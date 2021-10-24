Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75090C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423E76052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 423E76052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B136E0F5;
	Sun, 24 Oct 2021 13:32:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FE46E106
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMJlt4wCdw7Zgcgp/YcDiDC280GzyIN+hmgoV7iBBi5XQY3vGM0eaEw2Dqx4wvkyVOoUObhiYBR/qTe6BYnmJ/dsQB+ec21VUToigSxrd6nH09r8Bw40YkfbkDw4i0KuulEJ/hdnEX0s+j+wQHwFsIO05o9OKPrzVf2COiWH5IC+K2632Z11kLtXEsXI1FBcb7LzKnIrv1JhzVORnItwievaACBxzS9OewzeTtipk3fKQ4G+Z7iVYUSJJxlix0nyheT4ayEM1zlqJC4mHuU/IsL9DNhnE1QWpoo9vizXUNr3IlicP9RSj+/upfOH1HlCwQm+OseWlU/oJQ/X73KzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORbCYGFUBfThGPqiiyS6JomzqC1KGTgwbcj+1lqsM4c=;
 b=Dqr6ff2cSjescOYr8SUdYJD2Hp0zHVyOmb3ncsk0r1eC3hnWe2kKBjyP+gYS+dRU6INRxhUoRjuXR5lVnziq7e2q3sp3dwUzYwecknfdvk4r/kj3nszcBmImVqlHjpqdY3nsX//2KUS9xzzjDdT01yeH1Uhn8FZPDyzJHxo0DRtjzyVRM5inYOObA8QlCBLuATSUHE0jXu0S7kmWn/MnOcamgluzFpfOz3E1SxTcg7O8Nrn278P/958rQz0z52MNDvKODUoGd+41SJfTR6KixKhF+wutkOOju9felkuu/b6oT8Srr1E5YtfZs/0U00e/OT6g1FqmTg01eQIT29hp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORbCYGFUBfThGPqiiyS6JomzqC1KGTgwbcj+1lqsM4c=;
 b=XRK2ZJCYpbPtqpzXz22T24fRFoDFd/x8t/u4+UqewarMCIQCwkMx/4BlCPMW2Esi1NzAp+Ylh3JxIv/YK/aKU+OLiUlPAz3LhtdNmzkaGCC64xHORrn8Z7S96RHYY/t0WeKpt2u3dHS9P3lkL7v6jWb5//dcYrTMwnP/vP4MpIk=
Received: from MWHPR1401CA0020.namprd14.prod.outlook.com
 (2603:10b6:301:4b::30) by DM6PR12MB4266.namprd12.prod.outlook.com
 (2603:10b6:5:21a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:29 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::5e) by MWHPR1401CA0020.outlook.office365.com
 (2603:10b6:301:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:26 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, 
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 11/33] drm/amd/display: restyle dcn31 resource header inline
 with other asics
Date: Sun, 24 Oct 2021 09:31:19 -0400
Message-ID: <20211024133141.239861-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23edf7ce-e96f-4466-8694-08d996f2b7fd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42668723216AE6DE2C9E7CA398829@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4sdEjUciiyEeOhaYl67Y6RJUpgm1vtHJo+KyALPxmo6vxBCeTWCLQG9ArS7CAab0mStJNeCvnXT+Y+nrLBMi0ug5aP6q/6qc/7g6BmwNuc/kjEjYLuEPI6gcD3MgS0QtVuFT5ZDWNJu0SndeDX+jOCU+OdQihNIKQ6Tjk3d/iY9HwR2IYJTOBw5ZVgfqOBhS+b8PXWrcP9Kty78ttsSTNZQ19KzfTHc/xmwnkSYSyyVhWEbTs3nMm2behDRFSugPwvdnNDP/vo+yofO9U5GIKNNYZ3KdBzBAbq1vRs095lxf+0/B7yBl0UgsUnT77DyS1GaysRqFEsssZ7ymh4H/ivFV04u7HRND1n4E42j5y9EhXG+Wc1b0O2qmp+aZKdsxSgyou86P51uHmzMNqlEMTpIdEvpfr8Q6MhNRxOkRxpoBRiTJ1UGF3MKgi9F9T03qFr0EE4c0T32B6WCelY5LdZzoRVArAl299n9AUA/JXogl+Q+mhISfDylSHc7r7Zgc0E78NDFY4PON11VutDz4nWd+LvDCiuRQnh9tABI1k0EsrRXvuM7DvJbAlk7CmZL1UFvGnkhHRC1Y0YusJVbCW5E6W0CyRgyln4wYgcOAf/uZIfI7IfrPzLqOf5GjGbq6b7D5teF9Yxe+G8B3qy8HSKC2jhfDuwiHkz3hybm5U7gTRH0F86eAwMDmc69rSrmIYyYL6KyUOB6ew1aA8g6PZv4YXiac14ZI0Os3cXqeVU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(8676002)(426003)(186003)(1076003)(2616005)(47076005)(508600001)(36756003)(86362001)(6916009)(54906003)(316002)(36860700001)(16526019)(26005)(82310400003)(81166007)(83380400001)(8936002)(336012)(70206006)(70586007)(4326008)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:26.1174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23edf7ce-e96f-4466-8694-08d996f2b7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Style change for better consistency across codebase

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c |  4 ++--
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index abbfb5aeff2a..2de731e3e639 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1828,7 +1828,7 @@ static int dcn31_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-static void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
+void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 {
 	if (dc->clk_mgr->bw_params->wm_table.entries[WM_A].valid) {
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].pstate_latency_us;
@@ -1972,7 +1972,7 @@ static void dcn31_calculate_wm_and_dlg_fp(
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 }
 
-static void dcn31_calculate_wm_and_dlg(
+void dcn31_calculate_wm_and_dlg(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
index 93571c976996..416fe7a721d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.h
@@ -35,6 +35,16 @@ struct dcn31_resource_pool {
 	struct resource_pool base;
 };
 
+bool dcn31_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
+		bool fast_validate);
+void dcn31_calculate_wm_and_dlg(
+		struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel);
+void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
+
 struct resource_pool *dcn31_create_resource_pool(
 		const struct dc_init_data *init_data,
 		struct dc *dc);
-- 
2.25.1

