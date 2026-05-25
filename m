Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C9DCD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 19:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC39A10E1EA;
	Mon, 25 May 2026 19:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tYOuP8/O";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7932310E3C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 19:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPN+ws2pX2T93h6OA0UsV5rgQG0XmY4Of5/4+e0NYJHRn13KCfUfbeqkLAjvDyhqWf4bdU5J8mHWDXFctxXllkRo7q5j0iHFascxz+wljjzVTaOOo7dQzOa/cw2IhPHTIjpKw9EdRuMDRJlbC+BYDix1Eg/LXhSNiYoIu5IaC6ldWhKzIbCYDMgLidpPpAFIY2TU4hAdlI76GEDfjXvVV1+Bjn/F8DzPiGkuxC6aqO7jkY4LSe7Nf0fz+O4saUXPoX3TSOZ6DUciS8OPlUKQB/fhGxOGpb3QqP03G2H3ETt4gbGU6emdVNz2KmYqQSQINTvkF8vd4Z9QIS/bitSKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXTSXQWcZwXQWjpxLkz8LLTzoPfjS3P3tdkakNAqYAc=;
 b=imMLDNmniWHIeTUJ7QafBxzoy251Q6Jo+PaRfJw4VUyTunblnJSfQF9SXPO8ufcXqHB9N+ZY8o98gJhZkmdDZiG9WbKgS5kJ1R+s4g/nn5Xs79kfrGroCCqP/UtJIb3uRPp9gZd9MS4qFXcCS9Mv/OjJ3QaXlBXOs4Jvw2AsbeDswUyfYVy+Ein7NQfz7vu2SIRxAGqXwZThFABiSJ/q8NaeCsMQUv4GokQ+fODvKh3JxgijlC84xjl0ekgFDmoeDiaPw/ogwbymYtK3wbCHeEGz9M966tmfYopRszwjbCMngn0n+1QVjMeGQ2cJCZikrh4U/Q6MApKtSDjmGMPXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXTSXQWcZwXQWjpxLkz8LLTzoPfjS3P3tdkakNAqYAc=;
 b=tYOuP8/OmVfa3B60CQfLOapk6U49FJCiZROgACFaqf0Fbd+IIo3rMfyzcpRBKrDPrsccdqkxsy76uqs1khv/3u+/Jyk1yTpHAkQYdproYHGP9oy+SmIZP50lD0eHDhTD30ubMK4f61PBzpeCw+5ro3z1I4MtO2NbnHVfXRrOLXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 19:02:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 19:02:23 +0000
