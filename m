Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0995C001E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 17:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFDE810E414;
	Tue, 11 Jul 2023 17:05:47 +0000 (UTC)
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8901010E3FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 16:53:32 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1689093834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVEqfzU8LKaeTCpd0iTjGV1loy12NrUravzVWeb1zk8=;
 b=H3VPH7tc08QQlw2h5nbl1lpqKBm+1PGywtLormVFLl9T0Bl6ppxX8pZfolXuvzfQorxg1H
 /L2uyQ6b68f3NY/OM/G+v4+IsWmf3aM/9tRax3B/Gphu9fd9i4aHg5iRxClevu+H1Lvr/T
 ZGpawz4uQZx+ixsSXOPb3VhDlhvWY94=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: David Airlie <airlied@gmail.com>
Subject: [PATCH v3 8/9] drm/ast: Register as a vga client to vgaarb by calling
 vga_client_register()
Date: Wed, 12 Jul 2023 00:43:09 +0800
Message-Id: <20230711164310.791756-9-sui.jingfeng@linux.dev>
In-Reply-To: <20230711164310.791756-1-sui.jingfeng@linux.dev>
References: <20230711164310.791756-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Tue, 11 Jul 2023 17:05:41 +0000
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
Cc: linux-fbdev@vger.kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>,
 Daniel Vetter <daniel@ffwll.ch>, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jocelyn Falempe <jfalempe@redhat.com>,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sui Jingfeng <suijingfeng@loongson.cn>

Becasuse the VGA Display Controller in the ASpeed BMC chip is also a PCIe
device, the Software Programming guide of AST2400 say that it is Fully
IBM VGA compliant, thus, it should also particiate in the arbitration.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/ast/ast_drv.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index e1224ef4ad83..0e53b0cd3f09 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -28,6 +28,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/vgaarb.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
@@ -89,6 +90,32 @@ static const struct pci_device_id ast_pciidlist[] = {
 
 MODULE_DEVICE_TABLE(pci, ast_pciidlist);
 
+static bool ast_vga_is_primary_gpu(struct pci_dev *pdev)
+{
+	struct drm_device *drm = pci_get_drvdata(pdev);
+	struct ast_device *ast = to_ast_device(drm);
+
+	return drm_aperture_contain_firmware_fb(ast->vram_base, ast->vram_size);
+}
+
+static unsigned int ast_vga_set_decode(struct pci_dev *pdev, bool state)
+{
+	struct drm_device *drm = pci_get_drvdata(pdev);
+	struct ast_device *ast = to_ast_device(drm);
+
+	if (state) {
+		/* Enable standard VGA decode and Enable normal VGA decode */
+		ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa1, 0x04);
+
+		return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
+		       VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
+	}
+
+	ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa1, 0x07);
+
+	return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
+}
+
 static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct ast_device *ast;
@@ -112,6 +139,8 @@ static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	vga_client_register(pdev, ast_vga_set_decode, ast_vga_is_primary_gpu);
+
 	drm_fbdev_generic_setup(dev, 32);
 
 	return 0;
-- 
2.25.1

