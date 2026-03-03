Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A807BEC1421
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 11:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D50510E011;
	Tue,  3 Mar 2026 11:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TXHT/com";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E0610E011
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 11:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcSYapbvNz3kI8EQVoFrfqzVsHePu4FVAuPbgtJXeN5Dn3GHrp8CFCOMrtcC1VMOhMZLtu9H+rAUZU3n7SEw3azUIe4HfqO9w16wQe5E99ENXow47CYLgWT75EghCaoqcvh9aZzIBaoPDLfLAezLCFXFUDch96Oewl3/nwBE0raY0hbeY99T8THvxmseLPAd8tnsMCHPtaC1RtE5AJAAMOX7+hFUYpuztjqd7HT9HTigKyNVMxXv7G6E5No9bX0sXQBWQTtNNMyECemXFzceeS5QYI4+ftUMFCLQ+r+cGOnGqvY24EQhX3PvFIGBhKD4WQxGY2e6nNUTZpc4EVc3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8OYhgYDVQyuLlKEde7JGhRXzvuBz8k0dD8JU2EUDq0=;
 b=DXVuCkR1/WZvduMFP9otiBabAe+SWxVD3kewgy9/qRi/BuyQCcYP7InKp5HLrGRIrZbS5TXxCDM33Yuej+x7ch5RP4XVEb6ynGESyk+Wb9ygWe5JlGnIJJbs+6IOXlmFF+YnRi/g7C5Lx9ueesRshxiji1sdtsRjno7uA4TZ/guYTb8QugZTpgoq2ekBxuiwumv3B9Zf2MfBDIJeMOtfg7kHwTiy3GUW4tPhuTRpLKRvLa67kLQPqpJrjSRqWG3gyNvPGIRBh4aTjnTf++VRWme04hkZBSmvWyCrL+up2thbosjMudmv0MpIktjGJVnw07h+G4b6Fsl2HYCpiTjBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8OYhgYDVQyuLlKEde7JGhRXzvuBz8k0dD8JU2EUDq0=;
 b=TXHT/comgo6t0xUiJQN41vSIqPelEfbbVszr+VVlmi4XUTYEmKNaxF8kZnUo0FHkJ9iH1odbA+E4IuoYJXfjxeTxPTJRC6n7L6A8Oz0Sd2LsguNrBZTx9oRIDJyiCOGyTPVoYawE8p8HLzsrVgS0AajcAxTBV5r+lbKoVaXEfjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 11:50:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 11:50:09 +0000
