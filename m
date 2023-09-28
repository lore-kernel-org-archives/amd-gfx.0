Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE265CE7B05
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 08:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9517510E5EF;
	Thu, 28 Sep 2023 08:33:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFD710E5EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 08:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMAGvATy1A85YZLyMx5lNS+GpYHTdUkdog4Qz+85ZsGP1vCeE/WO7PJmNbSdFUlRSiGCXjJGZ6LVtYj2gZA2lll9Pd007x/oBfru8XbrarvhkJZgBkAs59O1I/HK527oyoiU+kbtObNiFtO9oLvXYSKNYR7u7nZuXwHHqgvGkEgYCRL1qhu6D1I8u51CPdkBJ9ix8ANhAsoaQszQEhbmn3UVzqhjxxFdenf4l9yTU6FjVJQsGAKR7W7gLgOoDT28k1dSYQ01WtPLk+xyS8sc/XW5zXJtGVo0EQeJ3qGvkcZ/K5p8lMl2YCJZV8dD68HINqTJ9VgUHQ7m6rFLzv11Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtncX1e/RD940kYmhvr/LfnQqDrDAgdLjXdwDyym5ws=;
 b=eh7jfQp+e1avNlhFQ2C5HjVPirfcNOLpEsyJAdMw0yLfWaiiBYYZ3QyW30YoaoTeMSrZ6+wNwT3lWJGCgITPC+HwxUYKgp+hHbur7q7N4s+lXMV72rQUnEcL6h2ocSern8Mf1e/BSnAp6y06X/affB8LBIMkv9KlAfWS/qaypz+qfnIqFVZZcVjmjYmtX7pNV54HJAm5El+Y8OglPQBGl5SjYgxrsByvHuf3pUOJdD8TiORNNp0dDG86Uaf4+OfMUmH27gQrhTXsdJt/pELgYqxYzVxhQGhyNCrE7G971xJvppGooS9nSDwwAI0ye802k2mP4VMHUQe7I77H8uTeIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtncX1e/RD940kYmhvr/LfnQqDrDAgdLjXdwDyym5ws=;
 b=SIa1kGmJHI9wUww0QIBWfLZ9nKlpub0sJesJ3G+bmAruYlziZo/fSS+G79VnxunBYVo93jUXtFqckH3hJ+AVU5wzbY/dxCuO3LPCkq2dlXd4pBgLFQrofwTd+DsLhyZzLTMRqhg4NRJgXqTqmBwxCN1ObOcb8USOTZYSVqZQYCw=
Received: from CYZPR05CA0027.namprd05.prod.outlook.com (2603:10b6:930:a3::10)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Thu, 28 Sep 2023 08:33:29 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::6) by CYZPR05CA0027.outlook.office365.com
 (2603:10b6:930:a3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.12 via Frontend
 Transport; Thu, 28 Sep 2023 08:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 08:33:28 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 03:33:26 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: enable S/G display for for recent APUs by
 default
Date: Thu, 28 Sep 2023 16:33:11 +0800
Message-ID: <20230928083311.2858681-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed04145-4ad2-44ae-2e47-08dbbffd974f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QdIYVuPNN8ZQPQtaHNIiaFkDAhS/CCoABJpXjOKkAH11EXo3dyD4k8NJNA+S8pRLts208x6M9xUr+eLpJbYNvQHESHT1FYLnGlR5bUGG23gDPHoUpX7WUQCERBCgNUU3CcsA/Wjitgedtrd35ZmjVemsUnLWaZfCXjJv6QsVxWkQJn9U4NyvApkv+Z3eAEz7RA0WVEXZ338RNk8pn5NbbzrrySpizWtQUTOn2z4yCnlwEjTokWzBVS7IFUdtRTg41FSi4nJAYXmn7MiVHllvb6hFYE6fvYO21IHxXVM1f63XKPDCYpjSOcRfj7XJDxJt70d+UykilXcGTIHym5ldzmWIRIWqu5i1W7yX6WzHeIcZx3/u9EARPMFYYXJGDdtgqaqyIhenqnCYagE8bjcBFVjpDkIvYhzPk/SKhYYs+SsNhKxJJf+NzF3p7iQEQaiaDokEIlFlFsEXsAVzUrGApYfGuUGejLD3onSdZ5oyF2IfV3nfcHXIp9c5JqYvYHckwjy9I2m3NCHfH8wDomGDRuMCNopcU3dj+S7QRDnsNXgO9MgeGHoyHbPEQi3ozxxRthc0E1Lf/IC3HCTnjfHctfLgRbNohQACqrJmAQD1aCmciSQFxks2Z6OeIk6oaHzC5nVecwYOPLIgBzEl1mbeDro0voYW21LIz7QTT4ND4isvTaxRGk/SiZ9qbBVRomeaGoNdVu8/q/OY6wfA8W9H5nE0L/Hwlengem2OO1tRjL0UECnFhXKUIZgVrFmxallqee72RLirOmxDA+0r/xgUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(70206006)(4326008)(40460700003)(2906002)(41300700001)(6916009)(316002)(40480700001)(36756003)(8676002)(8936002)(54906003)(5660300002)(7696005)(86362001)(70586007)(2616005)(6666004)(1076003)(36860700001)(16526019)(356005)(426003)(26005)(81166007)(478600001)(83380400001)(82740400003)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:33:28.8143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed04145-4ad2-44ae-2e47-08dbbffd974f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Harry.Wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With S/G display becomes stable, enable S/G display for recent APUs
by default rather than white list.

v2: explicitly disable sg on pre-CZ chips (Alex)

Co-authored-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 47 ++++++-------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e5dfdee22e6..8963d9c251f3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1627,41 +1627,22 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		break;
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_CARRIZO:
-	case CHIP_STONEY:
-		init_data.flags.gpu_vm_support = true;
-		break;
-	default:
-		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-		case IP_VERSION(1, 0, 0):
-		case IP_VERSION(1, 0, 1):
-			/* enable S/G on PCO and RV2 */
-			if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
-			    (adev->apu_flags & AMD_APU_IS_PICASSO))
-				init_data.flags.gpu_vm_support = true;
-			break;
-		case IP_VERSION(2, 1, 0):
-		case IP_VERSION(3, 0, 1):
-		case IP_VERSION(3, 1, 2):
-		case IP_VERSION(3, 1, 3):
-		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
-		case IP_VERSION(3, 5, 0):
-			init_data.flags.gpu_vm_support = true;
-			break;
-		default:
-			break;
-		}
-		break;
-	}
-	if (init_data.flags.gpu_vm_support &&
-	    (amdgpu_sg_display == 0))
+	/* APU support S/G display by default except:
+	 * ASICs before Carrizo,
+	 * RAVEN1 (Users repored stability issue)
+	 */
+
+	if (adev->asic_type < CHIP_CARRIZO)
 		init_data.flags.gpu_vm_support = false;
+	else if (adev->asic_type == CHIP_RAVEN) {
+		if (adev->apu_flags & AMD_APU_IS_RAVEN)
+			init_data.flags.gpu_vm_support = false;
+		else
+			init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0);
+	} else
+		init_data.flags.gpu_vm_support = (amdgpu_sg_display != 0) && (adev->flags & AMD_IS_APU);
 
-	if (init_data.flags.gpu_vm_support)
-		adev->mode_info.gpu_vm_support = true;
+	init_data.flags.gpu_vm_support = adev->mode_info.gpu_vm_support;
 
 	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
 		init_data.flags.fbc_support = true;
-- 
2.37.3

