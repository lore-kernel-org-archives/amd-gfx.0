Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BECCC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA2EE11219E;
	Thu, 15 Oct 2026 08:21:59 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AE11121D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 08:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcDU2UPlaI/G8/dIElmUOFJs7d92bGWKdRgPPc0u3UnBhB8taHVrgSiZVMHjVQSnNNjjlAgLtnEkZ/UrvTUZcNH/kfpD4EUKqSWIvKEeTDoGIq12fULa8gSJqcadHCU3t43HmUvHCiGPO/JvZWk13S6c5ZrR8nQhoMnJjObR9GMAR/xjpbcBVYEIjlZX9OeDIzTjD/jmPKErZLZPWwu23REdPwutJSaC/I67Tp4Wv7g0DNIEKbY9KUij+9rsAYjY2w2gZry2yovmJNev9WIrCw4f75EEUbEaSNiThm1I854NVVjhGb66dFftouX1Dpn4I4rM9O2X8sKCXPh/u/yzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPfxPGJMSuqB1p/ibI0VzgQtxqGASe8UK3HKqR2mJMY=;
 b=JH4HWL4TKZIrD7d0wnmKDBbxj971XgAKnZL5sX52WiNWG8MJhLSYcdssBe8ZuErugjuAWQEqHHuCp60+s7fTj2EWdG1cLVh2yKyu5lwMNIRaPg2jP024M319ZLxbw7AiNFnIEifSXLWtSC5jE7P0bqsQJrQyOqXtP+7LukQ9m7L0MyqCbuTrEZ82ChToppPnWVXiUIwN46i1J2wsrbk2/Z79Y+Ea0gicL79OUo3oq/bBkKUafePiBbueC+4silgrHG6GoR4TNwWVfx+sKz8NeIgpw530nis0hye7DGLbGRHFgdWLu4lmnDWi1QQjV7ON6DNfXANkY9p3ljuy82jAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPfxPGJMSuqB1p/ibI0VzgQtxqGASe8UK3HKqR2mJMY=;
 b=1k+UzCKz8MOcWrUZv3061Aon2EjnLBcI1xtn2gdYzeAQPfVse2NGMOmrdG/hFR5ChrQAogMDa990m4ghh70iAWCJJ7ONj0Bl+Uuy5ZOR+9kXVGB/s87y+S73lQ0MF1PcS84e1Di3OYLZQPjQPv/X9ITkPvGGs25KX2FzmDGTDKQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:21:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 08:21:42 +0000
