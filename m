Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C781C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15E610E456;
	Wed,  9 Aug 2023 15:08:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF05610E454
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ2wT2bv31TkOfCm81u5Jilfhb5Z1EHm7Um73oLyZN+2P+NEwAfE62bWThKibZjBbWpW8jXgFzm0F1Y9ORmJcwQKCZfTiRVydEKC0wPeYHLFU6/Xs01al0Zi6QhDGhvhnFEA11uCATIUhH7lDSvrI8+mQC3jjixtrpW0mGzb9IaiEfg4bY063YBze5c+i47zjTxz5Heyt+ZsEB7rHXwiIA3F6jBD/V+nZF+2h6GM+ice+oD6kQhUUf09pkZBeRvMNx9BcMbQkWdK5NzFwwm+4rchzI4BA+Q40XXk8E4lONM4qDpTfaM8HIcd6FMsU6pSeaDMVbYS726YDKfQSYNgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkTdCOwx08E4+3FqjD082fEcstXegWEN5xFNS5cg0aU=;
 b=fDZpwsExBBzGvp/V5dm0InEdaM2N93swN+sDrwK7/N52hwiaD9HSgGTrPHG1cPuYg5zqJabkrhYfcrwgEE3BRoAkFmmtAfJmWxjfmqtCuEHNnF9ojxPKDkP+AC+oImvv2NPeMUDdY0uK2oAV9vVGAlFY/XTm9N6lnKG1S/l35cCMn8mimjj1Dxl6RDb93WsqOJNCcI37H8gQ1UWShVid55Nv3xNxYOVznDBm3wM26XkElaz3y6Hw4klEkE2lSKAVaB8PQMEPOeMcsTxoRhvF9bjetJRr0adNvw3xHCssG5OymGPBst7D9SFIbjUNEV/1ixwqjjd3y5D4jR0fJqOr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkTdCOwx08E4+3FqjD082fEcstXegWEN5xFNS5cg0aU=;
 b=UKzDmSK5172isyYF9G8Lm/T8pr50Os0Y7tzEPTi6u6xiNnq0uoyCe8OgzN9T6nFrWJydIVHnODeDGqMrzJuiGzvKap8F1d2VqAzsk+ufL//JmOzJuF8wPu6Cg3AydOXR1FQPP5ti76R0ZJGslDWai2BmWEUs8E0krHdLpamYfX0=
Received: from CYZPR05CA0036.namprd05.prod.outlook.com (2603:10b6:930:a3::24)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:08:12 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::c0) by CYZPR05CA0036.outlook.office365.com
 (2603:10b6:930:a3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19 via Frontend
 Transport; Wed, 9 Aug 2023 15:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:08:12 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:08:08 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/15] drm/amd/display: PMFW to wait for DMCUB ack for FPO
 cases
Date: Wed, 9 Aug 2023 23:04:56 +0800
Message-ID: <20230809150620.1071566-7-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW3PR12MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d1b390-8b38-45ad-701b-08db98ea7334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmVrhm+QZGRdv7pEFzcoeGikK9F9xzI6GMoOTDQzKK0UjFP/hbjP6I5XgtrR33Cd+eL6oRJSEm/EPAig646TB+vZ/1lDpoRQbA0+0YKx9GHTYn7P1gm8xEzk5C+joqErrmfbx5nTa5ItqpniQLOHIfJGPSLbgKEdpmVrBI+5zrfvl/krr/WSemWT3f7lBRwpOYIL08ooQHc/S10AlgWL0NqVbWMJFzuefaUD7fTWJa3j2X7ZalAauDiwYUnu8X50tUYHHkbwsl4L1xUNqTWrQg1GvGd27Zi2jUapFjM+9Rjeh2FAszHL+8JTg8txryYpxw6WzuF0kzQMkirTr7Syfu/KHQj3Yig9pGQ2Wj8d3IT7L2VzmtD/pEzdabREjnofjL6zfyVNAc7Eq7z3JHN+Xrmn3c0rVqP6wh9F7yQKT0Ay/3e9Ui8pMW8znK28F1qh+9jGZ8mGcSA0dY9ViOLkNTPAhK/o9YMeXVU8CucEkNRx4VX2w/VD+gZh5yHcrmx/QzVx2oUbyPoflR/Fw0vtD25gzzwDGejZ/W8bfjxf9eTZf0FV97ZZpC6veVsFl/GHl11Inaxejt0W8/nLiPw7MY6sCsGFUA/hYsWJsA/eBQ0jtnwgglXRIHYtH+yzcZB0PuLjma0xQI1jMC8h/Ba2x8Glfu7jzhoWYsDJw6/wEU79QLzTAM2Qw6pB1cdxCXJ9cjp2zFEuZiC+aNEca7Xzk5yCRpUzgv589epfPcJ16kV2RG5urEneMsWErs0uoBZAcXrTex1/iegq8f2mlSKLQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(186006)(1800799006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(54906003)(6916009)(70206006)(336012)(1076003)(70586007)(16526019)(26005)(6666004)(478600001)(36756003)(7696005)(36860700001)(47076005)(83380400001)(2616005)(426003)(41300700001)(316002)(44832011)(4326008)(2906002)(86362001)(82740400003)(81166007)(8936002)(356005)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:12.4549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d1b390-8b38-45ad-701b-08db98ea7334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
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
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
We want PMFW to wait for DMCUB to ACK the MCLK end message
for FPO cases as well.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 5 +++++
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c   | 7 +++++++
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h   | 1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 2f65591d2f62..c224c6eb879d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -555,6 +555,11 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			}
 		}
 
+		if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
+			dcn32_smu_wait_for_dmub_ack_mclk(clk_mgr, true);
+		else
+			dcn32_smu_wait_for_dmub_ack_mclk(clk_mgr, false);
+
 		/* Always update saved value, even if new value not set due to P-State switching unsupported. Also check safe_to_lower for FCLK */
 		if (safe_to_lower && (clk_mgr_base->clks.fclk_p_state_change_support != clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
 			update_fclk = true;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index fb524fe4ab26..700ce42036d7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -139,3 +139,10 @@ unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, ui
 
 	return response;
 }
+
+void dcn32_smu_wait_for_dmub_ack_mclk(struct clk_mgr_internal *clk_mgr, bool enable)
+{
+	smu_print("PMFW to wait for DMCUB ack for MCLK : %d\n", enable);
+
+	dcn32_smu_send_msg_with_param(clk_mgr, 0x14, enable ? 1 : 0, NULL);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
index a68038a41972..a34c258c19dc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
@@ -43,5 +43,6 @@ void dcn32_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
 void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways);
 void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
+void dcn32_smu_wait_for_dmub_ack_mclk(struct clk_mgr_internal *clk_mgr, bool enable);
 
 #endif /* __DCN32_CLK_MGR_SMU_MSG_H_ */
-- 
2.41.0

