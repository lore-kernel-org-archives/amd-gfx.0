Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD158C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 10:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508B810E00A;
	Tue, 14 Jul 2026 10:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxTO0uhr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D6C10E00A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 10:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpP7oz+lhdHbJHaqhwRF6BBriDfiii26dMOycE5LTRQVC/7HJztozasnRMdS6xqFCi1YhG10sXIF93PbTucoqNi98/1y8az+7DUoqCabjL5NUQdnOzAVt32tV/ksxqtITfdUKKr/T9nb0cnbydMU/emC0CK4OHylsiZJ4AB3z4u7uTI2f9Te5ihApHS3EgX32iHYku2Lwzx2eT3KK9I1y0h2kqVI6sOCi/IQAXCN8gsl6x2oNkvMrDWpU9luXngGzOBdGLogxFt0z3YvN2IFy5tYiflscrpW/u1WrNf8uWXRCugJvHXdbpYYXVtFLxUk795uvmGiMaTkWcsNLgDF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjA1LRSza1tNq1Tj5vpuqvrSViBzrZRVHITB6aW9ZL8=;
 b=Z7BcivLXnuuLv812+PVCv95Q32xqLEk4w06nQifCpAHKyyiff6JflEHXqQOhE0rxRPSedn2LquWHUEDegKLgzSdu5sCu4nh37eIZFdsBZYnHppZ6Y2mgjNCITxFyTJ7UmUZ7TK0C9ZqnDgFifzZYYrCT6JKkbQz1IX/LqtJHPvFKSy8HKnLF6huSMkcnfFh/lPnAK4ZITVQztVl5pdTdqR2KxuXJKXH/rgt5pCYipvfI/Jj3O2bYJwgQyEz44INEfo2QvlycRfAXtlo8qjgwYKWcXLQ57NBk9asdDyWMUm55KmV4cC5ZyQmsfAZlbMIZLOSi8QYXRpaKLcXtuHLPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjA1LRSza1tNq1Tj5vpuqvrSViBzrZRVHITB6aW9ZL8=;
 b=zxTO0uhr8LyyHwnHiNw74O56kNMNdDbuDH6aVpeEG+64bWDiFlmeHKlkZqCNCSutwSj+OtO+xLWeOupkeQJ8e0Fbb7ekQjHTkEyaGgs8iso0T5AzZGYJC1lhJ0L+l/v+Emeq+eRMzGpXxQuLYIbPdjl+nGCMxBu97SOS0L5TecQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 10:16:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 10:16:45 +0000
