Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CCBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D6E10E979;
	Fri, 13 May 2022 20:51:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEB910E922
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsnlZjO5I2ZCyYs52IetswzXlAYY/7TEaNkly+H6QK+EhWOpAu8Wr4tWx79VW8Zp/IHv2ISzQzOcTlCNKQX1FrZoeiEbnG14Iuvw/NXM6XYNobWSd7XfGrNhr7uozN/WPBtYHU+7my+WtzD1ckwDSwR4o5oFgHZH3XxAmME6L/z8X3vFIeevsnjiw3DGBezyHKI1LueySDMveaIjISKt5rllFznww6O3H1sfempdTA9PavrPQZgSorhGUI/vqPE/LA65ZaaX29MKXybZemJkVcxz//6/0TuxtcsT2X8ngrmwgxpLiFHNebRVmzdxBa/6dt9mHSkucUkBHTN0cy8HYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWCxgivtBajgjAWyXzTRGFNlmQxkyLFWKQZBX/5raXo=;
 b=W4gA7P6HxhPZcaLtjXyJZtNJ/T4yY+4CHtS+1nB0J94nEYwjBk3FCEc30uKAGFexFaDO6BnoJuWAIRyE3MElnHzdOTshYspzErVsqA3T58kHy60VkFXev4nn2n7Tj8fUA6SF1MfSllyqu0vreMU2vmDX0TSma7pYw3QuLJaNDWmAJ862eLnZw75kY1f0uuqn5AdHoO3mg7TYQFzTB/TIEf+Gv2VuafE2B5y1uonPSHB9yxAqmOnSx66X0gg9l2SEQSWPEaVltHBY4EiqfdSsqGyab00ZQeeb3Owh/7wUldGCdwucMghww4i29njIz998vaDw66XMuCM/3e5swf1WYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWCxgivtBajgjAWyXzTRGFNlmQxkyLFWKQZBX/5raXo=;
 b=hxsJ/IY92tp/XDjqmXDG1XE8Av00dTMCAc6gNkfY12MN+76RFd6LDMHoUk2ulkslF2Z/fdlwtYBvlF3AiddILeNepTumur+XZb+tQTl9kRWmaxWIQPo2QDiMLxsrIVZiinDsmTO77kXhhySJDAFXqpybEOJVwDtqGbM0JxfF7Uo=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 20:51:30 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::9d) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16 via Frontend
 Transport; Fri, 13 May 2022 20:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:30 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:28 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/11] drm/amd/display: Allow individual control of eDP
 hotplug support
Date: Fri, 13 May 2022 16:50:36 -0400
Message-ID: <20220513205041.1311639-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf151fb3-578d-4f4a-127b-08da35225b85
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB50045FF37046466AD1F85875FBCA9@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbBtV5vtpEC6T4a+1XVFBI4x0R8wFCC959VdeLFVvTF8sMCMZiMyS7L0zTzxeniqerRECEgaaeRO1oJk6UlIP6MSakwysnCSjyUqEOrS78ygLcRYV69PTCWy4+JXVtxYPsK12Q0AsagQyAaQQ857oJ1p9UUymeKz0tKp6PI6yYkEE/6A/TYShxArhltu7Z2VsLkEawEF8MVv/0zlLFo+UofGA/Pgjl4s+7HIZHgYIrxj23caUHttxgd2U4pVkQyVArgNfhRneXCEQ8hrRp+2TXNnDals2h8s+j2wTIgpTjEWtWy6mVkMcezum5eed/klj1zzqTR+IhkU9GxVA1aQC0h+vhdzaYKO7wWR2CD2GUBGR3hHJlXxbl7TvqUzkz3ahnEYrJIZq4dIZrWXukJWZzxw2N+rnIGvk+DH1wDxuIWFgSRY+MBIPDHFl4kJlWr+4Et7QWTMVEAlqU5qIVL012MFTXPN6XRs8kDOp7yRuBs9m1yQo2gY2S00OGfOS9JtJMWDhxolwbGUup9U8DKNxeJhst+1F9daHCXzooFh8m+P7rxM3As/6oYH5A5jjY8yelJXJBvsLsBIeSdH1BVxRDAAWwJC8wiAcpwRabGfzjIXxPM3Apk4ADvEEPpIRV3if8s75kYbwgNQYi4jV85Du+Mer/2fMAHpBxWxJklhJrrxjpF+lV5rYmjDKNWPBSp4Qas6bcGZ9VFkgyzDdQ2QLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(2616005)(70586007)(4326008)(44832011)(70206006)(6916009)(82310400005)(16526019)(186003)(426003)(47076005)(5660300002)(336012)(54906003)(6666004)(26005)(356005)(81166007)(86362001)(36756003)(36860700001)(2906002)(83380400001)(8936002)(316002)(40460700003)(1076003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:30.5079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf151fb3-578d-4f4a-127b-08da35225b85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
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
 Derek Lai <Derek.Lai@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Derek Lai <Derek.Lai@amd.com>

[Why]
Second eDP can send display off notification through HPD
but DC isn't hooked up to handle. Some primary eDP panels
will toggle on/off incorrectly if it's enabled generically.

[How]
Extend the debug option to allow individually enabling hotplug
either the first eDP or the second eDP in a dual eDP system.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Derek Lai <Derek.Lai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 21 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b40abd2bf7f6..a789ea8af27f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1605,8 +1605,25 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 		if (link->hpd_gpio) {
 			if (!link->dc->config.allow_edp_hotplug_detection)
 				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-			link->irq_source_hpd_rx =
-					dal_irq_get_rx_source(link->hpd_gpio);
+
+			switch (link->dc->config.allow_edp_hotplug_detection) {
+			case 1: // only the 1st eDP handles hotplug
+				if (link->link_index == 0)
+					link->irq_source_hpd_rx =
+						dal_irq_get_rx_source(link->hpd_gpio);
+				else
+					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+				break;
+			case 2: // only the 2nd eDP handles hotplug
+				if (link->link_index == 1)
+					link->irq_source_hpd_rx =
+						dal_irq_get_rx_source(link->hpd_gpio);
+				else
+					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+				break;
+			default:
+				break;
+			}
 		}
 
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 26c24db8f1da..7cfc04a8ef15 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -329,7 +329,7 @@ struct dc_config {
 	bool disable_dmcu;
 	bool enable_4to1MPC;
 	bool enable_windowed_mpo_odm;
-	bool allow_edp_hotplug_detection;
+	uint32_t allow_edp_hotplug_detection;
 	bool clamp_min_dcfclk;
 	uint64_t vblank_alignment_dto_params;
 	uint8_t  vblank_alignment_max_frame_time_diff;
-- 
2.25.1

