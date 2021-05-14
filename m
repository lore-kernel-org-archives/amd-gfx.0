Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7794FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35941613DE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35941613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F362C6E488;
	Fri, 14 May 2021 21:13:16 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6D16E488
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 21:13:16 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id b25so793637oic.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jIO5q3c7UHtru5VBFeItvGKkQZHrhwDLBxhqzclZfKg=;
 b=lAWq8hMoiT3LRO62k6azDjdCytss63Kb+Q/MaJglDz8mKnOaP2lkNx9+7cB2sqKT90
 oB/RFzUb3Kh+XacMbZkv1BLhaPvnw7zsxiQT29IHy0vctECzIJQ9tvO8y3Na2Q8Zr5mZ
 1wL6fcA2wBSMAVoOCJw/ehbXulgspOs2tTAABONWaLO3xp1dk1ksWRMFOvCMgYLRAfEV
 9QKjhiLOcWidwfBrBULS12n5jLdX/DfKD5j4YHFIVu3E97i/job4AbuU34fTzrYsqNKk
 ymsE++mwyCu7CPMNU6ScF8vKRREEaT9irebgOugRr66z1SKQMlp6jkMEg5V06X7XJOk8
 Z7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jIO5q3c7UHtru5VBFeItvGKkQZHrhwDLBxhqzclZfKg=;
 b=Th9jR3/X+h/WckOPW16yXMZ9709rHQZh+DJiHcdRhbxvY2CbWNvqWNhKIINfZTyeKo
 rQjKQ5vHMO1rqtMLHsA0ERAX+viPvraAso1YvnItTBOyBdXiMHXi/h2vQuO4+fxmzJxT
 aSQL+f+ihyo+t4wwzxVccsLlBdQiE/rzRIGrM8IKfHHq3N/oU5891PV2fvz0/Fso3u5i
 H+YS9zlx1715lmnPXTrHs5XMZrxjAsSYS/CxL2I8m7Y2FpEoJOOXH7ijgA8Lv/RIGuyG
 4ifN1dRYDhI3BfmIt1+5kNYotWc4mdPEoK2spmqAxdemSMnfElqhstdoF6WW75JV9dxZ
 wirw==
X-Gm-Message-State: AOAM533zW2neXPB1W/W0ETb+hiJ6piZhDgbYJe/i6EOc6DRdXnSY54b6
 wFgzkiME71hq7YkQ9MC1wjF1ELZmE1kyIc1Xa9A=
X-Google-Smtp-Source: ABdhPJyMee0ZQ/8qtJwHnqaekEoH0pLgZO6SYh5kmvgJFkhoBCyajRyTe9gsQ4PieOnkcgc/YXq+GhhNfGRMDYj8Ni0=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr34809458oig.120.1621026795624; 
 Fri, 14 May 2021 14:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 May 2021 17:13:04 -0400
Message-ID: <CADnq5_PFVXw3q9OhNxBthG-7M61H9_rJv+1=if43ukC1UA8h_g@mail.gmail.com>
Subject: Re: [PATCH v4 01/16] drm/amdgpu: Indirect register access for Navi12
 sriov - new internal macro
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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

On Fri, May 14, 2021 at 3:27 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> Change RLCG/SOC15 register access interface to triage
> GC/MMHUB access from MMIO to RLCG.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

I think patches 1-4, 16 need to be squashed together to avoid breaking
the build.  Please also provide a description of how the new macros
work in the patch description.  Describe how the reworked macros
properly handle sending GC and MMHUB accesses via the RLC rather than
via some other mechanism.  It's really hard to follow the macro logic.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 14bd794bbea6..9b18e19f4c73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -27,6 +27,16 @@
>  /* Register Access Macros */
>  #define SOC15_REG_OFFSET(ip, inst, reg)        (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
>
> +#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
> +       ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
> +        adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
> +        WREG32(reg, value))
> +
> +#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
> +       ((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
> +        adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
> +        RREG32(reg))
> +
>  #define WREG32_FIELD15(ip, idx, reg, field, val)       \
>         WREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,  \
>         (RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
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
