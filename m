Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D53FD116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 13:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A3410E142;
	Mon,  1 Dec 2025 13:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1Jtfoao";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6740A10E33A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 08:30:51 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-297e982506fso51184065ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Dec 2025 00:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764577851; x=1765182651; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YRqx+zq6MV9VeTwc28uE5sAPkmHEV1/sluHR5vInZzw=;
 b=N1JtfoaoB958HQYPqLbM7GRxMTOUyxvjEkomeJ85xuZitcA9RY/zITGEeSREUBGKjQ
 Y5/RxHaP7WOun77phqJiTVfVKwUbVA6uNYAcggrrex3kNt24dUJZeIrnZKWk+Y3I1hA1
 Ay/HACpPTNUYa3X8XV4u+HCqGPiqvcStWMhpzT8ZpdCWcpC9dOsCIIzwkfCHK9ft9iu/
 r+6M4YdMTEnoHLJAm6PFu7g4/RkCU2DebfeBaDow1lHcPyXkXqgIppG3DPOrFvYPwl/6
 uxToOXqYIiasvLT0RCHR8G8KmCXGk+DOZu3/4CWqKX26zHp9kmZfv8nkE1wAzaisKMX7
 49dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764577851; x=1765182651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRqx+zq6MV9VeTwc28uE5sAPkmHEV1/sluHR5vInZzw=;
 b=JU4Lt8dr6OiGkGJkRLV/XC2neA4TotX9I2KtNUMb2xj6xUhPNZhI3cbDlj7jhVQO/4
 +31EIKt4TCr2gwRjEn4ogFg/4RqUDc7806cdS3QGJoRGSe3aCL0WE6XW+Gp0Cert9d64
 6rL7VXuAYaz1OK9+/e8ILPoytV60+Y4pJsrt/1Yxaql3YV+AUWIfcav8z18XMjl/2sLj
 xuknVZMz1R170tYRuqhALlHgwsuHICVgMdxV686ihzYo7ZIQNqIuJMF1cBoId4xUdY38
 YUdAscBvQxdbwknaXeLvRKnQRbi3cwVrqEL+XR+gqA12sDIoiOimloXMB/HdUwJlwcVs
 LX2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBanKyf66TiUfJm7n9/TrQYOPf4Ys4WdFBcpwByKJqHYsB83/16hu7EnElbEJyR36TKi662+95@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVQ5QI+xg0WKWkZco8XUNr/sUH6oVfdR/2NmSEbY6CdNd6N3pS
 7nFRYwyWKUyD2fEraIdhCEYxog+4diwWe/QtC8tkZ0YP6j8tkrlnxYCc
X-Gm-Gg: ASbGncvPVo1cgimx5pXNZoWDu6WEIcYfpw10umYG9NMi7p97AdYxyb+P3OdtVlMff25
 xCSaXiIb/HqXbCrAjXZuNxv7Hc6GVii/7rFzUxXqiDlgxmFgJs61xqyfU/T/6VRBMlcFewYovey
 u9KsLqlt1JhgwdULRshyOcfsozNupsp5s/LgyeRZCSNe1ERXTWIMs2co3OQx31ayi/MKJuVNOZp
 UGeefUACGJJRpl/ec0gRMPqMfWUBX+ZNyeHF0QTgem0nCCqbgvOagcsqneu/UAeTKLlMiJsZSqB
 rNxUxC6Ch+xH7rAkkoLnB8PoiBqbbjYzuXhw+akoXG2bacQU1huC4AQxQFETy5YAYEzhT3/9QjY
 ioBRu9TdwwGMIEeErCQVxiS5ScSazxL7YpMOpBQZhqgcNjYssLJM6MD/W9trScxJMoZx8PLR/Yy
 8swKSi+jWYJH+TltTu2JiG
X-Google-Smtp-Source: AGHT+IFW9UJkWdGVik+RSQYeEpxrY0mwOpthUJGwwDnRRi307Q5DK2ltXPn3UBb6Ty9M1AXX5CNwmg==
X-Received: by 2002:a17:902:d588:b0:29b:6845:6214 with SMTP id
 d9443c01a7336-29b6be8c872mr440193065ad.3.1764577850566; 
 Mon, 01 Dec 2025 00:30:50 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:2a71:e28f:ae3c:b20c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bce441e59sm116914635ad.33.2025.12.01.00.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 00:30:49 -0800 (PST)
Date: Mon, 1 Dec 2025 16:30:43 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, "Tsao, Anson" <anson.tsao@amd.com>,
 "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add helper to read UMA carveout info
Message-ID: <aS1SM0sENT510Feo@google.com>
References: <20251126-vram-carveout-tuning-for-upstream-v3-0-cf1729c4cb3c@amd.com>
 <20251126-vram-carveout-tuning-for-upstream-v3-2-cf1729c4cb3c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-vram-carveout-tuning-for-upstream-v3-2-cf1729c4cb3c@amd.com>
X-Mailman-Approved-At: Mon, 01 Dec 2025 13:53:38 +0000
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

Hi Leo and Mario,

