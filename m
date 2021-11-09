Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 05:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984CE61151
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 05:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 984CE61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4607989EA3;
	Tue,  9 Nov 2021 05:27:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC7B989EA3
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 05:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrDgHZWaCEhcR7ObsvmC1V9VjoT+iMTp09jlTMeTmf/qVeVpkWC02YwgpnropjYN/9+uxPdcDaE6S7phlUc3I2lqEqDDnFUBXjQCLR6d6POpbvWigqMnk0aaYTmO8HaNCxqK6bsQ5r4ID5WGu96L/7mfwOldK+7H2gw1eSQM2tYcU7cDhNtEjRds3Fc+uSKRym+gGVqudjlXkknsrPfNcgNhQxbrykjtFekhQJAcvUisPWoYdjlrKdMxgkhS0I33qBjD1VjGnAMz1IwMyH13Ck11ky3/Q0c+OjuNdohrYJFe5K3qx3fCuXmIotswGqG7ns3TtY0cfLD238q/9UGA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4LXvRg1l0VGsRAwxdH4RElw0zm7v15exwrNwuzI1qs=;
 b=bB0IyGL5JDs3DigKTZfk8pxkcGzng8Fe+gJIgnP2ywuPpyFWM4x2xN8bGkg8e9JhhnS3jW9NNRjgbzCz/EcOW/Mq9JILlMppMt6Igj4xdkVgs0SsHZKFWTCOxqvdQC5U7rZW8MbhXJTugS/kl3EUs9ds08ZG6hFrGsNOaue+t9EhwhstH+EfG8wkbwcOXn8o0S/uTK+2mQTp/aMJEldswNQGIK793EyNXh3AOLDtRmsJHO0LyVMxCIZuV+GFEjL6lT/Mxhg5FpOXaL7yYx2akwm4b0ic0jZ0q2fqyHAEcBK2KrDMl1a3ED9lGJYeHt9uGluUlV839oRVHvtMUfWjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4LXvRg1l0VGsRAwxdH4RElw0zm7v15exwrNwuzI1qs=;
 b=esLz2Kviqu2SnjdYzCV7CkrT/V+tcMpHNKxXCQXS19vyIU5sx3mmG4OxqQYlzv4Hl2T/0TrsHnBCJebIGjiTnF2nkptSxWhBK4uXaqMsO0WU9cjo3bCkphowRFFH9oCU+sLRgdK8AlELMTwBnRiDpWE0S/fUIOMHSNeM6nIId0k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Tue, 9 Nov 2021 05:27:04 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 05:27:03 +0000
