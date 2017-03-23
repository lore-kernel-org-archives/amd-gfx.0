From: Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Thu, 23 Mar 2017 09:46:48 -0700
Message-ID: <CAOfP2NB5Z4pTKb=142Cx+j+PfSpfch7ffcvtUqdvJLfk7+tm8Q@mail.gmail.com>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
 <d476dcba-048d-ad4b-b080-49e31e6fb25b@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1505728656=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d476dcba-048d-ad4b-b080-49e31e6fb25b-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>

--===============1505728656==
Content-Type: multipart/alternative; boundary=94eb2c06404e842ca6054b689fc0

--94eb2c06404e842ca6054b689fc0
Content-Type: text/plain; charset=UTF-8

>
> No, I've requested reverting the patch for now because it causes an
> obviously and rather severe problem. If you guys can quickly find how to
> fix it feel free to use that instead.
>
> My mistake! That makes sense. Thanks again.

--94eb2c06404e842ca6054b689fc0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><div text=3D"#000000" bgcolor=3D"#FFFFFF"><div c=
lass=3D"m_9153420107263341636moz-cite-prefix">No, I&#39;ve requested revert=
ing the patch for now because it causes
      an obviously and rather severe problem. If you guys can quickly
      find how to fix it feel free to use that instead.<span class=3D""><br=
><blockquote type=3D"cite"><div></div></blockquote></span></div></div></blo=
ckquote><div>My mistake! That makes sense. Thanks again.</div></div></div><=
/div>

--94eb2c06404e842ca6054b689fc0--

--===============1505728656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1505728656==--
