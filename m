Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0557BED7B91
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C95D10E325;
	Tue, 14 Apr 2026 09:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wRdSouLH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC9E10E166
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx9uEnrJlmSlCkI7Tn9ZoO3okLD9ioTho+fluYQShHD2WiC6kf3BkwupmYHOjDS173QcpGDaAaLxguSdbIWWk+YffEZe2eoCRgrgJYpWG6pVY9+rw0jhtBidnqiAZ1yuWRuz6pw0aUKMJeW+rT1yIMbg0ZHsvBtORQTW0cKcLj05WKXBq5uVCA4M1EcXFF9k4W8+4rkOs52EGpQ6jWgQ/TeqCSanp/3mu34/HNmXz4cO4cSVJLUM94kbXYUu4DhbfYXJt85qVnitMldgQ4NtuAUwyoycX+L7jOdY2HdrKG6AqIkFc7S5peyuMIe/4dYT+DHOA0xmBKdaNHYH74KxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ddDNLtS8Nis1Uuw2CiEVf+Ubg4jjV1k2rawWyQflR4=;
 b=V4UZDlUgeLQRZrKLGxMYg2ivHdyB/HMB/9YBLA3/MjrpJpZS2gy/hhdjFOLOAmov3h3hFcQqqeTOVA/rPw5+RexA133ZIHdG1LpnNgFpLDuIz6SUShrBPNezEdI6aYfzw8dtxJznmCruuJJ7mh6TLn/QvpGcSwAHMRqoP1/eU0gemyPnHVF3BSFIortWtk0NlRGw85zsPpVNK+Fp0rYmqQN07s9TtuPHnTOCvqpLqNhGY0PYvBbcIHpeteoI87hzDml88hQLKMKtsCNkeha3x3EbqFSkpaQowX3bSrcv7WoZe7OL0X5xOX1MDCQQo6fKkF771buULqB56am0oigqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ddDNLtS8Nis1Uuw2CiEVf+Ubg4jjV1k2rawWyQflR4=;
 b=wRdSouLHp8+eQYozoVipQvVy75lpzhC5mDlUSUQ4Nmj5+nZ2stxwd9lBPDm6gEMN78wcXKF8cS+bS7cWQMVkjQoKTwXW6e6Zfzmjy1ynjczvzjjmTNurvX5wrLqRigyqVp9WyObwOAsy2gcj/prax9A/TGe9wFGW5KduqnaZy5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:22:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 09:22:24 +0000
