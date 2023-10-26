Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197FEC25B6B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C9510E823;
	Thu, 26 Oct 2023 14:21:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5845810E823
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoEfR5uWtL+UMriGSD5hNAq4p2luQXiNBwn98XhfH0hrH8lvrp4Bc8+IrDXGQW8ZgOdgj18BdZnITiXqaUK5CuCS1GG0MlOBUD+sAWidBY84k6SLjgqmmRsdZbcc48oHcJJbJIUHO39FTYbn2fVL6l3xBGOtuaBgZ8cgxvTzuEHEXeQ4hdwlnwLOJKtyhJ0vRZOPMIqUux/oriHL/pa0fVe8gbh8kFaZAq6AmTZnCOsOQTotckxayVk5sF/j2Qp0Lb5p28vKLOKRzwEfKdETPAlhxBWmqAV+asdGUsQ6v2AKN0GI8nvArAuC+U1o8HZ32pLXupscY3B20/YDmanA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nfmDdaByn3t/5YVUkxMvgAz9rqdtDTv0dTkvkUUKII=;
 b=W1980rCyqvoLzU/GXKtXtXHnqFQXbsjezWhu2ZGawh3y0z0jAUhJyLEKOinkn0OH5yYFdrK9bpxo5pLdQ5O3UQMwZ+kVSicoNlIjOio2itzDzTD0URpSBo6pd4svnTK5J4vUzPCFmFINN2F7gOazAwKFG/tSnZ7I6Ugycm/arHU0sYIXE+//B0We+dPp2sfZs5ene5qSIcEGa5u9fwrBypdBFKBBKfqMsV0ZaiBNaYG6nCAMlLwxdLG1/xZl9yiWDAt7Ub2gexKN2GREWf3tX/aPEsxZGVLhfM3rKkaoLO9dCHMgdz9P6djKNuSksAMiOEXn5LeN3MN6Rt+tEKsw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nfmDdaByn3t/5YVUkxMvgAz9rqdtDTv0dTkvkUUKII=;
 b=4evypNkp7KLIMDAmWa4asPJMOBXv14ZguKflr+3FkB+zogFBvz0uoZQChZcQ1HmSNHRKfs1QSJ7rFinL2QJm2XY7S8D6NJs0yptqd+0iCFGUjcTMFsq5He8wjJTb433EnYaRT1jB1efX/hEX8ko2wUJvWct9LtWtCV9td1D0eaE=
Received: from SA9PR13CA0035.namprd13.prod.outlook.com (2603:10b6:806:22::10)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:20:59 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::d8) by SA9PR13CA0035.outlook.office365.com
 (2603:10b6:806:22::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:55 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:54 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/25] drm/amd/display: Update test link rate DPCD bit field
 to match spec
