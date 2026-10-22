Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF241606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iIzndSRn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9253B11257A;
	Thu, 22 Oct 2026 12:24:52 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62458112593
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 12:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7NEbbBcc7BDxFmHn3XrvvR3YUeHTiMckYCQTmtsiZfvxj+T5kSVdsjBM8D+qZZEix30djVnWUKaraKYiHv1Ym7dhBiDG7REUP1+OjQJYgFThuxvkx1GkGcLIaSVpg429o/Crg2tf4hQJ8rjrJ+U1r56p0EaTp8W+o3EVfCt5uuQ45x4elKaLtnPYeuMm+nQ3nwOOIPwbm8LDreOAjCnPU+JMocj+ix5IfgX0GmLWE8XUnbAAtKP9moQ7Hz7XL+Z6uPHQABRT4UDCIH2vnDyVDy4DWdRp63mUgKJUPhgd5jPE3tp2qTg9rQhajHgMkKzOlWg//r+uMmCwqkyFfl6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMhGKWMdSKNr2EstiB4eqMR8eq9mHpKm4oGdfI3UR4g=;
 b=nJLVebry4xp/dUx4++E99oxs8Xw8AozBIrp4kKX50icrwwinBYc9bLAGZP1bULgN5zRqoa7lrgb91CCib4O8mS9dasEbNebQswhldq0yOqfX7UJ+dPqDixMlLcgGuNN28IoyhAiOMopqq8tcUMZwf6uZ/rdY4MeIwmbef4kO3jOYyUhD3VPH0UNvwRU1JU/wXygSazfRDp8IREZag5urZqtT5kp3geDjCxbBjP8sxkyiOmSKcyA3ykbT1gFeBTggLWI57vezPRx7bHuLt2bbyF+sN0WQagmiqoMNkN3icPTNY2uviDnMFN8mmZhBuFd7FR1TqZ3cKOI8BQeLND6UMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMhGKWMdSKNr2EstiB4eqMR8eq9mHpKm4oGdfI3UR4g=;
 b=iIzndSRnDMVLwCqATtf6cSnaQS7z5AxuvPjeJzM+a2rcbLvP24PlBWunl/1Gu7qFcLo565PEiTbmNRowuerFVLiegwtUzP2XNN5L0Z30eA+oMU+VawyBfRFxhQ0/qdT3KdkDp4ZB3Evr4ZCcHHDjvbZtUfStoVk3B5PhCIoaFD4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 12:24:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 12:24:42 +0000