On Wed, Nov 26, 2025 at 05:05:13PM +0800, Yo-Jung Leo Lin (AMD) wrote:
> Currently, the available UMA allocation configs in the integrated system
> information table have not been parsed. Add a helper function to retrieve
> and store these configs.
> 
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Yo-Jung Leo Lin (AMD) <Leo.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 32 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c         |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 77 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h |  2 +
>  4 files changed, 113 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9f9774f58ce1..6873c020b923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1675,6 +1675,38 @@ struct amdgpu_numa_info {
>  	int nid;
>  };
>  
> +#define MAX_UMA_OPTION_NAME	28
> +#define MAX_UMA_OPTION_ENTRIES	19
> +
> +#define AMDGPU_UMA_FLAG_AUTO	BIT(1)
> +#define AMDGPU_UMA_FLAG_CUSTOM	BIT(0)
> +
> +/**
> + * struct amdgpu_uma_carveut_option - single UMA carveout option

Nit: struct amdgpu_uma_carve*o*ut_option

> + * @name: Name of the carveout option
> + * @memory_carved_mb: Amount of memory carved in MB
> + * @flags: ATCS flags supported by this option
> + */
> +struct amdgpu_uma_carveout_option {
> +	char name[MAX_UMA_OPTION_NAME];
> +	uint32_t memory_carved_mb;
> +	uint8_t flags;
> +};
> +
> +/**
> + * struct amdgpu_uma_carveut_info - table of available UMA carveout options

Ditto: struct amdgpu_uma_carve*o*ut_info

Regards,
Kuan-Wei

> + * @num_entries: Number of available options
> + * @uma_option_index: The index of the option currently applied
> + * @update_lock: Lock to serialize changes to the option
> + * @entries: The array of carveout options
> + */
> +struct amdgpu_uma_carveout_info {
> +	uint8_t num_entries;
> +	uint8_t uma_option_index;
> +	struct mutex update_lock;
> +	struct amdgpu_uma_carveout_option entries[MAX_UMA_OPTION_ENTRIES];
> +};
> +
>  /* ATCS Device/Driver State */
>  #define AMDGPU_ATCS_PSC_DEV_STATE_D0		0
>  #define AMDGPU_ATCS_PSC_DEV_STATE_D3_HOT	3
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 610449d73a6c..92070738bd42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -38,6 +38,7 @@
>  #include "amdgpu_display.h"
>  #include "amd_acpi.h"
>  #include "atom.h"
> +#include "amdgpu_atomfirmware.h"
>  
>  /* Declare GUID for AMD _DSM method for XCCs */
>  static const guid_t amd_xcc_dsm_guid = GUID_INIT(0x8267f5d5, 0xa556, 0x44f2,
> @@ -125,6 +126,7 @@ struct amdgpu_atcs {
>  	acpi_handle handle;
>  
>  	struct amdgpu_atcs_functions functions;
> +	struct amdgpu_uma_carveout_info uma_info;
>  };
>  
>  static struct amdgpu_acpi_priv {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 636385c80f64..7f4751e5caaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -296,6 +296,83 @@ static int convert_atom_mem_type_to_vram_type(struct amdgpu_device *adev,
>  	return vram_type;
>  }
>  
> +static int amdgpu_atomfirmware_get_uma_carveout_info_v2_3(struct amdgpu_device *adev,
> +							  union igp_info *igp_info,
> +							  struct amdgpu_uma_carveout_info *uma_info)
> +{
> +	struct uma_carveout_option *opts;
> +	uint8_t nr_uma_options;
> +	int i;
> +
> +	nr_uma_options = igp_info->v23.UMACarveoutIndexMax;
> +
> +	if (!nr_uma_options)
> +		return -ENODEV;
> +
> +	if (nr_uma_options > MAX_UMA_OPTION_ENTRIES) {
> +		drm_dbg(adev_to_drm(adev),
> +			"Number of UMA options exceeds max table size. Options will not be parsed");
> +		return -EINVAL;
> +	}
> +
> +	uma_info->num_entries = nr_uma_options;
> +	uma_info->uma_option_index = igp_info->v23.UMACarveoutIndex;
> +
> +	opts = igp_info->v23.UMASizeControlOption;
> +
> +	for (i = 0; i < nr_uma_options; i++) {
> +		if (!opts[i].memoryCarvedGb)
> +			uma_info->entries[i].memory_carved_mb = 512;
> +		else
> +			uma_info->entries[i].memory_carved_mb = (uint32_t)opts[i].memoryCarvedGb << 10;
> +
> +		uma_info->entries[i].flags = opts[i].uma_carveout_option_flags.all8;
> +		strscpy(uma_info->entries[i].name, opts[i].optionName, MAX_UMA_OPTION_NAME);
> +	}
> +
> +	return 0;
> +}
> +
> +int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev,
> +					      struct amdgpu_uma_carveout_info *uma_info)
> +{
> +	struct amdgpu_mode_info *mode_info = &adev->mode_info;
> +	union igp_info *igp_info;
> +	u16 data_offset, size;
> +	u8 frev, crev;
> +	int index;
> +
> +	if (!(adev->flags & AMD_IS_APU))
> +		return -ENODEV;
> +
> +	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> +					    integratedsysteminfo);
> +
> +	if (!amdgpu_atom_parse_data_header(mode_info->atom_context,
> +					  index, &size,
> +					  &frev, &crev, &data_offset)) {
> +		return -EINVAL;
> +	}
> +
> +	igp_info = (union igp_info *)
> +			(mode_info->atom_context->bios + data_offset);
> +
> +	switch (frev) {
> +	case 2:
> +		switch (crev) {
> +		case 3:
> +			return amdgpu_atomfirmware_get_uma_carveout_info_v2_3(adev, igp_info, uma_info);
> +		break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +	return -ENODEV;
> +}
> +
>  int
>  amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>  				  int *vram_width, int *vram_type,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> index 649b5530d8ae..67c8d105729b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> @@ -32,6 +32,8 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>  	int *vram_width, int *vram_type, int *vram_vendor);
> +int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev,
> +					      struct amdgpu_uma_carveout_info *uma_info);
>  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
>  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
> 
> -- 
> 2.43.0
> 
> 
