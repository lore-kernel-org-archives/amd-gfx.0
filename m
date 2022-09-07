Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C80C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 17:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515DA10E801;
	Wed,  7 Sep 2022 17:33:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B62F10E7FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 17:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaVPYrKzcU05ODjeshFIsLjK7VOlSyYXGVoBWtDNT+hyts1Y+qiTEeNM8yzYW6/9rBLS/iH59q0DtbjgYgGJFLJxGCrMQLePHb0brOy+y6vO7g2tx3WrwYMoYjjln8sN4fwjBKev/OhexT8JpfRwC1E6maIiUH4YQdMBasfNiemkbroSiS9j88A1kwVvbQkokAl2nIzQw6lChdDnwNKHcSnNm83/snJuMDvZSP17CKPnTiWtMvefC0hIaL8i9jXwrnU2BBOpHrB2DkSJJG5si2yuKhKvvgkpc7T/m3bwJTLYZpTgXPYSCiWJyAU1bOKRjuFZIO/9IsAiQ8CKVamRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfDzdUxSRlS3jDXI553giLKmhF645ZC6nv1HLPig+iQ=;
 b=morD0IOSsJRzGnkC0uNk1jk7dtp4OrjWMAxcuryFJy1B3vGUlYgmxQSjxonBBcb5wQYFcPkSOCR9Dy35WG9KOYNnv0pf2yR9Vpq+EMs3movo0wvJKCg2SUzACR//noOxTM/1mfPOQJXA61v7A4lcdqy11GeHDykmIbDVaENVhZCUIu9V2dgY0oVMcmXiQySiUtQwiBXfuG3+H+ZAfVCdM/hgwLH9nIZBSyOuth2qWYb7tCKPLCc0ZDmZLb9xSMBxNiUtNAYrLkugbaURNPSQbwFb96E1lVvoxzNK+4ZDajSdl5VkDle4EDtqFjA7quwoCGD2Q/De/N2MhEqfo8LW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfDzdUxSRlS3jDXI553giLKmhF645ZC6nv1HLPig+iQ=;
 b=T9Pz02/wAbgTL4WKOkMRdMts1Fcf2sF7au9BdH0zmwNfWa8dr+GtPBltGMy2QYa6ALjj1JHJOkXKiruZqvuTU0E76O7Tiq8setb/4xVMWMRFJIF4OhhEdf0dvVb/iyh9AFv4FtTHkWRJEgBc/EIMLcm5k4mjjQOL7oHNOAB7y8o=
Received: from BN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:408:ee::24)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 17:33:20 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::84) by BN0PR04CA0019.outlook.office365.com
 (2603:10b6:408:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 17:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:33:19 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:33:17 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/27] drm/amd/display: update header files
Date: Wed, 7 Sep 2022 13:32:06 -0400
Message-ID: <20220907173232.11755-2-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907173232.11755-1-pavle.kotarac@amd.com>
References: <20220907173232.11755-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 905fbd78-bd39-4b7f-4b52-08da90f70e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68ucbKZIw4G70vWo/9plhs1LCcw7V15RP5bdO/H9wfm4tVVEanGM0MghLS7lkYNnNl4I4rvECiuXQxzknM6rM724RD5QIkE4Mf0fA/osPzA2CQui2gi8Gc8HRTvzDpL+IElk3bCc/Jw0SuNl8McEUQIazkNJWZGpjruOmKTNPl3RUCKfmEtCCPCd6AxxUfys3YQ/lZIZesxYNmqwYUm4H6r6SpohOg6ErgKdd63C73HZDanJiCm0/lP9TaNWqF//NV2Jt+ZB64vcD26H+5AnaxidY7epJzeoqkfgfYnXkOn5blmEXdoyR+GoLyaqdeAcwJI57wkyIf7UB1qFZWDF6HzmEjZykAEGhiaFnKH6d726mIjNrGA1F9GdfU3wuuGBKJPZnFW4szsKeqK9/QBysgkp0c6cfy0TX8ty7zzD/eFMnzea/2ILzP4jrgU5JgXINCAksMU15vmN44VAm63GoZmmS9qi2vJFOWNk0RLG5nvxpYHeHNSQZqGiLUPGjdPtbqolISiX7ZgreF05kwpOwMUePY1Mqd7s9m3K3phXr1IAniLiCQX9THYIY3IY4YK34NqZFskZkUjMxxGvHyC68I+sOjp4StswPTYIfxACETqvLXR2HmiCJSr/rj2t4tNdSS9VnC5p9BwbkpVYO4TOlkxaV8Y85NdhmV4ag03P3+0gT+xuYuOz6Pvcnrd0s98dB1BkCiUgwaMKH9vi5M8hq6Y/fXSD0J2wVEcb50na4ljlZ4/iEVx7k5VY1PG0qNeG13d3UKu6B+8QvEPBgKMUGNhc2WpPDaRcGwJqNIYJM66fup/vsSluySkU9270YiM/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(186003)(54906003)(1076003)(2616005)(16526019)(86362001)(336012)(36756003)(36860700001)(316002)(6916009)(426003)(47076005)(6666004)(5660300002)(8936002)(70206006)(44832011)(478600001)(70586007)(41300700001)(4326008)(8676002)(40460700003)(82740400003)(40480700001)(81166007)(26005)(15650500001)(2906002)(356005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:33:19.8865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905fbd78-bd39-4b7f-4b52-08da90f70e6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
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
 Hansen Dsouza <hansen.dsouza@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hansen Dsouza <hansen.dsouza@amd.com>

[why]
update header files, and remove not used register access marco

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h |  8 --------
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h | 10 ----------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
index 694260c10a01..ccd91792991b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
@@ -215,7 +215,8 @@ void mmhubbub2_config_mcif_irq(struct mcif_wb *mcif_wb,
 	REG_UPDATE(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB_BUFMGR_SW_OVERRUN_INT_EN,  params->sw_overrun_int_en);
 
 	REG_UPDATE(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_INT_EN,  params->vce_int_en);
-	REG_UPDATE(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_SLICE_INT_EN,  params->vce_slice_int_en);
+	if (mcif_wb20->mcif_wb_mask->MCIF_WB_BUFMGR_VCE_SLICE_INT_EN)
+		REG_UPDATE(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_SLICE_INT_EN,  params->vce_slice_int_en);
 }
 
 void mmhubbub2_enable_mcif(struct mcif_wb *mcif_wb)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h
index f2580e65196c..7446e54bf5aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mmhubbub.h
@@ -227,11 +227,7 @@
 	SF(MCIF_WB0_MCIF_WB_BUF_3_ADDR_C, MCIF_WB_BUF_3_ADDR_C, mask_sh),\
 	SF(MCIF_WB0_MCIF_WB_BUF_4_ADDR_Y, MCIF_WB_BUF_4_ADDR_Y, mask_sh),\
 	SF(MCIF_WB0_MCIF_WB_BUF_4_ADDR_C, MCIF_WB_BUF_4_ADDR_C, mask_sh),\
-	SF(MCIF_WB0_MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_LOCK_IGNORE, mask_sh),\
-	SF(MCIF_WB0_MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_INT_EN, mask_sh),\
-	SF(MCIF_WB0_MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_INT_ACK, mask_sh),\
 	SF(MCIF_WB0_MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_SLICE_INT_EN, mask_sh),\
-	SF(MCIF_WB0_MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_LOCK, mask_sh),\
 	SF(MCIF_WB0_MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_SLICE_SIZE, mask_sh),\
 	SF(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK, NB_PSTATE_CHANGE_REFRESH_WATERMARK, mask_sh),\
 	SF(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK, NB_PSTATE_CHANGE_WATERMARK_MASK, mask_sh),\
@@ -363,11 +359,7 @@
 	SF(MCIF_WB_BUF_3_ADDR_C, MCIF_WB_BUF_3_ADDR_C, mask_sh),\
 	SF(MCIF_WB_BUF_4_ADDR_Y, MCIF_WB_BUF_4_ADDR_Y, mask_sh),\
 	SF(MCIF_WB_BUF_4_ADDR_C, MCIF_WB_BUF_4_ADDR_C, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_LOCK_IGNORE, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_INT_EN, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_INT_ACK, mask_sh),\
 	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_SLICE_INT_EN, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_LOCK, mask_sh),\
 	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_SLICE_SIZE, mask_sh),\
 	SF(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK, NB_PSTATE_CHANGE_REFRESH_WATERMARK, mask_sh),\
 	SF(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK, NB_PSTATE_CHANGE_WATERMARK_MASK, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h
index 22355051f5f7..e460cf8d9041 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h
@@ -90,7 +90,6 @@
 	SF(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB_BUFMGR_SW_OVERRUN_INT_EN, mask_sh),\
 	SF(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB_BUFMGR_SW_LOCK, mask_sh),\
 	SF(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB_BUF_ADDR_FENCE_EN, mask_sh),\
-	SF(MCIF_WB_BUFMGR_STATUS, MCIF_WB_BUFMGR_VCE_INT_STATUS, mask_sh),\
 	SF(MCIF_WB_BUFMGR_STATUS, MCIF_WB_BUFMGR_SW_INT_STATUS, mask_sh),\
 	SF(MCIF_WB_BUFMGR_STATUS, MCIF_WB_BUFMGR_SW_OVERRUN_INT_STATUS, mask_sh),\
 	SF(MCIF_WB_BUFMGR_STATUS, MCIF_WB_BUFMGR_CUR_BUF, mask_sh),\
@@ -101,7 +100,6 @@
 	SF(MCIF_WB_BUF_PITCH, MCIF_WB_BUF_CHROMA_PITCH, mask_sh),\
 	SF(MCIF_WB_BUF_1_STATUS, MCIF_WB_BUF_1_ACTIVE, mask_sh),\
 	SF(MCIF_WB_BUF_1_STATUS, MCIF_WB_BUF_1_SW_LOCKED, mask_sh),\
-	SF(MCIF_WB_BUF_1_STATUS, MCIF_WB_BUF_1_VCE_LOCKED, mask_sh),\
 	SF(MCIF_WB_BUF_1_STATUS, MCIF_WB_BUF_1_OVERFLOW, mask_sh),\
 	SF(MCIF_WB_BUF_1_STATUS, MCIF_WB_BUF_1_DISABLE, mask_sh),\
 	SF(MCIF_WB_BUF_1_STATUS, MCIF_WB_BUF_1_MODE, mask_sh),\
@@ -116,7 +114,6 @@
 	SF(MCIF_WB_BUF_1_STATUS2, MCIF_WB_BUF_1_C_OVERRUN, mask_sh),\
 	SF(MCIF_WB_BUF_2_STATUS, MCIF_WB_BUF_2_ACTIVE, mask_sh),\
 	SF(MCIF_WB_BUF_2_STATUS, MCIF_WB_BUF_2_SW_LOCKED, mask_sh),\
-	SF(MCIF_WB_BUF_2_STATUS, MCIF_WB_BUF_2_VCE_LOCKED, mask_sh),\
 	SF(MCIF_WB_BUF_2_STATUS, MCIF_WB_BUF_2_OVERFLOW, mask_sh),\
 	SF(MCIF_WB_BUF_2_STATUS, MCIF_WB_BUF_2_DISABLE, mask_sh),\
 	SF(MCIF_WB_BUF_2_STATUS, MCIF_WB_BUF_2_MODE, mask_sh),\
@@ -131,7 +128,6 @@
 	SF(MCIF_WB_BUF_2_STATUS2, MCIF_WB_BUF_2_C_OVERRUN, mask_sh),\
 	SF(MCIF_WB_BUF_3_STATUS, MCIF_WB_BUF_3_ACTIVE, mask_sh),\
 	SF(MCIF_WB_BUF_3_STATUS, MCIF_WB_BUF_3_SW_LOCKED, mask_sh),\
-	SF(MCIF_WB_BUF_3_STATUS, MCIF_WB_BUF_3_VCE_LOCKED, mask_sh),\
 	SF(MCIF_WB_BUF_3_STATUS, MCIF_WB_BUF_3_OVERFLOW, mask_sh),\
 	SF(MCIF_WB_BUF_3_STATUS, MCIF_WB_BUF_3_DISABLE, mask_sh),\
 	SF(MCIF_WB_BUF_3_STATUS, MCIF_WB_BUF_3_MODE, mask_sh),\
@@ -146,7 +142,6 @@
 	SF(MCIF_WB_BUF_3_STATUS2, MCIF_WB_BUF_3_C_OVERRUN, mask_sh),\
 	SF(MCIF_WB_BUF_4_STATUS, MCIF_WB_BUF_4_ACTIVE, mask_sh),\
 	SF(MCIF_WB_BUF_4_STATUS, MCIF_WB_BUF_4_SW_LOCKED, mask_sh),\
-	SF(MCIF_WB_BUF_4_STATUS, MCIF_WB_BUF_4_VCE_LOCKED, mask_sh),\
 	SF(MCIF_WB_BUF_4_STATUS, MCIF_WB_BUF_4_OVERFLOW, mask_sh),\
 	SF(MCIF_WB_BUF_4_STATUS, MCIF_WB_BUF_4_DISABLE, mask_sh),\
 	SF(MCIF_WB_BUF_4_STATUS, MCIF_WB_BUF_4_MODE, mask_sh),\
@@ -172,11 +167,6 @@
 	SF(MCIF_WB_BUF_3_ADDR_C, MCIF_WB_BUF_3_ADDR_C, mask_sh),\
 	SF(MCIF_WB_BUF_4_ADDR_Y, MCIF_WB_BUF_4_ADDR_Y, mask_sh),\
 	SF(MCIF_WB_BUF_4_ADDR_C, MCIF_WB_BUF_4_ADDR_C, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_LOCK_IGNORE, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_INT_EN, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_INT_ACK, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_SLICE_INT_EN, mask_sh),\
-	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_VCE_LOCK, mask_sh),\
 	SF(MCIF_WB_BUFMGR_VCE_CONTROL, MCIF_WB_BUFMGR_SLICE_SIZE, mask_sh),\
 	SF(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK, NB_PSTATE_CHANGE_REFRESH_WATERMARK, mask_sh),\
 	SF(MCIF_WB_NB_PSTATE_LATENCY_WATERMARK, NB_PSTATE_CHANGE_WATERMARK_MASK, mask_sh),\
-- 
2.34.1

