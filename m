Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE02C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F8410E47C;
	Thu,  2 Jul 2026 10:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="op89GKhW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D2510E47C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srGAYqrfD2zOKrtbdGhPsbzxpfD877QuZEBUU7Bj95kTOyXtVdAIGeBL1yeNxtuhogVMuFL9qXvFtqEgt9OR7VlXu+gcqqI3s9QvtyDde5i0pDAmd56pO/pwatVcQmnNCsYYImzEm4b7d50iykQCBcKc1oqSWXvkPko2gWdXEFXhjGZh0u22lH1PmlClbIHjW9ENMm87Mzcmw67aSzl/dooh0lYOOEIaTvEtfG4XKGg69aSAYhk1/YGWo15zTJQc/YhF1HJF93ndtXjgk1gLY/XXxMDrS8iDooIt5D6mutnA2j+T4OL1PMmP7CcZbmhOuCBhkAJxqb5pJHn/pGOEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxtsnqT2I+Vu82j7MarQ9x3ygzCx2oW0Z6/CIEUzXaI=;
 b=FWwrCDtBhsdOjk+UG/mZhbpLBNrr7sQtG5FVKePHUEygyAmBVGi49NOGeQqaSDJoYagv76LkFpDJKm2fGpO3sUqu9LfMZ0GIpOiLOF/MoI33WI8FoxPL/qm7ZCexypeUgJrm+nGBedXNQfjwPEpGzJhH4Luu0KQUI5zFP17QaQ/l7WzgbQCbgF5hnTY/i6358nQvjsxP9IsrX3XxFREO0oPNzNUHpiTLH7yfonUCbuLa2bdjGeAJ1SHvxUyIEDF1GbRFVTel79kdIyziTMolld9i7phvKcRUO0pH5rTn1gxCHwIvbEfAE5jLB7DcxJbjV/g0PexcILcWWagGtiAiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxtsnqT2I+Vu82j7MarQ9x3ygzCx2oW0Z6/CIEUzXaI=;
 b=op89GKhW70Px+XGPcOscjHYCK7EzeGCnY7KN6mU9yHuZb93RDEKRRDJTqoJzDp5QENXLXeljYO+53envZwbPQX9F+QEMdAThHmnsqTAM6hOw5PkUgaCZ3KPQ7O7jH/Da+WHC5DbSGhWDXsuN45mxgrxDy6EZ2iwptOYQ4mkt7ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:24:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:24:25 +0000
