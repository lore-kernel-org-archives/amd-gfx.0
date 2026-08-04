Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ADDC55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 13:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B4210EA68;
	Tue,  4 Aug 2026 13:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ah8J9tir";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087CE10EA68
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 13:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mW9Tc82Ro7o6Dv0FQoKAJu/pwd2JpqurMaZXgyOhl/Jab12fgMehfJ3HtAKo/Vjw625sURtPJjFJpJY2QLDIaYW95sPV7/ZyK52gOJ+02KLJ20iBp4AuNC3ySLHhozl4dy7ytlMyvjAQXb/I/SaUA9/IHiyuiioRZNhSon8WwK3I/acnqX5oEJA1Ux2/uZg8jdTxhPN06IDU31SkeAlne9kbPUQNHdRei9YeLW6lyeJKmjaxolvFepE6ZMGCRfLqWgdG0T9eQBRNhCq/Y0oMTEsXnEKiL99QxRTE8gH0KMysUScH1JXVhVFYPstAoxQIMa4caQ9tRrpvHsPqQo+0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcv4HJAw0VS69yTueOdt+4NDzMphKkF756OiD7RlwKU=;
 b=p1ehrVYkpCvuO6P1bGwyPVrZtTSlbuT6UrlZpe7nUltSx8ouu5b/2kL1OiDGgk20vJjyesgqqh/W2pgm5CtDeswthP9gPaYExlbn3Rj/NUhwZXUlUcux9gwBpdwEF5/vZ/MrVSyvrV27gOJjNYfJ467+u5dXkq1Gw2iJLdftr0J8Rl5uBqNsje4cirQMCkcWw5OJf4mnGYSMwx7XAuPPwXcLZZSMQ/h59pl7MMWmauAhFStPGk2Tihdj1w0wO3BGsHIbPsqhObGuT88FmXr5opFGi06usirDNkw866My3iWblHzBCIUrRBfwVC4f3O9WIPZLNmwt5ILu0JIyQHU/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcv4HJAw0VS69yTueOdt+4NDzMphKkF756OiD7RlwKU=;
 b=Ah8J9tirxmmlziGnSOA3Y2ertPtvMfaPlXXfCPXEmwI2j3V/jTSUTDuNxJtLkRREE9XEVmRD+w2pRPvdJW+CFRqsWE6+gDNqMh09BUfOuDrDT9KhrySSn3mlq5kk6c6x0fZ2+Qfe0WLMvtsHx9Zn+L6oMvxMo+FqGLk/xNfQA7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 13:57:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 13:57:37 +0000
