Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C92C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 15:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84FA10E810;
	Thu,  9 Mar 2023 15:24:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FF010E810
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 15:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbKVSl56bYh3i5wiLAGJykEBndS3Ipo9joL0jyVuzDjb/zFJjwH5j8QaTqdIkUPpuu4zASwm3xYAfqcOFHiWfFIlhyQuyzED5NQTjlJJAWXI9VDnlZAnkai8d6DKe1wbW2z55Zhgg5m3sgZFl9g5S3enOc/pvovTpEzAFkSl+iccIALhFfI6qpKgv9O3BfWr81T2Ri27kIWKe31OJEM/chvFqAeq9cWyGX9JzVSKzdXGVJ1N0BkIXVUTKdsTXT1+SZLVTnHGMnLYsrcYts3wr/WnxjSimP89FfG/z3hMY/kg4MkRoxavPStrLe5YKZgv2K71zKE+DEUll4cg+JdmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNkKU/QngZGgWmQCQxlXK+LiaNDq2+zm5dpPxnJn8Nk=;
 b=D5R0LjkQnXxOSaRfLcxrajb5H+lN1WrJjzaGCE41D+AIqkKDE/ZBr8hNyYHJCZ9LTlz9bBC+cP5BRt+CI/37lrFb2iv57bCuWJbeJXyetBk5ZOOOYXxFRIRQucVl36scSvZ6EqzTbWhdlUvpcpN+cVmMnqUlF0rgokoX5RBR4lRtpfiUkt6M/MVtgDR5mcnIuIXvtLjwNhLz2IBGkAiEMl1bNwCH049E1tD+v54dukv/Fd7H5OCivqGMAlQDVIB0KwcfLo8a+S67VC2EgpSZKkKWn891/RXt0u96l1lU1qg6ZqEbY4/bUIWwuFq190RFHig6/L7iHgBnI0tqoRHbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNkKU/QngZGgWmQCQxlXK+LiaNDq2+zm5dpPxnJn8Nk=;
 b=xggD02lbtZNi7BGVP9YV/9+b6N7NZDXXtjK4ESUSvvM/9vC8BzRTsBequaP1tk0WGsmW6hhZdTAvomMdMyjDZoZ28PuRHi6trOwKFv8PyAIfFkoPwApCTPBtwqi4n3Nq++pnXYHImhd0v4bYbHSByhScSi6fGBq3FU7L3F+Szro=
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:431::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 15:24:23 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::15) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Thu, 9 Mar 2023 15:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 15:24:23 +0000
Received: from tstdenis.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Mar
 2023 09:24:22 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add missing INT_STAT_DEBUG registers to GC
 10.1 and 10.3 headers
