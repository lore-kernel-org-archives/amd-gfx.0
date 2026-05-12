Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE735CD4F21
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 10:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC5910E1EF;
	Tue, 12 May 2026 10:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAqaXeiH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5348D10E1EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 10:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOrkmxXMwUZdPENkectlxk7hsl9HljAbWRUNbEaqwT7NUDViiO5Mx+xRJdL/AxwHodZ+aUGDtfuwXNNPXuz2mS2er3D2FCrQlWSkIhegVi7RYxjHJTIDP9rS3vkbHvUz9IjrXVfk6JvDPZbjUSmMj7xQYpFgTEGjAXvHmzSvIPeuOR6u4EJfyg31EgtcxMqwaXGj42FAakJH4mywOxxCG3R/5mu2wPlxOwWOovEGrW7CgYZ3iE+N9d1wvKOZHev/bZnOlkmsczDKV0F0+FbKMIJhnUxypC4x2Hm3jmORAXisLUWknhtdxVGbJj5qMdKECxm039Jj6aUoYTMLfIjM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxRL2qtoqQ+tXFI87NdKQP0zbJ09Li4XmHnWJ8pLxU4=;
 b=IEds8ldtN5THodhaaCAdMWsh++TteZb+kwpOZVUHOdjszIUn6HeqZeD6ZwdJsHuMEcueanfSBY5F9B1MtAsRyDPW8Gnly0o17c6+aAlaUaf9RMhEQNSblbaDv9Z9nukwCrxIOePx7bsGx59W7MFGJhYQrwcc1Zi5eFMtEkXoJ5diw47kMwVJy74RuWSIOaqqgffwazhnqmkZVIl8zQ3uwP9wQtGa5p6OQbidsZtsA3VG+JSgUf0Hm67Sbq5149uIx6xoaAEHrqpJMr6rdD7gOt4f5ppQK5IfHJ2VUh2uf8z7SWDIxHVejJAxpCnusNwqB/pznBtxgztOsu7k0aEHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxRL2qtoqQ+tXFI87NdKQP0zbJ09Li4XmHnWJ8pLxU4=;
 b=DAqaXeiHkWkTXSsGiOabF7VVgTz3RK2Ha1K60bjkaBxj+aluGa21q8zWqLwfNGEctqeYLyHLvZjyZQh13TMwCBQVsjNbbS8FXzc14fRNh4ZQfLwDTllmKbBs0FsFTjl0tvAtJ36CKtjUYuzrWIsTWGIHYIAUL0r0kK+NQ7B3Oz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 10:16:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 10:16:01 +0000
