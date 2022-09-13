Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60BEC6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 15:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBF010E76C;
	Tue, 13 Sep 2022 15:23:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA5A10E76C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 15:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYHRVTd0jDDQKhApxi4KT8piMrBIeof9+J/sum0SE7X2zkVCGhyAUWqMcYlmawDydnm27+aCI1RNKOErEtzsV6wcnILQZc7q3O7uJ4tw5Jp/8HsnYgyQvLA3TJdA5/PD5m/McKCNtq9mWsLbyKSOhnne6sJ3/F8FF9cyBvdEG20ZORdg1lPRYq/itIc8vCdzPoiVZxYQ6BJZFu1GsSKg8f82vmOmwKHkDQTYYDuqTkckE6aTfqiuQpHB79nQgrTMv5pN5jeYwWD9Tb0W/gSNH2geV0xWrPs+3QkPaQhk9s+F1dcWzKqd3foT8abX8Fc5XUyPDuqfKUXl44dLawfN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVB3BjhaByRJs8cfeGt1N2yRowK4lltng0ZAJegQr48=;
 b=aMFWmlWUlDQ0SBkR5Fa76UkKiptv3K/AQ/ziXiCK9Q2d0gfXZ5VnLw9EJCOm7+HYnQMSSt41jnaeYK3aooM3O+8rgb+E3yAkzqo0HzJrcbS2oRan1VbgVrRvEGdiu+kcwyE/qvXhy1o9XzqN2a/d19IL0tsAZCQ1m75vAJrEsizTHNI1F6KVHqqpbzyzWRfpAotN5VIcz8rLqwsMB8ePuKOMSNH83oO5Wbm+N8VpwTN59OM+UMjJ5Kn2/ngeH+GDvlGAj25MrDduobYylTlNk+szCeVqxgVJFsECrG8QCXIY5K8YWJ62HXStolvwma/p/99b/o7+TqeOTQBYClklpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVB3BjhaByRJs8cfeGt1N2yRowK4lltng0ZAJegQr48=;
 b=B1zrdFF8mhULZDJN1l287+SmF2EpLeWcroXcj1BuCCe6E1U73WIQD9lz/hKzJjOtEoK/7L3SMtL166avJoE0iK4TCy5XPhM47kI634o1Gx97tnQgh02yRblj1rjat/xKIeuLRpaCwCDVEBeI9CG27m4556aR6+bQJd7uQmp3/UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 15:23:51 +0000
