Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD05C10DC1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A36610E66B;
	Wed,  6 Dec 2023 19:52:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EC110E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldgV+2iVKEXGiMRS87kHjveDaCKvbrP+7IpcV/q9maaYILMPjYZ9kmxLMSRGqa7MKa6b4C3jeJCPkM+t98Sf8vLdxCnHrVFS+5HGX4GWV0dZoA5cURH5NU3fNKSaLEoIc52yRxs47UhWQGS4h+RuBvrako1mNIsFY/QVOQy0vsmQRhhJdub9tmAQBykdmKjyOoYJYcbQMM/bamywbzbP4TQ/G9VcXT3YmJViz+gl9WTfokjA63Di1VoLvdw2dgQ4qIeevh/4o+8ph3rQMf9sk6JeSBl4qMySvSN8l0p7IUPodFRnKLlbyJKm3ENXL7ngPg4t4aXQZzjbMb7/egsyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCtJ9oiclCq1YMm8o1m9Jna/yyjJOuThWtXJmu72aD4=;
 b=IV6xL+V2W5RLGaHdiOZyc/6HM34waoA7sKDylDi764KOFQ1W62vc7KA9YHw156XOxMfLMVq0mRYUQzdUWHCaOVIBVl51i2JTzzJP4WjFCEGiarZH94BzuOQYQdHoq7swyI4luFUsGAyWmmUHH2L/jo5fjosfEsqZKHu3N6Fqksg/gmYnpQmQBXAtHrDLKpJg+6+exeSMGVQJUHii5oVWqdmgwf+4nvXXLFfCtcsjeA8I0I+oqdsX7EvYCpkJ2aquNhNqN5Dx6ZXgH14ARlwJd3cD9GQT+bbKS3cfHJalQmBqn1WbYrMvQRhGR5A9BSNeV1gYcycd179hKtz4bWMkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCtJ9oiclCq1YMm8o1m9Jna/yyjJOuThWtXJmu72aD4=;
 b=dyw/weFHYD3SB1VD+rD4Zxs0rDfNVRnNI4ZGFn2ZXg1xodnNkV7uLCSrmFIXUi2lrGJajy6ahOqnvN1far89o4WK3nGkA/Yy0UhNL3dCrDbXi6tQhXXz7gEtZxnSQVCfvsYIgPR0fy4WxZRLxhVyLXVx7BlELL52tmLUcWqKSYU=
Received: from CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::16)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 19:52:42 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::72) by CH0P223CA0005.outlook.office365.com
 (2603:10b6:610:116::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:41 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:40 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amd/display: Populate dtbclk from bounding box
Date: Wed, 6 Dec 2023 14:52:28 -0500
Message-ID: <20231206195234.182989-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f2e470-a659-4cfa-c5d9-08dbf694e8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EykXbb46EY8wfoDmyLtAcIGo7kTPaMukURSbXl1j/uYVQvO/SyO5y9MDmX6Yr343tX8sjvC+e8zuyhmPEOiLhRyqSY2GafOmnt3qjk78/kmbEEmxq182SVjmY+0ZSNwXf8SQm5Y34EM+ShLEZVrw1wprKtEmyR5uw/tVTefHUp1tmSzrPyPH0AlOX4zpGHts+zQ0Q3RiL5pJUpkI1PRMTYEy4G0kk2jWpPT9t/PU+Tynu/C7OQ9JuXCcVibWY2FEaSx6w8fbrmrvnZ9rtjcZ8sbd9h+QCXw6NK1bsf0ke2Hw8UZvri+3Q/tn+Ax7rFbgyy7JMzUOQVieHM8pL0cnUIEmKdcl6FinfBGP5IX+3zCMevzh97OWsy1p0bJHR1VlOe34j4bXMjlxXxg6ULY9GP2AUDMfBTxrOdHsgsdmB4XN7ooDfRjdcaxFfJzNuzH5uQa5FyOMWHPkxDQQ/ekqtSIWZhsfJegxkuqpCIeHuUtPYEjuON0wzhijIivqenn02DFC+2cZK6kB+KN8hUhO/l/h3+cl+MUeo84GA5ci+KWGDRW04YT0lo1YIWdIKTytok9hohjgiaGWVaoF7z8XSWNbdJ3E7KavY+jMPpC2QKE/kIkLsHzVX9SNpVGEhidg15ILVyysG+KnR3HnCi3eowaXl7Doy9PQfO600H49/df503yWO4Q/MBshTOmf76gee7rw/Q08LdHY8XilrM7tE8JcTiU4jgz63tPXdNQPnaB3jyVXnf4sj31RFWS+sazC+4JKqqce+3++XTsf+J8eSfKwQu4ht/A/79iygAJ3iFJYlM0V8MizGC38Lta0cvBQHBwhr6no7Pf3fQrUuCeV5aMjWycMSUWsMRZo29tmSHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(8676002)(8936002)(5660300002)(44832011)(7696005)(6666004)(36756003)(2616005)(6916009)(54906003)(316002)(70586007)(478600001)(70206006)(41300700001)(4326008)(2906002)(40480700001)(82740400003)(81166007)(47076005)(40460700003)(36860700001)(26005)(1076003)(83380400001)(86362001)(336012)(356005)(426003)(40753002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:42.1308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f2e470-a659-4cfa-c5d9-08dbf694e8a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

dtbclk is unavaliable from pmfw. Try to grab the value from bounding box

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c   | 14 +++++++++-----
 .../amd/display/dc/dml2/dml2_translation_helper.c  |  5 +++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index e9d88f52717b..3d12dabd39e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -124,7 +124,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 			.phyclk_mhz = 600.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 186.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 1,
@@ -133,7 +133,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 209.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 2,
@@ -142,7 +142,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 209.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 3,
@@ -151,7 +151,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 371.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 4,
@@ -160,7 +160,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
 			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 625.0,
+			.dtbclk_mhz = 600.0,
 		},
 	},
 	.num_states = 5,
@@ -367,6 +367,8 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 				clock_limits[i].socclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].memclk_mhz =
 				clk_table->entries[i].memclk_mhz * clk_table->entries[i].wck_ratio;
+			dc->dml2_options.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz =
+				clock_limits[i].dtbclk_mhz;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels =
 				clk_table->num_entries;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_fclk_levels =
@@ -379,6 +381,8 @@ void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
 				clk_table->num_entries;
 			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_memclk_levels =
 				clk_table->num_entries;
+			dc->dml2_options.bbox_overrides.clks_table.num_entries_per_clk.num_dtbclk_levels =
+				clk_table->num_entries;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 255af7875c08..279e7605a0a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -425,8 +425,9 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		}
 
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_dtbclk_levels; i++) {
-			p->in_states->state_array[i].dtbclk_mhz =
-				dml2->config.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz;
+			if (dml2->config.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz > 0)
+				p->in_states->state_array[i].dtbclk_mhz =
+					dml2->config.bbox_overrides.clks_table.clk_entries[i].dtbclk_mhz;
 		}
 
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_dispclk_levels; i++) {
-- 
2.39.2