Message-ID: <b1c1d523-439f-4ca9-a1cc-53a8602755fa@amd.com>
Date: Tue, 3 Mar 2026 12:50:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260303114034.2413456-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260303114034.2413456-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:408:141::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: df9b62f9-3c09-44ea-6370-08de791b0550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: /99rg23pdl+CNVSKpNEASD9VjbognH0r3X0sHsXHIeJqT1jaVtJi/dm1neJrL/BAdqxWPZ7ej1Ok+SP1GfM0Wn1+jS2Ce8miDPlBXOHNu/45e3IawWHvcX5VZUcM2YXgpk2FNeQWABXb5QsL7GEmjSE4m3qN7zenQBaNh0gw3gIG55bIp4C320HtAGedsqGAuNiWInUhfBXGVXwFoZgt2Zi0yjomQWfIeFVHaaMUDRjQDxTeufl69Unkth4O3al1qmBLvYg4rieuhzTJPGzlepocGwfP39SxMWG0zOa/LZl4slX59DHKsJrKxj4ux9HuCij+L1KoHKO9lKs8s25/AxqpxW1l7EdkDAd3IVU1U+KGv6N+Z1BM8lTJTXrcgPIi5PcTiRDYCvQDSKd3VQZgUidFk3XM/UiPXfgbjHUEPstIAfpihQQ7IdKQc1NKCbhG4RgBalFBGpEshW6T5TE1UvsfSr3H0cesOR4bFimGHKs3wLc6gGbm1e7jJns7zjdx6ak+3Az45k6gD38ALJuIgcfSjAVAaUIG7nEmCoBemtNWH80PI21ZC5vlFc+kWuS5mgTJ5umLwo8KSs3idsgIF/sF+G0O6hkeZrjHcsgq40NDFw8O5U/JP/Qkmt9gYox/PKmpywVpVv9vjILIa4WAqw/iq/QVQkgKJJFknZDCy8pMxLR2fIDgw3tk1N5xFuCZjiLiGMLhnqMEDCQPRcUPkD6TTX85zwUTmNumHZWnv2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpRSld6Z3dka05Lc2daVUhoMHJ2QVNMUStobzVHcTRqck1kWnRkOHZ3UHpv?=
 =?utf-8?B?SWlsZERSME4rQTN5TWpSZW9GWGowWUJJaUtxQnJPSUwvMW1EMjNZTFR3eDVp?=
 =?utf-8?B?VmlKNkdTbWNsNDhOb2JCMzE5ZmY2VDNpc24yRElzNDRJSnlDYkYyVUN5QlJF?=
 =?utf-8?B?a0Q4NWhvaGVHZmtMckpaaE1LcCtleG9WcWRRb2FqcDI4Q0MraVVFcUcvWHpq?=
 =?utf-8?B?eGdvd21aeC9taFZYZUhNTE4zcXphUnUxckE3VFZvc29FcEpGVDdFZFVzeU1p?=
 =?utf-8?B?Q2RJeGVtYk1uSnpLWkZ1bTVGQ0VRU0MzTG1UU1BNQkJ3OCt5V1hHeXVhTjB0?=
 =?utf-8?B?cUx2d3NjWHlSQUVpUXRJc0FKTFhrR0VrWk1jTkF3UDMvWUxIcjhNQjlWcEoz?=
 =?utf-8?B?NVRjb1A2eEo0a0FQWlRJS0dVbkVibHpFMVk3LzJuRXdHUlNhcmQ5S0g1WGxI?=
 =?utf-8?B?ZHdWSS9Ka0gwcCtpT2Q5ZTNLK0J2eXF6RlgvYjAwTXhqOS9DdVlsYUF2RmVD?=
 =?utf-8?B?NGNVVUszVDlveFEyYVFCZjd4T2w0YVE1dEdiM0VpZlJKdnRNd281ZUZ5YzJ1?=
 =?utf-8?B?RmxJZUs0cGpNSkZwTkkxY3lBVDZQcmRURXVha1pkcGdLWHQ2UHBzdXJMVENN?=
 =?utf-8?B?TGYwb2Y2RmNjYnlkYVI3cXkzUkZsRDR3Rloyci9Id2NBbUIzcEM0Y0JmNGlw?=
 =?utf-8?B?YS9wTWxWY0crY1p6QzdoYzNQdmc2UzN6ZWp0cDN2YURTRXdRQStuMTdramJJ?=
 =?utf-8?B?cVdKKytobDYzR0dwbFpOc1dJL1pZNFlYbnl3ZklRWndJVjR6MnNweW5SSzFR?=
 =?utf-8?B?L2xXellWVWhwYlljMkZMUHg0S2lXRzhra0NZaGZKdjhrMGdnZkQvS1ozb1lF?=
 =?utf-8?B?VVl0UEU0OVA4QjhwL01TeE9tU3hRWlRCbzBiNjFsTzBvanFpbFZKNTBrUCt1?=
 =?utf-8?B?ZFdGc0FCT2NsWnNNamVSYXhweVlhdTZFZ3pXR0Rya2JPaFlTTDUvb2s5VmR0?=
 =?utf-8?B?S09oVDk4NXI0eC9jMFZkTEh5blNEbmp2K1VML2ZYTDUyNVZoaW94OHB4YXpC?=
 =?utf-8?B?NzBJVGdMbXFYQUFFK0FISlhMaVh3VjU2cmFHSXdqbThMdjdCUUV0dms2Nk5n?=
 =?utf-8?B?K3E3TC9Za09zQWk2dWowZ3d6UWVtTTUxRy9QRUVtaTl3ZFplN3o4Skh0QlRL?=
 =?utf-8?B?ZmhxQTBzcVZ4TVFsbWpsWFBZa0h3Y1lZd3dLRlVpcjdtTkpuY3M2YkcwaEs4?=
 =?utf-8?B?Ull6QjZOMzNJeXY4NkpGUE5IUDJkUmZXd2QzL25GekltYjJ0MWhmeXkrWEFD?=
 =?utf-8?B?SnJYVlZSdmhmRzI4TmJjU0kxSGF3SnJEZEZINTd6VXk1RWtiaEh0cUdNMExH?=
 =?utf-8?B?cTlVajdyTVRnL0ptTVQrSnlKUnpTSHFOc3FFTkJTQUpKdkRnUGdBWTNKSmw0?=
 =?utf-8?B?dVhNZEpjVFZWcVhpdStwT0dlL1BJSDBUZHBwQThQYmdyOHZXRkJRcE1OYklW?=
 =?utf-8?B?cTA0Y0tpN244bkNwV2FXUGxvNmxmVlROT3JrekNNcHMrT0JPbnJXNUxXWXI3?=
 =?utf-8?B?M0YvMTV1dXFOZGdaWlVEa0xqNnh5M1phRVd1d3ppb0JYc1NzMHFXY3psMlZD?=
 =?utf-8?B?QkRNNUNHNEE1dDZrUmpyd2U2anJTYklBdGZwckMvWXpPdzFUS2ZZQkdGZUdL?=
 =?utf-8?B?SCt4cWMraXR2aWR2ZUhyN0N3bmpMK1JVYldSV1B1R1J6SDRIZ2hISVZLY2Uz?=
 =?utf-8?B?V3BjS3BWdEhKajZNTlRLanQ5ejRwZ29Wbks2QTgxY05NYXVHRnJSdmJZbGsr?=
 =?utf-8?B?Skp4eklKN0Q4TGw4Q1RYeGlZSVRUZ2RKQURmbVlnQndRdmFyekpsaHRJZUY4?=
 =?utf-8?B?TlF1OFUzT04yQVlEcmQxUEZYcW5uZE0xLzI1bm1XcUFPVkZJTUJkUXhnVnRt?=
 =?utf-8?B?dFE2SnJ1UGc2OXhEK0QyNU9tZGtUbVhpS0IwSUExb1VBd2YvVEFXY3Zka09O?=
 =?utf-8?B?UXhISzJqbmNZYzc0dkRNZ3NhbVZvS3hJdzg0S2xRRDhZUVlpakp5WGhTZGI1?=
 =?utf-8?B?bDFOaDR2RDMvdm9ZRTl1TXdvOU5ITEE0NDFSNW4zaTVZb3ZoeFpCWXFXbGY5?=
 =?utf-8?B?UGh1UmpRVmY0RE8xZzIzaWdUM1FkcXNnSU9ndGc5UW9KNGNtMmR4ZWw0bVNV?=
 =?utf-8?B?V2JCRDlWN21ndVhoQUo3eGlqVTRUNGN4WEI1VmRDQXpObFFYdXhraFMweTla?=
 =?utf-8?B?REZaRTRxV0JhbXJVSVhxS01PMUtEVkwwZnptZGJhZDBaM2FaaE1MSG5EWjVq?=
 =?utf-8?Q?VQ2KEMpwTAwjqidJxG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9b62f9-3c09-44ea-6370-08de791b0550
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 11:50:09.5494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiWEe0PzeRdFG198AS2PXQkW8uW2IeSO8MGkMbpHmCkmZmBOM3np3WnZU5knYbSd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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