Message-ID: <e7df02d7-1770-4251-9918-991ef7f69843@amd.com>
Date: Tue, 14 Apr 2026 11:22:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: drop userq fence driver refs out of fence
 process()
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260414022643.3469481-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260414022643.3469481-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 301cfea2-14ca-40b4-1313-08de9a0756bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Zx8hBR774tCBBODUNbr3TDt+Iiwke2nl8L1id1g9n9sVutQrHf72kmfaLceukBfJ9SYupaHZuTFZ4PRa9vBPmObXA/Unv1o9cvAzvphfjf0y7xdAeFcNuqKMocNwDjxzKguZ5rHaefDPn4Mwe5eXut1AS77nTX1trBzrySTa0Kgb8ZBnTAtn6z+Yy0RYc53y9DJaKdehHmtrJ/xmsjK0u4a692eXStdwTvSYhfCsnjLWfomJPVudUwmSwaE2qJaohCDQwJFxdZTCzvVIjIXEhnV3a3HXMO+JrvaSeuW2bvrU1pCXtaF9tTSjDdITsjCWT8yuQnHQGVwcir+jTbd5vSqWLB5vJmvZG2qC7e2l820ChxjkvrS+gMSBEdaiNXnzgftOT/xGHQS+DXx5vyvF1199/I51nwu1AHx+8ppLdLoxUf2gx9/pOfpYrZMptV8irEin/zIZd1LT7eI+RM14SpElFX8nyXk4H0jU1Ww4iXFQk4zT6dG9sMQ/JCMkIPDrP0Nmu0oCvORAdslH7pKHtrTbZjmgt43t4TnQ92jpuIVmPqmYwGU1FjRexVmkpmjeGefw/aABLOrLCYXAjxCLz1mEh2ZwdA32yC0rmk9Yh0nHGPK6GgePnxsErI6CJ6gc7GHilmWaJKOCUVi0NmkP3/6YBzS6lYHSw/gR0ajJWSlmhONjL5KXKe4dFksEmUGz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJlUGtmM3hUQU1IQlRId1U1ejdVVXU4ck1jZ241UnFZemxvVEFZdDEzMzUz?=
 =?utf-8?B?V3hMc2NJVTdIdEZISlRKUEhHQmd2SHhSaFdMOVd6RXM2SFlYR0pKdlJZZE15?=
 =?utf-8?B?M2VQTTl0SGNlY0ZHQ3FDZytNcGxjRCtEYjlYTTdhcDlTN0RqSzYzRHJGZDcz?=
 =?utf-8?B?WEVHNlJRbU9uNG9xaWxPTTNkbWJFenZ1OGFucUcrNEE5UWJ5cHRTWk1nUUZP?=
 =?utf-8?B?MG5Cd1FkMDF5emYwZElZOGFKaThOai9SN0N4V0J1WDlsS0JIOGQ1TVNaTkps?=
 =?utf-8?B?ek8zQnZEVzA5R1NrN04vVUxyTWEvdnFqOVVoSWsrWU9yQ0s5bUp5QmkwNG4w?=
 =?utf-8?B?cGc1VTByeXgvTWl6aFljV0J6c1JQSHRvdTAyWnM5VS8yMStSREEzeUFDbjhm?=
 =?utf-8?B?R282QndpbEk1T1JCd3UxZTZDV1M5d0xENkNUWEhtZU1nS3d2UHJwTWM2OFR5?=
 =?utf-8?B?RHRCUm9CTmFBWVFtaTBPdENiY21QcGZCamYxdHdkeXYwUzdXemNNYnB5UTY2?=
 =?utf-8?B?c0lzYnhwUzlKQlR6S3ZoTTJpNnBaZDUxTldPUDhjSmNaWUJtVkp2YS9aR1pj?=
 =?utf-8?B?NFFSdks5b1doaTZLd2pCNU9YR0dSSzhlSzdNTGI3djJBVC80R09YVDcxQ0N0?=
 =?utf-8?B?WXpZOW9pUVhob05iQnJidFhvcGhoeis4Z1F2NzBEcXMrdjlDTC8ycC9CZTUy?=
 =?utf-8?B?V0k2dXcxd2M0aWxXWDJkMkg2TGNleWZhQ1FIVjFxbTMwWDFGMFlLMWliRkFS?=
 =?utf-8?B?YWpCYzRXTnNGOHdnb3NYaWNoQUR4RzVTdnJLaUh3T1NHYXVsd0pta0FJeVNq?=
 =?utf-8?B?UldXSFJROTF0YkpacTc4UFZtOEtIdUd6ZFZ1aXA5ZnhLcUEwZlhiRmNTRU5u?=
 =?utf-8?B?MWhrVVVlQzg0eWxmdlVMV25hZTNRMjdFTWxMbjQ3REZVc1NHOSt1aHdhbzQ5?=
 =?utf-8?B?VzZ6SG1qWmxyNWVTeEprZ1h2bGRNWERja0JKaGtTTEJJQ1o0OWlBdTZDTW1V?=
 =?utf-8?B?d3ZvTThOYU9Hb0lKakx0NHZyVXV1SW01UGNuK294R3UrK2czUUhYSnBSSmFW?=
 =?utf-8?B?bjVLMHJmYzUwMlY0TUIxdWRDU3BlR0xqSUZlazQ4WWZqNzAvNk81UTVLUzQ2?=
 =?utf-8?B?NGQvYWxJNjFaeTBHUVl3THRodzJudEN1OCtpRXpEVmEzUTMvRC9jWTdHY0w3?=
 =?utf-8?B?UE5rV3UycnA5Zk1kL3pVejlnT1hkTGJHK3pENFZtc29CeW9tOUhhSnJ3Mkhz?=
 =?utf-8?B?emxFM2V6RjNhQmF1clg3NXZQMjBvZVdRODUvTHNaS080Wklta0NPRHFWa29U?=
 =?utf-8?B?RTIyUTRXQ2pVcFprS2tFSGliUTcvNWtHU1hXQitwT3VnUUxzNDl1bEVKSTlh?=
 =?utf-8?B?M25ZdzhOQkJiUEsxSGdLSUFiL2V0MGRLbkVPYzlhSzhXcE9nci9ZbW9LU05V?=
 =?utf-8?B?dDBQa092eDF6bzFHc29Zbmh1V2lVQjNzRVk0Snh5aXovbTVxTzRhcWQ3N2d0?=
 =?utf-8?B?YlE0QXk5T25TQXBrKytZd3dQRjV5aC83Nm5CNEQ3ODlRQnFjVDFCdXY4R294?=
 =?utf-8?B?VTJsN2tjVUFaM0w1ZEVycHc0M3dHbTBVclF2Y3RDRitxR0F4QWMwc3U5cjVi?=
 =?utf-8?B?OEdVcHRwMk5TTGVVQ0FtYkwxNGZONFlJSUoyc0dMMDFkSTJYMVRhejU1enEw?=
 =?utf-8?B?K1U0VzBxdE0yZzdHUlQ4VHppVTN2WFJPSEd3MC82ZnhmU0FlSk1DY0pSa1VY?=
 =?utf-8?B?SzQ5VlBPSmFFUGFNb3puS3NoMzBmZVdET3pKbzhOSU9GaVp4S1ZrNUdBb0dB?=
 =?utf-8?B?Zy9peEVNU0Q4TEZ5TUc1elRkVEhvL3BSZkd5bWdjSTRnVzVUMy9YR2p4Vm1F?=
 =?utf-8?B?ZnhRK1lVSFI3Nkxrcjlrc05xeFNIT1BNbjhtMXAweXZpN0owWmY5MFdheWQx?=
 =?utf-8?B?UXBOTGdFQzZhRnlpUFpXQ3Mxd1EzeUE3MWtLV0xrWC95SWVEWjJQQjZpYjQ2?=
 =?utf-8?B?WDNqclIwQ3lGL2VkK3VMY3NMZ2RuYmdWM2dxWk5EWm0xOVdDVkU0NEdXUHQr?=
 =?utf-8?B?RE9BNGtvcUlVMEZYTjFrV2w4dmZxa1NJbXYzeDNLbjBkbi9Rb0pPMzRRYk9X?=
 =?utf-8?B?cCtrWEVrNmxUL3M3dHJZRmpxWTZZMm9sSGliMVpzTG1FVXlHWTNGT3RhRmNj?=
 =?utf-8?B?MVNJa095Z09HaTdoTkt1SGxraEpYSWVkRXV3UjFaSzRXanBHL0RlWmQ4K2d6?=
 =?utf-8?B?ZU5lcWNQVDBzSjc3ZERVWVBNcHNVWExsWklaOCtEKzNHTVZ0SWYxR3ptNzRF?=
 =?utf-8?Q?CidhoiYvt7I6Lt9aU7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301cfea2-14ca-40b4-1313-08de9a0756bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:22:24.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjYMHOE/6GFcikdK8/lNFMAHEu3V/eAIe71Ny0mfI+myriAYvt5vGMxj8jyUogdK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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



