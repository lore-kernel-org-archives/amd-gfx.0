Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A285AC11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 17:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F97961DB4
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 17:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F97961DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF09C6E8DD;
	Tue, 29 Jun 2021 17:40:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD656E8D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 17:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxxtGcZjf+iNs+VBzt1K8/HYaqFG3xu8GrziiZJv/pQMXNwIimsg5C3uKbtKTyiJhAJYibMg4oMtMloFY8m7z+FMzqpxlIGlsVQjZ7fIdfDTZzkGqpU591X1M8UhdZZcGNJm9r4EopaXGBLpNggEw2Vsc16HXkNvfSBInWL0em0sINyFcffWCBPoZxWbhx1k44jOK4pnQ1lqKtvhgCM5La6NPnWNi7Yc4xYtCXTnIJeJlhxRe+1pqfp2+ZuH3KcpxTUw/qmODdQxqYulrqBO9edPB0SYM4bw7FlT+0I1r13SDNy18JG+pOxz9jEGjPzQvOdc0bqBK5gg2lOGT8p7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrgSvuL95lI7GR8luZXseRVi857XZMRuRYuKefxUqO4=;
 b=gzy5vKMkDmFqTpG3XgJ+d2igRhAybbBmB7bnS6Vew7ZeXpeEaaMC+fXV1lGL0hxrydyyQdUkSTAyIHE+bKyS4PxhLLU22erm8Ra8XYMD/1Xz2AzDrot2Uxdkrjm+H5JoHr+13hqZi3EC6QXvLaa8m580aSvZ3ZWNwgcudTeGUGB8R6J7JY3b+Pyd5woq7QqiqnRwglawiN+ilA+N4x7A1urgWX/Pq65AEvz5awcIlmn1F2S59xKWcO+26JDN/NsBf6jIajfKKbtRoGmhnZqfCoeYzmV0xrG0QfX09vo5DlOTzqZdHWviceHjN4Ner1eeSMMCl/LeHM51zFMBP7bv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrgSvuL95lI7GR8luZXseRVi857XZMRuRYuKefxUqO4=;
 b=HYRHbeaEs5IwPiqzmG2uu8367YKPFNFqmghjmGX4q2yQ4HpSfq6SkNRORyqHUN07zRnQGU5PmQVcagtSOeWC40CdmtAW0Q7UBDajyDC9EjKufM6cvna5ZHP3YUNImGk3mhqH3AumZbQ/81aDdCfsgi9eRmOEHFRcrd1I3ulwujI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 17:40:19 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::6c58:1598:e768:d45e]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::6c58:1598:e768:d45e%7]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 17:40:19 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: use xarray for storing pasid in vm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629151907.4251-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <32786ca5-a652-86fc-1a6a-4418c75d5c38@amd.com>
