Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC40ED7B95
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D21210E574;
	Tue, 14 Apr 2026 09:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aIxjMg+m";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE9F10E574
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvrD7RDOXhK/FHQkR7BaC/NjLLTorTTiWQ0vQlr890hEBG2eRX1kT5KfacGUYqHr8GHMInL0eR67VoTuXYB3KYk1uRS6gUtZGgutKZGfne9ulhLJ1ez0wjMqfTH/nVLPWGCHmZeBmMBge7bkr1oblhmyq73NQggQBGKrwFggo7mblYW75oviOCj1nVIMdGqG4MvJivHo/06pGLUqZKL4IZNfVTQlwJPcsqyXZYNyhSBGdXFf3Ne78UCZKYemXc86NmurSSkg/r8xNkmHsHEl9zUTtaCsg/lubDLsBJnORx06Rq6NSlPvYM3TkSwFNpXm+7mMMVkbXSNzaXGEOg/lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD1NAbolVvXq1aDicyUNZh5idQ2kWANgUpp1KcFwz6E=;
 b=OLSZkfPmKbJeC76Aqlc8Ax0aFfDeQoyUoslUg5q2aEAevH6qIH6xzjUxud0f87IlcEs0ewdRV0IVp6aBCt2w/S9drBfrFtUYkO+oj22V9Brj3Y4VXLP9egSXEwCxpNhHMWQkBJaSJMRMDtFDJlO0VJnRxqK8YwzvN01s8eRz9I3fTbPNwtOCCwuJL0pYzYQx9m3l+2oxJuF9C7X6hIOCjMNNBNb2RZiuLKoO4JQhjpHL8sXEd2DEKINKeo3tKI3zf1m/0Kgp+OPlGuEOCKs/F0tVInDr4jcn97fcJ/Q8xiWc7pHSwVE6JIkWBaXFmDyV2U83fgi2TBqVqV0DAtEBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD1NAbolVvXq1aDicyUNZh5idQ2kWANgUpp1KcFwz6E=;
 b=aIxjMg+mEcsoq6WF713aGwBLsY+mXgmO8l8JWsYk2n1vBgFg0L8XIq12g9XzvkpgmbwaDiY18RBpZjZgPdWysWUhGDKtNNBUViabQm01pE+4duNaOqewCEoslG1BF8ms/WRgiXAhZh0nUSPZ+1Ri+CoHuL8x1sT0QMBrgqt7Adw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:59:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 09:59:44 +0000
