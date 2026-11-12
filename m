Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF7606A323
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p4tCYipH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFECF10FFF5;
	Thu, 12 Nov 2026 10:25:42 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A35410FFE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 10:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoZwZBoi49lyIHrKVikIBOWGCUVHT8QYGC/cEXN5zP5i202YelPTvJ1v0ThpTKlJHKE95vrXJ1FXGsRshiAhs1T45KdPxsUOzV5cM4AKyJn34jmPHRdgf9++VHv8Dg0kYUTYYdUcsuGStLJWadvR2RjER6tRU+YMht0ptonHiTXUpsYVn5Ff4niWYcPPSgeq9qvGa9d5XAEctG/z9r66pU2DEy1El2VYj1DJ+/DLLcTuExeHJVLUb4qtPsywPCsI+7Jc6C6TvxdG1jZbJpObgHbsdoU6yc8qhpxzlRCDUq1McMIQ9bk5xeuDvB4X+0qFZREMhfRlk5dKmbIGCl/8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdTn5hTSfP7H9TiwjzMriYFoWtt+e+FxksM2by/mTHM=;
 b=QClJhjdGJBoJ3xdpP6uaI/O+mqwMmUax1pdgDH8e9E3xxCwPw4z4tkXOHEwnEj/MLuqLbr/dwgbP07NH/pNcCUFZX9fdj7KSq7kf7Barqcm20k/Fy3Id3f9iWGYPVJKRx7tK3l+CH3ZibIo8mhPv+5eQhSjBSeOSgworGJrnsa8JB4CmRFyG+IKQm1PDg1sbSTLSt91B1EFzPbMT+QMnFaoJHKgyNAzPpcCAnBFd7kC7OvMPTJl+ZyY85mZNJ83Itd8hF7mwyenW9EGRD4kiOm3e/Kb6ujpx4SnReYWvuACDMNPZK0E50xuSxBIHDWQYxUJHRXWCkzxxB1KO4Bxzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdTn5hTSfP7H9TiwjzMriYFoWtt+e+FxksM2by/mTHM=;
 b=p4tCYipHNVXzHCTLaJFqCNW3jamuliZUdYLMae+r2Dbg/nyGhxHxURcD2cEswyzjyQ2IM9odWpFpYMQ5MPxMRvGm3o/Gsi5j45BhUKhZOkVL7pYjH9eQrbQEjEH3oPujby/qd9XkLQc1oldokvS41qv5XMNsSgvuuJ2JsmIjllQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 10:24:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 10:24:06 +0000
