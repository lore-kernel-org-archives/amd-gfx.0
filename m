Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020FDC982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7202010ECA2;
	Wed, 16 Sep 2026 17:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eMpngvw3";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4215310ECBE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enPW/TaHSrEoPDWaOIWta8v5q3KSOS1aQ6/9Ut9uCuyFkrUOe6Bj6urInYv7c/2I7MoCAxefsgiAL8v0FjQL1Hr7mxXnHBgcM81jHfZW2oK3DFyyVMt4J5miLSr2Z1J06bj+eKwMbkAfBdw065qAeaA1G93/lqA8uGto4tYWhH0iVYwU8+XxLfXjWFQzC3uRh32p2kjFooycTUL9wzwjVwj7xbIo0+nmes1qWHpKc3LDM6qlUlKpi7T7rEBVf/J0+5p7AW8WEtd+U5FVtZIsnsdD1cUXtZ/k5+J+F7SJG4+6ERL5vGdPEq8GxHk8TCq3QtCQkBMDc+vT7jnI1Yf88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DckL1uPgDXEf1aB4wsIDtH3xSNkkaH4n7FF1rTYkgDg=;
 b=aTYanIxv0Lvg8YFgFtf7OKsxWC5411l4awzjq4Genl3Eb6otWymCHcfop1rcfRpU3MC04CTLvW51zRmObHzpjJngVtnUhoyeE+F48VbVxRv8S36OgzSiP6VnTJSKgGrcccy6Uvkh09BZKidbDxioJgesjnBnDzZRAKiRADEs4A+pntZzzk4mRvGjMrf7Zd+cpxxikPlEX2CndVMw+AGK4ghVv7srNZVl9Bnh0qJtlz+AStuzJxa31pAxGgKqdt0nPS629kcbiooLCh/BBZDzI292tMM0NSa3rnXno3gN8//L4RjuwIgESIZZECBybi8dNqEqr8Xy0ImV7fDZKqysfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DckL1uPgDXEf1aB4wsIDtH3xSNkkaH4n7FF1rTYkgDg=;
 b=eMpngvw3QbwgrsI/i4D9k7Azzi+a3VFkaHY6fIYZM3Dnvo3Ll6jJOkxT3hGLWdsDBHBkz1dPfonVE6lAfrsmHmn4SJzsB0Ql91eM4KNdaPrXD4BJ6JKDTau77Bt5SihBFP52XxjJ5KsW8kdFbKpDwNMxaI+puPAw8tQ+sU3s1Ic=
Received: from CH0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:610:e4::17)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 17:52:45 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::5d) by CH0PR03CA0192.outlook.office365.com
 (2603:10b6:610:e4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:45 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:34 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 27/64] drm/amd/display: Re-enable P-State message to SMU
