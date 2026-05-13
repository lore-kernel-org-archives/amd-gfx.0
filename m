Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A4ACD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 13:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9CE10EE9F;
	Wed, 13 May 2026 13:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0sUmPnvX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E09A10EEB5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlI+dhHZi0J6VKnMKwjlMMzpfKkV6NKZVIYhWgl+SWnBReUP/tSaMITr+Caa5FPZ1RJdDP4+ra5mfOqhDf9i3fkT+MNY2y+g0EnhqEPM1pKzOSqRihVEKoyY+DaE1UI8TCqa7gluzum0+i1rSnKyE31MZkUQuYjY2RVeXEsfNGFLorAViPWQul3PfbupbUiW4EejRUSs9M3GAmY27QMqMgJk4XDJjpqgw3qt8B5JKPok0X0uR0Zq8YJqQgHI0VFDDCT+WubjyUUH08DPwhLzFa4xscv/DaUx8Pdvtzj1VBMYiTkD8qCVR1ca1Ei9CvZpBXHeWgFiRXvN/sPAVniIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCFcqrQI2DsAO9x5bO3LpZlyeMd8jdpquOr+ddcvyvE=;
 b=AGpnz8npK+5edeG1C1UEa2xXxff0IVHb5bP/UFRVm5qGCYzi/ksWluTtLOlYLBab4jE3Ca4h2dgrKoNlLKC74C1aJpzBEih4JxmuiUrP0dhXoKG8bL/nA/FyBZjVLvX9zOihNhaQfkxf2dNJ59YgFSf6ZqFsXrbnr8p1Le6kZ6O1W28chPNyCEE5hHOQbvbj6NrUjJaKkrT2j0HIbEDi0NmcLz5lnsmA0mtFhYvEhuJkO3eZagxuYJIkh1qoX+ZddnSyPajn81oT9EAwWoxVGOZDlJYaIGRbPnFkrSVbLt05uESH+Jrr6Ge3aDE5E8Ho6QRZgF1DKlXVedN7tDA1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCFcqrQI2DsAO9x5bO3LpZlyeMd8jdpquOr+ddcvyvE=;
 b=0sUmPnvXQ+zS2haCiXxxkRcnZezLHAbEij9aZ9O56LMNUGPhJwg+RTKPWD698JUrWAlEWrsWUvKCcR+x99SEiq9e+ypV0Pe01TUkXHhHwMcpQFkS84dp8PB9A4wdsbY9NEQwUWQUD2Ny/gKvF/s4IrsHnQu/Gcl9I+URBXUKQnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:55:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 13:55:23 +0000
Message-ID: <bdaf26f1-ba62-4dbe-88ed-6ae85c0cb43c@amd.com>
Date: Wed, 13 May 2026 15:55:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/userq: Fix reading timeline points in wait
 ioctl
