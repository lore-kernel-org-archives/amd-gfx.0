Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FB0C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 13:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A713610E4C3;
	Tue,  7 Jul 2026 13:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4oYKVX5z";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71AB10E4C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 13:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGm9V41UUi+rqSKvRJMxDRtbCQAXu83NOicFBIFlgDS8nvj25fnlxf2ifQ+KPQdP1yvVDDtbcS4AbVKWNUFJe24M56K8W787lEHi+JLZY2dW5RDzuKU+po1xgATpEkVuTYDqNAgIXl8+eJPmF1VKgEyaPepY/4WDk5u3JiAJbwoCSd/gN6A2fL3j8RTbHYXr/EFczswmU1JywFmWvbiYP+JIflvAdg2YC8jxPkGuDeIXd2bDl68VjlzyntbrUB/H0dcs0KX3wATEPGZUi7Oq3OYHAaJoOjcKUsclZRwX/+InJnn17f52ErNpayThThV2i6l8EBhjqFkEFZKryzsbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq51QS1CnFt3b6xaMpsITPN7FB8mao2eh++xNz07YsE=;
 b=gn/IjbYufgrf/vr5Y2mH+CjoyhU1ZHOcAJiQqBb6YURprYeNc/F3Te+WPLyor9vL9ig1s45QZlfWw3/4MDkDc+Z2c0lRTNidqDA+FFmTOksouxnWhRofpvLMsI3MALzCqnR5SAVHlqCM5xoVnyNBhQr51+t34rQgdAsvWHdzuGAjgBab4DZhRTpoD+PY+ER3dGBgh8zEk2we6X1Sj2qR8UJmGjqUzJXYd8nQ4tgFsLf3q9nzjrzq+KLgHTeu3u4ScQhsARTaymHcx9Hg1+yX2E5iWOVH3YPRTiqyT68B+8N6y5aD68UsHTAzyNATd1PUXs2WrY1744JQEvS3TqNTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq51QS1CnFt3b6xaMpsITPN7FB8mao2eh++xNz07YsE=;
 b=4oYKVX5zkXmSMgzHdzcWzmXKTRSb0wk6kZ80YboTn5UlTU+tSfuz+ey/Mdby8xRCxPdzMnuKvbH6P4xoiFFJXSv8b4aFf9oH3fpppnIAKlXh9FSsIPupgABaPugi/BJ982aAVOaUf+nANPRy3JJG8tsUDC3zb+M+XDigCRC0aHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Tue, 7 Jul
 2026 13:04:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 13:04:34 +0000
