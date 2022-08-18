Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07D8C25B08
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 02:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF1D99680;
	Thu, 18 Aug 2022 02:18:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5842314BF17
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 02:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBfeOZRymfQhYZhveObWOS8MEYrpyVvxIXHatvksTrUu5fNVp4BYj0Wg+8/U0ip8LoIPiXMduhSkg1CZwT7Q4+aaDVUtShy/WVcr3t66yimjswcMU/Kpo5hzzFm6eV3WHvz6ABFR1qRvGC8fipLPPY0UM+WmKMR02t/6sbb4Upcbob/YglbbPLDWX1RlwKLRM0UMJKHlRaV9FLX+pbtxXMB1h323pRCQoZUlWtiKRlLXnJ2MEwtoGi/qstz5M+OMklw+kXL+BFDe1cARsBB/NYcQ0wEytmqvMj4fho4zEFw73KZXplhhAA+l6TllsTE6LWmht8wVtfpHKXWxapJYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C8XMBoZ9b9SeEaXouEX9duBlMhGO0lOFl/9buPYi7M=;
 b=YzT1gquZKVXHPY7NiAQ32NtqK91uIK+lROAWUCX+C/242ac185yFT3Ef3VphOyiHOzYU0FHdGe+ejtmP5dGAqxtFr6bwMiYreMs1f/zRIg+4ymxJoSenVysmTFl4dSho3+FLFDYvACAim0nEOEIBgh+fzC9Gy+n1etmWQ7K3sFOLd5i2M6JkM38KbJdQCquJ5XkfkWJg090bOiuVcQRAXfx0qnrBoYrRXSO9o4MnzEtHWLjEgvDY5EPymR02Y1ea5t/r3L67mXErBpC5yXFeiCgLM9UdyV+vCMyA/Zls2nE6k7f4gydEoovp05XcyQZomvd2iCEviMgqsSgRwKCu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C8XMBoZ9b9SeEaXouEX9duBlMhGO0lOFl/9buPYi7M=;
 b=K8zZureRy9fn4oyNUh6Wqifik4yuAeHt1WAoo6LnR8X3groJKYlPgYsWiGpbgMSUA9idd8s7qTpouV9X2/QKy4fD3ntKSip21aNkdaknCGGLCsI0kjthyNM4UI+YG9GxDwKPZnIlgTv+PFDOEOWcUzHmV1D6io5pdCCjthjvaYc=
