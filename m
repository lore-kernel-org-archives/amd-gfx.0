Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57335C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E167610FA
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E167610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D676E2E1;
	Wed, 25 Aug 2021 15:01:56 +0000 (UTC)
X-Greylist: delayed 50894 seconds by postgrey-1.36 at gabe;
 Wed, 25 Aug 2021 15:01:55 UTC
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069896E2E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 15:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUD7/iQrHJ8j/Wq/0f7N7fZYNtECzclzJLKNpC047Mi80A7pyAd3rWQX22erGcIAxEScsKbD2ZxzMPbcI5Z8E44avMNC0FzXH2VU7y9e3aLrysDUYPGqvREfmTeZ7pViuflEII76XHwSoXa7+7rU/V86bByMeyGdStkdRSpkug/C2DNz7yUFaN5RbT/BKqE7L7LTOMTf8Hi5MZG96oNoZBdrSpEVg4n4j4R20OcLc55D/00Xgg6zyh5gm6S6B6iarEcMF8sevlOmCodVFA+7KAdI3TlQQEpbbObzBJzmVvioL3nfBXpFYPqD/w1KwqIRm12veUpZCqzzFjR9IkTjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD61IcARAtL05IAEm+kQi5wUu292oRZfTEMoR6c3hWw=;
 b=Q8/vOI/5i/sC4wmfviwPz2JtKjnVGS7hTszNo8b57Gnw+53b91FzqhMsYRZgmrrhrLz5NkyXxpOPz2eh58ei3gS27pB9EtLsW+ELXI6rRUYNAuR8o0oiSO7c6JbvLbF/2EvzRFJll7Af5/1jnFr1/LWQXgaLrydC2nqz4GQhAH8p7hSIEG9n5vNIBV+BRDGVqkzjo6FGZsvX+ABEcBLzOjvCIC9lKYMYaexizeucz8BfVlay75egwOC3Ms5NxvemKyggGgQzo7a8Q31rae6YqNm4eaRTacHxgWADFLsHIdk3swIzWMtWxRPYOzAYaXKku1vuuKqm711kvTKj5AH0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD61IcARAtL05IAEm+kQi5wUu292oRZfTEMoR6c3hWw=;
 b=w0LXO6xSyUJ8yr2nU9sVlHmJ/NL8jNeDpJbQ9X2fY0N5FSZDdwepyGEN9b6mGsqwsAYFixhIT+2C8Ng1uSDhrBI+y6T8hs23BVCuUC1f1E+ggAlQm34BQEzKPGt6yYPYIZVkITJ7JwxJB3+e1IUNDWVVRuHN24G0+cdRgZ2O23E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Wed, 25 Aug
 2021 15:01:52 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 15:01:52 +0000
Subject: Re: [PATCH v3] drm/amdkfd: Account for SH/SE count when setting up cu
 masks.
