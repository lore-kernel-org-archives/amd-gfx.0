Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7287EB7EA5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 10:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7672A10E108;
	Wed,  4 Mar 2026 10:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PaF+HKi3";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6B310E108
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 10:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSV6Xksh4Ja0XVUUJY4eWldgAeObQUi/qhGXoN6vMH594Ns0IfIV+jNSta4EGYiomn8E9k3x8d0aCOejd+xmRY9Fm1eTlJIvqH3JC2LzEWh2V4twEuEf0x8YXykShzfAvmYThL1oRcjydoC8X0NK5j6AJvqNw0ZzxqwzsjOida5msJ1vxVFGNHLNHEesb4CjauEkwuI3lI2zcsfDgmlIuyk71oawGGLLHcsVInOGNjpO7m8bq37xyWRH4CGLBEA4Jm45IRKa/BGt4gQLsjF0ixEq7+Zu+MN7UNCZSk1q9i6hISOiKCCZ+2q0ULa9NSv3f1FoKQbIePF/Z2njPlFmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEAhoozfDDCdi7j7cKpp7TJkjiZ59MMrN9qf0tvYlLc=;
 b=UtxcgaJIhCp3HwPuu3ONE1fosn/WLVYVctHOnGJj1Lwvh5u8becBpMFsCT/4JAcjOFfF2uy7JRH+GghfynwHuyGtMnhmxhlHP8btWvScoiBDGKC2wLGvRucn75B4SOwoP1hGOYHl+f5L8NSnxdpW3ja5l+MUOddGEFH/zRiJr8rOEFdb/GHlJ1xZ05z593HMRSMaN02aMocrhes45Q2lL/QvRLAvOoqWo7FotTShwjGOBVDaltKk4la0DMjmh+xkg+FOLfpUfLF6hGkOrkNGL7jvy4S2Q7HDR9E1yJ7IZyWQnQ1HWgoct17QFGxRYnPbcvSFxzjsln4BEbJFaXQ09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEAhoozfDDCdi7j7cKpp7TJkjiZ59MMrN9qf0tvYlLc=;
 b=PaF+HKi3f7o0ocgRMnqSXAYWcpHNnEN5HLut2yGe8H7G9gU2KlVEvJcjyVq+m/9emNznFq2ignwVPGN9j06N+3dJuVnxCOPqMX2kF1UcEifY5emQRRswKCjIyGT8iqFJL2YS6gsoJMY5p+7G4FtvoHyr930UawE7HWHKHEM+ZpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 10:21:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 10:21:10 +0000
