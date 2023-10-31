Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE65EC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 04:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1BCB10E3EC;
	Tue, 31 Oct 2023 04:00:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FC910E3EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 04:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn9C1wGJBcHL250BuCT9fhXQ7q949ECUSXovM1aEJTXXF9fAycup5Ka2uR/YTi1T+0BZcKtmlVs7H3l+U1kjrpCgZwUm3H2hQX8Zd83JBkFP7ycdFQUXYCOVoNSEN3okrFp6dPE9o/8JUzYlSuqAPqxu7x/KZzwys+rE/vIyfvKjPLlnY9IRSzhSHDF3oDLp5nkDyag4yIDrZYKJBT8QkTZWzWAipTP0lFJGe+agCUygCU0nRf8Wog/etSKJ+O+vhEMX+QZsQbqnqC6vWuhUCpSxvhbXVD5ZkVkK/JUz+FqMGeczihVHjZUkhPM7XTjIvxjuGtR9hW+MSqdHywx3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfMKhPllKyEbtbRFaGFK17gLiNHFhqYuM4yHfU2FRAc=;
 b=NsVICicXGRaWPsCEXslH2/Ilpjp8jps14pr8mRp2SfO2hTgD12M5n+cw39miaSe8YJ1IPKHVc36zjifomS2jCCK3DMj+oqOE3+MgD7mr+aZQe3SwCT7HBpI5mF12sxvBDydH4dMJwOeL1ntju4jOzEW1OoWz3mjHp8POx62uO6hhDWtOWE7VU4HYNFNAhginf0NGpLpkXGlaOQqXip1Y8hWzxBdLcRF4m1e+Jlh6zuKnmS29kOkX9tpLCC5GAmele5rV6VpaeRQ3LSBpITx53gnmHxIGMCved+zSCNNx3Eev2nqDzzCN/jOzD2bsUljv0X+LEOMIozNDY5/4uvQP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfMKhPllKyEbtbRFaGFK17gLiNHFhqYuM4yHfU2FRAc=;
 b=c2jbQDUoKOuFhDuctEHkBj6vltC0wZlUonuO89FuweMCwRScAn47ncNso3SAZmpNOtOhhTvx47674gD+GXItSP145YLKsNbvvaHk34JRGarCswWkgjZcJ5Qx+lqECuWygiEDzfamwz6QfsF9zF0O6/eydAKsUAEkbRXK4m6Mnzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 03:59:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8b0b:3c38:b988:ca27]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8b0b:3c38:b988:ca27%3]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 03:59:57 +0000
Message-ID: <a69f99f0-881a-1b52-1e29-4cb6b2bc1994@amd.com>
Date: Tue, 31 Oct 2023 09:29:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Add xcc instance parameter to
 *REG32_SOC15_IP_NO_KIQ (v3)
