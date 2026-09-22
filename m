Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09572C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 14:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E6310E703;
	Tue, 22 Sep 2026 14:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6rwyHWa";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450C210E703
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 14:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0kV02KU69A6sxWAEW+D7prBcbgZPr1H/ATbrbmn8X4koPQNqSMOm1doULwBt17F4LpuUo9YaKiNSSzoCtV3yfIiFmeJmkcHychzFhTFngpinCPBXuddVYsS3LPZGDU2LHwVRJkoUEGq2QPaPQ63YnX90eUsN9mSNHXAzWMz86gjE+jIdn04boO4lxNR1alCXsEKujOO4SPYTPnLF2JsfytJ5+3KlVnwk6rOqQed25shjv2lvjDVW8S9tn5e2xu7WlzkLhnPTkDFNG9D/wgB66eKsFMgiwMA/hdyE9OAq6FZmB+8KCc+6j8i+PGC5e7QrWVyiP4SZjsXN773p/i0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLgq7p7cSB8IgjC4L0O6nLc/T+GM8e9wCcxHPE6KNOg=;
 b=zOXvykhIiK49buJC4H7bqSUVEIj+/9ExbPphoMU7OaaSnrP5uUkplW6lIjppiUkdXzsqF/E5zqvbwf/W73Di42oXJ03Wr70dLMvlHUcrrQqspEatgyb8v96WWl/KdbzXMN0Jg1CWJzeIkm16zxIymIm+pKnxEBD33WYLuqkkWAzIFUKDbW4rIo519KQBfZvEgid05FDdV5ppjdloLgr4WxwbqOHjj0XTvTVBvvcX3HeJEHr1CJy+bGDO0KT/wvem83cPhrjfJJyM5jhE1GsnJVkr9OfZkavU/VOSiZXTmBlVVaZ5SLcxCy1JnEzoUiViXKw1n1JgcfI3PhV1sUphOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLgq7p7cSB8IgjC4L0O6nLc/T+GM8e9wCcxHPE6KNOg=;
 b=x6rwyHWaPbYNjZk+habeRKgNZUvup2/HPfw9K0EuLgBKNleJGJFIk2swEJ6DMOob+tFL0HGweHkW45CxJbJJUWhG5xG7Cjcl6yQHtY/hY59NEB4sCaz75f5REDIYgI/TO/aU9sf+g32lGimNgXW+d0ek1Jebmxpx6zn/f+Zv93k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM4PR12MB6398.namprd12.prod.outlook.com
 (2603:10b6:8:b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:15:45 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 14:15:45 +0000
Message-ID: <3484d79c-8ad4-44a9-bd3f-f35f0db108ef@amd.com>
Date: Tue, 22 Sep 2026 10:15:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Flush the pasid on all XCCs in parallel
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20260922131246.2886098-1-David.YatSin@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260922131246.2886098-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0195.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::17) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d10279f-6515-413b-616a-08df18b3fe0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dwqNe0sm+Hek0yJBQDP0EfAdIZmbXhVJbj4J35Y8+G1eFR8KqyIIor29cU6Fy06QmhYI9DF9h0+gGzHBMASP8e5pvX7jedpQJrf54cqVp0XQQHD/L0kcg8UYLtS7AS91MWutHO5IuHRiA3CX7G8QK82XULB3JiaBbF3/VCbnn7M21bwa1yKduytfL48Q/jxQ5R5R5DutWI0pbPr/sYdmNE9zTuxGf+ZpSEZD2OOO5jWYQBxvVbyM4M3pQZpI4XMb4gm1hYWStDoIONQGhsPCXJ5IUvKlHFaD1FYp/o5g7rVqYY8YMNBo1M14/Tylaqgm1s/Swx/ZdYct65nnumXbU2PM9XMCv9a+CbnDL8hkDi6ZpznR5tv2C47fXyhDhKnB1afmldWf04gSdrFthUXrjQR0bBDNlhW4EHUzDnUGKwpumfptNn9z94o3b2BhQ516Xbd6EOAPbGik8R+tKSnLylUXizxomZdwGKNkNsHdYXztAOuxF6T+SMjdqiZ+divfLd+VKNz+uTxGIEMqExchV40W92GZjd9zv+mtan2MPfKPBUMIdz30XGDbkN6oaGJWk6vGI1E7s1QtUQgREC7dkY3eKiFZbG69bAitidAsSpS8KwbXHfeW7bZN8mjoW9XPEIiC8NGrATfo9gZZ39Vk10lwTzWarrhS24SaZaqbk8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzBZem0vc0YrN0JhVlpjTHMzc1hFeVZpY3g5cnh5OGw2QWMxNkZMNzJKQjM3?=
 =?utf-8?B?b3Eyb0FDVVg5YjRVcC81aWprUFk5NmRKY3kwb1dUck1HQ1VhcGtOTWladmZ2?=
 =?utf-8?B?SkpnbFU3QmRrYmdZKzhPem5mcU5LMGdvVGpmMS9Ed3grUkpyVkxWNjd5cVBk?=
 =?utf-8?B?UmpaTGE1cTlMeHVOUkJCcUkwQjJpWUFRTXBHSWtBKzJ4WWhuRGFsTVp4dXB5?=
 =?utf-8?B?YUFFeGM0c0RWaHQ5R2xJRFVnclJyeCtzV2xzVjF3WHlEcVdxU0Y3clFSK3Vq?=
 =?utf-8?B?enFTMjM2V2tzWkprWU83NFNSMW5HVFdlYUozcGZ2em1oeUNVMTdkRG9JQVFq?=
 =?utf-8?B?SVFOREVoY0p6WG1xakdNd0FqMWk5RzhzNlZkMnlIVWxoZWt3ZHlCMWs2SzRy?=
 =?utf-8?B?WVVXdDNtMnZKSUErTTJGYmdmY21JOVgxRXlQKys0WlE1NW9wUThJZlhmNVdH?=
 =?utf-8?B?QWlhUkoxckc5cENLZHVIcENyVFBWdXBTeENBYmUwMThDRXRwY2FGdDVibU9T?=
 =?utf-8?B?L0QrWmsvNGpENWlPQk1qUGQ0N3RCS2txQVRndXMwTjcyMkVQL1ZHaS9zRk1M?=
 =?utf-8?B?K3JSYTRZaXhqeFE5S2thMFFSUVdSQTlGU3Jwam9vdEtQNTRhUkFaZ2puSnFT?=
 =?utf-8?B?cTQyVFhwSXpGUTNiQWt3RWplc3RZVUpKUE9JUkxmNFlvRGc4d0xOczhFbWE0?=
 =?utf-8?B?UHQ5cEhjZSt2VEVOQWdWOXJPdTYxMzR6Y29RdldteGJTbzk1U2lLc25NV3Qr?=
 =?utf-8?B?WE94elNsdWVSL1ZOU2wwRXd2bWtweitMUG4wWFhubVM3eDl4YTZLbWE3cy90?=
 =?utf-8?B?NnBzaEVMZ1hiNHROSDA4d2gwOUpZUS9xczNXSlJyV2NEVjdVVzRXTVNGT2ti?=
 =?utf-8?B?MEd3cW1OM2dQalhaTnlmMnZwWDM0TjdTd2ZmQ2xhbkEzY0NoVXdaR1Vrc1pp?=
 =?utf-8?B?WWJxczVyUEdqSzJBcGY2NW5ldFpSUTJQODMrRHFMUkNmSllPeGhGWWxDZVcz?=
 =?utf-8?B?WEVTNGwwSEFOYjlwZEpoRkhUQ083aENiWGZjdm9FUWtYbFVxZnlCRm50cFYz?=
 =?utf-8?B?NFJYeWovV2t2ZWRsQVhTOWUyRVdCdS9HUTVWN2VtZHpKakNYdUtBMkxXamlG?=
 =?utf-8?B?aW1Ka2Q2Y2xUVk5xWWpBOUUzQjdvcWV0aFRNUVFpMUJVMkx4SUk2M3RuM3ZV?=
 =?utf-8?B?dXZ6RlVtQm81aDdhWHVHSTJpUG9oSElQbUhMVCtBV3NHWmdSWDMveGtKYktR?=
 =?utf-8?B?N0p3UE5od2hzeGZ4cDhXNkZXQWZkbDdvVnhzMnJuV2JSQWM2cEFlNHNOMThE?=
 =?utf-8?B?RzV3WDd0VFAvUzlkcnhvd3ZwdkE1VlRhWnFCLzdqS2FBQkwrTFJjN2dzdmRo?=
 =?utf-8?B?bDBtNnFlY3RYaisxWS9yVEFYd3hhUkpGenZKWmszS2sxbjhnQWJtY0x1Yk1N?=
 =?utf-8?B?Mmd6OUlvNGhlVDUwV1k5cFBseEQrUTZTRUlZSjhBUU9mWUJEZ1NKOThDNTJF?=
 =?utf-8?B?dnJVOVgzYnRXbDN4RW5WQTlDZ0ROQ3hlWUZHUGpsZWh2NU1RQU1PeEpsdWo5?=
 =?utf-8?B?dk9aS21PcElEOURBdzhvWG5GajFBOE1xYjN2NS8wTUQ0TnRqdE9wVnlZd0t4?=
 =?utf-8?B?WERhSGdZbElmcW91cDhaUFpRaXNaWVBzUlV4V3pRRDdJOW9mZ2ozTjFqQkZm?=
 =?utf-8?B?emNNYnFnTXNXYmwydGQ2UFpQQ0owVloxb0w1Mk9ITVArNDFvSGdsTytseW9B?=
 =?utf-8?B?RlU1a0RyMlh1RU0ybFB6ck1pVnRHSnMrZHZ3cEJRUVEzc3hEREJvRHhJb2dM?=
 =?utf-8?B?amIwRElmYnVjWi9BdU1pam5sYXFacHROWk1sZHRnRG9nY2d1d0lvYURDcS9O?=
 =?utf-8?B?U1RoWXF3eFJ0V0FTVEhWMUtIMmNqdGJNZ1Z3UFloZWJrSmhyakZOWTRGcFVl?=
 =?utf-8?B?ZnNSZHpvdnFaaEFZWWRIaDMrTHhLUlRlSmR1VW1neUlzcXJaSFRCL1k1VlBP?=
 =?utf-8?B?Y1lab2hZVjhRdDFnUVh6RWdFSXNCdjNDcUtJdXZtZjFscnZpdVpjNlpXTnhL?=
 =?utf-8?B?RXVPY01SVnkzcDlyNkN3OU1NaGhIbjhpSkloNENBWENhUmplV2ZteFNPaG0y?=
 =?utf-8?B?SnZsWDJUWFVybVpsVXZvaG40QzRRNHB0ci9lQW9aOXc3Vmg1dURYWm1nc2hu?=
 =?utf-8?B?Q0NFY1BiOURpcFJpV1FhVmJQMWIwNUF4L0hFSVRIbTBPMWw1SEljMzd5Nmsv?=
 =?utf-8?B?M3J0UnRBc294eWZXMFpTL0l3VUUxdmxPVFNXUkUrN3JNa3Jjem5xbHpEQmc3?=
 =?utf-8?Q?0HDJ1RWcmYxrjwcA+c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d10279f-6515-413b-616a-08df18b3fe0d
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:15:45.2269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqRuNdhJqxplIwSPai8DLN2wgXC4tgWj2/rSARpxkszlPcG0k8KSu8o1HSVRXhqlM0Pvq8EZ32dkSJfUR3Z7FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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

