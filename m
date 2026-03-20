Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FC0109319C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 09:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3183110E1C7;
	Fri, 20 Mar 2026 09:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gT35qkB2";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66ACC10E1C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 09:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+W7aGnMl29DqJkIeK5osvKx66+fwKSorta0KL8A0jL+oRQ4HQhwM54S/8MZdYefzcBpO13hrBbG3Fqvgqi+sMel26ey5GIHt7Ko8VxuRR+05UX3BQJPw0j4XMkF9134QYONlU9k03LtMMBwmr+Apqpf1WduoTsH4SJgU2AmFmNv9EMZsOiNvMKuikuNQuxxLcj2ppZRzr5L2hKIse4419wGZSS6RXrzuIYh/Cj+Hhp3c7DScto1NPS/Vqn7SyFKyZo+QW3XGRCxVdGIeh+IK9ToaPwmvoNZRQYTgSTwKvsMOGIvrURpMsVQKEdFPKZ0mBJQ3XHcODXY2uASuRR6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvCyoQZnOi3qHlemurmE/sHdwx6B7c7XPVmQ/R4V6rg=;
 b=qwfOdSwp1YHMBLDf8exXNUkPESHOqvGztbBgp1KS1F0Nh2ptoDYWbVcKZrNvfWqKxrSdM3J3QYUx7uHKJoXzQ8kTpZXTWFQf4N5axh0BVw0Uz2ni36OLlyo6ilU0AxDM2LSGtms5xWb9EMvTckZ8LbJY1ILvm4N7LHqvv3VXaEoUPqjLYfg2IVILPacnRifjYozaEl5n/ikd6RuuSgVouTEBrNihs93zp63cPXPIsvoI+Vi7pDEZ9Lc+qGbeNUwdeEGX4UbfreffKN29a+2LGLehpTjp3b4tp181a0qqX/qPF1AjkwRDiEKm7tT36S4e3gzUuYlyNuaL6p7BhChe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvCyoQZnOi3qHlemurmE/sHdwx6B7c7XPVmQ/R4V6rg=;
 b=gT35qkB2pN09s/Iw5iYHheI2R2F+fmocV/l3fyvSifCpvwHHC3OaRjSBSYeJxvQveS9cZohhNfbFLDH11aXKsCe7rs5zmMsX8xW1bzXiLFGJM/8XB1+DmJdxGk42Xgp15gbmOdgnGpsqxrGDpavigEHZ+Vn9qGrWwE/6AjtCF0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 09:17:52 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 09:17:52 +0000
