Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F71C77B6D
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3BA10F341;
	Fri, 31 Mar 2023 22:44:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0509610F33B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAl368JyLVWvnBpToR4In0dRrIt2rD3DV8XiDyV2a6fOyBhp1Ysue4bkMFCd9y1EnV7N2DwqdMO67T7bhudD7wfa6fWmvhnZmfQhDQ3gf1wNBXKY90AcAKAoJrnQCh0385O/KOPLOQ8/s6RVVe9tbq9Fn82dcUAJQifxXJlcLPhq0TH1gcul7L97P2ikIp5lFQaV72OGid6Na9m3Oym27T0jpUYjc/tbGHZRHeuXCc6e7DkaAZN2xm66WwXt3Fy8WHh/yK1MJ/VK/eRKZtM/fynr1N4BsuVjQe6uSAvwt4McVrEDvs/xWBpmqTVCz39jrgD+bWoAsm8pHdBsG0Qdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiegSWucDqBqRO1Zc6w5PSiaXHTU3aQUsNqNZbIGPfo=;
 b=RXgD0gEBYVxxyYeRKUn+1y80uo2bVKwaHTNFkrxP1UmxImNJaDNPb15SJfttzUyOHpASMCQFtHkiz11wGGoJfaZYFchmo06p5dEMB8JJ4ti03VJDIhfGphlLALnoskX0U9aS14xxcTzl4jSwirla1xUY1mbCeTNXlcVQX+rBeO75lskDivSXcC/31vX1xWJgknSULVAXEdvL3FJ7XnaGLCSsr4GcLLJNY8fHylfN2L0h7r7Kr/pAt1Uc6Gy7ylfIyWvuffuYCgxEKwwaoxduSYXQdy0uYHg/TLOuKsN7QiYtWpBClRnYPPt52vJrr6vUuWAi46+by6fWWO6M+Z7MrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiegSWucDqBqRO1Zc6w5PSiaXHTU3aQUsNqNZbIGPfo=;
 b=DVkP6jTLx/DoJgF8+KM7wYEfLfwzZMwtExpc6MFxhL8nRVN+6iKQUuo9+wB13h9seZbNXBOSEzxtDDeLS1LUgCf+gf5pxX7ptboVtLNMYuaQc5wrfNPJtcl8tmnbSm+U6t7/4MdeamPNF6EAnDg0qnySEK+S9xRPYATiFUaUoFs=
