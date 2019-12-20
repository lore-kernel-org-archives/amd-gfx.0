Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295BC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03E820866
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd9Hh2gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03E820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C096E150;
	Fri, 20 Dec 2019 21:41:24 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B9D6E150
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 21:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576878082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wljEDLQblov4l0mmb6ZvDHLhjxactWCRTqDqVyTkNSQ=;
 b=bd9Hh2gcIQozoL6WzVrWWg+25LflyLMP+8s2g7tkmNNToTf7/WBjCp0VUtSLdNFPNKM3JG
 vKKIkWRTbnExm2NUXeJYh8hYZi33OiEdwSRTEqc4a7iIZaF9KFUXMCpaXL1HMj4whuO3cQ
 R0EEiNEn3oeAqxSaYUZcRPYdUyypLSg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-XMAiPiBZOb6b6Cs3AlKKcg-1; Fri, 20 Dec 2019 16:41:21 -0500
Received: by mail-qk1-f198.google.com with SMTP id w64so6855015qka.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 13:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=wljEDLQblov4l0mmb6ZvDHLhjxactWCRTqDqVyTkNSQ=;
 b=NOKHRls+tBRESjVdecERhoHbfrtlASZvQENndYavE7vm7lzeD1csQjvaAYRbn2MfB/
 FC/KTG0FGHmX4GGKiAswFu1ZBPl6LZIKVUvh6aksJirwUc/LmQxm+b6rkOw2JVeZAvaD
 fISpREgR8XTR3o1M48C4ydaRYN2pQQiTD/vIp5IsOA9aJ7H5O8+eKGhIn4/KLmQ1PjCm
 48OZcqklJ1EezQCboeu5hx37ndoc42AoaL3BBHjzZRpTZtw4UWFHWmJkyPCna217p6is
 TT5PcE1k0LuzG3vTLzAgKgKgUyaWonzw35s/ZTPlkO06c2ACqxyA01C4+OrdtIoRDlfC
 GdvA==
X-Gm-Message-State: APjAAAXU0hr1Ni0JX8ZlIxusTUAf4e3D/ojP3nOCWaSXfn51AGST+yud
 I7F4QSZZ6a73qwJGYuh/8HndYDJAzcr7BLgrr/0n2+5X9olpX7I2dcgP0vL1IK3YzqiJXwN6Kr0
 A8SpGUob4TZJNPk+ek4BialRyEg==
X-Received: by 2002:ac8:4a97:: with SMTP id l23mr12543048qtq.231.1576878080635; 
 Fri, 20 Dec 2019 13:41:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6j2WyKIB3vmdUfoi1n/E3XmBMUyYUUbnpf7PSfZNnClUzLhyG/T4KC6YpZLyTM3ypRQYSwA==
X-Received: by 2002:ac8:4a97:: with SMTP id l23mr12543035qtq.231.1576878080407; 
 Fri, 20 Dec 2019 13:41:20 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id y184sm3183137qkd.128.2019.12.20.13.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 13:41:19 -0800 (PST)
Message-ID: <08a2b34d55043c9be603d739211c39702a760e97.camel@redhat.com>
Subject: Re: [PATCH v9 16/18] drm/amd/display: Recalculate VCPI slots for
 new DSC connectors
From: Lyude Paul <lyude@redhat.com>
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org
Date: Fri, 20 Dec 2019 16:41:18 -0500
In-Reply-To: <20191213200854.31545-17-mikita.lipski@amd.com>
References: <20191213200854.31545-1-mikita.lipski@amd.com>
 <20191213200854.31545-17-mikita.lipski@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: XMAiPiBZOb6b6Cs3AlKKcg-1
X-Mimecast-Spam-Score: 0
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
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So I reviewed this already but realized I made a very silly mistake, comments
down below:

On Fri, 2019-12-13 at 15:08 -0500, mikita.lipski@amd.com wrote:
> From: Mikita Lipski <mikita.lipski@amd.com>
> 
> [why]
> Since for DSC MST connector's PBN is claculated differently
> due to compression, we have to recalculate both PBN and
> VCPI slots for that connector.
> 
> [how]
> The function iterates through all the active streams to
> find, which have DSC enabled, then recalculates PBN for
> it and calls drm_dp_helper_update_vcpi_slots_for_dsc to
> update connector's VCPI slots.
> 
> v2: - use drm_dp_mst_atomic_enable_dsc per port to
> enable/disable DSC
> 
> v3: - Iterate through connector states from the state passed
>     - On each connector state get stream from dc_state,
> instead CRTC state
> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 76 +++++++++++++++++--
>  1 file changed, 71 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 93a230d956ee..2ac3a2f0b452 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4986,6 +4986,69 @@ const struct drm_encoder_helper_funcs
> amdgpu_dm_encoder_helper_funcs = {
>  	.atomic_check = dm_encoder_helper_atomic_check
>  };
>  
> +static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
> +					    struct dc_state *dc_state)
> +{
> +	struct dc_stream_state *stream = NULL;
> +	struct drm_connector *connector;
> +	struct drm_connector_state *new_con_state, *old_con_state;
> +	struct amdgpu_dm_connector *aconnector;
> +	struct dm_connector_state *dm_conn_state;
> +	int i, j, clock, bpp;
> +	int vcpi, pbn_div, pbn = 0;
> +
> +	for_each_oldnew_connector_in_state(state, connector, old_con_state,
> new_con_state, i) {
> +
> +		aconnector = to_amdgpu_dm_connector(connector);
> +
> +		if (!aconnector->port)
> +			continue;
> +
> +		if (!new_con_state || !new_con_state->crtc)
> +			continue;
> +
> +		dm_conn_state = to_dm_connector_state(new_con_state);
> +
> +		for (j = 0; j < dc_state->stream_count; j++) {
> +			stream = dc_state->streams[j];
> +			if (!stream)
> +				continue;
> +
> +			if ((struct amdgpu_dm_connector*)stream-
> >dm_stream_context == aconnector)
> +				break;
> +
> +			stream = NULL;
> +		}
> +
> +		if (!stream)
> +			continue;
> +
> +		if (stream->timing.flags.DSC != 1) {
> +			drm_dp_mst_atomic_enable_dsc(state,
> +						     aconnector->port,
> +						     dm_conn_state->pbn,
> +						     0,
> +						     false);
> +			continue;
> +		}
> +
> +		pbn_div = dm_mst_get_pbn_divider(stream->link);
> +		bpp = stream->timing.dsc_cfg.bits_per_pixel;
> +		clock = stream->timing.pix_clk_100hz / 10;
> +		pbn = drm_dp_calc_pbn_mode(clock, bpp, true);
> +		vcpi = drm_dp_mst_atomic_enable_dsc(state,
> +						    aconnector->port,
> +						    pbn, pbn_div,
> +						    true);
> +		if (vcpi < 0)
> +			return vcpi;
> +
> +		dm_conn_state->pbn = pbn;
> +		dm_conn_state->vcpi_slots = vcpi;
> +	}
> +	return 0;
> +}
> +
>  static void dm_drm_plane_reset(struct drm_plane *plane)
>  {
>  	struct dm_plane_state *amdgpu_state = NULL;
> @@ -8022,11 +8085,6 @@ static int amdgpu_dm_atomic_check(struct drm_device
> *dev,
>  	if (ret)
>  		goto fail;
>  
> -	/* Perform validation of MST topology in the state*/
> -	ret = drm_dp_mst_atomic_check(state);
> -	if (ret)
> -		goto fail;
> -
>  	if (state->legacy_cursor_update) {
>  		/*
>  		 * This is a fast cursor update coming from the plane update
> @@ -8098,6 +8156,10 @@ static int amdgpu_dm_atomic_check(struct drm_device
> *dev,
>  		if (!compute_mst_dsc_configs_for_state(state, dm_state-
> >context))
>  			goto fail;
>  
> +		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state-
> >context);
> +		if (ret)
> +			goto fail;
> +
>  		if (dc_validate_global_state(dc, dm_state->context, false) !=
> DC_OK) {
>  			ret = -EINVAL;
>  			goto fail;
> @@ -8126,6 +8188,10 @@ static int amdgpu_dm_atomic_check(struct drm_device
> *dev,
>  				dc_retain_state(old_dm_state->context);
>  		}
>  	}
> +	/* Perform validation of MST topology in the state*/
> +	ret = drm_dp_mst_atomic_check(state);
> +	if (ret)
> +		goto fail;

I realized that we actually should make it so that we actually expose a
version of drm_dp_mst_atomic_check() which allows you to manually specify a
drm_dp_mst_topology_state, because otherwise we're checking the bandwidth caps
of _ALL_ enabled topologies which could cause us to fail just because another
topology's new state doesn't meet the bandwidth requirements yet because we
haven't readjusted it for the fair share compute algorithm.

Also, I think we should probably differentiate in the atomic check functions
between failing an atomic check for a topology state because it doesn't meet
the bandwidth requirements we set, vs. a topology state failing atomic check
for other reasons (temporary deadlock, too many payloads, etc.). So basically-
we should return -ENOSPC when we fail because of a bandwidth (including VCPI
slot allocation) issue.

>  
>  	/* Store the overall update type for use later in atomic check. */
>  	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
