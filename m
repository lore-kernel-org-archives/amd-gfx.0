Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B0DC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 03:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E84F10E70F;
	Wed,  6 Aug 2025 03:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5We2rcjk";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084B710E70F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 03:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e34wTcyuWqgVRiv3ow3o7aUMIuYDh8LwvE6+Sdpb/gF/blRDV19o/B09gJ4kyKf8c1IfOgs03dBQ/KCz0vua0KnVl3KhknVd61T77zj38V16dK0T2NxOoyZavgtrWipQwmZSDUsX4dBxK/xsnhwfaC51IhdTQtZD3bO8s5EBswfksM36uaePalh3NK6g4OPEK55Gg0ZQDB7voeG84tKvUG8YQY3XfBtrwiYNKpTmA2PqlmCY3/8nYwtLuzx4940Y/JfWXlwKM5Ig/szfGm7eJcpWNQOQRn0gK0aNfV9hxKDk06AkpdDHiISf+4vLQiSx2GkDziRM5CQ6Qph9crTSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CNTRV+QEb6akrYlYoJsP6CPldRUhAx4R+6rp7oFBJ4=;
 b=PMOjc+2I10T87xwVYILrgtOlY7nFa7rJ+bgepNy4SlE2jv5RqWY5yDOrDvyI1QxZ94hG+M5qDykhBoSQ4Ay910u0kr+/K9qTO00gGK39xpKr3hjFIIGokjNd6sB772L2VA8N4uw3GmVIy9P3swMuHdHI0SJWgx1YsGvHKjRr5c70XrrV12e5Jdd8bdGuwfDRMedp11zhY3Q8iy8/SrnQtbqz25KbaA8oeR8gdnmpkF7ErA6STQEWQNEkiwYEmkUn8WbD4cKtFeEHWfJB6m5N64/CUcEzdxjyHwJXQ6xhevhJ0YDx/t9JkpC0pA10j/JHS0Y4FOjWNcJsnEl5LVJihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CNTRV+QEb6akrYlYoJsP6CPldRUhAx4R+6rp7oFBJ4=;
 b=5We2rcjk2kTnd45fD9K+vC85LupCDOoRVsXUD1Q9SAHIWabjMrOuTWZVBHrRFmdmBjJcq4kyoglWJfADf+N7es2OD863oERzpRddEtB2BtqhB9xhRwMF2mIPCECvSZhZXCvZRrXXXF/NZ+ORQ5HFZdLsf00BY3i0zbxZCiWviKg=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 03:02:59 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::6f) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.12 via Frontend Transport; Wed,
 6 Aug 2025 03:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 03:02:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:02:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:02:51 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 5 Aug 2025 22:02:49 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 4/4] drm/amd/display: Promote DC to 3.2.345
