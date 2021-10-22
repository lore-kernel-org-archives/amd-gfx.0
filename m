Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED54C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 04:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0B7610E7
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 04:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF0B7610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237F06E544;
	Fri, 22 Oct 2021 04:29:43 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F866E544
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 04:29:41 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 w12-20020a056830410c00b0054e7ceecd88so3020096ott.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mad9+hGFetORofknaoiqQl3FJjCYbnTgs5v8pQQBo34=;
 b=Vz0N877DJd8vvlgPrvjEGQsLc8iOwbFfPTTG/uZ6n5XlJllFsCiycrwl69I6b7gle0
 WB9e6TCusf++7PwKOuT3SsEnwqG6942jSz5y1h4LKQQakqZsKyApBuCIJwozkByL4Ax0
 54mvkaqpu4LuTxBJ7P44C6CvGbIdwlaJAWFB/a07zbrW89SxKb3mzvpNJ45mBNV+EqDH
 KgwD6H7VJdyJPM5kDHzJ6N/IxyoXJNlGyXjfQZ9vCFj9cwFvDGyZtWL1IICCYaVMmPqb
 1AOlscIc4K8w9nsC5b/snHxHWL2l+q7ufbk0hGt7ujMS+9Or7iIqMxyfEId4mrmh+0TV
 iDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mad9+hGFetORofknaoiqQl3FJjCYbnTgs5v8pQQBo34=;
 b=Er0OCClFCcya5PDjjfKB4+4jgxMjuS/iR4RUVHYUSW+ODMpZpSbLMamvluRVtPcVK2
 1631qD32CzDBEdrdXmyFJwaVpGXFvoOzQqMkmDaJ5Q0WNFzBwGYvRe8zjBjzsTuJHEjy
 3ojo6IYa498riiwzKRTrzTfPj6E0jxsDvD2Pkwmp9G/HdInjkplMcyyifNgJ1P6TkTER
 nJOD+CrcJaLkx5Wv/MZ6reePGqCkKNAl/DQiR/CoODBqsoDwRinQW6B8i7ZpbseRfaci
 PkuU3/sSFX6g4c4bgOJ+3TNvvGFs/A2LVjr/Asgh35pmXDa65h3Olzb1ti/CWFpwGBbm
 Krnw==
X-Gm-Message-State: AOAM533vKJwaXMqOIA9RspRpKu3u0NWKfEFdM9esMqYAllxw++vOW4iG
 ogMr4nRjdJPHFlJNL9HPbXSeQUoLJe4wtm5mwqq52ohSM4s=
X-Google-Smtp-Source: ABdhPJyS8uerMBw8NFp+Wf5ceePzjmCnEdShC+bw/4QR/bKryOnsXiRpMFeYSd1ulRonY9ovYap2dXdsdA+znjNR5BY=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr8271063otj.299.1634876980950; 
 Thu, 21 Oct 2021 21:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211022042046.959686-1-alexander.deucher@amd.com>
In-Reply-To: <20211022042046.959686-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Oct 2021 00:29:30 -0400
Message-ID: <CADnq5_O8Ds1j8aOSQJJEUd=fNPez-djXmi2f4yrST=Ot=-wMhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/nbio7.4: use original HDP_FLUSH bits for navi1x
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Oct 22, 2021 at 12:21 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>

Copy paste typo in the patch title fixed locally.

> The extended bits were not available for use on vega20 and
> presumably arcturus as well.
>
> Fixes: a0f9f854666834 ("drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h        |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 814e9620fac5..208a784475bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1125,10 +1125,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>                 break;
>         case IP_VERSION(7, 4, 0):
>         case IP_VERSION(7, 4, 1):
> -       case IP_VERSION(7, 4, 4):
>                 adev->nbio.funcs = &nbio_v7_4_funcs;
>                 adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
>                 break;
> +       case IP_VERSION(7, 4, 4):
> +               adev->nbio.funcs = &nbio_v7_4_funcs;
> +               adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg_ald;
> +               break;
>         case IP_VERSION(7, 2, 0):
>         case IP_VERSION(7, 2, 1):
>         case IP_VERSION(7, 5, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 3b7775d74bb2..b8bd03d16dba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -325,6 +325,21 @@ static u32 nbio_v7_4_get_pcie_data_offset(struct amdgpu_device *adev)
>  }
>
>  const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg = {
> +       .ref_and_mask_cp0 = GPU_HDP_FLUSH_DONE__CP0_MASK,
> +       .ref_and_mask_cp1 = GPU_HDP_FLUSH_DONE__CP1_MASK,
> +       .ref_and_mask_cp2 = GPU_HDP_FLUSH_DONE__CP2_MASK,
> +       .ref_and_mask_cp3 = GPU_HDP_FLUSH_DONE__CP3_MASK,
> +       .ref_and_mask_cp4 = GPU_HDP_FLUSH_DONE__CP4_MASK,
> +       .ref_and_mask_cp5 = GPU_HDP_FLUSH_DONE__CP5_MASK,
> +       .ref_and_mask_cp6 = GPU_HDP_FLUSH_DONE__CP6_MASK,
> +       .ref_and_mask_cp7 = GPU_HDP_FLUSH_DONE__CP7_MASK,
> +       .ref_and_mask_cp8 = GPU_HDP_FLUSH_DONE__CP8_MASK,
> +       .ref_and_mask_cp9 = GPU_HDP_FLUSH_DONE__CP9_MASK,
> +       .ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__SDMA0_MASK,
> +       .ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__SDMA1_MASK,
> +};
> +
> +const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald = {
>         .ref_and_mask_cp0 = GPU_HDP_FLUSH_DONE__CP0_MASK,
>         .ref_and_mask_cp1 = GPU_HDP_FLUSH_DONE__CP1_MASK,
>         .ref_and_mask_cp2 = GPU_HDP_FLUSH_DONE__CP2_MASK,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
> index b8216581ec8d..cc5692db6f98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
> @@ -27,6 +27,7 @@
>  #include "soc15_common.h"
>
>  extern const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg;
> +extern const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald;
>  extern const struct amdgpu_nbio_funcs nbio_v7_4_funcs;
>  extern const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs;
>
> --
> 2.31.1
>
