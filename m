Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7480C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 19:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6444410FF0B;
	Wed, 20 Mar 2024 19:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BW8Psexd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC5310FF0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 19:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDl9NbaugFNab58Jq63K1F232yrwxOFSqGxU1AnN7LZIMohWaXjOCzBhDkjZ8kugXcLBVKBaQqVxUPFDbqA1pTlCeW8YSmewIBrKZjMyZMr3/cShVYUXXhnU7qIlObpEjUG//gYppJtiHnhcZUKhBIDAeRtvs6NtRqf/NHpwTws0HCuQSXfL5RcZehH5cAsbl0NudaVTmhykDvOedmfAEZnWzbvK0CPOepAc2gsFgkK47yo97Aa7d2QHI89ep/oWZGEW0PvVfao9or95d2/Mndyeglt6QzbQGoRVcAKmeD8ioA7HATmrJ6AR9xTr/00CmKdfnbU7gQ3OsYwo5bLSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqJF06p51gC0FD8tNK7Ao7W67tgfxAIoqwZDVGdTbjY=;
 b=i57hNDH017lAfMzA/RlT7RNjoDcwZZZ704+jM05WTh0T95A2cQnpSMftVR7zGbqzO74J/nF7GEzszbi7LmP3HWww1Zj4aQwDqQrSUriMKCdygZGmiA+hEdk/ORBlQHmcz3Re5UR+tz0JCcnCx1OJ7/Fs6R380h1ahz2v+uAD6G5XeIXbzBpDZRq6L0RNMYBCLq5OutMvY4fp8c2V5DPVBw5mtS6aQHVRipWnPBmjKirvDzk+Pr1AfYlYvXaKCWg6Pkg6MVsEeCrGv3ACsKSmkbZnQIvLG5EEHxHlaaeC7ZpO81OuFRzA9dzchDlE5I4ah7y+Gt5PigHCUcmMgnOnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqJF06p51gC0FD8tNK7Ao7W67tgfxAIoqwZDVGdTbjY=;
 b=BW8PsexdasfJ0HiPumzDTW00znw6UttyTbdZVhudxlEP/7YRs9ZiUUMau94DM28luutU0xWqlGcNecQJmWleFZRwU4dsP/n2nUrZNichuH4Sa3n6PctBqwIg21ip6msoy7EO8FqKaNpk7LfCy/+4PlZvIVXTHs+FnK8EgzkjLxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 19:14:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 19:14:51 +0000
