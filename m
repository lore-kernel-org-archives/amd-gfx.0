Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CE5C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 19:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C6910E5B9;
	Tue, 31 Oct 2023 19:14:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB9AC10E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 19:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdT8ARLK8AFy7XScmwjXlfmz+oM/h22iEsyRUKaY2tf03jPoeOsWbnfh09S71B+XhzX24tMGDG5r4OnPuWZ/4CuRp6NvchUoOX9p4QH5jsU0bhTmtMpy7j9N2+wmNsgdZMwO7knN1UEzmYmdBVQABbmTB1hBkupdEfU2mkKg14aaczB/9Gyx6+Q5/ucJKzvRAqOsy+fUdhViBU6kHkqxmTV0Nru+9avZ/CsAm6Fv5GKxeJ5DHJk/4Jvd9Mqz8xuiRqrTCwLF8dg8DEuE04uEsEYI3LdTfmZT6DJur577dK9c5THrrovsu00iMo6Cdu6YpF6VDtmz2lOSpuwVMpVUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMLe0g2TpUD3zr8iGnB1wnTjfmE03AB1+ISZp8XSQnc=;
 b=atbJTkB49qVgm1m2egW53Hj9CgS/jVFjVsyQBQVZ2zI2ws9Tgcy92kMEZ36kC/hsB//FZZ2+03cpb9kHwCUJYpqY+i5GOzpMjNH0zYWA6hIVz8v5Yr9VZlqvJNetGTujnlW6f+sxsiZ5xEvJS9uds8YF44xl52xdaNcwlgnKv27OV2+wfnGQluBNT/7tpp2jBTAvcfQUmEF5KbSg3yNydyogAzmJy36/v2rGDqHUP9QXcx7PUzBIKB7AREc6LrM8CGeT+uuQw5Brp4SlRL5OutY5wVFp+Vuwvoqq3pqAi1Mdtpd+HWwkClhStF/RB+w9Nloc4USHufZLSov09d+a0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMLe0g2TpUD3zr8iGnB1wnTjfmE03AB1+ISZp8XSQnc=;
 b=e84dL7mpDwiSSnvzWmp4Mo0q3LX0qjuiKSjiE/v2Tw8TwcMn0xx+lzwQF9d4PnBy0l7nbXWbC4HP1/sVeqWA7CBRHZBIWm60z7fWoIL2dCtAFQ2FBePlS64fpZuMTOp4GCkaqe5CR0o4vIZxTZ+j6fJZHdg5dn3kn/J+J6+VRNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 19:14:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 19:14:38 +0000
