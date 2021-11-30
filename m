Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8278CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 16:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3762E6E49C;
	Tue, 30 Nov 2021 16:13:28 +0000 (UTC)
Received: from mta-p7.oit.umn.edu (mta-p7.oit.umn.edu [134.84.196.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92536E2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 14:49:06 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4J3Q8f32Lmz9vffL
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 14:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v6eg0XnPLpgE for <amd-gfx@lists.freedesktop.org>;
 Tue, 30 Nov 2021 08:49:06 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4J3Q8f0zH6z9vffB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 08:49:06 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4J3Q8f0zH6z9vffB
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4J3Q8f0zH6z9vffB
Received: by mail-pj1-f71.google.com with SMTP id
 h15-20020a17090a648f00b001a96c2c97abso6894957pjj.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 06:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SKUA5rulho7/zo1ULnuDGtU3hFtIpEJdfFzpP4bqLSk=;
 b=GeK2kPOS68r652pwNSRxEaAW/b/2tt84HoSKWLnqyqPdVPl4ucwQ+mMlReYNSho7SF
 +sha56JoOg34qC7EaQh4IyuQQZ4oaOtBdBjrxjJ+f8pithTUf3Zr/gb0ZdFOqnIUAoJU
 RVYhqDa4M1u5Zkp/QQdNSReB7yO4zl01to//Z6JN4rwmCYKGEdP1uKGMEtPODj20OqLq
 YgpO3ENCThW3nGWNthqOb91bDF5PjI/JfYtJcuqsIwHc6edcrwISgV4lZwZwJ6J/VoYt
 D9aIjinT/QRXiDFiztTJLOPjnSt+gDhu2+6Kds5nC+/R6X55CMCBR3NOlh1pf3fm0/B4
 qzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SKUA5rulho7/zo1ULnuDGtU3hFtIpEJdfFzpP4bqLSk=;
 b=WWPms7u2AQVioS3pcLrnHrdadVu3ENtA72l/NKhXGz0FdL440Ay2tM1Qp49p+XZxDA
 AC77MEyln12BM0BKdAXjTFxu69wVc2zUOsKTOCnnCh0XziMRuqwy7PU4Sm7dmKwRBedB
 rGstQTkUrg58rULDedN8NMtCAQE0rEeIi+7jfMnHA6gtdYFaBTvCwqKcbHpoQscy2NTU
 IwHyeCoGpx+nrFOWAT5MyFVLt21yLtSTbO9bjQ22wvoscQjENjbL2HbJiO2q+y6429yV
 vPPWOrOgXIZ0LCNboYoZZWO7quA2r6ax4UNNcLokS2CTz/ufGLcI13uZ1dMKH2RJfrgT
 tJSA==
X-Gm-Message-State: AOAM532ap9+jTlYf/Q9+M1TlUDPEU2Wtphd/QUqD3gIFtHma2abVTehm
 dC20y+cD8Woir8q3XAYsdjhomeZnNi4c+VO+Xo+eDLiDNO9t+ci1uvVx/DQ6zQqgYenaYpVFQpv
 MnOgr2lJQ/qGGn1E3N9vMd7bPxMCLww==
X-Received: by 2002:a17:90b:4f86:: with SMTP id
 qe6mr6665848pjb.198.1638283745304; 
 Tue, 30 Nov 2021 06:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg5tqfIsb7cPPfYTW5uP2EKJprEpWzmVo1SJk8rR74gWfThL7r7GfAmz1doU8srd5YKcoi1Q==
X-Received: by 2002:a17:90b:4f86:: with SMTP id
 qe6mr6665827pjb.198.1638283745110; 
 Tue, 30 Nov 2021 06:49:05 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
 by smtp.gmail.com with ESMTPSA id s5sm14762936pgq.62.2021.11.30.06.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 06:49:04 -0800 (PST)
From: Zhou Qingyang <zhou1615@umn.edu>
To: zhou1615@umn.edu
Subject: [PATCH] drm/radeon/radeon_connectors: Fix a NULL pointer dereference
 in radeon_fp_native_mode()
Date: Tue, 30 Nov 2021 22:48:27 +0800
Message-Id: <20211130144827.163717-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Nov 2021 16:13:26 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kjlu@umn.edu, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In radeon_fp_native_mode(), the return value of drm_mode_duplicate() is
assigned to mode and there is a dereference of it in
radeon_fp_native_mode(), which could lead to a NULL pointer
dereference on failure of drm_mode_duplicate().

Fix this bug by adding a check of mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_RADEON=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: d2efdf6d6f42 ("drm/radeon/kms: add cvt mode if we only have lvds w/h and no edid (v4)")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 607ad5620bd9..49f187614f96 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -473,6 +473,9 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
 	    native_mode->vdisplay != 0 &&
 	    native_mode->clock != 0) {
 		mode = drm_mode_duplicate(dev, native_mode);
+		if (!mode)
+			return NULL;
+
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		drm_mode_set_name(mode);
 
-- 
2.25.1

