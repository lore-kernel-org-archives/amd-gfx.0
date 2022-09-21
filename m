Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33C2C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 12:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6901710E3EF;
	Wed, 21 Sep 2022 12:48:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E6510E3EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 12:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOfyg5A2kvS4RUiDUzLPFkeH7dYOvhfFH3xZz8Rk5qmcyIamb+DIq2GZgi6O5/hLChGp2UqpqnCGkTi/hlZZMfB/89nEesFWWK6rdPfWpI6MvjvUweHqH/lYZicwd+WO1l60wHZxgR+yMHfSWOIMHjrSiTVj/IRyMuFR0MlfmbImc4zujI28ukbn+GdZhOQUYSwkD0evHSb+MN5dhXUuTcyGRQIHBDK5FAsWW4CNInddIlE/kSmaKWwV2CfCCD4yAIX6cVGukkJWBaBDiNn2EsOH/neqbtbQKak/v4B5T9kHCV5cAiQ+yLCT2RDhaoF/2V58yAVRTz5Cw+RSlLdzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fy6P9BmvkOKVSdzIXFrF0YRG/t/cxJCJG4aq+84Ah0=;
 b=KskHVpsZMEuUJCxaN+nvpKJyHANpjJBgyqF2NUj+69FaVOg1i/FADGDlbBByi4E2xozNkUURRKQpRtFxMVxv54TleSd0zdsSxv3blKkkocimIunoRgn0lUp8WuXLKfjIlUWBYx2BhTLCcp77TPIKb02VvOoZzzDNlJ6iGPzeU7ySiXpqLZ0/+t2NUYM5KxwV1lqGLQqlZ8OgrHq757rlhtRDbyhY8lpQN2Ro026v+GUNR8AygDDgQLApldjaJHZHY1WcufJKBvOb31OVACirgqUd9Ia/Zy5Z9Kig86qjue/tq3EpJrppRaCi6qFamXyC7S+Fb5fj9UIGhHcS7mzIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fy6P9BmvkOKVSdzIXFrF0YRG/t/cxJCJG4aq+84Ah0=;
 b=ELIVBRkWST9bzx3Ps8MJG+awUK1Dkw2uVAGPhvDY5GOyJxy2SZ2MYOJNs/XxNB1cnhVsEsqR8jQgJBvIrboifjMcgfM7wb5xvKD/VqmdukNpmaWaF+CpyTrkwIyBmFY6WKQTC2zJZYbN/SFRpZSMNLWIlcMg7nlhMCOMzHjG+Ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 12:48:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 12:48:00 +0000
