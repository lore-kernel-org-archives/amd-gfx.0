Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C946FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 16:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECF961175
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 16:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8ECF961175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B616E188;
	Tue, 19 Oct 2021 16:04:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3AB6E188
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 16:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH63k0SeAp46LhGdrAQMDosHdC93GLjsP7Igt0ifYVPPUfeXNyThtVuStra7enYntqBznsfX+osRX5VdGixVYGqsWCd1g03LvjL5myyaSf4TSJwga4tEb6j5r9lBSEOqKqUJQKm7F7rC6UU+7I7YbPZq6YIWhO5AoV6vTcFj/WfodH3y3P4FHJSJ6yftp9qqLpOWgoTkoApD4SvaLwNz7Al9/D7PQ8pTct8/8t4O6tRvYkik5YKqMtCk1ftwt2FD6VU/kDvXDjsqkRIfvWLMg4iLbW/70XooDGhTmrQ1a5jbt5H5mFy9orfmFnO3YUMmlygV8ZvNIqFOh7vILwK0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IegmR5bFQ0eerS4CmVbi0vwbHOUQFF+uh6mHJBvIA3k=;
 b=W7QA7qnrJxf9lAcGYMLa9OQCarshTMC6Epwe7h85R51W+8qnETr35eSMCYkDaGqX0ZU0SQG8NgW6r8ol8GqhMw4IbFmBOUc81V3ISr/zEzicmxG231XW9BRGwP+nVn94YlEqpD6kbpB2BODDJ6OAzHXoFfs2S2PoCKYL3hY+UY3hmiCLRTPLube/U3beCvC+Nbd114WqEfECVulYzBS+/GmrcmBmfWIgq5OjzazmL3MLfcYttGy4LJDXbeBCp/HBcWWs7m2PxmLFpjvYR5eIVvl2Kn2tu/wOYqPQYBuKcXJs06PNrlITysaMokDriz8BvMEE3zzMLmI0HzOmdI2m5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IegmR5bFQ0eerS4CmVbi0vwbHOUQFF+uh6mHJBvIA3k=;
 b=qK83/mJvTEblsY2Iuf+pO9dF9RyVOtennsDYO4gJREEVo0F/oggVeuyyOvht+kfKIbLxi/uqRwxr3i0zxw2U9YrQtftrb3ast9HXCncJbKfEeJUVaL/63DE9QwKDUj+0xzQXRcictdsKQxqUU9AMRi+2Dmg+bb7AN2fQOA+Vvpc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Tue, 19 Oct
 2021 16:04:04 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 16:04:04 +0000
