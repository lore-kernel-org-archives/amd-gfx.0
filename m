Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46494606A33C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=verwilst.be header.i=@verwilst.be header.a=rsa-sha256 header.s=protonmail3 header.b=EZHsS6Xp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11BD112983;
	Fri, 27 Nov 2026 09:59:09 +0000 (UTC)
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F5C112609
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verwilst.be;
 s=protonmail3; t=1795714354; x=1795973554;
 bh=LGqcVcaydTIQRQ4BMJ2ovWJiZSzG7AUeW5b0zR7PZh8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=EZHsS6XpnLeq0j8l6zM4LX2S/oZMXnOUf6GZ/mtYfWSsEg3gDC1tJ/b/pipV+Dg7F
 bpfeOjY7DrFu+y+s8qXNiAUDXL6nTe675fKAMb30JrG0crguh6XnrXffp9dxWyVypG
 f8o+GAG/gwhOc5xDZbnQmWK+wCA/yHT7jEqX/PXYelTE+FRV4eyjmAERTuzh3C4x9T
 juYzac2J4M/gfXFZP87lHcamr3kjHwxtKtA9reODyyKj2RADO9iPhPR4lloMOsEoOU
 k3bLjPyyzNNv73Dopay4juYJD+Z3KFu3/pgaMwr874s+b7xjWq1cP/oQAaMMxJW5ET
 TbeJLHoBRquEg==
X-Pm-Submission-Id: 4jb3XJ6BH9z1DDLf
From: Bart Verwilst <bart@verwilst.be>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Wayne.Lin@amd.com
Subject: [PATCH v3 1/2] drm/amd/display: don't release an MST payload that
 holds no time slots
Date: Thu, 26 Nov 2026 18:31:55 +0100
Message-ID: <20261126173156.13147-2-bart@verwilst.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126173156.13147-1-bart@verwilst.be>
References: <20261126173156.13147-1-bart@verwilst.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
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
vc_start_slot means there is nothing to release. Skip the time slot
accounting in that case, but still drop the port reference of a deleted
payload and mark it unallocated, as drm_dp_remove_payload_part2() would.

Fixes: 83a79dd6f4fb ("drm/amd/display: adjust flow for deallocation mst payload")
Signed-off-by: Bart Verwilst <bart@verwilst.be>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6192c0f..b25d707 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -524,10 +524,35 @@ void dm_helpers_dp_mst_update_mst_mgr_for_deallocation(
 	mst_mgr = &aconnector->mst_root->mst_mgr;
 	mst_state = to_drm_dp_mst_topology_state(mst_mgr->base.state);
 	new_payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
-	dm_helpers_construct_old_payload(mst_mgr, mst_state,
-					 new_payload, &old_payload);
+	if (!new_payload)
+		return;
 
-	drm_dp_remove_payload_part2(mst_mgr, mst_state, &old_payload, new_payload);
+	/*
+	 * Only a payload that went through drm_dp_add_payload_part1() holds
+	 * time slots in the manager (vc_start_slot >= 0). Releasing a payload
+	 * that was never added, or releasing one twice, would underflow
+	 * payload_count and next_start_slot.
+	 */
+	if (new_payload->vc_start_slot >= 0) {
+		dm_helpers_construct_old_payload(mst_mgr, mst_state,
+						 new_payload, &old_payload);
+		drm_dp_remove_payload_part2(mst_mgr, mst_state, &old_payload,
+					    new_payload);
+	} else {
+		drm_dbg_kms(mst_mgr->dev,
+			    "MST payload for VCPI %d holds no time slots, nothing to release\n",
+			    new_payload->vcpi);
+		/*
+		 * Still do what drm_dp_remove_payload_part2() does apart from
+		 * the time slot accounting: drop the port reference of a
+		 * deleted payload, which drm_dp_mst_destroy_state() skips, and
+		 * mark the payload as unallocated.
+		 */
+		if (new_payload->delete)
+			drm_dp_mst_put_port_malloc(new_payload->port);
+		new_payload->payload_allocation_status =
+			DRM_DP_MST_PAYLOAD_ALLOCATION_NONE;
+	}
 
 	amdgpu_dm_set_mst_status(&aconnector->mst_status, set_flag, true);
 	amdgpu_dm_set_mst_status(&aconnector->mst_status, clr_flag, false);
-- 
2.56.1

