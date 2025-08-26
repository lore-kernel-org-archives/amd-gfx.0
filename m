Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF02ACA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 12:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB8C10E641;
	Tue, 26 Aug 2025 12:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kAGsLeKg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EB910E641
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 12:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVKCm+X36vRLG7xehLITR9zW+026sPZEscWrJZwzUv1muL0RCL2K06qD71lG3ZW0PQpb8JbrwVol1baGYJuYrIqJyP1s8S9SJcTHnhLQxy2GnIhbPj3NqDjetisfG7DM4els+tYHQs2kIzF7mW7lBESOC5+QWGvAIxeIu/4c8KcS4l5+98Sr+T41NoahAUQ+1r9uG058XFaTfJnlSKFLZxONCTo+hFadc6vEZrFZkYBmmPbvr1mGcgnhFTeKY3sf4qLSgAWR5o0Zi3uhpaBbZ97/WTbLscAacePhbSMaRkX5k7HsZpszHUsM5Y9h9f3x5Lv9X1XRFSeYA9gHsM6hMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F74EIVAX9AiA9DySx0auF5UBr2Z4gbv/X07y945TEfE=;
 b=m8qyp6iPQq1kkjak2LT6c/NIbKPyI5JoSJ8NpZf5/xq6p0fiFgSkHl2O08fprvZKnKcSMOvD1ViMZL4q83b8h3A7qxbSMcmru1hFxI8Hcu15sFB+EZAxJ018k0CH+fjh+fkgQZLMr7voupAc8bLU7GvgDuux+HJODnsBoNlgKV8FNMuJaMotZaHXXB39SaMz/i+nV6SxuH9eLS+Rf+SOWDSip6K+K8ZzoXJxYXxaF1ckk6j6Up/Oh2RuUjL3yjUWPzKaCP4+LMEK/7t5+aFjoXzAeM+Y0QIgMQDHJ8saSH0NhfBIqz/OOrSobDJ7s9FXCUJLhisiIe/Fazu6c34t0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F74EIVAX9AiA9DySx0auF5UBr2Z4gbv/X07y945TEfE=;
 b=kAGsLeKgKYr1eEaYqk0DlpP27lmA7Cce0x62Xzj/zbdt675WzipcIqpEymDXscpBTdhFerdtxZWSNcJjTk3a5KjbtvNhZGSmMGbKuO74MrR7Exr6B3/xQKRTip+WZHsNLtxxvUe7bxiYabBdjXopqfn2OSFudf1EeDRuzFv7KzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 12:10:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 12:10:16 +0000
