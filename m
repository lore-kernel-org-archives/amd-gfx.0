Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5866FC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 19:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E4B10E1B9;
	Wed, 16 Nov 2022 19:49:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B7C10E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 19:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/iutTj4gDBVMa5cLdfZ2Ct1zTfbMrrxTQIRqmjhWNgu8rB2U8zZ+3GRZL6xX5Kb3OsH9yGvlAL8Vb2baRjHk26RWd5DnXlQ0y0jYD3PAwnw8gLrmDPg06eOk2eerlm4dyv+hpus/TyU3V/u5xWgGMANntjgtQ/we83sQeCmocTB0Z988HWA5aWmStRQQL/INJKj5UFO5mTwnysl+dvc0uaNxqe2BdPYVIUyVYVOpHc16IMtNPQBOVga2r6I0JbjYPmY8pvPUEKO+L8hHncpoq2Xj6nCrcCyFvXm+LPqXkHNhu/y1T6Qa4h87H6pBXsex7eLa11zlaklTer1QgYqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A43StJKVRoPX3Lg/RHwkXmyHqSdpXIm3o8qay2lUcfM=;
 b=MtBe920Pc7yixWqAzHXCaBxrDApI3F/N35HoSRbQrW9iDa6HAtRLl5oJ2KZo/j7X/MaNQlGUsJyVZBUTRzcUbX2vHQM3OfdGOd77n/noLI19rMURxglA5NWl228Xf4hffjEkZ80vpz7B76kR0PLfObzt1eDKeOEFVJvSDaz7EhQVabroyzmzJx2L9oRGDc76EXH7UsxecmMSFGVRrF+aLCMBFnRV8HBZ8GJz7rAVB9RHjcRQ412gf2sfQyPQZfnYZrf/37an5kCS3ADctEF6ZhvThELk2IUF27RLvjvwVZNTyuqeYOeefdZIKeLkOG9xFe0LTty9+RTbWndDcx2fqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A43StJKVRoPX3Lg/RHwkXmyHqSdpXIm3o8qay2lUcfM=;
 b=ThlwdPeKRz9c2Cltgh57p1tQk3McJJEI8xPSKezclEsUIuN2Uq2YNmGSFH3a8lxZMBy87LkS5JO4WcMso+ZKLzCPXnSCan1f5sSTdDGWgjpiGk5rUbKZJZcqPRBt6LFeio5+0BM/L307If59gxFuWXXqNgAi3SGwrg4A4Nf1ckc=
Received: from BN1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:408:e2::25)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 19:49:07 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::6e) by BN1PR13CA0020.outlook.office365.com
 (2603:10b6:408:e2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 19:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 19:49:07 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 13:49:06 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Set new default I2C FRU EEPROM address
Date: Wed, 16 Nov 2022 14:48:36 -0500
Message-ID: <20221116194838.15315-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116194838.15315-1-luben.tuikov@amd.com>
References: <20221116194838.15315-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: c670560d-db8e-42b7-89d2-08dac80b9fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNMo8qQgmktBgy74Agx7kzFn0JDoSyPRW32TzHgPnCvk5gn+NKENnHE8b2SZsM/ZAYy12E349+1c8IEAyotHi5kiFYRuoFEpi1wCVfY/WnpgnkYxIkI3wz/CZshshPn7dmGNsWenmyTFcfR9YMq/Br3jBgOXeM5cs9Eu6XPlTnqFQP2x/ngveve/sy1nA+/FxaPfagL9w1PxztYFbXeBvRvNCu9FPWaJy5IqHqjtGsWihfXVcJGT8vnjpi63oFy4I2ZxeiICTf1PT25n6xC3FOQckZiVy6rc4NeF6sTBE0d+b3pcA8TCl1z3WnTh3mnbLDUbSj1GFna5TGA3LouhoyHXJ26vB52OPXN6sFxx4NlxxphLzQ/hjnIAalX/vP7Nz0SbKRcSJ6geJwEDfnveZQMcmvkhmvxYGKFtJ1PXYm1TiIPw/X+VhMKPKVgrtwx4Xq+wi/VJUTrayvx4zBxUXFeBmJMHVmPehQlGkVOnV/Sv0aCyCxT1iQ/LL4QvpJriH7cJmx3mcqcRcyFaZdxh9x9Cyt9fabFAvzvN9eknHLeeVs6XF6eXCFZyiC/tpH0UZlxe33fu4cRDNznS2O2VtcFhjjuwK2remziqo16dg+aq3kLlYNR6xcYFgg21mrAJGi1teaVAxb5832pLcNgNgUnpG3ES4Y8BdCgEN0FwzwI57Vj6oM5Yx+qJh2O2L3Ex2nY3GlwuiMlJ6AsqpvnNp837MEdJ8yqJiBdxOnOwYZDJqoyySS0pk/5MBVqLcp1hPPl0c0zYiz9pUwnI3tRQHSJIJJiSoHV3kyS5f+ZjyroEeIkjBlbk3sif61vBsqID
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(54906003)(81166007)(6916009)(2906002)(44832011)(316002)(426003)(7696005)(41300700001)(2616005)(16526019)(36756003)(1076003)(186003)(5660300002)(70586007)(8936002)(356005)(26005)(40460700003)(86362001)(8676002)(4326008)(70206006)(83380400001)(82740400003)(336012)(478600001)(6666004)(82310400005)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:49:07.4368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c670560d-db8e-42b7-89d2-08dac80b9fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

Set the new default I2C FRU EEPROM address for newer ASICs.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Tested-by: Kent Russell <kent.russell@amd.com>
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