Message-ID: <7645febb-2256-4e39-bcbe-3b61dab7db80@amd.com>
Date: Tue, 7 Jul 2026 15:04:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amdgpu: Drop vm_manager PASID to VM mapping
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
 <20260703061833.3163913-4-srinivasan.shanmugam@amd.com>
 <3f732fbc-5a36-4818-9247-4539ed791872@amd.com>
 <IA0PR12MB82085C8E4A1E00B94B602B8B90F42@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB82085C8E4A1E00B94B602B8B90F42@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:208:32f::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0569c3-349e-4409-9f91-08dedc284a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|18002099003|56012099006|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: HN4noeuQsVxREvIsM9GPCES75uT3+e0KRhlj7+lsF8Nf49jnBxgFWNtIeDVlyrBgKkVM0YxtwotwrEaFvoHnh4hwGW4vzjefIuvBlOTM7Mpa4NaT/sxYwMdY6n13ccVakxjV6WIV4AbdE1YITzG1boFBodWuhCaIDi7jNnOPIqaGc5yxen60H7hXL3kFVfZYFewJyFcVYf6mDY5ikOfyMgeyZ3geDD+Zf2gkFQGgQqwKfQn0sybs+BPajSF2Le3zPef/8Icq9NmUmCcHEjWqObecs8I4p96hB85zBosiYQ1v1Nw3VaQGLC/OnyTgpw5RsdywQbgXfXhNBx9ngItQx/Zg9j9wicAk3Np3/fOUl39E00orJdnPQNBLFqcMNoMp9tob3+PJjacauA/alVCCbhdGmIV7C894KPGhafOJxrMy/ZAFnas3llG7ljiTQMAVQT0FQJR0Po/kuMySZBhW/it5FDNjD1yYhrZqmZIHC5SNGNO+qPFIZ33weGcyoqnMZb7BQETB3NdV6C5DlkvvUAsCXMtrRQVxWC3HpNQ3b/8CCYLGfDO5EZNgO47IHHMoVNTNpQJ6KGXs+50MJ9jDVhJfd51jGoms+77t/S0H9rtJ5qfFwM7WGQmwTEZ0hsY12GJ1tVSFqnMNwzhVxm5XQcvlsf50JajLKNk/nsqLGeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(56012099006)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRYOXZvazlDZTFiMjV0WE1DQ1E2dTVoY2hRbkk0RmtXT0xObXM3cG54SVRO?=
 =?utf-8?B?c2t6dkR0U0U1dXIvYTkvcnpwM3pWS3BacE5BRUQ1UWJSNFgyMTdaRGk2ei9a?=
 =?utf-8?B?UlltRU9KTmNIbkxiNm16RFlrcStNZzI3NkkxRUZzV3drNlJNLzZnNEdudFkw?=
 =?utf-8?B?K25wSFlPSDhwM0hVZTl2aEVtU3Nyd1ppK0FWZE9zQ2J4ekl2T3BUdzMrNWEr?=
 =?utf-8?B?b2VvdEVqNG9SZ2NVRjhBL2ZyR3NvQVc1SzdJVTdZOHdvN1VFYTJtV0NrbWlx?=
 =?utf-8?B?WlZGL3VGZ1l4Z0hCSjVZQmdmYUFjbWNrZEpPanhkanNyVjJpb0l5T2xwUjdK?=
 =?utf-8?B?bmhBUUUrb1F5SUxTTnVMRHh6bmx3UkZIVEttTGM2T2hTelZ5Rkt2T2RiL1VT?=
 =?utf-8?B?STNvM0ZiK0M0WHhjWDZsdHdEeVpha0hXaWdLZEZTMjRtK3UvWUR5WkJFeXht?=
 =?utf-8?B?b2lGUW1nQUc2MHJ2bnY2cm42RnJkQXVJOENsdEdRMlAzcUwwZ0hSajM0VGpn?=
 =?utf-8?B?eTFDTWI4WWxUWU1kMjQ5OTJnd2hGQlRDR3IwUmZQYy9KYXJCYXpoSWkwbmta?=
 =?utf-8?B?S0NMT3FtZzVRZ1FZcE1odWhsNGJTV2lmRHFJMWhnVHRGcFRTcVRHSzM5a010?=
 =?utf-8?B?ajFQZGhEdGZnT3RjVVIzeUZNa1FFbDlsOWdBR05CRmgzSUxjclpxSGE0Y2ky?=
 =?utf-8?B?Slk3Ymw2MU9uWmQ2ZGExb0p3MCtqdEpOSTliNmFoQi9KTnZsekZqTlNMNGpt?=
 =?utf-8?B?d0Y3RkpQK0JzVDcwSEZUM0I3STBjTE1qcTF0TjlmTHRoeGp2ZEt2OEVXMFpo?=
 =?utf-8?B?VjRZV1lKc3lRU0xnQlpXUXBwOWxoVUkwL0Nsd1JNemx6ZlB0SWV2OC91aFRx?=
 =?utf-8?B?Tmh1YWpDendIVkNiTk1OdiswMXBPSVNwWWRwY2ZTbHhuNnlYR1ZVOEs1dGN3?=
 =?utf-8?B?SVFQTHVHTHpvYjRkWmZRbTM1Zk13MklYeGJWOXB4NndLdWU1TUkzMUtHSzFY?=
 =?utf-8?B?S2IwYVRValJmS3d3QWd0Z2Zscm56RVFHNHFWQVhacHV5QnB6M3lFWmNEakZw?=
 =?utf-8?B?UTNKR3IrNlFYbkJvazZ6ajVNVWJLblc2WEI5QjFseEZOelBrdFhFRUhsOU52?=
 =?utf-8?B?N0RqcDdPeTdvbjRVUlg3YUtZZEE2VzNGMmMzcGV5QVFHYkZiUUNDWncrSjNE?=
 =?utf-8?B?RkljREl2dVI1VDVHL1o0dTA5REpLSVhqRkRoQXRhdXBGU3lvSSt2Mm8wTlNo?=
 =?utf-8?B?S1lPLzQ4VE5rOUN4K1A0YXNYQWVsMFFXVG4xVEhhUEZReXN3OXIySFVuOGZE?=
 =?utf-8?B?OGhBQlVHcURiWEpTSjArcFFiS2k2V0lkMVFxVVJvcFNqc0xkMWVtSmIyNlp1?=
 =?utf-8?B?cEZTQ2ZCY3g2TmdOZWF2ZnF3aTQvUkd0cTgyRXZGWkRsSmlxc2VMUmV2clVv?=
 =?utf-8?B?QllGWm5vQnpZeWdnaDlLYWg5cCs2VnZUSVZNSm9YQkRhaDZDQVdjZGZ2dUdE?=
 =?utf-8?B?ekJxc0JzNzRQaithNWtXUjRzb3IvR1RBV0pocFk0UVM4WGFsMFdjaTd3Y1cv?=
 =?utf-8?B?TGRSWXlMMmVObEp3RlNhY2h4TmxuRFh5Y1M1WHBYbU9BOG95c2F4NjNoTmwy?=
 =?utf-8?B?aG1kMmdZTTM3STQ5dFdRNlBxekNXMU9QeE43RXNYRkVzZWVNdTJFdHJWN3Rt?=
 =?utf-8?B?dWtWSitDb2J4RjJwbEdDYXlHVDBBUlppUERzQnBRS2dRUFY2Qy9uemdtMk1U?=
 =?utf-8?B?R0luQytGWi9WNWdNS05FMjF1a2dIRHE4SDVhSm9aUXdSRDBaa2xzb2hCL2kr?=
 =?utf-8?B?b2dVbUZSOHRsbmlnK1ZVOFJoYUIxMGhlZjRQdUdGbzRzYUR2V3c0M2hvUnNE?=
 =?utf-8?B?ejVlZ0pwWno2eW5heDJmOW5VazMraElPdDhjUnlhdlpYNEJoUE5vZHA1elpz?=
 =?utf-8?B?aEs4blc5aytjUGZqVG1iVVp4OEdNT2MwbThQWXBhaWMvMzMxR09Ha0pkc2Yx?=
 =?utf-8?B?Z1hFSmdSMUJ1VVQwbHFLUVlydnJsY1c1ckkvbEtMZXIzVXp5YjhaQzlFZFJk?=
 =?utf-8?B?MkhOZWdNYU9tRTdGMUt5bFcvc0VGSWQ0Vkw0ejhuall3Wnp0Tmo5Y21PTTBy?=
 =?utf-8?B?MzdEYjdQMkZOZmhkRVNBazA3RU1rNStGVjdoRFZaSlNtSUNnTS9GSjFseHJy?=
 =?utf-8?B?MXNMZHpWeXE1ZXJsSE1wTVdLdEl1bW1yQVV0WDhETjQwTXdhVFFWNDdyTnJE?=
 =?utf-8?B?MExaSFBiTDYwcU9Zb3lNM01JSG9pNkdjTk5oOEp5ZGFSY1FLNWN5VzE2K2RE?=
 =?utf-8?Q?WdlmuZAo3tkK5eFKZl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0569c3-349e-4409-9f91-08dedc284a6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:04:34.2969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSf6iMVKoLSkKZdVoyYH9oiiEe17opEHXS/R169SwhQOlksnWIRiyjSk13CE1a9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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

