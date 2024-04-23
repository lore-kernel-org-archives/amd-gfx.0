Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05E1C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 22:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4147510EAF0;
	Tue, 23 Apr 2024 22:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UT5FknVl";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF1A10EAF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 22:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR/eRISF8t44Z/TMUOZFws6dMWg/WEWgaf34e1JSGOJfAjCTznUNTGBumpI6GrPrKmNdKOEusozXqEBjwgrk/8yaX0uGmn098BQcPwt/U/5kZc7pux2xWfn9F/3k8o8umSsY/dTyayIdk0h85uAzJ6OsiZDygDS/QXcPzyzmYBkZtY0u9SL8ErCb6/khL1v+RoxIo2sD74snwkgFu9bNVHIIO+8HybqVT+aRh9Xe7viTCBS5dW3r5miUQlUsAUI1xwOKrHcefuRhSkN+Z8lAKiOChh1jpZ30sAiIN1Xm3ZzxzDQKGFSwn68s4Q9w1vEpd0+1qgYByGjM+WjAP/vJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9vNK3JOLdl2S35NtbiECvEoT0BMMcB3suF2lrHsvIU=;
 b=KIUVNJhpA4lh6QN4Huy0hQYH2w38PWYFk5Mcfpebl9RdhfI2OsOYDPArAsCwdZ2giJYH50Vs9vrmihFsoLI0brs8s6yud7YavO8ytjuBpD7tNdlnPna/QHCjD91/ab+oeLg17Q8cxEHOgY08SFqb/TwGBqRStgDOfbGbNgmvjmcALaw8NMGjg+WfH/9GbeJSMcw0YWzX6+sCkeOvzi4dGRfdMLRK+NFi1kaFvTGFsmsdn2xE2GBuwM2TKUKUZDr2Tt9cdLdD8GeuP8a8YdpqTdGVB5wUXetwm+o3iZvI9726ddTqvExLbfY5TaLzIMU0tERg+eFjFpigpTcAZn1qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9vNK3JOLdl2S35NtbiECvEoT0BMMcB3suF2lrHsvIU=;
 b=UT5FknVl5Q80DAXNJj71/yaySKRw3QLHox5QqPorcNFIIdegg+4jqM+0RY6PNfKxPqcmS5vfBCr5cc3xcFnmiQECDHplgigN6wU9QzaZwNGzCDEK+wKYsD6Co6zAO1UPMqWFEay7cmvu9X1fPgLYJESjhpocWst5qAnnF0tp3Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 22:16:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 22:16:08 +0000
