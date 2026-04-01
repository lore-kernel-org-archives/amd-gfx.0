Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA12D2ED08
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A28B110E54D;
	Wed,  1 Apr 2026 13:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HsopjmDc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B7210E597
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9qAc15eg4PiZDveqET0IPZfo180UVJt5BB0FfPLGtc6E72d0/AdnLwCePitosq8NFRyr3Sp6WthO40tV7od9xiDKWeNLbUwS6OkV74y6qr4PY372PK98a3rg4b4901jHQX6bdmHOvJsq5CeclEJ32GRJA6SlGw7qg/160H8YFjHGjFoK4c1d8o+8ImLTIiehZLtdWSYcdY45VCL5DE2Zi1tpW79GGcAl5uWpZxuvagG1VCR/311xCkVOIpVtq+1I42bxdVtqvDaR+zn/UFrx8LRWfYrTXGGgS15j8dQ6pckSH4jUBsdMrFT6BeZUMy4W12GRbjzS9tm3TAlpocSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWk9oLmycnfFc/4KN7Q/v7+QvKtTcL12AMq2+tcMzfU=;
 b=aNZEDOgFxhOviUhnFS7Jmkke4i0dQyVV/0ENYQQ2zaBxu+WmeccuMufFn8eqAWxA2Ne6WHGRUqjcttFpH5aGyo/Ociu9IS/s9jh9cniUXJBVgx1GmxaqMn4OShNdCJdxEpX0/qWJF2+FChzFfidvArABHeV8SBxIqJyFeDTJaQoFbDZMDXijVDPeJj9sJsThtZQu9S+aNAoH7VJqorZjL+O75SRriUlwZl53X6Hoz93upozmsXo7yoosF35BFIOmgVXG/J0sX+bMuEg8c4Cph2iwnASnXFWo0TfVcijcn5uuspCVSdkngusdUS4Qc0nHZujOk981uPNLZ77bjerdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWk9oLmycnfFc/4KN7Q/v7+QvKtTcL12AMq2+tcMzfU=;
 b=HsopjmDc0L/bgNP3a0NkPuBgh3OWX9PJl4EIWHPgxa1DkpWJDPGHBrgNpr3aOUJ/3SaJvgjXjlq9xrmi03KNku+6sUWQGgZYUhuoHqejjA3bJKwatGjZKRpq3hhA1iJcwrc6lED+EIMaoK23rweS5lnF1vzGiUhbCMt46LlKlIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:39:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 13:39:09 +0000
