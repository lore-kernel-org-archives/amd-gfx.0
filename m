Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA1AD3E189
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 19:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3801C10E232;
	Fri, 18 Oct 2024 19:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U2eX2x9u";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D745410E232
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 19:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQkjJAATzUrrYnzyuKfNYTABiLLSYKycwdRZDSvmEfD8AaMtbyT5gwqDChRzYglKyJLe8BTntR1SHCO+HZ9S7S3WNLGlGioSEqWF7m63S0jCSRokDrEsjAyR+vnoNocc96xmwtUSmnj5dO93tjqxl4nRph29BqPHoE0kycclUVbw65MUqgyGY48c/TQpdMYKWs9YjnXE/VqYDdYx1JNA82r2umKRUgUORyq/gFyoMmfGaXBQYm/nWcrGvg4mqrKgOMP7BKZLJju6PiRowWJVxdIDXKh2hr/U+/xchERGeeoO+4sPjd4R9IiJnQoLlXtvKMCMV6j8ZNrpAGYV//egWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZOGj4wRhEV6m550tikn3zMp38To8V7keP5UB65m7QY=;
 b=pKHfOZFAPi1+bjeZH49GK7AIPgtMyEETCxfbX50EMImEKfeaWesIx78+zWCoidslRKiGkpQ0jaMRJhBMkLExSsV+lWdxCbDmonPes6slJdP3lm6lNnXrQrSRqIaXyMkmhNOpLl/tyBMa/9psJpjQZUdTmvLSb0azuaR/8jJFncMtMc9KdaGvhufV1E2TbRgAb9ipKobWEb6FIVj5vaqJN7WQjNS1VKhXEmquF42HRlVbLtYtNJ8Cm8ITQRUOMedi2qZ+PZIOGzpEqYbtMwROocE0ycraexqIVV+piDLvxTpO97J5Y/mq1+l8x0+A9ohZQik3efH+ZRPKZbenzeiyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZOGj4wRhEV6m550tikn3zMp38To8V7keP5UB65m7QY=;
 b=U2eX2x9uPbVFV872odXmYnPBMEXba2Qb1eX6J7NMq4YqQeDjDGi5JHpOMN7iMoecU12PmCperTSuaNKwPzQHBhKAWMtZpVsQ+ic7O4NBFvMozHt9QDNW9k/+kOnQW3WHZ79xTxyHplipxKaAQnqORJNrxh+3A1I8sIgv2EWFeq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 19:16:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 19:16:27 +0000
