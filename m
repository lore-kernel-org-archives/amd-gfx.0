Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65952C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EC510E6F1;
	Tue, 14 Jul 2026 13:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K6BB1t9p";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CF710E6F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/+/jpxZuVaObvkyYA0CQ1OuMRloVHfV5zCfN5TgU6ZDBenGS3rNGwy1skKiV+D2iXzHWYcrJK4+GF0x4DfwfTX707nbMQuXH3PDVDMx+knTfLVjkXna90YQc39Z4m9spBxymBLa/maTPcm5qxL3Zl4WJ9kSW+X0ltEDJUqFX2kjGYwrUMd+BWYYvAxAqVG2R3GQsasSa4yoNxnmzfNh3YUtc+01t70gWd6sNSLRdmlUZSbWtpnrvXBC14iGM0SF7zHjQbIvMG7hrjTNMDyCB2uYfU/EXLQXtT39suXP4LX80/Ye2UaAy1XQ4d/KdPRtdPNkkdDEavLAiw0Saup9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iGBBUJM2ndzT2AJQZlPQNmUxh+K2+FVmomPEBH8ZHE=;
 b=xqe2RBat1PY13ju35Po4y4F91ujGEFkdKlJVBXdFcG5n+g1gUDf1Yx6y0obAmQizxp+vpVhzm0dUroSOg/iUiZVuXryfbsJIUUnOHmvy1pCf/2A174gak6ocQqszHDYHij03Z6aDe15opdfAtkdUnaYK3oxMOyvQ+kbNA6gQQvIwrYW4DiIIjduWczjSaqgrgHBhXnpgpV1mz3cCuaVTmBjqaEDf4fbkL7gmqMb3d/tbnQQgh6TukdeEk8P9SJiEY7A16hq4SYu4rAOAY8CSY0y6tovpGTuWDJqvw2SxHFhh3hzCD8+t6HQPmV4M3wIXXtT8l8Q9Q5wuIXtzLv2J2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iGBBUJM2ndzT2AJQZlPQNmUxh+K2+FVmomPEBH8ZHE=;
 b=K6BB1t9pmXQ9ubfyuYVwqY3pIS63M2IFjB7Im4Nh/eCzK8guxJd4clHC4mJ8aEkWlDVxzYyCDCrmIQrkmu4yK5VcTK4nhloRjR3zi8AbkOTlPZLUumV3cSAexBLEYHRYKTMwCkOq2hkhitqIGMeQ2OYioLrdV9A79oB91dHYAsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 13:46:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 13:46:07 +0000
