Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06849CDB481
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 13:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9399310EF1D;
	Wed, 24 Jun 2026 13:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xM3hwOHW";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69B710EF1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 13:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8FPRxXRW/lETip0NFr65WS84ETcn2t86rEKSrLjF+YVwjLFOvsRHISxc+qKgA//HCqD0jMH5Ox07EKOsetFzgkhhTKkd3O31RlMoPa9Pc3r/NZrbFYDKLIU73nMDvbJPFgWnuJdSxBqlVNFDcyFYzSpgbSa0ZlGuzKHaouNlRhLJzxT69/dl/XGclgOOAwkzxJuDatcPgsS/9n7Ygt4SOcDGZW1xfreoXHym2DfLdkYSoQcN03t3X+fm9YjaPEroYkCy2WZ16mtpftBbSVSB5TBtQfkeq7/mRSRn8MjAbPLn/ZfBzQjhB4n4AtQQEk6SV/hFGTqGKrdmxeytMZitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUBETALK10+RI5ct+7RQyK0TitucIWwQQjt3lNRpRvA=;
 b=W3NROjuNt9G7BURCWQyBSgI9RbASgC5ifmutGDlmd++PYUNSHg6QpgFCazJKKMv2UHhuNehhaJyB9QIv0MjXfy6z5L1QzWzFphb2q0eMwNUhXOc7BEb28RgoFY6ZK/s2d3JTp42e8ZSXePYZBh6RG6Qi++SZuBYrSBdj1c+NcmNVt3xsnh5DzwKKksmdLC3DjfcA6Kugj4M5O4SmhTOeNk4fGogwDHC4iqlHe7tO4P2/KX9SGS5TtSjKxEvajEW7T634UgQ+O1UdgpIDdBHD6Jht1wd8PadqQ1T2dqwz2ApDHgiB5EcvHQZ7a0UoN4llXvseLNucogVlpCXFm5HZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUBETALK10+RI5ct+7RQyK0TitucIWwQQjt3lNRpRvA=;
 b=xM3hwOHWEiKqA8THkdGys++di1iMfgx2GKxvP8eF61Zd1p4plJcY0477xOoCbCqb5pxMggQmphrRIZAvI7ZzGNoiO89j42kVJ9oIz+Aj/yYT7GVSJwF5A4b9IDszvTDm5R4X+7wItGpWgH9/zHy6+tHwk9Rhd/ALxgtxXEwMsNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 13:10:56 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0113.015; Wed, 24 Jun 2026
 13:10:56 +0000
Message-ID: <efdcaa38-edcd-4ff4-b9ae-7b9fa28574c7@amd.com>
Date: Wed, 24 Jun 2026 18:40:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and helpers
 into header file
From: "Khatri, Sunil" <sukhatri@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: alexander.deucher@amd.com
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
 <20260622195729.181216-5-shahyan.soltani@amd.com>
 <8f135ee0-7d1d-4af2-aa89-36fb2265a66d@amd.com>
 <aa6d3b80-fff5-4cb3-a613-c67804edcc5f@amd.com>