Message-ID: <a4287c13-6006-4739-a2f3-8c14cd085f05@amd.com>
Date: Fri, 18 Oct 2024 15:16:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use SPX as default in partition config
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Asad.Kamal@amd.com
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Hao Zhou <hao.zhou@amd.com>
References: <20241014091911.3036389-1-lijo.lazar@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241014091911.3036389-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7746f8-d936-400b-6ca2-08dcefa95d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU9Wb1d2UGJoSXBlVFpMb1FNQzNiWUhKZ21xcWtlT1c3b1RNM0pzZVNBRjBT?=
 =?utf-8?B?Q1FBcnlhOStERlUwVFVZaGxLTVRUTzYzRjdsUXFlcVpqMW5lY0lRc3FZVDJG?=
 =?utf-8?B?TnJsYjFEbFVCRWZCUHRzWW5nN1RBWEZoYWZIUGZqYVMxQWZFWVI2M0F0cS9Y?=
 =?utf-8?B?RXRMVkx2OFkvcXR0QmV5TEJjaktxV2dFbnZBdGx2ZW1FaTlhb1dSRC90dHhT?=
 =?utf-8?B?aEIzRHJ0SWMyRllNRml5TmRieWQwZ0syQjVGeE9WYWNxb1dJTGJvWG1sc3JH?=
 =?utf-8?B?NU12QWFvdVRIZTZMUWtFd1p2bVpqUnYwUzdXOHZXNDJzZkNweXNVOE9zMHdj?=
 =?utf-8?B?M2trcXJCUUZWTDhTU24wL2taQzFLN2E0QytHTFdIWW94d250ZW1wWUNqL0lG?=
 =?utf-8?B?UHVxN1lNdmpuaFd6YVhKNU9LaHNQc3JaVlQ3R1NSck9aSlU3dVBTeDZ2TmRZ?=
 =?utf-8?B?Znlyams0SFJYM1lNRHF6WkQ0NkRCSm1reTZTcFZtVnBuZTBJT2NQUFI2NXdS?=
 =?utf-8?B?NjMwUGM0Mk0xcHpwUFNGbnlOL1o5dllLTThGUU0vNVgwNE5zVWI5VE51a2Ur?=
 =?utf-8?B?TTN3OUJsMVBVQzkveUkrSjZnUmtUZzRxbUV0MWJYa1VkYWxFNEhTNDIzSGtY?=
 =?utf-8?B?VFFOS2l5SmpLdUVnRU0rZFY1blNJRzh5UmlpSFk4NEJpTGZINjNFYnpYNnJB?=
 =?utf-8?B?SUY4SjVjYUJ2SnFFcUwzUzJuNGZUNGNQK3A3emtqdlBCa0RZUWRpL2ZZa2px?=
 =?utf-8?B?WVRkMVF2RmsyQ2tIYmVkQUs4bFkzNHU1U1oxbmRyU2g3K0FNdkxUdWxQMFhO?=
 =?utf-8?B?NjBoOWVQb0JsOEFpT1granZ2MnhjWDZML3hJLzdnOE8wcXpNTm1LdUZoR1ZT?=
 =?utf-8?B?UnZwYXc4TEJQNzZNbDY3b1lSR3o4eVlReUdJTXRnejZ2SkJDSkZsakRqdnZi?=
 =?utf-8?B?VHNwd2tLbWFSWTM1aXJmdFIwRytuU0w2WmRkM05SV1N5NDZTRk9xamZ3ckN0?=
 =?utf-8?B?T3BlRTcxazdIYzNMWFV6YzVBWjVMQmdhV1FzUmdGUWxRU3ZRVjltN01IRjB5?=
 =?utf-8?B?Rk10Q1FtVDI0Ykxyb1dZbVZTOHdSRzFyd0lLV0syREwxc2d3eThoYTZrQkxI?=
 =?utf-8?B?ZVRJTFBFQjYwbjI2RWZ6dXN6Vk9IYzN4MDhoaXA1SDhIMlFsUFY2dFNiSWVy?=
 =?utf-8?B?aXF5SWJodEtQNmk4ZGpjVFZxRWc5UHplaWhWaSszRTRpeW05RlFIMzI5cFY4?=
 =?utf-8?B?c3dpK0R4MG4yZXUweVIwa3orSmlpZTRjT1ltQktCeHJsZFNwNWVVVy8xbTFm?=
 =?utf-8?B?LzVSZXJHbitRZ0dLYnJIN3hlRkRNSVR0UHdKelBjUFpHRThmVlF6dERnQU50?=
 =?utf-8?B?ZzNjeHNZV0YwcHN0emVmaFJjSzRRZHdQYVh4N254M0VORU4rK1lKOFJoNG8w?=
 =?utf-8?B?aDJHYTkzenBnNUpjKzduREVTZ05ZQkJST3RVTnhsOVQ3SWcrbFUvZ21MVVk5?=
 =?utf-8?B?WmExZW5jQXFIVWJicWJiNXFqZ1ZETGpyK2szVzZrbHZkbmVkMXRuWFVZU2Ro?=
 =?utf-8?B?c1RQcXF2RGpIK2U0YStqTXJMZzVocisxWU9PbjBQMTZ5elpXenUrNUZzSGZN?=
 =?utf-8?B?a2UzanBHdFpDYW1IdHdmbjg1U21ZUi9TbDErSWlOZWZpM1JXcE9mZCtaSGxv?=
 =?utf-8?B?bEpQRU16TlZTYTF1ZEM5OXZHK3FvTWJkL3R4WTE0R0x1OGpVU1ZkWG5VU20v?=
 =?utf-8?Q?/1nXebH9dFcd7kY8zBA1szqPdcS1v3RQnbMDy3Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWtHTG55MjNqUDYyY29TVHpSbjR1NDAwUnVlaFFJUGw2MGdRR1E0U1NnYlAv?=
 =?utf-8?B?ZEtFVDIzcDVwRXFjS093Q3UzeXgvME5XRDBrQWt6SFVOcHBoQUVtbmNBTTlB?=
 =?utf-8?B?Vm54bTJEamJRMGtWbjhKUnZYOUhKOFZaNzZEY042dEhoeHQ5WUVjRkxVdDJa?=
 =?utf-8?B?TG95dnJFRG5lcEp0RUpKU0dlZEltK1JmdDV1cUFCQUhkSitUQnREekc1QmZw?=
 =?utf-8?B?d3BxZSt6amx0ZDJ5eXpCTy82NFdTekp2eTJkeWRHbmhReDFEVDcxQk82Mkx4?=
 =?utf-8?B?YzExTC9zY2FJMlJNR3FjM2Z1MUlSYWZ5OHErVmFWMU1SVGo1YUJpS09rdWpq?=
 =?utf-8?B?c1FocGMzbjFYRmE4SDdBMUpKaDdNbURHWHhRa0NQdXZaOU5IRG8wVWhEUUlu?=
 =?utf-8?B?V3pCUmM2QXlUODVIUmdiMGlpVVpmRThaRHU1dXUxM1Zrb29pcm1IeElDRGpE?=
 =?utf-8?B?SjErOEl1RGtvZjhCeGR2eWFmaXhBcms5ODVraDEvNUJtVUYwQXd0MTVDV3BN?=
 =?utf-8?B?bzJkQVMxcXhseEpvTjBodUttY1FaWlQzMytrWEhlNDhQb1REMHA5UnZyaUc3?=
 =?utf-8?B?TWdSb3RHOHhYODNTZDhZV0V1MmVDRmN4T0trRjg3Zmt2NWRjMVZMT0lHaXRE?=
 =?utf-8?B?QkJ5akZwc256K3h1cFc1MHN0MXN6SUpCNllvTzArdVBlYVJXZ3Zxb05MWkRJ?=
 =?utf-8?B?aE9RaGJ4am1RSzlEeVdrUWp4cmZmUTdPVFhidy9RWXVWb0hsV1R0L0VyNml0?=
 =?utf-8?B?eTY2UUhNQ2ZqcjRiQTdaTTVMQnQ4b3REbUtVY2RXQUJEU2ZieWFpcWtFb3Zo?=
 =?utf-8?B?WVN1YWc1QkhNaU90b3BnQ1h6QjNZZHcvRVlnOXl2SFBOcjh3SGo5b20vcXl2?=
 =?utf-8?B?d2RkY1RBMFhZL2l4bkNwOFlLanM4QmRkRnJ5Y21aamx0RmRIVkxnOWZnYWxM?=
 =?utf-8?B?andoeEpqYkQ0RVlvUmUyOU9tSHcwWkM0VWI0MHBWNk52VzFEZXlwQWtibWlE?=
 =?utf-8?B?Tm9ONUsxTlpQdFc3aW54Q052N1BYdENIOXlCZjRLNFhieDdRNjU5dnlOZTAx?=
 =?utf-8?B?WkVZcUExa2prMEhhVnlJS2VWbnpYNFhYQ0Z3VGZzclpienFxZzNXeTFTRmd1?=
 =?utf-8?B?dTU3RW5HeiszTllBV3pJb1lRY3BSdnFQSVNuQTcyRmorbGQ0cG5lZ3ZUaFlU?=
 =?utf-8?B?bGRlK1VKV3RHOVFZY2RnNU9DMmJvRDNXYmpKclJCQnpOUkxlMG5CNlIzT2ll?=
 =?utf-8?B?cnVoYUVldXNxWXo0MjVCV3lyOXdsRnJ3NzVpeVJrSy8zdGhtVXU3d2V6a2h2?=
 =?utf-8?B?cGRpcDRPRTYvc0V6dDhrSk9za1Q4dURUQlhHVXJtZ2NyTURCeGtuMUZJa3JG?=
 =?utf-8?B?UGd6QUhmMDNlTzkzRUZmMUdQcHFLUkJzVy8vT0s1bzNJbEtpQUYrWlBtQ1Y5?=
 =?utf-8?B?SG1VV2Z3TlVwZXpNQlVqU21rQmd6WnlvRG0vVzVFRzZsWEMzaGNjSEZNVHpO?=
 =?utf-8?B?UVNJTnlHbUxVWWt0L1lFTWorK1VMVWdSVzJxdGczdlZkWXVCVGpkRHRsUmls?=
 =?utf-8?B?Z3dBUy93ZkY5RmxjcTFGUXVNRjU0NENVTUFYNC9NU0R2WnNIK0UvVXV3MEdv?=
 =?utf-8?B?VkVRbCtHMXM3N3U2SGVlU3c2eWFnOWUwdHFlTnliNFJuSU5IYzgxTUJFTG1Z?=
 =?utf-8?B?a2FZZGhoYWdUMEhsUVkvMXdmZ0ltT2xXTzZjMVFnWWtvbW9pRC90Rnc2UC9x?=
 =?utf-8?B?RXNwaDVYeUpaVTExVVJEMisrTXY2MEZuNjdDaTF4d1pFVW8zdDdzc2Z3L3F0?=
 =?utf-8?B?aTE5MjBPTE9uS1BwSnB3MGI5ZHpvanZ4Zks4c0JXOWQrdjJVQzRnZVA2QjRI?=
 =?utf-8?B?RUR5cHR3c0QrMTVMVGduL3B2RVFkckpTeHBRSGpHS0lnVzlyR2tUdXo4Z1hv?=
 =?utf-8?B?UVVMdzZIQ2pCRUp1a1AvdmhqajNOVkxGQ1JnY014Sy8wTTdUMlE5VkVZanhy?=
 =?utf-8?B?VWVQcjY5eVFMc20yM3dHdzRqWm15RlBjRnpSWGxrbzNxcXd5TmkyS0RnbGls?=
 =?utf-8?B?b29jVytHQkRGTjdYOVlXV3RKK2N6QVNrbSsrbVoxa2plSDFEc0xRUlg5NUJQ?=
 =?utf-8?Q?c5X+faWdptlnpYtLu58A28QaL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7746f8-d936-400b-6ca2-08dcefa95d85
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:16:27.8613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1GS4AaJ+CpLgTnBD0yv8oMg5DhOBg9hYsaRKfSswjic9dt44QwvwdWL12iehKFMsTMw1p0EgClwtspPlH4TAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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


