Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E89DC3F68F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 14:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A5B2075D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 14:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtIkekte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A5B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D230B6E2F3;
	Wed,  8 Jan 2020 14:22:53 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0516E2F3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 14:22:52 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id y11so3575901wrt.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 06:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JogcyJktjZchGZusNi0s4dsPBvo8oKCb0BKjbq1hTWM=;
 b=EtIkekte/GgLIlbo6SAAWeQNNDILOKJnjWuRinqmFUksDDOTDEWDGd5zH5S3Pe2PJd
 hvty4eh16rjaEKciYn47Q02kXFcWclJw20zFpZlcOvMAUgNLUop4N4zoO9m2i4hHfkln
 YU4WaMOomk8DFdKmpC4zUz88vfczPl9TgtGsoFToEOWWpOQ/OP8NtGu4DUwxePFvLZOA
 aHxWyj7dHatE1RS25tP0Ueb+OZvHuslmiGukBLZLbyZwfAkFfMx/CHfRDHScHqGNc0Ki
 9CHCOD/G2vpq1u/+7zdMEoSZllfyAAUK4VmmfHEmNPYWDmWOaD6y3s36cHQaLc144D68
 LCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JogcyJktjZchGZusNi0s4dsPBvo8oKCb0BKjbq1hTWM=;
 b=jDYS02VkV9c10vU3DbQcLFKbrz+xp4SPk075iG5VbLyTMi5ZxqamXlADbqMZxIxGgM
 iRgUPBrZtiHTi8PeN/J8yGA+SvLV/yrGdwqvkZTGCYC50eHcSOp2xEMY5VngxQFGPLRr
 lmrMbePt0McjexCY45UzceqbtYnEo4eir04rxGmBiLFVPgO1InyoVJV5x4Ecv3Q/XWhn
 H11MMp5emP2MRVUzOJtL+qhNOX58GfE58sINP1b605hXs25cst8mMHZWAsg7DcnOzEDO
 93CuAjUrRt3e0H869I7Pj5YuPVyavVNjEuLP6Qc0GV6Rio/3M0pFW/WZgKsiga+C4TG8
 0fdw==
X-Gm-Message-State: APjAAAV5C1o0i0jXpChYcvgam3vwPsbqVoCCF7a9ryaEs936gH643Gx2
 W6gCPm4io007bWb4UYLoiclK40W8oExUNsU3ERmvDw==
X-Google-Smtp-Source: APXvYqwzxzdrMA2Vy8seiuCa+6CTifCPmP5W2+jtNs6SazMZLT5HlocKpEHUJE4IY3lxBxzeRiGqqCiR6pjbcfCvw/4=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr5017496wrn.50.1578493371522; 
 Wed, 08 Jan 2020 06:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20200108061511.30825-1-Tiecheng.Zhou@amd.com>
In-Reply-To: <20200108061511.30825-1-Tiecheng.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2020 09:22:39 -0500
Message-ID: <CADnq5_M=73iPRQkZFYSQOu1vtmSJNam6tOex5WBEGqatmJhw5w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sriov: workaround on rev_id for Navi12 under
 sriov
To: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 8, 2020 at 1:15 AM Tiecheng Zhou <Tiecheng.Zhou@amd.com> wrote:
>
> guest vm gets 0xffffffff when reading RCC_DEV0_EPF0_STRAP0,
> as a consequence, the rev_id and external_rev_id are wrong.
>
> workaround it by hardcoding the rev_id to 0, which is the default value.
>
> Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index b0229543e887..63d54604ace6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -726,6 +726,8 @@ static int nv_common_early_init(void *handle)
>                         AMD_PG_SUPPORT_VCN_DPG |
>                         AMD_PG_SUPPORT_JPEG |
>                         AMD_PG_SUPPORT_ATHUB;
> +               if (amdgpu_sriov_vf(adev))
> +                       adev->rev_id = 0;

Please add a comment explaining this here so it's clear why we are
doing this.  With that added:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>                 adev->external_rev_id = adev->rev_id + 0xa;
>                 break;
>         default:
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
