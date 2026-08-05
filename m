Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E62BC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 07:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB5910ED5C;
	Wed,  5 Aug 2026 07:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wm7jIZf4";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1429C10ED5C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 07:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4aX+KY1lblRrpZKpxP21jIpByA5sJ//+O5LhBwqiw/4I2//WA1u4ECgs6lXhRwF5CoT9197u8ZvBM0mzS4WgkZx0XpsOi3hP7ulQUHVVoFc8T+D0oNaAVqXSFf1WGa7p2hdiZ8D+i+syX8nvPbyTofiKqYGdTVxhMfIiH69MPCIAhDefZyKOOV4YZBZa3BQL9WDcFsHsycZVGHu8ghab10FfiD6/wW54qvLTuF0p3tj8Ie8sIdNA7YgbI6V9Jc6okM7U9O3mr6W+sa/DjxkKsL73AIrEdf6rLiG9y34kYzBJC83zlq5OvCK2TyetSI4/h8pr8kHPuWQ347XIXArgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXZjDU9ygE5W7T9fY3HeYpzsVedwWzGpqkSQPkATXz8=;
 b=DfZSCEV6ZAP5X09w+NTFHL88jkRwVWE5Q3OsAeokM3WqApJ0ez+N9AORplncp0zW7bUJCPYT38C5ou+pEz2js+FuIzPnWdNDlDJOb+8O/sqijLFVbWT40yxmqxyqt6vAQCg/Srrk7x8wBHkqBsRm85lEorBjWnZEs2g1+rWHjKNEtlBAb7vjRCgk3G/f8wKYLZ1rnfHpU3fkFdMpdO0Gi+74NpLq2W0EsWPls/4A6Y+03vCcIEoq6rDA1sIUoq9FP5NE1RJoGxwglVtIg18ZivHzq8YWrltbHV7ZEYzJCyqYUSaFgcAAE+DTG+fonldhoz7CBOecH4F4S1zsSGEoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXZjDU9ygE5W7T9fY3HeYpzsVedwWzGpqkSQPkATXz8=;
 b=wm7jIZf4WsgTal+jqfAXP/Z/eTnAPPTfCTGpokXzKg//ZiOd4L7Yx4YhEZWyRpFSlMBCupoq596aZShM1PYcixE5D0b4AYt8Su4QXDFTSETYX+OaKd4ONV2rxhFflWmTwJJU5wuoJaLNQF/Q4883jyFAnTpkrEHu6lo+F7Tv3YQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 07:57:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 07:57:35 +0000
