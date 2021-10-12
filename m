Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20499C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 22:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14F860E0C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 22:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E14F860E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E255C6E9F5;
	Tue, 12 Oct 2021 22:12:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E39488284
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 22:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTnCTigdmgUEjC2QJe2OWLpGyb683AVOHnzO5IcKrMLPbB6T2mABKEVtMQmlVJm2PJpEoeaivZjUxQ84HEml2FFpqMk600KxcvGl2U/BzqNKQbQseZDOrEqHgR61uWuSWD7NUhRPstXUeYFCuJAEdSMLNB5JItobA4/i6tFip5D7c5jZatOQpfKTvpnC6uhaRR1G6oaDCN54ISwNBmtI3Hai7lRXqAwsN/YLOhUNsVGT76x2LGn1xj+TOcWAxOc8YLWsIXrTPBZwRy9Y9DHFNMp64neNIU/lgEnCCr4aXM7IT4JKj1t+BfCD7cQW1cvNgCGFYUoyISRPFCcQdfuMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9msDApA/+tq7atw7kVs2xCdfltxuZbUI5kLCPEtInA=;
 b=c2nbbYaAynZGEFsQwWU47Kzs5X5kE2/GoJyLf4luPQsmh+XKRtCyfCjcqD5KtphalWAzogZlM8gu+YKXGwKqusyjtfsLnJCKNgiozPxm4NYH/i71SNqpFj/vS2XBogEpMbJaZKj4SLyVMlGFV4VXmiPLJQmSnCe6M8YrgW9kaMO3SRar0MVp4JC30ugMpZPflk18TXmKukb9GQoQRRLjmN+gAPJ+0PixhiYvBLXG1cpyqIzhaaANQKYVnrTEw+VptIOaepWT+Irwbe5o5fHLmTrl9P6yQSyR6tnDBfSsE/WChpNWSjTnAxy3BMP0N8Z+cdEUdA0e2wPQw+PQn0s22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9msDApA/+tq7atw7kVs2xCdfltxuZbUI5kLCPEtInA=;
 b=QVUJMS++kYG/g0YhLhM277bCAoYJT1NcxX3OeCn9/UUzsNv5kWzNEkNv8JRejdKwnQEn+MaS1/LH0x83ob7f4Jlmld7YmqjhiX017I/fIueJ1rtIqphkEoGq0UgiCOx895CAoZRxulPMkgeLCSGOqeJ4Vnnb4CQ7r/OJRwgzRcw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Tue, 12 Oct
 2021 22:12:14 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 22:12:14 +0000
Subject: Re: [PATCH v3 2/3] drm/amdkfd: handle svm partial migration cpages 0
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211012135527.28083-2-Philip.Yang@amd.com>
 <20211012210044.32069-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <46fd7abe-bd7d-e2a3-1aed-b3028828d178@amd.com>
