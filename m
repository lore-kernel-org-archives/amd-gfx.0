Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFE606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kDEVP2nl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB0B10E031;
	Wed, 21 Oct 2026 15:36:41 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3CC10FEA1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 15:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYYzLvRIl30kLmdN29XFmdXoWMkFcNAjmq0UOWde7TfXVdMrUHH5KNvgvrWHKhNTW6MFip6SJCqea38kmJgwfrxGbL1Ik8xSwJTK7tqb7+r7sg4TyGmBmA1RE02xo2EhJBuaEMfeeP1z9DxkFQ0mV2GDkPJ5TIpQ0jgVajmMydPEzJ7qIFAH3V9dzsCeUuxiQed0x0TMGhzg6B/hijdgZj5TZCpI8b/LRRRTf+k+G7OXzio2d9kQ39yNqgmz78yBxzfI+GDYUfJWTRD+4oza2rvcYybc6ybytY1mMo4YIOpwP0A2cnorsht/+aBZrRFzNqTp1/VHOXoAyfdKGMtTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6+WeoAduR0+M4ILdMzuhMPNo222/clDgxhjDErTnCM=;
 b=XAhoAXQru2aAPXuyNO5g2B9iTD+UDC3jkvM1r3SgvlluxraOpjYMg0y9OEik2fmL0ow3VemN7Bti7olb153+aPtFooP/Gk8om22XTLzMM0CZXXQeHtmKR12iJ5V1nzlWFT5I26LLstswxNDurnSh1sKbLC0bS+fHmuBGdUeiiVKwDUZETfjq6MZNncb8pMrSd+/Qeb+8arUNiahkq5pWRrW1Vn7H/9nSx9tYm13LUymJBRAnVC0ZAHKoEn6WMU21Yi9zXcSRzKSs4xXquPM9wdbSX+R9nCrFesfS5/sE7gUeSFxxu9Qxa3k1i59SFBZeCkwn6Gi9BmQ4CUQQ5baVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6+WeoAduR0+M4ILdMzuhMPNo222/clDgxhjDErTnCM=;
 b=kDEVP2nl5Jdh26yaKFm03TNGP8VyPj8DoIpcQOFo0V4vZs6If62HTBj+kNgPrvKXTtwA6kaEHIBr/3cM2UEbLI63Xj2+C/9CLvwMrISaZ1pulZnuzmvlDrTUfmvXk1CbhlpePnMPE4oJeYNAYDyMGHljwTK1R7jOVt4ZcEN2b74=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ2PR12MB8035.namprd12.prod.outlook.com
 (2603:10b6:a03:4d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 15:36:29 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:36:28 +0000
Message-ID: <e96c513f-43d2-404f-b938-940b4db97304@amd.com>
Date: Wed, 21 Oct 2026 11:36:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdkfd: bound SVM ranges by the smallest GPU
 address limit
To: Daniel Huang <danielhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20261021095906.48630-1-danielhu@amd.com>
 <20261021095906.48630-3-danielhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261021095906.48630-3-danielhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::18) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: dc997916-d475-4a86-cff8-08df2f891303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|5023799004|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: sjmxZO8mcvqLoT5935deqYPvK3x3su4hb/rdT0p+sFiIbt3DjaDOCr274TDXvDZs1NVexKeSTOx6DoPjjY4THwyxEuhuRPMg54hbbe4OsOydzlvGysgWmjpKYIy8GegsVjLjZSgEElTAxHp7XVmGUhPzw1CHP2ifcM87q3RMEcSZmkQv9mw8fL+PI2ePsiPQBizsKzqus+5++Hf2ZgzDbZ5p60prd2yyQvXYOh5LaHTjx2i+9QamaTwuEtCL7v0k0cHc4a3AsEu1gAMs/R3pVbdYzzKt+9bZZVnWTZqkZDOoRW+gHns2WazeLuDEi4J1JtsSdRIw05/pSGjFIPCMfNxOzFANwpZBZPOFluuD4J06ylrf9mvXVJuRwWSdz6o1dodgjCpkEk9bPIazVDTcpos0G2yZ6PZQ/PcHeMxjRET/7cHosKcVpH6kYDmqQRixhUf3PNgZguDdB8fLy9Q2lmDP9bhpVxKu3RzPCvBn6Bv9G8EX+KVtYvLTYTVT3V30Snm4N4QgP8N9Xn5/eSDfoKdCS0QYcy3kGtyhyE2o70cR5xdWYLVCyfM2T81Q+mOPWW7OzwLhrfSXdM06OE5UN9yUZNOEcBcIsDd8fA/FpWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(5023799004)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmZzRGxNTkNvUGNhUHRyUi92WEFnVCtVV2pVbFRVYmtVRURHTGNGWXJINzdS?=
 =?utf-8?B?cFNhczdJMExQV0FTbk0xZTZVVWoyZHZ3ZkprSTk0VkdvczZKU3ZpRGsraG50?=
 =?utf-8?B?MDFpUDd4WnJQVk9NZ2ZRWTQzeno4amN0MnNpalVIUWpPUHF0MXp3VUU1enJZ?=
 =?utf-8?B?V1kzTFR0Q291bm5YaW9ZdS9TV2hrYjNxdE5PMUd4aThxZmYzSkhkR2NBT0F2?=
 =?utf-8?B?UXlmN3dsbWkrVU9zQXl6N0h5bGZKTERETW1DY0NrOWc0VUNBbWhPcjRVREhI?=
 =?utf-8?B?d2VoNVJtclV3Z1F1UzJ5WHc5VmpwWUg2dkZOMk0yZ0ZyU2dtQkJMVk9BZCsx?=
 =?utf-8?B?RjFmVDdadkFYSDFxbHdFeGtjRjFwcXlGUHIxMzFaYjliUno3amhyYXNZZlh6?=
 =?utf-8?B?amRzYkRDZ09QYUxGZnVNYldVcDZzM3FxL05ZdUZ2MEN1MWk1UjIrZTZVS1FH?=
 =?utf-8?B?V2dMK2dRNUJMWXNCejBjZnlreW03ZlR6SThaMmFrMU1zTzhjdVN2cENRYXY3?=
 =?utf-8?B?VjlFTGR5RVVBSnV2VmlyT3dhcDZMQkh2TlVMc00xSjlQNk9qQUtBNEJ2ZnNW?=
 =?utf-8?B?RjFjc2RHTTZaeVBvQmR0aGR3d1F6NWxwdFFzMDZNN3ZZMVJoSmJOMEI5dUV3?=
 =?utf-8?B?dE9IeEtBUUZyODJ3QVdiQWRHekNtL0YxOHU5cWJ4RHlydExJbGxoY0VvMUcx?=
 =?utf-8?B?S1h3a2N1T0FXMXZDLzNDYjN0MDl1VUhueHRhQjRpVDJ1b3dlbElTZ0xUT2I1?=
 =?utf-8?B?SW1DOUxscnNidmczeFV3Rk1paVcrT0J3M1d0NWo1T3NiSnQreHJhUThKd3Jh?=
 =?utf-8?B?aloxbHZsNVVYaWd2cEJ3a056QTBURVk0TlFmeFBEQVRMWVYycUdPLzFQUE9y?=
 =?utf-8?B?Q2dJVDQxYmJOb1Nhd1ZOM25CQXBNT3NjOXJvNHlUdE9XUVlzRnBWVjJhcVNu?=
 =?utf-8?B?dzF1ZldNVzZFT1F0NDBid0FnQUtaQVVSbDFtVTlvZ2RNaThiaTl1MlNOcjA5?=
 =?utf-8?B?clVDa3QwSjg5eTdETUFHUWtOQ282UldKVE5FbVE4VU5ZK010WUNwaVA1bUcx?=
 =?utf-8?B?dE1FTURmM0lHdmdIWW96ZXVhbWZwSWlYV3VpcTg5RTk3SVM0QjFKS1h4aUVy?=
 =?utf-8?B?Y0FSRHVwd0ZzYk9NNHdyNW9DYVMyUnBMRDVNcTF0RnFxWFhpWGtZUzl5VWYw?=
 =?utf-8?B?dDJIaUlyOUVjU3VaaEJZaHdoVGdDd3ZnRnpNcUg3NFNCcDVBL3RRNTNpdXNm?=
 =?utf-8?B?amh3ZHlFYzFxWnFqTDQ1ZEdJUVI0WUF2ZVQ1TDBvQlZvcTBIMEFaWm4wcmxD?=
 =?utf-8?B?WDNYbThRU2lCYndacmxpcVNnSEVPM3Axa1pKalJ1dnpXM25QUGM3V1R4dUto?=
 =?utf-8?B?UjV6dW4vNTNHU2oreGVWWE1lZmlYdTM1c0xNUzI4RDF5TWV6T1o0VCtnYXJz?=
 =?utf-8?B?cHd2VUQ2aHM5blpYLzZhNFh5SnRSdUxUWnZIWk8wekIvbEhkQWZ0U2pIV3h2?=
 =?utf-8?B?bk1ZN0loL2VOdm9STWg5eTVBQjVPNmdpOHdMS3QyM2R1RWZkakRkeVVrTExn?=
 =?utf-8?B?MnFVbHdKRGF3TlA3M0hiZ2RZc3JreVhIcTFMWXhkNktFdmFRRmdpWXZoQXRt?=
 =?utf-8?B?Y3pGN3N6VldGdVRESk9qN1JpNU9JRFd0VG9zc245WXZ6K2N0SEVLMWlDaXBy?=
 =?utf-8?B?bEpSWERpdEJUV1NGVU96alZFdXhZK0VsMkMxMDQxTWoranowUys4cTU4UkNB?=
 =?utf-8?B?RVFXa3RUTnJSUHJOSUI4MEZlNHJaeG1TT1dyUzR4K1BXckxHTTQvR1E0bTJZ?=
 =?utf-8?B?QjNRM1BFemt5c1FGdkZwTHU2cWJ0Y3QvWmY5d24wOElWTG4vQ3dPdm5ydVcy?=
 =?utf-8?B?TDlwbXEzMU0zYWhQUnJYeHRWYjdRUmIvREh2YzFsT2p6dUZQbU9DQ01ZZnpM?=
 =?utf-8?B?TGE0TGdNNSsrMmdWdmZTRmZKdGlxRGVmL0R2bmRadjhNQ3ZNdDh4ZEVYVU1N?=
 =?utf-8?B?aHNJbmJIMGdDdG5rRHJVbHhXTXI5NEhsZk5keWIvRG9Xdzh1dUpJREFBUElq?=
 =?utf-8?B?b2x3dGNGbjQxSVExTnNlY1FiaDlvOHlONmxudkZsMGJySXdiZ2pNODRkMXVq?=
 =?utf-8?B?ZndzL0piYisxZWRacHBIaWFZMk1mNnR1Y3ozbG1SMzFRVHI4eFhwa2lWQ3Np?=
 =?utf-8?B?T1l3cG5TNWVjanQ0Nmt0dWhEOXhBY0RZYThiSUh5K2x0bnNiRVZUVjBtV0Nq?=
 =?utf-8?B?VEhzbGt3MzNsTzJmclVCRGY2Y1ZRSFVvbEVoS2lwSzViVjk0Mk9EU1Q2bjls?=
 =?utf-8?B?VmgwRkc2R3BZLytjaTlwRlBrRGlKZXdnZ1dzQVhtYU9maXN2Wm1wdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc997916-d475-4a86-cff8-08df2f891303
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:36:28.7424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss+3C9VL195CJ9rD7M6j0FsT8WFfI4a8gdnElal69nUTBQN/tpq7DY7NNoJsteSVkCs7w6yzc3XXZ+x+g0RtyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
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

On 2026-10-21 05:59, Daniel Huang wrote:
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
> svm_range_map_to_gpu() keeps the same condition as a WARN_ON_ONCE()
> immediately before amdgpu_vm_update_range() walks the page tables. The
> creation-time bounds above make it unreachable, so it asserts that
> invariant rather than checking the caller, and catches a future range
> creation path that forgets to apply the bound.
>
> A process wide minimum makes a GPU with a larger GPUVM unusable above
> the smallest limit in the process, even for ranges only that GPU would
> map. Every SVM capable GMC generation uses a 4-level, 48-bit GPUVM
> except one gfx12 variant, so the minimum is uniform in practice.
>
> Link: https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Daniel Huang <danielhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  4 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 43 +++++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h  |  8 +++++
>   3 files changed, 52 insertions(+), 3 deletions(-)
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
> index cfb428c72686..fa68fc512331 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1504,6 +1504,14 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		return -EINVAL;
>   	}
>   
> +	/* Ranges are bounded when they are created, so this asserts that
> +	 * invariant before amdgpu_vm_update_range() walks the page tables
> +	 * rather than checking the caller.
> +	 */
> +	if (WARN_ON_ONCE(npages && last_start + npages - 1 >=
> +			 kfd_svm_gpu_va_limit_pfn(pdd)))
> +		return -EINVAL;
> +
>   	for (i = offset; i < offset + npages; i++) {
>   		uint64_t gpu_start;
>   		uint64_t gpu_end;
> @@ -2960,6 +2968,15 @@ svm_range *svm_range_create_unregistered_range(struct kfd_node *node,
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
> @@ -3410,9 +3427,18 @@ int svm_range_list_init(struct kfd_process *p)
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
> @@ -3511,6 +3537,17 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
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
