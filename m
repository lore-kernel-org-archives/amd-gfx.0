Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1321C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 18:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D95810E84E;
	Tue, 11 Oct 2022 18:12:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E2A10E47C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 18:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPXGwoiTuVkT2ZEI4uKB/HU4V1Gyj3AV84j71aqv157asis4JNYmiOlhZDaGfdWGl7lGb3ERDTiXTuz8ZqXGWwSWakOdBjhWtXiIYF7eLvWBA2i5zQgMY7A7gNvR9PSxzWhmPiGER4dvMM3BFfk4g8eeMIDLxKkHJgVvaNwvHchF8gVzLDAiKw7PDaEfRqL0RT4XJprPrxtoU3P6LZCDNeJCyKQWbbjcH6n/2dUHkQDt6PrvB4bQACGvWCmGY4DPWg3s1NqPTukKGh9A9Sf1dwSPrWRaN0ExMVcGG41EXzdbq6abymm7VvqVG52NKvZdt+m88/IEwa+rbfjQjP6noQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbqYZWy76fC/P6azCU+Zopt22EExiHEqzFjueq/zh0s=;
 b=HHOzCpXCvRZecPLJHqb8JFSeaPbZO7F/frThuvsACjXqYtFhGsghNg7ao9cNy90zbZNpg6MpOmEuOD3UHFMEV4EauqMMZv4XDjLytre5PuV4K7ZUgq/gbmdGr7wx6NprFBAlc1du6wUZuXC0rKOgz5+Ni59z5p4prMYFvw2+E6Z7XwAhk/etvf3DUckllnEkVFVlfsddvhpwLrp997IUkenZ+dNqf9jsBfVxyx+Ed/P7GjsIuvdS+TfsgwM/QpKl8vI0ifVPq1kcMTSTpCj1nv+fyPeyhe91muN1xabds2EEYLNxLvuignLZW6ghDM3APHBLa8BVCf12Pno6GWdaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbqYZWy76fC/P6azCU+Zopt22EExiHEqzFjueq/zh0s=;
 b=MNR3I0GKjbwsy4ZQeUOkdxaz1KReTHieROdLMv96IUot8G/wXGlVE+2x2X/50q57JWhBSKuOHv5z3hvcKqpsimluCWAm0cj2C8i1GRRmOo4/djZ/uODtFbcAoYgjA0I4l14YC4yA117C/rxoYmbzjoq1bF9YFaJC8bBNMNZ5WeM=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 18:11:53 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::3a) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.20 via Frontend
 Transport; Tue, 11 Oct 2022 18:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 18:11:53 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 13:11:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/display: Enable new commit sequence only for
 DCN32x
Date: Tue, 11 Oct 2022 14:11:39 -0400
Message-ID: <20221011181140.94595-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
References: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db1f90b-d982-4428-f4ca-08daabb4134a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIlW7k5CB6B2ycajIxHWky0QbhbnXsROI9mH7iVVynQj3QOLbP/AmCAl0P/XBdo/ljyOY1Sei/llkENqazKbEgi0emnrRaoauoLKpEq+kzfIhgjlUYNyRdcQwneUt8Yu/Bk/vnLPm3z1FOeh1JW2KQW0nMWtS0hLeHAQ2Dx47UmcoXj6qoeHgwGzhnsLBR1FfdwCRkFtdDjiP6tkvUkUL/jEfPPJh0q0gZBXIfXk8c94s7W/BVLGLV+QcN1DkR5/g6tov7cnyjRvBcqxcTTuagodx1R7jnRFTMwHQbJGE9KhdBQDaR/2zjpEjzs8DFxvBdT/57jOtjbX/gXbqZN7KIhdy9PW746n/jFQWJkrYI34pMHq7oR01EnA0BAxACZdHELJT7Q3WdEJCI0n6ujhuF99LdZht+ceKf8qBeKCJ6ysZjaP39A4HF0EJF2smMnwd5fwKfO/DlJtCvt4ERSiHEAyr7sqO8wbLNYmArQQ7z7KJtLkn+uQkGCws3aLlPPTGPC8ltvxVv/eYzA1LQ4VNF8H92bTtxs0t/FurgZVOnssIBYRwalBfYU/nkMUUaC15FdnfPIlT6BpA1CY5TilPNiRgMxrq/3Oa5hY6t/RjiHAjeqGQr6mImF5mKH6buSWliucsHuCxHgbGh4NvwwHg2oou0XEmJrRdMuHMaoGrsyK2amRxxetH8CUXlFM23fyuzZgPOJONWT/J/InxiRHRFsse+E9d4TDUPG4UWoDRy919CYeRqfPJcLT0Fc8DiCkNqVSnti154n25XG86/UtEWHZQOMR/LpMxWJqyRWGGlBqZ/NVhCgpuBbrcCT6hAMi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(26005)(40460700003)(6916009)(54906003)(82740400003)(40480700001)(81166007)(356005)(86362001)(336012)(36860700001)(36756003)(4326008)(1076003)(47076005)(7696005)(2616005)(426003)(83380400001)(8936002)(8676002)(16526019)(316002)(70206006)(5660300002)(82310400005)(6666004)(70586007)(186003)(2906002)(478600001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 18:11:53.2176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db1f90b-d982-4428-f4ca-08daabb4134a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change commit sequence might impact multiple ASICs; for this reason, it
is better to run it only on DCN32x for the first set of validation.
After we get more confident about this change, we should expand it to
all ASICs.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ad3aafb73cba..21d20900cfe3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1913,6 +1913,13 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 	enum dc_status result = DC_ERROR_UNEXPECTED;
 	int i;
 
+	/* TODO: Enable the new commit sequence for all ASICs */
+	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_0 ||
+	    dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1) {
+		result = dc_commit_streams(dc, context->streams, context->stream_count);
+		return result == DC_OK;
+	}
+
 	if (!context_changed(dc, context))
 		return DC_OK;
 
@@ -3898,6 +3905,15 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	struct dc_context *dc_ctx = dc->ctx;
 	int i, j;
 
+	/* TODO: Enable the new commit sequence for all ASICs */
+	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_0 ||
+	    dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1) {
+		dc_update_planes_and_stream(dc, srf_updates,
+					    surface_count, stream,
+					    stream_update);
+		return;
+	}
+
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
 
-- 
2.35.1

