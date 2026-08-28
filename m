Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F107DC61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 13:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D4010E010;
	Fri, 28 Aug 2026 13:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hA2SAEZf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661CC10E010
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 13:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzoSsfvpWgh517t/YVgBI/HhfFXYZAmL2/PYzjsLA6VGJScfuF3cHJoe534uEjPrzzUIYCEHYwKh1rJ1BYcFk3hmWwASoyLFhYwkJRi1Nbx7dDL3KT6HZUxQwaKvzfGsIuNPgY+K+PB0T+38e52i0caJuYJWXRHiWY3bYKViSlTQaKXTqmFSSn4CW47FxrgDm4nuxcxf2IZZVTxSfQ+RNTYEn3hzQysE+8t216Ldt79d6sB5JHRjNhtDtC5yLPqgNj2iWBVVQJkIE4l+uNaaAwlAXMKmhki95Xd3+4VjGsrgPfkOfC8gvYI8gU23Li8Ei3Xz5kWZZKNjWoJDV3AV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndX+G0OR3MneNxDRW2NH6QQ8pK/yK1mcKzTvdvp/f8s=;
 b=FYH2iavo4FY456YZ2tM1f/2O9KCx8lArTrZ7p6UodVq/Kc1fhceG3WuTQxP4KgPUF7uogxAkXYjl5ipYUQIDRvegqOlcnnjruxfskxbqpL+JPGq8Y1wTtdqRhv0aoPK5zLdTAWQGYh7lL4T04K6hUIuPZvDRVb68tLDXUONH4JIqpcTravRfx1gQYt0CF1G1aGdPuoJ3+b1H8tBTCybAhH70F8DT5TzmukUW8bxl/Yppg4pi4lsUnBNZjWcEeFhECAExADhCf6vo0sPom6iuXN8GEhdaZRwqZ6Q5CuDJjAS6eBVaiZ0S9gfSTfQbYZz54stCwz7CoLS6lRZ71Jtlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndX+G0OR3MneNxDRW2NH6QQ8pK/yK1mcKzTvdvp/f8s=;
 b=hA2SAEZfm7hV6oF69eu/ClOQy2NoGZZyJK6LM9zTxkTx+6tczM8YVjihDhHnIutwdoB56XLF6X4BEloY/fM+fb7wVBya3FA15CEvZTmxBA6hA71lwkeLjfdyqlu/mxFjJ6h+iICO7Geh3UNT1XR5PpMbscwsF72IvpFjfgbLJR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 13:08:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 13:08:38 +0000
