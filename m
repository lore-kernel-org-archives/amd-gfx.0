Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CEAEA3C55
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 11:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7342810E7C8;
	Thu,  9 Apr 2026 11:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="llpAP8Wk";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010069.outbound.protection.outlook.com
 [52.101.193.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF4B10E7C8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 11:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/KfEhy4N06XEvuc1MFdm/YRgeZnwQ5tlR7bbmACUlMMQTQHk0LQTiOhMtmB6r1zumn4OZqxQzzzynEg/Z1d7mKu+s34+YoBdGo/0f4Ea71FUd46IOe0WTblr4e36+xYM0la/bdGsx/grexzqyc9/COl0zxbsSSWSgwshbFmWWUC622USNkivx0/HFTB2a+k7ErMZKMqIW2a3hF1z6vd7C+ClZdv/IHVhcbWfLXV4JjB6JF6EYjYONuL8kENrcgN+SRYo2U7lk6Toniq5q00io6ztxPENoKa77kvOG+0XNeNUF4NEZVy/YDEwBNlYL7Q7E2LGDhbK3r6UE3C8H7MMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnMg2BNGGA4wcHVSSMAolVMChfeY25BSbSXXDch/8lo=;
 b=uKCOe3H1yS9hW/bwyaHrA3FiwgBU0cpcAbzHbBg8pC46kqEDb6Oov5j9dGIQrYU+eMAQTzJgWk6yb+b1HZ7p/PfcpO+MFTkuuZC8LJxqE0QpK22BlHyaiu8DnLTrC2LbuFDFPMoaz8w0WsYkY2fGgW+1j2Cvn+kv9MfE9gbiVJ9QVU8gu5JC/9DU1mlOCZxkAEx7aB/jogy6DE/AC89xOLn4TxU7eXuI5QtmZA2R25GpjjlhMRkbp6h1sLMvnuHgrZdMpudCyyhLZ3c2NyCVbpGPBHqcVjmwto6jOdpLxCY0nSbQebS6xxrRa7JGNq+FggmfMJhgzi7nVEWIQ+JXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnMg2BNGGA4wcHVSSMAolVMChfeY25BSbSXXDch/8lo=;
 b=llpAP8WkxjUTrD47J/7V+DxgQqa0O8sL9/DawPU3HLXwFUNAuqv6ytSZcwTQHgErklwnP8zQkKif48s50DiTQF8xIVR6ooCSPjExli95TyUAI0Zj3lOGWAC6xEmCUB1wCaGTosIQdKvSNDZe5lF3/nE/BUdcK9V43LKtYfnS7fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 11:55:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 11:55:15 +0000
Message-ID: <016e66c4-0268-4b22-b285-b54f0c2f88ad@amd.com>
Date: Thu, 9 Apr 2026 13:55:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] drm/amdgpu/userq: create_mqd does not need
 userq_mutex
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409083355.1326089-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:408:e2::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da23c2a-e70b-44f6-60fe-08de962edcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: JfIlp1F5hHA5PsiTnlD/Or06hMSCr+WTlPvlDLydZW3BZAuWBN7KUNeW5Dp3g/vDs6THHsSEfSiwb5DGeW0MV2tt0Qeb9AjKrVsZcysNQbE0MgPeLQ73Be0gLPjGIgo4ig4Hox9lwL0jm271AvzkIcZ8blB954ZkIRWvEdYnIF59uQID1dAE3Dj9l5DAMmwaDIvKxMF9qYA71KuOsQm+L9HSY/5UDBHkItlyDjvzT7myDUEuOjXE6/C7ygWUMyaquFQkSfHaOelJl2j/Db3zl8eOOOi8FnltyouehFjg4BRi56MjO4cuOxWtDlQkbuuOa/90+bTaaoH1vlhKOkv6VirK71vYvs1MMjEyn/l/8JTL7L+dnA6h7UDAuHkWXdD9xqZMYf4cywVUKsnDMZPLKLoWdhQG6PyzKvFufpON9djtUyAQT9RbWTjk9JJrlpv4sP95S2pjCkzSUwPpZRzlvZcv19gSjk0dDt3/NJ4XQ0Wu2TW2HFmybZqQjGG9/A6kZKA/zT8YSiMJsPRLuN+gyiQwcsJ7jcWgT/m6aCB0k+O9NW/eSpfqjtlo2BssRVyOFze3noQ3TdY6hu4LT6zD/SsVIlWt6qce9HvlFRc+y3nhXle9Phr0T9RvxT67MrJkmXvYAgbx2Shs30O01WT/dBZbPxqre+WxMcsBxDyQmPF62rPg+oPRi0v+aGd0u1txn84oFDX+AobiHMKfq0aRI2oNqehVOCwvMWUuqFd6lOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmE0dWhOalBRUXIySEJMMkorQmtjOFZuMTdzUHhxWXZzbXRFSVpEOXBrWTNv?=
 =?utf-8?B?WWRPc0U4Y1FlNkVabHM4V1N0ZGFEc3RqdTNpTWw2cFdNU0FoOS9rV1Z2NFFh?=
 =?utf-8?B?elBqTWRaSWtqTEJyS1lnK25nNWU3dFI5dXJaeHdwbDcrUzc1ZGt0OW9oOGs2?=
 =?utf-8?B?cmR3ODNMZlRYR29UWEJYNTdaekNQVEM1a0xsdzZyVHREUXlsaHhGNmFFVHRw?=
 =?utf-8?B?YjF1THFQR0crbTBrcTYrcnU2UjNtUVFjeUVkYVNUaDBxd3lYT2lWNWI1OXVa?=
 =?utf-8?B?dzIxR296NlFzb2RoSGhrcTh0WFl1b29Xbk10WjVUUFVLdEoxS1dYc2ExWmlE?=
 =?utf-8?B?RE5JZlhMREhmOHFKbHl0R3lMK2hoZlhnQXNqNWR4UENRTTk0cTQxeWxNYUsx?=
 =?utf-8?B?dHVWZi9kaXpsV0dhVWd5MkJpaGUvNSs2TFdHdllyalRIMStka0hpYkpBMURE?=
 =?utf-8?B?TXpqdXlZNGVnaDRlR2h2S1FuRHhjbGhMRTRlTDBFY2N3R21LQ0xhL25iRE45?=
 =?utf-8?B?VGJVM3pWaXV0Q3l5bmdYNUlnRml6eURINmpzTWRocDcwcXV1Mm5OSEdqRCtB?=
 =?utf-8?B?WGx3UkdzMVJ3MTRjUElveW1FS0JSdFM4ems3ZXlrd2NXQU9HTFlGQnI2YzJG?=
 =?utf-8?B?T0dSVnJKMDVqV01MMFpZQWtUSGZ3TnI1VHhhRkMzRGZ2MEpreFRldDU1c1dJ?=
 =?utf-8?B?MU1lNDBLOXFFcWplUmVuZEE1bzdXNW9Hc3dRUlliQ1V3Si95L3RxMVpQMmJi?=
 =?utf-8?B?YXdnWHd0QUp6RmtGZXNlU1ZPNS94QjBaaXExOUFUVFdnUjlZdkFLd1pBKzhP?=
 =?utf-8?B?Z2cvQjFXZEVzQlVsc2ZvMWxFa1lTWnBQa29zWksrNWVTUXhUUHhoa0pTRHFY?=
 =?utf-8?B?QnI4RzY1YVJDY3JCZlVyQmViOTlqd044Y01KWmhEWDdXUmtNWjBpRnAyNzRu?=
 =?utf-8?B?a1FvRlhJRDk3Z2Jna09PMHJaYmJOYVdqZnpIam8vWFV4NGE3OGlIZnhCZWpW?=
 =?utf-8?B?aUVEaURmU2pNSXhWaHNHbjBsWXFzOGRqTDdoaHpZdXhGK1FqU3NvZ2x0bm1t?=
 =?utf-8?B?VWdzMFptRHA0WXduVnAwVnJEdzk4NVFDWUZZaUJjMmNnNzFDanlVVlN3OS8y?=
 =?utf-8?B?SFZ5SUhPUlFVSE5ZUFJZRUVEMlViWUc4WHArUFlUSmdCcExGb3QxazlGeEcw?=
 =?utf-8?B?THorZWpWSHdUbUcraEVrekZ2SlFGT3pKVzNwTmZBelVtWEg0eVVSL0VidXlF?=
 =?utf-8?B?eEdiN2t2UndkeWhRSGQ3eFd1bVRKNldkdFB4RkZrMU5CaGtqUWpjcEovNjhN?=
 =?utf-8?B?d3BPWkxwU0ZETVg0aE55a3NuaExhRHVOLzVSMTVQTmtPMDV3U2pHRmhERGlJ?=
 =?utf-8?B?MkxyN0xOK0lGTmRQMnAxSTMyK25UMUhRSEJhTG9BUXEvbzhoeURUS1pPMCta?=
 =?utf-8?B?cjNRWXQ3UkhqR1poMGxaZ1J2UG13dHRzb2NPdTM4UUFvSTZ5RWgxYWVCRnpx?=
 =?utf-8?B?dXloS3lpQnJ3S2FnWFhyUjZteHRsWEE1Sk1ZRmJWdi8zamJDaGVrd2lsNXoy?=
 =?utf-8?B?bmNTZDQ0VWcxMk81MHM2Z1orSXJTc2VRVU5PQXAxcll4TXl4elRsVXBKb0Jh?=
 =?utf-8?B?eFR1STZuRVptTkROQ2lQM2o5d05vaUxYQU5rSHpRRGRHRVlzaXFWS0t1eUM1?=
 =?utf-8?B?REdpQStlc2FIdGtaUHlmZUw2YTNMeDdxUktNZmdPYUVydGcvOXRVVitDRG92?=
 =?utf-8?B?VzJxQTVsTGNFMHJqN3Z0d25Tck5vVmFrSzNGanlnVUU0MDhpaW1EZ1VLMVJ4?=
 =?utf-8?B?ZzlmMjV4VDYxZ3g3U1pab2xlUisxbVBFNE8wS2RBK2hncWptNlVNQzZwTHI0?=
 =?utf-8?B?blpyRGhyT3A0b3pWZVhyMVdJODJodVJhVDFVMnJuWDJycVoxMlBZcGFPQ1FM?=
 =?utf-8?B?ZGRpTlZ5U0VrWDR5ZkxVVERjdjVsVENyTU1WU0F6bGJTbXZoYjE1T093bWJE?=
 =?utf-8?B?RmFOeHdHb3M4dUdoQTdzOGFIdTAxWWN1dlJIQ0JGbUgyZTJ4b2M2aVhFVk5M?=
 =?utf-8?B?a3hQRk41cDZwME9rRExheDBEck9YZS9aQ0E0TDBsTXR0S3kwODJsQTBjVFB6?=
 =?utf-8?B?NFJiMHRGRGU3cUVHRjRXdDVtSURJbDVGRko2SldTYmVmUmF3M1N1NTRnNkNp?=
 =?utf-8?B?K3gya3ovaE1WVExSNCt4eGRjQUg3dzNNMlFVc0UyeVpONC9ncDZkVXpYNmVC?=
 =?utf-8?B?NUNCcitZOE1FZDVNY2VLSTZtRStzampQdW9BNmdLWWRPSEhTUGxscUFZWGtN?=
 =?utf-8?Q?WH9Pullu/ClNQaaagP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da23c2a-e70b-44f6-60fe-08de962edcb4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:55:15.0012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrCb0KlV79O3ywNcHrjdehqfGvAtOA+ab4x4/S4rycqU5fue6KMT7mc3hJP/fkD1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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