On 3/3/26 12:40, Sunil Khatri wrote:
> To avoid race condition and avoid UAF cases, implement kref
> based queues and protect the below operations using xa lock
> a. Getting a queue from xarray
> b. Increment/Decrement it's refcount
> 
> Every time some one want to access a queue, always get via
> amdgpu_userq_get to make sure we have locks in place and get
> the object if active.
> 
> A userqueue is destroyed on the last refcount is dropped which
> typically would be via IOCTL or during fini.
> 
> v2: Add the missing drop in one the condition in the signal ioclt [Alex]
> 
> v3: remove the queue from the xarray first in the free queue ioctl path
>     [Christian]
> 
> - Pass queue to the amdgpu_userq_put directly.
> - make amdgpu_userq_put xa_lock free since we are doing put for each get
>   only and final put is done via destroy and we remove the queue from xa
>   with lock.
> - use userq_put in fini too so cleanup is done fully.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 114 +++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  14 ++-
>  3 files changed, 95 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e07b2082cf25..7a4b8caa8547 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -446,8 +446,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
>  	return ret;
>  }
>  
> -static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
> -				 u32 queue_id)
> +static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  	struct amdgpu_device *adev = uq_mgr->adev;
> @@ -461,7 +460,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>  	uq_funcs->mqd_destroy(queue);
>  	amdgpu_userq_fence_driver_free(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
> -	xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	queue->userq_mgr = NULL;
>  	list_del(&queue->userq_va_list);
> @@ -470,12 +468,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>  	up_read(&adev->reset_domain->sem);
>  }
>  
> -static struct amdgpu_usermode_queue *
> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> -{
> -	return xa_load(&uq_mgr->userq_xa, qid);
> -}
> -
>  void
>  amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  			     struct amdgpu_eviction_fence_mgr *evf_mgr)
> @@ -625,22 +617,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  }
>  
>  static int
> -amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>  {
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>  	struct amdgpu_device *adev = uq_mgr->adev;
> -	struct amdgpu_usermode_queue *queue;
>  	int r = 0;
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>  	mutex_lock(&uq_mgr->userq_mutex);
> -	queue = amdgpu_userq_find(uq_mgr, queue_id);
> -	if (!queue) {
> -		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
> -		mutex_unlock(&uq_mgr->userq_mutex);
> -		return -EINVAL;
> -	}
>  	amdgpu_userq_wait_for_last_fence(queue);
>  	/* Cancel any pending hang detection work and cleanup */
>  	if (queue->hang_detect_fence) {
> @@ -672,13 +655,42 @@ amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>  		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}
> -	amdgpu_userq_cleanup(queue, queue_id);
> +	amdgpu_userq_cleanup(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	return r;
>  }
> +static void amdgpu_userq_kref_destroy(struct kref *kref)
> +{
> +	struct amdgpu_usermode_queue *queue =
> +		container_of(kref, struct amdgpu_usermode_queue, refcount);
> +	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> +
> +	if (amdgpu_userq_destroy(uq_mgr, queue))
> +		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue\n");

Probably best to assign the return code to a variable and print that together with the error message.

But in general we should look into reworking the function to never fail.

> +}
> +
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +
> +	xa_lock(&uq_mgr->userq_xa);
> +	queue = xa_load(&uq_mgr->userq_xa, qid);
> +
> +	if (queue && !kref_get_unless_zero(&queue->refcount))
> +		queue = NULL;

This can just be:

if (queue)
	kref_get(&queue->refcount))

