Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1A8CC6B30
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 10:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64B610E5A5;
	Thu, 15 Oct 2026 10:38:13 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E3CE10EBC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 10:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfMa4eIpdy6z+lR4ho9lvPzy70InOuac3Nu4zao22AIOZVlVYV3hXcvR84cA8GOwBtJX4NW9Zat78uFrrKB6C8L9HpZhGtAfxkkrWEE2r4WVfa57itGDxCIdKQN/v8xG4OG3mgiZe2ycpFX9reVY1rq2rOAruTqUl9Sh6x7x0UoW9KwFvH5NImuk16FcnZ1USdi2UJwXVsbpXkbIYpyeGWY/0S30MflqtQaDqFAMlyRM9BDj79zi7/3y1prjP4W4wICO7TlqyIyY34I5ArI1Iom7c9rIFZ6IN3zyPDMIg5F8qqzh387emMsz1HdIsw6dLWgniE7TmWvlOfx9uffJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUI9bWtPYOMEm4p1jD3ikE4ieWO8rQyH2D7khEvRSZU=;
 b=LMBCZFl3z4Wzi0af5FoIzkspzruGEAz2wzWQJ/ig9ABs4KYGp48nJvmM7XU+A7mRs/dELUOsEqiESjTHQrqI6VCxRnpXV3XBe4oK/5zbyBZXkL7ucG3wD5NQuLZKzulZOrApHwSqJKvJENE0h1CS8BW52rljbqiWzQMOaFx66m1SyUj0yo4vFS47gJw0wuhKWzp59DRolBD9GBZb6yrFWcfXSKrAejmr+mR07fEzBEkB4NXjuTjsxbe5ec7Dq+ZTPuSG9HKb35j3QLE/GSJOuNNv1EqZPXtmpjluR4AfjDl5QNQuto8FVGVJJYPtYKAPcPk23WD0dhHkQW3Al/FX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUI9bWtPYOMEm4p1jD3ikE4ieWO8rQyH2D7khEvRSZU=;
 b=2IbE12nf9MxNElUJOsLRNvpZREpR/C+vwGv9Wi8POO5BpcRvgTwkpcw8zGeBiqw5lY7sEM0Q02/8moMaGf03n3yg8HgF988MczlktJ5Vf1Rqf2e1LG3ywtvQopMFx8KjVgazZq0N+qgYTWeOIFqnUhXqXgAEoEsInjZdUuLS/Ys=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:38:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 10:38:05 +0000
Message-ID: <262a4948-c17c-4cfb-8235-64c9b3f906de@amd.com>
Date: Thu, 15 Oct 2026 12:38:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: map the seq64 memory when restoring
 user queues
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261015072150.3414162-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261015072150.3414162-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e07f83-44a7-449a-dba6-08df2aa86509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7PDOIX9/svSPCEy70WQCehGupJ5eJceaQ9zBFY2bYVGpPP5FkzpyK7tvTqYPHUNA4TaeugNao8gJiVXs0FOR0JW7Pms0doHgyZOYEkrTNPy5WbzxBt117r8IrjRY4D0dKrZwJops5gWhfesmYiA4bWhcpfZyLi3XDh7s3+7ys3fpXqLUr3KbnU7ivFhdvcvXIpo5IDt0yx5/178dskZYubSw+mj9RJ0fwegn4jpS7lG7hVJThiW/LIL1UmrAsENLVVgBJ0bDBy46H1M7t7S/J7Tv5a6/0RoHBfY0nGRqGp5z22oF60FEPzrszXOkFFpDonBE9nAGum7qrQkdouAXAJW44BB/SKeLxbORxQmWbojYaMvJC1Bx5rYFZSgD2LR5TX0vzqId1i5RZapT+20QerFu5ci/V8n7w4o38bVbESpwBhyV9yFK6U6dWHsWokD8piGhgm+YK1SvGnnVY6t5UtmT/7H/6tpFtNE897N4VAvqGiZEoTmo/7FbsfMF5dAqsJnIgfP+4v8dL9mT9cK+Aam/Iv057/k8MthgrXbGFJS3Ym7E7DJCEgvM45Veroxhkk5S/5wy0iooXGAy6kdpwMTpQzhMwX/nY4k5QamyIgn6LkVTlSbIUIfaBTeBAbaAiGDLoUE0F26L9oC+VFnVOzEYlFIwgy5fqPSpW9UstfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NWem9xWnZrNDlnVkZxS0ttMWE2aTZHTUlvcFNNRFRrZ0VZOGdDRmJaenIv?=
 =?utf-8?B?REJ3Y0haYU9wRjl5ek9leDc3M21FZS9FNlpIaUFjSXNtekV2Q0NhTmxYcFQw?=
 =?utf-8?B?eFcwSG93d2IzVmFlZFBaUktHYk1UblBzSFFOUVFZVFQyNlpPWVBFODV0M2to?=
 =?utf-8?B?RnppcWtwQkxjeDdEUkJMTFo3SGhhUDBub3IyN0pGVThuZXVMeDFvUVZ5Mm51?=
 =?utf-8?B?MjFGbVRBQXE0ektKS215cGhHWC9IdUhzZHpkTGRUQmMzS1EzOTFYbkNMdlFj?=
 =?utf-8?B?K0FWL3lHSFdmRDA0cGZqZ0Y2Yy80Y1c0UzU4MzdSSmpzQ255UVNkMmJLVFhv?=
 =?utf-8?B?ZTBEaG0yVkR6aGNOMTYwUE5vYmRQVVg5alNqU0F6OWRFTGRGTml4T3MxcVd1?=
 =?utf-8?B?YlJPMVY2YTZCUUZQY2w5L3NXKzNKQjF3cWxzdTlCbTdxMUdWT25Bd0FncEhr?=
 =?utf-8?B?QmEyeWhDZzkxZ1VndFJHSU1oOE9UZHVEN1JXMmZwZmpyUVQySExjZ1lvVStB?=
 =?utf-8?B?WFRzY0pTcS9idlFzcFVGVllJSjdGWmZDM2NRZlhYRGZHWStEUXRiRXMxZkZn?=
 =?utf-8?B?NzhqaURWend6Qmludms1OXFaZzZFSGxKOHlNck9PVGMyVlFYU1BwcHU1Z3RQ?=
 =?utf-8?B?VWxnN3FuTTZjUFdOV1FETllyYTJvbElhMFBCQUJjbk9EdVdaWXdIV1BCZ01M?=
 =?utf-8?B?S3E1S0FHVmtLSDVobXlIbXpacjhKbGNOcHNqaGNMcG04dk5VSXh6RU5IRGp0?=
 =?utf-8?B?R2hvMS9XaU9BdXYwYW5jZjR5WE80M1NaZ1lqMEx5NmtQSHo5a21FTWU3VlZH?=
 =?utf-8?B?T00xYlhiaW5RUnI0NE11RmxYeGVQL2prSUMrakovaEhGeDFia2dvZDJ1cHBI?=
 =?utf-8?B?WVJPbWJRc0hTWnoxUmtuemJvRnV3WDZ4SEQyclpqbklER1FnNFdtWkpCSXBN?=
 =?utf-8?B?eVZuVDQ1RUFQMHJLTktQRS90L0c1V2FUZXpDK3Nqc2E4b3VxRWdkM0lTOEU1?=
 =?utf-8?B?MTRzZzg3dDJHeXZxM1pBK2sxSkhjd0tkMjdKYytGbmlnc29WZDB2ZUd5d2I5?=
 =?utf-8?B?Y01YZjJEdmROQ0ZWSXp2ZjZ4dk9TbmVzcHRjYWZ0NityYnYzakRSbzllRUZ1?=
 =?utf-8?B?SGFlRmpzS2RiZ3dWbjRNOEdWSmhMd1ZFRG9uZ1RTMS9ZYUV3eUcwNWxmekFp?=
 =?utf-8?B?T1pwaTNEdjc0RVl3N1JRMlhqQzRnWkVVVWIySFNoT2pCZVNZZHJrT2k0aXY0?=
 =?utf-8?B?dHpta3YrWUJ5ckU5OFhSdUV4Q0ZuUUkzRVUrVVljZG9qVjZ0cWpjc1dyeEMy?=
 =?utf-8?B?b0U1SlZmOFZpeHRWdHJLbWVQcUlXU0V5OE5mSFJwQnJLa2RsdTVLazZtL0N5?=
 =?utf-8?B?R1ZUeHpzenJXU1dId2pVNFBuYS82TWY4UFBnMUZ6OENXa0N2b2piNjJHWDh4?=
 =?utf-8?B?RkJUeHdaMEFaemlTc0d0dUc3aVNYckNGM0NPdlJLOXhGbzdUcWN2S05nSXF4?=
 =?utf-8?B?MHdNdWxWeCtaM282cEVsTlM4anZmMElsUkF5aS9ZL2Fkd2k1Z2lBak9oVlVI?=
 =?utf-8?B?NkpMaWIrNForY2t1dUtnMFNUWU4zYmFzMmxFZ2s4OVVJRWVOVCsyeC82TjNm?=
 =?utf-8?B?akVCQzJBakI1UlVIcjVodlYyVzdNZVJPbHdFbHYrSmRUM0JCeVhMRXNvZWFP?=
 =?utf-8?B?SDkxVHBLSVl5c0lCWlF5anBhU09IT1lsWktTR3ZaQ3JRSWhsUnFVZDhtS2RR?=
 =?utf-8?B?WEtzQkQzbEkwWmJYUjlEYU9wWTdyUkNySTJCMEdPSldaREpJUEJibTVtMWhm?=
 =?utf-8?B?MnlRT3dWZFNTVkMxQkQ2aDgvYm1jQ0VWOXdBK2hPNHdGREJQWXNnLzJDM3pz?=
 =?utf-8?B?WGplMWdrRENMaHFhTXQxYlFIOFNESHUvWm9xa2wrYWxSOGluN2dWdlRmQ2Jn?=
 =?utf-8?B?T1lnL0VqYStzcUhLcW1lU3FPNHBZQURrMWJzV0YyQ3FRYTJyT0NvS2ZIL0pu?=
 =?utf-8?B?bGVEbEtRL1phMGxBV0FrYStKbXVRcU1zRnQ0NDRtQ2N4cWF0VFJiRm1hV29l?=
 =?utf-8?B?Tm9SNTFvZUEvMHlDNEQxMzk1eUlRbmZBNXpCY3pJTU1pVjhiWE5HSjJLK2Zh?=
 =?utf-8?B?eGxLM1k3aFI1K21sWlUvdktOUm1rcDBxbHpiMWQ4NHF6Z2x4OTdFYzBzcVpB?=
 =?utf-8?B?NnV3Z3Bkc0J1RzU0ZVEwS2d0NWJGYWZEbjdKVGp6OXF3MTR6YmIydit3d2x1?=
 =?utf-8?B?bXJORm1RTjNOb3pBWXdTcVdnTERQS0dxaTZWQ0V2YXREa2lBemhxMVpiMkE1?=
 =?utf-8?Q?Ggfjj8hAvDE2aDt0vO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e07f83-44a7-449a-dba6-08df2aa86509
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:38:05.0462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqT8dzGka9gwIJW4/+m8QwP19Rrr3cSc+qjvrJa06KcovlNKoM1AkEqxmHrf1RPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

