Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1A0EC1430
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 12:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6B710E06C;
	Tue,  3 Mar 2026 12:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VQSWaibd";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12AD810E06C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 12:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzAEp/yVUVqdw7FVeCAFbz+tUDP6j3uwteEjNgPq96TJB7UbYYC2Q9YWA3+A+xUid7wh4IXVUafzQuOAQvc2B27hiTy6Bzue0oCBJAKAY7MzcavxSWOCRpDojyY5NoocZ6ZoWAb0na8ebMw0bDIs3UcFVbZHPetW71uzroryDunyEGoVEN2ZcR9yR4afpdvfRZBmukYnUmo270D7G1B2329xH16hYfyDUJEHgETQoBYpYr5XKA8VdcIhjbNs/oZ2HrLCknGrpwoNV0ahnsQI/wxFTBsjpIdN4We7vc3hKK02w1aRpkKWA0mZ14PzjkkKfLZKi1LcxPdHZ1ll91thFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+SUxptQ4OV9/m82FLSt6rsez8FJUAoe1k/345/Vtlw=;
 b=CFyqu/TlmjPFQNpemSLQuQXGIPufaV3XmqU2OTaty4i04AQHEAYfsVVj/uJXjmt5XwZ1Qsv1/d93GoJInARrpdGCYEuY9VvVSKN4Srx0jNfp1OZ/I61XYceN+UP5I1zxNmvL9TDKsuBkXivrg/aiEq9s+kp0EpQNmdfoSYD7rPbj8wD9CTIwhrKW5am6yeCu6fiCoRKYVQY4FC0ukZD4Jv22L8d5/3F5YMDkOiAnj+LiF0pVy48Chpq4/L9pQ06T1RGZ6RXPlqdjgAyN1NBags48XXXlyqERmP189Y2wlP9ff+SUU4NzaDGDXQfF12GHIeLp7VA8fbwKxKTWXa38cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+SUxptQ4OV9/m82FLSt6rsez8FJUAoe1k/345/Vtlw=;
 b=VQSWaibdL5LF39chhPctsh32iRsx9RGIxNJxwpWzi5lNORtAQm8jD5kit9W2UtKCUsUpa/AY/unMhsKqZ3+FFO3XdxrZWhbFhYvkMTpMBkfUntaMTJT2+zIEQJJg3OH+B6+GRaPxbmQiVqJB4ouXzRobq7ByNAYKr1Z1w9KI4jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Tue, 3 Mar
 2026 12:48:05 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 12:48:05 +0000
Message-ID: <3ff02c46-3316-4eb9-b468-378f2f0bc6e2@amd.com>
Date: Tue, 3 Mar 2026 18:18:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260303120849.2583663-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260303120849.2583663-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d11849-b33f-4e12-fd37-08de79231d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: YYGvfCvHWTsbhIx3FR5rhyALAllts3RjMdedAQR436KvsizvVB60Nlgx2GzTo0/BUXKupPHcwrvlH986IP+2Lh3XJRORG1UXu5JONKaRrT3H0i9r7VEQWY21E243piNQ0e1KoDHD/42qamKU5BjYV5euvOPBj2L4gK5+MTxug5JeU7J0e10xwG+UiKr3oTFtLq6AtODknCpf4lP+tAFFuLVtgCNpaS8Q7MgldgWPc+jXRwHj0fhMdaa4kp0+ACetWkfqnotIwgK7cnU7lQKuT69kIsW+fgmlBuDNnz9njGzMbQrc39jpbQJ3r7KVytnfghK20ypZ4GGZj/XkYW0GIcaovcuiKgw3czpOsg8QsuKCQpchBkt48gfcA95NXw6sBO3fMHMuTZlbVPiWwXQlMleLvthElpczig/j7+TEmHqIij7KMQhHTVjAVExVmKUNokDOf6DaJpeE8iU7hhC43JTBoA0M3AWQjNIvLbEjbEFAlj4WHO2xQwUfj2qQMaEFydJNMlGwCmC/yUHxmQMOi5idbdNZ0IWftOXmduXRSVt8VAWbN9ZWOaOHV9f0ArCZkgyue1rF/AOuP1Q5pT0Jjw+JxtrXz6JPE5fmMmYKBnqMvGDuDiapRluS/6z3SJV6Nw6190y84nWdVooDB16bJ812pbEC7w6IrAP+CNCDOgHuleVbyPOh43gy3os+7eXLEn8vs3xaoqotxWr7OuXIStc8L6CSf2NbnRjaF1opzp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFBNakdQYkxxQnl0cnAvSTArZjhqNElyWE04ZUM0MTduZUo3dXQ2RithMmdr?=
 =?utf-8?B?azNEcmFUWWxrOHg2aXVQbVNDZWNZclRRbmFIb1pBUDNYK2tUMkR1dkZPVGVi?=
 =?utf-8?B?aThka09FRkx3SkpVL0FXQkVnR1g4bTV0TzR1alRCemVFMTVyT0V3bUZpR0la?=
 =?utf-8?B?NVJ4MTBjWjlWdW5BZkhTNTlmekhFTnhQbUtCQkxmbi9hMDhSRFF2cGd5MDhZ?=
 =?utf-8?B?SnRLNWVCekl3ZllYcnc2NEtRZmdIWFBJaFpWajVXcHlqQWtXN3JpWFRQblgy?=
 =?utf-8?B?dk4rSUlHcjBXclgweWdTNDJZRTZ0akgzN3JRdnZLRkxBTjA4eFRBbk0vblFn?=
 =?utf-8?B?N29vaXlLUVFlVjlmZEZXSTJmVGNlUEQ1Q2dGeEtMaHdIS1Q3em9aeDZRWjYr?=
 =?utf-8?B?bmkxOTZkVS9VTXhxYlhMUW4yT3E0bllMb0oySk5YalI5RTNhRHZIVjJoUmtw?=
 =?utf-8?B?UldYOWNBMDFtL0MzTTBKNFNYS1NNMEd4RnBmdlRyUk84b1UwejFFdlQxeWc4?=
 =?utf-8?B?ZTh3UXM4VVNONy9tOWNudlkrMmdyM3ZtOGpNQ0lhZ25jUk9pUEZxbEVVY2Y0?=
 =?utf-8?B?ZzBhRUlFSkxyR3dJMDBqWFZJZmJ1Mzl5UURHdEk5Z09YbDgwUVU4QUZueUFV?=
 =?utf-8?B?VnYrR1JQZEhYdnJzZmhXbjB0QnV2TG9hTCtVbFZLazRUMjNRbkhhTlNVd2R4?=
 =?utf-8?B?amt0UkFaZGtTRjZXUmF4QkM1SitvV3ljNmtucnpZQjBGYXJjVEJGQUlqcGph?=
 =?utf-8?B?U3dleWUrVjM1VXRGY2RURnplQ0o2ZDd5cXRJZnEwMElaTkVtdlBiVk5lbTNB?=
 =?utf-8?B?aUlsT3ZsN3dDWVNxTzhxMjUxcFB4eE5jaUlxMkxZN1Jrb1pWV3hwVDVtaUJ5?=
 =?utf-8?B?UU5ES3RSeUVaN0dXbUlnQms2aEtjZ3RaSTg1QzdOSFhiVGJKMmtZUElmNEhz?=
 =?utf-8?B?cWZYbDFLUU5yRGlvYmlONnVHVnQ2dWdzeitwY0VZTVRXT1hxcktzdXhxaG5u?=
 =?utf-8?B?WE4wVEkvYlpsemJnOEgzQkFzNUdneWdyL2l4bXljYXd4RERGUVFybnNjQXBW?=
 =?utf-8?B?M0d5VHg4OTBPSGdKSmxQaHlxN1E0Um9tdDViZ0tpR3JMM0JTQUxLUW5ZaGRR?=
 =?utf-8?B?U2VNRzlNT1J2czFvL3c0eXB6NTdsNUtwUTNTeDBPZG5uQVdnYzVSVUtNcEx4?=
 =?utf-8?B?K2RML2F6Z1VJTkIvb3dvelFDeDlWVDRwRGlmZ2JoNzRBR2QwN0hSQVExSXRI?=
 =?utf-8?B?ZjIrTnRFYlNUUXJoWUpabDhLeU8xK2lwdTZxRjBSWGF2bUppSURWWkYzc25s?=
 =?utf-8?B?b09pVmdJcmI5aDVrQ2hqbzUzaGdoT0tMOGxlT3VHNk1hbjRtamg3ai9QRTQ3?=
 =?utf-8?B?U0RVTWpBYlR1eUF4eG43T2V4WXFSZHZkVkNJTXNvWjVFZXVKY2tTazZLUDFL?=
 =?utf-8?B?T2pKZDJ1Z29TY2IzODVCWHVMY3htQmxnNHZVbG5pVHZMVHEwY3l1akl4Wlhv?=
 =?utf-8?B?TXJrcU9zTURyN0VKMzFiU2hPU0kvZmVqcDlFeHJEbDk4eGNDckpQU2NpSHYw?=
 =?utf-8?B?VVNyZzNyaDM4RHdZdzI4NGVIYWZ4UUhyeXpWTGVhdzhsYWlWS0FSdnpMZHZv?=
 =?utf-8?B?Z1FlRStIUGpGSDJGd0VIOTVHNE02STVoMTJpb0p3eG51emhhYjkyaVcvRkJM?=
 =?utf-8?B?d3RrMzR1Z0M2UGVLem5xYUNmMEY2dzlJcHp6QW8xNGxBZUpOZjI5OWtNWWVp?=
 =?utf-8?B?OFRQZXpLcnVVeFhVeW1Ndmc2OFQ3OWwyVzZid2ovYVBWL2duWEh6UXdtUjJ3?=
 =?utf-8?B?bDl2bk9CZUIyWklHaTdCcmhDWXVPTUc4TERsYjhGRHNuaXZWWnRYb2NMY0N1?=
 =?utf-8?B?Q2l3N2svUm5UWWJLaml0ZHpGRWxYblhvczJ1L0FJR3hqZXBYWi96UmU2UTUr?=
 =?utf-8?B?VW5ScTY2Rk0zUXdlU2oyYjJIaGFVQVNxbGtPdVRLZm5jM2FPbmtUVkN3dXhG?=
 =?utf-8?B?SlB6QWhVUEx0bmVTUS9jK0ltSXRhd0lXZWxoWmpTOUV1cGJVZ0VYMWJzNXYr?=
 =?utf-8?B?cVpDZ21DN3NOa1VyV3pxeU41MzljMWNxcngrY3pxK2ZCSHUyZkpVSndSME5j?=
 =?utf-8?B?ZTZqMW0wNUhGVkF1TTJhKzhIeDRWSTdnV1R4bFBaclZ3KzM0VHlKU2F2YTdq?=
 =?utf-8?B?alhwRjRHcnF5eFIvb2hCTm1vNWFPSFdPM0JXRlBXRXlGU3V1cDNvZkhYWWpH?=
 =?utf-8?B?TEZaL1dud2M0L2UzL0k0OXZZcVRtU0dRYmlyS0J0VS9aTG5BUGJuTlc5Z2JO?=
 =?utf-8?B?TEFEOXVvS1RPbVlqTnRFQkhZb29PbHVGcjhhNHlVZ3FBSGNXVy92QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d11849-b33f-4e12-fd37-08de79231d05
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 12:48:05.5128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5uwHDOErykhpLuFwNhmC/OdVTMIfS8v783FZ+81Pb1CWrudhMjO7LRaZakKGjYSyHAb2eYcOFKU+t+yqIhdyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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


On 03-03-2026 05:38 pm, Sunil Khatri wrote:
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
>      [Christian]
>
> - Pass queue to the amdgpu_userq_put directly.
> - make amdgpu_userq_put xa_lock free since we are doing put for each get
>    only and final put is done via destroy and we remove the queue from xa
>    with lock.
> - use userq_put in fini too so cleanup is done fully.
>
> v4: Use xa_erase directly rather than doing load and erase in free
>      ioctl. Also remove some of the error logs which could be exploited
>      by the user to flood the logs [Christian]
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 110 ++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  14 ++-
>   3 files changed, 91 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e07b2082cf25..ed6a9d779d1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -446,8 +446,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
>   	return ret;
>   }
>   
> -static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
> -				 u32 queue_id)
> +static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>   {
>   	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>   	struct amdgpu_device *adev = uq_mgr->adev;
> @@ -461,7 +460,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>   	uq_funcs->mqd_destroy(queue);
>   	amdgpu_userq_fence_driver_free(queue);
>   	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
> -	xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>   	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>   	queue->userq_mgr = NULL;
>   	list_del(&queue->userq_va_list);
> @@ -470,12 +468,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>   	up_read(&adev->reset_domain->sem);
>   }
>   
> -static struct amdgpu_usermode_queue *
> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> -{
> -	return xa_load(&uq_mgr->userq_xa, qid);
> -}
> -
>   void
>   amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>   			     struct amdgpu_eviction_fence_mgr *evf_mgr)
> @@ -625,22 +617,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   }
>   
>   static int
> -amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>   {
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>   	struct amdgpu_device *adev = uq_mgr->adev;
> -	struct amdgpu_usermode_queue *queue;
>   	int r = 0;
>   
>   	cancel_delayed_work_sync(&uq_mgr->resume_work);
>   	mutex_lock(&uq_mgr->userq_mutex);
> -	queue = amdgpu_userq_find(uq_mgr, queue_id);
> -	if (!queue) {
> -		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
> -		mutex_unlock(&uq_mgr->userq_mutex);
> -		return -EINVAL;
> -	}
>   	amdgpu_userq_wait_for_last_fence(queue);
>   	/* Cancel any pending hang detection work and cleanup */
>   	if (queue->hang_detect_fence) {
> @@ -672,13 +655,44 @@ amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>   		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>   		queue->state = AMDGPU_USERQ_STATE_HUNG;
>   	}
> -	amdgpu_userq_cleanup(queue, queue_id);
> +	amdgpu_userq_cleanup(queue);
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
>   	return r;
>   }
> +static void amdgpu_userq_kref_destroy(struct kref *kref)
> +{
> +	int r;
> +	struct amdgpu_usermode_queue *queue =
> +		container_of(kref, struct amdgpu_usermode_queue, refcount);
> +
> +	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> +
> +	r = amdgpu_userq_destroy(uq_mgr, queue);
> +	if (r)
> +		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue\n");

Sorry missed to print r, will add in the next patch or if there is no 
further comments i will add this before pushing the code to amd-staging.

Regards

Sunil khatri

> +}
> +
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +
> +	xa_lock(&uq_mgr->userq_xa);
> +	queue = xa_load(&uq_mgr->userq_xa, qid);
> +	if (queue)
> +		kref_get(&queue->refcount);
> +	xa_unlock(&uq_mgr->userq_xa);
> +
> +	return queue;
> +}
> +
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
> +{
> +	if (queue)
> +		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
> +}
>   
>   static int amdgpu_userq_priority_permit(struct drm_file *filp,
>   					int priority)
> @@ -891,6 +905,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   
>   	args->out.queue_id = qid;
>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +	/* drop this refcount during queue destroy */
> +	kref_init(&queue->refcount);
>   
>   unlock:
>   	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -985,6 +1001,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   		       struct drm_file *filp)
>   {
>   	union drm_amdgpu_userq *args = data;
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_usermode_queue *queue;
>   	int r;
>   
>   	if (!amdgpu_userq_enabled(dev))
> @@ -1000,11 +1018,14 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   			drm_file_err(filp, "Failed to create usermode queue\n");
>   		break;
>   
> -	case AMDGPU_USERQ_OP_FREE:
> -		r = amdgpu_userq_destroy(filp, args->in.queue_id);
> -		if (r)
> -			drm_file_err(filp, "Failed to destroy usermode queue\n");
> +	case AMDGPU_USERQ_OP_FREE: {
> +		queue = xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
> +		if (!queue)
> +			return -ENOENT;
> +
> +		amdgpu_userq_put(queue);
>   		break;
> +	}
>   
>   	default:
>   		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
> @@ -1023,16 +1044,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>   
>   	/* Resume all the queues for this process */
>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
> +
>   		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>   			drm_file_err(uq_mgr->file,
>   				     "trying restore queue without va mapping\n");
>   			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
> +			amdgpu_userq_put(queue);
>   			continue;
>   		}
>   
>   		r = amdgpu_userq_restore_helper(queue);
>   		if (r)
>   			ret = r;
> +
> +		amdgpu_userq_put(queue);
>   	}
>   
>   	if (ret)
> @@ -1266,9 +1294,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>   	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>   	/* Try to unmap all the queues in this process ctx */
>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
>   		r = amdgpu_userq_preempt_helper(queue);
>   		if (r)
>   			ret = r;
> +		amdgpu_userq_put(queue);
>   	}
>   
>   	if (ret)
> @@ -1301,16 +1333,24 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>   	int ret;
>   
>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
> +		if (!queue)
> +			continue;
> +
>   		struct dma_fence *f = queue->last_fence;
>   
> -		if (!f || dma_fence_is_signaled(f))
> +		if (!f || dma_fence_is_signaled(f)) {
> +			amdgpu_userq_put(queue);
>   			continue;
> +		}
>   		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>   		if (ret <= 0) {
>   			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>   				     f->context, f->seqno);
> +			amdgpu_userq_put(queue);
>   			return -ETIMEDOUT;
>   		}
> +		amdgpu_userq_put(queue);
>   	}
>   
>   	return 0;
> @@ -1361,20 +1401,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>   {
>   	struct amdgpu_usermode_queue *queue;
> -	unsigned long queue_id;
> +	unsigned long queue_id = 0;
>   
>   	cancel_delayed_work_sync(&userq_mgr->resume_work);
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
>   	}
>   
>   	xa_destroy(&userq_mgr->userq_xa);
> -	mutex_unlock(&userq_mgr->userq_mutex);
>   	mutex_destroy(&userq_mgr->userq_mutex);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index f4d1d46ae15e..54e1997b3cc0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
>   	struct dentry		*debugfs_queue;
>   	struct delayed_work hang_detect_work;
>   	struct dma_fence *hang_detect_fence;
> +	struct kref		refcount;
>   
>   	struct list_head	userq_va_list;
>   };
> @@ -114,6 +115,9 @@ struct amdgpu_db_info {
>   	struct amdgpu_userq_obj	*db_obj;
>   };
>   
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
> +
>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>   
>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..a7ded25346b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -470,7 +470,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	struct drm_gem_object **gobj_write, **gobj_read;
>   	u32 *syncobj_handles, num_syncobj_handles;
>   	struct amdgpu_userq_fence *userq_fence;
> -	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_usermode_queue *queue = NULL;
>   	struct drm_syncobj **syncobj = NULL;
>   	struct dma_fence *fence;
>   	struct drm_exec exec;
> @@ -521,7 +521,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		goto put_gobj_read;
>   
>   	/* Retrieve the user queue */
> -	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
> +	queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>   	if (!queue) {
>   		r = -ENOENT;
>   		goto put_gobj_write;
> @@ -612,6 +612,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
>   
> +	if (queue)
> +		amdgpu_userq_put(queue);
> +
>   	return r;
>   }
>   
> @@ -626,7 +629,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>   	struct drm_gem_object **gobj_write, **gobj_read;
>   	u32 *timeline_points, *timeline_handles;
> -	struct amdgpu_usermode_queue *waitq;
> +	struct amdgpu_usermode_queue *waitq = NULL;
>   	u32 *syncobj_handles, num_syncobj;
>   	struct dma_fence **fences = NULL;
>   	u16 num_points, num_fences = 0;
> @@ -863,7 +866,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		 */
>   		num_fences = dma_fence_dedup_array(fences, num_fences);
>   
> -		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
> +		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
>   		if (!waitq) {
>   			r = -EINVAL;
>   			goto free_fences;
> @@ -947,5 +950,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
>   
> +	if (waitq)
> +		amdgpu_userq_put(waitq);
> +
>   	return r;
>   }
