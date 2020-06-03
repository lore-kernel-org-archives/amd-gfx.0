Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D108C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 01:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07692072F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 01:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq5kbzaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07692072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64966E258;
	Wed,  3 Jun 2020 01:31:49 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141F56E258
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 01:31:48 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id n141so614576qke.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 18:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VWoHTgnci3l4TWBgdO8mZriM97FyUXlcv2kkMgvZrKw=;
 b=Vq5kbzaN4TSsdf1LrHx++BIrwSNLMoYOEuq4S3pOfYwJvfSJKz9iDIjIWrr6fyyPOc
 z+s/b6gtWhhoDzu6MMqw8W2J2w1N6+qCMXTyw8cwCYouSjWBzFhJ3GfoQ0xKqfjuKhcC
 3K4o8tXn3lZX+utOUCpfTgcAbDuz5pjwv8lz+Ym5UK95T9KqGDIImIzq/3DHZoWubvZr
 uGMuSQEg3RR0In5ekHzlMKZGw9W5o+3sPuLFPErEaYUWRHSlQupSxgd7IWEft3hPJTu2
 HL+HQZKO1veX7MMnk9qJX1QnmylXlIqc/GADcFbqqVi1UnQN/c2WN07/Z5+Tx4HSMwE0
 +rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VWoHTgnci3l4TWBgdO8mZriM97FyUXlcv2kkMgvZrKw=;
 b=ICOfyujASVGUDCTXZudTjeCCRwZHUPYqbNUv+TebHRyHvZpIR+v/mliOC2NVUOvdnn
 FIKDPwuFPljusv7lIKEhjQFCKPJq3pfLtTpHBoZ2K2a8VUVs0DH2b/yOWgQ4JR0MvCk0
 MkrzekylbgNkBYb/3cj3IN4M0Xc/IsDa2VU8Srmv1pfIwsOVVb72lT9//6xO5FDXOgo9
 yvfbPjZ0tdk1Nx5dei+Xzcp6ibi1EI3BSJOqODjlwO5h98yc6RxIfAYEOniNKDvrdSvG
 I+B2afEllItiUOtDqjz5qfpuVDSew70hPdj27qnXLbjJ4bjcp3bR6dRma5xOGmbQ50Qj
 4sMQ==
X-Gm-Message-State: AOAM532OFogz55Oysqwl7q0O1BMe0T4JukFD+treOwtIl6aPPdG2j+mk
 zglrR72e+jaqH+45cuY6ytm2vkM1
X-Google-Smtp-Source: ABdhPJzUQk0OtPJhPQJH6otYZAZeAXjwRD4jhXtRHr1sFhBaG4sziuaQUq48JQgBnuO49OAc17KjXA==
X-Received: by 2002:a05:620a:200a:: with SMTP id
 c10mr26764217qka.218.1591147906938; 
 Tue, 02 Jun 2020 18:31:46 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id p6sm610575qtd.91.2020.06.02.18.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:31:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alsa-devel@alsa-project.org
Subject: [PATCH] sound/pci/hda: add sienna_cichlid audio asic id for
 sienna_cichlid up
Date: Tue,  2 Jun 2020 21:31:37 -0400
Message-Id: <20200603013137.1849404-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Hersen Wu <hersenxs.wu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

dp/hdmi ati hda is not shown in audio settings

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 92a042e34d3e..4188bc4bd4e2 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2643,6 +2643,9 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1002, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	{ PCI_DEVICE(0x1002, 0xab28),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	/* VIA VT8251/VT8237A */
 	{ PCI_DEVICE(0x1106, 0x3288), .driver_data = AZX_DRIVER_VIA },
 	/* VIA GFX VT7122/VX900 */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