Message-ID: <fe180238-38b0-404f-8bcd-58a0e206e5dd@amd.com>
Date: Thu, 15 Oct 2026 10:21:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: reject ANONONLY userptrs that span
 multiple VMAs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20261015021859.3229267-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261015021859.3229267-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7d85c5-7c5a-4dd1-48ba-08df2a95577b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261009223027099003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: +DDyT1X1OtaUHuFRFsABroseeeGEcfxDlYTatCoG1suhY4kurI/63IVoFA1FGPjgWUbF3DyKcH97ijNiXKFPSh7qHpi0/yR/2IquTM5xALMqVVVdUptRgwZ8AY67dCzdC5kowUgeGX/RKSdEN3z67GMA3HrH3HPdXebIYKsK6rtXpgVxaq3TF4wlN21nS6m44Vleuxkiq+2Q3CraRYafFBUoDurFloMTZXSC2KrMi7hMXUJ2oROrPPLaaUKVDw9IMLUIXKOhehgdXt3MeX1rou1MIARZOpPiWKLKmMqJuon/cK0ETlLamL1zMzD2Ev6dPAOU9XgiPUY9g+Cws/IJmVcNY8Wc8hMkl7lXGKyfWsS5eET/8H2VNlUzf+aUU2FXL4/VCzPKeyNkAZnqZPoNJsTyEiyCidM4Y/prCoVh2/3pAaEHxacjwM9b6AhXnQyuUz/jw9KnGsHIV7MOIrCnH6q3nuhRw2uTluYQfe0oCVIITAxMXNXBY1/Xy2TeHa1Ai8+wL3NXJLFpzgOwrQf/P5dVbzkufJLbC1ZF3mf6zNJcN3hGZ5pSh7SzGVY8CwWHHyZiL5GaDnvH8VBCBSX+ccmFyJ6/COKx1O6Y3bXH49pRH60uE2CBKDXtJsLIdVV1q7jMDLPOm8xEW1qM+BO1GOS5sP0fDyI5cf5tWYHz8f0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261009223027099003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3ZhRjVwVC9EbmVrR204QU1Ec1JPeitBendsbEthQ2hxbTF4STd4VktxaTQr?=
 =?utf-8?B?RHBwaUZyTnVvdEUwUnBCakN1cmtuOFRHdWpVcWlaazRKUWRYbVFOZWUvVmRy?=
 =?utf-8?B?b3d4WmYvQUVSczA4WXp4UVh1TUVRVUhaa29XRnNDL2J6TEtGZXE4UFcrSVg0?=
 =?utf-8?B?NGw1cTJYa3RHYmpLMzZKM09oMlRaOEk1VDlEa1laczQ1cjlXSEg1SzQ2RGlJ?=
 =?utf-8?B?RnpZaEJZeVFySTJqMm9DbWlBM04ramZrQzcwUDhaSE5USnViUTVPS3pqaGVG?=
 =?utf-8?B?NGp1K3RTbkZTMzhvZzlNcjhRQ1g3RkNuNVFtdU1sZ1Q3WHl6c3VtL2VoNFFH?=
 =?utf-8?B?S2dZakNkeFY3K01wRllXNDRqczBBdUxQd2V1RmdhRTZnRVhwRjhTL09LTnQv?=
 =?utf-8?B?ZWQ3YWJiUXFzZnJkSU9ObStlazB1dkt0V1NVaENjTk5Bcm1vVGdlSzNldUVH?=
 =?utf-8?B?cXFtdXBsUlhOWWppT1c0ZW9LMUUxYzdiekM1MktZMEpwTjcxUlBRS0RpeEZw?=
 =?utf-8?B?RU9uR1ZiejlLM1JTY3ZuRlBxalpXNFpQZ0YyNTdvbmtzL3FvQ3JJT28xNStP?=
 =?utf-8?B?RUlWZ3VlcjQ3eEllTDNiNTJFcCtodWVhMXIyZUV2YUd3cU5xTHVPRStoRmFk?=
 =?utf-8?B?VzI3SFRSeUMrclc2WE90dGlzMzJ5Unc3QXlBNm9TbXZESElmREh5NjlMSmJ6?=
 =?utf-8?B?SG42MXNPRWEyN3JXcEoyUHhpeUJmZlVjM09FV2FSWmowMkxFRTBtNS96OG83?=
 =?utf-8?B?Z3Zaa2pHRmZ1U3V4SHB3VnNoVVFqN2hwTU1FN3Q4MWtpZkxrUWJSc2ZoQlNp?=
 =?utf-8?B?eHIxZjMrMzl2T2N2TkpSNTFHaU43cDRMaFlhMUV2cExCNzE5bndTT2J2K01K?=
 =?utf-8?B?MkZPQ0FGdGFpcnZUWVFhWkdjamgydVZyczlSZXF0UWs5Ry9QallrOXlUcmZk?=
 =?utf-8?B?ei9WTDNxZWttWjFRWC9GU0pWQ2VaR2xaSkxZcEtPRXlSVjQ0b3BEMURGRDFq?=
 =?utf-8?B?d0VWZURvRzk3K2JYcXgzK2hjMHZuQ1pLTmd1M1UzU20vOWNUMnZTQUdUNE9t?=
 =?utf-8?B?dkZSNkxQYzNhN3RoOVdQUU5XWUUyMHpzWHlvYjNXQUdhK1hpMUdDeUpsZlFj?=
 =?utf-8?B?bm1uUUlLRmRlZm5sRk51SjgrYmZETWplaEdRYmYwNVVTMG5QOG4xRlZWNWhq?=
 =?utf-8?B?dlc1b2NtV2svL0MzQWpWMS9LUlZ6MWJnbTlTWXd5MzZIUzNUaHhOb01OU1BJ?=
 =?utf-8?B?TzJPcitFYmp5ZHhPaWhOekQ0ZnBaTnZPbUI0TllFWjVSZjFoRm9lYmR1Sjlh?=
 =?utf-8?B?SFp2dHJoS3hrQzMvK0FTUTBmNHRyTDExbXlIdE1wRER5SFpPSDN6WDJ2QW5U?=
 =?utf-8?B?ZnJ1ZFhFaERMczh3cnFxQ2FhNW5FbFlyUkt3L3QyeDBsWjcvN25FYWVzdG81?=
 =?utf-8?B?Q0R0VHNvejZOSjdmQUdWVU5JUVdtYSt2WXRQV3RZTzk1N3hKZFd1NFZ5Q2lo?=
 =?utf-8?B?OGc2WVRRV2Nxbk5DQm03QzFUYWVMTGNJWHFTbWRQSWZjV2VLVzJlcVZxZ2tB?=
 =?utf-8?B?OEpNZk0veGxSNmtYZmhGaWxPck5mcFR4ajFzQVRmTVBzOUI2NE94R2RFaS8v?=
 =?utf-8?B?RTNZMkc5TThGU0dubVhudFpMbWxnTWY0bFRjZnFYVWZsT3FKVG5xSE5acGc0?=
 =?utf-8?B?bFBOSVhtdzQzVzFsSmNOTk4yUHNpUndlYld4T28vQnlYZU81eDVWS0FNcGNL?=
 =?utf-8?B?YkZJM3RqVFZkcitGSE1XREY3aUxPQzdvNFhqRW5lS0pvaHhsQURTUVpnYU5q?=
 =?utf-8?B?dXRmMFdrM0RudXowUWJKRDR4T1hkTTNsWVFycmZXMTlpZC91RlVRNHJEZjlj?=
 =?utf-8?B?bXFESlRUcG5hRjhjRXVDdHdLTjlmWGhnNHJmOU9va2x5T0dhbkJxdThvZHY3?=
 =?utf-8?B?d2hDcElLelI0V05mK1dZY0p3RnNSd2w0TzFaR1RSMHAzeWpuemt5QXpCSWRV?=
 =?utf-8?B?VStGZCtldHdOU3dQMUZLbWk1MkczdjhZQTVvdzNvZ0J5c1BHcjJrbmtvQUlj?=
 =?utf-8?B?aThFZDEwK1Q3d2dCNGRTcGUxSnFrQmF5OS9aQkh3SmZKb1JkVnAzci9MdVpJ?=
 =?utf-8?B?a2Rtam9LWkR1TFZvUW1SZHd2dFZWaVBUNHdJU20wOUwxSEh2L3ZLaS9xeVk1?=
 =?utf-8?B?Zmlwd25GdTI5ZUY2Y09TOUJ3TW5FR1NLYUNzOXNNdDZqYXl1T3ZvT2hORGN2?=
 =?utf-8?B?cnM3TXdpMkFOT3oyQ0xjM1JkMC9pTWF6QitkejB1d0pHY1c2cE1acEJ6c3l2?=
 =?utf-8?Q?uDvT20VIsNz+CCBJfN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7d85c5-7c5a-4dd1-48ba-08df2a95577b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:21:41.9564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfLbNIjMUTZGhthz42LcPn1Nd58yWcDdQUEE9QqlIQiSz6wItnQqmo/ylNjZkHvx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
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



