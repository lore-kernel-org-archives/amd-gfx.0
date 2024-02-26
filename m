Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6879AC48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 08:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D9710EF42;
	Mon, 26 Feb 2024 08:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e5coFvmw";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263B310EF40
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 08:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTfkX0VHj04hmshp250mZwqaqZTb4vLkMFEHXiQqXJvVU2zx3ehMG/fInZuzf7CmSvJPIzCHkCEADSyB3ZZ4NEYuyu6GK6Qh4Md/jbcSWVCl6mrtKGC49vN8DrEXamI7Ylk2wufpN9kjXEBTnTr5lrI1SE3qKOHYjd3G9GGbSB2m1Y5YR/wwfzjhyGKVc7Y36GiurahCtlodpwkM6NOBwR/2zJBIjP+HBJTo2N6RNDa5tlQ8XuTkUFCt4jJT2QiVydFbsyprDCRYodNDw/L3jUZR0mo0gagUUs2v0VE5f3YQerofuKBmgcTgTcTM4OSa/aOVtva8dOtDawsBFd+awA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8fZGQKSrvsbmBm67WyWn/j2gVKhsc80r8+2PmFxjpk=;
 b=fv40cS7EVBK79yLjcavArJoJ5DIsKsk6Yjbo0SXCOREutGBHaH1usV+FqXJHEXCSBoX94F4oYeWV88WGCS/1UGkNhZz9vXIw1rNlf1IFKgitAkMk6ZpjtuyDpQXBQ7hHu43+UJQrSHd+h/zMwyk5OoipRzGTT3VasbRZXFGQ4JnHm/uFqmzkvvWaiHz1KDnxWoYMEk4PXnwSd4E+8meP3jwZH8jDQRqSXfcE9gL5zbBNV04LFIDFPjFwTMO6F3HJntzdxt7PRKBW/lSqRzOG99qD9iUpCV7kp+hZzqEYGhR5m/leX4YtfXMmTq3Z5FgCMi9q9lFAmRcb/95oS4z4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8fZGQKSrvsbmBm67WyWn/j2gVKhsc80r8+2PmFxjpk=;
 b=e5coFvmwR+osn+/2FOKrOKGujgAKASCqSSUvBlnASw7vO3tPE/DiEe/vqs0I42MhAAJcW/FsAESe230/lIM5hmcYcgJ+tGR0j3CSzgNdPCr/Dd8z9MP8vAYxZJrODZ8f8LLsNJWuPGIlYT/EEcsLk7WJjHKljAf8XL5ELrkpGvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 08:16:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7316.031; Mon, 26 Feb 2024
 08:16:52 +0000
