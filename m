Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162A1EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B30010E4E4;
	Wed, 21 Jun 2023 15:54:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12F710E08F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 15:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXyNSC4PrasYKIX2eViw9lzDge92tKV0BzCJdnFC39nkNVA+1riMYDuJM4ap8d1ICvskeAI79d0LPjRcNfZ2z7ijUM4mxhHC8mtIrK8IdE0pHsmDyrmbA7r5hiiNh6F/dprJTZs2Wwbiqh2bnLr6KpF9LS1QjF+DbjEJk2xzeI7+XT7lccZeBqAjZpqAbWJCh1PGt5cxMOQF216gV/SEhgCbkyFVtOG1IWKNHysJix9hi8l+O2lNTA2cgoE/5B97PowMwvzg6vEFe9ovuUVeoJjLX2XPG29jgl7cjHh8G/OvcfkfqfTS7qBRxuxBabIRCRlkhLz2+TlZBUAEqBdPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+HGXTNyd7I04eV3pCdVdWNKBu+IGTpbyil+wEwxMH0=;
 b=T9B5YJWNxFv6SCntSowecp/M4HHSmkAUSZMnU7VAeQ3uBz78AVFWgcGy2LdMhXOT8CZQnsA5t+QYVip0C6RTq1mLp1YGJCMnvsOj8AkrTq3SeRkc00Ffso6kbM9nhMZJW2yP3S2+i9wANsq7R7LOjVHUb0Pa6XyeI+/2Uq4TUfIQvNTCWIEJ9mBGiGBw4GNi80op6IThBm5XYXA/za96smTnwuY9BZ6H6tO6C104nQuVr+carxhmemfZgpHl9KP6yLk7mDDPOI0mGPKKl5hDJnEvEY/AGzzPaN2FdRLMobT2ouUvTFECdwe//HRKR6jZtrw/VDSlyN+7r9slIaDIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+HGXTNyd7I04eV3pCdVdWNKBu+IGTpbyil+wEwxMH0=;
 b=zs/dIi876WLd8J8uiQGQImFlfgpq4Mcm+zlThSs+xjc9zIRlqQiUAX38rQ5XhedolSSFEwKdHntM/EI0lxzatwjnrFVezIyn3aUILYMCQHL405qzAfxhl4sLvz13AxCvWd5Exbmc90QdLmLUflB7wJ7cbUDeTCzCvI/1cKRQxoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 15:54:35 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 15:54:35 +0000
