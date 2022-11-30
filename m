Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B84CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD68710E297;
	Wed, 30 Nov 2022 06:40:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D3710E296
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHW6TF5JdjJrghZBYG59CJ3nMThbOu9HOvBcZZOOAP50jePjoPSxgExsKV05RPMkzThnFML8paAtCuiYDxSJ+22L1duoJtx2TqCftL8/MZflegrMCkVMg0oyaDfjNPYQYKGpL1SaHL2dcbi/FN/okOkmGD2Pm6HW9MMdtjltDNznmvRfe4pjT4ue/L2gKcBOQSz0PwwZUoIMI1Qx5X5za+pXITu/BPDTNvhhroRWD4DpfTYyd0n2Sq+ncqU3fE7o5HAz/yUV/BCtTxVt2xdJrsyGTZ+cm7TDWY2bhF3T/lVgLP2SwDZfaMugWpIe2luaQTY4TMnF7zpZbWyZGYKhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqA0dv5qUtUgRvL8ssXv7+zp94YJbpNfCGLPXYvZWe0=;
 b=DJ37uDbFxeGWgM6jqZo6bi/wmNsW4EzfMMIG4aXWvh/S2sAIhn+AyVVDziybmN6Y3MFuJUVjDiRGyraYsolzqSsA5qWgqe49gHeLV6nj+Vwr1UKMtXplzrdkqisc+JEK/UB6uDMSV6sDH7OhvPGAO9LRr/P6rBBp1VuknkQ+0pzfu/xx+T6y8es6SntrybIh080QO8UiPHJsm5SPHkBfRO6bceiZTZwwixI/7EPmxE1Gd6/YKiBA5lxIfOTU99GKy3B4IQUCinjeIeEatfAcD2Uwwos+1GdDYo7fgkF38ZEJGmHJ6JIAGLiIxB3MZfJWk1zd7GCQkoXlejP+920BBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqA0dv5qUtUgRvL8ssXv7+zp94YJbpNfCGLPXYvZWe0=;
 b=b1GsoHxXG3UZVV4OyhNXE6PsnFpNsPbAPqv+0Za3X5JmZgEWTbSrvmudKZFBhAfWc5P/FR95/KZ5xuWbzBpJEtcbFJNHIbIwiRoXyed3OkkD2nEIvkbz+M19bGH47Rr6j1MqJZRhxZfsY2Jk3be9d7QxCDEJ3OrbEPBZ0lCl4ww=
Received: from BN9PR03CA0778.namprd03.prod.outlook.com (2603:10b6:408:13a::33)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:40:43 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::c0) by BN9PR03CA0778.outlook.office365.com
 (2603:10b6:408:13a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 30 Nov 2022 06:40:42 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:40:37 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: correct DML calc error of UrgentLatency
Date: Wed, 30 Nov 2022 14:36:24 +0800
Message-ID: <20221130063627.2398341-12-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|CO6PR12MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: 385d63bd-cf86-40f1-fbee-08dad29dcda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nk5bADJGqSK71zWsm7g18WLeuIXxvVKfvFuOeW+nbVFTStCwK6QOWevVuu6Ioaev/G/730CN9j6LSGqutA/OiyIDn/r8U7JDpBvhEHkaQaEZ3K7pQSbm6yn7KiON6qZO5n4zdwCbmeWevpJ7nVVDPXdBlvBQVQIJ6nu2RZgFUH2ysAg7lSvObqeuYgLFIUC9mIKcu9PlmzpbpwLGYD6YKPEJ3GzlBBXtBDm3GgovN6wpjpj/aN4wSEHUWGkvre8GtVYc0GfY/KJ+GDMvFwCZ4KmQUXRYgB/lpjGzg609fprMhc47GLRXdtWn435W42WPvzzW8pjz2xSrIEJCKcruto6GgzUbIzK9wJNu0HG9thWLSOSwT7O3DlaOnAcCFRpBtr8xVTwf6MeHmD7hWpPe6suS4wfDdSosT2gKezBbLwUl7ldFpwRxjmnmWLvk/6ksuQI/qzSA0uzUROkkUIKJaO8rfu4O/17rO8VK5+QdsOvKLxCKabsPP4QEc+QwnIfCUDfrc4DyDWCfbXY5atnthf3nTqB0yeCtD2B2vw45/OhrUoFU8pWEjvx3TYwiqB6Ed/ahufeiaT9sd7eDFH3FElLgDivao0GWGJsvLxQMJqXUMGj86fGcasMpSqp1gBJQivLv075QgOI49jcczk0jZLnOWCiEV6CfhZVa70Bcy47cxTq0BD1eFhs5OgsOjR95dt1Z7vhSqQioUzpThgMG2tqhZ4KDQ2GNSx+ue17XCrY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(316002)(478600001)(70586007)(70206006)(2906002)(40460700003)(356005)(6916009)(81166007)(54906003)(36756003)(426003)(83380400001)(82740400003)(6666004)(47076005)(26005)(82310400005)(40480700001)(36860700001)(16526019)(2616005)(336012)(86362001)(1076003)(7696005)(186003)(44832011)(5660300002)(41300700001)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:40:42.7602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385d63bd-cf86-40f1-fbee-08dad29dcda7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Zhongwei <Zhongwei.Zhang@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhongwei <Zhongwei.Zhang@amd.com>

[Why]
The input UrgentLatency in CalculateUrgentBurstFactor
of prefect check is wrong.

[How]
Correct to the correct one to keep same as HW formula

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Zhongwei <Zhongwei.Zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c  | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 479e2c1a1301..379729b02847 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -4851,7 +4851,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k],
 							v->HTotal[k] / v->PixelClock[k],
-							v->UrgentLatency,
+							v->UrgLatency[i],
 							v->CursorBufferSize,
 							v->CursorWidth[k][0],
 							v->CursorBPP[k][0],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 4e45c6d9ecdc..ec351c8418cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -5082,7 +5082,7 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k],
 							v->HTotal[k] / v->PixelClock[k],
-							v->UrgentLatency,
+							v->UrgLatency[i],
 							v->CursorBufferSize,
 							v->CursorWidth[k][0],
 							v->CursorBPP[k][0],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 41f0b4c1c72f..950669f2c10d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -5179,7 +5179,7 @@ void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_
 							v->SwathHeightYThisState[k],
 							v->SwathHeightCThisState[k],
 							v->HTotal[k] / v->PixelClock[k],
-							v->UrgentLatency,
+							v->UrgLatency[i],
 							v->CursorBufferSize,
 							v->CursorWidth[k][0],
 							v->CursorBPP[k][0],
-- 
2.25.1

