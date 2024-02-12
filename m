Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7D9C4829A
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Feb 2024 03:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB4B10E5AC;
	Mon, 12 Feb 2024 03:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1K/6FplH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18BA110E5AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 03:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjoHzXjyJhD2pLAze3yNY0/+mcRNnNG6bn9ya6014EL/6KYYw/oMlGChGHB79RkArv7ZIjsDVn7hICgduHxxmr8OEjp2jDECCsEPhmKrAjTiFEM/rSXGoeMH/3N1Odq295/UmIx+DxqOi7ILlBpEa+hwY4nWZz8fPmWm1SmDmEZKviiXf7S8nfmBAe0w37dNbofWR2BoT6URViCbFKekMQ/k522uUSwpRIvrHUwOOVTAfJWPtHvFPye7jqzphzwHq9pOE4N8rip/c/6qOIoGpkYDcVqP6yrJXw5eduXwWCq9OzZzD3WHSIavfmcTxA5OZYT+yq8Yd7Y0Dv0GgxT67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpaVUk50riDDElDNLqbxeC5VuPEIpHwxgFeHYACekj0=;
 b=EI4QbCoKUbjeUCLsQL1LUJxJM0Jy0HxtY7ZX1QVFQm/wYM9QZoNb4LHWnK1tpi0pPw7pF7vC8kM8n9F162H7zNYn323eGs2TFcW2BDh3XSJ5yPUfwLTPyI9kj41mC9n/d2d2vFCJfSApputdYZZPRkl1YtyxDTlCE8CQ7DDKryMXbQtK+0lLarHWyySoJDUX9giFqExV+CMn+ow2I3s8NfNtu5gj0ak/ZhOgSetqB3XSU0vZ3gNUIrjilqBR72bPNMRNG3kJgoQ5jNwRIUNQxDPxIFMniUJil58SJql/Z5CwHsAjIykW1w8gGZ3G0SzXZxEiBefIJaTNGCT+jqWasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpaVUk50riDDElDNLqbxeC5VuPEIpHwxgFeHYACekj0=;
 b=1K/6FplHh40BUop40B1cR7wdwI/QkNz57eA22HQNdDzTVFuiCQ4FBT/E/oMwG2oijKPLVaadn8eDEIlaRCW2KWt6tR1Qpz27OYTWBIOxeO+9r+gGO1L/nLy9HNclYl7l82XZJcNVzOZl1YNTPG8BR9keE1uBGFuW/fjivPplklw=
Received: from BL1PR13CA0244.namprd13.prod.outlook.com (2603:10b6:208:2ba::9)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Mon, 12 Feb
 2024 03:34:36 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::9d) by BL1PR13CA0244.outlook.office365.com
 (2603:10b6:208:2ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33 via Frontend
 Transport; Mon, 12 Feb 2024 03:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 12 Feb 2024 03:34:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 11 Feb 2024 21:34:34 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Bhawanpreet Lakha
 <Bhawanpreet.Lakha@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amdgpu/display: Initialize gamma correction mode variable
 in dcn30_get_gamcor_current()
Date: Mon, 12 Feb 2024 09:04:20 +0530
Message-ID: <20240212033420.980477-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: da15bcae-5d9a-4bb4-8b48-08dc2b7b893c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJ8TFdOXwgIn6YPvoJTJP/HjAUocLy7/4K9lK1uoPAxANQp4bcjoxwLfDCjTWMONVthwld4w9DZyPxNG4iA5pHppw3A8LkjdkitBPAL4N7lGggTubopKSprDy34indgPJ00yJmqtlyn0g/woHHVPpYhN6GCz3yH24hKr0xJ7qXIFqQJN8nTDnFhVn1cle/KB/rNr4uEZQgt9K9rqOQV7YQz8BcH/ZHaK6pkrEsEqq0kDlKgi5xf5B7LIXgW7B594ef0NTGoo3hqTua6uyCPjE9SmSOmlvh05ySxD4b97+K/X20d8kMQjSESBK4rq/HdLdVEElP18QV/qxIASp8clqWofVqCnhljwpP31Kwky7dzNY6L1GFTQ9SBBSla/1XyOXMI0UsJN2GH5gP4tzeXIcSUyFhLtNOxCd72iXyXtuABlbeebcNJ+Y9HLsW+IJoLh/bsFkUaHTimwYHR19WJAUsBKdIlcnNdnvOu/1pvR9zdDHW/hezCMu/VjQX6Xt89E4n1NVwMvd3zaxWKVz4WSi1qdUp+z2p3i31DUGxwVh67o4Xc9y1ZyNBYNqmYk65FZJGgzfBN8Kd44xKkaBSXRUisVeT8PelFKmhgIyIWnkAM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(81166007)(82740400003)(356005)(41300700001)(16526019)(86362001)(83380400001)(2906002)(4326008)(5660300002)(426003)(336012)(44832011)(8936002)(70586007)(70206006)(8676002)(110136005)(6636002)(54906003)(1076003)(316002)(26005)(2616005)(36756003)(478600001)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 03:34:36.2717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da15bcae-5d9a-4bb4-8b48-08dc2b7b893c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
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

The dcn30_get_gamcor_current() function is responsible for determining
the current gamma correction mode used by the display controller.
However, the 'mode' variable, which stores the gamma correction mode,
was not initialized before its first usage, leading to an uninitialized
symbol error.

Thus initializes the 'mode' variable with a default value of LUT_BYPASS
before the conditional statements in the function, improves code clarity
and stability, ensuring correct behavior of the
dcn30_get_gamcor_current() function in determining the gamma correction
mode.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dpp_cm.c:77 dpp30_get_gamcor_current() error: uninitialized symbol 'mode'.

Fixes: 03f54d7d3448 ("drm/amd/display: Add DCN3 DPP")
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
index 54ec144f7b81..5276b50cf901 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c
@@ -56,7 +56,7 @@ static void dpp3_enable_cm_block(
 
 static enum dc_lut_mode dpp30_get_gamcor_current(struct dpp *dpp_base)
 {
-	enum dc_lut_mode mode;
+	enum dc_lut_mode mode = LUT_BYPASS;
 	uint32_t state_mode;
 	uint32_t lut_mode;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
-- 
2.34.1

