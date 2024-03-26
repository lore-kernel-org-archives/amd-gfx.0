Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1813ECD11DD
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 15:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E2E10EB62;
	Tue, 26 Mar 2024 15:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uNJjTYTd";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2130.outbound.protection.outlook.com [40.107.100.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D47A10EB62
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 15:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikNqFnAKpfiY+2Vw14B3Esopdm2Epccps6EuJcmwR5dyLfrPz7/CtAs7K7NituRSGKvZnAfjlEUlAaxXrfucObxlAJcPbAPF3hMDCEiITLfqJScn4r5ku2Yr93ID48x6HW6DdcBRN1Ep5gJkcsS5OERMlyozXsAbYWXLqY+8rOlez7clRLvN2K61jR05wn6JrmdVI+dl9pRwSvAz3Gu6J5m0NI7NFbCymZEV/zM3yA87ybLZP4pSXc2tkMfjUxKb2UymBve0gIGKEr/pueBBAbsN0eJx3I996/zL9B2fzvbFx12Wk6LcGoudPhI/aCmsENhEjBROGg5r51YvWHOU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja4uFaVR+8T7r6PbA6/GDv967K4WbfZqd3STuS0wTGw=;
 b=lkT7jQXvS0AlHASN7NGl3kf7i8VfYdcSd8jyvlts7fO+2hsklzocN71nwmFoOYRKCH6wkYUWVhc0Q3hyiUHxDxzetI7d0HICtVacU+ozjN4oeYe7BLrq1TIUulbrK4iuyxyM9AWmE/HvkQYipMAn2wNGWDMz6AvbGUY8Ee7hWdhYb+jOEHiIGL/Is2jmJZHAZCCSNt+v2n3zIUDRr4YYSn+YTM7HIuLJn3qsz+08GJ8KmKnCP3oMamMJhWWuo7LIPWYjjisl+CtRHEnbaa9nmNJ+7iFZxpJmu6pn6B2dmm6vCj2NHAE/3A04IA748Sl04QnTb5y7x2eRoLfdV3fRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja4uFaVR+8T7r6PbA6/GDv967K4WbfZqd3STuS0wTGw=;
 b=uNJjTYTdpVlpXJ60Pql8tcEJA67T7pH5w/WmZp3XOeQL/LLp50eswFuHH3krCqLZRjoSZL0K7FvNaerceN/TuQaC3D2IHKNbheVEEad3RVidI9tvVpYIwhXMPnsFfOtU3npZg6R+1dzzvRVgioaU6+qDwju6286XD1qzaftyhyQ=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 15:01:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 15:01:34 +0000
