Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B9CC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 03:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C8D210E979;
	Tue,  8 Sep 2026 03:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c2vD/aYG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B75D210E979
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 03:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ku0Xc35S/TDPkYMImCVWYFd8i1OuwBb7QNQ0R8GNjd/wZO4uIcPlcHw8bLPIk65hG9Wcp1JQZko+wdQoVC6NP0PFDIemkNoj/xVjqWLmCMUSy2vW1fITMBt7TBpbm3f05vqwpbZ07eOuu6Gkb5D8YvYDK8qAKgZtLAhBHpi3HQe+vOmc3n8J9Nxy7IIZCArMgmjZkxb7yg81fcL+rQHkW3fmzNfml8n08lzhWGkgOAief2nJmSCCH2cx67dCnL9cRysq/36lGGuTGd1UGZfHuZa2lp/1fjFE93XoM0vKGZxqWQQd+C1A6jvMqOLL7MC0uIPJrhsaqewNmfljQdQM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6Tbt3C9pRd/zNv9/bt1RRvBY+5CXaJb4zvcHkZTWKA=;
 b=F7NrMxf2kNzIaNz8JtM+fAyFPYji1a6KDcgmpklg8K+TU6+jXThbaNOB8NnUQFz1XihImu074+wt4OJQbxEpyxbvuGhRgyoJwi9fHJ8y3VJz6TAYZp6XaP86G0kUrL8QgSaJshzJEFnjXmXOIjLN8I+IXfsrLXCjWYQSI3k4J8ZIp1Pbp75Ryht0of2/nxxMyXMph0daPFgCGkSWAnU2chKXG2BoBMaKNwsuCljORcF88bb4K4POgpw4pJFW62BbhlPHO+fWOq0d6B10tS4Hka3CLSCUUjxfG/dFvRXAwKy0Zpf0TTrubvlkWNYIKszVDaSdiyfq0xSzWynHuoTbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Tbt3C9pRd/zNv9/bt1RRvBY+5CXaJb4zvcHkZTWKA=;
 b=c2vD/aYGRTqYOFeJzLMwzwHMGLkxZ1HzBeP2S/S/zD+ciApVJElmUFLmEKm4hQsk872PJ5gbOwXqwf1um9HmqhzxLzwev+Lioy4cI43zAWzhZi7ex2QnCNISeoz9S2ZtJ1Fb/nbEgN+K6v39pUTLNVB7L5irccKa5Kg3XP5LdGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 03:25:35 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:25:35 +0000
