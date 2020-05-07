Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A12C54E49
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 15:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4262082E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 15:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f3/Od708"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4262082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F48E6EA2D;
	Thu,  7 May 2020 15:56:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133876EA2B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 15:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT9FeDSn9Aas6H5dbs8v5zqSoSRohEff38afW8y/LtCb3GOAWUwZ15pq60MJ6A4OEpWjvyStlUpLCCsA2lYYoBzDbjB9mN1ozyAwKyWmRwx/WeIFAz0D6ovuWDAOGB+4bwKxvpq+3NpKyNYLAuyefcEnhRfxsvuTV4AF6ZKC4cMqAcydi53Ov36MW1roKn1ssh6UTPDpXydKt90bXERHBTbCekMwfOsp/vIPXFRphpf6v40lRS3U8xUbHASAJKc6UjhOyrtPDjocD2kph9pJCFYedjHDcjyYnUoOvhb8jzorzuq5803cO+QcT5GJoNJf46NvlbyR4xDuiqShUIil6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4W65WPFZyDEFEIntjCVaYHrD4NzJ3BsUYPyqgmDAFQ=;
 b=Wq6c+GkBrTBRMTdDq49PUfHLuSo4GfRBEdG7Ikrd37iYsK0LTu04WLpxeutvNjYf1LPz5V6TkhOAvEomRVFgqT+RrJ6NW2GgMefAXzE0PyncK0Ktl7qRfEE0Ers1iLMsMFI4cEy20LIYQLfGTItOZDOME0avtCdMu/yxUTyldIdZOfl2DrOUt6g2rBLmIXsjBrZzgaEHwpJvmOED7TMhrl6/yCUusiioltTv0ZGDFG6p0drI6HZy5Xr8jWnEdbiEo+/Fmn8HdTgdD+w2/cuMyUN+1lOA75em695bGpbvfStmEDP5Bnb+QVYKlqbe/Ck8an1gU8ec5WTcBKtoepTOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4W65WPFZyDEFEIntjCVaYHrD4NzJ3BsUYPyqgmDAFQ=;
 b=f3/Od708RDRYyb8RBJyCsrBbxoeyFT0yjLIYsHQwBU+gHBZIfojn2uSUXEDh+CgvQDLu+WXXJbBJ6tp4ObtlqRdXGHwUfO7qKr+Id93HTT6BNpiaMCzVoBfeo/QXoQzpEHoqipK+VXMS3D4oBc01DgaEKIRBRJGCSthNW+KRedI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:25::23)
 by BN7PR12MB2657.namprd12.prod.outlook.com (2603:10b6:408:32::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 7 May
 2020 15:56:49 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::151d:5f5c:81d2:ad07]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::151d:5f5c:81d2:ad07%2]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 15:56:49 +0000
