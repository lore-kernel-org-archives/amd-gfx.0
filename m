Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3A6CA0EDB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 19:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF93310E62E;
	Tue, 12 Aug 2025 19:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1eypYJ8";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE6110E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 19:35:50 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso4588578fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755027349; x=1755632149; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+FoKBwNi6VSgi26IDvV2kEvn/F8y7YL3AiB2MzjqKLI=;
 b=V1eypYJ8RYQxQEFJL2S2+OUzLNW1kkOOvTuX3F8eGyJwjsQ5JvVfubEy3hRrG6pNe6
 FdS9HcI02D67imuFGTjkPcvWsXkTJfvWhD4mr0IsH4pLsbJBd3sHjce+6P6OJUVaf7b/
 ygkivWKQ2Awx0SYuxn7e7Mw6MDX3kLsb4KVdi7jy/u8eCGRCA9UiVV2LXvZrXx6cfQDx
 WNOhj0YLr+H5kcmCZZxMuUywP7KJEZyLXGKGjup4ko8vRJbBDLEf7h0qRjKsQzc6FqVW
 Lh+VldQYP/ZzoJEV2uq4OIgEHje5bmjdRXr61qklVvK18mB/LxeW4TbnrS/aU0kwoMHc
 2CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755027349; x=1755632149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+FoKBwNi6VSgi26IDvV2kEvn/F8y7YL3AiB2MzjqKLI=;
 b=shvYPbyCdw9S3zgh6FQE4h2a6tZucZml95/IThtekqtWmUHAXrdgowA64nDA4W8PhN
 DsKAsUeMkUiYyjVzGKkRGxCts1We5b2g1TFlML8UCaSf0AS936s9yGcUP8zW6xGLja8W
 ZWZZD++iNxv/2Mlm8wWdVb9/vUjUCRUUmmEgzFD+lBruTuqHMrBUGAVwoNIpOkUMSiAu
 Uu+E/oOYTW+xM35C2E9hYpMAjAokWTMy5+QdReSF6W5O9bCNN76SBX21GZWc4rwg2Li4
 xdurZcWub+FGV56lzxNAKnCcsMaMAVKklfPxrZBsNJipPlZiPpSXOLKmIInYM/bbh6Vi
 laPg==
X-Gm-Message-State: AOJu0YxRVpAWwwtdfl2DxPvxXKMa+0sE1oZ7nM5qZHU6uuRg4mrnMz2o
 NZcK7v9n1LZiPEBAEQrZH35tdZWexApwJtOrlb2Bi1a7Wj0tOQVNIL6sBVB9IPCrMjx0GvFZgyg
 NiRem2pH1T63SHUX+eHNrSxrLhZCjAYk=
X-Gm-Gg: ASbGnctGCXghw91oO5fehm9aps8+BqyKejFXITFlUmkG1PoLTNdWvuXXfBZ9weYBggm
 369zpCNzQ2rewVddUd1f6rgtHAYdvyjCCkokDZFETbKvQ4upoaPBS8aTHQvWYW9Jd+UDwTHgnA0
 F8xUYZR1D6bykph1YVofmLc5ky5VX6BN0bvxb6mCMr/cz1PooDTmVEaYPaDHgRdGjNjQnJLVBzp
 Uuuctid
X-Google-Smtp-Source: AGHT+IHslJjoZiPwAaMA0+edkziNSMyWKQjg8o5UB5lSWck1+ebn/y8RSp2qPLH/HC/U9MFFZbY7i2Fn9WzJDlqDlhk=
X-Received: by 2002:a05:6871:4192:b0:300:d9f4:dfb5 with SMTP id
 586e51a60fabf-30cb5bc3596mr322978fac.24.1755027349306; Tue, 12 Aug 2025
 12:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPEhTTH90Rz-UFVJCdsi=vP5BSuQxVB3W-Qe1yVKH93txBLFsA@mail.gmail.com>
 <CADnq5_PuR5V2DzSow2EibdykmqwyOAd7q2K51uawumbo1naTGQ@mail.gmail.com>
In-Reply-To: <CADnq5_PuR5V2DzSow2EibdykmqwyOAd7q2K51uawumbo1naTGQ@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Tue, 12 Aug 2025 15:35:39 -0400
X-Gm-Features: Ac12FXzjh79U7MKJ8nsfdjGgdYL394IrXCKmQf-kLZh14P2k-7ZHU7ZwIHHCVQQ
Message-ID: <CAPEhTTFH3abJMkQ5ojqXyxQjGBU7Br=MQipKmT0uMdsi2AQSsg@mail.gmail.com>
Subject: Re: AMDGPU's rings VS Radeon's
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="000000000000ba0016063c302590"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000ba0016063c302590
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:22=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:

> On Mon, Aug 11, 2025 at 6:08=E2=80=AFPM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > Hi,
> >
> > For those who know, I'm still working on VCE1 enablement under AMDGPU.
> Progress is happening, slowly but surely. While investigating the ring in=
it
> calls, a few elements catched my attention and I'd like some help in
> figuring out the differences between AMDGPU's ring sizes and Radeon's one=
s.
> >
> > 1- I understand that the size parameter changed from bytes under
> radeon_ring_init to dword under amdgpu_ring_init. That being said, some
> values don't seem to be equivalent between Radeon and AMDGPU. For example=
,
> GFX ring size went from 1024 * 1024 bytes to 1024 dwords (for most GFX
> versions), which seems off even when taking into account how
> amdgpu_ring_init calculates the final allocated size. This question is mo=
re
> about understanding than a problem strictly speaking.
>
> You can make the ring any size you want.  It's specified in the queue
> descriptor.  I don't remember why we picked the sizes we did in radeon
> off hand.
>
> OK, thanks

