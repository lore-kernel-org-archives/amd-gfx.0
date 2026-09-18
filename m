Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4F3C88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 07:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D4E10E7DD;
	Fri, 18 Sep 2026 07:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASw/Fi6j";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0095410E7DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 07:57:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NT62vXwxCbSKbSw4GVM355XK9zcnWqvkEcpqTCCuuEnnQVqN7J3esUNpC3N66VQJpGb6X/4NtnaADaI+YTwNjCbAQ8+NgBq9H8fclnQWpFb+sAGJJ/yKwdkqj3GlZZHPycl+hyfmelf8A/5CIf+9VecUYKAKpubVgB0amZlmcdUDVlOwwqXPbzqIJP9Xp0TAcxOxOUFpOyclhGjNQpd0KejZWEUZSO32rpVtErG8Be1KcplOcqNb6yhhEQOOEfj6UXw/pygzFMft4nmm9W4QGKPDDgnLb2pSnmXnuOjtmmA9ec2tOUUOxZnwxPVdeRSHxP647SBVY1lNgueRymnYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/TvEtaQv2VqE/po4l/EHy15Mpe3Nf9jgTiVqEgP7/M=;
 b=Z7OkejYFFQzL8lm9FmsmJY4RJKzIF+dkd88XJCpeEC/B4zQ4NFRC4K2LdNeLVCYXck4cER+bBgGXyar7tScODRRzi6jdBj+HmPFF0MRhr5NLyWlPWgSsUMvlDf3S+cZhWQF9wF+lHsyAJO48wT76cp2YlcUypr5R52soYPolPHE9kF8Ig7qavR09BOLwGPhQIHKPcBPJTi2INN2Obufr6ma/koXkT67FzqppYaPOQ/tAJGRkNP1U1lo668onuRy0XzOZnB9uUH9QrpXy/ZGm7Zss6jEHptuS72YbjbxhW30p3koUwDs6SNyDa1Q6p9zTf1QatpxtFIszXp2jdime0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/TvEtaQv2VqE/po4l/EHy15Mpe3Nf9jgTiVqEgP7/M=;
 b=ASw/Fi6j1ok0JWZ84s1hBpyx9ahCRc1lYJDVeJjT8Dbza8zSfTNzxqp+Hf7m3MzLmWWTe6zkUgrZ/kcSAR4Af3yZBpj6LEkHdTZHeB4ocRyFze7m/M0Xdm41D+h6L++A6GVfu+0aXOvYqwo1hWE7Mjxcs30XEQZTg1fd5qDuXEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 07:57:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:57:41 +0000
