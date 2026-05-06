Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C58ACD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A148910E0B4;
	Wed,  6 May 2026 07:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AGiGWg15";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD0C410E0B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA4/5uWhRXtm2WVI5o5z6Pwz0MHJHsaKkzproHbBeaMymyuPjj7E2MeV6qlBmthtPCcQ6hReSMCIfZyMgWxY1CeYZKFU2b/kmLHUz27++V1JZF7SIbP6InvjZ0oePCtlx2LqRFk19hrgdDOxBfXuwvcOa0hmG3rzKonBoCt8uw+aAxxi3hr1tVHq4FI6YdkRfgs0JMCn0IwXephxZINePSIkl2xOyKV10VOf6cxKktq2YCQmhRYOhga0PD7oR5G152yB8PwOYYnHSfC0RwZFpP8ja8r6f4dhxpcwnIE+b1wps5rh8NPzjqmWJGOaEU1qU/g2N02gbsX0ii1sewT+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPe+UQ9F96yDTLiCO1tFvo2WdwsGFHZmsyNAp/hAGc8=;
 b=qstziYKgSQgQg9/N6HWpmr1BecBCIKiKwg0fA3o56ck1bwxXdGgYi9wxK3kfuND/ecOfVfPmJyJJs//gIVEJUSlvy/vU2WHv0VK2aGVTb9ml5jJizmk5aKgvOpnQWysCKV5E08wOd+3ESkPrq1hYTpxYL6yDT0GquAbgKFBz+9nCGvzTUxEhqhw2sVuzDHYWTNGkoyyh8rT/gro1c5o1FlhLp/lG+IrRETp2i6JWssEE+mb+YcPeMr9hIGljjrH0asu+J2BY1dFkS4/+xjEbzCc8UE78/GhVJR+/Q8kY8bgwtf9A33cdcWig16SOGj854IqB7Y3rV76GT/tbPlaZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPe+UQ9F96yDTLiCO1tFvo2WdwsGFHZmsyNAp/hAGc8=;
 b=AGiGWg15S4gSXcke2EBRa3vQCHtMfp1WnIN4eq2vswBgCrMZuS6Yh3+Mv6lDZYo1kBda35YueugIUVzaQkkEyjkv6kcbITzbEHfVplMf4rWXqi62P6PTrkcPHA5W/QucMRhzFIzZRSPcQFScYyLOLzcfBUypeBY78bQoninoCPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 07:21:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 07:21:53 +0000
