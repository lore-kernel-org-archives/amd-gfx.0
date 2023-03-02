Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38BEC678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 21:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD0210E579;
	Thu,  2 Mar 2023 21:39:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB3510E579
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 21:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l91f3+HuyN9te+/V4qrdn8V8HCFSCWsBJjIJeEpN81MqhUMOk1OkXkSYBPYbowGaH0D4Lf6hpYW7o9o+1nQFjihSSAPnIhdksvNfdFMiNmM+cH9pnCEcV2n51hhs1i15stx+FxSarz1cb133SFAhtEAG5clEGvM91shE8d773uw9xFE+s6PVU4N0Xo3XqOEbeci0Hd4EHOYPZ70fJoC2OiZqxsrJia9i7c2NWq/gtOZDrQYxsZ8v9Vy9YfswJPpEOu5aeysyCQleVK90CohDvt2GnArJR7eCdhW3dfTxaGcs9Jgo2REYjdIKhh3dVz3ibUD8Z2DEb3Ij7WUGN6bhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8HnxjXYZy9wR2C1jRoGQtD2y9zWIjDBSw/ro0VX3yE=;
 b=La+8tpb4rBe9BUNh8J7WGhAf6JDsZ2hn2+hqBU7NQm6aqffIHHyo0DRbzuAszINqRG9a7pTtzycDWA+YtnLHN7Oe0mW+UVrdCx+sYSX55/IeyTKn18g0axJC56a8Bzgz9Aa4IHAJM5beDu8pDQiLY5cZt2iEPCkEqrTcMXEX9CkcDCfMtn84rt+gniKsPoFlgJbsak7YmEPP57Gm8Gh7ThxAscw31UK/xv7EOD9LcvINrOSjNZ1RDaNDQXhTNLKPTnFwn80BevFiOcXWYLhopO2QkL55z35+aZsqOC4wN7ECzt6hK7MMo4Hx1018ZB/hKLyessNk3LoDCF2hh7/r6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8HnxjXYZy9wR2C1jRoGQtD2y9zWIjDBSw/ro0VX3yE=;
 b=bJfLHsCncjhKmZih8suISLqFwgTO0GaPrH8MGX6stsndo2GWKyQbstx9zdH56g0CvtJuwJwyXwl0uGWlB65fuPH3IY4CkfdBKd5pdWeIOImnZq7CHNFLMXiAVbdPcZQGdj7Tfqes8e2ZMWOA+ItzTKuQwZKqWHcB9xEMqXFEEUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 21:39:13 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 21:39:13 +0000
