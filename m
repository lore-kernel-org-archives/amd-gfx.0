Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A50C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 08:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7E010E811;
	Wed, 19 Jan 2022 08:40:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D90FE10E817
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 08:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgEZpG6EA824F4LTV83FHbhiRY5zO2UA6ovrCJ2yuC32s0/e0XnjHOPWRPMEKYLfmtyN1M+4CNU1/l8y21SPINq52YnHY47Vzb0bOS75ApLxd2YS+qt3K8EIo+aqS+vHRY+ZPK8qtCk4Q/Ihr9Yu9teAnqQG5mszo+viXYk7Ow/kOiwHHaNU0j3ClmFjMUWWBm/obqyvyaNJD4u54mbGO2QhIiMPM/3CNzmb8xlIi6q8vM98BvX9ZnlHycEgCLzHMlTnbNc9+6H6FEonvPDCl56wS3IkZ1guprFb10eyQtJvTdjLFA/pSQ6FGbgN0xkELoQJlNhkGOPAGxLrWwmBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBEfBSVGKytjy2wiYXMgxEO//B2LYi4gFBAAvwoetDQ=;
 b=oAOMsH4Xd8XDll8zSDTOG+wyAs+cQ/Bqa4Z0mxDu1JNIcdH0k0mKpdDmssp4jxdR8CA9RPZhVXrbkvH8VZdnT/8HYGSH7SFiv696Li5GvA3s8Bo7JcQ0LO+gCGiBQeue+iNHtX3YohtTqf5Mn51lQVg8SGbwbzw8B3rpwiK7H+dEnsjHDXCHoXakUPDSn5JJwi39bv26ngAZzFj/uaBoUQWQhDABRqhRfWASJm8fCL8K3MWeiD1UAP31gmunaGQKggrUo1q1OO52WEG7LZ+QjT3L80VDGES9TbKKC32vYEmGM8vPg0TWdYenUvExpcM3mofP3/PN4pR6vVoMIUBmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBEfBSVGKytjy2wiYXMgxEO//B2LYi4gFBAAvwoetDQ=;
 b=MdT5vqdSJXr/I/28DxIqGl31xBDNgi4AA4Y0fR49Zj2wToi1kjAVVW3VUbAN3h3OsPnvRhkS5nHeOgT+JyCkyluazyeGz5HRojcLJ95cwgikv0QHYxm8nSgIGtGr5LO4JL+oj8VvkHpm0qzQkBEDjEGTHBW9Z7+nCQgkQ8Abpfc=
Received: from MWHPR17CA0082.namprd17.prod.outlook.com (2603:10b6:300:c2::20)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 08:25:27 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::53) by MWHPR17CA0082.outlook.office365.com
 (2603:10b6:300:c2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 08:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 08:25:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jan
 2022 02:25:25 -0600
Received: from wayne-Celadon-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Wed, 19 Jan 2022 02:25:21 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amd/display: add more link_hwss types and method to
 decide which one
Date: Wed, 19 Jan 2022 16:24:40 +0800
Message-ID: <20220119082443.1046810-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119082443.1046810-1-Wayne.Lin@amd.com>
References: <20220119082443.1046810-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cfe792b-4aa4-4143-8af1-08d9db253f4e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3970:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39708DBD9F9E8DBC5A9ADA02FC599@BY5PR12MB3970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILSXMfWYnR/QPT5jQnAcpYK8kDStasR9nFD9k3JFGl8f6oyi4jhM+Fajedj5BRDLTOdpqRBq2GsK8gbuVG+fz+nUbiL/5/ouL67vSIlz7G+g7wX4OFnZ7TwF+l0o34PKsEQC1DQdCeIF1gM50rAjvpx83Tj06sOLy1ApvsO9MqqxdtG0LSMUF0K3NQgcxF0c2oS4M9Eb4mb0ewaJrp5rAmsaeuXzLPulM4gpZK+QZ9CMPRVm3mpkTLz6ce8dCy5XO+abHkLUPya0AtiRqEJopR+i03lGKig3Mg5aDRO5OvxLLGHs68v/jPjjkVpq4wI4WiWL24OIbjf6yWpwdq2AOLffhn/NbrOt6i9Jc/z0s6TZUr08xCzqUik4NuRn5GPFx7eQHr2tM9LP/i6yfU5WXU2dsF599ouCey1/N8+UfmH21hWavdIqqWH1B/lp5DxN+zOjFgzXWzFwoFlYHxm3TwL9tvlxH7loPTtNKXLiEc2FHX+PwCBibxvW9xLBL2tmwpCiLtc1d2lMjSbwnLPTf6sI3ZetTGZTaHSaPj9AMFO8dze+CrjmDgA2mlYZTJqQasHexT3IWA8++ObDiZ3oXekH2bmzLdn6X/4z3C3IQEJF2x0b2iCTOCHiM4SQU/IMYoiQkTqo7tKImpTDAORPMJpjkB/++WKe1tyxxm/WaixE3rwNEp3PekKjPXgf3xwO7T1JljuLFFBlW8oW/MgZ6A3q6LZYOQEWof3eT2DlpnuU/yk0aTYMm3lEfPwoejuhT8U1xEF/aQyWvUaNvRzRWr5Vi99SXlSi3PGz821Mwa8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(36860700001)(86362001)(2906002)(70206006)(5660300002)(40460700001)(82310400004)(70586007)(6916009)(36756003)(186003)(26005)(508600001)(8936002)(426003)(2616005)(316002)(7696005)(4326008)(336012)(83380400001)(1076003)(47076005)(81166007)(6666004)(356005)(54906003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 08:25:27.0302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfe792b-4aa4-4143-8af1-08d9db253f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
as we add more link_hwss we are making a generic way to determine which type
of link_hwss we should use.
Later on we may think of introduce a link policy layer. it could be a thin layer
that decide the type of link_hwss we use. So instead of passing in link and link_res
we can just pass in link_policy and swtich based on link_policy->get_link_hwss_type.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 53 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  3 ++
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 93392c67c909..c65955eafaa2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -844,7 +844,16 @@ void setup_dp_hpo_stream(struct pipe_ctx *pipe_ctx, bool enable)
 	}
 }
 
