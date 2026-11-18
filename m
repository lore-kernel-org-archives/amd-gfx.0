Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE2606A33D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cjum/ZkR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2169910FBC0;
	Wed, 18 Nov 2026 12:40:22 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23AA10FBC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 12:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRGAqkz0fVWq58ZSR4algAUejcmxyRAWUl7xYFOmHz9dbn9GtDzElXa0gNFq/2KigdZo/k6k7B5P/ncvDMMsMAFYe5lTQNaj2UpEnSNo5zoTfQvofqIN02CEKNoqjPQHTo00cqqZaaK7M69p+wlldHAiHAFbbzgifqG7TgeRt+PmFLNvDqKgg0TubaTOGPfVbPjFRYQJOPeQQSB1DX7IJnkLeHjDb/h0WFWjlBmZJikFaWHebirHeOBVPkGYNb3+zpYdSlKrt6Kq48aVH7TTjtwJZX+KhBQ4cre5ss9vsv8uaoCDxlKT/IoRS/B9GaffIw+TzeK5IuPkvf4OwthgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dmtCYJrORF6r5hnwk7iozVcaBn9ziqgZmQcMlb+Vxk=;
 b=GvUmmYf3o8AhQgVMnGnJIsW0xyRjdTzwG0ur1IJr5WxNh+cWihbkqRJpmy9M44DGG7cjFJfkprQiMg8edIh6bGIqSOlOe25kvT/AkeKiC7CdDujguTqZQYrKBJLHHnuMRv3PRM5Qn2bb6B5/yRoAMXzWxVSf/lBFJtKkCsmIl9tz9aqLRy9PQFFyV98gZaj79ztUTDNUCJm+YM4jQfTHbpsQen3pANCjIJLMB7dltNx6td5O5Pc38LSzqow3S3NQ0uawCEnPWRm0rhyrkV7ajy3u7VS/P4MKTd+ZETZ+nqa1zfwHG+GfrzPySRqqDQ2kGdSVisvbbAre1UOlgNSp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dmtCYJrORF6r5hnwk7iozVcaBn9ziqgZmQcMlb+Vxk=;
 b=cjum/ZkRFw/sVbXoEve7rQacArtAfd9yN+lmwcPMyDmVjKTlcuxdzHoYPuqoB++0JEvItFyKCixwFUPJRZUyUbH2dRjWuhX6R0O+b3sR8XLoHPRozrV6SO/FoLg13SuT36BTaJngiaC63obKoZGPHxajkFL7BO6rKDUraPr+n6Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:40:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:40:09 +0000
Message-ID: <401f0027-0b3c-46b4-9325-e7fbcf8b7241@amd.com>
Date: Wed, 18 Nov 2026 13:40:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/5] drm/amdgpu: wait uninterruptibly for
 page-table moves in CPU prepare
