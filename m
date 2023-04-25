Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D3CC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 16:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B38710E2DF;
	Tue, 25 Apr 2023 16:56:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7357310E794
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 16:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td9WkPmR5hZ/nhYL+fWaqp2wJULsec5/Zg5z3OApdtxMozw4JRY0P56++Uv5HGmdOSL5YWs7Yz6bLQWndLwYYYBU7oPmF5XSUL0STgIZpBasV8FcuYawjqd8f5CyyIPib08CirvfY+++nOO9BwJ70j2QfzMDsZkinuuntE29XdslqSiT4Pz6voN1CYvsHgVDDyLfJy4NHHoYfTP9o+ovqBu1Ex74wfUJOyYt+4qsfScaxk1hFl7BwmBD18KcUOf3HtkEjvPEGuz3Y95oPXe/EcvVaHtBq1JKGG7V2uHAgGjNL8ngUoEZLuNpOzu+EDSJMv2hd7wq4NkgRfBHzeLiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89zMwY6AC/Qh010FIFVdV8a5+KDhoE5GRIYqXWSdv/0=;
 b=WVr6xeBkiobHGZKVnCJ2LKuMUd/X3YzkGuyKrIzIsg56/lmMvGTl0qevsf76daMEimgy0St8ZD2RrTxMnlSZJYXWbZ3DosNhO6FbXmYFCWzjKUyTQ/gFEa9/mSi0lLSxDzri+qVRVuQI/efZFCdNHRnK392CUZsdXlCAAg8pbUGL5R0XzWUkQvC0BfWFRlHIlMpvevfHcIcMg/Zd5BATKrzryqEaZ9nFgX+F4tvVxseWoWgnOTolzYNh68eF2rrLqcYsxGfeKPGVXntuP1t8FLpDn3VoPCfCXaOoNxiMX7kbJDfZzA1dcayXejHtVbOQYsly+IulucMSdHjv1JXZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89zMwY6AC/Qh010FIFVdV8a5+KDhoE5GRIYqXWSdv/0=;
 b=oRQtQgxU06421/9Y+7TgkvCjFEXbLIXSmks85MV2OPkRqLJqFt9qxaUh7n02DOHZCCBHUMTQRatgpz5ODAggYIckNOipwuooDcTAV+vwbjuGwKX5ltkJjn0YkLGVWaQ4sFeHwgfMtQdHV8D8dCGvls5HlRYm3dEjAF0d6sKD/SM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 16:56:17 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 16:56:17 +0000
Message-ID: <ecd951af-071f-c686-db16-4c369e3162c2@amd.com>
Date: Tue, 25 Apr 2023 18:56:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 07/10] drm/amdgpu: map usermode queue into MES
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-8-shashank.sharma@amd.com>
 <bd98e48e-652a-8649-d2e9-f3c90d710f0c@amd.com>
 <63fb9f84-04c2-64cf-764b-b30cd9b81558@amd.com>
 <75d5e1ba-de55-683c-a852-cb5138fcf844@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <75d5e1ba-de55-683c-a852-cb5138fcf844@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: f5870719-d10d-4637-e833-08db45adfc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1d/yNIfBtuRg8E7Sw/SLsL5hS34yxARSn6w1dlyNRrumQPwoP11x7+acOQtN5FizW0nPgd2KrT8fS0RRgxZY1YNUK9eUfoqZ7gHG3zEWdl9QsX+ymRUF4+QRQgmvQVvkhAGyeELVIZtvRfsYNeTq+Ha/2INwa5qpB5YtVP5EOiRGOdud6SMiv6KhMdBkdLCdOqt5GOtGYo7j0VpwrLUup2wRX8xYAYWw7u/9cuNdKCWcxRzPHQK4rmDdlL89yypjsLsUBXzNWhk7o0v9khe651mn6Xoi3MZaTQp4MCrf+0OY6iS4kic9MakUbndgI/jV3svdUawdMrnldAt33fZhFyqB0fAZEHhcoSbQ2pHhhxluzjUWi0EjHagRKJUXrzeEimvC9zSfcM5CqtUckBcKIg+gJc6m+rOh5ZNzEHtvih7nXwVrg3h3GrlOdeqYg6a1Jyqi9lCUMl/kUD6LG0va0KkaC0OwsQAFc7RvKzJ2DQYkvK71jQOOK809esplmOfu9S7XOMIQLunyRQ1kt6j6lgeI9qiGvRK0F6sNDsHM8O9EtivfSZmP87tBpbJd2Oz4nC8rJPlEAee8Jvj9iSP8n3eFeHM9iVE3JYUWaQdEwIVLqJIWOgDAFoC3BrFiWFZJuyf126f+nwljx8xKdMv6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(38100700002)(66574015)(6666004)(6486002)(53546011)(6512007)(26005)(186003)(83380400001)(31686004)(6506007)(2616005)(5660300002)(8936002)(8676002)(41300700001)(2906002)(44832011)(316002)(4326008)(66476007)(66556008)(66946007)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0RtRktnVWY4cUhMaGVQNmoxMElIbFRwQ2RZV0Z1S1VLUDNQeFFCaklxNmc4?=
 =?utf-8?B?N3pqTmorb1lSWkJhamllSGRPVWpRMjFmVTZva3pxQk1FNkE2RVQyUWo3anNU?=
 =?utf-8?B?TFk2Uy90dXgrdDBxOTE4RG1QeUFxbXRMMTZHSFZ4STAvS1FMRmRiU0ZkMWZ1?=
 =?utf-8?B?UHJCUDJGMWhQb0s4VW1hSGNNOEVyS3U3TDdXbkE2NWZYZW5Xenc3WUMyVlJB?=
 =?utf-8?B?alEycTdTMy9VejViN0lublZmZ1ppKy9nenVCcWFWViszYlZ2by9yVEFlRmRI?=
 =?utf-8?B?NzJJK1psSzlpbldmMGlvS1gxMjcxOC9QdU0yUlVuNXJVUGQrQmIyUVg3cHRH?=
 =?utf-8?B?WkwvY0lpSmIrSVhZaHNVK1RTdHhWK0dYME9BMWhFZ1EyYzl2bVI3emlWNFNw?=
 =?utf-8?B?dmFZc1R0QkpadXNDWFQxaHJQTDdCSEhyaGgyeUdnVTBNa0Z3dWRzaGw1bHZU?=
 =?utf-8?B?UDZma0k0YUQzQXUrbjlCYU91QXM0dVgzcXhMcklhZlhLZmNiN3ZUbTAzWlFZ?=
 =?utf-8?B?T3pJR1NGTW1ORzU0cWdmekVWSFBaYm5tMjAwL0xoTkFJMHFzRUUxSnZqTFk5?=
 =?utf-8?B?dGo3SnNTeVl3VnArSFlTdnRQVHN6RmFDbk9rOS96RlBlRGdtTXdYQnZuNFJJ?=
 =?utf-8?B?cGk0cldoSEoydUFuWDVRRUkyNkpMd0RnRkVQN3NIbmo1TmhnWUFhMTJYODY3?=
 =?utf-8?B?dzBJVk1Majh5STVrN3VQdWFmSjJVNDlQZWlmNkNhY2ZaZjRQVUZPeGJ6WFJD?=
 =?utf-8?B?RE9Za2ZvMUZaS01UR2NoSkx5KzdHOElxUUhhd0ZXZEQ3bU5VeGtpL3FzZ3Jz?=
 =?utf-8?B?RXVKQWJKaDM5RWJTQXpsOTl6WkJrdmlGTUdZN05jc2dYL04wUlZwckhQRzhU?=
 =?utf-8?B?MmpXRjJnN3c1bEVUUndJTXJjSTVwYWhHVGN3TlBSRGxLaUdoNW9UM28veVVo?=
 =?utf-8?B?OTFXVCtIQkhpZlEzSmtBdHpNcFd0QVNRUUIwLzVGYmc4SDFpa01KbEkxVDYw?=
 =?utf-8?B?T0V3cCttWU80amo0bzVpaFFZZWR5ZGtFVUg5Mjd3anp2ZmN5dzVIYmt1YWFD?=
 =?utf-8?B?K3QrRDZJQy9USmpsNHNLMlJYMUsvN3JoSW1TWlB2d1ZVN2NiQmF6MUtBMXlF?=
 =?utf-8?B?SklGbVhFUmxRQUFIWjBsYTE2NDA0V3pRQjBMVG1STjNRcm1aVmNzUm83azYv?=
 =?utf-8?B?NlFKQlJNcTEwNnZWVmRrUm16MS9ydklGdW1UZ0VJMFlndWQvZmtZdXdHbC9U?=
 =?utf-8?B?Yi9DVnRDUll0VzdRVGQ2ZGxrc3NUQXp3clR0UDVCa1hyWHdJYURrZnJETnox?=
 =?utf-8?B?bUdEd1NDa3VrZjBEelpaenJTNUd0WDlEZ3gxSWZDK3BOaWNmT2hBOWlKMFZS?=
 =?utf-8?B?UVJsN3UyU01aL0dJQm16NFR5cjBIWHdxRll6TUpMR3JxUENsZUljNDZ2OFpB?=
 =?utf-8?B?eUFyV0dvNFJEK3NBL0Fka24vdkNKUTZJQkRDNkZleXRaTXo4RkJSa25rMTV5?=
 =?utf-8?B?OFpFTXpDUWxNNVB1TUpYYUJ0K0tjYlBCSXpCTFVRSlVjMm55T0tBRzBTU0NV?=
 =?utf-8?B?ZGluN29iK3ltQjUxUFJ5NDNlY0pkNlcyOXpmcmk0bXNVb3NyQW1tNWwydUEx?=
 =?utf-8?B?RHBSQ2VkWVNKRHlxcGVNVTBHdUJGbFlkTEIweE5FYi9XSDVUa0ZBcHlBTWpN?=
 =?utf-8?B?dHNDRlVpenBNa1FVS2pWUkJmc2RoMWZ3eUFwVWNkRW9qbjZVWks4a2FLMHNx?=
 =?utf-8?B?SERwd3Y4bkxnM2RHY3JlNU9xVGJESzdtVzRoaXFHalJPeFMvMmoydmVHVDk0?=
 =?utf-8?B?SXZ1QURodVRTem1Kd3JvanhDU2xMS0dWL2FPMG0zM29WM1ltM1lBZnhuUFdQ?=
 =?utf-8?B?SFA5Snk3RmJ1a2o4bmdzTXhjSzU3Q3NnSHVkY0tDeHVvZEE5U0Y3Q1ZVS0U2?=
 =?utf-8?B?VjZFZXRRejZ3NVlHbTA0THpzNE5hZWR5YXAxcXFPRCtwbGdOaGdzZWtRT2tR?=
 =?utf-8?B?NUhkcmNFUjdUbkU3Y2VtclFIMGMrTFNYT3BybERwRk9iVkFDSlNFWDlaSEN3?=
 =?utf-8?B?anFzbnpjak5tRm5jYXBXenBJcGY1WVhyMk1HeHhqd2VxR3lFeDVxTW5Tc2pZ?=
 =?utf-8?Q?UL+FIgJCmZ/t3smcvS1gp6wjS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5870719-d10d-4637-e833-08db45adfc74
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 16:56:17.3309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R91EPd/kredPTyPJED8D2UPbM5zSIWnj5mttF2VYHQVm1wyPn1b54vTnzZ+TcYuII5GtseIYtTyj4YznfO8HuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 25/04/2023 17:33, Christian König wrote:
> Am 25.04.23 um 15:31 schrieb Shashank Sharma:
>>
>> On 25/04/2023 14:34, Christian König wrote:
>>> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>>>> This patch adds new functions to map/unmap a usermode queue into
>>>> the FW, using the MES ring. As soon as this mapping is done, the
>>>> queue would  be considered ready to accept the workload.
>>>>
>>>> V1: Addressed review comments from Alex on the RFC patch series
>>>>      - Map/Unmap should be IP specific.
>>>> V2:
>>>>      Addressed review comments from Christian:
>>>>      - Fix the wptr_mc_addr calculation (moved into another patch)
>>>>      Addressed review comments from Alex:
>>>>      - Do not add fptrs for map/unmap
>>>>
>>>> V3: Integration with doorbell manager
>>>> V4: Rebase
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 67 
>>>> ++++++++++++++++++++++++++
>>>>   1 file changed, 67 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index 86de35292f69..7a45d68091ec 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -31,6 +31,7 @@
>>>>   #include "amdgpu_smu.h"
>>>>   #include "amdgpu_atomfirmware.h"
>>>>   #include "amdgpu_userqueue.h"
>>>> +#include "amdgpu_mes.h"
>>>>   #include "imu_v11_0.h"
>>>>   #include "soc21.h"
>>>>   #include "nvd.h"
>>>> @@ -6411,6 +6412,64 @@ const struct amdgpu_ip_block_version 
>>>> gfx_v11_0_ip_block =
>>>>       .funcs = &gfx_v11_0_ip_funcs,
>>>>   };
>>>>   +static int gfx_v11_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                 struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    struct mes_add_queue_input queue_input;
>>>> +    int r;
>>>> +
>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>>>> +
>>>> +    queue_input.process_va_start = 0;
>>>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << 
>>>> AMDGPU_GPU_PAGE_SHIFT;
>>>
>>> Could be that this is wrong. What is that value used for?
>>>
>> Both start and end are required by MES FW for mapping the MQD. The 
>> value here is generated same as in KFD userqueue.
>
> Ok in this case then that's probably the values which will be written 
> into the registers. So that's probably ok.
>
>>>> +    queue_input.process_quantum = 100000; /* 10ms */
>>>> +    queue_input.gang_quantum = 10000; /* 1ms */
>>>> +    queue_input.paging = false;
>>>> +
>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>>> +    queue_input.inprocess_gang_priority = 
>>>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>> +    queue_input.gang_global_priority_level = 
>>>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>> +
>>>> +    queue_input.process_id = queue->vm->pasid;
>>>> +    queue_input.queue_type = queue->queue_type;
>>>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>>>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>>>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>> +    queue_input.page_table_base_addr = 
>>>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>>
>>> You need to implement some mechanism to keep those page tables and 
>>> all resources in place.
>>
>> I don't get it, would you mind elaborating this please ?
>
> We need something like the KFD eviction fence. Probably best if we 
> have a call on that.

Noted,

- Shashank

>
> Christian.
>
>>
>> - Shashank
>>
>>>
>>> Christian.
>>>
>>>> +
>>>> +    amdgpu_mes_lock(&adev->mes);
>>>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", 
>>>> queue->queue_id);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void gfx_v11_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    struct mes_remove_queue_input queue_input;
>>>> +    int r;
>>>> +
>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>> +
>>>> +    amdgpu_mes_lock(&adev->mes);
>>>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>> +    if (r)
>>>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>>> +}
>>>> +
>>>>   static void gfx_v11_userq_set_ctx_space(struct amdgpu_userq_mgr 
>>>> *uq_mgr,
>>>>                       struct amdgpu_usermode_queue *queue)
>>>>   {
>>>> @@ -6507,6 +6566,13 @@ gfx_v11_userq_mqd_create(struct 
>>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode
>>>>         gfx_v11_userq_set_ctx_space(uq_mgr, queue);
>>>>       amdgpu_bo_unreserve(mqd->obj);
>>>> +
>>>> +    /* Map the queue in HW using MES ring */
>>>> +    r = gfx_v11_userq_map(uq_mgr, queue);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>>>> +        goto free_ctx;
>>>> +    }
>>>>       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>>>       return 0;
>>>>   @@ -6523,6 +6589,7 @@ gfx_v11_userq_mqd_destroy(struct 
>>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermod
>>>>   {
>>>>       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>>   +    gfx_v11_userq_unmap(uq_mgr, queue);
>>>>       gfx_v11_userq_destroy_ctx_space(uq_mgr, queue);
>>>>       amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>>   }
>>>
>
