Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33998CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 11:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997F410F2FA;
	Wed, 30 Sep 2026 11:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIBn4Qwt";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF16910F2FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 11:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd95hbTa2yhQQ61V2tOr8VVr9gTqFX0qeVMrS1i3iF6qsMBLmZUkSPAVZsbu1pAPKKi9NypFE+UK2xj6j/0+guHJfu5yejdJkw6iklrnNzmqtUOW0VISzBcORhdQ3WvrdxqAHaI+KHa5iCtCLfZIKstxLAxwEdSsq5DBIHODBa8Y9/b43jbOiuOhVDEvVwGsxaC/VEeHKSVKnQLEheCyj5NzEtBA+wkrNRl4eY5PiA2B1RYX4ztQPv+RuD+1D5hcTAtqNNBqawAoHxk++YC0FNHXPIdBEBKb1XPMnv2yGO4DnoRDZ8u6EZM6swaQ3D/hu/cskjvcx9RMswEPNa3yWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AI/7TSf+mvgPwq9lsJdZ5Q27t05tW2UGeQ31eqfb28=;
 b=ofXzbkd72OPJnHGDErJ426zS3NIpLp9fclwzoSsL+LMLWB91UV1tRQJCa2hIILNgHw7STA7kNkhSYzB8ULyxzdFCOa5o9FgaG+iZUhEzBxPv389FbHGl25P+AGsub9EZb3CGhuz1/IJjyEyQ77g87G+LRwG9h785p4DA1LJp3wpgI3rVc9uN1ye5V37J4zymsm5/D6doalNscf332CxoAa2QBRytNizHG3eX1zb/vVhwKGMPdcsMwQAkGCjx+zVRFjbYUpx6qIj3nmLXZSywEZ/f8PcicITlnxRDD3b/4Guyz962u98yKm6SyPq2ijyO9aWQTuhMpQG4TQYRDvNSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AI/7TSf+mvgPwq9lsJdZ5Q27t05tW2UGeQ31eqfb28=;
 b=uIBn4Qwte2I2LMU5rOSigI9AuP3rDqv5gAau/X6YIDiObuDY/B5gA+ftO0+MSK4kYLWKWOhzD1uv3cJkuYapSchYGDZl53MifpAnY13XKh3HZ180SAdq+kPKBLlJuXx1JbJ5NY2CLaOQNS5GjWEb2Yw8RNz4AiSSYCF1/ViEWvw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB432622.namprd12.prod.outlook.com (2603:10b6:8:70b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:31:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 11:31:35 +0000
Message-ID: <2873ad31-7fd9-4fcd-96fa-7f4fff1c1934@amd.com>
Date: Wed, 30 Sep 2026 13:31:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: move vmid_mask_gfxhub/vmid_mask_mmhub to
 vm_manager
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930111601.3721001-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930111601.3721001-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB432622:EE_
X-MS-Office365-Filtering-Correlation-Id: c411c64a-df63-4e37-374b-08df1ee66270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ouJojeeYlbvW/xzyUz7UaQRtIGm4lspr2FTRl5NINq57C0ysu1xYd9iHnTLVrUzgfFGVulWybDIIJCS6v9xRDezMtUxpdLju1+kDji/wzGJeZTZchee+zC4AacG8YrT5vzcexNM+1Mz0CmAGpNQ9NUCsC/Mq05RtLqXx9UUe+QWLInA/0773bLm3zGqq5tCzjP8jHFiPeokvx6iRDmrEbMODOhITwnX1p1em7B+pcuJjYGa7z3/744oPSBEUqL/XO+iQH20i8llUEnJ4Y9wViFI4UZkJkdd56vGRu35tZ63oyUIXjdJRQNkUD6cKNYSeQpBwhhRFrdNwo/XOwGn2bNuvrg4Mq5mp8u3B45ZxZ/jL4SRqxAlFbV39H+n1f0VH2LN3NeXmr4BxjGMrPbDBFmUn5pPrxP57r9wyUK8kqc+Zlhq0p9RDkmB+bio7D2DNwnVuiQmTVkg3Gp5mmDI1ZK+r6WSGjoRjiq0yqLX2FF26Jg/HcKiFRNMGmZVkNogjlvNMoJ2VKd/LA1xz+s0WPANGeVfZ9drIY7isNIsDtmUsG46Bp3G/G/yTPEvMwKaGOFBaKpqnMtGHVsYIfDUavUXvfP1sonwajBp2omracX4PHvRtfy26uK3mabE29PBL84hGm09I3AtdjyplCGBx8ZOlGYOljV6tJnxyi3xdV5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRjQVl3aGVTeWVNL3Y5c00ydVNHaFdtN2pibWt0aG9ObFNrcHpERlhpZkNV?=
 =?utf-8?B?c2x3U204eklhYkZ1d3B0TlhDbEl5Q2hwWWxxSno3M3FNSTcxdkZDcEVreVJW?=
 =?utf-8?B?ejVUeDBPakJCVHBGL1JGYU9RTUpBaHA2Q1lBbnkvQWdKSnk0Nk42NVlQQlo0?=
 =?utf-8?B?V0kyN1MzcmRVTW5sWU5ZL2hpRjUvRjFnY3k4U2szNklra1R6OEtURmdTU2JF?=
 =?utf-8?B?RkE1OUxqdmJaNjZBa3o0cjdLZ2VSMkpSSW4xR1VaK2daVkVHTUlEVVVhS0lr?=
 =?utf-8?B?QWF2bzBLOWNjc3hqaVlMTzhya1dZdnoxTllzRW4za3U4VGZtZUFKdERtYmZM?=
 =?utf-8?B?dW5MdXdrUnRpSkt1OTJuQ0p5SzA2R3Y0amFhSmpvalJrcjg4U3BNaUxOME5F?=
 =?utf-8?B?eStRNk9QQ3d3dFFob1JTZkgwQ0hvcUJjNSt0OUJwQU5PQzFsUzZqd25rZ1NU?=
 =?utf-8?B?VjI3ZDU2M2hHUWswU2V1ck5zSDVRNUc1WVcwUER3WlFuVHBpOXFpTkd1ZlJ4?=
 =?utf-8?B?NEt4cmhHcm01TE5ERUxQTHcxSzRtU01jdkphbklSRU5uM0t5UlRCQk1Ca2VS?=
 =?utf-8?B?MFYvQURCVnZpci92TEN5M29OVXl4eTZ1Sy9OUFRjcm1KZUdwZCtUUlVPMEc5?=
 =?utf-8?B?eGJNWTJRU3YwRUdFdlQwN2d0dlMvTUNBVlFGL2toNjR1cVd2aUwrcDhOdHZa?=
 =?utf-8?B?OGNWdWYveEpvNkFjK2RqcllYdTZWZzVWTm9LUGZibzl6SDZjbi81M0Z3YkI4?=
 =?utf-8?B?QkNONXN6TDI1M1B0Z3lEbDJ4S0gvNVlNN1VEZjV6S1FTemZOOU55clI4M0lY?=
 =?utf-8?B?RFh0TFZJdGdlZ3JlMnNyUHc4MW51N3ZuamtIT1dGcXFuSGdmd3Q3ZldlbTJB?=
 =?utf-8?B?U0g3NTNNa0tCcXpBOW5KaTFKT05hSTZZODk5R0ZxRHJ3KytkN2pGQVNKcEdh?=
 =?utf-8?B?VEV6MXgrTHh3TXQrNkNDUGgra3B4bW4vY3JuQ3FsVzVsNGVxcnVwT2o4NzMv?=
 =?utf-8?B?VXgxekNGay9FcWFDYVExOWlUQVdFQjdJZStKMmR6cDl5d0NpbUNtMENoYU9u?=
 =?utf-8?B?L0dzVlQ3QnhUY0krYUJvWXp4blJVSVdSS1ZFN21aZWl5YkdCaVhuZ0pyTFR5?=
 =?utf-8?B?TTdkODh3YkJrQUNyMll1aEZ1ZllWYU16UXh4cU5PYW43UVhhWW9iY3F5TEJL?=
 =?utf-8?B?L1BpcHhJWU9mNVJIVmQ5enBkcVhVSWwyZjNNTnBrT3RWZHBQbm51MUZBQVRy?=
 =?utf-8?B?NDBoWEdBdlFWamI1aEZiR0orMy85b2ZqRmRjd2s5WVpFUlhZMnJlU25VMWJy?=
 =?utf-8?B?VnVjbnNpOE1DZlV2MDhhSjJZNjhIQW4zSjY3bnJWUWwzekRrM08yT0NHTzhB?=
 =?utf-8?B?OUFOb29DdnRSTnpxSTRVR0dtZFkyV3NVdWRsdVdpS3FPTVhEYmo2SnNnRHVS?=
 =?utf-8?B?SXdzTlhmbmFsZTU4RHRJYU83anJKTE9oNVFCU0tJS0JMZmdCSHRSb3RMK1hW?=
 =?utf-8?B?dHpxeTMxZUdEOEUyV2toZHNISVlzdm5JbGxTUEY5T0RSTmduaHFjOUNxVk5v?=
 =?utf-8?B?K0MwK3kvVFFuT3hMVDIvNEJiMTJWaGtGOEdzaUJ4eW5iOHNORHBBbmhZbEk5?=
 =?utf-8?B?VnVIWDI3TDg5alZ0WUFLUWJUczNOOTZsM1RSdmFwWDZKOXRzQ3QyWk0rb2kw?=
 =?utf-8?B?dEl3MVg1YmNQbmJFM2hMMUhBVFdjUDBybG1sSnJhOXZwWkN6TnlEWHc5Nzc4?=
 =?utf-8?B?NFZPdHZsbXl4SGc4OExZRnhFVEhGaEkrK1RxSSt3VkU0ZHVqZWNRZEpCVC81?=
 =?utf-8?B?MWZaYWNUUVZ2Unl5K3QwbWtidGZLLy9ISTNQOG5jT01lSVpLeWhtU215MmNo?=
 =?utf-8?B?cHhuSDNZOXlKelREM1lJbXZ4Y0FaRGs1WjB0MXg1WG1pOThzbGYwQjVOdTha?=
 =?utf-8?B?UTQ3U3NISnpsSWlqenBwdWtEcXVYUnh3N2lZLzl6Tms5bVRxeFcwZkVCT01L?=
 =?utf-8?B?QWlKemdHU3RGVkxRSGFMNFhmVmtoYlFSbjdTdmoxR2p4VFJzMElTM1ZBY0pI?=
 =?utf-8?B?QVcrdlNodTA3UGhON3h5a2czM1c3WDFlZ0ZXcnhqaDUvbFNYVnZ3VUV1Y1l1?=
 =?utf-8?B?U1JFcVRKNDVZUEFyczBSVU1nZnpyWUNOcWMxc2NPSHlFOFNGMnRHTU5zT0t2?=
 =?utf-8?B?TFQ2RE0rUC9VdzhsNFliajJUS2gwUTdSRzBmWlNnTU9BOWpaeGEyZGQyeVEy?=
 =?utf-8?B?VzBaQ1A3UmdxcEkyK3B4MXRIZi9jTWRhTnlPcVZhM2IvZk9iR1RLTzBlcU1v?=
 =?utf-8?Q?sG/RrlLevIMHi6A0e3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c411c64a-df63-4e37-374b-08df1ee66270
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:31:35.4883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Zd1Iwg37Rl52gZNWqAm96voqYr5SHdPFSNsf9fDKrycIcvxcx9rl/MEWzZYuDZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB432622
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

On 9/30/26 13:16, Sunil Khatri wrote:
> vmid_mask_gfxhub/vmid_mask_mmhub makes more sense logically in
> vm_manager than the mes ip struct.

That's the VMID mask for the user queues, so I would name it vmid_mask_uq_gfxhub/vmid_mask_uq_mmhub.

Apart from that looks good to me.

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 4 ++--
>  6 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 5285c1d1fd4cb..9c36ccf5d5659 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -137,8 +137,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	total_vmid_mask = (u32)((1UL << 16) - 1);
>  	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
>  
> -	adev->mes.vmid_mask_mmhub = 0xFF00;
> -	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
> +	adev->vm_manager.vmid_mask_mmhub = 0xFF00;
> +	adev->vm_manager.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>  
>  	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>  	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
> @@ -184,8 +184,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  
>  	dev_info(adev->dev,
>  			 "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n",
> -			 adev->mes.vmid_mask_mmhub,
> -			 adev->mes.vmid_mask_gfxhub);
> +			 adev->vm_manager.vmid_mask_mmhub,
> +			 adev->vm_manager.vmid_mask_gfxhub);
>  
>  	dev_info(adev->dev,
>  			 "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 594fb817e0a38..2b13a5b375393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -122,8 +122,6 @@ struct amdgpu_mes {
>  	void                            *mqd_backup[AMDGPU_MAX_MES_INST_PIPES];
>  	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_INST_PIPES];
>  
> -	uint32_t                        vmid_mask_gfxhub;
> -	uint32_t                        vmid_mask_mmhub;
>  	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
>  	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>  	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 98cdd7e3475fb..5f22c146e2339 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -413,6 +413,10 @@ struct amdgpu_vm_manager {
>  	/* Global registration of recent page fault information */
>  	struct amdgpu_vm_fault_info	fault_info;
>  	unsigned int				npa_vmid;
> +
> +	/* VMID masks for GFXHUB and MMHUB */
> +	uint32_t                        vmid_mask_gfxhub;
> +	uint32_t                        vmid_mask_mmhub;
>  };
>  
>  struct amdgpu_bo_va_mapping;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index d1cd665ab301c..178ef8dfe6d61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1080,8 +1080,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>  	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>  
> -	mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
> -	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
> +	mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
> +	mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>  	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>  	mes_set_hw_res_pkt.paging_vmid = 0;
>  	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index c0719d8fa63e9..f2dd4323ffd3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1042,8 +1042,8 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>  
>  	if (pipe == AMDGPU_MES_SCHED_PIPE) {
> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>  		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>  		mes_set_hw_res_pkt.paging_vmid = 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index 20159fb9d6ea3..c3e1f9a746ce0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -685,8 +685,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>  
>  	if (pipe == AMDGPU_MES_SCHED_PIPE) {
> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>  		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>  		mes_set_hw_res_pkt.paging_vmid = 0;
>  