Message-ID: <6ba9ff01-0b13-a09e-b031-c97a3cb46e6e@amd.com>
Date: Wed, 21 Sep 2022 14:47:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] drm/amdgpu: Add software ring callbacks for gfx9 (v5)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
 <20220921094117.1071106-2-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220921094117.1071106-2-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 801c0175-1de6-4f58-cdd3-08da9bcf83e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dx2CO1n6tgmyW2SyBapaq7aqztkM+NvZmXH/g30XykdhHL4GAuWxlMzUDkDa+YQj8A9Jnrm9CqI7zZw2x/ZJUAJJRSTSFHgd2krOVPdlwouw/iowRwOsCTj8zAW4tHc7yCOCkKfEYm8Bir52Da92vZ4KYLAcQiB51BW6APy4OqX+2jQKh9bcLKTEfYkmXFlR6yswzf7kw9CMi69sH0hlTKy+l5qvZB98dCNsT6ZJmc8weVMl1/Fz+ZxcBu/iCMW2A1CIEutoUgEQm5W/IF2pi760UvWxNxTlqtkMJVA7JbxkuB1TQdCpfvnbViPQZrR1xxCYd5ot90UUlHGz/Hra03CKVbz5oxq4zXyG+C3aNydRgVGY+7Ekbcsq5UQbwha5MgY9867JgNvN0RbFsyWXBmOyfTnz+HxfW4XiHLLFahrJuSsJckgV/xs9qkpGARijlhxujf7AheUZrpg/avdYd9/4V9FrXO2HfJFLebslEO8lCmlmWaH2zJKR/EzpNLzugakHQ0QU6NLzi4gLxNrVRa6jXlvds+kY0+Eyed5WOybRmLguLwTQsl13dBjTx2sfrDybesgG805Z2rfX+n7eVdMmoFKrfqh5D8dpnhlXX8ETsVL2j46Yi4R/vptmbtlrA0oL1Lyk/mJ+BtiXkW++TJEzHP0DJMxOLo2znNL7uS81vxQbihZNZQznHJBXjhNUdcND6OZJUR4V/QfmxjTmISNM6xVU/GQXnnX7ZkfoXqoJgZ3lnCpHZXjU1iOjTTE7Jp17sRT4DbQmQaSnwE5PfBBfHKAVpXLgfVzqcnOkP5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199015)(2906002)(54906003)(5660300002)(316002)(30864003)(8676002)(66946007)(31696002)(86362001)(8936002)(41300700001)(66476007)(66556008)(4326008)(83380400001)(38100700002)(6666004)(6506007)(6486002)(478600001)(186003)(2616005)(6512007)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzA1VXBhUHl6S3QrREd1TTFXSnNxRitwTVlGZVVSY1BTUnlMSnBaNGtHZWpH?=
 =?utf-8?B?c1l4bmhKTDZ3WktZRnFIb3VMaHpieVBva2k2WGFaVHpRTVVHZTE3WUpRTHJm?=
 =?utf-8?B?bHBEdDUycTVaSXJJSEtjbDIrT1FnanhHd3lYclJxMDh1Y2hUaEtsb0tkWUky?=
 =?utf-8?B?bnJNTWdnSGw2MmtYZ1h3cG1VWlF5M1hmOGlOZnM0SVVQdXJmYXlUdEg1VVBw?=
 =?utf-8?B?U0x2Q1JqeGErQmQzWnVOUjdSYzVURXpuNCt5dmovVnUrdjcwNTVlNHBHZzNi?=
 =?utf-8?B?N3dCblBCeWJUbi9Jb0lTZEN2bEVCRjNsdXQvK0tlcHZxZUI3Ry9LbXBtSGVF?=
 =?utf-8?B?bnBocUJMeHhiTVUrV1ZyamEwaWNnS1JhN0Zoc1lCUUpxTHU5T25xZGdCSktB?=
 =?utf-8?B?SWtwaUF4aC84enRMZWdiYm5tMDBjMmpidllEM3dvTEpWYThjRXlGblEvMWdx?=
 =?utf-8?B?Z2daWTByU1hhbXk5RU85VEpvUE9DV2ljQStLcG54YzVvQmUwLzZ2dnRneGRk?=
 =?utf-8?B?eGRKVUZZbmk1QXlMN3ZXNWk4TG5CaTI3bkFjNXpGaUwvRUZUSHE0ZUxta0Zx?=
 =?utf-8?B?a0JuRnJZVVVHbmd5MFYra01qb3NVZWlUTTRYZDg2dlpVb0wyMHJUdVlOczB6?=
 =?utf-8?B?cmsxRXRENWxKZUZ3TlZ1SDFSWDZSZXZQNXVOdllrMFdCbGRUbXRwc05iMGhS?=
 =?utf-8?B?Z29SaG1URkhuWThWY2JFWnY4amNCWHNRR2FhTEkzZVB6T0gyS1BxSE90MzBC?=
 =?utf-8?B?eEI4d1VFM205SFZxb05qRFVmdVVpdittUjRobXplcmpMMHFUM01wVktkMXVX?=
 =?utf-8?B?amVqak05eUFlV1hUS3pFY3liQnZHR2svbFF2aE9RVzRHa0ltME8rN3ZrKys3?=
 =?utf-8?B?MkhLTnhYUDJVYUZLVUtrT0pQSms2UDdmdnl3UlpDRzEyUGhOSHVHNkwvT3FZ?=
 =?utf-8?B?TlAxd2xGT2ZSUDRQVzdmY3BVR0lUdStISnRIN0w2RkkvTVZ0b2NJejIvMldI?=
 =?utf-8?B?UmVBTjc4M2xsQXF6MDVsN3BLVWhtYkJzbUZzemJ3bS9kNlB4SExKWm5DenZz?=
 =?utf-8?B?eGozSUt0QmVZVDRPTWRBUERxa1IxTjhkNzBVaFF0dVhNOS9MTDkvTzZRMlM1?=
 =?utf-8?B?NDN5djc0YVdmWHNhNjBYRi9YNVdJSVIwLzBlQUk1VUJDZFRSN3hXaklmdEVp?=
 =?utf-8?B?RkViRE5ObXdiQVE2RUNyVzRoYmF4SFRxTVoyZ0hFY2xqR3lEb2N0N1RBL1gx?=
 =?utf-8?B?eFQvaG5YN3ZrU1o3bDVWSFBXZjJidW9wT2JEOEVVQUJEMXBtanpyZTFzNjM0?=
 =?utf-8?B?bkE1TC9pVWFORGs5ZHhJejM5bTdxQkZ3bVJhdE05VzJnRUVnVmc3QURaeEZt?=
 =?utf-8?B?M2RLM01VVGR6M0tzVVZFSWlMb0loVWVWbFlYQ0t3RzRNU0NUNnh4c3M3bUVP?=
 =?utf-8?B?T1I5T3RJaTM3VkdjSU1uWE5kc2hnOE05ZlZIc2hCd1ZKUGx2dkVDT2NYR2lB?=
 =?utf-8?B?TkNadXBKK0tQd0ZsL1laaVdEajArUk9tRlZHZWxBeEp2RWlXcmJHbmtuNjZQ?=
 =?utf-8?B?RlI3SHpJRUpkNmVkcWhjR3h3bU91M2RwMlFyUU5HbUpvejVQNmZwNW1FYllP?=
 =?utf-8?B?QXB4eXVINVd4cXFEeDJ4MkdxY2IwSGRwbjM5RUVTQzJpKzE3WW1tc2ZHUFF3?=
 =?utf-8?B?amFMODdhQVE1WGx5aCszTzlZK2RkdThsNkRpUU84TXNLVUUxNGs5dzJxd3Nh?=
 =?utf-8?B?dGJialRuaFJILzZXTkk0U2lFUDRETDV0RVhlNmdzYkZaaTB0ckZxdlR6YzVO?=
 =?utf-8?B?NUZjZTFsS2pselk2RC9rVzdqK1dQbWtyMXlsSVBVdUNGNDJNRmZwN2pobzJ0?=
 =?utf-8?B?ck5VdXhJSiszMnVaSVc5ZXBqMitoejNDZ2l6cEVJZk5CVjJ5L2pUbmU5VSsy?=
 =?utf-8?B?cEZJekxEVFg0cUk4a3k0RTZ4ZFNQbnk4WnJNNERKRTN5NDBZN3l1UFczVTNv?=
 =?utf-8?B?R21leTBEVW9GS3hCa2s0cVA2SGFkd09ZWU9uQ0dJZ3A5RjVXSWJaTzhBdVlr?=
 =?utf-8?B?YjNEVFBpU0svd3NrUWd1VnBYOVpMdzFuaWhhN0tVUWY3VXZlVU5JN0EwWUww?=
 =?utf-8?B?RGs3UlF3N0o2Y1JhSUxpVXp6OVFOV3NFVXVGcTRTZjZGVSt3K2xKcEtockZI?=
 =?utf-8?Q?5phgszvhZWzZwrzTYXgKvE9jX0q9GUMtLo/G1vuFPLGg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801c0175-1de6-4f58-cdd3-08da9bcf83e8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 12:48:00.1829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjtB64nKrVSN3xFnVJf1wVImiUuVySWHtlhELTsE+TuQmY/UfbeWF2VLjFyYaj+W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.09.22 um 11:41 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> Set ring functions with software ring callbacks on gfx9.
