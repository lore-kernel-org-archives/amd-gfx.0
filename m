Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC489CA5FA5
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 07:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8841D10E225;
	Thu,  1 Oct 2026 07:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HHXuVEJe";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6A310E225
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 07:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeQhfV9z+q4zzkghYu24YxNJTbNzYM2AF21TxqVTocop3JBJUvSSAJtsET+t9MM8vStGCZsJEXzum5kumqZNqxvkaSr/nQqtoXrrb9Nl1PWpsoP3liPDpJ7Sr2Fpr+d9qadvG58c88yQs1HPxayWEaIYWt9KIAmvkUGaHKKmhdJaogBWGpupMvW3DwQqXbXqH68gqZ0RrQ2Vj9ptCZGNtA+yFVH86FuQRvZ/NQryBjxq6rEn6q4oW0J373G8wMVHPvbtIYq3He7JJCZ+y5xrHtWiJ5AIbnfzvBA4WPZqB9TPW1GvPZ2JBlXECgzNmByPqh9R7L2C4csOpFiH8U2bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaUlpbzbGTx2QjDfg68tA2l9s3R2e7O2+P9OGNhNwwY=;
 b=q5EbcEqGA13nOaahJfshjAMMxtv7y/A8ikN6b98Ctva1pr8zS63wzQszm682c2wNbHlayDthksj2lmtkwtWOz9E43ZbjYk43X8o1T1E4rp9x2EmIGKAm8tS6FPahGk++qms3xRrSDMGBMVkNFJvfrSneWLz7n7IF5DNo6mCbFcF0VdIE5TTVn2rg5LkBarwnvjwoGXREkH9bS2VQV2ObZGi+Nnxx17kDxLmu9ltMFh61GZlDRK8ZUNvPA38WDaehj5SuLOXavul+s9pwAaPolANLzJ0URxGZ9qT1W96Ke9QwP63xKxmdjQ+Vv7VPCXplBr+QYghDADU3R1NIsK23Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaUlpbzbGTx2QjDfg68tA2l9s3R2e7O2+P9OGNhNwwY=;
 b=HHXuVEJe/+fZB9/VEktcKKPVu1/dXwMta+OEEBiypDAVWV57OygFjj1EzLEHbpKLAJ/GMVyqh8wvoPP0RkZPReNKX/NtPyh1kj5uJrLOqbVyh8JgBMkfQ9CqrrA2+f+KyJR+A3PyBcwi7mPofYMD8Nv5tLpG16G5tkVAqBeF7iU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 07:50:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 07:50:48 +0000
Message-ID: <34a4abfe-2971-4a51-9fb0-265dfb369f73@amd.com>
Date: Thu, 1 Oct 2026 09:50:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add amdgpu_vmid_uq_mask_init() helper
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930144341.66352-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930144341.66352-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d4f0dc-7aee-47d7-e751-08df1f90b523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: eFEr/669N1aZsoEWVNapgOjxw9VeuWLjQ1lUfuyivlURACI2f6067+6xIEwDInMyMok/d+tmssAaSYHMQuvLLBFhdm49XHXU+jte7pIr4wdd31qoA+R+VhMPUxt/mDX2OgNWGI/ks54UKr0PJIPfDOoXReHghsoSt/jo2xG0YsEhRIGKOPv2gPTNTO6ugxvyfOE+MNbjPW0wJzFeYUWKZhmlkMuKHZstFwpa+WBKYFxAYL2Z+JciUckgKhZ4tbvqYS51TGRItQZnWmRT0mVm0z8AfFCNF3fzb7YBjMAo52hSaLGtjlBFgdiqoaUYWZYDqEg34ddjSCZLkRE+1wmgXAXi6Aa/spgw3HTcOUp2OcczaNOlLbXTHsYmpZbW22sHz3H1YaRzprveluZneyDtKp1dbZD4uwejj1IZUyJo/gvWnMV4aQ4vUI4EZbS2LyaBYAu91DJkQnWFpc+6r3tpDvdspaeO/8Rex1OUbxoMw8ueRJb9V1tpxSss7+8euP+5pz6qwmfZy0yMW2Oy5vLAZ+wVcYB4pJPi21r2HLuoTRMkbm70YR0nIMIIUHiwyI8GEOFFl0SUiLswKS15SPT4tdpPXf7RfEsOIaro3FcGHIwjv+UvLjnRuYyC1/KgTG90HzAhIGCdtDuVmTNzlRTsVhWimsQfS8A4lFqVDA6HISI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnBDaFlCcmlkdUpxaXVCZHB1cENhVmlESlFnNnVTQWU4SjRVS2J5VnJFVEJo?=
 =?utf-8?B?elFJSWZwUEtrR2JWeW1PaE5MdlRqNE54M090d3pPSlBrQTdyMEpJZFVLZ1hw?=
 =?utf-8?B?UHNsZ1BNMk4vcjR6ZnVGblFucE1YenJNU2w4U1JLYjNPL1RRbVhLNGRpNGlK?=
 =?utf-8?B?aXVNUVk3UWZXZHZ2d2JLUXFUMjlHbDBzN3MycExtekpUWXRyakl1T2s4QTdV?=
 =?utf-8?B?cEJWdERJaDl3b3k2b2loMmtQcnVKMVc5RnM3STZONkF3TUJCTE1YbFE2MGdm?=
 =?utf-8?B?a0tjb2p0RytoM0JJd09QdXh1NmFRcGJLRmtieUVQQXhXU0orQ01ZMTJpTU0y?=
 =?utf-8?B?QjFZUjVYeVB3Z1I1Q0IraStEQjJ2N2VWKzV1NGxhcmJ1RmxkRDNSd2lOQzBB?=
 =?utf-8?B?L1dVT0o5RExQbkM4TmdUYmY3MjZDRkpvaHBTcG9aNEpHNnFSbjU0QU9ESnpl?=
 =?utf-8?B?dlpJU25iT1ZOZXBEYjJxVHNZNmVPSndVMi91aU1YekxGUUVLUWIxanNqaEh0?=
 =?utf-8?B?aVdMN09sUnErNHhFWGdMdE5GQkJydEZXQmt6SGhuU2pwazhUWThqZmM3YVZt?=
 =?utf-8?B?emdFTzhpZThOaXFxekFIaDZvY0pNVkZ1dFFBRWFFWUw0V0wxSXpWL1M5YVI3?=
 =?utf-8?B?dWM1RWppN0pvRE8yWThxS0UxS0J3cFpqTEVhc1JJRW1VU3B2S2JsMnRrQ2RH?=
 =?utf-8?B?bGpwYitmUHl1Q3NsYXVlcmlYR096Y2x0QzZVRzRWNkZNRzJJTkJhYTNERWZo?=
 =?utf-8?B?bnNlaEh3cTg2UnJHL2NKMytuYXFzWklwbHp4RWlyNFQ1MlpyR3Mwc2ZPODkx?=
 =?utf-8?B?eGJMRlU5NTZydDFwWXhtUGcvc2hBZngxTGFkRlBsTytwUHZRcVI4ODMzMEh2?=
 =?utf-8?B?NU5LNE8vQTU3SlRuaDFJdjE3UWxlUFUrVlhpdCtGQ0dKT0tQSFVNYnZ4UnJ0?=
 =?utf-8?B?MkExRjl4TjRKeUpPRm1vcThTM1laV3VVeDBlWEpiRXFlbFhtNlcrMXVVVk8w?=
 =?utf-8?B?K3JuVDI0M0hjbStHdGpjdERhNSs5RHY1UFA2TkFWeHdrdnhRQWErdjY1amRI?=
 =?utf-8?B?YkV2OUlnTFRrUnZicWwxV3p3aUUxQU1tdGZ3MEpTZWJ2TUV1V2oyZjd5dmhz?=
 =?utf-8?B?RDk1LzgwakNGdDlpc1pLdCtURGNieS9jN3lwaldZMGllMzZDRGdkZEtGZHNV?=
 =?utf-8?B?aS9BY3ZCVWtzWSsyVldjYTRRTmhXWE1tWndlcSttK21yQkZsZkpiLzUybEhu?=
 =?utf-8?B?MTdBNWtBdGY1ajVPditWeEZxRDMrNWtnUkxIam55bDdJV3RqUW1JVm5sbGhh?=
 =?utf-8?B?YzJDNmFRMzFMR2FZL3ZhYXBMSHowN293alJpVDFPMEZMMFdoWXh1ejdsOWFW?=
 =?utf-8?B?SHptMWxuNXFBMlJaanI0dXkvWE8rVFFOWHFxckFEcHhpcjJRbDIvMUxCT2kz?=
 =?utf-8?B?ejNsNUFoalFSdm91dTBqeHFYdXpuZnRqeWI4K3AzNU9vdjB1bnh5cVJTenVO?=
 =?utf-8?B?U0dOQkw3L1FPdVIzSjhza0dvOFpGaEZ0N3hsaUMzU0gvd2FFdlY4TlpmYi82?=
 =?utf-8?B?ZnVBVm5YTWExYXNadmVJUmlEV0FxQ1hCdUZVT3RJVVFZYklobG4rS0dkV05X?=
 =?utf-8?B?MWJyT1lTZ2Zmb09Rb3AzeXo5QUw2VzQrdHhMMGpCblAzWmxLZXd0UllVMmxS?=
 =?utf-8?B?SXJRSGYrMWxZTFZ0MXREZ2U0RlFtUzVtenZqYWdBcTdVZTk2SDB6WXdDNzFn?=
 =?utf-8?B?WlZweUM5SEp0T1RLT0hCeWM1OHlKSkxFOUhvQTcvbWRGSkVyOXFQUVBaSHZs?=
 =?utf-8?B?UWVJVFFNK0FNR2t2MVhtZXpLaHcyaWo0NUJFZVNQdFp0alduSy9RUGFGa0tD?=
 =?utf-8?B?MmVPQW9YR2RjT2xRS0NYTFdJMUhXSWIwdEY5NjM2ZHE1RmVzVmdKUVp4SVAr?=
 =?utf-8?B?RVpUbk1qNzl3bHZpc0NFOHBTWlRhZ1BMRWo2VC9ZMHVQSHU1ZTBJVS9tWEhD?=
 =?utf-8?B?ZEJ6M0ZHdW9qT3FaeUI1dU41bE1tU0JKZHYyT2pXc3plKytNV2FNS3FucVBi?=
 =?utf-8?B?S1hIV0pZMkZtT1FvOERnSmorTWxUZ2F3SWxmaDlmem1BSVl5Wk00NFZ2Nmty?=
 =?utf-8?B?NG5sOGFXVCtIU1o4Ulg5eDQ0S2lzQWN3bzdoZ0JpN05WQjMxS09DVU96Mzhq?=
 =?utf-8?B?a3NNQlRYMGhodG9MaituKzdJeGRLOEhCbUJGUjV1S3lEWTRpb3EvRDJIYzQy?=
 =?utf-8?B?cXBFYmg0S01nQm16dkp0ekR1ZWdKa25BNTZUcU0wa2JNSHl6U3hrQTNKbkRV?=
 =?utf-8?Q?VQ+WEOp5Nl1EzjBkXC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d4f0dc-7aee-47d7-e751-08df1f90b523
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:50:48.6324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgMph+yebOiGUPOEt2k6ZUfHrfscq7afGwI0SR70XnBYnq1s1SBpSJAqrHN82zEQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

