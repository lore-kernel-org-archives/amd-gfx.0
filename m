Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295CAEB7ECF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 12:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B471D10E163;
	Wed,  4 Mar 2026 12:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IAFT1Go6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FA110E163
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 12:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shYFUq/IaCE/sXctxyBUxtFDJeb9l8JTdaDh9B76DDNH1mCDYHPiYSZj3XWStQo1VJdX1/5HOaYNB5tLyzknSw1GmWZ0heARSLbpfq1Fyuahx+xThkj5MSJHCp1Dz5QDRp3BlS7L2u5gB5rmlTQNTQEpI3wduy2eNfJNfvgpncTqsR98WpSvwN05dlfyKtOBC8/sdiVapR4FVJCL49vT3v7VA8UMSvekkUu7QUAk3LBw2FifkByNOpbcR+3mQD1+Mx1tj09EPzyYnMD7jgjXE9x+SDq1su34MKuMnni6G7qz+x8/V94vKPaBYXFurQnGSvhP+l5Iq0kLEpO/jtQ8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se3OmVrnV6AyMi2J0K7Jmj7P1vXSucPOIMvYNWOTh0I=;
 b=a5pu6Yx6UqGYU0vz2wUlFtWf8YVTzI7qDlw3Wa9+7hQlrNpnyjjGYrkocS6yazx0XSG0GIt4n+TZSk+lchEbxfQ0tdVvnEwN13Hu9jDLb+qsKwfreJwwLxd0cvRWgKRkgvzJYEA7erX34X8zK3Dg4MR2JP1ExQ/hmzAFQ9PPePtWUFVeTYr3C+JV8p7ew4YlCtLJgYldehj/1jDxPcedX3PGHWG5agsjTAdw4xPSsh4W4ANWBvkCTqV8TdtMNxDGxIa4rlM/GkkeEPU6ImsUAZBAdevhN6rmRks31buIkmgiWMieBOfSEcxUj8JKhFv9D3SB/MREDl/j05foygm/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se3OmVrnV6AyMi2J0K7Jmj7P1vXSucPOIMvYNWOTh0I=;
 b=IAFT1Go6o6X53JGepzxajDV7FMF+z5Eq2eTgHgHr3osTS+Mp5GFJI95t5C+pizhTCC8ztGaws/522Nw/OEJayG59X4ufZo50t9ZwvYeSiXv5xhSDhwGfXEAAlqo7OUFrND5yXChoLH2NE4etiw/PxLZ2x/fEEDQEx1oJxJNtZiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Wed, 4 Mar
 2026 12:28:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 12:28:31 +0000
