Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE2AFA0C3D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA23D10E6A1;
	Wed, 15 Apr 2026 07:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hfb+45Vr";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8454510E6A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z80kUHkh8ZWCqT4R/zM+Sj8JUl0kPHjFXzZgbm+dYNx5oZIN9lg/GIwGxQwaLZBSPAzU6YUWKq7h9ejM78Rdsf/KIDbDXoCA/ETDDaU/Q/Tg0h2883CldDt6BMPCoLGfZPKc52VE7dIsxKNH7sgy6dVfrvtq0DFZjjHN5ddwzoLpb9BtG+42f42DgXCZrTvemQ6WAND0h81AGtmrFZXFJp/AgSDgiroj2sF1wGAVWyUprNwJk7buU7EJZCUQnqJSw1jiK0A+/5NVACa2nPxTlCCWH6g38to4wSNguU5k0foLXbRjZHJ+dYTGMkUBoPf+6KZZPgw4UrTaS/+tF6Od0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWUopTMA6/Eoss1KpO5Li68QBIhQrR7bjXG61LsHiYg=;
 b=gMUJKqgevR5FlzcEOpCuazq/HDOIsYr3BgliaB+5fI1NYmaUFExUNFioJV3M8aJelH+y5I9JRd8TeHwFBYCeO6khoFQvNLnzF9gWt7ioq47BbVE1ssGJZKzu1SKMhgiDPnM7B2HkkcuT55KXxdQqstm6o6y0pER1tSMG6Jn5NshFUBumbRSCc+uXLoFCJHHLBFzTGz7eFcTtpjRwGlkopaKw39UAB3JghAofIq94euh2+yz3x807CZJF+BmB5W81hTAGbv2oTvZNy36WDvDRStXNVTzI9bOAjhme4VmlnexplgHTwqav85IIY+ENJ7m08uCTjbXepgXksbyulWJawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWUopTMA6/Eoss1KpO5Li68QBIhQrR7bjXG61LsHiYg=;
 b=hfb+45Vrmniju+9+En2HewzpFwHd6zThi6WGv48qiVSmEbbjrXhFqzFtD0Pzv7ZPVm/GBUePxsaZonIMe3blPqfRb9Nra9bynQRb+F5vZUGBh4y6Gvzky9WHAmWeQTuHq8F33HMu6+OGd6IMgyPPtKFnM489wpoaNY7IyoZ0MTE=
Received: from MN2PR04CA0027.namprd04.prod.outlook.com (2603:10b6:208:d4::40)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 07:44:17 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::4) by MN2PR04CA0027.outlook.office365.com
 (2603:10b6:208:d4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 07:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:44:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:44:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 00:44:16 -0700
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:44:12 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Samson Tam
 <samson.tam@amd.com>, Dillon Varone <dillon.varone@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 16/19] drm/amd/display: Add README.md file to DML2_0 repository
Date: Wed, 15 Apr 2026 15:39:55 +0800
Message-ID: <20260415074223.34848-17-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f6fdb0-dd7e-48d9-58bc-08de9ac2cc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SjqhNwcZuhiX2pSfD9PXLUJlw96F1T1DY2g60q6JNNA734sJ6g96TqWE2vGUXOvOCcVW84gVD+tXQoe9jVd9izxkVNaHq5HQUYP4Wo5e37TkwlYSFb+qyvU3qnfS7lU7LJetgwSiFIABJTATV/EVLkTk+OYnsw3RlyDiW6AxlVfEBWkNq8Pluy2S+t5j3TNri+Ly5HAHR+3fZyd7aswU4ydxX/RoANnmsnYWkDJ1N/KjqMSehAXFzgokhcpA0eKtAL/znAo7SMilu/2x6Kf4zcGitfQr1oOwTX2Vo7xvLUigonTulduB12Ku8w/Ky/bHt/Mp0pyopZHyKzvX00GYEPgyiZ1mdfXmHSKbQSKLvqTNetjGZznDqxBBaq6r/cnqF8AP1x082g3GS6PGHK5Zrs7tH2WKFK4vi0Sjcry7DmgXvXIlIGbFniahBqGDs9LixwRAKFX7skCNu3ixxiMW9VVl0E4Z+L9kPo3lJGqzDM4SoDwI6AClISePWz8KLMsW6rsC8O6XbQFS2MPtOEqziQPAFj1z3BI867Vjc9B5z6jFEDNThygb5mG0pKxGEAw+D22+BMvW6qQqFoPqEw8705yx442lZCtKW0sKWWhtr/ABwhLt61MCvoh08yqU6KjpHfTztL378AG/SvsarnoB1P9xC+H0kVg2EUiPMO0CinHsyLrkHzPzNuOyrzh9A2UrLAx5Ghm9zhlG1Gq6n4ooaiZvD7csfFG9/pyEvHveQypU2miaERDVCHw+LF3HxP8TO/1aSK4LCU9qExxlfmSmsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: thMa0oYzTVC3hIEIKQpAQiMJIvitqnR18/bFKut3GGvqveokZ+70mx27Jd94TkiYtr9uPWsCBUXAqZrGk+2LYujll0SOJilbDFblUAn97QdCqhYtZHjwZNLfy6iwrUA5RQlukhEN3ER7hf8Co2CtfyIYKH2RbbIRirc5G3aIvzDTVWhZAkTIxh5RCiQ1u8//kYsmEK9kDjwaNzTaKfZMy2xIclSMBfQyvhC2puQWdCkCxUhf7Peb+vFO/tPSF/pDovioNKrl1SbVlIVW+OrzpXJtA13X7fUKDrgMFXmCaGHI+YCQ3KFAzXA53WkItA5Wp3Wk7doDNUY8zOsK+XW5uBaaX56E5BxDdr8TwXCaIPhSoCLCz9T+ihkHLIIsqLonaGk9dfAa94awL8THWEhR1vLBk+TtOPP5bZjIeVUOs+8yfwn+6yUA6Oum15ibTIn7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:44:16.9914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f6fdb0-dd7e-48d9-58bc-08de9ac2cc04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

From: Samson Tam <samson.tam@amd.com>

[Why/How]
Add README.md file to repository
Use it to categorize directories for tracking purposes

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/README.md   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/README.md

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/README.md b/drivers/gpu/drm/amd/display/dc/dml2_0/README.md
new file mode 100644
index 000000000000..9e8814fbe52f
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/README.md
@@ -0,0 +1,31 @@
+# DML2_0 (Display Mode Library 2.0) repository
+
+## Category to Directory Mapping
+
+```yaml
+directory_categories:
+  app_tools:
+    - dml21/build/
+    - dml21/src/dml2_unit_test/
+    - utils/
+
+  driver_hw_dependent:
+    - dml21/inc/bounding_boxes/
+    - dml21/src/dml2_cga/
+    - dml21/src/dml2_core/
+    - dml21/src/dml2_dpmm/
+    - dml21/src/dml2_mcg/
+    - dml21/src/dml2_pmo/
+    - dml21/src/dml2_standalone_libraries/
+    - dml21/src/dml2_utm_soc_bb/
+
+  driver_hw_independent:
+    - ./
+    - dml21/
+    - dml21/inc/
+    - dml21/src/dml2_top/
+    - dml21/src/inc/
+
+  undefined:
+    - .github/
+```
-- 
2.43.0

