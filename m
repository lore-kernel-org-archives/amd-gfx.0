Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A42CA9EC5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 07:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F05C10EEFF;
	Mon, 12 Oct 2026 07:43:07 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A898810EEFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 07:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCpMO2sHtJ7jmp+elnfyoGnXog3hIrb2fL8D5mqkpeeCjJ5yQCU6inXp8jfD1wC4F57psO0jSwtBqrlas5WMP3Y0xY6Lu+1NayYblX9saJxgdv4oys9p/F8Y0MRCVHLi2ZTkhYyuLEpKpnbKXbKsJIrcS6EtZaKpnupmO2vu5iX8FIZc5KRnHCtFmtqwVFLdk/Ul70Aus/VZIqGLp4G9ZlrddBoNVFSDOCEB5729A2O+G5rokLk65OlPmCVKN/lkgbETxg2mprLATgBxy7B3BVN6LTk4pPNjefuq2Pj5L+b7YBOTsy0uWNxy83bij3dVMBYn293ngfZREhWM0qiI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKeYpfUCi7A+O+RJlcneSJunq9YjZ32uOBnx8upDqPw=;
 b=yzwRbeQmxANnlLf4HabjFoXtxMhTBJ+OpWQ1DrCXc3xaeBxnXXyMBWewCM1dm2axleHx3aSiieRg1wo8hYZ/sb5KS8l+O9QtDr2E2dsjzCQBJXLYQ6Gczetg3kasTJsE+G7bamgkx0ITaerCduR/I/+EFoUiI230NuLMquEKO+HgmpGe/8aRA1k5AGTWWRjy0zz5yMVXtW8KFZeZyfzYNfsglb2EK1Y3eKz9flAi9VjzO23zV/cqWRLs5xpXTnBN6VhAza1D7OxdFKcBWXYWEU8vaV35zyuja6rmLxsU0QalUXdEheCGR6ZrDuwh/F3CEEDQ66HmI8VcmazKjg1XPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKeYpfUCi7A+O+RJlcneSJunq9YjZ32uOBnx8upDqPw=;
 b=dydNlSTaARi/bquuk2+wR0fStyH0b6yfcB+tTnRMbO1rSSrowQ/dxiOzYdxrk3ONcBXLj/g7aL65i4p6cEmMoErafn7nBKit4AGkBFpdg/YrK4ZQcetHbtD+/g4y/gkayMTuGnza1LITIgH2Y0HFWiLrPBy2p8pTNpCRd6ofpVU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 07:42:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:42:46 +0000
Message-ID: <89da0aeb-c78d-450c-9d6d-38c24f5607b6@amd.com>
Date: Mon, 12 Oct 2026 09:42:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: preempt KFD queues before taking the reset
 domain lock
