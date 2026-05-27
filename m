Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBD9CD5BDE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 06:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0DE10E168;
	Wed, 27 May 2026 06:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ayV8jJX";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8532910E168
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 06:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkDDTnCJ51TA/Jd58RpMUqmB4QCKXfoi1yPqqyjBFH/s7K/z99doeDh5rO8flzt7PBx2psfy7mBUiKyH2DEPfGQBq32maKriH0309+chEQ8AwUlhC6/jxsybyXoEI/YzEd4pNcYoEzoXllBxj1z8PWq6Utjd4jIQ82LKOTWhUbTkQM2achrbk44Tnt2Ninkp07pOyL1oHkrl44lrUPedXTqdxts+R8cEZBriyuRrynmlKMddTkzlpjyG/K7go5/9+/EmnM4L9m6A1+KpnBIleRCOthUmtHAYdvDs7iCkGolSPm5r1nx9UVWS8Q1Kg2blCNFJcf9Z2Kh1vjWrGIPgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peWW25fho3NVFtFhpk/cUcIGdazCvxIro0rLtblsoPc=;
 b=FkRlu1el7zYNEYLPEEKggLD8pOCNaeiuLF7aKIdY9/SWoJXZwj4FeKj45NftZ23AtWPGGCTZmXmdbDknBhJzJMLvEkoRFC17yx7lPhJfC+bHeW9T7YtZhskdJ3lqcqXYcquzjPXmk2mw+Z6lfcKapajzAO+7QBUXO8o/B1cIAq8QxXlh/3KdXrHEB8+D19OPGCZLVTSkrjpGP0lRo23TrA3g9n8cNrUYRb3WSoQSongNon7X3sB9BHs3Vh1YizPJox95NBNFbKi5+MVHXWholDGQkyiN/37X4Z4K4fEhv3sFgijEuHGpCxhyKqQzP+DrCMKcrCpyUFwn1PPbt+mGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peWW25fho3NVFtFhpk/cUcIGdazCvxIro0rLtblsoPc=;
 b=4ayV8jJXcvoYRPRTuCMHyq9SGrLP0S7GEfMbvi51P9qx8rjJ5wzDHdhJsH4SoFhk534M2nip28MWrQ7Ar0IUw/a7p8twypm1GMFQC1RNLAYJqxzGt1/bbzZzf1WbCpkYYEhe4mN/VeQZovMl2LF5IK93vpICTyJ821qYstL6ZsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 27 May
 2026 06:35:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 06:35:30 +0000
