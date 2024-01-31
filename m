Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E43C47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 13:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5290D10FA1B;
	Wed, 31 Jan 2024 13:39:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFA710FA1B
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 13:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO9N4M2+VnpdjH1zS//bt3BFNwFoecsZUvXuB/PyQ1Dh1cdF0uWDRn9SmoxtdnZ98lSkBGVeSozy/FN+jack/ltdd7wLaiaMqELz4sMWeOLiUUNfwozPwNJGF/t4PYm/H/hcQ4mPr/DDBH9LEcfxRWp1XNlmhSDl5k6xw3ZRnKUdgpQEkgMTyoAj6AZvBL5MSyCF+KJBUPR0CE79bXtKG6Pe4i3by6GZw//dLoeXCOycwvT4uUmKGWXd/yI9Uoxby84D3jmBi0ngBLUoMDo60924GFX1JfhoT3uwHTTbZQfePuFp1AnaT5ZEPy/wkZn5G9isIc0SS2AHPgy5RxmySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcubol6Vh2mD4gNk+8Y8PDKR2gzhCRpMKuUKniuEPSk=;
 b=N03FB0M4goPB+QDdIAr/EEypaLbpCbzr91FZtXa6123WPoKFzTyXiQbgTXtBovRt06nicrgIFFz2udlVOSsGqZDAbfK/J1vWm1tPVWZnPQjEJnWpLQdbl1jw8SkTnP81ZTrrJOJMLJW4ebrp9FWXGv+KDsnQ2Krs5NMOLnK/EfyqfhqXherYz3BnjdPsufP9wRhIIb5Aey0mdy0EkeB8XklOG/XnjQTPwKBhqczj/39WfYFuSi1Sd91KYC+XuNtE8KnzRpxGQllnKceDm1kCG3Jdib9oQ8gi1NLLzGa/2PeDgVTz6q4VgzohdwueVHad/kp8j1Fjf1XsATdgdKzHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcubol6Vh2mD4gNk+8Y8PDKR2gzhCRpMKuUKniuEPSk=;
 b=whNcEU7zaw7lY/qDpXgrVbR31PYwirxxf0j9uPxtECXP5rK+sbMyk58guVRwF961xTSe+pOW9Wlyjj3VJ90V0wHi1vSr9FMGNRr2o/apy3HDdZaPp3EPgu80U9GYlF+X494CgXcYrzVnUyl45KZ4WvasQXoH4MaGf5+BN6I0sJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 13:38:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 13:38:50 +0000
