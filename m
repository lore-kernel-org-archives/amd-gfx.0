Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A8BC5CFDB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 07:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9FE10F1D8;
	Thu, 13 Aug 2026 07:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+2kMKr7";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A219A10F1D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 07:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYV6AaT396k3+iC0ZQa2kyGtI1z9ULGX4rM3NIf7K6TYnqnmf94N6uvwMzH9QHXl6Vtmh15+aDdPF0Xdb5ryYnemPeGu4918uzqozj7uiVofr1UGyYSWSEznkxBb1PGljWcZeoLe63MIGmz62Xm3C0QpUU9OvbX0C+ljOJLwPYx75NwYyoTD7TDNLcFPydtQt41wtya0BBZ3j4r7IyOtA1R5SUkH9fZAsCGGe6Aj2eSlCWJ+D8en4qCBv47FeKScM5klhpKFyzK35M4vODmfo6bF5PkQT2e+R8uICdprhP6NfCZ2i7s+4TlkdAJJEBHLGSbipfMLu03hDEsyOTzeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bX6JkE0b+zaPNaxvnfSN8nVgi0hAy9SveC8MsVBFMo=;
 b=QN9jKVKCRQJ+GF6jQNTappoRwYdupIp/6IFC0iK26oRxqlhYmQDfCs9EKgOcWCxwO1551djy7Ve/qe8zzXu9HLqtJbkoa9qE8bhnqpXGskf2EKSzkV1tPApnOU4GHLmJwYiCuPArvDF8+0uRgUPCDLB+P1HJ6aVDPvyO3x8ENoN8QyJLQpl0l4wNfSBvS/xwSh1CORXFd2jibiydgHFLHN/PQYro3bt9j7XjcEWWZOuBhymETr4KIH3SpwCfeELaUBUpTREKvFtqBMbhYTaRDSjTd3eJ6wz3KeHD4u/LSPu8ogkgknCgjM3W/GZ9o/0AHA4PXXXVQ+3aykxvWCbxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bX6JkE0b+zaPNaxvnfSN8nVgi0hAy9SveC8MsVBFMo=;
 b=i+2kMKr7/lAqWXLyz4djzLtKJjv3lFgzh/LZTuqZY8umv8Y68W0P4uxj6RjBrW9rV2eavtIQuEdhqRD3Ypi0OZZxzQQDL0494oYIuVgnt9K4wa99NajH5zODll9sQnqz9UtYLNrwVDMqooSMkBy/bVuX/dLVgR4Cf51Dp5rGLVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 07:54:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 07:54:18 +0000