On 7/3/26 12:36, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
> Hi Christian,
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, July 3, 2026 1:14 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v4 3/3] drm/amdgpu: Drop vm_manager PASID to VM
>> mapping
>>
>> On 7/3/26 08:18, Srinivasan Shanmugam wrote:
>>> VM lookup users now resolve DRM PASIDs through the global PASID xarray:
>>>
>>>     PASID -> fpriv -> VM
>>>
>>> The per-device vm_manager.pasids xarray is no longer needed.
>>>
>>> Remove PASID registration and teardown from VM init/fini paths, drop
>>> vm_manager PASID initialization/cleanup, and remove the xarray from
>>> struct amdgpu_vm_manager.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 ++-----------------------
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ----
>>>  2 files changed, 2 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 9092ff227a55..74836240edbb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2647,14 +2647,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm,
>>>     if (r)
>>>             dev_dbg(adev->dev, "Failed to create task info for VM\n");
>>>
>>> -   /* Store new PASID in XArray (if non-zero) */
>>> -   if (pasid != 0) {
>>> -           r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
>> GFP_KERNEL));
>>> -           if (r < 0)
>>> -                   goto error_free_root;
>>> -
>>> -           vm->pasid = pasid;
>>> -   }
>>> +   vm->pasid = pasid;
>>
>> What do we actually still need the pasid in the VM for?
> 
> I checked the remaining vm->pasid users. It looks like vm->pasid is still needed for existing hardware programming paths (TLB flushes, PASID mapping packets, tracepoints, etc.), while this series only removes the separate vm_manager.pasids lookup table.

Ah, yes. Especially the TLB flushes are a good point.

> 
> My understanding is therefore that:
> 
> vm->pasid
>     remains as per-VM state
> 
> vm_manager.pasids
>     can be removed because lookups now go
>     PASID -> fpriv -> VM
> 
> May I kno pls, does that match your expectation, or were you thinking of removing vm->pasid as well?

Please go ahead with the current plan of removing vm_manager.pasids but keeping vm->pasid.

Thanks,
Christian.

> 
> Regards,
> Srini
> 
>>
>> Regards,
>> Christian.

