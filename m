Return-Path: <SRS0=WIfX=EV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C82C2D0E4
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Nov 2020 09:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB39222450
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Nov 2020 09:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB39222450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BDB6E995;
	Sun, 15 Nov 2020 09:39:52 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448A26E995
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Nov 2020 09:39:51 +0000 (UTC)
Date: Sun, 15 Nov 2020 09:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1605433188;
 bh=xrubJ7Cjo24zJmxh/QBdfGo4FGIbvY6c4jf8U+IuwrA=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=DgVpZUSR+CBkQojhjQD4I6HDVvHyOFO9G1UwHnZN+e5orFUCQpB8Gm96UhFP0hwPj
 cjBPHRzv2hWwSQZPOtMvU1AlDlKllegij3ZWkWf12YjopcyAmJOlqzokKI//o8B4ZD
 /GlWXOG92gvnfA3/Hir7mfAi8pGyzJ3vsBLkLJfeUM+JpI8ivH4crPQt4w+UCPo7M8
 Cen9NAybsVGUP+a4ytBcSiQ4pCnpjSdmgktQbCR7O5zKEOk6BQQEodAiDsbcF3xZat
 neea7z4UAKPphl7F/iJFPXlQTS0/cLqAuTyDGdJwNM6u4o+nhLFZM56ZZwxpiYrxyW
 XOXaTnn9qClmA==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/fourcc: fix AMD modifiers PACKERS field doc
Message-ID: <6NXsveJa7IUiRftZcOguXi1dj0UifPcrDRtR1oOgrU@cp3-web-009.plabs.ch>
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

This field doesn't alias with BANK_XOR_BITS: PACKERS is bits 26:28 while
BANK_XOR_BITS is bits 23:25.

Fixes: 8ba16d599374 ("drm/fourcc: Add AMD DRM modifiers.")
Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/uapi/drm/drm_fourcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index ca48ed0e6bc1..29c7a8694479 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1196,7 +1196,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_PIPE_XOR_BITS_MASK 0x7
 #define AMD_FMT_MOD_BANK_XOR_BITS_SHIFT 23
 #define AMD_FMT_MOD_BANK_XOR_BITS_MASK 0x7
-#define AMD_FMT_MOD_PACKERS_SHIFT 26 /* aliases with BANK_XOR_BITS */
+#define AMD_FMT_MOD_PACKERS_SHIFT 26
 #define AMD_FMT_MOD_PACKERS_MASK 0x7
 #define AMD_FMT_MOD_RB_SHIFT 29
 #define AMD_FMT_MOD_RB_MASK 0x7
-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
