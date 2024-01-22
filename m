Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4145AC46CD2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 21:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50B810EEDB;
	Mon, 22 Jan 2024 21:28:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B26E10EB34
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQ8mCzhlHhNOh5tSLA2nIKfgEmSMKLbBw6RqVj1VvH0zZOH56GkaI6rwgYBSQJXO6oYkwA69XlunC9yJ2czYmRRPKptH6yzO8DwoU3gjeL2kZ6NwOu+wZQOoQSKIoen9z88AjFlwBiHQjAj6XEdWbC/jH5/2AWmQtV/FJjk66/YVzBrvNwLA+nLTuE9iK2VG4yU/ulk0KiBfbR2QbO4mv7vNA+k7i98VzSX0HNEwBVHcUZ15JJWku7gtUNg4YKO0zUako/Up33Hytp8xRzuhCP8d7VG4LbGbgFbWfUYw32KEEjSKODmSz8aeARljfEtxwuby60FZjYpyD3QbJaVqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie7l3ZoGIktIvy7iKnLuWk+uMd0Pe9pUJswOhWIgrrk=;
 b=JqHnyye2C+ZqXUMVM/IppGtHD3yA3sS/S7dW6j7xp/l+VExiaRAzPaW0Gbd2xjx5H5VAkBSrB+zaYvAHG4IyhksNuMrCSAuXS2B0BLAEglj7pcpYeg+eEWh2MwlcRxN0hp0fLSrWzOJG6Hh3FEa0VQO8TC8HteeDBOfH3ir0USuqr/EQJgzrfVaf7h8Axk2M1c9qe+h3rNKu9A45iI5IFZ16KFDRIihyCONWrzcAQ8PDYPXkVAlGydkPHyT8B0P74ihigiWWgFvgiQuOVbXDgMDqIMSW8Hrmn3TzF5u1DNUnvL9ov9z42F4viJlnZf5TdBY7pFFJzRW2G/x2xLDWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie7l3ZoGIktIvy7iKnLuWk+uMd0Pe9pUJswOhWIgrrk=;
 b=QAmftPvU8Mi37Lvm8hcEjeV+oHr0DIdFgRyGcz6NP8WdPQ1K3Lr4Fi67J4WxOHRTOaFoQMtV+jQ44hJwgdnl4ElLBM1bijZFff/VV+dSJc2YjineT3/iqxBfv4Erh5uYo6yqWems6fVTIMwVt2Uo6NxWmFUkVvjSZaQ1TjVkIj8=