Message-ID: <858bc863-8cd5-4d4a-b81a-38998bb25e05@amd.com>
Date: Wed, 5 Aug 2026 09:57:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: rework the amdgpu_device_gpu_recover()
 lock sequence
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260727133505.190888-1-Prike.Liang@amd.com>
 <20260727133505.190888-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260727133505.190888-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6285d632-ab75-4d70-0f30-08def2c73608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: mdMaWQa8JnANE6Lclm3u5qbIP0Cwy1XWwtG84dTsyn6Bjt+WrosJmq1qWPhZo3fYVZBa2jTsnXo/8xeaIfAtSWtxZIhLt4urooblL35Fd8Xy3DJWvbVuqoSfLrV+wYGbS6iaThyPamjh/ZGPI/MbYLAGP7hSrDAcvfSwAfl6uQhrkPGmdUrPm3B/e2IKg7utbNmeSX7y9DuMcIGN0BCIBQvvhGngeX2EbZ2Qfw4RyniaPtxF9Mk8/T1m0St02TIWwwk56b53gZYzaGAgvF8bO+9n7/0G3XhcGVBbmSyFbFJoRlPWT6z9mJXym59umFGoMSvnwuZi4lCm9ERtQCAI60Rjoz1qwcBmAFbFLjH65SWwdKcMxRCwxevzMncl+2xFPSAqogTfix72uJPAeNLdfH/f7XuULcTkK/iikVu76OtZgYeBgCg3g9TmcoMdD8ZQcvgPb8bvv5Ps74oXhDOEXs+PCi8xWkuNPXXRc4HWNRW2SSO30ssAPIDp4xN+pFcfXcmUZEGyR1wkNLw6VUf6picJwPvc+WE+wgdTJNiUcyWNute3j24+I9njE5TOGIaMX7JtTvCF5k/+crt1d5L9Hk3m8kyzrLe1HewxZ2XcxL+OIpPfoVX7S5TUQNH2DZDJurV5cFPSwqGLvL8pCPoLfZoRwOIzxt8csQcWtK0cBaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW9CeVhtb21QeDBmNzh4MVZFbzQ1UGlOYjk0aGtjYkowOXVQcjFOdldRVDFt?=
 =?utf-8?B?RVNXcURsSkhUS3lveWVrd2Y0eXBpbktpQlVTblBKSTRQK0J5WTBuRzFFelVH?=
 =?utf-8?B?OTEyR1BVNFZvOVJUZG5aMWkzMCtNc0pXR3JuenpwVWxkRmk3MWQ2TDVHMkdr?=
 =?utf-8?B?ODBBT0lyd2VwQURWK0Q2ekxKRjM0TDREaGJ3Nkl0c3dDSTVZT2c5WUp4OThX?=
 =?utf-8?B?TCthNXAxRmpEWFRMczF1clBSVUhya1NtMzZRcWdOSUErcytsWGo4WitTaEx4?=
 =?utf-8?B?V1lrNVBuZytidlJOejRKbFJGS0JUZlM3RFluOU91UDh2WFZ0WlVkRFVScGts?=
 =?utf-8?B?SXc5Y2pZNHpGMnRzTFkvZUdGc3o5eE1Nc2UwL1o0amViZ3hPZVFHZ3NNR3dV?=
 =?utf-8?B?dHY5eG9RNUEwQjJIV0dONUNVY2NvVkllSm9Bb2RMYXh3SjBnVVE0eFBCY0Iv?=
 =?utf-8?B?YWlBRmZpVmhGakhyeldSODUwc2J4eEJ3d0F2WjVWWTVzcjR5d0dqWHN6cDZ0?=
 =?utf-8?B?OXhFNTdCTnFWZ20yb1hqZ2FyVUhOWHcydTZiY3pSUEFUU2VwWUxUSWsvVWxO?=
 =?utf-8?B?bkZ6VFdZLzVLcGZJdWJiSW5zUHVidDh5WElsNklpMlVYcnI1dDh2cFhLZjRp?=
 =?utf-8?B?ZW5tdTNFYmtyS1RqK1lSSnErOEx6T1pvbFhWMXlETjJKSnR5ZnR6TFM5ajFu?=
 =?utf-8?B?WjFjSDhORGZXSlRHV1hINVErc3JjT0Ivb1hyV2ZrSzFyT1k4YkNZbldEVFhx?=
 =?utf-8?B?R3hWYkQ4Q25KeE1wbXp4WVNSOXVCNVppOFJRNW1pRXNoMmFwd3h4SVVHNGlw?=
 =?utf-8?B?RVhVWFZ4UVVEOEJDQm93SjI5TDY1MENtMUZzb1hpN29vQ3ppMGdpMlpXYWhE?=
 =?utf-8?B?aGxUZHhDTGVlY0NTdytDT0VzdWJhbC9RRWRucWdLNVUvOS9sY2hzS2tlWWpU?=
 =?utf-8?B?VjFQVE0raGQxYklkdFhqUTJmV2prT1dGZlVSRHRsZUZRSzhOb2FVMHVDYUhl?=
 =?utf-8?B?SVhWSXBkVTd0dE51ZVB2c21GUmJXcmxPUlVWTUhMMkJiMXhRbHNjOGNYRGhH?=
 =?utf-8?B?ZXhrUjY5TE5HNXc2RzlqUVo2aVczeXQzUzlKbFJWbFRmcitzekpzcUdKSWQ4?=
 =?utf-8?B?a0FNcFJnajdWL3RmTm9QaHR0Qi9TMXBVZ2g3ZFhYY0lYNFFmbUl0eEV4Rytt?=
 =?utf-8?B?by81VElFdHdTZkdraVBYdWt1YmNrVVJGSG5QWTNVRTdRMGFkVVdOakc2Tjll?=
 =?utf-8?B?SmsvNWQ2Z21Vbkw0NXZYczRvTHFpT0RYZGxJWWUvaVVMbDRWV3R1VmlPWGR2?=
 =?utf-8?B?UmJnNFUwZldNRjZvUnZhN1FwRS91czdLbG1YT0taU3p3MUFnV3Y0Y2RSR1Fz?=
 =?utf-8?B?eWQydHY1a1h5QzgvSXNDWk52QXhxRGJtcnpBQkQ5M3JvUm5uY0pKV2pyRzhl?=
 =?utf-8?B?MU1NMDBjRWk4TnBETlJ4Ri8vNExKRkdjemdkeVhSRTZxV2l5V3M1NUhTTTFh?=
 =?utf-8?B?UmQwL0JxRFBaZUJMVWRVWC9oRVppbVByZHJlUkt2UStMNXlUTHFkRDJSSEtW?=
 =?utf-8?B?RVcvbExaM3IvRFcyV3ZaTk9wSEpmeTBUQkl3WTgyeURQR29Qa3dtdDRqTVZ5?=
 =?utf-8?B?aVFaTGV1K3BwRUNTQ1VsQVc3V2JXamh3dUNwK2ovRGZ1dDE5U24vb0xrbkFn?=
 =?utf-8?B?Y0VDdHhOcFVDaHk4TzlqZWQyaDJZWjYwLzBxaDVXdVRSK1lwZGZtRFdieWxr?=
 =?utf-8?B?U2FMcUZrVWxrcXpmTFlRcGdEd2x3Skl2bm1Eald3MUo1Ym05bVVGSUV5S0Zk?=
 =?utf-8?B?QjlOd2piUitlWklVeTFGd2YzNlNGUTJoaUJsL0VGSmF2aGZ4TzF3Ni9ray9o?=
 =?utf-8?B?ZDNtTks3QUthaDcxeGhjTUpjL3ZIbDFLYlkwTUV3ek1xa2tWcllVWlhJMDRk?=
 =?utf-8?B?R3FYRS8wU29xalY1cXdpQXFIWjhmYnFQWXI5VnZVSk9DUkVnWkZZekpZV1Jv?=
 =?utf-8?B?UXJ1RDl1aXRxd0ZvNlRCZUlXdWhRYnhiRUtxV0dveXJNaGdGUExmNmQ4ZXAw?=
 =?utf-8?B?NEI2OEtRZDN4OFAxN0ErSC85WU1pS2pUelJSdEpNZ0w2anFXM3lhdWVDR2x6?=
 =?utf-8?B?VHd0WWxkcG9XM29CaDRydkdSK29JeUdQNjhvaHlHME14OU5sRjZoSm9MdmhJ?=
 =?utf-8?B?RHhDblNaaGRHSGk1V3N2NVdLN1dZcDI0am45Z0FtN1ZrNVA0YldIZjFHUkZp?=
 =?utf-8?B?RWZMODVzSlZQTndRVllYNmJTaE9sU2x5bnBRNFlyQTRJZFhMMUpYKzJpMUpa?=
 =?utf-8?Q?Bz7gTvzl5zIv/IMdjl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6285d632-ab75-4d70-0f30-08def2c73608
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:57:35.3543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpSEt0C1jurBMVMPgAbBMw6GQE15+tPyY1V2BZyCh+M9B1BM6VXSOKq0fSTIftQE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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

