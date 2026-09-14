Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702B8C88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 10:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54F610E472;
	Mon, 14 Sep 2026 10:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DMB9u2z4";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213EE10E472
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 10:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlxAYaLYLwIvKAnHUG2ifT+qyXEYONRaRs5GlqXPchGsIV6Pxrw/H6tR2iYeRb4FQCxDJf/njFY1TkfrVYOsy8KWiF1l6K3wIshA2d0U02ZYb8E+cWWsQro3pglwreTLoKQxW/hOB61POjMBNQ+Lf55ybHyBJOqzq6qPb3cAAitXh7S1l8WeDBA/K3d9/RFdL5/F7CZeYaIyIzJOQObEYfO8vb6DvlShZhmptEAT3TkF8+QP4qVUVbhKS7GpccjawOMkqhS1APQ0SMb6khSA1/bfOBFrg2vn2gXfcPxChFBYREG82/1R5420xFaNcUg3Fsqn9uf/JCBA95N5obA1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPLjyHoa5JwnwwDShraSsc2ce6sK99YHvjUOOWVIFDw=;
 b=S1sNkAmr5UtTlSBjzarrAv54Ibniz83ZvSvMaDO70N4HSV/GIWJ179KR6zIycWg/Y3jkCFZeEHvDUD68hzJ86JqZryFVoOQYKSc2bjUMli4GcrmDeyWuetF8Ub0e9NBXIhUcudbuyhyEYHO7lskamrCQWXvSPL2I3rBYEkUiVUBdxdi0WHGCDpSJwxZgRDE4gVZInTPdZytWRDtvd2tgl35dbYOizx36Qyp3MgNMtA0Y1eJOwbKVU/NLzx//ONBJ8NSDhGW1wiQoom/UrhKyxdsv9J3NDCZ++7RW92D6qaSJzLF0TTlkZ5KUNFmjBLtlztCEiiO5yQp1zBfqdQeLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPLjyHoa5JwnwwDShraSsc2ce6sK99YHvjUOOWVIFDw=;
 b=DMB9u2z4EIsj3wg0QEU0FHSmbYaWaxo9rYB53Xqe4m4/nu844b7AuOWfiqQWig8oHZC2/RCbETVkCC9lifORviA2SC9S1TUJaLR0zXJ69+ySKGNy4S25Abc1Eay3EVPparypQAsbtXyBc/oZzrvu1adPmvNUJtc8rFVysgC0iu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 10:52:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 10:52:27 +0000
Message-ID: <76a0b557-0122-41ab-ae74-4d6bd9b2719f@amd.com>
Date: Mon, 14 Sep 2026 12:52:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu: get rid of amdgpu_drm_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
 <20260911154212.591213-8-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260911154212.591213-8-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0426.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ed4984-f697-4cfa-c3ba-08df124e4457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vrUhrnfhWRiJo2VlOiLvfptOHI+LAF/bidBfUPNZzJK+MYqsZd6XqUr4Lyv/HDdHGBSv9UkcrJ57DlxgVfSkbzmyWP3S9it8MS04t7dpz1hfBT4San2BGdHwDE5xobFxPZIgfQ8oxOMIYlPAFES3KSWM6JxaNFYDCJx8KWQ0Qxgynt0BHGQjcDjExja1vRw6uV8hzFpcF8hNZfc+9Arpv5WCS8nvLRr18YxRAxBiUgmloztVsl9Hv67kMUJMjdDXpG5lEWiq8FURHqEOHhDnSUzJkUFvzFgcsqq0HyTLbcO6OtQs5OtBDxWhLYXcJQSEzGoDCHCNRo84N1sGvcSH9Q9+AYoi7D0FsLNzRAAqeoiq53AIF5suCjucsbn1MNReq829ZYdGQjaepnkyyfTpO7zVCi/FD4JDS15iumSKwVtavFCv2qim8jSAiDmrkdQFbMNve8fmvbKlimxLPVeOAn/TN+Am7/mgPHzLkSqdnIMeAo77uO46kZVfiwwymDhjMDSjdOU6h17/UrZLzrbgVgCXCXFe/zmSZ19d5hZLJ2T+5uWS0WzQhK7y/De4S/sWLkOq9C/BzEIArlJLDdBCpsufV7liPRpllVlYWXJRgWPXMXdBBcZAQk2YpEjbKPm4hjFcZ361ZFddkSEHzPVXxLb5Dts4wMT5tKvsbMDM1ZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlNaVUE1U2RaU3pnMllyb2pMZ25tVnNWandRNVB5NlVveDZtME00ZTI4dHJT?=
 =?utf-8?B?MitvTXljdGlMbWZGRTVEODZaSFJTcFdOamYrK1hTa3NYV2VDUkN1eE1JK1Zp?=
 =?utf-8?B?MW91clFMS2NxYnFiZGppTzBSV2xDZVpFWkpZMTNFTjZON054MjNFR1gxMklR?=
 =?utf-8?B?Ums0a1ZqZ095OVFuTzJrZ1p4Zk9YUHdBZXZCSHNoOFV6Q1N3QUNxUjBCazVJ?=
 =?utf-8?B?aERybUZyVmdTMjVaN2dIWEU0R0g4RFkyWm55eVZnaldKbHRDcVhEeHRqY0hm?=
 =?utf-8?B?KzZadGxKaWRYM09QazBORnFQQk1oUGNINmFqSW0yR29HeENvbWZhUlRISEtK?=
 =?utf-8?B?NytsYnp5TDNyNmVFT1VIR0FoblZuY3BMa3hBS21kY2lLUXJ6UnYxbWQ2U0Fx?=
 =?utf-8?B?azVqYlhzMW9YdTJHMS9WT3VvVE1PSSt1eE0vOXpoL24xeHBWSGVXNk16SnYr?=
 =?utf-8?B?OTYxNGdWRUVkUDB6N213ZUhxaWoxaUNaaG9MZ2Q5dXl4SHlVeE5lbkFMRGd3?=
 =?utf-8?B?Vmw0OUR3cExXWWl1dDU3R09YaHhVNWpiblZ6Ri9KdDZrTzc2ZDRUUFNvSDBV?=
 =?utf-8?B?aWk1cnV1YlE1SStRdFFCWE5jVmN6TENXSE1oUGZzZmlkMUV1TW1LV3hLZitq?=
 =?utf-8?B?ZjVEam9jZUhEczREbEpoSlhKRVh2OFBjZE9kdStaQk5McWJuWjJzK0p4SFdF?=
 =?utf-8?B?SE0xN1NVYnRwMWdkR2tTb3o5elROMmlwOXVqV2ZKR0RPRnFZczVlb0tKQUhU?=
 =?utf-8?B?L2tUNXFxdTVUbkl4Y3JqNUsxQ3E4ZVRSaW44QXNxdUwydHZhZFp2d1EyZWZm?=
 =?utf-8?B?OE5PU3pZRVQ5SkcySTRoLzU5QlN0NFo1Z0VqdUo0TEVUUmpBUmFKYjU1ditR?=
 =?utf-8?B?cTNQcTc5eUVMbzdOZ2R6K1R1aDR2L2w2aU1YczBxUTB1VG11cmM2Mm1FODEy?=
 =?utf-8?B?TmtUWlNJQnB2S2JVNmdBVUZGdVpTanFtbUpmbUp3UUhLLzRsYU0zVThRTFBp?=
 =?utf-8?B?RjlUZDhJeGpwYlA1WFVTQnMrR21ndG0rYWFwZTRkOXRjZElJa2FtVHpDa0pY?=
 =?utf-8?B?WGxCUlhYU09VaTJxQVlGbkdQbWt5RnFqb0lOR3V2YzdTUXlkTkJrOFREajAy?=
 =?utf-8?B?UHBSa01Tc05QTytPZjhXem5rU1NmMlhZMzVXZUxNWXJsM3k4dzgrMjVvd2dV?=
 =?utf-8?B?S01wNTFGUFNDUHdsZ3lWa3Rtak5DYzFYNUxCMGlhTWlsWFNMSlpodHBXdkNC?=
 =?utf-8?B?SjVnTUtmNWR5M1RsRzVPTklDWTB0eG1LNnc3ODJqYVczV3VKZEc1UDVHNWJT?=
 =?utf-8?B?b1M4ZUNxSnZ0RE5kOU9tZmNQS1FyUU1XNk1YQjVXdWhLWGdFclN2VlJNRjJo?=
 =?utf-8?B?N0lkOExpTjA5V0NzN0lseHhwTTVFSjFOSFp6NEdVWUpvT3BJdWUvMThydWZj?=
 =?utf-8?B?Rk1KZHhhbVM3ZnczOEE4MFRTSjRGcnp4MjZTWjNESVd6NXdkRUxEbG1DbjRR?=
 =?utf-8?B?UFMzb3VSQzJRSGpOZHpKRGZwcW9BaUpXcHgyck1nZVF6SUZKVFE1VCtBSEtz?=
 =?utf-8?B?K2NMZEY4Njd6ZFpKTjBTajZCY3ljNnZTdm9qd3pEdk5ZUFZFYjFOem9WZnNS?=
 =?utf-8?B?RUUwVTREaDFmZmdSU3ZqOWxNamhPM0dFN01JNHo5bjZLeWNxVGcrZnVWT2ZK?=
 =?utf-8?B?MWVTS2NKMVJOcGpiV2oyTlRmL01UejVUeU93SVpjZ2JGbHZrSGJ6UWR0Y1J5?=
 =?utf-8?B?OHhpaHdBOFBDVjVBbWhtY0I3UWxneXhiZHlZcVNUcExRYXZqblNvZExmV0kx?=
 =?utf-8?B?MXhOQkNKMjArRmI5VFpGQ21YeFI4VW1mSTNRVkJUWTk5RjFLOVVSQ21XbmRp?=
 =?utf-8?B?QjdDZ0FZNmpXSnZ2dnludE5yUDFiYXQ4Sm9NcnFOUkJuVUdTSm4zbWtCZm5s?=
 =?utf-8?B?b1F6UDh1YVVDS3BiU3pmUXRITEdLWlJFUS80L1RwU216YWtnWVVFVEdVZDhv?=
 =?utf-8?B?YURneG5wNHU1WGxZTThJVVRLSWtLbithQmUrT0pxaVFHa3VFZDg4UEIyZjJq?=
 =?utf-8?B?anBmOFZiUC9NR3pWVTRhYlNyV2IxSzcrcnVGTGsvOU5qcUJsYzBYSzNFZjdF?=
 =?utf-8?B?OHB1QnNnOXY3OUh5bERmaS9JemYwbEpqYTlNQWNBM3plYlMvcWRBR3dPM3pi?=
 =?utf-8?B?dXZNNWZkUk5QT2lGcHFVNklrUSt5TW9pY3RxbHZGYXh1cFE3bzlBdGI2ak1R?=
 =?utf-8?B?UXlrSHZ5akl2RW8rRmZ3UzZPSHlIQ0cxT0FpcXE0QkZpdFY0UDE4bllOV2p6?=
 =?utf-8?Q?eGwWh2yHI/kS2N3ZAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ed4984-f697-4cfa-c3ba-08df124e4457
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 10:52:27.4520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9FctQaxIzF4iLt/IkLOjB3eM4YaFKevkyjAbyVJtmm1DpQhIKo2CGJ0/PyeIlaT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
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



On 9/11/26 17:42, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Remove the entire amdgpu_drm_ioctl handler system in favor of drm_ioctl.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> [shahyan.soltani@amd.com: Added commit description]

When you modified the logic significantly it is usually a good idea to add Co-developed-by tag as well.

Apart from that you can add something like:

v2 (Shahyan): added commit description.
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

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

