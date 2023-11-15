Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9944C5AE5E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641A910E58B;
	Wed, 15 Nov 2023 19:44:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E39110E58D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ligUYtCLahS+U67cplAEzl3mRXA/mcSx6TmMvlBJJSDViNx4fPNvVWeqM3i9a4oALO8pqIHfC8SwJGOKJA3sUmmNgSF3SXH1eZotvF1eFpvfkevLyQjbxqhIcjaDTv7ksJe34FSwSUzduC/xLOOCXCL+lnvY5U2TSZliys+ETginGt0Z21IqHRH2emUUkUgxEyKY2dleOviHniAJIvvXbkvVd5XC84SA59x7zrQU6+E1whWPpiIJyLefA9wbz65d1D8kX3lJpfiAc4Rxg2TRJCKVrpA7HVnnLQ4x79ux6oS0FzEJJsfU91d0xBRBPZrF2K3nH6MnL0r3fvCsaKchlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//rXNA3Vm6bV56mxDXRwjZ9A7gWSEZRrzoJzuWGIK0w=;
 b=KKmUN99E7j7c/BOXdAGIlJcOfIi2IUyJKTkHf5iA1Mb7I4Voz7LIwLl8+g8gvfwubhifDxCwoBmIdy6aK5UjOR6v1gcM/LuTSJS1pJVEFiRPZQVZ5vdCe71SauAB7amIGLVaJv+OA8UX6pM5FPZ73kfQciPABWfu9mztG0WBHoVwoXMWR9oz6ebjeONsdzJFMH/Sa+g6Ygaia4X/EKlCSwZ6xaM5Po/BS/7Z14s5KPsPIaolvcs90Qd1KW/uP1J1jSnOfFivVVmhyMi7lLjcWENTw0I3eMhb/5iLC6nTlpD4Cn+ADP2PaxTbF3tGUOgYWCRHVPB1bagHoFa85MQ9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//rXNA3Vm6bV56mxDXRwjZ9A7gWSEZRrzoJzuWGIK0w=;
 b=UBBbmkYMRa5uZ8NUoe4QOjT+MVnyYRPPfuqWx5NX+dMlphFhW15Ix5jVsHMRrwWt+zQyTz0klYads7IPPqcK8wdCkICXkc7qHnoxOKzRiO+FekyvGbhGUH9gJyFmHymtIMybbcO19lEgVsRVQAQ2UIud/xJLFx4T8OXSt+EuK/g=
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:39 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::61) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 19:44:39 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:36 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/35] Revert "drm/amd/display: Enable CM low mem power
 optimization"
Date: Wed, 15 Nov 2023 14:40:38 -0500
Message-ID: <20231115194332.39469-26-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 571f7d11-c13c-4d5a-bc0f-08dbe6134e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DflMSt4+SiS99rSFpmukNJ//sMX500GCsiGuwxxSyJNkXoN9EE6jR9W/ypCqlsP8AwHpO3e51lM5X1JTkzt7LfGqysY01Mba/CoMlshV65+ONxEsm6uBtekb/YK0U7yFj7kjsemFycpWHE7dnP/9g3dAKGKd7/6tf5xJcvsk/nH7iPMsXmss6W7oLt1v07KhVFLGI++P77yWAD+CMUVMroUrlxFJ2SQJTOVSajrBz0jyCDvjWal2S41/1uBmBF5qdR/brhDo3hEpXPzxL64iPOudonyaqvV+QacC3DRGHAOMVNUSNICNsloiL12PqcK5d6f5Kmv7Opb3gY8o9bXLHxpivcGCo1GJBQzQSDqyX5dmS6URPi3+AKOu33B4B8Hc2Liry/1pXc+2o1xwQCtcEK77QKDhQmXXtlbbQ0DCEfhtM9ZCA9VgEICm2z5PnHbd26crKPWxn0kzAhayEw5Sz424K6VhcZ41n5kEw/3c1St6dMiG4z9Qs4TOlmayupgM9tP4WSp4BNfx0OJKafkfJGCOFnYi2vV6jgJDOtBFtDuHKvnhk7iXuVSLlEMnREEl46DzCq6gMeffVRX7cwKiFTq7uoiJ0h8iFRfeNPkmwEYWQEGDTVpUDYDP2VzyW1B/zkbHeTesn5fV4PS0aL050kEckPI+gfA/5ysYUHgRpriRRLIuv7LuEbl/sfMhMkJL+liCXgns2Z9m1Hr7dRENKQ0I7kwpkWpISHa5f04AYbXR0ARxirkU092xEMUTZJrVF/CRjj3OI3gLM0lVivqpLkb8mivHXyFwQZ/92W97y6ylXE+QpT1qhENnP/lCbnw/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(2616005)(336012)(426003)(26005)(1076003)(16526019)(81166007)(356005)(40460700003)(36756003)(86362001)(82740400003)(70206006)(44832011)(83380400001)(5660300002)(478600001)(4326008)(47076005)(316002)(36860700001)(54906003)(8676002)(6916009)(70586007)(8936002)(2906002)(41300700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:39.1821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 571f7d11-c13c-4d5a-bc0f-08dbe6134e19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Yihan Zhu <yihan.zhu@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Gabe
 Teeger <gabe.teeger@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

This reverts commit c2925d905ede9f7023168857e8f488136e56a1d4.

[why]
Flickering observed. Regression search pointed to this being
the offending commit.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c    | 13 +++++--------
 .../amd/display/dc/resource/dcn35/dcn35_resource.c  |  2 +-
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index 1a2adb354718..994b21ed272f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -71,24 +71,21 @@ void mpc32_power_on_blnd_lut(
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
-/*
 	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.cm) {
 		if (power_on) {
 			REG_UPDATE(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_FORCE, 0);
 			REG_WAIT(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_STATE, 0, 1, 5);
 		} else if (!mpc->ctx->dc->debug.disable_mem_low_power) {
-			//TODO: change to mpc
-			dpp_base->ctx->dc->optimized_required = true;
-			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
+			ASSERT(false);
+			/* TODO: change to mpc
+			 *  dpp_base->ctx->dc->optimized_required = true;
+			 *  dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
+			 */
 		}
 	} else {
 		REG_SET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], 0,
 				MPCC_MCM_1DLUT_MEM_PWR_FORCE, power_on == true ? 0 : 1);
 	}
-*/
-
-	REG_SET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], 0,
-			MPCC_MCM_1DLUT_MEM_PWR_FORCE, power_on == true ? 0 : 1);
 }
 
 static enum dc_lut_mode mpc32_get_post1dlut_current(struct mpc *mpc, uint32_t mpcc_id)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 0d5a03c6d812..53eefba0b9dc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -736,7 +736,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.i2c = true,
 			.dmcu = false, // This is previously known to cause hang on S3 cycles if enabled
 			.dscl = true,
-			.cm = true,
+			.cm = false,
 			.mpc = true,
 			.optc = true,
 			.vpg = true,
-- 
2.42.0

