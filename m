Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFFAC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 14:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8964A10E4FD;
	Tue, 31 Oct 2023 14:20:32 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD3A10E4FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 14:20:29 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-778910b1195so19189985a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1698762028; x=1699366828;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T9X/uqUM5RsuOlD/HJQ664kyZQY3t9rA5z+IaFb0H0k=;
 b=UpEdQcfFcQ44apNuj10v6vQyS+PhN4AM/hxbJUeX6WyUiqtxEvESefhaGwar40aHzL
 TuVSovnD3Gzue/9sgtyLxtnq5uB/p8peaypdwqSiF/WzT7VKTjvQ+KpW571e8o4c0I7n
 r82b5HFCKoBAwMn6y+/Q9g3JBDvgmRRe/Sbrt5R4yMwPW1Tm5keVN1SWoVGyVeXzviqd
 9dSsCTLLVgdmv2qvbKN9SS79hxratzhPVe69Cfzucf0BcgHoRktkRWFIVX6aefh/zxlx
 oZY6j4v9y0vo359fr2Ik7lAS6tDpx+rc6EFq9pj5a9381OPb+54limf66RaMzVw5jIT9
 TJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762028; x=1699366828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9X/uqUM5RsuOlD/HJQ664kyZQY3t9rA5z+IaFb0H0k=;
 b=UlHY1TDD6RZo8nCkI9NBl/B7WXHMiQa1xvNJ7TpLRYda6DLRcyUAaQrpnYMGCgHIjD
 t3ki7I4GQ8uV81BQLFMDw85YXo351iR7VMvvZx1BM8VnRiriTF8uZUKT4aqAcu+EZZyp
 /C3vVrdIXI1/1lWZf475R3dahyYABAaGTmCaHlgqGZu9BYd4I5amGI9N60hPt+QUew2z
 mQsFcF/oAMZPqal9Odxwd6zkDMYMgCyjbewcVrKFWJru37p+7ffHVzk/bOZZOF9khpZB
 y8xz0F6o6sBIBlnU4sb5bNBprjyXPCHCTSml29wM2cAyVrj+xqehHE+Q3HNnHxCDMNxU
 ewog==
X-Gm-Message-State: AOJu0YyLzIv2uck/1ppH89VXTaI1iiaVh8Dzvd7qq8+vU5v4Re1uKrKz
 qGOS8vDf6DTCeV+EJYx8ZWJaKtKrz8PvXljgkhijzA==
X-Google-Smtp-Source: AGHT+IFa+WjGrvvRJq0y/E6u2ye9nhllNVHJ5X+zirguXI+nSH8lYe+MjITk8S8NmxjL4y82ma3xz78D7ZjRIAsVXI4=
X-Received: by 2002:a05:6214:3ca0:b0:66d:4c92:1609 with SMTP id
 ok32-20020a0562143ca000b0066d4c921609mr13159273qvb.5.1698762028453; Tue, 31
 Oct 2023 07:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231031134059.171277-1-ishitatsuyuki@gmail.com>
 <20231031134059.171277-6-ishitatsuyuki@gmail.com>
 <454e7d7f-8a23-58bd-8822-55c13beba97f@mailbox.org>
In-Reply-To: <454e7d7f-8a23-58bd-8822-55c13beba97f@mailbox.org>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Tue, 31 Oct 2023 15:20:17 +0100
Message-ID: <CAP+8YyH_Q7FAs-7s7HsocQqgdqFM84CmAcwaiObyKKo5Gh-GqA@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/amdgpu: Add flag to disable implicit sync for GEM
 operations.
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Type: multipart/alternative; boundary="00000000000043a8b7060903db49"
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
Cc: daniel@ffwll.ch, Tatsuyuki Ishi <ishitatsuyuki@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000043a8b7060903db49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 3:14=E2=80=AFPM Michel D=C3=A4nzer <michel.daenzer@=
mailbox.org>
wrote:

> On 10/31/23 14:40, Tatsuyuki Ishi wrote:
> > In Vulkan, it is the application's responsibility to perform adequate
> > synchronization before a sparse unmap, replace or BO destroy operation.
> > Until now, the kernel applied the same rule as implicitly-synchronized
> > APIs like OpenGL, which with per-VM BOs made page table updates stall t=
he
> > queue completely. The newly added AMDGPU_VM_EXPLICIT_SYNC flag allows
> > drivers to opt-out of this behavior, while still ensuring adequate
> implicit
> > sync happens for kernel-initiated updates (e.g. BO moves).
> >
> > We record whether to use implicit sync or not for each freed mapping. T=
o
> > avoid increasing the mapping struct's size, this is union-ized with the
> > interval tree field which is unused after the unmap.
> >
> > The reason this is done with a GEM ioctl flag, instead of being a VM /
> > context global setting, is that the current libdrm implementation share=
s
> > the DRM handle even between different kind of drivers (radeonsi vs radv=
).
>
> Different drivers always use separate contexts though, even with the same
> DRM file description, don't they?
>
> FWIW, RADV will also want explicit sync in the CS ioctl.
>
> I think a crucial problem is that VA ioctls don't take a context so a
per-context flag doesn't solve this (the previous attempt used it because
all the sync changes were on the CS submit side and not the VA ioctl side)
. So I'd still like to solve that side for RADV, but I think the VA ioctl
flag makes sense here if we need to do anything different VA ioctl wise.


> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
>
>

--00000000000043a8b7060903db49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 31, 2023 at 3:14=E2=80=AF=
PM Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel.daenzer@mailbox.org">mic=
hel.daenzer@mailbox.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 10/31/23 14:40, Tatsuyuki Ishi wrote:<br>
&gt; In Vulkan, it is the application&#39;s responsibility to perform adequ=
ate<br>
&gt; synchronization before a sparse unmap, replace or BO destroy operation=
.<br>
&gt; Until now, the kernel applied the same rule as implicitly-synchronized=
<br>
&gt; APIs like OpenGL, which with per-VM BOs made page table updates stall =
the<br>
&gt; queue completely. The newly added AMDGPU_VM_EXPLICIT_SYNC flag allows<=
br>
&gt; drivers to opt-out of this behavior, while still ensuring adequate imp=
licit<br>
&gt; sync happens for kernel-initiated updates (e.g. BO moves).<br>
&gt; <br>
&gt; We record whether to use implicit sync or not for each freed mapping. =
To<br>
&gt; avoid increasing the mapping struct&#39;s size, this is union-ized wit=
h the<br>
&gt; interval tree field which is unused after the unmap.<br>
&gt; <br>
&gt; The reason this is done with a GEM ioctl flag, instead of being a VM /=
<br>
&gt; context global setting, is that the current libdrm implementation shar=
es<br>
&gt; the DRM handle even between different kind of drivers (radeonsi vs rad=
v).<br>
<br>
Different drivers always use separate contexts though, even with the same D=
RM file description, don&#39;t they?<br>
<br>
FWIW, RADV will also want explicit sync in the CS ioctl.<br>
<br></blockquote><div>I think a crucial problem is that VA ioctls don&#39;t=
 take a context so a per-context flag doesn&#39;t solve this (the previous =
attempt used it because all the sync changes were on the CS submit side and=
 not the VA ioctl side) . So I&#39;d still like to solve that side for RADV=
, but I think the VA ioctl flag makes sense here if we need to do anything =
different VA ioctl wise.</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http=
s://redhat.com" rel=3D"noreferrer" target=3D"_blank">https://redhat.com</a>=
<br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Mesa and Xwayland developer<br>
<br>
</blockquote></div></div>

--00000000000043a8b7060903db49--