Message-ID: <3e0bf273-6bb5-41e1-80e6-d933116d0b7e@amd.com>
Date: Tue, 31 Oct 2023 14:14:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [2/3] drm/amdgpu: don't use pci_is_thunderbolt_attached()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231027154225.1662448-2-alexander.deucher@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231027154225.1662448-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: bddec513-8f51-47a2-8d22-08dbda45a054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2zJLKaTIH7PSxOzp+R0SQxPkyzpk2S4F7OMG94LDvLNUxapZXs17uuLajqleWVEdURmymYLwCRoI7p4hNkU1rsXWagnDmopecEyf4MKO49XDyj6zc8g3XWZ8tylj4SOp7xVn6CAEDioJz8De5EY92nDbLWRZyhLgRgb9cgn3wkWCySS0+wOG/5ED52zIVEQ7Z1tVgW1gmmYaGZ7HuigyACW02MCZaNpJSPmTuGZ89iHkuiJUyU3ofk/xihQ8i9m+96z9ZLSvO9N0NPyR1bjd/mijXs2awVjUrsL3ZEq6jMxn5T2U2EGhkwmtHPBSoriEEmYWybZBspiagDbAsNlfsrTxDts21KbF/7HFp3ZGhhCD/CIPNF+ghcO+tQrXlt9U5t8hxmUcuxqDT3dSivorVMNoU9sXqpn3uX19QQc8m1C4Tb7LYNh+7W6d7AHp2zkuoGxR8amJytU5TW5KhO+adhcmywc0hZ7iXprZMVBqps0rNPf/mhCm2p/a8prO6RpTjNOYDdFT5llLAVUP369GbOH9yEyFsVFOUS8Jdg47vQ3EmhoO2bChK4OnTAwO+Txnw6n/W6XTQO/O4/PAZx9Fyk2U7hUldWI7srif3wH/ksZziymBK7S04+gIKvfpX1h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(26005)(53546011)(6506007)(6512007)(38100700002)(86362001)(31696002)(36756003)(83380400001)(8676002)(2906002)(8936002)(31686004)(44832011)(5660300002)(316002)(66476007)(66946007)(66556008)(41300700001)(966005)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDA4Q0V2VzIxcVFPNXRvUG1QblVGQWJaa3oxRVJiVURKNTJSRWV1Wm1Pc2tR?=
 =?utf-8?B?NU5KWmcwUDU0enZJZGRLeE5kaSt4dTl2UUlsTkk3elVrKzV1bDNLSHNVQWU1?=
 =?utf-8?B?MjlsL3JtL2lDYktxWXNxUlRIMHRrNEoxNytnU2UxcnlrWDE2RVlVS1ZCMUFT?=
 =?utf-8?B?Z0g0QmxaUStaTkdqNGdsSngyZ1RRTXk3R3R5K29JTGFUN0EvUjN5WmRzOWw2?=
 =?utf-8?B?WDluN0szMDFLSjRybjJMR0t1RDlKczQrOFF2ZDhxY0gzZVU4Z0xtdzFGdTYw?=
 =?utf-8?B?cXRKczhoZ0ROY001b2lEZkhMcHdhZkdud0xqemdHTW5Cd3dDTGlmS3VsU0Zk?=
 =?utf-8?B?ekZTaEJPNXRTWlhXbXpwemhOZlQySXAra1ZhNll4QjcrOGtWS3FlSEFuYllD?=
 =?utf-8?B?Y3crcXpONm1ScUNBU2hOeDlPL3hWYkx1cTk1SkRrbHRkQXVrVUcwM3A0TXNn?=
 =?utf-8?B?dlQ3QVo5dWVsNmpTRVE3OTFNbFprcE93UWJIdnNVV0FlSXBQSHpERFZGWnND?=
 =?utf-8?B?WlB5b0FoTmdGRjBiNWx0Wm9ML3NJcll2cTdnMGVQaTd3Tm14SC82bmRzMElH?=
 =?utf-8?B?QUlBL1RTM2xBZUt3ckdmWVNjeTFJWTZpRTNvb2J0RkVYU0I4RzJFa01jZENQ?=
 =?utf-8?B?MGVjTHNtaitNTHhub0JVQ1NpdW4rNTdIUEtNcVpUQ1RKOVgwaW1BLzBmMDBY?=
 =?utf-8?B?QlJMWU5iWW9FU3JORFJkNk5UZUhBeUVKTUt3RFJJeTFKV0NyUGszN1NDYTE3?=
 =?utf-8?B?cTI4S0wvWStUOG1ZRWtaT1NaOXc5TExsdy9vdEx1QnRYLy9QZmVqMER1RkxM?=
 =?utf-8?B?S0pwYmREM01JN2g0bmxSV0szaEFkQ3FsY2FXM1ZtMWdlVElpSUxUMEJKRStB?=
 =?utf-8?B?aVN5OE9QbGltY1Uwakl3aGlXUDB5UFRXOW5VVThTRE92cG5YVURRd0NxZHFn?=
 =?utf-8?B?b2hybDdNbTcvMHJzaTdUbkVVdXdBV1g5QmNVZjd2THA5QWtLcjcxMXVCZEFR?=
 =?utf-8?B?Smd2K2diS0EreGJFRnNjamJQdDVBeG5tVUhrZ0tXeitTOVVWZE9FYUV3Yys1?=
 =?utf-8?B?cWhtbXRLSm4yZldxamxuT0xlNkZER1JiWjhCd09yOXlFOTZtUitSWXdtcGJj?=
 =?utf-8?B?SENzRG0wVTRRZ08rUnowWVA1RHFoSDZ4TVFCSDBtS1hWUXNPVUxBUzlRZnQ5?=
 =?utf-8?B?OC9TVHRsTG1FZUt1c0l6eTBSa3hIWDdRMTRKMDZhbWZoVmc2VTJHZWJSSkkz?=
 =?utf-8?B?TExhbExRSW1oNXhEajljT0JnNm9FYWtWWXdoKzN5QUdRNy8rWFhLT2NKcktl?=
 =?utf-8?B?bTVaQ1QwVkkvZHpVQ1NGL0pWSlJFbnlsVkNzdWRJZHZxbWN3SkE5UzQxY3ZN?=
 =?utf-8?B?NEV3MncrTmN6bmhsbEdTZSsrb3NlbXM4azQxYStVakZKTXVMaEVDL3VweVhL?=
 =?utf-8?B?Z3QzVFBxNUt2Njd4SGl2OElRR1RacjgvbWVVMGRRMnhKR3RPdWdqczQ0WTIx?=
 =?utf-8?B?b1JQbzBPemUyUmtvVjE4SHBaL3h3RFY2Qjd4a0VJb2kwV0FjQUQ5YXJTMkhS?=
 =?utf-8?B?dUx1aFhPUWNFcUgweUxEUmlmRVFncTRHb1pCT1ZYVVh4Nk5aSUtyRUJ4UHBp?=
 =?utf-8?B?L04zU0pNNjJHM3NQa05zK3ZVbmY4MjlKSXdPR2pWNWF6blBGdWc2bmlvbmtk?=
 =?utf-8?B?MFNkRk9sSWVMclQwMlZnV1djM0tYZHMrdGFyd3FzZ0xNemhTTWtBakNwVjM1?=
 =?utf-8?B?MmJ6SHZXc2VQaHRzeHBtVFhwS3pNcEx4YlJ2QnBTdU5ZRXhzU2VGWUw3ckgz?=
 =?utf-8?B?VkZzRnpSL1k5L3kyMGQwcG0vUXNBUkFWR3JKT0RlZzA4b3RaT2hCRCt2dTlR?=
 =?utf-8?B?cFJTWU9qZ25NeHIzcWUrOTNqS2ZIOGVsb2d1dHBzVEdwaFlGTXY3TGVKalJt?=
 =?utf-8?B?WHNpWUcxUXk4bjZ5MGszWW5KZVJ1K2V0YWtaN3dVYWUyajR3alA5OWRYbnVQ?=
 =?utf-8?B?a01KZE1KdithSWc2OVhKenFKTHoyTGpMUmRIbEtnWFdvUm1CVjNVQzQ0OEFm?=
 =?utf-8?B?aXFXNTdSRHcrSzl5YmZRZ2ZRelVsVDRENE1yYU5nS3dBeEd3Y29XY0JTR1RF?=
 =?utf-8?Q?Cim1KIm8cvqky6wSDmH9KrLsB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddec513-8f51-47a2-8d22-08dbda45a054
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 19:14:38.2516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbFTfQO3yrWm3C4oVlJYHv1YQbWzr7rLgrinQwWPuScQI62yXSZotQUNA3KS1y8RIkYJw+nUqFyJm2DABOUbCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
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

