Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F12FC07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 10:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7458310E3D5;
	Tue, 27 Sep 2022 10:00:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83BF110E3D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 10:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTbWhaIwOsKMg1YZ/7f0p+BY4l4r/1d5i2Ug0CBd3gtIfYoDDjWKsRqpiYBw1NwkBI5cp/MyCdH/0n/IeJdiMsI2V46BJClUFdo0GyaPoQ7XdTDwr+FsboKKTlDAP8lwNLGAJpocFUStCESpXQ3RvbgqnZwyb3gNut86BQ3Hiob432pGIEbcq3Tq1iJPo7zNS69gQe9wQsPHPwZkuqcmPbbYhp3oFJZV0ADkTmRcOcNF10Il73B04CVLFq5u6g+sLPe7Ot5ve31fx6WY8kwixK2gbvN+5q5HByYTgVkoOml8wEdiRIpVC5E4X9eoFN4JZ1hMhhOKeykV3acMGMg7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zLGPH0bAEiEKsX1X3glRw0y4phUsXnuV8Tv7NDAtXc=;
 b=SenlbZAdfckLQpFftd92TOtsGMx/sldhWc7GU7voD8XlJIp4/E4yzrBXCm6xvjuinVzNwgLuhKS0ml3LVPUatWGj99lMXGBJQBmPA2F1XpBAXgLMccQaX0eZgGI4RkekJSro6YxmRLJZD+g3b+KeIwyaRwBJ9d+cO47IPdJoBRZ608Fe3jDF1jLSf98/xXgVCyQNN3jd0AVpnBhbbTMKCI3LbZxMVs9Z7WfzdBdx9bXozSFCzHceVnMUW7v+ycLdw0MGxZFBwXb8NbKLOKTosj9XN9sqoxdm9EzcdLmsQB4PwQIuo4fgAcazjkFFwllQSzmXa3QPnwhGRTS/AJAm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zLGPH0bAEiEKsX1X3glRw0y4phUsXnuV8Tv7NDAtXc=;
 b=SjMfW4aLwV38cTTbG2wLs1+Y65JIJfy8PRxePjg9mgQ0qr7wKsrqGB/VKR9efXOOSspmfbekL8R/E/UITzQHA/Q+0wrRRAjDivYlLskKgAoVAxQoacp4DqLDOpOEHM7dkWzibRV0O76Bhrbnx8xKyRvv4j2D2+F5ZE17bHfl8Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 10:00:35 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::b944:6ee3:2df2:631c%9]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 10:00:35 +0000
Message-ID: <c9bb881b-e917-5052-6ded-963005c4bd84@amd.com>
Date: Tue, 27 Sep 2022 12:00:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
 <BN7PR12MB261218AAD06042B10065EA56E4559@BN7PR12MB2612.namprd12.prod.outlook.com>
 <80efbb83-c6a5-7585-1c16-21832ded522e@amd.com>
 <DM6PR12MB26194BBD083A1FCF60FAB9E7E4559@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <DM6PR12MB26194BBD083A1FCF60FAB9E7E4559@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::14) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: 91550611-0d02-4455-b3b1-08daa06f1efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAxWyB1WJV2VCGPRjDQJrVm6BMwQwpWOP7rZvLXfQdZy1qUOAob7eei/jzZvLKfyd2I1dHTsnDt1HHVWQFQUPJESG3TEU5gz/2IQVy/guuB7Zgw5Bf5YMYNVz14GTCdRqCj5rGSIUDqF4tNunWm+b77S6y/PucU8lE5JscEiAS5heBi5QaIgz1nzZotnaxJ0/w7zWekNPnx7pHDNeL+uyQBQwI0CSEYKk35L+Y9+X9IXZHBO/Pia+J26MYi4TIVeuIIpCI5cldyqZeIfI9+tkZbGbSEkdbzXzvgz9He7ZexMRfdw2odL0GCSJI9mVB2ePWWPdvGEjJG6oDEYyM/NUy2Ua0NExC+Xf3+UFJJsu5juzCKqRwO63g8Qlk4eC+AfmJGk6obJoDmXwcab3gUK6E7lBX3LLnjfJHsuDws4ZRgrhGHZW33IvWff2zz/X786gcCX50otCzHU5gCuAORud7p6IAiXulvwPUE3tuNUL1jSYmMVnYEKJmGjku8QIFNOi00Ty2YczPX4Z036uNbZeloS/jdcY/xMeOQR2jeE9c7Tv+Mo0SbX15t+pKvh/eRqlW7i89qgyVUWvN1odK8g4fVDK66Ic2tX4wfnN/23ENkMEn+uRN1W8L3DoRhasMxLM704+WFbE0eDXutrD+Tuw3AJ0XCiMYEy/MkTUEYzUefxpxWqnkdfTe2evdOkr1+fc7bKHV3dBubqH0HEDLdfCyr5htzTDSN//2+HpgX5ppcy4DbujT8nQtoIwNwy5UHQEyPWmrb65jHe1UGFsaGDI7sazDSsD60KdKHdyZidHpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(186003)(83380400001)(31696002)(54906003)(110136005)(316002)(8936002)(86362001)(66476007)(66556008)(41300700001)(8676002)(4326008)(6512007)(478600001)(2616005)(26005)(36756003)(2906002)(66899015)(31686004)(6486002)(30864003)(6506007)(38100700002)(6666004)(66946007)(53546011)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVwK2UrNWVnUHUrV0s2YzNqb3ZCeTZaQ0lWcE9KZk5wZmZiL0cxdnJ6b0hT?=
 =?utf-8?B?ako0ZzFrUHpEZGNOMHY2YkxLZkNGSFN1M1ZOcFVjaGY1TkZYb0lBUFYyRFZ1?=
 =?utf-8?B?b3M3Vm1GVU8vNUlycFlJRTFXNXlmZ0RTMS9jL1U1Vlc3TjdsTXpRbGlaWEJ3?=
 =?utf-8?B?VzVkOUE2N1YwajJPajVBV3VET0k4SHh0R3NCQzJiejZFUnhZdHNKbmwwd3RQ?=
 =?utf-8?B?NThBdkt3bHhhUlE4STJzbmdUQUNJTGhjaTVTSXlKbHdEay9vMFJGR2lEK0pR?=
 =?utf-8?B?S2xQOGJNdjQvZnJSZkZiVExaRWZmTGtwalVDUFFLTEtOZDRHVXFMd3ExTlB2?=
 =?utf-8?B?L1NtT2J0ZGtPRExYNUJPS2Zuc3JlOGMxVTRpVFJacTFiSXErUkZZbVJWWmNv?=
 =?utf-8?B?LzhadW5vRE4xS2dQNHV2K29wVmlabGtGV0JiR0k3ckxadGVpNVoxNGlla1Ny?=
 =?utf-8?B?YWdDUzJMSHIvKytJRkl4Mjk4OEpBZ2sxTU8xa0ZuSFBWeVVvYk1DdUV3UEwx?=
 =?utf-8?B?dFBqK0VsVWFaNDU2ZGUwcm0yRTJWRytobWl5c2ZqejNPTklRenFZeTIzWkUx?=
 =?utf-8?B?Mko2a0dPMFpKT0lYRFFibm5CS05ubVlaa3RlTnQycDZ1cFZFT1BxWUFpU044?=
 =?utf-8?B?Q2RlbSt5ejZJd3ZERzQyMjc5QVJGNENPQmxDRDFoQ1NaVEptK2pjYjd0Zm1X?=
 =?utf-8?B?SGhwbmNpajYvVW9sM3lCUi9yc2tDYlBBM3pjT1hWc09vRXJiM1RZZ3FremlE?=
 =?utf-8?B?dklBQkM5bG05WmxyY3M2OHVnZCtoeE1YSUt5eVJnNWI2ck9UMkxrYkw1THZM?=
 =?utf-8?B?UDBtdTZYVVhsUjN2ZTR4cHdvNTVEZTRRM0hwYzNVbUxNWE5LZkg0MUdRaE9E?=
 =?utf-8?B?RmFVYjA1b3c3aDhjZ2FzeXMybER1eEZLSHJNTUVWM0ZYWllySjdCazljVjdY?=
 =?utf-8?B?WjhleHFJZHRLam5uTFlpTmt0UUxYRVZiNzVCaHRDdlJyYURIVnM0dERSR1Ft?=
 =?utf-8?B?UFpBdklQb0tzakFBeVN6L292ak14N0RKcG5WY0xLQ0RwazJKZ01BTng3bis5?=
 =?utf-8?B?MUJkVDJxSUptWEhuNDAvdVl2SmhtbjZSRzVTYUwvbUpsa09KVm1nWVNpbi9p?=
 =?utf-8?B?MEJQdXRERkRBK0k4UmowNnRaZzBhVG1BT2M1ZkJ0YnJienpHdWZtMkR6b1hK?=
 =?utf-8?B?MTJUNHN5N0Y5STNTMC82UDR2Mzl1MlZRM242bVhYS3ZlUkYyWGlqUHZrUm8r?=
 =?utf-8?B?MjFWYWN2SEtPT2Q4TFF6U1F5eStyc2t4QzRWVWV5dTFlU216VUpsZFN2a2N5?=
 =?utf-8?B?Y1EyeGxTL0kxcEtFN0wrRzU4MDVOTUJkbmJPTmVPZnFCeVNYMXBIa3BIWGxW?=
 =?utf-8?B?L1FRb3ZVdzNJeEhMSmVDZm1HVVJ5MEhsajZ3RHAvU1JXd0UrRnZCUGUrQkMv?=
 =?utf-8?B?bnZtTHVDdU1VR1BROTJsMUEvUkp0SEN6Tjd0bjloeUUvTEdTMXdmTC9tUG9G?=
 =?utf-8?B?Z09GUGNjQ3d6TWlZQ1ZyUTFXOGg4QjViRnplRVgzRkgwa0RpYmY4bktKcTEx?=
 =?utf-8?B?Z2pPL2JPcXA2ZGNUOGRYVjFYa1hRaTZKaU5xMnVMdmJWZmRWZGw2K2VrNDhv?=
 =?utf-8?B?VGJ3RjZOdW5CU0x1bjFyWXVXcy81S3ZrSk9rZlZST09SZmlPVHAyZTFBc2hj?=
 =?utf-8?B?dGQ5NWI0WVpHeERGcmtHTG5yQ2h1WVFNbU5VcHBmcDNzYnhVTGtubnVDcjVH?=
 =?utf-8?B?ZnZEOTlFNk9VWjJoSlFhZWZ3bVBkV1d2VUpiMFh1S2dndlRpbHg0M3A4Y1dp?=
 =?utf-8?B?ZWxOakp3V0hIbFdPZ1U5Z1FYTTFVR2NrbGdZRVUrSHRPcHNzUk1YQVlOYUZW?=
 =?utf-8?B?U0ZxZ3h0ZCtBRUNkMVFKSWNxaXNkaGtoWVRrbDBmNlpOSXN1d3JmdXIvRG00?=
 =?utf-8?B?Z0xtU3YxYVA5TUZwRWNabEFOdjdSeTRZbXFKcXRjOUQxWVVPNitLS25VR2Rt?=
 =?utf-8?B?c1ZYcmgzUnR3VGJhbGJPVzdnRzhaM0F2b21WMTBvMXR2cUFHSTZqalpyVGNn?=
 =?utf-8?B?dVFCR2RCUkNGS003NC81RFNGbU9WWk96UENPQzlKSXZnTHRMZ05zNWM3Y013?=
 =?utf-8?Q?ABXP/rG041BU2nZUGWfNBNMzf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91550611-0d02-4455-b3b1-08daa06f1efe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 10:00:34.9262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsndVIjrAfUquGvkyVbyZiGs+uwP/N1kVkfvRZb1WX/rZLLFbCjPE08/m3++UP6HvqoqNzv8pb7D00BEZf86Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 11:29 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Sharma, Shashank <Shashank.Sharma@amd.com>
>> Sent: Tuesday, September 27, 2022 3:30 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram,
>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU
>> power profile
>>
>> Hello Evan,
>>
>> On 9/27/2022 4:14 AM, Quan, Evan wrote:
>>> [AMD Official Use Only - General]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Shashank Sharma
>>>> Sent: Tuesday, September 27, 2022 5:40 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram,
>>>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Sharma, Shashank
>>>> <Shashank.Sharma@amd.com>
>>>> Subject: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU
>>>> power profile
>>>>
>>>> This patch adds new functions which will allow a user to change the
>>>> GPU power profile based a GPU workload hint flag.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97
>>>> +++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>    .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>    5 files changed, 158 insertions(+), 1 deletion(-)
>>>>    create mode 100644
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>    create mode 100644
>>>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>    	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>    	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>    	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o
>>>> amdgpu_pll.o \
>>>> -	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>> +	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o
>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>    	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o
>>>> amdgpu_virt.o \
>>>>    	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>    	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \ diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> new file mode 100644
>>>> index 000000000000..a11cf29bc388
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>> @@ -0,0 +1,97 @@
>>>> +/*
>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person
>>>> +obtaining a
>>>> + * copy of this software and associated documentation files (the
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without
>>>> + limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>> + sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to whom
>>>> + the
>>>> + * Software is furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be
>>>> + included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>> KIND,
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN
>> NO
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>>>> THE USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +#include <drm/drm.h>
>>>> +#include "kgd_pp_interface.h"
>>>> +#include "amdgpu_ctx_workload.h"
>>>> +
>>>> +static enum PP_SMC_POWER_PROFILE
>>>> +amdgpu_workload_to_power_profile(uint32_t hint) {
>>>> +	switch (hint) {
>>>> +	case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>> +	default:
>>>> +		return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>> +
>>>> +	case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>> +		return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>> +	case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>> +		return PP_SMC_POWER_PROFILE_VIDEO;
>>>> +	case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>> +		return PP_SMC_POWER_PROFILE_VR;
>>>> +	case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>> +		return PP_SMC_POWER_PROFILE_COMPUTE;
>>>> +	}
>>>> +}
>>>> +
>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>> +				uint32_t hint)
>>>> +{
>>>> +	int ret = 0;
>>>> +	enum PP_SMC_POWER_PROFILE profile =
>>>> +			amdgpu_workload_to_power_profile(hint);
>>>> +
>>>> +	if (adev->pm.workload_mode == hint)
>>>> +		return 0;
>>>> +
>>>> +	mutex_lock(&adev->pm.smu_workload_lock);
>>>> +
>>>> +	if (adev->pm.workload_mode == hint)
>>>> +		goto unlock;
>>> [Quan, Evan] This seems redundant with code above. I saw you dropped
>> this in Patch4.
>>> But I kind of feel this should be the one which needs to be kept.
>>
>> Yes, this shuffle happened during the rebase-testing of V3, will update this.
>>
>>>> +
>>>> +	ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>> +	if (!ret)
>>>> +		adev->pm.workload_mode = hint;
>>>> +	atomic_inc(&adev->pm.workload_switch_ref);
>>>> +
>>>> +unlock:
>>>> +	mutex_unlock(&adev->pm.smu_workload_lock);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>> +				  uint32_t hint)
>>>> +{
>>>> +	int ret = 0;
>>>> +	enum PP_SMC_POWER_PROFILE profile =
>>>> +			amdgpu_workload_to_power_profile(hint);
>>>> +
>>>> +	if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>> +		return 0;
>>>> +
>>>> +	/* Do not reset GPU power profile if another reset is coming */
>>>> +	if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>> +		return 0;
>>>> +
>>>> +	mutex_lock(&adev->pm.smu_workload_lock);
>>>> +
>>>> +	if (adev->pm.workload_mode != hint)
>>>> +		goto unlock;
>>>> +
>>>> +	ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>> +	if (!ret)
>>>> +		adev->pm.workload_mode =
>>>> AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>> +
>>>> +unlock:
>>>> +	mutex_unlock(&adev->pm.smu_workload_lock);
>>>> +	return ret;
>>>> +}
>>> [Quan, Evan] Instead of setting to
>> AMDGPU_CTX_WORKLOAD_HINT_NONE, better to reset it back to original
>> workload profile mode.
>>> That can make it compatible with existing sysfs interface which has similar
>> functionality for setting workload profile mode.
>>
>> This API is specifically written to remove any workload profile applied, hense
>> named as "clear_workload_profile" and the intention is reset. As you can see
>> in the next patch, the work profile is being set from the job_run and reset
>> again once the job execution is done.
>>
>> If there is another set() in progress, the reference counter takes care of that.
>> So I would like to keep it this way.
> [Quan, Evan] What I meant is some case like below:
> 1. User sets a workload profile mode via sysfs interface (e.g. setting compute mode via "echo 5 > /sys/class/drm/card0/device/pp_power_profile_mode")
> 2. Then a job was launched with a different workload profile mode requested(e.g. 3D_FULL_SCREEN mode).
> 3. Finally on the job ended, better to switch back to original compute mode, not just reset it back to NONE. Does that make sense?
> 
> BR
> Evan