Message-ID: <221e4720-6624-40b4-81e5-8e945822f805@amd.com>
Date: Tue, 8 Sep 2026 08:55:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu/sdma: Always handle kernel queues in
 amdgpu_sdma_reset_engine()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
 <20260904072850.321759-8-timur.kristof@gmail.com>
 <e6270791-f276-487e-abc7-4ee1a529f357@amd.com>
 <ZBE1nOSpRoOewoLNHFTFIA@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <ZBE1nOSpRoOewoLNHFTFIA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0223.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e49230c-56c9-49af-0218-08df0d58d89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tQquVHRFYnoLuZOiK5L15R6vWr72/EDGfFdeGklOors1DmBH6ZXLO3bRacn30T+rmUEKLbBTN6DiPRGYHtOUPhShDYddRw6y7CNpxjtRrGklVMy000hWeEJsLymUqw9Vztxk8j8s2cCoqALLd69AiqXOXEQe9gx+PMniGs5QYm6fr/mAlcFCbhQUB99F+TmQ33dNUvPWU0Vkq5pKqmfokfa+lL52cT0eaI4ewpBuDfiqQELnF4srLZn1CSErVtZxIbWyzkXvPlH0uLdl4DpxUP2M57cN75sN7dznC3IydxI1DWmTTKCcCVtbYJRNmka3rBnLawPXD1meNEHMGEFNE+2W5e+fraFeV97oBHE/Www8zxW59GyAbKoZ03CdSBAcpu2D26ZdQTZyAdrvx9CX+eCsF6Tj0g/XDLpXZmCi7HTZEYvBawJzi0bEVxyjH1lmvKbpAvRSBpQPp8Z7mf6WMY3Dw0grYOAot8Q80/r0riBEGwPaogd3luJFpf5E58w3Fe5VX7xb6sZkr0UZszPP1/25Z9EJ2H8EN5vA4GbVnMybfo88YFzqjfoc36ER9U4Rl7sGIKfP2dEr7qjllLKlqVEmATJR86NVzSMkFb65BQ9kDLxHSsMdezP/p9WxHTqKwiYko2JV/sTq0ltBjmkHIeKrYBqtyIf652HzltSW9gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXdIUk92bVdpbGl5Z1J2VWNhMExvSVpNMEVQckxUUG1WNm9NOGlreXovNnVw?=
 =?utf-8?B?Z3YvSnNxbzc3ZnNmeDV3bitBM0xsakNPRW1FS21wQllXUDRzYS83SGFvOHRn?=
 =?utf-8?B?cGQ4MXhnVHdRUDV4REJsYjlnMCttYVhUeDIyV2xNY1lDdlFwNWVqcHFCRVd5?=
 =?utf-8?B?MGYzK20xNERMNGg1K1lGS3ZudWNPNVJqcE1ZUExFSzVPcndLN0ZtY0FMMnJw?=
 =?utf-8?B?QTRqZCtMNlN3WmdBY05jMDIyWHNiUEpZZ29iaExlKzNNcVVSSml1cG85Z3Bt?=
 =?utf-8?B?TzBSbHpJY3liemZSRXBuSnJJUWNyVTJoREVBRkx1ekp3enIwZHA3UXdjanB4?=
 =?utf-8?B?THBoKzltbEEvN3Y0bmFUMGlYODY2ZnhvR0lGUVlrSWNZK1VIRHg0MGdIS25v?=
 =?utf-8?B?TDVLWU50NGNEZ2RYQlRvdE14NE9LUm5rZTR6c2R4ZlcwOVhwMjlGSlBlRm14?=
 =?utf-8?B?SzUyL0RpZTI5N0NXUUt5eXpKNXBMMXBjdEZoaFVGejVIMVFobWszK2FGc0ho?=
 =?utf-8?B?ZW1sMXh6RTNxTUt1U1dZeXp5L0RScUtNZUt6Sm5tMXRNZWljN3dGQXd4amUw?=
 =?utf-8?B?S3VlTVRaZTl5WG1DbGdBVm5RZW1kd2o3QWlWUjVma0FQa1E2eXF0Wllnejdy?=
 =?utf-8?B?a2RYUkRWUUVvWE9Jc1V0a3R2bzcvdTY0NkdJZWxSZEEvM0dZUVhiczEyYnhM?=
 =?utf-8?B?bExTWnZJNFB6a2hTQUthenpUL25JOFpRMFg1N3VuZGdDZGgyMi9hbHYzSW1G?=
 =?utf-8?B?cHVEQ09YRU1UR2FrVVVGeklsR0ZxdG4yVlNVL0ZLMlp4ZmZkSjRMazJOaU93?=
 =?utf-8?B?MG9XR3l0bGJmUW95MmZzNGMwOFViTVN4V2xFNU84NlRpTlBSeHkvTUNGbnhR?=
 =?utf-8?B?Zi85UCtoRFBqbkVtMWozbU1HaVp3ekZnbkhnME5zNGUvZUpxQnVkMTlLYjZC?=
 =?utf-8?B?ZnBWRDN3TEU5Ymh2bDNTY1hENWwvRkZBVHoxMGdBSm9sMVFPU0d0R2oxeFBu?=
 =?utf-8?B?R2JrNEJvajZsdStoUURxWVB0S25jSEhQZHN2WEVnaHJKV28weUZyVDVURHBQ?=
 =?utf-8?B?UUhHVzVRNVhSWno2M25iNnRSWFdUeGo5aVFYNktnQ3R0M2pMeXN1dTIzcUJs?=
 =?utf-8?B?WDZTUWJYakdSb3BwMWFLbVFWMnhaaDlVcnhFaE5DOE9YTml3L2lIRXlaaVpq?=
 =?utf-8?B?R091ZHNxS01ObTNUalB6YTZUcVQ1N3gxaDd5MnNac3IxZndqN2hMZENKVHpM?=
 =?utf-8?B?clB5WW4vcXJ2T2FXNXJLdzZqNE9RbmRWaVNRcisrbzJybUNTL2R1RzFwN2FI?=
 =?utf-8?B?RUJZUmdqU3I2NWMvckZ2aEgrNnArSXd6dzdMdnczRnlscFFiK2JUQUxPdU1V?=
 =?utf-8?B?dElwa3kzdEF6L2ppU3hFbzFEekZTaUZIWlVWRHVUZUY1WXVHWDZaL05kRThG?=
 =?utf-8?B?RHBrNHFNY2ZiK3N5NGMzKzU2V1l2YkE3RHpRTTRsbXFlK2NUUHkxQTJ2RExx?=
 =?utf-8?B?OUxUQ1VTQ3d3ZVJiNmVMam1kS01JWkFDcE9uRzlZRUcwNDUwUkdyT3dXZDd2?=
 =?utf-8?B?RzBCTFZNZ3ZXWjcweGJTUEZNdlFocjN0cEsvd20yVk1PaDBZamV1amZLc1FS?=
 =?utf-8?B?LzZCRjNUaHhzRVhPWGRnQmxjS3VJdi8vMzNib2dkWVRucDRzTlRBSWtBUDNl?=
 =?utf-8?B?SmNVRnd5RXE1S2JKNThsVktacFprSWczUzBPQkY0c09uSzU1ZjBIRURnNVh2?=
 =?utf-8?B?ZUdEYTBkNkxCMW4wTFBGdlk4djQvVFQ2L2o3d3YxQnFIa0lXSkZEYS9PSFV2?=
 =?utf-8?B?aXBkcW9VT1k2dDFsdS9WQ2xnV1kwYnYyZU9JbFZ1OEltb2FUWEFLdzl4bzll?=
 =?utf-8?B?NmRuUWo1RnhLRnZnYkRNc3JyZ0I3RVFNcTY2WmdVM2o3KzRoeWFKK1VFbVNG?=
 =?utf-8?B?dlVNUkJoY05TaW1TTVQyWHIxWEhUbEhndUc1TnAraXNYSTRnR3Z5alMyN2JY?=
 =?utf-8?B?ZVdHaHlqZXBCdi84MVZ2Tkp5K2F3T0RFU01HUGhITStyRWV3TzFHV0Y3YTFY?=
 =?utf-8?B?NFJ6RW5tdVI0djNYKzBsZGRuakk1bS9JTGZGMEFoc1B6V0pwdDh1N1VJMEs3?=
 =?utf-8?B?MDF0UDJEbTJPOXJOV2tVYWhtOWRWUk1yL0pPb0JlbEwyTG1TTEZMVDE3cTlQ?=
 =?utf-8?B?dmpGdWkxUnZ2VldJbGduS2NIb3ZwajhWMDQzS1Rjd1BYYk8rMUdWTXd6TFdq?=
 =?utf-8?B?cWM3RHF6c2tGVGJLT1JwbGFDVEJhRHdlU3VMMXlGenNmbmRHSzFSTmxubzR1?=
 =?utf-8?Q?ZXBWY9ekNmfcyqxc1v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e49230c-56c9-49af-0218-08df0d58d89b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 03:25:35.5789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trx2jz9w7Kt0AsTfyqLkSKSIr/5juoR/9qDy3pDllouPu4CSPDRhaohqluHN/jIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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



