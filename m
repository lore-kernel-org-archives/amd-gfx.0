Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5310C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 13:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E81112292;
	Tue, 28 May 2024 13:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O8pb9ABN";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECF7112292
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 13:51:52 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-42017f8de7aso6080035e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716904310; x=1717509110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wlEcvxWVmeilIqIhgiWx0ujSlE6QJyR1R67RNMH55Cg=;
 b=O8pb9ABNNuTFGJ9p70WvlMjp6PS3kPiAFMDfeiXNQc2L/8nPd/5f5GLHNCoKTGndZI
 p9/5zf5dBy0ScPV3MhjalLq7XhJJ+eP1oqInYVzXhsWhOwTPhz4061WM0EjsFdxZk1pe
 7oFkUO4nv4jkA354tLklgoqYDXDo5erVk3w5oQd5K/nPqTzU6Dr2o2CeoWlqyiodDVUk
 TLpHfsdtx4y3SYUN4f7MeZ6irVKrlQnA6aAn2+EUOfEr/6qQVQ50LEUB6sf9l7rz9NqT
 8xLAkWyT3RzuHGQPR8CBRXCdcferdslgb7Uh03GvNNFC0YEmgS6BMYtAXQQJLGLI+dDJ
 4WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716904310; x=1717509110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wlEcvxWVmeilIqIhgiWx0ujSlE6QJyR1R67RNMH55Cg=;
 b=l8Uy8BERzbEJjx9v567Cz57xW3VD+DEPYhqS8hLe8RGiKLxmua+cVOWkiC4hyu2LCg
 Qudyz0qnu5pjRA0bClGFAClnRvNj5XW+kUXp71Q3EMcUZS0WZj/CCjJrrFGXMszTJgzG
 qdVO17u/71Phnjr3u219j5JqWI+1KVEoI9BHCMrTRyGIvrMW+mkjcZhfTm1h3gvm3FyH
 QjcJE4WZNXBPMEYB2Gsk4pAHP6/KrrSGWToeQj46t2nYKQbtvx5CwSLghRxC5YGCEUYu
 EWi28dwuyQcIAmRL3SQ2QzNomPKOhcDT/QQc1P9M7F3+wN9ynY8WSNKLgmtHQFbNh0+X
 v0Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1/kOLoIzUpGnHQoJbo3Pj2Vrp0W1sj377eTQx3JUe8UstaSiGeGvTZgAVJwSgBqX1oxspfoBT7cgZ/DFqam++Bwlf4qZDMWu3ilY5vA==
X-Gm-Message-State: AOJu0Ywf5rhgwANSCYZAoRZ74JCPTbdEFYjuZmF3Ji9tSu9SFRVJ3RAc
 nW3VswmzwTQ6+TFV643A/HgMTaQYNzEBn+4yOmVs6nS85Dn0aOEX
X-Google-Smtp-Source: AGHT+IG9LeCJa6UqNkdC1YyWd/yGOOljuYzGtWxVvKw1GTDKn3DZ0WNkXhxkJAge2hESrpFruS6rEg==
X-Received: by 2002:a05:600c:1d27:b0:421:21a8:fd77 with SMTP id
 5b1f17b1804b1-42121a8ffedmr965505e9.8.1716904309864; 
 Tue, 28 May 2024 06:51:49 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210897bbd2sm145453675e9.21.2024.05.28.06.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 06:51:49 -0700 (PDT)
Message-ID: <31066020-28b8-49cf-b86f-c8acc28b8c92@gmail.com>
Date: Tue, 28 May 2024 15:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add flags to distinguish vf/pf/pt mode
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com, hawking.zhang@amd.com, le.ma@amd.com,
 shiwu.zhang@amd.com, donald.cheung@amd.com, sepehr.khatir@amd.com,
 daniel.oliveira@amd.com, charis.poag@amd.com, Shuzhou.Liu@amd.com
References: <20240527162839.259865-1-asad.kamal@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240527162839.259865-1-asad.kamal@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.05.24 um 18:28 schrieb Asad Kamal:
> Add extra flag definition for ids_flag field to distinguish
> between vf/pf/pt modes
>
> v2: Updated kms driver minor version & removed pf check as default is 0
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  9 +++++++++
>   include/uapi/drm/amdgpu_drm.h           | 10 ++++++++++
>   3 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2da76fadf6ea..60d5758939ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -116,9 +116,10 @@
>    * - 3.55.0 - Add AMDGPU_INFO_GPUVM_FAULT query
>    * - 3.56.0 - Update IB start address and size alignment for decode and encode
>    * - 3.57.0 - Compute tunneling on GFX10+
> + * - 3.58.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
>    */
>   #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	57
> +#define KMS_DRIVER_MINOR	58
>   #define KMS_DRIVER_PATCHLEVEL	0
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 66782be5917b..260cd0ad286d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -869,6 +869,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
>   			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
>   
> +		if (amdgpu_passthrough(adev))
> +			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_PT <<
> +						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
> +						AMDGPU_IDS_FLAGS_MODE_MASK;
> +		else if (amdgpu_sriov_vf(adev))
> +			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_VF <<
> +						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
> +						AMDGPU_IDS_FLAGS_MODE_MASK;
> +
>   		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
>   		vm_size -= AMDGPU_VA_RESERVED_TOP;
>   
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 5b6c0055cfcf..ae3f4e275f20 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -754,6 +754,16 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>   #define AMDGPU_IDS_FLAGS_TMZ            0x4
>   #define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD 0x8
>   
> +/*
> + *  Query h/w info: Flag identifying VF/PF/PT mode
> + *
> + */
> +#define AMDGPU_IDS_FLAGS_MODE_MASK      0x300
> +#define AMDGPU_IDS_FLAGS_MODE_SHIFT     0x8
> +#define AMDGPU_IDS_FLAGS_MODE_PF        0x0
> +#define AMDGPU_IDS_FLAGS_MODE_VF        0x1
> +#define AMDGPU_IDS_FLAGS_MODE_PT        0x2
> +
>   /* indicate if acceleration can be working */
>   #define AMDGPU_INFO_ACCEL_WORKING		0x00
>   /* get the crtc_id from the mode object id? */

