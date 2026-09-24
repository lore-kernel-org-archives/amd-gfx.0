Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366CEC98314
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 07:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EC010F36F;
	Thu, 24 Sep 2026 07:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="niX66qnV";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7896410F364
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 07:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G33vQZryTpY2G/uGqNXdKW84hyV0AUO3U+YylIqv9OFaaYvipA7NDYi/LmUzfVE1V4Zbhnnu7sQSh9jwr4a/3/1ryLz7RpKTN3R8AuDzh7OQQu/DYlqED/9yAaNSBkIgpYPU9lNz5l9Q96nnK34S8VuVF7hzKa/QMXj0qsTalYnAJDuSsu2sbu7480px6LBTYeTj63I9MKmWj/ingDtr3bhTG9r/nsH4a5RCdCUj8tURegkSecX8DV7EGCmOZ0NpcpEFvyAUKfv5coFWYSYXDwJeavSBJwoe5jd3+v1jp4GkxUV7VsnnuYd29EU0xvysL5CCL1/Y3+5F9NGfUJAvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6TDofP2yr3ZFAt024YIe3AQ38PKTfvhqm625JviNWc=;
 b=HonkXVhpDJ/qqNcq90tZW4+e7MoY6MiEDkateFe2dgj6/StMFtVRyCPPPYyc1oaCRWF40WmCYwU4PWEmE1yqfLE/CGf7uL5C0/UnwQsyM0iSpQ6zzvS8dEonuADgG7x0Wf/rGC3K2b1nDOY7+UkM7zukjbKLHDGXzaSnw7WYSfciyRXWay6pKub2pVh/bXCMAnqA8JvovHgKLCa0FWn+Xq383RcYgZtZuV/sXCuriiP+LQgDvMcjV1zTnnw4xaYEltoDl8M5JVaIeBJeRtXPFvp6G91HYeBQnUMEoO0jaAAPD0E94kLSeb/AU+N5xl4G5om7T9D7bj5uDAqYgBM3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6TDofP2yr3ZFAt024YIe3AQ38PKTfvhqm625JviNWc=;
 b=niX66qnVIeD500Pncn2qIu/PVMpebgKDyqQSryO75N55XH+Ks6N68syRGbMDfDUS0QYWR1ynugpRPlfmPTUigIMB/2i2XhoEioG2L/U0QHeZp3mqGwBDCsnSDpiXR38w7fQDlUCMxsL34/NvfyCQap4z7P2lLaiyg3unmOWoR4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 07:41:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:41:34 +0000
Message-ID: <b4254043-2c62-4fa4-927f-ba84aa816560@amd.com>
Date: Thu, 24 Sep 2026 09:41:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: place VRAM-capable dma-buf imports in the
 PREEMPT domain
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20260923212838.1421843-1-mukul.joshi@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923212838.1421843-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 461e39ee-075a-4deb-fe48-08df1a0f41a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: kSzEuXCUccmGY6d4efpzYdirHTcP2dIZuD2cSHl12E8A0Ep1oRa1XlU19wJjKq14686MLsdtyTiiauVMk1RDxaUaS6n4X3Jsfs8zXc9qKr1yjF+CMvmRR9scIj9jEl81/95927e2Ye7OXlcQgk1RMNAgtPjqA+Tg6dZGTPQbJJvkBQN3PXSEn1W7N93yxm4Zz+Tnlj4DNdXIh4v384dnPo6Z33c5/NMwwTz5/zBTsDsDFlx+qAKplL56qPqDS7ttBB5jHzICM5SsXnbP+A+QfMrjTXKAEgxhQC1MYzeXGoIOtvDT4G7B9EXjBEI1dB5hkVMGJxcUd8fZ4EzQMapxyzt9QPYbnaxqsOzBm/q3k6JujP/l9v6MycLx8yq75c9dt+F/K6+1H7WfBU19U07xiTfbInmh4h/p+eUk7Jv5xcWWToMPh0J03HxLxOxtIPdvkeWU7jJd4FtpmXw9bhoAeVbrKioyJnweNUczYoyoOz4fusROe6jqWSToMlr/7Y/9NngIUkivU1bms1bJK/8IC3MzdLn9MfWL4qiWWRrWctAyIhzPUt21KEsQ4MakmltAQ6SuMlwCCJEfDXu7rFWidqh8N4qb27HguG4Oejp2iFMe3C3mTbN12cuvN6z4e4gzgcovSLYrePClr3yEgLnD644TRqh4ver6yUTuJ1KRp/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNWQ0VMa0NVQTZNQXQ2bGxEaDhSQUVpNXQycmROdUsrQnpsZGtXWGNyUE1R?=
 =?utf-8?B?cDJEMk5WSVZiRGE0aTB4YnJFUlorSXBVbitQQVlLZS9lSjdIMDd1dUdvS0lR?=
 =?utf-8?B?TkIyN3NDaGc0cFVuZkpPMjhZVHIzd0V1WUo0NjBZdDI2MzdTRWhOZ2lFa3o3?=
 =?utf-8?B?QlAxREhMV2VNbTdXTUM2T05KTXd0ZG92bE1LR0RJWkVzRVN1S05IT2VDaXZz?=
 =?utf-8?B?aFZNS0dPem92Y3dvSkhYMTJpME5KRGZ2VEp2Y3paS1VGMTd1K0NDblVLSzF5?=
 =?utf-8?B?WXptTmpxVUVvcGdHVEIyYXI1Nmkvbk1HdTRiSndQdzZKTVBsQTFOZjFDL2I5?=
 =?utf-8?B?cnlzVS9CR3EzY1F2QzE0dk9ieDc0L2xMc1doSW8yMlpzZUNRaEIvUWhMVVZs?=
 =?utf-8?B?eURuU1RXaUNpUElwbVN0akdid3dxMUl1R1pkbkkxMmNxaE8wNldNcW9YTDJa?=
 =?utf-8?B?REVaZTJEN2U4a0FTQ2E3bU4vV3pUOVVEZE5tb05abURBT0R0Y1lyL3V6NzA5?=
 =?utf-8?B?Q3VyQndFR1RIWE5pcE5GVE1Ba05qVEdxdGEvNE9ITlNwaW1EamVXZFZXRER6?=
 =?utf-8?B?Ky82M3FLRnZDbWVVRG5VUlRQWXNSZzZLLytHVTV0TmdFVlBuS0JRWWtDM1pq?=
 =?utf-8?B?bDhCV2F2NXpDTHZYVkdsc01QbmtpUkxSQjJzaXVmMTJsRjcrclp5bkx5cWRM?=
 =?utf-8?B?enZJV0ZmVitUdURzUGsrMUkwdDRLSmx0R0ZMZlpSdzR6dWJyZE4vY2NJM3RH?=
 =?utf-8?B?aXBDTlZBRDJUUzBrczh4RW5nSUJkT1VUNE9WU1pTTS9NeDJJQ3pEOEhJR2JK?=
 =?utf-8?B?ZTdjOXdEd2dwdWdQYTNOL1VCUjVSMzhDd3VmSDZIdnpXUDV4Nm45SUxCKytS?=
 =?utf-8?B?b2JlVE41ODRaQWo2c3lMY3Y1ZE8zVEgwLys5eEVoYk9XS0ovQi9sVVY5ZU5X?=
 =?utf-8?B?dm5qS3RkaHNIZmlBeEpGTVgydUxPRWRLNElWRXJwZWhFbk5VUVlCME5FSUht?=
 =?utf-8?B?c21maFl4RmJDUEZZZDBTMHIwczVrS2ZyUFRNYVJBVUVGRXpCMDRKaTNsbUdy?=
 =?utf-8?B?eHBYVHppWkhaYjJZYWpRTUpOTldSVVgzc3Nxay9DQkdDK3g3V2FpcTZaZXlm?=
 =?utf-8?B?T21YSWVvUnQ1WnJZMG9FREU3NkgzbzJBaHF4V2F3YjNwYVcvVzcydnc1czA2?=
 =?utf-8?B?Nk8wZU5SckNrWGpVQVcrOTFmOGc5WndrVVdRZDlsNWtlS0g2V1lHWERlWmdD?=
 =?utf-8?B?YnVQR1VuZjkzSWQrNEExZFV4bjhpRUVjem0welpTM3B5dEZ5bldaRGZObkhr?=
 =?utf-8?B?ZWhYTFpidDZ6SVJEUEJrRDFwWUltRjEwcUdLRCtwMWI4ZERveGpCSi83eVNE?=
 =?utf-8?B?MU1JVmhNTEs2bWF3dnlvcGRSemtkekpkZjdDazNPTXdETFJYWlp4YWkxazBY?=
 =?utf-8?B?cnVVc1BFMnl2dVNETE1xL2dkTmt1K1NqOTdOWUNmTEFTRE1yZVBldkRmcU5i?=
 =?utf-8?B?dDN3S0lMNmtWTVhySXhTdlJnTE1ZVFRKSzhHeExVSEJ1cWFZRGsrS0ltdysw?=
 =?utf-8?B?VHY4SFREMk1wbWlIa0c2a3VRS1pCZ2krOUovV0VNQWZQVG9uMGhBNnZsTTM0?=
 =?utf-8?B?NEtBa1U3djNuNVowV2xEVENhUVJHd3V2UDZHOVY1bG9SZHdtZlZYVHNjUHoy?=
 =?utf-8?B?eEZEUjlwMUdSdkhPdFJYc3ltbTBjUUM1RTR5K3lsS0VwcVhiS2R6VkFWYjVs?=
 =?utf-8?B?NDN6YzZhdkJNMXl5WHFmVmdSZW1GMDM3c05RRXAwbG5EdytwRlVTVVBOWHda?=
 =?utf-8?B?YTcvQnp6ZHhSUGJSdm0ycFpSNTBraHRaMmFycFlEZkpzMG9XSUZ5RXNTdEhY?=
 =?utf-8?B?WXNDR2hGaEZNTHVXenJOL2dkOWEybFI1TnNac2JiUGNZb1BBeVpwZmlEUTFv?=
 =?utf-8?B?ak1Jd2EydFp2TllVY3JINWlmdDVETFR4UkFqWVZ3UXgvcjM3WFhhZUJYb3Jl?=
 =?utf-8?B?Qm1jY0d4SUY2K2tTYVA0Mnh5L3k2bWxySVlwOUVmTDE1YWs1Ly9yTEZOcWpM?=
 =?utf-8?B?cHFqamszcDJJeHlUU0tZcnRQUkF2dllRTER2S05SVjNIWFBENHBxWXh3TzdU?=
 =?utf-8?B?bHhaQmNocXlmR0QzRGhqdGhpSU9oNlpIMzUyVVhxRGhtRGEvV1hhTXNZb3VK?=
 =?utf-8?B?Tmg1K3BXY1pnYTZvajRzeUJBZzA3NWZQckdGZDZWTGFyOEpHZ01wRmVXUG15?=
 =?utf-8?B?TmZKak51N3VIUmpwS0tpZ3dCSnhraWFrV0h5bnRvMElDV1hhbHd3bGtWQ1Bu?=
 =?utf-8?Q?KHe0iTxymWrJ9mWglE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461e39ee-075a-4deb-fe48-08df1a0f41a9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:41:34.3297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lC0vZYjaotw/AOLD4kPjMjqCx/m3npo+MXOhs1oH+9JI3qIGQ/ipWWSV5SsU5ibf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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



