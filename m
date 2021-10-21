Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB854C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9795E615E1
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9795E615E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C136E466;
	Thu, 21 Oct 2021 17:55:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1606E466
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 17:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTOBuM1wmCHpaZMgiCjMheQy3mN8igYBYBkYhmWAWM7SC4cVmAAPso/O+AUU/r56GaXulc+/b3MMs2kl/az8aqsXo4SubQyHKa9IPgz8V4cso6FoKxaAeD0aGTIuWUsjcX9wMWRcq1QqPIKPDeW+qogU2Mf7tUajImCfgQfjmLok6rlQbBAaHbrd0/lzUyJBp9gbGMDrPFD/Y+euNMt0HoVvb/PtvtFczne/mDIR0Ir57A5vkdEG8quv8tgQG0SitVydEuOyy5Y01yU+htcTItgStN9UvFcsf9eQQxmGQYuXJ6WWY6tGxOiHb3kc58Md/r1hjAYbdySSzQvi1JMtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+4vQAC+gb8LYMWKrlnJI0PlDFU4oP6OUeMajWZARC4=;
 b=Q5IWXQ+9zs3b18wBc4UJgYgewN5xwxa2p5Viunj3pHrbgtvHVu6C5a4Oe+pU2Bp4fHgoovRO2K6A4Q5dHhcZZhPBFyZjhKOt5zUmhr9Ztl96lBZOYcBVTezBn1zw4ZjKhYWqSI9srT3PLM2xQxKqXdHfBdjmAED99ckNaJlEjAlDSFQ784WyRrKLHs3NdaiKR9D7e01dfQn4VUA28LKDwD4dZJKZ35QDdUgqz8RvU2tVdI4vdQUTS0o1RpAKq56Fl+JUu3kZzcsJM+8hFaLX6h+dIR8Et3X0k9F7W+0L5TgCFhjdW/GNo2LKrXrp6k4vqWSsrx/qvund14b7skFrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+4vQAC+gb8LYMWKrlnJI0PlDFU4oP6OUeMajWZARC4=;
 b=EWJcCdgPXdpHbrNmHCeuKzG10ho4JXGFvs+4qJxQLekyT+2MNHLbuDW3P5EftpBEgp2n2uY52WehLnY1iBp5PR33FpjLxv6Rh4fbs/Zup0wpSU7QXOEgBqtCXRG1Q3kkwBDykvsHEeZJ27rP4QOdaEFqOj+YFf8Q2sQnZ1JcEJc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 17:55:42 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510%5]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 17:55:41 +0000
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <hwentlan@amd.com>, markyacoub@google.com,
 Sean Paul <seanpaul@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20211014153433.169454-1-contact@emersion.fr>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <f6993cb2-53e0-b4c8-48f2-c5bf4eaaf511@amd.com>
