Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07722C761A2
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 10:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBBE20679
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 10:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbwZP9Hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBBE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C48C6E90E;
	Mon, 17 Feb 2020 10:16:09 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92B06E90E;
 Mon, 17 Feb 2020 10:16:08 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a6so17788435wme.2;
 Mon, 17 Feb 2020 02:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R6kTYyV4yeootxcCO0Pc4b5JT430LY5TerttUMYIqdU=;
 b=TbwZP9HxK71gVHf3IOh0a/1JQLrpVCcLEpYTRNNUuN/kajFy5BKeCijudxJD/Th52V
 aiMN36m3DHtathw2KIU5bKawyDU3MqcydDKeMGWNs2zzMWDo6M9Z9M1QdYO7idb4UBu3
 9dQrbgXqJ29i5UmyiPdFwEyp8GgF3al77UjHPNnb53uoSoUjXGJNzgcwbP1ZnarOfG0g
 OHkkaqLMn7VPl1K3Eh59ps4Rkb6XNeN0NZNQVdf8BkB2MCMNMT1/SYBHaR3+gplxdMc5
 f1eqw5J3IIbzNZHNfJdnFtXd5b+niL3BpycIZD7Gu7TWKtE5PdarTU++B3R5CVcoWetQ
 qBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R6kTYyV4yeootxcCO0Pc4b5JT430LY5TerttUMYIqdU=;
 b=pPwXNDe3nzEVVDSqCPt4oTMFt8cYOtG0C0NtyFpfhPB0FaNNZw2+fsHUdvtPlEU+cN
 W7k0LnCg6t9UgGoLXhQ9P/LTW3LAFUb8qDJBQI51kZjWl7n5ztupa91YMkyrI1KnTzHy
 xEZsOPEw8avrtQagZ9Q7WjmDyb05rh9Puyiqo7egPM71X5NJi83JfgUNcRcWomXuZR75
 8SXxK/wC/kmSLmJzTlsSKbWhAp1IexGVtk8NqNXf+zAgcoHVvY8S8CnJScSOYVHNIKcp
 atw4VkZggtMi6pxbNuWF0ppaf3sEvNf6y/G7HGidvr9Fs/HG4jbIrZvpcyTQK3Ea5N9I
 WoUg==
X-Gm-Message-State: APjAAAWsjLmVjO9kq2nVvv+XPrcYg4j0WiRDoKACKmzbRxbjN4R8tcXZ
 MFcuWJx1xSVtjtbdpyAJW7ambZELWfZQmg==
X-Google-Smtp-Source: APXvYqyTbxyLPSzZ7hpJC3vu1S48YFo1V4ueNy2uWRuPYiKTaExIGsmfPW2v7UU6WGDE7Ufo1TF9ZQ==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr21050154wmk.29.1581934567017; 
 Mon, 17 Feb 2020 02:16:07 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F261400BC111EAD619EC67C.dip0.t-ipconnect.de.
 [2003:c5:8f26:1400:bc11:1ead:619e:c67c])
 by smtp.gmail.com with ESMTPSA id a16sm278487wrt.30.2020.02.17.02.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 02:16:06 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 6/7] drm/bochs: don't use ttm bo->offset
Date: Mon, 17 Feb 2020 11:18:40 +0100
Message-Id: <20200217101841.7437-7-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217101841.7437-1-nirmoy.das@amd.com>
References: <20200217101841.7437-1-nirmoy.das@amd.com>
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, airlied@linux.ie,
 kenny.ho@amd.com, brian.welty@intel.com, maarten.lankhorst@linux.intel.com,
 amd-gfx@lists.freedesktop.org, nirmoy.das@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sean@poorly.run, christian.koenig@amd.com,
 kraxel@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Calculate GPU offset within bochs driver itself without depending on
bo->offset

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c     | 3 ++-
 drivers/gpu/drm/drm_gem_vram_helper.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 8066d7d370d5..852ec7910d84 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -38,7 +38,8 @@ static void bochs_plane_update(struct bochs_device *bochs,
 			 state->crtc_x,
 			 state->crtc_y,
 			 state->fb->pitches[0],
-			 state->fb->offsets[0] + gbo->bo.offset);
+			 state->fb->offsets[0] +
+			 (gbo->bo.mem.start << PAGE_SHIFT));
 	bochs_hw_setformat(bochs, state->fb->format);
 }
 
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 92a11bb42365..e7ef4cd8116d 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -214,7 +214,7 @@ s64 drm_gem_vram_offset(struct drm_gem_vram_object *gbo)
 {
 	if (WARN_ON_ONCE(!gbo->pin_count))
 		return (s64)-ENODEV;
-	return gbo->bo.offset;
+	return gbo->bo.mem.start << PAGE_SHIFT;
 }
 EXPORT_SYMBOL(drm_gem_vram_offset);
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
