Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007CCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 14:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A4511B9DA;
	Wed,  6 Jul 2022 14:09:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B06E11B9D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 14:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Amyeiziq5OGHt14BgATzMc3HRTbBp8FdU0fW8QYnhG0LowekD2X5xbL8CXAu+k2pIyOHUyq815bqioR2uSECXTiCmne2gZpo2/NdJnTE6pZwey0baNDQbg7+bnjnBLOoV6Z901gTJFVK5trXyWEGex9OhzPPH+PLeS56FFlUK+cB0SYesN8nE3swstYfmJ5rtWPybEKmIqY8DhzEkIKvJ2NTF6DPRyStoH4E5ob5/yZAkBUnhg2iysn0MdI5G3wqyWX8SM4roO8rmUbQM75MAVyEbZX0j3IAp1s2sp6RlNE52XBRNLyTGJvXIj1lHww3CVSaOl9J8wcEScQgsAsyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbxbpfzz6GdqrifEq5SlfJlfH8oOeAnGxnk8Xt93gzk=;
 b=UnizoCpUfLmBXTuIdF6M8x7NxJFp6IyIKX9oMFcIK071JO6hW3jQ28SwnOL0P2okhUUhDTtKHFP8G89k0wsr1NJ6/trF8FiMR8nT8U1UhuC0htGzMwRP2zvOrFrk5kwU28rD7S3EFXMoPm1jeAGO7iWDTMEj7t1xDYMvbh07nOH3+9SF0ygPhlHAKqrHzAQNMoUXd2pfknWCBIhty9Tb0sf/917RLMSy5pYD0LYo5R4XVIQonSmu7DJ5qpTCp4c8ITnCgh2ZKtEiOtvOZgZeDGR+OkRDieWZdiU7cZ2P0B1PKb3Y4DTGY7D5yImm5iqdfXPqJujFNHV9smlYPbrqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbxbpfzz6GdqrifEq5SlfJlfH8oOeAnGxnk8Xt93gzk=;
 b=JHKnbVJ9tKLpfkIJRXa+8jR+LfTTImzVvU6zhe1V0ptcelEY6EOKEHBO8xjr/Di6MULcs2xymBBvfKbO7cvqQrLAZyhKfPQY3bNUAeGA+oxVsEageVZpSlDc62FtZPkl2nnEvevK+FU+rZJ6z/ZDqXY1EbmJrzTDk3SaN+QQDgI=
Received: from BN9PR03CA0548.namprd03.prod.outlook.com (2603:10b6:408:138::13)
 by MN2PR12MB3069.namprd12.prod.outlook.com (2603:10b6:208:c4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 14:09:00 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138::4) by BN9PR03CA0548.outlook.office365.com
 (2603:10b6:408:138::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 14:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 14:08:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 09:08:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: remove set but unused variable
Date: Wed, 6 Jul 2022 10:08:41 -0400
Message-ID: <20220706140842.116064-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c95a876-bd75-42f6-0c20-08da5f5912bc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3069:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyovkXtpu7tgH7nwDLh+2hyO7w1KqiVxi48vgpUy+FJ5OMMQfHp5k7xDiMs91rmti6hgGPeD5qG7TYCn8e+jn2CViBjJBCHcTsCHVhou/GYjCFJB54QDQRx6lnifREs0Abu1PZBPfbFan3XiHXaSEE+R/I+02b4FoUN8HBILEUXHESPOzlLCUgPcfzJwrYtBdP91uH5DrK/XwYBFish/jH450FKXj0sd3mBMeARu/6sAHcRrGQ7sZs34IO0gGrOAlLTMzZThSNgcLsd7QMuLehmi/glXn8lixvTc7dVwC5p8qUqx8yY9jGAJDsCi3Ol8GshMBu4SW0Bu/BHM+wg/dfI16G9nl5gsvb5JS8n3ILxkhFl68EjYpHDil1N2g2TMqCvGuZzEg4AENxZLa6gsvnouCLhgxyi1aHGsGzkdRERu7axKfiA+CNFaP2TpwTnlO7GUBcv/aXjGYUBgDDRbP1DB/zBJsMg/mnAvaLyif5wMyfEwWK87o8z4z1UGTeC/lCsdFiK9TyYQorJw8RS7Dqhv8bdUSPSuCz9ve6bosRM8cwGERXdXbCCp3QB9zMRXpYHGayeiU9OPsBTBpHpIuBRfAGQ+L4hI4PRiemIaeFWoRd3cCdo0shECaHydeOGa+KXRx3Td6ifxrP+AxzmG5Q5zp9CeVT+g3CC3TzCq3P0LjTbXtRP3The2C1lr8QDjRErtAWqEjVaBNETZ43+7SimnhXbm/IcJon0PFvp9uwhI+/hY+aVMNOXp/3dxsqE7DZps/41j5O/SKzaAx/YK0l1W2f8K8aeSsr28MiH9DNN1yGBI6XA9HxMDGSL8BRurwA56fm8oA1527WU5ko+XM3Ia8MDcmauRUEzvnpYd6UeeiNKJb7+OWet8MwSx4aRJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(54906003)(316002)(2616005)(26005)(6666004)(7696005)(1076003)(186003)(16526019)(36756003)(6916009)(478600001)(34020700004)(2906002)(86362001)(356005)(8936002)(5660300002)(8676002)(4326008)(82310400005)(70586007)(70206006)(41300700001)(426003)(47076005)(336012)(83380400001)(40480700001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:08:59.6607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c95a876-bd75-42f6-0c20-08da5f5912bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:428:33: warning: variable 'old_pipe' set but not used

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index baaeaaff23df..3f42df525c0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -425,11 +425,10 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
 	bool subvp_immediate_flip = false;
 	bool subvp_in_use = false;
 	bool drr_pipe = false;
-	struct pipe_ctx *pipe, *old_pipe;
+	struct pipe_ctx *pipe;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		pipe = &context->res_ctx.pipe_ctx[i];
-		old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->stream && pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 			subvp_in_use = true;
-- 
2.35.3

