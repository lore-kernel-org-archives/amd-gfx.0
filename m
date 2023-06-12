Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F70DC7EE25
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 12:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1599410E21E;
	Mon, 12 Jun 2023 12:24:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E24110E21E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 12:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq2AC6Zspi3p8NcQZC4E+J4I6uBeoxD4M7K7MxCpYOGI3wWT7eGWMGCdeBfSZbk3KZwu7H/q00XK0fPdqP8cihAk2bVHDGp0t+oDMotyx9L2Z2KCUSSOiJJ6C6a4egVtknJFCdbOjupLofEVhW5x48uMSCAXaOZZrfBQJaHdXTuAeTdE3RuLCOMwT1u+2UnzCZhxNCOCimoR0uQ3MJsY1Kb1gl00dEYoS4T/jKG+kxw/8eLJdElVR7GYzP6g2KSgZEs4e+4LJUQW41oIkOi2xuEZAW5rEbGg3Req3AnHzGI9O5WfwxtH5wdNyy+zmbSzLEcr8xQkGKnMsDnbuqB/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mpqPMMzwrQDrsi7URdor0O8KAJ8BLX6F8IO5Mw4hXo=;
 b=YFWE0z+rt1ATMZJ3YFQqCwqO8euNfSyytj74Mjy54NO7oETK5PxnzC2D//11n0/ogdSLTdHJQD2kh41+ug8Djn6FgYHBPK0XGRQigu/n9b2vdZvu7+skwnb1/gmGI+6vhGN7Bj3VE3MQeLzAgRXS6Kp4IyCHwmer55JGwvA7gwKCiY2mGisW6HWsCpYtmYfTFNM4obJaqpYciC70oeKJGGcKsW47eOMRPX/LroEsh5yps36bO5kmNns0ugoRFCMVtgxeoVYcrtBN9GCJqzpX5n9k6++S6SsDEvl1hUKA0mriOGeojheAllb/Ks7x39OFm6gUCXMpUXO30LtP+dk38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mpqPMMzwrQDrsi7URdor0O8KAJ8BLX6F8IO5Mw4hXo=;
 b=OFLo0JSMSmNIRBkMXT0RsCjVN0IYy1kDlBgidzJuUyr+QACXN4MZt/So6ofux8WJB5xFksaLrCMHbWRwdxn1xrjK9D4Q00WUBQv1ORODWp0/Qse/D9NcJZbYPtbkkkpGbleHtqkTUt5JvJY6Tjmny6jyZvbi8+KrsZ/KArXqWVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 12:24:48 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 12:24:48 +0000
