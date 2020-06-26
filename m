Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E7C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B5B206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oxWrbf7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B5B206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6090E6ECCA;
	Fri, 26 Jun 2020 16:19:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78EB16E125
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTTEzgDyoPz9Q2bRrDZkminTlJtGbUdS5S5ak+0pZp0/Doa/tzodyWr4RONulN3RpqQPTRj211SEOck3i5kdcP3mzpWj/vPSB8D3YEmnPPJ45hkCDQrwbweCd8Fv/sjFGQtueDyJKIkG4dcUhiIYelQ+MU9xW4ja3jYnQbI3etFszHrfoikrQJs2tuefDL+UMt+5WW+rtTT3RyJCIq9qSiIzRGglut+gX/T32YaV7LGQKqu/RwIxiYno3BHksxhP80c1hGTBAkOMjmLZTtyd66l3F7fvBj5Fya9mDjglIEJs5cR94R6SiRJSE+BCT7MMgrXmD5GHoIMuX4uQRo1WGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Yb20nnJltzU26UQNUz7Njqg6htd3Pcxt97D0Kxw5iE=;
 b=PWxeyK6P+xviydaZPRa65HmMhrfh9EZ5c+w3NpwuTesy53un1XooGg4HTozR5ylyZsZQV6U69SRCAAp08jJDFhIxNC9sBHGgaPIrkSHVt8JHGMD9XqQ6159rj40vFloky+BSGEDLpPc00y6l3poEeD8UBkOt3Pk8ji/owz+LAqRqXTO8tJ2BIfXHkD34Y/RmQlP/Bs0RvDrTvpqOxQ5jVRCfvrNExKcv0KJtMH+tnFvwRDMZGxj0Vc82e02jGjjF77d0aMl+mEVWq4IYzXApTr1Cs3sbWDsKg2PVzZUxfqbdK1LZ6vfulWit7fNovARyFlS5tqPn6wCUoIcolyok3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Yb20nnJltzU26UQNUz7Njqg6htd3Pcxt97D0Kxw5iE=;
 b=oxWrbf7gNoihUAPAwb+Z0wXmnasZm4V+ykEsjXqlwS/SD7PkXXPVV8oOAuALV5gGMz5odd2kXa8/z83DsewS55tZFU2zxv6uqpvl3eRq3TnJi3+h1S7gcPoS5aov3/m8JoYgH80akARJdoAnyM3tu6rfitN59CX7ccloCMdV+3M=
