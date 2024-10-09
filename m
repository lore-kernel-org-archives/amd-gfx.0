Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55F3CEDD9E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 14:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96CE110E736;
	Wed,  9 Oct 2024 14:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="iwtmVWIN";
	dkim-atps=neutral
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE2610E736
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 14:17:13 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7afc5925679so120025385a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Oct 2024 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1728483432; x=1729088232;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RJr+5TpDhrQh88yuCsb10jmNLHrsBNhZozh/kZlvGU4=;
 b=iwtmVWINpUWR3qvX53bonmgQ5URB+pud4fAekMb5duYuDgGH9pZ1sxVtwF1bEd7EJ8
 j459l0SHtWXSzXS15V98HobgcSzSpg6fl+FDp+wX1XwSIcHqrcqjEieW5DooVgJXxh59
 ZhcuWHwYnMMPzaPRzcYuiFZxUbHdXTZFCMFVWMzQHWxxO5jTiNf7YT34aezb46dm5rqN
 b+B2vZsbUQE9Vx49gYIPtn7bS19oEVbA8gp9SQTJ9xV4jRTGvfhuoytUP50OrTUqHSwT
 8gSTnsff8IBlL4IjDCXBOmZuuvUaEon7A2Q8BT5JovxKd0ztjBtGuwYRHd4uald93p5g
 NCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728483432; x=1729088232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RJr+5TpDhrQh88yuCsb10jmNLHrsBNhZozh/kZlvGU4=;
 b=I/lMw1XNrlwFKWlXMyt7SDXt/su63cRho2ftoVKMY/D0AFHkIuW0bTZoIJ+csL8qj1
 pOh/hSssfs1+0Ql1jVAYHNk/KUMXGkS9xq06ClTS0F/ZkgR4ipMyXAvL/JTLvvDzcwk8
 ZZZgfkRgms+Rv79rk+x3bbQP2sKEe2qZNRx4H0IJxukYp8gXPJv/FH/yApYGIoPeeusq
 A3xwuyPiODszGjMRGt2i6gR8YxM03VcuDaBhzNjEyR4U4bLMl/05S3Viy8mVG+CnKwU/
 O18uvutwE6M9QaT+rY8qkCuuJ5R+dcpYLbLq69+kDe/Zw/+/gUFBJMbUZZzPuMdZKzPX
 v/dQ==
X-Gm-Message-State: AOJu0YwZOQeVpto0jxV5/tazDBZPkRd7htRUFtbWxL4pHEeJK8i/eRIo
 zrrTolauSKSXF+JTGRNU6eKVp6dUT7cvjiRLGgF/7tGtgvyzQrrL19B4KYqBFz8bTPbXww5f88D
 sZMjkYCdHRzd4/BT9M8CtAal2DSjpFFUSNJmk6JLowfwn+6yYUn8=
X-Google-Smtp-Source: AGHT+IFgE0npvgByBmUtWxJM4rsxByM074ICkfni12xJlxvkgy2j1aYEkmQ2nAIHLaxO5zeJ9Sl6pNnZ3ILZYYCiIOM=
X-Received: by 2002:a05:620a:c45:b0:7af:ce6e:1663 with SMTP id
 af79cd13be357-7b0874d223amr379261785a.60.1728483431741; Wed, 09 Oct 2024
 07:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 9 Oct 2024 16:17:00 +0200
Message-ID: <CAP+8YyGODBJO3hDKo8H9KwpdwR=O+ROOpxqrs8ureyvOVm7YoQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add submission flag to disable implicit sync.
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@gmail.com, faith@gfxstrand.net, 
 friedrich.vock@gmx.de
Content-Type: multipart/alternative; boundary="000000000000f3294606240be89a"
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

--000000000000f3294606240be89a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping on reviewing this series from the AMD side. Thanks!

On Thu, Aug 8, 2024 at 3:09=E2=80=AFAM Bas Nieuwenhuizen <bas@basnieuwenhui=
zen.nl>
wrote:

