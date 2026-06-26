Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6360DCD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 08:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019BD10E340;
	Fri, 26 Jun 2026 08:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p3JxBvVR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956FB10E340
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 08:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CElL7/8YZOs23fe3YCda3+XhhQzsX9Ykw/7SATxZ3p1Lt7W0jDycXrFSGIkLyxzKfKMjfG7uGHU/vRI4/MtD5W1r9x6PDgQNWDDklOciXkECyLPUcqA2ncKpNkD/zuGG4nAWnFQhD5VmW0mY4b6W5ESIvrtlScsFi3OqwZClj0YNHz4U3ifooBwEEbZjLE+Xsvj/khKntCiOb52acKUXq4WyDaaWVVlTs+Sy7Mw+EbuZgRBbpjswyql1/8PgrKTCiJl/3RMYpvGTp3hwbRJXDpqQIO6j1sGzInIU0EpVLd1U679Jqztp+sHoZ7y7uI5JR+X0MsPmSePxMf0c3hnOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6i0NSmCViIFZRPz5cnee+BnFoSoqB5FX7GDqceDF1cY=;
 b=MgQxeNLj0/hzvA8nfZrHJ4wTFu36b4cIUO5KSG38/mqjHD3czGmnGqHTGASCvzdwZjBLDYbeA9vGSkia0+KBPi/X0Ne9D7kOpFgEG6VgGoO1CKltlOee7y62ldjHkUQV+r5NPt+9dgFJGLyHzffxdBMbK/7hg1gb7/T4O4EXm1IWQEmdYndam38V+LnlFsYwMNnzLzknkCJzRze6eAQiTKw3BQUvEsQIaTdiea/DnksjGEFHtw27eZyUYycVbdA2jW/y1VnfnLuWBBfudFR/n1TOcyO37tTFlyIPnnPg43eSEe40bMOcqx9c/L/Yd6Pu+EpV7Jb+C4Qy+oljplqRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6i0NSmCViIFZRPz5cnee+BnFoSoqB5FX7GDqceDF1cY=;
 b=p3JxBvVRSx1pPigzaCvatjY7VZSU7C+61hHYHjMDP3vxMY1mDo6W6gG+nNCl1t0D/5LeVsXTbTPMjrOnZ2pk+G+QIBXThOgp8KJ8LzqcCu05UJI9vKLak4TFv8vv3tJFdZQyXqQbAmTmCFwFkFK3//eMYRCrDNsecGQJ+M3qhWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by PHXPR12MB999231.namprd12.prod.outlook.com (2603:10b6:510:3ce::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Fri, 26 Jun
 2026 08:16:02 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0159.012; Fri, 26 Jun 2026
 08:16:02 +0000
