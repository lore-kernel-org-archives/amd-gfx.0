Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5FDC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E297822AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E297822AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9DA6EC80;
	Fri,  4 Dec 2020 21:31:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90496EC7F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLIrimhIiOhKYvl7tM2STOzN1aYHhxkIAyorL9xkwo+J2ee6hy5jwVK3ct84h5FBzNCRVZu5i/D84erVQPXvoW94KhjkDrhGzOxC4hBBh4pRcJ60D+xhS7Dz6ZrEVAMHpx+/zD8UIz8M+rBSZSuP3Pi2okbPj0EfA2qRrkKqBaZNA7K6v1tzXTgQ0wJwwJ7sBKNe/EEL5tCP7LXFEPUQcMHE710M7/cusMJr5kReJvRQqUUe+t2L+WVqnJwj1hkzdwERkRYeu9wHICJxmAO3yKZKOxUYCXQO40CiAapAb2Q7fZPN29+QebrkYXf/KBo7erBN1erNNF490lfPI4ssOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmvtw/NQa8FwsDX2CsHkNPO3Ip99YisbNT7rengIz6A=;
 b=bNDTy48Ky2NAorL6EdAekZmR66ebs+WdFSOFqBAqUJ6cSRqlHuB8lE5Wauo4wHR38r14Egw8FOBvzbGESz3BqlZ+UNdDrQ2eYnrrlJIeGCRDAzGmjmgdaG3ShfCpHiQKUEvoRJ/nMVzEWvug6xLifUW3SzjwTLkuFDuMRhLdJ4yFnAWvgYEqFoHv4WJZ3t8TMZq/Gb/SZ5ooBLHHIG7QzoBOnKbxU6mJRn1wC6FE+dumLUeAX/wznTrmYwUsEIwBivPP85Hk4tldNSgywbs4JqVRlv0zq2+HCk9LsBKXnP+poGZEMUnyGfdd2lB2bOYnnb25K3EEjJnWW6UxPBbipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmvtw/NQa8FwsDX2CsHkNPO3Ip99YisbNT7rengIz6A=;
 b=ushat/dC/H+KYy90MXo+pdkl55+srpGsK2ZNbkWVriqoTpUctM83zJS/entBIcFH+0XEZeIsWDbD2hnDe0tv0g8fQHg/RDzMPafyRKA+BXOC2XxS5xHf/NHgS86ZYXiENqf9+APNzMvQZVzHNfNIZNbC/NtQ2KbIIbIGWe0ykdA=
Received: from DM5PR15CA0055.namprd15.prod.outlook.com (2603:10b6:3:ae::17) by
 CY4PR1201MB2548.namprd12.prod.outlook.com (2603:10b6:903:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 21:31:00 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::ce) by DM5PR15CA0055.outlook.office365.com
 (2603:10b6:3:ae::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:59 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:58 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:52 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/17] drm/amd/display: Add wm table for Renoir
Date: Fri, 4 Dec 2020 16:28:45 -0500
Message-ID: <20201204212850.224596-13-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc69a2de-0e02-45f5-9825-08d8989be4b8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2548:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2548A5303DF8E09CB0E4D899E5F10@CY4PR1201MB2548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWCiaeQCuvsppWQD0OTSpYOJ5n/kL9QLQuS8bkcSWyalks/BfRFPOpl7RK1quc78fJ+AvGgDHcNBJnJGgpg+MCBcaNAIzJVKNdacJpTJdlUuLM14wVj3ydXxQCSuh0v7bYp78KJmiDJVfKDtnDngebXaYa5968VA5V09xP17NgKyzoMo713p+AQvuAlxhMcAp9xtkf8Tfa5S65VIpnfx5fXqXFRQxejaKb5pshJ6Q+vTd9V4xfalM/W4oz6SI1RK7Bwdj2gCsMvLST5V6wDsGB6XhVUz8NadkR/KCmJlLufDPo/lQLBbVRd3N9majZibuqf6lJm3itaQZF79x6oc1EMz8YprC0dmV6VnO7MjWAwg2Cnw1Kv4hA6dkjdwj+t7wF/oFL+kbTQwAS6FPqBC5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966005)(8936002)(186003)(86362001)(336012)(82310400003)(8676002)(4326008)(356005)(2906002)(44832011)(6666004)(83380400001)(2616005)(6916009)(47076004)(54906003)(82740400003)(26005)(36756003)(316002)(81166007)(70586007)(426003)(1076003)(70206006)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:59.6611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc69a2de-0e02-45f5-9825-08d8989be4b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2548
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
Without additional HostVM Latency, Renoir takes 2us longer to exit
self-refresh. This causes underflow in certain cases.