Message-ID: <d997108b-47e1-4769-b450-61ba6ce0a960@amd.com>
Date: Wed, 6 May 2026 09:21:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] drm/amdgpu/userq_fence: NOTIFY MES on SDMA UMQ
 submit
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
 <20260430161146.2851078-10-Jesse.Zhang@amd.com>
 <CADnq5_N_PwKyX4-gmDc7xWWB3AL0CVYJXzomgOXER0c72-c_oA@mail.gmail.com>
 <dcd83794-5387-4892-991f-4933845048db@amd.com>
 <DM4PR12MB5152E6B971F2830E7141089CE33F2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB5152E6B971F2830E7141089CE33F2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 1589e1fd-6606-4d49-c737-08deab402593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: qUm2LcvgFG0PJLSqAo/999j8zUpbMSi/ka0SP2kMLwCaLpKmG1ceE0Ay4T68bcjRSOmSvlGsxy6xXMyy5ZgXlPOGtU2cEqOKUMe1n/zfPfM5if5IDRMphfEgbDNmgRH1CHevobNM0IZR3sd2d3dtTEQyFLQWp/bTb5w55lnnGcK0BEeVwndwooNNZwiTX4pa4Xp618kjLLSeKRXKZH0bioz7/VKVB0JF9Pq8j+SJbSiQgcMbCzU4vK6DLUO8MS0alhC88ylFD1ttOJD/fOF0CsEUit4PDd9Lq7rH9SpVJhLrae9MDn0gIlGmR2EcoY1KQMC+5jWhJ4F1yM9zyEIpWny6PH2tNzp+z5PkyCHRWdqIF/idSCYI6NZfnRw2h7wxIQH9ccHcaC3oUIf5wQpw5felVOXiG6NNzfK+TVaOAh4NhtLLh05J23b2OVhs3BjWFttbA3VInQ2EEJmbd6644eN1W8qHDRMYL8RoAuUYhnZVrpKhHxVris9ZKvPC8aGNEMmWTGhgXLNkUigjWK+cXdliXeUSBWKFnqwOliRekOYRgqGlrqPpZqFb7huKu6sWyBscU7hlGUyGFrsUVdO7DXHUztCeBcVV+OIu5qvfdWWSGYQKWVqe93ugoUFKF1JaqEvRxeYghcK/ASrL/X7FU7FGKYiBm0Yq37pyBEzGJ0qnpcmpd0OzWYra1Vq3mtFO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ZrZTVPRE9JclZ1TlRYR3JMck5TNTVYOGRrNFhHdGVqZ2ltNEVzNER2TGxC?=
 =?utf-8?B?ODBuZFVtM1BkTWFXMldWMmpZY3lSc0NRS2FsMGEyZGlhRW5abG5BSEVqMDIz?=
 =?utf-8?B?eHVzSW1lakJRNDlYc0RMbi9FbkQvcU5CbjMzeTBZZklZRTVjRlVKT3RyeTV3?=
 =?utf-8?B?SHBYVC84WDZFMDB2VjdsZURCTUpSZys4bFlRK3JmOGlTd3VrOXhhODdjaGdK?=
 =?utf-8?B?WmpUMWxhN1A5UXJUNGZBa2s3OExNQndWbXhHUVBtU0F6M1VmNFFwdS96bUpa?=
 =?utf-8?B?ZXdZbkpGM2ZvTmwyU1VMa2owQ3lDdUJzVjIyZ2xzQ3FZdTI1MVBXaFNZYmpW?=
 =?utf-8?B?K1Ruc2tPKzdWcldIMHhRTVN3QVdDUHhQY0RLRFNsZUhDTlR2WFZyNEVObU9j?=
 =?utf-8?B?UDBncHBKdTA1OHpsZEZmUEM4RzJicC9yMjlid1poc3RYcVFNRkpkUkxzVEkv?=
 =?utf-8?B?STBRTkpERVM2M3kzWTB2bG0xaGRVOTk1V2IvMFJ2MmRmUThyNmx2WjBiYVdB?=
 =?utf-8?B?MVhiNnpxUUpLUlJlYjBpT0ZGS3RrWG5JcFJUWXByc0hXNjluZkx5YjIxNjhw?=
 =?utf-8?B?Z2ppMEtkSWcyZDJLY2JOeng1S0MwR3NnVVduQmxFT3V5RHc5bWhpUXA5Y29n?=
 =?utf-8?B?OG9Cdkd6eFFOalZtQlBkaDBEY0tsQXdRL0NWRjIzQUY4K0h1elFjQ2ljSDds?=
 =?utf-8?B?T1RSSDhIM0lTUEVxalJDT1d4ZEFtTlFCWFpTNFQ5VCtnSFBEaDRHOW5YMFpY?=
 =?utf-8?B?cFU3bldkbTJPVEpiVnNKelhTMVptMjRnUkMyeVVVb2l5UXVtclRlNnltRW13?=
 =?utf-8?B?RkZ2ZWhBVkRyRmxCWDdIVEI0S0QvWjZZMFlzUHloOVZRcStXMmV0N3lXL1cy?=
 =?utf-8?B?dVQzb3ppRHpBVkcxaUxKSUhNWThreXFnQUE5L1pramFGaWtKVTRsaWcwdWJ4?=
 =?utf-8?B?bGdQWXhOTmRJVis4eWFDVUVSNy9sZno0RTBPR3pyUnJZZytHZGJmVjBSMXhI?=
 =?utf-8?B?ZklIWDZhYUQwWGFFanI5M0JiU3BhU0pHam5Oc3h1eG9MdlpDa2xZMUFuMk9x?=
 =?utf-8?B?M1ZVZHVGd05US056L0VWbEZFZmJvYTRIdE5wclVlWXk5ME02Uy9Ua3NCQjRS?=
 =?utf-8?B?VVVORFNqdi9tUjVpOSt6SmthakoxZVArQStQZjFqVHpDV1BROVQ3RU0rOFRC?=
 =?utf-8?B?Skw0cHlDT1dYWElTSmp4VU4xeVl4a2hBeW9mQjZJUXhMOWp2UEhEM3N0MHNu?=
 =?utf-8?B?MXBVZHVYcjF3Vkc3c2syLy96WDVveGZ3UXNjTlZCVTV4RmY2dE5kVWFBekFQ?=
 =?utf-8?B?N0Ewb1BPa1lyWXI1T2RzaVNQWkdnUk9odVU1cjdlbm50WjB2eXg3ajZrdmpz?=
 =?utf-8?B?QktIcm9hWmNPOE1iZ29lQXUzREQwd252OVJxN3ZIQ0gyVzdQRmJpRjlaaks4?=
 =?utf-8?B?TXJPbmN2V01ROXFScDJWeGRtSFYwSWZtb1FBNGM2aW9sY2FlTHNxNzBYSUc1?=
 =?utf-8?B?Z3BjSGFzOFhBeTRsSnJWUUt6N0FTN3ExcW0zM1lrME51SWFmMnRNSUZzN3JD?=
 =?utf-8?B?S0lncjVhaVMvWVE0MDZLZUNFZVo0aVYrN2hXL3Q5QWZJaEU0LzV5NktjemZS?=
 =?utf-8?B?OGNGTGNMOHNySmxiTm9RWHQxaStvSzVGTHlrS29DQmZvUDRvZDZzYVpTNElS?=
 =?utf-8?B?VTdueVRqZ0tiMVFyQUlBV1c5Ujd3Si9OL0NXYUhTQS9BNm1xb3FNUXVTbHdo?=
 =?utf-8?B?MFBCTUErZkJHVmw1WnE5RHc3cG9hekdINVlYNXBOTDc3ck5xSHMyN05jWHIr?=
 =?utf-8?B?KzdiR2JRMDdzSW1sL3poWFVqalFCdm4vVmE5blJFUER6SnpvejlvVW11aHFs?=
 =?utf-8?B?Smptd0JBZlIrYzY5bE5wbDNmbTA3QWhQYUJ0U2ZzU1JweHFaZnpySDExdFdR?=
 =?utf-8?B?aHgvSGp4RlRhb3IvUi82VUFvOGtjU2k2eE5TM1M4UkgzbjRZdEJ6RFJOZGhL?=
 =?utf-8?B?emIyN2F5R2paMTZxNkZabDhITUlRemlodi8zbERQM29rL3kxMXhDVzhHa2VJ?=
 =?utf-8?B?d0FDRXlsMWRDYXpzSndUWThMMlVPYTJJU1ZzbzN2ZkxiSnRiMmpkS2IyUmw1?=
 =?utf-8?B?M21PNzFRK1RxUVk2M0tJanNMQ2dQOHJmQ2pQemdSclhMMDk3Y0RnTnh1NkFl?=
 =?utf-8?B?ZWIxMXlEZFFRY3BvZjVTVHpqNVZZWm1RL0RPZm4rSDVlQzlXWDN4MGRXMzQz?=
 =?utf-8?B?cU1mUG9IWHlQTW5JeHBFU29ZYTRTTzc4N1F1RFJFY3d6Q29zdVJ4aHhEaXVB?=
 =?utf-8?Q?izypEMvqlAwLE0WJPc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1589e1fd-6606-4d49-c737-08deab402593
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:21:53.0962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zAWIA/oBZ24AFqefEwwssaYscWYg3ZelNZNRFZX5zNHsSoqyCMsIxnrkTVHFZM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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

