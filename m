Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F55C61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 06:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AA510EE85;
	Thu, 27 Aug 2026 06:37:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rnI9MxoP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03BBB10EE85
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 06:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1dys9HyeWz3/9UHeWGVqolOZXrkIRMw0O6gyHeqzPMBVNv5PaiEjWNBEEoW9lFUWNkqB8/xtYEAfQ17sULmZKGLZdXKdhbbmKrt2boqgz6uBNryTY34wEa7gAPIFNFyDCWDulOsBlQhLatQUskMU2oosHGL6AfJ7e0yKdSLPpG/a8Lk4kvsCZTCVVy1tV0dpb716mhPLkr5cel9maOnbMzBziG8brIi8nsLCsmm0PxyrvLg9kEzhdTNwBCkDXaQrRAzxh5DoA38U74BYjdZMCdASrXLgbCLedAlwWqDyWNIy0kAWJWZPJg288P/QuJWv3CIySgext6u549jjkVWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9xNyz76YDgRh4CkTaz8cTM6KkDO0P93BQ4uIq9pPnA=;
 b=UmqK+JkkL7P5zK647AflKq0dFeOdDdijPjrbRjZqkycw/9ncMGMQLOZ5/4gsIM2FBnl0K+T9HG2Vc1R2ZLMkjCUIQNyhn07rGcUStdXspdb0NWTAh9rbdvXdeA27Zefxwl+cq+3FHqgfJMH2NQCyYAF1u8Gf0GBD95OyDDEZ1MTzu7StIzMHMjF64ArlleZ8H9NfIX4eIjrTtgR3YHM7vFsgvrlxojdWMtVayqY1ZY9d0Sg8DlbjuWNwLBkkWNkgiKObcGzgSYHfdymhnVKZzkKlSYLq+zjH3YgIcF31nc++Wg0KlYrU/7LAHra3HbpF0qzkr/u3WfLqGk5AEfaYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9xNyz76YDgRh4CkTaz8cTM6KkDO0P93BQ4uIq9pPnA=;
 b=rnI9MxoPu/j+lGg23di8lns9rz5VgjCC972+O7HQlLjZ1w+fVx+UyA6zSvDMKaTcyl6lh1KhqjlN1hJdhmYXzD+FowqzI8VkWiiydrU0LnpnifM/aCLvXjlnB5d13uj8cVMoZHcH0Nu4O6t/LJ2pxWZMXltslYkCZlYyrX3CHlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 06:37:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Thu, 27 Aug 2026
 06:37:54 +0000
