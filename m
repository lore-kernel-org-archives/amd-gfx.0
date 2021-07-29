Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795CC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 11:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9E160F01
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 11:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C9E160F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F856E059;
	Thu, 29 Jul 2021 11:11:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396FD6E059
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 11:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdivDuvhBROkwcAUFkoYwXDg1uTcP8iehP4ERIDb/8PAMqBt5nxLqWVLO998DsiDDtS48Z2PndsT/SjAyUf3NeOlQI39uYBD7+Ky928LSexlKRCeXP/MTLObjSXuf0QZ8Y+ezHlblHUFHKM+blHk7yWaklQ+zqPd5Egwycq/QF77fmIr7Wd720aAMH2mjKeE71meV69rLyCnP2Gp5TWjls1dlT8dnNDgjKzjGMnOuk1HBOOqkyMg3blftTdme7INL9WayvKDgVHUhZg2hdLraC2Wr6ezVmDct0nREVU2RLtrAwDpo1UZNOd8ZQwlFvSJdWqJejHHi+5YuMJlVVRQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+pr6AjvR94ZYkF4QGtxjRs/gO8ihBieap0AVQ18agA=;
 b=ed36pjVJdxZ0WnVSVCkF8JsAFcDJqxClE6aHegweTyGyRl2+5YZm8FuypDiQhVQs7nQxyVzNErjf37wf2B4/4zu6b+6CQPTovAXS9d316MBNamVowLl8VMtu40w/PtzqdALdid+3P/wgp1zFUoUvPg2YwVbLhPJ1z2B0bByQntX5pbzn6PLdQEToDZLS7vJEKXJp9fKP4DiwOtpQkRO4iAT2zTamE8XEmfkx2f/cmisMf0ExVhYoV5cTXQVOiH+11Kn++5jbDe9sUpbmQvq/S/wu9waCVJN9GibJATfqPwYXbDmnAvr5WjZ2Ne1akpKC6y/XHMXHubTQosjrrLSsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+pr6AjvR94ZYkF4QGtxjRs/gO8ihBieap0AVQ18agA=;
 b=ZjqF6xaxsXUcCN42h020rft8rFlMgodo/dyp+soi8Vayqbvk7rBdtSbjsBICiSE8l1ar+5fV+qn88YQmL8RoJJSLmFN2E/AW8P8YqvUXyVelcVySLMeDaEU5NH6uuxrOQYOMiEdZp1j+UDswuKECAF+MzW7Dp9uV8EgjJMFLRpI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 11:11:33 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4352.033; Thu, 29 Jul 2021
 11:11:33 +0000
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Likun.Gao@amd.com, Hawking.Zhang@amd.com, alexander.deucher@amd.com
References: <20210729104945.25312-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f862776c-a329-19f6-34bb-68f5ff5f6b50@amd.com>
Date: Thu, 29 Jul 2021 13:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210729104945.25312-1-guchun.chen@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR2PR09CA0008.eurprd09.prod.outlook.com
 (2603:10a6:101:16::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3e62:c902:d5a3:6f28]
 (2a02:908:1252:fb60:3e62:c902:d5a3:6f28) by
 PR2PR09CA0008.eurprd09.prod.outlook.com (2603:10a6:101:16::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19 via Frontend Transport; Thu, 29 Jul 2021 11:11:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d55bafc0-cab2-4d92-ef27-08d952819f58
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25780D2E2B3ACE5D819AF51E83EB9@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTGp6oULfGezOuSo3M7YpZPBqWxRhwzbH0dowyNpLinaiCKSUuU4FgSLJAAtTjLg92PVSW+ceTouLUw7U+k8qf6a8aE2rpH143EU56P32WukuFEJu4iceVYdbR3YATKg8VRBgBXN3tQvWC3Ga5KHCz1/FoLw3S7KyC1dcE3j5o6fZ95i9cS6VcQ1g1CIJv9mY171Fz3F0FsoHH4fCA/+ReOGPaNRlNmf0bJcQ3IacPzCOW3ctftbVBym1Vj1ed9WSy41vpsbeI7s3mFMIs/P88IhEN9VgveGpGaXzzBqN5CJblhqcSDgw0Mzg6DvgXfYhn23C8/sPJ+NJNjrRWkz6nAEOc7zIemL//OZXEMb0+SzQudBP/CpdTMPYLynZUFjkWrdUAUkfQD58Ra+A73ZiBsh0tQjgBLtCA8otILeTbHGv2DGtYbh/vXfczc0+5hi9Y0a7b56Uvuh6nEpb848YAmbZ1uHfhdM22AmJ4ZTvfl96bU0wUPZsyq3QRK2r8Whvo3cHG1qVclTcKW8dWABWKmSK4+nBImBw9REQybst6K1RE6xzjtab8p6pF5IEcam9pv6yh6llcwGxz1w0F48paoLRHVt/yTt3bMf69ory1xH7YU4CmiLUU1pfXqPGDpSv/iJW+zw8Mxt7bsRhdse4hYjNCy2hy4lpTv/MAhzgRSnLuHu7z+vRdfmhOuHa7wKWzDqqMl9xgzsevL/CHQPm9dZmjHL6OtFvmxaKJ3Ning=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(316002)(66556008)(66476007)(8676002)(2616005)(36756003)(6486002)(478600001)(66946007)(186003)(31696002)(2906002)(5660300002)(6666004)(83380400001)(38100700002)(6636002)(86362001)(31686004)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlgzSy9uT21hSXlSamhGU3RhcnU4VUdzNmhpL3Joc0gyOXpaLzlETkU0MXU3?=
 =?utf-8?B?UEZCMU9nS0dBOWQ4aE50d2tPdk5wZjd0ZFVtSS9JRGFleXQ5Z0dGU29nelBB?=
 =?utf-8?B?R0g1bnprSU1YNGE2aEFEOEtLalRGRHV0Nk9JTTl6VUV6RktvSWMrZnZQY2s2?=
 =?utf-8?B?K2Y5V1JjQkFrU0syNDltMVFCdlY5eVhXR0psNjJGWnFEQ2VQQUJxWHRKbmhp?=
 =?utf-8?B?eGlWZjVoT1RXUWRsd1hOek4yVTc2VVZsVkZsVHRPQkVnL0gwalhPNS9YZjhG?=
 =?utf-8?B?UFMzNU1ZRGxoSUtWaGIvbWRxc2hrSjYwRHU3dytFczBFR2RWVDJaQTU5MU9h?=
 =?utf-8?B?S1BaWG9mTDhnelpwN0M4TkMzam1rbGZ2YXg4blIydFpLY3FPOG55TVZyZUxW?=
 =?utf-8?B?TTlENUNpRUp1RjRrVndndmZNOE1WV05WZ2YyN0dhNGNlNlVQSjlVNm5rZUhR?=
 =?utf-8?B?YkRhcFp0TkhmTHdIVVJ0aHJISm5rSnpmQ2NjaXY2TTdYd2owL3RJVXIxYUNy?=
 =?utf-8?B?R0R4QjlYQ2NwUFRaeWdocDZ6SkIyNlc1QUE0ZHF4TzA2bDRwWEtId0FacUpP?=
 =?utf-8?B?RW1uYkU5bkxRdkVhQlIvSzFyVW9jN0Z4VmR3OTFWL3U0ZnJ4eU5ycVJXQnpS?=
 =?utf-8?B?NGlxRTE5UU0rMWovRm81TFZZNWlvZDU1VjNqUXVNcEcvL3k3UytZTytLcEFh?=
 =?utf-8?B?Q0N1NThlWTV5S3dIcWh6UVBIWWo4WTR2dENZSjNQRHJvaFAyVXJGN1k0SjJP?=
 =?utf-8?B?MDV6cnA5MG1WUDBxcHBzL0txVUlZMERpMk1wR3NTWFlXTzRZc3ZTSFV3SmxS?=
 =?utf-8?B?QW1MU0F6SG5MN0w5UUpSOHEyYjlkNHh0dHRoZTNvUk5XR254Qyt5eGJVN1VP?=
 =?utf-8?B?Vk5tZ1NyTTczSFhyZGFsL3BWc29WdmpiZXBPQU94alhEQVBramZnYmRlWUpJ?=
 =?utf-8?B?LzdXVGo1Y2x4a2tQWGxxQjh0RUpIeHp2VU55WXV2UTJoUkNVQnFzd05rVDUw?=
 =?utf-8?B?S29oK25TZ1BzbERxUkdqTTNOWG11SllBa04rWWVNM3dUNXhaWkM4Y1QxN2lu?=
 =?utf-8?B?TzZKZk9vNXhIVitNQ2g5dDMraHdXS0NnYVJ0Wjd3M1VGdkJYZm43aFVib240?=
 =?utf-8?B?T3ZIL2xOb3FWYTVYZFVDLzZ2L3N5TmF1eVlGV1p4SmNkUnJjak5ia2RFSGl3?=
 =?utf-8?B?cTUzckZxa2dUOWloYUplU0F2dm9KUEtRbWxhSlF3cTZqZHVxUm8yaThtNWJs?=
 =?utf-8?B?OUE5ZEpyam1XS3c1Nlp3NllzUWorNmtHaFk5MDd1L1NIb3lkYmlHZSthVDQ3?=
 =?utf-8?B?WXZTZWhyZUpQV1RqZlFWT1hzd1pFcTZrQktTTVVZS2VWb2VZcXUySWRtYXp5?=
 =?utf-8?B?MzVYdTVKdzBERkIwK2NETERhT25VUkRONHlITzlFaHZwU0t5eEM1Qjl2Y0xQ?=
 =?utf-8?B?WXNlcGl6YkJISzByajkzOTFwL2FzaE5mZkdtT2xKcmJTZzlBMHN5RDhnRGVC?=
 =?utf-8?B?Q3IyTXpIMmIxTnNnVjM3M2FVQmorTUM4VHQ1QUhVNjhNZkU1R1dKSkZYaTBm?=
 =?utf-8?B?dFVzUlFzRUNWVHZrVGhnM0Fqc0Z3S1JPVjF0U2FnSkVndGxSZWthUTJRMW15?=
 =?utf-8?B?N21UcVJJeUJkMzh5RVVHMEQ0Y2VwUnB1cERpS1hlbUxOR29jeUhhamlVYnlk?=
 =?utf-8?B?UTdSUEpVNU83STB4Q1RBWlI3RlhYeUdoQmMzU282cVNmcTFoYStjQUk2cEF6?=
 =?utf-8?B?eGxUNFpsRkxKb3VGbFA2dzhqaFZMNnRLemFScStlQys2RlV2dnFYc2NXMWh6?=
 =?utf-8?B?TCtqNEQvdTlpNG5vUFRGR05mZndYck56d3BDYVRMOHoxbVhCU0RXQ3FwMUdk?=
 =?utf-8?Q?zAen5OewFT4Qq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55bafc0-cab2-4d92-ef27-08d952819f58
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 11:11:32.9159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiBIjtcd2NnrXj0JMpA2ouJ25qscwcRZT87z32Lc1Y3vHDrBERcRW0SZeoUEud8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.07.21 um 12:49 schrieb Guchun Chen:
> In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
> scheduler in s3 test, otherwise, fence errors will occur after resume.
> So introduce a new parameter to distingiush the case in this API.

NAK, the problem is rather that drm_sched_fini() is part of the sw 
shutdown and should never be called during hw_fini.

Christian.

>
> Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 8 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   | 2 +-
>   3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b1d2dc39e8be..aaff8ebbb7dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3844,7 +3844,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		else
>   			drm_atomic_helper_shutdown(adev_to_drm(adev));
>   	}
> -	amdgpu_fence_driver_hw_fini(adev);
> +	amdgpu_fence_driver_hw_fini(adev, false);
>   
>   	if (adev->pm_sysfs_en)
>   		amdgpu_pm_sysfs_fini(adev);
> @@ -3941,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	/* evict vram memory */
>   	amdgpu_bo_evict_vram(adev);
>   
> -	amdgpu_fence_driver_hw_fini(adev);
> +	amdgpu_fence_driver_hw_fini(adev, adev->in_suspend);
>   
>   	amdgpu_device_ip_suspend_phase2(adev);
>   	/* evict remaining vram memory
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 49c5c7331c53..7e6a73c2919d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -515,14 +515,15 @@ int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * amdgpu_fence_driver_fini - tear down the fence driver
> + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>    * for all possible rings.
>    *
>    * @adev: amdgpu device pointer
> + * @in_reset: indicator to distingiush device removal case or s3 case
>    *
>    * Tear down the fence driver for all possible rings (all asics).
>    */
> -void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool in_reset)
>   {
>   	int i, r;
>   
> @@ -531,8 +532,9 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>   
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
> -		if (!ring->no_scheduler)
> +		if (!ring->no_scheduler && !in_reset)
>   			drm_sched_fini(&ring->sched);
> +
>   		/* You can't wait for HW to signal if it's gone */
>   		if (!drm_dev_is_unplugged(&adev->ddev))
>   			r = amdgpu_fence_wait_empty(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 27adffa7658d..42cbecfc26a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -115,7 +115,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>   				   struct amdgpu_irq_src *irq_src,
>   				   unsigned irq_type);
> -void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool in_reset);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
