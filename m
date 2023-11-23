Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D440C61D85
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 19:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A4DF10E093;
	Thu, 23 Nov 2023 19:52:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61012898C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 19:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk8nGcdsWi9enjBjZJnCOHdJaHEs1B95jvI+Ub4qYC2wBUINHn4x5zJZ9ybVmqHynakVyOMogUzgkVwLbxX8ZknZjqo2Y65lR35qjTCdsTHS2942iQzb7vkhS3gJujclkb0EcxR5qUcqLLnwsys1cfSZfT4q6b6M02QLOv21c+UXBtE8ZPu3sf7q5sLlMwxySTjPEKLTbVBe0gWXMKGBWUseaRwDXjAjWvFf1Q4HcS/mHwFil0LZY4ij3F7Q8UmshNgtbHwfTmqBaRDSwqWE6+ApzRHuOTKCkqeryqm8F7z9/WB5CYsiCDY4aOT01XaAplAlsIuDtFHUlNCiod/shA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM5cxIwHcx/U1LvTPA1nqr1Wy437DilLhzMJksXv5BE=;
 b=axTPuw6BFxftsK9P+WYOknoMoHjIn0GRChWatQgKcvjO8jD/dW9ncpLR13lzh3rp4Y8A4RTAzV8KZdQW7CTR5q3lgzSxJN+fVFXDaEeGeN58ntBgzP3a+uPs6pVoza1EgoBu9M2/DWnSTIHX1ZXANva1eucNmVr7cyPoLmqy1Ci9SVuMQoZyEes51k6BDjOHxg/1ZG8YPC6f9tSlQdpdmdXclZqMIpyn+goWU5uK0HH2DcGf7otj5mSPQOzv+++Do6cvViMm8Lu7nUTaeO3mSJ5KLsj4V0U0TS5wEWVjCUNkia6XE1HtzfLSXjtgTbdPSTTyTsTpWjVkiThBfPin8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM5cxIwHcx/U1LvTPA1nqr1Wy437DilLhzMJksXv5BE=;
 b=ratgJxxCMlvzx6kCygQOUhwtQtXSBko4CsIy2q71t3ZVd20UQTPS4NToosdXyXp6/dUsyqqRBbuuTx/Ey9gfI8VzluhV+/bQl4YadvZtXuL6mU8XuhGN0Q0gplAbOhvPDcqdQU2kBdZtHfr5e+QOGeQhDT2n7FUCoVbeyfwuPns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 19:52:38 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 19:52:38 +0000
