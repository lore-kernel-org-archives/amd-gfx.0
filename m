Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26667C88E5C
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Sep 2026 20:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D90510E177;
	Sun, 13 Sep 2026 20:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gdgl0KN5";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013042.outbound.protection.outlook.com
 [40.107.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5C710E177
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Sep 2026 20:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld1gr6NswaOiPFT+Nf/vIQDG9gxr9a3T7aINsTjw8j7mDH1b1kJ8XOlUDyFsh7DPleLQhzkFcQiH7BhKLYMXjD2yfjMPjJ6eL+Dva9E/zGVn/y6f3ZTwHeVj9K2dnNBFFj75azvaGfS3wT6KFF5WoeFmA7i90tNJlGD+eZ3wg7nWvXS/N8g3gXC7sgG7Plf8mRtJgrLNroHST/4ZcFjGSLhYRoMrOBVkNi7jyTOO7U4WdPtKjjTbxQhIDaoPAWxXQmrWFEfjb0Tq813+Dtj3l79G91sVMAfR+I9RpT0waH5s7F/mxoeyc3BzqoVkDM1m/eATdekqJNgiru3IK4zKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQmw1HA+rgmnGh4WkumUqeBnPQR5nU/KVal6XKI6Aqo=;
 b=tGwX5rhouTuR4LT48pKIW14btG2XBd/0WoFQNzmOQipiixi9A0osIXWZpnjHxKGp8reN8yAXhnBzEwldrfyCbwxpZNL0fYGjoUGe+dF18ke1VmfZTfcTSLzuI7G9PzN/HRGex5Igzy55djcUqMoA9hNM93Vv7ix9ssji3o9i8tNyzK71Lvg9jdI2UZktzo9Dz3udBNef+hoyhDjR7LTZJKI/v7q3Jrx5vmQyE+uBRcEyE9T86v/pcmpLnR7QXf/DUGDcW0U7PmSZ+8YNRJ+Dd9RJPlkXHGLzE4dmKpI/ugg37d8OrFpdIBkPZcv+bPxigapzQptVYWvf7H/zQJXHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQmw1HA+rgmnGh4WkumUqeBnPQR5nU/KVal6XKI6Aqo=;
 b=Gdgl0KN5NGfyCdRZx7ul/vfVS5qjo7gVg2fd0VqxALz0au8ncjyOW15iR27vNQDUAOZmd6LoWQbanyKzgbehha2XsalhrUaa+DVsp8JmvUrSbSIh0Yu9EPNlZsIp3VOa0331iqZOpJmk/QTp17es2eZxGL9AAApyha/RNiop8g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 20:48:13 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%5]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 20:48:13 +0000
