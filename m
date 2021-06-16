Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00CC48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 11:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C31360FDC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 11:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C31360FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46BA96E56A;
	Wed, 16 Jun 2021 11:01:50 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A26C6E56A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 11:01:49 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id t3so2092931edc.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Mxly3IwcaaWQsjbhZn2WiayEjmRpPEvGL+Hs03Kzoug=;
 b=X2TbYIgJZyPNlefHt+s5CJDOzpG3ot+3BJgizGkkEPnPmPDyY5L0ClfjOCohgU4Nzd
 pxNpnn2zAr56DUEWd2YPL4CyAgdGxHvCMnkduNN2CTiUB70csGuE1Dik+c0JtmHDsqX/
 Ju/GBWV7Esph1UXewOYuQnhxRgVPPfTldy/A5WmOVebpS6nTGZqH574cfves+zPHi4At
 0skbtzmEIlkZxkpVtPfVTHQ3ZVhXifFuH1WSNBghO7jKi7C5HtcN+q0W+DqXuz+Y52uh
 t4Vt61GPJ8Q2tWf08YrL7OsOicYRdi0/sr8fstTcBYlVi7ixNYnClp+iNRrr6sWZZT/D
 Zp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Mxly3IwcaaWQsjbhZn2WiayEjmRpPEvGL+Hs03Kzoug=;
 b=q4cCxg/iVB7snD8R7Lt+jjyS8nYpbH1J6vt38pFcIQ5InejF6U/BB8PUSKxCRQUaT1
 hm5IP+rfyCCJ7Y9PZHD+4OLVRpm7o4robMtzSzebctPeeW1FSLYvpqXj9qrbHQji8bJF
 B7w4smvxZfDGgDmVcv0DTpPJcstwdfX7cXFUx2k/MCBRQc5lQD4Ow8td9sETB21qOJAm
 RMvF8CGbWoHnAEOkSg7PRREW57aMjeMwakZzB6sY04hkSR4DoqO9fNoqJPYDeKOBckhK
 rSEma/uMzbHnOi/t8Qw79Pvcc9N2s9oJNUWa7UvCrcxclSeP1JYPjgYmkOfFRhL8msX/
 SDhQ==
X-Gm-Message-State: AOAM530Pv95frIvyQImAUYHNkQgE4wkZw0tnFhi5aG+EpgfTD4q6JZkm
 ELfA/8lhaCRpIbgv/0TmVd4Pmg4C8v0=
X-Google-Smtp-Source: ABdhPJzmwi1CUXoMayVzvQKxx9QqDTtPHxg3Uuh/QpLBHkB8G3qOBnfQqxbnTPlz6GAQhUhGp/mz9A==
X-Received: by 2002:a05:6402:4316:: with SMTP id
 m22mr3395633edc.316.1623841308291; 
 Wed, 16 Jun 2021 04:01:48 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:afc4:3771:10a6:8a6d?
 ([2a02:908:1252:fb60:afc4:3771:10a6:8a6d])
 by smtp.gmail.com with ESMTPSA id j22sm1419913ejt.11.2021.06.16.04.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 04:01:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: add gfx rlc enter/exit safe mode through
 emit ring
To: Changfeng <Changfeng.Zhu@amd.com>, Ray.Huang@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20210616101440.11523-1-Changfeng.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7dad9ec1-6cd7-b352-2df9-33bd919ddeb8@gmail.com>
Date: Wed, 16 Jun 2021 13:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616101440.11523-1-Changfeng.Zhu@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This needs a commit message and a bit of justification.

Christian.

