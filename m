Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA633C33CAA
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 22:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800B424653
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 22:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nOKxW0xO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800B424653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A48D6E48C;
	Tue, 21 Jan 2020 22:32:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4125E6E48C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 22:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAwbtPyN//DO4qVZH0/JVLJ89jideEukIeaTgfGihzbLXBRRFUmySLwX9RyN5MhTatnwDCFUvTnwLODGJXULKzF6gocOdmHgbdr8DivUy5vxFV0iDujQBAwKBvLnEPhM03ZlFtxX2UFsGfEWsHi5ccFk1MqTqzUY3T5hIVe0Ml8cN7rD4AGprUDxPUWbyr374iRnuagpBOkBFVBK4MrSikgyPgFz4yxZe4dr5WVgPw17WJgBh4/lYkpCVuqf11vfn+0HIDhggtuNcCrDO4SvzwAAMSekREm9YEvHphP2QhG2Vz0yViMS9uvHofh24I+GNPt8IV3QjS+/Uop/0291iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SJM9oKUHHyIaUP1icKnQQZ/vmCaHhC9bYRHBMJ6o4E=;
 b=ddImwbNOP4dRT8br47Lq7L3OxNcnB/eqUOyfVqlb+NUh5GL7cooNHKJyVaPYO4Sa3D/M5r6lTEA8yh9ENIqEyK3g6x6Dnj30lMHAKK+HCxgpO7vpXrzxb9xOXfyolsjSfbCyRC5x5YLfOvuIF4VAzeNcd/DCNukm4m78b/pykU9W+oov8wRQn3VX6ZYYpsEJIOF5+y7OTUeQH5dNHS3Ed0+c9amUawsvfbvUjxmA1U9qsznDgduzcyM1djlVp+BMGLdMI0TErAKDTvKPidXQwhspBdvouEOoASCK/h9400EOyffOjNx4JYymSL7qb9vSBX65Bv7Fj87+FovbXq55tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SJM9oKUHHyIaUP1icKnQQZ/vmCaHhC9bYRHBMJ6o4E=;
 b=nOKxW0xO0Chm5vZpCTjMhoIU0XJmecC8GsC3dobSgSp3ewTMvQ6CnYje3hEZX0uQI2Bd/cC3kmVqBEDLl0nlGPCclEowZ5euYBShvCB3IOfNfQoLs7kov+5v+krvVFHb16PmZ5qWas3HQDgbv/UL0lVQLu7l4frbUbg2ipUnw7s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB2747.namprd12.prod.outlook.com (20.176.116.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 22:32:41 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 22:32:41 +0000
Subject: Re: [PATCH v2 3/5] drm/amdgpu/vcn: fix vcn2.5 instance issue
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579623556-30941-3-git-send-email-James.Zhu@amd.com>
 <1579645319-12747-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <f1668831-0001-638e-d380-598fbb2d4b05@amd.com>
Date: Tue, 21 Jan 2020 17:32:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1579645319-12747-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::41) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 22:32:41 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ddb6641-e3cc-4a1e-a5cd-08d79ec1d396
X-MS-TrafficTypeDiagnostic: DM6PR12MB2747:|DM6PR12MB2747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27470EC247CA3A87BC15DFA1E50D0@DM6PR12MB2747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(956004)(86362001)(31696002)(2616005)(53546011)(16576012)(36916002)(5660300002)(316002)(36756003)(52116002)(478600001)(2906002)(8936002)(26005)(186003)(30864003)(66556008)(31686004)(66476007)(16526019)(66946007)(8676002)(6486002)(81156014)(81166006)(44832011)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2747;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBD9DrEdf3C4vGcVPUToA5sB2Cgl/zzRjJKC88+IRFGod5youArRIIs9JHYR+QruLcmjPC+XSWhv6iJd0x1AflhXUWg3u0rCYmaTwnBmQlvNrbWNbccAZ2tKU7wEKKGy5Oy3Da8JzgndRSUIBu33aQm18IzRIyjrZVmfWQwf+zKhpua9K/QPnTS+2JWjeqFZbZl5SckIqbvfHNLEeEaf0KVFa6BBWiEBPhNzf5xvt8DkkiUiKLGLWV4vWhSUh5Yn7YVSarW1E2zFXr+qJ5ny0pq5LuOJ5p5uHlmgwKoKocgiBCPN2n4rDMm64zmowdjAuG3B7QlBl7ZR+hgf2PfEeTP5eoKyfln7jCNOAF0S79ndJcfinZlyTmtrDqYT2+s0QHB+/vxtoTLtyRaKm2RZLESF0Nqh784fI3Y0UUDFi9S9Zm1CtLXLtUnMbVSClBHt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddb6641-e3cc-4a1e-a5cd-08d79ec1d396
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 22:32:41.3485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roD1q8gTA4Vr8Hqvmy05CKueZRolrPg05ufS3mP9wcasbtvDtn4z5iSpBPPXf7Vz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2747
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