Message-ID: <046b6af2-147d-494f-a61e-e84da46de022@amd.com>
Date: Sun, 13 Sep 2026 16:48:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] drm/amdgpu: remove drm_client suspend-resume in the
 gpu recovery
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20260902125001.621629-1-Prike.Liang@amd.com>
 <20260902125001.621629-3-Prike.Liang@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260902125001.621629-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0064.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::19) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a70535-a595-41be-1dc1-08df11d853ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nDPOmrDz/1AM2DPHUmBi4M0qcnq3gCtgqSeWH2DUoyOD3jzElDuPqsQr3pq5xDV7q38MjGePoITM4MgP9vdEg2yslFILeQO862iZ+ByX04jYle82UJTnEKDJ62rJHyoYTH7C1DDTMt00BwpwPXhhLuAfeoA9pFcUrdcG+W3PtLgh9f8lXZOsq4jGoIFzF5tsVipnmESAkaeJZZGHQ0raFsE3W1cecjUvxhRODAIcRgblU/iBPVd1Df784H/tDK+xPq7GT5WQxrrmm5oBK2ipCiMuEML3yGKd6CgynkgWM0lBLt75rDeXIem3eanmjqX4MA5xhC0jhZuBxDH39G3+NfYxQQsrn2Ogl1yg5k5pDpd28Y/hUm95KkZibbHWkpvDntNxKAzqThjQhxPKdHkJEmuJj2UDcyqawWhVjylasS3V+3gTlP2xtlfVamhWlh4K/zYmW5nXSrMACDAEGpDAflbQijqg40X8McDm5jyQpU5pATvL4aIj15/8CaAdyIdTGTVpTwf+WVcjE73jUciFgxuQx+6a7t8SVOcVM6oj/OrrF4guhNxr7hms1B0Hh0CzTyLCtIq1bfW5zV6BLOQn9lbfKJTfXU/IWWCfEEZg0n0FWraD8bV/4XKqOtdJX6Phi4WU52tarQqHXAifWL3gryGNIqbPKDXVBXNWyU6zqY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEw2RGhRL2NQTHh0VUJGMEVBWVdJdXloVlNDUzlTZFZXbnVKSVlZK1BxMkU4?=
 =?utf-8?B?UlJRdC81TW1lWkFIalpmVjg0ZHF4c1VRb2hLVDREQWZLTDJTSWV0TFVtYVFn?=
 =?utf-8?B?alpPaVRxWTlTL2hkKzJOdmpPTnBRSThOQXFkK1NrajJNakhVMU41RU50YjQx?=
 =?utf-8?B?WkZWdElrOWdzd2M5N2hsUlRadGdtMnZvbWUrSUVDNmtEWFNMK1RBMWErV0FE?=
 =?utf-8?B?OVQ5M1BBS2xjUUdLVlJQQU9PanMwWDlqYVVvZHRwbW9MZ0J5c3FXZUdUdjFD?=
 =?utf-8?B?dmFORUJ4eHEycnpOL0VCMUtEQTJ1RmtpRjNCZ2NXS3NvYStEcjljREp4a1Nv?=
 =?utf-8?B?akx0TlphWGw3M1BqbzVWQjdxTDZuZS8zbmFWNzdzSThqRVhkQjdIOXgrM09h?=
 =?utf-8?B?bnUrM0pWNEYxNjBwYjREczRCWEFKalJodUlCaWNjWlFvSE0rR2pHcUxmbi9x?=
 =?utf-8?B?V2d4emVCaEl3TGlUMXBtS2dXLysrbzhWOUVJR1l6T3pVVzNIaElpWndVVGEw?=
 =?utf-8?B?S295V2VaZmFUOGxNd3BrcXp0NjFndTMremcrMHM1MWVqWjBKL0oyYUkvaDF6?=
 =?utf-8?B?VDNmcVNQQkp0aks1VzVtM0pPU05xb3VEdnZLaGM2YnJCeVVnenI1MnFzNkpz?=
 =?utf-8?B?cG9IRElTVHJJYWU1UVRCNGVHemY1RXRZN2R6V1RBM1RCdy9lV0IxNDd3L3ZU?=
 =?utf-8?B?R2RkZUZmbUQyQjhmbE84cFNuS3l4N0xmaUdaenRQa0hwcndPZ2NTeVByUG5p?=
 =?utf-8?B?Nll3WjBOS0ZnRDN1aW5vbHhwU3M1cWU5R3hZZk82MUN0bXFsUnBPOTIxQUJL?=
 =?utf-8?B?RTluTmJPaGJRKzI0Qm4raDRGV2sraENZbUo5cC9iLzNhY0dtNVdxbksyL0R2?=
 =?utf-8?B?T0RBNHQyUFpTb3VsZ09VTVpld0tGS1hwVzZDWVRodUhjanZkSndib1JwQmZT?=
 =?utf-8?B?QTRGeGJFUUVFV2NhMmJ2N1NON1IrcCs0R3liTTNzWEM4aG8rR3BSZW90Qisx?=
 =?utf-8?B?UUwzTkFZZFNoamJITGtxeVhFMW1Jb1IxL0pLVkllNGtDSW1qS1Q0ZUdNMHA0?=
 =?utf-8?B?Q3Rvc214ZS90eTdVT0ViTUxoSm1vOGx3Q3hoSURwTlpBMHdtdndxZllqV1c4?=
 =?utf-8?B?R2xzM3hKRW9XdkFRNm1wQ0E0NzgzV0pwWlJ2b0MxUXNoblk5L01HVWRrWVZh?=
 =?utf-8?B?bDRVL2tvbUJpTSt0UllyWEdDNUVPZTFHM21LdlAydE0walY0YmVvODhnRnhu?=
 =?utf-8?B?WDhVQU1DcE1kbGl1elh6eWY5NVd5R3FQK0RiQ0hNRjBXTzhzZHgwcVRkMmFU?=
 =?utf-8?B?VXV2S3YzaFdGQzhRVmNaenpTWnJvRUk0OTJxTUczTkVjcEtQV3h5ZEFRWVlr?=
 =?utf-8?B?ZjJjdGpJUk11Tm9LMmlNczF4VHN4R1pCY2JTN0lXekI5NGY4cUhpcFEvQnRn?=
 =?utf-8?B?NWVLNmVmR1NSeXVidmtWa3BNdEV2anJIaXZscWwxRE5lWFdMUW5pbzd0ZUpr?=
 =?utf-8?B?Q05QY2pOT1RMSmt5STNuaXFqdTJ2Yzk0NnRUVzEvVEEzbEpOaVhWa1FxWWNO?=
 =?utf-8?B?WWN2SGxsbjVYZ05hOURBNit2Mk9ueXVoZHJzQmpFTmlqUVVLbDJGTXdUb1VV?=
 =?utf-8?B?T1hNSHBOMjFTSFFQOTUxeWtGSGFGaExFYlllb2hyZVpJWDdGNGQvc0hEQ2pI?=
 =?utf-8?B?di9Vc0pxQkdqN1RRZVpsWXo3eVo3bUJBQUZ4YzNzUXRYTHVSZm9YRE8zd21n?=
 =?utf-8?B?bWwya2tiY3ByNzBaaVE0U2FtbXM4NE5KdlVPbE5GNkkrczdFaERtMnFQVlc5?=
 =?utf-8?B?Rmc1dEcrN29PRlF0RC9qdlFyYWQ1bTdOK2FQaUVJaW9hMTJBc1I1L2I1dURN?=
 =?utf-8?B?dVdxUWVUd0t4ckF2ZTUzNXpucVRGZHdaeWdGTFNEYy9qeEFkaGh0NzBJbFow?=
 =?utf-8?B?Umk1SVJjb2djek1zSGplYW1NbGszb28wYTR6UmF3UkZWK1JJNFc2d01odVVy?=
 =?utf-8?B?MTlSL3kyaHlLUUQwVGs2WUl0enkvNFhNWGcxTk9UZGxlUTlwOWdQWjBMTGJt?=
 =?utf-8?B?MmdqTmVIR1V3cEpZV2hWeW5OYVhlbXNwcGZtUlB2S1VyaVB3OHhNM2RlVjRR?=
 =?utf-8?B?TVJsSTIwZ2FQK3VQdzVMNnZZYWZ3LzJ4ZjBxdjJNZy9BcTRRT0FlNnpDRUpJ?=
 =?utf-8?B?SHBSL1dmRWxUNkJKeXBYQVgrZ0VXS1h5Um1DVzVOUHpId3Axa1BRSisvaysx?=
 =?utf-8?B?djhLQU5vVVVVTWVZTEx0WFFIQStYOHhvOTh1bHBwU0RrQXRwelZPNklYK29B?=
 =?utf-8?B?NWRmRXRRbHJLVXRoMjJsOEd1RmJlcHVITjVkREdQdUt4aEUrTDlaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a70535-a595-41be-1dc1-08df11d853ee
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 20:48:13.0507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkGTDgNF/wexii9OVN4/RuBLPO3zq/M+fWT8kHYZ0e5FycPONlt94xcsVQCMu0rhLfpIuSjSR53zgRkhMQ83tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
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


