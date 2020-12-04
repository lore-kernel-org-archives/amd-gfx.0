Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44EFC4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804AF22AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804AF22AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0126EC7C;
	Fri,  4 Dec 2020 21:30:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848686EC7C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP1UcaUdxthZWfiIKO3WiTKv8Q6TzJRm3G7+2j2ehyyo+k6GHALKSeErTuOBTe1aKYDo0iZuSF5m9550UTogaQZhG+17/ooSmY2ZNqtR3GxEPKRvABJLRy4CgOEALisWPPOzI0hO7JuMrXcyfNm3Oja/Uer1cRa15iduwCNHHO7bPe+VH/iUU8o2f7tVg44JErYyhvIfJIa9nI0je4RCvEUZGA4WLlyaM85RHa14yjsB11sotLMe85gxh3VvjscfZvu2qMtDEAsnYktCTbmYIP2J9buQuvprGzKHf/OiLojiehzUs6CEEdNIjtCmMejU2n50bzFd2t5CTz+X0uq+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVmx2Eya1VVmIc378+iczyzO+cIYUs3S2uAmFdayqfY=;
 b=cUnUUabo/3PDMkud8FXnoXdLYgYi1N5fqaQPi0TFSjY3VPA8Lk1uYpH/og8AdIukGjuRKu5owou63SJycxQE0UpovjHLXTBMjvanqPt4PvREvkSULjFOyIBs8ndt0BPubQGveqwIvVZsAnaEmwt6LQnI2c29MIOE5OPE22ZpltLsrfj2Bq3JIs3Q7wfw8eFNckfEjt/O8ro/IdmSHVzLgIGth3GzPKTF3YUZ+ZWm8vgggigJCQhodY90+fPlF+URD7ELuyn6FnoGODg5n4QRDCAMt7Wo0JDyy+cn126jpDnSCg27XRD2rKVM2mJ4Dbu4a4z4ViuWhsKfeoDvo3NVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVmx2Eya1VVmIc378+iczyzO+cIYUs3S2uAmFdayqfY=;
 b=yN0ba2nOkya+5co/A5iTPC30wqKOn1XA9XD2pt5QVsFjDx5CGhfEQtv33LGIJu6AnDRX5QKu10FSS4MTgHlsfzkF7ZEjg1fcuESIMee+iaJjxtHj0XknFgAuGiKtS4YUA0mGRiYmuo0mH9EUbIJr4KEVJRnv1M/rbCnmOKjs97M=
Received: from BN6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:404:23::14)
 by BN6PR1201MB2464.namprd12.prod.outlook.com (2603:10b6:404:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 21:30:22 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:23:cafe::9c) by BN6PR03CA0004.outlook.office365.com
 (2603:10b6:404:23::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:07 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:07 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:01 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/17] drm/amd/display: Expose clk_mgr functions for reuse
Date: Fri, 4 Dec 2020 16:28:37 -0500
Message-ID: <20201204212850.224596-5-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5042ccd-1837-41f5-b431-08d8989bce77
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2464:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB246407B539CCF2305D5F6C87E5F10@BN6PR1201MB2464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SlAxNs3mISE93tBwyhDbO6AuCS/lvDzHyoPHeKK0VWKpD1f7+RhSXvz/EVf6XItdog+61Ych8WonxFnKXiykM7mldWrLe+orGxez88GXv3FO9cVOGZigsjNUyMoby3fUejqbE+Of9V3XVE1pyhRWcW/7/f5KjtLMU2t5Lt9bUbJUMoGA9NagpqpbogTX+7rwOQfu+bKeo3dRr+Zn7kdwQ+LVTznb35zQcq4KaRzyIE8roD2jqibQ8xxpP0uXRFIReMD31wfn/tclxpUwU6hFNtPcIr8tKKuXFtBTCsocrItRIKsNH1uLvxnCDyC6+iw8sKdQzqn89osRDFHbEF7i9Rk20QIvkzqmc8fhTnNLvAJIz0EUSYjyXiBSYGIoJT1ZJx2o6SBoepZGm8/62zeQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966005)(316002)(82740400003)(26005)(426003)(6666004)(70586007)(44832011)(86362001)(5660300002)(4326008)(47076004)(336012)(8676002)(2616005)(70206006)(478600001)(54906003)(1076003)(186003)(82310400003)(8936002)(83380400001)(81166007)(2906002)(6916009)(356005)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:22.3729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5042ccd-1837-41f5-b431-08d8989bce77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2464
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Yang <eric.yang2@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[How & Why]
Allow clk_mgr functions to be reused by making then non-static

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |  8 ++++----
 .../gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h | 10 ++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 82cb688ba5e0..5b466f440d67 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -499,7 +499,7 @@ static void dcn3_init_clocks_fpga(struct clk_mgr *clk_mgr)
 /* TODO: Implement the functions and remove the ifndef guard */
 }
 
-static struct clk_mgr_funcs dcn3_fpga_funcs = {
+struct clk_mgr_funcs dcn3_fpga_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.update_clocks = dcn2_update_clocks_fpga,
 	.init_clocks = dcn3_init_clocks_fpga,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 98cbb0ac095c..9a8e66bba9c0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -32,9 +32,9 @@
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
 
-#include "vg_clk_mgr.h"
 
-#include "dcn301_smu.h"
+
+#include "vg_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
@@ -631,7 +631,7 @@ static unsigned int find_dcfclk_for_voltage(const struct vg_dpm_clocks *clock_ta
 	return 0;
 }
 
-static void vg_clk_mgr_helper_populate_bw_params(
+void vg_clk_mgr_helper_populate_bw_params(
 		struct clk_mgr_internal *clk_mgr,
 		struct integrated_info *bios_info,
 		const struct vg_dpm_clocks *clock_table)
@@ -709,7 +709,7 @@ static struct vg_dpm_clocks dummy_clocks = {
 
 static struct watermarks dummy_wms = { 0 };
 
-static void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 		struct smu_dpm_clks *smu_dpm_clks)
 {
 	struct vg_dpm_clocks *table = smu_dpm_clks->dpm_clks;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
index 80497df20ba7..b5115b3123a1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
@@ -39,5 +39,15 @@ void vg_clk_mgr_construct(struct dc_context *ctx,
 
 void vg_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr);
 
+#include "dcn301_smu.h"
 void vg_notify_wm_ranges(struct clk_mgr *clk_mgr_base);
+
+void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+		struct smu_dpm_clks *smu_dpm_clks);
+
+void vg_clk_mgr_helper_populate_bw_params(
+		struct clk_mgr_internal *clk_mgr,
+		struct integrated_info *bios_info,
+		const struct vg_dpm_clocks *clock_table);
+
 #endif //__VG_CLK_MGR_H__
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
