From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add a workaround for GDS ordered append hangs
 with compute queues
Date: Mon, 4 Feb 2019 11:00:47 -0500
Message-ID: <CAAxE2A70p3_f+2AyXe7-m0nn2ZA7Zu57KLa9aPAAcH38Qa4EWw@mail.gmail.com>
References: <20190122200546.1575-1-maraeo@gmail.com>
 <CAAxE2A7xs40YZvCQpMmv9X0Z98Sc7+ZEbFJDJLfmkMuWHzuprw@mail.gmail.com>
 <1b1294f7-1604-fe49-de7f-0e234656eecd@gmail.com>
 <CAAxE2A4vsMRL0FZYBknCTMEbDBNYJZOdOnR32EZqM5iaKX6j3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1379064392=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4vsMRL0FZYBknCTMEbDBNYJZOdOnR32EZqM5iaKX6j3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1379064392==
Content-Type: multipart/alternative; boundary="000000000000bc389c0581139ac4"

--000000000000bc389c0581139ac4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, when I push this, I'll bump the DRM version.

Marek

On Mon, Feb 4, 2019 at 10:55 AM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:

> On Mon, Feb 4, 2019 at 7:42 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> At least from coding style, backward compatibility etc.. this looks sane
>> to me, so feel free to add an Acked-by.
>>
>> But I absolutely can't judge if that is correct from the hardware point
>> of view or not.
>>
>
> Our GDS docs say that writing the register resets the wave counter.
>
>
>>
>> And I think that somebody else looking at this is mandatory for it to be
>> committed.
>>
>
> There won't be anybody else. Nobody here really understands GDS, nobody
> here really cares about GDS, and hw guys weren't helpful with the hangs. =
If
> I didn't discover this by luck, GDS OA would be unusable on Linux.
>
> Marek
>

--000000000000bc389c0581139ac4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>FYI, when I push this, I&#39;ll bump the DRM version.=
</div><div><br></div><div>Marek<br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 4, 2019 at 10:55 AM Marek Ol=
=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, Feb 4, 2019 at 7:42 AM Christian K=C3=B6nig &lt;<a href=3D"mailto=
:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ckoenig.leichtzumerken=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <div class=3D"gmail-m_-4957765592598782426gmail-m_7001441194333530681mo=
z-cite-prefix">At least from coding style, backward
      compatibility etc.. this looks sane to me, so feel free to add an
      Acked-by.<br>
      <br>
      But I absolutely can&#39;t judge if that is correct from the hardware
      point of view or not.<br></div></div></blockquote><div><br></div><div=
>Our GDS docs say that writing the register resets the wave counter.<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
bgcolor=3D"#FFFFFF"><div class=3D"gmail-m_-4957765592598782426gmail-m_70014=
41194333530681moz-cite-prefix">
      <br>
      And I think that somebody else looking at this is mandatory for it
      to be committed.<br></div></div></blockquote><div><br></div><div>Ther=
e won&#39;t be anybody else. Nobody here really understands GDS, nobody her=
e really cares about GDS, and hw guys weren&#39;t helpful with the hangs. I=
f I didn&#39;t discover this by luck, GDS OA would be unusable on Linux.<br=
></div><div><br></div><div>Marek</div></div></div>
</blockquote></div></div>

--000000000000bc389c0581139ac4--

--===============1379064392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1379064392==--