On 2026-09-02 08:49, Prike Liang wrote:
> Suspend the drm internal clients has a deadlock risk as acquiring
> it while holding the reset domain lock inverts the ordering
> established elsewhere (clientlist_mutex -> ... -> reset_domain->sem).
>
> Reset AMDGPU can prevent the user space clients further accessing by
> using the reset semaphore, so removing the drm_client_dev_suspend() |
> resume() in the reset path.
That is only true for ioctl paths. amdgpu_userq_restore_worker is a
workqueue, not an ioctl. It never takes reset_domain->sem. The removed

suspend/resume call was the only thing blocking it during reset.

Thanks, Vitaly

> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d7640da9f6de..bd4eb97336b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5210,8 +5210,6 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>  				if (r)
>  					goto out;
>  
> -				drm_client_dev_resume(adev_to_drm(tmp_adev));
> -
>  				/*
>  				 * The GPU enters bad state once faulty pages
>  				 * by ECC has reached the threshold, and ras
> @@ -5544,8 +5542,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  		 */
>  		amdgpu_unregister_gpu_instance(tmp_adev);
>  
> -		drm_client_dev_suspend(adev_to_drm(tmp_adev));
> -
>  		/* disable ras on ALL IPs */
>  		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
>  			amdgpu_ras_suspend(tmp_adev);