Message-ID: <f41bf288-3479-48c4-b172-2321d1cf7697@amd.com>
Date: Tue, 14 Apr 2026 11:59:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: unpin and unref doorbell and wptr
 outside mutex
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413125630.2239439-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413125630.2239439-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0273.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 114cb540-cda4-417a-9037-08de9a0c8d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: +dkDAWHbw5OiHR0wmInp56MwmatI+7LHJKvkg1xD6U3nGYxiN7K3GtL/G3N6P5RvJGccOvzJWQXT5RUpGpgKZbDC3on1xW3UKW2E4YhVqh44EDIsE6l4ewizYMGTsFot94AV/xjvsAwmkf5Cr+c/8raDVVXoSLny+IEGS3G/LL0s9O3a8bKHT9zkX/QhZ2v34pLzc3tj97ML0ajFuDI3DKhxxM3dV6+NTKzyLqwoG2By7V2IDuXy81q08b62SM1O8soa7jvQI4UkUObHnhf4vu6orFamaPq7thHPUaFffQuxXSEtHQi5icfPy78VMyiN5SdBY3MmQxkwv7+Qe3cbAcYm18hqRr9A86Qc2+RZSGllMB5AJ9AAFESr5kjZtr4YhkVfJa2Rx4FkaUWiXgsPeobT0BYxvcdrYz4ijURNk27yuKrsU28lA/+Sj/f+u2Vgoao7d5YNhApEWn/si0cY34YTxAL3OhrBRg0PmBzR+SlbsDTwHRzOVMJZC6V1ZRSRLchBF0TnAqPJ8F5u+Pxa1LAF35ow6lawBK3DE1pyNYNOHSyRBRtj0IFvj6wANVm2z/PGxiHJPDMgZV8lew9pcwNK/Im/ixHTmilJ/7n7qlsjktI1jfoJRUfJ9w0Mun44N+b14XUAWUPWFKlAW74Oe93N1bkiuRaWkfC/eUMaCj20Yp9mhd1hTjilAeCiQosDiUsYwMNRNUqOHPAV/HDOaEbB1IZRp3o0cccQJLmFY+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJnaWdhOXhGNmtnMmhUS1BKY2htS3JGNTg3clF0UEZpZnFBbUUwWTdYZU41?=
 =?utf-8?B?Wi9IN1NFUW1YYUw4TTUrQ3h5eEs1Vk91TmVRM1FXVjFqbGRCOERvUFJqd0lo?=
 =?utf-8?B?Yk1iUTllUWZLVmxSbG5weEZQWCtNOE9GeWY4eTVaOEx2YW45aGVwOVZVQ2F0?=
 =?utf-8?B?RFE0VWZHODNzWEVuQWVodTJBdEpXdzJ2dzVTV1FvYUxJRFkybTZSMjJiOVRv?=
 =?utf-8?B?VTZxQ0tpOWNXV01JN3lDZFBEZUNsOHdYTEZvQ3hUbjRlaUlGT3Jxb09WMjNV?=
 =?utf-8?B?NmFvbHBacEhSa0dSNC8yUnBpckhVZk5wYVBpL3RpZHpCN2dmUkJNUzR2ZGhS?=
 =?utf-8?B?SFNtREZJeTErOEVUbkdOVXlEVkt4bVN4Y1R2Qk1xazJSRXc1VEdscGI1NkRX?=
 =?utf-8?B?Zm5Ba3ZxRmIzMC9yMWJOc0JKWGVzSGgwRWhQRTFoeVA0RmxkZXNJVjJkb0Rl?=
 =?utf-8?B?dzlndEFvK1RlWWUwZTlOeUhkR3psVkRVenhiMmpYaHZPM0Q0ZVZsQ2ZtWVV3?=
 =?utf-8?B?YXZnNkQxQ2dxNjVHTUt1aHVuQVlQOUNLbWc4UTlWaG16UStGaVNYS1Z5Z243?=
 =?utf-8?B?dmo1RHdOSExBOE9za21NNUVmYjdPdExmYkRsSEo2bC9tNmtLY3ZOb2xSMGh2?=
 =?utf-8?B?RFRROHp5Z0pxT3dTUmNXUjJhR2Y1VnQ3YzBXdWZmeEh1TU1MOC9NdUxKeWg3?=
 =?utf-8?B?cUFXNXZBdVNLOHN5dmxYaXF1YjFJdXVCRkdIUjUyUU9jY3NkeHV3b2t6b3N0?=
 =?utf-8?B?RDdwYlBRV1kxYk03U3J4TUtPdzNUQ2EyUXpPcFBYQ3huYlhWQjNTLytNZ3dR?=
 =?utf-8?B?OGdPL0NnbUhtcFF6c29OMUxLaDRLUUQ4cDhMUDg0azR6bmU2Sk5qODRpR2N5?=
 =?utf-8?B?UkdXVzhNdGdicTZsZUVXdEN2amdWWjhoTVFIaUhvYWFzbVpGdEZrWHVuZVI1?=
 =?utf-8?B?czZLMEJzdzdUZUYrNW4zdllPMloweHB4N2lzVHNpTC9nSHRuWi9hTGp2VnZD?=
 =?utf-8?B?U3dZbG13WEE3VmdQcGM3S09SS1V0TDQ4Qy9MbzM5eHJqNzAySzdjcHdONENM?=
 =?utf-8?B?K0F5aG9jK0pRZWdQYjdQQnhYVXZFclh5ZUl0TlJmbWNHNWZ4T3pwVUNYNjJ6?=
 =?utf-8?B?dE5xOUE2T0RJZjdJNkkyY0xDNXd6Yk5WUDhzaENicS84eHM2NVJjeWxvUjBO?=
 =?utf-8?B?VjJMcmJZMlhDQTdqNDFnTUlza1Rad2JzWHo0Y25CK0VEWDRWcVh4aUZ4U0gz?=
 =?utf-8?B?c2VvWGUzSTNZVE1COTMrVm5qMTVicFI0QkxwZDR6WHEwbXg0WVhUTGh2SVM4?=
 =?utf-8?B?NHRMeHhDR3NVWGFjcnhLWjlSRXdXWjU3YjZVTTR5cTNUa3RaWjlQYlZtNWVZ?=
 =?utf-8?B?d2g5dEg1K0t5Zk5OSVlHNkc2SVIxN21zdFlkRG00QmxTS3hvcVpMdG9yczRw?=
 =?utf-8?B?U2RaOCs0d1VreXFoWkxQaFFub1Vza0l0VmJMaUhWYXE4Z2xjTElMRUpLOFQ1?=
 =?utf-8?B?eFFrd0RWenp5d0Q3N0c2M3ZUTnhjMHp5RVd2clQ4YkVJdXEwZ1RSQ3N5WG8r?=
 =?utf-8?B?dWdhTEY2OTcwODRFdmQxZzM2K3pjb1NDcXNEczhVc3FiWnBxQXRWL0NxNUlK?=
 =?utf-8?B?UFlodXIrVmhRUGtpNFVTQVU4K1A3YjM4NEZwcUhmRk5sL2tEd1RnT3k1WmhN?=
 =?utf-8?B?QVV2aHpQOW91Tzg0bkVYK1kzd2t6STZLZXVXa09CS09OenMwTTVaQldEUXBm?=
 =?utf-8?B?USthWEhYbEFKOW9pRHVmZmwxYlZIRWh1RVFuMWc2ZWJZai9vdkJxeVZVTjIy?=
 =?utf-8?B?c1YwRTAwT1FOdHFaWWxTUTdSdzU0emRHZWRBNmV0ZDdlaGpLZXB6ZUpPckhh?=
 =?utf-8?B?Mm9USFpCaHlGMVdtTFNWWlYzKzVnazI2NDc1R0R0NFp6OXNLMkpsNmJzZDFn?=
 =?utf-8?B?ZTk0WnFuQVFyTTJyVDF2VFBFNGVrVXNpSEVYNHF0K2YwNjYwWm45dHE2Y0Fy?=
 =?utf-8?B?MjNWcUdwMExTaENHRFhQRnFzdVZjYUh6bHVsMUdobGJvYUx1YkVOUHZUOWJs?=
 =?utf-8?B?NWUvdWp2WXhyeis5U3ZMK3hoZEMrUHIraUZZZ1pQeUhRSW9nWllSTnFtUVlQ?=
 =?utf-8?B?RVZvV3ByQXY2T0tsOUlMbnZIcW9BMWI3cVhjY0JCc2pXbTFsK2xPQ3ZTbDlE?=
 =?utf-8?B?T0E4WkRRZlAydnV5MEFoQnZtR2JXOXdwT3lzUjN3QW55c1pMeUpJMVQyNk0z?=
 =?utf-8?B?MG9rN0JBTTYxVTQ1K2FhZGFuc1Iva1k5VTdJUjFoMVdvZVQ5K3djMlptcS9z?=
 =?utf-8?Q?6z5Z1F6hTJm3pKYvZK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114cb540-cda4-417a-9037-08de9a0c8d6f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:59:43.8840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyucgWugtATkMN4v7pDlf3b84hYRjDjPUKckYxLzpjum0wtHVR4mR36vY8e4EYnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

