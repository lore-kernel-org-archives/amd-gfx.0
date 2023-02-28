Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67783C64EC7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 19:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F1D10E06C;
	Tue, 28 Feb 2023 19:55:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D61B10E06C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 19:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivDkb6gW7WnnRjexITekvbu2ZIYZE0xBs6hUGyl5hQ8tc5Zlf6hqNhWNrcoJFT0E60Xv1yhs9r9QW/3eqWbnd5AY0gFtMcYHn+OLwjrUaz1PgyqFIQryLTsWyOVVHcVEOtPA+oSgr5kKT23HAIw/uVXZ6G5TwuPSXmik9SwUkyHMU1du2q8XCrzdDj6Xi7cy+oqX/EjlOY/k4ttV3bsISDF73JRlbn+J9ZK1AxD5WsmECE7X+virIvc7irSp2l4oSjNQRChNAL/sMdGPa47NykFa+e+tBjiIE4zsDWqumWd0esnB2r61+u8370JqYoEDpODtylaC4cJJDXbpNaiBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNNuWNikXVFb8Dv8z5OD4qflCJhMyuWSUK7CIDqmy4s=;
 b=MIEoGQsdoMTctc8CKhPN31QQcs6rt5s9IG6bn5BN5ziB+H8lqYVqqToxYH8RwD/Tv95N1GRu/jvsXfzBKfp9HpuDVKVU2qHhl8tyCYt5BhOd4rSGBl7kDEHfwjRMwJKmX3fY1a79Xv3FPiKR+6fLcP/nhcYhZmfawYJUTCKhVsnmO4/M7bketAwyGgcpoB42JJcpbF/h4+0o75oHWar5jvAIvrlgECQlLJArQqjeFieex11j7fYlp7KVJIVaJtaenmDIs4EsHECNQuDY6uOo1w/BqnLYICd44rxYrKfWhUyplMeAlAveN+TEptJfhL8kvhNC5edTfTlyYJh/9eZLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNNuWNikXVFb8Dv8z5OD4qflCJhMyuWSUK7CIDqmy4s=;
 b=0Tpg54EuGsvSc1XelvO9ag5x+QMLgGNqBu+80M05Foh1Z1UbCX7VtY2lUhOJy1hKFIDzeynm/3DJGBN1kiHIsh1Rul261q28+kSbC1yOlAfxWxVrHL0FtFDhGsprnRNzSJhZVPXpBl2emOnWwwi1lQNaI2IJKuWSgp3vi058DTg=
Received: from MW4PR03CA0070.namprd03.prod.outlook.com (2603:10b6:303:b6::15)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 19:55:07 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f2) by MW4PR03CA0070.outlook.office365.com
 (2603:10b6:303:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 19:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 19:55:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 13:55:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu/display: change pipe policy for DCN 2.1"
Date: Tue, 28 Feb 2023 14:54:43 -0500
Message-ID: <20230228195443.10758-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: babd70eb-11b3-4003-9be3-08db19c5b0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpshfxBEjQ37nfaWAxbRxjcTm5AJjvaSs8qkTQAwjH86KuN8obB+2uECCftHzbusvBlzhk6jogS8M9zXFiuUCPA6hcvpYvDdG33xeQZIvkThEo+ZtiCuSFFVl1f/gjAmzVAMuHMeqIe5aMXnHzaMH9ev/HTx6J+NwtORTQhLoKSE/Kstiqf7mfUK8dm7xRLtFLjVB78sPVkdy4aQpdY+HQO/tzj9lDCp1wohgs9fEcCqKODM/znZuIqQkZBw7++7ddVjHzcHL3eTlYY6xQkpaRT5YFvUGm3ApH2QWEEjwdQH2mP5pWGGRLLF3NsxN/FxPXJDrdq7d4wu/nNRDYjjknoEwsjnFgz3y12rhnKEdlB+Kj4CALGgdFkcAo/jhwMoD0YeVnx2tkoEPTyk3CiGBsja2xQIG2xR9D6OdoPksd903l/+9C/Lda6XY85yExGAaOaQ3wnT3XHVh/Qj4JDy2BdjTe1pOzjzqHdXaNv8aLIpNwHVt3ptR7ES1vBFHhUz8iCc9eoqQhV63a5LqcxG0Dzkegi86yVY9Gx4im0vYntGUgzjgSMMQ6T2b7IGdQuG1Veq619Z5575p8NTKmTsl0AA1P8I3aBl0KsKgEHRsYCmiLTQo2ZtZKgub4gbk9IBGUm2H9iTX9LcI4JKGAtHHrfR/wpz8o+/uggsvRW3FPJssr2sWpN51fJgncWZltZr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(356005)(82740400003)(81166007)(4326008)(5660300002)(86362001)(36756003)(2906002)(8676002)(40480700001)(70206006)(6916009)(8936002)(41300700001)(7696005)(82310400005)(70586007)(2616005)(1076003)(16526019)(336012)(26005)(83380400001)(40460700003)(426003)(47076005)(186003)(478600001)(316002)(6666004)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 19:55:06.4062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: babd70eb-11b3-4003-9be3-08db19c5b0a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit fa458eb10dc7218146a84e6d2e072424e64d188a.

The issue is no longer present even with this commit present
as verified by the original reporter.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1849#note_1759599
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 8f9244fe5c86..c10ff621cb1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -642,7 +642,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
 		.min_disp_clk_khz = 100000,
-		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.39.2

