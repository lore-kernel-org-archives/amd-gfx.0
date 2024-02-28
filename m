Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41909C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 14:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD92B10E070;
	Wed, 28 Feb 2024 14:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sd5wCt1S";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB3410E070
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 14:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIvOEa2Cfqkv4TlU/uhuRPNa+816fLlSxRGlw2xJoiwtydmhceiiUIjU9rNSksCZxL5uRwCejgfECceMPU2koI1dJh7NdR9La/tRYFi/0xRXpPOOBaW1Xub6sgV8lmyDPFhMo9VbJuhk27AphmgwmfAr4Aguaz4iyt5hBMl17UslsT82ws5wM5VuADmyBzVlPKphgmma9O24/Ts+P9pZ/5TMKXLs2VjnkOdVNhzKLfyTwkwYeU1IVbwfzCms5yMK/o/KavYcI033dnaKf6E4pjrYatEAwRtN8ZMb+YEayPcIor0v5Yb6x9Z36Ca8cMRcKzixhbjILpFifkNs6AuM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBvRWZVryLBMsweS9mEqzG+VlUHEb6rTlNkwRrXWO+Y=;
 b=aod7P+RjNp1F3xVJFh/mRTTB8oVkTUyY02EZyvXoKehFRwfcNkuPGcsrxKGxvZYdHAa5ZHNIO9XIYLzBjRQ4trjj+ZrTIPdsKpJs2yfeMwoJae4QCVMHNMkG5xFJsxcT3pg3/EloccSpsoOl7P5WSIDWMeXabZNnL2JC35DhOZW/Nr6DA4kRdTN5zL85HyieIawpVacIirDpCRq5J6byuZbVNVTT0NkeUspKuxvvJ/SOi2TDI4Ri3VQQRhi4jTV56eH0OlNUhwS2ytQ7KvWilkxgBZtGWXd7bFj55cS26I/mL0Of4rQ7jX+o6ynoyLSYdTmnKFmESugGPYbrn4RAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBvRWZVryLBMsweS9mEqzG+VlUHEb6rTlNkwRrXWO+Y=;
 b=Sd5wCt1SVYTQOpJbV/UBYSPEsLSGFdDzzbV/UN2W092jq1SYsp0Zchh+8bGYaE2cVI95Pmn0TUzTt5OkO5gv2cIRWE9AnEYBH8y809rgDuDwNI1otV9dtoAJPp9I3rpsl573w0r3lgsTHpyMfOsJfah4mdD5atrjnIxjdxJ/qUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Wed, 28 Feb 2024 14:44:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 14:44:54 +0000
Message-ID: <814dfe8e-cbed-4842-979c-6575fac2f6f3@amd.com>
Date: Wed, 28 Feb 2024 20:14:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Removed used parameter
Content-Language: en-US
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240227155355.517538-1-Harish.Kasiviswanathan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240227155355.517538-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH0PR12MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfbd253-0c35-456a-5973-08dc386bd396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwiF3sZ3K0SGbbZP7KgTgPIzYQoRU2nMt1hQtgfvlYUcR/+BGe18IE1eGiAAgiR9kKAxVeDRKgiGGm5f8tJUIIpVCeU3AD36kSZwd/dqws8IYCCCBhCBlLtDENUW/AromingLGi0JmSMRcTVXNz+bFwvlXJ3Zu04x2/xg34MomKMcuJ3vuc/LmMjvMgHka8Ztbe3ilCMUoFwNASq5Y7G1ySiSDl1hGc91oa8bTraeU1WvXIzkXkpuLrVaiD9FQcnHwsWRpo3rmEYbg1WhVD9B4PKB0bo4r//nY0StKhzzlsqPiaxUoGj4iG4BSNd8qkbvbqyFvYtMBpdvpOxpD3M02jkhh/PuMmb/vhD6quSuWK8RiMlBdLmKV2h5ajOywvWNSvkwrGWXb2UZVbWej7BTqmHj3aYHz7KGLExaSoil5jfqc1FZ3cO96A5O10KXAIJ9+Gpubt9E/ZqFzXWPw8RDOo58E6uR5B+7HoErHCR2udH+7PWuj2Zw0EbZYkSlCa38ecWTCzWOCNvaQ8lBJK4J2zHGgYZ9GbbrnwcuHEcAz+LHqwqkVVrytOXATUFelTzCgEhjoJmfSwOrSwbOVo3CPL3BlUCcVUEoRBTVxYsYtGFYlPbsJ0uiBPlB8SOIp6YIgqZkWQhUTdPsgt6rvATVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YldwZmxVTnd2OFJTWVdLU2E0Vkg3NHJobS90UTFkSVpKMmUyUWNtTUFNMXpt?=
 =?utf-8?B?TURDSVZ4aTZpLzVPMFJFSXJ1eUdpMy9zWVpOS203TGxlQ3dXMm9PK0ZqS2k1?=
 =?utf-8?B?Yjl2czd2cXF2UktZV2tXVFVuSFlYcVVMeCtxd3FLWWVsb0V1SzA3UUJXR2FX?=
 =?utf-8?B?UGtNMFhOZVB0U2NPRWVHL3FCSzY3aGdGL1l6ZGtJTktTaHdGcVJMalR0SGJI?=
 =?utf-8?B?SHM1TVFpeTFIVi9YT2JTS2xrazBZZ1BoQkt2NXExV2FRblM5MC9SanpKWEdD?=
 =?utf-8?B?Zzh0T0RHWjd4TVVJZ01Ddk1ZMHJCalFtN09KT09yR2dYK3ZMTzk1cUJXUEpT?=
 =?utf-8?B?bDdWbnJ4Vnl0V1ArZFo3clJ3MnVSclVaWVBMRmFjWmtYUzNmWU9hbVFjc0R4?=
 =?utf-8?B?Q0NZMVVYS24wL2kzTStVTVp2bXltd1hSZ090K0V3ck1qclFEVi9oNkthbDlu?=
 =?utf-8?B?bUxNSG9jMVFRWUREWFk0Z0NCelVkUllXMXlXc2tpTThSQmFtK0RpdENZRXd1?=
 =?utf-8?B?QmRSWjU1RHA0NXdCcGRUUVVjVGRtSUVYUjRnTkFSZGRUc1dnZEQ5MExHbzAr?=
 =?utf-8?B?bHRtZnIvVVhJY3VFUUQ0NGNsdnRoUjUxVDdENjRVamZrZTcxNzloMXJneFJN?=
 =?utf-8?B?SEJsWG0zL2JRaUx0UnRJY1NrakJPNFVXZXVyYjZqaEhvQnBqYTBpU3lobXl5?=
 =?utf-8?B?THVlVmdlWGQrY0w0Q3VkR25UQ2hvVmk1aG05MkVuVHlENzBOcnIyMk5paFZa?=
 =?utf-8?B?ZmppdUFvcFpGNFRBY1lsVllNZkYwRGZGc01lVzRpVTdhS3Q5RlNqTU9KaFNn?=
 =?utf-8?B?SzR0cVhVTzcvSUJCalRoU3k3Y2QySE5MVUFqWENwdEIyRHFxMitWVFZ2bVMx?=
 =?utf-8?B?clRYZ3ZSTHFVOUdpNDJkZXBhTDhISEduN01NelZOUVhQOW9GUVk4QXByd2Ey?=
 =?utf-8?B?cFlGUlV3WEhJdGo5QTZJdXhRTXgzU0U5RDI0Yi9kRnA2aHJHQ2ZoYUlxVWxI?=
 =?utf-8?B?L2lxbzB4MVlrRmRXV00wV1dmdUpRcTEwb2QwQUpoZ3BkUHR3SmdpY3B3dTFU?=
 =?utf-8?B?c0IzNm85a2FvZ09EYmJSUDB1MVNaOS9WZ08yRW9FWnRFa0IyZC9JcFUydWJK?=
 =?utf-8?B?MURFUTNmT2pKU3AzeUtESkJKTU5TT1NSN2JMNWZVQ2p1b1ppUnJyTHpwK3B6?=
 =?utf-8?B?T0tmZm1CRjBWN3I2T0krOFlMYk5zVjBJMzJQelE3azZVSktDSmxscXNEQXlZ?=
 =?utf-8?B?L2VzRHFnN29UZ2Vkc056TkNFQjVNRlhIeFlVUStidis4S1psQzFsaERCQUl3?=
 =?utf-8?B?YjhqSDJQbmJnNU1HV04xRnNRY0NadzdyZHpMajhSZ2hReHE2d1U4M0hEYTRG?=
 =?utf-8?B?MWZ1cnRLL3dhajZqWmxOL1JaMStwT08xajR4ZlVKWmd1eEo5V1pWWEdHMzRC?=
 =?utf-8?B?TGllUmtQY1Zrcjlwd0lqckVCNWNsS0RUVk1yS0JTOE5uZDJYMlNQQzJqOTJD?=
 =?utf-8?B?SVRpektZRVMxS0padHVLVHlMYUtmUUloZWYrSVd3UXV5UC9xTzc2QTVpT0JI?=
 =?utf-8?B?UjJTTHdpemw4OVBmYmJCbnB0ZlF5Rk1zM2NPczNGUUk0d1NWZ1Zhbzh3OGIx?=
 =?utf-8?B?M2FLcHBrY0d4eXozYWhZazRYcVJqczlhK0hpNzZoTW1FcWFnL1ljVVF1UlBu?=
 =?utf-8?B?eEZxUkgxZzBPT05sckduS0RqbGwydnBaMUtLQ3UyY1hmUW44Y2tsYk93c2J1?=
 =?utf-8?B?ekozbUZDRVZDSXBZMjRYbnZ0WUlISWIzK2VPOXYzenNRajNzc0prODk0enpN?=
 =?utf-8?B?RUdEYWxtUEt1eFRWRUlVTDE3RDQ0MkduMG0vaGxpbVNTUjh2SmN6WnUyd3dj?=
 =?utf-8?B?bDZJNEhPSXNKWHM3bnlQTXhOL0Nac1JESjkyR296TjdTbG4xSTc0V1pLY0xa?=
 =?utf-8?B?RlNwaHRhQzRaWVV6SkNYTUREbmEzeVJpaEdLRG02Y28zb1RoUnRnSm5PdGdQ?=
 =?utf-8?B?a1loYmFSU21NK05hMUdXR3p0a2NXWkk3SjRUREVxV3pWNnp4OCtLaGRGNFdN?=
 =?utf-8?B?TmZiWTIveTBEM282RS94bTh2aCtzcGtlS0tOa3dZTERqRHBnZm9sZEJoNnpn?=
 =?utf-8?Q?YcR8G8iOZfkWa1JtBUfIMnGWu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfbd253-0c35-456a-5973-08dc386bd396
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:44:54.6392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c5Zb9COKBFZE6D6jwo4Tv1/7Hju6S4Qi8AeVOm/Jjuybt2cyIIGqtm55PYfJHEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
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



On 2/27/2024 9:23 PM, Harish Kasiviswanathan wrote:
> Also passing adev is misleading if BO is associated with different adev.
> In this case BO is mapped to a different device
> 
Looks like a typo in subject - unused?

Thanks,
Lijo

> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4fb32d86cd0e..0ef223c2affb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -320,7 +320,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>  					     void **kptr, uint64_t *size);
>  void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>  
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);
>  
>  int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>  					    struct dma_fence __rcu **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ef71b12062a1..d0819fa5fcd8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2189,13 +2189,13 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>  
>  /**
>   * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
> - * @adev: Device to which allocated BO belongs
>   * @bo: Buffer object to be mapped
>   *
> + * BO will be mapped to GART of adev to which it is previously associated with
>   * Before return, bo reference count is incremented. To release the reference and unpin/
>   * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
>   */
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>  {
>  	int ret;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 824e660283b2..f030cafc5a0a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -371,7 +371,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>  			goto err_wptr_map_gart;
>  		}
>  
> -		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
> +		err = amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
>  		if (err) {
>  			pr_err("Failed to map wptr bo to GART\n");
>  			goto err_wptr_map_gart;