On 08-Sep-26 12:04 AM, Timur Kristóf wrote:
> On 2026. szeptember 7., hétfő 9:17:12 közép-európai nyári idő Lazar, Lijo
> wrote:
>> On 04-Sep-26 12:58 PM, Timur Kristóf wrote:
>>> Remove the caller_handles_kernel_queues argument from
>>> the amdgpu_sdma_reset_engine() function and make it
>>> always handle kernel queues.
>>>
>>> Now the SDMA recovery sequence is more consistent
>>> between callers for the KFD as follows.
>>> Before recovery: first the KFD is suspended,
>>> then the SDMA queue contents are backed up.
>>> After recovery: first the SDMA queue contents
>>> are restored, then the KFD is resumed.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 68 ++++++++++---------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  2 +-
>>>    .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
>>>    4 files changed, 38 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index
>>> 9eebd8380834..07aac5b3ea92 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>> @@ -542,16 +542,14 @@ static int amdgpu_sdma_soft_reset(struct
>>> amdgpu_device *adev, u32 instance_id)>
>>>    }
>>>    
>>>    /**
>>>
>>> - * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
>>> + * amdgpu_sdma_reset_engine() - Reset a specific SDMA engine instance.
>>> + *
>>>
>>>     * @adev: Pointer to the AMDGPU device
>>>     * @instance_id: Logical ID of the SDMA engine instance to reset
>>>
>>> - * @caller_handles_kernel_queues: Skip kernel queue processing. Caller
>>> - * will handle it.
>>>
>>>     *
>>>     * Returns: 0 on success, or a negative error code on failure.
>>>     */
>>>
>>> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>> instance_id, -			     bool
> caller_handles_kernel_queues)
>>> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>> instance_id)>
>>>    {
>>>    
>>>    	struct amdgpu_sdma_instance *sdma_instance =
>>>    	&adev->sdma.instance[instance_id]; struct amdgpu_ring *gfx_ring =
>>>    	&sdma_instance->ring;
>>>
>>> @@ -564,20 +562,23 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device
>>> *adev, uint32_t instance_id,>
>>>    	mutex_lock(&sdma_instance->engine_reset_mutex);
>>>
>>> -	if (!caller_handles_kernel_queues) {
>>> -		/* Stop the scheduler's work queue for the GFX and page
> rings if they
>>> are running. -		 * This ensures that no new tasks are
> submitted to the
>>> queues while -		 * the reset is in progress.
>>> -		 */
>>> +	/*
>>> +	 * Stop the scheduler's work queue for the GFX and page rings if
> they
>>> are running. +	 * This ensures that no new tasks are submitted to
> the
>>> queues while +	 * the reset is in progress.
>>> +	 */
>>> +	if (amdgpu_ring_sched_ready(gfx_ring) &&
>>> !drm_sched_is_stopped(&gfx_ring->sched))>
>>>    		drm_sched_wqueue_stop(&gfx_ring->sched);
>>>
>>> -		gfx_fence = amdgpu_ring_find_guilty_fence(gfx_ring);
>>> -		amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
>>>
>>> -		if (adev->sdma.has_page_queue) {
>>> +	gfx_fence = amdgpu_ring_find_guilty_fence(gfx_ring);
>>> +	amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
>>> +
>>> +	if (adev->sdma.has_page_queue) {
>>> +		if (amdgpu_ring_sched_ready(page_ring) &&
>>> !drm_sched_is_stopped(&page_ring->sched))>
>>>    			drm_sched_wqueue_stop(&page_ring->sched);
>>>
>>> -			page_fence =
> amdgpu_ring_find_guilty_fence(page_ring);
>>> -			amdgpu_ring_reset_helper_begin(page_ring,
> page_fence);
>>> -		}
>>> +
>>> +		page_fence = amdgpu_ring_find_guilty_fence(page_ring);
>>> +		amdgpu_ring_reset_helper_begin(page_ring, page_fence);
>>>
>>>    	}
>>
>> Since this resets the engine, a different way may be to have something
>> like below (similar to amdgpu_multi_ring_reset_helper_begin) which takes
>> care of all rings in the engine instance.
>>
>> amdgpu_ring_engine_reset_helper_begin(guilty_ring, guilty_fence);
>>
>> amdgpu_ring_engine_reset_helper_end(guilty_ring, guilty_fence);
>>
>> ring_type = guilty_ring->funcs->type;
>> eng_instance = guilty_ring->me
>>
>> Thanks,
>> Lijo
> 
> I am planning to do exactly that, but I want to keep this series short and
> focused on unifying the code paths for SDMA v4.4.2 and v5.x.
> 
> Is it OK if I do that in a follow-up series?
> 

Yes, that will do.

Thanks,
Lijo

> Thanks,
> Timur
> 
>>
>>>    	if (sdma_instance->funcs->stop_kernel_queue) {
>>>
>>> @@ -612,22 +613,25 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device
>>> *adev, uint32_t instance_id,>
>>>    	}
>>>    
>>>    exit:
>>> -	if (!caller_handles_kernel_queues) {
>>> -		/* Restart the scheduler's work queue for the GFX and
> page rings
>>> -		 * if they were stopped by this function. This allows
> new tasks
>>> -		 * to be submitted to the queues after the reset is
> complete.
>>> -		 */
>>> -		if (!ret) {
>>> -			ret = amdgpu_ring_reset_helper_end(gfx_ring,
> gfx_fence);
>>> +	/* Restart the scheduler's work queue for the GFX and page rings
>>> +	 * if they were stopped by this function. This allows new tasks
>>> +	 * to be submitted to the queues after the reset is complete.
>>> +	 */
>>> +	if (!ret) {
>>> +		ret = amdgpu_ring_reset_helper_end(gfx_ring,
> gfx_fence);
>>> +		if (ret)
>>> +			goto unlock;
>>> +
>>> +		if (amdgpu_ring_sched_ready(gfx_ring))
>>> +			drm_sched_wqueue_start(&gfx_ring->sched);
>>> +
>>> +		if (adev->sdma.has_page_queue) {
>>> +			ret =
> amdgpu_ring_reset_helper_end(page_ring, page_fence);
>>>
>>>    			if (ret)
>>>    			
>>>    				goto unlock;
>>>
>>> -			drm_sched_wqueue_start(&gfx_ring->sched);
>>> -			if (adev->sdma.has_page_queue) {
>>> -				ret =
> amdgpu_ring_reset_helper_end(page_ring, page_fence);
>>> -				if (ret)
>>> -					goto unlock;
>>> +
>>> +			if (amdgpu_ring_sched_ready(page_ring))
>>>
>>>    				
> drm_sched_wqueue_start(&page_ring->sched);
>>>
>>> -			}
>>>
>>>    		}
>>>    	
>>>    	}
>>>    
>>>    unlock:
>>> @@ -662,13 +666,11 @@ int amdgpu_sdma_reset_queue_legacy(struct
>>> amdgpu_ring *ring,>
>>>    		return -EINVAL;
>>>    	
>>>    	}
>>>
>>> -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>>> -
>>>
>>>    	amdgpu_amdkfd_suspend(adev, true);
>>>
>>> -	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
>>> +	r = amdgpu_sdma_reset_engine(adev, ring->me);
>>>
>>>    	amdgpu_amdkfd_resume(adev, true);
>>>    	if (r)
>>>    	
>>>    		return r;
>>>
>>> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>>> +	return 0;
>>>
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h index
>>> cb41453c1a19..5709d438e824 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> @@ -153,8 +153,7 @@ struct amdgpu_buffer_funcs {
>>>
>>>    				 uint32_t byte_count);
>>>    
>>>    };
>>>
>>> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>> instance_id, -			     bool
> caller_handles_kernel_queues);
>>> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>> instance_id);>
>>>    int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
>>>    
>>>    				   unsigned int vmid,
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c index
>>> 77f385b9ef53..796ea9f74763 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1583,7 +1583,7 @@ static int sdma_v4_4_2_reset_queue(struct
>>> amdgpu_ring *ring,>
>>>    	int r;
>>>    	
>>>    	amdgpu_amdkfd_suspend(adev, true);
>>>
>>> -	r = amdgpu_sdma_reset_engine(adev, id, false);
>>> +	r = amdgpu_sdma_reset_engine(adev, id);
>>>
>>>    	amdgpu_amdkfd_resume(adev, true);
>>>    	return r;
>>>    
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c index
>>> a23384571193..f9fbc5628fb4 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -2576,7 +2576,7 @@ static int reset_hung_queues_sdma(struct
>>> device_queue_manager *dqm)>
>>>    				continue;
>>>    			
>>>    			/* Reset engine and check. */
>>>
>>> -			if (amdgpu_sdma_reset_engine(dqm->dev->adev,
> i, false) ||
>>> +			if (amdgpu_sdma_reset_engine(dqm->dev->adev,
> i) ||
>>>
>>>    			    dqm->dev->kfd2kgd-
>> hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
>>>    			    !set_sdma_queue_as_reset(dqm,
> doorbell_off)) {
>>>    				
>>>    				r = -ENOTRECOVERABLE;
> 
> 
> 
> 

