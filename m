Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B840606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pPwhYTgV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D9410E793;
	Thu, 29 Oct 2026 04:44:14 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7917710FF88
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 04:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpYNpcgbTwRWpKVZZrciHIBjhLHKy70ZwOXiJH7kCZaGZWZdGFUtx0Z9O3qC+X7HtvGKzAg9MPQ/0M9kblEAfbgR7Jmjz20fGVLpakswBd7948weI72Rtr7tZvYPzZ6hkiIZQm7eApvikSPw1HgyZaGIOzTVto9HFnD5pGmaEVbhc85+ctG54u0etYr7Sq87C5+k8sAhA/eeVD4pCgl9N2UK/J+29Mu/4LueTBSzYht4BZ390e6x58R2+0F4Yb3272f8k/TonrCXNk7UgxyCdBJojYL+GO1DZArf4YOoryCctOL30SOJ3ZrhdCQjtbTBIigsTHdzpemufinx7CpEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAYzTtqGWEjJX1XR5syQY6kB6UUbtgohYk9qb72+vj4=;
 b=aFTC3FFbgM2BT+K2EjTlWc4Caxx+n+p5dVRDGFqy6kOl4ezBO3l9ZHiW1qilY5w3CHEkeYxIHLK5qeZNayPI1QBoa8um7kVsBxmiIHtvPIAkvNPxudetOkEd7hFcNfqtXY1htptKKEEsQ54v9Usy9jgI3z45RNMM8b6SFe8AiUq5HNvSFrBZpiUqoX8ItrIhlnQ39dikQd2nisixm/v8lIsHlbcesGRZJe9k9y8AtBjOqOPxEHKzY1MX91NTO9XLJMaUuqz89wyj6nvsALqBhu/zPzJL/4mzFjLRjd7tPyj2jdeUEGbHx+pb2Nl6D13e6svBzGoNOS4a0ki9SxntmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAYzTtqGWEjJX1XR5syQY6kB6UUbtgohYk9qb72+vj4=;
 b=pPwhYTgVxaACMwaLR8fjW6VMnU1ENsmZGCXRPhWBJROHv/aQPIIn5QKJFBhogvp/kNHRqdLkogM7jQAqjL6BZbGk+r+G37gYdsK74ekfgY4PleD4GAm71Am9QTyXIP37BHdIV+2QZrwWVeO+PiEFHkdFU4CXfj9je9jX/bQfMrM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DSVPR12MB803185.namprd12.prod.outlook.com (2603:10b6:8:3ea::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 04:44:03 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 04:44:03 +0000
Message-ID: <70f8340a-267e-4bba-9611-07406c552cb7@amd.com>
Date: Thu, 29 Oct 2026 10:13:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: abort SPM VF init when the HBM aperture
 is missing
To: Chenglei Xie <Chenglei.Xie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Zhigang.Luo@amd.com
References: <20261022153132.211631-1-Chenglei.Xie@amd.com>
 <20261022153132.211631-2-Chenglei.Xie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261022153132.211631-2-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0041.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DSVPR12MB803185:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fec920-07f2-402e-5bd1-08df357741ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|261028144727099003|10067099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: Ow26YgxjATwuXlhCA8H5SCUVgrhD/FMoougKNRNj9BdMMNm2g01eOdNqU37nK1AWVVbQm0rJ6DfRt2YzzVoLScJStsY4ss99XbCCWnlMdUvGg6oZAqkj1yAdi5heBuBhUEu0ZPClIusiv5FO3+T5wyAJrkDM3SbalwC9YDuLk4ppMjlpteXful7Til0WVsQ6CuvsLo4oAce5h4rnflU1tfAwXbTGaw7hOFbJFvFZ3aPuW9I7A+puHa9iuBauQijcRIY2gDe6OVN7BCnaKjYiF/onHy4ew3eq4kSVPbQVuR62bR8Fpvr02IuwVtGVA+CJPWCw8f5z0fIJ4OjSwSLuCvirje3lZ33eOkMpH8sFuOEnxMYiATIJW4pkBwQ94Aeq2uTEGukUMNeUY6uLdo7WzhpCtitCaRUohJV2YVNBlse92d2kxeqh2LCrDLD2DHaaKhm0VUYhL5Qwe6gHoPmaikCb4TcAx8wnCHazz+/rL15IjIe+vhEABNCV0ZvHtxam4PzeIktWKlmNngXunIVNAmiXe1ecwJOEVdmqeghQ7XA2awYj4FMO2eDvASSvcTXdCrTFoTTWj+aEbw2xBUi9bBFYlLtoMVSWFSEynp6xO5qZa2xa40R+u1VNe4Let3172tjN95wCI8FSMLnGaSKW8/vB2dPI4LL+hz2v0OeBKWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(10067099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZSNHBNTVY5MUhOYlJGZE94WHJ6QSt4eGdoVTZGRHRBaDJoNjNmTTBXSXlK?=
 =?utf-8?B?NkJjNkhvWGx3bTY3WEdyL0dvVFdxVFIxQmNscXBlU1A1Rmgwb20rTkhYOXd6?=
 =?utf-8?B?bjQvV1RaUlYrSWZVSTYyZjI0dnhKWXducjl0bUphVGplbWVTcmwyVkczT0Vj?=
 =?utf-8?B?dVVlekR1STFZQURMRmNRanJxTCtiTGZrTmNXbGJhVnNFdi9nTFNiREJ0ZVZV?=
 =?utf-8?B?cHRQc0VTL1dYT3hoS3hxOEZDK2xIYlh2Z1RNWHdlaTY3Sk9EeTAvd1Rvek9T?=
 =?utf-8?B?T0l3TUhmY2dRanh4TGhaQW5xaitSdS9YMEpUbVJ3ZUcyK0xJOERpWnRoc3ly?=
 =?utf-8?B?ZnVZMW9Hcm1Pby9ob044ektXc1VnZ2diYVNiL1U2bkh2akxOVXAxRXYzTWkx?=
 =?utf-8?B?dllJM3p0TXg3d2FBVGhJakZzT1dCN0Fta09MWHdvVVpBWEQ1eVN3bVQxM0k2?=
 =?utf-8?B?aFh1SU1yVGw2Q1lkTklNbXNYL1ZTZnBKekFKTVlBMDMweWxjWW5DOUxySTUv?=
 =?utf-8?B?RjBoUlJyOTVycDRKK2FpbTI2QmEreGxXMXk4RHVtMmZWcUhyOXFZOHo0TGlT?=
 =?utf-8?B?ejF5V2c0U3JQK0E5UnFmR2VHN21EdC9lV1JJNjF5UytkcjI5Y0RmOGRvaWhv?=
 =?utf-8?B?Tk5XMGwyVStPSDZ2a254OTdSeUc4SFEwUnNvcVZHWkRSYk5UQkg4QzdUNkNo?=
 =?utf-8?B?VkFnb2EySGl2YlhQbURuUkNMcmR5Q0pRQ0t0VkNmRklFOHpXWUVCcWJid0M1?=
 =?utf-8?B?cDJsSWxSNHlKVnFsd2hta1EyQ1lKUlhZTUcyS0YrVktlSEhZMVlDWjBNbWha?=
 =?utf-8?B?cWQ2WkxZOGRLT3FFM3prQXp4L0lmVUVCQWs4Rzl1K09BSjNGYXhKQ3dRRDVk?=
 =?utf-8?B?RnpaNTcrSTN1d2YvdG1GSXlTYk96dzk4c25JZFFrNmZRMWVXRFpoYW80dmhz?=
 =?utf-8?B?ZlR2TjFHUDhWMWVVUXpBR0syMEhmcktZY1BKZncyekROVkVhWWlTVSttMnha?=
 =?utf-8?B?YzNZVVc2SjlNVUhYdHVpRFVLL0V6bS9wSFZURlNseVp1K2hldURGRlBsdzkx?=
 =?utf-8?B?N2FYU0RzL0gzMGhqSXg3eE9ROGRrdStKR3hPaEFZZjhRbC9sNXRJeU5HbG5O?=
 =?utf-8?B?blpiUDRSdUtjN0NDNjF0ZVhaNlJBSTdITFhEWU95UUtqRjNjaUN3Q1g0S3Yw?=
 =?utf-8?B?cDJqYmx3d1N3V3RPR0FmeFJSTHdKOXpSdjFmdmhoVEZJSERYNHNwL3lRWGc2?=
 =?utf-8?B?Y1NGQ1lTNW5PNUdDQnB2aGxCMGdoYUppdmlQZkpZdjJpaGI0TUtRbFpJRVZX?=
 =?utf-8?B?S0VFMHJ3MU85WVZWWUpDUWVMN3JwS3BtRWpOTGltdEpkYllUbyt4QXRheHlE?=
 =?utf-8?B?a05BeFhKajdPemVOS2Y3dFE0bW5EZUUvSGZYMkFCTTJxZjBuTFlSTS8wbVJV?=
 =?utf-8?B?UEthYVBKdUwyN0hXOTZWRStjeVpDMHlCSWM0Qk10dkZDakNQYnBwdVMzWHJ5?=
 =?utf-8?B?Mm9PWW5ESnhzVzc0RlBBTHFncEt6b1d6ZGNsakhrLzd2Q3FpTTVBUTMvdDZ6?=
 =?utf-8?B?VjVFSHllK1Zrb3JFUkgxMk5ZOEdXSU1YQnlFZnZCSWcrYklsMThOQkFSakFs?=
 =?utf-8?B?MkIrdTBFcTFqdVZGOHE0dGxxWFZTdWwzT2l3NkFsMWE4akZhMDlTOW5SWTFm?=
 =?utf-8?B?V0VmZGp4WENhanoxSUw0VlhlMS9yaFdGRTd5WWFPRk9kTXhUbUthcEtrSVBN?=
 =?utf-8?B?eEp0OVR2VjZKT2I5cHNPcTJvVVVVMm83SXpMbHRyWG1sTFV1dUQ3eEd2VDFP?=
 =?utf-8?B?MEJLak1sTDVBcWtVeGlJeTZzS2Zvdk9PUittRjlyMXBFcXZRRit2cy9DWFFB?=
 =?utf-8?B?aTVGbGM0YVBlUWxsWXozY0RneUlOM25UVnNsdFA5STVXN0hJcWZEUVNOQkFT?=
 =?utf-8?B?ZWF2S1VaVVpocEdSN3c0anY4dng5bjh3UUF4OFVQaWRtSkFXRmRLQUlEbXc0?=
 =?utf-8?B?dkw3N2ZWU041ejhaRVBnYUpSMm9BRWZXMGY5Qk9wWk9PNm5hMkZDQW1Ncy9a?=
 =?utf-8?B?QkpMZTNYTnQ0SGhaSUpudkNFaU9jMEpZaXcvNC9QdUQveHEydGJud0tuT1R4?=
 =?utf-8?B?SkxGdkYzSHBPWExLdXRsTjJVVnQxMk83OVRXQy9YWFJ1U3dOTTVzWDlwNk5R?=
 =?utf-8?B?RXYvVlRaU3dHaXpKMXZMYXcvWG44YUgrVlJ6Um9vT08wSXpRZXAzVkNvMmVV?=
 =?utf-8?B?ZTJZWGRJSjZoQ29tOHZtRjd1eEZXN1FrNjZPN3ZCWE5HdXU0NnVyTzAreURG?=
 =?utf-8?Q?gCDKz2utGyuuHKZ5k4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fec920-07f2-402e-5bd1-08df357741ba
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:44:03.1417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvVe+LpisyywegKQj0otoVaIp1nojuVdmnKb9/yuSvLkOVbb0vUUzOBXe8Qtopm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB803185
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



On 22-Oct-26 9:01 PM, Chenglei Xie wrote:
> An SPM-backed SR-IOV VF has no usable FB BAR, so gmc_v12_0_early_init()
> resolves the VF HBM aperture from the SRAT. When that lookup fails the
> code returned -ENOENT, which the early init loop treats as the GMC block
> being absent. The probe then keeps going without a memory controller and
> only dies much later with -ENOMEM, far from the real cause.
> 
> Return -ENODEV instead so the early init loop aborts this GPU probe at the
> point it actually failed. Other GPUs probe independently and are not
> affected.
> 
> Aborting here also exposes a second problem. On a legacy host the VF takes
> exclusive GPU access at the start of early init, and every error path
> returned directly without giving it back. The host then waited for a
> release that never came, timed out, and recovered the VF with an FLR.
> Route the post-acquisition failures through a common err_release_full_gpu
> label that releases full GPU access before returning.
> 
> early init also fails before the CP scheduler is programmed, so the host
> treats the VF as not active once it sees the release. Clear
> AMDGPU_SRIOV_CAPS_RUNTIME and drop adev->virt.ops at the same label so the
> later fini path does not send a REQ_GPU_FINI that the host will never
> answer.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 11 ++++-
>   2 files changed, 43 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5069042b5279..10002b78c69d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1999,7 +1999,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		r = amdgpu_virt_init_critical_region(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   	}
>   
>   	switch (adev->asic_type) {
> @@ -2012,7 +2012,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		adev->family = AMDGPU_FAMILY_SI;
>   		r = si_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   #endif
>   #ifdef CONFIG_DRM_AMDGPU_CIK
> @@ -2028,7 +2028,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		r = cik_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   #endif
>   	case CHIP_TOPAZ:
> @@ -2047,13 +2047,13 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		r = vi_set_ip_blocks(adev);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   		break;
>   	default:
>   		r = amdgpu_discovery_set_ip_blocks(adev);
>   		if (r) {
>   			adev->num_ip_blocks = 0;
> -			return r;
> +			goto err_release_full_gpu;
>   		}
>   		break;
>   	}
> @@ -2062,7 +2062,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
>   	    !amdgpu_device_get_rev_id(adev)) {
>   		dev_err(adev->dev, "Unsupported A0 hardware\n");
> -		return -ENODEV;	/* device unsupported - no device error */
> +		r = -ENODEV;	/* device unsupported - no device error */
> +		goto err_release_full_gpu;
>   	}
>   
>   	if (amdgpu_has_atpx() &&
> @@ -2123,7 +2124,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
>   			r = amdgpu_device_parse_gpu_info_fw(adev);
>   			if (r)
> -				return r;
> +				goto err_release_full_gpu;
>   
>   			bios_flags = amdgpu_device_get_vbios_flags(adev);
>   			skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
> @@ -2131,8 +2132,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   			if (!skip_bios) {
>   				bool optional =
>   					!!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
> -				if (!amdgpu_get_bios(adev) && !optional)
> -					return -EINVAL;
> +				if (!amdgpu_get_bios(adev) && !optional) {
> +					r = -EINVAL;
> +					goto err_release_full_gpu;
> +				}
>   
>   				if (optional && !adev->bios)
>   					dev_info(
> @@ -2148,7 +2151,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   							adev,
>   							AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
>   							0, 0);
> -						return r;
> +						goto err_release_full_gpu;
>   					}
>   				}
>   			}
> @@ -2159,14 +2162,16 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   
>   		}
>   	}
> -	if (!total)
> -		return -ENODEV;
> +	if (!total) {
> +		r = -ENODEV;
> +		goto err_release_full_gpu;
> +	}
>   
>   	/* Request full GPU access only for the remaining SR-IOV init work. */
>   	if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   		if (r)
> -			return r;
> +			goto err_release_full_gpu;
>   	}
>   
>   	if (adev->gmc.xgmi.supported)
> @@ -2184,6 +2189,22 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	amdgpu_smu_early_init(adev);
>   
>   	return 0;
> +
> +err_release_full_gpu:
> +	/*
> +	 * Release the exclusive access acquired above so the host completes the
> +	 * handshake instead of timing out and FLR'ing the VF.
> +	 */
> +	if (amdgpu_sriov_vf(adev) && early_full_gpu_access)
> +		amdgpu_virt_release_full_gpu(adev, true);
> +
> +	/* Don't send request since VF is inactive. */
> +	if (amdgpu_sriov_vf(adev)) {
> +		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +		adev->virt.ops = NULL;
> +	}

I think this is not the right place for this. These flags are not set 
inside this function.

> +
> +	return r;
>   }
>   
>   static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index cd276a138e10..5c6a20e42000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -667,8 +667,15 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   
>   		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
>   							&aper_size);
> -		if (r)
> -			return r;
> +		if (r) {
> +			/*
> +			 * An SPM VF has no FB BAR0; without the HBM aperture
> +			 * from the SRAT this GPU cannot init, so fail its probe.
> +			 */
> +			dev_err(adev->dev,
> +				"SPM VF: no HBM aperture in SRAT (%d)\n", r);
> +			return -ENODEV;
> +		}

amdgpu_acpi_find_gpu_memory_in_srat has error logging. The error code 
returned is -ENOENT when table is not found. So this change is not requred.

Thanks,
Lijo

>   
>   		adev->gmc.aper_base = aper_base;
>   		adev->gmc.aper_size = aper_size;