Message-ID: <6a2a9e6b-c5e0-4e9e-a012-274a5c434fa5@amd.com>
Date: Fri, 20 Mar 2026 14:47:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: fix the userq destroy dead lock
To: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20260319082150.3324177-1-Prike.Liang@amd.com>
 <20260319082150.3324177-3-Prike.Liang@amd.com>
 <97824e02-f269-4ab8-aa05-369185e4cf11@amd.com>
 <MN0PR12MB600408189043102213210DEEFB4CA@MN0PR12MB6004.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <MN0PR12MB600408189043102213210DEEFB4CA@MN0PR12MB6004.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::11) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: b50aa938-9f2b-45c2-f239-08de86618ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1VQaf1y/0LBCTJW6OitSk+gEM0LN16hu3raMR1kAz1uojPMDKV1FbsHwbP/HSTUQaHczMK292cf+9T16z7Q5N5pEsnzfBWbGKx2TWWFESi8+BKiRZ2u4TrmXBIGjRYisF6VQttWm46FHRBIKku6N0opYzEY08jiTWnMHIbGVj/gmnnKraNUzezgNBJ20Gdq8h6EZhmFNrm93qj4fR1v0RfvoOhIa3QxFZsURYcmpdttRTvuChprLYVsZnMjNQ6QyY7vmMSceH+sgItYnhDiQQRc61IokXwSj9uSBJHasG4/rWN93f61+qTvI2Chs7jPwLpFdEF7ujbZVHFDESR1nhWH/lmgm4ZnvjbsgeauSY4UO+fOg4mOobgcHD2jh5nnkcuvhHcWHAB4rQN95bcfB6aHDzreT8US4JOr3QefXIHDhIeCUBEttEZJawmMZY3CfgpqUfXI1BqzAiTZ4pAAgrMWHg90XxKYOKIEPOh7Nxkdmwtwl2ftl1GH67oHIiEGsXUN7JtQ1m7WQXVmkYCE93zTuNJ6YF19WxW2vQ9Ds3hpG/3NrGIm47tCk8Xu5MsS4cbPlrxIVlB6tXEJh+3TLOEVBRzZoItkYwgd3CFPaWpCXPKGAFhKBMJBmUhCayrUtjso9intWVnS62i1TC/xEdupBo4pulicN80JhxKPMCZT0MGVKJM4VdoPCyWRTxZM/mK+QFny+q621OT5dEiPqrsmHox8pkYcQjacW0AmI7hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFU3d3lKdER2SzlYL3VUOTJwQUdPd3Z4QXU4TTNqVVYyWWVNT3lvQ0REdzhl?=
 =?utf-8?B?QUJyWkNqZFZwWVEwaG9TUlNSeGg0K2xydmFTWmpXT1ZLZ0VWeFZVNnNpR2pn?=
 =?utf-8?B?ZXlUeEF0U3JpNmM1aGhMWXFaSUVhRGNkUGd6ZW5sMHNPVFBidHR4REcrYjF6?=
 =?utf-8?B?c1FseDU4WDdMckpZYndDT044UlJoNFZObFR6bFkzMW83N2RRMWRpeVk0ZWlJ?=
 =?utf-8?B?NXZhczRuQStZU0QxZVpjOXprTk5OdVdSeDE2ckxrMG9YeEV1dHJZelVPV2ZI?=
 =?utf-8?B?dDNtTlI5UmhFeERES05IOGlscmRtV2lKeFplTkNrRmtjMTJWSkFRRVpMZ3o2?=
 =?utf-8?B?ak9OWDVEbEdQekpwRmRpQXBUNzdzOS9iZTVrQVF5TWVmVjMyeFVzdGFzaGlx?=
 =?utf-8?B?Y2JuVGNNcmgzeG4wMG0vQTB0NWJBUWhlVEVwNGhMdFVSU2tjZ0crbTNuNkVw?=
 =?utf-8?B?RW0zR2ViQlVjYTEzUS9zZmVIaDZUMWtWUnJuNTFUVmJqMW05a3hhcFpJSEZp?=
 =?utf-8?B?cWxGNEw4R3BTSjJwZER0aEx1WXFKSUxUWTN2dWtzL2NnKy8vbUIxYUg4Rkdx?=
 =?utf-8?B?NEVMbzNkdHczZkE2UXUwZnROYUhFWXRjc2ZOUXRWUHVqL1g0dDE1bmpreFV5?=
 =?utf-8?B?YTFsKzd1YzVkSjBBbmJQbkNBZGRLcVhHT3BIOGVROEhjR3FlK0lLYjdmdkVy?=
 =?utf-8?B?UFE2VXdHTHZpdEhjMGNNUVg2WlZGb3FLdVlXZ3k1Mjh2Rkd4cm9vaVJSSTBV?=
 =?utf-8?B?OE1yM2lOS3dkNnFxVzc0WEhQdVlRS1pUemduY1VhQ2Rzc01sWng4ZXhIaDla?=
 =?utf-8?B?UkZlRk5XczIzaGN0VEE4eHV2UFFhMi83WXN1blhCS0ZQdS9zTytuaXdQejBi?=
 =?utf-8?B?a3RDdnhXL1ZwYWlDUk5JWTl2aXYyazYrTkRDSlpQalFqOWQyNGNqVTNVc3pX?=
 =?utf-8?B?S0I4N21vNm5aYXFNTjYvMEVmVTkxdEwzM0ZLOHB2cm9aakI1RGtBQ1N3OXdX?=
 =?utf-8?B?YkM2OUw3UXlvZVkrRkhIUzhaTllQWmJXQ1ppRGQyWCtzc1o2RW1MT3NENG8r?=
 =?utf-8?B?N3VFWGFtWGtlTERsWmgyL2tJQU1qaC8zdlY4ckhQeUNWbHdtbHNqaHlsd3dX?=
 =?utf-8?B?S1o5UEIzQzNBRVlSM2t2WGNMSUFtWG9LT0tRdm5HdnFuRFZYNWZuOFc0b2xZ?=
 =?utf-8?B?bmNmY3MyNkdrVVFDSm1CNXg1a3ByR3dJU3JxK2ZDOGZZTGNHYi9rRDhoTVVq?=
 =?utf-8?B?SGo3akpENDdDSEhXeWlrVmdjdFNpeXp6ekZLSnF5WGl3V1hjT295Mll6MTlF?=
 =?utf-8?B?S3ZDVGZJb2pjdE1KQ25DWEc0bk9zbFV0WDNUbVdPbE93Q1RIY0NlUUxRRVQ0?=
 =?utf-8?B?eHdvSW1IbXU0TC90MFl4RktMS1VsTWJ5MGFxOVNaUGduUmxPOWJjeG1mY3NN?=
 =?utf-8?B?MXpqZXpiYk9haEJHZ3NGdXNHSFJXK3F1U2hXaFZZL0hpdzB5cGxLLy9kR01F?=
 =?utf-8?B?ckRDWkVJQVA1SHg1dHF4UHlLNCtHbFZaOFZKNHk1OUprQU9CWFZ0UUw3aDJx?=
 =?utf-8?B?R2hzdlJnNGI4YmRGRnduTnpiNCtuM2ZseS9FOW5YRGtrSDd4bURoVFpEanhm?=
 =?utf-8?B?VjMzdU5hNldGcXVXMnV0b1V4eXUweEFUemsyQ0VrUUJHR3FVb3V5cHNHQ3RB?=
 =?utf-8?B?RXc5YklYZGo0aE9nVjVwWVp0NG5DMXVHOXF6Y0hBVlFza3d3UVBXbmN0KzBq?=
 =?utf-8?B?czRBVVA3Zk9MVmZKT0VoU0daanlTcFF0UFpiRmIwOTRZZWI1REYzQU5DdFdw?=
 =?utf-8?B?YkpHYmh4UjNiQUtGVkZpb0N2d0tXdVM3WUcvdDRCRzc5ZHFQdmtnYThEVVNR?=
 =?utf-8?B?ZEpuMXZsbGdhd2RFY21BV1NoRG96VDlVNGpPUU9VYVVaZ0FyMXIzUnc0MHJL?=
 =?utf-8?B?ZUN0UVNldkVuSGRRaU9ISVhHeDdXU09reUpLQ281SDZ2SldENUxnRFVRWHo1?=
 =?utf-8?B?UXVoZEpRWE0zZFpKbzYwNFNZc1V0Y2puWTBzYktsZDAvcWo3Q1RleXJETFVv?=
 =?utf-8?B?UFllWHd1SjBFcnVmam82UnNMWGZVaE0xTHp5aC9iM1JxUGh2NU5NTlFzeE1j?=
 =?utf-8?B?T0lhS2NIdVI3M1p1OENXSWdnNFJyUDJ5Z0JNaHJ3bjZ3TzAybWUycktxc0dV?=
 =?utf-8?B?b2YzQXU3enBLZFk0dThwYUcvTlZZNW1BSVZLU01iSWtIZnd6ck9HQktKTVNx?=
 =?utf-8?B?ZVZBWUF1Z1NhRlJOTWZUUlZXT1VrR2pJZWExdFlaM3FHM1lSQVJMUEtGN0Ev?=
 =?utf-8?B?aGJRWVJJN0FNcTB5bnpTeW03cVVmMVVMTGFKMjFzdUNrdFR4anVaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50aa938-9f2b-45c2-f239-08de86618ffd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:17:52.0590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M84MH8nUwurZWo3bKx7KxCDSwXvQBdoZTC2HdmxwCMcpzzpxoq5adLs2xBl3bJNDGkWZ3d18VkDG4E9l+hoL6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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


