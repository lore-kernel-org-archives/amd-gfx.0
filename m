Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1164D767F2
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 18:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48FC510E8FD;
	Thu, 31 Oct 2024 18:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqqtyhf/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98B510E8FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 18:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h73TzNCsT9T/QvRd/gZaZQib0XRXQ6QLsNzXRXNgBcv9Uco7x4mM/sZdqwr+wfWSnkFjA6s23ELYPNkADJ1QVdjajvLiKz2xsvMzaiWdRcskRyIECAs7sIUf2fJZNkCmw4eAz58z7bz1f2L1tvRZThba6+ZCUD/DNzRZY7lSycgQqV5eyyjwo9FZ0+5WWIy9RpPAXUr7Zv8xVaDBCeVynn9qrFP5Oe8cf3ZwXf+2TsU9Rnc4KAZ8hLgUv5gMqRVM3Y70arkQeDBr31O/ROlD7WitvTHBJDfEByG1qvXGRmO1TuKyAd7RzWOqg1JTNOQbQR9k+6BXZ4ML6g+KsAz+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+S7QbGEIhe4cSLtprMQ4nnE0SKLPXLSzNdbhhsBCfY=;
 b=KhjWuMe79E9U7+NL7e0KeWcbzSGJhnH2ibyPK41RPnEQ6YEvrMXfJ5YjRDA1w/gxZgbP5O4Nczw7Bg45dlfM9f40KMpVP3y/1ymi35EsQnzHlwIxkKeA9cGtUzhxrV9q4x8l9S8Hz9KaVUEsffhFc8DbwrwaS7m+ZpG3bwiA20ac1vDIyDlqtmcFxaF4xNwJx7KMZ1hBTAEI4yRuZqR5F9Z5woogwDxeKNlTPWFkvMP1fp3+XLIlj/IUiEexN5nrhuFTpEDknoYIqnoH8Ux6r7XY9s8h9yS+AzBLS9j2BOWPc043TNmzHiFdz5DBYaRDKc98wHZaWCRRRVxpkzvrKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+S7QbGEIhe4cSLtprMQ4nnE0SKLPXLSzNdbhhsBCfY=;
 b=vqqtyhf/WFFX+f+v2oNRLqv3VcnFnPRlqxV99KFzvSwLmF3bazbHNrd1Q98XUgMs/bwEPbf1lHS36ObzHD4Qz78JQ2UQDRELuj21oFgMsfbX64swEI1mHs5E9YyWBUoWaUN1WSgTRUB7EYqD0DlR9o7qY6/Shq2KEAcpAmo3byk=
Received: from MW4PR03CA0178.namprd03.prod.outlook.com (2603:10b6:303:8d::33)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:04:48 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::1f) by MW4PR03CA0178.outlook.office365.com
 (2603:10b6:303:8d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Thu, 31 Oct 2024 18:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:04:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:04:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amd/display: add clear_tiling hubp callbacks
Date: Thu, 31 Oct 2024 14:04:27 -0400
Message-ID: <20241031180430.3993389-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031180430.3993389-1-alexander.deucher@amd.com>
References: <20241031180430.3993389-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 2955674b-0f00-41bf-6802-08dcf9d681e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/S7JhiCifgyrddmp48G8MsYlkyQuNgr07wvquHyTIe6HWro7ipxHt2cSbvtB?=
 =?us-ascii?Q?kAKifO0FFWOnwxYNxK+lxMN05wN3EhEmuj/rBpPpMHe2OCSc89x49AWmXCXT?=
 =?us-ascii?Q?0Y0XA3Yig81ZUiZwG7AggC5L+8gwq+tTdY9Tx3/sgV7s30ir8Dimp2Ei4Yul?=
 =?us-ascii?Q?AoiHjbspm/egBdZG39GWy4Y7+lQML6aDFQeHMBB6gxO/068EP5eMpzE8QqrV?=
 =?us-ascii?Q?Jq6DzJwbhh0YCeFIOuwFUWUY1s3/otawFslIqp7EZPktGUdkzLRDZ8/I4c+E?=
 =?us-ascii?Q?3BkPcDN3Mjo9Tyzw6JnZdi88yd0beq0J+/YKGL/GKkILDxVPBeoPipH3z51s?=
 =?us-ascii?Q?dUnLH8hi2uqgUsMgCAdbcD3K/GYF3f8w9p/KXerxaxyEFlPci0dsP+xaGMKW?=
 =?us-ascii?Q?O3FDdmOD+ql8ST7cEFF/pLDekbROP/KpK/2pRS8CTAHft6QCdqTSkCDZGg49?=
 =?us-ascii?Q?S3k6fbWqF/gGxtE1de9A3wNfav3/NKIJu0t8wRMSoCfQsu/W6z2iZfc0M3Tb?=
 =?us-ascii?Q?JqT//ziKllEpzjF5NU0F78M2I8PBvpGJOW/9zPjx3+YIkvnDPbuIyo9LG/zT?=
 =?us-ascii?Q?9p5Qx/r3LL7R1bICTR0l7nLJi8A6C+PruC9OKFAY9plmkVQft6m6IK3sN+Zz?=
 =?us-ascii?Q?OTLoFoEgMfNEZgaJ3vnn7W/Rsb1jzorPl5aPR3FEDwN0AJr8+HqxrGXrJh+k?=
 =?us-ascii?Q?BTbxUn9lqv9StC4XIL58Kw8hvbiPDXfgWFcTSWjSLFSV2AYVnYM3AST6/MgL?=
 =?us-ascii?Q?JGxlQ58cBo9vEV+edw2tKJW/NPDLa4FUlKpJjpzGI9chcF72IaU5WpbkRG6p?=
 =?us-ascii?Q?+J6UcD8YF+oV99KTFlJiTmy6vOCq0wCVlm2q0kbUgfOznbvinuI9HLABnGVK?=
 =?us-ascii?Q?A/Tx/JmmpUWOpVYSabLLoON3cLhiRUFUDIPk6zp3T2NkPmKLT9arThcKE3Pu?=
 =?us-ascii?Q?J07mQwaTlLklgqmM+9IN5qucVMVNkJIrlw1xS0Ss0EX3xVC9Prr8L9gyRfPq?=
 =?us-ascii?Q?PvLeH4lpXlSk8bNlZ1AoS6XGmiy/kHbkMKNRPFYwLhz81kmQqJAOZyYsxaLE?=
 =?us-ascii?Q?gr05igakNuRYQP00r4X7QduUfXyab1CaylPXkr5VJOXoQrVfnP25xoEnUvpA?=
 =?us-ascii?Q?CliMACY5I9gHIsn2McXSnAvHBTRun5iknWdEcFAqh+0iIuCSyoHn0cOilDx0?=
 =?us-ascii?Q?vNxoLcYYHIgjlu6MzDLSJjyW//l0Tn0q7MVxoxXE/b/ChCOMZ0engGw+J9BE?=
 =?us-ascii?Q?BiU9K30rkezDGrLzYp2Ur/6ABxrv0nRpizwHCkvAb8SuEtw3jptDHnDXmK9F?=
 =?us-ascii?Q?SDWtKjJIJceCybyKZ5NsEy11c9oY+9zNUyA6WUu2KruDZxJl4F7DAX6dxAcZ?=
 =?us-ascii?Q?zbKNBXGuF4DrjziGPSv8AeFAl/LdhAULMrYfzaV+Yx54LLTlqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:04:47.5555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2955674b-0f00-41bf-6802-08dcf9d681e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
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

