Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE19BC5DF71
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 05:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F01C11385B;
	Tue,  2 Jun 2026 05:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yl9vibG6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9A611385B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 05:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE/T1rkd9RAD/tBfHU3bs8qvGkrWBDbEcHnvBImRJQc3AEJPhD1BoC/QiMek++g4AdTyXI7C9C0YkF2zPoK3vUdDHN27IGV0Vw9W5mcUkYHbk9BmwzVfXk3ufBlaW60VhLrQLID6nYF5D0zd6rAEdn0A+rN2V52EzoykXVCacjGnXCPzEl6N9A7UMLQ68vFpVn8N2v+qbb4tVYt00ZZC1gKXOEqUnGTtE5qPDAe1W/SxTsc+b8p5+1fpHo+PqII3vJP/FlPDTvALHUqU2cVadXMz19hHT1hqbjg3bkvldcnlJMZ9dWpiG5OG32w2WgHvx5NCGqjVCqlou431BZehGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSxwSotYx6zxgThyOdE1m2XaSo6NddBmes9VXWen4ro=;
 b=U9nUR+NsPuBWoH5TiCDr8/SPXTi/W5v7ot4JLONK4P74pdXlB+7DBn5O+6g+lCgn6taL4ZhQ76R+HG+CpOzaY3c1XFLDINKgwpMcgFrl4WcZgueUV7FPQb7cVslZfFDZLx1+ZkTGjXH4GJkY8qlhJyG9nYAceY8kw2QBpgybx/Iq5sfjf2lSS1QKm3jHKqfBFgJahguvoO+OSA+g5NNk7ey5DLxyU7Lvr6aaf5hPqwJg/JEMMevXTMHTU5HUiZnaiPO5ANZNH4gtgh+i9jdXD/YEhmLob/LKLlLZoBN9Er3c8fIaYrpBbtZ3uI60NQHh2HT+zEquXx/02ioiJUtgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSxwSotYx6zxgThyOdE1m2XaSo6NddBmes9VXWen4ro=;
 b=Yl9vibG6RbxTNQtfYflAUuM9fXUYCDp5AYjTjqm5hGhzVKuC4uELXbDf/dSig2h17LQ5lW4aHNNpbkwHzyooMtagjjFMDIJfFWbuZuL6hN6KCzrKCN3WOJian5P5OSp4QPc438hb/eK6axAhcysZVIChI7xsDLAxdCNXFcUI9N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 05:43:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:43:58 +0000