-/******************************* dio_link_hwss ********************************/
+static void set_dummy_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
+		struct fixed31_32 throttled_vcp_size);
+
+/************************* below goes to dio_link_hwss ************************/
+static bool can_use_dio_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	return link->link_enc != NULL;
+}
+
 static void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -855,7 +864,17 @@ static void set_dio_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 				throttled_vcp_size);
 }
 
-/***************************** hpo_dp_link_hwss *******************************/
+static const struct dc_link_hwss dio_link_hwss = {
+	.set_throttled_vcp_size = set_dio_throttled_vcp_size,
+};
+
+/*********************** below goes to hpo_dp_link_hwss ***********************/
+static bool can_use_dp_hpo_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	return link_res->hpo_dp_link_enc != NULL;
+}
+
 static void set_dp_hpo_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -898,15 +917,33 @@ static const struct dc_link_hwss hpo_dp_link_hwss = {
 	 */
 	.set_hblank_min_symbol_width = set_dp_hpo_hblank_min_symbol_width,
 };
+/*********************** below goes to dpia_link_hwss *************************/
+static bool can_use_dpia_link_hwss(const struct dc_link *link,
+		const struct link_resource *link_res)
+{
+	return link->is_dig_mapping_flexible &&
+			link->dc->res_pool->funcs->link_encs_assign;
+}
 
-static const struct dc_link_hwss dio_link_hwss = {
-	.set_throttled_vcp_size = set_dio_throttled_vcp_size,
+static const struct dc_link_hwss dpia_link_hwss = {
+	.set_throttled_vcp_size = set_dummy_throttled_vcp_size,
+};
+
+/*********************** below goes to link_hwss ******************************/
+static void set_dummy_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
+		struct fixed31_32 throttled_vcp_size)
+{
+	return;
+}
+
+static const struct dc_link_hwss dummy_link_hwss = {
+	.set_throttled_vcp_size = set_dummy_throttled_vcp_size,
 };
 
 const struct dc_link_hwss *dc_link_hwss_get(const struct dc_link *link,
 		const struct link_resource *link_res)
 {
-	if (link_res->hpo_dp_link_enc)
+	if (can_use_dp_hpo_link_hwss(link, link_res))
 		/* TODO: some assumes that if decided link settings is 128b/132b
 		 * channel coding format hpo_dp_link_enc should be used.
 		 * Others believe that if hpo_dp_link_enc is available in link
@@ -925,8 +962,12 @@ const struct dc_link_hwss *dc_link_hwss_get(const struct dc_link *link,
 		 * do work for all functions
 		 */
 		return &hpo_dp_link_hwss;
-	else
+	else if (can_use_dpia_link_hwss(link, link_res))
+		return &dpia_link_hwss;
+	else if (can_use_dio_link_hwss(link, link_res))
 		return &dio_link_hwss;
+	else
+		return &dummy_link_hwss;
 }
 
 #undef DC_LOGGER
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index bd3b2b807431..8eff386da95e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -78,6 +78,9 @@ struct fixed31_32;
 struct pipe_ctx;
 
 struct dc_link_hwss {
+	/* you must define a dummy implementation and assign the function to
+	 * dummy_link_hwss if you don't want to check for NULL pointer
+	 */
 	void (*set_throttled_vcp_size)(struct pipe_ctx *pipe_ctx,
 			struct fixed31_32 throttled_vcp_size);
 
-- 
2.25.1

