Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E5DCFD65C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BBE10E636;
	Wed,  7 Jan 2026 15:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lAmN/FyM";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A1210E639
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxdjMMtUvWY8lZLChePXshZZNBlZbYh1ulv0BkD2pvGLn1QAZB3wvMqDlSTAGEJwuBJBAo0Xsuy6MagforzNdCzprihvTNZNhvE/ug/+viLJVk1mcX2Mxaqdr8uN6xk1Jb/KnN6oG5UBD+zxEaYl88yeAMt5Ip99uiU+1Kmx/A4JgzUEyLYweT03u++hEg1NiAnDI1RfjHTLZLP/hsh3QJwDOFaQT61kUmyuX9k9N99fTNGFRjeczcu1OSSOAkesDwutLLt+Z2LZKoYijBCBETXA+h9MlRUyVE4yCq+4X8NFpN/NJwDsIqkAB7o/NyWh/Rk4iBcxI2MS++sCAkkU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nU+rBxM16GEueQwpK0fXaFm9eO/gRa55HWNvr4ZEfY=;
 b=huVoih9w0+Cd9hTqNiarZ04kEM/VfV7rkqnEFlxUN1NrxO1+J2zCyn/IMSn3Q3AuEEHgwpR6RR2/De4XwpHODMLUluKhcs8JJOZSYnjtKEIZSEKShX5RKDYEu/LPLgUaP/dX0Vbj61MaAebcRbXxvokqGTDcvEruuLr7kOEzF3mQpJo+3sQe/liadtdTMfsuOCbOq/uKHcB2r1+otQd926vWaiRb6gAmTVwa5CX+n+noHpjWDiAWrxtsbUoYlY55u8TVTUzQfYawZ/2FAlXrYMu3QrX53s+6BLHQUkvJRhqP4nJVAM5cgW0+cS2JTB8qOZfd5h/uSFjfi+rc8wuoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nU+rBxM16GEueQwpK0fXaFm9eO/gRa55HWNvr4ZEfY=;
 b=lAmN/FyM2VpPjP29cGin8yl89Q1EtK6wKqJf6j3BG4xWBru14VYNEekKYCLWZFB2zQHJ5/lBgLbde5haf8cB3YtRhvmTy7V5GE54/RN9pTUA7hLyP2o6s+VsuMq+ALc2M3RSCiQMKLeIQ8660qNDBrNx6azG5uZ9nM2iRMhqblU=
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:14 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d::4) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:09 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Jan
 2026 09:58:09 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:08 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 17/21] drm/amd/display: Add pwait status to DMCUB debug logging