> >
> > 2- Under AMDGPU, SI's GFX (GFX6) ring size is 2048, while this value is
> 1024 for all the other GFX versions. Under Radeon, the GFX ring size valu=
es
> are all the same (1024 * 1024) under Evergreen/SI/CIK/NI and others. Is
> there any reason why SI's GFX6 ring size would be twice the size of the
> other values under AMDGPU?
> >
>
> From the git history:
> commit 97041ed37718dc9ba30aa23ca74093dc93ac89fb
> Author: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Date:   Thu Apr 13 16:22:51 2023 +0200
>
>     drm/amdgpu: Increase GFX6 graphics ring size.
>
>     To ensure it supports 192 IBs per submission, so we can keep a
>     simplified IB limit in the follow up patch without having to
>     look at IP or GPU version.
>
>     Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>     Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>
>
> > 3- Would it be acceptable to add names to rings under Radeon, the same
> names as the ones used under AMDGPU? I think it is more talkative for the
> average user and for debugging purposes to deal with ring names than
> indexes. I already have patches in my code to address this suggestion.
> >
>
> If you think there is value there.  It seems like it would generate a
> lot of churn in that driver for little gain.
>
> Alex
>
> The patches are pretty simple and straightforward. I'll send them.

Cheers!

Alexandre Demers

> That's all for now.
> >
> > Cheers
> > Alexandre Demers
>

--000000000000ba0016063c302590
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 11,=
 2025 at 6:22=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gma=
il.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Mon, Aug 11, 2025 at 6:08=E2=80=AFPM Alexan=
dre Demers<br>
&lt;<a href=3D"mailto:alexandre.f.demers@gmail.com" target=3D"_blank">alexa=
ndre.f.demers@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; For those who know, I&#39;m still working on VCE1 enablement under AMD=
GPU. Progress is happening, slowly but surely. While investigating the ring=
 init calls, a few elements catched my attention and I&#39;d like some help=
 in figuring out the differences between AMDGPU&#39;s ring sizes and Radeon=
&#39;s ones.<br>
&gt;<br>
&gt; 1- I understand that the size parameter changed from bytes under radeo=
n_ring_init to dword under amdgpu_ring_init. That being said, some values d=
on&#39;t seem to be equivalent between Radeon and AMDGPU. For example, GFX =
ring size went from 1024 * 1024 bytes to 1024 dwords (for most GFX versions=
), which seems off even when taking into account how amdgpu_ring_init calcu=
lates the final allocated size. This question is more about understanding t=
han a problem strictly speaking.<br>
<br>
You can make the ring any size you want.=C2=A0 It&#39;s specified in the qu=
eue<br>
descriptor.=C2=A0 I don&#39;t remember why we picked the sizes we did in ra=
deon<br>
off hand.<br>
<br></blockquote><div>OK, thanks=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt;<br>
&gt; 2- Under AMDGPU, SI&#39;s GFX (GFX6) ring size is 2048, while this val=
ue is 1024 for all the other GFX versions. Under Radeon, the GFX ring size =
values are all the same (1024 * 1024) under Evergreen/SI/CIK/NI and others.=
 Is there any reason why SI&#39;s GFX6 ring size would be twice the size of=
 the other values under AMDGPU?<br>
&gt;<br>
<br>
From the git history:<br>
commit 97041ed37718dc9ba30aa23ca74093dc93ac89fb<br>
Author: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen.nl" ta=
rget=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;<br>
Date:=C2=A0 =C2=A0Thu Apr 13 16:22:51 2023 +0200<br>
<br>
=C2=A0 =C2=A0 drm/amdgpu: Increase GFX6 graphics ring size.<br>
<br>
=C2=A0 =C2=A0 To ensure it supports 192 IBs per submission, so we can keep =
a<br>
=C2=A0 =C2=A0 simplified IB limit in the follow up patch without having to<=
br>
=C2=A0 =C2=A0 look at IP or GPU version.<br>
<br>
=C2=A0 =C2=A0 Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:chris=
tian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@ba=
snieuwenhuizen.nl" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.d=
eucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
<br>
<br>
<br>
&gt; 3- Would it be acceptable to add names to rings under Radeon, the same=
 names as the ones used under AMDGPU? I think it is more talkative for the =
average user and for debugging purposes to deal with ring names than indexe=
s. I already have patches in my code to address this suggestion.<br>
&gt;<br>
<br>
If you think there is value there.=C2=A0 It seems like it would generate a<=
br>
lot of churn in that driver for little gain.<br>
<br>
Alex<br>
<br></blockquote><div>The patches are pretty simple and straightforward. I&=
#39;ll send them.</div><div><br></div><div>Cheers!</div><div><br></div><div=
>Alexandre Demers</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt; That&#39;s all for now.<br>
&gt;<br>
&gt; Cheers<br>
&gt; Alexandre Demers<br>
</blockquote></div></div>

--000000000000ba0016063c302590--