Message-ID: <1bc4dfcd-79ed-48b6-b5c9-9a2d9e5a393a@amd.com>
Date: Tue, 26 Mar 2024 11:01:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amd/amdgpu: wait no process running in kfd before
 resuming device
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com, lijo.lazar@amd.com
References: <20240322195737.30795-1-Zhigang.Luo@amd.com>
 <20240322195737.30795-2-Zhigang.Luo@amd.com>
 <4fb3033b-a025-45ea-846c-bf97566d41e0@amd.com>
 <4cc67abb-c0e0-414b-353c-9f364cd0888a@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <4cc67abb-c0e0-414b-353c-9f364cd0888a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0084.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB9147:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rYyZQuCtfh83Aj13Yjw05FWA2Xl82hG0voyhVuTzygblIWoN3FwJyVGyBnyzAsUIB5tQC+lp/mAG/AhITx66dHns07dHapIio9RgNvh6Hr/yFI28aGl7+snfFAc2oYsGB8jzEB5pQ0TUdtXY4D4do5BDj/uzZinda/sw+8cSalE239FbPgiZJVKqApcqTIqT62WX+RZySFeJkDsvrVb3ONLvNXNIn2ZTP6xTu0qzc4eKQBgeicigUbTolkREflZgHtcpPro29P4loAxOvYdF6fA+YyH63YrPdbU8fYVjJjcz7b2SY4A7fII4iji+UVXJrzt0uz6OhJuv9d1u34BHcTLfVatHSyeZyUzAE2Si/c1houmFNieBOJMlJGHhW9+siN9C9LyTZG8hkP+keNPi+uHe1PbYFmrNKu1VGnVOwbSASpfowujqndLycqj/gIYPOYzCul2jxPUaC0lsGXQjAC69k84AYHT0rIYA2rNBymQfGdpxJN6cgt71Wfpq/n42o0Kamst/OBrdTSj2PzNyhgzrog5j4DR2Rhfmj6aJXRAGnffvdxXMkirMiSccceoD0UnrtGjV10FRIPOGBXqA4RwR+ZXLSrJWgT97/oMOIowTVIOfijFcmC69XROLlhkXRszsdoF8abbhJpTusgkLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJTaGdHREFoNFZMdFh6NzV0Q2F3L2wrNHQ3cEdYOTVvSEJEenVxQ2pocU53?=
 =?utf-8?B?WkJ0WkNGZkFRTkJwZ2pzZzVtWmJQZmVmK2thQ1hKQ2NrU0FOc3l4aU81eVVF?=
 =?utf-8?B?c0hpbDJtMEpmaHY5eUg2SnRtdm9TUzhhS01hcWsrb0VocG96amlHTzhQNXV4?=
 =?utf-8?B?Y2VIdElxcGRqQXBzQ1g1T2M2MVRkQXE4VUp3d29TTG12Q0xrREMzOGs4TE1i?=
 =?utf-8?B?Y1BKb0p5blNZTVVybEtlODFBMDRkb2lVV3U1TDdTelhoRkwvMEZnN2xEVnZT?=
 =?utf-8?B?M1N0TzJUR2xOTWkxbG5kbDRKWHQ2WlRYaXprbSttWlMwRXZhOTNnWm12UDNF?=
 =?utf-8?B?cFovMzZZZ3E0bEkwdno0dDBRT0ozRXM1bHVjY29Ed0pNVGJvWWVLc3JuUTdP?=
 =?utf-8?B?aDJNMXFXRVNBaFU5VzNLSXlnZEFabi9FeXdZSjhkWStOaWNIUXRtUlYxZys0?=
 =?utf-8?B?eFdlSi9rcTBxb3lQVXJNMC9PRjRZRFJ4am1tazROdC9DL2RxdkxJR01NWUJ6?=
 =?utf-8?B?SXFLTnduUE5KRjh3c1Q5UlVESDRaeUJFbDl4Wlg2UXlwZXA2V1cxcXNkcGkx?=
 =?utf-8?B?Y3l2REs1c1NTY2lMbDlpWFhJT1RscTh6aGRkdk5ZV1RGeVRNUjdaQ25ET3pL?=
 =?utf-8?B?R1pXVDRDVG5qZVRjZGJoSGZvcmNGVjFhUGV0Z0ZKVnFkbUcxU1VwV0gxMjhB?=
 =?utf-8?B?NG5WS0ZLaWk0NnlsbzlrZm5xdDRqWXZCakwvVm9xSXJCZ3dKVHB5cE5Xdjhp?=
 =?utf-8?B?VHhaTkZaTWZqQldua2pQd094N1dVYVp3R3NYMVFnM0RZTE8yM1p1WWFiRXg2?=
 =?utf-8?B?NWJmQzgzeXIzZG1oZ25TMUlkRTZrU1hoYmR1a3ROcFlNRmRJWTFvYUpuUW5n?=
 =?utf-8?B?Z3d3NGRxNzIwZEQxNzl0Q054d3g5TmtSWDJ2eXBwREFDNy9BeXBveFE0a0dw?=
 =?utf-8?B?NFh0RWcyeWxRRXpNUHduQnpQWk55THNCUXFKNWtKeWFrMHpqVWZ4dEIvcDJv?=
 =?utf-8?B?aDdKRTFqMjFaczdvK0ppanljRWRNSCt4d1BoNlhSanpuQndEN2pFRll3VlIw?=
 =?utf-8?B?djUrQ0xrM04ybGVaaXBBMG5UM2tFQld0YlgxWXZTbWI2Z3JDSFJZaEptK3pv?=
 =?utf-8?B?dyt0ajJkU3JOcFpwYnpJdmNNbS96eEdmai9IVUZpbUNXQkxNdmQ2NjZqYTRp?=
 =?utf-8?B?RUlUK0hRSzJSbFZjRUlvS2wzRVhCQXlVbXAyd3NlY1FSMy95VDZnZmZJS1Bq?=
 =?utf-8?B?SzlhOHdNZFhJazRsbys2Q1VodDV2bm51dTl0REoyWkhWVHBENVRXME8xRnQv?=
 =?utf-8?B?VldPS2NIYjcycnpYeXFsWFM0Z3hicHhyNWI3ZWFHb2ZYcDYrWTFoUlR4NzVI?=
 =?utf-8?B?TTg4bVgxY0lNcHZGMUJhTUhRQ0R6VW5xRW5pVXhDWC9Jek5JWlZqTk13Qk9z?=
 =?utf-8?B?cXlnNmFQcDcwNjM0cmQzdmg5dGRKTDYreWJ1SmV0enovalc3VFV6RjFXaG5l?=
 =?utf-8?B?Rkk2cTVFb0ZhbmFPV1R3TTVhM3dpNmZyOVhud0ZBZ3F4bGtYMW1RWkNNbUxE?=
 =?utf-8?B?S2J0bVRBY1ZrTDBNQ0VtN0wwdW4yc0Q5UHkrSnRBLzg3a2N6TkVvRGVCMUl2?=
 =?utf-8?B?NGdNUHBjMWpvZFBPMmMxdG9HcUVzcURRbVV5akxDdkVuc2hvcTBYT0NNR0FU?=
 =?utf-8?B?ODNwVHdVTUlYeVJzSkpBVkRQMitaekVzR3pYbndpRGhNUlRJQVBHZ2VOMlUz?=
 =?utf-8?B?TVpkNTBJNmIwTVJzTUNWaGpmVS8vSnhnNWVZV2VNTVk4RmhxQ1ViNnBvUUtJ?=
 =?utf-8?B?bDJsKzYweDJhaENmM3JVVE1PZ0tSUG56R1JLR2tZK1d4dHlucDFrODMrVVMv?=
 =?utf-8?B?NHNaKytpUWlpcXcwYzFuR2tRemxESmVyRG1DM0dSNnRUNHBYaHhpUDZaT3NY?=
 =?utf-8?B?dkxFN3J4TzdCWDhFcU13d2h2ZkZUZGozWllMTzd0Yk1FV1dqdFVoQWJ0a29L?=
 =?utf-8?B?ZUpjQmxxdTdHUm1MYmVzYzJUWXI0bkZRV2JxMWlMQ3lhbGo3NVAwTVVIcU5P?=
 =?utf-8?B?VjJvbkNaaHNFZGpVa3ZSYVVOTGhiaDk3TnR1STZ4ZEV2UmdWaDhKVDd5d0dv?=
 =?utf-8?Q?DytAFeMMRjWkaUVPWXL+oS6g9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b48dc3-592f-44e3-c628-08dc4da5a0e6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 15:01:34.5581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmE6e67rLxC/s21mbG2KvQJCluiO/5LKhi5nbTm1YgKaylX5+DUl2vezvQ6RNJcmytWdCqbXq7P8MmJIBa7cxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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

