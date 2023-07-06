Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0312EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 17:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F5710E067;
	Thu,  6 Jul 2023 17:32:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21BE10E067
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 17:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr1glc8meiLx7vO2mOs8lUwckM6UPuuO6Lwy8e37MM9QSzX4BQZ1muhOeFVDPNoD+ovF59xU4aAFBslezQRVbTO9+/2yOpxJlH7AMT8atuQPh8JCuhqDfjF9gcQoRomsdaq9+6WClVHlboJdB6s7aRjSPKlJpBS/Ir9GcYESSbc3hulZd34uLQdKwg9HjHjFPBBYBDYY+0N4XCyzkyQ2uEkaQaLxErikvuEqeWF9jYF3VHBjE+cHYlf7fPyXuBeSKOXhwMPaFh6kjKQbLeRHqZTd6v8WHiwGztMZ0rFwAYBzfkiMmqInCXiNR7PVT1DLMzUVi87jzxDZXOL6d7TCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZI4YmvFbQXdM1HVkhLAf5or8jpPcBkM/Ih14NgWdRo=;
 b=bZ2mIZBBBAaijqHDbo2W32WkhuXPAPt49YJQ7lpgKcWV6G4zRA9fxwt/ttjhrpJI8Qu4Qfgv94ioXgmt8/1800YpRweZygEp39/QlmqLm0aM9vmiWGFfpRHSYKmYqcGBbo5yNc+weCYtcwvdjqSZ2rBlRwhzJSFvN2GNC7TEuo+LZWDVxrCs6hK6VE5ElU7gKT4RZ2hj5gMsWEO9PB4GJrx3eVEQ5XVb3ivGxaR4O+yk2VroBXQoqR7DJL8FAVKPtexYg1mwfL7gOoQY0dKODpW0AGwESNchhlWXMo1jQbsmUIUWF2przLLLTArqfvyoTwjlX+qpIVaa/qIXKIpqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZI4YmvFbQXdM1HVkhLAf5or8jpPcBkM/Ih14NgWdRo=;
 b=lhCRddGw4sW8z9hOykLeOX72xDjc7M593Hdy15PYSM+ui6QhJ/xVHWX9lA/Am0/veBGWOF63YL39mYZKJG28oJRymzEZiYyHIcP9GWpNsauSkAyX3yOc58Y9rRwgC//JnUwgKxIHriBwRpRF+/PG1vByKX/Y2NIVkDZF6WmXKqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 17:32:53 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 17:32:53 +0000