To be honest, once we have a proper UAPI to set the power profile, we 
should not use a sysfs interface at all (or use it mostly for debug 
purposes). Also I am not sure if you can read back the current power 
profile from FW/HW, can you ?

- Shashank


>>
>> - Shashank
>>
>>> /**
>>>    * DOC: pp_power_profile_mode
>>>    *
>>>    * The amdgpu driver provides a sysfs API for adjusting the heuristics
>>>    * related to switching between power levels in a power state.  The file
>>>    * pp_power_profile_mode is used for this.
>>>    *
>>>    * Reading this file outputs a list of all of the predefined power profiles
>>>    * and the relevant heuristics settings for that profile.
>>>    *
>>>    * To select a profile or create a custom profile, first select manual using
>>>    * power_dpm_force_performance_level.  Writing the number of a
>> predefined
>>>    * profile to pp_power_profile_mode will enable those heuristics.  To
>>>    * create a custom set of heuristics, write a string of numbers to the file
>>>    * starting with the number of the custom profile along with a setting
>>>    * for each heuristic parameter.  Due to differences across asic families
>>>    * the heuristic parameters vary from family to family.
>>>    *
>>>    */
>>>
>>> BR
>>> Evan
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct amdgpu_device
>>>> *adev,
>>>>    	mutex_init(&adev->psp.mutex);
>>>>    	mutex_init(&adev->notifier_lock);
>>>>    	mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>> +	mutex_init(&adev->pm.smu_workload_lock);
>>>>    	mutex_init(&adev->benchmark_mutex);
>>>>
>>>>    	amdgpu_device_init_apu_flags(adev);
>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>> new file mode 100644
>>>> index 000000000000..6060fc53c3b0
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>> @@ -0,0 +1,54 @@
>>>> +/*
>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person
>>>> +obtaining a
>>>> + * copy of this software and associated documentation files (the
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without
>>>> + limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>> + sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to whom
>>>> + the
>>>> + * Software is furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be
>>>> + included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>> KIND,
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN
>> NO
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>>>> THE USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>> +#define _AMDGPU_CTX_WL_H_
>>>> +#include <drm/amdgpu_drm.h>
>>>> +#include "amdgpu.h"
>>>> +
>>>> +/* Workload mode names */
>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>> +	"None",
>>>> +	"3D",
>>>> +	"Video",
>>>> +	"VR",
>>>> +	"Compute",
>>>> +	"Unknown",
>>>> +};
>>>> +
>>>> +static inline const
>>>> +char *amdgpu_workload_profile_name(uint32_t profile) {
>>>> +	if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>> +		profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>> +		return
>>>>
>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile
>>>> )];
>>>> +
>>>> +	return
>>>>
>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>> +}
>>>> +
>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>> +				uint32_t hint);
>>>> +
>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>> +				uint32_t hint);
>>>> +
>>>> +#endif
>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>> index 65624d091ed2..565131f789d0 100644
>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>    	struct mutex            stable_pstate_ctx_lock;
>>>>    	struct amdgpu_ctx       *stable_pstate_ctx;
>>>>
>>>> +	/* SMU workload mode */
>>>> +	struct mutex smu_workload_lock;
>>>> +	uint32_t workload_mode;
>>>> +	atomic_t workload_switch_ref;
>>>> +
>>>>    	struct config_table_setting config_table;
>>>>    	/* runtime mode */
>>>>    	enum amdgpu_runpm_mode rpm_mode;
>>>> --
>>>> 2.34.1
