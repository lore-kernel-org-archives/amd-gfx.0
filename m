Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03169C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 19:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9178B10EB01;
	Fri,  8 Dec 2023 19:33:45 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46E510EB01
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 19:33:43 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d9e9f3a3abso665054a34.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Dec 2023 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702064023; x=1702668823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yO9UfXZ6mrjiI1zwzPN+H6NzGSQqsGMopocf5HPCIEI=;
 b=QTAbx5GWUaxr5N9tv+yIG7TFkFSMGJ4/nSK2hCgJMZ4un1fpxOogsb6buq90Upp3Fc
 etcuGsoZWWQGHlRmFvAFRJAQ9GXqlfiUvNFUlYl9wpcp5GWdIKMyitGBQgQsBioxnuoM
 1TI2XzG2pZGChQAaTTI0yxkaHzdQyu9jICWq6GaoEJfv84wtM8WVpgahj/6QSyWGVzlv
 HAqnP5xrnAvQp/zWHfuryUHcftM7i/LOALa6Ss20/UnXvkXDvDzUhGEowm4kdZv0DSlJ
 OiK8JBTrd2/CzgrZLLh58O11an4BeR+bN8MsDUHLRmeqFOfSZLHVXtxIBhjT/kN/gNsw
 6Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702064023; x=1702668823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yO9UfXZ6mrjiI1zwzPN+H6NzGSQqsGMopocf5HPCIEI=;
 b=e6Y1qtpTVbtfLs/DVl0kZ1bN7A7eFOZqNMhX9ICz5PXnCAkV0bZiATSqDnkkje0c17
 2cGWYWsFLPClTy2hHWjBfyueFhCoikvfsmOf9iWqYLV4orhUNUIZhlcgptfUl3R6MzzC
 4VKfMSHAwp356Q60iKD0B/nHQK92ZChcVsb5KVqIwAGAxQTYwI/ojDw98Sn8OLpIWi5c
 rkMbPRN44Dd0wW1nF/RX1MhmfM/LbRvfq7RaeUXyXKkuZsUoY0Vx+oSvXqf3x9Yuf6s7
 cfWR6gKr7nF3xx3YjyCWMst8t88D8awxXm+kcYcUrOEOLqWfJpHM0ErUcSG1gN6Zlvbb
 Z2EQ==
X-Gm-Message-State: AOJu0YzCxQZhtOXPoXDXW42BEdKvYtsPgJYl/F5u9p5EAu61iuIYELyq
 8/iEm00S1P42DWzxofhap9QchN/ab8PsJjFX5aI=
X-Google-Smtp-Source: AGHT+IEHybLnpb6vB8azlId+2NNhy5Fd/DcEObu2rL9+7RNXfwQfIXovrxu7gA4BFHeCge6+10q0xqRVlcDTIKia6hE=
X-Received: by 2002:a05:6870:b625:b0:1fb:75b:2fdb with SMTP id
 cm37-20020a056870b62500b001fb075b2fdbmr662694oab.114.1702064022832; Fri, 08
 Dec 2023 11:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20231127223234.891204-1-alexander.deucher@amd.com>
 <CADnq5_OpHe527RoVPzgyj_TOw+RT=dZnfmfB7TGWD=8Zzt10cQ@mail.gmail.com>
 <84229452-a063-46d2-bc04-46c38b2911ff@gmail.com>
In-Reply-To: <84229452-a063-46d2-bc04-46c38b2911ff@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Dec 2023 14:33:31 -0500
Message-ID: <CADnq5_MpACqkTkrhNHwqyWF9=mydxbg3q0RAhTcwKtajuqZ6ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/debugfs: fix error code when smc register
 accessors are NULL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 8, 2023 at 8:24=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The second patch never made it into my inbox, but the first one is
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.

Thanks.  Patch 2:
https://patchwork.freedesktop.org/patch/569132/

Alex

>
> Christian.
>
> Am 07.12.23 um 18:39 schrieb Alex Deucher:
> > Ping on this series?
> >
> > Alex
> >
> > On Mon, Nov 27, 2023 at 5:52=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com> wrote:
> >> Should be -EOPNOTSUPP.
> >>
> >> Fixes: 5104fdf50d32 ("drm/amdgpu: Fix a null pointer access when the s=
mc_rreg pointer is NULL")
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_debugfs.c
> >> index 0e61ebdb3f3e..8d4a3ff65c18 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >> @@ -755,7 +755,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct=
 file *f, char __user *buf,
> >>          int r;
> >>
> >>          if (!adev->smc_rreg)
> >> -               return -EPERM;
> >> +               return -EOPNOTSUPP;
> >>
> >>          if (size & 0x3 || *pos & 0x3)
> >>                  return -EINVAL;
> >> @@ -814,7 +814,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struc=
t file *f, const char __user *
> >>          int r;
> >>
> >>          if (!adev->smc_wreg)
> >> -               return -EPERM;
> >> +               return -EOPNOTSUPP;
> >>
> >>          if (size & 0x3 || *pos & 0x3)
> >>                  return -EINVAL;
> >> --
> >> 2.42.0
> >>
>
