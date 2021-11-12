Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE7AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD8661268
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAD8661268
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21FC6E9AB;
	Fri, 12 Nov 2021 00:55:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 062BE6E9AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqhxjmkCnHhCmczzu2zfa2HFOs+eBfPWHigVj5UKCOMm/Ze1o6nSHw22L4zx8mt1Cq2B/1XWhdXcmJFYZteSWp8Lz6paP2tFEtKNS1HAvwI9okpFTKo23Sy2Wv82GBp8trug43j/ydNEna5hlUx4BYcI9c/eZ+zrLfeyVUhb1POiH75TgN6jtPSbwgV1vtokB/gTz8NtNebGeGWTgh0IwcWRklkxs4zZDIl2cQTxlpFpiMP/XBKCKPTL/TzZST3KkjYw4F2cEIi4ENZeHCV6BK4S6PlP51VyfzMRl8rjvQqRGDmb7mCkH7o8lLPpbksf5j/zLXohm01jGA/Zxz/gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMadjEXuTn5uBwMyPH7JlS+m8L4LurMf86Bke6qiq2g=;
 b=PN/3cZeB10YRM7DeF6Pd7h8hZwlcrFt2G6FOWF8wGKzErykNlPar+YuHuhvpxKd4otO2+yQDYs2xJs5oqgUQkFn4/2Jco67596Jhpr/85zrqKIpGFRHRkFaLlr/ARAghmuVY96k6k9OcjMzm2PScVAUk3v+f57wxSxfaka9nQVK6ZTX2K0sYDyhM5hXXJ2Wnp4ioZHs0JxG49wEC4L6epmShARu1Wtiap7P1DHyYBhpqSA/mfY0e5BiNjP5RZ8MlZJJ2Uy6Lj9RHRBjeoAIUOtDKPLDgPLeaEScZU3J869z8fEQUeulsW54QEH9JuQbv8nKGvyGNOuvzBqs8qO5w9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMadjEXuTn5uBwMyPH7JlS+m8L4LurMf86Bke6qiq2g=;
 b=EtcksD/S32pxJ5atslhOePHiGtLtGTyPcPxaRQC5XNj1J57hjbgdUDxQm4ZhPNSA9XTwHXh4XrhTpmoO05aFmWdaq5lBUmgf/Ofxu1/N5AMntnOfRt9uiA8TpfWGdxn2T1y8H5AO9IR+CuZ6f0kdCDIcc8xELfd80Xn+Z4L9+zI=
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 12 Nov
 2021 00:55:08 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::1e) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:05 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:02 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: Revert changes for MPO underflow
Date: Fri, 12 Nov 2021 08:54:27 +0800
Message-ID: <20211112005438.5505-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9125482b-d653-48ea-6d2f-08d9a5771250
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1747AA833D508CB5D3276893FC959@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwycJgCHwgDORO6DnyHu4p+3cMSAvPZn2NzJHCk3mKRsL/aWii1wSfvqUML147cHGJXRFG6SSjWC46DFAcpfm42i1lGQsJyBTNlPiznMGBgO3teJr+lLc0NJkCVmN68HHg3EbyY8AalUJLpWpF47lK8WE6+6X412VVTaaAGE+5Sy762fo+9efIGwYO3E0GvxQA8VQBSvOE9rFd07jdpX2qqyWV0h13ChAXV4g5Ki5TPbM44Ry9Iqs6zYHe0ldsGho1bQcq7fPaX5YQFxEElGlWcK8O2SmlILjv5teqVYIV5KjnC7/DSl1OZk9gU6CH8LPX4hMfgMxPz7lDdJh0HE+hGoK6rfxF4kFe7XMlkQnvQf89HCZnbFLmD8IILLxjae05Cl27a7m/yRiDXMQ/+iDoZJFLaZNtAtnZSkUqNzs0zdld0xjicKfM1o2X8Bfb1JccvUst9tvv0s8a9UU7hmRpB85pV3H2SCs/GT/K/qIt++ozVFnxWd4lzY5fFDBVpJZ2j1B+NWD3wPdi+4iKPA/tkm9Nk7TrPx1h6Gk6Xj7g87AvWbmWqSB0AZDDs5QlZb+uLfPWSZyWcmRwphJCpr/FptcaTXl32MF2N/ebt6pRiLCzg3favGNEjOXyapai/2FsNNh4JRU1HYZ47pHdJicvcVVXoAD8oibCcOeLiXt/KPvGKPptYAXW62UpYb0OZzUKFWyUixpHFwoujJbaeJuvHUxsY/PJr0UhrNqoqC8Vg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(1076003)(8936002)(8676002)(7696005)(82310400003)(70206006)(508600001)(5660300002)(336012)(36860700001)(356005)(47076005)(83380400001)(4326008)(2906002)(81166007)(70586007)(316002)(36756003)(186003)(426003)(6666004)(6916009)(2616005)(86362001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:07.4848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9125482b-d653-48ea-6d2f-08d9a5771250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
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
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Angus Wang <angus.wang@amd.com>, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Angus Wang <angus.wang@amd.com>

[WHY]
The previous changes for fixing MPO underflow with multiple
display connected caused a regression where the machine runs
into a hang when doing multiple driver pnp with multiple displays
connected

[HOW]
Reverted offending change

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Angus Wang <angus.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 83f5d9aaffcb..3883f918b3bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1069,7 +1069,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 98852b586295..79a66e0c4303 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -840,7 +840,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.timing_trace = false,
 	.clock_trace = true,
 	.disable_pplib_clock_request = true,
-	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+	.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 16e7059393fa..fcf96cf08c76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -211,7 +211,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 87cec14b7870..4a9b64023675 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -193,7 +193,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.25.1

