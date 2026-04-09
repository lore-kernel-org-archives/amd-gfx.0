Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53184EA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 12:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D742F10E7CF;
	Thu,  9 Apr 2026 12:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dayYY93h";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B5710E7CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 12:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPmdpm9bNltCnoxd0Vl3KuA8DZ+A5KVAHWQ2w2xaOx7YpGqsXXzW8wnOnMOrsZM02840RFxeg0QGxVu/8BKi/Izq3ngCtT/r7L6iIMB5Qdu/TBb9XDSR0d+SJ7hrZseW4q2FziAr7ASpwIdQFH3ETz/NuEWWjd6LX/6EMkiDAwukREon5YEq04BRTCOhTTr20m5Ibt6ZkUCBsNzct5roDOVtZS+Cr2fL3qEWO1n1MiTwUpNt2h38u+xWa/iqalSmDmdfWQ+D481BblwRjBLX5IwBCXnTarCS2o7JP6dI5kQn6uJ6xEF150jR4+VP+wjfzlFsOmB9IOVLPKhxyn8zyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ktZ3MmhgONAXmOxtjf7hRxnlJdt8AY95HxcvpeDlS8=;
 b=rBpl/Fdg5hwVmN8fG73PCOGsz2+SZX3IziZCJdyc4ewYnMQgltiKlmZmI9n8hskgReoz31csVzSWXrtnbYX+UfDLAGjOzz/EvMOIjMavPFegRH+XiM9QwUp3JiTsLGiRE91vDaBVEhFQN7g2WE409I77O6wsmdG+STovnJOoeiXy506raVq1G4IoQpc76/FnmqC+6izePLW3RCT3DGdxhDXdlm+oDNFGeL+z7amZ/V5XwoKBQNf0PFz97ZtzLzhIpTK8om0qLhK14gngQLo/c/iBsSs77ElGCCMGYu9paN+EcRa+3AYPNf1FfeJkH62KfAkb3tKOd0zVwaa/N+V48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ktZ3MmhgONAXmOxtjf7hRxnlJdt8AY95HxcvpeDlS8=;
 b=dayYY93hICbc7DNokGxjbXIjIQRqna1VDOiVOClWmo6RHwrdVXafDe6Unsr63vsmz3Plc0fwfbRRD8pxQ5rcnWvsLartmtXvyuL211eCW+Yy5ZYukm12ZzVN3+Bi0BeF2LdFeQc3B51kZ+XPzcEGlbUYM6bCjwjnkFf4mHkYDDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 12:02:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:02:55 +0000