No need for kref_get_unless_zero() as far as I can see.

> +
> +	xa_unlock(&uq_mgr->userq_xa);
> +	return queue;
> +}
> +
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
> +{
> +	if (queue)
> +		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
> +}
>  
>  static int amdgpu_userq_priority_permit(struct drm_file *filp,
>  					int priority)
> @@ -891,6 +903,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  	args->out.queue_id = qid;
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +	/* drop this refcount during queue destroy */
> +	kref_init(&queue->refcount);
>  
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -985,6 +999,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  		       struct drm_file *filp)
>  {
>  	union drm_amdgpu_userq *args = data;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_usermode_queue *queue;
>  	int r;
>  
>  	if (!amdgpu_userq_enabled(dev))
> @@ -1000,11 +1016,20 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>  			drm_file_err(filp, "Failed to create usermode queue\n");
>  		break;
>  
> -	case AMDGPU_USERQ_OP_FREE:
> -		r = amdgpu_userq_destroy(filp, args->in.queue_id);
> -		if (r)
> -			drm_file_err(filp, "Failed to destroy usermode queue\n");
> +	case AMDGPU_USERQ_OP_FREE: {
> +		xa_lock(&fpriv->userq_mgr.userq_xa);
> +		queue = xa_load(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
> +		if (!queue) {
> +			xa_unlock(&fpriv->userq_mgr.userq_xa);
> +			drm_file_err(filp, "Invalid queue id to free: %d\n", args->in.queue_id);

That just spams the system log and can be triggered by userspace.

> +			return -EINVAL;
> +		}
> +		__xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
> +		xa_unlock(&fpriv->userq_mgr.userq_xa);
> +
> +		amdgpu_userq_put(queue);

The usual patter is to do it like this:

xa_lock(&fpriv->userq_mgr.userq_xa);
queue = xa_erase(&fpriv->userq_mgr.userq_xa, queue_id);
xa_unlock(&fpriv->userq_mgr.userq_xa);

if (!queue)
	return -ENOENT;

amdgpu_userq_put(queue);

Regards,
Christian.

>  		break;
> +	}
>  
>  	default:
>  		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
> @@ -1023,16 +1048,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  
>  	/* Resume all the queues for this process */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
> +
>  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
> +			amdgpu_userq_put(queue);
>  			continue;
>  		}
>  
>  		r = amdgpu_userq_restore_helper(queue);
>  		if (r)
>  			ret = r;
> +
> +		amdgpu_userq_put(queue);
>  	}
>  
>  	if (ret)
> @@ -1266,9 +1298,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	/* Try to unmap all the queues in this process ctx */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
>  		r = amdgpu_userq_preempt_helper(queue);
>  		if (r)
>  			ret = r;
> +		amdgpu_userq_put(queue);
>  	}
>  
>  	if (ret)
> @@ -1301,16 +1337,24 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  	int ret;
>  
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
> +
>  		struct dma_fence *f = queue->last_fence;
>  
> -		if (!f || dma_fence_is_signaled(f))
> +		if (!f || dma_fence_is_signaled(f)) {
> +			amdgpu_userq_put(queue);
>  			continue;
> +		}
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>  		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> +			amdgpu_userq_put(queue);
>  			return -ETIMEDOUT;
>  		}
> +		amdgpu_userq_put(queue);
>  	}
>  
>  	return 0;
> @@ -1361,20 +1405,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
> -	unsigned long queue_id;
> +	unsigned long queue_id = 0;
>  
>  	cancel_delayed_work_sync(&userq_mgr->resume_work);
> +	for (;;) {
> +		xa_lock(&userq_mgr->userq_xa);
> +		queue = xa_find(&userq_mgr->userq_xa, &queue_id, ULONG_MAX,
> +				XA_PRESENT);
> +		if (queue)
> +			__xa_erase(&userq_mgr->userq_xa, queue_id);
> +		xa_unlock(&userq_mgr->userq_xa);
> +
> +		if (!queue)
> +			break;
>  
> -	mutex_lock(&userq_mgr->userq_mutex);
> -	amdgpu_userq_detect_and_reset_queues(userq_mgr);
> -	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
> -		amdgpu_userq_wait_for_last_fence(queue);
> -		amdgpu_userq_unmap_helper(queue);
> -		amdgpu_userq_cleanup(queue, queue_id);
> +		amdgpu_userq_put(queue);
>  	}
>  
>  	xa_destroy(&userq_mgr->userq_xa);
> -	mutex_unlock(&userq_mgr->userq_mutex);
>  	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index f4d1d46ae15e..54e1997b3cc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
>  	struct dentry		*debugfs_queue;
>  	struct delayed_work hang_detect_work;
>  	struct dma_fence *hang_detect_fence;
> +	struct kref		refcount;
>  
>  	struct list_head	userq_va_list;
>  };
> @@ -114,6 +115,9 @@ struct amdgpu_db_info {
>  	struct amdgpu_userq_obj	*db_obj;
>  };
>  
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..a7ded25346b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -470,7 +470,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	struct drm_gem_object **gobj_write, **gobj_read;
>  	u32 *syncobj_handles, num_syncobj_handles;
>  	struct amdgpu_userq_fence *userq_fence;
> -	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_usermode_queue *queue = NULL;
>  	struct drm_syncobj **syncobj = NULL;
>  	struct dma_fence *fence;
>  	struct drm_exec exec;
> @@ -521,7 +521,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  		goto put_gobj_read;
>  
>  	/* Retrieve the user queue */
> -	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
> +	queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>  	if (!queue) {
>  		r = -ENOENT;
>  		goto put_gobj_write;
> @@ -612,6 +612,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  free_syncobj_handles:
>  	kfree(syncobj_handles);
>  
> +	if (queue)
> +		amdgpu_userq_put(queue);
> +
>  	return r;
>  }
>  
> @@ -626,7 +629,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>  	struct drm_gem_object **gobj_write, **gobj_read;
>  	u32 *timeline_points, *timeline_handles;
> -	struct amdgpu_usermode_queue *waitq;
> +	struct amdgpu_usermode_queue *waitq = NULL;
>  	u32 *syncobj_handles, num_syncobj;
>  	struct dma_fence **fences = NULL;
>  	u16 num_points, num_fences = 0;
> @@ -863,7 +866,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  		 */
>  		num_fences = dma_fence_dedup_array(fences, num_fences);
>  
> -		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
> +		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
>  		if (!waitq) {
>  			r = -EINVAL;
>  			goto free_fences;
> @@ -947,5 +950,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  free_syncobj_handles:
>  	kfree(syncobj_handles);
>  
> +	if (waitq)
> +		amdgpu_userq_put(waitq);
> +
>  	return r;
>  }