Content-Language: en-US
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <3ef27e68-be40-fce4-1f04-680ee74833d8@amd.com>
 <20231027200614.2249-1-victorchengchi.lu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231027200614.2249-1-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BL0PR12MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9ac308-d158-4ee4-7c4e-08dbd9c5d8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HKKWmPuciJBjgsWkotZhTtU8sVN1QPNmHRYH9bVh6Q4nBtG6jynjIqx4FDe+ob2pMRBrbGR+Wx1dUrzA90hrf5vg1kS34tbip7aa/l/a47yyfB8VswHz5S4JZ9mmfX7v3Ep2+lVYJhEP+m9jgCyFhP9DWFUr4lXBjMq6ezez16KS+XoKM00Ww/OXaRgAuvbcB0J7J+1LFlwb8lSzaoNVWv865aWTDw9s0prcr3C71l3W50jgjF0UQpUUWcw/yDSFAzuOMkhxh1MaYoaDOnxosWuW+wcWBy70yDVXEc4SFzU1ttilqonGJ/IPrjYVTs94zOzxebmizh0FE6ObGzNc5hvNUFNwQs5ueP7Lm/2jay3aRmpErtWeDX/CiVeUa1IT6aZDuOSrTAG+34Ciu8B2nLJrOk0ofq1LhHZGqjbvhnfzmiMVHLGyE2VhcW04feiaWrhZjgGdrQ3an7JSaKXAeezCrH518X22yj6VZko/KoNEC6Arx9/uHZfq4h795L/UmobvNqbW3udfKXKFHSDURs80xsEmRdcyT1D94x+sdWU98XLKvk3vCbNZSe1a9cLP/hTgnSFJgnmnuxpC4FPE6jCZoti70+7Uy0++X+6TxtS9mlcUVqXuTyXvCQ7wecxUtw+KNasPG6zKc7Js+X17w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(6512007)(26005)(2616005)(38100700002)(31696002)(86362001)(36756003)(2906002)(6486002)(83380400001)(6506007)(53546011)(478600001)(6666004)(8936002)(8676002)(4326008)(316002)(66476007)(5660300002)(66946007)(66556008)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUhkVjhMN1daaXhVd2ZYWFFDa0lCbUNuTk1JdXVqUGFoTG5VdDVHV3A1bU51?=
 =?utf-8?B?M1lQcExZUzZ3YjM5RlFZY0g0QUNuUmYxaXpxbU00TUdqcFkxU2MwWkJaVXh1?=
 =?utf-8?B?ek1IaFdlNlNDRXQ0WkRLWWNUSzJ1M2NCdjNxSTZFclZOTmNhQnZxRTcvbnNV?=
 =?utf-8?B?SGcwTVlhOExmTTRBNkh4SjUxQXoxZ0ZTcDNWSk9wY0g1QmR2WWJkMS9NWGRB?=
 =?utf-8?B?SndraFdjdjFVMC92MVEvOW1YQlhpRXI5V083clM3bSsvbHA2elJHdjJtUE1z?=
 =?utf-8?B?SnNGR3FEKzhmN3I0Rk8vOWx2UjN5SndiNGNMRkpmbC9wU0VJZW5Tbkk0dEZq?=
 =?utf-8?B?b2JrVnNjUlByRjFuTkRWVU5Lb2JzeGNPZDdKdk1oeWtiV3BtVmgycVFlWG84?=
 =?utf-8?B?citjZUt3Sk00RGxkTEllSFBNeDc4TEppVUtDQUphNHdmNlkyeHBPS1dFZlFu?=
 =?utf-8?B?eTZLZ09zRmJNOStNVWVQOTlGaHVxVHlBVnhMeGlwbnBlTGF0V25naDJjVk1D?=
 =?utf-8?B?OGhOK2d3K2pENW5pMlYrZWlFUnd6S3MvUWduWCtxZXdtUnd2cERLd1R3eEhZ?=
 =?utf-8?B?VEtZSWltTzZ6NER5SURvbUxtZ1R2RXBSYTdVRjFsTjJLOEdyU1NiQzQzQmFL?=
 =?utf-8?B?K0dZL1NoZno1em51QjZkazJ4VWpKTDVzMU82c3BRSC8zczVTMEp6MXhYMG4w?=
 =?utf-8?B?Njd0Z1UwbHlINWNaRml2YVZnK2pFWDEvM05KOEJMVk9BRW1rWnVjdjYyVzF6?=
 =?utf-8?B?MkFQQjRoMzMxSmtEUXhqWWsrSnU5VFQxR2k4cmsraFNiUXRmUzF5K1RFNjFh?=
 =?utf-8?B?NXJNd1ZsRlBVY3RzeHNuRHpqYTdzcW8ySjd5V3NlSUJnMTlVZEJzVW55TGVp?=
 =?utf-8?B?dnloNFV6V1JZcFJXV0JkNytack1IREd6V1pWS0haQk5ZT3hIMjVlWU1KMy9j?=
 =?utf-8?B?VnNhTjJENkd1eWwxR1NSWXVrMEw1SXNnNW9tUDh5aUg1cVlGQTJSOUhSTlBz?=
 =?utf-8?B?eHFaSncyLzdnc2ViOExOcjdLMkhXSGQ3T3lZVjl3QTR5UWpSWTIxc3ZQdWJr?=
 =?utf-8?B?ZkxiZ1Mvci94MkFDbGY2MFM5ek4wQi91Ym9VVDJZQmlKeXhQTG1udUMzaDU4?=
 =?utf-8?B?Q1UrM240SG04YnlMakxwSjl6UW1lZEhZOFAvdmlHeXViSi84Ymk3eC9YY0Jr?=
 =?utf-8?B?eU1jMHlzT1I1eGdZUG9TTXlkdWtZVXFEdFpmVm9Qa093QTZZWXp1V2NNTFdG?=
 =?utf-8?B?Tnl0Q0dScWdxV0EvN3NxMWlDY2x3Y1BpSjA4blhjZnF0ZXVyNzdneExLQm9S?=
 =?utf-8?B?ZndMTDVpQnA1NUZvd3ZxNlVROEFnMVBmbzZPaWhBc2xmSFo2RUNiRUxHeWR5?=
 =?utf-8?B?R3JGZk9nbVc4OG1TaExIY3I0SzJISUhqcklmMTQxc1dFNUdGa1ZVbWNWQm5I?=
 =?utf-8?B?dUV2MHNhR01paFpkYUZwYS8xNHZpZjN2ejQyZDZhKzByai9CL0V3Q1ViWUZy?=
 =?utf-8?B?T3YyRXkxS2ptcjIwb0xWWDMrOVMrY3Y1cjJRemZvaVBXRnVyb0xTd0VsTVdC?=
 =?utf-8?B?bHNITUFtVFN4ZWRsVXh4SEFPczlUVnlQN0xLQ1dnRjlZRjRjZHM2QTFveEdy?=
 =?utf-8?B?RzBTTC9WWm80NDJiRk4ra2hSNWEwOFN2QWdqZnpOUURDdjd2V2paZVAxRWVI?=
 =?utf-8?B?UCs1cUtKYko2MWRVVk5pU3Q0Y21IbnZ0RCtVNHdkUVZ4YlpvTmNTWDZmVWxB?=
 =?utf-8?B?cGdwQmZ4dUtGa2c0VEI0SnNQR2J1dDVReU1oN3FLZVlsbHFKVTBNeVRMWUpy?=
 =?utf-8?B?TU9QMHJzSTBySU04bTBNaVBOMnF2Z2NtNDhLb3pNem5EWDZ2M3FWNmp2OG5G?=
 =?utf-8?B?aSticjJGWENocnVvSDJiZy9LQ1lZZm9LVGN5MmNGZDNNVUhmM1JTNmk2cnNt?=
 =?utf-8?B?M1J1RzhRYjQyTFk1SWdQaS9wK21RTU9wQ1BGaGdFME5OTVlzMnJxVSs2UFBv?=
 =?utf-8?B?aEgwUUNHYWMxemRpZ1Y0ekEzZ2lsTEhOcXphVVNhSS9pTE1aVnBVSTNLeGZv?=
 =?utf-8?B?YjVFMUdYVlBIeXVZbkg2eFhXT2EyV1YvK2FCbktHaS9yYjI2S1hZWWxJOHd2?=
 =?utf-8?Q?hHdlwWFZZowa45k0vIgxgvDdf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9ac308-d158-4ee4-7c4e-08dbd9c5d8a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 03:59:57.3240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3CClNApnY4ikAVppSbek3Ppl6j1AkfUuyqaOBCQPYfndhe2b6VEqLEH+xpq8zKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
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
Cc: davis.ming@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/28/2023 1:36 AM, Victor Lu wrote:
> The WREG32/RREG32_SOC15_IP_NO_KIQ call is using XCC0's RLCG interface
> when programming other XCCs.
> 
> Add xcc instance parameter to them.
> 
> v3: xcc not needed for MMMHUB
> 
> v2: rebase
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/soc15_common.h |  6 +++---
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3a1050344b59..0ab9c554da78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -856,9 +856,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		for (j = 0; j < adev->usec_timeout; j++) {
>   			/* a read return value of 1 means semaphore acquire */
>   			if (vmhub >= AMDGPU_MMHUB0(0))
> -				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);

