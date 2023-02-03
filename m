Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8031C64EC5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2093610E89B;
	Fri,  3 Feb 2023 19:09:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C1810E89E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzt9Z6I0BZSSWb1WcG1QzPg2WWE3junoVJhZd4TVwwVyLYTucGtHDX8i38keInxJUTBgtIozCx0QGvUw3D2A9Wn5yi8+ruxp9pucmKe/1Ru+9OrOH8fIY21UCyWHap2Qe9Y1DyUsqReJLYNbGLU0z8JzUGyYOCw7PEBRlX0vobOpAvBkks+Zz3UV/ck2QO4ujT9GmLsiHMg2eUOVsllPsRj+ZA5BbHORxSiio6PJdoEAWycDgE/oMktO2m1gR/AvWLmgO+dbe1EzpmczC8pcvkn4+DoYfMoVMZ0DHzowQgKtJmsaIF0WnZPN3p0sXVCHib57rbQE1yjU/dYmCBjt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A59leZToDm8833jlrzatVrWzDprwz1F+8QvW8k/lwss=;
 b=BGe5Qq4ekob/AfIlE8JJlp3NRStgEsr/mdIrxYsjbgNIDEwBoPF+CCqWCnbD5qSckmCIUzkocXMDZEHHNADgNE1ROQyKf0V66VOtiANHz/Qp+h7PjjmOX4iAsZau310a3Bce14l5rrcq/y3vrLO5OmvUK1xvFr6JUgTMJeiffu4P4uL547zBKGLj61KlVKpbdiJx6W5LhykChRnIyFKg4Jyb2BE1pmmcWZNOHyqKqAfaErYf5N0d/jm7mGl+vFlTcTYyMU3YWp4dysCzVqrFUZ0z8W5TYH6SbUsZ431QUy8YSVlo5+reQP4nU8/2whkV1EgyBYZRe196fPcU6dzzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A59leZToDm8833jlrzatVrWzDprwz1F+8QvW8k/lwss=;
 b=C/mbc2M4LhRkqSwMk78AxbLa7vm2xtstGMj2xWst2A9/vfsobH2kKiwR/tCb+bmkWinAwFdhvX4yvfyI2Co7OBUt5Sam4Kk5qVGuamCXeeWnqoC1/xoRLsHbgWU4nJyyjd/6xsOkufiN5RKetxT0klTfpNcwznuBfrFoq5BMIuw=
Received: from CY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:930:3::8) by
 IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.23; Fri, 3 Feb 2023 19:09:23 +0000