Message-ID: <aaf8d1f4-c0fc-2b48-24e8-39e43ebb526d@amd.com>
Date: Thu, 2 Mar 2023 16:39:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: avoid restore process run into dead loop.
Content-Language: en-US
To: Gang Ba <gaba@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230302181555.10796-1-gaba@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230302181555.10796-1-gaba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f63df20-d41d-4f96-afcf-08db1b6690cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMqeJWVozAsAswsKRdPtGpGLLKb4fYlnfiDSfaQ3N5G2CBnHCLNrMllor2s/chhPASLerVfWuhRM4iOSXmR4/rwW4zw+mgAViTAXc5jh8xjG+PjNNs28VrF6jDQohmm+i/79kyR86nWRVSGiviejPVYEn7lXdk1/O9Az5cQI5+gL9NNRji2gcpDxH/9SloaX57i5Bnv0wWrhJzDOqb0l/wQRyYZFrvOOOoHNDUNhUVpfIWvNShndMqcPsQhtDwwY2XuXjoWMYnzY0Ng3qyW/xsTgIW4Y4A7Az68OEqExd69wYcKBZV/xgmntrOaajTuzMWRdYKRMSpuOaVwcFD1KBdV9TwhXnqjnzUpPTXSLkhKOuztwBgh7F0nRCeut3rsSGhCDkYu/sdzrYJxmfmpG82NXSunFQA6+eHhr6VyL7f+s+1GJazTZAf0W9JlTD+8BVUfdxacCRKiDYcfBbAs1Xww62tGXFJ9Hxw/2WmYygj8TSlaf4GN68nC1SyVwOp8EZY9uEMEqE/mpum8ZMw9h8u6sHcabPdahpA5MmEjpZr7nSFSoqEcs8SasIPtUPeFQTtCCmMM83GEd/invUEPtUVzv34SZGxgjBDLYfebM3h2p7s1DJ3rxjS9c8LerbcKWAf+bevxcLEfe/ocIoZH6POSHbagilJRC0GxdxZbSXatXmNPACLb16Yg+XQVLFnEAPfBzqGJUFDYS545QroFsWZMzzcRCORu8jOncBUZsBRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199018)(83380400001)(31686004)(36756003)(38100700002)(478600001)(8936002)(5660300002)(66556008)(86362001)(31696002)(26005)(186003)(2616005)(6486002)(6506007)(6512007)(8676002)(66476007)(2906002)(66946007)(44832011)(316002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG9HeXpTUzd4T1ZGQWt1VjBWMGwycmdDNXJ1K21icE96Mm5Bc0JFQ1VXRCtO?=
 =?utf-8?B?dC9IZDdqejBPYSsreDRmenZiemI1L3dsZzIycXZmblNRdUh0MitIdlY1K2Zl?=
 =?utf-8?B?UnpRZUZ3TzV4V01YeENNSE9hcmQ0Y29BRkJJUnNEWmlOZGdadGZZb3grS1Qy?=
 =?utf-8?B?YXQwRW9HSGlzamUzY0FhOXlHeGVtQm9tcDdLMXdqWmUxaFFqQWNJaWJXS1RT?=
 =?utf-8?B?eW5YL1hrTmx3Q0hiTTE0VU1RYisvUXBaZUwvTTVEMXN4WWwxTG9QQlNGaFhL?=
 =?utf-8?B?VnBwZ0FINHdHYm9TdzNHck1WM2dUc3I4U0c5NGVSYTJDcVhYQWdoaUJ1aG5v?=
 =?utf-8?B?ZERtTk9CZ1BOcHNRR2Z2cTlabFFmUnB4N0phelBwMloyYkRwS1lXQXhyaWJl?=
 =?utf-8?B?dVlxeVFWSDJoQ00ydElkZGVYbzRuNkZQVlhkOElEN2M1WkNXSVdGWXhwRXBu?=
 =?utf-8?B?Q2RLdVozTXk0K3ViSlFDY3dkT0JVNTVwWmJ1UVZBbTh1WWU3c1dhTXlMR1J2?=
 =?utf-8?B?ckh4R3JkV2FaTmYyN1g4MThKV0dWdGNHK2s2TDlCTjdoUUtCZFljcTNwcEpC?=
 =?utf-8?B?cUgwWDJPWThuWmI5QU9SS2lHczJKNHUxOEVlUEF5azMxMkU2UVZoMmJLbUpE?=
 =?utf-8?B?ek1hUGxJOWJVZ2ZDQW1CUWVYcHlWWkkwcnNtZFFQTEJmME5hRTl3RFRyOTRF?=
 =?utf-8?B?VzlkYk1yMyt1T3g1UC9PMXYwNnJVYU5vSVpYT0ZWUXRTRFdOa0YvY0ZKMDJu?=
 =?utf-8?B?UzZocmk0NnNva2diUkNyUFZMQVRCV3pJQ2IvT0R4MjcydDN4OCt4SGNDdjU0?=
 =?utf-8?B?MmVYVFdod2JubWhadnlHUVo2NzlLaDVDT1dJREdJOHRyQW11cE85TjdBT3VJ?=
 =?utf-8?B?TjVTazNJU2NXSjg3eWFRN3AzM2ZRaXlQbUpZQmNmcFRLajJnY1pwc0ltME5i?=
 =?utf-8?B?eE1BZ290V0V0K1VoSFpOZnVYV1VpT2ZVbDNOcnBiUExJOXYyRDNhTG5IMmwz?=
 =?utf-8?B?YjhLUGNHSE83cXJUa3BkM3JTZi93Yzh6dHRPK3ZvOE5hQUkvb2U2cjhzbXUx?=
 =?utf-8?B?U1BaUjJ1K0dCSWdvTGZGK08xMW5ENWl0dCsrNDRUQ25VMDVlWnJmNGx6d3JP?=
 =?utf-8?B?SDd2VldWUnNvM0JvdTZoNkJYVjlGYjkrMHJxcVFtRnpzOThiQnR6Z0RwSzdN?=
 =?utf-8?B?bXNaNXVyTUthQm94UW9Ud2FoMlNENjBwc2VoM21XcEV4YnFSaUdSeEd6VlQ2?=
 =?utf-8?B?dVU5djhaZEhYSDA2WGJ2YzRSdkcrRWkxUjI5Y0wrZnYvMUVSejB1WlRGNXBx?=
 =?utf-8?B?eDA4SFlFUjU0OUtQVXI3dVNGQVQxVnhCaDlEN0xEY2dSVTg4UnF0WnhrOE94?=
 =?utf-8?B?dFFTeTVSazVWc3grb1hVNVdZc0dYVFVSWnlyNGlqTFNBMmt5Wng3Rlo4cDBw?=
 =?utf-8?B?R1I2Q2xZczNoeGRjOEdzNXBDaCt4LzRzNVMrNDBlMTZqTVpGd2lDMXFHRGNy?=
 =?utf-8?B?bDhxOEh0SDl2R01BaUFvbkxrWXFDeXRJVEdTZkZyVllza3dlKzRZMHFuNjh6?=
 =?utf-8?B?TllBWklaZm1LaVYxK2RRd2dqbllTeVR0UXVCVDhlTnFuTGJoeGV4NkVWUGxv?=
 =?utf-8?B?NGU0b0RMUGMrRmw1UXA3bnpTWjdWcFlBZE4ybGMwTlJsZVdiYk52U2xkV01U?=
 =?utf-8?B?allYV0lGaUFQYjE1UVNIQ2F2VE9oZHFzb2FodzdTZU4vYXIwQi9RWk5ueXlz?=
 =?utf-8?B?YW03d2E0amJGaWlRUHlaMEN1ckpza25hdm11QlBiYjNFRUFpOHV6Mk5EekJv?=
 =?utf-8?B?VjRWRTBxdmpXVEVOZm1LK21GeVVZbHI2QU1PbG43bTFXQ0F5Q3Y2RmprdUlR?=
 =?utf-8?B?K1NRUlE0MmZoVU51T0JKUHh2T3VzdW5JazZjNkhqUU5VdlRoVkh2S1FHeWJE?=
 =?utf-8?B?TGVKcnZkT3lQOGJacC9hZDNMb2pXZTFEcURtZnNXeU0zeTNoQmdKZWttbGFE?=
 =?utf-8?B?amR4RUFUWkxPNkd5Zi9qbjdiYnUwckI2Nlk3MnI4MVovdVRCdUozR3hrOEw0?=
 =?utf-8?B?V01PN2xTdXJUTjFSRlMwMmk5Z3luTmF6OWtrQTZ0UFhtd004VVk1RzRLYjJV?=
 =?utf-8?Q?piFCNBwndao2v5WPGT4CEr1yi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f63df20-d41d-4f96-afcf-08db1b6690cc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:39:13.4098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nW7OMm5hOA7lqfVWTfLqZkWrtfxgam+FSjj0YOOlSjyrjmBuILnHAiNgpIYyvAjVH91+kosGjiFEbW+3bt/Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
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

Am 2023-03-02 um 13:15 schrieb Gang Ba:
> In restore process worker, pinned BO cause update PTE fail, then
> the function re-schedule the restore_work. This will generate dead loop.
>
> Signed-off-by: Gang Ba <gaba@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4b46b936a804..a38be83e486e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2586,7 +2586,7 @@ int amdgpu_amdkfd_gpuvm_export_ipc_obj(struct amdgpu_device *adev, void *vm,
>   	struct dma_buf *dmabuf;
>   	int r;
>   
> -	if (!adev|| !vm || !mem)
> +	if (!adev || !vm || !mem)
>   		return -EINVAL;
>   
>   	mutex_lock(&mem->lock);
> @@ -3170,6 +3170,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
>   			if (!attachment->is_mapped)
>   				continue;
>   
> +			if (attachment->bo_va->base.bo->tbo.pin_count)
> +				continue;
> +
>   			kfd_mem_dmaunmap_attachment(mem, attachment);
>   			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
>   			if (ret) {
