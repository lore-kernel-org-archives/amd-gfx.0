Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FBEC3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB46E10E37B;
	Wed, 17 Jul 2024 19:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X0P1gICV";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047A210E37B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHaGqZAgf1MsPV7xEXCSLRQIVcsxoqvRIcApoD+QGUDEYHSlcSq+RgTO7fYJPuyEi7A2FXUO6tMoQer2tlowsJhHHFhzdQoa5nNsjF7QOfY111DHFZxwpYCKAkIpphho6DiCjzk972TmFMvUfXxKurx11JfoMSqiUWH7qAuDj0iZnZh4356MuQbtB0azn5RVp75DQHlM8ZTUO3weXK/YlPFDAqhGcf9UbhGv2Hwz/aiUSpPL9jo1xePNSonp0ixPArGh1gcB03c5SmvRqOHWCN77i4ksrSw+dREPgkMV8wezrcOmHFHTNHn+e3M4vPnPVLwtndXlavGgVu+4S9yv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVIcun9VW6dGbRopKjCN6OLcux4ax6pjSNkGJHlXvHo=;
 b=q4G40SjLcq8OsI+VpG84EhjALVHYoRDjmN5AXeVsN+HsM4C6KXhYkCybHiyBpEc0Lpy6CQ2hfQQYz5MnfRqb3cySvSodKLbjAJamnr9LOP956ku0+TAFJ6Y+gq6jyyW3ApWMCjmqWhkwfT28/dN+P666maNIFPuxSCe3qjgAFRgbLFUdZXfOyuYSWfBr7ZxOXFiV9mYAGFHNg02Pxl/4aOayu8FcItZltBj327K+ueYjBfduaK6wK39dFhCJWet1C05nYQ4M3joE+Z4MAOZeTxOiQb+C6Phdu6JIM7LfnAV3ABuWoOaiNpo5HRWAi6YfhhO/vojvnlwR/k/KXsQraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVIcun9VW6dGbRopKjCN6OLcux4ax6pjSNkGJHlXvHo=;
 b=X0P1gICV8Cyzmy4ZHEPIxyzYX71XfUu+c5V/NCGH5ahjuATjRTjnumDaeKiVfsfeO31jCETB9ba1Q8GrSYyXqC9NKKUN+RoD7IKE2gCsKFfuLXXd3LNbgaFbBZBPviOTnIdMeDD6460Py1F05N/Tp6f/6cpgXq4BJmWy9QNvwU0=
Received: from BYAPR08CA0049.namprd08.prod.outlook.com (2603:10b6:a03:117::26)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 19:39:31 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::9c) by BYAPR08CA0049.outlook.office365.com
 (2603:10b6:a03:117::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 19:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:39:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:30 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Revalla Hari Krishna
 <harikrishna.revalla@amd.com>, Martin Leung <martin.leung@amd.com>, Aurabindo
 Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 04/22] drm/amd/display: Refactoring HPO
