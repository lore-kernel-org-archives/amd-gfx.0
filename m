Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E210BE7849A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 10:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550B710E27B;
	Mon,  2 Oct 2023 10:31:27 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39A410E27B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 10:31:24 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3231d6504e1so12305725f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696242683; x=1696847483; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ncDZfhu7V3eL4c89Xhci/+l0ZVvy/hsrjqnKIjSUjFQ=;
 b=Q7Fk0rDFsJ0/T9ZlvUDv6IiiNq6MjgjhbCJ4K7PdvbPaQnq9yZd08W9MOPFeEPcgQo
 gQ67wYWd2nzyE9UvhtDSHsGNnei/juVBVB8RpniKEUS3RAePFEY5ee157b5GANpcIyQc
 apDTdqq1mDDWpAaWfDdk6gMK/R6VUZdka4YZHgN3whaGK3yv71zNOGz2RRXu4LHkwNGE
 ND5JBDiDjBH+Do7EmZf5tk/mxVZeR8ipJqCQq8MbvDlRi68laokwxIr8Olrw6YJER0zg
 jDuRSxY0Glwzy+Yx7sDoSxliJWvxs7MkKg7b1VoNWist+e/q4/j/LI/HR0PXiDwyZGfQ
 NCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696242683; x=1696847483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ncDZfhu7V3eL4c89Xhci/+l0ZVvy/hsrjqnKIjSUjFQ=;
 b=CzntqaLivPzmbCR5CyB/SFEVQPskEJIThfxuouhnucOJiLl3C+nSgq5/8a1By0gIVp
 WmbRXFBjHwLpzZ55rALFRh4LF38DuqzvqMCHEznpK9v+aRVJbijSvRFM99PvmtQqKCWc
 f+p+GlxuKU+K3a0bpujGF0nX996wNs+f9Pu6f5zgt7NWYESd7PtwCUmvA6ANOc6JRi3t
 gkNH0Z8am4TafJXOhKcvMto62Pw/DpanSOqfqJURQyA+K9jS8lfWcqbk0jNPZfuSLXfe
 ObyH5svparaThkV5nXBGhhv5vC2Cnl2QlhZLKcAdgTYb8e71cvZ4jfDEHPQcqDjbdKIL
 bXQw==
X-Gm-Message-State: AOJu0YwFQnE+afKxZNNlRiSbt26iZ7o8CmCLnys3O0iw358lolk/5EoD
 IlmffxtUMyI0CpV1YZuUahU=
X-Google-Smtp-Source: AGHT+IGNHjtzaEY9x07i4FrT+xArnKMWr2894aOVoGyxW9ADW+5K/otowFNyCe+ydFREAu20PBDqrA==
X-Received: by 2002:adf:e883:0:b0:322:dbc6:8cf7 with SMTP id
 d3-20020adfe883000000b00322dbc68cf7mr9926247wrm.16.1696242683043; 
 Mon, 02 Oct 2023 03:31:23 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 z7-20020adfec87000000b0032179c4a46dsm10220313wrn.100.2023.10.02.03.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 03:31:22 -0700 (PDT)
Message-ID: <a5c1fa06-db63-e1d3-1d99-94c0dda61657@gmail.com>
Date: Mon, 2 Oct 2023 12:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: Fix complex macros error
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230930063232.1317236-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230930063232.1317236-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.09.23 um 08:32 schrieb Srinivasan Shanmugam:
> Fixes the below:
>
> ERROR: Macros with complex values should be enclosed in parentheses
>
> WARNING: macros should not use a trailing semicolon
> +#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h        | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h          | 6 ++++--
>   4 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 73e825d20259..1ff2da1a5565 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1322,7 +1322,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
>   #define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
>   
> -#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
> +#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter))
>   
>   #define BIT_MASK_UPPER(i) ((i) >= BITS_PER_LONG ? 0 : ~0UL << (i))
>   #define for_each_inst(i, inst_mask)        \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index c60d2f79eeef..65aa218380be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -149,7 +149,7 @@
>   				       RAS_TABLE_HEADER_SIZE - \
>   				       RAS_TABLE_V2_1_INFO_SIZE) / RAS_TABLE_RECORD_SIZE)
>   
> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control))->adev
> +#define to_amdgpu_device(x) ((container_of(x, struct amdgpu_ras, eeprom_control))->adev)
>   
>   static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index a3eed90b6af0..0815c5a97564 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -33,7 +33,7 @@
>   #define AMDGPU_VCN_MAX_ENC_RINGS	3
>   
>   #define AMDGPU_MAX_VCN_INSTANCES	4
> -#define AMDGPU_MAX_VCN_ENC_RINGS  AMDGPU_VCN_MAX_ENC_RINGS * AMDGPU_MAX_VCN_INSTANCES
> +#define AMDGPU_MAX_VCN_ENC_RINGS  (AMDGPU_VCN_MAX_ENC_RINGS * AMDGPU_MAX_VCN_INSTANCES)
>   
>   #define AMDGPU_VCN_HARVEST_VCN0 (1 << 0)
>   #define AMDGPU_VCN_HARVEST_VCN1 (1 << 1)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> index af1a784696bd..c520b2fabfb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> @@ -62,7 +62,9 @@ int xgpu_ai_mailbox_add_irq_id(struct amdgpu_device *adev);
>   int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev);
>   void xgpu_ai_mailbox_put_irq(struct amdgpu_device *adev);
>   
> -#define AI_MAIBOX_CONTROL_TRN_OFFSET_BYTE SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF0_MAILBOX_CONTROL) * 4
> -#define AI_MAIBOX_CONTROL_RCV_OFFSET_BYTE SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF0_MAILBOX_CONTROL) * 4 + 1
> +#define AI_MAIBOX_CONTROL_TRN_OFFSET_BYTE \
> +	(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF0_MAILBOX_CONTROL) * 4)
> +#define AI_MAIBOX_CONTROL_RCV_OFFSET_BYTE \
> +	(SOC15_REG_OFFSET(NBIO, 0, mmBIF_BX_PF0_MAILBOX_CONTROL) * 4 + 1)
>   
>   #endif

