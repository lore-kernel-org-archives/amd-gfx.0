Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF3BC55179
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 14:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865BE20709
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 14:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2Jz0Mth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865BE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248A16E0A1;
	Tue, 27 Oct 2020 14:48:00 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF676E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 14:47:59 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id k21so1247761wmi.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oxTk8NbR6mATIy34Kpv5XZCtu4AJMscfpzIYbjEYuqA=;
 b=G2Jz0MthKfYuP/Y4ZfwMv/qEZlQD4AV3+AHxjyJ43frq/dd2A3MQDF8Q2JtueqNmQW
 hIXbnVmi13fH3lx201/Lxxs9p/KsxRX6+AMZyOMayK3fEXOIEebu9cNV5EKPk4ms+mSJ
 GfRJQsmturolF+ZY04eQM6y1GEFgMO8HerpK2fsX9qZL8RgC1E52AXMt68HtEyI/Cn2z
 EJEyoOpUUjT0gnl+bP47DTpExLcZjo4c2cBrmWogFS2ndl+vg3uCgALnjd8yCx20/9Kb
 jAsvzHQej90xvagT4N6n011TvOHgzXpfVUzh9JGr6GVgQOegdy+oIXeA7MsA4iGUuAZB
 bvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oxTk8NbR6mATIy34Kpv5XZCtu4AJMscfpzIYbjEYuqA=;
 b=hZyjnrwEYPTR/oZz92Vm8ScUd8EEDk6eDaJitmD8gjuwJoJJuvZ3ZzqUPQMuFThVqt
 2lmSpHSWmCN0FK3spRAeBvNGhCDaHqm7zfnmm67cWOBCjJmtrt9baJXAaDxJZTcvjD2G
 i5iCLZyRM0tmf1FrwXgewWdq1f4EPvd9VJzJcEeHLJ5U+fnVEbbt4ujvX3wtLtLe413n
 /TScI/+0ScQMo+NmfpG1N6B0zLPW6Q2uu20RUT3qkfQ9J11Vt3MDnZDFLpRkXTM9JZ7X
 /HhNBU9ijWH20l+Tajr4GJssxcdXs8FKbSujBxw1Y4WOQaBiDTnP/9GYU7hB3/e5g0Md
 nv1A==
X-Gm-Message-State: AOAM532vWCo/OhYv6cJiRhWEVa42zP/rH2kLoe5CZD+qgIbOTFkyn6I9
 KXKKAZOpECvcruSP4Klb03Q/W7G36koLt1GPIk8=
X-Google-Smtp-Source: ABdhPJzoFfvgI1Tta2KyfC5xd402g2WWxCiA27dYvuVsLR/CyK3D8TgMJZZu4FIy9fiHgYFOInfZBUJX3MqETbq3guM=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr3179211wmb.56.1603810077810;
 Tue, 27 Oct 2020 07:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201027024025.32269-1-evan.quan@amd.com>
In-Reply-To: <20201027024025.32269-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2020 10:47:46 -0400
Message-ID: <CADnq5_OeWk8Y4X+iHqM6SzzyCaHiy+uP8bccV3=wJUxA56Bb9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sandeep <sandy.8925@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 26, 2020 at 10:43 PM Evan Quan <evan.quan@amd.com> wrote:
>
> Which can be used for S4(hibernation) support.
>
> Change-Id: I6e4962c120a3baed14cea04ed1742ff11a273d34
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cik.c                 | 4 +++-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c | 7 ++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 03ff8bd1fee8..5442df094102 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1336,11 +1336,13 @@ cik_asic_reset_method(struct amdgpu_device *adev)
>
>         switch (adev->asic_type) {
>         case CHIP_BONAIRE:
> -       case CHIP_HAWAII:
>                 /* disable baco reset until it works */
>                 /* smu7_asic_get_baco_capability(adev, &baco_reset); */
>                 baco_reset = false;
>                 break;
> +       case CHIP_HAWAII:
> +               baco_reset = cik_asic_supports_baco(adev);
> +               break;
>         default:
>                 baco_reset = false;
>                 break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> index 3be40114e63d..45f608838f6e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
> @@ -142,12 +142,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BCLK_OFF_MASK,           BACO_CNTL__BACO_BCLK_OFF__SHIFT, 0, 0x00 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MASK,          BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0x00 },
>         { CMD_DELAY_MS, 0, 0, 0, 20, 0 },
> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x20 },
> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x200 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ISO_DIS_MASK, BACO_CNTL__BACO_ISO_DIS__SHIFT, 0, 0x01 },
> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c },
> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c00 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ANA_ISO_DIS_MASK, BACO_CNTL__BACO_ANA_ISO_DIS__SHIFT, 0, 0x01 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x00 },
> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x10 },
> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x100 },
>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0x00 },
>         { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xffffffff, 0x00 }
>  };
> @@ -155,6 +155,7 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
>  static const struct baco_cmd_entry clean_baco_tbl[] =
>  {
>         { CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
> +       { CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 },
>         { CMD_WRITE, mmCP_PFP_UCODE_ADDR, 0, 0, 0, 0 }
>  };

The changes to this file look like a bug fix.  Can you break that out
as a separate patch?

Alex


>
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
