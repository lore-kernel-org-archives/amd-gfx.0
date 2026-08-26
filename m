Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B71CC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B940410EE35;
	Wed, 26 Aug 2026 23:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LMgKiD3J";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9087910EE35
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOIe2w1zynKoRxl4pKxB2K6jr/Gh7x8v7xH02OEOZgOE6Jfc8h3yFw5wSIkcwjHMKJ4U9GVuyYBriHUC8KHTP6g/yhFHYP2+W8mcb4MoWfIRCXufHBhcW32r3vRwMnSh9H+1UBIDHdQrZV3iUTHiEE0ruNBWzYGSbvGRp1zkkZDcPdFptLO2X5Gsp8ik+ZFVuUNDPkt3BlLfOvcx8Ji4VtJNdhNdVhNaG/CEMqc0kjgYqdeQQ4xCXdfrD9zMZMhBRCm2H5JtPsYD7TUeLt+OXOW8HAfEC9KRLFsMbbIYqV1zRCaD54WXC3TCWNy5B/O9oXLqodKNc/abBwcZt5VRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg5YVnGOP15vql/iFbV3Cov8XrvTpULXnNYm3ovHAP8=;
 b=fJidIvvK6AB6UQUREHqPpJKDdWkrN6q8ZoQCmmXJP92UQANPb0BePJnUuodIADOGdbRgYqDUr6uqjYsY/FTEFld/VFQL4zcM7XoxLYXp+EQQf8YggpP0YMmfA/R1RF7rI9vxWVzSqE+mQvmwLnUcaoqp9gZ8g1jP4UFIObv4dQCBNakZH4mxle3WHU29d18NOWNsEVtPme81jk3EiuBJsjAgDYGph3OMVucMnZ3B+VEqaAUerQuvXjttKDdxeaULR4oYqiRjp5UWjZaEbtRTQ5owu/fspDM0qrHVOdZx5l8BEM9Wxij+OxlS5pbN8rpG81UdTrQBR6+oLshjqIFTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg5YVnGOP15vql/iFbV3Cov8XrvTpULXnNYm3ovHAP8=;
 b=LMgKiD3J9In/1bhYi7nGnrMOmQjMNVizDDPBmiWhUoWJUy9S5XKqt/sJehUPHhBWHOGEwQaOcaIhTgkzBj41/s1pj9in7YRiPl+U+JQK+zSbZY3XJ4g0XpJdK1XqxymmavPocP1fzMZD/SQQ4EaeofwnJ2++6TGmnZvL+x2/h/w=
Received: from MN2PR15CA0047.namprd15.prod.outlook.com (2603:10b6:208:237::16)
 by CH1PPF68E8581EB.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::611) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:18:35 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::46) by MN2PR15CA0047.outlook.office365.com
 (2603:10b6:208:237::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Wed, 26 Aug 2026 23:18:34 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:18:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, Dave Airlie
 <airlied@redhat.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 08/59] drm/amd/display: Move custom float structures from
 opp.h to custom_float.h