Message-ID: <84e4330b-1ea5-4499-a9a8-672f2a12c70f@amd.com>
Date: Tue, 4 Aug 2026 15:57:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260727084238.3396808-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260727084238.3396808-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 374e7873-3ceb-4a84-c92d-08def2305751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gY0rXTk9ZzXHcnGvm/tsje3hdVEzz4SWgQX7Ki2KoPuj4B3wtRMVpfIXXmthKNp63O5CKozKzDZYLLD3E+KH0qlZTPI2cH+vKePcONLKKdwt0G9DMddg+Nxy9tR89CBcHkbGBY9jKxMqKumNf/VbyB53+VqzDFtMr1yXz8XqnUo2i3r4xwmq8J0q+KjmOczpcz68znRhQcaZlwKg4x41HbBqiZNKfDgA1HYib5XBpX3c6t0P5F28yLC+GHJIVWGnKYGOFhL2dC4nTABI6apHHYYmv1kYrYgAa3wN6LK76n9KyFWaI9NEciqBunh/SiWV+xPKVxvakJi58qNSiuJg484RDW1JOxh71+QF8hKYvdfQWy2WJlHWrguEqEUxqZDv9ZqtjZC4/NS4hxoH6OzeulXdX6WFr6X4TU+7e/C92BMlRGDl6ZT+vhpZR6zj3Hl7p0f+y3uQvST40UwGc6SoVQg4h047ZeWpiaOK1Km4d/SWkfxDaRIQQv+qVHlcRZGKH7DYwB8yS015SU3nCxuh2WP2aQlBaSSLY816jeiYKlp4O3X5aXq3qjL0RVIl240tZQ4ueNIeG3tJw2l0DNGINCU5WlQxqt8NTxOeLhiOdMPBA6sNepmqI1+XuO/gwsfXuV3dO0NiBSD5VFJv//WXVHIEZmTpGet16E3Qb7M6fNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXoxWjQ3aG56Y2tpcXBrdHc0YjlKSVVCTmpKVDA5emtSMm5MUWdkN204QTkw?=
 =?utf-8?B?bURWRlpNQnl4ZEZqWVlGZ2l0RGRZR210d1gvT3FRb3hPc0M0TmlvNWFTYStN?=
 =?utf-8?B?RlFVdzhRTGNDblpNT1FRYzFrZFNzUDJkYjNkK3RVTVcxUHRKKzZ5Rit0Q1lE?=
 =?utf-8?B?Q2lRQ2hUMXFKUG83bThFWEljTnFrTy9JUG9pdGpBcEJTamtoQTN0SkRETEY3?=
 =?utf-8?B?ZG5YVjNUZDR3VnVvLy8zSStYWlJlb3o0b2tlS3FyU3RJdzhPMC8rbnFiek1y?=
 =?utf-8?B?RGcwTUUxdHB3VnFKbzh5blloeVJWa2Q3czg5U3dmY1FVdzltdnM1VjdDY0Vl?=
 =?utf-8?B?ejg4U3l4dkY5S0ZUTmJHTkF2Y05rVWNRSldERldZQlNzR2JGMzNnUVRpU0pM?=
 =?utf-8?B?a29NVWY3TnRuS2pvQnhReHRXcWJYMHdWcGo2aG9BRUUvRDRaT0VXYU4xNzVY?=
 =?utf-8?B?Q2wyZTJNWjFiWVh3QWR3dktPWElZSE1xcGhqYklBNys4ZXR5L3gxQ1RobElu?=
 =?utf-8?B?YTVzTHhQTVhGZHRCaUFXMk9acEF4WFZueGZ3YW16V1A2ODdWVkRFVkVBNjd2?=
 =?utf-8?B?YlU1NDNpRDhWTVJVNEw0Rk9SZmYzWWwzUzZzcFZxQ0lnWDdvK3d5TFJYaHhR?=
 =?utf-8?B?ZU41QUtyUUNBUHlSZnl0VHpJREtRejNUUWUveFNUMCtLWkhqdlVhTlZ6UnpO?=
 =?utf-8?B?NFBxV1hOdW5kbDJNRTUrWXVteE5acDlvY3V3UFBySTVlS1ROaHhETURHOXcz?=
 =?utf-8?B?bVZzT3dUaXBwak5IcVFMUXM5SXFCMW5aclZRemdVV09YVGQ3RlpkU2ZycVBs?=
 =?utf-8?B?Y1hpZlFRVnJ6U2c5WnZ6dGgwT2sxbjMwNlVKazh1K3Bzc0tEcDNEbWt6L1Ny?=
 =?utf-8?B?K21JM0lSa0hrTkFtY2xFVVZTUVZNK2JMYjA1TVFmcDEycFNuUHFTeHowak1X?=
 =?utf-8?B?ZFcwSTZ6TEpUNkpldUIrYXBhRmp0alFFZnEvVEI3S2dIT09ZL3I1ayt4Mm4z?=
 =?utf-8?B?U0h4emRBN1dsckpCOStJNVlYRGFmVkk5cmVQZkxHeFlSa3BiM2JNRmxrRENJ?=
 =?utf-8?B?K2FaaFlCN1p6S1lQY3hDUkFIN0dDbUxuQXMxK0FFVytwcUtBTGxPQVlPd0g1?=
 =?utf-8?B?dnEwSUJxY2k1WUtRYjg1cmpqa3BBa0wxZWpNQTNUME14RlVCMCtFbFZoeFd1?=
 =?utf-8?B?VzQvdmN0NUhrZmxIbFJwZzlvU0lNL0QzenBMNHU2eG44M3FEWTlnUVBYaDA5?=
 =?utf-8?B?dm9xRDRHcUhSVE5JWlN5UFJaTWk4WTN3RHJyR3l6MS9LY0ZZZUFTV0J0dFlP?=
 =?utf-8?B?cVF1VXBEd2dPL2ZFWEZkb1BvQkZPbGhLclNKb01xK2VtdWMvRnVYZThoY0xJ?=
 =?utf-8?B?aTRlTG9FVzh3dWRST3RTR3NHL0REeFc5SFNiNTZRNXBXVjVzWVppZWl6YzFQ?=
 =?utf-8?B?YStTRnVVSWI3azArS1QzcTFyc0NUblNVYm1yTUFjUkd1M1haQlIrS0lyYTdL?=
 =?utf-8?B?ak92Q0NDd05tNS8zeGhKaUMvVVBGSEVlYi9XVHNJd1lLeWVtUzk2a2ZxcWJS?=
 =?utf-8?B?UDNJRjRrekc0NlE1c0U4ZmhXaG9GdnIwS3FkMVlmRkpkRXF6eTl4SEg0ZHVB?=
 =?utf-8?B?Yy80Y251SVdBcXNmUTBIdnhOWkJxVFg2UVFtSHQrUkF1eUdJQ2Y5bTFTTWdY?=
 =?utf-8?B?eGtYbVEzQ013M1pRRERUWnYwZW43eDMwU1craFE1UTdacjAya1FicWFRaDU2?=
 =?utf-8?B?M1ZXMXZTRVlzWklVbHg0anQ5aU1DYXNsV2NiaHBUM2ZHeHcvdlpBWFJDdG52?=
 =?utf-8?B?U1VrVWhJdGhsR0NGMVBXYzdNYTNSTmpNTmowNjQxNGQzZUx1MHNJK2xqWEpa?=
 =?utf-8?B?cVBsQnhSTTdFT1hxRHlqc096SWRwbFVpS3JTeGVmNFJFNWF6K0YvdnpqRUh2?=
 =?utf-8?B?SndJaUYxOEhuYXFlT1VwQ1c3ZXZhNkdQaEFSK1AxbGpYR0wxMHorK0ROWlNO?=
 =?utf-8?B?K1F2RHJqaWVhYVNLQ2ZKcmYzRlkvd08wWVUwcUpNNUtlYkJiaGxlYWtvYVVx?=
 =?utf-8?B?dUs1THBEcmdRTE90a29QMGJtbCs4dWJuMklPcHVHWXg0NUtoS1NjSmpWamF0?=
 =?utf-8?B?Ry92WHVHV1dVUXJKdHV2elhVWGhaaGU3WWFubFVsVTdQR21ETEtEUExrZFEr?=
 =?utf-8?B?Z3BMd1NWN0piRXI0VEhPaTRDcVQwNHFNN2dUWlMzVGdxRW9USmlmenNtc0Nu?=
 =?utf-8?B?MkY5MUNqRmFHL1lpQ3ZOQkRtc0djSDFabzZEMDJDekRXbGNKY3prV2xONE5S?=
 =?utf-8?Q?8qGekSe0r5L4dQN1ar?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374e7873-3ceb-4a84-c92d-08def2305751
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:57:37.3259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFeXN445SPRi0MTLaPC/I5CMSANjfMEFGgOr5dbo/+Nmu7TTU4535L13aFFosGUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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

