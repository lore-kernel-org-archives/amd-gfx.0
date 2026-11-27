Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6F606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eXeAQy/I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF0E10E549;
	Fri, 27 Nov 2026 08:58:51 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876FF10E51C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 08:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoExoVJRLXzq1xFjiwBHoOvewz9h7DcXEJYfp4h8pRChX3MXEM9+Zd9iYrKwCo6ft7TJDeAddabcysoFZPWOFJZQsFv7rc44iSS0f8ijW3W4F4HtrNd51EpvxTjucMoPzBMZ/CKZRHA0awtktKgzBJzMwe68rz242FJlzPIPSvdFRpBjrMvu7myHG7ZFRtNvV1Id3CA+wltl71q81EW+ABKPDLhMHlJAsehwQm+8wVx6GTsYCwXCWoUJscBkkF403IolgIaYbIGLsNwbjaH/6WTJmyKHMISfZA9OYLXhCj0NcQlIj0ciSxyy+T6XnQ0tbDyDFke17Sv0g2/Ln1kDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fql9wx9kEZ/cy2VWxZVamJW6FtQl/YlRgDds83Sm3NA=;
 b=esyxUG1cUzLY4QPqqEYTK6/RfsM3ycCGn6UlOSVHIy5QzzYJcnvqzq5sFEtXyiGoJ3ev+1WL1G9+zLj9rpK9frKfDh1ZfYYzay7FJyzloPcJm4URCBN37iW45kNrfXiqRsp6f3l6y5GARJiDdCWfm4YLg33fXEvl0hXx5O2G/1sEzBk+odeuSF6oKQCb64R273qWhUPZ29/fQj/CvWumi2LAG6fRqkCJv9ZKt3WBxMBFJScenH4fY8FgrtZgiu/St5aqMXC6wqesvkKmQYEljNCHcKjqurnLHr/JYLrI1rmci/4QIMhNSg3xJxEGWubDvxbQbu6OG+khu7OcWkOCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fql9wx9kEZ/cy2VWxZVamJW6FtQl/YlRgDds83Sm3NA=;
 b=eXeAQy/Iv226pY4zVuzOZYmI2d2TO1p5y6i/r4CcWvyLTDiofzCg7V3n0O8TQvTAKEXh6mYq00mhx7xrj6AVN6Mv0W5yW6iXy2AN6xM3AksG8t22ri+XgNwSnL3/Tqospnxe6rOuhCptjOr9v/1Em8O7kZY1GAcZXE4+MTK4pLY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:58:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 08:58:42 +0000