Message-ID: <cd688c50-ca2d-4a24-923f-fa280bdd7c3f@amd.com>
Date: Thu, 9 Apr 2026 14:02:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] drm/amdgpu/userq: hold reservation lock in caller
 of amdgpu_userq_input_va_validate
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-5-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409083355.1326089-5-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0301.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e288f85-7f69-4838-d1ee-08de962feeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: mkr+g8SXN8rDzVQeMhFUWFp/d+Mmq5EogNAG97l43MULS1HDwEUOiJqAD0wSse1vPwodlHcr9GRVzk8xUvypqFrzIFN0LuuxKnWHHUp9FSvND2mDJMII9ZKOxJvIFo2GWG1jn8MF9Cq7ef+CT3wp2JmB8+zcAdoqtj+AWrMS4ga9ucToabU8f1lCrQid/IiWChuL2PQ7kkfsOm9EVAXGmKcvOCxpHYS+eRcPZ6Se9162XH/9QdzFtKqNF/DLsf1WXDM2uSAvmBJQV0hMKmUt4L9b/eDCCvqcpjjtyNymy1nkAhhNQjUZWNjVN7XUQhUw0vtwuMzzyJi0b3VqxnvzsLsZ5DD3ojMNtXETaZel0brMQ0fS7w09Ei3Af/gO7EbSqc+PI/Ou2Jd+Bojt71XiZNIQ5xR/+BzKp/Q0O04KG+ve3a3j+f1tGXjkdol35EF4xJIFguQ0GCE4nXYw+ObSoCo/To6y4bPA662SM4ZhkwOtLRAnlyBTrXVc6FNpI12syYDkmMEAD9kkxTQUSi1cSMcHlSgfhopaMJNrtedNLJjD9D0z0Ja6Gr4D1gXE/NBCDHFeFAhjUtEdBLCt3zWu535av8fM1e6lxK/kT6vmD25sOyIng9nwyGjRaKRoqKg8MyNrjaadkQdelTfFvRGUr4sblA0vlUCM/lZ58R+QMlKdIAkp2O4pt9kOrxLuuB3vXg9af0dpuP79Km8DSZN/DtulHW5A3rWsbvSEc6bWtWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzYrKzlpdm5yRlltTUlNNGZGcS94a09xY3krRUgwa25Ldm1LRU1udGNIeEkz?=
 =?utf-8?B?NTZaRGsxVUl4ckdHRHhJMEduRTN1T09KV25BRkxNNll2QUtCZFdDam51Z2Rw?=
 =?utf-8?B?QTN0SUhIaVB3TVN6SXN2QU5aREZGSTd3OXR2dmlXNmJqUDU4cTBYVi9BSGJT?=
 =?utf-8?B?OUVhUVgwRzJzTHFTVkU4Mm54N0VMOC9EQkpVU1pyc09HQ0prYncwYWlpZ3JX?=
 =?utf-8?B?OTJLREZjcXBCd1dIZjFGandIR2haNFRETDlpcXRFU1hsc1AwNEJBVVRCRWx3?=
 =?utf-8?B?Q3pFdVc3RUFERStjZmVqZVpwNVhwU0xzK2VHUWszOGcxOXlhWldndEE3REtW?=
 =?utf-8?B?L1hJM3Z0UU1taFJENk91M2I1eTY3TkxWeDVjN2RUdnRsaUZvU1BMTUNLaEE2?=
 =?utf-8?B?UFJtd3FBRk0rTkwzQUJheW5jVmVlKzN1Rk8vcVByQ2NQdVhkenpISldIemFC?=
 =?utf-8?B?TGJ3VEw0THJ2VnhEMldxK2RtOE9hM1llY1NKdXExM0lFNG1rcXBqRitLQzFY?=
 =?utf-8?B?Nmt0andob1hIZHNoaUVib2NPZjlPa3I5V1Z2ZVZ0RzJvdDZGYURIbzhVcEZ5?=
 =?utf-8?B?Q3lHYVdDSnNxa3BJVEhsc3laU0J1a0h3RVhKelpzWmNGYTdKa2tueEpwTXFw?=
 =?utf-8?B?cmFlczVCM1hEUlhsQmZyTG9RZ3FNTTdhTXlBZHFZLzlDbldoak5oMTNSTjVh?=
 =?utf-8?B?R05jZXorSnRxenNOQU1LY1RPbE5DUXpGbmV6dlFrVzUxdVBpRWZmWnFaakxC?=
 =?utf-8?B?M1Mvbk5HMS9BVVN1UGtLZFcyemNocklQRjZnT1l4eXhsMUtFQ1l0cnU1SlJl?=
 =?utf-8?B?RFlrNVR2T3RoMkd5K2JZU3N1Nms3RnRUQWY3bGd4MXgwblI3S3RxLyt3NGtw?=
 =?utf-8?B?QVZQR3NnZHQzeVAxUXBPS2hMM3kvcC9wOFkwOHdGajJLUFczYTFsVEFQZ3A5?=
 =?utf-8?B?dWE2THVBN2gwdGRTRDAxbVBqTFdlQXB1Zklhc2FTQWczd1I5UXpwQjZVanA1?=
 =?utf-8?B?MjIrOUNkS2o2TCtLM0FTdG9mdE5OVjZ1NjBSNmVHQWgyL2E1TTQvZVJlcUxl?=
 =?utf-8?B?aHd3L0dhYlg4WWNGSTJFcXVOQWNwQVR6YUlLM0F1QTdhR1RVS3pJYjE0N1lG?=
 =?utf-8?B?U1lMMjJuMjhPSFRTZTVjK3lRWjMwV1BqRStnZkV4K0pWN1JwMVNGTHl2aVhM?=
 =?utf-8?B?KzV4cUdwOC9ZbjM5blFOVTY0QmgySXUwdTBUSml1eXJJME1CY05LNE9NQjVh?=
 =?utf-8?B?NzJQM1lhRTgyQjVDcEtsYjN1MStjMXlZTm51YVNtdEZXOFVPZTVxUUw1eldG?=
 =?utf-8?B?cktsb3RzUExiMG8xWXg1TzhPR0JUVCtUV0oxd0pRcm9HWGVNbHhFb3B6alBu?=
 =?utf-8?B?dnpiL3ZZZWtFWlgwdzgwY1ZFaXNlcHhLWnltaVZtb1p6UnRwRG1DWlNTdkZD?=
 =?utf-8?B?UkF2MWszWHE2K2RpYWlQU2FTRTNUcGlxMVA4RDlHS0dObllWOG5OeXBIcFlO?=
 =?utf-8?B?MjZIUmVVWkh0Ti95NWw0SUJmamN3aVlqVFZsbnhLZGdlUG5MRjVnR09DbE1X?=
 =?utf-8?B?MXRvZ0N0YS9BcG8ySlJMa0lWVTBIUWNaNEVpTzZGbEpyeXVDNEp5Y3o4MkFK?=
 =?utf-8?B?aVlIcDJiZ1ZLaVNYOU1yUjM0R3JPNm9IZzEzLzM4NmRnTytOcUtkOXVJVGVG?=
 =?utf-8?B?bXlFWkpzL2NUNVBWY3ZVT2Z3RFNsaGp3SU04NG5TeERnbWVLVnl5TEFzUzNk?=
 =?utf-8?B?RFczQzJDQmkxZ0VQdjY1SFUzbS9ERUNKNXZFcDRsTk5pVE4xcGMxdkhGMlBH?=
 =?utf-8?B?UUV4UmV3RU9ZRHRxNUJjdnV5VFd1bWhWSmJzaG1PSnMzMVFlVFhSTWRiZnN5?=
 =?utf-8?B?ZXFHZlVpSWk4aFNiQTZ5QVJmTTZweVVRVkxZWnQraHJJRUd1TVpXYnQyN3J6?=
 =?utf-8?B?U2pWM0VnaGkyd004WGR3ZXRnL2VyU0tTbzZCNkJvRjlYZXFsajFPTXR3QVJv?=
 =?utf-8?B?a253OVJOQXVERFVyOFpDb21ZZ0diYTdXeHA0UGhiZzE3eEFodnRIM0xhd1B0?=
 =?utf-8?B?cmw5eFV2ZkVVUCs4c3FVNFVmUUNJellZQ2JsWGFXcExia0hWSUJmeWdFUDFl?=
 =?utf-8?B?NDdoU1NKek15L3h4OVVrV3lhS2tpdlliaEQ0SVcxckpIR1BQOEdhcEZkRGxx?=
 =?utf-8?B?SGlwdmFEOEF1VVdRV0JjbkIxY005SzBzQVlYK2FFUjZPYlIrZGZ3RGN1bE9I?=
 =?utf-8?B?am1PNnVVQzlyU0lNbHhRY0F3aWRUb2hXcVVQQzYvYStOU1A5L1dDWDJLRVVE?=
 =?utf-8?Q?tReq+uT0eDpQHqA1uL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e288f85-7f69-4838-d1ee-08de962feeea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:02:55.1324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jw7//xBxyTqFfC98h+HRxyiYWHcZjuTcZ9LfF810mjVerwZTE+wRjR+yR0Xy3+HE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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