On 4/14/26 04:26, Prike Liang wrote:
> amdgpu_userq_wait_ioctl() takes extra references on waited-on fence
> drivers and stores them in waitq->fence_drv_xa. When a new userq fence is
> created, those references are transferred into userq_fence->fence_drv_array
> so they can be released when the fence completes.
> 
> However, those inherited references are currently only dropped from
> amdgpu_userq_fence_driver_process(). If a fence never reaches that path,
> such as it is already signaled when created, so we need to explicitly release
> those fences in that case.
> 
> v2: use a list(list_cut_before) for managing the signal userq driver fences.(Christian)
>     Link: https://patchwork.freedesktop.org/patch/718078/?series=164763&rev=2
> v3: Doesn't cache the userq first unsignaled fence and use the cut before list
>     head directly.(Christian)
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 49 +++++++++++++------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3be80a82788a..d4dd0cab7dce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -145,35 +145,51 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>  	amdgpu_userq_fence_driver_put(userq->fence_drv);
>  }
>  
> +static void
> +amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
> +{
> +	unsigned long i;
> +	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> +		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +	userq_fence->fence_drv_array_count = 0;
> +}
> +
>  void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>  {
>  	struct amdgpu_userq_fence *userq_fence, *tmp;
>  	struct dma_fence *fence;
>  	unsigned long flags;
>  	u64 rptr;
> -	int i;
> +	LIST_HEAD(to_be_signaled);

Move that a bit more up, e.g. so that we have reverse xmas tree order.

>  
>  	if (!fence_drv)
>  		return;
>  
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>  	rptr = amdgpu_userq_fence_read(fence_drv);
> +	userq_fence = NULL;
> +	fence = NULL;

That looks superflous, the list_for_each handling should initialize those.

With those nit picks fixed Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

>  
> -	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
> -		fence = &userq_fence->base;
> -
> -		if (rptr < fence->seqno)
> +	list_for_each_entry(userq_fence, &fence_drv->fences, link) {
> +		if (rptr < userq_fence->base.seqno)
>  			break;
> +	}
>  
> -		dma_fence_signal(fence);
> -
> -		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> -			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +	list_cut_before(&to_be_signaled, &fence_drv->fences,
> +				&userq_fence->link);
> +	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
> -		list_del(&userq_fence->link);
> +	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
> +		fence = &userq_fence->base;
> +		list_del_init(&userq_fence->link);
> +		dma_fence_signal(fence);
> +		/* Drop fence_drv_array outside fence_list_lock
> +		 * to avoid the recursion lock.
> +		 */
> +		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
>  		dma_fence_put(fence);
>  	}
> -	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
> +
>  }
>  
>  void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> @@ -228,6 +244,7 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  	struct amdgpu_userq_fence_driver *fence_drv;
>  	struct dma_fence *fence;
>  	unsigned long flags;
> +	bool signaled = false;
>  
>  	fence_drv = userq->fence_drv;
>  	if (!fence_drv)
> @@ -275,13 +292,17 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  
>  	/* Check if hardware has already processed the job */
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -	if (!dma_fence_is_signaled(fence))
> +	if (!dma_fence_is_signaled(fence)) {
>  		list_add_tail(&userq_fence->link, &fence_drv->fences);
> -	else
> +	} else {
> +		signaled = true;
>  		dma_fence_put(fence);
> -
> +	}
>  	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  
> +	if (signaled)
> +		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
> +
>  	*f = fence;
>  
>  	return 0;