On 10/27/2023 10:42, Alex Deucher wrote:
> It's only valid on Intel systems with the Intel VSEC.
> Use dev_is_removable() instead.  This should do the right
> thing regardless of the platform.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     | 5 +++--
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2381de831271..5c90080e93ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -41,6 +41,7 @@
>   #include <drm/drm_fb_helper.h>
>   #include <drm/drm_probe_helper.h>
>   #include <drm/amdgpu_drm.h>
> +#include <linux/device.h>
>   #include <linux/vgaarb.h>
>   #include <linux/vga_switcheroo.h>
>   #include <linux/efi.h>
> @@ -2223,7 +2224,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>    */
>   static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   {
> -	struct drm_device *dev = adev_to_drm(adev);
>   	struct pci_dev *parent;
>   	int i, r;
>   	bool total;
> @@ -2294,7 +2294,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   	    (amdgpu_is_atpx_hybrid() ||
>   	     amdgpu_has_atpx_dgpu_power_cntl()) &&
>   	    ((adev->flags & AMD_IS_APU) == 0) &&
> -	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
> +	    !dev_is_removable(&adev->pdev->dev))
>   		adev->flags |= AMD_IS_PX;
>   
>   	if (!(adev->flags & AMD_IS_APU)) {
> @@ -4138,7 +4138,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	px = amdgpu_device_supports_px(ddev);
>   
> -	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
> +	if (px || (!dev_is_removable(&adev->pdev->dev) &&
>   				apple_gmux_detect(NULL, NULL)))
>   		vga_switcheroo_register_client(adev->pdev,
>   					       &amdgpu_switcheroo_ops, px);
> @@ -4288,7 +4288,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   
>   	px = amdgpu_device_supports_px(adev_to_drm(adev));
>   
> -	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
> +	if (px || (!dev_is_removable(&adev->pdev->dev) &&
>   				apple_gmux_detect(NULL, NULL)))
>   		vga_switcheroo_unregister_client(adev->pdev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index e523627cfe25..df218d5ca775 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -28,6 +28,7 @@
>   #include "nbio/nbio_2_3_offset.h"
>   #include "nbio/nbio_2_3_sh_mask.h"
>   #include <uapi/linux/kfd_ioctl.h>
> +#include <linux/device.h>
>   #include <linux/pci.h>
>   
>   #define smnPCIE_CONFIG_CNTL	0x11180044
> @@ -361,7 +362,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
>   
>   		data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
>   
> -		if (pci_is_thunderbolt_attached(adev->pdev))
> +		if (dev_is_removable(&adev->pdev->dev))
>   			data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
>   		else
>   			data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
> @@ -480,7 +481,7 @@ static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
>   
>   	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
>   	data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
> -	if (pci_is_thunderbolt_attached(adev->pdev))
> +	if (dev_is_removable(&adev->pdev->dev))
>   		data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
>   	else
>   		data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;