Message-ID: <71a9d5e9-aa1e-af55-ff8b-2063b95e19b8@amd.com>
Date: Tue, 19 Oct 2021 18:03:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/1] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20211019132200.10352-1-nirmoy.das@amd.com>
 <c99524ce-1720-6a0f-ba6a-525c493c2a4b@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <c99524ce-1720-6a0f-ba6a-525c493c2a4b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0602CA0023.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::33) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [172.31.54.68] (165.204.72.6) by
 AM5PR0602CA0023.eurprd06.prod.outlook.com (2603:10a6:203:a3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 16:04:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb24ec5d-1c86-49ac-af7c-08d9931a12a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB5518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB551862ADCFE2949D9BC1C1B48BBD9@DM6PR12MB5518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMVoxG5UhxDFHfWix6O+SPNlBR2DnLxa6YDchXjfCpATMFnksxog0R6xfApy47pAZ92uTaGmbCYR+YqfYHaE/pfJkfIv7e9a9Yibbp5ytPAX9JYDVjIsC9JNTyiQ1p4ZcCrZZmZyBPwt3Tfh6NOOE14hW0EwhmiKLa3MR+DK7jL8skIN56B6a6t9/gNB3p7KWKBS1AT3YhuNPoAuI5zTOkavKmvS3MB9rgXr3Nwcpt4x/hOEkLy9MTgVksD2gMgoxPxSUBcJQnA+b/zY/3mLJHLKPEzKIQGMNiBaongGejva3/rIghT8eRwHqdmjQefk1KzFbddBlogXch2HLoroBGbtdhZCu9Jf29xAbodU9qDtulIiO5tq/cYZLNZsAtV4z6bd3Gqf6ka2klcuMN7ZfEkA14qCgAQ1vqVAjgoLZB7yOqScnjkNlET3cdJH+0LZKzFmm2vKVqE4CupsPAq+2XzTp69Ny/1sp5eajkisnrKESbJzBPJ7t+PHiVZBccrbdoYQyPco1gWlkJb+DyD8jDEgsMjsmMKQ9rRSrtoCiUf3D1XMOFMLyGquOTrpaBhCDZBmQQipYfEZT1wJingoo/eubIrsVwWbIylSO6PnmlwpJPq6ogWRrRauwdBsRyNs6pB4ASlmj9QmHFSxvmlcb1ZsSMriOqa1Z2t/GpLgSvy6BA1wgqPr8sxoLWiN6FsjOxpZbAkXoU5l8ldt/ssltcaEwTj9QF975npsFX/P6bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(186003)(66556008)(66476007)(8936002)(4326008)(956004)(8676002)(31686004)(6666004)(86362001)(2906002)(36756003)(38100700002)(66574015)(508600001)(66946007)(6486002)(5660300002)(83380400001)(2616005)(316002)(16576012)(53546011)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhBd3NyZnlXd2YrR1RpVVhTbmRIZ3piT3hvQWlwZDBMYjFQTWViWlFTYng3?=
 =?utf-8?B?N0NISkhscXhzaXQzc0F5c1NoN2k4TjhFYU9KMUlPOWk0bzd4Zk1XUUdadWVn?=
 =?utf-8?B?Yk1nZStiZjVCdElKMER0RTFUdmk0RFJsNTBWZ3djY2ZqOWpzREY0MW9sUlZ1?=
 =?utf-8?B?cmZ6aVRaSGlOYTFqYitpb2tQZGx1b0lCVFF6ZmhrU05ORTZ3OVJ2bHhvNURG?=
 =?utf-8?B?aU1kTXR1SGdjUDdMcFdwb1pPaTdaUE1ja1hmdWkvUDdLZVhRM3A5b3R3blN0?=
 =?utf-8?B?cXNCNUQ5dW9yeXVZTTcxUHFVVFRsMVFYT1V5TG9rZjZOK1dJUFE2MTJjeVFi?=
 =?utf-8?B?djR4TjZ4VStDYlhHcmUydnRJbWJ4ZHE0T1N0Mi82QmZLMUtod0NOS0FUVVRi?=
 =?utf-8?B?YVU0M1lBeEFxbG0zQldxZ3pvWGQzWFhIZVNha0d6VEpXTUhPclF5dEpGUEdO?=
 =?utf-8?B?d012TUo0SHRtUFNOb1pmSng4UUM0czYxdW1LaXNGbGRESkU3aWhkRndmZlV1?=
 =?utf-8?B?Zmt2UTZ5VFMyMGN0TEpsdU1xVi9RQ0I4bGdQdmk5cFljaGs3aW9NMkNDcThQ?=
 =?utf-8?B?QkZkOFdpRmZzMjkrWnpQK09YeWdzeC9zVWVNbGdtenF4YlJCUXlHSXM2L0ND?=
 =?utf-8?B?YmZsL1czU2M4RVdFZ1FsU0s2eGJNMEVsbjN1eENCVEs0RyswWUdOV2xHek5O?=
 =?utf-8?B?UnpoY3JFTTNLaGhFV3BoSVJEQUswNndpZnZSdjcrNGtZbVVOakxmS0xLaC9H?=
 =?utf-8?B?VklwcE4vQWcvV2Y1UTd0ZmI2VFJucnUrKzdmTi9WWnl3Uzg4ZUllTFdOSHhB?=
 =?utf-8?B?MVBUZC83TmVIa3VVOHhSTksxYzBoZHVuYXMzd2g1RU85eldnMkNaVTRPOEVa?=
 =?utf-8?B?T1gxUXU2clZnYzVTOUVsOUlFb2tWQVVrMXBvZnE3TGUxUk9uYThJTE42NkNH?=
 =?utf-8?B?TktudUwwQ3VrVG1PWWZVVTl4UlBPMDNQeitJL3lTM0dpdkJNbmpFVGtLTldl?=
 =?utf-8?B?Y3RNaGdESEFpUTdNbFc5WFJLaTBFUDBBMHUxSGM1blp4SlJPZjZJK3dKSkJF?=
 =?utf-8?B?UEI2TitEMXVGSjNLL3ptV2VmTllaL2xFMTVPSnJrdHg2NEhhK2prWFNaVFVr?=
 =?utf-8?B?RWd0RDZrTGUzeDgwbnUzaGJ2aUhoTU8wNENlSVFDWndIanM0eDNhLzBUMjhY?=
 =?utf-8?B?V0h0ZHpVMlhianFYTUxoeDF4R0I3R0x0U2tvWW9CaVNSQ0hMdHBLT09QMWh0?=
 =?utf-8?B?Q2cxWWZxVFE2c0YrZUdRK2xJNERVSWYwSXErUHVJR3JWSGgwSno4UDZoOHJV?=
 =?utf-8?B?ZFYxUDgrUzZkOWU5cEpBVzlXUStOOGdIQjlFeFdEeTI3OGU1cUpwRlBweFRE?=
 =?utf-8?B?aG80RUtDanVpcjNGeHFZY0JnRDdTaVVrYktXdG1HekRTaStvcndhUlBOVGFo?=
 =?utf-8?B?Y09zKzdJbmRWTlkyZmV3Z3NpNjVhY2ROTmJOMytYLzhaWDU5eE5GZk9SYVZC?=
 =?utf-8?B?bUw3dStrTVVjRDl6K2NYaXdXMHZGVXdJZ3MvZFo0UlpjdTRkU2l3d2ZURXMr?=
 =?utf-8?B?b2ErOUFnTHhmYjhxZHNxdkprVVc1MDg3dVcycXV1eEY3Zit2SHZ2bVpXNzFs?=
 =?utf-8?B?MW9ZYURSVGlQOTJXR2tadWxwSnlmeFVBaUV4eUZwYXBRZ1RtK0RpYVEzNWNU?=
 =?utf-8?B?K2VhbnRQRjlNVjkwSHpmTHpSd0t6QjFKNHFudEVMaDRUL3o5MXphQVhRUk5I?=
 =?utf-8?Q?8IgnmGR90gaW0P3+6wvFAHrxUs24yAo34gfdQ5Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb24ec5d-1c86-49ac-af7c-08d9931a12a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 16:04:04.2984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rWPpyEjbOBRGmfWZXjvIWmWPtBg5bQPeUnoNzfFKZhcEJYak6eIANWB919wO/3CCRCaWDsiwkeIfCI8d0jgCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
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


On 10/19/2021 5:43 PM, Christian König wrote:
> Am 19.10.21 um 15:22 schrieb Nirmoy Das:
>> Get rid off pin/unpin and evict and swap back gart
>> page table which should make things less likely to break.
>>
>> Also remove 2nd call to amdgpu_device_evict_resources()
>> as we don't need it.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 -----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 16 ++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 17 +++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++++++----
>>   4 files changed, 37 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 41ce86244144..22ff229ab981 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3941,11 +3941,6 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool fbcon)
>>       amdgpu_fence_driver_hw_fini(adev);
>>         amdgpu_device_ip_suspend_phase2(adev);
>> -    /* This second call to evict device resources is to evict
>> -     * the gart page table using the CPU.
>> -     */
>> -    amdgpu_device_evict_resources(adev);
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 3ec5ff5a6dbe..18e3f3c5aae6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -992,9 +992,16 @@ static int gmc_v10_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           return -EINVAL;
>>       }
>>   -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +    if (!adev->in_suspend) {
>> +        r = amdgpu_gart_table_vram_pin(adev);
>> +        if (r)
>> +            return r;
>
> I think you can move the functionality of pinning into 
> amdgpu_gart_table_vram_alloc().
>
>> +    } else {
>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>> +                                TTM_PL_TT));
>> +        if (r)
>> +            return r;
>> +    }
>
> And add a wrapper around this call here. Something like 
> amdgpu_gart_recover() or similar.


