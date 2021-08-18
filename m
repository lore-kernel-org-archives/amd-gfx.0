Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B6C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 05:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4865A6108B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 05:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4865A6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C461C6E3B2;
	Wed, 18 Aug 2021 05:26:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD376E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 05:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEBbkcP3mTCe3I7OKQMA6MRTkgoMxaYr/HyQP6dtJHV54j0hl56oMt97N8oJThH6qoGdAB4nTkte6mwctsvYOF000kpZ758ONPypAqAc/fa2o0S04pQ3VEAH7n8Rp89TdSFnXESYqb+emudOVddHUWPvl06I3HgfpBFxoXN83so69qaCRHJFu1nOMs0QNQP2Uhd9W1x5na5+Lr2G6+erHAzZUejIg+qU/vo6RfCPgp5//lQ6nQLqq+TrnPvU5Ed9SdNAsfJB4Yp70q6qSZ1DjJkN3WBcR8bHKXAdaO3rctNP5+SaszmROeh/EbSa68x1PRxlUk6PCs2jhcEDDf8BkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBQPHTYwzsZbiuNg1eqSgmlZBLw0tyGi5iE1d9ZAPE8=;
 b=nCmEOBAjKJqyCcu6yP3AfKuZJ2G8SrEIp6CHa33T5HbcihvsKISqPs16IE81oZbGguMcO4A2R+Ul6Rn0ggAX1uUjo/p2p/1ASR+n2VZEQzUp8kwhKtuW3mSdKBoqGYt8nrAtwwyaFhOyP1JQesvAtT1jDO0tvS50u3/CQpRrSMiU1kNw69IgzuSZFNX9YE/04rhrWC5gIC5lwBKfhnaSGyAgk5SdBgRKDf9yJO2+nmA3AofedY6vAhf9BMaE3U9xv9FK4h3wg/VYDJMHFTGigyBDkD0mGi7Tz48g0C54ftHAbvmCxcL+ibq1h+z9iYBDY/ZEQJIC+1xyUjW+7ri2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBQPHTYwzsZbiuNg1eqSgmlZBLw0tyGi5iE1d9ZAPE8=;
 b=OP65GmSNizy2f09CQgnZtjyvGHf905GqH5ujju8DsSkQcazaFHFk3XbnANXlPsjMw7XJWs1oekp0Iq0ecDwFhlkzj+iYQa9c7ciwH2aIZzqu9s0djtaz5g8Cxc9rxbXz8GVvBjvdH5f++z9Wk58Na9WZzqvJ4FhRapYnGV5+veg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 05:26:55 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400%5]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 05:26:55 +0000
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test (v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Likun.Gao@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com,
 alexander.deucher@amd.com
References: <20210802051602.23822-1-guchun.chen@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <9b28973f-d71c-8ca1-32f3-e7dc23563a70@amd.com>
Date: Wed, 18 Aug 2021 01:26:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802051602.23822-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41)
 To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:8030:531a:c97a:dc26]
 (2607:fea8:3edf:49b0:8030:531a:c97a:dc26) by
 YT1PR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 05:26:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1bf0d13-6017-4276-e35a-08d96208cae3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4416FB97E7B14E6A6369094CEAFF9@SA0PR12MB4416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVv8B5vcH040d/h9VbFnyqmt2mr87RA+pxTp+rp+4iCM61woynqB36k/kr/wbwJ72UhNIldaA+oSEuc7eDLvvB6BdeZcbFjLgP6hkQ9darZ5F0rcCdirqalOfjEgmLfDF+dpPvwxi2sP2wnJDc7W3eO+HA6vEkXROZz4riHNoFlTVmgTo6KamWyx9VmVOaP2iaDJ9sTwTsShMRqH7PiG8yW3DPNvc8zS+bUKtRIyb5rke6ZDHVYkZ3YqQ+TER5Gon14mr1aCC0NXonZAsU5DDGlPH6nPcDMdPfXDVQrHZbd5sSVUr6J26ZuC5Ix6rXeuSspqib/ap4B3b45eQQDUzCMRwT/qR11MgKNuA6rpRKlbMpZW9mu5v7It/YrmXovsqacZfHJPRIAlIk5AXbn0Top9hndd7QlNlcShinimif+5iKSHZhBb5fCScVPlJXYBjXN5p7ncddCMvSCz840VXuT8ovt1yQiuFJsAYSJwa3FwZ8lAIDtBKOZ9lAaVC5sOgPZbRovbiYX+AqISR3oGLPoEDGA6C7kwk0hC/Xr9uBa0BTKWo6M0mKcCtbpOQIUM1l3IIij8uyh5bWyLip/XDAqSVl0gunvvrwZyAYgAn6eDzYWRwOCEVo0PpdpaasDdxflz26eqd58rb0jd63RMsZmfRCpYVGKYmxDjfOK2Ruf/IcAoMirv45Jt109/ldACg1pHjD41LKUZ9sRQVxB5DWElKI6qmACzGmjHJd0i2co=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(66946007)(66476007)(31686004)(86362001)(2616005)(66556008)(53546011)(316002)(44832011)(83380400001)(186003)(66574015)(478600001)(31696002)(8936002)(36756003)(38100700002)(6486002)(5660300002)(2906002)(6636002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVCbmk2eG55QmpEVDA3NnBJWE5aTDNIbi9HWmpLME9LQ1E4UTVQaGhIZjJq?=
 =?utf-8?B?OXVFYUpNK1kyMDhjN3pwRGFmNjUwUGVBREdaei9QSXJkUTdhdFBBb1FxN2Fz?=
 =?utf-8?B?ZFFjb0RwbUZlQjNJRSt5Y05QbGhldjk1bFJTc1JET3BDYUhaTlhyQ3hYU3NX?=
 =?utf-8?B?S1RDTW14S3MyUnhJdldHdFFuWUU3VEhLaTFkYUFiQjZTWEIyZVhGc2pHbU9r?=
 =?utf-8?B?eW9qMHFrd1FjRTVERkdoWWpuT1Z2UHpmOFVsQTJHd3pCb0VHcWVOTUZOaHRx?=
 =?utf-8?B?TTNVK1NWZFpYZEpubm82NjV3b05QNERkU21kSkRnYVVoWnN5Y0hqcDlJOW5M?=
 =?utf-8?B?ZU9Tb3RlTmlvTnk2SGNBOERUQktXamJxSk45VlBEN2d5K1ZIREZndmhJcldz?=
 =?utf-8?B?WTRaVDlHMGlGbjZ5VzhtenYvcWFqNUhlQSs0VVh4cVRzTStLWkE3ekNDUEdZ?=
 =?utf-8?B?R2pNYm05R3BWU1pjYnNvSmxHRzVodkt5Rmx3ZWFPWGowdzNwYTJ3cmFRckZr?=
 =?utf-8?B?WFZ0Q1Mzd28zZGU3Nk9OR1ExbTNCK05UUmZiZHpFWDJlVmxtb0VVODYrRFBL?=
 =?utf-8?B?ZVRDWTAxeWthQUxBNHpGUXFlaFNnUHR2S09tRjJZYVFDdHhxTDFRWkFMOXo5?=
 =?utf-8?B?UElvaXdXSktHUUJMM2ZJL1FWY2FXWEZDWGY2VmZzWmFuZlpvMjFzU0V5MWJZ?=
 =?utf-8?B?L0djL3lMZnJXbisxNXNRYTUwbnVRVjY2ZHBVSUJlTVBNRTFhdTNHRnlkTlVn?=
 =?utf-8?B?SzlpZmZWWjNNVm85T296enVtaktNQmxRdEVMNlllUkptS0V0QTZGTC9tQjlp?=
 =?utf-8?B?OTFBQkdFQWd6N0g2bktFNmNMTzJLYmp6UmRXS0JLL2VaU2VrOFBkZHNBeXFt?=
 =?utf-8?B?cFZZMGRJWUxPbjRBK1VtLy9nOG9peTB2bWJMNEgzelVEMndUTy9Kd2hkWGMy?=
 =?utf-8?B?MjIrS0Z6dExkK0s3UFducUlxSjdOWWttNlc0eVAxRVpQOEVJd1ZvbS9aaHFK?=
 =?utf-8?B?ckhjTno5a3gvWTZrL3ZRc2YzWTgwbnZrNW8weTZWV1g5anpkUmhaUzdBYlVv?=
 =?utf-8?B?dFRlU09OemFab04rQnVOck1ZeURTeTZyUGlHdUx0UVYxZFpUUHM2OWhMNlkw?=
 =?utf-8?B?TUFrQmpzSGluQnFJWW9PN0w5V2I5a3VhZXdmc3VRdjBYSHNaZjJEeWloSWJv?=
 =?utf-8?B?dUxiWjlCNG5XbSt0ZzNWM2h5V25tVTU1b1NNTzlhWktLSGYzN1l4YVk2bElo?=
 =?utf-8?B?VmM5eHFhbmRVV0s0RVM0M05ubUd0L0k4MTJDMW5zQ3lsdWF0RkI1YTdtMk5G?=
 =?utf-8?B?d055Z2o0YldQUERidXJEVWUrQjVrN0g4bnpUMERRUGtjSHk4Wjg4ZXlmNXVR?=
 =?utf-8?B?c3U3N3hWakIycW1FQ2Qxdlg4ZzdHMUhNTTJoTTU5RS9wWXFtcGRSczlzZGJv?=
 =?utf-8?B?VmtBNnJ4cHFhK2ZROG9rdHFDdjZUUStlUCtRRXZ1dDFFbm1aaWFCUVBjME15?=
 =?utf-8?B?eUZyUjNJVXNOKzkwZEkycTlDVFpMSGp4d2M4dTArK0RoZVJVMHppRExaWFFK?=
 =?utf-8?B?enIvdlJERTZlUDZGQjM4clZhaVYyTHVSd21hU1NBWjdKcWdNS3lzbmNxbmJM?=
 =?utf-8?B?YU9ydmxFN0VQWnduN3ZCbmVBOWdadzN4SHR3Vmp0N1NxTHdLZUQ3MXErdi9J?=
 =?utf-8?B?aHNJQVBoVUswbVpPZ0lEb3UxbXZzVVVNd2xtZkhwYUlzT20rajJERHhqaXBW?=
 =?utf-8?B?bDFEMkpUUzhkTHBaOEoyMTdUemlJZS9RNm5HaUp4UHFWcUpRUmhwRkdDQmMx?=
 =?utf-8?B?ZERvNVYrQnZlaGpPcUx5eHRweElhc1lTaFZwVnJrK2tLbC9qYSt4UVNCSERr?=
 =?utf-8?Q?paw2ZdEtzG3Bq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bf0d13-6017-4276-e35a-08d96208cae3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 05:26:55.4427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOsrDL6UUoStzkkX8EKCrTPQErQM9Hjsf8TNhpCetEqjnpFSSJvRkZmdSrbTAmQj5w++daBVGNtIqPbjUbnaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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


On 2021-08-02 1:16 a.m., Guchun Chen wrote:
> In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
> scheduler in s3 test, otherwise, fence related failure will arrive
> after resume. To fix this and for a better clean up, move drm_sched_fini
> from fence_hw_fini to fence_sw_fini, as it's part of driver shutdown, and
> should never be called in hw_fini.
>
> v2: rename amdgpu_fence_driver_init to amdgpu_fence_driver_sw_init,
> to keep sw_init and sw_fini paired.
>
> Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 +++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
>   3 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b1d2dc39e8be..9e53ff851496 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3646,9 +3646,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   fence_driver_init:
>   	/* Fence driver */
> -	r = amdgpu_fence_driver_init(adev);
> +	r = amdgpu_fence_driver_sw_init(adev);
>   	if (r) {
> -		dev_err(adev->dev, "amdgpu_fence_driver_init failed\n");
> +		dev_err(adev->dev, "amdgpu_fence_driver_sw_init failed\n");
>   		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);
>   		goto failed;
>   	}
> @@ -3988,7 +3988,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	}
>   	amdgpu_fence_driver_hw_init(adev);
>   
> -
>   	r = amdgpu_device_ip_late_init(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 49c5c7331c53..7495911516c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -498,7 +498,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   }
>   
>   /**
> - * amdgpu_fence_driver_init - init the fence driver
> + * amdgpu_fence_driver_sw_init - init the fence driver
>    * for all possible rings.
>    *
>    * @adev: amdgpu device pointer
> @@ -509,13 +509,13 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>    * amdgpu_fence_driver_start_ring().
>    * Returns 0 for success.
>    */
> -int amdgpu_fence_driver_init(struct amdgpu_device *adev)
> +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev)
>   {
>   	return 0;
>   }
>   
>   /**
> - * amdgpu_fence_driver_fini - tear down the fence driver
> + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>    * for all possible rings.
>    *
>    * @adev: amdgpu device pointer
> @@ -531,8 +531,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>   
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
> -		if (!ring->no_scheduler)
> -			drm_sched_fini(&ring->sched);
> +
>   		/* You can't wait for HW to signal if it's gone */
>   		if (!drm_dev_is_unplugged(&adev->ddev))
>   			r = amdgpu_fence_wait_empty(ring);


