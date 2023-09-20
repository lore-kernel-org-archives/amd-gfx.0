Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0000ACE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A63410E436;
	Wed, 20 Sep 2023 03:21:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F43E10E436
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUwuKyNvBs5ycKodYJ1aY0GoLUK0WpRUIq1M8WxXyUbdIvMX+98sIAIzRQHBmdV/tx8uxVX0HpX6ecEyTmmeWn0/ZmvMfrerDsjV+l99j3nH4/YlrdByJeyBGD9JTTdQF9XgotWzJo6Ots4iY81vkNV6plQ8WgW7NkVqZDgMt7OrScqyNwv6XSBZSHFZGuvDwatA2O53CX4HWZYE28UhAd0KLoVLgyZcoqlRdDw6xVSGgp4HCSKZcYtW47cKYXCwu5X8GUyieu8USfoRKf05KYpdnpMTKeriawmkT7GnJidSI6qC1UZh6SvbjtMT0QpHOX7xZoc2yeY0U+B2pkYG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr944rQYP9H6VjEf4hQMJwMiPVFOcX+SfaDkGSzmLfs=;
 b=jAh44seOCtQl9WkDSkrImXk0CtSfKryytnId999Uh0pU1xKKPv16wDv55V3QFaRy0SZGrba6cjpbGA0RaxVgi6FFUDkFKYe6Uc9eAOI0Xq5o+JzfuWQCT7B3cDNFEnvjlFZuKuxMTHJ0/EKXm5VCsMiS9OtgQaO003SfmahNxa7aazrl4py+6aELqPkrCfvjfG0wbRr1sOMWEjNA3ctppoRY84zUAqph1iYJcrrPUx52jdxwkWJ/HepoLuUpPE3wEltvPGi2BH53qpwkEVu6XcWh6bJkw0PaS9FTh3TkjzXE7ZRBT1FIItRq0rccD2yqjSs6phuxBW0DkqbX8GTXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr944rQYP9H6VjEf4hQMJwMiPVFOcX+SfaDkGSzmLfs=;
 b=xlFNNQnCc3pxQAojNM9CaLVKmnlk/QdtM6g8d5eyu8kOGVVQXM8l1SMcWx07aa0fiFJJBVN52yEaKbcOu8SOwewLoy48PSgGH/TjN1Ujbx/OvV9zFGDnIYan/rtWj2yY2B7chUtib5pKud21qDiYaEezG7dHRP17rZWQKkhsm2k=
Received: from PH8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:2cf::11)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 03:21:38 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::4) by PH8PR07CA0031.outlook.office365.com
 (2603:10b6:510:2cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:21:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:21:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:21:37 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:21:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/19] drm/amd/display: add primary pipe check when building
 slice table for dcn3x
