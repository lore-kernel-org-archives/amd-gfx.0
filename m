Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59338C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 11:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C5B10E53C;
	Fri, 14 Aug 2026 11:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wlL2e+db";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 611F610E53B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 11:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMzpuv4pIUNu5axvI/0pW4KwadMzfcvPXtHkXlN4ANDeGoledAa8D3PpX9CCrNmQFyvUQyzT+iPKpXZDApFyrDDgTLBu/q7pZqyB1NqVkUXci0FpNjShOnMqR0xH6tCIfO/f6o2dxD+KLd5Ap2+spSYCOvCJxopC7tq6yQ7kxZMprXHhGJdBlcDBXa/rOvmtN7zpj6uhS8y+t/9vwNVMZBNjoEFcIFPsyifnBRDU+Q1pwhTSCjsLqil0qnkq9vYx7/0brah4jZk+SjFe2ohOakn1tTuLcjhKeRoKZNOXcHnxSOzGnfcJzMKyl4pgWHKLaYaJ9fEgRiUkPOzh4sMcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RevHv5V/UQckMhZvBHlcRfpNPR8h/worYYYRBSFfuH4=;
 b=KmMWx8YtbxtFh16gsDuCeE5FeBS4CxTeSa7jRK+Av0QKG/YMmr7QGJMSyED5TSjsZiZ6cE4SBDd0FXddj3GqtMnDFctD6TuFdWnm6yd9WbSuulOriDu+NnIHhk17WUl/UG0SN8iy9eWU3a9SygWPloNOBoCemO35STMsfLZTtyuFizgGy4rQQy8CmivmgXahLPFiOD7dtAQYhN2DZ6gNf6aqd18nVtSPGXRYp8hB7w4MfHQJy+0NS6AGwvVxiQjZ37t/M+oboubZ7ZZrgltoZBgnqzk/e6hB937oZchzq4dlQqK1iZSZResMGYf73lTX3RmBIcRAxGYpMWDLa928pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RevHv5V/UQckMhZvBHlcRfpNPR8h/worYYYRBSFfuH4=;
 b=wlL2e+dbOMwH+smfJuVo8T+pP+0K6+WcIweXyLDaybYFMOG3ftFOYA7lOlvFF8I5iw3KjihqLnil47c5Fm9V4vk6x81oDQat4H9LG66UYUF7vRRdYpclmK6AZpeSrdk8UUh55N0gMeFNIGYj1Qa2xsLcsSBTmC9/Au9oVhUft4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 11:29:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Fri, 14 Aug 2026
 11:29:58 +0000
