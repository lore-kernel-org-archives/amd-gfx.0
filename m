Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E205FF60ED
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 08:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A71C10E91B;
	Tue, 31 Mar 2026 08:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rRIokTzS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52D610E91B
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 08:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRVBwib2p0DjBf2xfO3pH7Gsmlr1pEhfWgzYCU98/Xti5PpUVECDNaBJ/kJNJvOuz24sOEFDbR4gGXlYUhXDUJRzkQRWUGihFpCsO6CZwEFMGbxD4qRt63sm6yPo/YLNr92O8YsxGIL4U3i7a5/HMjxjY6byOZ6FNNtMBKAdYuHBOBFyes4DMsFp3DoN9WyesIK0bYOPXgWTdIptBXzo+2mZYHVrqzKDrwTwuZtRDUvK8+keysV9LKjNsLbaqbuTjm4ip/AqH0r3uIdtrplaRwu2pR665bZESwhyKHDpUfxFE0gnUYDOr9g2PLRrZyPr8bacuoP/U5CarMPBMT9XtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw3uia0z72MSQXxHCix5OA0awM9jxGSg2U7SzQ+ErSw=;
 b=NmL0lTZZ9+LOdGvtgpYhrZdIqzYdsW+nMKHUvYHavXJbjt27msShapUQjcw/im+fuU1r/YI9J3t6dV7KMKSuckFkVQGuCy0IKRbSImUKE9p0bNdpoGQmsMtXkcclMbKQSd1HfG6sXb2S2d1d3klqEupCPy3I9RjzROn0uGU1Fdp0WnJP1HEWThZPpBxWfP3fl9gFY4WoQSnDmxBR/A/FbW7gIIHdOYNo593243r5eatcb+KqzZh6ud2k/DxOZUJUjc5yHeEDi/ZGby2rB8TNq2sq13G1P04EOuAa3e7ujnxPxAqsgX6B4pJONeGarAdydcX/8G1h5PmZPYk8no5uGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw3uia0z72MSQXxHCix5OA0awM9jxGSg2U7SzQ+ErSw=;
 b=rRIokTzSGRvORv0az9VoP3sEy2wh7kzcdOFP7ND9HWSuSq17r6Ic9doZU6PNVSbpWAe4P07OR9TYOmL/xYF5NRVM9Qe/ynbLEQZ04qHNJs9GJkbDCKi5rX+TO9zRmmv5n2hmDtlmCctfcpwxK0asx0QC8OvgBUrFQho3zqvqG90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:39:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:39:49 +0000
Message-ID: <6c32fbb1-669f-4656-9d03-e70f9b515a88@amd.com>
Date: Tue, 31 Mar 2026 10:39:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add fast-path for userptr BO validation
To: "Wang, Beyond" <Wang.Beyond@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Jin, Jason(Yong)" <JasonYong.Jin@amd.com>,
 "Alnasser, Mais" <Mais.Alnasser@amd.com>
