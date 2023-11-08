Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F10C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E62F10E823;
	Wed,  8 Nov 2023 19:08:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A5A10E823
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgD2sTH2uIogOemQKgdVLk3tJI8zzU+rRZEBkPA3OdbIaZnX63qMe9aubJwL6o8MhGQqInB67PuTTt+tVkih5feIkP9bo3wfoyJbY5Fp4uUdSoJRm3qj0VSXjlF2XWsQ1t9QLUTFD7rABKm0wbz/Idf50V2BY+EmW7YaXlNPvRn3MySc5TsQIx83wyuRdKAB4qHuOsICeliz2crikc4yDzk7hCFWNy/Ut750uf0NsD2yKvX9dewpNw5c4VMWqZ+s/6c3MXB/RDgHYAk39RtmRuY2xWW4V39pAaWi+zF49sjsowRDwlbP8baUfvJM2UaWhU/jv+aLZP7nmbZ8PAEJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7utEqduD7cA5XQzCaQwAcz2Lf/6xxAjTIG5FVCYcN+0=;
 b=W17h1nSDeSVqgLNMfK7+F1yJwIUJv1gXTiBuTRH4qG+Z4RAfSidEYLqBYdo4Qyj6XseXQL3TaSC6jVK1iOHriI0GIGhmZ+tES4tGI6PM3tNNZX0KtnB/TFda7Blx3HWQKZT7ZTmnD3lYwxRXRr0g1ps+iiFpiTLgJE+3dyTiQIdV5b0SM89is4OhVWl45YbR0+cnfRN3Ybx981zie6gl5DisGRqC0Ks6JXXd7nwQXc5UUYXB84prNh4j/ENt4zy8U7eqwvVAETYvypDe7pSLvm0K06bgICC10DkdcA1+Aj57WdPkOJ1EawxzVnspVBAAraU9BMITnvadD91mm5ZVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7utEqduD7cA5XQzCaQwAcz2Lf/6xxAjTIG5FVCYcN+0=;
 b=CHSsTOVLJv1aVeEuGLesNvusVcImGos3wZsO1DhUe5eRn9ptpvMI0X1/EVhz2gHLXn5wIJQu+7VIP3N0n0vCcmsA87ugpnClHekMfTuczRqU6rjEtTRSeJ+L4jGSP05DvHLwIdQKn+IuHyys49PVqmbzHgoIlf7/+r5W7qpASoQ=
Received: from CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::7)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:06:58 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::75) by CH0P223CA0019.outlook.office365.com
 (2603:10b6:610:116::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:06:57 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:06:26 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/20] drm/amd/display: Try to acquire a free OTG master not
 used in cur ctx first
Date: Wed, 8 Nov 2023 11:44:24 -0700
Message-ID: <20231108185501.45359-10-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|BN9PR12MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 438b7cd6-c5e3-4705-3fa9-08dbe08de14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnWrde6ye+GCABZrdvLBGE7JD3NqTLb8IS3TgiQo7KhQItXjGBbx2r38RSjlu04ygxPl81aCiwkTC84Q9//IqW3nJeDONVMgRLa+KXpFFUvpK8B2YS4MwgYZaGZvfKHXdvvNZYYSYfvdP69FspIB2uRd/RFCgziJdenDzvLB50TNPenDWIuaLUqyZlpryeEeic6LcAlWPw4AIPkJ5jRP0sm3G+2Tlm7Y25lFO62bM6WDhJqmwCzWa5q8Cb1bnCRghpME+SAXcCoJnJ0W0V2yZruIJDQ8CepdxvxcIi0E3hc8SahDiGA1wrNr7Ndnoj0NcokJvl0frC2vcI8R4L68hUKUZxcXx0bOIIqkKwMA5iTqCZdkgVvPfn3A8AJxP8osZa823eRmcskRrrtxTGJ9QSdy7PNVJ5WJFxU3aJbvAidIvL6WX4AxPNag6b7Zgt8dMDIZbxT1kS8drqoGteheCCms5sC8Zk5csBP0jKhYc5eRsrYMqCYoGyO9U2X4oemMZwDx9AVMPLWZcuLmJbPfRat2gGLc84S/DbFbenZNX9FLonW8oQ/SasiRmjPXEn1OpUyFq/AvsqME8dDVyFEQ7KQxT3/nYRd0GrEsY44BmOojxYIBPwdBPApu1N6RfSCYsoH0Ly/uV/2lLxMVVI/qd/e6N4QZtHU9MkSTBNUdSd+Ar6W5dUIvrL0cm+U+4GlIsX29RGd8OlA4i76RkvYacPeX8HcKu9D5AEo4TAWzLZsMqXz5QZNW/Ebu1JbH+oeKPWlrR9i2D1KPQFuuq93GhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(7696005)(478600001)(2616005)(44832011)(36860700001)(36756003)(82740400003)(356005)(81166007)(86362001)(6916009)(41300700001)(1076003)(70586007)(5660300002)(83380400001)(2906002)(426003)(336012)(47076005)(26005)(16526019)(70206006)(316002)(54906003)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:06:57.7066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438b7cd6-c5e3-4705-3fa9-08dbe08de14d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[WHY & HOW]
The current otg master pipe allocation logic is not optimized based
current resource context. We should try to acquire a free OTG master not
used in cur cts first to avoid unnecessary pipe switch from current
state.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 6159d819c5c5..49f8c90f0d2b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3586,6 +3586,7 @@ static void mark_seamless_boot_stream(
  *       |________|_______________|___________|_____________|
  */
 static bool acquire_otg_master_pipe_for_stream(
+		const struct dc_state *cur_ctx,
 		struct dc_state *new_ctx,
 		const struct resource_pool *pool,
 		struct dc_stream_state *stream)
@@ -3599,7 +3600,10 @@ static bool acquire_otg_master_pipe_for_stream(
 	int pipe_idx;
 	struct pipe_ctx *pipe_ctx = NULL;
 
-	pipe_idx = resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
+	pipe_idx = recource_find_free_pipe_not_used_in_cur_res_ctx(
+			&cur_ctx->res_ctx, &new_ctx->res_ctx, pool);
+	if (pipe_idx == FREE_PIPE_INDEX_NOT_FOUND)
+		pipe_idx = resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
 	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND) {
 		pipe_ctx = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
 		memset(pipe_ctx, 0, sizeof(*pipe_ctx));
@@ -3659,7 +3663,7 @@ enum dc_status resource_map_pool_resources(
 
 	if (!acquired)
 		/* acquire new resources */
-		acquired = acquire_otg_master_pipe_for_stream(
+		acquired = acquire_otg_master_pipe_for_stream(dc->current_state,
 				context, pool, stream);
 
 	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
-- 
2.42.0

