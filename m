Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC16ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C56F10E83E;
	Wed, 14 Sep 2022 05:17:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFF410E83E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQs1lbeLItASjsvcmwte0BrHTmP9qfSP87RCQnFi59gD+v5lmK4WK4yZkJs7W9TitHA4ewWJDVKLRU1jP8K7M7o3gRdtqInwYfuA0mKe3PPGG49LgC5XwEpn57gHSivs7Zsh8BR9pxbCQxaMa26amW+DTk93NgOUTWcOqkprMgHsuY3ki+T4ER+PINkTeA+AiidPb3BGrdBe6t6tACOrq4OOXUVzf7qJZOpe0fk5wgdEXlDA8Yd4WOXmVv/kxP7+q6m/AZNNFDK1op09e0od3V71AVLiHonrlO6p0b/9e9ywSR9Eo9GWpK8afWes0LZZtFSVLVZeUwzs/8PjRIr2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FkHtfd2bgbh/3aJv2AIFJH+sk0LeCzDdjT9PKfux/M=;
 b=m6eCn5ZRXcYr7OQDq/ltnTaTv/yQ/NhLCOt2eC1KW3cpmTmEol/sN+2kSLzB0oX3KuIwsrLFItOlCP2z2Z2neJsHwxtmmy1DE0umXf5eRo4l38pcnnMP5NsCSltjhh2vtP7ZmzwGXZPtxDEECtvHLET5rjNeXLhqevFFVV2KiF8oJARTAodTBS1QRqNVHlZizNB/Gy0v//I90a2hYlfCPoz9CAbrQrzxl/6ODW6qwfENiUAkS1arPGAcWJi/LG+c0t8dUARU66T6Uv2RXD8ngFe0B9dr6IMVFli2cNUJQhHvQXN65SW2yLyiH+Zq57eMGuRA+G03fE1bNlHpI8AtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FkHtfd2bgbh/3aJv2AIFJH+sk0LeCzDdjT9PKfux/M=;
 b=LN81dykMYJ2MSrikh+19yeZsMM4ps6S1WRVoFbFCJ7p7XRYXMBV8Tq4lqc4PPi4ecTfTsSuXmV4g95IvuerCwI+ncvwoDgfnt4T+XINeI+t/2WHLr/wR5jC8RyFMQVze7c0lVnyqSEFYkUQqhl7YjUPZcNP9MtbkXxbG0lTxN3I=
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:17:23 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::18) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6 via Frontend
 Transport; Wed, 14 Sep 2022 05:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:17:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:17:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:15:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 30/47] drm/amd/display: Fix DP MST timeslot issue when
 fallback happened
Date: Wed, 14 Sep 2022 13:10:29 +0800
Message-ID: <20220914051046.1131186-31-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: bff0bcff-a739-4b63-6d3e-08da961067c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNT1xnlB3qfdIwFQqKAtARUmjHVkwxrSu0rW0qL0orEtgLARtLUSZRGJp5OdhqW1FWvk9BC20/CCcrtahNAKCNsrO0FmIthv5bF77rjiQZRIs/uFO1cux//S7cx9/BH/YkQZdGaITueYUkW7KNYKDrhvDGc5lxZzIDNkLEnJfNxLJgPpQztf57jjQEB42H8c+vvBaSGylWbfl93l0xfIw/gbos10KOhWEoszNoiNmZIhvix++dp6vIlTGtizhuY/lPFV3THsh4lkCE8DCyA4VKk6HZhee4d/pJKlKkgu6eDJHrMvqaOUvey97E6uzAnCg0p+4ACg4jgb0jylqP4cECrkPfKe7zOg2CSK99eMu4SBWKyxi81AcU7jR0ldUgINhAd8OW/er7SFA1Hw4jDzgZ3rAkjRMrz+MAbxtw5EqeWNkfTz9gYDPbTAEEiZ7D9mqUpu7KPIGhUFwB8dXFvCE6Tui67foR36zEulpSRcFHaxVFsuw+IKVmbW4kHJY3eNQc5tzkm+gD8tyPTXHg0Z+coXP/bkKFNTYJ7hPbPWNu+YuWCJXDaFCAatGcqnIludRJaObTkV6SQAtjyaaeA2pccTn5+2iztUgX9LFrX94nfj12tqfAwwtXcFm+JgljF5fZ9ZQD0QiK/F3l+pX08+ayJSu+MdelvBYdtbuEn6fbaDcpBQl6Z+DU884HdxfEAu6DNzbO/MkMULNL5pDn0QVRyx2MHHnIequsM3dwnirdEz8yCjs9IPGTK3k2mK8zATKM+1adsod0LFuerSo6uOrkVmIUYnnzQMA3rrmEI0/XI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(2906002)(5660300002)(426003)(86362001)(6666004)(8676002)(478600001)(356005)(316002)(40460700003)(81166007)(26005)(4326008)(54906003)(40480700001)(8936002)(82740400003)(186003)(1076003)(41300700001)(70206006)(83380400001)(70586007)(47076005)(36756003)(82310400005)(336012)(7696005)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:17:22.8753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff0bcff-a739-4b63-6d3e-08da961067c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Cruise Hung <Cruise.Hung@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <Cruise.Hung@amd.com>

[Why]
When USB4 DP link training failed and fell back to lower link rate,
the time slot calculation uses the verified_link_cap.
And the verified_link_cap was not updated to the new one.
It caused the wrong VC payload time-slot was allocated.

[How]
Updated verified_link_cap with the new one from cur_link_settings
after the LT completes successfully.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index f317e48c2721..3118e6f808f0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2758,8 +2758,14 @@ bool perform_link_training_with_retries(
 						skip_video_pattern);
 
 				/* Transmit idle pattern once training successful. */
-				if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low)
+				if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low) {
 					dp_set_hw_test_pattern(link, &pipe_ctx->link_res, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
+					/* Update verified link settings to current one
+					 * Because DPIA LT might fallback to lower link setting.
+					 */
+					link->verified_link_cap.link_rate = link->cur_link_settings.link_rate;
+					link->verified_link_cap.lane_count = link->cur_link_settings.lane_count;
+				}
 			} else {
 				status = dc_link_dp_perform_link_training(link,
 						&pipe_ctx->link_res,
-- 
2.37.3