> Caller should hold the reservation lock for root.bo in func
> amdgpu_userq_input_va_validate.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 18 ++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 23 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1b81ce49d408..333bd84e7619 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -239,13 +239,12 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	u64 size;
>  	int r = 0;
>  
> +	/* Caller must hold vm->root.bo reservation */
> +	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
> +
>  	user_addr = (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
>  	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>  
> -	r = amdgpu_bo_reserve(vm->root.bo, false);
> -	if (r)
> -		return r;
> -
>  	va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>  	if (!va_map) {
>  		r = -EINVAL;
> @@ -255,13 +254,11 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  	if (user_addr >= va_map->start  &&
>  	    va_map->last - user_addr + 1 >= size) {
>  		amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr);
> -		amdgpu_bo_unreserve(vm->root.bo);
>  		return 0;
>  	}
>  
>  	r = -EINVAL;
>  out_err:
> -	amdgpu_bo_unreserve(vm->root.bo);
>  	return r;
>  }
>  
> @@ -773,13 +770,20 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	db_info.doorbell_offset = args->in.doorbell_offset;
>  
>  	queue->userq_mgr = uq_mgr;
> +
>  	/* Validate the userq virtual address.*/
> +	r = amdgpu_bo_reserve(fpriv->vm.root.bo, false);
> +	if (r)
> +		goto free_queue;
> +
>  	if (amdgpu_userq_input_va_validate(adev, queue, args->in.queue_va, args->in.queue_size) ||
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
>  	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
>  		r = -EINVAL;
> +		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  		goto clean_mapping;
>  	}
> +	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  
>  	/* Convert relative doorbell offset into absolute doorbell index */
>  	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
> @@ -864,7 +868,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>  	}
> -
> +free_queue:
>  	kfree(queue);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 527cf2f14691..f7e00169c0be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -322,12 +322,19 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			goto free_mqd;
>  		}
>  
> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +		if (r) {
> +			kfree(compute_mqd);
> +			goto free_mqd;
> +		}
>  		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
>  						   2048);
>  		if (r) {
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>  			kfree(compute_mqd);
>  			goto free_mqd;
>  		}
> +		amdgpu_bo_unreserve(queue->vm->root.bo);