Message-ID: <8241286e-49aa-4cbb-8bd9-bb660682b530@amd.com>
Date: Wed, 4 Mar 2026 11:21:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] drm/amdgpu: Consolidate ctx put
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
 <20260112102244.63308-9-tvrtko.ursulin@igalia.com>
 <4a57e7f6-0722-411f-a37f-24d1f5d6f0e8@amd.com>
 <1dc6b09f-563a-480a-a884-101271302367@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1dc6b09f-563a-480a-a884-101271302367@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c6c331-603f-4be5-4a99-08de79d7c11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: mHgn+Hsn7DrzIawbPeLRqAeiWHvLKEIhH2kRGJvM/s7QYTVklLQIybq8HO7Cxk7eMn8XieRDRjupzGqx9vkV4Fe9Lq/UblcfNWtmRrNqV1L1MsT5te/RW1wcfiYj1SPwNY/XJMQYw0kufNZoiYruy/R5pamRnwOXnumYRysQoJqy4lfneQih+g4t7EHud7IhGR6iEKq21ll0fCt0OIw1iD3fJgj2+KS6D6zDYxTULqkAWYLP64A8710yh1sjUQbnX0vXdf1PpmxdEUXn6j6Tf1tOAO3akqBg69rehqOfkkrhc6LENvBoqj3DYa+mRTP3LCJrrJcx90tf+J+laA/MfdcVBF7nxTAz7qRu2fTZ8pzqnvZzC511Ujpb8jfcP2Ywjzb7wUWlI7SxapmIrDgfMfYKxHiFmOAnD1JgSec7FYklWy5gUX9huHLmuWyIFkunBnpa74GfsTOEWPANC6AbAboUoiuj+pUq9qRXg/W7YwDrB5HeZhWJI4Xx/aXgb4u/ygzK6TIuo5a1+hROo+Lv/2VRiHwE0EpRIPQrXhmdxcfoyBBe1unNmAcgcCbC9K4MJpBE4jsXKAPN+WlD1stQ9qvgp8BoLagcupYZ44Byqh+62Co7eBiKDh4QuCkTu5Yfxe64GqSj/pJG9PoGzTHMxwN/Rplb2Xiu6VR3roOEytqv66iQdJYoMQNBhRo0F13LVFwrB+pS6q4CvFb7hGGsQlnVhuyb5KVuT0N7rlLXHeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVAzbnh0WW5Ca1JlMGxsL2hKejh5Z1lQbHdlbEVDRU4zRXRwRkhTeUkrcktp?=
 =?utf-8?B?OUhyVkR4amZQUWsvSXBueit4L2dIdDluemhKalVBenlzZmJnbmx6eThQUlhW?=
 =?utf-8?B?b0NLenFJSjBuSVlOclNyZ2FHTGRZSHdIZ0VIWG5DRjNyYURIT0czNXdxcU9m?=
 =?utf-8?B?djRGZFZEa05KbURQaXBnSkNlU0Z6RjgzaVVjbjRSVTc0NEFIdGRGa1hhd3g0?=
 =?utf-8?B?Q1BaczlMNUZXSlF4ZzZvcU1pc3dVOUZ4RnM1Q3ZQRlNaUWdwZERGNGMyRTdr?=
 =?utf-8?B?b0tMTng4NzltTDdjY3JSOFlMQUc4dmdQVlNnZjU1SjlXYU1HMmg0d2ZMdWpJ?=
 =?utf-8?B?UnUwL1lsSStKRFgxb0JHVVE2T0xxTjRFTk1KMEZIVU42T01lNlM3bE10b3pH?=
 =?utf-8?B?S3hiLzdlTjVxUFFoZHg0eGJLRmdVZTFONDJkVzloK09tM1hEcDVwbVowSkJj?=
 =?utf-8?B?WmkzelEwNHB6WUZ5UDR2c0VhWmZ5V3FsSjFTUmlwRmVzN1hxVzQ5ak5mOUVV?=
 =?utf-8?B?OENJTnV0cVNNVTVkWHREUjkzMC9oQ0c2ZWJlTXZ2K0orL0hyYkZGV1Z2Ulhz?=
 =?utf-8?B?cGlpNVRmV1VxWHlmTlEzcFdDa1hNdmtpc3BHTm9KclRidWtQRTNCanJsRy96?=
 =?utf-8?B?eXM2djlFS0VIdWg0UkZQRUNPVlNLdHVxYkhqRVREdm9OeDhGbUVZMlpvNTA0?=
 =?utf-8?B?NlI4a2JWTU81RnRkdmRYN3E4ZVJMUmgyUitaOVo3S0tOUGNsdFpsWWVCcm1t?=
 =?utf-8?B?NXFrLzJBbmNrQ3l0ODFrdzNNVTIvTkVRTUhuQWlBNFM4LzkvSVhCcEQzRFYz?=
 =?utf-8?B?Qm0yT0hoMENLWmRzbGU1K1RlSXNLU0VTaXd2SnhHbmNBYnE3OGRORzdiSWY0?=
 =?utf-8?B?bWwrS0xROVIwUUJqYnlpZzVxeVNyak04WU9hbkxrVC93Y1RZNmNvblhwVW42?=
 =?utf-8?B?K0RpUFkzUVZBL0VtRWVaSTF6aVBiZFJkWm9EcU9DUnVxM01TM2VmVWg4VFEw?=
 =?utf-8?B?UUlRT1JibGVFZEJRN1l4dHprWDJKVWkyQVhvWndOeHQ0cjFzR24zSHJZSyt2?=
 =?utf-8?B?VW9SdmVqMzNvMTZ6MUZFNmRTaGU5bjhZVEFzMlBzTjJwQnJDQUtSMFAwMW1k?=
 =?utf-8?B?Rjdud013dW56R2RZdnNtdXI3VGFvdzBFTmdzRDJsSDRvMWVmOU82L25CL1oy?=
 =?utf-8?B?eDE0WU9rVE5RSld4K1UvaStSeDllUFk1OVB3L1QzRkxMSVhTY2VadTFoNnhD?=
 =?utf-8?B?ZjNyVmhNSEVUcEppR21KbC9Wcy8zUFhTMGxRV1UrWWlaWER6eE9ORWpUOC9Y?=
 =?utf-8?B?eitxQmU1QnNWTDlZMWg3R2lsbTZqYjc3Q0F0R1N0VXNlbGpsZDBqTkFmdzlR?=
 =?utf-8?B?R1hrZ3gzWVphVzQ1dUkwS2JuTWdFTTVxTzF6c2xzcHh5SUtZNnVUbHRyam9M?=
 =?utf-8?B?UlZUUWN0L3ZWRWI4d0RTU1Q2am5sUzFtMVNoVUpETE83aXRLLzQvTkcxa3k1?=
 =?utf-8?B?Y0VhdEs1cG9pb2NvOGRDMXlJd3NQOXBjQTAreWJRaTV3K3IyaFh5K0dvVHBx?=
 =?utf-8?B?MHpYU0JnTVBXbFE4bWtMb0NGU0x0UVhSU09tNGdmZzFqYklwVHg0ZXUvQWxp?=
 =?utf-8?B?MTZkRWwwQWpGaXJoMWIxcm1VR1l5OGFjVDNwT2Z5bjhlNXRQS0hSRGE0QVYy?=
 =?utf-8?B?ME94ZEgvSE1oYVlqd0dJYmNuSU9sRjJqQkI2WFhUWFVSejhSUFNLVVpzRVJO?=
 =?utf-8?B?Y3pjb3dHM2FqeXg4anUrMUxIYWVnQSswZ3ByZC9aRFdCME5iZTJ1UlZ4dGYw?=
 =?utf-8?B?ZDRROFptN2kyN21WVXFJYmwyQlhmc0ErSkZpWEYvQkt5cHRQTlpRYlVNRTMr?=
 =?utf-8?B?bFNNUmZWbytqaTlmU3R4SFZEU1JWbFNKM2EyL2gzSFkwdzhjejNSU3lLLzh0?=
 =?utf-8?B?U2VNNWxwZjRYNFNkb0lueHdzT1Z1cXcyRjZtMHA0NHVwbFZtZlNZR1NWcHRo?=
 =?utf-8?B?UlRmL0JvMzlzWWhRWDV5QlUvS2xwY3N1TW92My92RFQ5NGZBTWJIbHJSQUto?=
 =?utf-8?B?ZkJGbE1DczVkenFKM2hnU0hhWHVEUHVuWU9pYjhja3lYY0JVYk03eUJ6SXd1?=
 =?utf-8?B?ZXFJL3UrZ0FxU01JdGZBYWZabkFtaU90eHVrK0swK01UVEdIUDVwdUxFZlBq?=
 =?utf-8?B?L0xuVnNRMktGYnVzaER2b2QxL044WkN6a3FBeU1OQWJjcmp3dTA1bXdONFZk?=
 =?utf-8?B?QjBWMHMrYVcrcG1tRm9uQTNiK3cvZ1lBRzR4eTBCZ3lEUmFVdG56ZTZ5NDBO?=
 =?utf-8?Q?Dtx91Tu+2+buSh6pku?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c6c331-603f-4be5-4a99-08de79d7c11c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:21:10.0513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTmA3f0fOFHBop+sWiFOBgbKYzmrda3eBRNbK8lRLcPgzZ8li7ojPS7QmzfzbRoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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

