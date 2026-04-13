Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E70FEBFD0A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 07:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F382D10E344;
	Mon, 13 Apr 2026 07:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XygeH6P2";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD15D10E344
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 07:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFd7NfSBen5sEpeGW0gtXkRtWu8aFSSScppSZMsKJrRGHkOFe7pC5XEKD8zJtTGoOh5lXR8qDQdmhq03kF7LVnZxiuJ1ivfuILwg2aWsqsdoWwqix97mgxIltYM3+HyGAPwhL8r+LKZwJTWAp4qamN5QeDT2QxtQXvVTmAkDmmBdrHiRo2jyaxjpfKCklHuO7Y8nJ/0rp1ZT+T80xXlt0BQJPKLiFSY27NhwPHH5YNS2nIXghiXS6icFxzd6OdptINBmKWZFtmOILhp82/5Ys7hFhJK7DVeKgqBYNKvmzo7BBso78//3Ym83ESItPLTZdnyUnBPT64BkgauXG5N5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA2TfXhrQlSyXg1G//Updqb4QqocpDSEAKI/3ucXYkw=;
 b=O0xB0qnPqF9/Ma6sjRgFcdC60F9kaCgRFv6cbw6zNB6kmiucNd8Er8bPe62jXBeVotYjt3VkxDuzgrFPlSD6142hZRir4WbomAF+Dvht6MYP3Ya2cjcqqXcoP2KcoLO4OV0qm5gyiHlEvhNdj8KP8h2Bd3KIIOwHAWQQEyT0To3YseEfUeQxx94Cmhz0A1d8I2Yph82qyVOyG+iXqr86QQMPs8gI4KjbqdNBs1UeeiE5OZBbezDJpLWv7kaNSF3LDg9H8b+ff8mFMO3rjLQSMovg4uJ7MwMNO+VU0L415zzqByUtqXHNNC6q4zRYCuaijkUCVShPCWVoKhjt4Rcw8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA2TfXhrQlSyXg1G//Updqb4QqocpDSEAKI/3ucXYkw=;
 b=XygeH6P2+omWYByyJT4ZOlr3FvzY8rwSdPSIaX3qtWNlz5d7CS7lFzTETwmkJFBD1iW6H3nUNBxEAuHSmR3G41Zcqx2DQZFyhQsnyi8d/VxTIA58laxQDqq2spd2qnmbw4D6Dv0p0eqDf+cMfMFuBWk7Xgny93BrkqCE83Pk6M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Mon, 13 Apr
 2026 07:48:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:48:48 +0000
Message-ID: <0e1b18f1-fcc4-41e0-8a0f-5764f103e717@amd.com>
Date: Mon, 13 Apr 2026 09:48:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] drm/amdgpu/userq: caller to take reserv lock for
 vas_list_cleanup
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
 <20260413062153.4050981-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413062153.4050981-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 768c2eb8-f952-404f-1eb2-08de993118ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: lgRroQBBq5/g5FqsPPWjana3Kt7yoJ0mnzCZ3lYz2heSuJXhw1bAY2X7v5/etbdx0ywhOwpSG/SSrHJuL+ufq61xyzeLcVR6nmqbk8+Ku1XZrEa8hCbQTCULWd+pSBzMjQD10PhCAUHPihRq1TrCt4Gz3Q4W08516CbUHIRzYd6UZ+YDUYRx7BRtWBpckV3q/THIouJX2v1Sz+0bFlXg6FvPQkJSAfHraIcDNj93RIO78zNmoQ0H3IC7w8SRxynuW4tI8ggLff/udzbxt0oyfthMs6zGHecDo8SiCqmDbu/RKyN/g5hdAdOBNIRZKEb5r0IRIClCfGRQTSo51BJV1rnRWuE1KQ6ErXPChC+oN1C7q6dAC9Hr8P9gqZvtcdOFnaJkn6DWhCVEVukSFqMEnXVll5OeRFH/uzip60Dhuzpkt8z/jiSQ7BF5O9KtzUcWReoRQFHQcRVQfcjv2VWjUnI5FfGXiMNPmpRgr+Qqo+7TWRRYuCLSkzjzZKDaVXvcRZSRRNjFLb/LgcOiesJZrbYYlMvtXBX3x7DYO0GI1BNpG2Q4/d12mqyt7C8JvDAmLwuqtMhwmsRaDWuaZYAEbN6+7fV1Llg5ep1hHfTcnhjSvY9Cwt4cPfn+3x4nnxClnFfqKyT7k6xEQvTVrOmhG62nQbJfbigX/cKBlmRjlWCZPA2ICZVwlePJPuLtrYRaGWFc9o5xEV7QhBFTKQK3aHZlJZkrRbJaIo1xDwyZaX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTd2bUI0VFBzeTlOWVNxbERYVlJYbWhnUzNMNEZtTStpREJ6aUZnK0Y1YUhI?=
 =?utf-8?B?WENyR1JaNllmcWZ6QUQvUjErTmgvdnNFekFXalpyR2dKZ09pQURNWkpTVTIz?=
 =?utf-8?B?K29aUVNpMjhOREpPeld6QlFxeTJlQXFnd09mNlhhRFloalkvTG1JdUdJR1Jw?=
 =?utf-8?B?dGJ3TDR5Wk5zNGRCK1JRQWxhdkJaVlZiQ1lTK3NQTms2Y1Q2SEFleXZmS2Vp?=
 =?utf-8?B?TWZ3STZqZ2hMSmo5SkU0WDViSzF1SENidHVhditaVEd0SEp3SlhDK0RKWXBv?=
 =?utf-8?B?MHA4alJsa1BBc0xtc28xUG95R0VXVXZ2aXkvOEdrTkNhNG00Mm8wUE9vaHNS?=
 =?utf-8?B?aVVWLzAxMjBPVUt4eCs4dzMvUjMwNk9hQmRzVVdpUkFjVDlQY1RlUGVwS0Jh?=
 =?utf-8?B?VUxubFJiK0FOQXBTMHFRYmE1N3pjdFRMWEp1cmZ0S2JnZU10L0o3WFRDcStx?=
 =?utf-8?B?RWgreHFsZXM4UUphNWwzejRnUmMreE5pUlBPQldBcG5KRjdIM2RGcWFUdWpa?=
 =?utf-8?B?THNVaDB0ZFJiM0lYc2g5S3hFNjBCUGxPYVo1SGQ1a2gvTjgxMVcrRU81Zmkz?=
 =?utf-8?B?cC9obDhDY2FFQVdrbWgzeld3UDJoSnFlVEMwdmFrYnVUN0JJVEplQi8zS2ZZ?=
 =?utf-8?B?dFlPV2szRytDK2xnOUlsWW85d3pwQUlWUEpnVmdBUGVOcVMwWVM3c0dBenJD?=
 =?utf-8?B?NFNXVDBoSWlSSk9IVVhZRDhtR2RGTkE2czhpNWdFbzZqTm1KVmE2ZTBWdXRZ?=
 =?utf-8?B?a21pbkpxUncwV1M3N2p4eEVwN056VWtjeWdmbkY1cklPazdLTlFwM08vME85?=
 =?utf-8?B?OVYwQzdjMkJxc0pRWnB3THFwdkdxRmNPWXg4ZFFYVG5vYi90ODhtajhxbHc3?=
 =?utf-8?B?U1FzSHNreGZjTGlHTnN2YUJTN2RnQkFJWS8rQjB2VHBUSlhMQjc1SUxETnNR?=
 =?utf-8?B?anhHTkNVdCtpaFBTYVBsc1hZQTlvUGExQjhwU1JGZXF6a29qa3dNZUFBT3du?=
 =?utf-8?B?S2d1QUowZGRScEVmYUFqcllpbThoNXc3ZHowL3hMU2tqaGlKN2wrN0VsNnQz?=
 =?utf-8?B?bkhJQTE5WDk1OTAxWXZXcWJYMVdiS2ZKR2NUS1FDeDBDZmRlekJFbFZveDhY?=
 =?utf-8?B?akppVGxhMGlZcFRwUWxHWndCcEQ5OU5Nb0NFMEFBOXZlRDBabGFUV05DN1Jp?=
 =?utf-8?B?SEgrM0piV1BXQXZUei9ZRVg1RlNrT3FxcXk0UzBpYWQ2NHp1cVlQRG9Mc0lS?=
 =?utf-8?B?NWtEYUJTNnJnc3llT1Bwb21SUTYvQzNsWnRvczQ2empqQ29wOGR4TXJaYkhT?=
 =?utf-8?B?MzYxcFpkQWRoUTgydjVUVDdqUzQwcGJaNk5ZTklXUjBYV2JMV3VNNUhQTE5a?=
 =?utf-8?B?blhaVDJkekpHSjgxcU9td1djU0NMcVNZc2FmWm1VTTU5WnVuRGlPYmdzVHN3?=
 =?utf-8?B?WVJMYVZhdEJkdy85bGlNNlVXRGVsR084VDB5dmI2MENEVmZuS2ZQL1pPbjVY?=
 =?utf-8?B?bjhDWEFRUW82M2FTcVJjME9Fdy9ud1hVTlB4eDBvNUltZkVDTXgzdEJYTHRI?=
 =?utf-8?B?RlZHQ3M1Wm1lazlpUldiZHd6SWpueDNTTWJXcGc5aWdiSXVhZjdPVU1salNI?=
 =?utf-8?B?WFhzRE0vUDBXbGJxSjY2Wjg4RStCc1lBSjhuTzlsNjZLVStPZEo3d2sreGZD?=
 =?utf-8?B?Rmhobko0WCtwSlRQNGg0S2FUc0JkcXlaZWJ6U0lLWGZZeGNjNlVmOXdBSDRO?=
 =?utf-8?B?a0wyTDF0QVNpUHRkZVFXeGxKMmpsbE0rdVBjYXNORnBLSkE4ekRNSnNacGt1?=
 =?utf-8?B?WllFZUlqUXk4dkgwK3VOU1IwMHRnT2tnQVFOS0EzSjNrcEVvejJCQ0RkRjZn?=
 =?utf-8?B?aHBRNitVMjgyRWEvM09BbW1kM3FLWEgzbGlVMDU0WmFrWEpyZWhpN0dwT1pL?=
 =?utf-8?B?MFp5MVdDa2M2Z0Y1dW1qQ1NrR1llU1BGU0lCeTZneHlJUlpQakFKTmcyR29R?=
 =?utf-8?B?clJGV1BkU0Nab2dFaUxleUJZSTliUm1wYnJ3K2M4NVREdDV0T2N2TlYraDRZ?=
 =?utf-8?B?VUpaYzNFVUZ0ZUJ3bWkxWTVOVmNrUC9RQmsrandyZ3N4cCtEMExuMmdEb2E5?=
 =?utf-8?B?aHMwQ3BuZVZCdHB3WmpzaU9VQXFvanJDM3QvektHNVhiNEY3eWFCZFp4ckM1?=
 =?utf-8?B?QVpmYTdMR1ZjbkJnTE5FMnIrcTdpMUpGZkswMGx3c2ZIM0NTcU5aNTNlYTdz?=
 =?utf-8?B?aFJ3aWRVNUI0UjA3b1h3Wk1vOU9nUmRjeU1yZDJEQVoycGYwZlVKS01zZGpO?=
 =?utf-8?Q?510RigvcaTym4ePt31?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768c2eb8-f952-404f-1eb2-08de993118ce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:48:48.8382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KrqkqOWqLU1Dn586nXQksCU1pZlxJGPb2iYVDoH9HGM7RkSDH71MhzBe5YCloH2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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

On 4/13/26 08:21, Sunil Khatri wrote:
> In function amdgpu_userq_buffer_vas_list_cleanup, remove the
> reservation lock for vm and caller should make sure it's taken
> before locking userq_mutex.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 ++++++++++++-----------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2408f888c4d9..5154949c9ba7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -312,25 +312,21 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>  	struct amdgpu_bo_va_mapping *mapping;
> -	int r;
>  
> -	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> -	if (r)
> -		return r;
> +	/* Caller must hold vm->root.bo reservation */
> +	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>  
>  	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
>  		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
>  		if (!mapping) {
> -			r = -EINVAL;
> -			goto err;
> +			return -EINVAL;
>  		}
>  		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>  			queue, va_cursor->gpu_addr);
>  		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>  	}
> -err:
> -	amdgpu_bo_unreserve(queue->vm->root.bo);
> -	return r;
> +
> +	return 0;
>  }
>  
>  static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
> @@ -444,8 +440,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	/* Wait for mode-1 reset to complete */
>  	down_read(&adev->reset_domain->sem);
>  
> -	/* Drop the userq reference. */
> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	uq_funcs->mqd_destroy(queue);
>  	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
> @@ -626,6 +620,9 @@ static int
>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +
>  	int r = 0;
>  
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
> @@ -633,6 +630,10 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	/* Cancel any pending hang detection work and cleanup */
>  	cancel_delayed_work_sync(&queue->hang_detect_work);
>  
> +	amdgpu_bo_reserve(vm->root.bo, true);
> +	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> +	amdgpu_bo_unreserve(vm->root.bo);
> +
>  	mutex_lock(&uq_mgr->userq_mutex);
>  	queue->hang_detect_fence = NULL;
>  	amdgpu_userq_wait_for_last_fence(queue);
> @@ -664,7 +665,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	}
>  	amdgpu_userq_cleanup(queue);
>  	mutex_unlock(&uq_mgr->userq_mutex);
> -
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	return r;
> @@ -856,7 +856,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  clean_fence_driver:
>  	amdgpu_userq_fence_driver_free(queue);
>  clean_mapping:
> +	amdgpu_bo_reserve(fpriv->vm.root.bo, true);
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> +	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  	kfree(queue);
>  	return r;
>  }

