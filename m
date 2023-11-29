Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6414EC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 18:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19AC10E1CC;
	Wed, 29 Nov 2023 18:11:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3292210E1CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 18:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI12aupqqJxLKzbz5K7P3oSkaTFNsEvu60A7P6Ro3HdGhHCge/xm3nix1efblblTFpMENKNaj3YSl5BturgqRkMqz2ob/Ufg4LWKXvAAMjVMiGjiM1eCROlG+rLrQgs3vZjG9eoKSXe6iQgf7FPRiIs7hf8Vu6Xd395+wZvhsWP/is+sDQaLCxsZ8d84ZQhMg+AEOps9YO6+an2pML1PM3p5HXutwQdO3UKrj1VggfSTj0MRBzJBMSJ5Hss/0zGjk0d4chKjLRYrKwkj0CqPxd4B7OQkrsHSBAKlxt9OWC2w+8IwpxwE0nsyAVZ5Gj05qJnRWI9Ry+x2I/nNIuuAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxDzRHjYoSs0VjhDrf+YgMzJHWNO6VjLSJLWVdc/m44=;
 b=M7Le7qZemGf7f2Da9lK8QcsGpdgMzr4hKz4BbUvDLU9ZnPgciGqdUC4k/Y8mYhkmVc5cjM5h8ZYl1YjggML1Dz0gDheJKM9Gpu9aCmMPL1zGyDHcQkew8VKoHnDjJUqE3I1Ogozx2IAxe/dbjU/+FTip/1/fjv+8VEvRNfSHM4ayCZIQdq61abHk66vcqTkZs0wjViDS2dmGU1WT9R1cTQDs8AFoNUPcu/a1Wyz5al7csk1oQnqLnZOyRtDMFXNGBH6yhuL6Jt1dVSqNWp51J+63uUEOtzRn7qhwtHGMFWTSRCNJuYmsHEPKYrakek7GHMon83JMkDVbdCYAirBWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxDzRHjYoSs0VjhDrf+YgMzJHWNO6VjLSJLWVdc/m44=;
 b=xMB8TDSz3McsVJDQY/Xq6VEfsQ1n6AJWapMBrteGssjzL5JIw0JguF6Etw7rfW0izLbiM3tZBwcOfikmbhhs0iFz/ZSW6mcYC34893+ph8HICvdYomvef0Cq31j41lwRldotZQZI+rhPmOGMZtGb5CIGemYWmvOM9MmaTQTzeoc=
Received: from DM6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:5:177::16)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 18:11:54 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::c1) by DM6PR02CA0039.outlook.office365.com
 (2603:10b6:5:177::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Wed, 29 Nov 2023 18:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 18:11:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 12:11:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference at hibernate
Date: Tue, 28 Nov 2023 18:35:09 -0600
Message-ID: <20231129003509.246035-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc28cea-ab94-4008-8ef4-08dbf106ab1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MBJ+wGQmFKRB9hz85/5NbcTCFAhi1btxxlH8zKg4d2I/uGBowLVZR1jhukgaoLnMeQlciSO/BXY2ktKChQjpuo/nXTd9SHMX8L4ySKif5ra4qSs1VtEc43cqlTj7/hYrLpfDzDoR3+5c7yrQHwUq2ke13TvwLvoKa5cv6EZCDIZ7MxK6DSyVu7SIMEVjxvxb8AvjtzdayC7olcb8Cv+je5mPn/Mn6hJN1vybp7fBWxtUfnKoT6agKX4/8+Odp4XczKgtYtevlDrilLigRNj01Ts77hLRePX4PH7LByLgP1tqQPreJYnwo6haS39UJTvHlPEYsExwsC9nYoNS3yUYLIiVPjFOl3vq1E6auoEemTS/6iRvCEpSwWZmwbk2YtocuexuYz36awbyWddppXq7nse768mAjLh60O601iDfzFufgK7rVFNH7nGk4xAaX7aXlJQk07/fPrZdbh+41KFyrpru293C92uK0/EXySdSHJmt3LXj9nNhRKaq+YINqBHRCKcKmnymMp5H53xZcfn1tqhYBecARMhy2Ixw6hQ7NKRig33kmEYau4X4AJmYlQ8xe8DXjk4npj4Ha43yAkb9lqVl6HTSHR/iqt2IyGo3mPK72gqgVBk7gsiJ59ObnnsLNY1KFQgg0r/44NUcX9hTthGcYQMF/22IEaQ8lyf6uRarOk6Q1GMZ0ZkveXZZPlFSjxKU2sN+0M/Ew5yJgaqzhtiWXwVpz3d9EMErEYiYppW5hw7gCi2YMorGgo83rus
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(316002)(6916009)(426003)(336012)(36756003)(82740400003)(86362001)(81166007)(356005)(40460700003)(47076005)(70206006)(36860700001)(8676002)(70586007)(8936002)(4326008)(40480700001)(5660300002)(2906002)(44832011)(1076003)(41300700001)(83380400001)(2616005)(7696005)(54906003)(16526019)(478600001)(26005)(966005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 18:11:54.4861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc28cea-ab94-4008-8ef4-08dbf106ab1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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
Cc: Rodrigo.Siqueira@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During hibernate sequence the source context might not have a clk_mgr.
So don't use it to look for DML2 support.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2980
Fixes: a2815ada8616 ("drm/amd/display: Introduce DML2")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f3a9fdd2340d..e1c02527d04a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4554,7 +4554,7 @@ void dc_resource_state_copy_construct(
 	struct dml2_context *dml2 = NULL;
 
 	// Need to preserve allocated dml2 context
-	if (src_ctx->clk_mgr->ctx->dc->debug.using_dml2)
+	if (src_ctx->clk_mgr && src_ctx->clk_mgr->ctx->dc->debug.using_dml2)
 		dml2 = dst_ctx->bw_ctx.dml2;
 #endif
 
@@ -4562,7 +4562,7 @@ void dc_resource_state_copy_construct(
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 	// Preserve allocated dml2 context
-	if (src_ctx->clk_mgr->ctx->dc->debug.using_dml2)
+	if (src_ctx->clk_mgr && src_ctx->clk_mgr->ctx->dc->debug.using_dml2)
 		dst_ctx->bw_ctx.dml2 = dml2;
 #endif
 
-- 
2.34.1

