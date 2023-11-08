Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E795C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7FB10E828;
	Wed,  8 Nov 2023 19:08:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CDA10E823
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+hJC5f8r6p4MA+d5M4ziOtD8IoIsaZff0LjM6I9c6VfQp4AObamBmLkStyiPmnigFP4YSEPpVnL/bXNyV10fKCUw/6VC/eReELd7fhbgmz6Z8BIuG4iL7Gv9FLKD43b52PVFfCP4ZujVW9QD23lqSSCV9dAVLDkPo2z9jdwIcgGChQZPLOEruRyby2bjkIe8l1wvpD10FpQbZqG6Fn/3jjLA049Kst/GYfAj9Ys9sTdXEaM1AKTqd1Idu4wdafxz2b55HWiSTwkyYb+LeWFblRsz5mChq0HQIDFLFrUzoAneEcLhJ41UF5Xvy9NrwySjQAK95njFWfgsh3hluo53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDBdHSqlCsPTDIVGUlmwEGVHUb8gLkVjlBYtbxBGv0k=;
 b=GQifjqwzJiJN9HpyTnX+yaG8ZPRW66pgmHcwF0mkM8bzavm1Inf/tABA76rHr7Bg+/U/ZLjOyNKlEtk3rlvEVh0b4aLIiJyT51a0hTNhEZLllVnEvgFpO04ex+iEPASkyO4XmEwa4d5tjPKUJaUbttZitwQYoAjWPUxpRlZMhfoUaarPhFtRo/cLn3dHM/MxRNGojD9c8GEhUqLPGPQcOX+kgQJ/G3HyicbLCuXAoSNq9S9z3JV/MVYiSG/3mWYpOAnFg0TVUHJc8DSbbm4xY7ZCsj8bocEz0ZHXXYi2ZH7NT/r2O8fhXJgM/PI4gRzXBsiQMaQ3Bz2qHfbFsVFSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDBdHSqlCsPTDIVGUlmwEGVHUb8gLkVjlBYtbxBGv0k=;
 b=LOJN5tikuj+Ykl47ilQgLiMhIEKbxH4zt4dtrV3ZXT20+fXopVa1QGIaNxulvZ9aikG1V1Vnscsp4TquViYXSrXCqbgtSRKNz6K25MC7foDhU5BwZ9E6ljE2Xdu7haN7g/5CIPcS4DAMyU621OUJcvV878c94ynccQHBmlQvwMs=
Received: from DM5PR08CA0034.namprd08.prod.outlook.com (2603:10b6:4:60::23) by
 IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:07:11 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::26) by DM5PR08CA0034.outlook.office365.com
 (2603:10b6:4:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:07:11 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:07:08 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/20] drm/amd/display: Prefer currently used OTG master when
 acquiring free pipe
Date: Wed, 8 Nov 2023 11:44:25 -0700
Message-ID: <20231108185501.45359-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbff0f1-d2aa-44ee-f116-08dbe08de95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58/j0DuDQoyOUDwGZOKYAbPlN7qaU2ZP81YonWOGpsWa5iNcZA+qRYeNHhK8h8hDsDP/0e+3fXVC4kdq+bs/QW8NT8ALud2OKeSF5P2NySAl8LpEEIUaIdcfKE4l+BxrqtFfXmec6signZvgt38Pw32tIKQplTxh4bq9NH9am30+yCOnzAAE9WvQG47nWojBcAq2U5HCGXRvMndHyjFWzsOqQBknaicUJrjmPtBJ/wm48XneVwExQwWpJnVWtXvi8Hhl1ZuLIwpr2Mv1EB0TMa8eu3giPvjFZwuaoleFtCBQKxhuOiZ/ihfTpdth6q1+w6rlh/rvqQdKtPz7ftAN9pj04m8g9iy+qBS9fiADseXlDXNypBfSHVEfyzxGqMPy/OCehOg5nN9+ZrP//mkYk28bqxgeZTFsal+lJ4mNCn0hA48k0+cwOf+66cyN1/fXiRLfqVkFPQVmdFYv4DdhSQIkZrGdswYGs3l3T6mzobs/ndFlFj03XebvWGtrY9eMEXj1v3Zn1oWe2u3w6vJUHbJaIETuVPksQpVNXRBaPu+NlX0L+YYUnZoWTZl8DryOMZCaV0yrilab/Fz/lG0IblPyJcah206vbwe5iHWfRk4xWresSo+uuadhP2MIIeG469rx/7C5c9FfdqNcEeInth9MHF8DZhGBZMEVviHTCdXmt5+KGT8w0Izij1vysHP32bO7jEGlhgtsXs1kRr6I1YTaEf89leQns57Ih7fLWkiyM6SVbDi2hK5you/JA93iYSKxVhR3K0CTo7b+HWr4/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(46966006)(36840700001)(40470700004)(4326008)(83380400001)(1076003)(70206006)(70586007)(26005)(2616005)(336012)(426003)(478600001)(16526019)(40480700001)(8676002)(8936002)(6916009)(316002)(54906003)(47076005)(6666004)(44832011)(7696005)(36860700001)(40460700003)(41300700001)(86362001)(82740400003)(81166007)(5660300002)(356005)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:07:11.2403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbff0f1-d2aa-44ee-f116-08dbe08de95b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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
Cc: stylon.wang@amd.com, Dillon
 Varone <dillon.varone@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[WHY & HOW]
When acquiring an OTG master pipe we should prefer currently enabled OTG
master pipes first. If there are no free pipes used as current OTG
master pipe then we will try to acquire a currently unused free pipe as
new OTG master instead of tearing down current secondary pipes from ODM
or MPC combine.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 37 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 12 ++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 49f8c90f0d2b..42a927710743 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1764,6 +1764,29 @@ int recource_find_free_pipe_not_used_in_cur_res_ctx(
 	return free_pipe_idx;
 }
 
+int recource_find_free_pipe_used_as_otg_master_in_cur_res_ctx(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool)
+{
+	int free_pipe_idx = FREE_PIPE_INDEX_NOT_FOUND;
+	const struct pipe_ctx *new_pipe, *cur_pipe;
+	int i;
+
+	for (i = 0; i < pool->pipe_count; i++) {
+		cur_pipe = &cur_res_ctx->pipe_ctx[i];
+		new_pipe = &new_res_ctx->pipe_ctx[i];
+
+		if (resource_is_pipe_type(cur_pipe, OTG_MASTER) &&
+				resource_is_pipe_type(new_pipe, FREE_PIPE)) {
+			free_pipe_idx = i;
+			break;
+		}
+	}
+
+	return free_pipe_idx;
+}
+
 int resource_find_free_pipe_used_as_cur_sec_dpp_in_mpcc_combine(
 		const struct resource_context *cur_res_ctx,
 		struct resource_context *new_res_ctx,
@@ -3600,8 +3623,20 @@ static bool acquire_otg_master_pipe_for_stream(
 	int pipe_idx;
 	struct pipe_ctx *pipe_ctx = NULL;
 
-	pipe_idx = recource_find_free_pipe_not_used_in_cur_res_ctx(
+	/*
+	 * Upper level code is responsible to optimize unnecessary addition and
+	 * removal for unchanged streams. So unchanged stream will keep the same
+	 * OTG master instance allocated. When current stream is removed and a
+	 * new stream is added, we want to reuse the OTG instance made available
+	 * by the removed stream first. If not found, we try to avoid of using
+	 * any free pipes already used in current context as this could tear
+	 * down exiting ODM/MPC/MPO configuration unnecessarily.
+	 */
+	pipe_idx = recource_find_free_pipe_used_as_otg_master_in_cur_res_ctx(
 			&cur_ctx->res_ctx, &new_ctx->res_ctx, pool);
+	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+		pipe_idx = recource_find_free_pipe_not_used_in_cur_res_ctx(
+				&cur_ctx->res_ctx, &new_ctx->res_ctx, pool);
 	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
 		pipe_idx = resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
 	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 06ca8bfb91e7..0458d2d749f4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -500,6 +500,18 @@ int recource_find_free_pipe_not_used_in_cur_res_ctx(
 		struct resource_context *new_res_ctx,
 		const struct resource_pool *pool);
 
+/*
+ * Look for a free pipe in new resource context that is used in current resource
+ * context as an OTG master pipe.
+ *
+ * return - FREE_PIPE_INDEX_NOT_FOUND if free pipe is not found, otherwise
+ * pipe idx of the free pipe
+ */
+int recource_find_free_pipe_used_as_otg_master_in_cur_res_ctx(
+		const struct resource_context *cur_res_ctx,
+		struct resource_context *new_res_ctx,
+		const struct resource_pool *pool);
+
 /*
  * Look for a free pipe in new resource context that is used as a secondary DPP
  * pipe in any MPCC combine in current resource context.
-- 
2.42.0