[How]
Add table for Renoir with updated sr exit latencies for WM set A.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 93 ++++++++++++++++++-
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index fe6dc1e68e60..6f4fe8fce6b7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -621,7 +621,7 @@ static struct clk_bw_params rn_bw_params = {
 
 };
 
-static struct wm_table ddr4_wm_table = {
+static struct wm_table ddr4_wm_table_gs = {
 	.entries = {
 		{
 			.wm_inst = WM_A,
@@ -658,7 +658,7 @@ static struct wm_table ddr4_wm_table = {
 	}
 };
 
-static struct wm_table lpddr4_wm_table = {
+static struct wm_table lpddr4_wm_table_gs = {
 	.entries = {
 		{
 			.wm_inst = WM_A,
@@ -732,6 +732,80 @@ static struct wm_table lpddr4_wm_table_with_disabled_ppt = {
 	}
 };
 
+static struct wm_table ddr4_wm_table_rn = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 9.09,
+			.sr_enter_plus_exit_time_us = 10.14,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 10.12,
+			.sr_enter_plus_exit_time_us = 11.48,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 10.12,
+			.sr_enter_plus_exit_time_us = 11.48,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 10.12,
+			.sr_enter_plus_exit_time_us = 11.48,
+			.valid = true,
+		},
+	}
+};
+
+static struct wm_table lpddr4_wm_table_rn = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 7.32,
+			.sr_enter_plus_exit_time_us = 8.38,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 9.82,
+			.sr_enter_plus_exit_time_us = 11.196,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 9.89,
+			.sr_enter_plus_exit_time_us = 11.24,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.65333,
+			.sr_exit_time_us = 9.748,
+			.sr_enter_plus_exit_time_us = 11.102,
+			.valid = true,
+		},
+	}
+};
+
 static unsigned int find_dcfclk_for_voltage(struct dpm_clocks *clock_table, unsigned int voltage)
 {
 	int i;
@@ -813,6 +887,11 @@ void rn_clk_mgr_construct(
 	struct dc_debug_options *debug = &ctx->dc->debug;
 	struct dpm_clocks clock_table = { 0 };
 	enum pp_smu_status status = 0;
+	int is_green_sardine = 0;
+
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	is_green_sardine = ASICREV_IS_GREEN_SARDINE(ctx->asic_id.hw_internal_rev);
+#endif
 
 	clk_mgr->base.ctx = ctx;
 	clk_mgr->base.funcs = &dcn21_funcs;
@@ -853,10 +932,16 @@ void rn_clk_mgr_construct(
 			if (clk_mgr->periodic_retraining_disabled) {
 				rn_bw_params.wm_table = lpddr4_wm_table_with_disabled_ppt;
 			} else {
-				rn_bw_params.wm_table = lpddr4_wm_table;
+				if (is_green_sardine)
+					rn_bw_params.wm_table = lpddr4_wm_table_gs;
+				else
+					rn_bw_params.wm_table = lpddr4_wm_table_rn;
 			}
 		} else {
-			rn_bw_params.wm_table = ddr4_wm_table;
+			if (is_green_sardine)
+				rn_bw_params.wm_table = ddr4_wm_table_gs;
+			else
+				rn_bw_params.wm_table = ddr4_wm_table_rn;
 		}
 		/* Saved clocks configured at boot for debug purposes */
 		rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