Message-ID: <c1ea12d0-fd6a-41c5-8c7f-c1d713f2e17f@amd.com>
Date: Wed, 4 Mar 2026 13:28:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amdgpu: Add render-node EVENTFD manager core
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
 <20260302030219.1734986-2-srinivasan.shanmugam@amd.com>
 <41d029c5-cc02-4e81-8fcc-e7917f78259a@amd.com>
 <IA0PR12MB82085C2FAFDF660476D43C12907CA@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB82085C2FAFDF660476D43C12907CA@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f2dfa9-2384-4552-4087-08de79e98bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: ANgP2re1IukMXBD8vub7BJHuWn5EOF2/3T7VsdsiAD6ixYCX/IqaSJUkxK5VG7qci9fZkqmRDCaAfHesX2BXujkPoB8gfnsocua/iJmDYCx69SCj90OmVUsQq1GTLhoqT31+jNF30YWogdcVJCRFTqJM6ddex+CoWY86kGlgKuMnWPP6gyiTE0oO4QpI/BHHA2MG3Sr8wnSNyojVIH1h8iugGJGEla+s1QE9DlTrdrQa+20kXdeiI3WF71OvxznMHE11/akkE6kPRevBaQh8cU/PyxGaWtfjRZGpvFg54ErAiWcJ51vzNBK2SqOs4q9cvcckssM8ldYC3M71RxSvNn4iY05aXzu/FB8BHGMeL1RD06P1FH0m1OCHcwccQJyoOAj3owOWN1o5dfbOJJH6Kp9BMfZ1uvEDxY1psHAzILcc2y7S65A7kZaqZ75+fBTuDTasbbkZbaAJO9PUu1A5QZFx18L+dlwn4nmPVNDuFsMceTNVyncuraMXqFzCeyUoDEXL53gRTusyubI6SDY3PyRU/cnvuh1yQxh6KV7sU5k0EeKW2RjmEOGNh62WROXA6u5dv/3nSGqhtY8GdSCJj1G/SKRcMdbfYpQJDqvx2PAOG50we4kjCZNrH5lTv9tMvxSh1bzVA9o3A2beUVbLnKrtKR1XtnD/B5YzixCW2fO8CfPTtXZ/NWnKZmpsDmgBS1kIR7djyXPHDPeUW2DHbH3FLg6rZ9GF6ZhYpGTnwlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmxEb3ZQbjhPUVNiWWxKMitDWTN4YzhxcXZESkZhSG1jdVRGUS9zZjNzdzBE?=
 =?utf-8?B?aGZWTVpYSXFJdFo3c04yVHpmUHIyNkE0dk5EMmxXSUVBb1NqNTZ0QktxT2FN?=
 =?utf-8?B?NEo0TmZPc1dGUDdkamR3SXhQTU55VUdTN1NoLzVCSTI0SFNwTDNjdFdCZmM2?=
 =?utf-8?B?aVUyQm1mSDd3dUlMbFBBNmt0M2d0VTZEekV1K1k2N1FQQUdIcGpHRHNJcFFz?=
 =?utf-8?B?aXREOWRINk4wcHB6aktzRXhvb3FldXlMd2prUFhPRGNNOFBoY2xTZjJEeDd0?=
 =?utf-8?B?OXhjaWV0L0RzeWphWHN1TmdYM2lzalRXWHA0cmc0bE4yTEhDME8rSVZzUGtw?=
 =?utf-8?B?WEVlQ1JBaXgzM0JpR2E2anBNSS9hYjFocmdYMTVTQjQ5bTJBYXd0M3kwQTVo?=
 =?utf-8?B?L1Y0aU9NaVZLOW91VnFqMk1Pdkw5VmpVd0ZiaC84ajJGdUw2YmtFZml6Q0tF?=
 =?utf-8?B?cWpiQnRNNU5EQmw5bjV1MmJHb2h3cnVGRi9ZcDF4SzZmUmRWc1M2cWxnc2tS?=
 =?utf-8?B?Z0ZLUmVGajZkU3pTY2FMNCtpSGZ6VHdtaXFZdFc1OGNOajgwYlJuZlVobGx2?=
 =?utf-8?B?MVd5YU5DQWtYSU5seVFBbkNhZkFSTldZZjBjcmd0UkFuVktYNC9JYmtjRGhk?=
 =?utf-8?B?MTFFaVk0THRpZ2JaSEVRZFNCRDhqeHFnSjUzYXZZMU84bmEvcDB5WlVjV1Yx?=
 =?utf-8?B?SmhHbllVMFJuSS9GcEkrQS9vc1RGczZTNWtFU0k0Z3pvRFdwdy9oUmtpcThu?=
 =?utf-8?B?ejJiUzdLOVdDdEszMFpNeitmU0VaR2VQVFA3QTFmUVRSdU4yNXBwYXpSdCtT?=
 =?utf-8?B?UlBhRmdEZ2xBazZpT1lWTVlrRXJaSW5TWFRBbHhlYjFTUE5HZ0d5MUMvN3px?=
 =?utf-8?B?SzIxN2lXeFpKQUo3Wm00cGNLckVTbUdlUXo3OFJXK1REZysvVWxsUytxMWh2?=
 =?utf-8?B?OUVlL3IvaUkwdWp3T2VTbFhiTHo0aDRMcDF3ZG95YzVHbWlXM1JTaUJZcHFM?=
 =?utf-8?B?ek1yRWlLZDdPcUE5UFQ1aWpNZnJWTno3WUE4bFhINlFTZ0xkVkFYRDgzS08r?=
 =?utf-8?B?T0FmNDkrWWFJVnVDcVl1aXV5N1RpVU1EWFp5aFgzTEFiNklxREtYMUNSNVBr?=
 =?utf-8?B?Q0Y5M3pmOVlYWVlMMHZIZmpRSGt1NVNuT1lKYVpEOG1qc2ZidUZyc0trMEg4?=
 =?utf-8?B?RTJYTXVuamYvZllITFhZUi9aSTAwaFV5bmwwZDhqdG94TXhVUHBFa2hOVXVR?=
 =?utf-8?B?K2J4eTVvKzV6SHIrYjJnV3dlS1R4dDJCNDQzTlVKSEQ5TUxEVXorVFdGSUpB?=
 =?utf-8?B?M0VKOVYwcFU4dlAzZHBtME4rQUdpWHhYVktoWVZiYzV1T3lVTG1xVEVCMlRX?=
 =?utf-8?B?RERrTmJqb0tNV0N3MGR5WnBGdE5ONnl5SjIzeGVwM0VPQnVnZVo5QWtqN2hZ?=
 =?utf-8?B?SklSVXFVUGtxeUlhaktqUEpoOEJpZlhWcEZLQ1l1Z2wvS1d3VWhxRE1iTUJm?=
 =?utf-8?B?ZlJWSHFWY3VOSk02cDhYTDR5eWpDNitBTUw1MDVvNlhXVXNaRWwvQkdlVGg1?=
 =?utf-8?B?RjVGMDFoRlM0RXRTU0JpR00zRWV5ZlpraVdjajVFZG5CNjVUVFVaUDI1U0h0?=
 =?utf-8?B?WmJwa3h4aWJ6MDlBT3NLWmxXRVFpWlh5OGVNY3p5RFVJc2JiRFNDWmpRWXZO?=
 =?utf-8?B?eGhCTGxVOTcrZjhPL3ZVUDNPSE9Va1hkVGxXMS9xMGZxK3lPWEdjNUFzMTZC?=
 =?utf-8?B?aWV2Skk5YmMweE02b1hzcjBvbW1MQ0VHekNoRXh2azhac0tQck1jQUZlbjlG?=
 =?utf-8?B?MVRvSEkyaDlMTXBHenJ0TW10QzRxSW5lTjFNS1NuU2w3NkpXbnBsUlVPU0My?=
 =?utf-8?B?cThWeVJITGltNjhCNUlOZ3NvWGFtVGc1RTRVVWZRdWo2WWs5YVhkUm04aDdJ?=
 =?utf-8?B?U3U4aGg4L081NVhsTmZyenh2TEpUaml3cmgreTZVS3JsYlpwNmxQZVZwbTF4?=
 =?utf-8?B?cmY0RFVheWYrTURUYTdNeklBS2tnTTlKT1dsUHFMWWZkcU93UEU3L1Q5V0V1?=
 =?utf-8?B?UlZ3NmFjSjh3dW95NXVvaTJXSnY0MmxYRTI4UUdYUk5yRS9SMVprTkhZZTFJ?=
 =?utf-8?B?aHVvUTdPUHQ4eEsvRGxLT2VHUUpNUktra0xYTXlJTjczYU5rNllHVVF4UVZT?=
 =?utf-8?B?ckF6UzVmMEoxT1h5V1BZbktCYlpJTk5WcDZmSVI1aXBjcHVoYzZ2QjRDa0p1?=
 =?utf-8?B?S1I5OFcwcWRyN3NDNUZuMFRBYmh6Rm9CUExJRzNHalVPTllpS0dvK0VJTVB4?=
 =?utf-8?Q?g3aEgLwG9K81xz/r2n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f2dfa9-2384-4552-4087-08de79e98bd5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 12:28:31.5207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGtyTe9o/8p9qz+NNW+oT74NXHTEvOesyVwNSTzoyw/xJcBPf89YhwIxSnl1CeMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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

