Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A317CFEFB58
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 14:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEDE10EBA5;
	Fri, 27 Feb 2026 14:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fKzalXN5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013063.outbound.protection.outlook.com
 [40.93.196.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6904110EBA7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 14:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxpGi8YsMkGp1+JLMEDiXyfqfsKLgJbQK44OnJLgOe48zQAXSjC5EgGLnx+TrLNzadhObqlY9hxeQdzR5DH+YjwiSuAKj6njEPjwyrGHBIhSZbLPS7R/Aqf578Cdk5ppIm82rzmThhUEDV4bmS84E0HlJGZMD8OX0wgBT7U5p//KcJbDKAnAQKXCSCYBPSXBAM+fsSSfAlSRQXwMNFFaGZY6q+ZY8MkAahQXJynkNQEdF5EayIMycwY1Ij+KNagnBxcxVxW/C1kz75b60rM/l5LtK17Yk160Q4TpE474eyofOXiWj+g2l2RmItaztggu0wfxdAlKbwt/AQqdiPc9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiWcAnP5ulW/mm0IeT1GFqoRMBDPy5OmzWWVWGDd2XI=;
 b=eV6TGBZZYPyefSKGS8On+RlZ5XTWiIt1aFV1DQjjFsBTbq+HBh6Qzg3HtxfVDxzySD6HQEr2QgqZJHwioiD7MXS8AAjiWVvugs7QfkEbjV+E58H6rxWnCTxJ/iZP5sgChVcBEjlfP1ZxUzL/wIrf/FKIHkltVGDNcfzlyz0KOB1rhHVF7bQIhQgMGj2L7lTCXfluPtTX4kufguTaVhAhQJGzNv5Krwwoq5Dk5umxdHtkd62K+6tH0RBQ4JpiAtSNYKJDxx6kneftJMZC4qI4PbAIl8Qq7j4fVtOLUi3Jlq4Tk5bfej6J8W0U22j80lUmElD1Hpsy/WB+3oEnj3zi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiWcAnP5ulW/mm0IeT1GFqoRMBDPy5OmzWWVWGDd2XI=;
 b=fKzalXN51tMdnBXjW54X/BV5ZkpoPf7Fp31nARrCJyUc2F01v9DI16nfkv1zxtscUiiw27J9hGOnWhymtspNs+yOwmENte8NHkiqEzWmKFy5Eur5UuPBv0m7FIiAPeCb4003TEOpWYw+2AXFrutkbs1KZvGXIakHxrzTHT9chmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 14:34:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 14:34:47 +0000
Message-ID: <a11e0572-4770-49ea-b476-db6fc9e5096a@amd.com>
Date: Fri, 27 Feb 2026 15:34:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node
 eventfd
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
 <20260216154943.1582412-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260216154943.1582412-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: b491d213-79b1-405e-12ef-08de760d5b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: BjvvzGK6KeLiOZNm9Z3FBOEqsxIVX0HVf4AamPFao8ub/hkibE6iIDc/APfR3jkvX+a8RiRmeoJDMovK1hocrYaelWdmJA8SP/gUF1+1ZXxfO8dFtgTEj3pGSPq5j4J+FhBML88jCVZsD/mZhL/2+HJJPs1EDNaZflYnCHfW9fnveEGANtKQFtvzLsZA6G2/Ku05uBnpTj7wvLtQZu9Od5gO5vmukLtJGiRP2z4l9/DEOIXHGikQ+WFBViX+PA4hKbogwkJXQNQcTraQYwzLDSES0+/5CGoZOBr2tkR0i/oLwKG1gFjh801mkY+3AtTWCQj8gxYcU41x4maXAWJCmLA9P4b+qpxacwunW69be0jN86Q+i4U6UHHu6+scFH671hFzYIfGeQzHYEHfmcYp6IkFQkFb7S5bPXmwrYlbu/JmrC1XnUQADc36pBiNH++g9S2TeWTcj+i+euPFZZsE8gfCfXkRJB2nZ7AD/oY96H6L3sB7CqEaueMSsCH0BIVC++55OukCXGl1sBxhVdzEnC8HR6H4FJG4kabmVGTny/m8xOQR0AcMLEKCWgSQB2P4Xvof9LPHt/82ed5C0e/0K4M3v/LkqA5ImTgOiRvqukFr81hgVa5Kgj2WmCq3gTrJ+Jr8zGW1IkWu6//Gr3ZB47zexEKXO/i2AE2WKh8z6zSuLSOA6ufmgc+8KGSc0zqMqd5sr0ygN+bP85Y47o2+uN+t1EFdKSGbYT2qwgFQ+xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRwbkI0eEZkTmkvM0UzQ2xFZXp6TWFENnZKMU56ajZqT0pRRFoydG1CdzZa?=
 =?utf-8?B?ajhkVUhDV0xyT1R4VkdPak9SWUVwbkIveXh5THJwaTJBRnNKYnN6WkFvcWVv?=
 =?utf-8?B?RmNWWlN2NHF2a2N6SUxLSVN1emFhb1BxekxlMjFaMjBjbDY5azF4M2ZHbVhB?=
 =?utf-8?B?V21sZjhoYzFSRGhrUmVRSWtCK0gvMGtyQ3ZWbmVuVGNBNSt5R2hkdzE3cWc3?=
 =?utf-8?B?TXpUNHoyL1R4azk3eGtaK3N2cWR2K01Eemg0SlhrQ2NEb1E5TWQzWlpBSU1n?=
 =?utf-8?B?L3NNTGVMc3pXdHlwWDZaRXlacWVaQXJnbkN1eGVCdmFqeHZScjFnenVURWhi?=
 =?utf-8?B?Q1pRcXV2aHJ0eWw3ZzdoNEVDT01WY29saXhLUU9Pc0dndUN1cXd1dGM0MVhl?=
 =?utf-8?B?OERqQ2JnOVhCOFozRUo2QkVXUVdQNSsvdDFva2J0cTJ2dzBoUkNKOER5T3RO?=
 =?utf-8?B?VXFJK3ltMjZaM0ZLOGxIUGlRNldlL3BEMDlzZEcxekJwSVlBc3NEcEJudUlV?=
 =?utf-8?B?MFgwZlhJcExIUzNtd2xsaWQ2N0RzeTZvS2p0dmY4Zm16azRFSHVkTFR6MjRv?=
 =?utf-8?B?S3hnZWlEaFd0ZEtWNWpGajFFNjFNUG9UTjllTlZCdHpHWmNOakFGSG1QektV?=
 =?utf-8?B?UjRDMGtQeC9nek16ZVF0eE9GZDB2MHAwY1ZxREtzcHZPcjB3ZHpueUJXandw?=
 =?utf-8?B?ZS9aZGlvMjBMdjVYZUEvemhpa29mQlZQYlR0MDloaGZaMVcrYUdOWWpFK1hr?=
 =?utf-8?B?ZFlKUGVlMWpjZzR2RTg2V2NSeHg4cnp3Ym5tTkszbkk1NGdxclEwbW9iY3dj?=
 =?utf-8?B?a1liSkdvRmZ6NEV2SzN3TVJSYzlCcy85enRQOElkN1ROd1pabmt6ZnlhbFph?=
 =?utf-8?B?MFE5Tll5UGwrZng5aHcvamtrcDdQbXd0VW9KTGtiSFBWZmM5SUQvbW14dW0w?=
 =?utf-8?B?Ym9jK3dGRGlWK0ovZGpCalJLOXUycHRvanRjZmowZWZvQ0lSbW9NSnlqcytF?=
 =?utf-8?B?QTdudng4aTNJWjN6VjNmU2xSZU1hdEh3VW1XZzRQSE9HWGUxTS9WMThyelZH?=
 =?utf-8?B?THByYm1sL1B4b1A3ZGptb3VaaG5WWEpLdDlaTGFENkc1UkVZM2k5S3FDS3BF?=
 =?utf-8?B?ZHB6RG5sZHhVSytoV25Qb1dSdnNudmNGVldTQTJxWUZGRGFuYXQrR3ZiWDZ4?=
 =?utf-8?B?Si8yZTlNd3hsRDYycERhaWsxYnZTMXU0U2Q0YmZKclpyRnV1aUxCV0RqY3ZH?=
 =?utf-8?B?SUlzSUcrOXJjQzh6WFYwYjFGV2F1S1g4aFJHRlNxMUxsanVDaWR2L1hweDNu?=
 =?utf-8?B?WGxrMVN3MklqeHN4N1ZCMENPOFUyQ21TL1gxcEZybytDbDdpMGltRSt3RmEv?=
 =?utf-8?B?dVp3V3BIWnlzNEgwck15VHV0RGdsZTFvY0ZaVHBxQUNtMjRoOVRTRGJQNVdG?=
 =?utf-8?B?WFpSQXBSdlIxTVBwTys4WC9TYzN2ZjAxSUxqS1lkN3g1emlSWE1PTEFmdTRr?=
 =?utf-8?B?NVhNYS9iZTNFZ3JaVE5IdEhLWDRLb1UwTjE3Rm5Kd1Y2Zjc3NnlqU0Z6a3FM?=
 =?utf-8?B?RlFTQk1zL1JpakNNVmJtWFdTU0EzSGM0eGhtV01BdURGeWxyZG53a3NmeVJI?=
 =?utf-8?B?a3pNb0k0aG9Tb0g4Yi9jZVFMem0xaGJDQzlWM1lyWUV6OHQrWXN2cG83Y3R4?=
 =?utf-8?B?ckR1VmRLK1Z2MmZadkxhenNNSG5KTW9Md1d1WEFVWW9xT3I3U0loY2Rmam82?=
 =?utf-8?B?NGtpQ1lMU3Zsd3dUaDZkRnF2OEh1UnM2aElqTTF3cis3d1ZmQUUzd1lYZTVJ?=
 =?utf-8?B?clN4Q25YT2RZa0gxakw4SGdHR2hpcVN2dVd2SHMrTEFvNVpma1dPanRHWDYw?=
 =?utf-8?B?WEdldFYrR2ZNOTdDVFN4UHlBSHFtMFhIZ1dDVktFVkhlajhYeDRsOUx0MDIv?=
 =?utf-8?B?M0pOTDdSWTFZWWtBbnNKbXg1ZkVTMEVNTy9LbFFhTDd2Njh3R21NL3RyZmVK?=
 =?utf-8?B?cHVKT2VjMEdqZVcya2Z0dDRvdXBNZG44S2xmY01Lb3djTFBYNUcvOTFWZEMy?=
 =?utf-8?B?Z2NoZU9jcmV1S0d1MEN2ZStVMC94YjRlZElCUHdxV0VkTVNncXZWRWkrTGNG?=
 =?utf-8?B?MkpEQlFkcmhwMFJHNEQyR21zK3U2ZG10MzhHcUx3NTRwREpURE0vQmxHM0pO?=
 =?utf-8?B?TnBvTXVxTzZ2VVFwcFBlRDBXeXlIOHlHM1hnNkZkYVpSZE5mQWJQWHl6SW40?=
 =?utf-8?B?bnhaSDlHWEpDNmdDRFhBYXhJOUZYWXhYd1E2MWZCdjMzOEI2QlU1NU5tK0h5?=
 =?utf-8?Q?FOdKd9J4YgD6n39oPS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b491d213-79b1-405e-12ef-08de760d5b0d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:34:47.0607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6iDshPutuUD4K/QDdGNsoX9oeqRZH4fRaKa+mtJRdfBJQwUObWWP8XuulRoRPbG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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

On 2/16/26 16:49, Srinivasan Shanmugam wrote:
> Add a minimal producer for the render-node
> eventfd subscription mechanism by signaling a fixed event_id on GFX11
> MES/userq EOP interrupts.
> 
> To reach the correct per-file registry from the IRQ path, plumb the
> originating drm_file's fpriv into the userq fence driver, and in the
> EOP IRQ handler walk:
> 
> doorbell_offset -> fence_drv -> fence_drv->fpriv -> eventfd_xa[event_id]
> 
> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c          | 14 ++++++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b700c2b91465..a3a38efdc3aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -820,7 +820,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	queue->doorbell_index = index;
>  	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
> -	r = amdgpu_userq_fence_driver_alloc(adev, queue);
> +	r = amdgpu_userq_fence_driver_alloc(adev, fpriv, queue);

The fence driver can't have a reference to the fpriv since it lives longer than fpriv.

That whole approach here won't work.

Regards,
Christian.

>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
>  		goto unlock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 212056d4ddf0..507defcfabd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -76,6 +76,7 @@ amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
>  }
>  
>  int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
> +					struct amdgpu_fpriv *fpriv,
>  				    struct amdgpu_usermode_queue *userq)
>  {
>  	struct amdgpu_userq_fence_driver *fence_drv;
> @@ -102,6 +103,8 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  	fence_drv->context = dma_fence_context_alloc(1);
>  	get_task_comm(fence_drv->timeline_name, current);
>  
> +	fence_drv->fpriv = fpriv;
> +
>  	xa_lock_irqsave(&adev->userq_xa, flags);
>  	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
>  			      fence_drv, GFP_KERNEL));
> @@ -192,6 +195,8 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>  	unsigned long index, flags;
>  	struct dma_fence *f;
>  
> +	WRITE_ONCE(fence_drv->fpriv, NULL);
> +
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>  	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>  		f = &fence->base;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index d76add2afc77..8fa444a07f77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -42,6 +42,8 @@ struct amdgpu_userq_fence {
>  	struct amdgpu_userq_fence_driver **fence_drv_array;
>  };
>  
> +struct amdgpu_fpriv;
> +
>  struct amdgpu_userq_fence_driver {
>  	struct kref refcount;
>  	u64 va;
> @@ -56,6 +58,7 @@ struct amdgpu_userq_fence_driver {
>  	struct list_head fences;
>  	struct amdgpu_device *adev;
>  	char timeline_name[TASK_COMM_LEN];
> +	struct amdgpu_fpriv *fpriv;
>  };
>  
>  int amdgpu_userq_fence_slab_init(void);
> @@ -64,6 +67,7 @@ void amdgpu_userq_fence_slab_fini(void);
>  void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
>  void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
>  int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
> +					struct amdgpu_fpriv *fpriv,
>  				    struct amdgpu_usermode_queue *userq);
>  void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
>  void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index b1a1b8a10a08..b06adeeeed2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -54,6 +54,8 @@
>  #define GFX11_NUM_GFX_RINGS		1
>  #define GFX11_MEC_HPD_SIZE	2048
>  
> +#define AMDGPU_EVENT_ID_USERQ_EOP  1
> +
>  #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
>  #define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1	0x1388
>  
> @@ -6489,6 +6491,7 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>  
>  	if (adev->enable_mes && doorbell_offset) {
>  		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> +		struct amdgpu_fpriv *fpriv = NULL;
>  		struct xarray *xa = &adev->userq_xa;
>  		unsigned long flags;
>  
> @@ -6496,7 +6499,18 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>  		fence_drv = xa_load(xa, doorbell_offset);
>  		if (fence_drv)
>  			amdgpu_userq_fence_driver_process(fence_drv);
> +		/*
> +		 * Read fpriv while fence_drv is still guaranteed alive under xa_lock.
> +		 * fence_drv->fpriv is cleared during teardown.
> +		 */
> +		fpriv = fence_drv ? READ_ONCE(fence_drv->fpriv) : NULL;
>  		xa_unlock_irqrestore(xa, flags);
> +		/*
> +		 * RFC: notify render-node eventfd subscribers for this drm_file.
> +		 * Mapping: doorbell_offset -> fence_drv -> fpriv -> eventfd_xa[event_id]
> +		 */
> +		if (fpriv)
> +			amdgpu_eventfd_signal(fpriv, AMDGPU_EVENT_ID_USERQ_EOP, 1);
>  	} else {
>  		me_id = (entry->ring_id & 0x0c) >> 2;
>  		pipe_id = (entry->ring_id & 0x03) >> 0;

