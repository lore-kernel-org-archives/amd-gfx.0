Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870BAF9D0CD
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 13:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19EC510E596;
	Tue, 14 Apr 2026 13:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YaYKi2MB";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987ED10E596
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 13:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CguOsDo+QTCr/7bWz+LPLl1Z+5pHQvyYNNInVHBYLioTLvdrUGtwtyBtRLl31Bij4xGWJs7lrgUC1diX+u+rIo3lxA3o2i1ZcDqpHn3qtpHVEAGV7ad9uRkvVceNbRESQrS4Al+XbzcdU4LZyTRH75Iul9d0oDz7Gc4g4kKWfc1A/ozc/3F3aw3e+ephv282OwZU0b0xa6SvI4jJMKHOtipou1w3lDG8LxdXlT2SzhMLUvSQkxvCC8KPuv9+RdAoAVV1gft8MgdbluePWVJzfAUmnk8f07iJ2t5iyZu1lId7vjc+yt4YBbZ1WVvb/qv0LPUpF5lsMc5qNQta73RjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjedltCUTBwJzArwZBIn9Qq3EqGMTOGInZEGhWzZNyE=;
 b=CnomtvF1FVix671i+0YuaNBp2VXN1KeSgEkOwCUwZsfJsOB5IPL1H1ioc/I/d4mR6wFTD6CL7zrOpaohca7p2fH3m/nFOfww6nXahY/gk53gI6aG/8Hxf148ifUQaUPHzkN6VGWttmS+yJp20nXH6XgLOQEdJiVp06Pdm0VD3yqTOKRVaO1K2FGa5zw9n3dP1I3zfHevNQqvwwLU1RnQghJOWLVeN7Sh67DQpVKnDpEB4uhTf+6yzQVdwO4SH9/GQcmaCM9me3RhW9ICkoanJt+5e7tpXzRnVkJ+i3JuDHwgZlps24cAhW9APRokj59c9TtQnkZZJ1IwwFFVwxjrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjedltCUTBwJzArwZBIn9Qq3EqGMTOGInZEGhWzZNyE=;
 b=YaYKi2MBmKDFDJDnc9gA9BJiG83J8GwttL/PV2H5IUHmBhbCT7JPpn1wVUyryNbOxMMYivRqYRrODBjE1kePykefkMvBydpWOAAs2+yz1GlBXQnsrh/kP3nChsVdRHK0JPbNVejWa10OwxCkT51WQrlpWIHWywQMO4G4KDlurUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 13:35:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 13:35:45 +0000
Message-ID: <bf580889-aaa5-44a2-96e1-b66abea912b9@amd.com>
Date: Tue, 14 Apr 2026 15:35:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: fix userq lock order against reset_domain
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Alexander.Deucher@amd.com
References: <20260414085537.3471717-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260414085537.3471717-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa6e3c5-e4ef-4eb7-f6bb-08de9a2abafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: GskRbqKiOAYjDvV3tadWi7y7hqLYJciu8ymZjsdKXd1VckNf8k6GO+N6qRCk4LAcBdoYKbMGkR000YEWwEW0x2863rZiTeDgXGAIgWgiLT7auUa7+BckaBEuJTw9/i+qSImBbHYhxhr0l+0cZgTxVtHhCcU33gcIZrxrSo/eco4PkY8ZcsCf2XGzEKTNF1542tWhBPZ78/IA1D2o72ek8W3JJY4d14G557hSAkRrpO4GRzfnRfI+3WU3YZJxPnVbJ0OuiKrLYhG5YwSdrt/yyW8fM1u9xVPx/kvh7XBwpcZJSF+ONZfM6zOlPX/aVGQPvFCIIyLdN93YA7aqob6Y3AXVTR/hE5Axy1+dr22bZ7eLU1VB4Mw6IQZAOs8vuYEV+PI+lXMf2GKf8L5Eu9oFF2B6EbA6HY/jfgPcxaMj77dtnR9goze59vW1AUPOPoTqSDiuKsWIAEnUBmkKFDMFBDLspFEbZ6aw1TRq8yMOM/IuUFZyRVQgR68dFmIWTXwB4hwgtTTB3z8aV2lARpEg58aXFulZTVK03VJdpJBUFfD/3V+KPoMA6ww6tzVRFwhBH/xRj25i1r8DEGdwKlh8oitUGobHpWLBJ9iAddTWcJQ1ctojv96nqAR4Vf+2+2fVL0qA48ipr5rhwLbWH1v8bONfZ0TP0HzK5PNSZa7i0AIf4JAGJICcGD9p13lGw1VctA+B8xFqECEHmYBXSrBzIGk2nt2OOAve3Y6FPZbydjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTR6TGFwVzl3ZFJ3ZldTajhJZCt1akhLWlFoM0N2OWgzTmxZSDRVZnkzQXVY?=
 =?utf-8?B?WVZDL3Y5elJWU2FoWC9lS294dDM4QzRxNWc4QS9DMis3Q242Q3VaNGYzL3kz?=
 =?utf-8?B?cDBYUXVsV2s4ZHFyZnEzbHRhbTBjaXBTRnlmMlNieFYzQTA2M0YzRmRMbzlX?=
 =?utf-8?B?R1oxSDMydk1qSEN2UEVPZjdpdUM1Qm83WmE3VGExUVRoMnRtMGxBcElXWVJ1?=
 =?utf-8?B?dlhuTXp5d2tuakhFUng5cFZSNUtvZVlsM2hLL01PRHBxWUwya1FLYm00QXNx?=
 =?utf-8?B?OS9ZUHgzRHRITThQWmRrdFFaVnF5enFER3o1TUJhQkJhcXJabkEyb3J1VkhR?=
 =?utf-8?B?RlFRK3EvbGxMb2dQR3FMNGFKd1FmaFM2ZTNrdWJhZ1dYTENJT0I2cVp1Lzhh?=
 =?utf-8?B?Wk51aXp5M2o0QURvRWhkaGMxM0ltL3E4MHRkWUswUnN0T29kNCtubmQzNXo0?=
 =?utf-8?B?aTk1U003UTAvekNGYkNMUlpzWHh2by9rak9mQmhqYlBjUldpa0Y0TWxYN0x0?=
 =?utf-8?B?OStUblp5RHFsSGp3VldDT21ycXVaeC8vVDB1NWhZejRPekVYVVgyNG9aaEdy?=
 =?utf-8?B?SEZ6eTVBdyt2M2xqZlFSbXVQd3pFU3huM3VnM2Z1anIxQytzR1c2NjJGZHZK?=
 =?utf-8?B?R0thOEhPSzI0YS9rZXZjU0VsZkZBU3pwZ3hFeERlVGM0cDdsWmFLUXpmQVNt?=
 =?utf-8?B?TmRlZTU1V1F5NlFQaC82NzM2V1AxemZQTHQ1SkdzVk9wR3Vjcnh0VDFjTVQ3?=
 =?utf-8?B?VURna24rLzFKZTBJNllLK2V3ZDhwZEMwa0padGpDQWVNN1hjZGV6eWk1SlRG?=
 =?utf-8?B?STRkaTlFNERVL3ZadjR6YnBsMUFzMjRUS1pGU1diMkRHakNpcXlQUVh5RVFP?=
 =?utf-8?B?dUVUa1BpNk83OGVKcVFZcjYwV0wvUlcxd3lyZFlaNlFoQ1hqOVBYazhtcnZw?=
 =?utf-8?B?ZTVlQWlMcEt1NVRQWFhYRnlNZC92QnJ4eWh3enNFT3ZmMXluVXZLUXkyTXYv?=
 =?utf-8?B?SllUaHM3c0t6amNTSm5pNW5MWW9XY0Jtb2pMYkk3YVdxWHdOQkhCUEJWY2RU?=
 =?utf-8?B?eG9YdjhoS0VLWW1tWUZSaE1lc0o2ZytVZEI1c1BuZzdhbzZUN1VuVkNDU3BW?=
 =?utf-8?B?bEp1eDlDR3M0bjFUYkhnTnVOU0orbyt4L1Y1MHhOR0xERDQxR1NLUmFETEc1?=
 =?utf-8?B?MUdoTDZUUnYxTkwxVEZic1BXenZkS1pSUmFvS3diL0Q4eGh3Ni9kRHhsWjRD?=
 =?utf-8?B?K0VoWlZTVG5yNHd6NGJCK3owVkMxSmVJaHVVcnpWM0tCQUM4cXE5ZTRkcm9Z?=
 =?utf-8?B?c3piUEhRY25jMnpMSlB6ZzZVTmdpc0pvN2hEeFN1R3haakZTamlnVGtoU01R?=
 =?utf-8?B?T1kxdzAycFdmRTBXa1BrekRZay9qYWVQbUJFTEVzRnpCMHVuU3JYQ2NKTXo4?=
 =?utf-8?B?UnJTRVlWRlJyODBIajNxUGhnaFlSTGVJSkVraFBidjRCbVFzQWthekpwUlpD?=
 =?utf-8?B?UkUwV0lNbmEralh0TS9kUENMQjNPbXVsdGJDL2dzM3dzb3ltTE5WTUhLd01E?=
 =?utf-8?B?eUZwZnlnUnlWWEpVRkh0QW5Yb3JZYURvd0xJYkNiOWc2clUxQUd0SkdldVRE?=
 =?utf-8?B?RjU5czBQYW5pL1FvbnpmZmQxUUIxRitMd1N0eWZCRTdqVkZLRlNCSm9tdmxa?=
 =?utf-8?B?OHI2VmFxSFM4WURMdU00WW44aDBjZEY5TzlxY2dwM1lLZER6Myt4UHFpeFh0?=
 =?utf-8?B?OUdLNG9wbmJVR21ML1hiVUhmWjBkWWV0ZkQ1SXl6aG5wdVBpb3FHN3lJK0c3?=
 =?utf-8?B?RW9kWTdWN2lpbGRpbVpqSWhmTWRyMWlsMEUxUlVXOUhPRmR2U3VLc1Z4dXpm?=
 =?utf-8?B?dVlzMDZwaGJqcEt5eHZ0eGFXMmtEM0RKeFlJUllGeVIzSGpEbUxTbjhTcFhO?=
 =?utf-8?B?SE12T0E2MithcHZoU25JMGJ1SFg2bkJsVG04MGNBVXFUd25DTXBvTGZOTVQx?=
 =?utf-8?B?bk5wcU9LZUlUM0hvVnRscE1rbFVwR1JHYTlBUmNrdUtCaHRZNDNHWjh1RE14?=
 =?utf-8?B?VkhhbHlSa0ptT1IyZVBTcks2dUVLNkRCZzY1SnlUUG5ROGdEc0Z2RDJIN09u?=
 =?utf-8?B?NS85WVJ6ME01ZWR0azJJZU1uNlQvM201VzR6UjRDVmlldnhqVXZBNHJOeVVp?=
 =?utf-8?B?VXR2WDBqSkRmcFNlMEhjK2d5N0VXRDR0dmxYNmZpZkxaTnhlbHQ3WFl0MU5J?=
 =?utf-8?B?MkJJeVdwUzBnTzNHVWR6SitFRlV4SU03cW4rbEluWlJMUnhUYjgyWTgzYTZ0?=
 =?utf-8?Q?giTDiRZTcJVnMWecEp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa6e3c5-e4ef-4eb7-f6bb-08de9a2abafe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:35:45.1884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXh0bLyrSJXAIlJR0vrJ9hk8bMHoynq1YEvZfy5MOdhKUfQMEyCTUqFZJsGH+Uja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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

On 4/14/26 10:55, Prike Liang wrote:
> User queue restore takes reservation locks before userq_mutex, but the
> create and destroy paths can take userq_mutex and then nest
> reset_domain->sem under it.

Yeah but that is correct behavior.

> Lockdep rightfully reports that as a
> possible deadlock against the restore worker and other reservation
> users.
> 
> Fix this by keeping reset_domain->sem outside the userq_mutex section in
> the create path, and by moving queue cleanup out from under userq_mutex
> in the destroy path. Remove the queue from the global doorbell lookup
> before dropping userq_mutex so IRQ paths cannot access it while teardown
> continues.

This is exactly the wrong order.

We need to be able to wait for fences while holding the userq_mutex and than in turn can wait for GPU reset. So the GPU reset can't depend on the userq_mutex.

The order needs to be:
1. reservation lock
2. userq_mutex
3. GPU reset lock

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2408f888c4d9..551426741a7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -447,8 +447,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	/* Drop the userq reference. */
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	uq_funcs->mqd_destroy(queue);
> -	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
> -	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	amdgpu_userq_fence_driver_free(queue);
>  	queue->fence_drv = NULL;
>  	queue->userq_mgr = NULL;
> @@ -662,8 +660,12 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}
> -	amdgpu_userq_cleanup(queue);
> +	/* Remove the queue from the global doorbell lookup before dropping
> +	 * userq_mutex so IRQ paths can't access it while cleanup continues.
> +	 */
> +	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>  	mutex_unlock(&uq_mgr->userq_mutex);
> +	amdgpu_userq_cleanup(queue);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
> @@ -799,6 +801,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto clean_fence_driver;
>  	}
>  
> +	/*
> +	 * Keep reset_domain->sem outside the userq_mutex section returned by
> +	 * amdgpu_userq_ensure_ev_fence(). Restore acquires reservation locks
> +	 * before userq_mutex, so taking reset_domain->sem after userq_mutex
> +	 * would invert the established order and trigger lockdep.
> +	 */
> +	down_read(&adev->reset_domain->sem);
>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>  
>  	/* don't map the queue if scheduling is halted */
> @@ -812,16 +821,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			goto clean_mqd;
> +			goto clean_reset_domain;
>  		}
>  	}
>  
>  	/* drop this refcount during queue destroy */
>  	kref_init(&queue->refcount);
>  
> -	/* Wait for mode-1 reset to complete */
> -	down_read(&adev->reset_domain->sem);
> -
>  	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
>  		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
>  	if (r) {
> @@ -850,7 +856,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  
>  clean_reset_domain:
>  	up_read(&adev->reset_domain->sem);
> -clean_mqd:
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  	uq_funcs->mqd_destroy(queue);
>  clean_fence_driver:

