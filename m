Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736E606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckNb/Gg2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15F310E43B;
	Thu, 26 Nov 2026 08:55:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7255810E43B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 08:55:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 311FE443E7;
 Thu, 26 Nov 2026 08:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3581F000CA;
 Thu, 26 Nov 2026 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795683306;
 bh=vsdmHlp+UN88vF6mlRTwxSLqIxCAcKdWKPTf+pos+eo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ckNb/Gg2PAIy3YTakNQBuP2YZYlUt7xBYnCHtsJlTjy9QpnfKWjlR1Yi3J2hGTcqk
 gIe+gTbF8SuYFKa6TubvcLVr7NPr5opYZlKI6K4iFBlPVpbDTtW60hWthgZ+BR/f5X
 SoAZ3Z6cVd4rul0stEUYG36TQa7lW9FzjaSRb5HZPPQ7dp+VHIkAXVaTvqFxTOE9Aq
 jFY1onsojRXaRNxUpzK7a3hUVthghwsVWYIMbEKO62aMz3bujB0DLY5suCJCu5pae/
 Q8dhR+2zyn54io4Tlj2EMkFRXorcE3Jgg4jjGX1Hi6Kyiq0Op3pnnC2PTLRR/GqqMn
 tkfI+amJdVZew==
Message-ID: <sashiko-outbox-235063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: don't tear down a shared link for a
 stale SST/MST stream
To: "Bart Verwilst" <bart@verwilst.be>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125184208.36789-1-bart@verwilst.be>
References: <20261125184208.36789-1-bart@verwilst.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:55:05 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/amd/display: stale_on_link in link_set_dpms_off_v1() skips
  link teardown
- [High] drm/amd/display: link_set_dpms_off_v1() disables sink DSC on
  stale stream
- [High] drm/amd/display: link_set_dpms_off_v1() deallocates active USB4
  bandwidth
- [Medium] drm/amd/display: stale stream teardown skips resetting stream
  encoder VC rate
--

commit e05b38e79559c6d45e46f82ff60871a8b780f8ca
Author: Bart Verwilst <bart@verwilst.be>

drm/amd/display: don't tear down a shared link for a stale SST/MST stream

This commit detects when a stream being disabled in link_set_dpms_off_v1()
has a signal type that no longer matches the link's connection type, and
skips payload table programming and link teardown so a newly active stream
on the shared link is not disrupted.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c b/drivers=
/gpu/drm/amd/display/dc/link/link_dpms_v1.c
> index 1a6fe2e12c06a..fd37e68c2d97a 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
> @@ -2411,6 +2411,7 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx=
 *pipe_ctx)
>  	struct dc_link *link =3D stream->link;
>  	struct vpg *vpg =3D get_vpg(pipe_ctx);
>  	enum dp_panel_mode panel_mode_dp =3D dp_get_panel_mode(link);
> +	bool stale_on_link;
> =20
>  	ASSERT(is_master_pipe_for_link(link, pipe_ctx));
> =20
> @@ -2418,6 +2419,26 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ct=
x *pipe_ctx)
>  		/* No real hardware to program for virtual signals. */
>  		return DC_DPMS_SKIPPED_HANDSHAKE;
> =20
> +	/*
> +	 * A sink can switch between SST and MST on the same link, e.g. a
> +	 * monitor toggling Picture-by-Picture. The stream created for the
> +	 * previous mode stays in the state until userspace disables its CRTC,
> +	 * which can happen after a stream of the new mode is already lit on
> +	 * this link. Tearing such a stale stream down must not touch what is
> +	 * shared with the new mode: powering the sink down (DP_SET_POWER),
> +	 * disabling the PHY, or rewriting the link encoder's payload
> +	 * allocation. Only release the stream's own resources.
> +	 */
> +	stale_on_link =3D
> +		(dc_is_dp_sst_signal(stream->signal) &&
> +		 link->type =3D=3D dc_connection_mst_branch) ||
> +		(stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST &&
> +		 (link->type =3D=3D dc_connection_single ||
> +		  link->type =3D=3D dc_connection_sst_branch));
> +	if (stale_on_link)
> +		DC_LOG_WARNING("%s: stale signal %x on link %u (type %d), link kept up=
\n",
> +			       __func__, stream->signal, link->link_index, link->type);
> +

[Severity: High]
Can stale_on_link evaluate to true when no replacement stream is active on
the link?

stale_on_link only compares stream->signal against link->type without
checking whether another stream with dpms_off =3D=3D false is actually acti=
ve
on the link in dc->current_state.

During HPD processing in link_detect(), detect_link_and_local_sink() resets
link->type to dc_connection_single or dc_connection_sst_branch before
verify_link_capability() runs and before discover_dp_mst_topology()
restores link->type to dc_connection_mst_branch:

drivers/gpu/drm/amd/display/dc/link/link_detection.c:link_detect() {
	is_local_sink_detect_success =3D detect_link_and_local_sink(link, reason);

	if (is_local_sink_detect_success && link->local_sink) {
		verify_link_capability(link, reason);
	}
	...
	if (is_local_sink_detect_success && link->local_sink &&
			dc_is_dp_signal(link->local_sink->sink_signal) &&
			link->dpcd_caps.is_mst_capable)
		is_delegated_to_mst_top_mgr =3D discover_dp_mst_topology(link, reason);
}

