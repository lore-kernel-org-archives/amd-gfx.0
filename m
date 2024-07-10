Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D284AC3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E6B10E8B6;
	Wed, 10 Jul 2024 19:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMd/5zeJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6946110E8B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfhY+5dqNW+mTQr29KjiXmwyHBSVpWzdct40sgIyzR/yDg4/N4zgQdVFEKgX/VDb2D5M4wRcC0IXIax1PSIfID55MQoPrXFzTzp001X85qDcamHRfG/+0yxzLyJffLe64UW8Bg2WlSU2RLkyuQeikPK308m3enyRNyfusm0vb7LzSQaTqSt/2mxbWzpgHoWh0KtcYUnCuV82ghmrtV8192mPSRZkJVbKrHm/THNZlR9hDlaJfc/qMU8M1z5hAS1qowrd9jdDEEx6YsjdY8uxXKKyZvWFklrQKuABnEQvEmEmWOR3vZJzqi0l5HHc+BMgGm0aORrPZuCiDFaWFzy0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8l4upmcpjbsqKxaXYjzgieiSk5Tb05LxM4oDP8QyPU=;
 b=k6ME8FlJJCDJVVSm+u+a2Ig/rnUNHw9up7GG38vXXSVJjosW1rfjeH/xbujb4gyTqHX7dmUTurr+y8PH6sDLxUWTzvsaR6v/Mp8mBJvP+W05jjdx+SHNJLqv//2QZZVYrUv7+FqC7ub5+TlJsARzCh+sz3BN6zoR7E25D0sOUrkcfWiVG00iz0ZMTnDFmlIz4mSlSR4yhL5nDVyCf6XkW9QEa+sDVjUiWFYt0FxxVshJ8QTZBWw524jlw/ox7BOSufd1nsQVcV0EmNQ7ckID/ZkJoJTMxwalenORcKA8K/o6vDAXZ481GdytatVmoJxkNCRCIM72qim219kgLsLFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8l4upmcpjbsqKxaXYjzgieiSk5Tb05LxM4oDP8QyPU=;
 b=jMd/5zeJxy/WR8XoPl2qO2LISeU+D7G8n9jkjFxCVBPTKa/lhRdUNV/9Jd2NK5grHgKZZnyq4P8KxHg+73u24FvegUbu/GYzZSn/itj8DEV4lGFM+af6OQjwgICCtCM8iQw8PDHrNrzRttJy4VjoOlbpr89D1n7hTcBO3g1R1Es=
