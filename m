Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7195CCD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E0AE10EFCF;
	Wed, 10 Apr 2024 21:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FSdwxEge";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B30B10EA65
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh6aCAfJMnvxuI16s43UHLxuAAAIra4rh9G5DO4RV+rtir34fjDCLfbZLCw99h7uOdBWUw8GHnBjUhysXEMBkEYScK7H18IUZDya7EXmUYjcVcSfdl07sXz6p2a5ErHgmqAs7y01rqxp4cASq3hZLDxBZuggiABgzIikCa+BPJtheBixLCCfcYXzrNO83JEWX8Ci/flmOnr4waDEC79O5J4/WzqTKDhFE8WA0LW7es38jcunG/t+pOiVZ4tFy+HcN2QdiAWNvccaORGWLrZtGPwnwkjp/dEhQSXlP1Dad+22rnK71kc5G5RNguvxLTXkduyu3CJ4Rt3mHpkvYZShtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08J/0E+liA0oigIZvmsIpr/EQHZ2l0kPGjdTcr1iZgo=;
 b=cnrQ3UFa1G2f7zns3wpwncZkC+JoeyGMWhnzhAyvpHS3YN5OApKdqOjeUG+PJLuyan/6Tpmf3m8Ozndr/Ty7awQ39+uwIDRiXKltYiF5h8gGCSs3P/c7Q6DwjC1xQI1kqrC6yOvMFxQiLbUhBtbz3Zbn6WmxiqHZCydmemEYFch4b4wTsXpM39NcEuPQvndgBgEFGipkAwaU0YGPd8wZwGdh3uWmdaOG1lcRpLhJYavrTW9Rd1m37cVE3O8ZVN9c8vSyTU6TofMAqIvveBQtrWtNNdL1qNbpJZfGlhWLV77dNpzUNQT2HVBpVZ8L3Z2SFmcdKI6pkmdWN83X1uhQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08J/0E+liA0oigIZvmsIpr/EQHZ2l0kPGjdTcr1iZgo=;
 b=FSdwxEge9836kVDw25h1BNQN50T1dJEOIjWAwbhQ/ARiapQhQYqsxxhx6cTL5fR+MrqiFEvZhHUxF+X1taDpN5qT4cj4zAkT5+uVchIXO7YC0c8q+JKmRXFuzB/J455MToUAiWI+CS4/2OhHDDIFw1pOsuj/tHKphtMX6/+KqyU=
Received: from BN0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:408:ea::30)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:03 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::b6) by BN0PR04CA0085.outlook.office365.com
 (2603:10b6:408:ea::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:03 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Chaitanya Dhere
 <chaitanya.dhere@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 07/25] drm/amd/display: Fix incorrect pointer assignment
Date: Wed, 10 Apr 2024 15:25:56 -0600
Message-ID: <20240410212726.1312989-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d134151-bf63-41c1-d458-08dc59a51ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GixQuQMM830GvqXovzvWBh4wenBqOSzelemePo5uO0OMwBPBfzE1PLq+ZBbJxp7yDJYCYRTjIJGjJdzL1F7vcSYCcbi5qmYyydUmQ9dQibVpaI76sBQSlldBb5dzN21sPiSxyJHnrDPFM9aOjKuI18OftE2HRTFHN+s87e0DC8Q1/AwTaRrBN9CbFyJdTnz/ohxoqpv1hBkVDZkvC6PX2SMR+5DubK4VtOlfdHoGiQf9TU88L1kUE+Jw93892MbIZ+EFkY7JhF5JkLCUzLTTpFHMY13D0bZu0Qo8hvV6CvgUGmDDM/GoAsUbU5+ZNf8EXz5PJcTeMPXol6gFHqtimRg3+8qwYDG5pEWnxL/j2EcN2BE7cXoKngHH6BZ7XJlWu6Vs+XTt41QUb+DW1X1ufiptOopwhDeVTN1VExzbKCC9nHIMqt7o5sjKV0cJNgO/E9NuWhFkGgL5o+iPLCVg6Syp6+OXFU4zifSEt5f0PGkJyG7Qjs9nPDz7yNK7fUSkq6iTvnWAx7SObuXtPfZLYjtLqWrhwarPjmMqjcGWHuVCyw2SnM0OWnvzrcf6W+Ph6hHgQXN32ezq2U4AAq9FMjwf1JSIT9iZwhsFIL/gYRocHWS5Jl+x5oNBR4p7dP5F8kyRGKnQt15LX0K0fqPbnDQM5ZhQ4wezNQBXDkmuS8TVoJvJJwFk5SbOXPR+ntPk1ggce/cG4SgCwXbCino5Hisafu5yzyae1DVDbAjKoY08UV8siqbdnpyuBzwCzrzC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:03.2453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d134151-bf63-41c1-d458-08dc59a51ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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

From: Chaitanya Dhere <chaitanya.dhere@amd.com>

[Why]
Pointer initialization and assignment for dml2_options is not done
correctly. While this works for some compilers, others give an error.

[How]
Modify dc_state_create code to correctly initialize the dml2_opt pointer
and pass it to dml2_create. Also update the code with correct derefrence
operations.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index bf889bdd3925..76bb05f4d6bf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -191,7 +191,7 @@ static void init_state(struct dc *dc, struct dc_state *state)
 struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
 {
 #ifdef CONFIG_DRM_AMD_DC_FP
-	struct dml2_configuration_options dml2_opt = dc->dml2_options;
+	struct dml2_configuration_options *dml2_opt = &dc->dml2_options;
 #endif
 	struct dc_state *state = kvzalloc(sizeof(struct dc_state),
 			GFP_KERNEL);
@@ -205,11 +205,11 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 	if (dc->debug.using_dml2) {
-		dml2_opt.use_clock_dc_limits = false;
-		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2);
+		dml2_opt->use_clock_dc_limits = false;
+		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2);
 
-		dml2_opt.use_clock_dc_limits = true;
-		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2_dc_power_source);
+		dml2_opt->use_clock_dc_limits = true;
+		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
 	}
 #endif
 
-- 
2.43.0

