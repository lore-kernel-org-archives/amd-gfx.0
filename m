Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E07C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7201010ED73;
	Mon,  7 Mar 2022 05:52:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C95F10ED6E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo7ruZvaucYJmUl4VgN68urc8WEobJrpXE/PvwSFi6pjDrEQ6jsvY9p8qrvyVf0Py7GQeY8vab1CrGoNTfIwU7nykWCDJvTKS846OfkhxFwO4qYFV2VHxWqW1CjLEJi/74+jBBtti6YWnnUl68sQlJnUq0ecfYe/2vARhu4XYCeJ0AA2FnvE7QQMUeeJQp87I2hRqKj3ojiMWiCWKlytWaXdnERC+vGElMlG/VMeW3vynYFvxPTrjJEf0hnMlLNsmbg8s+XeZTWSZNdnL6T7AcYk3VaYaPdreffx024ziEqHhm+9ljlW2wNgtX4Twbfj5sq5qdgsJW5Ddb5NCIUvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AmSS62/NZ4ZfJJCI4aPvJA3M1JldqUmDZnO7jp47nQ=;
 b=dkP87zMIvfOI/nrtCNx0UxosHKzDWzhWipOW8Doc5REWHZ9PBFLTJ3aJ9en5A1GOqRuL0YyPZP+LGF0EHK03mHuVhpqbkGf/NFanqfMGup+/S5/O3FzaQXjzKiflSdkO2LcjRJerqsdsav1UhgbHCfistIgdj1fjab1KHCgxJXMN4EVnVc+pWjaA8Urd1yR0makEC+tUBbFHDVoDA2avLIVje3nLjnOLepuG+3jMaAccTdcckYHWqiiBOqxXQmnGsH6putweHW8uNGzuEFNdnGV7zOSwmisUX5i6R4TRAyIq8OkAfv+RHGgxfKEqP2szExBifPFfxNCoxLL8KsyojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AmSS62/NZ4ZfJJCI4aPvJA3M1JldqUmDZnO7jp47nQ=;
 b=poQLsprz9jY1P5tzVMmGxHwADLZxKxO289KlylgYsCjkWYC+/lmqluYOh26dgmmpccVhRMwOpTMJ9obJAzeCDgiO5gSXwrGXVsyUY2mWWDw33fxrRmq+rMJoowc/5L/QwFOa23ohN8EBtWFYF2nkSE9od02Kiwr7HVXb8aW2dsQ=
Received: from DM6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:5:1b3::25)
 by BYAPR12MB3287.namprd12.prod.outlook.com (2603:10b6:a03:131::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 05:51:58 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::ec) by DM6PR17CA0012.outlook.office365.com
 (2603:10b6:5:1b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:51:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:56 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:51:47 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/21] drm/amd/display: Fix compile error from
 TO_CLK_MGR_INTERNAL
Date: Tue, 8 Mar 2022 05:09:41 +0800
Message-ID: <20220307210942.444808-19-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d5f98d-32f7-4b3f-6072-08d9fffe970f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3287:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB328775CDA8279707625383A8F5089@BYAPR12MB3287.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1XL6g41amQUqXE1o/o/MbNFiO4Ngp3aE6Tx+fSBdWV7zTwsuVLCqp06Re4R7eTfwt36FJyppU88BJQpJ9fPsjrLR78hQGjhRfdMssqLeWUDWHhH7ttucEOSfGcqg7K7HEfpAyRxiiVz1SYV6L5rOT0TRegAwH3c16OqllXr8fosUT4oj8H2f4BArmtA7egJ5rnG91f8t//270CUIFqv64DkKUbSMdt8pgokBjP4SbBO8k82wPl2vAIptRs0ZcYlr35a4+FfL+gTHR4hsu7lMKL/qGzkMSH7Y46O2St2s16cXFSLumeU4ftKkGD9pMQnXj4q89CI4TrAKOU8AeqlcgGmQUIPmgW7ylwUqWUjsNWorZx9h3Lo/0QkuIou9SX6KQ7hmfYPlAv7NvtQrDZ+YDT1isLzUzqdG+bOqqittKO1fn0Twf1fkfsUJh3Bpo/bPFax2UCf7ZdTwJ/OzucvBSO3fpRgtAXqjHmH/ecqCJw+b43UDhkQK0UNSpBWuy6tFFs4C+aJDhrTYppjjJSeZU6S1NOeBR3bGuzRKX0WPGjbuMo1PVnoAl4lLf/SE+aBEKYLeAfg/Qb0zV5sqLjSDFGzNxdwC0DUKOlqODZLz9cWxgoMjB0t4OClL+l2T/TKEGc6z2FHPmyLbvNzLQ8ALODaz8C6Z03+GQIuJv5uvSNX8Sy31cHBgnDATrSPQdGwP2o+fyJeKMOwyMwaKsn7zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(426003)(83380400001)(36860700001)(6916009)(356005)(86362001)(54906003)(186003)(26005)(336012)(316002)(5660300002)(1076003)(2616005)(8936002)(36756003)(2906002)(6666004)(4326008)(8676002)(508600001)(70206006)(70586007)(82310400004)(7696005)(40460700003)(47076005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:51:56.9841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d5f98d-32f7-4b3f-6072-08d9fffe970f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3287
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

On LNX, TO_CLK_MGR_INTERNAL() only works to get clk_mgr_internal from a
given clk_mgr. In clk_mgr_dcn316 struct, the clk_mgr_internal is already
a memeber by the alias 'base'

[How]

Use &clk_mgr->base instead.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  5 +++-
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    | 26 +++++++++++++++++++
 .../display/dc/clk_mgr/dcn316/dcn316_smu.h    |  2 ++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 43120a8f8305..702d00ce7da4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -683,8 +683,11 @@ void dcn316_clk_mgr_construct(
 	}
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
-	clk_mgr->base.dccg->ref_dtbclk_khz = 600000;
+	clk_mgr->base.base.dprefclk_khz = dcn316_smu_get_dpref_clk(&clk_mgr->base);
+ 	clk_mgr->base.dccg->ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
 	dce_clock_read_ss_info(&clk_mgr->base);
+	clk_mgr->base.dccg->ref_dtbclk_khz =
+	dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn316_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
index 128614dff108..dceec4b96052 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
@@ -310,3 +310,29 @@ void dcn316_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable)
 			VBIOSSMC_MSG_SetDtbclkFreq,
 			enable);
 }
+
+int dcn316_smu_get_dpref_clk(struct clk_mgr_internal *clk_mgr)
+{
+	int dprefclk_get_mhz = -1;
+
+	if (clk_mgr->smu_present) {
+		dprefclk_get_mhz = dcn316_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_GetDprefclkFreq,
+			0);
+	}
+	return (dprefclk_get_mhz * 1000);
+}
+
+int dcn316_smu_get_smu_fclk(struct clk_mgr_internal *clk_mgr)
+{
+	int fclk_get_mhz = -1;
+
+	if (clk_mgr->smu_present) {
+		fclk_get_mhz = dcn316_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_GetFclkFrequency,
+			0);
+	}
+	return (fclk_get_mhz * 1000);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
index 658b36d0e107..2a7293f66515 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.h
@@ -133,5 +133,7 @@ void dcn316_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 void dcn316_smu_request_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz);
 void dcn316_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr);
 void dcn316_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
+int dcn316_smu_get_dpref_clk(struct clk_mgr_internal *clk_mgr);
+int dcn316_smu_get_smu_fclk(struct clk_mgr_internal *clk_mgr);
 
 #endif /* DAL_DC_316_SMU_H_ */
-- 
2.25.1

