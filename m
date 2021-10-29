Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BD8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF5B61165
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7FF5B61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BC26E12A;
	Fri, 29 Oct 2021 15:15:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2538E6E12A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFUNHZWnI0H5GsLdvGncVgUwlVI4prN2hrB+3JP1YWBRV5d1Kh3eeAe7ILf58Ps12T0N5Sd42zl9y2I5KCC+s/HdHhDdMgQdeD9Gc3YloVlKqjQq49jlJJKVZ3DRCLqzzF1bJnJ/Qx0MILT1T6kYewptmPXZPpXaWmaD9ageKEgXQ3dsd28Hc39rWGrG2Jmzs8GBJwjo1H+Wi3kYTsbb4Fb3PJoO73qnsev1IXAACu0wX1sewknbi7wtxb3frgY7/KByp2wZc8rxqjPm8qIT4hTmPv5I0TsTiZcOKTG7SzTQFyxEAAPftA0hQ2VKj7lj7UPqcskqQOxTvGGxdHztyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8w8OxlA1T0DIhhyLiOoSoiFGtrQpV+H1O1mMJ4MTsl8=;
 b=Oom67nq51w/vohH9Z3dBaqMFj6xIuAeB4eA/A9+v3yvo65ETCLe/VL+GJg23TSwDFZnGpZjVRTc1icgin7cd/qeOvT83JXnEdRWRdioTixs4XwcYyKofkjRRZrGw3yWAnmcQL3995S0YIPl8PqD0IDyzx5frmRhTW7jWkHvNiUKvUkHC4q9nRoZ8vJ1ZeqwwpSn/Heg5bEB86IzCL6Vm+OXiRc+tVrYihQXNNqC29qq7PhS3N03nrl+oc3akfqG5v2yjDz48QkL30bVgupnJO60j63g+40S4vvEFE0LMU7iIA1eHtQYU7MgLXDAa2g3HP7ta7+KoXbBRhDpDiFp3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w8OxlA1T0DIhhyLiOoSoiFGtrQpV+H1O1mMJ4MTsl8=;
 b=QBE9Sk89p8L/V08j0oRTzXkqj1U5l/Z3HSDs/bCtPPyWaNZWMH64aT4McW0jrbt2Mj7L1/19FHCBeLCW3S3MEF0/xSMMHOPNEZ6SZ8xXS7jmJfv7ATtq6Q8A3R+ccnRAlOmeRNd16E/tUIHwMWg/mZCOb1GAyxeWyJJWEBj2bQY=
Received: from BN9PR03CA0147.namprd03.prod.outlook.com (2603:10b6:408:fe::32)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 15:15:08 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::b0) by BN9PR03CA0147.outlook.office365.com
 (2603:10b6:408:fe::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:15:05 -0700
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>
Subject: [PATCH 02/14] drm/amd/display: Fix dcn10_log_hubp_states printf
 format string
Date: Fri, 29 Oct 2021 11:14:44 -0400
Message-ID: <20211029151456.955294-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a84aae-da98-4ef5-a280-08d99aeee52b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4166:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41668D64A63865DB45F957CB8B879@CH2PR12MB4166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzZpeeH5FwPrTInr7PwryVlTWrZKy2Yn6+p9wp5cBNgn6urNxvT/ONy0m6T5MQfr1hcTz59AMPR0snkOSQwvhFjJ29PVaqGTZ6OPuoP7gzBbnGfhSpVzLNM1WOpLzWCmFoNO52sgB3OCFuW7V9x6FfGKoeI6RV8xaM0E4UeSFih7e4876+ZvP2QdK0iGdkel3+4+JL15uJhzWbv2YYhHhFxX4OUqisy+zAycQ7hdW7ugieyzSXT7aT3aSsZMEEaw+zd0eS7gPmHXsue05e267XsRsH4W9VMF+bR6cXafjiaLMHYR5UvNliYWIchF05QqCIwCAFzex9teO/x4WTEQESjG1Q+b9i9sBxj8VQBIXBUV4K3S7wChCDnQp2N9xQUYrvuLAN8Zl1w9rV3kDZGMt84uBSoP+dnWwEcJZFFIYkP/bmExirG+YYKCAsXJaF4n4rdmph216qUA2WVQaeo2S9vKOl2XeW8WR+jGTlf7bBI4evMlpZHV6Ir29OzKDaSVGWaH1bFW9iqRLQbAvriiD6syKmCJENaGofw/v01v/YRigRfbi7rybdAU5lrJiUWE3Dp6IQvs0PinwTu75jWAzjOyufZ4tm9txo0HDosVS+uYvD2e1vBuGr8Envruk/7ojhgprmGziZfQ6uvHDeauXN9AoDu4Eqm6qT77kGm5K7KK4qtguy2rJlcf/hfluUFmm4tpvs5tomkROfkfKHWum//LTT0z46el0dsnATdTsVk9pKrLqd0WEGg6MTYjva2klr5Yhv5eY2AP5trH52m8PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(26005)(316002)(356005)(508600001)(86362001)(186003)(8936002)(336012)(2906002)(82310400003)(6916009)(81166007)(54906003)(47076005)(4326008)(70586007)(426003)(5660300002)(70206006)(36860700001)(36756003)(44832011)(1076003)(2616005)(8676002)(83380400001)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:08.6952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a84aae-da98-4ef5-a280-08d99aeee52b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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

From: Anson Jacob <Anson.Jacob@amd.com>

Fix spacing issue for the format string.

Addresses-Coverity-ID: 1446765: ("Invalid printf format string")

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index a25732d07222..0b788d794fb3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -231,7 +231,7 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 
 		if (!s->blank_en)
 			DTN_INFO("[%2d]:  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh"
-				"%  8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh"
+				"  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh"
 				"  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh  %8xh\n",
 				pool->hubps[i]->inst, dlg_regs->refcyc_h_blank_end, dlg_regs->dlg_vblank_end, dlg_regs->min_dst_y_next_start,
 				dlg_regs->refcyc_per_htotal, dlg_regs->refcyc_x_after_scaler, dlg_regs->dst_y_after_scaler,
-- 
2.30.2

