Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A2C5518C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123422076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z3upVaC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123422076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D0789FDD;
	Wed, 22 Apr 2020 22:08:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B6589F71
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQvfnqxuIKVKj56hApwwl/U+OBZFAjx0AtKiljCM+tmVSzdeYb7oESffDpIjjojVm+vsGnCBPKB0yncn5gyMO5x4pJ/kEQnJ0JvAbvbVqlupco6pyf26R1Nk+9D+2zAT6jaWtrbi4ZRz3HDeIzKytQNMX+MhzSCAHmx2M8CT5hlvjpkIOGJS+JGKH2azFOHhh1UE+924ZxuT2Rl6QJIVEEq1HNCIt1WascYJBeqrIrMnu/mxyciBz19GZYy8DK5lKSVSOYyPeItLcmy8USkFwqJPJXUB7Gsl2CJWg1yH3qXMUz6tKw4TQdF6uAPCO9GbG80hszdgKvvvvr1xdUOECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1fFuuYGFfxkTE3mL5iGLJxFB86e1Zw9Nn/BbMVwuvs=;
 b=W/e0DTp4/YpzATf+DBjqWpJk+vnBPxm6H2c/JIeRnHKMK4UeJIyiyw5a92zIFIMdxGcjKslwDoeajqBcVJY4va6OJMpco0z3pNCzf0NK5QFg0AKKDr3b5b8gORQjIjY+iTjuSzsxp1rAnfT+MkVYcQL/vj7a/Jo/7+kDDuJXAzNq9wCd6EUa9XDuhDYY1Sc36qf/sY8KB+4RZ6eOn6g8ecLwaP6ILDF1v0tTzMLWyZr2mqQm5RbsnyqjDVuWnuPLL7EJZj6f0ae71T2N6Ldv5IATY8hEAEwmzsj0CAHTmHD3qGJiZaO8xulv6YfhQkU9OWyr91lM5NPzoD305Ru0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1fFuuYGFfxkTE3mL5iGLJxFB86e1Zw9Nn/BbMVwuvs=;
 b=z3upVaC5nm28YoyGeMOzJ6p7qPAyJhzFXB5SWoh5pYmcpIhpwsrg1bw3qgHGm2Ew6B4EVnMVoDkCKveyn4eTXahuC84czpLDwgJy/w9SZtkMOFslzw1SvsPb8AUUlFmO0KBDdYHLqD8iv8XcmnFkvx9wUjpb0sEI0lOM5WI/0ew=
Received: from MWHPR1701CA0004.namprd17.prod.outlook.com
 (2603:10b6:301:14::14) by BN8PR12MB3396.namprd12.prod.outlook.com
 (2603:10b6:408:45::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 22:08:18 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::ec) by MWHPR1701CA0004.outlook.office365.com
 (2603:10b6:301:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:18 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:17 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:16 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/19] drm/amd/display: fix rn soc bb update