Message-ID: <53d1f30e-96d1-48a8-a933-c922439e9cdb@amd.com>
Date: Mon, 25 May 2026 21:02:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: implement per-process MES context
To: Zhu Lingshan <lingshan.zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
Cc: Ray.Huang@amd.com
References: <20260525082359.5510-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260525082359.5510-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: a426a4f3-0fd2-479b-c2ae-08deba902733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: zbPGDW9PB+/UoFg6v37rDBaDYgE+aNHI/Vp+bDb+RSgnorwHY/+2QIs7iOuk1CUEtelMETll1WqaEZsEW5slegl9F+iBCv6dCBAXujdh5CZl/rnGVeNAIGVwWriueiWTmgAR9GgPDFXQOa8SoiGxUeHNoCSIyN79swZ9jX9O7H5blj3iiNJaqKlDQc3jCyi7cREUpt+inDIinzfSf2MymYg4V1yQYXg0FsaGD7oMVMhCzVbBDAHS8To7XzU6fbkCy5qUU2Ue9DCuKaVuFidJ/5T5bKJv13Epj/NXx7+f9ySD86vQwD5HFf2qgM278+yk/wxPHf7aA4YucLO0AJ1ym1Oo3xa0Qpbs2ImfQos6EhiNDW+wAKg+RCvA38OqI52e3uB8sq9BFGYzZmj5DwyczJwr560tipc0pwJ4ytefNA5ZkcnGKZyT5tAG2h3jpIvwl8lWkqeLP2CQwOIsHh4yJ5JU30LpI8pCG5RgYTVMMTwTyqTmu2YT1HU/P9Boi2RYLFEZR1vwnLg0ejtAoyGMI2z0qq8j29fl+JDvn4T97Okm+LlHguWnwvpZoOQirkbxU8tXrzqT5q6kD15ECqnhR4Eqi3anUFvsz4f5gO3hj8q3SB1e6XBEc8ai/VXeNAiD1otQjqn58b9xakTBSXawjOka2RSZISPo4Kep9b7MeHJtWHK0qsx/OEfcypRnwxB6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRuV1k0dlRZeklrcVIvTW01dDNXZnlubHlFY0NIcWJkcTFoYTJaN0xZMysz?=
 =?utf-8?B?YVhmTVgzdlRQamJielJXMGdHWGJRN1ExY21neHFGbUhaRVFoQUNjYno4am1m?=
 =?utf-8?B?Wks2SU1RdXpBQWhObGVuUHdlOXVmZEhWbFg3aExBYmtHTXcxemJWR1pKSWdM?=
 =?utf-8?B?MFZsN0JYZ0psNXA3QnVzVnpkSTdVb3hiKzlpUWg1dDd2YkVFenBtU2ZibnUz?=
 =?utf-8?B?MSszbExNUmg4YUZpREM1RzVBL3kwTkN4VEkzaGxvbXBndzdWc0JReFEzakYz?=
 =?utf-8?B?dmMvbThVbWtKa2VUQnNPNHo5VGNwcHZmSFFNc0QyclhDQ1RkaWtsYktDYXpM?=
 =?utf-8?B?SjJnVmtnTWxrNHJpdDlaVzN0dTJTTGc2VDM4U3ZZdnBKc0xQSFYyeXAvbzE3?=
 =?utf-8?B?Yk04SzA0K0J0Z09yWEVhMFVaSEYxWlp3bGF5cXU1a2R5cmFzQ1Y2eER3cVY1?=
 =?utf-8?B?UHlrMlUwRlBsZEp0YTI2WjkrVGpaVGEyVkRMTHA3V1F4endCWEZsbHNITHZD?=
 =?utf-8?B?ME12dFhKSVJOTlU4OVkvTjcrWVJ3TzRwYk0rOUNXRHBUcDJ0NnZGdzErR0pJ?=
 =?utf-8?B?MU54bVd4dzFpN2liT0RsMmcvS0JNeDRjOWZXMFZLcFJmSDF6RXdkeHk0MkJR?=
 =?utf-8?B?YlpNdElIaUZiVW45QURTT05yQm4xYitxanZQanZRb2lnZmZKZ1dyZHhzY3dY?=
 =?utf-8?B?WStwblFMU2d5c0FrY1FpTGNlSTE1MHk1RXREYzM3WFVuNVFwZ0ZhbkthRUg1?=
 =?utf-8?B?UjYxUmJQYzVBd0NvcXZvMDVrcnBrUmRPZVhPeGRQNWZ2QWFuRm4yTXAzekJa?=
 =?utf-8?B?QlI0ejRLRmd2SVhYNkM0dFluL29DN3gyOEVwSTZvREgrNEFjVG5nU05QdkFl?=
 =?utf-8?B?b0RvSHBGMzkxUWtZRmRYK2F5MHRmOWhwQTI4N2tJa3VhaGxLd0p2N2hQdk0r?=
 =?utf-8?B?L1NqUUFCaFRmNENFb05ublUrQ09QSU1ZbWZYTTg0MytSL0dRMFFQbmlSL1FX?=
 =?utf-8?B?cXl0cnhmQldPbkJGT21zallleFc0eTIzZWZaMEx0dWRiRkY0YkpTTlNXYnJj?=
 =?utf-8?B?aEZIVm5ZeXpNUEd6dXpZZFRYM1lXQW5RRlgzRUdSZW9EeWlwZHo0TjdvL2Zs?=
 =?utf-8?B?Q2VtSit4MlJxRE15UlpCeHpsNzdnME9IOVlPMEk0eXVlaHRGWlEzeHVCL3VQ?=
 =?utf-8?B?eEo1MXFRZFB2VmtyT2Q1UG1qWEVGN3BhNThBdFpYblJXNGVPbk9jemVSVDB4?=
 =?utf-8?B?RURNa29Fd0lBV2E3NnZVcDNDSU1FdVhwNm81OWg1ayt4aURhZkdMNE9uMmFn?=
 =?utf-8?B?R1pVL2tFOGx6SzlsMUUzSWdWWExQQzhVOFArZDlxK3ZrUWdiTHZPdUUxaVF3?=
 =?utf-8?B?czFMekM2eUlUR2RPSVd2T2xQdGNaQlRsYjJuZ2JqMHpNOU0yTUY2WU42blgr?=
 =?utf-8?B?bHBveUhoMEVRczIxNlN0WnFGS0NEcVpuS2FFRGRCYVJlSjFPQ3Y2aHRMVE1W?=
 =?utf-8?B?a0dVLzVNMmtUdXlHWllKZU9YbSt4bUJseGVGOHl6MmVncVR3NnJMb2FqZDQ1?=
 =?utf-8?B?T08xTTBMRWRseTFWeWNvcEtLZnhhVW84S1NSVy9CZFFXdjlJTEhpZEY4YllG?=
 =?utf-8?B?dTd1WTZGQ2NSR0tjQi80SWNFRGJ4REZxRXlLRWhHSm5oRHRNa1FYekNMYzh1?=
 =?utf-8?B?aEdtT3crSmJBQmVyZWlaOUlWU0ErS2trVDdPR1JvbXRCckRGNVdKRXA1b01Y?=
 =?utf-8?B?bDFGVUpra0NoWWM5SVBWMUVGcDhFc3E1RG9yVDlIR0ZjRWVSNXJBaExVZm5S?=
 =?utf-8?B?SFlWVEx1aXlJZ25OcjFKY3JoT0d0NHNqcTZydmYwY0psM2x6U3JXM2loNmVq?=
 =?utf-8?B?RUFINk5WdHZQWmh6aEVUL0pqMDVvSDJZOHdXQVNtWVB3cmJ3QlRYSkxlaThw?=
 =?utf-8?B?YzBRN0cxd3k4dlNLZFVZNUUvaXFIUmJXQkRKTVlMb3kvZFhvRVR6SkJoa1pN?=
 =?utf-8?B?dUJpdmhUZTVtUlhmZTd0SEZJWlk3L3dWeGxwcDVvcm5CQWdmbzZnNndKVmJW?=
 =?utf-8?B?L1k3OTV4eUZzRmo0OSszeXFYUVZ0NXMyTWRZVDJNN1lNN2NNYUo0Lys3QmM1?=
 =?utf-8?B?T2x4alpxN3hQMUUvRWF1SUlXR0NtSjBFQzI3NGZDaExwU0x1MndZaUFhSkYz?=
 =?utf-8?B?c2tLQnJZelFSWUdKZWpsckFWd2UraHc3dVhoSkFjdmVpaWV5NjVpZ0JRSEZK?=
 =?utf-8?B?Y21VU3FmWERuSWVKdml0dUZ4eVdwNjJuK1EwNlpFRWdLYkI2SmRyaHlhTU00?=
 =?utf-8?Q?omYvxoEixF8tVSDrwZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a426a4f3-0fd2-479b-c2ae-08deba902733
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 19:02:23.0631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjg4oiqXuYWQakBP/tvCIVcfOZqPSK1HglmQdVCxWzx4igw0l7zidvlHVCzsu775
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
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



