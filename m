Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B82C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 10:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99F618B8C0;
	Thu, 21 Jul 2022 10:33:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0C718B8B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 10:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrkbRdpVG1g5Hjq+VKF5QSA6pEvD1hhgtOVvdMB5ToGqed5mx6EWV3fdJXFMT1f/RuENXhu8xGOJ2s+te2UpR5loAFtdMrQ7mDduYfJfBMAoiTU93QRQXF7rQCuNLSTq4yUZOdxQMhTM7YVHxQvdFDdTCAIqjXVe4fYZ0fZW4PAcm0vUaRUi2zYi9vyP7xC3+NgVc9MU44aEewsLex5jdWB2+C4ChjqnN5WHfCzj70Yh4lboFLT2yAsAThJ8cjVD/Y+ccGL3Iplk8RynPasBluNDK7vHEi3wFOEQRIhgmKI1CnCghAp4x16f3A+yIF17/BShOsMkSjGsezrtg6wkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uZA7/fWLsVBRZa1M9J48zYV8IdmfSnUTJiLRm3vh0Q=;
 b=V1kZkvk3g2JmHXQm2ZJypl+P+KXrL3uvOIsvoEfv/1reepn+/CjOqPqCxt0fLv+dwAH5ybPWSOwk/wprXGsvNfXHCn6g+suJeRnWsp2cmql1cCQ8lhrrG3NZnr+3UH5VN1mGDrZ/daaKtyU5I2bLrrtNgb8e/ix4c6M23aJxDOOWL9TCEESqN/VmA1LszwF/RU8BXVQsMcnXUs1pCT8d7eBaxcI7t+1+apIe4iEGByxE9T1tuM86PWMcIzOm4cvAPjrWzUQtSPzebgoix3QKrJZsRX4CH/nvEH9gvUGbOOlPrLJ5/88e79a+Yyjf94RMkgOgtFB5rFa05qodgUhjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uZA7/fWLsVBRZa1M9J48zYV8IdmfSnUTJiLRm3vh0Q=;
 b=hawfEZFUF3t8MuCeue2I1hGkpstajiNIWmWAkg76R9PKGHiN3CA7MCgKa96dHtBoOpCYtGViARpZaKjzNO8t2sBalfvjTNiEzomzt9tmIsU4aCyV0TiGoXZJRPPHmwS71GwYlGyA5ZVNKG6vtPUY6eH99LlMYBtAVqf1wLuyBKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB3668.namprd12.prod.outlook.com (2603:10b6:a03:194::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 10:33:25 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::41b6:a196:4f46:c9b0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::41b6:a196:4f46:c9b0%5]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 10:33:25 +0000
