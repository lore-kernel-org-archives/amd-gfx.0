Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551A2C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011A810E6CD;
	Fri,  3 Mar 2023 15:45:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D4010E6CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIWzKSulkWqY350esw1Cw9p2XpJRVnlOXB4XXws/2b2fyIuxqe+6rdT9UI0ThEaYBHQ7F4uLcpMuYlOKSDpwT8OWaKI8Aue4yQgfrg/TaXvczW1C6haT3bf2z3AcC8zkRqJiucHFxUqieQ/doYEQLYaMht2mvjYHmPCb1e1NZiqXvs8PnEuwMUCZIO9j4M2GbGHC1nbVGNgMC8Wvm6R3T1a9/maJ54ynvoAZFKQQjaC2kux3BAcs/a1zKN74Kq9lccqVxeFwyJMrBArPrUsBmGPJfAPNtccM3pD+E2xUUjKaIt6pWc0Wfo5LdfJlUp5hJicRTGIRrlK1S77cTg8AWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRj8eqlUBL+3jiPQOfJziWs2qC6aopnCXzRoAFilK6o=;
 b=FEp7DirgTHSZeUzi+9I2G0MPjvHOxcSPz0PLw8GRiPFsQju2vThRaWX+eDzPfrybM2rPG5FtstSa6uZw3ouq9AL6llUrOfYwarYq9l0TpnTyJoPrLyQoz+6kIeDLbz6N5Y6bmtBof9ma8AocevpoFmMFbkN5t+WTuN66VVkU2RMHjy5IqkhcrYipLVmGtP/oVbMOJODqy5yN35L1yALNkkkBN5Tk/is4/CzCDtT2QysRr5J/zhFTdNvB7cTl4YnVASMeLLmUZVB1AHHBB3+1qXgxJ2yzjQaUmE6qNPFXBDsbKA3LBBx/+3oKAVrF7Sw5UclINrm8l3e7/Ri7TCVT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRj8eqlUBL+3jiPQOfJziWs2qC6aopnCXzRoAFilK6o=;
 b=D+cUx0XFZbz4A9a7twuehXNsCRXgw4pgmGagLgI8Wdfaywi2cxli+/RFpbwk8Y0C8ff8NTcHigTlL0rOg3rcKNmJSjzko2mfD+jo7ZtsB7F6Eqemthnf9uevTMTORRclh85nAyc9Xltc2h5KG+31dYcoTOAG2kiyLMvSuuaHcLw=
Received: from MW4PR04CA0235.namprd04.prod.outlook.com (2603:10b6:303:87::30)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 15:45:23 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::40) by MW4PR04CA0235.outlook.office365.com
 (2603:10b6:303:87::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:45:23 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:44:55 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/33] drm/amd/display: Add minimum Z8 residency debug option
Date: Fri, 3 Mar 2023 10:39:54 -0500
Message-ID: <20230303154022.2667-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e08eaf-1746-4ced-4987-08db1bfe4d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17HF6WmEvtOvyDhKk0emT2P1nKQ/XIv90NAbkKBvVATHy8EAeygWteSpqLJKhvXa8Lth3MgeQF+FoR2XX/WmLFWrZpgej6PY6GlHMY4Fuujahe9KePQOmk9aS+1ZBGjIVGv+syLEQ10xU/guqu7ijUNbkrNZxsnQ//EmOxRE3h/whFi6X8xIrh4n61UGzCAcNSyaEkyyvFvsZlg1zPD+uIJMJRz0+W2krPctMQKBssZK1sS3TLv5nUW5h88osr3rTGyurcxyr+Va8baR+EDRKAoSkH65qSQDEuYIRK+5narIlxMvyx5FK+hTiaQu/K55ajOfGXaGwTiOPOJCn90a0WYa2jaiKl3UlfIMRMlXatLGWASLKZE3WVmEE+0PjZ0OpUWuNinZ+MAxYBoLp8u8B6jW5HMnR5mTzk1XUlRKGD3tegWgxsa1iHCy4aZ78EBq9L/Hz33KC4Q43z+W+6EHA+36snp1zFlVE2UzO6q9BIavjZnBG8NFU9HXt6v/5nVO9F576FK87VmWCTSbIe+kbhrk7vK84+qoS9iph9L/TA9ngDbIIbpZR/5eusjtTyDz2qlFw58JJDpQHuRLga536BptR8gYpbCNsX+wc51XSoSeltfn277cM7UQ637yrWOj4eAFPvfcVGpuLc7XpD6/BZFv3RrLrYrfCccq6IrpR/htQFDKDfMbKFNF3q29enyYPw3sarhzrz4yi87YI5Z91QJtSaZRzGbZcKcuWeAPGrQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(426003)(40460700003)(36756003)(47076005)(8936002)(478600001)(81166007)(5660300002)(82740400003)(82310400005)(356005)(40480700001)(86362001)(186003)(336012)(2616005)(26005)(1076003)(16526019)(70206006)(8676002)(44832011)(4326008)(70586007)(2906002)(6916009)(41300700001)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:45:23.5712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e08eaf-1746-4ced-4987-08db1bfe4d64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Allows finer control and tuning for debug and profiling.

[How]
Add the debug option into DC. The default remains the same as before
for now.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c    | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c3814f40a102..f1ea9031a191 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -795,6 +795,7 @@ struct dc_debug_options {
 	unsigned int force_odm_combine; //bit vector based on otg inst
 	unsigned int seamless_boot_odm_combine;
 	unsigned int force_odm_combine_4to1; //bit vector based on otg inst
+	int minimum_z8_residency_time;
 	bool disable_z9_mpc;
 	unsigned int force_fclk_khz;
 	bool enable_tri_buf;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 54ed3de869d3..8fc89aeb86d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -887,6 +887,7 @@ static const struct dc_plane_cap plane_cap = {
 static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.enable_z9_disable_interface = true,
+	.minimum_z8_residency_time = 1000,
 	.psr_skip_crtc_disable = true,
 	.disable_dmcu = true,
 	.force_abm_enable = false,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index d3ba65efe1d2..f3cfc144e358 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -973,7 +973,8 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
-		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > 1000.0;
+		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
+		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
 
 		if (dc_extended_blank_supported(dc)) {
-- 
2.34.1