Date: Wed, 6 Aug 2025 10:57:13 +0800
Message-ID: <20250806030216.21096-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806030216.21096-1-chiahsuan.chung@amd.com>
References: <20250806030216.21096-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a019ef8-4cdd-4d16-bc38-08ddd495bfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MtKKpl2i7f1MiY2IqKNlQsiyKnp9DcmwiR0o5l5PKbkWBmto0lPhSjdhfxoK?=
 =?us-ascii?Q?a3NhmwSOhQGu2PHud93DuEPGY0sn/MXLWoj7weG3UyGOLPYqbIDq/bREH50h?=
 =?us-ascii?Q?RWsv7PpoLpG+qnbNA0vmdTBIK3mAoYRc3v2HsBlTZLJFXHbBIUVUXb2XkmQ2?=
 =?us-ascii?Q?QGOk9gnTI94uecRThz+KrfgThg8rpvUS6qhwCRlplMTk6n2f6UYkGpMCRhfY?=
 =?us-ascii?Q?/vbkev9XvU8diRnpwGibcJlnRAqodBJ0Gk2rrtxRu/YXuTXZ3sjxCK69t0Hd?=
 =?us-ascii?Q?ZDBlgLxlMeV3krxKewFu5CGygFh01dHd7JeaE3bv/MOuqriALei8AM1RNJV9?=
 =?us-ascii?Q?CJJc7HO5li94BRyR36MOUB2hGWzP7ikeizVWErG4nCBINTHRyppLqs59/Vue?=
 =?us-ascii?Q?oFLXavzW7s4FyjTgXlzZfkXxK28jCgjyPc4UL50QKQXvsv271xuDxvGEhrE1?=
 =?us-ascii?Q?xf5ZO/3veeDRy/EvXqwitLTug4pDHZEDH4Q48WGpoTEeHoPGtooXzNCtDCU0?=
 =?us-ascii?Q?6E/CTsFtNp3phLntoVZnWLrSPf6KzEKOwIO0x9Nq+B6OWQEpN+r2CyjGvVRn?=
 =?us-ascii?Q?Sr+zCZsne6Q0x12bX8sOVnvV4bENEisSbf9pa6TYq+r5OHTAM3a3IFYc+LH4?=
 =?us-ascii?Q?FmhYGvr97qxWftcZ40FP3kQAVeAHdASzvAZAFhDowaoraYIuZ4hmBbFLcf4i?=
 =?us-ascii?Q?gZBtQET3NA7/U+yPEM/nz1VN2KbCp+7/PmW05qfPgB5aRLkrObZl6V18wGYl?=
 =?us-ascii?Q?/CykNorOGfDj36/wNSfviad8FPZmSr8sfYGqemiNmm5JM9IJzMLJX8dRAT+K?=
 =?us-ascii?Q?TBpxndlT+UYniic0ouIFA9zj3DV754zvEWKe8fb09tgmb0+D77hLDsWJYtA9?=
 =?us-ascii?Q?+7jSsY58l368B0HbIokybvbNDfW8vn7+Bs+DFkVPvpXLS17aJBSJeZtTZOs+?=
 =?us-ascii?Q?FojsFgJiZvMToaH9F6j7sL+tMcDidZbgOwzy/EICHBQD9nnV+rZHi3ChAzP1?=
 =?us-ascii?Q?MifTflseFxURco93Y8oxPsWs564ixr+dUko3NrG2Pjttr/2h0t0SvzjGhji4?=
 =?us-ascii?Q?yvb6drO73EUp8pQ4rMNi7XPKasz3Cbn8BNcaHACMUm5s4X3t0jRf2cqzEwtj?=
 =?us-ascii?Q?2nstOV4lTw45OckyQDSCvY4N8o/KQoWh6CJcNJVJEgSx9JCUIcoLAtPpMVpU?=
 =?us-ascii?Q?YXhaSdSZfHlpYHTYlX7xWxogcJOYY10ROSQGloYcsZl6tfV3DORx2e19euTv?=
 =?us-ascii?Q?C0koWnVEvCU/661U9a+K/u5WkPwLcQAx9UDsjOZVLvT9kcAyvrdYZ90j8zGL?=
 =?us-ascii?Q?0TIKSWEli6kLJEo2apUWDf6H99IxMGGmHGKGXaoVmDgdcQxcRn8xxIoATal3?=
 =?us-ascii?Q?wTrTtfyYEgNTguAzsLBTYm2vARAPfnGsZnxlCOFCIwLzV5P0KL6myh+2Z/vk?=
 =?us-ascii?Q?eXdmSUvoCk29zP1XMycM24XKXAQ7ZfV9vAduZpVofVacsZRbtFGkGAwJC3E4?=
 =?us-ascii?Q?afEaz9TUMuRI3BwhaNihnXj0BljRiBuL1jlQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:02:58.9262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a019ef8-4cdd-4d16-bc38-08ddd495bfdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

This version brings along following update:
-Fix close and open lid may cause eDP remaining blank
-Fix frequently disabling/enabling OTG may cause incorrect
 configuration of OTG

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 18c68e531f71..1ab05eabbddb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.344"
+#define DC_VER "3.2.345"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