Message-ID: <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
Date: Fri, 28 Aug 2026 15:08:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260828095349.9797-2-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 637f9bd8-1a80-4fa5-227f-08df0505793c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pp+gNXEgUj9h35NuioCuT/dLYZ2AnBfHYVzHHvpOlKWnitvRKCOglP8VKmTtsgpAzrJ2XgR1ZO1QB2NHMXFtMXcBSRinDUHxLkxO2378ybUmtiMniEYsDJF2Zf2ohf10ZYR1cFWL5FSjPPzAlaC7OVeJKtK0XPiMqWJbMvR7BZJBGlFrMJ9CSRu/xxEeH5NmLEttduSNdCeFfzxJw8uqlOwH9Ol4JqQpZr8t+8OksA4I7tvh7hnXLsRGlo6gSaryFbNMquG26KwCeGydRG6/SMfo/FSljcJD3Y7LK9UKE2a3o5teb96pm46mpEub6G8D5I4d65hNJMMBND7XIMpzwIQIZtl4EIkUOUgnA45L1CoblV4BxJlxJJyrLXZT51CMKSiByPaOpVZkXotaxPF4XZIDkmMD/kWkRL3DukTZHt3T8MaqdoL/gRx9lmbxQg9PmogCoK75qFwjnwAamwI4aKxGyLNK7hVW0YNSdWzLH12j8JC5yhgo881w96mwCWqMl8Xagt3DgEg3pePpmgzTC2ci42TnPnXPfxDlcuSlTGLb7dRltyypVjI8i/tI64ulT4JLphsLgw+8dw7j1wKGUzsIN7PFP0wjr1VB76bB4BNhf8FMV/uQGE2xrQKcOOTBxd5AhkLqRBBGc7jAvwm0wga5odYxcqWm5q2P5Bq6Y54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnBLdzloTzNiUWcvQithK2dqM2tGcW1sQWdTSTZ6UE0vSUFKVFhDY1RHTDFz?=
 =?utf-8?B?RVRzQThPaVBwZ0E1S2hIS3B3QVh1ZFU5UTBxcWZCZTFoNWk2cXpjRFhzMW1I?=
 =?utf-8?B?N3N6NVQ2b094bVF0Mkl3RlM3cVNlSXM4S0I5MHU3TmxSNm8vTWFBdUE1VFQ5?=
 =?utf-8?B?YnFMMFJqSU01SWJzUUVHQmVGcGRQT2RYUHk4RWhSNFFLV2o2dkJBVlA4dkRJ?=
 =?utf-8?B?bFR3RThGaTRDWXllZUwxY2FYMm9CbUYwd2lpeUxJbTViSnN1WWFTbHY3N2Fz?=
 =?utf-8?B?aTNHY0JmdDNreW80R25FaUVLS3dpV0UxMUYyL3BmNkZFOUhSdDFZazQxdGVY?=
 =?utf-8?B?SGZCRGd1cGttR0oyWk1yVWRaOEVhaVArTk5lb2I3V0tTcFBaV0piK29KdEk2?=
 =?utf-8?B?RVg1d3pNUUFOTmV4aW5ZMm9ibFY5czQ0b2x5L205YnRhVjdvaGFxQldTNnlH?=
 =?utf-8?B?dFBTOW93M3FIdzhYWlhPVThaM241d1V2eG1XWkhERjVLVVY3Nkk1Tmt0cUEx?=
 =?utf-8?B?OU4vQzJ1N0hXbmJrd0V5QVpMczFkK09zQjNZVjhhZDkwVXA5eGdIL0VINWJh?=
 =?utf-8?B?QUdtdGhBblJKa2J1UFhualZUUTF1aW5PNllzdFlwanl0a1hhbFlJRTRiWWpT?=
 =?utf-8?B?SVBHZGNCYXovZHVsVWUzSmNoZklwNjdycVhwdGVWeUFZQytHNnJ1c08yR0tp?=
 =?utf-8?B?WFBKUGwwZDBMeDRmRlpTblJJY0RLUHB4WXRBTnBXN2FGK0hoUlJWZFF6YThQ?=
 =?utf-8?B?N0lrZWRlMVR3clBpTVh6RG9QM3RsVU4veGdEK3VlT0wzZTcwZVozODQ1WTVh?=
 =?utf-8?B?WkdRWDFSUHNVa3BjSzVhY1RNVXA3Qk9LVTVZY0FSWGZ6OFp4VGdSSUlVRWJz?=
 =?utf-8?B?Q2J2RWFEenQ2Tzdaa3hYazdOWldXVlc5Zno5dzdWWEMybTc1UG5MU1ZSQlRN?=
 =?utf-8?B?QU5YK3RoMjVDaVJUeFZIT0g1ekMrSzUrQnJQRzVmVjUxUlppMnF4Y054dUNG?=
 =?utf-8?B?dkF2cEhDTUdEeFhsWkEwZTVxVnhQZTlPVHRsU1paamhWaThlWTd1UWNrREdH?=
 =?utf-8?B?R3RGcUY1a0FJbnRTQnpPcUlkbWNJdER1S2JYSWgvRGxaVDBuUlY4N253SmxB?=
 =?utf-8?B?UkxXeFdZdEFxcjc1NkRWNmhzSE85am5WWnc1VU92NEM0akVzRlNyN0lFOFlE?=
 =?utf-8?B?M0xPSWhCUWgyaXAraC9yQW1kODRvdWVCU1MxdE5LRGhGbUtyRERIalRBYm91?=
 =?utf-8?B?UHhRNzZMWU9HWDhJRnJjUWhudzZCZ1pSVTZkcitrS2huYXVOZFNyZGVETTBn?=
 =?utf-8?B?QVBTeXpmZW8rMDM3NnErSGd0cVlSWVhFZ3cvblo4YlYxNHFvNkE3RkVuT3JK?=
 =?utf-8?B?bjEvbDVlZWZsRndKanJiNFFlT00vcGhPK09GT0NMamp3eW4rUmFBQ0lWODl1?=
 =?utf-8?B?NlZWWGx3SnRYTFVUYlBhRzQ1S0xOMXV3SkwyMDdEKysxbDRNVlNxblpPM2V3?=
 =?utf-8?B?aUFvYmZ3ZzhMWUhuQlZpZ1luMVZ0ODU0aHBEQjl5SEl0eEpJOWZoNGxiZ1E3?=
 =?utf-8?B?RkRRMk5CVS9iUnU4RWx3UzdwRHlmZUZsOWc1TmhUTWM4Q09XZ29SMkg4akZG?=
 =?utf-8?B?cUJ5STFlZThUa3JBbjVmRGV1dzZlOEV3dkVjWDhycjNmV3BzbTFzTWpGVi8y?=
 =?utf-8?B?Tmp5UXY3cVdrRXpFUHowSnliZ3hpb3ZoMlFTaUhtOFI2RG41SC9FR0NhL3do?=
 =?utf-8?B?cGFOVVFIQldEMW9LRmdlMGNIVjlrUGphd3NJdWYrcmRVRnpVcXVpZ0JZamsx?=
 =?utf-8?B?Uk5vRWg3S2hHYUdJY1pvZ0ZBMHh6N0hnOVJlSmx4cnJjQmFxelV5TUFVVXl4?=
 =?utf-8?B?dk9ldlZKUzJTQlc3VkI3TC9oUG1Od3poYUVsQVZTaUhSY2Z5blZEM2FrQ0c3?=
 =?utf-8?B?YkVaVTljbG9PelNIOHQ2eUgwUUU2VlpodUJTZUkzK1lSREltK1lNcGhrb3dE?=
 =?utf-8?B?K0swWG94OWxXbSt4TXV5aXN3dTJiR1JDWXRsUUMrZjc0Zk1nb3dkaVdNRllX?=
 =?utf-8?B?eEZsQUZWcWFTQUk0NEU5TFZWamk3UmxnWU5mR3N2dkFmcDRDN2svQzdMRDRY?=
 =?utf-8?B?TkRQdFRkQ2ZDMmljYkl2aG5aMVFCbnB5NU5zbWxIY2RMVXY5RjRIKzE5VTZn?=
 =?utf-8?B?WkNYY3NLWlhia1FQNXVxT05iZ0NBWVZtYnF3SUxlTE9IMkFHelUvUkFxZDFZ?=
 =?utf-8?B?YlE5bTdVM2thZzVESlA5N3NSbUZ5MjVWR3ZvZlNMRDVpRy9HNnJWc2IvUStu?=
 =?utf-8?Q?tDC7k13Z8agkL9FwTK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637f9bd8-1a80-4fa5-227f-08df0505793c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 13:08:38.0594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ8HAaV65fsj2NiY9T7AX3x6gAc8ZgxJdvMlAwGA9iBx+r4Uyr69oVanihffB8zO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

