Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF46AC47DDC
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 21:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 814BA10EFD5;
	Mon, 22 Jan 2024 21:28:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D0710EFD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJAg/JHpUqH+4OJY2tOBGLRNSF1oM3DJ/YZg5zLkXw2H66ijPA9JSE5C8x6FUnqn9+mZDl196Hxj2TC3DUmtMFgdw4Y41ACpJEO9EtzHdIqAWBJmGkGVYuSDGHA1WnV9buY+SCQQb3+lkCO/cs3RYE+UaRQUhXz6pEw0Vp5VBn3YCqHfEoi8SiniPWjNqyDw2JsakQOqCrjacyNMBrNkvxlksKYicoK9aM4fDiSIXImYx1uUpXwUGT1YPHCuLDQV5PvFhqR87kC06/hl45VGvUqrUdplW+LaKvk2qa2z3js8l9yAQ2LnXPshN/3NXhX6KqZRX/Pnva3rbyAOIvBV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I8498vv9fGKGOIPkOTrREV8cU9IFgnOW0SOUNxmczE=;
 b=bJ9xb8ehzGRntl8oCWZYRHn4PBbkgXybNCizNQLk2hH4LgxS4PvHiQD5DVNRokbIWRQOaDqFjPL6+YMDXH+C5NG+iNtrEFdb39RgrQjWV2tvy951kRv0vet6FfcVjq+cj6xWaj1+LKeHMa2ZZdGG1XPINCcuaPDLxsy+9VZkAaNMM+brivC1HP1EeMetsmxW6pjFU64PzXR3EZ30TebTvVUMyRufQAuHEbFUeIXmVTDqnumaz+J8pqwuSoVe4grmhNgi8dHfhFRUHYbwF0fqsH38Q2gkvThjHQ7cbChIGSg/YHnP6VRD+XSF9MH8yXI9lBlGOqbLKIVp7VKETBkSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I8498vv9fGKGOIPkOTrREV8cU9IFgnOW0SOUNxmczE=;
 b=Vh3hg96uqMpv/QgF3QvI3lvRqCdm7khWhK/0PnXEYht10TgjEILKzCk0dJjAIUbtd03yEC+FxwqgTwQfxCLnlNr8FP/7781OD6ZJLuD5iS2LGZxGqIH+hoySdl7EeSc2euaVF1tfIKadDCuTEveSQF03PWJNDB5sR/al0uipgRg=
Received: from BL0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:91::35)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Mon, 22 Jan
 2024 21:28:13 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::f4) by BL0PR05CA0025.outlook.office365.com
 (2603:10b6:208:91::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.19 via Frontend
 Transport; Mon, 22 Jan 2024 21:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 21:28:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 15:28:10 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>
Subject: [PATCH v2 3/8] Documentation/gpu: Add kernel doc entry for DPP
Date: Mon, 22 Jan 2024 14:24:56 -0700
Message-ID: <20240122212719.647008-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
References: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce89a30-8921-4cf8-9c21-08dc1b9109d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4h3iEqerj30SX6NlNUJ+oGFOIRrfxOsfHV6cJmaOPDN1aEWoeHwzxuxmDBGF0HUohvqLlpEN9Xh5KsJc8Nulzx0ihKO3njWriYC+4VdnGs/5KWSyuAR9l6OEyYIi9K7WFWRrj0Bvwq3i1cp0zzNsceXgECZKlanxfypVKiXoO2v2KylLx60bjAlMB70gyVVpljeok0qi9NhfxcLjzBG3h+A5c6Lw1AYr1QzVf/3iph05lH3lujzrXSuSsUH+Wd6GqgHGHNDRnDcNHBbAlNmTWSoqKn/4Rnh02sI7f9DvxWIYinNmeDFm4vDtuKTnB37p2QB1NtTXf4J1VCWP7H6rQqSNw4bQkfUdxTMNbrOrjqrrckZZ77DOA3wQJ52YD1ApEliDSO+hBvoarnlJ8uB+RkBB9iPWB5IPi7kAdJYUFt6dX4n7owJG0/RphCtfBK/YF7dEn/IAT3HmWzZoWYhVnP0T97qgJDSTbOkKkAXpmkh8oBTb/lw3X0AOgNKYGW4G3mDxdTUNLNb0p4Zy4okBdVqkc9DtJvSTJxI49K76uudT6IMb6EGaGY+EodzWgPKRDs4k4TB5bXd4jIE8yx7xQRaYVWpP9O/Jx0aqg34VS8UlWxdS+YUvFewiZsyzhvj5EtU+RHMniU0INlxp/eQaK7UTT2T60IyPbTkq6iO42a4lAubIIbjdTj7WAeHU2bxgQGcjTdbqYWbaJlJeGWUroWAPR84Xyj+aEXWOiQekjhbV61ljgv7OH34zE4Kz28GfgFR8O/G1fRGF7mgAPTELUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(81166007)(40460700003)(40480700001)(82740400003)(356005)(1076003)(426003)(70586007)(5660300002)(54906003)(70206006)(8676002)(2906002)(110136005)(26005)(336012)(4326008)(316002)(8936002)(16526019)(83380400001)(86362001)(6666004)(2616005)(47076005)(478600001)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:28:12.8304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce89a30-8921-4cf8-9c21-08dc1b9109d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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
Cc: Harry Wentland <Harry.Wentland@amd.com>, Rodrigo
 Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit introduces basic DPP information and the struct scan for
code documentation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/display/dcn-blocks.rst         | 12 +++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   | 26 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index e4e0a4ddca4e..83fc4a03113e 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -28,3 +28,15 @@ HUBP
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
    :internal:
+
+DPP
+---
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :doc: overview
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :export:
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :internal:
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 4e604bf24f51..a962a9f36845 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -27,6 +27,32 @@
 #ifndef __DAL_DPP_H__
 #define __DAL_DPP_H__
 
+/**
+ * DOC: overview
+ *
+ * The DPP (Display Pipe and Plane) block is the unified display data
+ * processing engine in DCN for processing graphic or video data on per DPP
+ * rectangle base. This rectangle can be a part of SLS (Single Large Surface),
+ * or a layer to be blended with other DPP, or a rectangle associated with a
+ * display tile.
+ *
+ * It provides various functions including:
+ * - graphic color keyer
+ * - graphic cursor compositing
+ * - graphic or video image source to destination scaling
+ * - image sharping
+ * - video format conversion from 4:2:0 or 4:2:2 to 4:4:4
+ * - Color Space Conversion
+ * - Host LUT gamma adjustment
+ * - Color Gamut Remap
+ * - brightness and contrast adjustment.
+ *
+ * DPP pipe consists of Converter and Cursor (CNVC), Scaler (DSCL), Color
+ * Management (CM), Output Buffer (OBUF) and Digital Bypass (DPB) module
+ * connected in a video/graphics pipeline.
+ */
+
+
 #include "transform.h"
 #include "cursor_reg_cache.h"
 
-- 
2.43.0

