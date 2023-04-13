Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9528C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 19:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647C810EBFD;
	Thu, 13 Apr 2023 19:58:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0993310EBFD
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 19:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdojg4dNobjxnxEOGt5jgtXR8/AGENrV1EgyImo/AOCXrrPSHTY5jqtzTPQF+GlTxVCPkFIUIDu3b6cIMeh4YkOAa1C+SOGVQDQgF+r9cY5d4cgK+/PQJUuEiPxd8yxfo+K9oqtKMVCtiofNspSOYxLb9K0ghroWgsVebWSoCqu7e5lvUu4ZOyU9iPjIB6lVcln0RYxf/Pi8jH8S8U0zoFMouZxGNT95AO5mRicGkD7DsbdTz6v/mfU2panvPsAW1NP+HrOvj/Wpj6DBXpqVU+wAKRftNTZhb/SzXlm7Lei1YsgWuIi+HFXO8VAWIQzAPwYzcxaX8kpvVe3D5zMxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9anMiQTEeGKE6EycCQpmSMRAX25vmAXpuooTHndoXEk=;
 b=glP1iOl/C31YBkROFzw35v5EG56HqwvsgNcU5tTCSxRq3FVbkO8KCUR2zjzb+M7wxyKPIgNzBZfyN7O9MuyIpvJnloHXGbC3F3kkXox4oaMKABQTlgEgOGnwQwnSqdRBAvaz1ECVmFuqYHJY3H4pyfffWY6QLjzkET7wgRJc6ZfSztJ9NwdSS5gChKqlBLqa+1F9NDGhaIqNsj50Yt57Z6JcyNAdZR9V96OuJ7V5Oy3S+ICSLFZlynI3JGndhpiDjEmfki7RS0rqAFl5v4JZB4mh8h9n80xGaLWvSKLR5d/p9qZ3C9GJIsumRJYWqy8SsQxJ41tAy89eK6ruAhrDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9anMiQTEeGKE6EycCQpmSMRAX25vmAXpuooTHndoXEk=;
 b=Wq9xnTkBv+TjlnucKV0nr52AfuDxqZ3YTYEpp3LyIZpDW8lB+oH/f0m07qcgOI5jE4LqZ7fIMHlSW3ySFlRPgn8XtRy0MNKxb9TTB+bDKRQqDS59LpFn9WsMLx5xxXFJ0/DubWK6M4KyZ8lOXF4xsMGXANW6NvzUOrUYcKEllxI=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Thu, 13 Apr 2023 19:58:02 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::8) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 19:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Thu, 13 Apr 2023 19:58:02 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 14:58:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Add logging when DP link training Clock
 recovery is Successful
Date: Fri, 14 Apr 2023 01:27:46 +0530
Message-ID: <20230413195746.2369084-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|CH0PR12MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: a34ba84d-7ea1-49ac-16a2-08db3c5963d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVY90bMjaB6xuzUNl3Oa6Fd4As4eDostAeyIPv+yr26ulN+jTB2Etrp1GOmImMBs/TW15OLbVD77hHo18/2vUApSrHGeb2vjKE4kb3ch2fMSXBro4FhiQWjZlpfP/AGZ0eQSAbmxyI7JzptFSH4PQ6GGVC0ZBrg6/XiPUW4hpzBwZ8yOvkF7uU46jxv56/F4zbeghesFx+GcjgdG401A0KzgO4hKu01jSl+hgdzieK++qOnyGLTNYPf3K3+zZAqI7rB6UXHltKSjAiTfE71upIuEEL/6Ai2fOgW7V3DG2VNv6lc3b9OtWN3DXr3JOfenrw3Aqm8/dqcg6ALeu3fGMIxK63koHAiCoZJ6/BAj97oL6tfmsHDiwOKJPOtzkVTlWmTQK9ozo2B4w5Yi2SLWoSmTbseM512CL7xsHN1+lgvzYBaL2iGFIjjzad/fItYKR+p4YaGGB1+sDzvb4pPj1hmbHZUhXHjcHYUVY7iWULJ4J3AsHZIPQK5FqGsEnmxQx0rx+M6PmbCWsnjU+mf0ed9aw3a57e5TPOG8/UppzSD323jzz4Xj4r+6Xk1m1MKCdwZPHaWQujmHjcvySqj5vEVmSkzpUTyBxnRfKahHEBRFg3QKLs1Z5UyOsL/eH7HXeToafM0Se2m6dpVy02xBoyCmBlKRomkQRppsF3WtUcPfGkB801hhBz9Z+qa8hZkaqWP51sF6gBaMO6pdu69Q6k7yhn6ZATAupQnjBTM/EVg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(5660300002)(44832011)(2906002)(316002)(8936002)(86362001)(40480700001)(40460700003)(8676002)(81166007)(356005)(41300700001)(4326008)(82740400003)(82310400005)(70586007)(336012)(426003)(70206006)(83380400001)(6636002)(47076005)(2616005)(110136005)(26005)(1076003)(7696005)(16526019)(54906003)(186003)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 19:58:02.7137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a34ba84d-7ea1-49ac-16a2-08db3c5963d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Log when Clock recovery is successful, as part of
DP link training process.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_training_8b_10b.c   | 4 +++-
 .../drm/amd/display/dc/link/protocols/link_dp_training_dpia.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
index 41b38da9feb4..8ac4e879032c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
@@ -225,8 +225,10 @@ enum link_training_result perform_8b_10b_clock_recovery_sequence(
 				offset);
 
 		/* 5. check CR done*/
-		if (dp_is_cr_done(lane_count, dpcd_lane_status))
+		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
+			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
 			return LINK_TRAINING_SUCCESS;
+		}
 
 		/* 6. max VS reached*/
 		if ((link_dp_get_encoding_format(&lt_settings->link_settings) ==
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index ab4aafdb5e5c..4f4e899e5c46 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -401,6 +401,7 @@ static enum link_training_result dpia_training_cr_non_transparent(
 
 		/* Check if clock recovery successful. */
 		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
+			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
 			result = LINK_TRAINING_SUCCESS;
 			break;
 		}
@@ -508,6 +509,7 @@ static enum link_training_result dpia_training_cr_transparent(
 
 		/* Check if clock recovery successful. */
 		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
+			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
 			result = LINK_TRAINING_SUCCESS;
 			break;
 		}
-- 
2.25.1

