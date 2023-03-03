Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844F2C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B0510E6DC;
	Fri,  3 Mar 2023 15:49:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1583010E6DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkKcHtnY4lRcEA9IAXxQjqwyEkvgjqC5f1iCWjfter02HmqzPUj14JB6sfic2jfxKYHD6yPXcGJKhr6XcGODV3tgUL6k4lJgsOthd+wiqN7YhJr2CxZpFWxaSJLY44CEUXGAHe023eEeki3aJJ/L+Lr1/RzZT6NqVH72FMt5bAXUmRofGdnQ6yIkQb8/t6tLp420kFxr+dIfF2VVoAR98HrJcQQvNcMeE6vf9gHVduWxUNATdXnnKAwqCPfk6kK+xp9adfeetIumxXxyo7i8cbFtLG3d9B4J7jz05QQuxy2nlPsGP6Y04rJnh7nAG5N4yXtMxXuEX6FVkCyh2EvI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+1RpWLzcxmrroqADDy2KBHNTeF7gfJZY3YI4scoIGA=;
 b=NcAPhrWDTAN5TZOJ3fM1H2/MjPTYmyyO+R6LCZKFf704ANx/kjDLFUYWwKVYU+D6nc4KQ4glDuM4ar41Mkvp2HEHeL9qhv1sfsW7FDSodLTNtuk6dx85MwLJ8VvQE1/vfTCUmc0iITgGFEW8qXovbjmcS6Yq+1xJ3v5SFzTOIVURL91xgpGKAifRWhC9q4A/EN/5x1n2k4C5kCVNEoWfCOs6OEsnhwq/2ULN9Egzg9d9XRFLAa8E6lvSIY1YYb2A3TUWuG3VXLzHMXOXr2Dkm8oany8ydgUTHx4jk7gyrfmTXG8nGop7quOVZtx/JlmUsj4w3kn4STzwSOHJFqRtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+1RpWLzcxmrroqADDy2KBHNTeF7gfJZY3YI4scoIGA=;
 b=fWinhIJdNjW5YCWxyBgmP4iobl5RvRnZGsAWTu5o7xrAfMTkG9A7io69yQJNUvYJYrCOAZ0xXO1s0XMJIKReRnUiM4SHa8/Xwxz71/gY3BWl6XLxICrB3dNndLJkx/EKVvYbspx+yjvxL3EuCmWHjpRHEyegv5WyQzrVc+9krz4=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 15:49:51 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::40) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6 via Frontend
 Transport; Fri, 3 Mar 2023 15:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:49:51 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:49:35 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/33] drm/amd/display: Keep PHY active for dp config
Date: Fri, 3 Mar 2023 10:40:08 -0500
Message-ID: <20230303154022.2667-20-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 336919a2-65e7-4b0c-3e4b-08db1bfeecfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OW/8cqDvTDR7HnHXHmQTu4m70u0tC5cpUZorThNejzpwAQOom4pnZJLmFEY0c3Rs/dKCTWgsVeYyB3g4A2seLhWt1TyoDt4kx/i5gt6tyEdEcIRWTUIPQfXalKgtic1/3WdjT9qFowemoAo2nGqyoOBezL62LMlryfplhbTFtFBLcixnnl+tc4bIwFFsd9eHASe1GXKR20JA0LRCzn/N8oms6/BsyG/lBZwpJW+p1x8SS0+IStHRTFfdsewJrOUejm3lbO65e6+BPfjEyH0AkA+F7Al6/6Q34GyjIn8/qF+ICe7MbkVK/nrRjBk8em0uWvZA74GcHlde/gkNhE+48Qax1COq2AjagbzDIJbIfBY+dvGTw1uATkSbMosoYsG/TE9HaGHQBmp2PNVvl093WxPirfDyPbz/RF1sMApoGX/L8/xAmGkUcPmGDpyx/L4FyK0MOSqdq8Y7UD/gw0C1c3mF5CHccj7Tw32Qm5ze/tj5PIEGU/pVjoOTXZCjF2Iyb8UV8t8BwQeDUEzERbNVTjhkT5AsKOeara6vpqs9ZqzS++ULgFrb9EzkFoJsEy+i3MHHFk7AUS7V7RAVdgEq1TraSXGAiAlk5irUavLxBTyCBsUM4vm0lPHkvmPYWZGot2fYgQe/DiCm+oU2LJPdGzX2f+dITkYr77Nxnip+uZX3sZq1AtO6JGoExhCaqGhE7OnhP0AgrAd0p1EDnFPHnp1+2tI46jasxqOvhR9ljQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(47076005)(40460700003)(6666004)(26005)(186003)(1076003)(336012)(2616005)(16526019)(316002)(6916009)(54906003)(41300700001)(4326008)(70206006)(70586007)(8676002)(44832011)(2906002)(8936002)(478600001)(81166007)(82740400003)(5660300002)(82310400005)(40480700001)(86362001)(356005)(36860700001)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:49:51.3807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336919a2-65e7-4b0c-3e4b-08db1bfeecfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Agustin Gutierrez <agustin.gutierrez@amd.com>

[Why]
Current hotplug sequence causes temporary hang at the re-entry of the
optimized power state.

[How]
Keep a PHY active when detecting DP signal + DPMS active

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 89df7244b272..5cb44f838bde 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -108,6 +108,11 @@ static int dcn314_get_active_display_cnt_wa(
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
 				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
+
+		/* Checking stream / link detection ensuring that PHY is active*/
+		if (dc_is_dp_signal(stream->signal) && !stream->dpms_off)
+			display_count++;
+
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
-- 
2.34.1

