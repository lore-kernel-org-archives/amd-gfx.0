Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51203EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 09:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98FE10E069;
	Wed, 21 Jun 2023 09:25:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6881F10E069
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 09:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/I9h3b8zU8aJ1GwOrbBZW8U/jYcYx0SIuUF1/JJB0bWVXauokbTnjDicnzMojmvdffEBlC37R2Hn8v409fR9BZyjt81gj+0p8d7qRMadTRnAa/0Ybk+n1CfCOk0skTDDMEry08kTuTv2gUDUHfir9wpnaEEgsMqz5QF+mt6lO5bw86sAH5l8CRTzz/O+o9k9Ud7u5u5pMisZxtlAGxQA9BXRbBQ6xcbVmTroDNGy4NV1K69MpofnQQqmz1wXHWh8Jbq0T3LOb3DdaI4e/y6pAW59YrmeLR6NFZ+/YOsp5M+okyoIzgHBUJNSnjlMG0odeX/lWyZ+nWskT9K7VpRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDgefmoSOT6Kws5eDSHbfYlOlmG+iitepgrNEoFcGUI=;
 b=H7lQ9IMQb79N/ZRJGUBj7DmMoD6MgZfTG/f3IrVY4cWgHYTXuO9Vqe7QW+5TuT5PSquY/AKXxf2kBuUpzXTUWF2b1IDdCzcM7Ih3YchMlSSwbM20PoPt0iBZV8xFAstspGF2RFRCMfV5yRjZVGH2PcPFthiBWyBK4icc1QvO09wa71uJ8DNJPg/Rmp1Hatm795roBFodW8jFK7fK00E2Sme78IzX/8wz3oCg5Gfgv+jBPZBI3QW6EPcUbehXbQgjMhUiBzcOsIeOHW0xiqwqb6r+hCKAYJuEo468/m3jpHMApbMDUd2P7ir2o/LNwpkiuWR/6DUGxZM/xePPULEGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDgefmoSOT6Kws5eDSHbfYlOlmG+iitepgrNEoFcGUI=;
 b=ph7uL31ZZUkdwY7kIrWeLkQJBNoIWJafnQKQGykU3WxgzSmRr3wBHJW3bpEdi3RDyENBK7KS+uYXmpfYLlZvYSgTAHN3+WqsgZygikJgAzhBbqBavuRvTKe5SUEgorynciNzZZP3fkSwB+Qj/Eor/G+RbHhPnhV482qoojLZm9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 09:24:56 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 09:24:56 +0000
