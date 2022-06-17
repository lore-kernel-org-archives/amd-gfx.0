Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C6BCCA479
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8030110F328;
	Fri, 17 Jun 2022 19:35:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8444C10F328
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSiuyimeE6HjjfWGHx4Xwqi4QEgwTewr/FWUsjC5otWnc3zOZWd7a12qdUVjmDSSmVMSIn9leRd0fjdIBvdsK0voFcTYdJmuhYbfidhTDuMdhCekuP8e0RdIw0YZ62F0QCx+6fLniAtiCSihSud/D1V9GDFkyrRMTwOr5S6dQZ8AOOhigP3FEusGrWUCREtD08QPfEqdAg36iTwNRFmMs3w2v6RtQ2/ce++EcUgPWAxPiNFbkpFJ4r02UpSWm46R3xHRk1i7I95rAsjMaOzZomEyU3f1tWBKOt+vVLoN52WWTtd+qu9FqId/438ptUlrRys1c3YAn75G92PliQjUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2nycMbUVHT5fQdnEk69/jR5yRCBlCYemUbs31Nqsuc=;
 b=CLbdC4GzSGdHvPN2BZsymRw7yMuK2uwDXnIYk86uO63Zd0bUhPPTJtU1fNKYqKOLxi3jndjx6eqVOHiI10aQCovRt3888U5uj1VGxO6of6R1txA0OYTvtMF23eID3/ZQhfSJ5HU+4Xj8YDeKDbkKN5nyw0sx2VrgIl7xR1EW8U3lwO6jODZyqfmcJZ3vnW/M/0gQSIW6ZDPRrSCleBmf1nqupd7qZmyWcL3MdT+VFwRJZLskj5VGJYF4jopvKC4zBgJs0BULzJBIZu6Z7U0eKtH9WF8exwNITprOm+VSaKuaBzWUesYCbdzfI6+arMi5/lAHPIlHaf/rQ0UGoh4llQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2nycMbUVHT5fQdnEk69/jR5yRCBlCYemUbs31Nqsuc=;
 b=bqG9jPTwFx1eOvRGyMoA4e1TIMGAxv83ROarsvBKUWQSx6ffCZn8cm/If9sgTA6tRFF4UqPtIi55yFtN5pVG7qWxYWGd5sVMU/k9OWRfDB0lyItCBcFILJLzaJotbeR5tJFBEM1hqdFQrrRtmbBvxjQGAf1PnyPS543bE8scQls=
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by CY4PR12MB1575.namprd12.prod.outlook.com (2603:10b6:910:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Fri, 17 Jun
 2022 19:35:48 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::bf) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:48 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:45 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/31] drm/amd/display: Add SMU logging code
Date: Fri, 17 Jun 2022 15:34:51 -0400
Message-ID: <20220617193512.3471076-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 415efaf4-0789-44b6-ee57-08da50989482
X-MS-TrafficTypeDiagnostic: CY4PR12MB1575:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB157592EE44B3231C16B27BB998AF9@CY4PR12MB1575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ss3hiGkV1FS7AEkEChYrU50gcapEpnVEvGpEgfL/TkqIAyTkwn+fGcq+YZthqKeokgHyXzPdm6gO/vbOKKlhfyoAF3bqkFxvwfnx0kATJD3nHmQbCMnJu42brnMSO/4emXYXoFS78E37k3bzd7sfKiB6Sawcsm+4g4t+RRSTOa3bH28fL/NI2ya9Q2pyWd5g++ruQaMp/YxLeJIrldJx1VmsA4MLePA9sIrZr/oYQFoTwjn3bf5vZlORVa2DGuPOMO9RA1yoPMRi4o/APMjQLZkaVSxsuKO2NfKAQzKbvCicCFOgV72OZbriLembPsdStPKbZ5WMZFS5dN66EqrpIal7z08OxURT8Pw3dg3ry4CC8jp4xLgppQ3TGiHn3kieFqIiB2OLl0kE+LaYfa6wfKSUe32oN4lZNPNIYFMcJMSBOI72WKu+hUywR/VPuqnTq/B/ah3cZlUZZ+8pDOSikeOBOgIC/5o2YXrwPjdBboT1ItwIBga+dMGK4Z3KoxVtLB8s5g0MJmIGTSsLylCepew2XPItclylaJI6XvwUJYDwBv9pVZsWmLDeEHRhPEwwpY/SWUou4/ZZHKD1Cy6op33wsomQXsQqUtzEHr1yOSeFoTSwHgWxQ80hw0hzj/H6GHxDaUOCuE0OTCJa4FQUSm62VNu4DXunGtxBzNPnJ3ZemNVBf7HaG/vX1AoL0yXN9ZngKkHTeN7KmxuDytF4fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(70586007)(8676002)(6916009)(82310400005)(6666004)(7696005)(4326008)(26005)(36860700001)(186003)(2906002)(70206006)(36756003)(498600001)(336012)(426003)(316002)(16526019)(47076005)(1076003)(54906003)(2616005)(81166007)(83380400001)(86362001)(5660300002)(40460700003)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:48.2425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415efaf4-0789-44b6-ee57-08da50989482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1575
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Saaem Rizvi <SyedSaaem.Rizvi@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>

