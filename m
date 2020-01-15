Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34364C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 13:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2B92081E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 13:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1T6VfKIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2B92081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61336E9CD;
	Wed, 15 Jan 2020 13:09:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956496E9CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 13:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDKwJFlbmx1PFjpHz39QtzS1LCaLgvLbIpk24WCZIE1EuJZ9QQkvJ1P47Y3Z6f5oHEBh/kFKeGd8Rl7Avohi7unwmNxljzVFoMMPazplyo0Ea1uxOhpO7IKgsYbYbD3Q0cARRemZ0mjkKnUldCoOuuXlMIRK1oD1AnesriD1wiRNBiaujGBioIIIhehoHNg+Kr1fsuQqQscWrTi3n4d+CsE9buPOJAIio7xcblBsviDQkhtyUs2ibXyG1efZ0Wx9DVxwPIEF9AE9TULUw7Z8fae0eXAPyL9I/2b4i2wLrPMZESyQr05td8acJ1QuakhR2FDcA+wTdBtV6EgThk+lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jT6jU9VbJFqQxVjFl+GlnXs4dOytzqhTUM65GGVC14=;
 b=BRzxtDwkXirf98n00lU9vhXMY7pgn/UC+6o454c8DXJNvN4I8pGBFfRwJxjP5jl/GvL14JBOG1KrrR1UuWlgs0LlgRVGzCuNjdskhqcenXS3xQGpgiM84qhSld0qewXByduKbr123c2x1Dxzu/ZfYopuBgdNQPgto8g+DEuCJUuGxbA/f8yQPlSV86CcbJsVIW6WZAn/gs23jOh4NQ6SsQpjvVnfui8I00GisdzSNTzIerzRyKfvl5U4BswoXAbjIKo5wOv8FoCQbT12OuMJCwNRmzTQdsiou+xExlbgEZ6KPbY5IaylRxQ52KdYHX0ggjwtaZDcNAbXoXl1A/h+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jT6jU9VbJFqQxVjFl+GlnXs4dOytzqhTUM65GGVC14=;
 b=1T6VfKIZQF464tMCYF63OlxqocmqJbRTQKI1xrLUVaP3yyvcv8xRM/yHRGq+qiSNii0/X1BbqJcpFWjtCGctooe4MoubLoJyMibVqXAhpp7Hh7Y0JFJRxpYroKN1SIJOiQsUzuOmD8BnUseeuBHle+O/dKm42uwzqWtsC/YKdqw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3579.namprd12.prod.outlook.com (20.178.31.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 13:09:35 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 13:09:35 +0000
Subject: Re: [PATCH v3 2/5] drm/amdgpu/vcn2.5: support multiple instance
 direct SRAM read and write
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579040596-12728-1-git-send-email-James.Zhu@amd.com>
 <1579040596-12728-3-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <d95913d8-01a2-f3f8-2025-c1249434df12@amd.com>
Date: Wed, 15 Jan 2020 08:09:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1579040596-12728-3-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 15 Jan 2020 13:09:34 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 772a6164-6368-4958-736b-08d799bc2a99
X-MS-TrafficTypeDiagnostic: DM6PR12MB3579:|DM6PR12MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB357984C1FA90FB78FA866ACEE5370@DM6PR12MB3579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(6486002)(31686004)(30864003)(52116002)(31696002)(16576012)(36916002)(86362001)(2906002)(8936002)(478600001)(16526019)(316002)(26005)(8676002)(36756003)(81156014)(81166006)(5660300002)(4326008)(66476007)(186003)(956004)(2616005)(53546011)(44832011)(66556008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3579;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFxUnH7UcTHulVUx0Ab77I3Gx2/bCnEEsMpgbg0+5C9w7Q48EM0KagUM8iv83SeSNZW3vzgOQc0ghYVrDqNUa+lqESmi9YsjglI8UcmtGvB1Lnn6y9gEmo/BVf9Qty0y7qk/GNdCUQEXtKIzTfZkXTUBcqrGG7THhPkGR2HvywXj1x/AI7VZdhm6xoswt3FCYukzvqgNeZ8WhZho/oQhV88ZhAvIDqz8WpX5G19XF8H0uLQ1xg0yaZoYAu4ucbxMDqFEQeByhmKvNe8Ed7jRlWTIxHa6FeuWUOmD9C91sKxDBI80/udag0S+Y2DoUQ54ag0H+uN3ApyRoUlvvPxtxOySDNW92qxMrsDIA/VIc4itaIY537wfF22nHALnrH7pC3EDuXYsGm5rBHt8m1LhRwV4gKfhoNPcvYAoY/T2GCdh1oHhUlMIp82hesg0kOxn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772a6164-6368-4958-736b-08d799bc2a99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 13:09:35.0152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PEMANJiPZBrw1wUh10e/3eJaAEocdI2a6KoeRRpsRgbEYUmbzHttDBVG6DcwlpR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-01-14 5:23 p.m., James Zhu wrote:
> Add multiple instance direct SRAM read and write support for vcn2.5
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 46 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 94 ++++++++++++++++-----------------
>   3 files changed, 83 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 99df693..ca62d99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -165,15 +165,15 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
>   			return r;
>   		}
> -	}
>   
> -	if (adev->vcn.indirect_sram) {
> -		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
> -			    AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.dpg_sram_bo,
> -			    &adev->vcn.dpg_sram_gpu_addr, &adev->vcn.dpg_sram_cpu_addr);
> -		if (r) {
> -			dev_err(adev->dev, "(%d) failed to allocate DPG bo\n", r);
> -			return r;
> +		if (adev->vcn.indirect_sram) {
> +			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
> +					AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].dpg_sram_bo,
> +					&adev->vcn.inst[i].dpg_sram_gpu_addr, &adev->vcn.inst[i].dpg_sram_cpu_addr);
> +			if (r) {
> +				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
> +				return r;
> +			}
>   		}
>   	}
>   
> @@ -186,15 +186,14 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   
>   	cancel_delayed_work_sync(&adev->vcn.idle_work);
>   
> -	if (adev->vcn.indirect_sram) {
> -		amdgpu_bo_free_kernel(&adev->vcn.dpg_sram_bo,
> -				      &adev->vcn.dpg_sram_gpu_addr,
> -				      (void **)&adev->vcn.dpg_sram_cpu_addr);
> -	}
> -
>   	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
>   		if (adev->vcn.harvest_config & (1 << j))
>   			continue;
> +		if (adev->vcn.indirect_sram) {
> +			amdgpu_bo_free_kernel(&adev->vcn.inst[i].dpg_sram_bo,
> +						  &adev->vcn.inst[i].dpg_sram_gpu_addr,
> +						  (void **)&adev->vcn.inst[i].dpg_sram_cpu_addr);
> +		}
>   		kvfree(adev->vcn.inst[j].saved_bo);
>   
>   		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 26c6623..63c55bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -104,27 +104,27 @@
>   		internal_reg_offset >>= 2;							\
>   	})
>   
> -#define RREG32_SOC15_DPG_MODE_2_0(offset, mask_en) 						\
> -	({ 											\
> -		WREG32_SOC15(VCN, 0, mmUVD_DPG_LMA_CTL, 					\
> -			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT | 				\
> -			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT | 				\
> -			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT)); 			\
> -		RREG32_SOC15(VCN, 0, mmUVD_DPG_LMA_DATA); 					\
> +#define RREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, mask_en) 						\
> +	({											\
> +		WREG32_SOC15(VCN, inst, mmUVD_DPG_LMA_CTL, 					\
> +			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
> +			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
> +			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
> +		RREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA);					\

Please keep the backslash aligned with those above and below.


Regards,

Leo



>   	})
>   
> -#define WREG32_SOC15_DPG_MODE_2_0(offset, value, mask_en, indirect)				\
> -	do { 											\
> -		if (!indirect) { 								\
> -			WREG32_SOC15(VCN, 0, mmUVD_DPG_LMA_DATA, value); 			\
> -			WREG32_SOC15(VCN, 0, mmUVD_DPG_LMA_CTL, 				\
> -				(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT | 			\
> -				 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT | 			\
> -				 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT)); 		\
> -		} else { 									\
> -			*adev->vcn.dpg_sram_curr_addr++ = offset; 				\
> -			*adev->vcn.dpg_sram_curr_addr++ = value; 				\
> -		} 										\
> +#define WREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, value, mask_en, indirect)				\
> +	do {											\
> +		if (!indirect) {								\
> +			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA, value);			\
> +			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 				\
> +				(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |			\
> +				 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |			\
> +				 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));		\
> +		} else {									\
> +			*adev->vcn.inst[inst_idx].dpg_sram_curr_addr++ = offset;				\
> +			*adev->vcn.inst[inst_idx].dpg_sram_curr_addr++ = value;				\
> +		}										\
>   	} while (0)
>   
>   enum engine_status_constants {
> @@ -173,6 +173,10 @@ struct amdgpu_vcn_inst {
>   	struct amdgpu_ring	ring_enc[AMDGPU_VCN_MAX_ENC_RINGS];
>   	struct amdgpu_irq_src	irq;
>   	struct amdgpu_vcn_reg	external;
> +	struct amdgpu_bo	*dpg_sram_bo;
> +	void			*dpg_sram_cpu_addr;
> +	uint64_t		dpg_sram_gpu_addr;
> +	uint32_t		*dpg_sram_curr_addr;
>   };
>   
>   struct amdgpu_vcn {
> @@ -184,10 +188,6 @@ struct amdgpu_vcn {
>   	struct dpg_pause_state pause_state;
>   
>   	bool			indirect_sram;
> -	struct amdgpu_bo	*dpg_sram_bo;
> -	void			*dpg_sram_cpu_addr;
> -	uint64_t		dpg_sram_gpu_addr;
> -	uint32_t		*dpg_sram_curr_addr;
>   
>   	uint8_t	num_vcn_inst;
>   	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index dcdc7ad..9ff59ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -356,88 +356,88 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
>   	/* cache window 0: fw */
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		if (!indirect) {
> -			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>   				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo), 0, indirect);
> -			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>   				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi), 0, indirect);
> -			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
>   		} else {
> -			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
> -			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
> -			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
>   		}
>   		offset = 0;
>   	} else {
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>   			upper_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
>   		offset = size;
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
>   			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
>   	}
>   
>   	if (!indirect)
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
>   	else
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
>   
>   	/* cache window 1: stack */
>   	if (!indirect) {
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>   			upper_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
>   	} else {
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
> -		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
>   	}
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
>   
>   	/* cache window 2: context */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>   		lower_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>   		upper_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
>   
>   	/* non-cache window */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
>   
>   	/* VCN global tiling registers */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
>   }
>   
> @@ -583,19 +583,19 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   		 UVD_CGC_CTRL__WCB_MODE_MASK |
>   		 UVD_CGC_CTRL__VCPU_MODE_MASK |
>   		 UVD_CGC_CTRL__SCPU_MODE_MASK);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
>   
>   	/* turn off clock gating */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
>   
>   	/* turn on SUVD clock gating */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
>   
>   	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
>   }
>   
> @@ -759,7 +759,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   	WREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS, tmp);
>   
>   	if (indirect)
> -		adev->vcn.dpg_sram_curr_addr = (uint32_t*)adev->vcn.dpg_sram_cpu_addr;
> +		adev->vcn.inst->dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst->dpg_sram_cpu_addr;
>   
>   	/* enable clock gating */
>   	vcn_v2_0_clock_gating_dpg_mode(adev, 0, indirect);
> @@ -768,11 +768,11 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
>   	tmp |= UVD_VCPU_CNTL__MIF_WR_LOW_THRESHOLD_BP_MASK;
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>   
>   	/* disable master interupt */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
>   
>   	/* setup mmUVD_LMI_CTRL */
> @@ -784,28 +784,28 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
>   		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
>   		0x00100000L);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
>   
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_MPC_CNTL),
>   		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
>   
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_MPC_SET_MUXA0),
>   		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>   		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>   		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
>   
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_MPC_SET_MUXB0),
>   		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>   		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>   		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
>   
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_MPC_SET_MUX),
>   		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> @@ -813,29 +813,29 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   
>   	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
>   
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
>   
>   	/* release VCPU reset to boot */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_SOFT_RESET), 0, 0, indirect);
>   
>   	/* enable LMI MC and UMC channels */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_LMI_CTRL2),
>   		0x1F << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT, 0, indirect);
>   
>   	/* enable master interrupt */
> -	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
> +	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
>   		UVD, 0, mmUVD_MASTINT_EN),
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.dpg_sram_cpu_addr));
> +		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
> +				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
> +					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
>   
>   	/* force RBC into idle state */
>   	rb_bufsz = order_base_2(ring->ring_size);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
