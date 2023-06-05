Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35676C7EE24
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 15:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA61210E067;
	Mon,  5 Jun 2023 15:13:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F115610E067
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 15:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENvQS0eo4+dyNIX/jr3T+HX8/466uet9O3Hth5+TiirTqIdInTLQHWUo95pWGYCRAeVqrU/qulvfvINtrDpHned5LcItdqOBUGZ2V7rrJklk+zhUFzNy0lZkzSQfvAJM0eIRqLNeU4EvHP5sFyF/Q6NLpRnsmT+3MT8AGZ6G6NR6HefK+htuUQR1kwl/QHXXHGnjSkrWVbwOTzJvG0+z9RSt5u60oy+b8XI2rF7M1TX68gxD+V7GqDtNGjgsNgI9LUKArnt3mBOddtsQmu1yAgt+wELDlZUTuuHEDh/QWQsyYB37mw7Ua3d6nrr+FuswpdBE97UQRlJd1h7xQEE4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yOF7KP3QTvICrooYXzS2JFGP+CqYps5FhsOXAds0hc=;
 b=HkPNvTJQg4zeuQgyXvtUgj0GKzc3CbvBPE0gNyFqbxFbmSLT6TkXBHAvTTdPpD68PU6C4jC2UBHjDbFOzPz2W/6+GEL6wUhyxLVMNKMfsS1zbFW3YmmJOT8+JvrRKxlfxy7TUcIj22W+AXHZ5n3Nu2CSjjOtatqyTbXZFZkl/AyE/hFBwehr2L/Tu3VX2nopsk0d+gTyLLV0OrCpGN+ddYvmlPD99+LHFK5UPc2AAJcAzEet4+SOigw8jpGQnMq4JhBPAd/CJUOEBA9X0S7G505TxXBUxe8XRkNXDK59efXLCA11j0YLQ9LMeJBnKfBhZkAD/9eQkBs+NjLvb+hHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yOF7KP3QTvICrooYXzS2JFGP+CqYps5FhsOXAds0hc=;
 b=Wd0FFWj9diRt8nDx/4eG3I6rWKpl2rvVrzitzmbt0lL+WE/Fs/8bBs1zTJyy5Fc2Gl+x4SZakqpsMFAwmnVL/FHlxy+z/l8YfbnVcgNQdJXeBEFojIkumiPuzoijj104VQa8T7epqRUsMLfeIu0UicKqowSV/FTavCmrQYlSeiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:13:17 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 15:13:16 +0000
