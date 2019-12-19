Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6EEC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 19:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AEE24672
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 19:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JpAKWZvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AEE24672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D2B6E3E1;
	Thu, 19 Dec 2019 19:47:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B467D6E3E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 19:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4fl37BqYCVVqMPXbG23zlhIwcp7TCYAZ/T4mSNwI5vhOYqpVrn+OHgnzbjPkYJv3ruHb2iPeT9THVS2AoC65lIr3w4XHMuNHMESrG+hWcDGGjqGQ7fd4zVRl6PS2MRgCwJ4wyJnMPm7rZAV2QkjMyYxPb+TedKoPbPRSJhYdH0UMnDHe53dAtYVvhJAtPaGMQOyENgSpZ5bFmsU7Z2tEh2QiXu+LAGB+wB/khHRtFLihUmE/f2CyHrVRN/Ddc6vE6U8f3rWGp774T0j3crD6idDoXNYGF1v2pD8mrD8v0LFhpQfOwGztmgtbTTB7K2LnHh18mkXBEZ3UcA3mpZXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJZaFleGtKRMrL4RXE9nx7/ERxMs97Noz/KFa+oMVMc=;
 b=VjudK9EAWAhXNNca7Q75WIhOO+mgECpMRn1+5ZJmgt2hxq211xuEtXjf5XIs4CiOxZCraaVAxu1Q5R4vsGGc1Hq1/laRk0z153SSYCGB0Q+Fl39MEzdWHUyo1+7/jp65x+xgIr3tkxHowLqb33/kRuPqDP3La1WKtr2fPn3c6KX0VjxaH1xP+YsL9ZlmqjbbREntJzG33ocIXN+qYFUaWB/I3TPiheFcPD4LQ7sD/YZST575iry0Dj9dOIGMyWQxIpyrA7mNJsRCV8rko+0U4OGbDPouylLSjbgY9BDTC/XG6PDiDGBVs5J58ny1qpjwl+5TNrxCLxAaXeNMEGOD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJZaFleGtKRMrL4RXE9nx7/ERxMs97Noz/KFa+oMVMc=;
 b=JpAKWZvux2PAUVktBW2ARTaVRGTrwbTyQpG4Lih5MFwbMlX3h8I1y9x1sStFjlafMLb/CYur7tQQ/fnyDT/TH6I5ge/8yJBkDUsJrJ1mRei5POOUUro6ceLh8P7mKpNnUCRxl+SuOo+GN8AsLxWKAiNkXd+cFr4Lp5KMWqHXMSw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB4203.namprd12.prod.outlook.com (10.141.187.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 19 Dec 2019 19:47:53 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 19:47:52 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V4)
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191219091623.3922-1-tianci.yin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <ae29000d-fb99-4846-6d66-3ce5f67013c5@amd.com>
Date: Thu, 19 Dec 2019 14:47:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <20191219091623.3922-1-tianci.yin@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: BN7PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:408:20::27) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 804deccd-ffbb-43dc-c679-08d784bc55d2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:|DM6PR12MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42032C0331EC0CC1464B42EE99520@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39850400004)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(6512007)(81166006)(8936002)(8676002)(31696002)(52116002)(2616005)(86362001)(6506007)(53546011)(26005)(44832011)(81156014)(6486002)(6666004)(478600001)(5660300002)(36756003)(66476007)(66946007)(66556008)(31686004)(54906003)(4001150100001)(186003)(4326008)(2906002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4203;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HeGaqfMoAyk8ypWWLh+hsIVm059BcJjOe6pspUBoQl6xUpm8KLcjzw+mrWFVmFEeGAByI5OTgKtAnkTsPXJWj59IIWrcW6ewNyUlywCtEFD10Wwmz3QHjalPlEeYsZkzEhZbVBKRaOcJ51dUCFyAxdvNIWlcyZCVGaj+K6+ibwbNe+FBnT7yYCcYukJkSTkBi4+LBGrxMQ/5V3dDsYcBKmNWi+M5V5NCorPJoBNxWvojyZOV8XMx3W6nFuOHV3rP5SnCd8X5wPGmNi1c6qPMSZLjmKGx2qaVxPTG8UK65lJtHcV2jco0XksqVW1Mmf1frCWBcSmVwFn8drIP4KyEF4skKw2De8luYh78cWiMd5bHo8WeScTy/hxlrHonkZNnTLwkb8JMTI6j74V4gKoRCXfmXZcIbe35Q3ykUFgpubYK2Tt1Uvuc6vJcqobQUDI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804deccd-ffbb-43dc-c679-08d784bc55d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 19:47:52.7028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00NCiGiymHiAZQoAzoB640K6jyMoupjzH3s4RuoCLfhMLU5uzmEQerckOEVPP6yv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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
Cc: Long Gang <Gang.Long@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yep! That's perfect--good job!

Regards,
Luben

On 2019-12-19 04:16, Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> The method of getting fb_loc changed from parsing VBIOS to
> taking certain offset from top of VRAM
> 
> Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 ++-----------------
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
>  drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
>  7 files changed, 23 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a78a363b1d71..fa2cf8e7bc07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -642,9 +642,8 @@ struct amdgpu_fw_vram_usage {
>  	struct amdgpu_bo *reserved_bo;
>  	void *va;
>  
> -	/* Offset on the top of VRAM, used as c2p write buffer.
> +	/* GDDR6 training support flag.
>  	*/
> -	u64 mem_train_fb_loc;
>  	bool mem_train_support;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index 9ba80d828876..fdd52d86a4d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -2022,7 +2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
>  	if (adev->is_atom_fw) {
>  		amdgpu_atomfirmware_scratch_regs_init(adev);
>  		amdgpu_atomfirmware_allocate_fb_scratch(adev);
> -		ret = amdgpu_atomfirmware_get_mem_train_fb_loc(adev);
> +		ret = amdgpu_atomfirmware_get_mem_train_info(adev);
>  		if (ret) {
>  			DRM_ERROR("Failed to get mem train fb location.\n");
>  			return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index ff4eb96bdfb5..58f9d8c3a17a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -525,16 +525,12 @@ static int gddr6_mem_train_support(struct amdgpu_device *adev)
>  	return ret;
>  }
>  
> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
>  {
>  	struct atom_context *ctx = adev->mode_info.atom_context;
> -	unsigned char *bios = ctx->bios;
> -	struct vram_reserve_block *reserved_block;
> -	int index, block_number;
> +	int index;
>  	uint8_t frev, crev;
>  	uint16_t data_offset, size;
> -	uint32_t start_address_in_kb;
> -	uint64_t offset;
>  	int ret;
>  
>  	adev->fw_vram_usage.mem_train_support = false;
> @@ -569,32 +565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	reserved_block = (struct vram_reserve_block *)
> -		(bios + data_offset + sizeof(struct atom_common_table_header));
> -	block_number = ((unsigned int)size - sizeof(struct atom_common_table_header))
> -		/ sizeof(struct vram_reserve_block);
> -	reserved_block += (block_number > 0) ? block_number-1 : 0;
> -	DRM_DEBUG("block_number:0x%04x, last block: 0x%08xkb sz, %dkb fw, %dkb drv.\n",
> -		  block_number,
> -		  le32_to_cpu(reserved_block->start_address_in_kb),
> -		  le16_to_cpu(reserved_block->used_by_firmware_in_kb),
> -		  le16_to_cpu(reserved_block->used_by_driver_in_kb));
> -	if (reserved_block->used_by_firmware_in_kb > 0) {
> -		start_address_in_kb = le32_to_cpu(reserved_block->start_address_in_kb);
> -		offset = (uint64_t)start_address_in_kb * ONE_KiB;
> -		if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
> -			offset -= ONE_MiB;
> -		}
> -
> -		offset &= ~(ONE_MiB - 1);
> -		adev->fw_vram_usage.mem_train_fb_loc = offset;
> -		adev->fw_vram_usage.mem_train_support = true;
> -		DRM_DEBUG("mem_train_fb_loc:0x%09llx.\n", offset);
> -		ret = 0;
> -	} else {
> -		DRM_ERROR("used_by_firmware_in_kb is 0!\n");
> -		ret = -EINVAL;
> -	}
> -
> -	return ret;
> +	adev->fw_vram_usage.mem_train_support = true;
> +	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> index f871af5ea6f3..434fe2fa0089 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> @@ -31,7 +31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>  	int *vram_width, int *vram_type, int *vram_vendor);
> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev);
> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
>  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2ff63d0414c9..1515413fd356 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1687,6 +1687,14 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> +static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
> +{
> +       if ((vram_size & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
> +               vram_size -= ONE_MiB;
> +
> +       return ALIGN(vram_size, ONE_MiB);
> +}
> +
>  /**
>   * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation from memory training
>   *
> @@ -1705,7 +1713,7 @@ static int amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
> +	ctx->c2p_train_data_offset = amdgpu_ttm_training_get_c2p_offset(adev->gmc.mc_vram_size);
>  	ctx->p2c_train_data_offset = (adev->gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);
>  	ctx->train_data_size = GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index f1ebd424510c..19eb3e8456c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
>  	unsigned long			offset;
>  };
>  
> +/* Definitions for constance */
> +enum amdgpu_internal_constants
> +{
> +	ONE_KiB	= 0x400,
> +	ONE_MiB	= 0x100000,
> +};
> +
>  extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
>  extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
>  
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index dd7cbc00a0aa..70146518174c 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
>    uint16_t  used_by_driver_in_kb; 
>  };
>  
> -/* This is part of vram_usagebyfirmware_v2_1 */
> -struct vram_reserve_block
> -{
> -	uint32_t start_address_in_kb;
> -	uint16_t used_by_firmware_in_kb;
> -	uint16_t used_by_driver_in_kb;
> -};
> -
> -/* Definitions for constance */
> -enum atomfirmware_internal_constants
> -{
> -	ONE_KiB	= 0x400,
> -	ONE_MiB	= 0x100000,
> -};
>  
>  /* 
>    ***************************************************************************
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
