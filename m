Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C974C3DA4B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 20:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D4C10E12A;
	Mon, 15 Jul 2024 20:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVPl1j1S";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEE110E12A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 20:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAfjwhGe7JAlGnTztw7ZKN9Yn9yDlL0hFO+eWvt10AG9Q42mldx3IKQ3rlF+VKviGSdj8d5m8fcXHxl0D66gzlaag0aYx3vxsWABLL9izOpbjfOBefoOgEqn4Y30KSNMNVFp1A22X3DcKGq5qpIKIjNlzp0yh3udoEafJbhsYHGTZnWEYso/6rAXxCEry5k8TIOaiKdwGErIpkkiLB8mg5IDixTCO5Jb8+uu6zeloBwGo0OqpJ56NyNkoUn2aUfuXTgLK0JzPaonrwTm3risqXUawkt3IOdE5TFpgakz4JTt88LFyit7gat5kwowW9Y9e2ku2ZTygbsXjIz9pjywYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdbdLhjsLdzpegqE5jgPSdDeYxw6jjnEwv4mXaog5uA=;
 b=awW4YfatbZ08if2OpOfDlXjST60yDX8M52gFHmw8rproswJ0L+Q4OkRvlz9R6htZfpkJ0I/hJR62L651PdNq161aksP3QlMaS6nz0b3/ElEnFnWQtKOfLaQMZk9zK0oL0byeJTn6YxY97BX/j3zdiduZ4PMjLdMnpK8Wcg5ZGOcVvnxMmJqDDSBAEow5OfWm6NUGCU0CecbL0I0yeuE+qJRpCOWoWBkRwJW5z90knKiZqobmHcXPAQOxtsIS+TbrYtoqjelPDWf/KsF5gzbxQ6OxmuYQ3GOe5QTP5mAKD6GtTWwPR6/p73mEA8inqdbNbeQvtPhyfUpWjGOE+QrjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdbdLhjsLdzpegqE5jgPSdDeYxw6jjnEwv4mXaog5uA=;
 b=bVPl1j1SM1LawjgTGsz/yN8kUFaZEcnG0Tmk73ljybib9u2uboouRU8v/1eAoFx2rRp+yNBoeXCEnesGHvM6rRI47FlfTSF8LY8dr70VF//0Zt0kuYjEEsjo4aZBX+Y4X0gK02vnhar+qM2nPDnd4+yd99VfoXaW9dViXr2IJRM=
Received: from BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 20:39:40 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::74) by BYAPR11CA0099.outlook.office365.com
 (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27 via Frontend
 Transport; Mon, 15 Jul 2024 20:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 20:39:39 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 15:39:37 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, Roman Li
 <Roman.Li@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH] drm/amd/display: Add doc entry for program_3dlut_size