Message-ID: <f2418e1b-43fd-4d3d-9f52-10bd50dfe68d@amd.com>
Date: Thu, 13 Aug 2026 09:54:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix lock missing for userq fence error
 set
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260807061422.365929-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260807061422.365929-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:32b::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f898c2-6b05-418b-a052-08def91013f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6xWbZGnvhwySJhaiYT9U9wPIEnEN+vVHnPK2kTk7GGfV6XAsGGx4f4thyLxEc7OtNi/JljMaZEhvmXLz3gXLwWYEgI3xnsEm4tVZgmuLNgxPxY1qxqEprwKaBBMiSb3MYMRZah0RvSP063oBjbBq5Gr0Y27S1KqNyeVYqbDfMaPA/8H2R4WNuzgXWIeGWwQtav2tO2FYQSXKPRvXHZBUx2WNNQEEKyargdK6Iv+wAnqBngicxmUvcqwcCh2psN0kVLQ5KyiaPjfN4327iSxR3YL0IkxPY/XjnUNBB0uhNYPIU0MxL6MjFCoitknyfyu0g8XtoAVBdIWlotzhfwUAMFgmfDEHEUTfUYfCN2h+kSvN2UZ/+lMCbC2NJWwJ5jikQ/ienHllb8lQeop1Sppn3WHxBjzDiRPJo0Yss0LXKwtelikdMTQhLbquaZ2RozKTZrwq3xGyCaTjiuD0zfLGYQ2gU2Q+9txZ/rDgq0zgxi0wi7E1RALRVkTmn8M8Z+2qtZY5d/yYxr8aZSSP/DJe90uZ6nSYt9pMS77JF2j8c3T7OuBv9wdmXBz58TcD9iuJBwcAuA7AKk0ME8hGwGVpdcUWDkLqtMYNYTonNyGhc76zUjFt76l1K9etQprapQg6ddadbu/+ybP/AIoIPV0b2rXaGugKkBH0/z+kGo5a8Tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC93MjQ2VVRiRGNzckVxU2RvS3dxN0lJWTJZTElIb1lsTGN4MzMwbHRFRU1L?=
 =?utf-8?B?T1Y1S2NlVlVuRHlQSStuRkRpbDdObG9wRDVYbDBEZEVmYVkxei9jcUtCTGVr?=
 =?utf-8?B?ZVN4Y2JnNmRuQVgzY2JaUnlBQXFoREloZmZ2MFAxb0ZmcDdiOW84K21LNkts?=
 =?utf-8?B?UCszZW5GdDFSQnhFR2NUdXhscU92OWFVb0U3SHJ6WmRXcVk1VW5nbWVtOVpG?=
 =?utf-8?B?UEs0Rk1uNXY0NFlKV1BrdTh5SlVoOWNUSzhPMkF1aEpuRXdjTE8vMU9pRXRG?=
 =?utf-8?B?ajYvK0Uwb1R6cThrVkY4U3BMdktwcDV1V3c3bjEvMFJKbnJKZlU2bWRqTU0y?=
 =?utf-8?B?WWx2eElVYnArM3ZJMEwyQTJUQ29mSjR3WDMxaEo1Z1ZUeEJYeWh5eFdnMDN4?=
 =?utf-8?B?b3A3M3JRVFdNYldkd3l1NDZYRWNMZXRVTjJYR1pSWXIra0RBbTAvVFk3c1NH?=
 =?utf-8?B?amNucjJVckdEbE1rOW1rejNRK1diajZUN0xIWkJmem80eXoxZGFYa0tTVVZW?=
 =?utf-8?B?TkxrMjh0K0pxRU11c1oybUl5dDdkVVVNU1gvNG5IbTFjWWt6WmtjUGpoZkJ1?=
 =?utf-8?B?VU02RkVTdDBVT3huckJZR2NpUGNRMVI0NmZqdVJiRXVtL1prZE5UeXE3c1Ny?=
 =?utf-8?B?Z1BxbjRIZkxXQ3pxUnBoTEUzOGl3TGs2MXZvS2RJMVE2LzlhemtKOFBBQUhO?=
 =?utf-8?B?bTZlTGVuYWxWMURpQVBuTDNSZFBVakdQdWgzUkRPYjJrMlBXaGNKTXBPK1Ey?=
 =?utf-8?B?eVF2ODl3c1V5Vis5TlpRNkp0eE9ESEdFOHJpZThMR2xBSHdicWtlaDN6enNG?=
 =?utf-8?B?bk0rLzhuQ2NGVWJqaXFiaXFFRmlXYnNxcUNONmdLWXRKWXFCWkt4bGJiL0pE?=
 =?utf-8?B?TW5iWG8wUGNqZTRNWFJqTGpiNlVUYW5pcEFFblVpN284cTU0N0FMNWZnWHc4?=
 =?utf-8?B?SEl3cXFUVXgxZHhPbFpKMjNxVXFlbDUrbWlCOW5UelAzdE81a0t3ZkdydTY1?=
 =?utf-8?B?T0UzR1E2aURSSDZ2U2ZFN3dJRDZjR3hWNVJFMUE2VXA3U1U0TEZzMm5RWmVh?=
 =?utf-8?B?ZCtrcG1kSmpTVEJsdE5hRkNGOTN5MTc0ZkZHSG92dDFxN0hXMEdMZitVeEwx?=
 =?utf-8?B?TWdaUU56UEYzdmljWjd0MWMveUlOd1BnQXhzNTZOdEJxQmNzU0JFYlJRZnhG?=
 =?utf-8?B?RVZZbFU5TDlhVU1Nc2c2OE1QUEdjZlFqZTBmV1dJUHQ1Z3QrRVNubWtWYThY?=
 =?utf-8?B?TFF3bjE0ZTlkWmlXYlJDcFRvVGVXMm9NbjZ5U3hIbGh5dGVZMXdEQm92VUFm?=
 =?utf-8?B?MUZUR2xNdDBhcXNRRUFZSzA1VVh6V0FHK3p3bE1EVkFXN0g4alVZcEN4ZEVU?=
 =?utf-8?B?MUFFRS9CaWpxRmprc3A4WklQNnV5SVFsdUdGeFdLc2g0cCtDZ0xrTFI3MTZU?=
 =?utf-8?B?R3NsUkU4ell6RHFwb1VmMExnd2xEWVZ0bVQ4dkNReEZWYXNKWldDOTBjWFZR?=
 =?utf-8?B?Y3JKOFUxUXRNdG8wQUp3cWpSa2IrWm00RjFnVzVRQlI2RGNxNVE4ZFN0R04v?=
 =?utf-8?B?ZENHTEtoZDFBUG1kcGhNRGlxL2N1T1YwTGZpeWIxTDZ2NmF3SXhqRGxvSjVR?=
 =?utf-8?B?SkJKaFFxWlhXU09DUkYramFSZmttTEY1N0Q5c3NzRkwxL1JMdGduVXo3eHd4?=
 =?utf-8?B?bytKTmpmYnVla0lRUmNEZ0l1M2hYWnJhVkcraS8yMWJxK1UwVWNiY0FkaUls?=
 =?utf-8?B?eXNzT0ErSzhHbHRON1pkdSs0RUJnSWEwcmRCV2I1WDhMSGlyK1VrU2o5TDd5?=
 =?utf-8?B?STVWSThmU0VHM3d1TlNvSnVzS3g1clZpNlVicGJHM2k0OGVndThCTUZoQUhT?=
 =?utf-8?B?MnZzQ3BUV0Y2d1c3cnJRTk1KLzNybHliQ1ZoVlZ6akF2b1FZWkxUcSswd3pB?=
 =?utf-8?B?Z0VLU2ZYU3pjWktjTjR3WTFjZ2tKQm1tYllBM2YvY2UwRlB2bzBDYzJRUmht?=
 =?utf-8?B?c3RkeVRCaW5mdVB0UmZSZWMyUVlOa0dDV2M2RnF5WEE5dC9yWXlnS1FYZjd4?=
 =?utf-8?B?TU5nUlpSSGRJT0U2WjdZcEFWSjJuWXZ1OG9yUmlxMnVCMlBNczJRT3pOM2ty?=
 =?utf-8?B?UXNxK3ZuUVR4TTNjelkrNDk3eENQdmQvLzA0eTRZQUFucnp1NGt2MW9EcEN3?=
 =?utf-8?B?cms3SnM2ZHI5WU4xZnQxNHpNQ25LRVVETVBlOEVvNWxyVitGRUVtWDIxUlNu?=
 =?utf-8?B?SG82WUM2Q242Ulc5Q1I4VkhBbFBnd3RQdGkwa2lNNW5nakNwaGZTblVWSGdI?=
 =?utf-8?Q?kRaSvkmWa5pVDdlL4h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f898c2-6b05-418b-a052-08def91013f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:54:18.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6BkA2BidEaBDYEZKGXX3czGS+zIB6edG7Y0AUoGHN7VIRllg8ucyzrDpFWnUa6u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
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



