Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73D6C25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E19F10E3CE;
	Wed, 16 Aug 2023 21:31:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFE610E3CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfLVOdMToj+IE7GFG2VjoW1Ht8uOCHzOaUUQMjVh9A230GoSpm6qW4nVvNQpqW2cVYdK0rAucJPUY3YJjjkJNq8iWrp1BRntXy487YXW+K04O3w2yxZ3Jo6ZKWYZZxcQ8zyK8m0v3/L/2l80ERYsDmeYHggHp5W6BOp1kldYlCL7biJmboNmnZLUry0GVxMSIlqGThdB9r9VGZ0sXjk9QjjbUmLRq1ZYP+76ajNuRHV/r6SgQRvHWMT47O4Mp8zaq1CqxDQ/s60WyPQhBWozq8/u0YwqMCJdPF51k6T3Kx4mS5CGJob5DkAeNzeKERaVoR5eo+bXmtrtbxymH5Co9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOdZjG4kezXJaceo/D0mNK8OTiczxspkdrGBQSWW+7U=;
 b=Pw5my66+UDQkwgqMdbtMn4BSgzS1GrP8dKNqdarqMon+90BZ4XrAt7YzWXPGVbdXjCrPra3Cw+YD2cg8lTk5Sz4HUUYDQKKQ3aKNgrd12u+nhJMCrn0ajdhvuDvHo6Vd+tVj8ufkRCBEZMrXSuomS2hUPZtrWvFD1eJMAxllGJDnr9Lu4KYada6SPf6H1z+bGOBmy7aYuATbf9WaNhI1C5Ch1bwtLYrOql0BtiH9X231nDxu19tvC+pCKuot/kKwwSePCtN6ODjqSAo8X7VAnEwU6QbIRu6ZnxTvRUrS+MWxqV+/IFeRbJJdsaQYmzSX1LL4WQa7B0F6uZeVZuGnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOdZjG4kezXJaceo/D0mNK8OTiczxspkdrGBQSWW+7U=;
 b=TTjD9TG3xICBCDTLhFCPWm0F8H0NGlvPMnVjFoYLMJS/QxMKsSsp0YKFNyF8wakTmXMn/4vUk363cQDPd9Vq84o2PyUevxGEvHaI+3Pdy8F07wkc15qeqRSKMouC0aPud90ETDetYu2ysXoH2qsynV27DJgDIzrR29ckukByrnY=
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 21:31:30 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::8d) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:31:29 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:31:28 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/18] drm/amd/display: Fix writeback_info is not removed
Date: Wed, 16 Aug 2023 15:26:22 -0600
Message-ID: <20230816212626.987519-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: f7233752-81fb-475f-ba93-08db9ea0277a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogkXszq/GPfQd/jBWZ2Ef556qW9tJY3dtmH4nNVztPGy4ivuBRhMQR1cwk5cb5qaII5RAoesFZyokHMPwIWz5JpBxKO3a+KfL9UCbljMcCkKlD70BL8uLQhqvsINnb5UpHhWPrrw/h1Ol0o91UlEzHHzpE/h0FH04m/rtCZ09rppYTRugns8IWdrRuUM2uyFTeJMkp/9NalTUieuBhj0uslkyKYGb3LAxVSLf8pL8Peysg8YBXHCMI8LfOMsTfkZIxoHsLwUoA0ikxGFfXiFdsMP16MtM8Vw5k4bAvrP0WccENdMlXWeXq5zzNlawHoSjz6YZK/WbcI2NRguMysRKhu7wXDZrbJJUrNg6yqclTqCxoAlpYr2u2fRtLKSitazNhror9CHzrf/6aAaq/kjdIjW+2Ykfh5Tp+ZfJo7+UuC2hG3JYfUvdzuIGWOJW0s05hAfsRRPiWf34NajCuL/PETvwzesEifAzn6tRWlzB5aFaDHNKTv23VXyI4XEvWnKK6xpi3SIwhRT3T5s5vmYTzdljOw/D44IARtKGcBSd/BlYE719dyB0HYge/r2kXchuLF64mtBWw1ZVs9CLJzS567zpWBrHvyLsBY0XuepwE/3VFO+S9dIPeSmUUUqPKKh2o6QFzZWMtlAl/cXhJYnClCrb3NPEJ4Xkm1aMpiEKTc0JJ/2U/8GuocUt2Y32AD5lDRioL2F5zX2OCP89NWjpYUVwU8W17FGylM3JcEKY8e/cJxHakA2GEUJ7EHdmQuLLjI9FtiIrEr8vEwlGFBk1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(4744005)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:31:29.6273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7233752-81fb-475f-ba93-08db9ea0277a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
Counter j was not updated to present the num of writeback_info when
writeback pipes are removed.

[HOW]
update j (num of writeback info) under the correct condition.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 5b89df8fccca..0e3ade920c4d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -565,11 +565,12 @@ bool dc_stream_remove_writeback(struct dc *dc,
 			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
 				stream->writeback_info[i].wb_enabled = false;
 
-			if (j < i)
-				/* trim the array */
+			/* trim the array */
+			if (j < i) {
 				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
 						sizeof(struct dc_writeback_info));
-			j++;
+				j++;
+			}
 		}
 	}
 	stream->num_wb_info = j;
-- 
2.41.0

