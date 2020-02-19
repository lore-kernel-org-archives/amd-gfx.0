Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD4C34051
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 13:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2C520801
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 13:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhH50M4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2C520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC026EBFA;
	Wed, 19 Feb 2020 13:50:53 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9953A6EBF8;
 Wed, 19 Feb 2020 13:50:52 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a5so739628wmb.0;
 Wed, 19 Feb 2020 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AolbXk2Fq1YBeMjbbUIDV5EfiVXR8mlZoIKExVmKJBk=;
 b=VhH50M4meNxnkB1EPYKHUpA1IM9ih8BDfO2AM94Wx2tcQM0illVMIgAUXsBkSdNiKV
 xXbruD5QQtFxs4fHEj5jRWO5IOq8DYKQEATgJDZpeP0QHo0yKEquEvRq4I1C9PttdkBg
 l5LljPhnCsVgZIZPmGir1xERNUgC92PXL8kS0O0efm4UZHL/2RJBe5E9b4s8kMpUkT13
 57bdWyTugNChFxEfYcbmeY+PoJh3m9elYnBdK4EjIefuJKF/PTJsdQUhebFRff5HSe8l
 3locYDa9GTCSa0t3dFqBnppe1HstAE5/b6wcMp0VD6L/b1bhkn+NcP8/0MlPSmCUzQIG
 TErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AolbXk2Fq1YBeMjbbUIDV5EfiVXR8mlZoIKExVmKJBk=;
 b=bNcJpSpRAZvMyRTyDSdC3vSnO0AfQk1nDq4XaTCNZd4eiS7Cj1g27GWI4v6Cn1qZzv
 XbFKt42EJZxrSbca4+V85z1Pn+IMBCXNewp7cTHpIDP9uoa4qbE4Lb7D9XHDh+PLeEaG
 ZakfkwKQcMWmakz3b7ptOCo3m+H5gzABZ6jix9nZeYr92GlqhNu4cl+qt9Zwi2JMdJAi
 Jd8qCvwDqCfamSb9hkj7ryKx24J+rYbR9hWtMktHPwrAPn/a9SXVbTUtMBGumjty0frH
 z+uE/NuEDrwAeTtHVa+tOHjVKMUr9c+7mQp1SPGynrf0NkU15fnbYjafyZtVOTmzsRfy
 /kmQ==
X-Gm-Message-State: APjAAAV7+u4btvA4lejhDI7pAxdQ7PH8YT+28dZJuTiiPMYzw4jed6UZ
 80lFxDeMxrr6v3YXUfG456qtJuLYwGUQRA==
X-Google-Smtp-Source: APXvYqxH2Xap7PnOtG3CBUOE+VMnOjDBlPdPBYuTKs2p0y6Gqu6uGyG96jtLtIjZQWqf6787jsSpyg==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr10651308wmf.55.1582120250856; 
 Wed, 19 Feb 2020 05:50:50 -0800 (PST)
Received: from brihaspati.fritz.box (p5DE53754.dip0.t-ipconnect.de.
 [93.229.55.84])
 by smtp.gmail.com with ESMTPSA id y1sm3061881wrq.16.2020.02.19.05.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 05:50:50 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 6/8] drm/vram-helper: don't use ttm bo->offset v2
Date: Wed, 19 Feb 2020 14:53:20 +0100
Message-Id: <20200219135322.56463-7-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219135322.56463-1-nirmoy.das@amd.com>
References: <20200219135322.56463-1-nirmoy.das@amd.com>
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

Calculate GEM VRAM bo's offset within vram-helper without depending on
bo->offset

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 92a11bb42365..3edf5f241c15 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -198,6 +198,21 @@ u64 drm_gem_vram_mmap_offset(struct drm_gem_vram_object *gbo)
 }
 EXPORT_SYMBOL(drm_gem_vram_mmap_offset);

+/**
+ * drm_gem_vram_pg_offset() - Returns a GEM VRAM object's page offset
+ * @gbo:	the GEM VRAM object
+ *
+ * Returns:
+ * The buffer object's page offset, or
+ * 0 with a warning when memory manager node of the buffer object is NULL
+ * */
+static s64 drm_gem_vram_pg_offset(struct drm_gem_vram_object *gbo)
+{
+	if (WARN_ON_ONCE(!gbo->bo.mem.mm_node))
+		return 0;
+	return gbo->bo.mem.start;
+}
+
 /**
  * drm_gem_vram_offset() - \
 	Returns a GEM VRAM object's offset in video memory
@@ -214,7 +229,7 @@ s64 drm_gem_vram_offset(struct drm_gem_vram_object *gbo)
 {
 	if (WARN_ON_ONCE(!gbo->pin_count))
 		return (s64)-ENODEV;
-	return gbo->bo.offset;
+	return drm_gem_vram_pg_offset(gbo) << PAGE_SHIFT;
 }
 EXPORT_SYMBOL(drm_gem_vram_offset);

--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
