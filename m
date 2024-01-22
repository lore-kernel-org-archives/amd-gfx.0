Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A90C46CD2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 21:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337F410EFC0;
	Mon, 22 Jan 2024 21:28:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829B910EFC1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myGk8B1Jdq2lZPXwcK+jYyW4iGxTuZBbXz+tLFTLR/2CxF8EwF0HyvcfhhlrjGP7jq+GMWvU0J43sJ9L2YnwgksizEdlKDUmRQoSnQ2aRf/w5ek+CazJhzqB5/ins2Wo4QTmwlRCNw+jbGmJR0n5ao9KZ/5SYwv6+hYBOHaj1u4R7DOvEU64M4VxXtbx4Q1bRSe/XIo+iEAGbwkFgK0aIGf+UErAxuZmvUiTDRxlW2z7eXZZHSJAMowzeEGvUtaP2jVfqVZJpEoax4ESFQe0EuzDBJMCxre+KK7txlm6K0mPeJQvizm3/dP1q5l6YKZ9cVeYKxfqB97wenn7oDIgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U+5RyWjWlqWc9VIH7pmRREGBLU5MiLGKcZwbDjvWJQ=;
 b=WYb6gEplKCNso06fhbHVwMW0tMysPjPlyb6XGAJre5DNix7jLszwmfA/Bx/awRV4segpWlrcnURaOY7I6Xu4r7dQdv0KczJp6azM4BFhHDUukEZt8DYMmnXVZrtRzy4wG7zZRWbj7SA94k2TjbY8TBGfW5Uk5omTjOLx8ESScaoNeL/LhyyR2nHjKD4lVun5avhjZs9K/4Rl6TBudx5ous1t+I46fghqFOTm854J3P2RBKkz+a6DIvQROqA4Lid4MdSBD3Gy6xfM0aDq/e75y9E2irQqDr6pa2i9ka/AvmF3qwChkd9Bm8Y1k7V9uWevr/l8KfHckqbU5bmx7wbbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U+5RyWjWlqWc9VIH7pmRREGBLU5MiLGKcZwbDjvWJQ=;
 b=B39VIMO2gRUp+MnzUdfxzOtXhsjIs8QVcDwiS8tojRUYMT9v7Dmnf+/EW28C+FwDm9VZ89tVBDEqPmhU/EH1m5yZdQt2TVT4qm3/xug7MDKWUOljuDGNzCRKthX+5oeWD1jGi82Stih9jqiVYR2vmccSAunb0VvBC+H8Im8uCy0=
Received: from BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17) by
 DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 21:28:16 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::a2) by BYAPR01CA0004.outlook.office365.com
 (2603:10b6:a02:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 21:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 21:28:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 15:28:13 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>
Subject: [PATCH v2 5/8] Documentation/gpu: Add entry for OPP in the kernel doc
Date: Mon, 22 Jan 2024 14:24:58 -0700
Message-ID: <20240122212719.647008-6-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a7b271-aced-403e-f8d5-08dc1b910bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrHF3RLrpBsHS7gtoXWHxyIsMiuCgnJ248BPlhtpqwIAlIqAcqOyBThqkTAkZWgfXt3LmPvsabLM+eL+0yx6qnOTneA+sdEkmWMmWftrtTPgRfGABXiBHTEArNClBD3v9VecLeRgCPaZlawb635yDQLKKTu6NYm/ajQS65/KMdeYbNlRBh2uhHf0730unsyaUvrrmj8lgbgYM5wspPhMB/pnnCIKqeBhjITBEatDIDUd37etk1UphJ5jemH+WnrjOmhS6TzHTvsGA/hMY5HKAOYPdlc3E0+BXDTBharMdbXRQyyQwMdc3HhGkw5FWOd7BqhisenA1LmFEbH1vasCRi59wpl3ueKSuVk1Dl5dfAg9/TikfJKgjg6MHqNgh46cABSLxUNzfDU0FIn1USV4FwucyRHltFtObxP8L/or1mIsKO5iJ86lVIQziA65Z9xy7VDpkox6YAAp6KK3LyOcvS5PQVPSTN2/nxW7tuXLvin1uZzpqMEsmfCUEzETEzpuLkj+geoJzyjffMoN+3osWLhvx4jqL5iZZ/zYdDVbWZqa5TogKftfuj+Z4J/oJfmI7+rXbbnhy6etv1ApgWbxrl2I6p0AuVM8n72zocS15Y76o1uw720D74OnExTrPGdHWh6ZqqFjnx07iT3CbREJ5BzGZv3veanDqY1l/mupfeHpFiFA5XU1ASoJ2ca4cn1ChoF4t+FnBi6cGH684llOlLH5Xf4S/0kNdTB7DK4II6WTaQO0y43XyDPUWvFUfLetKfQUNHseJslQpa5LzSxQHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(36840700001)(40470700004)(41300700001)(426003)(1076003)(26005)(336012)(40480700001)(40460700003)(16526019)(36756003)(36860700001)(47076005)(6666004)(2616005)(83380400001)(478600001)(356005)(82740400003)(81166007)(8676002)(2906002)(70206006)(110136005)(316002)(54906003)(70586007)(86362001)(8936002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:28:16.3526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a7b271-aced-403e-f8d5-08dc1b910bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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

Introduce OPP as part of the kernel documentation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dcn-blocks.rst | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h     | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
index 1a223f33202e..5ba3c04c1db0 100644
--- a/Documentation/gpu/amdgpu/display/dcn-blocks.rst
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -52,3 +52,15 @@ MPC
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
    :internal:
+
+OPP
+---
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+   :doc: overview
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+   :export:
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+   :internal:
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index 7617fabbd16e..aee5372e292c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -23,6 +23,22 @@
  *
  */
 
+/**
+ * DOC: overview
+ *
+ * The Output Plane Processor (OPP) block groups have functions that format
+ * pixel streams such that they are suitable for display at the display device.
+ * The key functions contained in the OPP are:
+ *
+ * - Adaptive Backlight Modulation (ABM)
+ * - Formatter (FMT) which provide pixel-by-pixel operations for format the
+ *   incoming pixel stream.
+ * - Output Buffer that provide pixel replication, and overlapping.
+ * - Interface between MPC and OPTC.
+ * - Clock and reset generation.
+ * - CRC generation.
+ */
+
 #ifndef __DAL_OPP_H__
 #define __DAL_OPP_H__
 
-- 
2.43.0