On 2024-10-14 05:19, Lijo Lazar wrote:
> In certain cases - ex: when a reset is required on initialization - XCP
> manager won't have a valid partition mode. In such cases, use SPX as the
> default selected mode for which partition configuration details are
> populated.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reported-by: Hao Zhou <hao.zhou@amd.com>
>
> Fixes: c7de57033d9b ("drm/amdgpu: Add sysfs nodes to get xcp details")
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 111bf897e72e..83a16918ea76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -606,7 +606,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_xcp_res_details *xcp_res;
>   	struct amdgpu_xcp_cfg *xcp_cfg;
> -	int i, r, j, rid;
> +	int i, r, j, rid, mode;
>   
>   	if (!adev->xcp_mgr)
>   		return;
> @@ -625,11 +625,15 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
>   	if (r)
>   		goto err1;
>   
> -	r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, xcp_cfg->xcp_mgr->mode, xcp_cfg);
> +	mode = (xcp_cfg->xcp_mgr->mode ==
> +		AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
> +		       AMDGPU_SPX_PARTITION_MODE :
> +		       xcp_cfg->xcp_mgr->mode;

Shouldn't this depend on the memory partition mode as well? You must 
have at least as many compute partitions as memory partitions because 
each compute partition can only use a single memory partition.

Regards,
   Felix


> +	r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
>   	if (r)
>   		goto err1;
>   
> -	xcp_cfg->mode = xcp_cfg->xcp_mgr->mode;
> +	xcp_cfg->mode = mode;
>   	for (i = 0; i < xcp_cfg->num_res; i++) {
>   		xcp_res = &xcp_cfg->xcp_res[i];
>   		rid = xcp_res->id;
