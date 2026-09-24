Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A384C98311
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 10:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05E910F455;
	Thu, 24 Sep 2026 10:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I6muTsUG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AD810F455
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 10:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNVyMjxRM44idemNr9UGuLyZdfHsJGLvA02SyzKo3vj/hg69fJXLoNSgQr1OVtvvZTsBi7q3gKUrGYjmi5csxY6+XI9iguD37K+w0E7kgFnEdNeTTaPjPZOhZWaphH/u4VRRRCERHRWiNjKvXVq9ZKJWo8MNR0lHXR/sydC4MLZhAq7OdbFz8hIh4GBBMuw+5xxYVhbdmZJN/m930AK/KjTzF1tQu/VuZ8zFglLYhItcKMXD9WwZHzmjxjdgfMbyX7s74JCmw2Jp7jpTExYi/pXvlmSA+J7ceGwWZNm6bzv6tXlwA+g2VVLiv+8fYFoh57tsfnYqY6fDLR6Mr/NVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDYYxwI3smVZY67NGFXrQad/Uf0AdpPvqcNNZheX/bw=;
 b=YVZs9Fq3U7KuThjJjlQRu/CJnR0miHABNhARH13SwfOkWfvNd561gVENbtkkkg0cmT5QpPrWaEp8tL12xN0T6tDaqKKY/XaIOj0wdft5LyWNG1LfsDHVBllNRA07PgMSJnk1iKvDawSGX1Dc8NmUkSUjvbSrUpUhee+oA3cdyI/rhHj6DEyl8ftYwyIK+k6I4/+Naq+joA3O/tRRHo2An1yQ1/QESSVqf6/Qf0Up6b2gYQapNe0getWf0sxkmIKz+l7+HOhoi2eA1FCZlf51Q1s/n/KBn4D94SY8koamK3QEVeOemkmDjDuGF5iSFTV4D1oGt7QqBsZPeVasQFL2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDYYxwI3smVZY67NGFXrQad/Uf0AdpPvqcNNZheX/bw=;
 b=I6muTsUGLH8c5tjPF9lwHlTwVJP1z4BcqpMDLI0h2mrsIyARyJPApxKJD87nHbY2nbRZddtrjDJqCh+0ikEWAZ8+GiWT2i1nHF6Shck/JFYcNG+txjak6pb+GsnvbJ8tXesgfVKWEWLxfbgeHdqf0n3q1TUHrXdRN2bUwtZl63w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:29:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:29:04 +0000
Message-ID: <4260b28b-ed7e-4bdd-8559-7eb07de10cb9@amd.com>
Date: Thu, 24 Sep 2026 12:29:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] drm/amdgpu: get rid of amdgpu_drm_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
 <20260923193346.2292597-8-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923193346.2292597-8-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0288.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::19) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: b5639b20-97a4-4f76-a8b2-08df1a26a80c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: GVmru+7ds5gUFspNwElyvTmDPTHyj4VN6+7oiGLEJSiaungp93T1T7LDgjnC2qjIdiYUNO/j1ioXgPhHttMNEv4qc2bWX+kyhujHAf0ngt3EXugMdm/Qh3w1P9L+rNh7zBCBccX+qAdfxEryRWSqflIIpkiDuw4yv4P1HrzVafPXlbyHM4Qyo3AoBLQYRMsmvnNktM6D5AeXlXeDoEOtad4d8dq7/G/fJG9LoTTOVeSV4vBR//mfyXZLy82bTxZLZVXj7znqw5KRV2ooQQh33Ah2DXC6EfqtgELspqE6E4Vtb1WFDrwiP1Ggw6pnqNoPQMqasYjyhHTf+2XG2zqBrempPmxB9P8K5ng8G5chUhL5MaBl8Y6SHqo9Ap7jOcX5ipbZXOrQjglsLX6nfYns/0JkTmvUEiXzzXdRXgskJNvBoa74Pdr1pITLvMzLtZcNseuvOYUmr1AyonyPusgyy0x9x1eod/BBJsFKGACwz9rTEXqd6Z5dNEqW74gud+mp9zZVpKMY0LXkIGsJPQcJLJtr0cgFK8rKP2aSNZs8DlCPRb68QUGvRhCEJ6U7YF2WQsb1vOH1TpSeVneIFjo/Bp2ceh3XknuH4ypuBVfjErBeAiDhlYbKsOyDVTtKGFYQHbAW18uWptOpAkoTlFviRjuJYD2DpXGmVa72SeSBPwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWMzd2Z6Qlg0MEFpQ2hLRmErMGxQM2xBYXpWc2VCZXJjYjhSd0RXK2tqdG13?=
 =?utf-8?B?Vi9jSGlja3dJVm1nd253WERnaDdxWWwvQkZyMnJLWjN2cFdIdmVDb3VsaWlH?=
 =?utf-8?B?dTZhMkt4SUxJSHgyQTYzVTFzVlJLWWZqa05HUGF6QUVVQ1dVWmJVbWFkOUht?=
 =?utf-8?B?akpaQ0hxN3JkL0Q2bVkrT3QrU1h4K1ZMdU5aUzBEbExyakd5WmdPQmxlK1ZS?=
 =?utf-8?B?TEdjWGxVaW40YUZUWitDN2xTdlJjbThNVUlFa3pXa0tydXlCWklFWEFSSVBX?=
 =?utf-8?B?bmZjbEN5YXFhMTVDSkZqREc3aW1xN0FnYjBwTENpNGtGNzRNbXNvNmEwSjNj?=
 =?utf-8?B?OWdXb3E4QjVjdVJJWVFQT3Q0eFNweUlxSi83QTQrT3drNjFvL3JYbGFjdjBF?=
 =?utf-8?B?cmpiV1hCRk5TeFJpcXpENzNqMWlaTUtsZjNZZmw2bzhiMit3bVZnTjAzMUFC?=
 =?utf-8?B?dWFzMGhzdGJHb2hkRXpYNWN4bFFBTlNSbUxab1FjUVo5aHdmMnNUd053TkZI?=
 =?utf-8?B?TEtrNldjSU1Ma2kyWjNvNHZEdXNsWjIyWm8rQTZKMWhIWDBTZnFUSW4xelhZ?=
 =?utf-8?B?d2ZlN0xRTmM5cVcrcFZHdTVNMFlGU29jU1FaNTZlYmp3UGJRbEtSUlBoMmlq?=
 =?utf-8?B?S3lkSWExQ3IvOFpNS3hCcGx5cHk4aDBKcWpTK25TUzN3eEhSOFZOMUhUSXY1?=
 =?utf-8?B?MldEUmtWQ01qWGpQU3F6QlRpREtiQkZxMzlBWkQ1dFRJaE14cXNOS3djdjZ4?=
 =?utf-8?B?ckJWY1R0M05wc2VCTWhIYTBoTG5VT0NKR2N2ZGVuTzVLN28vRlpubTBvd0xH?=
 =?utf-8?B?ZFQxQzZTTmFEdEFGMFV5OVcwamNWOHpwMDNNVFlzYmhvRUJZVFg5Tm9RYnB1?=
 =?utf-8?B?a0I5d0g0NGlkbEVEUU5SMkw0YklqaUlZbnJSdFRjNHhPdlplOXh5T3FLQXFs?=
 =?utf-8?B?emovaWNZdFJFTDR2QThtckxzWjlCRkFoZnJrWS8xaktIRDN2OEErWjB6NGp6?=
 =?utf-8?B?ODM5dkN3QjFnaFNnZlQ0dk15M1ZUT2RnU2xWU2VMMFg3RnpBYUJjWnpuOGNp?=
 =?utf-8?B?ZzlyNlZnUEV1UWpFK25jeGZtL2tzQ3FxTlpqS3ZaR0gxUGJvb3haclo2NU5L?=
 =?utf-8?B?VmQzSkZjUVBsSWNvdkdpTVY2VCtLb3dmelIwSnpTcThhUkw1eTFlV0tWZ1RX?=
 =?utf-8?B?VFkwNE0xdGhEMXhMaFUrVmdha0xGVW8yNUtWQlg5R3REakxIdUxOVll3ZURo?=
 =?utf-8?B?dDlKSUx1MTVXbitIY1JpbHlJM1lxS1J1eDJuRTk5WFh5UjVaT1BVTkRkbTBF?=
 =?utf-8?B?ei8xS0t6eERjR0U4WUpwOGNQY25QOGRGVnhwNHprak4vZWlsM2ZuWncraGJu?=
 =?utf-8?B?RnlTaDVHSUdNL2ZYSWxvRk9vNVFBZDk1WW92b292VGpLemVDNnlCZUFRQmVo?=
 =?utf-8?B?ZUhFdi9uWVgrM0I4RlA5UURWejJFRjdwdTQ5SlppV0tJZ3pKZGFKc3pnRXlv?=
 =?utf-8?B?Q2tJb3g3Um9WSjBvSlNBQXBTZ0NYOU9MWXpOV0k1L3pDUlduQjhHMzBibDhq?=
 =?utf-8?B?ZWl5b1crRGlISFBCYzlsWmIyQTljVGRHQUVZV3VndEhVUm1aZ0J2YkhUcmEr?=
 =?utf-8?B?SGdDL09LWnc4eXVoSVNiSjlwZXRlaXFrdVJVM0JsNkhVOVZ4T3BiZnBHVnNr?=
 =?utf-8?B?ejgzVTRZem5MdWNqTmIweUVHVTFyZWJkdmlHdi9MU3BvTkhQdmpjMGZFZHgr?=
 =?utf-8?B?QURhNG9scTlIa0VxbGw0TkJsamlaVnV6R2p1SkJranEzVFExTXhMQk1GTGJU?=
 =?utf-8?B?Zk9od3lmNjg1YklCMXcrZkhPWm9seWdmZlVxVkpVTk1BRVRQUDhaaEoyL2Fv?=
 =?utf-8?B?TzMybUFqcnJRVi9yOXlrd21nV1NyOVJvTk03TXZjZXhLaWtQdG9xRmxxcFBJ?=
 =?utf-8?B?NTBKV1grdTVOS2Nka0pnMForeDQ1SytoOFUwSTVOWmpEVDk5WHZvTzE0Szl6?=
 =?utf-8?B?bmszMGZyN3VsaDBKekt1dDh4cmtkMWlmZWZWcnlLajhGYks3ZGFTNHpIbkVY?=
 =?utf-8?B?K2FuYWRyNThNT3Jvek5nT0kxS214NDN2K2FhSUlFRGlRVFRDS1JlbXAzZjZ6?=
 =?utf-8?B?WVYxSU5FdzZ1REsxNE5aMndxQVgxdThIK0NkZVljcktQd1VLK3R5TjhhQmZD?=
 =?utf-8?B?bU55S3JVdHVBczNPdTRHVDVXWUtCVG9yWDhYeUtCMU1DWUNFeWRHKzFwYnoz?=
 =?utf-8?B?S0dKWHUvZzhHN0tuR3BkQlhpRGtkY0RraEtER1BVT25NRkplTzhySG5LRjdp?=
 =?utf-8?Q?SFEo3j5IPUbjfFY96Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5639b20-97a4-4f76-a8b2-08df1a26a80c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:29:04.6543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbOwdzcr6gIK+EqV8RmQXTY5hkJX1Oht1r8bqCRgK153TYo/SR/blK3oSeHtWvnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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

On 9/23/26 21:33, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Remove the entire amdgpu_drm_ioctl handler system in favor of drm_ioctl.

Please add a bit more commit message, something like:

Each individual IOCTL should now handle runtime PM itself. Fingers crossed that we haven't missed anything.

With that done please push patches #1-#7 to amd-staging-drm-next, I think they are ready to land now.

Thanks,
Christian.

> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> v2 (Shahyan): Added commit description
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 23 +-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h   |  6 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 45 -----------------------
>  4 files changed, 2 insertions(+), 73 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 7b08814a24da..d5ddf236a6f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -321,7 +321,6 @@ include $(FULL_AMD_PATH)/acp/Makefile
>  amdgpu-y += $(AMD_ACP_FILES)
>  endif
>  
> -amdgpu-$(CONFIG_COMPAT) += amdgpu_ioc32.o
>  amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
>  amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
>  amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 9c5e93cd3ee6..f51f03ae5241 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3019,25 +3019,6 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  	return drm_release(inode, filp);
>  }
>  
> -long amdgpu_drm_ioctl(struct file *filp,
> -		      unsigned int cmd, unsigned long arg)
> -{
> -	struct drm_file *file_priv = filp->private_data;
> -	struct drm_device *dev;
> -	long ret;
> -
> -	dev = file_priv->minor->dev;
> -	ret = pm_runtime_get_sync(dev->dev);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = drm_ioctl(filp, cmd, arg);
> -
> -out:
> -	pm_runtime_put_autosuspend(dev->dev);
> -	return ret;
> -}
> -
>  static const struct dev_pm_ops amdgpu_pm_ops = {
>  	.prepare = pm_sleep_ptr(amdgpu_pmops_prepare),
>  	.complete = pm_sleep_ptr(amdgpu_pmops_complete),
> @@ -3070,12 +3051,12 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>  	.open = drm_open,
>  	.flush = amdgpu_flush,
>  	.release = amdgpu_drm_release,
> -	.unlocked_ioctl = amdgpu_drm_ioctl,
> +	.unlocked_ioctl = drm_ioctl,
>  	.mmap = drm_gem_mmap,
>  	.poll = drm_poll,
>  	.read = drm_read,
>  #ifdef CONFIG_COMPAT
> -	.compat_ioctl = amdgpu_kms_compat_ioctl,
> +	.compat_ioctl = drm_compat_ioctl,
>  #endif
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = drm_show_fdinfo,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> index 2d86cc6f7f4d..6b06c0956e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> @@ -43,10 +43,4 @@
>  
>  extern const struct drm_driver amdgpu_partition_driver;
>  
> -long amdgpu_drm_ioctl(struct file *filp,
> -		      unsigned int cmd, unsigned long arg);
> -
> -long amdgpu_kms_compat_ioctl(struct file *filp,
> -			     unsigned int cmd, unsigned long arg);
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> deleted file mode 100644
> index a1cbd7c3deb2..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -/*
> - * \file amdgpu_ioc32.c
> - *
> - * 32-bit ioctl compatibility routines for the AMDGPU DRM.
> - *
> - * \author Paul Mackerras <paulus@samba.org>
> - *
> - * Copyright (C) Paul Mackerras 2005
> - * All Rights Reserved.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice (including the next
> - * paragraph) shall be included in all copies or substantial portions of the
> - * Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> - * IN THE SOFTWARE.
> - */
> -#include <linux/compat.h>
> -
> -#include <drm/amdgpu_drm.h>
> -#include <drm/drm_ioctl.h>
> -
> -#include "amdgpu_drv.h"
> -
> -long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> -{
> -	unsigned int nr = DRM_IOCTL_NR(cmd);
> -
> -	if (nr < DRM_COMMAND_BASE)
> -		return drm_compat_ioctl(filp, cmd, arg);
> -
> -	return amdgpu_drm_ioctl(filp, cmd, arg);
> -}

