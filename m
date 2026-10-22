Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAF606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=edLRr7gz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DCE112521;
	Thu, 22 Oct 2026 12:09:41 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D755112524
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 12:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJHK0MZgLWsH2reW+OPf0jiMyCY1tGQ56P2QJzS4VNj8b2vRkBy2Z3PrR+1lIRAWXzHYP2ARNVLSaw75sZJATaF7x+SiJlOc/u+OrRhgseLDjxwnCmfyiQxlnZFX2Tg/uuA3b4vtAIFj5FWdWnYc/Vboii1u6dQLhjbe9ErVGCqP4fq6HvZRfTWlYfKr6Z2miCrxr0tM7TtbaI2v3MLtdllCoxns23fXJgZbYqNbh/5zDJ3xwDcGS1sDOKmjBcsGYKK7UnI7jum2shWYBiFOH4ezChxG+Y7+pzanWk++2m6MmlDDjmfLlus1gR7y8klmIMlUQsXG4I12v7+RAbqvZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOYNZFnMrDG9s3e0LlFMmhdMVOCB4Jc96B0BG/TeZmI=;
 b=nqmbZZmiOuxbAF85YXhK0Klh927ylQOaMSJPFM1qSM6MFiNPDaOp62Ehqy3Vlunz8pwoYXOBA4wGijPF8JD0bHGjsP/ZwHLMxcbQLd+WCpfZ3bPHWPqTxuKu+OzS6o4S7mTJAstXeqPFrbfkODSrCr0NJGzPIKPH8upDKn1oKa934buaeUy9fCXhSk+nDwQVd5QAfTmvduPltCbN/psxsxcCyzeC5onGool5FuhD8wiSdMWr00Y4sskv9vP+1jpggbGmaJyd8LRdXNkmqgXc0wO56ZDrumwOi9Q4L5BBI8L/WNfkjGv1f7kU2a7HRGxvK+Wn52meJhqsdGmxuRlneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOYNZFnMrDG9s3e0LlFMmhdMVOCB4Jc96B0BG/TeZmI=;
 b=edLRr7gz6nCGMgAPDK8+Bf2JMMofQoIud3vDsnew/jAFI2W2sAoGCvIZysHrJzOH//lNATPMPgQnjgM18ujScfvovUQ6TCHC0Az1YrK3uJ7gVI9c05ZYRpM7SPSaIvJVV3m3SNoV1qzwhtGR11C2FoKkAI2jTqciyuieCtysjz4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 12:09:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 12:09:32 +0000