Message-ID: <2d2520d8-6477-44d0-a298-37bd078da24a@amd.com>
Date: Fri, 18 Sep 2026 09:57:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/amdgpu: push down runtime pm handling in
 amdgpu_gem_create_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-5-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917195812.72917-5-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0383.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d4f63c-add4-4903-07ee-08df155a839d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|6133799003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KkGwqGUjH+xs17QCw93VNfdfrC3n+aBkTd/STgRBvldKk1kYc0WltwQ9HzPmzBRbz2WX2AuntQqt5Co/X4hWxeP8ys/dedg2zr4e/5L/KnYK0jbXc/mRzuBptHgrL0JJJxKuIchZdcL7ydjQ6zsxVSV8SO+SD4B9ajw3PS1eU3kYaNqd117ko35Bwh6RuSHyTMBhLqcRoGjx4bMgGuG2J4aSgxgPa/Ytk3OaoWyIEL4GxZMJx7PZM/v843yCYlJUCb6MNTSqUkVS+YKerP/h2IMHEDuRPsmH4FESjCD2yN0mKczb45Pgo7UG9F75/QbvFF17qhOLwnq9K75W3ov7PRcRmGaEZ+33s5N46RU1fy5Uynd23lknCJMAZ4sGXbpvceeAGfi9KyyElNao8AXuQ7MpNOsPsYQyz1552kf2IXa/Iou5lEujuU1E/T5rN4Usrkj1fZAZm7PWcu3vBa5EMA2vEvb14LJcvvALrzEYpVN6Qeu2aDLLRwQY3iqZvxu2H/tOLAcJfI+vTcnLeHw6pY/UP81l/S/9FtFRbsTAhhJgXEVLypOOC2+vtzqAaf3omH36K8mdqEjt95BVJSQEzv3nsijebj0GzI6n7e13wI8+MXQyO8eL4QPxvnNJZCkmUeVJ3/YIJZrKUeW1gGC4ZNCxhSm/Svi4ZNhY+dwAqjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjRwT3NvWW9nQXZFbE1XbWN3NWtRSnM1aE0veXFqQ0dGOFl2d09mZGlpUmJZ?=
 =?utf-8?B?dW9wcEdoZXhBWTUwZ3Btcno1NUk0TlVONG1DZXc3dlNWWmNOS0RCaDBJS2JV?=
 =?utf-8?B?OHVSM0RCV1hCemgrS2VOcUJ2RmZoS09TVDQrYmZWT1h6STJONi9OdnJUUGVk?=
 =?utf-8?B?TmRuYk5WOE93T3ZtQ3VCSnBqaHBiRUFoUWdsbDlXTWJsRzZVL1FiOFM1Vm5m?=
 =?utf-8?B?OTE0NUZwSWo2V1BKczlFUjNranVrVGpUaUU5VnVLZzNaekx6ejdlNDB6bWZw?=
 =?utf-8?B?d1RQN3IxYkNSNlB3MHlzUDM0UmdXOVREbkJMeEdvVkVIRk9ZUSs0Y3B3alFp?=
 =?utf-8?B?UGRPRDVrS0xKaDZ4Uk1EWi9ZVXBJRmNMemlWZ1A4UWUwRkFhWExqMUZ2TG9H?=
 =?utf-8?B?ZWd2cmtpdXB0cDNuY1lNYTFlSk9oc1RObXl2cGwwR0Z1Z2xrT2hCTzZ0U1A4?=
 =?utf-8?B?REZ2cFhkNzZROGRIL0NlKzJQOVFjd1I2LzBUQ3lXcmdJeWs3UHFyaVJBL1or?=
 =?utf-8?B?eGxUTG5YN2QxcXlpK2I4UnVZbHNOSFNIVzIxQkcwUnNla3h1ekpENTAvaWtS?=
 =?utf-8?B?dXFSNGFkQ0xuRTFsVkR2eEhhK0syT1R6dWlHZkpsKzJCanFPT1V0OTFhcGZy?=
 =?utf-8?B?MHNpa2lFdXNqeDU2blZITFRpYlhkQTlEWG5NUDFTNzgzM3VKR2FjR1VpZ3NC?=
 =?utf-8?B?cW1hOGNlSTNLalR0aDd0V3FNSmRoWTk4V3QyNS9sblR2eXJJd0ZhL0RZUDN3?=
 =?utf-8?B?WE42NTBJSldkM05OME51a1dlK2h2K1BtMWJmajgza3o4VWFuek5UeFQvNGh4?=
 =?utf-8?B?UklWN2Q5dGZwbGhIREpOMnd0NjI1Q0JuUENiUC9qbkFlUTVodWZqSzNwdkQ0?=
 =?utf-8?B?L1hoSzFSZHpVZHphNkVGYVlaTmhEL3JqZkk3aCtKWkFiRmxaeVlpTGMxUTh1?=
 =?utf-8?B?WlFkc0NHSEM0cGFtdkFjamVsSEV5S0JRVTVQeXJKNFA4S2JqL1E3cmtNKzdq?=
 =?utf-8?B?K3ZtQ1FCaEZaeXh1aVBCekNXcW83MDg4K0c0L0RoazhtaFFIcGx4cVZua01a?=
 =?utf-8?B?STNuMUFKMUFtVlhHYUN0MGxQd1J1VXFjcXJWMzZGajR5SmFBTmt4Y0w5ZWtV?=
 =?utf-8?B?UnF0Y010cnRnWFlqWXdnTk4waDVoZWxEdVJMK2VKL2V1NG1ISjV2ZTJic2Fo?=
 =?utf-8?B?SnhRL05FY2tBSUxycUk2U04rakdVN2MxY2VRVzEydWdxNTVhTmpWNlhBNWg3?=
 =?utf-8?B?Q1RVZW5VRmxPY2kyRUQ2dTV6ZEc3V1FzM0QrQ09KN3M1ejZXbW42VHY1Rk05?=
 =?utf-8?B?VUtTV25XREZwYTY1R2psQ2w0SWNnQ2J4MkgwVUlySUZKTDFhb2RtV1o5YlZK?=
 =?utf-8?B?ZnZWUEdyY1hDSWNmZnR6ZWtTYVY0TjEra1Vpakh5VE96dmZEUzNCa0Z6Rldq?=
 =?utf-8?B?bUFuNFo3VTlIWEdKUGRJK0pwdE9mRlB5NUliOHdaWGEyRTRFQnpiTUZaaEs5?=
 =?utf-8?B?ZkJqODUwc3A2Q3BpcmtoSkVkNUxPelFSZEUzeTdpUFRrVS84OGxnUjlpUncw?=
 =?utf-8?B?eE10dUN0b0x6a2lHMlJyODZlR09rVCtJMzNuQ1JLK2dLaW14NzV2Wk4yL2Rn?=
 =?utf-8?B?VGJQVjEwWDIwT3U4RGl0MDVKRENUTmlQaFEydkxlQzJvUkFRMzZJK051K3hC?=
 =?utf-8?B?aHMza3k1N28wQjRZbStKWU5GbHFWeEVRK1o2Q1k2aXBzREU4MG1oM0l1VnVB?=
 =?utf-8?B?V0lOZVQxSlNpT0ZkR21pL1kvQXFRVXc5TjBDNEpuWDkyY2lCU0pIT25NZjlV?=
 =?utf-8?B?YW80L204VTdReUhNc0YyWDFJTWxNY2p2WkR0WFJaU0tlaDE5ZkFtYUJ4YjVX?=
 =?utf-8?B?Vi9iMm1GeUI1dXl3Q2Zka1gwd0hOWG5PTVJ3dWxLNWNJaG12anZlZVRyc3RD?=
 =?utf-8?B?Y1JyT05hUnJjYTJVb0o1R1RadHFVY0RuM0VZS1pQdmsvMTNCSmR1Z2ZySHBQ?=
 =?utf-8?B?UHhSUVlvR0tJVVA5dEpLZEcwenRQV1M0WjQwRy9XbmtQbmIrM1p6SUR5cFhj?=
 =?utf-8?B?ZFQ1djlYOTB3UzdqTVBqRm5MNHBtbUoyREJFZ09EQlpzd1NIdzF1eU5JSklM?=
 =?utf-8?B?NThIY1F1eEFTUWVETWRGQXlhTmYvQVl0aUN0TXFmZFBWYmVLcnVMOXZFZ1hL?=
 =?utf-8?B?d2c5Q2F6QWJtVFFaWklLYnFSTFZ3aXQxUStXcWN5eXZXRkJZYStLSUZFOFFP?=
 =?utf-8?B?d1E2empzdVUraDVnRys4NytDdGR1VnBEQlU5U1NGZDJDRWlvZW8yVEpJTFps?=
 =?utf-8?Q?pkmSNh4wNFrKbSSdr/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d4f63c-add4-4903-07ee-08df155a839d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:57:41.2500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLLCLXmSqA7WKzJ6h1h196E9RalCeCk/Y4pPFyROqYigSH/dpCA8qnzXNHa9MDPV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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



On 9/17/26 21:58, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> For now use the same logic as the existing one, but it's not 100%
> correct since:
> 1) most operations don't need the GPUs
> 2) some operations that need it are actually deferred
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 4e4814caf61a..6edd03647c2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -978,6 +978,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	if (r)
>  		goto error;
>  
> +	/* FIXME: only PRT operations use the GPU to update mapping, but
> +	 * some operations are deferred to fences callbacks so it's not
> +	 * trivial to fix.
> +	 */

That comment is not correct, just drop it.

> +	r = pm_runtime_resume_and_get(adev->dev);
> +	if (r < 0)
> +		return r;
> +
>  	switch (args->operation) {
>  	case AMDGPU_VA_OP_MAP:
>  		r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
> @@ -1031,6 +1039,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  
>  	}
>  
> +	pm_runtime_put_autosuspend(adev->dev);

That error handling is not correct, after the switch there are a bunch of returns and gotos for cleanup.

I strongly suggest to use the guard approach here as well.

Regards,
Christian.

> +
>  error:
>  	dma_fence_chain_free(timeline_chain);
>  	if (timeline_syncobj)

