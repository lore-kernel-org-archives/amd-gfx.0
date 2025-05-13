Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930D5C3ABDA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 07:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A07010E269;
	Wed, 14 May 2025 07:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gvernon.com header.i=@gvernon.com header.b="mLR97Mkw";
	dkim-atps=neutral
X-Greylist: delayed 406 seconds by postgrey-1.36 at gabe;
 Tue, 13 May 2025 23:39:47 UTC
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [95.215.58.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341A610E21E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 23:39:46 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
 t=1747179170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iYcQQzN6vnaXT766TJ+cVQWw0N0NG5qRoAhx0ZwZjFY=;
 b=mLR97Mkwj5zSlLnN/mlvCwd7qeWtalgeS4/J/A3+Sxl+eLFdZrt+OTWS3CmKuJjDYISsCn
 2CL4jzCj1ldnYYSHqC+CHKCNvTsxb1S6W7+LTxxKwS5he0SzrwnhUBKD18BmcvdHFqwhyj
 51A6kJmYvqs+h0K6o03t7qf6hxmc1nCewHEkJbFBhN6qDIhmo7mVZmwQUSzpG7sQoIWbU2
 pLJQQqVEvRCAoBTji9ZwD/lOc0M7I+ziOPOxUvcvFGuBBc/ST6JucGO7owcaL5cppkvln+
 GRjhf0rvCs/mlcWCBU5hBpZWsDwIfJm7ca2CVrxM3Rb4lFwF8Bcfx6y1GTa8BA==
From: George Anthony Vernon <contact@gvernon.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	skhan@linuxfoundation.org
Cc: George Anthony Vernon <contact@gvernon.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/amdgpu: Fix docs build warning
Date: Wed, 14 May 2025 00:31:55 +0100
Message-ID: <20250513233212.21186-1-contact@gvernon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 14 May 2025 07:31:11 +0000
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

The kerneldoc comment for HGCP locality check debug mask was missing a
semicolon resulting in a documentation build warning. Correct it.

Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 4c95b885d1d0..c8eccee9b023 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -366,7 +366,7 @@ enum DC_DEBUG_MASK {
 	DC_HDCP_LC_FORCE_FW_ENABLE = 0x80000,
 
 	/**
-	 * @DC_HDCP_LC_ENABLE_SW_FALLBACK If set, upon HDCP Locality Check FW
+	 * @DC_HDCP_LC_ENABLE_SW_FALLBACK: If set, upon HDCP Locality Check FW
 	 * path failure, retry using legacy SW path.
 	 */
 	DC_HDCP_LC_ENABLE_SW_FALLBACK = 0x100000,
-- 
2.49.0