Received: from MW4PR04CA0385.namprd04.prod.outlook.com (2603:10b6:303:81::30)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.37; Fri, 31 Mar
 2023 22:44:43 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::8a) by MW4PR04CA0385.outlook.office365.com
 (2603:10b6:303:81::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amdgpu: Add sdma v4_4_2 ras registers
Date: Fri, 31 Mar 2023 18:44:17 -0400
Message-ID: <20230331224425.8755-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3c013d-d036-4293-2ca6-08db3239851a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7gy46fvvgL2vo41e30NeJYGHWSQgqjIxEBaViMX7NiagQRN67gva/OqYOqqKw4smm+mg2mJ6rtkho5suMLbJsIPdOkaistDt33l+tWhZNzYujlEI+gM0RGneXNzh+a+vlkNr5FNs05eKS3AtDTbxfv3hc384w3huztHNGVS9sX+0gZkmystM8Hyog9fSrPrOTISkn4ii+YVa7bMZerQn3ILzbU0DRzMkajaQGItzcmTtuNO+qQhhhv92O5EipLhj/9+tPUx17WDqkZUPwwfiNLvKaSbJg0YZmXkEaLuIu7WK32K09UGL4ukIHQcBNzCMIQ3rfwFl9daI29UEH0jqpPBeqyUe3qJGh5PXFn7xZXmudD9K4EMjOIRHJ3t+XHPhCNR/HE+UOz3SyBij+Z6sAP1rFaKJ3YKIcUgL3vp/zjmo6lx3NSH3s/y11BAwUKJmHVFcfwaHqH3FKDFmqQ3EtIzrtQtZ57kPohs+nObPb2CflqKkij5B1iuPFVu/PKTOCfsze3YWeWoF8vwyzvUc5aRRBylD7Wgx1/EiugE5UiwVn0y0EPfTM7Yxpu/stQF6VhL8o+4VTbkquDUE0F4sZVMd3eEgD9skBvg/4ZKg1/yyEMPb2dr07roQJq+VFjGbzyrYd2kAsbF31w6cUte2wtodFunefF0kq9zC5WCy9jM3A1yJIuqWZIcPRMH9oaQc701f8A2UmPHZ69L8zy5ztI3WqjAj5oN7O/BOnMHyLI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(82740400003)(40460700003)(36756003)(82310400005)(6916009)(356005)(81166007)(8936002)(4326008)(5660300002)(70206006)(8676002)(70586007)(40480700001)(2906002)(86362001)(41300700001)(36860700001)(1076003)(426003)(336012)(2616005)(478600001)(6666004)(7696005)(54906003)(26005)(16526019)(316002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:42.9104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3c013d-d036-4293-2ca6-08db3239851a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

SDMA_UE_ERR_STATUS_HI|LO are introduced in v4_4_2
to replace SDMA_EDC_COUNTER/COUNTER2 registers to
log SDMA RAS errors

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++++
 .../asic_reg/sdma/sdma_4_4_2_sh_mask.h        | 24 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
index 31bef0776ded..ead81aeffd67 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
@@ -211,6 +211,10 @@
 #define regSDMA_RAS_STATUS_BASE_IDX                                                                     0
 #define regSDMA_CLK_STATUS                                                                              0x0068
 #define regSDMA_CLK_STATUS_BASE_IDX                                                                     0
+#define regSDMA_UE_ERR_STATUS_LO                                                                        0x0069
+#define regSDMA_UE_ERR_STATUS_LO_BASE_IDX                                                               0
+#define regSDMA_UE_ERR_STATUS_HI                                                                        0x006a
+#define regSDMA_UE_ERR_STATUS_HI_BASE_IDX                                                               0
 #define regSDMA_POWER_CNTL                                                                              0x006b
 #define regSDMA_POWER_CNTL_BASE_IDX                                                                     0
 #define regSDMA_CLK_CTRL                                                                                0x006c
diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_sh_mask.h
index e46cb3339355..290953bdf1d6 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_sh_mask.h
@@ -1171,6 +1171,30 @@
 #define SDMA_CLK_STATUS__F32_CLK_MASK                                                                         0x00000008L
 #define SDMA_CLK_STATUS__CE_CLK_MASK                                                                          0x00000010L
 #define SDMA_CLK_STATUS__PERF_CLK_MASK                                                                        0x00000020L
+//SDMA_UE_ERR_STATUS_LO
+#define SDMA_UE_ERR_STATUS_LO__ERR_STATUS_VALID_FLAG__SHIFT                                                   0x0
+#define SDMA_UE_ERR_STATUS_LO__ADDRESS_VALID_FLAG__SHIFT                                                      0x1
+#define SDMA_UE_ERR_STATUS_LO__ADDRESS__SHIFT                                                                 0x2
+#define SDMA_UE_ERR_STATUS_LO__MEMORY_ID__SHIFT                                                               0x18
+#define SDMA_UE_ERR_STATUS_LO__ERR_STATUS_VALID_FLAG_MASK                                                     0x00000001L
+#define SDMA_UE_ERR_STATUS_LO__ADDRESS_VALID_FLAG_MASK                                                        0x00000002L
+#define SDMA_UE_ERR_STATUS_LO__ADDRESS_MASK                                                                   0x00FFFFFCL
+#define SDMA_UE_ERR_STATUS_LO__MEMORY_ID_MASK                                                                 0xFF000000L
+//SDMA_UE_ERR_STATUS_HI
+#define SDMA_UE_ERR_STATUS_HI__ECC__SHIFT                                                                     0x0
+#define SDMA_UE_ERR_STATUS_HI__PARITY__SHIFT                                                                  0x1
+#define SDMA_UE_ERR_STATUS_HI__ERR_INFO_VALID_FLAG__SHIFT                                                     0x2
+#define SDMA_UE_ERR_STATUS_HI__ERR_INFO__SHIFT                                                                0x3
+#define SDMA_UE_ERR_STATUS_HI__UE_CNT__SHIFT                                                                  0x17
+#define SDMA_UE_ERR_STATUS_HI__FED_CNT__SHIFT                                                                 0x1a
+#define SDMA_UE_ERR_STATUS_HI__RESERVED__SHIFT                                                                0x1d
+#define SDMA_UE_ERR_STATUS_HI__ECC_MASK                                                                       0x00000001L
+#define SDMA_UE_ERR_STATUS_HI__PARITY_MASK                                                                    0x00000002L
+#define SDMA_UE_ERR_STATUS_HI__ERR_INFO_VALID_FLAG_MASK                                                       0x00000004L
+#define SDMA_UE_ERR_STATUS_HI__ERR_INFO_MASK                                                                  0x007FFFF8L
+#define SDMA_UE_ERR_STATUS_HI__UE_CNT_MASK                                                                    0x03800000L
+#define SDMA_UE_ERR_STATUS_HI__FED_CNT_MASK                                                                   0x1C000000L
+#define SDMA_UE_ERR_STATUS_HI__RESERVED_MASK                                                                  0xE0000000L
 //SDMA_POWER_CNTL
 #define SDMA_POWER_CNTL__PG_CNTL_ENABLE__SHIFT                                                                0x0
 #define SDMA_POWER_CNTL__EXT_PG_POWER_ON_REQ__SHIFT                                                           0x1
-- 
2.39.2

