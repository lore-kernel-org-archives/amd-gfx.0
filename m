Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A19CA5FCE
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 19:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4011610E1CB;
	Mon,  5 Oct 2026 19:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w5ApN1xk";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A741010E1CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 19:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRDYlGXXD+lQxoJ5vhmRlqW29isRF70c2DcJ4PRrrMZrMSTSyIRnYqFG9jDFLalgZ4KdoklvgyOG0sT9EMjF8bfrZ1DOM/weazfdUzr3ycoxH/1RDO6TD/7Nl1IV5kyAZA+XI1mezi2Da4yyABhwOpTgqMex05S0YBCxQfJ01aTxuNrXGqIrnm8Dskg7azEwfqaUOTmDGnIDDnhd1v+4/e/iV9ZUcYghDgM3GP/b7tY0O0ZvUBdbleN0z//lhzi3qoPYHO4FSygKBZDvRKEcadFWD4pMI4pLNxOK3NPDGIu5eJZy+1Cgvo8doSLbyRA6+ejwaUKHkkyl4rMkMRl06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjBMkU6i3Zvf/EZKIqNgRxYbYqmQPiyIn4RcvkHgsCo=;
 b=eP8//JiQUamji9cxxHQMBTP3agSqYSDDFAWyBXshHO3PePJjTU4vZgnwgVX8KfhxoVCLItBzqttu5jojGzyghF0+NqkxxqKx9yLOs1IcZf3YNDS5Mz2MZcnKX8q1Rjjus7VkjJjIh9MVd77GLwiIijpzh+HfP2Hww46gVWwkUxmgK+xewBINHt4lQal4irE2zcd8b9Vrp6brqbJCIuS4gatPVS6AhblcwPeQhq1xlZLOof2QpJxGej3fqW8OheAnqwv5I2EBowDEtaFQFJUTAVlmkQaa5nwMU9q76CkhiaonuwC9lgDX+H64XZj2tzXlIO8is4sDlSbxWBH2TR0Yvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjBMkU6i3Zvf/EZKIqNgRxYbYqmQPiyIn4RcvkHgsCo=;
 b=w5ApN1xkSyxv3sLFNGS2t0HuKeLgLymB9ciTgfi5wEfLMRk+IYVl2Ia0pEQa/1hVYufTu4+GXuFMCNsbQcj1WVNfk5BoyoUpPbhKisssvEy3sVDmxKk1Hr1W8P+J+DVRh/INUlRIGaQ3fXlWsy3z/QrimTgd4lEyR3NJd3eRIT4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MW3PR12MB4475.namprd12.prod.outlook.com
 (2603:10b6:303:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:03:56 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 19:03:56 +0000
Message-ID: <a1bc9a71-a352-4888-ad56-79da1f171b07@amd.com>
Date: Mon, 5 Oct 2026 15:03:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix svm_bo use after free in svm_range_clone
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261005185245.1060657-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261005185245.1060657-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::31) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: aba04254-343f-4007-aa38-08df2313677e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: JONytMGFHYX/TaxQTCqWwCmqNVWJl4BcTYAXuL3mtTN57pbrhPKFSS9FOqYPBLflcmTiEAfZijkRTmLDFjqAExRq5rpqNiEeiVarEyktgYZ6+YsAgDmZYBYZxiJZy8XbQP0FNs36MAMFBpy0w9oBeaEc9HHKHZjfLBUakeTknTSr6dYEhZKbcXf+YicgdzGILp6wS3zAgmY6aEmtET5QsI0637vPb/JNGgF13tO3Vl1EsHHqyWwCOxDWufJL2BTylsC3WPywSbX17HY8ghK3yx9XXiEPvgqc2NoZyi599+T4BZAeLYA5nE32ecGCxtnj175C56OXcgkH2098WXLlwKDFzVIwgRtgQJXPHzb971moAcKMu5AZumgcgoctJV0KzVFE1ukCzy5MfG9E1HMov5IahKPAfYhynah4UYxqDMEDRgfsiAf5V/sQ6a3ZSu/4px2Vaozcv/K46uASwHIWxAmZVKNva/fcQn8y6rUw+SpSHzWi5gIHiRThggqTB7AcvhqKgZKTOCSe5sajfGzO0HMeeiRchYzDpgzpUeBq6N+DMggCtjGwOiXeo/0zYqHp/lq72Y5hFjPT6QzHb91cB2mh05HZLTt/nv/ntec15K0l6Pbe/Orc8HqX+tvOlSCMRgJ4tLjf33qMbWtDjtw37DMA0rxjaTbJ7Gia31j8jbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGRHZmcrY1dzZnpIUFFTRG81M2FSVXJzcStPWlE1SkpGT2tJN21LalBGQkZ6?=
 =?utf-8?B?cjZ4Nk02bHJvS0VmUVZmekpjZlgyN3k1L3VCNXVOTEZVaVBDeU5MbkM1MXFx?=
 =?utf-8?B?bWgySGw0SVNRRlFuK2dqVVl3ZklmdjBwQWtZa3I1WUJrOUhQSUYwcVRuTjJN?=
 =?utf-8?B?U2RPZFFmU3lmckRLZ0wxdDJTbUhvanR4K1B5VkMzUzZhSU4zcVZFRkRhWWZT?=
 =?utf-8?B?UWxCcVE1TnFKRS9RVFF5VXJaNlJxUWhxano0akxETFNVRTBpL0IxMTRHMUU0?=
 =?utf-8?B?enJwZTdvRkd1U052YUVsY2d6Y0RUck96VWI0ZW5wdFZWaGU1RHkxOFgxRjl1?=
 =?utf-8?B?OEhmWlNsNGxEUVZmMXNOTmtLUUxIRUtzWjBYMjFCTWEvYkgxZVhIaDV4dnhS?=
 =?utf-8?B?TzlkRWtFTW9maldqTW9qeTdOYXhQajNRaHBNZzRreWt3UTJKSlJ5WFNtZEJD?=
 =?utf-8?B?V0ZxMVdRV3dtVlYyVy9Vc09VSHF2L1hqOFZGZFVhVUc1NEZUQ3Z4VzhyVm5Y?=
 =?utf-8?B?UGFsa0xYazUwZUhha1F0bUNTcHFSYVNnMDlkWjBxbjMwRWdJRENXOG9oUXJB?=
 =?utf-8?B?elhrTURkNnloZ3N0UHVNTU1UQ3BSUTRDK3J3SHVvNU1MR2lueTh2ZmYyU0hy?=
 =?utf-8?B?cTl6bFIrQkhTTk5CejNiS3JXL011QkVZT0xsRlBPVVZYMEt4T2ZabUwzdjJy?=
 =?utf-8?B?ZElVbkNYRk5JSVN5WkZaaG1GRE04Y0NjM09EMno2dXUwMnZIV2F5bHpuRjR5?=
 =?utf-8?B?T3IrWmNiYTcrK0N6cm45QTFVT2owaEsrNEJnVW9DTzNrajJWRGw1TkYxVlNk?=
 =?utf-8?B?ZkpLUWhaTGZIRWdDK1RTWHZtUU1OMTI2UUg0K1JPVVJBV2ppbmRPSW4xS1Za?=
 =?utf-8?B?a0d4TzBPUmRCalAvN1ZLcGhZeE9yNUJNNzBENEJjaGVERjRoYlFlVUgzc1ds?=
 =?utf-8?B?V3hkbkxyVklDVDB5cEhRendYcHhXREYrbzZBa1l5ZUt6a2RYTXIzYU5ZS0VP?=
 =?utf-8?B?RFpQbW1IeW15V3JCWVRyWHhQVzFvQUJSS3FCZFArcnlVa3VxeTJxMkFWanVt?=
 =?utf-8?B?b3YvbldnNjFQbVh5T1VHUDBCUk9YUVd0N04yZjJIVU5KS2lrZXZCakttSkVt?=
 =?utf-8?B?ZlFDZ0FXUHlZWWZoQ29DSTIxUHoyR05Nc0NhSnJoTEthMlhvUE96dDZLRk9M?=
 =?utf-8?B?WG10ZnNnaS9Mbk9TQUYzWmdPUGpzRURCbXZyY1RWbHJ1WldhR05FYTRjeldX?=
 =?utf-8?B?bXZlU1FBaHBaN2M1UG0rbGJmTTVqcHZvTS92N3JZNXJVSW5wVWxLRFFXZkRa?=
 =?utf-8?B?emVTV2Y1aDdaVWxIN0NyVVJTVVhVNk1hQTkwSEFCL2hjaFJCdVk3ME9iUkdx?=
 =?utf-8?B?c2dUQTNWY0FYOWRGbjZzUTJ2ZnpaVEJrUHhKZTQyL0pNZlFQRkZtaUpnOGpI?=
 =?utf-8?B?UldpNU1qYVpWWDJLTFpPVHR0QjRLVHJPeGQ0ZUpWTWQ2Qy9FZmJvRnMwU01m?=
 =?utf-8?B?d0dFbnN2ZDRkYXlhSGJrQXdCVFI4c251bzRPSlNrZUZqLyt0LzR3YThWMG1S?=
 =?utf-8?B?NXlZVmJxYmJ1bUN0SmhHZnFXRS9NNG5rVHprU2V0REZaYU5UbFVPWFpUVkor?=
 =?utf-8?B?OS9tNXF0ZlpCMVIvM0NJNmE4R1JrZXByd1U3bzVnOVZWLzhaWW1ucm5FcEM1?=
 =?utf-8?B?dm9sM1o1YmtwOFJJRjZWV25mS3g4NU9hMlNNUG14VTlUd0NzWm1meWdWMmxR?=
 =?utf-8?B?czZRdHNQaFk5MlJOUGNBZ0dtN0VwWlhpRkVlRm95b1RDS3U1c0Z1VXpqWHlr?=
 =?utf-8?B?Q2JBb1E4NGFhWUFqSWZjeFZxeUVldGpLWGo4eXFHLzNwVDNSNTFWK2owRUVu?=
 =?utf-8?B?S2krR1dwT1dmeXUyVENINXh4Y3J5ZnlHQ0lVRlFmMWF2UEFQc1lzMENHTS9r?=
 =?utf-8?B?bFhxWmdpNTNldG9yL2lxR3dUSFZaMjRZRnlTYUErZkFaQ1hYbElXcVlnZjFG?=
 =?utf-8?B?cFhIdk92TGMwKzRyVGNJUzQvaGdJQWdSQWQ1OU5mUGREVjE0Tld2c1BmN1cz?=
 =?utf-8?B?emtQbVRGS25BTlFLdTd2R1krRFdyNVZhZVhiMEdDQm1xS1VCaXlRRk1nMXRo?=
 =?utf-8?B?ZmhYazVFYUhiRjBoYTBCSW1PcDYyOVh0ZmFnQ2E4cWtDZWFhM0ZzbXdQOGRV?=
 =?utf-8?B?YUtVaXV3VmZsRGRFdnpxOUgyaStpS3BlQ0RML3ozTVF3Z1B1OEl0UVFwNlRv?=
 =?utf-8?B?bkZ4QmVNdmJWcTQxTVRoTndYYzZkd2xSVVUvQ2VSTnEwVVFIMk9Vc1g4a1ZJ?=
 =?utf-8?B?L0tqb3pHdS9DN3p0UThWUHJuaTRLVGI1akJKSmZnUlVUblJ0V1dVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba04254-343f-4007-aa38-08df2313677e
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:03:56.0053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2/yVg/PqVTgm5+vn90W/XM6rc6lMt45rAZhgzgnAQDjs62rRpJ0xjBJz3leJCEhWhqZDmwSnJf7n4skHcihuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
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