Message-ID: <f9f461fe-666a-5b6e-646b-d0a608a3b9e5@amd.com>
Date: Thu, 21 Jul 2022 16:03:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: Add get_gfx_off_status interface
Content-Language: en-US
To: shikai.guo@amd.com, amd-gfx@lists.freedesktop.org
References: <20220721085738.2528792-1-shikai.guo@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220721085738.2528792-1-shikai.guo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b40cc228-e1b1-4530-5f0a-08da6b047149
X-MS-TrafficTypeDiagnostic: BY5PR12MB3668:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blWMJ8STvzV04Q0GMHTr4AXZLe82DlRGJ9k788O0CN4meehjWsr7XV/bUJU67UaJJ9Kzk7G0EtqUPtOU12rMSHACL4KG2vzrLb3NLpMfVUUQFFEf/5aRdt6rZGsZKLqErRIjQAX5SHR9EJs72qmdPHFMx2Nd4ubCT5Ku38Z0FlTVBhYPpEyjYOKQr4vaUlJWfXR82OMHn9Uph8kSQh4QSHKU7ybsKm1walX9tOJuNUigC6pVYcSun9tdGhKBGacPsI8k4QFXKjQoVvTiL+lag4ooQnvNrGWYAommXaEj02rciE51S2JrJo/4o1MdCam7orixF0IY7+ZbdhXGVlJUeFQeNVAYxDsfOqVtupy0Yz9yG15qE8PosE52JKhQ4B7k4k14zXy38yv/rq8dDlwYOnCHJa6xWX0jGXlN7fRK4d5RXe1AHlKnxbMIRz/7IHBrgm7gB0KFqmjtALOd/P9jU6VuK7BUPqC4GCZv6T19hojOQjvidQMNnyr4Jr2fx5bxK8NaPI2FpSrFEUrgt7SQdqFSWlmOFPnK52r1/Zr6f/6vPdsn6zz/OQNHbiMklhlmIN8nZAAVzNgzzubQJ2e9T9EJLt9KhS79Ivr0eTNFCSxBOxETI/9xkVth5nVa7asBgeLJ20oRxjLPtJWO/PB6WtLBZlj+lz7Wsq/SJ6/eHvICapY6J8I3k2JXc888x8exEmqWZsFATp3Am6hk9DdQ68gxGvFWKKRV+o/o3hRp7ux3+xwYPYqHENHcIHoZ5HaNeK8plfT9MOFayLIj5DteVV9KhVh0+7a1G+MuAfXMvVskHAoOQMtdi9N1+DMk8b0hTfyPlO0hcTQd3CG/hJ5N6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(5660300002)(8936002)(8676002)(4326008)(66946007)(66476007)(66556008)(2906002)(83380400001)(36756003)(86362001)(26005)(38100700002)(31696002)(6486002)(316002)(2616005)(186003)(478600001)(6666004)(53546011)(6506007)(31686004)(6512007)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUh0YURqUWYrN0NRbTNmV1ZneTZpODRCa25GL0dKTjFEWXdGSk1Sb1daVWFY?=
 =?utf-8?B?NjlCc0FMcm9BY0psT2xZRGtna0U3TnV2Sng4SzBrQjM3TWxvek8rZEh4R0Ju?=
 =?utf-8?B?NlJtT3pPWlFYdmEvR0J5RVBaREJiekVHcFg2TVRpajE4Qmc0NU1CYTlENlRw?=
 =?utf-8?B?SWRDMVF6QVo5UzlkaHFwTk5vb05aenZZR3FkUGJxWVREQzlyTmdWZCtZajRY?=
 =?utf-8?B?TFB1L1dzclk5aXY3NTZ3Wkk3cGJKR05XSkZGNzlRSDYyQ20wclpuVTIxUWNW?=
 =?utf-8?B?T1BvQ2hhb0V4R1c0cTczbTFrV3JPa0twK2JxblFrOFJTYmVZWEtGOTEwTjNT?=
 =?utf-8?B?V2d4eUkrbDdCRTQrUGxoWFVaUHErNXY2bFV5WjZJMnAyNUxmT0tyMTRrVnYz?=
 =?utf-8?B?RFBkMXVnUWxVOHA5SXN6aUM5eGIzbXZPSXNVWWI3aTVFdGdmL2FIRk4xWUdj?=
 =?utf-8?B?a2JSaWdEWWdqYjk2SDZkbXhyeGFlc28xdVdVZmsyQVFRWWtWL2dvTjV6cE1j?=
 =?utf-8?B?emVzWnNGZGxaTnU0S240RzloQXBnWURPSHovbEtmQmZEclJ5eWtET1BhSTFr?=
 =?utf-8?B?UFVraEM5WEVKazlJRUN1Qnc1a2pwOERIdVhqZy8rRW5nNUtPUlViKzdZRkRK?=
 =?utf-8?B?NFFCUStDY0ZUQmRyYmFab3hjeHBvOHBkUGpqOFRXb1FWVm5QUjJWVklXV1ls?=
 =?utf-8?B?ZnZ4ZUFtdEMzbnIzc3EvbVBkTnp0S05XRU96b1BZcmhnWjdOZ2ZUUjY2anhx?=
 =?utf-8?B?K1V2TUtJaGhzTHpRQXhFemNFZW5HWk5ETUpkQkNFaUVzeUNqV3BjS1F0KzBQ?=
 =?utf-8?B?Ky9mbVh1cFpDSjkwclFZT3NLSzQ0V25GcFdiUHp2Z2pQNzhVWGh0OXMrTjFN?=
 =?utf-8?B?MUtweVBQQk54enBDV1VYcDNaOW5IT216WHNHNlVjY01LNXhyeXdvUy9ORXJm?=
 =?utf-8?B?OTgwbTFIUk5JUTFIUFprODlaSW9RcE5MYjVuOXE4Y0gzK2YrTXdselltWGFo?=
 =?utf-8?B?QnRPVVBVeE9QcUdyNEF5RlcwVjNsOTZDY0N1VmNLaDNTQVI0Vm5CV3NvWDF0?=
 =?utf-8?B?SStXL0Iva0pHWVErQnBLTTR5OWVDNGNrUmo5amY4MExtQW10bVlqWGpNbUJn?=
 =?utf-8?B?bUJKMmN2MXpuVjdJcnFoalRCU3E1UVAzVnFCdWxWWnhPQUNlbHBwam1VbFZh?=
 =?utf-8?B?T20rRFhVVG1Eb3gwSm9heU8zZ09HakdrRFd1aURKYWppaEdrY2o0cmRnb2dN?=
 =?utf-8?B?K1JKVW9vT3hTZHd6V0FUdjZId3R1Y0grSnE0S1czS2ZOa29sZVpBSXlJaWR6?=
 =?utf-8?B?eXZzNXFwNjJLUVBIQTIwTm1hTk1NYmVmRU1kZkczQlc3cHA4cm51eUw5RzNo?=
 =?utf-8?B?K3hIalRoeDhmd1M1Qkt2TGUybXNCK0xOMnFtTmNYeVNTbFVoSE9PVXZ1cmRr?=
 =?utf-8?B?c1RwU0owdkdpZjhYTjdwVmdmU3dkbkN1d0w5N0xuWVdZcis4SlVldHFyZGRw?=
 =?utf-8?B?cHRWVVFnSk5OQ2doMFlNYTJ3My95WFZWMklGRlNCUFNZaXJ6OU1zWkVwVU55?=
 =?utf-8?B?ckN3dkkrR0cxalp2RnBvQWFWdFRQNVd2MFFDMmQ2SHJva0Ntc05ENXlNSzl6?=
 =?utf-8?B?ZkxsQmJmckR0a3RRWTZ3MXd2Zm9CVGNVUmdOYzQzMFAxQkxpSGw0UlNJb0xl?=
 =?utf-8?B?VUo5S3gzVFc1OFRDVXN1QUNNZnZWUWdJSHJ2UXhsRjdLZVFjc3FnZmhUaEdj?=
 =?utf-8?B?T04yc1NhcTNBZCs3allTKzJ4eU8wVG1ObUpKR3ZPVHFFb01pYUZBN1ZGYi8w?=
 =?utf-8?B?SjdPU3hRb2ZRUVlvV0tiVjN0RXUrS2hhWTRXdlNRRTNDaENyNFVKNnV3NWhB?=
 =?utf-8?B?RytLVEQ0NHI5TXM2WHFaQStZa3A4dkpDSDkxY24wZDBvcE1OM1Y3dWtnZDFz?=
 =?utf-8?B?Y2Nac3dOeENFaDRkQTVkdktCbk5LN25tM0dTV2NseUZ4MmRJdEpJOVkzeUI4?=
 =?utf-8?B?dEE1RXljSXNuQnhDWncrcW9YYjM5K0YrUnFPQkZBQmszMWlOZFRmQkdGdFZY?=
 =?utf-8?B?azNEVUliaVpKR1JndkJDSHNzWVFOT2NLaEFrN0c5ZFN1aDRtaUgrQXBVV1ZK?=
 =?utf-8?Q?dVDL2Q+pxBRu6P5R+abeSVUFJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40cc228-e1b1-4530-5f0a-08da6b047149
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 10:33:25.4771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPK9pIv8WlDSmAYlcst6sOZRFhEroPJlNHDAuyAXFQ5IfJGpUcvar2+Z3x39yVN1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3668
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
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/21/2022 2:27 PM, shikai.guo@amd.com wrote:
> From: Shikai Guo <Shikai.Guo@amd.com>
> 
> add get_gfx_off_status interface to yellow_carp_ppt_funcs structure.
> 
> Signed-off-by: Shikai Guo <shikai.guo@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index 70cbc46341a3..2e39b629e7e6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -31,6 +31,7 @@
>   #include "smu_v13_0_1_ppsmc.h"
>   #include "smu_v13_0_1_pmfw.h"
>   #include "smu_cmn.h"
> +#include "asic_reg/smuio/smuio_13_0_2_offset.h"
>   
>   /*
>    * DO NOT use these for err/warn/info/debug messages.
> @@ -42,6 +43,9 @@
>   #undef pr_info
>   #undef pr_debug
>   
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK		0x00000006L
> +#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT			0x1
> +
>   #define FEATURE_MASK(feature) (1ULL << feature)
>   #define SMC_DPM_FEATURE ( \
>   	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
> @@ -587,6 +591,31 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>   	return sizeof(struct gpu_metrics_v2_1);
>   }
>   
> +/**
> + * yellow_carp_get_gfxoff_status - get gfxoff status
> + *
> + * @smu: smu_context pointer
> + *
> + * This function will be used to get gfxoff status
> + *
> + * Returns 0=GFXOFF(default).
> + * Returns 1=Transition out of GFX State.
> + * Returns 2=Not in GFXOFF.
> + * Returns 3=Transition into GFXOFF.
> + */

This is a public API (amdgpu_dpm). Hope the final status is consistent 
with whatever is already defined for other ASICs.

> +static uint32_t yellow_carp_get_gfxoff_status(struct smu_context *smu)
> +{
> +	uint32_t reg;
> +	uint32_t gfxOff_Status = 0;

Mixed-case names are not part of coding style.

With that change
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	struct amdgpu_device *adev = smu->adev;
> +
> +	reg = RREG32_SOC15(SMUIO, 0, regSMUIO_GFX_MISC_CNTL);
> +	gfxOff_Status = (reg & SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK)
> +		>> SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT;
> +
> +	return gfxOff_Status;
> +}
> +
>   static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> @@ -1186,6 +1215,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_driver_table_location = smu_v13_0_set_driver_table_location,
>   	.gfx_off_control = smu_v13_0_gfx_off_control,
> +	.get_gfx_off_status = yellow_carp_get_gfxoff_status,
>   	.post_init = yellow_carp_post_smu_init,
>   	.mode2_reset = yellow_carp_mode2_reset,
>   	.get_dpm_ultimate_freq = yellow_carp_get_dpm_ultimate_freq,
> 