Message-ID: <4aa191af-d98f-5e6a-f000-81ff8338cccc@amd.com>
Date: Mon, 12 Jun 2023 14:24:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] drm/amdgpu: flush GPU TLB using SDMA ring
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230609150521.951-1-shashank.sharma@amd.com>
 <CADnq5_O3377WchqgAK+tEkt5-oN_9Wu2bRz2VZ3tpkZaVR5Zww@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_O3377WchqgAK+tEkt5-oN_9Wu2bRz2VZ3tpkZaVR5Zww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: c2117946-8eaa-4131-6822-08db6b400381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YT7UwqBVJHMwyyUW1cpAdvdUCNrKSvnuBmNg16S58qCFKFzfMkCZDPXb27XQxXaSTKUvlverr06LNuNJ0d8tDfw3TBPDuXeNZMducU7P2TWzOtkk/TUi035n6XdqE/hrwvXtZEkxDLCm8nAOKu8WcR9nGheY8P50SgBQKOCv7W9Ai1S1qhsbw/JFVNUM0vczf8l4bbhSJTgHOZmX4C00zG+8dlra9eau364/jTdhtYtKLO9LPj+UHb/bSMzpVmRnTCAjTzzJimcnLY8UfaHx8bIKxBuE4gOxrS/Z1/usrnq4js7oWVrBdenFSwVK2mxAsY36F3qJNEmGoFPRt7swcFLu/tdDr2Th5Zhx7rHOPCGj4ryumBxop8jMhz9pH47klrPv7EjWiiFBTpMk5PKa1NRUp/P9hoH6YzWQRvCSzMo4p3miuJCRfAMxCOuLFn6423tVKC8XKxYnZiNQNPNZrlZrqChzB1uUym4WloYf+cJYs0rjzqazJKiuFX3rJKOQbdBWkCdS0VA90xqQagwzlNtcnRpFFSNx7efQK6/paDO6dR8tSGqb9PLwWPwww+1b0nwiByLrENNoy2h1BjcSWIomxQmn25oes5oi6g2VFo3gRD+VpHKB7Jj4XEe6CvHJrjgQo4ffYgIhXm97YHRTfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(6486002)(6666004)(36756003)(83380400001)(2616005)(38100700002)(31696002)(86362001)(6512007)(6506007)(26005)(53546011)(186003)(2906002)(8676002)(54906003)(8936002)(44832011)(316002)(41300700001)(31686004)(5660300002)(66556008)(6916009)(66946007)(66476007)(4326008)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdxL3E1U3JtSnppR2tDbjlaanFscnc5OUF5SGVFcUR4S05PVmlrTTJ4R3k0?=
 =?utf-8?B?alAwM0Rta0lJU2dwUVBzZUNOWlYzb2FFSG1pRTNSUUNURHc1TFZSdHNTWDRp?=
 =?utf-8?B?SlMveDVOYlRuc1FGaFFNdVJPK054aUpmVGRJb1BmNjY2VG1OYUxPOFUrU0sz?=
 =?utf-8?B?aEpKa1VweU0xL0h5RkxVV0Vib01STVM2ZHR5ekxMdWlQdXk5bkFQdE02V2lK?=
 =?utf-8?B?S01hSWhxUTQwQ0dsWGUwQ2w1aTJUak1rUWFOd1JUd0kvaVIrQmZjUDhRNXVQ?=
 =?utf-8?B?V3pHVzVWUFZ2WjFqVVlBL0dZSVRLMitPN0l2TGp4MWg3QXdIdEZtWkIwMHJZ?=
 =?utf-8?B?NGNaTExOOFJmTSs2MWJjUFdZeUZ6bVFraFlLbm5DQlpJY1RMQktLUWJlMGVa?=
 =?utf-8?B?MGpHUnpoV3pwYUU1MU1GMTJkdENhRllkNUtoVUJLOVpaaTB5ZVRzbUU0Yktz?=
 =?utf-8?B?NjFYcUJoTGIvYUJ2NzhrUXoxdWgwOVBwaHhQT1QvOXNKdUJCYVVrOHlNWWxi?=
 =?utf-8?B?ZHNjaHFWbXNvcWprbWtPcVVvR3FGR3FFdlBtSXRueUxxcitvNWpGK2dQNjAx?=
 =?utf-8?B?Sk9ORXRTWEExQ2RKc3dtU1YrVHhJSnpZSXR0MHpvNzI5U1M1UGhZMGZBQU5F?=
 =?utf-8?B?cjlWVU80QnIvMGFFdGJqTXVnZ2I4V0RIM0NxV0tvY2FNejIrNFJ6by90L3kv?=
 =?utf-8?B?MHcweml6bStJRU10L216cVNjeEdkbmZFZnd4ZTBCcTVwUmhEbFJqdXZucUpV?=
 =?utf-8?B?YVFNRFlnUHFtcE5LZUJlbjVCbXZxWktTQWVBWC8xNVZqcHJOWCtwZnR1K0hI?=
 =?utf-8?B?c2hoaTlhZkd5dlRjYmV4MDAwS1pQb3kwcDVSeVZlNmNaWW8wUkhISVZYTkZB?=
 =?utf-8?B?Wis2L2pVQU1LUExmOURRckhZd3FNTG8yUFAyQlZEb1Vrc2F5MDQ3YzQxVjFF?=
 =?utf-8?B?WkNhQjc4bS9PeiszYk1HdktaSUlnN1lVK01CQmxWSTBTa3ZSK0VFMytSWG1I?=
 =?utf-8?B?MytMZzg2U01obFZCRE5FaUxrdkZjSHNVVk1TOXZ3Z3Nva0JoTzN4cDlVTzVJ?=
 =?utf-8?B?YkJPZnB1dDhrRUpqOFZzbEE2Y3AyNTZlNm5oWmZ1ZGhvNTNEVDZIRkg0eXpz?=
 =?utf-8?B?UzZnYUxmZDY0MFBIVzF3bUhodDlrQlpKVXh4K21aOWNrdlIzMFYwdVgxekR4?=
 =?utf-8?B?cHA0bnpuanRDUThUKy9sVWh6cGszcFVBR2ZCMWhSanVvVEhjOXpNT1FIT0V1?=
 =?utf-8?B?eC93L0VoeG9tUEdyMDFMZGt3UFQzRlhYbEN3eGplYUJvWmIrMERudE5wb1A4?=
 =?utf-8?B?cmZSM1lHQndURGg1RGRiOUlFVU5qVUM2ZVU2bFlHQVI2Q085cGpUSGR2OUJ2?=
 =?utf-8?B?NERKV0tCZFRnYUdBWjJ0c1N3YUx4YU1XOVdhUkxlS2hFNWY1RTFnWkhrWGVn?=
 =?utf-8?B?MXorQjc4Z0VqZGRoODlmTnh1Sng1WWZYc1YzQWFTRHZsNk5FS2I5dFpIQVpF?=
 =?utf-8?B?M0JmdnVMZHJza3pHV3RtcjNPWmlzTnY3MmRHajkxbHVha0NUZzMyYVJLS25K?=
 =?utf-8?B?MDdZa05Ob1F4SkRmdDhPbW9pZE8zMHVPVmdMRUlwVWIrWS9laG44WkpQeCt5?=
 =?utf-8?B?SUlBTlFjRVRlMDNUSGZncG9peDBka3pRbU1aNnlNSldZRkhCQkZlaDEzdkdT?=
 =?utf-8?B?RWZPYjNSK0k3U1lQQWR2ZUdoR3k0ZW9KclJQSXJGS3ZPVGg5NzRud24wZ21P?=
 =?utf-8?B?RFAxYmxmTDE3dFRjWWY5MUZkUUpNem5FemRwRU9qZlc5WVJHVXJ6MEpTZElu?=
 =?utf-8?B?VWZRRTlFUFQ3b2kwSmpDTTh3Z0VNUlAyRlN5WkFIZTJhb2lkL1pOcDFnbDJ4?=
 =?utf-8?B?UDVPdEl5T1hLM1NXTWt5WVBOVkNOeGxMTU9sNWhSc0oySzFKM200amVaNTBD?=
 =?utf-8?B?R0lqcFVlUURkQUcxbWFFRnAya284NmFadVhuRTV1bGk1a2J5aDZBS0pCT0Vl?=
 =?utf-8?B?aE5mNFU3ZXhYUTV6aEswYWgyc1ZnbkQ1YytlUnFKb09vbWJ6NWpKV1lCajMx?=
 =?utf-8?B?UVVoOE5hRHV4TWVVTmhTa1h4RWgzc1piWWZPUTdmTXpkaGZHblVoVWpRNEFi?=
 =?utf-8?Q?/Cqmw41+B1YkHXY+oPg3pNaYe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2117946-8eaa-4131-6822-08db6b400381
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 12:24:48.7445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HtWBQoOKE/nllMU2IutMwvJxIaudOFfTz3OyAq3SdOHt2IfLQuupTyTfSLONB10bxfTlFRZ4pYRGV+wSLmTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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
Cc: Philip Yang <philip.yang@amd.com>, felix.kuehling@amd.com,
 Amaranath.Somalapuram@amd.com, Rajneesh.Bhardwaj@amd.com,
 amd-gfx@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Alex,

