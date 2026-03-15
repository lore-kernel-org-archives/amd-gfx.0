Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC427F506D2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 13:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DF310E532;
	Mon, 16 Mar 2026 13:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bk6Gzpdu";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE7B10E2A3
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 16:43:05 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso34634135e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773592984; x=1774197784; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zT9Ebx7ITKcXyYVSOJehzLefR2Xa2qxq2q7RzGpseCo=;
 b=Bk6GzpduGETle6epO0NiTPRuQhwQAz3jgbPXKN9f5f5pGDnuyH+SsWu/ZI/0m4NhYx
 Xgo7c3/e/pqQx8Xyp23CURXCo2xx7P6uBuWBbFtwL3RWvtDGetpuQJUKMZF8pNTgBxOu
 pTqllVsEPLgKKhowrMx1cPCXhIPtQtw9PNJgQzx1icslAvJZgJ65+CLix/tefj0zTbh3
 ufrtHImz7r4cVS2lMuLCGwTI8kRPvBiCLHRgc6jBi86/EfnIZk7WzQpSWZ2ec6aPIa7h
 VqHgSDkfV+TyOApac8Hn1ns5awCq51KYuFm7Q0j8CTiGWq7N/kx8iai+/Iw8S4nDetYM
 hLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773592984; x=1774197784;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zT9Ebx7ITKcXyYVSOJehzLefR2Xa2qxq2q7RzGpseCo=;
 b=sQ6eZdPdFFj2ZfPorci8dDyde1MfYqnVtx8ml5Xog/8g5W8FqJdwCw8hl9rCGHwoQD
 HChm/ao5wXfOFU5Pvhbruj9+w7X6PiA5Mzuce60EiO3bVYx4xpe66uR//i4gD+WGpTbp
 b6YXEGAK28HmBawKbOiP+2SbnW6wpGfLOo8ff9cC9lDVV6UGGd9vvlYIAqojBd4yQFhf
 peroKXtj9a+1jeMT70Iqzcb0bit7Z0+yNHpzTgeSkNLqHmW2IeTCeI5CCjLZiMv0b2mS
 9u6/eB/aoUj9YVsQ1xwv3jmDb8sq+Ff9L2pDI4wEDrqpuhUG5UNtEdbQMmBG0uNh20yB
 vS1g==
X-Gm-Message-State: AOJu0Yx23XarcRca7mskAccrzs9wd46ZLZSbLJOF2/9bqudNhWW4kwly
 QOQ49V2XLIudSgfS9revHtnt13OVuykab7g7jMoflU1O1oYPN+a/G8e1
X-Gm-Gg: ATEYQzzwwfvVMWHWAryMZuE/lzle6sTpB9z2j9x70RQLhJmPwtLcM8/kCWg1uum54mO
 hfNNop4l3sDjPIG2sdTppVv8lTa2yCtVbAWjyKKMbfvthebgwnwX+SLYC91XLMD2C1xkW5VkXwL
 jdNzvyIfEABMe09xQcUJOu181ja/aDdZkRqzRAvc5+EFeKZb0FsN5Z4DpEWCa6qV6wuNQTKzJ4q
 8LEv8g0j9sVlx44iQ6336OIpeCaSezAhbAPNbOmlXPTsNIp5+0tL9+zJwM4Yu3Fwu1nKLeRjcai
 5EY7jZgCGyyHV1ceFoOuVq8S87CBP/yqjCxBpBgpRf/C1H6I7Otf7SYO0vli8Yu3YfZtjRx6U0U
 Evtkk74mStvjbtHDiA9aGqoTFoHi0Z1wmER9hCh+/SHl0JAXkKthUANuusNrwqA8gahC9NVyQO/
 UjbRVRqeaTTGQDv12nQvycr24Q8nVPirM7Drn+hmSOi5YutkirHg==
X-Received: by 2002:a05:600c:3b14:b0:485:41a6:cecf with SMTP id
 5b1f17b1804b1-485566d8610mr174764945e9.15.1773592983961; 
 Sun, 15 Mar 2026 09:43:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:86:f06b:2a9:c6c1:cd00:d0e9])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48569672c60sm19486735e9.0.2026.03.15.09.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 09:43:03 -0700 (PDT)
From: Andy Nguyen <theofficialflow1996@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, Andy Nguyen <theofficialflow1996@gmail.com>
Subject: [PATCH] drm/amd: add 0x13da cyan skillfish PCI id
Date: Sun, 15 Mar 2026 17:43:00 +0100
Message-ID: <20260315164300.60672-1-theofficialflow1996@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 13:28:00 +0000
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

Add an additional PCI ID to the cyan skillfish family.

Signed-off-by: Andy Nguyen <theofficialflow1996@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 1 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 1 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95d26f086d54..3cfca9249180 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2179,6 +2179,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN},
 
 	/* CYAN_SKILLFISH */
+	{0x1002, 0x13DA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
 	{0x1002, 0x13DB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
 	{0x1002, 0x13F9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
 	{0x1002, 0x13FA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 03d125f794b0..aa25e593a000 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -204,6 +204,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		    asic_id.chip_id == DEVICE_ID_NV_13FA ||
 		    asic_id.chip_id == DEVICE_ID_NV_13FB ||
 		    asic_id.chip_id == DEVICE_ID_NV_13FC ||
+		    asic_id.chip_id == DEVICE_ID_NV_13DA ||
 		    asic_id.chip_id == DEVICE_ID_NV_13DB) {
 			dc_version = DCN_VERSION_2_01;
 			break;
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 8aea50aa9533..8b647bd95691 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -217,6 +217,7 @@ enum {
 #define DEVICE_ID_NV_13FA 0x13FA
 #define DEVICE_ID_NV_13FB 0x13FB
 #define DEVICE_ID_NV_13FC 0x13FC
+#define DEVICE_ID_NV_13DA 0x13DA
 #define DEVICE_ID_NV_13DB 0x13DB
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
-- 
2.43.0