On 5/6/26 08:08, Zhang, Jesse(Jie) wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, May 4, 2026 5:01 PM
>> To: Alex Deucher <alexdeucher@gmail.com>; Zhang, Jesse(Jie)
>> <Jesse.Zhang@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v4 10/10] drm/amdgpu/userq_fence: NOTIFY MES on SDMA
>> UMQ submit
>>
>> On 5/1/26 15:30, Alex Deucher wrote:
>>> On Thu, Apr 30, 2026 at 12:29 PM Jesse Zhang <Jesse.Zhang@amd.com>
>> wrote:
>>>>
>>>> From: "Jesse.zhang" <Jesse.zhang@amd.com>
>>>>
>>>> Pair the userspace aggregated-doorbell ring (added by the
>>>> AMDGPU_INFO_DOORBELL /
>> AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL ABI in
>>>> the previous patches) with a kernel-side
>>>> MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE in
>>>> amdgpu_userq_signal_ioctl for SDMA UMQs.
>>>>
>>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>>
>>> How will this work if the user doesn't use this IOCTL?  protected
>>> fences are optional.  An application can create a user queue and never
>>> use a protected fence.  Why don't KFD SDMA queues need this special
>>> treatment?
>>
>> Yeah agree that whole approach doesn't work.
>>
>> What we could do is similar to the MM queues that userspace need to signal both a
>> per queue doorbell and an aggregated one for the queue type.
>>
>> Regards,
>> Christian.
> Hi Christian, Alex,
> 
> Agreed, and will drop this  patch.
> 
> The MM-style userspace ABI is already in place: David's agdb_bo
> (AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL + GEM_OP_OPEN_GLOBAL) plus patch 9
> (AMDGPU_INFO_DOORBELL reports the SDMA agdb slot).  IGT rings per-queue +
> aggregated on every submit.
> 
> The remaining gap: on MES12 , a bare agg_db ring does NOT wake an
> unmapped SDMA UMQ — MES needs hasReadyQueues set, which today only
> NOTIFY_WORK_ON_UNMAPPED_QUEUE flips.  This is by design, not Linux-only.
> The Windows UMQ path  also uses the same
> contract — MES writes 1 to *unmap_flag_addr on preempt; UMD checks the
> flag and calls NOTIFY before ringing doorbells on the next submit.
> 
> Next version v5 (matches Windows):
> 
>   - Drop patch 10.
>   - Keep David's ABI + INFO_DOORBELL.
>   - Add a small standalone NOTIFY ioctl (e.g. AMDGPU_USERQ_OP_NOTIFY_WORK)