Content-Language: en-US
In-Reply-To: <aa6d3b80-fff5-4cb3-a613-c67804edcc5f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0144.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::16) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: ed881fd6-73ff-4e76-ac6f-08ded1f2068e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|6133799003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: a1ClDuJCMxmlxsWcg5S6NDMAEJSXEcFRQHAT3TND2pWjinLutDURDmUVq0PzPFNvgH/OEGCtVzlm/4YKnMVtJ2bNBOaP2EqTSAV/QJ6gAy0Yv810gBF3eCKliR3IcptP04Wt4quzZ52rWV/sv5KHQNYv0w649SD4rJDIXVL9ldXwFhpNiwNzNoiIDGij8nB0TBYGJ2It+UjDX1bas6WD5mzwOVYARrTSp6UyTI9tiJ0EZ87bE6gfaCmg9fg+e/RzqHT2g0NqkV+nA6xjyQguF7Yxu7xm4af+it3uCgFwnlD2NNFE4g1xU3l4yv43Qa7FwednTZhGUr81oUaZFeA1G4ZINY1XEFsC6yj1LVzxjlR2ueU2ImGeewSxFypQeM9a7I4154NjRM/ULdg4mzCE3sEwkwZ4YVzlCov5XZ53YwiF9iWab1+X3n9O5CCpAZEycrYD3MGj+dg3L0c83LJiJD3fXmWuYUgIwlc/jlaTmRu/BU1gIUwAAsacUtVLm5l7t35QRstlb4PMJU4v8DdSX7hgOtxhDN6ztQxHfl/PPnHnNetsjnVugcXNN2mnvBEHa87Itf5sO+gdCnXpOupHzZOKIheKBbKBS0BOuftmPAKDgSz7coL/qmcjyqiIS0y5PSvdYTJmehklygV0iGtM6q/GYPbckIcVLtrNfjksMAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(6133799003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MERGRzFyME9lc1M2bUFhd2M2OUtadFNmOW94ZzdZcjU0OXVtU2xkR1hhNXhP?=
 =?utf-8?B?VUFMd2duSDFQTGo2S1VzUmViRUw4emlGVVQ5MnJUMWpDa2hNaDNRaFNxYWhE?=
 =?utf-8?B?U2ZPbGIxRkJQRlRrdHFlT3dkWk4zdWRyUjNQY0RZT1U1cmFqdi81TnNMTVZ3?=
 =?utf-8?B?MSs4OFc5eWgyTVM2NGV2b1ZyZ1RGQUVncWZ1ckRSVkkzbW5kWXFBZzY3czd5?=
 =?utf-8?B?VTBQQWIvcDM4blJveTlwaFhZWnFFY096eGY3MXM0emJHUCtEaWtlbnhhcE05?=
 =?utf-8?B?V1BXb2xxbS9FNWtXWXI1ZDYzbzNDTTJ6Wm9uZ240VHRWait2QmNwQUxCMVlF?=
 =?utf-8?B?UWpPZzlRMmVOeVU4REdYUU40bmVrSUhnVnZWWHpQWnF5dVlVWDFuazlpNXJ2?=
 =?utf-8?B?S1lGN2NjY1RWRTNsYlhZbWU1L20zYTI5MmxCU3pIT25Cc0RYYlIzQ1Q2M3U4?=
 =?utf-8?B?TERGc1J2d3ZBS2tINUh1Y3p0YisxZXBWQmZDazJoMk0zellsSUcxSWgya0JX?=
 =?utf-8?B?OGM4MzBlcis2R1lXejJxcnF0VXhmR1Y5SHFzV0dYOEVrakFzSTkwcEt0L1hW?=
 =?utf-8?B?QWZQcCtHSXVPMVgyRkZHWG51cHB1NmVCWk91TjMwNjRvTmowaVdnMmhidjRO?=
 =?utf-8?B?T3czNzlVWXI3ODJXcHh4NkhRZVZ3RUQ0eUlROFVjYjhzWUxxYTE0b3NBNmNu?=
 =?utf-8?B?cllZSkRsM2hTTnJ1VmtYT2p4RUdTREc2WjFiQ3djVjBtVU82Mm1vejc4eXdF?=
 =?utf-8?B?RThaU0xjemxQRW91V0lTNmJmT2JLYUdjcEtkdVJBVDkwKzlCWkdncE1wUmRE?=
 =?utf-8?B?d0pjV3lQaEw0RTdNbUdSeFN4WE1EcGJHZHpYNHkyWVllcXZ3L0xNZjRzdUlQ?=
 =?utf-8?B?T2tuQktpeEc1azlFUHVoQmdwanBNNHZzd2svU1V3NGRNeVJCeGpIbi9qbnpP?=
 =?utf-8?B?Z1BYbUNYT25SSFdjMi9DT0dMR2daa3hreXo1TDFYbEEvMjgyaEpXUHBzSnlP?=
 =?utf-8?B?S2E2Rysvb0kzakFmcUZZVURLdDlhV2IxU2JxNkZyNzVCY0lDZFlYZmR6UWZ0?=
 =?utf-8?B?RW40UG5OdDhENHNuYmFYUWM0SDg3eG1QV09RTVFheEM3Z0luWDJhaTB4cWZt?=
 =?utf-8?B?Q3g1eVJaUzVzdFNsRGI3U2w4RXh1YjBDeXo4ZWhqdU02YkZ0U01tQWNobUNl?=
 =?utf-8?B?QW9tNE10M2NpbFo3emhoYUdOa2VZU0lhcHRqRnhZOGVRNDBHUFBacnh5Y0hZ?=
 =?utf-8?B?a29YbkJzZTNFejVBU2FWN3R4N3NLUHhHNkhaaE5MbzVpSXczdnpLM2htVXY4?=
 =?utf-8?B?V1JtWFkweVo1eC9RQ1MyYVEzTmE5cW5idDJGcGVWSTZlYTAwNU1jNWNQTWt2?=
 =?utf-8?B?YVJMUmlmYnkyOWVWVU5LQk1PR0xxdklERTlKNnphV1JmTXRlN1RzTzMxUDBJ?=
 =?utf-8?B?NlE2YVpvYkx1b0d1VEtMdGplVE1CODQva1hTZkpBd1MweVJGa2lEUzd6aUts?=
 =?utf-8?B?b21LUGNkOGVzNnJhd09DdFVsQWp0aWQrdkFmME5RTWMvV3VkWnVPYklUZFIr?=
 =?utf-8?B?MG5JbFJPcEpHNjBxL2hzS2JaaFp0akR4ZVhuZnFQSjhLUjBSN3RsalYyV1Ba?=
 =?utf-8?B?WjdRL0J2cGZ0dmlwMW9SdXJzVVczVHpuYTc0TlRYTHdpNUlCK2tVNG9wNWdI?=
 =?utf-8?B?aDd1LzZBaFkybGRhMFJtTVIxd281V3hmZjhtcjA1UFIxR0tNai96K3dDc3c5?=
 =?utf-8?B?MUcvVXRVSWV3US9kSERJMFZYMWR5U1ArRTJZdDVkVWVqQU5OL0taeUh5Skxn?=
 =?utf-8?B?ZE1yd21oaUhlYXdWMWl6R2N0OWh5TzJ2T1hVZWJ3VWxaaGNKZmRpVzc3bnFF?=
 =?utf-8?B?MWcrQkZSemRCdjhUOXQ3RC9XZERXa0tNL1FIcDR3NlBxSnQxL29CQ0VKZGRP?=
 =?utf-8?B?MmU0eG5sRTREcVZ0b2haWkhZYkhCQ1dTMXdPMExRV3UrcWUxZlN5Y2xrNmdk?=
 =?utf-8?B?blpSLzhFMDJYcTJVZmNXZzFhdURqeWtpSUQ0SS9KQnlQU3pvaHR3bVVOUnUw?=
 =?utf-8?B?L05yMjJ6ZkhLZ0txMjIrZDJNY1J2enpqdkE4alB5ZVdLSE5KUk84Tnk4NDNs?=
 =?utf-8?B?ak5QOEFBWCs2NkFZVG1zZjlKbFpPTEpjd1ZFbXBsVkVaOSt3SlJYZ0U0ak9C?=
 =?utf-8?B?VFJJcGpBdlJkaVU5dDFKTjluNGI5Y3p0bHlCRDI4M0FBdW8xYk9ORUppai9q?=
 =?utf-8?B?VTRuQXphK3Q0VzFnQm02a3U4QVBIaVJGTE4rYld5Y0RWLys4aGtNQ2JtT2F6?=
 =?utf-8?B?N0MyNko0YTVkMjJRTGQ3WUNNNENkek56MTBsTGs0NjI0VHRjTW1SQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed881fd6-73ff-4e76-ac6f-08ded1f2068e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:10:55.9208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqWJ0lILqMhp9sWwiHAbFTW6S9NSbaFzo7i+BKTy1S/D32ix5oQTB+YJ6CQU6BziFPE8838sSDxRLyNN2lumug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
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


On 24-06-2026 06:29 pm, Khatri, Sunil wrote:
>
> On 23-06-2026 02:34 pm, Christian König wrote:
>> On 6/22/26 21:57, Shahyan Soltani wrote:
>>> Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the 
>>> monolithic amdgpu.h
>>> into existing amdgpu_mes.h file.
>>>
>>> This is part of the ongoing effort to reduce the size of amdgpu.h 
>>> into their own respective
>>> separate headers.
>>>
>>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> @Sunil can you take a look at that as well? Just to keep you updated 
>> on all userqueue stuff.
> LGTM,
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>
> Regards
> Sunil Khatri
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>> Following v2's feedback struct amdgpu_mqd and helpers were moved into
>>> the existing amdgpu_mes.h instead of creating a new amdgpu_mqh.h file
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 48 
>>> +------------------------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 ++++++++++++++++++++++++
>>>   2 files changed, 47 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 61608acc0393..ca86cef62f44 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -96,7 +96,6 @@
>>>   #include "amdgpu_doorbell.h"
>>>   #include "amdgpu_amdkfd.h"
>>>   #include "amdgpu_discovery.h"
>>> -#include "amdgpu_mes.h"
>>>   #include "amdgpu_umc.h"
>>>   #include "amdgpu_mmhub.h"
>>>   #include "amdgpu_gfxhub.h"
>>> @@ -115,6 +114,7 @@
>>>   #include "amdgpu_eviction_fence.h"
>>>   #include "amdgpu_wb.h"
>>>   #include "amdgpu_ip.h"
>>> +#include "amdgpu_mes.h"
I remember one thing, if you moved them from amdgpu.h and again added it 
via include "amdgpu_mes.h", there seems to be less benefit of it as its 
always there in amdgpu.h. Just check if there is a possibility if that 
include could be removed totally and include amdgpu_mes.h explicitly 
only where its needed.

Regards
Sunil khatri
>>>   #include "amdgpu_sa.h"
>>>   #include "amdgpu_uid.h"
>>>   #include "amdgpu_video_codecs.h"
>>> @@ -609,44 +609,6 @@ struct amd_powerplay {
>>>                         (rid == 0x01) || \
>>>                         (rid == 0x10))))
>>>   -enum amdgpu_mqd_update_flag {
>>> -       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
>>> -       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
>>> -       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
>>> -};
>>> -
>>> -struct amdgpu_mqd_prop {
>>> -    uint64_t mqd_gpu_addr;
>>> -    uint64_t hqd_base_gpu_addr;
>>> -    uint64_t rptr_gpu_addr;
>>> -    uint64_t wptr_gpu_addr;
>>> -    uint32_t queue_size;
>>> -    bool use_doorbell;
>>> -    uint32_t doorbell_index;
>>> -    uint64_t eop_gpu_addr;
>>> -    uint32_t hqd_pipe_priority;
>>> -    uint32_t hqd_queue_priority;
>>> -    uint32_t mqd_stride_size;
>>> -    bool allow_tunneling;
>>> -    bool hqd_active;
>>> -    uint64_t shadow_addr;
>>> -    uint64_t gds_bkup_addr;
>>> -    uint64_t csa_addr;
>>> -    uint64_t fence_address;
>>> -    bool tmz_queue;
>>> -    bool kernel_queue;
>>> -    uint32_t *cu_mask;
>>> -    uint32_t cu_mask_count;
>>> -    uint32_t cu_flags;
>>> -    bool is_user_cu_masked;
>>> -};
>>> -
>>> -struct amdgpu_mqd {
>>> -    unsigned mqd_size;
>>> -    int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>>> -            struct amdgpu_mqd_prop *p);
>>> -};
>>> -
>>>   struct amdgpu_pcie_reset_ctx {
>>>       bool in_link_reset;
>>>       bool occurs_dpc;
>>> @@ -1034,14 +996,6 @@ struct amdgpu_device {
>>>       struct amdgpu_kfd_dev        kfd;
>>>   };
>>>   -/*
>>> - * MES FW uses address(mqd_addr + sizeof(struct mqd) + 
>>> 3*sizeof(uint32_t))
>>> - * as fence address and writes a 32 bit fence value to this address.
>>> - * Driver needs to allocate at least 4 DWs extra memory in addition to
>>> - * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE 
>>> for safety.
>>> - */
>>> -#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) 
>>> AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
>>> -
>>>   static inline uint32_t amdgpu_ip_version(const struct 
>>> amdgpu_device *adev,
>>>                        uint8_t ip, uint8_t inst)
>>>   {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> index 5255360353f4..7b4cfb5c8f83 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> @@ -438,6 +438,52 @@ struct amdgpu_mes_funcs {
>>>                     struct mes_inv_tlbs_pasid_input *input);
>>>   };
>>>   +enum amdgpu_mqd_update_flag {
>>> +    AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
>>> +    AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
>>> +    AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
>>> +};
>>> +
>>> +struct amdgpu_mqd_prop {
>>> +    uint64_t mqd_gpu_addr;
>>> +    uint64_t hqd_base_gpu_addr;
>>> +    uint64_t rptr_gpu_addr;
>>> +    uint64_t wptr_gpu_addr;
>>> +    uint32_t queue_size;
>>> +    bool use_doorbell;
>>> +    uint32_t doorbell_index;
>>> +    uint64_t eop_gpu_addr;
>>> +    uint32_t hqd_pipe_priority;
>>> +    uint32_t hqd_queue_priority;
>>> +    uint32_t mqd_stride_size;
>>> +    bool allow_tunneling;
>>> +    bool hqd_active;
>>> +    uint64_t shadow_addr;
>>> +    uint64_t gds_bkup_addr;
>>> +    uint64_t csa_addr;
>>> +    uint64_t fence_address;
>>> +    bool tmz_queue;
>>> +    bool kernel_queue;
>>> +    uint32_t *cu_mask;
>>> +    uint32_t cu_mask_count;
>>> +    uint32_t cu_flags;
>>> +    bool is_user_cu_masked;
>>> +};
>>> +
>>> +struct amdgpu_mqd {
>>> +    unsigned mqd_size;
>>> +    int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>>> +            struct amdgpu_mqd_prop *p);
>>> +};
>>> +
>>> +/*
>>> + * MES FW uses address(mqd_addr + sizeof(struct mqd) + 
>>> 3*sizeof(uint32_t))
>>> + * as fence address and writes a 32 bit fence value to this address.
>>> + * Driver needs to allocate at least 4 DWs extra memory in addition to
>>> + * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE 
>>> for safety.
>>> + */
>>> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) 
>>> AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
>>> +
>>>   #define amdgpu_mes_kiq_hw_init(adev, xcc_id) \
>>>       (adev)->mes.kiq_hw_init((adev), (xcc_id))
>>>   #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
