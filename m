Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EBCC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B6D10E9BC;
	Wed, 28 Sep 2022 19:41:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F11C710E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIf74cEW39GgfEvDRJXAOfdytSkHay9hg3ih0uM+Dlz7ox5o5EkFP+jt2kTrSWjC93HQLoEVKFZ/nMW4tfxUFMU1nkXkKwZgJdyjXxbNjSq7xNsLk/VXJ2U6Rj/x6707n2wL7x1lz3IncQRmTlzVdIA81hI7YnfAtTwuP2RZQSQ+iOVV+PttIBm1o6Ca685kEeXceG7POz5J/EpoO/jXiztMRjKiom8FjbDunUJS43pqavIJZZ1LybdFGmOkWJjhJZBhiGSK+0lm/LFxv9bZW0r7ZybxWKrxGiaRnL5HOLGuXBZpKPUXlBiyaLlDmDxS1lIGjmwSdJbGDWBqety9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXywZ/JdsFdMscbaKUNFviEVOaUuFP601aQ+vxmo2wM=;
 b=cXupVHUE+YiJ/1bs+UBRGhNv/XEqwUzT3/sGnR7mx1+MCE9tsrt3dHvcvQy3DikM2iv/l/N6lvcK8cvskBhu4r0rwv9NRT0hmBCXGfkMDw4B/Z+PtjmaptdVKTTMIJGShl04PyR9TrdOLbu17qiiK4pdxug76PJnCvAEZufQe90K3idVa9sCtc6qCfc3451BjuzYJ7V8ZJCpDvcRJxtITKq1ow4KnMAw2dlhnY9OlG2Qo56289MKNHJXRKFAg0GJ+bstxeHU7HKerbZVpDmzWQJSkXmhIcwUSsdFVowC5Zz/z/EHxtxqGidyysFIp/U87XYi0K4uJWUEzuzqsEuMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXywZ/JdsFdMscbaKUNFviEVOaUuFP601aQ+vxmo2wM=;
 b=4izRtCEQcsYzBNN9PhxQ/j/tEPYz4J432cAJp0Po851E22i5KKduVEJj333nbwNqAypxx376uSIkjQ9/hTO8i9SpbcV6LwwKVauxQYb8bbezehK1M7oIZbqLnkmgJRLaAKjJdYilH9DQhTsWuyljA6bRskZwPBzBK/RZd6FKmDE=
Received: from BN9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::8)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Wed, 28 Sep
 2022 19:41:13 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::b3) by BN9P223CA0003.outlook.office365.com
 (2603:10b6:408:10b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:13 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:11 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/36] drm/amd/display: Increase compbuf size prior to
 updating clocks
Date: Wed, 28 Sep 2022 15:40:08 -0400
Message-ID: <20220928194028.144879-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|CH0PR12MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: ea97b4c5-038f-4847-5b77-08daa18966a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYGojIi95rlyc9kepChOinsXEuhcOgNiHOzJGY/KarlaT62DEpZfTuQuwVOFTbVWbSgarw0DvpnYtNXtoeiy2Iri5ThfUSDIeOXpJJaiWhsEe0ZWh3a6tOTBT9yeAAd9/jayGwHRX3ZwWU8E9tfTGUEAFcrLgg8iBQKVQ2yKCOXytVmKK6i8+3q6v/1TOXmTzUidgkb+PkKZ1CEpmqZW2mzRPpM6OMZoaKGwHPuv9dAU2/hGoBDX2oyRSvWh7MYJN55/ELPuSydv0zU80KehC57iBCaY5S1twXCog4fSuRx+qMMtUKkC9/B0PuU0WXKjCFvDJyQjRGutOi+sArhHDhlrdK6Ow8/dLXKawPcuvzrp+creG1WUdVtoFEX9pBNwz0MgAm75dMjmcIgm+XrLHSfYnR3WGELxWYeEkYJA7Zl18a/dlCHxLnATjCr1HGRLB06cJg0MxLammwUNP8NNCiLn5P6cFX3EIcUWzd4IKe6TeDEDhH+yGcdk5gQHHMsMS8K9kU0RVyboD0X46rxnGAnKKP3LXR5HF17cvSzuhAFbAB0/5x6LoYPFMyNUz5Of3iVZ/ioDwxy+E96zZho5U3tXhcdmuNwnmmg5X3+QCvwTHIjEJWUTyEilcn6UpfGA02Wguur98uFUctElUowFXduGcXKNj/uAXgZX0oK6Ugn5DcMkB/zWgFkJi0QLDAJTe0Vb5Z0lDNsflni25rZELpPuurvYpATuJjJs01QNDmCr5WlWFwFs7R8cVSWQ4YRjU3sfAY3H1Awlk8j6Ef/Kvl2BWNr9ym/9DK81nCRuIxxkd1oj1ghJXlBktto+smmgR7kmJ7ci9D/AT7+KAmP++Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(36860700001)(6666004)(7696005)(478600001)(36756003)(316002)(82740400003)(81166007)(8676002)(4326008)(70206006)(40460700003)(70586007)(356005)(86362001)(82310400005)(44832011)(41300700001)(40480700001)(8936002)(6916009)(54906003)(5660300002)(16526019)(186003)(2616005)(1076003)(426003)(47076005)(336012)(26005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:13.0622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea97b4c5-038f-4847-5b77-08daa18966a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Clocks are updating based on the incoming context's support, however the new
compbuf size is not programmed prior to udpating clocks, which can result in
P-State hangs.

[HOW?]
Increase compbuf size prior to updating clocks.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index e1d271fe9e64..7de511fd004b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2018,6 +2018,10 @@ void dcn20_optimize_bandwidth(
 				context->bw_ctx.bw.dcn.clk.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->dc_mode_softmax_memclk);
 
+	/* increase compbuf size */
+	if (hubbub->funcs->program_compbuf_size)
+		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
+
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
 			context,
@@ -2033,9 +2037,6 @@ void dcn20_optimize_bandwidth(
 						pipe_ctx->dlg_regs.optimized_min_dst_y_next_start);
 		}
 	}
-	/* increase compbuf size */
-	if (hubbub->funcs->program_compbuf_size)
-		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
 }
 
 bool dcn20_update_bandwidth(
-- 
2.37.2