Message-ID: <365aba9b-dfbe-47e2-b0a1-f5296179f04c@amd.com>
Date: Wed, 20 Mar 2024 15:14:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
Content-Language: en-US
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240315181756.685335-1-mukul.joshi@amd.com>
 <48148998-5124-4a66-8d1a-767d94f6c284@amd.com>
 <BL3PR12MB6425081828B93697A317ECE4EE332@BL3PR12MB6425.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <BL3PR12MB6425081828B93697A317ECE4EE332@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 367b0370-4be4-45e8-c743-08dc491204ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19fLCyvur4d9PnK75xqMSg/B2CdSCgyR5AHGHdVmn0lF/YagG4o7TBt/gYvB4ifZCd7Cfs8MmIxBR2tF5bhea5hvGyfgLslHYWSJ1RBeILpYjvv8ePBBWKK8ChQ/euUFOn9pqNCxn/BmluTSUJGnuKq2ndQlNrTRmdatKiIKSfZ5v5uZTmMa0CaktiFvfnMHVskcB5P00pl0bsipKpC4Bwgo13g/W0uvLydQMpTbbSrLONcGVljKFovdWhU1lnKiFcwB7FzHG7+jdNSpDhaTQsyB7KTTQJ8yk2VPUK6cP+4fAqLlPERV/UmUJ3IBvhMOiI5SlgeAkclflsbTf0T2j6XhotGIjUgYZ3Wr0U5Qq9mzLB17S//uqzOtFeuI27t8Sf8B5K36V1h5JaHAJ2qQePxpbbMAKrLPPlTzqp4k0Iglk8pUn0xvrwx3rNT9J80YDcKb/MwZvVDEiFmKbVM6tfVL321UCpJ7HyJUo2WgekLzVHDQscFHzLj3jFv5aVLgS8dul9JOBRKFSyNtUSk5MyGfOv9lUobJi/ImhkiCqpxKA2fvY9Q9GfUTIo/Y8Vdbg5HnJ1sLF9b2V72w97KigsHkPP//k9yzi2HoRRwjlfZXFnSirgpjYUTQs64G5s/eZKvkWfHfsEXSuPun9GPNWJgWVMIGgx19eaKUF1ie3YM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUwrT3hWdnh0SGl2Zkc4cUE1ZDY4SE93Z3JZQVMwaXpFYWthaXVnSGJZVzJD?=
 =?utf-8?B?NUx1VWt3UTJxVGNwMlMyd24vMEV1Zk9Nd1BzQk13Tm8xQURwUGRHV0dPYjd4?=
 =?utf-8?B?VHV4OUVDOTZqV1hleC9sKzRKRWhlUnBKaVZxeUJjU2lIR3VzTlErRHdXcTU5?=
 =?utf-8?B?dzY0RFluTTBha0NtbGJ3eTNwRHVjRkFzelhRa08xeGovOUJZckV4S3FabjRS?=
 =?utf-8?B?dEx2cy9VK3lSNFRTbUFxcC9jazNBR3I4QkNrUHIwb2VKbloyTllYbHZmWVox?=
 =?utf-8?B?L3FmV1JKRFFZano5YVlhVG5BTjFLeVFPWnJrV3BTcndGYjlSbDBJbTZCU3hN?=
 =?utf-8?B?eVJYSWlvMVJicTNuS2g0RzBteitSUStCQjZXRUNLSWlJd1lWS0NXbklmdFpv?=
 =?utf-8?B?dnFnMHRsVUIxbGx3eW1RZVdrZnFuakVUS1gxZmlCc0NXNDRkT0JQNzA5ZVRp?=
 =?utf-8?B?c3BtejV5aTdXZ1FuZmhnL3p1NG1oSlFZTUlsTURUdjdpVFJhcDhuMENOaWR6?=
 =?utf-8?B?S1NHUTMxNEJNa3BlK05nTXRVT2g4b25kVFJXQkZidGtFMkpmTUwwY0RCRWlt?=
 =?utf-8?B?Uis0bG1PN3pKRlBQNVFEUFpsL256K3NSTUFFZ05rYXgwYWRMY2dOU0d3R3Vl?=
 =?utf-8?B?eEl5eXB3UGt3U1d2bjJYZ3A5TTY3d3RCVERrKy9MSEdjdCt1N29qdjVTQ2Vq?=
 =?utf-8?B?MEhkVU10QmdDcWNxMUxWWGl5RGUvMlJIY2J1L3JlUFhQNjQ3dlpZRUJJeFRz?=
 =?utf-8?B?SDNSUUFaSnhiMlhyNDRYTHhqcjBrNTBiOWZ2YmhYbnNRSjlGUVdZZUdOMDBD?=
 =?utf-8?B?RFJ2ZTlSWWxEZlNDOTFZV1NqcmJuS0tUQzdncEtFMG04QUVmL25WKzlIQzRB?=
 =?utf-8?B?d2tNL2M0ZzhYcEtHTmdzUnZLenNvQkxmZkdTbU91cHdEUExUR3JodXZIRHZs?=
 =?utf-8?B?eG03N3ROQXlwK2NDem9ja3hsVStPWjZuYVZKRHk5MUlKMzRMUjdXS1BVbHBD?=
 =?utf-8?B?Ung4NERyVjRBa2M4NHkxWmVoQ3Jid2dzVENheWFnTFYvWDYrellod2hnSGZQ?=
 =?utf-8?B?THlmSnFzRGZKaVA4NGR1Tm9PalhmamFxZ3ZNdHQ2bGdHcDJ5QXg5N3lXSUx1?=
 =?utf-8?B?SHovTXdXRmp0bnFVRkMrMHpoZTFYUUFocm5iSWdQcGJiNGlRNkFPTE9zb2t0?=
 =?utf-8?B?RkJHL0h3UXQycFNVcGhXdjd6a0pER1pjMXpMRHUzWXV6bTNjYW1TOXJMamdu?=
 =?utf-8?B?bVlCaXIyZUlHSU1idW80bEJyQ1lnV0xZZjltcThKTlkyQjZ5TVh1cmpicEx4?=
 =?utf-8?B?bjRPNGVLSW9QTzRBRnppMGx5OXJrSitWcVQwOFBLNllNSWdhRDU1bUFleUty?=
 =?utf-8?B?cHAwV2d2VFJ5N3g1WUJlRUV2KytQdXozdGIyUjV2UmNGeGYwc29uWTRrYjZD?=
 =?utf-8?B?Y3YyYVpzTGhQUzlrZzZHc1hpSFk4dlZFTXFwMDRuUURTK3k1eEYveXcxNlRW?=
 =?utf-8?B?aUdyZWV5Z2xEVUVtTmdJLzZjekFEWE9KYUx2WEc4ajFoRHkva2Rjb2xxazc3?=
 =?utf-8?B?TENQZDFKZE54VkJFM3FXbjkxVVRvZjV2NEc0c0RmWWNYb3N2V3A1WUpDaVRp?=
 =?utf-8?B?eENML1VVNnd0djZRUWhxZWVIcUhXbytJUUJxQ09vOXpuMDZRdU9pTGZKT2lk?=
 =?utf-8?B?ZTNPTlZtNHllU3dzQUFERDJ5bFBaOXlZVEpnb0VLejdPNDRuQ0oyT29KeXha?=
 =?utf-8?B?di9ZdnE4WnpyaXZMNHZkcHQwV1JRd1RoaFdrSitEM2ZzNDVHbTVOOUZEVlh1?=
 =?utf-8?B?NUtDbllTaldFVUd0TmRXeUpHWGUxWGFJcnJYcVRMcTJsb3RLNGFwaXN0OWJ1?=
 =?utf-8?B?UXNudjRoUEwxZndyVXp2SVBQSDdVcS9laExDTGIvazd4cWVOUlFmMkN4dXhP?=
 =?utf-8?B?QXYwRHBSdXNwaGtLTUpCMzFuMXdoSGxhZm94MjdLR0lRQ2FBTmgzWUNYdlU1?=
 =?utf-8?B?d3NISmNKRVNrNVBuU1FNcDNDeDI0NlN2N3lidkJ2bnJtOG5JVHlKWm1lQWJ5?=
 =?utf-8?B?QnRtRG5GOXJxWDVqSTBxUE81RkJ0Vmp2NWVvUUFtYkVxV2R6djVhcHZiZEpN?=
 =?utf-8?Q?X+3gqAUC3+Cfyg50NxwiRAeEC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367b0370-4be4-45e8-c743-08dc491204ba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 19:14:51.8581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RN0rpPl3te9hQX1SSMa6qtQ9XHp+R1b58EZT4HAgxs5AsIaRnw1tvt9I2ZmwXk/IWEWr0xlU80fUV/1steymw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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