Thanks Christian, I will resend with your suggested changes.

>
> Regards,
> Christian.
>
>>         r = adev->gfxhub.funcs->gart_enable(adev);
>>       if (r)
>> @@ -1062,7 +1069,8 @@ static void gmc_v10_0_gart_disable(struct 
>> amdgpu_device *adev)
>>   {
>>       adev->gfxhub.funcs->gart_disable(adev);
>>       adev->mmhub.funcs->gart_disable(adev);
>> -    amdgpu_gart_table_vram_unpin(adev);
>> +    if (!adev->in_suspend)
>> +        amdgpu_gart_table_vram_unpin(adev);
>>   }
>>     static int gmc_v10_0_hw_fini(void *handle)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 492ebed2915b..0ef50ad3d7d5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -837,9 +837,17 @@ static int gmc_v8_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>           return -EINVAL;
>>       }
>> -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +
>> +    if (!adev->in_suspend) {
>> +        r = amdgpu_gart_table_vram_pin(adev);
>> +        if (r)
>> +            return r;
>> +    } else {
>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>> +                                TTM_PL_TT));
>> +        if (r)
>> +            return r;
>> +    }
>>         table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>   @@ -992,7 +1000,8 @@ static void gmc_v8_0_gart_disable(struct 
>> amdgpu_device *adev)
>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>       WREG32(mmVM_L2_CNTL, tmp);
>>       WREG32(mmVM_L2_CNTL2, 0);
>> -    amdgpu_gart_table_vram_unpin(adev);
>> +    if (!adev->in_suspend)
>> +        amdgpu_gart_table_vram_unpin(adev);
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index cb82404df534..1bbcefd53974 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1714,9 +1714,16 @@ static int gmc_v9_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           return -EINVAL;
>>       }
>>   -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +    if (!adev->in_suspend) {
>> +        r = amdgpu_gart_table_vram_pin(adev);
>> +        if (r)
>> +            return r;
>> +    } else {
>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>> +                                TTM_PL_TT));
>> +        if (r)
>> +            return r;
>> +    }
>>         r = adev->gfxhub.funcs->gart_enable(adev);
>>       if (r)
>> @@ -1793,7 +1800,8 @@ static void gmc_v9_0_gart_disable(struct 
>> amdgpu_device *adev)
>>   {
>>       adev->gfxhub.funcs->gart_disable(adev);
>>       adev->mmhub.funcs->gart_disable(adev);
>> -    amdgpu_gart_table_vram_unpin(adev);
>> +    if (!adev->in_suspend)
>> +        amdgpu_gart_table_vram_unpin(adev);
>>   }
>>     static int gmc_v9_0_hw_fini(void *handle)
>