On 4/9/26 10:33, Sunil Khatri wrote:
> Reshuffle the code to run create_mqd outside the mutex.
> code here is mostly setting up software structure init
> before actually registering the userqueue in the xa and
> to the driver.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index cf8c8dfde721..2408f888c4d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -793,14 +793,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		goto clean_mapping;
>  	}
>  
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> -
>  	r = uq_funcs->mqd_create(queue, &args->in);
>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
>  		goto clean_fence_driver;
>  	}
>  
> +	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +

Mhm while this might work it looks a bit questionable.

What exactly is uq_funcs->mqd_create() doing? I though it would only be initializing fields.

Regards,
Christian.

>  	/* don't map the queue if scheduling is halted */
>  	if (adev->userq_halt_for_enforce_isolation &&
>  	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> @@ -812,7 +812,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -			down_read(&adev->reset_domain->sem);
>  			goto clean_mqd;
>  		}
>  	}
> @@ -828,9 +827,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	if (r) {
>  		if (!skip_map_queue)
>  			amdgpu_userq_unmap_helper(queue);
> -
>  		r = -ENOMEM;
> -		goto clean_mqd;
> +		goto clean_reset_domain;
>  	}
>  
>  	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
> @@ -838,8 +836,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		xa_erase(&uq_mgr->userq_xa, qid);
>  		if (!skip_map_queue)
>  			amdgpu_userq_unmap_helper(queue);
> -
> -		goto clean_mqd;
> +		goto clean_reset_domain;
>  	}
>  	up_read(&adev->reset_domain->sem);
>  
> @@ -851,12 +848,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  	return 0;
>  
> +clean_reset_domain:
> +	up_read(&adev->reset_domain->sem);
>  clean_mqd:
> +	mutex_unlock(&uq_mgr->userq_mutex);
>  	uq_funcs->mqd_destroy(queue);
> -	up_read(&adev->reset_domain->sem);
>  clean_fence_driver:
>  	amdgpu_userq_fence_driver_free(queue);
> -	mutex_unlock(&uq_mgr->userq_mutex);
>  clean_mapping:
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	kfree(queue);

