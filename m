Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48EACD4F5F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 08:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A19610E74A;
	Thu, 13 Nov 2025 08:36:20 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A479710E751
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:18:44 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso547999f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 07:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762960723; x=1763565523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9ERKG+RVswYeFDCXzwz7sJNCbZbjByWuF1IneGgYXk=;
 b=ul6cKlaCWwwN1GEYYWn3mahAL4RtS3fL/nnWHsS0X5zazpUqjqJA/vQdF+cETKm6Vg
 gQs/do4le8La+gvt6nAdV4hp2hqDZ3QIby47l/fRCoXtBRa5IS4MW8D0TUrld+My9k2E
 7IwxK1S1Al8BpNUIJftZEsTyAJ9rOgNE4j9RBS7ZehAaEb1RzkDfL/2lhnm1IhXjIf/m
 U1Gnjyeh8JpOXFUdaM6P/W6U4ClqRokK6Qwu8Zm00SixZH4ug8ey8qDwxov/Vhj3KlK/
 LWUrjSrAi334x098Igzf/PIPgH1F1GMnx4HLFjzrL2YMs9VZLFC8muYK5Neqo21AAY5/
 VRSw==
X-Gm-Message-State: AOJu0Yy1jR9pr5ufmqbYXnHHLdN8KcDPSGHlVAmuhKFHUsKBax6SuDT7
 8Uf1iOuV3QvFXlvb2OwlTBrH48YP3p5vbPSrxLzE//QVnQN5je8TBkGq
X-Gm-Gg: ASbGncuEJAAXSgCKVntlw3z9u9+4rdaWjPNl32sFVlvyusUlfjoe+s1DJci4JZ6DFUt
 WR5109paQAqlvt1icQntvfXK+r6vvUPMOpwP2TADIN4VewMSQq0IVewz2Cccy99W7DJH9azVMMW
 gj7JRMDqHhBvEti+rXt4WKHJCA0jOndxULpRNLpwexMV5Vddz4yNF/PQCnlfHJ8eKs0Wzc7gAJd
 1ZSnoAMOqXSdLQ7fjIxTRjIwEomA7YhBThofQypnffV1qvcrBudKsbDsQhii6EZ9NJLESIhePvI
 CpG18NWjNPVBP1NtS7a3eYgRn61N0moeL/FxKpxO2ifp3ZkeLWnXt+gqWEnP9D8z9k8xWdrLtYZ
 KH+aS09jSxVHaD9wUJvfAoA7qQ/TBacnIjJYfa6ugxYJCZ43MhHtQfQK2KLB2S7om87RaYiT6rg
 pO84XpR8Gfvg3ukU1ZKdQ=
X-Google-Smtp-Source: AGHT+IFl3aCPLhARBAOzXnz43lwg+zp85mBUw/QQcIFFk9i36RBEUBY2w+Fa5wu6vZ6vO2WwfomyKA==
X-Received: by 2002:a05:6000:2f88:b0:42b:3ed2:c08b with SMTP id
 ffacd0b85a97d-42b4bdb674fmr2815717f8f.51.1762960722922; 
 Wed, 12 Nov 2025 07:18:42 -0800 (PST)
Received: from xavers-framework.fritz.box ([193.124.138.23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b32c1ad2bsm23255211f8f.6.2025.11.12.07.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 07:18:42 -0800 (PST)
From: Xaver Hugl <xaver.hugl@kde.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 harry.wentland@amd.com, Xaver Hugl <xaver.hugl@kde.org>
Subject: [PATCH 1/3] amdgpu_dm: also send FreeSync packets on DisplayPort
 connectors
Date: Wed, 12 Nov 2025 16:18:30 +0100
Message-ID: <20251112151832.77867-1-xaver.hugl@kde.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Nov 2025 08:36:11 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Afaict there's no reason why it wasn't done before, and this is required
for later FreeSync 2 HDR enablement.

Signed-off-by: Xaver Hugl <xaver.hugl@kde.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 163780030eb1..1660169ae5aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9048,7 +9048,10 @@ static void update_freesync_state_on_stream(
 
 	aconn = (struct amdgpu_dm_connector *)new_stream->dm_stream_context;
 
-	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST || aconn->vsdb_info.replay_mode)) {
+	if (aconn && (aconn->as_type == FREESYNC_TYPE_PCON_IN_WHITELIST ||
+		     (aconn->as_type == ADAPTIVE_SYNC_TYPE_DP &&
+			aconn->vsdb_info.amd_vsdb_version != 0) ||
+		      aconn->vsdb_info.replay_mode)) {
 		pack_sdp_v1_3 = aconn->pack_sdp_v1_3;
 
 		if (aconn->vsdb_info.amd_vsdb_version == 1)
@@ -9058,8 +9061,9 @@ static void update_freesync_state_on_stream(
 		else if (aconn->vsdb_info.amd_vsdb_version == 3)
 			packet_type = PACKET_TYPE_FS_V3;
 
-		mod_build_adaptive_sync_infopacket(new_stream, aconn->as_type, NULL,
-					&new_stream->adaptive_sync_infopacket);
+		if (aconn->as_type != ADAPTIVE_SYNC_TYPE_DP)
+			mod_build_adaptive_sync_infopacket(new_stream, aconn->as_type, NULL,
+							   &new_stream->adaptive_sync_infopacket);
 	}
 
 	mod_freesync_build_vrr_infopacket(
-- 
2.51.1

