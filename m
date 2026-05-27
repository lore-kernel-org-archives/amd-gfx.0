Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFDECD5BD5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 06:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63E710E726;
	Wed, 27 May 2026 06:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHGYmtw4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7DE10E726
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 06:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JacqOmHYwXNXIJM26RrYF9MB6HAn7pCTM/PckW1i91z0YmsbimV8rVWi3Z/71am+z6byjdHDzNYlz3fhECwpJA1RVeNvtP4lXeZUffDJADK1O+1kuxujpmPHH6M/P/ylLPB1VBGyJBQRxfmxiVr/ZmRxSe+ewxn2yoxbSdZAhSChMtisdyVXohNDeqVop3/wnvmQUUnnmlMLcpHTbv2872/ZtT57P3YpXb4i3z+0YzBzHWIJ5UPZFMRZFlIyYMxwy6ZAP++GAu5XFoB+hPQJi1j/7qeH54s1m6po+sEalTLgDJfL5NWcDktBDzH6KAFhstP/tkCmjTrdPXWNTXOONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98MznpnNjPryDJUSx1tAFSXPhXyckbIQJ/5xPmyk19s=;
 b=J63vv66Wil/5418qWW6ff/D+AyThHPJDHN5bFXCgJqY7Vf8StQF89N2K+/wvWDZjKpqTtZQ6S8mJHM5Qy8zy+s4Yp9HngP7tWo2QOl7vpwT1e77Ch3jDpZcq+TD9AOgGUJt+tPJh2Z/wzid2bubLceYHxIvdb8qEfFRiniYHMlkNsMl9vsp5lHZPMTyh4XE5iBiBr0orAK4yqgA/euNVgdCtlfAyLhJ2ANpIT4anmy5Y06OC1+eFDuHWWpiRtlsiHi9s7PWYAIwDk6RgMpWiQvdIxBbty2sezREyusYOxWn+ybifh5rSbVvpE6UIp5zpOyRoMYIoSzDIYmBofwqFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98MznpnNjPryDJUSx1tAFSXPhXyckbIQJ/5xPmyk19s=;
 b=mHGYmtw4r+XFl+aiH1TRhjT3MZqgDJqyO4Tv0Ad30roFmN3ZeTCfDcQxEAJAVT8XlaaVOamdHg1UYJ1IPfA2XiGxctMolh/TD8aRxF3xD0Lt6AzpFhUqObSEfUobd9W6F2Jw3DXBJJ5j7XZc169SvGgfiZ5nSrhsf0ob7eSuY4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB999069.namprd12.prod.outlook.com (2603:10b6:408:32a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 27 May
 2026 06:36:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 06:36:00 +0000
Message-ID: <b10c9626-c76e-46fe-9dda-cdb83efbd6ed@amd.com>
Date: Wed, 27 May 2026 08:35:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: remove the vital queue unmap logging
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260525113343.358641-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260525113343.358641-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB999069:EE_
X-MS-Office365-Filtering-Correlation-Id: 39055e8f-3854-4211-f63b-08debbba378e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8wBwTT9jJ/IgBMHz9Lf1IHaf5KIbB/CsHOsNSQ9Jk8tOPjPYOjNyyL43ijIYV4gLTm7P2gnsv6rPfpu9wix0NIoYoP97CGHUArIGwyW5WI6dKbmEclJXH+Y3i7fRaRRqTb3VAKREkvY6VpzIioF+EVYP4pZMSZF0CmeM8+9MmH3Tj4duh8GEILUMU/66z1Fde96oGKZNkctA24kYxRUPiNDgyogCsbAioJll34ESfCjKxCkD5idjOB0IY6LSz3/2tWDJ3P5DXQa7ZdnIRK7V/hRh5iidrUOgklPprcOo6M11BpFJacdoI+5ABQSqkOW3yBNQlGY/Vnr3ZHmsDd7K4bmu9JSIjw5i8UOU0r1hy8ZHHK5k45zv2eOPbaGjweEAiSmR6JkMHSW8SmFRswlu6ZIl/43R2hJsyoXjwGnIqYDmDxfRbr8sXjqE2kL+/A1e/9iZkx6NDO1WsxqTLZWD5gW6F4y64UTgOaJq2k1xPrfhptSjP8P9yB+hsrjZsEi+ZwC2uwMrLk7MDkXHFTCP+hTFzVF0+XpTP3cNTs/6E+TvNSDtvJJPmk45zTOL5V3cnOEl7zXhmb3HZF2z6grIkSjBfY+EWgQxn9japNIATDMRZW02woZfgpy1Zki07qMATAlY2GeH3BP7eK510dPQ2fhyXykVsPRkYuz/uR41mF/5iLkmPWBPTWdFn6KPsRot
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0g0WTMvNHZVaVI5YWl3ZUxyZmtKU0Z1MjJSZGF3OWhYaFpqWHJzNDMzR3Vy?=
 =?utf-8?B?Rk5iVGRySjI4bjZPRlk0bXJTRU9FK0xZKysrRmo1SkNVZldLcFUzOTJ3TTJZ?=
 =?utf-8?B?SHp4MXJvN1VRUnpibU1NTDlSQ3FPaTZWSnpKSk5DQnJHMXNDb0JnOGo3SmFL?=
 =?utf-8?B?c1Z5ZHBKamo3MkdYWVhLY2dLcWxPeHBXQWNXb1A5QThzS2FsRXRJTFdPYzdH?=
 =?utf-8?B?bnpDclNWWlErRWF6ZHRSNGppTTFsWkpiL0FqZm5ZajlyaXg5dStuM2dLTi94?=
 =?utf-8?B?alVBT0NZb2E4VEd5eGZtUXo4WVdTTTQ0QTNWbGQvM2RvLzJ0cllaNkZVV09H?=
 =?utf-8?B?Q3ozVVRFS05rVTVpeVZ6SGdaL3hROGdJY05OZ3p6OTNDRytxOHBYZGxQUHIw?=
 =?utf-8?B?ZCtPclZyc1VsOWxoSGJ4SkZQWjkrTFF2Mk9TOHBXWXJ5VGowNFVsTGJ3dVRt?=
 =?utf-8?B?VndnZXdLNzdnYlJpQU8xYS8vUlZ2ano2ZDVONlFSYzZYOGhwL05vcEFGdVVq?=
 =?utf-8?B?TE8xVS9aVGp4amJDS2VTd3ZJYUlsMUVEMldhZGxRRmpQRDJ0M1BqaFpJMW9q?=
 =?utf-8?B?VFFXMmZCeG1qajFkcm5ZckJPSnVIWkkwR1lic2l3NjNLaWhCb2YwY2NRcUJB?=
 =?utf-8?B?SXlZWEdWNkFJQUQ3dWk4ekNDVHNROVVmdGtpaVkyT1lLUzk2Y2xrdjVRdkU1?=
 =?utf-8?B?NlUrZEt0VWE0SUtOd0ZlVGVtaTJvYVNKbFhNbEFrWGtwWHBDeXRyR0gxdmxr?=
 =?utf-8?B?UXZ4SnI2QTBzZEVwWDc5b2hZb0pReG16eFBOZ3RtYW5TbHNER1FkOGhUVTdw?=
 =?utf-8?B?a1NHRkh3S3VGK1diRzZDQVk4NmhlMGNoVW5rL3FDNEp6OGRVd2JONTVHOGlh?=
 =?utf-8?B?V2hkYjZZVkl6RU95dW1yRVlPVS94UmtqcWptRlFCU1Zha0Jkd2M4Wmowdysv?=
 =?utf-8?B?anJoWlUyZ1p4RUVBakIzRHhhSHdQeFhLYit3eFV1cWJucTMxbjdoTzZLMUo5?=
 =?utf-8?B?dHUreDdVbDVTeUpNSndZUktCUzdTTVltejN0b21LbHNGRUF4VGppUkxQS1lk?=
 =?utf-8?B?cDRHMWtjS2hpWUZtRk44T0FVT3RqT3FvUWpKVURVSmN0RER4RWh4TDFOOHk2?=
 =?utf-8?B?WnR5cVFkTndvRDE1d3dvcWZoeW95dFVweWRWakcvWU1HWVV6a2phcDRFYnpj?=
 =?utf-8?B?cTE0UXRpM0Y5dTN3SGdTTzF4TU55blJMaHQyb1VDUnVKUXJCRTdYVEh2b29v?=
 =?utf-8?B?U2dDc1R0bmtvMThDclpFTEhhbUFVcUl3cVh4cDRTRW1WQXk4WjFQYzNFMGht?=
 =?utf-8?B?QXFKMzdJdHhqbTF2QU9LQWo4UDZtUHBWKzVtVDl0bzQ1Ly80TUxTQnJWTTlr?=
 =?utf-8?B?ZjNBRE9BZktmVktIMnRTRmRORzNxUTFNVkI1ODU4dmsyL0dZNlR0REZtWU1T?=
 =?utf-8?B?bExKSjRpZ2YxZDdvbEtHREc1RzhlTS9YbTdrUEtaMHhrU2wrT3gyZ2l5cFdl?=
 =?utf-8?B?RnJac00vK3dDdEhFMWFtVkNjeHB4U0JqQTNCY29QdDBUUkxrTzZXemx6TXVp?=
 =?utf-8?B?NFpyazBjZmtOays4YU0vL1NSa0E3b1VCUzdsNnFZV2o4cmxqdkJ1b3h4QzNr?=
 =?utf-8?B?eFhwc0k2cXptNmFmN2ZFWXBReWVDYmtaNGhkcmZPWWpmTU1vYnZYbWNTOVYx?=
 =?utf-8?B?Ly9Hd3p5NFBkR0tjV3M3RUhIVDRVRWszallRd1kyWG4zbFppYVFhdCthMjJX?=
 =?utf-8?B?ZW5zeHMveDgyNC9nVytYL21GQThtM0RCeUlXaFYxR0tQZXBqS2J4U05DV1ls?=
 =?utf-8?B?QkF1b1hJTGFFeWhDbnljekErQjdmZDNPMEV0aVlzWTlzKzVDQThPcWZXZzBU?=
 =?utf-8?B?dWJvSHUrUWg1Ull2eWRKUXJCNjZTc3ArbUFTZjBQRHgvRmVIckllaTlsVkhJ?=
 =?utf-8?B?L2VsUmlBbHJSSGg2NGh3YjFSYlcwSk53K01Ub253YWxQVjVEbkc4ZHUxVVho?=
 =?utf-8?B?UkptWFlIUUppMkZsakxrOEd2R2tYamsrTTdkZUZvZDBvcDJGcDQwbmh1NUxR?=
 =?utf-8?B?QXVWbWU3VE9Kcm54ekZoWHNqSGJYT25sRkF5M3Nxa2dWQW9tMGZVNnZoMkx3?=
 =?utf-8?B?eTBFVmV3TXU2LzZmOHJWeFo1QVZwaDdPVEhEbTJlbkxUSXdCbjJDWTVhQ1dr?=
 =?utf-8?B?WnFiMGZLMEl1a0tXaGlOR1pDSGJkMkRia2ZsQVhFOWZDeTQvQkpTMm9tMFpJ?=
 =?utf-8?B?cmloRUtnQVBsL05WcUIrUHZzZjg3d1h6SStsd0FoNEV0Vmx1NzhiaWMrV2h4?=
 =?utf-8?Q?JMm/DM03iCYQLmVZue?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39055e8f-3854-4211-f63b-08debbba378e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:36:00.6413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXwMTaKwLvviP6WgsVc/+yoDOKKyq7yeLBoghYAQsEVVcWZPVMoXJTYjCDPfaQkT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999069
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

On 5/25/26 13:33, Sunil Khatri wrote:
> Mesa userqueue free do no wait for the free to complete and go ahead
> in unmapping the vital bos while kernel is still in queue free and
> corresponding cleanup.
> 
> So ideally we dont need the logging for that and hence remove the warn
> message as this is expected behaviour and functionally  we are making
> sure to wait for the required fences before unmap.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index f0c7b686f68d..ebfef6470f90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1352,7 +1352,6 @@ void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  	if (!ip_mask)
>  		return;
>  
> -	dev_warn_once(adev->dev, "now unmapping a vital queue va:%llx\n", saddr);
>  	/**
>  	 * The userq VA mapping reservation should include the eviction fence,
>  	 * if the eviction fence can't signal successfully during unmapping,

