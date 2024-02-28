Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08902C54E49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 11:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CB210E9E4;
	Wed, 28 Feb 2024 11:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CY/ObSY/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87D110E91D
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 11:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+RAJRbLHIYbbq5OFrHQixbZjFO+u0WKb8MbD8V+asDp4KOCpi06KP0ns0B8KW3NuIia6YYHiY675HgRF9xZKNPaos9OTfE9kE0Rk0mScy0TLdQPHgUHIbdSwDNi2bPQyXVHy+2H1R8FOcFMVPCnqo+iG1lvF8mGjADChWwEo8gD+g8U+ijQKIr7+kiMnJEJOkft3XgCfAtKrcj44G8biOEYn0jxjzanOs7Mig1ospCMeYnD7jXK8RHXPEMdi+EGNYFHou25oEI+66FwBRCsQTe+VZCnmIYHKAGhLVPztMHsyTK3T1Q8thzMQ811m5GrdW7t7PErZ3DYvxkeF4mX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xitPKgvqEe0F4aFNb7excOQl5QKuwe8YcRLCaatqB/0=;
 b=GtgQrN0kGHe4I3GlZaVr+iwzlw+xcUH7bXIr/k/zqaXBq9PUth9FtfYk45xfBpCYuKr5LNsDRLkxROFfVqueNcToY0MH1zT/wMsxjkaHwMOx8txAldSb3jOZevKxaytfc6ePpr5N92qg/Bv2ftj0ZwkhoQjtePw5VMFyGEhekuxBIsU4Xty8B/IFK6EfxOIZDizFnnWO6811mgIOeMawRJYkRkg/rJIMQ+5KOlNa2x1mRROLw6CwsHQouBmhiT5Pmo2dw1SU7xrFkU98vkM03+jNWQX9Fq8dSZXAOxJVp1a2GKpj9hQZosBMR2onLqUpFHwXkCh443wySMiTmeO6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xitPKgvqEe0F4aFNb7excOQl5QKuwe8YcRLCaatqB/0=;
 b=CY/ObSY/kd9ho4kS8Xo8gfwBmb3lPACqOGW2PbEMR/VkGib6fBG9OinFO/QfoX8eYjj0UGMfghqPLmKe9pt54nN31BRIBeoQ4UVJ3y506stC5BiiSScFmr/sBgtyt/f302m1rxx9wPvjs3wvSAjogOq42XOKR5DJFmuDWfV7/1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 11:59:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:59:38 +0000