Message-ID: <40d850d8-9449-424e-af4e-2fde30797c52@amd.com>
Date: Fri, 27 Nov 2026 09:58:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM clearing after GPU reset
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261126144240.598627-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126144240.598627-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a662091-4eda-499e-78eb-08df4c64a273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261009223027099003|22082099003|18002099003|6133799003|10067099003|261021123027099003|11063799006|56012099006|261102123227099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: sZ1dzv4ZFqclCVgl+jg2hMT4gyVmk/mYFvdxILwFm10rgyqrOlqx2m9sOXHtXWS2O0tfJIGnNJ8Pbi+tMldRP1SMaUNz4ICG6XKaw2EdvXsC0uRFoZ5Whg2AzS/mmc5Rm2Nlo7X/e8fKX1ez/PW4pl83kjlD4vyJQcHms0ia4utTgBt8c46GtM6eQoPtopVYxxrEzARfS0PuunnQQKg+ugChxjdbsoaTEXAPGg9/ILYpGgn80cwR3TdatQjT8heqPgv3ZTzU2aambJmzVDlb2Lr1QLmck5SCmxvwKdJyopWfdAoG51bvjrK4Xaj5PJSAPspSXMARmtWgPNNp27/ytCbllkjzhN7Dv3Z2HN0f61LmVDAxEWRYXx6a9nfVftdM+MomymZ7ZoJlRBrvDbfmlS+I/cE5+AgIyyih6OLfgIXEsQYLTA0SiBJVjQjCCp/1CNEkr3yR2ozC0xvX9/2g6W/6eYarYjr3JmE6FLONMHEPPJxcVOPJd6v49EMG7UBAk/FE8od/ElgUjwb92Mpg9WyuATkOwZbgYyKjx7a5sAjO9ffmnp+PUkLhcy/EcpKjyuVBz2yvolunkvoyBP2Qr8Y2hJNUyB7cztIGtLqbXbaS9+URN8ZPrF7FZLnLGTp/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261009223027099003)(22082099003)(18002099003)(6133799003)(10067099003)(261021123027099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2tGcE0ycWxqRXJaRHJnb2x1T0daMzBrYzdPc1YrcHQ1eUJlWGlHV2RaRERK?=
 =?utf-8?B?OEpPa0Q4cWlTTHVpK3M2Vzdkc2hEUEd2U0FqN1BNZ29TVytyOEhiTEp2WGpE?=
 =?utf-8?B?NGNHemRkOTlXNGV2NUtPcmREekFYSjB3dDR0Y28rY1N0NzFnT0Y5bzhhZm44?=
 =?utf-8?B?aWZhSGk3S2ovS0Faai9wRVdDYTNNdlc4ckIyRERIbjZsWkVSWGRCVWwxUVRO?=
 =?utf-8?B?Q1dWL1VmemY1allIRUVtY1NkWHdPejNiekxMYzYvSTFDaUdNL0ZpMi9SODM0?=
 =?utf-8?B?VmtZTHlUQStEYXFUOHpIelhxNEZ2WlpKa05MbW5SZVJXODFoR254c0xIZW5D?=
 =?utf-8?B?UlY2YzJHczkyaW1QMnYvMURqWlMxb0VhV2RFTFBVZUN3Q0IvQzBJaGtRKzhV?=
 =?utf-8?B?MGN5a0VENjM5WmcyNCtWeUE1NjJLWmNzMkd6Ty9DaGk0MjAxNkpKVkRtQVRy?=
 =?utf-8?B?TkpER1VqTCs2WUo2WWllNjd5VXlyaG53TkhBazR0OElqcUxhR0lvcStYM1Bs?=
 =?utf-8?B?emtoeStLL1N6dUw2NU5xd0RlVmNncVYvM3RFRnNQZDZ2ekFEMzNGME95UWZM?=
 =?utf-8?B?dGlSUHFUSDk0UGRmNi9saDd3R3lBcFBVaTVSMHY2Zy90UXc5WVkrSklmdE1E?=
 =?utf-8?B?dG5EMmNyN0VoaG5McnR2SHdzTGVPc0NTbWNGUDd0bEpjUWZtMmRIeEw1N1Zk?=
 =?utf-8?B?TzllRzFCbEtHQmtzam9kbHBTK1RKSG1zVEZrSzVoODFRc2l5NHdUQlFXK25N?=
 =?utf-8?B?bVpMVjB6ZVNjTW1hYXExQVpZZ0RCM3p2WmhmTUgzRExUT1UwS0R4UlVST3dx?=
 =?utf-8?B?cTVxd2VWRlIzR094MFlwZURmSkNrN3V1QmtvNlc2Zjd6UDcxeEhRc1lwK3Fn?=
 =?utf-8?B?RS8raVpxWGxFQ05CREt6d0E3TU11VVo1TEFPTkozcjNnNTVXNFNmVFppSkxW?=
 =?utf-8?B?c0U1U09pc3ZYZW1UMk81ZWhRSG1oZ212dTR6Qzlhd2xSL205R2U0UE0yNHBX?=
 =?utf-8?B?MGlCTzd3VWZoUFlXNkUzSFhtOStEb01uK3c0emdLWGZldUxIb0txbEpuOVFX?=
 =?utf-8?B?aUE2QVU3VUd3QkFNUWlVMnFGRUc2S0dnQU1YbnI4a2RwcmJSV3BSRUdTeW1u?=
 =?utf-8?B?VHd3RHIrUFk2dUhZOEJUYjZpMTVKWC9LVS9sQm84NElyY3VrZFl0eVlQcTJp?=
 =?utf-8?B?ck5leXhyM0t2emttQTl2OUdqUmVsOVR5N1BWbWt1ZGd6UlpLVGR3QmVEdDNN?=
 =?utf-8?B?WktQR0ZtK0l0c1ZXLzNOWloyR3NQZm5KRm1vZTlQUFdTdjA3K3JneTE4eU9o?=
 =?utf-8?B?Q2k2Q2h0RSthcmxXZWtBM3AxUmlhcVdTZGxYN3NDWWFRQjVVaW1tcXNYV2tv?=
 =?utf-8?B?cmtWb0QvWDBqc09weWFRUHB0Y2RtSFJkTTZMKzZvblZzMWFoMlBDM0JjZ3VE?=
 =?utf-8?B?ODFzRVcxTTVUS0JMMWlaeEZBQjQyZGpMUlB4ZFF5dVZiTjFhYlRKSkFuWjlK?=
 =?utf-8?B?TjBPL1k2WTZ0cVJWZVR2Zmd2WFdJNDd6bW5sMXY5byt4ZjhhdjFsaVhmTXA5?=
 =?utf-8?B?cG9iYko3dEROdUo1WVpIeVhxQjc5YjVZckR6Qlp0L1dGMUhnUTlNQW9Jc2lo?=
 =?utf-8?B?S3lMNVZmSGVTaDA5WnhZejkxTXVGeldybjArdGFXSEQ3TG13SmRFSXJCNWg3?=
 =?utf-8?B?WUYvSmp5WU1GV1ZMM2tzNXZRMHhGT2hCUlNadkg4dG1FZ0FIMWc0RGxYeGx3?=
 =?utf-8?B?K1dVYXdvYVl5VzBWemxuS0ZxRnBiSWJlWlZYR0dEY1JGMmo2QXJCcy9RRkNR?=
 =?utf-8?B?WGEvTUxDcXpCZVlwUGlaMlZkTDJwdUFWOTJZajRMY1JBNWE1aW93bm41Wmlp?=
 =?utf-8?B?SUh3Y00rQ0k3aFVtOHFRUEZ6NjF5THovRWt2a0hDb1ZvTlV2WEVrVlp3dWxY?=
 =?utf-8?B?Nzc2eW0vTE4zS3d2bm80Si9GMUdmdE1lUHZNMWNxMnpPZ253VXNmaXVYdnRX?=
 =?utf-8?B?U2d0OEZtTEU3L0ZnZG9XQjFpanFaeVY0Szlwb1JpdkN4eDRXN0ZhejJWZlgy?=
 =?utf-8?B?MlJ0QXF3dXJtWVZEU0lqK2dkVlBHY050ZU1iTVI0OE9qT1UxSGZ1TFpFUWll?=
 =?utf-8?B?MnBwRGM3Tk9JKzVkN2xSdGxqTzVaVGJHeWp1Z0ptZHYwQVBwQlBGbE1oTm5i?=
 =?utf-8?B?QjYrcmoxQVlzYmlibVJFZ1h1ek5JMzFhTHpqaUhLNktqTXNnVDh1WVdYaXla?=
 =?utf-8?B?cFNWa1BaRWgyUDh2NmNHb0JrZGpqeEpmdjJaeGNVc2JvbWFxZ0RmR2NJdElI?=
 =?utf-8?Q?b1gZRgc4M16pgywxAK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a662091-4eda-499e-78eb-08df4c64a273
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:58:41.8956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnC24esNDQGsJVtX/yE3NFURrGJXAZppaM4Ob0/fJkR/yy6wZVsn2TFzjsAFVuF0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 15:42, Arunpravin Paneer Selvam wrote:
> After a VRAM lost reset, freed VRAM can be handed out with old data:
> 
> 1. Clear jobs inherit the error of a job cancelled by the reset and are
>    skipped. Let clear jobs ignore the entity error.
> 2. Free blocks marked as cleared before the reset are not clear anymore.
>    Reset their cleared state when the VRAM lost counter changes.
> 3. Blocks whose wipe was queued before the reset are freed as cleared,
>    but the wipe may have been dropped. Don't mark them as cleared then.

Please split that up into multiple patches, especially the error handling for kernel entities.

Regards,
Christian.

> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6141
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c      |  8 +++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h      |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  6 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h |  6 +++++-
>  6 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 8689a3c933b2..b186b5b73de2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -391,9 +391,11 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
>  	struct dma_fence *fence;
>  	int r;
>  
> -	r = drm_sched_entity_error(s_entity);
> -	if (r)
> -		goto error;
> +	if (!job->ignore_entity_error) {
> +		r = drm_sched_entity_error(s_entity);
> +		if (r)
> +			goto error;
> +	}
>  
>  	if (job->gang_submit) {
>  		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 18e788f0e790..1947d650cd7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -75,6 +75,7 @@ struct amdgpu_job {
>  	uint32_t                preemption_status;
>  	bool                    vm_needs_flush;
>  	bool			gds_switch_needed;
> +	bool			ignore_entity_error;
>  	uint64_t		vm_pd_addr;
>  	unsigned		vmid;
>  	unsigned		pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d4651f2d437c..9512c778c4f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1366,7 +1366,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>  	struct dma_fence *fence = NULL;
>  	struct amdgpu_bo *abo;
> -	int r;
> +	int vram_lost, r;
>  
>  	if (!amdgpu_bo_is_amdgpu_bo(bo))
>  		return;
> @@ -1398,13 +1398,14 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	if (r)
>  		goto out;
>  
> +	vram_lost = atomic_read(&adev->vram_lost_counter);
>  	r = amdgpu_ttm_clear_buffer(amdgpu_ttm_next_clear_entity(adev),
>  				    abo, &bo->base._resv, &fence,
>  				    false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>  	if (WARN_ON(r))
>  		goto out;
>  
> -	amdgpu_vram_mgr_set_cleared(bo->resource);
> +	amdgpu_vram_mgr_set_cleared(bo->resource, vram_lost);
>  	dma_resv_add_fence(&bo->base._resv, fence, DMA_RESV_USAGE_KERNEL);
>  	dma_fence_put(fence);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d5c1d044403e..5c683df901ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -435,13 +435,15 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>  	/* clear the space being freed */
>  	if (old_mem->mem_type == TTM_PL_VRAM &&
>  	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
> +		int vram_lost = atomic_read(&adev->vram_lost_counter);
>  		struct dma_fence *wipe_fence = NULL;
> +
>  		r = amdgpu_ttm_clear_buffer(entity, abo, NULL, &wipe_fence,
>  					    false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>  		if (r) {
>  			goto error;
>  		} else if (wipe_fence) {
> -			amdgpu_vram_mgr_set_cleared(bo->resource);
> +			amdgpu_vram_mgr_set_cleared(bo->resource, vram_lost);
>  			dma_fence_put(fence);
>  			fence = wipe_fence;
>  		}
> @@ -2647,6 +2649,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>  	if (r)
>  		return r;
>  
> +	job->ignore_entity_error = true;
> +
>  	for (i = 0; i < num_loops; i++) {
>  		uint32_t cur_size = min(byte_count, max_bytes);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 249f07f30951..ef4c7b438406 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -456,7 +456,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>  	struct gpu_buddy *mm = &mgr->mm;
>  	struct gpu_buddy_block *block;
>  	unsigned long pages_per_block;
> -	int r;
> +	int vram_lost, r;
>  
>  	lpfn = (u64)place->lpfn << PAGE_SHIFT;
>  	if (!lpfn || lpfn > man->size)
> @@ -523,6 +523,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>  	}
>  
>  	mutex_lock(&mgr->lock);
> +
> +	vram_lost = atomic_read(&adev->vram_lost_counter);
> +	if (unlikely(mgr->vram_lost_counter != vram_lost)) {
> +		gpu_buddy_reset_clear(mm, false);
> +		mgr->vram_lost_counter = vram_lost;
> +	}
> +
>  	while (remaining_size) {
>  		if (tbo->page_alignment)
>  			min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
> @@ -652,6 +659,11 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>  	list_for_each_entry(block, &vres->blocks, link)
>  		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>  
> +	if ((vres->flags & GPU_BUDDY_CLEARED) &&
> +	    vres->clear_vram_lost_counter != atomic_read(&adev->vram_lost_counter)) {
> +		vres->flags &= ~GPU_BUDDY_CLEARED;
> +	}
> +
>  	gpu_buddy_free_list(mm, &vres->blocks, vres->flags);
>  	amdgpu_vram_mgr_do_reserve(man);
>  	mutex_unlock(&mgr->lock);
> @@ -961,6 +973,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	INIT_LIST_HEAD(&mgr->reserved_pages);
>  	INIT_LIST_HEAD(&mgr->allocated_vres_list);
>  	mgr->default_page_size = PAGE_SIZE;
> +	mgr->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>  
>  	man->func = &amdgpu_vram_mgr_func;
>  	err = gpu_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> index e581cbf52fcb..378e9c89be7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
> @@ -39,6 +39,7 @@ struct amdgpu_vram_mgr {
>  	u64 default_page_size;
>  	struct list_head allocated_vres_list;
>  	struct dmem_cgroup_region *cg_region;
> +	int vram_lost_counter;
>  };
>  
>  struct amdgpu_vres_task {
> @@ -58,6 +59,7 @@ struct amdgpu_vram_mgr_resource {
>  	unsigned long flags;
>  	struct list_head vres_node;
>  	struct amdgpu_vres_task task;
> +	int clear_vram_lost_counter;
>  };
>  
>  static inline u64 amdgpu_vram_mgr_block_start(struct gpu_buddy_block *block)
> @@ -81,12 +83,14 @@ to_amdgpu_vram_mgr_resource(struct ttm_resource *res)
>  	return container_of(res, struct amdgpu_vram_mgr_resource, base);
>  }
>  
> -static inline void amdgpu_vram_mgr_set_cleared(struct ttm_resource *res)
> +static inline void amdgpu_vram_mgr_set_cleared(struct ttm_resource *res,
> +					       int vram_lost_counter)
>  {
>  	struct amdgpu_vram_mgr_resource *ares = to_amdgpu_vram_mgr_resource(res);
>  
>  	WARN_ON(ares->flags & GPU_BUDDY_CLEARED);
>  	ares->flags |= GPU_BUDDY_CLEARED;
> +	ares->clear_vram_lost_counter = vram_lost_counter;
>  }
>  
>  int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr,

