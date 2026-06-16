Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC052CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742F510E952;
	Tue, 16 Jun 2026 09:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YSkXZiKh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4EF10E944
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoWCBpwp/WpB5pVJ4oIjFLrOOFZvefw/Z2tbKC4QX7U0dyGdK7unqUaf2uv39+DOc8/0MPBa2YudPOqS0dEmtba4B0yV6mzdoAiRtRVlUYBgTAU7hXg+BYE9DrRz5qKEwwduJ34AOaxdxBuFla44vLE2Kg+07Q+LGjXbMYgXIMzNBXdpkrs75RjC3/IbD65frC6mhTUKYUo2m44wcqYVyHfs58c9sdT9ZgGIHPn/3QWnRUbd9UdnyyuJNO0UUpJvvil4yVKrTPp4p5wYgRxvk4QSz/KC1CmMhLIzfNzdrlb4G97wcNDGJHu2tjhAFQQaWvDfbpnRNjhOwrl4/TjKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MGUyjtksLYfaHcWCu6jSNxOFMm6NkqKEmQJ86xIlRw=;
 b=PeHBJN3J9b4xe2gvmAXF3o0kpodQhzJfMQB2BNG4SLx3PptY9HIeZ3jptEpN+ZNJvDYEJSB8nPiVNxHovu3hHdAGSrkinWI4/H79jejIA30NcAp8bJwy9DpTFxFL4pQsi++h+zMAyaXnY/zBkYUm/vcRVo3pGkerf7n8sjBeOqv7lKuxWP17CvzSKNZSVTTiwdd+hOx4Lw9S2w82UE5uHGmjEXuag5T+04Z2zxtQ6EgDBhPlo08388gJRdB/J20BrUxrn8ADa6D+8oWksL3XjcsotuwDwbSi5FLx6vLqf69wPHlZykkBsSMKhu5F5irN3yjsUBMtJaZxZVZnzXp1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MGUyjtksLYfaHcWCu6jSNxOFMm6NkqKEmQJ86xIlRw=;
 b=YSkXZiKhX9aYkBmtjdt+cIYMzM0368GvW/L1sKZ1dADFuIaPScxrUVbCrj3oyjZH4YtzUjj0AibsYpUzqmMfN//mJ/pZ3jMr3RIWbXwmcQ0oNXFFAjD683CWtZils6NCcCHbHZj1waUd0rFjV9FamlHTxoKjgjpY60MYuFv7i8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 16 Jun
 2026 09:02:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 09:02:28 +0000
