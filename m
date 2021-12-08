Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FE4C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 18:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29A06E0EB;
	Wed,  8 Dec 2021 18:20:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0335C6E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 18:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUMcLHaZkqL81Z4WdmkCupFHkTB31J9/GTVQJjaLU3Mm5wvm3918arrGuiO0B7REKZjKTTiRiYzaeFrxmudGmzO43+F6aFwxB6fiFjQ8y9vreJdY2MTyVt7Hbj61iHgaE1mSN9HJe736M520mzLJ7aKBpet1ak966Hj2d7eOW3nZCDZrNqu5BIf8+C9+TVIU6qoRUrnG2+tIZrsEgO/u6azlfxjIgS4jfMV0VN5K4E4zSmVoqjYy+AlouC9QpY4sX0pHk+r2ccEp/HWrJkt3JJuL5T1MV6WSIv7ckvGI0SHC4WSHpd86hQ9C5WtqAV6o2bcRuBaa8loML+MDMPcNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf9Oxh8CxpLH7IkWc7rTdCHD1ds7rM9fQXelFQ7BmwU=;
 b=BlYf8WLsY4CtoW00lWYS4oKqQhbyvQGWBcegAENKhduosAVR/pnntZNrmI+Gs+M9rVp361UuPIb/Ev+bN8W1nKIWc2UQud0jsMguyPIi3b1SXBSNSLZ0YS9Q4o/Yfok8+/j/lfw4QgeekFnO+SU8W8fWdA393NFvLmzck4ffDoME8sO8hqspx+TLk6UNmp1V7b2jJ0GxKSZ85X8r/2cxMYZvqmQ8b/Gtysthj18/Nx1mqOoW6I5BWqPPDyzxg0+z3ZgZlw9Qfk+n/xw+EWxrpKGmc5jOmJgsOIYq0iepxXKIVEFybqB4voNVflnOxNWwcDgGJVdNyGLzGZg8YiKVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf9Oxh8CxpLH7IkWc7rTdCHD1ds7rM9fQXelFQ7BmwU=;
 b=Zn+kSsHWW4U8v6DyugKwwEYkw2KINJ/6eciQLCY2td0nCSKcMBg3qSvQysieJZPqOxU2jVTWmZpwKeOYXo8fwMaltrTkKxSpvTDkC5wu2paY1+FYIX2rid7FZBE8MWDv0TZy/QfX1c0+LMFIvpz6NdnaBEjzAhh9m+K3mbVHM4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 18:20:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 18:20:10 +0000
Subject: Re: [PATCH 09/10] drm/amdgpu: remove unnecessary variables
To: Isabella Basso <isabbasso@riseup.net>, alexander.deucher@amd.com,
 christian.koenig@amd.com, daniel@ffwll.ch, harry.wentland@amd.com,
 Rodrigo.Siqueira@amd.com
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-10-isabbasso@riseup.net>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5b052fa0-6999-9977-d0bc-24d9a17aefbd@amd.com>
Date: Wed, 8 Dec 2021 13:20:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211208012529.372478-10-isabbasso@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Wed, 8 Dec 2021 18:20:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8815c458-f1bd-4dce-c72e-08d9ba775e9f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5145:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB514578CA96194DF583B9A929926F9@BN9PR12MB5145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FPKksII7uOGaXT27gx1yvEhsmQQLvCDcp/gFbzrIA3pQmgUWw9aNcpB142uow7h3pC441nj7azCWBbiCMkxjvDdFYOPB0nexd6nuj+tnj540pnDjQh/UI3GM66wKmQutPEw2lFjGyxV/e+rid7E2GXdMQ7zIj5gNQ0KqRXRcz1WH0RbvAt0V2Sjd7mpn2bKOjwy2AYwpIqdAt2ROBswBdlqwxQ7w/WsOgmaKAAZrcPj0xEgqZLdyZ83B7celKgivyyMy2sVl9WbAsfX/u/8IGoeTvbSsIBeR/mnkNrebPZh6L6IYGb9oVQWL7u90dU9iJJjKcQ/QkcnneBDNst1vKjjKtulOaSwIKk34XSYImA121ay+ttgiFhCe3/TnrHkSZyLolKfa/bR6QXze4Ae/exaD1x2faFOpwsdSpdXNY8lREyisaqLTi7vQtUnPBlsuCqQSx7OAA/ePgM/HyBNE2Le9viBMYh3seQIgqcD8ovzsXr6LWAqvCLleH0ibEZB9IRHCJ2aBvU3KGACFg6L+HR5zyGIgb6iCt3JGZOSs2ILGZwfhuatRpPv07B1lUoAlvAOEI4AXrwzq9vDuJePO1AMDHfk3yxAJJktYDr4rNnAzLtyShJWTHrdT/2cSk/RWNRkKP+mg5MR+5XGYicr/qQZx09JLgGpJnv0BW5c+IjPXZp7II3TwMIhIEnK7+O2gR0rMT8VIIQhR1dbw/AnA4RKxwj2e9IlLGCToXyxv7mUSMAovSw5o4CqOugJ2M/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(26005)(31696002)(316002)(186003)(83380400001)(6636002)(86362001)(4326008)(44832011)(38100700002)(66476007)(5660300002)(66556008)(8676002)(508600001)(31686004)(36756003)(2616005)(16576012)(6486002)(956004)(66946007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFabldnRW1wRXIzNVhaSkhBNlhzUFhLT2VvWmNnU0Q2T2JrQlhkVjVtcDU4?=
 =?utf-8?B?SlJ5MnBEeWhVVHVYTjdrVE54cDdWcFhUZm9meGkzR3NzZW1iZmxWQmZLcTNH?=
 =?utf-8?B?ejR4TGx2bmxWTWJnMkZkVmJSSlhZczZ4bTQ4V3d3OVRGVXJGRFY2bTdpWkhK?=
 =?utf-8?B?QnNNbG9VdllQUDNvVDYycGhydHQxV2ZTZjF3aHBYR2gxOEJmemw2NjZaaXlQ?=
 =?utf-8?B?KzVrZ2ZGeHZTdklLUmdiU0h2UEJVVUlLVXJINUFuTzhvRGtXN0d3MHhHK1Bu?=
 =?utf-8?B?YTh5Y3FLZkhGZ0Q0SXRQdlBZWlNFeDEvaG5peDBlQWxkcG9MUGwrNFlJcjR3?=
 =?utf-8?B?V05KOG94alZXYkxsMC9sMk1GWTM5bXl0TllJYnloTW50cHFRVmtRdW1HeDIr?=
 =?utf-8?B?dkdQQUFKM2ttMFBsMU1Ka0twM05qbE9LSjFRaFFvdXhWSVdsc1RHV09NamNr?=
 =?utf-8?B?TTkyV0VwV0hJTTBkbmk2MUhMR2VXSEVrTGZYeW9iVEdVa0dvOFd6Y2RORkRy?=
 =?utf-8?B?SFZEaWthaVVpR29mZDNDUmdwNDA3TmkvTGM3ZTVlOWw2T1d4blQ0MVpWdEpq?=
 =?utf-8?B?VkxkbFNWbSs0TjlMZVNLbzhRT011SjI2cVJMemVBeEk0Q1pQR2M2YnN0VWJt?=
 =?utf-8?B?NXhMM2dnVHpqSkZxY2ZyTzZGN1VNUUtScEFtR1Qyc2xKSzZxdThVL2x2MlE0?=
 =?utf-8?B?ajFsVGExUGpLSHphWmdQdWxrdVNtUFdnZG54Z2R2RzhTWmxGSG52aVlIbDZS?=
 =?utf-8?B?c1RuN1FpKzJUMkRRSThnTVNKMXBabFcrRUhsZ2VSWHZ0angvR1RUK1RrUW1N?=
 =?utf-8?B?S1BhY1RFRERIR2RZTUh4R0RvQUxlTEliNW1QekFBUTEyMG9PVG5tQURRdVZv?=
 =?utf-8?B?RkJKVGJQR3VmVC94aWd3aUhIV2ZHcmhRS0I3NHoyWEpSaStKbnNVbXJzc1RQ?=
 =?utf-8?B?ZGFRelpZc3FYTHNYVlRxNkhzZnNySnF3THFqRU1Qb0JSZmdReUpXUk0wLzVF?=
 =?utf-8?B?Um9xdzlJQmlwYmJXcGpxRjFVZE4yZE1VZjhpM1RYVnB5YUFva0lyY2JZT1dG?=
 =?utf-8?B?aTZjcFVpNURXMkhvTGE4c25kVnZpZkROWVlhZk5EZWxWYnpFK1VkTGc3dFB4?=
 =?utf-8?B?T25qbjM2eVNLYjFlRnlkQkcyeDhnYkY2aXdzY0JwSnNxVzFLWjNqSStiWW13?=
 =?utf-8?B?RXpIbVA2Wk1UQ0syMXU4WUVRT1hqZnc3UWN0ZGlOYXQvSjliZkpHV2VMQjBK?=
 =?utf-8?B?TE9FcTVSZ3ZMTUdYQlJHUGVRbVRBSk9GU3p0b2NWb2hGWGk4VUxFeFF4T1Rl?=
 =?utf-8?B?QWlUemxoYW5pVHRVLzdHVEFSUWkxbHhoeFNlSHVaNUt3UkpHUUU2NjJzNktU?=
 =?utf-8?B?VjlZVGlybCtNbGRrcnFMWFo4cXhFaExaSGgrbThQbU5kRzJZbjdwVzF3b3Y4?=
 =?utf-8?B?cHZlOWI4WERYM3RhVUZFcFlmWTJacDZyZ24zRnNrU2VCWFdoQ2dvYnhkemFk?=
 =?utf-8?B?VVJKSXhOZ1YvLy9OL2FLUGNMdHRBSTFFdU9JcVVKVEwvb0FIcGVmWlNzKzRz?=
 =?utf-8?B?N0lLTTRKdWNvZDJiRC9vbWJGbFRRTWhOaVdEUGJ4Y1N4RTFRRWFyRkFJbmUw?=
 =?utf-8?B?ejdqOVA4MDJEWnBIbXZFbmZrSzlwUGJlR3pWbXQ3RjE4NVljdkJnL21sUENa?=
 =?utf-8?B?Z3JHQ3hVQ3RqMjZ5eFlTdHNCVmdhUm1HeHptclluWmpuVGQ0VnBPV0thM0pF?=
 =?utf-8?B?VGNmZ3pkanNCNGZick5FeWpsREtSbkc0WmpBdlhGaHM1cTE2UHlta3RMb0Uw?=
 =?utf-8?B?R2JWYkFpWUNvWjBoNEhwc3RKaFpjNzdSK0NyNzFvU1g1Ukh1WEt2TnRKeVFS?=
 =?utf-8?B?OU9ZeDlQeUg0dURJekp1L0pDMldhS0NjcE1Fbm9vY2ZwZGJ1NzRPbEVWQWRm?=
 =?utf-8?B?UWd3VUxPcWZHTFJ6Ti9hQ3hFRjdxcldLWkhxMExQMEs0QTZpLy90R21KdDVZ?=
 =?utf-8?B?VktrQmxwSjhQaHZUZlkyOHB0SDAxVE9Dc2lMc0lKWnZydHlKMWhCZTI1U0xS?=
 =?utf-8?B?T29HaXk2NnN4KzRGQUdmbkRtNFE5UEFRN0pmWEZGb25YYzZaQWVYdnJQc1F3?=
 =?utf-8?B?akIxcGVRM2E3bEF1TnpaRzNmanhRZlBBaWg0bXg2NG5FWXBwV2lOQzlYelQ2?=
 =?utf-8?Q?IGpgg6PLZRHycGTgDoIi5qo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8815c458-f1bd-4dce-c72e-08d9ba775e9f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 18:20:10.3090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pm8ifIR2pFMQG8AyeZYB24li76BdODk59zKC531bsDWMGpmP0qvbQCkAMoMas7TtSVGM44mMbGYOOcgQlfGrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
Cc: ~lkcamp/patches@lists.sr.ht, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-12-07 um 8:25 p.m. schrieb Isabella Basso:
> This fixes the warnings below:
>
>  In function 'svm_range_map_to_gpu':
>  warning: variable 'bo_va' set but not used [-Wunused-but-set-variable]
>  1172 |         struct amdgpu_bo_va bo_va;
>       |                             ^~~~~
>  ...
>  In function 'dcn201_update_clocks':
>  warning: variable 'enter_display_off' set but not used [-Wunused-but-set-variable]
>  132 |         bool enter_display_off = false;
>      |              ^~~~~~~~~~~~~~~~~
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c                          | 3 +--
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c    | 4 ----
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 82cb45e30197..08b2130afa4c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1169,7 +1169,6 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
>  		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
>  {
> -	struct amdgpu_bo_va bo_va;
>  	bool table_freed = false;
>  	uint64_t pte_flags;
>  	unsigned long last_start;
> @@ -1183,7 +1182,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		 last_start, last_start + npages - 1, readonly);
>  
>  	if (prange->svm_bo && prange->ttm_res)
> -		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
> +		amdgpu_xgmi_same_hive(adev, bo_adev);

We can remove the whole if block here. amdgpu_xgmi_same_hive doesn't
have any side effects.

Thanks,
  Felix


>  
>  	for (i = offset; i < offset + npages; i++) {
>  		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> index f7f46b886162..2ea813a56edf 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
> @@ -128,7 +128,6 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
>  	int display_count;
>  	bool update_dppclk = false;
>  	bool update_dispclk = false;
> -	bool enter_display_off = false;
>  	bool dpp_clock_lowered = false;
>  	bool force_reset = false;
>  	bool p_state_change_support;
> @@ -146,9 +145,6 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
>  
>  	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
>  
> -	if (display_count == 0)
> -		enter_display_off = true;
> -
>  	if (should_set_clock(safe_to_lower, new_clocks->phyclk_khz, clk_mgr_base->clks.phyclk_khz))
>  		clk_mgr_base->clks.phyclk_khz = new_clocks->phyclk_khz;
>  
