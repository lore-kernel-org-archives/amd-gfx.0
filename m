Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DE7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91256E3DA;
	Fri, 26 Nov 2021 19:49:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072AE6E3DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCKhQ4HTwXMmdI8+9FdSj5l2WOUVsUe5z8upLz+XodAe+0qPj+MU9iKqWZwPeoZBa5kbbIhGajsfSY2DsBywvIzHLO6N6mPYZdr28484BVSvD3KtF7Gg3ZgK7wA28tp80OAsiExEk1uPty2O4hppaF8Baso8rS2Tk1zDQ2acrCV+CPCNQHNKjGqw31lOK+mEaTv8aRgkF4VtHhXqYi1idD1x84C7tisIUPPwYcBEYYy6VvExZnZix23I3OnwGcGA+7SlO3tvQSF4yJ1M1cYNYvKORam8jeul0A3uojMxmRxOfvaGa4b5tz9g9W1fRTy9HakUDT4UtmD8blOkHd0R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnECDRz5U+9V4rjBd1hpJEHtcy5koqHSDl9xDlMgtPo=;
 b=ZwoFYoTyzl5YmxZ6jYxEnnB5wOQr44IhpxNQZFZoLQCpZm60oJOoV+ebH3YAnp8/vJNSF1s9hgm7/i4qfXERqBbvKGwfrnfReICRN0F0NcQCYMLT94SdFX5egVmf2rjGvO4/w5tAJM5OQCQ6XMjQylMDKBcXeW43OpwkyrxIsFtUFd2YjJ9fP7IMocE/H6O3iZP+qbJ8cikAHSKVZ8N51DOaad6tyIv9LBLMOOaGSlPxR7NA4xynfeyOjKcAV7J51mv12zM3iCPCVqpZr+CEKTYavOSiWhkR+096aUHC1YwJBE09VOfXLsO8Rxa30OkNDuprwyw8vAWWKonpVjzAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnECDRz5U+9V4rjBd1hpJEHtcy5koqHSDl9xDlMgtPo=;
 b=fuIqd2HajbnXwf+AaCaZ01JJs9i0wFfkN6H4A6las0NcdwNTsSsqV4gv84YryFlMAG+jEgP/t73lfTosRSRmwMLNVYOi5rltdGh9bhQNM2jlaEGf0cpOIeHev7eLxaVaKKnIvo78oB82MFbm4eIED64aNd08NSF7SPC0luu+vj0=
Received: from BN6PR19CA0102.namprd19.prod.outlook.com (2603:10b6:404:a0::16)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 26 Nov
 2021 19:49:31 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::eb) by BN6PR19CA0102.outlook.office365.com
 (2603:10b6:404:a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:26 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:25 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Enable P010 for DCN3x ASICs
Date: Fri, 26 Nov 2021 14:49:07 -0500
Message-ID: <20211126194922.816835-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a12553b5-549a-40a7-13d9-08d9b115dcc6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4131:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41319523AD2745878B0D81DBF9639@BY5PR12MB4131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/lpAvI4KB+q7paYhlO7HOmXwy5S9sK7hoVciLOIyFC3PRzlWxMDeDN+OevXRQxyd3fvGXtdK/bTJmfPlIb8+rY0zK7SB+/4uf/Q53tx6eitSfeaV+Qy4lspWxWYgLxACOM+DAOXzfCoJNAePqtioVh2ukADxS8jGVgFsRCb6+o4SmzUWEnOYSgSz2GFRy+epVBqy7GxRm6Dsydu3lyKSUq/EaoL1dv0a6VISbZTmuE1KjhX6ZsxuW0/JepX8AP7i1E0PyMjHpJlXcYhiXR4QSQvGrHmJgE49gjvmOpgcLyX5DxSN/WrLFjU6VkwfNixfxoe5VI0ueV+oDYsAaAAf7PX4ujvGqQCImCKgHiCmhFiQ7nfqz/Pjdj05qtue9pMCt94rf5zy81q6O/y9DRcOuaAERY0of281MDx1S855jN7SoeGZFv2aP3Xg5wvgO8LYWx42vuKP1euiODa4htJReuVMQ3qVtuHAtCpAqzqV968W0MXXlxVM7d4zAfhEcVY3QpmcQhgKdG1nh8a7ER+p7C5rUd/tog5uXNIR1n4ztkhiSL/VmRvg+UdwwMnhzVfbmXzmeG3jdBwD7y/C+Et5HDB1MMBfl7ovyG4scbK2b5DPby3B5gb7cjJXEfZUdHsCPZHNe0u/NnkXqbcrB1o2Q4M78BfKaUrMiLz1CiPHTz5lBKACUlD4ch+UmZuepZvKlFd9OcDDRXcqWV8hg9DH6FhfQmKLJaRZhhil0+y6arKHSyk9+VoEyXPMrVHrhjChwU/wXtP7FtpvYFY6u61Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(36860700001)(336012)(186003)(6916009)(508600001)(81166007)(316002)(86362001)(82310400004)(4326008)(70586007)(426003)(54906003)(356005)(83380400001)(47076005)(70206006)(5660300002)(2906002)(36756003)(26005)(1076003)(8936002)(6666004)(8676002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:30.2436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a12553b5-549a-40a7-13d9-08d9b115dcc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why + How]
Enable P010 for SDR video applications.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 79a66e0c4303..d6fb1c93fe77 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -816,7 +816,7 @@ static const struct dc_plane_cap plane_cap = {
 			.argb8888 = true,
 			.nv12 = true,
 			.fp16 = true,
-			.p010 = false,
+			.p010 = true,
 			.ayuv = false,
 	},
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 7abc36a4ff76..907bc4e1978b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -656,7 +656,7 @@ static const struct dc_plane_cap plane_cap = {
 			.argb8888 = true,
 			.nv12 = true,
 			.fp16 = true,
-			.p010 = false,
+			.p010 = true,
 			.ayuv = false,
 	},
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 058f5d71e037..003e95368672 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -276,7 +276,7 @@ static const struct dc_plane_cap plane_cap = {
 				.argb8888 = true,
 				.nv12 = true,
 				.fp16 = true,
-				.p010 = false,
+				.p010 = true,
 				.ayuv = false,
 		},
 		.max_upscale_factor = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 7024aeb0884c..01ba9d656c72 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -254,7 +254,7 @@ static const struct dc_plane_cap plane_cap = {
 				.argb8888 = true,
 				.nv12 = true,
 				.fp16 = true,
-				.p010 = false,
+				.p010 = true,
 				.ayuv = false,
 		},
 		.max_upscale_factor = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6460fab496f6..f5d702148e0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -968,7 +968,7 @@ static const struct dc_plane_cap plane_cap = {
 			.argb8888 = true,
 			.nv12 = true,
 			.fp16 = true,
-			.p010 = false,
+			.p010 = true,
 			.ayuv = false,
 	},
 
-- 
2.25.1