[WHY]
Logging for SMU response value after the wait allows us to know
immediately what the response value was. Makes it easier to debug should
the value be anything other than OK.

[HOW]
Using the the already available DC SMU logging functions.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
---
 .../display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c  | 12 ++++++++++++
 .../drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c   | 12 ++++++++++++
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c |  8 ++++++++
 .../drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c   |  8 ++++++++
 .../drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c   |  8 ++++++++
 5 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 30c6f9cd717f..4137394a6ace 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -41,6 +41,12 @@
 #define FN(reg_name, field) \
 	FD(reg_name##__##field)
 
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	CTX->logger
+#define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
+
 #define VBIOSSMC_MSG_TestMessage                  0x1
 #define VBIOSSMC_MSG_GetSmuVersion                0x2
 #define VBIOSSMC_MSG_PowerUpGfx                   0x3
@@ -97,6 +103,12 @@ static int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 	result = rn_smu_wait_for_response(clk_mgr, 10, 200000);
 	ASSERT(result == VBIOSSMC_Result_OK);
 
+	smu_print("SMU response after wait: %d\n", result);
+
+	if (result == VBIOSSMC_Status_BUSY) {
+		return -1;
+	}
+
 	/* First clear response register */
 	REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index 1cae01a91a69..d8f03328558b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -41,6 +41,12 @@
 #define FN(reg_name, field) \
 	FD(reg_name##__##field)
 
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	CTX->logger
+#define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
+
 #define VBIOSSMC_MSG_GetSmuVersion                0x2
 #define VBIOSSMC_MSG_SetDispclkFreq               0x4
 #define VBIOSSMC_MSG_SetDprefclkFreq              0x5
@@ -96,6 +102,12 @@ static int dcn301_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 
 	result = dcn301_smu_wait_for_response(clk_mgr, 10, 200000);
 
+	smu_print("SMU response after wait: %d\n", result);
+
+	if (result == VBIOSSMC_Status_BUSY) {
+		return -1;
+	}
+
 	/* First clear response register */
 	REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Status_BUSY);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index c5d7d075026f..6a17f7ed4d01 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -40,6 +40,12 @@
 #define FN(reg_name, field) \
 	FD(reg_name##__##field)
 
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	CTX->logger
+#define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
+
 #define VBIOSSMC_MSG_TestMessage                  0x1
 #define VBIOSSMC_MSG_GetSmuVersion                0x2
 #define VBIOSSMC_MSG_PowerUpGfx                   0x3
@@ -104,6 +110,8 @@ static int dcn31_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 	result = dcn31_smu_wait_for_response(clk_mgr, 10, 200000);
 	ASSERT(result == VBIOSSMC_Result_OK);
 
+	smu_print("SMU response after wait: %d\n", result);
+
 	if (result == VBIOSSMC_Status_BUSY) {
 		return -1;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 2600313fea57..74a78fda62fb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -70,6 +70,12 @@ static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D
 #define REG_NBIO(reg_name) \
 	(NBIO_BASE.instance[0].segment[regBIF_BX_PF2_ ## reg_name ## _BASE_IDX] + regBIF_BX_PF2_ ## reg_name)
 
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	CTX->logger
+#define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
+
 #define mmMP1_C2PMSG_3                            0x3B1050C
 
 #define VBIOSSMC_MSG_TestMessage                  0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
@@ -132,6 +138,8 @@ static int dcn315_smu_send_msg_with_param(
 	result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
 	ASSERT(result == VBIOSSMC_Result_OK);
 
+	smu_print("SMU response after wait: %d\n", result);
+
 	if (result == VBIOSSMC_Status_BUSY) {
 		return -1;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
index dceec4b96052..b2d1f24cfb80 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
@@ -58,6 +58,12 @@ static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E0000
 #define FN(reg_name, field) \
 	FD(reg_name##__##field)
 
+#include "logger_types.h"
+#undef DC_LOGGER
+#define DC_LOGGER \
+	CTX->logger
+#define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
+
 #define VBIOSSMC_MSG_TestMessage                  0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
 #define VBIOSSMC_MSG_GetPmfwVersion               0x02 ///< Get PMFW version
 #define VBIOSSMC_MSG_Spare0                       0x03 ///< Spare0
@@ -120,6 +126,8 @@ static int dcn316_smu_send_msg_with_param(
 	result = dcn316_smu_wait_for_response(clk_mgr, 10, 200000);
 	ASSERT(result == VBIOSSMC_Result_OK);
 
+	smu_print("SMU response after wait: %d\n", result);
+
 	if (result == VBIOSSMC_Status_BUSY) {
 		return -1;
 	}
-- 
2.25.1