Received: from DM6PR12CA0022.namprd12.prod.outlook.com (2603:10b6:5:1c0::35)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 02:18:31 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::45) by DM6PR12CA0022.outlook.office365.com
 (2603:10b6:5:1c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Thu, 18 Aug 2022 02:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Thu, 18 Aug 2022 02:18:31 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 17 Aug
 2022 21:18:29 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add TX_POWER_CTRL_1 macro definitions for
 NBIO IP v7.7.0
Date: Thu, 18 Aug 2022 10:17:30 +0800
Message-ID: <20220818021732.4087442-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7218266b-5d78-4e93-c6af-08da80bff1e3
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aR85iNtWFFXlnE6ZMeNq5FHA4uyon5lfS613ljNdcd9OAfv7PO118st9H8ufakXqqXHhvQrsC6F50rgvFw/2Km65+WP7fVVSE1c77TC1vGS9FvWtk+ZTRjZ5LdeQQk4bOkt8S5wEnAsE6yBct0CCN0WB76UeE5xdSE70X1W++C7UIgfsJB0c3bb/liZT5NdjgMewyR0203xmF1hNnjT5KXISY90plDH+eRvEKbALJgzz3OOgB+/BhN//SS4pD41RpMHitWBUPFAlw/6CxaXipLhRFW41qLGGyu8Ko2MXAjYD/P+XgwdQN5OJft58UiAL1Ml+6MCUYfCYtEZNqx7gZwZV4XHvqHJHHHT2CFpl76bmuwWIsjHl/wp0YmcolM84ERdyxwnZ8WZ03RZkQGqjffqaA58FED8QcI4j38H6P4n6LJRjcDSQo8N0+KdNiZFgBpV94h+eXvK+HWGsUWryG3vjg+pxUx0/t11n3p6OdGomxxwRiLusUiXdBY872bn1h+xzzJkVNeiw0sM1s3bSfARXHDotEWnUwdkmnR7nSHPNBChM1UqaGcTBBzCuKnWGwx3V+xZJlTabtucRTvoL8Aky/Oi8rO5oME4DSq4kdELZJMgoxek2qPIalaLjxk66/pRLWMGht0MeZzTS2ubjJVa6Hdj29vvFg9cZqyQEXYYEjnfeyFs+f26WbuNTJiaNtiX5gbgp3/VhPt8/u9HD048RvFZ9Z6EW5HweJsTwUpHiD/+aQl/Cj3D86Dtn8DrvuADNFWcJkFqXxksXTcyofK6vdegMtf/lTjBpv92kwRE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(82740400003)(40460700003)(82310400005)(1076003)(83380400001)(426003)(36860700001)(186003)(2616005)(47076005)(40480700001)(356005)(336012)(81166007)(478600001)(16526019)(6916009)(70206006)(316002)(41300700001)(70586007)(6666004)(54906003)(44832011)(5660300002)(2906002)(7696005)(26005)(8936002)(8676002)(4326008)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 02:18:31.0598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7218266b-5d78-4e93-c6af-08da80bff1e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the BIF0_PCIE_TX_POWER_CTRL_1 register offset and mask macro
definitions for AMD_CG_SUPPORT_BIF_LS.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 .../amd/include/asic_reg/nbio/nbio_7_7_0_offset.h   |  2 ++
 .../amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h  | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h
index 2ed95790a600..cf8d60c4df1b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h
@@ -15243,6 +15243,8 @@
 #define regBIF0_PCIE_TX_TRACKING_ADDR_HI_BASE_IDX                                                       5
 #define regBIF0_PCIE_TX_TRACKING_CTRL_STATUS                                                            0x420186
 #define regBIF0_PCIE_TX_TRACKING_CTRL_STATUS_BASE_IDX                                                   5
+#define regBIF0_PCIE_TX_POWER_CTRL_1                                                                    0x420187
+#define regBIF0_PCIE_TX_POWER_CTRL_1_BASE_IDX                                                           5
 #define regBIF0_PCIE_TX_CTRL_4                                                                          0x42018b
 #define regBIF0_PCIE_TX_CTRL_4_BASE_IDX                                                                 5
 #define regBIF0_PCIE_TX_STATUS                                                                          0x420194
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h
index eb62a18fcc48..3d60c9e92548 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h
@@ -85627,6 +85627,19 @@
 #define BIF0_PCIE_TX_TRACKING_CTRL_STATUS__TX_TRACKING_PORT_MASK                                              0x0000000EL
 #define BIF0_PCIE_TX_TRACKING_CTRL_STATUS__TX_TRACKING_UNIT_ID_MASK                                           0x00007F00L
 #define BIF0_PCIE_TX_TRACKING_CTRL_STATUS__TX_TRACKING_STATUS_VALID_MASK                                      0x00008000L
+//BIF0_PCIE_TX_POWER_CTRL_1
+#define BIF0_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN__SHIFT                                                       0x0
+#define BIF0_PCIE_TX_POWER_CTRL_1__MST_MEM_DS_EN__SHIFT                                                       0x1
+#define BIF0_PCIE_TX_POWER_CTRL_1__MST_MEM_SD_EN__SHIFT                                                       0x2
+#define BIF0_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN__SHIFT                                                    0x3
+#define BIF0_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_DS_EN__SHIFT                                                    0x4
+#define BIF0_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_SD_EN__SHIFT                                                    0x5
+#define BIF0_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK                                                         0x00000001L
+#define BIF0_PCIE_TX_POWER_CTRL_1__MST_MEM_DS_EN_MASK                                                         0x00000002L
+#define BIF0_PCIE_TX_POWER_CTRL_1__MST_MEM_SD_EN_MASK                                                         0x00000004L
+#define BIF0_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK                                                      0x00000008L
+#define BIF0_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_DS_EN_MASK                                                      0x00000010L
+#define BIF0_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_SD_EN_MASK                                                      0x00000020L
 //BIF0_PCIE_TX_CTRL_4
 #define BIF0_PCIE_TX_CTRL_4__TX_PORT_ACCESS_TIMER_SKEW__SHIFT                                                 0x0
 #define BIF0_PCIE_TX_CTRL_4__TX_PORT_ACCESS_TIMER_SKEW_MASK                                                   0x0000000FL
-- 
2.25.1