Message-ID: <26d6ddd6-f0f9-4d5e-915a-98c1901b6f98@amd.com>
Date: Tue, 23 Apr 2024 18:16:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] drm/amdgpu: Evict BOs from same process for
 contiguous allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423152900.533-1-Philip.Yang@amd.com>
 <20240423152900.533-4-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240423152900.533-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: a464957b-474e-4688-879f-08dc63e2f982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTc2MmtkaDJYNXZGK1lSMml5amxZblRmUlpHbmlYemdUTXNjSFBIZllRSlBQ?=
 =?utf-8?B?Y0hrZlF6MElCNnlsWlBYSGoxSmxQOFpjWHFnNmthTERCUXlYSG1MeTNMd2VF?=
 =?utf-8?B?QzREZVU4elNEYnlpZW5wWGNoVU1iT0l4bERSQjdEVUd0ZlloMzdGQVJud2FD?=
 =?utf-8?B?c29PSDN0SmZGTnEwLzZHeWRLOGFxUjhLREhuNW5TWDNZMVhINzM4ZlBodTVR?=
 =?utf-8?B?b1I5NmRZd0pPK0U3ZDhWZFRyZWRMMzJXRDF3ZVhzWWFFWTVXWWtURCtNbHps?=
 =?utf-8?B?SWtMRU5rbjJ0NHQybjlvcnkxRnFYOWcxbko4aTJTc1N1eTNoQ2lwSzVST2t6?=
 =?utf-8?B?SERmRUpLbTkyemg2VWRhQlRTbjZ0R0VGYm5RT25pOGNLNGZTbmlWdmlFUmdt?=
 =?utf-8?B?MlpHU0g3M2pYSnp1czlEa2t1WXhkRDB2ZUs0RVZsMGE2akhNRnZScmJRUXNJ?=
 =?utf-8?B?bWI0Y3BKNm0rbHFoc1k1Vi9HWXA1YU0zTmU2VE9xMXZURmlHWTZXZGNYV3ZG?=
 =?utf-8?B?allPS3Vxd2t6dmo2OGc2UTBZSytoSlNSYnQ4SnVMVFVlb3hzYmFqUDRFNzhV?=
 =?utf-8?B?R0JaeENvTy9qOTI5b2llYzU3cHhhZVcyTDN0eDBabWorVWMxb3lyMm43QzBT?=
 =?utf-8?B?aUp4UFBlRWdhZnB2dVI2ZDFrOHNFbnJFQWtJbHVkb1gzL1VLVUJSU1BZaXd1?=
 =?utf-8?B?eGFTbkpPL0FyT1pqVnV6TDBieXNudVhabXRHU3IzTWxtUnREWE0vZjljRkJV?=
 =?utf-8?B?bUVRb0xMaXdZU2VkSU43MEUrUkIvNnk2YlNvdmZrRGFjM205VlJ6aitGeVdM?=
 =?utf-8?B?VktoS2JYb3YxaVpKeVZMOHlWWmRyVmN4MnVJR0RURmFYMTdXWXJ5NFhSVkRR?=
 =?utf-8?B?aU9ZS3pSVjhmRGtFSS90RkluNDhDS0hFb1ZVY3lhRjQyMFRtMkVxVy9NZ285?=
 =?utf-8?B?b2RvMkVXWkZQdWRUdWhEenNWaUM0VVF4M20zeEJsN1JXVWpTNFYvVWNEUldi?=
 =?utf-8?B?YnBFaHF0R0srdG9FRUJkaHpzdEtSa2dxZWJ1WUw2TzIvRWlEMGpteklEWVp3?=
 =?utf-8?B?RDN2ZjgzekI1bVlrMVdiM0d4MkxrT1gyQmFsaXd3M2xDNUc5Wkg0SVUzSzVz?=
 =?utf-8?B?eTU3Z3B2dnNaVnhnNGZsdm51UFJDZ1YyRHkxYm9LeEpndjduUnhWNW1UMHZs?=
 =?utf-8?B?eDNDZEhxMFRkaU80OThpcDk3RTZCOC84MzNIb3NVTEhaOWxjRmJ6RHYwMm1o?=
 =?utf-8?B?WHNzSEZaK2dLWTFtRFphZmIzMmJuWHI3YktLdG5GMGNpcnloZUFkenROcVd5?=
 =?utf-8?B?dVVGZDVsQjVuWm1TZHVqanp1S3dnbThWV1dQMmZpbWZ1SFd2MGM1RFZsQ01B?=
 =?utf-8?B?TkZkK1U3cHhGR2tkcVQzRFFycmdVdFNmQlV0OHFKenBpUGxReEdYQ2s1T25N?=
 =?utf-8?B?RHhOazkxWDM3MFU0OUR6TVgwM0w0NUlqQWZCN3VId041THBrbzZZR1k5K1p4?=
 =?utf-8?B?REZYRVhMSTlSNzVwejNvMGh2TzJYTDU2NzFMY3B1WStzMlBTZEc1YzJQRUpq?=
 =?utf-8?B?dEhPa2NRLzZ3SjdiNzFqKzlDc1M4M2FncjYvVWxjYnV4SXZtMFNvdUxZbmlN?=
 =?utf-8?B?R28yOFlJZDJRQ3pOMnZVNFdkODlRWGJGSGJiVjJEUFpqQi9lMCs5TVZZeFJn?=
 =?utf-8?B?Ump2emEwNzc5RWtHRGEyMUl2VkJpMUVoWWc1Ti96UGdWZUpYVmdGMjlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5vekZPcis4ZE9KVTdUMStoanFzQVB5eXlIR0wxc0p1S0JTRGdMZTV3RlFK?=
 =?utf-8?B?TUhPRTlIZTdWMWlaL2F2a2hNTVA5UTJVK1NBWnU1ZENvWGMzcGRtNHFlUEJY?=
 =?utf-8?B?eUZrc3ZqMm9qR0RnaGkvTi9Id2JwV0NyeTlQRjN3TUVhejRFRXpSVkZINGJR?=
 =?utf-8?B?a2FIWS9MZmhnT0JCU3pJeklHZEswTVRsZ014dyt0eHlkN2s4RjIyUGZhLzQ2?=
 =?utf-8?B?c0ZsRFJDS1Y5dDhmNVYyTEl5OHZmMC9UckRtQ0krdUhrRkgzbFY4Q3VqeHU3?=
 =?utf-8?B?MkZkMy8vUXZ5STcxb2Rtcks1S0VlYWNXZnd1RVNGMnNRRTdndkdNUmhrV1Vr?=
 =?utf-8?B?MmtSYlhoSlMrd2VpTmxlU0hndC9LbHBVZEY1SnhUeHFmSnY2WndGOFR2NlNq?=
 =?utf-8?B?OU5SekVYdTAwYlZGdmVqd1hkS2gzaTVlaHVkMjk5Unl2WmI5Y3VtazU2UXJQ?=
 =?utf-8?B?S0lOclFJS0k5NUNzdmFVSE12Nkp2M1lMSnNmeTFkdFRscG1KQWp5TXFIUy9i?=
 =?utf-8?B?eTJ2dGFiQUw0Mk0wb3U5dzVjMENTR3JBT3Bxd1NHdlJQNTFuSGkxMW1QRlpW?=
 =?utf-8?B?ZjhsK3BLWE9aN3FlOG1YcXVGaVZjNHJPd1VENzUwSjZmbFJReDhWSXR0RHh4?=
 =?utf-8?B?ekhaejljVFhTdTJMUC9xRHFIa1Qrdkw0bnhyTHNUbDhlY2FPeEJzYjJvNHk1?=
 =?utf-8?B?cC9KYU84NmZIaWZKL1ZEOVF6VnoxQVlCZU92UW8rZGVuTTBGODNKUHprR3du?=
 =?utf-8?B?VWg1RDMwNlhsdWZwcFQxUWdNK21mZTc1YlF2T2dVVWRFTTVSMkJGZi93K2FI?=
 =?utf-8?B?UTNXaTR4eWJkTVoyWXhWYlV1dGQ5N3NBZWJsUnIwVU40VlRFY2tvSzMyVU82?=
 =?utf-8?B?d1B6WWFUNFRCdVZTRkNha2NSRlZZTXlEV1lIcU5qYjBBVXIxWGM0MUs5aVpY?=
 =?utf-8?B?dGkvTFVOaDAySkVhMVNFcnJHRU5iak0zT2Z6cWx4OGUrNlJFOGEzT3VSU0xP?=
 =?utf-8?B?R1kydGM4dHlyNjRnUitmc1d0bjRlZzB5Vkh2ZGhuNU9XY1R3Q0R4ZkRqQXBn?=
 =?utf-8?B?ZFRNRDFuWEQ2blVzY21SZjR4VlNqU05qaDdPWmtYYnNCdHdQWTk0RlhkeGI5?=
 =?utf-8?B?MysvREd0WS9FQVlodC9ab2tlYVlwTm8yMTFNWVY3bk54YStkSS9FSlE3M0dK?=
 =?utf-8?B?djZ1aG5LRlB2TTVZQW9TLzNpeHFvYkQ2MjJFYllqam54RkF4eU5rZTJleEtN?=
 =?utf-8?B?eTN5aG9ubmVuQXFWQUdvZVIrTXpGWWFOZ1hsVCt4czQ5Nm1rVmJ1TENXNjBw?=
 =?utf-8?B?UXJHS2hXQXVRSk5SazhVZkNUMmZPWDE1Y1NoR0lGRThEcUtmcmNUSVlGN1U3?=
 =?utf-8?B?WXQzcVhyVGRsdlF3ZUZYYTFYa29HSXhub3M3MHFvZ3Z5OGNWdFpXeFNCTmVx?=
 =?utf-8?B?UDFuaW4yamVjcm5VbjIybFpsTERhWVZ0OWduVlJtSkRyQ3daMGFYeXZkeHQ0?=
 =?utf-8?B?a3NNZ0Jnb3hsS1FFQ3NNZU1JTVZvQWVZT0tmbjJwQ0N4aXVBdWNreGI0UER4?=
 =?utf-8?B?d1VaaW5LZnFQMWN5YmhUNGw1UmhwNHF1WWVmdjIrYjI0RE9heXZtZEIxTzQy?=
 =?utf-8?B?OG5xbTRUTDFCNk9mVGJTazk2VGJiNTYvZHFQRlZaeWFheERGTldLNnpreFRT?=
 =?utf-8?B?ZkZ6MjRjNjhJYjlLY0xWbFVhUVA5amRuWHZZRWVhMUg0UnJZcWdpUVcveVM4?=
 =?utf-8?B?OTRJaFJacHBpczBpWWRKTXlKME9VamRhR0RZL1NFSzZTc3d5Z2laNVRtTy9p?=
 =?utf-8?B?eUpqSW9jK2NBNnFwNGp3YlBtVmtLVytLR0hZdk00WHJCYmh5R2QzYnZjdW94?=
 =?utf-8?B?a2Y1REFSNytyQmFzbktPY2FlNFdrL2xtTHJuL1lFYUVDSFMwaWc4akV3aWtJ?=
 =?utf-8?B?MzVKZFAyWlJndTd5SVFnTCtsWWNjbTlnS1pXK1V2ZG95YVo0YmlJWnlZMTcr?=
 =?utf-8?B?V09Xek0zSk93Z2lZYThLMHp6NGdaZkRKS1o0ckN5RGowYkl6QXEyWXlYMTJ1?=
 =?utf-8?B?Y3ZZYTl5R0k5TW9rbmQvZXpmNXQzUEZWUVVJREx0d1lUNkEvMkVzNWpnUVI2?=
 =?utf-8?Q?xGXUamUfsh4d8nwHI1pdFE6qf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a464957b-474e-4688-879f-08dc63e2f982
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 22:16:08.0564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUJR+LYKgVe/wAWn8h9k3O4rytdCW0GeYHRoV4EdqzrUYvCFx6ECdpxjH44+8rpk3q0C0/mUXVn4xK4vqnfD4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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

On 2024-04-23 11:28, Philip Yang wrote:
> When TTM failed to alloc VRAM, TTM try evict BOs from VRAM to system
> memory then retry the allocation, this skips the KFD BOs from the same
> process because KFD require all BOs are resident for user queues.
>
> If TTM with TTM_PL_FLAG_CONTIGUOUS flag to alloc contiguous VRAM, allow
> TTM evict KFD BOs from the same process, this will evict the user queues
> first, and restore the queues later after contiguous VRAM allocation.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 851509c6e90e..c907d6005641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1398,7 +1398,8 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
>   	 */
>   	dma_resv_for_each_fence(&resv_cursor, bo->base.resv,
>   				DMA_RESV_USAGE_BOOKKEEP, f) {
> -		if (amdkfd_fence_check_mm(f, current->mm))
> +		if (amdkfd_fence_check_mm(f, current->mm) &&
> +		    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
>   			return false;
>   	}
>   
