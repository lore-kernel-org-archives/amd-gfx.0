Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACE0C4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F1D10E477;
	Wed,  7 Feb 2024 20:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBkuU8fg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0524810E460
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSDRPVl3MNbse3b67JkLBFiyAKH48YKFIKIW0KsiVgMtM5CT/Q8+XjGz/qrfxoAWkiOyTdmk5YQcTtEvLCC3sPX6nxnpGSm0BcdO28xExOzRS5A9t4blUGs/6wkUwWH8T33t5sKL6JdHMyklYXFrkU3HPOFeRHC4R32Z3RdwtXdeljV5lluFtT37rLpLW/Vybz3NMTwMDmauoAe1S9LsZ3WypA2yB0qYEB+2nV6BcX3hmPfNhZo09yIyqg/Q5WUFUccDXdFSuQvPWEPcxgjZixVDP3eD8IJpQX2ISuiK0Tuvi1oWvWN/KyAX6fr1KyU90xhhDdvswy/l1ZZu7UJBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuvv2yHBu7fFDmKc3o0yOOjy6rLZmb1Z1IaS2AD6PQg=;
 b=AIjwfcSLX+6Os7WvXpLHF4qjpLxXPTxcYsZci+Tszb1FlVrkz/22Voj/9s6LoSxqdMQeGFDjUtG1hZxmhoAfHWxdBIg3sgQTwhK2G3E5FSd0VgzDpiNe+GOG3eJKsSB20veUTUGopDm6TMOqgdSg4pAV3VJI7Ns2OBE4BpYKmuvJUtYRnIYf+RqKH9DgvDFN37WFtnXo4+IefzG9BJarwjKw6OS92IWcrc8QCasPN2cf6RzBbomjB+5GV697sl8Af9WYXw2W1hG/dIXmyzlsNdAbUm8eC8mG19O1mRLOkiWmrGZmVjjZTJMk5yduTcMCKue33DyKA6P9/GrK/rK6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuvv2yHBu7fFDmKc3o0yOOjy6rLZmb1Z1IaS2AD6PQg=;
 b=sBkuU8fgnwt+I7n8YgQcMFVbOa63F/5MiEroojpE6VmUHGJarG04LbG00SUIpesQcXz8siOMhyqRcYVTzLHE9h3P+vsegHCLmzx9IDKeD2JW7t9oG8TEG+U66h5/rkObiJmfU2r5zVNAexUsMnLaNJqH+vqkNbKtw4z2bBO7RB4=
Received: from SJ0PR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:334::15)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 20:52:17 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::14) by SJ0PR05CA0100.outlook.office365.com
 (2603:10b6:a03:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:12 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:12 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>
Subject: [PATCH 06/15] drm/amd/display: enable fgcg by default
Date: Wed, 7 Feb 2024 15:50:41 -0500
Message-ID: <20240207205200.1608684-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|BL1PR12MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 626f64a6-4996-4b61-3998-08dc281eab7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tdMG2YCH3D0tmi1+KOu/leeq4/UEl87XaL5mhBqifL8BdPXg7g5eWuLXXRwpoUgLl40meEd21keUlYFqa7SKo7FtVJX3w56hQUHjyA+pT3pKlwJOwxEcwlaaLQtG1gNVZXuaK5weWFBMNTJYn2OOnEqCPNqIL23sHna/x5gwJlAD0jYFsLjLPcWicqHyV4s+Vs+ZbKqfNo1TkxwpK4USGKYW6Nkgprn4En59y3tklUjWSqLXrIGy3YAxeCLUU4LY3MHgzCNI5TvO6thfQ2UMs8/heoVgJGor0O1CB0owcZkIgGcnQDs2tsJ2oer7tTRnF6fQvfOeH3Z8jL3FV6EeY/dlU826vx+N6ENa/7TYrhr7JHqQ9pGc3GBPcD7oawwN+exvPgJj8yZd7wifmGB3Z3yxHLAueJD7OZanwnA/OyKN2wT2kbULKThGu5zFX0IVszFi0ONiyCSZ1qeItTGuW0Fwv6va15fYkG+nm/yMZ4aERgiSbIjfVQACxZV/bPAIweIWATKA9DNdKul4cUZnpPMy35oeEYOqST93319SvmXt2NmGOL3EJhoC4qXBYDfSzXsmAV8iV6ygPtSmuojMMz/7zPN2ay/fwywA2124gk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(36756003)(1076003)(2616005)(41300700001)(26005)(336012)(86362001)(426003)(5660300002)(478600001)(2906002)(70586007)(6916009)(70206006)(316002)(44832011)(4326008)(8936002)(8676002)(7696005)(6666004)(81166007)(82740400003)(356005)(54906003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:16.8508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626f64a6-4996-4b61-3998-08dc281eab7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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

From: Charlene Liu <charlene.liu@amd.com>

[why]
sw has most of the fgcg enabled which is the same as HW default.
but driver disabled some due to enable flag not initialized.

comparing HW state, we still need to enable dpp and dio.

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index e534e87cc85b..28266b9a148a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1907,7 +1907,8 @@ static bool dcn35_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-
+	/*HW default is to have all the FGCG enabled, SW no need to program them*/
+	dc->debug.enable_fine_grain_clock_gating.u32All = 0xFFFF;
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
-- 
2.43.0

