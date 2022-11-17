Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBACFC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 01:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E34510E513;
	Thu, 17 Nov 2022 01:24:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F71D10E518
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 01:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbY1C29KTl3fSbpXHxbVgWp4RKIS4dBijorJhdNfZaPmziWTxaeGqv4Bpy9ur9Wi2RsnS3WXWy+YxG6wY/FTr+jwLAUyjcN/mRlvtZnOm1prda5+rqlUE701U+rCXc9PNiYwLV+r0861DvZwFIOJXmqqpovEwYgDHhKVODhdqq6M+Blpz+eX/BVoBae4HAERVBSuVKmf64xTTbVSsdB7G4QonJa/xkSC3V+pn0NKAsmUdz3b2HV2wes2gR9h4D0JWrfM13fxX4Z57m+uL2N/qcoeVUADsPEY8PVV/VcoF8YjgY0D3SaILpzEXbELixAFSElNazqZpw+4ItoC2FafVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsg9QTm7RQg1NpQlfLul4+TjvDJ+yxRCtDYj3WuVuF0=;
 b=BKOZ5TYqNPQ++QgzDUoEb3844sPM50I7caKW+hE4z+h6nL7rxjFnqeo8wmNXP4I2XvZDStiI5kmXvZyjfXBfj7FQsI/C5uWoTwrh72MIkaZG2lPnfZNdSp3FAgP76aPdVMnsaDTsPocCZGZ4GBwMwwE3wpodf/3xb6gy4vcvb4JTOKkz9bWWAN+sNY+kTZyxZoQIL/SVNs60x42A+eaz3mytvGuXBghbNSpsG+Ct8dOkZOMKEV4tTFKpDrdxsAiaD4k4dqXXF7zgjLE5zRduNBH69hHzt9EBjTf7p0GmZ3UUeVNQOtzeH8Tjjscs3VTXLfKuQp4BEppJiJD2ptIqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsg9QTm7RQg1NpQlfLul4+TjvDJ+yxRCtDYj3WuVuF0=;
 b=Pxa9FmsOO4/oXwEzhLHiEet670hxQkDE3/neSkFDD9rfMPr5K8ns7TRhapVNE3xhzTXjdf/UhDMshDDz5SZIiZrQBmdNLf5L3P/1SM1p9eLsWxcTnYnyQ8oEjuc3JxywJn4hyx7JQhczNqdKGK2vrMx9eD/QhQIfgcmzaZZwnGc=
