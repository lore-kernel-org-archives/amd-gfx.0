Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE68AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 18:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF0C10E9B9;
	Fri,  9 Aug 2024 18:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gfxstrand-net.20230601.gappssmtp.com header.i=@gfxstrand-net.20230601.gappssmtp.com header.b="p8dghGQH";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E323610E9B9
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 18:01:54 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-52efd855adbso2954337e87.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Aug 2024 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gfxstrand-net.20230601.gappssmtp.com; s=20230601; t=1723226513; x=1723831313;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OxgbznSlSfurLFq/JUiaKIbUyOrrGKcgv5s41kKdQTk=;
 b=p8dghGQHOB1CglWiSjm1QGfYQVIfUJVSA/PZpJERWBhMwkpuD5BE6kKq52v9mPRw/y
 1mz62PBhB9RDmmI7duxKz17LFJEyrf4Kg0a+zKGPaDnjKYRDeWxlwHXliRb+h0v7MsxD
 cdMRBRCAHtSxu24dsBnX1xPE007K5J+R1k+o2PPQQzfhllhQuOeXR1J+jNenaXcwDmIJ
 Zy6MCdGU9lz/2J+Qbz6MyteeRMHtBNED3YbgHbn1yusuhICrdRYELRmLlokvakKQ6wrL
 KVR8AHbu01h32GqHEgk5D7VT/SNewgxcLna2928I90XZGh6cqOeYpLULa/Vkv/1BCzb/
 /P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226513; x=1723831313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OxgbznSlSfurLFq/JUiaKIbUyOrrGKcgv5s41kKdQTk=;
 b=HueBaSpHUGPKBUvqcUDU+6rtFAKpgHBMhpuCf2o1RZdoba9DEWovlNEiy2BNs1H+oX
 nrvL0l3sVYuMdgWmyr1OQDJlBvPGizrp/yKIsmGMSzYbbnowzPZUH92wsJJ1cJ92sB2b
 2HWJoCvW3qjvL5CI9e5RhyBSMzW+UQ5I5AtOMu7lrN9h9dV1yfHC/+mZm1UGEpMrrB5Z
 nocmY3kvBVTBpn3LVlU1rXliqG4m8f6EfJUGfAdy0DnCc5fiT8nYRbhTNnzLXry4Lwmg
 5u+Wq5aDcMJSLdpaa0ANKmh/U2oheJLOFBO/GyHKbMREVrdlIgU96XYMb3l741npjC7m
 tEbA==
X-Gm-Message-State: AOJu0Yxii96/3UP1j5bFSmW/l/N2Nkm6PhlKypttBw+XPnjDfTMuIBPG
 a+AL+Ulcd3T+mVqs7I6AzjVQ2rCvarxWOr5mWCyskGBkXc3+D8J5dTA/4XycI+AZl1wiblWGRwu
 Sf5i3QOXQ/M964GqnPZwkdSK/UHkWsX+6ErEI3w==
X-Google-Smtp-Source: AGHT+IEOdeLe+eAhwmFchqiDEMHOUEKcXFYirH3pRnYyEUYBVjJPZfwXz5KRHDwjpUR1OYv3X/qh/eqt53KHRi/kTs4=
X-Received: by 2002:a05:6512:3e0c:b0:530:dab8:7dce with SMTP id
 2adb3069b0e04-530ee9747aamr1638747e87.19.1723226512250; Fri, 09 Aug 2024
 11:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
From: Faith Ekstrand <faith@gfxstrand.net>
Date: Fri, 9 Aug 2024 13:01:41 -0500
Message-ID: <CAOFGe96iG239kwSgOrqy=-5LeKQSkwSmvxo5Do2DzmJzCK7LEg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add submission flag to disable implicit sync.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, airlied@gmail.com,
 friedrich.vock@gmx.de, =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000217f19061f43f01a"
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

--000000000000217f19061f43f01a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't see anything wrong with it

Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>

However, I'm not an AMDGPU developer so you probably want someone who knows
the amdgpu sync stuff to review as well.

On Wed, Aug 7, 2024 at 8:09=E2=80=AFPM Bas Nieuwenhuizen <bas@basnieuwenhui=
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

If you want to throws in MRs, I'll review them as well. That can be a
"real" review.

Also, Michel is working on trying to reproduce the original Mesa issue so
we can verify the end result.

~Faith



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

--000000000000217f19061f43f01a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I don&#39;t see anything wrong with =
it</div><div><br></div><div>Reviewed-by: Faith Ekstrand &lt;<a href=3D"mail=
to:faith.ekstrand@collabora.com">faith.ekstrand@collabora.com</a>&gt;</div>=
<div><br></div><div>However, I&#39;m not an AMDGPU developer so you probabl=
y want someone who knows the amdgpu sync stuff to review as well.<br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Wed, Aug 7, 2024 at 8:09=E2=80=AFPM Bas Nieuwenhuizen &lt;<a href=3D"mai=
lto:bas@basnieuwenhuizen.nl">bas@basnieuwenhuizen.nl</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">For the rationale see t=
he earlier RFC by Faith: <a href=3D"https://lists.freedesktop.org/archives/=
amd-gfx/2024-August/112273.html" rel=3D"noreferrer" target=3D"_blank">https=
://lists.freedesktop.org/archives/amd-gfx/2024-August/112273.html</a><br>
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
.freedesktop.org/bnieuwenhuizen/mesa/-/commits/basic-explicit-sync</a><br><=
/blockquote><div><br></div><div>If you want to throws in MRs, I&#39;ll revi=
ew them as well. That can be a &quot;real&quot; review.</div><div><br></div=
><div>Also, Michel is working on trying to reproduce the original Mesa issu=
e so we can verify the end result.</div><div><br></div><div>~Faith</div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
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
</blockquote></div></div>

--000000000000217f19061f43f01a--
