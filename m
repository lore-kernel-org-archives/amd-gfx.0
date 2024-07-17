Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3110C3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9932210E16F;
	Wed, 17 Jul 2024 20:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EqVDJr77";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4C010E419
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ8EN5N2xmOS0IV5QVJO6D6/G5OaFNRqO6HnGbRVfoR6+jT3XGL960daIGNMAzn8Y7ykPAfpXveWqsBmUgoDc2cZYDyyvz2Yl+1SUY6DCi8NjiDsTEuSl8MAnTeckxsRBe/y4RtTynd9YKxbALY+cVt0IrE2f8DjfS87eSntzGYReZUinlP5gp6jz0GVmMmzFhp8yxWX9ezXHIJRMay7wsB0shpunPRGl3gNwpcl0qcfRD2yJQiwk6TH0Jru+Hi1k03TZYA6Ckob9FYRAK13eEDrLauGi9JJDdfaRFfsyxT6GrIYNN+DSJFFDtecAUMxd5qze4pBy7s2ghoBhEXh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfpbxEkaW0Oii8z1w8dZFxiwotaCR1rBKnVuVhNetzA=;
 b=dj5gfjchaB7yPM8aTmfcv/dvYlvyPrfP5qOJs21gvFdkJieL5CPCDs/5xKp6HaYR1w3KQe8fv5QYT16VA8yqyiSYwy9dZuh+FbpxsY5ARl+8i+ZSNeox9W5Ez0RgoTvXcBI3XH4ReN2RR7Vc8dgFNWIvK76EOYJJRkcVdryCKS0Bt+gLhyv8DNxvIDUW5NK9mCJwXExTIneU5gXD02U9wsPZTWhZuYtVVmuXeo0+L37/EX4SO3mv+sfxf6otv1Izqv/q5q0P2zj/f/Sv8BpBvsCHIDJJpB7nVUciq8lERnuvUOmJv1y5duFqjiQTcR1uXfywGt38qUJsZdMD2bHcdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfpbxEkaW0Oii8z1w8dZFxiwotaCR1rBKnVuVhNetzA=;
 b=EqVDJr77aDTXOLOImNfcmRpFTDBEX1cSv3IgL0ri2z9rBkgmlY4dCs4LqUvBfFIPTBRrb7/8fdDTH7nkZQhnG2i1zITrMJDxl7qjkP/ZiobQ6QYsR5qI/q2BppkkfPaGxhB/KRk5MMVCAv7zQCS0e5qlsD22YOElopB95tEAFQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 20:25:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:25:19 +0000