Message-ID: <1e4cead4-73b7-461f-b4d4-a66e293d0d96@amd.com>
Date: Tue, 14 Jul 2026 15:46:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amdgpu: add an buffer funcs callback for TLB
 invalidation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-5-alexander.deucher@amd.com>
 <e8926046-2e03-4224-98ba-8601de0421db@amd.com>
 <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OGJBx5xkSDfU4cyt0bjZRot18F-PE29RJFSkC=YPz6oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6be3a8-1ab4-4718-346c-08dee1ae41a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: kG+KgzYRf9913N1LDrZK1zRyY1+Y4QXFyKrm1x3fooNwk9XcEjcsWQXiBkkF01h+P3sBYugme3/H/jiF81Ayam/+VAObIJdLaChLxqIFtsCgtEn7Exb6khGVmF6+duhfY3qxKCDFiKwQjAB+ta0jkH86Of20cWtiYM3GXT2+i93Sv9buNYcrF7J2Sb99iLfjsQAMlkvFQsOU+Vxb1m6zjzWHXkDKkZjq8qCauS88Fo6sssaDG6ZmTrspnjy2NtQQwyEQg3rTQ2WpBDMHzmsIGOv0dyng3HFX7xXhGRlMvjcK/rl6li4gvyhDHuUXEy6Ww7mpyiQEZTNORZrgBN5u6aqz3UC/FHR396sESP49Vc901prwniBgK4Y0oaWWOPmIY/qQkyroXYyythKSDJJeUVBTUcdPd0kr2tUAqvzxy4ZdnrlHDQDLtdeSst1k0/ixM0nYHuH9gsKcaqF6ntzX7WhvPAic5FtrwPQDsKaxTWQBn+M++z5YW5U9k8jqa8ZBDUQ42fzRD1nyQsDErTgcBHhRK370QzbVG9IT6vxuyKsqRKWtoSXpaYiAJCtnY5WTNxfBCv3xm2Wjicc8voGsiKxNUX07rc2UOFN72hCAIqF2BcY3TSaotVxlWij1kmKT0NmdU/Ppe9EyLNng2IlwfzZuOjXrYL6b6ylWVfDLi5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk5BZ1BjelBXZmFyRVRTMG5Uc2pBQ3dKakNJOGZrTDZGci9Xd2h6Z1NiVFht?=
 =?utf-8?B?RzdDaDB3bnViU09GcU55SzhGaVB2MVhJOTI0TzJxU3d5ODMyUnJNd3k0cW9v?=
 =?utf-8?B?RWZUQ0RjNmtsQmlZdmtoY3hIR0h0dTdEa3QrbnR0RmdORGNxTEtGOHlHQnJW?=
 =?utf-8?B?MEpQeVk0d2Z2d3Zyb1A1ZFN2OVQxdVBpSExWSk5kUjlKTUZsd3ZtRWNWb0FO?=
 =?utf-8?B?L216b1VwVXVKaTFIOW95dVlOZjE2VkdweWR0VlRHeU5tRkJEQllrZkxxTzFs?=
 =?utf-8?B?dUtqNk5QdTN2c21yeEovNzRYczAzWGxISWRRM0hLLzdsdmxHYjlYNEVUMzBm?=
 =?utf-8?B?ZUdCRnhqTExlVUZ3bHpsc2ZBUWVOMkR3cEtiTHUzMVpXMEZJTmc1STROUExk?=
 =?utf-8?B?dVB5SDM0cmhOTTJ0MlAwNzhNYTZNc1ZkSTU0dmhSbVRGeHh0a0NUUGFZWFdq?=
 =?utf-8?B?M1pqZnVvajZzTms1MDV1UjJDRnRudFNDMm02dnh2bkF5amdaR2MzRkZJQzVV?=
 =?utf-8?B?Sm5jbWRFMVFQMnIrL2pWRkVDbG90WXlWcDBZejlTbm03TUhKNWNvK3h3UHJo?=
 =?utf-8?B?akxETDdMRFRudTRKYkM1dmJyUWVVVlhONmUyMzRCbE9qcnpjem5OMFJvamYv?=
 =?utf-8?B?eVN6MWsrd3d6Q0g1TXVCRmJZcE5nOUVEVG9uaVhSVitjUXlLZWQweFFZK0xu?=
 =?utf-8?B?TmdrRTdoNmhXY2xNMWQ5THd4NW5GK0VpYUxBcnlWa2RCdWZuSkZYbU9LRGxi?=
 =?utf-8?B?Wk5xTXhaVkdXT1ZENzNUVmhydG55RXBHQXpsWUFobXZOWHF3MlFUaXhmODVR?=
 =?utf-8?B?clY2VHhRdDdoMWE0dkRXbEEzTHZyYTV6bnZxUmZVNjQ4NjhIMjFLc2hvTGpE?=
 =?utf-8?B?WG9keS9kR1VVSDh5NVA0MDhBK0FkZW91N1ZNdVZHZnVyaXVOS2hBdXZEYVVm?=
 =?utf-8?B?dW5KVDlPVFoxUERUK1RTbEF6RTFuTFg4WTRHVyszVEhlcS9BZW42TitTSW5O?=
 =?utf-8?B?RWVkQlA5emw1azBQT1JlWThqZ3NORXFJYjE2QytsR2lJbllHWlFsQVdEV1Nq?=
 =?utf-8?B?RHNMSit1NjByZG5PK1RhTnlyYjN3NHBCZlF0bm1UTmdOdXFtdDFNWE5TNG41?=
 =?utf-8?B?K3IvVlBYZEduYVV0ZFRwZlFXRldpR200dGlQZTFMeGlZa3BRZkVpTHpXc2or?=
 =?utf-8?B?ZVlaVXBtM1BQQnpROHZNNm9Pd2ZPNnJDTEs1NXFjVHB0Nnk5ODJjMU5NNDBo?=
 =?utf-8?B?SDJNSk9jQytlaW9JSllMVXVrTU5FY0V0YzkvaWt0d1c2SWVGYndteEgzV3A2?=
 =?utf-8?B?QVhqQ0d4SE54MEhXUXAzNWtkVjFvRGlONDBobVdXVTNCNHhGZXR1enRndXlk?=
 =?utf-8?B?NVFGOTV3WGRWQ29Ba29oU0xtamtXeHFGZDJFN2VnODU1V0N0Sk5Ud3Btd3I0?=
 =?utf-8?B?bExkdGptenp3dDk2dW1hUTl1SGFLMDJIOG12YlVSV3J5VXhFQkx5WTNQeFd2?=
 =?utf-8?B?eFUrUmRGWHV4VUFmNlo0T0x3R25GYXNSaFRhbDF3Z2d5ZHFmOWx3ZVBtMjZB?=
 =?utf-8?B?M3p6cG0wSG5LL1FvN0hoZVBjeEFZVnRBSXdxaDNOWFNhYmdLR0FNTDZEbzNp?=
 =?utf-8?B?QVk2bW9lWW1yOWxRdEorVkVRampzQlVCQ01HNmtZRWhacURxNzVwdU9RU1Qy?=
 =?utf-8?B?cU94SDArbk8wZDY2d2ljaG1wQS91Q2hRWFl4Q3ova0dWdEhlQlNPVmpFTi82?=
 =?utf-8?B?Y3RpQTVEQzZYZ3R0QkdwdXkxQTJIaTRtdDBKY2tjTWlzS0hXREp1bk5xV242?=
 =?utf-8?B?UC8wbEdsMlNYSzUvSXZmcWp1Z2xoOTVSUkV5US9FaXF1SjNBSStNOGZhWXVh?=
 =?utf-8?B?SzcvL1ZweXR0SUxtNDVZVm9NYnNueGJaM0F3YWhuaittNkloanViYkdTK2Ni?=
 =?utf-8?B?ckVtalRJaGErckJuMXBqQnZTQkNJODd2TnJ6eTJNR0E0Y1RaYi9FY2tBTUxO?=
 =?utf-8?B?WEwvd0NteGdQSzBUanpFYlNyUG9pWDh2YUtiTXRXTEMzMlJpSkdlb3UwZlZB?=
 =?utf-8?B?S29FNGVSdWRlbG1Ubm5rcVRja3BlQWExR2pMTEVmSXMvclM2a0NSTUlrQkxy?=
 =?utf-8?B?dWlWci9INitGVkdKRURZVmVPeVVPMDFjVzZTQlVXODBENllvaDBYZEhDeEpE?=
 =?utf-8?B?bmpUelpJN04yR283NytBQUJHMjA5dHNlMnYyMlZPNURXR25YdmtWZ1dmd05V?=
 =?utf-8?B?c1RFNnY1R3I5VGg2WVp5ZFdrT0tYbUR1ckZyM2lwNFZpdy9LTi9scG1xUm5z?=
 =?utf-8?Q?R6ca3EaDMU4XK5EGV5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6be3a8-1ab4-4718-346c-08dee1ae41a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:46:07.7111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2jeyecmRr8uzBJMoG1obh4TIb/3Ml4ZEOEF5U9QhE19CnzpGQJL8AWvujavwJbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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

