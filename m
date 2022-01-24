Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8970BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 14:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1227C10E685;
	Mon, 24 Jan 2022 14:16:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B8410E31A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 14:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCo0DLCUWAo0lQZRL7/sPN2alXKeVJOSeAoSa28x3ovh+YL1I6lGG8T4Ov/CCG1DIm226abX1mLrWfMxFRHRYy8jaByenE3qd8hFWhV8TcGOdLY9og/VI8/AdT8/wzUTJsTB3EHt62qnYzE+4HoSQAvwOgs3WIpGhYlCx7g0UetXE1NWRQlwr2t+kaWZ/B4pweF08ul7TIQXGULyAje3yyLdQQDg1wfxJR9met1hHkyI3a8SWvrzGDPY8j5fDv0TWi20anwkjG9c0Xga4W95pekkvCjoZUDtLb8PRgq2pOif/s+VELNTfJpti6/5HJCmeOQChUxfLATniehzuXhlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekB/PZXdmiFm5PwNJb4OC0u66Q43CS7g+/ljTqTKhjI=;
 b=VMjU/rQ+XnyN+3JlMvDzAKl2QOy6IrGNegi3MbAYFCRrt1IDF5uB5CP5oQbf7xXW9n2rjiEL8ipMMVGCBenaLuvkGDcKJuGKMmtc/S6jk+iOVh7esV8FYjB6vN+hp5hw5FipfmGjmyR0HNiTit7HZfw4NNPl+2Sp/uTM0YRTSJPwpRbFZbbOvMaflqhoJKI60NFvo+aOwE0ixPDhERQUZqKLe1eTmqZ0KCW5MboP3+z9u5Hu2gNyt1M6dPeTLRajjJta00cPkFjOZ5YhXGb40mDO3NrLn0EXiR4yPL6rlmt2zdypWrylCzUW4WNPzvLF2m6xk4eO4LA4sWM21j/E5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekB/PZXdmiFm5PwNJb4OC0u66Q43CS7g+/ljTqTKhjI=;
 b=3pvZL77t6XaJ2lpjvYWXZU7J+lJwrgh7WBYkhcjdJ8tqGmdBM5aqBzun4nRkvI/eiTKiiMAHEDNH1Wp0eccsrQCT3s/d6hrhtLmOlrLPqbQcdTaCdZx2/qFn43vSMXtYSL61yy9GXf6e0HUveU9F5Ej4BF1hQn0LwDdc2qznShs=
Received: from DM5PR19CA0022.namprd19.prod.outlook.com (2603:10b6:3:151::32)
 by CY4PR12MB1272.namprd12.prod.outlook.com (2603:10b6:903:3e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 14:16:26 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::db) by DM5PR19CA0022.outlook.office365.com
 (2603:10b6:3:151::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Mon, 24 Jan 2022 14:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 14:16:26 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 08:16:24 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/pm: add get_dpm_ultimate_freq function for cyan
 skillfish
Date: Mon, 24 Jan 2022 22:16:09 +0800
Message-ID: <20220124141609.395703-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5781785e-ddc0-43ae-7135-08d9df441bb5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1272:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB127214EAD61DBE62204D73CBFB5E9@CY4PR12MB1272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRzYWtKH4afoSCvfkud6eLlVe9bWNs3GL470aHrnlEHWhcCG3TjxVAiOLDf/4Hh/b7bB4Iq+6RBFwEj50GaTzE6LI8I1RrkFzubvl2XfQSwxIuM9Y3XBxcvrx2yMGxeLvQr0kwbsG3+tDw/W3aLLO1Ln1tHdV2Fof9yPdTqM5ZKrnrJ2XMsx37uNPO+/f8Sz3EviIU68Ug+Kr9ZKHcVaJHnSRHqjXZwIL5Z1HcMQgCW6B3Dx9AUuMCoCcskFxLu6ucJsWpn6mmEsUYI/IuDdwIXh8GewDNoylm9HQpRuTdUmSqpDywtcfcBBSTVwwPPVcYSmybH904pKPB1xfeNdHTER2VlNWqy+yDFYjRKujyLBpUl1cxgYg6lT7ZPtzG/JaatnRq/CupXNtAr5OUuJisERyl8G+CaM/HAVQf6yGnQXY/bY1aF5xhMf6vn43vPgt/thMuT2SPy9nexOKKcpwrvu70M0ImeW4liNmZptKbBVN5AjEvgcE23P9eBCimzQ+Hi2Pj6BYQnky/egkQ7HJXCDDk8eRrg9hf0STYXFUdEgLNFJ/OxODIZarZBKWBYzpNv1vrkfBWMApghx54Qdd615GyX/KidZFJpbAd6GOPZZZzTRXslTC+Q6uGymOGbDbA+rsnHUWK11XnfSB8r+Y7V+E1H/WeU0NMcKDvSoBgrpcY4ciIQOfb/SUOiMpo6YObyVUur8oFPGd2YlxWLOadHhvIrb3qDcbQH1Q/pdzGY4eyIwg9W4uK6z0tII3j8ww6mUCg5K9to5dHtcdn4ALfFx4m7JOaLLI3n3iVwVWTQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(86362001)(36860700001)(6916009)(81166007)(54906003)(6666004)(4326008)(356005)(1076003)(82310400004)(2906002)(7696005)(83380400001)(508600001)(336012)(316002)(47076005)(5660300002)(2616005)(40460700003)(26005)(8676002)(186003)(36756003)(70206006)(70586007)(426003)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 14:16:26.4344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5781785e-ddc0-43ae-7135-08d9df441bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1272
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some clients(e.g., kfd) query sclk/mclk through this function.
Because cyan skillfish doesn't support dpm. For sclk, set min/max
to CYAN_SKILLFISH_SCLK_MIN/CYAN_SKILLFISH_SCLK_MAX(to maintain the
existing logic).For others, set both min and max to current value.

Before this patch:
 # /opt/rocm/opencl/bin/clinfo

 Max clock frequency:                           0Mhz

After this patch:
 # /opt/rocm/opencl/bin/clinfo

 Max clock frequency:                           2000Mhz

v2:
 - Maintain the existing min/max sclk logic.(Lijo)
v3:
 - Avoid fetching metrics table twice.(Lijo)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 2238ee19c222..dfc5d6801f9f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -552,6 +552,36 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
 	return ret;
 }
 
+static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t *min,
+						uint32_t *max)
+{
+	int ret = 0;
+	uint32_t low, high;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		low = CYAN_SKILLFISH_SCLK_MIN;
+		high = CYAN_SKILLFISH_SCLK_MAX;
+		break;
+	default:
+		ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, &low);
+		if (ret)
+			return ret;
+		high = low;
+		break;
+	}
+
+	if (min)
+		*min = low;
+	if (max)
+		*max = high;
+
+	return 0;
+}
+
 static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -565,6 +595,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.is_dpm_running = cyan_skillfish_is_dpm_running,
 	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
 	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
+	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-- 
2.25.1

