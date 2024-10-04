Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E398CF8842
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF58510EA36;
	Fri,  4 Oct 2024 15:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h7dlekRB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BEA10EA36
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brNFPozLJCXodSJjlyWK5xCVpKfRXcSRnIPugNIxUS0HvrZJkJtfyxhObV+87AVJtnaQb4a7nxNsppRF1ItNBga+gSNnkuZPSklCcAk8GERvd3fzVdcbczIQZTljUlz/H6HCpl6N5+hz6XlNrXbut7c+fI6izn1j51vNQBZ4oqDiseOLO35YgcsVWpAaKiafSFbS/tlT/MicHildWRG0+rg4DvgiWFuH5kgNQr/PJWIG+RVtF6EarDCscFmGMhoJCW/RtGRF6ku8Jdkcy7xMdnw5D0hd+j30tNpCKtFyzFLrEUXUR6KpT+tVgq10AU8Pd3R0wJEfJhOk1o519j6XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y5mcY+keA9QFqYIi31YOmYC8RyDL6HtCMDkYokQQnk=;
 b=F320iYGWaBk32z89Hz/UtruEBZVzKYZpKGg5lrzhBGsjx5EvGKfiF5c8lkKmsOHIO5buhu+7FisKzHcrFSP6Sz3Wf2kbJRJUn6NCCsKTlmBjjTIhB79JC1CXxo/EaEDqo2+d2moJKrmmDC+XHukPgMTNB1M9A1aNy4G/ByDgl9pOZKT2mNTCHxO4370ah70GJ/zxVdO6gRoPV+GvbN+cuDWH3Ky5lP2wPjhLJm/vdUS78AW4vbA1viIkTAgHRwxA0+Uj8hQMro6viDRObZ1LbvyAGJo73Ay8CMy34ospGQMz8OCCwG/kOTypDwT3XLCnQ0XP7kyjLoj8gQDOS2H/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y5mcY+keA9QFqYIi31YOmYC8RyDL6HtCMDkYokQQnk=;
 b=h7dlekRBdM2O00g11DDBjjELMtwgMmr0plFc0uRnuHJ0pHUBpUT5wruUOx7KYasph2kIUkULBBXJdUvyX1EnSsArOfGMms8CT92JayWOa95HHL6l9cIw167QRzYcZNx90oRY8+Sd3QZptApey0+GA0DU5A7sLsOcE/xUwW8oC6Q=
