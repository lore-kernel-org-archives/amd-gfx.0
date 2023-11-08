Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683B7C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E137110E824;
	Wed,  8 Nov 2023 19:09:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B382910E82B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m35u2aIjRyZr0rGVGX4MoMmLpXds3yomuk++rKHaI87rbOYySxTb175JxgcfBbFSjHjka2sjVyV6KNjzTfrQvHqPK3DCtqLLaUdk/5iPxG9IhuvUZRiUZkdIrA9SIlkgtfsvE7tNLmEWQWcnffU9y4AZOLYhBUCV+iVX6Kl9jwYS8KUKT1zwAJEHJjG1X1pB8Em5Z8tjb1FttnhCJlPz8mOfk6xGDPR2ReXZZpa3k+jLvojtfzmBpbdjKQWXxihhN2/ah5mX/fDaN5bILZw75hAmthBJyw49NMHHfGb3Krsb+clZ6jrkk6SuSM/qD4QTxVPDgcMDvx0TdndGPrL+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt/otNjy+EoJCvkbotGQxRN+fynnkUWUUOmhvjOqHIY=;
 b=cXGhWEGR2DHIdoZrZyJDsPUPaZsFacNB9iad+4IJrjOiVg9pG+H6W4MDNEuKclmuDjDZDDv+RlGdyneVTnI2LewGz/FknSQmKwhEDR5yHimtb1IHb11owqiAOtLO4sRUNj1uhFkNjnHq2LfAQ8XnTtn97j4+T87k0rhHJDj4ZSUG/4VsEPowErxqoectsBpWM+7ltpgujdXEubhliCPe61gzczPHp9Ostg3z2Z+v0kBlP7gbSfmi1A4NqTFQOL8y0/iDQ+QlU+FqP1BUwPbSX1M+m1fHhvo1J6eUNk5hvr1dy/GV5mz6wkig1izJCi+dK2zgxx99mcVqXdSgXx06AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt/otNjy+EoJCvkbotGQxRN+fynnkUWUUOmhvjOqHIY=;
 b=vIV4LycIFGHOxBjOZFtP4/C+cjfo4k3Vz2KXc6zyd6IHgNWz8PBiqFlY6af3e4t5hMt4UpHkYT9CQR9IPbvxFopMpc2ENgY8BG/kZYIM9Ohu59gOmEAlNRGZ5Hsi17WVlkgwwkcvKn0XillqM1Sfdm4JLpcppRP5ah7UbqiTWFY=
Received: from DM6PR08CA0054.namprd08.prod.outlook.com (2603:10b6:5:1e0::28)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 19:08:37 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::6e) by DM6PR08CA0054.outlook.office365.com
 (2603:10b6:5:1e0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:08:37 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:08:34 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/20] drm/amd/display: Add disable timeout option
Date: Wed, 8 Nov 2023 11:44:28 -0700
Message-ID: <20231108185501.45359-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be68fce-48b9-460a-7787-08dbe08e1c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2yzsh3gQWGWvHt+Zz/MCdxEvbV/GGVOUaHBWDM+HJwzDX7xYrTl+3DbfxVKnshJt2QmKBpvCYOl/raoqe5x8DzA75Alpr7bAZMVpu1AvAgtwV13FmPAP+28mHBaboWoLqUb2bKtsbAb4BT4Sb8TkmpD9ifWWg/SFoLuOtsVq9xVw+u/zHHSR5tNEkChritEqUgtjA8pCzRPNb6PlhcihSO4PNmNBeg/GnKN4Bquv2HYYABh+w5rFr0JlkpqQTSFkmu/kLEs46bp+q6QiGHs8ujH78PSjaexjKx8HN5CY1WZ9LLXtblKV+4kZQbCQFFYnK+0lmBenysjsCaZzHljpEAEvqFsQyGG691clKG6v0BYMD+577M8oYasQgMhb/jI3ty5anZwpuP7FOnnVtSzYcCwou4c/vzbWMAXniewdmpyYI8f9DHpWr7SWa5tFSYTs1zGvW2q/070PA8uvxczeE8IXti6KVtYyXVMrdcTJDQTX7Ac9u3CQ4Euo6oQszITe1sN25qVoam+ahj/gVtC1SCFgzmlMNrDqdVpA8OWloMJ++uMOhkcA9mJfSuEWGZ4O0zlQqzA0z6WYKu6O7uBuJmgfP4sjUygRelc80+ythmO5+dG5VJAqSKXsFbqp7ry/iGyYPzok1iDmcBsyzqBM9BdFJw12hUsMUs3RIYjq+xomo0ywoIOQF9vltEdNKHK9Kl6b/mdVfBXtB8OpfvZhhZn3VzzrPuJlL9N8XcpV4Hn6baNuQQGa8fWsE2JcI6APWqvgaDE/P9pPfGuyTaBpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(356005)(40460700003)(47076005)(26005)(1076003)(41300700001)(16526019)(2616005)(83380400001)(86362001)(426003)(336012)(7696005)(6666004)(82740400003)(36756003)(478600001)(36860700001)(81166007)(2906002)(44832011)(70586007)(70206006)(54906003)(6916009)(316002)(8676002)(4326008)(40480700001)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:08:37.1090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be68fce-48b9-460a-7787-08dbe08e1c8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[WHY]
Driver continues running whenever there is
is timeout from smu or dmcub.