Date: Tue, 12 Oct 2021 18:12:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211012210044.32069-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::17) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 12 Oct 2021 22:12:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fdf3f7c-e57a-4880-d99c-08d98dcd58a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4780774044A772DD5857561592B69@DM6PR12MB4780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8OwGIraNfKbsEsG2AgNPCS5HmteNL33g55FCRZfTMuMOkWbjzJVjLShtmcHBYn6KAoJg5IYMc5MwY44Kip4cUjAYvKS5iMHtDS06usg1YV3xA/stc0890s3i4ew2yY2yJ7QQIXChr1jwj/yv4Uu1VNWDh/9tzA8KUDDr89nHc2H/U4TtIAC2yEDn7WUCpbOCFVeHqgbSU5TjC3FROnVFYXlxSlSliEVUJgJukVaIoH4ftpjaK8J2mFmNcqoZv/7GvzXNTOC6bLjgs9hvhEjs4ClXkNeLZNbFmqtnkK8PTnKu/kMMK3RYlXt9Bcc0M0iIl9JbOJNnXT6qZpBjmN/DJEiuYwpqL8SqSHr5jksbSILPaLP9f5G9EmCP88ltu3EWYYQAD6qTeevWyl/3AdpuKHnPaukwKOuJcktc/LSsTjjVW7TgSLmN5id9tuMgWuTsjFNSPGSBLlD36R2FXMWSKTveDY/ZMLI5qssUfNtX8syOAoGCyz44nrG5RvpKx95HViNpevsaVDh5pV7ERm2jeqlBfZpwmNIkUtdmjtfHZDSAJjjPajAsxdxgWUbmEdqXIqBznfSzch8QaFwRC8dzzJoCRaf+t0am6xaiGj1M/HMKnAnQxtg1HMqyglX2Z1TuhRnt3OYIzxUXET2a2jdplDrS2B3DMxLBF8LUMfN+Bpqc020wYVuaq2VACTszzFxR6mCFx/0IdPKbRuXiOCo9w30rPd3rntNzBqvrz466ES2E0CQH8MmMvDDJKdodo1N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(8936002)(186003)(4001150100001)(38100700002)(83380400001)(8676002)(31686004)(26005)(6486002)(316002)(16576012)(66946007)(508600001)(66476007)(31696002)(66556008)(2906002)(86362001)(5660300002)(2616005)(44832011)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2t0RWNiazdOQ0dVUU5iQjVNaWZzSm93KzlVRTRYSTF1ZmdtaVJleGxHRFZX?=
 =?utf-8?B?ZldFdE9MMzlSSitKenIxOE9VT2FzRTlWWVp0ZmlJenhNVUdLc1kxak9tQ2VI?=
 =?utf-8?B?bUJ2Tjh0dEpyZUREam9MaXFSOStPNU13c0FwTGg5YUVVL1lEaHh6S1hpWXBT?=
 =?utf-8?B?MXVLOFp5UUdIUVRlWnVFb0Q3cHVCR2pXRjRMMXc0Qzc2aFN4NVBqM2N2Z0Ra?=
 =?utf-8?B?Q0pZU3YvdGs3V0llOXRqOVU4MWNCTlFnUWJHTjZLTmR1RXRvVk0zK3ZPcUZW?=
 =?utf-8?B?cG8xZEFhdkVMMDJpdlRGZHpkRjdndkRXcHEzOWlUMytVd2JLV1NrTERIVkEw?=
 =?utf-8?B?elNDdVdlU2RoVktWTnJTRmFFZnQyQWhjMUsxYzZKV2VDWElpeUpFdzY1WW8x?=
 =?utf-8?B?OWp0K2xhZFUwSFFvRTloSE5LV2h1Mk1vZDhHLzRKTUdEbDdwOXAvMG4xcGlN?=
 =?utf-8?B?WWpud0ZYZXNVMWN0R0p6MXJ6RTVKdEJObUI5QWxZc1U2Q3kwRkZ3dWN1VzNM?=
 =?utf-8?B?djk4NkFKcTFNRHYrMFRnc2QyVW40MUNTaFgvendCSWdrL0ZkR0ZObXhuaEFr?=
 =?utf-8?B?YXlpS2tLeXVNM29HSm15QWJheUZhT2NoWXl2ZWR3b3Z1SEJXMTd5aEJQdDA2?=
 =?utf-8?B?dHFyWEQ2QVBkUmg1ejBVeFdKSVR5Y1lNMXF0L0JCd1ROWWdJTnEvUlVpbUQ1?=
 =?utf-8?B?MjFMS25CYzQwSGZmVStkYkFXanYrUDhFYWtIWmdsN2VBb3VacS9RQ2tKd2Qz?=
 =?utf-8?B?WEExWkJkZTlrTm1DNXhwb3A5aTFUcmtpNXh1Mm1lQ2RuTjN0UHMxUVNNMDJL?=
 =?utf-8?B?NXBuOXp1REtvdzg5Mys5TzQ0MDFuL0pLM2xRV0RpWEswZGdFd1JwaXhqTmxm?=
 =?utf-8?B?dHZzU2NLbnZoekdEMHdzYjdrRGNWS2RNdXBIek5vVHlSZll3L25ScG1WbWtt?=
 =?utf-8?B?YXZybWdQZUxLOHVLQ0pMMTliam85ZWlMS0xLeG5RZk5VRGNGZ083UXlkMXcy?=
 =?utf-8?B?SDZqNC96S2xiRjM2YVVIUlNnZXhMNENzdUUyc2hIK2lxTXFuYzFVbXdCTmxy?=
 =?utf-8?B?NWhxLzBkR0pvRXMySlFqRVVpdGt4K2dnRWZuVE5rbmZEQ2s1VSs5Q0pQdTVt?=
 =?utf-8?B?UUtza2d0VGFUYlVydUtLM1FkdE5veUlpSjJsK2NKZ0JLZXk1VndtNnEzU0U5?=
 =?utf-8?B?NzlVSFRwbEgzT3MzS282Z29WUEhpVGxnSmRtUC9nTUlnZERETDlDdWpZUmlW?=
 =?utf-8?B?MjRNSXQrVENjK3pRMjdjcjhWNmwrb3IxTks2ZkRjVG1yaWRmUWk1OXRsZDhp?=
 =?utf-8?B?WVY2eDFDeG50UU9jSXNXams2RVUyQzc3cWtWSlJRQkwra2NOL0cvMi9hekZU?=
 =?utf-8?B?dW5SSERGM3lNS1dyM2dMb05DVUt1Zlg1SStsS053a0NjbkszK05ubitZNTdr?=
 =?utf-8?B?N09iTWg0RFBUYmYzTzhPSTBwRytmMWd2cWpzc2pSQUVkcVFZcTJWK1c3N2kr?=
 =?utf-8?B?WnYyMyt0MkljZTVCSTFUaExPcXQxZlJhTG1nVWk0QVlMRXptenRBNC9TVGds?=
 =?utf-8?B?TjdNTGl3a0dYblovWlpJOERNR3RLVWtXbFBHdzM2bVRkZ3g0VHdiM0w3dHdj?=
 =?utf-8?B?Y2RFdkEzUU9FWW9yVU9mdGY5OE5jSW9Hc2lZVmJ0clN0RTRwSG9zaFhFVHI1?=
 =?utf-8?B?b29IK3g5N0ROQ0hMdGpteXNEd2srYkhsTysxK3QwYzlGWXVjK1lidXI4ZWhH?=
 =?utf-8?B?ZzcyM0RpdDVETUcrM3ZVLzcrd082a09mY1BRK2RiYWNrakU4dkx4QjZ1NEtN?=
 =?utf-8?B?MDZ0cE1rYWNrcjdyVUNLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdf3f7c-e57a-4880-d99c-08d98dcd58a2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 22:12:14.6034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S++CPmKadZbkrAf5M6+EI9KBGevJRMIU9BfBg1rm6u4/U8XZQCggSuYJGY7vlJKA/zg9Oxos9Mrzko35DANd9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4780
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


