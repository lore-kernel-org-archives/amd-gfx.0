Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1814DCCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B16812A6C0;
	Thu, 30 Jun 2022 19:14:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC15210EC70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B452ROL/fGPYnjz2U/RfLWNbaExCDUztPpYyiQMZycAkgm8tzFVAR6Zk70ayN/B9dysJgki3uJRxh+FZDLESTdWBc5z5vaMex0WfR8vLehuOE5miVGrKfdS/vYhNiOcDMJatN9KOyEbi/xhjEj92FeJOgvvyN8cU6ucBzhdnRY5hlESIVh0NMW4iI9luAWyg+YmgEtzz3QAAemEH25ylLGzS9X8paydwX2rvU1dEo2NefObWRalIXtuVX824BLWKlunExxDJPZ2XkWdeZbp6MbDPVUtaTjgmCxvzONcp8jcMaarar6h1YdUd5NNSy9hskD4bKAxp+cjT5fOZu8ppRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJRHc6j4Ov7UrzeUgBXsh5qIiaylxOL5HFVXwngb11k=;
 b=M1EnvwekeIrpPbASq5wCWQwHmvi84R1OOOOdK+H2KLsomFMn/83rCZGNkndGGf0wH/rKsIU0NCQkn+zLJhY36ERNpEktX3r1sV8ylFASmeUcCQaPSCWq96XsagCbvlrfK2JAnV2Uj4wC1Y1etyLjra8CVHxMu8yuukqComj0gpxPYlhvLi6bDuwoYTM9XDJTKNg5AdEoUr85lw/jTfrzQNqrKqRo96UPJuHqrmtsozkBTv39wX8G2UZ1oz4Ueb/J2vSheL8bYmA9xwLKLkg4bnxHfNKy15P1rar1BXhrA7uFs/LFC6rMtQKFqU7m8UyzNeh8vP0TmR62RHzybH/Ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJRHc6j4Ov7UrzeUgBXsh5qIiaylxOL5HFVXwngb11k=;
 b=XZTkIzXsxjqfcgVZ6fIsph3CeGNv4idLmBflifDBfwV/wPTXCnLYIMOTO4NlY56wMgXPZeEwJG0o7KSKoNM4OpGtVaQHCz27k5YKcFs2a5qDrcTzGKPHhHidgIYzmBCDGeSBugrblIe9tjFI3N4JZwabmQoQCg7eDnOPU7pykXc=
Received: from BN8PR15CA0061.namprd15.prod.outlook.com (2603:10b6:408:80::38)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:14:18 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::e4) by BN8PR15CA0061.outlook.office365.com
 (2603:10b6:408:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:18 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:17 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/40] drm/amd/display: Fix refresh rate issue on Club 3D
Date: Thu, 30 Jun 2022 15:13:11 -0400
Message-ID: <20220630191322.909650-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0848cc9-8d16-42f0-7bf0-08da5accbb31
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nESn7+JQZcvjcBrQlw4l11Xo/FqEBewcKqnR/F4hhD2wYZ979n5m5l4PWwqjQwIBhTaWQUeYPlwqjWx8WqtA1jortxwfTdVU5oOqsXG3v1mVzjrulfSNHXzcoBwWOvz7e42oAPMaWKyN4WKzgr5/WpOcHUCRTHcEnqAOysqkSA3X6qHF1YSZvciMiGVb8brUOiNvLF/ugsVPNh5XNrA+2Rr8hkCvS7rRtuZzGBEwmzC3KuijLlXMqpjwFOR/dbhRldF4+S/0CyBrCbfftJKshwYUfpJPDwqGBJ7nnvo0n5EcZ420oJuwzuHrFWO01odR7edrxu+tOyI6DBS6KZOffH1Y7mOGDOvuqHp6FMzjS30OKnbzWeDqIbbWmWrBbXeFD3j1/bqC+7Afd75SxF8hGMBDf1NWzD0NkgdjmyTo0eO4M31A7UQW0EI63WEiWFPmvchLGSJruLSUhRyVduNpfvRuyMOUWmQlttXFLwfJ5WthXImz7D940QF/vTWnFD6cXi57s2tvsVBISX6loL5q+hEMB2K/Yfze47XKLUX74MhyL9v6z2ysY7xLwB3oWk9l/yOX6n+3PkDUMddwJIdTsuJAmtOUajL3M/sdIDuibZKbHatJu6padDBZ7TZJediMCckZNAq22G+ra1LLvSehZ/fPoiziI0kx4ILWo/+5JWmHmqz22zCxmjeYa/5M1Hqh0nOHVqjlWFtJLTXJh4SOaM+cSF8TonF9hx+tpgvmP5UvAmUgjf7wrsG+aG19xdzfgEt3Sg013qcrJAhbXC6jpZG9kH70XRNExU/4TpCVNsI9bm5boep2wRkj7Y3xb+M1+xMjgrt015uhwilxRu+mFLxLB827J+jqRwhwX9Mo3Ig=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(40460700003)(83380400001)(5660300002)(478600001)(16526019)(186003)(70586007)(26005)(70206006)(2616005)(1076003)(8676002)(4326008)(36860700001)(8936002)(6916009)(426003)(7696005)(336012)(82740400003)(54906003)(86362001)(47076005)(6666004)(2906002)(41300700001)(356005)(316002)(36756003)(40480700001)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:18.6132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0848cc9-8d16-42f0-7bf0-08da5accbb31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recently we introduced a patch for fixing an MST issue, but it caused a
regression on Club 3D since we could not set a refresh rate higher than
60Hz. This commit fixes this issue by adding a proper check after
validating the stream.

Fixes: 1bd038dc60e3 ("drm/amd/display: add mst port output bw check")
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d150f85e1d5..7642411ec6db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7210,12 +7210,10 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 			break;
 		}
 
-		if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+		dc_result = dc_validate_stream(adev->dm.dc, stream);
+		if (dc_result == DC_OK && stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 			dc_result = dm_dp_mst_is_port_support_mode(aconnector, stream);
 
-		if (dc_result == DC_OK)
-			dc_result = dc_validate_stream(adev->dm.dc, stream);
-
 		if (dc_result != DC_OK) {
 			DRM_DEBUG_KMS("Mode %dx%d (clk %d) failed DC validation with error %d (%s)\n",
 				      drm_mode->hdisplay,
-- 
2.25.1