Message-ID: <d61bf4da-a3f2-4457-b770-49b71f01a26d@amd.com>
Date: Thu, 23 Nov 2023 14:52:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] drm/amdkfd: enable pc sampling work to trigger trap
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-21-James.Zhu@amd.com>
 <6738fe40-7051-4b5c-9151-3eb7428c9d00@amd.com>
 <9b4c3574-a341-483e-95ef-6be9784a59a5@amd.com>
 <d4fce6da-370a-4c9e-b6b5-ef2b875b9eb2@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <d4fce6da-370a-4c9e-b6b5-ef2b875b9eb2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 408122c4-7e11-488d-de07-08dbec5dbec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAyB2e5ASzPND72OPNQTEdLrfcdB/Rk0XO9rXTkus73Ietf28jdVoH6q8uteK7mfB2hqvLl2FOLTEgvsQdY5kjOmVvsNpku3Lz37UpU7CSBZQHFHNszTHwpH1sicx9YzqtEZGCvSRsu5ODoymfXZpQ7HtINRXe4pBVJ5KAc4n56+D+n/gPz3WoqlS27JUNSEOGN6hoGAuUctOuCOlPu7sYN5ESaqXqD5vyg4/0sipt8Py0MHrg3ODZdezSRcZ4r0esQ+kCZMWoUXUDER7HEMuPEGf4FkqRgx2pTt50ahk64F/I6L6heWolYNAltb1bwDmpWHwSFuHDoxMDx2LmiLoIC5wWCCWkQwqKYhDIu8ztIqsM34zv+ssrJkMwrrawy8POGgRuSTZvqP5Sn/mVn2e6fm64Pf6vjgKvnzm13A03x+qEt3x0PY9qL/E3HoMhjwlhe8UruAxnZXolu7CMbIDv9XT9PwZRER8vCKWVsKLSLWflVxuWIe7ZIRSTfJXadtvoMbTWzuVZ7MvJsD50Bja1uDXj7SyC0GupR/Pv6RaWx5Z0FXtrutPPniEjsY1ArnPqOwM5XZrLZ0OZtLwvygwV8LrJz0Q4vQToaqMvHsYgR7jHR7HEmZlvWZ9IyEsgRsqjQEiC2gYkEoeDPglkd3FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36916002)(2906002)(6666004)(31696002)(66476007)(2616005)(8676002)(6506007)(83380400001)(4326008)(8936002)(6512007)(53546011)(66556008)(316002)(26005)(36756003)(66946007)(110136005)(6486002)(478600001)(38100700002)(5660300002)(41300700001)(31686004)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBRRmM2SVoyMjZva28vM2Z2N1Q4ZURKSlJkSWwza2NEaGdzTlBjYlViOFoz?=
 =?utf-8?B?ZlpqcHl6S0NSUHdJOHNSNUZ6YjJZS0F4L2lCSXc0MTdWUm9tUFVodUlZRDh1?=
 =?utf-8?B?WndnWWphWlBzMW81UjdFR0dXM0pHM3ZEb0FzeGxWaDNQazlvK2p3YVpLc3I3?=
 =?utf-8?B?T2ZnWVRjbG9MWm1HUWFEdTU5V0tvL2pSR0dzUHk1eS8xWFVnb1lBNXBMOTR3?=
 =?utf-8?B?UjZYcXZweGNKU2t6d3kzbHFxYW9xcm04YnNrU1JNcFpqeWIwbTgvSDdoWmRP?=
 =?utf-8?B?M0xTMXNWcmx0cVRKd1AydWpvOURRRkZkYjJmMFlKQ05idjJrNHhVcERaRUd0?=
 =?utf-8?B?VHBCR1ozUDgwWWpiOGlGME44L1p1OUlNeW1SREFFSUtRWWxaMFlrNit0SzRC?=
 =?utf-8?B?R2hna2NsNWVoRUZZcHE5d0VQMFBqUVRmS2ZIblZUNUtWWDBqd2RHVlZZVGUw?=
 =?utf-8?B?OVRFalFkNFVPaWljTEVmaU54RitwMXVhODQvdGFqS2wrU3d4clBlZlk1Mk1q?=
 =?utf-8?B?RHpZWk1Mb0wyOGpnNFF2UUtnaFVJMTlXSUJrcCtEejFNSjJsdzQzQkhkbUpK?=
 =?utf-8?B?aVY5aStJRjBMOG5zOTV4M29MSUtEb01hRVloY0g2YTNUQnQ5ekZuLzdPeTR6?=
 =?utf-8?B?bUJCOUVPUnVIMUlxcXE2SDUrektEVnB0Rys5MUgzdjZlRTkxYjU5a0VFbWZn?=
 =?utf-8?B?VXh4SytFdUQvUTQxWitYdklva3VhbGd2WU42SzViVUR1SVRVbVpYZXdQOTg3?=
 =?utf-8?B?bno5M0RPNjgxd1BVSkVJZ1VMOHhlQmpqK2wrY1YzWkxpWktWSnFNd0pMVHZI?=
 =?utf-8?B?bjFjcGNZMnZQUGhNVE1wRFBrU3dFVkdJV2NXQjRFTFZDQ2s5dmRHOUZyWlFn?=
 =?utf-8?B?WnJidEwrTm5VWGtaZ29lbFV2L0lkSEZnc2QrTjlEdFo1S0g0cHFmRndsY2dR?=
 =?utf-8?B?OVZHZjJqbmZ6YmZYOUQ0R0xOTmN4M1JvaTNVUFhZeHpjVVRCQjNGdGlydTdO?=
 =?utf-8?B?ZC9BUTlHcmVsQ2xjWU8rcUZwbUdSVUVreWV2Z0o2Z0NEVXNESUd3b0FSQjM5?=
 =?utf-8?B?ekpDeDB4U1BNUE5rd3lkcWcyZ0E3SldLN0RRb1doY3NxYVJUblFvYjJXeGpM?=
 =?utf-8?B?MHNPc2d3ZW10R2dlVUIxUWNTdjgrMDh0ZVhMTG1scXAzTWdpWXhEcVpiMzRw?=
 =?utf-8?B?VVhweXM3MVluVWVxYzVFdDJqSkc4T1RoTEJrQ2FMbjIvNCtCUjROdlB5Tjhx?=
 =?utf-8?B?TW1CWi82RWhsYUpHaGVXZUFRTEJIdzBwdHV1Q0ZieGFaa3UzaTVMdkE3VU5s?=
 =?utf-8?B?S1RSVVFCNWdwcVhsaXJYaE5VQlNhQmpUZUd6L2ovMmc1Y3JhaDQwYXFVaUly?=
 =?utf-8?B?VVo3OS9yZTZuanpYYVhISzRyaVVSOU9odWUzRERLelNWUm1Sa3daTjZTVmNs?=
 =?utf-8?B?aDRjUmp3cFp6UnFOY1kxN254OWpsajFZb2Iybk13Z2E3d3BMUzhyZlB3WVJH?=
 =?utf-8?B?NUxDNENLWENYV1Q2NTdGQmJMK1NCelQ4dHkwMHkvbnd1SWlqdEd1cHV1Zng3?=
 =?utf-8?B?cWpLWGZOOGhxWXRGZyszL2kybWZ5ekpTaWV1MkNMSnpyWWpCRitFTURnaVo1?=
 =?utf-8?B?M3Y3MkplVjlaclFLTytqbmJMeTl4eGNxTnJFenI0cEJMS3dZc3k4L1BtYTQw?=
 =?utf-8?B?R244ajJhQ3J5S01JNkJ3SDVURHNIdk9sZU4vS2gzYWJNVmJwYjhXRU5Ydi9U?=
 =?utf-8?B?Q0I0VGdZMC8xYmdsdzRNbEpMOERORTFJZlFxa3dpcXhzV2NUb3ZjZzRzYlBR?=
 =?utf-8?B?ZEhYcHkyNW1Zd0hpeDVsQkpVR3ZlMnJZNE0veDUxTzhIN2lQOGdLL3BhSytK?=
 =?utf-8?B?R1V0NWZHV0JBWldpTEFDVzEwWFhZYWplU05lczdaVDFqb21yMWJPZFArU21u?=
 =?utf-8?B?cUdlQVRiRXBMMXBwYzlSVXRkMWxEcW5RL003MWUwWFJHeHo2YW0wYzNCSGNn?=
 =?utf-8?B?NTV2N2hGSGpIbW0xVEZtd2wwVzNIZ3lndzVWcjlOd3JSN3hzZlZZWDdtVHg1?=
 =?utf-8?B?bkN6dDdySW1kcW5zOC9PSHRWZjdPbWtvQU1xeXJTTGV4cDE3UUNzVDdTUlJk?=
 =?utf-8?Q?Vk15ImSQrynxTv1Og5z03fP66?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408122c4-7e11-488d-de07-08dbec5dbec1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 19:52:38.2124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJiDqN1C2zjpt2mTq2ESCz/fjuf44HrYA/EYgNA0Vu7AH36NX9UeCtQ2bp0nndjd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
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
Cc: joseph.greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-23 14:08, Felix Kuehling wrote:
> On 2023-11-23 13:27, James Zhu wrote:
>>
>> On 2023-11-22 17:31, Felix Kuehling wrote:
>>>
>>> On 2023-11-03 09:11, James Zhu wrote:
>>>> Enable a delay work to trigger pc sampling trap.
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  3 ++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 39 
>>>> ++++++++++++++++++++
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  1 +
>>>>   4 files changed, 44 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> index bcaeedac8fe0..fb21902e433a 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> @@ -35,6 +35,7 @@
>>>>   #include "kfd_migrate.h"
>>>>   #include "amdgpu.h"
>>>>   #include "amdgpu_xcp.h"
>>>> +#include "kfd_pc_sampling.h"
>>>>     #define MQD_SIZE_ALIGNED 768
>>>>   @@ -537,6 +538,8 @@ static void kfd_pc_sampling_init(struct 
>>>> kfd_node *dev)
>>>>   {
>>>>       mutex_init(&dev->pcs_data.mutex);
>>>> idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
>>>> + INIT_WORK(&dev->pcs_data.hosttrap_entry.base.pc_sampling_work,
>>>> +        kfd_pc_sample_handler);
>>>>   }
>>>>     static void kfd_pc_sampling_exit(struct kfd_node *dev)
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> index 2c4ac5b4cc4b..e8f0559b618e 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>>>> @@ -38,6 +38,43 @@ struct supported_pc_sample_info 
>>>> supported_formats[] = {
>>>>       { IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
>>>>   };
>>>>   +void kfd_pc_sample_handler(struct work_struct *work)
>>>> +{
>>>> +    struct amdgpu_device *adev;
>>>> +    struct kfd_node *node;
>>>> +    uint32_t timeout = 0;
>>>> +
>>>> +    node = container_of(work, struct kfd_node,
>>>> + pcs_data.hosttrap_entry.base.pc_sampling_work);
>>>> +
>>>> +    mutex_lock(&node->pcs_data.mutex);
>>>> +    if (node->pcs_data.hosttrap_entry.base.active_count &&
>>>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.value &&
>>>> +        node->kfd2kgd->trigger_pc_sample_trap) {
>>>> +        switch 
>>>> (node->pcs_data.hosttrap_entry.base.pc_sample_info.type) {
>>>> +        case KFD_IOCTL_PCS_TYPE_TIME_US:
>>>> +            timeout = 
>>>> (uint32_t)node->pcs_data.hosttrap_entry.base.pc_sample_info.value;
>>>> +            break;
>>>> +        default:
>>>> +            pr_debug("PC Sampling type %d not supported.",
>>>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.type);
>>>> +        }
>>>> +    }
>>>> +    mutex_unlock(&node->pcs_data.mutex);
>>>> +    if (!timeout)
>>>> +        return;
>>>> +
>>>> +    adev = node->adev;
>>>> +    while 
>>>> (!READ_ONCE(node->pcs_data.hosttrap_entry.base.stop_enable)) {
>>>
>>> This worker basically runs indefinitely (controlled by user mode).
>>>
>>>> + node->kfd2kgd->trigger_pc_sample_trap(adev, 
>>>> node->vm_info.last_vmid_kfd,
>>>> + &node->pcs_data.hosttrap_entry.base.target_simd,
>>>> + &node->pcs_data.hosttrap_entry.base.target_wave_slot,
>>>> + node->pcs_data.hosttrap_entry.base.pc_sample_info.method);
>>>> +        pr_debug_ratelimited("triggered a host trap.");
>>>> +        usleep_range(timeout, timeout + 10);
>>>
>>> This will cause drift of the interval. Instead what you should do, 
>>> is calculate the wait time at the end of every iteration based on 
>>> the current time and the interval.
>> [JZ] I am wondering what degree of accuracy is requested  on 
>> interval, there is HW time stamp with each pc sampling data packet,
>>>
>>>
>>>> +    }
>>>> +}
>>>> +
>>>>   static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
>>>>                       struct kfd_ioctl_pc_sample_args __user 
>>>> *user_args)
>>>>   {
>>>> @@ -101,6 +138,7 @@ static int kfd_pc_sample_start(struct 
>>>> kfd_process_device *pdd,
>>>>           } else {
>>>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
>>>> + 
>>>> schedule_work(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>>>
>>> Scheduling a worker that runs indefinitely on the system workqueue 
>>> is probably a bad idea. It could block other work items 
>>> indefinitely. I think you are misusing the work queue API here. What 
>>> you really want is probably, to crease a kernel thread.
>> [JZ] Yes, you are right. How about use  alloc_workqueue to create 
>> queue instead of system queue, is alloc_workqueue more efficient than 
>> kernel thread creation?
>
> A work queue can create many kernel threads to handle the execution of 
> work items. You really only need a single kernel thread per GPU for 
> time-based PC sampling. IMO the work queue just adds a bunch of 
> overhead. Using a work queue for something that runs indefinitely 
> feels like an abuse of the API. I don't have much experience with 
> creating kernel threads directly. See include/linux/kthread.h. If you 
> want to look for an example, it seems drivers/gpu/drm/scheduler uses 
> the kthread API.
[JZ] then let me switch to kthread
>
> Regards,
>   Felix
>
>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>               break;
>>>>           }
>>>>       }
>>>> @@ -123,6 +161,7 @@ static int kfd_pc_sample_stop(struct 
>>>> kfd_process_device *pdd,
>>>>       mutex_unlock(&pdd->dev->pcs_data.mutex);
>>>>         if (pc_sampling_stop) {
>>>> + 
>>>> cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>>>> kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>>>> pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>>>> index 4eeded4ea5b6..cb93909e6bd3 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>>>> @@ -30,5 +30,6 @@
>>>>     int kfd_pc_sample(struct kfd_process_device *pdd,
>>>>                       struct kfd_ioctl_pc_sample_args __user *args);
>>>> +void kfd_pc_sample_handler(struct work_struct *work);
>>>>     #endif /* KFD_PC_SAMPLING_H_ */
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index badaa4d68cc4..b7062033fda4 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -263,6 +263,7 @@ struct kfd_dev_pc_sampling_data {
>>>>       uint32_t target_wave_slot;  /* target wave slot for trap */
>>>>       bool stop_enable;           /* pc sampling stop in process */
>>>>       struct idr pc_sampling_idr;
>>>> +    struct work_struct pc_sampling_work;
>>>>       struct kfd_pc_sample_info pc_sample_info;
>>>>   };