Message-ID: <d916ca82-b0a6-4b32-948a-f5a1c06bfeae@amd.com>
Date: Mon, 26 Feb 2024 09:16:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix potential ioremap() memory leaks in
 amdgpu_device_init()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d7add8-4f1a-4ec3-d70b-08dc36a348b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyE186seOPcTtY+X6hBfkq2zXuHN6yA5ijxsAofCkTpGP0Z+HgNArvfbs+Fi1uTXDL3afGEGbgDyvehJyjrHY2VPMvm6jHgK/GxQHsq6+U/FS5EdJ6r/jxe9aawSHKAD99xx8iRtae0xl2LGyIPic6BjiAcDCuRLOffZWWAcPDvk1ZNp9P+Er8YeptuFDXi4ry0b6nqDjuTf5Dze2ChHnOZ7OrKS6Fi4Mc/Zj3rnQAhZjXiZ/pY6iaN9nH/X8t65J2JV3gg5ABKUzS6KisNW+0EpCMczob3nyU1/NR2nXYaHh62qd9vMFDSq5N2USPYsP5AwAp6qclhp53oXE2RLFlperJ9aLAWp1nVyiJOAQ5H5MrSxIgxc+KX8tdWWxhPAcxMjyvhnAtr5lX2JccVWcZNHACOK1QZp+SMhYoBk+hI+i0iM0AnYKO4h6SUztA6B7pIVgHaQnnSYAW0UFKEZtLIB9rHLFu0/ByqbwhuvE8wbV7n6IrgeqU1b8+19LYIN3srXWtNmLm1AhF3Ou02nXDNwnO4+ochVwm4aK8e5piJO/oLLfKtkZdaNFa9UmCeZqcWDiEbU47RQDSKIvRSzdijzDEfBCjf3CqxjkPc91EoEv5X6L1X0QiBcn61I8yVdH4ionmo4ZhgeGX0SzdinpgqtK3E9TeLdL5q/GZVXJJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJ5K0hQaWJ4a0RZd2xzanNWNXNTZHltQm5XR3RCVWI3UUxYbmtON0RHZDg4?=
 =?utf-8?B?eG43Vmc0R0FydUpoR3A5amZUdm9JZEdGQ1gyUkQzelZTZVNjOVI0VmE5RW1s?=
 =?utf-8?B?ZGVWcURSMk9TZlY5TnRxY0E5YW8yQjFJNmhEVEREeEszdXVLK2tma2xnM3VO?=
 =?utf-8?B?eGgyWFRESEVMZVB6a1JDdG1xZmdpOW1KMU5SSTVWd1V1U3hxVmhxblpnbXdn?=
 =?utf-8?B?REFqbzVpU0c4WFJmcnljcWsyTTFxaFZnbERya1RPa3BRQlZtRS9NelFhTnZS?=
 =?utf-8?B?YyswSzQ2S0hyaFZYaG95a1ZIRHIxSmJaL29Iblk5UldGOVRQRGV1bjQrWlpK?=
 =?utf-8?B?RncxSjJtS25FSHBXTXBXYXFraElFVlRldHBqNE1PWmF6SndUa1BObFFPaVpP?=
 =?utf-8?B?TmRTUUNnUlQ4bDZwOEdoZ3hyZWQrajJ2UWdBU1NuQlF1TnNnWDAzd29ISEpG?=
 =?utf-8?B?ZXVDOTNZOW1JODkvZzVaRkE3TFJjOFE1NUlPdk9DZVpkVWVMenhXRUtWRlNn?=
 =?utf-8?B?RSs0bWFxUHVwVjREUGM3ekhRL0IvWWhBb013ZXRoZkpxdGw5c2JjZXVGSzFO?=
 =?utf-8?B?SjIyR1ZyaDh4UWlWUjBNSDFEN2Y0MGYxd01xNmJkSTdjZ092dnd4b240d0Ey?=
 =?utf-8?B?ZUt3N0NpZUxEVGtrWFJrN2Y1eUQrNlBDVi9DQU5paHVQWXBTMVhHcXNCTjZ0?=
 =?utf-8?B?UWg3WnhXeHQ3dnZuZVM4LzhweDJmVFJEZFdyN3FOQXhxR3RxQS8zQjVvNU1J?=
 =?utf-8?B?R0hKbGRuMjlsdWFmSEZndjFRSEkrY2ZITEVSalFIRjRHa0c3V09pVDdoUXVM?=
 =?utf-8?B?a1NxUjRyUm9HcHpTajRkL1pvWFpuYTVtbG5wUlVuREYxY2ZDZWdPZU5nUzJx?=
 =?utf-8?B?c3NWZWM5b1VtOGdLdTRKY3B1Y0w3OU5iblhzTUVMcGhwNEtxU0tvcEQwckZV?=
 =?utf-8?B?Z29ZWncwOUhKcUZxR2tZVkwrMU54Q3RvNGtXYno1eCtTUWdHeVhQdGVkNURt?=
 =?utf-8?B?cCtMa3lwTjJrR1E4V3phRVBIa0dVSnBBc3RUNkZBMmwvMHJad05TWEpwOXJM?=
 =?utf-8?B?bEMyK2xXTnRmL3RsRTJPMzl3NWRyOGhpZnlUUlc0NFBueEJ0VWgzbm1hT3Ft?=
 =?utf-8?B?WWxHald0WFZnUWRQL0M2cjgzS2lJTEY2bnM5VlJZcDI0NDM3OXZnVW94SG95?=
 =?utf-8?B?bkpFVGxrV05ZbmFxY2lxSUd2WFpvTnRBTHZKcjJJTkhRTzdjaGlTUUFwWGFl?=
 =?utf-8?B?TnhUQzFydUdFTVJhcTlCYVdyZk1PdFdaazYrTWRLUEMwQVJ5b0Q4cEdkeTdW?=
 =?utf-8?B?STQzTUhCd1JPV2dpOThQejdYK3RmS0x3WnJnY3hERkNwQkVrQjJBM1daa0RJ?=
 =?utf-8?B?anc3cnduaklWRGdpU1JuODFDWWJnYS9pL2tpQWN3OW1BTFB6Y2ZjOVFRMzg3?=
 =?utf-8?B?VlhCU1MvaURlSHdLalppOGdza2kzQm52Nm9NWTZ0MGlaY1lNRHdSdDVhcDI4?=
 =?utf-8?B?Vk52RHVFSnozUS9SeUxJdEhDMVVNUXNTV1Zva1N0UVl2d09UM1o4RVlONk4y?=
 =?utf-8?B?WWhISGNjU3FPRG9aMjdHendmdHc3YmJzZEpaWDEvd25haW1WeGxhSGJ6TVEx?=
 =?utf-8?B?ZFRXRE5tbDVRaUhZMlBWMU1YTTNKcjVVaktRV3RZOUI1ekVadzBFSG1BVnBj?=
 =?utf-8?B?NDFGTFVqeXlrMFpxbXY5WjJtM3A0djBJVG45b3R3Z25jSXMweGlKeFQ0dUJu?=
 =?utf-8?B?NG16ckdPcVBKWlF3blB6emZYRzlGWFA4akRBeCs3ZnFjUU40MXlPbk5FYjVz?=
 =?utf-8?B?SUtMdWxtTm8wWXhyWkJNblNVc2ZrS2NVYzlQU1Jsc0F5TkF5RmVPMkRjZHFU?=
 =?utf-8?B?UWdZTkZkNVl0cE9UN0MrcnhWcUlFYnF3dVRsa010SXE5VFJ4a3dkTVQxSndS?=
 =?utf-8?B?OUhFZEZFcldQZFFMWEtSenVIVHkvUlVJUndhM0lNZHlYejNqNDR0MVJFa1JW?=
 =?utf-8?B?V1JMZlJlNEt0cHZJaGpvWTRNZEliZ0c2SEdaREJxU3FGOEloNk5mYjVxQUpk?=
 =?utf-8?B?VU4vRHhEME1PeGpyajhrZktQOHpJSlc1N2N5akhGZmx3emV3NHZ5cEtPSDZn?=
 =?utf-8?Q?Oh3wgJpi4JPq3MuhRbQyyYw2+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d7add8-4f1a-4ec3-d70b-08dc36a348b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 08:16:51.9511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQJPpz2OAnrx3P0TyRKCeL/L2uLvE+AvqI5Vms0VS+Bi5AK0+/QNCebKWGTZYasa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
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

