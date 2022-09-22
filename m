Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D42C6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 17:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF6010E10F;
	Thu, 22 Sep 2022 17:14:19 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E40610E10F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 17:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBf53lxpxlLLmP4bvR3NfO8eyIP4R0Kw2svyU6qfoEOD235RxAJdmOrcnjyx3O16zc4efBsdi+dILm51zUzxGjy9HGIf2cV1NXw9q5Y6U4WOQZAk5BgVwKlNc2YkiZJ/pKSIUJU5Oj/MG30BYLMG8GPteJUXhbaajB8CP7E4OThfDJGjio0yYCHMvg8S30QHakN6iO8w76FRPi4ROuSaux0Vhu63reSCSO46oswKMkB9clnGNvlNq8vWihv2xDbSMt6eQI0qPVwBI96cCT96qVG4T+r0PhS14J0Jb5AmLOO6BEkGRke4aw4uM3gHu7fmqYOyOGUF3nbFMd7ACcfS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRh/JX+0EKXw4HFlD/jhkd94mBGTp9b3LccTQxGKnnU=;
 b=co0uB+l9xuXWIcLktFl6vOBUc8WMpQ1DC8wzQF4OuqUHdV3r8mxQLvO75D0gdVw+9K9Dch1Le9GHuNj1YO9R/FL4v8UukfANDNEXq4hpWJBRFoFl9liohpBw+zftDBgiBQ7/OO/F3SOwAFcWlIghLqMMz66Yoe3K9HEffP84uXkRPyqoiMYSqQKnJvzFs7meTfsmfhhfVR5oK+pvfijaKm23yTkLkjFmV2tdHwzMDinO0nL6JMbLymvEGtMKOmpaQXh2mAjl7r+RK/8H+9LcXpFqtmeysgIDx3Xpzhe2jO4s/X19TC4lFHTfFavRFJ/SBZ+MtefJo814CLa/7trpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRh/JX+0EKXw4HFlD/jhkd94mBGTp9b3LccTQxGKnnU=;
 b=UumPdw0vFhhghMAWyLgv03/W3jYjlEfh473xIaaoH9BAUU7aXF4J/E3qoV7hC7/S1bbhXNbHfhdcxJatIpMTR12q8qaG1/BXFIWHjISjEg5Jb2rcgfxBkJoT84vB8IPVtizfaGAGiJhK48pMN3rG6ZunS2r+BoDn+OLnbpLBbs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 17:14:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:14:15 +0000
