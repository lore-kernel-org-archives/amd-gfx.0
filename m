Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A27C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2080C10E8C2;
	Wed, 10 Jul 2024 19:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4U9X9/Ql";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9EB110E8C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Matzn1EPkFymHVCJZIUbbq8mel9cg/nd44JKTfyTXGEsgjzep18LDkT+NV6hP7ZAwnEh6fzAjMftyL4UE0dWqPH65zjgwwoVEX9Oh9qUzQ5jZxLEMrjwNNnCXX5lH2tC9yGkzXUohWUkI42dw/jnRlwMp0fWlG/XkMio1lXLWKMP30WsOfAD4yiQLQ97NM+cjzNIienrQ62auyt7gGMOevN48F1ueC5/8GrBEtaWM9d9bqkcYx9t/i2dV/C/aknDDghP5j/JSlikP5c8LGWEzfUK0OhF0wUdPdFhpxCb59t6FoSiIsdYXcr0gnI/KAMChcFR2DClKEAjYbgOMXHkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=getKFo5kn1TAsPxqvY5KsbiaQyCauyELNrR8YtSOO2A=;
 b=Sv1nFXIXveOgtYncbBsLGN74dw0UZTuavGJP/7Qo4F5ICKrk4V6lEE6wSV/sfQrK720pBTCtf3/IpBJxm7RIBO8pyNz5eK/Wdc7nDoJ6iVhKjuMGObeJKBwxgcR6Zq901VLlk1YTX/MIRU8QfTkz+9qKmoOjsRm6xwTsrFJVHfIpoNd/T+kyXXMnCjknDiQRow9KHFx+GpXg0p45xAyxyL5BgIDDljFUIQwmnEpm3V+GCGnuF8BZBptMQgD30ldJCHHM1W1NmDc8nj+cutRrfJ3Ca7vwsr/qaXlyIhzkJcgHt2WM/R2LeJd1i+Kt+zZLEOVLrQQ1rOn0se7ta9IhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=getKFo5kn1TAsPxqvY5KsbiaQyCauyELNrR8YtSOO2A=;
 b=4U9X9/Ql5GRejnyi66zPt4jOC/q+gz0A16rqr55e4ICcwBOPC1F6ZAVC9XLWiZhYGjC+R/PGO9254KuW2GJfW7q4UMcptQEczo1vavGO2v8cK3hA8fO8mVoJy5bv7EoUvP2Y/AmF5hkd/CaFN4s0O4FV5WgqhjIcvnhwzQk9Bbk=
