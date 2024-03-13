Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2143DC54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 09:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93EF10E9F9;
	Wed, 13 Mar 2024 09:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s/Sdbfzb";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6B810E9F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 09:03:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwvOG5rtRAXbqF6GFkXbc+qVJtrpQR6bcKCAcOPXv/rEEALwzqaycltgBsKsUFFnN8xQvbDHmKYxysqbIuuriGaPBAe/XQCDYK0OQLGvp+iyHA0BbuNYevXaFbnp5jLRdP5hb86WVp7ucllXwEp4zKuSnfBJ/07ekwNN6THMbLU0gTqyzIKPgb6Kp7SDABkmhEmpHW3EaCO/2VGk4xr61UQMqkW6gB8Qifm5Yr6mWHma17LLYcWEpHCyV1Eqz4PpE//CSwORHU8ncbRkQBx7hMxH0gQHGXA2UDD21gxE8nh2TUMdPFJaKap9yeOJMNU8UgIMmtwx0cEh3UbyDLgzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKOAQNiPewN7+axl9prVrhf0qxnWqObljYd/AjxGRIc=;
 b=FVEmT1HOszImUEV5jghLDwSPVEIE0vQp9VTKfr2+F/61jVky92PFEXBOO+iP3q10jP5NM4fK6lE4kKRpMsRH8Jp/v83w6ZAy0kauSH9N9GVRgfR/VNh+jwEFY/02uYy67erK5b1hc1k3X1Z/Y4h1vfEppVgiEiykHY2vYcizUxG0abwhAZr+THkd11DE5Ts1/6z3X/HTXS3PJoL0hyPP/B5cynlcOf6PYzfvdeJVlFN3/6LSggaEqzSu2WnCuolGDKrdLSJYj/dButvuaUvGHDIEFoluGbeO6UhvNi31+eAA22pLMYjNh9w86uhvS5pszRvXjpT7YBcu/EhIKB9Zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKOAQNiPewN7+axl9prVrhf0qxnWqObljYd/AjxGRIc=;
 b=s/SdbfzbLONiWOg18SI0AWMQUqG3sUiDJtWpl4SaSJ+F7DvSQb74hJIW4cnoolFYbrLwZz2pg01aF/vT54JVjF/GsSydwZOGwIpYaNRGRabXa+j6Mbrhufrib+QrM33HUBFp3RLiShuSBxATt7n8le3pe5OHnyZMOkwCWb9KrFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 09:03:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.031; Wed, 13 Mar 2024
 09:03:34 +0000
Message-ID: <0ae89ff0-3af0-4eb4-bed0-f07a01723a66@amd.com>
Date: Wed, 13 Mar 2024 10:03:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/: Remove bo_create_kernel_at path from virt
 page