Completely NAK to that approach. This not only results in problems with GFX userqueues but also completely breaks ROCm.

It looks like we need to go back to the drawing board with the FW team and avoid such workarounds.

Regards,
Christian.

>     so UMQ apps call it on demand.
> 
>   Is it  the right direction?
> 
> Attached test results (current v4, with the to-be-dropped signal_ioctl NOTIFY):
> 
>   HW / fw : gfx12
>   Test    : IGT amd_userq_sdma stress, 100 iters
>   Result  : 100/100 PASS
> 
> So the agg_db + NOTIFY mechanism works on hardware.
> 
> Thanks,
> Jesse
>>
>>>
>>> Alex
>>>
>>>> ---
>>>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29
>> +++++++++++++++++++
>>>>  1 file changed, 29 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index a58342c2ac44..50e275b51c9e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -598,6 +598,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device
>> *dev, void *data,
>>>>         /* drop the reference acquired in fence creation function */
>>>>         dma_fence_put(fence);
>>>>
>>>> +       /*
>>>> +        * SDMA UMQ wake: SDMA has no CP_UNMAPPED_DOORBELL HW
>> intercept, so
>>>> +        * once MES gangs the queue out (after the first IB's
>> PROTECTED_FENCE
>>>> +        * idles the queue), per-queue doorbell rings hit a mapped-out HW
>>>> +        * slot and are silently dropped — FENCE IRQ never fires.
>>>> +        *
>>>> +        * Userspace rings the priority's MES aggregated doorbell directly
>>>> +        * via the agdb_bo mmap (see AMDGPU_INFO_DOORBELL +
>>>> +        * AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL).  That alone,
>> however, is
>>>> +        * not enough on current MES12 firmware — MES will not scan the
>>>> +        * priority's queue list unless its hasReadyQueues flag is set.
>>>> +        * NOTIFY_WORK_ON_UNMAPPED_QUEUE flips that flag, so MES
>> then
>>>> +        * processes the doorbell ring and re-MAP_QUEUEs the SDMA UMQ.
>>>> +        *
>>>> +        * This is a kernel-side companion to the userspace agg doorbell
>>>> +        * ring; remove once firmware learns to wake on bare aggregated
>>>> +        * doorbell.
>>>> +        */
>>>> +       if (queue && queue->queue_type == AMDGPU_HW_IP_DMA &&
>>>> +           adev->enable_mes && adev->mes.funcs->misc_op) {
>>>> +               struct mes_misc_op_input op = { 0 };
>>>> +
>>>> +               op.op =
>> MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
>>>> +               op.notify_work.priority_level =
>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>> +               amdgpu_mes_lock(&adev->mes);
>>>> +               (void)adev->mes.funcs->misc_op(&adev->mes, &op);
>>>> +               amdgpu_mes_unlock(&adev->mes);
>>>> +       }
>>>> +
>>>>  exec_fini:
>>>>         drm_exec_fini(&exec);
>>>>  put_gobj_write:
>>>> --
>>>> 2.49.0
>>>>
> 