Hi Srini,

On 3/4/26 10:12, SHANMUGAM, SRINIVASAN wrote:
> [Public]
> 
> Hi Christian,
> 
> Good Morning!
> 
> Thank you! for taking the time to review and for your valuable feedback.
> 
> Few clarifications as below please:
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, March 2, 2026 6:31 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Kasiviswanathan, Harish
>> <Harish.Kasiviswanathan@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH v3 1/4] drm/amdgpu: Add render-node EVENTFD manager
>> core
>>
>> On 3/2/26 04:02, Srinivasan Shanmugam wrote:
>>> Introduce a per-drm_file eventfd manager to support render-node event
>>> subscriptions.
>>>
>>> The manager is implemented in amdgpu_eventfd.[ch] and is owned by the
>>> drm_file (amdgpu_fpriv). It maps event_id -> eventfd_id object, where
>>> each eventfd_id can have multiple eventfds bound (fan-out).
>>>
>>> The design is IRQ-safe for signaling: IRQ path takes the xarray lock
>>> (irqsave) and signals eventfds while still holding the lock.
>>>
>>> This patch only adds the core manager and wires its lifetime into
>>> open/postclose.
>>>
>>> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> Change-Id: Iac025dcb7c1b4f9ed74ac4190085e1925e2c8e68
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 321
>>> ++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |
>> 76 +++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  28 +-
>>>  5 files changed, 430 insertions(+), 3 deletions(-)  create mode
>>> 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
>>>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> index 006d49d6b4af..30b1cf3c6cdf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>> @@ -67,7 +67,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o
>> amdgpu_doorbell_mgr.o amdgpu_kms
>>>     amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>>     amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>>>     amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o
>> amdgpu_dev_coredump.o \
>>> -   amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o
>> amdgpu_ip.o
>>> +   amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o
>> amdgpu_ip.o \
>>> +   amdgpu_eventfd.o
>>>
>>>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 1e71a03c8bba..9e650b3707e3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -44,6 +44,7 @@
>>>  #include <linux/hashtable.h>
>>>  #include <linux/dma-fence.h>
>>>  #include <linux/pci.h>
>>> +#include <linux/xarray.h>
>>>
>>>  #include <drm/ttm/ttm_bo.h>
>>>  #include <drm/ttm/ttm_placement.h>
>>> @@ -434,6 +435,8 @@ struct amdgpu_flip_work {
>>>     bool                            async;
>>>  };
>>>
>>> +struct amdgpu_eventfd_mgr;
>>> +
>>>  /*
>>>   * file private structure
>>>   */
>>> @@ -453,6 +456,8 @@ struct amdgpu_fpriv {
>>>
>>>     /** GPU partition selection */
>>>     uint32_t                xcp_id;
>>> +
>>> +   struct amdgpu_eventfd_mgr       *eventfd_mgr;
>>
>> If possible we should embed that structure here instead of having a pointer.
> 
> I understand you prefer embedding struct amdgpu_eventfd_mgr in amdgpu_fpriv.
> 
> In my current series the USERQ fence driver holds a ref to the manager, so mgr can outlive fpriv.
> 
> Question: Do you want to keep mgr separately allocated + kref (mgr may outlive fpriv), or should I restrict mgr lifetime to fpriv to allow embedding?

Well that is something you need to figure out :)