Message-ID: <9a0247c6-9d23-1a67-2070-1f3454a71b06@amd.com>
Date: Wed, 21 Jun 2023 11:24:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 06/12] drm/amdgpu: create kernel doorbell pages
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-1-shashank.sharma@amd.com>
 <20230620171608.2131-7-shashank.sharma@amd.com>
 <a794a151-dec5-436e-fd92-c9e49b3c744e@amd.com>
 <37bae5be-b806-31c6-28f2-28c31b414dc6@amd.com>
 <4016ac35-e33b-64de-fb15-826240044d12@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <4016ac35-e33b-64de-fb15-826240044d12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d4bdd6-1fb7-4a05-ef0d-08db72396069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyTcjnu+QNoUI9mpId2I/7jJhf2L3MLTlTt8xM9AmmJIZ3T+BoOjpJGffZMOM3sluS6kyPz7OkALacI+tuON1AlmCU3s4OxQZRpr2VbNHruH+/WWywoJVfFb6XhQJNDJZ3dD1e4kzaKMMTM6Ms0L3zRR+oOXqs5mxfEEwWuvehuVqKGdEzBwu6zeUqKxbrR/xGJa7il4Tokiw8d0SKJGMfUfiGvb6grhg+QHCixw2Euuc15EkHcDNAIU7N7s3a0pZsVKNMwyTN4nKqvOde66xkEAs9GOBSiAA2FZYtlD90TRGpwP4hQmrC7q+SO9LWm2vNuMFnrOxIhY6lVcAdkVaw96jWHO46Rp+ha9N781k3FMsmWQOdA04jUPa8ELuOFkOC9gntt0B1vVWLjCj3e4eAyY2HomBkEeN6MdVSSsiDeZbxUEHKnQDxUksQBNVX4s4ibJctopw8BwS2TtmIP0bksB9Wl19RUZ384MWOv+RZ3cCPYMdBw9EfA60P4SM/HVZ3z7ekpxExN9xJFcHNaAqdH8NMr9h4O2x+FN/MVsaSabRO1LRcmkw4TPvQE2K92fzf+OfAZICsmUYCAr5l59EAks7hSxg5sLI4JmRSqPddlA6SAl1T3Eh+mpmGTD4qNTVpVEdbaOiqN1MQb+hgw6kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(83380400001)(66574015)(2906002)(2616005)(186003)(6512007)(66476007)(66556008)(66946007)(6666004)(4326008)(316002)(26005)(478600001)(5660300002)(6506007)(44832011)(8936002)(53546011)(6486002)(41300700001)(8676002)(38100700002)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdlanpod1RuMC9iR0RMZlJzZ1ZVQ0l3WXY5SDJmcjVna2VSY0U2Y2ltS3p4?=
 =?utf-8?B?b1M5bzhkZW5Rb2xvczlzSTZlUTFvRFQvOVF0c0IzWEZ4a28za1NzSjdzcHdm?=
 =?utf-8?B?U1hvQ0I3Y2ZLSjNpZW5mdHJ5SENZb2RlWnNsWmpHUjV6Umw5RnpUN1JZM0V2?=
 =?utf-8?B?NG1vNHlUcC8xME5hQlE5a29FSUtHVkZqMmxQdlNtVWlaTWlvUnczeDBsb1hM?=
 =?utf-8?B?MHl6NCtmRTY1WHJnZlJVVDkycWl1MldMcTc1bVFtbUpodGRYK0ZtdFJWcWRY?=
 =?utf-8?B?THBUR1FSb1laaEpqSlhSd1hxUU43U2RNVjVZcjJURE5jVlYyNThScEg2dHhy?=
 =?utf-8?B?TFJkSlhLZEF3UHZSZWxWbzZVOHlFWWtNNUNJQjMwQTl1dExwSCt4S05MVWdw?=
 =?utf-8?B?RmNicDVSTm9BcUc5SGRzblNmRDlRbGliSk5MVUUwSmtmem1GaWxiM3pyY3lh?=
 =?utf-8?B?NTlLd1d6TDl4NVhaaVNOQURPV05qcG50ZWQrM0owcjdxdXNCSWEwNmpCa1dY?=
 =?utf-8?B?Ukt5Q2QyWmN4MkJDZUNPTHQrRFhLTnJQNUI0MnRQdGlMY0pYZG10b0MzZnU2?=
 =?utf-8?B?aWxSVEJiczE0WkthRXptdTBHQUlZVHJ1N0ppQWJ5TWpKczZpdWF3UVNpRzVr?=
 =?utf-8?B?OFFyVVlBU3Bzb3RpWEpzTm14ZUg4VWVyUWhNRUdKb2RlL2lpRVpzaFIwblVM?=
 =?utf-8?B?SmpzTngraThmRFduTVg4bSsvdklwUmNyUWtZQUZMRHdkVWFUOFh2aTltS0Ez?=
 =?utf-8?B?bHdKNXFjYnJadXp2dnpVY0F1RWg4VDhsZncwVy9GaHNNeHQzNC9McUVKejBm?=
 =?utf-8?B?aWVGSFB3OVVhWmRhMjFmRTVIdlN1UVpwaE95bjNIaFVPVzlLY0IzMWU5UHZE?=
 =?utf-8?B?bjdHaW5GaHBPbG1YL3VkMUdhd0JJdlZ5MnBLZU9UZTlaWk5SelM4ZzRURkx5?=
 =?utf-8?B?WllNckNrYkM3eHhtSXRpWElKNHlEb3ZMMnZPSVdIT0RPYU1EUGQySGU3Q1JZ?=
 =?utf-8?B?Q3lpOEE1NHVFUmw0VFRTdmMwa2h4eEcyejVWTE9TUG50LzN4ZGl2dmt4clQ0?=
 =?utf-8?B?TmMyMGE1UWF1Zm9nOXdReHpuR0diQVdubWdCd0FSUWowM0VDandiZzdoNnpW?=
 =?utf-8?B?N2RLWGVvTmtBWndXZGZmUmZuYUNUS2NNbzI0OWhxYk9FRkUwSmkzWkY2RDBT?=
 =?utf-8?B?ZldMb2ZCVTdQM0MxbTVjRUhhMThYd2Jpc3k5NGwwTG9HMHhlRVlmeGNYU29E?=
 =?utf-8?B?T3EvQSsvL1VVR0g5QUVoUEdqcndhL1BRdmpxQUlzbFdIR1l6b05vNFl1a1NE?=
 =?utf-8?B?ODRWL3JIeWEyNi84SGZyYzdNZE5abWRUMU5CYUlhOW5PYjhYY3ZhZ0Nyampy?=
 =?utf-8?B?cjliL3RkTE90UmlNNzAyZTJRQnA1ZUNLTTIrZXZ0bjNGeFFyK2lIOE1OUlNj?=
 =?utf-8?B?WnM5eTQ1NmZtMStnN3dteHVleEY2ZXUvQ0hXZE10YjFESlZWYXAxWG1LN3ZB?=
 =?utf-8?B?cDNBNHpBd3VTMHVuVDF3eWhKRVgreFQzSTY3TUpoNWp0ckYyeUdwN0FUZkxE?=
 =?utf-8?B?M21UYU9yWkdQL2tKOFl5OXFjQ2FHdnFsSGtrTjZ6MVlpWnVHTGU4RkJCdjBH?=
 =?utf-8?B?cCtSajRmN0Qwbkt1c0JjUnM0eWppSFFxS0hUNVlCcVExakVveHU1UUhmTXhi?=
 =?utf-8?B?M3FqbHpMWjdNWFBxYmdVSlZGa3YrL2t6U3AwREsxb2loTFJoZWhtUkdBa2J3?=
 =?utf-8?B?eDJpNUZGb0hwODIxVmtuU3YyR2ozdVJCcHVyNld6bmhKS3lJajJDa3NTR1dK?=
 =?utf-8?B?UTVUdGVsTjA1eU1MSnRhYUduZEJ4ZForVTRSTXp4TDVmZDFSelVQU0FwY1dy?=
 =?utf-8?B?d3RTdGZQVG1oWEtQb1h0Z1lsMklGL0dHMmpVUFFBako1U3gwbkdSdHJ0N1d0?=
 =?utf-8?B?NklRVHJJcnBLQWMxRkQ5Q0V4UXUvc3dqeHFTL1dmVEVIVmE5S0dXck1xa2U2?=
 =?utf-8?B?ZDNhVjU4SjdsMk4xdTZ3NXpkRVpacm5xWllwVlJ4bVlkd2RER1BnSTlySFk5?=
 =?utf-8?B?NU9FQzdmUEo5U1RaNEF4bHVFQVNtL0lSSXA4blQwVmlaNUFiTitjMVZ5SVdr?=
 =?utf-8?Q?YjSH1V6y4YygrH3zY55/fjYWp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d4bdd6-1fb7-4a05-ef0d-08db72396069
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 09:24:56.0670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiRJzZejPz1UpKxU4yzbQ8LD0zO386BA5Hzoboz+YC0ntxrx/deNnPokDV89MYCAK3lp8FsWoSO1Qtl8G4wTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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


