Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410C8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 16:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A566F10E1F4;
	Thu, 23 Jun 2022 16:41:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D54E10E1A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 16:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHikI3R0lsUsooMet94wzP+3ArU457dekmfSugh77dyXY2LfB2UzjReOIuT6NBZRdxGEQAOFIhs1hGCglQuBFvPhNb4ZFm6QErzdLyqD35kAagIPkidcShRgiPlVpBA/w6w6yXZ1vUzFZ5ruqYNaN+BRvwnBYokJ99dqiHNjKI3MOibFsYshX+ueMT0QzsQCmrxAfFMXQALioflK1CUiKoWXxhbq4zN539qLFz4aKGABmfflkPGCKewJ7H3BRQMiZO44AFdBlW2ye049Tt8UFP5D41VDeqBavFJ0MMhZhLStusrn8/+jTky+0UoSGiZKuBN+Nhuk7pT1pxRR2RStRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrYUt8bGeJ8S2TMRN70BkUapBrJ6+Ubvkquky4H2Fmw=;
 b=K4Tx687PA01W3lxPh6TTZDyBfSayc676WxIL4bg15IjBnv2vw4Bvg7fCI0ey+KYoNCf1Mg9ZO6vEiXzBunDiC/pYrigt5zbGvNrgnhdXaOekqbrx1YIiYiWeY+d/4BURhqps6YRvKHvm7Say1wUXe8f4fUklQXuAs0DWfQKw4eATxAprLX7fIsi5sg/Sv3pu4ONjrWWlPnCvcfbSUMjefwpB2BlE4HlHgEJJstIUh7m3TKKkXceJZxsgsz7Bo2MFrItjDj+LFtLxIjjrAbcihur0v8oN9IrUdcM5pFLY6NIKL5MI3eyVpMZwT+FV0/Bd7ItFCvuFLpqSCxw/+6PzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrYUt8bGeJ8S2TMRN70BkUapBrJ6+Ubvkquky4H2Fmw=;
 b=5BEIy/wSk+UFMdLUVr9Vyq8PmSjvK6FknxYfMfp3o/vuiK2RVQSGvhHlJ6VRkJsULnM9rWsf4+knFYVEpKZm0V05FY+DUuMUPO5Cg6fT7+KhYFfuMa3ho6MnNk47qmMBXbdgLYnmKRDz9BR9YR0tegwo4x8h7fnN4D+1Kxp4Yk8=
Received: from BN6PR12CA0045.namprd12.prod.outlook.com (2603:10b6:405:70::31)
 by MN2PR12MB2895.namprd12.prod.outlook.com (2603:10b6:208:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Thu, 23 Jun
 2022 16:41:32 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::28) by BN6PR12CA0045.outlook.office365.com
 (2603:10b6:405:70::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17 via Frontend
 Transport; Thu, 23 Jun 2022 16:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 16:41:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 23 Jun
 2022 11:41:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/display: drop set but unused variable
Date: Thu, 23 Jun 2022 12:41:12 -0400
Message-ID: <20220623164113.1503249-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef6e1ff3-4306-48cb-1269-08da55373a93
X-MS-TrafficTypeDiagnostic: MN2PR12MB2895:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2LVRiFtmG7X0na4dJX0lz9TNUcHfE8zLXb/97RyvqexYyfNwM3HVMzVm+Y/3PNa6B6bTfxcnUSwugOi8dsJgR3HhbFsz2DfieGn+a5MC2kLtbmEi+XjPYufX/v6UdfeiHRXzN13uowwePLrBJ3xuZ6MkaTRjTr8JnSfh8kZV2o4dsPsH4/2wxIPmBmWxGG5U+7vYeRHsilF6gA1PBqhU6SLUDCSoKmylz0dAFzgm6ywRZEL9rQW41ZkbMwsZUkJ/khmiFTlpFWTqgKx0QLGi0JjrxeVupJsTGc4hnw5gnqVb3n3HWoa+QPlLOhbafEY7JOABPTr24SWhuyBSryJfLfCvG7D+UMdwbvq+tgcK55DQS4Qd0bxKthuu0iR9qJMOUL4DbdUR4DkUKGGurfakf0udQQQ44JMCQ30CTtvmAcQluA36ildNUKmrsOESKjHy9TjuNRUH2rxrqrNydVuq9F17EGorCZKGWwlKhptTHzPY3BTLVIN7FkIHXde4wjcr4xuCDUplpvG+iVihnHEBZnM6N91OpqOKN9SmoNym8MmXqBce/TBsVTJpOGFeYZWlitbnhdbJRUc/qTmI+tiHQMCKzSiTQufQ0OZgdlCX6jxhVPz1K0i0PDg+Gyilm0ICunv0k4g4G3JQsNPPITKX3VBpAKVqSPTNSyhx6wXeYaN+McdmOVVOI86cKWwdWULcTEJlPd7TTmMJHgQxhJHUaK/HkkvU47F1LIhECy5FqftxUuE/e5C2h91nS5rg2NWwTW9ubd3jQPacn/1eLSNUYc043kSmxmdfCuAoyZSqq0WTkQ6HUXTR0cTIsGpQvevFOhRN30CmhdAzZIcHfHAoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(40470700004)(41300700001)(54906003)(6916009)(5660300002)(81166007)(4326008)(82310400005)(36860700001)(7696005)(2616005)(82740400003)(356005)(316002)(478600001)(86362001)(47076005)(1076003)(83380400001)(26005)(16526019)(336012)(2906002)(8676002)(8936002)(186003)(40480700001)(70586007)(426003)(36756003)(40460700003)(6666004)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 16:41:31.9844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6e1ff3-4306-48cb-1269-08da55373a93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2895
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

No longer used so drop it.

Fixes: ec457f837890 ("drm/amd/display: Drop unnecessary detect link code")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1206a3dd746f..86a553757d14 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1022,7 +1022,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 	struct dc_sink *prev_sink = NULL;
 	struct dpcd_caps prev_dpcd_caps;
 	enum dc_connection_type new_connection_type = dc_connection_none;
-	enum dc_connection_type pre_connection_type = dc_connection_none;
 	const uint32_t post_oui_delay = 30; // 30ms
 
 	DC_LOGGER_INIT(link->ctx->logger);
@@ -1059,7 +1058,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 
 	link_disconnect_sink(link);
 	if (new_connection_type != dc_connection_none) {
-		pre_connection_type = link->type;
 		link->type = new_connection_type;
 		link->link_state_valid = false;
 
-- 
2.35.3