> For the rationale see the earlier RFC by Faith:
> https://lists.freedesktop.org/archives/amd-gfx/2024-August/112273.html
>
> This mainly makes two changes:
>
> 1. Uses a submission flag rather than a context creation flag.
> 2. Uses DMA_RESV_USAGE_BOOKKEEP to avoid adding implicit fences still.
>
> Note that this doesn't disable implicit sync wrt VM ops (map/unmap), I
> know we have series for that going around,
> but I believe doing just submissions here is less involved and doesn't
> really complicate doing VM ops later.
>
> As of now this has received a limited set of testing, no full CTS runs et=
c
> yet.
>
> For Userspace see:
>
> libdrm:
> https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/commits/basic-explici=
t-sync
>
> mesa:
> https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/basic-explic=
it-sync
>
> (Still missing a bunch of the version bumps & version checks, would like
> to postpone that till we know the actual version)
>
> Bas Nieuwenhuizen (6):
>   amdgpu: Add usage argument to amdgpu_sync_resv.
>   amdgpu: Ignore BOOKKEEP fences for submissions.
>   drm/amdgpu: Check cs flags.
>   drm/amdgpu: Add UAPI for disabling implicit sync per submission.
>   drm/amdgpu: Implement disabling implicit sync per submission.
>   drm/amdgpu: Bump the driver version for the new flag.
>
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 21 ++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |  7 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  3 ++-
>  include/uapi/drm/amdgpu_drm.h                 |  6 ++++++
>  9 files changed, 37 insertions(+), 12 deletions(-)
>
> --
> 2.45.2
>
>

--000000000000f3294606240be89a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Friendly ping on reviewing this series from the AMD side. =
Thanks!<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Thu, Aug 8, 2024 at 3:09=E2=80=AFAM Bas Nieuwenhuizen &lt;<a =
href=3D"mailto:bas@basnieuwenhuizen.nl">bas@basnieuwenhuizen.nl</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">For the rati=
onale see the earlier RFC by Faith: <a href=3D"https://lists.freedesktop.or=
g/archives/amd-gfx/2024-August/112273.html" rel=3D"noreferrer" target=3D"_b=
lank">https://lists.freedesktop.org/archives/amd-gfx/2024-August/112273.htm=
l</a><br>
<br>
This mainly makes two changes:<br>
<br>
1. Uses a submission flag rather than a context creation flag.<br>
2. Uses DMA_RESV_USAGE_BOOKKEEP to avoid adding implicit fences still.<br>
<br>
Note that this doesn&#39;t disable implicit sync wrt VM ops (map/unmap), I =
know we have series for that going around,<br>
but I believe doing just submissions here is less involved and doesn&#39;t =
really complicate doing VM ops later.<br>
<br>
As of now this has received a limited set of testing, no full CTS runs etc =
yet.<br>
<br>
For Userspace see:<br>
<br>
libdrm: <a href=3D"https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/comm=
its/basic-explicit-sync" rel=3D"noreferrer" target=3D"_blank">https://gitla=
b.freedesktop.org/bnieuwenhuizen/drm/-/commits/basic-explicit-sync</a><br>
<br>
mesa: <a href=3D"https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commi=
ts/basic-explicit-sync" rel=3D"noreferrer" target=3D"_blank">https://gitlab=
.freedesktop.org/bnieuwenhuizen/mesa/-/commits/basic-explicit-sync</a><br>
<br>
(Still missing a bunch of the version bumps &amp; version checks, would lik=
e to postpone that till we know the actual version)<br>
<br>
Bas Nieuwenhuizen (6):<br>
=C2=A0 amdgpu: Add usage argument to amdgpu_sync_resv.<br>
=C2=A0 amdgpu: Ignore BOOKKEEP fences for submissions.<br>
=C2=A0 drm/amdgpu: Check cs flags.<br>
=C2=A0 drm/amdgpu: Add UAPI for disabling implicit sync per submission.<br>
=C2=A0 drm/amdgpu: Implement disabling implicit sync per submission.<br>
=C2=A0 drm/amdgpu: Bump the driver version for the new flag.<br>
<br>
=C2=A0.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c=C2=A0 |=C2=A0 1 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2=
1 ++++++++++++++++---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 3 ++-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_object.c=C2=A0 =C2=A0 |=C2=A0 3 ++-=
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
7 +++----<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
4 ++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c=C2=A0 =C2=A0|=C2=A0 3 ++-=
<br>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++++<br>
=C2=A09 files changed, 37 insertions(+), 12 deletions(-)<br>
<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div>

--000000000000f3294606240be89a--
