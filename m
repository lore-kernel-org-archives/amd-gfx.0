Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE97D2B92F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5419A10E5B1;
	Tue,  5 Nov 2024 14:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sxbveb3H";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BF510E5B1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:08:34 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2e31977c653so510531a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2024 06:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730815714; x=1731420514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4SnN0m5h5L80hQ18TAeFxdrtnHgC7iH9TaWtrk4tBFM=;
 b=Sxbveb3HBBSYTQFMonJ5JT8Q0WylZkwqQqO185khkWQVefno+FfxrhtkIABIt0j4G0
 YwM+kadOb40IjQP1LrAECnhvIwFGMOe4bFH1vmkIb0sUZ/GWQUMCt46x/XdJg/aJWRKh
 jIBGSr7thp22ptZmNBtITkr/Wy0d3A2k/E9souratwv7/hZpPTcvaQu2Uu3PFRV5gpKk
 cdvxwc0PgyRsavVEfY/SlwgD5cP+UR/z8AbvVauK7wXzw01mb9dL9rBxV17HXvPH6Y4C
 1TuDloLKUXU+QTw0bKFk+TEZVFqhItSUyZkgdLH9GTMGGir/F/TUKQqN2QejFN6QMH7V
 woVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730815714; x=1731420514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SnN0m5h5L80hQ18TAeFxdrtnHgC7iH9TaWtrk4tBFM=;
 b=NQrJuQ+3JTScRLanb1kBEqhRRKwSwvrxj3c9uNE4/DN/z30lwEdCiaxGxFUlhKgJ5O
 +xeh4eF9YvjjPBJqs7lTEwsg3AaOHWOZoN5BygFsRX3GrVnaXISTn8mIC97rRW1pf0a0
 D7UMGygyIAqXPLJI8ngk0SMwnF+4NeyRHBEhTMU55z17NdrbEYgFBdOxHUAPBwF7aw76
 e+Yisrmiuvxtvp9BIOkG6IpwIFwoWdm3OP2UOlKrXDAe9LdmXs1YgtxgTDFNjKHNHTdq
 9TCvpC3BqxEp7sZmZGp8uRFtFvOvQmeDWrzXb7ySoUzQCCUXLGS+pWb2H2QviWPY7uvP
 8r3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc43/rv5DoDdC4kiDOQQxIGvW0Weq/Va/qKIPWwEzIvYe+VidJojRUfF7ysUIAr3N9MkrCi6xl@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4VH7TkshiOfz589cXl4JXIG2yuxIMXxNRstoJh0COqdMkbTAD
 vQBhaULAaugQP473uMfpyHh1Nu2qHx1yObbr3mrOd2HC6E4AVBOvBTyB9deZ65d1/FNyfZ0R+M0
 2StX97CYbSw9p4j79sEEZMAGOg8U=
X-Google-Smtp-Source: AGHT+IFwv2pYCJj4EDbSPFfH8SztUUcwwfuy3mModC5xlPtWI06WLtzKeNtDz4yU+eFaXECx9n4v2vM2reNuXqF5Lw0=
X-Received: by 2002:a17:90b:ec9:b0:2e2:e860:f69d with SMTP id
 98e67ed59e1d1-2e8f11c0f0fmr17325791a91.7.1730815713617; Tue, 05 Nov 2024
 06:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20241031180430.3993389-1-alexander.deucher@amd.com>
 <414c9f00-dd15-4d2e-8923-1ac64793becf@redhat.com>
In-Reply-To: <414c9f00-dd15-4d2e-8923-1ac64793becf@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Nov 2024 09:08:21 -0500
Message-ID: <CADnq5_Msa+xy1g_jg0UCACOd=utjPQbyE+H0UPFy777ED68UfA@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] Add panic support for all DCE/DCN
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 yaolu@kylinos.cn
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 5, 2024 at 8:59=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.com=
> wrote:
>
> On 31/10/2024 19:04, Alex Deucher wrote:
> > This builds on the patches from Lu and Jocelyn to fill in
> > panic support for all DCE/DCN variants and code pathes.
> >
> > v2: refactor to provide cleaner history and share more
> > code to provide a more consistent experience across
> > DC and non-DC.
>
> I wasn't able to build this patchset.
>
> drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:2712:31: error:
> =E2=80=98amdgpu_display_get_scanout_buffer=E2=80=99 undeclared here (not =
in a function)
>   2712 |         .get_scanout_buffer =3D amdgpu_display_get_scanout_buffe=
r,
>        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.o
> make[6]: *** [scripts/Makefile.build:229:
> drivers/gpu/drm/amd/amdgpu/dce_v10_0.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
> drivers/gpu/drm/amd/amdgpu/dce_v11_0.c:2825:31: error:
> =E2=80=98amdgpu_display_get_scanout_buffer=E2=80=99 undeclared here (not =
in a function)
>   2825 |         .get_scanout_buffer =3D amdgpu_display_get_scanout_buffe=
r,
>        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[6]: *** [scripts/Makefile.build:229:
> drivers/gpu/drm/amd/amdgpu/dce_v11_0.o] Error 1
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1526:31=
:
> error: =E2=80=98amdgpu_display_get_scanout_buffer=E2=80=99 undeclared her=
e (not in a
> function)
>   1526 |         .get_scanout_buffer =3D amdgpu_display_get_scanout_buffe=
r,
>
>
> I think there is one patch missing, that should add the
> amdgpu_display_get_scanout_buffer() implementation.

Argh!  I missed the first patch when I regenerated the patch set.
Resent with the missing patch.

Thanks,

Alex

>
> I've built and tested the v1 which works on my 5700XT.
>
> Thanks a lot for implementing drm_panic for all the other dcn/dce
> versions, I was hesitant to do that, because I can't test them.
>
> Best regards,
>
> --
>
> Jocelyn
>
>
>
> >
> > Alex Deucher (3):
> >    drm/amd/display: add clear_tiling hubp callbacks
> >    drm/amd/display: add clear_tiling mi callbacks
> >    drm/amd/display: add non-DC drm_panic support
> >
> > Jocelyn Falempe (1):
> >    drm/amd/display: add DC drm_panic support
> >
> >   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  27 +++++
> >   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  27 +++++
> >   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  27 +++++
> >   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  26 +++++
> >   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 103 +++++++++++++++++=
-
> >   .../drm/amd/display/dc/dce/dce_mem_input.c    |  34 +++++-
> >   .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  15 +++
> >   .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   2 +
> >   .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  15 +++
> >   .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +
> >   .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   1 +
> >   .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   1 +
> >   .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 +++
> >   .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
> >   .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   1 +
> >   .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   3 +-
> >   .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
> >   .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  15 ++-
> >   .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +
> >   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
> >   .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +
> >   21 files changed, 316 insertions(+), 8 deletions(-)
> >
>
