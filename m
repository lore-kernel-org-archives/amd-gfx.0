Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F088E9A754
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 09:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3200910E55F;
	Tue, 24 Mar 2026 09:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bx+OEAJc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013059.outbound.protection.outlook.com
 [40.107.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114BA10E55F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 09:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUXAKSpvoRM/DOVPdC3WG2ZOj+PX5p8R0dQOuh4XUgAwg0/73jtgRrm7ElQrDieK28hEYUT9Vn6BEoHPE+Lu6mEAD10b/53/qtsFGDpQE9bwVfOSsNmttscLjYTHThnjxrD7jWJ/bOg/GNQ/HGrPnSGZ1o2m4uttHp8lTLgKHCJQzeSsHkMKJXE0WEeW15qsqqUKrPuLQ48di3P2DFveTRy4MeEGmTOCYjn0ctM0xMb/irV73gk+unj0tEXG3vLVtjKNpnSJyVLRVR0FpX1MsRkODuBWoalDbCSyDn/QYC7RgI6sZ2k4VYbTuKB1RX9hNifydcMTZ6R13oKwBBv3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIaTqr/o8D+UFb97A3Hv56E1QCp71rqpiynXLpYaWYo=;
 b=e15VXUpiGAGb2uzHAnc39Ya6Cs804aoPo/dsGzTXzRMFJC8WVbtj7VmWLrkunWau6EBvbhkpzICWzWrcR9YulyMOkA7AUvJke+SSyzqkT5huklS+z0qtXlH8UDCMhGgReZ3eNDA2K+UDt0a++MDuJe00MzeNsZ+e1IvQ2RiImaRKFtRwYLrU6ozsgS/43pNNXAKiMQsheP5SSFUDK2jZ5S0qbodkR7OXWwsTMBQ3bO5vJQvs5vafMqC2heDZax73YVXvJtQepu79aIFzbk3fd48828SiGdWEIej8imYEp1yYBhPFe6AXhua8F3YmxnUjB5nYtA/PEDuShuGCbZYdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIaTqr/o8D+UFb97A3Hv56E1QCp71rqpiynXLpYaWYo=;
 b=Bx+OEAJcY8Ixr/CnnTfGOFFTAURGDAkrkSF48c2mtN+29Xa4U9T+lhsRVFNkUPJgCah3iw6bSSJaFA3yVitO0aimc4pHmD8PBidsNySreoXDti1PHP9nCCEuWXhqupeaYUaIDsEe8/5jEHYddEhjD56D+2L7/4eEFLVyz1FjiG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:50:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:50:05 +0000
Message-ID: <44091dac-3763-4adf-a7e8-2949288b706b@amd.com>
Date: Tue, 24 Mar 2026 10:50:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix the idr allocation flags
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
References: <20260323083923.3348059-1-Prike.Liang@amd.com>
 <1b28c112-c9c5-417d-b9e7-088100cbd22d@amd.com>
 <PH7PR12MB60006CEADD1F895156C60120FB4BA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB6000D706B3CC5758E03FC5B6FB48A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB6000D706B3CC5758E03FC5B6FB48A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0028.prod.exchangelabs.com
 (2603:10b6:207:18::41) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aac8858-0dde-4a92-cec8-08de898aba26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: GQbY2IJd1V3rT6ZOpdbft90gQidYpyVQ0d5Khz6jVaBQvuIx0LUF2mL0jKIoJizD7KhnqM+3M/QiXT0zrfxtmpkbPdzSuyeMSAKlEHeoXZbt1ahYfYb3jB6/CcUQLIUMW7aMjqOHTb1ShIohXirT7bwd3qRjTR0ab+sXK5q2Mv7UTmuxO6Fmf6527T+hJu3HZLt18o5zSczH0Varxn3R5iHsesQHFsbgOHGpcsLu/DSE6IXpvJxYZuhTl8clrn+W+LXSR0D4rRFQXhVlGnOHfys+D7TaD1yweBiogAc18yHeU6zmMXX+2MhHi7woHMaNbSRpUSGfceaJveWZuuwGJXuZe+ntW2+kLribG3u26HIyL/bsD97/tnFPeoQ8mM4dPbzJf+fdyObqji6StDN+mzN7rr7u5bSZehtnjEbpD0q8CsBHYfCSfXa4IgboCn+8rJkaWwS1PbbkuyBlww3q3jztSSNcZsC8tblUeViRlgtFdi55XvJiusn66cGBkICmr/7QWtJdCFMK7yz+gd0XYlaiuAo8K1fnpNnExw2pg38JQ2dFbuC/xICpc1PgyUCH9hIqzXJteUjsIEKyJxx6q7IG/B+lmGEzwQfs6XW8bID3LOI8ekbI+CG20cMEYRh17eAxb5jmjv+NZ9dNADCxEOQFKNV2qf0p4lqzEgOBFCRoBQylm/vx7K1sAgUzsLXbie4MsxnjN8wy0QMi9RCsmtVZMjipDgLwaOCeIEpinT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NEcjc2ZU9ScXAwY1hycG8xbjhQdEpOU2hxTnNEQm5PK1R5Mld1UWM0aThi?=
 =?utf-8?B?SlM0L214UWZaejdlMVNmMEdSdU9ibWdkM2RZamw4SGpjYmhGdGJ6VWxxMFFT?=
 =?utf-8?B?ZGh0RFp6RUZGVnVhbVJxa0NqeVlsODNvZU9OWlAvQTdudVhWaGFGSjFFckta?=
 =?utf-8?B?ZUJKUXRYOC9HQUtpQ2VBN3g1aEpCOGNmZzNURnU0MHhYRWR5UUFaZTM3SUFK?=
 =?utf-8?B?anNwbGZ1NE5yZFNDUUUzSTdVSWZjNWhGV3pTVmUxQmhva2xLK3hLQUQwVGk5?=
 =?utf-8?B?Snc1Mi9RZ052QUZiUjR3RENjV0tvVExMSlMxT245QW1jQThOUVp4MEZHRFpI?=
 =?utf-8?B?QUJ6Zm1HaGs2SmdKYjJCWXRRV2tGcVpWb3RjbkRxTXZkWFZiZ1MwWEhQWkNR?=
 =?utf-8?B?VVljT3Y4T3Urd3lROWhMUXN6dFJnRHcrZGxhcnE4NWhBTHM4NVE3REhKZDV3?=
 =?utf-8?B?Zk5zNXUzeUZZRSs4SE5rVEtvOGY1TFl6Q0tFbHVTYTBEMEZzN0FpelZtQnhT?=
 =?utf-8?B?RTh0QlI2dFhmR0VuWmJxd2VETExHNVBReUxFK2hFYWprTjdla3h3cFRBYTNY?=
 =?utf-8?B?cldFdzhSeDlwVHU4Z2ZvK0ZoanljaG9ZQUkvVzJZbzlzVFVTQWpLUng2NzR5?=
 =?utf-8?B?cXNabnBrYUsrb29pRHlQZFBYeFhHTWpXN1czczNJcHhMUkR6SUk4aUFiZzJ1?=
 =?utf-8?B?WXZuQmRFQTRyNlF0ekZqOW1icjRxUm1uOUVkb1cyK290Qm0vZ0FkOGVUMnBv?=
 =?utf-8?B?T0trRzBVdXE0U05TTno3VlBPL3BWb0NPSmNrQ2pJSEl4Zjl5OFZady9XaUVI?=
 =?utf-8?B?YS9FQ292enUzMkpDUjRMOHpxeTFpYWUyTnlJeVQ5cnlOYmNrelVxTXBseTF5?=
 =?utf-8?B?WjAwQlBjbndoZE5zS094WDFsWGp2WTVNWmczSFJFSFpSOGU4REhOK1pvNkxo?=
 =?utf-8?B?cnpNMjlOOHRtaERGbmFySjBnRGJTakYwRDJ3cVdVc2hWdjBoM3o1MlcyV0Zl?=
 =?utf-8?B?bUtyV0hDbk5ncFFhOEh1cXozM1c4RE94aW1zMHNwYWE3YldvRWZYQU5aT3Nz?=
 =?utf-8?B?Vko1RE5nVGpTam0yRHVUbWx3d2NDMWgrZ2VLYTgvdXpqaUhKMHphSytkUmI1?=
 =?utf-8?B?RFEyNkxRUkxxY0Ivc1ZaQWhNc05EeldiMFpFVUV2WmFnK1lnUmtzSGhiRmE4?=
 =?utf-8?B?YTZDYWM4WkxKdFNpWUpRd25EbTNqNDB0aDNVUUNHSWZJdVloWk1GUTB4emZ4?=
 =?utf-8?B?aWlkdW9zeXd3RzFxb3pRNmxOak9WMXB1QUYrYll2c2FxMkREbXhFZ3RwNk9G?=
 =?utf-8?B?R1FkZG11eE1tOXdBdlZpVWdGTUFMZU9MR2RwY0lnV1lHZC9wUTNRa2ZuMVFl?=
 =?utf-8?B?V3pnQy82czBlQU5VUFFjMjVoMW5aemlYeFFlSEdwZklsZnpHVUphUmF3MFA0?=
 =?utf-8?B?VWZtdGJYeVgvc3dsazl6ajZadTlNMGZCMFVZZ3RLU3pZaUZIbGRTQW1zellz?=
 =?utf-8?B?YS8rcmJFQ0FhSkhJWUlFNXVmVEJrQkIwM0RkVTVkOVo1cC9EaDFJSjdQdEVx?=
 =?utf-8?B?eE90bStndU95QnVQR0U5VWhmNjA0dUZodHRRTXBmZHlCRTdSdFJCU2pza3ds?=
 =?utf-8?B?dE5EclZOZVg2bHB2dXRCSWJvcWZoUVY5N1FqWG1aTTJwODBBQzczeENaVUEy?=
 =?utf-8?B?Tmc5dktGOHVnOVdvN3Z1R1Z6N29YRWpGL1NSWXZqNWtSOHpYcU9IVENrRmVt?=
 =?utf-8?B?S0RhWTk2YXBoVGlRSCtpaDJQcWJTdUczUm9Hb2FZSUt0elRSTTJSNnIzODI4?=
 =?utf-8?B?bldlWjJTMWNMN1pSZjBiWERwYkZJK2QvbXI0Ti82QnJ0VGJsNmxZY1NDLzYz?=
 =?utf-8?B?VFpMS2dFWWVVQkU4K2Q2RHB0U0xuZEErNjByRFppdGY2bXFwN2F0d1QvVWlj?=
 =?utf-8?B?QnAvUWJrSy9QYnp2c3BoM2dKYWRCb3BXdG03MEcxSHM0Uks5UURhb05wVG42?=
 =?utf-8?B?dE1oemZ3L3BxdHVFRWpnRlNSQWJ2S1c3MmgwSFFXNmx4T2dla3A1TVo2VHhY?=
 =?utf-8?B?YVpMRERqUUVmVmF5c2Iyc3lkMllDLzdXd25lNDFPUkxJL1I5S2U2M3llVFd4?=
 =?utf-8?B?QW91YzdQM3BkYmk4cXBVOGU4UDVNUnVGdERjVjUyMDVYYmRnOWM0THJlbmxD?=
 =?utf-8?B?aDVsNEwzSExJdXNjOUVYYzd5a1JKQUFjNURJeWdxYkc5djlpOTM5aU1jR1Bj?=
 =?utf-8?B?ZG0yT0VOL2pKbmxkbVZtQjJjTmpYRWd4VTNMdGtVTGF5RlJPVDV1d1NRQ2d4?=
 =?utf-8?Q?8rfA2DDGD5J4lAv6nG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac8858-0dde-4a92-cec8-08de898aba26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:50:05.6756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTXWfdri8cAyWgZn9bjRqff+czeGcmUKNn3c/MEDRigj7IhqutRz4SN70wgwLDRA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246
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

On 3/24/26 06:48, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang, Prike
>> Sent: Monday, March 23, 2026 8:14 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, JinHuiEric
>> <JinHuiEric.Huang@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: fix the idr allocation flags
>>
>> [Public]
>>
>> Regards,
>>       Prike
>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Monday, March 23, 2026 5:54 PM
>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, JinHuiEric
>>> <JinHuiEric.Huang@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: fix the idr allocation flags
>>>
>>>
>>>
>>> On 3/23/26 09:39, Prike Liang wrote:
>>>> Fix the IDR allocation flags by using atomic GFP flags in
>>>> non‑sleepable contexts to avoid the __might_sleep() complaint.
>>>>
>>>>   268.290239] [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on
>>>> minor 0 [  268.294900] BUG: sleeping function called from invalid
>>>> context at ./include/linux/sched/mm.h:323 [  268.295355] in_atomic():
>>>> 1, irqs_disabled(): 0, non_block: 0, pid: 1744, name: modprobe [
>>>> 268.295705] preempt_count: 1, expected: 0 [  268.295886] RCU nest
>>>> depth: 0, expected: 0 [  268.296072] 2 locks held by modprobe/1744:
>>>> [  268.296077]  #0: ffff8c3a44abd1b8 (&dev->mutex){....}-{4:4}, at:
>>>> __driver_attach+0xe4/0x210 [  268.296100]  #1: ffffffffc1a6ea78
>>> (amdgpu_pasid_idr_lock){+.+.}-{3:3}, at: amdgpu_pasid_alloc+0x26/0xe0
>>> [amdgpu]
>>>> [  268.296494] CPU: 12 UID: 0 PID: 1744 Comm: modprobe Tainted: G     U
>> OE
>>> 6.19.0-custom #16 PREEMPT(voluntary)
>>>> [  268.296498] Tainted: [U]=USER, [O]=OOT_MODULE,
>>> [E]=UNSIGNED_MODULE
>>>> [  268.296499] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS
>>>> RMJ1009A 06/13/2021 [  268.296501] Call Trace:
>>>>
>>>> Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse
>>>> case")
>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> index 644e413a4e69..2f552352e046 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>>> @@ -69,7 +69,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>>>>
>>>>     spin_lock(&amdgpu_pasid_idr_lock);
>>>>     pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
>>>> -                            1U << bits, GFP_KERNEL);
>>>> +                            1U << bits, GFP_ATOMIC);
>>>
>>> We should avoid using GFP_ATOMIC here and rather replace the spinlock
>>> with a mutex.
>> OK, I will check that whether can use a mutex for the idr allocation in other places.
> We may can't replace the spinlock with mutex here, since the lock need to be used in the DMA fence callback within the amdgpu_pasid_free_delayed().

Good point. In that case please add a TODO comment that we need to replace the idr with an xarray at some point and push the patch with my rb.

Thanks,
Christian.

> 
>>> Regards,
>>> Christian.
>>>
>>>>     spin_unlock(&amdgpu_pasid_idr_lock);
>>>>
>>>>     if (pasid >= 0)
> 