Am 16.06.21 um 12:14 schrieb Changfeng:
> From: changzhu <Changfeng.Zhu@amd.com>
>
> From: Changfeng <Changfeng.Zhu@amd.com>
>
> Change-Id: Ib6065f39d61872ac0497afd11789d98e56434b40
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 34 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  4 +++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 26 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/soc15.h      |  4 +--
>   4 files changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> index 6373bfb47d55..d5978c3a0e02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
> @@ -51,6 +51,23 @@ void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev)
>   	}
>   }
>   
> +void amdgpu_gfx_rlc_emit_enter_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	if (adev->gfx.rlc.in_safe_mode)
> +		return;
> +
> +	/* if RLC is not enabled, do nothing */
> +	if (!adev->gfx.rlc.funcs->is_rlc_enabled(adev))
> +		return;
> +
> +	if (adev->cg_flags &
> +	    (AMD_CG_SUPPORT_GFX_CGCG | AMD_CG_SUPPORT_GFX_MGCG |
> +	     AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> +		adev->gfx.rlc.funcs->emit_set_safe_mode(adev, ring);
> +		adev->gfx.rlc.in_safe_mode = true;
> +	}
> +}
> +
>   /**
>    * amdgpu_gfx_rlc_exit_safe_mode - Set RLC out of safe mode
>    *
> @@ -75,6 +92,23 @@ void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev)
>   	}
>   }
>   
> +void amdgpu_gfx_rlc_emit_exit_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	if (!(adev->gfx.rlc.in_safe_mode))
> +		return;
> +
> +	/* if RLC is not enabled, do nothing */
> +	if (!adev->gfx.rlc.funcs->is_rlc_enabled(adev))
> +		return;
> +
> +	if (adev->cg_flags &
> +	    (AMD_CG_SUPPORT_GFX_CGCG | AMD_CG_SUPPORT_GFX_MGCG |
> +	     AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> +		adev->gfx.rlc.funcs->emit_unset_safe_mode(adev, ring);
> +		adev->gfx.rlc.in_safe_mode = false;
> +	}
> +}
> +
>   /**
>    * amdgpu_gfx_rlc_init_sr - Init save restore block
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index 7a4775ab6804..9e0eb4882b84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -117,7 +117,9 @@ typedef struct _RLC_TABLE_OF_CONTENT {
>   struct amdgpu_rlc_funcs {
>   	bool (*is_rlc_enabled)(struct amdgpu_device *adev);
>   	void (*set_safe_mode)(struct amdgpu_device *adev);
> +	void (*emit_set_safe_mode)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>   	void (*unset_safe_mode)(struct amdgpu_device *adev);
> +	void (*emit_unset_safe_mode)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>   	int  (*init)(struct amdgpu_device *adev);
>   	u32  (*get_csb_size)(struct amdgpu_device *adev);
>   	void (*get_csb_buffer)(struct amdgpu_device *adev, volatile u32 *buffer);
> @@ -194,7 +196,9 @@ struct amdgpu_rlc {
>   };
>   
>   void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev);
> +void amdgpu_gfx_rlc_emit_enter_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>   void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev);
> +void amdgpu_gfx_rlc_emit_exit_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>   int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws);
>   int amdgpu_gfx_rlc_init_csb(struct amdgpu_device *adev);
>   int amdgpu_gfx_rlc_init_cpt(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 14136de8abb8..3c93fcfffa85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4822,6 +4822,19 @@ static void gfx_v9_0_set_safe_mode(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static void gfx_v9_0_emit_set_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	uint32_t data;
> +	uint32_t reg;
> +
> +	data = RLC_SAFE_MODE__CMD_MASK;
> +	data |= (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);
> +	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SAFE_MODE);
> +
> +	amdgpu_ring_emit_reg_write_reg_wait(ring, reg, reg, data, data);
> +
> +}
> +
>   static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev)
>   {
>   	uint32_t data;
> @@ -4830,6 +4843,17 @@ static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev)
>   	WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE, data);
>   }
>   
> +static void gfx_v9_0_emit_unset_safe_mode(struct amdgpu_device *adev, struct amdgpu_ring *ring)
> +{
> +	uint32_t data;
> +	uint32_t reg;
> +
> +	data = RLC_SAFE_MODE__CMD_MASK;
> +	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SAFE_MODE);
> +
> +	amdgpu_ring_emit_reg_write_reg_wait(ring, reg, reg, data, data);
> +}
> +
>   static void gfx_v9_0_update_gfx_cg_power_gating(struct amdgpu_device *adev,
>   						bool enable)
>   {
> @@ -5121,7 +5145,9 @@ static bool gfx_v9_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offset
>   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
>   	.is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
>   	.set_safe_mode = gfx_v9_0_set_safe_mode,
> +	.emit_set_safe_mode = gfx_v9_0_emit_set_safe_mode,
>   	.unset_safe_mode = gfx_v9_0_unset_safe_mode,
> +	.emit_unset_safe_mode = gfx_v9_0_emit_unset_safe_mode,
>   	.init = gfx_v9_0_rlc_init,
>   	.get_csb_size = gfx_v9_0_get_csb_size,
>   	.get_csb_buffer = gfx_v9_0_get_csb_buffer,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
> index 034cfdfc4dbe..717abf73f718 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
> @@ -28,8 +28,8 @@
>   #include "nbio_v7_0.h"
>   #include "nbio_v7_4.h"
>   
> -#define SOC15_FLUSH_GPU_TLB_NUM_WREG		6
> -#define SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT	3
> +#define SOC15_FLUSH_GPU_TLB_NUM_WREG		8
> +#define SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT	5
>   
>   extern const struct amd_ip_funcs soc15_common_ip_funcs;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