Message-ID: <4e390c3e-b63a-8fbf-8988-2d8bed0688b8@amd.com>
Date: Mon, 5 Jun 2023 17:13:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush
 tlb
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-3-Philip.Yang@amd.com>
 <90a3ac90-4091-4542-89c2-778230d265a5@amd.com>
 <a521c410-787c-d235-f911-e34a9cd01640@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <a521c410-787c-d235-f911-e34a9cd01640@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0473.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7f::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: e80c972c-7b93-4af6-1e58-08db65d76312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XnWrf9RryPml2rE39Ii+LcveZBZ6MgH+TamFevB0SbVRPPiYuhUh4RmpalHZQmUwjtjyDdsxQvRIH7krKqoMYgxe33sQdQv8qnrV7wjkRrFCTi+UnMrPyztN7n/xUzRof6cgnHSLnyyeaeGT9km/gkf7qd3zHdYIJt/wTM7oi74zy4/qKNOLMLOUV5ghFZVUXPP9Epzpc+lQ41uaJYr8PvnBqRf0vRmF7H7xQiTVTuFaL89/PeTXywKvBraP6isoP1KXcohPu7GDeZhxMRirPt43SrQpM1Vj14G7pNrBBpxCCtfakN4PpMixUNxUVAtO6U2w7a1tFpM1aE+fCi0A9HlwsWuIuWh28adEOodzUZleZ+2Euj/JB8d4JB1ungACKMs99E24oSkRiS8v2oRiMPVyu7ryQVq9/gZsXeoFxMSJzHscJvRJEPbW6nDi6DszflqjBNVq5R+i0CVTZvvXn7EDdQxlb+0/8vpFrTan+oHYp3hO8J/pA+aPMgpAv5ALE6K9Av13/hbOyKhGpPFuV/xSnoO+fOKYREMATrEUZ86//YlbZM/a2liYl0txdrc7Xhpn/JCycL76RJnoIaWp9tSR2iHkgnLDagPpA0QA6ix27m1DVGCQgsPzEvGJsJpQ68QDyLsFwn3Gk7v/11tGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(41300700001)(316002)(110136005)(44832011)(5660300002)(2906002)(6636002)(66946007)(66556008)(66476007)(31686004)(8676002)(8936002)(478600001)(6666004)(6486002)(31696002)(86362001)(186003)(36756003)(2616005)(38100700002)(53546011)(26005)(66574015)(6512007)(6506007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V05Ha25MYlBaSjBhbmo1TGNyOVIxMi94bWdZVUZvOElFS2RYOWd4N0d5bVNw?=
 =?utf-8?B?ZitIVDVObFg4VTZyaTdSNE1Ub3lTZlRGa1Q4Ynlna0ZCaVNuRHArT3NqQzYz?=
 =?utf-8?B?dTZsK2hPSlNaaGhUdGpmQjZWS1oybWJia1M5RGErZWlTanlNL0Eyemo4bDJa?=
 =?utf-8?B?WFduWHZCSXY3WCs4L0xpODFibitlMnJNN1ZIbllkbmZJZDBMSkdQVThveGtj?=
 =?utf-8?B?SEhnS2wreFFnNStad2JMaUxUQnJxYmczdnFtVmpsT2QvUEpGUTkyZWRKRUVs?=
 =?utf-8?B?Nm5DdzRUaGhocXh4Z2dreEx5QkJHaXBtM3FIMGtoMHMyK3FWeTZOOXlESi8x?=
 =?utf-8?B?aUV0VHIyWDAvK0hkZHdnUlU3aU9RTzhBOG1wS1g3blgzdUJha2NGeGtUWmF3?=
 =?utf-8?B?TGl2d3FiWTl3TzJZVk05Qmt1VDNKd202b0xOeWwxMU94bHhKVFZoTVk0WDNw?=
 =?utf-8?B?cW1Nc3BIak9KdXFGVWdJV2hnZDFRYWNuWGhqWUZtWnhHYm5oMTIwbkNnYTli?=
 =?utf-8?B?T2JrWmlXSE5WOXQwZk9mNVh0VFBqMTZzd25vR3NkL0R0cXlZUkVvTWVVNmRP?=
 =?utf-8?B?MHIxVU1MSmJKd3Nva2kyQ1I3SVI2RktoOW9mZmdIZitQTWM3cjVyM1JPWmNy?=
 =?utf-8?B?b0NtVW1FK08reWMrTlY1MWREdWQyTnoxSCtPYzRXVTNpS25zM09XSDEyamZa?=
 =?utf-8?B?YXo0enhYdllqS2F0b0FvNGVFOXNWdURNOUJrdTFvVzFnQm5BUVFoOGJhWEl3?=
 =?utf-8?B?NmJVSDJNYkVwQmk4SC9TcEdDYTB1YTJ3RE1tcmxwVUU0RXZkNGNIUGgxblov?=
 =?utf-8?B?eUVmR2M0elNhcGZHc1l5NldibEVVRWI2QmVNTDRoQjBaM2ozWW4zdDZGWVVO?=
 =?utf-8?B?Qk9LSDZqTlpTd2pnZW9FY3JlOUVEcWlhbDMzcnpKMW5pTWdlcUIrbHRYa2tu?=
 =?utf-8?B?ZFhNQ3Z2WStXbGhFc3RZV0NRSERSOUNuaFM1Tk9iRGdlQXJpRTBZLysxYy96?=
 =?utf-8?B?cEI4VUR5TGVMV0h3VTZMMU90WWExb3ZLc0ZBaEErU1Bvc1hLSC9FcW51Z2xk?=
 =?utf-8?B?a3BrekNGQzJOTzhoUnVlbnBFY29QcUFWU21sZ1VrT05JUUNmcjZyOVNyUGI3?=
 =?utf-8?B?V1RFSDhzNEw4N0V5dUV4YzZIdWgzdFlORFZ2cVdHbnFRVytDcDFhY0Fibzlr?=
 =?utf-8?B?ZHhWZGYyclBSU2VTMUkzeFZGOEFHZjE1OWJiemhRMEN0TW5zaEhwM3RKays4?=
 =?utf-8?B?alFrcUlwclZlWnBmNWt2cEd4Sk1WUlpGUG9KZjgyZStkQlhYRzFJbnYxZnFX?=
 =?utf-8?B?YmtqVXA4OHN2YnlaL04yYTJ0OFlQU3VTZzN1K0I5a0w0L25QaFRsTGJhek5q?=
 =?utf-8?B?WGlFV2x0MURHVHdRS2w5SVdQQkdzMnFxTzdiQjJVRE01Nm5TSk9xVWtBMXVQ?=
 =?utf-8?B?TDFpaFpMUEZiT29GVjFlOFlEdHhIQTRuNksvZm5GUTlvVnRwQU1RZnd0UmNq?=
 =?utf-8?B?NklJZVkwRUpCOGNlTjdVa05wZzdDSUduUmdscytMdGRzMEZ4ZXoxZmJNZHYr?=
 =?utf-8?B?VWtJVjVGTExkUWtVdHIzMHRCY2RtSW14ZFkxMjVjUEI5NUp0d0J0L1V2ejZK?=
 =?utf-8?B?QSt6b09XQXg1TC93clB0UE1yN3RnNitYczA0SnhuVGpHMllGTlFOM0NqVExJ?=
 =?utf-8?B?MXI0ajkyOGloRWlhRE14b045bzAvVFVONnp4ZXd1WG42SE0vS214c3NKQ2Vj?=
 =?utf-8?B?eXZsR1ViSXVQWHoxcFRXWXJkb0JIWjZtQnBlcXFsKzd5OGI4TXdoZENtOGJC?=
 =?utf-8?B?bXNxNUdYTythWXNWSW9odmZmWVBaWG4yT1gxN1ZMUHVVckQ1Z0RLZlhMaDZk?=
 =?utf-8?B?L0R5TGE1QnR1cTFoMkJlUkVBaXlQNjhhL3VHRlJ0NXMrMXYvRVJFRFFUYThh?=
 =?utf-8?B?UnFwcXJIL1NWV0s2eVBDRzMrMlpnMWFycmVsMVRHcUZEbHJzZFRqZ05rODRt?=
 =?utf-8?B?UXNkVmJvUU9zNmw2L3VzeTNzSHBVNE94TE9LcENpYjdSb2orK1JwUkxmRnJC?=
 =?utf-8?B?RXlRdm4yNHVJT0lrT2w3YWVxWE85MHRnQ2poMG1qYk9RMzFWQ0tBWGdvdHdD?=
 =?utf-8?Q?T5XFu1ZM57absgUSL9zP1tZvi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80c972c-7b93-4af6-1e58-08db65d76312
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:13:16.2362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beBEd5CbSc7cDT3UWORxit6wiUgn6jqWAe5vDunOj0TdNasl4Q1qUPXWRytweJs6zgBrjF/Ekbq5qGP9CCRb5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
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


