Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CD7C00A8F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 22:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4724810E5FB;
	Fri, 20 Oct 2023 22:06:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DADCB10E5FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 22:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iohM0PiuHKm0n7tpXDmTBP5I/f1Ma88yQ8cMYxIX5vK0kNsEvFDB6SVtNZ8tvYJ9xXAdFjOdT/FwVeWzCu3U8ZpFimiIR3rb+5pnLW8rJ2F0KcKUM1GcrHB8nk3g3zOWWOOMDfBFyEH9bPVePsBodbYnv1Ka3Jqiu2QjW7bO03roSAaHD+q95DWg8t2sFVZjb4vkxZVHiGhfKsgrlaL/ArAcyrj4SGyMbWbm+9N3W8IoCvn4XPwYDyZzWWHsabtRT1Xpwrgo7AZzrx2lRmq9eO50/wyHjYJzCh26I2WI5qsHoNf+Ub850scL/b55p/fJCM2ZRNoUUzBAn3T8DJUlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NegSShqbmXqX24ngqi1J/ULIUagFEdI12p5Ii1Mb5Gs=;
 b=Y5nnp7t+5jLuyDGZ8wfz0JbHMtRf7V0CdAvT0fssoSniXmvA+4AWWHSH+vRsJa8Xwqq/bKMnreYR4sM3WgttbUNtBBCW/DSmubw8BESXBYB4jvmz9WrFaiE6BcPQrk4BJyc5oniZm9F+cdwXmrYGOkh4aAvwe2ksIK2F1nPw3n/vxcNOiUQnwuxsg0GoJZjS+YZmYGh1v4qlrqkxjOYJtiXjTurrwP1U/e9e/ES+V27hvvylUEb3uPAJoDYAZ5tMySuqEL172MzaTj4e1siJejvcf1Q8wsO5Pxs5kD9CNclt0o+YB6UwDk0oatl2SmlalV4NydCQ3Olmcz1+FJczFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NegSShqbmXqX24ngqi1J/ULIUagFEdI12p5Ii1Mb5Gs=;
 b=DQ8fv1PqM0CJwrzXLxCPIp02YOZcs0PP6DSki1000/qNDNpbmJb1FDtGJICLgNyHYA+ALMhwywukYkKClRPNQCWnfPnPry/CF7nGKk0dB8fyRDIqpPQmyY8Am1KluQE8CWfkhOqFDUS4GmZW/9QIdt8iX/0Ab9BvLuUq3TS/oo8=
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 22:06:28 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::8d) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 22:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 22:06:28 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:06:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 1/8] Documentation/gpu: Add basic page for HUBP
Date: Fri, 20 Oct 2023 16:05:14 -0600
Message-ID: <20231020220549.493808-2-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 6984c4f9-5772-4093-8673-08dbd1b8cf19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlbhbjkziwIllFJfo77eZ8DgJW0TESx1nzuffdiQ/4t2pOT+EdGp56k/8D3q4S69qHzg+8XRmVjrcIYxns82PewS/tmpWBiP2cAuO1Xq4fk+/agTZYueD3YjbVYnoAeZMoJ5mC5SMK7YR7p/V0QCAc8ZVX6viE9Pk3Xe2Fo3LCrPrzp0V2Qs2RCVaA/RpezpjlWAMjve/sc+WFWSjAkMswxDmAHE2KRnsjCD7FgF92JpxxtVLV6sq0z1rzd7NZTvh5ZTy87hCGtX8gx1CUdulwP2ULSpaoCE1ozklUcpq1ERHIFHAEHaMN2brIN14DDxuyNuGMWLcmQVRl3a40oghjhpJqIaOQ1NwOO7m9GLZwjXzPDCvEhHZz3UfSxhlYRdk/kSV6Pe6h3QdBkOBueJsqQpMT695PPFugfKy4wPZTITPblqtlEhxTI0lKRVtSMfJhSoBrLB6088zOB1W7Fj+zY0YTdGaFTwA54n8OBkByCtxzH8ZfrO/+G0XAKYzm/p+Vu/KWjYKAZlgOiZfahH0WaMlsw6oXRfkQtcAIqDMZlPF3DB26ktP3fP6pcou5qNmDkZcvhnCKQqfZmZaZdnulmh5twVoQJ1MMOLTNjjYkt2N2YgNbpldOO/x71ONETko7iV4FqGzDxABJu2Agq8za1O/s5svA3FeUSm8n0nliJI/whn5ss+LC3IOYhHaRThNch+PrUrLJcRlVqjGpCWKx+uXYDAWo9/sw50ZHq2Si9qANPe6YO0Of/zGL7PjS76sCaHRvjC7a+TtOZkseHOqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(36756003)(478600001)(6666004)(36860700001)(356005)(86362001)(82740400003)(2616005)(81166007)(47076005)(2906002)(316002)(83380400001)(54906003)(41300700001)(426003)(1076003)(16526019)(336012)(26005)(8676002)(5660300002)(4326008)(70586007)(70206006)(8936002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:06:28.1332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6984c4f9-5772-4093-8673-08dbd1b8cf19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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

Create the HUBP documentation page and add the doc references to extract
the HUBP code documentation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
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
2.42.0