Date: Wed, 16 Sep 2026 13:51:42 -0400
Message-ID: <20260916175301.368306-28-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 726e23bc-b135-411e-23c2-08df141b5063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sFHTdMwYZtneFIgnFN3KnI+Gx/ppOWgpR4zmG5RwRK3gJ8Zi8YCN8CYxKFXBBiTueKTtPfB5VTJ+MdOVMXWeOHFVAqziKEdwN7VmM0B48Fkh4kMFeOPCuMZGnQ1puJxiGVWPGafsTJI7OvRHyCdKYDEn88f7X4SKAc8BHXOWua+TOBzFpMoCfk7GPohqQNc9q/KGmwhrMDLAQaCqMZTh79JvNC3D52CToVT2DZAuw6xnF6wkEmkGwRgtRDp0rII5v2Kwj8HGgvm2nTGpFITEVEQTYL2CQoXPGjuT3KSD5+bzw5kq6YW8BDpiQCZLxnu1+EZP1PghNExd5UXslgMzmAjGptyPkrYKoZKSVfp90VqEHdtp+AHMbYepT7rC1UvTI0xedLxxMov9lQ1NWa13yEVjVBGbqgtJngfdqN6tkoiTwaX7GhLYQEkB+vlo+0+ZqR0VytMk/DiK2tZZ8rvGzAssicQZoEvff2KiUTTAzBNXIUBAwwv/u8/+L4Mhgjjk+Zs8McN1Qqrd1bZFyOL13g6z4Izop1LIyFNgSWGVtDQQXUBYC5oMniU8GY5li0zVphPRurRYT9bxF+DFbGRDtYP+mEoeJbNQe1kaUoQbGWWtBmQBkYURQOpMBBRtGncdh1LMVkti7p0jRMwRNxh+4R7lzbf3ROhU72aHMoLCF/zmzBWf0eSLscJQzJw4ZSAadI3CBT4yyI/obB3f/mZctg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S5Ys12pa5KhD734bdcwm54I5T6AkzDwTqzTUtsNHh5ysXm30ZPwH1GhMI9GI2mGimMNyGpBOOIcWppG1HhJ8VHMT1YZeCJME+kPVTLa59RxOcvRGjlFv8QktDXuiRlXLBMz47k2qdin1N6zC5xWOiVMpO/jrcmTLUshKoIXnQPeCbc+9CcypAR7cFt+bNPrVgZ4YKFK2hd3NgI/9UOURJu3C0KUJY8eHF2OGa6Fp0J66olpfTVm+PmT0tG7OVyqpteL4vx/Y0FYAwbHeQDro+ckPmzhuK2IK/O6keYy7zK6e18D+vfmdPY30jvxWM8n5OurUNA8lgCaEfp/xB+E+Uvs6251SvuqdgewuiMyjX0tJ3Gig68hds6EOFznaPwWaToO4ppgme3Hincmpob41sA9JbKCdPIXpn6qZF0oiid+FQAOkE95f88vvBP35X2v7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:45.4664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726e23bc-b135-411e-23c2-08df141b5063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Re-enable P-State message to SMU now that support has been added on
SMU side

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |  3 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c  | 36 +++++++------------
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
index 9b109959bd7f..234777bdd183 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
@@ -170,7 +170,8 @@ typedef struct {
 #define DALSMC_MSG_ReturnHardMinStatus          0x19 ///< Return hard min status
 #define DALSMC_MSG_GetDispclkFreq               0x1A ///< Get display clock frequency. Return in MHZ
 #define DALSMC_MSG_GetDppclkFreq                0x1B ///< Get DPP clock frequency. Return in MHZ
-#define DALSMC_Message_Count                    0x1C ///< Total number of VBIS and DAL messages
+#define DALSMC_MSG_IndicatePstateStatus         0x1C ///< Set UCLK/FCLK related actions
+#define DALSMC_Message_Count                    0x1D ///< Total number of VBIS and DAL messages
 
 /** @}*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
index f56a49151c4d..5c1c95160892 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
@@ -398,29 +398,19 @@ void dcn60_smu_indicate_pstate_status(struct clk_mgr_internal *clk_mgr,
 		bool allow_fclk, bool allow_uclk,
 		bool wait_resp, bool drr_enable, bool alt_ch_enable)
 {
-	//TODO: Re-enable this function once PMFW has support for this message
-	// Temporary until message is implemented on PMFW side
-	(void)clk_mgr;
-	(void)allow_fclk;
-	(void)allow_uclk;
-	(void)wait_resp;
-	(void)drr_enable;
-	(void)alt_ch_enable;
-
-	//DALSMC_IndicatePstateStatus_arg_t arg = {};
-
-	//smu_print("SMU Indicate pstate status: allow_fclk=%d allow_uclk=%d wait_resp=%d drr_enable=%d alt_ch_enable=%d\n",
-	//		allow_fclk, allow_uclk, wait_resp, drr_enable, alt_ch_enable);
-
-	//arg.AllowFclk = allow_fclk ? 1 : 0;
-	//arg.AllowUclk = allow_uclk ? 1 : 0;
-	//arg.WaitResp  = wait_resp ? 1 : 0;
-	//arg.DrrEnable = drr_enable ? 1 : 0;
-	//arg.AltCh = alt_ch_enable ? 1 : 0;
-
-	// DALSMC_MSG_IndicatePstateStatus not defined in latest dalsmc.h header. Comment out for now.
-	//dcn60_smu_send_msg_with_args(clk_mgr,
-	//		DALSMC_MSG_IndicatePstateStatus, arg.Args, NULL, NULL);
+	DALSMC_IndicatePstateStatus_arg_t arg = {};
+
+	smu_print("SMU Indicate pstate status: allow_fclk=%d allow_uclk=%d wait_resp=%d drr_enable=%d alt_ch_enable=%d\n",
+			allow_fclk, allow_uclk, wait_resp, drr_enable, alt_ch_enable);
+
+	arg.AllowFclk = allow_fclk ? 1 : 0;
+	arg.AllowUclk = allow_uclk ? 1 : 0;
+	arg.WaitResp  = wait_resp ? 1 : 0;
+	arg.DrrEnable = drr_enable ? 1 : 0;
+	arg.AltCh = alt_ch_enable ? 1 : 0;
+
+	dcn60_smu_send_msg_with_args(clk_mgr,
+			DALSMC_MSG_IndicatePstateStatus, arg.Args, NULL, NULL);
 }
 
 static bool dcn60_smu_transfer_table_smu_2_dram(struct clk_mgr_internal *clk_mgr,
-- 
2.55.0

