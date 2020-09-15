Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5F4C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 13:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA2520936
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 13:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKP4zxvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA2520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B286E2A0;
	Tue, 15 Sep 2020 13:11:38 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B96F6E2A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 13:11:37 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id y15so3429259wmi.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tNjsh3r89A2373Yk9Kyopyli7MR3AnjSeGq0RVJjn7s=;
 b=mKP4zxvk7cumJdjXr2XSEx5vAsDTzGPpenFAUDzDy7HzTtTtnXP4DAtjDsBgr9bUdY
 KV1mT2kXUQ4GDpSKXKHcpyPVwcsENyQ76g+BUcRzFew/oUxFDhHlZWTSoaxhjzzLq/ub
 phsWjHWjqflgUebarbjYTS8N47eH1mQA/P1L3hXsNkxwEDVN3YX1qZBEez848XsHTVii
 VSjKiwSARE1aOBa4KtNL7Zj7YEwotG5KV+PTBaaKxUS6wgXeXBf/pY8K7V8Nbd/4o3Y6
 ow5PGxkwvl1IZW4ALhfhu0ehZvMF3+i2kw5xHo2E4AoN9o69JlTcoctK6nqMYWsvR3IZ
 UaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tNjsh3r89A2373Yk9Kyopyli7MR3AnjSeGq0RVJjn7s=;
 b=Z8xqep78nuyJNZEVlPcV+VfzRuG0eujS8z5jCpd5GTA9bVImGTJ8FjKoZecSctp2mU
 7GPsLcltFOjufoFwtxGRAKCBZQlpSv31pCaynz5s1MH3r+BdzwTuP2mDJxSRDlZzNvEM
 TLHMK414zxa2NysLYLJcLwW2cLMqO5ngU+4KV5eQb0m1kGBnfS6Jppy2CO72r45SH62m
 tP5zbxKETZVYcsqfwXtAnHSM2x54Ebz8ewc+drc2wEnnGNR9fbXU44ZkOF0c7GFRh0hf
 YCHCOBUOkoFw33f71ap1lSycRWvzn+hnKz0ZPgAk1Vkxkd769XgWvv6NH1F4Cj9MeEdN
 +TRg==
X-Gm-Message-State: AOAM533C84Ymdioh0N0LQbW716M/HOlIZmAKwNjaUM5KSfsQmz2fW1oU
 yTa4lnGGP+mKUWNKIqDgd4k09pBZv4BsY3uNb/M=
X-Google-Smtp-Source: ABdhPJzAw2p/KYQCkfZbwNvnnsllOouj2hRN1X1IFwilZMQuF+a1HNlPBmWhkT5w9bXlC9HVjZuDllWBPWWOVtxQ8Gg=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr4662053wmc.73.1600175495920; 
 Tue, 15 Sep 2020 06:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200914045513.83649-1-shirish.s@amd.com>
In-Reply-To: <20200914045513.83649-1-shirish.s@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2020 09:11:24 -0400
Message-ID: <CADnq5_MsyO9rszMBfSUEhWUOdgFiQX2ojN7-0x1tdDjOfz2iMQ@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/gmc_v9: Warn if SDPIF_MMIO_CNTRL_0 is not set
To: Shirish S <shirish.s@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 14, 2020 at 12:55 AM Shirish S <shirish.s@amd.com> wrote:
>
> With IOMMU enabled, if SDPIF_MMIO_CNTRL_0 is not set
> appropriately the system hangs without any trace
> during S3.
>
> To ease debug and to ensure that the failure, if any,
> was caused by a race conditions that disabled write access to
> SDPIF_MMIO_CNTRL_0 register, warn the user about it.
>
> Signed-off-by: Shirish S <shirish.s@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index d0645ad3446e..fc2d88dbe828 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1546,8 +1546,11 @@ static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
>   */
>  void gmc_v9_0_restore_registers(struct amdgpu_device *adev)
>  {
> -       if (adev->asic_type == CHIP_RAVEN)
> +       if (adev->asic_type == CHIP_RAVEN) {
>                 WREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, adev->gmc.sdpif_register);
> +               WARN_ON(adev->gmc.sdpif_register !=
> +                       RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
> +       }
>  }
>
>  /**
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
