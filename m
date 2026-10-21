Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41D606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=sJofjth0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C2710FDD2;
	Wed, 21 Oct 2026 12:31:33 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BB010FDD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=OSt91+ZX60mA6O40wV3630WkHb164HF/2QXNsPJjejE=; b=
 sJofjth0LGt9cRdQuY0cVTRU7fQuNZIBLPuMuFpcAWmDlP2myFx7dBqjJNpP81E0OWPHqSgMWjAka
 OQ8cAUfgP1+4L2CU5EGLL05LIdtJigtYyQQOHUujdhWYFBN6j6R35mhlJ92ZcL38R1IxOozen7Ley
 fFDoUfsFfPTtTEa5z32yQzY7xPx1oCL8oPcir4f2K61YaJ4e1jIvnkRM1Vae7lfWo1sRL+kR4VApm
 8FYRU9RJ/n3rnwjD2/n4beUnzfJWx/bZ8qIQkkMSfVLrYDHsBQbuXRP72N0BA84cljxhCSZidvRYr
 iEdajAfiIAn6JsQPpOBYboV0mCn5lYnJ+Q==;
Received: from 62-87-103-230.red-acceso.airtel.net ([62.87.103.230]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJVTB-005cgk-JF; Wed, 21 Oct 2026 14:31:01 +0200
From: Melissa Wen <mwen@igalia.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Xaver Hugl <xaver.hugl@kde.org>, Alex Hung <alex.hung@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Melissa Wen <mwen@igalia.com>,
 "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: [PATCH] drm/amd/display: signal PQ EOTF in FreeSync infopacket for DP
 HDR
Date: Wed, 21 Oct 2026 14:29:25 +0200
Message-ID: <20261021123020.53928-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit c2791297013e ("drm/amd/display: Add color bit info to freesync
infoframe") created the app_tf interface for FreeSync HDR and commit
c21a764a98cb ("drm/amd/display: Send PQ bit in AMD VSIF") used it to set
PB9 bit 5 (PQ EOTF) in v2/v3 AMD Freesync infopacket. However, Linux
never made use of this interface: DM ignores what userspace sets
regarding HDR and always passes TRANSFER_FUNC_UNKNOWN as app_tf, so the
PQ bit is never set in the infopacket received by the eDP panel.

Check the EOTF in the HDR static metadata and set the PQ bit in Freesync
infopacket for DP accordingly. This fixes gray-washed HDR on KDE/GNOME
on Framework 13 Pro AI 9 HX 370 (DCN 3.5) and may fix similar issues on
other VRR-capable panels that advertise Replay in its AMD VSDB.

It doesn't affect color/EOTF bits on infopackets for SDR and native
HDMI.

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/3200
Reported-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index ab9cfbce8d73..322106d1cce7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -165,6 +165,18 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_get_freesync_config_for_crtc);
 
+#define DP_HDR_SDP_EOTF_IDX 2
+
+static bool dm_dp_in_hdr_mode(const struct dc_stream_state *stream)
+{
+	const struct dc_info_packet *hdr = &stream->hdr_static_metadata;
+
+	if (!dc_is_dp_signal(stream->signal) || !hdr->valid)
+		return false;
+
+	return hdr->sb[DP_HDR_SDP_EOTF_IDX] == HDMI_EOTF_SMPTE_ST2084;
+}
+
 void amdgpu_dm_update_freesync_state_on_stream(
 	struct amdgpu_display_manager *dm,
 	struct dm_crtc_state *new_crtc_state,
@@ -181,6 +193,7 @@ void amdgpu_dm_update_freesync_state_on_stream(
 	bool pack_sdp_v1_3 = false;
 	struct amdgpu_dm_connector *aconn;
 	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
+	enum color_transfer_func app_tf;
 
 	if (!new_stream)
 		return;
@@ -232,12 +245,16 @@ void amdgpu_dm_update_freesync_state_on_stream(
 					&new_stream->adaptive_sync_infopacket);
 	}
 
+	app_tf =  dm_dp_in_hdr_mode(new_stream) ?
+		  TRANSFER_FUNC_PQ2084 :
+		  TRANSFER_FUNC_UNKNOWN;
+
 	mod_freesync_build_vrr_infopacket(
 		dm->freesync_module,
 		new_stream,
 		&vrr_params,
 		packet_type,
-		TRANSFER_FUNC_UNKNOWN,
+		app_tf,
 		&vrr_infopacket,
 		pack_sdp_v1_3);
 
-- 
2.53.0