Received: from BL1PR13CA0200.namprd13.prod.outlook.com (2603:10b6:208:2be::25)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 21:28:09 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::14) by BL1PR13CA0200.outlook.office365.com
 (2603:10b6:208:2be::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.19 via Frontend
 Transport; Mon, 22 Jan 2024 21:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 21:28:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 15:28:07 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>
Subject: [PATCH v2 1/8] Documentation/gpu: Add basic page for HUBP
Date: Mon, 22 Jan 2024 14:24:54 -0700
Message-ID: <20240122212719.647008-2-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f993e5-c3c0-4bfb-7e2e-08dc1b9107e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2WlGr7gAGhdm3jd4wVgSBb2fy5z55vD+Q3IbsNqJcHa2mgDSm7ynejYdMa5kLBcVqMZPxxoXws1OEWRalm18rK75j6Av22q2hH+9L/KSoMChYXxYM/zxDCm4vw54W92EEshHhKVjZljN1VHu12wKzJNpWQSNz9O7snKNwsyBu7pSeOjk+86lA9wXtfno4wFMtVQCWjSmhtp4Yrm3qcwOwBVyqHKk/SQoqajspczg57VYFgxUXNSsZX/bAmV4Sym6+JXPH3LDKAeKkSW4W2Yp6mlOMbslop/65/nby1EhSqTrgWoPWW6wf0h98nR6EIowfjLKGpkGm+6rM6Mwsl9uopzEQ6XwkYdBDDNVzSqcfnODrLtFcZF6Ixa1URCefJlxhl+CIGAagFw8hkyESQFn7uA7Y94YeZ7WeC1nPgPV+6HcLoR2qWLNJBzeFsANjM+SSMpSRz92LZFG66zLB/f3kOmWQWo1yQ/cplpE9s0MSNUFaZ8K6VUIFIcJC17wbvt6NNgrhAd8OUeTH/sITzEmouQ3z+J0IqSYn2kQ/P8A/cUC2F+dJ4ET5gbl8HEdmDPQ5viSj5vzbfhZd5YyczRNY2u2+Fud5sA2Cmlv1hfPRtDWMMQFeQO6HzRcMHTRpOY2p6Li635Q2DWzk43R4AU3P84truHlQJaoJQrTiFxSwHTFIzqR5I1sRg+JWJ0+QpCQlgB55Al5DlVdVuHXWMaETxC0rdvFiZXC1dK3k1FAjMswrFjmy08yOLbZXTyJEhaI0+pYAcT6XG6g5+hebH/xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(6666004)(478600001)(36860700001)(36756003)(41300700001)(66574015)(86362001)(16526019)(336012)(26005)(426003)(2616005)(1076003)(83380400001)(47076005)(2906002)(5660300002)(356005)(81166007)(8936002)(8676002)(82740400003)(4326008)(110136005)(54906003)(70586007)(316002)(70206006)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:28:09.5962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f993e5-c3c0-4bfb-7e2e-08dc1b9107e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
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

Create the HUBP documentation page and add the doc references to extract
the HUBP code documentation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/amdgpu/display/dcn-blocks.rst          | 18 ++++++++++++++++++
 Documentation/gpu/amdgpu/display/index.rst     |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h   | 13 ++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/gpu/amdgpu/display/dcn-blocks.rst

diff --git a/Documentation/gpu/amdgpu/display/dcn-blocks.rst b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
new file mode 100644
index 000000000000..5da34d5b73d8
--- /dev/null
+++ b/Documentation/gpu/amdgpu/display/dcn-blocks.rst
@@ -0,0 +1,18 @@
+==========
+DCN Blocks
+==========
+
+In this section, you will find some extra details about some of the DCN blocks
+and the code documentation when it is automatically generated.
+
+HUBP
+----
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :doc: overview
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :export:
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+   :internal:
diff --git a/Documentation/gpu/amdgpu/display/index.rst b/Documentation/gpu/amdgpu/display/index.rst
index f8a4f53d70d8..b09d1434754d 100644
--- a/Documentation/gpu/amdgpu/display/index.rst
+++ b/Documentation/gpu/amdgpu/display/index.rst
@@ -28,5 +28,6 @@ table of content:
    display-manager.rst
    dc-debug.rst
    dcn-overview.rst
+   dcn-blocks.rst
    mpo-overview.rst
    dc-glossary.rst
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 7f3f9b69e903..dedc5370023e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -26,13 +26,24 @@
 #ifndef __DAL_HUBP_H__
 #define __DAL_HUBP_H__
 
+/**
+ * DOC: overview
+ *
+ * Display Controller Hub (DCHUB) is the gateway between the Scalable Data Port
+ * (SDP) and DCN. This component has multiple features, such as memory
+ * arbitration, rotation, and cursor manipulation.
+ *
+ * There is one HUBP allocated per pipe, which fetches data and converts
+ * different pixel formats (i.e. ARGB8888, NV12, etc) into linear, interleaved
+ * and fixed-depth streams of pixel data.
+ */
+
 #include "mem_input.h"
 #include "cursor_reg_cache.h"
 
 #define OPP_ID_INVALID 0xf
 #define MAX_TTU 0xffffff
 
-
 enum cursor_pitch {
 	CURSOR_PITCH_64_PIXELS = 0,
 	CURSOR_PITCH_128_PIXELS,
-- 
2.43.0