Message-ID: <db6dcd7e-28e5-4f3d-94d7-e6388ff74451@amd.com>
Date: Thu, 2 Jul 2026 12:24:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell
 for retry CAM on IH 7.0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-13-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-13-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: f42252bc-a654-4853-ba53-08ded82416f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: B7Lk/GgradhJb6nvcArIuoWUrK1Tb06VeiGzWQtYVshbK7ChLo1+XGsl9hd+hPNTW3mvTmtF0WWZROehUChuVxaE+vGDW12+TBpQmrYykkA+IAHmxEvJcnbv0gCIVr8BE/6N/IjQAiFp0L/7RZHItdOaPu6oTFSPJAzT63G81re5ovp6BUtwGcMcftAqhXa7Wvb8fh7QjiNK9E3NcplWjYORpQqiaJvhEmzGT/wmwxIGYvgrnuobNcxbxyN8r0+Y9LEb5kWvTWazMJsEpPDQJSQ6Byrf21WEwzfzp+0RkK6VjcQLR81dkN1DoP7koh2voUCHwRv4zFSbcEKG4Yabs2IFeMDQNu0PZ+2IdZmEP91cWcCArZb+LxgCcWBODUzwz6q8oOR2t251y6erQ3cxxoZ/RFDbGZ4gPizZWvpZKCj6pAbtt7N4iIW6tMm1a9QJeVL6EQtHEsl2LkVBX79yY0LxleNwQKOf9Ojx2ujcniwoOQjAYzm0lRzSJ3WDKj1LxHm7C8PXqwUdxh2wFuoq17DOasu8mzrVQL6dDzZHfA1HQr4KF07JpQPIyLvsHLJfA9+0EPA7TqyAO+Nr8GKqAsNHGrbw5cl0sEAFXp7NsppWmncZO2Kn0Aw6pKn+cX/sbV/SkaeORtYaS3TauBlq5kSWFAFQ3OWTp8kEMv2Dk9yApewaNoYAFMbofz7EHlcMn4qOXVnrdznoo8AGuVQxLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlmT1RmTjkwWUcxWStzaWpyOWN6ejFWSnV6dDdmZUw4THYzM3FGYi90NzVh?=
 =?utf-8?B?QXdZdVNjVXJwbGhCbGRBMU1kbU5GQURhT1F4eHlTUStCakFQOVZSa0NRbEFo?=
 =?utf-8?B?ZWhrY0hXRjNUUFBzaS93WUlzL3p0RWp4RVBJd1FDckcvOXNNWmRyc01iTlZy?=
 =?utf-8?B?WFFwWkJNR1dlcCt2VVdkTTd4b0ZUZnVnWGkrdm5yekJ4bndLNFZhaS9oTkk5?=
 =?utf-8?B?dXJYODJ5M3FTTWhTRUk3VzhGcDU0V0JqUDMrMVcxVlI1YytFS2Q0bGlQUm0x?=
 =?utf-8?B?ZXZzMUdhVWFXbGVVbGlYY0x5THppMmFINTNlZHNHRllTNHJnT2hWVnBFL2lW?=
 =?utf-8?B?d0Q0MkZmTTNwSXVhRzJoYmc2c3pVNE90R2VFYUhWUDZmM2JVN1hrSE9uUmlM?=
 =?utf-8?B?NEUxVWtHeFhCQmFCdnBUZ2lmemFNdmd0S3JKK3MwT3M0VnVZdG9OT01kZ09P?=
 =?utf-8?B?c0dhdDI3RmZCVjNmcXRIZ3B5TWNNcTByYUhmK3U1SlFIY3lzL1B3TGpTWUx4?=
 =?utf-8?B?bXVBK2NMWWx2VC9jSi83bEpUTWd0a1JRRTVOWSszM0dkSnJRenFOa0o2cEFx?=
 =?utf-8?B?ZmFtdXk1SFhKME4vSU91blU1c3p4QW8yOWFHK0ZjSkN4WHJsVHNMQ1YzVlBQ?=
 =?utf-8?B?YXQ4TjNaTzVOOGlXOE56TTRQdmpVZ0pUQ3lHcGVpMk1RbkhIL29DOVBILy9n?=
 =?utf-8?B?aDJGQW5tN3hVU3A5OWVFdjB1T0tuZFd1TkxhdnN6QzFVdXgrUkppS1diZGRn?=
 =?utf-8?B?VWRLbmJyUXhjK2Jna1h2YW1WTkp1VkplZXZNTzJ4clhMY2dhbWp6OWJ6dkZH?=
 =?utf-8?B?a01aa1FZT28wUVdkOHBaOWNzeTFKa2tsTzVxSS9lSDlZelgxNmVxL3FMY0dO?=
 =?utf-8?B?RnhDejF5SDNYaXoyWEUrZGxQREIwWUJxRTBSeWpLVXhDTjl6bmRMNy8wWkk0?=
 =?utf-8?B?RDlzbnlwRWhlZUtOMVNtSkduckQrNU55Y3VTaWp5dTdyQktFaDBvTVBUaDh2?=
 =?utf-8?B?NEVoU09HSGFiRm1QSVRvTE1BZkZOTnRpcDNuNWt2cUFhNzYxQ3AwSjBCOTQr?=
 =?utf-8?B?bENOQXFVaWF0NUtESnp4My9BVHdzVUJpeG94VkN1dzljbE1vUHhLdWdkN1RT?=
 =?utf-8?B?R1EyWUtHbG9LMC9GdHhGaW9MZGdHbjArWklUTVJYMjhrUTFNY3hQRGQva2ll?=
 =?utf-8?B?QThIRUptRzdCTkpORFh4U3IvT3hmb3RaZi9FaTcwMzZGYlFSUVQ3bVFIUjdz?=
 =?utf-8?B?WlBMSmtnOWVKYnpKaktHMC9Ed3gwVVNHNFczdXJNZGxCNTBVZU1PQWRrd1ZX?=
 =?utf-8?B?dU13MjFodmpOeDlUWWkrVHN2OTVDYVlCRjRObnhXQ3haYTNYL2JDeHhJVDZh?=
 =?utf-8?B?T1AwSWZ2bm9SNVk3cUloa0ZHaEtUL015OXBBMzJlTXArWmhDWU1UeUFKcG1q?=
 =?utf-8?B?YmVDdlk4Zm8vK0ZsbzdUempqd1huSlhmVXpvWjFkWVhoVGhiWkZYeHVSM2xU?=
 =?utf-8?B?UHF5YnBqZVAxNy9QUGxDaXE5SUVJUlR5eUZrOGdMYm51dHNDdUt5Qk4wRENG?=
 =?utf-8?B?WG5zTDV6bjhIMHVMdG9BQjZ5VU91RWxEQlNjR0tMNmlKcjNEWXo4Ky9GSmxl?=
 =?utf-8?B?YVhCSTlpY05uQmhjTG1NV1UrVytwTGF6MmhhNkp1aDVvOHJJN2dpeFB2Mkk0?=
 =?utf-8?B?bm94V1dtOVlVZWx2UnVNRlpXZkZwMDRjRzdUSml2N2tPbDNwVTBNVFJSd2VQ?=
 =?utf-8?B?R0w2ZDljemgySWhOejdCRzVsdnpYdFNnRWJXVjVIeUpWcTF3cFdteGMvdmJ2?=
 =?utf-8?B?NmVjcGw5L2FzOWU2aFFSTm9hZXJRM1hkYnhCVzJDb1dhRzBCNFFnb3pRWlBD?=
 =?utf-8?B?WEtrZ1VMQ3JLTVhLSmhFT3FmNVN2a1AvRlV1TDBGcHB4ckRCRVR6S0FkejMw?=
 =?utf-8?B?MDByYVFUeFpPRjJsS0FnL1FsNDZ5RlA3SFV3cTd1NkdxdjN1Y2ZnL2I2MVVW?=
 =?utf-8?B?aTl4KzZXVTJMK3U2TS9pOVJLOGdDMGc5TlcreXpsR00xS29GSG5Kd2pDbmhQ?=
 =?utf-8?B?N0JpYWdpbllTckFhdGxUYnBkQ2htQTI3VHdlMjd3emVlbDdiclBGTlRDQkZk?=
 =?utf-8?B?ZTc4anAveEtTQkRMNmtHd1dZMkJJTEt4U3F2MkkvL3UrVFpCSWJIZnBiUEln?=
 =?utf-8?B?RkxSM3RZY01RZ1Q4d0xIQXJ3bGRSVzZFTDJOZDJvcGszL1RiVmlpL3BkeXVM?=
 =?utf-8?B?a1hSVGN4N1FoVWhYRG1Jc3JjTUJSUTBJdFFtVGgzWXYxYUlsM0hnazBUTS9Z?=
 =?utf-8?Q?QpIX3RZYOR78LYmZPG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42252bc-a654-4853-ba53-08ded82416f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:24:25.0010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUDOOz/4jzhT2rnvQJM4IowZIyZ9DJe4YaU6gyGNvHP/g3jkJFlOsXC3aL47Eq1H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

On 7/1/26 18:17, Timur Kristóf wrote:
> The doorbell is not working on Navi 48.
> Use the IH_RETRY_CAM_ACK register just like on Navi 3x.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index f1de6450a31d..291326d2ee8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -279,19 +279,9 @@ static int ih_v7_0_enable_ring(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index)
> -{
> -	u32 val = 0;
> -
> -	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
> -	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
> -
> -	return val;
> -}
> -
>  static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
>  {
> -	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +	WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
>  }
>  
>  #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
> @@ -401,11 +391,6 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
>  	pci_set_master(adev->pdev);
>  
>  	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) {
> -		/* Allocate the doorbell for IH Retry CAM */
> -		adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 2) << 1;
> -		WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
> -				ih_v7_0_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
> -
>  		/* Enable IH Retry CAM */
>  		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
>  		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);