To: David Rosca <david.rosca@amd.com>, amd-gfx@lists.freedesktop.org,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260513104710.9705-2-david.rosca@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260513104710.9705-2-david.rosca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9f98b9-6836-4e11-5323-08deb0f7470c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: etM37SK6f+dFirnLyUK+UuZlYi3jiuHuRjc9WlJRHXbIdQti+RviPWghC7RD11t8pNktdwdtvJuMihqYcL5iK+EqUUkx852ZbKh82x46uCrrEKNucUlO9Y61SR7tcIVtY1Zb1F+xI9OpNcspYZ+kzE3Ww0IxyYPw9jUL/iDvYrWfXuuclWumZj8aGbCOBVj/peFhwGmb+9Qy2QJLEqkQjIBn13Z7Ae5mj/QCUyh0QhSuGe+Zb2vV/8guw9rcSxaJPpkhkgVwvJ+1HtR3oxWWhIZGeD3AttyU+AapoEG+4E4runIgltTkpSmKpYP+pT1aqdmld3Grz+oxkw1vDTV5w+QNsQhgQWt0iBDxP6oUedamW8hz5uEQS5dgqDWFb2G+aFFvAVvixqUwxa3K4DFtNbf/dRizRvfRPvWKuaO+jdMS4+IucKA+8RnJ9d5LepTzn932FSeEZzw6JKUGFBUyVWahbNYBAWyHwcPlR6SEeh0NtKC/TThz2nj5PvPyW4nxADKu1vXF8bgVr/LyWTOQVftqVUd3RwUKVIi3JgLE195G8KfxT+hdnALMIPrONxmsm6mjapjlKoc2GWliB+1FuF8USovju3kKY2Zo4V1p4zpTVmaU4Ob7T/8BjEheqxjJNBAZWK2TCErm3P5aVHRcJA6hvSQdkV3/E4JfkDhU4QlTM+75saBDqcebTKeccwht
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1h5dnBGdVgvVTg0RWNETXVvR0NTQkRDWDZRN0hDaFBrcGRnZmI5OUd0dlc3?=
 =?utf-8?B?b2xZMHNLZVdFU0cyeU91MkMvRTZVQnhxVmErN1VncVhvZzVpT3hHV2NTWnNX?=
 =?utf-8?B?bVR4N1EraHFST2c0SE4zMEdBWi9DQ0dvWHpQU29DdFF5QVdTbmp1S2Y4cXpq?=
 =?utf-8?B?enhrUGFYOE0vZ25ZTXpCVCtWOHNsMFk0SEM1a0RrNkQ3U0JMeW9BZkppYmV3?=
 =?utf-8?B?QUx5K3JXMXNqclhmb0FpVEExUm5zcnNZd2RZOHdMQkJ3V1NTbHd5a3Q3a3ZR?=
 =?utf-8?B?VHdjVXlaVm0vTVBLSVNPWjhUQnBmTE1XQ3BvS0ZzZDFKT21rbjVxS25vSlNV?=
 =?utf-8?B?a1o5aHB2cW1PMFZYaWt5eXFhSzFvU0RjbFZwa0lYNlhabmtpZXNBU2VvcFMr?=
 =?utf-8?B?WHhzUnVlZjk3VkxBTm5uczBPT2ZFS2pvOTAxTnNDZzRiOWFIeEJYSTErbU9s?=
 =?utf-8?B?YlVFVmlTZE9KdHFNc0NVMlFDRE5NNnl4Y2VUaUZzUzZYQWwvd1QveXgrenVU?=
 =?utf-8?B?RjdFSHdEODNPRWNYUGdTWUJWMUlFOEVNSS9PVHMyT2ljcDU5eUNrRnAyRVU1?=
 =?utf-8?B?TFFVWUlmUERxZ3N0WkwvSVEzRml4VUtCS09tVGVqVTRWMkN2SmwycjBHN21Z?=
 =?utf-8?B?a3dMNi93cENFakk2c09LdVluWjZmL0NpWkpsSWpOeVQ0MU9nRHBQQnQ5b2Y0?=
 =?utf-8?B?dkFIRVNwVUpIR0pxUG5SRjczd2VFdSt3S3B0QTEvR1FJd2lVNkFDS2JjNTJT?=
 =?utf-8?B?UTREQ2p3UWswM0R6eFZQMkdDeHZtbm1WdHcwSXNQb3NyUFJmWWtValZnMWJE?=
 =?utf-8?B?QmFSN3c5ZFZYUEJzVm9KWnRGSStJcTlleWtoQU1DZkR5MmZwejV6KzhBYWdN?=
 =?utf-8?B?bjcrTmpsVTZZeTQ5UWIxUndicDdOb1BXRTlyMUY5V3Nyc2w4YWRvdS9aUlJK?=
 =?utf-8?B?ZXgrNmRnNkU1emVPMEpNdEVPN1FXNDJsbnRackJ3ZVpobDE3clVpV1kwdy9y?=
 =?utf-8?B?SzVSVnNtbnBMVDRoR3BrdlZZc0x0OTFoTFYwcGw4VXd0dmNkTGpWT0o5ckE4?=
 =?utf-8?B?WHZQem9xWUV3cE4rQnU3Q2wxVkllazUrQ3BWdDNRSlVjWjlNL0o4emMzS3RQ?=
 =?utf-8?B?K3Q0VzAzNUZ0QWdhdG5RWVUyMHF6UkJPZnUzRzhzcWpQejdlRzVQQmdva2F3?=
 =?utf-8?B?anBST2tJb3E0MzRpNlVFTVlYNkRkaEowZEF4eEdSNk9NcHFYd3dPclJnZzNV?=
 =?utf-8?B?K1dUMzNMQmpKeGNEMHJwckZBNVc1WHhUdTJYUWFkcVp0REJ2QVZGWW42Y2Qv?=
 =?utf-8?B?eDlMNHBEUmRMNVAwTC9UY2N2SnhJcmplMVdsWDhZOEJqNG1lS1UzU1RZTHBX?=
 =?utf-8?B?M3hHd21ZUExGZnpqcExEZHN2dnFFdnVSWjh6WjlpRnBoN3orVDJhcFYzWlJV?=
 =?utf-8?B?RytRTEo2VTlwRThMZStsVU9NY1RTSUljaG5IVVRVUEpFWkE0YStzVEhYWHd6?=
 =?utf-8?B?Z29yS3dDRjE0Z01KdDhRZEFxVkhnVHZqSG9oR2lleUJYSXZPT1FaN29sTjQz?=
 =?utf-8?B?MlNzcVJxcXpaZUV5Ykp3NWl4eVNMT1ZWd2lpNnBQT2VKSzNQNnQ2R044ZWN5?=
 =?utf-8?B?TGVpZXdTVjVJb2N1OENRZzF6Z2lsZXNPN0ZHR0JURDYzSWRQY2FQVlVOZEpI?=
 =?utf-8?B?SWt6ZTZtQjcrcmZTSGpLcWhrR0p3ektHTmIxR21qYlZadWdUdys2OFFWZzJD?=
 =?utf-8?B?M3pZQ1dGSkF5czgzdzZGWEdweTYxbnM3VDhib3V0L0tjRkFMZklndGFicXpU?=
 =?utf-8?B?SEdtOHFkMEdscnErSTgzUmZYUFVoLyt1cEtMZzVVZ0pGSi9SekVIQjdrU0Vq?=
 =?utf-8?B?RnkwNnRVMWFwMEJmWlhPREJqSHVlekNYRUxDNjVyYmVERnlRV0FDajZicUMv?=
 =?utf-8?B?NmtIOVM1QVdGK2ozbm91cUUzSHlBdVpzcG5zYjZaenluNFNJd3IzNmZQeUdr?=
 =?utf-8?B?eGR3Q2d1OXFyN0xpQjhHUU5mSithdllScWxGU1RrNkpISlNiN0J4VW95WEhM?=
 =?utf-8?B?eCtGanN6VTUzMHNrNEdZL1o0T0V2aEdDRkFVTjNpbGFZS0NSOTFpUEZLVklm?=
 =?utf-8?B?Mi9YTzcxd09HazV2bHpSc0Y5a0ZxRGJMdWxRb1p2SFg3QmdHVmptWjRQTDFU?=
 =?utf-8?B?YzlLb2ZIa0ZtSzZXN0gzSnMxRkFUM0U3TEhENG9TZnNZSnRFYk9TVjgrcTNn?=
 =?utf-8?B?L1hpVGNid1Naa1oycjh4bEM2eGZ6YWpHRVd5YzNaemkyc0N3MHJrU0dFOTJG?=
 =?utf-8?Q?O6kARIZRIUo1tNoq8c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9f98b9-6836-4e11-5323-08deb0f7470c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:55:23.1812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HK5KkyhZyu8SslhiINbo6e6/V+Knvshw467RSs3EASt4b4AnOXPWR/1Lf+19tt8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

On 5/13/26 12:47, David Rosca wrote:
> Use correct u64 type.
> 
> Signed-off-by: David Rosca <david.rosca@amd.com>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

Vitaly and Sunil do we have an IGT test case for that? If not we should probably create one.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 008330a0d852..c0d68863fa17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -593,7 +593,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  static int
>  amdgpu_userq_wait_count_fences(struct drm_file *filp,
>  			       struct drm_amdgpu_userq_wait *wait_info,
> -			       u32 *syncobj_handles, u32 *timeline_points,
> +			       u32 *syncobj_handles, u64 *timeline_points,
>  			       u32 *timeline_handles,
>  			       struct drm_gem_object **gobj_write,
>  			       struct drm_gem_object **gobj_read)
> @@ -703,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>  static int
>  amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  				    struct drm_amdgpu_userq_wait *wait_info,
> -				    u32 *syncobj_handles, u32 *timeline_points,
> +				    u32 *syncobj_handles, u64 *timeline_points,
>  				    u32 *timeline_handles,
>  				    struct drm_gem_object **gobj_write,
>  				    struct drm_gem_object **gobj_read)
> @@ -906,7 +906,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			    struct drm_file *filp)
>  {
>  	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
> -	u32 *syncobj_handles, *timeline_points, *timeline_handles;
> +	u32 *syncobj_handles, *timeline_handles;
> +	u64 *timeline_points;
>  	struct drm_amdgpu_userq_wait *wait_info = data;
>  	struct drm_gem_object **gobj_write;
>  	struct drm_gem_object **gobj_read;
> @@ -935,7 +936,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_points);
> -	timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
> +	timeline_points = memdup_array_user(ptr, num_points, sizeof(u64));
>  	if (IS_ERR(timeline_points)) {
>  		r = PTR_ERR(timeline_points);
>  		goto free_timeline_handles;