To: Sean Keely <Sean.Keely@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210825031015.96536-1-Sean.Keely@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cd416b58-ac92-9d8d-55fe-f94f194cd36c@amd.com>
Date: Wed, 25 Aug 2021 11:01:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210825031015.96536-1-Sean.Keely@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::24) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 15:01:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f1b6a79-2890-48c2-9859-08d967d945a2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5382D8CD82C5E4A45F52113A92C69@BN9PR12MB5382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHef2iDjnE5IaC9lbXgIrWqIIrk0rMVqaqtea3Ynj7TCYQVFUjZIiN+iIa9EzdQNnnUndNh49mwOmgfy4Y8hOqMRnbCWl3T4ixwxtcPr4zSwv/xgme2LQLrira/gteXsDZs8NegJKCkKMFt1e8WoqokhnrAuljVoytHDLFGJLqEiWToHknnaZXup758URHTibzQlcEhqiMvnrVL4+L2k/UStqkTtve44ZAYoJM0Ery2zMtj/cS9T8GHPWZFAQK8HpQCgf4DlVFfU40Qo0+JAr0yCMqlHfB59MvjGykIV1tAa7TozLWoH2WLrGuARhlyPOIVapJLMI/8C2rcQ1c69ERJbuEKjFfN6GATXJtPayaCAUnkVJPHfsF+9GjvEZdliKyRe+ELZ62Y0louMMmTxvvbkh1L4tOWu0rCsE6bYVhcZs6ayXutNeVUGzcuzBOkH2V+yutsO9gDX/rWkDJd1tXrVJ3idYXFlyNXORuURMIFu/pFjSTnZgbv0QbLmdI+4TFQHwY606L4YtiWTSHLSGdbll1s2mvSAd27I6B8vNm2adsZgUMgM5NcbnGObU6GqGXq0WWNQBYIh41qVJK3qJ/+2Q7+KW+tzq6PuOiDdhq0zTliBzTox90AE6jXDluQ44HuCA8nknuwBoKeoi8bIi0nZ6PtBi1b3TuepBM8UkB6ENvBWiVGRD2tXkfAZVFfdBRYXRKJ6COJCnFDB819BlCdweMls0LB4r1amesHPKos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(478600001)(36756003)(6486002)(38100700002)(186003)(83380400001)(16576012)(8676002)(26005)(2906002)(66476007)(2616005)(44832011)(316002)(66946007)(31696002)(66556008)(956004)(86362001)(8936002)(31686004)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnNNcUd6SHU1NndaMFZMZTBoQnhTRXo4NjNHc3EzQjFVbndrYVVFc0svWVhX?=
 =?utf-8?B?OE54ZUVuU3B2SEIrVWkxaTliY3Mvb2hLRklYMkpEL0pWNkJxbXZ4M0RuUE5S?=
 =?utf-8?B?UkVnMkF3OU56ZHN6ZXJtUnh6S0poMDhBS1EwUUgvaUxGZ0x5K3g3U0V3bWZ2?=
 =?utf-8?B?cjhRVzdNMzB5c1BZZU9oNlVjWkpPWldTdW9hWmhiOThCY2RTNzNTSGNVK3FL?=
 =?utf-8?B?TndtOFcvL21JVXN4SWRDVkhTSDA4ZzVWSzl4MS9mcCt0c2xNQmd3V2dYU3VI?=
 =?utf-8?B?ZXRRY04rK1pXRitOYTRDR3VSMll0Z3AwVnc0UFkyYlNzYVZ6R1VEWTgwTU5C?=
 =?utf-8?B?MzZsMzd5OVloSlpnNHkrU3QwRGhzdFhtc21RbUplV3RzK0FNaXJUc2REeXdO?=
 =?utf-8?B?UUlhUCtIZ01lMFhYQUxORml0aE5pMU1VcXVrcDM4SUJvMXVtYUVia09JcXBX?=
 =?utf-8?B?NlIwYlJJQ2o1WVFxVkZqVkR2QUp4VkpGQkZTQmtZV2hnSWl6dmJSNTZxUzkx?=
 =?utf-8?B?RW9rdXBYU05aM2duK2hMcXlndVl2ekIzRlVXanZkWWNDVjYzNXZobkl4SS8w?=
 =?utf-8?B?cTJ1SDg4eG8ydkhxT3lNdTZCVnRWdytpNk4rVTdiSXRWS290cSswQXVVTFhp?=
 =?utf-8?B?c2Fmd0dZNGVadmN6OUNZWFBlUy9iV3hNbEhnWkh3SXZBSitmZUF6dkI4bURs?=
 =?utf-8?B?aWtOWW5NQ01UYzdVdi94UDk5clFUeEpXWURpcDdxRUhjOTM3c0MraHRjTi82?=
 =?utf-8?B?eDY0TzVBdTRxdGhRQzVMRGlPQmVYanhDNVlHWXRDd0t5V24wZGs4R29jS2FR?=
 =?utf-8?B?TE1TNjN3SXVpMERNQ1orNTc4OHBucS9SSHB4YzR3TjNsbGl4eElsSUVZTUgx?=
 =?utf-8?B?TkRvdXpoWm1SUVN6d2dyMzhVMXRvaXh6UVBxQ0F3ZlNNUSttMENqMVRJektj?=
 =?utf-8?B?V2txUEhWdmVSQnRwK1BCY1RaWVl6cEswZnZURlhodkVZc2RxQ3NBNEtENnNx?=
 =?utf-8?B?VkRpNjlVSlViVWpkWGlIcjNvc0srQ1UyMDZwTzNqTmpFSEtVNGw2dVpjUDF4?=
 =?utf-8?B?NlhzNkdtWTVpSUhTS1JKMVlWbGg1ZExHYTZLT1RxaWs0NUZINnV6RXh1OUR3?=
 =?utf-8?B?Rkw1QW1KdWsramFGQ2NodE9yM3NzQ3BvYUg0OTY2MXNqd1FxcGlyczUwS094?=
 =?utf-8?B?SkhVZG9tR1pxR0FoRzlSNjJJUEV0a0QwYUkwUUtPZWR4Q1NPRHMvZk1NaHh6?=
 =?utf-8?B?WmZlcmJ5bUgxUHJJRTUxbnJVUXpJQmZkaTJoN3Nud0F5TDJ0VHNoYmorNVM3?=
 =?utf-8?B?ZWNvQVRQbUNBd1F4dEhza01NTGxOaittK0hKR21PT0pkWDFvTTFaSG9LeDhR?=
 =?utf-8?B?TlVNS0pOd25obGZqMUVuV0R3cWNFVmJEa0dPUTU1Z1hvUGc5NGdsd251Zk9w?=
 =?utf-8?B?c1VISWlyVU9GRUo2WEl6MDRIMzdxV2l0VXdYaGZmVCtLMzhlZXdiMnY2ZU4y?=
 =?utf-8?B?OHJxQ0hYbE1rRHFKZ0VLeWZSWHVFeDVCTVhtNHNTNjRuNUc4dVk2QVpIdW9X?=
 =?utf-8?B?d25tUkxQYW1yNEN2RmVrNjhFQnRLRzNmbjl0bUg4aitvUWQ3Ri9ISEJzT1hN?=
 =?utf-8?B?Mi9uRHFzNDRlUldtZnJNWFEvb0ZBdUJRZ2l5TUNIR2xabEM3Nk94S1VNSmVI?=
 =?utf-8?B?WFNvVzBueXhjeW1YT1J5QW9mMVBWaHNucmFLcUlGaDVJRlZEVE1jOFFLU1A5?=
 =?utf-8?Q?67eN9yvRK3XCsaDULJyjEAvPBFrTiQ5stEckJXt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1b6a79-2890-48c2-9859-08d967d945a2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 15:01:52.5265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5MO0YPeubSxJVcz3FwsjmnB2t9qU7Qle8IolQIn7Ykda0IMBN8uWF/qXKXjQOSMLCmoO7faR4T5tbwNTjPsLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
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