Received: from CY4PEPF0000B8EB.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::8a) by CY5PR20CA0021.outlook.office365.com
 (2603:10b6:930:3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EB.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.15 via Frontend Transport; Fri, 3 Feb 2023 19:09:23 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:22 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amdgpu: move doorbell ptr into mman structure
Date: Fri, 3 Feb 2023 20:08:25 +0100
Message-ID: <20230203190836.1987-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EB:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c85b3ed-114d-46f1-da28-08db061a296b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1USf4YEkJ2oWr6w9xcVOF6JdNGZrbsJCEdUSK0szB6t4WcWduNHQy/jC0ZcYUSxtMXPi2ZLUk0EMv8ZJ+Fw3nyPi/01VlRu51wpEUSekyhK850XKiKQ9i3tX5rJ+gHT13zptqdinchTAc6Av5SCL9ZqQsYFEv+G36Gp/XCb2ZUZ2lg3iZuNfDBlcPDTk1t2dDsTbz86wwbyCfzA5Bwg/ZWlNLqY2C3txR9p2o6MOZVNGIuYGtW7cA6OlTJ8o7RYZcblES77FMdatpDg2Y64xanklL9sOzQRsAHbxMEY+K43XYuM+Mxb+Np9wEQIqooU5bwOjkQMcUqwqQszGECmlwSyG8xrAxNviR5Z1/M0Bxf1L2q+qDomc4C9+LHhpeLL28+DvItgT7S9aYL/FyY45Jqwr+iT2uPT64dqKzKF+NAQga4BMTn3/Ma3QTrIgVpo4Q/hVqsuz0yqZXFyuUlRFwvnlCSzZtWiiKbrmfHOPS/Xw+cM+q5ZNx0AJqJFyTU4d17KuUG530vDRlI9WrP1TtEJ1qdKcn93SHkChGFm8cRJxTeUalP0GEsu0nIfRYXdX57k3L9ATNA0h4mmfXE9qw4RwEa8OGnafZeo0P+hcrynsG/pec+srzubzrujS6Ulr2NbWPjQISpgn+RDWL7euppEhIA5Mj6qh9D7yyylLd0uOH3QR5HaemUdd3fvf1rluO62xg/Az38sYg7Gzr7KJMPfzVFDpCKGta2pxz1ZlQ7Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(54906003)(36860700001)(316002)(5660300002)(8676002)(36756003)(41300700001)(81166007)(40480700001)(40460700003)(70586007)(6916009)(4326008)(356005)(8936002)(82740400003)(2616005)(70206006)(478600001)(186003)(16526019)(82310400005)(26005)(44832011)(86362001)(426003)(47076005)(7696005)(336012)(1076003)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:23.5657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c85b3ed-114d-46f1-da28-08db061a296b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch:
- moves the doorbell.ptr variable to mman structure
- renames it to doorbell_aper_base_kaddr for better readability;

This change is to make doorbell's ttm management similar to vram's.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 22 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 16580d9580d4..cda5387aae50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -597,7 +597,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 		return 0;
 
 	if (index < adev->doorbell.num_doorbells) {
-		return readl(adev->doorbell.ptr + index);
+		return readl(adev->mman.doorbell_aper_base_kaddr + index);
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -620,7 +620,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 		return;
 
 	if (index < adev->doorbell.num_doorbells) {
-		writel(v, adev->doorbell.ptr + index);
+		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -641,7 +641,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 		return 0;
 
 	if (index < adev->doorbell.num_doorbells) {
-		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
+		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -664,7 +664,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 		return;
 
 	if (index < adev->doorbell.num_doorbells) {
-		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
+		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -1038,7 +1038,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 		adev->gmc.doorbell_aper_base = 0;
 		adev->gmc.doorbell_aper_size = 0;
 		adev->doorbell.num_doorbells = 0;
-		adev->doorbell.ptr = NULL;
+		adev->mman.doorbell_aper_base_kaddr = NULL;
 		return 0;
 	}
 
@@ -1071,10 +1071,10 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 			adev->doorbell.num_doorbells += 0x400;
 	}
 
-	adev->doorbell.ptr = ioremap(adev->gmc.doorbell_aper_base,
-				     adev->doorbell.num_doorbells *
-				     sizeof(u32));
-	if (adev->doorbell.ptr == NULL)
+	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->gmc.doorbell_aper_base,
+						      adev->doorbell.num_doorbells *
+						      sizeof(u32));
+	if (adev->mman.doorbell_aper_base_kaddr == NULL)
 		return -ENOMEM;
 
 	return 0;
@@ -1089,8 +1089,8 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
  */
 static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
 {
-	iounmap(adev->doorbell.ptr);
-	adev->doorbell.ptr = NULL;
+	iounmap(adev->mman.doorbell_aper_base_kaddr);
+	adev->mman.doorbell_aper_base_kaddr = NULL;
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index c6324970eb79..464be28da4fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -25,7 +25,6 @@
  * GPU doorbell structures, functions & helpers
  */
 struct amdgpu_doorbell {
-	u32 __iomem		*ptr;
 	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index ea53aae3ee0b..243deb1ffc54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -52,6 +52,7 @@ struct amdgpu_mman {
 	struct ttm_device		bdev;
 	bool				initialized;
 	void __iomem			*vram_aper_base_kaddr;
+	u32 __iomem			*doorbell_aper_base_kaddr;
 
 	/* buffer handling */
 	const struct amdgpu_buffer_funcs	*buffer_funcs;
-- 
2.34.1

