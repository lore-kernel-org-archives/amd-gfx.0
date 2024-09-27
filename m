Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F29CDD1B8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 14:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906A010ECC4;
	Fri, 27 Sep 2024 14:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DjDylgal";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6647A10ECBC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 14:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoTCg1A+haJRjGKM6NMrNPnHXpW/yb6vMU0WkTBiaE0ALIldWUi06vhbIM7OqqhxGK2o1wAaUVZw0alnA41nw5roDRDgcaNN/IcqqFpyvjzCMzDDydYIXTDDxQnODzh0e4h/Osrl7NOLdR00So2ErkmNnUXYaWRkzhGFo8VyR9PyF+KYCB3PCMdMK8Oasg0wZh9DMgKwogm8jGgRxkY0T/MwQtn1WX/b8JJwjqXEuOwGLwH9VnLp2t0lGX/Oq5LUHDxiXTuu7Qd4+FAEbqBfBGYTXrW/KEy5afhWd/qJ0K0Eu946OMfkg9YGEu0Xyj8tw5tMW8wAl9zVMXXWhwNG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRKrWPT7F63PU3gw2sQ2G9Cew9gLqmHVETppDMS83U4=;
 b=T+SELWR+6nGCiBe8szN0ez1KeKp69l/Q37KyauaetDK31VjGm/sdA5BxFKnE8gZB/RjA/vfnMW0GUVfwFtSy9G+qQyu6ERoj1bPtFgcUl8uaKz4oIS/35IvlQF3HN5JX00cQ/GyeLRK4rty0VJscEcRV6+NChkQWk08QcbopWOFsK4fgIq5n4viS0kBfka0hsygNwGf5paxmFZe5ksoim/AihwK+pnw8J3MDckNXZ0kzfi32yLTK1xoDUm7ZWAkrThmvgMtTHwEuuRioTuqW0HQgr88Dq+2AghY7uYSqshgWTryJLg6MliTW9UL0wJVNzaXzrCG1SfyvwYksoUH/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRKrWPT7F63PU3gw2sQ2G9Cew9gLqmHVETppDMS83U4=;
 b=DjDylgaliCk8SxZ355+8e846cP36AGRIzHCiuVgbZgFheXFrMINGL0ip4MFNZdeqC7AeNUr2Incre3k44yBI8m+lTLn+Axq3bNikOzHdJ70Al5gCIVrcYbQCrttYvTYs2YejK6ODnKOHPD3B4xxcyk4hvdimwqj8h7H6wpATBvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Fri, 27 Sep
 2024 14:45:23 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 14:45:23 +0000
Subject: Re: [PATCH v1 1/5] drm/amdgpu: update the handle ptr in early_init
From: "Khatri, Sunil" <sunil.khatri@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240927095744.2191253-1-sunil.khatri@amd.com>
 <20240927095744.2191253-2-sunil.khatri@amd.com>
 <cdee7382-e4f9-4294-801e-7b994d133eb4@gmail.com>
 <0353246a-d820-bbc6-cc68-fcddc081912d@amd.com>