Message-ID: <f337ec37-ad31-41c1-8af2-1b8b539e3a6d@amd.com>
Date: Wed, 17 Jul 2024 16:25:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/amdkfd: Validate user queue svm memory residency
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240715123502.7013-1-Philip.Yang@amd.com>
 <20240715123502.7013-7-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240715123502.7013-7-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: cb50ea08-bdd5-4b81-98ab-08dca69e93a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emxMWGNFaGxvNEQrcElFbSs3ZVBuNzRyOStLei9oYzIvYVpJek9WcDU5c05u?=
 =?utf-8?B?TTArZ2kvYUtraVpKM2UweDkxOEM3b1h1Vm10NkYxc0hYV2lJZ002WjFsNzdZ?=
 =?utf-8?B?NkxRd3QxRkF5TGVSNlNsWDUyT0pZaHJudE82VDc1UUlEN2FUUjBuNTBXNXRP?=
 =?utf-8?B?Vm9zMHhkV0RhcmwybWY2L1BpZFI0K0thdUxxRmtCVlcwSWZiQUl6ZjNWL3p5?=
 =?utf-8?B?c08xSVhYZWZ3UFE2U1NQQXloL0lmVGE4UDAwc3B4aVBkbVdEQ2x3LzZnd0VL?=
 =?utf-8?B?YStWVks1T2JtMkoyTUtSdG1tSHNoUUd5dkxvYWhrSnk1b1F6ZVdieVZxVlFr?=
 =?utf-8?B?OGpQTXRZdUUxZVQ1NER1eTNlZ09sRko4VkU1V3lFbUJZVXUyUVkvczFDZ05E?=
 =?utf-8?B?RnhZZy85VC9QRDNSN0I5eGxrKzF2MzZPbWRUdm9BaGxJcVhBZG9jZ1huSjM3?=
 =?utf-8?B?T2VXRGdXeGh0WTQxVklFYU95NnVwcHc0eW5SRUljYkRlOUR3ZXJCdWNBa1g0?=
 =?utf-8?B?TGZHaXFFWUsvWUlRbi9zZ2E0cnVjK3kwNUxBOFBwOEQxREgyK0oyMGx5T0RJ?=
 =?utf-8?B?OWdyN1dyM3Vjc0pRcWpYSGFUVzdnUFE0MVo2N0VKaFhkdlJQZ0h1WFQ1Qm1i?=
 =?utf-8?B?VnUvMHhMemxvTWdTZ0t5TUFrZzBldmhUWXJVUnpDcXZ5MXEwN0hDVnJwTDJT?=
 =?utf-8?B?Rnh0ZXY4cHNqVjRHdUxvMUlmU1MwOE5wcytzd1lGZ0RtKzdNVUVDQ1NSMkRk?=
 =?utf-8?B?cm0vbTZaWWZLT2UrRWdnR3V2RHJISnBBSDB2YXN2NmNoVjVSSGJNZUdWMy80?=
 =?utf-8?B?NDJVNHBudWZLK2J4UktXTkRhY0JWQ3B4RkVrR1gxOFFETG03RG4zVE9VdDFQ?=
 =?utf-8?B?RSszMFIwU0dRQk1oY29sR3BiWmdnRThSVWU0Y3FDcWVWenVEcDFoSHU3WkF4?=
 =?utf-8?B?WnRqT1BtNkpFVGRPTUJha0hUTVc5M3pFdUxiYm9WSm1EM2JnM0I5OTNGYnFO?=
 =?utf-8?B?Um1JTDBNS1E2SDFHVWEvbXhXejdaQlVxSFlTTWhJd09tcktLNUVxWnF0SXpW?=
 =?utf-8?B?R2xQUjZkQ3hCdG1odXcrdGxRK1dTc28xTjk3R1o1RnRQVXV5dURIT2lYOCto?=
 =?utf-8?B?eHdGVkxGbVZrK0dZNW1JQ3JmMmcxTTh4M01VZ2ZNZjRCS3hxMG5aaXFNQXFs?=
 =?utf-8?B?dm16SmhPcHFjNjBYVzQrc2IxTnNPaVN0MUxGZy91S0c0VzR0cXZWZ2VSR2l1?=
 =?utf-8?B?MHJ2bWkyOWVpVGx6RXUrZ2NFUFlqRDhqTDRadmszTGdwUGR2Q2NHbHdQenN4?=
 =?utf-8?B?SDd4WnN2NG5DZUl5a0loK0ZRaFdkRDIyc3FnU3JtLzhsSllKUzJpTDJRZDdK?=
 =?utf-8?B?d3BieUpzUFFPbjRjN3RtYjUzWjBBUVBScjlWUWhocTI0Tk1tZldwS29IeUV6?=
 =?utf-8?B?b2ZZOC9Jc01pTVdLY3VSTGRqTHdhZll4cDRsVnp6bVFma09yV0FxbWZ5bVpY?=
 =?utf-8?B?Nlkxd1dnMHFkRGZGY1Ira0NNaVNmQjZFck5GZ1I1cnIyMXRrRHczZ3pmc3lH?=
 =?utf-8?B?b3YyU0NON2QwdzZ1TDAwSlpIS1ZwSHg2K3dYdmR3V2FEaG9vUENtZWZodnhx?=
 =?utf-8?B?R1I1QTNpbHVwQ0VWNCtBVmlSbGNwendSam1sQndlZDUzNHVLUnVlSUdvLzZU?=
 =?utf-8?B?ZVhqcWVaazVQQmcwUHI4ZlZPYkdkc01lcUZoUmVKUGJyOWh0SytDZFMvVkds?=
 =?utf-8?B?NXdTdnA4TUZuMlJEZXJwaThwUGVkQzJmV0RVV1lENTZFZXU0VVdtRHBRZTJH?=
 =?utf-8?B?ZldLZ2M2d1FOU2JWaWttQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFkTFplbFQvaG10UHAvQzBuZ0o4eGRWTDZzOTVxV2FwOWVsbThPMHJNeHd4?=
 =?utf-8?B?eXM4OEErNUwreEtLNHM1KzhzTzNXcUJTaFpRRVNyaEpudFpXaEF2MmRtdGhE?=
 =?utf-8?B?VlNNaERBenlIRFJUL3l5dDl5R0N0aTcxS0hJMFplU0xvU3I1UysxYkhNeHVk?=
 =?utf-8?B?UDZGcGZ5WnF5MjZCOHFGSnYwS0k2SXRQYWVNRHNqY2FoNUZEeDVHNEl4eFp4?=
 =?utf-8?B?eHMrTlIrNGtibHpPZFo0ZWpYV2lpL1d3eFdMUmxOcDFXMDhFaXM5L0I4cE12?=
 =?utf-8?B?VFM5MldqSFhmUWFucXZJMVVuTC9DZU94UXlJZnZUaW1RSVh1VFZKM3E1MXJX?=
 =?utf-8?B?Q1JQb29vczdmMm91Z0c3U3BhdnZ2R2tyOFBSZVpBNjdWVFdnZmZVaTVCaUJH?=
 =?utf-8?B?QTZ1Q3QycmpGanFZSnlCUjhzc0JXbXdNQ2JZdHJZUWNCbUU5bFpoeEt0SHAy?=
 =?utf-8?B?amRWMEVCdGVlcjZvSUF1dmhqSG1pMGZBUHZQNHh1UnhaSWJhWFRIZHlNeExw?=
 =?utf-8?B?YzQ1dzlOR01wYUdwbmVSeG1DTTFDYUNUVS9JQWE1QktjcUk3TVZqaUNaQU96?=
 =?utf-8?B?bSttYWFDaEtjWTNEVXhVcVVHSnIwZ2JuOW4zL011L1NOUWp0d3E5WjVHMUhX?=
 =?utf-8?B?MGVWdSszZWp6bVJXZzI5Vi9OL29YZjFBb01Nd1RFcUxmYjNlN1F6MVl5b3FB?=
 =?utf-8?B?T2g3OGtQVlFTdWFvTTRMTkJoTlNrNXBsR1Q5ZXRQbVEzMmV1OWtPNUFHVi84?=
 =?utf-8?B?Rm52QXlQa0twTXdjb3IwT2FWZ3BoU0hWQy9ZM2pFWTBEZW00dkdFVHd5dTJa?=
 =?utf-8?B?clFjWENSbjFtelk3Mnk0YU5LVEZUVnZpeXRiY2JYSmpVajI2dUtienQ1K3Rr?=
 =?utf-8?B?NXY1OFNXbHUzVWpzMEJXcXVOSld2MEoramkrZXUwRUhxTFJWZ01lU09LcFZE?=
 =?utf-8?B?ZEpQV3YrQkkycTR2NmVjS2RUdGovM1I3SnJlNXlEbUpuU2MxeWd2UTBaRlJZ?=
 =?utf-8?B?Y0lQUUY1YmpETmRUU1BsZ2Z4cmpYc2RCWldlYk92YVB6L3U1UWdVR1NJd3VT?=
 =?utf-8?B?bG1veDc3eW9teWRPbzUwaGo1SW1vbSthSDBnRnBYamtCa2dQUGNZM1FwT0o1?=
 =?utf-8?B?TFU0UFRpK0V0d2t1VS9yUlR4Q09KMFFNLzh1NTkrLzNnamhMZzJiQ3ZuVTNO?=
 =?utf-8?B?Tm9GMGxUVDRaaTZiWnJKMUphRUVpKzhQSXl6RDRwUkhWWkY3M0NsTmZOT3NL?=
 =?utf-8?B?cmpzT1ZNRGk0QmgwOU5udjRCRGYyaHRYRFBrZENoNHBzQm9CclZMc21PMXFj?=
 =?utf-8?B?YmRWaXRycXYrMVFZSUMwRkplQlExT0VTSVYxajlUeU5NdGczYTVncXRFTURn?=
 =?utf-8?B?RVNDeXNPaWQ0M3h1SFdzZ3owOXdXN2NTME9McDVNdi9STDlDbFF2a2VsM01y?=
 =?utf-8?B?N0ZGVGpSdHUxOWhWa1M0TVBublJCYVZ1a2tiMFozQ2FRcUpGa1cwMlRHTlBJ?=
 =?utf-8?B?V0VrQ3ErZ0J0bCs0SHNvdW1US3RIUG43SUVTUHkwYnVxRGlMV3NLRTlYOTJp?=
 =?utf-8?B?R3loRmU5ZTROYWIwelUxNjM5bldCMWp4Yy9WcytFT1B4S3NRRkNkb3gzVGcw?=
 =?utf-8?B?emdIRlU1UmpRMytncEVYd0owbTNNQUxyanc2QzlpU0xqVTU2Q0JiSkRGNFhB?=
 =?utf-8?B?T1N0S3JnMnJQN1djQ0dUdjl0UForU3RNY0RPVnFQT3RqdGEzdVo5bEhtS2xB?=
 =?utf-8?B?RDV1Nnd6WktucXRlSUlkTWN3NVhRaTFtOWVxUVJCUy9zSEtXWnNjS1l4dFB3?=
 =?utf-8?B?emtYMkExV2N6SWVudzhHS2FWM2pGYXdrN0lYZVpoQitJRGxjZ0VGelhYK2dn?=
 =?utf-8?B?N1ppZW15RXN0cnREV3FPdk5MYWYwbmxzT0Rhalc4b3YvU0dDVXZ3clhtZC9m?=
 =?utf-8?B?WTBVdEl3MndNMmlPQ1lZL0pINTZWenV5SlhHQmNxWWhoWm5rVGhUb3o4ZzlU?=
 =?utf-8?B?dE9SUkExRmwwTXc2VENQdFlXZDQwZFd4QUxqeTdTRTc0N3Z2Q25KdUh0Ukxy?=
 =?utf-8?B?YUNMOXlOS1BGZ0tUbnhDZjUyM1FLU2xrajhBcEFlOExRYURiZXltbGtuWUxO?=
 =?utf-8?Q?gbhrtMDopZTzIrC25X7zrQ583?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb50ea08-bdd5-4b81-98ab-08dca69e93a8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:25:19.2959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSrGTCV3YHIAl4HMN5Jh7yeNT32XrFMmZ21/ThEZBZfBYyhLgFO6n4Rn6D0xOfVU+HVBFnwQCxg+LMEgGwv3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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


