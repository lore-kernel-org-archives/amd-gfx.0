Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FD3C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 13:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED0310E7E6;
	Thu, 18 Jan 2024 13:55:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F235110E7E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 13:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/IXwh+Exn4vQR16Tkg5jgaSgnsFyatoDgVf4bBcJetoJmRZfm4XwOw6Gu6lvxc/cnV42K86RXmdr7qNOPbUwG1Ww9giFjoQgTv8RlTGXbKa1T5/p98PyS/mAtQCphkAsxbnF4UHEbcmkkjzWIHqIzz5WAz1fTlXhQ43smhrR7ikBQkCw0Nz1jLAeqniCq/46TItPa3VMarUIqHH0bMFvm2qiwHG5xAEbG3B57OZUzr9N6cUeo/znV9MyPuS6HNFMMgAStIw9399PB3PQqlULq4VEv7sOQAiVxkAUHxGXmRMnLjQ47E5cLWARujdJQ7eh0cMU3t5blLykXWmAUYs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlWje2+5suV6+WyoYIL4goLx/6ScmHrQL4kqDR/nT3Q=;
 b=nXgSkbOOBBdpCKzLeqNd72HLNolbSsbTzkBGwWAOewXRo/XTO2YCnt+ac6F2cvhhk5JylubZxNZUMQgZdam3wpyq2yUcmHBr5WALtfUPJrDcRpeTDbZ4BFcwenaoZ3mmnxQrAT+Hu68UC9tQTeS+NM+onkbUf8RDEcekSg/XGubFttN0NVkL9w2Fe5UZXjU0T+eU9RXwfvL+1NtOEpVu+A1mPBgvjDQ0RPxlJKsJx4AidYmM+FBe/xXbSRCE7stmaV4qXDEavW6NpmVel3c6/Tw+N+4JxUQWtZJbYUFpJ7X/dBJd3hVPggwM5OiIE2kM3NO9kNZkCbQu8QLB3N8taQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlWje2+5suV6+WyoYIL4goLx/6ScmHrQL4kqDR/nT3Q=;
 b=dH3gKOS0pzEc+GFfdh7DSP3DeP5uoWq/qCqLGGnIHLRg0/BwZk40QRothW82Hg1F7xZaZ03Nyp9V7KK/xntWXXXQQd4MXau4nhGoYprTpj3KPIBianeWCvmMaVskw1USXsVUXQrzBgv0eSB7A9c+TBoWq2rMDGnEbZheCY56EIs=
Received: from MN2PR20CA0035.namprd20.prod.outlook.com (2603:10b6:208:e8::48)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 13:55:35 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::e3) by MN2PR20CA0035.outlook.office365.com
 (2603:10b6:208:e8::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 13:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 13:55:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 18 Jan 2024 07:55:27 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Drop kdoc markers for some Panel Replay
 functions
Date: Thu, 18 Jan 2024 19:24:59 +0530
Message-ID: <20240118135459.585306-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fb4557-3636-426d-734f-08dc182d2498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSoQ7QP1JNjnkuvTwj9vv3RODTO8aViHJNzaBtDTYq00kRU2bTIescDMp9ZFf8KAZswHhMTeXK1dNlFIYpDKHuwrT8AKlX6wuAyaM5/hFcfMfmKoWP5ovEO4n+NFLhIzcesEr2AU4ucZeUg0h9VNnjuSpdYTR++G1qo/p2+1DCdWQ/BE9m5Sid6bIxNBVs0+EzUQ62hzIpTv16AOoNP3uJA0bCcEETU9kkXrPHVefBC1330A2fdCbIj1SOJzksUxCJoH6XJwvZXix5eyNhZWo5/RBNIMuQ0qz1DnRXRB8XqtOrWapXgd8+dWnaSSm3dNaS3invJ4nQMDVyMYd5ve75ScpPO5YoLoScM6M8qUKqf2P8834fYz2Re2H3OsJ8l+2CffSJ4K6itwdpMQBNinuTnm6YSogFfFLonnt600+vmX8a2nA8uSLJAY6PDDhIOzr9BKSXi4BkXuUaWcNg3LWvZo7xcIWWGLADDoPTV2P1yAOSN7eAYnd6Ko8TngxFtN+CDJr5D2v6oUXSQWmtKGn60D5Kmel6hTFdlkj1B3VVZFZPMTdW1vqI4UbK8olQe7DARvN7+ougFhdAPEqrDtLlzqit1qqAuzPApYdwpbl+YfflCPSzNMPor6P31TeSms68FKJf+FsXOI85OusYj+0kScRV4UXdKu5vuTCr8L3zr8T9oDhzy51HcHEFs3poeIPGaQ+qavDzgvDy2FHw4B7Cv4AYiv3scAuAbX5pZTWCgKntqCBjVK5YtZ7OaGdoaEE2XEeB9WYiMQLjuWsP+jxdAcIwFVfEpdPYGKeRtYJlFbfh1P+nrBppO6PzwouZOA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(2906002)(36756003)(36860700001)(41300700001)(86362001)(81166007)(356005)(82740400003)(110136005)(6636002)(316002)(70586007)(54906003)(70206006)(6666004)(7696005)(478600001)(8936002)(8676002)(26005)(4326008)(336012)(5660300002)(47076005)(83380400001)(1076003)(2616005)(426003)(16526019)(44832011)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 13:55:34.5864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fb4557-3636-426d-734f-08dc182d2498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below gcc with W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_replay.c:262: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Set REPLAY power optimization flags and coasting vtotal.
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_replay.c:284: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * send Replay general cmd to DMUB.

Fixes: 340b072e38d3 ("drm/amd/display: Add some functions for Panel Replay")
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 38e4797e9476..b010814706fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -258,7 +258,7 @@ static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
 		*residency = 0;
 }
 
-/**
+/*
  * Set REPLAY power optimization flags and coasting vtotal.
  */
 static void dmub_replay_set_power_opt_and_coasting_vtotal(struct dmub_replay *dmub,
@@ -280,7 +280,7 @@ static void dmub_replay_set_power_opt_and_coasting_vtotal(struct dmub_replay *dm
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-/**
+/*
  * send Replay general cmd to DMUB.
  */
 static void dmub_replay_send_cmd(struct dmub_replay *dmub,
-- 
2.34.1

