Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E291CD5BA7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 10:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9B110E85D;
	Thu,  5 Sep 2024 10:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5So1y8i6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 584F310E85D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 10:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7mK2i29mifrbja6YJ8p8ac2zZdqGrQIMy/nhivhcW3fgsVA4bVKXsyH+mSv+CTrb8OvpIAB7QNlX98T7q/uidFcse5h02JAbtT6XC7kZ3JqjemgLKV06aGvsdcOljdol0u9ukNfQSBGIbIyDO5JlHMCWTBXRQXC/Yc9TeRWAptr69V5P/k1xeLjTH6Zey2hx+epVIbv8y5bTpDlkbuPIEIwy+9KtHvDxBlR74aDSZRFI6Ztj3lKrfoPxVBH784ZQPh9M2OkivGIfeWCj2Zw7Q2sWfjRGflUpOoviWjKP0drw2C84jngRwvqLyQA752pYCFIHSRniC9FsqyG0+sFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y84gpsr8RJdHWtUjezIO3VXWBEngUK3S+Ft/2fOEFrU=;
 b=PDhS4O8M6WoW69NGKXcPj2gMuhOLV5owN7IA+ZenP8WGwXKJ8EMKsTfJ3mv3XiCAhbIa1bdM8iFv71yPYxuFollUu+mG3y16rHzcjOYf0hFJvuIX2zhOoY2TGVu6To3gCZH1Xa29Hc23i5r3zoinBbOC5TmqwA4BkBULNVZwaxyx3DJ/GMmcfDoTo4OkxlSYHz2JvhaSk94hlm4O6ltLbxm/DeViI2E++N0hxyHylBKtTF4E2Akf4Dr4QDIFBsl7qRkglqrms+hcZJdaeEZljhDLESBLQUR3LinTvIpfa+J9+D2nUlxsFjeSWhfWX2BaHItET89t+VnFI9wPoZnlog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y84gpsr8RJdHWtUjezIO3VXWBEngUK3S+Ft/2fOEFrU=;
 b=5So1y8i6ccHbbKuRGNNAMPBzCImBDt+aC7xpc5kJqAvZlWJc273Ozy2l3hTEO8rLGTkwzDnhQbdy37CfXBnQUYRLhuITCi9R19fz+rFPlP5vjgEF64KxkF8zgFryJmhJVGJXlZgjC7ml/qHrCT2eo3oH/esYiO5Phx96RuHxVK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 10:47:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 10:47:12 +0000