Date: Wed, 17 Jul 2024 19:38:43 +0000
Message-ID: <20240717193901.8821-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0c9494-1f8d-4519-1ab1-08dca6982dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DBvmNPCW2wnyI6hGSo8KkEloKrltnWghM3M6WkIF4WWnPOCTDA4BZ0QwSLgZ?=
 =?us-ascii?Q?+0qAy/tarJwKtY5bV/co7ezV+1JhU8qxBk6JO9GW3skEAVPz/od9bvGCSM3q?=
 =?us-ascii?Q?SQ4Rvqo909HsdOTkgiSWqgNe/vDgfr5JKQEQ66ep9pW8jYSzb89E6YY7eDBy?=
 =?us-ascii?Q?9kUUqN5+Q2a2EgHKWUb1ZPpzknL5HFuCQPSDwQu/caJFqeGJeMiHjMuvP0xL?=
 =?us-ascii?Q?a2r3bB62ch0V1G5P0D8n1f6vRcTHZvNxAXwKaWtomMRo861V90jhtoStPs+W?=
 =?us-ascii?Q?ioWml0DC70FdmJL88jYIqEeEZev6nJ9FZzBkl9cZ/7ZTVnyeLdzKbX7s839M?=
 =?us-ascii?Q?otx1boO+Z0o761A6w2Z0u0Vf7X1pxuN5pzOuWSDfCeTBrN/7i4txRXdD24sC?=
 =?us-ascii?Q?UVbt0NYhfcYEGohhVV0dMteYeZmJ8oR2/yDMgGQGrHpa4QxOozutRh6igFyd?=
 =?us-ascii?Q?Mcg0fFdFDezqvsEbCDsmkDffIvliL3bE/dFC05mPZ7amybwhxtRCi8SttDbC?=
 =?us-ascii?Q?LjckP4K23ZXXu9ezylUPW10TU7s4zm5EH41AIkGn/uxJGYD3TgIoLb6pqnjU?=
 =?us-ascii?Q?Hm6lwf4yHhULP32UtiXpocKZqhj5CyAnLkPTowSA/N0WWsvNw97FHA2DCX9A?=
 =?us-ascii?Q?7PuBoXjqI2RjPJ0Q5uzkOnBQM2e8N531DTWzuuE+y1n8CGgNDOM+/xgONjA8?=
 =?us-ascii?Q?T8EY7epsWMSoAwdW4a5HCDUWzKrS7TAGd8qJBJJFTdfOOLwoWfnC4OdLyHzM?=
 =?us-ascii?Q?lUftOOFp+pty3//OmrtBw5z4C4jrwBvE33T0fBSBC3zcSd7YGl8Egxu9hA/k?=
 =?us-ascii?Q?BaKYvBo4PsXZo61i4zCEjsegYztwrAnW+PTVz9k40fGuofbuovvEV4A/HUB0?=
 =?us-ascii?Q?fC4siteD24Srp1xa0h4I2Y0BSvzEvUrxXL3qEcagPixTwwo29QHY77ReZ/u4?=
 =?us-ascii?Q?JNcJcG9AlsXB5AdfAPzCTeaydJ53srDwolfklyr0zVXPd/xzgUKKQ/wCpk+P?=
 =?us-ascii?Q?X5PyAuiB/Azc8uE2cLjWqv6wqcgPMgrBt1ejMu2WQ0QCnFbA6ApFUktWmNuy?=
 =?us-ascii?Q?shHUQfqGgcNXJcIAthkUqhxsL1TzFMwnXzp4vGY92YIytFwyjuUHLHenj4IX?=
 =?us-ascii?Q?jRhzYeEwO+gqaW4XW93nXN8nUqI/dIKyWGpzu+uI9THdBjCEArME6HoAqTTt?=
 =?us-ascii?Q?nJ9Q/PEhoaExyNxHDHumNbp1mb1bvuAHP84EnBNbHrX7dAydM6C6zAGmFmsw?=
 =?us-ascii?Q?iIRkEXqlg2K7pcFjd1w0KW7fdDOI7DdaPPf6kSJayQDkoKQs4ISSqmSncNP6?=
 =?us-ascii?Q?WwrDB2hpwclOfn4BH3zxS3MvbsRg52ABHjWwfS2AmqOF3ReytjT43EX2lGyG?=
 =?us-ascii?Q?X4iZIpaiVfENInxWbrGq2GtzJX/BFd7jJaXevozxoaFUod01rFnnu2MwWz2H?=
 =?us-ascii?Q?HYAw/e/WS0hn+NXxe28cvCq2W/QKtpJb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:39:31.1927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0c9494-1f8d-4519-1ab1-08dca6982dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
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
To refactor HPO files

[How]
Moved hpo related files to specific hpo folder and
update Makefiles.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Revalla Hari Krishna <harikrishna.revalla@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile     |  2 --
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile     |  2 +-
 drivers/gpu/drm/amd/display/dc/hpo/Makefile       | 15 +++++++++++++++
 .../{ => hpo}/dcn31/dcn31_hpo_dp_link_encoder.c   |  0
 .../{ => hpo}/dcn31/dcn31_hpo_dp_link_encoder.h   |  0
 .../{ => hpo}/dcn31/dcn31_hpo_dp_stream_encoder.c |  0
 .../{ => hpo}/dcn31/dcn31_hpo_dp_stream_encoder.h |  0
 7 files changed, 16 insertions(+), 3 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn31/dcn31_hpo_dp_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn31/dcn31_hpo_dp_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn31/dcn31_hpo_dp_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn31/dcn31_hpo_dp_stream_encoder.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index ccb4b21338b9..b17277de0340 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -28,8 +28,6 @@ DCN30 := dcn30_vpg.o \
 	dcn30_cm_common.o \
 	dcn30_mmhubbub.o \
 
-
-
 AMD_DAL_DCN30 = $(addprefix $(AMDDALPATH)/dc/dcn30/,$(DCN30))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN30)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index e2601d0aba41..d510e4652c18 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -5,7 +5,7 @@
 # Makefile for dcn31.
 
 DCN31 = dcn31_panel_cntl.o \
-	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
+	dcn31_apg.o \
 	dcn31_afmt.o dcn31_vpg.o
 
 AMD_DAL_DCN31 = $(addprefix $(AMDDALPATH)/dc/dcn31/,$(DCN31))
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/Makefile b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
index c248bd86b477..7f2c9ee0dff1 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
@@ -25,6 +25,21 @@
 
 ifdef CONFIG_DRM_AMD_DC_FP
 ###############################################################################
+# DCN30
+###############################################################################
+
+AMD_DAL_HPO_DCN30 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn30/,$(HPO_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN30)
+###############################################################################
+# DCN31
+###############################################################################
+HPO_DCN31 = dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o
+
+AMD_DAL_HPO_DCN31 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn31/,$(HPO_DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN31)
+###############################################################################
 # DCN32
 ###############################################################################
 HPO_DCN32 = dcn32_hpo_dp_link_encoder.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.h
-- 
2.39.2