To: "Palacek, William" <William.Palacek@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20261008140045.1283288-1-William.Palacek@amd.com>
 <87e18cc7-2382-4440-96bc-605dc0828ab6@amd.com>
 <3d43d8fb-0cd6-49d3-a64e-dbbc160a7c62@amd.com>
 <CY8PR12MB71224C7E830D21794087E330F9912@CY8PR12MB7122.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY8PR12MB71224C7E830D21794087E330F9912@CY8PR12MB7122.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: b42b5b78-87ba-42f4-9982-08df2834680d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|5023799004|4143699003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: GnenPUebGGPjTUIk0i9psBLfd74gv4G4It05u46SyOMw9gdu1ZFXg/LxCJnCm47lNNHwlgvSabTT2rQGQOJyivH62h3XQ2Jg9TpKK6fdmbsoEx6fuQoRCDr6EyZbaZKRx5jyseHjDF67SOQQOekzFggI4EGC0OTBVJPi6T0VXlngc307hQkHFSZJOXIK2OI8YlODEoUwCPycC0QY649RN3R4hyCxIA2NDdDfYrEJFgySmqmSptweQWCwfXd4ePX8QdZzruxCs+fHOx4Wl0TXDbr0Dm2DSdVjXz0lNQXDjhsksPtFqO1iZlUFWH9zJayxm/am/869jnReehuK+gJi4xF1bes3ASk84BMEMjwF3U0RYz3yNF8LkdB5XqQirjFe4IPq87wOuXrc2iDVD2+3GqEyr3g/OV0VjL3b32m1VaejEBgWjT8d2xeDVxmokc9MHmH0dfTmzUAspxp2thvA5QTXAKZ+kezxvSjTMzFz52nujZvmy35ZeqYspy3xW+fpsCff73jKD95O5ZF2aM4pCtmS9IwoKqAFIQq8pXCg89Wh1jFfza9ZDcCfu5j3d4EDajfRebPsK9/gonbR4Rg9TmcP29r3vAA73XF0dswgbXt5dUpNSXj7u8q9a+975jvUu6awQcawHprNKTbdfyLQE6jYnEYDsqXFplGT5ICCc5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(5023799004)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2FYMzFuK3NEL3k4WXFXMEh0MW5PUEVVN2FRYnVTaXhTK2JncUJrWTVacFht?=
 =?utf-8?B?ei9oOG92N1hyZnJvK2dUZTJ4aFFZZlhDYXpmRWVRWEt5MWgzM3pnTGRiSVJB?=
 =?utf-8?B?NDFkbmFydUYrbjJDOU81MGlRbGNnblVaQTVaeU4yMTdOT015WDUxRjdqU0tj?=
 =?utf-8?B?SDdjTzlZdDRSanNqWXZHN3JUZVpLNXVpWGJOVDBESURIVWFRUTNzaTFjaFht?=
 =?utf-8?B?bk1Vc1VhaHV6QWhsYkVSQWs4Um9SYS9zR01BU3crUkJwZEgxdk5wS2dYTWFD?=
 =?utf-8?B?VFE2T0F2SmNxZytwYnhjY2hYQy84bENZR25GQUtZQ0NlblkycWlUa2o2dVZZ?=
 =?utf-8?B?a3o0RjlqalZkc0ljaUtQV3ZEUENvcGh5U1NSUG84b0FoMnVxMUpsLzFxMDVl?=
 =?utf-8?B?MkRDeWVURnVMbDNPK0Q0bk04OFEzWTlSZk03MXVrQTIrS1hxVnFmTUQrYVhj?=
 =?utf-8?B?NUhPN3F1enpJTGd2dmhudit1QWRYemJuMHlDcHN2SExZTnp3TFpCbzhQK2U4?=
 =?utf-8?B?UzZoT3RyeGtpVVhQTExLdk9EZWpLczVJQmJZUnlCZGs5QnFGVUtTZis4RnNZ?=
 =?utf-8?B?Q3pGR2V6UVpEbmM0cWZwTUVsNGN0aHVIOHZ2aU1Vemc2dkE1VUtuMnkyWjFE?=
 =?utf-8?B?aFZ6L1FpMytUM1dHS3BPbGZQamhmcTRJVTM3Qk9La3hWN1pOVE5CWkd6cXpM?=
 =?utf-8?B?RWpmQjNQVi9SL0hNV3ZYRU5CYlNweTNEWUVvWGhjMkp4WXlQelRvUTJXMytK?=
 =?utf-8?B?anh6L241SWFnTUROaUNQUTNBOHNwenpjNVAvT2QzM0QvbjA4U0NlL1VwUUNE?=
 =?utf-8?B?K1BOSm1ycFowZWJITUF4MmJZYXk0R2tNS0JPODFBRTNrMHRndlJoU253TDRI?=
 =?utf-8?B?U2xFckc2QkFsektSYjRpWHg0cDQxYTY5MDROdk9RN09vOTNhd3IrRE9zYkw3?=
 =?utf-8?B?K0F2VkgzSmRNLzBzTmpmNUxVeDB1eVN3bFp2cDdBbG9VZDROMkgrVTM0Z3VR?=
 =?utf-8?B?N0hjSXNKazBLaURCNXpZMXhKS2FvU2JvYm5zNncwSDNpS2tsUGlGTDR5cjZC?=
 =?utf-8?B?NmVwby9GL25QcGFQTGRqa2REQTYzcUtTbUNUY0UrcHZQUVpFSTdOZWljQkpo?=
 =?utf-8?B?YSt3WG9PeWRKQUtLajNGQ0ROWHJzbytPbGlXZHJ2QmtlUVltd2RzY3kvK2FI?=
 =?utf-8?B?MTI4bThFRFZPckUxandhVDFBb2lKLy96aVl5TE5yenk4VnJPK2V6R1J3Um1x?=
 =?utf-8?B?bDRLRnV3cWs4eDV5QWIvWmpidkNtRW5YSS93TWhRbkhTeE53YS9HRVZCR1pK?=
 =?utf-8?B?aXpsR1lXdEJKdE1ybWhqV0p5dG5KYVRXbXFEdEx2SFBNMzI4d0poVnlXQ29Y?=
 =?utf-8?B?WmxIUjFZck9aTldCSnlxY0NxWWp4alhCVDZTODNFZGNxL05ZQ1BQc2o4bnRH?=
 =?utf-8?B?VFJXY2VQZW9wVlc3YnlBbVhMNVhjQWtzNEpVN1Q0WkdCaWZOZVl3Sk43d0px?=
 =?utf-8?B?bnliRWJjTjI5WGtzcTRmcU1uQmZFZmpFYTNRT2xHdnVqL0JjQVdTTlZVNFgv?=
 =?utf-8?B?MEVxYUZTTWhKMlFSanJRdVBaVy9vYlFXSjY1R3h6ZVdKTklubjlxTzJzTzR1?=
 =?utf-8?B?cEorVjd6bktLWHVMQ0ltallqcFd6NnNIZXVBSjIvQlFobUdwUWdIZUFrUjRT?=
 =?utf-8?B?aDFkc3ZxeGNsZTJDdDNzWUNJSURSckJRSGowY2dlNWJ3Y0RndDJVandBMzN2?=
 =?utf-8?B?SVlLWE1acGkxbS9BL0lWMXhjWHBiUFczaHBURklrbzFDU0JqUkUyRkxKWE1W?=
 =?utf-8?B?QWtMTmJqYk9QNnkyenc3ZXkxQmozdnFXZlFXQW1xaXl3YkRLVGdQSXR5b1RP?=
 =?utf-8?B?Q0E3bGRlaENKUm42YjZ3cWw0M3RGTjc3WGJ5ZW9kdU1jdGNGNnpuckRKSWt1?=
 =?utf-8?B?Q29aaXFmRGllTW9UN1JRekNFVmNkamtKUnY1ZUVBblprdXByWW5iZE9qNGlr?=
 =?utf-8?B?K2lBalhNUkxIMGhQVWxWT1FVY1VueUpsYVhPS3ZGTFpvUlh6bkpEVEJFS2hS?=
 =?utf-8?B?TlIzTkdjQ1Nya21nVXF1c2ZhdCtqZ0I5elA5OEhYV1VJdWJaUENwOEk5cGRp?=
 =?utf-8?B?OUo5UlVCMXJHb2d5bkQ4SDY4V1Fxbm5aOFJST2wwemtwUUJoYUlFZGVvcGE1?=
 =?utf-8?B?REJaWkw0d3JjVG4vemJycnUvUGxkNCtHQUFiUVVDUjB1V2t5bG4wZUNWY1ZE?=
 =?utf-8?B?NE1SdkN3WTNlLytSVjE3S0x2VDBZRjYvQ01JL1lSckpGeFVlSzAxM040VHNB?=
 =?utf-8?Q?ZdnJ6+3eIeizMRlRtZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42b5b78-87ba-42f4-9982-08df2834680d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:42:46.0923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsMIEZDaF8E2eB2runeW1eNG788o/LuVECDQ8xacVj459JdQOAJRpnIPHG09WL5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164
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

