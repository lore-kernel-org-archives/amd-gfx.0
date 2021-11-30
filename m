Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38461C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 16:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F6E89309;
	Tue, 30 Nov 2021 16:13:32 +0000 (UTC)
Received: from mta-p8.oit.umn.edu (mta-p8.oit.umn.edu [134.84.196.208])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F4096E2ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 11:28:23 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J3KTs1MWsz9vKY8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 11:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7pm37Pdc8d1f for <amd-gfx@lists.freedesktop.org>;
 Tue, 30 Nov 2021 05:18:41 -0600 (CST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J3KTr6Dd2z9vKY4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 05:18:40 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J3KTr6Dd2z9vKY4
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J3KTr6Dd2z9vKY4
Received: by mail-pg1-f199.google.com with SMTP id
 t1-20020a6564c1000000b002e7f31cf59fso10134590pgv.14
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fcDXlkwYy3RGfIkoC7nwMHwkoGJwFkeLToaTBjqpVz0=;
 b=IZFo2LaVF/UDFGHVpkS6dD5TA6dpvZiDSB/3rKX1VSVjqxWP/lhMO39QYI3NPLoRgq
 cRXSmh8e41mhZP6Z6pASFNZgCl2xPwfVgz6CBJ4rCuCZ5ixas3pK71sx3cvXjwkJTop+
 3T/yiRiF1QWYne/jINn7ouKO7OjCe6gsRwokRuSedKnx6jzsAq8pHSJdN03f8AET5TzU
 a3BC2bkGlVrwO6yuzbS4R4Uw0sjIcFhIuR8RmeSA1Od8jCr3Qr3cmM751Tht6hvFkmqk
 ZRyDmDTDs5KOn9FrJ5pzFxU474Na5c2560b3P8n5J2SDV8k/mizEVWFX2R0RVU+iUKxp
 O0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fcDXlkwYy3RGfIkoC7nwMHwkoGJwFkeLToaTBjqpVz0=;
 b=YT5IayLdoZoBTXqvCdB/M1ny0N4MtTnGqdmuW4ZsPaTA7LijeBgMeQtxfIVZhSri2z
 YMApAIugtYMtNNIoQLvSVfJJ/40YHD2mlF/PBsAXE7ckC9djdSiKmd5z9w99rr/lr9VT
 Ot8rJCq/kEQSd1OX/v5jq6OOlkAV/GIbMvrjwT351t/rZ7m0OJ+ygYBqn5xkr9sXhmKa
 ZOimiEiXC/jzxa7d4TB9sTvR39DKElX9om2NKJ7a1LbRRDFr6+M/AkMLTQSXlbunpO/r
 fPS8yNoKhPctvYYIhGhRucwkGMnelwPQHBXcFmkcWCTr28uKXXvzP6vWbfLDiB9C0rUN
 b9Jg==
X-Gm-Message-State: AOAM5328GT25h5cZPyIeuKmGJih7P6josBZ1FxGkxpL5J0R9oGubxoen
 2jZLVGCTiVsPaa8HyO29qtIfWIBtY5/U3NLgFTujMRuBY/t29vOyxv8Nuqi4pBlXpRkD0Q7HBuy
 INXiqfSUV9W0O8VjL+NZlXLwijboYcA==
X-Received: by 2002:a63:4815:: with SMTP id v21mr33476644pga.204.1638271120018; 
 Tue, 30 Nov 2021 03:18:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz86b37XtXDhaWTJbzxcPVwFldWszd3ZgCjYlChRIfA1Lxm91iK1IJ9p5k5TxfqRc7ZaUDHCg==
X-Received: by 2002:a63:4815:: with SMTP id v21mr33476628pga.204.1638271119786; 
 Tue, 30 Nov 2021 03:18:39 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
 by smtp.gmail.com with ESMTPSA id q18sm19100280pfn.83.2021.11.30.03.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 03:18:39 -0800 (PST)
From: Zhou Qingyang <zhou1615@umn.edu>
To: zhou1615@umn.edu
Subject: [PATCH] fix a NULL pointer dereference in
 amdgpu_connector_lcd_native_mode()
Date: Tue, 30 Nov 2021 19:18:30 +0800
Message-Id: <20211130111832.113821-1-zhou1615@umn.edu>
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
Cc: Jammy Zhou <Jammy.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kjlu@umn.edu, linux-kernel@vger.kernel.org, hongao <hongao@uniontech.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In amdgpu_connector_lcd_native_mode(), the return value of
drm_mode_duplicate() is assigned to mode, and there is a dereference
of it in amdgpu_connector_lcd_native_mode(), which will lead to a NULL
pointer dereference on failure of drm_mode_duplicate().

Fix this bug add a check of mode.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_AMDGPU=m show no new warnings, and
our static analyzer no longer warns about this code.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 0de66f59adb8..0170aa84c5e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -387,6 +387,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
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