Message-ID: <dae92ad9-ac76-4b51-92ed-d5f0574e6689@amd.com>
Date: Tue, 26 Aug 2025 14:10:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix memleak of ring sched and fence driver
To: "Lin.Cao" <lincao12@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Deucher Alexander <Alexander.Deucher@amd.com>
References: <20250826092516.3607290-1-lincao12@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250826092516.3607290-1-lincao12@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d467d5-daf4-4c2a-6c57-08dde499846e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azFtL0JUbFhuams2d3h4ZkJoMUhNVlRmb1YzWnJLM1Z0MUxrVmZKT0NuQllv?=
 =?utf-8?B?aWpLdjB5clltNjdIVnV5RWtFRGNqM253dVdsU05QNE5vL1k2akpPdFhaM0V4?=
 =?utf-8?B?ZzJGbFcwd282Ly9zd3d1UFAvVkFVY1RXYTVEUWp5NFZEaWVsL3gxNzkzMlhT?=
 =?utf-8?B?MVBqcGM4VDBtQi9jNVlUTGtLb3N1SzBSZmk2c2VSUW1FQlBPWGlGWm1zMkpt?=
 =?utf-8?B?ZjlHWExzTjZDTmpCOFRNaW1waFdLZVFRWG5sYjhxeEVWSFU0eTJEQnBEbHEx?=
 =?utf-8?B?VlB5TUd2aFdocmtpUlB4WFV3a1huZjIwUHpUcEtZV1NqbkFyTkZSclQvMGlY?=
 =?utf-8?B?dnJoRG5SZ0FpZCtKTTJsL3V4SHNaQVdUK2N1QkNYSVZ3cUNmdHdtcVM2bitw?=
 =?utf-8?B?cmtDY3RBQTRrTDFjeUEwMFZzbCtkZDV3YkZDaEM5bExudEd1a0kzeTNGamJx?=
 =?utf-8?B?YkNMMjVZMHkxSGx5VjNyWGgwOGdnbnJhRFJRUy9zWlc3eEVuZlJxV0lCcjhy?=
 =?utf-8?B?RDV5eFlTOG4veXord3hJZ0c5SStFUFFPeWZVYlpCbG9XL215MjBSd01kbURZ?=
 =?utf-8?B?WXMyVmErTEdhcElYSXk3TVBZdGdaVE9vR2FlOFZlOFNhZkU5ZXlYcCsrSFE2?=
 =?utf-8?B?MUlQblluWGpUSURjb3BaYitXTklmSUNkcVN4SFRlNmtyUnpzVG9VWTNNT3lP?=
 =?utf-8?B?S2VyUm5ENEVmdlFxa21md2k2dWJPT3RKb3kvV3hWdVJCUjExaUJONG1CRjhI?=
 =?utf-8?B?QWRXS3R3Q3Rad2lFYzgwRm5CcWZaNVlsZjIrYkhBalVkQnJYbTQ4c1VOMHBW?=
 =?utf-8?B?T1cvRjJYVVBhMENTYlY5Ukd2VDJsUjM0OEkydGUza1FIVFhDeEFqQ3Frd3lK?=
 =?utf-8?B?SjZkTlliblk3WVFDYjl6bHhldnhENzFnSkFRQk4rUGxyTnZpNytldkE3QStD?=
 =?utf-8?B?YmJqcVdVdW5sa3RSZkJDOEtoTDVOT2Rlc2xWN0FZR2dlbFAzMXA2c0xybGd3?=
 =?utf-8?B?Qy9lYlNIOEM4WGNmN0IyVEt1MTFWVHJ3UGVSUGpXQWJLNDlnRmIvb0ladDE3?=
 =?utf-8?B?TzdsRlErNkJ0Ym5INHFGelVMNE4zWWNrU2dLQkd0RnJIYXlZUFFIUkdta3FV?=
 =?utf-8?B?ZkpqTUExM0VKUEpsMldQMXd6VmR4cytpaFJUNGZvaVhOTXp1NnR5WXVIZDRP?=
 =?utf-8?B?bWJnZ0Y2WTh1Y2k0Z1JTWUs1MDdYc29hRWFNRmsrbGZhci95ckZzT2d3SWxT?=
 =?utf-8?B?SUZqMm5VanRkZjdOa3lqNGRUV2c0d3l2RHg5S1RoSmZ3dlFoWnpnSmtQNytE?=
 =?utf-8?B?TWhMSktRTm91L2EzOEl2clVqVjJhNWZJVkYxaU1jYjdETlJTUjRKcFBROWdl?=
 =?utf-8?B?T1RmSEgrNk5QMXI2TG1NNXRtMkp1VG5OekJGd24rUDFvb3ZVaVVhc3pZRXp1?=
 =?utf-8?B?dzh3RG5wZXk0LzRVQkpIWVBCSkVqR08wYXp6V3NaUHRycUlLMHZab3lOMGlr?=
 =?utf-8?B?RUFwemdGd2d0RnVqcmlubWdKY1Qvb2laMGw2UGx0VlAyYmlERzRlUlNzaFFG?=
 =?utf-8?B?VXE3dFNJZ3gvb1BZOTB5TUhYZTBkaGFvVGZkUlQ4SXFwUksvV2dJb1ZLZ3J1?=
 =?utf-8?B?eHEvWWh1dk9DWFliUkVQZVA1WjhTS1dGTUFVbDVGUGFac1JPSHhRN25uRWFS?=
 =?utf-8?B?YzM2Y3BaQTExV09WMlJ4cUJLaHhKOEg0QS9KOGI0QzJxYlNMWWdUeElwNnU5?=
 =?utf-8?B?UmJTY2xhbzg1WUVzSjIrdGczVWsyYTZvdlBjeVFkbVIzMlZXV2tJRU84R05S?=
 =?utf-8?B?ZCtNY3RnM012QzVFQ3AxRjFjVnEvR1h6SXR1QXBTMGZNcGtVdkowb3JsODdR?=
 =?utf-8?B?VU5OeDEvV3c1cGV5ZnlvdXN4NzIrdXlJZ1dTUmZ5WWF4aDRwSnVEZmhjSFFj?=
 =?utf-8?Q?MUZcCPXX/kI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZYSW8rYlIxSXVWZmlCdlR2bTBielJHeU16REx6Nm9aeXgxK0RiU3Bla1BF?=
 =?utf-8?B?SFJOdE11K3pGWUp5dTNwNi92bE5vdnJhcGNRWXdWZXErci9zS011OFVPZlF5?=
 =?utf-8?B?NEthZkw5QUFBR0VKWDcyWEZFV3d4ZTJ5WkNDVzRTUTlScFdZOGdXaTBWK1Vk?=
 =?utf-8?B?dmcrUnc2c1NBSzZhRXZOdGEvNTlnRk8wcGEzZXlNcmdkT3dJN2lGMmZVTjZ2?=
 =?utf-8?B?aXB0SkpPUmRpQW9CU28wODduaEZiWDBzeVYwTlBWbzZsc2JzMWtrTVY5Z2xT?=
 =?utf-8?B?cTlySGRLWmtIU0tTVk5xUThHbnh4YzdpVzJmMHVUbXFKQUxpUGxRK1ZaeWhy?=
 =?utf-8?B?emYxTjZBQ05iSDdSaXo5bmVIOTU5ODUyUHZEeE5PN2Z3L0ZhQlloSWlKMkNh?=
 =?utf-8?B?YVZaMi9uZ3N6Tm50ZURUayt4WDRWTm1SdG1RV21TTWFQQ21tQkVYVU1NVUg1?=
 =?utf-8?B?ckd6Slp2YkhOcUdKdlQ4RHJMTjBpdEFNNnRSbXdMNmlWMldReENaUjAxMTFR?=
 =?utf-8?B?b3U4UHE4VlBVc2NBWlQ4WHFxRm9ZMUtpRDhOM2k1b1VsSWVMQzVUQkJCODkw?=
 =?utf-8?B?bnNva1JPOWRjT3U0WU9CcXl3a3oxaU1KUXpmNlRkc0cza1BpT093VnlPRUND?=
 =?utf-8?B?Yll1OHVodUlGWW0xQXNkalg4d0Nudnp2MG9RaGlGNXZwYjlYemZ6QzhPRjF2?=
 =?utf-8?B?eTJrRjhmdnJMZ29Rai9xb29MV3I4cXVKTW1VOXV2TnVCYUFSR1Z3eFcrZDJq?=
 =?utf-8?B?Z2l6NWo1TGltVDE1b0pkSUFoS0tYQ0pMWHdjUU9pa1B1SDltc1hxTldBUnZh?=
 =?utf-8?B?UGRUamFtaGQrYStJRCtVblk0UWl3TkhzM0p6SnpRSmJpK084VE5LSXZJakxW?=
 =?utf-8?B?S3IwclNUVjg2bVRnN0xDMWhNQTlZaEpjQy9Hb1JmdkFiUmRFdSszRExDRHZN?=
 =?utf-8?B?Zm5lTkcwUlVWV3VzeXBqVXIzTUtGblI3VXViaVk5OW5ydjhDeXVCVk1Xd21w?=
 =?utf-8?B?azgyc2JWeEdERllWOEpZNFk4QWxOWUJuTy9nOEVhTFpwVnoxTUQxOTV1Vm1W?=
 =?utf-8?B?YW9sdHFqc1czSnVjbDNqU0tDMG1QUys3a0drenNsaUplcHhWejlPVjdhUXVk?=
 =?utf-8?B?eTY5VzFjUjJEZ3RNbmZSN2szNHZpYXQ5SUFLQnVNMlNlb2NDMnpISnFvT3Y3?=
 =?utf-8?B?WWs1VWZQeWpqZXo5c21tY2piNXlUdzhDaEViYk9XcWtpK2lId1dBajJwamxH?=
 =?utf-8?B?U3ZSTWxqOSt3b2hWTFl6Sk1OYzgxaktPcVNNZnpqclRsQ0F6RnFJRkVORFg3?=
 =?utf-8?B?ZFFiaTRmVzRlYzRUcjVuL2JTVS8zTFZPQm5TQXlxNjU1eEtOaXpnMWNmaGJq?=
 =?utf-8?B?dHBxcFoxWGxFRjBKT1YreXFaUUFHR041dFB0WEFXYndoRk9kdXMzSFJ4Nk9a?=
 =?utf-8?B?OERTU0FRL2o5UGxSMDMzYXEwcWpXMFVmWkpPNW5OZ201ZnVnZGIwMFhpcmpv?=
 =?utf-8?B?RmtKWlEyd3FXVnRnMmFuaXVUQms4SUhLekxYaTZtNVJLOWZJaTFFYmF0TGhl?=
 =?utf-8?B?UTNyRmYzVHNOa3d4eXBTUjU0L3p1SHpSZ2VMTERRUFRrWE9YWGNNcnRnNmtz?=
 =?utf-8?B?cTNaTFZuc2pWVEFQdGFZMWR1Yis3bnF0dW0rcEZWdmFZVjdpU1pDc1R5bnlh?=
 =?utf-8?B?NDBnK0pWZ1h6c0xVbmxTcHFaaU5QVkNZK2Q3SlByTmJUaGlVSTNRTnVZMysv?=
 =?utf-8?B?MUtTa0hRUHZHZnFKaTlIa2l5Wk1kVVRwSTUwdXowWTNVNVIyVThDbDZHbDAx?=
 =?utf-8?B?Vi9EMVk5Q3FHbmVTdm52Z2VYcmt5akRjVnloQlpLSWYvVjBQSk02SGROYnRN?=
 =?utf-8?B?V2kwWVNpL1Y4cDhPWk96dGhGMWFGZ0VrcXpFZ2p5NnVBcUwwOVlTMW02SlY0?=
 =?utf-8?B?SGdCc2E4c0M0WmlwTFU5b1JhVGp3SUx3WEc4TEZ1NEhJRFc1UDhiYi9qbDQ4?=
 =?utf-8?B?R3BhaW1lNytUOWxWdnREcnhTb01YYUhWVmFJZ25hVHUwVmd0Yk1nVzVFbTJR?=
 =?utf-8?B?UDhLVGQ5TlkyTWxBR3ZPUTBkaWNDcklTVXJBazZvQ2lnTEp2dFVobnBPZGQy?=
 =?utf-8?Q?hqdX5rHVlUqps2OxEHoAgvls/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d467d5-daf4-4c2a-6c57-08dde499846e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 12:10:16.2655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnsnRaRPXt6+gcyIel5iPiweS9UEda7hZbgUz/lbAPwZ1ZKTxLJnLn9Y5dxHxkhD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959
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

