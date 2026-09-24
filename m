Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938D6C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 16:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52FD10E54F;
	Thu, 24 Sep 2026 16:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZImPaxoJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADDA10E54F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 16:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NghHMjFItuFwPEhfnLgtmWrbO/F8GnrPc99JhivTrQiwXFiDf8doF7EpzWfJsRUts5fBiM9VOKo8tWojpQR8RZergTJUv/Ub2zlmy5KuK3L6el/M7leBJBIrfnIeNvQ4H4yCCg9/LgJJhKs6xOhiTwBen8WT+9bPaMGY5BdPl0csjoz3zL18sal3QmBrFYHXCd9Wuy6SXFqF3VV6IA12mED9GNxOf/iI8Lx432RimtiKXwRKFQr+cXyxwmUFOBnqzdEiiyvHud9xMWgnesHy3GnyKJLP+GAFU6LO7Gb8BdUXTXy7rDsT+dZRnwkYt/u3VvuxfSheKLbxyDTbuEcMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqcDR0FlWGpwahJG4cPwcb+jYOo3lQHJth6/oKeFl5Q=;
 b=j4Q8n7lFasjoLxOfz58AxbZ3CeGI5W0x7uvjIODMDZZs9mQFZsMabV2Zv0Nh/hN2PH15j12lDNT15P4lU33LBzdMB8uJwIbkroVhWqzjQv6GkgdrR5KlEs1wOmSaA9kCWtRs7m6G2HuRZuMxvfK5c4gP3YQmgOL8vOe1grqas2V9G8S8Hggq16vtgjIq9qQDm1lZbLZ4TjgWT6kW1OmA18Q8PeUlfgVM3iUU56RjIvBNKiIQ/45HZ/sLto3rO77PUOKZqO/faALI1+dBvhoftK0mOii8Encw1OizMkmeWehqxVCoPPPLzLMdwlhsFHR0aXHRFVBs98GvhrSJSDr6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqcDR0FlWGpwahJG4cPwcb+jYOo3lQHJth6/oKeFl5Q=;
 b=ZImPaxoJunjJlbL+LJL2oNNUAosB1uCEA6ZcEra6AJyzE6YsiBCuuLsMXInQGLYLsgCYJmG2eeiDdjMCzV/A5g4DbTHiSt8mY1WvIEBKABHeTEoP1oGLa9+7Yz5ZNrQiC8VVTlEwh6khwPrIRawjVw8CNRMsqcbEp/B9TXI+Gfk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DM4PR12MB5842.namprd12.prod.outlook.com
 (2603:10b6:8:65::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 16:26:04 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 16:26:04 +0000
Message-ID: <0ab89b02-bd6f-45c4-8f14-192b4548d531@amd.com>
Date: Thu, 24 Sep 2026 12:26:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: don't leak bo_va when gem_object_open fails
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Stanley.Yang@amd.com,
 YiPeng.Chai@amd.com, Mukul.Joshi@amd.com
References: <20260924142129.745010-1-xiang.liu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260924142129.745010-1-xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0256.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::23) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a74561f-5bc0-4771-de20-08df1a588772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|10067099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 1kMq+ndbLlCtjAqLjRWwXqJRe/vTLMkGGrvMX/UWqeyV1bP7XPWzLU78502fYsvWWD9hf4aWXPl1Dxb3s7oW1/DT6LwBts4SwOv0QEOLHZGTdH4cLuDowXrbkfhcSl3VdZQplS+wt0dTkU0LPIO7B8ANWFTmIg5O12eFNhv6WwdyhbsAND/5WvImfU3pzGHHsKsVt1+X8lWc7AubnvcveHCB0Yud7WyqRqwtnHnnNH64loOQiQJY5kjGwQUtnzGGivUFQpth2Lz0nJpQU/82WoijT4t8VsRmzyCZtuAtVGlcz4TMq2CAVtGn6cXylvyA8QsQcu1sXhW1mgXlUPwqZLIyQtBP/zdZ677SnIUlEqk2sLfEqL5imzb9h/BSvjv76GHVCkI7DeZR3gdaXNsMnA7GVl5fhe/6V03IGA0bVltnvpsOKAedhr+9N6C43LRr92HJUdHF7IgBHgVGJScl2g7oyxTLYCpgBx3sDSXdrACcFJ+BSKFV8aqMQn/naYYzyVeCRkYEbQxjFxSVgzrxDwWjKtQUEq42NdsBwpnoWwlqDjyo5Xbrmj4M5q2QOWUCzV3tgjwI4M6Cmdnmjf0zpIUTU/ufkXbItKACi4cazWsYhCgOGKQIQ4TV4LcIvd9JqUNfO4aC+TztDUkn2/kdFWJS/piak6mWO5wvuLVrKWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RrVEt4WGdqQkZ2cU9DRmhHY1pvSmx2Yi8xRjMrdUIxTHpucnBZL081UFhU?=
 =?utf-8?B?REs5OE90VVAyRmtXbnpXQ2JQUWNKa2V3SjEzbWt1NGgrckNOdUJZeFgxVXli?=
 =?utf-8?B?NTJQUjc5bWlVUVhIL21jQVlVVjhzZGs0eDFaRlBoOTFLOWxRQ0h6bDJKd2FL?=
 =?utf-8?B?R3FNV0V3YjRRVExCU2J3cHZMejlrQnROZUVPYloxRDJQcnh4SlEvaVpOUlEz?=
 =?utf-8?B?c2ZqMXZ0NElTNTJtK0R1TG5SYncwUCtWeFpFK1hQUW1YSVBoc0tUZi9ZUk8z?=
 =?utf-8?B?UGZMcnVzRHljMmwzL0FsSXpwZndFTXFmbUZyK05VZjE3VlNjVkVXTWMwQVVa?=
 =?utf-8?B?OUZzL1FZWkduR1Z4VzR0VDNMdGE0ZnhUNE1sZVYvRnRObHYra1FiV3RqUjUw?=
 =?utf-8?B?dkVuMU5jdnR1YUZtYmlpQ1BsWll0b00vcm14YkJFOEc1NzRSakdwOHNzRTcx?=
 =?utf-8?B?T1dud1BBRjNwbmsreFQvUTdNeEY3VFhlbExPRFBHV3JFNVVFUkMzZU9tN1Vq?=
 =?utf-8?B?dWFnOWRNUkJXSjFwRmQzSTdLRHNtbFhpeWtnVHQ2YXY1VnRkM05aVHR4RlVh?=
 =?utf-8?B?V2VVelpIdDI1TDV2RmNuSHkzcTRSNlVlakhmTEFmVUZhY1JIempianNueU5X?=
 =?utf-8?B?NXpiSlFEMVl1U08xOXZwS0lWYkl6VlRrY2Q2Zm40ck9FY04yZk9ydURNQ2Y5?=
 =?utf-8?B?ZmhQTkhKZlpvWldkUExzRmMwZ1p4ZWovbEZsNU0rNmtwQ2hrKzYxbTIzaTZX?=
 =?utf-8?B?cDRQTXlLM2ZpU2hLcVY4VHduMDdpYzF1SXRzT2JkQVdqY2VLdmV2UHlJZ0F4?=
 =?utf-8?B?dWNHNnJCckhIc2x6bjhIbGVDNTBkbVRVNk5lT1hmbHU3YmpUZG9QejVMbTNx?=
 =?utf-8?B?MHpFaDFaUTZMdWF0Y1JIbDE3Z29aTFFnb0FVY2Q0WXNsRTNCVjdoRHppdU01?=
 =?utf-8?B?YnJUQ1B1U0hTYVowZGFycWR6eE8rdE1hRDJWcER4eEhSTGwzcnJuTVBtMXpi?=
 =?utf-8?B?SnRLVjk1VWZQdjRlcG1VdExORlZKT29yRlZHNGF4SDB1RnpLTXM0L01KVnNn?=
 =?utf-8?B?TjBkaGw3b1ZVMmVuMUUwbUJJcmxwQUpTWFg3b21FQkZlK2ZKcDk2VTN4c20r?=
 =?utf-8?B?RU9LMVROZ0lqdklUTGFDckJtemE2NU9oUUFVeE5WT0M1Q0JTWENaaHpOSHI1?=
 =?utf-8?B?YmZjQTZheDBNSjRqRTZGdll6dkRWdm1CUXVFU2xKUExCcjlBL3NpV3NvWnAv?=
 =?utf-8?B?eVNMYnpSYnRTV0M1d3FVbGxrTlBZUEFQRlR0T1hjSVU2b3JLZTV5a3JIUUxv?=
 =?utf-8?B?S0Q2M1FtS0J3YTVYZ3Y1UUNrTlB6NnJqeWpjbkNJU0QzcGZ2MktKbXYzczFP?=
 =?utf-8?B?SHgyM2ZucGhGM2lsc25KTmgxOU9Cb3pRL0ZLMGtGNjA1Wi9vYy9VU0h4aFhh?=
 =?utf-8?B?cWNKSk9RNWtjcy95a1dzeUNoejBZR3pnTnlGWE40Q21rcjUyalB1ZTRIVFNp?=
 =?utf-8?B?a296clplRDVsZi80T09WVXQ5RFB4bUdkWjhreVJOS0syd2h3MXdZcGJ3aTV6?=
 =?utf-8?B?R1g0WVVrTmxhT24wKzZmUmUrdnZHZCsxT2FuMkVFN2t1QXJ3UFRlYm1ydjIz?=
 =?utf-8?B?SmZwMUU0RnI3eWtVMHBlK3dFY1M4aWc4Q3hjWUxXL1k1TUlxT25RVXFvZE1v?=
 =?utf-8?B?bWc2NkRNYjBaUmkwRk1VNzNGWVQ3RXVrN3dsLzltQlhrTGZsZHFhaVoxNkVQ?=
 =?utf-8?B?dEVHMXhObG1Bd252OCtWN3lKeFZyeDVFakJyZTlVeERWN1RzOGZNUUUrbzl1?=
 =?utf-8?B?VnUzRzZ1VUt1UG1UYlg4K1BkMUswMUozNzJnMHpGbFhqUlE5RWVhRnNLUDJK?=
 =?utf-8?B?OVVMMWNpayszdXlOaTFPaDRZVWh0N0xtS3lUblVVY2ZhajYxdFJERVFjNmQr?=
 =?utf-8?B?ZEgrMHBHc3JteUJtZ2dEMlU3TFAvZ1RVWnY4VjB1QTAyZUxIY3ltV1FjbWZN?=
 =?utf-8?B?Q2V5NkZJWldWRTJVTkxNQSt5dTZhVFYxMHVnUHZJTVZlU0pDNXYxSnd3TFUw?=
 =?utf-8?B?TWdBeWdQQ0d1dFVBK3QzMVFsYVRkTmhLRmdHVjUzekRnT0syYkV0T3dTTUp5?=
 =?utf-8?B?di9OcFhsMmxDZnZ6VkMyZXd4YjJacXRlbXU5QzlnTW9JMUxUSy9EK3pEaHhk?=
 =?utf-8?B?NzJoelMvYU9VSzYvWVh3TGRtMERlcGM3VnZuMmdpU1REbVZEa0txNFpGZWhH?=
 =?utf-8?B?aDhUNUgwOEg4ZkdFYkoxSXZRaFd2QUxjNDRaTmNNZ1JWMlQrNWV1ZXpqK09M?=
 =?utf-8?Q?XMBVQNcFOO89AjOAj8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a74561f-5bc0-4771-de20-08df1a588772
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:26:04.3213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acPa7BODyLAWgmjQkyZxqnmllsbWc69PqWI3kKfu5sh0jqaz+8bKwRVLRwI1iJOaJv/o5HmLrXEkamOcdDklXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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

