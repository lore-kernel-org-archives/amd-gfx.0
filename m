Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AEC606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0yKg8NyN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C8689BEC;
	Tue, 20 Oct 2026 18:41:56 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153AF89BEC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 18:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0/QaP8qij7KEupUoOUt+faJ0ZFQSPv2y3UzTZdmqO4U+a+sCK89hCX4dhujkygIJkQVwmsTYTTitkeAQvIM8hSFIIVFVj7rMXBJtNnuSJZ+dZA/58Fi/DifqYwb75aFkOgk2jhMeIpQh8s6ICatifYxmQ8lq1HPtGwN+nmiM4OAOnb3ZtEsDe3y+y6iftMDX7Hjbdh/D3CfzODATP6oddVITDU5yqNHnjkjNdfWGzbpUTI3M1ALFfIi2e/6pwSDCkrgrffrIWpxAoD9lMpBOsTbBoHrUizDiCQdJ1Kak2tkSJnQUC3VKO+foSXAwsyrZ38syjLSFP4sW4z3Kvqt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPdJFPQokb78lNyb0mleHHKEVdQubwF6oZgPIQcoM1E=;
 b=N8ik6zxqY4Rwt0+wV60EQJmeyACTufFtCmBD0vvvptzh1W44c/mLjLCcZGnajhBlG501aADY59zzeSDbB2rcOqLyeaU1GoYRJ3mTEQfZCX8hm73Po93dAYvJKYwNc+PYqWoCr9erpE63E9KKTeAb4+KYHzN6uxgyhsaFT48M9fI6Ttp/nLW3HCY8H5GKoOi/ks1D8Uwu/emlXmD1Xkqr6KEKSAaXDz8B0Y7GgZcnPVL2PseGSAGDRqj7mAZrbOTOUQzkD94B72Betpd46dDh6T/Lb+rJxpP6F/v1T7UZCrRjHmximc05sjrKWE878PadSfdd9NGzifxw49aikxneKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPdJFPQokb78lNyb0mleHHKEVdQubwF6oZgPIQcoM1E=;
 b=0yKg8NyNoRegtT/sp0W5TzHuwPb0aHIP1a8mjXi6vJ9S8qvji9Boh99+2Q3K/AM0jFtYgp3Rr+KmdBqrWphsfzghd8d6haWm7kepQGYNQX62c+2eA3H6H3dquuhBd46kVHYp/Pmf8Ldcf90Aqm0h0vTQesbF/NhRU3va4uRWiKA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by LV2PR12MB5821.namprd12.prod.outlook.com
 (2603:10b6:408:17a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 18:41:46 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:41:46 +0000
Message-ID: <bda53386-6f8f-48ae-ba0e-c25c979da906@amd.com>
Date: Tue, 20 Oct 2026 14:41:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: bound SVM ranges by the smallest GPU
 address limit
To: Daniel Huang <danielhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20261020132901.23157-1-danielhu@amd.com>
 <20261020132901.23157-3-danielhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261020132901.23157-3-danielhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::21) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: ff05bf8f-cbc9-43ff-19cb-08df2ed9cb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|4143699003|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: RMNZr5NNg84DSr8H/5+5j1yrVjoB3A1l32GrdD92l2RkeInf3T/OCGXvtgRrDjyMD/iRUyBJxCd65FMhekZ8bISCiwzUTxZ/+VRImigS9LA9AistsdtFdz/mVnmyy9LazaTVT74WPx8TLfc3KWf+zjXCsV2eSOABAywrpnfHBavdtQeX7hlRVLchnl0OaSQrSq/BTcuoeNXapnmigkjsJjDt2f9c5+bcvF7sZLGQvrZHmCfuWiQEaxEyQ9zW+GjDZOwRkkZedojiEDJuJtoTdpy2+Y7vZpYtnTJR73TyWCcRr01obAASSeTAvAu0a77AfxsK0/X1fYX55W/Hj6Tlvo7AGM5zyGH4ZwHX9SqqSVO/NW0Fp1B2Ya5xTA8bShxMW1qIWhSX5HYBd0pffd+t5biblAtqFwUIBO/j5WBfZ4NT8RDZTTYe2mt3TjLvd76120NtC9gm2DT/SyRSOp+ZNItGNR4HtQVqmHhvTB9ECU0eBLPyPdFnvINSbOlUCn/sI9Wj/sq+bN+CYq1jRHaLZ1GgYNEOi1d5cbiqHyjkC4X/8jS8YoXg1zMeXq2ALUCyjipWo5jeZzIGu4aaxjPtc6Zzl8cyQEzLwPZACnMkdcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmtnd1g3YktiUVFZSForblkrTUc0TlNXK1d4NWxMM1BaNitpU1VDeUlmMVpt?=
 =?utf-8?B?ck5YanRhQTZqdW0rWDBQek5PaGxwVkFiQ0JkN05xZDVudkZyUVNFclIrMVJs?=
 =?utf-8?B?SU1XSUVsYWhuN1QxVGwyWHhXakc2Uld1bERvUnpKanRFbEJrRm5WZ0RtQlA1?=
 =?utf-8?B?QThWRGpSWFpxcXd4VVg3Q3ZKekRjZndxazJxVVc5QnlRSGNlMnVtVVhwelZQ?=
 =?utf-8?B?MmRXREo3eDVtdEtadUpyM1VJR0ZPaUZNUDhUS3QxN3hHd3ZEZUYrMStUZ0FE?=
 =?utf-8?B?Q2FKMkpKREdkcXVxbjdmOVVFVW55c0MrV2lVZ3BUamp4WU0yQVVRTEh4ZVZm?=
 =?utf-8?B?TW9vQmdVNnRRYWJRR2h2M1BuMnFQdE5uamwyYjVlNGZnekNzQWxESUdPOHY1?=
 =?utf-8?B?eEthUU81dGkxR3o0OUtNNC9NZU9GQURBN1pYZno4NHlRUEJzMWFGVHp0dXcy?=
 =?utf-8?B?cVl2NlFHYm1iVjE5RXBjL00yNnhoRmlBZUZFYzR4U28rVTFDWkJvK05PMkds?=
 =?utf-8?B?QjJ5TTFJR2JOTXE2MExIWGNudmM4K2VscHFNaFVieU1zbWdWY0NscllVazds?=
 =?utf-8?B?TFpaWm5xN2prQlNVQUQwOVR4eU1uVmd0dDFJOVg1c1FVZEtDUjBVcHhaa0xi?=
 =?utf-8?B?M0srSTQ0MllPMEtxOFdHVmlUUTUyMnArL0FZcHFxT3pkckkvTGFOT01mS0JH?=
 =?utf-8?B?UHFwY0tDTzlCTjE2R3pxeXRTRldGZnJJajE2THNmdmc4YytLaTQ2TVpJaTZv?=
 =?utf-8?B?a3hFU0w5VFpqWm1RSjl3NXpNazE3NnZtak9SM05TeWVWbE85TS9YMm93TjN2?=
 =?utf-8?B?SnQ5TXdFY0I2NndNYnRmZ2lUR0dHWlNGYXNkQ0RXUytVbE1QTG5GWVhhNTVT?=
 =?utf-8?B?ZHAyY1M3bVNXTGx3KzhmbzZjY3RUVXNRbG5rYmUrQ1ZyVnNWdktNSldFQlB1?=
 =?utf-8?B?K3lGdExwdTc5Rjh3OWlVc0FvN2tMVkR6TEhaZ2FmblRBYTFxQUsxQ0c2RzMv?=
 =?utf-8?B?THlHNWg0RmdreUhtWDc4WHY5UWhCNVhBSmx2OVVDRTdyZGM1MjVldEljNzho?=
 =?utf-8?B?cDZyNGcvK3NRQi9Sd21RenlBODFXb01GWFZnL1VWWUNqVi9nSWNNQnVGNWhJ?=
 =?utf-8?B?dWx3dk9Ea0prdTBtOUVpMUVZc1E4Zm9wS2dTc3BxbXFYeHNhZWZzbWEreGhq?=
 =?utf-8?B?YTZ2QWhTcHVGc0QyR3NFUXlIRkdLT0hRU0lhZFp0azAxaUxQL2x2eEFjZWtO?=
 =?utf-8?B?MnVuWVFXVmIyUUdEREc3elJlSURvKzM1TlFSY25hdVBvV1BwbWxXeUQvMVZl?=
 =?utf-8?B?T3FYbmVoVlZRSXUzRWFyempVaUM4Mm4zZlV5czFtaGxYVXVnNUYrK0d5MFVn?=
 =?utf-8?B?OVJHaDc0UFhIOVJNUDlGNWlzTXdQUFZBM213MThpM2tOY1FlbzBMcEQvWEs1?=
 =?utf-8?B?b2VidEY4YTEwQTA0d252WHJoNTNMTC9kVmtDOWttTlpSUHdZVWFkcmwrOFlK?=
 =?utf-8?B?Y3RqL0h5QW9OM0t1eXk4bEhyeHZFeDNEVkQwenowSU1WSkt3TngzaXVJTTRs?=
 =?utf-8?B?dlE0RmJhVE50NWVBYldMYitGbkl5SHhBTmoySGVRV3lMQVZpOU1DbDdObjlL?=
 =?utf-8?B?K1lZdDdBUDAzTm5xSUJBa0VqOFhUVU81b2pYV3ZnWGlQYjBLVEdEbFJ4VmNk?=
 =?utf-8?B?ejV4STlEdjFzNjd0enBLNmFzWHVGTWR4MTE1REYzUDNodU0veldsRy82SytD?=
 =?utf-8?B?bVM4TUs4NTBOSklQc2lKeFBDbWV5Z1NmTS96QlM1T2NPN3QwbEpJSFpxSk9v?=
 =?utf-8?B?ZEhyaTU0TVFGZ0g2bnVVWFNwelpKRUoxU3c2M0k3NDRuVDNPaENFUFAxY3p1?=
 =?utf-8?B?WlB4aFNlV24zbkpHUVFPcWwzelRCM0dlRDlCMTdZZUZQRGlyY3lWaCtHUjE5?=
 =?utf-8?B?eW9DNTc5Wmg4SmhIRExxeWJYMW1Ia2NSb2RMSEN3VzdSQ2g1QUwyUEZ4dXp2?=
 =?utf-8?B?WTdVdzZselRkWFZqM2lJVURqT290SE92b0h1a003a3MrY2tWVWpYMXI0a3hu?=
 =?utf-8?B?NjU4eWJPM1FXU05sRzd0WTM1U05CM29WVjJEUm1BN043U3dTVk52eVJaMG94?=
 =?utf-8?B?U29COVZJVnNTTUk4d2FXbHVVVGpqOFBYQWREMkYwUWNoTm8wUHhvL01LN0Vp?=
 =?utf-8?B?ekIyRGMreTh4TFNlMm9oaW5KdkRIc0xqUWsvcDlpWWdNUkErY3M3QjBBeTRq?=
 =?utf-8?B?Z3BuYUNwNVdrNXpZUitQLzRqc0ppQlowaWs4ZHN5NWhXWnJUaHJzc2JjQm96?=
 =?utf-8?B?OFE2MWoxNHdqY3BrKzNRV3dha1RoVUQvYS9jcGI0Z01QOS9aQVM5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff05bf8f-cbc9-43ff-19cb-08df2ed9cb33
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:41:46.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cDJuTNBHipRJXYIUPj8MzcX51SWHguOScxRoYT20iKD9v7/eR09pUCsqAHW+WRNU4KxUDx72K+E/ltI7AHkBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 09:29, Daniel Huang wrote:
> KFD SVM maps memory in GPUVM at the same virtual address used by the
> CPU, but nothing bounds that address against what the GPU can
> represent. kfd_ioctl_svm() checks only page alignment and a non-zero
> size, so the PFNs reach amdgpu_vm_update_range() unvalidated. Unlike
> the SVM path, the BO mapping path validates the address range through
> amdgpu_vm_verify_parameters().
>
> Disabling SVM when the GPUVM cannot cover AMDGPU_GMC_HOLE_START closes
> the case where the GPUVM is globally too small, but it compares the
> GPUVM against the GPU's own address hole. When the CPU address space is
> larger than the GPU's, the comparison succeeds and SVM stays enabled
> while individual addresses can still fall outside the GPUVM.
>
> On a 5-level paging CPU with a 4-level GPU, mmap() returns addresses
> above the GPU limit when user space passes a hint above
> DEFAULT_MAP_WINDOW. Passing such an address to KFD SVM indexes beyond
> the allocated root page-table entries in amdgpu_vm_pt_descendant().
>
> This gap was found by the Sashiko AI review bot, during review of the
> first patch in this series.
>
> Determine the smallest GPUVM among the SVM capable GPUs of the process
> in svm_range_list_init(), where the pdds are already final, and store
> it in svm_range_list as the first CPU page index that cannot be mapped.
> Reuse shared_resources.gpuvm_size, which the KFD already derives from
> vm_manager.max_pfn and the GPUVM address hole, and reports to user
> space as pdd->gpuvm_limit.
>
> Validate against that limit where ranges are created, so that an
> address the GPUs cannot map is rejected as early as possible and never
> results in a range that is silently left unmapped:
>
>   - svm_range_is_valid() rejects out of range set_attr and get_attr
>     ioctls with -EINVAL, before any range is allocated.
>   - svm_range_create_unregistered_range() rejects an out of range fault
>     address, which svm_range_restore_pages() reports as -EFAULT. The
>     range boundaries widen the fault address to the granularity, so the
>     widened range is clamped rather than the fault refused.
>
> svm_range_map_to_gpu() keeps a hard check so that no out of range PFN
> can reach amdgpu_vm_update_range() through any caller.
>
> A process wide minimum makes a GPU with a larger GPUVM unusable above
> the smallest limit in the process, even for ranges only that GPU would
> map. Every SVM capable GMC generation uses a 4-level, 48-bit GPUVM
> except one gfx12 variant, so the minimum is uniform in practice.
>
> Link: https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Daniel Huang <danielhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  4 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 44 +++++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h  |  8 +++++
>   3 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b9a31489b1c8..a800515baf4a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -907,6 +907,10 @@ struct svm_range_list {
>   	atomic_t			drain_pagefaults;
>   	struct delayed_work		restore_work;
>   	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
> +	/* First CPU page index beyond the smallest GPUVM supported by the
> +	 * SVM capable GPUs of this process. Zero if none support SVM.
> +	 */
> +	uint64_t			max_va_pfn;
>   	struct task_struct		*faulting_task;
>   	/* check point ts decides if page fault recovery need be dropped */
>   	atomic64_t			checkpoint_ts[MAX_GPU_INSTANCE];
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cfb428c72686..3fa0d6ff7236 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1504,6 +1504,15 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		return -EINVAL;
>   	}
>   
> +	/* Backstop before amdgpu_vm_update_range() walks the page tables.
> +	 * Ranges are bounded when created, so this is not expected to trigger.
> +	 */
> +	if (npages && last_start + npages - 1 >= kfd_svm_gpu_va_limit_pfn(pdd)) {
> +		pr_debug("CPU[0x%lx 0x%lx] exceeds GPUVM, canceling map\n",
> +			 last_start, last_start + npages - 1);
> +		return -EINVAL;
> +	}

If this cannot happen, then either drop it, or turn it into a WARN or 
WARN_ONCE (the closest thing we have to "assert"). Other than that, this 
patch looks good to me.

Regards,
   Felix


> +
>   	for (i = offset; i < offset + npages; i++) {
>   		uint64_t gpu_start;
>   		uint64_t gpu_end;
> @@ -2960,6 +2969,15 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
>   					   &is_heap_stack))
>   		return NULL;
>   
> +	if (p->svms.max_va_pfn) {
> +		if (addr >= p->svms.max_va_pfn) {
> +			pr_debug("fault address 0x%llx exceeds GPUVM limit 0x%llx\n",
> +				 addr, p->svms.max_va_pfn);
> +			return NULL;
> +		}
> +		last = min_t(unsigned long, last, p->svms.max_va_pfn - 1);
> +	}
> +
>   	r = svm_range_check_vm(p, start, last, &bo_s, &bo_l);
>   	if (r != -EADDRINUSE)
>   		r = svm_range_check_vm_userptr(p, start, last, &bo_s, &bo_l);
> @@ -3410,9 +3428,18 @@ int svm_range_list_init(struct kfd_process *p)
>   	INIT_LIST_HEAD(&svms->criu_svm_metadata_list);
>   	spin_lock_init(&svms->deferred_list_lock);
>   
> -	for (i = 0; i < p->n_pdds; i++)
> -		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
> -			bitmap_set(svms->bitmap_supported, i, 1);
> +	/* The ranges of this process must fit in every GPU that can map them,
> +	 * so bound them by the smallest GPUVM among the SVM capable GPUs.
> +	 */
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		if (!KFD_IS_SVM_API_SUPPORTED(pdd->dev->adev))
> +			continue;
> +		bitmap_set(svms->bitmap_supported, i, 1);
> +		svms->max_va_pfn = min_not_zero(svms->max_va_pfn,
> +						kfd_svm_gpu_va_limit_pfn(pdd));
> +	}
>   
>   	 /* Value of default granularity cannot exceed 0x1B, the
>   	  * number of pages supported by a 4-level paging table
> @@ -3511,6 +3538,17 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>   	if (check_add_overflow(start, size << PAGE_SHIFT, &end))
>   		return -EOVERFLOW;
>   
> +	/* Reject up front what the GPUs of this process cannot map, rather
> +	 * than letting the mapping fail later on.
> +	 */
> +	if (p->svms.max_va_pfn &&
> +	    (end - 1) >> PAGE_SHIFT >= p->svms.max_va_pfn) {
> +		pr_debug("CPU[0x%lx 0x%lx] exceeds GPUVM limit 0x%llx\n",
> +			 start_unchg, (end - 1) >> PAGE_SHIFT,
> +			 p->svms.max_va_pfn);
> +		return -EINVAL;
> +	}
> +
>   	do {
>   		vma = vma_lookup(p->mm, start);
>   		if (!vma || (vma->vm_flags & device_vma))
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index f61030408f45..268a545302bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -213,6 +213,14 @@ static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
>   		AMDGPU_GMC_HOLE_START;
>   }
>   
> +/* First CPU page index that this GPU's GPUVM cannot represent. An SVM range
> + * is mappable on pdd only if its last page lies below this.
> + */
> +static inline uint64_t kfd_svm_gpu_va_limit_pfn(struct kfd_process_device *pdd)
> +{
> +	return pdd->dev->kfd->shared_resources.gpuvm_size >> PAGE_SHIFT;
> +}
> +
>   /* SVM API and HMM page migration work together, device memory type
>    * is initialized to not 0 when page migration register device memory.
>    */