Received: from DM3PR12CA0072.namprd12.prod.outlook.com (2603:10b6:0:57::16) by
 DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.24; Fri, 26 Jun 2020 16:19:49 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::45) by DM3PR12CA0072.outlook.office365.com
 (2603:10b6:0:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:48 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:48 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:47 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amd/display: Preserve gpu memory allocation for
 life of dc
Date: Fri, 26 Jun 2020 12:18:38 -0400
Message-ID: <20200626161847.16000-3-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(1076003)(6916009)(47076004)(2906002)(4326008)(478600001)(82310400002)(82740400003)(6666004)(81166007)(356005)(26005)(86362001)(70206006)(5660300002)(186003)(44832011)(70586007)(54906003)(8676002)(36756003)(2616005)(426003)(336012)(83380400001)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bf32656-ebf1-4304-6fc6-08d819ecbfa2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3930:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39304C96A303697336ED0CD2E5930@DM6PR12MB3930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRMIQIHPx8qD903ne0Mc4tzq3A86cDNjQn2WdfFM5NvHZezggXzyCnXZBx7CC7aqVkqOVGrAg0DxIm/KC94BzDTqEweUBAPTEzh4RjdbrHBIqjwJQHfqeV1pAf3hnWfegT9YiMYBK7sdbOFaLWxpYY90cr+1nqble+biW5soNbevSL4tKr+t6hGxEVOGvPfe/Op37jxMCUnXYAYHalQGKWx3740qasLSqgUiWpi3FmKC2J5qeDyCCL7SimqaJ/zYNpj8Fa9XeKj9TLqW72eHZR0rMZ1Fuo0Bw52hbUkOI10XmDJ5dSSS9ASJNxHcSc5g+lbacE/x9OxEJR3Kd7J/clEfvPnWinFsBoWZjKsW4WzBATk8WXAuWEFWWysYOYFQ7Jhh3rrAYSyttYnCmC6HSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:49.0165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf32656-ebf1-4304-6fc6-08d819ecbfa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3930
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, eryk.brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
We want to keep the same buffer allocated for use during multiple
hardware initializations.

[How]
 - allocate gpu memory buffer on clock manager construct
 - free gpu memory buffer on clock manager destruct

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  3 ---
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 21 +++++++++++--------
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 ++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index f376058b5df6..6a345d43028c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -174,9 +174,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	case FAMILY_NV:
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 		if (ASICREV_IS_SIENNA_CICHLID_P(asic_id.hw_internal_rev)) {
-			/* TODO: to add SIENNA_CICHLID clk_mgr support, once CLK IP header files are available,
-			 * for now use DCN3AG clk mgr.
-			 */
 			dcn3_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index b27cb52903f5..872ee08b315f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -344,16 +344,12 @@ static void dcn3_update_clocks(struct clk_mgr *clk_mgr_base,
 static void dcn3_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 {
 	unsigned int i;
-	long long table_addr;
-	WatermarksExternal_t *table;
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	WatermarksExternal_t *table = (WatermarksExternal_t *) clk_mgr->wm_range_table;
 
 	if (!clk_mgr->smu_present)
 		return;
 
-	/* need physical address of table to give to PMFW */
-	table = (WatermarksExternal_t *) dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t), &table_addr);
-
 	if (!table)
 		// should log failure
 		return;
@@ -371,11 +367,9 @@ static void dcn3_notify_wm_ranges(struct clk_mgr *clk_mgr_base)
 			table->Watermarks.WatermarkRow[WM_DCEFCLK][i].Flags = clk_mgr->base.bw_params->wm_table.nv_entries[i].pmfw_breakdown.wm_type;
 		}
 
-	dcn30_smu_set_dram_addr_high(clk_mgr, table_addr >> 32);
-	dcn30_smu_set_dram_addr_low(clk_mgr, table_addr & 0xFFFFFFFF);
+	dcn30_smu_set_dram_addr_high(clk_mgr, clk_mgr->wm_range_table_addr >> 32);
+	dcn30_smu_set_dram_addr_low(clk_mgr, clk_mgr->wm_range_table_addr & 0xFFFFFFFF);
 	dcn30_smu_transfer_wm_table_dram_2_smu(clk_mgr);
-
-	dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART, table);
 }
 
 /* Set min memclk to minimum, either constrained by the current mode or DPM0 */
@@ -534,10 +528,19 @@ void dcn3_clk_mgr_construct(
 	dce_clock_read_ss_info(clk_mgr);
 
 	clk_mgr->base.bw_params = kzalloc(sizeof(*clk_mgr->base.bw_params), GFP_KERNEL);
+
+	/* need physical address of table to give to PMFW */
+	clk_mgr->wm_range_table = dm_helpers_allocate_gpu_mem(clk_mgr->base.ctx,
+			DC_MEM_ALLOC_TYPE_GART, sizeof(WatermarksExternal_t),
+			&clk_mgr->wm_range_table_addr);
 }
 
 void dcn3_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
 {
 	if (clk_mgr->base.bw_params)
 		kfree(clk_mgr->base.bw_params);
+
+	if (clk_mgr->wm_range_table)
+		dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART,
+				clk_mgr->wm_range_table);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index c3c151be7d03..82212ae2755a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -273,6 +273,8 @@ struct clk_mgr_internal {
 #ifdef CONFIG_DRM_AMD_DC_DCN3_0
 
 	bool smu_present;
+	void *wm_range_table;
+	long long wm_range_table_addr;
 #endif
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