Message-ID: <a96455c2-1375-498f-8754-97acb24e8a7d@amd.com>
Date: Tue, 14 Jul 2026 12:16:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
 <20260714080220.3395155-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714080220.3395155-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: bb890808-40e3-4e4d-5c32-08dee19101eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lXUkNh0KK8OmpGVyW7WLGoZ6sqqGS3FjpI2KEZj0rmsvNTchMBQsIgWZdnxJE5xpHgrPGXm29PL1r7LoJreclaV151+Z3d0GbOxRJfrqt3BWjtOr1u2hktoGJ+dNzIh0zJiKctJZHVwKJWRqUqZCKTAe9hn0b3HcCzRVIQjwTrFk5rFgs04AC0W4R2cmoIodzClwnlyq0M61l6FB5fHzo9j0mbDiqM5z/w9txyNIZxgh4x178OfzcSUu+tAE8WpRT3u8coOeqtSCVygd1w2jo7939Bhl5zGf3dbyAUxhZbdqYRcafemWvm4Db49JzsTSLhDe3zAXl7GGmvYK+ZQQSFpCbsz7chEezTcsJlIcsCnGJqVOryBwmDrFDt4Vn0P3IL9Qa550K0z6X3P5+cBypZKeZU3DPpFBnN7FQ76shPjyFJuS7vlSp4zI2XDlPgfEA8f1u0qBVtoM2kY4csr9p/iXTqyDockpY2TkJGWYjl1qsL8HKTBQX7PGzNOnKQGZnLZE5vZaH15096qdT1fYverx14Oc5z3CnJwox2R2oKAd6h/jlDciwEBezqbZtfJqOLbjjznXHc8p61s4e2tndNNSbYd4IGNwMVxoQnYwZr6bUQmfdh22cClbelUpP2NWW/R4Ek+6C9LapzW/iy1ipeCfU0rysqp+ojKWO7tPNW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkhFTS9iT2RMM0hVeWIyYzc5SmtYWEQvSjdEcHRPb1RIay9qbWRFeDdNeXl0?=
 =?utf-8?B?QjFvZGxndzlsaG9MU3kzakxRU3Zocnpjc1VQM3V2ejlhZkdkeUd0MEZOaS8r?=
 =?utf-8?B?TVh5RFdBM2dNZE56cklQemk0YU1tenJ3bVkwcVhmMVhlL3VETHhkMGN3bGtP?=
 =?utf-8?B?RlVKNnhWd2tzOWkrMDlXM2VLYldJT3owNFFlMUdmNWcvTWhHc05PbWFvazM5?=
 =?utf-8?B?eFlGaFp1T2lZRWovYUZlTkJSSTZLYzl3cERwWEUwd2VFNStOQlBqZk5vdXlo?=
 =?utf-8?B?eUFCaW5kN09UeW8zZHhEcDgvdlJZais2Kyt6VURxSlQyOUFhSnN0REM5TlF2?=
 =?utf-8?B?cXZ4REtQRFVybEFFWlUrVld6QUN3Y1h3NEt1ejhRU0pyVnRPaXBoaUJpVk1N?=
 =?utf-8?B?dXhkYS9CV1lFZEd4d0lYbVQvVUMzaldRQ2MwOE03TE43TzVJTkM4TTd6alNi?=
 =?utf-8?B?MFVpaWVnWG9uZHFwempkdmEyN3F3blAxZTExR0JZK1Rhbm84Q2xrZDYwazBN?=
 =?utf-8?B?bS9NTWtsZjRGSVlwcnlFWTlwM2FueEY2RWFWMDZwVnNCN3FTYkRsVWxDTmgx?=
 =?utf-8?B?MEFKRkxyRmpyT1ZNK0RxT2JlY0IxL1JlT0xNREJSTVlUdW5xTVVuZ2xuazI5?=
 =?utf-8?B?M2gzS2JCY1hDWk02VjhlaGdiYXBDWFBUcUR1UnRIVGJMNWNURE9BY3dnMkwx?=
 =?utf-8?B?K25td1JGM1pKM2RnNjllTU1ZeWVqU1VNUTNPTGFOR1R1dVZzSzl1NmVHTFU2?=
 =?utf-8?B?NlZCODZEbU1UTmlwdm1ZaWZLR2JSWGhKNHNYUzczQ2RaWnB6UWN4SFBWWFVZ?=
 =?utf-8?B?dUZNaHpaeVdZVUZrU1h3dU55Rk5LRlFmYnVYenpuWnJnTGY1WWVJT29lK05s?=
 =?utf-8?B?c2YvRTFyYTA4ZGhnVlBneURkcUpxcktvL0Z2WmhFL3pjemVoV3pLemp2d0k5?=
 =?utf-8?B?MjE0YnpMY3lFazdNak1uNFhTR0p1RVZDczkyMzU3UWRUOGY5eGtOQlhLREUz?=
 =?utf-8?B?STAyQk9IOFo0ZmdiaklCRkJKT1ZnQ213L0lXRlpFTmh3NjR1UEhqN0ZRQ3da?=
 =?utf-8?B?Z3pRRmVZc3FxbzZCaFpZZ0NlbDY1U3NzZ2U2ZlFoOW9IOHBEblJqWkM5TVVX?=
 =?utf-8?B?ajF0QmxacWxreU9YOUtzREdHSjFZWTJBMTRaaUN5OC8yZU5HekNGdmNadFQv?=
 =?utf-8?B?bGNwSVNRWGFsc0duWlEvSUpOZEZXYkk1V0laYmhDODF4QmI5eHJtY0x4SVg0?=
 =?utf-8?B?M2xTYnFBVnJIaWJLcW4yV253SkhWNXBaQ2ExNTBNdkhZcGh1cWpIbWZxOFpZ?=
 =?utf-8?B?dlg4b1RLeE1xZWt0OGZiQ1pDSko1dU9qWjBCQkwvSW9MVGFDK3hCS3plMmpx?=
 =?utf-8?B?c3VEa0ZBYldudFpTUWx0N3R5UTJIUmJFQTF1c0s5cVh4c3NLZENWUUhzTUFL?=
 =?utf-8?B?R05sdEk3bDR3Yk5zbE5DaFN1dExGU09ZUUtEK0VGRXBVc3c2Mmg3akNwVXhr?=
 =?utf-8?B?SXJ2Uzdid3Myam1hUmFtS2d0bzVycEdQTVI2WUE3ZVBjeHBtMlVmT2xaSUMy?=
 =?utf-8?B?NWVsdWE1Y3hXMVNuRnVMRStGcTN6akRtRngyOFhsd2pmQVhGaDBNZlkvQVVB?=
 =?utf-8?B?MGs4bTlsK3ZSMWFuOVA2V3VOK0JPWks1TTB3a1UrODVMbzBlRGZkbk5hbXNL?=
 =?utf-8?B?Z05GM2s1RmY2dUVrVWZUNjlvaFBKbGpRcVBOOTAwNVNXMVlLNk9jWURqcG9W?=
 =?utf-8?B?SU00blhSS3M1eVp5Qjk0d1JiZHkzczhpdFZCdVYyNmFOTXNLNVIzZnBSMDNT?=
 =?utf-8?B?WDV3UHk4aUpSK1BjVWQyQ3p6ako0Q29JQUJUWTdPaWVrVUZUU0t5UFRHbWsw?=
 =?utf-8?B?ZnZ4WWNuZXZ1dS9sQkliTHBzS3V6SkJtOEFyeHQyeTdTUTRGRWRyVVJTNkhM?=
 =?utf-8?B?bENOcmlTTlpqaWE0SUwrc1JXWnlOYmtvUEJTeGJYVEkvOFJHQVlPN0k2OGxF?=
 =?utf-8?B?Z1Uzbm9FVVg3Y1U5VG8vQVdobWpHSjE1WUYwVTJnanBpMm5QYWtiVFRaTUxP?=
 =?utf-8?B?Sk41Y2RxSXRQTVM1SjJKdVpkRUUyZGJraklNYnhYRnBhYzk4UnNGY0Irb2pE?=
 =?utf-8?B?VGhaWkdMdzJhSW9NOVhmdWc5UWFGSEpsc0RvZ2RlWDVyd1QvMUlta2FpdEdy?=
 =?utf-8?B?Zk9sV2pnUkpEL1pkalFiUmszQUsyNWpLWmx4eWVKZTYxSlJkZ3VvSzRtcTA5?=
 =?utf-8?B?NnNtMUkwZEZaallHNVY1Q2pRYUZxZ003M3dnZUVrY3hBL2tuU01VK2I5dzdD?=
 =?utf-8?Q?lwXw61kTxBcu222+vv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb890808-40e3-4e4d-5c32-08dee19101eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:16:45.4437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c85tbXs8yKpom515LIgiILcQLWgH9CEYOCJcL8LfxhB/bvDsq8NoWtwI2VzoEXGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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