On 9/30/26 16:43, Sunil Khatri wrote:
> Move the duplicated VMID-mask-above-first_kfd_vmid computation out of
> amdgpu_mes.c and amdgpu_amdkfd.c into a shared helper, called once
> from amdgpu_vmid_mgr_init() to set vm_manager.vmid_uq_mask_gfxhub/mmhub.
> MES and KFD now just read those fields instead of each computing them.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  7 -------
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index afcfb92fb9f5f..c59a8f99ecdf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -178,9 +178,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>  
>  	if (adev->kfd.dev) {
>  		struct kgd2kfd_shared_resources gpu_resources = {
> -			.compute_vmid_bitmap =
> -				((1 << AMDGPU_NUM_VMID) - 1) -
> -				((1 << adev->vm_manager.first_kfd_vmid) - 1),
> +			.compute_vmid_bitmap = adev->vm_manager.vmid_uq_mask_gfxhub,
>  			.num_pipe_per_mec = adev->gfx.mec.num_pipe_per_mec,
>  			.num_queue_per_pipe = adev->gfx.mec.num_queue_per_pipe,
>  			.gpuvm_size = min(adev->vm_manager.max_pfn
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index f8bda01f3bca2..c4c1b2d1e3cd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -646,6 +646,22 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>  	}
>  }
>  
> +/**
> + * amdgpu_vmid_uq_mask_init - init the user queue VMID masks
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
> + * first_kfd_vmid, shared by KFD and MES user queues.
> + */
> +static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
> +{
> +	adev->vm_manager.vmid_uq_mask_gfxhub =
> +		((1U << AMDGPU_NUM_VMID) - 1) &
> +		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
> +	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> +}
> +
>  /**
>   * amdgpu_vmid_mgr_init - init the VMID manager
>   *
> @@ -657,6 +673,8 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>  {
>  	unsigned i, j;
>  
> +	amdgpu_vmid_uq_mask_init(adev);
> +
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
>  		struct amdgpu_vmid_mgr *id_mgr =
>  			&adev->vm_manager.id_mgr[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index d1e956cf8e5b8..8d813c68450bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -111,7 +111,6 @@ static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work)
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
>  	int i, r, num_pipes, num_queues = 0;
> -	u32 total_vmid_mask, reserved_vmid_mask;
>  	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
>  	u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_per_me,
>  				adev->gfx.me.num_queue_per_pipe,
> @@ -134,12 +133,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	atomic_set(&adev->mes.userq_hw_queue_count, 0);
>  	INIT_DELAYED_WORK(&adev->mes.userq_notify_unmap_work,
>  			  amdgpu_mes_userq_notify_unmap_work_handler);
> -	total_vmid_mask = (u32)((1UL << 16) - 1);
> -	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
> -
> -	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
> -	adev->vm_manager.vmid_uq_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
> -
>  	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>  	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>  		dev_warn(adev->dev, "more gfx pipes than supported by MES! (%d vs %d)\n",

