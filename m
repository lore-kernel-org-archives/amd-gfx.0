Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41AAC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7607864F65
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7607864F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146A66EA15;
	Fri, 19 Mar 2021 14:23:24 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA8C6E9ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 11:35:35 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 a22-20020a17090aa516b02900c1215e9b33so6570162pjq.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oKHyKM5HpgM64/v1vzFdLp1d/ZtBozUZ21Nb1Kh1LfE=;
 b=oA4VSa+nu/9W7HEreKS2m+YjOanl3TPCruPFBgMTvzGK1JsQbrp7ZQne4hciU+1JpL
 tC2hWULRXHHPm4YwQNXxvUbUHsNu+x7lQ8tKHvDxk7FyQH65oZsd+VfiJrYfgCeNw0x0
 2EN2PSSWRcAdVl/GZMvNDl5QVcWps3mc2u+aTI6dsRha6h0AuWq8HTAlXVRbHO39y8q4
 WZkfB+U/TXLwbSlwImsWvK008U6xWpuA1uj8mdfmuDOUeq0ILBuWvf9PQZDnWX1pHpET
 Cgam/1cfnlVfvmOO9ujm+CmSjw2dgkAUvDDxyLpJFCwN1ntNUPTBIZ28vTqcL+GsxyRT
 dvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oKHyKM5HpgM64/v1vzFdLp1d/ZtBozUZ21Nb1Kh1LfE=;
 b=dF6TkG2bUP8PrxtklOp+PrnlkQP1m1VUu7mnhzg4Yd2gKuglr6IWz+C9EP5lPGM3it
 6VyRVyg9VilAv4IiXISHo4tSX4RN4J0e66wXXXqh2kUr1BSfLa/YTaN7HmJfuRP3agQ2
 BiQ7oZjY5ifMwuVPzZKa5BRW9OHowJXt4JCmVUizvYheZuYdFP5Xr3dwCGc8NlOKBmL7
 i85ye/a82ZIW3Pw/LZaKeCNWuRdWw6pRWfwopSDptF41He9wCiQV+EatSttc9F5YEQ4Z
 agDfk/f3gKsjhtM0PyjVleQl3vjWJVQPa8KJv0cu5rge9QCRJDzbVeXSislyLdm9VwGQ
 VdNA==
X-Gm-Message-State: AOAM530fpUURqLf2BcBDE4oYBGo3i74v6cO0Pioj/Z5wo0F+8LpxH7mT
 K2ZLwSF7/q2+5on/vsrf37rKkzTYttjQdNre/SnKNw==
X-Google-Smtp-Source: ABdhPJyYOsIuX8edCxIL4tkKbNSgbtWLcodZmdaiaQmxoRZST0LiH2O2E/Mhxco68rpGovr0mKxDhbougBexQ4y0Q9k=
X-Received: by 2002:a17:902:e752:b029:e6:822c:355c with SMTP id
 p18-20020a170902e752b02900e6822c355cmr14084469plf.69.1616153735064; Fri, 19
 Mar 2021 04:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210219215326.2227596-1-lyude@redhat.com>
 <20210219215326.2227596-28-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-28-lyude@redhat.com>
From: Robert Foss <robert.foss@linaro.org>
Date: Fri, 19 Mar 2021 12:35:24 +0100
Message-ID: <CAG3jFyuvnDQXXJKaY7zqi01_BG7pvFj0_9DJ2eAr2C=FvUtL1A@mail.gmail.com>
Subject: Re: [PATCH 27/30] drm/dp_mst: Pass drm_dp_mst_topology_mgr to
 drm_dp_get_vc_payload_bw()
To: Lyude Paul <lyude@redhat.com>
X-Mailman-Approved-At: Fri, 19 Mar 2021 14:23:23 +0000
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
Cc: Maxime Ripard <mripard@kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Anshuman Gupta <anshuman.gupta@intel.com>,
 Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
 David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Ramalingam C <ramalingam.c@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lee Shawn C <shawn.c.lee@intel.com>,
 Imre Deak <imre.deak@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Lyude,

Thanks for the patch.

On Fri, 19 Feb 2021 at 23:03, Lyude Paul <lyude@redhat.com> wrote:
>
> Since this is one of the few functions in drm_dp_mst_topology.c that
> doesn't have any way of getting access to a drm_device, let's pass the
> drm_dp_mst_topology_mgr down to this function so that it can use
> drm_dbg_kms().
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c       | 7 +++++--
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
>  include/drm/drm_dp_mst_helper.h             | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index cf4f2f85711e..fb66df39e0bb 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3631,6 +3631,7 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
>
>  /**
>   * drm_dp_get_vc_payload_bw - get the VC payload BW for an MST link
> + * @mgr: The &drm_dp_mst_topology_mgr to use
>   * @link_rate: link rate in 10kbits/s units
>   * @link_lane_count: lane count
>   *
> @@ -3639,7 +3640,8 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
>   * convert the number of PBNs required for a given stream to the number of
>   * timeslots this stream requires in each MTP.
>   */
> -int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count)
> +int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
> +                            int link_rate, int link_lane_count)
>  {
>         if (link_rate == 0 || link_lane_count == 0)
>                 DRM_DEBUG_KMS("invalid link rate/lane count: (%d / %d)\n",
> @@ -3704,7 +3706,8 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
>                         goto out_unlock;
>                 }
>
> -               mgr->pbn_div = drm_dp_get_vc_payload_bw(drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
> +               mgr->pbn_div = drm_dp_get_vc_payload_bw(mgr,
> +                                                       drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
>                                                         mgr->dpcd[2] & DP_MAX_LANE_COUNT_MASK);
>                 if (mgr->pbn_div == 0) {
>                         ret = -EINVAL;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 8e316146b6d1..60ca0fa32d15 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -70,7 +70,8 @@ static int intel_dp_mst_compute_link_config(struct intel_encoder *encoder,
>                 slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
>                                                       connector->port,
>                                                       crtc_state->pbn,
> -                                                     drm_dp_get_vc_payload_bw(crtc_state->port_clock,
> +                                                     drm_dp_get_vc_payload_bw(&intel_dp->mst_mgr,
> +                                                                              crtc_state->port_clock,
>                                                                                crtc_state->lane_count));

checkpatch --strict is unhappy about this chunk

WARNING: line length of 102 exceeds 100 columns
#61: FILE: drivers/gpu/drm/i915/display/intel_dp_mst.c:73:
+                                           crtc_state->port_clock,

Maybe the results of drm_dp_get_vc_payload_bw() can be but in a
temporary variable.

>                 if (slots == -EDEADLK)
>                         return slots;
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index bd1c39907b92..20dc705642bd 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -783,7 +783,8 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
>
>  struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
>
> -int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count);
> +int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
> +                            int link_rate, int link_lane_count);
>
>  int drm_dp_calc_pbn_mode(int clock, int bpp, bool dsc);
>
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
