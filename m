Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC42C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA6110E4E8;
	Wed,  2 Nov 2022 16:04:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E54610E4E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSPhsjLXdV7fgbtag/Hwl1VPxDU58ck6SizqTlQCSxFoYIVtTDtkwIYbXRqRnQ3x+ocavO5j1+/xZ5kem3uDP/5/DgCrKojE6fw71LzqBmXFzIvB+9cgFWYWNLKnZqPbvBeAZIGjXkFGFZ8VstvW279Ypi7wJTf2o8ECZod/tHS3kZ7Y2v/AfqXcpvJLQwNfea7frq5kXTbkbyjnzEdj8e0KZWuHxgMohxQDlzMGnJiOk/JLcmgkpzqX3UMn3WMri0X2xFVkX0pzr52mgFEsB1jhG3T3HexhF7azBMZRbNF3nVb4ZdkF3Es2bo7Lzw05NjZ25VuWZWxgupHwjkeaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ7irH4cjm8aCs0GbSDcOpS40rhY1VD+SEGC3fWq2ls=;
 b=dRK2HQDAkxsUB6TXSnC/If2rqvu8ODLJjqbiVVc8y4ZiAXNePXSjG3E9UX0QT/vDu9O2bEP6QnnESdZIvvlbkmrLa4omPnQuot1Eb1kOUX1mynhLsNc7YB7iFMvKnpAkj1invjnW5M/1I+oJicIDrmM9tmfvWmfSVrZiEla/9y4pip8wyzGFMZOQWNx1MBeB6iQIog3aUooflkuzb4GfjfYA8Wqud3RiZlVguHBtDLo8SV+hgweSZevDVnQbImoW0MtjerTZjjZd4t2E6Naigat4HJxcR5iQ13oPlBMvk26D1GXHmOYmi3+k6WIKnBsEwcuiLXivk6IV4jMPV4dilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ7irH4cjm8aCs0GbSDcOpS40rhY1VD+SEGC3fWq2ls=;
 b=caww2LBgTFqsW6eiatIBn0LWczSYjW/KluKfnvhRfDI0LRjDiBMVJ23qsH24FdKR+A87Nrbv4BNCfGdNEWMBq4X4MQOE3/ER3KOIWwu6SnJD4q5czhvJJmUbfxzaq0ulrH7kv0Z6b+DhmBYTdMj8ypv1YYceT/elJMd5+zP1F7s=
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:03:56 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::82) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:03:55 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:52 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/22] drm/amd/display: Fix FCLK deviation and tool compile
 issues
Date: Thu, 3 Nov 2022 00:01:09 +0800
Message-ID: <20221102160117.506511-15-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f59315-1b0e-4577-878b-08dabcebd8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHHkVahBjmFbD1R26u7AXBWGRtoHxG68TpsMYnWHg8iUjYsztuufYjTTqWjqa37rgArou8PpIPwANrS7YDb+yj/eo1k3scdQi8FfsLXLUpbXX1UgQQKK8HVwPwMKZzdHEpy2tA53N9Q4n5bzwaKxUHStzw8BEvn0soTwg6HMJ1BIWn4o1deMCATTo/7Ncm9ZYwRNsZmlJxu7ZweQ2rF9tddjLzTSarR/OkyXR2goTZ3/kAl0frHiKU+mJqnoOPkExMDhLgvXQmOVi4Br7w1WTe6KWXOBBxrzn/7yBMjKoeFXBBXobo+Y7LZwmYCuRE1PdN4W1ETX1mHmfc8PZin0261MzDfn2syzzFnSQZDSL2bOsm1TeqWkn9+tus46ZzKA3TSFySI1MUie6HHLIDMH1TqBt7zRwZBXnfTSpc/AYcrwDu9/C3K0gt7kcVZK0wf7Jm+JCDqMexqgxg1wkwQhvwjSsawHFfp2WCM/4zvb3m+jG4OXQfs9/FIfj9Yn1QZyHDCrvgb5FH/hefLJQrbCsdn8Shq5Fy6+ZrwCE1YqcWm3W/8bZdUn+jCMeIxD6+tryF1aUUA3Q8Y2lXrkJsqwqBZGePI9CZiYXhrIKUNWNeZ7d6ZAmgJFXBsAeaJhimjbHN9MqO7EUeWjHgtlsG0WQQ/DDCSmxBw9+Prg/t3/stMlJLlJdKRSGKhnl2fsonaYLeQXnDY16n+W7iGo2Tvz8fdFGqQPcTs+gXebEj7i7ocQZJlgTALFXeYwnST+xz35P/i85XNRiArOGAnOrYbNmKhUjLq3QMbZ1EcEB++E8MZfGMZ3rJift2LhOVRs4kyg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(186003)(82740400003)(7696005)(1076003)(356005)(8676002)(2906002)(336012)(70206006)(4326008)(40460700003)(86362001)(316002)(36756003)(40480700001)(6666004)(6916009)(70586007)(82310400005)(2616005)(81166007)(8936002)(54906003)(26005)(41300700001)(5660300002)(478600001)(83380400001)(36860700001)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:56.5660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f59315-1b0e-4577-878b-08dabcebd8c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chaitanya Dhere <chaitanya.dhere@amd.com>

[Why]
Recent backports from open source do not have header inclusion pattern
that is consistent with inclusion style in the rest of the file. This
breaks the internal tool builds as well. A recent commit erronously
modified the original DML formula for calculating
ActiveClockChangeLatencyHidingY. This resulted in a FCLK deviation
from the golden values.

[How]
Change the way in which display_mode_vba.h is included so that it is
consistent with the inclusion style in rest of the file which also fixes
the tool build. Restore the DML formula to its original state to fix the
FCLK deviation.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 968924c491c1..ab9217732a17 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -4397,7 +4397,7 @@ void dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 
 		if (v->NumberOfActiveSurfaces > 1) {
 			ActiveClockChangeLatencyHidingY = ActiveClockChangeLatencyHidingY
-					- (1 - 1 / v->NumberOfActiveSurfaces) * SwathHeightY[k] * v->HTotal[k]
+					- (1.0 - 1.0 / v->NumberOfActiveSurfaces) * SwathHeightY[k] * v->HTotal[k]
 							/ v->PixelClock[k] / v->VRatio[k];
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 2c3827546ac7..fdccaa93eb2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -30,7 +30,7 @@
 #include "os_types.h"
 #include "../dc_features.h"
 #include "../display_mode_structs.h"
-#include "dml/display_mode_vba.h"
+#include "../display_mode_vba.h"
 
 unsigned int dml32_dscceComputeDelay(
 		unsigned int bpc,
-- 
2.25.1

