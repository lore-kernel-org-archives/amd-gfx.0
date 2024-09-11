Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7616BEE57C1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2706110EA62;
	Wed, 11 Sep 2024 16:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o5CyzzsE";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C0F10EA62
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGKBBTzrhRA8aUzye1W2Z+0T3QIdpQkUGBGqXmzhmRx0vHjPdQF3Lyp9oSnnRX7X4cmqkt5VG2F12cMFNjnkg3P2r8Vmdkrq34ASfHq+ebGFKLEWeoNzjatGeQh+wsEOL8U4tSVYXpSHnTeFS36yb+OHZxI/p6AnZ1sxLwgO8rvHI/fbfU7vXACvM7DumqOt9YUzN38CkknZvK8dRGbJQSP7lpSrZnKrRy+JY4iUsV4Ke1BB54zxhabthswtQ5EHWf0wZGyAuQtidjLFS5Wdigs2MLSU9xc3Ggq2b2s6oJboCKF1ncnSKELfus82xN1Z6ktfOl6b6g/fhIjZ321rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icAJrTtBZ7BW5Xr4rWen2y7+doAs1cdmy5AlElNfxY0=;
 b=gaGiiLEdeJDJole0FnX1IF9yiC2zIC0f7YsgBJoew65h4CwdGsEyM+cVPrT6Q5ho5p2uM1Y1abWvbcuFm26igKk5lK4Gqr8M6t22rRC5XzERumydyj6s0N40/EGlCYVNEcuuBki8SJL4vqDIrBBCIxpqu9+FHZdtZrnaVa7IVmMCr3wqXRsE3X2+6yJt8nMCyNsPPOFBSgxdNmkQAeExfdVnRBC0uv9TE+ytLzzMXKP+rvfY2T+6P+AjSH86xRPTrvjKNodC/Lh6TwZ8O6j/XtnPvDHSB3xYwgW6tHgCUgc4rAPjpP2DH5nUaHejf1yv66gI0lCSkcZHQ/yNmlpglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icAJrTtBZ7BW5Xr4rWen2y7+doAs1cdmy5AlElNfxY0=;
 b=o5CyzzsEoTjmNgGbe5q7/lbyyueHfkehrBsshIc0MwjHPmWNcRRwedky1CPqpB3TbK8+JhwB2AJwxu/WhzOQgruqRl9Oyd/UR+3Kv9TFHT4tlCzghq5BZZdttsEZ+H4lGV5kg1LOJEV8mPUaLCx4mxJK63E/ybQARKcr54OeaeA=
Received: from CH0PR03CA0414.namprd03.prod.outlook.com (2603:10b6:610:11b::32)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 11 Sep
 2024 16:26:58 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::a6) by CH0PR03CA0414.outlook.office365.com
 (2603:10b6:610:11b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 16:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:26:57 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:26:55 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 23/23] drm/amd/display: 3.2.301