Received: from MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b]) by MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 15:23:51 +0000
Message-ID: <822e2f83-e911-3356-e171-86c9dc7c1235@amd.com>
Date: Tue, 13 Sep 2022 11:23:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/4] drm/amdgpu: Add software ring callbacks for gfx9(v3)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <20220909015022.557099-2-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220909015022.557099-2-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To MN2PR12MB3375.namprd12.prod.outlook.com
 (2603:10b6:208:cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 30846151-84ca-41b7-5a0f-08da959bf64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyI44LaPgiqK87PKk8uNdRcccAK2EXoNUgN48jCV0v7B400eiGAnTsm1cJzDlvyFfR5ckM2CCg4rcwinVHOD9Oy48PxV8R/PYzMc+YjL33xDE2VtQl/uyp6mvGAHrhidqyiOruPeyeOHWpHjuNl56YSovZq2lj3ULUhu1c1qDChx9sY/CIpQ+DfyrJ4RGqCTPqXOknbSH6bNJj7ZUmENbbduGW92SrgN0Snr3RmCBfyOKItWjPMZD2PZHq63CbB62UGxWSp8kmXNV2t2QqPj2XGR+aPX80g3dt1LHPE90iioM94llgMzZ30VPTk+0YyvZUr8rhuyts2hQa8C66x/CrfwhBoutk6AiafgPgfOK2wl0BNrlStdHA2oGzNfElDqwqFHq9HszFEIfs/2muhPLVWU3YkNB56332el/OacQQqQF1u6UagoqcNAKJutcSgzCQ088fYvyGCJ7e8LqgXuQx1QI83u982WlnX4PjzordGcl0s/lL3QpLnaVfrO7+TswSezoGMQMV1fzw2HTMSkDBOASL/K6dob98EI3oReKXh1StMYObj5Byb+FKQRBHkaRGwtZH6yfgu/3M/Y2cz8DzrG99xNhDYV+Ht6ut4lUFpMumzm74Du4eV81h/n3XpmuYzl+5FRB7lJHP6kUC8hlgHsJLgIF02Rv6qFv99i+JtN8MZ4krVxy74SMTNfMLbVvyYw6dMrM7XYz/94aR/8bii9FV/Jh9C9J62psCQNhW84uAQ+lxYtqEXeYMNACTG9RD2gI/OF4ngNgEEl/L4+nBA+qGjLCD9bAy95oeQ0x0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3375.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(44832011)(8676002)(2616005)(186003)(83380400001)(478600001)(66556008)(31686004)(6506007)(86362001)(38100700002)(53546011)(31696002)(26005)(2906002)(8936002)(6486002)(6512007)(66946007)(30864003)(316002)(36756003)(6666004)(5660300002)(66476007)(41300700001)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmlleHlxVTZOb3hjODEwYkFYQTdWUi84Z3JBQ3hkSitaYko2NlVoaCtKbHM0?=
 =?utf-8?B?bjFUMDJ4aW1MakJEWm5uVHgrbGtldUIxTTMrL2l0dFVMUmo5RWdGL0NEWWZq?=
 =?utf-8?B?ZEFJWGJPY0ROcTFJUHlmL0FlSFFnbkwxemVnQUQwWVJrNDlZUCswTmltdFBl?=
 =?utf-8?B?R1RycjJNajBDdndvWE5HWDgyM0lNUlJITkNCZTdXejA2SFV4YWFVTHk4aFF0?=
 =?utf-8?B?bGxXOHExQjdRUEpVeXQ4NlJGbzBQd3prTkhWbTR5UkF0TkIxbmpOdDhxMkNV?=
 =?utf-8?B?L3BHcnZRbnNjZU1pMGtIeldVNWhUL2R6ZmpTamlpUFJGSDNiZjF0dGJTNXJW?=
 =?utf-8?B?QnlrQ1UwOEEvSDdmRnN3Rmxyckc4bmxLVzZ1cVdKMHlSSmlVUFlmYTlDbGVP?=
 =?utf-8?B?aVptNi9SKzdNUWlpNGhaUDNJZ0xJa2l3aERibTRiQmV0UFVmOEdiMTZCRXVi?=
 =?utf-8?B?TWpLVnI0Y291YlRXQ1h4VEt2VWtZWWhlQ1dFdGdNMEdvUHFHUHM5MENnRG8y?=
 =?utf-8?B?YzhHWHBiUUppaXdaMHkwSUdaNUY5ZW1aYXlTMysyRWMzeUlaYVI3ZmVmQ0pL?=
 =?utf-8?B?ZFVrUHFxMkZ3YXhTYXFYS25iVkZPSFc4cFVieVJBTUVBUnJUaHd0UGRxeUcy?=
 =?utf-8?B?blV4MFRROHVpRm9qc2tybkNseG1GM2kxb25NNDMrSysvY3A1ZGVQZEV0bUU0?=
 =?utf-8?B?RXpNZkllMzFpb0NtczcydUhITVdLTS92WDVnUjNUUkpHOSsvODBTSnJsc1pJ?=
 =?utf-8?B?MW1tZnlKay9qNUpIbnl1L1A3Tnd6enRxU3J4eWF0Rk8vcE04TGdabjV1cXhV?=
 =?utf-8?B?VXJhUlB5VVFWMVlJVVFpamRKOGV5aG9Ja0NjSWN0ZThzOENtczArczhHbGd0?=
 =?utf-8?B?TXRnRDQ4N3doLzBIZnlPN28vaTdnYjUwMUhqcUhZUm5hc3FoUzlOUytOVnJN?=
 =?utf-8?B?WTFZYUtxVEhiZ0F2aGpUUDBxTFlIdy9vSktrZzYrZG5kOHloMFk1Wno0T1JF?=
 =?utf-8?B?Y3Jjelp2ekNOY0trR0tydjN1aTZtV3JkODd4SnpQL3cwbXk0cWhONjJML0M2?=
 =?utf-8?B?NFVkQUxCUFU5OGE3a2NvUDVCMU9DNkZISUM2NksxZ3BXVUhId2FHUEZOMTlC?=
 =?utf-8?B?eGdTdTE0TXhSakh5S3dPbWhqcGRiVklSMyszMDB2by8raFZkMWNXVEFib1A3?=
 =?utf-8?B?eW5NdjZ1QVFSL2ZYa1R3OHRmOUMwaWNMMDNRNE5VaTJ6RGtHZEEvUXhRNHRL?=
 =?utf-8?B?N3NkMVdMTkxRTjdUb0xxTDF3VDVoZng0cnJHMWhxamd4bG1tM09qRDIySWNp?=
 =?utf-8?B?c3RVcUZRVjhDakNxWHVkYWd3WFRiZTcrWDdMekQ2eFNCVWN5VUtVVitvMmVm?=
 =?utf-8?B?eS9ySXN1QnZ0UWJJL2pROXpic251eThYaTQ3aXVkSG8yalllK0pvSGI3eGsv?=
 =?utf-8?B?OGZEakRYK3B1QjE5d3BnWjFpTHZLR2gwb0NHU2RSdHFqa1dsVDc3WVRFNmNl?=
 =?utf-8?B?Q3RNME5RaFBYUmZpbUhHS04yWGpYeVZyRDl3RTQ0QzBHVlZLZ0c1bm9lc2dS?=
 =?utf-8?B?S0FOK2RBa0I3NllBVGNhUlhXZjlNd3RjOFJycVdkaVBOcTBJRldGakYveVNt?=
 =?utf-8?B?bUg2RTh6N0NmZHZkMzYvZGpZRUxIMTVVQ3hKSVhuYkNldVhJT0JpZ3N4ckVR?=
 =?utf-8?B?MzNmWE5UR0NCazhzVzl5bnpLVWoxSXBXZjBVODNOMStlUkdOMm5JYmFUZ1d0?=
 =?utf-8?B?OU1tak12TEQ0bmZLWUszYzJaQ1drcyt1eVVndC9rWkhEQktrTFgrQk1RVzRq?=
 =?utf-8?B?aTRZUGxZL0tCblFSVUl1MCtoV1dMM3ZXQ3czV0ZwVVhnZElrbzZZYW5DTld5?=
 =?utf-8?B?dTB3SUEzbmdCdkRNL1NteVpUZkNPSGF6YUJENVNSMGdZam90T01MTHBWaTdQ?=
 =?utf-8?B?eGVrYUxEd09HSmM4VlRTKzhaNG1obXd0dkhUaXU1QVMrWlI2ajByZ0JjT0xi?=
 =?utf-8?B?STJEcERRU29KYWxobUdwY05hdk4vaEdMS2lES05lb0Z0QnMrTjVMTTRyNCsy?=
 =?utf-8?B?bGwweWhScG11Y1I0ZzRTSkxjS3hLUWZ1cFdDRUdhS01CNzJONlFJVXZBNjRz?=
 =?utf-8?Q?5azp60FUFB9xF8iWDiGoQB6nq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30846151-84ca-41b7-5a0f-08da959bf64e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3375.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:23:51.2708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7mmkhm853eIrHk+p/o7ib6g91m6aTEYiXFCY9uwyTE8G94RZ9jRnU5po0Yb6YzO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
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
Cc: Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inlined:

On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> Set ring functions with software ring callbacks
> on gfx9.
> 
> The software ring could be tested by debugfs_test_ib
> case.
> 
> v2: set sw_ring 2 to enable software ring by default.
> v3: remove the parameter for software ring enablement.
> 
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  16 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   3 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 116 +++++++++++++++++++++--
>  5 files changed, 128 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 96d058c4cd4b..525df0b4d55f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -207,6 +207,7 @@ extern bool amdgpu_ignore_bad_page_threshold;
>  extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>  extern int amdgpu_async_gfx_ring;
>  extern int amdgpu_mcbp;
> +extern int amdgpu_sw_ring;
>  extern int amdgpu_discovery;
>  extern int amdgpu_mes;
>  extern int amdgpu_mes_kiq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 0de8e3cd0f1c..5eec82014f0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -348,6 +348,8 @@ struct amdgpu_gfx {
>  
>  	bool				is_poweron;
>  
> +	/*software ring*/

Isn't is more aestethic to put spaces around? Like this:
/* software ring */
?

Please run your patches through scripts/checkpatch.pl.

> +	unsigned						num_sw_gfx_rings;
>  	struct amdgpu_ring_mux			muxer;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13db99d653bd..5b70a2c36d81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -33,6 +33,7 @@
>  
>  #include <drm/amdgpu_drm.h>
>  #include "amdgpu.h"
> +#include "amdgpu_sw_ring.h"
>  #include "atom.h"
>  
>  /*
> @@ -121,6 +122,11 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>  {
>  	uint32_t count;
>  
> +	if (ring->is_sw_ring) {
> +		amdgpu_sw_ring_commit(ring);
> +		return;
> +	}
> +
>  	/* We pad to match fetch size */
>  	count = ring->funcs->align_mask + 1 -
>  		(ring->wptr & ring->funcs->align_mask);
> @@ -183,6 +189,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	u32 *num_sched;
>  	u32 hw_ip;
>  
> +	if (adev->gfx.num_sw_gfx_rings > 0 && ring->is_sw_ring) {
> +		return amdgpu_sw_ring_init(adev, ring, max_dw, irq_src, irq_type,
> +			hw_prio, sched_score);
> +	}
> +
>  	/* Set the hw submission limit higher for KIQ because
>  	 * it's used for a number of gfx/compute tasks by both
>  	 * KFD and KGD which may have outstanding fences and
> @@ -343,7 +354,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   */
>  void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  {
> -
> +	if (ring->is_sw_ring) {
> +		amdgpu_sw_ring_fini(ring);
> +		return;
> +	}
>  	/* Not to finish a ring which is not initialized */
>  	if (!(ring->adev) ||
>  	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index fe33a683bfba..ba6d8c753f7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -38,7 +38,8 @@ struct amdgpu_vm;
>  /* max number of rings */
>  #define AMDGPU_MAX_RINGS		28
>  #define AMDGPU_MAX_HWIP_RINGS		8
> -#define AMDGPU_MAX_GFX_RINGS		2
> +/*2 software ring and 1 real ring*/
> +#define AMDGPU_MAX_GFX_RINGS		3
>  #define AMDGPU_MAX_COMPUTE_RINGS	8
>  #define AMDGPU_MAX_VCE_RINGS		3
>  #define AMDGPU_MAX_UVD_ENC_RINGS	2
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5349ca4d19e3..774e44e1074a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -47,6 +47,7 @@
>  
>  #include "amdgpu_ras.h"
>  
> +#include "amdgpu_sw_ring.h"
>  #include "gfx_v9_4.h"
>  #include "gfx_v9_0.h"
>  #include "gfx_v9_4_2.h"
> @@ -55,7 +56,8 @@
>  #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
>  #include "asic_reg/gc/gc_9_0_default.h"
>  
> -#define GFX9_NUM_GFX_RINGS     1
> +#define GFX9_NUM_GFX_RINGS     3
> +#define GFX9_NUM_SW_GFX_RINGS  2
>  #define GFX9_MEC_HPD_SIZE 4096
>  #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
>  #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
> @@ -2270,6 +2272,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  static int gfx_v9_0_sw_init(void *handle)
>  {
>  	int i, j, k, r, ring_id;
> +	unsigned int hw_prio;
>  	struct amdgpu_ring *ring;
>  	struct amdgpu_kiq *kiq;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -2356,13 +2359,40 @@ static int gfx_v9_0_sw_init(void *handle)
>  			sprintf(ring->name, "gfx_%d", i);
>  		ring->use_doorbell = true;
>  		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> +		ring->is_sw_ring = (adev->gfx.num_sw_gfx_rings > 1) && (i > 0);
> +
> +		if (adev->gfx.num_sw_gfx_rings > 1 && i == 2)
> +			hw_prio = AMDGPU_RING_PRIO_2;
> +		else
> +			hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +		if (adev->gfx.num_sw_gfx_rings > 0 && i == 0)
> +			ring->no_scheduler = true;
> +
>  		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
>  				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>  		if (r)
>  			return r;
> +
> +		if (ring->is_sw_ring)
> +			ring->wptr = 0;
>  	}
>  
> +	/*init the muxer and add sw rings */
> +	if (adev->gfx.num_sw_gfx_rings > 0) {
> +		r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0]);
> +		if (r) {
> +			DRM_ERROR("amdgpu_ring_mux_init failed(%d)\n", r);
> +			return r;
> +		}
> +		for (i = 1; i < adev->gfx.num_gfx_rings; i++) {
> +			r = amdgpu_ring_mux_add_sw_ring(&adev->gfx.muxer, &adev->gfx.gfx_ring[i]);
> +			if (r) {
> +				DRM_ERROR("amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
> +				return r;
> +			}
> +		}
> +	}
>  	/* set up the compute queues - allocate horizontally across pipes */
>  	ring_id = 0;
>  	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> @@ -2413,6 +2443,9 @@ static int gfx_v9_0_sw_fini(void *handle)
>  	int i;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> +	if (adev->gfx.num_sw_gfx_rings > 0)
> +		amdgpu_ring_mux_fini(&adev->gfx.muxer);
> +
>  	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>  	for (i = 0; i < adev->gfx.num_compute_rings; i++)
> @@ -4709,8 +4742,9 @@ static int gfx_v9_0_early_init(void *handle)
>  	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
>  	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>  		adev->gfx.num_gfx_rings = 0;
> -	else
> -		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> +
> +	adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> +	adev->gfx.num_sw_gfx_rings = GFX9_NUM_SW_GFX_RINGS;
>  	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
>  					  AMDGPU_MAX_COMPUTE_RINGS);
>  	gfx_v9_0_set_kiq_pm4_funcs(adev);
> @@ -5877,7 +5911,11 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>  
>  	switch (me_id) {
>  	case 0:
> -		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> +		if (adev->gfx.num_sw_gfx_rings > 1) {
> +			for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
> +				amdgpu_fence_process(&adev->gfx.gfx_ring[i]);
> +		} else
> +			amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
>  		break;
>  	case 1:
>  	case 2:
> @@ -6882,6 +6920,62 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>  	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>  };
>  
> +
> +static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
> +	.type = AMDGPU_RING_TYPE_GFX,
> +	.align_mask = 0xff,
> +	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
> +	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
> +	.vmhub = AMDGPU_GFXHUB_0,
> +	.get_rptr = amdgpu_sw_ring_get_rptr_gfx,
> +	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
> +	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
> +	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 +  /* COND_EXEC */
> +		7 +  /* PIPELINE_SYNC */
> +		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> +		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> +		2 + /* VM_FLUSH */
> +		8 +  /* FENCE for VM_FLUSH */
> +		20 + /* GDS switch */
> +		4 + /* double SWITCH_BUFFER,
> +		     * the first COND_EXEC jump to the place just
> +		     * prior to this double SWITCH_BUFFER
> +		     */
> +		5 + /* COND_EXEC */
> +		7 +	 /*	HDP_flush */
> +		4 +	 /*	VGT_flush */
> +		14 + /*	CE_META */
> +		31 + /*	DE_META */
> +		3 + /* CNTX_CTRL */
> +		5 + /* HDP_INVL */
> +		8 + 8 + /* FENCE x2 */
> +		2 + /* SWITCH_BUFFER */
> +		7, /* gfx_v9_0_emit_mem_sync */
> +	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
> +	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
> +	.emit_fence = gfx_v9_0_ring_emit_fence,
> +	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
> +	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
> +	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
> +	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
> +	.test_ring = gfx_v9_0_ring_test_ring,
> +	.test_ib = gfx_v9_0_ring_test_ib,
> +	.insert_nop = amdgpu_ring_insert_nop,
> +	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.emit_switch_buffer = gfx_v9_ring_emit_sb,
> +	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
> +	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
> +	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
> +	.emit_wreg = gfx_v9_0_ring_emit_wreg,
> +	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> +	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> +	.soft_recovery = gfx_v9_0_ring_soft_recovery,
> +	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +};
> +
>  static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>  	.type = AMDGPU_RING_TYPE_COMPUTE,
>  	.align_mask = 0xff,
> @@ -6956,9 +7050,15 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>  
>  	adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
>  
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> -
> +	if (adev->gfx.num_sw_gfx_rings > 0) {
> +		//first one is the real ring
> +		adev->gfx.gfx_ring[0].funcs = &gfx_v9_0_ring_funcs_gfx;
> +		for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
> +			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
> +	} else {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> +			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> +	}
>  	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>  		adev->gfx.compute_ring[i].funcs = &gfx_v9_0_ring_funcs_compute;
>  }

Regards,
-- 
Luben