Content-Language: en-US
To: Victor Skvortsov <victor.skvortsov@amd.com>, zhigang.luo@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20240312175059.141019-1-victor.skvortsov@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240312175059.141019-1-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 9529d8df-fcc1-424d-dc10-08dc433c7632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqXihtdJLJ/iDc0vi3SCjR6cb/ktKWk6r7yfn1SCUC9FCm6PiqYXL+WTggL0oVRwG4maFE3ay/EadkZVDwa4aLmx00oBlNamzJq3VGLVnnjQ2N6DTqz08c1J0skiA5PzevKfW/Gfpf+PGmHaxszrTK5vMV1/rpjggOhv0g0lbIQCZ5Ck4gnzkw4CCiB1Acpm7u0g2urktpTYaTPBoKTQyY+FGervberXA7sgV3tpWdLG0yx6nxntiKswqI5NvSvi1z/46qZFzORdoHNmrg29Bw29IUZvrJ/OOvCCS8Mf4TIwyH9tldZCAwwKg88O2vmj9h3tFM1WvnDu46tIOVHoKQ8H+wemdF08jMraxUP6qBAHOTk0Q8JRMzgn2kbvx7kvpxsiAD7QzMwsacLj7yMDDXKNwtlEikU6mzfff5JXpFrHTWIEzWGKjDipHQ09rUmwnUi8CHJn0tBMWYIr44zwd+KzwVQyJm4wZzQYhcK+kRPd7u2C4+3Zesau5IvwLm8jmS1TfbO9ERhwCoWbe3Tv7niZFT5URLVp5SpIbNnkulxiHrSs/47RvcUtB0wpwECFAoxblBG/NMbtqmAaU3+HL64H844WUTVLLXMOriwfRpRxgkUvhvyVCQVT7hj3sfrZgemzYU5sPIEdTOW/dhFckoAvpeK80t+25r1+lFd8r2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djBkNUFidDVnNllvaHJGS25wSHlSSFM5S0l1NE1ZMlIvbTZINnNVSUZ2Vmkx?=
 =?utf-8?B?cEt5Mkk3VHBUMFA3K3V0VkZUeHBHZ2V1MlpjTStCQzh5ZllhSkZtRWx3ejF3?=
 =?utf-8?B?V2Ftd1VlbitxOXRXMEk1clpNVjZXallzRnQyVWVtNEFFcUFtUkxNWHcrYm1R?=
 =?utf-8?B?aEhGZ2Y2M29zdXZJQkJFcnhUcjlvYkgvbFVZc25taTNFMzltTzlFU2FNUldQ?=
 =?utf-8?B?ZkVxYTBWN2piVGlmekwvUVZUMHovREZyTmUrOEFya0lBRStta0VCN0p3VHNh?=
 =?utf-8?B?THpkYlA1L01GbTZpQWpvSHZSR2NTSU5PVitjcWxqVklYelBBWFVmYjhQUitm?=
 =?utf-8?B?MCtFM0pFQVJ6VUYzN0kyZ0o1SE5OaHdBYkZyeDZPNUlUS1RQOG1TVW8vazBM?=
 =?utf-8?B?R1AwZU01ZTYxY2dWbCtLY3ZYYkVETlBFYm1RbXpxZ3E4WVBiOFUvenBJdGxN?=
 =?utf-8?B?dWVWWkd2TGlPSi9JbnZRL0d6VGEvbjB1M3p1L3RPU1VLV0VBRWN5TEVBT0lh?=
 =?utf-8?B?akVDNTBrRGVjaFlHZERzaExIZ2NkeEM3TUpsSzBaNy9UcGgybUhrYmtKZGNp?=
 =?utf-8?B?WnZWYzVBdGl4VzdGYW4xcnd4dldtQXZFQmZCV0MxMm5tSlp4ckJ0aU1VNk1x?=
 =?utf-8?B?ejM4NFNMRk5RUmpkNGxVWUIyR2M4QUpEUXg0RkpOc0VMT0Q3SGk4WDgrclJ1?=
 =?utf-8?B?YlAxbWM4dWM2VkFzdW56RWFGcTA5S2dGc2lVb3dLa0dkd2JDbS9EMU9WT0FR?=
 =?utf-8?B?N24wRnpVSTZSYnc5MUlUVmh1NzE3Z0ZOK1lrWE9xZ3ZUdWRoZ1VpRUpVcXNJ?=
 =?utf-8?B?RlhhZVVoVXhCSFl5QmR4Vms5bkpBNUo4U2JXRWVaWFpmLzRtMUlET0N3bFZB?=
 =?utf-8?B?YlhxZUtVUUo5eHBIbHE1dzJsTSt2NG8va3ZKT0M2Y2lQN3lvTUVJcTZ4Rzha?=
 =?utf-8?B?a1Z4K20rZmlIc1FtckVQeDFYMUsvbFU2anh0YndydnFIa3JpT2pjTEpka0lF?=
 =?utf-8?B?R1BVOFZqTDE1U3RnVXlqdnFlZzZ2RFpXcEVycEdsODZMQkhCTlhOSUZxVTVY?=
 =?utf-8?B?N1Y1YjV5dWtJOExWRERkTk1ySUFoUjBBQ1dGZ3RHaXNmc0I2VTEybUdOeWxo?=
 =?utf-8?B?OXB1UEp5eXdwZjN1UUwzYkdnbDcyekpObjZaOHJEQU9oS1pHOVFsUnJ4OXBz?=
 =?utf-8?B?Qi9nUVJWZjB1QWpsTks1MDQzMUUvMWhCWWhTNXNzQi92OFdwOEtlcVM3c29W?=
 =?utf-8?B?SGhQTzlnZFFKZ20zdGZhZlhCb3F4WEx2Qm9td3lFZGMxQUN6dXcyQU5XYkhS?=
 =?utf-8?B?b0gyTWV5K0xhMkl1YS9ESDVXMTlnQ1I3K3BweEVGUmxRTkh3V2lwVFhEcjlI?=
 =?utf-8?B?SkhTMGcwR3RuRHJ3L3RacmtVZUhJTW91elVucEROWnNhVFhXMlpkTDlBY2RI?=
 =?utf-8?B?aTFhb281QVhqUTVFMUwwL296SDV2RE5qVURTdittdHQrenc1TUgzKzVnWjl2?=
 =?utf-8?B?NmtBbjNOR2lVcEFnTENiWlA0TVlXWkpZTzNzWE1RUHQ0eGVHOW9zd2dpYlJG?=
 =?utf-8?B?cGdjNVhHVWtRbXcvbGZBd0ZIKzhzYW94VzFmQkc0UjZvdHlDUGpKeXh0YmF4?=
 =?utf-8?B?SjhEVHU1WmdnRDIwSGcybzJRL2RPT1ZFM21EbU5mUTRoZmUxZi9oOW9zaGdN?=
 =?utf-8?B?RFhwUXZwK0hSalBKZ0xXUFVmNmtyZ25rYkVEdmtZUng5MmdzZXhZNXg1RWxl?=
 =?utf-8?B?SElmK2pHSEttaDdVSW5JQk1Pc3NlbFhGZDRVQUY1U0M3eWhzbmNOWnBSNVBQ?=
 =?utf-8?B?QTJnSVlHZ2U3aDJGdThyNEFRUjQ4Z2RHbEQ3QUZEblJtbFQ1TFVESE0xcUlm?=
 =?utf-8?B?UzNUeU5XODRQUThUa3dmRUlGNFdsTVY4S1IyeVFIeStWRm5STmN4TGorclB1?=
 =?utf-8?B?L1Y4aStqb2ZGWGZZbEtRalpiTkJTNkx3U3VQYUZvN0VNeDRGTDU1SzM5cHpR?=
 =?utf-8?B?UktGTjZDWTQ2NWZSMzlzV0VON3U1U1lYT0lmWmxQMkF0a1I4MHREc090dlBj?=
 =?utf-8?B?NUZIQUhBa0xkeVR2ZVRiN04zbVNlUnludXpzQkxOWXlXS1lGelhnUWZvWGo3?=
 =?utf-8?Q?aXyZDt5jx7FQzDfz9/UMe8WA4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9529d8df-fcc1-424d-dc10-08dc433c7632
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:03:34.2519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfyvikNY++5UfuHOqbxxYIg9SoL3NCqPo/xVu8hLBa1hLjT6ICOWHpqXRcZlzreR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
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

