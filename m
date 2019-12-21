Return-Path: <SRS0=QHOg=2L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30171C43603
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Dec 2019 00:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B0B20866
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Dec 2019 00:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erwtn5fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B0B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A6D6ECD2;
	Sat, 21 Dec 2019 00:11:54 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC666ECD2
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Dec 2019 00:11:52 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id h126so4558188ywc.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 16:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BuVviVuB3oLRuKqAu7VR/YAFZjogWeOt+1yDj21j43o=;
 b=erwtn5fcrX8dVtxYEb3MeI69BdScjXhWEkHSEBoyioxaypIrMwmEI0Hw1uAxLbSOoC
 iCW6u8HJa8t4djLLLJ1bmIB+uKelX3aEPJAmCRjtlAUHXE3WBkJWSPttcZ+fdmm+bf3F
 yc0K8U4hBl8O2pMacpbzA/yNNz9m4rrwjCbGLJTMMJmVwcv+gPJ6+1KnBmU6jHPY3QLZ
 7EraFFzH5WkCUqZe0u8AqLohOOKmDncwtOktI5Blx7rn5FlEQd38ouzrvFxJfzMfgxaZ
 5hlHuXZ7QYB3zww1zhsTee4YpppJDIet3NogBXbL+LteuM//br/vs3SHQh+l7l/zGhvd
 kdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BuVviVuB3oLRuKqAu7VR/YAFZjogWeOt+1yDj21j43o=;
 b=FWKykXKuZNw20V29yf32mD6s9cNf+CHjk+DnUrYVccZx5dKdMdz/IQ3qfcyNmRk7q6
 UEN2+L++zhBZDmXz+wVuaKEO6JDXsFQD8Tne+ai+AhfTpDev1EQ7PEICVALVNAYz4EQ5
 V12Fu54xYjOAizF+94wRnvRmTsVqtRqauL5o1lEgSTtnlv/sm2em5WgyODaBb0Jz9oIc
 EVS48v2e+wCmBwKmzxd8DrB5AxE7dYOknTvCNbDdxavM6vatLanC61qYp2pGWv5Ida8R
 pmCqquAqjjrKP6rZp04RLGIX3YufTtJ/hSeD/C5i0REElx4dI5fDcSbRMt/ROzsV097H
 NlYA==
X-Gm-Message-State: APjAAAUxxxMuJqHh/FzASJG0CEhHDV+W6y4OEIKDugNtl5NE1UGzW5I8
 lFPXKWpR6cBLnobcHQWt9Q03OEhv
X-Google-Smtp-Source: APXvYqwCzz4rvJndwRHqZgoNBkfiTHR9/d1Gt92X3l1dfDRGFkei02R/BPmN7ouZbtY1/bsMRDPsAg==
X-Received: by 2002:a81:db50:: with SMTP id b16mr13763261ywn.28.1576887111879; 
 Fri, 20 Dec 2019 16:11:51 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q124sm4519239ywb.93.2019.12.20.16.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 16:11:51 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: simplify ATPX detection"
Date: Fri, 20 Dec 2019 19:11:42 -0500
Message-Id: <20191221001142.1338192-1-alexander.deucher@amd.com>
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

This reverts commit f5fda6d89afe6e9cedaa1c3303903c905262f6e8.

You can't use BASE_CLASS in pci_get_class.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/995
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index a97fb759e2f4..3e35a8f2c5e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -613,7 +613,17 @@ static bool amdgpu_atpx_detect(void)
 	bool d3_supported = false;
 	struct pci_dev *parent_pdev;
 
-	while ((pdev = pci_get_class(PCI_BASE_CLASS_DISPLAY << 16, pdev)) != NULL) {
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
+		vga_count++;
+
+		has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
+
+		parent_pdev = pci_upstream_bridge(pdev);
+		d3_supported |= parent_pdev && parent_pdev->bridge_d3;
+		amdgpu_atpx_get_quirks(pdev);
+	}
+
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
 		vga_count++;
 
 		has_atpx |= (amdgpu_atpx_pci_probe_handle(pdev) == true);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