Message-ID: <ee95d0ea-1d46-4e73-9e88-1ebe167a0f5e@amd.com>
Date: Thu, 5 Sep 2024 12:47:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: Enable userq fence interrupt support
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
 <20240830184322.1238767-4-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240830184322.1238767-4-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: f51037e5-6d43-4351-c47b-08dccd9818e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEdNU2tMVEdmb0xXeGpIaUR6SVFBK0ZNZyswL2lwZGU3dGY1RXlHekFOMlhJ?=
 =?utf-8?B?MlByVEhnbGdPa2NpSG90NWFyNmxubEIyMWZEaUNadXNFK25EdWh5cHlHcmwr?=
 =?utf-8?B?cUk1M3dsQzdvVTM4dXUwR0VKc0kya0hMT1ZJMTRVNlZ2Kyt2OGdrQVJoOWtn?=
 =?utf-8?B?K0VETUZnSXNrOTdlMnFEUThOTFcwMUNUajJFbG1GZnFKYnA3SXZCWW9NcUJK?=
 =?utf-8?B?bHhZM09QckRocXZDYWFSNlJidlhCS0swR2VmeWZoNzFWVWlmMXFvSyt2b2R4?=
 =?utf-8?B?cXFqNnBCb1lZcWw2UE1aZENWdnNyVUFYZGVacjBwSm9OS2s0cFNVWVdKY28v?=
 =?utf-8?B?UTFEcUlRSkV0dlQ2STQvanNZd2JOdGlpTnZMYmF1dm1uQ1dwbmRETXl2Uitq?=
 =?utf-8?B?cTFsbkZDSTJDaVEvSTB5Z1ZZd3ZzQXgzRkowaHdVNGl5WDYyc3BPamtpUEkv?=
 =?utf-8?B?c3lUVk1xcmU1b0VHY2tEYUxzMm8vd1FTZ0x3ekxKbVhhSGE4SHdHdWJkc3pE?=
 =?utf-8?B?OHFBbzlleVhaWWZFQUovTm02SjNWcTR5ZVNmR0pGbnkyaDhjSnJJanVZSzhX?=
 =?utf-8?B?cU1uemRXWjBOSlc4b3lMbTduY2hINThrK2xVcm9TQTYxNXFzVGNYOHM5L3NY?=
 =?utf-8?B?U01RTDlLVTk1S2h2SFE3cXRZZDNFcFJiZU4zS0Uxbi9YS1ZUaUZDZkQyRGFH?=
 =?utf-8?B?M1pXbmZkTlNMYXFSNGZHd0NqekVVbzJQMmE4WU00clI5d1VNTGwxbWExMkJO?=
 =?utf-8?B?Q1Z0NCtEVVBXZU5kaS80bTZEUloySnY1bnByanJLWitBbW1SSjVPWlhWNUFq?=
 =?utf-8?B?ZnhJTld5ZVFuMnowUDdpVEdWVThJT3JWazU5WTFOcnR2aUZkSCs3UmxCdHQ2?=
 =?utf-8?B?eWNiN01mYW1yY05LQ0pWUkFWMm1qT3A3RVM0eU02MVV0a1l1RDBnN3U3d2FQ?=
 =?utf-8?B?aGhrSWIrTzJjSW5jVjBRNm5COWd1dFlJVGc2dk1SS2RyTkZTY1U4eUdVYnU2?=
 =?utf-8?B?cjJsSk9PV1lNNE1JRGlyOElyZTkwSjM5UTgzVTQwdlJoN2Joc2wxVnFHeEhn?=
 =?utf-8?B?STFCK2x0RmRwckVVNDQ0M0c0Qys1YjVhMC9ZbjRid2x6YSt4VHdwNzk1MG5m?=
 =?utf-8?B?V0R4bTFCVjQzU2I4b2dRTGFTeXk1cXh5ZWI2QlJBRUIxYXMyWXM4MXluVW96?=
 =?utf-8?B?YUZDRzE5ZjllU3BzaFpaRFRXaU1yZXhvMUlBQ05ERThsMEF1VGI4R3ZkcDVh?=
 =?utf-8?B?YVg2VzVSbGpnMk9hbVdGdUNpZ3NOZHdtLzkxUk5VbENzNU5QTExzemVkbW9F?=
 =?utf-8?B?OFRXUjJnUk1mMFMwR2g3c3R6ajk1eW9BZTlhaU96TWZ1T3hHcVQzanp6d3o0?=
 =?utf-8?B?Zjd3a1J1V210aXloeC83U3N0cnRFNVNNV2xxb0hHb3BpSlYvSURyMmdJUVlL?=
 =?utf-8?B?ejliMmlvQzFIVERDKzBUQnlhNDU4a21Oa2JvK1NzSjgvRm9sb1dtazVwZHIv?=
 =?utf-8?B?RXBDNlF3UzczejJudmZMeTEwUXBNNEpjRlF1S1NFRFN0dzBqSngwZ3ZONksr?=
 =?utf-8?B?bVR5T00vV1lTaFNOeTEyeVYzalFjeEpkWUlKL0FKdndiYkhic2RqMUova0w2?=
 =?utf-8?B?Z0FuZ3ZVV0NWR1hpZTBSUk1IVXFCRjNhM2VzMXYvYm1oLzZpTU85YjBtU284?=
 =?utf-8?B?emc2blROaUVHQngyMk1YTkN1ZFBGclQvbE9SSVZLdWxlMnoxa0N3WGhnOGdp?=
 =?utf-8?B?OUo3OTN0TksycGRrWTQzVjBUTFg2RHhIOENpdlFWRGQraWQ5T2s0eTZzdEFC?=
 =?utf-8?B?RkdlYlJ4WnBrcXhCdFYydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1MSTdXdGdySVRMc085WVhhc0c0WU40ZC96T2pDWkp6WHIxSlVCY1RtcVds?=
 =?utf-8?B?NjVJRE1PY044cENqQmZOR0w2Mi9kY0RKc2UvRFVzRWJ2Y2t1ZHZ3SzQxQVpn?=
 =?utf-8?B?bE1tSFJiMUhPTVhlVVV2UVd0Z0V2d0JhRG5VUzdNcDRGakNaK1orblhpN1Bh?=
 =?utf-8?B?TU42T3lUQjRFczhTTzZxODdmcTBGRDRjd3BGeXlzU0pkVXF6RURDWkZYUGlm?=
 =?utf-8?B?aEtlUkZpQjZsWG9BbTBGaWpvOWNzOU05Qng5d0Q1eGl0Z3daaHp5bGZSSnZK?=
 =?utf-8?B?NFFMWjNiM1Z6NVNmQ1ptUnMvbDN3V0JNVGlWZW9sU1ZsTUF0UldhNmpWdWs4?=
 =?utf-8?B?OFJjTUZMdmszSGpxUGhMQmkwTENCRXgrS0dHOTdXZWdqZFhjK0k3OXlHUzZs?=
 =?utf-8?B?aithN0RFQ2tnelhUcWR0TzFBSW1wU2RiaC9wb1BqYUN5S3Z4SlFrRXhFei8z?=
 =?utf-8?B?UTRGTkJtL21KMWZ5REsvNW5QUnJ1WWh5WlhsVGhvWmprNklVU3lxNkFaaVgv?=
 =?utf-8?B?ZFJOSzlocStnejNJSVo3OCtnMHVnVjJJb1I2TUg3cDhmTmlXTFFaNW53YU5h?=
 =?utf-8?B?cWordWNIWUhCd29hRndYeUdIcW5nNEVkb2R5ZURONjU1SjhyRFJGUlNqTUdq?=
 =?utf-8?B?VE1iTXk4eks0c2Z3UUxMVjh1Vm9WOGdxYUJkT3pHRXRQeEUwWk44b3gwWlhB?=
 =?utf-8?B?WjBSVytZNkFkVTRqcGR6SklvRDhUcDE1SmZtRS9nNzBoajg2OVNBdzRYcEVV?=
 =?utf-8?B?cDJPUDBPZHJDODY4bEtrbXltK1dsQUFEZ1ZjUldOK0RVMEJkOGZzWFJQeSth?=
 =?utf-8?B?NUpYWjFwSm9VNlNSSkxrNTIzNVREZGJ6V0d4ck4xakpaenJPNmtjYVE0OUVE?=
 =?utf-8?B?L21vSlBhNjIrREdRRVdpVUlFeE91WFZld3k4ZHhjWlltTVVjYm5vcWI2bWVO?=
 =?utf-8?B?N3daY1ZNcCs2YzlxMXZUK1NTcy8vK2NFNE55eHgxcitRZnMvTlkyakZxbUJ3?=
 =?utf-8?B?QllTT05XU1k0Wll3RzlUcXZ0RU85V3lpTStKQ1pzcW10alRZM1B0S0tYSU9s?=
 =?utf-8?B?Uyt2bDVIWWxmMmpObWJ2QnEwSExFMTRXa2EzcDJ4dlVQR2YyNGlZcjVTTDIr?=
 =?utf-8?B?cnM1TG5lTytGdVovNVEyN0NjcmhXVW0xTGxEMHo3NkMxcXpUWXJQdzBKM284?=
 =?utf-8?B?ajVjSkhZVEdUdnVzd2dQYWExMjVlMm1nUGRJRFBBLzZJQ2VoZlZBZThFT2Fv?=
 =?utf-8?B?RzFHSWJkc1VZSTcrWjdKOExYMGZkajI3ZWtWQ1FGd0FBUWlvd3QxMWJuanhY?=
 =?utf-8?B?NXdvcDIySTVGSEpIQlBtbXNibUpxbHBpSEM5NkZtenV2T3BtTjR0WWd4dyt3?=
 =?utf-8?B?RXFJQ05DQWpWajcvbTZlak1KeGZYRVhEc1dXK3FNUXZiSi9TQ0NaUHorU2VU?=
 =?utf-8?B?YllSZnNsdUJMSzZ3c2hkT0RMNzlkRDdNYmNiUWlhNUlDWFgzM2o2VVVtY2ZU?=
 =?utf-8?B?MUozN0RWS2JMbDRVNi85TkhyN2xWUG5CVWpmbHNobjZhMW45WW9jZWt4YmJz?=
 =?utf-8?B?WU5FNlgyaU9Fd0FUR0FDWTUzeEFTNk1zeURDT2ViT1JzclgwTmZveTNHNzBR?=
 =?utf-8?B?VkdnanRrTVBrVmZaQ096ZWJkc2tPTExIWnRvSHEvcGkyMU0xd2ZONkdEakcv?=
 =?utf-8?B?YWF0YW5sUmlGNmdHYW16V2NNV3FGSlVSaWtSRHlXNjM5ZytSaEoyRDlzRktq?=
 =?utf-8?B?c1ZVam1CZGxiYmhTYXZCYlkrSFNIa21CK1dPUUowZVpFUXJ0cG5teG1RL1k4?=
 =?utf-8?B?WGtpMldqa0NUVVVlZTVSNlNMQUVZYXpoVW1BMnJCaWJNZG1neUtEVllvbm5Q?=
 =?utf-8?B?ZVIxQXVwaGw4eGJLcHlEZXFQU2Z2c1hhODFxakIvWkJOeHFPSEl4S1E3ZmMv?=
 =?utf-8?B?V2FoQTNtTWI4TkNWK1IxaFU0MkRQeGVEZnhJa29zN3NaR0YrR1NVVTd6Nm16?=
 =?utf-8?B?S0k5dzgwZUY4dXk5blRGalcyQk5kbmdxZzVtbCtidmh3Q29YQzI0SVo5bGg0?=
 =?utf-8?B?SndabFJpRG9PbG5ZYXYwVURZYVFSTStGNjRWNDltdWNCOGJVbVdiQ2d4Mk8r?=
 =?utf-8?Q?pHzY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51037e5-6d43-4351-c47b-08dccd9818e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:47:11.9335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raHpMtZ0YY008baTwLAWFD0M1dWZ6URCWiWzYWvjmPGEVTW4gPS7qpuEtDxVY0o4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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

