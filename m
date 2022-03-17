Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480ADC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 19:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DBB10E6B6;
	Thu, 17 Mar 2022 19:06:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28D010E6B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 19:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIGi0gCfkzpHhBuPWTXKxoJ7VpulD9GH0R/qAPQTcQ2Xd3/nhwa0ge53tDxRPgKPWKma7Wp9vkLzNXVF8mFVqbYZP7s7tsZCe+zMMwsqboPC8Jd2r+ZDzg+FyKAimyHCC6SGsx+VgKZ9nZW9tjxvC8hXnJpyDpQMQWZKzuJ2DnEeslxYNaGEsJdQn/GltxrJHRdbRn3GUM6bFlgkRW6wsGIDfnaIz4o2RLnoPjMg69hkhdaqzp8uciF9Dn8fsClQZRCGivlDe3CkOuiKA1CrrAEE6B4maw2e3Ag1AIgWpVIrxS9fz+twsRVPLcnULOxrve36sOoLacF0pDyn08Bn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqiHLWzesZAdMGAHm4roGmEUAVu6+XxSqfnob5/CrWw=;
 b=EK4/SHXdOCC6whJOPcgRs6QjE9GEVCC7/KuOxevZ6sIb0SppYg1wYfyByR5HePWhz61QVgXelxLJj8QGuxSLzi9W9y2JENMk7JaSkz51fnYtZ99Arj/wAdsczmNC6z2ZrLknr0oHvg2B7PDwD7d68mS6XtZwTJYyYVEz3vwPxvGEfTQRwn1aM4TZtkPEYxU2Df0WRmEJILre4RdBrSQPrmQCMjwaayS+tA1M6XYloo5S9GFnOfw/oUDdRZJyPc12ww73oJVCIhx+4cozfVT1k4LHi0H4lyL1U7wgdt9JDgn6VZorNKT6ESgSyW4jYowjoOCp6H2/pBbzydDIzuVwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqiHLWzesZAdMGAHm4roGmEUAVu6+XxSqfnob5/CrWw=;
 b=yuVD+U/ED3arX5suSMD8PBew6ms5KAHHOFiKqe41s+XaqPE98h1LTEwXfuRR1GBpeXf3aoOo4SMEzBf6cVZZ02JOlv8MboqLxQk7lgsNUsdVdnCVYUmc/rmBJAsJbtDgnoIP/jiFog7usPwqRdknhLitgcX5WFV3NPYJsufzVNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 19:05:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 19:05:57 +0000
Message-ID: <91e5b1b2-7357-66c3-0fa4-8b76488efb6e@amd.com>
Date: Thu, 17 Mar 2022 15:05:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/7] drm/amdkfd: use tlb_seq from the VM subsystem for SVM
 as well
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220317135044.2099-1-christian.koenig@amd.com>
 <20220317135044.2099-6-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220317135044.2099-6-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2518de8-07db-4c86-e4e0-08da08492b0f
