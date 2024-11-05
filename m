Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D915D2B92E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA6010E5BA;
	Tue,  5 Nov 2024 14:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U6Rjy3YS";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EF810E5BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZaDZ/JI/fuaY0GTQrSDC7Y+nLXV/RT5xZCZTIOKX73D/JGOrTexZWWzELYRXgXcsejX2DUtG/I3IxRwaFKZ7JgSVoamom9a/6ZpJSn79zrau7gGhlyUhyxfdYCqDuem02jI14NcGh3SZUkrRKn3yYOOkgTRtKjie1ujI9AfVLSQxCXNVonniCcKmxmoPCG98EH99R6t0tlrCCYQ1KSf7LrbSWQkbCVHHe1epfGhzl4tB8sQOqNMkYh9tFjSTMIZ2JoyI/f05paQnKNEAAGWHrzwiTGMVhc5YnlM4+zqY7/Q5KJjdNTRsJ6vIWar+hTJVwPubrz2RbshNbv/LdCPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+S7QbGEIhe4cSLtprMQ4nnE0SKLPXLSzNdbhhsBCfY=;
 b=ODou3FsWIuZ9LMg0CkUz3yvpUnlknk7MeWhL/9f6UTfZnx+4YjQBprvafSrMz08RY5cI+EovbunuhJue/+iR1Cmz3Bxfym8nB05GBZXVTfTUSF5TOendO050misu/0kOTLz4S5kZ/YBWrEVOPyQCsuYkxmY+pbWrMucxkY9HeJORNl5+l05jkB4cquCfY27hzZ/XPF0jL+x5r1HeZ8bw3xtm5l7iz6mczIBu8N9RbjVy/17Lvdfjt34+ZeIVg4GvUXRHXhf6L9PuMCHr1+9eAFkh1A9q90FSkAnax7i1iMlaebvKbyvxRWhtPRKCaSIZG0P0SrnDjJlJilZtnl2heA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+S7QbGEIhe4cSLtprMQ4nnE0SKLPXLSzNdbhhsBCfY=;
 b=U6Rjy3YSAXR235GqhPO6+VsPD6uEdF9g4gt3YdgpDfngLtADRz7EpJFsGRIuw2bcEg0S+f/GzPQs3fkrAgOiajfU7xtqwmaegnDh2D6Bl+i/Jirb2drSnU+tDyFjAoGKEeGrhvpzskQxIver291dM7qyAe9KU873OuoPiEBftqs=