Date: Thu, 21 Oct 2021 13:55:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211014153433.169454-1-contact@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0863.namprd03.prod.outlook.com
 (2603:10b6:408:13d::28) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:56e0:6d60:7ecf:81fd:5f02:a76f]
 (2607:fea8:56e0:6d60:7ecf:81fd:5f02:a76f) by
 BN9PR03CA0863.namprd03.prod.outlook.com (2603:10b6:408:13d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Thu, 21 Oct 2021 17:55:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac161cc5-6ec4-46a3-3d5c-08d994bbff42
X-MS-TrafficTypeDiagnostic: CH0PR12MB5218:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5218EFDF22C8A5322667046B98BF9@CH0PR12MB5218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/yNUKZgkT0jVmNxEQWG3cER67DU6FhYztE0laCWrxmjWCGF+uAjhJTuPPse4fOwyjdGbMzQF3ns7KJR5cjcYHr+jNUog4qSZWttFLaRNG/Gw5mEtWv9qjHDuChe7pSlCIY/3zG1wnrbySE4QXPpQLJd2eQOyekiWjMEVbcmOq4wHjCdDK/U0iCLYnTAL2DDJ31U3QJfWXl52fFz8m1Bl4LY2qKJAbNAmo1gxNx3hYny4KilZ7QoB30TDYleQ2m9sOoJIEFL+uX9VR1EdjsAjyK4I2uH3rKQOUvxCzCfbK4YXnzv4+qSYB0KX55OyLppVseP/Aha+1E1nkqueTN9ys6lQX2TR9JSZrwHFQdOaoPPpw7m9zBndpWqmEF8KrCoJw0EjRfrQ3e+YOMdTLj08Gt0/d0vdd2KO3MLXg2gfMGOr3xjT9pP3xk864NwxqzFkbiXCcqUHOS3dmKRKc0c9tS75k/o8Gi9B9xnhADyX9jt5sRStU2nCDOyT7TRkTPCROR9ucVu2GV9BQmxIvqtqy08u8vvUVKXDfeEsJKGqWenyPx3h0Xxh966w6jXCDv8ymM3mtD7NOrhlRcHVIrE/cjx3C+Ohv4Il9Vr7FAJwo0SdfOjauC2g1M7yOA3eDHPfV+MVMEFItQ2EqeZtIM2+xvMsDp+1RGl/lONeJJW32xQgjfoVRBId3AR4OXBwsH4NWJkwOodmrxgsy9yMKN2e84P7j4H2J357pEsTYrjQ/hq3KYSNqyVnjZus0BVO8qYUWJACOsGZ/TwgOz/8BDKMGVSzPklKdGZRq9hpp3nkOf+Yae3g9snjZ1qwnjPpEeEqVOhAX3PsZ5MDOlsDmOVXlk/H6vx19/fA/hwD4H2BNM8Fr+kTKGiaQHsolO0YBTR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(38100700002)(2906002)(83380400001)(2616005)(66946007)(31696002)(36756003)(8676002)(4001150100001)(31686004)(110136005)(4326008)(53546011)(5660300002)(966005)(8936002)(186003)(6486002)(66556008)(66476007)(316002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWFWdTA1VERGVlZjQTFQZlZBcnN2Q3AxOEhiR3NRUDN2bVRCNWRic2lzMVBl?=
 =?utf-8?B?TDNwQUhuQ1JkOW4zZjV0M1N0dnBnM2JMWnMzRzk5M1V5SW9wd1pDMURTS2hr?=
 =?utf-8?B?Wk5Tak5WSDRFMVBrNmEzT3BTN210bERVeUJBNG9BTGlKTXA1V3oydTlmWUND?=
 =?utf-8?B?d2c2MlRBWnFXMmVOYk1RcE5QajlLaXpyTENjc3lkWHhSMzB3WkxKUlBrRWF1?=
 =?utf-8?B?VWI1aUNUY1IvQlpQRFlDMGM1VHJhNFNJcEVqbUdrblFoY1J1VEtTbFM3T2cz?=
 =?utf-8?B?bElvRDVuN2lycUN3UW1VOEt4MkZwZ0svRFhWbVROMGVsZjF5TkYvZEVPTFJH?=
 =?utf-8?B?bzlUUC9CeEFhSXpFM3Z4WW1VTXg5ZWtwRmhZQVkwc2pVK2c0VGRFemllMlZK?=
 =?utf-8?B?Mks0VVpwc0ErVkordWtTOXZ1RkY2SjNnRjVsZ0dzTFAzS1VMRW9nZWF4OW5j?=
 =?utf-8?B?TjVMVVluREJ2Ri9tTkZwSmxGblk1M0pzUnZISnZGMUgzSXZiVVdYWVlSL3Jm?=
 =?utf-8?B?RWpGZkVWcklNT2s4T01Qb3FXLzJHSGFIc3pPMEhpQ1llVUJoOG56R1hDY25m?=
 =?utf-8?B?SElrVWI1YkluTkczOUxnMmFFNjF1eGhUY2pEYUVRNzcxTjYrajlXSjJTOGRN?=
 =?utf-8?B?eGwxVS94MlBUOHNpVWV6ZXJUSjN1SnpOLzBIUFpzaW12VTFBWjRTUlIyUloz?=
 =?utf-8?B?R080dGVwbVFPOWFGNG14R2JPK0o2Zmltd3hKVUxxdW9IV0tFTFJqOUcxbjdU?=
 =?utf-8?B?dWRqd0JJTG5hbzFWY3cvMXk0d1BGYkdVVGFLTmFHcXBFZGhOdWxsS0h6VVhX?=
 =?utf-8?B?T2pIbFk4UXpKSCtmd1V4SzVSQkV3T2Ftcmw2VFl6TTlrdmVBc1NBTnl4R1ZC?=
 =?utf-8?B?SnkrNXczSjF6Q3N4MXFFakVzNVdWaENqUm55c1ArZE13M3ZuWWpoZGhkd3Yr?=
 =?utf-8?B?V2R3a0MrdjZrdW5oM1FhWktLcjNtY010VXRRYnQvbS9Pd2FxWW81RGpVM0pR?=
 =?utf-8?B?ZDFXODJ3RkZZVzB5Ny9ySHlsSnFnZ3owRXkxbng2OVVWSzQxUXVOK2FtTUtC?=
 =?utf-8?B?eGh4Ymxwb01IRysrNG8ySW93ekc5am0zd21hZEFMUnNjZ2NnNGtqeENqTHdl?=
 =?utf-8?B?Y1RmTnBQQm9XS2cwbDhnOFpPMm1aVk9HNFdid0x1NVNyVVZCazc1SjlVb1FR?=
 =?utf-8?B?TURTNFRaVTRlci9aUVlvcFliUWx3dHIzTFFXT1ZHZVpLeVNsY0RyRXJQNkVG?=
 =?utf-8?B?clFZOE00Q0JPcWxYVXVFK1VnbnN6S3FxWmsyTWhXNnBHL2F4RlNtZUlqNlQw?=
 =?utf-8?B?MFV0cWx6N3dxSDZ6cm5tSTZzakNBY0xHaEUvSitXVkpxTGduSi9hNjc1eC80?=
 =?utf-8?B?MVV5djlxZ2ExV3R3K2N6UVNvd0FVS21tUEhnNlVJV2I4UFAxTFhveVg4Z1pv?=
 =?utf-8?B?cVBYR2hmVmF4TGI4Zi9MOTZXZ0hCaVBmemk3UDFvMEVaTkhaVnRic25ycU45?=
 =?utf-8?B?SjlQTFNYZE1raHNORXFxT0lyODZiaTZZOVlQa1ZWMWU0aWtMUDBGbDIyb0pj?=
 =?utf-8?B?a1V2dEszOFlCL2o3cnNRNDc2ZmNUUWd3MEcyb0F6K05MTHhia0xkVU4zc2xH?=
 =?utf-8?B?dk1FL1lEcXpKdEo0U01WZ3dTdmJhbTlwRzVJeG5xT0NKaE80aXlkdzNLNUJH?=
 =?utf-8?B?Y1FhdnBFOG5RVDZrb2wvT0NqRW5pTFpIZTZmM01hNzY4SXVMVDVtMGRrSGc2?=
 =?utf-8?B?b1BBQ21pREM5UjgxOGlMVm1EcVZlWmY0a1dmN3dGZ1k2UHE4cnJGTkVMQmRD?=
 =?utf-8?B?bnM5Z0VPMXpKWnhQQ3hUSDZSeS9BZ3A2OFBWMEVlNXpORHl3TnJMaXIzeTZF?=
 =?utf-8?B?ZjhYYUs3WkdTaGhNL01weTVEQkRRcTJsNE1JOTRnSmhLM3hYUG1ISzFYS21E?=
 =?utf-8?B?Q1p6eFNRTExIaG9NczZ0cVpwVmtRaVVhTG5vdi81QzVYM2tqS0orQ0xGQ2wr?=
 =?utf-8?Q?krB+Eps1vyivqJOhSus/LSPZ2my5kg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac161cc5-6ec4-46a3-3d5c-08d994bbff42
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 17:55:41.8159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjordrigo@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
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

Hi Simon,

I tested this patch and it lgtm. I also agree to revert it.

Btw, did you send the revert patch for "amd/display: only require 
overlay plane to cover whole CRTC on ChromeOS"? I think we need to 
revert it as well.

Sean, Mark

For ChromeOS, we should ignore this patch. Do we need to take any action 
to avoid landing this patch on ChromeOS tree?

Thanks
Siqueira

On 2021-10-14 11:35 a.m., Simon Ser wrote:
> This reverts commits ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication
> when using overlay") and e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay
> validation by considering cursors"").
> 
> tl;dr ChromeOS uses the atomic interface for everything except the cursor. This
> is incorrect and forces amdgpu to disable some hardware features. Let's revert
> the ChromeOS-specific workaround in mainline and allow the Chrome team to keep
> it internally in their own tree.
> 
> See [1] for more details. This patch is an alternative to [2], which added
> ChromeOS detection.
> 
> [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=@emersion.fr/>> [2]: https://lore.kernel.org/amd-gfx/20211011151609.452132-1-contact@emersion.fr/>> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overlay")
> Fixes: e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay validation by considering cursors"")
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 -------------------
>   1 file changed, 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 20065a145851..014c5a9fe461 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10628,53 +10628,6 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>   }
>   #endif
>   
> -static int validate_overlay(struct drm_atomic_state *state)
> -{
> -	int i;
> -	struct drm_plane *plane;
> -	struct drm_plane_state *new_plane_state;
> -	struct drm_plane_state *primary_state, *overlay_state = NULL;
> -
> -	/* Check if primary plane is contained inside overlay */
> -	for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
> -		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> -			if (drm_atomic_plane_disabling(plane->state, new_plane_state))
> -				return 0;
> -
> -			overlay_state = new_plane_state;
> -			continue;
> -		}
> -	}
> -
> -	/* check if we're making changes to the overlay plane */
> -	if (!overlay_state)
> -		return 0;
> -
> -	/* check if overlay plane is enabled */
> -	if (!overlay_state->crtc)
> -		return 0;
> -
> -	/* find the primary plane for the CRTC that the overlay is enabled on */
> -	primary_state = drm_atomic_get_plane_state(state, overlay_state->crtc->primary);
> -	if (IS_ERR(primary_state))
> -		return PTR_ERR(primary_state);
> -
> -	/* check if primary plane is enabled */
> -	if (!primary_state->crtc)
> -		return 0;
> -
> -	/* Perform the bounds check to ensure the overlay plane covers the primary */
> -	if (primary_state->crtc_x < overlay_state->crtc_x ||
> -	    primary_state->crtc_y < overlay_state->crtc_y ||
> -	    primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc_x + overlay_state->crtc_w ||
> -	    primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc_y + overlay_state->crtc_h) {
> -		DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but does not fully cover primary plane\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>   /**
>    * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
>    * @dev: The DRM device
> @@ -10856,10 +10809,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			goto fail;
>   	}
>   
> -	ret = validate_overlay(state);
> -	if (ret)
> -		goto fail;
> -
>   	/* Add new/modified planes */
>   	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
>   		ret = dm_update_plane_state(dc, state, plane,
> 

