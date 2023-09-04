Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E475CA0FF7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 07:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B79710E448;
	Tue,  5 Sep 2023 07:47:27 +0000 (UTC)
Received: from out-226.mta1.migadu.com (out-226.mta1.migadu.com
 [IPv6:2001:41d0:203:375::e2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B39D10E3FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 19:57:52 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1693857470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eVLtpKZqnO0MsDqBoHAPYkiqg81D+bke81ZOJN69XK4=;
 b=NC2ru9MCWsAYNJ2JJcP1noCtF2zQDgPBa0LpYE2S+4M6e4i+WN2Kd9qVsYWiRslhWMrg0+
 xIyJHmFr09Ash0CyTQsTafa0QY9OGLSS0SQL36tPB5E78LI0mlzwjbZA+6UeW9wJkR7mO+
 OeDMb50AfrAOUBCe6WMMLaNnrkQX67s=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC,
 drm-misc-next v4 7/9] drm/ast: Register as a VGA client by calling
 vga_client_register()
Date: Tue,  5 Sep 2023 03:57:22 +0800
Message-Id: <20230904195724.633404-8-sui.jingfeng@linux.dev>
In-Reply-To: <20230904195724.633404-1-sui.jingfeng@linux.dev>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 05 Sep 2023 07:47:25 +0000
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
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Sui Jingfeng <suijingfeng@loongson.cn>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-pci@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sui Jingfeng <suijingfeng@loongson.cn>

Becasuse the display controller in the ASpeed BMC chip is a VGA-compatible
device, the software programming guide of AST2400 say that it is fully
IBM VGA compliant. Thus, it should also participate in the arbitration.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/ast/ast_drv.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index e1224ef4ad83..1349f7bb5dfb 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -28,6 +28,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/vgaarb.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -89,6 +90,34 @@ static const struct pci_device_id ast_pciidlist[] = {
 
 MODULE_DEVICE_TABLE(pci, ast_pciidlist);
 
+static bool ast_want_to_be_primary(struct pci_dev *pdev)
+{
+	if (ast_modeset == 10)
+		return true;
+
+	return false;
+}
+
+static unsigned int ast_vga_set_decode(struct pci_dev *pdev, bool state)
+{
+	struct drm_device *drm = pci_get_drvdata(pdev);
+	struct ast_device *ast = to_ast_device(drm);
+	unsigned int decode;
+
+	if (state) {
+		/* Enable standard VGA decode and Enable normal VGA decode */
+		ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa1, 0x04);
+
+		decode = VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
+			 VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
+	} else {
+		ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa1, 0x07);
+		decode = VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
+	}
+
+	return decode;
+}
+
 static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct ast_device *ast;
@@ -112,6 +141,8 @@ static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	vga_client_register(pdev, ast_vga_set_decode, ast_want_to_be_primary);
+
 	drm_fbdev_generic_setup(dev, 32);
 
 	return 0;
-- 
2.34.1

