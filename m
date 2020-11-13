Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08502C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35D220A8B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35D220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B056E59B;
	Fri, 13 Nov 2020 17:21:44 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490E26E5A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 17:21:43 +0000 (UTC)
Date: Fri, 13 Nov 2020 17:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1605288100;
 bh=D60csVvyZkJMwUAF2Xl2ltkvMiW0+tALBjS2O0sVEqA=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=VI9SmC8dplLBuKXo9E3i50An0di5CDiBPc1IKtZy0A9hW0FXK1v+cVUoHFX6Zce9E
 o41fX9OyCGiM3TtXbUy2udhYrjJ+EKqwRz7PDKnGg4HnXiERoBpceshKftSLhc0TTG
 9pNKlb7PU5NPO9dUXdpqF+hUK5wm7XDsElYjTo6f7N34l7kAqO0fbRN2D1txA1iiuf
 BiWvbiQVhlt89zRcab2+Q/1bNgemzUDwk5uORZt6nIS1FtnPMJuVJYUNtiDbuHLKYb
 vNbIorY+0RZoTG/Ubz0tnckIUM3Y51ke1IHEdSUriQjG5WXvTc14gr5jKWS1wx8V3T
 ktao3+b8GeyIA==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/fourcc: add table describing AMD modifiers bit layout
Message-ID: <0gLrKmUEE4VjN5rdf6dUiejliU1GhjCBvH7RFMQYY@cp7-web-044.plabs.ch>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The table describes how each bit in the u64 value is used. Explicitly
state which values a field can take if we have defines for them. Also
add a note when a field isn't always populated.

Forcing people to update the table when changing the bit layout should
make it more obvious when there's a mistake, I hope.

If we get to the point where the bit layout gets more complicated, it
might be worth it to split the table into multiple tables (e.g. one for
GFX8, one for GFX9+, and so on).

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---

This already contains the fix in [1].

[1]: https://lists.freedesktop.org/archives/amd-gfx/2020-November/056073.html

 include/uapi/drm/drm_fourcc.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index ca48ed0e6bc1..253386b7bc6a 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1114,6 +1114,25 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
  *
  * For multi-plane formats the above surfaces get merged into one plane for
  * each format plane, based on the required alignment only.
+ *
+ * Bits  Parameter                Notes
+ * ----- ------------------------ ---------------------------------------------
+ *
+ *   7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
+ *  12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
+ *    13 DCC
+ *    14 DCC_RETILE
+ *    15 DCC_PIPE_ALIGN
+ *    16 DCC_INDEPENDENT_64B
+ *    17 DCC_INDEPENDENT_128B
+ * 19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
+ *    20 DCC_CONSTANT_ENCODE
+ * 23:21 PIPE_XOR_BITS            Only for some chips
+ * 26:24 BANK_XOR_BITS            Only for some chips
+ * 29:27 PACKERS                  Only for some chips
+ * 32:30 RB                       Only for some chips
+ * 35:33 PIPE                     Only for some chips
+ * 55:36 -                        Reserved for future use, must be zero
  */
 #define AMD_FMT_MOD fourcc_mod_code(AMD, 0)
 
-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