References: <SJ0PR12MB69030113B9A8023E3132F8F7F753A@SJ0PR12MB6903.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SJ0PR12MB69030113B9A8023E3132F8F7F753A@SJ0PR12MB6903.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:208:530::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcd01e8-77ac-42f4-bc61-08de8f0111ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 5Euog5MNb8manQqYVLjbT1bqOcB6UmFOU/fh2tgsBOjaQ1YetkloMSEuWIkX1NwyfOETE7vA7pABpy9xMFvMYilinmuiGbdVj65JjbB01W3baXOHvpOIrPoYI6e3ivjMFXh916s2V1q7z3UjlvxCaPKc2ODWtTOom31twrq6xYbBH+7c59W/5KT4nb8FSM9psDGlyFMyU5eX8cy3vmvLgTzW8/rMInIxELBX97MQ2frKhk5MF4lsFQx37OQX6QRUjT6dD1yWWhyG7qUr/EFJci2pcHp4NhAswsZbcmHChpFVsYqeFgxdL31VpSHL+FTq/CyRk84ugtp9SkvshvHyZ9844N0amzisa6R5BWYaZyJX6mZQp6nC4wKKboa3vexflp88FCIj0y/f4L+8HhD28NTu6TP12dyxPurcQuggI6vVpDXsfAwWSC474uLVHRPixf1Ugrb9AH2VFAtHL0NCbHrllO/CTcCV8ly0E82ICxCzcEveaAFeu45DuZSiOvReS+8TplJGjWxCufKeci5F4jaK06HSJFLc4/CJDxCBoVlE1NWePjc+oM8ejbjsZx8bYo+v1dgQoOdhLNpdGUWu3yuSx1AIxT/v+ND/Da5k5tkNemdWfOVVPK6m2VsWDYcDxKhYw+y4A9udeRwnHiNTRvLdRQVBUCRYe+OViUtHyy6jmWnvSPdLqwTYxC5E420qb7Dilr2q/+Plvkwiag2k0DeD11JP1Z3B3AX3Ht+5RTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUxJbEZmVHpodmQ5MGF5MjN1WENNUVBxNzVvakFCTkVLaitNd05INDJCdGlF?=
 =?utf-8?B?RTNRdlNneFlCaUZBUUFPS09VbVJDbmdIUlZ3aTdBUUpqL0tnanlXekozTkFm?=
 =?utf-8?B?aGJWLzVnOWpIeDBPVVRISnNBRVEvaGlFWUxqOTBUckxaOHl3VGhCVkhUMDlN?=
 =?utf-8?B?Y3gzMUQrVWUrOHVrdUdDSmI2U3NoWVlHVVZOLzFlc1k1SlR4NWNHUHk0enAy?=
 =?utf-8?B?cHJ3UWYrcUtqVS95aFBpSTMyZm5zVWFSaXhCQ3d2V0xYNDdxaTY0TmdNTHF1?=
 =?utf-8?B?SlFFZGRjSVhTendwaUhlVXZnUXlQNmpaREEvRXdHcCtpV09ZTmtVdTljM2VR?=
 =?utf-8?B?VjNqRUw3TWdyNm5xTXdJbk1TSFoxZit1aEduU3orSGlMTjEwRmNqZGUzejdI?=
 =?utf-8?B?WEVWQ3pwSm1mQTVSdkhya2dsUUJCdzU5QlpKdnppL3g2d25BQld0RWtFZXRV?=
 =?utf-8?B?WmdmUU1DOXNST2JjMG1PZFU1Y1lFN0ZZVzhTMFVwVkZ0UEN6Ujlia3JPeTlX?=
 =?utf-8?B?VWRoVU53VmJjakpwT1JNZUdPYklOQUt1VEJzQUZORkVrUVRGcVZ0NWoxU2NC?=
 =?utf-8?B?ZTcvVWhJUHFySXpIMkwrREpObDJHV2hIOTM0MGduWkpUMUxHSVFIazV6akNu?=
 =?utf-8?B?MXdwOHVRcGQ2NnY5UUZ0MUZjS3NScnh5SE0vQXhLNEExSmdkeHhmYllwdUt5?=
 =?utf-8?B?dm1ISHREeDNDeER4eERlNUdUU01rYllVOTh5Rjc1QzdwN0ZNRExGclpZd2JD?=
 =?utf-8?B?aitXMjB1YnZhQzZCaERLUkRpMGpUSXJoZk56ZitxYlcrdko1YVRNd0JjT2hO?=
 =?utf-8?B?R0xSMHFlZ1lBOGYyQTNDM2FML3V6VWY0VEVTS1RGTGZML1NNTUdTc0lJaWNP?=
 =?utf-8?B?YW83Z2NPT3lGWlhYSjExUGFQRUFGUUZieW9CRU1mK2tkNmRHOCtMQjA0d1dX?=
 =?utf-8?B?K0RkNTVkcnhleEhuY3N0d3RKY2o5RTd3dHFJc01zWHEzeTdTcWs0cE90RExp?=
 =?utf-8?B?aU5SYS90Ym1FZmpFOGs5N1k2bDlBejg5NmZTTXhmZzhqUTdBMi96YWdsdmtx?=
 =?utf-8?B?aE1aWXg2TThmZ3dxbm1UMC9PR2g5UFhvMEl2TWFQTmROYUZHSFJOQmFVQWJz?=
 =?utf-8?B?ZWhGTVNWSDJWNHlDOHBZb0dHNHV3RVdQM0xkOE1NeGxLZHNZV1hNckkwUGNp?=
 =?utf-8?B?OFpubjczTDhpeUNYR0xwZVpUSmVDVnJUOWJPY0hIRU1ZaDdVR3JNRC93R3Vp?=
 =?utf-8?B?bVJadjNhRkZiREMvZS9HdEtnUitIY2hBcHJieHJjRzV0ODJ4MGcyZHB4U2Q4?=
 =?utf-8?B?a3FzSUlvVHgydkd1MTJOVXJwUkVCZ25Ob3NiSHNidWpwVHRPdXhveDBLY0pX?=
 =?utf-8?B?bnBUMGs2Z09qN0M2WlMrdVlPYnUwZm1GanBWZDV0VmZZOFRndFNrbHpyRGJP?=
 =?utf-8?B?RFNDeG9udHNtYUJwZTllR0c3a09CM01maDJ4NjBKNUc4dnFsczU4QmVxOTRD?=
 =?utf-8?B?Wm81VzVkbkdRNGR6b1RucFFmNkVra2ZJODFVRHJtUXh2WVNwekNJdWc4KzBM?=
 =?utf-8?B?aEtWN2hxTkJJbE13c3hsVmsycVBSOWIwWEJYeThyVVl2K2ZxQUkxNUlmT3FM?=
 =?utf-8?B?QmlBK3JhNk9WbktrdEJla3Axc3RiL2RBZ0JpMjJIQmtSZnJQR0o5VU9QQ2or?=
 =?utf-8?B?R1Zxd1lMSmdhSUtUS0tEUVM5OGpQeHlLZWx3RW8xR2ZxQnkyckdqamVVbFVz?=
 =?utf-8?B?U3JxZk05emFXZ0JGdEhYQnB6RFNtU3hqWGt5MUtmWXkrYmptNUFDZTdZNjlz?=
 =?utf-8?B?YXNRRmlvQ24rejl5U1ZTM1VaRHdMYU5xeEMyTXFmMG1RUE1OQUlqMERXNlND?=
 =?utf-8?B?V0FGQytIM3FvQitVbVdLUDBCSk4zSlZtWHh3ZzlNOWRnMlYxb2JzZ2tzd0h4?=
 =?utf-8?B?YThIZndGTUkyaWFOeG5tSVFoNk9UNGFGOXdvcmVGYytweWNmYmlGa2VWQlly?=
 =?utf-8?B?Q0RWM0RKWlhqYWpzV2hBYkNYaFVDSy9mQ1I0ZmI1eWluOXBRSVRQWldqUkNm?=
 =?utf-8?B?U2dVdkVsZHJJZjlMbGNXR2FQZGREZmI5cW9aTzVDb0tWYjhHRjlSb3p5Z0hV?=
 =?utf-8?B?eEl3VjdMMmhlbUpGbWFyRkRVcDRzUDBnUVpubVlycCtwT3pvdjNzc1UwSk0w?=
 =?utf-8?B?OXNxOUYyL3IveEhTR1gvK01NcStCWmErTjV1bngraVFacmg3bDM1eEJBUE5C?=
 =?utf-8?B?dlRsMFBrcWFyOUkwRzlYaGtvZkpFYkN6OGhnMFlVVlpJOXBwVFVMQzdteDFl?=
 =?utf-8?Q?i0NS8jIMVQbs+vHeLW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcd01e8-77ac-42f4-bc61-08de8f0111ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:39:49.3407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtekCKJdCzXMkSyhjWMrGqjqJaRYclWr1WUn7Lv+HiiJQI/ifoMRixpoUrq8rQ0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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

