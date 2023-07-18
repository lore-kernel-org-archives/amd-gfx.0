Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61787EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 18:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC4710E3B4;
	Tue, 18 Jul 2023 18:03:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C5110E3AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 18:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jygzjAD+KU8taJExOeNNGU5HXk7+O/WuvOguVueXI0qaoMq62lLm2pO7ZUDnqrPJ3PC3CwUriXK+Yxb/tM1j0RhXRdfTwnRvIAWiop5igKhnEZARDAPAVaABUpuQ1seOYbIvsk4XzfiP940JoakzhwqJTAy1GbUUXBdYuzhx0XDTP2ngK5VX3+p0/8X5jOOnJot7kd70TTjBV6LMokiccD61LFcosb0hO0t1iFg6vkEE4LNJ8//STKmH+KrdToN8OSUQHkQbtYgV0Gu2XXx6mNVCLVSdSVtdcz5QmhSjWninrNdfYxJy2UPtIAW2e3m+Dzf9GV6kGywVPkw4MAfClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+bTtlVCbsv/LBFs29N4Z2VVvRyOY6YtrT1sSMeaHnM=;
 b=NxVQLN9MiZ0MdiAgd74Z3lCCcx/pnHR2IP66b60b2PyImJJ+ZBRuRMlNgC5ORiDaiw8Wg0B+W67QVvN6JvssFytgZIxkeqOB4Lxm10aisJnqDt+FZjOGZVotOxJAvEOdBvN4cFrigXPNbYVa6TUHaHotrrPmTzSOE2GxcTS9AgvnhFrK2CPfIFVFSZBTY0OiI+91PYAfaMvsZnKPJdLKyNrcdladRITNGF3ZC4N5q9PPdO8zSmvaJlC5gCkBJvDudSrV/jN63VzPfkR8cgoNRryBGzOsRG0MneMtErcupFlzb6ZUNUI78VrVcb4Msy0jNdI2ufVqOjLlDLYhmF/xYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+bTtlVCbsv/LBFs29N4Z2VVvRyOY6YtrT1sSMeaHnM=;
 b=yMmP7nVFQjP7o5+3h9vQDiCrVE8wTzdmPnMZeJoDerGd4HNcTqURCruzxnS+x/oStBWwzNTRZLeFN3kJcSRkCdLs7Yg/kQDBUeOVvG3IGDNu1yVpSeymyFAxuC9iX/U4j7ON1gKItAS9IRQ0WmnKQYv32ogCYJLEhXvAOCHbjyY=
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 18:03:15 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::40) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 18:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Tue, 18 Jul 2023 18:03:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 13:03:14 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Avoid reading the VBIOS part number twice
Date: Tue, 18 Jul 2023 13:02:58 -0500
Message-ID: <20230718180258.17737-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: dc767551-2eb3-4f86-fe0f-08db87b941f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+vgSDTfca3dLucwRibd0DgtuzvAdOLrAt/XBVkh11pzRap4aGgv/xaGLq3h685F0uActN+G2ivOI6sREvAYrVgzNODmB/3t54wmkRqnCKCfsXoy4kdUrwdAMS5B7pXBpSSjFJuPDDCQLmPL+giMz2Xe8iVx4G78QCaMX7wWo/oqlVIiwbFO/ALG0VRMZHhFJpHfvjpnU1Zdq/aISuUdl6xTunaRmHBuNNPV3iIngCrjeIpyiWlGbjarZ2kacR+NFQ864z1f+wC18Z7yJ+n7V/DaZI14w2P2+FsPJDaEh6KyOMXSAEjUZFgK0FJUcgQjh+V8zPeC1n6GEe7Bjb87NLflr5Pf/3zLLbLYzdEswBj+N/S7rYf4Wr4O9aFnW5SNLbw15MZmXrfdcP4vHdMnp8qx/jsmRQfxj5zxLMF+NxAKGCMKmYSiQyOkRIS5Kt3KxNb03IBR/gRykiW+1zBqqA6FIOj3caXsLo2yjjluhLnptA9IjNiqp7V0gC2T1fsSHzGkT2exj5i0W/LMgu1MpJ9tVEQ5KN3+RxPC9oODYDTmOBlP4NXHi9VkiD0JHagx/QimWhQHN5OGJEx+Wk6cfQKIbDUS5sfZxbVslCr8Xi5C8GmflcLCYuGspUeDIZrpkb6158yyC6RgpHByO7O+2XVkjsayM+rcv9Q5dZXWagdzfBHjVKi4eFIt9dfp4E1ZgWqvD6TBaw/N1Z+XEJcV5HtThYOfNSfX1kLAkKh/5uzXTp0uwqx2xNZPUY+6hYkKAyCuSrXrtgbjgY6u5uR/Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(356005)(6666004)(82740400003)(478600001)(83380400001)(47076005)(16526019)(36860700001)(426003)(336012)(186003)(2616005)(1076003)(26005)(40460700003)(40480700001)(8676002)(41300700001)(6916009)(70206006)(4326008)(2906002)(316002)(5660300002)(86362001)(7696005)(8936002)(36756003)(44832011)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 18:03:14.7656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc767551-2eb3-4f86-fe0f-08db87b941f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The VBIOS part number is read both in amdgpu_atom_parse() as well
as in atom_get_vbios_pn() and stored twice in the `struct atom_context`
structure. Remove the first unnecessary read and move the `pr_info`
line from that read into the second.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 20 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  8 ++++----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/atom.c             | 13 ++----------
 drivers/gpu/drm/amd/amdgpu/atom.h             |  2 --
 7 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index f4e3c133a16ca..dce9e7d5e4ec6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1776,7 +1776,7 @@ static ssize_t amdgpu_atombios_get_vbios_version(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct atom_context *ctx = adev->mode_info.atom_context;
 
-	return sysfs_emit(buf, "%s\n", ctx->vbios_version);
+	return sysfs_emit(buf, "%s\n", ctx->vbios_pn);
 }
 
 static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 4620c4712ce32..c9f16eab0f3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -60,10 +60,10 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 		/* D161 and D163 are the VG20 server SKUs */