Date: Thu, 9 Mar 2023 10:24:13 -0500
Message-ID: <20230309152413.1185095-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 800346b8-2f5b-41ef-34e7-08db20b25cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdTFfqGL3nDAByjcFIINTlX1S56P0Ot5l4VcWEsbqt+TShLF1UanNupBOdTX1xDlCCsmtw05rVyxyyIoUvgAF6kYERK5FTTDFXh/AjMyI3b8EB1Fm+/ga3hKEXFk/MQShlUzQCnITYp1flOSIGh4J0Ygor/5X/484585kK2ImwaF8nL9m54ZdkspGlxlr0YCWvOlgtiCinbfBG2HPiZJdaGOHFlGhxCl+ttLlcu0sDxswOcWRp1eXPXa5yZQm8H80RjCwP3XUQj98qb2x/418sTI+Ff6V/XxLQI3yoyVtSWvGR8mhRSunHrgHI6v0jabq5KGjECHcEGeIFG3RkPobqV8vbSa949ruW79ZTV0gepxeTFSmty68a+I1Ai8nWV85zL+yPALt2jaFPq8wNU5htyIcS06T9jISywFdmJP33XVrfTlho3iSZfj105w2tMYzhZpJSM4zz96FaQL64Qc2grOhPCDzqADYer7hePdWJ+vXedN5RN8yFOm26/sFT0ESBFgU3MlgWV2xWwEgy7iLxfzMowG+UTUH8leYr4V8Lh4iBREgEzC4KA0+hCSUkFJHhNycBEA9+wxqti0N8rwba3j4kyClfm96+Wc0hkZKdc85naoup4mZjAuNvtrIHLGGP/mYvwtkxam5biqEqujJTt0AHPNDTOgN+uLf+KVEjvUYgl/5jNhherWhywTFPtK9oFCOamp6IbJBZf4mT8buXH758HYMWA7SDXCtnkxB6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(336012)(47076005)(426003)(36756003)(40460700003)(40480700001)(356005)(86362001)(81166007)(82740400003)(36860700001)(186003)(26005)(1076003)(82310400005)(83380400001)(6666004)(16526019)(2616005)(5660300002)(316002)(478600001)(7696005)(41300700001)(4326008)(6916009)(30864003)(2906002)(8936002)(70586007)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:24:23.5238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 800346b8-2f5b-41ef-34e7-08db20b25cd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Checked against database, copied from GC 9.4.2 header.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../include/asic_reg/gc/gc_10_1_0_offset.h    |  4 ++
 .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 54 +++++++++++++++++++
 .../include/asic_reg/gc/gc_10_3_0_offset.h    |  4 ++
 .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   | 54 +++++++++++++++++++
 4 files changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 18d34bbceebe..79c41004c0b6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -4868,6 +4868,10 @@
 #define mmCP_ME2_PIPE2_INT_STATUS_BASE_IDX                                                             0
 #define mmCP_ME2_PIPE3_INT_STATUS                                                                      0x1e34
 #define mmCP_ME2_PIPE3_INT_STATUS_BASE_IDX                                                             0
+#define mmCP_ME1_INT_STAT_DEBUG                                                                        0x1e35
+#define mmCP_ME1_INT_STAT_DEBUG_BASE_IDX                                                               0
+#define mmCP_ME2_INT_STAT_DEBUG                                                                        0x1e36
+#define mmCP_ME2_INT_STAT_DEBUG_BASE_IDX                                                               0
 #define mmCP_GFX_QUEUE_INDEX                                                                           0x1e37
 #define mmCP_GFX_QUEUE_INDEX_BASE_IDX                                                                  0
 #define mmCC_GC_EDC_CONFIG                                                                             0x1e38
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
index 4127896ffcdf..52043e143067 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
@@ -18680,6 +18680,60 @@
 //CC_GC_EDC_CONFIG
 #define CC_GC_EDC_CONFIG__DIS_EDC__SHIFT                                                                      0x1
 #define CC_GC_EDC_CONFIG__DIS_EDC_MASK                                                                        0x00000002L
+//CP_ME1_INT_STAT_DEBUG
+#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
+#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
+#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
+#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
+#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
+#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
+#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
+#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
+#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
+#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
+#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
+#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
+#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
+#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
+#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
+#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
+#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
+#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
+#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
+#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
+#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
+#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
+#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
+//CP_ME2_INT_STAT_DEBUG
+#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
+#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
+#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
+#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
+#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
+#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
+#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
+#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
+#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
+#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
+#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
+#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
+#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
+#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
+#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
+#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
+#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
+#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
+#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
+#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
+#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
+#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
+#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
 //CP_ME1_PIPE_PRIORITY_CNTS
 #define CP_ME1_PIPE_PRIORITY_CNTS__PRIORITY1_CNT__SHIFT                                                       0x0
 #define CP_ME1_PIPE_PRIORITY_CNTS__PRIORITY2A_CNT__SHIFT                                                      0x8
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 3973110f149c..a734abaa91a5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -4531,6 +4531,10 @@
 #define mmCP_GFX_QUEUE_INDEX_BASE_IDX                                                                  0
 #define mmCC_GC_EDC_CONFIG                                                                             0x1e38
 #define mmCC_GC_EDC_CONFIG_BASE_IDX                                                                    0