Message-ID: <7b50469a-b292-4af0-8d55-daab9cd6ba97@amd.com>
Date: Wed, 27 May 2026 08:35:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: move wptr_obj cleanup in mqd_destroy
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260525045137.4027378-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260525045137.4027378-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d54913-fe91-4b75-7f34-08debbba259a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: doIBS+kKX/Wnfpz6v5YLsb4gEL/XoBR0we/JAfZUT7BEBCgJXNoQZHvcSh/29as8b/ZEdLyIAnyUposMmLxxNqzHEttTmxUkGpH9/AW1imz6J5MM2dKiEHcAZnIzlGKjsxItmBp4Mko4MVpV1twe4NWvak7Y60Hs1Mp9KZes9h/qMP1wP3knQexBCtQAmn0TajJtiKQ82hsX36rkFpkf5MemB/P+hGiy5B7biIkv0uYHS2A/iJYr8cpKh+BkhRmsWnTQwq3CIhRFnU7dunR6kBCXJuTM90tC2JLCzarFaP5To/v7ptShJ2Or63c0SaRaq7LXPR+45tiPRNF5YRMhw6mhZIar9fPS6RUwKyV24/OaRo1zClrYXDZjlxSJKLo/vliWUsf+E6XQcfE45BJsSKc8LlQM0UOWDlrAyxC7D2UZMnSCfsG22FXOShYXBTaYB2MvmzFmty4qZILf1x57fRnP/ZV9Lt+O1njv/Dpd7dJnN0/gCEzox6j7oso4VOpK1ehOKlUoVUc9tj3SIhm4BYgFn52/Yx3kskXotDvUDs8N7L/DqO6mjLdIQuWyntQn7PrPtl8c+VxvXny3j1pqQrXUSP45Vezfm3Q4FkpIb+x1fsQJkcMbwtneT8VSH98yPF8rehhclnQBmlkKgO3N4qmG4aRHlt3Um6nyoJ0QATzmkYQ6qwe02QHYV5Cnqe7S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWU4cHRIMmc5eWlIQVVLVVFWckM2NzdkNHQ3ekU3SFVvQ2thMGc4Y01WNWsy?=
 =?utf-8?B?bUJJS3AyRTdxelZ4ZDNYVFVYVFhGS0p3a29MSkdPdVpwajc3VElNcFhLSDlo?=
 =?utf-8?B?TUgvVlhRL29wR0J3Q2dhVjlMNlY0aFJuUzNHZnl6WVBuMFU4QW1ybUNHei92?=
 =?utf-8?B?VzNuKzUxeWl0U3pCMDJSZEVjTDdidFQzdk9xMG5yZU9zdkRsVytkeHczd25K?=
 =?utf-8?B?NVJzdk1lS0QvV29LTlZ0NkNZNERCNW5xSE5NT3YxMEVIVHlhRUpOSWVJbGhR?=
 =?utf-8?B?cHFvR2NRTkxFMi93SDRIcEVDOHdwL0ErUXFYNUZ1QzFpdzhIdFRwb2JvaVgw?=
 =?utf-8?B?TjU5eitNT01sN2pNekpJV1RVRmdOci9RTVhqcTNIb2ZvbHRDWWU0NWxKRDFB?=
 =?utf-8?B?R3RoWG9wYmxuUjQyWXEwQjVmaG44TFBWQlJXTnZGSWlOSndxbHllVW9GLzI1?=
 =?utf-8?B?NXRmSWJZdllIWVdzcTg4bTVqTmJCT3lpME1aczgxZk92U3haMFY3djVrWUph?=
 =?utf-8?B?YjFqbUd3b1dvL1hYM3FwRjF3c2xRWlQwWlpTa1pyZEtZMVF0a2RENHU2V2xE?=
 =?utf-8?B?Q2toOXg2TklaNWhrcTZDU2l4cTI4VUdGWEk1MzhNd0hJS1M4MUoweFYrZ09n?=
 =?utf-8?B?bGYyN2dZbzBkQytqdW1HOVBMQStvaHBwOERudWVlQlZoNWl6UHNmaDd0Ykpx?=
 =?utf-8?B?dHlXekZSaUlnaVEzM2ZmQ09HSG1MK2E3dlRVSmdkNmlXb0JHRUFCaUhveXhk?=
 =?utf-8?B?WG5UazhjSzVsSHgwRzhXS093b3o1dWp0MlJXbXJ0cFRTMWp1TmxVR3FsTlpp?=
 =?utf-8?B?NjFyK3ZoaTg3a0ZWMkJyeThmMnVPZnNCa21uanJUWVhEbHd0NnBrUGt3WWlB?=
 =?utf-8?B?YVJHd2EvY00zdytoeEFZdGloczNwZVl0N0dnS0cvYXgzb0VXY0VTaVQxcVA4?=
 =?utf-8?B?SXEyYWZ0TThuMDFLVitNQzQvWEtlNElzZVYwenM4Q0x1Uk4vNnFCc2FCQWFD?=
 =?utf-8?B?eStuWUpmVDBzdmlpS1NlUGk3eFNQdm4rY3RsQ3RCRTMxRk5OcWsyN3JCbjBv?=
 =?utf-8?B?UVV3MnlIbThUYlFRMW1UbjBqdWt6R2RvcHdEa0VzVThIQnUxaGJDRlZaNG5I?=
 =?utf-8?B?S25rNStTU0lwWkkyU1gxQmZJaGVBYmJzTG5nSHlwdnBUOE1XODFINDZhMTd2?=
 =?utf-8?B?MVA5UVkyU09NNlI4RkYwbk9KWmZqeEc3VWlrWmxBanJhK2tGUlVYUjd4dk16?=
 =?utf-8?B?Tk9hbytPNlY5Mzd3Mkg5WmsrVTVCNnBudW5CcmlGNXJhVmdDVUdVQzdObHZx?=
 =?utf-8?B?TkU4c0dMamUvbW1OaHFBZEJ6ZU9nejUrb3d6R0dJaEhCcVZxb1I0eDA1L1hu?=
 =?utf-8?B?bDQ1VzNEVjdRS2xKMGlTdmQ3ZVNiV0Y2a1JCcjUzTnJIYUNtckJNVjFUaHNX?=
 =?utf-8?B?Y1lBMUxSS0xDNzlDcFNsZ0xMOW5pWXBFbFUvKy9Sb21iZmZCYndOY3BEcmxh?=
 =?utf-8?B?T0Y0UVRIWEVmSTk2NzBTZkR3MEtCdkRwclBST1E3eDE5ZXRoWVkxUGZmRVk1?=
 =?utf-8?B?bkQ2T1p5ZURyUVVjbTVQaUVxSWwyQWZPcU1EeXp2WmRxV0MwcFNpMHk5VXk1?=
 =?utf-8?B?QUh3L0ZERXJtNnFCSStDRkl4Q052RmRYMGRJelBwUnNSY3ZBUGZJeFdQZ0Z3?=
 =?utf-8?B?WHFrMXhUakkvbC9ReDhlb1Z4UDlCSHYwajU2YlRNckovaG93ZVBCRnZRQmxm?=
 =?utf-8?B?TFpWZDI4VG5STWR5OXdhMC9xOU90a2ppYkRsK3hWMXJhS0VneTVKVXhhaTFV?=
 =?utf-8?B?Q01URXp0N1dFQjYwcW5WNDByZ1pCTzk4eFVjZHUrZjBIcklGY202bmxTQlRG?=
 =?utf-8?B?dU0zSm84MzdzT3hJSUp5ZmR0UytPMmM3S3c5WFIyRUhvWFJxZWdsSk1jdERX?=
 =?utf-8?B?WXQvdVo1Y3NXcWJwbVBVRFNjZ045YjFVaGJ2VWlIUjlpbFhlYW5lWjJ5OVdY?=
 =?utf-8?B?VmtzRkZTWnR5YXZSSTh6TTV3SEdpeDZZNjVkU2xMcWVOTjVRVzh5d3kyK2xI?=
 =?utf-8?B?NVMzc01PaWhpejhZZXcydlpBcVkzNEZBQmhUQmY1UjZDR3F5M1JoRjF2aHg3?=
 =?utf-8?B?ZjJvZ2FIamg2dFJjWnpYTjluRGpvenB1VC80NWhPNUs4SGJkM0JMUmlFb2pl?=
 =?utf-8?B?OW5aRUNLa3EzVGdWQk9Zai9WaFZLRGROUXhvVThmS3BCUW9LYytiZnZ1MEd6?=
 =?utf-8?B?ODc5WTIrbzgzejBxNWdEbk5NdldQTW9Vck5hTVRnOE4yMFQrQWtHVkFIR3Qr?=
 =?utf-8?Q?FDWAOfdITG9ksOoiO1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d54913-fe91-4b75-7f34-08debbba259a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:35:30.4089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avLVF5aQAzRw0jZT4UZG/riYBCOewRy8LewWdcxTQKe9CILfDg6pFd82fDRvFEYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
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

On 5/25/26 06:51, Sunil Khatri wrote:
> In case when queue_create fails and mqd has already been
> allocated and hence wptr_obj is not cleaned up.
> 
> So moving that cleanup part to mqd_destroy so it takes
> care of all the cases of clean up and during tear down of
> the queue.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 4 ----
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 5 +++++
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 5e361b035e8f..f0c7b686f68d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -534,10 +534,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_bo_unreserve(queue->db_obj.obj);
>  	amdgpu_bo_unref(&queue->db_obj.obj);
>  
> -	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> -	amdgpu_bo_unpin(queue->wptr_obj.obj);
> -	amdgpu_bo_unreserve(queue->wptr_obj.obj);
> -	amdgpu_bo_unref(&queue->wptr_obj.obj);
>  	kfree(queue);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index e9189f07c6dc..836a156cafd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -467,6 +467,11 @@ static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>  	kfree(queue->userq_prop);
>  	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
>  			      &queue->mqd.cpu_ptr);
> +
> +	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> +	amdgpu_bo_unpin(queue->wptr_obj.obj);
> +	amdgpu_bo_unreserve(queue->wptr_obj.obj);
> +	amdgpu_bo_unref(&queue->wptr_obj.obj);
>  }
>  
>  static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)