Date: Wed, 7 Jan 2026 10:48:09 -0500
Message-ID: <20260107155421.1999951-18-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 77939d70-c44c-4d86-9585-08de4e0590b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qb+IW7UdTQzjYGI11X99eVs5uzn7BIOK1g2Wj2afzdVjEM7GEK5ueWbcm2GK?=
 =?us-ascii?Q?WqOWPx3MVvp8YJai5EdM1bQybo7o32hPJbGFK2PPjqOo2Jyl/HPAhru9Fbvj?=
 =?us-ascii?Q?4WbA8x2b7Y+JW7ZOQjD2bJD+ExzJT7QalRKMZl8mHEbcnvoTMEcwJx3xeW1g?=
 =?us-ascii?Q?1K3yBoot9GsFfm/VF17uE+ggmIPzCAXg7V+yk8PX//JRR/kRYMOSK4iwElpK?=
 =?us-ascii?Q?/ey16KNfo408C9+xHFW9GIZHQ+FOXyGsIB6Fpo0tTilo0dbQLX3mUohTbMAT?=
 =?us-ascii?Q?FacbW0nTZcd4XVM7etxUehX/hfBg56ahcbhYJ+7uM9B4eka8ck9396QRVM06?=
 =?us-ascii?Q?JTSTCECqg/qZD9a6sJKQTcA9fjcVIUZ4ueqttjZ+u6ioW9ZW6B28WT0AepvE?=
 =?us-ascii?Q?FUbf/Q3gugdqeGLNjnEyLMNIulkPiLloce58TXtw7UwCzaTQYdvoNMg4I2fl?=
 =?us-ascii?Q?kuXuhbY3u65UZz/ULH7w7+xWglElDN/FxsrHYYkE9vtVcqAWIM9TR/F3Xxvs?=
 =?us-ascii?Q?clXqH/myy1EjFEPxGDjoubOjdlaspPHPgvqlYfHw2ZC1RxCPrmD96Chy/zyj?=
 =?us-ascii?Q?+FPKN1+tByxHgIG4upfuZsOJ35wAOKEQnqrCxiWOCOJJ6ty6uV7Y3pqixEHD?=
 =?us-ascii?Q?tng+c8wTUjGaNvsnM7LPkZbRWFflGDR/7PGMhK3rGz/U1ULGY5ZoM6qqxkA1?=
 =?us-ascii?Q?jdU29svjA2h/Ish2+iCU1cm99etK4b+5aFEjzeq6imTTEASuFH6Wc6pCFowr?=
 =?us-ascii?Q?SZQYaxNsf/5kdrQHWYd/W89peALFIAVqHnW9NHKUZmzSjpZOLlJw/rPpv8l9?=
 =?us-ascii?Q?MX4gZQThhGe+YfUBUmLJ5NLGGocAa1MOzZGv1tmbeqX1F9nYyconqLWxTAhZ?=
 =?us-ascii?Q?F3IboWe8+e7U+ZyESPsEvM0w4UHhAzfSU34qzcEIMkJGxO2f33oFB6wdj3eY?=
 =?us-ascii?Q?zSLXaJtgB00A8CAD2ci9zGGx1GR9hX2KO7PZ9q+PFLaXb857mPiBDr4Oq+8x?=
 =?us-ascii?Q?ASUvlaX6t9IZZ3aw92RHlmOYoBscPsOeLSqsaFniQKucNQlJbHabG51e6Y2h?=
 =?us-ascii?Q?i3FNI5PPxzDeeDdE0sgy8gjBnWoiRXLzQgGMU2T9jPnjendhSEEvAvQtdiSv?=
 =?us-ascii?Q?c1QWpwx98Gw5i081HwoAePz98hS9bkCZpf/CAvYIPCt0o6HCU27Xy62CQmLJ?=
 =?us-ascii?Q?2Gijcei/z7ymey2uRZ617FL288cjoVAvrgQERgnqsf0Crhst5mObi4eNWPN2?=
 =?us-ascii?Q?c1a08TYixRzSSNF6MODjh2tePq4pEKqc5R5Ht278UT6ZIaSdvkfK4ZOVwlHk?=
 =?us-ascii?Q?IToRhyKmI4mjwS0QmvCXrhSAJb7OJWDqWhncWYIDkGSkSrOHgrz8sEKV3KhV?=
 =?us-ascii?Q?mdNW4fAFcTHGxaCoTTHaMUA6CfwR6UNjaOQ39OtOf9aL7LIMLv33KHvR3ivp?=
 =?us-ascii?Q?MSvaATyRPTnzDPUSpkHxM/F4JCO7b2dZfcr5aBZt47D07Fbx2HMZCcpP1JDJ?=
 =?us-ascii?Q?CXegwb1lwpu5sd9nr55oissjvzyxQ7iH7ik4dqhFVqmINhYX+k2JT0MHts3t?=
 =?us-ascii?Q?cpobI7eDnYoxWdgpEbc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:14.1825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77939d70-c44c-4d86-9585-08de4e0590b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
To know if DMCUB is idle at the time of the debug data being collected.

[How]
Extend the logging to include the field.

It's already captured as part of each ASIC's get_diagnostic_data.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 602655dd1323..2dc6ae6b5bea 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -999,6 +999,7 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 	DC_LOG_DEBUG("    is_traceport_en    : %d", dc_dmub_srv->dmub->debug.is_traceport_en);
 	DC_LOG_DEBUG("    is_cw0_en          : %d", dc_dmub_srv->dmub->debug.is_cw0_enabled);
 	DC_LOG_DEBUG("    is_cw6_en          : %d", dc_dmub_srv->dmub->debug.is_cw6_enabled);
+	DC_LOG_DEBUG("    is_pwait           : %d", dc_dmub_srv->dmub->debug.is_pwait);
 }
 
 static bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
-- 
2.52.0

