Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C29C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 09:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAAB10EA1B;
	Mon, 14 Mar 2022 09:52:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6C810EA1D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 09:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2AYzlOVUxv4cQIIqh/a6pJb0sq1v5LihtDnWKWhu2x0IdhOafJgBCOTBOSf2QfBMltnWALaFYLtRCbNMxJnErouQu7wOwfc/OgMLaRg5D31B1H6HIRaLLB7tCt+nAvHOgwTEQerqAJ1P5XRVQTpztyaxMsnsIt5s0fdUnJV/O4TYP41OSGF7xzBMfPZqM54dpEa+GP6lsHFFVnbuDyzFwrtJAE7X5WKsdReI9LunHMrRibbw594bz1YYRfvX5nO2WryZaMtxLpHUeU13ZDBHB74kH4qijCCdltKNirKw6tHvH3D/NF2JcH4nKeM3lgYFEklebjHuXHdB76S5TT5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SToi/9KZJ9NGLPaEsx2aAoyJdL65cRK7hny8l7cwf2s=;
 b=fWuX97KL6VPpRNflvqbyWK+lf5NAM3t9K6n/ubXl6WYoLBAUJ1flHfD52uZuDw3QZAYjCuKADe7Ji1z108sUwIH3ZejrsOMp31KOQi7IrWu1s4z9j/33/Tq1w+ktm4yenHI2yCJsfoU6If4T9wb+rFY1K1PBtzWzdc/8TvVtyKQ63/szk0aZwb1U61LMenycLv5zyaJdKg/y8NgQ0O9uAZUw265CcOAs8wkUqP0mfwv3BJ5BZYHNnqnmt8C2uuw6wzloAqFNygqX3SB2i9qLSaSeyFkEn5RvrVDwM9pSKUeajr5POfer7daEUEd1UtNLV9EhoH3DzGajavFcuFtGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SToi/9KZJ9NGLPaEsx2aAoyJdL65cRK7hny8l7cwf2s=;
 b=BiuVZA9tE5yj4PxXishVP8ylcoLLhuMML/k5svPOKzbgv21c1VA8vzgnUFaKuMFctrygWaqwJBtt+kwi148FidDaI8GaA4tbD+TEfWyE6wczKNtdkkNxN7qT+UTVpBUFbVKp79XW2QKo1NsvwKTk46yceYa91twuAzY/A215HOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM5PR1201MB0186.namprd12.prod.outlook.com (2603:10b6:4:4d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 09:52:09 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 09:52:09 +0000
Message-ID: <0480be6a-3bf1-d120-8923-06819d7479bd@amd.com>
Date: Mon, 14 Mar 2022 15:21:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220314070326.21828-3-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ba9e638-70b7-447a-9f4a-08da05a04e08
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0186:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01863359D5F265DED996FC1A970F9@DM5PR1201MB0186.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnC13WsFxL2yvHdooijc0qVaMEVmaqn/9jW4D0PlYoR64mC+bxF1Hr+fEYqI9nvcU1DTL9UWT13A3mR4ItOjWnCVn40K0NdaSMRPxz6Zl5SNFUqIAU3QdPLQ3rxAKcIuLVhpZXqKco6zm42RWpeCOOhGt/ejI5c9i901qtDHgMarb1p8gcze18CldyUCE1KsLO9XJD7EV5qFndE+US/QSsiV9wVutyFBkBSrO1U+ie2myn84y3iTGCpVBNvWGanYxLnXS6nWYYsQ/J76AVj7m2uIyjmHcUUfLj89942BmCZufgFbA249ejyVOnr+RcrZ3zcGhrKwypLtPIGfyFoZcKvPWyHVsa9v1qcBz+AMg7VyW3tmy+BN+eOCLQp4+cNp7StdNuD+x1UcvZIb9Hjcwqa3qBWNIOZT2NwYovVUYRoHzo/KDHg9PFiiZajZ25Sjds9LKU7S48Xb/YWUg+i0LAhfRrqjS7mHF/MFZLdzLPAl00LL0X+oP4unX6c4/pCA+c/7lClHcF740klhWD58YV7kd3lnwWhg939U81lJG7j3Pg+UmI0AqOWQ/MhTB8bbXlIKcHICH/lpL8vyjxi1OchTNSw7G1YGJPdntPXZqYqDsgyxpnrRqFv0/bfHZdyzA1B98n3lJkIrrUv4djylQhcWuolyvI2iYy4ZUQcgx6UcI6VIMzVryHCncnETzSFjqDseE2uA3tb1QzR32inJqy3gzewdZh12PQjVNzWNhOOwbkgulooZbvzChxJ85Rih
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(508600001)(6636002)(6486002)(66476007)(8676002)(66556008)(66946007)(86362001)(31696002)(2906002)(5660300002)(36756003)(31686004)(8936002)(26005)(53546011)(186003)(6506007)(6666004)(2616005)(38100700002)(83380400001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1NeTFCd0haREs2TTZBQ1l0WjhMNG9KY2orK1NEVjJmNnpka011M0VrdlBW?=
 =?utf-8?B?YnBXVDFuYS9iOVUxWnROT3hZTzZ4NFpMM3h2ZGMwUWszVy9ITW5zSUhhdDNw?=
 =?utf-8?B?YVMzb2JxbExQVGh1eElyeVI3dFg4OVpkdm8wNy91UHlOa2d5aFp6L2g5T2lQ?=
 =?utf-8?B?RjBuOVk0NDNJM2hBUm5XRHRGVE9iakpLWnl0bXlTM0lVOHhRdCtJZHlwcDBJ?=
 =?utf-8?B?eldNaUsyQkF6cVRqM2xSSTFXMVBlMHc4aGFQYWJHc3d4bkp6ZzJiK1RQc1pP?=
 =?utf-8?B?SjdybUZrdmwxTnpqNTJ0dXVUWXJzWDdkczFBQlQzRTNxS1pLMjhaSnZtMmV5?=
 =?utf-8?B?aFZDVyt2ZFMveFp6OVZGWmJTWEhxWDg3dGQ1cFRIbGt0eDFZYUZFSXp4Vkta?=
 =?utf-8?B?SDFJQWNFeDdqS0hWbHB5L1h6K1lNREZlTFZaRGRYOUlvckltVTcyYlpMbnlu?=
 =?utf-8?B?TWZyaGhyaWNPYUVBRjV4TU1wVEhpT01NQTVBdFdFd0hVZ2R4T2xrejVvZzBL?=
 =?utf-8?B?WmVSWlFyd0g1ckhsdUZGaGRpK2JiOUM2UjYyOGlwTG8ySVRyZmZlM0dkRmh2?=
 =?utf-8?B?SVZaUW1WOFZUUjZPS0FEVkMvTEVWVTA5VUdFajdid1l3dXh2U0RpdW5jNDVC?=
 =?utf-8?B?bmpUeDg5WnVBU0ZVL296ZHIzVmZ6ZG9DMHZ1bHd0R0ZLbEVkNHZlTEprN083?=
 =?utf-8?B?VW9sNUxaZWVpUG5qQVFLTG9iaGlEb1JhamNNVlV5ZnU4S0ZLQTFCYi9aWWJI?=
 =?utf-8?B?RWE2Y0VFeldsMWd3RWtzd0M0QjBmMWw0RGd1My90ZXdzK2tuOXdIQlgxajQy?=
 =?utf-8?B?YkFaUFB3aEZCc1Axb1hEVU51WVJ2T0NySkFXTCt1WlNheE5rcHV6cW5yT25q?=
 =?utf-8?B?ckVOa0gvSlk3cnozM0lvQkdFUmNQVElxMzRmcVdORVRGbWdZejhZVmJQRjFE?=
 =?utf-8?B?UUh3aXowajc2bVVKSUVVM2hVVnI1NytaYi9WS1luQU5rN0pnNUx1eWY0VUhj?=
 =?utf-8?B?Z3JmRFBkOS9QeGcyU2lPQ2RDa1BoaXhvMTBPb3RHR2pvWWJqVEU1NU8wM3Fi?=
 =?utf-8?B?MmJPcDloSnViV0xES2x1WGxGQmpWaVB0UG9waGxDK1RiOWdTN3hFOU5CaWIy?=
 =?utf-8?B?dFEvajRRV0o5WWRvWHR2U1N6S1A1VXVhbTVDNFpON2JUYmpkSkRDOUhKU2Y3?=
 =?utf-8?B?Y3g3dkFyWHgxSUNnYjJtamJQQ0tXRy9YVDRuckR4WHVpZlZ5c01XODJmcVFY?=
 =?utf-8?B?bUluRmlyZ0gyNXpwMWUwZWpHblRNOGdzR1ZJNWx5c0dxYUhxSlh6Tnc2ODVT?=
 =?utf-8?B?L1FLUWdTQ0tic056alNlNnB5dUF0MjdWcFEvcFQ0VTZEYWY5N2lUYlNtNVpR?=
 =?utf-8?B?K00rT3VXdmMrUlBhWjZDdlVHSVZuT081MXpRcUozam1TT2NIN0RscVVVS2RU?=
 =?utf-8?B?UnNVRURYMC9Eamp1cCthVWQxWFhCVllLM2REUTJGRnpRNExhOTMrWHM2SWJY?=
 =?utf-8?B?OUt1Z3o3dnlpMi9NZ0F4bWdmZTNVZFFNRkVOc3F5UG5jbGdTMy9iVmxVQW51?=
 =?utf-8?B?ejNpU3NLR1RlbzFXZzZ1SmtRQlZ2d0tnb2l6UHIyTWZqbUQyRERkUzFtbm5y?=
 =?utf-8?B?ZVA1VTVjSGxjSzczNkptc1BLSUdEazN6cG0yS0MrQ0oxdCtCdUtvRFdHdm1J?=
 =?utf-8?B?bjlIQmhCZmFFODZaN3ZPUExvVjRqWFArYnNwUFhHaXMvQys2OEhyU3pVVEhR?=
 =?utf-8?B?WHJCVjY2WnVUS3BWdW9xbE42Qkh1MXI1dXM1TmQ2VkMrazRqNU9lVVk1SE9I?=
 =?utf-8?B?ZC9ZR1NYbEJyNGNTTXZBZ2MyUjJvOUd6eG5Qa21vS1h4ek5WWjlJNGdaZ1h4?=
 =?utf-8?B?T205SDBXL05kYzBhalZkRDhFK1U1UUtqRS9welA1dG15UG90ZkRwU2ttc3lh?=
 =?utf-8?Q?1ml/sKCqKutd+VVFPGwhSxcX+7tABEui?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba9e638-70b7-447a-9f4a-08da05a04e08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 09:52:09.2346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkhFnwIuX9emxpFnJ4qfDWz5sPOnZOqYdl08F3JNjZ0u1mLuM3ccBeRACaSjx5tK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0186
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



On 3/14/2022 12:33 PM, Tao Zhou wrote:
> Do RAS page retirement and use gpu reset as fallback in utcl2
> fault handler.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 ++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index f7def0bf0730..3991f71d865b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -93,11 +93,12 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>   static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   				const uint32_t *ih_ring_entry)
>   {
> -	uint16_t source_id, pasid;
> +	uint16_t source_id, client_id, pasid;
>   	int ret = -EINVAL;
>   	struct kfd_process *p;
>   
>   	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
>   	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>   
>   	p = kfd_lookup_process_by_pasid(pasid);
> @@ -110,6 +111,7 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   		return;
>   	}
>   
> +	pr_debug("RAS poison consumption handling\n");

dev is available through kfd_dev.

>   	atomic_set(&p->poison, 1);
>   	kfd_unref_process(p);
>   
> @@ -119,10 +121,14 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   		break;
>   	case SOC15_INTSRC_SDMA_ECC:
>   	default:
> +		if (client_id == SOC15_IH_CLIENTID_UTCL2)
> +			ret = kfd_dqm_evict_pasid(dev->dqm, pasid);

Since this doesn't logically belong to the switch condition, better to 
keep it outside of switch.

>   		break;
>   	}
>   
> -	kfd_signal_poison_consumed_event(dev, pasid);
> +	/* utcl2 page fault has its own vm fault event */
> +	if (client_id != SOC15_IH_CLIENTID_UTCL2)
> +		kfd_signal_poison_consumed_event(dev, pasid);
>   
>   	/* resetting queue passes, do page retirement without gpu reset
>   	 * resetting queue fails, fallback to gpu reset solution
> @@ -314,7 +320,18 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   		info.prot_write = ring_id & 0x20;
>   
>   		kfd_smi_event_update_vmfault(dev, pasid);
> -		kfd_dqm_evict_pasid(dev->dqm, pasid);
> +
> +		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
> +		    dev->kfd2kgd->is_ras_utcl2_poison &&
> +		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
> +			event_interrupt_poison_consumption(dev, ih_ring_entry);
> +
Is it expected that no other interrupt would come until this FED error 
is cleared? Otherwise subsequent ones could also be treated as poison.

Basically, whether to do this or not?
	1) Clear FED
	2) Handle poison consumption


Thanks,
Lijo

> +			if (dev->kfd2kgd->utcl2_fault_clear)
> +				dev->kfd2kgd->utcl2_fault_clear(dev->adev);
> +		}
> +		else
> +			kfd_dqm_evict_pasid(dev->dqm, pasid);
> +
>   		kfd_signal_vm_fault_event(dev, pasid, &info);
>   	}
>   }
> 
