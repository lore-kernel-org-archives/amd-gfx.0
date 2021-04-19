Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD7C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 22:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5F261026
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 22:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5F261026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26BE96E4CF;
	Mon, 19 Apr 2021 22:57:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7030A6E4BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618873065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aORR5BDLVuChgsGPTpiSbr2OxX85lHm3aaLawSJYbVM=;
 b=jOddZxutI+x8udB23TOTGtNK15DnS7OfVGcyvOOd2nDpHfS5xU/Gh3YCEKvUKWse0T/6O3
 jb2BMbzrcP4JDwrYJAsRaMy88ioizyso1b2I1qX8jjCMuIcXmW32K1QBzI81YoH7gzc7Au
 zxy3NIIrCBOZkWx7+4/iO1UPvxvkcyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-15fvv2bnOhSJvr70IefdHA-1; Mon, 19 Apr 2021 18:57:41 -0400
X-MC-Unique: 15fvv2bnOhSJvr70IefdHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D9E1006C80;
 Mon, 19 Apr 2021 22:57:39 +0000 (UTC)
Received: from Ruby.lyude.net (ovpn-119-153.rdu2.redhat.com [10.10.119.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A29835C1C4;
 Mon, 19 Apr 2021 22:57:36 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 16/20] drm/dp_mst: Pass drm_dp_mst_topology_mgr to
 drm_dp_get_vc_payload_bw()
Date: Mon, 19 Apr 2021 18:55:18 -0400
Message-Id: <20210419225523.184856-17-lyude@redhat.com>
In-Reply-To: <20210419225523.184856-1-lyude@redhat.com>
References: <20210419225523.184856-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, David Airlie <airlied@linux.ie>,
 Ramalingam C <ramalingam.c@intel.com>, Imre Deak <imre.deak@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Sean Paul <seanpaul@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Anshuman Gupta <anshuman.gupta@intel.com>, Lee Shawn C <shawn.c.lee@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since this is one of the few functions in drm_dp_mst_topology.c that
doesn't have any way of getting access to a drm_device, let's pass the
drm_dp_mst_topology_mgr down to this function so that it can use
drm_dbg_kms().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c       | 7 +++++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
 include/drm/drm_dp_mst_helper.h             | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 276f7f054d62..9bac5bd050ab 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3638,6 +3638,7 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
 
 /**
  * drm_dp_get_vc_payload_bw - get the VC payload BW for an MST link
+ * @mgr: The &drm_dp_mst_topology_mgr to use
  * @link_rate: link rate in 10kbits/s units
  * @link_lane_count: lane count
  *
@@ -3646,7 +3647,8 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
  * convert the number of PBNs required for a given stream to the number of
  * timeslots this stream requires in each MTP.
  */
-int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count)
+int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
+			     int link_rate, int link_lane_count)
 {
 	if (link_rate == 0 || link_lane_count == 0)
 		DRM_DEBUG_KMS("invalid link rate/lane count: (%d / %d)\n",
@@ -3711,7 +3713,8 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 			goto out_unlock;
 		}
 
-		mgr->pbn_div = drm_dp_get_vc_payload_bw(drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
+		mgr->pbn_div = drm_dp_get_vc_payload_bw(mgr,
+							drm_dp_bw_code_to_link_rate(mgr->dpcd[1]),
 							mgr->dpcd[2] & DP_MAX_LANE_COUNT_MASK);
 		if (mgr->pbn_div == 0) {
 			ret = -EINVAL;
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 180f97cd74cb..eb04b3cefda2 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -70,7 +70,8 @@ static int intel_dp_mst_compute_link_config(struct intel_encoder *encoder,
 		slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
 						      connector->port,
 						      crtc_state->pbn,
-						      drm_dp_get_vc_payload_bw(crtc_state->port_clock,
+						      drm_dp_get_vc_payload_bw(&intel_dp->mst_mgr,
+									       crtc_state->port_clock,
 									       crtc_state->lane_count));
 		if (slots == -EDEADLK)
 			return slots;
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index bd1c39907b92..20dc705642bd 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -783,7 +783,8 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 
 struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
 
-int drm_dp_get_vc_payload_bw(int link_rate, int link_lane_count);
+int drm_dp_get_vc_payload_bw(const struct drm_dp_mst_topology_mgr *mgr,
+			     int link_rate, int link_lane_count);
 
 int drm_dp_calc_pbn_mode(int clock, int bpp, bool dsc);
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