Message-ID: <2943b204-2999-b6f7-1f30-bdeb85a711cb@amd.com>
Date: Thu, 22 Sep 2022 13:14:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Enable SA software trap.
Content-Language: en-US
To: David Belanger <david.belanger@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220922161703.916705-1-david.belanger@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220922161703.916705-1-david.belanger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 262971f4-5472-4edc-569e-08da9cbde041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7RH85su3C33W9yobCEOskYu9PbCgTwpUOtN6kNmcWxSPlB/Og17QkEKYDV7819yAwcX0T8/RbVBylfvEPU/x2Xy5mGHHrwqK4k5FUQuzNkC/f5vXxxAaUCPO+CAUuUZdihf4nC43S4v+/sJqaMsnfQ7MU4jAEe8/2kpcodKgm7+BpDaO35Y2A7eem3sK+TusWOKMoqV5yn+laIccLawQHUwvqmnl+wHnKwFvVQoSzX7+B9Lvh3/BsUEXD28ni5/YiOVD36hTt/zXnJjbX0+LRse9uZtMR0hbRz3T0xzfNVBHuE22h7KZ31r2y1fUDipdy3hsr57xpHrJAwc0lSIPydyF8Nvwv6S1glKPa4YtVaedQqL/HrE95OMIcRGQI03iaYjKDlOXYAPoglOFYpE0bfYDkfxrtFllyieh8vdoSh2qIlOUtKrOE/2hNZk2D42o3S2jZMEXhTLoh4ntztXBn3NtKfA2uYH0knUWg5Ky6MabZAl4gTQ77ulC1f7kZynnWqZX3MKkfSPeVOG6+W27NwMD28WoFJ8xTxIMMsoWYXp2PlGC13mX7bxDKMUxKrzwZASLmv5CK/+v2oeErPKUhjgWkP+l6Wk4IgQvw4JBKR98kKHUVMUXYwYEQD24BANToNtr5mDmVbnZofA2IUKIgfdEdnZhBgunw69JIJqVn3T7Afi5LWaDCYPg5ZuhlmCecU8iFry645hFlKfG0aJ1gQ6NGICBpXBnr0SPsYXntl89PrGW9vlBqnQ/wBZMydOPww8TCJF/4XuKvMIDs2y+p5u8LM/baeE50BnQS9tB6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(6486002)(31686004)(26005)(6512007)(41300700001)(6506007)(316002)(8676002)(186003)(2616005)(86362001)(31696002)(66476007)(83380400001)(5660300002)(66556008)(2906002)(38100700002)(44832011)(4326008)(66946007)(478600001)(36756003)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU4rcGJ4YnphUjdWU1ZFZU1wcTMvcm5la3pJTEMzbE9LakVkb3dKY1MzZUZy?=
 =?utf-8?B?ZWNGLzhEUm1UYk5oWTgvd0RyQ2hhTkRRbVVLbnZIYW5SbnF3U2hPQlBheEp2?=
 =?utf-8?B?N1BySytpSGZKL3ExTjJSeVFLME90STZPS0dGMlBsaDhvRG5TWWYvWUJSMHJV?=
 =?utf-8?B?NGcyOURDWnQ4VmhSdVoxTXRUaGNYN2NPdnBWZ216TlRJRVFqT09peTVBZ3BZ?=
 =?utf-8?B?NzdNMVQ3Z3ZnK0dFVmR6YlZYUWtFeGEwWmpuY05OY2Qwc085VnFjeWhxMVNR?=
 =?utf-8?B?R3d4Y1d1TmdYTEZPaGRqdGpSMmVoNjBZaXhhbUd1eFFZanZSSFVVOGVzYklw?=
 =?utf-8?B?NVZ6bER5SFNxc1d2US9mK3EzTWNpQ2EwMXZFODRhQmQ3Z2owQ0VFOVk2MGk0?=
 =?utf-8?B?N2RhUkVqd3BXdmZuL05hczE1WDlZVFkrZEtkRFp6czlKeW1tNXlEWkg5YUZK?=
 =?utf-8?B?MEZuYVFQamhYTWRmTFREcXc5eDJvRGIwaTFsbXU2MWR2YzB5M2piUHRDdFZD?=
 =?utf-8?B?UjJoVHVtZCtjOEFTd1N6Q2Z3Qkw2cHpBdUNEQXBrZk8wSFJDVGlKRklSKzJW?=
 =?utf-8?B?OFd4b0pYUzBRZ2NvNURWdHRRRHE5ZjRjbzZzbkgwbERncE1ENkN1R25nZG55?=
 =?utf-8?B?UXVEelRhNE5PUlViMHFPRFFDSEwyNjk3OEM0VEVMa2IyWWEybWQ5aDI4MDRI?=
 =?utf-8?B?NlhKZWlxaWIwUlIxdEJ1Zi9KdkxIdVM0MEgrOXBDNFE2S3RCNXVkbzZRSkdN?=
 =?utf-8?B?dnJ2bnFISnJOaFhoMENUUWRQc200d1ZzNnJubzdsOVcyZXNLNDdJcE5pNXNh?=
 =?utf-8?B?ZXoxeGJzRGVDTlA4dVdRUXZvMlNZRWJHazA1QXBMeUJCQlJzV3FZZkYzd2RB?=
 =?utf-8?B?NXBLMXl6eWlVZ0ZHaGtRWjBNZW9zcUxBUW50b0dXTXpXSTFkdTlLeEg4eXVJ?=
 =?utf-8?B?WlNTcG1jU1g0QlhrMEt6TEY2RWJ3M1QzN2x1ajR6UXZYTEJmVjVZR0M0blBV?=
 =?utf-8?B?eERaVG9VQkZKM202Z2J6VzAvdkpoV1hIMHdhWTdEdTBrZ1FXa0dFVEs3KzF4?=
 =?utf-8?B?MGNwY1NGUnhhWkExQ0pETlhmdC9vSnFYSGR4cHd3a3ZTVmNISGxzRjEvUEF6?=
 =?utf-8?B?K0lnanZZakRLUTBsY0tFc2xuQVJnV0tlQS9FYW0wV0dlaFg5V1VzUkFIWXZP?=
 =?utf-8?B?MU1Ed1d0SXB1UnhNOUYvcjY1aXJpSmE5UG4yMzU4RzZQVjdRVncvdG5WdUI5?=
 =?utf-8?B?ZzRid1d3MThXNGV4OE1rcVVzQjJhWFd3V0cwMklKOXpsdkMzeWRiZmFPaXQv?=
 =?utf-8?B?SXRmUXlvTFp3UjJSOTNGSzJZME1QdnJzcmJJTTY0OWdnbUhXZThDOFVKUVlk?=
 =?utf-8?B?NGZjcEVEREM0VEtpa09UNlo3V1RFdXpkU3VWcjBib0lHUHN2a0hFT2JOVE1a?=
 =?utf-8?B?ZURkM3daMkpLanc3TDZHOVY4SXN3THVUQW5XbUJUdFFEekUxZFNFck9wdHZK?=
 =?utf-8?B?NzVXOW9iU290R3hNcE1GUWZZSm1EeEhIa0xwcXNlNGlIUFI1QXAxK3E1ZmNu?=
 =?utf-8?B?WExtZnJITjhibUVpN2cvYWNMN0VxNUVKcnR5THQzWFZnek1aWElUMHVMMVhj?=
 =?utf-8?B?VTN6QkR3UyszNkIwZTN2bVBDd2dnTGFaZnVSbFhvNzY2TTMxUXVUUDFVQUNO?=
 =?utf-8?B?Ry94RVYwM3hJNEV4Snhoc2tlMTBEbDNqS3cyc0cyZHRVYXJMTWVmK3QreGh3?=
 =?utf-8?B?c2pNOWUya0hmbmVyZWpxd3UraDVtN3FZOXdlMzVTZnBDRmdtZUZlNjF2MDhu?=
 =?utf-8?B?QVJnMzliVXVUNTRTRkRTU1ZqSXlHZlVwbzFRQzNuWE82WlppZE1sRHk3ZWY3?=
 =?utf-8?B?dTB2NHpla3drRUw1aElScWxiemJXbkFtN3B5MHdVVnhpOEdwMTUrdFBwajM0?=
 =?utf-8?B?dHQwOFR3RTJSc3UyZHRKT3hIT0c1a2c3UDVWWW1WRVNBSGp0VFRNUFhYNytT?=
 =?utf-8?B?ZWxUUU5KSUpvaG85K1FHNENFWHJUT2FjY212WitBV1VTa3IzeFdxK3AxNDFt?=
 =?utf-8?B?MU01ZXlGY2YzSFhRZVp1dDcxdEQ2cEIwOUE3YVF5dzBqSldlUFVxdGpOT2E5?=
 =?utf-8?Q?U6iHx+IWxUzOqHfBIz+9ZsUfx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262971f4-5472-4edc-569e-08da9cbde041
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:14:15.3195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cd8oLAmX9yK8FkayzdORJcZhX9wbEUcY+g3FQLrWW0g5Z+1jFLi8T5iIedSEM1lVRi2zBu/9z7fWvwBlApe4/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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
Cc: Jay Cornwall <Jay.Cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-22 um 12:17 schrieb David Belanger:
> Enables support for software trap for MES >= 4.
> Adapted from implementation from Jay Cornwall.
>
> v2: Add IP version check in conditions.
>
> Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
> Signed-off-by: David Belanger <david.belanger@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   6 +-
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 771 +++++++++---------
>   .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  21 +
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  26 +-
>   4 files changed, 437 insertions(+), 387 deletions(-)
[snip]
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index a6fcbeeb7428..4e03d19e9333 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -358,13 +358,35 @@ static void event_interrupt_wq_v11(struct kfd_dev *dev,
>   				break;
>   			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
>   				print_sq_intr_info_error(context_id0, context_id1);
> +				sq_int_priv = REG_GET_FIELD(context_id0,
> +						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
>   				sq_int_errtype = REG_GET_FIELD(context_id0,
>   						SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE);
> -				if (sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
> -				    sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
> +
> +				switch (sq_int_errtype) {
> +				case SQ_INTERRUPT_ERROR_TYPE_EDC_FUE:
> +				case SQ_INTERRUPT_ERROR_TYPE_EDC_FED:
>   					event_interrupt_poison_consumption_v11(
>   							dev, pasid, source_id);
>   					return;
> +				case SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST:
> +					/*if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 4) &&
> +						  (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
> +						  (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3)))
> +						&& sq_int_priv)
> +						kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
> +							KFD_EC_MASK(EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION),
> +							NULL, 0);*/
> +					return;
> +				case SQ_INTERRUPT_ERROR_TYPE_MEMVIOL:
> +					/*if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 4) &&
> +						  (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
> +						  (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3)))
> +						&& sq_int_priv)
> +						kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
> +							KFD_EC_MASK(EC_QUEUE_WAVE_MEMORY_VIOLATION),
> +							NULL, 0);*/

Which branch is this for? kfd_set_dbg_ev_from_interrupt shouldn't exist 
on the upstream branch yet. That code is still under review for upstream.

Regards,
   Felix


> +					return;
>   				}
>   				break;
>   			default:
