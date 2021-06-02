Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15331C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 08:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE35613D0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 08:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE35613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1D06EB6D;
	Wed,  2 Jun 2021 08:54:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0483A6EB6D
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 08:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py74KJDF4jchQ6UQEQGpTwoR1vs8ub5dmrkQzhwfLzF/pdEn56EFWmsX76UigJb4Kgap5bLHIYIhAJzIm6WpoUVPatRc38b4xRxR+7qfX3fszOYQQk1Ko3iXKx1oHv3Komcc+d6yB9MphsuLK6rlHfNdFnSgYlvfakFqLPVhLBUu+OiDNnoaMy2sRk6rA2qu9QkokuGcRTw5mRCw5XSyjj7Jd6ohlRQ5AeoRBB/XIbVgWS0FHxF1+t31VkenjxFTpLI2G1vnWBwn922z7vxoOeTfVosCeu3ofwn1EGyKfDors+hYqruhsyxUcF3ppMQdTd0b1b2zzmb0kGj69K0gDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re4rmYdFLZSeKX7Ymb/IquvSD6KgTdG+ovVbPLXGQrA=;
 b=XVbcpvJGln8qj7YUdNk4cQV96wOPtZCH9L5+iBcauN3Gw81odjgeS0NhEnH4JDiSonpsLC5PNiJDFjzpgGwz2Rb3B97LmAeIkGCor8W0OaSGp7QXXY3mBgzuGpSzSq4Burb6wM2EjzCCsJBU2Pc68hH+OqK0VZFfQC6n+UXZ+gbmV0g9aYzgdQ7ot7EfUlIsspUNgr63SGERHYosDby8OLdXCfuH+AsrL3wgnImkWOsNEsZd2S9BUwiBhQUuNelx6YYJqTwrHPCXA4H0b3JMS00xEJLQhxx8p7Mu0uWO8SDcAEvHGzDSX5X4qtnZ4GuKyia/YyVimzr5PK9ouAjzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re4rmYdFLZSeKX7Ymb/IquvSD6KgTdG+ovVbPLXGQrA=;
 b=3wbmpoPZ4jQq9MTLxG+nCUg9ynRBa8pju8j7inxdt9N51cu4W0xNG4rXiCRDVXMEOIXW/yI+XgP3vion9fWkTkc7lycT6a/qDVRLK2h92bRs7WWvs5gaszVZX4coWhXhE9XxVZ6nVz2PnxkvyoWTlT9TMCDUBow/CnJYQJ1uBpY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 08:54:20 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 08:54:20 +0000
Subject: Re: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
To: Changfeng <Changfeng.Zhu@amd.com>, Ray.Huang@amd.com,
 amd-gfx@freedesktop.org, Christian.Koenig@amd.com
References: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <c9c3817a-ddd5-d73e-5a5b-fb3ad25d8ddc@amd.com>
Date: Wed, 2 Jun 2021 10:54:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.72.6]
X-ClientProxiedBy: AM8P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::23) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM8P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.15 via Frontend Transport; Wed, 2 Jun 2021 08:54:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5182b8-1efa-417d-e15d-08d925a4027d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52294EB598A1303BAA884C7D8B3D9@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eP6S+6YErVjUyz7cf3yTvl3s6rh3fD/TFbDkbHAEuXX7tY3WljDnWvGmBvBfD5wgLLD+8ijWMb3l9VRWcvb+B4Premo0z5cpEk+JYaCzS8L+x3NPzTvej+RagCjFP8rR3bAAMmKvteGzTwtXotJBmioeyaTfvEezk2C6deVhL7hZnp8EF+nuNq0y8L+RCl6hA8+8ie9foLMkiHZvvEh8zc5QSxdFWneCO3IXsjS+0maT/s9Gx+bvbskALjBpULLkNsQKLbBcr9wSeSp/spDQP131ZzZ4tYxVpjUP9pFxXabGvHEmN6UnOuaCqbq5q9dITdubkJTvu635dFlDr57aLp3qd+6k6G/uK/pkyaO/FZ3fW6OOK5eHpRbaoMAXkPftiFSfR5HJsZBZCTiqVWHbyumByltL7il8GCJrF17RsCUy+FUGyUxKLRu0RajsNBDONq2nMYB750iuSmag+D4otI64ZGdIgQJmDduZ31paMgRhfuCLbuN/EAZt6oc6GVdI1BuukJ3SiAv4RqehSHeem7h6wxwlaYdRj4orXJc/MoJOmiIddaSeDGHh0Xd/bGQ33ZSMawbKUk16aZ/fm04EYehRph+kS4fMKVmucVHNCklGc2Dsa2jqXifJYz6E/PwQtCQgnSDgdLeNLpVTEPLsqvkQQVaZ+O8x5Yg8P7EoqLwf7Z/JkGy+exp+WxkC+gKiFV6l14/+MAL+q+KKczSbUh+u/EYE6q701C+d01rZLFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(66556008)(956004)(38100700002)(6486002)(66476007)(2616005)(31696002)(66946007)(2906002)(8676002)(8936002)(5660300002)(316002)(16576012)(26005)(38350700002)(83380400001)(186003)(16526019)(86362001)(478600001)(53546011)(52116002)(6666004)(6636002)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eThtUWxWVWFLN2xBN1M5Wk1hS1UrbkI2aVNiSFZjajNZNEF1SlNBRU5sRWlp?=
 =?utf-8?B?dGhXWjB6Tm9hQWg2cXZDeXZ1NHZLSTRob1RSMXFTZ1VuNzduU0FzSC9kbGk5?=
 =?utf-8?B?YS9XbUJZWkg1MDZHVXR0RVJYTmVKcU9YbU9SZHp1clRHRkc2SW5WUUxmajBu?=
 =?utf-8?B?RzF5Z1FiSDVVNkx5a0c4eGVrelRZMFRHektjOS9YMXlRWWNmQTEyRzVrTG5k?=
 =?utf-8?B?QnNhV2FvMm5PZExZSTc0VEN6YTJaMXpnOEVkcFZIdnRmUEVLc0twVHc2dDVD?=
 =?utf-8?B?dCtBNStWeTQyQWxLb3N5Ulh1RWF3ZjF6L2s2SWc1dk1ZZnJJeFg3NjFGdjkw?=
 =?utf-8?B?TUgxVTQxWnJvRXBQZ0NKYUw0TnVSZG1SSEYraWxDM0pnWWxEd0NnMXRFWkpJ?=
 =?utf-8?B?M3ZGRDBGZmprVHVoWHpPYWZ5MnRIVkxHQ2ozcjNjeUFWdzcvWDNtT054eUQx?=
 =?utf-8?B?aVhCRGphMEVSbm5NRnFuWDlSS25PQTk0bUp4eDg2Y25qL0hVaEtSdTdSZVMy?=
 =?utf-8?B?VlBiQjVGNVpUVUF1cktzT0grWVV1VVBGbE5qVlptQjcwRHNCVnpBMjhnSUlB?=
 =?utf-8?B?djFlNmg3bEsrMjEyMkFFWTFvVEIxSmwvdE1PZDNUNXRGaTNkRmxuVnFlZ3ZC?=
 =?utf-8?B?N25lNk5NUkhTNFo4bm9iaXN1aVlQMjlyaFE5OE9RUDFaTFY1UHlkbVR3UmRD?=
 =?utf-8?B?ZUtINHJjV25TMkNYcGVRNCtxU0Z5bG5DcXZMOTlvOGlqdkRNTTBwdmlCUGg0?=
 =?utf-8?B?eitjVzFvZUdPSHMyUm9XbE1LTytPdGVzMHZTVi9abE5rVlJNWHZuMXh4enln?=
 =?utf-8?B?ZmI2YnZTYSt0eHViZjgrZWZnSFZDdjNneFp4NXZzNkRvVjNBTU5WSDNieHJh?=
 =?utf-8?B?bG1FS0V3ME5VblVVcHRIc2FzOUIzZTR5bVhPVWpKMkJDa0FNVUQ2OFdlNXlX?=
 =?utf-8?B?K0w2aWNjS2VVRnpldldiTTV2bUxKVU9LM2syNlpCQ1k4L3Jrdk1QOExmdHd0?=
 =?utf-8?B?TGo0ZmhZREpscFd5bkJ4NW9RcXFXdmtUT0xOQ1FMZmVyK05HTFEwNjd2ZE9W?=
 =?utf-8?B?WUhhZmJTVkU3d2k5dnNVUVpyeGc5V25OaTN3MTJoVUF5WTJ2a1JkRlNsbHFP?=
 =?utf-8?B?dG5OcWN0b0lxVU1vQjRKRUlBMURvZHNaN3VNQ3Nhb253YWhITFVleUxUb3RK?=
 =?utf-8?B?U1RsOTQ1S1RCZk45djQ3UTQ1WGFMWU9EVzhBaHQ2T29Sd1BLdFFLSUVyWGEz?=
 =?utf-8?B?Nnl5Ykl4NE5GY2NDbzlJQ0pIdkYzbmVkcDVHa01kSXZtZHVmYUZZMDNQTjdo?=
 =?utf-8?B?cmlvRGRmNjJJLzkxVUxIb1VOOU9TRmZIaVluN2pMK2ZQczhuNTFlcGpwbS9j?=
 =?utf-8?B?RUVPMlhxWUhGaGsxMEhZdm1iczZKUHNJTi9oazdYbC8vSHNjUHFYVmpXRmly?=
 =?utf-8?B?SE5FaVZYTld5TzdxZTFEWDBUQkFJOEdGWVRkRVRJV014Q09FTVo5UFl6S2gz?=
 =?utf-8?B?NWd5ZTdFOUxHVllpdUJTcStkOUFvdE5DRXZtVmxaWjY0WjByTmtQbkliV1BQ?=
 =?utf-8?B?MjRzamh0ZU0vU2Y5VXR4bW84U0ZEY0poZ2VFQWNwSUI0ampoVkxXOTdzcEly?=
 =?utf-8?B?WS9nS2I3UkQyd2tlb0daZkdobENOU3JyWHVvTmV0a09kbG1SSDJ0TUxjUHNX?=
 =?utf-8?B?a0dvUnFJaXQ4dkJPQVNmSC90UGVsK3JPNTZpdGlOQW14NXE4czF2QnEyeWVa?=
 =?utf-8?Q?+U8wjv08sDGkosvkB5IwZ+U+JzG74T2BE3xCDMy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5182b8-1efa-417d-e15d-08d925a4027d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:54:19.8424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySDSTqprOrHBwmM4ejrZIHyDYmJvZsYnmfzQ4xdnrv1dmdzP+Hct18Xu+Ixog78xRuSkHg4q3FWabQ71L18T0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 6/2/2021 10:30 AM, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
>
> From: Changfeng <Changfeng.Zhu@amd.com>
>
> It will cause error when alloc memory larger than 128KB in
> amdgpu_bo_create->kzalloc.


I wonder why I didn't see the error on my machine. Is there any config I 
might be missing ?


Thanks,

Nirmoy

> Call Trace:
>     alloc_pages_current+0x6a/0xe0
>     kmalloc_order+0x32/0xb0
>     kmalloc_order_trace+0x1e/0x80
>     __kmalloc+0x249/0x2d0
>     amdgpu_bo_create+0x102/0x500 [amdgpu]
>     ? xas_create+0x264/0x3e0
>     amdgpu_bo_create_vm+0x32/0x60 [amdgpu]
>     amdgpu_vm_pt_create+0xf5/0x260 [amdgpu]
>     amdgpu_vm_init+0x1fd/0x4d0 [amdgpu]
>
> Change-Id: I29e479db45ead37c39449e856599fd4f6a0e34ce
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 +++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1923f035713a..714d613d020b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -894,6 +894,10 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   		num_entries = 0;
>   
>   	bp.bo_ptr_size = struct_size((*vmbo), entries, num_entries);
> +	if (bp.bo_ptr_size > 32*AMDGPU_GPU_PAGE_SIZE) {
> +		DRM_INFO("Can't alloc memory larger than 128KB by using kzalloc in amdgpu_bo_create\n");
> +		bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
> +	}
>   
>   	if (vm->use_cpu_for_update)
>   		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> @@ -965,15 +969,19 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   	struct amdgpu_bo_vm *pt;
>   	int r;
>   
> -	if (entry->base.bo) {
> -		if (cursor->level < AMDGPU_VM_PTB)
> -			entry->entries =
> -				to_amdgpu_bo_vm(entry->base.bo)->entries;
> -		else
> -			entry->entries = NULL;
> -		return 0;
> +	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
> +		unsigned num_entries;
> +		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
> +		entry->entries = kvmalloc_array(num_entries,
> +						sizeof(*entry->entries),
> +						GFP_KERNEL | __GFP_ZERO);
> +		if (!entry->entries)
> +			return -ENOMEM;
>   	}
>   
> +	if (entry->base.bo)
> +		return 0;
> +
>   	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
>   	if (r)
>   		return r;
> @@ -984,10 +992,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>   	pt_bo = &pt->bo;
>   	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
>   	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
> -	if (cursor->level < AMDGPU_VM_PTB)
> -		entry->entries = pt->entries;
> -	else
> -		entry->entries = NULL;
>   
>   	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
>   	if (r)
> @@ -1017,6 +1021,7 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
>   		amdgpu_bo_unref(&shadow);
>   		amdgpu_bo_unref(&entry->base.bo);
>   	}
> +	kvfree(entry->entries);
>   	entry->entries = NULL;
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
