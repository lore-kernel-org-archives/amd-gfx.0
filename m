Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DC6E6B27C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C4510E9C7;
	Fri,  1 Nov 2024 13:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASC8Y5lD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A473010E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEXiN+jJTZLz/ftPhyRsuys57O/GHDR/nlJ0upk0lFaPhwVDESvkWTIoysEfjy6zse0Be3V2y98eY/jSaBBHTf2u1Hnqu854AJCDbkdzGoyVvW0iuWR8yPtn/k643dK0S8wazY2C/rc2ZZXbM7N4o9qo9JktDzK1CbnWERS5aMBvkDPsIqJJIhmKptRqOZDo51Rw8DOUxeukHrk+bUl2NTjkLdiZ69xUbcfmwB2SjwWBBbj5tD05ShJ0mjx89mpv0KAJMmnWuqG3iM7wua3bKGJ7WbaoXUtSHLSfx/eQkOdVGx1FhfOgiP3MSubUS/JVuRQkgmgv/DBNSeC4a4GfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6euFr2uJsp2jL2wiezmI5V+dmmQFk/hJiR7vbfIecw8=;
 b=EeS40+q7Ms1woZZL/7XRs+xZ91g5NW53Umazy06b6PNZ1xWTQidYP891e+CfBeV4rlw+2XDcA6G694vD6qVi2CMtfvpyxTIADSL60tTod9nlyF3T+8eGsyeSTYuA1vBW/NKv1FKNK8D4fe1sMLiduPAGrvEr81R0Na9sAcOxYhbMe9AsndlKSXPMKw/zZUfJ5d0LuuN15v/aoSBa/nGnup+m3cCbEipFzo1gaZW2dRrIss69L+KNk0Bj8I6orLWlNGlbr0Nvq0mt79KE/auG/ZJvnBB4aTjETyRH2MVuW+dpeck+DGeaC/ntWHakdjpDA3woYoTxzr+xrsB/Im+UEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6euFr2uJsp2jL2wiezmI5V+dmmQFk/hJiR7vbfIecw8=;
 b=ASC8Y5lDU2uxjHlk4v6aOKAXMHfI22A1jWZ32zPG/7eI1v6ncZImesFJVRJhWrPU+iPbNEJjL+QxaSXWQVdSmeMOl0+2LVnzzPfwLQvXSFxaydikfvjbAse9EwbWA46FlBGXXieDJz6A4vOr6CYEIdL9fsbRdZEmQzH4rIfT/7I=
Received: from BN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:408:e4::16)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 13:50:10 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::23) by BN0PR02CA0011.outlook.office365.com
 (2603:10b6:408:e4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:10 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:08 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 05/17] drm/amd/display: Remove inaccessible registers from DMU
 diagnostics