Message-ID: <fd834844-a836-440f-9b3a-1e1e944e8ed2@amd.com>
Date: Wed, 31 Jan 2024 14:38:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Relocate TBA/TMA to opposite side of VM
 hole (v2)
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240130200810.2434013-1-felix.kuehling@amd.com>
 <20240130200810.2434013-2-felix.kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240130200810.2434013-2-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 89938abb-bb38-44a0-80f4-08dc2261f528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHVKgS8gxbKDEpcEVjFbGsSw1w+LPG0DU269rCgOmQuNRVlzwnVXU37V2eeSn74vYG+f1eFdIf7L8im0UTUxVzKHoTaEmE/q+Yb/WTACiR7AEukQXXuDJ3hkMgFt9v32X4nRRvrQLZGTMAuEPXcIymb7FODJpyH4FgvL/c0gHrpQvJgLk9BU2uSXJMNInXSgVzDPZed9s9r50sbICtoDTKeuYX9V82FP9aJJOCRIt+JfViGExWouNhoHWuH5gBHZ100lLnH3eYy+n4oh4cSbxcs8Yh+NIwLZQOKnLQSmIC4Mjh2/9s9eGhywJKsTmh7y7z6Nu9t9GYnxlikoEph5SYzSy1PMgsh4CZvPPRd4eJ7EEowW7+JpgY95rzlsrYtjUIsnq3Bstr2MxwQ6zzLqqc+eqL07Bv6VpRKMvQkJdPTQqtaYnXZgKVe/lQQBcLgPzRk/zAEY++gK1IvxVWCXj9yjkKNe6Itgurb5ytnVR/YrWf3mNbIxj13nAmnHKuXOC4RdmR4dKfSzEyJ/QEpvw+zTjGJE9zrkyLu7iOberZ6fiBJEmNdIZrZHxsJ1zbYYLPOlhgZM0+JDAcVMJolqu5MKcekGSPBrwg/r/oHSXOJ7+1UckEOtCnB7k4/2d5Oma6m3GS7it5gULwzeE4SLoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(6486002)(2906002)(6512007)(6666004)(5660300002)(66946007)(8676002)(8936002)(2616005)(4326008)(26005)(66556008)(316002)(66476007)(6506007)(38100700002)(478600001)(86362001)(31696002)(41300700001)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpFWjNFbEFadFlpeFAyaHNZQTYyZDJrMkhnL2c1ejQ4RnB1YWNBREVoMGZM?=
 =?utf-8?B?d1RZNlZ0emF5eGtCMm9tbkVwYWR6bUU0WHZraC90cE4xN04yL2VRV0RHaHVC?=
 =?utf-8?B?UWthTzJLRGUyM29nN1ZGK0g2Nno0RWozL29TU0thUmhxak94MkdqQi9Zd1JT?=
 =?utf-8?B?cmNORC83U0ZSZWxGNjZZeHIxYkRXZlRSalJHNUhyeEFlQTYrVExUNllvY1BR?=
 =?utf-8?B?YUdjRFFqbnRMZmJwaEtPQm5icGhzU0VBeHRua1BEZG1odUVuaElldUZwTXZ0?=
 =?utf-8?B?ank1Tnd1K1hTMFVvajVwQXVDa3dYb2psQWg4ZWZKUk40NmFrWGpIQnl5Skh3?=
 =?utf-8?B?NmlKOUFLQUdWUTFIaUxOdW9NRlVOczk0b2dWaE8yTUJjTk45b0Q2M3B0WXFL?=
 =?utf-8?B?VVVRdnF5c1VzeGdoQUIrZXpIOHJyTmFpT1hXTWp2WGZGZWJGWUlsY3pya0U0?=
 =?utf-8?B?dU8xYnF0b3hGa0podWR5MlluMlkrbG1yaUlVS3JhWEJMTEFFcFNLOWxTNktq?=
 =?utf-8?B?SmxhYUh6NERLd1ZQN0xLbVhGaEpnNFFLVG5keml1cEFvMGYzdmNaenRWZE9o?=
 =?utf-8?B?RmhZWWFkc05JWi9SblZuVFlHeDhabThpOCtlbFBMelplQzJkVjBheWZQWDRG?=
 =?utf-8?B?SHFtclZiT1YvK3hSOUVLMVBwQ3Zabm1sQVpUak5IbHVLbjRKYW9abXRTVFda?=
 =?utf-8?B?andRSFdSVVJaNGtHVlkxeUs4bUFtWGMwNk9WTG84M3dzdldSREwwQk1JSDVY?=
 =?utf-8?B?RGVnMit1YUtoSm16ZlYvT2JZd1NwVGozWTBjY2M5a2RvejloYVQ4WWc5SmJN?=
 =?utf-8?B?cVBrQmJoK0Nla1kySURtUzBjNUZFaUptZDQ0aytRbzJNQ0xYWVJZTE85RFA5?=
 =?utf-8?B?dkNiN0gybVVsQ0NMb1VNejdDNm4zL1JTaUV3VnVSRnYvRTlKYUlwUmRoT1dq?=
 =?utf-8?B?dUFlZWxVSWRGU0pWQUFIU3NvcFRCZ0FJNHZQbzE2UnVadWUrRWpyN0RCV3Uz?=
 =?utf-8?B?VmZVa21pVUpJb1FVNys5SENlVjlpdzF5eUgwTVFCSXJoSmFNNExLK1IrY1RV?=
 =?utf-8?B?b1lUakZhSnk4NlhvdSt2dDVCcDMyMDZNOHp3QW5BaHdQSDh3elhHMDRkTVM3?=
 =?utf-8?B?VUQ5WFlucjYyWkRqMzNDbTR2YlR2ZXpCajhnZ284V2xYdUJZRlhsWHgrY1R1?=
 =?utf-8?B?N3dmcVpKZHErTWFleUFxVUtSN3ZZYzVYK1JDdkxWa1JKcVZuU3RXbDR6VFVp?=
 =?utf-8?B?d05nUWl2VFJ1NHdQcDZLNjNkTlhxRDdzM1VDbXc1SXZYOUVlNWZuOEh6ditU?=
 =?utf-8?B?MmVYZE5sTThTanliL1VuVCtGOXJrV1NyQ1BXN0pYVHZ1TmFqRHdhUm9rblJH?=
 =?utf-8?B?dEUzT1ZzcjdZVkh4S0o0VE5XbE9Sb2xzY2dxOU9ZdGVjSXYxdndleXRtWXVx?=
 =?utf-8?B?MzVoaldVUzNBNGV4TFFYSHA0MzYzOEJ0cThrQnVlbjJQd010TzhpTmRmdDEy?=
 =?utf-8?B?TC8zRlNVMHFQN3RJakk3bFhlTmtuTG41NktKb212ZmYveFNpQlhmSDlOdXdB?=
 =?utf-8?B?OHo4WlNFVmFSRVY2NWIrVUs0bVROcitJYkVDeExvaktWL3dhU2pqVUo2OEsr?=
 =?utf-8?B?MkR6S0xvZllZUGtLcGc1empLTHNKREtsWlRXZDJDTnNsdkhYRTV1alBDbGdw?=
 =?utf-8?B?eXdnNW9GVmpvcmtvZGgxNzFQS202QnBCTDY2Unppbm1GUkVnemJ3MTFhTmFz?=
 =?utf-8?B?b1BpZjNIMzh4cUlhL3lZKzZxUC84aXpOdUF4Tk9uMDJqbmNyT1pHMkhuR0Ev?=
 =?utf-8?B?VHNtRGQzd1JqRHlEK05QYzRRUUZWMjh0Y3lzeDZIaDNOZU04OTc5QjhGV25G?=
 =?utf-8?B?cVF6a3hFVEp5VEpmMDNJMXloOHprdmFSTEdKdmpwVndqTXAvYkwyRVMyZjVa?=
 =?utf-8?B?K2hrbkRkVVJadVF4b2pMY0phb2ZSQTE1WkhDOUZGcHJNNTcyYjZMSVVWa2I0?=
 =?utf-8?B?a2wzMGl0cThKVmZNQXB6OSt3QUVFM1A5d0E3bWZrbXY5M1FhTHlNNjNhenpR?=
 =?utf-8?B?RS8yanlFak9SbEwvNmUvUlArRUZ3WEVLeTZkc3hlWElLMEZIR2F4S2FRUEZq?=
 =?utf-8?Q?olZdEzKv0i2DxS8M4uAIIEKXp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89938abb-bb38-44a0-80f4-08dc2261f528
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 13:38:50.1179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPMlN9RH8azyDOqRy1z4+kYuaPrKkvXEnxuDoLiuCMDCBdBLkYmWCCOznsS8DPIs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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
Cc: jay.cornwall@amd.com, lang.yu@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 30.01.24 um 21:08 schrieb Felix Kuehling:
> The TBA and TMA, along with an unused IB allocation, reside at low
> addresses in the VM address space. A stray VM fault which hits these
> pages must be serviced by making their page table entries invalid.
> The scheduler depends upon these pages being resident and fails,
> preventing a debugger from inspecting the failure state.
>
> By relocating these pages above 47 bits in the VM address space they
> can only be reached when bits [63:48] are set to 1. This makes it much
> less likely for a misbehaving program to generate accesses to them.
> The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL
> access with a small offset.
>
> v2:
> - Move it to the reserved space to avoid concflicts with Mesa
> - Add macros to make reserved space management easier
>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  7 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 10 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 +++++++++++---------
>   4 files changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> index 823d31f4a2a3..53d0a458d78e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
> @@ -28,9 +28,9 @@
>   
>   uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)
>   {
> -	uint64_t addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
> +	uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(
> +		adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);

Maybe move the "adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT" part 
into the macro. That should be identical for all use cases.

Apart from that looks really good to me.

Regards,
Christian.

>   
> -	addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
>   	addr = amdgpu_gmc_sign_extend(addr);
>   
>   	return addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 3d0d56087d41..9e769ef50f2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -45,11 +45,8 @@
>    */
>   static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
>   {
> -	u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
> -
> -	addr -= AMDGPU_VA_RESERVED_TOP;
> -
> -	return addr;
> +	return AMDGPU_VA_RESERVED_SEQ64_START(
> +		adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 2c4053b29bb3..c2407f6a7e83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -137,9 +137,17 @@ struct amdgpu_mem_stats;
>   
>   /* Reserve space at top/bottom of address space for kernel use */
>   #define AMDGPU_VA_RESERVED_CSA_SIZE		(2ULL << 20)
> +#define AMDGPU_VA_RESERVED_CSA_START(top)	((top) \
> +						 - AMDGPU_VA_RESERVED_CSA_SIZE)
>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
> +#define AMDGPU_VA_RESERVED_SEQ64_START(top)	(AMDGPU_VA_RESERVED_CSA_START(top) \
> +						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_START(top)	(AMDGPU_VA_RESERVED_SEQ64_START(top) \
> +						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>   #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
> -#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_SEQ64_SIZE + \
> +#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
> +						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>   						 AMDGPU_VA_RESERVED_CSA_SIZE)
>   
>   /* See vm_update_mode */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 6604a3f99c5e..f899cce25b2a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -36,6 +36,7 @@
>   #include <linux/mm.h>
>   #include <linux/mman.h>
>   #include <linux/processor.h>
> +#include "amdgpu_vm.h"
>   
>   /*
>    * The primary memory I/O features being added for revisions of gfxip
> @@ -326,10 +327,16 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
>   	 * with small reserved space for kernel.
>   	 * Set them to CANONICAL addresses.
>   	 */
> -	pdd->gpuvm_base = SVM_USER_BASE;
> +	pdd->gpuvm_base = max(SVM_USER_BASE, AMDGPU_VA_RESERVED_BOTTOM);
>   	pdd->gpuvm_limit =
>   		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>   
> +	/* dGPUs: the reserved space for kernel
> +	 * before SVM
> +	 */
> +	pdd->qpd.cwsr_base = SVM_CWSR_BASE;
> +	pdd->qpd.ib_base = SVM_IB_BASE;
> +
>   	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>   	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>   }
> @@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
>   	pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>   	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>   
> -        /* Raven needs SVM to support graphic handle, etc. Leave the small
> -         * reserved space before SVM on Raven as well, even though we don't
> -         * have to.
> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
> -         * are used in Thunk to reserve SVM.
> -         */
> -        pdd->gpuvm_base = SVM_USER_BASE;
> +	pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>   	pdd->gpuvm_limit =
>   		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>   
>   	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>   	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
> +
> +	/*
> +	 * Place TBA/TMA on opposite side of VM hole to prevent
> +	 * stray faults from triggering SVM on these pages.
> +	 */
> +	pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(
> +		pdd->dev->adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>   }
>   
>   int kfd_init_apertures(struct kfd_process *process)
> @@ -407,12 +415,6 @@ int kfd_init_apertures(struct kfd_process *process)
>   					return -EINVAL;
>   				}
>   			}
> -
> -                        /* dGPUs: the reserved space for kernel
> -                         * before SVM
> -                         */
> -                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
> -                        pdd->qpd.ib_base = SVM_IB_BASE;
>   		}
>   
>   		dev_dbg(kfd_device, "node id %u\n", id);