Received: from MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 14:06:42 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::a3) by MW4PR04CA0359.outlook.office365.com
 (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 14:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:06:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:06:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amd/display: add clear_tiling hubp callbacks
Date: Tue, 5 Nov 2024 09:06:21 -0500
Message-ID: <20241105140624.2897662-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105140624.2897662-1-alexander.deucher@amd.com>
References: <20241105140624.2897662-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d6bdcb-b655-4593-54e1-08dcfda3134f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7T7nqm5iicxTj5e/xd/HhXMS40ScatLDY+X7vb3CmK7gH1HNCoDkFbtb8DS?=
 =?us-ascii?Q?dFmiLLHy8bLQ+j6O6v0KMyQDqT3HX5+kHX9wADYYI280mmEQDEFvyHxsjPKx?=
 =?us-ascii?Q?4mKYyKI1xTiRM66uiRgtt3cKNFQcntaRnAuACY5I4BIPtBKPu1jzvkMlSeZ/?=
 =?us-ascii?Q?DCdKv5X/OYJ1/aizNIFy3QzeQgpzubcIyvAHU6D+vo1kRCHvY13pXCYxZsLR?=
 =?us-ascii?Q?EurqOPsZcm5oYbzeYwx2eALfIUO8HDQxSPt1H0unQ5xL/KmoShZCgCChnJWa?=
 =?us-ascii?Q?mGREV4UAZS/eUszWdCdBZtncMv2TuMh7WVWFDRvWdiSZv8+Kjvy72VqpZmz5?=
 =?us-ascii?Q?15GQ3kx3feBfQvcZ3HparlXmH60yEvf9WiH1jKTB8DdsuUWlxGRn44+DMYoh?=
 =?us-ascii?Q?sDm2NnKTX/UvgDlnKv7enSA/qeLvvDDMRb7zN3JARpTsiN8Rjp65SZ5Ol+xz?=
 =?us-ascii?Q?4ATsH339AWknbOrdD7F0jeH7gXfsuUSMd7ZIHrD+Guw2ibvK9H5wF32egKze?=
 =?us-ascii?Q?0AqSNvosgM7p+1yYSfCS/isiEYjrAtIVHG4NQVw3nfjpthnQuXXMhanp/zfY?=
 =?us-ascii?Q?dnM4AKGC4nHYPQnZXNOVv26Hz4E27ccv0XWLng0dy/ETRTc8cQA5gZwaC5j/?=
 =?us-ascii?Q?bG+o7I5wmykYdILLFlAL9PWaDmh79ZXLiLaCKvS1rsCL9QFcAv4GbL6HTZg6?=
 =?us-ascii?Q?4CUXrhBjmDGlVtP9hx900vdjd7MDr2BNUllygANCSxTiNNkDJ3iPGN+egsgu?=
 =?us-ascii?Q?uZcgbQbdauTLwKhmeKxC/JrevcbpBrJteQ5x0OhrVacE6MVmrWO9bHAS13V5?=
 =?us-ascii?Q?yR2wmHucv/qKWoAMiICfaW7EzCUvSzj/E6BZ37CxT7GhpBtTTu0dmp0JMRm6?=
 =?us-ascii?Q?BjAWWLmL7Ys8OPPagvHv/YHTuVYZ2MNU2rLc1uYNCk02CUAq0sgRY+wBl6h4?=
 =?us-ascii?Q?7XJ5sLPH4f6NwlgWS9LQbgfnSiqoihD5V2uzr8NHSxZutHqxdKGRat2FbOkt?=
 =?us-ascii?Q?gF1oKNcI2IRWrAkDUB2LG5MWzea1hgVSzfFaOuj/GSwxJdtF14gskbBK1hCM?=
 =?us-ascii?Q?6KLTYfaVg34pImpL+TCc46ZZbqOm/3BJ+tabmMGMuPP93F/dbY/qDJq/rvOv?=
 =?us-ascii?Q?AN0ZNZFI1aqo+yhOy8MtcjnuIQcwm3DJ5Ak3o7HpjRaPQhGziLz+Ayu43a/z?=
 =?us-ascii?Q?SwcEfNsAPITPrK4ubxLXsk7lr7W2AcaQ/C/A5+BcAnPg9kcHzDsFXaSKhOak?=
 =?us-ascii?Q?SwNOVhJcCRVerhKLcTAcwOu7fboV1vNXjxNrYRpl/q7oFEVnxPv9lhhC6OMY?=
 =?us-ascii?Q?NaT9FVK9zPp3BGjgi/PCmIvoY0SPpMRTEXK6ZpJUILxvspCN/UV4HseSIecS?=
 =?us-ascii?Q?34+aF8Yq4lSECYk2HjeyAnbzGl74+XNZIVKELYw3EsXzRNj7iQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:06:42.3511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d6bdcb-b655-4593-54e1-08dcfda3134f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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

This adds clear_tiling callbacks to the hubp structure that
will be used for drm panic support to clear the tiling on
a display.  hubp3 support from Jocelyn's original patch
and the rest from me.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 .../drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c  | 15 +++++++++++++++
 .../drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h  |  2 ++
 .../drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c  | 15 +++++++++++++++
 .../drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h  |  2 ++
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c    |  1 +
 .../drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c  |  1 +
 .../drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c  | 17 +++++++++++++++++
 .../drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h  |  2 ++
 .../drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c  |  1 +
 .../drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c  |  3 ++-
 .../drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c  |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c    | 15 ++++++++++++++-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h    |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h    |  1 +
 14 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 22ac2b7e49ae..f0ba944553df 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -518,6 +518,20 @@ bool hubp1_program_surface_flip_and_addr(
 	return true;
 }
 
+void hubp1_clear_tiling(struct hubp *hubp)
+{
+	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
+		     PRIMARY_SURFACE_DCC_EN, 0,
+		     PRIMARY_SURFACE_DCC_IND_64B_BLK, 0,
+		     SECONDARY_SURFACE_DCC_EN, 0,
+		     SECONDARY_SURFACE_DCC_IND_64B_BLK, 0);
+}
+
 void hubp1_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size independent_64b_blks)
 {
@@ -1363,6 +1377,7 @@ static const struct hubp_funcs dcn10_hubp_funcs = {
 	.hubp_disable_control =  hubp1_disable_control,
 	.hubp_get_underflow_status = hubp1_get_underflow_status,
 	.hubp_init = hubp1_init,
+	.hubp_clear_tiling = hubp1_clear_tiling,
 
 	.dmdata_set_attributes = NULL,
 	.dmdata_load = NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
index 69119b2fdce2..631350cd4f2e 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h
@@ -794,4 +794,6 @@ void hubp1_soft_reset(struct hubp *hubp, bool reset);
 
 void hubp1_set_flip_int(struct hubp *hubp);
 
+void hubp1_clear_tiling(struct hubp *hubp);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 0637e4c552d8..200194544bf0 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -406,6 +406,20 @@ void hubp2_program_rotation(
 				H_MIRROR_EN, mirror);
 }
 
+void hubp2_clear_tiling(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
+		     PRIMARY_SURFACE_DCC_EN, 0,
+		     PRIMARY_SURFACE_DCC_IND_64B_BLK, 0,
+		     SECONDARY_SURFACE_DCC_EN, 0,
+		     SECONDARY_SURFACE_DCC_IND_64B_BLK, 0);
+}
+
 void hubp2_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size independent_64b_blks)
 {
@@ -1676,6 +1690,7 @@ static struct hubp_funcs dcn20_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_clear_tiling = hubp2_clear_tiling,
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
index 18e194507e36..7fd9240868c3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h
@@ -409,6 +409,8 @@ void hubp2_read_state_common(struct hubp *hubp);
 
 void hubp2_read_state(struct hubp *hubp);
 
+void hubp2_clear_tiling(struct hubp *hubp);
+
 #endif /* __DC_MEM_INPUT_DCN20_H__ */
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
index cd2bfcc51276..d910e4a54c34 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c
@@ -131,6 +131,7 @@ static struct hubp_funcs dcn201_hubp_funcs = {
 	.hubp_clear_underflow = hubp1_clear_underflow,
 	.hubp_set_flip_control_surface_gsl = hubp2_set_flip_control_surface_gsl,
 	.hubp_init = hubp1_init,
+	.hubp_clear_tiling = hubp1_clear_tiling,
 };
 
 bool dcn201_hubp_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
index e13d69a22c1c..edbdb8c88d5c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c
@@ -837,6 +837,7 @@ static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_init = hubp21_init,
 	.validate_dml_output = hubp21_validate_dml_output,
 	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_clear_tiling = hubp1_clear_tiling,
 };
 
 bool hubp21_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