When verify_link_capability_destructive() calls
link_set_all_streams_dpms_off_for_link() on an active 128b/132b MST link,
link_set_dpms_off_v1() sees link->type !=3D dc_connection_mst_branch, treats
the active MST stream as stale, skips disable_link(), and leaves the HPO
link encoder and link->link_status.link_active enabled while running
dm_helpers_dp_mst_update_mst_mgr_for_deallocation().  When userspace later
disables that CRTC, reset_back_end_for_pipe() sees
link->link_status.link_active still set and calls link_set_dpms_off_v1() a
second time for the same stream, running
dm_helpers_dp_mst_update_mst_mgr_for_deallocation() ->
drm_dp_remove_payload_part2() again and underflowing mst_mgr->payload_count.

The same skip of disable_link() also happens if userspace disables the old
CRTC before enabling the new one (or switches both in a single atomic
commit, where dce110_apply_ctx_to_hw() runs reset_hw_ctx_wrap() before
enabling new streams), leaving the link encoder, PHY, sink power state, and
link_active enabled with no active stream.

> @@ -2443,11 +2464,21 @@ enum dc_status link_set_dpms_off_v1(struct pipe_c=
tx *pipe_ctx)
>  	    stream->sink)
>  		deallocate_usb4_bandwidth(stream);

[Severity: High]
Does calling deallocate_usb4_bandwidth(stream) when stale_on_link is true
tear down the USB4 DP tunnel bandwidth allocated by the new mode's stream?

deallocate_usb4_bandwidth() calls allocate_usb4_bandwidth_for_stream(stream,
0) on the shared dc_link.  For a stale SST stream (or a stale MST stream
when link->sink_count is 0 in SST mode), req_bw evaluates to 0 and
link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0) requests 0
bandwidth for the link over DPCD while the new stream is running.

> -	if (stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST)
> +	if (stale_on_link) {
> +		/* bookkeeping only, the link belongs to the new mode now */
> +		if (stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST) {
> +			remove_stream_from_alloc_table(link,
> +						       pipe_ctx->stream_res.stream_enc,
> +						       pipe_ctx->stream_res.hpo_dp_stream_enc);
> +			dm_helpers_dp_mst_update_mst_mgr_for_deallocation(stream->ctx,
> +									  stream);
> +		}
> +	} else if (stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT_MST) {
>  		deallocate_mst_payload(pipe_ctx);
> -	else if (dc_is_dp_sst_signal(stream->signal) &&
> -			dp_is_128b_132b_signal(pipe_ctx))
> +	} else if (dc_is_dp_sst_signal(stream->signal) &&
> +			dp_is_128b_132b_signal(pipe_ctx)) {
>  		update_sst_payload(pipe_ctx, false);
> +	}

[Severity: Medium]
Does bypassing deallocate_mst_payload() and update_sst_payload(pipe_ctx,
false) leave the stale stream encoder's VC time-slot rate and HBLANK
minimum symbol width programmed in hardware?

Both helpers zero link_hwss->ext.set_throttled_vcp_size() and
link_hwss->ext.set_hblank_min_symbol_width() for pipe_ctx before touching
the link's stream allocation table.  Unlike the allocation table, those
callbacks program registers indexed by pipe_ctx's own stream encoder
instance (such as DP_DPHY_SYM32_VC_RATE_CNTL0..3,
DP_SYM32_ENC_HBLANK_CONTROL, or DP_MSE_RATE_CNTL), which
dc->hwss.disable_stream() does not clear.

>  	if (dc_is_hdmi_signal(stream->signal)) {
>  		struct ext_hdmi_settings settings =3D {0};
> @@ -2472,7 +2503,9 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx=
 *pipe_ctx)
>  		}
>  	}
> =20
> -	if (stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT &&
> +	if (stale_on_link) {
> +		dc->hwss.disable_stream(pipe_ctx);
> +	} else if (stream->signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT &&
>  			!dp_is_128b_132b_signal(pipe_ctx)) {
> =20
>  		/* In DP1.x SST mode, our encoder will go to TPS1

[Severity: High]
Just below this block, when stream->timing.flags.DSC is set on the stale DP
stream, link_set_dpms_off_v1() still calls link_set_dsc_enable(pipe_ctx,
false):

drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c:link_set_dpms_off_v1() {
	...
	if (stream->timing.flags.DSC) {
		if (dc_is_dp_signal(stream->signal))
			link_set_dsc_enable(pipe_ctx, false);
		else if (dc_is_hdmi_frl_signal(stream->signal))
			link_set_dsc_on_stream(pipe_ctx, false);
	}
}

Will link_set_dsc_enable(pipe_ctx, false) disable DSC on the shared sink
while the new stream is using it?

link_set_dsc_enable(pipe_ctx, false) calls dp_set_dsc_on_rx(pipe_ctx,
false) before link_set_dsc_on_stream(pipe_ctx, false), which writes 0 to
DP_DSC_ENABLE (DPCD 0x00160) on the receiver over AUX.  When stale_on_link
is true, calling link_set_dsc_on_stream(pipe_ctx, false) instead would
release the pipe's DCN DSC hardware without touching the sink's
DP_DSC_ENABLE register.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125184208.3678=
9-1-bart@verwilst.be?part=3D1
