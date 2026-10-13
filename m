Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6821CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 13:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FCB010E847;
	Tue, 13 Oct 2026 13:06:03 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03BFD10F7E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 13:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qS2fbOe+OH9sNnrH5OU1dwilvA7fL7CYNwnSWH7c2Y6kCTmXXVBb9ImmfhvUXzEURrzw9sxfE1IdzfrwU5n3+NkvVIVUi5LZIETiIjlbZr4+YTIG7cYhojtum6yHMpUVGwRSQnfKuXSohg81tIxaxjD/0z762aNnBgqNBYiLDB2a8fDNWf3f1c6HQH+JuIUzgpF4vvg5JwIVfr9VTZ/K6asUize1mz3umq8bgicJvnFza7mEDnmGcOqw4bUqxsy/gRLrdPWmqMarP47x2hZVvaz9H0afRIS44K4f4XnjudIbRg1jJWjKCZmIM6RsTSazxtGDQTPvbfswTlUWiD4QJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0wPcY3lWl4W20bYkk4ZgxyrjDPyANAh2A0eaLZ+hwo=;
 b=GKU4F8O/RGdk2jfFOuKl48zjXCQ/coWw/UpKeYRHKklG8S/PasVOTcW4G1PxCA2yEA7h89cuR4e8vC5/EK0TF626l7RTonfB/lrFuJwYhETDwaBay32oxABghDzeeoHpX4tfAKibZsYASN6HLr9zWcGL2CpOPYW/aSw5CPB2d6s0dz9uNUhWqb9w7VPLdKsZJB4nE1vRyEu389p5obQwXG6IX8qMo6A4VpC8RiTswx0hx7APBMFhgnCTqn8XZjl52mb4MDMq8U+hFzx88X32N9nGwdRjGiewPO2BC6MV18upgHgJPYgQddud3AcsLh76lkpbEOyJUwS8kFvYg1MkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0wPcY3lWl4W20bYkk4ZgxyrjDPyANAh2A0eaLZ+hwo=;
 b=xnEAx8rvCYn5KUFgwvyY0kQyah2+Xt0RC6Klm6I8tStW4AQ2UxhbQcqV1lcrDiMhagfpXtYt9FsSrymoOZgcMPljJsg3CimtAOdYJm0mQM/IPkl8D0XZWab8Tua9uz0mLlW4AXN+rTrvIMj5S+5+SnNGG2piNtVnsy0eY+u/UyE=
Received: from MN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:52d::27)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 13 Oct
 2026 13:05:51 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::1e) by MN0PR04CA0028.outlook.office365.com
 (2603:10b6:208:52d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 13:05:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:05:50 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 13 Oct 2026 08:05:44 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/mes12: send SETUP_MES_DBGEXT to the requested
 pipe
Date: Tue, 13 Oct 2026 09:05:07 -0400
Message-ID: <20261013130507.550782-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: e854e8c9-7b2a-4235-b2ea-08df292ab4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: K2LfipQ+bozl8+JuiCAfJ5UfQIKtB8CxnpRXUXQRSInEaz8akqc+9NyTRDgjiAj1B+8J0beeE7OB6X3AUJqf9Od/5CQzs84n4JPL4lO2Qrw56xQloK9VhrIKdTKAYWPLImARswJUR0B2OK0sqgnYWKkJBTXMaPqmABe5cTNefw8m5oou9gPcqIjgg0eTIlyWtN+S9czIVn/vi4XP7JQqgUt65z1O50QqFEPNKDU5CdjT4HRgpC7L/n4AMWNofaPN33UctBaU3XLYBIlgRltnn8yHz40HxezvPWvuSPrMkUM01LHkFNyyk3bMvRbFF/qxnmlGmJN5GCE/i259CIj5OMmY2PbwColtZBplQhYeOTmboypNddidEh7Zuzv7EDRi28hrYSSaYNfgTJPS3mzy6ft3FXBLTBWVsKa7LEPvOVjrhjn2dhECXtoFhBpx72xcRMwj8XJtBVG+RzHaahoPbAfySAKc1++nfZwz/OnyQJMvdn1Jg47nFzN6TQOZaP/XpP0rJIrGgUrC+wth6gtrXwMO8zSt5BJSHmOK8E/krOfb1FPS8LHBPRy+/GDJgAe4eeXKxjhSNhhYQC2BsMZwVsQW07A1dk5sCDVUzniij05dMwa/B32H3aEtqeIZOIHY+zsX5FC/yYXCAA2iEfL5g6CYrcw4QUwipgiPn4XbFftjpS3SA/0dD7X/+vOYU7Srqx5gLgtyG2AQFARVwkr6Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3GTFl5C2UfkBBEtm69+G/yvpXeFLK9pcTbjlFZrqPDg3/rGJBPPNnyYHExd6zubyecoOLmdvv/gvdNW+fH1pWADfK9IXc2q0gFpUNKMD1snk4MDlGg8a1Kp8j5c3kinfu8t/XgzLTULYwV75qEYs95t4EBhoNoHF02Q31cmkcs6jgby9cTpixA4ark1HGPjg7T7EuHFSndm2OWSLIMSYcyXRZ0V6aBif8Zm25j3lEKR7kr1t1vlUR9UPLICQBXvNj9a6Fxnn7Wjj3LAF2RCgpxYGWHJIjjynwPtOTDK8o7VG0DfO5v8z/RlGLpFr8SmNRHvbHuTPcrBBkDlx6es2VMqXY9PQ40He7OfvFz+QJtdRoBPAdVNgbvqFnqTFI8UetPyIObMEHNgBsN5kl12TfLungHdU1EieHTChp+xF6OTFBwgawrlUtbnm4asMy3ni
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:05:50.7938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e854e8c9-7b2a-4235-b2ea-08df292ab4c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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

Route MESAPI_MISC__SETUP_MES_DBGEXT to the pipe named in the setup
request instead of the default MISC pipe, so each MES pipe can be
pointed at its own dbgext log region. Under unified MES the default is
the KIQ pipe, so both setup requests landed there and the scheduler
pipe never got a log buffer.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index b6356095b079..0f8b9e59d394 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -991,6 +991,10 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 				input->change_config.option.limit_single_process;
 		break;
 	case MES_MISC_OP_SETUP_MES_DBGEXT:
+		/* The log buffer attaches to the pipe that receives this packet. */
+		if (input->setup_mes_dbgext.pipe >= AMDGPU_MAX_MES_PIPES)
+			return -EINVAL;
+		pipe = input->setup_mes_dbgext.pipe;
 		misc_pkt.opcode = MESAPI_MISC__SETUP_MES_DBGEXT;
 		misc_pkt.dbgext_init_data.dbg_ext_mc_addr =
 				input->setup_mes_dbgext.log_buffer_mc_addr;
-- 
2.43.0

