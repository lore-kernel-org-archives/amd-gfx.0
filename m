Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55515D3A676
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201DF10E6A0;
	Tue, 29 Oct 2024 16:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AyLCuWfp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E308510E3A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPiwk61pFt66t+1S7sp79X9r8bY7yV7qW+jkeskos+3ZswCGVOs+DxI44wut4b4Q1u34C5eFuE56jXr/u4FaA61MUR97acAPGeWbf6ckC3ohNWt4jAZYFG+igdv+Meu7gjENtRzo/Zz/2ajPa2DHPzRHgBqesxtJgQIEiD8l3XFKnbMPSf7QqUftZgWc2JT3laM5S0v21I7f+HFj5JfRmKciCbgqEXVR/QSEp85cMS7LNhk5VfIsKlJJbhWoOI4HN+GZHZUw7TUf1lmD/urQAvW+uN5wsjiAB3ltGHpeMFmlDc2Pvii+KnZQaKZGbxTJbvL6H29VUy3KdX6kkQZzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dd8kr+fewCuCwanwKbatugaMXsbAmDrcq62hjDFFxK4=;
 b=xSyPLhIIjVFHVz573DG1sG6gGSSMbukRJ1e5/BX0awtO6B+kQE2OmqZ5fBse9KMV7Cw5ThL6jd1+Fy6gQVdRUGCki0RciprQQfLRQWwKoxBI8Lc6z+PchF+ikgt2RQmvVPXUha2BgxnxTN+zaKq3emlYpMUUufa4UiOnixkhGpw9V49/DnbDmXgfsC6z/ssAgz6vals2NPo2CB349ArpDQyTdCksOl46bU+bCFu2fzmS8DZpX/T6PlnhHaxEU7+MNJRCjgAZsxfL5FFTrzXpfgM1klflM33S4jLG7phLKWuhMCFleIzpysi4dP5gVndZ5co+avIzufVvljCV3O2Nlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd8kr+fewCuCwanwKbatugaMXsbAmDrcq62hjDFFxK4=;
 b=AyLCuWfpDiDsTaq19xGgzIQRXsqUfEnO/wbvjeW6HX739RYAoaw+xjKhg9f2bVuESFjb+jsiydPEalgGjuv2mjD0LDT+kMom4n2sMuFdzvkg8bHEEAd3ued/NaFXLSkI8oLyPylgB0lzt/f1TKgFtJhwMZMQ8Zy/WnE/ldVH4Us=