It is difficult to track failure state
when dcn, dc or dmcub changes on root failure.

[HOW]
Add disable_timeout option to halt driver
whenever there is a failure in response.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |  3 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 29 +++++++++++++++----
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
index b6b8c3ca1572..af0a0f292595 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
@@ -116,6 +116,9 @@ static uint32_t dcn35_smu_wait_for_response(struct clk_mgr_internal *clk_mgr, un
 			msleep(delay_us/1000);
 		else if (delay_us > 0)
 			udelay(delay_us);
+
+		if (clk_mgr->base.ctx->dc->debug.disable_timeout)
+			max_retries++;
 	} while (max_retries--);
 
 	return res_val;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c5e7da302acb..18ab453bfdb1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -978,6 +978,7 @@ struct dc_debug_options {
 	bool psp_disabled_wa;
 	unsigned int ips2_eval_delay_us;
 	unsigned int ips2_entry_delay_us;
+	bool disable_timeout;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0e07699c1e83..53400cc05b5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -241,7 +241,12 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 
 	// Wait for DMUB to process command
 	if (wait_type != DM_DMUB_WAIT_TYPE_NO_WAIT) {
-		status = dmub_srv_wait_for_idle(dmub, 100000);
+		if (dc_dmub_srv->ctx->dc->debug.disable_timeout) {
+			do {
+				status = dmub_srv_wait_for_idle(dmub, 100000);
+			} while (status != DMUB_STATUS_OK);
+		} else
+			status = dmub_srv_wait_for_idle(dmub, 100000);
 
 		if (status != DMUB_STATUS_OK) {
 			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
@@ -1147,10 +1152,16 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 		return true;
 
 	if (wait) {
-		status = dmub_srv_wait_for_hw_pwr_up(dc_dmub_srv->dmub, 500000);
-		if (status != DMUB_STATUS_OK) {
-			DC_ERROR("Error querying DMUB hw power up status: error=%d\n", status);
-			return false;
+		if (dc_dmub_srv->ctx->dc->debug.disable_timeout) {
+			do {
+				status = dmub_srv_wait_for_hw_pwr_up(dc_dmub_srv->dmub, 500000);
+			} while (status != DMUB_STATUS_OK);
+		} else {
+			status = dmub_srv_wait_for_hw_pwr_up(dc_dmub_srv->dmub, 500000);
+			if (status != DMUB_STATUS_OK) {
+				DC_ERROR("Error querying DMUB hw power up status: error=%d\n", status);
+				return false;
+			}
 		}
 	} else
 		return dmub_srv_is_hw_pwr_up(dc_dmub_srv->dmub);
@@ -1187,7 +1198,7 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 	const uint32_t max_num_polls = 10000;
 	uint32_t allow_state = 0;
 	uint32_t commit_state = 0;
-	uint32_t i;
+	int i;
 
 	if (dc->debug.dmcub_emulation)
 		return;
@@ -1220,6 +1231,9 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 						break;
 
 					udelay(1);
+
+					if (dc->debug.disable_timeout)
+						i--;
 				}
 				ASSERT(i < max_num_polls);
 
@@ -1242,6 +1256,9 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 					break;
 
 				udelay(1);
+
+				if (dc->debug.disable_timeout)
+					i--;
 			}
 			ASSERT(i < max_num_polls);
 		}
-- 
2.42.0