On 9/23/26 23:28, Mukul Joshi wrote:
> An imported dma-buf BO backed by a VRAM-capable exporter holds no host
> pages of its own, yet when validated into TTM_PL_TT it is charged against
> the GTT page budget; importing many such buffers can exhaust that budget
> and fail with -ENOMEM even though no host memory is used. Set
> AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMPT
> domain instead, which is GTT-like and still bound (keeping the exporter
> resident) but carries no host-page limit.
> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 4031ebe075d8..5bac2474af03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>  					 AMDGPU_GEM_CREATE_COHERENT |
>  					 AMDGPU_GEM_CREATE_EXT_COHERENT |
>  					 AMDGPU_GEM_CREATE_UNCACHED);
> +
> +		/*
> +		 * A VRAM-capable import is backed by the exporter's device
> +		 * memory, not host pages of its own. Place it in the PREEMPT
> +		 * domain (GTT-like, but with no host-page budget) so many such
> +		 * imports cannot exhaust the GTT limit.
> +		 */
> +		if (other->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
> +			flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;

You also need to check if the attachment results in P2P access, otherwise the DMA-buf will be moved to system memory.

Take a look at the amdgpu_gem_prime_import(), since the BO is not published yet just unconditionally clearing the AMDGPU_GEM_CREATE_PREEMPTIBLE flag there again should do the trick.

Apart from that looks good to me,
Christian.

>  	}
>  
>  	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,