On 8/7/26 08:14, Prike Liang wrote:
> amdgpu_userq_fence_driver() and amdgpu_userq_fence_driver_destroy()
> don't acquire the dma_fence spinlock, so locking the dma_fence lock
> before test the signaled state and set error state.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index e8de64f8357d..db5bfd79ec1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -193,12 +193,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>  	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>  		f = &fence->base;
> -
> -		if (!dma_fence_is_signaled(f)) {
> +		spin_lock(dma_fence_spinlock(f));

Please use dma_fence_lock_irqsave() here and below, using only spin_lock is completely unsafe!

Apart from that looks good to me,
Christian.

> +		if (!dma_fence_is_signaled_locked(f)) {
>  			dma_fence_set_error(f, -ECANCELED);
>  			dma_fence_signal(f);
>  		}
> -
> +		spin_unlock(dma_fence_spinlock(f));
>  		list_del(&fence->link);
>  		dma_fence_put(f);
>  	}
> @@ -428,8 +428,13 @@ amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
>  
>  	f = rcu_dereference_protected(&fence->base,
>  				      lockdep_is_held(&fence_drv->fence_list_lock));
> -	if (f && !dma_fence_is_signaled_locked(f))
> -		dma_fence_set_error(f, error);
> +	if (f) {
> +		/* nest f->lock inside fence_list_lock */
> +		spin_lock(dma_fence_spinlock(f));
> +		if (!dma_fence_is_signaled_locked(f))
> +			dma_fence_set_error(f, error);
> +		spin_unlock(dma_fence_spinlock(f));
> +	}
>  	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  }
>  

