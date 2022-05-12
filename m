Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F60AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 00:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E836F10E4AA;
	Thu, 12 May 2022 00:45:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BA610E48B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 00:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGGKF/fyd5Wr4ut1L3JurUChKn8GPnt11TaZnCPfPJwnsodH1dw6bfO4sQY3odHzs7PcU47GGjx+/MGrKuyghhvgWyRh1VsOg4l5Wv07ke+NvoVApIcMcamfltAvzhyHeIEXJYLfUjDxgA6tfzNUE7545HkCyrS56eONlbomYWLi/IOrJLKIubP9DX3eL6tldDCeGdnDXJhvG/bCrqNpbB8TDo4N6Xs6HjpG6jHXSKF/aBCK6MNnWcQ7Vv9OeBMrmRygEyPWO9aXIBGMSOHC00rax4TCwFM9ypXC+gr/tP95DsfTqjYNivJXcCYkQOpHGtjbpJZnRSXafURfErieTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8zUVsoXtw8M4yijvrJq9KdQv7nDMSZsTtQD9mPFQ2I=;
 b=ZL24ygVo991N92ibgEGt+cQl60f/mYmS+OPiRU0UpHHg/1/bygRfTXmNTC+8ZQqr9BMh1pae9jJNj2QdcxrR5ATWGjAYj7SuoH5DsbrwvgKbWPtV3JksRkGm87rKGBgIDQZ7svy9pWsFusrmJDLB1cZtopN7HepH7NHTdfkMXv5dU/I1hufCPdOyp7GSpeIV1WB++EswUXl2tjVzL3aLUxVh8uSaTIH1/f6VjC/x1sq75zD6FvXHOcMjbk2aXF3uVxRqUpgOafQpRJDYX9HjAlQlEWBOMsPgOAlHN2q9/IunrBgzyDxNad3vUjJ1Vl3X/fGsRt2yx1i9ahk8xiljAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8zUVsoXtw8M4yijvrJq9KdQv7nDMSZsTtQD9mPFQ2I=;
 b=ewVFAPpL5S108OCrwC+zPSUr2VugIqi9MeUB53bVcEDCJM5lQHJkyAa1hJxlnTprHKOTtVYGdfVeHbVlLSyEWl0MJr2DhSwkTMnAb+vyeGJTiF2qMIYAcxKTbZcf0ROIr1aEBzP2wX7PlLlfQWiuMDvE4a059fwIDptlSW85iSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 00:45:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5227.024; Thu, 12 May 2022
 00:45:24 +0000