Am 30.08.24 um 20:43 schrieb Arunpravin Paneer Selvam:
> Add support to handle the userqueue protected fence signal hardware
> interrupt.
>
> Create a xarray which maps the doorbell index to the fence driver address.
> This would help to retrieve the fence driver information when an userq fence
> interrupt is triggered. Firmware sends the doorbell offset value and
> this info is compared with the queue's mqd doorbell offset value.
> If they are same, we process the userq fence interrupt.
>
> v1:(Christian):
>    - use xa_load to extract the fence driver.
>    - move the amdgpu_userq_fence_driver_process call within the xa_lock
>      as there is a chance that fence_drv might be freed.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 ++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 25 +++++++++----------
>   3 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 94bdb5fa6ebc..2da895f91e4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3967,6 +3967,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	spin_lock_init(&adev->audio_endpt_idx_lock);
>   	spin_lock_init(&adev->mm_stats.lock);
>   
> +	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
> +
>   	INIT_LIST_HEAD(&adev->shadow_list);
>   	mutex_init(&adev->shadow_list_lock);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 8a3b5374cc1a..4c3c8901e155 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -70,6 +70,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq)
>   {
>   	struct amdgpu_userq_fence_driver *fence_drv;
> +	unsigned long flags;
>   	int r;
>   
>   	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
> @@ -97,6 +98,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	fence_drv->context = dma_fence_context_alloc(1);
>   	get_task_comm(fence_drv->timeline_name, current);
>   
> +	xa_lock_irqsave(&adev->userq_xa, flags);
> +	__xa_store(&adev->userq_xa, userq->doorbell_index,
> +		   fence_drv, GFP_KERNEL);
> +	xa_unlock_irqrestore(&adev->userq_xa, flags);
> +
>   	userq->fence_drv = fence_drv;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 508e0acebb0d..68f908cafb6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -50,6 +50,7 @@
>   #include "nbio_v4_3.h"
>   #include "mes_v11_0.h"
>   #include "mes_v11_0_userqueue.h"
> +#include "amdgpu_userq_fence.h"
>   
>   #define GFX11_NUM_GFX_RINGS		1
>   #define GFX11_MEC_HPD_SIZE	2048
> @@ -5865,25 +5866,23 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>   			     struct amdgpu_irq_src *source,
>   			     struct amdgpu_iv_entry *entry)
>   {
> -	int i;
> +	u32 doorbell_offset = entry->src_data[0];
>   	u8 me_id, pipe_id, queue_id;
>   	struct amdgpu_ring *ring;
> -	uint32_t mes_queue_id = entry->src_data[0];
> +	int i;
>   
>   	DRM_DEBUG("IH: CP EOP\n");
>   
> -	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
> -		struct amdgpu_mes_queue *queue;
> +	if (adev->enable_mes && doorbell_offset) {
> +		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> +		struct xarray *xa = &adev->userq_xa;
> +		unsigned long flags;
>   
> -		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> -
> -		spin_lock(&adev->mes.queue_id_lock);
> -		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
> -		if (queue) {
> -			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
> -			amdgpu_fence_process(queue->ring);
> -		}
> -		spin_unlock(&adev->mes.queue_id_lock);
> +		xa_lock_irqsave(xa, flags);
> +		fence_drv = xa_load(xa, doorbell_offset);
> +		if (fence_drv)
> +			amdgpu_userq_fence_driver_process(fence_drv);
> +		xa_unlock_irqrestore(xa, flags);
>   	} else {
>   		me_id = (entry->ring_id & 0x0c) >> 2;
>   		pipe_id = (entry->ring_id & 0x03) >> 0;