On 10/15/26 09:19, Jesse Zhang wrote:
> Since the seq64 mapping of a VM only gets its page tables updated by the
> CS ioctl, a process which only uses user queues never has its seq64
> memory mapped. USERQ_WAIT hands out the seq64 address of user queue
> fences for the GPU to wait on, so a queue waiting for an earlier job
> faults on it and hangs.
> 
> A GFX user queue waiting with FENCE_WAIT_MULTI for the
> already signaled fence of its previous job (va 0xffffffffffc00000 from
> USERQ_WAIT) never gets past the wait:
> 
>   amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:24 vmid:8 pasid:13)
>   amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: CPG (0x6)
> 
> Update the seq64 mapping where the user queues get their VM restored,
> which also happens before the first queue of a file is mapped, once the
> page tables are validated again, and wait for it like for the other
> page table updates. Only do it when the PTEs aren't there yet or were
> cleared, so that restoring after every eviction doesn't write them again.
> 
> Fixes: ae05e3f3d02b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

The seq64 mapping should just be a normal individual BO mapping, so the extra handling here should be superflous.

My educated guess is that this is already fixed fix the patch "drm/amdgpu/userq: actually validate userq BOs" from Benjamin Cheng from a few days ago.

Please make sure that you have this patch and re-test if that issue still happens or if we are missing something else.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 4dca1ab48410..94b9e6890f91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1070,6 +1070,12 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  		if (unlikely(ret))
>  			goto unlock_all;
>  
> +		/* The pinned seq64 BO only needs a slot for the rearm */
> +		ret = drm_exec_prepare_obj(&exec, &adev->seq64.sbo->tbo.base, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto unlock_all;
> +
>  		/* This validates PDs, PTs and per VM BOs */
>  		ret = amdgpu_vm_validate(adev, vm, NULL,
>  					 amdgpu_userq_validate_vm,
> @@ -1140,6 +1146,18 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  	if (ret)
>  		goto unlock_all;
>  
> +	/*
> +	 * The seq64 mapping is kept up to date by the CS path only, but the
> +	 * queues wait for user queue fences through their seq64 address. Its
> +	 * PTEs only need writing when they aren't there yet or were cleared,
> +	 * e.g. by amdgpu_vm_handle_moved() after a VRAM loss.
> +	 */
> +	if (!list_empty(&fpriv->seq64_va->invalids) || fpriv->seq64_va->cleared) {
> +		ret = amdgpu_vm_bo_update(adev, fpriv->seq64_va, false);
> +		if (ret)
> +			goto unlock_all;
> +	}
> +
>  	key = 0;
>  	/* Validate User Ptr BOs */
>  	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
> @@ -1203,6 +1221,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>  	 * it explicitly (as the CS path syncs it) before restarting queues.
>  	 */
>  	dma_fence_wait(fpriv->prt_va->last_pt_update, false);
> +	dma_fence_wait(fpriv->seq64_va->last_pt_update, false);
>  	dma_fence_wait(vm->last_update, false);
>  
>  	xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {

