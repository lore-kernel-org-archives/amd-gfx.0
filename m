Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34875C6FD19
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8DDF10E9A7;
	Fri, 10 Mar 2023 09:32:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FD010E9A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzis6TcFonaPvzAjmAFl3GQKu2j8yGTmzIsUSYMuLVWtYQeLDcc4IzcKw2mE/FIVc+C7Ccx2E+zXkV3AfAv2mPKjH5XH1MDDGv2EHFvHP4H57rqk4Yo8GqIpLt7FAWNjGtI1kpJgUoPskkfnjOhgwWUzX/z7zjGHJNk8UfVpZtmQeS075WC7txG9RS7mA+b+5veN4dr0XQ3Xdv/HFXgPvoWb/WsjLGV0g8/cVsKOP2MuAIA9wlaBe3lfmqpOS29qQw0W5W9pr/azgu9MCzDImv3bAgk2b/sdyss6zxjhRtDPO+T7mWhnaN/UZ6uMl2BpZOGNhH+ScmR2uOGTJwwtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEVmeE75iOmf79gxcJp1jOubG+CCZkDC9LLEsVhgcXE=;
 b=bxvoVdndgErhBTdolThQ4+osEDK74RedxTbxsWCzrDrNR3X0LFb/fwLm+tV5uJlZaIQmEr5vSKkWRTXlJ57ie9i6js476x+rvTF/Q6IdYxsaGfhj4UAoUBNHhrIk5pPZifhw5Q7PnGTdhc51eHqNkdBFdEPaZ1UjR5m6V/UTBc/tMGGJ2WffpJFIdkls0c7zcG8zxjg0FoocxvkeyCk1VpipwY65jC4xMoG7aiObWMigU1GIvpwmvfHuynmqEeCRpCCYOWqCgNqoMMTuSyZA4YSYeXtnFSQrid8aE8T3N4jS+OSblyNCzMiQFbhwwqjHAm72wx0HN2wO+DeDS4eGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEVmeE75iOmf79gxcJp1jOubG+CCZkDC9LLEsVhgcXE=;
 b=sSBMAakVkHkFgwckeHgDkqeU/hgGUV1mHGNj3ypQbhZgjkRqHk+GA9/GWnw1T9ndBtJo5Ju0U+gw2u7dtuSkzvqphCU4T1BBU3k22gU/ut3KRYjUa6d3Lw7iOqTLLvH9/Zpx+qsPFIl/6kxAtmdWg2ONalCyM8XUC7mfTizZdc8=
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:32:14 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::e9) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:32:14 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:32:08 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amd/display: reset the scaler boundary mode
Date: Fri, 10 Mar 2023 04:31:03 -0500
Message-ID: <20230310093117.3030-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 43861422-7582-43ad-2166-08db214a5516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90iAdqkXXMv6yBhPMl8/Ne4K4lj4rbvg10SSBJhg68J1oxg//s52e+cR9gTZ9yf2lULEgoDMAEwEu2JSeek0vQRv5ku2cX3Hl2EEYmwBLSqa/MdfiGpKg9xkBzWlnoIVljrUcGI/DYHOcmvoB1ZdWHqkZz9dYNChPxyaMFihdsdLKTkzx559swQl7c4VQfqeb+5SJG2gfHSXA4bcEgwfLsjmjiZYaYG1eqwp6NyQQ61xrRqv5N96V3XPFazGsJbMxdRa4zj5mmiHOLs1bw76ssc5pUeMWe8lsh2Zp/JNG9suEt77bW0bTh/yJsfCdahzCB8JR5CkZq5gYddtXeGT2Jxh7Yg0TW3zx+7EqPQ9qFQXvZH2FtLany0jPX2YWRVzObH+08BU5BFR+urPk4sFL684N/dThyCT58W/DIoMroTR3hdcXsbj2gG/w5d2DYR0k7hfOzR6gXxTsXeNHcuqQgAh/0GaL+DtuhLWj7D3g1VWHTPVcSS0OpZyUvOmIo7G53+pved8Y22hECM4YiIOwtVeKUnkbywRiFmiUKCkez10GGQqaFwzZGUV/5vN8uSJpcX9xgRb5pqwGd1KpwyA9HgMvFuHQyf+HDMWay0cek+ty1a9hHXsvp8rqIThar+lBGP0NL7QxQb0I3IVfe7sKOQre0gMVq+/mHjvYFRfbF1Fz4y3u7/GjQWTPsPNkz0ol5PPhgtOUmRHlxAIffO0zaKM3nzq2l2Xs2WBzOV6wiQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(47076005)(336012)(426003)(54906003)(40460700003)(36756003)(16526019)(356005)(40480700001)(86362001)(81166007)(82740400003)(36860700001)(82310400005)(6666004)(186003)(1076003)(26005)(2616005)(316002)(5660300002)(478600001)(6916009)(2906002)(41300700001)(4326008)(8936002)(70586007)(8676002)(70206006)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:32:14.0773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43861422-7582-43ad-2166-08db214a5516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Zhikai Zhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhikai Zhai <zhikai.zhai@amd.com>

[WHY]
The VBIOS select the black boundary mode when using auto
scale mode. But it doesn't recover if there is no reset.

[HOW]
Clean the scaler boundary mode to default edge in the manual
scale mode.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h      | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h      | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
index 71b3a6949001..c9e045666dcc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h
@@ -59,6 +59,7 @@
 	SRI(LB_DATA_FORMAT, DSCL, id), \
 	SRI(LB_MEMORY_CTRL, DSCL, id), \
 	SRI(DSCL_AUTOCAL, DSCL, id), \
+	SRI(DSCL_CONTROL, DSCL, id), \
 	SRI(SCL_BLACK_OFFSET, DSCL, id), \
 	SRI(SCL_TAP_CONTROL, DSCL, id), \
 	SRI(SCL_COEF_RAM_TAP_SELECT, DSCL, id), \
@@ -209,6 +210,7 @@
 	TF_SF(DSCL0_DSCL_AUTOCAL, AUTOCAL_MODE, mask_sh),\
 	TF_SF(DSCL0_DSCL_AUTOCAL, AUTOCAL_NUM_PIPE, mask_sh),\
 	TF_SF(DSCL0_DSCL_AUTOCAL, AUTOCAL_PIPE_ID, mask_sh),\
+	TF_SF(DSCL0_DSCL_CONTROL, SCL_BOUNDARY_MODE, mask_sh),\
 	TF_SF(DSCL0_SCL_BLACK_OFFSET, SCL_BLACK_OFFSET_RGB_Y, mask_sh),\
 	TF_SF(DSCL0_SCL_BLACK_OFFSET, SCL_BLACK_OFFSET_CBCR, mask_sh),\
 	TF_SF(DSCL0_SCL_TAP_CONTROL, SCL_V_NUM_TAPS, mask_sh),\
@@ -495,6 +497,7 @@
 	type AUTOCAL_MODE; \
 	type AUTOCAL_NUM_PIPE; \
 	type AUTOCAL_PIPE_ID; \
+	type SCL_BOUNDARY_MODE; \
 	type SCL_BLACK_OFFSET_RGB_Y; \
 	type SCL_BLACK_OFFSET_CBCR; \
 	type SCL_V_NUM_TAPS; \
@@ -1108,6 +1111,7 @@ struct dcn_dpp_mask {
 	uint32_t LB_DATA_FORMAT; \
 	uint32_t LB_MEMORY_CTRL; \
 	uint32_t DSCL_AUTOCAL; \
+	uint32_t DSCL_CONTROL; \
 	uint32_t SCL_BLACK_OFFSET; \
 	uint32_t SCL_TAP_CONTROL; \
 	uint32_t SCL_COEF_RAM_TAP_SELECT; \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index f62368da875d..b33955928bd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -655,6 +655,10 @@ void dpp1_dscl_set_scaler_manual_scale(struct dpp *dpp_base,
 		AUTOCAL_NUM_PIPE, 0,
 		AUTOCAL_PIPE_ID, 0);
 
+	/*clean scaler boundary mode when Autocal off*/
+	REG_SET(DSCL_CONTROL, 0,
+		SCL_BOUNDARY_MODE, 0);
+
 	/* Recout */
 	dpp1_dscl_set_recout(dpp, &scl_data->recout);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
index 6263408d71fc..2082372d69ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
@@ -102,6 +102,7 @@
 	SRI(LB_DATA_FORMAT, DSCL, id), \
 	SRI(LB_MEMORY_CTRL, DSCL, id), \
 	SRI(DSCL_AUTOCAL, DSCL, id), \
+	SRI(DSCL_CONTROL, DSCL, id), \
 	SRI(SCL_TAP_CONTROL, DSCL, id), \
 	SRI(SCL_COEF_RAM_TAP_SELECT, DSCL, id), \
 	SRI(SCL_COEF_RAM_TAP_DATA, DSCL, id), \
@@ -237,6 +238,7 @@
 	TF_SF(DSCL0_LB_MEMORY_CTRL, LB_MAX_PARTITIONS, mask_sh),\
 	TF_SF(DSCL0_DSCL_AUTOCAL, AUTOCAL_MODE, mask_sh),\
 	TF_SF(DSCL0_DSCL_AUTOCAL, AUTOCAL_NUM_PIPE, mask_sh),\
+	TF_SF(DSCL0_DSCL_CONTROL, SCL_BOUNDARY_MODE, mask_sh),\
 	TF_SF(DSCL0_DSCL_AUTOCAL, AUTOCAL_PIPE_ID, mask_sh),\
 	TF_SF(DSCL0_SCL_TAP_CONTROL, SCL_V_NUM_TAPS, mask_sh),\
 	TF_SF(DSCL0_SCL_TAP_CONTROL, SCL_H_NUM_TAPS, mask_sh),\
-- 
2.34.1