Received: from MN2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:208:239::6)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:39:09 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::c2) by MN2PR08CA0001.outlook.office365.com
 (2603:10b6:208:239::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:08 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:07 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Revalla Hari Krishna <harikrishna.revalla@amd.com>,
 Martin Leung <martin.leung@amd.com>
Subject: [PATCH 24/50] drm/amd/display: Refactoring MMHUBBUB
Date: Wed, 10 Jul 2024 15:36:41 -0400
Message-ID: <20240710193707.43754-25-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f61ed19-6381-492e-8b3a-08dca117f7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0dXeTQ3cWw2ckF6TndMbzZkdmpCZlNjZWZKRmRGL2xLazBLMG5GOFlMUVNU?=
 =?utf-8?B?eEl1Rm51S3ZGRDljTkdnd0g1T1lyd1VUVERjRXdJZDlNcHowenFtb2VGSStT?=
 =?utf-8?B?eFQvT0pWUzY2aTlkWWVTQmV5ZStXNkVBTmhkRmxubms5eFhxK0lqNml3RktX?=
 =?utf-8?B?UXhYNEFKc1BYTis1MUppR053aE5CanJzU2c5UTVqdjZ3ZGU0YjAvd3NoSVo3?=
 =?utf-8?B?aENPOFN5NDZNeHRkcjJPeUxheUxwNk9TZFZ0WHBKZk1uQ09SMFdUOUI4dFpR?=
 =?utf-8?B?NzR0UVhIOVBHVzM0V3g2U3NuZnkyWm9NMzRvUUlTZExVSit2NWpra09mMXJ0?=
 =?utf-8?B?aGxmZG52T2t4ZGpFdFNnUGJoajdySWJBNVg4MlhLYlF5d0hQTDVUdWNQeitN?=
 =?utf-8?B?djE3SForbzVWZmd0QVIyR05aUGd4UnFVOWl0OCtCRHNoZ2IxbW95enVqYnF0?=
 =?utf-8?B?alRKaEI2SE1yYk45SzErcUJQUXhJWWg4M01zN3E4clNpUlJDeElncDd1ejFt?=
 =?utf-8?B?MktqM1MrVTdWWFozS0tQNTlpampOYnZUS2ErKzFYcHdRL2NmTGhEakcxRGEw?=
 =?utf-8?B?TnY0ckMxUDRNbitUWDFDYmVtemJUamhxcU5HUWxPaGtYS0dtanRobWU5ODNp?=
 =?utf-8?B?MHJIV1V5aHA5b2dVcE5DYW1YMDdmYlFWTmU1WVcrU3ppT2ZIcWcyOVZ1RW9J?=
 =?utf-8?B?S3I5czI5T2Rjd0FYSGRPZ08yeVpaVGhRa3NRRml3aUVMV2Zsa2l0bVMrdWpU?=
 =?utf-8?B?VVRPUjZNa1p2dFl1WEFBUXFNd1FXSm5CdHp6RkVlcWtJZnYzTlZ5Y0tZNjJy?=
 =?utf-8?B?ODRBd0dUNkVZYzM3R2tQb3EzajN0LzZnNjlMc0h3QW1wZVhiNVpWU2pBd25v?=
 =?utf-8?B?c2VINnA0OGpWcktLbFQ5NHBmS2NzTkZWb1MrMVMzb1NnaVZibHBBRXhtK240?=
 =?utf-8?B?YXFZU3QvWWprbSsvSHB0Y2xsN3BuS253MFFQeWpGdHA3eTdQbDIrVXpzQnpV?=
 =?utf-8?B?cXoyOW5OSkpZQnlXdFBwMlBOVWRyTTNacEhYYzZBNnBCamhjRFJlcXlxcjhi?=
 =?utf-8?B?dTNLWjlDdUhhWERjUGdVaXUzaXBlQXZCQzRJcDhkd0JSU3JLZzRFMVFxcXVL?=
 =?utf-8?B?V0RxbjgyNWdGWi9vUXp6RmZyZlE1T2swSHFlajJmK0x4bUU1ZExrVnRkWWc4?=
 =?utf-8?B?OVoyL0xxTlI1RG9taU5WZk5aTm5GN1c5Mld2MTYrU0hocTdXUS9rYkdaeXI5?=
 =?utf-8?B?eGhtNFVweUJNcFQyNnhyaGE0OGZkakVteS9SOXJFY1pwVDFOSUxYeU1uSkZY?=
 =?utf-8?B?aEgrdUhSZjF0dGh6djE5Zmh2RS9ZNFpveGp6ZGNyRWIvRWhPeXBxQzkyNUhp?=
 =?utf-8?B?ZHpnZ09hbXQ0UXFqOFh1QmNBeDBsOXJFUzF4RE13Wnc2WDJTd3JYS2dTS2RU?=
 =?utf-8?B?cjVuMldaNzNGWkdpSFUxZkJZT0Q5Tm1oeWU4ejFQVlR6QzZyUm1pYlZOYXB4?=
 =?utf-8?B?UkpxdFMrYm5zd2JxK0hyVm5MbStrMnl6VS95OHdSRXRTRmxsdlFWWjM0WnAx?=
 =?utf-8?B?SmhFdlNWWGpmQnBpemhwTysxMzRCTXFIV041aU5aUStvU3NaQ0RyYWduL1p4?=
 =?utf-8?B?ZDFpdmpocXF4Nkt2dU1OYk5TVHBPcVNtUlRRZTBSZXByRUNQRWVIYU9wOU5a?=
 =?utf-8?B?YVBqcGZoMVRTV082Q1VKZ1RsZkxUeUJBUldhVU1Ba3ArTGJzNHFaU2ZxSHly?=
 =?utf-8?B?ZnEyd0pxdjFoMG5rZ3ozb0R0NHVKdUZLYng4ZUd5Ry9ySVR6Ri8vNjZUL1k2?=
 =?utf-8?B?OGZkMFVhN0VMa0ZrT1ZBdi9PMGo3QnR6bHRsS0RjN09STjRHUjNBOFd6L3BW?=
 =?utf-8?B?TEU1cXpUK3IzN1BreUFmMUNFYWRoMFdLSWhjc05pMGVsRnRBSEN1VUJJMDRC?=
 =?utf-8?Q?c3gfRuuGiUeddsuxPADDh0J3P8NBQ4ko?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:09.0662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f61ed19-6381-492e-8b3a-08dca117f7c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

From: Revalla Hari Krishna <harikrishna.revalla@amd.com>

[Why]
To refactor MMHUBBUB files

[How]
Moved mmhubbub files from dcn20 to /mmhubbub/ folder and
update makefile to fix compilation.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Revalla Hari Krishna <harikrishna.revalla@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile            | 2 +-
 drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile         | 9 +++++++++
 .../amd/display/dc/{ => mmhubbub}/dcn20/dcn20_mmhubbub.c | 0
 .../amd/display/dc/{ => mmhubbub}/dcn20/dcn20_mmhubbub.h | 0
 4 files changed, 10 insertions(+), 1 deletion(-)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn20/dcn20_mmhubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn20/dcn20_mmhubbub.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 744a6c4ac816..d92d2b4ee015 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: MIT
 # Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
 
-DCN20 = dcn20_mpc.o dcn20_mmhubbub.o \
+DCN20 = dcn20_mpc.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
index 505bc0517e08..eab196c57c6c 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
@@ -24,6 +24,15 @@
 #
 
 ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN20
+###############################################################################
+MMHUBBUB_DCN20 = dcn20_mmhubbub.o
+
+AMD_DAL_MMHUBBUB_DCN20 = $(addprefix $(AMDDALPATH)/dc/mmhubbub/dcn20/,$(MMHUBBUB_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MMHUBBUB_DCN20)
+
 ###############################################################################
 # DCN32
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c
rename to drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h
rename to drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.h
-- 
2.34.1

