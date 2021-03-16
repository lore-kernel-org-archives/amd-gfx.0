Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF78C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 15:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB331650DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 15:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB331650DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699D3892CC;
	Tue, 16 Mar 2021 15:24:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D1C6E405
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 15:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n01v4b6GEaCUWX5U1ug7iTVKuKGXjhlUxsGH1b9bINm4vyT/gQ1a8F+tCI52OAO86fHSgcPldbLF/OX1jJH/1iAcGtqp+TV+3IRraxlXjbeY3npuSt3n2+3J3hz6Twa3IuGL5fZ3vN05rNs569It39ZeektKP/GyRSN7atmxisVO+Ajyu19yl0L8oit+wPZ0Z7NMozqMo+RcVeqOvWQ62+NaJmJ3EzhTd6uvx+7COpGuHi4R8qTOzIGuS/aLqIfN3T1Rnc1YyYo+zDErVC9xHsY406PGAAFLGjzZpNQG3K4Qru/rL4r8a95o/u4tnjjrrRrO2U5G1gPaP1hQ3Hue/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+2T6gS3xbB0ASYcLBJiKROzzKNO6A3IfnEZcRT2EYY=;
 b=UqxAwPFfl6IuennBdlIXlEpOu62AgiOxNm6XGQPvuefkjK9zNn2aabDtvURdud/3qDVLjp+nTxMooG+DOUPYuDgtXdSPPFpOxKtKeHJRjSMFY00fAkiPoyopOdQ2Vs3M+vALUYpX2sakSp+yMEwDebMjJO3ZBTtoM/pxYcUAIZw1ZnixgJ9QU4acTVPfJZ9D3gjWkICYmnF8jfShKcMeLIAIsEKStWm4Q/o5bl/wSuuNQPX4QgpFZ6gbfauta2ziOCdU2873gibU71r/BQJAxUvm42fWasJ4QFzPxVFTmwBf/SV0dFAFGNhw9K86bxlplzetGDz9D4HYjs1IqfkVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+2T6gS3xbB0ASYcLBJiKROzzKNO6A3IfnEZcRT2EYY=;
 b=mDBGRl26zwja3gDJXmHxnyOr/qN+f3Bgjp0AvAjiNC0hEw9H4I3d4LkApFy6DcqyhjWjXCnHhLSCjztjEy7SisZpbl6hrrBX4uq8z3iIqKNPFS22m6F4CDyfCYigYOrVqO5P3HLYVX1SwmzL76BhF5E7wkUnkLYvR7wJTjJgzik=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 15:24:41 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::6c8a:904f:7403:8d60%5]) with mapi id 15.20.3955.018; Tue, 16 Mar 2021
 15:24:41 +0000
Subject: Re: [PATCH] Revert "Revert freesync video patches temporarily"
To: Nikola Cornij <nikola.cornij@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210316151556.4299-1-nikola.cornij@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <b81f93e3-c5be-ead1-b6b8-c59932d393ed@amd.com>
Date: Tue, 16 Mar 2021 11:24:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210316151556.4299-1-nikola.cornij@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.1.132] (165.204.55.250) by
 YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 15:24:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5fae19c-2e8b-4169-6ea4-08d8e88f9e4f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB50738BBB777E7693128FBAB88B6B9@CH0PR12MB5073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6jDnmnx9nueZsxzCtKCVsU0BJAQOc2VPdT+4n8Kiwv6+bgMf3EcXkgICDEXWGp25a4Rqvs6PH9lCOtnlSiGOzdsmQ6/LX6vQPw5CefoWlFj0R4l016qYKpSPlsMhrxo444oyf7OdqYQ7mA/xogzu56uNAD16hKZYpD9s3TeiVzuybU+CzGz+ok2WmhKhDUe1fQngMyWkivRheh76T+55YA1d0ayl81ZJA1zfpH+BAYtCQQAl6jSVqiCXYJvHXDOp57YLXsWHV4GyWY6OXr5WRJxgkSIFTrb/QjNFc2vWUxCJyV5AMopr9LPVdDBatN4hHry/3gKEM6TOApz123iS0RS4yz3txCaD1yKcsw+eAMkjn8582Q5yDryQEkp/1GvLO4yRuFAMsLo6QjAy6iLHHM/SbZYQ607TFBqJ5RR0ln0Q/VkS48hT3r3WPvqnI5Rh+Qmvh10/bxcORX2IZVV5PdIKLI67WInuecgGRPs3GIq2M6zTnPYfZoLAL6l2cURIhG2F9weZQN/ncRbM0BtbTNVz8Gbr04IFSiENv5LurHNG7x3gg9BnTirB4MAUNvyKldQ8RJDrkZmfPSpHMM99TOpqMyaYEES7T1UmRlzSdwGSyv0MzxRfLetLsCcvkNrAba3pdMVKBzvEIk+z79FGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(186003)(16526019)(2906002)(44832011)(956004)(2616005)(26005)(316002)(8676002)(66556008)(478600001)(16576012)(30864003)(31696002)(6486002)(86362001)(66946007)(66476007)(5660300002)(83380400001)(52116002)(31686004)(53546011)(8936002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N3pjVERwcmF2L0lMSVVMSlVpdVo4aDJTRWxqNTQvcXpQbEh4SkF6Q0lqNGF2?=
 =?utf-8?B?MFQzNUFhTVIrb01KbUM1NXRlM29TSzhjL3l0Ry9lWWx3elhTRXl6cHpMYWhi?=
 =?utf-8?B?WTZRSFFSMUdpSlZ5V1lHdnhwQndkU202R214aUJGdk02WjZONzl2K0o1cGE5?=
 =?utf-8?B?S1RJdVdmT2hOd1hFQThBeGFGWU5DMjhOdEZJMjBrck9aWFZQNTZOaG9lWXZi?=
 =?utf-8?B?QkJ0Si9DbThkMGNidGRWNnI5aVJpbjRRcHlZK0VvL2VWSjhPM214ZFhDOGF2?=
 =?utf-8?B?MjdjajJXUVRhK3RzN2RHeHZaT1FvNHpacnVJQ1RPUFZLSDhQbXE5UFJ0MS8y?=
 =?utf-8?B?V3ZqVGIva25EclQ1V3BlVDVRMDZoTlA2bmFpSWpaZWdBYjhNNFRWamJVWWk0?=
 =?utf-8?B?NGlWRjlaRlUxWU9hSHFPT1dIUDBsd0I4TXl0Z2hGLzI3K0l3MzdBUmhjNld3?=
 =?utf-8?B?elpqOXZNalVWN0RHRmlBRGN2UGg5Tm9oZVFvaGtPTmFsd1BUbW1IWXZmTmYz?=
 =?utf-8?B?L0NvbEt2YUJmK01wc20vMHVnend6YUpxSzhVRFgxN1BNU3Y0b3RTWFFKZnhI?=
 =?utf-8?B?Wko3ZitoZGhFdzZZN05pcGhvRWZHRW9DK3pDWnNCVnBmQ2cvZk80NzdXMjB2?=
 =?utf-8?B?bGQvSlFGSDJSY3Q2RTcrcTRSSDZ2MC9kRzRIRTArRzd2cWdENjErN1V6SzdR?=
 =?utf-8?B?VEtINkQ2MkFJSEozenVmeDdOQXc4M1ZSczNSRzlKcFR0Qjk2TjlxSnNuYzNE?=
 =?utf-8?B?ZTUrcWRxY0JaOXVVVHZBU0xKYXVUWUEvVlhmUmlTaFBwYTkvQ0JsNE44RUlm?=
 =?utf-8?B?WkllVlZ3OGx1UTNwYVMrenNMVGJlL0hhTEozdTZHaWtjbkxNR3pqbjhWdlg5?=
 =?utf-8?B?VlBRNlk4NnpzRkQ2Q3lvbmNjVWg5bkpCdnVkSWYvenVnTXJoODVCRFRwMlRI?=
 =?utf-8?B?c3oyNWNXdFJEb0hobDgxNEx4eGs1UWlpaUNwUVZOcm1xR1dLL2hIeEtBakFr?=
 =?utf-8?B?Tjl6VU5ySWpHS1E5blJVN1U5NDc5M1ZEWkFGR2sxSkdmYmZYMHh2MTltaUNU?=
 =?utf-8?B?YW9ORHJ6OU5mdjM5VTQzZEs5YVpzRk5FckxjVkpHdWhjeEZGaXRBREp3azAz?=
 =?utf-8?B?cE0vODZDVjBZSU9XbzhTWkxXbXk0N1Z2ai8rR1A0RHBkK0ozSXl2YlAzZXdj?=
 =?utf-8?B?R3E3THVFeGNkRGFFSk5lRHBHK1loWXZkMVQwclNWV2wrUG5PNm44enNsdGhE?=
 =?utf-8?B?MnppK1NnaGR3aVFDRmN2b2ljbnJwNjgwcWpLQkR1MkovcWE1U01kcHhiQjZ0?=
 =?utf-8?B?UU54d1RDWFpnWW1Sa3VTL3pjV2ZsS29XSjdVUEs3d2QrRU92WW9DNDFIRGEw?=
 =?utf-8?B?OHVGMGJwYktHOTA2ZFlManVLUFNoY0Vqd3hnV2k1YXFEbFJrdVlnaHNOcGlH?=
 =?utf-8?B?b0tTSGFSVkFWQkJvbFJoZE5VTFJQRkxqdmFQWFkyanhmYWkyczEwV0ZWYkFi?=
 =?utf-8?B?ZDVKeUROdDMwZHVma3JRWjZvV09uWjN0Z3ZXcVdoMitGc0h2b2Jrc1ZEQmJT?=
 =?utf-8?B?ZWV0NG5RL2l3TUlDUm56ZVhxbnBKQWF1MkVuL294N3ZQelhLTG9QRUlFa0ZZ?=
 =?utf-8?B?NERyZVQwWml4MjJmSHhQWTM0cDlobjlHOTJyVDUwRDdpZER1N0xOakg2TmZY?=
 =?utf-8?B?OSthc0dlQUd1U1BvMlhJZHpLYkhPOUxjYnBxQWZEZ0Y5eHNRTzQwbVFqQkZ2?=
 =?utf-8?Q?1YP/kCh7wN27GuEjriw2ca7NdlBmxaTGEWuYNBm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fae19c-2e8b-4169-6ea4-08d8e88f9e4f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 15:24:40.8999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drgKz6rLMVqkWRVAF4ThxBlEU5LNIV4WCwpuuLNIHO5wO4u6ViCmGCsngGv82cYzKJ5AZ00r+MKHvZfVEBzuxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai at amd.com>

On 2021-03-16 11:15 a.m., Nikola Cornij wrote:
> This reverts commit e9a777fc0c264542fbd6d51b8fe51739d09032c1
> 
> Sinc this is a "revert of a revert", the end effect is that freesync
> video is back to its original state, the way it was before the first
> revert.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 369 ++++++++++++++++--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
>   4 files changed, 349 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5da112b3feb0..428b9f2d38c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -189,6 +189,7 @@ extern int amdgpu_emu_mode;
>   extern uint amdgpu_smu_memory_pool_size;
>   extern int amdgpu_smu_pptable_id;
>   extern uint amdgpu_dc_feature_mask;
> +extern uint amdgpu_freesync_vid_mode;
>   extern uint amdgpu_dc_debug_mask;
>   extern uint amdgpu_dm_abm_level;
>   extern int amdgpu_backlight;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1be42edf84d0..d6a9787e5597 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -166,6 +166,7 @@ int amdgpu_mes;
>   int amdgpu_noretry = -1;
>   int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz = -1; /* auto */
> +uint amdgpu_freesync_vid_mode;
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   
> @@ -828,6 +829,17 @@ module_param_named(backlight, amdgpu_backlight, bint, 0444);
>   MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
>   module_param_named(tmz, amdgpu_tmz, int, 0444);
>   
> +/**
> + * DOC: freesync_video (uint)
> + * Enabled the optimization to adjust front porch timing to achieve seamless mode change experience
> + * when setting a freesync supported mode for which full modeset is not needed.
> + * The default value: 0 (off).
> + */
> +MODULE_PARM_DESC(
> +	freesync_video,
> +	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
> +module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
> +
>   /**
>    * DOC: reset_method (int)
>    * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco, 5 = pci)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8b464debc1ef..553e39f9538c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -212,6 +212,9 @@ static bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
>   static const struct drm_format_info *
>   amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
>   
> +static bool
> +is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
> +				 struct drm_crtc_state *new_crtc_state);
>   /*
>    * dm_vblank_get_counter
>    *
> @@ -335,6 +338,17 @@ static inline bool amdgpu_dm_vrr_active(struct dm_crtc_state *dm_state)
>   	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
>   }
>   
> +static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
> +					      struct dm_crtc_state *new_state)
> +{
> +	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
> +		return true;
> +	else if (amdgpu_dm_vrr_active(old_state) != amdgpu_dm_vrr_active(new_state))
> +		return true;
> +	else
> +		return false;
> +}
> +
>   /**
>    * dm_pflip_high_irq() - Handle pageflip interrupt
>    * @interrupt_params: ignored
> @@ -5153,19 +5167,16 @@ static void fill_stream_properties_from_drm_display_mode(
>   		timing_out->hdmi_vic = hv_frame.vic;
>   	}
>   
> -	timing_out->h_addressable = mode_in->crtc_hdisplay;
> -	timing_out->h_total = mode_in->crtc_htotal;
> -	timing_out->h_sync_width =
> -		mode_in->crtc_hsync_end - mode_in->crtc_hsync_start;
> -	timing_out->h_front_porch =
> -		mode_in->crtc_hsync_start - mode_in->crtc_hdisplay;
> -	timing_out->v_total = mode_in->crtc_vtotal;
> -	timing_out->v_addressable = mode_in->crtc_vdisplay;
> -	timing_out->v_front_porch =
> -		mode_in->crtc_vsync_start - mode_in->crtc_vdisplay;
> -	timing_out->v_sync_width =
> -		mode_in->crtc_vsync_end - mode_in->crtc_vsync_start;
> -	timing_out->pix_clk_100hz = mode_in->crtc_clock * 10;
> +	timing_out->h_addressable = mode_in->hdisplay;
> +	timing_out->h_total = mode_in->htotal;
> +	timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
> +	timing_out->h_front_porch = mode_in->hsync_start - mode_in->hdisplay;
> +	timing_out->v_total = mode_in->vtotal;
> +	timing_out->v_addressable = mode_in->vdisplay;
> +	timing_out->v_front_porch = mode_in->vsync_start - mode_in->vdisplay;
> +	timing_out->v_sync_width = mode_in->vsync_end - mode_in->vsync_start;
> +	timing_out->pix_clk_100hz = mode_in->clock * 10;
> +
>   	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
>   
>   	stream->output_color_space = get_output_color_space(timing_out);
> @@ -5332,6 +5343,86 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
>   	set_master_stream(context->streams, context->stream_count);
>   }
>   
> +static struct drm_display_mode *
> +get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
> +			  bool use_probed_modes)
> +{
> +	struct drm_display_mode *m, *m_pref = NULL;
> +	u16 current_refresh, highest_refresh;
> +	struct list_head *list_head = use_probed_modes ?
> +						    &aconnector->base.probed_modes :
> +						    &aconnector->base.modes;
> +
> +	if (aconnector->freesync_vid_base.clock != 0)
> +		return &aconnector->freesync_vid_base;
> +
> +	/* Find the preferred mode */
> +	list_for_each_entry (m, list_head, head) {
> +		if (m->type & DRM_MODE_TYPE_PREFERRED) {
> +			m_pref = m;
> +			break;
> +		}
> +	}
> +
> +	if (!m_pref) {
> +		/* Probably an EDID with no preferred mode. Fallback to first entry */
> +		m_pref = list_first_entry_or_null(
> +			&aconnector->base.modes, struct drm_display_mode, head);
> +		if (!m_pref) {
> +			DRM_DEBUG_DRIVER("No preferred mode found in EDID\n");
> +			return NULL;
> +		}
> +	}
> +
> +	highest_refresh = drm_mode_vrefresh(m_pref);
> +
> +	/*
> +	 * Find the mode with highest refresh rate with same resolution.
> +	 * For some monitors, preferred mode is not the mode with highest
> +	 * supported refresh rate.
> +	 */
> +	list_for_each_entry (m, list_head, head) {
> +		current_refresh  = drm_mode_vrefresh(m);
> +
> +		if (m->hdisplay == m_pref->hdisplay &&
> +		    m->vdisplay == m_pref->vdisplay &&
> +		    highest_refresh < current_refresh) {
> +			highest_refresh = current_refresh;
> +			m_pref = m;
> +		}
> +	}
> +
> +	aconnector->freesync_vid_base = *m_pref;
> +	return m_pref;
> +}
> +
> +static bool is_freesync_video_mode(struct drm_display_mode *mode,
> +				   struct amdgpu_dm_connector *aconnector)
> +{
> +	struct drm_display_mode *high_mode;
> +	int timing_diff;
> +
> +	high_mode = get_highest_refresh_rate_mode(aconnector, false);
> +	if (!high_mode || !mode)
> +		return false;
> +
> +	timing_diff = high_mode->vtotal - mode->vtotal;
> +
> +	if (high_mode->clock == 0 || high_mode->clock != mode->clock ||
> +	    high_mode->hdisplay != mode->hdisplay ||
> +	    high_mode->vdisplay != mode->vdisplay ||
> +	    high_mode->hsync_start != mode->hsync_start ||
> +	    high_mode->hsync_end != mode->hsync_end ||
> +	    high_mode->htotal != mode->htotal ||
> +	    high_mode->hskew != mode->hskew ||
> +	    high_mode->vscan != mode->vscan ||
> +	    high_mode->vsync_start - mode->vsync_start != timing_diff ||
> +	    high_mode->vsync_end - mode->vsync_end != timing_diff)
> +		return false;
> +	else
> +		return true;
> +}
> +
>   static struct dc_stream_state *
>   create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		       const struct drm_display_mode *drm_mode,
> @@ -5345,8 +5436,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		dm_state ? &dm_state->base : NULL;
>   	struct dc_stream_state *stream = NULL;
>   	struct drm_display_mode mode = *drm_mode;
> +	struct drm_display_mode saved_mode;
> +	struct drm_display_mode *freesync_mode = NULL;
>   	bool native_mode_found = false;
> -	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
> +	bool recalculate_timing = dm_state ? (dm_state->scaling != RMX_OFF) : false;
>   	int mode_refresh;
>   	int preferred_refresh = 0;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
> @@ -5354,6 +5447,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   	uint32_t link_bandwidth_kbps;
>   #endif
>   	struct dc_sink *sink = NULL;
> +
> +	memset(&saved_mode, 0, sizeof(saved_mode));
> +
>   	if (aconnector == NULL) {
>   		DRM_ERROR("aconnector is NULL!\n");
>   		return stream;
> @@ -5406,25 +5502,38 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		 */
>   		DRM_DEBUG_DRIVER("No preferred mode found\n");
>   	} else {
> -		decide_crtc_timing_for_drm_display_mode(
> +		recalculate_timing |= amdgpu_freesync_vid_mode &&
> +				 is_freesync_video_mode(&mode, aconnector);
> +		if (recalculate_timing) {
> +			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
> +			saved_mode = mode;
> +			mode = *freesync_mode;
> +		} else {
> +			decide_crtc_timing_for_drm_display_mode(
>   				&mode, preferred_mode,
>   				dm_state ? (dm_state->scaling != RMX_OFF) : false);
> +		}
> +
>   		preferred_refresh = drm_mode_vrefresh(preferred_mode);
>   	}
>   
> -	if (!dm_state)
> +	if (recalculate_timing)
> +		drm_mode_set_crtcinfo(&saved_mode, 0);
> +	else
>   		drm_mode_set_crtcinfo(&mode, 0);
>   
> -	/*
> +       /*
>   	* If scaling is enabled and refresh rate didn't change
>   	* we copy the vic and polarities of the old timings
>   	*/
> -	if (!scale || mode_refresh != preferred_refresh)
> -		fill_stream_properties_from_drm_display_mode(stream,
> -			&mode, &aconnector->base, con_state, NULL, requested_bpc);
> +	if (!recalculate_timing || mode_refresh != preferred_refresh)
> +		fill_stream_properties_from_drm_display_mode(
> +			stream, &mode, &aconnector->base, con_state, NULL,
> +			requested_bpc);
>   	else
> -		fill_stream_properties_from_drm_display_mode(stream,
> -			&mode, &aconnector->base, con_state, old_stream, requested_bpc);
> +		fill_stream_properties_from_drm_display_mode(
> +			stream, &mode, &aconnector->base, con_state, old_stream,
> +			requested_bpc);
>   
>   	stream->timing.flags.DSC = 0;
>   
> @@ -7160,6 +7269,107 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
>   	}
>   }
>   
> +static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
> +			      struct drm_display_mode *mode)
> +{
> +	struct drm_display_mode *m;
> +
> +	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
> +		if (drm_mode_equal(m, mode))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
> +{
> +	const struct drm_display_mode *m;
> +	struct drm_display_mode *new_mode;
> +	uint i;
> +	uint32_t new_modes_count = 0;
> +
> +	/* Standard FPS values
> +	 *
> +	 * 23.976   - TV/NTSC
> +	 * 24 	    - Cinema
> +	 * 25 	    - TV/PAL
> +	 * 29.97    - TV/NTSC
> +	 * 30 	    - TV/NTSC
> +	 * 48 	    - Cinema HFR
> +	 * 50 	    - TV/PAL
> +	 * 60 	    - Commonly used
> +	 * 48,72,96 - Multiples of 24
> +	 */
> +	const uint32_t common_rates[] = { 23976, 24000, 25000, 29970, 30000,
> +					 48000, 50000, 60000, 72000, 96000 };
> +
> +	/*
> +	 * Find mode with highest refresh rate with the same resolution
> +	 * as the preferred mode. Some monitors report a preferred mode
> +	 * with lower resolution than the highest refresh rate supported.
> +	 */
> +
> +	m = get_highest_refresh_rate_mode(aconnector, true);
> +	if (!m)
> +		return 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(common_rates); i++) {
> +		uint64_t target_vtotal, target_vtotal_diff;
> +		uint64_t num, den;
> +
> +		if (drm_mode_vrefresh(m) * 1000 < common_rates[i])
> +			continue;
> +
> +		if (common_rates[i] < aconnector->min_vfreq * 1000 ||
> +		    common_rates[i] > aconnector->max_vfreq * 1000)
> +			continue;
> +
> +		num = (unsigned long long)m->clock * 1000 * 1000;
> +		den = common_rates[i] * (unsigned long long)m->htotal;
> +		target_vtotal = div_u64(num, den);
> +		target_vtotal_diff = target_vtotal - m->vtotal;
> +
> +		/* Check for illegal modes */
> +		if (m->vsync_start + target_vtotal_diff < m->vdisplay ||
> +		    m->vsync_end + target_vtotal_diff < m->vsync_start ||
> +		    m->vtotal + target_vtotal_diff < m->vsync_end)
> +			continue;
> +
> +		new_mode = drm_mode_duplicate(aconnector->base.dev, m);
> +		if (!new_mode)
> +			goto out;
> +
> +		new_mode->vtotal += (u16)target_vtotal_diff;
> +		new_mode->vsync_start += (u16)target_vtotal_diff;
> +		new_mode->vsync_end += (u16)target_vtotal_diff;
> +		new_mode->type &= ~DRM_MODE_TYPE_PREFERRED;
> +		new_mode->type |= DRM_MODE_TYPE_DRIVER;
> +
> +		if (!is_duplicate_mode(aconnector, new_mode)) {
> +			drm_mode_probed_add(&aconnector->base, new_mode);
> +			new_modes_count += 1;
> +		} else
> +			drm_mode_destroy(aconnector->base.dev, new_mode);
> +	}
> + out:
> +	return new_modes_count;
> +}
> +
> +static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
> +						   struct edid *edid)
> +{
> +	struct amdgpu_dm_connector *amdgpu_dm_connector =
> +		to_amdgpu_dm_connector(connector);
> +
> +	if (!(amdgpu_freesync_vid_mode && edid))
> +		return;
> +	
> +	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
> +		amdgpu_dm_connector->num_modes +=
> +			add_fs_modes(amdgpu_dm_connector);
> +}
> +
>   static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>   {
>   	struct amdgpu_dm_connector *amdgpu_dm_connector =
> @@ -7175,6 +7385,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>   	} else {
>   		amdgpu_dm_connector_ddc_get_modes(connector, edid);
>   		amdgpu_dm_connector_add_common_modes(encoder, connector);
> +		amdgpu_dm_connector_add_freesync_modes(connector, edid);
>   	}
>   	amdgpu_dm_fbc_init(connector);
>   
> @@ -7847,9 +8058,22 @@ static void update_stream_irq_parameters(
>   	if (new_crtc_state->vrr_supported &&
>   	    config.min_refresh_in_uhz &&
>   	    config.max_refresh_in_uhz) {
> -		config.state = new_crtc_state->base.vrr_enabled ?
> -			VRR_STATE_ACTIVE_VARIABLE :
> -			VRR_STATE_INACTIVE;
> +		/*
> +		 * if freesync compatible mode was set, config.state will be set
> +		 * in atomic check
> +		 */
> +		if (config.state == VRR_STATE_ACTIVE_FIXED && config.fixed_refresh_in_uhz &&
> +		    (!drm_atomic_crtc_needs_modeset(&new_crtc_state->base) ||
> +		     new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED)) {
> +			vrr_params.max_refresh_in_uhz = config.max_refresh_in_uhz;
> +			vrr_params.min_refresh_in_uhz = config.min_refresh_in_uhz;
> +			vrr_params.fixed_refresh_in_uhz = config.fixed_refresh_in_uhz;
> +			vrr_params.state = VRR_STATE_ACTIVE_FIXED;
> +		} else {
> +			config.state = new_crtc_state->base.vrr_enabled ?
> +						     VRR_STATE_ACTIVE_VARIABLE :
> +						     VRR_STATE_INACTIVE;
> +		}
>   	} else {
>   		config.state = VRR_STATE_UNSUPPORTED;
>   	}
> @@ -8170,8 +8394,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   		 * re-adjust the min/max bounds now that DC doesn't handle this
>   		 * as part of commit.
>   		 */
> -		if (amdgpu_dm_vrr_active(dm_old_crtc_state) !=
> -		    amdgpu_dm_vrr_active(acrtc_state)) {
> +		if (is_dc_timing_adjust_needed(dm_old_crtc_state, acrtc_state)) {
>   			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>   			dc_stream_adjust_vmin_vmax(
>   				dm->dc, acrtc_state->stream,
> @@ -8456,6 +8679,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   			/* i.e. reset mode */
>   			if (dm_old_crtc_state->stream)
>   				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
> +
>   			mode_set_reset_required = true;
>   		}
>   	} /* for_each_crtc_in_state() */
> @@ -8866,6 +9090,7 @@ static void get_freesync_config_for_crtc(
>   			to_amdgpu_dm_connector(new_con_state->base.connector);
>   	struct drm_display_mode *mode = &new_crtc_state->base.mode;
>   	int vrefresh = drm_mode_vrefresh(mode);
> +	bool fs_vid_mode = false;
>   
>   	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
>   					vrefresh >= aconnector->min_vfreq &&
> @@ -8873,17 +9098,24 @@ static void get_freesync_config_for_crtc(
>   
>   	if (new_crtc_state->vrr_supported) {
>   		new_crtc_state->stream->ignore_msa_timing_param = true;
> -		config.state = new_crtc_state->base.vrr_enabled ?
> -				VRR_STATE_ACTIVE_VARIABLE :
> -				VRR_STATE_INACTIVE;
> -		config.min_refresh_in_uhz =
> -				aconnector->min_vfreq * 1000000;
> -		config.max_refresh_in_uhz =
> -				aconnector->max_vfreq * 1000000;
> +		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
> +
> +		config.min_refresh_in_uhz = aconnector->min_vfreq * 1000000;
> +		config.max_refresh_in_uhz = aconnector->max_vfreq * 1000000;
>   		config.vsif_supported = true;
>   		config.btr = true;
> -	}
>   
> +		if (fs_vid_mode) {
> +			config.state = VRR_STATE_ACTIVE_FIXED;
> +			config.fixed_refresh_in_uhz = new_crtc_state->freesync_config.fixed_refresh_in_uhz;
> +			goto out;
> +		} else if (new_crtc_state->base.vrr_enabled) {
> +			config.state = VRR_STATE_ACTIVE_VARIABLE;
> +		} else {
> +			config.state = VRR_STATE_INACTIVE;
> +		}
> +	}
> +out:
>   	new_crtc_state->freesync_config = config;
>   }
>   
> @@ -8896,6 +9128,50 @@ static void reset_freesync_config_for_crtc(
>   	       sizeof(new_crtc_state->vrr_infopacket));
>   }
>   
> +static bool
> +is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
> +				 struct drm_crtc_state *new_crtc_state)
> +{
> +	struct drm_display_mode old_mode, new_mode;
> +
> +	if (!old_crtc_state || !new_crtc_state)
> +		return false;
> +
> +	old_mode = old_crtc_state->mode;
> +	new_mode = new_crtc_state->mode;
> +
> +	if (old_mode.clock       == new_mode.clock &&
> +	    old_mode.hdisplay    == new_mode.hdisplay &&
> +	    old_mode.vdisplay    == new_mode.vdisplay &&
> +	    old_mode.htotal      == new_mode.htotal &&
> +	    old_mode.vtotal      != new_mode.vtotal &&
> +	    old_mode.hsync_start == new_mode.hsync_start &&
> +	    old_mode.vsync_start != new_mode.vsync_start &&
> +	    old_mode.hsync_end   == new_mode.hsync_end &&
> +	    old_mode.vsync_end   != new_mode.vsync_end &&
> +	    old_mode.hskew       == new_mode.hskew &&
> +	    old_mode.vscan       == new_mode.vscan &&
> +	    (old_mode.vsync_end - old_mode.vsync_start) ==
> +	    (new_mode.vsync_end - new_mode.vsync_start))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
> +	uint64_t num, den, res;
> +	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
> +
> +	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
> +
> +	num = (unsigned long long)new_crtc_state->mode.clock * 1000 * 1000000;
> +	den = (unsigned long long)new_crtc_state->mode.htotal *
> +	      (unsigned long long)new_crtc_state->mode.vtotal;
> +
> +	res = div_u64(num, den);
> +	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
> +}
> +
>   static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   				struct drm_atomic_state *state,
>   				struct drm_crtc *crtc,
> @@ -8986,6 +9262,11 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		 * TODO: Refactor this function to allow this check to work
>   		 * in all conditions.
>   		 */
> +		if (amdgpu_freesync_vid_mode &&
> +		    dm_new_crtc_state->stream &&
> +		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
> +			goto skip_modeset;
> +
>   		if (dm_new_crtc_state->stream &&
>   		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
>   		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream)) {
> @@ -9017,6 +9298,24 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		if (!dm_old_crtc_state->stream)
>   			goto skip_modeset;
>   
> +		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
> +		    is_timing_unchanged_for_freesync(new_crtc_state,
> +						     old_crtc_state)) {
> +			new_crtc_state->mode_changed = false;
> +			DRM_DEBUG_DRIVER(
> +				"Mode change not required for front porch change, "
> +				"setting mode_changed to %d",
> +				new_crtc_state->mode_changed);
> +
> +			set_freesync_fixed_config(dm_new_crtc_state);
> +
> +			goto skip_modeset;
> +		} else if (amdgpu_freesync_vid_mode && aconnector &&
> +			   is_freesync_video_mode(&new_crtc_state->mode,
> +						  aconnector)) {
> +			set_freesync_fixed_config(dm_new_crtc_state);
> +		}
> +
>   		ret = dm_atomic_get_state(state, &dm_state);
>   		if (ret)
>   			goto fail;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 2c9eed78f6df..face69078d71 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -465,6 +465,8 @@ struct amdgpu_dm_connector {
>   #endif
>   	bool force_yuv420_output;
>   	struct dsc_preferred_settings dsc_settings;
> +	/* Cached display modes */
> +	struct drm_display_mode freesync_vid_base;
>   };
>   
>   #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
> 

-- 
Regards,
Aurabindo Pillai
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