Am 12.03.24 um 18:50 schrieb Victor Skvortsov:
> Use amdgpu_vram_mgr to reserve bad page ranges.
> Reserved ranges will be freed by amdgpu_vram_mgr_fini()
> Delete bo_create path as it is redundant.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 55 ++----------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 -
>   2 files changed, 3 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 7a4eae36778a..2a20714b9c16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -244,7 +244,6 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>   	 */
>   	unsigned int align_space = 512;
>   	void *bps = NULL;
> -	struct amdgpu_bo **bps_bo = NULL;
>   
>   	*data = kmalloc(sizeof(struct amdgpu_virt_ras_err_handler_data), GFP_KERNEL);
>   	if (!*data)
> @@ -254,12 +253,7 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>   	if (!bps)
>   		goto bps_failure;
>   
> -	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
> -	if (!bps_bo)
> -		goto bps_bo_failure;
> -
>   	(*data)->bps = bps;
> -	(*data)->bps_bo = bps_bo;
>   	(*data)->count = 0;
>   	(*data)->last_reserved = 0;
>   
> @@ -267,34 +261,12 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>   
>   	return 0;
>   
> -bps_bo_failure:
> -	kfree(bps);
>   bps_failure:
>   	kfree(*data);
>   data_failure:
>   	return -ENOMEM;
>   }
>   
> -static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_virt *virt = &adev->virt;
> -	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
> -	struct amdgpu_bo *bo;
> -	int i;
> -
> -	if (!data)
> -		return;
> -
> -	for (i = data->last_reserved - 1; i >= 0; i--) {
> -		bo = data->bps_bo[i];
> -		if (bo) {
> -			amdgpu_bo_free_kernel(&bo, NULL, NULL);
> -			data->bps_bo[i] = bo;
> -		}
> -		data->last_reserved = i;
> -	}
> -}
> -
>   void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_virt *virt = &adev->virt;
> @@ -305,10 +277,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
>   	if (!data)
>   		return;
>   
> -	amdgpu_virt_ras_release_bp(adev);
> -
>   	kfree(data->bps);
> -	kfree(data->bps_bo);
>   	kfree(data);
>   	virt->virt_eh_data = NULL;
>   }
> @@ -330,9 +299,6 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_virt *virt = &adev->virt;
>   	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
> -	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
> -	struct ttm_resource_manager *man = &mgr->manager;
> -	struct amdgpu_bo *bo = NULL;
>   	uint64_t bp;
>   	int i;
>   
> @@ -341,26 +307,11 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
>   
>   	for (i = data->last_reserved; i < data->count; i++) {
>   		bp = data->bps[i].retired_page;
> +		if (amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
> +			bp << AMDGPU_GPU_PAGE_SHIFT, AMDGPU_GPU_PAGE_SIZE))
> +			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
>   
> -		/* There are two cases of reserve error should be ignored:
> -		 * 1) a ras bad page has been allocated (used by someone);
> -		 * 2) a ras bad page has been reserved (duplicate error injection
> -		 *    for one page);
> -		 */
> -		if  (ttm_resource_manager_used(man)) {
> -			amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
> -				bp << AMDGPU_GPU_PAGE_SHIFT,
> -				AMDGPU_GPU_PAGE_SIZE);
> -			data->bps_bo[i] = NULL;
> -		} else {
> -			if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
> -							AMDGPU_GPU_PAGE_SIZE,
> -							&bo, NULL))
> -				DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
> -			data->bps_bo[i] = bo;
> -		}
>   		data->last_reserved = i + 1;
> -		bo = NULL;
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 3f59b7b5523f..15599951e7b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -224,8 +224,6 @@ struct amdgim_vf2pf_info_v2 {
>   struct amdgpu_virt_ras_err_handler_data {
>   	/* point to bad page records array */
>   	struct eeprom_table_record *bps;
> -	/* point to reserved bo array */
> -	struct amdgpu_bo **bps_bo;
>   	/* the count of entries */
>   	int count;
>   	/* last reserved entry's index + 1 */

