Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E152C54E60
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 08:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A0A510F1DF;
	Tue, 19 Mar 2024 08:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sOPQCugg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2099.outbound.protection.outlook.com [40.107.244.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BDE10F68E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 08:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmoUlGn8wrnUhGrZWzRnIUNbLsTWFoYhzGQ8KbDHf30AntpKb9iFSuIMKjT++n1kBIY+0k/TWA541+wSmqQIO876jc1pa3O41J3yEznobTEeWbgRYs+V3mDQhpiYmWzkS1g0aPgQngcTOC61CFYmUIGy2bEdQI8xXGBSUEY24is7tORsfXIzuSCtvzc5Jo8M7sFt/fYTzSVh84nwnz7606CxO6T+YbxJJMbSia2ib2q2wnT/WV6JSaPs2ka26Emdq1LeUikIzet+O/BQ1YxmUj5YzPNU340Qw4u04qDfZekn2Vp81mGv6DcBLrKCKptg25x1f7b1KgDwaqHZY4cfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPip4PP7hVJ1M5XJ++tRBCaRd8QRiuFu9A2PMDDwxiQ=;
 b=Pd8kVD0NDtmnzICX9jmmAiKyo2aIc0nP68v6a2DDNxtbrpbMQvzVnknULz/ZTMxjXNzOgBW/K8c7y84FHOJgfJrlcC8Baw68sWMl6UsyFcYLNyhfcW4Cq22bycSMYR6iSlw3E9tfBtZIVc1+kGKZY86PRhwj1ycojan6K8RIH3FFHNMCHd2CExT75cr7txJpQqta8miQdUnQfoYBZXHJwmKlCowwazFHMEVJt3Pds/gcd/X/AF0Bir8/Qolpz6aUIqLt2FLL4FAiQyOJ2JFxulhC0Yopa4pKo/KQqEATd58+B7W/9Ro1gLEvtBpqCJEnyk4eAFkKoLrnMdJHRo3VRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPip4PP7hVJ1M5XJ++tRBCaRd8QRiuFu9A2PMDDwxiQ=;
 b=sOPQCuggaR9nXZszsk21LP7Ow/STSYlP0ltS9XNOKGUoQOsniDukcEkCohgrB3AdxGvJoH4gugTamviLNFpTLo+szY5a1QZGkiO3ArKvvV5gOQv9f6lmJaxnNzHd5K0ip+afzkuJ7GSgbssBFtigv1xef6L6ZFCgdTF5m124UfI=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Tue, 19 Mar
 2024 08:22:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7386.023; Tue, 19 Mar 2024
 08:22:44 +0000
Message-ID: <4e5cd8d0-b27e-4a32-a055-618a58d6bbfd@amd.com>
Date: Tue, 19 Mar 2024 09:22:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/amdgpu: Fix potential ioremap() memory
 leaks in amdgpu_device_init()"
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
Cc: srinivasan.shanmugam@amd.com
References: <20240319080728.2558078-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240319080728.2558078-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8519:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fESdrdbIirIuUGhbOFGC3GEOr9ubtrrpPlBLl5eHVedeb68C/K/t8UHHMbhHGqJHFI+7wGVviyNSfVCPGRNmAArLtsqWbN3eNZTb2uQj2zS0jE+YPeDS5r6+6Sb6NX6WQNgzmRXnRWWTbVvi42b+zUfvFPEadY+RKpYmDlRpi24A6SlaV2JAL0ylMBZpR0V13292guzGAKk9bvPNpJWvZ/s35TBiS8VHLnP/VnveFjilzAxY+eLg9r0PiNl+f0I8IH03KYtSYUGTUESzSmEVeh5xsRZEfHbhhVE+iZY02PO82T18e5ETZnoADQGLuFAo6daMSF8VHmILNOE7QKO/Kmrl5HzHNFj32pSOUKSHxF3OAhbXKp90cZH3jLb4vUFH5uRigRc+B7X/KL6HoOBedaYEhH6PcNflIoz3yOjuMZDwl58C1Ou4m/FZxq+naOd+HpbOnOLoSyZucFNYWB9DEJmCvMYUck71kmX0UdcuselJqXfeX6YEZNmytQ4XF6EpCMnLqzq6SOMR4MN8EcIiKsv2gubqxWXwwoMOTQeD5zL8FfmVp/vQK1RhxScfjqwZ5tvoSsDzcmqL8j0NmvUdIn22eirSLXZz4DQBfPcVXbDsO5FHbEaW31LzIFQylDD+a8Qkmg+nPkfKZnLNuyhh502OlmNek9QR4EfiJNJqjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZtZncwaFFGOUY0MjdXdnNmSC9UTDVIVTFiZEczSk16aGRnNXNIZmlFNUxZ?=
 =?utf-8?B?cktuQ3pybzU1STIycWFORFFHWVl1M2NWc3hHNTlLd21QRmdzUk1RMmRXQjJr?=
 =?utf-8?B?cFk0SitlbGNaTit1TGRkNWEyRWFpZTdBLzhoZkpzdkpHMUJBcXpRYUhicGxU?=
 =?utf-8?B?SkQ4MVV3NkpKTWZwL2ZEdlpCSVdtK25zY2R1VWlNYW1hZEExMEZSWE1uakJ0?=
 =?utf-8?B?bEdCNHdsQkhCaSszdXNwL0FPaHgzSGlGRnIyV1JMcHJwaHBnbFRzb2V6MGc3?=
 =?utf-8?B?WUFUWVh5RkJyRUQ4MVd2MTE2VlV4NUJxcFNkT2ZPYUwzWW1GUkRLd2dGVTZz?=
 =?utf-8?B?Ri80SzlHMDhYcXg3VjNhQTFDcENCYXlkN05wZDBlelgxUS9MWHVEbDZPS2JC?=
 =?utf-8?B?V1NTTkZIL2RBeStNeFhUdGp3TFJiRTZXZEdsNTcrbEZ4bmEwM2V3aGd6YjRj?=
 =?utf-8?B?QlJWYVN1eHV0bHQ2UW5xR0tCN0ErZUVKWm1BWS9LWFY4cUtkSlNzWFhWTito?=
 =?utf-8?B?SmI3YU1TWVNKVVEvQVRUMzROZlpvSERMTnBxRWd0VUNJL3B5OFY3UXFPaVh3?=
 =?utf-8?B?aGNHNm1GQk91ZmhFZ052bnVWWmQzeUhOcXl2UmFSRktyQm83OWgydHpETG5m?=
 =?utf-8?B?Z1hKVExBQVVBZUFDOEdLeXRQcDNjdG5tdVJLWDl0UVlvc0tmN2ZQMEx1cDk5?=
 =?utf-8?B?TVJDZXlsWlNLZWxNZEZ0V28venJhSUdweFNDZUFqM3lCQjJnTFFuSVlvRzlq?=
 =?utf-8?B?U2hlVFFIM3R4RThXUFJYYVViU3VmeUF4eERyYVJaSGU5Y09HVHpjbDZ5K2kw?=
 =?utf-8?B?V05WYWt4QUs3U3laYVdpdVNSTktNd2J4RXk3bytPOEVtcnoxQnhNdFA3NmlX?=
 =?utf-8?B?YWtaanZldk5xcFFaYTFwSkxDL0VhTnFpWVVDOGZRTzVKZU5Vbm4weWtUbFQr?=
 =?utf-8?B?aFI2eDhXMFRqTzFBUEN1Q3hvVFFBYjhodXdyOU11b3FtME5KdHkrQmpWMHlP?=
 =?utf-8?B?eWN6VisxQ1AxWXJRL3oxb2JFTjYvemVtZHA1RkRtS2prN1VsMzBaV29qenNP?=
 =?utf-8?B?SFNpQWN2VDBIaWRzQU13Q204Vkw5RWNRb3RVbHNGQStLZ1JtSERER05PVER0?=
 =?utf-8?B?NnJxdFV2RjJiSzJndFJ4Rm05bGtleHBSNjhOSnpaVXRsd0UyUDNPNEpaeXE4?=
 =?utf-8?B?djA4Y3d6Q2NiTUJDaXdmMlhhYU1leVJqclUvMGhldU14R2tEV0VHUzlFZXF1?=
 =?utf-8?B?SEpuMERIM0VjNDRDUmd4ZmVWeXRNWXdyenlDZDRhS2NaWHBqWHh2ZlVEYktD?=
 =?utf-8?B?Q2U0K0hka1dXcWtUL1VZM3VLelI4S3k3RjFZblBYT3pxWTlndlgvNWhkWHFx?=
 =?utf-8?B?eEhqdGp5MDJ6Z2pCRzhJanlsV0RjTDBwVjBEbmNjWGk3eThVQ2ZXT0ZEdVpo?=
 =?utf-8?B?SzhqY1hKbVFON2Nacm8yRUd2MEFuY3Vla0Z0Sjh0cFNCZ01NRWZlVlV2R3I4?=
 =?utf-8?B?YnlFczNmc2gxRXFPdXNaMEtKemgzYXZSaDIyNE1IRkxzWHVzdnVRaW1DbXRl?=
 =?utf-8?B?SVUxa1VZSThGZUtJSlFMdnNTaDg5S2RzUGpGOW1wRTRWazFIU0NFWnQvN1Ex?=
 =?utf-8?B?R3FnbTZlbm5sRUN6WlVPRXVtTmxsNHRVdHVYd3pHQjNuMGYwQkhJV0dPRG5E?=
 =?utf-8?B?WWpFWjJhR25TeVdGZ3RieVM1b3ZxdDZuSUdCM2M3VWZ3VXpHTTkwM0xRRkZM?=
 =?utf-8?B?eE5NcjVFWW1talR6ak0vK01PRXMydTdCYmxmRVN4Lys0Z2ZWOEMrT1REZkhT?=
 =?utf-8?B?SVNpZWIzbGFuWC9WV0tHazRHamxlRTZMc1NJdGdJMGZxeXRjSUVlL1BlUXJx?=
 =?utf-8?B?dUc5OEdRR0wxZWhwYzRUcEFwVFBLelZmMlNyRFdCYWxmTi9sM3hGSXdZdTgw?=
 =?utf-8?B?d0hzYXNXN01SWDQ0VWYxQXcyOVpCN2ZJV09qME1ic3V1NmRmeFUrSlZMelkr?=
 =?utf-8?B?dExXNXhpcWdFejRMQW5EKzdWTldGY1ZxMnk0akVQRlNNSVYzRzM4SG43VlEr?=
 =?utf-8?B?ZG83U01Sd2pYL1BzVWhXVkFCdHNyaFlCSDMySmNNZWNqL2ZIcW40SDRQOEpE?=
 =?utf-8?Q?gzzUnztNer31+Wjqjq1/qkAlz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28df7ed3-d28e-4752-1fb5-08dc47edc07a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:22:44.3455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGIj8xjDbfOfwbjQEGtCR8X9R6J6YQeNeSLcZjn2u/29z461oiVk6m70OoR0k9YA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

Am 19.03.24 um 09:07 schrieb Ma Jun:
> This patch causes the following iounmap erorr and calltrace
> iounmap: bad address 00000000d0b3631f

> So just revert it and amdgpu_device_fini_sw() will cleanup the
> rmmio mapping.

I think we can improve the wording here. Something like this:

The original patch was unjustified because amdgpu_device_fini_sw() will 
always cleanup the
rmmio mapping.

>
> This reverts commit 923f7a82d2e12a99744a940954f3829ab18a9dc7.

You Signed-off-by tag is missing.

With that fixed the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 70261eb9b0bb..3204b8f6edeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4042,10 +4042,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	 * early on during init and before calling to RREG32.
>   	 */
>   	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
> -	if (!adev->reset_domain) {
> -		r = -ENOMEM;
> -		goto unmap_memory;
> -	}
> +	if (!adev->reset_domain)
> +		return -ENOMEM;
>   
>   	/* detect hw virtualization here */
>   	amdgpu_detect_virtualization(adev);
> @@ -4055,7 +4053,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	r = amdgpu_device_get_job_timeout_settings(adev);
>   	if (r) {
>   		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
> -		goto unmap_memory;
> +		return r;
>   	}
>   
>   	amdgpu_device_set_mcbp(adev);
> @@ -4063,12 +4061,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* early init functions */
>   	r = amdgpu_device_ip_early_init(adev);
>   	if (r)
> -		goto unmap_memory;
> +		return r;
>   
>   	/* Get rid of things like offb */
>   	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
>   	if (r)
> -		goto unmap_memory;
> +		return r;
>   
>   	/* Enable TMZ based on IP_VERSION */
>   	amdgpu_gmc_tmz_set(adev);
> @@ -4078,7 +4076,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (adev->gmc.xgmi.supported) {
>   		r = adev->gfxhub.funcs->get_xgmi_info(adev);
>   		if (r)
> -			goto unmap_memory;
> +			return r;
>   	}
>   
>   	/* enable PCIE atomic ops */
> @@ -4347,8 +4345,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   failed:
>   	amdgpu_vf_error_trans_all(adev);
>   
> -unmap_memory:
> -	iounmap(adev->rmmio);
>   	return r;
>   }
>   