Am 24.02.24 um 07:38 schrieb Srinivasan Shanmugam:
> This ensures that the memory mapped by ioremap for adev->rmmio, is
> properly handled in amdgpu_device_init(). If the function exits early
> due to an error, the memory is unmapped. If the function completes
> successfully, the memory remains mapped.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4337 amdgpu_device_init() warn: 'adev->rmmio' from ioremap() not released on lines: 4035,4045,4051,4058,4068,4337

Hui? How do you got that warning?

>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1ef892bea488..68bf5e910cb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4031,8 +4031,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	 * early on during init and before calling to RREG32.
>   	 */
>   	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
> -	if (!adev->reset_domain)
> +	if (!adev->reset_domain) {
> +		iounmap(adev->rmmio);
>   		return -ENOMEM;
> +	}

Please use a goto label and error handling instead. Apart from that 
looks good to me.

Regards,
Christian.

>   
>   	/* detect hw virtualization here */
>   	amdgpu_detect_virtualization(adev);
> @@ -4042,20 +4044,25 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	r = amdgpu_device_get_job_timeout_settings(adev);
>   	if (r) {
>   		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
> +		iounmap(adev->rmmio);
>   		return r;
>   	}
>   
>   	/* early init functions */
>   	r = amdgpu_device_ip_early_init(adev);
> -	if (r)
> +	if (r) {
> +		iounmap(adev->rmmio);
>   		return r;
> +	}
>   
>   	amdgpu_device_set_mcbp(adev);
>   
>   	/* Get rid of things like offb */
>   	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
> -	if (r)
> +	if (r) {
> +		iounmap(adev->rmmio);
>   		return r;
> +	}
>   
>   	/* Enable TMZ based on IP_VERSION */
>   	amdgpu_gmc_tmz_set(adev);
> @@ -4064,8 +4071,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* Need to get xgmi info early to decide the reset behavior*/
>   	if (adev->gmc.xgmi.supported) {
>   		r = adev->gfxhub.funcs->get_xgmi_info(adev);
> -		if (r)
> +		if (r) {
> +			iounmap(adev->rmmio);
>   			return r;
> +		}
>   	}
>   
>   	/* enable PCIE atomic ops */
> @@ -4334,6 +4343,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   failed:
>   	amdgpu_vf_error_trans_all(adev);
>   
> +	iounmap(adev->rmmio);
>   	return r;
>   }
>   

