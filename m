Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A1EC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 17:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5951410EA49;
	Wed, 17 Apr 2024 17:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UnBdKJYx";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B5310E6FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 17:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR/kx++o3mmCXXkcFILHtpwNNxwy/6auKLVjqq3QQLlb5ztz33lUzoLks4a8YPKactDs6Zig37lZY0cnxVRlWnVV4+E5RYgneJ4D6L6LlYqc4JTsNvFdCP71LcTmBIOJA2/UnL7OqLwzzUsk+y80Dvk72oVSGCU8vk8vo0j3EanTWMjFL3v0zEg6cBnvRht5h8leQvnBBlFOhg+tFZHNwfWLLYXd8qM+UPMcwRS/rAkOmNPhs1u+w7exwHmowyhR/Uejtr1K1CgQzYmMveFrpjtlMp0h958fjaPeqKpRXuQfdiuZCq4zq3hjC6pg462cG0jnENWL+3z1GkRV1Zpl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpZ1HJynWW8UJdxhub5SX6eMwi9ncKEiRWVedf8DHAo=;
 b=hO7/5INqovbL0biUe7lFjKpGO8EqhRaRFaL4V8uLfezu4gzyi9CUTWR9tdBnLlBj28+ilk+8B7iiCvrrokyo5IYoivBF9b0h96/iUgEu1BSe6PHidTefmGExC9Hi1d1WYf7LtXmO/2y7IjB3o3eBM1h6v0V7L1vgq6LLJLuDqCWO4O4PiTjnG99caduK1LrHye9irXOvca/t53E4QzbHxIjXSWuRrprmdMwC7rCohZaLx77/H8DJi1tRlWPISQrz/NtLvTScxytCwd+uR6f/MLZd1rA3V+6MJng+aGOEpWbuU7p23JjYuTj9nDEAFPJuwNRC+cYCbKnC/Tuew3sTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpZ1HJynWW8UJdxhub5SX6eMwi9ncKEiRWVedf8DHAo=;
 b=UnBdKJYxdNouhIJZ1xCtTy0RTwvlu2/uCWbG28uZB+c7tpytT88e2goRNbDOgOnhZB8B4yZN49EKwxBiDKLa+A6RV+BZL8lHTfiP99DU1WRTgf1JV/pVN6maY6abVoH0LeVBDbNLDhiAr03dnLAIiEWe9ekDBZfg9Xq8t3zKGVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 17:01:10 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:01:10 +0000
Message-ID: <83a9afb6-6a2a-40e4-a86b-4a0d373a0cfa@amd.com>
Date: Wed, 17 Apr 2024 22:31:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] drm/amdgpu: add support of gfx10 register dump
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240417093809.168002-1-sunil.khatri@amd.com>
 <20240417093809.168002-2-sunil.khatri@amd.com>
 <CADnq5_MkYKO5Z3LBRdJsTO0+Wf+YWVgUONTt5Y1Lrm+6SXJfTQ@mail.gmail.com>
 <fbf4f592-77db-4087-9dcb-3d9a49302164@amd.com>
 <07e86900-125f-457f-95b0-1f6d4a6e9598@amd.com>
 <DS0PR12MB7804D33979E4F1CF29AC8722970F2@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CADnq5_MQuZiRvTumvQVw6HxM7ZxQ25DPQbOc2aEu7Mxvm2RgNA@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_MQuZiRvTumvQVw6HxM7ZxQ25DPQbOc2aEu7Mxvm2RgNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: f85e266b-f5cf-43b2-48ea-08dc5efffaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJnYxvG6JAuJKS2YrnWk7Qq18mMG5rGeNLz9r2/Z0IYoUy5QZSLdruL0G5MEuuFkHqWS4rgh/yt5TnAAR9ah+7GQr2+PT+mTCjM3zXxVf0wiPQwabC8/R8eZ0Uw6puByZKx5PJuh7vMEI6i/Sa24AzBBU2G6UaoZ5PPD/RhmSM0kK5e1rF7z73TX8wh5uWRCDnWiGENhEXjQdjlUH2dL5QDfhkfkxnsTdYV+dUJfIDFw/qf2znfuLraHZYxBNIwx/99LIHtshUuzPPJ4ZSzgKzRcTRVj6OsGonsTNZ3lpntE83bt0ms8qDUB4iHYjWuX1bLsAEEXIqQklUM4lZIhSUSdMIhALqOGKeGd5YEROSwSU8SWUgKeAm52fq8UMoxwT9WS+n6sS9kENyTHXywDah+Cqja2mfLaRE2N+3wN5jQb8d23ITzxAzkt31/OfRuRHbGomtY2oEOnPZdGyqN7796mJoqt/A41TSRLHMTGy3XkgxGHgvin2Vsc8GG8Pi1OpKBjrkiRqJeTmQnXPiRKIawxUGnK88mzhMDbSRXxI+EFo9AJ+jT70QHPyGEu9C5nb6fpulSWKlyKzm5jwXEfK21m+GGuo3Q7zm68C++JAJ6stIlIsX73xECtpttDLuw6QXcV0bYr5VO2inJq4XnVK0p6aMCJ+P25Vpa09b9Z1KA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RFdWgvSEJGc25DUjN5eHdwbmd1THhsTjN1NnJHR0NXV05NRm8yWUVCMlBG?=
 =?utf-8?B?MEc5dllaeWJpWTNrcEdhcnhaSGxjQ25nd0FhOG4zVFlZaUVPY1I3R1B6YlZG?=
 =?utf-8?B?TGJrMG16NDl0V0s2RDVIT0dneGpnK0VUeEJTMDlrTGU3NXIyTDh1NlRFRXZC?=
 =?utf-8?B?Ulpyeno0SXVZWEpDS1d2b1ViSUhzaG5xb21lZjBoanpJMWxNOGVDTm1XRkN2?=
 =?utf-8?B?TlRmcm9NQ0tlYUh6RWswaUNwUHJXb1dkckFDdzBpSkoyeHo2aG1Oa3YvcStG?=
 =?utf-8?B?VUdKZitzTG1mRkg3U215NlJ5K0ZlWlkrL2VNbWtzVEdtRGxCajhWcnhwVlFr?=
 =?utf-8?B?bS9HdDN1RnZsVm1XSnlhU01SQjJBRzlFMm4vUVNwcXg1WS84bGpHUnlvbGc5?=
 =?utf-8?B?c25qZEVkVnU4L1pNWlo5cE1tM3FGRmpGbjIrRUMwWEI4eFZTajBjUU52UUMy?=
 =?utf-8?B?Y3c5enJHVE11cWN4dHozUWlOKzEwWlJreUQwUVZJb0pkR3l6Z3NSaHNKdW0x?=
 =?utf-8?B?d0Fja0gzdmJXYWZxVjlVOWxIdmpid1Q0WWJVSko5c0p0N3M5cW95M1g0UDFT?=
 =?utf-8?B?eUhGVm9WYzZLS1YwUUN6TFltTUE1UXBxQ2lVcFVUNm12UlVqV050Q0p6R1Fi?=
 =?utf-8?B?bVRlSGZHTW82UW5paG5BUDlhTlhJNFJsU2FkRVRzUG8rL0RhRnpjbU9nRms1?=
 =?utf-8?B?cStlM2pCbWlLQVI0Ukw2TVVYdGYxKzVHUmQ1S2ZRMUpRWTRZU2ZzK01DMTJG?=
 =?utf-8?B?VjQxWTVwMDZMTlk4VTRQbmhNS2ppYnhTUW1PelVvVzA5NnJzRnVtN2xhQlZ1?=
 =?utf-8?B?M2FqMENrQnFGbmh1dVRSU1RVa0d4bGdlVmhacWgrYi82YmM4RXNndnV5NGtj?=
 =?utf-8?B?UEdxRDA1cUkvdys2TEhKZk1vSTBGVjRjNEEvREUwR2p6UXhzTlEwM3UxbmJW?=
 =?utf-8?B?NUw1dzgwSGphV3NueDJlb0Z0NmNzQXZmbWh2Q05XY2wyZWFqUHF3TjFVYjBp?=
 =?utf-8?B?Q1VRMmZkMURaR04zWWNmMkJuNVp1RytVRkNJWnp5aWdWWGJiT0tBR0dmSmN4?=
 =?utf-8?B?UnVobGpUTTFYRWh4QlUyQWtsRW5SRTFBNHRsclE4eEdTczVLNlBhTmlQTXA5?=
 =?utf-8?B?ZFlORGlsRzdHVEwxaDltZlQrVVhxdVNZbWJGZS9tTzhxYitoOGg1TmpMZnRB?=
 =?utf-8?B?ZHJPa1AwKzhVY08xY0pTMVJ2dHRua09CL2dERE52QjF1djlPcnZyTUpPZmw3?=
 =?utf-8?B?RjRDL0c0RUNqMzJvbklDdUp1YXJpM2QxVGw5YUxxYm1XTW0zSUNleW1aYUtM?=
 =?utf-8?B?WGNteFN4cmhXNUx1dzZBa0RzYkFsQ0ZNaWptOTdNODlBZ2E0TGVxNU1zV2hF?=
 =?utf-8?B?dDlYNnppMThwNDJ6d05UdWw1cGppNVVRS2Flc2grNUUyb1UrSDNPbVJZaXl4?=
 =?utf-8?B?SzlSSFAwVTdqSGk1WFNXYkZxYU1nS01wWEJ4cTlBWUNoMldDdjJSMHBXTThw?=
 =?utf-8?B?VENSV0l6VENJQ2kyaUlWSnpKRGw1ZEZNL0pxdDhKTjBHMmt0Ykd5RVRhSndT?=
 =?utf-8?B?ZFhvd0RpTkJyK1JVeUtUMnZMb1psK1RzOEtvMjY0eWc3bStrVFcxMWVrWkg0?=
 =?utf-8?B?T0tBbHJHN2k3SUlzaFJBMmg3eUdlc2RQQkk4eURxQ2pWQWtEdHIvaWx4U2pI?=
 =?utf-8?B?YWtJRmdLS3VHUVl2Y2dnbGJidEpKZWVRTmNxc1BFZVUzU2ovcFUwaG5Gckp0?=
 =?utf-8?B?RmQ5cjYxbUxTRVJlZFgzWE50bUJPblQrZUN0eGZyUzZ0akRjaWlrNDRJaDE0?=
 =?utf-8?B?THFzNDFNNWYwdXpGVStidkFUVkMrUURqZFlRUkdqbFJkdXhNWE9LekNkS1RU?=
 =?utf-8?B?eWswRU5pbDBHbUpuUjFGb1kzUVdTNlNqWGRPUVdOV0ZGeWVQanpJZWh5Tm5Q?=
 =?utf-8?B?dEpmalc1NFQwQjYrSm8vd0JjQzhvUjZyVVJKTnAzUUJ0SElxd1BKSkR5TXpn?=
 =?utf-8?B?NTQwekVnSncwWXlGdTdwS1orUWhpdzJsc016TkI2R2Rwa28yeTErRkZXNFpH?=
 =?utf-8?B?aEJiQ3BDQUx2RjhZQ1BueUI0dEJKbDlaQUpIZ0lRU2FOUit2akg5Y0FzbWlU?=
 =?utf-8?Q?7dz71yQgrnWJyl/WsF8/gwt9/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85e266b-f5cf-43b2-48ea-08dc5efffaf6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:01:10.2101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1y3qxWBMDdQ1iqmytyqbmRBgKU1jC0bVc1fd3/p3138H4yNKP3981/9RclNYAtfBXmTIRaquBGSNukQ/pJTlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
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


On 4/17/2024 10:21 PM, Alex Deucher wrote:
> On Wed, Apr 17, 2024 at 12:24 PM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>> Yes, right now that API doesn't return anything. What I meant is to add that check as well as coredump API is essentially used in hang situations.
>>
>> Old times, access to registers while in GFXOFF resulted in system hang (basically it won't go beyond this point). If that happens, then the purpose of the patch - to get the context of a device hang - is lost. We may not even get a proper dmesg log.
> Maybe add a call to amdgpu_get_gfx_off_status(), but unfortunately,
> it's not implemented on every chip yet.
So we need both the things do gfx_off and then try status and then read 
reg and enable gfx_off again.

  amdgpu_gfx_off_ctrl(adev, false);
  r= amdgpu_get_gfx_off_status
  if (!r) {

        for (i = 0; i < reg_count; i++)
                adev->gfx.ip_dump[i] =
                RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
}
amdgpu_gfx_off_ctrl(adev, true);

Sunil

>
> Alex
>
>> Thanks,
>> Lijo
>> -----Original Message-----
>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Sent: Wednesday, April 17, 2024 9:42 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v5 2/6] drm/amdgpu: add support of gfx10 register dump
>>
>>
>> On 4/17/2024 9:31 PM, Lazar, Lijo wrote:
>>> On 4/17/2024 9:21 PM, Alex Deucher wrote:
>>>> On Wed, Apr 17, 2024 at 5:38 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>>>> Adding gfx10 gc registers to be used for register dump via
>>>>> devcoredump during a gpu reset.
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 ++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
>>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 130 +++++++++++++++++-
>>>>>    drivers/gpu/drm/amd/amdgpu/soc15.h            |   2 +
>>>>>    .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>>>>>    5 files changed, 155 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index e0d7f4ee7e16..cac0ca64367b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -139,6 +139,14 @@ enum amdgpu_ss {
>>>>>           AMDGPU_SS_DRV_UNLOAD
>>>>>    };
>>>>>
>>>>> +struct amdgpu_hwip_reg_entry {
>>>>> +       u32             hwip;
>>>>> +       u32             inst;
>>>>> +       u32             seg;
>>>>> +       u32             reg_offset;
>>>>> +       const char      *reg_name;
>>>>> +};
>>>>> +
>>>>>    struct amdgpu_watchdog_timer {
>>>>>           bool timeout_fatal_disable;
>>>>>           uint32_t period; /* maxCycles = (1 << period), the number
>>>>> of cycles before a timeout */ diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> index 04a86dff71e6..64f197bbc866 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
>>>>>           uint32_t                        num_xcc_per_xcp;
>>>>>           struct mutex                    partition_mutex;
>>>>>           bool                            mcbp; /* mid command buffer preemption */
>>>>> +
>>>>> +       /* IP reg dump */
>>>>> +       uint32_t                        *ip_dump;
>>>>> +       uint32_t                        reg_count;
>>>>>    };
>>>>>
>>>>>    struct amdgpu_gfx_ras_reg_entry {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> index a0bc4196ff8b..4a54161f4837 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>>>>>    MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>>>>>    MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>>>>>
>>>>> +static const struct amdgpu_hwip_reg_entry gc_reg_list_10_1[] = {
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS3),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT1),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT2),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STALLED_STAT1),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STALLED_STAT1),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_BUSY_STAT),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT2),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT2),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_ERROR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HPD_STATUS0),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_BASE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_RPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_BASE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_RPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_WPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_BASE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_RPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_WPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_BASE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_CMD_BUFSZ),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_CMD_BUFSZ),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_CMD_BUFSZ),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_CMD_BUFSZ),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_LO),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BUFSZ),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_LO),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BUFSZ),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_LO),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BUFSZ),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_LO),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_HI),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BUFSZ),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPF_UTCL1_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPC_UTCL1_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPG_UTCL1_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_PROTECTION_FAULT),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_VM_PROTECTION_FAULT),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS_2),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmPA_CL_CNTL_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_UTCL1_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRMI_UTCL1_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_DCACHE_UTCL0_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_ICACHE_UTCL0_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQG_UTCL0_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmTCP_UTCL0_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmWD_UTCL1_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_DEBUG),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_CNTL),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_CNTL),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_INSTR_PNTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC1_INSTR_PNTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC2_INSTR_PNTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_INSTR_PNTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_INSTR_PNTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_INSTR_PNTR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_STAT),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_COMMAND),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_MESSAGE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_1),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_2),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_3),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_4),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSMU_RLC_RESPONSE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SAFE_MODE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_GPM_STAT_2),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SPP_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_A),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_B),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR),
>>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) };
>>>>> +
>>>>>    static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>>>>           SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
>>>>>           SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL,
>>>>> 0xfcff8fff, 0xf8000100), @@ -4490,6 +4583,22 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>>>>>                                hw_prio, NULL);
>>>>>    }
>>>>>
>>>>> +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev) {
>>>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>>>> +       uint32_t *ptr;
>>>>> +
>>>>> +       ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>>>>> +       if (ptr == NULL) {
>>>>> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
>>>>> +               adev->gfx.ip_dump = NULL;
>>>>> +               adev->gfx.reg_count = 0;
>>>>> +       } else {
>>>>> +               adev->gfx.ip_dump = ptr;
>>>>> +               adev->gfx.reg_count = reg_count;
>>>>> +       }
>>>>> +}
>>>>> +
>>>>>    static int gfx_v10_0_sw_init(void *handle)
>>>>>    {
>>>>>           int i, j, k, r, ring_id = 0; @@ -4642,6 +4751,8 @@ static
>>>>> int gfx_v10_0_sw_init(void *handle)
>>>>>
>>>>>           gfx_v10_0_gpu_early_init(adev);
>>>>>
>>>>> +       gfx_v10_0_alloc_dump_mem(adev);
>>>>> +
>>>>>           return 0;
>>>>>    }
>>>>>
>>>>> @@ -4694,6 +4805,8 @@ static int gfx_v10_0_sw_fini(void *handle)
>>>>>
>>>>>           gfx_v10_0_free_microcode(adev);
>>>>>
>>>>> +       kfree(adev->gfx.ip_dump);
>>>>> +
>>>>>           return 0;
>>>>>    }
>>>>>
>>>>> @@ -9154,6 +9267,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>>>>           amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>>>>    }
>>>>>
>>>>> +static void gfx_v10_ip_dump(void *handle) {
>>>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>> +       uint32_t i;
>>>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>>>> +
>>>>> +       if (!adev->gfx.ip_dump)
>>>>> +               return;
>>>>> +
>>>>> +       amdgpu_gfx_off_ctrl(adev, false);
>>>>> +       for (i = 0; i < reg_count; i++)
>>>>> +               adev->gfx.ip_dump[i] =
>>>>> + RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>>> This may cause a bigger hang, if PMFW is already hung (in that case
>>> reset also won't work, but a dump is still useful). To be on the safer
>>> side, there should be some sort of return value for gfx_off which
>>> should be checked.
>> amdgpu_gfx_off_ctrl doesnt return any value to confirm if it worked or not else would have checked return value.
>> I guess assumption is that it will work until there is a bigger hang as you  mentioned and i guess in that case nothing will work and needs a reset only.
>>
>> Regards
>> Sunil Khatri
>>
>>> Thanks,
>>> Lijo
>>>
>>>>> +       amdgpu_gfx_off_ctrl(adev, true); }
>>>>> +
>>>>>    static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>>>>           .name = "gfx_v10_0",
>>>>>           .early_init = gfx_v10_0_early_init, @@ -9170,7 +9298,7 @@
>>>>> static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>>>>           .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>>>>           .set_powergating_state = gfx_v10_0_set_powergating_state,
>>>>>           .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>>>>> -       .dump_ip_state = NULL,
>>>>> +       .dump_ip_state = gfx_v10_ip_dump,
>>>>>    };
>>>>>
>>>>>    static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.h
>>>>> index 1444b7765e4b..282584a48be0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
>>>>> @@ -88,6 +88,8 @@ struct soc15_ras_field_entry {
>>>>>    };
>>>>>
>>>>>    #define SOC15_REG_ENTRY(ip, inst, reg) ip##_HWIP, inst,
>>>>> reg##_BASE_IDX, reg
>>>>> +#define SOC15_REG_ENTRY_STR(ip, inst, reg) \
>>>>> +       { ip##_HWIP, inst, reg##_BASE_IDX, reg, #reg }
>>>>>
>>>>>    #define SOC15_REG_ENTRY_OFFSET(entry)
>>>>> (adev->reg_offset[entry.hwip][entry.inst][entry.seg] +
>>>>> entry.reg_offset)
>>>>>
>>>>> diff --git
>>>>> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>>>> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>>>> index 4908044f7409..4c8e7fdb6976 100644
>>>>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>>>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>>>> @@ -4830,6 +4830,8 @@
>>>>>    #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
>>>>>    #define mmGB_EDC_MODE                                                                                  0x1e1e
>>>>>    #define mmGB_EDC_MODE_BASE_IDX                                                                         0
>>>>> +#define mmCP_DEBUG                                                                                     0x1e1f
>>>>> +#define mmCP_DEBUG_BASE_IDX                                                                            0
>>>>>    #define mmCP_FETCHER_SOURCE                                                                            0x1e22
>>>>>    #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
>>>>>    #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
>>>>> @@ -7778,6 +7780,8 @@
>>>>>    #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
>>>>>    #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
>>>>>    #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
>>>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
>>>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
>>>>>    #define mmCP_MES_GP0_LO                                                                                0x2843
>>>>>    #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
>>>>>    #define mmCP_MES_GP0_HI                                                                                0x2844
>>>>> @@ -9332,10 +9336,16 @@
>>>>>    #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
>>>>>    #define mmRLC_LB_CNTR_1                                                                                0x4c1c
>>>>>    #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
>>>>> +#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
>>>>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
>>>>>    #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
>>>>>    #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
>>>>>    #define mmRLC_PG_DELAY_2                                                                               0x4c1f
>>>>>    #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
>>>>> +#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
>>>>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
>>>>> +#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
>>>>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
>>>>>    #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
>>>>>    #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
>>>>>    #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
>>>>> @@ -9720,6 +9730,8 @@
>>>>>    #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
>>>>>    #define mmRLC_LB_CNTR_2                                                                                0x4de7
>>>>>    #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
>>>>> +#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
>>>>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
>>>>>    #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
>>>>>    #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
>>>>>    #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
>>>>> --
>>>>> 2.34.1
>>>>>
