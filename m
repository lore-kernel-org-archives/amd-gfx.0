Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5099C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE6910E868;
	Fri,  1 Dec 2023 13:28:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D94910E868
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHqKI51ODKUjCqQymhRDqDw5hEO1QXDCisPKLnhcGZS1aRVnW6m0wNAFeoLb5JOMxh7yJQAJE11vV5Dw5/7hkcrRoY5kUq2dSdOngaa6lUlFznkl8Gy/6a+V8h5ECcpDCSD+CeFREJRh4dUa4yLvV4Z8Qe/dbRE7oNbvXUYKdoiebODgPufW/PP7xXQT1T2qWaZtC+A7N2ERKEem8Gm+D5GGiHsbRDF6hj5emK0T9pEVBTCbDnhQvT2kCUsUtNpPNpC94fo8QpF0hwMGPyqupnTVY+UmzfEDc2qZ4SEGS817bTnOXjHgFzRwBjtYEhvYqBxKiV5iPknsjIoUxt6jDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18j42fbxBeBGn5JkrP4i7ZjYnuc4M9TkzKSO8QltXI8=;
 b=KWJh7soSLOcbniMuOdUasmK13N/Ti32AgMOF0r6Q5sVuTuY7ZHIb/mqCGhAu8664USBbdqNiiKYYIY7y8NJuQs4d5Gey4I5x0I8lPTt8k/VAbyGWX4w5nTDeQyk9Wx2t6Q2Mym5EQRXcUmVkOqYabiHh72RCo+f08QjpSME/JVZ9CM4K4C1k8JQ3UzHDgQxEOaGBqIHXb2J7M5JaMuThpGCFywgcphTB3TwdHgiaQ3AK44frdB3bDxKWis2ivlOiRyXQfJzzZ31QX6leKbFuGbroExQQ4bVGVSorJ7i46su7LnZk3rAuyJg38dDH+bwVSq+DG8T6RojYIx2gluPeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18j42fbxBeBGn5JkrP4i7ZjYnuc4M9TkzKSO8QltXI8=;
 b=MaEA09ZY5IE3ua+8Xxy5ctSf77+oSbxoBiV5fCa4BmOPIZlpuveh91W/BGiIvwaQi1bTJ8KrhB1rV8bLxb3Ut3QNp0jXXT2SdjnlQRmYbdlsMKNwqjZz3PrhDTn3k96DTRx4mEwl8IX93TivOsssM+SjYqFI/XToTgVqTogmxY4=
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:27:59 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::73) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:27:59 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:27:56 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/47] drm/amd/display: initialize all the dpm level's stutter
 latency
Date: Fri, 1 Dec 2023 06:24:58 -0700
Message-ID: <20231201132731.2354141-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM6PR12MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: b54fb71d-8dc9-4f61-afa8-08dbf2715608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBi6oI8nHVx5ybkJu2A6VNz4LAdvVlz2JLKQUiOmLMrRpsWb7p7OwK4U1I61rxxNY0Zkxtd4y6bJyRv2xQC7wXfEgFkKc7EmFMLpVjafj38NLBgeia7Dawgq/Ort6zuoIu43EvCkDHcFwlbyP9UjWo7kRTrFZuFXonmCd7jQwPJWVvTksJPsrLod3bhplR5/7GRH8ilHQVOFIKirDa0P57v2RHbhUodAQraaGcGHrQ26plj+MP1y3PNugXeehKCvy19NibvX7aJ+SFXmWOlelMqH2vJiSVI4muZlmdBgRXUUjh5W3/NBIq6ySDTS48udACTYw3rdRec5L9bkiDTuJl3uiTCFnOO7c5qUphtupZZBDlDKEfHQhtes0RwMZ11PrKpwiAOiRPj/dLeLzPjvxlsAx44yrG43SIr1icHglgj77g870/N3wD3FM3e5kJ9WpTQnNJMf4sXL4Ldu5okb7g7Qa4L+affB/Ux1yQy8kw6I8D5XRIobw7Y/6KIqASrWcx/QTMwIxFgR+WAUJQ/yfeFplGVUM3QcgUUxPK051X1xiN7k+e+zv/6rZUOt3LZALEKzgUd4f2WWd9nwDUNpkCxa1DWDL4+j8hh3/RofWemU+q/XMIepvuptsYy6iTp+jWp7eAvWLtJ+GV/isMk2UAESsdEwF7sQqnNM+ErzSh0oFZA41xmrT1OSNPDAQtCkrg+c3HrxiCv/UVKLyz7kN+Zk0Y8dYogUoHc6zNCAe9QIF7EUE+ZA9hAWWj+AT/R4S2eKW7JsV+dbsuh5RxI30A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(36860700001)(47076005)(40480700001)(81166007)(82740400003)(83380400001)(16526019)(26005)(426003)(336012)(2616005)(4326008)(8936002)(8676002)(86362001)(1076003)(356005)(478600001)(40460700003)(54906003)(70206006)(70586007)(6916009)(316002)(2906002)(36756003)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:27:59.0911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54fb71d-8dc9-4f61-afa8-08dbf2715608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>, jerry.zuo@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Syed Hassan <syed.hassan@amd.com>, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, Allen Pan <allen.pan@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Fix issue when override level bigger than default. Levels 5, 6, and 7
had zero stutter latency, this is because override level being
initialized after stutter latency inits.

Reviewed-by: Syed Hassan <syed.hassan@amd.com>
Reviewed-by: Allen Pan <allen.pan@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index fa8fe5bf7e57..255af7875c08 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -341,6 +341,9 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		break;
 	}
 
+	if (dml2->config.bbox_overrides.clks_table.num_states)
+			p->in_states->num_states = dml2->config.bbox_overrides.clks_table.num_states;
+
 	/* Override from passed values, if available */
 	for (i = 0; i < p->in_states->num_states; i++) {
 		if (dml2->config.bbox_overrides.sr_exit_latency_us) {
@@ -397,7 +400,6 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 	}
 	/* Copy clocks tables entries, if available */
 	if (dml2->config.bbox_overrides.clks_table.num_states) {
-		p->in_states->num_states = dml2->config.bbox_overrides.clks_table.num_states;
 
 		for (i = 0; i < dml2->config.bbox_overrides.clks_table.num_entries_per_clk.num_dcfclk_levels; i++) {
 			p->in_states->state_array[i].dcfclk_mhz = dml2->config.bbox_overrides.clks_table.clk_entries[i].dcfclk_mhz;
-- 
2.42.0