Message-ID: <5f16dfbb-e9b7-4f66-954b-ac7299743323@amd.com>
Date: Tue, 16 Jun 2026 11:02:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu: Signal SCRATCH EVENTFD notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612055226.2879270-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c7f7de-f636-4fc7-7ee5-08decb85fdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: iQ4E0eQcF3hxGzTHoBK3eGsQLrgWtEc8u+DXbGkVCzT0w9ov7V5Gef8js01gX70kFCg7+W5+Jry4zp0HiFczV9oeWphFqqkYEDohUqRlZTX8aiHqxwj8IRRj4sQ0REYktd1U7zFFjYfaKCiUSFbHmWdWOLpI0tsVugDKUGdddhpA7pFuLPrfqWy4+BcsLm+fO1Nyb3Pd8AXE7Qg4vMmO2Md5lhkeFyCiJU8U0feSwcFrtNLypP4PTYipgsfzN6w7yU0UvVX+1c3oCsKmmkWD/KhEW8uD4Typ6Jzf7/hcJszoW4DlVS4lxPI2HEvw5lxqmvzvFFL6EL6bTOznkiuOBieLRZ2Oi34WmapYH7dZw24UX/uWWNvdoM5nn/jXlaMlUKmhMrupGdn8sqX06kI9xy376f/xMybIKfouhZHop9fg/Nge/mqVM6ZnW3bf2AHZn5+SSKzVR8JA/STDiayH0sUbGKy+vJTDkIU6ZmwV3uqhoP66b2K49iyloWmP7ylmchNF876hd9xLHnXNd6LsbIZm4WcmDB9J1ut2DmibbJ+oqdTD2mUrlhGxvdO1ZGEUGiS8R2DtrF4LEdfDIB/4GcYFBIHsulIkFOS5nzzlOrD8bXUXlEm52HLK3sGmJu0S7x0AHVMrRzvqOxsGV7vnhzOCf/G55b1SRmYOZIJchH5ZGDUU0czpdUTODuuL53DH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODlmdDh3ZjFqQTBxOURuQko0WFRaaGd5SDZqZXlVR3pBYVFqckxJN1k5UGVJ?=
 =?utf-8?B?elM3TUJIQWRWMDN2OXAySjl0eGg1WDIwek5KaTA4aTNPNk5XSGRUcmtPWlNT?=
 =?utf-8?B?cWljc2lLM1Q1SmxZYWJRVFVWTHhCc1hNSFBuR21YM0pUWUc4N3Q5a2xZaDRm?=
 =?utf-8?B?SS9GMlpwUHcrY21uNGV2b25nYWNrRG5IeU5XVjg1SEhSZ1RINTVEa283d0dX?=
 =?utf-8?B?QnhJMUwxblAydEEzTDhqRnRReHZVZTVYeWpmMUNPQW1SOEgzNUZNR0FPSThz?=
 =?utf-8?B?b0JZaStmOXpYQ2NpcFJqcHBsUEl1ZWduYTN4cm4vL3NId3dES2haTElwdjBD?=
 =?utf-8?B?a0NtUlp1Mnp1NE43cWlmeXRGWVEzVGM3cU5lT3lpQVRpeGhLZ2FOV1FwQ3h0?=
 =?utf-8?B?VDZnc3ZMNURMM1NDL01IRjhqek4wekRVZC9YclRCeGRxaXpTRmtJV2Z5Mnhr?=
 =?utf-8?B?ZkJzNUxsZit1NVd4WGkwaXpMSEQwc1FubC9DdXF1NW52SXFlQzVZeWVSd0sr?=
 =?utf-8?B?dWlSWVk5TUJHakpIbFNVeUNyS1BOS2dWb2ZHZ1d3bEpjclovWWg1dG5UeGlC?=
 =?utf-8?B?Y01vSnhBTTFNOWRlVmQwWWJjdFNiVEFSWVdoTndvVDFrODRBMm9aV0lGMFhz?=
 =?utf-8?B?N3pkS2hybnMxdGxTQVlSd3JPRkZ1TURQejRueDFnR2N3RTdKMWVDeVBhSzhL?=
 =?utf-8?B?cGRUZHpGSko3c29qaCtMQm4xN0hBNTBEWm55WGt0L1llb2VJaklxbW9mWVgv?=
 =?utf-8?B?M3BqRXY1UzFkNVVueS9ocTExQzJ1c0VNczJ5L2RuWktFbUVYNDBkaFFaZHVQ?=
 =?utf-8?B?VzgxcnVnSmREN3ZSWU5NZHZiUXJvNitkVXBaeGJudnFiVnJNTHFOUjJFT1Rh?=
 =?utf-8?B?U1R3VW1aWXM0UHBQY2oxSTVjTmxhb3gveXFCUnNTV1RlZnRqd1oyL0FJS1l1?=
 =?utf-8?B?YS9RMWtHUmdSR1RsSzIzcWovSUNadDFiK2xtY0JWdG9tTzBqeWwvUjV2ZGRV?=
 =?utf-8?B?enVoaGd5OEVJL0p1Z085aFFXc1pBVGRmdk1vT2IrZHpzNGh0L28wTm51NkVm?=
 =?utf-8?B?UklxTUk1QWFMQUpLY1dzWjU4ZmEyZWVybHFwYldrcENudGFVeEIyK1YrMlRR?=
 =?utf-8?B?YlNOeHd3Mm4zZ3dBOHg5ZVNLWEZxczhDRkY3S1VFS2dsS1QyaDVOYTloTzZ6?=
 =?utf-8?B?Lzk2NjRxaC9MMTdsWHhsbldRUm9YL3RnY3UvcGpJbGo5MGVOL0ZXZVcwNmtR?=
 =?utf-8?B?bXFCRFprenQva0VwcVdFT0hUU1ZUbjh3Nm8wV09MTmhGMjNiSkZqeFUyRmVi?=
 =?utf-8?B?eStoMzFVQmZ2M3k2dWdJRHRIcmtETURtSUFUV0JYeUdsY3pQRnZXVmtTYWN6?=
 =?utf-8?B?d2dJRUNIdWhGcmRhVytVMHFqeFMrbm5DTnI0OFpqUHBudWc0aXZMSndSK3ZT?=
 =?utf-8?B?TVZXV2t2R1o3eFZoaW92dmR6czBycDFPMjlwQitjbU1JMERGRy9uVXVybWU0?=
 =?utf-8?B?eVZ6aWdwVWN4eDIvQ3h1cVVZNm5DZW1URExQUU1lRU1NZ0FPOWlhOG8rMVZ3?=
 =?utf-8?B?OHRSVVc1cmRURFpTQUx1Q0g5RGFESWRibzhBQTdvT3d3aEhoaGFJNnkvME15?=
 =?utf-8?B?dGJUU1dtVHduMUtBbUIzSWdrZ1QrZExRalhEZHdmVXF4UTQ2VjgrcnoyeXdD?=
 =?utf-8?B?L2wrSTVpUy8wNDh5VHlrM3Z3RXIwUDdNMlRZc0gxaXdPRE5aSjRmdjlyaE5y?=
 =?utf-8?B?bUxCNW51U0tHd0VIR1h2ODNpZ2hEZk1HN3dEbnlhMVRuYWh1Zm1kMjRuMU1u?=
 =?utf-8?B?UmNrYXZwb1JJSnpLaTVPU1ZDTlRncmZGdFRLeFdTSFVBeno1TERSS1dmQXkv?=
 =?utf-8?B?NHN0Q1BwbFREWUpmRFB6MVRicEFvdWpVQUFWVmpXMDRMM0hCNGlLdTVsYXFI?=
 =?utf-8?B?Tmt3aUtlNGZTd2dFcmMvRkVqaDFONXJHblZ1MXlsZitzZEZUeEkxdkY5aGlE?=
 =?utf-8?B?R3lEdlBnLzB2U2Mza3IvOWFVWEtFaUJ6eXFFbDEvODRsVnpHVk1VYlhWZFFq?=
 =?utf-8?B?YTRNY3dHcUhSalJ4dDZkSXZlZXdFaG9kUDlmYWtVR1FreGhBVVNRamhReU15?=
 =?utf-8?B?NFBVYlF0bE9mQzhML1lVdGlMTnRvL0VUVUZqVWhtN2FLcEgrcWZqdGhMbnVQ?=
 =?utf-8?B?c2ZBTUxRRk1FUFhCU1hqVk5tMkY5Vmc2dTl5RlRrMVJlVHNyUTJZaXRHZFJ4?=
 =?utf-8?B?RW1ZeTd6NDJuV0hLeVpDdy9yRUlYVlBUNVNITjV3OTdyS0hvZkkvUlIzUmVi?=
 =?utf-8?Q?99p0M3tnCPLz3I6nbJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c7f7de-f636-4fc7-7ee5-08decb85fdc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:02:28.3859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esT2zdM+fRlf+2sAQTg1grjviG4BibDmsPgRTXiJeoQ/NglqvUm77ZY4TSZX1Gp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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

On 6/12/26 07:52, Srinivasan Shanmugam wrote:
> Signal SCRATCH EVENTFD subscriptions when user queue restore detects
> missing VA mappings.

I think the scratch event is meant for something else.

When a core VA to run the queues is missing (WPTR, RPTR, ring buffer etc...) we have a hard and unrecoverable error for this queue.

But scratch handling is a different interface as far as I know.

Regards,
Christian.

> 
> The restore path already identifies the affected user queue. Use that
> queue object to wake up the matching EVENTFD subscribers.
> 
> SCRATCH is queue-scoped, so the queue object is used for signaling.
> 
> EVENTFD remains notification-only.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b77385e35e4e..7f605501c84c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -896,7 +896,6 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  	unsigned long queue_id;
>  	int ret = 0, r;
>  
> -
>  	if (amdgpu_bo_reserve(vm->root.bo, false))
>  		return false;
>  
> @@ -905,9 +904,17 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>  
>  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
> +			struct amdgpu_eventfd_mgr *eventfd_mgr;
> +
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
> +
> +			eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
> +			amdgpu_eventfd_signal(eventfd_mgr,
> +					      DRM_AMDGPU_EVENT_TYPE_SCRATCH,
> +					      queue);
> +
>  			continue;
>  		}
>  