Message-ID: <51ef2f77-30d0-45e4-b42c-d024af3b72f9@amd.com>
Date: Thu, 22 Oct 2026 14:09:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdgpu: clear vm pts upon a vm->generation
 mismatch
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261021201459.715423-1-shahyan.soltani@amd.com>
 <20261021201459.715423-3-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021201459.715423-3-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:36e::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 353eff4d-f242-48d9-85d3-08df303554a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C6LRBVaSrC7nCeWk6NDA5SbXFCE6es6XVEo0f04JrZ5ltNjKqKDu/n4JrpjN10+ZrSaxli3J2crrhyWIZCGOyArMqtMQjWaSDK8wTQyG1N79jLrE6EF8WAvfRFQT869IqnPtM/gu2L3gxohwsRWh3yfKtJjyL3OgCPo0WMiwdStUqaDSZMGcF50cNolFSRfolTfLanv39YCzIVss2h1Jauc436HfQJVK5Kxhtp9dwex7LwsWiuXafnnh8DvSn7r3TU8tTg6/JMLdDNdHoGYWkxsTMPRSQJCd2JZ+jfk1Hlo2RxSCNlqSc7ZGH3Sgnua+GrCHn9nTF4blFpmlvjhtsP5rfxJVRFr/cF8mYoC1SJIKR/PdztnlX6xwSnfabNk9GKdF3eFSO/OKWcUiM3Gn2WjDvQYiGMSg5UYXCU3758JICiF1tE6yUW/fuN87VQAyftHVbLGn1iqhBpalp803oCZUG7fDaGEDVDZi+y3TVgChsytQ4l034NrURcOt/VM1K1CWPRW7uysPYI1gCltuoo7O5+0rvMHQ1UCblDShE4HWBEO6be6mCKiDI0bVVhd/uW/wsZ+E0LERQUToHI8gNG+xh2p3omJOWbkQBuZsI6DYD0TX3306kMPM2e522Maczj1HfQIMPvO8zxH+ElDKHZNtLFw40AMvfWXYK01wyjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVlCU1RGVzdnUnZwNEJmckpveVR2U1RkZEdxSkVOcDB5QjdBa25ESEZqQ085?=
 =?utf-8?B?SGxBbXlLbXhJNGVPVUpWSE1zUkdnZitJT0lYZ0VxMlRFdUZQMFZUdGJJM01L?=
 =?utf-8?B?Z1BBVC9KVDVIbXBOMCtxdUhKV1E0Skh4U1BQay92YURzYUU2WHc0YjM5c3Vv?=
 =?utf-8?B?Q2pEdXhQb0djZ0VLVmdvL1o0bXRhYTRpeE5rR2hEeDJiNHd3Mk16Mm1UbExM?=
 =?utf-8?B?L3ppaFJ6UHRUa0FVaGYvbElGYzIzVUFJK2syZDRkU1ZacGlTYjBUZmtjcExq?=
 =?utf-8?B?MGhZN0hrTEtFWUpFb2ViaWlaNDg4V28wbVE0VDMxOHVXOTNSeTVNcDJNVVF2?=
 =?utf-8?B?SVhKV0lkVlhlblNKVVlMRzM3UWFLWUhYOE81UFhXVm1SZ1JFZ2EvOWIyQjg1?=
 =?utf-8?B?RG5GaGZHT3lVK3hYczBEZkFjVUhGSXdYTk0zUzBvL0hIL1JSZkRSblduUmFI?=
 =?utf-8?B?TTJPOU1NNzdQVGp6ck85SklFd0F4TXNBM3Bpb1d0M0dOSEJpSVExZXhUc0Rz?=
 =?utf-8?B?d2VGeVZGaG5mSnJid0RJUElFcTA1N0VzNEl1TnRRUmxsYm9FVGxCVEJnemY4?=
 =?utf-8?B?RDRjVGJ1TEVhUWdGaFBMdGVjR09PekcvWFZmT0E0Qys1MytaZUd6TEdYdXNC?=
 =?utf-8?B?VjJ2U21VTHQ1WVpYUzZ0c20xZ2daTHI2K1Bnc1p0bGt1bGVKQ1lSVFl0NGZ3?=
 =?utf-8?B?OWE5MHFUNHNoQkVHMHhUalR0cm4rdGE2a0lUUWxVNXJuNHZ1OXpkRGhNdUhw?=
 =?utf-8?B?RGwxT0szd1EyRlUxSVYvdmRRaExjZGNMV3UveC9kZnFqV2xlRXdLSUpjMXpz?=
 =?utf-8?B?V2hzK0FGbGlJaHVCU05qWE42cnRJQWNQSUNvcjRNK3dWNkVxakdZWVZ1YlF1?=
 =?utf-8?B?dkRmRWgyOTE5UEtDMVdUeFlvNGl3Y0lYQjVZZ1NFdjE0S1N5ckFJVjVqSHly?=
 =?utf-8?B?TXRSUWM2OWp4RjRRT0NZTktVZXJ0YlRseGU5blhvbDdmZXhBU0JSWkV4Nkk4?=
 =?utf-8?B?ZGRNS2REeUpIQkpzcFNBZGtlZHZqcUJTL0FKMlJRZll1cS9tSy90YXVvS25k?=
 =?utf-8?B?UVZqeHFLQ3JWMDZNbGRsN09vSklJaTlpZHFLZzNhd1RnUk4vbGVhRHB0M3Yz?=
 =?utf-8?B?a0p6WkdWS1BLemFpdnVGaWhqR1hBN0JiTFFZTWRmcnhPZ3BDR2NjbGcxcTF0?=
 =?utf-8?B?ZzdaRFJaUjk5Uyt4TDN5ano3NUFmd281M1Vpam5rU0dST254TWdDVTNZUUNx?=
 =?utf-8?B?c0ZOVUtMaTFXOTNTbWhobnVFRi9kcm1NQXhwYStCU0w0TGthL3dqV203UWNS?=
 =?utf-8?B?d0R1WUQ4ZTJjZ0dhR2Nqd2s3c3Vha1FHT0t3VjdObDlOT1RnUWJhVXE0aHM0?=
 =?utf-8?B?L1c3dUhoNDdWVkQvdHBlb20ySSsxS2dUdXJZMnNVTTNySG92Wit1WmZnYzF6?=
 =?utf-8?B?ejBmRE0xYmhaVThCUlhvTWkxU3FXcTJiKzBkZWtEMFdkb0lkVnAzMTlodDNG?=
 =?utf-8?B?b3hkRVlwNjdlOHdudit6NGFzN2JEUkdsalIySjcxM3B5S2V6WVBreWRZclFx?=
 =?utf-8?B?TjVVb1ppSG0rb2M4dTl1dmFZOElUTmc1dHcvZksxT0xMb3I1Z3F5RHN2d2Vi?=
 =?utf-8?B?Nnl3MktJREMyVzdUekdVcllZbkQvdERLRzBZUHJWNEk5alYybE5NeWdNVVFQ?=
 =?utf-8?B?bGZrSkhvTEZkN2pzUnRmREpOTERzeUF5TVRyaHp3S1IzcE4wbXl1T3JWNmpB?=
 =?utf-8?B?UnJTUkNndXpnK0M0bkQ4K04wc0lYUzhNSHZmRFNYcldkS3BPSVZyS3RwR0dl?=
 =?utf-8?B?QjhTZUZHS0tudURzQ3BxK0Mrc29Yay84WmY5N2l6cDZITG5VckI1Zk1WRlBa?=
 =?utf-8?B?S0d6M0duZnRPbis4VlRxbTBUcFZVY2dXdzFSL3Fwak1vTlQ2YTFtVDV2UEdx?=
 =?utf-8?B?OUJFSm5taU5lS2FlQzNSWUYrWm9qbTJtL3FnQVpmYXdHYkpJQXF4bnQwVmZv?=
 =?utf-8?B?WDcxNnRxRWZzV3Y3WlFtaTJXdGRUM0EySWhtMmkxeWRQVGprYjJCMzRrT2J1?=
 =?utf-8?B?L1FpTENDTTdWaE01d2UrS2ZRd3JPWnl0TGhRVm9EeHRxc2RZRlkwUmJNSjBr?=
 =?utf-8?B?SzVOVFlCYnhtWEVVQ2tKUnl6NWw5TytZTnlXL3Bmakc5SUhqcGNCU09oZzNX?=
 =?utf-8?B?M2FTVTNPMW1aK2dZZDU3eG02ZmI3bjk0M3VmV0FFdEs3MzczSzJnUHdNSlJQ?=
 =?utf-8?B?bEpoNUlybUFEM1ZjeE5PaW0vQ2dVbWJZL2xmd09sKzA3RWJIc1FLTzVGaGZM?=
 =?utf-8?Q?loPbR7w31mxCF2P5/w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353eff4d-f242-48d9-85d3-08df303554a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:09:32.2847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cIYzlPpahakAUmn8AxtJpN4atisBSWl7kJHUat3iIBOxm9l3ecixuVz1ioWhD8v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 22:14, Shahyan Soltani wrote:
> [Why]
> Upon a vm->generation mismatch, the evicted pagetables are iterated
> through, resetting their state, and moved to their preferred domain.
> However validation doesn't process the necessary step of clearing the
> pagetables' garbage data.
> 
> [What]

I strongly suggest to drop the Why/What tags in the commit message, they don't add any additional value.

> Clear the vm page tables through the kernel.evicted loop upon a
> vm->generation mismatch. This ensures any garbage data is wiped. The new
> vm->generation value is assigned after the loop.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1843b9d7bbf9..961557997cd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -630,7 +630,6 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  	if (vm->generation != new_vm_generation) {
> -		vm->generation = new_vm_generation;
>  		amdgpu_vm_bo_reset_state_machine(vm);
>  		amdgpu_vm_fini_entities(vm);
>  		r = amdgpu_vm_init_entities(adev, vm);
> @@ -645,9 +644,18 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
>  		bo_base->moved = true;
> +
> +		if (vm->generation != new_vm_generation) {
> +			r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(bo_base->bo), false);
> +			if (r)
> +				return r;
> +		}
> +
>  		amdgpu_vm_bo_needs_update(bo_base);
>  	}
>  
> +	vm->generation = new_vm_generation;
> +
>  	/*
>  	 * As soon as all page tables are in place we can start updating them
>  	 * again.

