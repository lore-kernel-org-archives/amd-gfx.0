Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4077EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E68210E40A;
	Thu,  6 Jul 2023 13:37:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0992F10E3E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U45PAw8GF2QCKTGcP88Ykal/04WI2PBr2viW+2K7ZRhMdTmzeLpx6/ydU4OnGBt8whBMJT+f7B0Lt4jNHWOW5KEA/lT58GhjQrkzGx/+oAudE7JiOB1Tj7xrIfvABQJpMWbm0D5AfNF5vdyaFxXCu7n5pWpwjS7/EHMh/fH/Ma2N2Ta29+EZDWVd6eZIo17VVJ3e7aZrPCoJbKRFCeHMQZAzlVg/LhegrR2GDacFmyPzzvFVDDTSGbtLRUVcNIbSWutBeKrdtxJ+3bp+uYR2akyDpjUA5Sf4nsaatXMhD/l1EnVREkm/JM3I0gGYcR/WnVCxgRyfWLPfDBR+3mC4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roIpevEnhAg7ot48s0FHIterTIR+xgECY9PaSonGx0A=;
 b=D68NWBbhMhHyR6DJS+bTs+PCPUKF/M37WOLD3sd3bILsoTM6IIocwKUJR/5jt5EaFxUT15lK+tnK8QwmJKP0XiGABWO99y8xUaWeid6IPdfVqkG10YAlOy3SMxoGi61YE3VcFu5wRqFCjfVJpppEIF9fJtNae7IDhz9oOxDH7W9QhnjDP1jMZ/lps/d/vgBzH3sBhUAQgkGVqNAt2Z1rKywll8+o/dJqWwvRajTM75A4q7SgimJ56+Ms6A1YYvTnkELz8wI706BF9ap2N5j14iOWKSLZzy+FuXVXKkUudr4A1zVaGy9IZIOjr33NEqjjL9CvMGRZaeYVqZmYWL9zwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roIpevEnhAg7ot48s0FHIterTIR+xgECY9PaSonGx0A=;
 b=YzahmRiHeeLjGui+YguVJUCs2juRahRZRlVGyTUiFpe0ET2IkOYOzd831SasSHhgIGLjwAfN47BJoyPJNy/OVpIxWeg8A6hQyLOq30Nv8IDW4Lk8DHBCfwXmV0f3uTz7PrNNSnwNzTaQyYkCpcfI1pp48JnnIGW59qE/djkdz4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:37:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:37:22 +0000
Message-ID: <578553eb-5f4c-d231-4def-4bbc6c3727e7@amd.com>
Date: Thu, 6 Jul 2023 15:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 05/10] drm/amdgpu: create context space for usermode
 queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-6-shashank.sharma@amd.com>
 <5d947a69-d77e-0a5d-5581-1ed4aedec6ec@amd.com>
 <80818bc4-f813-906f-1a43-0ccb29b1ca85@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <80818bc4-f813-906f-1a43-0ccb29b1ca85@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dd0bbf-93e1-4739-111c-08db7e262080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+qIcrnk3a6OEczZD8cq8UYtLj44N4wgF7TlKfSklnmuQFi9+fpdGylT722Svtow5ZCfmHOa/HF6TM2jSmpYHfOn5ZwlLrRwbuIJ8dM96MRvwKbpOo4W8eaXim2zyVyYhUYLdQ3Q+6lWH3bj6hEnGNRXqg8QhU2bBMhBXiUqtV66+x6p7oHssalo9zReNmQc8TvH/EFbMPjTiUkar1u3i/7sVn/bWzzdlV2KUfxRKhGBVHrsICfaLsy5gNGjBD/kihwnCozkKCytBSXjQBVIm+41jcU5v4n08bgBHC2L29ZDGjtU/fjV8ufrNp4MIu32lzo8KgI3Y9GZ3TIybtlbCFInRuncE/taz8cNutrAEeSETgDtK91aZ2qfG+Y5Vk53Brx0W+aKKlqkwcqSmxKHLXERcsqqmX2PRAU1DAQCAIjJuijbQ2MYf4GlmJVTViifrg+ggHtfxZNrDTDr8NfCbekdSncX3OQyJSlNCTiLyZRzH7mKLXJjORfcUysvvcEscW8wzRGWTaA6V1n333GY/cp0mhrFyc+ysc+dsxa83Qv83Q1Mt6m3s3c/L1uM2sys9hWUT7HKrYPWGP9OMAxn5bYesMI+WHZj2T6OamYyS11lGI7hhwg6S27hF6BTKA8g6uei6//IPcxWYGihfnuWcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(31686004)(478600001)(19627235002)(6666004)(6486002)(83380400001)(2616005)(36756003)(86362001)(31696002)(66946007)(2906002)(53546011)(186003)(6506007)(6512007)(38100700002)(8676002)(5660300002)(66556008)(316002)(41300700001)(4326008)(66476007)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWMzS2pVOTZDZnhxeFNTQSt2QmR1WWIxYkhyWGg0VFljWEJFR2UwbG5tTC9B?=
 =?utf-8?B?dkdiMjBCeGZEZzIyNklFbXQvTk9pSTVDcVZmRjIvU0xpZEJkYmtXMGpYTW1R?=
 =?utf-8?B?T2xCajZxRHZVYnpGcTFvL2NOR3g4TDBVSFBlTnpzZjNQZ0wrT0VNTWZNS3p6?=
 =?utf-8?B?QzVHSmdSam9taFhHSDFobGh0K0pYejZTNWtqeURSTDVyOUh0YitCSzRseW45?=
 =?utf-8?B?Qy9RdkpMd2lyZWhpbzZla2xqUG5EWUY2elZPUEdVQ05Nd0hIODZFUENJbGdH?=
 =?utf-8?B?SC9mNUlwNG01WW4vRzBna1ZpaTlxUDBqYlBvNWlEdUNDSGhVZGF2V09QaFdX?=
 =?utf-8?B?QkNKRVdiSmFHODY2R1BXdmdSVlhZL0ZRZjFhcUdHb1UvZ1pjTDI4MlNybnN2?=
 =?utf-8?B?dC93R0E5TlVocVVxNzBlcE5ySThMbmdoMHlYeTR6NWNFSm1oYm5WREZKMXQ1?=
 =?utf-8?B?bTJ0Q1RVWmt5cE91QkV5d3k1ZnNYNXBGOHpjOWptS1N3WDdNYzFNZkxWNXBU?=
 =?utf-8?B?U2J6TUJXK0JtUWZLdnhkVEJFSWZwZWF0SEw2MHFYUU96TzF5cEtubVphS0Zo?=
 =?utf-8?B?TGNVWmNURGUxWXpFMDUzR3VFVmovaGVEK3Rjbm1OTW14SWZkOVFhOW5hNGxZ?=
 =?utf-8?B?YjljS3NjRVJNUFdnbXU1N2dUUGh3OVlmQlFpbTJWVEtaOHRZV21Pbm5mRHE4?=
 =?utf-8?B?dG9heG9nRmdaYzA1NS85aW50Wm0rM3EvWnBjUGI3UmxCU21oZDRWNUllT0Vi?=
 =?utf-8?B?dlNuS215dDNQb0s5NEZ3bVNMR3psMkpGWVNVRUdaUkJNSHZDY3FzUFFpVHJC?=
 =?utf-8?B?YjM5MnRoYVJIUG9oY2t3T1BNRjA5SEIyZnp1L3cvWFIxVjc4R0g0NFdQTVJ5?=
 =?utf-8?B?SHFCa3BIR0hFMk8wUTZQSE14alJPRnAwT1lzWEFQYlR6cFhTbklFdU1ZNXU2?=
 =?utf-8?B?ZHExYlBINlk3b0Z3OGd0dFJMaDVJUkdQT1hvcHNSbitWb3BsWlBQbEt2UnNN?=
 =?utf-8?B?VjdhM3JvZEtXZ1A4dWRIbDBkQmFwSk03aEdBYmFCZkpEeGwxMXlsTVlkQkNV?=
 =?utf-8?B?ZDU5VlgvYWUrQW91ZUphV29ibEtEQ2ZINGMwODdyb043LzgwWkNFdCtiSUhM?=
 =?utf-8?B?clNKeHBPd3lmbmQyNmc4ME9DWjVPSVIrUU0wL05SekdCZzQ4N21LNFFDTEpU?=
 =?utf-8?B?Rk1VME1Nc3ZNZk9FUWJpbk5MUzdnN3dGRHFIRmwzZVl3ZHI4WjhFSFNyV1lp?=
 =?utf-8?B?THVQaXNjWXQrZmF3d3YzN1RNVjk2elJ6enJQckNPUGVlYUtLK2JZOTN6YVE2?=
 =?utf-8?B?U0g2bXNYYU54YXdpY214cm5YT2ovbDFkTmxFbVBaQXNqeUl3MWxEb0k1UXIw?=
 =?utf-8?B?K05zWXNkbXdjR0UwR1hRcmM1RnZHNEtmWG5KSmRUMy9Lc2RPb0pPa2trVWRS?=
 =?utf-8?B?bThZWHI5bUlTSkdCWUQwQ25IOFM5VGUxajBRMmlHbzc5bFNKZDJVMDVIQ2ho?=
 =?utf-8?B?V21yZUlBdHVCK1dMaktXVyt0N1ZqL3UzbWVydFlHMm0xcWVwK0M0M0puNldy?=
 =?utf-8?B?WmdmQll6Ym5IQmswZTl1Rittc3RjSGVodVR3N2p3b21IeDhKTW5TWmR4a2Zp?=
 =?utf-8?B?OERGWkxXdksrck9KYWNJbStKdlhmRytlL2NIUTNDVDI0a29CSEZkOERLaWdt?=
 =?utf-8?B?cmRkOTZoRXJBTFk2VzVqNkwweU94dFR3dUgzR2t1UWlhcmxPM2hQN0NUQ0Y3?=
 =?utf-8?B?eVphaGxGcGRXbVIvbjdiaHJnZWVlSzFDSnJKY3F3VjYxMWxEaHVqNmpaN1hU?=
 =?utf-8?B?RTZ4SUd5bzh4U0ZpanZJdThMSVFrTFZicHpnMXNwTUNQQnlraG4ycXI1akg2?=
 =?utf-8?B?bmN3R1VpNDRQaVhYY0taK3UreEwrOGFZMTlySFM0RWROdUo3MHdlMXN6dEFB?=
 =?utf-8?B?ZFhKejFqV21aU0tDdkNjSnR4R3ZZRXduOVl4R2FCVFVUYkYrOE5qWmhWNkpD?=
 =?utf-8?B?dzlLM3JSUzVGMVc3TGpMSndsN0hpa25FMEpmOTBMRXd1ZFJraDRBVE9Va0Mx?=
 =?utf-8?B?ZEtGZ3RMaDB1MGpudWVkWDBXRE9ZRlJrbitBbkVZNDE2QzM1Tm1YV1NYWFV0?=
 =?utf-8?B?RzJ2RGZlcStDa041Um93UTNGbzdvTW5oS1VLOEpDbVhGcnMrWnVublp6dTQz?=
 =?utf-8?Q?NAU5tmIX3j9I5xJAUMTrPlYRNoeqarLO5m5zZe7Iz84W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dd0bbf-93e1-4739-111c-08db7e262080
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:37:22.4626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYG6Gsr3/hHP1K9c22tNqfqRABwLA/zp8AleC8+Cek8WPHw+YmVvENc49B5HW3Qg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.07.23 um 15:33 schrieb Shashank Sharma:
> Hey Christian,
>
> On 06/07/2023 15:28, Christian König wrote:
>> Am 06.07.23 um 14:35 schrieb Shashank Sharma:
>>> The FW expects us to allocate at least one page as context
>>> space to process gang, process, GDS and FW  related work.
>>> This patch creates a joint object for the same, and calculates
>>> GPU space offsets for each of these spaces.
>>>
>>> V1: Addressed review comments on RFC patch:
>>>      Alex: Make this function IP specific
>>>
>>> V2: Addressed review comments from Christian
>>>      - Allocate only one object for total FW space, and calculate
>>>        offsets for each of these objects.
>>>
>>> V3: Integration with doorbell manager
>>>
>>> V4: Review comments:
>>>      - Remove shadow from FW space list from cover letter (Alex)
>>>      - Alignment of macro (Luben)
>>>
>>> V5: Merged patches 5 and 6 into this single patch
>>>      Addressed review comments:
>>>      - Use lower_32_bits instead of mask (Christian)
>>>      - gfx_v11_0 instead of gfx_v11 in function names (Alex)
>>>      - Shadow and GDS objects are now coming from userspace (Christian,
>>>        Alex)
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 62 
>>> +++++++++++++++++++
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  4 ++
>>>   2 files changed, 66 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index e76e1b86b434..7d3b19e08bbb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -61,6 +61,9 @@
>>>   #define regCGTT_WD_CLK_CTRL_BASE_IDX    1
>>>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1    0x4e7e
>>>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX    1
>>> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
>>> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
>>> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
>>>     MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
>>>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
>>> @@ -6488,6 +6491,57 @@ const struct amdgpu_ip_block_version 
>>> gfx_v11_0_ip_block =
>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>   };
>>>   +static void gfx_v11_0_userq_destroy_ctx_space(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>> +                          struct amdgpu_usermode_queue *queue)
>>> +{
>>> +    struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>>> +
>>> +    amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr);
>>> +}
>>> +
>>> +static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr 
>>> *uq_mgr,
>>> +                        struct amdgpu_usermode_queue *queue,
>>> +                        struct drm_amdgpu_userq_mqd_gfx_v11_0 
>>> *mqd_user)
>>> +{
>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>> +    struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>>> +    struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
>>> +    int r, size;
>>> +
>>> +    /*
>>> +     * The FW expects at least one page space allocated for
>>> +     * process ctx, gang ctx and fw ctx each. Create an object
>>> +     * for the same.
>>> +     */
>>> +    size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
>>> +           AMDGPU_USERQ_GANG_CTX_SZ;
>>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>>> +                    AMDGPU_GEM_DOMAIN_GTT,
>>> +                    &ctx->obj,
>>> +                    &ctx->gpu_addr,
>>> +                    &ctx->cpu_ptr);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate ctx space bo for userqueue, 
>>> err:%d\n", r);
>>> +        return r;
>>> +    }
>>
>> I think I asked that before, but shouldn't this stuff be allocated by 
>> userspace now?
>
> Following your comments, we have already moved the Shadow and the GDS 
> object space to user, but the Proc and Gang context is required for 
> MES mapping (which is kernel internal process and usermode doesn't 
> know anything about that), so it needs to be created by Kernel only.

