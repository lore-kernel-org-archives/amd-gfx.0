Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67B6D132A1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 09:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D3E10E3AE;
	Mon,  4 Nov 2024 09:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="gAex2VJy";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A1A10E287;
 Sun,  3 Nov 2024 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1730653482;
 bh=omnzY7OVUHnekZ/bUX8pXaM2rzeR5oe1Izmsxqjd69Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gAex2VJyMV+OiFkklrV8IrICkrh78EMUGYE6sgF6izsK/E9bdOLP+ue1pMfx65KEP
 daDJhG0bHjOZvxSIVoZOVufQPlLYRdXOaAnYLf8bMNfx7N7rX5CM0q0eWD9GRIOclJ
 PZ80lLezOY62im86G8xcV8ntzX7D+eMJVrF5nUUY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 03 Nov 2024 17:03:32 +0000
Subject: [PATCH v2 03/10] PCI/sysfs: Calculate bin_attribute size through
 bin_size()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241103-sysfs-const-bin_attr-v2-3-71110628844c@weissschuh.net>
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org, 
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730653468; l=2359;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=omnzY7OVUHnekZ/bUX8pXaM2rzeR5oe1Izmsxqjd69Q=;
 b=QEHmCC4IyJCPeU5OBXq34EhCHkpPKQglOlOaOSow6b0xRNSB6n8UoneN+GL6/CGyBOY6ZhYUm
 LOb4xWNOB8AC0VTvIPxtVY0ZKdQGGSIFQEaRXg1966rzLgUpCbB+31p
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Mailman-Approved-At: Mon, 04 Nov 2024 09:05:01 +0000
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

Stop abusing the is_bin_visible() callback to calculate the attribute
size. Instead use the new, dedicated bin_size() one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/pci-sysfs.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d0f4db1cab78674c5e5906f321bf7a57b742983..040f01b2b999175e8d98b05851edc078bbabbe0d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -818,21 +818,20 @@ static struct bin_attribute *pci_dev_config_attrs[] = {
 	NULL,
 };
 
-static umode_t pci_dev_config_attr_is_visible(struct kobject *kobj,
-					      struct bin_attribute *a, int n)
+static size_t pci_dev_config_attr_bin_size(struct kobject *kobj,
+					   const struct bin_attribute *a,
+					   int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 
-	a->size = PCI_CFG_SPACE_SIZE;
 	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
-		a->size = PCI_CFG_SPACE_EXP_SIZE;
-
-	return a->attr.mode;
+		return PCI_CFG_SPACE_EXP_SIZE;
+	return PCI_CFG_SPACE_SIZE;
 }
 
 static const struct attribute_group pci_dev_config_attr_group = {
 	.bin_attrs = pci_dev_config_attrs,
-	.is_bin_visible = pci_dev_config_attr_is_visible,
+	.bin_size = pci_dev_config_attr_bin_size,
 };
 
 /*
@@ -1330,21 +1329,26 @@ static umode_t pci_dev_rom_attr_is_visible(struct kobject *kobj,
 					   struct bin_attribute *a, int n)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	size_t rom_size;
 
 	/* If the device has a ROM, try to expose it in sysfs. */
-	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-	if (!rom_size)
+	if (!pci_resource_end(pdev, PCI_ROM_RESOURCE))
 		return 0;
 
-	a->size = rom_size;
-
 	return a->attr.mode;
 }
 
+static size_t pci_dev_rom_attr_bin_size(struct kobject *kobj,
+					const struct bin_attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	return pci_resource_len(pdev, PCI_ROM_RESOURCE);
+}
+
 static const struct attribute_group pci_dev_rom_attr_group = {
 	.bin_attrs = pci_dev_rom_attrs,
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
+	.bin_size = pci_dev_rom_attr_bin_size,
 };
 
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,

-- 
2.47.0