On 2026-09-22 09:12, David Yat Sin wrote:
> amdgpu_vm_flush_compute_tlb() walks the XCCs of the compute partition one
> at a time, and amdgpu_gmc_flush_gpu_tlb_pasid() submits the invalidation
> to one XCC's KIQ and then busy-waits for its fence before the caller can
> move on to the next. On a partition that owns every XCC of the device
> that is num_xcc round trips back to back.
>
> The XCCs do not depend on each other here. Each has its own KIQ ring,
> ring lock and fence sequence, the page tables are already updated before
> any invalidation is issued, and no invalidation needs another XCC to have
> finished first.
>
> Split the submit out of amdgpu_gmc_flush_gpu_tlb_pasid() and add
> amdgpu_gmc_flush_gpu_tlb_pasid_xccs(), which queues the invalidation on
> every XCC in the mask before collecting any of the fences, so the round
> trips overlap. Every XCC is flushed even when one of them fails, and the
> first error is what gets returned. The single XCC entry point keeps its
> behaviour, so only the compute TLB flush path changes.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 226 +++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  10 +-
>   3 files changed, 172 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 7c0554506334..6a9bcd28b43c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -780,15 +780,108 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
>   }
>   
> +static void amdgpu_gmc_flush_pasid_regs(struct amdgpu_device *adev, uint16_t pasid,
> +					uint32_t flush_type, bool all_hub,
> +					uint32_t inst)
> +{
> +	if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
> +		return;
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_2)
> +		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, 2, all_hub,
> +							 inst);
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
> +		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, 0, all_hub,
> +							 inst);
> +
> +	adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub,
> +						 inst);
> +}
> +
> +/*
> + * Queue the invalidation on one XCC and return its fence without waiting, so
> + * that a caller flushing several XCCs can have them in flight together.  The
> + * KIQ ring, its lock and its fence sequence are per XCC, so the submissions do
> + * not interfere with each other.
> + */
> +static int amdgpu_gmc_flush_pasid_kiq_submit(struct amdgpu_device *adev,
> +					     uint16_t pasid, uint32_t flush_type,
> +					     bool all_hub, uint32_t inst,
> +					     uint32_t *seq)
> +{
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
> +	struct amdgpu_ring *ring = &kiq->ring;
> +	unsigned int ndw;
> +	int r;
> +
> +	/* 2 dwords flush + 8 dwords fence */
> +	ndw = kiq->pmf->invalidate_tlbs_size + 8;
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_2)
> +		ndw += kiq->pmf->invalidate_tlbs_size;
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_0)
> +		ndw += kiq->pmf->invalidate_tlbs_size;
> +
> +	spin_lock(&kiq->ring_lock);
> +	r = amdgpu_ring_alloc(ring, ndw);
> +	if (r) {
> +		spin_unlock(&kiq->ring_lock);
> +		return r;
> +	}
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_2)
> +		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
> +
> +	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> +		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
> +
> +	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> +	r = amdgpu_fence_emit_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	if (r) {
> +		amdgpu_ring_undo(ring);
> +		spin_unlock(&kiq->ring_lock);
> +		return r;
> +	}
> +
> +	amdgpu_ring_commit(ring);
> +	spin_unlock(&kiq->ring_lock);
> +
> +	return 0;
> +}
> +
> +static int amdgpu_gmc_flush_pasid_kiq_wait(struct amdgpu_device *adev,
> +					   uint32_t inst, uint32_t seq)
> +{
> +	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
> +	int cnt = 0;
> +	signed long r;
> +
> +	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +	might_sleep();
> +	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> +	       !amdgpu_reset_pending(adev->reset_domain)) {
> +		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	}
> +
> +	if (cnt > MAX_KIQ_REG_TRY) {
> +		dev_err(adev->dev, "timeout waiting for kiq fence\n");
> +		return -ETIME;
> +	}
> +
> +	return 0;
> +}
> +
>   int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   				   uint32_t flush_type, bool all_hub,
>   				   uint32_t inst)
>   {
>   	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
> -	unsigned int ndw;
> -	int r, cnt = 0;
>   	uint32_t seq;
> +	int r;
>   
>   	/*
>   	 * A GPU reset should flush all TLBs anyway, so no need to do
> @@ -798,76 +891,91 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   		return 0;
>   
>   	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +		amdgpu_gmc_flush_pasid_regs(adev, pasid, flush_type, all_hub, inst);
> +		r = 0;
> +		goto error_unlock_reset;
> +	}
>   
> -		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid) {
> -			r = 0;
> -			goto error_unlock_reset;
> -		}
> -
> -		if (adev->gmc.flush_tlb_needs_extra_type_2)
> -			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> -								 2, all_hub,
> -								 inst);
> +	r = amdgpu_gmc_flush_pasid_kiq_submit(adev, pasid, flush_type, all_hub,
> +					      inst, &seq);
> +	if (r)
> +		goto error_unlock_reset;
>   
> -		if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
> -			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> -								 0, all_hub,
> -								 inst);
> +	r = amdgpu_gmc_flush_pasid_kiq_wait(adev, inst, seq);
>   
> -		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> -							 flush_type, all_hub,
> -							 inst);
> -		r = 0;
> -	} else {
> -		/* 2 dwords flush + 8 dwords fence */
> -		ndw = kiq->pmf->invalidate_tlbs_size + 8;
> +error_unlock_reset:
> +	up_read(&adev->reset_domain->sem);
> +	return r;
> +}
>   
> -		if (adev->gmc.flush_tlb_needs_extra_type_2)
> -			ndw += kiq->pmf->invalidate_tlbs_size;
> +/**
> + * amdgpu_gmc_flush_gpu_tlb_pasid_xccs - flush a pasid on several XCCs at once
> + *
> + * @adev: amdgpu_device pointer
> + * @pasid: pasid to be flushed
> + * @flush_type: the flush type
> + * @all_hub: flush all hubs
> + * @xcc_mask: mask of the XCCs to flush
> + *
> + * Submits the invalidation to every XCC in @xcc_mask before waiting for any of
> + * them, so the round trips overlap instead of running back to back.  Flushing
> + * one XCC at a time costs num_xcc times the latency of a single one, which on
> + * a partition holding every XCC of the device is most of the cost of a compute
> + * TLB flush.
> + *
> + * The XCCs are independent of each other here: the page tables are already
> + * updated before any invalidation is issued, and nothing in an invalidation
> + * depends on another XCC having completed its own.
> + *
> + * Returns:
> + * 0 for success, the first error otherwise.  Every XCC is flushed even if one
> + * of them fails.
> + */
> +int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, uint16_t pasid,
> +					uint32_t flush_type, bool all_hub,
> +					uint32_t xcc_mask)
> +{
> +	uint32_t seq[AMDGPU_MAX_GC_INSTANCES];
> +	unsigned long pending = 0;
> +	int xcc, r = 0, tmp;
>   
> -		if (adev->gmc.flush_tlb_needs_extra_type_0)
> -			ndw += kiq->pmf->invalidate_tlbs_size;
> +	/*
> +	 * A GPU reset should flush all TLBs anyway, so no need to do
> +	 * this while one is ongoing.
> +	 */
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
>   
> -		spin_lock(&adev->gfx.kiq[inst].ring_lock);
> -		r = amdgpu_ring_alloc(ring, ndw);
> -		if (r) {
> -			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -			goto error_unlock_reset;
> -		}
> -		if (adev->gmc.flush_tlb_needs_extra_type_2)
> -			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
> +	for_each_inst(xcc, xcc_mask) {
> +		struct amdgpu_ring *ring;
>   
> -		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> -			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
> +		if (xcc >= AMDGPU_MAX_GC_INSTANCES)
> +			break;
>   
> -		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> -		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> -		if (r) {
> -			amdgpu_ring_undo(ring);
> -			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -			goto error_unlock_reset;
> +		ring = &adev->gfx.kiq[xcc].ring;
> +		if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +			amdgpu_gmc_flush_pasid_regs(adev, pasid, flush_type,
> +						    all_hub, xcc);
> +			continue;
>   		}
>   
> -		amdgpu_ring_commit(ring);
> -		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -
> -		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> -
> -		might_sleep();
> -		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> -		       !amdgpu_reset_pending(adev->reset_domain)) {
> -			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> -			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +		tmp = amdgpu_gmc_flush_pasid_kiq_submit(adev, pasid, flush_type,
> +							all_hub, xcc, &seq[xcc]);
> +		if (tmp) {
> +			if (!r)
> +				r = tmp;
> +			continue;
>   		}
>   
> -		if (cnt > MAX_KIQ_REG_TRY) {
> -			dev_err(adev->dev, "timeout waiting for kiq fence\n");
> -			r = -ETIME;
> -		} else
> -			r = 0;
> +		__set_bit(xcc, &pending);
> +	}
> +
> +	for_each_set_bit(xcc, &pending, AMDGPU_MAX_GC_INSTANCES) {
> +		tmp = amdgpu_gmc_flush_pasid_kiq_wait(adev, xcc, seq[xcc]);
> +		if (tmp && !r)
> +			r = tmp;
>   	}
>   
> -error_unlock_reset:
>   	up_read(&adev->reset_domain->sem);
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index cffd5ca3fc66..5ea237ce133b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -447,6 +447,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   				   uint32_t flush_type, bool all_hub,
>   				   uint32_t inst);
> +int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, uint16_t pasid,
> +					uint32_t flush_type, bool all_hub,
> +					uint32_t xcc_mask);
>   void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>   				      uint32_t reg0, uint32_t reg1,
>   				      uint32_t ref, uint32_t mask,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 47cde5459469..aae92ca87914 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1724,7 +1724,6 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   {
>   	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>   	bool all_hub = false;
> -	int xcc = 0, r = 0;
>   
>   	WARN_ON_ONCE(!vm->is_compute_context);
>   
> @@ -1740,13 +1739,8 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   	    adev->family == AMDGPU_FAMILY_RV)
>   		all_hub = true;
>   
> -	for_each_inst(xcc, xcc_mask) {
> -		r = amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, flush_type,
> -						   all_hub, xcc);
> -		if (r)
> -			break;
> -	}
> -	return r;
> +	return amdgpu_gmc_flush_gpu_tlb_pasid_xccs(adev, vm->pasid, flush_type,
> +						   all_hub, xcc_mask);
>   }
>   
>   /**
