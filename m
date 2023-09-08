Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD6FEEB56E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 20:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B8E10E94D;
	Fri,  8 Sep 2023 20:43:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4032810E94D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 20:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDasPXPkl0H8rZds7vY2DKT6anZ3rKB3utqFalPUfA9fviouDq1DQe0o3YoYzKKrUUZjsn+rW8NJeE85y2QgH6kXuuXUg+mBu9gw1Kb0U5CAolggQILj63BVUmrsqmc4ldG2PZ26UXqEl1yA0UxFglJ/q7MnfLn1uUHw+ZM7ImtEF8Bh0B2cqXwiZbw/qd8paUob/DMG6hFOo4QWlntT7Udvalf8xFvUABDp1Z2idXZIVGT8VfDkS6E95U3a8rKW91d/YUm9oT2Jjnj5D0XEG7+uyY98DH1XSf5RWvYRlOPjPCsgHDTRWUrxvp+ogbTmnJgmMKCsq9D4Gka/OwK3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g48R+iGXPnniLtvTTbjGp9iAuxsfSKelKFR5Xi+7yQ=;
 b=e2uhVtS2GH/hdagyuA8K+2wbscocR5pklEqTqYZPf5D2o4Fw7C9875+4vVMpbzUTwQ0puY+ghCCJMwG2P7BO30a70A/mjSYEz1teOB2fHeoNcj6QpO4TEUyPANwmiF9XAQJR1R9miDptjissihRUK4SLatZAPl7I7dY4yYdc8mOzk6bzBTp/ReH/EE4cCUfSkcyCH0KWtajoYaO/3ArVxhPH/rczbvSUCiJXMvd2IhUAd6su0d3H+HYXShjQicd+WaEZHYpTNZRLuIqpQP833cfrePFfND3Fvb9fC2MEErhIFh4FKisEmiUsPb+dysxvJVjAUjWSno7cSc12A0d1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g48R+iGXPnniLtvTTbjGp9iAuxsfSKelKFR5Xi+7yQ=;
 b=CoK71ePC5QBCfN6q4hP28m1LSGmKlAnVPkLLmxG3ziZK6TGxP2IVwMJemxJV70sDHe/PkD1JwuqLBvhKnQdJzEwpCyW0K45uf2UzIa3cKQzR29Dx+8kmXkNDZMXv3YGvyyKG8yD1c0Rbr9gURDt6PGJJOb5S5eU73uERVvHuWSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 20:43:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 20:43:47 +0000