On 21/06/2023 11:13, Christian König wrote:
>
>
> Am 21.06.23 um 11:10 schrieb Shashank Sharma:
>> Hey Christian,
>>
>> On 21/06/2023 10:32, Christian König wrote:
>>> Am 20.06.23 um 19:16 schrieb Shashank Sharma:
>>>> This patch:
>>>> - creates a doorbell page for graphics driver usages.
>>>> - adds a few new varlables in adev->doorbell structure to
>>>>    keep track of kernel's doorbell-bo.
>>>> - removes the adev->doorbell.ptr variable, replaces it with
>>>>    kernel-doorbell-bo's cpu address.
>>>>
>>>> V2: - Create doorbell BO directly, no wrappe functions (Alex)
>>>>      - no additional doorbell structure (Alex, Christian)
>>>>      - Use doorbell_cpu_ptr, remove ioremap (Christian, Alex)
>>>>      - Allocate one extra page of doorbells for MES (Alex)
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  8 ++-
>>>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 56 
>>>> ++++++++++++++-----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
>>>>   4 files changed, 60 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> index 783e2b8b086c..002899edb9d7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>> @@ -31,10 +31,15 @@ struct amdgpu_doorbell {
>>>>       /* doorbell mmio */
>>>>       resource_size_t        base;
>>>>       resource_size_t        size;
>>>> -    u32 __iomem        *ptr;
>>>>         /* Number of doorbells reserved for amdgpu kernel driver */
>>>>       u32 num_kernel_doorbells;
>>>> +
>>>> +    /* Kernel doorbells */
>>>> +    struct amdgpu_bo *kernel_doorbells;
>>>> +
>>>> +    /* For CPU access of doorbells */
>>>> +    uint32_t *cpu_addr;
>>>>   };
>>>>     /* Reserved doorbells for amdgpu (including multimedia).
>>>> @@ -311,6 +316,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>>>> *adev, u32 index, u64 v);
>>>>    */
>>>>   int amdgpu_doorbell_init(struct amdgpu_device *adev);
>>>>   void amdgpu_doorbell_fini(struct amdgpu_device *adev);
>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>> *adev);
>>>>     #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), 
>>>> (v))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> index eb113e38f5e9..118f4bed32fd 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>> @@ -39,7 +39,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device 
>>>> *adev, u32 index)
>>>>           return 0;
>>>>         if (index < adev->doorbell.num_kernel_doorbells)
>>>> -        return readl(adev->doorbell.ptr + index);
>>>> +        return readl(adev->doorbell.cpu_addr + index);
>>>>         DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>>>> index);
>>>>       return 0;
>>>> @@ -61,7 +61,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device 
>>>> *adev, u32 index, u32 v)
>>>>           return;
>>>>         if (index < adev->doorbell.num_kernel_doorbells)
>>>> -        writel(v, adev->doorbell.ptr + index);
>>>> +        writel(v, adev->doorbell.cpu_addr + index);
>>>>       else
>>>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>>>> index);
>>>>   }
>>>> @@ -81,7 +81,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device 
>>>> *adev, u32 index)
>>>>           return 0;
>>>>         if (index < adev->doorbell.num_kernel_doorbells)
>>>> -        return atomic64_read((atomic64_t *)(adev->doorbell.ptr + 
>>>> index));
>>>> +        return atomic64_read((atomic64_t 
>>>> *)(adev->doorbell.cpu_addr + index));
>>>>         DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>>>> index);
>>>>       return 0;
>>>> @@ -103,11 +103,47 @@ void amdgpu_mm_wdoorbell64(struct 
>>>> amdgpu_device *adev, u32 index, u64 v)
>>>>           return;
>>>>         if (index < adev->doorbell.num_kernel_doorbells)
>>>> -        atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>>> +        atomic64_set((atomic64_t *)(adev->doorbell.cpu_addr + 
>>>> index), v);
>>>>       else
>>>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>>>> index);
>>>>   }
>>>>   +/**
>>>> + * amdgpu_doorbell_create_kernel_doorbells - Create kernel 
>>>> doorbells for graphics
>>>> + *
>>>> + * @adev: amdgpu_device pointer
>>>> + *
>>>> + * Creates doorbells for graphics driver usages.
>>>> + * returns 0 on success, error otherwise.
>>>> + */
>>>> +int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device 
>>>> *adev)
>>>> +{
>>>> +    int r;
>>>> +    int size;
>>>> +
>>>> +    /* Reserve first num_kernel_doorbells (page-aligned) for 
>>>> kernel ops */
>>>> +    size = ALIGN(adev->doorbell.num_kernel_doorbells * 
>>>> sizeof(u32), PAGE_SIZE);
>>>> +
>>>> +    /* Allocate an extra page for MES kernel usages (ring test) */
>>>> +    adev->mes.db_start_dw_offset = size / sizeof(u32);
>>>> +    size += PAGE_SIZE;
>>>
>>> This is initialized but not used, so I suspect it will temporary 
>>> break the MES test? Or is the MES just implicitly using the correct 
>>> offset somehow?
>>
>> I am not sure if I understand this comment properly, can you please 
>> elaborate ?
>>
>> If you are talking about 'size', its just used below while creating 
>> the doorbell BO.
>>
>> If you mean adev->mes.db_start_dw_offset, its being used in 
>> amdgpu_mes_kernel_doorbell_get/free and amdgpu_mes_doorbell_init
>
> I was talking about adev->mes.db_start_dw_offset. But using this in 
> amdgpu_mes_kernel_doorbell_get/free comes in a later patch, doesn't 
> it? If yes, doesn't that break the MES test?
>
Ah, I get it now, and you are right, I though it would be better for 
reviewer to see all KGD kernel level pages being created in the same 
patch, but now I feel it would have been far better to do this in MES 
kernel specific patch.

I will move this code in MES kernel doorbells page.

- Shashank

> Christian.
>
>>
>> So both of the variables are being used.
>>
>> - Shashank
>>
>>>
>>> Apart from that it looks good to me,
>>> Christian.
>>>
>>>> +
>>>> +    r = amdgpu_bo_create_kernel(adev,
>>>> +                    size,
>>>> +                    PAGE_SIZE,
>>>> +                    AMDGPU_GEM_DOMAIN_DOORBELL,
>>>> + &adev->doorbell.kernel_doorbells,
>>>> +                    NULL,
>>>> +                    (void **)&adev->doorbell.cpu_addr);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", 
>>>> r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    adev->doorbell.num_kernel_doorbells = size / sizeof(u32);
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   /*
>>>>    * GPU doorbell aperture helpers function.
>>>>    */
>>>> @@ -127,7 +163,6 @@ int amdgpu_doorbell_init(struct amdgpu_device 
>>>> *adev)
>>>>           adev->doorbell.base = 0;
>>>>           adev->doorbell.size = 0;
>>>>           adev->doorbell.num_kernel_doorbells = 0;
>>>> -        adev->doorbell.ptr = NULL;
>>>>           return 0;
>>>>       }
>>>>   @@ -156,12 +191,6 @@ int amdgpu_doorbell_init(struct 
>>>> amdgpu_device *adev)
>>>>       if (adev->asic_type >= CHIP_VEGA10)
>>>>           adev->doorbell.num_kernel_doorbells += 0x400;
>>>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>>>> -                     adev->doorbell.num_kernel_doorbells *
>>>> -                     sizeof(u32));
>>>> -    if (adev->doorbell.ptr == NULL)
>>>> -        return -ENOMEM;
>>>> -
>>>>       return 0;
>>>>   }
>>>>   @@ -174,6 +203,7 @@ int amdgpu_doorbell_init(struct amdgpu_device 
>>>> *adev)
>>>>    */
>>>>   void amdgpu_doorbell_fini(struct amdgpu_device *adev)
>>>>   {
>>>> -    iounmap(adev->doorbell.ptr);
>>>> -    adev->doorbell.ptr = NULL;
>>>> + amdgpu_bo_free_kernel(&adev->doorbell.kernel_doorbells,
>>>> +                  NULL,
>>>> +                  (void **)&adev->doorbell.cpu_addr);
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> index 547ec35691fa..a403418d5eac 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> @@ -128,6 +128,9 @@ struct amdgpu_mes {
>>>>       int                             (*kiq_hw_init)(struct 
>>>> amdgpu_device *adev);
>>>>       int                             (*kiq_hw_fini)(struct 
>>>> amdgpu_device *adev);
>>>>   +    /* MES doorbells */
>>>> +    uint32_t            db_start_dw_offset;
>>>> +
>>>>       /* ip specific functions */
>>>>       const struct amdgpu_mes_funcs   *funcs;
>>>>   };
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 6d1587bbda52..c48e97646541 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -1854,6 +1854,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>           return r;
>>>>       }
>>>>   +    /* Create a boorbell page for kernel usages */
>>>> +    r = amdgpu_doorbell_create_kernel_doorbells(adev);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to initialize kernel doorbells.\n");
>>>> +        return r;
>>>> +    }
>>>> +
>>>>       /* Initialize preemptible memory pool */
>>>>       r = amdgpu_preempt_mgr_init(adev);
>>>>       if (r) {
>>>
>