On 7/14/26 10:02, Srinivasan Shanmugam wrote:
> Signal GPU_RESET EVENTFD subscriptions after successful GPU reset
> completion.
> 
> GPU reset notifications allow userspace to observe that GPU recovery has
> completed and the device is operational again.
> 
> GPU_RESET is a device-scoped event, so no queue object is used. All
> processes that subscribed to GPU_RESET on the device are notified.
> 
> EVENTFD remains notification-only.
> 
> v2:
> - Move GPU_RESET EVENTFD signaling to the path that confirms a real
>   GPU hardware reset occurred.
> - Notify only after successful hardware reset completion.
> - Do not signal reset-skip or recovery-only paths.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 51 +++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c924a55fd16f..15aaceae13d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5390,15 +5390,43 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  	}
>  }
>  
> +/*
> + * Signal GPU_RESET EVENTFD subscriptions for all open DRM files.
> + *
> + * GPU reset is a device-wide event rather than being associated with a
> + * specific user queue. Notify every process that subscribed to the
> + * GPU_RESET event on this device.
> + */
> +static void amdgpu_device_eventfd_signal_gpu_reset(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	struct drm_file *file;
> +
> +	mutex_lock(&ddev->filelist_mutex);
> +
> +	list_for_each_entry(file, &ddev->filelist, lhead) {

Is it allowed to grab the filelist_mutex in a device reset?

@Vitaly another one we need to handle in our lockdep checks. Lowest priority, but please put that on your TODO list.

Thanks,
Christian.

> +		struct amdgpu_fpriv *fpriv = file->driver_priv;
> +
> +		if (fpriv)
> +			amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
> +					      DRM_AMDGPU_EVENT_TYPE_GPU_RESET,
> +					      NULL);
> +	}
> +
> +	mutex_unlock(&ddev->filelist_mutex);
> +}
> +
>  static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
>  			      struct list_head *device_list,
>  			      struct amdgpu_reset_context *reset_context)
>  {
>  	struct amdgpu_device *tmp_adev = NULL;
> +	bool need_full_reset, skip_hw_reset;
>  	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
>  	int r = 0;
>  
> -retry:	/* Rest of adevs pre asic reset from XGMI hive. */
> +retry:
> +	/* Rest of adevs pre asic reset from XGMI hive. */
>  	list_for_each_entry(tmp_adev, device_list, reset_list) {
>  		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
>  		/*TODO Should we stop ?*/
> @@ -5430,10 +5458,30 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
>  		}
>  		if (r)
>  			adev->asic_reset_res = r;
> +		else
> +			amdgpu_device_eventfd_signal_gpu_reset(adev);
>  	} else {
> +		/*
> +		 * Save the reset decision before amdgpu_do_asic_reset(),
> +		 * which may clear AMDGPU_NEED_FULL_RESET before returning.
> +		 */
> +		need_full_reset =
> +			test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> +		skip_hw_reset =
> +			test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
> +
>  		r = amdgpu_do_asic_reset(device_list, reset_context);
>  		if (r && r == -EAGAIN)
>  			goto retry;
> +
> +		/*
> +		 * Notify only after a real hardware reset completed.
> +		 * Do not notify recovery-only or reset-skip paths.
> +		 */
> +		if (!r && need_full_reset && !skip_hw_reset) {
> +			list_for_each_entry(tmp_adev, device_list, reset_list)
> +				amdgpu_device_eventfd_signal_gpu_reset(tmp_adev);
> +		}
>  	}
>  
>  	list_for_each_entry(tmp_adev, device_list, reset_list) {
> @@ -5530,7 +5578,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
>  	}
>  }
>  
> -
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *

