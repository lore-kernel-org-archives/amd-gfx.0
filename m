Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA3DC33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 19:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F9F20731
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 19:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4vj7h/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F9F20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BE96E50B;
	Mon,  6 Jan 2020 19:58:54 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF9C6E50B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 19:58:52 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id d71so32727879qkc.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 11:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e8QyaimXeLX19OB83F/EPAxSKyHVEEjTJH2w4xzP/44=;
 b=m4vj7h/GseCTL6+8c8I/MOhh2jYecbr8HKqS7AULv1GglW4usZQQ3lW6jVQbMLEJl0
 gtfaWgDRrW3KDtowGAwMZE+qv8hAi047EmViWv+lL1v2r/L9Psik0YcSmt9aIVFrBJsI
 jKNVpfitsk6ze9KFj9ZdIUFyVJ7E0xKvfzPOtadAkKhWrvj47iEJCt3EirHxu0RReLXM
 szEFNSpQnMmo45wuSwA3GfEWVxDdoTfkMmUZuoPwfSZtoYZNrh5oS3LASkEq9dRiDWpA
 9xt6s3K4I1w9HwUd6LUEz2L4z3HaFc6YaNDoCt8zJ3t3qpBPBmzpy/D21P8zCKzrab1g
 YQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e8QyaimXeLX19OB83F/EPAxSKyHVEEjTJH2w4xzP/44=;
 b=pf1TKKGqFZSix0jYv0AmxUvwl7udI9Rrul4HA9Gvc8E5w3yympk2gY6ykr1Hnbw+dN
 0wOBFFqmSCiY8OpzHlHoSgvqQ1EKddgkmAnX7hZcqiUEzUIJ5VlHQ4GTNdgwA9ypOz/N
 vsbguoEiDr0AswUa3VWtKmKI744h8wPQHl2T23BLHGxYFOMf2MCycEm+kxquicsJmfkV
 cjvgv858cjfLXovFCfyr4yJlVDrV0/AdGIV0tqy9eRnjRGOdJuaKECV4Wo8LOl7A0iIu
 fwzclyBY00MzZtak1N6SOi5b4HSPJ8TVCN+VAnGCJ7jk6pTtYPv9dB76ONiIc7b4KP0C
 BT9Q==
X-Gm-Message-State: APjAAAX+S30k+eNR4djVX4K8B9lTd8TvqyNyqT+T0cKox97Ru2z7muW4
 tq/g8vQRCiJG9h6I30B0Em8CNf06
X-Google-Smtp-Source: APXvYqyEIrIXN+drkV1OfwJ/6UuWWQesKbkbvGPykSYA2Nlk75gK+CtoQ9J5qTISc8RGT/ybfNHqsQ==
X-Received: by 2002:ae9:f106:: with SMTP id k6mr86975090qkg.189.1578340731550; 
 Mon, 06 Jan 2020 11:58:51 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id d25sm21082134qka.39.2020.01.06.11.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 11:58:51 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx: simplify old firmware warning
Date: Mon,  6 Jan 2020 14:58:42 -0500
Message-Id: <20200106195842.716709-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Put it on one line to avoid whitespace issues when
printing in the log.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5b05334a2548..379e46c1b7f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -577,8 +577,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	}
 
 	if (adev->gfx.cp_fw_write_wait == false)
-		DRM_WARN_ONCE("Warning: check cp_fw_version and update it to realize \
-			      GRBM requires 1-cycle delay in cp firmware\n");
+		DRM_WARN_ONCE("CP firmware version too old, please update!");
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 35384f543664..1cae356b1ae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -988,8 +988,7 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 	    (adev->gfx.mec_feature_version < 46) ||
 	    (adev->gfx.pfp_fw_version < 0x000000b7) ||
 	    (adev->gfx.pfp_feature_version < 46))
-		DRM_WARN_ONCE("Warning: check cp_fw_version and update it to realize \
-			      GRBM requires 1-cycle delay in cp firmware\n");
+		DRM_WARN_ONCE("CP firmware version too old, please update!");
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