On 7/27/26 10:40, Jesse Zhang wrote:
> The individual.needs_update loop in amdgpu_vm_handle_moved() unconditionally
> dereferenced bo_va->base.bo (to read its reservation object, ttm_tt and to test
> for a DMABuf import). However bo_va->base.bo can legitimately be NULL for
> PRT/sparse mappings - amdgpu_vm_bo_update() already handles a NULL bo via its
> "else if (!bo)" PRT path. When such a bo_va reaches the moved list (e.g. the
> userq eviction restore worker running amdgpu_vm_handle_moved() while a user
> queue is being torn down during a GPU reset), the NULL deref crashes the kernel:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000158
>   #PF: supervisor read access in kernel mode
>   Oops: 0000 [#1] SMP NOPTI
>   Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>   RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
>   Call Trace:
>    <TASK>
>    amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
>    amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]
>    process_scheduled_works+0xa6/0x460
>    worker_thread+0x13c/0x290
>    kthread+0xfb/0x140
>    ret_from_fork+0x1b6/0x2b0
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> The faulting instruction is "mov rax,[rdx+0x158]" with rdx (bo) == 0 and
> CR2 == 0x158, i.e. reading bo->tbo.base.resv off a NULL bo.
> 
> Guard the BO-less case: skip the reservation dance and the DMABuf-import check
> when bo is NULL, and let amdgpu_vm_bo_update() take its existing PRT path.

Clear NAK. PRT mappings should *never* be on the moved list in the first place.

Regards,
Christian.

> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index aac8ace9d7a6..fbb76c32bff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1631,11 +1631,17 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>  		bo_va = list_first_entry(&vm->individual.needs_update,
>  					 typeof(*bo_va), base.vm_status);
>  		bo = bo_va->base.bo;
> -		resv = bo->tbo.base.resv;
> +		resv = bo ? bo->tbo.base.resv : NULL;
>  		spin_unlock(&vm->individual_lock);
>  
> +		/* PRT/sparse mappings have no BO to reserve; just update the
> +		 * page tables (amdgpu_vm_bo_update() handles a NULL bo).
> +		 */
> +		if (!bo) {
> +			clear = false;
> +			unlock = false;
>  		/* Try to reserve the BO to avoid clearing its ptes */
> -		if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
> +		} else if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
>  		    dma_resv_trylock(resv)) {
>  			clear = false;
>  			unlock = true;
> @@ -1659,7 +1665,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>  		/* Remember evicted DMABuf imports in compute VMs for later
>  		 * validation
>  		 */
> -		if (vm->is_compute_context &&
> +		if (bo && vm->is_compute_context &&
>  		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>  		    (!bo_va->base.bo->tbo.resource ||
>  		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))