To: "Mu, Zihao" <Zihao.Mu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
 <MW3PR12MB45722BB121F9BEF7DA3203F39E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW3PR12MB45722BB121F9BEF7DA3203F39E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b1a1c6-4cc3-48c0-2395-08df457114a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|4143699003|11063799006|10067099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261021123027099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: mYQxDQe20VheTunqWgjk1U0NZlRYGHaU3joABoO0wHgQl97SFBWIOB4oalG58oT19f/IutHXG7Kc0Sde/RWhc6vxqFeXQWxO6/ISzcgDizJVvxKlVZ9dGCyaJ6pB4wDjQArZ2O1r7oYcvykXo8DA4WuxjYv3tncC3lo9uXbhilSS1/Ji/55jJq2dyhfhGeBmbt9d5LAta81OtfapktQZ3hbn5G06VEPE1a8TQzfl301Jscd5LrKUIjPxRGgkbEBkaV3TmLSPeud9ku0lGP/9m+eEhsjbMAIW8FRVWJ2+yeERm8RuFnZyXR3pE7p8LW1BiLprI2XeU2sFJXUg+CshEegNvQXQ9Mn2n11ihgebmBj35S7AAY683/D/iHSDBlVKMy31Sz4pA8lsWB5Y2GD1mQENUmsTKHkUkL0v67By+xfdhZMbMAIRiL16m+4zxwCrFUFh5oi9AneVVquv44PmF3QfE3fEMFz6xBA4EqJsyYLSu9MKf6sGnmJvT4V/3gpDHv4XUF/Jl1ilRYY4t/ToSPZdBWknfwban7xpC6uMf9SKfKxsEod1puV0Tdijzm0PCYojVGmucxHf3SYCYVxPGH0zBO2OGj3n1Q5DP+DK/PAlgNw0ht+gDfg5oorzpzKl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGx6K0FiWDVUcGlzSWpzVXpSMlAvZVJHQjJNQVlRaHJudkVYQktsMjJoUUdv?=
 =?utf-8?B?WUZDaWwxSms3NWpvMTRVZC94eDlkUGN5RlhUMnRlSU1KSzlHTVVzazc0bG5u?=
 =?utf-8?B?bEowcU9uNkJiRml6ODN1eFB2VFRjVU5nRGsyVHYxdWFsTmdCZ2NyT2tnUHE4?=
 =?utf-8?B?eUYvUmEzbDNFRlBoZmZLN0RPc3V1Y0lMZVZmSUNZZnh4V1lWV28yTjQ1cC9P?=
 =?utf-8?B?UzQ1Q1lVdms2dVN4R0RJNldzZWFOV2gxbWdpc2VnU0Y4SjhsamcvL2lqMm5S?=
 =?utf-8?B?ZVdQY1pYNitBRHZPdTJVWXRxd0N1TGluRk1IWlN0UnFKN0dVVStqQ0ZQYWxV?=
 =?utf-8?B?QmFVQkwvMGNhT08vWXNBTVRSaDRJM3lCanJsNjhIMnozOTlZVmliR09BRE1p?=
 =?utf-8?B?TVNoT2oyWGFjRG42QXVXMjcxMXgyZGdhOHlab24vbWFUbnFTQmJaanFoblRp?=
 =?utf-8?B?YlZ1emdFOG40OWtONVVuLzdxUVRSN05IVVM5aFo5NlhZSFlYdTlwQUorTUFW?=
 =?utf-8?B?cFJEbFRiTTdMRnJNUlZUNGxIWjlTRGFtbU55YXhveUV6QUFTZHhUUWs5dEsw?=
 =?utf-8?B?TWFSTVRDVk1yZkRISlpKRlNCVE5xVjlRYXhRWDRoOURHWjJHRzN0NWV3dmY0?=
 =?utf-8?B?WWw5NHUrUG8wWTh6dDg5YUEwdlh0cC92ckpKRWh2Qy9KNkZzMjZKNlNqMklF?=
 =?utf-8?B?QTFYdEZ0UmhlbWVkcmNjZlZ2Y2oxQkNrWTk0aGgyWklvWHVDeHByQVZmUTBB?=
 =?utf-8?B?VXdkUW1pSjByUFoxM0lEY2E5ai9wd2NiN1pUMko5ZThwTWgwaGpKV1NLWnA3?=
 =?utf-8?B?Q0ZUNmZ5SW45Y3dDQU5ZcndLUGt0RVZwRjExekZZbkRMTHJBY1FTVTRmenRQ?=
 =?utf-8?B?ZVdmOER2TngwVDFjOUhsRVpvVHh6RGNUR0h3WXlkQjUrZjJ0M3VRVnRCTDZ3?=
 =?utf-8?B?ZWVlNUNxLzliTzZqNmt1NFV4ZWNZcEJmc2J4OUFXZHlYYTNaVUNrVVIveUVs?=
 =?utf-8?B?WkhQZEt4cDNkRDdQMElNUWVoSHBLaWgybDgzMmlhNVpQRHlCNXVDSWVMUjVG?=
 =?utf-8?B?OU9oMjdQSm9EaDQrbjdEakVqa2VTUmt5VFU3RFdUT0cxTnFkUnFXWDVZSE4x?=
 =?utf-8?B?TDV0b2Q0cVZ0Q0krTm1pT3FOZlQ1dDJndWxqS1VXaXBINjlvSlVQYnFLNnpR?=
 =?utf-8?B?Zmw4anVVSFlkVStCTk5GWGdRcGM1SkMwelY0NHA1dXJKTmlrQzZHQzlFb0Ux?=
 =?utf-8?B?bDQ0OXRkZ00rSjJRZTVkd01oKzBCcStzcFcyUXQrdWVYOUVqVGFMTzFacTJ1?=
 =?utf-8?B?bzhZNk5SZVd5Vm9uYVVsMFBEYnhWdFl1YmhPZ1lSRjFvRnVwSDJWR3Z0OHdG?=
 =?utf-8?B?ZWJ5aGNLSGNUSThIdGpjQzJFOFVLcmxNbWdHMERVR1NwUUd2VkxkbnZFU2Ft?=
 =?utf-8?B?Wm5YTGI0V0J6Y3VNMWF2eENmNTJZVmZNTjlYZ1ZLTHl5SjBVWmhEQzVGbjFT?=
 =?utf-8?B?d3dEemxYWXptZ3RqL0RnajZhVnNzWXhhMUQwOUM3R3NaU284cXF0aEJxWnhS?=
 =?utf-8?B?U1Y0N1hYTkw1SXl2UkRYVHJHc3dTMTBmdFBabmJsUzZZMklnOXRlM3pCSGwx?=
 =?utf-8?B?cjZvVjFrTkJHeTJEYVBvUjFUR2Y4dkU1eUdyanQ0b1dNMVBiWEd2M2t6VlFI?=
 =?utf-8?B?UmN5bnhYSmE3V0l0WTZNcHQ5WWc5ZHlGVnVzT1Fqek9EZDVSdUYydUhTTWdW?=
 =?utf-8?B?aVZNZDdpQlc2V2dLays4RUdLMjAwelVGUVFPL3ptaG92L1lJYWdVTXdBUm0r?=
 =?utf-8?B?MEtRRTJYR3hHVnlXQURaUXJTSkJ1RjNBU2tpeUhwR2poQ1ZEWEdPWDkyeVVz?=
 =?utf-8?B?RHR3UmlkWm9wdEJsK3hPNDNZWi9Tdmltb0ZEaUdibGdpbjBzMFBJQXBYTnlZ?=
 =?utf-8?B?NHRBS0hrUjJKTXBRVEZieHJ6OHZMbmQ0ckwveHNhZ0h0NTVRa1dHeUY5bHJu?=
 =?utf-8?B?Vkl2bmRHS0EycC9CNitvVkVTNDQyNmNwSG1BU2RDNGpBTnpXL1MwM09EYTYz?=
 =?utf-8?B?OS9rcjJrOHN5VUxXQkVBRW1jUXdEZDBHTXR3QnVzam00N0lkQjJXZEpaTGVV?=
 =?utf-8?B?OG9TWmFSNWR3Q1BHbHprUHpYc2pxUmJCRUhVTUhSUlhkRTRSbE5aNEZzRjhw?=
 =?utf-8?B?enMxa2FyeE5DYTNqZENVNmtRZE5DM2k4Q0NMK3BOa0IyUUZYWlRRQTFLaHlj?=
 =?utf-8?B?RXErdDh4ZGhKUGk5dVdWVmw1VU1kNVdMWldPSGRnSUdXWXV1cUs0TGx2N2hR?=
 =?utf-8?Q?vlDIOw3JK79H+gVczx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b1a1c6-4cc3-48c0-2395-08df457114a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:40:09.2610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPJCUwxARS87d33/NepHmiQLB2zwEuW3zNX/zyQ5b2T74YBWDAmAMRyoXNGziIXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/26 12:40, Mu, Zihao wrote:
> From: Zihao Mu <zmu@amd.com>
> 
> Wait for the shared root KERNEL move dependencies in prepare, including
> NULL-sync calls, and remove the per-batch wait from the CPU update.
> Allocation now commits and prepares again before further writes.
> 
> Use uninterruptible waits for both explicit sync and KERNEL dependencies.
> An MMU-notifier unmap must complete even if a signal is pending; moving
> an interruptible wait into prepare does not meet that requirement.
> The infinite, uninterruptible reservation wait needs no error branch.
> 
> Keep the CPU write/flags body and public callback types otherwise
> unchanged. SDMA resource-allocation failures remain outside this CPU
> signal-handling fix; no allocation retry or no-fail claim is added.
> 
> Link: https://lore.kernel.org/amd-gfx/bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com/
> Signed-off-by: Zihao Mu <zmu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 7521c5be207..b6d774751cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -50,10 +50,19 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
>  static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
>  				 struct amdgpu_sync *sync)
>  {
> -	if (!sync)
> -		return 0;
> +	struct dma_resv *resv = p->vm->root.bo->tbo.base.resv;
> +	int r;
>  
> -	return amdgpu_sync_wait(sync, true);
> +	if (sync) {
> +		r = amdgpu_sync_wait(sync, false);
> +		if (r)
> +			return r;
> +	}
> +
> +	/* MMU-notifier unmaps must finish, including when a signal is pending. */

That comment is not even remotely correct. I think it should just be dropped.

Apart from that the patch looks good to me.

Regards,
Christian.

> +	dma_resv_wait_timeout(resv, DMA_RESV_USAGE_KERNEL,
> +			      false, MAX_SCHEDULE_TIMEOUT);
> +	return 0;
>  }
>  
>  /**
> @@ -76,12 +85,6 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  {
>  	unsigned int i;
>  	uint64_t value;
> -	long r;
> -
> -	r = dma_resv_wait_timeout(vmbo->bo.tbo.base.resv, DMA_RESV_USAGE_KERNEL,
> -				  true, MAX_SCHEDULE_TIMEOUT);
> -	if (r < 0)
> -		return r;
>  
>  	pe += (unsigned long)amdgpu_bo_kptr(&vmbo->bo);
>  