Message-ID: <2879710d-486c-450a-b514-f9b5ac23ad4d@amd.com>
Date: Wed, 28 Feb 2024 17:29:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Use rpm_mode flag instead of checking it
 again for rpm
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, Alexander.Deucher@amd.com
References: <20240228114440.1939084-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240228114440.1939084-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 374f0226-5d09-448a-c440-08dc3854bce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pgl9KhoEBUr+nxbQ45HvJV7PSHugJD3ng2uNYw0AitsjnU8OOrvHcoLfhilUYHJEFt1YfQtUs9udeNmjdQsYxZwoQcNAKy/zyrwWsKRnGqkMLtX1X05sBUa+gpNxik6Ab5JHxGHLeR7OPVXhfllDzU4DcU9ONmDWomtk5shfc0ZyWAc8hkkdpxRh/zJXx9Y53BAlosAMaCBo2ozcuiSTb6oWOebiD8ZdBPOR8nCuhwmEPH1y5r+J5pfO8A35DUXmTbopNstZiDyL+KxjzYVSFEb4cB9R47DYAG0EQDSDjyUQBUAuQCwFaxiaqSJWmq3QzUJ1+VEkeGvcKOutwvJjbrr4Jn4LJ0n1KYV4P6coES0O6PMoQi/WIeAyZS6C+ciAer6bTSJYzkYDEVNbGfYyibb5JJ4Z+Cju02oQeDfbTpuaiUAraLHLzEWZSUtsvI2S92kn2RdglpaWu4ckfAJHdhGFJlsBxzHMl/gV6Us+FvKaZTHz2/cgR08WgxNvTRDFXTbjaw8sVE6+suIH76OGlgW2VtF1mNfcxLwdzdkSnHxgY5WfoQ51gUfd4LnAgtyn/FFzvbqNwZCZbYRRT15DCKeJ4SZ0fHpd5w6OQNEIgpuY1dEyFfP9V2uxlAWw+Zfb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTY0dlUzL2NvU0pvekVTeWxEK1I1eG9aWVlSdTFQLzdScm0weG0wbFBDMDZK?=
 =?utf-8?B?c0c4TWlaQVhvTUVNTUpNM3cvTkljM1g4R2xibHFwaityTjJZcCt4WERYdzht?=
 =?utf-8?B?dlhTc2p2UXpibzlGSjdsaVYzSktGTktjZ1ZVdFk4TXlEZzZ5SHQveXBnSWt2?=
 =?utf-8?B?eFoxaGtvbE02YXl6ZEZZUVgxQXdOSFMzS3lrSG9iNjJvcytNQmxMYmxMRTMx?=
 =?utf-8?B?VFUzakdLQk1QVURKMFdnWkFuc3F0MXdRT2NaTG1GWmRSTmZMbGdHNWRWSlpY?=
 =?utf-8?B?eUV4cWJ5c29EWEN6dnJXN1JvN3JYL1czNXFFZ3Z5U0dzZUdXblFpb0xtcC9G?=
 =?utf-8?B?c2cwN2xFTzZjRlhRQ0N3Y29BRWVzY29ERkw5bU9mQmV4c3ZmaVJrS2lqUXd4?=
 =?utf-8?B?WTE5MFlwcysySHNVUjZzUHdVTmxSVWhiWklhZGdoWEFqdWtJdFNGcFI3RlZ6?=
 =?utf-8?B?N1QyNmV0VjNUaDBvWVlCUGlhVnlwa0NSYzZNdEZpQW5mbWVDRVoxRmU0b0Fj?=
 =?utf-8?B?WmFydFVHZFQ5S2tjc2NSdVhmemFqQlRXYzlFbFlQYmw3ZDNvRjJscmhMZHFo?=
 =?utf-8?B?Lzg2RjZKQXZpMTFWL1JPUTE1NHNhdnFodnE2TE9CMyswRHBmVTZGbTZVN1Yz?=
 =?utf-8?B?OU4ybUtLUndtZ21DZzVKbkRxS3U4bkJETnBFYnNoTlBrQVBldk56RE9EZDBT?=
 =?utf-8?B?YjB0MFAwOFV1cUFyeU92ZXJoRXZ3ZTBWWGZVbkx0SXFQZWxmSk9xMVlXeW1y?=
 =?utf-8?B?b3doVTQzN2xGZG9XUU5wMUo2U0xhVTZwM29PamxQWWhmbVhtTXR6NE1jWHNl?=
 =?utf-8?B?ZEpJdEhtdGNQT3lLdnNxNXllc3pyZ0RzTXFMYWxCdXhNNUdpQ1VwUTl4RGM3?=
 =?utf-8?B?RzRXVE14Ynl0MnNSazZRd3pZbVJUSjBWeDJZdVZXL0h5bFd1TStsQjAvNW52?=
 =?utf-8?B?VlczeFZmaGwvSDZ1cGFsSmplTHhwK21OQzhvSFNiQmFJQ0F5dkJPRzUraGFC?=
 =?utf-8?B?elFPUnhlUGFZZmRGTWlyem04TnhFb1lNYWhpeGJDVm5Ib1FtdVhqQmtoa2RY?=
 =?utf-8?B?TkhDaUNSbGlWNjlqSmtNY21pUVNqSitPalBDSXZKYVNYd0lPQkZRSllIUzl2?=
 =?utf-8?B?WGQ3S3VkaExZdVRtQ2VnT3VTYzV6eHF3djdocG53aTRQeXBZWVNuRnJIa3NU?=
 =?utf-8?B?R1R4clFpOG8rQk5QZXZ5NjgvdGEzcDZVcnBiMWlSZVVXR3VhMkwraE9IUFBR?=
 =?utf-8?B?c2lwYnlwS05lQzdYQThSVHR3Z0FEQ25nMEFKOHhva1NLMHBvT3JmVDByRWhK?=
 =?utf-8?B?cklzeFkzd1dObzdhRlNXUldoZ2UzMk96cFFwaVhvUkNQb3UvQXI1TnIraDJT?=
 =?utf-8?B?WU93VDREVFRULzZxb0tQZWJCZTY3cmhkYVhqN003eXhMOXA2OTk5Y1ZZUGxH?=
 =?utf-8?B?NVVLNDM5VnpCd1lLNm1WRXpwdy8rcCtoUktHMEE5MlhvQjBCVExPck1Jd1VP?=
 =?utf-8?B?RWowdWpLK1UrN2VoNzZkZzcwbWxIT0NINU5Rd2YvOG1HL2N6MmJoWnpuQlVt?=
 =?utf-8?B?NUo0dW1odTNuT09ORGRxWnZMeWZESjlMVWEzUHdJRTJqa1NSRTZJZHRZaGwv?=
 =?utf-8?B?aGNvUUNxQzIwNlMrUEt2YXYzTzh1OVY2eUFmQzB0d3RQTUhvKzhzK2dmS0Ja?=
 =?utf-8?B?S1RRVTJ2THZlS0hWa3EzODRTZnBPYlBkV2NnWGpWbzQ1NDR6L2k2anhUaG4v?=
 =?utf-8?B?a1AweVUyRGdmU0MyQ2p1Tkd3L3lEcUJFS21zZ2gzekFESks0ZHl2WG1jUjVU?=
 =?utf-8?B?WE5Nb2dkN24xaTNxc0diQ2NrN0xJcFJjc0F2d2dVUzhzRmhIZU4wYThmMmVy?=
 =?utf-8?B?VVVWLzRVMkh5a0RIczBHMTFEcU9ZWjFnSnVzZW54NHBudnFGQis0NWd3TE92?=
 =?utf-8?B?alpSZy9vZjhpQXN2MTcrQXB5YW9lcHBKZldvUHNBakI4WmxSczZXcS9HeUM4?=
 =?utf-8?B?YXVUcWRzTmdjdHE0K2VxSlA5TDA5Z0FZL1lPdCtSTlNjQjFWNVF6RmlGa01U?=
 =?utf-8?B?RTB4M0sxQWgrM3gwdVMycUFqSURCd3RYTHI4bWdnelNyM3JiZEQ2WmVSeHIy?=
 =?utf-8?Q?QkEI0QgboEJXvKsZ0epHNR9o4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374f0226-5d09-448a-c440-08dc3854bce3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:59:38.0465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Wb5EtNjtb7pWlhkivitRFvK9pWH9LjrFA2lYjJjJK0VQBugaWStjSuEsBlRdJt9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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