The rational for the longer lifetime of the fence_drv is that when you share fences their lifetime is determined by a reference count. And those fences then reference the fence driver.

But for the eventfd manager the eventfds don't reference the eventfd manager. So it should be sufficient that on cleanup you deregister all eventfds, then eventually wait for all ongoing interrupts and that's it.

A reference count and with that not embedding the eventfd_mgr into fpriv would only be necessary if the lifetime of eventfd_mgr is defined by anything else than the lifetime of fpriv.

Regards,
Christian.

...
>>> +
>>> +   spin_lock(&id->lock);
>>> +   {
>>> +           struct amdgpu_eventfd_entry *it;
>>> +
>>> +           hlist_for_each_entry(it, &id->entries, hnode) {
>>> +                   if (it->eventfd == eventfd) {
>>
>> Absolutely clear NAK to stuff like that! You must compare the ctx instead.
>>
>> Apart from that is it problematic to bind the same fd to and event multiple times?
> 
> If the same (event_id, ctx) is bound again, should bind be a no-op returning 0, or should it return -EEXIST?
> 
>  I
>> mean it doesn't make to much sense but it also doesn't hurt us in any way.
> 
> Ack. I’ll stop storing and comparing the eventfd integer and instead use eventfd_ctx *ctx as the binding identity.
> For duplicate binds of the same (event_id, ctx), I plan to make bind idempotent (ignore duplicates and keep a single entry).
> For unbind, I’ll resolve the fd to ctx and remove the matching (event_id, ctx) entry.
> May I kno please, if this correct?

That sounds like something we can do, yes. But you need to document that behavior in the uAPI header.

> 
> 
> And other questions please:
> 
> 1. Signal count API:
> 
> My tree seems to have eventfd_signal(ctx) only (no count arg).
> 
> Question: For older kernels, is it acceptable to loop signal count times, or should we treat count as 1?

I don't see an use case for count != 1. What exactly is the background here?

> 
> 2. IRQ lifetime:
> 
> In IRQ paths where I copy mgr pointer, I’ll take a kref get/put around the signal to avoid raw pointer lifetime issues.

Well questionable idea, this means that the mgr can also be destroyed from IRQ context.

> 
> Question: OK with doing amdgpu_eventfd_mgr_get/put() in IRQ before/after signaling?

It would be better to just hold the appropriate lock while you work with the manager and not have reference counting, but as I wrote above that is up to you.

> 3. One clarification regarding lifetime:
> In the current design the eventfd manager and subscriptions are tied to the drm_file (fpriv), and longer-lived producers like the USERQ fence driver hold a kref to the manager if needed.
> Does that match the expected model, or would you prefer moving the subscriptions under VM lifetime instead?

I think the lifetime should be tied to the fpriv and not use get/put reference. Especially the fence_drv should not signal eventfds, but rather just the pure interrupt handler.

Regards,
Christian.

> 
> Thanks in advance!
> 
> Best regards,
> Srini
> 
>>
>> I'm running out of time to further review the patches, but I think that already gives
>> you quite a bit of todo.
>>
>> Regards,
>> Christian.
>>