Message-ID: <21c4acae-3310-4988-b5eb-4c8c8142b556@amd.com>
Date: Thu, 12 Nov 2026 11:24:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: remove pm_runtime from open/close kms
 paths
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261029040922.3911530-1-shahyan.soltani@amd.com>
 <20261029040922.3911530-3-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261029040922.3911530-3-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: bd70c990-8e59-4b81-7232-08df40a7147b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261021121427099003|261009223027099003|261009221227099003|261026121527099003|261021123027099003|261102123227099003|4143699003|56012099006|11063799006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: s2jm+32sGX4ziyjBRWa7t7ezk+h6jDciarwGDbwvvyYN1BQqrLxSWxMQe8Xus35UmVg/hlg2q01+JnHgc9aHwtcy/SAsKzShx+0qKhWnjbX++8MjmT8GneJUcho4Ze/uO/tYO6ppTB0wfFVvBqwIqR8/8MpvgCmMgBTf+I496aYQrg9toocwjb2QyMfhIO5A6IZjSkoPFXpRRVi/9gvCxgVRRPzRRepCAefNO7uF7nsX6j+NlNtSHa6e2TKXNUuUXHpqnVUlhQcV9adLsdvRwr1TneWounVwdvh333IE0HilriIOAMIJv7b9wg4ky3gNClydFHSf97efJ3/qn1uvYU90HQUSTCnjQEc6GwhcFAMG6MJSvOBzQzrx8DdMY8gc0wD3fJ1cgFEpO2CTW8RA1UOA1ufyi6SlIEwkpv5pgNEbZmUCFtRZsNfZXMzpa2qZDk/qNG5LMEiKmxX/qMuQM327HiJdL7+fOYvDhO+bTA2aHdNbO6cJb8YM4FVpQ7TxupzuWg5cCJVWMpQ/R4Cf7CnUyZuxm5eLpRhcDNF09y8NJl+yyVIBCWXiqygQBi97DpNWYtfARioEbnWxN4Afub5gTQT6aTD1La/KfbH8fVGztgUz4EkXlTDbIZphHLojd95LjpY5kpFyqTKL3bIucrMwMQSNEtLyDLivZhI8lH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261021121427099003)(261009223027099003)(261009221227099003)(261026121527099003)(261021123027099003)(261102123227099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFTeUVITEdPaGU2cjZtUWZiZWFHWU1TS2dSckdwT2k0UnE3VEdwbW80eEcy?=
 =?utf-8?B?a0ZFWmdrLzVSYm5QYzdSNXhDWUdCeGRXZDFnVmE0Z215SDd6YUc5MDY4UTYx?=
 =?utf-8?B?dXFHcXY2ZDdiaHR3S2pCdmh6WFE5TENXQUlaVzVQdkZKeUhPRFF0YXRaNUdL?=
 =?utf-8?B?ZkhmQnR6QUY4Mjc0R3AwcWtHOFBIZ0ZzNlVGeHFWaXlJRjBkZ3o0K2w0dmtw?=
 =?utf-8?B?eFVMRVRlMTFxN05EelNFcmRrRlBYdk1QbFJZZmtBOVlaTDhWcGlwMGVRY2gw?=
 =?utf-8?B?ZXRQc3RuR0hacVJTcytyYWYreTZ2NmRVRVpFVTZ6c1BNbE5OcUtrL2g0SmRS?=
 =?utf-8?B?NFJWek44bmpaZXhDTXI2TG1GVXZLR2hnb1RCYzlpeWtyanc1b1k5SEZhc1ZI?=
 =?utf-8?B?TTNJVmlvMTVqZlNmTUc1dmk3Y0RyU1JGR3lvdEZVaHh3UlBPVkNpR3JpeENt?=
 =?utf-8?B?VTJWZzVJVkZxb3h1M2lmbkVkOU9xbXhCTDlyVHptN2RhTXMyRGNyWE5Cd002?=
 =?utf-8?B?enBKOUE3RlNYUFpVR3QrV3RtbkNWOHNXNE9EdE9EbHVxQ2F0YnY2a01hc1N4?=
 =?utf-8?B?dlY4YVVZVU4zOG9BWE1RVmJYVlZGSlNVWWJMZnhFdFZDQ0p4SjVuWHE1V3lZ?=
 =?utf-8?B?ZC9OeFFadER3MmcvaWNnSTgzdkRQaGhDTTMvSjRSWW9KTURxTlFVaDl6c2ZR?=
 =?utf-8?B?RzlVYW0wa3dEV24raVgrOXRwWFdKMENvSVl1eFdac2p0eC9ZZytJSkZTL2JV?=
 =?utf-8?B?MVhlYTB4VWVUQ0FMVG4wU0pnVytuR0pXNmhqWjI0REdoUUpOYUZ0TmFNVTQz?=
 =?utf-8?B?cStHQiszTDM4dHFnTzBjWm5kdUpqMEtXZTRHc1d4ZEF6dFdOelgxRHFhQlZU?=
 =?utf-8?B?VjVtT1lJYWJMN3BpN2lMTWxzY0k1SnhiQ2JFQzRzWFlBSnZRd0RvSGptRVdS?=
 =?utf-8?B?QTFUV1lkT1AvODBKamFrcTlpN2pzWnp4NUxoL0FKQ25DWXp0andaYUpaWGhj?=
 =?utf-8?B?d2hqRDlyZ3pkVHM2QlZSaVVsRG9MeUtnZ3RXUTNiVXBrVlRROVV3UUN5MmV4?=
 =?utf-8?B?UmpacG9lbUZwUzEyeWNCVUlrV0ZSQVVWenNkbG9FUmJsYkNvdlFtSXpYa081?=
 =?utf-8?B?b1hjYTNETmV6RUpVdVNFSUlWVGpmblErdXU5RHpCU1NZQ1Jlbld3MUtRckRv?=
 =?utf-8?B?blJVcG9DZnJiMmpVR1ZWdi9YSTlDR1JSUzRHdHlCemRQMk53SER0UmJRb2hX?=
 =?utf-8?B?cVFVVDFZbW5PNXhyUER5TVduV3RzdXdtZHZWdHFIV1RIUytkbkZxRzFlTlcz?=
 =?utf-8?B?Q1hBVXhnSU5jOVRGRlc0MEYvZ0NZaTJmN0s3UngwUUovT3VhMGcvaTI2aCsz?=
 =?utf-8?B?VGYvT3RPZnpoT2hNL2UxakRZVWovQzl2ZXp1NG9mV1JLcmQzSm91YXM1VWZj?=
 =?utf-8?B?QXkybEpvT3ZoeGJCNlYxYVBYdGtEcldhVUtkZ05VMUVtN0dmaTZEdlc0NUUx?=
 =?utf-8?B?Z3ZqSlhneXNoQzQrUWo0N3g4WDg2SExBek1PY3JaREtIK0FDcUlzZEl4TWlZ?=
 =?utf-8?B?YmtORTV6NjBYUFhyZnNGNExPaDc5YkpUblZDYnA1SXIyTVYzVEQ1M0xsL3hI?=
 =?utf-8?B?YkxTcEhZNTdFaHNGcXphSWpyWXIwU2tTL0F6bzJOYVNEdG1SN1g4Q2xHTWZi?=
 =?utf-8?B?bmVzM08zQjdsZDk3d0kvTjZidERtb3NsUnJVUFhpaFU3dG1XWmJHUVpXNis0?=
 =?utf-8?B?TGlmU3Mxb1ZJaG1uRDVFdWFPV0xWSHhRYjhkaDA5Snhhc1ZIa3NPalhSNzIy?=
 =?utf-8?B?YTcrOG1NcGNrSDNtSEZqV3RCNkpxR3N2cXNqZE9yU1JYUzBYUG4ydU85Tm1U?=
 =?utf-8?B?K3NrTUJIZXUxL2NwN0JpaTB3UWlwZFRqeTFlN3JiVzllK05qZlgxUlptbEky?=
 =?utf-8?B?RXNKOElLTUI5aS8xWCt1anl2eGNadEdiTGxTSFY5VVV1dG1BbTJRVnE3UVNL?=
 =?utf-8?B?djZtcG9OM1l6Q3VsMTRma0JYVlEwZHpzUjJoc2lzNVZmenF4VW9NQiswM2Zs?=
 =?utf-8?B?dWd2TkJJcSs3T0x4azZtNVEyaDZQV0RXZStwNWpJZHNQdDBKcUZ5K2p0TjFz?=
 =?utf-8?B?OEc5NDZpT3BKZmptZURHK0dmNkU0Y1VOSndwTnZmcmt0c2dsOWNiTUs3K3lR?=
 =?utf-8?B?OGNzcW5HRFRCNlVmU2MxY05QbUViSXpQRitnTlU1RlZ5ZU9Gbkc3VVFTTTJZ?=
 =?utf-8?B?U0s2WmF2eUV6VktUWGM4VDVhWWowR29CMGYvNVJLQjV0am12YkJmbUdid0pm?=
 =?utf-8?Q?3ZPQpGe6JjoxxmhaUd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd70c990-8e59-4b81-7232-08df40a7147b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:24:05.9058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA5UkH0KYc7ck2XmFO5r/SL4xf4s969+zIUCJytIRryCt4UtbZFu2QywLyWTtHZe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

On 10/29/26 05:09, Shahyan Soltani wrote:
> Every open system call for an amdgpu device holds a runtime reference
> and resumes the device from a BACO/BOCO sleep state even if direct
> hardware access is not required.
> 
> Drop pm_runtime_get_sync() and pm_runtime_put_autosuspend() from
> open/close KMS to prevent unnecessary resumes.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Please triple check that we haven't missed anything and the functions now get/put the PM reference as necessary.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 14a72a406d37..05406c9ff370 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1506,7 +1506,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	/* Ensure IB tests are run on ring */
>  	flush_delayed_work(&adev->delayed_init_work);
>  
> -
>  	if (amdgpu_ras_intr_triggered()) {
>  		DRM_ERROR("RAS Intr triggered, device disabled!!");
>  		return -EHWPOISON;
> @@ -1514,14 +1513,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	file_priv->driver_priv = NULL;
>  
> -	r = pm_runtime_get_sync(dev->dev);
> -	if (r < 0)
> -		goto pm_put;
> -
>  	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
>  	if (unlikely(!fpriv)) {
>  		r = -ENOMEM;
> -		goto out_suspend;
> +		goto out;
>  	}
>  
>  	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
> @@ -1583,7 +1578,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>  
>  	file_priv->driver_priv = fpriv;
> -	goto out_suspend;
> +	goto out;
>  
>  error_vm:
>  	if (pasid) {
> @@ -1596,10 +1591,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  error_pasid:
>  	kfree(fpriv);
>  
> -out_suspend:
> -pm_put:
> -	pm_runtime_put_autosuspend(dev->dev);
> -
> +out:
>  	return r;
>  }
>  
> @@ -1624,8 +1616,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	if (!fpriv)
>  		return;
>  
> -	pm_runtime_get_sync(dev->dev);
> -
>  	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
>  		amdgpu_uvd_free_handles(adev, file_priv);
>  	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
> @@ -1662,8 +1652,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  
>  	kfree(fpriv);
>  	file_priv->driver_priv = NULL;
> -
> -	pm_runtime_put_autosuspend(dev->dev);
>  }
>  
>  

