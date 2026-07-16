Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DAEC44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1005D10F2F6;
	Thu, 16 Jul 2026 13:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBPE0r7c";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20FD10F2ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdu68zMUI98uqXg+MllE3j0lhvBAemdtZq73FqP9DRZFId9reK7+tEi9SOfWcBOtjgJfdUcw96DxZqvPyl7EGDTEDqRy32LFdGmCgmWRF+/K0atC+er0GEVmLIfZnweVpdu7LDhiR0YaaxUS7WADM2ucp1NBCsTb2vcfFM3t05cnNEB00rXYueQkYlcyPOMLcf1rIQpKo5/88RL3kSjy0IxF1CvEKLrwMB3/lbzo3gfo/P0H3CGWp9+mYYvucekGFwQg0jNa/Vz6rOEwldpMoFlQkr/A9dDbZJwp5TzkgTpinJ189ruVa2lcSkZ8+2ta9Z+KCCV6+H+L2ye/tdMaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbRuo75bbAqJQ887KF5G4K02elYWvhikat1fHPw03+E=;
 b=MzIY0V+PZmHXYvJgIu5qU2hP3SJHeiTF1UrvnvXxnDZEhPTHLqYKNpY8REY0AgCSq3gQcNhpB49k08W6sYLpQPxxeST7K3jD3gpo9f+6KSUV9RrvMI81LJZzCLBHjdXKUdEq4kvDvZNHvczEosoQOdy+q8Q1sQTce6Tj11nGPPW79bSsKIwvYvANGwOyGtWwzP06sgxVTapnVxezcGy0BVUDGN3ckujvlGL1h9xXcbmXA5Ft+hG0nhYShhAeBJtUowwTPBoqHrG2A6KB5a/e+dNJAJOfDyFAjO03TeFPIBT05atdV1CHAei9vmatoTFxP7elo6/RbVqQ0qNcYLKQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbRuo75bbAqJQ887KF5G4K02elYWvhikat1fHPw03+E=;
 b=RBPE0r7c+vjgs6blYK+6djphTd5NpBFC3QVWDTubCYLCaX0/KPlDqB4mwl3GGdU2dqEPwD/TK6Maax3smHFlRs3PmrPBN94Dc4vdcKKQPm3vnMpURclr6puuSlG/LkctnH5GffBAL/iSm0k3RZoUmCIGv0IyRDCbeK9uOmGIg8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 13:11:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:11:26 +0000
