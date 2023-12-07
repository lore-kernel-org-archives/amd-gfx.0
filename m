Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCE9C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F89610E067;
	Thu,  7 Dec 2023 19:14:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99CB10E067
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 19:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyoq64ry6zqvxymiA2i4T1mWvfwrTXOlJq9C1GGNSnlctIHkkSxcbKLPq3JfIFf1ly62Bb3W1iIndqqMf6hs0x5SOaWcw8F9XoIDzn3sCQg07/Djq5oQrSeu1hbkdsk4mWJtKezls0yW+8NhDtoVFa9pF0Xqf5Ia69FiEMiRwio2a8UlxN7TX0U0TtKRTEYysf/12SckyhMCSAYH9r/hlIw3k/h1Q9HVflZaOSG05t/YkTc5FKJUevdrGEdeoSufE0dfNTD2+sQyiqz6/RpgIixu4fHB6jxRn291iZAzxsqr1sIhxR4SPWX2DfXhJbj7aEYh8nnYMOfGd1nBryiPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh17j/zBtH/tgkVCYG90iRvMJpFdeZNNM0wMzfX9Gb0=;
 b=Xz9KTDwPa2LNAkfHRKP0YNUVWmuEGNTKZry6jbi8PmkvJcT1T62VXiu+eIowOukGsU7paZNyiS2sfjP77LiMcL2Zkmk2r2zO+EdF7sDYq1x+4UYRLisoeTkqhb+9tQdBNWq2tIlsKNpVoZ/qoaRJNudFmT6FCaiDq80ct2Arj/7irp5oQi8V5GEeOSxoEbhHPmvLcgIlMQKzHsuMs3Epfk5a2NRWBwf66YDH4nU9SAePtXUWUbfbCX9LvQ2NEToL8oSMynti7joBppHn00wmbWMb9U7kuMWSKTiuCB9D/Y1sE/SPwtWoJgpMqNJM5hHNMbrKgv7bGmpOnUa/5YYwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh17j/zBtH/tgkVCYG90iRvMJpFdeZNNM0wMzfX9Gb0=;
 b=LMLG3ExxQP+QdV6pJYpYixUUe4khb61Y7k4aSRi2geGyLs25VbWw0gi3X1DJyCPf+av4G/5kZw5ggSqLLDg6ntCisf3PsnAGfQ3KvwykENJV86u6DF0AH1TnFoon6L1fpJZ02bJlMqAjtlGRkw8afP6eX+iEpyYFBpm+9ypHIag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:14:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 19:14:38 +0000
Message-ID: <e879ea47-4281-4830-a4db-5a144999198a@amd.com>
Date: Thu, 7 Dec 2023 14:14:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix sparse __rcu annotation warnings
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <20231205222026.2108094-1-Felix.Kuehling@amd.com>
Content-Language: en-US
Organization: AMD Inc.
In-Reply-To: <20231205222026.2108094-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a51a20d-2203-4222-189f-08dbf758c1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3JNhV9Js4k2xmgnDvQCNHN+vEB40edHt8NEGq6RM0ggBajTiKq7Jqxw9eWyPXxMR/KJNbF2L19VPjB2mnrsSw+rJNPDaXqOPBCn2ua0tTu0mmC8OKywBsP7xbli72r55vWM+OafEJZ8uNMeTU1fGiRoX7ZDv/4/racq4GH2+jaYU1aXkmkegu611k2b4zyICNXFtxIgDStCDSHCbWSz1Kj8FS7DCOy/xm0pNRGT1O/7JoNLOitSjTXB/3rWnEFXBul+WT5GXwi1bEQbEjDu16LYoSOD/bbjeMUjgR4X8iD4PE7h6AEiMdLZCKvDLJ5byfUqZZr8rzDPR3dCjopY81p5UuolAizvv8ptjQaD+1oF/N4iFEQLlak40DljF/N8vK+B5VDDPljaT4R7kepu8VHcDLsb4znncNCdsQEV3U88BEV9GbSrygmMnjMXjIK0zd3DP1EWNT2gOYKqnPpqb1bRLgrJT8rCB+7RbMzlQ7tbGPtGxkBbgZzmtgs9XUPdi/6SH3Z5yvwa61uF7Ke9/zBTh3Pcm3NfmsRmNvCqhuw1/h59SeVxh8kQDBUBc7WYa8q/9+EMywxPegNiMPwvpayIMSA9qaVeNzWsV0y03YVU2uhkGA7ewdnXRBG+rarBue+AumlkFdmHRStgtSn7yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66556008)(6636002)(37006003)(66946007)(316002)(66476007)(38100700002)(2906002)(31696002)(41300700001)(5660300002)(36756003)(4326008)(86362001)(8936002)(8676002)(44832011)(26005)(36916002)(6506007)(53546011)(6862004)(83380400001)(2616005)(478600001)(6512007)(6486002)(966005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWpXR1ZVclJQazVVbnozaDl4a2EvdGVnRHkzNkZkczk1K2FwZU02L2IzZy9R?=
 =?utf-8?B?eExYTmpTbXYxM1lJR09MQzh4UTh0R1IzaERNV1FtcmpNU2VEVWRFVndzVGNr?=
 =?utf-8?B?Ulh5NHNpVXk3eHFJVGh6NTAreXc2T0R2MkxEOGxrR1VGRDRpa3JORTZhV3U1?=
 =?utf-8?B?N1JpMGVmOEFmaW9OOUUwYkVHNHd2Wk1EMUZ3YTlLWWFWWkFnSFNpME9IVlBJ?=
 =?utf-8?B?NTBMR2t1dGlCYmFLZUV2VHdVZEYwbmQ1dyt3Y2pNNjhIelZlTllJN2VYVnJP?=
 =?utf-8?B?amwyWEt3Qk9nUm5vNGZaV0hQQTFoTkFEVTNJQi9kVk1LeCs3L2laSFVCTDU2?=
 =?utf-8?B?U3g5WjZzLzE3ZU1CcVVtWEdjTEQ0bzVEVVhaN3J6Z2dOT203YWpWcGZ3YUxy?=
 =?utf-8?B?OUovVFJ3T3hxbUduVnp1WE92VStHb1dFS3NnYWtsenlhSnY3azVmYW53dDBs?=
 =?utf-8?B?THJKU1ZGRjhDSVBaOC9iUk0wYmZVangzbW9kVXVNTzIyWE1udStPWWNlS3BN?=
 =?utf-8?B?cG83eU9oTFQwMDJsVkhtTFljWWRPRzJhMER5eXhMTW0xVU1sR3BJNkxuL3hN?=
 =?utf-8?B?RG54K0hjdTRYZ3NXbTlya2djSmZjWWZISDZKQzN2aFpTQVJVU0NmYUE4VXI3?=
 =?utf-8?B?dVBZQVNGZWNiNTQ1bnBYY0ZOSmY1ZXMyK2ZocDlhMkcvQ2hVQmFEOVhjYkFx?=
 =?utf-8?B?b0Y1LzJzZCtkVkFMNE15citYQUxXVjFTcDQ1cFNtclJGcHVaQk9FeE52RGZp?=
 =?utf-8?B?dk95R2o4RnpCU2lVRStqaktlRVdxZUFVcDNvTFQ5Q0lxTzA0UGhpZlpIY1RB?=
 =?utf-8?B?cVFOSHpXdXNWam9PVHRoOXlMdmoyZ2c1cDNrZzVwSmtYR2huWVFneGNBaENx?=
 =?utf-8?B?cWx2TU9KSUdIanBuY3pGMEhSR3U5MVJMK3dZWXNFTzJzeGZ4ZDNXM3ROZE96?=
 =?utf-8?B?anhha2NVemczZFovL1doTUl6S1pRRE1pOGY1RE5ybTNqNWdJdGxmRTlrV3R3?=
 =?utf-8?B?LzVFVVpPSU1BSFVkL28xSXppRmRDSWJldlRPN3lJbFkxemFKcklUaUxDc0xL?=
 =?utf-8?B?bWU4MnJsMUxNcWFKNzlDV3hIVUREb0gxSVVpV0htOEgxbGRnSHdVSlp1WkdG?=
 =?utf-8?B?WFUvQWRuek9FdVloWEdUcDF2MWo5TFhYT2dpVUFPemtLeGV1ZjhCL2dpaDQy?=
 =?utf-8?B?bDhzZ1Zsd09WY0psYXkzZUdKTWljaDRHMlEvWXAvZGFLUnZaa1dTdkltTFB5?=
 =?utf-8?B?OGNVM0V2Y2k4RkdXamFaSStvMi8wWmRtMWwvTFFLSU5sZEc4dStHMXFLcHQw?=
 =?utf-8?B?dEdVaUVMdyszSW02dDM3ZnNRK2REWVBMcEM0M0sxRGthWVUreVBZbW1vK0pp?=
 =?utf-8?B?QVkzVjZ5MnBsL2FMUE80cGpFZk9uUkhyRHpUTTNtWEdpRGlXd1hnVGRHRUxM?=
 =?utf-8?B?RDZybFhudGVBRVEycXNXNDM3dityMEhuZUt0d0lLcVFoVUo3MHA4aWNiSFZ2?=
 =?utf-8?B?QklxUGUwQnJuQkVxYzFsUExHbFl3bHY2eFJIdWVMejlBMmY1QkJYRHdLdW1j?=
 =?utf-8?B?aGNpV2xqa1FEdHBOK3ZwM0V0Ymc0NzFVZTNvRHdMU2FkMUFIZ20zTDRHN2VM?=
 =?utf-8?B?ek0xY1piend5c3Ryd3YxSWZNRElkdGZwUmpsWXNRdEluVDR2NEVBMWhabzdW?=
 =?utf-8?B?eERJVHVRTXhjZ3p6eXpNYUZKYnY4TVZ0cENSNXJUbVJVTUU1WWQ3RCtnWW45?=
 =?utf-8?B?dE5uODhQMUZtQ0FQbUtiaGZwNGdlTjI4c2JFRllmOVVyd25ydklucWJtcGxB?=
 =?utf-8?B?RUpNaXR5NlJ2NUttaGdhYS9SWE81dDN5ZlE2T1dMZFZmVUl5T1pVU2FLNGpk?=
 =?utf-8?B?NmdzWm5Nbnh1QUVoMlZWYk5sTDUrY09LWm8yRUNKVTc3T0VFS09ESE1LRXJa?=
 =?utf-8?B?b3dBanVZN0YvcXR5ZlhEN2lpZmVSVkUwWUM5dlh3MTluNzZMckFQcWpWM0FT?=
 =?utf-8?B?eHRnMXFNcm9KdDljTmU5aklNM2Fqdk9XdEFwL01WaGJER0twYjVpWjRHSDM0?=
 =?utf-8?B?VTI4OXVrdXo4T0ZKaGVrY1lzRjF1aXZ1alFIcEJtb2sxVWEyT0E4SllZclBU?=
 =?utf-8?Q?sg1fobVbDVbe83BhEjtqKzaPh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a51a20d-2203-4222-189f-08dbf758c1ae
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:14:38.3930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VPZIOemHrGa/r2HXNfSsSxP6bQAmsUG6ByC0PHTgpg1O5QQ+0aCN894RSjxF9h7ZTPu9CU41/rGC/q/pbuCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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
Cc: linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-05 17:20, Felix Kuehling wrote:
> Properly mark kfd_process->ef as __rcu and consistently access it with
> rcu_dereference_protected.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

ping.

Christian, would you review this patch, please?

Thanks,
   Felix



> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 6 ++++--
>   4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f2e920734c98..20cb266dcedd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -314,7 +314,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>   int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>   
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
> -					    struct dma_fence **ef);
> +					    struct dma_fence __rcu **ef);
>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
>   					      struct kfd_vm_fault_info *info);
>   int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device *adev, int fd,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7d91f99acb59..8ba6f6c8363d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2806,7 +2806,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   	put_task_struct(usertask);
>   }
>   
> -static void replace_eviction_fence(struct dma_fence **ef,
> +static void replace_eviction_fence(struct dma_fence __rcu **ef,
>   				   struct dma_fence *new_ef)
>   {
>   	struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
> @@ -2841,7 +2841,7 @@ static void replace_eviction_fence(struct dma_fence **ef,
>    * 7.  Add fence to all PD and PT BOs.
>    * 8.  Unreserve all BOs
>    */
> -int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
> +int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu **ef)
>   {
>   	struct amdkfd_process_info *process_info = info;
>   	struct amdgpu_vm *peer_vm;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 45366b4ca976..5a24097a9f28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -917,7 +917,7 @@ struct kfd_process {
>   	 * fence will be triggered during eviction and new one will be created
>   	 * during restore
>   	 */
> -	struct dma_fence *ef;
> +	struct dma_fence __rcu *ef;
>   
>   	/* Work items for evicting and restoring BOs */
>   	struct delayed_work eviction_work;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 71df51fcc1b0..14b11d61f8dd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1110,6 +1110,8 @@ static void kfd_process_wq_release(struct work_struct *work)
>   {
>   	struct kfd_process *p = container_of(work, struct kfd_process,
>   					     release_work);
> +	struct dma_fence *ef = rcu_dereference_protected(p->ef,
> +		kref_read(&p->ref) == 0);
>   
>   	kfd_process_dequeue_from_all_devices(p);
>   	pqm_uninit(&p->pqm);
> @@ -1118,7 +1120,7 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	 * destroyed. This allows any BOs to be freed without
>   	 * triggering pointless evictions or waiting for fences.
>   	 */
> -	dma_fence_signal(p->ef);
> +	dma_fence_signal(ef);
>   
>   	kfd_process_remove_sysfs(p);
>   
> @@ -1127,7 +1129,7 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	svm_range_list_fini(p);
>   
>   	kfd_process_destroy_pdds(p);
> -	dma_fence_put(p->ef);
> +	dma_fence_put(ef);
>   
>   	kfd_event_free_process(p);
>   
