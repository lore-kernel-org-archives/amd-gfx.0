Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A3FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 09:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833AC64DF5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 09:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833AC64DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1030D6EA83;
	Wed, 24 Feb 2021 09:16:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDE76EA6D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 09:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw7HwwXs/b8d1VNz/qnBQpSx5hIo0swLIKGEYgt/+eamhNcB+gUlgrEszqdCQeVlcscHNKJf+wCfrBm/Yw7+SbIXBZPthGTnoXUHh6Kemci1b2pHC4m92rhb2wI14VaUgEqBnRPLLdeIIrspCbitVsL2TrM4NKWaQ7Ig0HspX0ifhLDekxxMn46gp0ba8DD5KFBFiCq+f2x8P7lOrLJkbw/CRKrxpPCbXlYeNhPYMaOfW+X2oVe82U+meSUtl3hBApk/RvYGQpx6J6kQdcE/Hx7PUjPF8VK4bvTnWnSat/+jHWCYiyXCJ4zeua+DthEbf1QkTpIIK2HzbGY0QzA4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7ZQLtKah6YMpa+AQH7yUJQ3yTMvAHBqDwTjyJWzatQ=;
 b=Rq4mab+H6Y1C/JdZ0jpgBfJqmMpnD5nSaSy46U3qBI4MU0qqTtRBPLCdVIVRq8S67ccuofBYUQZulhSphupt/LB5FCp+syt8/53PNbRLE8m+OvOZ1YCzfQpOY1wJ+q79AIHIAcO7PxQqkE+69q3QnmBRhgxOK8/jwWfiYVb2tpooBGV2g2tmQgyL1LVaYaFlMnZGrHctPo5rHECZvi0ZgY98ziCL3jD6P29zlwLvT4xlB3F1GvT3D0EHYRYoGm/F6wIjuoWpu+1VKaGgVjD4zZ/EDxkuUK2EYOWi1xDoh5McPwoN2fe64iVC9PwvP98oBcX+YPA7RVhhXCZ97h3zlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7ZQLtKah6YMpa+AQH7yUJQ3yTMvAHBqDwTjyJWzatQ=;
 b=rJIeF3ePQj5pl/wvT5UARHdPIftMtr/khJwQMvZfX75VqoacCWFtdDX9SNplhHpLgzATTh+9X/iVkVA5kbMWWF0PNrSqXz/OCH9z2QV2hdDtGlEI6YEZ6VetblM36Z+IcPXJFxs6rJzkSEZZzMdyyaBh7hkxbI8fj3XNxHBnRLQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3725.namprd12.prod.outlook.com (2603:10b6:208:162::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 09:16:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 09:16:42 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210223211026.116403-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
Date: Wed, 24 Feb 2021 10:16:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210223211026.116403-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [46.189.55.12]
X-ClientProxiedBy: ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.201.250.142] (46.189.55.12) by
 ZR0P278CA0103.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Wed, 24 Feb 2021 09:16:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c23741ee-c7ac-49ef-e3d0-08d8d8a4e5b2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB372597722DCD3C7813B1EE0C839F9@MN2PR12MB3725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efHUC+m5m2GFq21qIZEXYWOTqCQJ3UWPm7SryHsqGjLlCYboWpBBNqtnSA+b0qB5ybvnJUWVsb061BTn2zQw2ZlgR4f0JjLYwHtLtD4KVjUYADTmie9JS4SA0PSLNggd9zh9GKE+atEOyworpMOqZ2/CQn1Krvl4c0D/I8SEDZyaid/VUriY4FFuUrzAcQv4tUyTrIbm3QR+1gXzBsMDVvdbONpqfwO++GqsrYaCUZ1c7QKiqe+qW5cn2KIfkZSr93gM145J/HCIy4SFMedEUMOWvf0bjz0kM7CPaPiyrBLKHrF2AWNYYFRdFGjZjk3rnyGfOw8BfLwJW04KIwy546+H8/nKdLdGx8D+EnofouvnxwaA58Fsolg8Y9SUce9fMpnFLScwJYib0krpLLLRfnpJYLshPZd2O0hQqWKSfcPY0UXk4Roe22U346n44Js1XT+rhL90Bn6Q1m/A7kxsEEa2DS9bJ21uSTh5HEXWdagCMqzFDtIy72+wlUQytf0+e/TBFir9aGTdsR7vICT+cwyC3BFxo0ENCTIvAlRmcYN6BOpJVAW90rlTXY9UZTz7GUZsFcO34h+K8Dw/X1SU6O3eG3+CKp7uMsKKZ41Xk5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(2906002)(5660300002)(6486002)(66946007)(478600001)(16576012)(31686004)(66476007)(31696002)(6666004)(66556008)(4326008)(186003)(316002)(8936002)(2616005)(26005)(36756003)(956004)(16526019)(83380400001)(86362001)(52116002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b1Q1MlRGem43a09NM01JVUh5a2J1bW4yTHdQcXJZNHFvdHhEM011cDJlenkz?=
 =?utf-8?B?eTJZSHloanpMdVhabXFDZXVZVXZpWk9ZelEyNDZ0VEs1Ukd0U0o2REpuVm9Y?=
 =?utf-8?B?MkJnbmxYZk9vRm1VQ3lmZWMvelVxSU11Zm9qTkgzRGNKWXVTZFVhdWZ5STZh?=
 =?utf-8?B?cWViUTQ0L3hBUWV5TEFEV2lTemMyaE8zaFdQME8zM2pjOGtUaXJXYTJnVklC?=
 =?utf-8?B?c2lGMytIMW1Qb3plc0hwVDBUQUJYOWZ4ZGQ3RmFXRWNQdkhRZzNKY2VZZDh3?=
 =?utf-8?B?TFIya0wzZ0s3L2NpU1oxbUV5WjB1Z0M3c2tCVFNVbEY1MlI3aWlEeW5hMXFK?=
 =?utf-8?B?RUNmNWkxNnM5ZFJpcWdsTm1VTTZxRkNlTXdYNnFRc29GMlpONVZMQkRPVVB1?=
 =?utf-8?B?dUNjZnJqOVVRMkxRejFaQVgwVHhPaGJlQSt0TXpiZUxpKzV6Y09scUNWbHcy?=
 =?utf-8?B?WTdnMEpEeUx4Uy9STlA1MVlQdi9ScmVxd0tIYW52cDJMUDUyeVR2NWR4MmVU?=
 =?utf-8?B?bGQ4WC9JNFRtNXptUk41QUI2cEZwenFHL1dqQjFoc0JPS0Z1c25OZitQYnB6?=
 =?utf-8?B?K3NYS3UzMDNNQjEzVFpGUHZJSEQzVkFraVdpK0x5ME1OOFBVeno3TXRFclhp?=
 =?utf-8?B?Z1ZEaTJVOENURXNoMG5CSUJiZ2FsaURqTlV0QUt3Sm1Jc3ZLMWl2MFlPRmdz?=
 =?utf-8?B?QnV3YWJSU1l5NzhkWEdZUWFtT1BxaXh5SlMreC95MW1SNVRBUjliSEtwM2ZR?=
 =?utf-8?B?aXNReEZrOXZ3RDdPVklrU1pleHRQTGtxM0NwdEE0aGdvcFlQQVVUSWlpeTNp?=
 =?utf-8?B?T2RXeXdRakRyY250cis0UVpxb1pJZFRBWXMwa2VsUjRvbURXWGpTZnpNbkM5?=
 =?utf-8?B?cEFoVGJLQitGZS9CN21zRmF2YXRhSXJMeklMY3FXcHNscXY2NXlTVXBwd29K?=
 =?utf-8?B?eVV2d3MvTytDLzhLWC9QUXIrSVlYaTVYcGY0M1JDeEV3b0NjcWpSemE1dXFO?=
 =?utf-8?B?MzErR0JCRUp4SmRraW9leDh3MGR0ZTRGSlBET2tBRlNHSk1EYWhaTGp2LytK?=
 =?utf-8?B?R3hXaTFEdzFyOC8wcDZIZTdtTVFZZit6YVk3SUEzMmliTTZ1dVJjbC9ibjhI?=
 =?utf-8?B?c2pHTkhDZFh0VS9DVm9rMkhKV25udnRtc09yZVFzUWhGYzdEUkg1TGpYMW5j?=
 =?utf-8?B?SWt1MFUwSktkdGMzcURKRnF2a2RWV3IyaVYzb2hxRUFKdmU0VFQzd09HY2pK?=
 =?utf-8?B?ZCtoK3ZIMS94dnpaMi9aeUY2c3FuRE1KdXZ2RkJSV0VUUHNyNEhHdXJWZ0lx?=
 =?utf-8?B?TXo0QXhvdUp6MGNieHVRNXVMdU9GdFVLUWhsRkZtanFEY005SGlxTUhReGo1?=
 =?utf-8?B?TXNlWmNEVUlZMXVhQ1lEQkdGM0kzOUZ4NWpTMHBVWjMyUktiRm5RbG10Wmg0?=
 =?utf-8?B?NStsTUdNb2ZNY3drM05laC81Zi9rWEZZUjVnSkh0ZWZJUm1vcWF4d2ZqS2Jv?=
 =?utf-8?B?V3ZpYXNGMFAyS1gxN3ZOTTgwT2JJYlhScjJZTUk5VzRBdDgxNCthaS9pRG9U?=
 =?utf-8?B?aVMxQ0VYZmxuTytoKzY0LzdzMmtnT1VRbXNoaXpoT3d0TzM4c1kwa0c2MDFw?=
 =?utf-8?B?SGdneVhEaGROSVU1WStacjN0aDBIQVJnZFBLaVlVTHRud2xzUU1acS84WDJk?=
 =?utf-8?B?bWJWaGpsWkNRZXJ5MlB0di9CWVpJdlZFZHhtSklhcWJWa2tRZVZIbUZFZlB2?=
 =?utf-8?Q?7WWK+Iz/2Qr+p7alPDW35FR/YcG9g5XbbXWwZwz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23741ee-c7ac-49ef-e3d0-08d8d8a4e5b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 09:16:42.5270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oP9VId5pcFC3JhpsmHgcmYkckurzDbE49RBLALo8w1pkoiROAWhFjv8cfxdS/pDZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.02.21 um 22:10 schrieb Jonathan Kim:
> Add IH function to allow caller to process ring entries until the
> checkpoint write pointer.

This needs a better description of what this will be used for.

>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 46 +++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  2 ++
>   2 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index dc852af4f3b7..cae50af9559d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -22,7 +22,7 @@
>    */
>   
>   #include <linux/dma-mapping.h>
> -
> +#include <linux/processor.h>
>   #include "amdgpu.h"
>   #include "amdgpu_ih.h"
>   
> @@ -160,6 +160,50 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   	}
>   }
>   
> +/**
> + * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
> + *
> + * @adev: amdgpu_device pointer
> + * @ih: ih ring to process
> + *
> + * Used to ensure ring has processed IVs up to the checkpoint write pointer.
> + */
> +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih)
> +{
> +	u32 prev_rptr, cur_rptr, checkpoint_wptr;
> +
> +	if (!ih->enabled || adev->shutdown)
> +		return -ENODEV;
> +
> +	cur_rptr = READ_ONCE(ih->rptr);
> +	/* Order read of current rptr with checktpoint wptr. */
> +	mb();
> +	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
> +
> +	/* allow rptr to wrap around  */
> +	if (cur_rptr > checkpoint_wptr) {
> +		spin_begin();
> +		do {
> +			spin_cpu_relax();
> +			prev_rptr = cur_rptr;
> +			cur_rptr = READ_ONCE(ih->rptr);
> +		} while (cur_rptr >= prev_rptr);
> +		spin_end();

That's a certain NAK since it busy waits for IH processing. We need some 
event to trigger here.

> +	}
> +
> +	/* wait for rptr to catch up to or pass checkpoint. */
> +	spin_begin();
> +	do {
> +		spin_cpu_relax();
> +		prev_rptr = cur_rptr;
> +		cur_rptr = READ_ONCE(ih->rptr);
> +	} while (cur_rptr >= prev_rptr && cur_rptr < checkpoint_wptr);

Same of course here.

Christian.

> +	spin_end();
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_ih_process - interrupt handler
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 6ed4a85fc7c3..6817f0a812d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -87,6 +87,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   			  unsigned int num_dw);
> +int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
> +					struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>   				struct amdgpu_ih_ring *ih,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
