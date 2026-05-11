Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C494CD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D643E10E0CC;
	Mon, 11 May 2026 13:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CMpFU6Qq";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7745E10E0CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeW2VRbs4nMInN8MlxSVK4Tq9OPgzGgcrdNmvIZimLzy4c7Ec+cpqDsxMICFZEjYduLkr7/jFzE62QXf5KH2YTaCh3sE+S/srGLhUM5v9oCXFhdzJapR3X2rXewB0AU0sKMiX+r6jPVB/oMge/0y+mtOlpjjiilPN3I2O/RtCJYVGf8SeO+v3g5iiII+zIGJlZYbDSJNQ7NhN3wL4e7XmsYuCWsGczogYK9fHD+F5N5eMBUu0jV1CE4gmrfVOiXB24cLCExlnT7OukNJ/j+hRCEamc19RBHf0lPE5Au6t6ymGhMEuF8RfAdXRnPYbLCm3cyoPjc//Z8X5pTTDbH4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX1i9cHHdK9KjmmgJCmO/gleWYPcbHexy/o1D+Mbfqg=;
 b=ECbxFapvm2fZKAQiGyHAdGjGOL7WqwTdaF9Z3NZBcSW0sWhxnDl2HZD/hXhosHro3ccnjymmu/Liq79LxpI9GMhYXMgrTb17KrLApFZQBj01gC6CC/UO7KzVUafghkroH4vphZ4AQ42pNXsoHT+TgPRvwDxKmL5WnV+wT2qA5tF5VUoP0M9W5SThN9Napkn2AiBgF6ZJPvDaeg17xKQEz5FGy02Ntr4fG1tl6cO2Sb5ymRy2o+rrb2Rg1QB5ZMvpSxS83znTcjh6QxXVvnfafXEQAPRWm2vvCzOImV8tPHADKKjNtZhBflknLlyvDQcmfD7DZvTyG1ToHJZ4yo2izA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX1i9cHHdK9KjmmgJCmO/gleWYPcbHexy/o1D+Mbfqg=;
 b=CMpFU6QqDKp9aodTfn2c98MKSAmqn5BS1+dFtgHcu/28oPigN+ePPKIkwce3POPWvU19uDrN75bUYKUfOExJ2TjkRDdS9qsOEYQKzBlAJb0IcsFx5B67rq+yMTneQIkOebEvtPskVwO8ggWSaDRzy/ApcHNBcvmH39PvhU3t9AI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 13:49:15 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:49:14 +0000
Message-ID: <7da40666-74f8-46f4-a887-90a7b77dec2a@amd.com>
Date: Mon, 11 May 2026 19:19:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: kfd vmid should start after vmid for
 gfx userqueues end
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260511091326.3111950-1-sunil.khatri@amd.com>
 <16837ea4-4501-4727-811b-430d50fc7b87@amd.com>
 <CADnq5_OwZV6YsoQn+BS3mRiBaAnWe7pbhm3xfELNH_8U-AEC8g@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_OwZV6YsoQn+BS3mRiBaAnWe7pbhm3xfELNH_8U-AEC8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0168.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::10) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b0c67f-4254-4023-760b-08deaf6416c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: cxJ4xllj7aWd2bzEqmMc+lOKVvAaFgIisETXxMFWGkkMKguIHfnRjP0++x4ht56UijVkaPDEikm0GMiHb933HLnRCRrilYnTpnOID32DeE6MNQ4yY0DKPnWHqW2nGXz53HZzpBf8K7l7Q8JmFQQ5zSbcG5t7NxSd0cOiVppB3so0DrR9LH4kxUkSFbsRlMf0WxB0UjtmHuJqYgeaUNwpp4tyF/dM7eqzTqYu+O/w35KMHjGiQZMsYXi4okUl/Md2bFu8CLj8OaBM1+CQndftsywOYX8lKhcNQJDMRwbaOwO4b8p2iBEZo+irE9zLNDS2z9jA5QlCO6632igYXiHDKCXZsugwzaMaYxIDzJnofZgU2UPqz0G93gvyl05Zw4wFb+cWSVySa178KEd//28KGxkAzvrfLUXqlLO1BusBqX0du4/NJxrVos7xlG32iDg/TI2r56gPeMywhb+1Otx4/GrymECQcQB65CJ2UMdusm24q7OYbYWKJfkDoZUoaGINNDLPKWPF4IzSP5In33X6b+xZBgN/4/52pz4CYcyNFUiKzIG+E7Ag0fV4u6DiksZM5dUBhO9WbsDkC/9y7s44/97CQwsyrWCM2fVLgX4pfD9TqHRtaTTGkMhCQ4RkqaZY+tnE+DWP2C9wyTHl2+0s7J7Yond8d6KXf8nBybM0lrifQd7A16WSZoQKvjKG7jar
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2ZtZTBSMVhwMm5jaVBDbkdXaUl2aHRNMThsSGFzZW1uTXk4NEFhUGJoK0ZY?=
 =?utf-8?B?b3N6Vkpob1N0M2JlUmFCOHlrMGRWcWQ5UDRiTXh1R1pucXdMOFUyV3E1d3Ba?=
 =?utf-8?B?cGJtUUoraG9SVFg5T0FHQ0xDRUg4VGVMRHhzUVh2TTJVZHJ1bFlDQ3A0a2F0?=
 =?utf-8?B?UGhVMG15VnJQeUhXM0JUY1Q0NktoRGdaK04yb0tBTUN5K2IyekxUZkt5dGpl?=
 =?utf-8?B?am80dlpRMm5RUVhZT0h2VzN4K1NTOWY5RFNvQ21oNEtmNVJYbmxCaG4vODdH?=
 =?utf-8?B?ZE1pUDlzTlZMY1FhUnZiTHNtRDh3WFNhTkxxNjBuemYwK0dOa2F3RnZMKzBs?=
 =?utf-8?B?TWZxV2x2MFIzMkV3YWxjNkdUTDErYm9RZjk4clpZa1JYelg4ZEdGclc1Q01L?=
 =?utf-8?B?amhqRHNRN0xQOGVzSGZ0OWt2ZWZ6NGxBQmpGczE5WHYxZEFGc0FOamJjK1pI?=
 =?utf-8?B?UXBtaTBhQnUxZkZiNXIyLzlvNVlmRGpPNG0zYmxRWWtheDZrckhvSFFxb25Q?=
 =?utf-8?B?VG5sdElMenBFUkFxK00yZWNzMUJMaHhKZWh5alBHY0tTaWJnMEY4Nk5ua0Er?=
 =?utf-8?B?YzBGeFJjbXBBalZXU05Ob1lLcm90aDBYemk0eTNhdldHR2E2a2ZxTWg2UFBi?=
 =?utf-8?B?ZWpHd0VzYU02VUZHVkZiNHNVNy9iaCtBTHdGZ2dYUEczRGd1V0hVZllaR0lh?=
 =?utf-8?B?TDhoMnZYU3hCdTVZOHM4UE9kaGZRVm44L1cwT1NWeTdCVlNSUWNyaEJPTWtM?=
 =?utf-8?B?TmJGTjNpTVFoWWpIZHMvT09Ha2dZOWlpVCt0dmRJQldUc1JhU3hncFYvRWJC?=
 =?utf-8?B?dHQ4cGNwZG84MDU4bTQ2LzlmWXJMV0Q2dHhtZE5vdkx3N0RYNnpFbUJja3l5?=
 =?utf-8?B?WWRocVBWb0JDQWJ1SjFESXU4eS8xMEpRbTNPTzdtZDR0RlArcDNGYW5CN0xk?=
 =?utf-8?B?LzV3Y04vYTNQVjZ5VFRJSWtUSjRPQVZCamY3cVJxV3V3RHNpU3libFQ0U29X?=
 =?utf-8?B?eFpUQkhFS1VrcUVNMWM3VWd6SFdEMEdJdWR2dy8ydDBXZldna1U0NlFtMy95?=
 =?utf-8?B?aEYxQ0FmVFBRMnRlcmg1NjJ2TmZrQnEvQ0ZudGdGSVk0Q2tSOUVBMy9ka2hH?=
 =?utf-8?B?dVhEbnFTWFhNMnpybndLeUxQY1R4OWl1eW9FWGt0YXNTclJ1NlEyOTIwZXRS?=
 =?utf-8?B?TWlhMHpWODZkNi9XeUdpdGlFMENXWFR3Zk9aTTE1S2VVS3pvcDBadk5vZkZn?=
 =?utf-8?B?cXJHQ1BlajlKbWFLQ1JqZ0tQY0ZUcDlENXdobzVVQzVGWUN2UFBpMGtDMFpE?=
 =?utf-8?B?KzdrMG5oak5kLzVyd1JFaEJadzZ3WjF6UFJYQi9YQUFuZ0x2cFpLZzQ4TG9l?=
 =?utf-8?B?d2t1MXVaRHZOVERuMmVVWGNxOTlUN2ZPRE1yNzJOMmpOTzJMVkdBSG00SmhE?=
 =?utf-8?B?VmpiM3JPVnZsYS81RDhielNHclp1NHBDc3JTMEJhRy83VWUyTGMrTThOWHVq?=
 =?utf-8?B?UGRIeEx0MjZOS1BRS3A1aGVsTW5CR2tTUXlTQkhlbW1QVDRlZ2MrRmEzcVRt?=
 =?utf-8?B?TzdkdmQwTGgyQldkYWhZMEtDVjJONGFKKzh0RjFVY3RhUDFVU0p1YzZKMDlN?=
 =?utf-8?B?YUZsTFdmL29icDJyMy9UeUtGUTk2WmM2YjI3MTdyVURiVnFUY1V5cGZ0ZHBr?=
 =?utf-8?B?VCtTRWZsbCt2c011SUFvc20wTzF5d2lNTllVQzU5WGlpWi9FVnRMeFUvY1Fx?=
 =?utf-8?B?K2tWei9URW4wajllNnFDM1JjSXNlRWszem00SFZSUzA0Q0hTV2loQkRRQlNZ?=
 =?utf-8?B?ZlZMMkZySTl0NjR4WmwrTEJha2J2elFrN3FhekhaWjZJSzhvc3RCM3loSzRy?=
 =?utf-8?B?UFlVdjRhN2Uza2NKdW9XMHNud3dDbTRXUnJGSHV6ZkZQV09rZnkwWHA0c1Yr?=
 =?utf-8?B?MjQ5WHh5ZDRadmIxK1hvZzBSSnJIL2oySEpkR1hFV2w4TXZ0bmtYYjdlV2dx?=
 =?utf-8?B?SE1RcHB2c0o3UndZcmpCUEY5TlZubjBzY2xHcVUxMGdmT3ZaV1MwNkdsaFhS?=
 =?utf-8?B?VFJHT2xlVi9GSUlIQ3FsbHFPU0RSK0dRMUgwV2pRZnpmd1RCS09TWEpoM2Jm?=
 =?utf-8?B?VnNsUHEzK21sR1RLcXJWNU9rWVllRGJrZTRkN3E4MzJwazJ6ZzZweno0dk5B?=
 =?utf-8?B?RklwcjdseGJKdzNNWUlyUThjRU40QkFYUDFHQXNlb1NJRStySml0dnZvR3B4?=
 =?utf-8?B?ckcza2dhQjd6SnQ1TjFBUGpPVWxiU2F1cnB0SEYwZHg1NEZSalVCVHgzV1Er?=
 =?utf-8?B?MVg0K0V0eldwSHFqTGFpQ0RuRk92RGl3c2VDNjN1a1M0RFF6USswdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b0c67f-4254-4023-760b-08deaf6416c7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:49:14.8358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgBKc4vXhYf3LcAud9QM8p0nUrAhFa+LHpnVh0XdfRTaKlYmm+9oBH4e/SIV4tBsKWHoQvVP80ITfJaxtU7csw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519
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


On 11-05-2026 07:14 pm, Alex Deucher wrote:
> On Mon, May 11, 2026 at 7:49 AM Christian König
> <christian.koenig@amd.com> wrote:
>> On 5/11/26 11:13, Sunil Khatri wrote:
>>> For GMC11, when KGD userqueues are enabled we should have vmid for
>>> kfd queues start after KGD userqueues VMID ends.
>>>
>>> Use the variable gfx.disable_uq instead of gfx_disable_kq to check
>>> if userqueues are enabled or not. For mode 1 even when kernel queue
>>> submission is enabled but userqueues is also enabled at same time.
>> Of hand that doesn't looks correct to me.
>>
>> On GFX11 adev->vm_manager.first_kfd_vmid is the first VMID the MES will use and that should 8 when kq are enabled independent of the graphics userq feature.
>>
> Right.  When kernel queues are disabled, all of the vmids (except 0)
> are available to the MES for userqs (KGD or KFD).
>
> Alex
Got it. Thanks Alex and Christian.

Actually we are getting KFD SQ interrupts while we are only using the 
KGD userqueues, probably some other issue here.

Regards
Sunil Khatri

>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index 16388e3caea3..354cf1c1b93c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -846,7 +846,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>         * amdgpu graphics/compute will use VMIDs 1-7
>>>         * amdkfd will use VMIDs 8-15
>>>         */
>>> -     adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
>>> +     adev->vm_manager.first_kfd_vmid = adev->gfx.disable_uq ? 1 : 8;
>>>
>>>        amdgpu_vm_manager_init(adev);
>>>