On 20-03-2026 02:19 pm, Liang, Prike wrote:
> [Public]
>
> Regards,
>        Prike
>
>> -----Original Message-----
>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Sent: Friday, March 20, 2026 3:57 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH 3/3] drm/amdgpu: fix the userq destroy dead lock
>>
>>
>> On 19-03-2026 01:51 pm, Prike Liang wrote:
>>> In the userq destroy routine, the queue refcount should be 0 and the
>>> queue already removed from the manager list, so it must not be
>>> touched. Attempting to lock the userq mutex here would deadlock, as it
>>> is already held by the eviction suspend work like as following.
>>>
>>> [  107.881652] ============================================
>>> [  107.881866] WARNING: possible recursive locking detected
>>> [  107.882081] 6.19.0-custom #16 Tainted: G     U     OE
>>> [  107.882305] --------------------------------------------
>>> [  107.882518] kworker/15:1/158 is trying to acquire lock:
>>> [  107.882728] ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4},
>>> at: amdgpu_userq_kref_destroy+0x57/0x540 [amdgpu] [  107.883462]
>>>                  but task is already holding lock:
>>> [  107.883701] ffff8f2854b3d110 (&userq_mgr->userq_mutex){+.+.}-{4:4},
>>> at: amdgpu_eviction_fence_suspend_worker+0x31/0xc0 [amdgpu] [  107.884485]
>>>                  other info that might help us debug this:
>>> [  107.884751]  Possible unsafe locking scenario:
>>>
>>> [  107.884993]        CPU0
>>> [  107.885100]        ----
>>> [  107.885207]   lock(&userq_mgr->userq_mutex);
>>> [  107.885385]   lock(&userq_mgr->userq_mutex);
>>> [  107.885561]
>>>                   *** DEADLOCK ***
>>>
>>> [  107.885798]  May be due to missing lock nesting notation
>>>
>>> [  107.886069] 4 locks held by kworker/15:1/158:
>>> [  107.886247]  #0: ffff8f2840057558
>>> ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x455/0x650
>>> [  107.886630]  #1: ffffd32f01a4fe18
>>> ((work_completion)(&evf_mgr->suspend_work)){+.+.}-{0:0}, at:
>>> process_one_work+0x1f3/0x650 [  107.887075]  #2: ffff8f2854b3d110
>>> (&userq_mgr->userq_mutex){+.+.}-{4:4}, at:
>>> amdgpu_eviction_fence_suspend_worker+0x31/0xc0 [amdgpu] [  107.887799]
>>> #3: ffffffffb8d3f700 (dma_fence_map){++++}-{0:0}, at:
>>> amdgpu_eviction_fence_suspend_worker+0x36/0xc0 [amdgpu] [  107.888457]
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 50 +++++++++++++++++++++-
>> -
>>>    1 file changed, 47 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index bb5d572f5a3c..c7a9306a1c01 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -148,6 +148,52 @@ amdgpu_userq_detect_and_reset_queues(struct
>> amdgpu_userq_mgr *uq_mgr)
>>>      return r;
>>>    }
>>>
>>> +static int
>>> +amdgpu_userq_perq_detect_and_reset_queues(struct amdgpu_userq_mgr
>> *uq_mgr,
>>> +                   struct amdgpu_usermode_queue *queue) {
>>> +   struct amdgpu_device *adev = uq_mgr->adev;
>>> +   bool gpu_reset = false;
>>> +   int r = 0;
>>> +
>>> +   /* Warning if current process mutex is not held */
>>> +   if (refcount_read(&queue->refcount.refcount))
>>> +           WARN_ON(!mutex_is_locked(&uq_mgr->userq_mutex));
>>> +
>>> +   if (unlikely(adev->debug_disable_gpu_ring_reset)) {
>>> +           dev_err(adev->dev, "userq reset disabled by debug mask\n");
>>> +           return 0;
>>> +   }
>>> +
>>> +   /*
>>> +    * If GPU recovery feature is disabled system-wide,
>>> +    * skip all reset detection logic
>>> +    */
>>> +   if (!amdgpu_gpu_recovery)
>>> +           return 0;
>>> +
>>> +   /*
>>> +    * Iterate through all queue types to detect and reset problematic queues
>>> +    * Process each queue type in the defined order
>>> +    */
>>> +   int ring_type = queue->queue_type;
>>> +   const struct amdgpu_userq_funcs *funcs =
>>> +adev->userq_funcs[ring_type];
>>> +
>>> +   if (!amdgpu_userq_is_reset_type_supported(adev, ring_type,
>> AMDGPU_RESET_TYPE_PER_QUEUE))
>>> +                   return r;
>>> +
>>> +   if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
>>> +       funcs && funcs->detect_and_reset) {
>>> +           r = funcs->detect_and_reset(adev, ring_type);
>>> +           if (r)
>>> +                   gpu_reset = true;
>>> +   }
>>> +
>>> +   if (gpu_reset)
>>> +           amdgpu_userq_gpu_reset(adev);
>>> +
>>> +   return r;
>>> +}
>>>    static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>>>    {
>>>      struct amdgpu_usermode_queue *queue = container_of(work, @@ -627,7
>>> +673,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct
>> amdgpu_usermode_que
>>>      /* Cancel any pending hang detection work and cleanup */
>>>      cancel_delayed_work_sync(&queue->hang_detect_work);
>>>
>>> -   mutex_lock(&uq_mgr->userq_mutex);
>> Cant release locks here and we still need locks while updating hang_detect_fence
>> and all other functions that follow.
> It does not release the userq lock, instead of the mutex lock is already acquired by the eviction fence suspend work.
> And the hang queue detect I have reworked a bit in this patch which doesn't asset the lock when all the queue dereferenced.
True i missed that. But there is another problem we cant be calling 
below function with lock held as it causes deadlock again. as resume 
work and hang_detect too both takes lock again.
      cancel_delayed_work_sync(&uq_mgr->resume_work);
     /* Cancel any pending hang detection work and cleanup */
      cancel_delayed_work_sync(&queue->hang_detect_work);

>
>
>>>      queue->hang_detect_fence = NULL;
>>>      amdgpu_userq_wait_for_last_fence(queue);
>>>
>>> @@ -649,7 +694,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr
>> *uq_mgr, struct amdgpu_usermode_que
>>>    #if defined(CONFIG_DEBUG_FS)
>>>      debugfs_remove_recursive(queue->debugfs_queue);
>>>    #endif
>>> -   amdgpu_userq_detect_and_reset_queues(uq_mgr);
>>> +   amdgpu_userq_perq_detect_and_reset_queues(uq_mgr, queue);
>> Possibility of the deadlock seems correct and there are some other places too that i
>> found out. But we cant leave the locks here like this.
>> We still need lock to clean up and rest of the function.I am looking into it and share a
>> fix where we dont have to release locks and probably a better way
> We may need to resolve the deadlock case by case, and this patch arm to resolve the
> userq destroyed deadlock in the eviction fence suspend work. I hope this patch can help you
> observe the similar deadlock issue.

Yeah we could but i feel it needs a redesign or get/put which takes care 
from the caller itself in both lock already taken or not condition. I 
have one patch on this which fixes other corner cases too. lets
check if once.

Regards
Sunil khatri

>
>> Regards
>> Sunil khatri
>>
>>>      r = amdgpu_userq_unmap_helper(queue);
>>>      /*TODO: It requires a reset for userq hw unmap error*/
>>>      if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) { @@ -657,7
>> +702,6
>>> @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct
>> amdgpu_usermode_que
>>>              queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>      }
>>>      amdgpu_userq_cleanup(queue);
>>> -   mutex_unlock(&uq_mgr->userq_mutex);
>>>
>>>      pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
