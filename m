Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2784CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F62610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3F62610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561216E231;
	Fri, 24 Sep 2021 19:10:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB346E231
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL+nJWnakatbeBY/TYvbqirztshv8vWkxedMyTOLAWwcafzrzzwwKZzdUDXLuuyl1ZLiTJ0Y6zl2/5ffHshE01j9uOdFkTk9Zzdxz0Gjw79eYufhvu3RgE8LYHYJS+vWgbMng37v3g+j6lRLFDLkt0zJ6XzXLzFpmuDnwOMLweHDKvww28Rm7/kSxko38IOkZO0IHSOyXEfBtTOIXQZjwqYk8muG8rR+hg7wq1c06u6XqEDf6T4QJDPNkDOZ8+vuBECQyPrqKEh/eT0pla0u3+ZiAZz4F6WbYsK6C7iRQF15CowOW1vc09SCR4h+GOEM0I2dy9qRR8ywVd20YpUSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=z8uPZz5OgR2EJjObfU5oFW6jWwKw30AeyVCPGRNgM3s=;
 b=b9v2hNO0iPf2M5eTDPwAgS0wU4JKn++TL41/mWSXmPLxB0AV7Ny331/HzHpY8Ii0pHvzfnIgm+cn42nrsk3g4ObKkKtsK8Q6Aeop9HIkKcgMFIfvzySW8vVn/W3F6b8B68W6KTnYS8k0D/6DTC5dmGEtVItD97UM6KXT4yn667K8kHBg30PGhPpK8sEYULx3rnmk5LRQlS2llZffW24ocyV8yTuitvw1NWKZJQ+VGa/ruY9uDV6+hSyN2idSdGFTnLOgILHyyduzJKLegnYc1fvID1SLWYRLSduQpYmzuynY1cJ1PQ2/iByqvCxHaZU9Lu18OYRqH4hJP8UMpG3WdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8uPZz5OgR2EJjObfU5oFW6jWwKw30AeyVCPGRNgM3s=;
 b=OP/Xu5Zw58KqBHZmXSALmpttCNi3JseF3PqgDb8LPlR78nEQjEI2zL0x1/YVE/Ro4cE73NSe8/1nuVsLliqvZCjFlaobrMTHgY0hiRrw7rePU2gFaLMieuczyvhzu74MIpkSc7kKXsOtjfufxXhDsFZGT24GkC7BiJzRFvYfUTg=
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:10:44 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::9e) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:44 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 12:10:43 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:41 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 23/24] drm/amd/display: Update VCP X.Y logging to improve
 usefulness
Date: Fri, 24 Sep 2021 15:09:33 -0400
Message-ID: <20210924190934.1193379-24-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66b00ea0-d9c4-4fb5-7f16-08d97f8f0229
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268CA431E59D25D16BF12EBEBA49@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FL8D3fIa/h53jDxnd70K1gej1AROKs016r/1CtM9wdln1zJq1R2wePC/lSfr2+Z8iIRw8rAiWFNmKXTdjFHQHtrkI+/FfnYAjEHMTCLPVQ8npm0vJFqKPCRuXPVCKasYyNLROAUlOiSvyH2I12jONEWjJyGaXYnWVJtN+1uRp7g3Syg0GhYGthAfoS10WPoDnAGUbE2HAIyFAdSc7tcMfqd+le/AjMpqyvD3T7a6xZDvu20d8Kvk9HX9I87FIhylIDx5Ws8HcWvX6S9suzdvG1K0ABbKArF7OWVVfyWmBoORo0g06nmZUbcoM2XNIg5iwC905hyVMuYnSYt2fdREgFyqNctGONiNtHfs3/JMXwN8BnL3sEKqVqHE9sKOg5+qeq8lhoZZmsV71p3Q6+LSPhf1F18hygysRQRyNl2FHac3cWq/nNSGst/SLtveSph7h6auN25YwsHpszR+T7TXJMpm+rVFDQ/wwl7EUx1UDRHEq5jQzNeN5RSOv9r7o2v0RQl/W354OK+K9kyMo6Fw0QpcFkRdEnrFIDnqRlk1TxOe6ivqURLD7e0i711005T92jfcjpxqhPLDXj6Mk5P31R7k61hNaWIxfruJhZDmgHfdmUysproyVx62EBSAIZoZ4ndZAnGsxgDiAuptPpmSzPsy1/81JzEmA7vYN7hibkU4r85xKQMTwLbY8UxGFSFgxM5ObASJ0kXkAHc9PDX6+psiRubimGyz7ZCTpNc4vrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(316002)(26005)(2906002)(36860700001)(4326008)(7696005)(82310400003)(36756003)(47076005)(2616005)(6666004)(426003)(186003)(8676002)(5660300002)(15650500001)(8936002)(54906003)(356005)(83380400001)(70586007)(81166007)(508600001)(86362001)(1076003)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:44.2540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b00ea0-d9c4-4fb5-7f16-08d97f8f0229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Recently debugging efforts have involved setting/checking the
X.Y value used during payload allocation. Current output for
Y was calculated with incorrect bitshift. Y value is also not
human readable.

