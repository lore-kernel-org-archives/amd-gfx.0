Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F13606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jno8MLe4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB70A10E27C;
	Tue, 20 Oct 2026 18:30:44 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7C010E27C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 18:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTziWdvGvl9KiTy5XmH8eXRYayg5pnJBsmoHPENDw1PxL1aiG1R11OTm8Hf23L/ud+KQsEMQ1ukVsKGDSR/v9lez5h0wD5rPTKMeY8ytakeYWudIO/kY7KDO5zr6KvIbfBiB58R7jY92XsIUhy+4ISk1M0DgFS+MM2/H9iRz7XJibvKLWDWYGp0ulGbRUAyn0YNRrcOae9kvWBdd4QpcPtT6JbvauN/KHE8G0tshyqNxZsMktRfsWKBzeGCaYXKb074rLhLHSjMTER3hGT4DtBMv+Yo2hOet/nKvNdQjgYRdwGTinkEEMalYvCTBfZ/cuF/vBwT0PFmxe7ppDCdiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czQ48sebf5uDSlgsinTZ2QRjFg/+6gWvoFKuRh9TKj4=;
 b=K+BBYHSwKEeAJiZiO1QGGJDhjz5C/p6RLtHDYuwlFiT1fGzFaTB/duPWJl6/Z89SN+ppKDawJOKw6sC7HYRnGmBYOGGpiXSD5rLhhVCHe8LPBgn2F7yl2cC0KzYpiKvI3ykwIlhKm0tiEp8aagUADzHD3qeVtb++ak/mvQlkK/SI4iAqwnY2vveq/5e5H+r4nH3cQieSBKGLxGDh0rmOLo8OJCefnK0LzsF8dqdrWi6syFs+5tDCz1whk+UWZhK6b7Ie92tSbEvwc5QBeBSVbiRtOfIw++Ya7UxmTYUewVStiMMKs8M9ZZ70OfbjcxXcO33PZmfpIt5aEAMTYvZevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czQ48sebf5uDSlgsinTZ2QRjFg/+6gWvoFKuRh9TKj4=;
 b=jno8MLe4gQrztm5aBQ06mgPfYmZSF9cUFU2urjjmCY1KR5DkhcBCU+RRhMxCDXQUzo0zM/TkyP+wBtYqi5bbnR2uBwgVj8P8r5O0VriLaQuEtYc6eb9dNbQ9yYQiGuZEuqrnAvktPU3EAqUyacdXRWkqP8+qQbKDSs9PmzzypAI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by PH7PR12MB7306.namprd12.prod.outlook.com
 (2603:10b6:510:20a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 18:30:35 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:30:35 +0000
Message-ID: <d676a99f-4004-41c7-899b-aa65fc197ac2@amd.com>
Date: Tue, 20 Oct 2026 14:30:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdkfd: disable SVM when the GPUVM cannot
 cover CPU addresses
To: Daniel Huang <danielhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20261020132901.23157-1-danielhu@amd.com>
 <20261020132901.23157-2-danielhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261020132901.23157-2-danielhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0192.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::35) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: e38cff56-9e9c-4ca5-7bcf-08df2ed83af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: shGeMeUIt0HLihIE8Jki0d7BiurSpZyIo9efHTxM6Q/kf6d/9t8QVo4B5RGKHCcFub4L12QD5FH4mu5UUNoQdyL1XWBpRdv6Lwmflz5AF8VirqyOQQB8qA6L6bofrHHaBAQNC+oHO3u6ux681uQsuj7neF1c3lOxKsHKS5Uo+NKYrmBvosuiHIg3ABkmCuKc1+KBYz19hxfMC8Pz/OQHkiXgoWEhzUMAJcEgceVSgS9FmtI2eqD+fR0pa34AuegI3arEPI/1cgCy+BK5GF2qLtM2lowJCFgnOMZuzHML5cZx5vFaIu51A/CuG0kbBzAPsmvGXgPu/cOJZcYILoyhf52nY0QoUxteXpAH8csawdW7/f81toirKH6UjlMZ6z1vsQ8L7aQxVmaCnAbsciEEttXoU6Msqkbx9E3v7I5vVbsDhTNe5o7RkD2BEjlh+D4QJlzBf7SlP9GGtR2DZL7d2cHTE9RmN28SPu6BNAZT5+O1Y8F1KfrsG8GEzS3Hly33IwrMM6Bhq29MBuSONy1OKsg8WB9Dm1VkUdUcw3X2dj7uadmlLM2VPz4ktYf7G2aymHw8icQtXzGzPx18Su8Tqpf6BEws5R3U3Mtl52LQ2xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHRVTFcyQ2pyS2QzL3BtNjBBQlRTZ24ybVNwTHlQNm80UDZOUnBXZjV3QzM2?=
 =?utf-8?B?cXVPZzBYR29XSkRhL2RpK3JTUWpEcGpNa0FicTI1RnpiNks4L0wyRW5XQTVC?=
 =?utf-8?B?ejIxbENMVmhsbHdBY1ZWa2I2d1Z2cUtlV1o3MmFNTlNFM1pFSG96bDdORE1r?=
 =?utf-8?B?WkNrUVF2WU1yajcraStBN1E3S1I4Yi9xTVFZeVVwYUcrT2U2WlVxaE03am8y?=
 =?utf-8?B?Qk92WFlSQWQ4aFhzbnE1ZWdEb053Z0d1eDFsc01hTkZ6TkdxeDJzbmtyajdk?=
 =?utf-8?B?TnNxYkJ4SUlZZmVoNklZaExJb1hNRFRHdkoyb2R4K1JlOXp0KzFOanJJYjFx?=
 =?utf-8?B?cTFwYkY1QlZxbVNmZU9hVjJod0lNQ3NhS3Fvai90K1pURE5EVkNNb3VDOVRi?=
 =?utf-8?B?SkU5M2orR2Z0dTNCeUF6ZExZVGR3RjVxSjRSeUozU3BpWGxJcjdXQnBPQ0tw?=
 =?utf-8?B?RU1nWFJLYzlIcW0yRnZ5RUJ0dmxOSU5NcFAzbzlxZmtyT3hQZTZJd2k2Zy9o?=
 =?utf-8?B?RWFNRmZUZkx6am1ZeDlLdkNXSVROdUI3UGtscWx0VnJJTS9BVlFrUG9PbDc3?=
 =?utf-8?B?cm9RVFZYWFBQbTRESkdKS1QwbVNuc3RvSHpRbUZHdEtQMXU3eWdMT3NDMEdP?=
 =?utf-8?B?ME5KUnRBL3FYWERjS0ZYK0VMa3RjYXBqNy9uM2o2c0NGOE5oWlZKaU9XOXZS?=
 =?utf-8?B?SVNnVkFKVkxRYVdPOGhEWHRYaFJNV3BSd3hQUVhRR1lyQnFiMnpEQitEUlZh?=
 =?utf-8?B?VWtUTHJhWUZxMVNGT3pkY09mdHdSc1F0MGU0L0pnNFkrdTJBZXBtNFBZU2dl?=
 =?utf-8?B?aklZNWtYd0p5Zm5senF6cG1ta1FJeElGTUdyYkYwc2YxMGhyeW1HdWtoS2Zs?=
 =?utf-8?B?M2pVb0RmYTNSQlhCTU1FUERybkljeHBaY3ozck9UZFZsL2xmVC9Mc1Vyeml2?=
 =?utf-8?B?SG51ZW1OWHhkYUQ1MDdaWi9nWjR1QnlFWHYvL3gvajIyL3dseXJpMTh5bXo3?=
 =?utf-8?B?VWlDRkFzUkR6akUxYzFOTmFsUUhRYjBKaVBLZC9iVC8vWFRIYUxIS2RUeEZH?=
 =?utf-8?B?NHJqNmVGcGllYTEwMThmdXF6SElJVjhlWnhLUUMvV2FOcTRDaXkxVkFOTm5Z?=
 =?utf-8?B?K3FueU1QQU00SS96bjZsbm1vWEhUNmZnd2Rmd0Zud3U0VWJWTWFrTWFPWWI1?=
 =?utf-8?B?a3c3aVN6VnlNL1RzSEdEbm5id3N1cHU3S1dwZkJOMzhUaHFWTUxwN0djQldh?=
 =?utf-8?B?Wm41ZU5TUU9Xd1Zha2hGUVlrN20rQU5yU0RSMkVFOGo0ZllnMG9LWXVFSTJv?=
 =?utf-8?B?aGVwUzE4U3Y2QUhsM2htQ3FMVGxCdDE4MUFsK0hrOUFHanRuR2xHbkZ1OGZ6?=
 =?utf-8?B?UHFqbnVhTGdSQjBxSDBRTG1zMlBqQkRQY1l0MW9xbFdSTEFRcG83UElTa3Ri?=
 =?utf-8?B?MkZVMTBkOHltQ0Q5bDdTanFWcmRRWS9GRlgvSTBxR3liMnhaVGpuU0wxbS9V?=
 =?utf-8?B?ZzZ0V3UreFB1RlBoYm02YmlUUGdEZE5hdHNrbVB4WkpNcTBjSmJFSGhVLzdr?=
 =?utf-8?B?Vkt4dGQ2MERBVTJEZE11dUQyTjJGYTJjSVVPUEFRU3ppcmxzRkdPdmRmbkxn?=
 =?utf-8?B?TkNzNjFZS3ZRaGtvWVl4aFFXWnB1QUlHWWdBTno4TlRWdmFpWklBYXZRZkRT?=
 =?utf-8?B?M3IxOWpXYjU1ckdyQXhyQWZLalNqYmsxYm5yWHU2U3p6WVBFQ1I3M1MrMUJX?=
 =?utf-8?B?REpheEF0Z20rOGYzbFJsVHY2ejE0YVNLeU8xNWFaTUtOSlFZUm5KS1grUmNN?=
 =?utf-8?B?V2xMRVVyWFdwU1dQMmpuQlZqelNZcUJ6NHVpOFczNVBNazIxbDgzdDB2empD?=
 =?utf-8?B?czcvUkhRVTFpeWpCb2ptRmJKUzE2YWY5bWpWbVFlVnhJb3p3d0NiRGl2QkFv?=
 =?utf-8?B?a2JrSkZpLzFDeXhqV2trRE1mOTFjRjBRbGxOY1Vvdi9ueFZjeDBMdFZYOWRL?=
 =?utf-8?B?N2x4dnIwYnkrM3NxcDd5czlBNGtSeWc0aDlDajBJekI4eE1JK2w3R2F3Tndh?=
 =?utf-8?B?andZNW13MFVOZmxrd21RN1Z2NittbTU1SEVOa2ljMDR4TllLd1N3b1VzTjAv?=
 =?utf-8?B?Q1VkYm00eWttdVMrU1ZyL1BJaGRuU1BxalpRREhDOExaYWxXQ0dFSTlScTZ5?=
 =?utf-8?B?RWpOSXkyb1BiYWg2RHVGUXp3R0ZNTWF1SGJFSm1LQkNtSG54OTNTQ2JiSEtj?=
 =?utf-8?B?UmJ5Y1pLbWtYOFhMdkt6cjZzR1V5OFJNcmtZSDNnSXRYaXNyVldSV1FoTXVi?=
 =?utf-8?B?MEhjdk55M0o0eFdMblNVTHNmUi9Qby9MYVhoS3dYczhld0Znbi9FZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38cff56-9e9c-4ca5-7bcf-08df2ed83af2
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:30:34.9033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8qmaZRNdhOzUwN9ivd3dqPzN3dvOVaO5HGkS4JHjvIs9/wGhjV6mpL/8/G0YCkvorWvUOvYksIVSDOB4UXJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
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
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 09:29, Daniel Huang wrote:
> KFD SVM maps memory in GPUVM at the same virtual address used by
> the CPU. However, svm_range_map_to_gpu() passes the corresponding
> PFNs to amdgpu_vm_update_range() without checking them against
> vm_manager.max_pfn.
>
> If the GPUVM address range is smaller than the CPU address range,
> the page-table walker can index beyond the allocated root page-table
> entries. Unlike the SVM path, the BO mapping path validates the
> address range through amdgpu_vm_verify_parameters().
>
> Only an explicit amdgpu.vm_size override configures a GPUVM smaller
> than the driver would select on its own, and that parameter is meant
> for driver testing rather than normal end-user configuration.
>
> Reproduced on a Radeon 780M (gfx1103) with amdgpu.vm_size=64.
> Repeated hipMallocManaged() allocations attempted to map CPU
> address 0x74bd48000000, well beyond the 64 GiB GPUVM limit.
> The out-of-bounds root entry contained SLUB poison with
> slub_debug=FZPU and recycled heap data without it, resulting in
> a general protection fault:
>
>    RIP: 0010:amdgpu_vm_cpu_update+0x2f/0x140 [amdgpu]
>     amdgpu_vm_pte_update_flags+0xfa/0x1e0 [amdgpu]
>     amdgpu_vm_ptes_update+0x38b/0xa00 [amdgpu]
>     amdgpu_vm_update_range+0x279/0x930 [amdgpu]
>     svm_range_map_to_gpu+0x13d/0x400 [amdgpu]
>     svm_range_validate_and_map+0x8d3/0xaa0 [amdgpu]
>     svm_ioctl+0x66/0x80 [amdgpu]
>     kfd_ioctl+0x40a/0x650 [amdgpu]
>
> As discussed in [1], rejecting out-of-range PFNs in
> amdgpu_vm_update_range() is too late. SVM must not be initialized
> when the GPUVM cannot represent the required CPU addresses.
>
> Prevent this by disabling KFD SVM support when the GPUVM address
> range is smaller than AMDGPU_GMC_HOLE_START. This prevents
> affected devices from advertising SVM support and excludes them
> from SVM mappings. Warn from kfd_update_svm_support_properties(),
> which runs after the device memory pgmap is registered, so that
> only devices that would otherwise have advertised SVM report the
> loss of the capability.
>
> KFD SVM has never been supported before GFXv9: kgd2kfd_init_zone_device()
> returns early for GC IP versions below 9.0.1, leaving kfd.pgmap.type at
> zero, so KFD_IS_SVM_API_SUPPORTED() is already false and
> HSA_CAP_SVMAPI_SUPPORTED is never advertised on GMC v6/v7/v8. The new
> condition therefore cannot change behaviour on those generations.
>
> The BO and userptr paths are unaffected. Their GPU virtual address is
> chosen by user space independently of the CPU address and validated by
> amdgpu_vm_verify_parameters() in amdgpu_vm_bo_map(), so an out of range
> address is rejected at map time instead of reaching the page tables.
> SVM is the only path whose address is dictated by the CPU mapping.
>
> [1] https://lore.kernel.org/amd-gfx/da43b0e3-5bd9-4aa1-86d3-b733f3bad108@amd.com/
>
> Closes: https://github.com/ROCm/TheRock/issues/9302
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Daniel Huang <danielhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 15 +++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 ++++++++++-
>   2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index c7d7adae4476..f61030408f45 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -203,11 +203,22 @@ struct kfd_process_device *
>   svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
>   void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
>   
> +/* SVM uses CPU virtual addresses for GPU mappings. Disable SVM if the GPUVM
> + * address range cannot cover the required CPU address range. The parameter
> + * must be named adev, AMDGPU_GMC_HOLE_START dereferences it.
> + */
> +static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
> +{
> +	return (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) >=
> +		AMDGPU_GMC_HOLE_START;
> +}
> +
>   /* SVM API and HMM page migration work together, device memory type
>    * is initialized to not 0 when page migration register device memory.
>    */
> -#define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
> -					((adev)->apu_prefer_gtt))
> +#define KFD_IS_SVM_API_SUPPORTED(adev)					\
> +	(((adev)->kfd.pgmap.type != 0 || (adev)->apu_prefer_gtt) &&	\
> +	 kfd_svm_vm_covers_user_va(adev))
>   
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 35b3abe57b80..5d12446b8ea8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2471,8 +2471,17 @@ void kfd_update_svm_support_properties(struct amdgpu_device *adev)
>   				sys_props.generation_count++;
>   			else
>   				dev_err(adev->dev, "Failed to update SVM support properties. ret=%d\n", ret);
> -		} else
> +		} else {
> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +			if ((adev->kfd.pgmap.type || adev->apu_prefer_gtt) &&
> +			    !kfd_svm_vm_covers_user_va(adev))
> +				dev_warn_once(adev->dev,
> +					      "GPUVM size 0x%llx is too small for KFD SVM; SVM disabled (amdgpu.vm_size=%d)\n",
> +					      adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
> +					      amdgpu_vm_size);
> +#endif
>   			dev->node_props.capability &= ~HSA_CAP_SVMAPI_SUPPORTED;
> +		}
>   	}
>   	up_write(&topology_lock);
>   }