Date: Wed, 20 Sep 2023 11:16:22 +0800
Message-ID: <20230920031624.3129206-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: a01a582e-213e-44e0-5dc4-08dbb988b368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COJHzRF/WuS9MYgnbPPTW3/wOLp4dwBivb3oZOvjhv8X8akduoduiOTa3Gy5LCmi1PjOQGDtGsvAfMOTCxtI7f4zthdGgVSwqpRtrqYYSdEHP7p8yibj+0E3MzkPl/LY0hiwb2PTNGOZG+vDMZ1wq01iZiu4FCwCdQi84fGUhuNV72HSQ54K/uruOuuV5YkC9nXlJKXJdFOdZ6zVtM6mB3e/R/ShFeF0UTvdcRgNDON8VsaYM/1ffkgnKaPnWPPUHOMLm4SXrBWzbN2LiBkZQUEBKgca/aYpUTw3DXrdOiuEsdSrEjFbyggOEALy2KXv2n6kplo5w6cObxT5MuyUPcTxccYYPsvvPFd0z/FI08zkYmLDQAK7rtiyRfrhFZdX00p++xgLQ82Z95eFj+jnfXLmsXV5MFdWSuX/kvx9k4m4DS3RlGfwj/8iDbOKuOPShjGGFc2Ot2Q3r9qVDIMHcOhT2BAag4oaFsoql3vkTLvjFCnLdi8YY08KeYQkoITBRFV1COOk2UDkAXybNWNvKXEGIXrWjOrOnmgn+eJIXZAsO9XMtcsLa6iYBFYz8O+iiP9f6R3AnZBLFeEn8pRn8EtL9mXnniGBb0lTN7VteMj+qzS1Ly8NnMC4PxXrBKvKcJbBRvHO2XAUSuPIQeakZNrlSJtf266932P8E6l+R7BWT4jmPJGp98l9k69VrHwP5PS9cxdyCSq3/moVz0gL/vMVMir35PUK4kOAsE7IRaAwRpzVPEkrvcOs+C/hNVTZRhZ85fcmB6ojGiGDZY+dJa2zrnVVo3LNOPJEHW+qovQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(54906003)(41300700001)(83380400001)(40480700001)(5660300002)(8936002)(6666004)(2906002)(316002)(8676002)(70586007)(70206006)(4326008)(6916009)(7696005)(26005)(1076003)(2616005)(40460700003)(336012)(426003)(36860700001)(47076005)(36756003)(356005)(81166007)(82740400003)(86362001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:21:37.9240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01a582e-213e-44e0-5dc4-08dbb988b368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There is a corner use case where the same plane pointer can be added into
dc state twice. In addition to plane state pointer check we also need to match
primary pipe before identifying the same plane.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 062633af77a0..7179c2b3b1b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1086,6 +1086,7 @@ struct pipe_slice_table {
 	int odm_combine_count;
 
 	struct {
+		struct pipe_ctx *pri_pipe;
 		struct dc_plane_state *plane;
 		int slice_count;
 	} mpc_combines[MAX_SURFACES];
@@ -1113,12 +1114,14 @@ static void update_slice_table_for_stream(struct pipe_slice_table *table,
 }
 
 static void update_slice_table_for_plane(struct pipe_slice_table *table,
-		struct dc_plane_state *plane, int diff)
+		struct pipe_ctx *dpp_pipe, struct dc_plane_state *plane, int diff)
 {
 	int i;
+	struct pipe_ctx *pri_dpp_pipe = resource_get_primary_dpp_pipe(dpp_pipe);
 
 	for (i = 0; i < table->mpc_combine_count; i++) {
-		if (table->mpc_combines[i].plane == plane) {
+		if (table->mpc_combines[i].plane == plane &&
+				table->mpc_combines[i].pri_pipe == pri_dpp_pipe) {
 			table->mpc_combines[i].slice_count += diff;
 			break;
 		}
@@ -1127,6 +1130,7 @@ static void update_slice_table_for_plane(struct pipe_slice_table *table,
 	if (i == table->mpc_combine_count) {
 		table->mpc_combine_count++;
 		table->mpc_combines[i].plane = plane;
+		table->mpc_combines[i].pri_pipe = pri_dpp_pipe;
 		table->mpc_combines[i].slice_count = diff;
 	}
 }
@@ -1154,7 +1158,7 @@ static void init_pipe_slice_table_from_context(
 				&context->res_ctx, dpp_pipes);
 		for (j = 0; j < count; j++)
 			if (dpp_pipes[j]->plane_state)
-				update_slice_table_for_plane(table,
+				update_slice_table_for_plane(table, dpp_pipes[j],
 						dpp_pipes[j]->plane_state, 1);
 	}
 }
@@ -1205,7 +1209,7 @@ static bool update_pipe_slice_table_with_split_flags(
 				/* merging DPP pipe of the first ODM slice means
 				 * reducing MPC slice count by 1
 				 */
-				update_slice_table_for_plane(table, pipe->plane_state, -1);
+				update_slice_table_for_plane(table, pipe, pipe->plane_state, -1);
 			updated = true;
 		}
 
@@ -1216,8 +1220,8 @@ static bool update_pipe_slice_table_with_split_flags(
 				update_slice_table_for_stream(
 						table, pipe->stream, split[i] - 1);
 			else if (!odm && resource_is_pipe_type(pipe, DPP_PIPE))
-				update_slice_table_for_plane(
-						table, pipe->plane_state, split[i] - 1);
+				update_slice_table_for_plane(table, pipe,
+						pipe->plane_state, split[i] - 1);
 			updated = true;
 		}
 	}
-- 
2.37.3

