Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D0606A32A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=verwilst.be header.i=@verwilst.be header.a=rsa-sha256 header.s=protonmail3 header.b=YP3l/Zjt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90322112430;
	Thu, 26 Nov 2026 13:48:55 +0000 (UTC)
X-Greylist: delayed 58730 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 11:01:29 UTC
Received: from mail-07.mail-europe.com (mail-07.mail-europe.com
 [37.187.220.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D8610E87D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verwilst.be;
 s=protonmail3; t=1795690884; x=1795950084;
 bh=mqHNx7XbtgU+wSbeZ4nVnkhjmB8qJUYO01351tzRUx0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=YP3l/ZjtoRzsgVL3x1e0pXKbh7DUDMvJr3LTz9gZfbIU6LX7o90iQSL5frBqBrSZJ
 +3Ts8zr4F/xXSAAsfTdGpUvpzEmLPRsDbPV3g0ykr+jD8C3Kxs5bqekr4Ekle7QFIz
 MU7s7oNKEaF4Z1pAFu3muJd8c7roGTfF7RCdIRoMB+my1Gn7vcK6B3YaUXgRsGPgfD
 2bbCwZjiYYp9r4KTSgfgLtsFdJAwEYXmy9r7zxBqf1KhScJhgl2d42Tr4JcFJxfGyP
 SqHHoOwBrUn+3xFcNhOMezerfHXwFUcZO0AMZqY6jtn64p+p310vlQVLkOgfkmQ4bd
 IwP/33Of4Guug==
X-Pm-Submission-Id: 4jZtrr4RfTz2ScQG
From: Bart Verwilst <bart@verwilst.be>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Wayne.Lin@amd.com
Subject: [PATCH v2 1/2] drm/amd/display: don't release an MST payload that
 holds no time slots
Date: Thu, 26 Nov 2026 12:00:41 +0100
Message-ID: <20261126110042.14612-2-bart@verwilst.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126110042.14612-1-bart@verwilst.be>
References: <20261126110042.14612-1-bart@verwilst.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:48:49 +0000
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

dm_helpers_dp_mst_update_mst_mgr_for_deallocation() calls
drm_dp_remove_payload_part2() unconditionally. That function decrements
payload_count and moves next_start_slot back by the payload's time
slots. If the payload was never added with drm_dp_add_payload_part1(),
or was already released, both counters underflow. Every payload
allocated afterwards then starts at a bogus slot and ACT never
completes.

This can happen when the same stream is disabled twice, e.g. first by
link_set_all_streams_dpms_off_for_link() during a destructive link
verification and then again when userspace disables its CRTC, or when
the stream enable was aborted before its payload was allocated.

drm_dp_add_payload_part1() sets vc_start_slot and
drm_dp_remove_payload_part2() resets it to -1, so a negative
vc_start_slot means there is nothing to release. Return early in that
case.

Signed-off-by: Bart Verwilst <bart@verwilst.be>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6192c0f..bc26f65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -524,6 +524,22 @@ void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
 	mst_mgr = &aconnector->mst_root->mst_mgr;
 	mst_state = to_drm_dp_mst_topology_state(mst_mgr->base.state);
 	new_payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
+	if (!new_payload)
+		return;
+
+	/*
+	 * Only a payload that went through drm_dp_add_payload_part1() holds
+	 * time slots in the manager (vc_start_slot >= 0). Releasing a payload
+	 * that was never added, or releasing one twice, would underflow
+	 * payload_count and next_start_slot.
+	 */
+	if (new_payload->vc_start_slot < 0) {
+		drm_dbg_kms(mst_mgr->dev,
+			    "MST payload for VCPI %d holds no time slots, nothing to release\n",
+			    new_payload->vcpi);
+		return;
+	}
+
 	dm_helpers_construct_old_payload(mst_mgr, mst_state,
 					 new_payload, &old_payload);
 
-- 
2.56.1

