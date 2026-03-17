Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4C8F33812
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 08:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FE310E5B5;
	Tue, 17 Mar 2026 08:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RI9T1lVB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EF1710E5A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 08:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh8uLBrDvTqCtFob7vpv9JyYpOXZ679eQCikfeyNJyNTcDssBpZu61gXjg0k6rB+CUEXBNbGyLNxZ2YoJ6okkTDPsNyI+qV8KWO6/6D6G1902yhFwpUUc8uEStA5ieWFFW/HJxhUcLm70A3wOAZLLPrLnTiqhl3jb84+ztPST4ySou4WBNfSg5k0IH3ntOf9CGsYMRYkin9mW0y4FDsgyLW1ZsggZ70RxrOpdEy6Wt7SHoaJFMpHBFaYR8kRSxUNxe+FvCdaZizIsC3kV63xAOY/0tAI3TJ45PuDoigvfAlpWAmytVR3DCGDW7B7HyEsNZROdIoqyyLL9ZTFesE/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlPi2m/Ar/Rg0y9GDJbTZSw4t0IxvHER2GArCoLKCDg=;
 b=PVXAIqPVM5wdW80pDU6UbfAroHbfA71qZuY0ieQOuvlAimuSmPBTo3T7XXiKCWyFPxY6aUppuOIxnOJw4Q1Biw3xWVMB87cMgs+J41ukb4xRVvlw07NnZRdRiYH2/D/Lu942UJVVVqjINxTDZbUra24+v7xFqU1O2eAWGpKpRCy1gYHQKb1fzprZ8wM4OmH/kk6MU1HK7ni9hZ2nLdbG3hx/srawRT8jKlGnxZzcjo0l84aAZ+JyGzL1h20IxxQe8FbVhZBeoWHg+We1+4DDCQHGe+XFL+8YhG52Vx11QtbFzNRd02vCUy2l1Bc6rVGmDUh1Xze+l7wysjL83qrQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlPi2m/Ar/Rg0y9GDJbTZSw4t0IxvHER2GArCoLKCDg=;
 b=RI9T1lVBc133PmBIbiMWq2RxFFBgwt2v6zHBJO4B6BixeKnLsdaaNqVZ3VDOYOLr5nxqf+6L0RgFcw7jN+vxF7pG4VeOgAE+VCNhJmPF+9ORG+C+toS4R5lxkNEkBTukVzsjF2cwj/IModqP8W6EBr3y7JHDk+u/6omp6V17EHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 08:29:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 08:29:52 +0000
Message-ID: <7bbea951-c1b1-4a5d-a09b-df84c531e1a5@amd.com>
Date: Tue, 17 Mar 2026 09:29:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amdgpu: replace WARN with DRM_ERROR for
 invalid sched priority
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260317074804.2363458-1-Jesse.Zhang@amd.com>
 <20260317074804.2363458-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260317074804.2363458-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: c860b1b9-5d0a-4e73-6100-08de83ff5c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: DBcBZ0OlwZIAWTk9tZV49F6941FySXc4Lohuqpy18hGCLb4iF+NtRTVuJEKTa9DNdqXOuvx9rUTXCrI5KaFquRGKWs2RRbD57VrvgDMiKTxU4+hD1G6pWAvgmv0KzGhntQLxOAn7AWoKkvbnYcKSEkLW8HW0vrr/hzNhaJ/Nf0cKGpYFovMtShpxfsGrkOO3pt6QGuusq8fXjAbiJ1wyh1UBgC+GFATK8oCjXMtHqcRH/O2Eju1onKz9m7i6viEK4vKIQODaHcWILmYdso68PR8shQTliD5aW7ZrChhQGm7LGE5q/nFwe6igAmwYBbSiwR5TuNWl+R/8UkBzu/iUpmIWHgdI+kSO6tk9rTfmzQjFB5AUs/BuaVIip0xh+4hqoI+pV7YmxRc2pe01k0jFjszGvStxHjNgZAVo3pFErbApctmGvMSW1gt2/YjtQlSfzKsgKqAoZDbhcxqXUlqaFwuAXvvtQvoL4FTvWDWiGr95hH/gStIKq+xeisxd4dk66I72GwQMkP/qaYYmY+5pq118X7dpfb3gesnUNmYhpHICR1ErKLCNwfwBdwHU/NJKi7pV5gb2rYAX8G71XpnPKJ5hmPwQsuJwF8JOCo9TObgiyjVTrFggMZUHfUfc+xjBcIVfx0Vf4/MTvMvl2db/tM9sXkKb8umTQPT6JrBhXySmpzEq68PwLpxx2OKgwr8YxuFriL1WToARnLsiETWb+za434aqoW0ogzuwn78BHg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHYrYlVQU2UzUWs3MUtlZ1g1Z0NMT0xkeVdoMElMOHBYUytyQXRtZEgxb2VP?=
 =?utf-8?B?OFpIL3dndWtnaXpaOFdCRHFGVWg1Z0tZbnBmWWFIZ3VuNDJoUTZoQ1pMT3Rz?=
 =?utf-8?B?ZllQTkluczl3eC9DZVcwOGNtcFZQelFOUnVOVTljN3YvaXltejVXQjRubXpK?=
 =?utf-8?B?enU1ck9uOExyWjRDcHFMWEZsVzk0UWFFQUFlOUU4K0s5NGVYZGRQemJ4dmZD?=
 =?utf-8?B?Y2hRQ0JoQktTSXJPNkh3bnlWWitMSGxweUVrOGJ3TjgzTjEyWVBQeENyeSt0?=
 =?utf-8?B?UlROb0NaWE0wYktWRzJ1ZW9mcUtCSDFqMGhDR2pjUjRaam16WTc2SmtPWXQv?=
 =?utf-8?B?bitoNzlNQUR4cE9ZUFZ3cTY2T1QxZ0traytvMCtKTy9pT0VxZDBhNHI1Mm00?=
 =?utf-8?B?UlZwSzNuYVFnQWUrTDNEaVVoYzN2cEhrSktkcUYycFU4KzRXbUgvRTBkbFhp?=
 =?utf-8?B?RUdJSFJCU2d1dUw4UDRMd3lRSlVIU0tTN0dWOUR6QXF2RWZNUXphZTJHOXA3?=
 =?utf-8?B?U3pSOUZjNWxRZm41bnBBSVhYbGpkdEVYeTM2S3huQTF5RDJZMVZ4dnBkMmZM?=
 =?utf-8?B?eEFFZnNuQUVRRzN2NTQ5OXUzMkw3ckdTek5qak53TU9vUXE0aWgwZUIxcU1Z?=
 =?utf-8?B?d1QrdlFuNG9vZmdpMnN2VjBka0w2K0ZTNmVuSVd5RlpTTWEzOXl3NHg0c1VB?=
 =?utf-8?B?UStweW5xTjcyQUFUZEkzSXMrTTV6WCtvYVpGTTNXSTJjTHBoQmJ5TUV1aHNh?=
 =?utf-8?B?aklrSHhuYmRCQThmWDhGdXJkbUNiOG1DdE5mdmtSUUlpWUVzNHNMVE1Yekc0?=
 =?utf-8?B?U2RKR2JheHl3VkN1VXFZL0V4QXNWU3JRenRreDJ4dFhFY01UUjhFSnpzUHdj?=
 =?utf-8?B?UHBvYVFVQ2JBb2tLZmMzM0Q3NW5PRUI0bFBxTGtWQWtlTGlSekFqYTRBT29L?=
 =?utf-8?B?TDYwV2cyQjlKVEZ3bmxnQThud0lMbXozRUhmMFZFcmdUbHhWS1ZHcGVRZWNo?=
 =?utf-8?B?emQ4VGlIQkZ6aEd3c3o2ZWZ5NG5CbjQxOHVST05yem14eVBJZ1hUTXFnb2VK?=
 =?utf-8?B?M3RVSUQrZ2hzUGJ5aENlNlhkbk1Xc1NzREh3aXozNUJOeWpraERPaTUyVGV5?=
 =?utf-8?B?MmlLZHpKVFRhaTlCY1hWUUJMYkgvK3QrTk1sYXlPUXJMR2dKeGo5RFNuWEJy?=
 =?utf-8?B?VENxZDRpcmFkdU9ZV0ordkhSdDRGbTkzVU9sbVlaeWRBZE5weE1SY2xhSk5K?=
 =?utf-8?B?NzlQWk8wV3Mwc2FURVI4UGdKc0RUSHhMeEpVNFdGTkZnV3ZnZ1NndjR1NW1z?=
 =?utf-8?B?QU53UVh6TUdzb3hKTVA1aFJIMlp0VWpoQWxyQ1VXOXY4dk1tNGFhc3JEdmhz?=
 =?utf-8?B?dm9qbFdBS1ZpeWJFbUdESnJJSHBJeFdiYXU5WkFVVTRWNE1aaDFsTnlvbkpU?=
 =?utf-8?B?Z2pxdm9XdUk5WWxZOW9PTWNFRnFnb2Q2b0UrZWZZR3ZmTStKOFFDb1NPbmpW?=
 =?utf-8?B?dkRqaWpvaWh6bmZTNHAxQlRPK3pFeTB4K2hjTUVhMEtDVVZIcWpOZUZCTzdh?=
 =?utf-8?B?aGhmWE5CZkNHZllQQURJeWFCSm42U0ptbm9YRGJLNmNCSWUwY25RNGNzb1pp?=
 =?utf-8?B?TVkzd0Q4RnNYUmczQW41MXJxSW1vUXZJeUpLLzNROTdMcmttZTIvN1FzQnRR?=
 =?utf-8?B?SDVIVy9OWFBQNkhiSkNNYUhoMWRYWmpPR2NQRmtoeTNacU9USHpFSFZYRHY3?=
 =?utf-8?B?OTloN0JMUXhVMURINzhibGxzQ3lHRUdiN0x3WDl0STh6aW82VjVYc1hPTlF2?=
 =?utf-8?B?azRsaXVaaURKdVpyL3ZZU3J1WjRwT0dKQ0UzTWhiWDNZaENRa1JybTY2Rk9Y?=
 =?utf-8?B?YWNvN3ZwdDBqdUxKNlVRU25QREd2ZC9vVURRdlpQaFdieXVxeVlEMzNmQnl3?=
 =?utf-8?B?Ukt1SEF2STVVcFRVZDE1WVZ4OHV4cGk0Tmg2QjZrVi96Q1V3eFFqaHJsMUtD?=
 =?utf-8?B?WFFNdmR5Um1pdzBITnpoWExjMWw2ZHRHclpHK3FBUjI2VnV0VXUya0ZSVzly?=
 =?utf-8?B?Z2dORjVhSGlQRU81U2FuaDdsWGJuUUhmdEViaDB2SVB3bytDaXNUMHRrQ2li?=
 =?utf-8?B?Sk9ubmlxK0w1aHNxWGwvTm9tb2hoZnpuSG0reGlqYWY5empHTmxtOCtXZStl?=
 =?utf-8?B?N2txczYzcFF0V0FZeVI0Z1loMjBnWUdvS21nZ1ZyYlJTV1RGbSs5TVk4a0ts?=
 =?utf-8?B?WUEvUnhNN3VheThJdTFUa0orWUZIRW1ZeitvdDNlOHhnUkgvK1VZUk5CUUVr?=
 =?utf-8?Q?biT6xkV9cYzShqcAoA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c860b1b9-5d0a-4e73-6100-08de83ff5c86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:29:52.6807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoTTMPYDpn6ueCpEfa4c1AnVN7/3/dyV9xNIXXPIra13ICAH+RjD646ae3bu4usC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
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

On 3/17/26 08:47, Jesse.Zhang wrote:
> amdgpu_sched_ioctl() currently uses WARN(1, ...) when userspace passes
> an out-of-range context priority value. WARN(1, ...) is unconditional
> and produces a full stack trace, which is disproportionate for a simple
> input validation failure -- the invalid value is already rejected with
> -EINVAL on the next line.
> 
> Replace WARN(1, ...) with DRM_ERROR() to log the invalid value at an
> appropriate level without generating a stack dump. The -EINVAL return
> to userspace is unchanged.
> 
> No functional change for well-formed userspace callers.
> 
> v2:
> - Reworked commit message to focus on appropriate log level for
>   parameter validation
> - Clarified that -EINVAL behavior is preserved (Vitaly)
> 
> v3: completely drop that warning.
>    Invalid parameters should never clutter the system log. (Christian)
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index 341beec59537..0eecfaa3a94c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -103,10 +103,8 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
>  		return -EINVAL;
>  	}
>  
> -	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
> -		WARN(1, "Invalid context priority %d\n", args->in.priority);
> +	if (!amdgpu_ctx_priority_is_valid(args->in.priority))
>  		return -EINVAL;
> -	}
>  
>  	switch (args->in.op) {
>  	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:

