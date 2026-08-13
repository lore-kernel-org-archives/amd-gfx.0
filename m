Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0A7C5CFEB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 15:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3E710F394;
	Thu, 13 Aug 2026 15:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMjqw5hy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF18610F39E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 15:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+P586BvnVW4ouwVWnY3TkGjwwO9LE0dwD55XmYBXTOEZUPwYxgm3oIl3mW+oGu8/yh8IVwf8nlNhPjbdU/pLci8TZ6r17C5mIyNFg+Drv0hHygjQsZVpkzu3EOOCByG+aep6+duyaTbW2x1BAyJ12G6GrtcUpSauGyA8ume30pPA/69hC+h/viu2sxUCd8N/j+ak/uy5FtbZmw8L98cZ1ZLzYEmzSXKwqhh9XarSlqPNK1OPuSmUB7PRuvqvO1u0rpdcHlrg1q0DB3futRc6YiD14Oj+Ou705Vfw6rBPG8UhlIWKO/eO4MKRKT1ZZir34v2oUTa0/bgB1w6Q9bkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eekUNP1xMOyOReJij/WkxHxN3xquyRwbnOlTE4pV17g=;
 b=BLPhMVSf9Bq7mevTQAjLZSL4FsgBBaqEjM5LGjRb9JYS4r69lNASgfXzjiI/CKucpUY9X21mQ4ESE7DV9YSqWDs8JeyIXGBI1GeahmuHFsuRl2OdaJIdybx/LXHNm4/oGiop8dinWvuhrOXUrCjrA8QeKyNqYeXRznd1UwILaA4hrzcHwpSzPqNF2yDrx/ozbjWbEZkhxwV+6c5tvvLOgimMdBThxTdF2g1fpDjFAI1z5LgrrMUnJyAehjczbQK9iTSCHEWvgrZswBKM2kwUnu4N+XlfvV40cfCeEzPcqKjASvtoUIHXDvlLQli543+rJvlYvw8mYmc6BgOXKQJepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eekUNP1xMOyOReJij/WkxHxN3xquyRwbnOlTE4pV17g=;
 b=jMjqw5hyyXSISa2t6lsaAdTOW2QAK9C4ATDCR+Lmn4FOKT0yBN1Y6FjwcMMm/HW+l81a2ZSy7y0PZHTWK8sQgerkW2Ojogp65YjU8DOXNh3Yt4/q6xzwKxyfo7xmr6q8IMtE9IuDuBXHiYdVKR7bY6bstRjuZTQJUD3k0dXS7Ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 15:04:07 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:04:07 +0000
Message-ID: <34efce60-6816-4463-847e-3cd65fda877d@amd.com>
Date: Thu, 13 Aug 2026 11:04:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: workaround 100% gpu usage issue for gfx11
To: amd-gfx@lists.freedesktop.org
References: <20260805212722.247508-1-jinhuieric.huang@amd.com>
 <20260805212722.247508-2-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260805212722.247508-2-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:610:118::8) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: ade0c785-2751-44ff-7026-08def94c1f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /t3XXN9sdTp3gByqrY+pIY8sQnCoHS2MDWyRoaXVOfnxi6Vkm/heM7/D4vGOzuMg2iz17iuG+WpkEF/akBZyOrruo9OkTazFzwA9/lCnKi6RtxSjCeEtE/ULZ3G3AcNbfJ3Dr6PuOvlRO6ej+RQ68ib6B3YZupLoVTS1eV/IAUMofL7pDxwjrGWVF5mSKixa8axmOKkmPUsZ0mlXZWjs6Co/jxwpf4X0g0keiZsPOCIBkW6eun49pDe518gm32+fllpChN04I7pFJ8qDdj5vYcuc7/lvW722h5me6VyFYA4wSjKolrL87kqu3Hz/ZfzYKK7xBn9SEqSbRz3+ECC+VOdA1Fjd3WZW1/dDvADKfohLDUl50ivuwvMtii+xi1AOVofMehoQV4Ce3eLX1zD//J0hK/b0WweFH+2qq1OB9jjFc4eRyXJhLhhj89wByvY91L6nePPHZ3Ji7BfFOV3wLoULY+3Ta+7GKjyPoWqXbvH9efmVRyeY1rmFD1S3jGOU8kRhPdUpLKaFAOYg3JdtvWLgdLJBg3wz7scOUvUxBy21V6nE6Il/USs7dbadxks9xMg1zMTWZrTNh6lwOJpCh3Aif1o8E2JtOGj6kt6YKWBdi+QZdC99eWN3+Uzrt3DYyAEvCFBPUI/FZalwp7NW2XhF3HjrKnPfkmyqAKKoG2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhJWjlMdDIyb2xLRkx3M1dFRjVGK1JjeEVnUDZkNUIrUGJnZzJPNUMvd0wz?=
 =?utf-8?B?UTE1YUYrZGVNbjZiVTRtK3lPWlRhWFJLNEJSaEZ2SVArZkI4Q1M0THlsVElq?=
 =?utf-8?B?SVlDbUNtWEJNU1Z6amYzV09DcngvYlF3a2RlQk5zK3hJMnB2RWtQL0t1dDJK?=
 =?utf-8?B?UXl0L2N5aG45UGh1RmUyUFpES2ZmSWpDem45SHdRN3pHdlhDek1razgrckFx?=
 =?utf-8?B?RmxEdnR2aHZEWGhQc053VFJNUkNyN0V2YVlhSFBJS282c3NlanUzbzB3ZG5j?=
 =?utf-8?B?WWxFdkNqditQeUdXN0NoZGM3N3FzekpFV20rM0NEL2NsZWtMcHBNVWNyQlZ0?=
 =?utf-8?B?Y0MvOHFlb3lZSVhlRzBJVXZBN3ZoRE0xYlhodTRoWXZGMFlDQXp4c0xsL1p5?=
 =?utf-8?B?NXdUK29wYktQLzV6STlMVXRIbzQwcXMrVVA3cTZXTkhRb2NzM2hMRWxDSkpU?=
 =?utf-8?B?ZlFLQkhaMDVRM2NXM1VSR08vbXlNM1RWNGEzbXV3c01NQm9XSHl1VVpLV25Q?=
 =?utf-8?B?bmE1dnU0RVpoSHA5Z0NJRVZZTTlEcThVcWd3QmlVaWlIbUhkWDh2UXNBdnIw?=
 =?utf-8?B?a3BNTDRqNHQ0TlJPSzlETmxDK0x0WTV3ajdEYTNUeTREZHVpNEl4ZzNnRUFW?=
 =?utf-8?B?K0FsRC9XeUhWa0hNaW54bUFKV2ovY3FrTDZ3b1R0Z0s0WVNzSlQzdkdvZUZ1?=
 =?utf-8?B?MG5aVzkya0h1ZjB2Y3ZQc3RBTkUyVHF3dFNPYmYrSWFnVDVBc085UGJDdXNK?=
 =?utf-8?B?Q2tVRDdxQkN1dmpId09FQzVxUjJBanlQd29KQ0Z1ZjB1MFdDOE5hK2lMcVpo?=
 =?utf-8?B?QzdDT1Q0ajBLWksvRThXRkZsNEtkYUlWM05sUFYxLzZOSjk5M3ovNjN5OTBC?=
 =?utf-8?B?Ri8zeTdJeWVYSEZ6ZjZMaFFYeHRkZlBIS2hNbkUrUmdZUWNwQnhnbWE0bnJ6?=
 =?utf-8?B?d0orVkRkN2xIWnR5UXZHby80bCtZcDh1RkJPeHR5ZFFCc1pLM210UXhyNUVG?=
 =?utf-8?B?RExMME1oYytnVWJ0dHdOVFhTeXRCUzlESUplekNWU2lGUnNQeExpRDRyb0tK?=
 =?utf-8?B?L2RxM0k4RzFacUxBZGZSTEZjUTMxcFpCY2NYbjlwa2ZkTlN2YzdGYU1aOEN6?=
 =?utf-8?B?V2cyQnY4dnFub1Z2akYwd21ZTkd0cUNwUVIvenlzcmdPTFdwaEFyUWk5S2VX?=
 =?utf-8?B?dW5KdVZ2UUE1czVONkJoYmtaOHJXZmhwTzF4bUhaSjFxQlh2VWwyWUttV2lk?=
 =?utf-8?B?UDRnaytCK3gwcjRLSjd3Qk1hWGE0WEZXaEFNSENpb2kwSlRRQlhRU0tibTFw?=
 =?utf-8?B?KzNCczN3c284Uy9GR1R6S1VBTU1rRXI3OHRmQVNHekRrVGMzbXIwU3djNkJV?=
 =?utf-8?B?c3QzL1ZoSE5PNkFnckdBQVhVWHBkMjh3U0VwbVZ5Vk16TzBhVHY2TFA4M3pj?=
 =?utf-8?B?MVUvU3g0RTlkN29hdzZZS1RCdzNwalZUNFVhVkZGWnBNVW9BRzM4a1VKNWFV?=
 =?utf-8?B?N2FidkliYnlyTFRRNitiQ3FUNjJhOHFicUNrQTl6ZXBLWTF6eVpQZmlMNith?=
 =?utf-8?B?L1JGdU8zYTY3WEpNMzlwV3RTY1BjVGd6ZXczajZYOTNmcTBKaFBCRktxZ3ZN?=
 =?utf-8?B?OEpBc0dkQ25TcVY1RERCd1dWUW4weG1HTmlhWXpVN1lxeW9HK1hlLzNLWTRH?=
 =?utf-8?B?NTJqaDUwMTFscE5OSkZBekloK1dXSUd1MHUwUXpaSHl3U0dvVUtMNk0yQW5m?=
 =?utf-8?B?T2dDaEtMeTBPVWc5U2MrWjIyclRQNy9ucFNjRk94SDZEck1UK1NOUjAzRTVC?=
 =?utf-8?B?Q2NzVzVJRlFXUkpWSGxqKzd6UXlaQnViQnV5REx1ODBRWmNacmVYSlc0VkV4?=
 =?utf-8?B?bWpReWtuRXJtb20rakZYbm1qOU95cjV0U0MwQ2x1eHJQdUdFQTdiM21Ec25N?=
 =?utf-8?B?VS9LVE9HbVJLZXQ3NjJTNWpwVkxGa1pmUm9qWEo0b1ZvRWh5WGFvTnNsc1Zu?=
 =?utf-8?B?aW50K1hRY3lTbTBpcDd5cTV3MlQvL0hpcWJTV0ZJYWFFckxYWkpGTmV2UXF2?=
 =?utf-8?B?S0tRSGtXWXU2R0tFOHZGTjRTYTJVN2pTZzhqdkhCTDR0REtuRVpEMk9hTGRM?=
 =?utf-8?B?a2JITFgrYUFKRjdMT0lZQU5MRmdjNmI1TEVxYlVoWk5IcDhmNmM1ZVRIYTRz?=
 =?utf-8?B?bzROblkyeXFzcW1qbUwwdzc5YTZBb2R2KzRITGhFMnUzcUlWY2ZUSXBsNHBq?=
 =?utf-8?B?TFZJRG1DNUhHWEg5UkVKdmM1dVZuYlpZVWNEdVlia3pxVmZpM2xsdkpuVWdm?=
 =?utf-8?Q?tMJbbvMp0BMZaKXB51?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade0c785-2751-44ff-7026-08def94c1f79
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:04:07.6929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3/VNWfas65rDGyWwXcIWVQHC/AABUoVJFMWRh4Jm9+MDCn5Z1qbiNjQqEPNCG3g8BA/6CxGyfMlTG/Kb7/1+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
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

Ping...

On 2026-08-05 17:27, Eric Huang wrote:
> the issue only happens with oversubscription when gpu has no
> workload, the root cause is mes oversubscription timer, so
> disable mes timer and make a similar timer in kfd to resolve
> the issue.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 -
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 ++++++++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
>   3 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index bc0ee6ccfca7..40683db66a13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1019,7 +1019,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
>   	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
>   	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
> -	mes_set_hw_res_pkt.oversubscription_timer = 50;
>   	if (adev->mes.use_rs64mem)
>   		mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx = 1;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ea9d87450eae..350e0ce308d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -47,6 +47,9 @@
>   /* See unmap_queues_cpsch() */
>   #define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>   
> +/* Interval for notifying MES of work on unmapped queues during oversubscription */
> +#define DQM_MES_UNMAP_NOTIFY_DELAY_MS 50
> +
>   static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
>   				  u32 pasid, unsigned int vmid);
>   
> @@ -276,8 +279,16 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   			q->properties.doorbell_off);
>   		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>   		kfd_hws_hang(dqm);
> +		return r;
>   	}
>   
> +	/* GFX11: start notify timer only once when oversubscription begins */
> +	if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
> +	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
> +	    dqm->active_cp_queue_count > get_cp_queues_num(dqm))
> +		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
> +				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
> +
>   	return r;
>   }
>   
> @@ -354,7 +365,16 @@ static void set_perfcount(struct device_queue_manager *dqm, int enable)
>   static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   			    struct qcm_process_device *qpd)
>   {
> -	return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
> +	int r = remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
> +
> +	/* GFX11: stop notify timer when oversubscription clears */
> +	if (!r &&
> +	    KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
> +	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
> +	    dqm->active_cp_queue_count <= get_cp_queues_num(dqm))
> +		cancel_delayed_work(&dqm->notify_unmap_work);
> +
> +	return r;
>   }
>   
>   static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
> @@ -3088,6 +3108,20 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
>   	amdgpu_amdkfd_free_kernel_mem(dev->adev, &mqd->mem);
>   }
>   
> +static void mes_notify_unmap_work_handler(struct work_struct *work)
> +{
> +	struct device_queue_manager *dqm =
> +		container_of(work, struct device_queue_manager,
> +			     notify_unmap_work.work);
> +
> +	amdgpu_mes_notify_unmap_queue((struct amdgpu_device *)dqm->dev->adev);
> +
> +	/* Re-arm if still oversubscribed */
> +	if (READ_ONCE(dqm->active_cp_queue_count) > get_cp_queues_num(dqm))
> +		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
> +				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
> +}
> +
>   struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   {
>   	struct device_queue_manager *dqm;
> @@ -3213,6 +3247,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   
>   	if (!dqm->ops.initialize(dqm)) {
>   		init_waitqueue_head(&dqm->destroy_wait);
> +		INIT_DELAYED_WORK(&dqm->notify_unmap_work,
> +				  mes_notify_unmap_work_handler);
>   		return dqm;
>   	}
>   
> @@ -3229,6 +3265,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   
>   void device_queue_manager_uninit(struct device_queue_manager *dqm)
>   {
> +	cancel_delayed_work_sync(&dqm->notify_unmap_work);
>   	dqm->ops.stop(dqm);
>   	dqm->ops.uninitialize(dqm);
>   	if (!dqm->dev->kfd->shared_resources.enable_mes)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index c9f9f7a87111..21cf3c16f3f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -281,6 +281,7 @@ struct device_queue_manager {
>   	uint32_t		wait_times;
>   
>   	wait_queue_head_t	destroy_wait;
> +	struct delayed_work	notify_unmap_work;
>   
>   	/* for per-queue reset support */
>   	struct dqm_detect_hang_info *detect_hang_info;