Message-ID: <3b518bd5-ce53-54c2-93c6-dc7d6c03042d@amd.com>
Date: Wed, 21 Jun 2023 09:54:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: Fix errors & warnings in amdgpu_dm.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230617155608.3689171-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230617155608.3689171-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::34) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d0d48d-b72b-41f8-65f0-08db726fcf4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcQ7XOR5IDKPlF4nP+ah8s7hQ5H/8NQtOS1m6Cn77eUOAQAp0w2UCiL00KLUGvPKBgJQwX7W3zfRZpWG4a4zJ4U3f1p4eEwERWl68fKT8xxcq0Gqhi5OpETDB3rWWqgQEofdI6B9orqVk/xYQV7shx+rsfwJfn7OvY6eO/tijpDna4sZCnsqlb+NC0Ok01ZfpmgLyOGQzGhQXjmKlnsmBVH2a1DwlETKPSRzmvu5dTzqHQficojbFob7lW50rAOa5pUPNejz0XQobUR9BAEMt4ri2Zt9c0hZfl9FnbD9CynHZHUm5zf4gVzxK5zlQmD+YINmU9R+HO0hGaF/lEvtcO0GN8zkeiSB1e03Mo2zocoy0UHvNZzQfLjPaqMGMnE/4VPmlv/J392F837D6rjhcuqBHdrMnRLorMyS09zQVx2xSkmu+pyG3NswiGOVu6y0wjD+IZ9T33gSGmLKEfkF0b/NqtijNW3/Y+wNnBtVOHRetSRQydcejg6Ap/pt4wH1qDn7/tF7cAO2EP0pPGE+QqlikmyorHv3xayS1HvGPIm4kSsNIAn2WcPRJaI/6krtXSDw/U0nMIJy7scWQ0FCOOHjGdoVrc1QJ2OQAS1Db06v73LbNUkE5mc4phT1L490s4UdAfmZucKQZJ57r4TS5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(31696002)(83380400001)(31686004)(6486002)(6666004)(110136005)(316002)(38100700002)(8936002)(2616005)(8676002)(6512007)(36756003)(86362001)(4326008)(6636002)(186003)(6506007)(66476007)(41300700001)(5660300002)(53546011)(66946007)(66556008)(478600001)(30864003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVdhN2RMRDVXTWNWTVNlSldUR3h3T3Y0emRCT0FwMWpaQTVtSGdiQjJ3dkJs?=
 =?utf-8?B?UWtVL0hIaTh1SHpEcXpyNnVaM1hpc0ZOMk10RXIwY3R6ZEd3MTBlS2wrNGdu?=
 =?utf-8?B?UFFmUUVtSzNySVVPZ3A4aTY4QSt0NkZtdGRhckdZK3M4KzhuZjRXSHRqbkxI?=
 =?utf-8?B?bUZjMWhNNWh3WjFhVWx6SW5icEdYN1JHb1ZiZ1RqYnplNFd1aWdXaDQ4RWtQ?=
 =?utf-8?B?VEVPZGJZdXVnZlNyVnNzcXYwSE43WFhIVVkycVhOdE1KWVZPVnlPN2J4QlZs?=
 =?utf-8?B?bmR0dXMyTEdmTEtpMEZ6TVdtaTM5RW1iUzZFSEw0RXloMWIrQXJybFhEWGhV?=
 =?utf-8?B?dkJRMDJQRGh3OVBZUTRtc2FvYXJBSnJJSjJZRWtpakxId0x3UmN4Q2hmM25X?=
 =?utf-8?B?cWZyR3BMSDBBOU5hcU9vS1JSUVVRVjBIYmsweEFHc0ZBN01JUmZtbWNZYjFh?=
 =?utf-8?B?anZoTmQ2bzJ3N2s4SG41Ykl2QkZQZm9UVWpIaUd4cXBBWVJUVVNpUlZHeWxV?=
 =?utf-8?B?emZGV0RHSkhKSHhuUC9FS0NTWXNCMFpMWWMrK1RwNkNrWERRaDNrL3pvUG52?=
 =?utf-8?B?TVdJeXNVRmZqa0YrNHQ1SHpma3lHZGl1d2ZVTU5JNlc1K2tFVHgweC92WUg1?=
 =?utf-8?B?ejk2dFQ2TnB1dGo0UitLSVhyY2lBRnkvc2hXWVVlUDU0OHZzWW1MRzh3Y3p5?=
 =?utf-8?B?NktKTCtqclg3eUQyMGpDZGxNR0Ziemlmdlgrc0JYY3krMXhTaGhESlYxY3hj?=
 =?utf-8?B?VzU5eVpzVnYxYnQwTEZLZEdWTGVOZHpkT3R1WmZoeDNwdUk2ZDZkb3h1UWJj?=
 =?utf-8?B?b0x0cXhBMzB3Y2JwcFZSWk9rZ1dkTk5GRVR2NCtkZEw1RWVEU2NSaVRhZWU2?=
 =?utf-8?B?alZJYlF6UlNiNWp3cDJtcFhxWkZzTkR5NHRGUDYxdS9ZRjdML0V3MXIvWE1C?=
 =?utf-8?B?YjZZdVZQWU4wQ1IrNmtMclFCT0VLWlNyTmNGTERIY0Vpb25tV1lMZ3haQkN6?=
 =?utf-8?B?d1d6VkIxY3VLQlpXSHQvZStVV1gzS04rZll0NXBzak5LYUJqMG5XcHE0blBO?=
 =?utf-8?B?M0pHVXN3aitCd3NZbStZSGh4T004eWE4WDVCL243alpRY2N5QS9wZXIzTTZv?=
 =?utf-8?B?QnppeVd4OE1lUzVwdW1wMHFFMGRXZ0FZY0VEV0tYQ3VWZncycWFsODJmSzRX?=
 =?utf-8?B?eE1YT0x4RitTbTNyckt0QWVqb2RKZmZaK1J4N1hBcml2akwzNkNEcDlmbjEx?=
 =?utf-8?B?aVpBUWJRd0g3QUlMb3RGcEhsUmpQZDh3WVdqQXpnaTFvUlBNekNaOWh0UlE3?=
 =?utf-8?B?RkZsQ1l4cVpDRjVXbm40U1NjUHJMUGpYRTB2b0RTYi82NVl2MHdjUTlyOXZo?=
 =?utf-8?B?cERMc2ZmTWRTdnhJK0Y2SDVsQmRuajA1T2xORUlWa2hxRWVtL3NkTHc0OElh?=
 =?utf-8?B?NzZGRFRMWnFrSE5CT2Z1ME5MbXdlMXB5aTdQTTFYWklvR0FTVkJpT3dMbDVP?=
 =?utf-8?B?bkh5YmRJTnk3bTBDb0F6ZlVPN0lKRFN6TTBKWTJncUZPQm5wQmZzay80b0hy?=
 =?utf-8?B?VytnRWI4M213b2wvSWpRSmdrYlJYcHB0Y1dzOGdBTy93NjB6bUx4MlNFbnVo?=
 =?utf-8?B?dUFwU1l6RE5lcUtBKzV4WUluZ044ZTkzQkxNMVVuY3FURjFlTXc4VFprYzY2?=
 =?utf-8?B?eGJ4T1M5RHJUeWloZVIvVGVzTEZVVEMrNUgvN0pvbTM2aFQ5di9kSE5aMnZD?=
 =?utf-8?B?L1FzN1VqTTdBVWJ2Um1CeHNxR2lWdTJEN0NyNmpUL1pTNTgvM200OExoMndL?=
 =?utf-8?B?VWVndDNDLzcvUytFSUFGU3F3VUpuc2kzWXdaTjJ6dlNpMGdrcmtZVE85alVa?=
 =?utf-8?B?VFR5R0NHbEpuWjlDRG9iejRhOUZ6RjUxZ0Q0M2UyTFVwa2t3YVFnRGt6c3Q4?=
 =?utf-8?B?ZkJoRTY4cS9pU1FYeXRzYmhJelpNKzc4eWYzSmgydHFpcndkUjFaNDlVOWor?=
 =?utf-8?B?alROVXBibUk3ZnQ4dDVnQUpzUXJYVVVMbk1kZktHeUtOYjgrMmc0Y1dDbSts?=
 =?utf-8?B?NVJkV2RSeU1pZS9mSlh5a1U4RDh5RE1uR0xUMXJMSkFFU1AzTXM4am12WVo3?=
 =?utf-8?B?TWlMdzk5OFpjcWd3NlhnTzJsVndzaGIxQUJpVnA3NXpWVFprOTV2SE5PVGZv?=
 =?utf-8?Q?LLJTfjHa64rJ9FWezLCK8dVQvKOli3dHfNMW3Iyi01MJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d0d48d-b72b-41f8-65f0-08db726fcf4f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:54:34.9780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzEQIOwvSL4DCxwEgJUGj0EHSgZLdFJ6hM7U6KZ7hHwU18Mpa7g7gdWFqWjq0ff8mPrK7ksxQk91vQSpefAsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/17/23 09:56, Srinivasan Shanmugam wrote:
> Fix the following errors & warnings reported by checkpatch:
> 
> ERROR: space required before the open brace '{'
> ERROR: space required before the open parenthesis '('
> ERROR: that open brace { should be on the previous line
> ERROR: space prohibited before that ',' (ctx:WxW)
> ERROR: else should follow close brace '}'
> ERROR: open brace '{' following function definitions go on the next line
> ERROR: code indent should use tabs where possible
> 
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: void function return statements are not generally useful
> WARNING: Block comments use * on subsequent lines
> WARNING: Block comments use a trailing */ on a separate line
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 133 +++++++++---------
>   1 file changed, 65 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2446529c329a..5e28899bb167 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -424,12 +424,12 @@ static void dm_pflip_high_irq(void *interrupt_params)
>   
>   	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>   
> -	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
> -		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
> -						 amdgpu_crtc->pflip_status,
> -						 AMDGPU_FLIP_SUBMITTED,
> -						 amdgpu_crtc->crtc_id,
> -						 amdgpu_crtc);
> +	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
> +		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p]\n",
> +			     amdgpu_crtc->pflip_status,
> +			     AMDGPU_FLIP_SUBMITTED,
> +			     amdgpu_crtc->crtc_id,
> +			     amdgpu_crtc);
>   		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>   		return;
>   	}
> @@ -883,7 +883,7 @@ static int dm_set_powergating_state(void *handle,
>   }
>   
>   /* Prototypes of private functions */
> -static int dm_early_init(void* handle);
> +static int dm_early_init(void *handle);
>   
>   /* Allocate memory for FBC compressed data  */
>   static void amdgpu_dm_fbc_init(struct drm_connector *connector)
> @@ -1282,7 +1282,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>   	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
>   	pa_config->system_aperture.end_addr = (uint64_t)logical_addr_high << 18;
>   
> -	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24 ;
> +	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24;
>   	pa_config->system_aperture.agp_bot = (uint64_t)agp_bot << 24;
>   	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
>   
> @@ -1365,8 +1365,7 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
>   		DP_TEST_RESPONSE,
>   		&test_response.raw,
>   		sizeof(test_response));
> -	}
> -	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
> +	} else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
>   			dc_link_check_link_loss_status(dc_link, &offload_work->data) &&
>   			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
>   		/* offload_work->data is from handle_hpd_rx_irq->
> @@ -1554,7 +1553,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	mutex_init(&adev->dm.dc_lock);
>   	mutex_init(&adev->dm.audio_lock);
>   
> -	if(amdgpu_dm_irq_init(adev)) {
> +	if (amdgpu_dm_irq_init(adev)) {
>   		DRM_ERROR("amdgpu: failed to initialize DM IRQ support.\n");
>   		goto error;
>   	}
> @@ -1696,9 +1695,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
>   		adev->dm.dc->debug.disable_stutter = true;
>   
> -	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC) {
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
>   		adev->dm.dc->debug.disable_dsc = true;
> -	}
>   
>   	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
>   		adev->dm.dc->debug.disable_clock_gate = true;
> @@ -1942,8 +1940,6 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
>   	mutex_destroy(&adev->dm.audio_lock);
>   	mutex_destroy(&adev->dm.dc_lock);
>   	mutex_destroy(&adev->dm.dpia_aux_lock);
> -
> -	return;
>   }
>   
>   static int load_dmcu_fw(struct amdgpu_device *adev)
> @@ -1952,7 +1948,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>   	int r;
>   	const struct dmcu_firmware_header_v1_0 *hdr;
>   
> -	switch(adev->asic_type) {
> +	switch (adev->asic_type) {
>   #if defined(CONFIG_DRM_AMD_DC_SI)
>   	case CHIP_TAHITI:
>   	case CHIP_PITCAIRN:
> @@ -2709,7 +2705,7 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
>   		struct dc_scaling_info scaling_infos[MAX_SURFACES];
>   		struct dc_flip_addrs flip_addrs[MAX_SURFACES];
>   		struct dc_stream_update stream_update;
> -	} * bundle;
> +	} *bundle;
>   	int k, m;
>   
>   	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
> @@ -2739,8 +2735,6 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
>   
>   cleanup:
>   	kfree(bundle);
> -
> -	return;
>   }
>   
>   static int dm_resume(void *handle)
> @@ -2954,8 +2948,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
>   	.set_powergating_state = dm_set_powergating_state,
>   };
>   
> -const struct amdgpu_ip_block_version dm_ip_block =
> -{
> +const struct amdgpu_ip_block_version dm_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_DCE,
>   	.major = 1,
>   	.minor = 0,
> @@ -3000,9 +2993,12 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>   	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
>   	caps->aux_support = false;
>   
> -	if (caps->ext_caps->bits.oled == 1 /*||
> -	    caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
> -	    caps->ext_caps->bits.hdr_aux_backlight_control == 1*/)
> +	if (caps->ext_caps->bits.oled == 1
> +	    /*
> +	     * ||
> +	     * caps->ext_caps->bits.sdr_aux_backlight_control == 1 ||
> +	     * caps->ext_caps->bits.hdr_aux_backlight_control == 1
> +	     */)
>   		caps->aux_support = true;
>   
>   	if (amdgpu_backlight == 0)
> @@ -3269,6 +3265,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
>   		process_count < max_process_count) {
>   		u8 ack[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = {};
>   		u8 retry;
> +
>   		dret = 0;
>   
>   		process_count++;
> @@ -3468,7 +3465,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		dc_link = aconnector->dc_link;
>   
> -		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
> +		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
>   			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
>   			int_params.irq_source = dc_link->irq_source_hpd;
>   
> @@ -3477,7 +3474,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
>   					(void *) aconnector);
>   		}
>   
> -		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
> +		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
>   
>   			/* Also register for DP short pulse (hpd_rx). */
>   			int_params.int_context = INTERRUPT_LOW_IRQ_CONTEXT;
> @@ -3503,7 +3500,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
>   	struct dc_interrupt_params int_params = {0};
>   	int r;
>   	int i;
> -	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
> +	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
>   
>   	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
>   	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
> @@ -3517,11 +3514,12 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
>   	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
>   	 *    coming from DC hardware.
>   	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
> -	 *    for acknowledging and handling. */
> +	 *    for acknowledging and handling.
> +	 */
>   
>   	/* Use VBLANK interrupt */
>   	for (i = 0; i < adev->mode_info.num_crtc; i++) {
> -		r = amdgpu_irq_add_id(adev, client_id, i+1 , &adev->crtc_irq);
> +		r = amdgpu_irq_add_id(adev, client_id, i + 1, &adev->crtc_irq);
>   		if (r) {
>   			DRM_ERROR("Failed to add crtc irq id!\n");
>   			return r;
> @@ -3529,7 +3527,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
>   
>   		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
>   		int_params.irq_source =
> -			dc_interrupt_to_irq_source(dc, i+1 , 0);
> +			dc_interrupt_to_irq_source(dc, i + 1, 0);
>   
>   		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
>   
> @@ -3585,7 +3583,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
>   	struct dc_interrupt_params int_params = {0};
>   	int r;
>   	int i;
> -	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
> +	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
>   
>   	if (adev->family >= AMDGPU_FAMILY_AI)
>   		client_id = SOC15_IH_CLIENTID_DCE;
> @@ -3602,7 +3600,8 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
>   	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
>   	 *    coming from DC hardware.
>   	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
> -	 *    for acknowledging and handling. */
> +	 *    for acknowledging and handling.
> +	 */
>   
>   	/* Use VBLANK interrupt */
>   	for (i = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0; i <= VISLANDS30_IV_SRCID_D6_VERTICAL_INTERRUPT0; i++) {
> @@ -4049,7 +4048,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>   }
>   
>   static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
> -				unsigned *min, unsigned *max)
> +				unsigned int *min, unsigned int *max)
>   {
>   	if (!caps)
>   		return 0;
> @@ -4069,7 +4068,7 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>   static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>   					uint32_t brightness)
>   {
> -	unsigned min, max;
> +	unsigned int min, max;
>   
>   	if (!get_brightness_range(caps, &min, &max))
>   		return brightness;
> @@ -4082,7 +4081,7 @@ static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *c
>   static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
>   				      uint32_t brightness)
>   {
> -	unsigned min, max;
> +	unsigned int min, max;
>   
>   	if (!get_brightness_range(caps, &min, &max))
>   		return brightness;
> @@ -4566,7 +4565,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
>   {
>   	drm_atomic_private_obj_fini(&dm->atomic_obj);
> -	return;
>   }
>   
>   /******************************************************************************
> @@ -5403,6 +5401,7 @@ static bool adjust_colour_depth_from_display_info(
>   {
>   	enum dc_color_depth depth = timing_out->display_color_depth;
>   	int normalized_clk;
> +
>   	do {
>   		normalized_clk = timing_out->pix_clk_100hz / 10;
>   		/* YCbCr 4:2:0 requires additional adjustment of 1/2 */
> @@ -5618,6 +5617,7 @@ create_fake_sink(struct amdgpu_dm_connector *aconnector)
>   {
>   	struct dc_sink_init_data sink_init_data = { 0 };
>   	struct dc_sink *sink = NULL;
> +
>   	sink_init_data.link = aconnector->dc_link;
>   	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
>   
> @@ -5741,7 +5741,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
>   		return &aconnector->freesync_vid_base;
>   
>   	/* Find the preferred mode */
> -	list_for_each_entry (m, list_head, head) {
> +	list_for_each_entry(m, list_head, head) {
>   		if (m->type & DRM_MODE_TYPE_PREFERRED) {
>   			m_pref = m;
>   			break;
> @@ -5765,7 +5765,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
>   	 * For some monitors, preferred mode is not the mode with highest
>   	 * supported refresh rate.
>   	 */
> -	list_for_each_entry (m, list_head, head) {
> +	list_for_each_entry(m, list_head, head) {
>   		current_refresh  = drm_mode_vrefresh(m);
>   
>   		if (m->hdisplay == m_pref->hdisplay &&
> @@ -6037,7 +6037,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		 * This may not be an error, the use case is when we have no
>   		 * usermode calls to reset and set mode upon hotplug. In this
>   		 * case, we call set mode ourselves to restore the previous mode
> -		 * and the modelist may not be filled in in time.
> +		 * and the modelist may not be filled in time.
>   		 */
>   		DRM_DEBUG_DRIVER("No preferred mode found\n");
>   	} else {
> @@ -6060,9 +6060,9 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>   		drm_mode_set_crtcinfo(&mode, 0);
>   
>   	/*
> -	* If scaling is enabled and refresh rate didn't change
> -	* we copy the vic and polarities of the old timings
> -	*/
> +	 * If scaling is enabled and refresh rate didn't change
> +	 * we copy the vic and polarities of the old timings
> +	 */
>   	if (!scale || mode_refresh != preferred_refresh)
>   		fill_stream_properties_from_drm_display_mode(
>   			stream, &mode, &aconnector->base, con_state, NULL,
> @@ -6826,6 +6826,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
>   
>   	if (!state->duplicated) {
>   		int max_bpc = conn_state->max_requested_bpc;
> +
>   		is_y420 = drm_mode_is_420_also(&connector->display_info, adjusted_mode) &&
>   			  aconnector->force_yuv420_output;
>   		color_depth = convert_color_depth_from_display_info(connector,
> @@ -7144,7 +7145,7 @@ static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
>   {
>   	struct drm_display_mode *m;
>   
> -	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
> +	list_for_each_entry(m, &aconnector->base.probed_modes, head) {
>   		if (drm_mode_equal(m, mode))
>   			return true;
>   	}
> @@ -7469,7 +7470,6 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>   
>   	link->priv = aconnector;
>   
> -	DRM_DEBUG_DRIVER("%s()\n", __func__);
>   
>   	i2c = create_i2c(link->ddc, link->link_index, &res);
>   	if (!i2c) {
> @@ -8183,8 +8183,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			 * DRI3/Present extension with defined target_msc.
>   			 */
>   			last_flip_vblank = amdgpu_get_vblank_counter_kms(pcrtc);
> -		}
> -		else {
> +		} else {
>   			/* For variable refresh rate mode only:
>   			 * Get vblank of last completed flip to avoid > 1 vrr
>   			 * flips per video frame by use of throttling, but allow
> @@ -8517,8 +8516,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		dc_resource_state_copy_construct_current(dm->dc, dc_state);
>   	}
>   
> -	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
> -				       new_crtc_state, i) {
> +	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> +				      new_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>   
>   		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
> @@ -8541,9 +8540,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>   
>   		drm_dbg_state(state->dev,
> -			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
> -			"planes_changed:%d, mode_changed:%d,active_changed:%d,"
> -			"connectors_changed:%d\n",
> +			"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
>   			acrtc->crtc_id,
>   			new_crtc_state->enable,
>   			new_crtc_state->active,
> @@ -9119,8 +9116,8 @@ static int do_aquire_global_lock(struct drm_device *dev,
>   					&commit->flip_done, 10*HZ);
>   
>   		if (ret == 0)
> -			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done "
> -				  "timed out\n", crtc->base.id, crtc->name);
> +			DRM_ERROR("[CRTC:%d:%s] hw_done or flip_done timed out\n",
> +				  crtc->base.id, crtc->name);
>   
>   		drm_crtc_commit_put(commit);
>   	}
> @@ -9205,7 +9202,8 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
>   	return false;
>   }
>   
> -static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
> +static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
> +{
>   	u64 num, den, res;
>   	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
>   
> @@ -9327,9 +9325,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		goto skip_modeset;
>   
>   	drm_dbg_state(state->dev,
> -		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
> -		"planes_changed:%d, mode_changed:%d,active_changed:%d,"
> -		"connectors_changed:%d\n",
> +		"amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, planes_changed:%d, mode_changed:%d,active_changed:%d,connectors_changed:%d\n",
>   		acrtc->crtc_id,
>   		new_crtc_state->enable,
>   		new_crtc_state->active,
> @@ -9358,8 +9354,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   						     old_crtc_state)) {
>   			new_crtc_state->mode_changed = false;
>   			DRM_DEBUG_DRIVER(
> -				"Mode change not required for front porch change, "
> -				"setting mode_changed to %d",
> +				"Mode change not required for front porch change, setting mode_changed to %d",
>   				new_crtc_state->mode_changed);
>   
>   			set_freesync_fixed_config(dm_new_crtc_state);
> @@ -9371,9 +9366,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   			struct drm_display_mode *high_mode;
>   
>   			high_mode = get_highest_refresh_rate_mode(aconnector, false);
> -			if (!drm_mode_equal(&new_crtc_state->mode, high_mode)) {
> +			if (!drm_mode_equal(&new_crtc_state->mode, high_mode))
>   				set_freesync_fixed_config(dm_new_crtc_state);
> -			}
>   		}
>   
>   		ret = dm_atomic_get_state(state, &dm_state);
> @@ -9541,6 +9535,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
>   	 */
>   	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_state, i) {
>   		struct amdgpu_framebuffer *old_afb, *new_afb;
> +
>   		if (other->type == DRM_PLANE_TYPE_CURSOR)
>   			continue;
>   
> @@ -9639,11 +9634,12 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
>   	}
>   
>   	/* Core DRM takes care of checking FB modifiers, so we only need to
> -	 * check tiling flags when the FB doesn't have a modifier. */
> +	 * check tiling flags when the FB doesn't have a modifier.
> +	 */
>   	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
>   		if (adev->family < AMDGPU_FAMILY_AI) {
>   			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
> -			         AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
> +				 AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
>   				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
>   		} else {
>   			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
> @@ -9865,12 +9861,12 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
>   	 * cursor per pipe but it's going to inherit the scaling and
>   	 * positioning from the underlying pipe. Check the cursor plane's
> -	 * blending properties match the underlying planes'. */
> +	 * blending properties match the underlying planes'.
> +	 */
>   
>   	new_cursor_state = drm_atomic_get_new_plane_state(state, cursor);
> -	if (!new_cursor_state || !new_cursor_state->fb) {
> +	if (!new_cursor_state || !new_cursor_state->fb)
>   		return 0;
> -	}
>   
>   	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
>   	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
> @@ -9915,6 +9911,7 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>   	struct drm_connector_state *conn_state, *old_conn_state;
>   	struct amdgpu_dm_connector *aconnector = NULL;
>   	int i;
> +
>   	for_each_oldnew_connector_in_state(state, connector, old_conn_state, conn_state, i) {
>   		if (!conn_state->crtc)
>   			conn_state = old_conn_state;
> @@ -10349,7 +10346,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   	}
>   
>   	/* Store the overall update type for use later in atomic check. */
> -	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
> +	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>   		struct dm_crtc_state *dm_new_crtc_state =
>   			to_dm_crtc_state(new_crtc_state);
>   
> @@ -10371,7 +10368,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   	else if (ret == -EINTR || ret == -EAGAIN || ret == -ERESTARTSYS)
>   		DRM_DEBUG_DRIVER("Atomic check stopped due to signal.\n");
>   	else
> -		DRM_DEBUG_DRIVER("Atomic check failed with err: %d \n", ret);
> +		DRM_DEBUG_DRIVER("Atomic check failed with err: %d\n", ret);
>   
>   	trace_amdgpu_dm_atomic_check_finish(state, ret);
>   

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