Message-ID: <52647840-1f2e-5189-b920-5dce3090735f@amd.com>
Date: Fri, 27 Sep 2024 20:15:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <0353246a-d820-bbc6-cc68-fcddc081912d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: f05cfb3c-4880-466e-488c-08dcdf03044a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3hsd3FubE52V0o3cU5nYTU1Y25CRDB4bXlMOU1BYUUzdHVzS0tNY2VyZk1i?=
 =?utf-8?B?Vmh0dVIxbzBSK1dFMWE5REdhRjhHNFo5YnU2L0tjK01iclp4d0tpM2pBRW8v?=
 =?utf-8?B?cWY3c3FFMThDSGJLOFJKUW9DQzFta1pJMVdseS9hZU1uTExTdDh4cENpZ2NK?=
 =?utf-8?B?S25vYVNhZDBMR2xML1M0WHdLWldObWovcWd2L20ySjJ3bkhiR3FNSUdHeFVP?=
 =?utf-8?B?TlEvVlFFczR4ZE92R3krcGdkeE5tTzh2dHNCM1NMYkkvZ3c0YWNKMGZTQlky?=
 =?utf-8?B?UmFQMkhad095Q2E2eGlFdTI3NGdzbjM4bHJ5MGYyZXR3V2lkS0VKY0lib2ts?=
 =?utf-8?B?c3RpeXRiVlBxRkdneTU3dERnTURsUXkrbFJiYUE5bGdaYWJ0V0Y1cml3c2ts?=
 =?utf-8?B?Z3EzdzE3NitMWVo0VGYrdzBmZEJsazlmSTFhRGQwRWZ3d0crZm9Pa3pya0dQ?=
 =?utf-8?B?cDlQa3lRakZRQ0JsQVZ5c0FadVNTTW9TTyttTmlQaUlLaWx3cCsyaTFFVmZ3?=
 =?utf-8?B?dnJqYkZ4aVVZYnhwWUduMXhlL3R0RnVYU0U1STZxUHF5VUFZeWJFYTlBa01x?=
 =?utf-8?B?K3I4MklzYUQwZjhkT1BVWSt5aTlZZHp6R2hLU1JUb2xmd1ErNUduK1BFKzV1?=
 =?utf-8?B?bUthbTdORkxhNE83eGtXd3R1eE9ZVTc3RVNCcGE1M0dlMEc0aVdBTzdMMVcw?=
 =?utf-8?B?QXVOODFkRFdwSk1hUXluOXF0OTh0cnkxeXNDMTJHVFE1R3hvbFMzQjZvbmhS?=
 =?utf-8?B?bXBtT2FMdFlZMnV2ZkJHRXNrOUhpK094MCtsWlcxTklFWVhGUUdUVGxsNlBn?=
 =?utf-8?B?TVBLQW1ydm54WGc4UzRqc2VzMHdWUFpxQlVSY1BUTTNuOGxIRFIxVUxtNldX?=
 =?utf-8?B?Z2NaYUpQZ1FvRVV6bHhibEthYkdOY2dUV2NZS25kY3g0ZDVQUFR6L3Y1WEJ5?=
 =?utf-8?B?dlJwNC94TVZCTVBpdGU2dFBuK2tiYlErL3Z5UkNmRHBTWi9NS1piYWdnb0Q0?=
 =?utf-8?B?SStwMjlaOGRtR0NpeHdYeUcvZFRnVHhkdjZPQWpZaTNHeVNtdGdMOWc5VU45?=
 =?utf-8?B?eFBoc2tJSkVmMmdON0hpNWxHUDRReERhNmVKWGVmRjE0dk90Q3RTT1lYbDh2?=
 =?utf-8?B?endXeDZScTRuTDg2cktZcUcyeE5NbFVqdklRbXV4dWM2djZCeVVVdlA1bGJ0?=
 =?utf-8?B?Rkdsd040TmwyNzBKaWdnNnJ2SHlZY2pYeG9OQXR5aWV0SEc1V3dDSERwbk9O?=
 =?utf-8?B?dndMY09TMjNYMDFsTTV0WEhjQ0Jrd2VWVmhBMjVzcHNrL2VucHovaXdRT3Rk?=
 =?utf-8?B?eDlVT0pjNjFabHVDb09MZHRHb2pRbU9JcnVrN3dLRU5yQXNzRWVvdGpaS1h4?=
 =?utf-8?B?M1ZERW5vaEpkOUFtMFg1eUlDZi9ScDJFRE5LbGZSSDEwbENCcEFCVVowT0tV?=
 =?utf-8?B?MERmc1U2WS8vYUdZalZiT2tpcnFBand5R0VteHRxaWtsdk9GelN2aGd0VmQv?=
 =?utf-8?B?TG5VTUJUbmlTQ1liaWdKZy9sS1owTkMrV1RMeHV2ODdGUTdGdkt5KytoeGZJ?=
 =?utf-8?B?dUZHTUNCRVFmSFBLR0U4bzlwWVBwOUI4YWhYQm11ZkQyMkZDaE1abytFRG13?=
 =?utf-8?B?L3cvUlhpVDVQTWtJbnl5WVJqNW1rMGJ6aEFvNDBaWUtMTG5yeWRJQWEyL2t1?=
 =?utf-8?B?VDNhWDF4dTAvaWc0cG5HOFFMdFNDSHF2OUtURWVyQXRRQzBoQ3RBTGhldjZ5?=
 =?utf-8?B?eS9wVVVERS9ZZ09FSTV1eS9yd3pOMnFrc2hKSkx3ZldDNHYzbWNsbmlaRk5J?=
 =?utf-8?B?NlJCWDZtQlArTjRZQ29KZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZxQVZWRm1oU2MzK3gyMWJNYzRxTkFnT0FneGtnSGtERStDeTU2WFRLcE5Q?=
 =?utf-8?B?V2MxU3RKZ1lxT1hBYkRzbUcyTXphdytNY2pFMUdsTGNubGswMlZkYng4RElq?=
 =?utf-8?B?Y2dvekdaV3hlSEJXV2p6b21YeEJCbjJMZDkzOEJBMENnSUhVenR0VUk0Yk5k?=
 =?utf-8?B?VU1oMDFFYlhaM3E2K1dmQUR4Q0diTVdEYWRNY0JzQUxJM3pReWwzbHVpTUtE?=
 =?utf-8?B?SGNpRHVGUXNXV1Z2Q3dMVUFVUEJhMmhzeDJyeUM1MFFXTXpXQSt4LzFzQ01P?=
 =?utf-8?B?YWlUTE8xVCs0b2wvdFRoaWhnU2FzWDFhZ2NmRlg3YklqZW1xRFFaa2pyVFZt?=
 =?utf-8?B?emN1MmJEZ2laNFNmT2NRNDRQbDBOUXRUMGEydE9zMUhlcjc3QXpreEhBSjkx?=
 =?utf-8?B?V3VkUzMzSnltQ05XTlJRaDR2Qyt3WUFDSFR2cGxqWnJ0dkJYanI4dkQ1N0cz?=
 =?utf-8?B?dlFCbFVIME10V254MFpHZU5YV3k5dnkxMmVqV2FhRWQySW9jdi81VEI2Q0VL?=
 =?utf-8?B?Wml2K25SaW00b3lSSWhUY0RZU21rR2ZkaTQ5bXkxVzVnOWNxM2I5UTdZZVQy?=
 =?utf-8?B?cnYwZVVDQmhrcU11Nmt0SHRNT3FPNWdQeGkrZmhJaDlUNVNjRTZjejFtZjd0?=
 =?utf-8?B?cWRFQ1NMcG9sdVdDQmhYTEhSVUZUeWJyZHlDUklDdGc2VHNGNlZWSVJUUTF1?=
 =?utf-8?B?Zm5ObmRERDhwTmVhMzNNSGJtN0ZKRjVoY0o1TVlSQlpDYWt2UGtxdjdSZkI1?=
 =?utf-8?B?ZUNjWXBXRXd0T0FUZ2tJaVFJWlZSNGVpNmlCRnF5SjYzWDdoU3B1NThKVXo0?=
 =?utf-8?B?OVB4dFFXdWh6TUNhK2E0U2JrVmUrVEVEV0NWR2Q3RFhvcDloMjl2SFZmR1g2?=
 =?utf-8?B?YXNuTlFXWE4weWpYWS95bzJhSXhYS25oRGZPL3pQc0RWVlcwVkhuYVY2YnJ3?=
 =?utf-8?B?TDZzYmlHVGdubytSQU04NWJJM0pxNVVEVFU5Z0FHdjAwaG1qMXVRdWtmTHJD?=
 =?utf-8?B?ZWV4RXRmM21vT0U4N1BSYWpiSEk1UUF3U01tK0JXblNyM2FpVE94SFlWLzQr?=
 =?utf-8?B?RTFCeWI0d0JuUjhZT0ovR2ZtM2JSL3NUdmZoVzN0WmlVQVhKQjZkV2F2M01z?=
 =?utf-8?B?amFkUldTZ2Q0WS9oTFZ5L2hoQTVOMGVqMnBhbDVuNzY5QzBqcVE5U0NHdjd2?=
 =?utf-8?B?cTJwTXhmQUZ1ZTRzdmYwUFBGYi9BWWZHRG9YUy9YQVVqbjEwS3B1ZUkrSUVY?=
 =?utf-8?B?M3FjNUNmVzVTNENHQ0dmNVExSWtWcWVJNC93aGNJbzlrbm51aG1ab2FUNzJl?=
 =?utf-8?B?c1JVd3FuM3RXNnJjYnBRTWc3NFVnZG5WTEtLQ2NNUlkxSDJ5NndGSUJZeGts?=
 =?utf-8?B?WnYwQzVod25pOTdISzkwbjgybStqRFUzZ0xmOGI4NGYyT3hkR3Q4ZGY5aFAw?=
 =?utf-8?B?Tk1nNTRIRWo2RTNXY3J3ZjJRL1JUVlB6cGw1d3BDSEdyMCtGbGVsM2VJVmVW?=
 =?utf-8?B?SkVNR3piZ29aR0JqbGJMbC9UcGRsWE9rWUtiQWZDVnZkcGZ6OHJVL0p2Qk1Z?=
 =?utf-8?B?YWtyaVJsWVdyd2xZZVhtbnVseVNrZDVsNitLeHlEWklSd2FBS1NHMU5DRXZF?=
 =?utf-8?B?V0pPbmc0Um9kdkxOVWhJbkplWHE5WWM1eFdWZk15N2I5enE3a0hnY0hJbEgx?=
 =?utf-8?B?MTZ1Rk1pbm83M3VPUTkwVWZ4MVg4dzIyb3FyRWlSWE92OGVQdlQ1T1J1bElw?=
 =?utf-8?B?eGQyWTI0ZWZUWEJSU2Y1Ky9Uc0h3UXA1MEF5c1VUd210Ty9XL0tVbnRvQWpm?=
 =?utf-8?B?dnB3ZkFmdVF6TlA1T3VMWTIyampGY2JGeEpUQVBxL3Z5VG42UktkZVJTbEVN?=
 =?utf-8?B?Wk5rK3NyT294Wm5MMWZTaS9MdkNYd0xPcHdxQWRydTVvMnI4Mkc2eVhsMkVB?=
 =?utf-8?B?UFRVSmFiWU9UMmx1YmROWlhYTXRpb3pydmJoM1UzZW56QlpSaXJuUmp4K2tl?=
 =?utf-8?B?QVk1L2tBUURqTmJ2UVFzbnYzaFdvTE5pS0xzSlk3TnB0bXJIZXdHTmR3M0M0?=
 =?utf-8?B?emVpVWthNld2MjNyaEsxbDlnQ3dxWjlwZ29XbzR3dmRqRXlyMUpCdVZFRWNm?=
 =?utf-8?Q?ubBoWJg2Pw0TaIOEcuQ4xtVYs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05cfb3c-4880-466e-488c-08dcdf03044a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:45:23.5252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiCwFQzYm5chN5dqDmsDTjTgMbl0PU4+RlSdcNxGSxbq1jVR0/VaTeE78g3riwrL/ndh4JGqCjAPGS0xipgnFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969
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


