Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1135C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 17:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C5961879
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 17:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C5961879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144026E462;
	Mon, 29 Mar 2021 17:41:43 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26BB16E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 17:41:42 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 k14-20020a9d7dce0000b02901b866632f29so13087799otn.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AmWLkf3F/t3lXU3YDik3vWRGelAstHwEHuRdF20Vw+4=;
 b=g/qMfvXct1EBMdCL808fUydjbLnb7s/41nRiA9KTZ12M7c59UxeFCYCg6mgHCSa0uX
 WbjEu9tw80566KiLAT/n/pxR41MbD70Ct6UZldemxyy/KfFFVlf2EoGg8nuDUEbaA8tz
 o8waX5N7K4U+RuEjhH/KfXVUK5Ceoj/LCw7ASn7r3gi/g+ZfrmJqYJwCFOd1T0nnxD0Z
 BDkUmDbrh1KYPvwxM90mAQuzORBa2k4fUee5jVlZJbVpkTM4IvHAEGQfXwaEpqq/TEFF
 Ha9jUpBjo1/Nm0bnujh6wHEVZy9uwSoM3SJlf3O43OURByCKutlDUAhdGD8jQHJpnRkV
 d9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AmWLkf3F/t3lXU3YDik3vWRGelAstHwEHuRdF20Vw+4=;
 b=nmi/Mls3Qa4etf8rtSApxvtNYOxivk7Gbe/z1Q/dxfX2w1sSP+MsQgNiR27n/mfb0Z
 N34NqK9DmHG7gujQrY3xbfgEmkm2UT8kBUyzrO5gYFLLbDs182hIP4s5WC+1G5aBNmvc
 1IeO2Ipwoo6tTIEJKz5/wCIiSjoWMKihajpNgOKkSflkfCWLA15s/ecZgzI6kX52P7gJ
 8fWzkPDjuVx6tkK9rwRqwPhJW6BkliO0JOXOqJ7bTg9BAbZvmQZKGPYp3IM5CkncCMJx
 Ps5Zy6m0A2q9MdLxsdr6A9y/HdnU95hhUkraJ0x6uvSazi4AUTBJTYPfx+xW7VgYEe85
 9HiQ==
X-Gm-Message-State: AOAM533itPpqmnWZxGUgEVvmMExPFcGNkWPEVW5pOfZokNxqP05dtgmA
 5uvdEdokaRMqgo5I5eZuSNgrstrHAPqzf9i3jTk=
X-Google-Smtp-Source: ABdhPJwgw2e0DN7ySug4BQEplC4IWZYGFmbHQHCnYlMjPLkhnsLvuPJ+aKLupXtq/TqlzG6suAjozaBvNUu1FS/eSU4=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr24056548ots.23.1617039701549;
 Mon, 29 Mar 2021 10:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210311141942.44342-1-alexander.deucher@amd.com>
In-Reply-To: <20210311141942.44342-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Mar 2021 13:41:30 -0400
Message-ID: <CADnq5_PQUnOcG1QHsPvXhOFJEKQBO5_8gxO7FkkWdXP5G+uduw@mail.gmail.com>
Subject: Re: [PATCH] Revert "amd/amdgpu: Disable VCN DPG mode for Picasso"
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 Leo Liu <leo.liu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Thu, Mar 11, 2021 at 9:20 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> This reverts commit c6d2b0fbb893d5c7dda405aa0e7bcbecf1c75f98.
>
> This patch is a workaround for a hardware bug, but I don't
> know that we've actually seen the hw bug triggered in practice,
> meanwhile a number of people have reported that this causes
> suspend and resume issues.
>
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=211277
> Cc: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
> Cc: Leo Liu <leo.liu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 3808402cd964..1a0c3a816863 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1405,7 +1405,8 @@ static int soc15_common_early_init(void *handle)
>
>                         adev->pg_flags = AMD_PG_SUPPORT_SDMA |
>                                 AMD_PG_SUPPORT_MMHUB |
> -                               AMD_PG_SUPPORT_VCN;
> +                               AMD_PG_SUPPORT_VCN |
> +                               AMD_PG_SUPPORT_VCN_DPG;
>                 } else {
>                         adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>                                 AMD_CG_SUPPORT_GFX_MGLS |
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
