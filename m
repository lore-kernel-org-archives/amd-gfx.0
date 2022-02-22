Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915F5C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 21:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B64F10E80D;
	Tue, 22 Feb 2022 21:53:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352D610E80E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 21:53:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfy1PJLGeEQ9kYIIHZ2ZNWLaBAjnNFpvynyS4SKjFMsHXvUgpV8yvlujz9+aWtduf/CE10WYdZu788UsbA68FgEB602PnaIo8IX6FstVIFbgXD6FXP68zU1YqktEQ5AXZRIvceSnNh/g9eLszoFxInGO/AciwgsLt9w1Rv0s3yitVsenQ1eq1P602e+q7TXkz3pBV8rxeuxpomUjZ7D67BlHesKSypgH/G0aG0ea0nUqw6jzJS5JH5fVJ8cNSK90sfhGhb9Ndr7on8MVKgAV08K2UQ0dNW50chBGNBnOhlKHlk5PPMNVW4snj/M40tJ7+p28s12UAMvmrJIX0HInZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbhfBx/2+62FaKyDGpKmEB3m6biB0k919mMlQYSFbxs=;
 b=de53N6lfVfKlco6LK/0pp/hVUw8DwChhzG+1YWbWKgjA4TooYY4Sx0eh2zGyFYgdhPQS905oTTztu36XfjayPjIKDCbZTt0IW+19fB+QFfEAcgBAhtmXXi1RU5u22OJxzxOpHbxIGu+IpxlyJtdiXuRiVL67yBTxcl4wV+yViT9ap1u61Ci695ByFEB0Vvtd8m/UUaE0ZvalW78yOKeosuJNXPUFgQ2ljtILc3mLb6nfC2bZ6SbzXD6hfGMYyFxoIXw0h7PtPFuZnhfofD4vJgqrIzSNPNaopap/SJ8+dK/wUqxKvzdRzbuI76VroJ076UEQa0Qvwmsds+owCL8ELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbhfBx/2+62FaKyDGpKmEB3m6biB0k919mMlQYSFbxs=;
 b=kUeN4C0WqWkkOc+gE2vlwAEbr2yGBs5vq72EiLR78WcnJ2IjWzqBABQWz27I97EszvqSWs9ogWTBWucrEdUU8Q4cUXlpAquA1o5trxBugzzWv0OJ14PBRSUDrsyO1CntW4kddnU6l349TVcsWTQ+jXVFJipzRBORhs+zKa918SI=
