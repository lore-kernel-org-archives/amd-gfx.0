Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58C5FEDA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8500110E682;
	Tue, 17 Mar 2026 20:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kpJV2NRo";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75AF510E637
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbxrYTGGo0FMQvXbkiY1mzAvFK1CgQMpGsT9IkDQp58Mkydzgvb5K5sMA3HBHxtSYOlxjL4WzB543qHLt4+dbFt4iBatJLzo7dMEZB2FjaoXR1HmZZMIwHSeRRknP4lM29hf6xDPYbAen8hV/Wv4hYKV91GAC8Qp53G+9ExBqxab+4MWUJ9nwEQ63tg/Lj4CDzQ4ZCWOCA+3BCy4IHpctZdSY08aT16Mk3jJqHssXA1jQATEs9T5fiYwhmDNRTdc+77I33UfTEeJAScOv4wqBSIP5oVQ0fVK0qp4fpyEWa4WiOFjMUvbZs3tGWJvQyDSrZchju5L9pPzj2ArwsJVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGFX3KwMYsVHFMHLhMTxHPRosY0oK59vJYboqMqYr6s=;
 b=a9HrLTr3H+CEPyuXOfmFmz1C+cZHuDuvJ+vjMYsEheN7C2HIMuAaElAGVAXpgmwZzbMo3DvpQOW3AWgdmyn1fIJIUV8H6ZQQxFXLlRRBgYNK8lNJbfKCSkX9+uuQ8OVTST4yDVD4Qan5T5NuLoPAWoAKxWtk03vQ+hiXPWeFdocTPNbBRvY2lVodUxhT4vE2TuiuVI/AYQLpgP9JdldQPIiZkTS7Ih/X1eNjFT7+9iWjfn2fNo5QVh4x/yrvnP5S0t1jkvSxsKERh/J4uOzoGJu8yFuG19KZKdPhlksqHK96QITtCQ15zBJBMCYoDN5zL6IWBTN1tq4dd4djlKX58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGFX3KwMYsVHFMHLhMTxHPRosY0oK59vJYboqMqYr6s=;
 b=kpJV2NRoUs+BzhRX/x1Ge1RJpmfW8v6cVdhNOTpdGVcm+t9bt5hJ6amcVLH35e6R5kkWVIJMxjB8EQfowBrx53QRjS8Fd74/1ctxuyS64mJdfqg0xsTu/bbMy+ka3mSXR/su77aAkRnsdBVUDv8ivaJRzuWrKTcKnLbRDqbwCew=
Received: from PH7PR17CA0020.namprd17.prod.outlook.com (2603:10b6:510:324::11)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:13:14 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::6a) by PH7PR17CA0020.outlook.office365.com
 (2603:10b6:510:324::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 20:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/25] drm/amd/pm: add populate_umd_state_clk support
Date: Tue, 17 Mar 2026 16:12:31 -0400
Message-ID: <20260317201242.3808136-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f1f745-0448-41bc-7fbf-08de84619e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: s/HHB3TgXmken8c2ICytQVY/y1+43xii6Os5TTFigmpwWYIp1ktp230603kqIzyh2IeIl8NgLUqwiyDRAFklOfIoj0ULkAKX2SFIacuo74rQJZTxnk2MX8kOGx+ETXjMHyqbJteuLjII7qmuIOjpylUACXaGztYB3lsezT57UhTEfz5Fjqwbw7OuQVRtTKdmBVnoix2YU/iOg8SJNfMtmVRsGz259U++8U5O02zJn/pcT7OMUavK1+U52VaG7UkXR8J3Es+pQc9yLVqYTyZSZk258f6PP3fw6SwRRc2vQqaxS4Gp/rOYi26FN6pINN2+9Z2TiKjZ1/lcPc4nE+IUjvUFquCbNtRr/M9nofaCAMGT5uIk5s84lZR8wnDnY+cGheUj7j5Go4s1u1CZC6kekklWMlJxrnVi3xKFrIwc/CxqfD27+X3bfyi1p7gStZE3MrFoSoOL4kt2MDLaw8p7Qdz8j+Gu9HeF9wWuQ+FJPfGGTa3ROvEfbUc9kGaAIAFtOT923OMGKjOIOMR1Kn03mWh09o50g0mmc93BOP3zk+y+0W9agit02KVjU2p/U4VDCGLl7l0OV4NNQYv8QDn/URValjFDS5q2mjqR0jgm3BmZ1OY2uWfBHfL6vEtpYeM4NOFw/U4hK4uHENPynShNhtHMN7iz1L8F9f63WLgu156fy/GpqnBKo0E3WfC1xFd4BZ0QsMBxi7p4YoTmtXQjoSxPE6fwdza1XEuYGsjhogVJDHBQK/PwVVoMe/ddeI5J2Pn8zS474Atw83lNvohRug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VQLykUJnLxCLZmhQ7+h7JHZAqGuahqqkmgX3dT6FE+tddn1+Ym1Am10FEkw/ggyO5HQWtO2Ak/C6FeU0a2Jq6l1ouNMaHEMIT6zehk5KQT6nkLMhWUeqkpViGUibM0D2usLk9jiAa8jRfPyPAPmOlKl2pelZtFO9K4iUx1dTvrGh85mp/AtjSxttBwdzXzudQ/QAbvgYq9f5TkbjCokk6fjH5JIgRyfU1uu0UaHjwgmErO0BJzQQAl4mchlAmCLwih8Ms45zhhmXFe96SroTPUgR4nhGG/JeaAWX3yAjtrMQkT6qoYXSu8ofjpMyyWIQbZ3a/W6Co1X/HSE7ls32as5XgLX4e5r2rDEVJwPZp46ZvrCGKZsa4KcV5qwQH1opS+h7lvWIeClIolCgMVov7QcnSQmmycztMmqk/clgvkvBYH5roK0rj8ORe+W9/Ag0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:13.9181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f1f745-0448-41bc-7fbf-08de84619e91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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

From: Asad Kamal <asad.kamal@amd.com>

add populate_umd_state_clk support for smu 15.0.8

v2: remove gl2clk/socclk/fclk, restrict to only current min/max (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 9b48c258b1f20..f3378e73b6ccb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1376,6 +1376,21 @@ static int smu_v15_0_8_get_power_limit(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v15_0_8_populate_umd_state_clk(struct smu_context *smu)
+{
+	struct smu_15_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
+	struct smu_dpm_table *mem_table = &dpm_context->dpm_tables.uclk_table;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+
+	pstate_table->gfxclk_pstate.curr.min = SMU_DPM_TABLE_MIN(gfx_table);
+	pstate_table->gfxclk_pstate.curr.max = SMU_DPM_TABLE_MAX(gfx_table);
+
+	pstate_table->uclk_pstate.curr.min = SMU_DPM_TABLE_MIN(mem_table);
+	pstate_table->uclk_pstate.curr.max = SMU_DPM_TABLE_MAX(mem_table);
+	return 0;
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -1404,7 +1419,8 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_power_limit = smu_v15_0_8_get_power_limit,
 	.set_power_limit = smu_v15_0_set_power_limit,
 	.emit_clk_levels = smu_v15_0_8_emit_clk_levels,
-};
+	.populate_umd_state_clk = smu_v15_0_8_populate_umd_state_clk,
+	};
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
 				     const struct cmn2asic_msg_mapping *message_map)
-- 
2.53.0