On 4/13/26 14:56, Sunil Khatri wrote:
> In amdgpu_userq_destroy once unmap_helpder is called within mutex
> there is no need to hold mutex.
> 
> This helps in avoiding a deadlock between doorbell and wptr ww mutex
> and we could unpin and unref these bos outside mutex safely.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index d4e18b57be80..d66ed81a3fd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -444,7 +444,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  	queue->fence_drv = NULL;
>  	queue->userq_mgr = NULL;
>  	list_del(&queue->userq_va_list);
> -	kfree(queue);
>  
>  	up_read(&adev->reset_domain->sem);
>  }
> @@ -650,6 +649,10 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}
>  
> +	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
> +	amdgpu_userq_cleanup(queue);
> +	mutex_unlock(&uq_mgr->userq_mutex);
> +
>  	amdgpu_bo_reserve(queue->db_obj.obj, true);
>  	amdgpu_bo_unpin(queue->db_obj.obj);
>  	amdgpu_bo_unreserve(queue->db_obj.obj);
> @@ -659,11 +662,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_bo_unpin(queue->wptr_obj.obj);
>  	amdgpu_bo_unreserve(queue->wptr_obj.obj);
>  	amdgpu_bo_unref(&queue->wptr_obj.obj);
> +	kfree(queue);
>  
> -	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
> -
> -	amdgpu_userq_cleanup(queue);
> -	mutex_unlock(&uq_mgr->userq_mutex);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	return r;

