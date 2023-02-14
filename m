Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD2FC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 06:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9205910E7ED;
	Tue, 14 Feb 2023 06:56:29 +0000 (UTC)
X-Greylist: delayed 398 seconds by postgrey-1.36 at gabe;
 Tue, 14 Feb 2023 06:56:26 UTC
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4349E10E7ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 06:56:26 +0000 (UTC)
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
 by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id 9c0f2726
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 14 Feb 2023 17:49:44 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
 by largo.jsg.id.au (OpenSMTPD) with ESMTP id f54c8467;
 Tue, 14 Feb 2023 17:49:44 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: avoid unaligned access warnings
Date: Tue, 14 Feb 2023 17:49:44 +1100
Message-Id: <20230214064944.54993-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When building on OpenBSD/arm64 with clang 15, unaligned access
warnings are seen when a union is embedded inside a packed struct.

drm/amd/display/dmub/inc/dmub_cmd.h:941:18: error: field
  cursor_copy_src within 'struct dmub_rb_cmd_mall' is less aligned than
  'union dmub_addr' and is usually due to 'struct dmub_rb_cmd_mall'
  being packed, which can lead to unaligned accesses
  [-Werror,-Wunaligned-access]
        union dmub_addr cursor_copy_src; /**< Cursor copy address */
                        ^
drm/amd/display/dmub/inc/dmub_cmd.h:942:18: error: field cursor_copy_dst
  within 'struct dmub_rb_cmd_mall' is less aligned than
  'union dmub_addr' and is usually due to 'struct dmub_rb_cmd_mall'
  being packed, which can lead to unaligned accesses
  [-Werror,-Wunaligned-access]
        union dmub_addr cursor_copy_dst; /**< Cursor copy destination */
                        ^

Add pragma pack around dmub_addr to avoid this.

Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 33907feefebb..dc92d06572a3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -162,6 +162,7 @@ extern "C" {
 #define dmub_udelay(microseconds) udelay(microseconds)
 #endif
 
+#pragma pack(push, 1)
 /**
  * union dmub_addr - DMUB physical/virtual 64-bit address.
  */
@@ -172,6 +173,7 @@ union dmub_addr {
 	} u; /*<< Low/high bit access */
 	uint64_t quad_part; /*<< 64 bit address */
 };
+#pragma pack(pop)
 
 /**
  * Dirty rect definition.
-- 
2.39.1

