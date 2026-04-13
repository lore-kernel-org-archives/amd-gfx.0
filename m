Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14009EBFD01
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 06:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B7110E31D;
	Mon, 13 Apr 2026 06:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3/S3z20";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78AB10E31D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 06:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U62zWlM3aLTSegMbQeVgL29spx+prN+JTxvSwJROffm7/+ySYW1B30+jcJILEYp/V3OpT5Og6AbtNhOHeZp9uhaA9rs56DB862kiV25DeQFbf4xwy2LelkyDTDWG5fwdD3tTAAg7bgjlCIu+fDMr4mi+JfxHM9nPZEmXg/WPVyf6ue9DaudAa0AA9T6784T1VLUUC8IwKFAGd/uL6JPtrGtEaJ2aw7FEvjCpDreFJUDDQrReNJG4a47Os3HXDfuOM/eXrAiZaYNuUAPxeqKflzNHLex8d1BKLux62dR9AVyaTNyivEdxROTjP8OtMBD0LQuJFcO2fB5VKXp/sHog7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+367ez1l5IP+BOJOrPKlACDj2p13XML0xnjyR5rNtM4=;
 b=ZkdgPA8UbatvUtgpA+laH22qWSc82Su+8GoK+RMgLTsp/8m1v3YpoU5BokI8ocRtqfl5ALxR3jJLexr9/3FOYi1d9AkcUvucf1vwNo4hAKBtABqUn6/j+8KgXF6fFAkhmOKuaJzHnJslp7VurtqlDHCJTiXNqOSdJxSUnO3WFXvy+3y4dpzWHLIHuam9Olqoj3B6dAg7cngaC+SfpuEqBCdwhTuJTctpikNvJiP90y+hiy4epr1eiPggj4G4oA5Sue4G5f00IkweLCsChc3zjufsFR7jzTFTwGWKei0R56ZhF4i6Ygj53rIeJQzf0og8DShjGN+bcuveHnVHSYXH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+367ez1l5IP+BOJOrPKlACDj2p13XML0xnjyR5rNtM4=;
 b=i3/S3z20RFYhqU5XE4V7FzuWBlAqIv+bcDay1LlQDA5BzfM6yP8JPZuQA9fN0BlxYH35Q5mG9XrD9T0VxBFEVu+ssR4TrSI92g+DpRYc2kQSsNno6X1vHijGWT/O9DwcECamE4fbde7Iz/6fVfTYsg3b+l/TYM/YaeJsZ7UG1ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 06:22:33 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::2c4e:287c:8da1:4be5%7]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 06:22:32 +0000
Message-ID: <39bb946a-a327-4e75-8900-883a4e37a9ae@amd.com>
Date: Mon, 13 Apr 2026 11:52:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: use pm_runtime_resume_and_get and fix
 err handling
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260411081345.3555853-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260411081345.3555853-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e43869d-c32a-481c-1a68-08de99250be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ZFBlLXgx1p/w/ps06Px8LhlhR0PIUzXxEAyY9EH4qGTR+4wYqWlT4G+R3z9sCxUcSJAthvPTZ9rDEMnyzFbIypuOEuyHxd0uGyypLUD7SvYcH4jJ21y8+9L9+VB7SOycB1/o/odXX7yf1tEoyN1umPLvnkWgw2A4AQhOsJwlacHxZtOz00JOX/JCztBPjasS8cAfsgIB36rqdHCgtNtTc7cTFO97Oz2ppb7yyyqfGKfiLfzhfjGOPkyLIX1vLgXqE1SpHuyogHIJ+da0C31u6R2GRKGwwXy0/FIaX7SUc866rlh78Ffyu/GFGJ8IVnwH2Ks2SaI+3+xnmI9mFDTB+kDouLDoGeF6GOrPZgaU3BhqSjxwqYWMRpe/nsnyR8p5xpscV7bApwtsM8EKuWIFPDLK7A298xzSun901XwhNXW2Xw/0h2nb99eMOZDJYs0wOopyYQSNBuMqnYCXi+bGxWHFyD0Hg4aS3Q6dOOKKMOwSH1eoRCXLrV+POvUivSaldwyg84N0WltrETGrEpkv/N+Hf4/ZyljKZJTKQPhK1lgyOWJyWSHrB8xFR84uUYCpRbM/BUVa/utaAHyR+4Izo69XzpBW71tblPpk6ndOh0vGNLzhby6BURFJCCMp7WRjKIxNQCgrF19vFwpwSxiKEGBNcuJvzaYGoIeo3TA8IEe8ANY8+RaIKU1ELvN4idqMIQUEnLsRNkwE7AkqrWMHKH6vDexP04fy0rKnWN7JZHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJZZ0EwZ1dpdjZGdFBLVUMrSytPekUrdGhVZHdrSHduTk1CYmFJdjVDeXFt?=
 =?utf-8?B?TjI3YXc1MFlnRyt2UjdWQUIvTmxnaysvaVY1NG4vNXhyMXFnRUJiNVdEbWJN?=
 =?utf-8?B?K1dGYWdKcThlMmF2ZDZHR21ZdHlNaWpmNWFsaTNjN2xSeXBmSlhtSzZ0R3ln?=
 =?utf-8?B?anFBZGN5d3ZMbnZ5VDN6cTkvejZ5UTU0cVlZeGlwYXY2ZEI2ZlNLUzI4RTlm?=
 =?utf-8?B?amR4T2dZUGE4RjJTSlpPaFkvWmZoY0ozV0VWSDRUeUwvb2RLeGFHTWdzd2hF?=
 =?utf-8?B?YnBTWUpxenI2a096SnpBV1V2MnJqVWRsSGlZV1dmUEVRQW1VY0tHeW9RYkZl?=
 =?utf-8?B?dk1hR2FIdVNsSnlBdSt2UUpyNFdsQ3NHSTM2RjJtUlBzdGFJSWE1ZnRYNUxa?=
 =?utf-8?B?UDkwOHc0d2EzSmNxem1wUWVCQ3BIR1MydWlFNWpDeVJDSUcvaCtQdWYwVE1a?=
 =?utf-8?B?MGozVW9BTkwxRGsrRFNMcUNMOElTM1FBdSt0R0ZTMUJqUGR6NmZlYUtlMjQ5?=
 =?utf-8?B?by94YnBUTHlMYmxmbUdXZ1hrMzJ5QmtScm9ReUdOMkkzM01qY1N0Q0NDOVdR?=
 =?utf-8?B?ZXVvL3JTVlYvdytaVmlLbXppcTU3bk9NYzdkR0JHQzkvTU1HdS94ejlkNVFl?=
 =?utf-8?B?SnBuMWtRdUxjSXg1TkEvdmZSOXBRMXdrUld4N2tabkpLb1dsbEF4TkM3b21p?=
 =?utf-8?B?UWgzZmZBbzlYZk5OYWZmWkxIT3ZIOXdmRGRoSmJwcWVjNW16STZwVEJpMnRL?=
 =?utf-8?B?cFAxS3hRZXczTlQzM2VGSEliY0E4bmR6SjYrN2Z2OUFiN0pBYVUwUDQ3YnhE?=
 =?utf-8?B?QU1XRk9USUdhRE1hWlpxQzdQb1M1UmVjUFVhVExvMFVDM3NuSlpVS1hVeS9S?=
 =?utf-8?B?eXdHckxBUjJEb2xKTkJyVGlmTzQzd3hQR1N0Zi8xMmwxT3hYZW5NZVkxVkQ3?=
 =?utf-8?B?MFR4VmJkdnBTNnFna1R6RGJtU3FWb1dBQURGQjN4dDhLODFKTnY0eGlDK0tu?=
 =?utf-8?B?ZjRhdmNsY3hOTWtycUZZaFQ5c2pEVFppTkk1L01vTzU5Nk9UYzkwL21YZHdJ?=
 =?utf-8?B?dEVodWlwelI2Q1FnUWl3Z0hrYmVoZ2xwYkVsSTFvQXZXV1VSTE12TFYvQXZi?=
 =?utf-8?B?cjYwZitaWFlIYWxhdzJmc1hVQ0p2RlVVU21WL3hGVWNhTkU2ODlNODB2RXVr?=
 =?utf-8?B?UXNucnJHc1AvMTdvN0tCRFZlaWZwNTVkVmFTY0RRdUR6Z002c0NzdkdkSU0x?=
 =?utf-8?B?NUUwNllaYnlUUWtZMHAraGFTRGlLeWFVTlhOYUNVQU1VUEJZYnBYcmwxUWR4?=
 =?utf-8?B?VnJ0WEZacTVaUjZQSDdiQVYzWmNnVW0wSytBdXdwMmNvNkhGL0dNUnZERWpX?=
 =?utf-8?B?UXI3Z3Rjc0RsTmVpZ0MvT21xYkpNU3dvaVZlOVd0aGFueG1yUFJKZ0F4bE5z?=
 =?utf-8?B?NllQa0Izb3poZlF6YkgzcER0d0Z1Q1FiQk9zTkVDdWp6cUNjMnIxWHI2Y0V2?=
 =?utf-8?B?TGtWb1hCNURjSUhUL3F1eUJ2bVV3eHFUNWFXSHpqU1M1ZzNyR3R2V3lmZmIw?=
 =?utf-8?B?WVAzcXpISiszUk1MQXNBUTNBWnEyWnRNUWxQaHhaOGIzY1VOV0NqQWVyZmt4?=
 =?utf-8?B?NHNBN3BialJWMjl4SmExSXF4M3hvQ20zL0FHaEk3MVVEMmo0UllBb3pKRWk4?=
 =?utf-8?B?MEQyREt2RmYxdHg3M1lFZ1dRb2MwSmE3ODNYRjNWTDg3cWFGcDUzU2dIMi93?=
 =?utf-8?B?cUNxUFpBd2JPNTM2NnJLVmRWdGxMRURjRzFFK3c5TXZGRS9sMXFQQ3oyV2Rw?=
 =?utf-8?B?Slkxc1oyUVRETkJTRGFqQThLTjNsVzl0MitlMzJzQS9iTzA5Q2FSckZQMFJL?=
 =?utf-8?B?V3dkZ2VrcDZ6Q01pQytqN2xDckxNajFpcUhhU3RBTjV1T3JRcW0zc1JQVGJz?=
 =?utf-8?B?Tk4rMkY5NkpKQjF2UkdWTENRZzJWbDEwKzdqRWFseXJCQXdpTU9EL3Z6OXk4?=
 =?utf-8?B?MFdGVFFzQW4vUXNzeXJVMGFjYmZsNWljNGxIOUdXNjM3c2ZXNmhJS1NMOTBu?=
 =?utf-8?B?OStUaDBrU2gvcWREM0twWWdDSTBMZ2RjOEx6YklEckhUYkQvbDUxS3Q3ODFn?=
 =?utf-8?B?MENVb1hkRVo0ZmpMMmVKcDZwSEtNdHFOaFhkWlZ1YUJ0K2o2Zy9GV0tLQW1Q?=
 =?utf-8?B?bFgvRzZ0QXZKejR2Q2JWTmJCODlBWjF4aGlhTUVBWm8xVFAvcFdnYUl2cnFk?=
 =?utf-8?B?ZkNGNlBBcDkvS1R5TXNRNWR2eVdiWmVBSXRoU3JRNjh0akFlYTY3eGxjZXgy?=
 =?utf-8?B?Vi8yWTlabzdQUVhnV2FJbVBQYnpuWGFSNGZHRTNaQzh1YS9LM3U3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e43869d-c32a-481c-1a68-08de99250be5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:22:32.9108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/ECCGcFQbqsPZwhC/uqgD7fx7XqBOMmlozkhLr6e/LKH2TpNX6WJWZzw0mCHQdjiaidAzxtwgIzHzvUVIG0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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

Ignore. Added in the series.

On 11-04-2026 01:43 pm, Sunil Khatri wrote:
> Use pm_runtime_resume_and_get instead of pm_runtime_get_sync as it
> return error but put the reference in the function itself.
>
> In goto statements we need to drop the pm reference too.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0163fba4cf74..2981f4a3c457 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -738,10 +738,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	if (r)
>   		return r;
>   
> -	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	r = pm_runtime_resume_and_get(adev_to_drm(adev)->dev);
>   	if (r < 0) {
> -		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		drm_file_err(uq_mgr->file, "pm_runtime_resume_and_get() failed for userqueue create\n");
>   		return r;
>   	}
>   
> @@ -749,13 +748,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	if (!uq_funcs) {
>   		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
>   			     args->in.ip_type);
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto err_pm_runtime;
>   	}
>   
>   	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>   	if (!queue) {
>   		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto err_pm_runtime;
>   	}
>   
>   	INIT_LIST_HEAD(&queue->userq_va_list);
> @@ -869,6 +870,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	amdgpu_bo_unreserve(fpriv->vm.root.bo);
>   free_queue:
>   	kfree(queue);
> +err_pm_runtime:
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   	return r;
>   }
>   