Message-ID: <63281ff1-f316-4d8f-874d-34a9e57991ae@amd.com>
Date: Tue, 12 May 2026 12:15:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: cancel reset work while tear down in
 progress
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260512092810.750379-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512092810.750379-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 84dfd3ca-81e2-4cae-ccc0-08deb00f778f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: WnElgw/eikzfLwCRo7xzuzkO3ZTYwG1jxnqcM3xCPchq6J/nocukpMROdjlN6HxXOrLHDIwig2eXJryfOQfNJENovyB/qZGSf/qhCHG17THF2ggknw0Ju5ur07DmoIBp7A9YA8+Wd3PRjU3ULXBE0/X61pdGNmSHdCslK1e/JHSIZMFMmTzWh3kQOqFLY00OdKH0kgzte9imNYo20PxpdeHHGCHh9oDRxo4ICCqNiq6V74h6I1/GSjZTx9oV5QB/PSfE8Sz0B4Arxzg1Wdl72hPQcp+HwSljP9487TQyW4ju7ISS78UvpbgcZBepOw4C6lm/EbGGUDg/vDOdmwRx33LhG/Djmu5LZ1wJSQxBUPv4rih2aDatPdvi6dGvUHrIUSCIt042FzqtKCTEMQurlpiaf5C4RWxYNwFE1HwToCtDAevFRkFGJeaeGekoAtbBNImsPQxegdw9TWjPTdVEBYT+cpA5F3iKj4c2NoIqL20OQ76JxkOAM4wLkDDZMR0YIWMSnkuDzdwv1XNe5lQifz9nuPGWwnddfjdtPioFRT8WxtypZi8DYDidd9jriL14VMVLkGxVe4EE8nj3E3xS8gOM2h+N67W+eZXSQoLUNPcU8ofwdmHW1VLYHfml0BPQLZLRIhSUdnTlpEkL1izv/51YtAK1F2pBtwkUYCLaS23YvCgzaR8uJ4WEHHnII9Go
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFpFNTdqS0pWb3RxVXp3SndTTlpNV1BoSWJic09xSjFpbkI2bkR4UTZsTjFS?=
 =?utf-8?B?VUh3Nkl5RlR1OHhlUVhacFRCZFIrb2NQWi8wcm9RL0ZiVjkzR29NQldjYmRu?=
 =?utf-8?B?OEFNVnJId3MyMkUyV3VFalkwcm9oUDVBdVFjWURpWEttblJEL2lVMlNDWVN5?=
 =?utf-8?B?a29KOVlmYnovZ2I2V3MxeDFmZ1d5aXNRckE2MStWbE9meCttY2JmTmJxeDdw?=
 =?utf-8?B?Rm90eGxTa2RKMjNVNG52RFIxcU9tNHlVaWxyQzA1U3ZMY3ozRVRzRU0wZ1A3?=
 =?utf-8?B?SHk0ZzZaQWVrS3F0TmIyQ0F1UWQydXZHRTZOQXdsWnptMkJ6VGJmNDF3eVZ1?=
 =?utf-8?B?UDJXbDk0bkJLMk9zaU9wdDhBTU1kcGRMeHZHMzJVRURncStsU1NKSllmWVV2?=
 =?utf-8?B?VFNXV2xvNUJYenMwSEVtL2dSZnU4SURCWGZBemgwVVA4L3QwbUYyekdBekpM?=
 =?utf-8?B?QmhpdEx0Qld5MXQ0RWdmd1JaTXBsUU16VEsrenZBbEFMNnFNSlVhdmtkY1RU?=
 =?utf-8?B?RzByRFBGeEVWTlJtVE1Pc3N1c051bi9IMXRoaUNxeW5WSnhwR2hPOHFucGNi?=
 =?utf-8?B?eEhzQndrT1BMZDhldFlQcU53SlFzazhEWlNkajhhYXc2M05FRXFrcTB3c3Mw?=
 =?utf-8?B?eFJUTFZPKzJmZkhHdWZKQlRkcXlYL242OGJjcXNQVUtNTHdsU3hTeG9sR3JS?=
 =?utf-8?B?WThlWVhwQWJxV3QybzFkQjVtQy9kWlBtV2pMU0g2U0VhZDJLYWtuQUNGNFd6?=
 =?utf-8?B?TWlBenBnTlBqL09YRWkxdzhJUzJWQ1d6Sm5uRG02ZUYrRERpclhBR3pYK2Ji?=
 =?utf-8?B?REZlbWhOQXBEakJQL2hZbWtoUnNyWDNJVFpsNmJidTNFclNwaEVHUTFvSTJF?=
 =?utf-8?B?Mngzd2p1K3Q5OUxyWVRUbk1aYjFlemtiTTZwZVZLdEV0MFBHTzRidEVqS0g5?=
 =?utf-8?B?cElobDVnelpFWUlaaUx3d1dneEQ4RXYxZHZQSndCc2ZPWFoveGtmcy9QYWZP?=
 =?utf-8?B?dFIwTE4vN0RYTlVvZGZqRndCdDFyaWtCdVcvL0NEVXJYNGtMZ1hzdGJmamNh?=
 =?utf-8?B?d0N2T0NoU2VaMEthSC9TSnV3MC9LR0ZBNjVBeDdTYkpNazhiQnJ4LzFjMVow?=
 =?utf-8?B?NmRURFU5VnJ5OXBMZnpMVlgxcU5GODJhOTFVc2g4RzhndFpQd1FGdHlxOFVa?=
 =?utf-8?B?YkZUbk15Zk9sVGY5MnJKUXFjWHV6QTFCYzBZZEJIUXhNQTRaVHdTV3hkR0Fi?=
 =?utf-8?B?SEZWV2pBL2ZzUEV6M2xWTHNnQ3F1TlovWnpNaC9heWZZWDFGTDRYbGpHTEFh?=
 =?utf-8?B?clhwZ3lxemZaa3pLdGorNHM0a01kdmdDNXZsM3hVZ1hjTXN1VVhXUTJJVmxn?=
 =?utf-8?B?YUN4dVlzc1VDdmc3WXlndm1NMVdkSGpQMUh0MDFMOW01akxMZVVydGlJOVdL?=
 =?utf-8?B?bHhjOEZ3T0JiTjFibXZzTUVJNldFUkRQN2JLQXhvbnQvRkNGVStoT29SRkVT?=
 =?utf-8?B?VW9TRm4zYTZGcTVFSFR0NVNRMGVZTWRkb0ZQejgvSG4wZ1hER3hPbGRTSlc0?=
 =?utf-8?B?YXI0THZxRzdseEEyRHpXVE5oOVBJbTNtZThmRUlqTzI1WTJ5SlQ4Y0Y5UzZG?=
 =?utf-8?B?NVJFdXNkUVB2a1UxOVBYYmVXSU50aC9NZHhwZzFzVkZwRVVXVE54NkRITVVE?=
 =?utf-8?B?WHk3cUNtYVR2TlRSZ1MyS01YdGMvN2MvVVozRUVSTlM4VCs4U1hqOVhrMWcr?=
 =?utf-8?B?TDdQUkxIbDd0Q0h5SGJreEVEb1U0b1ZWaXJYakJQR3Y4UEdhaGZjcUkyaXl6?=
 =?utf-8?B?WlltVndZZ0t3ZGpIcWxheVpQdkJLd0dvQm9pYVNGdDRuaEl1WkpTRkRaUXhQ?=
 =?utf-8?B?Y2w1N2NhWHpQMlpzWlpVbzhLSW9pOGJVcytDTUNtTUNZZ1JBZU1rYmVVRnpj?=
 =?utf-8?B?bHRvN09tc2o2K3krSk54b3dQcEZOYWJLTnd3a1BaODRZNnVHOWZTZVgwNTFt?=
 =?utf-8?B?dnF5ZDRJdllpNjA5SUZQVjU4QTNsSkpzVmZ0d1ZJeHJpSWUxTFlVbWRCQWlU?=
 =?utf-8?B?Vis3WXg4Z0hwRGZ2QzkzZ1RXTy93VnhJbE00WlluNkNiN2U1NUVSTVlvTkRN?=
 =?utf-8?B?VVBMc3NQNXpoenVOcHZpbm81QW1SaHNtV3RmeVJjcFhGazFIYXUwM1o5d2wx?=
 =?utf-8?B?cGJ0MEhDbGZVZ010S3Y0N0M2UWNyU1lIdmY3TE0rS2F3RXk4S04rdFBwR1lC?=
 =?utf-8?B?ejlrUSttWk1uUGJteXMvUTF2SW9XaFdhbzlCL2JZUWRQWFR4YkxsKzN6TU1t?=
 =?utf-8?Q?wK2Cz7vi7pkTcxYeiu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dfd3ca-81e2-4cae-ccc0-08deb00f778f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:16:01.2576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7aYpZqlsn0OHI8neEHCFzSedjNxn4x7Wp/qbXqztHUVHs+vs+OT+Y9OH9thavSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
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

On 5/12/26 11:28, Sunil Khatri wrote:
> While tear down of a userq_mgr is happening when all the queues
> are free we should cancel any reset work if pending before exiting.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0a1fc45f5b4e..6000dee5ee3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1346,6 +1346,14 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  	}
>  
>  	xa_destroy(&userq_mgr->userq_xa);
> +
> +	/*
> +	 * Drain any in-flight reset_work. By this point all queues are freed
> +	 * and userq_count is 0, so if reset_work starts now it exits early.
> +	 * We still need to wait in case it was already executing gpu_recover.
> +	 */
> +	cancel_work_sync(&userq_mgr->reset_work);
> +
>  	mutex_destroy(&userq_mgr->userq_mutex);
>  }
>  