On 2024-03-26 10:53, Philip Yang wrote:
>
>
> On 2024-03-25 14:45, Felix Kuehling wrote:
>> On 2024-03-22 15:57, Zhigang Luo wrote:
>>> it will cause page fault after device recovered if there is a 
>>> process running.
>>>
>>> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
>>> Change-Id: Ib1eddb56b69ecd41fe703abd169944154f48b0cd
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 70261eb9b0bb..2867e9186e44 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4974,6 +4974,8 @@ static int amdgpu_device_reset_sriov(struct 
>>> amdgpu_device *adev,
>>>   retry:
>>>       amdgpu_amdkfd_pre_reset(adev);
>>>   +    amdgpu_amdkfd_wait_no_process_running(adev);
>>> +
>>
>> This waits for the processes to be terminated. What would cause the 
>> processes to be terminated? Why do the processes need to be 
>> terminated? Isn't it enough if the processes are removed from the 
>> runlist in pre-reset, so they can no longer execute on the GPU?
>
> mode 1 reset on SRIOV is much faster then BM, kgd2kfd_pre_reset sends 
> GPU reset event to user space, don't remove queues from the runlist, 
> after mode1 reset is done, there is queue still running and generate 
> vm fault because the GPU page table is gone.
>
I think seeing a page fault during the reset is not a problem. Seeing a 
page fault after the reset would be a bug. The process should not be on 
the runlist after the reset is done.

Waiting for the process to terminate first looks like a workaround, when 
the real bug is maybe that we're not updating the process state 
correctly in pre-reset. All currently running processes should be put 
into evicted state, so they are not put back on the runlist after the reset.

Regards,
   Felix


> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>> amdgpu_device_stop_pending_resets(adev);
>>>         if (from_hypervisor)