On 09/06/2023 19:08, Alex Deucher wrote:
> On Fri, Jun 9, 2023 at 11:05 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch moves the code to flush GPU TLB using SDMA ring and
>> splits it into two parts:
>> - a general purpose function to flush GPU TLB using any valid GPU ring.
>> - a wrapper which consumes this function using SDMA ring.
>>
>> The idea is that KFD/KGD code should be able to flush GPU TLB
>> using SDMA ring if they want to.
>>
>> v2: Addressed review comments on RFC
>>      - Make the TLB flush function generic, and add a SDMA wrapper
>>        to it (Christian).
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Philip Yang <philip.yang@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 22 +++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 36 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 34 +++++-----------------
>>   5 files changed, 67 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 231ca06bc9c7..05ffeb704dc4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -30,6 +30,28 @@
>>   /* SDMA CSA reside in the 3rd page of CSA */
>>   #define AMDGPU_CSA_SDMA_OFFSET (4096 * 2)
>>
>> +/**
>> + * amdgpu_sdma_flush_tlb - flush gpu TLB using SDMA ring
>> + *
>> + * @adev: amdgpu device pointer
>> + *
>> + * return: returns 0 on success.
>> + */
>> +int amdgpu_sdma_flush_gpu_tlb(struct amdgpu_device *adev)
>> +{
>> +       struct dma_fence *fence;
>> +       struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> I think it would be better to put this function in amdgpu_ttm.c or
> some amdgpu_vm.c.  It doesn't really have anything to do with SDMA per
> se.  buffer_funcs_ring could point to any engine that could handle
> buffer ops.  It just happens to be SDMA on most chips.

Makes sense, I will probably remove the SDMA layer itself and just keep 
it a generic function.

- Shashank

>> +
>> +       fence = amdgpu_ttm_flush_tlb(ring);
>> +       if (fence) {
>> +               dma_fence_wait(fence, false);
>> +               dma_fence_put(fence);
>> +               return 0;
>> +       }
>> +
>> +       return -1;
> Please use an appropriate error code here rather than -1.

Noted,

- Shashank

> Alex
>
>> +}
>> +
>>   /*
>>    * GPU SDMA IP block helpers function.
>>    */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> index fc8528812598..739077862a7d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> @@ -130,5 +130,6 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>>           bool duplicate);
>>   void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
>>   int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>> +int amdgpu_sdma_flush_gpu_tlb(struct amdgpu_device *adev);
>>
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index c5ef7f7bdc15..1248d1dd5abc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -81,6 +81,42 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
>>                                    false, size_in_page);
>>   }
>>
>> +/**
>> + * amdgpu_ttm_flush_tlb - flush gpu TLB using a GPU ring
>> + *
>> + * @ring: ring to submit the flushing job to
>> + *
>> + * return: returns dma fence which must be put by caller
>> + */
>> +struct dma_fence *amdgpu_ttm_flush_tlb(struct amdgpu_ring *ring)
>> +{
>> +       struct amdgpu_job *job;
>> +       struct dma_fence *fence;
>> +       struct amdgpu_device *adev = ring->adev;
>> +       int r;
>> +
>> +       mutex_lock(&adev->mman.gtt_window_lock);
>> +       r = amdgpu_job_alloc_with_ib(adev, &adev->mman.entity,
>> +                                    AMDGPU_FENCE_OWNER_UNDEFINED,
>> +                                    16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> +                                    &job);
>> +       if (r)
>> +               goto error_alloc;
>> +
>> +       job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>> +       job->vm_needs_flush = true;
>> +       job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>> +       amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>> +       fence = amdgpu_job_submit(job);
>> +
>> +       mutex_unlock(&adev->mman.gtt_window_lock);
>> +       return fence;
>> +
>> +error_alloc:
>> +       mutex_unlock(&adev->mman.gtt_window_lock);
>> +       return NULL;
>> +}
>> +
>>   /**
>>    * amdgpu_evict_flags - Compute placement flags
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index e2cd5894afc9..86ba70d2eb53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -200,5 +200,6 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>>   int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type);
>>
>>   void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>> +struct dma_fence *amdgpu_ttm_flush_tlb(struct amdgpu_ring *ring);
>>
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index ab2556ca984e..9892b155d1ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -52,6 +52,7 @@
>>   #include "athub_v2_1.h"
>>
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_sdma.h"
>>
>>   #if 0
>>   static const struct soc15_reg_golden golden_settings_navi10_hdp[] =
>> @@ -332,10 +333,6 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>                                          uint32_t vmhub, uint32_t flush_type)
>>   {
>>          struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>> -       struct dma_fence *fence;
>> -       struct amdgpu_job *job;
>> -
>> -       int r;
>>
>>          /* flush hdp cache */
>>          adev->hdp.funcs->flush_hdp(adev, NULL);
>> @@ -378,34 +375,17 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>                  return;
>>          }
>>
>> -       /* The SDMA on Navi has a bug which can theoretically result in memory
>> +       mutex_unlock(&adev->mman.gtt_window_lock);
>> +
>> +       /*
>> +        * The SDMA on Navi has a bug which can theoretically result in memory
>>           * corruption if an invalidation happens at the same time as an VA
>>           * translation. Avoid this by doing the invalidation from the SDMA
>>           * itself.
>>           */
>> -       r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.entity,
>> -                                    AMDGPU_FENCE_OWNER_UNDEFINED,
>> -                                    16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
>> -                                    &job);
>> -       if (r)
>> -               goto error_alloc;
>>
>> -       job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
>> -       job->vm_needs_flush = true;
>> -       job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
>> -       amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>> -       fence = amdgpu_job_submit(job);
>> -
>> -       mutex_unlock(&adev->mman.gtt_window_lock);
>> -
>> -       dma_fence_wait(fence, false);
>> -       dma_fence_put(fence);
>> -
>> -       return;
>> -
>> -error_alloc:
>> -       mutex_unlock(&adev->mman.gtt_window_lock);
>> -       DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>> +       if (amdgpu_sdma_flush_gpu_tlb(adev))
>> +               DRM_ERROR("Error flushing GPU TLB using the SDMA !\n");
>>   }
>>
>>   /**
>> --
>> 2.40.1
>>
