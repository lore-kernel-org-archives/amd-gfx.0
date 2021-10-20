Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12630C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65776115B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 10:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C65776115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B4C16E96B;
	Wed, 20 Oct 2021 10:51:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1109C6E96B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 10:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgMArmD9cCVXTtFCF3sq86LmQLqFp1vWX2ioieEDj375VvndCvQkJkzH5q35nCm/oluglrJ9zNKofW2SneobswpxHW1X0eXr6Jzrn0FcwLBzpPx11UI6OSPXL9XihOSw6zFs9QUyIK/GA8TpDYqRr73WKOhP/f7U6xi0EE/IuJ3jg1k7s5xtFGpLCTgS3mDnt49nk4K5SHK2ymUzyBMDs6X+dsz+f9t1X5RzQcxPpMdBk4AFol8ql7yNU3TsisILSq2KwEYUxvAWVCrhOrfisZdVWcOHxwpZYkOa9J6p00YuGI6JbIAws2h3Q8H3GJB+vdeMkvm0slrXtYwSB6xEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPXcmZF6NrUdmnJTscAM7uzVTnBi3ZCoIXUABncps6c=;
 b=X+NllmZed9d0AGiu3d+NtHecv+WEeM9Xu9OUcpnYWwTAFG9NuEkMbwMiu6v5zkNBnp1SaIJGrG3RB7q7rFdLveouc3hqT2pYIxUifbjkaOjAXKfrWDGi2R2cy5CbWe+62tFn3HZU2DhDg9MJpMIsFs8tlQkcbykyHvQfscYsJZJfcD6z8sDZhrYheyKFsnx/qFCMsyobvTZXSGHWbiSOLX5itsUNLDVvQcPM/dBUintd9tRi20d7xVGCFdsYEd1OOFFnq5NPQZ0b8phvKfDnt4158ACU6P8I1BRRXyPVvO4TECvRnL6xq2ybq8hLquFMIOpBlhUTt9ZROGw5wts53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPXcmZF6NrUdmnJTscAM7uzVTnBi3ZCoIXUABncps6c=;
 b=pE+5PT8Gq8C+a/zgHjuYulGHXsznEyg6BOlDku9g+PkTrJoK7r8z3VCBGk+Qti31Nrdqp9tzARP+qd1LM7JAKXrY+ItJlJbEY3ANfQQFbygwGawgE7XTNFe7CvqgF/CLpdpRfgZJJrQoHidOSWR98iRQY4BUndUbe/JZpkKL9vY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1151.namprd12.prod.outlook.com
 (2603:10b6:300:e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 10:51:19 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4608.018; Wed, 20 Oct
 2021 10:51:19 +0000
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
To: "Das, Nirmoy" <nirmoy.das@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
 <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
 <2715b2e9-4f7e-a356-fbdf-48006985a252@amd.com>
 <4897383c-b931-3bf5-e3c3-04ee9e3467ca@amd.com>
 <968c352a-29db-49c0-0f79-763596785be7@amd.com>
 <039e062b-19b5-bd36-55af-43dd437f60c0@amd.com>
 <cf382da5-a831-241f-4a4e-90c4a2cff2fb@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3cc14a7e-9bb6-4cf9-a1a8-e300b2b68072@amd.com>
Date: Wed, 20 Oct 2021 12:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <cf382da5-a831-241f-4a4e-90c4a2cff2fb@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR10CA0074.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::15) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:6048:8836:7968:5df6]
 (2a02:908:1252:fb60:6048:8836:7968:5df6) by
 AM6PR10CA0074.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:51:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6d729cd-22b1-430d-d50b-08d993b78c8a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB11515C84257590EBFAC53A8D83BE9@MWHPR12MB1151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMBchtIZQrGS476NcN07DxECDmUYg4Be7RRpjNgKNejhfrDc8wWUPMHvGw0XswvPhzP4+TJzQqHVVeGALAB2IL+4xjXvc83o3W8Al7tdoh6YJWfkRLuIimc45Ah2aiWuHOcPhoiCvwv5RyJ1G+GlP2dyNehHQ4ZZny5s4mutwN/D8FJ1LIxwVgesVYxTOPeHA7vwoDX7BkrzBGKH7n2yIE6XkyYxQpXOWJLodgeamMuCyyXsKbCOpZm46Dzto1YX5AzM/37hKx5+aK2Fy5ybNBzgxugJzmqHiFwhcZkmJkTF1Ey+vt+TFH26lP0dtkAejqwp4aLqQDFIDdq7iAjSipdHrf6K71aPWFc69iYLErrD8lEGQtMwyPfZwPX3Zj3i1Nnoex/ZI81szaLN8uG7MrfmB9SSNy25RCcOwxH9EARRTXRdvWEt8oWii3eYfmNEHxjD68oE1pEdRCgA0ndKwy9QcVDNu07Hbgnx6jk4f4Uk77dKDln2h+OVRNyl+NobRHS52O5gqK0UEsfCICkhyJVnT7Zl/v8sen2/ijlT++AEAoYBM7hyBkXJP+uoyyGGFMcfjNx2JefQHNJ1nevGCCA5EXlPOl2hMT2rKib0gVMqmbKNNo/d6qD3FFNArB1F5jLYW6+zmdDJ94w0FrI+0rQH0pHiEslxEWF1Bcb/0srtJwuXMsSki0/PFZED7YOLtdHy1bH1Q30jpFwHxtNsin9q0eMIO6ufrGWnLHHqjJjMsngEjNTaFf3ybSECkR8E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(66476007)(316002)(86362001)(110136005)(8676002)(36756003)(2616005)(53546011)(31696002)(66556008)(66946007)(6666004)(2906002)(38100700002)(5660300002)(31686004)(6486002)(83380400001)(4326008)(508600001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWorVmtzY2dUcmlKT3NsMDVFUVFvK1Y1aXYxVmdYNk8vUzcwYnVOejB4NmVN?=
 =?utf-8?B?YUl3RlhhL1ZIQVR5N2FzcEJ1eHlITVR0VVhIUi9VSFlDWjdVajk4VWVMOVNB?=
 =?utf-8?B?R1FHNzIrZzhHd2lwUGlTNHRCUkI5REVyUS9aUXVmTnBpQ1JacXprcUJlYjdR?=
 =?utf-8?B?VG84elVrYlpzd3ByYmxaRzNFOEFnY0JKTXdpSEN0WS9yMXlIRi9CcDU2MkFn?=
 =?utf-8?B?RlRLQm5henVhY1E1RGZJOWNzbjAzd0ZZZ3REZzdROWdZaTJ2THVOQWR2RTc1?=
 =?utf-8?B?Z0xCRC9LQTdraEsvelpRN0d1ZndsRFRpc0VKcndEVllzWVdMSy9jejB3UzR4?=
 =?utf-8?B?ZkVJUkt5WGxNUUFSRUdJUisreHFZMEQrYWhYSFJiR215MVBoR1NGdER2UGlJ?=
 =?utf-8?B?QzZLME93UGRqaFQyc3pNSVEwdWYvSWY5ZE40WUpQc3hXcWkzbTU2RmlmMEkw?=
 =?utf-8?B?MHVHNkRRVUpjQTF5TDNCV2VyeFpSaW1MdjNrRXJEc1FBTnMrQXRWUFpHN1lQ?=
 =?utf-8?B?YU9mWDVSOHZSejdjOGxqOTV6b1NJMkZlU3FxWGh6S2JEQk5QQUhyL3hDeEM0?=
 =?utf-8?B?ZVF1RFhlQWU0Nzltbkh2QUFnTlY4SkZKcXgvZ2Vkc2xPalR1aW9OMG9wbi9i?=
 =?utf-8?B?aFlVbHk2aU1RRnduSmhOM0R4elpLbDJ0WkJqV3BwRXA3VDRZKy9TQ0ZlRGZH?=
 =?utf-8?B?cHFOUXpYNTRYa1pZd292OEtxMTF4V2M0bHMrNkRIWThGTzFmMTBmNzFUS3lP?=
 =?utf-8?B?ZEVKWE9xRzZlc29xQ1Z0dWV3Y3ErcnN4Yk5sR1RneEduRjdOcUpGY3EwUk9M?=
 =?utf-8?B?elgxNTl5ZjV4Sk9adEo1VUVZRUIzbnB0VlMybnBUUWo4c2tJOURQTEtBYWRK?=
 =?utf-8?B?bUk0U2dyTmVnUHpBUDJjbDk2aW5jNDZ5eGNsbkVOdEo0RXNVUUQ3L09nekdV?=
 =?utf-8?B?RWVGc21HUm9DM1J0ejAwL3BrazBxdElRU1pRNzNkQ3pJVXVXZXBzVEg4bnhC?=
 =?utf-8?B?OU9pTXY0YldVaXlNRWUwWS9aMkpTTDB3RkNsWXAvWGp1UzVJc3R2N1h1d1hB?=
 =?utf-8?B?c3IyQlVpRFZlbXVpSDNZSjZ2dkVJTnhZRkVrdmRQWU9JRmprZUtCa3lDNFhw?=
 =?utf-8?B?M3dKWTFYelFJd3BsVjRTdGJzWmU4eWZkNXV1SlJVdEZDS0o3VGNWK1JVWVFi?=
 =?utf-8?B?N3pXb3N1emNuc25JWXpnQmlRaC80ZE1VSFVKRS9wY01FS2NqV1ZCVXppRE9B?=
 =?utf-8?B?aG9aaHlZVVQvSGFTSFR0VkViMlhNYVZPTUZJekVLUjhhenMwdTNydUtHSlZF?=
 =?utf-8?B?R3NGaFNPQm9vd0dKUXFKS2dZWkF6SVlJcHpkd2dnTElLTDBRd3dtaWI2S1p0?=
 =?utf-8?B?eTY1QXM0dVNGYWNGdUw0WWgxbStYWkVJRC96VDRFRlBPUC9HdzNiaFVZcEN1?=
 =?utf-8?B?SG90aFlWMDVBTlRxMWJKUGhqRXlDQjl1WlVGSEI0SmdybEVuVzNOZmRxbEcx?=
 =?utf-8?B?dnRNblFvb0U2SkRSMy9uM1BqSHArQWVpOE9WUHpBbldYeEl5VDJiWTFibFR3?=
 =?utf-8?B?MkRrTDU1TU1RSlFWRGFLckloSzQ0ZktrK3NaeS9KcGVJNXQ4S0ZESEVpTy9U?=
 =?utf-8?B?cEJXNEJUZm55M3NHRnpJQ0NYTHZsSTNpa2R2cUx2c0hGc3UvNUoyNDA3YkZ3?=
 =?utf-8?B?Sk9SUmZEcW1uWWxLZ1ZYMER5bHBKWFEwQWMrSVZsajBvL1E0dk95QXNHT0x2?=
 =?utf-8?B?citraDVqWkVRS1ZwZHRHM0FsMnJYQjhGajRhNWY3V1NZU2Z4NjRuaEQyRFRU?=
 =?utf-8?B?MHlVQi92MWRuSTB0RllQa0c3QjF2MEpDUlVWbC9yalpwenZzUkQ0YUpSUFc5?=
 =?utf-8?Q?bHTqAybvmNDy3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d729cd-22b1-430d-d50b-08d993b78c8a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:51:19.7032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjKwDBKqcVh6n6GlgaH0gUsHt3oKQjPOWMBvoCTSdp93hF18GmrTj2N20csN4MXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1151
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



Am 20.10.21 um 12:21 schrieb Das, Nirmoy:
>
> On 10/20/2021 12:15 PM, Lazar, Lijo wrote:
>>
>>
>> On 10/20/2021 3:42 PM, Das, Nirmoy wrote:
>>>
>>> On 10/20/2021 12:03 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 10/20/2021 3:23 PM, Das, Nirmoy wrote:
>>>>>
>>>>> On 10/20/2021 11:11 AM, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 10/19/2021 11:44 PM, Nirmoy Das wrote:
>>>>>>> Get rid off pin/unpin of gart BO at resume/suspend and
>>>>>>> instead pin only once and try to recover gart content
>>>>>>> at resume time. This is much more stable in case there
>>>>>>> is OOM situation at 2nd call to amdgpu_device_evict_resources()
>>>>>>> while evicting GART table.
>>>>>>>
>>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 
>>>>>>> ++++++++++++----------
>>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>>>>>>>   6 files changed, 45 insertions(+), 39 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 5807df52031c..f69e613805db 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct 
>>>>>>> drm_device *dev, bool fbcon)
>>>>>>>       amdgpu_fence_driver_hw_fini(adev);
>>>>>>>
>>>>>>>       amdgpu_device_ip_suspend_phase2(adev);
>>>>>>> -    /* This second call to evict device resources is to evict
>>>>>>> -     * the gart page table using the CPU.
>>>>>>> -     */
>>>>>>> -    amdgpu_device_evict_resources(adev);
>>>>>>>
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>>> index d3e4203f6217..97a9f61fa106 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>>> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>    *
>>>>>>>    * @adev: amdgpu_device pointer
>>>>>>>    *
>>>>>>> - * Allocate video memory for GART page table
>>>>>>> + * Allocate and pin video memory for GART page table
>>>>>>>    * (pcie r4xx, r5xx+).  These asics require the
>>>>>>>    * gart table to be in video memory.
>>>>>>>    * Returns 0 for success, error for failure.
>>>>>>>    */
>>>>>>>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>>>>>>>   {
>>>>>>> +    struct amdgpu_bo_param bp;
>>>>>>>       int r;
>>>>>>>
>>>>>>> -    if (adev->gart.bo == NULL) {
>>>>>>> -        struct amdgpu_bo_param bp;
>>>>>>> -
>>>>>>> -        memset(&bp, 0, sizeof(bp));
>>>>>>> -        bp.size = adev->gart.table_size;
>>>>>>> -        bp.byte_align = PAGE_SIZE;
>>>>>>> -        bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>>>> -        bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>>>> -            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>>>> -        bp.type = ttm_bo_type_kernel;
>>>>>>> -        bp.resv = NULL;
>>>>>>> -        bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>>>> -
>>>>>>> -        r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>>>>> -        if (r) {
>>>>>>> -            return r;
>>>>>>> -        }
>>>>>>> -    }
>>>>>>> +    if (adev->gart.bo != NULL)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    memset(&bp, 0, sizeof(bp));
>>>>>>> +    bp.size = adev->gart.table_size;
>>>>>>> +    bp.byte_align = PAGE_SIZE;
>>>>>>> +    bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>>>> +    bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>>>> +        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>>>> +    bp.type = ttm_bo_type_kernel;
>>>>>>> +    bp.resv = NULL;
>>>>>>> +    bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>>>> +
>>>>>>> +    r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>>>>> +    if (r)
>>>>>>> +        return r;
>>>>>>> +
>>>>>>> +    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>> +    if (r)
>>>>>>> +        return r;
>>>>>>> +
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>> index 3ec5ff5a6dbe..75d584e1b0e9 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           return -EINVAL;
>>>>>>>       }
>>>>>>>
>>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>> -    if (r)
>>>>>>> -        return r;
>>>>>>> +    if (adev->in_suspend) {
>>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>>
>>>>>> When the existing usage of this function is checked, this is 
>>>>>> called during reset recovery after ip resume phase1. Can't the 
>>>>>> same thing be done in ip_resume() to place this after phase1 
>>>>>> resume instead of repeating in every IP version?
>>>>>
>>>>>
>>>>> Placing amdgpu_gtt_mgr_recover() after phase1 generally works but 
>>>>> gmc_v10_0_gart_enable() seems to be correct place  to do this
>>>>>
>>>>> gart specific work.
>>>>>
>>>>
>>>> I see. In that case probably the patch needs to change other call 
>>>> places also as this step is already taken care in gart enable.
>>>
>>>
>>> Do you mean amdgpu_do_asic_reset() ?
>>>
>>
>> Yes, and saw it called in one more place related to sriov reset 
>> (didn't track the sriov reset path though).
>
>
> True, hmm looks like this patch going to need multiple tested-by tags 
> for gfx6,7 and sriov. I only have gfx8,9,10.

You also need to test this on APUs as well, when it works won Raven/gfx9 
I'm pretty sure it will work on other generations as well (except for 
typos of course).

Christian.

>
>
> Regards,
>
> Nirmoy
>
>
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Nirmoy
>>>
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Nirmoy
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> +        if (r)
>>>>>>> +            return r;
>>>>>>> +    }
>>>>>>>
>>>>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>>>       if (r)
>>>>>>> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>   {
>>>>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>>   }
>>>>>>>
>>>>>>>   static int gmc_v10_0_hw_fini(void *handle)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>>> index 0a50fdaced7e..02e90d9443c1 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>>> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>>           return -EINVAL;
>>>>>>>       }
>>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>> -    if (r)
>>>>>>> -        return r;
>>>>>>> +
>>>>>>> +    if (adev->in_suspend) {
>>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>>> +        if (r)
>>>>>>> +            return r;
>>>>>>> +    }
>>>>>>>
>>>>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>>
>>>>>>> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>>   }
>>>>>>>
>>>>>>>   /**
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>>> index 492ebed2915b..dc2577e37688 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>>> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>>           return -EINVAL;
>>>>>>>       }
>>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>> -    if (r)
>>>>>>> -        return r;
>>>>>>> +
>>>>>>> +    if (adev->in_suspend) {
>>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>>> +        if (r)
>>>>>>> +            return r;
>>>>>>> +    }
>>>>>>>
>>>>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>>
>>>>>>> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>>   }
>>>>>>>
>>>>>>>   /**
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>>> index cb82404df534..732d91dbf449 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>>> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           return -EINVAL;
>>>>>>>       }
>>>>>>>
>>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>> -    if (r)
>>>>>>> -        return r;
>>>>>>> +    if (adev->in_suspend) {
>>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>>> +        if (r)
>>>>>>> +            return r;
>>>>>>> +    }
>>>>>>>
>>>>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>>>       if (r)
>>>>>>> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>   {
>>>>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>>   }
>>>>>>>
>>>>>>>   static int gmc_v9_0_hw_fini(void *handle)
>>>>>>> -- 
>>>>>>> 2.32.0
>>>>>>>