Message-ID: <ec751f5b-e6bb-4c1d-93dd-f9d4418ab70f@amd.com>
Date: Fri, 14 Aug 2026 13:29:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: lock and validate wptr BOs before
 reading their GPU offset on restore
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20260814085626.80716-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260814085626.80716-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 790e400c-e3d4-4df6-179d-08def9f75f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JWEWEIiaWf8g4gltfOIVLGvKQry/owHzmLyTsb5Rbaojnwlz0FFdg0UxUHHOs5S4yykuqRqqFKnOY33Rh9ktOyRIA68jbIaKjBmot3OAjGxePP+NSNY4X651XNjmguqGwENCg1xGwCGB/hXBalvFWeOmhdXOnVivKKzNUAauIK90asbu4uDOoNzdrbUJhsZ1wXz3g1a4A42YhEl1i+g/W+TgvZcV7XvMYHwYWdohtzhdcx78oxpiAaCiBOI3iJ/SGaU7Rq579/BDmpzXPpz1/hWsnkW3OtXcLGsZfFkIdqkRr0skyR1p+aHepWZ0oBSLhpAkzdfqW0lMRBzG66/prDZBUI+3LtpqFy7ulZ07ElA3dZxEwZT5rd2KRHqzf5gl/KHV7LYp7eUK5b8EjyBprEJpgy9znfoVCCqCMsEBxmf3JJfKQiC7tu9WRDzefZGUQ8xpehBzfe7sGy4W+bxUSxusm4/DbFphxWAkE2bX/A7Vec3dkNYo/Lkgh54mOGSX2oOZL57gH9G54souAOJo2rMp+l7usAOLFKtFckSIwUg0F3GQ/kAtxemv+X37Q6rbaGKyyG09Arpa6t18LMsZdH2ed/5MJ/UKOurmpQGTtHAHWY9f2F/sHnJCe4HErsJGm1H3oBbNFY7v7PrNqyykxBkINwNlYwDeVQuzVcbb09A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXBYNHJSTml6eGt3ZEhYK1IrL1V2ZWlzczJtV1BJNGUzRk9VaEZLSi9UbS9y?=
 =?utf-8?B?L3JueXhnSDFGOEJ5Y2IxSFlUaUR0N1puM3Y1NzJ5OGVReUlnQWh1OFQrSzdN?=
 =?utf-8?B?emlQWWNTNzJiSEhGTmI0VVZ3Umw1eGwyNGdTbTk5Nkwvb2NxdDBIbDZPaUpZ?=
 =?utf-8?B?VkloZklmajNvNmo0WkZjajk1VE1ZdGVSMWw0RVVKcEpMYkhPeGtEKytLSkdZ?=
 =?utf-8?B?VzhnQWM5aXhSSWpNMExqSVpHZnpXcDhWcjh6K1k1MGVuNGN2K1V1WnZWaUxW?=
 =?utf-8?B?eGdHdTBYVHM3b3hwTzNLdC9TTnQ3RllVVDhyTmx0TjJzL2dVbTJ6RFNVNDRP?=
 =?utf-8?B?V3VxaEZYanUwdFRBbGhuZDZDTVpKd0x6SUdHVlZFQWNRakJsam1iNTUxdlZO?=
 =?utf-8?B?WEdSV1lEcE9VV3VHUFJwM0U4ekFoeVRIRm5HL2RyVzVBSmh0TlUxTUsyVTVJ?=
 =?utf-8?B?V3oyMmhpaDF5U0xYRjZpSng0UXB6NmdpWFpQMHVMcWJOejN2VEdyR2FZQVM5?=
 =?utf-8?B?VXQ2TUhHbnpUU0svTFI2NFhIbXVLUk1sZU5aQ2NNYTFNTnU2NjNBV3M1UTdI?=
 =?utf-8?B?ODZQRkkwTkxNNW02Vk5MRFZHSk93aVJMR2RvR25KTVQrdGp4M1ZINFh5eGp6?=
 =?utf-8?B?UEdQb0dWVjVpLzVnS092anlYZFdOamlIa2RjMjYxKzl2K3dOK2JPRjJzL0lX?=
 =?utf-8?B?NjIwdGFIUHMyUVZDakhGSHVteE45SUFlYTM1bHdib1VEaW9EYWZOK2g4eDh5?=
 =?utf-8?B?KzYwRHVtODBDak5SQjJreTVBL2xQU3RIU3g4bTRZMzNIUnFZdnIxWE9nN2hL?=
 =?utf-8?B?dGVqSDFOSnNoaWFnZEZISC9hYUo3SGZ3RGR1Z0p4VkE2QUhOSnF4V3IrdEFD?=
 =?utf-8?B?L09XcWd4T2pkdHBMYnN3bjJRcnlhK0ZkdWxxbnpIWjh0THpNT0hKMGNnMzIy?=
 =?utf-8?B?N0dvSEEyb0xjZnJXbnk5UVFRSzFLQXZ2MTBQdURVb2htbVBQUE5sanBJS3Q0?=
 =?utf-8?B?TmR3VGJoNnpUSFRMOVVOYXVvRVFoc21NMU1xY3F0bit0cWI2RW04dWsyMXVz?=
 =?utf-8?B?RGFpbGUrSEh0cEgzK3FnNVNndHExZlA3dzhZWXMwRTgxRGRidVN2WXdiTHJ5?=
 =?utf-8?B?TmFVR0VkZ1NOdTZ3eXp1RGhrL0lJenp2aENnajBJSDY3UnNwUHZXSjZPaVBm?=
 =?utf-8?B?aHdMQThJazRSR1VTYWc4REhUSGo4K3ArNlc4YmlreE53R05ZcVl3UnA3ZGxz?=
 =?utf-8?B?NjZvenl0cXUvVkZWMVJrWkZiZyswR0dVODVGNVROVGdKU09iaC95UmFFVExa?=
 =?utf-8?B?cmg4ZGwwTmIrRTdJcUxTUnlMbHN6MmdyaEU2b1JzbjBvS21PSkNtbWwwa21x?=
 =?utf-8?B?dDJMWHF4U2loamNXOWxTQWVrYUhjc2ZGdmRrS1o2OEtKeVlOOXJha1BvS010?=
 =?utf-8?B?MWR2b1dxSjI5NFlzdTUwTmVwSmZQZVJ3K25SVmtLdlk1d0ltRXFhL0o4amcr?=
 =?utf-8?B?T1o5MzJzMGlpdFJhVytKUGIycDBGV0VZUmhtdnVzd1NlRWhGYUppb0dOcUFt?=
 =?utf-8?B?aCsvemU4UzBQN2F6U3c2a0hlWjh6UUNJc2RHRzltcnBxUHhjRHFpOHZpSGF0?=
 =?utf-8?B?SGxzTW9pL1lKRm1idFlOVVkwWWRUVy9iRURPZ1Nvc091aDIyUnhRckFoN3lG?=
 =?utf-8?B?Y3lsOGw4UDc2MUpnY0NjeERUaXRBOUdITDVmRGlDVjJKcHVwL2YyWCtmeGdD?=
 =?utf-8?B?L1VjVXBua2V2eXIrY3RIVE8yUVo5c1I5dDVxcytScFVzeFowK0tjZ2FRZXdS?=
 =?utf-8?B?d3hTSWlocTFwT0Z5Q0FrL1ZvaE10UW1tL0J4UWdrY0xtK3VWMWtPODBTajNi?=
 =?utf-8?B?TVFQNkJCZEhJazc3Ynl5M1ZEQWJQbURpSE1lMWU2MXV6Q25vMXZDRVViNHVY?=
 =?utf-8?B?ZGd0MWEzemJHdElmUkxHZjlhazJETHVKVUtPQXJMdjlJVlAwRlpjRHVVVW9y?=
 =?utf-8?B?RXU4WEl3SlJZSlVnZ2labWRrTFhna0lsaHZZZlZub0srQ2szdlE0TlZIY3Y4?=
 =?utf-8?B?aHJQL2FlOWVGbmFmYTNEN2N3dXdONlRxb0RCbDJ0K3RYaFZtd2hTZmpjMGly?=
 =?utf-8?B?UFk2ZXMySlJ1SVYzcElFeEVOZ3ZINUlIS1RjdFAxbDhzZW5nNVFyb3h5cGNk?=
 =?utf-8?B?c21qMlJFNkplVUhWZkN0T1lqc3gwbWpCQUd0RWs3bHd6VlFJNHhjbUdkUkUr?=
 =?utf-8?B?eU9MdkNtSEFWVzdCZVlOQnM5VXZNWGR2ajJsRDNpeWgxU0xzTVF5SHR3WHpL?=
 =?utf-8?Q?QQA/EVSEVuhb9MUG44?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790e400c-e3d4-4df6-179d-08def9f75f30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:29:58.4395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeqrWirzM2MdcGTtqlxrTUqfKPz687mq1/YX0A33EtzZbZf1XpRn6qb1fc2AEVEA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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