Message-ID: <c20304a7-4f5e-459c-8da2-b67baab9f6cd@amd.com>
Date: Tue, 2 Jun 2026 11:13:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Add enum for PCIe BAR regions
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260601205553.239933-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260601205553.239933-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 544a942b-0ba9-4e7b-ebf8-08dec069f148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|6133799003|3023799007|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: c3aZ3A926wsM/CGyV0QuEZGC/6tt8rOASQur4ey5BVFQux6gweCguRHTiXUR0mVOZfj2wgQ3ROtgnnWXxIAlh2ZLJq2a9XMauclhegg5c7h1oQT4+eZ1NG3uyyf8a2+xpdpBaggUOdDagz8Uu4rkUnUZi6Xa5HHBAKneBFdNkLsxLqLm2ib8Aciau74Wo0yTY5fyPZDRyTiEx/pyahY3gL0Jh6Sb4gJmFKJt7cj57YzWMCIpxCjJEA4t/B/ts0l19UJtWaht2scW9qEg1JJt/BNh0+MLSQxoD+ubmJ2U1R/v1hhkS4zBNx5Zf39Y3swmHhnHvFzSwoTHjfShlpeeYUjXgiJDmTg7at7NzU3rtRH1lDVszNldvtFVP3PYVno0btiYm1IJo570bRxYzGv/hztG7/2i3IcDmd0a/O4iGhZvdPOrE4QaHYCCcp80/zsp3SzJs5x04GRixHGnNo62RoAECJzbiNY5FNMpVEXOyM9LXI3/sqOZNPNz0wCr4JoBkD6es2tbXIr5oFi0OXXCh6yaNx/rg7AapkoceLFKOqb4sFjO2liG7AniXF1J8fs0lPhddB+rGEvcaw2nwSWilz50kmx8XOpuWNC91JxYJGuyNZZCijX7It9R2EguGWfcZDaA9aVMB6zZnTwlULsBnLJIEDMLbd8Sn0rhKkNPhgUFNd8iztnMW5sIAKMHvm3c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(3023799007)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2p2RVJyY3lvbGpra1k2UFZ5RTN2NklNaEVIanN2MjdRb2lxSnJ1OWhURHdF?=
 =?utf-8?B?ZE9kQUlYR0hwUC80SGFJSy9SMjlROGtFbmo4bmRvT3BUa1VDY3cvWUcvK0ha?=
 =?utf-8?B?bzJWRDZOcTJTTy9kWmFtTXJaSW1kMUROQUw0WWpDUTFVSm43Nm5LMDdtL3ZQ?=
 =?utf-8?B?aHlhaHdrcmlKdFd6QkVsZ2xhR08zTXRxRVNBeGlSQjJBVE5nVFlQNHBESXIy?=
 =?utf-8?B?WExseEgreDduTG9DUDIwRVRkd2k2ZUZBU25QYWZIalVsdjhFQkVGZlUzbFlS?=
 =?utf-8?B?LzZYSmdVUXVoRDFBcXBjNFBEem9OUlN5cGE0YWk4S21vblFJUTRONS9pb3pH?=
 =?utf-8?B?ZmJXWkl3TlhCeHFVMktRRVpxOWVhUStJQ1lpTldGVUNrK011dXBjOVFPakhr?=
 =?utf-8?B?d3pzZHlVc2xWVVFnTXdPdyswSCtjRERlRmp4bmFJdTFrdno4Nk5hYmdJTGxY?=
 =?utf-8?B?TjMxTklkS2VqZVg4YTFvWENxTUZDVnZlYzExMkZZSUI3UjZZaEVIOGhLQkor?=
 =?utf-8?B?eXZCMHBDbEVqdjdtalVvcWIxWEdNV0FwN0NGQk9HYjE5MVpaSVl6d1l6NndL?=
 =?utf-8?B?MG4vdjJZTFhTTjdtMHVqYnVmalJuem02Zk1KdE5OTENsYWt6WkE1ckxxOXU4?=
 =?utf-8?B?UHprN252VzZsNVFiaHp2QWtEdFc2NUc4dWFVN1B4ZENxbityUHlURlMwTzVh?=
 =?utf-8?B?dUc5QUI3eHd4enE3MkduMG45M2wzQVBDeXlETGxKK2IxQWdkL01ZTFlBMUs3?=
 =?utf-8?B?Ly91TXdkcUxjcmVEM1NHaVBGNHoxSm1DcDFUYnphYlpkb21wWHpLTWs3Qmxt?=
 =?utf-8?B?RS95cVdpU1ZrajNUeGNkc3l4Wlhhdnl5cGVPSDZrYUt3Y2lRcXZqaVpSdkU2?=
 =?utf-8?B?MmpMSyszSk5xSnI1aEh6NkxYSDdtOTcrZHUwbmQrbWpadnZhZnQ2bkp0R2Ni?=
 =?utf-8?B?dVhDbi9wcHJuRFpMUTN0SDhCc09uclQ5WU9jbUNZUUtRZlJOTUx6akNHWnFG?=
 =?utf-8?B?SnJMWUJCU1dDeUVEVjl3NDRtTkRjdDh2Slp3QUZpV1FUVTFNNy9CTXppMXpR?=
 =?utf-8?B?MlJZSEp4Sy80bmdWK21PcGJDSnZlSTl5cndFa3ZTZ01JeHlRTDFha2ZreDVG?=
 =?utf-8?B?TzVsTnhzb1pteFg5aVVtSUhIQlNHaHl1bVR0bXBSU3U3cTBGUGk4SkdUNFc2?=
 =?utf-8?B?VVFSRXdxY0s5R0tGUGNOSDJ2bUlRUHFlYXFpOEkxTHJSUVdCV3J2cUlBNUFm?=
 =?utf-8?B?ZjFCdnFqQUE1ZnZkODlUOWxqWEhCQ0JhQm15aFREK2h3OUxIWEtrWEhvanBr?=
 =?utf-8?B?QWFPdlB4eDBYZGU4TTVKRHhSVjg5SkFqTkp6QnRRZ3owYVdhWTRickhMUzNr?=
 =?utf-8?B?UjV5Z0l6LzNJSkZ2eXppV2wwVDhYWXNhcUZ3UWdzd296bjEwLzBWR1pkT1BM?=
 =?utf-8?B?Zk9icGdSR2xkd2JHSGIzWHRuT3lseWZmY2tkb3AydzR4UlQ3MG56dkt3cGZL?=
 =?utf-8?B?UjhmcDBjQnJITDh0VFdiSTFEUkwyL0tCMGtDOUxoMk9mcVBKT3JQTHNxWFRQ?=
 =?utf-8?B?SDNFMitqSk5aQzdxOU9UbGhadGRzT2t5amM0dGh0UUhVZW8xeHVZOHZOemZa?=
 =?utf-8?B?QW1McUVTa3Vhc1NJd3ZXTEFiWkJYWjdUd3ovTXhoaWswYWRQaTlVVlZwczM2?=
 =?utf-8?B?N25EZEFLWWZTVEpwZHJ5WDBNaHJOTnptUEZObXBZVThMY0N1ZVRRaEZZdXhC?=
 =?utf-8?B?ZmJMREFudnBKcEZuUms5QWx4TU9LWlIwZitXWWJaZ2ZueG5FeXYzQmE4bGFi?=
 =?utf-8?B?N1ZSa2ttUGRsSWJmU2FBenRqZUY4SlZWaGMvcFZiaEREbGQzVEFXWC9jMWlM?=
 =?utf-8?B?aHl4V0FxMzZVVnBlZXowaGtRNW1TZ1Bla3d6M3NmTHN3QjNJcmdva3VhcDJM?=
 =?utf-8?B?SE1vSm1wMlQ1MzdIbERFODBpK0xqYVM2RFM0Yk9SakxEZWpocHhNNm9nQUVI?=
 =?utf-8?B?WEVBVytaZXVVVCtmMlhsQlBuWFFvT3ljOVdOdkxES1NtakgxMGN5aHlJVXhs?=
 =?utf-8?B?b1h5QncrQk0rSmtEREpwdndFeGE2eEJ4b1dVVngveVBCY1ZhbEU2eWQrem5u?=
 =?utf-8?B?Y3grYUF0aC83a2Q0b3gwaW1iQ1NpblBZajhpQkprY1c3a1NLcFZsOXJQR0xy?=
 =?utf-8?B?U2M2d0w3QUZwVEZsenpYTmFpeS81RUFCOS9zWHc0eCt6dU1KR3dabG1LU2o3?=
 =?utf-8?B?SE83ajB6Z2xneENmTk5BRG9pRldJRVh1bnpkZlovSEdORExYSWxrWHorQ3dl?=
 =?utf-8?B?eUoyQ3o2L2R3SDZjUXlQT0xWOHlHMHZhdEFBalVITDcxTkhDUHB0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544a942b-0ba9-4e7b-ebf8-08dec069f148
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 05:43:58.7216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkVlIh1KamP04V85mqVYXZeQruvdtscm7TA20b3dY0BUepa2jMV86W31UWS9zM9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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



