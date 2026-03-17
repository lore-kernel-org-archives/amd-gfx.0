Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB96F3380C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F1D10E1C1;
	Tue, 17 Mar 2026 07:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O4EwIdiJ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA92510E1C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXfiLNFQ7yhbx6r3b8WVJ7Tlie0WULMzl56sm8nTsE0Xu1Lt6GAr86Wq16Ghgf1cSlpwJ8hjI1AOf8NFUaS0DguaUoGCYppRWN1h1jCeeFn07+HDC4yPiyW4NNuSy+uNF28gAtDCOr+xdjRB+T4X/QX058p1TpCWolNxSYHOQ4lCGukERYKS4RBWaO5X8AG+BZeljKy+5D4PiL6Cc1DQq5oCA6cYFD3Jg9xYx3Gn+uYdUztp/z861UszxwqbKSxl9AIXnJd9xMzyFwG0WqXnm9gu6ic2F5dI/iC5ZgJsAEFBDMtdODErnyjfFjjU2vvntMSskeE9cSNW5LP1917nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+Fmdi3BM4KNU4ps7ZtkNbb6j8AM4Wv+Tn/3RMyjXoQ=;
 b=iUddBwD181qc2dKmxT2PxNgKMIbuxDNXzDTs2KjV43/ysl14EYacmOVJo14FyiVCAI8xK6yFJK4lMHI6pRg6jM3/xTUaiWgETtGpfIvnsWAPppTWTBZB37rSaNlYBYWLR7ohXLZgqYnNpwLhu7/f9geCICH6AqTqLLkiZFJpajlYHd8ZRQB9nEzsrx/Eu0sD9j7jSbWYVHFM0LBxvLeZdp0+eOl2Adz3eULzSGsXgEOp2tLdelyf+/moRu4D3hxXWLEgMJ7sNdshi+xcJTMSaJc+Sv5kSBH8m+weRvgw/lEDG7+jv6kvfRsnPvIxc8wahnwzStjFHEHaOYWXIbUARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+Fmdi3BM4KNU4ps7ZtkNbb6j8AM4Wv+Tn/3RMyjXoQ=;
 b=O4EwIdiJM++cQRlsxwgxkZWthQY4+lBUtnY3pxR8UibAF/MzCn3vqLmhklkGmu2XyshbmsDOdJKDUVWF21YD/TTdOcmJnnLD3ARPT4k5zsSHTv8ZIXKJHPXl+IaMgNBYfDR7tgnPedNOmSPAWLplZLSwqzQw0typTniAIHzkveo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 07:36:05 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 07:36:05 +0000