Received: from MN2PR06CA0022.namprd06.prod.outlook.com (2603:10b6:208:23d::27)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:40:18 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23d::4) by MN2PR06CA0022.outlook.office365.com
 (2603:10b6:208:23d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:14 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:13 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Mudimela <lmudimel@amd.com>, Martin Leung
 <martin.leung@amd.com>
Subject: [PATCH 40/50] drm/amd/display: Refactoring DWB related files from
 dcn30 Files
Date: Wed, 10 Jul 2024 15:36:57 -0400
Message-ID: <20240710193707.43754-41-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0910e8-fdf9-4a81-fba8-08dca118210c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ER3j4d0XsZ0KI7kgpv3tqu96b5EfaRiMo/1mLx/oZcXnIMlZg8fZ5V5IVOMU?=
 =?us-ascii?Q?5duHzGr1QD70qeyrIkEXhyrA1MBBDfsDAnVbS6u+sCtAeDNOSPg8JSa8QSg9?=
 =?us-ascii?Q?0R2jU4/XC51AYvnJTqsbuyXCW43Rsr1eiDW51kKLELfJcz3XERKymZ131KlT?=
 =?us-ascii?Q?OgezxaDMSme7CFcDnkYdgakuwx5EEP87vlUzL6DQPVEJbK43KXUh9NeFHqoV?=
 =?us-ascii?Q?1LSs2Ks8aQIVJ3A8lkud1JZzC3hs45ZWcozAsKa+burleUmpV/81+ZKbcTvK?=
 =?us-ascii?Q?qM1ijshZopmXQBcRqm5h5X4ok52rz6/tZlPNqUAc1XTTQrS5oa7sa6Apd9mO?=
 =?us-ascii?Q?lnZveRbQ4nUzsuJJeyDje7Cb19FBw3MtanUT44vttMmzKoSq1N+v/Jj1U+jK?=
 =?us-ascii?Q?FtSyI0xS5tgll6qHn7IsRfNm1hHWumZxzNWiPA6XPbQ45+vM2dhNKD82EWAW?=
 =?us-ascii?Q?5jdGHXGdu8MMKbMWJcM3/wSGnhoZLEj3/Bd0HmVlG9MPNP0U/kMW8xX1yQ3a?=
 =?us-ascii?Q?5AdFCv+rSMN6hxm79J4Wyqbh+4xuwpKyys8ezeUqxQenrm9bOueZ+pJV/Va8?=
 =?us-ascii?Q?643uopRoRsNc/JPYDGg0qBg+TInU/XQE7F++ydApsVt4MBr3eJthXok78ndh?=
 =?us-ascii?Q?rFXKwFVOkQ9IKQRMUiqpU6nJXMZT35Da/HOG83gl95B2BCPKPdv9XaTkTLPr?=
 =?us-ascii?Q?KkAmda1NeI+g9DePXgtOgRjFL9LbbIcOf14bOyn8JDNPW+dE51KAAGhKAPro?=
 =?us-ascii?Q?O23FENYxE11qrdHU7hgVGZJs+N/w4y1kc0aox1SFWs4WsAuoadfKb6/ZAnk/?=
 =?us-ascii?Q?f/NfySOQzUEFGMcHZIsa8w6w1uLZE1jZBoCzCQyI4OdL7fU1XlW218yTV6jw?=
 =?us-ascii?Q?bhnSA7iMaJu4gQSZ8Cacwq+v2fjjUEUy6ekLk/JTnIwGq+EDeNK+fJ1BQvgF?=
 =?us-ascii?Q?iciLbZQDvkfO+qD0//thgO0jZIJus2kukIs54DIaeqTdIPls9o/y06NBxBCK?=
 =?us-ascii?Q?Fh7/9UFwO0A80FffpZmATNrP39epzSg1rcSh8LNCopeJywiUf/SvC7acvlp9?=
 =?us-ascii?Q?f7EUDs0Yrmw1HkWwBVShe8JyWGdZ60i4AsK1wUipX7VvF6MRfRqwM6PVVRly?=
 =?us-ascii?Q?Oin6euA28T4RT5RspTyIXUWUe6LhxiuUAzdvYJDT9pNia1h9FDLB4efqVEED?=
 =?us-ascii?Q?f+I66L2oEACxHNynyt40TxRxeVvHkmLA8hLm9WalXKx/+6hB9coor/ymp/s4?=
 =?us-ascii?Q?oN0qHmuHX/8XX44cVCkGQMGsefVfX+otbfktFWNASX3+K7GRjcdlXhZysjTO?=
 =?us-ascii?Q?JGt8JMt//Gpki1cmc0Xant24jKyf+1J34wCN5FkRMWBDESfuDuHr8mqP7HiC?=
 =?us-ascii?Q?Y5pW13wtdopr+FxlhXVCzeP/X/54Pll/H2trDX6I3X9yDsrQ06OZqkzQCiYO?=
 =?us-ascii?Q?3Xr5kS7tZKudaKuNBbYLc/nFMp1oJiQY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:18.2428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0910e8-fdf9-4a81-fba8-08dca118210c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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

From: Mudimela <lmudimel@amd.com>

[Why]
To refactor DWB related files from dcn30 Files

[How]
Moved DWB related files from dcn30 to specific DWB folder and
updated Makefiles to fix Compilation.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Mudimela <lmudimel@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile            | 2 --
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dwb/Makefile              | 9 +++++++++
 .../drm/amd/display/dc/{ => dwb}/dcn30/dcn30_cm_common.h | 0
 .../gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb.c   | 0
 .../gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb.h   | 0
 .../drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb_cm.c    | 0
 drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c     | 1 -
 8 files changed, 10 insertions(+), 4 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_cm_common.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn30/dcn30_dwb_cm.c (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 804851247acc..ccb4b21338b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -25,8 +25,6 @@
 
 DCN30 := dcn30_vpg.o \
 	dcn30_afmt.o \
-	dcn30_dwb.o \
-	dcn30_dwb_cm.o \
 	dcn30_cm_common.o \
 	dcn30_mmhubbub.o \
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index b8327237ed44..685702321d32 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -28,7 +28,7 @@
 #include "reg_helper.h"
 #include "dcn30/dcn30_dpp.h"
 #include "basics/conversion.h"
-#include "dcn30_cm_common.h"
+#include "dcn30/dcn30_cm_common.h"
 #include "custom_float.h"
 
 #define REG(reg) reg
diff --git a/drivers/gpu/drm/amd/display/dc/dwb/Makefile b/drivers/gpu/drm/amd/display/dc/dwb/Makefile
index 16f7a454fed9..3952ba4cd508 100644
--- a/drivers/gpu/drm/amd/display/dc/dwb/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dwb/Makefile
@@ -24,6 +24,15 @@
 #
 
 ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN30
+###############################################################################
+DWB_DCN30 = dcn30_dwb.o dcn30_dwb_cm.o
+
+AMD_DAL_DWB_DCN30 = $(addprefix $(AMDDALPATH)/dc/dwb/dcn30/,$(DWB_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DWB_DCN30)
+
 ###############################################################################
 # DCN35
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.h b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.h
rename to drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
rename to drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
rename to drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
rename to drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c
diff --git a/drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c b/drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c
index b23a809999ed..d5e8294f5a16 100644
--- a/drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c
@@ -21,7 +21,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-
 #include "reg_helper.h"
 #include "dcn35_dwb.h"
 
-- 
2.34.1