On 2020-01-21 5:21 p.m., James Zhu wrote:
> Fix vcn2.5 instance issue, vcn0 and vcn1 have same register offset
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 88 ++++++++++++++++-----------------
>   2 files changed, 45 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index c4984c5..bf7f2aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -91,7 +91,7 @@
>   		uint32_t internal_reg_offset, addr;						\
>   		bool video_range, aon_range;							\
>   												\
> -		addr = (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg);		\
> +		addr = (adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg);			\

Why do you still have hard coded here? please have it reverted. With 
that fixed the patch is:

Reviewed-by: Leo Liu <leo.liu@amd.com>



>   		addr <<= 2; 									\
>   		video_range = ((((0xFFFFF & addr) >= (VCN_VID_SOC_ADDRESS_2_0)) && 		\
>   				((0xFFFFF & addr) < ((VCN_VID_SOC_ADDRESS_2_0 + 0x2600)))));	\
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 740a291..f513c6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -435,88 +435,88 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		if (!indirect) {
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>   				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>   				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
> +				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
>   		} else {
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
> +				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
> +				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
> +				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
>   		}
>   		offset = 0;
>   	} else {
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>   			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
>   		offset = size;
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0),
> +			UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
>   			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
>   	}
>   
>   	if (!indirect)
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
> +			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
>   	else
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
> +			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
>   
>   	/* cache window 1: stack */
>   	if (!indirect) {
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
> +			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
> +			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>   			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
> +			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
>   	} else {
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
> +			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
> +			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
> +			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
>   	}
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
> +		UVD, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
>   
>   	/* cache window 2: context */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
> +		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>   		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
> +		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>   		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
> +		UVD, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
> +		UVD, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
>   
>   	/* non-cache window */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
> +		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
> +		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
> +		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
> +		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
> +		UVD, 0, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
>   }
>   
>   /**
> @@ -670,19 +670,19 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   		 UVD_CGC_CTRL__VCPU_MODE_MASK |
>   		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
> +		UVD, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
>   
>   	/* turn off clock gating */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_CGC_GATE), 0, sram_sel, indirect);
> +		UVD, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
>   
>   	/* turn on SUVD clock gating */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
> +		UVD, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
>   
>   	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
> +		UVD, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
>   }
>   
>   /**
> @@ -772,11 +772,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
>   	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
> +		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>   
>   	/* disable master interupt */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MASTINT_EN), 0, 0, indirect);
> +		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
>   
>   	/* setup mmUVD_LMI_CTRL */
>   	tmp = (0x8 | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> @@ -788,28 +788,28 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
>   		0x00100000L);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_CTRL), tmp, 0, indirect);
> +		UVD, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MPC_CNTL),
> +		UVD, 0, mmUVD_MPC_CNTL),
>   		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MPC_SET_MUXA0),
> +		UVD, 0, mmUVD_MPC_SET_MUXA0),
>   		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>   		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>   		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MPC_SET_MUXB0),
> +		UVD, 0, mmUVD_MPC_SET_MUXB0),
>   		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>   		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>   		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MPC_SET_MUX),
> +		UVD, 0, mmUVD_MPC_SET_MUX),
>   		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
> @@ -817,26 +817,26 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
> +		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
> +		UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
>   
>   	/* enable LMI MC and UMC channels */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_CTRL2), 0, 0, indirect);
> +		UVD, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
>   
>   	/* unblock VCPU register access */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
> +		UVD, 0, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
>   
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
> +		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>   
>   	/* enable master interrupt */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MASTINT_EN),
> +		UVD, 0, mmUVD_MASTINT_EN),
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