Message-ID: <9b226a19-62f5-400b-8236-ddce4ba3857c@amd.com>
Date: Wed, 1 Apr 2026 15:39:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: rework userq fence driver alloc/destroy
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260401100508.3397962-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260401100508.3397962-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:408:f5::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: bf00b754-e703-48e7-5dad-08de8ff40d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: VfhzXMH/3PUiqtuwJlQURVQ5pSjR2nrOjhJ6AjiECXUUHbxoU84R9nyvFTDM+EEEQhDKuTXDUzFv68d74Qf/gSJdz3p5ihGLPyhyivNKCzXQ3tqH6R5Ju+Afxtafa81L9nun8h2/RvtJLtA2iRE/sPn0IYGIqRYV6PCyAg7VjFHVeKNilC4O2TFaa5Qozls832RBCq1GGm2sCIulme+tllRXVPE4mRwVquXa1O7HBlTUpfnz/iEDa89c6F6QBzNFbf4W8lEg3Ncwq2s1YFea6/YsJEeVKIfdenmLYOTBnBABVWpO9c3JPFZ6v5oTaPo0qxaDV3sCjXgQ/UtRciWI6N3nGQde28sU5FchKOd/20RqHKxrgTthDcj89gKmpZ1fCnaWmGHB4L2dK5l6uiNQKI4m1IVy+R/qJi0CXLp2zZsYfPcopiCRQyj6A5CoOGum6GJv3L7hm2Yo8efhNC6xuFfkvpfmwOAZYcgRw+fAKwAys62kbjvovmUyzJBIyn7CJ0AQWlVTuo3LbDZv/p0iPn7AaQQpnpt4h0SVwIIeH8z1UJCifRv87F01nEdeJorkshOhIbQzrkq0lSP1MuJucI05vvckplQkLEH7JIXyLXqvQX87v70fJU1F+u3UpRpHj9M6AbWiROnLjhHLuaeb8Q+KdDSGeMj0jtGhPgrfq0Qnoc4kGa5nUAqqiXqiN0XjeQOL2l+cIhtCoEWQc+fFmCC89Hb3n6KRpApCyG61j4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW95ZGxmUmpNNDlERmFVZVRvc1FzdE1oVHQvYWt2Y3poL2FyRVNra1c1L0lo?=
 =?utf-8?B?OWxNWUsrTmRNMTUxaEdPaGlwMk80RE4zTUFzbmQwRFpZQ0FYaUFWNkxINzBx?=
 =?utf-8?B?alpLejdQV29DWlNjeGZpTStvQ3dhMjFzbmMrbzlzcFJQK3ZvWHBYSVRScklX?=
 =?utf-8?B?aEtmeUJPZjBqTk5pNnJYdlhpRUJGL1lHMXF4bXlqUFZFN05WVGkycE9zRG40?=
 =?utf-8?B?TlJKTjVMRGJvMFNUUFhZWTFmMHd4VUNtOStZYS9SMVZIYzBEZGxzWG0xL2pS?=
 =?utf-8?B?NUlibytHS1N5MUl4b25iclpzelIxUjM2T1BUcVRRMmxFenI0cnJPN2xqSnd4?=
 =?utf-8?B?V05KaUhndWVjamVjUUVFUGRrRkFvTEMxb1JrTllFbGRyclZxemxlaUlFV2lW?=
 =?utf-8?B?MHMxMlZYbThLV2RwS1Fjbnc2c2tXRysrSTBHMEFEZ3NHcFdiU1lPcG90ZFgv?=
 =?utf-8?B?cU8yMEJDNWhLczF0M1VrenFNN3J5ZHc1ZU5NWmlzbXhhQnJQa0srbnNBdnNm?=
 =?utf-8?B?elpkdVdNOE1aSE1xakJDa0dwVnV0L1lIend3ajRkTFE3cFZVUjgwSkFHUVli?=
 =?utf-8?B?cURMdTZGK2hNTGIxM012dEt6ekRZcXJzUlYwanFsRVpmTXZDZExjMDlFY01R?=
 =?utf-8?B?djNUdFRGa2M5Y0RQL2JXNHVDTkwzcHcwa0MwRmFSL0FMUmNlMFpsckczWDBm?=
 =?utf-8?B?ZFQySXhBUmxUc293TzRxT2cwSWt0bDB0WDRCaEdOT1JxdzFEdXM4MVFkUGJt?=
 =?utf-8?B?RHNlNVVGKzl5OEJCTmZmeXZZeThaMWd4Q2pEWDE3aENUUkRWT1N6cXVnMWk5?=
 =?utf-8?B?VkRtenpsSHAycXluK00wZ2NqQlowVlpuV3Z2US9IaG5yNHh2VzdoRFczbEt6?=
 =?utf-8?B?VzEydURQekwrV01iNlVrMytyVUJtNzBsMzMvd1hpMVZPU1UxM1VIdDNidGFC?=
 =?utf-8?B?N2RNQXRwQlp3SFlvdENxajVkbUdUSGpOZ1hWNDA5eGRqd25rYVRzVHoycTVl?=
 =?utf-8?B?OE12cFNLeXhrWmh0NXRIYnpZdnJrdmJTNi82bEVBTDRHa08wZ3dKbGg4bS80?=
 =?utf-8?B?VUhzT2dxVUVEVjY3bkorSGlsN1E5SEhJc2J0M3B3TDNrYll1SjVBYnVjMjdO?=
 =?utf-8?B?V1ZXV0JVNlQxaXI0RmJQOEFPTkgvYW1oWkN5OHd0VHY2NTdmY21weHVFRlZT?=
 =?utf-8?B?NVdST3VIdTNKenhGZ1JNOWVqUTk1OVcra2IrRXh6eFRLSDJTbGtwY0ZmSlVn?=
 =?utf-8?B?ZzdNMmdTdjNYUUR6N1JuanZXbGJ0S1RqOEl3N3o2Z25seThlSGFDaFA0eXFN?=
 =?utf-8?B?bW1IZU1GTFZ1aVpTQktHSkVMYUtwZTVkOXNkRjFhL0l1UUdYRjBEWFRKZnNZ?=
 =?utf-8?B?aFFMOFhmbTdhYW1KQjgzRWk1VWpnakwyRTIrRzdYamdmZTZqZlJkL3RCY0dU?=
 =?utf-8?B?U0xiTzQzZDVSRGpYT3BvcHhERVlHcXB5aDVrNTVTdEdWRjYzUElydWJtMjEv?=
 =?utf-8?B?dTRyWS9Zb3V2MVdLNzJKWjlhcUlpQ2VGQjczSVZvSmxGTkRRYVNCdzJmUlN6?=
 =?utf-8?B?WU5GU1A2aFBGZEZVeGx5UmZmb2pGem1HVHptMjRkMWtWZW1xTVc4WDlIMjA5?=
 =?utf-8?B?Q01YSVpNZlJ5MU1SNThOSE9XamllS3RaeGpZa0xPbkphSGlUUU1GMVo0bEZm?=
 =?utf-8?B?c0s0SlRFZDUvK001QVByQTNkS0Z1Q2t1YkhJZ21RYnRWSHdoZXp4OHh2dHpx?=
 =?utf-8?B?cWIzQnMyWFNXU09GTXFMMDEvYWpZK1g3dzZBTWd3enBuWHN1YmQ5c3lvaWRv?=
 =?utf-8?B?dTBVVlRIb3VqTWxtcW9NR25WVG55c2UrdnFjZ3F2ekdsdEhuK2xBRkc2T2ZS?=
 =?utf-8?B?SG9OWUdPcnYwenpLY2pLY3pxcXFUdi9CcytMQjk4aCtOZkVRL2ZjWFVaeXZZ?=
 =?utf-8?B?Y1VlMHBNN3ZpcU5Ma2diWFlCamhQbVBoOE9MMkp0VzRhbjdaeWN5UTBISnBC?=
 =?utf-8?B?b1dFRUJHeU1sYjJ5alJFQ2tla3FIUDdrYzRya3llWndXNVppYmlONHpDQ3Bj?=
 =?utf-8?B?R1ZXM2UyZXI1QWM2UnZSTUdJYk5kWDBjMXJhR3U4S1RHNVg3ZDlCOVNUUVE1?=
 =?utf-8?B?Tm8xVEgzbnhnaTYwZ2VWOFBtYWFqVlhlaWNldm16NHBZODRVSGJXOXFlckdj?=
 =?utf-8?B?ZU15YUZIUEVqcnpLVTR3V1diUjRZelp0aFdOS2dhYkh4WkVEV1pqSERGRVdq?=
 =?utf-8?B?UnBRbHlYb3JlSHUzV0o0VlZBYWRoOWNFSi9aRFNpaUZGdnhwNFB1eFlidVlU?=
 =?utf-8?Q?xy/fqQqFUvZCa1w1Es?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf00b754-e703-48e7-5dad-08de8ff40d55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:39:09.3689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AApu1b9rF+IyGCu2uK2bFEzeELjY1Y/yBdtaP8HJdxKtbrF1yk55FCvFAC7pBJJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

On 4/1/26 12:05, Prike Liang wrote:
> The correct fix is to tie the global xa entry lifetime to the
> queue lifetime: insert in amdgpu_userq_create() and erase in
> amdgpu_userq_cleanup(), both at the well-defined doorbell_index key,
> making the operation O(1) and resolve the fence driver UAF problem
> by binding the userq driver fence to per queue.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> 
> v2: clean up the local variables initialization. (Christian)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 +------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        | 11 +++++-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 10 +++++-----
>  8 files changed, 28 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 49e7881750fa..8bc591deb546 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1045,11 +1045,6 @@ struct amdgpu_device {
>  	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>  	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>  
> -	/* xarray used to retrieve the user queue fence driver reference
> -	 * in the EOP interrupt handler to signal the particular user
> -	 * queue fence.
> -	 */
> -	struct xarray			userq_xa;
>  	/**
>  	 * @userq_doorbell_xa: Global user queue map (doorbell index → queue)
>  	 * Key: doorbell_index (unique global identifier for the queue)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0c0489395edf..a7b519f670a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3757,15 +3757,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	spin_lock_init(&adev->virt.rlcg_reg_lock);
>  	spin_lock_init(&adev->wb.lock);
>  
> -	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
> -
>  	INIT_LIST_HEAD(&adev->reset_list);
>  
>  	INIT_LIST_HEAD(&adev->ras_list);
>  
>  	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
>  
> -	xa_init(&adev->userq_doorbell_xa);
> +	xa_init_flags(&adev->userq_doorbell_xa, XA_FLAGS_LOCK_IRQ);
>  
>  	INIT_DELAYED_WORK(&adev->delayed_init_work,
>  			  amdgpu_device_delayed_init_work_handler);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 6b33c2428b2d..87560c1251d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -81,7 +81,6 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  				    struct amdgpu_usermode_queue *userq)
>  {
>  	struct amdgpu_userq_fence_driver *fence_drv;
> -	unsigned long flags;
>  	int r;
>  
>  	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
> @@ -104,19 +103,10 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  	fence_drv->context = dma_fence_context_alloc(1);
>  	get_task_comm(fence_drv->timeline_name, current);
>  
> -	xa_lock_irqsave(&adev->userq_xa, flags);
> -	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
> -			      fence_drv, GFP_KERNEL));
> -	xa_unlock_irqrestore(&adev->userq_xa, flags);
> -	if (r)
> -		goto free_seq64;
> -
>  	userq->fence_drv = fence_drv;
>  
>  	return 0;
>  
> -free_seq64:
> -	amdgpu_seq64_free(adev, fence_drv->va);
>  free_fence_drv:
>  	kfree(fence_drv);
>  
> @@ -187,11 +177,9 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>  	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
>  					 struct amdgpu_userq_fence_driver,
>  					 refcount);
> -	struct amdgpu_userq_fence_driver *xa_fence_drv;
>  	struct amdgpu_device *adev = fence_drv->adev;
>  	struct amdgpu_userq_fence *fence, *tmp;
> -	struct xarray *xa = &adev->userq_xa;
> -	unsigned long index, flags;
> +	unsigned long flags;
>  	struct dma_fence *f;
>  
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> @@ -208,12 +196,6 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>  	}
>  	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
> -	xa_lock_irqsave(xa, flags);
> -	xa_for_each(xa, index, xa_fence_drv)
> -		if (xa_fence_drv == fence_drv)
> -			__xa_erase(xa, index);
> -	xa_unlock_irqrestore(xa, flags);
> -
>  	/* Free seq64 memory */
>  	amdgpu_seq64_free(adev, fence_drv->va);
>  	kfree(fence_drv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 78d1f3eb522e..e97f487c419c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6488,14 +6488,14 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>  	DRM_DEBUG("IH: CP EOP\n");
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct amdgpu_usermode_queue *queue;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
>  		unsigned long flags;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
>  		xa_unlock_irqrestore(xa, flags);
>  	} else {
>  		me_id = (entry->ring_id & 0x0c) >> 2;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index a418ae609c36..65c33823a688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4854,14 +4854,14 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
>  	DRM_DEBUG("IH: CP EOP\n");
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
> +		struct amdgpu_usermode_queue *queue;
>  		unsigned long flags;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
>  		xa_unlock_irqrestore(xa, flags);
>  	} else {
>  		me_id = (entry->ring_id & 0x0c) >> 2;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index db49582a211f..68fd3c04134d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -3643,14 +3643,15 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
>  	DRM_DEBUG("IH: CP EOP\n");
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
> +		struct amdgpu_usermode_queue *queue;
>  		unsigned long flags;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
> +
>  		xa_unlock_irqrestore(xa, flags);
>  	} else {
>  		me_id = (entry->ring_id & 0x0c) >> 2;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index b005672f2f96..0f530bb8a9a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1662,16 +1662,16 @@ static int sdma_v6_0_process_fence_irq(struct amdgpu_device *adev,
>  	u32 doorbell_offset = entry->src_data[0];
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct amdgpu_usermode_queue *queue;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
>  		unsigned long flags;
>  
>  		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
>  		xa_unlock_irqrestore(xa, flags);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 5679a94d0815..9ed817b69a3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1594,16 +1594,16 @@ static int sdma_v7_0_process_fence_irq(struct amdgpu_device *adev,
>  	u32 doorbell_offset = entry->src_data[0];
>  
>  	if (adev->enable_mes && doorbell_offset) {
> -		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> -		struct xarray *xa = &adev->userq_xa;
> +		struct xarray *xa = &adev->userq_doorbell_xa;
> +		struct amdgpu_usermode_queue *queue;
>  		unsigned long flags;
>  
>  		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>  
>  		xa_lock_irqsave(xa, flags);
> -		fence_drv = xa_load(xa, doorbell_offset);
> -		if (fence_drv)
> -			amdgpu_userq_fence_driver_process(fence_drv);
> +		queue = xa_load(xa, doorbell_offset);
> +		if (queue)
> +			amdgpu_userq_fence_driver_process(queue->fence_drv);
>  		xa_unlock_irqrestore(xa, flags);
>  	}
>  