On 02-Jun-26 2:25 AM, Harish Kasiviswanathan wrote:
> Use enum instead of hard coded values. There is no functional change.
> 
> v2:
> - Add amdgpu_get_bar_idx() to map BAR roles to PCI BAR indices
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 17 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 56 ++++++++++++++-----
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  9 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  6 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  9 ++-
>   11 files changed, 100 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..1944d1bece86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1405,6 +1405,23 @@ bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
>   bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
>   int amdgpu_device_supports_baco(struct amdgpu_device *adev);
>   void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
> +
> +/**
> + * enum amdgpu_pcie_bar - PCIe BAR role identifiers
> + * @AMDGPU_PCIE_BAR_VRAM: VRAM aperture
> + * @AMDGPU_PCIE_BAR_DOORBELL: Doorbell aperture (Bonaire+)
> + * @AMDGPU_PCIE_BAR_MMIO: MMIO register aperture
> + *
> + * Use amdgpu_get_bar_idx() to map a role to the PCI BAR index on a given ASIC.
> + */
> +enum amdgpu_pcie_bar {
> +	AMDGPU_PCIE_BAR_VRAM = 0,
> +	AMDGPU_PCIE_BAR_DOORBELL = 2,
> +	AMDGPU_PCIE_BAR_MMIO = 5,
> +};