Message-ID: <ae02e6a7-aac2-4ed2-a24c-c9a1d0e0e9df@amd.com>
Date: Thu, 16 Jul 2026 15:11:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-6-srinivasan.shanmugam@amd.com>
 <b40ff22e-2d09-4644-a4d3-a9cffcdaec6d@amd.com>
 <IA0PR12MB8208D744889CEED95FB6DB0E90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <IA0PR12MB82082D2D3FDABB394796856B90C72@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB82082D2D3FDABB394796856B90C72@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc657bf-0bb8-4945-5305-08dee33bbde1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g2i61rjjtbBZC2qn79IyX4TMP1gW8QnwRWY3T2b1VDAWQZ+EnRe6n7/t7gzs+fkbxxtIxTv+sio8rER722ymQDjUqnax0jFXQNTP3nuwB8JKwaZ+9xSxn34z4N29QAiUhEgGsvNfEC2vX1VjiY4OYPqbC7UQs5O89gKDMxqO+du1NOwZd0KHuduu38lUJplIgi//TO+IQ6r/B7Ma/uEe1lp3fPHWRIwWntKedRUjGnFCD+oNgaqZ9k+C6aWCMIq47CsHprId7JZ2scw+kIEcpVNUOuzUdHvex0ghTOu33oj05tnUgzRivm3uEgyXtww9DKh6WX4ZELbZeYtV+HwNZjFrIGO3447NFi/b2PvDaxeDEbVg0odKl0d42r2bHri25F2IsNOp+8nhWf68KKMdAT/p7X7OwHaIHLFKALCV2MWmIZT/HYoQOtd7ZY4nwUYe8H5kcj+jkDtT+x5c51wMWKKJP56T9OdFHwqKQ9joPPnwfeiSM8/5VaiqufHGJyjuJ/Va69C5dMbPnNF38Ul7K+NlCtNSzN2csEbhgH+98Oaq95W9K30+BR/w1QduHAS8lvS9w90+4hoE0W8g2YB6vDpGadubk1nPjYuLbpWaUdr88YS2Z+j0gs6R5FWy+NwJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDk1dmhSNTNUemxGY3AxbFNoVm1OcUxuYTYrTzJoam1IZitoUWxMMmVNN2lL?=
 =?utf-8?B?OHJYc3JIZUdFanZUcTk0aVV3amE3UUJUcExzQTJOODFXa1VoOW9Oa285c0Qr?=
 =?utf-8?B?RXJEbDJEQi9ldFdxQVZ6MnBQS1Nad2IycC92TXFQNDl5SEc5MTZJMzJBOWJz?=
 =?utf-8?B?bVo3b3czcGRwY21FN0VQaTZoUFVOclBITzZibTl6S0pRSFIyVnFBbjg4OWVx?=
 =?utf-8?B?SFA1bkExOW92dTZHZTYwMkw1dXZtR1BmTG00MFhMVVBTQUZoQklZTHRhUGo0?=
 =?utf-8?B?UmZjWHVIcWNNa29GUG9pUXNMMUx5UytCeUFZNDdGeWI0ekcxcFJSZitHV1Z5?=
 =?utf-8?B?MW5BV3BEcityclpoRXRvU25hb2hkWWhjaGtsTFVGQ250SVpOUnFxSk1PbFBO?=
 =?utf-8?B?L1FFelhGWEM1RGtNMXJMOXc0MEdmckgrNGppMWp2K1NZeHRubEd0RStLQVlQ?=
 =?utf-8?B?VjN4SUxaNE5xQU5jdlFkUDhSaFNHQUlKdmkyVEpCUjYwV3dQMXZERW1MVnBY?=
 =?utf-8?B?UHZiNnZxK2ZKbktzakFLUjByYVZoaDNxSmVqYTB0Qk0yRXdxQ3dneVNLVWdO?=
 =?utf-8?B?VU5BL0pnRlJEdHVxVGM2Z0RiazNRTk1yUGowTWlyWjJmVE5HQjVhRmtnRXQ1?=
 =?utf-8?B?VjUxTVlreWhpWmlqNGJYcEI3eW45aXBXa1ZqWDdEVDlmTENtYjBoK2dkVG44?=
 =?utf-8?B?cGZTdjFTTXBTWW9iSWhkR014OHdhK1IxSXpRRTA5cnc1RmdJWmphdU1Jbk80?=
 =?utf-8?B?eG5BLzhsVTlzQW40QnpxS2dVSlBqTjVtUHN2dDgvR3RReTUvVkNmSjZwdTRI?=
 =?utf-8?B?OUdCbjFyRHM2eGcydjc1SWJPTkJJeWlkUENPZmpnbStYbUw5U25DMWlSM3Aw?=
 =?utf-8?B?OGw2RlV1OFROT2hwS25KcjdDQ082V3kwT0tOeEZkVmxYUG5na1NqSkhIQVNn?=
 =?utf-8?B?alZ2azFlZE8xaEhiUUVpTkRCeXlaK0VCUDBocHZiQWtNNVJnWUh1cUZIOFlH?=
 =?utf-8?B?YS8wYXlENHZ4emJsRG9zQjhCT3lIVlFKZ1JVeHhKQURmQWJ2Y0R0dkNRd1Jk?=
 =?utf-8?B?TGh5bkdlV0crUlZvZXFWUTJmV2JMWUhTYVdicTA2cmRUU2lyME9WaTd2MEl2?=
 =?utf-8?B?eEFjUWFrSEY5RyttQjltSDNkcW8xUWJXUTVEYjB5c3Q1ZUFzeVgxN25XdzN4?=
 =?utf-8?B?YisxZC9kazRPa1I2SldZNGJWZWZzdHlzclpjVzR5ODFqa3BaTnFNWnNIajdP?=
 =?utf-8?B?cjQremFaR3NwZlB3cEFaKzFsdjRRazdpSmdtSllSWDM2QzJXckJaZ3B0NFY3?=
 =?utf-8?B?aUgzZ3dqSHltdG1jSkIrdlpjOXNEOGV3eklUM01HYlVqbkcwMkRsMTY1REdJ?=
 =?utf-8?B?R1lkb09WdUg1YzZJTGs1Mm9remNyZnJveTdlM2pOVTV2TmoxRU0zSWVVVnhV?=
 =?utf-8?B?cWhDNTc1T0tkNFRxbEUyaTZOSmd2cC8yR1VROG9aMVYxd243OE0vRFB4YXZu?=
 =?utf-8?B?UTBhV0M5UytodW1XOU5UMzNVL3NNR1BjemJzMjFEZ3pvY1NxL3U3NnZSSkg1?=
 =?utf-8?B?QkZYcE1hQ3hEVkIxTjhiT3laekdLMUFRblpIYy9ubjVnQ3d1QjhtQ1FxN3Rq?=
 =?utf-8?B?UzAxN3FjdTlrZ2FNN293UHhoaFZHUVhLQmZValZxOEJJWG1aUWpsb3ZBU0V0?=
 =?utf-8?B?eGdiZ0d5eEduYTlRNDV6ZHJQQkQxcDA0ckJ6QVJoTlorcDBsWnNmZVZZOCtF?=
 =?utf-8?B?S241cFdGalNJdXJpWndia2dqTVlERDNRbGVYUFlaM2xFbmNCc1pkVE9FYjJP?=
 =?utf-8?B?MFgrUW9XampWNTJobWZTWTJiR3d0M2lVMnZOeTBXaEY0ZEp4eVdKUmZPVWFJ?=
 =?utf-8?B?Qm9OMTNhNGFqM3RBNzF6M2ZhSlg2ZDkzYVA1cEkyUWw5NXBHUjVyazRab0tv?=
 =?utf-8?B?VG9BTDI1eFJIVDNVVFpUdUlENnJleEw4cUkrcG4zY1VSSU84Nkpob0dzZnk5?=
 =?utf-8?B?RzZFWS84bWxsZCtrVXBKeDQxWk5RV1BqQWF3Q3NyTXBOR01xbDdLdHNxRlFk?=
 =?utf-8?B?emFWbkNSWUxuT05VazV6OUcrT01RcFFDYk5oTHJlQzlrL3hJeHY0RTdpajh6?=
 =?utf-8?B?Y01yckJPTnFSbmQ4R2xqVnhoU3VVc052a1hraHZxWm9nMFRyZzFyTlpOLzli?=
 =?utf-8?B?Z1V2N1RDV1JJUFE5akhRNkNmalg4NEdidUtscTk0bjMyTTc2eVUwT2RWbXZW?=
 =?utf-8?B?VlQ4ZWhhdGdncERCL2h5SGRvb04wV01OUG5GNkNzcFlucVlhekcwaUdFK0Z4?=
 =?utf-8?Q?5/rtOhNq37GyZATaxi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc657bf-0bb8-4945-5305-08dee33bbde1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:11:26.2955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24muqG3VmbO1addaU3x5NmG6hyeobBF5Ueb9NKbP9LHxf1G9UInVldhH8yaZbf7j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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