On 2/28/2024 5:14 PM, Ma Jun wrote:
> Because the rpm_mode flag is already set when the driver
> is initialized, we use it directly for runtime suspend/resume
> instead of checking it again
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index af7fae7907d7..8b83c26dc018 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2666,7 +2666,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  	}
>  
>  	adev->in_runpm = true;
> -	if (amdgpu_device_supports_px(drm_dev))
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>  		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>  
>  	/*
> @@ -2676,7 +2676,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  	 * platforms.
>  	 * TODO: this may be also needed for PX capable platform.
>  	 */
> -	if (amdgpu_device_supports_boco(drm_dev))
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
>  		adev->mp1_state = PP_MP1_STATE_UNLOAD;
>  
>  	ret = amdgpu_device_prepare(drm_dev);
> @@ -2685,15 +2685,15 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  	ret = amdgpu_device_suspend(drm_dev, false);
>  	if (ret) {
>  		adev->in_runpm = false;
> -		if (amdgpu_device_supports_boco(drm_dev))
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
>  			adev->mp1_state = PP_MP1_STATE_NONE;
>  		return ret;
>  	}
>  
> -	if (amdgpu_device_supports_boco(drm_dev))
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
>  		adev->mp1_state = PP_MP1_STATE_NONE;
>  
> -	if (amdgpu_device_supports_px(drm_dev)) {
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
>  		/* Only need to handle PCI state in the driver for ATPX
>  		 * PCI core handles it for _PR3.
>  		 */
> @@ -2702,9 +2702,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  		pci_ignore_hotplug(pdev);
>  		pci_set_power_state(pdev, PCI_D3cold);
>  		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
> -	} else if (amdgpu_device_supports_boco(drm_dev)) {
> +	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>  		/* nothing to do */
> -	} else if (amdgpu_device_supports_baco(drm_dev)) {
> +	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>  		amdgpu_device_baco_enter(drm_dev);
>  	}
>  
> @@ -2727,7 +2727,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>  	if (!pci_device_is_present(adev->pdev))
>  		adev->no_hw_access = true;
>  
> -	if (amdgpu_device_supports_px(drm_dev)) {
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
>  		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>  
>  		/* Only need to handle PCI state in the driver for ATPX
> @@ -2739,22 +2739,22 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>  		if (ret)
>  			return ret;
>  		pci_set_master(pdev);
> -	} else if (amdgpu_device_supports_boco(drm_dev)) {
> +	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>  		/* Only need to handle PCI state in the driver for ATPX
>  		 * PCI core handles it for _PR3.
>  		 */
>  		pci_set_master(pdev);
> -	} else if (amdgpu_device_supports_baco(drm_dev)) {
> +	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>  		amdgpu_device_baco_exit(drm_dev);
>  	}
>  	ret = amdgpu_device_resume(drm_dev, false);
>  	if (ret) {
> -		if (amdgpu_device_supports_px(drm_dev))
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>  			pci_disable_device(pdev);
>  		return ret;
>  	}
>  
> -	if (amdgpu_device_supports_px(drm_dev))
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>  		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
>  	adev->in_runpm = false;
>  	return 0;
