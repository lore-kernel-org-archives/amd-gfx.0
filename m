Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC480C38142
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jan 2023 15:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CAD10E6A8;
	Tue, 24 Jan 2023 15:13:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4605E10E6A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jan 2023 15:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTRzP6FAY17kqLq+L0mzhkaQ/d6KOiNSzKqsniuyUFCZ+Ckelp3TbsZ6iweos1JWwO4i9HZJ4sIOKhpEMiAcpqJh606H7rS3LFvKtvKvqfUlBaVe9PWVPuGkiWxEqs1W035LsIJuLc4kWLCWINmo2g4LMbx8p7ubALTS5CN+7/+aPrlz25ry8Qq5b+mzEYT/OXWFMwVlKTTjlLqgdvih0tPs3TugI6pvSj9+LnGkWtpoWaHD7R2Pm1B1FoWFtAo3bgU5MSHroQGkhbz0ivVp6f7Vep2ijS5IGqp6P4qkJtwDkMAvTRoNGT2VOTGz7/+M/vlMaAfxNSFRoAf0mS+2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L2kawmHjuMYPDWiCHE36U1K2epQx9M1oS3B0J4Fg+o=;
 b=ZOJQshC3Z58Md2znUmogpPFCfLpvJLsP5scicvk7bpSNLVaC0r7scJrATUQaPfairPKtzB31J6PYUlcp65e3p+xKPgVliZ2vdUUBLxgz74lUwrug7l6mKDfaMj6GRAgHcZGY9uutiKi2KzKXuFcQWgaSz8vSZJuVT0lErGhxwUYkETLPAP/C6ZpzbnmoodZJPiXMxbo/eHi+XcOpJGh5L6I9T7jhk4DOzlU9vd1fcRmkA6VN1q0+R5xyy5R3KlI83FfNiIBepIc1/d4gwpIz9QXbyPeYMUhVOOM0lXQgoAdBvQmPG5QcN0HFH+B/ppWu4fgcH88/ZfmC5Ye6+PfjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L2kawmHjuMYPDWiCHE36U1K2epQx9M1oS3B0J4Fg+o=;
 b=aEYDqKXPKZKulanY4bt3i8d54iJck9VEM/1Snfv0pQSN7IUlsbChs/MI/h/oia/O//60SLgcqMgY6P9jcK/9VfoeAG1qz1APvuFx/Xxb96UY/ydLgdxgx+Dwc8XzZvLFeg1XuKbBftdnJMpUof36vtNjYMSIeFGwDINOTF5udTo=
Received: from BN8PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:60::16)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:13:36 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::d2) by BN8PR12CA0003.outlook.office365.com
 (2603:10b6:408:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 15:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 15:13:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 09:13:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add force_sg_display module parameter
Date: Tue, 24 Jan 2023 10:13:18 -0500
Message-ID: <20230124151318.605240-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc77cca-8ce6-4c82-f008-08dafe1d908f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aK34Z3WrT0/4LI3Ep1hmDXemcslUCJICXYe9mduhbVub0jiCqHpwR7ogiv5yMHHaeZiICpsMGqYWyecnh+zSbyZuSgI2nC/7vCh4vgz1Q1MRSn3ElyvcVWbf1WC6LIzY1uOSq+euS+lo0FBTRqcvEPl2hD0LUqZL0o9UvrBNGYkV7wSIbI7/xBikDrAIIZFKlJmgPtUOCiJqXMpDqGy6JALlc0NBq0jo/2La7HIbOa1yS+zU/R8UlauCr0muQHzGkY5LqmgNzu3tG8jYG16tLMA6hKnL+4i391VYR7dVGsPtTB03taXdL3XTAExSDvRoYnXjfMiKloUPlkkGFZbf0oaAXdnouLpczroRAtPa1fXjvoz584Whn8L7bLlvH5wm6Q+yu2yscSMT1m2bFED8vCjUtymS8iV5VUZc/SdSS9pdNxLb084IIQPU7Hx+GOZLoNTgQ64wpWKjk8uO32effEzUVSJBUgAD9vU7pIVv21W//L6IFp1/P4VlljShGmNnQWeD1bQZdeC3A7IomoJEIqimOJlJsT53Xvc3PtBm9mcGe0xLIlVId0dsO2cIJ9pxj4uDRxw6DDOcHkCn1mE3IYH4l1QBJ+9EBcMjOKe/9tAM0uO8fWq786skq4NtmmkpwMBHssumMGXfxFptAfij+3K68ejyHncQdw25gotPh4rZcw9Nb5+VgUINc6yRafJdWTLgRkKtIZ2RFP6miBt6/lLzBGGq1+/SNIX32Op/uQA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(41300700001)(86362001)(356005)(82740400003)(81166007)(8936002)(5660300002)(4326008)(2906002)(82310400005)(83380400001)(36860700001)(478600001)(7696005)(6916009)(26005)(186003)(8676002)(40460700003)(16526019)(40480700001)(316002)(70206006)(70586007)(2616005)(1076003)(6666004)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:13:35.8892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc77cca-8ce6-4c82-f008-08dafe1d908f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a module parameter to force sg (scatter/gather) display
on APUs.  Normally we allow displays in both VRAM and GTT,
but this option forces displays into GTT so we can explicitly
test more scenarios with GTT.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 872450a3a164..73d0a0807138 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -244,6 +244,8 @@ extern int amdgpu_num_kcq;
 #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
 
+extern int amdgpu_force_sg_display;
+
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a75dba2caeca..bc0eaf2330f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -942,6 +942,18 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+/**
+ * DOC: force_sg_display (int)
+ * Force display buffers into GTT (scatter/gather) memory for APUs.
+ * This is used to force GTT only for displays rather than displaying from
+ * either VRAM (carve out) or GTT.
+ *
+ * Defaults to 0, or disabled.
+ */
+int amdgpu_force_sg_display;
+MODULE_PARM_DESC(force_sg_display, "Force S/G display (0 = off (default), 1 = force display to use GTT) ");
+module_param_named(force_sg_display, amdgpu_force_sg_display, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2d237f3d3a2e..78dc5d63a6dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1515,6 +1515,10 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 	}
+	if (amdgpu_force_sg_display &&
+	    (adev->asic_type >= CHIP_CARRIZO) &&
+	    (adev->flags & AMD_IS_APU))
+		domain = AMDGPU_GEM_DOMAIN_GTT;
 	return domain;
 }
 
-- 
2.39.0