Date: Wed, 26 Aug 2026 17:04:39 -0600
Message-ID: <20260826231519.881949-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH1PPF68E8581EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d87a14d-019a-406d-e88f-08df03c859e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SHmjSQQTNw6fn9gvDbP1r948CMnM0sR5n4RRP4eftlF4bdyuu6Tw7xVU3Kfaz3YJyjNNRnujkkNMoue73wC0o3YpyLW4or6Fq6dR1yZCHwe1eFOSt0WKQsPX18skUAMp6TAORaq32qHJknQgy5/1KNNVNM7Jg3i178FR8EVE8Z5KPRX/ceYzaCAu9jYp3Z+9cKaziPKKJGxwIdQt2aAa1OH9Mj+3uEw2Z4t47ZvmRdc/RobLtXToDkoN8e/TqMLBelfIU0kf0x9Xi0GflOZe9CxyE3k9oXjroVTD3D8jpidlCxsKVMfihNOg85UaWpbrokoG+UWbDnl9JsseHcIFRQubI8WAziU6U59dOHaJCQzdOJx14mR0DEwEYM0jYVMbl+W2jMVBJA1I2YL/8Ni+hxsMEnnLWwRLWBiUqZD9l6H34q07an83FpGBzb9AnCHnCaXt+T9VzxrDmLxp/Zgqgn9aiOQudnS4RRsrrbDaKIAMszCusbK5FXXLFXL9a1sXMK3/mFw6aAv0BjmVR+DYArPwEw+bbBlZSczB4iDDi1lP3wZFsupKVUIakmo99vDTS11PDkhE3ORyRR3OTbWsy7Nqxwyq9KgRKw7ZnTEJUC5neo8QyNh80lOTM73BMBzZxgn3jr26Tzs4a9us4ilk/0XoMY+VL/Mz6kmQIIeeIF6scsks8YxnmDnRp837iuGT
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gKaVh4DgpZwoLZUP1Whd6e+Kx5MeOKaG3yCLxMfsZrYRg7Jee1c4af7YQ0eJQ+5Tg3Fw88dWtYN4wKKSehjMdmly++FRlQn0YpFmz01580MLuGrF2Db+v4+aaecJQ/Z8ROa8bvl9FYU2ZdlHgl7r0jjy9xsZBSPBxTC5r6fS1dGYacBGmZEB+3tPd5qpIwfP/vHQem1zp/tdGCWeGqMCHuM1CFkyAd9edLQWU3457lrog+ecMH/vJZqHSLU1JzWGyW+gsLuREKqe2a4lQqcS5uyyVuT2YwI09Q8o+PAt7fEeofY2vFaI7kIGzG0TQdyPVTJExTDKDZ9Awb14oTx78E4P3h4hD2k+52y4WMcFjiQuyyPzUvhL71OxPaNS66den7av1TqcWko4OrWaLfm+maPo/NokvDmAU2eivMNvnILiznDoiFPqDGz30RHI9fLS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:18:34.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d87a14d-019a-406d-e88f-08df03c859e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB
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

From: Samson Tam <Samson.Tam@amd.com>

[WHY]
Currently it needs to include opp.h to access custom_float structures,
which pulls in additional include files that are not necessary.

[HOW]
Move custom_float structures to custom_float.h, and include this header in
opp.h. Add only os_types.h and fixed31_32.h in custom_float.h

Suggested-by: Dave Airlie <airlied@redhat.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/inc/custom_float.h | 21 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   | 14 +------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/custom_float.h b/drivers/gpu/drm/amd/display/dc/inc/custom_float.h
index f57239672216..897759a041e4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/custom_float.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/custom_float.h
@@ -26,10 +26,25 @@
 #ifndef CUSTOM_FLOAT_H_
 #define CUSTOM_FLOAT_H_
 
-#include "bw_fixed.h"
-#include "hw_shared.h"
-#include "opp.h"
+#include "os_types.h"    /* uint32_t, bool */
+#include "fixed31_32.h"  /* struct fixed31_32 (used by value) */
 
+/*
+ * Moved here from opp.h so consumers of custom-float do not have to pull in the
+ * heavy opp.h
+ */
+struct custom_float_format {
+	uint32_t mantissa_bits;
+	uint32_t exponenta_bits;
+	bool sign;
+};
+
+struct custom_float_value {
+	uint32_t mantissa;
+	uint32_t exponenta;
+	uint32_t value;
+	bool negative;
+};
 
 bool convert_to_custom_float_format(
 	struct fixed31_32 value,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index 73cc34ea7726..f2d16d88b0bc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -43,6 +43,7 @@
 #define __DAL_OPP_H__
 
 #include "hw_shared.h"
+#include "../custom_float.h"
 #include "dc_hw_types.h"
 #include "transform.h"
 #include "mpc.h"
@@ -142,19 +143,6 @@ enum channel_name {
 	CHANNEL_NAME_BLUE
 };
 
-struct custom_float_format {
-	uint32_t mantissa_bits;
-	uint32_t exponenta_bits;
-	bool sign;
-};
-
-struct custom_float_value {
-	uint32_t mantissa;
-	uint32_t exponenta;
-	uint32_t value;
-	bool negative;
-};
-
 struct hw_x_point {
 	uint32_t custom_float_x;
 	struct fixed31_32 x;
-- 
2.43.0

