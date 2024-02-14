Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F259C48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1138410E5F3;
	Wed, 14 Feb 2024 18:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XU9MqMsK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5A910E71B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ944DjwAbDFkUX4OJM92bOIokZLEHNDN08pFH5WmsFwtHonhrrfRjicLZue6Tt7R2InvacUdE0nliioiX6ESwBMul1IwOMJxcMtIL/z+6t+9mfgn/kynSM7ocoJ8ZvMKVwH1uHBTtB4AFfTQcHbHW2Yp9f/t5jKZnlP8RNwrJjkGH7Osgd0Q55REKsMTmC9rNbRlQvtlFB6K4ahYxSdCtdCTCffRbuB1kfkR6FIdZdVT+MiTG9cRVV8XDLwyZQSZW6Mzs5vVTDuVtPycWtToAHEX6UJ1Dh7Lmi60XSvJvxtSti/wKBrT58mxNvgHytMzXepQ3wesgMNeuAy5IFWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ8R6uJudJd5p65jQ1tsCHrqPZdwnepThaVuqxnxI88=;
 b=TJaJtnFnTH6omdRpUOuyvMgP/W1DpH3QxRbZ/x5SHn3PSi/kkyZyIlmc+B/KeikGo3slfioaGPrWYO1CBSJALiBAhVZ26q7ywEVzBO1fzKVdrW9WtZ10+Rb2K451H2NDtUg1T2BtkdXmMxv4s7mlO0bnQgVr7s30sinKCEPU+zy5/k7Sz/dAyevnEZ1O0vB77iO06bFzhg15ouCOqAVPhVxQ6bTjWqH1C/NWfCjdXo8O16WjPkuZw4y7mOcksDYfxb4nj1OKW5cwXzjvmpAvqKyPZvBaU9XuTTSqPZNyjXpDoi2V78NoWnFqmctckcRgL/M8hUXwziMPwVwXYaa9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ8R6uJudJd5p65jQ1tsCHrqPZdwnepThaVuqxnxI88=;
 b=XU9MqMsKQGiqJWtxxQEikxBqmc+uFrN/BZwFr/0P5ps2PNkKwTlNHoE4EubFM8tg4t5GYCMrFX67Sp7LFXWaTFbN+URjl7Ytf0C/lFo5glrdQMuuQu7og9awG63elSlMpZLbuy3bm8vWziYlEkOnBeEHQ8v5La2tyAs2Ht7NmzM=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Wed, 14 Feb
 2024 18:40:48 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::8d) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:47 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:45 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Swapnil Patel
 <swapnil.patel@amd.com>, Charlene Liu <charlene.liu@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 11/17] drm/amd/display: fix input states translation error for
 dcn35 & dcn351
Date: Wed, 14 Feb 2024 11:38:42 -0700
Message-ID: <20240214184006.1356137-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: c8698907-d9cc-4704-0eff-08dc2d8c75b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rW0OjSxbiUkiDgTJFbc/xHy5aRxNXTy0kWxRzyPTIuSkUdcKnNocEwezTh6+JIjei1Y6Kat4YTNJWfxITLvU+M3ztqzNIF9fa1byD88HE41uBVJ6zSPHgGBF/WzBwaQQUh94/+57oTNgA8T4x6/rTkAWyPtZNKGvr/iSvswIzMsByyKDruo/NfxdZyCblWN2dr0EcBig1I6e1CIvJDrdK5ZbYufEoIRwfTdLHj90s6jBKIBppHm8dKHEE/R0Z5PdAlScDBT1/3IoyAqC5DT0nbyDVFPph3pE3Q1YO5kZyVn8t+L/1DU1U0poGjz11YbPqqP7SPkiJ2QGZM4dJUCP5enCCoD3+DuYyxohQnHj4DBeAgqxnKoYr51Pf6AXZwlnJBJNfvIdiOxi0W9soP4wfVAABnuukR+L+DQa/lEkaqk8Gr0OEfX65x9nXyOZhJI6iPRihA8qRVHDGtK9HfnG2LxbujGiVjj6vo4DQseHBiciA+mD/ztuJLE09GFYLuh7OV1WV5YUY2N1D4bXcwax0AYfsaHjRu0bJ5QRfi3wpO1VT3o61Jl+HZgCcFv9Oqgt/WywxBLS28ucVeQXThLNkFhaItQnNispZIjLdoAKb3s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(86362001)(8936002)(5660300002)(6916009)(41300700001)(70586007)(4326008)(478600001)(2906002)(16526019)(82740400003)(356005)(26005)(83380400001)(2616005)(1076003)(426003)(81166007)(336012)(8676002)(70206006)(6666004)(316002)(54906003)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:47.2392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8698907-d9cc-4704-0eff-08dc2d8c75b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
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

From: Swapnil Patel <swapnil.patel@amd.com>

[Why]
Currently there is an error while translating input clock sates into
output clock states. The highest fclk setting from output sates is
being dropped because of this error.

[How]
For dcn35 and dcn351, make output_states equal to input states.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
---
 .../drm/amd/display/dc/dml2/dml2_translation_helper.c    | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 23a608274096..1ba6933d2b36 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -398,7 +398,6 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	/* Copy clocks tables entries, if available */
 	if (dml2->config.bbox_overrides.clks_table.num_states) {
 		p->in_states->num_states = dml2->config.bbox_overrides.clks_table.num_states;
-
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels; i++) {
 			p->in_states->state_array[i].dcfclk_mhz = dml2->config.bbox_overrides.clks_table.clk_entries[i].dcfclk_mhz;
 		}
@@ -437,6 +436,14 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 
 	dml2_policy_build_synthetic_soc_states(s, p);
+	if (dml2->v20.dml_core_ctx.project == dml_project_dcn35 ||
+		dml2->v20.dml_core_ctx.project == dml_project_dcn351) {
+		// Override last out_state with data from last in_state
+		// This will ensure that out_state contains max fclk
+		memcpy(&p->out_states->state_array[p->out_states->num_states - 1],
+				&p->in_states->state_array[p->in_states->num_states - 1],
+				sizeof(struct soc_state_bounding_box_st));
+	}
 }
 
 void dml2_translate_ip_params(const struct dc *in, struct ip_params_st *out)
-- 
2.43.0

