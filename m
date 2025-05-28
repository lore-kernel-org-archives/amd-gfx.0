Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC1FC54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258DD10E539;
	Wed, 28 May 2025 02:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="It059qDh";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F50A10E539
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmA0E07sS8JavVcaWPM1rQi+QnrVw2F2l6oWAAHB3IVCrrf10c7K4swhCa1l++IkAdAn5Ldf1GXoaoEayEgH00VvjrVf4VEHnHM6cvPCdUy6Cx9AUfSMwnj5bx4sVsEUCTLB5kTOrpI4JR3ZFsWHrc+Ud09K2Nv3uavsbuuWJKYwLNHPH7BdBsFojfHNSA+cX/qsfW1VMJWnVDZitQwcR8bbJhCxlmlYJsOVysScj2c4QMfRFK9/e4Seonqr69h6d9z4l4yzbN3ldcxHO2QxIeW4vcah/7v8N1I7JopeWAcIiHspi9QGPyVi+SwyS+NokS5hjHKdwtGOEtzQ7KGWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12pGg7dsRGiwao6XezB48ewdnh63PWp7PD2VUi2R9T0=;
 b=v0pXkfk1dTwckyVu+ylOtPBK5+sT8IT4F3eR8KSlYma9J7WF1UKavsInqrtmM7Gn2iG/c5h3k1SmrQXDVDGfIJj4h4F9BFQSioRhquTK1eOFEZLts0Xuv7hyXc0b5kQT9zTOePU3T9AlxojrDg5zPE0b0K1CVoOxeWrw6XZRDWMRcf9rKm4R2cE1/N5WygUrF8f4FJBQlAswjrzKSsDN/WR/Mfbb3ycH10J5voJouczTBqn2Mosp+QogfMiWUnWzFFnS5QZGdka5RVr4Df7FvpZLQDAo9bBndRr2SAs1mAOgbBVMbSXD0pGQRudOr3VV1RtmvgReZLFyqlfeNOno3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12pGg7dsRGiwao6XezB48ewdnh63PWp7PD2VUi2R9T0=;
 b=It059qDhNIdVH7DU9xzWtOBGAGrbAf7+ol5WI/4SanQLXNNqwiH76CBWJNSKU0S6l3Ghe9SlE8GY8UlaqgARAuuRuxCS+e8foUSdyuywXOF3anWO0F6CwCFLZKQxO0yB4tKrlyYR3wb3yuuBVENk40mSj8GEITBkc4wGiTFFrJw=