Message-ID: <c415154e-63a1-7d6d-bb48-b42d75c6a99a@amd.com>
Date: Fri, 8 Sep 2023 16:43:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/11] drm/amdgpu: fix and cleanup
 gmc_v7_0_flush_gpu_tlb_pasid
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-5-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230905060415.1400-5-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abf33cf-d971-497f-b6da-08dbb0ac4c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWsDyClpsLWZ5D7XiNMcb0jVxD/zBjgcxxZIVUV9NoVJrvy/b+1P5w3t8MOkPvaWEJc6jMmOYy29Qm7gf4NmR8JB1iskK56GEXF59o2/IkSnKNC/w8Z0EmRg3VagVu1XSAyc1TC1wS8ua2/0SsYOGcqnALsQxriptUpJHKUE9CAKqGy9a09dK6EENWfl+mu3yZip7LiizRidN5G3modL8Hg97WfF097T8jV2ZSJSW9IXdk7QY0tOv2fE61K+wQ7dCgwWv8qhBNIDkMba9NTeioEdTXI7AQsnfT+8QicXc+x83YCtZkkCw1y4kxw2rYCedxyo/Sof74M0p6Db1lOfK9k6p5nknTnO2+71vhX0Tq4KG38zZ2qMycVc1n7fqo7NAjD+Ure9ceWsqnmK4YT1XWWZ+3e8NlSG9rYCFf3w0Dzoe0XVR1fsdjpMbnoLhrvuDDW359qcK18dg7BOUUAyV4AeTZQG6q1QVJJprPIPXiAgH2KLLFGnFE3LWDHqI7rkK0JtjV1XHbF1i74gLkhvVU2CLonKP/Y62mLbYsRRNFNvBNnaArAd8m7vGe7y2EBKZZeQyHNbzhhnwffU7u/Vd2s8jW7KJDymJmNoHAYpkRbnTYmRrPgA7nnCbDy3ycNcV2mXD5xgypdeqd3fCoSppQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(83380400001)(26005)(2616005)(44832011)(5660300002)(8936002)(8676002)(4326008)(53546011)(6666004)(36916002)(6512007)(6486002)(6506007)(31686004)(66574015)(478600001)(36756003)(86362001)(316002)(66556008)(41300700001)(66946007)(66476007)(31696002)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHdPSXU3clFsdVpRVFIrN3ZmV1JHTnFnc0FONyt3SnljazIxb05MdkZvY2ti?=
 =?utf-8?B?WUg2RWl3Mm9zelozU1gwL0FZZnJTN0RIRi9vN1NldG5qQkxTVUkwaVE2Wld6?=
 =?utf-8?B?T0gyTXI3Umk5alF4L3FsNDM4YU1QOUJDdTVLa1ZnNm9CWDMwVDQ0Y0xIeG02?=
 =?utf-8?B?UUh2c2kvWHlRVHJhd3VNWlRXMTJjYzZCYlRDd08rWEhIdXdVVkpqRWd0NlBV?=
 =?utf-8?B?aUZYOWx2WERsWmR6Z0pSTHZ5OVk2ZkdrNGFid1VoWlRiNGhVUkJBblIrNVh5?=
 =?utf-8?B?VVp2REVvdlhNYUx0dmp4dlRVdlFWU3FiRlJZRGp4SzF6bFo2a3hCQTg1NDUx?=
 =?utf-8?B?NjZSZGhIUFdxYmhseXpLTnNNNUJ5MTVJMzl2UFJuaG9KV3VrNFFscUxUK1dw?=
 =?utf-8?B?Z2pGcEVMdW1WRUZUaE8yclhRN2JXaTRvcXIzR1ZtZzZCVVRGV2loRGR4ZE5J?=
 =?utf-8?B?M1dRbWYxa05GMk1yUFBSNDdObnllTDhXZy9iK1JzK3FLN2ozNC9QRk5zOXR1?=
 =?utf-8?B?M2FtbExqdXRYbURWRldFdWNwLzYwZjYrWXFvV1FESmdHMjdGNUxEeS93MVQ2?=
 =?utf-8?B?M2FKU2F2LzcwcW1GSTg1bDhoSVJnckhuOEorSjJlZzZsVFJRR3h3Y2ZqeDB1?=
 =?utf-8?B?Ly81T1cvWkxGSFBpQWF1cisrbVNTSFgyVFVURHRpUnRkN2xoL2hIeFgwNFh1?=
 =?utf-8?B?SmNmakxoL05CbWVMZTdON2FJZkZBNkVUV2RjbjZDeTJzUU5FZ3RwNWRxOTRH?=
 =?utf-8?B?TnI2cmV5dzEwcjZxdUd4REV2WnZnZEthbW5jbXJaTmIzZEVXSk5hTFVoS2h5?=
 =?utf-8?B?M3MvY3czS2MvVCtid0NPeDZ0R3AvZkkra0J0SmZaUDM3TndzeG5yWHJ2ZXE3?=
 =?utf-8?B?TStPM25sMGl2VmozNlR1dVlCSHMvb0NlS0Qra29xRCtlMDRkQTRpTWExMCto?=
 =?utf-8?B?NVBkUDhuRkJySlh0T2U4cnQxVTRhS3Bka0c2TUVjd25uS0psN2NEYnlBK3p0?=
 =?utf-8?B?aGIwOVZOMTRQSjl5SlV0aDY0VE0wZTFxNk41TndHWTAvYkVxZDlzOUdsTTRu?=
 =?utf-8?B?VGJtaDJXc0JiblZiTld1SDBDV2NDTzhhQldNMVluNTR0TjByMTdCeGlERzU3?=
 =?utf-8?B?VHR1b3RpMlhFbEdIeTZqWHRpa0JTS3pUOGdxNGFUNENyZWkrNXU1bGxtL1NS?=
 =?utf-8?B?WXpwL2lKRmtiUnFLdUtSdmR5OVZIOURLN2hhZzk1Qng1SWlXVEdNZ0Y1dG1Q?=
 =?utf-8?B?WTM0ZE5nazk1V29naTdJNjVweVJNbFd5SG01aHE0SlBldjJaMWdLWjVpRGdm?=
 =?utf-8?B?RUpTOG1wVzlnTi9RT2hlcmpvaU5rcG94R2dFRFJhMVVhNXAwUU82cmEvVldL?=
 =?utf-8?B?enhSQzlISHZobmYrd1dRQ1hORW02aGpOaWFOdkpGZ21DQkhGeHVZMTkxU2g4?=
 =?utf-8?B?amZJSnFFUXZVcTVLanVzUUNEVzZZeDJPY3FsU3N4ZHNDSmJRRlBIdlAvcmxE?=
 =?utf-8?B?ZERNckF4VmFiUUh1cWZ6NlpxMEd2dnN4MEo5ekhCWDBuRWFyQUdxejlpdDlz?=
 =?utf-8?B?Wjkrcll3Vi9aNExTTkdjaHcrQVF2SDBuWUhwREhwOHl0Tzk2dVQ5NjdGVmVK?=
 =?utf-8?B?ckF2eUxjSkVocVpuVHJ6R0cwSTlhWEZla3JzS255N1hWTmFaamx1azRidmdr?=
 =?utf-8?B?c0JvMm05RkliVnRjQTVDOEdhTENWcDA3NnNDQVprU3ZRU0Q5UHFFMnNKMDhr?=
 =?utf-8?B?S21QM0NtcUxaTmdZMXJnV0tTWm5xbjhuT1d1NnRPQjVIRklOc1dVTkFGcFpF?=
 =?utf-8?B?Skh6UmovVk5ZZ0RzclZzSDFhQUZ5dllPNnVFa0V3Smd0ZUJWQ2tKRk5HeFlI?=
 =?utf-8?B?WGZPaTRMRXJqQWZvRURobFFjY1VFWUdKZy9zM0ZnUXdvVGx3UHdDbTRubWNz?=
 =?utf-8?B?VUlHaFd3WjBGSWhIL3BORSthZWc3cmJzYVNEd2FtcFhzUXZYWlpYTkJ1dFNj?=
 =?utf-8?B?NXNUcVlaMHFubjBkZHV5RWlmTERjc0VaNHZ5emk1dmxobmIzUkJOOWx3R2pi?=
 =?utf-8?B?dDM3Y0tUenpaREVXUEpzQlZTaGMySk5oemhLaGdIbE1ub2ZiUnowN3JZbi84?=
 =?utf-8?Q?742wldokNP1garyyXoafT7ErO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abf33cf-d971-497f-b6da-08dbb0ac4c98
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 20:43:47.0627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXxjXvmtrt++uS3A6sgr3viWFm3f49MVLP0W/QV+QturTT/zya1vjLPyclqcqakJYqo35TpUK9IiWhNl9x2tSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think you mean "VMIDs to invalidate", not "VMIDs to reset". With that 
fixed, the patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


