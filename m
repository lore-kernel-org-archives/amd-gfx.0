Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30395CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 07:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52EF10E45A;
	Tue,  5 Sep 2023 07:47:32 +0000 (UTC)
Received: from out-214.mta1.migadu.com (out-214.mta1.migadu.com
 [95.215.58.214])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A320110E3EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 19:57:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1693857466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LqpDfy7jFw2xJEvEvsvRPCTDdY9j+2hqZZDtflMLDhg=;
 b=WStnGQXeW5BqIuHoiyaRzA+TJzXqxO/w6kqSS4bJpIIHA8VKpuQJC55KX3cJTyU0ojlG48
 rQA4YgJna8esL75FwGA1ZCP6tfeU2Te6m7aNzn1JJt1o1j+Trw9b2ZZgImETGb439FHPM2
 KY/rIaV6Z10ITNKiYHL2D3EBhLDq5cI=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC, drm-misc-next v4 5/9] drm/i915: Implement .be_primary() callback
Date: Tue,  5 Sep 2023 03:57:20 +0800
Message-Id: <20230904195724.633404-6-sui.jingfeng@linux.dev>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Sui Jingfeng <suijingfeng@loongson.cn>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
 David Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sui Jingfeng <suijingfeng@loongson.cn>

On a machine with multiple GPUs, a Linux user has no control over which one
is primary at boot time. This patch tries to solve the mentioned problem by
implementing the .be_primary() callback. Pass i915.modeset=10 on the kernel
cmd line if you really want the device bound by i915 drm driver to be the
primary video adapter, no matter what VGAARB say.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/i915/display/intel_vga.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
index 98d7d4dffe9f..e3f78ba2668b 100644
--- a/drivers/gpu/drm/i915/display/intel_vga.c
+++ b/drivers/gpu/drm/i915/display/intel_vga.c
@@ -113,6 +113,17 @@ intel_vga_set_decode(struct pci_dev *pdev, bool enable_decode)
 		return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
 }
 
+static bool intel_want_to_be_primary(struct pci_dev *pdev)
+{
+	struct drm_i915_private *i915 = pdev_to_i915(pdev);
+	struct i915_params *params = &i915->params;
+
+	if (params->modeset == 10)
+		return true;
+
+	return false;
+}
+
 int intel_vga_register(struct drm_i915_private *i915)
 {
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
@@ -126,7 +137,8 @@ int intel_vga_register(struct drm_i915_private *i915)
 	 * then we do not take part in VGA arbitration and the
 	 * vga_client_register() fails with -ENODEV.
 	 */
-	ret = vga_client_register(pdev, intel_vga_set_decode, NULL);
+	ret = vga_client_register(pdev, intel_vga_set_decode,
+				  intel_want_to_be_primary);
 	if (ret && ret != -ENODEV)
 		return ret;
 
-- 
2.34.1

