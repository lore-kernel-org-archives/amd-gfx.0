Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7FEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 11:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835AB613D5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 11:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 835AB613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4F86E283;
	Wed, 20 Oct 2021 11:10:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF0F6E283
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 11:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJWFqhZHb83X/3/vufPw2qP8oJRA1GuRLy3zDLwWrgp5C5SYdLnTri4zoha6FTSgN/e5h28mYcp/S+4+gwgQ2yZ8C4u4zL9S1GjE9v42Aw06boZzSAF+O92eBpM+7AiXYeWhaPe/Y4XqugXPlUZPmBMW1GQLNDjKWgxd2kllCFo61k4TQieCdlq1tCmYukZVHkqL4xUGSAr2py0WMLLhf3/PcT1jmwuD22vgDrkZ1kgNEMjWEGY1HmHg3wWtvqcNR1Ql8y+lBjzH84hEDOioxXU0j7XAAqKWkv6mQ2sn2yA1GipAhzU4ocFOf45Ueb7kg19ifYtuJcpum9jI8KizVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msMFh1UBG9G2OKUsBc54w5mhaiNv5pICWWQmrmt/aDE=;
 b=fY0Z7NHTLtU4jAiARjPDsSxPccT/O4Pdim+SnUf7VS9+1EExV3srvsKL2AWETo5sFZmokZKCJ2ixFe1GFNJBJ7hduTsA0cFFY/XHqVtaYwKDPRY+2q4YyCPg8Ru5RZWgWzqlRaSzqnxUc5GOyhnAbfWrchGLzzGGwpK3iCOpnf7ZbChxUM1EIO1xCRtB3VRntazfHE1+mThlX5Q7zxP6iJqJSoaW6vIWTexpEHoMMvXPagXZ8iQZx+v90DUXhCovHoWYizwOg042OTs5YV9IdBiP7zLPIY08xHbDyjxRChtRvJyBo2AFRrVJ9Gf6TTu9w9zgUDoJa/9phO9bfD1whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msMFh1UBG9G2OKUsBc54w5mhaiNv5pICWWQmrmt/aDE=;
 b=XcG5fc5XqtgC2bXgsWmjvLi3A0MCCNDpT+oWoCta/bnZbDQGEnwRZDb2OLRBhsmWeGb1R01xFOs+aGhjVgcU2XDwIuV7smUigDxdVJ2e50bNix007HImxyXPsQORHM2H2HHcJv7+Trnodhz1I5rpyEvrgnSjII9nDtmamjkuavw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 11:10:44 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 11:10:44 +0000
