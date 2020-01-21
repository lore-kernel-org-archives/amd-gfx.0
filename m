Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EC7C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD6B21569
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 17:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PPVA4yvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD6B21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A496EDDE;
	Tue, 21 Jan 2020 17:40:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87F96EDDE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 17:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuBkRASazxCrMZPG28S+XdPddQdllel/abom2Iu5PmDOkmibIcTDTVSxYWk9AMuQm4L1EHx8lOVrvhVvPa7scx6ncOjreVmqTcpgeHjaUdY5yUPZzicjqWfNzXYBQqvHXsouIiqH++q/7puUt8MWEHSjStAE1LYplszxeXN/bkUjR0NQDsAP5OVPT8cf10av6Hi/5ikmjkuhvsO/qSH4vY5Home9goLlLxCnSvzsntp/lmSw0P2cCoBz4YdCe5E+Pd8D0FLv/iISzIFH8x336+fyUroB4Dohw18L5IAbf4mL42kJcpCPhuttbpT0zXWddSYxTuDfK53Nk48ZwZaA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inFw0QKCEbakZWDHQBIaKx4CE7I7nRTkzBvjNnGiQ3o=;
 b=DlR/x13sfWOvVicnK1i44/q7/oMZZw5ASHJmzrXR3ozMwgNR6gg2rsk3Uevz72RS/1BHJfIDWcOmp/XCdn5J8KpDwc4+FvqSit08nCSlB0rAWvu3vAP8zT/5k+lZilEInRKLz00MQzYwsiqvNUxf6MQBS60Jgr9OoJJ+4S5pjNE9WFoDYtRfi6CasSy1HvOKccR/gGlihmHRxeed1bLcTbauTtJQF2R5wE8OZqy8lOxbjfc4Bbpy+ZnZfcgpXnJjPog+SuFqUyh/AcpHIFFtc3NriJb7CBORQcZ31pNtLQDx67roHNzLePsipJyTYIYHSGIvTyO7QGqL8IDwNW18QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inFw0QKCEbakZWDHQBIaKx4CE7I7nRTkzBvjNnGiQ3o=;
 b=PPVA4yvKEuiceskGjcaF/E7Gv4PA8Wp+xIUAFwyYKYbC8rDqvcP8blu0aCAwMUa/EUzd9wfPEjKSbnB8Hnil+iNyQgIbfSG/ZiijHvFanwY5SFmDol3k45aK6OB5yaBohl+xo5x0orpQ+7XZjnCEb5nxgLpRlAeVAHvX0FIGtdQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB2923.namprd12.prod.outlook.com (20.179.104.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 17:40:25 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 17:40:25 +0000
Subject: Re: [PATCH 3/4] drm/amdgpu/vcn: fix vcn2.5 instance issue
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-3-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <2a8c4f6f-2238-1f63-fd5a-b2e5623bc789@amd.com>
Date: Tue, 21 Jan 2020 12:40:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1579623556-30941-3-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Tue, 21 Jan 2020 17:40:25 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dcfe170-260a-4763-4487-08d79e98ff92
X-MS-TrafficTypeDiagnostic: DM6PR12MB2923:|DM6PR12MB2923:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2923DA9D1693622D45A212B3E50D0@DM6PR12MB2923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(66946007)(66556008)(66476007)(81166006)(8936002)(16526019)(6486002)(31686004)(186003)(26005)(44832011)(956004)(2616005)(4326008)(2906002)(31696002)(53546011)(316002)(30864003)(81156014)(36916002)(52116002)(36756003)(478600001)(8676002)(86362001)(16576012)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2923;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQMrD5O6mEBd3Zltrhw6reyU//HjZ/EZHWbY30lnNpcmhr6C3AFoGd4s7/FL46FUfk06K+DEWmN1gYXAPVtt7fVHpMGb6szoUwvAzDvDBnoZbRjzvGeuXVc/RtUhu05Ma7KkxMfUNWTYYYeXg1Qqp11jsPbSPg0cJNubHTCQoBd3M0RJ0XWDM0IzIUHSZca/2dQMGAzAx2F7hl0QGrGWWYVVDvZ6ZC23i44MJUY0Og/L7S3hS5KtmBGqYCzibUztGOdp3HVIQhWI2ELxNcOOwRC3UM2fHxZi6NvnWwzr+hOrp1PLu01EUVsPXxdnH2Vt5u8xPvCmMQIGkDG7e/B0BS1PEzzrWqOX2lVmUkOJObyTR3qH0/yV/uOjkXJRRxoBLBCLR2ubu48KRDyFfk3HbRZchwhghKX4aUpPYE6K6Xurvyk8zNbzfvZovOkYhNpL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcfe170-260a-4763-4487-08d79e98ff92
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 17:40:25.8396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsExrSLLBtqVj6yATu6WzCaJoAeUMdW6WGWn9CMDV+cNIUZFfB2f5ormhSOviiXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2923
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


On 2020-01-21 11:19 a.m., James Zhu wrote:
> Fix vcn2.5 instance issue, vcn0 and vcn1 have same register offset
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 86 ++++++++++++++++----------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 88 ++++++++++++++++-----------------
>   3 files changed, 89 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index c4984c5..60fe3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -86,12 +86,12 @@
>   			(sram_sel << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT)); 		\
>   	} while (0)
>   
> -#define SOC15_DPG_MODE_OFFSET_2_0(ip, inst, reg) 						\
> +#define SOC15_DPG_MODE_OFFSET_2_0(ip, reg) 							\
>   	({											\
>   		uint32_t internal_reg_offset, addr;						\
>   		bool video_range, aon_range;							\
>   												\
> -		addr = (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg);		\

This is based the soc15_common.h

#define SOC15_REG_OFFSET(ip, inst, reg) 
(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)

You are saying that is not right offset for 2nd instance?


Leo


> +		addr = (adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg);			\
>   		addr <<= 2; 									\
>   		video_range = ((((0xFFFFF & addr) >= (VCN_VID_SOC_ADDRESS_2_0)) && 		\
>   				((0xFFFFF & addr) < ((VCN_VID_SOC_ADDRESS_2_0 + 0x2600)))));	\
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e2ad5afe..ad11c8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -352,88 +352,88 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		if (!indirect) {
>   			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>   				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo), 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>   				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi), 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
> +				UVD, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
>   		} else {
>   			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
> +				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
> +				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
> +				UVD, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
>   		}
>   		offset = 0;
>   	} else {
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +			UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +			UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>   			upper_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
>   		offset = size;
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
> +			UVD, mmUVD_VCPU_CACHE_OFFSET0),
>   			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
>   	}
>   
>   	if (!indirect)
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
> +			UVD, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
>   	else
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
> +			UVD, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
>   
>   	/* cache window 1: stack */
>   	if (!indirect) {
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
> +			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
> +			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>   			upper_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
> +			UVD, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
>   	} else {
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
> +			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
> +			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
> +			UVD, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
>   	}
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
> +		UVD, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
>   
>   	/* cache window 2: context */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
> +		UVD, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>   		lower_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
> +		UVD, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>   		upper_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
> +		UVD, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
> +		UVD, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
>   
>   	/* non-cache window */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
> +		UVD, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
> +		UVD, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
> +		UVD, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
> +		UVD, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
> +		UVD, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
>   }
>   
>   /**
> @@ -579,19 +579,19 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   		 UVD_CGC_CTRL__VCPU_MODE_MASK |
>   		 UVD_CGC_CTRL__SCPU_MODE_MASK);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
> +		UVD, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
>   
>   	/* turn off clock gating */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
> +		UVD, mmUVD_CGC_GATE), 0, sram_sel, indirect);
>   
>   	/* turn on SUVD clock gating */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
> +		UVD, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
>   
>   	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
> +		UVD, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
>   }
>   
>   /**
> @@ -764,11 +764,11 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
>   	tmp |= UVD_VCPU_CNTL__MIF_WR_LOW_THRESHOLD_BP_MASK;
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
> +		UVD, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>   
>   	/* disable master interupt */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
> +		UVD, mmUVD_MASTINT_EN), 0, 0, indirect);
>   
>   	/* setup mmUVD_LMI_CTRL */
>   	tmp = (UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> @@ -780,28 +780,28 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
>   		0x00100000L);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
> +		UVD, mmUVD_LMI_CTRL), tmp, 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_MPC_CNTL),
> +		UVD, mmUVD_MPC_CNTL),
>   		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_MPC_SET_MUXA0),
> +		UVD, mmUVD_MPC_SET_MUXA0),
>   		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>   		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>   		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_MPC_SET_MUXB0),
> +		UVD, mmUVD_MPC_SET_MUXB0),
>   		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>   		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>   		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_MPC_SET_MUX),
> +		UVD, mmUVD_MPC_SET_MUX),
>   		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
> @@ -809,22 +809,22 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
> +		UVD, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
> +		UVD, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
>   
>   	/* release VCPU reset to boot */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_SOFT_RESET), 0, 0, indirect);
> +		UVD, mmUVD_SOFT_RESET), 0, 0, indirect);
>   
>   	/* enable LMI MC and UMC channels */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_LMI_CTRL2),
> +		UVD, mmUVD_LMI_CTRL2),
>   		0x1F << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT, 0, indirect);
>   
>   	/* enable master interrupt */
>   	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, 0, mmUVD_MASTINT_EN),
> +		UVD, mmUVD_MASTINT_EN),
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 740a291..42ca36c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -435,88 +435,88 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		if (!indirect) {
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>   				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>   				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
> +				UVD, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
>   		} else {
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
> +				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
> +				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
>   			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
> +				UVD, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
>   		}
>   		offset = 0;
>   	} else {
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +			UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +			UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>   			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
>   		offset = size;
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0),
> +			UVD, mmUVD_VCPU_CACHE_OFFSET0),
>   			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
>   	}
>   
>   	if (!indirect)
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
> +			UVD, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
>   	else
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
> +			UVD, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
>   
>   	/* cache window 1: stack */
>   	if (!indirect) {
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
> +			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
> +			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>   			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
> +			UVD, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
>   	} else {
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
> +			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
> +			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
>   		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
> +			UVD, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
>   	}
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
> +		UVD, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
>   
>   	/* cache window 2: context */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
> +		UVD, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>   		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
> +		UVD, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>   		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
> +		UVD, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
> +		UVD, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
>   
>   	/* non-cache window */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
> +		UVD, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
> +		UVD, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
> +		UVD, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
> +		UVD, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
> +		UVD, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
>   }
>   
>   /**
> @@ -670,19 +670,19 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   		 UVD_CGC_CTRL__VCPU_MODE_MASK |
>   		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
> +		UVD, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
>   
>   	/* turn off clock gating */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_CGC_GATE), 0, sram_sel, indirect);
> +		UVD, mmUVD_CGC_GATE), 0, sram_sel, indirect);
>   
>   	/* turn on SUVD clock gating */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
> +		UVD, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
>   
>   	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
> +		UVD, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
>   }
>   
>   /**
> @@ -772,11 +772,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
>   	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
> +		UVD, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>   
>   	/* disable master interupt */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MASTINT_EN), 0, 0, indirect);
> +		UVD, mmUVD_MASTINT_EN), 0, 0, indirect);
>   
>   	/* setup mmUVD_LMI_CTRL */
>   	tmp = (0x8 | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> @@ -788,28 +788,28 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
>   		0x00100000L);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_CTRL), tmp, 0, indirect);
> +		UVD, mmUVD_LMI_CTRL), tmp, 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MPC_CNTL),
> +		UVD, mmUVD_MPC_CNTL),
>   		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MPC_SET_MUXA0),
> +		UVD, mmUVD_MPC_SET_MUXA0),
>   		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>   		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>   		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MPC_SET_MUXB0),
> +		UVD, mmUVD_MPC_SET_MUXB0),
>   		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>   		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>   		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MPC_SET_MUX),
> +		UVD, mmUVD_MPC_SET_MUX),
>   		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
> @@ -817,26 +817,26 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
>   
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
> +		UVD, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
> +		UVD, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
>   
>   	/* enable LMI MC and UMC channels */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_LMI_CTRL2), 0, 0, indirect);
> +		UVD, mmUVD_LMI_CTRL2), 0, 0, indirect);
>   
>   	/* unblock VCPU register access */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
> +		UVD, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
>   
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
> +		UVD, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>   
>   	/* enable master interrupt */
>   	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
> -		UVD, inst_idx, mmUVD_MASTINT_EN),
> +		UVD, mmUVD_MASTINT_EN),
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