Message-ID: <d06a5c88-63cb-491f-8090-6df38325acdb@amd.com>
Date: Fri, 26 Jun 2026 13:45:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during nps
 dynamic switch
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260626071752.192163-1-Stanley.Yang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260626071752.192163-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::6) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|PHXPR12MB999231:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e8a9ca-936d-4291-a24f-08ded35b2973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|6133799003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4OkHXh3gxm20NVgP+HckHNuvuurVQLzb9nn5F2oTR8QhjYmTG3QFOqBBTz1NyP8brlGGabWzxrPTeLeY8MNdUPM6bbmLDfYNs39F3xJ87aEg73DDNpmZzw5vZkbMQ5xOS4i5WCyir+nmTTiH6JBLMPxk2j4RytlkZqJNUnR+JWgPL2mqP5hFBatqqFRbePiVZK6oUt9IWs5ApP6yLyyrvpILjD9BZOVoqyvI48eVacmTKJYITYivkCXFTziu0A7KF4bjb+ojSgXyYF8E3pelVzY3JuCJRC8ZOYvgUqUltJ9upUIvXDYr/VS2CiXbNN4/aN3WXEvR3rCfR2rlFIDhzZr1OgOEwpjl8mlWAngc897c4/0iyXD1rqE//qKIRpl9pXRQZHn+otjdtbxg0QwZCBDDJ/XPLu+uV5dTvBktDGOTdTbKb1aPDmS1p6NCJdyRYYTC+NHrdzX5WffiH0TDl+ogoPqQxa5vbb6aSevXVbYw8ZpmN5HhRzvwyirAc1L2ZE8IB+RK+UvF2awFEIF068KgxPBHMTVbRXykn6Deud3vvV92LpgU1HRg3tWcOSx+NOii6P7nBA8pbz1MTWRZcFU5E3Wpnvae9DKZN9RcKemoPiiQiXLoSBiVA2iLOGrU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9MWUdPWG5uVWMzQVdqaGZBRVJWYWtoSWhDbUkyNnBvSjd6a3VmWFNzOEs3?=
 =?utf-8?B?RnZwUVVZeVJZbjhQMDNRODJ5T3BlYldXeEtEWm02ZVBEbVc1b1M1MjdIY0ZV?=
 =?utf-8?B?clVFZTlyWW1hVU1sbDR0TGNIM0ZxQ0JWWmtnVmU4UldraUJUdTV3YTYrZVFJ?=
 =?utf-8?B?R1N1dE9HRG5ReVFLZlU3enVaRXYveVVBQS9JeFhwKzlhTUpoMnpSVmpSTG1r?=
 =?utf-8?B?cjg2elFpWEFEUThWRkxuRTFGOUVPMCtxUSt2aFR4UHRhNmNxUS96M3ZqTk5a?=
 =?utf-8?B?L01idTA0ZmQvbUhpdjJtVFljUnJacjVBYlBmYXdJN0toS2lpZlplRTA3RlZU?=
 =?utf-8?B?Q1htUlZhTmFFVmlYZUpXWk5JVWlVUENaM1JNcFRwazdKMXJnL1dkZ1BQTkdy?=
 =?utf-8?B?dW1aZGFjYlpWWkpiOWNpR0dpTEY4Vk5iYkVLaXBCZXYwTmNGNzNjL0o2clps?=
 =?utf-8?B?NGVyZmU2SXliL1dLc1lCTk5LUHVSUUFtV1VaT1VWc2lNM2FVckZkMUdZdVh3?=
 =?utf-8?B?ZlRJVGorKzVTVVNiV25nM3VLNERwaHQ3RVl5VlZoSE1ndjI2VE9DL3dSd01X?=
 =?utf-8?B?QUFORDJJcm80b0ZCTjg4ZTRCN3o2NWprZ3NlRW9vRjVLc2NidmVrVEh0MW1w?=
 =?utf-8?B?cmJkWW1hU0kxVFBzRHEzTXJ2ZUVQdTUwbUhuMTZ3VzJXVGI0TTgzcHg0eU5a?=
 =?utf-8?B?anZiQnpseUpkaXVWd2xMbC90VmhIeGxIV0V6bGxORTY4NEwyMEF6Z0s5M0d6?=
 =?utf-8?B?Q3ZmYUt6Q0tVdWNGdFlRSlpOV2NlRndjcS9JRld6d3hzM3E2VFFtM0VtUGRF?=
 =?utf-8?B?R0NVdjRhbXFGSzdOWEFtYVgzT0lQUFZYR2RlL3FIUXV4UmhUOXdWRTZzZm5o?=
 =?utf-8?B?a0NHTzdZOHE2d0haUERzZUxjQkIxbU0zcXcwNlNtRjJPT2F3N2YyMTE0S2hB?=
 =?utf-8?B?MDJUejVnZHl2N1VHaktGY1BYeGF4bGRjTzZtMzl2Z0VObmpqcGhBL05ydDFM?=
 =?utf-8?B?U24rSWxrK0gvZzRDWWdwY1ZmZ3cxMzlPdU50OGpsUXVxcDdEVDA4RUZ6M0RV?=
 =?utf-8?B?T3VIb043dFJ6ZE1sV2tyOFRPUWpLam9XSUkydjRTWmlXK1dlM0pGYkVOSURX?=
 =?utf-8?B?VnU0Y1ZIZ0tTRnVEeUZhSG16OGFKRzR1REF4dFV5ZC9Vek1nbURvUEtuTUNE?=
 =?utf-8?B?UTg3ZWk0MWZwL01GbDNyU1ZWc3p3d2FCbjgwRVJZOStUMGdtQThmWUw4aXRI?=
 =?utf-8?B?SklIeW8xcVN6UXB6ZkZiNHFxdXFuRS9pYWRreGFiNUZPa0JjRjFLNjQyODFL?=
 =?utf-8?B?ZWFOZWdPSlFiMjF5WVlXbXZkRFFNL3pOQWJuK013NzM1eE00K3gxOVVVd2hJ?=
 =?utf-8?B?QnNxMExWbXl2azBRS3NMVlhBUWt5ZFQ3SXVSb1RDczAxOUszK2VCZW1kb1dX?=
 =?utf-8?B?UHBVWXJkTWpncHVpaVF0NnVvY0hGVTBpYVlaTk5RanlKbDRReGRGZU1jQVdR?=
 =?utf-8?B?RlBFcHFwam5FRWkyYWVjclBPYkUvbDV1U0RoYlZiZG9HK3RaYWRoeXRzWG5R?=
 =?utf-8?B?Rk9nVS8ycTArdi93RzJKd1F0NlVZN0hXeGRsZS92bjRhSDJSd1RTblZsSWcz?=
 =?utf-8?B?bjY4V08wTzI1aHhTcURjb2JWSmQ5Vk1QbXB6bnRKSXZiNHRRR2N0T2gyTko0?=
 =?utf-8?B?NktOSHRZcWtVQzhsckdYdFgxbUZjRSs1OUh3K2NsdzlzRFZyNzZqSjZKTDA3?=
 =?utf-8?B?dE9XZHdNeHpZdFBNeHVVNHdvbEpyR0VWYjc1Z0g2ZmZOYnZKVkN3dDEwZnNw?=
 =?utf-8?B?M0hMbVgvUG1CVG1KTE5uVnZCeTV0N09FMzVtUm1sQmtZSzFmLy9rcE1jdU9a?=
 =?utf-8?B?R1FWQzJ0WFl5Y2pMWGNvQ1ZXc3lXVmNheUJoT0Zrc2RTRmZPYXp1dXpqZm9w?=
 =?utf-8?B?MXNadDR2Q213cGZ1cGNXd3g1cVpQT0lFdXJ6ZmRXNWxmcEVGcUNoNlc4dmNV?=
 =?utf-8?B?SExSY000SDBReFd0Z1RTc1haTFcvYjVreVIvSFFGRnpLNGViZGNVeG5WMnl3?=
 =?utf-8?B?b29tcUVjd3dWbGhhMzB5SCtXcjlzUUxBVVpWVHJ0L0ZKUmc2WnNUSjdrY1J4?=
 =?utf-8?B?a0V5eUh2N1cwWmxrQldJMWEwcm40VzRYWHdBQVhyQ3l2L3pYMW80eGQ4Y2Zi?=
 =?utf-8?B?RTYyekhaU0x3WHlESlJQT2U5MFNvUkY5RlNrejhoYWN5T0UrRkdOUzFnaWZB?=
 =?utf-8?B?Z280M21VSWU4UUtyMlFDanVpNi9JbjBUeVRBMVFlZmlOZ0p3STNzY1o2MXZK?=
 =?utf-8?B?eGNLNG5Hcm5aZm1WenptZDlUV0lDTmlCb0c0YzV0M0lBNEJQa0VyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e8a9ca-936d-4291-a24f-08ded35b2973
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:16:02.5707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBDCSYok9oBChzCx4xqkG8PmlZF5O7HXXwB639Nn9xNh4uuPDP6F8H2LofnmL5T2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999231
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



