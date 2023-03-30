Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CF4C761AF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2B410ED4B;
	Thu, 30 Mar 2023 08:59:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E648C10ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyvdiwC6P/sjy8MRfMbHo3OFcSW26pxhvE61vYLMouomZ/XKgTWs95aYPho1BF/YXNW0C4B+FLmjNzCkXQ2U+lu7kRj5JFe+rL2+eoD98P8qYWaNtcnbT3jsYownnp8W/fFIhGgoRNkUHzj39DEeeLE1z6paPsAWhgptL9+d5QoWBJ89821OOzWotyKIEBe1uldQhHkv7aoCI5PGn4YSv//xkCyoCpYvDp/WPOhd5nVPMZuRCe7Pxn39CZqBg1apnY3Rjb42T2rCNTCH62/bsRAsKVmDBp6NrL5RKtraQc/kYzR8n5r2g3+GWVXnaWMWQLT6aw/1cQqyfW9nW5OfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kpr2KfjEyx5n3G2rB+9eYmVgPAeZq+/ew9pyETPEN6s=;
 b=YoLT5aPAD+khWg0RK6srrVFaZCSV2BMBGjwtnXxdt9lKpQIvc0CaCEgN77ky5yzl3tw86AR74I0fZMtvGxtlyLcwLtj2Dizhw6ZX0nZViLdoq9S2WSg6V6dd4enoLmG0WTTyLhFoSyarBva2I9pXYWwD3Rc3rE7XZX4yP3DwXqD8ZxuRSzZJRVQqb8R5NnTeK3lXnoaIj5b1mIthuIfea5zGJRx0EJNs+OSrvlNuwmrerQipN+tO/EaBDreO0eqTf9OAqvrLxgIUsTnVZMPcYz1exz/gjlauRGcGvTYk3sMngCJKy68vODv7v+7c/+mjYREY7lVV+3M7ioQ149Y/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpr2KfjEyx5n3G2rB+9eYmVgPAeZq+/ew9pyETPEN6s=;
 b=rvP3OAxoS46U9w4b3RFzTORHLpwqh4TXCmVG/PXqzWQ5xV8m6pOZfYZchXGX7H57AYS1ePOv7bI78IuIeBfGPyQdm1Yq/GWdEP0lV0wWoA3F0VNosf+h1O2aknVWVFJfUVXQK3M8PCNEkCYk/Ci69UR+r7Ir5a/fw+Y0ugjwrBM=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 08:59:02 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::b1) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 08:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 08:59:01 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:58:55 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amd/display: prep work for root clock optimization
 enablement for DCN314
Date: Thu, 30 Mar 2023 04:57:13 -0400
Message-ID: <20230330085720.3863-4-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: d85ae8e4-570e-43e2-280a-08db30fd01aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29f/BqCmiwB6qNaShCk2sgUhSiqjMYkxdlkFh0yGl9gRBGVoeylQVh4JlW7mL0QyN+mE0nXV82SV8dl2fDm9BS+c/pTiCoqV3Hmr0rNDm3B1r7ng+qeDHl46qJ7BLjDW3MlCyY97ZF821uBidxnF/RndxWJo9zNna+Ht0uKAe2LYan6bZ/0LhlZZp4k0kPeArxFlaI0Lk2lfBlQZyuo4ucmEzWZgSWBWYst7E4J8qqEIFRvxJzKtRyFHfDhmnjc0aW+LXm/7P5nqnta18CvneMzgpU2CDKYsW6/VV1WtCQn1RRNevTfd/aOlJUwMZFcNJty+lA8gPiW9ovyb53zuZ9IylnruTmj3KgR9y+zpcka+mNwvfbLWGnJ0MmfB87RsVeWNy1pqulYT/g4Ctzh04yDfBlyyITC6o2vdUDZ+9mpPmnMlbWrbELu8VOPN3s5mHilgVaqJKmNACbWLxb31Ks1NEjNLhUbInDHN/gq719cYPFg/cKle3ngqswig9BGQeLKHqUW3SoR6vFKowOyKQdJm24wC+U14SL5uAmGdNOK8o92ZpdTfqjhpnZbINx/TNv5dlSCpXtATQSXIWYAPQ5N+CtWlGJn1yKgEbbaP6o6iexqzT91MRxyLC4ql6sZBIBWzItW2/ygMTCZyk2rBPW8vJsrUj4lNjCxrfkUXqk0f59Uj7OWb1E44FM7DMzZxbmbN9qWk3Q63OjoQ8Qiz0Cr+y8f75sZRLgzt9mN5pJs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(36756003)(356005)(81166007)(82740400003)(1076003)(26005)(6666004)(54906003)(316002)(478600001)(8676002)(82310400005)(6916009)(4326008)(70206006)(70586007)(40480700001)(41300700001)(86362001)(47076005)(336012)(2906002)(2616005)(426003)(40460700003)(5660300002)(36860700001)(8936002)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:59:01.5376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85ae8e4-570e-43e2-280a-08db30fd01aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

To enable root clock optimizations, we need a number of
register writes and need to account for the difference
in DPSTREAMCLK between DCN31 and DCN314. To prevent
issues, add a number of register writes to
DCCG_MASK_SH_LIST_DCN314_COMMON(), and define dccg314_init()
which is mostly in alignment with dccg31_init() but
accounts for the new DPSTREAMCLK sequence.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 28 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |  6 ++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 081ce168f621..6f879265ad9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -274,6 +274,32 @@ static void dccg314_set_dpstreamclk(
 	}
 }
 
+void dccg314_init(struct dccg *dccg)
+{
+	int otg_inst;
+
+	/* Set HPO stream encoder to use refclk to avoid case where PHY is
+	 * disabled and SYMCLK32 for HPO SE is sourced from PHYD32CLK which
+	 * will cause DCN to hang.
+	 */
+	for (otg_inst = 0; otg_inst < 4; otg_inst++)
+		dccg31_disable_symclk32_se(dccg, otg_inst);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.symclk32_le)
+		for (otg_inst = 0; otg_inst < 2; otg_inst++)
+			dccg31_disable_symclk32_le(dccg, otg_inst);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpstream)
+		for (otg_inst = 0; otg_inst < 4; otg_inst++)
+			dccg314_set_dpstreamclk(dccg, REFCLK, otg_inst,
+						otg_inst);
+
+	if (dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+		for (otg_inst = 0; otg_inst < 5; otg_inst++)
+			dccg31_set_physymclk(dccg, otg_inst,
+					     PHYSYMCLK_FORCE_SRC_SYMCLK, false);
+}
+
 static void dccg314_set_valid_pixel_rate(
 		struct dccg *dccg,
 		int ref_dtbclk_khz,
@@ -315,7 +341,7 @@ static const struct dccg_funcs dccg314_funcs = {
 	.update_dpp_dto = dccg31_update_dpp_dto,
 	.dpp_root_clock_control = dccg314_dpp_root_clock_control,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
-	.dccg_init = dccg31_init,
+	.dccg_init = dccg314_init,
 	.set_dpstreamclk = dccg314_set_dpstreamclk,
 	.enable_symclk32_se = dccg31_enable_symclk32_se,
 	.disable_symclk32_se = dccg31_disable_symclk32_se,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
index 6a35986307af..f62631ab53a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
@@ -155,6 +155,12 @@
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_SE3_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE0_GATE_DISABLE, mask_sh),\
 	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_ROOT_LE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_SE3_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL3, SYMCLK32_LE1_GATE_DISABLE, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_PHASE, mask_sh),\
 	DCCG_SF(HDMISTREAMCLK0_DTO_PARAM, HDMISTREAMCLK0_DTO_MODULO, mask_sh)
 
-- 
2.34.1

