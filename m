Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D646DC3DA78
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 18:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0471910E5AE;
	Tue, 17 Jan 2023 18:41:07 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B9E10E323;
 Tue, 17 Jan 2023 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xhSKM6i9VC5+7VvijWK/N24U7babSlLtavxmRhSer3s=; b=g4gbXgmSJ7W+uAJXHG9XoLQMOX
 tmv2u1kIzjoph5KKRZJXnjIr5tpw8cuhRwGRUtBxgJOME0+p45K4yNB9d0hFr85dbDsT5Q2chM/pp
 X/25VUL5vzAiJHPZFMi7c9ByvNWF5qm9rFIvrQvnD7ZbmbnjVegpYsL8mIFZCMhnTGzy8Q9vvuJu/
 nafGo3RYQ89BD1/qe1MGHUB+T/BIuPJcmqoyJnBiysUN7/j0yEG3ieXZTVzwH6znnImJE05gcwfmA
 XlulIPhirO+sgvl2wBSuzENVsIH5fcMkSEkYDvekSuuKd4fboRknPT+7WsyUcT5bK+sXNL5kaKOfk
 U49R81Sg==;
Received: from [187.56.70.205] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pHqUc-00AqiG-LP; Tue, 17 Jan 2023 19:15:32 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/2] drm/amdgpu/vcn: Adjust firmware names indentation
Date: Tue, 17 Jan 2023 15:15:23 -0300
Message-Id: <20230117181524.915372-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Jan 2023 18:41:05 +0000
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, kernel@gpiccoli.net, Xinhui.Pan@amd.com,
 dri-devel@lists.freedesktop.org, Lazar Lijo <Lijo.Lazar@amd.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, kernel-dev@igalia.com,
 alexander.deucher@amd.com, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an incredibly trivial fix, just for the sake of
"aesthetical" organization of the defines. Some were space based,
most were tab based and there was a lack of "alignment", now it's
all the same and aligned.

Cc: James Zhu <James.Zhu@amd.com>
Cc: Lazar Lijo <Lijo.Lazar@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V2/V3:
* Added Alex's review tag - thanks!


 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 38 ++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f8397d993f23..1b1a3c9e1863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -36,26 +36,26 @@
 #include "soc15d.h"
 
 /* Firmware Names */
-#define FIRMWARE_RAVEN		"amdgpu/raven_vcn.bin"
-#define FIRMWARE_PICASSO	"amdgpu/picasso_vcn.bin"
-#define FIRMWARE_RAVEN2		"amdgpu/raven2_vcn.bin"
-#define FIRMWARE_ARCTURUS	"amdgpu/arcturus_vcn.bin"
-#define FIRMWARE_RENOIR		"amdgpu/renoir_vcn.bin"
-#define FIRMWARE_GREEN_SARDINE	"amdgpu/green_sardine_vcn.bin"
-#define FIRMWARE_NAVI10		"amdgpu/navi10_vcn.bin"
-#define FIRMWARE_NAVI14		"amdgpu/navi14_vcn.bin"
-#define FIRMWARE_NAVI12		"amdgpu/navi12_vcn.bin"
-#define FIRMWARE_SIENNA_CICHLID	"amdgpu/sienna_cichlid_vcn.bin"
-#define FIRMWARE_NAVY_FLOUNDER	"amdgpu/navy_flounder_vcn.bin"
-#define FIRMWARE_VANGOGH	"amdgpu/vangogh_vcn.bin"
+#define FIRMWARE_RAVEN			"amdgpu/raven_vcn.bin"
+#define FIRMWARE_PICASSO		"amdgpu/picasso_vcn.bin"
+#define FIRMWARE_RAVEN2			"amdgpu/raven2_vcn.bin"
+#define FIRMWARE_ARCTURUS		"amdgpu/arcturus_vcn.bin"
+#define FIRMWARE_RENOIR			"amdgpu/renoir_vcn.bin"
+#define FIRMWARE_GREEN_SARDINE		"amdgpu/green_sardine_vcn.bin"
+#define FIRMWARE_NAVI10			"amdgpu/navi10_vcn.bin"
+#define FIRMWARE_NAVI14			"amdgpu/navi14_vcn.bin"
+#define FIRMWARE_NAVI12			"amdgpu/navi12_vcn.bin"
+#define FIRMWARE_SIENNA_CICHLID		"amdgpu/sienna_cichlid_vcn.bin"
+#define FIRMWARE_NAVY_FLOUNDER		"amdgpu/navy_flounder_vcn.bin"
+#define FIRMWARE_VANGOGH		"amdgpu/vangogh_vcn.bin"
 #define FIRMWARE_DIMGREY_CAVEFISH	"amdgpu/dimgrey_cavefish_vcn.bin"
-#define FIRMWARE_ALDEBARAN	"amdgpu/aldebaran_vcn.bin"
-#define FIRMWARE_BEIGE_GOBY	"amdgpu/beige_goby_vcn.bin"
-#define FIRMWARE_YELLOW_CARP	"amdgpu/yellow_carp_vcn.bin"
-#define FIRMWARE_VCN_3_1_2	"amdgpu/vcn_3_1_2.bin"
-#define FIRMWARE_VCN4_0_0	"amdgpu/vcn_4_0_0.bin"
-#define FIRMWARE_VCN4_0_2	"amdgpu/vcn_4_0_2.bin"
-#define FIRMWARE_VCN4_0_4      "amdgpu/vcn_4_0_4.bin"
+#define FIRMWARE_ALDEBARAN		"amdgpu/aldebaran_vcn.bin"
+#define FIRMWARE_BEIGE_GOBY		"amdgpu/beige_goby_vcn.bin"
+#define FIRMWARE_YELLOW_CARP		"amdgpu/yellow_carp_vcn.bin"
+#define FIRMWARE_VCN_3_1_2		"amdgpu/vcn_3_1_2.bin"
+#define FIRMWARE_VCN4_0_0		"amdgpu/vcn_4_0_0.bin"
+#define FIRMWARE_VCN4_0_2		"amdgpu/vcn_4_0_2.bin"
+#define FIRMWARE_VCN4_0_4		"amdgpu/vcn_4_0_4.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
-- 
2.39.0

