Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7408CD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 10:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7C011314A;
	Mon,  1 Jun 2026 10:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IxRrjZ9O";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF41F11314A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 10:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcpDk1QIOQTPfRgwHVma7NxhCO/mh+n7ZYkf6s7Q9KfEQPh3R7RIJfR3BcjdMtABfYg14IHlGGDS3mBa14pr1cYLwxSFf1DsbvwfYlgCxXQszaG+GMfXcEp/Xh594y7ghq6DkDRtgtGIjHuuuboYCkks0qDFY7foiLbulKEjFQuhCFu2gTjP8WHSg2i7LzULVAwTi7uraPWvfY/pVKmCbaLMFPkbEcCp8rDmofI3V8ajvl8sBYglH0Q+Q2l4GtGYTI/CF2mEupj1bxOzdI0BWGcX6BDpFePi++76MqYjD3J9uxdLocB7Fa6j3loxc58u6Xssi/lp/oMmTCNyGyZqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPgGpvKLmpqisWCu3Ugfb+VQbHM1G2pRAugWbbC7Zgc=;
 b=l62mjnVlhRrWOlw4tyDerxEE8s7oWa0k9DwkfHmq8hn8/evZtC85wD1M4lm3NnQk86eeAX+73qkM6I2j6HNFUyF/ow8LLWy+JYqD4XPGkZNDhp2+0VDPWAxNiqO1xScqWlhuCeaQGmNmzCuHByclfejBSNakQC2Gwl5Rk8dIWgtVIzPaMdU4SrEFMcxSEPoyCszDOvSCDtc+RYGhSfLANLz870bWz3Fx69HzpkWbwktvEGaiHLON01SmvuWV/OAa+O0gw8S+bCmVH2N3py0QLyeTjZSEw16aYBEhwmgoa4hGp+4+WDKi3SSl0SWb4lywxma6IzWfVIk7iXTDeGGD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPgGpvKLmpqisWCu3Ugfb+VQbHM1G2pRAugWbbC7Zgc=;
 b=IxRrjZ9OSiP/W0ggnJK8S0gcaawV/68f6H020XtlZgfZ0DVrZQfxDJ6B7yUw3yeAld1anOrZuwZl1Zs+biU+2zayJt/zsLHINn37rk7Ztf61Uhtc33EvSm+zIrYVt8HYEWpIXT9wqCerFH16LufZ1rxtjJ3x7WyCBQmpQbkfFO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 10:18:28 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 10:18:28 +0000