[How]
Refactor logging into separate function. Fix Y calculation error
and format output to be human readable.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 49 ++++++++++---------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f3a1219c0bb9..02c7a18c095f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3197,6 +3197,29 @@ static void update_mst_stream_alloc_table(
 				work_table[i];
 }
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+static void dc_log_vcp_x_y(const struct dc_link *link, struct fixed31_32 avg_time_slots_per_mtp)
+{
+	const uint32_t VCP_Y_PRECISION = 1000;
+	uint64_t vcp_x, vcp_y;
+
+	// Add 0.5*(1/VCP_Y_PRECISION) to round up to decimal precision
+	avg_time_slots_per_mtp = dc_fixpt_add(
+			avg_time_slots_per_mtp, dc_fixpt_from_fraction(1, 2 * VCP_Y_PRECISION));
+
+	vcp_x = dc_fixpt_floor(avg_time_slots_per_mtp);
+	vcp_y = dc_fixpt_floor(
+			dc_fixpt_mul_int(
+				dc_fixpt_sub_int(avg_time_slots_per_mtp, dc_fixpt_floor(avg_time_slots_per_mtp)),
+				VCP_Y_PRECISION));
+
+	if (link->type == dc_connection_mst_branch)
+		DC_LOG_DP2("MST Update Payload: set_throttled_vcp_size slot X.Y for MST stream "
+				"X: %lld Y: %lld/%d", vcp_x, vcp_y, VCP_Y_PRECISION);
+	else
+		DC_LOG_DP2("SST Update Payload: set_throttled_vcp_size slot X.Y for SST stream "
+				"X: %lld Y: %lld/%d", vcp_x, vcp_y, VCP_Y_PRECISION);
+}
+
 /*
  * Payload allocation/deallocation for SST introduced in DP2.0
  */
@@ -3214,18 +3237,7 @@ enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx, bool alloca
 	if (!allocate) {
 		avg_time_slots_per_mtp = dc_fixpt_from_int(0);
 
-		DC_LOG_DP2("SST Update Payload: set_throttled_vcp_size slot X.Y for SST stream"
-				"X: %d "
-				"Y: %d",
-				dc_fixpt_floor(
-					avg_time_slots_per_mtp),
-				dc_fixpt_ceil(
-					dc_fixpt_shl(
-						dc_fixpt_sub_int(
-							avg_time_slots_per_mtp,
-							dc_fixpt_floor(
-									avg_time_slots_per_mtp)),
-						26)));
+		dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
 
 		hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
 				hpo_dp_link_encoder,
@@ -3272,18 +3284,7 @@ enum dc_status dc_link_update_sst_payload(struct pipe_ctx *pipe_ctx, bool alloca
 	if (allocate) {
 		avg_time_slots_per_mtp = calculate_sst_avg_time_slots_per_mtp(stream, link);
 
-		DC_LOG_DP2("SST Update Payload: "
-				"slot.X: %d      "
-				"slot.Y: %d",
-				dc_fixpt_floor(
-					avg_time_slots_per_mtp),
-				dc_fixpt_ceil(
-					dc_fixpt_shl(
-						dc_fixpt_sub_int(
-							avg_time_slots_per_mtp,
-							dc_fixpt_floor(
-									avg_time_slots_per_mtp)),
-						26)));
+		dc_log_vcp_x_y(link, avg_time_slots_per_mtp);
 
 		hpo_dp_link_encoder->funcs->set_throttled_vcp_size(
 				hpo_dp_link_encoder,
-- 
2.25.1

