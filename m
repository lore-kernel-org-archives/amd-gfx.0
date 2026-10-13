Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB60CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 06:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F5EB10E76B;
	Tue, 13 Oct 2026 06:54:03 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010042.outbound.protection.outlook.com
 [40.93.198.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE7010E76B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 06:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp8DTCJ6rphXdZl5t1n5SCcYWcEUJ/kRNlwONqLBEbYyWDbjDG9VforI8pbiH+derJtjDRHzeK0vzx2mOVDpwPlDbDiW3qvS0fI1T9eLe+UWgzpj28XFS9q/PiIC8rs9C4sL+W6QRQyC0ksWuwXMedqcJzyVEJKb58J9tn5wge5f4+yIm1L3l5HgEzAmjj4tyVIQeg2N6IBRD52e2UjDtkiIeUfkv9fOpSm/2Z4x9OQMWQjYQKorCyeV/Z9cyL+bpSiJ5nX8uEIW6v3haKjZD8D9KUuuev/TUZel6JzYyZ8cgAIEZkzXRfLlWrQUmuI8oZvDSATtCvykdX64AsfdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaK5uJHNklI7J7J19sSTay3mn11Rm5FVHvXULK5AT6g=;
 b=Jplfgu5v4oiupYAlaRovYsbZ9W2mDDyRkRmc4cRgrOwx0ESzIJTmFbBe+VKZlOeVMaFBCbx/ZqiiUOxqDG5VXddXFIIBo0zbOGLOJNtkXvtoCtTISs9z+m0DvSUoY9pG9P5j7+4nVPO409Mfw4EgJFqH/4DHqRtsAW6PrGNaV9qCnhtSwsmpiQP68blz94GVHsLv+kWwec0NQPFigLxujIpDsKAQwMKsI8CQ469rIL92zAIsXTLDcYc3Q3gIlL8UN3EoWAzEEBbx3k9HHX74gGiOhRv60hnq9uCg60eGKXDnN9zw5Kcc4hVDDgk+z0lTYgzmec1BjIwk/KYj58icrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaK5uJHNklI7J7J19sSTay3mn11Rm5FVHvXULK5AT6g=;
 b=uXe0kCU+R2zGH/sAgl23io+zyLBHiqHHfZPciOC1r/LKgAMiwKqW2X9+1aNVw0KMaUCnZseJS3/4mXFSKY0sKQ64Uclx6D4+A05Ln2Y4xkZIblHPSeSx8XbZXzHPMW45v07RL2A6ZXlQAvjku+BuZ0lDwFB/o05atZLLlbj6Wtw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 06:53:53 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 06:53:53 +0000
Message-ID: <4e0781ff-a9b9-4521-8629-6a031e125d0e@amd.com>
Date: Tue, 13 Oct 2026 08:53:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] drm/amdgpu: use the same naming scheme for kq
 and uq VMID masks
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261012092429.3937825-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: d68fd6d0-28f2-4a3f-b7bb-08df28f6be8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 0dBhaYFo22KLhJb/r+6VKq/zvNEFE2QXNFqunYLY5jn+3fMV9QKqr6HqguVDMA173FyMZFvRys2AEfEmcpUz0su9rdvHIU2t6mjnfZYT6AagIbSID+aeOi9XL0S6fgiGENVCeK0q9uXK/glbdpS/2pKddubEwPP+Uy3FF+AAhFyyyMz5u7AGShm+LIgQe7drOughvZ71Zt/nTjESzcFWg9mTy1yW5b6L2zUGCkbSk/GtDcoWxNMfDGorLvPwO+awcXrSmNhDfvd8TyzuT6dCbo/uUFsd847FdA/9OjvWEeE2ThgazwDEdgloBP3hPABHukwTvXkUrCgEObPYcf2o7UO7OhNrPTK0eoErXl4sLoxgJWdCub7MT9xBJG5awcnFthkuc9P3QUFclU2IvgSqMRxvyetmd/fuQRfezcfkyHXJR75sLhkx7bLg4LMYVfLFiuD8+GBOpcjTCLKeJKjMfY2dugEeyguYjTFamQJEnxAi2QTUhOMxT7+LZOumKlDMio30VgWHN/9RzvU+gGWMTVJtK5dkSG+OtMk6Tl5Py9P0qPXEn0w1pCauGbNfpHWQLG4gJ9IJUz8hiBZFpDh191BUiMBJRZiMsk7BsV5gqSaRjz/ozwn7ye0euuj2kuYbDHdgX6z6QJGesKBXmlTNN6VrtWRmnfAwA7S80mzJbB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2JDR0kyWkxsUDd1QzBoSWNwcVNUUS9SOFFJRnlqWWVSOFllSklPeTVvNFNK?=
 =?utf-8?B?OFlHcDBVMERKT0l2dkdhMnQ0aFB4TzJ3QjNMNUVvVlVXNmdNVDdpQ0o1NDlr?=
 =?utf-8?B?NjhDalpmd3dJYVVUZGg3SThRVUlvdG5ucGEwbm5Rem80QmNZSVJkTkFzdUpD?=
 =?utf-8?B?dUVFdXZIMWh2anBJZ2M2ckwrUERUQUlXbGtmcEszMElxQVUyRzRteUZuMU1O?=
 =?utf-8?B?ZFpsMlBHY1BmUGNONnpra0tNZG9FYTZYMmVVZlZNanhJdW03MXNHNG1pb0tO?=
 =?utf-8?B?b1RFTTFOVTVmOStZOEZIazZCQ3hUZEFlQmpDMHdGUzVxdXZSNzlvdHc1SFhR?=
 =?utf-8?B?VVJ3ZnRPcEJlNDBFV0JSYjV2RlFKRDhPWGREbDcrc3ZtakRWR2djeEtIc3l0?=
 =?utf-8?B?WUJOVVJpUFlGbXlrV0lxcVVHN1pHTk0zMnBJMVlzR2RudEFBYjlpclN2RkUy?=
 =?utf-8?B?cGVsVnh0clhEeGp0WXZWWXl0a2dSNVpNVFdCbHo2SWxsd2hML0FLamhrNTJj?=
 =?utf-8?B?MWIzalFYaTBLTkczaG5VL3UrWFMyR1BxUHcwd0t1SENuQmxiUllEcmUwci8y?=
 =?utf-8?B?Z1NWQW1zZkJaaVVDcnpPRncybmI0d3NCQ0lJTmR3b0tPYXhWRW5vNHFVeGtM?=
 =?utf-8?B?VktUQ1BrY0pjaThtWUdPVWcweTZGS0FoMzRrMFR5ckQ1dXd4dnpkRlhYWEY2?=
 =?utf-8?B?OGRGdmJNZkdmUUNVVVh6U25pREJmSkxVMk51dzBkQSt6ODhtMFJzVnkxYU5h?=
 =?utf-8?B?QUs3T1lHcUxreUpPd0pnazZGR0VyNWVUWEVHamhRalc4dFNUN2UyRFF6L0Ru?=
 =?utf-8?B?MXg3Sy9yWnpuLzIwcE54cE84a1hHOGhYVVVTRDJkelZJRmtCSlRtV2h4RXpS?=
 =?utf-8?B?M1VVcW1hMEdNc2ovUEUxOHFHQzl4VnFibWYvd1kva1ArS1NWd3phS2xVWkJZ?=
 =?utf-8?B?RTg4elVRSlhZYmJEck5vaS9HalhnQ1o5ZDlTTGhBdlViRVVWT1FzTFhBdzNm?=
 =?utf-8?B?czlJTzF4bEMxckppUjJyYXBjUGZRWVZLQjZWbjJDaTVBa3d1LzRUZXo0NkRI?=
 =?utf-8?B?Z0c3V3o3VXhoZHo1anNmbXI5TXhtOHBYTXdUNm1rWnZJSG83TS9hdE5WZi9C?=
 =?utf-8?B?eFUvc2RHb05DdlFraTdTQ0NpYWFhcFQ2R3YxNm5pMmQyZSs2ZmR3Nm1wSnRp?=
 =?utf-8?B?b0U0N0FaT1BKb3ZoMGU1blFEQ3BmY0hwbms0MHo5M1BVWnNvTlVoRzA2cXZM?=
 =?utf-8?B?V3dUNUNuVlpMR2x2bGJLRDh6b0twV014TVhiK0pheWFYeENyWXNwNzFSR2NC?=
 =?utf-8?B?WVAwZjBabXlSRlFIcTRyWGNQUWkzYnZBOFNRR2FkYlBoZDc0OFdPVG5sRERW?=
 =?utf-8?B?TndDSkl0dEZxZ24wUHBrbmNRU21JczZmMGdWL3NHK0sxckhHRlhocEJCdXgz?=
 =?utf-8?B?MmRSc25rRkpudHJLbHkwbnhqaURWMHVvNkY5VDFmQ1g4cXl3RWtQeEZzcXg5?=
 =?utf-8?B?QkZTR2NLbWxNZ2JSaWw5S09OT0ZPWFVvMDVuSmJlNlBFTmFGL2FwY2tyeVFY?=
 =?utf-8?B?KzdxaVkrMlJKUmRoUXNZYi9SVWljQWZRa3VsaUVqZVZJV2dvWGJJUnlieEY4?=
 =?utf-8?B?bG10VkxYT3hMTWpnS1ltYW02NUtPYk1JUzJFemc5M3pYTlhXSFRvRzQrTjY2?=
 =?utf-8?B?S3JGR2xlak1jcU1VWksxK3JNS2ZSb1doSXlqcXlDTUNjMmVTY1lmazNPRkVh?=
 =?utf-8?B?cDJZQ1dEM2RNRkFURGpPZlgwQlQ2SVlLSWRJR0lXYmE0ZUlxNnVVVWhlcitq?=
 =?utf-8?B?SVFobWIyaGUvL3kxM3QraUMrRmNSY21kRlZqZmlGSml2cU41dlZoQitnaFBP?=
 =?utf-8?B?NjR5UW8wZnR5c25IYSs5OVIzT29TeUgyU0d3VHMrenoxRzBNTHk3ekZVNHV0?=
 =?utf-8?B?Z2RRWVB6ZnpoQUU1S0QzbEZZWWdHdVFieTNzTVcvUmZhR1BWVWJMZUl1dGdx?=
 =?utf-8?B?bThrTkJSNkh6T2F2YjFlb1h1MThjcDhWc1hsTmFEd1lFNFB5eWsyNlRMRlB1?=
 =?utf-8?B?S2Ezc1lmS2R5akxxYWZiczBHZ0hRM3ovbVpUOEt3dXNpU29jeVpxUFJuTUZi?=
 =?utf-8?B?TGt3M0JGVHQvWms1YmdERk8yUm41M0hTMFZRTndxcXpXczRScmpPZDNTbmR0?=
 =?utf-8?B?TldDSStzQWhuVlRXSGsrL2QzbWpYN0VyMHpKbVFIN21wT0dnTmx4NzN0cTRR?=
 =?utf-8?B?N0ppbmJIbzd4S2g4Z0I3Y1g1TmllWFlCZHVtaElSZjFUTHR6MjNabkVQT09F?=
 =?utf-8?Q?gF8Im67no8Yh3Blomk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68fd6d0-28f2-4a3f-b7bb-08df28f6be8f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:53:53.6516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPNr2K0k4UW65mGB0fI3xtNNnu3/giORoLwZhjm32gYF+bWqIrZmmHtG6Cdb7awt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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

