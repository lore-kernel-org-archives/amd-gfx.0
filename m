Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2585C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA2B10EC97;
	Tue, 11 Aug 2026 15:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZh+9/9q";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F7810EC97
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkOqk4XSGMh92t6Rg8S60dehquiebuQELn7oSbs9wd92HITcK/Qyuq3JYoyojqVhhHqIggS+8uDB35WL3XiJauhVAL/Xo84R5uPsE8dDDbjau0zm7BEQAn///e0bRkI6s7MoEtOcPLs/sD4c2MpZS/hj4NETqjXEh0CVqxRCazLqDxdvhE88Ru+tRM6ymaW/EUWgYlk39v2vSpXj1KgjaP1Pf6ZgmD6EM0AJCy85DDEZw2ddqqwGBvvQioyJEyJI7zNnFk9t7REe5R6z7sr8A8+EQA360mmuIj+KBEprKSXK2Gx7IjcYkDCiBAoOaKf/rY7G0PR2Leb7mnp+cWxieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY8K4BX3pa7l6Of6F4l/wJSdLI/sXdghMX8ro4hgVVE=;
 b=xK7THE/pHoWRD7cpqbgXW5n0LxaGCnGLwJ/W9r1yX8hQrOVh3TnMM4kwTvv7x2tkKatISWmjm3uQH93tZ2PK6ybxE2CgFEtW0A1OEW1K3ZAxRaWP/cBLjB9pSwnrWemFwVQcWfSiF7sYYdFdqgQi+qx6pzaeZKoiQ+XnkfhTXnUBJbsywrDToyr6MgRI6sSnWSYDc/KdzR46tkX5BGB/h+QsVF900Qq6q44YOQk1AZeYl5PhzkbK2xXJQPoNOGXXhAsKZ959eIq7/p1i1Qe7XE1wvDec/BkZiNDxq+n8qyGgdAopqWQrZeT1gvyE6Sm2iS4h69JlPRVhbfmZG59lqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY8K4BX3pa7l6Of6F4l/wJSdLI/sXdghMX8ro4hgVVE=;
 b=hZh+9/9qXp0HWidv58l+UpQqivQxDr8bm00uO3O2ICT645AaRbdzoSwmw9TF4Ogc+URwO7QX+fh80xTr7Xn6uEnLo3dyA7eStyHr2rhIJsP7Wlqi1/EABfasEbrozbLUa2Y8L8RbM3fHOALPA0IWOfafHpaUbyjirBzHcJI2cD0=
Received: from BN0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:408:141::24)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.11; Tue, 11 Aug 2026 15:49:51 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::6f) by BN0PR07CA0007.outlook.office365.com
 (2603:10b6:408:141::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:49:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:49:50 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:49:41 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Leon Huang
 <leon.huang1@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 11/24] drm/amd/display: add wait stream regen event
Date: Tue, 11 Aug 2026 05:28:45 +0800
Message-ID: <20260810213010.1703162-12-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 786e3414-8a57-42ea-a27c-08def7c02e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yrA9WdZNX7oz1nOuxfMBwicnC1Rz4sTOChE7kdIeURC671CJ/8FlIMgLaokMRFXycwI726rcdrOgoVFz1rI6IFPnOfRKvA26AYai0bafK8fWVx+6pf6HD62KHy0n4ndaTv3x4RMohUP/PfFtyp+rkqb2Kgcj+NQHBeE0ENyTsxTCshR83SiHSHMO3NaXw/+gP9S89vGeMDjxynQ+73uHS4NI5cjucMwghFPRt5CZwDUXiJNHB4WqRa1YMVRNol9oHmKzZm1YPHN7b6O4fxFKCUfZrkl7rOTK4dyTHZ+KW4NwcM3hiT2u/Z2zHvksWT1eK2U78KAoTKqlzGfNCiVJ5EIFzaEHipCKWckmSG2lqQU1uAYIWThx6ZLw9jM8lp4bz/fAjAEDbHq2vDaZPk9CWogik9dyCx8If0aMGQi+Rmq3n5P3VfKowppuB9lUDTrsEg15VNIKIHu8sOpwYo6jo90ToJTkOXWoEzhNBYT2NKTMGcK04H2ixH9cFMsScSKOlT9sWx7YaHsdrFCyqvPMRo1rP16Wfuhwb8/Pl/+TdxqMUIahbInK+K4ocMakMN9jSQfjplAqc6ruXgv7ezEe4VDkUinbb9VrScMrEh09ADd/6JpI4mN5bh2vE585PJvFIUom8NIWi2IGTuw1wS9FWeYpvyZiXVEl18KwPoJIvHIIXrpIZjJ26IN5PCqSdyVE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ufGcY6GFRk3bbqevWzsZto1/mz9yPC8Z/3qpgtDSz/+54YJskyresPx1+5aUOhs/jK3YlMQkE+7kMnQBtwEuGlPNwxlsV6ORWqhJwsDosO82BJ3FdANACCtiUaAc4X2qIhQ1ly8igJypAMx+z4PqESCOWU3f19QRcXQJMlgbQpnO/qMdpFOOhGnc9Kd5nIBDUOe0FDl/1QnUP/sidexNrYpy1CCGKLtozLMHLb4MnlXhroW/C1LIh30xRwzlxzWqQ8WvGgS22oQxBPLNzsfNAO/PYOaEUA0x2B2KrxLsp8071LkXDSR0IARElcnW6tO1BzwUS0WicQY1KscL1WG4Kw4zSSzFHQRhkNelpOwCiKisKt57FL/dyz6pBNTntP5ttLaZ0udxfvvowG/cSf95v6ZsGpgBw9CASobNfkMrCs997/ADwZXwfhNYTdgc80pX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:49:51.2203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786e3414-8a57-42ea-a27c-08def7c02e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY & HOW]
Add event to wait stream regen flag.

Reviewed-by: Leon Huang <leon.huang1@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/modules/inc/mod_power.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
index 02bee3b1956d..5d1275b7cd46 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_power.h
@@ -174,6 +174,7 @@ enum replay_event {
 	replay_event_os_request_force_ffu = 0x2000000,
 	replay_event_os_override_hold = 0x4000000,
 	replay_event_crc_window_active = 0x8000000,
+	replay_event_waiting_stream_regen = 0x10000000,
 };
 
 enum replay_enable_option {
-- 
2.43.0