Date: Wed, 11 Sep 2024 10:21:05 -0600
Message-ID: <20240911162105.3567133-24-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: acbdf87a-bf1d-48b4-88d6-08dcd27e8e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?szjVlWRNUEHIYznuKaS+XItogt5BQfi3h6ccUO8sSFhfT/0bbYAqoHwfOxnY?=
 =?us-ascii?Q?akjjxZsVysLqL28uf2TgtrJt8XbivNMP3qx4xwqC54KuORqN/D8FD7UN/+fT?=
 =?us-ascii?Q?lUccygWk3YWlUe1pO5fXF4S/bg+7lE+iqYyFmo3uK2dGcoNnXptBLSA+xIuy?=
 =?us-ascii?Q?ziF1hHVZgfDGRuO27L1P60G/wm3+TPZC+u7bvPsYNB3pi/3LDcGmsrsSwUPd?=
 =?us-ascii?Q?uEpUazmZDajQZDyQiJGhG0ilHHuDSeYoaFXNnEBHSyiZAkTP9poHNbO9iRm0?=
 =?us-ascii?Q?uqxYGWbSmR6kETBe/odxxQh+1NIO0IjpAaESfzltKQS36Xktscn7BjQxGvGL?=
 =?us-ascii?Q?huwGyRFFEAs8kDy136/XWuT7H1WRusfC5AlTTAivsybceyZm6EnNS2ZIbvvk?=
 =?us-ascii?Q?CColv8dnO7u4nYTvW5d7MSift0wgoVHl9VarNDIwnQQm/lf1lwP45NdzItEF?=
 =?us-ascii?Q?XJJmoXGf+MkZr+Ua2VX22vGkOrFA8Peo+zxiwM1xgNgkSp489rSU4P+VVlN3?=
 =?us-ascii?Q?b4kRSsOHzkRAzsN9048TU+PxCEWFD9sSJW3ZDbuAArX90sFVxU3vMgL0vW1I?=
 =?us-ascii?Q?l+IRtXasjb+TAD/RqnBAF+7ZWeLhdAROtcHTZ7UlILI6P29KtEBQb7ZsuLPX?=
 =?us-ascii?Q?xXBybnq1tuvdRKTG74hJqVCpwyw7eF7Mu81JLPdZXqIIJZng9J/FUDflAySI?=
 =?us-ascii?Q?5LlIApwKhjWiKoamlsOu0mstgeiBsPCdHtp9MuO3rM/6PPBI9T2sGnlNZ0Wx?=
 =?us-ascii?Q?+l/E+nmNlL/LCELWcAUQLCPbwchO4Za4NuGJ3mJyFcIY2bGuK5aFuqqEj9hP?=
 =?us-ascii?Q?OUBscdors38DGt9FFeJ5NWes6jdnyzzuc1DxF9dND4kPMhfr6qGtM/+6xmUH?=
 =?us-ascii?Q?ni/bAFf2nbxMETpT9sx9gLDcxOjPWMk0640cfNwXm4cEyetB06D99Itxji5w?=
 =?us-ascii?Q?JbDOXhWA85XjGeuzQG59Vy2/P/BaatQkPK4YAiAUrEvgN1a8J/yRcZ0knq9H?=
 =?us-ascii?Q?P8jeajcRQyoOLb/DurZPNcMbrHODeyfcnw2zWrXV8DzFYDw4n+kemx9z0HXd?=
 =?us-ascii?Q?qH5sH+FbgUNyhQEIHsp0TWJfVHNdsvHE4n6olRgXpcndC3FRr2aHtOThQWxT?=
 =?us-ascii?Q?Q13s0tFA3Ar8AWESIHpOtzzVyuSON9ZSb5CIaAiD95iK7t96+s4qCrbjy7bs?=
 =?us-ascii?Q?4nYl3IQcB8m0MzX3GoXHW5BQgfcf0GU9yjuqXYipZWL511S+wf7s7n3AINkl?=
 =?us-ascii?Q?5a861xscTUO3YzZK4yGKA4bKflm55TOCsJu/Id9PFGGOI8CNCca8cbxbS3E8?=
 =?us-ascii?Q?iPKp8GWqNOy6q/0y5iTX8kA0djd3f94YW5WJgbvdAj67vbX50JGIoQ1w+6ob?=
 =?us-ascii?Q?B5Lq2pdBZNKDZzSgWg2jov1xb6c+XyluvWEIl7PvQ6EcjL8QFWKNt6cUp1U5?=
 =?us-ascii?Q?ZatD3swAmmnYuEzHaPn5DkYR3Gj8q2mT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:26:57.6307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acbdf87a-bf1d-48b4-88d6-08dcd27e8e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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

From: Aric Cyr <aric.cyr@amd.com>

- Clear cached watermark after resume
- Update IPS default mode for DCN35/DCN351
- Use full update for swizzle mode change
- Skip to enable dsc if it has been off
- Fix underflow when setting underscan on DCN401
- Remove always-false branches
- Check null pointer before dereferencing se

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 78ebe636389e..3992ad73165b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.300"
+#define DC_VER "3.2.301"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

