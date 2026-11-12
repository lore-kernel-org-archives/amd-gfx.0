Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75663606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SpVlthOT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F46310FFDB;
	Thu, 12 Nov 2026 10:25:55 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B0610FFBE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 10:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoVbGlE8t2E0d20cmTg2mee0qMLMHV1iv9OispE1IAhrey47PHQBgR45nv8Ae/PQBuh5sL8CLKFhrQb6BYzS/WkkdaSYMUAgzUKBcjRK0DHpVxWghMy3si3hDM/tLM9FKTAC+Kpt717WGoA6oFoQLbJmLrXTBlm19J3Tmp/s+VtdvFmc7d4k/xQs1B/KZRD5BxhGSoojR7zGKDwouBqHFVnjY2AGvFbY01l7WMbLOKo0HxADYTu9sa72Lku9E0ZSJWfJmUSQcuVQjflgf4p6LCejFS8Q9H5keoZVqn9apKu/8FpDdEJfWbmldRzR7hlR4xy3wKYKWBzF5P7DxnwtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdTn5hTSfP7H9TiwjzMriYFoWtt+e+FxksM2by/mTHM=;
 b=Ysl3M/Vj7qhopfvwRpGmfUm4s9DN7CaWDPVklrV7kKAmUZQk8jkAIr6RdadVwQErq8Fob+dJFmh69utWiHY+FFmLYYdKcYTtuOs4NozKMIin/epNsLr2w3I7DJar7XBZQREV2T17KtC7o0xGIxxnSVT3p6iiarAUvr4Q2A7+4WdJL8U4p9vJjKJL2z80Mn9NwXcDCbmFRAjpA8ZI+/xnuQOuyWGyqMWo70jpJmfYY5I53WciHO1igqCPJBFPbuApX8G0cbqxWuO1XjHz8eLeMrMszWl9DXQX6vsTjNSnBr9uGJA8zbR/sGKpJ99CERjAHY6sCtgLAL/bAJ/U0iDINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdTn5hTSfP7H9TiwjzMriYFoWtt+e+FxksM2by/mTHM=;
 b=SpVlthOT9bk/S7KnZf92k4fUTc89sMBShAf4WLvRs1FMVB1SKrflSbHgdmATzMtPgtyD06auUg4lfVfWmgoqhwluGIoQoWCvrj6LJznRGlk4OjKYLW+IZdBZDL9vxAYtLqGZem7aQjtz/Av14n+WYftrOY36fjBs3dpajgXp2Xg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Thu, 12 Nov
 2026 10:25:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 10:25:46 +0000