Received: from MW4PR02CA0010.namprd02.prod.outlook.com (2603:10b6:303:16d::8)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 15:01:23 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::8f) by MW4PR02CA0010.outlook.office365.com
 (2603:10b6:303:16d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 15:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Fri, 4 Oct 2024 15:01:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 10:01:19 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Fri, 4 Oct 2024 23:01:01 +0800
Message-ID: <20241004150102.327639-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcea3c4-6b17-4593-23a8-08dce485697e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xhqHhjAECBEzdVPvsgCKv7w+0lXsjBxaJRIkXWUFpPIR/NAIaxFTB9kDhjTs?=
 =?us-ascii?Q?q88hBcygoXQwT9XNF6ffmb7p5D9plNKfLobgdQhnl7gDs1/wrnaYrADX6/od?=
 =?us-ascii?Q?MVKa2I8iRHBfSxEtITRY/Os2eMnvy8y4iZHxpq2uB/LjdKIn4x8FGnUSgLAm?=
 =?us-ascii?Q?v7s9kcONGIY+f7RTSEIgVwXhaRGpburizepKKi1u5xPdFn60iFkv9f1KYDRS?=
 =?us-ascii?Q?lCA9hMGFhS0jdCN8G78THnfI2BDLzOM8/hq8m53gM18ia04Er9YK59CANclU?=
 =?us-ascii?Q?cE/HSVUiZMZgIsNV7SKzxeBaPEcsCqBm1/uPsA1FUScmuym1f4cNmkSySig8?=
 =?us-ascii?Q?RY7RVVPop8aqmw3txGOdGrNn45vVNY1b5KiysWb2umGn9KHOHSH9sHbhf0Xx?=
 =?us-ascii?Q?fFXHHp2tXjr5G+sFID5B97pk614/c8YXpIprGfz1SZ8uhL43/gDyyRY3PIiT?=
 =?us-ascii?Q?piBsPKVXKuIEYNnUiIjGNscCtCohnhgQimSsLDjag4Y5melE5mR6QWHaL0tQ?=
 =?us-ascii?Q?BHVb804hg/W+ccPfCAGGztJnTYwG7lxBlbZOdJrQleprF4ce0j18MMixHdV+?=
 =?us-ascii?Q?v4xoE1rM0mWAoawFzQ2UrVQdmSrWWHLvvA6MmVE5YF6xnoxcdqEVh9CNr5FH?=
 =?us-ascii?Q?0EjnE7oz2ns69cF0G2sLz53f5Rzl3oFS8AMlevwtjWIYkhqrjt8QIhwqMUrf?=
 =?us-ascii?Q?SQbA9ZK1JcUEqbwkh7lFUmyFNbxZY1B6B73suATMMzG5EgC5w+uMB034e4GC?=
 =?us-ascii?Q?ufEs+S0rRPsNr/1KFV9Ab6Yntc5FlWHg5nnr996GiIe0kCJ96QbclF+a1Zta?=
 =?us-ascii?Q?Z8PulWBl6QFucPweSS3RttCsi9FV1fPywFbfsMSLadtQLSN4wb8gQyG7ijO+?=
 =?us-ascii?Q?2fQUlB43i2cKzMLsX0fh0iifGCPqTBOddC15cvBOGtZ/n5FqXBZPZMMrX8tv?=
 =?us-ascii?Q?QrHivnkYJSo0HR3HGIv2UrW1YGBuSEt/oUt7EDxmfqmHsGbVrrv+iGdn23wg?=
 =?us-ascii?Q?7y/n3TGdqDuE+62PcIVlKpgiH7pwGnAvoZjYIhzj7h6gE62PxPjhGAh8gShB?=
 =?us-ascii?Q?/WHdgxGet8QNkzSQ58Hdh2cNvw8LUwM89f0v77/PcNctIOZZprll0HTAP1xe?=
 =?us-ascii?Q?yXcou/7NCNhf8I6ZgiodLR9TZnjciabrOsMNPRuH5cDFqzDTTvgLkpAWUTjF?=
 =?us-ascii?Q?+9lAYSqPeWClDs/pwoNSZCnMn8JRYtHsbg4n7N7LMCPJ7GMxsMoE0dbv0xTb?=
 =?us-ascii?Q?DcW2hH94gOjnYIMTHTGNLC2LDMhFvW9oUuqf643NFPuUM+Gbx8/qJnuSwd8Z?=
 =?us-ascii?Q?LWZ8753QECeXSsAG03yly6sJ3GW4ACH6ZiCn7wsgh0aLvNKPkNlcI4kBZfPQ?=
 =?us-ascii?Q?fzEy0zpluopXUzGYY26gwAtLydFB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:01:22.9550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcea3c4-6b17-4593-23a8-08dce485697e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

Update pmfw headers for smuv13.0.6 to version 0xE

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 822c6425d90e..0f96b8c59a0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0xD
+#define SMU_METRICS_TABLE_VERSION 0xE
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -231,6 +231,9 @@ typedef struct __attribute__((packed, aligned(4))) {
   // PER XCD ACTIVITY
   uint32_t GfxBusy[8];
   uint64_t GfxBusyAcc[8];
+
+  //PCIE BW Data and error count
+  uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is accumulated
 } MetricsTableX_t;
 
 typedef struct __attribute__((packed, aligned(4))) {
-- 
2.46.0

