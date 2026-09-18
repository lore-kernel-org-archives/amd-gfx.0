Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAC9C88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 07:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94F410E857;
	Fri, 18 Sep 2026 07:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALKzYwyH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A833E10E857
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 07:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osVbxeoWEyoQj3SDv9ANmNuHJ4CIiA0MX0MDQ4yzQRxsWNidr6zUXSlpMqNF3wv6Zzs3jQ7ZjUouE5whG20yoGB9U4e+reif+SSMWuqEDS7f6pY5MIsyDqJv6C/X4Gwl9zMySO3rTOkwuO2s28sXTDDEd/8pRohCHs0ru9uBN5yl7UP6hvT8lNT2Kcis+z7PQAm5zJ9V3bfrgiap4HhANBn//bN1DlqkNTvhrZU99np+8Ke1uS5WvTEubC0LUrxKcVTaYJnJAX7ljwinfBVWq42Gpr+QlAyiYg/Nt6IYTOd+CBoiNob5xL3WuzAsjS+0lmI4BDxgQ1vlCUQAKh5EkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tflWh6VBgsAjv4VuP8awdnC1u4h+WNpVbdYvoZnpzgI=;
 b=lBiOh2oBYYxJBSIS67KgIFyHrgZcYyqcQQ4VhTJOp1RkJoeYfFGCU9NnvXMS+qKGenmZ0XdDIYtPS0Cv489EnrD3e35Hv3AzLjJZa70MddU7Q087svALGo7am/muupbmQ+S1PQQ3ylIs4h8+4rcqSFK/wz4kRcmkXjcLN6GCfwyFEiHn0lSTo4anJ5Ggp2mqBKuvOUt9hDww6Qc05AXs8I2kzysy08MCTjBKIYGlxQDkPgGg0xzm2yB04wa7CbsbgctSdRm548KlIpK1f6fHPc3tLUoWYdu5R/k+8JKMpxQ6MRK/MqytdiPdbmCfl9H4+lQFC3ewlbhbBDh7YVe1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tflWh6VBgsAjv4VuP8awdnC1u4h+WNpVbdYvoZnpzgI=;
 b=ALKzYwyHiMvo7wCj33/qYtFllYKQ00Am31sZNSR32WqmiLRtg4Fnlqy/IvmOjTsnB3Tw57mW1/EXEVIJBOW82DMmiXc0huvcqHr5wTZYw2XEAW2N2RKXxdqG4e+IZU7yxk1CxDipc4nFeWlWx+MPQKx6mtvHn12tg4lIvThioPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 07:58:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:58:24 +0000
Message-ID: <03689403-93db-45fa-9b14-208bc9304845@amd.com>
Date: Fri, 18 Sep 2026 09:58:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] drm/amdgpu: use pm_runtime_resume_and_get
 amdgpu_gem_create_ioctl
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-2-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917195812.72917-2-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b52039-26a7-42f0-998c-08df155a9d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|6133799003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3Rlw4fgQaDG5ukOArzpJWyHOK7dVgcE51CxnpLaa9+pb9BML1CxNqJoEwiksFqXN7rDk/p9TvUb5HHwUPDFavdtolZo/e14PthvYr0DbepdtA8ers274OnkxeUgna4RWKwLtN7fMRY+lvvG5JU4aZ9hpP0DNJpd+EnQhdfqF0rTTG0In5Yl0hJ7z2H6q+nrxNr7pa/A2Tkiog9KW2kcg2h13p4Ib1nA0MQg9UPKQ4lDV3wbTDgfmcqMhf/STBHNz4Fs7NP5E+m8AHrOCfQxatlfDxBeiM/l6BGHOczlHgXN7NpnThypnf7pSjQwTMBEbmY7xKVKKYJ6tEAl41oDLRpAkuQF8XQQhvVX9tCyYiezw/nDnnUrdcAp0uf7a4OYi8Ji3h/ALP1GqiVzXdRbk7dcy5DQ5ZmZFUQSL5pNl/r6dqlBwVCczBsBHQHDqpqepKRHBtxrh2I3k6aGwnsMX1pbufN7yU8V03bDvqfaCixjnKYWuL8/d6qe5xXoCbqTgm2aAT2dIf016s/UeOSbZ+olQaLcxv6N2nafX78N/UwlvZYBMzZ2FcJXm/g7aPFj1yQNVmwHDtDoOrXuaUY8TS3erUNBtdfjpb00k36B0q33+VagOW5/hD+yR+Df0UvuCPtmpK4kpkpQeGNHNjvNQY0Phze+uUH0eOoV8BdzuYTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEY0a0gyaU9rbE1aTDMwRE1ZMVZlVEdOdHduM1JXUjRWWS95WHFEUHloK2lo?=
 =?utf-8?B?ek50cHFTVDU4TVhoSm1Hd3gxb1ZLY2VDSUJ3RXhEajZYaldKRXJ3SW1tNmpL?=
 =?utf-8?B?VEFWeGRqdm1hc1FpQlBFQ2s2d0dvK1JoWXJUdFI5a25yY1RVZ3pNU3B5Tnl1?=
 =?utf-8?B?RXVSVmc4N3FHSkZqUmhaK0V2dlpObDdXQ2dmVjF5ejczS0NRRHYxUE5XS3NX?=
 =?utf-8?B?blVFdU5WdUdmTDRUSGFIUk1nYWIrSGxneC9qRktlaEQ1OGdvM2FFM0JPOVp2?=
 =?utf-8?B?WW1jRHg3OStlREZDZEZjZ3FjREdSSUNOYlErb1NVQ216UmJEbmNWcElWVU92?=
 =?utf-8?B?Zm1PSERENndva1VFODZDblV4MFprbHRyRFlhS1FFcnhrUklHR1FZSFQwRWp1?=
 =?utf-8?B?RVRadTRXaE1xdFlZVGpMQ2E4TjNMZTMzWnFDbXUza2FtaUNhSzgxendtVFg5?=
 =?utf-8?B?SWVoMFV1ZWw1aWtJSFFod1BrN2xjTGcxR1d0UDE0Z3V1azNrWjd5TW9zLzdR?=
 =?utf-8?B?amtmL0FUckRqc01Kc0NaSERNNXN1d1IrYTNjOVpXcmYzSmJhV3pHT1grSnEw?=
 =?utf-8?B?K3ZENDVLbG1ZckNZYVAzK3FqamdGQmFtVlBGMnlUNnI4amlvWk44eUpWS0tj?=
 =?utf-8?B?UEg3SVhoUStvT1BKZ2N3MWxWR1Y4eTFtUi96OXRKUy8zNjluS25xT09vNHVO?=
 =?utf-8?B?cnBXdEhvR3FyTHNQamJ1YVJ6Rlo5eHZSeFM2SEg2ZnIvQ21od2FjZC9taWFi?=
 =?utf-8?B?UmNYczIxL053M3M4Zk5BZEhXVExrNnlXeFRUcUNvbmt2ZzdaRWpNd05LQkd2?=
 =?utf-8?B?MjFjdlJpZWNIWHB1WTNyRGhsRnRlMVBtSEhHSlIvYXdPaUppOXNPRUhVWUZp?=
 =?utf-8?B?VmQxbUhnRGZodXROZ1VCTi91WS9YNjVaN1lzVzAwTStXUnplbGFjMitFcWs2?=
 =?utf-8?B?d2doNWpIdkN2ajQzK2tKVXZ0MkJWbzJ5RFAvWWsxb2o0d2JKOUN1QUY0d1lp?=
 =?utf-8?B?WEVHOUlwR1Q3aGkrenJ2dmdxUldPTkpuRjRIL3RkR2J3SUtRU3VtQnVVc0gy?=
 =?utf-8?B?d0wzMGNDVTJpeGZCeDJsMm5uTGZZNk1hWm5HL3lpR2lCVjRmM0MrWjV0cXNy?=
 =?utf-8?B?bkpKYjQ1aWNhbUp1QTkxZjdJdVZ6TUlDQnd0OUhVL0NwcHdQdzdTMlMxLzB6?=
 =?utf-8?B?OGRwU1Q4VkpkSEI5SkFSbFZjNUNaVE5mZ1dTUFRqVVpXWm9tNHE2c1c4Z1Rt?=
 =?utf-8?B?dThVZkd0S1c3dElYc0FlS2FwUFA3K2pkNmJFVUVsUEhFRTF3WmJDaC9hbENC?=
 =?utf-8?B?bXNLeEJITkRyYXVRNjZTZ2s2M1VSU2pGNTRiWkMzVlJaZnhNaEt2OGZxYy9Q?=
 =?utf-8?B?R1lEV3NYc1hiWWRYOHN2aklaTk04elZXSzdYa0RnbjBlZ20wemxPSkpKNTlN?=
 =?utf-8?B?cENUR1AvVzZpbnJWeFEzcUxHQk5Oc0JYd2Q2cWZZMThEcGVzU1FLSFd5Tkc5?=
 =?utf-8?B?elM1OUdoNXE3OW1qSG84MTVxWEZZQThkZFJGTy9NT3VEYWFxWnJVQVVpVFZC?=
 =?utf-8?B?aEJ5YmVub0dGRVlybVQ2ajFmcHlQb2NLOGhmbVI5S3VyQytIaisxdFBjQTZX?=
 =?utf-8?B?MnRNaXF6WWpmenZjekI0eW9tSTg2S3l3ay9BZWxGNUlteHY5OW9FOE5vR09u?=
 =?utf-8?B?aGhrWWI2U3VwSGdhQUI5cmZLblJISjNmNVFjRnVKS3JWQUZ4NGUrOFNOTGxR?=
 =?utf-8?B?bmlmeEc1NmxuaUhneE9RMEJSdkwzdFZiT3dEV0JMbmk5T1ZwWDhnM2ZFRkg5?=
 =?utf-8?B?TWtyTG1PMk5yNG5pOHc4SWg0MnRJWFZGRzNCMm1Ua2pEb0dYS1Vza0NxQ0xr?=
 =?utf-8?B?OFFRajlsK1NLWjgxN2k3Qm5UVWloRm1aN3o2QWpISFlPaHNxYzJ2cFI4WUVN?=
 =?utf-8?B?SVJUem1xK3M5OXZsQ0lyRjF6TWpTaXo0OFIxV3Nvc0RGQ2d0eC9vZnVDSXVZ?=
 =?utf-8?B?ZS9JYjVOYXVwYTMyc0E0amdWY1BRVVdHdDF4UVJDWURPMlRLSVdpVzdId3Bn?=
 =?utf-8?B?OGdmVHRLcDBYK0ROVEJob3lrL3c3MnM4N01iSHB4cXFRNlEwd1FRbXhDVTh6?=
 =?utf-8?B?MG8rWHlVUk1VMmZMOTIrRGVLbkZhU0ZXTXFwRXJoaVAzd3ZiSER5Mkx2bmdj?=
 =?utf-8?B?dm51ajZYTS9oVGRIZitydUl5MUpDbTNTQWcvUHBDRnF1VXUwQ0I4TGRwS011?=
 =?utf-8?B?Slk0ajE2a1VqVnVtajNjTUs1M1VPblF1WVVTS1ZLOGFrWFBOUFhPREVQcEI4?=
 =?utf-8?Q?bxQ1dg5xQObipkdkTT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b52039-26a7-42f0-998c-08df155a9d69
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:58:24.3650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z60Gb/ivpKiifMKjJjG3LtZ2B3dGWQYnnacxh1cb5B3+9/Xrj8FSYZI4fugQlzZK
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
> This ioctl might trigger GPU work through ttm so make sure the GPU
> is awake.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Co-developed-by: Shahyan Soltani <shahyan.soltani@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

That looks really nice now, good work.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0d579517c03c..4e4814caf61a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -33,6 +33,7 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-fence-unwrap.h>
>  #include <linux/uaccess.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_drv.h>
> @@ -442,6 +443,12 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	uint32_t handle, initial_domain;
>  	int r;
>  
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
> +
> +	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> +	if (r)
> +		return r;
> +
>  	/* reject invalid gem flags */
>  	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
>  		return -EINVAL;