Received: from BN9P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::16)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:57:16 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::88) by BN9P221CA0001.outlook.office365.com
 (2603:10b6:408:10a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 16:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Tue, 29 Oct 2024 16:57:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 11:57:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amd/display: add clear_tiling support for all DCN
 families
Date: Tue, 29 Oct 2024 12:56:52 -0400
Message-ID: <20241029165653.1873243-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029165653.1873243-1-alexander.deucher@amd.com>
References: <20241029165653.1873243-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddc4c51-cbad-4da5-bc96-08dcf83abe18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tveWfMH5CNtY7Nh5exv+P5xdSHUNfOV1ogg2A3kciiIlRPnMBCOUbRf045XP?=
 =?us-ascii?Q?aRkA8b+TJo50iGw7jpVnQizswbCJCSiGbeaeDgtq65OjcmICp8wG7Bvww2XE?=
 =?us-ascii?Q?Gs6uVGuINKgGfpyWzXCMaYQtG0TiZDSeQYCaRGyrEzKakTj8shTVCHl9H622?=
 =?us-ascii?Q?CGA9Ni64khduSc1j0vgzFLShU6lKi09jCHAtqC4PRs7Dv8DW/8jETo/eimm8?=
 =?us-ascii?Q?kCTy78QyNXhK8dC+NCh1mLaRS/Rxn6qLWxQT/yJgRkZu9FTYITErWvIJxNh0?=
 =?us-ascii?Q?uIIAmJ/QDX1xBFXhKJEHNawAaSd8SHwq+TQlCOMiXCew1gGgCy6bEhoeDuNZ?=
 =?us-ascii?Q?fGDiXDJ0s5vn6LXsQnOZMf4PZwW905l0d4bjXqicRtipJeCVCzO2IcOxmDsQ?=
 =?us-ascii?Q?6eXkWjk/HjCa7MsgPjM3tfJGmADU79pxHOjtQkbKI/oBVPZoaXphFWZCQT7k?=
 =?us-ascii?Q?Y73JFBPKMzDmnLQiyN1AYUiRKdS+DDRJjTIEvvNdcGI7opEWuCnJ+jCkMzFV?=
 =?us-ascii?Q?T7n4/CuQamzSI51b+j2Xpok60uJSYhlKU1cvHwNtwhYcYuhdeo5fKDgOd49j?=
 =?us-ascii?Q?BjFChWFLvPHulewW27JGPqvYX4jnHNlVvGK5P3OgiCDpJfcU0djWr6V2FzYS?=
 =?us-ascii?Q?mcK3Rf53fSTocoAX4axyeNeZx6N9nwkt2YVZNhNGdXu0aFRzrdffl8jKbHOc?=
 =?us-ascii?Q?Grec5X4aZnzwscRWE2nOOh4rRCHBhCGwo8JUr0hW+PawAmxa+6IjoSXf7wMw?=
 =?us-ascii?Q?z5GuCcHpDn/Mux8yvDcYOVNjRvMGOAtV9ulJr1I591PDtszC6QZ8OIcsse7e?=
 =?us-ascii?Q?B1bYvS/tZ4B5rIETP725wlRoefRAh0b8j6Hjix9ANDizAVA9zggsGyAW8F4G?=
 =?us-ascii?Q?N70cG1V89ZS+qKx4q1CvgEYoJFNchjUUqb/gD3ZmRckTxUOB+kzThTG3pGkF?=
 =?us-ascii?Q?ZU16ZWIma2Owsl9lWKnPGetyHmI12KqNjjZxl0ODbAX9wejPlFAKNhr0KnXV?=
 =?us-ascii?Q?0IWLAslupuTGoUQ4dRPf1piiWbzWe8Ch1ZLSVgf3zgRgkZF87lzFgKDpDr7u?=
 =?us-ascii?Q?5rRBuYyMe1lLhDokv+mXo0ISoWqchog6RxTMKrZZwmNPoeWW+MHAfAqZOkOp?=
 =?us-ascii?Q?nk/WJrC4xaGXf2b7VDfycO0q/krpEc9sKRGX+1ylHW9GTzKGL45XjOGfRroF?=
 =?us-ascii?Q?x3bTjOZqgoyDFXMU4uHQgG2EXx5YDZUVZgOU8+DCqw+PbbAv1VhwOR95x/Bh?=
 =?us-ascii?Q?1aZOHMhuCRwA8C2Jnmwikc0w8MPbgNzRrSuIvfDhkYNRA05AiLoXAhlq2pcH?=
 =?us-ascii?Q?6TGgLNQHt65hn7+tswIFaVLlh80jttxHbHgAfnW7GvNFTl0wAJZkGJnazMVF?=
 =?us-ascii?Q?aBHOLobl2yaUl3AtP5bh9Xq8W0UnR2m0ZYf79ADGdG4rG/0Mww=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:57:16.0226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddc4c51-cbad-4da5-bc96-08dcf83abe18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
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

DCN 1.x - 4.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 15 +++++++++++++++
 .../drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  2 ++
 .../drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 15 +++++++++++++++
 .../drm/amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  2 ++
 .../drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c  |  1 +
 .../drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c    |  1 +
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 15 ++++++++++++++-
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  2 ++
 8 files changed, 52 insertions(+), 1 deletion(-)

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
-- 
2.47.0

