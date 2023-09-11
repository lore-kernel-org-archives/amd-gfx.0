Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B57EE7FF4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 13:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC0F10E2EE;
	Mon, 11 Sep 2023 13:08:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C5710E19A;
 Mon, 11 Sep 2023 08:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694421743; x=1725957743;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=kXCb911Im1WYlhVa1w+GsUGBVADxyxhDRL0Nfwv2OM4=;
 b=dLHEJLAC5ob/YE/az4Uxb64byqgFTvtSwVJyYYzTuW+Pn6/FIr7Y/n6y
 Udf6i0Fo9YgWMzCfgBaxLj1iF0Gd55urKSAau8cx58YELpUx7OTsWO6Xj
 3Y+HjoJyJPmCOlr+pIg+CsSJOYWmSCytEzuecRVbi+VJsLKaCHZAiJPlA
 JIC7YSyCFrMZc9c9D9QZ8U104Tm5qUU2U6+6rG/ocxS7ACW0CPH9Izkhd
 mgrUT7029J8FEbcy0mrIBjH+89YgGZqHFqtVTYXT7QS2UwumqjfOMrcUD
 JQNbKg4G3uUm+n5vO97A+bBRSuhMsI+FbMCOR+PjFnQyiQ670+wZrkcYW w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368268883"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="368268883"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2023 01:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916949458"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="916949458"
Received: from kschuele-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.252.63.119])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2023 01:42:17 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Remove unwanted drm edid references
In-Reply-To: <20230905171354.2657889-1-alex.hung@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230905171354.2657889-1-alex.hung@amd.com>
Date: Mon, 11 Sep 2023 11:42:15 +0300
Message-ID: <87tts1f6e0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 11 Sep 2023 13:08:23 +0000
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
Cc: stylon.wang@amd.com, haoping.liu@amd.com, srinivasan.shanmugam@amd.com,
 sunpeng.li@amd.com, airlied@gmail.com, Qingqing.Zhuo@amd.com,
 Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com, Alex Hung <alex.hung@amd.com>,
 daniel.wheeler@amd.com, aurabindo.pillai@amd.com, hersenxs.wu@amd.com,
 hamza.mahfooz@amd.com, daniel@ffwll.ch, wayne.lin@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 05 Sep 2023, Alex Hung <alex.hung@amd.com> wrote:
> [WHY]
> edid_override and drm_edid_override_connector_update, according to drm
> documentation, should not be referred outside drm_edid.
>
> [HOW]
> Remove and replace them accordingly.
>
> Signed-off-by: Alex Hung <alex.hung@amd.com>

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>

and thanks for doing this!

BR,
Jani.


> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++-----------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1bb1a394f55f..f6a255773242 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6372,15 +6372,12 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
>  static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
>  {
>  	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
> +	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
>  	struct dc_link *dc_link = aconnector->dc_link;
>  	struct dc_sink *dc_em_sink = aconnector->dc_em_sink;
>  	struct edid *edid;
>  
> -	if (!connector->edid_override)
> -		return;
> -
> -	drm_edid_override_connector_update(&aconnector->base);
> -	edid = aconnector->base.edid_blob_ptr->data;
> +	edid = drm_get_edid(connector, &amdgpu_connector->ddc_bus->aux.ddc);
>  	aconnector->edid = edid;
>  
>  	/* Update emulated (virtual) sink's EDID */
> @@ -6421,22 +6418,6 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
>  	};
>  	struct edid *edid;
>  
> -	if (!aconnector->base.edid_blob_ptr) {
> -		/* if connector->edid_override valid, pass
> -		 * it to edid_override to edid_blob_ptr
> -		 */
> -
> -		drm_edid_override_connector_update(&aconnector->base);
> -
> -		if (!aconnector->base.edid_blob_ptr) {
> -			DRM_ERROR("No EDID firmware found on connector: %s ,forcing to OFF!\n",
> -					aconnector->base.name);
> -
> -			aconnector->base.force = DRM_FORCE_OFF;
> -			return;
> -		}
> -	}
> -
>  	edid = (struct edid *) aconnector->base.edid_blob_ptr->data;
>  
>  	aconnector->edid = edid;

-- 
Jani Nikula, Intel Open Source Graphics Center