On 1/22/26 09:56, Tvrtko Ursulin wrote:
> 
> On 12/01/2026 13:32, Christian König wrote:
>> On 1/12/26 11:22, Tvrtko Ursulin wrote:
>>> Currently there are two flavours of the context reference count
>>> destructor:
>>>
>>>   - amdgpu_ctx_do_release(), used from kref_put from places where the code
>>>     thinks context may have been used, or is in active use, and;
>>>   - amdgpu_ctx_fini(), used when code is sure context entities have already
>>>     been idled.
>>>
>>> Since amdgpu_ctx_do_release() calls amdgpu_ctx_fini() after having idled
>>> and destroyed the scheduler entities, we can consolidate the two into a
>>> single function.
>>>
>>> Functional difference is that now drm_sched_entity_destroy() is called on
>>> context manager shutdown (file close), where previously it was
>>> drm_sched_entity_fini(). But the former is a superset of the latter, and
>>> during file close the flush method is also called, which calls
>>> drm_sched_entity_flush(), which is also called by
>>> drm_sched_entity_destroy(). And as it is safe to attempt to flush a never
>>> used entity, or flush it twice, there is actually no functional change.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Looks like this was the last patch to review. I will pick up the set and try to push it to amd-staging-drm-next.
> 
> Gentle reminder if we could try to validate the series via amd-staging-drm-next.

I pushed the first 7 patches from this series to amd-staging-drm-next and our CI systems seem to be happy with them.

But starting with patch #8 I either had rebase conflicts or the CI system seem to reject something here.

Can you rebase on top of amd-staging-drm-next and test a bit more? If you are confident that the patches work I can throw them into the CI system once more.