X-MS-TrafficTypeDiagnostic: PH7PR12MB5711:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5711344AB2298EE16369D76192129@PH7PR12MB5711.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVh2f3eZ2JneBKgD31YPd6MorstnkHQr7xNF/e4p2awSfPs3Md1CK48bAB0yJjexoREmmYtXFZC1ic8k8jAxnq/4JLCxcEGQTqHh48jlPpSuffo9zx+4I0VWCMon9uy2DeYEB/j6m6HJdDFFlWUGYvEkvDbUgyoyTYG7GRSD4maPIO8X8WneewjskiOPIkOh3Pc5G+UkrRWGcdvphPpaTDLthgRgg7pQaeUIBui4PdNcqTMdREKtPo1UENvJZLsMHX8ceQAsUCuBqAri1+2EdrpzJGUwp6u9tZfo13NWfYlH020XpWqa2hlKGTyrFMESUFtMrgX+tV/XRah1z83tSrlIKPKPWNats3eCTHSonHnnUAyHUVPp7Uwp2YUlHTX0IJEAczYDkubSzWLM9Oko9DATSf4RorFj77Tb5Rjlz1e5JFOGL9xvx/M9X/47qWmCw/OQeqCKmyvUHzs2VEB498MFhv8WVEef6YfX7CzqIZGXzTVJWwVcf+fIFguH4RyKqbazplItT1VqCT365QFfQZ3cWkTj5FZZjivAdm/UgfjyrFP4RaPHYCGGkdizbd62r0oCjCoRH/F1KYHd9KZzA9bIq9deOPqrSPjHYEcVP0d4ikP0vbG5Ef0QLr6RO0jf9MPAKVAUvCi2PZCf0hj4jtyt6092CukK7oCw91Yi0KVoknJohsLWT1soeDYN0E+MpkHiTzRKsaaLm4Egrbd2pYW5ZO2oj0EODD3z/YK0z5QUAjEmMC/2oCL5iOvbi44/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(8676002)(86362001)(36756003)(5660300002)(38100700002)(4326008)(6512007)(66556008)(66946007)(508600001)(2906002)(316002)(83380400001)(31696002)(8936002)(26005)(186003)(31686004)(2616005)(6506007)(6486002)(66476007)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEtkWm4xTWVNVVJicFNyZlZWSG9TMHdDTXI4c3M1V2w1cXF6TXdKRzB1SFYr?=
 =?utf-8?B?K2ptd2xjQlBoclBDaHphWEVaRjhvTzdmYjNSN3JwMnlPRGhnVjBlOEpVTm1Y?=
 =?utf-8?B?eFNBUE95VExzSExtRWVzYTZkSk9tV0lFcG5VeG5rSGdqb2JYQnl4b1gxaXBn?=
 =?utf-8?B?UXE2emFGQ0lmVDBWR1psdE9DdUhoT3VTZC9iNU8rR1R2enJzU3Uya1ltYUJJ?=
 =?utf-8?B?WDZUaVVaa2MxdnBMbXU0ZC9KN0pFM05abHNBVUFsbkFLVTUybkdhN3lIQjU3?=
 =?utf-8?B?c041SkJpMWozWmNCZkRMV1A5cExhVGM0bWM4R3Npek56UkVDbHUrRlhRTjY3?=
 =?utf-8?B?ZXB6azhSYnA0MmFwZnlPOW84MEVYWFpjeWk0YndoeEwzSkdFOHhtNy9XQ04y?=
 =?utf-8?B?MVl0WWlvZjNjSmJWN3ltTHNVcHlYN0xxWVNtWVJGRWNqN0Q2cTJMM1V4bFI1?=
 =?utf-8?B?YVpYOWVzWTB4TTVwQjBQZ3dIS3RqM2hMNTFQUGV2TE1CK1ZtclVGWkJTNndr?=
 =?utf-8?B?R2NvdGRpR3pxQkc3YStyaHNzbEY2bjd0VWxCb0tXa3d2Qzd6TXdVMXJleitz?=
 =?utf-8?B?cDljRXFaelY3b3dnc1doajk4RGwxZXdPbmpqak01ekdWckFLSFI5QXVPQmt3?=
 =?utf-8?B?TFBUQXROK0JtRHBSbk41Z0dKWGtTSkFKM2QxMTYrc0J3bDFySnFvTlU0WkFn?=
 =?utf-8?B?N2Z3aW5XWWk0enJCMnVNT0xobjQ4RVJraGpaK09TWWVOc2syVXZ2QnhYWUI4?=
 =?utf-8?B?R0NIOWFwK2FxenduUmd5dHlKQ2pHWjdUVjFIRE5ackZYb1U0WTFXZVpRamow?=
 =?utf-8?B?VzdEMTBFTWdTSXYvWWk0L3ZpbVRHT3F5MW5ZTDc2dWs0c0NFb0VPRzRnZWhU?=
 =?utf-8?B?eTA1MkpUMmt4cjR5eWt6aDA3Yjg4N0JMejkxcXpuYjlRcjRqeDhLSFEveUtS?=
 =?utf-8?B?cS9FayttS3A1ZlR3QUxMb0h6a1dwY3dQeFkvUzd6L3ZHQk04U2pjZHVXZElQ?=
 =?utf-8?B?ZXd2T09HM3hZd1I0M1pac2FpK2xSVHBUT3pVbzZ5VjQ4TGNDaUNxc05RazBF?=
 =?utf-8?B?TXJrY3k5bzluckh0QXZMa1NFd1g0cndTR01wUFhTYllmbUpMb3Q1czN6eXlx?=
 =?utf-8?B?VzFsdm43S0srZG1KSXdpdEYzWHo4UE8ycVRtU1ZKa1k5VmJ6eDZPN2dYYkxa?=
 =?utf-8?B?bkY3SUJDL3lFNFh0TXB4T2xRZnlDZis3VVNCdDNKZzFkZHF4Z0ZSNlJsZDNR?=
 =?utf-8?B?cVpJMjJUN21zMnhndDRPRG9KL0FyUXNtV3pMUHd4cEk2MkUvVjhNTkNRMlZL?=
 =?utf-8?B?bE1WZkVkTXhFMUFJZ2tTSWRTdE1iaE9iVnlKMFpGbzZ0b1MxcXVOTlNDV0ZF?=
 =?utf-8?B?ekZMcmhGRGFsU2Nyays5amZ0VnZnUHJxd3gwdHdoTDZVQlNES3ByK1J4cEhP?=
 =?utf-8?B?RmdaMTlVekFuYVZhNi9VK2pra3V1NWVjMDY5NFVJT2piSEtkcGVtMjM0V0gx?=
 =?utf-8?B?WGNtZnN3ZXFiRjQ3Tlp4OU9maS9jRWxWV1lkYUQ2ZGRHZ0dKbXpHaHFnUEJ1?=
 =?utf-8?B?WGt5aTlCSlQ4bEIyd2Y5ZUtpRVorSTM1aG9JUjZRWm5CL2VMdFptUmFyWEFj?=
 =?utf-8?B?bVpuVUQyRk9PU0g5MW1idlZiN1VVelVZd0EzeXZQMGZ3WjF6VXNOenQ0SzBk?=
 =?utf-8?B?TlpQblFyOFVjV0hFUWxaaUVLTlBaOE1xTjRGUko4anh3a0gvOElBRTVJTGZY?=
 =?utf-8?B?NWZUQUVpbmd4amgvb1R4M1c0UU1wZ0NGNFMrTWl4YjFnYXMwdUdnRVAxTWhF?=
 =?utf-8?B?MExNV0lmN0FOK2ptL3NRUXU5STJYTjZBbDNvSUt6ZXpjUTFwdTQ3V0w5bEtS?=
 =?utf-8?B?aGpEbXcvenIzdVRWL29FTGxNeFM0TklKRmM0ZDlQenJOUGdIWjh4cGN0WHlx?=
 =?utf-8?Q?vWglrB6ULPwF4nu5S/3221jwCfPXb9SF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2518de8-07db-4c86-e4e0-08da08492b0f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 19:05:57.5380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhKwMFYxzQV7NEH2SR71QgROGZ1ZyFoT4QFR9PUYTiQCH2cOYIvWSsd3ZKKzQXRiykrW3vR/uWxRdMnENnELwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-03-17 um 09:50 schrieb Christian König:
> Instead of hand rolling the table_freed parameter.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  5 ++---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 18 ++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 19 ++++++++-----------
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
>   4 files changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4cb14c2fe53f..9fcfb5e1b55c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -273,9 +273,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
>   		uint64_t *size);
> -int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
> -		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv,
> -		bool *table_freed);
> +int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device *adev,
> +					  struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem, void *drm_priv);
>   int amdgpu_amdkfd_gpuvm_sync_memory(
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index cd89d2e46852..57b521bb1eec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1093,8 +1093,7 @@ static void unmap_bo_from_gpuvm(struct kgd_mem *mem,
>   
>   static int update_gpuvm_pte(struct kgd_mem *mem,
>   			    struct kfd_mem_attachment *entry,
> -			    struct amdgpu_sync *sync,
> -			    bool *table_freed)
> +			    struct amdgpu_sync *sync)
>   {
>   	struct amdgpu_bo_va *bo_va = entry->bo_va;
>   	struct amdgpu_device *adev = entry->adev;
> @@ -1105,7 +1104,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
>   		return ret;
>   
>   	/* Update the page tables  */
> -	ret = amdgpu_vm_bo_update(adev, bo_va, false, table_freed);
> +	ret = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
>   	if (ret) {
>   		pr_err("amdgpu_vm_bo_update failed\n");
>   		return ret;
> @@ -1117,8 +1116,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
>   static int map_bo_to_gpuvm(struct kgd_mem *mem,
>   			   struct kfd_mem_attachment *entry,
>   			   struct amdgpu_sync *sync,
> -			   bool no_update_pte,
> -			   bool *table_freed)
> +			   bool no_update_pte)
>   {
>   	int ret;
>   
> @@ -1135,7 +1133,7 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>   	if (no_update_pte)
>   		return 0;
>   
> -	ret = update_gpuvm_pte(mem, entry, sync, table_freed);
> +	ret = update_gpuvm_pte(mem, entry, sync);
>   	if (ret) {
>   		pr_err("update_gpuvm_pte() failed\n");
>   		goto update_gpuvm_pte_failed;
> @@ -1745,7 +1743,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   
>   int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   		struct amdgpu_device *adev, struct kgd_mem *mem,
> -		void *drm_priv, bool *table_freed)
> +		void *drm_priv)
>   {
>   	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
>   	int ret;
> @@ -1832,7 +1830,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   			 entry->va, entry->va + bo_size, entry);
>   
>   		ret = map_bo_to_gpuvm(mem, entry, ctx.sync,
> -				      is_invalid_userptr, table_freed);
> +				      is_invalid_userptr);
>   		if (ret) {
>   			pr_err("Failed to map bo to gpuvm\n");
>   			goto out_unreserve;
> @@ -2300,7 +2298,7 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
>   				continue;
>   
>   			kfd_mem_dmaunmap_attachment(mem, attachment);
> -			ret = update_gpuvm_pte(mem, attachment, &sync, NULL);
> +			ret = update_gpuvm_pte(mem, attachment, &sync);
>   			if (ret) {
>   				pr_err("%s: update PTE failed\n", __func__);
>   				/* make sure this gets validated again */
> @@ -2506,7 +2504,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   				continue;
>   
>   			kfd_mem_dmaunmap_attachment(mem, attachment);
> -			ret = update_gpuvm_pte(mem, attachment, &sync_obj, NULL);
> +			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
>   			if (ret) {
>   				pr_debug("Memory eviction: update PTE failed. Try again\n");
>   				goto validate_map_fail;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index e1e2362841f8..91f82a9ccdaf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1146,7 +1146,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   	long err = 0;
>   	int i;
>   	uint32_t *devices_arr = NULL;
> -	bool table_freed = false;
>   
>   	if (!args->n_devices) {
>   		pr_debug("Device IDs array empty\n");
> @@ -1208,7 +1207,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   
>   		err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>   			peer_pdd->dev->adev, (struct kgd_mem *)mem,
> -			peer_pdd->drm_priv, &table_freed);
> +			peer_pdd->drm_priv);
>   		if (err) {
>   			struct pci_dev *pdev = peer_pdd->dev->adev->pdev;
>   
> @@ -1233,13 +1232,11 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   	}
>   
>   	/* Flush TLBs after waiting for the page table updates to complete */
> -	if (table_freed || !kfd_flush_tlb_after_unmap(dev)) {
> -		for (i = 0; i < args->n_devices; i++) {
> -			peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> -			if (WARN_ON_ONCE(!peer_pdd))
> -				continue;
> -			kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
> -		}
> +	for (i = 0; i < args->n_devices; i++) {
> +		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
> +		if (WARN_ON_ONCE(!peer_pdd))
> +			continue;
> +		kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);

My knee-jerk reaction was that you need to check 
!kfd_flush_tlb_after_unmap(dev) somewhere. But I guess in cases where we 
flush after unmap, the sequence number would tell kfd_flush_tlb that no 
flush is needed.

Patches 5-7 are

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Patches 1-4 are

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
   Felix


>   	}
>   	kfree(devices_arr);
>   
> @@ -2203,8 +2200,8 @@ static int criu_restore_bo(struct kfd_process *p,
>   		if (IS_ERR(peer_pdd))
>   			return PTR_ERR(peer_pdd);
>   
> -		ret = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(peer->adev, kgd_mem, peer_pdd->drm_priv,
> -							    NULL);
> +		ret = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(peer->adev, kgd_mem,
> +							    peer_pdd->drm_priv);
>   		if (ret) {
>   			pr_err("Failed to map to gpu %d/%d\n", j, p->n_pdds);
>   			return ret;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 4a8a047b7593..ac8123c1ee8f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -722,7 +722,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
>   		goto err_alloc_mem;
>   
>   	err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(kdev->adev, *mem,
> -			pdd->drm_priv, NULL);
> +			pdd->drm_priv);
>   	if (err)
>   		goto err_map_mem;
>   
