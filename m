Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71240CD343B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 14:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E7C10F182;
	Thu,  7 May 2026 14:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u1hWBuzq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF1F10F183
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 14:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1sO+dOxGBnD0PUznozt4LU/7C+yDOzprg6PK4SRDyZIpLyI//ZExR1V40xVlzdrK476C3dnNpJ9o9g453bW79Omj8PBB2qAAOmLFXnlBWu+Uvr37dknl7RxmXCwK3zbQ80EQ940Bk0J9YT8J5OjBDhQspUTH0yFGFj8aq3eIY6tnVLTO50NyWajMY1h2coE2d25e6ylyoQahsQ15YMmKQGnCSok6Yc4xxmXB3xskOpWCNfyynEFmAgYOIcnx+tkDPVKlLWD2bZX4MLxLr2l83gniuonVuZOiOB8pGvswo7TiJOWJBMI+1HbM+6DyIuo1QvAvLEBdR25UOJkQwnBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTIH1/rZ8d/tdajvuLlVdPy5snesSrPqbQGaxT/zucI=;
 b=HL2meP3/TV+ryuogT7oNmXj8m2OFYnTjwt7kWddYZOgf11XEqTuJfWwQzHb3D0d8+R9IbUWpNNgwYlEMJpk56iOBr1DU5UKSt2C93XlQnsm5w8HnL1r0nKbcnq2Ui0B927ZjmONzK4d30Bhn50GR2vwa0QW6S9PMKVgvAuo6PsZbpi1wBxbVe8YUIS0nHOtorH0B7JBDxdZX2BJJ/gERvX3N7VuNU2h/ecPZq8cvkxG61YAukA/okz5U0VZnBYDJtnAgo+h+bbL/cgNas8sa4dtdBZFVCpO+v1+fqmZ+RswIwS60eJb0tXnikBUwZdCIuseKU9DzWiVlsNoFR59VAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTIH1/rZ8d/tdajvuLlVdPy5snesSrPqbQGaxT/zucI=;
 b=u1hWBuzqdPgVT5k3Xx4NEqtEuJfkjnPsWxg6YCHH2UXvTce3P03cft7z46VK+e3ZKBnQZa9G4lfIzdE0IDtxL7bFOVIZFVTDVDpRorNflNTCvo5CeTRNpPAX10ZlccPQCfiqO32oSQPUtM37d8gfD2znK+XSokPdHDG/Vpsmbj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 14:45:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 14:45:40 +0000