On 2026-09-24 10:21, Xiang Liu wrote:
> drm_gem_handle_create_tail() skips the close() callback when open()
> returns an error, so a bo_va added before a failing step is never
> removed. It stays linked on bo->vm_bo and a later eviction of that BO
> dereferences the VM after it has been torn down.
>
> Validate and fence the BO before adding the bo_va, drop the bo_va when
> attaching the eviction fence fails, and propagate the allocation failure
> from amdgpu_vm_bo_add().
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 80 ++++++++++++++-----------
>   1 file changed, 45 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 9da1880ee76d..be0c642f3740 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -260,7 +260,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	struct amdgpu_bo_va *bo_va;
>   	struct mm_struct *mm;
>   	struct drm_exec exec;
> -	int r;
> +	int r = 0;
>   
>   	mm = amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
>   	if (mm && mm != current->mm)
> @@ -270,6 +270,42 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	    !amdgpu_vm_is_bo_always_valid(vm, abo))
>   		return -EPERM;
>   
> +	/* Validate and add eviction fence to DMABuf imports with dynamic
> +	 * attachment in compute VMs. Re-validation will be done by
> +	 * amdgpu_vm_validate. Fences are on the reservation shared with the
> +	 * export, which is currently required to be validated and fenced
> +	 * already by amdgpu_amdkfd_gpuvm_restore_process_bos.
> +	 *
> +	 * This runs before the BO is added to the VM: drm_gem_handle_create_tail()
> +	 * does not call the close() callback when open() fails, so nothing that
> +	 * would need unwinding may exist yet.
> +	 *
> +	 * Nested locking below for the case that a GEM object is opened in
> +	 * kfd_mem_export_dmabuf. Since the lock below is only taken for imports,
> +	 * but not for export, this is a different lock class that cannot lead to
> +	 * circular lock dependencies.
> +	 */
> +	if (vm->is_compute_context && vm->process_info &&
> +	    drm_gem_is_imported(obj) &&
> +	    dma_buf_is_dynamic(obj->import_attach->dmabuf)) {
> +		mutex_lock_nested(&vm->process_info->lock, 1);
> +		if (!WARN_ON(!vm->process_info->eviction_fence))
> +			r = amdgpu_amdkfd_bo_validate_and_fence(abo,
> +					AMDGPU_GEM_DOMAIN_GTT,
> +					&vm->process_info->eviction_fence->base);
> +		mutex_unlock(&vm->process_info->lock);
> +		if (r) {
> +			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
> +
> +			dev_warn(adev->dev, "validate_and_fence failed: %d\n", r);
> +			if (ti) {
> +				dev_warn(adev->dev, "pid %d\n", ti->task.pid);
> +				amdgpu_vm_put_task_info(ti);
> +			}
> +			return r;
> +		}
> +	}
> +
>   	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>   	drm_exec_until_all_locked(&exec) {
>   		r = drm_exec_prepare_obj(&exec, &abo->tbo.base, TTM_NUM_MOVE_FENCES + 1);
> @@ -287,47 +323,21 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	bo_va = amdgpu_vm_bo_find(vm, abo);
>   	if (!bo_va) {
>   		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
> +		if (!bo_va) {
> +			r = -ENOMEM;
> +			goto out_unlock;
> +		}
>   		r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
> -		if (r)
> +		if (r) {
> +			amdgpu_vm_bo_del(adev, bo_va);
>   			goto out_unlock;
> +		}
>   	} else {
>   		++bo_va->ref_count;
>   	}
>   
>   	drm_exec_fini(&exec);
> -
> -	/* Validate and add eviction fence to DMABuf imports with dynamic
> -	 * attachment in compute VMs. Re-validation will be done by
> -	 * amdgpu_vm_validate. Fences are on the reservation shared with the
> -	 * export, which is currently required to be validated and fenced
> -	 * already by amdgpu_amdkfd_gpuvm_restore_process_bos.
> -	 *
> -	 * Nested locking below for the case that a GEM object is opened in
> -	 * kfd_mem_export_dmabuf. Since the lock below is only taken for imports,
> -	 * but not for export, this is a different lock class that cannot lead to
> -	 * circular lock dependencies.
> -	 */
> -	if (!vm->is_compute_context || !vm->process_info)
> -		return 0;
> -	if (!drm_gem_is_imported(obj) ||
> -	    !dma_buf_is_dynamic(obj->import_attach->dmabuf))
> -		return 0;
> -	mutex_lock_nested(&vm->process_info->lock, 1);
> -	if (!WARN_ON(!vm->process_info->eviction_fence)) {
> -		r = amdgpu_amdkfd_bo_validate_and_fence(abo, AMDGPU_GEM_DOMAIN_GTT,
> -							&vm->process_info->eviction_fence->base);
> -		if (r) {
> -			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
> -
> -			dev_warn(adev->dev, "validate_and_fence failed: %d\n", r);
> -			if (ti) {
> -				dev_warn(adev->dev, "pid %d\n", ti->task.pid);
> -				amdgpu_vm_put_task_info(ti);
> -			}
> -		}
> -	}
> -	mutex_unlock(&vm->process_info->lock);
> -	return r;
> +	return 0;
>   
>   out_unlock:
>   	drm_exec_fini(&exec);