Date: Tue, 9 Nov 2021 13:26:48 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT  domain
Message-ID: <YYoGmHxlugJagJ70@lang-desktop>
References: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109013744.30464-1-Ramesh.Errabolu@amd.com>
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by
 HK0PR01CA0070.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Tue, 9 Nov 2021 05:27:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b92dd2f5-da95-4e98-7b00-08d9a3418fc5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351430443374F29A462ACC8AFB929@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hINKe0GL6GIIbvku/eEHuc4PFcSfR0vWQOxPpwMiI7X7005/6GkAfUtO74Ai11hnzW0pQsznD0dYk5VeBfVPN3baHLE2mgeM/kY4w8iWiCMr2YNCg7w89Ymwun3v+W85rJK5fdQY+t3gd8uzdYCqLXXz6yKFiGf0HTU11sUHkiEcQjeZXeasGMU3yJ0dnb00SXowjfJVuR4terMJvAz8tM3a/RK5lpHHA/XJDO6u8DLXElQMvBE/1xkJwEjUFVTW3NeQj9Ze6vlKeBflrVEhT+HGzHKMNoVTXZiQrIjTWH7IKnCw6D1/cqYywqWU+h7PAqsM8ogzJHQRW6pZUEu1DY2UOxUbTHXIDeT5nJsB2hXHeqxh0ShnquEdA2XDRPmd1kAbIKZfq7dDvmtm0luhzFSXmToL13euZpGBSlhsT0SKJdDdpBKB7NBAwuj69niKoX1rWgkIcC9Wwntk3J0ohBOOYP59beM08Mdz5YnzSWVlK2h7uHAoIUhyONAfxEZNWJGrZgLwxDuoAZF4Bvz8GjLpi37txwGez9+4l7lZAEbbOOpFUf3Fl2+DOlOj02czBpUciaQdM0GDSn4So0Tblhq8/y9DP137ifqhhMD8HFueGBnvVGlEuGQbT0ZfB2jmungovJYpaU+6zuiXMHIzGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(6862004)(956004)(508600001)(55016002)(6666004)(2906002)(316002)(6496006)(8676002)(66476007)(6636002)(186003)(26005)(9686003)(83380400001)(8936002)(66946007)(33716001)(4326008)(5660300002)(86362001)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rh8j9IKeOIOWnj06zQut3rY859Z7Mg8yoQP5p3pMz6Zy2DpolocuKlKqrBMd?=
 =?us-ascii?Q?b6PBKQ47XD/EfHFE/tWGpyiQghiEj4wyozfOm/olrnspyy/YvJr/a1YmLpwe?=
 =?us-ascii?Q?qwVdm9n5OeW2HXZOBWuljkl6HKMLQDFDIKmk3m07JKaSH2WIhT6ZGKF49XpY?=
 =?us-ascii?Q?7ylEWRZGQvDiqAq+PDIHe9+Xh8YXE73xBdj+kOYTPE5nDdZYYRGhgve1rZBA?=
 =?us-ascii?Q?tU5h83R3gNx0gepWNLjIuBvfjeSOe4Wots9NgxIq3l+F8b3wyy+z5qPC/weK?=
 =?us-ascii?Q?9AKdTN7pAkzMxrdmp7acmbj6YUXN/64yES7HADQLgdgtdV6WuLvL57Fy7tBw?=
 =?us-ascii?Q?Ja116Y8mqnq48bF2Xmo15ZAk9o3XisIfhH/Pa6KYmVy/r+an4aCSkwFrfZ/y?=
 =?us-ascii?Q?RnP0AvfQ8c3z69SDTyZIPU5sZa+kMecKfcOy5iTeKeth3AXKzd/+DYeF2BlU?=
 =?us-ascii?Q?uy+Jh8+qQEhmkcT5stWzaGwKtxW+nj2hHBqunASpeIiMusNet9303ikmHxOZ?=
 =?us-ascii?Q?E4HLDgm+9DQocEsRSazXRBBVp/mfn7mDQuVOwC939Eq0xVtc9JhiP1lpx6iH?=
 =?us-ascii?Q?/XcOvms3+fagCWPRsJOZupnPJLBRO/76MjIIF0vxR+W4sTorustev7Vy7Agw?=
 =?us-ascii?Q?s09l6qect73rhN6EfJtVxTn/tJf7TGORz0pgu8bXO+7AW5s1jquscdQAM7zd?=
 =?us-ascii?Q?WmNP965mQAUoaQzDqsxqpOa+kI1UOXYOo+B3GscXrc+8YT++ZfW1pkhm7Huj?=
 =?us-ascii?Q?bmwn76YAVCCK9W6YN17XYuC3D1vSxOigWcPjljSzWV8GKlNtLzlulcr3sShI?=
 =?us-ascii?Q?vkVuqb7skLcvreE9o1iwisDmiPYzCR6HBThqNh91ZipMaSVUTteBzp33L+Ta?=
 =?us-ascii?Q?F0y//dNyXuPWUpJ8Rn9ruikJ1Eak5mLWg85xsTGM3FpBf0n/STpKgU/3WofR?=
 =?us-ascii?Q?HQoFQsa7hBIz4Gp3LdfFPNaHm3TjtL4Nj1kE+3KPRzllD+X/dhl1qclZDfAT?=
 =?us-ascii?Q?7NntU4JjuUgdBzusL8FPv0jyHKCVT6z90k+/GzdGlm2VlWBatD5eSesiJPf7?=
 =?us-ascii?Q?V8C3oQIRgL8e7vpPdngoEMOdezEfwMvGqwb5AYEyxNJR9sGEDYN1O1VXUeeF?=
 =?us-ascii?Q?d4RK3bFMV/cnCGyliKFtONvOfZtUDWNwP0gR0bvmg5zUhmaykWETDRzzayHd?=
 =?us-ascii?Q?RDe2BN+OoowgdyJ5PlnkJ/RzY5Gsx7Biyhg5Sgn/k+YTf74MxO6X+lqXNLFA?=
 =?us-ascii?Q?yo/DFsjj5busXDYZS4IGdcBAZFXVOEC2kXc9NP8yVxEVVELRq+mvW0dwgGoM?=
 =?us-ascii?Q?YdpAz+UJz+F/E1015xnUrDN9r2lvhjbcbTfDxJ3uvhXZtgWDMhOZgYDaBIH6?=
 =?us-ascii?Q?FjmJFNva2v6KOqmouIjUF2sh6JgF0TCp44ix1eOfKywyYj19IDNGhnJOy2ai?=
 =?us-ascii?Q?DIMa5IB/k8Fub0M968gbgEk+m9nmFCoKXusRSt47+b7Ur2HitSaW1gg5G+R+?=
 =?us-ascii?Q?1HSNFzP3Db2MTiLEfVGInCWkdRRJzKLSPKKgC2zSxLe4Sx3cNLyp8XJLBzaO?=
 =?us-ascii?Q?UMp+UZkIQo3HLdv57L6FFPAUfrA58nKr6N7ZrW6Gl8hurnFE4zw3M3UB5x9g?=
 =?us-ascii?Q?1F1SJMg7husMvykD3Momavs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92dd2f5-da95-4e98-7b00-08d9a3418fc5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 05:27:03.2241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gP+GKzwIbkMGmwFNbfosKrStoDpqNE3IQq1/a8rTJhMkuiH2+LityvT7So+kpscE8pYatgzD1keLzx4kD++ZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 08, 2021 at 07:37:44PM -0600, Ramesh Errabolu wrote:
> MMIO/DOORBELL BOs encode control data and should be pinned in GTT
> domain before enabling PCIe connected peer devices in accessing it
> 
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 25 +++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 55 +++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4c1d6536a7a5..d9a1cfd7876f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -300,6 +300,31 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>  				      uint64_t va, void *drm_priv,
>  				      struct kgd_mem **mem, uint64_t *size,
>  				      uint64_t *mmap_offset);
> +
> +/**
> + * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
> + * @bo: Handle of buffer object being pinned
> + * @domain: Domain into which BO should be pinned
> + *
> + *   - USERPTR BOs are UNPINNABLE and will return error
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count incremented. It is valid to PIN a BO multiple times
> + *
> + * Return: ZERO if successful in pinning, Non-Zero in case of error.
> + * Will return -EINVAL if input BO parameter is a USERPTR type.
> + */
> +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain);
> +
> +/**
> + * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following criteria
> + * @bo: Handle of buffer object being unpinned
> + *
> + *   - Is a illegal request for USERPTR BOs and is ignored
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count decremented. Calls to UNPIN must balance calls to PIN
> + */
> +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo);
> +
>  int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
>  				struct tile_config *config);
>  void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4fa814358552..f4ffc41873dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1299,6 +1299,36 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>  	return ret;
>  }
>  
> +int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
> +{
> +	int ret = 0;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
> +	if (ret)
> +		pr_err("Error in Pinning BO to domain: %d\n", domain);
> +
> +	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return ret;
> +}
> +
> +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
> +{
> +	int ret = 0;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return;
> +
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +}
> +
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					   struct file *filp, u32 pasid,
>  					   void **process_info,
> @@ -1525,6 +1555,23 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  	if (offset)
>  		*offset = amdgpu_bo_mmap_offset(bo);
>  
> +	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
> +		if (ret) {
> +			pr_err("Validating MMIO/DOORBELL BO during ALLOC FAILED\n");
> +			goto err_node_allow;
> +		}

amdgpu_amdkfd_gpuvm_pin_bo() will do ttm_bo_validate(),
amdgpu_amdkfd_bo_validate() seems redundant here.

Regards,
Lang

> +
> +		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
> +		if (ret) {
> +			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
> +			goto err_node_allow;
> +		}
> +		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
> +		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
> +	}
> +
>  	return 0;
>  
>  allocate_init_user_pages_failed:
> @@ -1561,6 +1608,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	bool is_imported = false;
>  
>  	mutex_lock(&mem->lock);
> +
> +	/* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
> +	if (mem->alloc_flags &
> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> +	}
> +
>  	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
>  	is_imported = mem->is_imported;
>  	mutex_unlock(&mem->lock);
> -- 
> 2.31.1
> 