Sorry for late notice, missed this patch. By moving drm_sched_fini
past amdgpu_fence_wait_empty a race is created as even after you waited
for all fences on the ring to signal the sw scheduler will keep submitting
new jobs on the ring and so the ring won't stay empty.

For hot device removal also we want to prevent any access to HW past PCI 
removal
in order to not do any MMIO accesses inside the physical MMIO range that 
no longer
belongs to this device after it's removal by the PCI core. Stopping all 
the schedulers prevents any MMIO
accesses done during job submissions and that why drm_sched_fini was 
done as part of amdgpu_fence_driver_hw_fini
and not amdgpu_fence_driver_sw_fini

Andrey

> @@ -560,6 +559,9 @@ void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev)
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
>   
> +		if (!ring->no_scheduler)
> +			drm_sched_fini(&ring->sched);
> +
>   		for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>   			dma_fence_put(ring->fence_drv.fences[j]);
>   		kfree(ring->fence_drv.fences);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 27adffa7658d..9c11ced4312c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -106,7 +106,6 @@ struct amdgpu_fence_driver {
>   	struct dma_fence		**fences;
>   };
>   
> -int amdgpu_fence_driver_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>   
>   int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
> @@ -115,9 +114,10 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>   				   struct amdgpu_irq_src *irq_src,
>   				   unsigned irq_type);
> +void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> +int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
>   		      unsigned flags);
>   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
