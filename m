Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3490C44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8765110ED8D;
	Tue, 14 Jul 2026 15:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yZaomdRA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1F910ED8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx8xNVV9WXQ6U9n2g0AKhjXmK28CrvDXhsxUQbrPe0wtiBPqLlGMLoOXd2aBvUQyiH2w8+NIPmK7IxdHc76meAHkaczZaRBRN4NiXr2LunbU1REfWkAB1+a6fwFOP8VGHFy8H7aVEAw283+VPf576uQr4TmNC6l/ZlYdjL8gWFDNGK4YhvWVcMc6BkA3ymGEF3OWYyTaHPSc6QcHVTr2iYwElYfo7s6GoK1N/3vfbp7UN5FKLzrXrfk+aUVQwAuM03PyxPjgIg4SRMi65HS+S7BVq7Ci9EjsFFV7YgC13jfNw/maFylM7+Jme0k5kmLx1Nfrjhu1sxOCL/0tdfESZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NveOGvdIhY0BraxRRX6Zv9aFlGnuGDub075cF9XYIrU=;
 b=iGL37bsBCbOrPfwqz3ekWP7tjAHx9BdNI2SVs0hVGGAPnPon4NCHwoCcNpvI0523Evbia43X7zHXcPoq7O7nBOIoMuiIJSSkzduS7fodt1HhTIDAzm66l91L+eG2hvIrGuQ9+lsuVa7hpVZ+stNY4XnIM+PMc/Z7EFelWTTZ4zvoOZGwlEKmLwkTVB4QbQh3T0HC/DrRgc/okSMVUA2LeYeq+2BvkbRd0mZcSu/VvLRhGNDNDy8nPpMUxr8zQ6Yr4cJpnkJr9i3iHobm9cZpTuU8bFDMZjZQhzIwemtQzoW4xM4CZgx76zXqlOe7qhJAuROUEBPqcEdZl5fqLlV+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NveOGvdIhY0BraxRRX6Zv9aFlGnuGDub075cF9XYIrU=;
 b=yZaomdRAPG2NF72Krafd7fo0OovDMQ2qgM+HYFaeq+S2Tqfz5Ad/4GTTLQVagMEW+1G3X0gMpZqCM0pwEsd0ALrr5++BZEhVXSawon3Fww7adQYx0THHRN/EbovgMztJ6iRMs7zBfFGUhS1e9gaWEWTrH/RLclVW7s5vCZyNOqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 14 Jul
 2026 15:12:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 15:12:59 +0000