>
> The software ring could be tested by debugfs_test_ib case.
>
> v2: Set sw_ring 2 to enable software ring by default.
> v3: Remove the parameter for software ring enablement.
> v4: Use amdgpu_ring_init/fini for software rings.
> v5: Update for code format. Fix conflict.
>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |   7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 117 +++++++++++++++++++++--
>   5 files changed, 120 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 96d058c4cd4b..525df0b4d55f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -207,6 +207,7 @@ extern bool amdgpu_ignore_bad_page_threshold;
>   extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>   extern int amdgpu_async_gfx_ring;
>   extern int amdgpu_mcbp;
> +extern int amdgpu_sw_ring;
>   extern int amdgpu_discovery;
>   extern int amdgpu_mes;
>   extern int amdgpu_mes_kiq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 9996dadb39f7..93b25d9a87f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -348,6 +348,8 @@ struct amdgpu_gfx {
>   
>   	bool				is_poweron;
>   
> +	/* software ring */
> +	unsigned                        num_sw_gfx_rings;

Please completely drop that, just always enable the SW ring for GFX9.

>   	struct amdgpu_ring_mux          muxer;
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13db99d653bd..4eaf3bd332f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -33,6 +33,7 @@
>   
>   #include <drm/amdgpu_drm.h>
>   #include "amdgpu.h"
> +#include "amdgpu_sw_ring.h"
>   #include "atom.h"
>   
>   /*
> @@ -121,6 +122,11 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>   {
>   	uint32_t count;
>   
> +	if (ring->is_sw_ring) {
> +		amdgpu_sw_ring_commit(ring);
> +		return;
> +	}
> +

That is a pretty clear NAK since the sw ring should be transparent to 
the upper layers.

Why exactly is that necessary?



>   	/* We pad to match fetch size */
>   	count = ring->funcs->align_mask + 1 -
>   		(ring->wptr & ring->funcs->align_mask);
> @@ -343,7 +349,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>    */
>   void amdgpu_ring_fini(struct amdgpu_ring *ring)
>   {
> -
>   	/* Not to finish a ring which is not initialized */
>   	if (!(ring->adev) ||
>   	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 40b1277b4f0c..275b885363c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -38,7 +38,8 @@ struct amdgpu_vm;
>   /* max number of rings */
>   #define AMDGPU_MAX_RINGS		28
>   #define AMDGPU_MAX_HWIP_RINGS		8
> -#define AMDGPU_MAX_GFX_RINGS		2
> +/*2 software ring and 1 real ring*/
> +#define AMDGPU_MAX_GFX_RINGS		3

Please don't change that. Instead add a sw ring separate to the gfx_ring 
into amdgpu_gfx.

>   #define AMDGPU_MAX_COMPUTE_RINGS	8
>   #define AMDGPU_MAX_VCE_RINGS		3
>   #define AMDGPU_MAX_UVD_ENC_RINGS	2
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5349ca4d19e3..4a8be9595459 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -47,6 +47,7 @@
>   
>   #include "amdgpu_ras.h"
>   
> +#include "amdgpu_sw_ring.h"
>   #include "gfx_v9_4.h"
>   #include "gfx_v9_0.h"
>   #include "gfx_v9_4_2.h"
> @@ -55,7 +56,8 @@
>   #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
>   #include "asic_reg/gc/gc_9_0_default.h"
>   
> -#define GFX9_NUM_GFX_RINGS     1
> +#define GFX9_NUM_GFX_RINGS     3
> +#define GFX9_NUM_SW_GFX_RINGS  2
>   #define GFX9_MEC_HPD_SIZE 4096
>   #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
>   #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
> @@ -2270,6 +2272,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   static int gfx_v9_0_sw_init(void *handle)
>   {
>   	int i, j, k, r, ring_id;
> +	unsigned int hw_prio;
>   	struct amdgpu_ring *ring;
>   	struct amdgpu_kiq *kiq;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -2356,13 +2359,41 @@ static int gfx_v9_0_sw_init(void *handle)
>   			sprintf(ring->name, "gfx_%d", i);
>   		ring->use_doorbell = true;
>   		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> +		ring->is_sw_ring = (adev->gfx.num_sw_gfx_rings > 1) && (i > 0);
> +
> +		if (adev->gfx.num_sw_gfx_rings > 1 && i == 2)
> +			hw_prio = AMDGPU_RING_PRIO_2;
> +		else
> +			hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +		if (adev->gfx.num_sw_gfx_rings > 0 && i == 0)
> +			ring->no_scheduler = true;
> +
>   		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
>   				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
> +
> +		if (ring->is_sw_ring)
> +			ring->wptr = 0;
>   	}
>   
> +	/*init the muxer and add sw rings */
> +	if (adev->gfx.num_sw_gfx_rings > 0) {
> +		r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0],
> +					 adev->gfx.num_sw_gfx_rings);
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
>   	/* set up the compute queues - allocate horizontally across pipes */
>   	ring_id = 0;
>   	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> @@ -2413,6 +2444,9 @@ static int gfx_v9_0_sw_fini(void *handle)
>   	int i;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (adev->gfx.num_sw_gfx_rings > 0)
> +		amdgpu_ring_mux_fini(&adev->gfx.muxer);
> +
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>   		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
> @@ -4709,8 +4743,9 @@ static int gfx_v9_0_early_init(void *handle)
>   	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
>   	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>   		adev->gfx.num_gfx_rings = 0;
> -	else
> -		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> +
> +	adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> +	adev->gfx.num_sw_gfx_rings = GFX9_NUM_SW_GFX_RINGS;
>   	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
>   					  AMDGPU_MAX_COMPUTE_RINGS);
>   	gfx_v9_0_set_kiq_pm4_funcs(adev);
> @@ -5877,7 +5912,12 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>   
>   	switch (me_id) {
>   	case 0:
> -		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> +		if (adev->gfx.num_sw_gfx_rings > 1) {
> +			for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
> +				amdgpu_fence_process(&adev->gfx.gfx_ring[i]);
> +		} else {
> +			amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> +		}
>   		break;
>   	case 1:
>   	case 2:
> @@ -6882,6 +6922,61 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>   };
>   
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
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   	.type = AMDGPU_RING_TYPE_COMPUTE,
>   	.align_mask = 0xff,
> @@ -6956,9 +7051,15 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>   
>   	adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
>   
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> -
> +	if (adev->gfx.num_sw_gfx_rings > 0) {
> +		//first one is the real ring

Please no // style comments in kernel code.

Regards,
Christian.

> +		adev->gfx.gfx_ring[0].funcs = &gfx_v9_0_ring_funcs_gfx;
> +		for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
> +			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
> +	} else {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> +			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> +	}
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>   		adev->gfx.compute_ring[i].funcs = &gfx_v9_0_ring_funcs_compute;
>   }