Message-ID: <baf198b2-204b-4a71-8093-d0a105f960e0@amd.com>
Date: Thu, 27 Aug 2026 08:37:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/userq: use fence_val instead or rptr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260826175841.559992-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260826175841.559992-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fd38ee-c112-404b-1474-08df0405b965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: EzEe8aPBEfPI9c9x6ieC4e6lWXA1ItBA8qdXpXL6YkJQnuALeYRMtb4JqW7Y80WP8qA+K6+bkwz7DnlSjSCca9ZWlexaRPLpOc/7SV18NTUMsEyiFPOUGl9WTDk3vhcWFlAm5MEUE9dGvYWIBxFunr2qJgSubK4BJiJwudEasfD9+B1Obo2QuWYnZyi6gW/6A8+rVyiHHl5Ma4dlI1PY0H8YWEwI7ObYRkT1lJXzPGrMvsHdBSVwcjclkuCh01G9KcDZYNQQtH6/0gV1tRDjiGWwel9DdBNso1rydpAlLs5+Jttxj/SWtdJZhgQtabmqmAq2hGgCMsjZFYSNhZIfewwk8iw9Jys8A4zasOrrOGLQ0AQI0wHM3a1GftkfLYbgvxK39DMqr/9C09i2At282AKa7nc1BpKFEjlQy1H27Xb/4sUXivsvQ49tbvt46NLlpotZw79do8GxCCUJM6/sA69u/Jnw3aJaukGoYYasGzJm6fO/86A+qKnygsb/jrwi39SGbKUZT2pmvcFf5B8YoU0gIKjaYoAXzFCSeDsHMua2OVyD8iIQi3iVJ2NLkhlI+kYGtEmMv/tgP/TCNFAXfOV4vISOUppfNEkbu8neOoZhICEBcgZhJTJ65HjBoNvxvR/Y29HftFlVyYW4WbxdWYOhPwsEUyHmWBQdzNi6jCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBmeXkxYU9PQk0yaStEeFFlVFE1L3VZZUZ0ZVByK2ZqYlZlY3J0cTJkMlZF?=
 =?utf-8?B?SjNuQnI1UEhUMnhMTk1SajhqSmpCSnc4bTYzQjZ6bm52WFFMcTEvK2FYeXph?=
 =?utf-8?B?OG1uclkwVDlGZ3JGU0R3VmJZY0JkQ1V2K2ZLdVp6ZnRwa3p4Y0tLZWt5ZmZC?=
 =?utf-8?B?bTRIOU5NMERvTmU4ZjhjVTRTbDNEbDdoaWtSNllJRFhDcklDeGVTZWNDZ0NF?=
 =?utf-8?B?UnlrdHhwMHdBdnluc1ZVank5S2ZtTXdnZHpvWHR6THhtUDhndHRzK2VhaVJ1?=
 =?utf-8?B?d3Z6RFgwK1JrVmJzV1M0TTl2dVc1YkoxRkdiNm5wUVE4N0RGT3VvcGp1U2NN?=
 =?utf-8?B?YlVVTmZpTk1xYkhzRlFMMTBiV0FFa0Jwb1dKMDhWdmxMZm1GZGhZaHBzQm93?=
 =?utf-8?B?Vmh4ZGFTbEVSZVAvVm1IL1d5SjJxU002Yk5WdzhDUFZ3djd0K3AyendEL0R1?=
 =?utf-8?B?UkJIQVRjdkk4QW43Yzc4NHgrczFQTmx1SUZ6RkowLzg0R2YwTG50aEhoTzI4?=
 =?utf-8?B?b3FTcDVUV2ZyckYwSFRYSVJGK3Boc0Z0OXkrYVNjUFJWNG1FM2thT1o5M0kx?=
 =?utf-8?B?OHRnRFMzeUhtSFl4aXNabHVoWUlQT3pkS2M4VHZBSnlWWTQvNVlxbEl5UXBv?=
 =?utf-8?B?TjluUTZmaXlOcFZCZ3hKcTY2WFhQOU95Mk5rNXpBbDZOK1lWMnFhL2hHVWtj?=
 =?utf-8?B?ajFkYTMrYjNLQkdkNFpTV1h5S2Rhay9LS1FDOENJM29oZW40MUFWWGpKdmwz?=
 =?utf-8?B?TmUwT0RTNXZUaG5qOC9Oa1Y1WlpJWmVQTWhtQ0Ftek5ZY1F1bUFpSENvdjRt?=
 =?utf-8?B?L3BLR0d4bXBoemxXek9ySzBoa21VVGw5dUY5QmdZc2hTeWx1ZkM1dXNldUti?=
 =?utf-8?B?NkxZTGRkZkpKUFBkeWo4dTV6eXA0QnN6d3JNZkJFOXVBSjZVVFEvcFNsaGd0?=
 =?utf-8?B?TlhMeGZhREx4WlJrNk5FZzdrVzFzeXNsSVdMNUdVOFhNa0NhL3VDUVEvcFk3?=
 =?utf-8?B?Rnovd0JVZlp6Q1BqT3RJK0E1NEtCSFFCTmRxakMyNEkyOEtUL0F4eDZ0YVB1?=
 =?utf-8?B?andGNERzb1dFNXpkTWVnZEtoTlJZdkxuQUdKQTBwL3hTU3BCcDRBVktZcnRj?=
 =?utf-8?B?cXMvYzhHT0V3c3UyZmIyMURvM3ZVWlJjSjFvSHNISld6VUNrNWIwQkVPbGNo?=
 =?utf-8?B?bTByQldaUGdkblpZU1BUbmpKZU9RWGptcHZLUVk2S3dzWmNmS2Y5NVRjQjJE?=
 =?utf-8?B?bE1iT09sd2dkdnIvN2t5U1R2eHlpVHFMTWFYY1lFcm5DU0VQK2dvZmtodGgx?=
 =?utf-8?B?Z2RzYXpzU1BwRzU5M0xES1dQYzJuRGp1WDZ4T05tOUtHMXg5RFUzejhBL21q?=
 =?utf-8?B?S1NQL0lhOFpjdUdwVnBGdkJ5Y2pDbi9WQVkwN1ljVEdzcXFDZzEzMUhrdkxC?=
 =?utf-8?B?WGxnYnFQUUJwdFdlVWFCM3Y3eTRFTFNQMDNkVDlBSzhzcktjQjhkajhkVFZL?=
 =?utf-8?B?aE5scnJWSUNnRkRsRFAzMVRJQXg2Rm10T2xYcmFhdWQ4a25QQ0xKVitsaUlJ?=
 =?utf-8?B?MHVNLzk4cloxRWF1T0hnL2VqbXB0ay9UZTJhRjViU3kva3FDNm5MWjY4clUr?=
 =?utf-8?B?UWdTbEFGNXhDdTVyVkc2dXpoUHNxZFNQV0N6M0FpS0ZEazBhRFVhTEpDbC84?=
 =?utf-8?B?VzlCOUFCNk9PZlJTcTZ4aGc4Q3RTSWxZUSt5VldITjdURnEveTZ3VTl4RHFn?=
 =?utf-8?B?bHNLZUZYZFJhcWhSZHdseFd4T0lVWTFEakU3MVlISTZ6Y01pbHZBVmNrOUdo?=
 =?utf-8?B?S0ErM21SbWJJWTVEN2tDaEFyTUJwdnFVNDMzeDdCQi9xbU9oV0FYNm9KUk5l?=
 =?utf-8?B?c2F5TkRmK2VvQ3hFbVp3dnVVNnRJclhZNWExejY0eTdMY1FweWhybTAzaGVE?=
 =?utf-8?B?bStvWjYrbllZWFl2OGozTXNUTHBGcmljU3NqMnMxTE1EQzZoTloyc1dqVU12?=
 =?utf-8?B?NlFRWisxMlNmUHNlZThGVEVRRnQvZ2pYd2JyUDFSellDNldYeENVSUFYZTFn?=
 =?utf-8?B?YlJOb1QrcG5iYzZ3aTB5VEFyOHBIY1VsbFpQMTBTK1R1YVN3dDlCbzJCcUlo?=
 =?utf-8?B?OHQ1Z1RQVGdXN2NSdkNnTDFTQWhHdmhqNENhZGFZb0JqOFFpZXdvMnFrQXdJ?=
 =?utf-8?B?NTZGZ0N0Q0ZnYlJlZncrL3hISHBFUytKQ293clZmV3lYT2NCbFU0UVBTd2c4?=
 =?utf-8?B?WUJrSVRPazN3RlNOa042OWEwVG5DbkliMk9ybXY0eWZjbTlYYTc0VUVxaUtP?=
 =?utf-8?Q?xwnZ6+9j6HN0IwThHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fd38ee-c112-404b-1474-08df0405b965
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:37:54.3266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHgtCtOqLU5O8ennoc8dSdhxdbypqo1SOigVgujP8P+bwY4AngWBwJ3PDLUlGh5B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
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

On 8/26/26 19:58, Sunil Khatri wrote:
> rptr is a confusing variable name as it is a fence
> value written by the cp in the fence address and no
> where related to the rptr.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 09e2079cfdbd..e862b65f5366 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -148,13 +148,13 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>  	LIST_HEAD(to_be_signaled);
>  	struct dma_fence *fence;
>  	unsigned long flags;
> -	u64 rptr;
> +	u64 fence_val;
>  
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -	rptr = amdgpu_userq_fence_read(fence_drv);
> +	fence_val = amdgpu_userq_fence_read(fence_drv);
>  
>  	list_for_each_entry(userq_fence, &fence_drv->fences, link) {
> -		if (rptr < userq_fence->base.seqno)
> +		if (fence_val < userq_fence->base.seqno)
>  			break;
>  	}
>  