-		if (strnstr(atom_ctx->vbios_version, "D161",
-			    sizeof(atom_ctx->vbios_version)) ||
-		    strnstr(atom_ctx->vbios_version, "D163",
-			    sizeof(atom_ctx->vbios_version))) {
+		if (strnstr(atom_ctx->vbios_pn, "D161",
+			    sizeof(atom_ctx->vbios_pn)) ||
+		    strnstr(atom_ctx->vbios_pn, "D163",
+			    sizeof(atom_ctx->vbios_pn))) {
 			if (fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_6;
 			return true;
@@ -72,16 +72,16 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 		}
 	case CHIP_ALDEBARAN:
 		/* All Aldebaran SKUs have an FRU */
-		if (!strnstr(atom_ctx->vbios_version, "D673",
-			     sizeof(atom_ctx->vbios_version)))
+		if (!strnstr(atom_ctx->vbios_pn, "D673",
+			     sizeof(atom_ctx->vbios_pn)))
 			if (fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_6;
 		return true;
 	case CHIP_SIENNA_CICHLID:
-		if (strnstr(atom_ctx->vbios_version, "D603",
-			    sizeof(atom_ctx->vbios_version))) {
-			if (strnstr(atom_ctx->vbios_version, "D603GLXE",
-				    sizeof(atom_ctx->vbios_version))) {
+		if (strnstr(atom_ctx->vbios_pn, "D603",
+			    sizeof(atom_ctx->vbios_pn))) {
+			if (strnstr(atom_ctx->vbios_pn, "D603GLXE",
+				    sizeof(atom_ctx->vbios_pn))) {
 				return false;
 			} else {
 				if (fru_addr)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cca5a495611f3..46844082762a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1719,7 +1719,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	seq_printf(m, "MES feature version: %u, firmware version: 0x%08x\n",
 		   fw_info.feature, fw_info.ver);
 
-	seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);
+	seq_printf(m, "VBIOS version: %s\n", ctx->vbios_pn);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8aaa427f8c0f6..5055c14d6b426 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2440,10 +2440,10 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
 	if (!ctx)
 		return;
 
-	if (strnstr(ctx->vbios_version, "D16406",
-		    sizeof(ctx->vbios_version)) ||
-		strnstr(ctx->vbios_version, "D36002",
-			sizeof(ctx->vbios_version)))
+	if (strnstr(ctx->vbios_pn, "D16406",
+		    sizeof(ctx->vbios_pn)) ||
+		strnstr(ctx->vbios_pn, "D36002",
+			sizeof(ctx->vbios_pn)))
 		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0648dfe559afc..4287743e12124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -194,9 +194,9 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		/* VEGA20 and ARCTURUS */
 		if (adev->asic_type == CHIP_VEGA20)
 			control->i2c_address = EEPROM_I2C_MADDR_0;
-		else if (strnstr(atom_ctx->vbios_version,
+		else if (strnstr(atom_ctx->vbios_pn,
 				 "D342",
-				 sizeof(atom_ctx->vbios_version)))
+				 sizeof(atom_ctx->vbios_pn)))
 			control->i2c_address = EEPROM_I2C_MADDR_0;
 		else
 			control->i2c_address = EEPROM_I2C_MADDR_4;
@@ -205,8 +205,8 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 		control->i2c_address = EEPROM_I2C_MADDR_0;
 		return true;
 	case IP_VERSION(13, 0, 2):
-		if (strnstr(atom_ctx->vbios_version, "D673",
-			    sizeof(atom_ctx->vbios_version)))
+		if (strnstr(atom_ctx->vbios_pn, "D673",
+			    sizeof(atom_ctx->vbios_pn)))
 			control->i2c_address = EEPROM_I2C_MADDR_4;
 		else
 			control->i2c_address = EEPROM_I2C_MADDR_0;
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 5f610e9a5f0f8..edbb862c1025a 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1438,6 +1438,8 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 
 		ctx->vbios_pn[count] = 0;
 	}
+
+	pr_info("ATOM BIOS: %s\n", ctx->vbios_pn);
 }
 
 static void atom_get_vbios_version(struct atom_context *ctx)
@@ -1460,7 +1462,6 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	int base;
 	struct atom_context *ctx =
 	    kzalloc(sizeof(struct atom_context), GFP_KERNEL);
-	char *str;
 	struct _ATOM_ROM_HEADER *atom_rom_header;
 	struct _ATOM_MASTER_DATA_TABLE *master_table;
 	struct _ATOM_FIRMWARE_INFO *atom_fw_info;
@@ -1502,16 +1503,6 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 		return NULL;
 	}
 
-	idx = CU16(ATOM_ROM_PART_NUMBER_PTR);
-	if (idx == 0)
-		idx = 0x80;
-
-	str = CSTR(idx);
-	if (*str != '\0') {
-		pr_info("ATOM BIOS: %s\n", str);
-		strscpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
-	}
-
 	atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
 	if (atom_rom_header->usMasterDataTableOffset != 0) {
 		master_table = (struct _ATOM_MASTER_DATA_TABLE *)
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index 0c18398245206..55bf99d5288d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -33,7 +33,6 @@ struct drm_device;
 #define ATOM_ATI_MAGIC_PTR	0x30
 #define ATOM_ATI_MAGIC		" 761295520"
 #define ATOM_ROM_TABLE_PTR	0x48
-#define ATOM_ROM_PART_NUMBER_PTR	0x6E
 
 #define ATOM_ROM_MAGIC		"ATOM"
 #define ATOM_ROM_MAGIC_PTR	4
@@ -143,7 +142,6 @@ struct atom_context {
 	int io_mode;
 	uint32_t *scratch;
 	int scratch_size_bytes;
-	char vbios_version[20];
 
 	uint8_t name[STRLEN_LONG];
 	uint8_t vbios_pn[STRLEN_LONG];
-- 
2.34.1