Received: from MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 01:24:51 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::4f) by MW4PR03CA0191.outlook.office365.com
 (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Thu, 17 Nov 2022 01:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 01:24:51 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 19:24:48 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Bug-fix: Reading I2C FRU data on newer ASICs
Date: Wed, 16 Nov 2022 20:24:04 -0500
Message-ID: <20221117012406.33268-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117012406.33268-1-luben.tuikov@amd.com>
References: <20221117012406.33268-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: c835e419-2423-4943-e272-08dac83a8651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Ls/gEAy2GN+9mnU/PqVrP7EMKwIH4xLXIxzpuZo/p7jjPvK8fj5ng93QKUWCKbqLLDmD0SZNbPPKgHygEziqcrJcENaPNbNmGIaAI2XALyfYtBb/f9twSgdBlg2rdzn8o7MJfDZnkK0xaAG7pgBfErtYLr+wUFo52wAJONJVpRJgoHWptj6ebwGMwU5ttOfW71Dz10fuc3FZuXO3OeIWdBD10jWM5iopNbFFqxyUOSKca/xSDn5bw4rzmWZ5poZX4lE9NBmHG7ayhOn11MTWYQZx2XcK7pg+HuP6a1/vTINjC1HGQF/bhA4Gwq8uh9VXLWUWLLjCNRUJpbAk9wxYX4ChbgQnA6/MfjYwMr43205ZWY0qTh0oQ932xHj9s+b+9DIDLh9uxAMkvQl+zk2TaKzpFyl+icBYUHMSaoA6R6Gg842cLVV8brWLK+Pf8QAy4FUOLKh1rwWlDTYBq5hj2FDvkaHk45Rz01igKbepIrV7ro5nld7On+EyYzUJTZ0S821JyQW0jO+TYTU332DVo4VevLv+lUE5ANefbe/J2Q59RyiDBJmylSDD/7UvAzCGwNA7sw9XRlJ7ZT1L/Ap7MTxRMf3MPHHsddyV1LOJtFesGSQVw8HdbIukVlOGiKKbh5WOPFPyKeVA5vSabiwvejzBiN6PwlTWuT932KYkyQS4Ic/MWvRly9cUqH70rA6JmJNFKtbVwbAL0IqDOeV8okKNUikklli76NP4aK0LaiOVtMBiI2pDyrdcU8SD9jX/x7LigonvFwHuSwk39nMq89V22AffvKY4bh52fLK0qR4SDMGON28LeCdshwub8Us
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(81166007)(2906002)(82740400003)(44832011)(40480700001)(8936002)(82310400005)(5660300002)(1076003)(426003)(86362001)(2616005)(336012)(47076005)(186003)(16526019)(36756003)(4326008)(8676002)(70206006)(70586007)(41300700001)(36860700001)(83380400001)(356005)(6916009)(6666004)(7696005)(478600001)(26005)(40460700003)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:24:51.0080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c835e419-2423-4943-e272-08dac83a8651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the new correct default FRU MCU I2C address for newer ASICs, so that we
can correctly read the Product Name, Product Part/Model Number and Serial
Number.

On newer ASICs, the FRU MCU was moved to I2C address 0x58.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Tested-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Alex Deucher <Alexander.Deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 36 +++++++++++++------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index e325150879df7e..9b2ff386b7c4f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -29,9 +29,10 @@
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_eeprom.h"
 
-#define FRU_EEPROM_MADDR        0x60000
+#define FRU_EEPROM_MADDR_6      0x60000
+#define FRU_EEPROM_MADDR_8      0x80000
 
-static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
+static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 {
 	/* Only server cards have the FRU EEPROM
 	 * TODO: See if we can figure this out dynamically instead of
@@ -45,6 +46,11 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
+	/* The default I2C EEPROM address of the FRU.
+	 */
+	if (fru_addr)
+		*fru_addr = FRU_EEPROM_MADDR_8;
+
 	/* VBIOS is of the format ###-DXXXYYYY-##. For SKU identification,
 	 * we can use just the "DXXX" portion. If there were more models, we
 	 * could convert the 3 characters to a hex integer and use a switch
@@ -57,21 +63,29 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 		if (strnstr(atom_ctx->vbios_version, "D161",
 			    sizeof(atom_ctx->vbios_version)) ||
 		    strnstr(atom_ctx->vbios_version, "D163",
-			    sizeof(atom_ctx->vbios_version)))
+			    sizeof(atom_ctx->vbios_version))) {
+			*fru_addr = FRU_EEPROM_MADDR_6;
 			return true;
-		else
+		} else {
 			return false;
+		}
 	case CHIP_ALDEBARAN:
-		/* All Aldebaran SKUs have the FRU */
+		/* All Aldebaran SKUs have an FRU */
+		if (!strnstr(atom_ctx->vbios_version, "D673",
+			     sizeof(atom_ctx->vbios_version)))
+			if (fru_addr)
+				*fru_addr = FRU_EEPROM_MADDR_6;
 		return true;
 	case CHIP_SIENNA_CICHLID:
 		if (strnstr(atom_ctx->vbios_version, "D603",
-		    sizeof(atom_ctx->vbios_version))) {
+			    sizeof(atom_ctx->vbios_version))) {
 			if (strnstr(atom_ctx->vbios_version, "D603GLXE",
-			    sizeof(atom_ctx->vbios_version)))
+				    sizeof(atom_ctx->vbios_version))) {
 				return false;
-			else
+			} else {
+				*fru_addr = FRU_EEPROM_MADDR_6;
 				return true;
+			}
 		} else {
 			return false;
 		}
@@ -111,10 +125,10 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
 	unsigned char buf[AMDGPU_PRODUCT_NAME_LEN];
-	u32 addrptr;
+	u32 addrptr, fru_addr;
 	int size, len;
 
-	if (!is_fru_eeprom_supported(adev))
+	if (!is_fru_eeprom_supported(adev, &fru_addr))
 		return 0;
 
 	/* If algo exists, it means that the i2c_adapter's initialized */
@@ -135,7 +149,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
 	 * and the language field, so just start from 0xb, manufacturer size
 	 */
-	addrptr = FRU_EEPROM_MADDR + 0xb;
+	addrptr = fru_addr + 0xb;
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
-- 
2.38.1