On 26-Jun-26 12:47 PM, Stanley.Yang wrote:
> On an XGMI reset-on-init (NPS memory patition mode swith), RAS
> IP hw fini, sw fini is called but hw init is skipped due to
> RAS IP block is not included in hwinit mask, so need call
> RAS IP hw init during XGMI reset-on-init.
> 

After reset, we set it to default level.

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L5211

The default level includes all IP blocks, hence it's supposed to resume 
all blocks.

With RAS as a separate ip block, ideally it should have resumed. Could 
you check why/how RAS IP block is missed?

Thanks,
Lijo
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 14 +++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      | 10 +++++++++
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22 +++++++++++++++++++
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  1 +
>   5 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7ef7c54ab982..e11c542a01b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3857,7 +3857,14 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
>   	if (!con || amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if (amdgpu_uniras_enabled(adev))
> +	/*
> +	 * For the reset-on-init path (e.g. an NPS memory partition,
> +	 * switch) the RAS IP block hw_init has not been enabled and
> +	 * the amdgpu_uniras_enabled return false, check amdgpu ras
> +	 * context uniras_enabled flag, eepron init will be called
> +	 * during RAS IP block hw_init.
> +	 */
> +	if (amdgpu_uniras_enabled(adev) || con->uniras_enabled)
>   		return 0;
>   
>   	control = &con->eeprom_control;
> @@ -5859,3 +5866,8 @@ void amdgpu_ras_post_reset(struct amdgpu_device *adev,
>   			amdgpu_ras_mgr_post_reset(tmp_adev);
>   	}
>   }
> +
> +void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev)
> +{
> +	amdgpu_ras_mgr_resume_after_reset(adev);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index a86ab65aa2f0..ad24c7cf8936 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -1045,4 +1045,5 @@ void amdgpu_ras_pre_reset(struct amdgpu_device *adev,
>   					  struct list_head *device_list);
>   void amdgpu_ras_post_reset(struct amdgpu_device *adev,
>   					  struct list_head *device_list);
> +void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 9a4e8715742a..f175c8987aeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1669,6 +1669,16 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
>   		if (r && r != -EHWPOISON)
>   			dev_err(tmp_adev->dev,
>   				"error during bad page data initialization");
> +
> +		/*
> +		 * For the reset-on-init path (e.g. an NPS memory partition
> +		 * switch) the RAS IP block hw_init was skipped under the
> +		 * minimal init level, so uniras was never enabled. Bring it
> +		 * up now that the reset domain has been unlocked. This is a
> +		 * no-op for any other reset path where RAS is already
> +		 * initialized, and for non-uniras devices.
> +		 */
> +		amdgpu_ras_resume_after_reset(tmp_adev);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index f627a97797ed..a70e532b3d00 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -465,6 +465,28 @@ static int amdgpu_ras_mgr_hw_fini(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> +int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
> +	struct amdgpu_ip_block *ip_block;
> +
> +	if (!con || !con->uniras_enabled)
> +		return 0;
> +
> +	if (!ras_mgr || !ras_mgr->ras_core)
> +		return -EINVAL;
> +
> +	if (ras_mgr->ras_is_ready)
> +		return 0;
> +
> +	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_RAS);
> +	if (!ip_block)
> +		return -EINVAL;
> +
> +	return amdgpu_ras_mgr_hw_init(ip_block);
> +}
> +
>   struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct amdgpu_device *adev)
>   {
>   	if (!adev || !adev->psp.ras_context.ras)
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> index 4f44a917d48b..3f80b9f1f0ac 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
> @@ -82,6 +82,7 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct amdgpu_device *adev,
>   		void *output, uint32_t out_size);
>   int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
>   int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
> +int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev);
>   int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
>   		uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_count);
>   #endif

