Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF07C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 07:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2EB10E1EE;
	Mon, 17 Jul 2023 07:21:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B3210E0CC;
 Sun, 16 Jul 2023 00:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=vCDJzaPXRVCO/UvhiEs9IHkx1kgQ8KEzMrH/C6KGEU0=; b=b7ClRTC6xGPUfPjg3DfYY1xxDk
 J3IwUzmdemoCyRwI1hiw/UFxBG9Nc9tqI1e9ahGdgGni3OdqfAzU9D4rBjo2f8a14GXaWFTL8AKC6
 g3XXKCTByv78lQYd7LRpHmjSHdcZGBGa+7YYhXofQUKQnxBjv7vhd5ruCbnV1wghR5/jU07soME/F
 bCfM2LI+RaQxuigE+wISZEqQ/cu3zBOpOexyddGJldJndOS7P27AFORezLol2tj7RFy6Fw5sOvvZz
 bUMDZLVEqz2oe0IS5BCGSt6NRku+WjGsNbyj9wWo9dMgm/hfCZBrKB93jcPgX27lj5OeMa7nEnBYe
 tWxamYXg==;
Received: from 50-198-160-193-static.hfc.comcastbusiness.net ([50.198.160.193]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qKptx-009lWB-2x; Sun, 16 Jul 2023 00:46:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drm/connector: mark enum counter value as private
Date: Sat, 15 Jul 2023 17:46:16 -0700
Message-ID: <20230716004616.21838-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Jul 2023 07:21:12 +0000
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
Cc: amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Randy Dunlap <rdunlap@infradead.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mark the DRM_MODE_COLORIMETRY_COUNT enum value as private in
kernel-doc to prevent a build warning:

include/drm/drm_connector.h:527: warning: Enum value 'DRM_MODE_COLORIMETRY_COUNT' not described in enum 'drm_colorspace'

Fixes: c627087cb164 ("drm/connector: Use common colorspace_names array")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 include/drm/drm_connector.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20230714.orig/include/drm/drm_connector.h
+++ linux-next-20230714/include/drm/drm_connector.h
@@ -522,7 +522,7 @@ enum drm_colorspace {
 	DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED	= 13,
 	DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT	= 14,
 	DRM_MODE_COLORIMETRY_BT601_YCC		= 15,
-	/* not a valid value; merely used for counting */
+	/* private: not a valid value; merely used for counting */
 	DRM_MODE_COLORIMETRY_COUNT
 };
 