On 8/14/26 10:55, Jesse Zhang wrote:
> amdgpu_userq_vm_validate_and_restore_queue() reads each queue's wptr BO
> GPU offset via amdgpu_bo_gpu_offset() after only calling
> amdgpu_ttm_alloc_gart() on it. But the wptr BOs are not part of this VM
> (their reservation object is their own, not vm->root), so neither
> amdgpu_vm_validate() nor amdgpu_userq_bo_validate() (which only handles
> the VM's evicted list) covers them. As a result a wptr BO can still be in
> TTM_PL_SYSTEM and unreserved when its offset is read, tripping the
> amdgpu_bo_gpu_offset() sanity checks from the restore worker:
> 
>   ------------[ cut here ]------------
>   WARNING: amdgpu_object.c:1486 at amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu], CPU#3: kworker/3:1/116
>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>   RIP: 0010:amdgpu_bo_gpu_offset+0x75/0xa0 [amdgpu]
>   Call Trace:
>    <TASK>
>    amdgpu_userq_vm_validate_and_restore_queue+0x629/0x960 [amdgpu]
>    amdgpu_userq_restore_worker+0xa6/0x180 [amdgpu]
>    process_scheduled_works+0xa6/0x460
>    worker_thread+0x13c/0x290
>    kthread+0xfb/0x140
>    ret_from_fork+0x1b6/0x2b0
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>   ------------[ cut here ]------------
>   WARNING: amdgpu_object.c:1485 at amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu], CPU#2: kworker/2:1/127
>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>   RIP: 0010:amdgpu_bo_gpu_offset+0x9a/0xa0 [amdgpu]
> 
> amdgpu_ttm_alloc_gart() only creates the GART mapping; it does not migrate
> the BO out of system memory, so the offset read is bogus (the queue would
> resume with a wrong wptr address).
> 
> Lock each wptr BO into the drm_exec context and validate it into GTT
> inside the drm_exec_until_all_locked() block, mirroring what the create
> path (mes_userq_create_wptr_mapping) already does, so that the offset read
> later is safe and correct.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 17cc48d87c4d..59aa4802c111 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1054,6 +1054,32 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto unlock_all;
> +
> +		/*
> +		 * The per-queue wptr BOs are not part of this VM (their resv is
> +		 * their own, not vm->root), so the validation above does not
> +		 * cover them.

That's not correct.

The WPTR BOs absolutely must be part of the VM or otherwise the MES/CP/SDMA FW wouldn't be able to read it.

> +		Lock and validate each into GTT here so that
> +		 * reading its GPU offset below is safe - matching what the
> +		 * create path (mes_userq_create_wptr_mapping) does.
> +		 */
> +		xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
> +			struct ttm_operation_ctx wptr_ctx = { false, false };
> +
> +			bo = queue->wptr_obj.obj;
> +			if (!bo)
> +				continue;
> +
> +			ret = drm_exec_prepare_obj(&exec, &bo->tbo.base,
> +						   TTM_NUM_MOVE_FENCES + 1);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unlock_all;
> +
> +			amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &wptr_ctx);
> +			if (unlikely(ret))
> +				goto unlock_all;
> +		}

Clear NAK to that, this is clearly not correct.

Regards,
Christian.

>  	}
>  
>  	if (invalidated) {