Since rlc reg access ctrl is populated using GET_INST(GC, xcc_id), use 
GET_INST(GC, 0) to be consistent.

Thanks,
Lijo
>   			else
> -				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, vmhub);
>   			if (tmp & 0x1)
>   				break;
>   			udelay(1);
> @@ -869,9 +869,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	}
>   
>   	if (vmhub >= AMDGPU_MMHUB0(0))
> -		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
> +		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, 0);
>   	else
> -		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
> +		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
>   
>   	/*
>   	 * Issue a dummy read to wait for the ACK register to
> @@ -884,9 +884,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   	for (j = 0; j < adev->usec_timeout; j++) {
>   		if (vmhub >= AMDGPU_MMHUB0(0))
> -			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
> +			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, 0);
>   		else
> -			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
> +			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, vmhub);
>   		if (tmp & (1 << vmid))
>   			break;
>   		udelay(1);
> @@ -899,9 +899,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		 * write with 0 means semaphore release
>   		 */
>   		if (vmhub >= AMDGPU_MMHUB0(0))
> -			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
> +			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, 0);
>   		else
> -			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
> +			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, vmhub);
>   	}
>   
>   	spin_unlock(&adev->gmc.invalidate_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index da683afa0222..c75e9cd5c98b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -69,7 +69,7 @@
>   
>   #define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP, 0)
>   
> -#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
> +#define RREG32_SOC15_IP_NO_KIQ(ip, reg, inst) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
>   
>   #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
>   	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> @@ -86,8 +86,8 @@
>   #define WREG32_SOC15_IP(ip, reg, value) \
>   	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP, 0)
>   
> -#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
> -	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, 0)
> +#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value, inst) \
> +	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP, inst)
>   
>   #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
>   	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