Message-ID: <c0fc10fa-d7b2-4b05-9d04-9c318ae55bc1@amd.com>
Date: Mon, 1 Jun 2026 15:48:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add enum for PCIe BAR regions
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260502212857.85677-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260502212857.85677-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 14be5669-4f14-45e4-8e20-08debfc71fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X5YrPkOhgwa0sRfJwlQQhy7dcl8crD2QNVbHhs/iezE0gm8iKPBGubY8gwD6bDVTcVMHYjhcaVYwbsqX8ohvhpYDBArSmXiJyeoB6ab5pW7RsKmzvYmstVOSQmlk018nL55DQb6ov+91WzyUKyiST7QYw5IuRREtyZJFEuFtSsuvmkjU+GvNmGXxR8/EWT1yS1S4CxAGcuRi3eBe/paAgUETS9kKiGV7rzJVERSXYLQ3mPfvsFdLA22DzG8CbxuE+djpQZYISnQpAOP0iga5Sn/J+ONQdcXoUEauu9OprakozaObQSoEFtrE6dnJ+1/bNDYRJzdql0x637Kqvn5WVvIJ+S9r0NzSxKzW83ne9JnvJmoVGgL0nBUWn1T1Kh4UwVe7EZPVq4rB2JGaMt8PtnYLhQoqHNVbqHCYeEE3Rw+cDeorNiP9uKBd2+B1W3SPbJciLc+rfaVUdY1xdNgdcvLU1JNwh/iNKvYLVInBSn8Q+DtyTS3kFCMYpoMxmD2ir4C4ofQ3Df1cV11hA5BL1ZD3yZFebLgRZ7vXW/ZsxuiBwvGvn/nkcPNg88L7Egy2EmWNJ0pQ1nNU4KMervaDT90NRmNFPp/P43zLsQAIIKIxbR7KLRRzHF5i/Jh0XKU5V9IOgmxDUJlJBGJqaHbJe1bCeVzMJCVfMt5U/kfWXAOVhyfD3K7ktrwrnA3pe0+T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFOVmJ1ZjVTVUR5SEU5aklUblVuZ0o1dnplRXdGSzdNNTcycFJiV1Baclhx?=
 =?utf-8?B?ZDNjRVhCVkM2MGpVTHVhWGlhKzFwSTVPeUVWTm9GRG9KQWpNM2IvdTFzMm1o?=
 =?utf-8?B?cnA3ZTIrWFRLOEdHVEhPWFQzak1oemk1Ulp3UVlSSTVkZDAxaEVjZkdZOFQy?=
 =?utf-8?B?bHVLQWdURC9mOXQ2ZStGMnlTWXp3TlN2ZmNEUTRhYzBMZFc4YldaMUlsT1F3?=
 =?utf-8?B?NlNMU2p4M2pxVVEvSW5sT1lhaFZKOEd5NVpZeWZsbmUxcXNraU1vTnVMU1Zu?=
 =?utf-8?B?QUZ4aEpsUGRxQWdVcWJmQ3hUbnBCM2lmZmFWNTdlVGI1TXdlRTdJU3lSZUxQ?=
 =?utf-8?B?dURsbUJYT25tUzlRMEJXaHVtbzZvclR2MWJBMEs2N1ZkS3lTbUxQV2JBTmpu?=
 =?utf-8?B?ek5rQ1ZCc3d1dFVJZlJaU3VPTFJkZ2hwZHBvY0F0eURndkwwY0YvRkNLUTRu?=
 =?utf-8?B?cDhXaXgzekZQSHVpaTRVR2FzUE01WExBWGFDNXI3TlhZaHd6WkpaWEVRQ01N?=
 =?utf-8?B?QjNueGw5QmM3TnZHSVZJMTBXc3NadG4zcUhwZlNnSmxXczZXOUJxNnQxNnlM?=
 =?utf-8?B?ZnVvaDZLT092R09rLzRTWnZzeWJmOFdoaFZyWjNVZG92UjRHazB0OU40LzVT?=
 =?utf-8?B?NkdGSGlxMHM1TGZVb09FVFJpR21qbTRUMEUzWjhZZjlUellWM0c2WUR4SHlV?=
 =?utf-8?B?VW9DWjJsZC9IYUdZbTNERXFCQW4wYmhJQkJkaFVyVE9uemhRb1FzLy9YVGtY?=
 =?utf-8?B?UzRtTE80aVRHNzQrbWRtTmJKaVFzVkNzOTRxNis4L0EwVi94b2JjOUw1bXRO?=
 =?utf-8?B?eWZWd0JBQ1hib0lJTTAzY3crT3plZ0ZBK2tkNnp6SWJKNWh5TlNpV1p4dDlG?=
 =?utf-8?B?aFZFcVZ6Sm0vaWRFNnlMVEMrQjE0dUdVdVd3eWhKQ1QvaWlNWEh4OTFwcVN2?=
 =?utf-8?B?MDJyK1oxN0tucUJjMjRBamFZM3dvS21mbGY1WHd2YUpTTCtnd0RkY3g5WlFu?=
 =?utf-8?B?bWpJN1A5RmhhSTR0ZElsdTV1cGd6UUtHVW55SFc4bEFGQUFBd0xyaWs5WU9L?=
 =?utf-8?B?emg2MFkzbDBUd29meFdwSm9XcWQrNHZ6RURldm9tWC9RRDRIdW56Njh6MXFI?=
 =?utf-8?B?dkFmeGhhNUF0em5QbG5RcnhKaFZqWXAxRGxocmJQcStnYUhOMXJCMmZ0akZO?=
 =?utf-8?B?ck9TbGE5cUg1SjRMc3NaRWJZUTArSkl1QW5DTlgrMGdQeXhJeVlXYXN2V0tD?=
 =?utf-8?B?QWNrTnl6VnpjTEEvdWtKVCtCbHRNUjk2dUI2cmhGQXhBbkVJallBWG9naWlF?=
 =?utf-8?B?Vk1RR0R1RVBQZ0pTMDdDZVA2ZzNZVlVOZHI3NVNzTTkrRDdGN1NkWUMxUWts?=
 =?utf-8?B?MVJidW1WQ3pqMzE5ejZqU2o0UXd4dlVPcVhzUFlxZW12bThFTFdhc0lKeUdD?=
 =?utf-8?B?L3NjVHJYcXZYdmJHMVVHNXdQZXM3YlJtWGRjK2JmWmhod0swa3NoVER6Szlp?=
 =?utf-8?B?K2tTMmpLL2Frakx6VytUKy9vZS9LZHVNLzMzMHdpYmVCVVB0VmpmbmhSQlJH?=
 =?utf-8?B?WURCb0FjSUR0TVVUaklUYW8rc3pkRVMzK1AwZjhTWEZnOWVJTUpOUE9KYWNH?=
 =?utf-8?B?anVZZnc3NmV0L1U4eGlPb1l0YVVFVGlNQ3Qvdit0QUx3OElXNjVFQUhqSUZE?=
 =?utf-8?B?SCtZdTFpdGdoYXorcVpvektUb0ZyVWtoczkxcTZITEJUTUpZcmsrdW1PYXUz?=
 =?utf-8?B?TEU5MW5Da3VxQ1R2SUlLaFRkdTR5bDVSK2EvdnFCU05TSEo4V3ZtVHV6YWti?=
 =?utf-8?B?NzNUQTRxQytFaHErMG9KWTdBMVd2a0JGSWhCY29TWDNyT2ZLaDd6UllXZThW?=
 =?utf-8?B?UGdnSS9xS3lER09XUFBoYkpNY3JtRUNnUVVzdGNsT25xaVIrQ1R4aEdNOHlk?=
 =?utf-8?B?bXo0VFlGcXV0aDFad0Jrek85RVNvTE45bkdJQlBZUGtJUkIzQ1VmUG04L3R6?=
 =?utf-8?B?M2JKbEU2UWVqVEJMaWFRdUR0a2lkanVPWmlsd0JJYkFqTFh4WGdjdjVMSGJB?=
 =?utf-8?B?NXdMQ2JjSjFQNVU5VWdIdGpuS2IrOU1XUks2YzNnN0poTm1KN0JFeTFWSmxv?=
 =?utf-8?B?UVZBSEZ4QzVwM2pST2d4a1JQRk5OdCt6RFZOaWdjWUNZa2tTTVhNbHp0blRC?=
 =?utf-8?B?Y2tvb0dvTHJBbjJ6N09leENDL2tyMmpjT3MzK0NZMmNrSWNBeGsrejN4VU0y?=
 =?utf-8?B?ZEI3ai8yK2VhckhUQndSL01tWFQzNmUxeUNpUFp2cWZySFp2ZWloTDBMOTJP?=
 =?utf-8?Q?XN4N/Onryk7CalzHuj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14be5669-4f14-45e4-8e20-08debfc71fa5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:18:28.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRe16CSYi70Gfhh5oQq4FSSnycBNNphpPygXHUzzeQNldbw5Umruvcfw8DBHuEhL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
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