Received: from MW4PR03CA0099.namprd03.prod.outlook.com (2603:10b6:303:b7::14)
 by DM5PR12MB4661.namprd12.prod.outlook.com (2603:10b6:4:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 21:53:49 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::fb) by MW4PR03CA0099.outlook.office365.com
 (2603:10b6:303:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Tue, 22 Feb 2022 21:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 22 Feb 2022 21:53:49 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 15:53:46 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd/display: Set compbuf size to min at prep prevent
 overbook crb
Date: Tue, 22 Feb 2022 16:53:34 -0500
Message-ID: <20220222215335.3009315-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222215335.3009315-1-qingqing.zhuo@amd.com>
References: <20220222215335.3009315-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3202e489-3e1a-41a1-466a-08d9f64dcede
X-MS-TrafficTypeDiagnostic: DM5PR12MB4661:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB46610FF33ECD16231A387BB5FB3B9@DM5PR12MB4661.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZdvnQ4nJig0hG8jrh8VpO1OTvVauYxsI7k2JrstuPDIVn6u/429tXhPfk5+9ZuGs8eYeOLv2zaqKmIoUPTcAzsopm6NAvo824RouJQquDf7Aud0hQZRC2qMQL+F+otiaK7HzVUpQI23gzsMLoqbPUZ6rm9nwck8Z/Wu6kT8Xbygjq62CrXTqelNBMln6AG2P180q8pbNznO7LYsZzMmzmG/oOkQWwwvAeMo22Q6oMXrPuNwozUVKAnETw6v7oUKneopRf1ynTZv2EtLkjXIZdmANXZb2fqS4kpfDYm0zr14SMtMbXgjlFJQuGvdhGUykgjcfhSSe0JbAKS0gQCuCHv/c+m/zBRJ2ZMBVT3gebpUWUhfOR7pQnrr9sN59h/1K2vRlQPn8zMNRebspX5nvnQprdEeNC25wLM4gkTG4o3QhvIWbH/o7Twf/dsHmZjLP2DPkYB+XaLWJbiykH4Vztq3Cdx8tvOeWg11GK1XgWgWkMNv0aVSs9eR3o2oTHdrFNovgJh4W7V2Yx3i4vHZafQFFg4qNjrAylpxOq8QO51YuYTCGmUuZBmXTKRo+QIT+iP8aSwRtdDH+MbnLM+JU26UBrCARmvBrxMKTPlvDvC74RFAhxViRsFArPycsJMrPwfFWcXv1akpT2KoThg4eNTNl6J3yhHMCqGrANXe+OALjCdQzdCXQKNYJkiVa6IXNlE59picOf02R+NOiYEIZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(6916009)(316002)(186003)(26005)(1076003)(40460700003)(336012)(426003)(2616005)(54906003)(81166007)(2906002)(356005)(5660300002)(8676002)(70206006)(86362001)(4326008)(6666004)(70586007)(508600001)(16526019)(36756003)(83380400001)(44832011)(8936002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 21:53:49.1349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3202e489-3e1a-41a1-466a-08d9f64dcede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4661
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com, "Ma,
 Duncan" <duncanma@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Ma, Duncan" <duncanma@amd.com>

[Why]
Detbuffer size is dynamically set for dcn31x. At certain moment,
compbuf+(def size * num pipes) > config return buffer size causing
flickering. This is easily reproducible when MPO is
enabled with two displays.

[How]
At prepare BW, use the min comp buffer size. When it is to
optimize BW, set compbuf size back to maximum possible size.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Duncan Ma <duncanma@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c   | 12 ++++++++++--
 .../gpu/drm/amd/display/dc/dcn315/dcn315_resource.c  |  1 +
 .../drm/amd/display/dc/dml/display_mode_structs.h    |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 20a9cbb7c0a8..1ef880fed776 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1818,6 +1818,7 @@ void dcn20_prepare_bandwidth(
 		struct dc_state *context)
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
+	unsigned int compbuf_size_kb = 0;
 
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
@@ -1829,9 +1830,16 @@ void dcn20_prepare_bandwidth(
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
+
 	/* decrease compbuf size */
-	if (hubbub->funcs->program_compbuf_size)
-		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, false);
+	if (hubbub->funcs->program_compbuf_size) {
+		if (context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes)
+			compbuf_size_kb = context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes;
+		else
+			compbuf_size_kb = context->bw_ctx.bw.dcn.compbuf_size_kb;
+
+		hubbub->funcs->program_compbuf_size(hubbub, compbuf_size_kb, false);
+	}
 }
 
 void dcn20_optimize_bandwidth(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index f22158bb4b13..46b170e60a54 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -147,6 +147,7 @@ struct _vcs_dpi_ip_params_st dcn3_15_ip = {
 	.hostvm_max_page_table_levels = 2,
 	.rob_buffer_size_kbytes = 64,
 	.det_buffer_size_kbytes = DCN3_15_DEFAULT_DET_SIZE,
+	.min_comp_buffer_size_kbytes = DCN3_15_MIN_COMPBUF_SIZE_KB,
 	.config_return_buffer_size_in_kbytes = 1024,
 	.compressed_buffer_segment_size_in_kbytes = 64,
 	.meta_fifo_size_in_kentries = 32,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 8f9f1d607f7c..59f0a61c33cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -141,6 +141,7 @@ struct _vcs_dpi_ip_params_st {
 	unsigned int odm_capable;
 	unsigned int rob_buffer_size_kbytes;
 	unsigned int det_buffer_size_kbytes;
+	unsigned int min_comp_buffer_size_kbytes;
 	unsigned int dpte_buffer_size_in_pte_reqs_luma;
 	unsigned int dpte_buffer_size_in_pte_reqs_chroma;
 	unsigned int pde_proc_buffer_size_64k_reqs;
-- 
2.25.1