Date: Fri, 1 Nov 2024 09:49:28 -0400
Message-ID: <20241101134940.1426653-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8b4fcb-edb9-4abe-6ae8-08dcfa7c1a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EbckptKUncdhvm39pM/L7O9DEhcNJHPBYslZdbxq8q9YnrsRRqSv9znEVlJq?=
 =?us-ascii?Q?10wMGONaEjDg2gGMRl5k2p5/AQp/3iTddDtRXpg0//P3FrzoXAMlG5pzn6e5?=
 =?us-ascii?Q?zsv/xnACQT7o9kUetZ9AOaEO3Zq01cyaUsN2nQHSvrgpo03pLiAsPD/f4zU6?=
 =?us-ascii?Q?9byCpRJP7ZvoLyhNXo+upx1FqSRxB16s6V5qWI2YlpFH/kuIeQeYolMUBqWQ?=
 =?us-ascii?Q?WupDYqvvF6nGa+DW5KOWtQHE4bAX2z8tAnEbCFmQrXgmq7RHhyP9nK6DWBsw?=
 =?us-ascii?Q?pmf8Z8VElTLFi4XbZOMTwN9lBUvx8Zo+H5fLVsk7XoT9LbCUna5+I8T1+AF7?=
 =?us-ascii?Q?4AMqMWaF5NwmKFPdAQQGV8Dk465T8wETJvyE/31utmQRASATgDJeji+KEPuM?=
 =?us-ascii?Q?k6fYELziyDZKyfyuyyIiOeeG4zoQa8YV5p76MA4D5fSQUGdeVNJcIgiICebP?=
 =?us-ascii?Q?Atl1NT0xhjT09dEi4QYtWaUya5YO+qOBAXwuWivZM1lQkHAvtEL8EIJ229UG?=
 =?us-ascii?Q?D5Cq9XN04QNrq0pFo7IaV2Mh7IGdDryUQ8sz7+KnUa4IDEeLR+XbB7uZUO+4?=
 =?us-ascii?Q?JC5miOq7gyBXbucReTW5+aO2dZhFnYOKlXW4agp+u01/DUzGp6PYh9Q5ZyAr?=
 =?us-ascii?Q?iEsFOOOJvhJTfnAQayI5W/lxQoghdofKzCyURrtyHJpCqZaIIoXNgLU1svIF?=
 =?us-ascii?Q?9f2cYEsHO78mtPToaeaOmNRYKxlHTj7/vHyfG4DlwLwFjaNYEaOwUBsEyhzG?=
 =?us-ascii?Q?J3D/JmStsENqW0rC+qsULVZFOIZ4iuEwHYL2bMPFCFRGsuehdyNTv7tu49Dn?=
 =?us-ascii?Q?JIzh65WkI9WEclZYdZ+IFBFO1uBHz4w38d5PhLHvRPVbNjJMY267PgdEQ8j5?=
 =?us-ascii?Q?3EgigbjCwoFzF+26YsvWR8kKfPXwio8cH38FKQC+R0d48sLABXLWUeGNOGxl?=
 =?us-ascii?Q?lc2eoeusSlWEgvcD4ZpD77KkUlqhpMeIiKy+4gfl3FofTUxfSJYAipd4zCqV?=
 =?us-ascii?Q?MgW94y+SELcz73CA34Fewc0IYvqNbr4c41dQkVh1gKwjb3zIs/bxhM4/Y22b?=
 =?us-ascii?Q?ZrmoBtpwPepmwSQAgyo8bYMumwK1K/kMDVOiAG/InYveZ5sxncv7L3Y5tdED?=
 =?us-ascii?Q?UNebenVCHwEqrHhRluDEVvrGCQ5BNqXc+SQYXIV1RpxclDRTbxqjoV94SD01?=
 =?us-ascii?Q?CaG7ee/PGCakimniuLHGFdaILvjCHhrGPsk7LGnPKMk7KMcjOjosSvg8xkLT?=
 =?us-ascii?Q?v6zjPqbc58OmK/SMSC2XOr8i7JOdi3uBkH3UA/kf+tPSfhz12pwUzmhcNQDx?=
 =?us-ascii?Q?IEpQAew2n1S/31ACcOK0h9Sx9vp5Ylh9paMayZKcqQMlRJ1PYFaAKt9yRR7v?=
 =?us-ascii?Q?L5+hRz0fCsyJ8MU4ymHlVtRaxGM614EOeGjg27dgg3kVDbNARw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:10.0862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8b4fcb-edb9-4abe-6ae8-08dcfa7c1a2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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
SEC_CNTL isn't readable by x86 and can block Z8 entry if read.

[How]
Remove the read.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 3be315f1a443..e5e77bd3c31e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -464,7 +464,7 @@ uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub)
 
 void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
 {
-	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
+	uint32_t is_dmub_enabled, is_soft_reset;
 	uint32_t is_traceport_enabled, is_cw6_enabled;
 
 	if (!dmub || !diag_data)
@@ -514,9 +514,6 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	diag_data->is_dmcub_soft_reset = is_soft_reset;
 
-	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	diag_data->is_dmcub_secure_reset = is_sec_reset;
-
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	diag_data->is_traceport_en  = is_traceport_enabled;
 
-- 
2.34.1

