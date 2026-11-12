Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9C606A331
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+n5XFq4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A550410E6BE;
	Thu, 12 Nov 2026 20:46:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BE710E6BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 20:46:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E549F4461D;
 Thu, 12 Nov 2026 20:46:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794516393;
 b=dS8daodbhVPbMz6sVZFe2ClEvSjDxfLyeCo2CHidsD2WWXALuOzLBqi+ewUKJlBu3cB9
 bWln72sQ7lCH3DJ9pRyZIfjx5WLs/l29spY4WnNtfo4LssmFHhxB7cn8xMeS9Ox0v2qsS
 6FnG7sa/9wUIXJsJM0mNys2xjl6f3AM238B8EAWw+YePXUD5tIELaWy/oJXRCqVlaA2k5
 yka/Nm14AIIDdU9JIN4qoeZFIjlXN7bYkNrZgMcgpYQQ7fRARRwPyH8npa21wL25Fgsrn
 iuHNkgGfFqg6uFCTJSmmtrW5As6xTTYZqFyKxWpwSoEy2a3l0Ms4uccrrqtrcHrQgfw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794516393;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=bhU8z/CBubfLQRWKxYA6pZiIC3DUL7PeabLeVW6uC9M=;
 b=Fw8znp9VeZe8Zqfgs0fo6F4l/KVlkkkv7nUtuOlrobPe2W1OcIrzDZAyXJ0K3obf/3l2
 IPxNb2bx/QNaEN6dRxbErI6Tt+PiLX9LN/9rBsCoWz/MK213m0iiumx6Xw3yoZlayhUDm
 vcJVakTk78BstssNsDOZBvDS+mb3WNA41Gcy/j+s7dYmz8SegUSmFZF2uTii6FKgULtD7
 HIgNfSZVITMhcL73v/TVHfwR2L+s5PpqY0W+Afg8mKG37htreButNJyJoyjRIJyNYxWHw
 BhYL6YBIQLLcjxfrrksLwnXp+F1oAa/qa+XAdR2mPylnxYMJ8vJOw38sIlKEWpvT7hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4FF5F1F000C4;
 Thu, 12 Nov 2026 20:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794516393;
 bh=bhU8z/CBubfLQRWKxYA6pZiIC3DUL7PeabLeVW6uC9M=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Q+n5XFq4WoZxnFdGO8/Bqq3ObpatbHrfgboZc5cgkIW2UaMyPMsY35utuxaWxUH7t
 6O+eXNFfbHC24/BgkFN8zKc9E0rb0Myn0vT9MviRipo4xIJ5KNiWNolLqCuzigZEpN
 g5d6n5AmIxWOcg95Bfhrr6INgUPywaoTCj780YpnoZxreCQb3+1iBY2nVoubEgFBrp
 r7+5YoZH1AdxsAVffOeGZyYWO4ZLEAQQg1NSTnpk+3Hy0qqJfoDh5foNr/Q1hA98WT
 5ZbM/8wmVQhnbmxxU2U0DTdk62SeKprKQEUg33cFhnMUN1jMDrQUMaqY0p3RLtPv++
 +Zt/i9kyYkv1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C4591474DE;
 Thu, 12 Nov 2026 20:46:32 +0000 (UTC)
From: Jameson Pair via B4 Relay <devnull+jkpair.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 14:46:05 -0600
Subject: [PATCH] drm/amd/display: Add ASUS ROG Bulwark DG310 PCON to
 FreeSync allowlist
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-dg310-pcon-vrr-v1-1-4888b7097218@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMwQ6CMAwA0F9peqYJrejifsVwwNFhPQzSKSEh/
 LtRj+/ydqzqphUj7Oi6WrW5YARuANNjKJOSjRgBpZULMwuN04lbWtJcaHWnTsI1hKE7S87YAC6
 u2bZfeOv/ru/7U9Pru+BxfAAxIWJ2cgAAAA==
X-Change-ID: 20261112-dg310-pcon-vrr-427977a452ff
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, Jameson Pair <jkpair@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794516392; l=2493;
 i=jkpair@gmail.com; s=20261112; h=from:subject:message-id;
 bh=IaHtGZwdEM/yO/9DxMrgKbM58p1r4Zl9A8RjAoZx16k=;
 b=iowwwB+Cy2pUmh2L/LEBmRWRiZaCMSqauWHoCFrUBz2dTP8vuv6NwHxqu0KaHbiPcq78BpOqg
 8gjvHU7Q9eoDNOIGWxjdW1NiOLKfbLLpz9TFlDgJwU8/iFwP2X4tTmu
X-Developer-Key: i=jkpair@gmail.com; a=ed25519;
 pk=GeD1yXy+BumOgxcXosI+5+L+1j8T0KNZzjWrBe1gnqQ=
X-Endpoint-Received: by B4 Relay for jkpair@gmail.com/20261112 with
 auth_id=1504
X-Original-From: Jameson Pair <jkpair@gmail.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: jkpair@gmail.com
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jameson Pair <jkpair@gmail.com>

The ASUS ROG Bulwark DG310 dock exposes its HDMI 2.1 output through a
DP-to-HDMI PCON with branch OUI bc:be:fb. The PCON sets
MSA_TIMING_PAR_IGNORED and ADAPTIVE_SYNC_SDP_SUPPORTED, but it is not in
dm_freesync_pcon_whitelist[], so FreeSync is never enabled on sinks
behind it.

Branch DPCD 0x500-0x50b: bc be fb fb 48 44 4d 49 62 01 40 84
(device id "\xfbHDMIb", hw rev 0x01, fw rev 0x40 0x84)

Tested on an ASUS ROG Xbox Ally X20 -> DG310 -> Samsung S90F (AMD VSDB
v3, 48-144 Hz) with a 7.3-based kernel that also finds the AMD VSDB in
every CTA extension, as the common EDID parser does since commit
ac10a874fc8a ("drm/edid: Parse AMD VSDB for FreeSync refresh range").
With this change VRR is reported capable and works; without it the
connector stays VRR-incapable.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jameson Pair <jkpair@gmail.com>
---
One-line allowlist addition for the DP-to-HDMI PCON in the ASUS ROG
Bulwark DG310 dock, so FreeSync works on HDMI sinks behind it.
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 drivers/gpu/drm/amd/display/include/ddc_service_types.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 3067ac5bb0cd..0c0d7b850c04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1712,6 +1712,7 @@ STATIC_IFN_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
 	DP_BRANCH_DEVICE_ID_90CC24,
 	DP_BRANCH_DEVICE_ID_001CF8,
 	DP_BRANCH_DEVICE_ID_001FF2,
+	DP_BRANCH_DEVICE_ID_BCBEFB,
 };
 EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist);
 
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 827e9bd7c5cf..dafecbd606a5 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -37,6 +37,7 @@
 #define DP_BRANCH_DEVICE_ID_001CF8 0x001CF8
 #define DP_BRANCH_DEVICE_ID_0060AD 0x0060AD
 #define DP_BRANCH_DEVICE_ID_001FF2 0x001FF2
+#define DP_BRANCH_DEVICE_ID_BCBEFB 0xBCBEFB
 #define DP_BRANCH_HW_REV_10 0x10
 #define DP_BRANCH_HW_REV_20 0x20
 

---
base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
change-id: 20261112-dg310-pcon-vrr-427977a452ff

Best regards,
--  
Jameson Pair <jkpair@gmail.com>