On 2023-09-05 02:04, Christian König wrote:
> Testing for reset is pointless since the reset can start right after the
> test. Grab the reset semaphore instead.
>
> The same PASID can be used by more than once VMID, build a mask of VMIDs
> to reset instead of just restting the first one.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 6a6929ac2748..9e19a752f94b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -33,6 +33,7 @@
>   #include "amdgpu_ucode.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_gem.h"
> +#include "amdgpu_reset.h"
>   
>   #include "bif/bif_4_1_d.h"
>   #include "bif/bif_4_1_sh_mask.h"
> @@ -426,23 +427,23 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   					uint16_t pasid, uint32_t flush_type,
>   					bool all_hub, uint32_t inst)
>   {
> +	u32 mask = 0x0;
>   	int vmid;
> -	unsigned int tmp;
>   
> -	if (amdgpu_in_reset(adev))
> -		return -EIO;
> +	if(!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
>   
>   	for (vmid = 1; vmid < 16; vmid++) {
> +		u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>   
> -		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>   		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
> -			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
> -			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> -			RREG32(mmVM_INVALIDATE_RESPONSE);
> -			break;
> -		}
> +		    (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid)
> +			mask |= 1 << vmid;
>   	}
>   
> +	WREG32(mmVM_INVALIDATE_REQUEST, mask);
> +	RREG32(mmVM_INVALIDATE_RESPONSE);
> +	up_read(&adev->reset_domain->sem);
>   	return 0;
>   }
>   
