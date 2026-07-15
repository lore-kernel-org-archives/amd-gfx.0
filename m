Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A96C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 16:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66A610F10B;
	Wed, 15 Jul 2026 16:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vIR17jxV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAC510E1FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 16:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHjq950okODlADEXmEcBRkmf9apiN1BwGh6XbM0eO2nDcB4aZVhv+7xzEe7Ygp9Hyn7ZQBkWUgUniodmZ/8CBhCiMX4q0zqn1KR8iMoRq5BcSfulfOYAGmo5mdMKEdWGFQV8khLVpDNFEQHG8v8XgHkJdb3Bu9WEogFwt1Uo26S0WDqeerUb95YenkspsG8tO/j8mKRiq/jIK+zIuhLO/1wR70B5bJ3rHdPRc9Uqn4/ino+UrDQMeYeZAe81kI25hOPeHDxxCvygAlSOI92bPcK3Lb8Fn5RFEjh1ICqAKuNCG8czoOcmGPBKBHqQ1Rzo0o9oob1aPgbMLAlmTElFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiZ2GVksDkg4oYMsWcZxgMaYRHZ9jA/13a6r1TJED1o=;
 b=SFdVZR/D9AI+wMmdf0v8YkBPuvBjpBriJkHI4+fNa3D/eVX8hMPSuW0nNPTfKPVganp55Q4kZKVXtPYdYaYS4EvJ2BwXGUBeH8zfjHWqIDJgJwXkfTH1MFKO6t9+ggQw7HPXSW0cBEWPjYIDMM/hCwy71uvNExJB4r9qnLwHpGrHEtzec5IXeyOO6v3okfe9+ntW5JZll3H178ZXFFKhI3oKp4YZoy8t8AZO1IfMmaVojkztl69djr8IicZ3sp4Y+xjqwkA97/rS3oX9rQU04NrPJqBabYaSe84RVfpRpJBIhagsQZ5K8AX7Dsm7n+tlLJeUjdOeVPnIPQeQIZUXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiZ2GVksDkg4oYMsWcZxgMaYRHZ9jA/13a6r1TJED1o=;
 b=vIR17jxVCs0WBMos/raRqDQi1E62jkxpyN5/GjsDTqLRGi+hjCZVXcQPT9d8vXsEIeSIQlZPkbVCD88i2CSoWyEMhYjHx3fu3pB+ZO4T0InKtvpH/10aRNMDxOTHc1Cru9BOZzNN8mznVNBtziTNKfAbktOpIN0DAvK6dkWNIeY=
Received: from BL1PR13CA0406.namprd13.prod.outlook.com (2603:10b6:208:2c2::21)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 16:50:22 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::1c) by BL1PR13CA0406.outlook.office365.com
 (2603:10b6:208:2c2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Wed, 15
 Jul 2026 16:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 16:50:22 +0000
Received: from lsttdev4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 11:50:21 -0500
From: "Galantsev, Dmitrii" <dmitrii.galantsev@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <paul.blinzer@amd.com>, Dmitrii Galantsev
 <dmitrii.galantsev@amd.com>
Subject: [PATCH] drm/amdgpu: add Component Unified ID (CUID) sysfs interface
Date: Wed, 15 Jul 2026 11:48:36 -0500
Message-ID: <20260715164836.3879564-1-dmitrii.galantsev@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6777de-f4da-43d1-9d3e-08dee2912929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|10067099003|6133799003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JR+BggB5FJ/H5Nr/Ztw432x2DHIfGa/NqpHCKgvz1Pdzm8ODZiJmhm3WCdSMQbK9AUAGGw6VQYg0yJIyG5eqFXxEmGSQy8IWdttKv2nhERWLnHOfMD2XPSJRecx7Qfhz8CAFWFc1HLlvC/GRVyDDTGuF8RGCCP74/SOHcGak/hgXTTins2pkpK03789mZXoiu1LTEPvVsZkdP+VYv/Fcvu1VTXaUIOAwNSUirw4DyVSeChItV2v/QnD3aCz49Xe/poMm2FwlyoTOyA0lpf/400S1MFOEAu5DN9Qu39Bb7MxUjs6D4PlSxLpNb9Cp63GCdV44mX9RwQTLWJe5rsDfn87Mj0BSkI+LatAkw0CXzmmyMzhzplK+oSquTdXCcTAG0MJ1xK76OJTnu5OveuffGLtMTIsOloGcCyX+irSz6mKr3KmuAAPYSDkI2KfsZfvqbMwyqCA5BdjHTeAZuFf8GsKacbcFAVBtI2qvDENRY9yO04D839VYIRy+ozKV9O5Nmw3jeNElNQvXmsxTGHKuVvHYm80+Z6Sg1AmoC0JrB7MJvIWw4osg92KimYTn+ELgjC6zHpGsiOn5sE7knbvuYm86Qyqy9X/mvufGO6rDkUd2umlBCezXITKHUOzOfDodpwX7r71V/vmCtcBMabxgZqoMjH8W7tXRRCLxefWjyQlWc7AxugyyDPyeDoaqJQZJcUbneKLgvAKbCKBooIJNvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(6133799003)(18002099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5vNPM2C6F9Ty2HdUoAwvY6zylziYPr2w1ZdWoz74kp3GTSiFJeVcr4TzPzzmeEcIZr+jM/bDBo+yYfALiPFZ+Xoo1oGOZHvDDleC/B+qg/yRX4PMjhGm0aQ/fhDVQUdY76mni6DawUkWZq7oXorwBBzOX7wvKm6ZmcD2fGYIfKLUhkpFRcMQ4ZL4AG7gnfcBjvj2WTrVvX97GR1QIR6PcNLO/Rs0/fqTuTve6KS9Bf1qQ2sWN+nhD1a7tJpbYTCn5YQ5MrgOlk494ponNbqzK/GgnRG3Mj0JTJNUl4Pw1gdUU1JCnArrb6FUQKfIUVTvke1e6Vpd7RjeNa0WkV8KIyBQjw+cftlfzK+rdhzexeZbwDp07fM03Gu3kM+X5+574nlDsd3P/A8dpM+WejHSsaBgd04xpUPL0AaXlWGC+sU7AdNJF6tew+20sSIwv9tQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 16:50:22.1489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6777de-f4da-43d1-9d3e-08dee2912929
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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

From: Dmitrii Galantsev <dmitrii.galantsev@amd.com>

Expose a stable, per-GPU identifier so fleet and inventory tooling can name
a device without reading the raw serial number.

A 122-bit primary payload (serial, PCI vendor/device/revision, unit and
component type) is packed LSB-first and rendered as an RFC 9562 UUIDv8.
Three sysfs attributes sit beside unique_id:

  - cuid_primary (0400): raw identity; root-only as it embeds the serial.
  - cuid_secondary (0444): HMAC-SHA256(seed, primary), world-readable as it
    leaks neither the serial nor the seed. A public default seed is used
    until a secret is provisioned via cuid_seed.
  - cuid_seed (0600): the secret seed, raw bytes (at most 32).

Derivation uses the synchronous library HMAC-SHA256 (crypto/sha2.h) on the
read path; the only persistent state is the seed, guarded by a mutex. CUID
init is best-effort and does not fail device attribute init.

Signed-off-by: Dmitrii Galantsev <dmitrii.galantsev@amd.com>
---
 Documentation/gpu/amdgpu/driver-misc.rst   |  21 ++
 drivers/gpu/drm/amd/amdgpu/Kconfig         |   2 +
 drivers/gpu/drm/amd/amdgpu/Makefile        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c   | 278 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h   |  45 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  13 +-
 7 files changed, 364 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h

diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
index e1a964c3add2..983358ab4c4c 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -154,3 +154,24 @@ uma/carveout
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    :doc: uma/carveout
+
+Component Unified ID (CUID) Information
+======================================
+
+cuid_primary
+------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
+   :doc: cuid_primary
+
+cuid_secondary
+--------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
+   :doc: cuid_secondary
+
+cuid_seed
+---------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
+   :doc: cuid_seed
diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 12e4a41bf1f0..1430096412ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -26,6 +26,8 @@ config DRM_AMDGPU
 	select DRM_SUBALLOC_HELPER
 	select DRM_EXEC
 	select DRM_PANEL_BACKLIGHT_QUIRKS
+	# CUID derives its secondary ID with library HMAC-SHA256
+	select CRYPTO_LIB_SHA256
 	# amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select to work
 	# ACPI_VIDEO's dependencies must also be selected.
 	select INPUT if ACPI
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 105b9dcc19a2..66f4476966cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -52,6 +52,7 @@ amdgpu-y := amdgpu_drv.o
 
 # add KMS driver
 amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
+	amdgpu_cuid.o \
 	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
 	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
 	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f5d65bd0ac25..90abbdfcec5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -872,6 +872,11 @@ struct amdgpu_device {
 
 	uint64_t			unique_id;
 	uint8_t				unitid;
+
+	/* CUID: secret seed for HMAC-derived secondary CUID */
+	struct mutex			cuid_seed_lock;
+	u8				cuid_seed[32];
+	unsigned int			cuid_seed_len;
 	uint64_t	df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
 
 	/* enable runtime pm on the device */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
new file mode 100644
index 000000000000..a365f8ab4591
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CUID (Canonical Unique ID) support for amdgpu.
+ *
+ * Builds a primary identifier from the GPU identity (vendor/device/revision and
+ * the serial in adev->unique_id) and exposes it, plus an HMAC-derived secondary
+ * value, as UUIDv8 sysfs files beside unique_id.
+ *
+ * The packing, UUIDv8 framing and HMAC derivation form a frozen ABI: the
+ * payload is packed LSB-first into 16 little-endian bytes, framed as an
+ * RFC 9562 UUIDv8, and derived as HMAC-SHA256(key, primary). Derivation uses
+ * the synchronous library HMAC-SHA256 (crypto/sha2.h), so it cannot fail and is
+ * callable from the sysfs read path. The only persistent state is the secret
+ * seed (adev->cuid_seed*, guarded by adev->cuid_seed_lock).
+ */
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/capability.h>
+#include <linux/pci.h>
+#include <linux/string.h>
+#include <linux/uuid.h>
+#include <linux/mutex.h>
+#include <linux/unaligned.h>
+#include <crypto/sha2.h>
+
+#include <drm/drm_drv.h>
+
+#include "amdgpu.h"
+#include "amdgpu_cuid.h"
+
+/* Public default seed for cuid_secondary until a secret is provisioned. */
+static const u8 CUID_DEFAULT_SEED[] = "AMD-CUID-DEFAULT-SEED-v1";
+
+/* Pack the 122-bit primary payload into 16 little-endian bytes. */
+static void cuid_pack(const struct cuid_primary *p, u8 raw[16])
+{
+	put_unaligned_le64(p->dsn, raw);	/* 0:63 DSN */
+
+	raw[8]  = p->unit_id & 0xFF;		/* 64:71 UnitID lo */
+	raw[9]  = p->revision_id;		/* 72:79 revision */
+	put_unaligned_le16(p->device_id, &raw[10]);	/* 80:95 device */
+	put_unaligned_le16(p->vendor_id, &raw[12]);	/* 96:111 vendor */
+
+	/* 112:116 UnitID hi | 117 aux | 118:121 component type */
+	raw[14] = ((p->unit_id >> 8) & 0x1F) |
+		  ((p->aux & 0x1) << 5) |
+		  ((p->component_type & 0x03) << 6);
+	raw[15] = (p->component_type >> 2) & 0x03;
+}
+
+/* UUIDv8 framing bits: version nibble (76:79), variant bits (62:63). */
+static bool cuid_is_framing_bit(int pos)
+{
+	return pos == 62 || pos == 63 || (pos >= 76 && pos <= 79);
+}
+
+/* Insert RFC 9562 UUIDv8 version(8)/variant(10b) framing losslessly. */
+static void cuid_to_uuidv8(const u8 raw[16], u8 uuid[16])
+{
+	int src = 0, pos;
+
+	memset(uuid, 0, 16);
+	for (pos = 0; pos < 128; pos++) {
+		if (cuid_is_framing_bit(pos))
+			continue;
+		if ((raw[src >> 3] >> (src & 7)) & 1)
+			uuid[15 - (pos >> 3)] |= 1u << (pos & 7);
+		src++;
+	}
+	uuid[6] = (uuid[6] & 0x0F) | 0x80;	/* version 8 */
+	uuid[8] = (uuid[8] & 0x3F) | 0x80;	/* variant 10b */
+}
+
+/*
+ * Derive the secondary payload from HMAC-SHA256(key, raw_primary):
+ *   0:63    = hash[0:63]
+ *   72:116  = hash[64:108]	(45 bits)
+ *   117     = aux (from primary); all other bits zero.
+ */
+static void cuid_derive(const u8 *key, unsigned int keylen,
+			const u8 raw_primary[16], u8 derived_raw[16])
+{
+	u8 digest[SHA256_DIGEST_SIZE];
+	int i;
+
+	hmac_sha256_usingrawkey(key, keylen, raw_primary, 16, digest);
+
+	memset(derived_raw, 0, 16);
+
+	/* hash[0:63] -> derived[0:63] */
+	memcpy(derived_raw, digest, 8);
+
+	/* hash[64:108] -> derived[72:116] */
+	for (i = 0; i < 45; i++) {
+		int hb = 64 + i, db = 72 + i;
+		u8 bit = (digest[hb >> 3] >> (hb & 7)) & 1;
+
+		derived_raw[db >> 3] |= bit << (db & 7);
+	}
+
+	/* aux (bit 117) copied from primary; same position in both buffers */
+	derived_raw[14] |= raw_primary[14] & BIT(5);
+
+	memzero_explicit(digest, sizeof(digest));
+}
+
+static void amdgpu_cuid_build_primary(struct amdgpu_device *adev,
+				      struct cuid_primary *p)
+{
+	u64 dsn = 0;
+
+	memset(p, 0, sizeof(*p));
+
+	if (adev->pdev) {
+		p->vendor_id = adev->pdev->vendor;
+		p->device_id = adev->pdev->device;
+		p->revision_id = adev->pdev->revision;
+
+		/* Prefer the PCIe DSN capability, else the SMU serial. */
+		dsn = pci_get_dsn(adev->pdev);
+	}
+	if (!dsn)
+		dsn = adev->unique_id;
+
+	p->dsn = dsn;
+	/* aux (bit 117): set when no genuine serial was found (dsn == 0). */
+	p->aux = (dsn == 0);
+	p->component_type = CUID_COMPONENT_GPU;
+}
+
+/*
+ * DOC: cuid_primary
+ *
+ * Primary CUID as a UUIDv8. Embeds the raw serial, so it is root-only (0400).
+ */
+static ssize_t cuid_primary_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct cuid_primary primary;
+	u8 raw[16], uuid[16];
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	amdgpu_cuid_build_primary(adev, &primary);
+	cuid_pack(&primary, raw);
+	cuid_to_uuidv8(raw, uuid);
+
+	return sysfs_emit(buf, "%pUb\n", uuid);
+}
+
+static DEVICE_ATTR(cuid_primary, 0400, cuid_primary_show, NULL);
+
+/*
+ * DOC: cuid_secondary
+ *
+ * HMAC-SHA256(seed, primary) as a UUIDv8. Leaks neither the serial nor the
+ * seed, so it is world-readable (0444). Without a provisioned seed a public
+ * default is used: stable but not fleet-unique, so treat it as a placeholder.
+ */
+static ssize_t cuid_secondary_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct cuid_primary primary;
+	u8 raw[16], derived[16], uuid[16];
+	u8 seed[32];
+	unsigned int seedlen;
+
+	amdgpu_cuid_build_primary(adev, &primary);
+	cuid_pack(&primary, raw);
+
+	mutex_lock(&adev->cuid_seed_lock);
+	if (adev->cuid_seed_len) {
+		seedlen = adev->cuid_seed_len;
+		memcpy(seed, adev->cuid_seed, sizeof(seed));
+	} else {
+		/* default seed, excluding the string's NUL terminator */
+		seedlen = sizeof(CUID_DEFAULT_SEED) - 1;
+		memcpy(seed, CUID_DEFAULT_SEED, seedlen);
+	}
+	mutex_unlock(&adev->cuid_seed_lock);
+
+	cuid_derive(seed, seedlen, raw, derived);
+	memzero_explicit(seed, sizeof(seed));
+
+	cuid_to_uuidv8(derived, uuid);
+	return sysfs_emit(buf, "%pUb\n", uuid);
+}
+
+static DEVICE_ATTR_RO(cuid_secondary);
+
+/*
+ * DOC: cuid_seed
+ *
+ * Root-only (0600) secret seed for cuid_secondary, as raw bytes (at most 32).
+ * Reading returns the seed in use (the provisioned secret, or the default);
+ * read and write use the same encoding, so the value round-trips.
+ */
+static ssize_t cuid_seed_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	unsigned int seedlen;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	mutex_lock(&adev->cuid_seed_lock);
+	if (adev->cuid_seed_len) {
+		seedlen = adev->cuid_seed_len;
+		memcpy(buf, adev->cuid_seed, seedlen);
+	} else {
+		/* default seed, excluding the string's NUL terminator */
+		seedlen = sizeof(CUID_DEFAULT_SEED) - 1;
+		memcpy(buf, CUID_DEFAULT_SEED, seedlen);
+	}
+	mutex_unlock(&adev->cuid_seed_lock);
+
+	/* Raw bytes so the value round-trips through a write. */
+	return seedlen;
+}
+
+static ssize_t cuid_seed_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	if (count > sizeof(adev->cuid_seed))
+		return -EINVAL;
+
+	mutex_lock(&adev->cuid_seed_lock);
+	memset(adev->cuid_seed, 0, sizeof(adev->cuid_seed));
+	memcpy(adev->cuid_seed, buf, count);
+	adev->cuid_seed_len = count;
+	mutex_unlock(&adev->cuid_seed_lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(cuid_seed, 0600, cuid_seed_show, cuid_seed_store);
+
+static struct attribute *amdgpu_cuid_attrs[] = {
+	&dev_attr_cuid_primary.attr,
+	&dev_attr_cuid_secondary.attr,
+	&dev_attr_cuid_seed.attr,
+	NULL,
+};
+
+static const struct attribute_group amdgpu_cuid_group = {
+	.attrs = amdgpu_cuid_attrs,
+};
+
+int amdgpu_cuid_sysfs_init(struct amdgpu_device *adev)
+{
+	mutex_init(&adev->cuid_seed_lock);
+	adev->cuid_seed_len = 0;
+
+	/* On failure the lock is torn down by amdgpu_cuid_sysfs_fini(). */
+	return sysfs_create_group(&adev->dev->kobj, &amdgpu_cuid_group);
+}
+
+void amdgpu_cuid_sysfs_fini(struct amdgpu_device *adev)
+{
+	sysfs_remove_group(&adev->dev->kobj, &amdgpu_cuid_group);
+
+	memzero_explicit(adev->cuid_seed, sizeof(adev->cuid_seed));
+	adev->cuid_seed_len = 0;
+	mutex_destroy(&adev->cuid_seed_lock);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h
new file mode 100644
index 000000000000..473ba3a4ab8f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cuid.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * CUID (Canonical Unique ID) support for amdgpu.
+ *
+ * Builds a 122-bit primary identifier from the per-GPU hardware identity and
+ * exposes it as a UUIDv8, together with an HMAC-derived secondary CUID.
+ */
+#ifndef __AMDGPU_CUID_H__
+#define __AMDGPU_CUID_H__
+
+#include <linux/types.h>
+
+struct amdgpu_device;
+
+/*
+ * 122-bit primary CUID layout (frozen ABI):
+ *
+ *   0:63     Device Serial Number (amdgpu: adev->unique_id)
+ *   64:71    UnitID low 8 bits
+ *   72:79    RevisionID
+ *   80:95    DeviceID
+ *   96:111   VendorID
+ *   112:116  UnitID high 5 bits
+ *   117      Auxiliary Indicator
+ *   118:121  Component Type
+ *
+ * Packed with explicit shift/mask (not C bitfields) for a stable ABI.
+ */
+struct cuid_primary {
+	u64 dsn;
+	u16 vendor_id;
+	u16 device_id;
+	u16 unit_id;		/* 13 bits */
+	u8 revision_id;
+	u8 component_type;	/* 4 bits */
+	u8 aux;			/* bit 117 */
+} __packed;
+
+/* Component Type values (bits 118:121). */
+#define CUID_COMPONENT_GPU	0x2
+
+int amdgpu_cuid_sysfs_init(struct amdgpu_device *adev);
+void amdgpu_cuid_sysfs_fini(struct amdgpu_device *adev);
+
+#endif /* __AMDGPU_CUID_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 472e96ae884e..760103641592 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -48,6 +48,7 @@
 #include <linux/vga_switcheroo.h>
 #include <linux/efi.h>
 #include "amdgpu.h"
+#include "amdgpu_cuid.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_i2c.h"
 #include "atom.h"
@@ -246,8 +247,16 @@ static int amdgpu_device_attr_sysfs_init(struct amdgpu_device *adev)
 	if (amdgpu_nbio_is_replay_cnt_supported(adev))
 		ret = sysfs_create_file(&adev->dev->kobj,
 					&dev_attr_pcie_replay_count.attr);
+	if (ret)
+		return ret;
 
-	return ret;
+	/* CUID is informational; a failure here should not fail device init. */
+	ret = amdgpu_cuid_sysfs_init(adev);
+	if (ret)
+		dev_warn(adev->dev, "failed to create CUID sysfs attributes: %d\n",
+			 ret);
+
+	return 0;
 }
 
 static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)
@@ -255,6 +264,8 @@ static void amdgpu_device_attr_sysfs_fini(struct amdgpu_device *adev)
 	if (amdgpu_nbio_is_replay_cnt_supported(adev))
 		sysfs_remove_file(&adev->dev->kobj,
 				  &dev_attr_pcie_replay_count.attr);
+
+	amdgpu_cuid_sysfs_fini(adev);
 }
 
 static ssize_t amdgpu_sysfs_reg_state_get(struct file *f, struct kobject *kobj,
-- 
2.54.0