Date: Wed, 22 Apr 2020 18:07:53 -0400
Message-ID: <20200422220805.15759-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(428003)(46966005)(26005)(36756003)(6916009)(336012)(2616005)(82310400002)(81156014)(7696005)(1076003)(81166007)(6666004)(316002)(356005)(426003)(8936002)(4326008)(8676002)(15650500001)(70586007)(82740400003)(5660300002)(70206006)(44832011)(47076004)(2906002)(186003)(54906003)(478600001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc01d40-961a-4347-f563-08d7e709a94b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3396:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3396847F5DB88819D3B4AE3D8BD20@BN8PR12MB3396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZczhnmFP1v8jXnrb6oLbiYkYnI27AsSxzNhC1WjmC7cNAyDU0DsGvF1sPdaW2wKeppSdyv3TuxYvXe/BlncSOSjhU99Rl8xUKp1WrTU6xjGzI+86AeXl4G14Yo8BmXp0CwqCvAdk7vjhqj7koEHawd9g3sErB46uy8wM5PTxIT1v3d7WZ2JSvkRd19Db+jHbiMsMqeaJ1Wt1p6cGFJn+z0tmcx/dDpMUs7piITB0hNwcpP3sfGCAIvX85z/vypaa1YqCVunUS4xlpcYMOEyFyhAJNcfrlk95yMTL+3bJqruLG5mT+rpF4TgPLa8mNwCZ3UzRQYSixxi2rJWBuWNUajvn+hZ4mF/dk41YtkS2Fey+YqF4b4pJYLMkFpUjvWE0GADsCmcOAEomwanDGhTc4SPHAzHrlsLbfEwlNYXSQLlrAZhRuO7KkXGl35zGExca4E5RHJCdOOQt3rnI+IMopcoKZVsFSc85aR26/oQGeoPnDLAspT33iceCu4uf/pmoxPTbGZDFZk7b9DXvCvkVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:17.5285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc01d40-961a-4347-f563-08d7e709a94b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3396
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Currently RN SOC bounding box update assumes we will get at least
2 clock states from SMU. This isn't always true and because of special
casing on first clock state we end up with low disp, dpp, dsc and phy
clocks.

This change removes the special casing allowing the first state to
acquire correct clocks.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 71 ++++++++-----------
 1 file changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 78e6259b4ac9..8fcb03e65fdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1379,64 +1379,49 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 {
 	struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	unsigned int i, j, k;
-	int closest_clk_lvl;
+	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
+	unsigned int i, j, closest_clk_lvl;
 
 	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) && !IS_DIAG_DC(dc->ctx->dce_environment)) {
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
 		dcn2_1_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
 		dcn2_1_ip.max_num_dpp = pool->base.pipe_count;
 		dcn2_1_soc.num_chans = bw_params->num_channels;
 
-		/* Vmin: leave lowest DCN clocks, override with dcfclk, fclk, memclk from fuse */
-		dcn2_1_soc.clock_limits[0].state = 0;
-		dcn2_1_soc.clock_limits[0].dcfclk_mhz = clk_table->entries[0].dcfclk_mhz;
-		dcn2_1_soc.clock_limits[0].fabricclk_mhz = clk_table->entries[0].fclk_mhz;
-		dcn2_1_soc.clock_limits[0].socclk_mhz = clk_table->entries[0].socclk_mhz;
-		dcn2_1_soc.clock_limits[0].dram_speed_mts = clk_table->entries[0].memclk_mhz * 2;
-
-		/*
-		 * Other levels: find closest DCN clocks that fit the given clock limit using dcfclk
-		 * as indicator
-		 */
-
-		closest_clk_lvl = -1;
-		/* index currently being filled */
-		k = 1;
-		for (i = 1; i < clk_table->num_entries; i++) {
-			/* loop backwards, skip duplicate state*/
-			for (j = dcn2_1_soc.num_states - 1; j >= k; j--) {
+		ASSERT(clk_table->num_entries);
+		for (i = 0; i < clk_table->num_entries; i++) {
+			/* loop backwards*/
+			for (closest_clk_lvl = 0, j = dcn2_1_soc.num_states - 1; j >= 0; j--) {
 				if ((unsigned int) dcn2_1_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
 					closest_clk_lvl = j;
 					break;
 				}
 			}
 
-			/* if found a lvl that fits, use the DCN clks from it, if not, go to next clk limit*/
-			if (closest_clk_lvl != -1) {
-				dcn2_1_soc.clock_limits[k].state = i;
-				dcn2_1_soc.clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-				dcn2_1_soc.clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-				dcn2_1_soc.clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
-				dcn2_1_soc.clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
-
-				dcn2_1_soc.clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-				dcn2_1_soc.clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-				dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-				dcn2_1_soc.clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-				dcn2_1_soc.clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-				dcn2_1_soc.clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-				dcn2_1_soc.clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
-				k++;
-			}
+			clock_limits[i].state = i;
+			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+
+			clock_limits[i].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+			clock_limits[i].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+			clock_limits[i].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			clock_limits[i].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			clock_limits[i].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			clock_limits[i].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			clock_limits[i].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		}
+		for (i = 0; i < clk_table->num_entries; i++)
+			dcn2_1_soc.clock_limits[i] = clock_limits[i];
+		if (clk_table->num_entries) {
+			dcn2_1_soc.num_states = clk_table->num_entries;
+			/* duplicate last level */
+			dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
+			dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
 		}
-		dcn2_1_soc.num_states = k;
 	}
 
-	/* duplicate last level */
-	dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
-	dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
-
 	dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