Received: from CH0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:76::20)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Wed, 28 May
 2025 02:53:50 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::1d) by CH0PR04CA0015.outlook.office365.com
 (2603:10b6:610:76::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Wed,
 28 May 2025 02:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:53:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:53:49 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:53:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>
Subject: [PATCH 17/24] drm/amd/display: Promote DAL to 3.2.335
Date: Wed, 28 May 2025 10:49:12 +0800
Message-ID: <20250528025204.79578-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: c90ce72d-43f1-4c5f-c06d-08dd9d92e017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V4G1izDqkiAnku2ZsMHQPTYuffWBLU2s85RQGBdQkkw4ZOJ2Yx2KwJ5FEWtr?=
 =?us-ascii?Q?s87m42heKpVZ4B9Pak6ysP1Baby3ZqSIXUwdG5BJOg7inxFxEZWk3bdZ4szJ?=
 =?us-ascii?Q?JiFMsR71zYMOqCCrzkyKjXp5djJw7sBkZElABoLZFTLpCGUOqcioIjdk6JMx?=
 =?us-ascii?Q?d6vPG+Wpw55CQ34JnTA4cDUz5486BqlKOAGMCyCB8bxNghJY4m5HzkBh0rbP?=
 =?us-ascii?Q?69nxY42KVduRG9EZk3e/kckUuK/yUjjp0MGtxWU5tkFCyWIBWem/W6yCMRQQ?=
 =?us-ascii?Q?4Jgb6wlQL2EjgK7S+WFK5gLU9MHMc20yYkmdynJ4VbDSULqpucq7Kjxlpnh7?=
 =?us-ascii?Q?3XQZMAxJcXvxWYkkUf7w5TltW4kxRHhJzIWlHvj4v3Lh6Jo8oiSg22rSDbpG?=
 =?us-ascii?Q?yaLfEM82qgqZGy25uXH3RmI20B0j+WKOQdGyod0mj+3AQ3GJJC7rLOojtw9+?=
 =?us-ascii?Q?Uo/1SqeCSWU0YGdLQky9AASX7RB6CHB5KqvFCkskvPMLreYj8LTVZ3Mq0N5C?=
 =?us-ascii?Q?8q1MgPZ/sIhOEQcKJ5o3EFuNNzogGuHdTNqubOLEInREiJNqt8cCnODG5trh?=
 =?us-ascii?Q?ESTpxySCm0/9x/D4B0Zh872V/L5XPNk7mGBr5Qf8OSf3/2K7WQBXbinSUbgd?=
 =?us-ascii?Q?gjwiFa+nZxckVLU3HbSwqzyiiakn7HZMw8uGMG2QlCb0FM0hHW3Ps0e0jmj1?=
 =?us-ascii?Q?hreO8RfkKXNrl7bUtEVwLT7cFM3ZsnUkmRE+rnDoUteZSqFXq/hVy70WPZkX?=
 =?us-ascii?Q?e0AyVv1vd6IODdBbo40Whccwsuwiv+bBXNEGS1iR4T1qOAxJbx5AUcSWLChN?=
 =?us-ascii?Q?SSYIGGcafBFafHXs42q+tIIQiJ0CRWLJ5LXbKRapo16EcFSTuTq0SeR06H4z?=
 =?us-ascii?Q?P4ZGxn79DccpZmYxmLQO4X2+HW5QySZGAf65TMYz6HYPjTMCsn0y951bDCC5?=
 =?us-ascii?Q?CoRGYFCXJitGnc6iKjbr7zgizJmWY9PE2THBzfIw9wrlXayjxKQ0U45xN/ev?=
 =?us-ascii?Q?YNuM/RzIb/uztokhJkTCREzNO0K2XnVib5upbwPx6msnSV35XxPlCe94SNmu?=
 =?us-ascii?Q?2iwASViiRlVXkLxgvwVMk06gtCKhU4ljSx9eqvLMO0/T5Bp3vUfyTFIcL4cD?=
 =?us-ascii?Q?wd410OSuHPYGx0OHzelM3/J7JC+Dp6vrL5ZGgjCSDtg6fTzK+vo4DDPULPfb?=
 =?us-ascii?Q?wVRmDWVE9/ceQE0XJJQEkuBL7NyCiBD+UXrPysjFKnJAS7VgHEIIKwah4Ddj?=
 =?us-ascii?Q?9QRcZ6C07sqOnOU6qa/He1kk+MJ6xbaoZR/VRzmggNR4SjKt7ZaBIJyOfM7f?=
 =?us-ascii?Q?MrX2KSs9sfDKW2+k18FDRObXDtoy1sV/HYBxwwBlc4ikOS0sra/4pv3ohcP5?=
 =?us-ascii?Q?FIqru3euxnXT60t7ikI9Ts9CFHHVKecsroDy2q7wh5pYnoqzyAoiCmugEJsB?=
 =?us-ascii?Q?kfNl97w9QIDzZxG4eudnuDc7zUosWJtR+4wKZWLLQ6vC+mXhoMWzFhQy5nlP?=
 =?us-ascii?Q?VuKn1dxMpJwkBXS/OuwCbv2bigefY2KnNHD7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:53:50.6353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c90ce72d-43f1-4c5f-c06d-08dd9d92e017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following fixes:
- Fixes for DML21
- Support OLED SDR with AMD ABC
- Indirect buffer transport for FAMS2 commands
- Correct stream attributes setup timing
- Correct non-OLED pre_T11_delay
- Optime boot-up consuming time
- Add support for 2nd sharpening range
- Fix on chroma planes scaling

Acked-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6b0471f635f2..274288139461 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.334"
+#define DC_VER "3.2.335"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