Message-ID: <4a46999b-12f2-a1fc-10f6-68545c540f7e@amd.com>
Date: Wed, 20 Oct 2021 13:10:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
 <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
 <2715b2e9-4f7e-a356-fbdf-48006985a252@amd.com>
 <4897383c-b931-3bf5-e3c3-04ee9e3467ca@amd.com>
 <968c352a-29db-49c0-0f79-763596785be7@amd.com>
 <039e062b-19b5-bd36-55af-43dd437f60c0@amd.com>
 <cf382da5-a831-241f-4a4e-90c4a2cff2fb@amd.com>
 <3cc14a7e-9bb6-4cf9-a1a8-e300b2b68072@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <3cc14a7e-9bb6-4cf9-a1a8-e300b2b68072@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:203:69::30) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (217.86.117.49) by
 AM5PR0202CA0020.eurprd02.prod.outlook.com (2603:10a6:203:69::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 11:10:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62498628-fc17-4d72-04a1-08d993ba4288
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5311517CC9C67F3295925C798BBE9@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmcJrWko1+VnyGmqiiMRUwpYHaJGroga/zg9KSNEIzzKs8I6jhJSOS+dPTat+i9+mSMp9Ro5OiVc2CxtQcV/gFr6atLky14UPMMn3VgYTvuI/6WBzOUxZ/AUhil68kidsYUKBKVTACci2FdFnHVId9tjBSNH1P+pwhq1ZatN1pHrKmTjpfs9NTBBDio6KJwZZdLkkneUltPtu417aX+jyQcZmvEukE1JAIwVAmUF/1PwR5N4xEV3Pg5q7iKUlZb0tmmjxPxsK9sRZf96Tog4kT6JMea60I5cMMCLZvJ3IM6La9qcG+AajRE/47xzpo23VAf6E64yGkmd4MCvBo64k8iF+b43qSX5DJNbbugLIBn7nDW8QMpQOIeYjUGe8eAi07jptfoI1UUExIdNw2Sa1Vp/PsO+KzuMlbuaLiwT/wWQGHxCzxeVwDwfhxNRMXccR9xqKBiuEtt30VSrNLO6WmRAjjbzA1KFLH3coX6u4CKCmeaA2u//HiP36pyCl6bVdaD0S6aNoO5dqscVccKkwavslyeEUVn/WjgrnO6ooiwpyKjQrxoP4EB0HFOuXFLoVEkk0+VFcZ8wSB/KEkjC8wIodCrqQYXFxFvrU13MQ44ryQiJop03WgX2B9C6PMPK94S9gHT9B9Ov9Z1pAhqKAr2ACC63vjbzeYgk2xU4Php5ddTSYe62zLIaGodbHJPs9iTIl6tTQ639PotGEAOkTMNokzIixAaQqu6izJ56rqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(16576012)(31686004)(66574015)(316002)(26005)(5660300002)(186003)(508600001)(8936002)(31696002)(38100700002)(110136005)(6666004)(8676002)(36756003)(83380400001)(66946007)(66556008)(53546011)(6486002)(66476007)(4326008)(2906002)(956004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3VleE14YldTVk5KZ25aUW5kQTJORkZWM0ljWEVXM1ZLc1JkNnZuWWRUTGpa?=
 =?utf-8?B?aVRIeWRPdjlvZ2s0ajVuaHNsYTNGbEVoR3QxeFp0ZmhscFQ5WFk5U0tYUW1p?=
 =?utf-8?B?c09nVUtacGxCZTlKc1IydGhXRXM3WXdpVFZiVlNraURmaEc4NGJ2aXdYRk1K?=
 =?utf-8?B?MU8vRVBaVjh3MytuTGJ6RzlXTWtIWmhPWWwzU1JiVFFjWTMxS010cGJOT0VY?=
 =?utf-8?B?VVEzL014dWhrekEzYXJwQ2J6bzg4MWFRVmdxUHVLVkZ4TEFrV2tvdkJrSmNK?=
 =?utf-8?B?U2pTOXdtUVY4NHVZZTRLenJaWUhQRGVaeFZ5ektvWDArcURacGxQR0l1OEZI?=
 =?utf-8?B?djZkNzcvZ0VIMVBGUzZFWEdZb2tHa0NIMEVralI4ZktTK1Z5VDdOVVdVS2Zo?=
 =?utf-8?B?MG1IRmFYWjBJMCtyWEMvak5iUTBqOGtHbHpzUXhDb2lnamNJTkpmWStqWkpw?=
 =?utf-8?B?YXlHNDA1UzJRNTVvTWt5bjRxQXVya0FNSzFIWHVnbVhEb3N0MGFzUGw2US9U?=
 =?utf-8?B?VmpNU0xBc1QwSEtWZGVnRDVNbi92ZnVXTGUxNkpDTUI3VFR3ZnlPaDFMWFN0?=
 =?utf-8?B?SlFQZlFJZ2VYYXZRMmQzQzNEYTF3RllvK0pleVZ1Z0xoUk95dnZ3T0V2UnFQ?=
 =?utf-8?B?MW9rL25mSlhLNCtRMnkvTnMyMzhxa3FMTDdKWmZjellIRDh0QWZIbFdaQWpF?=
 =?utf-8?B?SXAzZVhLVldSVGFZMEVGZnN1U004aVFzeUF6bVo1dHUyeU9ycllibC9tSXR1?=
 =?utf-8?B?QmRqcTl2MksrWGcrSnp1OWI0Qk9BNm84ckV5bVdybGN4ZnVKTFp5K0hURmZY?=
 =?utf-8?B?d3AwcHI3WmhzempIR055Nmh6VUJqNDRYNHluSkMycHZpbVpMNUUvYy8yMDZw?=
 =?utf-8?B?TDc1MFNNcWhubEZ1cmRZSUcwb1dEdmZRZDdvZEZVQi9mMXBjVGhlTVppLytq?=
 =?utf-8?B?eUpHVDdRY0svSktDQSs2UzQ1aElTNTUwdGxvcU9iUnV4bThQRXRmL3VPeTE0?=
 =?utf-8?B?MHk3Q3V2TXVqc0U4czVsUkJYQlI4bUVoOS9OTElzRllZVnJaNlVTZEduekFJ?=
 =?utf-8?B?d0gzbDRIK0pMZVc4a3RuZU5QYjhscDg1NVEraS95ZnNEeEE2L3pmZHc0MEYy?=
 =?utf-8?B?TDVXdGR1WFArNjFjQXFvaUZicmZyNmJHdmYvaXQ3L2hGbXpvQ3NvalZuRWQ4?=
 =?utf-8?B?V3I3MW9wNUFKMXFZV1JlMU9iL0tha0pFMFVMeDRRcmdvM200RjBSTXBhSWIv?=
 =?utf-8?B?Q3pMMlpIeWxaSlpqL3RaZ296ZDdGQTE5bHJDT2tnWmR1S3g3akEweFFYQ1NB?=
 =?utf-8?B?b1dMcWpFdFRrMGNaWHhITk1aSWJueExBaGdTZysxNGYrZGs2d3huYlRWYlFN?=
 =?utf-8?B?MHlDVGd0RkRXV01rUDZiN09sKzZXS0FHZ0RLTTRCbmxUS2ErNWZQRlpLOENY?=
 =?utf-8?B?LzNKTWVmN0V1aFF6V0RZQ3NmNlUvVURBd1l1UW5RTitNdTNwVDhXOWxtcmho?=
 =?utf-8?B?c1d6ZDlKNWZxVzZmZEZLeU1PVHpzb3RQR0xiQmlQK1dkSHJacEF4dGlxVlRl?=
 =?utf-8?B?dEZwWXFVVW95Q1o5akJ0R1p1M2RNS09vVkJwbG45OVpFTjd3YVRVRzJkVGNZ?=
 =?utf-8?B?ZzZGcXdVeXFocW1GNnJZRFNvbHBEdFNtbERGNTRvZEdCUVlwcWd2Wmc3K0M4?=
 =?utf-8?B?VkxyK3lhTG93UHdtS2htbjNZWkxENE9PbmVlSlV3a1pFV05FZXBQaGZ2OVlt?=
 =?utf-8?Q?ZGi5/THgXQfCamiGEheD64/ta9VZoDH4XbpBPn1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62498628-fc17-4d72-04a1-08d993ba4288
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 11:10:44.1455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEBPVInQvkaUfnBn/fbc9R3yB+71uu0UohobD78DDcc/vSRrlZg1lhjrjqWKiNaj94Wm5GeHYVLmDnEzkigM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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


On 10/20/2021 12:51 PM, Christian König wrote:
>
>
> Am 20.10.21 um 12:21 schrieb Das, Nirmoy:
>>
>> On 10/20/2021 12:15 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 10/20/2021 3:42 PM, Das, Nirmoy wrote:
>>>>
>>>> On 10/20/2021 12:03 PM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 10/20/2021 3:23 PM, Das, Nirmoy wrote:
>>>>>>
>>>>>> On 10/20/2021 11:11 AM, Lazar, Lijo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/19/2021 11:44 PM, Nirmoy Das wrote:
>>>>>>>> Get rid off pin/unpin of gart BO at resume/suspend and
>>>>>>>> instead pin only once and try to recover gart content
>>>>>>>> at resume time. This is much more stable in case there
>>>>>>>> is OOM situation at 2nd call to amdgpu_device_evict_resources()
>>>>>>>> while evicting GART table.
>>>>>>>>
>>>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 
>>>>>>>> ++++++++++++----------
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>>>>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>>>>>>>>   6 files changed, 45 insertions(+), 39 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 5807df52031c..f69e613805db 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct 
>>>>>>>> drm_device *dev, bool fbcon)
>>>>>>>>       amdgpu_fence_driver_hw_fini(adev);
>>>>>>>>
>>>>>>>>       amdgpu_device_ip_suspend_phase2(adev);
>>>>>>>> -    /* This second call to evict device resources is to evict
>>>>>>>> -     * the gart page table using the CPU.
>>>>>>>> -     */
>>>>>>>> -    amdgpu_device_evict_resources(adev);
>>>>>>>>
>>>>>>>>       return 0;
>>>>>>>>   }
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>>>> index d3e4203f6217..97a9f61fa106 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>>>>> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>    *
>>>>>>>>    * @adev: amdgpu_device pointer
>>>>>>>>    *
>>>>>>>> - * Allocate video memory for GART page table
>>>>>>>> + * Allocate and pin video memory for GART page table
>>>>>>>>    * (pcie r4xx, r5xx+).  These asics require the
>>>>>>>>    * gart table to be in video memory.
>>>>>>>>    * Returns 0 for success, error for failure.
>>>>>>>>    */
>>>>>>>>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>>>>>>>>   {
>>>>>>>> +    struct amdgpu_bo_param bp;
>>>>>>>>       int r;
>>>>>>>>
>>>>>>>> -    if (adev->gart.bo == NULL) {
>>>>>>>> -        struct amdgpu_bo_param bp;
>>>>>>>> -
>>>>>>>> -        memset(&bp, 0, sizeof(bp));
>>>>>>>> -        bp.size = adev->gart.table_size;
>>>>>>>> -        bp.byte_align = PAGE_SIZE;
>>>>>>>> -        bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>>>>> -        bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>>>>> -            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>>>>> -        bp.type = ttm_bo_type_kernel;
>>>>>>>> -        bp.resv = NULL;
>>>>>>>> -        bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>>>>> -
>>>>>>>> -        r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>>>>>> -        if (r) {
>>>>>>>> -            return r;
>>>>>>>> -        }
>>>>>>>> -    }
>>>>>>>> +    if (adev->gart.bo != NULL)
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    memset(&bp, 0, sizeof(bp));
>>>>>>>> +    bp.size = adev->gart.table_size;
>>>>>>>> +    bp.byte_align = PAGE_SIZE;
>>>>>>>> +    bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>>>>> +    bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>>>>> +        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>>>>>> +    bp.type = ttm_bo_type_kernel;
>>>>>>>> +    bp.resv = NULL;
>>>>>>>> +    bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>>>>>> +
>>>>>>>> +    r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>>>>>>>> +    if (r)
>>>>>>>> +        return r;
>>>>>>>> +
>>>>>>>> +    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>>> +    if (r)
>>>>>>>> +        return r;
>>>>>>>> +
>>>>>>>>       return 0;
>>>>>>>>   }
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>>> index 3ec5ff5a6dbe..75d584e1b0e9 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>>>> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>           return -EINVAL;
>>>>>>>>       }
>>>>>>>>
>>>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>>> -    if (r)
>>>>>>>> -        return r;
>>>>>>>> +    if (adev->in_suspend) {
>>>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>>>
>>>>>>> When the existing usage of this function is checked, this is 
>>>>>>> called during reset recovery after ip resume phase1. Can't the 
>>>>>>> same thing be done in ip_resume() to place this after phase1 
>>>>>>> resume instead of repeating in every IP version?
>>>>>>
>>>>>>
>>>>>> Placing amdgpu_gtt_mgr_recover() after phase1 generally works but 
>>>>>> gmc_v10_0_gart_enable() seems to be correct place  to do this
>>>>>>
>>>>>> gart specific work.
>>>>>>
>>>>>
>>>>> I see. In that case probably the patch needs to change other call 
>>>>> places also as this step is already taken care in gart enable.
>>>>
>>>>
>>>> Do you mean amdgpu_do_asic_reset() ?
>>>>
>>>
>>> Yes, and saw it called in one more place related to sriov reset 
>>> (didn't track the sriov reset path though).
>>
>>
>> True, hmm looks like this patch going to need multiple tested-by tags 
>> for gfx6,7 and sriov. I only have gfx8,9,10.
>
> You also need to test this on APUs as well, when it works won 
> Raven/gfx9 I'm pretty sure it will work on other generations as well 
> (except for typos of course).


I have a raven APU. I will test on that as well.


Regards,

Nirmoy

>
> Christian.
>
>>
>>
>> Regards,
>>
>> Nirmoy
>>
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>
>>>> Nirmoy
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Nirmoy
>>>>>>
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>> +        if (r)
>>>>>>>> +            return r;
>>>>>>>> +    }
>>>>>>>>
>>>>>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>>>>       if (r)
>>>>>>>> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>   {
>>>>>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   static int gmc_v10_0_hw_fini(void *handle)
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>>>> index 0a50fdaced7e..02e90d9443c1 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>>>> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>>>           return -EINVAL;
>>>>>>>>       }
>>>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>>> -    if (r)
>>>>>>>> -        return r;
>>>>>>>> +
>>>>>>>> +    if (adev->in_suspend) {
>>>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>>>> +        if (r)
>>>>>>>> +            return r;
>>>>>>>> +    }
>>>>>>>>
>>>>>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>>>
>>>>>>>> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   /**
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>>>> index 492ebed2915b..dc2577e37688 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>>>> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>>>>>>           return -EINVAL;
>>>>>>>>       }
>>>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>>> -    if (r)
>>>>>>>> -        return r;
>>>>>>>> +
>>>>>>>> +    if (adev->in_suspend) {
>>>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>>>> +        if (r)
>>>>>>>> +            return r;
>>>>>>>> +    }
>>>>>>>>
>>>>>>>>       table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>>>>>>
>>>>>>>> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>>>>>>>       WREG32(mmVM_L2_CNTL, tmp);
>>>>>>>>       WREG32(mmVM_L2_CNTL2, 0);
>>>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   /**
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>>>> index cb82404df534..732d91dbf449 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>>>> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>           return -EINVAL;
>>>>>>>>       }
>>>>>>>>
>>>>>>>> -    r = amdgpu_gart_table_vram_pin(adev);
>>>>>>>> -    if (r)
>>>>>>>> -        return r;
>>>>>>>> +    if (adev->in_suspend) {
>>>>>>>> +        r = amdgpu_gtt_mgr_recover(adev);
>>>>>>>> +        if (r)
>>>>>>>> +            return r;
>>>>>>>> +    }
>>>>>>>>
>>>>>>>>       r = adev->gfxhub.funcs->gart_enable(adev);
>>>>>>>>       if (r)
>>>>>>>> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct 
>>>>>>>> amdgpu_device *adev)
>>>>>>>>   {
>>>>>>>>       adev->gfxhub.funcs->gart_disable(adev);
>>>>>>>>       adev->mmhub.funcs->gart_disable(adev);
>>>>>>>> -    amdgpu_gart_table_vram_unpin(adev);
>>>>>>>>   }
>>>>>>>>
>>>>>>>>   static int gmc_v9_0_hw_fini(void *handle)
>>>>>>>> -- 
>>>>>>>> 2.32.0
>>>>>>>>
>