On 9/27/2024 7:26 PM, Khatri, Sunil wrote:
>
> On 9/27/2024 5:51 PM, Christian König wrote:
>> Am 27.09.24 um 11:57 schrieb Sunil Khatri:
>>> update the handle ptr to amdgpu_ip_block ptr
>>> for all functions pointers on early_init.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 6 ++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           | 5 +++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c      | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/cik.c                  | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c               | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c                | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c           | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h            | 2 +-
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/nv.c                   | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/si.c                   | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/si_dma.c               | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/si_ih.c                | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/soc15.c                | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/soc21.c                | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/soc24.c                | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             | 6 +++---
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c            | 4 ++--
>>>   drivers/gpu/drm/amd/amdgpu/vi.c                   | 4 ++--
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>>>   drivers/gpu/drm/amd/include/amd_shared.h          | 2 +-
>>>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        | 4 ++--
>>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        | 4 ++--
>>>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 5 ++---
>>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         | 4 ++--
>>>   86 files changed, 174 insertions(+), 172 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>>> index bf6c4a0d0525..c4ca59875679 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
>>> @@ -585,7 +585,7 @@ static int acp_resume(void *handle)
>>>       return 0;
>>>   }
>>>   -static int acp_early_init(void *handle)
>>> +static int acp_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>>       return 0;
>>>   }
>>
>> At least early_init and late_init are optional callback and I think 
>> the other two as well.
>>
>> So while at it can please remove dummy functions like the one above?
> Remove below functions ??
> static int acp_resume
>
> static int acp_early_init
Will clean up the functions which do nothing but return 0 or dummy after 
these changes. Will push new changes for the clean up.
>
> Regards
> Sunil khatri
>
>>
>>
>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index ce030d201309..48a7549fb21d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2611,13 +2611,15 @@ static int 
>>> amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>         total = true;
>>>       for (i = 0; i < adev->num_ip_blocks; i++) {
>>> +        struct amdgpu_ip_block *ip_block;
>>
>> Please add an empty line between declaration and code.
>>
>>>           if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
>>>               DRM_WARN("disabled ip block: %d <%s>\n",
>>>                     i, adev->ip_blocks[i].version->funcs->name);
>>>               adev->ip_blocks[i].status.valid = false;
>>>           } else {
>>> -            if (adev->ip_blocks[i].version->funcs->early_init) {
>>> -                r = 
>>> adev->ip_blocks[i].version->funcs->early_init((void *)adev);
>>> +            ip_block = &(adev->ip_blocks[i]);
>>> +            if (ip_block->version->funcs->early_init) {
>>
>> This could also be an "} else if {".
> Sure Christian
>>
>> Apart from that looks rather good to me.
>>
>> Regards,
>> Christian.
>>
>>> +                r = ip_block->version->funcs->early_init(ip_block);
>>>                   if (r == -ENOENT) {
>>>                       adev->ip_blocks[i].status.valid = false;
>>>                   } else if (r) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>> index 4766e99dd98f..7c1f17dc6b4b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>> @@ -122,9 +122,10 @@ static int isp_load_fw_by_psp(struct 
>>> amdgpu_device *adev)
>>>       return r;
>>>   }
>>>   -static int isp_early_init(void *handle)
>>> +static int isp_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       struct amdgpu_isp *isp = &adev->isp;
>>>         switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> index 944dad9ad29f..8f07dad9e449 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> @@ -159,9 +159,9 @@ static int psp_init_sriov_microcode(struct 
>>> psp_context *psp)
>>>       return ret;
>>>   }
>>>   -static int psp_early_init(void *handle)
>>> +static int psp_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       struct psp_context *psp = &adev->psp;
>>>         psp->autoload_supported = true;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
>>> index 6162582d0aa2..d7e377341367 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
>>> @@ -765,9 +765,9 @@ static int umsch_mm_init(struct amdgpu_device 
>>> *adev)
>>>   }
>>>     -static int umsch_mm_early_init(void *handle)
>>> +static int umsch_mm_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
>>>       case IP_VERSION(4, 0, 5):
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>>> index 5acd20ff5979..c9c4e8c7dc9f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>>> @@ -295,9 +295,9 @@ int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe)
>>>       return 0;
>>>   }
>>>   -static int vpe_early_init(void *handle)
>>> +static int vpe_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       struct amdgpu_vpe *vpe = &adev->vpe;
>>>         switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c 
>>> b/drivers/gpu/drm/amd/amdgpu/cik.c
>>> index cf1d5d462b67..0a0114de11b4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>>> @@ -1985,9 +1985,9 @@ static const struct amdgpu_asic_funcs 
>>> cik_asic_funcs =
>>>       .query_video_codecs = &cik_query_video_codecs,
>>>   };
>>>   -static int cik_common_early_init(void *handle)
>>> +static int cik_common_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->smc_rreg = &cik_smc_rreg;
>>>       adev->smc_wreg = &cik_smc_wreg;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> index 576baa9dbb0e..5ccd7e2ebf67 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>> @@ -283,9 +283,9 @@ static void cik_ih_set_rptr(struct amdgpu_device 
>>> *adev,
>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
>>>   }
>>>   -static int cik_ih_early_init(void *handle)
>>> +static int cik_ih_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int ret;
>>>         ret = amdgpu_irq_add_domain(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c 
>>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> index 952737de9411..3565dbcf7e38 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>> @@ -918,9 +918,9 @@ static void cik_enable_sdma_mgls(struct 
>>> amdgpu_device *adev,
>>>       }
>>>   }
>>>   -static int cik_sdma_early_init(void *handle)
>>> +static int cik_sdma_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         adev->sdma.num_instances = SDMA_MAX_INSTANCE;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> index 072643787384..bbc50a8e3bc4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>> @@ -274,9 +274,9 @@ static void cz_ih_set_rptr(struct amdgpu_device 
>>> *adev,
>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
>>>   }
>>>   -static int cz_ih_early_init(void *handle)
>>> +static int cz_ih_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int ret;
>>>         ret = amdgpu_irq_add_domain(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>>> index 70c1399f738d..a7a48ad98698 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>>> @@ -2738,9 +2738,9 @@ static int dce_v10_0_crtc_init(struct 
>>> amdgpu_device *adev, int index)
>>>       return 0;
>>>   }
>>>   -static int dce_v10_0_early_init(void *handle)
>>> +static int dce_v10_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->audio_endpt_rreg = &dce_v10_0_audio_endpt_rreg;
>>>       adev->audio_endpt_wreg = &dce_v10_0_audio_endpt_wreg;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>>> index f154c24499c8..0b8017a9b925 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>>> @@ -2851,9 +2851,9 @@ static int dce_v11_0_crtc_init(struct 
>>> amdgpu_device *adev, int index)
>>>       return 0;
>>>   }
>>>   -static int dce_v11_0_early_init(void *handle)
>>> +static int dce_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->audio_endpt_rreg = &dce_v11_0_audio_endpt_rreg;
>>>       adev->audio_endpt_wreg = &dce_v11_0_audio_endpt_wreg;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>> index a7fcb135827f..2c074d35bb13 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>> @@ -2633,9 +2633,9 @@ static int dce_v6_0_crtc_init(struct 
>>> amdgpu_device *adev, int index)
>>>       return 0;
>>>   }
>>>   -static int dce_v6_0_early_init(void *handle)
>>> +static int dce_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->audio_endpt_rreg = &dce_v6_0_audio_endpt_rreg;
>>>       adev->audio_endpt_wreg = &dce_v6_0_audio_endpt_wreg;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>>> index 77ac3f114d24..71197d58c92d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>>> @@ -2644,9 +2644,9 @@ static int dce_v8_0_crtc_init(struct 
>>> amdgpu_device *adev, int index)
>>>       return 0;
>>>   }
>>>   -static int dce_v8_0_early_init(void *handle)
>>> +static int dce_v8_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->audio_endpt_rreg = &dce_v8_0_audio_endpt_rreg;
>>>       adev->audio_endpt_wreg = &dce_v8_0_audio_endpt_wreg;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 4b889a2acb10..3d0969a7ba69 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -7678,9 +7678,9 @@ static void 
>>> gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
>>>                       (1 << (oa_size + oa_base)) - (1 << oa_base));
>>>   }
>>>   -static int gfx_v10_0_early_init(void *handle)
>>> +static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->gfx.funcs = &gfx_v10_0_gfx_funcs;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index 3f29b36323a1..690cd7b173f7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -4997,9 +4997,9 @@ static void 
>>> gfx_v11_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
>>>                       (1 << (oa_size + oa_base)) - (1 << oa_base));
>>>   }
>>>   -static int gfx_v11_0_early_init(void *handle)
>>> +static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index 3044436436c8..6423b20e9156 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -3695,9 +3695,9 @@ static uint64_t 
>>> gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>>>       return clock;
>>>   }
>>>   -static int gfx_v12_0_early_init(void *handle)
>>> +static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> index 564f0b9336b6..cc9f9b10b435 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> @@ -3023,9 +3023,9 @@ static const struct amdgpu_rlc_funcs 
>>> gfx_v6_0_rlc_funcs = {
>>>       .start = gfx_v6_0_rlc_start
>>>   };
>>>   -static int gfx_v6_0_early_init(void *handle)
>>> +static int gfx_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->gfx.xcc_mask = 1;
>>>       adev->gfx.num_gfx_rings = GFX6_NUM_GFX_RINGS;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> index f146806c4633..3babf5b5a9dd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -4134,9 +4134,9 @@ static const struct amdgpu_rlc_funcs 
>>> gfx_v7_0_rlc_funcs = {
>>>       .update_spm_vmid = gfx_v7_0_update_spm_vmid
>>>   };
>>>   -static int gfx_v7_0_early_init(void *handle)
>>> +static int gfx_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->gfx.xcc_mask = 1;
>>>       adev->gfx.num_gfx_rings = GFX7_NUM_GFX_RINGS;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> index bc8295812cc8..e80e071f193c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> @@ -5254,9 +5254,9 @@ static const struct amdgpu_gfx_funcs 
>>> gfx_v8_0_gfx_funcs = {
>>>       .select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
>>>   };
>>>   -static int gfx_v8_0_early_init(void *handle)
>>> +static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->gfx.xcc_mask = 1;
>>>       adev->gfx.num_gfx_rings = GFX8_NUM_GFX_RINGS;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index f9f2410ee7d1..8c98511144b2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -4766,9 +4766,9 @@ static int 
>>> gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>>>       return r;
>>>   }
>>>   -static int gfx_v9_0_early_init(void *handle)
>>> +static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->gfx.funcs = &gfx_v9_0_gfx_funcs;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index eabe0cf6191c..0dee2102d759 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -2511,9 +2511,9 @@ static void 
>>> gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
>>>                      (1 << (oa_size + oa_base)) - (1 << oa_base));
>>>   }
>>>   -static int gfx_v9_4_3_early_init(void *handle)
>>> +static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
>>>                         AMDGPU_MAX_COMPUTE_RINGS);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index 9784a2892185..f54f9bb89bca 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -630,9 +630,9 @@ static void gmc_v10_0_set_gfxhub_funcs(struct 
>>> amdgpu_device *adev)
>>>   }
>>>     -static int gmc_v10_0_early_init(void *handle)
>>> +static int gmc_v10_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         gmc_v10_0_set_mmhub_funcs(adev);
>>>       gmc_v10_0_set_gfxhub_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index 2797fd84432b..32dec30722ac 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -601,9 +601,9 @@ static void gmc_v11_0_set_gfxhub_funcs(struct 
>>> amdgpu_device *adev)
>>>       }
>>>   }
>>>   -static int gmc_v11_0_early_init(void *handle)
>>> +static int gmc_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         gmc_v11_0_set_gfxhub_funcs(adev);
>>>       gmc_v11_0_set_mmhub_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> index edcb5351f8cc..e0d3d865a59a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -604,9 +604,9 @@ static void gmc_v12_0_set_gfxhub_funcs(struct 
>>> amdgpu_device *adev)
>>>       }
>>>   }
>>>   -static int gmc_v12_0_early_init(void *handle)
>>> +static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         gmc_v12_0_set_gfxhub_funcs(adev);
>>>       gmc_v12_0_set_mmhub_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> index d36725666b54..3a524319f31e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> @@ -762,9 +762,9 @@ static int gmc_v6_0_convert_vram_type(int 
>>> mc_seq_vram_type)
>>>       }
>>>   }
>>>   -static int gmc_v6_0_early_init(void *handle)
>>> +static int gmc_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         gmc_v6_0_set_gmc_funcs(adev);
>>>       gmc_v6_0_set_irq_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index 994432fb57ea..489b3c2ab660 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -921,9 +921,9 @@ static int gmc_v7_0_convert_vram_type(int 
>>> mc_seq_vram_type)
>>>       }
>>>   }
>>>   -static int gmc_v7_0_early_init(void *handle)
>>> +static int gmc_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         gmc_v7_0_set_gmc_funcs(adev);
>>>       gmc_v7_0_set_irq_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 86488c052f82..d564b1d8c828 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1027,9 +1027,9 @@ static int gmc_v8_0_convert_vram_type(int 
>>> mc_seq_vram_type)
>>>       }
>>>   }
>>>   -static int gmc_v8_0_early_init(void *handle)
>>> +static int gmc_v8_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         gmc_v8_0_set_gmc_funcs(adev);
>>>       gmc_v8_0_set_irq_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index cafcb24449df..f274acdc49bc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1545,9 +1545,9 @@ static void gmc_v9_0_set_xgmi_ras_funcs(struct 
>>> amdgpu_device *adev)
>>>           adev->gmc.xgmi.ras = &xgmi_ras;
>>>   }
>>>   -static int gmc_v9_0_early_init(void *handle)
>>> +static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         /*
>>>        * 9.4.0, 9.4.1 and 9.4.3 don't have XGMI defined
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> index 07984f7c3ae7..87b29600cf1f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>> @@ -273,9 +273,9 @@ static void iceland_ih_set_rptr(struct 
>>> amdgpu_device *adev,
>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
>>>   }
>>>   -static int iceland_ih_early_init(void *handle)
>>> +static int iceland_ih_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int ret;
>>>         ret = amdgpu_irq_add_domain(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> index 18a761d6ef33..fa6c7e5fbbe3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>>> @@ -559,9 +559,9 @@ static void ih_v6_0_set_self_irq_funcs(struct 
>>> amdgpu_device *adev)
>>>       adev->irq.self_irq.funcs = &ih_v6_0_self_irq_funcs;
>>>   }
>>>   -static int ih_v6_0_early_init(void *handle)
>>> +static int ih_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         ih_v6_0_set_interrupt_funcs(adev);
>>>       ih_v6_0_set_self_irq_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c 
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> index 2e0469feca1e..ebe23630e8f6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
>>> @@ -532,9 +532,9 @@ static void ih_v6_1_set_self_irq_funcs(struct 
>>> amdgpu_device *adev)
>>>       adev->irq.self_irq.funcs = &ih_v6_1_self_irq_funcs;
>>>   }
>>>   -static int ih_v6_1_early_init(void *handle)
>>> +static int ih_v6_1_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int ret;
>>>         ret = amdgpu_irq_add_domain(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> index 6852081fcff2..1619f0ba4d1b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
>>> @@ -528,9 +528,9 @@ static void ih_v7_0_set_self_irq_funcs(struct 
>>> amdgpu_device *adev)
>>>       adev->irq.self_irq.funcs = &ih_v7_0_self_irq_funcs;
>>>   }
>>>   -static int ih_v7_0_early_init(void *handle)
>>> +static int ih_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         ih_v7_0_set_interrupt_funcs(adev);
>>>       ih_v7_0_set_self_irq_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
>>> index 6e0e88076224..8effd6dc65d4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
>>> @@ -462,9 +462,9 @@ static int jpeg_v1_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -int jpeg_v1_0_early_init(void *handle)
>>> +int jpeg_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->jpeg.num_jpeg_inst = 1;
>>>       adev->jpeg.num_jpeg_rings = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
>>> index 9654d22e0376..791de235cd8b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
>>> @@ -24,7 +24,7 @@
>>>   #ifndef __JPEG_V1_0_H__
>>>   #define __JPEG_V1_0_H__
>>>   -int jpeg_v1_0_early_init(void *handle);
>>> +int jpeg_v1_0_early_init(struct amdgpu_ip_block *ip_block);
>>>   int jpeg_v1_0_sw_init(void *handle);
>>>   void jpeg_v1_0_sw_fini(void *handle);
>>>   void jpeg_v1_0_start(struct amdgpu_device *adev, int mode);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> index 41c0f8750dc1..341c551dad8b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>> @@ -45,9 +45,9 @@ static int jpeg_v2_0_set_powergating_state(void 
>>> *handle,
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -static int jpeg_v2_0_early_init(void *handle)
>>> +static int jpeg_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->jpeg.num_jpeg_inst = 1;
>>>       adev->jpeg.num_jpeg_rings = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> index eedb9a829d95..ec0fa685e127 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>> @@ -54,9 +54,9 @@ static int amdgpu_ih_clientid_jpeg[] = {
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -static int jpeg_v2_5_early_init(void *handle)
>>> +static int jpeg_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       u32 harvest;
>>>       int i;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> index b1e7fd25afbc..dd00daa1d7ed 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>> @@ -46,9 +46,9 @@ static int jpeg_v3_0_set_powergating_state(void 
>>> *handle,
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -static int jpeg_v3_0_early_init(void *handle)
>>> +static int jpeg_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         u32 harvest;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> index 6c5c1a68a9b7..b147e0eba31d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>> @@ -52,9 +52,9 @@ static void jpeg_v4_0_dec_ring_set_wptr(struct 
>>> amdgpu_ring *ring);
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -static int jpeg_v4_0_early_init(void *handle)
>>> +static int jpeg_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>           adev->jpeg.num_jpeg_inst = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> index baf86c0e5274..903c47e9e8eb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> @@ -72,9 +72,9 @@ static inline bool 
>>> jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -static int jpeg_v4_0_3_early_init(void *handle)
>>> +static int jpeg_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->jpeg.num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>>> index 44eeed445ea9..48ab3e0a62d2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
>>> @@ -65,9 +65,9 @@ static int amdgpu_ih_clientid_jpeg[] = {
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -static int jpeg_v4_0_5_early_init(void *handle)
>>> +static int jpeg_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>>>       case IP_VERSION(4, 0, 5):
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>>> index d662aa841f97..61288104060d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
>>> @@ -46,9 +46,9 @@ static int jpeg_v5_0_0_set_powergating_state(void 
>>> *handle,
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -static int jpeg_v5_0_0_early_init(void *handle)
>>> +static int jpeg_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->jpeg.num_jpeg_inst = 1;
>>>       adev->jpeg.num_jpeg_rings = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> index e2b3f859a1c0..d476cf771bbe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> @@ -1653,9 +1653,9 @@ static int mes_v11_0_resume(void *handle)
>>>       return amdgpu_mes_resume(adev);
>>>   }
>>>   -static int mes_v11_0_early_init(void *handle)
>>> +static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int pipe, r;
>>>         for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> index 8d27421689c9..a490d0e2c2cb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> @@ -1617,9 +1617,9 @@ static int mes_v12_0_resume(void *handle)
>>>       return amdgpu_mes_resume(adev);
>>>   }
>>>   -static int mes_v12_0_early_init(void *handle)
>>> +static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int pipe, r;
>>>         for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> index b281462093f1..17aab897f86b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>> @@ -542,9 +542,9 @@ static void navi10_ih_set_self_irq_funcs(struct 
>>> amdgpu_device *adev)
>>>       adev->irq.self_irq.funcs = &navi10_ih_self_irq_funcs;
>>>   }
>>>   -static int navi10_ih_early_init(void *handle)
>>> +static int navi10_ih_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         navi10_ih_set_interrupt_funcs(adev);
>>>       navi10_ih_set_self_irq_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> index 4938e6b340e9..63a3c725ceb9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> @@ -634,9 +634,9 @@ static const struct amdgpu_asic_funcs 
>>> nv_asic_funcs = {
>>>       .query_video_codecs = &nv_query_video_codecs,
>>>   };
>>>   -static int nv_common_early_init(void *handle)
>>> +static int nv_common_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->nbio.funcs->set_reg_remap(adev);
>>>       adev->smc_rreg = NULL;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> index 725392522267..5b8198558869 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>> @@ -807,9 +807,9 @@ static void sdma_v2_4_ring_emit_wreg(struct 
>>> amdgpu_ring *ring,
>>>       amdgpu_ring_write(ring, val);
>>>   }
>>>   -static int sdma_v2_4_early_init(void *handle)
>>> +static int sdma_v2_4_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         adev->sdma.num_instances = SDMA_MAX_INSTANCE;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> index e65194fe94af..37275b38bca8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>> @@ -1080,9 +1080,9 @@ static void sdma_v3_0_ring_emit_wreg(struct 
>>> amdgpu_ring *ring,
>>>       amdgpu_ring_write(ring, val);
>>>   }
>>>   -static int sdma_v3_0_early_init(void *handle)
>>> +static int sdma_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         switch (adev->asic_type) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index f17ce2d53b92..cb5f84104717 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -1751,9 +1751,9 @@ static bool 
>>> sdma_v4_0_fw_support_paging_queue(struct amdgpu_device *adev)
>>>       }
>>>   }
>>>   -static int sdma_v4_0_early_init(void *handle)
>>> +static int sdma_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         r = sdma_v4_0_init_microcode(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index d577b973d0a4..c7c4456586cc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1290,9 +1290,9 @@ static bool 
>>> sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)
>>>       }
>>>   }
>>>   -static int sdma_v4_4_2_early_init(void *handle)
>>> +static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         r = sdma_v4_4_2_init_microcode(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> index b44d7d17d137..12bd42629e74 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>> @@ -1366,9 +1366,9 @@ static void 
>>> sdma_v5_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>>>       amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
>>>   }
>>>   -static int sdma_v5_0_early_init(void *handle)
>>> +static int sdma_v5_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         r = sdma_v5_0_init_microcode(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> index 8761b54050ca..e3ee1e2d8d55 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -1216,9 +1216,9 @@ static void 
>>> sdma_v5_2_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>>>       amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
>>>   }
>>>   -static int sdma_v5_2_early_init(void *handle)
>>> +static int sdma_v5_2_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         r = amdgpu_sdma_init_microcode(adev, 0, true);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> index 5eafc81e82f9..5b549e00143e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> @@ -1294,9 +1294,9 @@ static void sdma_v6_0_set_ras_funcs(struct 
>>> amdgpu_device *adev)
>>>       }
>>>   }
>>>   -static int sdma_v6_0_early_init(void *handle)
>>> +static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         r = amdgpu_sdma_init_microcode(adev, 0, true);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> index 8509769db9c0..90baf9a20b22 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>> @@ -1253,9 +1253,9 @@ static void 
>>> sdma_v7_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>>>       amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
>>>   }
>>>   -static int sdma_v7_0_early_init(void *handle)
>>> +static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int r;
>>>         r = amdgpu_sdma_init_microcode(adev, 0, true);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c 
>>> b/drivers/gpu/drm/amd/amdgpu/si.c
>>> index 85235470e872..93c68abf447a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
>>> @@ -2022,9 +2022,9 @@ static uint32_t si_get_rev_id(struct 
>>> amdgpu_device *adev)
>>>           >> CC_DRM_ID_STRAPS__ATI_REV_ID__SHIFT;
>>>   }
>>>   -static int si_common_early_init(void *handle)
>>> +static int si_common_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->smc_rreg = &si_smc_rreg;
>>>       adev->smc_wreg = &si_smc_wreg;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c 
>>> b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> index 11db5b755832..791d492e991d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>>> @@ -457,9 +457,9 @@ static void si_dma_ring_emit_wreg(struct 
>>> amdgpu_ring *ring,
>>>       amdgpu_ring_write(ring, val);
>>>   }
>>>   -static int si_dma_early_init(void *handle)
>>> +static int si_dma_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->sdma.num_instances = 2;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> index 5237395e4fab..bd2ae8255498 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>> @@ -156,9 +156,9 @@ static void si_ih_set_rptr(struct amdgpu_device 
>>> *adev,
>>>       WREG32(IH_RB_RPTR, ih->rptr);
>>>   }
>>>   -static int si_ih_early_init(void *handle)
>>> +static int si_ih_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         si_ih_set_interrupt_funcs(adev);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> index 619933f252aa..e1161027ec3b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> @@ -933,9 +933,9 @@ static const struct amdgpu_asic_funcs 
>>> aqua_vanjaram_asic_funcs =
>>>       .get_reg_state = &aqua_vanjaram_get_reg_state,
>>>   };
>>>   -static int soc15_common_early_init(void *handle)
>>> +static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->nbio.funcs->set_reg_remap(adev);
>>>       adev->smc_rreg = NULL;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c 
>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> index d30ad7d56def..c9e88cd4349a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> @@ -556,9 +556,9 @@ static const struct amdgpu_asic_funcs 
>>> soc21_asic_funcs = {
>>>       .update_umd_stable_pstate = &soc21_update_umd_stable_pstate,
>>>   };
>>>   -static int soc21_common_early_init(void *handle)
>>> +static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->nbio.funcs->set_reg_remap(adev);
>>>       adev->smc_rreg = NULL;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c 
>>> b/drivers/gpu/drm/amd/amdgpu/soc24.c
>>> index fd4c3d4f8387..3dcb3d953509 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
>>> @@ -363,9 +363,9 @@ static const struct amdgpu_asic_funcs 
>>> soc24_asic_funcs = {
>>>       .update_umd_stable_pstate = &soc24_update_umd_stable_pstate,
>>>   };
>>>   -static int soc24_common_early_init(void *handle)
>>> +static int soc24_common_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->nbio.funcs->set_reg_remap(adev);
>>>       adev->smc_rreg = NULL;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> index 24d49d813607..ae27dac94117 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>> @@ -283,9 +283,9 @@ static void tonga_ih_set_rptr(struct 
>>> amdgpu_device *adev,
>>>       }
>>>   }
>>>   -static int tonga_ih_early_init(void *handle)
>>> +static int tonga_ih_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int ret;
>>>         ret = amdgpu_irq_add_domain(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>> index 805d6662c88b..d5e2b9639238 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>> @@ -531,9 +531,9 @@ static void uvd_v3_1_set_irq_funcs(struct 
>>> amdgpu_device *adev)
>>>   }
>>>     -static int uvd_v3_1_early_init(void *handle)
>>> +static int uvd_v3_1_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       adev->uvd.num_uvd_inst = 1;
>>>         uvd_v3_1_set_ring_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> index 3f19c606f4de..5c46174dabbf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> @@ -90,9 +90,9 @@ static void uvd_v4_2_ring_set_wptr(struct 
>>> amdgpu_ring *ring)
>>>       WREG32(mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
>>>   }
>>>   -static int uvd_v4_2_early_init(void *handle)
>>> +static int uvd_v4_2_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       adev->uvd.num_uvd_inst = 1;
>>>         uvd_v4_2_set_ring_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>> index efd903c21d48..fd4acb1300f9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>> @@ -88,9 +88,9 @@ static void uvd_v5_0_ring_set_wptr(struct 
>>> amdgpu_ring *ring)
>>>       WREG32(mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
>>>   }
>>>   -static int uvd_v5_0_early_init(void *handle)
>>> +static int uvd_v5_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       adev->uvd.num_uvd_inst = 1;
>>>         uvd_v5_0_set_ring_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> index 495de5068455..e05e81d6fbd4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>>> @@ -354,9 +354,9 @@ static int uvd_v6_0_enc_ring_test_ib(struct 
>>> amdgpu_ring *ring, long timeout)
>>>       return r;
>>>   }
>>>   -static int uvd_v6_0_early_init(void *handle)
>>> +static int uvd_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       adev->uvd.num_uvd_inst = 1;
>>>         if (!(adev->flags & AMD_IS_APU) &&
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> index 6068b784dc69..15b8f6211bb5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> @@ -361,9 +361,9 @@ static int uvd_v7_0_enc_ring_test_ib(struct 
>>> amdgpu_ring *ring, long timeout)
>>>       return r;
>>>   }
>>>   -static int uvd_v7_0_early_init(void *handle)
>>> +static int uvd_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         if (adev->asic_type == CHIP_VEGA20) {
>>>           u32 harvest;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> index 66fada199bda..97ce06228a91 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> @@ -398,9 +398,9 @@ static void vce_v2_0_enable_mgcg(struct 
>>> amdgpu_device *adev, bool enable,
>>>       }
>>>   }
>>>   -static int vce_v2_0_early_init(void *handle)
>>> +static int vce_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->vce.num_rings = 2;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> index 4bfba2931b08..31ca855a950a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> @@ -396,9 +396,9 @@ static unsigned 
>>> vce_v3_0_get_harvest_config(struct amdgpu_device *adev)
>>>       }
>>>   }
>>>   -static int vce_v3_0_early_init(void *handle)
>>> +static int vce_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->vce.harvest_config = vce_v3_0_get_harvest_config(adev);
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> index 0748bf44c880..14ead62ec57d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> @@ -407,9 +407,9 @@ static int vce_v4_0_stop(struct amdgpu_device 
>>> *adev)
>>>       return 0;
>>>   }
>>>   -static int vce_v4_0_early_init(void *handle)
>>> +static int vce_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         if (amdgpu_sriov_vf(adev)) /* currently only VCN0 support 
>>> SRIOV */
>>>           adev->vce.num_rings = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> index 21e0962e53c2..451622184838 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> @@ -100,9 +100,9 @@ static void vcn_v1_0_ring_begin_use(struct 
>>> amdgpu_ring *ring);
>>>    * Set ring and irq function pointers
>>>    * Load microcode from filesystem
>>>    */
>>> -static int vcn_v1_0_early_init(void *handle)
>>> +static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->vcn.num_enc_rings = 2;
>>>   @@ -110,7 +110,7 @@ static int vcn_v1_0_early_init(void *handle)
>>>       vcn_v1_0_set_enc_ring_funcs(adev);
>>>       vcn_v1_0_set_irq_funcs(adev);
>>>   -    jpeg_v1_0_early_init(handle);
>>> +    jpeg_v1_0_early_init(ip_block);
>>>         return amdgpu_vcn_early_init(adev);
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> index b6d41d531ef9..18383e7a13ce 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> @@ -105,9 +105,9 @@ static int vcn_v2_0_start_sriov(struct 
>>> amdgpu_device *adev);
>>>    * Set ring and irq function pointers
>>>    * Load microcode from filesystem
>>>    */
>>> -static int vcn_v2_0_early_init(void *handle)
>>> +static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         if (amdgpu_sriov_vf(adev))
>>>           adev->vcn.num_enc_rings = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> index 6be770a060ef..0ba7bc052447 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> @@ -115,9 +115,9 @@ static int amdgpu_ih_clientid_vcns[] = {
>>>    * Set ring and irq function pointers
>>>    * Load microcode from filesystem
>>>    */
>>> -static int vcn_v2_5_early_init(void *handle)
>>> +static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         if (amdgpu_sriov_vf(adev)) {
>>>           adev->vcn.num_vcn_inst = 2;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> index 0c2d698ca046..7204e3630052 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> @@ -121,9 +121,9 @@ static void vcn_v3_0_enc_ring_set_wptr(struct 
>>> amdgpu_ring *ring);
>>>    * Set ring and irq function pointers
>>>    * Load microcode from filesystem
>>>    */
>>> -static int vcn_v3_0_early_init(void *handle)
>>> +static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         if (amdgpu_sriov_vf(adev)) {
>>>           adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> index d3aa1a5b2529..cfebd1255b75 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>> @@ -111,9 +111,9 @@ static void vcn_v4_0_set_ras_funcs(struct 
>>> amdgpu_device *adev);
>>>    * Set ring and irq function pointers
>>>    * Load microcode from filesystem
>>>    */
>>> -static int vcn_v4_0_early_init(void *handle)
>>> +static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       int i;
>>>         if (amdgpu_sriov_vf(adev)) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> index ca5ac917f07d..d64f4735ebf3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> @@ -102,9 +102,9 @@ static void vcn_v4_0_3_enable_ras(struct 
>>> amdgpu_device *adev,
>>>    *
>>>    * Set ring and irq function pointers
>>>    */
>>> -static int vcn_v4_0_3_early_init(void *handle)
>>> +static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         /* re-use enc ring as unified ring */
>>>       adev->vcn.num_enc_rings = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> index 0d8aa5a0904b..d13f07faae8a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>> @@ -109,9 +109,9 @@ static void 
>>> vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
>>>    * Set ring and irq function pointers
>>>    * Load microcode from filesystem
>>>    */
>>> -static int vcn_v4_0_5_early_init(void *handle)
>>> +static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         /* re-use enc ring as unified ring */
>>>       adev->vcn.num_enc_rings = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> index 8a2e217ae5c9..d9c92df3843f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>> @@ -92,9 +92,9 @@ static void 
>>> vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>>>    * Set ring and irq function pointers
>>>    * Load microcode from filesystem
>>>    */
>>> -static int vcn_v5_0_0_early_init(void *handle)
>>> +static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         /* re-use enc ring as unified ring */
>>>       adev->vcn.num_enc_rings = 1;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> index bf68e18e3824..5b0c81d510e7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>> @@ -472,9 +472,9 @@ static void vega10_ih_set_self_irq_funcs(struct 
>>> amdgpu_device *adev)
>>>       adev->irq.self_irq.funcs = &vega10_ih_self_irq_funcs;
>>>   }
>>>   -static int vega10_ih_early_init(void *handle)
>>> +static int vega10_ih_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         vega10_ih_set_interrupt_funcs(adev);
>>>       vega10_ih_set_self_irq_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> index ac439f0565e3..dec7279c8106 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>>> @@ -526,9 +526,9 @@ static void vega20_ih_set_self_irq_funcs(struct 
>>> amdgpu_device *adev)
>>>       adev->irq.self_irq.funcs = &vega20_ih_self_irq_funcs;
>>>   }
>>>   -static int vega20_ih_early_init(void *handle)
>>> +static int vega20_ih_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         vega20_ih_set_interrupt_funcs(adev);
>>>       vega20_ih_set_self_irq_funcs(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vi.c
>>> index d39c670f6220..c9ee4491ba64 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>>> @@ -1455,9 +1455,9 @@ static const struct amdgpu_asic_funcs 
>>> vi_asic_funcs =
>>>   #define CZ_REV_BRISTOL(rev)     \
>>>       ((rev >= 0xC8 && rev <= 0xCE) || (rev >= 0xE1 && rev <= 0xE6))
>>>   -static int vi_common_early_init(void *handle)
>>> +static int vi_common_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         if (adev->flags & AMD_IS_APU) {
>>>           adev->smc_rreg = &cz_smc_rreg;
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index f0828de1386e..6972a8e2e0f2 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -962,7 +962,7 @@ static int dm_set_powergating_state(void *handle,
>>>   }
>>>     /* Prototypes of private functions */
>>> -static int dm_early_init(void *handle);
>>> +static int dm_early_init(struct amdgpu_ip_block *ip_block);
>>>     /* Allocate memory for FBC compressed data  */
>>>   static void amdgpu_dm_fbc_init(struct drm_connector *connector)
>>> @@ -5249,9 +5249,9 @@ static int dm_init_microcode(struct 
>>> amdgpu_device *adev)
>>>       return r;
>>>   }
>>>   -static int dm_early_init(void *handle)
>>> +static int dm_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       struct amdgpu_mode_info *mode_info = &adev->mode_info;
>>>       struct atom_context *ctx = mode_info->atom_context;
>>>       int index = GetIndexIntoMasterTable(DATA, Object_Header);
>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
>>> b/drivers/gpu/drm/amd/include/amd_shared.h
>>> index 9b02ab1c2048..67d75ac339bf 100644
>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>> @@ -379,7 +379,7 @@ struct amdgpu_ip_block;
>>>     struct amd_ip_funcs {
>>>       char *name;
>>> -    int (*early_init)(void *handle);
>>> +    int (*early_init)(struct amdgpu_ip_block *ip_block);
>>>       int (*late_init)(void *handle);
>>>       int (*sw_init)(void *handle);
>>>       int (*sw_fini)(void *handle);
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c 
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>>> index e8b6989a40f3..ff71af96eb1a 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
>>> @@ -2954,9 +2954,9 @@ static int kv_dpm_get_temp(void *handle)
>>>       return actual_temp;
>>>   }
>>>   -static int kv_dpm_early_init(void *handle)
>>> +static int kv_dpm_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->powerplay.pp_funcs = &kv_dpm_funcs;
>>>       adev->powerplay.pp_handle = adev;
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c 
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> index 43028e776c93..5aa4eca21708 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> @@ -7930,10 +7930,10 @@ static void si_dpm_print_power_state(void 
>>> *handle,
>>>       amdgpu_dpm_print_ps_status(adev, rps);
>>>   }
>>>   -static int si_dpm_early_init(void *handle)
>>> +static int si_dpm_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>>   -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>         adev->powerplay.pp_funcs = &si_dpm_funcs;
>>>       adev->powerplay.pp_handle = adev;
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c 
>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index a71c6117d7e5..2af325b9fc19 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -75,11 +75,10 @@ static void amd_powerplay_destroy(struct 
>>> amdgpu_device *adev)
>>>       hwmgr = NULL;
>>>   }
>>>   -static int pp_early_init(void *handle)
>>> +static int pp_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>>       int ret;
>>> -    struct amdgpu_device *adev = handle;
>>> -
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       ret = amd_powerplay_create(adev);
>>>         if (ret != 0)
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 4a6b4ad97f06..ba09dde79499 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -742,9 +742,9 @@ static int smu_set_funcs(struct amdgpu_device 
>>> *adev)
>>>       return 0;
>>>   }
>>>   -static int smu_early_init(void *handle)
>>> +static int smu_early_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    struct amdgpu_device *adev = ip_block->adev;
>>>       struct smu_context *smu;
>>>       int r;
>>
