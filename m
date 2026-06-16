Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF5FCD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A22C10EB7B;
	Tue, 16 Jun 2026 12:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BohMP7Bi";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012027.outbound.protection.outlook.com
 [40.107.200.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E92310EB75
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADFWw0WICityRvL8kWcZyBO6LGWB4uQz/kdNxeCjajQJ3fCvpq/bqu+ZeW93joAYENVGNEaU88SgN84U4C7q1vdH6QYSd21Yjy7umXTG960BXOS9oLLBk3comYZp0KgP8xcy7082+RCl86FeRW4IgQMvW1eFCfTpvsnCesl/IqKoHqTzb5PX4rVryEv4JLgBJsffwQG69gsh2X6IBePF+Zza9pEvysRKqpMuERTkD2yrV7WxTglT+u5wVgpartsW9yrP67DcS5Es17PcrgmfWBeR5+7AmRKR2WqgpuqRee1LHS1edw9WqwCGogQ8wEangIOOEYcchUsqj9z8Z0tVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9EiWC0xtpX7KEBLVJ2FFeNmjtiRHvR0KJbp+/idhqs=;
 b=mS055VEOFmNj1v8VtZZXi2Sp5UL7w0X/SAFHqToiao9F9bZwsi6kH/ArimfInUrqDdj8wrbnwXL7SjgY5/O1qR5Vh2g3ofBZAcAvTDSstwghe2Y8tLaXZI+tNZPpct+Mm4BYxZ35gUgA9dhWd0FqYxHCAJM3kgaRie6ZyJe/8CnQf+jxXLtq6VrRzp7ADmvxJXggFzoxnVnlFj8a9VZZPYN1cwgqjEn+Xiys96KdrycyebT3X1XpT36V6MEiXb1zoHKpJavNgxM9TYoPjAUre7PCDkKWhFGU2lJlq4lIWBn7TIYDyuoCbg9eH3yLDEd7ixCrirOlltndj+iY9bbJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9EiWC0xtpX7KEBLVJ2FFeNmjtiRHvR0KJbp+/idhqs=;
 b=BohMP7BigV5k79Celh2OMEdDjCE7gJ4n4Nqfz7SEM2E2X/FtObwdYXkj/nFLyQxZux8MX2U4y6pk1N8YqQCDQFS87j1lJREhlvKbxUisajRMJeDlQqmQl3GWakTwp2jIn+58qgNC3nCK1nPP21thN1x/yZg/b2z9lCshuhpQJGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSSPR12MB999213.namprd12.prod.outlook.com (2603:10b6:8:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:50:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 12:50:14 +0000
Message-ID: <81d038ae-36bd-4026-a086-f52d0ee5ee9b@amd.com>
Date: Tue, 16 Jun 2026 14:50:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-3-srinivasan.shanmugam@amd.com>
 <205b3f8f-8381-4c7a-80b0-e13e56165c6b@amd.com>
 <IA0PR12MB82083E2008437898E247926790E52@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB82083E2008437898E247926790E52@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0430.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSSPR12MB999213:EE_
X-MS-Office365-Filtering-Correlation-Id: 1332ed0a-27a8-40cc-1df1-08decba5cf59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7H9lEABtjXUxDQVPqzEHrwXQaV2w6xSGvemxx0KUImpcpFYQi0dsmtRXvJJyQcRlS+I3bOXYvdKYV/LdG/emtcuq+1Db9mZ0ozFRlsdYbz8wC4Yz5T+9W5A+WZdepZfijQfc7DCnegpmMcIHvv8aE9AV87K5zC8u3N3FH9xifgKwY/80+wRazBO6mSCMkz8PARBK+ZOzyvBNZvpd5OQs3j/e4reXT6NufSOfFLZJaDf81bJ9r7p+gka5+SyUIrDA3srz8CHE6ZZoEYTccA2A8+5P6sPVAib3iObhsif9KkX+LqUx/DG2MTUQLHm/f+LwqlZHQWo4k770z2Fxxy+H0RQfhiiHEmOhV2Q+fryT/+y0fPMAdHtYEUyZX4cf1iXmWkpEQr2hBRNmMA2GsO0CRL26NBx6hN3Zjq3uHZZ6Em0WdXVR7iiN5p0+BGdyB9rGli8EfMbri5qPDtrx+bss9oi2CCo+Zn2tUptpi5/6YIOThJC3ItKZEPgJlriQHd2AFtqApd/hk24sS4cL3kMxeU2xBegE9MMRToRR7x6MQgFsmJmq52uNxzgXSVUlqvO8wTFa2ZzTMK1Pajl8s6c/yRHLd7sD1wWQKULd6BZI/w6+6oZ+aAaOqbWKdlDaR/8MIyuRLkV6rNP+FPwzsDe/YHU6nSN/q6WiUxib+FXdpPSvbvg3TM3amRQOXOgmGvzc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(3023799007)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXlLd0EyK0YwbkRCV21lcXc3N3Q0QWpMNEVDYlNPSy9DVjN4eUkxVmZsTWVJ?=
 =?utf-8?B?cnNOMDJvYU9weFIxZDRSc24xVUh6a2Z0R3JSMG5wRklabEplYjU5TEYxK2pk?=
 =?utf-8?B?eWJ0L0QrdVE2czdSWWozNGJjSkUvSzl1anprZ2lpZmVOdW1COTJjTmhUdXJF?=
 =?utf-8?B?UmM1d1ZaTEJzV1B5dHJXOTBSSnB5Skt1ckxiK0lIbFhxTytXWWJEQXZoWlZl?=
 =?utf-8?B?SElmd1NJYmErQTlCZ0dhMG9rQ1J4S1dZNTA5VmNCL2l5Vm5VU2ZEL0p2alFk?=
 =?utf-8?B?YXJYVm5wdUZkWFJkUGJvQWordlE5VDBnYmFhWnI5Nno2MStSOXRXOGNEeGxv?=
 =?utf-8?B?a0ppT1NmSm1jZCt1bnN4bVVTdS8zV0RHcC9HM0k2UkkvbTh6eU51Sk1wSVI0?=
 =?utf-8?B?KzN0ckZNajYyR3V2RnFaZm9ZRlp5eXZyMENEcTREWmZZVlZ2ZlhkejUvWFhO?=
 =?utf-8?B?MEJnV3RoK3RPK1hLdXVpaFg2dnRodllQYWJMRUFuem5GSEM4aHUzdGprTEJJ?=
 =?utf-8?B?NDZDMDJqa29sRUNia2J5NXdqUnZ1QWc5d1BjdmRTYVMxT09Kb0phUVREK290?=
 =?utf-8?B?WldxMzhQc1FwaUZrbzBCVjZGOURtZXBxM09lN1VuampUZzE2UkNuY3UvbzFG?=
 =?utf-8?B?aFVzYlIxWDNid05CZlZiR0JWU3MwZTJ0ajN0WEhZRnpxNG10UEpUbzRkVHN4?=
 =?utf-8?B?NlRCZmhNTE03Qi83d05ocW9mdGpEVVRJMlE1RUhjZkFtOWdPR1BDR1ZmMnBa?=
 =?utf-8?B?ZkQ4R2lETVBoUERYQ3dkdUM5K1o2NUxmbmVuUll3Vk1mTzlLYklTVit1RmQ3?=
 =?utf-8?B?YlVXTEFKdW5mMWN0NlB1Q3FINWFUWmdsR0o2dkNQTmdFakZyT1hEaWViV1pQ?=
 =?utf-8?B?ck0wOVd0SGJHUXJEN2MyWExJY0RIamNnZ2Y1d210bGNwNFFZdnNpeldwVm53?=
 =?utf-8?B?L3dXbHIrdzlqbzBnSW9pajQ0SzZwMHhrUTFHS0d2alExWlVvemtzWFk0VDQ3?=
 =?utf-8?B?bEx4MEJlQms3NkhhUGdaUHdKM3B1dGxpbGdDcTBHUk1nL29QczFheTRaa1FI?=
 =?utf-8?B?Z0Jhb0k2NjhUVHE1bWpSeitURW4xY1NtUk1ZYjVBSEIzSXIyRVhCbmZSMnlL?=
 =?utf-8?B?YzlKV3F6aVIzbXRXYTNmaEJrVkJxTTc2ZU1JcGZyY0ZXQjNvbEZqdHVhS1dR?=
 =?utf-8?B?b0g5eklrck5iK2lKTkMzY1Y5NEJNUnpwNDR4cjlXZXordzQvRThFanpwT2Zy?=
 =?utf-8?B?UTJRVjNVb051V1BJMFVPbm1Ub0JBZWhmcFczWWVGQ2VmUG9NREo2a0Q2aits?=
 =?utf-8?B?VnU1WkJoRFVBekk3R0JJSUcwY0NBNGdmYlZCL3oyQWxwR3BpM1ZtckVaK1pQ?=
 =?utf-8?B?NjFiTC81bk5DMjFWbk1lVlZSMzVZQmpiV0NWaS8zc0NhMWw2VzdXYTc0M1N6?=
 =?utf-8?B?Ny9zT1JEZHBOMHJjNmtDTngyb0tQUFk0czNJM0dDNVJ4bUkrMlkyOWtEbUZu?=
 =?utf-8?B?YXU5QkcvYk5zSkFGQkozQzJEU2NzUkxTVTZvK2JDcFY1ajJiL0YyNEd5MUpa?=
 =?utf-8?B?ai93Q3RHYmw4M21EOEIzcmhQWDgvMzJjZ0xCU3d3b1ZiZlh5c1FCSWxvb28r?=
 =?utf-8?B?UmZjL3BLTmljMkEzVUluVDJjaXpUbmFpTXNxYWFFL1ZzNVk0Wk9ENzZBS0RD?=
 =?utf-8?B?SlhrZGxSV0RIVmo2NWcxTENVY0lRc3k1RDJuQzdiQzdHVHBXaHRvd08xaitK?=
 =?utf-8?B?aEpWeXBEME9RNDlhYVpZSHNMeVIwNkE4YWZmZ01RU093SjJ3a3F4L3E2bnk2?=
 =?utf-8?B?aktoeTlCTzB3L3ZSUTZRSHZUa2djQU1zZ1NLb2JvNDgrQzlRZVhkL044Nzl3?=
 =?utf-8?B?NEc0dUEySllBZGJ0RmdUT1Z0cVhSWVBrZ2hncE1hZTJBWkpuUS9WMDIrY05k?=
 =?utf-8?B?VDdINjA3Z1QzdUJCUGI0M29ucnRVRVBHMFk4NktGM3NSMGpSZmtaMU9OZ1RR?=
 =?utf-8?B?Nlc4NS9QbUxhTTJkbUhVREJkY3grZE1rQU4zeVVhRXhBdVFZMVNRN24wWHZR?=
 =?utf-8?B?Zi9aR25QcUFVWGIxa1duU1ZuVis4b1ZKTlNyZWV2SHNRaDh4S0FWeFBXTXhE?=
 =?utf-8?B?bmx0VkZnYmtQOVo2QS83UDVEcXJiNUVoMVhXUDJWUjJpazRCVmZGMGhMRUxj?=
 =?utf-8?B?QjVmMzFnbFU5RlZUa0J4Ry9TQ2FuSkkxUExqS3hUU3FtS1RwY1FhZ3RDU3Qv?=
 =?utf-8?B?N3FMbG13VWxnRzBDTFQyRWRwRHdzWTZPZE9CVndXYnpMVFFhOWFNZEtydUdK?=
 =?utf-8?Q?ZYJxOxi8ckLngmmNv3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1332ed0a-27a8-40cc-1df1-08decba5cf59
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:50:14.3503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnyKKTF1NxAewP145l4mRv0GPVaV4p9v6zm0Q2bgecaJltPJbKki8vO9PFCghOJ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999213
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



On 6/16/26 13:30, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
> Hi Christian,
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, June 16, 2026 2:28 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 2/5] drm/amdgpu: Signal QUEUE_RESET EVENTFD
>> notifications
>>
>>
>>
>> On 6/12/26 07:52, Srinivasan Shanmugam wrote:
>>> Signal QUEUE_RESET EVENTFD subscriptions when hung user queues are
>>> detected.
>>>
>>> The queue reset path already identifies the affected user queues. Use
>>> those queue objects to wake up the matching EVENTFD subscribers.
>>>
>>> EVENTFD remains notification-only.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index e9189f07c6dc..ee8dbd70e1c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -238,7 +238,16 @@ static int mes_userq_detect_and_reset(struct
>> amdgpu_device *adev,
>>>                     if (queue->queue_type == queue_type) {
>>>                             for (i = 0; i < hung_db_num; i++) {
>>>                                     if (queue->doorbell_index == db_array[i]) {
>>
>> That code is extremely questionable to begin with.
>>
>> My suggestion is to clean that up first and add a function in amdgpu_userq.c which
>> gets the doorbell index and does the necessary handling.
>>
>> E.g. actually lock the doorbell XA, lookup the queue and then do the right handling.
> 
> Just one clarification pls regarding the QUEUE_RESET feedback.
> 
> Would you prefer the new helper in amdgpu_userq.c to only perform the doorbell_index -> queue lookup and return the queue, with the caller handling the reset/eventfd logic?

No the handling of the reset logic should be full in amdgpu_userq.c

> 
> Or should the helper encapsulate the full handling for a hung doorbell (queue state updates, force completion, EVENTFD signaling, etc.)?

Yes, exactly that.

Thanks,
Christian.

> 
> Thanks,
> Srini
> 
>>
>> Regards,
>> Christian.
>>
> 