This may just be treated as an enum, it's not required to designate 
numbers for BAR index.

> +
> +int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_bar bar);
> +
>   bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   				      struct amdgpu_device *peer_adev);
>   int amdgpu_device_baco_enter(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index aa039e148a5e..7e253bb35434 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -111,11 +111,13 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>   			return false;
>   
>   	/* FB BAR not enabled */
> -	if (pci_resource_len(adev->pdev, 0) == 0)
> +	if (pci_resource_len(adev->pdev,
> +			       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) == 0)
>   		return false;
>   
>   	adev->bios = NULL;
> -	vram_base = pci_resource_start(adev->pdev, 0);
> +	vram_base = pci_resource_start(adev->pdev,
> +				       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   
>   	adev->bios = kmalloc(size, GFP_KERNEL);
>   	if (!adev->bios)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ff224163bab..2e1e5791f123 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1103,6 +1103,34 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>   	spin_unlock_irqrestore(&adev->wb.lock, flags);
>   }
>   
> +/**
> + * amdgpu_get_bar_idx - map a BAR role to the PCI BAR index
> + * @adev: amdgpu_device pointer
> + * @bar: BAR role to look up
> + *
> + * Return the PCI BAR index for @bar on @adev.
> + *
> + * VRAM is always BAR 0. Doorbells were introduced at Bonaire (CIK): pre-Bonaire
> + * ASICs have no dedicated doorbell BAR, and BAR 2 is used for MMIO registers.
> + * Bonaire and newer expose a doorbell aperture at BAR 2 and MMIO at BAR 5.
> + */
> +int amdgpu_get_bar_idx(struct amdgpu_device *adev, enum amdgpu_pcie_bar bar)
> +{
> +	switch (bar) {
> +	case AMDGPU_PCIE_BAR_VRAM:
> +		return AMDGPU_PCIE_BAR_VRAM;
> +	case AMDGPU_PCIE_BAR_DOORBELL:
> +		return AMDGPU_PCIE_BAR_DOORBELL;
> +	case AMDGPU_PCIE_BAR_MMIO:
> +		if (adev->asic_type >= CHIP_BONAIRE)
> +			return AMDGPU_PCIE_BAR_MMIO;
> +		return AMDGPU_PCIE_BAR_DOORBELL;

Was not expecting this function to return the enum itself. Input is enum 
and output is a hardcoded index like 0, 2, 5.
> +	default:
> +		WARN_ON(1);

pci_resource_len() expects a valid bar number.
pci_resource_len(adev->pdev, amdgpu_get_bar_idx()) usage may invoke some 
static code analyzer warnings.

Thinking again, a one-time assignment of below ones somewhere in early 
init amdgpu_init_pci_bars() may be simpler to deal with.

gmc.aper_bar_idx
rmmio_bar_idx
doorbell.bar_idx

Thanks,
Lijo
> +		return -EINVAL;
> +	}
> +}
> +
>   /**
>    * amdgpu_device_resize_fb_bar - try to resize FB BAR
>    *
> @@ -1146,7 +1174,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   	/* skip if the bios has already enabled large BAR */
>   	if (adev->gmc.real_vram_size &&
> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
> +	    (pci_resource_len(adev->pdev,
> +			      amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) >= adev->gmc.real_vram_size))
>   		return 0;
>   
>   	/* Check if the root BUS has 64bit memory resources */
> @@ -1165,7 +1194,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   		return 0;
>   
>   	/* Limit the BAR size to what is available */
> -	max_size = pci_rebar_get_max_size(adev->pdev, 0);
> +	max_size = pci_rebar_get_max_size(adev->pdev,
> +					  amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   	if (max_size < 0)
>   		return 0;
>   	rbar_size = min(max_size, rbar_size);
> @@ -1178,9 +1208,11 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	/* Tear down doorbell as resizing will release BARs */
>   	amdgpu_doorbell_fini(adev);
>   
> -	r = pci_resize_resource(adev->pdev, 0, rbar_size,
> -				(adev->asic_type >= CHIP_BONAIRE) ? 1 << 5
> -								  : 1 << 2);
> +	/* Resize the VRAM BAR. Exclude the MMIO BAR from being released. */
> +	r = pci_resize_resource(adev->pdev,
> +				amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM),
> +				rbar_size,
> +				BIT(amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO)));
>   	if (r == -ENOSPC)
>   		dev_info(adev->dev,
>   			 "Not enough PCI address space for a large BAR.");
> @@ -1191,7 +1223,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	 * using the device.
>   	 */
>   	r = amdgpu_doorbell_init(adev);
> -	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
> +	if (r || (pci_resource_flags(adev->pdev,
> +				       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)) & IORESOURCE_UNSET))
>   		return -ENODEV;
>   
>   	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> @@ -3825,13 +3858,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	/* Registers mapping */
>   	/* TODO: block userspace mapping of io register */
> -	if (adev->asic_type >= CHIP_BONAIRE) {
> -		adev->rmmio_base = pci_resource_start(adev->pdev, 5);
> -		adev->rmmio_size = pci_resource_len(adev->pdev, 5);
> -	} else {
> -		adev->rmmio_base = pci_resource_start(adev->pdev, 2);
> -		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
> -	}
> +	adev->rmmio_base = pci_resource_start(adev->pdev,
> +					      amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO));
> +	adev->rmmio_size = pci_resource_len(adev->pdev,
> +					    amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO));
>   
>   	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
>   		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index bc7858567321..826b80481908 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -201,14 +201,17 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>   		return 0;
>   	}
>   
> -	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +	if (pci_resource_flags(adev->pdev,
> +			       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_DOORBELL)) & IORESOURCE_UNSET)
>   		return -EINVAL;
>   
>   	amdgpu_asic_init_doorbell_index(adev);
>   
>   	/* doorbell bar mapping */
> -	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
> -	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> +	adev->doorbell.base = pci_resource_start(adev->pdev,
> +						 amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_DOORBELL));
> +	adev->doorbell.size = pci_resource_len(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_DOORBELL));
>   
>   	adev->doorbell.num_kernel_doorbells =
>   		min_t(u32, adev->doorbell.size / sizeof(u32),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 8523833a74fb..728d93e96ea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -694,8 +694,10 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 16388e3caea3..a16e681b4de0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -694,8 +694,10 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 586703ec0dfa..5c2b4d2f3f16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -746,8 +746,10 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   
>   #ifdef CONFIG_X86_64
>   	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index af6944d2d330..5bdcc276244c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -323,8 +323,10 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   	adev->gmc.visible_vram_size = adev->gmc.aper_size;
>   
>   	/* set the gart size */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 93cf283191fa..d8b81d8ec954 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -379,8 +379,10 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 1d3ddffd5a11..99bfd4e42977 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -572,8 +572,10 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ced0f3941863..774e93590389 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1588,7 +1588,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>   		 * mode.
>   		 */
>   		adev->gmc.is_app_apu = (pkg_type == AMDGPU_PKG_TYPE_APU &&
> -					!pci_resource_len(adev->pdev, 0));
> +					!pci_resource_len(adev->pdev,
> +							  amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM)));
>   	}
>   
>   	gmc_v9_0_set_gmc_funcs(adev);
> @@ -1700,8 +1701,10 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev,
> +					       amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_VRAM));
>   
>   #ifdef CONFIG_X86_64
>   	/*

