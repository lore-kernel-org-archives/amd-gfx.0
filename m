Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE176606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UTMP5nJI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B3A10F890;
	Tue, 27 Oct 2026 23:20:49 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CAB10F891
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJTIg6vETAjV4UZU0frHx6bWQjM0SoWBOQYCczANESkraQKyFazXKU9jD/h57E0xad4u3lvpphmY0fSCcu/b11O1EXY+YTicu563nlJQMNyN+lCRweijDMZPKyMi/JlTzzgP2XpPn1xoc/MdMnnV7OStru9t64547KUp/hapQeMQtUoVUs1fXqXnZvhJ+voejrpYgaRZV8/B/zk2Vk69SPNmpbGu+NiB61KArlxSqRAUtDtcjbVXLG8Kuu7EgNvh9PhHJM3PftTTAeMHpHfCtCcagyiIA3CotvS5F7uoD3m+B6tpnfHLoeLutSlbTjhkShIC5ftVImZMzqMg1EaP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbG+LxrgM3I/jq/B9A1qTZF24xDcqwSApE2jAs9L9aQ=;
 b=RBuizQuw5yEXnBpPbDsObhaU+dGpzYKiZdwIeIuAj9r0RuS0PrD4vzIbXGGTwvFiXS0s5JVIi0fPN+/zdOqRQGw5BR3f8UcPKqisAXTW1Mnk+I86mlnn5WuT+twzo/Cp5/s2u8t4PSRT0yZ03hcVo0SzdTbjqvxVeeyEoGh9bZrnnm2dIiR7nDbRxkADrjY1zP2F/ElzwAd0LDK8L6QxVBISxJu+pwbeQzoQBWEaaTmv4xaPnBwmenccYWM1evihiUJ3UojZx0rHDWgUc6ktVk2X9qChqb98mwWEOhmc7klGilh3jXkg8hsFzb5QkNGYkwPfzgNbLo5gKn7JkMfB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbG+LxrgM3I/jq/B9A1qTZF24xDcqwSApE2jAs9L9aQ=;
 b=UTMP5nJI5yB/w6A50VZPEn808yZ1grXJroBc2ObmDnu18MCXTbxXbMV1hkA8zQDMBkm4HK4uk3Ks+gXUDiLjJWLlJmDERdEov9fIR9yLfZsu4TBS20nSeaaYa99L9PnGxaKBSFrLHSSbvLzl1bl+DnUdU7eKuBuED7UKQUHEDAA=
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:20:38 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::22) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:20:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:20:37 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:20:35 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 01/28] drm/amd/display: Use DCN6 driver_if for PPCLK_e enum
Date: Tue, 27 Oct 2026 17:16:57 -0600
Message-ID: <20261027232005.2879750-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f62af2-703e-401c-4053-08df3480e8cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|261021121427099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 5dwZbqz492aXozEJQrjmjwjuDt4BWgu8TsILKzXnyqgHiEUJsP/VGd9j/v0Bu5pAV6+uI2Iv4U1t4uQnog+YLpbSXaqtNQJ7kJUbN9hcr7lHh0W6dIl2z3GejjSxxsKGLLqa++oGBohl/1fUVyydArN2YGCjUjYdJApny4TM+cEZHua578ZogsOOf59SZxfbpUTSnOTjTE2ld5OTw2zCwbi1To8uWhPotLGJG0hyMYtgPWuHBLT6Zs+5WaMmyVaIc7aifQqNJAwofd+QfVJGjbFAG8q3EGFdsMNO6Wnte/PM4CCm8xhaAJIwXFzN/8ttTmWZoP+w0+QCUJuobmUQ6PzsdsKm6gM3AWOFijnyFWQKZqvefkw0bJpSa6yQylzJLZ7gcjK/fBjDFhg41S2HaMIqhw5calN4uvv1sElxiLJtlF0kete8+WNurLX0Z56CBNQdC/CEaLW6WUvVcbOO301fEIhu5CM5XS1S1xE2HdZDtDNHoKUvYDpl+Zz3JbumE0kMaiGa5qs+g0ipALk3QhXNbYc+fpepVvZ9Iyj8AlQVLmUmgkv6yvkwBIKdKfrBmuTSPiqqS9LFXw3E8BmJIHwF1F5Brh2Jip4NMKXVkIwm7TZqt+R12+A48zxldMF3ToeMks4qzSb+LChLmqOZAkLSuQ8l2DpNcVmAGD/myVkEQRwchfaiVyooCd4bgNisZosWS3Z2hIjHMXpTbn24dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YGoMRRhXjYFoiAtSXYh8ZkPyfEkUtQrGN5n1c1qn8kvd0YUzLA/yRJhbLrlRKBgheczG50nizAyqSPl73uleb6Gl7+Xt0J5CzhyJGZ/8DXSkSqH3V++JTLqPclDNUBIhkF/YzvlVL/+Se18VkHuPPRoSaEm1I47Z+qxHrSL6rmhyRROiIMxi27jRlyc1TlJl8rtY+YoEDL5xWQo7KvxQS6oy2cCo6PrpkoqRFbbHqxE4Vv2e9kCAJc1LrMn7lqbW0fQm2KlORXfdWFBRw7PG5Fl470XkAh7SsMOsVY22Mql0LZ/TOfUd+eH2zwsGg1fb/70tg8Ul3QxS4QOKpjuV7eiO/UUoLei0GCi/iB3Jsw33DKHTIiI8DZUo+o4M/9LiArIwpp7jjFBVRhXoWOYcGi6EgdaDmIZx1ji9J0kkAaL+TpYABsryRdkmHc7O+d0C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:20:37.5611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f62af2-703e-401c-4053-08df3480e8cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivan Lipski <ivan.lipski@amd.com>

[WHY & HOW]
dcn60_clk_mgr.c pulled PPCLK_e from dcn401_smu14_driver_if.h which is
incorrect and broke in different use cases.

Use dcn60_smu_driver_if.h instead.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 9ce378b821dc..29082b186134 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -21,7 +21,7 @@
 #include "dc_state_priv.h"
 #include "atomfirmware.h"
 
-#include "dcn401/dcn401_smu14_driver_if.h"
+#include "dcn60/dcn60_smu_driver_if.h"
 
 #include "dcn/dcn_6_0_0_offset.h"
 #include "dcn/dcn_6_0_0_sh_mask.h"
-- 
2.53.0