On 2024-07-15 08:34, Philip Yang wrote:
> Queue CWSR area maybe registered to GPU as svm memory, create queue to
> ensure svm mapped to GPU with KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED flag.
>
> Add queue_refcount to struct svm_range, to track queue CWSR area usage.
>
> Because unmap mmu notifier callback return value is ignored, if
> application unmap the CWSR area while queue is active, pr_warn message
> in dmesg log. To be safe, evict user queue.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 110 ++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  12 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   1 +
>   3 files changed, 122 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 3fd386dcb011..67242ce051b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -24,6 +24,7 @@
>   
>   #include <linux/slab.h>
>   #include "kfd_priv.h"
> +#include "kfd_svm.h"
>   
>   void print_queue_properties(struct queue_properties *q)
>   {
> @@ -83,6 +84,100 @@ void uninit_queue(struct queue *q)
>   	kfree(q);
>   }
>   
> +static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
> +{
> +	struct kfd_process *p = pdd->process;
> +	struct list_head update_list;
> +	struct svm_range *prange;
> +	int ret = -EINVAL;
> +
> +	INIT_LIST_HEAD(&update_list);
> +	addr >>= PAGE_SHIFT;
> +	size >>= PAGE_SHIFT;
> +
> +	mutex_lock(&p->svms.lock);
> +
> +	/*
> +	 * range may split to multiple svm pranges aligned to granularity boundaery.
> +	 */
> +	while (size) {
> +		uint32_t gpuid, gpuidx;
> +		int r;
> +
> +		prange = svm_range_from_addr(&p->svms, addr, NULL);
> +		if (!prange)
> +			break;
> +
> +		if (!prange->mapped_to_gpu)
> +			break;
> +
> +		r = kfd_process_gpuid_from_node(p, pdd->dev, &gpuid, &gpuidx);
> +		if (r < 0)
> +			break;
> +		if (!test_bit(gpuidx, prange->bitmap_access) &&
> +		    !test_bit(gpuidx, prange->bitmap_aip))
> +			break;
> +
> +		if (!(prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED))
> +			break;
> +
> +		list_add(&prange->update_list, &update_list);
> +
> +		if (prange->last - prange->start + 1 >= size) {
> +			size = 0;
> +			break;
> +		}
> +
> +		size -= prange->last - prange->start + 1;
> +		addr += prange->last - prange->start + 1;
> +	}
> +	if (size) {
> +		pr_debug("[0x%llx 0x%llx] not registered\n", addr, addr + size - 1);
> +		goto out_unlock;
> +	}
> +
> +	list_for_each_entry(prange, &update_list, update_list)
> +		atomic_inc(&prange->queue_refcount);
> +	ret = 0;
> +
> +out_unlock:
> +	mutex_unlock(&p->svms.lock);
> +	return ret;
> +}
> +
> +static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u64 size)
> +{
> +	struct kfd_process *p = pdd->process;
> +	struct svm_range *prange, *pchild;
> +	struct interval_tree_node *node;
> +	unsigned long last;
> +
> +	addr >>= PAGE_SHIFT;
> +	last = addr + (size >> PAGE_SHIFT) - 1;
> +
> +	mutex_lock(&p->svms.lock);
> +
> +	node = interval_tree_iter_first(&p->svms.objects, addr, last);
> +	while (node) {
> +		struct interval_tree_node *next_node;
> +		unsigned long next_start;
> +
> +		prange = container_of(node, struct svm_range, it_node);
> +		next_node = interval_tree_iter_next(node, addr, last);
> +		next_start = min(node->last, last) + 1;
> +
> +		if (atomic_add_unless(&prange->queue_refcount, -1, 0)) {
> +			list_for_each_entry(pchild, &prange->child_list, child_list)
> +				atomic_add_unless(&pchild->queue_refcount, -1, 0);
> +		}
> +
> +		node = next_node;
> +		addr = next_start;
> +	}
> +
> +	mutex_unlock(&p->svms.lock);
> +}
> +
>   int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>   			 u64 expected_size)
>   {
> @@ -165,8 +260,17 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   
>   	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
>   				   &properties->cwsr_bo, 0);
> +	if (!err)
> +		goto out_unreserve;
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
> +				       properties->ctx_save_restore_area_size);
>   	if (err)
> -		goto out_err_unreserve;
> +		goto out_err_release;
> +
> +	return 0;
>   
>   out_unreserve:
>   	amdgpu_bo_unreserve(vm->root.bo);
> @@ -174,6 +278,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   
>   out_err_unreserve:
>   	amdgpu_bo_unreserve(vm->root.bo);
> +out_err_release:
>   	kfd_queue_release_buffers(pdd, properties);
>   	return err;
>   }
> @@ -195,5 +300,8 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	kfd_queue_buffer_put(vm, &properties->cwsr_bo);
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
> +
> +	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address,
> +				 properties->ctx_save_restore_area_size);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index bd9c2921e0dc..2339bbdf452f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1051,6 +1051,7 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   	new->mapped_to_gpu = old->mapped_to_gpu;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
> +	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
>   
>   	return 0;
>   }
> @@ -1992,6 +1993,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	new->vram_pages = old->vram_pages;
>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
> +	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
>   
>   	return new;
>   }
> @@ -2444,6 +2446,16 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	unsigned long s, l;
>   	bool unmap_parent;
>   
> +	if (atomic_read(&prange->queue_refcount)) {
> +		int r;
> +
> +		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
> +			prange->start << PAGE_SHIFT);
> +		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
> +		if (r)
> +			pr_debug("failed %d to quiesce KFD queues\n", r);
> +	}
> +
>   	p = kfd_lookup_process_by_mm(mm);
>   	if (!p)
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 70c1776611c4..747325a2ea89 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -137,6 +137,7 @@ struct svm_range {
>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>   	bool				mapped_to_gpu;
> +	atomic_t			queue_refcount;
>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
