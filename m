Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AD5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8515F10E215;
	Fri,  8 Jul 2022 16:36:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5184610E21D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz+kU74OlfevDTrICIT8dOsHzSvhP3JMM5rxidhR2H9Bc7oookA+S6yAMD/UBLJiz/OpDQqtP+WQBnPxUbJC4Znsxn0iSR6Mx+oUzqoRksZ4mtCV9qQ5r3GNkH1H/9tOWwuIYpEkkFjuaYpz1vqmfgj/CBmuNa+vJNPCmMukLYNPvgxjymobnWggiJ9gJ1aHPYEtnt4EDmd3/yIH8C47TN3nZyJMGY18EUvfEkiT8hQPnAYSoJQB8SbifQGlGGU8UeoN2Geq7CH0ph2TMqs5lfCazPt433dWIQyqZMmsXy3tqFsDJaI1u3mwUPTywxYRZGnouO61uty4iDG2E4+3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jQKf40+wdYb45TraxgJkvDGbIDu9LYOZE+oTKhaHr0=;
 b=MZAyDe13PYGE2m3fyvXxkaO+TLcLUxtrkIf+lPumlqhBhkndK9A1Srtxp9uZJrrKCdt4riUG9qthsdth+xmDbEZd6KDDCyGzmQT8B1AyTdfIkWHhCsci6lRSBtIuhzIsFY6JTmfUBFFuYvsv2tMTCL6c5PbORytLjWpSuU/48cIIh2vd8OLqAyGZIliRyB2JrvObWO7aM+VQmmusC98iOdYOVQcfygCfOw9Ruyfu/2iZ8C7KzBuwdWxp7mo559UGy2Nts3GDd+YWAhUGDW3kEIWmnXB+7G8aYwl47IYmyiMwrwIUIaPceZKybyrPCAXqkAH6YFqV9tmXvquxlEsHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jQKf40+wdYb45TraxgJkvDGbIDu9LYOZE+oTKhaHr0=;
 b=lLLw4smXQlDNrPYW904fYXhH9wVJ0rGZjYQq/jvmJY88fU86CmC/5b7I9xvqHxGqFjbTNPyYtZIOFuQulzUadko3Toigbske0UIblUhKGIl9OIa9KEF7tL3rqtcvaC0oGmX0ZM7lWZF+kpGCDvCHvvn5VhRlUsoPcPAeFJt45gI=
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by DM6PR12MB4864.namprd12.prod.outlook.com (2603:10b6:5:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 16:36:23 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::4d) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.16 via Frontend Transport; Fri, 8 Jul 2022 16:36:23 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:18 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/21] drm/amd/display: Removing assert statements for Linux
Date: Sat, 9 Jul 2022 00:35:12 +0800
Message-ID: <20220708163529.3534276-5-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aec2015-f804-4e3a-76e8-08da60fffeb0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4864:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUPO1uhAAa+GuBRejrjXrsmp7I3DLVXpN81ME2D6oqRLXfWLtuQbW+d0o6eoCG5yqbQmwy7JXgIInUVcBbipTeBaytJmbwRK/eEYIx3YHoJwBG+Bnppe5YaIdO48h0mj8gSxGfhdyPqkyP72qOw5Ff74P7JScuJZu4bVaE5xRSbzeWDeUW1xIlLK6AIUjIMnLRvBeC+4pIX6Vtimd/8uX+Fr1blgFVqspS+HfmL+Mo92H/WDxt5wOhMJ7GAt5/L3yd07Z0JjREBlx3Qcp0Rxqj3TY0U6bHR7Ei2LnrV1Eyi02CEMrZ4L60c2YLHit96jJOFQIcNvWTfBmjxiSuF1W4tXJNNdEUixhMtFmflwwFSSWXuRVIXiBIQVh4bCMf8zxzL0vdVB7IdRjKsOCr6G4LL2oj/2ChJr5aViK/yxYXx9/LLAuzj0T8Hb0dvos7m/9abjiLd8UNaBdZccz6o2gJqukmpTxEfssX01vPhwvOKpqBo/1Vmfj8Lus6lO+rcyCLesl+k87ZGlkv8/VqsPxH/LChRY90jx0BcNMbUFURWnduuooEOlBCQxe6N5vWgSfdTmdNLhZdJABoNsiXsnGXEBHz+8JNrAsc3UDSmQwoD5He4HRy/xPWlepMgPpvuf9Ea1A+qb6ZUm6jH6RRkzwjm7Y+4ugx5jFBZs8ikv1n5txrNmGBCCKPbFU7YPkKW4CIVc9V4zbzzsfDAsd0CRathP6zqBjaeXzHHTC434NkAPxisVlmlxuqu+6AHmHNMQTdLV1cKqzt2I2+6CIq6HyiND6X3EN0yxDFbzlX+9mUFKRDpGj/bS7YHgDFgxHhpUnMgRtjGNF/hMCYHMYWfB7Q5BNXMsPCB0JGhHhtKSz4AygHWpnp345Gl720qWnjXg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(40470700004)(6916009)(26005)(7696005)(86362001)(40460700003)(2616005)(478600001)(36860700001)(426003)(41300700001)(2906002)(8936002)(6666004)(44832011)(5660300002)(1076003)(82310400005)(82740400003)(16526019)(186003)(81166007)(336012)(40480700001)(36756003)(70586007)(356005)(34020700004)(70206006)(316002)(54906003)(4326008)(83380400001)(8676002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:23.1626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aec2015-f804-4e3a-76e8-08da60fffeb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4864
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Gabe Teeger <Gabe.Teeger@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Saaem Rizvi <SyedSaaem.Rizvi@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>

[WHY]
Assert statements causing several bugs on Linux DM

[HOW]
Removing assert statement for Linux DM
(ASSERT(result == VBIOSSMC_Result_OK)). Also adding
logging statements for setting dcfclk.

Reviewed-by: Gabe Teeger <Gabe.Teeger@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 8 ++++++--
 .../gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c    | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  | 8 ++++++--
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c    | 8 ++++++--
 .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c    | 8 ++++++--
 5 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
index 4137394a6ace..27fbe906682f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
@@ -101,9 +101,9 @@ static int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 	uint32_t result;
 
 	result = rn_smu_wait_for_response(clk_mgr, 10, 200000);
-	ASSERT(result == VBIOSSMC_Result_OK);
 
-	smu_print("SMU response after wait: %d\n", result);
+	if (result != VBIOSSMC_Result_OK)
+		smu_print("SMU Response was not OK. SMU response after wait received is: %d\n", result);
 
 	if (result == VBIOSSMC_Status_BUSY) {
 		return -1;
@@ -188,6 +188,10 @@ int rn_vbios_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int reque
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
+#ifdef DBG
+	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
+#endif
+
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index d8f03328558b..e4f96b6fd79d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -102,7 +102,8 @@ static int dcn301_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 
 	result = dcn301_smu_wait_for_response(clk_mgr, 10, 200000);
 
-	smu_print("SMU response after wait: %d\n", result);
+	if (result != VBIOSSMC_Result_OK)
+		smu_print("SMU Response was not OK. SMU response after wait received is: %d\n", result);
 
 	if (result == VBIOSSMC_Status_BUSY) {
 		return -1;
@@ -179,6 +180,10 @@ int dcn301_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
+#ifdef DBG
+	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
+#endif
+
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 6a17f7ed4d01..090b2c02aee1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -108,9 +108,9 @@ static int dcn31_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 	uint32_t result;
 
 	result = dcn31_smu_wait_for_response(clk_mgr, 10, 200000);
-	ASSERT(result == VBIOSSMC_Result_OK);
 
-	smu_print("SMU response after wait: %d\n", result);
+	if (result != VBIOSSMC_Result_OK)
+		smu_print("SMU Response was not OK. SMU response after wait received is: %d\n", result);
 
 	if (result == VBIOSSMC_Status_BUSY) {
 		return -1;
@@ -202,6 +202,10 @@ int dcn31_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int requeste
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
+#ifdef DBG
+	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
+#endif
+
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 74a78fda62fb..925d6e13620e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -136,9 +136,9 @@ static int dcn315_smu_send_msg_with_param(
 	uint32_t result;
 
 	result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
-	ASSERT(result == VBIOSSMC_Result_OK);
 
-	smu_print("SMU response after wait: %d\n", result);
+	if (result != VBIOSSMC_Result_OK)
+		smu_print("SMU Response was not OK. SMU response after wait received is: %d\n", result);
 
 	if (result == VBIOSSMC_Status_BUSY) {
 		return -1;
@@ -205,6 +205,10 @@ int dcn315_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
+#ifdef DBG
+	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
+#endif
+
 	return actual_dcfclk_set_mhz * 1000;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
index b2d1f24cfb80..457a9254ae1c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
@@ -124,9 +124,9 @@ static int dcn316_smu_send_msg_with_param(
 	uint32_t result;
 
 	result = dcn316_smu_wait_for_response(clk_mgr, 10, 200000);
-	ASSERT(result == VBIOSSMC_Result_OK);
 
-	smu_print("SMU response after wait: %d\n", result);
+	if (result != VBIOSSMC_Result_OK)
+		smu_print("SMU Response was not OK. SMU response after wait received is: %d\n", result);
 
 	if (result == VBIOSSMC_Status_BUSY) {
 		return -1;
@@ -191,6 +191,10 @@ int dcn316_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int request
 			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
 			khz_to_mhz_ceil(requested_dcfclk_khz));
 
+#ifdef DBG
+	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n", actual_dcfclk_set_mhz, actual_dcfclk_set_mhz * 1000);
+#endif
+
 	return actual_dcfclk_set_mhz * 1000;
 }
 
-- 
2.25.1