That can be done before the "if (r)", so that we don't need it inside the if any more.

>  
>  		userq_props->eop_gpu_addr = compute_mqd->eop_va;
>  		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> @@ -365,18 +372,27 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		userq_props->tmz_queue =
>  			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>  
> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);

Acquiring and releasing the VM lock multiple times is a really bad idea, but cleaning that up can come later.

Apart from the nit pick above the patch looks good to me.

Regards,
Christian.

> +		if (r) {
> +			kfree(mqd_gfx_v11);
> +			goto free_mqd;
> +		}
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
>  						   shadow_info.shadow_size);
>  		if (r) {
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>  			kfree(mqd_gfx_v11);
>  			goto free_mqd;
>  		}
> +
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
>  						   shadow_info.csa_size);
>  		if (r) {
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>  			kfree(mqd_gfx_v11);
>  			goto free_mqd;
>  		}
> +		amdgpu_bo_unreserve(queue->vm->root.bo);
>  
>  		kfree(mqd_gfx_v11);
>  	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
> @@ -394,12 +410,19 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  			r = -ENOMEM;
>  			goto free_mqd;
>  		}
> +		r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +		if (r) {
> +			kfree(mqd_sdma_v11);
> +			goto free_mqd;
> +		}
>  		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
>  						   32);
>  		if (r) {
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>  			kfree(mqd_sdma_v11);
>  			goto free_mqd;
>  		}
> +		amdgpu_bo_unreserve(queue->vm->root.bo);
>  
>  		userq_props->csa_addr = mqd_sdma_v11->csa_va;
>  		kfree(mqd_sdma_v11);