Message-ID: <75407d56-320b-7d93-690b-2e3385a17125@amd.com>
Date: Wed, 11 May 2022 20:45:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdkfd: allocate MMIO/DOORBELL BOs with
 AMDGPU_GEM_CREATE_PREEMPTIBLE
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220511094407.266336-1-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220511094407.266336-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:208:23c::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72515d41-d43c-4e13-84f2-08da33b0b342
X-MS-TrafficTypeDiagnostic: DM6PR12MB4252:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42521FDE1D57468FDFC9CE5792CB9@DM6PR12MB4252.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbZj8VG7Uu+x+HJumSXI+pQK4DyHex5lpQ8Kj9x/WJB0qMM3W6w9ORG93hcxoN5jSQOe4iXkFlxJPkKKsWLbdeEkwKDjK/Y2/h9yK1ogOyF3iH6yWgFT7i6lzzfr/hwbAbHIJCpuECag/UymlZB790QbadCF+PXNGx89nNQyXtkdxDNjOPzTZdf2dq7WgynAQs92JHI4h1qA8HGrFXGH7KV0DV+cyF46QtJjTiqnrh/iRMNp8SmCzeXvc4XX1zBqy3NSCOYgRGE/0eKFG5lhpKo0Vuq6zQnnkwZVR6PpeT57I2KyFxu0OK5TkkAAVC8gNln1Cak38tD2IMNO91HSTcA7iRL2q/kNHhEReumZtpEkyLcfpceTSYCaPDNv3/AtKP35GgpnUbhSnhmTiN9nfyfdbdz3q0lxDYphuK2LeoGV2vl7HbHmu/zn72K4t00pDpcRoqyD3D+x4nHVLXTDkggdlEBeOAzshjN+g1E/5MvBt7nfxzYt5ihp0tgoburmnM2wUkTfTlfGjFo8bs4pKuhKQox/7YvrTvHdHvCIONu/w0riqC/j6xHgbsXO6EMYY9Phcw38QniUVpmcpt9j3/jt97njPUVhxbqXvFXqfYYxLSWihtg5G0xn+/5pJgLkRdqbi66hY+0ZC3WySanZnEyb8TAdh8D+D5HznV1c6cpdrQrunuGzJfv3aB2Z9REspt7rgt8XszYNB4vS2JctBfxNZeZAVuhAW5/VurePbEFgdjOGZ8y+BARNtyAcF/m3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(31696002)(8676002)(38100700002)(8936002)(36916002)(2906002)(6486002)(31686004)(36756003)(26005)(86362001)(5660300002)(6506007)(186003)(66476007)(316002)(54906003)(83380400001)(6512007)(2616005)(66946007)(66556008)(44832011)(53546011)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1lYU2U2S3FCL2NGME1hQ2dJUGJnSXJyOUpEVE5vbkd4RTB2aTFTczNwejRF?=
 =?utf-8?B?a1k4c3FESDZrQjM3NXZTcVJjV1dXY2NuSjR3Mlhqc203UWwwZlVHOVZ5SW5k?=
 =?utf-8?B?SHF4VTJyTGFLeXRXMmFVTzZBZDNhQTNpV2JhbnF5MjF1emtncFVTZ0hqcllW?=
 =?utf-8?B?cHhDTkU2WXQxalV6d2p0ZHNBeXAwQTFhdDlwS2I2RUswR0xRaG5xcmNjRGd3?=
 =?utf-8?B?WEdWdlpwQ1ZyMHdwN0JPbjJoZ2ZFT3FHM0pkSXJoY1NKdzZmeWIxUENPdWEz?=
 =?utf-8?B?L3J2NVFZbzgveGxrMlhSckFVSWdBSklsQVJUcy9wZVRNSDdWNFFGK2JkNi9p?=
 =?utf-8?B?Myt4ck9hTmlZVnRBTmwxK3JpTE4vUHM4WEtNVVBDYmlSZStNQXNLcTU5TXRF?=
 =?utf-8?B?M3Z3VXEzdzVsQ2xZbEh2bjBDWjBSVXBiYllERzlGcXJlYlNSd2JmdXNIVVln?=
 =?utf-8?B?R1lzZlZMYnB2T2IvYllFSVJZbUV0SExSZFc0QlQ2MHRocDRTRmtiSlAydzcz?=
 =?utf-8?B?SXJjVXdPc2xPditTcEVpNVhjZmNyZFNKUWcxaUtDd29wN2hSeFdaMGp1dkVF?=
 =?utf-8?B?Mmt6WnVVNG1PVTNQbUgvdkMyWXBqYnNVN01JSnVqcEM3ZXFscTZOdnUxTFBJ?=
 =?utf-8?B?NjA1VFYvOUxGajhlSW42SkVXTFFWNXRHUDRYU2tvcloydFhSbnNMTXlaVVhL?=
 =?utf-8?B?c3Q2ajhQTC9Zc0xBRUpPbnhnNVlrSXZ2NmZaeG1oazJ0blhDRkZvNElCTkVX?=
 =?utf-8?B?WXZCMUgrMWphbUVEek9lbk14RG5pdDFoSytpZVpMSVdObXZhOGVkWVBhbjBT?=
 =?utf-8?B?eU51T0JETStTaXpoUWtxeHhuZUNGYnBzZ0F3S2tzemY0blRxTUI2OS9ZNjFL?=
 =?utf-8?B?em1KZGxnb0RsaGdOSStNMDdmclgyOHBvamM0TFllUXFkMi9Mckc2a3lMVUJt?=
 =?utf-8?B?aHdYdTN3bGlPQUxIMFlpbEt6SEc5TUF5YzBFQW1tUjl6R0dwSUNhRnFoNWtM?=
 =?utf-8?B?VXZUNWlDWWlKeTd6dDViUXpNb1Blekd4Yi8vekFJSnNBYzY4TVpzSUw4WVpk?=
 =?utf-8?B?T0lnTENwRStYYXR2L3pobVdyMkhHWGNNYVR3c2g2Nldsc2RTOEVHZFdUNUdl?=
 =?utf-8?B?ZXNlNUZZbXNrNHhCcThRbjJWYkxodjE0OEhFajFRSzBNS3JrNnZqWnJZaU9O?=
 =?utf-8?B?MUJNM1ZUY3J0WE1wTkFhcEg5MTloUThwUHI4ME5ZLzNmeEJDMkhyVDUrL2E5?=
 =?utf-8?B?WlQ4cEVhMVJXYUx4Rm85WjdqTWlkSnU2ZVNqcGorRHZUckZYZnByZEZqMFp1?=
 =?utf-8?B?V1pCc1F4Qkl5K2Mxb2JWYnhZc01FZzA5SXdKallrdlNlVEZldldCV3BCSGZO?=
 =?utf-8?B?Q1lBZ1FxaGNSeU1Ld3I2cHB2WnVHK1dUMERUM0NKTjkzL0hhYUN1Wjg1MU5u?=
 =?utf-8?B?aDFPQVlmLy9sbGdHL0lVVENyTlY5dXA1N01xVHI4ejhvSjJpblluNGVYY1lG?=
 =?utf-8?B?MmMvRzRWRmdia1dhNkJxQjBvYTdvQUJ5VStWdVJOQXVHMEpXYUVEakxUT1dT?=
 =?utf-8?B?aUxKbkdLaDZ4OW9zdTFWalpGWk1pb0dmVFJGSitNS1kyMzgzSk1xZEpTU0VX?=
 =?utf-8?B?TjEvdDR5a05jVDB0UFdvR1Z3TkJWM1J4R2FSdnNUeC9wdW1aUU11b3krTWRa?=
 =?utf-8?B?N2xacEZpTGZnNUFlQjhlMDVKU2hGYStEZ2I3dWc5ejI3MWJuYjVNd0h4V0hZ?=
 =?utf-8?B?K2x5TnVlSVdwQ3NUZU51VEUzdFJpOUlXY012U0lnTG1zREhyZk96enhkYTFh?=
 =?utf-8?B?eG4wUkhFbkF3QzR2WEdJLzh2ZWtnR0tiKzdJdXVoOXBNc3haYUlmSVh6alRu?=
 =?utf-8?B?MlEvazB3ejdVMTN4TDRKajBiTTh1cFhKRkhabTlwNWU3OFJqSFhUQWpseWVm?=
 =?utf-8?B?TDl6Zlo1S3JBMnNtbktUZk1jVkJHeW5NeHZqYVVqSDlMaFVSQ0RmdEZ2NTd0?=
 =?utf-8?B?RWk2QzZBUU1kZDFVMnFJU21WWGNHUFpreE1lMnZVSSt2NHdQbCtTU240aTV4?=
 =?utf-8?B?eDdSMWFNbm5ReTY2SWh1VmpwQXp4QjQzUFRick1wY2lrdmhHVW5za24zOUNr?=
 =?utf-8?B?N3hLbHI0NHc5TTNsRTY1QlRjRUx5UnNsa0tYNExOK2I1WVFPRWYzSGh1M3FL?=
 =?utf-8?B?Mi9BQnhyMGRySnVrS25aYkhsZXRLL0d5a0cxaW5paXFhWFpjOHlOZ21HaFp3?=
 =?utf-8?B?eDhpM2lpOVN5cmlITEhuaDFSdjVqQ0JWYTVSYnpuY0o4QXhOK3FxUVc4WDB2?=
 =?utf-8?B?MnRqZHdodmJJcURHWi9Oc1lLTkpiWU1sYUVRajVsRWt1OS9CYjZtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72515d41-d43c-4e13-84f2-08da33b0b342
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 00:45:24.2494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /g98PLJ6Lw36dGbdpjsEH+SJXNBsPq1QhBV+uw+yXmEfC9DMNGAe+JobCO0+/a4E5T28iDdr2LdOOhzePVzOXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-05-11 05:44, Lang Yu wrote:
> MMIO/DOORBELL BOs' backing resources(bus address resources that are
> used to talk to the GPU) are not managed by GTT manager, but they
> are counted by GTT manager. That makes no sense.
>
> With AMDGPU_GEM_CREATE_PREEMPTIBLE flag, such BOs will be managed by
> PREEMPT manager(for preemptible contexts, e.g., KFD). Then they won't
> be evicted and don't need to be pinned as well.
>
> But we still leave these BOs pinned to indicate that the underlying
> resource never moves.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 32 +++++++++----------
>   1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 8b14c55a0793..fada3b149361 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1518,26 +1518,26 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_flags = 0;
> -	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> +	} else {
>   		domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
>   		alloc_flags = AMDGPU_GEM_CREATE_PREEMPTIBLE;
> -		if (!offset || !*offset)
> -			return -EINVAL;
> -		user_addr = untagged_addr(*offset);
> -	} else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> -			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> -		domain = AMDGPU_GEM_DOMAIN_GTT;
> -		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
> -		bo_type = ttm_bo_type_sg;
> -		alloc_flags = 0;
> -		if (size > UINT_MAX)
> +
> +		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> +			if (!offset || !*offset)
> +				return -EINVAL;
> +			user_addr = untagged_addr(*offset);
> +		} else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +				    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +			bo_type = ttm_bo_type_sg;
> +			if (size > UINT_MAX)
> +				return -EINVAL;
> +			sg = create_doorbell_sg(*offset, size);
> +			if (!sg)
> +				return -ENOMEM;
> +		} else {
>   			return -EINVAL;
> -		sg = create_doorbell_sg(*offset, size);
> -		if (!sg)
> -			return -ENOMEM;
> -	} else {
> -		return -EINVAL;
> +		}
>   	}
>   
>   	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