On 7/14/26 15:42, Alex Deucher wrote:
> On Tue, Jul 14, 2026 at 3:19 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 7/13/26 20:27, Alex Deucher wrote:
>>> Use this interface to issue TLB invalidations using
>>> SDMA.
>>
>> Hui? What should that be good for?
> 
> To use as a replacement for doing the invalidation using MES.

We should already have that as workaround for the Navi 1x SDMA bug.

I suggest to just move that code into a separate function instead.

But the SDMA can't do PASID based invalidation and that is what we need the MES for, so I'm not sure how useful that will be.

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
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> index 4f4e56022c970..4ab92d287675a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>> @@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
>>>                                uint64_t dst_offset,
>>>                                /* number of byte to fill */
>>>                                uint32_t byte_count);
>>> +
>>> +     /* number of dw to reserve per operation */
>>> +     unsigned        tlb_inv_num_dw;
>>> +
>>> +     /* used for buffer clearing */
>>> +     void (*emit_tlb_inv)(struct amdgpu_device *adev,
>>> +                          struct amdgpu_ib *ib,
>>> +                          /* vmid to target */
>>> +                          unsigned int vmid,
>>> +                          /* vmhub to target */
>>> +                          u32 vmhub,
>>> +                          /* inv eng to target */
>>> +                          u32 eng,
>>> +                          /* flush type */
>>> +                          u32 flush_type,
>>> +                          /* XCC to target */
>>> +                          u32 xcc_inst);
>>>  };
>>>
>>>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>>> @@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>>>
>>>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>>>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
>>> +#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.buffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
>>>
>>>  struct amdgpu_sdma_instance *
>>>  amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
>>

