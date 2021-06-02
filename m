Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFB0C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CDD6139A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CDD6139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5546E0F7;
	Wed,  2 Jun 2021 02:14:38 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC736E0F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 02:14:38 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 5-20020a9d01050000b02903c700c45721so98717otu.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jun 2021 19:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I9a0yaYmNZlhfH4RCfEcu+BjMMJBn8dLAPGou8o0BAU=;
 b=R2Kb3Ng9FG5lXYWLWQWCfMYHBY+2eRsLyrOtp5a3jRZkb9yTzQIjt4mkteVqWhGnmZ
 XpNSksyi7leq9UgfEz4e4rnPE/3CK9/zixutJCsj3l0OreIC6QLOqyr0eX5wubj3dKUk
 3gUragOaBIWdhRsjxBPNMGPIQbQasuFPPgaVg7S4mfoJBOpCNJhflQqTpK+lNbhgcLQJ
 WXeXoIczuCEsmIIenV4BamxeOaDwuze/TX5V2TunW6aJUPprmTmzvsIGabAHP3PkpOF8
 yZ23hHMpNZerlGl5gfwJhu+K6IU6KbOJS34roNVroYu+zBpILZYOjcDIFYyHmnbH7RYF
 qEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I9a0yaYmNZlhfH4RCfEcu+BjMMJBn8dLAPGou8o0BAU=;
 b=EsS9HI5IEZSQK4aktxR3UzottEy2VUM6GmskDBkp5inpmfhav78eF4yuUzRpLHVql8
 BZlcQd6FsXEzxDizPAgiMXQJ+/mCT2axi1bz7zSLutW/TKLAb8a2gQSKJc9Re4ZMGKYV
 qdvvn9Eu3Jq0hhkDovBFPde5hBdBiicRM5z/k5+iE3El0+FWMtbJCVoqgdB3w4mBnCTu
 XRA4QQQXZ+RekxUB052a352k8LYx1M3aUHIgQWdi+lWqC1ZReTl7dOhsnjnq1LicDxH0
 Ll19bwFe4DdhiTIgzgmmVCMsGGrJ5XKPOaM8XtK9RhJzYcfb6IRq492H2bZoGKK4fi3i
 632w==
X-Gm-Message-State: AOAM533IzY145ssP3IyOTg1r8ctqb+criuHH9pQn85I3noWxDkO1Y+kY
 3U+0SFA5s2pVqWvhTX9nImqvtg1yjT7f0LmMAwE=
X-Google-Smtp-Source: ABdhPJzUYo7eskVvDDi5PzipjxqZGoo+q7AhzJcsrMGiA+5mGosUNbYYlQujdqpMHfHilbiUiMa5gt0vp3Ls/mX9r0g=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr24154573oti.23.1622600077455; 
 Tue, 01 Jun 2021 19:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210601162825.11235-1-shaoyun.liu@amd.com>
In-Reply-To: <20210601162825.11235-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jun 2021 22:14:26 -0400
Message-ID: <CADnq5_PMCxomYYwojEeEicn6cZDVDNe_422KCv989gQKGuoVWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: soc15 register access through RLC should only
 apply to sriov runtime
To: shaoyunl <shaoyun.liu@amd.com>
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

On Tue, Jun 1, 2021 at 12:28 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> On SRIOV, driver should only access register through RLC in runtime
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: Iecaa52436a2985a18ede9c86cb00cc197a717bd6
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index c781808e4dc3..f6cf70e69cce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -28,12 +28,12 @@
>  #define SOC15_REG_OFFSET(ip, inst, reg)        (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
>
>  #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
> -       ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
> +       ((amdgpu_sriov_runtime(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
>          adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
>          WREG32(reg, value))
>
>  #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
> -       ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
> +       ((amdgpu_sriov_runtime(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
>          adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
>          RREG32(reg))
>
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
