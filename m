Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7CBCD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 11:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4D310E06D;
	Tue,  9 Jun 2026 11:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIMJNay5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7710810E06D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 11:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqZNa8NPSNXxw+H6TDtKJNsTfAnUMcAoXELD31LK30jT1lYqu/C8uYeHC1NXbQIYvWCbWNcDkNgoLHFpi7Y0KOZcvggtAHHsontoAxOTsLe4UWmUhZoYGAQ0FG1d21BbjWhLWmjYtEploqHSTICRnFlFxY4/+FXRjxLMyGoW6pbnVYSuf0BD4pJsTAksDaCWDpnFiXXD07p7lIk6Kyw4CnDwGKgsk+CLlLghjsX21ZcBuYnIF+6G+hPI/ii5iIQlCSE57r4Q+10fp9WLDr7KtETrKBt8Avw4bWJeRAbc5xdGVIR2KKY4akfDXgVGqPqsmU0ZH5qz1rOn9UnSIzzLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O75Z9HI+ZFbvhUkUM6ZoJ1LLeDBFtVFpuLVpvH6xEGk=;
 b=riDSYkuHo1T4GchlsB91GLn1yQmD5snP7WtjrvftJ3sGK99eQw1hFpjlwiQO4PVEkGzyKSF6Gvj+VVuDFqbdZfI9hogRmSgCVyvJuQJAVM0IfZZGygcujqIu7X4phLLko6thC6ZfD/Jm6baGQxhXbOcUsZFTZRS1D+gULQO/TEkRG1jMklPiULqMRNb43Nd0m/CrAAtwUPLNtVkoybHAjBQDZ+3o3nAtj0t2JeY0U80DrRet3VB680zGOqhW8O4QPhOxaIf8BVSNz7DAJbqMFjMpwp9zvqdEUM2oMMMVhq51cRLgkUn4vzv5kLd7Mq4BvAtr7hTkrHrhlZcygBFV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O75Z9HI+ZFbvhUkUM6ZoJ1LLeDBFtVFpuLVpvH6xEGk=;
 b=uIMJNay5eIVJo7tzY3p1WQJMoIHbgK8A+bRv4FtpB9L6qoaN6Oz+lxr1oc3kr4alc6ncjmL4okNJtxg5p/Dv1rb5LmTzrryqmnbkg91U8+5SW2KdheV2VO9P7eOoZOS3zcUrOkCuTBaMnGqz06utXivmHQiRPCZaTBfxfGuABE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:15:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 9 Jun 2026
 11:15:41 +0000