Date: Tue, 29 Jun 2021 19:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629151907.4251-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:acb7:5516:6a55:2bf5]
X-ClientProxiedBy: AM3PR05CA0086.eurprd05.prod.outlook.com
 (2603:10a6:207:1::12) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:acb7:5516:6a55:2bf5]
 (2a02:908:1252:fb60:acb7:5516:6a55:2bf5) by
 AM3PR05CA0086.eurprd05.prod.outlook.com (2603:10a6:207:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.21 via Frontend Transport; Tue, 29 Jun 2021 17:40:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4769784-4b73-46f4-eea0-08d93b24f64e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB376327D679AE0B23C3A123CF83029@BY5PR12MB3763.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMdvnwqlJEoke/5+tUBzye+9qIHyiM46yDVKsUv0cbob7oq0Rd1o7WQDzwC50JdSTwokkIfs6sguBRwgSLXC13LNfuTpxHri1WGAtpYf54fIRzBkvvBxXdP61hHpPfyiXacWnijQJhhybKRk8KwBfCkIpe+xR4rpmfutmbCBWsKBpNASa8Z9O25PK9xrTk07De7thiW7t0vjxJ1KbPKssLWt6UE9d4ScB5pUNP4SDMUkdA0esQA/1q8W2MJmbA8pKFFYs4/EOU/drACIGhgw740CZUU/hR3/JGPtyyLuCg8DZa3k77jKUJFIdrPoLvUMoAyJDOQo9zpREMV6+d9/gCc+S6r9O5Cqs173392HvTEH+bDSqx0I2Oil7gXL/RzE0hRYh9r7ZVAZl+bG+hKCWSuIgOduNLl2Lt1uSshWL/G/AqOQ5XGYTj1lubDELCzuQWfgILFTy5hYMg6fLinCJj4wp9HZTB4TY+skgZFSZntI3jQ75RBvkwdH1mcdwqewyXjX7ubqDL7FwDthR7eN4PsigMRaS7YfX3e+929YUJRo5bJO77QneSrN/wK12CRAaLpEgomqRxqVOvRySUiveeVKKanH+F4zUUTb12GQcl7l3mgkUHQs34gIC/aaYixqwj1a1az3NH7dNzqtKqSflJpnt+hp0HzSbmIQvuRi0ovlLzCxquB95X12NAfV2HyKK7uX975uHHWJ5Nl24tDwoBIxTdk75yVqUeFOHdJZXe4qMrcdvbKcS4SsGQ6Yipnj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(6666004)(316002)(6486002)(38100700002)(16526019)(186003)(4326008)(83380400001)(2906002)(478600001)(66556008)(66476007)(31686004)(5660300002)(2616005)(66946007)(36756003)(8676002)(31696002)(86362001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhBaXZFdDRtUWZucU80SHZVdE8veHhCSmN4YUwzZHZVYUM3WThVRWhCNGFt?=
 =?utf-8?B?TkRRcjBhYnRTa1ZZcFppcldCRUtwOEU3N2RPY0pkNjVXTHo0MDUvZlZ5YURG?=
 =?utf-8?B?MVcxY3g5T0t5bDYxWG1GZGhxNC9PSUl5K0l2Z2FUaGhXY3ZCSi8wWG5SazJs?=
 =?utf-8?B?R0Q2R1htZDIycXRCRTJKNU0ybnljTzZTanZYWjZLcW5nSTJCdzZZZDdYYUw4?=
 =?utf-8?B?NkVpbGZ1RXRnS3pLaHVVQ0hvTjdYa2pWa3QyKzk1a3dvRVZneXRmMFNvaDdC?=
 =?utf-8?B?M3pPN1lCS2tSZEVDdjZlY0hSMzNkWFpGSEpkK2pFVjhVNnpUWms2eE5MSnNq?=
 =?utf-8?B?OWtuMndaLzVValRhSjhmTnVhTDB1V0tWVGc1di9mNitzYzRCRXdxaTdMM3FR?=
 =?utf-8?B?czZpTzVCU1NCYW5yWmR4bmI0Y3BWTm5LNmR0N3EzdXA2UThkeTNmdnVpdWFE?=
 =?utf-8?B?OUxOd2FMcDU5bmt3TERrL0syelZnUUIreVNrRUFOZXY5NXU1RmdGTkVObGdS?=
 =?utf-8?B?RW1vdHc2UVI2Q1hQRmVTdXlzdDY3TjFrUVl0SzhJb3lqeW1LTTUyRDU1Y3ZS?=
 =?utf-8?B?UXljWGJMeDZFV3RoZWRiZXcwUVdCdXVScllXZnFJd0kyZC9GejRYZlBvM1lZ?=
 =?utf-8?B?WVc3eURadmpwMUhiK0Z1NFpNTlo2b2M2OFJqb1Q5bTNwNnpGSVRrVFUxd2FM?=
 =?utf-8?B?NmhwcnhTYTBRcXBpbkNaU3NSUHNEenBNc3pmSlkvSE14Z2JlU3N4eEhmR3JK?=
 =?utf-8?B?N1RVVFg1dGdmRTRQdGdYbTV1RWRpNXBsVlpua0RQM0x1ZXBCMWdSNmt3dG5q?=
 =?utf-8?B?eDBzY3FwUlloMWpQbkd1UG16eXBMSVVDZ3Q5YlRXT0h6d0Z6bmh4UUNHU2ox?=
 =?utf-8?B?bFdaMXFIUVExV2RzQkFjM1FHdFg3M2puKzZPa2lDWjF3M2ZLQUp0bXVNRWxS?=
 =?utf-8?B?Y1VFNFBTQndxYm1rRWN5bFFHTm42aXV6ODNhZFQwa2pGM0ttM0I5U3lIQ1NW?=
 =?utf-8?B?cTBvODg5WG5HMVpHN21FRU9tSkdZYUJLeXBONG5KVWloZEVXYmNrcm45RGVE?=
 =?utf-8?B?MTBOL3dHUzNoVXE0SUxwa1VQQ3VHeWwvNDdqR3Q3UncyMnNPZUNyL3dseGVo?=
 =?utf-8?B?dUppMkxtYlNMRjVkdjRHSlBBRHZmYmhTdHgzdC9zTitiQ3JXcE8wUUt1bzZU?=
 =?utf-8?B?OVVpM2YxNGp3U2twZ25WSFE1SDhTK215K29UdEpBT0Z3d3NYb2J0R0FEd1B0?=
 =?utf-8?B?U2Q2Uk9wTE5WZHZBRlZLU3JSMWpmdU5CZ2NYMGh5a0pjT0hmRTQ3cDBRNkc1?=
 =?utf-8?B?RUFXVDBQdmErc0ZUUm1tallYaTRCMFoyZGIvQ1hvL3F0dkZibjhPcmtLanJ1?=
 =?utf-8?B?b3J6SVFvUTVlUmZoVVVtc0tHaEY3Mm1vbmlFYXpxTStkSEZMSDhycnZVNXh3?=
 =?utf-8?B?N0NUcVZhbkxoYU5XczB5eStSNHJlWDdlbW5DQ3ZydktCTTIya203YnJlZ2Fo?=
 =?utf-8?B?ajNIMTZOT2FZZjN2elFqbmQ0Q2g2TU4vRGNGYUJVQVIvdnRDUUZMb2VlbVMx?=
 =?utf-8?B?ekNiWER3Q29iVDFHL2dJaHhUc015YjI2aXcxR0JxVEZNcVRFSFZvcjVVWnhl?=
 =?utf-8?B?Y0xyNVhTU09zTFNPOXY4RndseHVxaUluV0FjZGhieFo0ZjlaSUo3Uis4MGkx?=
 =?utf-8?B?TEF0NHZMdGFNQ2RmLzF3SzN5S0dnN2ZuQ1k2N2h2ckx4eHh3dkFYend1TGND?=
 =?utf-8?B?QmtmR1dzczdQeXloZDZlVXo1K3pqRlNMR0hlOU9PaUZYbm01dTcrc25TZHhV?=
 =?utf-8?B?YVFOOWZTemJ6Ny9BT2kvS21lRklpVFRzTkpRNEx6amxsRnVUWkM4UUY5MEh6?=
 =?utf-8?Q?EXGqsKJSU2rtL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4769784-4b73-46f4-eea0-08d93b24f64e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 17:40:18.8674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJVHMCEwmBkoukA0AfaRS5ODoDkh0dSt8RiTyM8J+E3/VoHrPnCB4YqkloRFDF5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3763
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 29.06.21 um 17:19 schrieb Nirmoy Das:
> Replace idr with xarray as we actually need hash functionality.
> Cleanup code related to vm pasid by adding helper function.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 149 ++++++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   6 +-
>   2 files changed, 73 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 63975bda8e76..fd92ff27931a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> +/**
> + * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
> + *
> + * @adev: amdgpu_device pointer
> + * @vm: amdgpu_vm pointer
> + * @pasid: requested pasid

Better write "the pasid the VM is using on this GPU".

> + *
> + * Each pasid associats with a vm pointer.

That is misleading. KFD most likely want to associate the same pasid 
with multiple VMs on different GPUs.

Better write "Set the pasid this VM is using on this GPU, can also be 
used to remove the pasid by passing in zero.".

>   This function can be use to
> + * create a new pasid,vm association or to remove an existing one. To remove an
> + * existing pasid,vm association, pass 0 as @pasid.
> + */
> +int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			unsigned long pasid)

"unsigned long pasid"? The pasid is either 16 or 20 bits IIRC.

Regards,
Christian.

> +{
> +	int r;
> +
> +	if (vm->pasid == pasid)
> +		return 0;
> +
> +	if (vm->pasid) {
> +		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
> +		if (r < 0)
> +			return r;
> +
> +		vm->pasid = 0;
> +	}
> +
> +	if (pasid) {
> +		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
> +					GFP_KERNEL));
> +		if (r < 0)
> +			return r;
> +
> +		vm->pasid = pasid;
> +	}
> +
> +
> +	return 0;
> +}
> +
>   /*
>    * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
>    * happens while holding this lock anywhere to prevent deadlocks when
> @@ -2940,18 +2980,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		if (r < 0)
> -			goto error_free_root;
> -
> -		vm->pasid = pasid;
> -	}
> +	r = amdgpu_vm_set_pasid(adev, vm, pasid);
> +	if (r)
> +		goto error_free_root;
>   
>   	INIT_KFIFO(vm->faults);
>   
> @@ -3039,18 +3070,15 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto unreserve_bo;
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	/* Free the original amdgpu allocated pasid,
> +	 * will be replaced with kfd allocated pasid.
> +	 */
> +	if (vm->pasid)
> +		amdgpu_pasid_free(vm->pasid);
>   
> -		if (r == -ENOSPC)
> -			goto unreserve_bo;
> -		r = 0;
> -	}
> +	r = amdgpu_vm_set_pasid(adev, vm, pasid);
> +	if (r)
> +		goto unreserve_bo;
>   
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
> @@ -3061,7 +3089,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				       to_amdgpu_bo_vm(vm->root.bo),
>   				       false);
>   		if (r)
> -			goto free_idr;
> +			goto free_pasid_entry;
>   	}
>   
>   	/* Update VM state */
> @@ -3078,7 +3106,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		r = amdgpu_bo_sync_wait(vm->root.bo,
>   					AMDGPU_FENCE_OWNER_UNDEFINED, true);
>   		if (r)
> -			goto free_idr;
> +			goto free_pasid_entry;
>   
>   		vm->update_funcs = &amdgpu_vm_cpu_funcs;
>   	} else {
> @@ -3088,36 +3116,13 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->last_update = NULL;
>   	vm->is_compute_context = true;
>   
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -
> -		/* Free the original amdgpu allocated pasid
> -		 * Will be replaced with kfd allocated pasid
> -		 */
> -		amdgpu_pasid_free(vm->pasid);
> -		vm->pasid = 0;
> -	}
> -
>   	/* Free the shadow bo for compute VM */
>   	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
>   
> -	if (pasid)
> -		vm->pasid = pasid;
> -
>   	goto unreserve_bo;
>   
> -free_idr:
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
> +free_pasid_entry:
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   unreserve_bo:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
> @@ -3133,14 +3138,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
> -	vm->pasid = 0;
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   	vm->is_compute_context = false;
>   }
>   
> @@ -3164,15 +3162,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		vm->pasid = 0;
> -	}
> -
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
>   
> @@ -3254,8 +3244,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   	adev->vm_manager.vm_update_mode = 0;
>   #endif
>   
> -	idr_init(&adev->vm_manager.pasid_idr);
> -	spin_lock_init(&adev->vm_manager.pasid_lock);
> +	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>   }
>   
>   /**
> @@ -3267,8 +3256,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>   {
> -	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
> -	idr_destroy(&adev->vm_manager.pasid_idr);
> +	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
> +	xa_destroy(&adev->vm_manager.pasids);
>   
>   	amdgpu_vmid_mgr_fini(adev);
>   }
> @@ -3337,13 +3326,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>   	struct amdgpu_vm *vm;
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>   
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm)
>   		*task_info = vm->task_info;
>   
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>   }
>   
>   /**
> @@ -3385,15 +3374,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	struct amdgpu_vm *vm;
>   	int r;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm) {
>   		root = amdgpu_bo_ref(vm->root.bo);
>   		is_compute_context = vm->is_compute_context;
>   	} else {
>   		root = NULL;
>   	}
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>   
>   	if (!root)
>   		return false;
> @@ -3411,11 +3400,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unref;
>   
>   	/* Double check that the VM still exists */
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm && vm->root.bo != root)
>   		vm = NULL;
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>   	if (!vm)
>   		goto error_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ddb85a85cbba..8e8bc132e590 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -359,8 +359,7 @@ struct amdgpu_vm_manager {
>   	/* PASID to VM mapping, will be used in interrupt context to
>   	 * look up VM of a page fault
>   	 */
> -	struct idr				pasid_idr;
> -	spinlock_t				pasid_lock;
> +	struct xarray				pasids;
>   };
>   
>   struct amdgpu_bo_va_mapping;
> @@ -375,6 +374,9 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
>   void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>   void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>   
> +int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			unsigned long pasid);
> +
>   long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
>   int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
>   int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