On 5/25/26 10:23, Zhu Lingshan wrote:
> MES process context is a process-level page
> where process specific context is saved for
> MES scheduler.
> 
> However, current user-queue code path assigns
> fw_obj of a queue to MES process_context_addr
> when adding the queue to MES.
> 
> This means every new queue from the same process
> would replace the previous process context address
> with that queue's fw_obj address.
> What's worse is, when user space frees a queue,
> its fw_obj will be freed as well, causing MES
> working on a NULL page pointer.
> 
> This issue leads to inconsistency and crash
> in the scheduler.
> 
> This commit allocates a process-level page for
> MES process contexts for a process other than queue-level
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  5 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 48 ++++++++++++++++------
>  3 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 38e310a8694d..0c4d6f80616e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1225,6 +1225,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  	 */
>  	cancel_work_sync(&userq_mgr->reset_work);
>  
> +	if (userq_mgr->proc_ctx_obj.obj)

Please drop that check it is unecessary.

> +		amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
> +				      &userq_mgr->proc_ctx_obj.gpu_addr,
> +				      &userq_mgr->proc_ctx_obj.cpu_ptr);
> +
>  	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 28cfc6682333..fe85234e58b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -127,6 +127,7 @@ struct amdgpu_userq_mgr {
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
>  	struct drm_file			*file;
> +	struct amdgpu_userq_obj		proc_ctx_obj;
>  
>  	/**
>  	 * @reset_work:
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index e9189f07c6dc..3022025bc2ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -133,8 +133,8 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  	queue_input.gang_quantum = 10000;
>  	queue_input.paging = false;
>  
> -	queue_input.process_context_addr = ctx->gpu_addr;
> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	queue_input.process_context_addr = uq_mgr->proc_ctx_obj.gpu_addr;
> +	queue_input.gang_context_addr = ctx->gpu_addr;
>  	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>  	queue_input.gang_global_priority_level = convert_to_mes_priority(queue->priority);
>  
> @@ -169,7 +169,7 @@ static int mes_userq_unmap(struct amdgpu_usermode_queue *queue)
>  
>  	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>  	queue_input.doorbell_offset = queue->doorbell_index;
> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	queue_input.gang_context_addr = ctx->gpu_addr;
>  
>  	amdgpu_mes_lock(&adev->mes);
>  	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> @@ -186,12 +186,8 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>  	int r, size;
>  
> -	/*
> -	 * The FW expects at least one page space allocated for
> -	 * process ctx and gang ctx each. Create an object
> -	 * for the same.
> -	 */
> -	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
> +	/* The FW expects at least one page space allocated for gang ctx. */
> +	size = AMDGPU_USERQ_GANG_CTX_SZ;
>  	r = amdgpu_bo_create_kernel(uq_mgr->adev, size, 0,
>  				    AMDGPU_GEM_DOMAIN_GTT,
>  				    &ctx->obj, &ctx->gpu_addr,
> @@ -257,6 +253,27 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> +static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	int r = 0;
> +
> +	mutex_lock(&uq_mgr->userq_mutex);

Clear NAK. We can't allocate anything while holding that lock.

Please add a different lock to protected the buffer or just oportunistically allocate it with CMPXCHG().

> +	if (!uq_mgr->proc_ctx_obj.obj) {

Please drop that check, amdgpu_bo_create_kernel() should already take care of that.

Regards,
Christian.

> +		r = amdgpu_bo_create_kernel(uq_mgr->adev, AMDGPU_USERQ_PROC_CTX_SZ,
> +					    0, AMDGPU_GEM_DOMAIN_GTT,
> +					    &uq_mgr->proc_ctx_obj.obj,
> +					    &uq_mgr->proc_ctx_obj.gpu_addr,
> +					    &uq_mgr->proc_ctx_obj.cpu_ptr);
> +
> +		if (!r)
> +			memset(uq_mgr->proc_ctx_obj.cpu_ptr, 0, AMDGPU_USERQ_PROC_CTX_SZ);
> +	}
> +
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +
> +	return r;
> +}
> +
>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  				struct drm_amdgpu_userq_in *args_in)
>  {
> @@ -429,7 +446,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		goto free_mqd;
>  	}
>  
> -	/* Create BO for FW operations */
> +	/* Create per-process MES process context BO */
> +	r = mes_userq_create_proc_ctx_space(uq_mgr);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
> +		goto free_mqd;
> +	}
> +
> +	/* Create BO of a gang for FW operations */
>  	r = mes_userq_create_ctx_space(uq_mgr, queue, mqd_user);
>  	if (r) {
>  		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> @@ -492,7 +516,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
>  	*fence_ptr = 0;
>  
>  	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	queue_input.gang_context_addr = ctx->gpu_addr;
>  	queue_input.suspend_fence_addr = fence_gpu_addr;
>  	queue_input.suspend_fence_value = 1;
>  	amdgpu_mes_lock(&adev->mes);
> @@ -529,7 +553,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
>  		return 0;
>  
>  	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	queue_input.gang_context_addr = ctx->gpu_addr;
>  
>  	amdgpu_mes_lock(&adev->mes);
>  	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);

