Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5510C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 13:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7646020784
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 13:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3KH12kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7646020784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F7B6E835;
	Tue, 31 Mar 2020 13:54:46 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773666E835
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 13:54:45 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id u10so26064274wro.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=msZlMVNwu3Vf1OhEs8VCCBQWNU8m5YCGUjOsccsxSTI=;
 b=j3KH12knXLY3az3wiGmFEtebzUKuBkNumaStVpEEHyGXTXCiYzLjy+lt3AFsvhQNsC
 JT7RLKWxKJDRR5EEVkRHTSCwFqwwvYehCT0RbqKxEoR2ZN+pOP+VuRibBNOkdTNH2W0F
 NigASGXpOxv7bRUM1uZTQVdtexiHrAnFbCat/YxCmrgS92G4ydrNxiiSsHaTTuKtbSq8
 c71OGz649jEo/ZxGp/5hOHjdzreoT0rqqkV/6P/gcf6zXqubXpux2JA0w53Co424U53i
 aVIySjTtPjzZnmSmRVWH6uxjU1PT7uVDxiRuWWwvOPc63mwfo3dunjydRcIKtevFv1Zj
 41JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=msZlMVNwu3Vf1OhEs8VCCBQWNU8m5YCGUjOsccsxSTI=;
 b=hEsynmDHkaPfNz2s4sDVElfW//zr6c04qDIZDoy+zJ7MCsI3ez8z0eC7Zrz71rSRuP
 dTdphbvIXvqVfOKo+fA8JlgUlxj9BFuMX/3RkuQp/XeVCeLcJteBvRpg/vHNRivxYTEJ
 qUdAUQ3Sw6xX62d1vOkNX/HgcbtLsMBzG5iYDo7lqlUmmPmfSfgtJC+9tcA6JwIEzyA+
 ME4iZBTxMRgUt1eBfs5EesG+OSlBzE87yxxwMMAG8v653XQSHBEfYdkySw1m63GvdgWc
 MVdY0cZaPW4D2nVI7fpMGKrKzfYSY+1GVhudxMvrja0MoxXQ+d6RlEm/D0bxqreI1qtm
 vwxw==
X-Gm-Message-State: ANhLgQ2kVyDekbC6UyfZ4/cLQKZ3GPSxlusLgqjT+E0aP7mkHveT4vwd
 O2nUSbD6FkNoRJ2Zc7jwSMitieFy
X-Google-Smtp-Source: ADFU+vtBTFkRolAJY3+pU6VgJ4JEju4pd4zqcJlylWRUxwxnIyysPebgEnGlG+8yeQAi93NbuZecuw==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr20863402wrn.106.1585662883585; 
 Tue, 31 Mar 2020 06:54:43 -0700 (PDT)
Received: from brihaspati.fritz.box
 (p200300C58F2E74000298C664B0CADE76.dip0.t-ipconnect.de.
 [2003:c5:8f2e:7400:298:c664:b0ca:de76])
 by smtp.gmail.com with ESMTPSA id p10sm27415546wrm.6.2020.03.31.06.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 06:54:42 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: sync ring type and drm hw_ip type
Date: Tue, 31 Mar 2020 15:59:04 +0200
Message-Id: <20200331135905.13045-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use AMDGPU_HW_IP_* to set amdgpu_ring_type enum values

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 080024d21d3e..50abc63f7cc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -47,16 +47,16 @@
 #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)

 enum amdgpu_ring_type {
-	AMDGPU_RING_TYPE_GFX,
-	AMDGPU_RING_TYPE_COMPUTE,
-	AMDGPU_RING_TYPE_SDMA,
-	AMDGPU_RING_TYPE_UVD,
-	AMDGPU_RING_TYPE_VCE,
-	AMDGPU_RING_TYPE_KIQ,
-	AMDGPU_RING_TYPE_UVD_ENC,
-	AMDGPU_RING_TYPE_VCN_DEC,
-	AMDGPU_RING_TYPE_VCN_ENC,
-	AMDGPU_RING_TYPE_VCN_JPEG
+	AMDGPU_RING_TYPE_GFX		= AMDGPU_HW_IP_GFX,
+	AMDGPU_RING_TYPE_COMPUTE	= AMDGPU_HW_IP_COMPUTE,
+	AMDGPU_RING_TYPE_SDMA		= AMDGPU_HW_IP_DMA,
+	AMDGPU_RING_TYPE_UVD		= AMDGPU_HW_IP_UVD,
+	AMDGPU_RING_TYPE_VCE		= AMDGPU_HW_IP_VCE,
+	AMDGPU_RING_TYPE_UVD_ENC	= AMDGPU_HW_IP_UVD_ENC,
+	AMDGPU_RING_TYPE_VCN_DEC	= AMDGPU_HW_IP_VCN_DEC,
+	AMDGPU_RING_TYPE_VCN_ENC	= AMDGPU_HW_IP_VCN_ENC,
+	AMDGPU_RING_TYPE_VCN_JPEG	= AMDGPU_HW_IP_VCN_JPEG,
+	AMDGPU_RING_TYPE_KIQ
 };

 struct amdgpu_device;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