On 7/16/26 14:53, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
>> -----Original Message-----
>> From: SHANMUGAM, SRINIVASAN
>> Sent: Tuesday, July 14, 2026 7:43 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
>> notifications
>>
>>
>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Tuesday, July 14, 2026 6:36 PM
>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher,
>>> Alexander <Alexander.Deucher@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH v9 5/5] drm/amdgpu: Record QUEUE_RESET
>> WAIT_EVENT
>>> notifications
>>>
>>> On 7/14/26 10:10, Srinivasan Shanmugam wrote:
>>>> The queue reset path already resolves the affected queue directly
>>>> from the doorbell and funnels successful reset handling through
>>>> amdgpu_userq_handle_hung_queue(). Reuse that common handling point
>>>> to create the corresponding WAIT_EVENT record.
>>>>
>>>> Keeping the notification in the common helper ensures that queue
>>>> state is updated before userspace is notified and that both EVENTFD
>>>> and WAIT_EVENT observe the same reset. It also avoids duplicating
>>>> the doorbell lookup or adding a queue scan in the MES reset path.
>>>>
>>>> No MES or GFX interrupt changes are needed.
>>>>
>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> index 28f9d3fe0e80..9e1d03eb31d7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -166,6 +166,7 @@ void amdgpu_userq_handle_hung_queue(struct
>>> amdgpu_device *adev,
>>>>                               struct amdgpu_usermode_queue *queue)  {
>>>>   struct amdgpu_eventfd_mgr *eventfd_mgr;
>>>> + struct amdgpu_wait_event_mgr *wait_event_mgr;
>>>>
>>>>   queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>   atomic_inc(&adev->gpu_reset_counter);
>>>> @@ -176,6 +177,11 @@ void amdgpu_userq_handle_hung_queue(struct
>>> amdgpu_device *adev,
>>>>   amdgpu_eventfd_signal(eventfd_mgr,
>>>>                         DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
>>>>                         queue);
>>>> +
>>>> + wait_event_mgr = amdgpu_userq_wait_event_mgr(queue->userq_mgr);
>>>> + amdgpu_wait_event_add(wait_event_mgr,
>>>> +                       DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
>>>> +                       queue);
>>>
>>> How are we making sure here that this wait_event_mgr doesn't go out of scope?
>>
>> Good point. wait_event_mgr is part of the owning amdgpu_fpriv, not the queue itself.
>> In the reset path, we currently take a reference to the queue, which guarantees that
>> the queue remains valid while we handle the reset.
>> However, that reference does not explicitly guarantee that the owning amdgpu_fpriv
>> (and therefore wait_event_mgr) is still alive.
>> I'll review the lifetime rules and teardown sequence to make sure the manager
>> cannot be freed while a reset notification is still in progress.
>> If additional synchronization or a reference is needed, I'll include that in the next
>> revision.
> 
> Hi Christian,
> 
> Thanks for pointing this out.
> 
> I reviewed the lifetime and teardown sequence in more detail. wait_event_mgr is part of the owning amdgpu_fpriv, so it is not allocated or freed independently. Its lifetime is tied to the corresponding drm_file.
> 
> During file teardown, the USERQ manager and queues are torn down before amdgpu_wait_event_mgr_fini() is called. Queue teardown removes the producer lookup paths, and amdgpu_wait_event_mgr_fini() marks the manager dead, removes pending records, releases their queue references, and wakes blocked waiters before amdgpu_fpriv is freed.
> 
> Based on this teardown ordering, the producer should no longer be able to access wait_event_mgr after it is finalized, so an additional manager reference does not appear to be necessary.
> 
> I've also documented this ownership and teardown ordering in Patch 2 ("Add wait-event manager and per-file lifetime plumbing") in https://patchwork.freedesktop.org/patch/740465/?series=164813&rev=11

Sounds great, feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> to the patch set as well.

Thanks,
Christian.

> 
> Thanks,
> Srini
>>
>> Thanks,
>> Srini
>>
>>>
>>> Regards,
>>> Christian.