Subject: Re: [PATCH] drm/amd/display: Fix vblank and pageflip event handling
 for FreeSync
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200506194754.10780-1-nicholas.kazlauskas@amd.com>
From: Leo Li <sunpeng.li@amd.com>
Message-ID: <33b0a4ad-496a-51f7-dbd4-ace5e807b3e9@amd.com>
Date: Thu, 7 May 2020 11:56:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200506194754.10780-1-nicholas.kazlauskas@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:404:f5::17) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.224] (165.204.84.11) by
 BN6PR16CA0007.namprd16.prod.outlook.com (2603:10b6:404:f5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 15:56:48 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52cd2e06-0c37-47c8-fdac-08d7f29f4080
X-MS-TrafficTypeDiagnostic: BN7PR12MB2657:|BN7PR12MB2657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2657F74507D2D640A9AAE1B582A50@BN7PR12MB2657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lx9H4iS5q6v7UCKkbzKZdeK4pBEgFmn5yNOrH6h13V/g/ZNobCqU7D4mFKEqk9xzZjz4IZwPP8rLWMOAkaqX18SgDS2qjHV0kMHq+9HguY5b+Ii2aDhg+hcHWOS0oSxmz7/4H1GBwGsiy8WVoJioMUcC5M4SYX8jvlcBtNIXOq5ZS/aqSbWhWJq6EjMhah1waCH7L+JhiCWaQzpmhGpyFndB0teHAJj1yte3xe6jU3GtNuoio8sBAJUWj6NlWYmZKfHm9GIkwI7i+ge3CVRkwmLOZc2zTvLnGlVm/nohfNN80sSH6by4Z1McIIWhgVc38rRHqDvafx1PKXHnVS2rF8P/FyyVgefVGUgm6N/b3upPiJj1Rdh6Ra/PynwvRHQdcsf5xns6Qb09BdWFeW2JhlZ06u92oEEHw/L6todj7uEdbzXP7ZaeLWi26losItMqtZQKztbcyHL3gzBkzZNEGzNopUUZVIhCwkZlrhnUVbV5sF3ujmJla8gqUlu8yp48EAdmeaXjqfotTA6jAUceBQTKlbUQL7EA7wEx9U8W5qTAZX56fGwBP1NGYbWiiN1m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2593.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(33430700001)(31686004)(33440700001)(66476007)(66556008)(5660300002)(66946007)(2616005)(2906002)(83280400001)(16526019)(186003)(83300400001)(83310400001)(83290400001)(956004)(83320400001)(26005)(31696002)(316002)(52116002)(478600001)(4326008)(86362001)(8936002)(6486002)(53546011)(36756003)(16576012)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DocTv+8hLQSJYaI9JJ30K8lRiXCWREu8CjFJZ+Ux+d7/MNFR7adjeKBkzruydNyDB+xXNrcDwWq5xkMR3w1iZvVM1LSdMCIJa6kSS4ftOcdyj2f6dg938lHEJxSPm+dYyMEoRBKcov8ULkFv23zP5XVQ5UNfanYBSZhCMWVAPPB1y5j9707WJThlbGngTmu3LGAMobHULzStoegZy4V1QC3OgPBQkWbKSY0wYSBkof7y3hYo1ZDhEhfsgxhiWixwXY5X1XwR6j2tHHKZe7OKV7JMUwdeE1a+sAFXRryyJ8mz2rfthRBDujaP0UjvvOtHF5ISIU/CQ1LgL8Z1/0Sj5sJ4bjpJ6Hz9hTGwsP/NBhrj9wYKGMVLLETEWOdeTo2Mgvwf63jn0Vncyl7rKDN4dVrXfFDaGTy7gGIVI8wbPUH2z8qvqiLmyRlRvO0I/MIjF1pWrksuwPa3LeE63SugKfgNRPB3tfWoHej9xm2FI1bkAtHMHNcyxVFhp++5AGSkvDNcSur4OsmXGRWWw/iZtGLOzACUcZ8d+vJxfVmfZnjZ0qGosY1Cc0T4CaxP/SvZxP38DseeXA08dnkB3FqtgmXw72eMbXRWupZ9G+i9Tsx80rSVAVr6v0/lmHOOmWd7cdJxmIpykMEbPBsZ7XguxqmTJr8NHMt1pNd8EiJSPNbBJna3ef7j84uL/EJAwjRGyKUbTiDgiPRyeHXu4LuBRSVj5dJqTodHWwWHVBzdQ4WOcRiCSouMv9Whzhg9LCg6nlNV33zUXcpJsT5ywbYKsjtlDj9x0vMoZIX372ywps4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cd2e06-0c37-47c8-fdac-08d7f29f4080
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 15:56:49.3091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2T3MlvKONqkFgm1ybQVY8wC2tHaD6/xX0hbIB0YclqE3YCZMhY8ZREX0vAf5vxT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2657
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
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-05-06 3:47 p.m., Nicholas Kazlauskas wrote:
> [Why]
> We're the drm vblank event a frame too early in the case where the
        ^sending

Thanks for catching this!

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> pageflip happens close to VUPDATE and ends up blocking the signal.
> 
> The implementation in DM was previously correct *before* we started
> sending vblank events from VSTARTUP unconditionally to handle cases
> where HUBP was off, OTG was ON and userspace was still requesting some
> DRM planes enabled. As part of that patch series we dropped VUPDATE
> since it was deemed close enough to VSTARTUP, but there's a key
> difference betweeen VSTARTUP and VUPDATE - the VUPDATE signal can be
> blocked if we're holding the pipe lock >
> There was a fix recently to revert the unconditional behavior for the
> DCN VSTARTUP vblank event since it was sending the pageflip event on
> the wrong frame - once again, due to blocking VUPDATE and having the
> address start scanning out two frames later.
> 
> The problem with this fix is it didn't update the logic that calls
> drm_crtc_handle_vblank(), so the timestamps are totally bogus now.
> 
> [How]
> Essentially reverts most of the original VSTARTUP series but retains
> the behavior to send back events when active planes == 0.
> 
> Some refactoring/cleanup was done to not have duplicated code in both
> the handlers.
> 
> Fixes: 16f17eda8bad ("drm/amd/display: Send vblank and user events at vsartup for DCN")
> Fixes: 3a2ce8d66a4b ("drm/amd/display: Disable VUpdate interrupt for DCN hardware")
> Fixes: 2b5aed9ac3f7 ("drm/amd/display: Fix pageflip event race condition for DCN.")
> 
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 +++++++-----------
>   1 file changed, 55 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 59f1d4a94f12..30ce28f7c444 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -441,7 +441,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>   
>   /**
>    * dm_crtc_high_irq() - Handles CRTC interrupt
> - * @interrupt_params: ignored
> + * @interrupt_params: used for determining the CRTC instance
>    *
>    * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
>    * event handler.
> @@ -455,70 +455,6 @@ static void dm_crtc_high_irq(void *interrupt_params)
>   	unsigned long flags;
>   
>   	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
> -
> -	if (acrtc) {
> -		acrtc_state = to_dm_crtc_state(acrtc->base.state);
> -
> -		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
> -			      acrtc->crtc_id,
> -			      amdgpu_dm_vrr_active(acrtc_state));
> -
> -		/* Core vblank handling at start of front-porch is only possible
> -		 * in non-vrr mode, as only there vblank timestamping will give
> -		 * valid results while done in front-porch. Otherwise defer it
> -		 * to dm_vupdate_high_irq after end of front-porch.
> -		 */
> -		if (!amdgpu_dm_vrr_active(acrtc_state))
> -			drm_crtc_handle_vblank(&acrtc->base);
> -
> -		/* Following stuff must happen at start of vblank, for crc
> -		 * computation and below-the-range btr support in vrr mode.
> -		 */
> -		amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
> -
> -		if (acrtc_state->stream && adev->family >= AMDGPU_FAMILY_AI &&
> -		    acrtc_state->vrr_params.supported &&
> -		    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
> -			spin_lock_irqsave(&adev->ddev->event_lock, flags);
> -			mod_freesync_handle_v_update(
> -				adev->dm.freesync_module,
> -				acrtc_state->stream,
> -				&acrtc_state->vrr_params);
> -
> -			dc_stream_adjust_vmin_vmax(
> -				adev->dm.dc,
> -				acrtc_state->stream,
> -				&acrtc_state->vrr_params.adjust);
> -			spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> -		}
> -	}
> -}
> -
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
> -/**
> - * dm_dcn_crtc_high_irq() - Handles VStartup interrupt for DCN generation ASICs
> - * @interrupt params - interrupt parameters
> - *
> - * Notify DRM's vblank event handler at VSTARTUP
> - *
> - * Unlike DCE hardware, we trigger the handler at VSTARTUP. at which:
> - * * We are close enough to VUPDATE - the point of no return for hw
> - * * We are in the fixed portion of variable front porch when vrr is enabled
> - * * We are before VUPDATE, where double-buffered vrr registers are swapped
> - *
> - * It is therefore the correct place to signal vblank, send user flip events,
> - * and update VRR.
> - */
> -static void dm_dcn_crtc_high_irq(void *interrupt_params)
> -{
> -	struct common_irq_params *irq_params = interrupt_params;
> -	struct amdgpu_device *adev = irq_params->adev;
> -	struct amdgpu_crtc *acrtc;
> -	struct dm_crtc_state *acrtc_state;
> -	unsigned long flags;
> -
> -	acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
> -
>   	if (!acrtc)
>   		return;
>   
> @@ -528,22 +464,35 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
>   			 amdgpu_dm_vrr_active(acrtc_state),
>   			 acrtc_state->active_planes);
>   
> +	/**
> +	 * Core vblank handling at start of front-porch is only possible
> +	 * in non-vrr mode, as only there vblank timestamping will give
> +	 * valid results while done in front-porch. Otherwise defer it
> +	 * to dm_vupdate_high_irq after end of front-porch.
> +	 */
> +	if (!amdgpu_dm_vrr_active(acrtc_state))
> +		drm_crtc_handle_vblank(&acrtc->base);
> +
> +	/**
> +	 * Following stuff must happen at start of vblank, for crc
> +	 * computation and below-the-range btr support in vrr mode.
> +	 */
>   	amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
> -	drm_crtc_handle_vblank(&acrtc->base);
> +
> +	/* BTR updates need to happen before VUPDATE on Vega and above. */
> +	if (adev->family < AMDGPU_FAMILY_AI)
> +		return;
>   
>   	spin_lock_irqsave(&adev->ddev->event_lock, flags);
>   
> -	if (acrtc_state->vrr_params.supported &&
> +	if (acrtc_state->stream && acrtc_state->vrr_params.supported &&
>   	    acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
> -		mod_freesync_handle_v_update(
> -		adev->dm.freesync_module,
> -		acrtc_state->stream,
> -		&acrtc_state->vrr_params);
> +		mod_freesync_handle_v_update(adev->dm.freesync_module,
> +					     acrtc_state->stream,
> +					     &acrtc_state->vrr_params);
>   
> -		dc_stream_adjust_vmin_vmax(
> -			adev->dm.dc,
> -			acrtc_state->stream,
> -			&acrtc_state->vrr_params.adjust);
> +		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc_state->stream,
> +					   &acrtc_state->vrr_params.adjust);
>   	}
>   
>   	/*
> @@ -556,7 +505,8 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
>   	 * avoid race conditions between flip programming and completion,
>   	 * which could cause too early flip completion events.
>   	 */
> -	if (acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
> +	if (adev->family >= AMDGPU_FAMILY_RV &&
> +	    acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
>   	    acrtc_state->active_planes == 0) {
>   		if (acrtc->event) {
>   			drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
> @@ -568,7 +518,6 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
>   
>   	spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
>   }
> -#endif
>   
>   static int dm_set_clockgating_state(void *handle,
>   		  enum amd_clockgating_state state)
> @@ -2454,8 +2403,36 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
>   		c_irq_params->adev = adev;
>   		c_irq_params->irq_src = int_params.irq_source;
>   
> +		amdgpu_dm_irq_register_interrupt(
> +			adev, &int_params, dm_crtc_high_irq, c_irq_params);
> +	}
> +
> +	/* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond to
> +	 * the regular VUPDATE interrupt on DCE. We want DC_IRQ_SOURCE_VUPDATEx
> +	 * to trigger at end of each vblank, regardless of state of the lock,
> +	 * matching DCE behaviour.
> +	 */
> +	for (i = DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;
> +	     i <= DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT + adev->mode_info.num_crtc - 1;
> +	     i++) {
> +		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->vupdate_irq);
> +
> +		if (r) {
> +			DRM_ERROR("Failed to add vupdate irq id!\n");
> +			return r;
> +		}
> +
> +		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
> +		int_params.irq_source =
> +			dc_interrupt_to_irq_source(dc, i, 0);
> +
> +		c_irq_params = &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
> +
> +		c_irq_params->adev = adev;
> +		c_irq_params->irq_src = int_params.irq_source;
> +
>   		amdgpu_dm_irq_register_interrupt(adev, &int_params,
> -				dm_dcn_crtc_high_irq, c_irq_params);
> +				dm_vupdate_high_irq, c_irq_params);
>   	}
>   
>   	/* Use GRPH_PFLIP interrupt */
> @@ -4544,10 +4521,6 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
>   	struct amdgpu_device *adev = crtc->dev->dev_private;
>   	int rc;
>   
> -	/* Do not set vupdate for DCN hardware */
> -	if (adev->family > AMDGPU_FAMILY_AI)
> -		return 0;
> -
>   	irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
>   
>   	rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