index 60a64d290352..3b16c3cda2c3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
@@ -334,6 +334,22 @@ void hubp3_program_tiling(
 
 }
 
+void hubp3_clear_tiling(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_6(DCSURF_SURFACE_CONTROL,
+		PRIMARY_SURFACE_DCC_EN, 0,
+		PRIMARY_SURFACE_DCC_IND_BLK, 0,
+		PRIMARY_SURFACE_DCC_IND_BLK_C, 0,
+		SECONDARY_SURFACE_DCC_EN, 0,
+		SECONDARY_SURFACE_DCC_IND_BLK, 0,
+		SECONDARY_SURFACE_DCC_IND_BLK_C, 0);
+}
+
 void hubp3_dcc_control(struct hubp *hubp, bool enable,
 		enum hubp_ind_block_size blk_size)
 {
@@ -512,6 +528,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp3_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
index b010531a7fe8..cfb01bf340a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
@@ -297,6 +297,8 @@ void hubp3_read_state(struct hubp *hubp);
 
 void hubp3_init(struct hubp *hubp);
 
+void hubp3_clear_tiling(struct hubp *hubp);
+
 #endif /* __DC_HUBP_DCN30_H__ */
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index 8394e8c06919..46b804ed05fb 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -96,6 +96,7 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp31_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
index ca5b4b28a664..8b5bd73b8094 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c
@@ -201,7 +201,8 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_update_force_cursor_pstate_disallow = hubp32_update_force_cursor_pstate_disallow,
 	.phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
 	.hubp_update_mall_sel = hubp32_update_mall_sel,
-	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering
+	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp32_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
index d1f05b82b3dd..eb62042dfafc 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c
@@ -216,6 +216,7 @@ static struct hubp_funcs dcn35_hubp_funcs = {
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.program_extended_blank = hubp31_program_extended_blank_value,
+	.hubp_clear_tiling = hubp3_clear_tiling,
 };
 
 bool hubp35_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index b1ebf5053b4f..2d2ec8562e78 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -508,6 +508,18 @@ bool hubp401_program_surface_flip_and_addr(
 	return true;
 }
 
+void hubp401_clear_tiling(struct hubp *hubp)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
+	REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
+
+	REG_UPDATE_2(DCSURF_SURFACE_CONTROL,
+		     PRIMARY_SURFACE_DCC_EN, 0,
+		     SECONDARY_SURFACE_DCC_EN, 0);
+}
+
 void hubp401_dcc_control(struct hubp *hubp,
 		struct dc_plane_dcc_param *dcc)
 {
@@ -1004,7 +1016,8 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_program_3dlut_fl_width = hubp401_program_3dlut_fl_width,
 	.hubp_program_3dlut_fl_tmz_protected = hubp401_program_3dlut_fl_tmz_protected,
 	.hubp_program_3dlut_fl_crossbar = hubp401_program_3dlut_fl_crossbar,
-	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done
+	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
+	.hubp_clear_tiling = hubp2_clear_tiling,
 };
 
 bool hubp401_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index e52fdb5b0cd0..92041d7e0569 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -340,4 +340,6 @@ int hubp401_get_3dlut_fl_done(struct hubp *hubp);
 
 void hubp401_set_unbounded_requesting(struct hubp *hubp, bool enable);
 
+void hubp401_clear_tiling(struct hubp *hubp);
+
 #endif /* __DC_HUBP_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 16580d624278..d0878fc0cc94 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -275,6 +275,7 @@ struct hubp_funcs {
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
 	int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
+	void (*hubp_clear_tiling)(struct hubp *hubp);
 };
 
 #endif
-- 
2.47.0