Ok in this case please just add a comment that we shouldn't use 
amdgpu_bo_create_kernel() for that as well.

Thanks,
Christian.

>
> - Shashank
>
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +    queue->proc_ctx_gpu_addr = ctx->gpu_addr;
>>> +    queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + 
>>> AMDGPU_USERQ_PROC_CTX_SZ;
>>> +    queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + 
>>> AMDGPU_USERQ_GANG_CTX_SZ;
>>> +
>>> +    mqd->fw_work_area_base_lo = lower_32_bits(queue->fw_ctx_gpu_addr);
>>> +    mqd->fw_work_area_base_lo = upper_32_bits(queue->fw_ctx_gpu_addr);
>>> +
>>> +    /* Shadow and GDS objects come directly from userspace */
>>> +    mqd->shadow_base_lo = lower_32_bits(mqd_user->shadow_va);
>>> +    mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
>>> +
>>> +    mqd->gds_bkup_base_lo = lower_32_bits(mqd_user->gds_va);
>>> +    mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr 
>>> *uq_mgr,
>>>                         struct drm_amdgpu_userq_in *args_in,
>>>                         struct amdgpu_usermode_queue *queue)
>>> @@ -6540,6 +6594,13 @@ static int gfx_v11_0_userq_mqd_create(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>>           goto free_mqd;
>>>       }
>>>   +    /* Create BO for FW operations */
>>> +    r = gfx_v11_0_userq_create_ctx_space(uq_mgr, queue, &mqd_user);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
>>> +        goto free_mqd;
>>> +    }
>>> +
>>>       return 0;
>>>     free_mqd:
>>> @@ -6552,6 +6613,7 @@ gfx_v11_0_userq_mqd_destroy(struct 
>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
>>>   {
>>>       struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>   +    gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>>>       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index 240f92796f00..a5cdb319193d 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -40,10 +40,14 @@ struct amdgpu_usermode_queue {
>>>       uint64_t        doorbell_handle;
>>>       uint64_t        doorbell_index;
>>>       uint64_t        flags;
>>> +    uint64_t        proc_ctx_gpu_addr;
>>> +    uint64_t        gang_ctx_gpu_addr;
>>> +    uint64_t        fw_ctx_gpu_addr;
>>>       struct amdgpu_mqd_prop    *userq_prop;
>>>       struct amdgpu_userq_mgr *userq_mgr;
>>>       struct amdgpu_vm    *vm;
>>>       struct amdgpu_userq_obj mqd;
>>> +    struct amdgpu_userq_obj fw_obj;
>>>   };
>>>     struct amdgpu_userq_funcs {
>>