Message-ID: <cb327867-ed19-4325-ad99-ada5475053af@amd.com>
Date: Tue, 9 Jun 2026 13:15:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/amdgpu: implement per-process MES context
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260601064112.172432-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260601064112.172432-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 58200901-401f-4aef-6ae2-08dec61870dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cimVhFb796Dt1SzVI1BF2IaVKhflbAxMRqWwCKmSzr37qcGJJH7YAxF88F7hdb28v14zaQk9+S7AD+YbQ2T58sNA/bIQ/LblfEAREiQJ6GuK78UisC4QwNcFFfPVJiMietWb0d8yHhyMvZzJCRacgAk2cNaPTlS4URaledzABzmDtfqxz1B0SuZMPWJ56rRlObpHfxe6y1zOoVEBpn2g+uDNCqGeGXZasD832BdvIfa1LlhKH0XQyaVlskA/SeZIF/C+wv30JKsJmLdY+OLw7o+pxIl2fVYKWkaa1hR4towJkycoqrM1ub8BxNHtWg5fkDf8Vr5w9zDSCXguZh+vNEq2QzNAd892TvVfp2J/x54ToJGBVsmARs+ZICEIYoYaRMCXhfwrn9IfdZVFHfdycH9pGWINwgox9W1GZWbwpmC+rVYOdgHKFpdXofc8E8jWIRR16eKddQhCJoFukQHKk7VmDPRdtube3p2dEOe74fSxd8kb5P0hmfFfR3Hh7+ppobrZHILIXDm1tLOBEKExLVZcBxg4dc6AKJYHwQZPEFYMYsCQx7Q1FJQvUCnd19p5keM8YJgPKWUbcFedV7PTRGLa6c3NwvcaRAchDH9/KcD56nF2XIi5m9jh+aR7zWaf8DBA8T+vRPAyHAXne9dAeXH2XfWn5nYlr0CDgAytFYtAildBwqlyKTieRKoXAVb9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmxWdjZpMEFZQVYrYlJubi9yNEpldFk4TTR4OGtGa0Rna2FEMmd2eEN6SmFo?=
 =?utf-8?B?VzFzK2J3Z3U5RlRYT2w3bXFVUE55UzZsQlZXNjNTVmdkSlpwM2tjNFFoU3A2?=
 =?utf-8?B?MmwvY3puT2pWVEVSZEFBeEt1Si85Q1RKTDJxMnJqelZlM3RaMG1IbjNPN3lw?=
 =?utf-8?B?SVp2aUlBTGJVY0lRLzdMcm1YTUJiL1RiK1IrVDJMbFR3UC8rQkp6TTF2VVRX?=
 =?utf-8?B?STNyUEt1QWJoazlTQ2FGd3RVN3NscDZzbTRzRlJrY3F6eThyZmI1REpWSDMw?=
 =?utf-8?B?N3VLdHFEemc1d2xyNnlMQmZDWmtZMTZ3WVgrMk1ubkR4aDFBa0VJbWFwTlk5?=
 =?utf-8?B?MEN4OXU2OUN2cllaaUFGTzF5UWU4eHkrUUlqLytMTVlBU3RPbXRmL0FPdmhH?=
 =?utf-8?B?akxDZU42YUc4MXV3cnU0aWZ1TTdMRE45akNhV1R4STVvU3VGczBRUnVTWUNq?=
 =?utf-8?B?V0ZjdndUTWdKT0Z4c3RiQ1ZtRUNiaUhneVlTSWlnaFpTY2l2S0ZkUWtKa0ZE?=
 =?utf-8?B?Y29mMW82Q0tFVEtOa0VWakcyVmU3QlJuakhmLzVqRE1SNzEwOGlva2lhNGY0?=
 =?utf-8?B?bDlhZFV0UENIUzNKS0lNb1dsMmRCV2pPL0lTY2FHdjhBR2RIbk1ydTZ0aGdG?=
 =?utf-8?B?elZZT2JnSmhCTncvTmFFR2pKREtXb3NFTlh3RVVRRm1nampNSUQ2YUhVcGdD?=
 =?utf-8?B?STljdlcwSTJuTndUUFZWWFRaSlRPRjZDTWo2d1FHZW9WN3NCUThud3ErMGRZ?=
 =?utf-8?B?dTlSeEh0cTcxRHBmMEhJTHF2VFRQbEFlTGl3RE42TUc2VUo4Y1ZBMm53L2ow?=
 =?utf-8?B?WjkzU1RPNmZEVG5sdTBNbTBPYWdjWmg1cEFNcE5ERW14dGxsb1FPTVAxZy9J?=
 =?utf-8?B?clNZd2Y3Rm1NV2JGL25KeTVKNVBlblowRHpRWndvU1UzN2pPSUI3WjBTZzE5?=
 =?utf-8?B?ck80K2ZMYUxkRnN4cmNyZU1GN1BwRy8vQVczQVBJU1BRTytVOUlkVVpMTFRF?=
 =?utf-8?B?QjVBM2ljaFR5Nld5TVRxTmp6akd5bkRaMnhmeTJtNmRSUUoyN08ybnVoaXJP?=
 =?utf-8?B?ekdXNUtvdWpJVXpaT3FNeEdXYmpNWW1hdkduTEJTb1RyYkxiVmhqSStiMnh3?=
 =?utf-8?B?OVFtQUgvKzlzM2QrSDJ0czdvaW1jRjBHUlBEbVZsZU85ZTJUeGp0V0hCclNM?=
 =?utf-8?B?azBhUi9teHVCOGIyMlNOVi95OTdIaU5wUXB0Ymc2OCtwWUdqNU5mSHY1Q0NR?=
 =?utf-8?B?c2tSK1BpSnp3S2ttVE1iUlhNSEd4M1ZsT25KU0MvbzJpSkljY0RBWll3cUdh?=
 =?utf-8?B?NC81SUhzWlIwdnBPU2pvVk5taG5FUmUvSHMraFdpQkdYQXRUeTJ6czJaWHds?=
 =?utf-8?B?bW1pekRPRHVDVzFJR1g2bEthS0hIU1FDdC91dmtaeERLVjZUSy9qRy9BVUth?=
 =?utf-8?B?YXFXNWZzd0pmcHQwcWl5TUhNQTlweURiYXJUSTlQK0Zsay94b2NpdWxTSG9t?=
 =?utf-8?B?bTdzSWw4WC9xbWdUcEU0NEpVbE1UTU9sMlovM1N0L01ORXBEblpGOXdJZFZ2?=
 =?utf-8?B?SGVVYjBtZDR3bWtxNVU0UzVXZVE4ZmtwQVU4SHdrM1VKU2NtQXozNC95RHpl?=
 =?utf-8?B?YlJFVGx2ejFUcHVYNFBnZ2N0bzdJUXQ2N1VqbFV5a3ErUlVnTWdnS1MrUnZL?=
 =?utf-8?B?ME1vZlgwb3l6NmFyWHhwU2hNbTFCMEZqb3Q4N3ZYWk40cXJZVEVLMXo0OHJT?=
 =?utf-8?B?QitCenladnBmVEJidE9PWktRVHRvWHhBZE5IQ3JHTkNUd3hQOXA1ZytCQmtL?=
 =?utf-8?B?dTJCOEZFbWlPdTlRTG9HWU1OdXFMcGl4NmdONEkzK2lnbUpmcTFHQ3hNTXV2?=
 =?utf-8?B?SUZqWVJRTlRWM040OEZFYXRzRTdIMXJrTjIyMVE1ZDc1QjFwU1B4L1lwMCtW?=
 =?utf-8?B?ckEzVHA4MTZYSE0ybHJqcERKeS9zZDhtS01jSDJ0bkwyTEZNVThrNGJQdzlw?=
 =?utf-8?B?T1BDSmJqa3F2bU5BYUVlTVlqYXQwdmkyK1VSazlvb2VBM2FnMk9sMktqZlUv?=
 =?utf-8?B?SzUyZHpJendNRWpLa0JSTEdibGVaa2g4UjV5cmNsT2ovaFJMT0xIMzFMdFRD?=
 =?utf-8?B?TW9aY3RIN3FoTGJxWU9za2Z0Zll6M01XVTUvai85anp2YUJvV0p3QUcvY1gw?=
 =?utf-8?B?cE5XVEFGMlpZaGFEZng3SnBaSjFqVHJndnExcXlCeGZ4UmtWUWExYzNQa0JN?=
 =?utf-8?B?YmdmV21meXdqcmFJNG1zOEwxdmFEZjY4YnFRVFhNekFuMWNJWUw1OXFralBw?=
 =?utf-8?Q?gsnJ8BrDbURUb/sRUe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58200901-401f-4aef-6ae2-08dec61870dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:15:41.1489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVt6huBhbef0Xh5LS8Hhhe/6K4g6Co1q2/iIbVr3sNTtIukZFxBdiFAZ8+mCj+cj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
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