On 2026-10-05 14:52, Philip Yang wrote:
> prange->svm_bo stays set after the range drops its reference in
> svm_range_vram_node_free(), it is only cleared later by
> svm_range_bo_release(). Taking a new reference based on old->svm_bo can
> therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
> pending, leaving the clone with a freed svm_bo.
>
> Check old->ttm_res under old->lock instead, it is cleared together with
> the reference drop, same as svm_range_validate_svm_bo() does.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cfb428c72686..536e804bc2c5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2158,7 +2158,14 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   		svm_range_free(new, false);
>   		return NULL;
>   	}
> -	if (old->svm_bo) {
> +
> +	/*
> +	 * Only share svm_bo if old still holds a reference to it (ttm_res
> +	 * set). Otherwise old->svm_bo may already be at refcount 0 with
> +	 * svm_range_bo_release_async pending.
> +	 */
> +	mutex_lock(&old->lock);
> +	if (old->ttm_res) {

This seems to prevent some legitimate svm_bo sharing opportunities. Can 
we use svm_bo_ref_unless_zero to safely get a reference to the BO instead?

Regards,
   Felix


>   		new->ttm_res = old->ttm_res;
>   		new->offset = old->offset;
>   		new->svm_bo = svm_range_bo_ref(old->svm_bo);
> @@ -2166,6 +2173,8 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   		list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>   		spin_unlock(&new->svm_bo->list_lock);
>   	}
> +	mutex_unlock(&old->lock);
> +
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