On 03-May-26 2:58 AM, Harish Kasiviswanathan wrote:
> Use enum instead of hard coded values. There is no functional change.
> 
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  4 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 28 ++++++++++++-------
>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  6 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  4 +--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  6 ++--
>   11 files changed, 51 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 39894e38fee4..6b9d103fbff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1441,6 +1441,19 @@ bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
>   bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
>   int amdgpu_device_supports_baco(struct amdgpu_device *adev);
>   void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
> +
> +/**
> + * enum amdgpu_pcie_bar - PCIe BAR index identifiers for P2P access
> + * @AMDGPU_PCIE_BAR_VRAM: VRAM aperture (BAR 0)
> + * @AMDGPU_PCIE_BAR_DOORBELL: Doorbell aperture (BAR 2)
> + * @AMDGPU_PCIE_BAR_MMIO: MMIO remap aperture (BAR 5)
> + */
> +enum amdgpu_pcie_bar {
> +	AMDGPU_PCIE_BAR_VRAM = 0,
> +	AMDGPU_PCIE_BAR_DOORBELL = 2,
> +	AMDGPU_PCIE_BAR_MMIO = 5,
> +};
> +
>   bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   				      struct amdgpu_device *peer_adev);
>   int amdgpu_device_baco_enter(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 35d04e69aec0..3e8216913e5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -110,11 +110,11 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>   			return false;
>   
>   	/* FB BAR not enabled */
> -	if (pci_resource_len(adev->pdev, 0) == 0)
> +	if (pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM) == 0)
>   		return false;
>   
>   	adev->bios = NULL;
> -	vram_base = pci_resource_start(adev->pdev, 0);
> +	vram_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   
>   	adev->bios = kmalloc(size, GFP_KERNEL);
>   	if (!adev->bios)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 073f632f295a..5c14fdbc1847 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1146,7 +1146,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   	/* skip if the bios has already enabled large BAR */
>   	if (adev->gmc.real_vram_size &&
> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
> +	    (pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM) >= adev->gmc.real_vram_size))
>   		return 0;
>   
>   	/* Check if the root BUS has 64bit memory resources */
> @@ -1165,7 +1165,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   		return 0;
>   
>   	/* Limit the BAR size to what is available */
> -	max_size = pci_rebar_get_max_size(adev->pdev, 0);
> +	max_size = pci_rebar_get_max_size(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   	if (max_size < 0)
>   		return 0;
>   	rbar_size = min(max_size, rbar_size);
> @@ -1178,9 +1178,15 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	/* Tear down doorbell as resizing will release BARs */
>   	amdgpu_doorbell_fini(adev);
>   
> -	r = pci_resize_resource(adev->pdev, 0, rbar_size,
> -				(adev->asic_type >= CHIP_BONAIRE) ? 1 << 5
> -								  : 1 << 2);
> +	/*
> +	 * Resize the VRAM BAR. Exclude the MMIO BAR from being released
> +	 * during the resize. On Bonaire+ the MMIO BAR is at BAR 5, while
> +	 * on pre-Bonaire ASICs it is at BAR 2.
> +	 */
> +	r = pci_resize_resource(adev->pdev, AMDGPU_PCIE_BAR_VRAM, rbar_size,
> +				(adev->asic_type >= CHIP_BONAIRE)
> +					? BIT(AMDGPU_PCIE_BAR_MMIO)
> +					: BIT(AMDGPU_PCIE_BAR_DOORBELL));


amdgpu_get_bar_idx(adev, AMDGPU_PCIE_BAR_MMIO) may be a better form to 
be explicit to avoid confusion.

Thanks,
Lijo

>   	if (r == -ENOSPC)
>   		dev_info(adev->dev,
>   			 "Not enough PCI address space for a large BAR.");
> @@ -1191,7 +1197,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	 * using the device.
>   	 */
>   	r = amdgpu_doorbell_init(adev);
> -	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
> +	if (r || (pci_resource_flags(adev->pdev, AMDGPU_PCIE_BAR_VRAM) & IORESOURCE_UNSET))
>   		return -ENODEV;
>   
>   	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> @@ -3814,11 +3820,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* Registers mapping */
>   	/* TODO: block userspace mapping of io register */
>   	if (adev->asic_type >= CHIP_BONAIRE) {
> -		adev->rmmio_base = pci_resource_start(adev->pdev, 5);
> -		adev->rmmio_size = pci_resource_len(adev->pdev, 5);
> +		/* Bonaire and newer use BAR 5 for MMIO registers */
> +		adev->rmmio_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_MMIO);
> +		adev->rmmio_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_MMIO);
>   	} else {
> -		adev->rmmio_base = pci_resource_start(adev->pdev, 2);
> -		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
> +		/* Pre-Bonaire chips use BAR 2 for MMIO registers */
> +		adev->rmmio_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL);
> +		adev->rmmio_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL);
>   	}
>   
>   	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index bc7858567321..0251625887d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -201,14 +201,14 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
>   		return 0;
>   	}
>   
> -	if (pci_resource_flags(adev->pdev, 2) & IORESOURCE_UNSET)
> +	if (pci_resource_flags(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL) & IORESOURCE_UNSET)
>   		return -EINVAL;
>   
>   	amdgpu_asic_init_doorbell_index(adev);
>   
>   	/* doorbell bar mapping */
> -	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
> -	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
> +	adev->doorbell.base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL);
> +	adev->doorbell.size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_DOORBELL);
>   
>   	adev->doorbell.num_kernel_doorbells =
>   		min_t(u32, adev->doorbell.size / sizeof(u32),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index e1ace7d44ffd..83611edbd7b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -694,8 +694,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 94d6631ce0bc..887edd7ea7c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -694,8 +694,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 5bdd4b9b7893..a2a81e601e99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -746,8 +746,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   
>   #ifdef CONFIG_X86_64
>   	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index cc272a96fcef..14963e9edac0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -323,8 +323,8 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   	adev->gmc.visible_vram_size = adev->gmc.aper_size;
>   
>   	/* set the gart size */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index fb5e33c8a5ee..a0ab5ab7df94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -379,8 +379,8 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 963d5b0fa87b..5f83311d7c26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -572,8 +572,8 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e7b78027002b..0cc4ac7e8ad9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1593,7 +1593,7 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>   		 * mode.
>   		 */
>   		adev->gmc.is_app_apu = (pkg_type == AMDGPU_PKG_TYPE_APU &&
> -					!pci_resource_len(adev->pdev, 0));
> +					!pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM));
>   	}
>   
>   	gmc_v9_0_set_gmc_funcs(adev);
> @@ -1705,8 +1705,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.aper_base = pci_resource_start(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
> +	adev->gmc.aper_size = pci_resource_len(adev->pdev, AMDGPU_PCIE_BAR_VRAM);
>   
>   #ifdef CONFIG_X86_64
>   	/*