On 3/31/26 10:33, Wang, Beyond wrote:
> [Public]
> 
> This change is based on Linux 6.19-rc7
> 
> 
> Skip the expensive per-BO hmm_range_fault page table walk if no MMU
> invalidation occurred since last successful submit. Here it's a single
> seq counter compare vs the full HMM walk
> 
> On first submit the slow path runs and caches notifier_seq into
> bo->last_valid_notifier_seq. Subsequent submits check with the cached seq
> for the fast-path. If an MMU notifier fires, the seq changes accordingly
> and the slow path runs again on affected BOs.

Well absolutely clear NAK on that, we have intentionally removed that before because it leads to security issues.

Regards,
Christian.

> 
> Signed-off-by: Wang, Beyond <Wang.Beyond@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 25 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  8 +++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index ecdfe6cb36cc..140346e9cb92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -891,6 +891,17 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>                 bool userpage_invalidated = false;
>                 struct amdgpu_bo *bo = e->bo;
> 
> +               /*
> +                * Skip the expensive HMM page table walk if no MMU invalidation occurred
> +                * since last successful submit
> +                */
> +               if (bo->last_valid_notifier_seq &&
> +                   !mmu_interval_read_retry(&bo->notifier, bo->last_valid_notifier_seq)) {
> +                       e->range = NULL;
> +                       e->user_invalidated = false;
> +                       continue;
> +               }
> +
>                 e->range = amdgpu_hmm_range_alloc(NULL);
>                 if (unlikely(!e->range))
>                         return -ENOMEM;
> @@ -1326,7 +1337,19 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>          */
>         r = 0;
>         amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -               r |= !amdgpu_hmm_range_valid(e->range);
> +               struct amdgpu_bo *bo = e->bo;
> +
> +               if (!e->range) {
> +                       if (mmu_interval_read_retry(&bo->notifier, bo->last_valid_notifier_seq))
> +                               r = 1;
> +                       continue;
> +               }
> +
> +               if (!amdgpu_hmm_range_valid(e->range))
> +                       r = 1;
> +               else
> +                       bo->last_valid_notifier_seq = e->range->hmm_range.notifier_seq;
> +
>                 amdgpu_hmm_range_free(e->range);
>                 e->range = NULL;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 52c2d1731aab..89dc9ee1176e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -115,6 +115,14 @@ struct amdgpu_bo {
> 
>  #ifdef CONFIG_MMU_NOTIFIER
>         struct mmu_interval_notifier    notifier;
> +
> +       /*
> +        * Cached notifier_seq from last successful CS submit.
> +        * Used to skip the expensive HMM page table walk when
> +        * no MMU invalidation has occurred since last validation.
> +        * Zero means never validated (always takes the slow path).
> +        */
> +       unsigned long                   last_valid_notifier_seq;
>  #endif
>         struct kgd_mem                  *kfd_bo;
> 
> --
> 2.43.0
> 
> 
> 
> Thanks,
> Beyond