On 02/06/2023 16:54, Felix Kuehling wrote:
> Am 2023-06-02 um 07:57 schrieb Christian König:
>> Am 01.06.23 um 21:31 schrieb Philip Yang:
>>> To free page table BOs which are freed when updating page table, for
>>> example PTE BOs when PDE0 used as PTE.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index af0a4b5257cc..0ff007a74d03 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct kfd_process_device 
>>> *pdd, enum TLB_FLUSH_TYPE type)
>>>               amdgpu_amdkfd_flush_gpu_tlb_pasid(
>>>                   dev->adev, pdd->process->pasid, type, xcc);
>>>       }
>>> +
>>> +    /* Signal page table fence to free page table BOs */
>>> +    dma_fence_signal(vm->pt_fence);
>>
>> That's not something you can do here.
>>
>> Signaling a fence can never depend on anything except for hardware 
>> work. In other words dma_fence_signal() is supposed to be called only 
>> from interrupt context!
>
> We are signaling eviction fences from normal user context, too. There 
> is no practical way to put this into an interrupt handler when the TLB 
> flush is being done synchronously on a user thread. We have to do this 
> in such a context for user mode queues.


We are currently working on adding a provide a high level kernel API 
which can be called directly to perform a TLB flush. Internally this API 
will add a deferred work to use the SDMA engine to perform a GPU TLB 
flush work (to compensate for a HW bug in Navi Chips). If my 
understanding is right, by interrupt context Christian means to perform 
this flush and signal from that differed work, is that so @Christian ?

- Shashank

>
> Regards,
>   Felix
>
>
>>
>> What we can to is to put the TLB flushing into an irq worker or work 
>> item and let the signaling happen from there.
>>
>> Amar and Shashank are already working on this, I strongly suggest to 
>> sync up with them.
>>
>> Regards,
>> Christian.
>>
>>> +    dma_fence_put(vm->pt_fence);
>>> +    vm->pt_fence = amdgpu_pt_fence_create();
>>>   }
>>>     struct kfd_process_device *kfd_process_device_data_by_id(struct 
>>> kfd_process *p, uint32_t gpu_id)
>>
