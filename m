Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C20F34C47
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 12:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1359510E0C4;
	Mon, 13 Apr 2026 12:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="purQ/pXx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6811210E0C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 12:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoq+Qta7nfyVLOGC+PwIFPHrkL2pSopWxJSkbCxvodhK6Wx9wcTmMdprw5DiMf1O8fw4vdwZ0G3kQsS8XC9VCYjPZQPt3dgB9U6LR2o9OQvKRlv6iVOj+CxqSYOxu1w23Loq1X/ubnGbczivLOkqSs3CL4V4NYameeOFhzHCxuGUpFHwRhrA8zYdEYhwq3QpojcHhzfIP8Dx9pvZZdFrw3XthUG35O3e+FV49nKYXgBkwMna54cfEXAg6yeJf4QHBQWk5Bcgd6aNH2ay7MH+pM4jaE+Nj+wxEfW8B/S2UoGXCWqAauI2ZXJenIqPp1C2SlRRoLYr/ps4tvY/4DFeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owFFdfxJkJBYQQwe0GEPXhskvnhhEGG5fyw/GceFw88=;
 b=d3oi9py2yPm7Xi/wA48iUaeg629FsenpzB7hOWW9j+pZDEOm2zbdH0yzW7BhAftxoX/2xiQa4aTppgVcF5unzWgq/qNhrxgogl4Ijl/dI+SBPy/nHuDd7H6NEe+xlJFkA8NnyY00Q8RwlrY1FElBnMiWdnJoBex1sveu+SMH4/bjXGw3lc2yBnSmIc/0uV1ejXNAtrH9p64/5XtwOq0wRVFm0Az8eRZBkpy/KGumV5a84KocXI3+IpHAh/JFSfn8PyBNFG6dnhkHnQoRO0jr167F5RQ7v/dKsi1CCF6jLfBDGJaL+aUMNLDA3UoW08F+eFrgwQidq0VyYcIwopSHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owFFdfxJkJBYQQwe0GEPXhskvnhhEGG5fyw/GceFw88=;
 b=purQ/pXxzmZlnI9bq9ohleSIHLx4WDTCVqtjtF0t253vs9jldOYxqOlOSvXQdP3l10qr74ZsUB4lZfau6FukYA89+fE53++WFreS/o3NaXcWcr8uVw66fv2ShLoLcGWtU0DL3m9s3kV1YPKEFZGsJi2Vn8TngxFMGaLV9t2aNsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) by
 MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Mon, 13 Apr
 2026 12:06:09 +0000
Received: from DM4PR12MB5771.namprd12.prod.outlook.com
 ([fe80::dba:6509:159c:fba3]) by DM4PR12MB5771.namprd12.prod.outlook.com
 ([fe80::dba:6509:159c:fba3%6]) with mapi id 15.20.9769.016; Mon, 13 Apr 2026
 12:06:09 +0000