On 10/12/26 11:24, Sunil Khatri wrote:
> Fix the ambiguous names in amdgpu_vmid_mgr_set_vmid_mask()'s
> parameters so there is no confusion.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 16 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  4 ++--
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 1c5bce0500ac9..392a18b1f2b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -635,13 +635,13 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>   * pools for both hubs
>   *
>   * @adev: amdgpu device structure
> - * @gfx_vmid_mask: kernel-queue VMID pool mask for GFXHUB
> - * @mmhub_vmid_mask: kernel-queue VMID pool mask for MMHUB
> + * @vmid_kq_mask_gfxhub: kernel-queue VMID pool mask for GFXHUB
> + * @vmid_kq_mask_mmhub: kernel-queue VMID pool mask for MMHUB
>   *
>   * Sets both hubs' kernel-queue VMID pools (tracked least-recently-used
>   * via id_mgr[].ids_lru), and both hubs' KFD/MES user-queue masks.
>   * vmid_uq_mask_gfxhub is set to the
> - * complement of @gfx_vmid_mask, since unlike MMHUB's it is always a
> + * complement of @vmid_kq_mask_gfxhub, since unlike MMHUB's it is always a
>   * clean partition of the full VMID range; vmid_uq_mask_mmhub is the
>   * fixed pool set here instead, since MMHUB's kq and uq pools are
>   * allowed to overlap. A VMID dedicated to a single fixed purpose on
> @@ -649,26 +649,26 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>   * caller's responsibility to have already set npa_vmid.
>   */
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
> -				   unsigned long gfx_vmid_mask,
> -				   unsigned long mmhub_vmid_mask)
> +				   unsigned long vmid_kq_mask_gfxhub,
> +				   unsigned long vmid_kq_mask_mmhub)
>  {
>  	unsigned int i;
>  
>  	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
>  
>  	if (adev->vm_manager.npa_vmid)
> -		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
> +		vmid_kq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
>  
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>  		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
>  
>  		bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
> -			    is_mmhub ? &mmhub_vmid_mask : &gfx_vmid_mask,
> +			    is_mmhub ? &vmid_kq_mask_mmhub : &vmid_kq_mask_gfxhub,
>  			    AMDGPU_NUM_VMID);
>  	}
>  
>  	adev->vm_manager.vmid_uq_mask_gfxhub =
> -		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~vmid_kq_mask_gfxhub;
>  
>  	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
>  	if (adev->vm_manager.npa_vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 4dfcec76afed7..105272ee2dce6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -135,7 +135,7 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev);
>  void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
> -				   unsigned long gfx_vmid_mask,
> -				   unsigned long mmhub_vmid_mask);
> +				   unsigned long vmid_kq_mask_gfxhub,
> +				   unsigned long vmid_kq_mask_mmhub);
>  
>  #endif