On 7/27/26 15:35, Prike Liang wrote:
> Suspend the KMS/DRM clients before locking the reset domain.
> drm_client_dev_suspend() acquires clientlist_mutex, which must be
> taken outside reset_domain->sem. Acquiring it while holding the
> reset domain lock inverts the ordering established elsewhere
> (clientlist_mutex -> ... -> reset_domain->sem) and can deadlock.


That is a good catch, but clearly not the correct resolution.

drm_client_dev_suspend() should *never* be called from the reset path in the first place.

This is only for suspend/resume and can trivially deadlock here through quite a number of other locks.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 472e96ae884e..c670d5cfe3cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5371,8 +5371,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  		 */
>  		amdgpu_unregister_gpu_instance(tmp_adev);
>  
> -		drm_client_dev_suspend(adev_to_drm(tmp_adev));
> -
>  		/* disable ras on ALL IPs */
>  		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
>  			amdgpu_ras_suspend(tmp_adev);
> @@ -5535,6 +5533,22 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
>  }
>  
>  
> +static void amdgpu_device_recovery_suspend_clients(struct list_head *device_list)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	list_for_each_entry(tmp_adev, device_list, reset_list)
> +		drm_client_dev_suspend(adev_to_drm(tmp_adev));
> +}
> +
> +static void amdgpu_device_recovery_resume_clients(struct list_head *device_list)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	list_for_each_entry(tmp_adev, device_list, reset_list)
> +		drm_client_dev_resume(adev_to_drm(tmp_adev));
> +}
> +
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
> @@ -5613,6 +5627,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	/* Cannot be called after locking reset domain */
>  	amdgpu_ras_pre_reset(adev, &device_list);
>  
> +	amdgpu_device_recovery_suspend_clients(&device_list);
>  	/* We need to lock reset domain only once both for XGMI and single device */
>  	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
>  
> @@ -5649,6 +5664,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
>  reset_unlock:
>  	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
> +	amdgpu_device_recovery_resume_clients(&device_list);
>  	amdgpu_ras_post_reset(adev, &device_list);
>  end_reset:
>  	if (hive) {