Date: Mon, 15 Jul 2024 14:39:08 -0600
Message-ID: <20240715203908.3679450-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fc8c0b-58da-4ec2-8543-08dca50e3f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCXhdiOpyAtsEXSv6RVXuMoxYmHHkNwaLM7QxLf0UnqFj7dIdSMlbKaTToKk?=
 =?us-ascii?Q?0ymb7AhfFwn1vgVQDiT0SmY53uTN0R8Cci+nEwYcWWQ7gucR6gj7ogjEazVv?=
 =?us-ascii?Q?/WTX7RZ90IzZuIT3oqZfkE6Zi/1egCZbYfsHtF90/duAn9QrZLOwRkQ/68V3?=
 =?us-ascii?Q?zMQSyQ63DbZa6VoRqGIke++akVpBaj/TD3HxPSfeqpf5X1oy3AF9Y4YbLoX9?=
 =?us-ascii?Q?QbzYOk8mFpnwGbzuh0HMV4IzPHySEaWSEyxBzdaDt2VE/HJC+wQIwWq//v+3?=
 =?us-ascii?Q?/LpNMEUdltR77zG3s3mICo4X4DPPiuG2JgEjHL7GGG8jVCyKkxdVfWaFBHHD?=
 =?us-ascii?Q?QyY4gD9Khgl80EuRDi05iHET6ljqLbO5jTEAssdUCRkvTXTzHS1nU2iepQFX?=
 =?us-ascii?Q?rfrJhYshOJ3MpvI/nOyQKeEnyX74PMPf+IJxkW/35uo1ufi6+V9vkaSHzAQs?=
 =?us-ascii?Q?e8Zs/3HKXNf6GBSxTXlJS2xalhULjZPaCYus9CaLmdd7sRMcwqcKUQCfm2lk?=
 =?us-ascii?Q?Oeo2pYDga6J1ZDsUcBSM7phPh2HjEvZgb8GOONWSsNIoRaNmAGWCSbI85Zhx?=
 =?us-ascii?Q?kJgzSOA5VT+hqwGqkra57LQzN6qTXMbYl50KwfP0HRcOyuqFJEzv7LWboQLE?=
 =?us-ascii?Q?O2I+12COHR1jvCd9K4H9o7iJA7EBE93Fu/A8ZOajTavPxwMoG1nL/e6GxGij?=
 =?us-ascii?Q?ew1vt257ajQWC86HofxDvLWM2vBsSQ2161wz02HJUgf0CxrYb62ztsuf83G6?=
 =?us-ascii?Q?IXyEjXgjbFw7PEf8nXEFxURQEMs+LmpOJk4n5N3F+NFdBmQXZ36ZBUhbDU1v?=
 =?us-ascii?Q?LBG4J6jFyIPR/V4EpLYuYa5vkXXpftEdKwdEM4nIGx8p1Emn/FLXX4XJv2+d?=
 =?us-ascii?Q?o9LIx/wfaWbItXpFoJ5a0ZKbx+u2L9gi+YmSLGXeylottbry6rG96zVMiG+q?=
 =?us-ascii?Q?Qz4Wp2Kk1k2P/Z9aYVyf8VBRPRTiPmpDLoJLEL3c+YbeByMdn5vMV/PpyZIh?=
 =?us-ascii?Q?514kyFJdRrogpkr+ufLtYf9VcDq49L102oCbvZxok7fPaDaLd9nSqh7tciP6?=
 =?us-ascii?Q?zminPoLcGYPZcJC037YdRRfs8VIV09VRVsh7uO7TQpFgDUDEThERJSQh2yrS?=
 =?us-ascii?Q?gufmgUCQOVAh7LBL0VKTv1ElFmlKqgGPOBAKceMWTCuQNFcr1SoLMcdZD+Z2?=
 =?us-ascii?Q?2Ug9bi7MBlas2oCssoQIoMjILLkcJb5XnSY2YC6n7c6PwAJHpIHw1oxVQTOz?=
 =?us-ascii?Q?1OtBgoZjokr0bxr2vMehsoxhsnPIQATaDELeKI8ju+EWwjKtKyCJ6xjYTAPH?=
 =?us-ascii?Q?nZAOSzKHZE8fqPI+uaBI5JT2BlclASVAF5BUoajn1DA0kjGhSlPJvnE9dbIE?=
 =?us-ascii?Q?gfSr+KKrq4beI0+TZdfuPHbPGI59nh6zmpGwKzERB3FtbHAlMNfjxxN7JQV8?=
 =?us-ascii?Q?5FSwmMogKvqBsOWSsqHyf2C4kLhJc7Sf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:39:39.0800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fc8c0b-58da-4ec2-8543-08dca50e3f72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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

Fixes the warning:

Function parameter or struct member 'program_3dlut_size' not described in 'mpc_funcs'

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 40a9b3471208..3a89cc0cffc1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -1039,6 +1039,20 @@ struct mpc_funcs {
 	*/
 	void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_ID id, const enum MCM_LUT_XABLE xable,
 			bool lut_bank_a, int mpcc_id);
+	/**
+	* @program_3dlut_size:
+	*
+	* Program 3D LUT size.
+	*
+	* Parameters:
+	* - [in/out] mpc - MPC context.
+	* - [in] is_17x17x17 - is 3dlut 17x17x17
+	* - [in] mpcc_id
+	*
+	* Return:
+	*
+	* void
+	*/
 	void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
 };
 
-- 
2.34.1