On 8/28/26 11:53, Zhu Lingshan wrote:
> This commit introduces a new helper
> amdgpu_lookup_queue_by_doorbell which helps
> look up a user queue with the given doorbell id
> in a xarray.
> 
> This function takes a kref of the user space queue.

Well absolutely clear NAK to the whole approach.

This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.

When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.

Grabbing references from this side would obviously result in circle dependencies.

Regards,
Christian.

> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0a816b3c5ff9..e0639f844a8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>  	return queue;
>  }
>  
> +/**
> + * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
> + * @xa: user queue XArray indexed by doorbell
> + * @doorbell: doorbell index
> + *
> + * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
> + *
> + * This function increases kref of the queue, the caller
> + * must release the reference with amdgpu_userq_put().
> + */
> +struct amdgpu_usermode_queue *
> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
> +{
> +	struct amdgpu_usermode_queue *queue;
> +	unsigned long flags;
> +
> +	xa_lock_irqsave(xa, flags);
> +	queue = xa_load(xa, doorbell);
> +	if (!queue)
> +		goto out_unlock;
> +
> +	if (!kref_get_unless_zero(&queue->refcount))
> +		queue = NULL;
> +
> +out_unlock:
> +	xa_unlock_irqrestore(xa, flags);
> +
> +	return queue;
> +}
> +
>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>  {
>  	if (queue)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 6412a7f7b6ef..8fc73862f64e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -151,6 +151,8 @@ struct amdgpu_db_info {
>  };
>  
>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> +struct amdgpu_usermode_queue *
> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>  
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);