Am 2021-10-12 um 5:00 p.m. schrieb Philip Yang:
> migrate_vma_setup may return cpages 0, means 0 page can be migrated,
> treat this as error case to skip the rest of vma migration steps.
>
> Change svm_migrate_vma_to_vram and svm_migrate_vma_to_ram to return the
> number of pages migrated successfully or error code. The caller add up
> all the successful migration pages and update prange->actual_loc only if
> the total migrated pages is not 0.
>
> This also removes the warning message "VRAM BO missing during
> validation" if migration cpages is 0.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 90 ++++++++++++++----------
>  1 file changed, 51 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index b05c0579d0b9..d37f20b17586 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -376,7 +376,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  	return r;
>  }
>  
> -static int
> +static long
>  svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			struct vm_area_struct *vma, uint64_t start,
>  			uint64_t end)
> @@ -413,32 +413,37 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			prange->start, prange->last);
>  		goto out_free;
>  	}
> -	if (migrate.cpages != npages) {
> -		pr_debug("Partial migration. 0x%lx/0x%llx pages can be migrated\n",
> -			 migrate.cpages,
> -			 npages);
> -	}
>  
> -	if (migrate.cpages) {
> -		r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence,
> -					     scratch);
> -		migrate_vma_pages(&migrate);
> -		svm_migrate_copy_done(adev, mfence);
> -		migrate_vma_finalize(&migrate);
> +	if (migrate.cpages != npages)
> +		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
> +			 migrate.cpages, npages);
> +	else
> +		pr_debug("0x%lx pages migrated\n", migrate.cpages);
> +
> +	if (!migrate.cpages) {
> +		pr_debug("failed collect migrate sys pages [0x%lx 0x%lx]\n",
> +			 prange->start, prange->last);
> +		goto out_free;
>  	}
>  
> +	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
> +	migrate_vma_pages(&migrate);
> +	svm_migrate_copy_done(adev, mfence);
> +	migrate_vma_finalize(&migrate);
> +
>  	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>  	svm_range_free_dma_mappings(prange);
>  
>  out_free:
>  	kvfree(buf);
>  out:
> -	if (!r) {
> +	if (!r && migrate.cpages) {
>  		pdd = svm_range_get_pdd_by_adev(prange, adev);
>  		if (pdd)
>  			WRITE_ONCE(pdd->page_in, pdd->page_in + migrate.cpages);
> -	}
>  
> +		return migrate.cpages;
> +	}
>  	return r;
>  }
>  
> @@ -460,7 +465,8 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  	unsigned long addr, start, end;
>  	struct vm_area_struct *vma;
>  	struct amdgpu_device *adev;
> -	int r = 0;
> +	unsigned long cpages = 0;
> +	long r;
>  
>  	if (prange->actual_loc == best_loc) {
>  		pr_debug("svms 0x%p [0x%lx 0x%lx] already on best_loc 0x%x\n",
> @@ -492,17 +498,16 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  
>  		next = min(vma->vm_end, end);
>  		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
> -		if (r) {
> -			pr_debug("failed to migrate\n");
> -			break;
> -		}
> +		if (r > 0)
> +			cpages += r;

I think you still want to break out of the loop here if r < 0,
potentially with a debug message.


>  		addr = next;
>  	}
>  
> -	if (!r)
> +	if (cpages) {
>  		prange->actual_loc = best_loc;
> -
> -	return r;
> +		return 0;
> +	}
> +	return -ENOMEM;
>  }
>  
>  static void svm_migrate_page_free(struct page *page)
> @@ -603,7 +608,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  	return r;
>  }
>  
> -static int
> +static long
>  svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
>  {
> @@ -640,29 +645,35 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  		goto out_free;
>  	}
>  
> -	pr_debug("cpages %ld\n", migrate.cpages);
> +	if (migrate.cpages != npages)
> +		pr_debug("partial migration, 0x%lx/0x%llx pages migrated\n",
> +			 migrate.cpages, npages);
> +	else
> +		pr_debug("0x%lx pages migrated\n", migrate.cpages);
>  
> -	if (migrate.cpages) {
> -		r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> -					    scratch, npages);
> -		migrate_vma_pages(&migrate);
> -		svm_migrate_copy_done(adev, mfence);
> -		migrate_vma_finalize(&migrate);
> -	} else {
> +	if (!migrate.cpages) {
>  		pr_debug("failed collect migrate device pages [0x%lx 0x%lx]\n",
>  			 prange->start, prange->last);
> +		goto out_free;
>  	}
>  
> +	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> +				    scratch, npages);
> +	migrate_vma_pages(&migrate);
> +	svm_migrate_copy_done(adev, mfence);
> +	migrate_vma_finalize(&migrate);
>  	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>  
>  out_free:
>  	kvfree(buf);
>  out:
> -	if (!r) {
> +	if (!r && migrate.cpages) {
>  		pdd = svm_range_get_pdd_by_adev(prange, adev);
>  		if (pdd)
>  			WRITE_ONCE(pdd->page_out,
>  				   pdd->page_out + migrate.cpages);
> +
> +		return migrate.cpages;
>  	}
>  	return r;
>  }
> @@ -684,7 +695,8 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>  	unsigned long addr;
>  	unsigned long start;
>  	unsigned long end;
> -	int r = 0;
> +	unsigned long cpages = 0;
> +	long r;
>  
>  	if (!prange->actual_loc) {
>  		pr_debug("[0x%lx 0x%lx] already migrated to ram\n",
> @@ -715,18 +727,18 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>  
>  		next = min(vma->vm_end, end);
>  		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
> -		if (r) {
> -			pr_debug("failed %d to migrate\n", r);
> -			break;
> -		}
> +		if (r > 0)
> +			cpages += r;

Same as above.

Regards,
  Felix

>  		addr = next;
>  	}
>  
> -	if (!r) {
> +	if (cpages) {
>  		svm_range_vram_node_free(prange);
>  		prange->actual_loc = 0;
> +
> +		return 0;
>  	}
> -	return r;
> +	return -ENOMEM;
>  }
>  
>  /**