Message-ID: <5664cff8-89ac-44ac-ae13-e09ee4cbbba3@amd.com>
Date: Thu, 12 Nov 2026 11:25:42 +0100
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
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1697dc-c1a8-4c95-a71c-08df40a7503b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261021121427099003|261009223027099003|261009221227099003|261026121527099003|261021123027099003|261102123227099003|4143699003|56012099006|11063799006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0fkjRu4xukxRtWWC/IuvTVLW61fsMfXF6HFSYhM7Jd5ixvicUMicLBN7kALimNFfyldY3969JG6CgRoYAe8yfqD/6hSravAxKwrER2cH340mj34gjmocoRz7FY4+kwXCcgOuEJtY+avxQYm0PDsSjEAoXS0Wf7+2fUo3q3HC9B/qXX4OqkyJBTOfLKtOyzwRJkgg2difTAybCSZDCTkGWoEENVXIVDP612aBD/W9uatrOS81IZ9Fio3UoeAaereCosfmK6izdgZWsMEBOqjLckoHj5HnKCP+pOtzTxZ7nE6eKfnRFCVAZiY9Y4H7NYEqaaXBUT3SuWyv5egYsxU3fHyl53m90APlKuM/EDt/p9FrAwq13bNQkPByJQ+rY+xCDf8YitCS4oc8PGuEyhQ1N7SMW7Lx6whWQ9Q9I3tjte/2SiBwe7lwAWnxQylDQrQ3n9/z/P69HblAqof4rOrOP47g0shcHSS8QoZaIQ4ZREs6tF/KcCAvxVFiGftGJhtcS0OzAUvfoU42n/kCptrvX9dSQZUU4/ZCf/HIUv1FjQjHySdXuUss7lKe3IrXEPAyMmfpMzErgnnp656htfNhfEEaNgyieKI0KrVuMoQaLkjqoUExalLp/lYqkQFcvJ5fAK0Xt/qy3YYHXCckY1tJv4B/y93/fKMIddf0dkiyTy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261021121427099003)(261009223027099003)(261009221227099003)(261026121527099003)(261021123027099003)(261102123227099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllFTXFabmpDdno3Q3B3YkJJcUJxQXJLRFRFSnY1Mk1nQjEzZlAySTA3UXFl?=
 =?utf-8?B?UVA2WnUwdUpiR2pKQk5sNzBTRkMzSmJibk0rNHlJaDR0YVBScitlRjVLUmNX?=
 =?utf-8?B?amkyTVlKdVRpZmJLWWdWbkdpMTdLeHkrMVZjNU0rU1dObXFVK2VrVVlSSDRr?=
 =?utf-8?B?L00vMm05L0R6V1pBU1U0MVdlcmcxd21YSVFTVVlXeVgvellkR3pnbmR3UXg1?=
 =?utf-8?B?bTAzeUo3WWk0S1MwSS9CbnU0L1IwSlFVV2pkVTYrdWhPN2U5TVVyM3AxWmhv?=
 =?utf-8?B?L0lxKzRtK0tNZm1MNk5WbmgvT0N4N1h6Z3kvSDM4VXpZcjhGbkswSncva0Yy?=
 =?utf-8?B?Z0h1R044R1l2MThOM2lidEFoajB2RzJuZWh5RFNhclU5dERDUWN4QzlidUR3?=
 =?utf-8?B?djY1WW9maVZvaXYveEpnZGF2RUllM2VhTW4rUWhjU2tMdFAwMjNhVUdoK2Nw?=
 =?utf-8?B?T29EdzFkcXF5eWU2SHFxbEFCNkZHbU1UMW1lekJVRTlJYzdVYnA1STd6R05C?=
 =?utf-8?B?SEJaSjdsZlY0a0dRbDIzcTBqSWJaRUh3SWhHaHA3bGhmMXhuZEVjZWtlQ0R3?=
 =?utf-8?B?T1NyZE5iVWRhdFhRcXI4NXFocS9uRzZaNEkybEJvdFM5dW5kbGU0RTB4V0pY?=
 =?utf-8?B?eVNFd0RxM1JrNFZrQ3VxUmJIMStyMlp3UWtMc1dTVUVHK25hak5IamsyUkRR?=
 =?utf-8?B?R1VXK2MrTnNvZEZDcDFoOThLczlEUUxuK24rTHd5UGxvR3N0QlR4VDQ2UHU5?=
 =?utf-8?B?THJNRnRMUzUwWHYzQWpEQ0xuODhneFFTdHRWS3M2RFBPT0g2VVNNeW4rcDd4?=
 =?utf-8?B?VXhHQklWSnluYU1RV3Q0bkZvT0tKUTBLS3hDZ2N3aWZHQTc2ZjJkUDdsWmR0?=
 =?utf-8?B?L254ck1EbGEyWEg2TkdXOTJMeWtYS2d0bGY1ZzFSS2NSalpxaC81NjVGQzRU?=
 =?utf-8?B?S0V6b2NzWEVtU1FQK3FZcktQa2hLbE5zaEZyaFhZRmZpdHl2Uit3MzBueWo5?=
 =?utf-8?B?eHJZNXh1dDVhSW1OTER3ZU5JVG5EekNMdllzSFpQMitSZGwwbGYwNERNdGtL?=
 =?utf-8?B?QTM3alFITXB0RTJCVW5SSWU2cUZzYlVlUG43TlNTM2IxOVBqZ3FRdzBQd2V6?=
 =?utf-8?B?MldXWDIrWmFaZmJuOUhTZDY5eDFBK2R4WE5pUDZua2U0NEJpd3Vab3lsQTBO?=
 =?utf-8?B?dERqSklraUQwT2ZHZHM5UlNkc3ljT2NmdVRZNENFaUt0dC8yaXo3RFpDK1Bq?=
 =?utf-8?B?TkNVOGcwMWt3M1pzMDQ0NEVtUnNmM3JweXBHM0VHT0VRSzMyS3RiRTVpY3RN?=
 =?utf-8?B?THNoQTQ2dnhNQi9aM2hxVUp6dDkzdXp3YXJhQVpFcVQ5aEw4eVlDNHVVOHcr?=
 =?utf-8?B?RG5NZC9wOHNVZWxWSFd6SWdJZFNNcWgrRVY0TW1EQjdTMTMxVU9QakY5OFpv?=
 =?utf-8?B?b25EL21FY1p1ZnNLOWk1Mys2ZUJoVzZtdEE0MlovRGxZeFd6c29zSGlGaVRU?=
 =?utf-8?B?RCtTOWxDMWExZUhKT3BOZjZDUnJqcnFzTGpxcGR6aldZUG5XeEFWdld4NCsw?=
 =?utf-8?B?QWV5Mi8xMU52Q3NEc3hIQ0l2Q01ITU9sT2VrMS9sMlY3NFg0cmVaQXFuYXNk?=
 =?utf-8?B?MzhNZGZudHZsbUdxT2Z5OXgyQzBHQXR3c0E5Smc0N3pMNWdPdFNHRndEVlo1?=
 =?utf-8?B?KzQ4bldsTENTVnRaTFd2aEdKeURacGhZNUhvWjl6RlRKYXl1dFNBeGV4UDJr?=
 =?utf-8?B?SUhVN0VVcEN4c3RzeTc2Qjl0SzR6VmhEajlYTncyaHFpVTNIb1l2NUc2ZU1H?=
 =?utf-8?B?NUJPaHprQ0lpc3krb1V5OEpTZ2FwTlF3cFV0RWV2VmxtelRKRXRpK0hoMU83?=
 =?utf-8?B?ZXRGOVM0eGZFV0x0RnVkRFkrTmZMSUgrdjZZMTh3bEoyMFdYdmZSNkNVZ0F6?=
 =?utf-8?B?WVI0a0c0ZDh0QXl0aHNXbGQyYlZJRlFEVnlUNkJqSFlBWGlkeWJxRVdhc29x?=
 =?utf-8?B?SThPbmtPdU5kY3l4aTBqUkc2MU5oYmZpNzczRE5MYW9iNDhtSnlsNTE4SHFC?=
 =?utf-8?B?QUJNWXFMR2x2RVB0RG0rdUkyZkNQekJMSUhzMEk5TFRSRDVkQzA0Z1d3Z1hr?=
 =?utf-8?B?akNpN01KcTFYaDl2TjJyTk1OdWpzcUFTTU8zbkhzMzhIbU45WFZVaktRbkNv?=
 =?utf-8?B?aXA4NE1rWnlvalR5VnZTeTV0WlZENnJhOTl2MTVkL0dHVE9OSUViMm10NktN?=
 =?utf-8?B?SXRUQjlaSmk5NitieWZFRHpJYzF0OFZ4eHRmbTVQY29yaHh2a1ZHYkI2VFdq?=
 =?utf-8?Q?NbwMoYPxHH/x9h0sbR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1697dc-c1a8-4c95-a71c-08df40a7503b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:25:46.1261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBW1OtzM+jARm3Z/KuD4wmNEzm3eBDygqe135Yw7icFn6bLSx6X+H6Hx1g+R2kTw
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