Message-ID: <d1e60cfa-2e93-48ff-9af6-72366aba7e06@amd.com>
Date: Thu, 7 May 2026 16:45:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 "Honglei1.Huang@amd.com" <honghuan@amd.com>
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com
References: <20260507140934.1001909-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260507140934.1001909-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0410.namprd03.prod.outlook.com
 (2603:10b6:408:111::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cc00c2-ff63-499a-9d9d-08deac474e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 8dV4UPXjvw0rKlBQ1wX9uIYxbK3y0V7NN2fYNn00wFSKinjvPO1YbFDNhWRAbjysNDU4QFj1sno8abOi6h+z6KgGe5Yxh+BHCYCBXBsMRQg83uAku/y1C3jW7TTnALEfe+PLBhEhDas/WyEI5Kss2ts80Vz8uOoygGKe/gWQi0+6cZ9k5gL8nL2teg/efobItoEE1jDpnQsLIzY4v4gxJEkDUXjFgZOFH7XQO0HIuGzEZAmiv+TTfAveEPXIYe3Rs3aha9FC9z/zNOvdnXWM4bpnlZC8Fc3DbSqE9R/EvLkaetJZFpDkrYet4bi+Iucr1XyhNJABkIham79/h2xJBg2DQgDs9senWx1ukZ+ZZF1v/TE3/Yu/hGPO4Oim/IOocVXFGz1oU8CxtYdtGM7ETdr6NcSpTk8ciImIdKCLLhU4KKH2HXHjY/+rV8ZhvyGGFPq+wuR48OG7y5EFU7K369v+wq8JBBI3BpmTmITPnMenR1vtpAuZ1yIxjq+5+VX6U4AUETM34mWDOW3CY508QL6ivocRw/hg4yTtusMZTC3YJukBovbbkPwSXg7to78B3DCiiGAy5ZENcShTq6Y6kVSg/XzezTpZYk+BHyuny3FDSY2BMI2f7k9JKWnrjatU8r3pcq2f/kDPnMd3eyMShH0On7M67w+QbSb6y52SW1xxLART1KwyVty6tLypNfjn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNzTHhsM253bVlNS0h1N0d0RUp6dElIY1RLVXdGbm9ySDFjTVQ4KzQ1SklE?=
 =?utf-8?B?eEI3ZXU1VnZkRzV2Y3AxS0o5aUVUbkJkSDU5aytqdXBFdUZwUTlDZGJ6RnJh?=
 =?utf-8?B?c2xVb1Y0Q3k5c2NHUGs0d1cybFFod3hMV255NTNlZzRRQ01WekZBbWdZZzgr?=
 =?utf-8?B?aThISEs2NXQrU2sxUk9tcndaeEhIdWRRS2hZODFzd0JPeENUbk9lOTA5cVpy?=
 =?utf-8?B?cTZnSkk2L0Q4Tllaakt1N2dCS05aYjB6UTFoNVBRNkNUbllsZUV4U1huNkta?=
 =?utf-8?B?bmEvMnNET2QybGlTcHRVUUVYYVJxM0lCOTdiWHZ5T2lpcUJSSXBXcXI3Z044?=
 =?utf-8?B?TnZKRkRVSmNTWXcwWTZHT0pIbjB2akduY3VUK3RFMGRvYWJ5OWdwaXlIcnVM?=
 =?utf-8?B?RHlCSERyR0p5OE85eXVFQ1VNVXpGakpVRmJra3RLSmVPQjN5dUdWeUtla3gr?=
 =?utf-8?B?N2lscjhMbnRVRHpLam1MUkVPQkFpQk0xR1crbHNIYjliaVU3cWlGSER5a0tW?=
 =?utf-8?B?NElnTGw1WkpXM3BCQUR1bGxzRnZ0UFRvVDlzUFNVaEczT25DMDIyaSs3YkZl?=
 =?utf-8?B?eGEzQk9DVkp2akZ6bmh4dlhaSGhUejkvb2c0NGs0ejRMekw3eGJvUzYrUU5S?=
 =?utf-8?B?S2l3MGtFTHJ1SUVMenpWVmxaTmlFQUh5T29KVy9RZ2d6cWYvL0dWTUlyMy9S?=
 =?utf-8?B?R0Y0MENMaklzY0RSQWZ5UHRYRFQ4RmNSQ3VCOEk1ODYra1p3d05hMGJrMlls?=
 =?utf-8?B?ejlqd3c4VGhXS0tTYk1wSEdEaVdZR285ODNqandXLzRxdGpSWjl1M0ZxMlV0?=
 =?utf-8?B?NURLeFNMaldiMjY3Unh4elNuTkhmeDJBbUY1cjdvMXVvZFE1RG5ZQW51Z3BU?=
 =?utf-8?B?dm5xUUNOVWpkU2pHdUdoZEUrdVM0T3ZHYTFJMjdhamJEcVI0K2NyZHBvOUxI?=
 =?utf-8?B?RDJCY2xJenB6NlpOMExmWlZSTllxVU4vMlIvR29URUVKNFp3RlFidDUxamFv?=
 =?utf-8?B?VmhBY0doczBaRjhXWlF5WHMzOGJpaHJwdFpCN0VXRjJHb2xoZTQ5TTJXUXZS?=
 =?utf-8?B?M3p2ZzRpbzV5b2JJczd3cjZGNmgzNno5T2JOTnk5ck9DRU1MUjJyUElwWE1y?=
 =?utf-8?B?MVh3dDlUMWxjZ25kZmtoT2t4M012enBBY3Vld1pQeEY4YmI1UStIRDZLTTBv?=
 =?utf-8?B?bVB6bUhBMCtVckpkbUxFMHQ2ZlgyRDlTV0d5cUlxcldBNFE0SEMzUFVNSkNN?=
 =?utf-8?B?MGI0NE9pSko1SXNmVFprTVdxTlFpWDhWMkVjVUM5aFo2ZkxvZlEvaWwxNktz?=
 =?utf-8?B?N3YwK1hXOUVtbWtKNXNDYUZrNHRIQ3BndjJSeENUcVZqT2lMZmJacnlvcWxP?=
 =?utf-8?B?TUt4UWRvNmNHTUVlMjc3V1hSQTJHN2xBbi85VVdCb0JjL3BuZmhYMklsUUZi?=
 =?utf-8?B?a21wenBvNVlPRXVGdE5zcUdxQmxtNmc2TUpvak5rZjNsUFZxU1R4b1c1aEhZ?=
 =?utf-8?B?d3dtdmd4QU1RQVdmTkEyWjh3QXJhTG9RaitJcjFHbnVZWVlBUExDN2lvQk5O?=
 =?utf-8?B?YWFHdVYwaXlFR0JYVzlwUUdwOUhJUk8zT1BVd3RsaXBGQWt2UnBaUldCd09I?=
 =?utf-8?B?ZE1yeXZzRmVtSXI5VVNZNm9QdmtxZDQxNEthZEZVeEZPQitkM2lzSzNEcDJE?=
 =?utf-8?B?MzQxK1BjaXdWYU1TbHpWV09EUmVNSDRGckNCR3EvOGM2ZTRDVmFyY0RKWWIz?=
 =?utf-8?B?YkxUSkRJekMza3NuWGYwSEJGUWpnOFI2aStVaFptUi9vZ2Q2Zkh3N2hiZVI2?=
 =?utf-8?B?dDNHRHMxQW5nT1pXazJBS1ZUbWZjOVkvNUpDeEhFSWhzUzYrZzNSSERMRG9P?=
 =?utf-8?B?Z015QzVYclpSVkxRSUVIY1IzMGY1VlYxcE9ybW5vMU5MWGMvY2lnWE5nL3ZJ?=
 =?utf-8?B?alA2YlV5cXNMYXhXWlQrc3BXUk9SOWgxRFBzSENnbFpsMEU2bWRzNjJWeXNm?=
 =?utf-8?B?N3JJbUo0bFlnbzNIcy9GYzJLSlRNRWI4UUdtVkxWR3l6V0VMUFZIaEN5NDMr?=
 =?utf-8?B?SlRoQUs1MTRtak9hWXhFbzBMcjJJc25HRHZzSGN5MlRWT3gzd3JrUmRTTzZY?=
 =?utf-8?B?elJBZjRRbS9XdE9ORXVmSTByZnpsUkJpcC9iUjFsMXAxblJQUmQxVnM0WXNy?=
 =?utf-8?B?VG4yM0ZXcHRCbFdlb3gxRmE5Vk1RdWtxT3RqbXk2UmFYUTVTVTJpSmFCS0ox?=
 =?utf-8?B?czZ1c3RkOHhpbnNmb0JtOEFVbGZibEg3VUwvYlpMZm91VEtZbmJpeVhNVnpp?=
 =?utf-8?Q?Dn2lLqJyPAjAI17rdQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cc00c2-ff63-499a-9d9d-08deac474e77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:45:40.2641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcqX7tdtgLzm6SDR5vJPhJ3is/mHFWYaK147YCHhz0DCe04YhCNjTmODmKeTuLlL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738
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

On 5/7/26 16:09, Yifan Zhang wrote:
> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
> inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
> this window can result in uncompleted PCIe transactions, leading to NMI panics or
> system hangs.
> 
> To prevent this, Unmap all of the applications mappings of the framebuffer
> and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
> during the reset process.

I think putting the inode into the kfd_dev would break userspace, so that is a no-go and needs a different solution.

But apart from that the patch looks like what I suggested before.

Question is since when does that issue exists? Previously we didn't had to take care of that.

Regards,
Christian.

> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 12 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  7 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c         | 17 +++++++++++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 10 ++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h           |  3 +++
>  6 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 2bf6a31c194d..5333e052d56d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
>  
>  u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7c01492e69dd..3ac2bd86c08b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -139,6 +139,18 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>  	kfd_mem_limit.system_mem_used += size;
>  }
>  
> +void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
> +{
> +	if (adev->kfd.dev && adev->kfd.dev->inode &&
> +		adev->kfd.dev->inode->i_mapping) {
> +		unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
> +			KFD_MMAP_TYPE_DOORBELL, kfd_doorbell_process_slice(adev->kfd.dev), 1);
> +		unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
> +			KFD_MMAP_TYPE_MMIO, PAGE_SIZE, 1);
> +	}
> +}
> +
> +
>  /* Estimate page table size needed to represent a given memory size
>   *
>   * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 073f632f295a..c67936d1fb0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5019,7 +5019,6 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>  
>  	/* disable BM */
>  	pci_clear_master(adev->pdev);
> -
>  	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
>  		dev_info(adev->dev, "GPU smu mode1 reset\n");
>  		ret = amdgpu_dpm_mode1_reset(adev);
> @@ -5840,6 +5839,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	/* We need to lock reset domain only once both for XGMI and single device */
>  	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>  
> +	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
> +	 * accessing them
> +	 */
> +	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
> +	amdgpu_amdkfd_clear_kfd_mapping(adev);
> +
>  	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>  				      hive, need_emergency_restart);
>  	if (need_emergency_restart)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0071d6957828..1dd343f0219f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_reset.h"
>  
>  static int
>  amdgpu_gem_add_input_fence(struct drm_file *filp,
> @@ -118,13 +119,21 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>  static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  {
>  	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>  	struct drm_device *ddev = bo->base.dev;
>  	vm_fault_t ret;
>  	int idx;
>  
> +	/* Prevent new mappings from coming in during reset */
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return VM_FAULT_SIGSEGV;
> +
>  	ret = ttm_bo_vm_reserve(bo, vmf);
> -	if (ret)
> +	if (ret) {
> +		up_read(&adev->reset_domain->sem);
>  		return ret;
> +	}
>  
>  	if (drm_dev_enter(ddev, &idx)) {
>  		ret = amdgpu_bo_fault_reserve_notify(bo);
> @@ -140,11 +149,15 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  	} else {
>  		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
>  	}
> -	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
> +		up_read(&adev->reset_domain->sem);
>  		return ret;
> +	}
>  
>  unlock:
>  	dma_resv_unlock(bo->base.resv);
> +	up_read(&adev->reset_domain->sem);
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 84b9bde7f371..d5bf5ba73ca0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -130,11 +130,21 @@ void kfd_chardev_exit(void)
>  static int kfd_open(struct inode *inode, struct file *filep)
>  {
>  	struct kfd_process *process;
> +	struct kfd_node *node;
>  	bool is_32bit_user_mode;
> +	int i;
>  
>  	if (iminor(inode) != 0)
>  		return -ENODEV;
>  
> +	/* Save inode in kfd_dev for unmap_mapping_range */
> +	for (i = 0; kfd_topology_enum_kfd_devices(i, &node) == 0; i++) {
> +		if (node && node->kfd && !node->kfd->inode) {
> +			node->kfd->inode = inode;
> +			break;
> +		}
> +	}
> +
>  	is_32bit_user_mode = in_compat_syscall();
>  
>  	if (is_32bit_user_mode) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a6ff1db477f9..bfdd7d3bc7cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -373,6 +373,9 @@ struct kfd_dev {
>  
>  	struct workqueue_struct *ih_wq;
>  
> +	/* kfd inode */
> +	struct inode *inode;
> +
>  	/* Kernel doorbells for KFD device */
>  	struct amdgpu_bo *doorbells;
>  

