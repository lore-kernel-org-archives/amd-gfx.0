Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FD7C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 10:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFAB10EEE3;
	Wed, 27 Apr 2022 10:16:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B3C10EEE3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 10:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSBmYtmsaYppWtTHs8Chzx9tDeSTkFP+afQEHdYT7C8gONOGM/ABFRg7src03Qq5nC1+dynmPItBoYsHJkNKee8IB/9Lf8G/ECcIpdAN6anMxnVXgVs1+KYm+MAQHPgOaHafSf8LLdbo9mzV9KOF3dv4kkXAUqI8373EdwWcOipCvM0YYEFzjqA9SmBx9J3pZ7h8TSzFYrup8lRqEz3mOVcbfJayypPD23vU/2tqN7p2Io7jEayvpdaNcBbVAC8yJH8euCIos5hXz6n0xWieyCqNWAiUGWk1VpKci3fd5YYvyzW5rXp99yfk4VlXo1HbaUGDSEHeXIBXPN+5eo8R4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r1574Q3/qfXzpU1IQ5Q4ATj33/rDe822ICqaFOXu9M=;
 b=K2F6CftFOMbVTdp7iaq/JM5koWXHIWPArGBGSqgrCP+oBLDMuNoCt/Ee37c1duSq1XbbcGGENpsne6P6rLGeKf3klGdqOsuuG//SBSAN8cW1wHoHYglKVwp3fya2CZE4qUJ+e27Fyu+shTKewlcSKi+Tzsm0gC946YdH2hzpzmWeCli519qHMlUapACS6Iyt623EP4keEHWZQfGAvYHDxBCzHIt5tg7DoHQKETK7nRE/pznHFm80XTzHUaVUjQeELsuV/fKQjLbRBmP5pZzn9x47HGAYXWF2O4NtdsX7ekAzVk775UJDWPS8loBzHsC4nE8xPzmRzHMxz6kPMedCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r1574Q3/qfXzpU1IQ5Q4ATj33/rDe822ICqaFOXu9M=;
 b=rrg/C3XO8C6txLhQ9hB4k0bRzZnimejImIUz9ojK4onUW6Ze8295nXI+7ks6FcVOMlTmrCOQx4zDxWN1MNiC8h53lwYNSlH44uEpOCFRE8Gzpgx0GG4Q6PM+XCuqldJBPYcLi1t9G1MhgWPyuTo50HxZsFMwdZ2RJnaiRb65lmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 10:16:10 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 10:16:10 +0000
Message-ID: <71203a07-9f5c-1193-4014-879e6f4766b7@amd.com>
Date: Wed, 27 Apr 2022 15:45:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, hawking.zhang@amd.com, alexander.deucher@amd.com,
 evan.quan@amd.com
References: <20220427101134.17917-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220427101134.17917-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffd19016-d452-4552-229f-08da2836f2fb
X-MS-TrafficTypeDiagnostic: DS7PR12MB5840:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB58402AC07ED6F3CA61BCFED497FA9@DS7PR12MB5840.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akUeErHXLcrrKs3JWXnZXV6Mgu6rqUm5kysHAsK2rkSFPXx7S1rrQ5Dcqls0PYZDzXASxuYpv5Eam1G7cu8rQjNpYcIs5C2b/IPIy4LtZ/mEsxmiOvqBncdEilAJmgPjZ5/JDbMtUCiZZ2sKpBVRAbzxBO848LgfuWE5U62Vduy4WyV/+awIXY+wUYQOeBZrWSKxdInCLUZeHZXDy5l+tBX7gZkuw4Ha577ticv6RMoONRFA6zuPfe4AYiz5yLWcT92NBp9G8NX1E2gE7Jgr6w6z+KvVGFm0o5lNYsv5Y9QAwCaXsk1Q/itC367kt6Js7zGbbRkh6TN9Uw1d1iBQ9Ef4CiyYun+g8BEM5gNvIFQTxnxo2NI9zLj6xbZfuX/KcgF8bEJmAvbDSsQld0Cga6Eh/Qm82VSRyYbuJGMUtXW3aIdRfB/WUBeAe9FFWtMDrIh4NMg0hxl0kx2fOO4Fzxkq2xQ0dvT/596HLO21L2dcpyIOvD8ByOXbw1t3nTueyelMzPMyjedGvMEp4wiYfqKq4BH/9sJAefzJ9wgYQxA4ZBCSfwkrYpby+ZVpYeA8PtkXAeM+wT//x2UtuHzwPAaElaIbmx0cDnJycxgHjKWESbXiX2BH6O231dGFlfdrVexUtLDFyxTM77XVRUWaG+qhUWfmLJNkPgdzsQl6PVo2UDpUkJ4URP8/j6xuvokYxHRyeqD7uVu+UcjGjK732W0Igm8sMdAyaFYJ6kMoh5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(5660300002)(66946007)(66476007)(66556008)(6666004)(86362001)(6486002)(31696002)(2616005)(36756003)(316002)(2906002)(508600001)(8676002)(53546011)(31686004)(83380400001)(38100700002)(186003)(6636002)(6506007)(26005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmk4L2lTbzZodWhWajBMQVJCbWNQb2xHRVhseTJzUVhWY1FEdVN3Ynd3T2Z3?=
 =?utf-8?B?UVlsYWFZVENDSUNQQ1hmSDhQNXJCQ25xS1pQRGhqYnBTNDZ2NE5jR3IyWjhz?=
 =?utf-8?B?ZnJYRTV5QjhiU292K0xTYkJVV3NVZFMvM1RDcDZ5SWdNYmJ2UnVWOWVTTnNr?=
 =?utf-8?B?SXU2Y3JGQkU3RzArVlRTQnRSdzdhbFVKazI1U0hEVFRkb3R4OTZFdE45MGxt?=
 =?utf-8?B?Ty9EaVJ3b0JyWXI3S2w1L2g4a3cyakorRXJnS1NiQ0pZT3V5UkpSY0M3cTBO?=
 =?utf-8?B?YnhHZ0llK3RpSkxVa2ZQQno0L2Vvb0l6Myt4UWhYSlVRTEs0ZDUwTEtrbnB3?=
 =?utf-8?B?bkMwbzBiUnhlVjRLSWNra096SWZaM040MnNqbDRyZmVGVmZMbkZNRm1TeWll?=
 =?utf-8?B?VFZMcDloNzRtK3dtd2V3NmpwMjBrRjBrR2JZZzNlenZMZHVYWDJSaUNSOGMr?=
 =?utf-8?B?L25OejhUbGpQV1MwNHU4SkNhbG05Q2hWTUZWcWpwOFlQeUdYWHV3NUJlbEZJ?=
 =?utf-8?B?N25ENDByVm56T1VSNnU2N1Faa1RZWWE0UXJTMStUVDNnVi9WTmdmWjMyZXp0?=
 =?utf-8?B?anVjQi9JMkMrVUZFRnB2MVZqL3pody9Fd0gxS2ZRdXFtT01BOXhOelJLY2xy?=
 =?utf-8?B?VWJhNlNCSUlVYUplYThVYk9GVktKWEZrdDliMGVZZ1RuVjNrcWhrNnZxdnhr?=
 =?utf-8?B?MXdBUEZGQm4zdDZYMzUrUEIwekVZOFNHK0Q2dWlnNmxqVTN5ZzJBMThPdXl6?=
 =?utf-8?B?eUlxY0dYODUvTUo4c3ZVdXJDanFrdS96bTk0MDVGQlVQMmM4Ny84OTkreUQ5?=
 =?utf-8?B?LzRsRVpWWUVjaXcwWENXazFYTXRwQm5QalFvQVNUcFJ4MDhqSWwwNFNIMnNV?=
 =?utf-8?B?Sit6Wm5mbE5WWUNLZjREYzExMExZVVB5b0RGMTJuN1ZwWjBicE1uc0owNVlm?=
 =?utf-8?B?UXVDTVZMQTd5MGJQdVpSOElPaFYvMHdTMzg1VS9DK3RabFJKUzI1U0ppYk1R?=
 =?utf-8?B?WWo4TXVZdkhFRlNGRThOOTRqdzY5bmEyTXVTQlk5UmRRV1ZWNjI0SXFPamMy?=
 =?utf-8?B?ZW5MQlZIMjAvM1VoRm1Id01MclRPa25ZQXBLWlpnem1aWWpCYWdTYlpNN3Zp?=
 =?utf-8?B?bzFEbDl0dGNwU2drUVZsNi9lWVl2UFArbS9xR2V3UDRTL2NjcWwvZVZsKy85?=
 =?utf-8?B?TmhCRXJQR25aU3ZSVVNqWEgyREE3SzdRamYvRnA5Mlo4OXZLeUdMeURuNXZ0?=
 =?utf-8?B?dHR5UEtxTlY5ODF1cGF2d2V5NWZCNElQUFNhK3NOZ1BPTXFGNEw0dm44ek10?=
 =?utf-8?B?VWpPUk9sQUVTNytFS01jRmVzUmVrZk1yOGJIN2U4bG1wRE9EUDBxQWNPc29M?=
 =?utf-8?B?YTZGb005cEFmY3k3UXprWGE5cTNCOGw0Z0JuTEt1cU01MmsxbHdaN2ZSWnl1?=
 =?utf-8?B?UnNqTmU4aFdXOGxZZGdPSFhTMnFtU09MSEhlZHVMYVZtekR0OXBwaHpORVNK?=
 =?utf-8?B?QUF4U1lYMStZNE4yQ1JRSzVzUlBRdGFFQVA0QWJKWllhZUtPdnB4dWVueHFh?=
 =?utf-8?B?Mk96WDhuOEtvSlVva3pUUWdkWlp4cDkwUGw3eEVuMkpRUEY5d0ZjWlZHSHNF?=
 =?utf-8?B?SElkS2xGK2g1VVF3SGE1QmJjeHhOMW4zaUZlZS9RWjNUc3ZTd0lGWTBGYnBp?=
 =?utf-8?B?czdnTE1qK0ltblYwRWlRQ3MyTFVOeTJWc2xTa2lmSjNrMEVybU9yMkptUUZZ?=
 =?utf-8?B?UzVQd21tTS80aWt1VUxnRHRvSnZFTStpdmlZVmRoRGl3aGlYZDArT0RMdDg3?=
 =?utf-8?B?cGxiaGhOMUJHcHlSZUg3SWxZVmJVbHBiQ09LR3k4N0lBcGhpSlBwRjNWekJH?=
 =?utf-8?B?Qjg1NEFMMWl2VDRUSGlhR3BWVFlZRTdDQWR3ZWpOcEpsMExrT2JZdE11Z2Vn?=
 =?utf-8?B?YXcyRjBKMVc3eDFsenNqdVpOblQybm5Md2Q5VnAzRUEwSlo4R0FlN2xqd3pl?=
 =?utf-8?B?b2k4RkN3TFRDZjYxaWdHbFBySjgxMGVWY2ZUM2ZWa1dGNTdaU0RtMmEvYUJs?=
 =?utf-8?B?OElnYXo2bG1QQmthRG9kUTJ1QWFheTlaNVlWa1BZTHFHdFhRdEV1L29adi9o?=
 =?utf-8?B?NGZGbkE0SThpNVNzaEovVzJUZzFnQWpYUGlpbndKRDhtV1hwMUlZc2haNjA5?=
 =?utf-8?B?MVE4QXVwUG5WeVYreXgrVklndVI2d2xROHB4YXJOWlk4SjRabFN3YVVXN2tZ?=
 =?utf-8?B?Zk5pQUxBMFlYN1JuZlQyRS8vejlrWGxZOWFUUFcxMTcwcy9uNXpUSElZVTBj?=
 =?utf-8?B?ZStsR0U1M3p2Z280REx3cTNJTlFnRTlTQ1YxTlFTVGNxVk4yRCtwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd19016-d452-4552-229f-08da2836f2fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 10:16:10.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eoz/jhcRm0i6ZkY59wcNyrNuXPq8c7WsQgFE2Orhy5Vik2vMSXIBgr2gWIzKoQKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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



On 4/27/2022 3:41 PM, Guchun Chen wrote:
> Disable runtime power management on several sienna cichlid
> cards, otherwise SMU will possibly fail to be resumed from
> runtime suspend. Will drop this after a clean solution between
> kernel driver and SMU FW is available.
> 
> amdgpu 0000:63:00.0: amdgpu: GECC is enabled
> amdgpu 0000:63:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
> amdgpu 0000:63:00.0: amdgpu: SMU is resuming...
> amdgpu 0000:63:00.0: amdgpu: SMU: I'm not done with your command: SMN_C2PMSG_66:0x0000000E SMN_C2PMSG_82:0x00000080
> amdgpu 0000:63:00.0: amdgpu: Failed to SetDriverDramAddr!
> amdgpu 0000:63:00.0: amdgpu: Failed to setup smc hw!
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <smu> failed -62
> amdgpu 0000:63:00.0: amdgpu: amdgpu_device_ip_resume failed (-62)
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 262938f0dfdb..9c483787c0ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -180,6 +180,15 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   		 */
>   		if (adev->is_fw_fb)
>   			adev->runpm = false;
> +
> +		/*
> +		 * Add below quirk on several sienna_cichlid cards to disable
> +		 * runtime pm to fix EMI failures.
> +		 */
> +		if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision == 0x00)) ||
> +		    ((adev->pdev->device == 0x73BF) && (adev->pdev->revision == 0xCF)))
> +			adev->runpm = false;
> +

Separate to amdgpu_runtime_pm_quirk()?

Thanks,
Lijo

>   		if (adev->runpm)
>   			dev_info(adev->dev, "Using BACO for runtime pm\n");
>   	}
> 