On 10/15/26 04:18, Jesse Zhang wrote:
> For AMDGPU_GEM_USERPTR_ANONONLY, amdgpu_ttm_tt_get_user_pages() only
> checks the VMA at the start of the range for a backing file, and
> amdgpu_hmm_range_get_pages() then faults in the whole range, across any
> other VMAs. The check used to reject ranges ending beyond the first VMA
> (vma->vm_end < end), which got lost when the code moved to HMM.
> 
> An ANONONLY userptr over one page of file-backed memory is rejected
> with -EPERM, but one over an anonymous page followed by the same
> file-backed page is accepted.
> 
> Restore the check and reject ANONONLY userptrs that cross more than one
> VMA. The second userptr is now rejected too.
> 
> v2: reject ranges spanning multiple VMAs instead of walking every VMA
>     (Christian)
> 
> Fixes: 6826cb3b92a3 ("drm/amdgpu: support userptr cross VMAs case with HMM")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2103f8d6165d..9b2d3ab9010e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -784,7 +784,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  		goto out_unlock;
>  	}
>  	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
> -		vma->vm_file)) {
> +		     (vma->vm_file ||
> +		      vma->vm_end < start + ttm->num_pages * PAGE_SIZE))) {

num_pages needs an u64 cast or otherwise that can overflow.

Apart from that looks good to me,
Christian.

>  		r = -EPERM;
>  		goto out_unlock;
>  	}

