Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9477FC3DA78
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Jan 2023 16:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C648310E02F;
	Sun, 15 Jan 2023 16:49:52 +0000 (UTC)
X-Greylist: delayed 505 seconds by postgrey-1.36 at gabe;
 Sun, 15 Jan 2023 16:14:26 UTC
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A060310E02B;
 Sun, 15 Jan 2023 16:14:26 +0000 (UTC)
Received: from [192.168.1.22] (62-46-133-144.adsl.highway.telekom.at
 [62.46.133.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (Client did not present a certificate)
 by mail.horus.com (Postfix) with ESMTPSA id 9F0A4640A9;
 Sun, 15 Jan 2023 17:05:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
 s=20180324; t=1673798758;
 bh=w9zpZqc6ml0juSwuAMfAZS89sGNTUrIqwuPdpS5c86E=;
 h=Date:From:To:Cc:Subject:From;
 b=eSZBiD8YaRmhXMwHukyZkpo3KKuVA4BQ2gmvzVL0ZVJObOIPRhGBwwTxStaAeUhBR
 kwgHLo2tXOdZT7y8l0D7UEH6i+5uUkPE9uppjLN0AW+aVRlYE1oIk4Q7FP9EHyCaqt
 myqfXj8VTQC5BGTmv+BEckEpPmehsG74XSsJTp1A=
Received: by camel3.lan (Postfix, from userid 1000)
 id DE233540090; Sun, 15 Jan 2023 17:05:57 +0100 (CET)
Date: Sun, 15 Jan 2023 17:05:57 +0100
From: Matthias Reichl <hias@horus.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Barco MXRT-5600 branded W5100 with PCI ID 664d
Message-ID: <Y8QkZZiV78SskCIT@camel3.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yan4WqrVcSul5e5d"
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 15 Jan 2023 16:49:51 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--yan4WqrVcSul5e5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I noticed some of the used HP Z240 workstations I recently bought had a
Barco MXRT-5600 branded FirePro W5100 card installed - some others came with
an unbranded W5100 (with the standard 6449 PCI ID).

Except for a large Barco sticker on the top and Barco being mentioned on
the barcode label on the back they look completely identical.

lspci knows about the 644d PCI ID but neither the radeon nor amdgpu kernel
drivers do nor does drm/mesa/xorg userspace.

I had a go at it, added the pci id to kernel drivers, libdrm, mesa, xf86-video-ati
and xserver and got the card working fine on Debian Bullseye with kernel 6.2-rc3.
I also gave it a quick try with LibreELEC (where we build bleeding edge versions
from scratch) and that worked fine, too.

Do you happen to know more about that card and why the PCI ID is missing in
linux drivers/userspace?

I'm just attaching my current kernel and userspace patches as a reference
for now but I'm very unsure in which sequence they should be applied without
risking breakage - I already found out the hard way that patched xorg server
and driver with old libdrm is a bad idea as that results in "Failed to initialize
surface manager" instead of starting with framebuffer driver.

If you prefer I can send proper patches or I can just you let handle it.

For reference here's the lspci outout (with patched kernel and cik support
enabled in amdgpu):

root@camel3:~# lspci -vn -s 01:00.0
01:00.0 0300: 1002:664d (prog-if 00 [VGA controller])
	Subsystem: 13cc:3d2a
	Flags: bus master, fast devsel, latency 0, IRQ 137
	Memory at 1c00000000 (64-bit, prefetchable) [size=4G]
	Memory at 1d00000000 (64-bit, prefetchable) [size=8M]
	I/O ports at 3000 [size=256]
	Memory at d0f00000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at d0f40000 [disabled] [size=128K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Legacy Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [150] Advanced Error Reporting
	Capabilities: [200] Physical Resizable BAR
	Capabilities: [270] Secondary PCI Express
	Capabilities: [2b0] Address Translation Service (ATS)
	Capabilities: [2c0] Page Request Interface (PRI)
	Capabilities: [2d0] Process Address Space ID (PASID)
	Kernel driver in use: amdgpu
	Kernel modules: radeon, amdgpu

so long,

Hias

--yan4WqrVcSul5e5d
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="linux-barco.patch"

From 04905bb6f7dfd5edac642978f7b369bb2e3c18b1 Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Sun, 15 Jan 2023 00:23:07 +0100
Subject: [PATCH 1/2] drm/radeon: add PCI ID of Barco MXRT-5600 branded W5100

The Barco MXRT-5600 uses a PCI product ID of 0x664d but is otherwise
identical to the W5100 with ID 0x6649.

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 1 +
 include/drm/drm_pciids.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 8ef25ab305ae7..a014bcd1ce2aa 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -189,6 +189,7 @@ static void ci_initialize_powertune_defaults(struct radeon_device *rdev)
 
 	switch (rdev->pdev->device) {
 	case 0x6649:
+	case 0x664d:
 	case 0x6650:
 	case 0x6651:
 	case 0x6658:
diff --git a/include/drm/drm_pciids.h b/include/drm/drm_pciids.h
index b7e899ce44f0e..d60535acb52e7 100644
--- a/include/drm/drm_pciids.h
+++ b/include/drm/drm_pciids.h
@@ -183,6 +183,7 @@
 	{0x1002, 0x6646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
 	{0x1002, 0x6647, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
 	{0x1002, 0x6649, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x664d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|RADEON_NEW_MEMMAP}, \
 	{0x1002, 0x6650, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|RADEON_NEW_MEMMAP}, \
 	{0x1002, 0x6651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|RADEON_NEW_MEMMAP}, \
 	{0x1002, 0x6658, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|RADEON_NEW_MEMMAP}, \
-- 
2.30.2


From e88e4eae6aa3d8dbec042e4df3b569612be928a6 Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Sun, 15 Jan 2023 00:23:07 +0100
Subject: [PATCH 2/2] drm/amdgpu: add PCI ID of Barco MXRT-5600 branded W5100

The Barco MXRT-5600 uses a PCI product ID of 0x664d but is otherwise
identical to the W5100 with ID 0x6649.

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c             | 1 +
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1353ffd089882..45e275f541b74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1757,6 +1757,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x6646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|AMD_IS_MOBILITY},
 	{0x1002, 0x6647, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|AMD_IS_MOBILITY},
 	{0x1002, 0x6649, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
+	{0x1002, 0x664d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
 	{0x1002, 0x6650, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
 	{0x1002, 0x6651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
 	{0x1002, 0x6658, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 5ca3c422f7d4f..6012e6ed15ba3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -256,6 +256,7 @@ static void ci_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr)
 		smu_data->power_tune_defaults = &defaults_saturn_xt;
 		break;
 	case 0x6649:
+	case 0x664d:
 	case 0x6650:
 	case 0x6651:
 	case 0x6658:
-- 
2.30.2


--yan4WqrVcSul5e5d
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="libdrm-barco.patch"

From a05abfc8a574105f3a4b0047000b9579bc217c1f Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Sun, 15 Jan 2023 00:37:02 +0100
Subject: [PATCH 1/2] radeon: add PCI ID of Barco MXRT-5600 branded W5100

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 radeon/r600_pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/radeon/r600_pci_ids.h b/radeon/r600_pci_ids.h
index a3b2eac8..ffd5b0e8 100644
--- a/radeon/r600_pci_ids.h
+++ b/radeon/r600_pci_ids.h
@@ -409,6 +409,7 @@ CHIPSET(0x6641, BONAIRE_6641, BONAIRE)
 CHIPSET(0x6646, BONAIRE_6646, BONAIRE)
 CHIPSET(0x6647, BONAIRE_6647, BONAIRE)
 CHIPSET(0x6649, BONAIRE_6649, BONAIRE)
+CHIPSET(0x664D, BONAIRE_664D, BONAIRE)
 CHIPSET(0x6650, BONAIRE_6650, BONAIRE)
 CHIPSET(0x6651, BONAIRE_6651, BONAIRE)
 CHIPSET(0x6658, BONAIRE_6658, BONAIRE)
-- 
2.30.2


From 5ceb986ac3f9732ef9dda84e2809e341d07bbfec Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Sun, 15 Jan 2023 00:37:35 +0100
Subject: [PATCH 2/2] amdgpu: add PCI ID of Barco MXRT-5600 branded W5100

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 data/amdgpu.ids | 1 +
 1 file changed, 1 insertion(+)

diff --git a/data/amdgpu.ids b/data/amdgpu.ids
index 53cf61cb..5a8bb00b 100644
--- a/data/amdgpu.ids
+++ b/data/amdgpu.ids
@@ -129,6 +129,7 @@
 6647,	00,	AMD Radeon R9 M200X Series
 6647,	80,	AMD Radeon R9 M380
 6649,	00,	AMD FirePro W5100
+664D,	00,	AMD FirePro W5100
 6658,	00,	AMD Radeon R7 200 Series
 665C,	00,	AMD Radeon HD 7700 Series
 665D,	00,	AMD Radeon R7 200 Series
-- 
2.30.2


--yan4WqrVcSul5e5d
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="mesa-barco.patch"

From 748b988d039fd90cc96db7e05e5ed37163f6614c Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Sun, 15 Jan 2023 00:31:35 +0100
Subject: [PATCH] amd: add PCI ID of Barco MXRT-5600 branded W5100

The Barco MXRT-5600 uses a PCI product ID of 0x664d but is otherwise
identical to the W5100 with ID 0x6649.

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 include/pci_ids/radeonsi_pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/pci_ids/radeonsi_pci_ids.h b/include/pci_ids/radeonsi_pci_ids.h
index 8c4567e8483..3a51a66f621 100644
--- a/include/pci_ids/radeonsi_pci_ids.h
+++ b/include/pci_ids/radeonsi_pci_ids.h
@@ -81,6 +81,7 @@ CHIPSET(0x6641, BONAIRE)
 CHIPSET(0x6646, BONAIRE)
 CHIPSET(0x6647, BONAIRE)
 CHIPSET(0x6649, BONAIRE)
+CHIPSET(0x664D, BONAIRE)
 CHIPSET(0x6650, BONAIRE)
 CHIPSET(0x6651, BONAIRE)
 CHIPSET(0x6658, BONAIRE)
-- 
2.30.2


--yan4WqrVcSul5e5d
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="xf86-video-ati-barco.patch"

From 5ce581b89b7f690c19fb38f996d6124caeeedfec Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Sun, 15 Jan 2023 00:40:02 +0100
Subject: [PATCH xf86-video-ati] radeon: add PCI ID of Barco MXRT-5600 branded
 W5100

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 src/ati_pciids_gen.h              | 1 +
 src/pcidb/ati_pciids.csv          | 1 +
 src/radeon_chipinfo_gen.h         | 1 +
 src/radeon_chipset_gen.h          | 1 +
 src/radeon_pci_chipset_gen.h      | 1 +
 src/radeon_pci_device_match_gen.h | 1 +
 6 files changed, 6 insertions(+)

diff --git a/src/ati_pciids_gen.h b/src/ati_pciids_gen.h
index c6216a54..fc465d20 100644
--- a/src/ati_pciids_gen.h
+++ b/src/ati_pciids_gen.h
@@ -708,6 +708,7 @@
 #define PCI_CHIP_BONAIRE_6646 0x6646
 #define PCI_CHIP_BONAIRE_6647 0x6647
 #define PCI_CHIP_BONAIRE_6649 0x6649
+#define PCI_CHIP_BONAIRE_664D 0x664D
 #define PCI_CHIP_BONAIRE_6650 0x6650
 #define PCI_CHIP_BONAIRE_6651 0x6651
 #define PCI_CHIP_BONAIRE_6658 0x6658
diff --git a/src/pcidb/ati_pciids.csv b/src/pcidb/ati_pciids.csv
index 59b370aa..376405ab 100644
--- a/src/pcidb/ati_pciids.csv
+++ b/src/pcidb/ati_pciids.csv
@@ -709,6 +709,7 @@
 "0x6646","BONAIRE_6646","BONAIRE",1,,,,,"BONAIRE"
 "0x6647","BONAIRE_6647","BONAIRE",1,,,,,"BONAIRE"
 "0x6649","BONAIRE_6649","BONAIRE",,,,,,"BONAIRE"
+"0x664D","BONAIRE_664D","BONAIRE",,,,,,"BONAIRE"
 "0x6650","BONAIRE_6650","BONAIRE",,,,,,"BONAIRE"
 "0x6651","BONAIRE_6651","BONAIRE",,,,,,"BONAIRE"
 "0x6658","BONAIRE_6658","BONAIRE",,,,,,"BONAIRE"
diff --git a/src/radeon_chipinfo_gen.h b/src/radeon_chipinfo_gen.h
index 91ef8df8..7ac74829 100644
--- a/src/radeon_chipinfo_gen.h
+++ b/src/radeon_chipinfo_gen.h
@@ -628,6 +628,7 @@ static RADEONCardInfo RADEONCards[] = {
  { 0x6646, CHIP_FAMILY_BONAIRE, 1, 0, 0, 0, 0 },
  { 0x6647, CHIP_FAMILY_BONAIRE, 1, 0, 0, 0, 0 },
  { 0x6649, CHIP_FAMILY_BONAIRE, 0, 0, 0, 0, 0 },
+ { 0x664D, CHIP_FAMILY_BONAIRE, 0, 0, 0, 0, 0 },
  { 0x6650, CHIP_FAMILY_BONAIRE, 0, 0, 0, 0, 0 },
  { 0x6651, CHIP_FAMILY_BONAIRE, 0, 0, 0, 0, 0 },
  { 0x6658, CHIP_FAMILY_BONAIRE, 0, 0, 0, 0, 0 },
diff --git a/src/radeon_chipset_gen.h b/src/radeon_chipset_gen.h
index 496dee6a..08c2f759 100644
--- a/src/radeon_chipset_gen.h
+++ b/src/radeon_chipset_gen.h
@@ -628,6 +628,7 @@ SymTabRec RADEONChipsets[] = {
   { PCI_CHIP_BONAIRE_6646, "BONAIRE" },
   { PCI_CHIP_BONAIRE_6647, "BONAIRE" },
   { PCI_CHIP_BONAIRE_6649, "BONAIRE" },
+  { PCI_CHIP_BONAIRE_664D, "BONAIRE" },
   { PCI_CHIP_BONAIRE_6650, "BONAIRE" },
   { PCI_CHIP_BONAIRE_6651, "BONAIRE" },
   { PCI_CHIP_BONAIRE_6658, "BONAIRE" },
diff --git a/src/radeon_pci_chipset_gen.h b/src/radeon_pci_chipset_gen.h
index 4b4b8e45..ee9ef674 100644
--- a/src/radeon_pci_chipset_gen.h
+++ b/src/radeon_pci_chipset_gen.h
@@ -628,6 +628,7 @@ static PciChipsets RADEONPciChipsets[] = {
  { PCI_CHIP_BONAIRE_6646, PCI_CHIP_BONAIRE_6646, RES_SHARED_VGA },
  { PCI_CHIP_BONAIRE_6647, PCI_CHIP_BONAIRE_6647, RES_SHARED_VGA },
  { PCI_CHIP_BONAIRE_6649, PCI_CHIP_BONAIRE_6649, RES_SHARED_VGA },
+ { PCI_CHIP_BONAIRE_664D, PCI_CHIP_BONAIRE_664D, RES_SHARED_VGA },
  { PCI_CHIP_BONAIRE_6650, PCI_CHIP_BONAIRE_6650, RES_SHARED_VGA },
  { PCI_CHIP_BONAIRE_6651, PCI_CHIP_BONAIRE_6651, RES_SHARED_VGA },
  { PCI_CHIP_BONAIRE_6658, PCI_CHIP_BONAIRE_6658, RES_SHARED_VGA },
diff --git a/src/radeon_pci_device_match_gen.h b/src/radeon_pci_device_match_gen.h
index 6dfe1e42..41674d1c 100644
--- a/src/radeon_pci_device_match_gen.h
+++ b/src/radeon_pci_device_match_gen.h
@@ -628,6 +628,7 @@ static const struct pci_id_match radeon_device_match[] = {
  ATI_DEVICE_MATCH( PCI_CHIP_BONAIRE_6646, 0 ),
  ATI_DEVICE_MATCH( PCI_CHIP_BONAIRE_6647, 0 ),
  ATI_DEVICE_MATCH( PCI_CHIP_BONAIRE_6649, 0 ),
+ ATI_DEVICE_MATCH( PCI_CHIP_BONAIRE_664D, 0 ),
  ATI_DEVICE_MATCH( PCI_CHIP_BONAIRE_6650, 0 ),
  ATI_DEVICE_MATCH( PCI_CHIP_BONAIRE_6651, 0 ),
  ATI_DEVICE_MATCH( PCI_CHIP_BONAIRE_6658, 0 ),
-- 
2.30.2


--yan4WqrVcSul5e5d
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="xserver-barco.patch"

From 1a4967aaacb03ff7a855635fc6b1108d3340d802 Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Sun, 15 Jan 2023 00:41:35 +0100
Subject: [PATCH] dri2: add PCI ID of Barco MXRT-5600 branded W5100

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 hw/xfree86/dri2/pci_ids/radeonsi_pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xfree86/dri2/pci_ids/radeonsi_pci_ids.h b/hw/xfree86/dri2/pci_ids/radeonsi_pci_ids.h
index 2ec8a1e24..32dbfd1ef 100644
--- a/hw/xfree86/dri2/pci_ids/radeonsi_pci_ids.h
+++ b/hw/xfree86/dri2/pci_ids/radeonsi_pci_ids.h
@@ -81,6 +81,7 @@ CHIPSET(0x6641, BONAIRE_6641, BONAIRE)
 CHIPSET(0x6646, BONAIRE_6646, BONAIRE)
 CHIPSET(0x6647, BONAIRE_6647, BONAIRE)
 CHIPSET(0x6649, BONAIRE_6649, BONAIRE)
+CHIPSET(0x664D, BONAIRE_664D, BONAIRE)
 CHIPSET(0x6650, BONAIRE_6650, BONAIRE)
 CHIPSET(0x6651, BONAIRE_6651, BONAIRE)
 CHIPSET(0x6658, BONAIRE_6658, BONAIRE)
-- 
2.30.2


--yan4WqrVcSul5e5d--