On 6/1/26 08:41, Zhu Lingshan wrote:
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

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 +++++++++++++++++-----
>  3 files changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 38e310a8694d..951d5da850be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1172,6 +1172,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>  	userq_mgr->adev = adev;
>  	userq_mgr->file = file_priv;
> +	mutex_init(&userq_mgr->proc_ctx_lock);
>  
>  	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>  	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
> @@ -1225,6 +1226,11 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  	 */
>  	cancel_work_sync(&userq_mgr->reset_work);
>  
> +	amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
> +			      &userq_mgr->proc_ctx_obj.gpu_addr,
> +			      &userq_mgr->proc_ctx_obj.cpu_ptr);
> +
> +	mutex_destroy(&userq_mgr->proc_ctx_lock);
>  	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 28cfc6682333..a5867ffe6988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -127,6 +127,8 @@ struct amdgpu_userq_mgr {
>  	struct amdgpu_device		*adev;
>  	struct delayed_work		resume_work;
>  	struct drm_file			*file;
> +	struct mutex			proc_ctx_lock;
> +	struct amdgpu_userq_obj		proc_ctx_obj;
>  
>  	/**
>  	 * @reset_work:
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index e9189f07c6dc..6c8a44cee34b 100644
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
> @@ -257,6 +253,30 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> +static int mes_userq_create_proc_ctx_space(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	int r = 0;
> +
> +	mutex_lock(&uq_mgr->proc_ctx_lock);
> +	/* This check is a necessary because amdgpu_bo_create_kernel()
> +	 * calls helpers like amdgpu_bo_pin() and memset() unconditionally
> +	 */
> +	if (!uq_mgr->proc_ctx_obj.obj) {
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
> +	mutex_unlock(&uq_mgr->proc_ctx_lock);
> +
> +	return r;
> +}
> +
>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  				struct drm_amdgpu_userq_in *args_in)
>  {
> @@ -429,7 +449,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
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
> @@ -492,7 +519,7 @@ static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
>  	*fence_ptr = 0;
>  
>  	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	queue_input.gang_context_addr = ctx->gpu_addr;
>  	queue_input.suspend_fence_addr = fence_gpu_addr;
>  	queue_input.suspend_fence_value = 1;
>  	amdgpu_mes_lock(&adev->mes);
> @@ -529,7 +556,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
>  		return 0;
>  
>  	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
> -	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> +	queue_input.gang_context_addr = ctx->gpu_addr;
>  
>  	amdgpu_mes_lock(&adev->mes);
>  	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);