+#define mmCP_ME1_INT_STAT_DEBUG                                                                        0x1e35
+#define mmCP_ME1_INT_STAT_DEBUG_BASE_IDX                                                               0
+#define mmCP_ME2_INT_STAT_DEBUG                                                                        0x1e36
+#define mmCP_ME2_INT_STAT_DEBUG_BASE_IDX                                                               0
 #define mmCP_ME1_PIPE_PRIORITY_CNTS                                                                    0x1e39
 #define mmCP_ME1_PIPE_PRIORITY_CNTS_BASE_IDX                                                           0
 #define mmCP_ME1_PIPE0_PRIORITY                                                                        0x1e3a
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index d4e8ff22ecb8..d7a17bae2584 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -17028,6 +17028,60 @@
 //CC_GC_EDC_CONFIG
 #define CC_GC_EDC_CONFIG__DIS_EDC__SHIFT                                                                      0x1
 #define CC_GC_EDC_CONFIG__DIS_EDC_MASK                                                                        0x00000002L
+//CP_ME1_INT_STAT_DEBUG
+#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
+#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
+#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
+#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
+#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
+#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
+#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
+#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
+#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
+#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
+#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
+#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
+#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
+#define CP_ME1_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
+#define CP_ME1_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
+#define CP_ME1_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
+#define CP_ME1_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
+#define CP_ME1_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
+#define CP_ME1_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
+#define CP_ME1_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
+#define CP_ME1_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
+#define CP_ME1_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
+#define CP_ME1_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
+#define CP_ME1_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
+//CP_ME2_INT_STAT_DEBUG
+#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED__SHIFT                                           0xc
+#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED__SHIFT                                            0xd
+#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED__SHIFT                                               0xe
+#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS__SHIFT                                                0xf
+#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED__SHIFT                                                        0x10
+#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED__SHIFT                                           0x11
+#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED__SHIFT                                                   0x17
+#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED__SHIFT                                               0x18
+#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED__SHIFT                                                 0x1a
+#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED__SHIFT                                         0x1b
+#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED__SHIFT                                                   0x1d
+#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED__SHIFT                                                   0x1e
+#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED__SHIFT                                                   0x1f
+#define CP_ME2_INT_STAT_DEBUG__CMP_QUERY_STATUS_INT_ASSERTED_MASK                                             0x00001000L
+#define CP_ME2_INT_STAT_DEBUG__DEQUEUE_REQUEST_INT_ASSERTED_MASK                                              0x00002000L
+#define CP_ME2_INT_STAT_DEBUG__CP_ECC_ERROR_INT_ASSERTED_MASK                                                 0x00004000L
+#define CP_ME2_INT_STAT_DEBUG__SUA_VIOLATION_INT_STATUS_MASK                                                  0x00008000L
+#define CP_ME2_INT_STAT_DEBUG__GPF_INT_ASSERTED_MASK                                                          0x00010000L
+#define CP_ME2_INT_STAT_DEBUG__WRM_POLL_TIMEOUT_INT_ASSERTED_MASK                                             0x00020000L
+#define CP_ME2_INT_STAT_DEBUG__PRIV_REG_INT_ASSERTED_MASK                                                     0x00800000L
+#define CP_ME2_INT_STAT_DEBUG__OPCODE_ERROR_INT_ASSERTED_MASK                                                 0x01000000L
+#define CP_ME2_INT_STAT_DEBUG__TIME_STAMP_INT_ASSERTED_MASK                                                   0x04000000L
+#define CP_ME2_INT_STAT_DEBUG__RESERVED_BIT_ERROR_INT_ASSERTED_MASK                                           0x08000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC2_INT_ASSERTED_MASK                                                     0x20000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC1_INT_ASSERTED_MASK                                                     0x40000000L
+#define CP_ME2_INT_STAT_DEBUG__GENERIC0_INT_ASSERTED_MASK                                                     0x80000000L
 //CP_ME1_PIPE_PRIORITY_CNTS
 #define CP_ME1_PIPE_PRIORITY_CNTS__PRIORITY1_CNT__SHIFT                                                       0x0
 #define CP_ME1_PIPE_PRIORITY_CNTS__PRIORITY2A_CNT__SHIFT                                                      0x8
-- 
2.37.2

