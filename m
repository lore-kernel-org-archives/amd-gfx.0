Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254ABC27C50
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0476A10E5A6;
	Fri, 31 May 2024 16:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uFZnvucB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752FB10E6F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqyl+QYkM0y55qpcUkgHHjhPcjyIJ6bs6/s+fQny3JXxAdif52eBqmWm0Tcc23kWQ9JyokGzSiXr1fprhOE30KFuPqaekIbTE/y2kJnoTm7UTUclgg0lNe/FbroU6T4EK9YD9PBBscY8Wzay5tP54c/+iCX+D0Qwv4YAv3MnDsYA9ej0AHlEOTehfOTEOlmpXmovZVwWZSwiUBo0GJA9XZaUCKjT3h6QQiNXf1IfDi+CQyD5bneDOK/mwKPSB26CC0SP1tUSO7KpY+Ldlyr9s4iDvsnMPkjs44MeRJYlQU5ClCU1+8kXL4cFo0e0BeAaWX9349i4TRjNjZ9GsgWsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pmhd2XBHww32Qy2cAQ5aT7y874x+ZH5O+JnrP9LQIY=;
 b=R5G/jWcs68WtQIksdoiDFGLk8BXqduJ3vmpPPXWW2k02UulrU9k7+sbo1BMFbfMAurVBHmy1p4Fcq44C+smxO22RRR8UEAFtwDHjNq6rK3jJ0kdPMzZb6SNo7hE9RLFJjhAfaOBv2aBMTXA6Yjx9kt9m9/aD3pvVpoRlLMxIBKXCIxikcPAoOkRkv2RI+qwn46RzeDL/cjHACTcwV8JS7eLasxqUGQYVEpxnKVLwSN1c6Ud2jav4eEtG2dnmu8SfqmjiVOV7dwwP/VKPE2j5cy8FcDs2dQUywGLxXXxavyTOFAWt3Uq6r9uI4WdG6L/DdiPbsJ3lRSCSep02LUrJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pmhd2XBHww32Qy2cAQ5aT7y874x+ZH5O+JnrP9LQIY=;
 b=uFZnvucBjFnxBy/BcWfcFHefa13cFknJVqazxURkfWDr4DJpeURouZY3QEn3CxPofS5PxkkZa6hWdrwxQkR7CXAjvoH3FuTsiNMLpqUmyozzOGLGa+IFsm/hZsUM+LOlPbh4xYGQ8d3OYdKTkc9VpDqT3UT82RhWcDBy/2kSM2Y=
Received: from PH7PR10CA0019.namprd10.prod.outlook.com (2603:10b6:510:23d::27)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Fri, 31 May
 2024 16:52:38 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::df) by PH7PR10CA0019.outlook.office365.com
 (2603:10b6:510:23d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Fri, 31 May 2024 16:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:34 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:29 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Susanto <nicholas.susanto@amd.com>, Jun Lei
 <jun.lei@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 08/32] drm/amd/display: Fix DML2 logic to set clk state to min
Date: Fri, 31 May 2024 12:51:21 -0400
Message-ID: <20240531165145.1874966-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: faaf512a-ebe5-457a-cdef-08dc819211c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b4uDkIHKSHzQlSXgGsRPmXTrgzpLz80q8VnjVA5j/2a8mwczUX6FzH54nb2g?=
 =?us-ascii?Q?BuSJk+FNlbo2rp+UVsZctrSzTtPw+wvVvRb+T/u9Vh9d+BIlmmTks4rZIYED?=
 =?us-ascii?Q?OYBrYtzcMSV7u/7EC0tZ6c6S7GxrcQArLbjALmhgiAGwlPRRM10H9aszSj/q?=
 =?us-ascii?Q?M3hB3S2JRoO2U9yHkocwzz4DoByLvfy910Md8376nNieJnaUOVnW1qGJKQDD?=
 =?us-ascii?Q?0aYBU5/+2KKaKnIdRuDvz4f0ySlDFryyIfOjuOTY1h9uO80XXmVKFA+lgDzB?=
 =?us-ascii?Q?7hK1Z2g1gJPwH7YKMyiDlEi9WY+x+CLfO/qRr2hfulSoYbQWh324lHEgbR2b?=
 =?us-ascii?Q?8gj98aYjfVePnyGL2h75IRIcCeZO2grmJsJT59IBQ+NDKS0Fo6OxO5+q06cG?=
 =?us-ascii?Q?lXF3dYo+koYFTIoUFiTsO2SYpZW9/46ZhwY+KcZy5d9MdXk4Z+xfPTn7bRD5?=
 =?us-ascii?Q?Tmk5VbzIHMYiQ8DouHWByOpk52b4zN+Y0k9HUa1+Z+1RzS2xNXavl/ZQvqj9?=
 =?us-ascii?Q?ThWTSf6j4ncQlWYn0GJmcnbxRpwWddDzu5KgpW7Q/Au5YhSXbvrmB8pjinss?=
 =?us-ascii?Q?jJ+wvvV+KTo2Xcm90NxN5N9TW87UBFXlNXKz6xhHUyB1zw/qVsVG+YnbVIqg?=
 =?us-ascii?Q?JiGXD7YoKoWPDFjucZMgXqCDe2OxX4lAzw+LqG3CB9jhVO9wL1zj5Gu+q8YE?=
 =?us-ascii?Q?+ELx7sHf3pCTBWyxGIsh5TAOorwDRLQrXUTTETd95d+S268juvwLAyc/stOf?=
 =?us-ascii?Q?/sip6OHaPW9vF1R8iL4yajMZGhOVUGI1y6/PCZM/By4dXTbH93OEbf7eJ6xS?=
 =?us-ascii?Q?1ieUkHmtQKPGZC3h2EkRIVWVKYUR6N4lqzMx3OlH+XBj4Ytrtgf5gYzGjI9y?=
 =?us-ascii?Q?HK8PP/8lQ6L0wmmBb66gmjCPmknYcvPn5KAJ8tW7Z+S0dXf8NWIeBYGL3L8n?=
 =?us-ascii?Q?v6i62eNp9Zakyss8YSaZYf4Gft6Vw9xBRcWQ+P5k9j+qyOBZYE0GTuuRayiw?=
 =?us-ascii?Q?rixRVXWCN04xqA6gmEOHDHy8b+9E3u4Qlr1gE0B8KnKdRzHZBhtqxPQnQ2TM?=
 =?us-ascii?Q?5sEca8mJ1KcMEwHJaj7VKfAK93vxPb2XxCzLQcm/uJ8TPihyXP6tTWiApGKw?=
 =?us-ascii?Q?qoBuaije7TNprJjB0mfeGOjDkGTX+O54OeMpDBwcs9Z97Al4AdMkNoZbwHtI?=
 =?us-ascii?Q?76nO1pBIwB9uxPA6nNMoNL3yEv9v4cmmxT7y6zeqAygsrc+Rp4IuowYiuL8w?=
 =?us-ascii?Q?y1uvs0GWVcQXh7vee9Kq2MqWvCnZLZORgFfPMRt7AxGm9/Rw1suyO6+2GqfH?=
 =?us-ascii?Q?VNrhuLgKdxv+GKmCPoOA+XEn0wMWhyrqWU2K4BaUyHjhQuyQCs68gKmiXXZs?=
 =?us-ascii?Q?KRwPPppGG5kiD5bwh43Zi666XnDF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:34.2149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faaf512a-ebe5-457a-cdef-08dc819211c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]

When an eDP with high clock states is going into s0i3, stream_count is
0. This causes DML to not update the clks to the lowest state and
blocking us to enter s0i3 since eDP is out of vmin.

[How]

When stream_count is 0, set all the clocks to the lowest state.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 5fe1110c4816..17cc2fdd7d34 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -573,8 +573,24 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 	bool need_recalculation = false;
 	uint32_t cstate_enter_plus_exit_z8_ns;
 
-	if (!context || context->stream_count == 0)
+	if (!context)
+		return true;
+
+	else if (context->stream_count == 0) {
+		unsigned int lowest_state_idx = 0;
+
+		out_clks.p_state_supported = true;
+		out_clks.dispclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].dispclk_mhz * 1000;
+		out_clks.dcfclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].dcfclk_mhz * 1000;
+		out_clks.fclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].fabricclk_mhz * 1000;
+		out_clks.uclk_mts = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].dram_speed_mts;
+		out_clks.phyclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].phyclk_mhz * 1000;
+		out_clks.socclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].socclk_mhz * 1000;
+		out_clks.ref_dtbclk_khz = (unsigned int)dml2->v20.dml_core_ctx.states.state_array[lowest_state_idx].dtbclk_mhz * 1000;
+		context->bw_ctx.bw.dcn.clk.dtbclk_en = false;
+		dml2_copy_clocks_to_dc_state(&out_clks, context);
 		return true;
+	}
 
 	/* Zero out before each call before proceeding */
 	memset(&dml2->v20.scratch, 0, sizeof(struct dml2_wrapper_scratch));
-- 
2.34.1

