From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: enable LEDs on Fiji boards
Date: Fri, 24 Feb 2017 11:51:27 +1100
Message-ID: <be2c283c-9631-03f3-4eac-9fb040df88c6@folklore1984.net>
References: <CAPEhTTFFTS-K-FnhvB0ma7FJymfN2EYRw3U-U_-7y8y3L6RS_A@mail.gmail.com>
 <CADnq5_Np1DWnzvSaChca4rsQzX02_=HYcLTwuFVaLm51qageRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0459571847=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Np1DWnzvSaChca4rsQzX02_=HYcLTwuFVaLm51qageRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0459571847==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LtbeRitfaRoXXn4IlTm4cdH2Khf5CeVrK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LtbeRitfaRoXXn4IlTm4cdH2Khf5CeVrK
Content-Type: multipart/mixed; boundary="hAAa92LCQKL7RSjU6epSjKf3aAsW8pipO";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <be2c283c-9631-03f3-4eac-9fb040df88c6-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: enable LEDs on Fiji boards
References: <CAPEhTTFFTS-K-FnhvB0ma7FJymfN2EYRw3U-U_-7y8y3L6RS_A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <CADnq5_Np1DWnzvSaChca4rsQzX02_=HYcLTwuFVaLm51qageRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CADnq5_Np1DWnzvSaChca4rsQzX02_=HYcLTwuFVaLm51qageRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--hAAa92LCQKL7RSjU6epSjKf3aAsW8pipO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi guys,

Shouldn't this hook into the "led framework" of the kernel?

https://www.kernel.org/doc/Documentation/leds/leds-class.txt

Kind Regards,
Edward.

On 02/24/2017 10:03 AM, Alex Deucher wrote:
> On Thu, Feb 23, 2017 at 5:50 PM, Alexandre Demers
> <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> First, sorry for not replying directly as I should normally, but I'm n=
ot on
>> my usual computer, so I can't. That being said...
>>
>> I may have my eyes in the same socket right now, but I think
>> fiji_setup_dpm_led_config() always returns 0.
>>
>>> + if (mask)
>>> + smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
>>> +    PPSMC_MSG_LedConfig,
>>> +    mask);
>>> + return 0;
>>> +}
>>
>> Even when "if (mask)" is true, whether smum_send_msg_to_smc_with_param=
eter()
>> succeeds or not, fiji_setup_dpm_led_config() spits a 0 at the end.
>>
>> Thus,
>>
>>> + result =3D fiji_setup_dpm_led_config(hwmgr);
>>> + PP_ASSERT_WITH_CODE(0 =3D=3D result,
>>> +    "Failed to setup dpm led config", return result);
>>
>> will always lead to "result" being set to 0... Am I missing something?=

>>
>=20
> Yes, that function can't fail.  I suppose we could just make it a void
> function, but I was following the same pattern of all the other
> functions in that file.
>=20
> Alex
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--hAAa92LCQKL7RSjU6epSjKf3aAsW8pipO--

--LtbeRitfaRoXXn4IlTm4cdH2Khf5CeVrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr4OPAAoJEP4bvbfZuWjbg6wQALqBtfklDu3gqaLG+5ZpEwUj
Js7y0hqCFhzWwP5jjg3InMRh8VXEc741FY5fm+zoHuV2pWr3lNzr0WZmN6ik6cax
yYIu+XeQOOHnKxZF1w5YH2FrRXXKmO8a6jLiYgi90JBQqTGNht/gyKJ3fgP9In/h
ED5XoL06r3cmtW0dC3LScSbjOtBW0vsYSLQUncAPmcD6xX6VBynfgYXPPsmqETde
s70IMKkeyyjFejbCM4ilSOy3+1p9VK2rQREeXZZmava82hnGTVPDDic+J7v2RS0E
NMtQLnbpqu3ggFPJSEI0mjCvsZkkZEiynQpwmRIOLcwkHhgdMYdNEKyn2eSOtwYz
Aj02WEyHGbG5LJk/Dc7UwvMSkS37hpvyQNuNYEALy9cZh7DLp1Rs7ha6of4iG1tt
l/F1E40rqmAiE+Hqq/RPnBlCpUhiuKwv+LqgxQFhv1pSgHsXa8qeIe6VPCUm7QWI
4Exm9AGO2uXlscUfWnvdo6TNyGadS7mKBy/5vvXtX4fgEdWPyfWueBORr/Bvhmqf
4ycZH2NtbJH9zO5jOzGFKX/I7XY/YN1O5igexfJyBwwtLmChTfy1CANJYE+WTJBW
o2TQ9SHaDMhGhwVH5U06DmutNJ/sJvno4s51CdjSCFotfy7KZ6XfRaxAJBOB/uuN
O3WnhoKnTRVJDjVMdr2i
=D8yF
-----END PGP SIGNATURE-----

--LtbeRitfaRoXXn4IlTm4cdH2Khf5CeVrK--

--===============0459571847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0459571847==--