Date: Thu, 26 Oct 2023 10:20:14 -0400
Message-ID: <20231026142020.67861-20-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9972931d-2b3d-48de-fe25-08dbd62ec674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FX+d4MeWL+IAnVBN8VOvEz2VwGTfl+ZQNzT0naQ3c2M+5EufjsepzwYqII0sFNAGZPSdCnwWLbvLdWcfBFS/Vy8UhpAF76XcW4SNVJgkxLBfBE/j2cI1434YMS3mnwM10gI+8ix6ZY9hT4K8fyXvX0a3nCgE3d+u/57FBs2z+Tdelmtbd/EhbIFmh9BfJ/LZ6LqxEHSHw9pCvAHZ4E3NT7ZNhwNfz0HwHtOJGpPB7JCAo2lZglv9zCxsuJ9xzRbZcjzr1AW1VxWfr9AdvCfnSqQhNCoCp4VXomqD957WVsSbHnx8ztziX9OfF1W7ew8XvCtxqxV7z+Xy56fUiCiIwKjzDSrV46fv8NRaV7RFTkCvi7zkzDytvPgNI0kN2+7kr1o0i7C/I8Qyoknt8XHZbwJ8awAxT6ncedXB0l6ThXI+fD69dTrSR7OFjgRAMe8xGHukzwL5emkppofk3x8Se4hFwUKl8pd5RQIwnrhZkDcrWPONlUhrF+1YiYB+eQgPKoe/6FM4l3wignO8t4xAAaj3FbeNb7WcI4cKVMPVJMQvr6o0tfWcrzqIkgQyKAeJBTNvZvFSOZzhPIGdyHNUQQCbPYu+Ygubsnw3s2UzcXUZRZZskS9zb/FJOywbknMJ+5jDuAv79GBQB7/544ky9sNo5toZFlVIFP1D0459haWyNSISTQkThxcryOCBkOWZuvec/Mr9cnMjdaNkyGZrrR1pcsbpNKbQ+PJooHecH0ktUa48UO5TIcR2KLX1ECqPPwphTvN1SZI3RYS/DLdy+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(478600001)(6666004)(2616005)(70206006)(70586007)(1076003)(316002)(54906003)(36756003)(6916009)(86362001)(47076005)(426003)(36860700001)(336012)(26005)(82740400003)(356005)(83380400001)(81166007)(41300700001)(8676002)(8936002)(4326008)(5660300002)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:58.8827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9972931d-2b3d-48de-fe25-08dbd62ec674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
An SCR was made to the DP2.0 spec that updated the bit field definition
for UHBR13.5 in the test link rate DPCD register.

[How]
Add new translation to match the SCR update. Keep old translation for
backwards compatibility.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h              | 3 ++-
 .../gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 35ae245ef722..eeeeeef4d717 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -142,7 +142,8 @@ enum dp_test_link_rate {
 	DP_TEST_LINK_RATE_HBR3		= 0x1E,
 	DP_TEST_LINK_RATE_UHBR10	= 0x01,
 	DP_TEST_LINK_RATE_UHBR20	= 0x02,
-	DP_TEST_LINK_RATE_UHBR13_5	= 0x03,
+	DP_TEST_LINK_RATE_UHBR13_5_LEGACY	= 0x03, /* For backward compatibility*/
+	DP_TEST_LINK_RATE_UHBR13_5	= 0x04,
 };
 
 struct dc_link_settings {
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 02d1a397ecc9..2d152b68a501 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -53,6 +53,7 @@ static enum dc_link_rate get_link_rate_from_test_link_rate(uint8_t test_rate)
 		return LINK_RATE_UHBR10;
 	case DP_TEST_LINK_RATE_UHBR20:
 		return LINK_RATE_UHBR20;
+	case DP_TEST_LINK_RATE_UHBR13_5_LEGACY:
 	case DP_TEST_LINK_RATE_UHBR13_5:
 		return LINK_RATE_UHBR13_5;
 	default:
@@ -119,6 +120,11 @@ static void dp_test_send_link_training(struct dc_link *link)
 			1);
 	link_settings.link_rate = get_link_rate_from_test_link_rate(test_rate);
 
+	if (link_settings.link_rate == LINK_RATE_UNKNOWN) {
+		DC_LOG_ERROR("%s: Invalid test link rate.", __func__);
+		ASSERT(0);
+	}
+
 	/* Set preferred link settings */
 	link->verified_link_cap.lane_count = link_settings.lane_count;
 	link->verified_link_cap.link_rate = link_settings.link_rate;
@@ -457,7 +463,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			controller_color_space = pipe_ctx->stream_res.test_pattern_params.color_space;
 
 			if (controller_color_space == CONTROLLER_DP_COLOR_SPACE_UDEFINED) {
-				DC_LOG_WARNING("%s: Color space must be defined for test pattern", __func__);
+				DC_LOG_ERROR("%s: Color space must be defined for test pattern", __func__);
 				ASSERT(0);
 			}
 
-- 
2.25.1