Hi William,

yeah Felix pointed it out already.

When we device to reset the ASIC this harsch the GPU is already completely gone, partial recovery by unmapping the KFD queues is not possible any more at that point.

So clear NAK to the whole approach.

Regards,
Christian.

On 10/10/26 18:27, Palacek, William wrote:
> AMD General
> 
> Hi Felix,
> 
> Thanks for the review. v3 addresses these:
> 
> - Interrupts during reset: with v3, KFD pre-reset runs before the reset
>   domain is locked, so the unmap is sent and waited for while the GPU can
>   still respond.
>   Filtering interrupts for a half-broken GPU is a separate change; KFD also
>   needs the fence interrupt for process-close draining, so I'd rather do that
>   as a follow-up than fold it in here.
> - amdgpu_amdkfd_pre_reset() now takes the device list; the extra wrapper is gone.
> - pci_channel_state: you're right, it is only set in
>   amdgpu_pci_error_detected(). kfd_dqm_can_reach_hw() is dropped, so no new
>   "is the GPU usable" condition is added.
> - unmap_queues_cpsch() now returns -EIO when the HWS is known to be hung.
>   The MES check is removed.
> 
> Regards,
> William
> 
> ----------------------------------------------------------------------------------------------------------------------------------
> 1 Commerce Valley Drive, Markham, ON L3T 7X6
> LinkedIn  |  Instagram  |  X  |  amd.com
> 
> 
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Thursday, October 8, 2026 11:58 AM
> To: Palacek, William <William.Palacek@amd.com>; amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Russell, Kent <Kent.Russell@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: preempt KFD queues before taking the reset domain lock
> 
> [+Christian for comments on reset architecture]
> 
> On 2026-10-08 11:46, Kuehling, Felix wrote:
>>
>> On 2026-10-08 10:00, William Palacek wrote:
>>> A GPU reset issued while processes are using the device can Oops the
>>> host in munmap() (free_swap_cache) after SDMA write faults from a
>>> user queue whose process has already exited.
>>>
>>> amdgpu_device_gpu_recover() takes reset_domain->sem for write before
>>> amdgpu_amdkfd_pre_reset(), so the down_read_trylock() in
>>> unmap_queues_cpsch() and execute_queues_cpsch() fails with -EIO and
>>> no unmap is sent. stop_cpsch() still clears sched_running, so user
>>> queues keep running while their memory is freed.
>>
>> There is a general assumption that the GPU is stuck when we're in a
>> GPU reset. It seems in your scenario, the GPU is not entirely stuck.
>> So you can still get interrupts from the GPU. At the same time, you
>> can't rely on MES or HWS to unmap queues when the GPU is in a
>> half-broken state. So while your patch may help in this special case,
>> there could be other cases where you can't reliably stop the GPU from
>> sending spurious interrupts while a reset is in progress.
>>
>> Maybe we need something in the interrupt handler to ignore interrupts
>> while a GPU reset is in progress.
> 
> It's also possible that there are still interrupts pending in the IH ring when a reset starts that won't get processed until later. Do we drain or discard pending IRQs before starting a reset?
> 
> Regards,
>     Felix
> 
> 
>>
>>
>>>
>>> Call amdgpu_amdkfd_pre_reset() before the lock, for gpu_recover and
>>> PCI error handling. Skip the dequeue when the HWS is hung or the PCI
>>> link is down, so recovery does not wait out the preemption timeout.
>>>
>>> Signed-off-by: William Palacek <William.Palacek@amd.com>
>>> ---
>>>
>>> Notes:
>>>      v2:
>>>      - Drop the SRC_USER gate and the helper; run for every reset
>>> source
>>>      - Cover amdgpu_pci_error_detected() as well as gpu_recover()
>>>      - Skip the dequeue when the HWS is hung or the PCI link is down
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       | 16
>>> ++++++++++++++--
>>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 14
>>> ++++++++++++++
>>>   2 files changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index e0014611f039..8ae6228dbf31 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5479,6 +5479,16 @@ static void
>>> amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
>>>       }
>>>   }
>>>   +/* Dequeueing needs reset_domain->sem for read, so run before it
>>> is write-locked */
>>> +static void amdgpu_device_kfd_pre_reset(struct amdgpu_reset_context
>>> *reset_context,
>>> +                    struct list_head *device_list)
>>
>> Instead of adding a new function with a confusingly similar name,
>> should we change the signature of amdgpu_amdkfd_pre_reset to accept a
>> device-list instead?
>>
>>
>>> +{
>>> +    struct amdgpu_device *tmp_adev;
>>> +
>>> +    list_for_each_entry(tmp_adev, device_list, reset_list)
>>> +        amdgpu_amdkfd_pre_reset(tmp_adev, reset_context); }
>>> +
>>>   static void amdgpu_device_recovery_get_reset_lock(struct
>>> amdgpu_device *adev,
>>>                             struct list_head *device_list)
>>>   {
>>> @@ -5534,8 +5544,6 @@ static void
>>> amdgpu_device_halt_activities(struct amdgpu_device *adev,
>>> cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>>>   -        amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>>> -
>>>           /*
>>>            * Mark these ASICs to be reset as untracked first
>>>            * And add them back after reset completed @@ -5784,6
>>> +5792,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>       /* Cannot be called after locking reset domain */
>>>       amdgpu_ras_pre_reset(adev, &device_list);
>>>   +    /* Cannot be called after locking reset domain either */
>>> +    amdgpu_device_kfd_pre_reset(reset_context, &device_list);
>>> +
>>>       /* We need to lock reset domain only once both for XGMI and
>>> single device */
>>>       amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>>   @@ -6232,6 +6243,7 @@ pci_ers_result_t
>>> amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>>>           INIT_LIST_HEAD(&device_list);
>>>             amdgpu_device_recovery_prepare(adev, &device_list, hive);
>>> +        amdgpu_device_kfd_pre_reset(&reset_context, &device_list);
>>>           amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>>>           amdgpu_device_halt_activities(adev, NULL, &reset_context,
>>> &device_list,
>>>                             hive, false); diff --git
>>> a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index 5e57576fba21..988fce11a4fb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -81,6 +81,16 @@ static void set_queue_as_reset(struct
>>> device_queue_manager *dqm, struct queue *q
>>>                      struct qcm_process_device *qpd, bool verbose);
>>>   static int reset_queues_mes(struct device_queue_manager *dqm,
>>> struct queue *q);
>>>   +/*
>>> + * A dead HWS or an offline PCI link cannot service a dequeue
>>> request. Skip it
>>> + * rather than wait out queue_preemption_timeout_ms per node.
>>> + */
>>> +static inline bool kfd_dqm_can_reach_hw(struct device_queue_manager
>>> *dqm)
>>> +{
>>> +    return !dqm->is_hws_hang &&
>>> +           dqm->dev->adev->pci_channel_state ==
>>> +pci_channel_io_normal;
>>
>> Is pci_channel_state always valid? I notice that pci_channel_io_normal
>> is 1. pci_channel_state is only set in amdgpu_pci_error_detected. If
>> that never gets called, pci_channel_state is probably 0-initialized
>> and this condition will never be true.
>>
>> I'm a bit cautious about spreading different versions of "is the GPU
>> usable" throughout the code. There are lots of things you could look
>> at. I've seen different conditions related to GPU hot-unplug in
>> another patch I'm reviewing. These kinds of conditions should be
>> managed carefully, otherwise we end up with subtly different or broken
>> conditions all over the place and it will be a mess to fix later. Or
>> the the code becomes unmaintainable if the conditions need to change,
>> because now you have to change it in 15 different places.
>>
>>
>>> +}
>>> +
>>>   static inline
>>>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type
>>> type)
>>>   {
>>> @@ -314,6 +324,8 @@ static int
>>> remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>>>         if (!dqm->sched_running || dqm->sched_halt)
>>>           return 0;
>>> +    if (!kfd_dqm_can_reach_hw(dqm))
>>> +        return 0;
>>
>> Why does this return 0 and not -EIO? Isn't this logically the same as
>> the next condition? We don't talk to MES because the GPU is hanging
>> and a reset in progress.
>>
>>
>>>       if (!down_read_trylock(&adev->reset_domain->sem))
>>>           return -EIO;
>>>   @@ -2832,6 +2844,8 @@ static int unmap_queues_cpsch(struct
>>> device_queue_manager *dqm,
>>>         if (!dqm->sched_running)
>>>           return 0;
>>> +    if (!kfd_dqm_can_reach_hw(dqm))
>>> +        return 0;
>>
>> Same question as above.
>>
>> Regards,
>>   Felix
>>
>>
>>>       if (!dqm->active_runlist)
>>>           return 0;
>>>       if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem))