Am 2021-08-24 um 11:10 p.m. schrieb Sean Keely:
> On systems with multiple SH per SE compute_static_thread_mgmt_se#
> is split into independent masks, one for each SH, in the upper and
> lower 16 bits.  We need to detect this and apply cu masking to each
> SH.  The cu mask bits are assigned first to each SE, then to
> alternate SHs, then finally to higher CU id.  This ensures that
> the maximum number of SPIs are engaged as early as possible while
> balancing CU assignment to each SH.
>
> v2: Use max SH/SE rather than max SH in cu_per_sh.
>
> v3: Fix comment blocks, ensure se_mask is initially zero filled,
>     and correctly assign se.sh.cu positions to unset bits in cu_mask.
>
> Signed-off-by: Sean Keely <Sean.Keely@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 84 +++++++++++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h |  1 +
>  2 files changed, 64 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 88813dad731f..c021519af810 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -98,36 +98,78 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>  		uint32_t *se_mask)
>  {
>  	struct kfd_cu_info cu_info;
> -	uint32_t cu_per_se[KFD_MAX_NUM_SE] = {0};
> -	int i, se, sh, cu = 0;
> -
> +	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
> +	int i, se, sh, cu;
>  	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
>  
>  	if (cu_mask_count > cu_info.cu_active_number)
>  		cu_mask_count = cu_info.cu_active_number;
>  
> +	/* Exceeding these bounds corrupts the stack and indicates a coding error.
> +	 * Returning with no CU's enabled will hang the queue, which should be
> +	 * attention grabbing.
> +	 */
> +	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
> +		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n", cu_info.num_shader_engines);
> +		return;
> +	}
> +	if (cu_info.num_shader_arrays_per_engine > KFD_MAX_NUM_SH_PER_SE) {
> +		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
> +			cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines);
> +		return;
> +	}
> +	/* Count active CUs per SH.
> +	 *
> +	 * Some CUs in an SH may be disabled.	HW expects disabled CUs to be
> +	 * represented in the high bits of each SH's enable mask (the upper and lower
> +	 * 16 bits of se_mask) and will take care of the actual distribution of
> +	 * disabled CUs within each SH automatically.
> +	 * Each half of se_mask must be filled only on bits 0-cu_per_sh[se][sh]-1.
> +	 *
> +	 * See note on Arcturus cu_bitmap layout in gfx_v9_0_get_cu_info.
> +	 */
>  	for (se = 0; se < cu_info.num_shader_engines; se++)
>  		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
> -			cu_per_se[se] += hweight32(cu_info.cu_bitmap[se % 4][sh + (se / 4)]);
> -
> -	/* Symmetrically map cu_mask to all SEs:
> -	 * cu_mask[0] bit0 -> se_mask[0] bit0;
> -	 * cu_mask[0] bit1 -> se_mask[1] bit0;
> -	 * ... (if # SE is 4)
> -	 * cu_mask[0] bit4 -> se_mask[0] bit1;
> +			cu_per_sh[se][sh] = hweight32(cu_info.cu_bitmap[se % 4][sh + (se / 4)]);
> +
> +	/* Symmetrically map cu_mask to all SEs & SHs:
> +	 * se_mask programs up to 2 SH in the upper and lower 16 bits.
> +	 *
> +	 * Examples
> +	 * Assuming 1 SH/SE, 4 SEs:
> +	 * cu_mask[0] bit0 -> se_mask[0] bit0
> +	 * cu_mask[0] bit1 -> se_mask[1] bit0
> +	 * ...
> +	 * cu_mask[0] bit4 -> se_mask[0] bit1
> +	 * ...
> +	 *
> +	 * Assuming 2 SH/SE, 4 SEs
> +	 * cu_mask[0] bit0 -> se_mask[0] bit0 (SE0,SH0,CU0)
> +	 * cu_mask[0] bit1 -> se_mask[1] bit0 (SE1,SH0,CU0)
> +	 * ...
> +	 * cu_mask[0] bit4 -> se_mask[0] bit16 (SE0,SH1,CU0)
> +	 * cu_mask[0] bit5 -> se_mask[1] bit16 (SE1,SH1,CU0)
> +	 * ...
> +	 * cu_mask[0] bit8 -> se_mask[0] bit1 (SE0,SH0,CU1)
>  	 * ...
> +	 *
> +	 * First ensure all CUs are disabled, then enable user specified CUs.
>  	 */
> -	se = 0;
> -	for (i = 0; i < cu_mask_count; i++) {
> -		if (cu_mask[i / 32] & (1 << (i % 32)))
> -			se_mask[se] |= 1 << cu;
> -
> -		do {
> -			se++;
> -			if (se == cu_info.num_shader_engines) {
> -				se = 0;
> -				cu++;
> +	for (i = 0; i < cu_info.num_shader_engines; i++)
> +		se_mask[i] = 0;
> +
> +	i = 0;
> +	for (cu = 0; cu < 16; cu++) {
> +		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
> +			for (se = 0; se < cu_info.num_shader_engines; se++) {
> +				if (cu_per_sh[se][sh] > cu) {
> +					if (cu_mask[i / 32] & (1 << (i % 32)))
> +						se_mask[se] |= 1 << (cu + sh * 16);
> +					i++;
> +					if (i == cu_mask_count)
> +						return;
> +				}
>  			}
> -		} while (cu >= cu_per_se[se] && cu < 32);
> +		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index b5e2ea7550d4..6e6918ccedfd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -27,6 +27,7 @@
>  #include "kfd_priv.h"
>  
>  #define KFD_MAX_NUM_SE 8
> +#define KFD_MAX_NUM_SH_PER_SE 2
>  
>  /**
>   * struct mqd_manager
