package mclass.store.tripant.member.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import mclass.store.tripant.member.domain.CustomOAuth2User;
import mclass.store.tripant.member.domain.MemberEntity;
import mclass.store.tripant.member.domain.MemberRole;
import mclass.store.tripant.member.model.repository.MemberRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class OAuth2MemberService extends DefaultOAuth2UserService {
	
	private final MemberRepository memberRepository;
	
	@Override
		public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
			System.out.println("loadUser===========");
			OAuth2User oAuth2User = super.loadUser(userRequest);
			String email = oAuth2User.getAttribute("email");
			Optional<MemberEntity> memberEntityOp = Optional.ofNullable(memberRepository.login(email));
			if(memberEntityOp.isEmpty()) {
				throw new UsernameNotFoundException("가입해");
			}
			MemberEntity memberEntity = memberEntityOp.get();
			List<GrantedAuthority> authorities = new ArrayList<>();
			switch(memberEntity.getMemRole()) {
				case "ROLE_OWNER": authorities.add(new SimpleGrantedAuthority(MemberRole.OWNER.getRole()));
				case "ROLE_ADMIN": authorities.add(new SimpleGrantedAuthority(MemberRole.ADMIN.getRole()));
				case "ROLE_VIP": authorities.add(new SimpleGrantedAuthority(MemberRole.VIP.getRole()));
				case "ROLE_MEM": authorities.add(new SimpleGrantedAuthority(MemberRole.MEM.getRole()));
			}
			System.out.println("oAuth2User = "+oAuth2User);
			return new CustomOAuth2User(email, memberEntity.getMemPassword(), authorities);
		}
}