On 26.08.25 11:25, Lin.Cao wrote:
> commit 4220d2c7c41b ("drm/amdgpu: remove is_mes_queue flag") set
> ring->adev->ring[ring-idx] as NULL at the end of function amdgpu_ring_fini()

That is a bug and should probably be fixed instead of this here.

Regards,
Christian.

> which will cause function amdgpu_fence_driver_sw_fini() skip
> drm_sched_fini() and free fence_drv.fence then cause memory leak.
> 
> Release these resource at the beginning of amdgpu_ring_fini() to fix
> this issue.
> 
> Fixes: 4220d2c7c41b ("drm/amdgpu: remove is_mes_queue flag")
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 6379bb25bf5c..cf6f19a122df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -406,6 +406,19 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  
>  	ring->sched.ready = false;
>  
> +	if (ring->fence_drv.initialized) {
> +		int i = 0;
> +
> +		if (ring->sched.ops)
> +			drm_sched_fini(&ring->sched);
> +
> +		for (i = 0; i <= ring->fence_drv.num_fences_mask; ++i)
> +			dma_fence_put(ring->fence_drv.fences[i]);
> +		kfree(ring->fence_drv.fences);
> +		ring->fence_drv.fences = NULL;
> +		ring->fence_drv.initialized = false;
> +	}
> +
>  	amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
>  	amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
>  