Message-ID: <e68f3b2d-442d-45d6-8274-82a19f4235e9@amd.com>
Date: Thu, 22 Oct 2026 14:24:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdgpu: defer GPU resume from open/close to
 first use
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261021201459.715423-1-shahyan.soltani@amd.com>
 <20261021201459.715423-4-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021201459.715423-4-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:408:142::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b42c8ac-7333-4e60-16f5-08df30377330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|10067099003|261021121427099003|22082099003|261021123027099003|4143699003|11063799006|261009221227099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: uQaVUyGK1TJHLWeum1Fzr2fo18HUaGmS3QFZBK1FnwPitdsI6pOKHmch5KUvRAkoZV9FcHfdbJtagv1PrWgUYuRbN6r4w7FNAE3rNOIl0q9CJD9/HHznMEBRX1H1iYu4ORyipkenGKHElBbX3O/mGuv3q4J9KJJLRxv+pzKJZkx8r192ARqsMSbXfBwvi0vxX9CajW+ZLFmV7UojDK2oDsnlon0GuApKEea0hL09VLmSHqGGxU76Ltl6vXTqbm/GuzRTTPwFzSOXUjtQElw7Er+MCy0PGozmUd5rMolGtBPj++ICheD2uyE5x+wt2joGmHG91P4ysRBdu/puWR1ZODhTJVVu6jzW/ZAk1Ym2o7RBxLTaEqGl5JvH8oYrnxs0LslwZ0vwL95hTA+OJEwa4l1IVgckv4TI8bMDcJfyXCEsARSUP/iyi3D5aW4r9ReBb1uu9IKHkIeHfng4CTmxMuOCEKVApV5fdm6zvQQUG2hFY6XYWSBHpS9702Ga2JxFriqJgCZbkryHTrNe07mXtzF2yh/SShGaFySjBHsazjoc5xtJjZhY0C3pmwCHerG87An7jTUcZd2tWtV1gcRc13IteWMgWEHdNAvw6d0pvB1QM9SDJYjkx0p5l1JhQ6K8I3zWatnZeu5rKMcusl8GveOW9ozjxL6gib1d0B5sikA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(22082099003)(261021123027099003)(4143699003)(11063799006)(261009221227099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCt2cHp6Mll0VlFkdXhVMFdVMlFWV2xvNURiREkzRVl4THZKbENHUkNIM05a?=
 =?utf-8?B?Y0F1NnZHQ0ZpcHVUV29kaDd0WEhWaWpxWFQxdkpEclpCQ3EvSGU0OSt5NUNM?=
 =?utf-8?B?TEN2TXZqQ2o1VG5TUzd6SnhpY2NLMVJnTjBUV0ZRRTJQY3JybG1QZVRGWFMv?=
 =?utf-8?B?ZWxxWWxiVmxnZXg3aHpQZXFKR0dSVWlyaEpSdmpCMzZRTGc0YmxkeC9EUktu?=
 =?utf-8?B?TWttVEVWT0Fzb3RrNnQxTWZhY0tIdTZ3V29JUU04dGpvYlRLbWNaM3hIazlM?=
 =?utf-8?B?L0N5ZGtsaUkwOHFKTnpQMGE4WUFHWjd4OFF6RSt1bi9jdkZYYkJ4VWRPcDQr?=
 =?utf-8?B?eThTRVZRYVU0bzRQOXY5R09sVEhJeFQ2c0RublFOOUhUeWlnbTRISjJ4dGxl?=
 =?utf-8?B?bXJvVi9TemR1UjY4TGpyZGdJcGF0MDYxWjQrYVRHdW9hRDBCSTBSbVVUQklW?=
 =?utf-8?B?cjVNTHB0dXBZNW11WkNiQUdCenlaMjZ5STJWUFRPd3ltNGdtdHh4bkh6NG5C?=
 =?utf-8?B?YlZtRHMzMWVJTDh3dGgzZVBWdDJOUU9uaGd2bW9WOHVEcGo0a1FleTM4ZEdq?=
 =?utf-8?B?TGxlZXhacTNrRjMzYVd3SjY3UjFTMG1SWVBlaWlvNmdoWENyQldZOHpZQzdV?=
 =?utf-8?B?SnNRbldvMVhFeERQeGtWbDlvOUxjZW1tYVV4aTNkcDYrd3YzUkoxK1Rkams4?=
 =?utf-8?B?c05wTlBXbzRycFFrV0NnVEpXVjE1YklwK0pXWHp6SHNqVzFDNEhHaCtCRThI?=
 =?utf-8?B?MGxqa2djU0xCK3MwbjZnT3MyZGRGVFc2MUFIblJtSjlOY3VwczRYeHZlbXFp?=
 =?utf-8?B?Y1dnY2VjVmlCMUpObEtvbVloMEFnNEYyNG02U2hWeVg1VW5NekhJbzRNZ0dj?=
 =?utf-8?B?bFA0cUduQWcwU3RFNEd3NjVDRDd3bnlKeDBIZEZZTklPeHVFUFFUSDZSczh2?=
 =?utf-8?B?ZUkwMGxvQ0xnNnZYNXFncWpCeHVOeXhkNGhBemRtOGVoT3MzbEZYSUdNZDBU?=
 =?utf-8?B?MDN0dUpOVTQ4elA1Nk9DcVV0SzBmSGlHbWJ3Mk9EQ3haTEFtd0dINmE3WjBq?=
 =?utf-8?B?QjRzalE3SlpzMlQ3ZzN4ZjhFL1lzZmJDWndndytNYVN4OXFyczdYdlpDQmhO?=
 =?utf-8?B?bVBsYjRPZ3Btam8rUWhJS2x3Z05qV2pNUlZtQS9RbDExekhwZi9ncnR4WWFM?=
 =?utf-8?B?aDVtMzVGRTNlemcyOGN0NzhPNUZ3bGl1MVpNTGdlQlcwQXB0WU5qRWgvempH?=
 =?utf-8?B?cEI4S2czYjVUU1FNYTJ3MmVES2VUMGxTQmhEblAvWnROOFh1ZG44VW9JMGcx?=
 =?utf-8?B?Z3pHaGhoTUtNSkozZWlqZG1sOERldCtIM1VnekZRVEQvWlpsWEppdzhqM1Z5?=
 =?utf-8?B?c0ZJSFNzMlRHajE0ejA0U2U3NUFIOGJjQldRdFRoMXNPem9JbWx0TDJVeFFL?=
 =?utf-8?B?Rk5qcU9nRmNNSlA3WnFvNittRlJQSGxGN2dDWlRhLzUvbFd3ejROZkVzMUNB?=
 =?utf-8?B?MlV3VWtZVFQvOHVNcENpU3YzWGtzdFVtU3BCSGorTWV0WS9WbEtZSUc1YWN5?=
 =?utf-8?B?cHBQVENwRTBsOENpYzQvMzZ0a2ROS0NyekJscU4vNnVoYTFDRGluaFVOR3JX?=
 =?utf-8?B?eklhTlBySkJOeVRVa292RmNML2FWN3RkalhLZ2xkY25tWGFKSUcvZlNzb2tZ?=
 =?utf-8?B?VjdSV2pFUUdxVGk3MEJXbTFvd2x0bEtWWDVJMU1hQnV3UDJUamVSNTllNjJU?=
 =?utf-8?B?M1JMRVd6TVlFcEh6ekNYWmVON1hiS0tCNXZhbCtHMDlkK0Y5MWY0UUJoS1l5?=
 =?utf-8?B?K1lLZnJodVNDNVlFa3pueGhIZlBsK0drY2hzaEUxYUp5WWQ4NEZlWTR3d2NY?=
 =?utf-8?B?dHpabmVuVGhpUFpIQWRpMjhHWFB2L0JZakp1UHdYYXJiMktDTFpMaXdjSUJK?=
 =?utf-8?B?RjJEQnpudWZrUDlHWXZQYlIwSU55TTBaSWU2VTZEeXFRK0F4OGQrS2JxZ0Za?=
 =?utf-8?B?YXZaUTBaTXN1VzhhemdBQmNHTm84a05sTTMya0g5ajNsY3prQ0NWSnVWdWZB?=
 =?utf-8?B?Q3JYalFSWk91V09OZTFyb2tqTU81cGRCalpLRWl4Z3pTSGE5OHlaTGdSZEJ5?=
 =?utf-8?B?bGV0Z3BuWkovQ0VIYmJNdWxraUdUVVlabThERlkrVWtNRktvTG1EODg4T0p2?=
 =?utf-8?B?WG9WbEQ3Mm9oVkQ2NUUyajdOZjlUOGdabFRYd2VKMHJtWnlWUFFLdmRIdlA5?=
 =?utf-8?B?MGorU3B3ME8rZlNTbEZIM1ovZDI3K21nbUFpKzVRY0ZUK3JRSzJhN21mWndO?=
 =?utf-8?Q?w3d6M06MOiJ7hY6MZU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b42c8ac-7333-4e60-16f5-08df30377330
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:24:42.6128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heog8w7PsTYGOr+aMAHDcIgYi/ToNKDN8THuuB/hpFFF5CEDGQ2OxPZaeCQVU6s6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/26 22:14, Shahyan Soltani wrote:
> [Why]
> Every open system call for an amdgpu device holds a runtime reference
> and resumes the device from a BACO/BOCO sleep state even if direct
> hardware access is not required.
> 
> [What]
> Drop pm_runtime_get_sync() from open/close KMS to prevent unnecessary
> resumes. Instead, the PM reference will only be held if the GPU is
> currently awake.

Just drop grabbing the PM reference, the parameter to vm_init and the powered_init flag entirely.

Instead do something like this in amdgpu_vm_pt_create() for the root PD:

1. Calculate the disired domain in a local variable instead of bp.domain.

2. Initialize bp.domain to zero (or AMDGPU_GEM_DOMAIN_SYSTEM if zero doesn't work for some reason, it should but that path is probably not well tested).

3. After the amdgpu_bo_create_vm() worked update bo->allowed_domain and bo->preferred_domain to the real values figured out before.

This way clearing the root PD only on first use is always exercised and not just in rare cases.

Apart from that the whole approach looks pretty solid to me now.

Regards,
Christian.

> 
> Introduce delayed virtual memory hardware initialization through a
> powered_init flag. The powered_init flag handles initializing the VM
> domain in a GTT or VRAM domain depending on the init state of the GPU.
> 
> Remove the vm->generation assignment on amdgpu_vm_init() to force a
> mismatch and proccess the amdgpu_vm_validate() logic. This path will
> migrate GTT based page tables into VRAM upon a cs_ioctl, as well as
> clear any garbage data within those page tables.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 18 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 12 +++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  7 ++++++-
>  5 files changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 14a72a406d37..6ac0459f202c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1502,6 +1502,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	struct amdgpu_fpriv *fpriv;
>  	struct drm_exec exec;
>  	int r, pasid = 0;
> +	int pm_ref;
>  
>  	/* Ensure IB tests are run on ring */
>  	flush_delayed_work(&adev->delayed_init_work);
> @@ -1514,9 +1515,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	file_priv->driver_priv = NULL;
>  
> -	r = pm_runtime_get_sync(dev->dev);
> -	if (r < 0)
> -		goto pm_put;
> +	pm_ref = pm_runtime_get_if_active(dev->dev);
>  
>  	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
>  	if (unlikely(!fpriv)) {
> @@ -1530,7 +1529,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_debugfs_vm_init(file_priv);
>  
> -	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
> +	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, !!pm_ref);
>  	if (r)
>  		goto error_pasid;
>  
> @@ -1597,9 +1596,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	kfree(fpriv);
>  
>  out_suspend:
> -pm_put:
> -	pm_runtime_put_autosuspend(dev->dev);
> -
> +	if (pm_ref > 0)
> +		pm_runtime_put_autosuspend(dev->dev);
>  	return r;
>  }
>  
> @@ -1619,12 +1617,13 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	struct amdgpu_bo_list *list;
>  	struct amdgpu_bo *pd;
>  	unsigned long handle;
> +	int pm_ref;
>  	u32 pasid;
>  
>  	if (!fpriv)
>  		return;
>  
> -	pm_runtime_get_sync(dev->dev);
> +	pm_ref = pm_runtime_get_if_active(dev->dev);
>  
>  	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
>  		amdgpu_uvd_free_handles(adev, file_priv);
> @@ -1663,7 +1662,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	kfree(fpriv);
>  	file_priv->driver_priv = NULL;
>  
> -	pm_runtime_put_autosuspend(dev->dev);
> +	if (pm_ref > 0)
> +		pm_runtime_put_autosuspend(dev->dev);
>  }
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 6cd3927a7e82..c8d558d07d1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -4169,7 +4169,7 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
>  {
>  	int i, r;
>  
> -	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
> +	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0, true);
>  	if (r)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 961557997cd2..2cb194dea6d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2634,7 +2634,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * 0 for success, error for failure.
>   */
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int32_t xcp_id)
> +		   int32_t xcp_id, bool device_active)
>  {
>  	struct amdgpu_bo *root_bo;
>  	struct amdgpu_bo_vm *root;
> @@ -2658,6 +2658,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
>  
> +	vm->powered_init = device_active;
>  	vm->is_compute_context = false;
>  	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
>  
> @@ -2678,7 +2679,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	vm->last_update = dma_fence_get_stub();
>  	vm->last_unlocked = dma_fence_get_stub();
>  	vm->last_tlb_flush = dma_fence_get_stub();
> -	vm->generation = amdgpu_vm_generation(adev, NULL);
>  
>  	mutex_init(&vm->eviction_lock);
>  	vm->evicting = false;
> @@ -2701,9 +2701,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto error_free_root;
>  
> -	r = amdgpu_vm_pt_clear(adev, vm, root, false);
> -	if (r)
> -		goto error_free_root;
> +	if (device_active) {
> +		r = amdgpu_vm_pt_clear(adev, vm, root, false);
> +		if (r)
> +			goto error_free_root;
> +	}
>  
>  	r = amdgpu_vm_create_task_info(vm);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 06e0ddd60c7b..8ed9c88c4da3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -372,6 +372,8 @@ struct amdgpu_vm {
>  	bool			is_npa;
>  	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
>  	bool			need_tlb_fence;
> +	/* Flag to indicate if VM during initialization holds a runtime reference */
> +	bool			powered_init;
>  
>  	/* Memory partition number, -1 means any partition */
>  	int8_t			mem_id;
> @@ -433,7 +435,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>  
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id,
> +		   bool device_active);
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index c73eb416c0e2..c22b3fc82a05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -456,7 +456,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	bp.size = amdgpu_vm_pt_size(adev, level);
>  	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>  
> -	if (!adev->gmc.is_app_apu)
> +	if (!adev->gmc.is_app_apu && (vm->powered_init || vm->root.bo))
>  		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>  	else
>  		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> @@ -486,6 +486,11 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		return r;
>  
> +	if (bp.domain == AMDGPU_GEM_DOMAIN_GTT && !adev->gmc.is_app_apu) {
> +		(*vmbo)->bo.preferred_domains = AMDGPU_GEM_DOMAIN_VRAM;
> +		(*vmbo)->bo.allowed_domains = AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM;
> +	}
> +
>  	/* Assumes that reservation is shared with the VM root and that the
>  	 * reservation is locked
>  	 */