Regards,
Christian.

> 
> Also, what could I do on my end to get more confidence some edge case is not broken? Run the IGT tests? Is there an useful testlist which can be used with the IGT runner or that is not used on the AMD side?
> 
> Regards,
> 
> Tvrtko
> 
>>> ---
>>> v2:
>>>   * Use separate variable for drm_dev_enter for readability.
>>>
>>> v3:
>>>   * Keep amdgpu_ctx_fini_entity as a separate function.
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 54 ++++---------------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  9 ++++-
>>>   2 files changed, 15 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index 325833ed2571..cc69ad0f03d5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -284,6 +284,8 @@ static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_device *adev,
>>>       if (!entity)
>>>           return res;
>>>   +    drm_sched_entity_destroy(&entity->entity);
>>> +
>>>       for (i = 0; i < amdgpu_sched_jobs; ++i) {
>>>           res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
>>>           dma_fence_put(entity->fences[i]);
>>> @@ -409,7 +411,7 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>>>       return r;
>>>   }
>>>   -static void amdgpu_ctx_fini(struct kref *ref)
>>> +void amdgpu_ctx_fini(struct kref *ref)
>>>   {
>>>       struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
>>>       struct amdgpu_ctx_mgr *mgr = ctx->mgr;
>>> @@ -508,24 +510,6 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>>>       return r;
>>>   }
>>>   -static void amdgpu_ctx_do_release(struct kref *ref)
>>> -{
>>> -    struct amdgpu_ctx *ctx;
>>> -    u32 i, j;
>>> -
>>> -    ctx = container_of(ref, struct amdgpu_ctx, refcount);
>>> -    for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>>> -        for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>>> -            if (!ctx->entities[i][j])
>>> -                continue;
>>> -
>>> -            drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>>> -        }
>>> -    }
>>> -
>>> -    amdgpu_ctx_fini(ref);
>>> -}
>>> -
>>>   static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>>>   {
>>>       struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>>> @@ -533,8 +517,7 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>>>         mutex_lock(&mgr->lock);
>>>       ctx = idr_remove(&mgr->ctx_handles, id);
>>> -    if (ctx)
>>> -        kref_put(&ctx->refcount, amdgpu_ctx_do_release);
>>> +    amdgpu_ctx_put(ctx);
>>>       mutex_unlock(&mgr->lock);
>>>       return ctx ? 0 : -EINVAL;
>>>   }
>>> @@ -750,15 +733,6 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>>>       return ctx;
>>>   }
>>>   -int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
>>> -{
>>> -    if (ctx == NULL)
>>> -        return -EINVAL;
>>> -
>>> -    kref_put(&ctx->refcount, amdgpu_ctx_do_release);
>>> -    return 0;
>>> -}
>>> -
>>>   uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>>>                     struct drm_sched_entity *entity,
>>>                     struct dma_fence *fence)
>>> @@ -927,29 +901,15 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>>>   static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>>   {
>>>       struct amdgpu_ctx *ctx;
>>> -    struct idr *idp;
>>> -    uint32_t id, i, j;
>>> +    uint32_t id;
>>>   -    idp = &mgr->ctx_handles;
>>> -
>>> -    idr_for_each_entry(idp, ctx, id) {
>>> +    idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
>>>           if (kref_read(&ctx->refcount) != 1) {
>>>               DRM_ERROR("ctx %p is still alive\n", ctx);
>>>               continue;
>>>           }
>>>   -        for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>>> -            for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>>> -                struct drm_sched_entity *entity;
>>> -
>>> -                if (!ctx->entities[i][j])
>>> -                    continue;
>>> -
>>> -                entity = &ctx->entities[i][j]->entity;
>>> -                drm_sched_entity_fini(entity);
>>> -            }
>>> -        }
>>> -        kref_put(&ctx->refcount, amdgpu_ctx_fini);
>>> +        amdgpu_ctx_put(ctx);
>>>       }
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> index cf8d700a22fe..b1fa7fe74569 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> @@ -70,7 +70,14 @@ struct amdgpu_ctx_mgr {
>>>   extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
>>>     struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id);
>>> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
>>> +
>>> +void amdgpu_ctx_fini(struct kref *kref);
>>> +
>>> +static inline void amdgpu_ctx_put(struct amdgpu_ctx *ctx)
>>> +{
>>> +    if (ctx)
>>> +        kref_put(&ctx->refcount, amdgpu_ctx_fini);
>>> +}
>>>     int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>>>                 u32 ring, struct drm_sched_entity **entity);
>>
> 

