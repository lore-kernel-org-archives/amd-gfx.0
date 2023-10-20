Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA54C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 22:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26EFA10E601;
	Fri, 20 Oct 2023 22:06:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BA510E5FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 22:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqYZrMNe56zsCsXyAxCxKZsbcl8ScvrW29R4gJvf7Nu24lZFZVBcT21qwfVVRgqhNOR/xzLkqN7+CmbUAHnAekYSY+hfAnYg8Ew3TRGRbbPTSw0vCEpmCImev0wpeXE5g+K0oAGNbj1SPfzvNXbuhwiZ/SamfTwH3m0v95QAHhVsWXKwk8n4quIE1qex3rijYbUh2GhAv1mbP9sllOJAeaE3l3Zl83Fye+xZFyuyZuupaOYhTd9buhFguUDAO2CgkJz1pr5K8oj5+lmf8aumH8FyhDjWia6mgCLmvCGkRdNm3UzG2tR0ELNfe6qcvnJf1MlKPU8VPz1aJ/47Z5zXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6LC3aXMVL3YcvGecpx711bprFMsTvqseVq5Nl6Ks5c=;
 b=n6zhVU6oUY+Ldg78gx2dy8B3ioA6w1HuUkueUqPVWgXLsW4P45S5h7Zs1NgUlpr8UNwyQZryLj+snGWBcpQI27kyyUDTxBvE/VOfD1eQfaqNXNh6FYaiZh15W/1iQB7BGlf8I0w+CawGnd0N8Eobu6qJACV4NdjY+stOs/JdzfyHj5wPiahbfW193V2jROAsS8lo1G14R2OZnxF2Tak781lt19wQ59fV1FtlDoe0BDupXkMnupz6IWKBZpOI/+rHH/Q7QZeBsM1rY2OO+mc7ZCj4ErzFNLM5+xyTfyGaigNxYvi9DiIdoMOGbITZy0OoenE6JBOnVUl950wy30eU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6LC3aXMVL3YcvGecpx711bprFMsTvqseVq5Nl6Ks5c=;
 b=PVrzbmfzUT3A+4VXjPaKJ5gcEetWXDd/O3X2tYNn0xv0Q1ua5OByKJMp9VJRVhB86Wnwc6ISwKF4Dp7XzOF+ewN3JbbKmNft8p4sWPJOVOMdzj+TK0mYPZEWN2GSBWBlNFyGjRgpTaCGpf+iCRpgxImN8HJSALGqvLKbjf85OzI=
Received: from BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 20 Oct
 2023 22:06:33 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::c7) by BL0PR02CA0126.outlook.office365.com
 (2603:10b6:208:35::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 22:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 22:06:32 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:06:31 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 5/8] Documentation/gpu: Add entry for OPP in the kernel doc
Date: Fri, 20 Oct 2023 16:05:18 -0600
Message-ID: <20231020220549.493808-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
References: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: ed929ee9-b5b5-4051-c8ce-08dbd1b8d1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPsHKWB/gqOZGLOGT0YkxhiIvHeBgUBn1qEqxe0xddOxGNbEY666ASfcF9Qgn7jtAw/Do7CkJTkzv/kJXh0M6WKJSd6gjdhEXkI2WF6WmBdayt33NfuPoRUDWM74yT9cCmMRbEITfesnMadGJSFWzO6aTGsKrI5ri7I/Z3xTTEXWsu5CsymHJrq2MEEGpcVvoPoSGAzBMvc4Yx0SB9zvK8hZ7qPsO8ED7dzADuoZMry1MK6BQi4AS0Zk+dpXw8fwvpof4ipbEA0orKG5EPxtTmKGCTnIcKlS74CRna8tTwt9rd7ytMq9fGmPTaHZ3eqwO4843MfsWaYiucDopJihkJ4mlGq4yjmVUx+tK+WTkkk8q4wf4tb1dlLvk0bHiYvrrZn8bZUhVgaFcaB4BhW3zf3sk7KYPjcWFz3WzEwDth3IvWapnccz5S9ZhT/4yOCFpUrJnhFiynDcOErDv13nlg90mWSBcWl+JDglPREj7VyE6phHq32KqesKgP7NTI51QefItR+sYrC1rUmLZhG45hnnZNjKAgVcr1xTUlwWN6gihUV2RNlmms3FhgaUE7MvispZsRkby3TMvZt7w++XMi1x3ycPvOZzuDbQx+2e+HiwRJmRUD48WmmqxCP5zcupngn6QU0kPNSny7x0Ml7Jj4GojgL3LRwcPNuqSd131NQzwHah2o9JEaAIwkLyy5DEKA+c6SrtRnCqjy7wT3S3srH4fiq3B7NomNgS69P7qOCgbUltp55uv9c5fO0AeEAucPhznS64iCyOCKoGLQOMqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(54906003)(8936002)(316002)(6666004)(41300700001)(70586007)(70206006)(110136005)(5660300002)(16526019)(478600001)(8676002)(336012)(4326008)(36756003)(356005)(36860700001)(1076003)(82740400003)(26005)(426003)(81166007)(2906002)(2616005)(83380400001)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:06:32.6060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed929ee9-b5b5-4051-c8ce-08dbd1b8d1c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry
 Wentland <Harry.Wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce OPP as part of the kernel documentation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
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
2.42.0