On 2024-03-20 15:09, Joshi, Mukul wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Monday, March 18, 2024 4:13 PM
>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
>>
>>
>> On 2024-03-15 14:17, Mukul Joshi wrote:
>>> Check cgroup permissions when returning DMA-buf info and based on
>>> cgroup check return the id of the GPU that has access to the BO.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index dfa8c69532d4..f9631f4b1a02 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1523,7 +1523,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file
>>> *filep,
>>>
>>>      /* Find a KFD GPU device that supports the get_dmabuf_info query */
>>>      for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
>>> -           if (dev)
>>> +           if (dev && !kfd_devcgroup_check_permission(dev))
>>>                      break;
>>>      if (!dev)
>>>              return -EINVAL;
>>> @@ -1545,7 +1545,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file
>> *filep,
>>>      if (xcp_id >= 0)
>>>              args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
>>>      else
>>> -           args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
>>> +           args->gpu_id = dev->id;
>> If I remember correctly, this was meant as a fallback in case for GTT BOs where
>> the exporting partition wasn't known and the application didn't have access to
>> the first partition. I think the way you wrote this, it could also change the
>> behaviour (report the wrong GPU ID) on single-partition GPUs, which is
>> probably not intended. Maybe this would preserve the behaviour for that
>> case:
>>
> Can you please explain why this could be a issue on a single partition GPU?

What would xcp_id be on a single-partition GPU? If it's < 0, then your 
patch changes the behaviour. Instead or returning the GPU ID from the 
GPU where the memory was allocated, it returns some arbitrary GPU that 
the application has access to.

Regards,
   Felix


>
> Regards,
> Mukul
>
>>        ...
>> -     else
>> +     else if (!kfd_devcgroup_check_permission(dmabuf_adev->kfd.dev-
>>> nodes[0]))
>>                args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
>> +     else
>> +             args->gpu_id = dev->id;
>>
>> Or maybe a more general solution would make DMABuf import work when
>> the
>> exporter is really unknown or not even a GPU. This came up not so long
>> ago in the context of interop with 3rd-party devices. This may require
>> user mode changes as well.
>>
>> Regards,
>>     Felix
>>
>>
>>>      args->flags = flags;
>>>
>>>      /* Copy metadata buffer to user mode */
