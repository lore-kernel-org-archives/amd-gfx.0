Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA6ACA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 14:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B483D10E172;
	Tue, 29 Sep 2026 14:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Jx/qnvb";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013059.outbound.protection.outlook.com
 [40.107.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD26610E172
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 14:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YosB/3nwlYqR/gxIlb7fm7EQclSJhA+Jb4d8Ji1gNn3GJkCUDcfk96GQ5B8vg4Q5yq3QaWmYPd2/X3JJTFBxCcTv2pvbY8fQnDagBBZXIjsDWh2bX0sRAQ9S+xJIwMdMPzXfrHvS4jMxZzytAgxmkT2YNSPCkWPkMrudgx5Ab67w3yJABmV5WV8WXYn/8WjJDI0OSVuOT3QhA98JonVvk2JHPPVRcswhzMFIiikz92h/Ek5HvUSy2anhQbwEqm8T19x60XNdRSwkfuYerrwEn2XZcre4K/KEXXIKbUodBTZ6BcBP7LjWeRVVGsvJVC/kz7ot9SLQ9GPRPkofWnATVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1ksRkOdATAmUh45WGEsYqhYpH6mROiDzZ15fD14WM8=;
 b=WiNbXB/os+iSgFeUsWEJ56ftufPUpjLm0V3NsxDKwHYp91aESPGfef8ZIdIaod95Oa0Sn5um95LshMu6HkDgPUrMYehxK6lAKRneVZeywMnIsyqC3XcMoLBuh5SUx+JIt1a9zk/9+VL5XZvEvWjaZIUPlTEjQ8eqoKl6pMe6OOI+6OLrsWfUDiWu9p7pVTN2C8I8oex1zWFSPMMrZJCpMdDjLMP/YNyUylVuUvAKWyjARU5jnZRVLThqqnQiSLOaIJBNFomQ+1WrDxga5zh8w3ql9h7oT8Iy6OvsgWdGjkm+zn15IwtElr6aYQZONJJpFTSrB1rWm+7KrbZK7NaYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1ksRkOdATAmUh45WGEsYqhYpH6mROiDzZ15fD14WM8=;
 b=2Jx/qnvbk8UP6uqwb83iTm6LI/onNZ6A5ljozcrOXVlQMCCP5wxm2y7tVzHWJANU6/fYqYkCyjnlokz2/CT8X6fLVZGJZV6AspjXJ6BW4JRAWGN5yaaNwSg17xI7hml7Rtr2AeW0gk6TVboDv7aLUbNS3G5+Smp9qpneLy14HG8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH3PR12MB7737.namprd12.prod.outlook.com
 (2603:10b6:610:14d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 14:22:27 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 14:22:27 +0000
Message-ID: <ef10e8fb-39f2-47cd-b36a-8d6ec780bbcb@amd.com>
Date: Tue, 29 Sep 2026 10:22:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Flush the pasid on all XCCs in parallel
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20260928185223.368752-1-David.YatSin@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260928185223.368752-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0488.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::18) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 39171b9f-0933-4487-62ff-08df1e35168c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: IuwFcAblvbm3Lc4Ys5BVb/ugha7Tltjc6wHjoOslzYwor6xzwq7UBS9xR4xlBnp38fHj+Jl6j+wYs7jrufUAj+aQQAwB5/3+/ngbLL1KkV297al1bMteJ0yYVjFYKmkBcbSkdx6IksgUxkkPpPDM3qRMIIAH6Kda3V1UgmcdaAaX1+yDITp/qybGebDWjs3GbaTBuxUACBhsTPWDDvJyqpI8yS8CpWAYipiKILIfzFXbQ0gTi/SP1KKuGQAhEyo1PJ6zZTe7/z71MtYQm0GdTENZ+i5+45+ImoJ8iEO6EKFFybiz+Jc54Wo7Gqb7FGbYsLCtZaw+dsVFlY50gaWeqgWcjsMhjWPLhi+sETxqPpHRoKwXKfKm8JxudJf1qsSwLnb8d+6bw1pDVOXqrcMwS2GK3uoGcxE+LRfsfs7retUAugx/RvFK8UEJDAC1oAa4rbhKb/FZNgTK8fEFtj4yIS4x1RN8euH9T1BY1o12REODckCVcTM50+68lgJzrVZzOB4+Dybfv9K33Dwc6YXt5E0r1zw/LMME26INgYTw8zH5fRhLLlSmC8FFmx61Yeta2qXmn58ViwxyJKES9svFbOcCfXL9+PT7p1cpoMd3riafsXMWT+rvc+VrFBUFH8PUCtQofIBk6qlSswxQNGiFpRzkoK+goIKAyL+f2d5YIm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtoMktuaEN5T0NxUEIzTVg1RERFbUJWZ09BbVgrR25iQVNva1RhUlAzNjBm?=
 =?utf-8?B?WmhXNjVGMTIxcHo0TEpzUG1FU0p6SXFuSVNMY2xNNEdiRkpaYmhTd0M4b0Jw?=
 =?utf-8?B?UEhLbkZBcEpLN2Y5M0Uxb0ttUCtxeUFhM2RrSEhFVmFlTUxHcnN3R0s0YzFm?=
 =?utf-8?B?U0VwTzl5Zy9xeDR4eDFaemN3Sm9PdkQvV2VCNnpzSCtNaWoyNXBpU0tGcHdZ?=
 =?utf-8?B?UnNucGRqU3hiMG4rcDdOM0JzNTI2aXptRlpvdVFJa0NvMHRVVEc5OVJDYWNt?=
 =?utf-8?B?bjhmcXNERkgvT2YyMlZld2VpTzNPNm1YRHhiZTY2cGlGRCtZQVlhMXMrTy9o?=
 =?utf-8?B?V1h0QjhKRXJyTGxTU29udWd6eG85QmRhM29ZZElWMFROZE5UeVdlb054UHJ1?=
 =?utf-8?B?V2hTQS9NMzJWaWZZWDlabjYzTVdlVlpsZ056dzcwY3NIaU5OVUpXQXpLc1Bh?=
 =?utf-8?B?Zjk4bDRxUVJuQ2c2U3h2Y0hBakJtRE1EU2lhaWNQdWlibEszS3ZRVDRoTGVz?=
 =?utf-8?B?cDJVbzFrQ0VDNGw0dXhVMkhBdmRMQ3NXNHFkcmNyc0dUYm5ORm1WMXc1YnFh?=
 =?utf-8?B?VTR4Nk16dVpYbzlwRHZ2eldtNmtTNVNDcHROTkNzNjdLOWlQckc4Z3VvSXZz?=
 =?utf-8?B?ZitOTkRiYTNpOGxYc1BzOWxZai9zenlmMmdCVUVFSTBjWHFrV2lscmtqU2Rq?=
 =?utf-8?B?RXRZbTEzNlFsaUhZZGRWdzFQYkRUWXA5L3p2OFVoczFKQkpqZE9aMnV6Nnk3?=
 =?utf-8?B?S1Z4dmFVSmZPdUZNRWlhdUpyb001L2FjcjMzd2ZaWlFwamcrRFVpOTFVQysx?=
 =?utf-8?B?RUlrQ1ZTc0RobWtVSmVkbWloL1N0MG5HQWhzTWJXbytLbWdoWStNczBDSHVm?=
 =?utf-8?B?VGNldUw0R2Z0eEVSbXZRTzhxOXdMYWZVaFN5R1ZQdFBYOTVEdTRQSUNiWUZh?=
 =?utf-8?B?N1dEdmdFRjVMZGJpellYZXBCRmRCaFZRSWpyS05qcTlmODdwS3h3bDd4L0FI?=
 =?utf-8?B?ZVVoTHFGb1RYUFEvODBzUHkxRHJ4aHUwU3ZFQnA4dm1vWXpsQW5pcjc1SU1W?=
 =?utf-8?B?Njg5T2Z2ZXl4Y1lsTGVmdmoxM0MwMSt1VDRmYlZ1Q25XOFlCNSt6ZTB5NUhi?=
 =?utf-8?B?S29UNGRrWTVoanZGa0ZMWDRjWVd0S3huc1B6c0djUkxEeitZcE9PYnpndEZ4?=
 =?utf-8?B?Zk1qSFpwRTZBb3Y5YVJDa3d0eFMyNTNNakJ2a1BWN0FZRUE4U3N0dUp3R0FK?=
 =?utf-8?B?aElmeTRwUGtka0RkU205MWFtT0RVVnFNTVNxZStQRnlCL1NwWWdiOE5OSE5V?=
 =?utf-8?B?MStxNzQ1UzgzYmZPTmJpNnE0Qi91a2JyK1laQVRCV2l6RzBQVTlRYkRIMDJN?=
 =?utf-8?B?VEVibU0yVjRHL1prNXZKR2tGbEhUdVpkc2NOYjMvcXh1Y3htRVBvL3dpY29W?=
 =?utf-8?B?bEJlTC9ub3FkdmhyNzZqbDIxRHlORmlBUUtpK1lsM3hvLzNDYkk5Y1U2eHVy?=
 =?utf-8?B?aFJiSmdaTEMzR1lVVzI0b2F5dVlobTlPZDNvOWZZRFJ3M1dBZ29DbEkwR1px?=
 =?utf-8?B?VHFDSjZzY3djVXVSTjQvVTdtei9qUGNEZkhPSlpJMVJiR0VVMURRQy9BUkFP?=
 =?utf-8?B?c1B5TjhBeWpLN0tzWnhCRithTGFiWUdPWE9zallxakFZT1dISzJwVExsdzJx?=
 =?utf-8?B?Wk0wZWs4MmFydmdIc2kvdmJvRGJyWmxQNnBya0VycXdITkZqOXplUlVSZk1D?=
 =?utf-8?B?RmpZcU9XNmh3aEVaU1c5Qk4xUnJXV3dBRDFzMTI5OFhJQ0o3WTJiU3JHcndo?=
 =?utf-8?B?N1N2RkRBTkV3bWMyMUh4eDQ5WW1ZejBldXNycTNJRUd5WEdRc3lJcGdjNlZG?=
 =?utf-8?B?S0VDdmFOcTBiRy92WGIrZGwreTJUTk8yYTRWUWtqYlJTQ2ROcFB1MnZ0eno3?=
 =?utf-8?B?UmFxT2h5Smxlb0tYalJrMk40aWM4S0ZySzR5bnE2VTNhemtacEo0VzM5c09o?=
 =?utf-8?B?VzJjeklvZTBLaTAxLy9qZ0t2VkNFQ0NtYmkxeTlyYjhkRWFFelA1V0orNXNy?=
 =?utf-8?B?S0VLYVI4bnU3OWgwaTNCaEFmd1ZkWXBkaGFiSnZKUDhNZTBvbVhOZ1MzSFk1?=
 =?utf-8?B?UDlLcmNCQnoyZ0ZZL1IwbkF2V3AvdjljQW9mRFdMWkZVUjhmL3FaTHNVelhj?=
 =?utf-8?B?YnJ0cDZ1V3NOVFZyVUtjYlk5c1ZwRFJDdVBOVkd1Zi8rVitUWmc4c2hxNC9F?=
 =?utf-8?B?dEY4dS92N0pHaS9uZlpwbFptUWFLYlhteTBuRnBJcFlHRlJacWI2Mk8xeGpx?=
 =?utf-8?Q?Y3snSrrDgGpZVhzjv/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39171b9f-0933-4487-62ff-08df1e35168c
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:22:27.2045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22NSgZPE7Z87Kr0+yy0s0VRndCiRubTrYEUeePsXpDgAEMaoJdf4Z/GBRTxUblmTTkhDfErTiGRQzwCC0mZOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
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

On 2026-09-28 14:52, David Yat Sin wrote:
> amdgpu_vm_flush_compute_tlb() walks the XCCs of the compute partition one
> at a time, and amdgpu_gmc_flush_gpu_tlb_pasid() submits the invalidation
> to one XCC's KIQ and then busy-waits for its fence before the caller can
> move on to the next. On a partition that owns every XCC of the device
> that is num_xcc round trips back to back.
>
> The XCCs do not depend on each other here. Each has its own KIQ ring,
> ring lock and fence sequence, the page tables are already updated before
> any invalidation is issued, and no invalidation needs another XCC to have
> finished first.
>
> Split the submit out of amdgpu_gmc_flush_gpu_tlb_pasid() and add
> amdgpu_gmc_flush_gpu_tlb_pasid_xccs(), which queues the invalidation on
> every XCC in the mask before collecting any of the fences, so the round
> trips overlap. amdgpu_gmc_flush_gpu_tlb_pasid() becomes a one bit mask
> call into it, so both entry points share the reset-domain handling and
> the KIQ dispatch.
>
> Note that amdgpu_vm_flush_compute_tlb() no longer stops at the first XCC
> that fails. Every XCC in the mask is flushed regardless and the first
> error is returned, which is a deliberate behaviour change for callers:
> one XCC failing to queue its invalidation no longer leaves the remaining
> XCCs unflushed.
>
> Measured on gfx950 with all 8 XCCs in one SPX partition, revoking host
> memory access for a pasid mapped on every XCC. Traced with ftrace,
> amdgpu_vm_flush_compute_tlb() drops from 141 us to 65 us, against 23 us
> for the slowest individual XCC flush. The KFD SVM ioctl carrying that
> flush drops from 0.14 ms to 0.05 ms at p50.
>
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 233 +++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  10 +-
>   3 files changed, 173 insertions(+), 78 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 1bf2a42fa63c..167f1344f8f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -782,98 +782,197 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
>   }
>   
> -int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
> -				   uint32_t flush_type, bool all_hub,
> -				   uint32_t inst)
> +static void amdgpu_gmc_flush_pasid_regs(struct amdgpu_device *adev, u16 pasid,
> +					u32 flush_type, bool all_hub,
> +					u32 inst)
> +{
> +	if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
> +		return;
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_2)
> +		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, 2, all_hub,
> +							 inst);
> +
> +	if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
> +		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, 0, all_hub,
> +							 inst);
> +
> +	adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub,
> +						 inst);
> +}
> +
> +/*
> + * Queue the invalidation on one XCC and return its fence without waiting, so
> + * that a caller flushing several XCCs can have them in flight together.  The
> + * KIQ ring, its lock and its fence sequence are per XCC, so the submissions do
> + * not interfere with each other.
> + */
> +static int amdgpu_gmc_flush_pasid_kiq_submit(struct amdgpu_device *adev,
> +					     u16 pasid, u32 flush_type,
> +					     bool all_hub, u32 inst,
> +					     u32 *seq)
>   {
> -	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
> +	struct amdgpu_ring *ring = &kiq->ring;
>   	unsigned int ndw;
> -	int r, cnt = 0;
> -	uint32_t seq;
> +	int r;
>   
> -	/*
> -	 * A GPU reset should flush all TLBs anyway, so no need to do
> -	 * this while one is ongoing.
> -	 */
> -	if (!down_read_trylock(&adev->reset_domain->sem))
> -		return 0;
> +	/* one flush + 8 dwords fence */
> +	ndw = kiq->pmf->invalidate_tlbs_size + 8;
>   
> -	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +	if (adev->gmc.flush_tlb_needs_extra_type_2)
> +		ndw += kiq->pmf->invalidate_tlbs_size;
>   
> -		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid) {
> -			r = 0;
> -			goto error_unlock_reset;
> -		}
> +	if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
> +		ndw += kiq->pmf->invalidate_tlbs_size;
>   
> -		if (adev->gmc.flush_tlb_needs_extra_type_2)
> -			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> -								 2, all_hub,
> -								 inst);
> +	spin_lock(&kiq->ring_lock);
> +	r = amdgpu_ring_alloc(ring, ndw);
> +	if (r) {
> +		spin_unlock(&kiq->ring_lock);
> +		return r;
> +	}
>   
> -		if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
> -			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> -								 0, all_hub,
> -								 inst);
> +	if (adev->gmc.flush_tlb_needs_extra_type_2)
> +		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
>   
> -		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> -							 flush_type, all_hub,
> -							 inst);
> -		r = 0;
> -	} else {
> -		/* 2 dwords flush + 8 dwords fence */
> -		ndw = kiq->pmf->invalidate_tlbs_size + 8;
> +	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> +		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
>   
> -		if (adev->gmc.flush_tlb_needs_extra_type_2)
> -			ndw += kiq->pmf->invalidate_tlbs_size;
> -
> -		if (adev->gmc.flush_tlb_needs_extra_type_0)
> -			ndw += kiq->pmf->invalidate_tlbs_size;
> +	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> +	r = amdgpu_fence_emit_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	if (r) {
> +		amdgpu_ring_undo(ring);
> +		spin_unlock(&kiq->ring_lock);
> +		return r;
> +	}
>   
> -		spin_lock(&adev->gfx.kiq[inst].ring_lock);
> -		r = amdgpu_ring_alloc(ring, ndw);
> -		if (r) {
> -			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -			goto error_unlock_reset;
> -		}
> -		if (adev->gmc.flush_tlb_needs_extra_type_2)
> -			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
> +	amdgpu_ring_commit(ring);
> +	spin_unlock(&kiq->ring_lock);
>   
> -		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> -			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
> +	return 0;
> +}
>   
> -		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> -		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> -		if (r) {
> -			amdgpu_ring_undo(ring);
> -			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -			goto error_unlock_reset;
> -		}
> +/*
> + * Wait for an invalidation queued by amdgpu_gmc_flush_pasid_kiq_submit().
> + *
> + * Bailing out because a reset became pending is reported as success: the reset
> + * flushes all TLBs anyway, so the invalidation no longer has to complete.  Only
> + * running out of tries is an error.
> + */
> +static int amdgpu_gmc_flush_pasid_kiq_wait(struct amdgpu_device *adev,
> +					   u32 inst, u32 seq)
> +{
> +	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
> +	int cnt = 0;
> +	signed long r;
>   
> -		amdgpu_ring_commit(ring);
> -		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>   
> +	might_sleep();
> +	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> +	       !amdgpu_reset_pending(adev->reset_domain)) {
> +		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>   		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	}
> +
> +	if (cnt > MAX_KIQ_REG_TRY) {
> +		dev_err(adev->dev, "timeout waiting for kiq fence\n");
> +		return -ETIME;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_gmc_flush_gpu_tlb_pasid_xccs - flush a pasid on several XCCs at once
> + *
> + * @adev: amdgpu_device pointer
> + * @pasid: pasid to be flushed
> + * @flush_type: the flush type
> + * @all_hub: flush all hubs
> + * @xcc_mask: mask of the XCCs to flush
> + *
> + * Submits the invalidation to every XCC in @xcc_mask before waiting for any of
> + * them, so the round trips overlap instead of running back to back.  Flushing
> + * one XCC at a time costs num_xcc times the latency of a single one, which on
> + * a partition holding every XCC of the device is most of the cost of a compute
> + * TLB flush.
> + *
> + * The XCCs are independent of each other here: the page tables are already
> + * updated before any invalidation is issued, and nothing in an invalidation
> + * depends on another XCC having completed its own.
> + *
> + * Returns:
> + * 0 for success, the first error otherwise.  Every XCC is flushed even if one
> + * of them fails.
> + */
> +int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
> +					u32 flush_type, bool all_hub,
> +					u32 xcc_mask)
> +{
> +	u32 seq[AMDGPU_MAX_GC_INSTANCES];
> +	unsigned long pending = 0;
> +	int xcc, r = 0, err;
>   
> -		might_sleep();
> -		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> -		       !amdgpu_reset_pending(adev->reset_domain)) {
> -			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> -			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	/*
> +	 * A GPU reset should flush all TLBs anyway, so no need to do
> +	 * this while one is ongoing.
> +	 *
> +	 * Unlike the one XCC at a time flush this holds the read side across
> +	 * every submit and every wait, so a reset's down_write() can only get
> +	 * in once the whole mask is done.  The waits are sequential, which
> +	 * bounds that at num_xcc * MAX_KIQ_REG_TRY * MAX_KIQ_REG_BAILOUT_INTERVAL
> +	 * in the worst case, and amdgpu_gmc_flush_pasid_kiq_wait() cuts each
> +	 * wait short as soon as a reset becomes pending.
> +	 */
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
> +
> +	for_each_inst(xcc, xcc_mask) {
> +		struct amdgpu_ring *ring;
> +
> +		if (WARN_ON_ONCE(xcc >= AMDGPU_MAX_GC_INSTANCES)) {
> +			if (!r)
> +				r = -EINVAL;
> +			break;
>   		}
>   
> -		if (cnt > MAX_KIQ_REG_TRY) {
> -			dev_err(adev->dev, "timeout waiting for kiq fence\n");
> -			r = -ETIME;
> -		} else
> -			r = 0;
> +		ring = &adev->gfx.kiq[xcc].ring;
> +		if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> +			amdgpu_gmc_flush_pasid_regs(adev, pasid, flush_type,
> +						    all_hub, xcc);
> +			continue;
> +		}
> +
> +		err = amdgpu_gmc_flush_pasid_kiq_submit(adev, pasid, flush_type,
> +							all_hub, xcc, &seq[xcc]);
> +		if (err) {
> +			if (!r)
> +				r = err;
> +			continue;
> +		}
> +
> +		pending |= BIT(xcc);
> +	}
> +
> +	for_each_set_bit(xcc, &pending, AMDGPU_MAX_GC_INSTANCES) {
> +		err = amdgpu_gmc_flush_pasid_kiq_wait(adev, xcc, seq[xcc]);
> +		if (err && !r)
> +			r = err;
>   	}
>   
> -error_unlock_reset:
>   	up_read(&adev->reset_domain->sem);
>   	return r;
>   }
>   
> +int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, u16 pasid,
> +				   u32 flush_type, bool all_hub, u32 inst)
> +{
> +	return amdgpu_gmc_flush_gpu_tlb_pasid_xccs(adev, pasid, flush_type,
> +						   all_hub, BIT(inst));
> +}
> +
>   void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>   				      uint32_t reg0, uint32_t reg1,
>   				      uint32_t ref, uint32_t mask,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index cffd5ca3fc66..76e6f1f96913 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -444,9 +444,11 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
>   void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   			      uint32_t vmhub, uint32_t flush_type);
> -int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
> -				   uint32_t flush_type, bool all_hub,
> -				   uint32_t inst);
> +int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, u16 pasid,
> +				   u32 flush_type, bool all_hub, u32 inst);
> +int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
> +					u32 flush_type, bool all_hub,
> +					u32 xcc_mask);
>   void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>   				      uint32_t reg0, uint32_t reg1,
>   				      uint32_t ref, uint32_t mask,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 29a66e39f3d6..25a74d497255 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1723,7 +1723,6 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   {
>   	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
>   	bool all_hub = false;
> -	int xcc = 0, r = 0;
>   
>   	WARN_ON_ONCE(!vm->is_compute_context);
>   
> @@ -1739,13 +1738,8 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   	    adev->family == AMDGPU_FAMILY_RV)
>   		all_hub = true;
>   
> -	for_each_inst(xcc, xcc_mask) {
> -		r = amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, flush_type,
> -						   all_hub, xcc);
> -		if (r)
> -			break;
> -	}
> -	return r;
> +	return amdgpu_gmc_flush_gpu_tlb_pasid_xccs(adev, vm->pasid, flush_type,
> +						   all_hub, xcc_mask);
>   }
>   
>   /**