Message-ID: <cf57ea27-e72f-d5e2-d8cd-60122090e889@amd.com>
Date: Thu, 6 Jul 2023 19:32:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 06/10] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-7-shashank.sharma@amd.com>
 <CADnq5_PS6Q=OqBf1OzYXkKbO=3EiKoTCk++n7fRKv2BGEk7tYg@mail.gmail.com>
 <59b6e3ff-3a5c-3beb-32bc-49720c530b5b@amd.com>
 <CADnq5_O_Os1ToTAodrtXiyj=MQeNpe+SnwBOynXV-MUxUvrU2g@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_O_Os1ToTAodrtXiyj=MQeNpe+SnwBOynXV-MUxUvrU2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH0PR12MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4c2799-b7e3-4113-f08f-08db7e470739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFIR6ZEHgTjcK+xQlrT/bAhEfLFP3tp6QdiDSjsshaHOfbiZKPnfRdjnuvaaELBtkq0Cly9mNf4lIf/PTRFIfMaCTSUplzZLi0Unr3+8GdpA/HcsAa0BoSyH6k4E6eSXXdP5MFGDVAmtUfv40dcJ3LiCsWDmpxRmf8YDHiYoeoD9Mc7icqpvpM06ee4RrSvPJeb9U76nw+XLq+Rmnl9fQgUkQM+HsAlfaSZVXScg+/uTZ1EX7r08s0k8EqdXcLFoWmCPtyDRAgnSg7VVDuIG2rZtABu2f/Z9WcTENkJNY3S/Hlm1gWIA4MiS8nR5/CQFxSgMSd5IHdHizalgZkBKq06GW2prvL6if9FGTZKhbojv2Pq+Pi3Yq0EvybTHi/cZJGLIb4ZWd6UpLC8ZGjrc7Eydqxyp2+6ka7tajzqcej0qpfhhGBmh/QTaho4Ie6IVgByg0xHBH3fiXg6E5AFAzo/kvK78IILHjdahqIVSBnQvZ1UMW13ASfK247hwKaW1dxpWpAlqZ1emFEvr8Q87yrPCHp7Z1w6U2H4GBbVJciEN5Lnkjubmi18kZnw7Cn/2X4CkA9ygD14UXOUDoWW9ongfms/NL/YWqAgu6cj6aCYxvrg7GerG7mMT6PGf5OyyTtHMHYukdqEMs4yFFCyQLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(5660300002)(66556008)(8676002)(2616005)(2906002)(8936002)(6506007)(53546011)(26005)(44832011)(186003)(31686004)(41300700001)(6666004)(6486002)(66476007)(4326008)(66946007)(36756003)(6916009)(54906003)(478600001)(6512007)(38100700002)(86362001)(316002)(83380400001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVpGT3NuU2NvN042S0o2R1pKcDRPOGpNeHI4OHJEcFlEZEM0RlBhRUpTU1Yz?=
 =?utf-8?B?TEN2d3ZDbDBLblc3SWhGMWhnYUQ4ZmZ5N2pidmx3ZEZzdjE4TVVCSWxUdVk4?=
 =?utf-8?B?TWlDclBTdTFGOUtuckNqWWtSYnVtVlFRSXEwQmhNWUFjYmQveFZnZFlxRDc1?=
 =?utf-8?B?S01xZXBJYUFUYWpEMTluaEwvb1krUmQzM0htODBlbjgvcUlIazB3QTlQenlu?=
 =?utf-8?B?SFF0YXBlTlpSNVphSUFyQTNYY0wyYzJ5WGl4d1dkS3lWbjBYYm5KdW1hUisy?=
 =?utf-8?B?amJOQzNzbnh6TTlxN2J2TjJmdmVLMXZobmRsL29mSkc0WFdWeGlGaTlsVFFu?=
 =?utf-8?B?OXlaVjUwQXdLK09GZ3VMQ2I2eFpka0Z3U3E3N0t1WDBabjYxU2VGb3JpamNw?=
 =?utf-8?B?enRrZU5QbG05NUxMSDNTS2tSWGtmMkgwT25GaUNBWjhYYzFuaHM3UXVQY2F4?=
 =?utf-8?B?WGNERThHZGQydnlULzkvMi9pRW53dXNHZzM3VEt5M1RZTmZEVFVQR3lFOGhy?=
 =?utf-8?B?d0J5WDU0SGVlMWpacnZGQ0xYZmZ1Wm1uZEVaSGM4SytScWVYa21zWFI2Vk52?=
 =?utf-8?B?UXFRMWJ5YXlXMnJKRlhtYjNqNTNnUlRwK3JLZlk3NkNVc0Y0d25ITjE0RnlO?=
 =?utf-8?B?cStqbHVSdVg4NDF6Q3kyS0cwblhwZ1hFcENuYW9PQkpURFBIT1RHcUtwQWlr?=
 =?utf-8?B?T3VEZmNkemhrelJCV2xycGd6QzZDWEFPWEk4Ty9kc2NXeDVCQnJCNXUyVFFr?=
 =?utf-8?B?dUUzaHpCRGIzTXhKQUpWaWljL0VqNUY3cU1jeTNkeGw0amRWUWl5dVFWWE9m?=
 =?utf-8?B?dXM1c3NNNHdEWUd0NDUydjFPaW8vdGxsbHRaUjB0Yy93TVdub1FzWHVNT0F3?=
 =?utf-8?B?SjlxeHo3NjdvY3dHRUF1MG45OGU5bDUvT2FVZzV0WHA3ZFl4RG5SVnVaR2R6?=
 =?utf-8?B?U0N0YzlVVmVkYTgvQTVCWTN3SytxNVJRQjhjRGFZb01WT21TZnprYXJTUTFl?=
 =?utf-8?B?Rzh5K0JVZktJUGV3L3Y3bkxBWXllY3YwSDRrTDExcGRHSUZsYVljTEZSVml0?=
 =?utf-8?B?bE1pZldCcGEwMngwQjJkc0tkbktKdDNQbmpvdDVmb0cxVjUxeDBhS0tBNE5T?=
 =?utf-8?B?Zk9hUlErcE9wOGFwdTZLWU1GT2x6RjR3Wk9wb2J1R2pZSDYwNE12VjNoc3ZU?=
 =?utf-8?B?RHR2RHQzenIxRUhlekdNY0R3VnB0WEdERFE3b3lWNXRBZUMwMXArblhmaWUz?=
 =?utf-8?B?ckR2d0lQQlpVUFNPbG9FWVhtZUl1Q1kwQ1kraXE5ZHBDM1lQa09oUzlVZWtH?=
 =?utf-8?B?dk9PNUxFcmhURUp4TGxwSU1hWG5qNkx5am5FdG8rZWdBRmpZYjdKd1J3Wkdu?=
 =?utf-8?B?Z3kzM0dSVjd1TDFpSkp3aWF6cytSWktVbFpuY3UvT3dEYVBwQk9Ra2Y0K3VK?=
 =?utf-8?B?cGFQTThBNFRpdEZoVGIwMXZDWFAzVFRsblFvNnRmS0RnMzJvMnhIU0I0Ti9Y?=
 =?utf-8?B?OFpnOGdCRU1wckhsV21BMTFrR1hvMitEdy92NUhxcmNRbGNadWhUZThHR3lt?=
 =?utf-8?B?NE82NXRibHk5alNBMmNRY3VFZDI4a3pTYzA0R2N5ZVQrbEF2OWNDWk1NVjYw?=
 =?utf-8?B?UVRqWEhTMmkrc0luUmsxeGxtV3FsQkJzZldoYW96WkN5ZGR0WkFvZXFNc3Ex?=
 =?utf-8?B?bDZIZmJUWDEycittL0FhM2xJY2tkYzAyM05XTENBaWtMeVJuV3NRenhKOXQw?=
 =?utf-8?B?K24yeTlWOFZhZUNtWW13UVdNbkMzczZGdUJqbnFlWis2djg3YXFHQzUxS29x?=
 =?utf-8?B?a1h3bE9LRC9LVGROU1ZJMzlBNEZwMnQ3RnJ6T0FqRllMbEFLOUt0amhwV0VW?=
 =?utf-8?B?Y3psV1lwU3V3bXllYXRLMlZGeC85VWJibEhIZmYzdnJYS0YrVWdML1F3TE9s?=
 =?utf-8?B?NFNJVWFSNzFYazVGcThEMVM0NmhYMVdQakg3SlNuaEFzZFNBbW1qQXN4bFBh?=
 =?utf-8?B?MThwUDZ1Slp6Z3ZRTm15TFY5dVNwdzMrV1kwUjNHblFDTVNnM0h5VGE0R3ZL?=
 =?utf-8?B?TjBBdisxemlqcWJmQUVGNzFJQWwrWkpLZnJHYkRySXBlUFN6TnRlUEVoYWl6?=
 =?utf-8?Q?+UQWCRfTbIK9vv90WGIqE8u8L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4c2799-b7e3-4113-f08f-08db7e470739
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 17:32:53.5074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DeIDwVFfSKPkWNqwunxQfqJtYEdrnN5RoALemITYrSywLnK3ERKniCyptF76dYOZXeHKJJuEvb2yXUQztaf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 06/07/2023 19:26, Alex Deucher wrote:
> On Thu, Jul 6, 2023 at 1:15 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>
>> On 06/07/2023 18:52, Alex Deucher wrote:
>>> On Thu, Jul 6, 2023 at 8:36 AM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> This patch adds new functions to map/unmap a usermode queue into
>>>> the FW, using the MES ring. As soon as this mapping is done, the
>>>> queue would  be considered ready to accept the workload.
>>>>
>>>> V1: Addressed review comments from Alex on the RFC patch series
>>>>       - Map/Unmap should be IP specific.
>>>> V2:
>>>>       Addressed review comments from Christian:
>>>>       - Fix the wptr_mc_addr calculation (moved into another patch)
>>>>       Addressed review comments from Alex:
>>>>       - Do not add fptrs for map/unmap
>>>>
>>>> V3: Integration with doorbell manager
>>>> V4: Rebase
>>>> V5: Use gfx_v11_0 for function names (Alex)
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 70 ++++++++++++++++++++++++++
>>>>    1 file changed, 70 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index 7d3b19e08bbb..b4a0f26a0e8c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -6491,6 +6491,65 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>>>>           .funcs = &gfx_v11_0_ip_funcs,
>>>>    };
>>>>
>>>> +static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                                 struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +       struct amdgpu_device *adev = uq_mgr->adev;
>>>> +       struct mes_remove_queue_input queue_input;
>>>> +       int r;
>>>> +
>>>> +       memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>>> +       queue_input.doorbell_offset = queue->doorbell_index;
>>>> +       queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>> +
>>>> +       amdgpu_mes_lock(&adev->mes);
>>>> +       r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>>> +       amdgpu_mes_unlock(&adev->mes);
>>>> +       if (r)
>>>> +               DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>>> +}
>>>> +
>>>> +static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                              struct amdgpu_usermode_queue *queue,
>>>> +                              struct amdgpu_mqd_prop *userq_props)
>>>> +{
>>>> +       struct amdgpu_device *adev = uq_mgr->adev;
>>>> +       struct mes_add_queue_input queue_input;
>>>> +       int r;
>>>> +
>>>> +       memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>>>> +
>>>> +       queue_input.process_va_start = 0;
>>>> +       queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
>>>> +       queue_input.process_quantum = 100000; /* 10ms */
>>>> +       queue_input.gang_quantum = 10000; /* 1ms */
>>>> +       queue_input.paging = false;
>>>> +
>>>> +       queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>> +       queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>>> +       queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>> +       queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>> Was there an option in the MQD to specify a priority?
>> I checked the gfx_v11_MQD structure and this MQD does have an option to
>> specify the priority of a queue (offset 134), but as we are re-using the
>> mqd_init function from gfx_v11_ip_funcs which sets this offset to 0 by
>> default, its not being used.
>>
>> We can add a parameter for queue priority and overwrite the init values.
>>
>> The priority which we are setting here in this function, is for queue
>> mapping using MES, and its the gang priority.
> Thinking about this more, the priority would come from the context.
> E.g., ctx->init_priority and ctx->override_priority (see
> amdgpu_ctx_init()).  We should take that into account when creating
> the queue.

In the current design, the userqueue is completely independent of the 
GFX ctx (we discussed this in V2 I think, and that's when we introduced 
the user_mgr). I agree that we should consider the queue priority, but 
we might have to get this parameter specifically from the mqd_user_in.


>
>>>    What about
>>> secure settings?  If not, we should validate those flags properly and
>>> return an error if they are not currently supported.
>>>> +
>>>> +       queue_input.process_id = queue->vm->pasid;
>>>> +       queue_input.queue_type = queue->queue_type;
>>>> +       queue_input.mqd_addr = queue->mqd.gpu_addr;
>>>> +       queue_input.wptr_addr = userq_props->wptr_gpu_addr;
>>>> +       queue_input.queue_size = userq_props->queue_size >> 2;
>>> Do we validate the size anywhere?
>> We are validating the whole structure/user_MQD size, but not
>> specifically queue size. But based on your suggestion on libDRM UAPI, we
>> are planing to add an USERQ_INFO_IOCTL in a separate patch series, which
>> will then introduce the IP based dynamic size checking, and also the
>> checks related to alignment and queue size.
> We just want to protect from userspace doing something crazy like
> making a 10M queue or something like that.  We should add an interface
> to query the sizes per IP, but we need to validate the inputs as well.

Agree, I will add this queue size validation check in this series 
itself, will cross check some other inputs as well.

- Shashank

>
> Alex
>
>> - Shashank
>>
>>>> +       queue_input.doorbell_offset = userq_props->doorbell_index;
>>>> +       queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>>> +
>>>> +       amdgpu_mes_lock(&adev->mes);
>>>> +       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>>> +       amdgpu_mes_unlock(&adev->mes);
>>>> +       if (r) {
>>>> +               DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>>> +               return r;
>>>> +       }
>>>> +
>>>> +       DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
>>>> +       return 0;
>>>> +}
>>>> +
>>>>    static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>>                                                 struct amdgpu_usermode_queue *queue)
>>>>    {
>>>> @@ -6601,8 +6660,18 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>>>                   goto free_mqd;
>>>>           }
>>>>
>>>> +       /* Map userqueue into FW using MES */
>>>> +       r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
>>>> +       if (r) {
>>>> +               DRM_ERROR("Failed to init MQD\n");
>>>> +               goto free_ctx;
>>>> +       }
>>>> +
>>>>           return 0;
>>>>
>>>> +free_ctx:
>>>> +       gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>>>> +
>>>>    free_mqd:
>>>>           amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
>>>>           return r;
>>>> @@ -6613,6 +6682,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
>>>>    {
>>>>           struct amdgpu_userq_obj *mqd = &queue->mqd;
>>>>
>>>> +       gfx_v11_0_userq_unmap(uq_mgr, queue);
>>>>           gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>>>>           amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>>>>    }
>>>> --
>>>> 2.40.1
>>>>