Message-ID: <ea4eadad-bee3-4884-9242-df52314c1f3a@amd.com>
Date: Mon, 13 Apr 2026 17:36:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_devcoredump_format
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
References: <20260410013639.129917-1-vitaly.prosyak@amd.com>
 <20260410013639.129917-2-vitaly.prosyak@amd.com>
 <56e81193-13ad-476e-aa24-06c46bb39454@damsy.net>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <56e81193-13ad-476e-aa24-06c46bb39454@damsy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0272.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::11) To DM4PR12MB5771.namprd12.prod.outlook.com
 (2603:10b6:8:62::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5771:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: d28a73d7-37f8-4270-3617-08de99550c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: vMwN/z4KhMwxZ07hclHAVkldAUoAn9+SRcUFnFNPF6jzoj4N6+dM2WtGb80zmWVxcNxu7sa3EtADITHeGDOzp2UaycPlz8ypnqLIT0TV1dGeKnSXDVhYYY9N0QNWDh3scGjxsL7IfSUW4HwwE7JMUNUZvAbO954zHyE4Pescejyhf2+XSmG9zESQ7G4ItybxKLQTnd7iJ2YQsRXcHOYrLxLBvSTeL0KOMonZnu8DNHWyPAmiiWqzQ4D26icy95bFqo9NApXsTv4IPbA/KOSgEP/q6YLtC1viFAfULya60e57DmINFgdclMzhSrQPl/MWNtonkACBqD7H6RsVXCJIB1juGi9jx4rNfwMFCu5QXkONQ97FZFLdQCQrMIMgmMFiv/iL1T3jh1rSB+LC8wdpaQkGhLqWMpanFtreERg4XEsEH20i4hUJiMUwj7ey8J7doyWlrScP9WTpKXLgtY2/ycJm3oPuYguJsBQSwuAlJtf5I2S8/a63HWhAJI47rYcRUHNqqlSN++xOSUloXrHKxZwRxCk7ySMsDfasu3E4QlX/bSSxN4ItsL3pApeazIiZ8whDX+r5aPXpsryIsorN7VHa9k0xmX46cRlRHtDtY5SNi/wFp4ETBHqIUBJ7vN+LDHsC4vFRGaskyoquS9jWO6qIr4yK5+fThWpmJ97TW0ra96ATjEa1zAUHffhvkK1c6kQ0rrTiQS0AtxvJ3xWKxbrKIzQ4svdXMEyJmSOPAiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5771.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pxT2FVdWVhKy9QMFZYWFRVNmZVRzZ2T2R4YWhGSVh6M2lCVmR5eVV1MEg2?=
 =?utf-8?B?NnFGdUVZVktKeXdlSkZveHlHWHlTcGhybFZ6QWtWZU9ta0dlRjVCVnBlR0hS?=
 =?utf-8?B?dVBwMlRtekFmLytDUWJBb0d2TExJZXdYZDNzWDkrdURLd3UrR2lhOTY2SGF0?=
 =?utf-8?B?TlMvWWdBV1AxU1NzTmNvb1NNOW8vcXZ5V2duTHFFVHJIT1J3MXN6QmZ3elBI?=
 =?utf-8?B?T0FwWWJPNTA5aitLSHRNeFVDa2t1SkFzeWswWGh6a20vemRZbXJPZjlOVmxy?=
 =?utf-8?B?S29GbnFaMXlaZjB6eW9hcFJ3eGhuRFAvVEVUSEtmc1dvaFNmWXFDcThEVGFW?=
 =?utf-8?B?UmppSkhZakw5YU1oeitITWR1dnhSRkZnOXIwbExTUmVISXVmNTdZWGYvb3lq?=
 =?utf-8?B?NFVxZVhqU3o3YWN6N0EwZmEyU21QOEhVdUtEN3FIaWtheFM5ZzY0aElaOEJt?=
 =?utf-8?B?R0lMcVJvSjU1WExYRis3WGZmSVQwTld4aElvMEJtMEhqQVhxVXoyaCtqYUhk?=
 =?utf-8?B?L0gzM3lPWkpRTHRtZ0YydTMrVE1yTWNLTkdaRkxBZ29xejlkajk2VjI2ZC9L?=
 =?utf-8?B?Vzd6Z1YzeEF2VHZZL3BOM1hGVG9PZUJqZkV5alZ0dW1jYVVtbHUzSCtXWGZi?=
 =?utf-8?B?K3N1aDBYMlVzOW1QcUN5b2t1bmFwbEIxSmkwb1p3RzhiRUxMc1BiQVNacXZV?=
 =?utf-8?B?ODBrRDY1Z0Y5WTIwdk1weWFNUlJtR2VZU09qelRuUU5BWUpTL2RhZm02a05x?=
 =?utf-8?B?QWc2Yk80NlI4cjlZbW9INlBHaXJsV3lDekErZGYzYklHYXpNRkpaOXlrYW5F?=
 =?utf-8?B?V09QY2dINmZqUlA4WStJV0VML2h5eVV2aUwzeVJodzhXb2IwNEFyWFFEK3Z3?=
 =?utf-8?B?SnZyY01oSUUxR0RmdFFaTTdjZVVQVmJ3Zmx1bHF6RlNNcGJUUlZFSWlrQnh2?=
 =?utf-8?B?VzZVQ1lDNlZ4cGFqRGxueEU3bkU0anFHaWltZVdBaytrQW40NnRuRk1SR3hS?=
 =?utf-8?B?bi9zcXlLck1SVWNnd1dYcUxlbFR5dG0xV3BvQUErMjFVRTF3Zk5WaE50RHl3?=
 =?utf-8?B?SEFGQS9oMEVBb0RkL3VsQnZXTkRtTEgwVVFYYTBwbElhWEQ1b1owSXhvOG9L?=
 =?utf-8?B?R0ZNcy9jVWx3L0RTSzFiVS9SOWowcVJ3WWZYUVZmazN6SVlKeVlsejBsYitT?=
 =?utf-8?B?c29sOXNhTU1KVzl2U3JXamZFeGpaNVdFQkRuaEJReGJlY1dPVytEN2VNM3Bn?=
 =?utf-8?B?TzRkLzZDbmpPN0g5WkRhcDVBRnlkOGZrQVJ3M3duVTY3R2xFdHpheHdBRDFH?=
 =?utf-8?B?VnJUamtyemg3aEx1c2JLWkZiWjVEQ3EwcWNIckIyNmJHaEVXWlRqdEV1NUVK?=
 =?utf-8?B?cDkrRjFIVjgxeVkxbkZHejFrb2ZJblZHMTBIN2hOYzRLRWxpYW5nWStwNTFK?=
 =?utf-8?B?a05IdTAvK2RyR2hTOWsrT1lPSW1ET2piaDVlRmN2amJSMlJ1Ums5bUlxQ2sy?=
 =?utf-8?B?VDRiZVZ0ajhCK0NXbm9YNlV4R1NxWkN3MXgwT0VJbzl4aGFLUld3UzdEWG9N?=
 =?utf-8?B?eHVjak51R0ZlbzJreDBiSVNjdThtR1ZlQ3NzWG1jQkFiRHZYN0JNeS9jbi9G?=
 =?utf-8?B?RThLd0R0RHVJODFtb1JXYlFTdFhwdU1tdWdma2hrVkpMSkQwZ1dtbmF0MkJ0?=
 =?utf-8?B?ak8wSk1wOEliNWI0QnE2UXFXdjhtZmJ3Tk1mOWY3OEZWaStxM0x1enMvVDlE?=
 =?utf-8?B?dm5VT1FmOEpEeGc0YkN6bXFuZEUxZHAyK0FKYTdXMjkydXhUQWJ6UXIrRks1?=
 =?utf-8?B?OHBBMzJraW9EaDhVTHVacSsyWjlQa0loVnJ0ZEM4YVZRVE1yRXVmbU1HTURN?=
 =?utf-8?B?Mzc5aytNOUVCYUdFNUJ5MjdjY3RJbHhoVlcyeXgxbmVpRllIWTlVSERqQ2Z4?=
 =?utf-8?B?dDM0SWl6UnlsM1lzdllrOFVXNkw2QXEzK0J2VXVuNkRkRVkrRURnUlI1bXBl?=
 =?utf-8?B?ejVQa3lVVk5ac3ZwUStjb0NyOTNubTVDRk0vQ3doR29hcGVJNWFxZ1NGSG9O?=
 =?utf-8?B?N3QwYldsODVMNER1UEhOMTVNdjRrRE9lZmlDVlgxSHh1QmFUdWFRRzJoRHRv?=
 =?utf-8?B?OEF5VXB1b0x6VWxuKzlia3c3c3dNZGt4YmVvYkRRdVhxUlJFRjBEa0xxZkI0?=
 =?utf-8?B?djFiVEtYdUVzUEZVWTFPWk5jbFM0Mk5NcEhlekRzQVJQTlJWNFZFQjdQVE5O?=
 =?utf-8?B?cGhmV2tCNjF1QWJpUytOMnNUQjYrYTNmREFDSUljNHRuRUppZjFvYzkvckJs?=
 =?utf-8?B?c2lhV1Q0YjU3c2h3WE1pSnNySXplaTVYVmFXSm9yc1RLME1nU20yZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28a73d7-37f8-4270-3617-08de99550c5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 12:06:09.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfgKODy4meSG44yIe8DsKejHoRLX+WTB2/JB3w6kDNgHLIpoTgTzX6kbSlMDQ9UxpMQBHfi5pYgmX4djrD4q/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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


On 13-04-2026 05:26 pm, Pierre-Eric Pelloux-Prayer wrote:
>
>
> Le 10/04/2026 à 03:35, vitaly.prosyak@amd.com a écrit :
>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>
>> A race condition in the devcoredump code causes a NULL pointer
>> dereference in amdgpu_devcoredump_format() when two GPU resets occur
>> in quick succession.
>>
>> The sequence of events:
>>
>> 1. First reset calls amdgpu_coredump(), creates coredump1, sets
>>     adev->coredump = coredump1, and queues the deferred work.
>> 2. The deferred work begins executing (work_pending() returns false
>>     since the work is now running, not just queued).
>> 3. A second reset calls amdgpu_coredump(). work_pending() returns
>>     false because the work is running, so amdgpu_coredump() proceeds:
>>     creates coredump2, overwrites adev->coredump = coredump2, and
>>     re-queues the deferred work with queue_work().
>> 4. The first deferred work finishes and unconditionally sets
>>     adev->coredump = NULL, destroying the reference to coredump2.
>> 5. The re-queued deferred work starts and reads
>>     adev->coredump = NULL. It then passes this NULL into
>>     amdgpu_devcoredump_format() which dereferences coredump->adev
>>     (offset 0 in the struct), triggering:
>>
>>     KASAN: null-ptr-deref in range 
>> [0x0000000000000000-0x0000000000000007]
>>     RIP: 0010:amdgpu_devcoredump_format+0xa6/0x36b0 [amdgpu]
>>
>> This was observed during the amd_deadlock IGT test where multiple
>> subtests trigger rapid ring resets. The dmesg log shows four
>> coredumps created within 120ms (at 102.377s, 104.424s, 104.492s,
>> and 104.497s), with the crash occurring 13ms after the last one.
>>
>> Fix this with three changes:
>>
>> - Replace work_pending() with work_busy() in amdgpu_coredump() to
>>    also reject new coredumps while the deferred work is executing,
>>    not just when it is queued. This closes the main race window.
>>
>> - Add a defensive NULL check for adev->coredump at the start of
>>    amdgpu_devcoredump_deferred_work() to prevent the crash if the
>>    race still occurs (work_busy() is advisory, not a full barrier).
>>
>> - Guard the unconditional coredump->pasid = job->pasid assignment
>>    with a NULL check on job, since callers can pass job=NULL (as
>>    evidenced by the existing if (job && job->pasid) pattern).
>>
>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Jesse Zhang <jesse.zhang@amd.com>
>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> The Fixes: tag is missing for this commit.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> index 8edec416fe2b..5cfd9ecccdf2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> @@ -464,6 +464,9 @@ static void 
>> amdgpu_devcoredump_deferred_work(struct work_struct *work)
>>       struct amdgpu_device *adev = container_of(work, typeof(*adev), 
>> coredump_work);
>>       struct amdgpu_coredump_info *coredump = adev->coredump;
>>   +    if (!coredump)
>> +        goto end;
>> +
>>       /* Do a one-time preparation of the coredump output because
>>        * repeatingly calling drm_coredump_printer is very slow.
>>        */
>> @@ -499,7 +502,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, 
>> bool skip_vram_check,
>>       int i, off, idx;
>>         /* No need to generate a new coredump if there's one in 
>> progress already. */
>> -    if (work_pending(&adev->coredump_work))
>> +    if (work_busy(&adev->coredump_work))
>>           return;
>>         if (job && job->pasid)
>> @@ -511,7 +514,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, 
>> bool skip_vram_check,
>>         coredump->skip_vram_check = skip_vram_check;
>>       coredump->reset_vram_lost = vram_lost;
>> -    coredump->pasid = job->pasid;
>> +    if (job)
>> +        coredump->pasid = job->pasid;

Hi Vitaly, my change is merged for this one line change for pasid, 
Please rebase you change again.

Regards
Sunil khatri

>
> Nit: This line could be moved in the existing if (job && job->pasid).
>
> The series look good and is:
>
> Reviewed-by: Pierre-Eric Pelloux-Prayer 
> <pierre-eric.pelloux-prayer@amd.com>
>
> Thanks!
>
>>         if (job && job->pasid) {
>>           struct amdgpu_task_info *ti;
