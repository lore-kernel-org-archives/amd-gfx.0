Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC0CCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 14:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B3F10E28D;
	Tue, 26 Aug 2025 14:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hUgIDuEX";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6832F10E28D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 14:24:10 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-24687bbe3aaso5701045ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756218250; x=1756823050; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVKBd+oYcrIP+/NhzioaAST50X2oa7gkCSIayAUHJUE=;
 b=hUgIDuEXBqvDCpBK+bjj9DXVJ+8qTHwtsP0RlqdIuur6pZJ/PXK6EAsSXTH8lMOWPD
 2VPhGqYG5oTa8NKmCK74+ENb4Hf/CNIk9vaI0Z1jMHNMAbWJzaeuUQ8vFkVPeymWeugs
 uwd3n/erKpTAzFSQ04xoJ3eBUt8Q+Znl1A15bG76fXSCYP9d1giYKF1IjCM2aMQ6JsWh
 aOCe6YlByfA74cPFj4cx+0vFMCR1tUpHorFy5JTVp1K1fGt1Zc8647I9NXeTOeTO0PGu
 m+c0wjKA73Ao5Xb4PJL5MW8ZBz+R9ZdDnMtRkKo4KzD2UbepltbbcZsXKm35tuLaPWRd
 G9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756218250; x=1756823050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVKBd+oYcrIP+/NhzioaAST50X2oa7gkCSIayAUHJUE=;
 b=Omt5nyseG4rTGI1GpIm0/CZot+bxx4PkbndS3uMB/kWd4914vhMGTvt1IZ10P9Ux7u
 z0E+bWksTDAJgOqggkjAN1lOhZ4pbEABAAqHiLuGdnjcdyhk8+3rgBeHqzyZraXByH8e
 VNb43AUPcYdEagf0q09FzGqHQKI/LXlexu6V461HVsv5/rq5xBq+F589+2L835YcTwMw
 CcVBeVpa1+NsSNWH6g/i/7lPgLEyvuGonjaFhXogUkS/76RRg79yYX2cnbl1ABChj8Ie
 TbOymJem0N95EzqKDAGSC7b3CmPaVkYkP1gJ3KgFDQuEn+bQqjYGByYhih0pH9Legy/7
 Zc5A==
X-Gm-Message-State: AOJu0YwerLrRu7pc1MUNnggPxk4qac4hM46QcetS3KNhypl2vSlCuYjM
 odEtiX42O/moR3cRqRO+yEHDVuRIDO87YrTNNuWU9xSjJSeuQe7zcc4HIriivTXkZvwxMfRRWSM
 G0wpou/DM5xTNT+vSP7S0U1dmsHczgy1qsw==
X-Gm-Gg: ASbGnctAGauWGVZuTFudW5Um0tfDkCPmUvjDs0Q3cSLUyA3l47U5fgAmtcRrCGzgxGc
 w+VO/89OmOAlqdiDZJjoaaAHgrbLh4YQqXKybdFKc0E2AHuCa/XPX2315JtGYltDw32bdGxv6ep
 EpGzA12H4QMvFm1iCOMlUHRc+1lv3dHCtLBBpWjhUze8X/sXHSjLyj/saFZo12sNG/IZwev+vWU
 R9t9z0=
X-Google-Smtp-Source: AGHT+IEGe14K9Ddq3p5XV0FW/ETOc/hrPrKRE6yt8/WVjLcCIc8Cs93miFKBHaUUmBWT5+hZoGYKmw+snJ/QmxikWDY=
X-Received: by 2002:a17:902:e851:b0:246:7d12:fd40 with SMTP id
 d9443c01a7336-2467d12fe71mr81793115ad.3.1756218249889; Tue, 26 Aug 2025
 07:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250825215631.628949-1-timur.kristof@gmail.com>
In-Reply-To: <20250825215631.628949-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 10:23:58 -0400
X-Gm-Features: Ac12FXx-5RDOzhEHLoXAzyjx13M-mmmMthoa3qM_GRmfwkNCJsIUb6_1WGfOvIA
Message-ID: <CADnq5_MjEuHz89Mv-_n5BoE4GMWD_PweLEwb=nydO1KdioPG2w@mail.gmail.com>
Subject: Re: [PATCH 0/4] DC: Fix page flip timeouts on DCE 6 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
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

On Mon, Aug 25, 2025 at 5:56=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Compared to the previous version of this series, v2 fixes
> the rebase conflicts on amd-staging-drm-next and includes
> an additional patch to address page flip timeouts when the
> displays are blanked.
>
> Currently when using DC on DCE 6, it produces pageflip timeouts:
>
> 1. When displays are blanked
> This is caused by (mistakenly) turning off the display engine
> clock on DCE 6.0 and 6.4 which is also the DP clock.
>
> 2. After suspend/resume
> The root cause is that DC assumes that the VUPDATE interrupt
> is always present, when in fact it isn't supported by DCE 6,
> which also doesn't support VRR.
>
> Finally, there is also a patch to disable fast boot mode
> on DCE 6. The rationale is that this already didn't work
> on DCE 8, and even if it did I have no means to test it.
>
> Timur Krist=C3=B3f (4):
>   drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4 (v2)
>   drm/amd/display: Disable fastboot on DCE 6 too
>   drm/amd/display: Disable VRR on DCE 6
>   drm/amd/display: Don't use non-registered VUPDATE on DCE 6 (v2)

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
>  drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
>  drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
>  .../dc/resource/dce60/dce60_resource.c        | 11 +++++++-
>  6 files changed, 46 insertions(+), 20 deletions(-)
>
> --
> 2.50.1
>