Message-ID: <0fea955d-ab81-42fe-9eac-90053fcd1680@amd.com>
Date: Tue, 17 Mar 2026 13:05:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/amdgpu: annotate eviction fence signaling path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-9-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-9-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0123.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: ce75f862-5c6a-49ad-2d12-08de83f7d8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: R8pyV4YfGNZQC5yd8yIzyYaTkH2bEVMQXvsjKPbCbu2uWld0rBdu/ZQXIlHmk6XonLLa4/BKGHgpTH4DbKvkxOiAoRZIzqcL6tC8aUqv/QldW06xRTRgTlMNp9YXTsivprjnPQ58MaxQUKgDKH/sPleSx+DJlCKux3Aoi5McZVHO28lpBC1bPP5DHvgEhvyN/Z1RY3ysWbPFaQL9nhEfSJ0cRGpQksI8petkcdSZemKE+VxOEUq5nJWjSPRcXbCPkAatiRK7G1FTAtFcOi4CG93EViGbwg6Q4gImXriUpi6qFfEWtNwHUb5qvruQVU7D2/cisgHJQEhVK5I6gKUqQXQjW0+lczVVq0mHf4zks3tWstv+vBjlisr0gpi8xiiuuC0fsQk7myvUkc34LIGJJRIdl9ZqyOl02yYfWyteARz5cn7j+Jl4LfLnjJg7tjAaoQOx44XfsysskdvxTNTb4QziHJZGF9yRy+XYC8IFq3rzDdGdBZXN+k2UJZE3AAKKE4r/usd8tFd97PYqB2aQKi9ivR5B6z0h5wyrHAb9QMDzz+Fy8yisnbXaQp8m6tMvuuHc4ZCfqIU19+C/A9X9EZcCJgqSomAx3dEKmmNp7431wD4INGd/gT3H0OaC/LYWeKwZ4eVWCCNlHcGrY4YuH4D9HfXT2ktzm5eOgY3dL2ci7OFDnlhXm9PmP6Tx4zT5FLSCLR72lXK/uvOkALC9W9R4WSY79VEyWPL5cIwhLoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Szg1OHdXNjV6NHhqaVVyUnI3dWIvblU2NlgwV0pCVmFWanUvRGN0b0wrVEs0?=
 =?utf-8?B?Q3REV1FyM1dBbWc3R3FnZkxpLzdpbDIzYTFXRmI0YS9aUEQzdXRUUzg0WC90?=
 =?utf-8?B?eWdVZDV0R3RBeUVTaFVFQUJrVVlRc0RxNnM0dVk5MXdmLzVmVVEzRDQzZ3ZJ?=
 =?utf-8?B?VzFMOURoaHZ3bGhyQ3NwNE82dEV6RmFWOTlybnhkMEEzc2ZmOGtmTmtRdndH?=
 =?utf-8?B?emtaU3JheHZycW82QWdoeUFtaW1OU2NFaSsweUdOSG1WODFlamxuYzAzZEpn?=
 =?utf-8?B?Ky9lR2dBaERlblQwUm9HaDJId0NKUmlKbkJmZm10cEhhblpURHl1aEU2b3ls?=
 =?utf-8?B?VEE1ejloZjdKSDdsV3RsdkxvOGRZSTNpTTYyRjhaSndSVHFyTmUwcDdaQWxX?=
 =?utf-8?B?OEc1Rjd2Y2xkYjFJa0FMZTgxN0YrMVNxNXZIM05VVjNzQmxmYXI2M0FGYm9U?=
 =?utf-8?B?MXZrVi9uOENNZGpiaVh3MFVwQjFsWVMzU1BsVzErdG11MmFtS3dNR2lVZ0lk?=
 =?utf-8?B?UHZMc0hZNUZKZXZIdVdkdy9Dd2FhM1l1OUxsQVd0N05MUUVTSmlqc093SUpF?=
 =?utf-8?B?UldGa2pLZWVWMTFQQWl0UG00ZnltcFROSWMwSWhRTUxWZFZWVkxlY1UwYVRk?=
 =?utf-8?B?ZCtHOUM4Z2FrbEZ5K2tySjA3bWNHUE1hVmhqVjdFZ0F4aGVvaXRYYUV2cngx?=
 =?utf-8?B?RWZyN0R5Y1l3bVpQNENvTko3Q1c4aVBwdnJlRWtBTzlWUVZWaFQ4WWt6SjhJ?=
 =?utf-8?B?YlU4VEc2OHM5ZkZrQ0wzWG91bHkvZkRLbjJTUkcxeDBYd0I1bzRPOEN3UUxy?=
 =?utf-8?B?M2dBd3FLb2kyUmJSa00zVXZSbiszTVM1RlNHREtOU3ZTKzFTZEZ1TS8rdEYv?=
 =?utf-8?B?UTA5L04xWCt2ZkJFWFE5RkJPR0c1b09kRC94bmdhMDRzSlVkUlkvd282bFly?=
 =?utf-8?B?M0lmdVV1ZHlpeVYzZ2dpQS91Q1IwdHU2SERPaDhaZk5La3BRSkhhYiszT0ZN?=
 =?utf-8?B?cTBkM25lb1p1Tkc4K0tBNm1zT0Z2cnQ0RGlzaXVHVjVZWkcyZUJJQ0dxS1hH?=
 =?utf-8?B?c2pmTlJUNXVsS3d4eFllSFZsTmVTNzl5MTFjNThzNlZUL0NqYXRrWGNzQjc3?=
 =?utf-8?B?OXJLZGhkWHhBOXc3TFozV0ZYS29uOW9xeHZQTDZwMDJTVWRaQmpyUmFKTElt?=
 =?utf-8?B?anZ6Y1dkRnRIdlJGTjN1VmtNZ09ZUHdTaW1ncGhlSHhCMmgwRlJFelVnbjU3?=
 =?utf-8?B?Unc4NzBzSEM1aGJSRU5oSkh1Q1dsN2JYVStITlROM1dlS0ppN0Z5c0ppYTJi?=
 =?utf-8?B?cXFPQzRZMmFEODRmWjhsOFZiLzR4UFZRSUtaWDF0OGtjbWR2TkFxS1czcFZL?=
 =?utf-8?B?UjMrd1FNNUVxcTJwTjl5MGl0QjVCYnh4WTlmZFNXRmxuOXNVQjFFNms1QU4z?=
 =?utf-8?B?eUMyY2pNcWJqY3RMMjRUQlNZSmEzbXpoY3BFVkNGSXUzNHNSNjFYNWlPNkJ0?=
 =?utf-8?B?L1BoU2hGYnhKQ2xiUWpjVy9Tc1ZjRFRST1p3dlN3a0V5QWJ6eFcwMzhScGNy?=
 =?utf-8?B?WjNNcHRGQ3p0NnBCUXhrVGZWSW4zYVZLL2V6bE1LMUdQR25BTUZTSG5KNTBZ?=
 =?utf-8?B?WVVJc2s4cFRzV1Rwa1g0cy8yeVc4Zm5paGdqS3EvbkZ1QmEzOVFGaVlFcHdG?=
 =?utf-8?B?UGxpeDNjRVdjaTBsQ1RkQ3NLaW4vQzdOQW1RYTFYK1dqRTZiODNteERZc1By?=
 =?utf-8?B?d0M1ZGpETnNvOWxlZXBjM2t2WjVrWWRRMVpOWTZqR2kwcnRES1pkTDlEYko4?=
 =?utf-8?B?eEdTNXF5Q241VWg5K1JYNEtza3U0SXl4bUZodEZVQ0lVZzVGemRPTFFkVzh3?=
 =?utf-8?B?cEErbEk3cDJTWjBGZ2hPYzhSMDRwbDArTldhcHR0MG1KdmdPb0lCRmtlWUl1?=
 =?utf-8?B?NW12MjFTVFg1RXhmNFViblBIK3Y2OUt1OWxQcFlXSEoyVG1FZ0c0Z0hTakYy?=
 =?utf-8?B?VE54MXFmNWFKdmdxZm9UcHNZeDhQWHFjSCtzQWRJL3IzLzRzUCszZnRZdGJL?=
 =?utf-8?B?SVBzZGJiUyt6ejRIMTBoMzlKQ0dKSklWZ0Z1OEcvOXg4TXNLZjFvZTBNd0Ev?=
 =?utf-8?B?VGs5bGpKUExmU01ORHl2RzZ0WVlsLzl6Ujhzc3BjQkhET01JNlFIclplcmJt?=
 =?utf-8?B?bVRuaWJBeUJaL0d4cVdtcThibFJ3MU1yT2lNdFlxdERUdWdrTUxUcXhCd3hI?=
 =?utf-8?B?WjBSYjAxQi9KN2hyRFB0NE5LdGtYZFYxTnFsK2lQTW14dU16cnpIM2ZscmJQ?=
 =?utf-8?B?MHBRTUFpbzFOVjlXVTlyMnAxSW5Na2JNS1Ryckkydi9iRkdLRmhrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce75f862-5c6a-49ad-2d12-08de83f7d8e8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:36:05.5425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zSyFMx7ye/Kz5Xe54h/E6RGThpUKfix3DMECWzRspm6lu9FydxTwIuOTB02UELTTWZsEdjhGmISAOnpZfNo0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 11-03-2026 12:43 am, Christian König wrote:
> Make sure lockdep sees the dependencies here.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 6598823ec619..e5aaa5156069 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -67,8 +67,17 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>   		container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
>   	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>   	struct dma_fence *ev_fence;
> +	bool cookie;
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
> +
> +	/*
> +	 * This is intentionally after taking the userq_mutex since we do
> +	 * allocate memory while holding this lock, but only after ensuring that
> +	 * the eviction fence is signaled.
> +	 */
> +	cookie = dma_fence_begin_signalling();
> +
>   	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>   	amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
>   
> @@ -78,6 +87,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>   	 * next fence.
>   	 */
>   	dma_fence_signal(ev_fence);
> +	dma_fence_end_signalling(cookie);
>   	dma_fence_put(ev_fence);
>   	mutex_unlock(&uq_mgr->userq_mutex);
>   }