Message-ID: <c9e1526e-c2b6-465c-9f82-24299d8a0e23@amd.com>
Date: Tue, 14 Jul 2026 17:12:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amdgpu: add an buffer funcs callback for TLB
 invalidation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
 <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
 <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
 <1e4cead4-73b7-461f-b4d4-a66e293d0d96@amd.com>
 <CADnq5_OnTfvMf+Bx3V36p0W_M4ARksHZ+emGSNb07Us9xPr2uw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OnTfvMf+Bx3V36p0W_M4ARksHZ+emGSNb07Us9xPr2uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e6ee8d-38c5-4c85-f30a-08dee1ba6443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|4143699003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +n/Wf2gSr0pPwGY2rcoxJIKpkEczWmhLpvhy7oIkdZbTB9/AyqB8VJecNo/5PrUOsW9laDviBTi2eKv62sX+TO9A+blx0qRZdnwrBB5FtE7rGafrFwInodJBdvqIwvbOrDbVJEeuSMmyxJIsI8Jzr3u6ACt9197WFO67yL5ASN1fH1jFv1QJMj5ksmbmun4aV6SfTBjDEwvyoQ1zSyBGQrE1XRVRk7l3fjeC86fp/6LYmcAzkvdKJXakJNGz/I0xugqU2KjQGGj6A1mD7tzdwFN/6YbWdC4yYKQPFRyZRbe8Garc8LoZoJadmkQZOOQFiWkPnG8In7m4kn5K3GhdjB6tz4AoXY7bOUhjzOVrIIoK+IR53W31Ku1I2AoekVnd9lJYfDnATgaf5QWlHYtAyHqxU4o6TivyoSQrJ+UG8zZo20UdDSZK1oMetYfq2n9iUq0mE7ezSqo/lh/yGBNY2ok+D9jRXjCbW5ZeRCyNyW/mlLSpW4GAVsv3XD2o0uhC6PeQGjj0IBtVHp1lqIlbxNQSq51tcJiIh/QAWEgsnrVgBO4S56elFDMiP/jBR9iTeD/UnK/Xt2hqavh13PWnxBIp725UPElFtXdJiOdN+BC78NDDpwTcORYhkheay3mQ5dhtsfnOZbb0O197ADVftvyiez9RCfkODeb08jYQYbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(4143699003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUpGa1hGNUI0UzVONWhKdERLaUlnOVJ4L2RNWHB0RFFoM3NDWHhjUGNpK3JX?=
 =?utf-8?B?T095SkZVcUJ5ZGV6ZlA0akFoczFvaytreVV3c3ZBSHB0U2MyYUlQREkvQUo2?=
 =?utf-8?B?dFI4c0orVzA3OVJkRENmekMxcXZOTzJuZ1lzanVZdmdxSHhYall3OWNxWnZq?=
 =?utf-8?B?MW54RlYxeTRxWVZRNFV3ZmFqR1dCcXJ5VUs4OGxHOEM1V3AvNGR6Ym5WYjlU?=
 =?utf-8?B?cmdXd1FoRGFOam0ySFpKamRJdHRjSXdpc3BqNmZwbGRHMVFDV3lWZFNNT0Rv?=
 =?utf-8?B?dG15NFZzeFdHRUFkZEttRTBROXJlOGp4Vm8veFRTdTZxam4zcndvZURnSVc3?=
 =?utf-8?B?WnhSMFFvMVl2dk9GcW9FcHgvUUhTbEtZVERJMXQ0KzlhWnE2Rzh2SjMzQkRO?=
 =?utf-8?B?bmh6RCtGUGNMU0VDRCtxODgzK0lqUFdjMGovQ1ZUOWJZN3BMYU1ENWZkMDNB?=
 =?utf-8?B?MmpHaXVNMVVXYk01a29ZWDVrcTBNUTlOVnNqUVhuQ0FiUWRNTFhDSlJTSVN1?=
 =?utf-8?B?MXJHUjBHZTVVZnpLc2llcnBjUkc1eW5TOVJ4UjRtbldGYmFMSHVlS3FIZTZ0?=
 =?utf-8?B?V1hKUE94akoxa1AwOEk3UlRaaGpUeG96amJIQTlsSWhOVWVNZG5BU0IzOTk5?=
 =?utf-8?B?a2Foa2RDWVJGTDZnZmVkVFFlZnY3Tm5pV1lkTCtQY0YzSVdsVzVnVHRNQmIx?=
 =?utf-8?B?SDJUUHJpSGZTNmlCWW54SDhiTXp1YVVJOVJaQ3o1WCtDcXBUV0JSWldVdjFi?=
 =?utf-8?B?K3FPaW1VNWQ5VnRjS2NYY3Z6NlZYdFJQSVZCNnd6STZ6ekxmYTU0aFVDaGFG?=
 =?utf-8?B?d1dEeThBT3dMbGxHS1dpRFJoNHdmUk9KNVpTcUo3bnVUK2ZCR1pwdUJMczQ0?=
 =?utf-8?B?ZGZzSEtwMXZtUXU0VSsxSE54NlplaHRVY252Vy9DSnl2YlJqcm5mOVppZjht?=
 =?utf-8?B?NVB6bUFXczIyYlpoLzFuZEZiRkJBUmU5cUo5K1hSb2ZaSjBIaUIxSzZOdzUr?=
 =?utf-8?B?U1g1Q1h6eGp4MnJ6a3ViT1N0UmhndWdXVGF5Q2ZMOW5xczEwazBLOVdjUzB5?=
 =?utf-8?B?cXhWMFdCK1kvakxpQUgyZVJxbGp5VWFMcTlLWklCeFRSQ1JFdnM1OEg5R2No?=
 =?utf-8?B?eDlNRk9xbE9ZU3hBL1diazhkdC9zYlNjOWZ6TFdleEhRQVFxRERBa1A1aGEv?=
 =?utf-8?B?NG1aTEI1M25Ccm1sblAyVEJuV2RuVTc5YkpKR2tCN2swUnhPRGdSbjVkcWtW?=
 =?utf-8?B?M3dyUkdoRDh0akFhR0dUUklOdEJkWUlUZ05MWWJRalZwc2dldHo5L3lobDY0?=
 =?utf-8?B?YWxQSVpVeGg1cy81VXNyM0E5b1RtUk9NTkZPb1Z0cXk4QzJmQStNNDZ0bXpk?=
 =?utf-8?B?ZUY0Z1RlWmV3TzM3SjVMMTNISWMvOU9GcEwxS3RSbmUxbzE5SnltRExPbkMv?=
 =?utf-8?B?Q3prUFpyNWRIQjFsdGNqVGplN2VlYllVbVBsQW43dFo5aENBRzRnNi9MK0pl?=
 =?utf-8?B?cVdCb0JLNlhRNTdhWW1vYWZXbUNEVHZIQjNBWHl1NTJReGg3cFNLVTJiVFpy?=
 =?utf-8?B?V0JpTVRmWG9UZGk1NXYrNFFZWGJweEJyK2tYUUVzWEVyeE9NL1U4TElrQVNz?=
 =?utf-8?B?Y21FaWJTekN2M1RlaXo0Sm1WMzVnR2h0ZkNObGZmbjN3OUxSYVl0YXRxZEVI?=
 =?utf-8?B?TytXckZyWldrTVJxaXkwanROR2JjK2FVSWtiRDhzS2Rmei9ZMzh2b0pMeGZP?=
 =?utf-8?B?MDUxdzFJL3ZSemZ6SDBRSnh3SlJlK1B3RFBvbmFaY1FJdDc3dXgxTkxJdjc1?=
 =?utf-8?B?TEJMRCs1WVU5YkhRNmFObmFqTklFZjF4bnJHSllSZStPMHJ6YUtYUzBrK2pk?=
 =?utf-8?B?a1pGalVrQ3pFdkZXS3ZHTnEzdDZ1ZEJzbHdWOERObElSRHVHQTBmdDRzejdw?=
 =?utf-8?B?bUhDWnppS1NCSkwxaTVLUUtYenZGeUVSa0tlVVk1MThQSGh0YTh1Yk9YN3dB?=
 =?utf-8?B?MUwyZnlUdUsxaWcxL09teFZQeHZ4SFhPQm1PRmh6OHlweHNZOCszdWdSVDZD?=
 =?utf-8?B?dDdLNk5hUHc2ZFJhRnhIRWhXckt0c1pUV1hZT1ZKTGZiTHRkdEdqNkNLcWp5?=
 =?utf-8?B?N3lrTk13TDhjWW4xKy9ZVEZUUWprc0NCbDNXR0NXZ3FJZnkweVI5WllOaDBl?=
 =?utf-8?B?UTI2MkJoTklEcnVWQ2Nnbk9sZkQyMk1TdFpsZmlORGs2Zzh3SHJmWGNaU2dO?=
 =?utf-8?B?NWVpb3V5WVhJa3lrUnY2akNldnlUZkVtRkRRQ04rWnloQm04TGMyR0xjOGZT?=
 =?utf-8?Q?P9UzNJFrLeuQCOgdY8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e6ee8d-38c5-4c85-f30a-08dee1ba6443
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:12:59.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjnNWYuLQ2JMw6AzMzkB/5cGiWcAhoVJ8apAeiBNsFFOC1UCfcmMX4FPwqGHJaIZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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



On 7/14/26 17:03, Alex Deucher wrote:
> On Tue, Jul 14, 2026 at 9:46 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 7/14/26 15:42, Alex Deucher wrote:
>>> On Tue, Jul 14, 2026 at 3:19 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> On 7/13/26 20:27, Alex Deucher wrote:
>>>>> Use this interface to issue TLB invalidations using
>>>>> SDMA.
>>>>
>>>> Hui? What should that be good for?
>>>
>>> To use as a replacement for doing the invalidation using MES.
>>
>> We should already have that as workaround for the Navi 1x SDMA bug.
>>
>> I suggest to just move that code into a separate function instead.
>>
>> But the SDMA can't do PASID based invalidation and that is what we need the MES for, so I'm not sure how useful that will be.
> 
> The current gmc code doesn't do pasid based invalidation either.
> Everything ends up in gmc_vXX_0_flush_gpu_tlb() for each gmc version.

Yeah, but that one shouldn't use the MES in the first place. We could use direct register accesses here.

Using the MES makes only sense if we invalidate per PASID.

Why are we using the MES for per VMID invalidation?

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Alex
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
>>>>>  1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>> index 4f4e56022c970..4ab92d287675a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>> @@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
>>>>>                                uint64_t dst_offset,
>>>>>                                /* number of byte to fill */
>>>>>                                uint32_t byte_count);
>>>>> +
>>>>> +     /* number of dw to reserve per operation */
>>>>> +     unsigned        tlb_inv_num_dw;
>>>>> +
>>>>> +     /* used for buffer clearing */
>>>>> +     void (*emit_tlb_inv)(struct amdgpu_device *adev,
>>>>> +                          struct amdgpu_ib *ib,
>>>>> +                          /* vmid to target */
>>>>> +                          unsigned int vmid,
>>>>> +                          /* vmhub to target */
>>>>> +                          u32 vmhub,
>>>>> +                          /* inv eng to target */
>>>>> +                          u32 eng,
>>>>> +                          /* flush type */
>>>>> +                          u32 flush_type,
>>>>> +                          /* XCC to target */
>>>>> +                          u32 xcc_inst);
>>>>>  };
>>>>>
>>>>>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>>>>> @@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>>>>>
>>>>>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>>>>>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
>>>>> +#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.buffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
>>>>>
>>>>>  struct amdgpu_sdma_instance *
>>>>>  amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
>>>>
>>

