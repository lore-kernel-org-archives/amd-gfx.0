Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22685D2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 06:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B619B10E554;
	Tue, 20 Jan 2026 06:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ardzyVYr";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010039.outbound.protection.outlook.com
 [40.93.198.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C24E10E554
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeBxYnRBalDQrNk/bLpL+AMGdUn81EUw3WfnDGofn4O+JZu+w7YnR9hDAdU1r9obN/fm3IKzRko2wsGTVi8Q/KJFzvu+/Yq6TyhyOozxTGGYqggao57TSbzb0gJ/DbUZSVojpsHevksAp9O8YMtnQz2gDfek6MvUNKH/kWrAsBMgHbQFZ/vxcWtd5zBwCUD3VaBTQ4pTmg6hIH+ceajsjOWA5xy+beEDiym3r7bdFMBF8PYUiCVu8uaSiTMc8WUzcVOKM4LaMC/z7EiNRaas9F1pflwvNBKYKxMI+fpYQo0LwujccUjdisrzmBrjkFPl3ATKyvgZiEmxHX7Z4mMMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xji74U0uFLVaD+TURLOLBoHM2LZvQl6Xo6RcmLhlCJ8=;
 b=jAtxjrAyg52eWWMVZPdT3zTjI6R+G1X6vESCoz4B4/yeQy/oU5a/Lr3fFNgmSh1JDVhXX2VF9wLFGFt2jk34NT4zacvLhS41tmBW4ItSFEpM8nNIgBC48qM/gmVSHOcvA10A/6onKq74CLO9gsG+Sv7RJU2j0Grxs4fk8iVvYk/LhZK7dXynvjsFTYyup1KcUKZ+c/Q5M63fuDvRBWRFgpmd6fDeCbUwJRx+r8D+MdC1Dny5ISOZkeFMih5VUT3+6XozawB2Par/CWQB11WK/fr0YbwnBBocMbz4CNy/riVyOaX/9AG60/PdJe/aTh8z/cYbOUeylJGnB5oQju9AhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xji74U0uFLVaD+TURLOLBoHM2LZvQl6Xo6RcmLhlCJ8=;
 b=ardzyVYr6bijiCm1LXFm2Smdb7mVZal3pR5TxdQxD7CPdGDdYBXESeuF/DSrsuI0l/9uNJQ+2bwETpf3Ovl7/nmAKx0O2lpZVfcFFOnCYMINTnkr+kTbMVpLaapFLdtrtuka/RwjkHdrNGc0cs2MKFSMcwNPehbs10dK0IsEefs=
Received: from CY5PR15CA0091.namprd15.prod.outlook.com (2603:10b6:930:7::10)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:14:33 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::1e) by CY5PR15CA0091.outlook.office365.com
 (2603:10b6:930:7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Tue,
 20 Jan 2026 06:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:14:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:14:30 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 4/7] drm/amd/pm: Initialize allowed feature list
Date: Tue, 20 Jan 2026 11:42:21 +0530
Message-ID: <20260120061402.1287680-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120061402.1287680-1-lijo.lazar@amd.com>
References: <20260120061402.1287680-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b39b615-a2c2-418b-bbe7-08de57eb2d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vg0C3oBqxYSnTS/FLFoAGjsmThuA3Px6uGR7m1y+uK2jL8KOST3FeKd+Jo0i?=
 =?us-ascii?Q?u1nnw+FQrOsK6gP+6uWprZihlmswSrt8Fdx6M8561w/he0prBWKJXgdhgtDl?=
 =?us-ascii?Q?zcdrDmB5gs38dBklFQAP5/wRzWNB/ax/1FKA0/E0TkwJOwbeFsBs5qa6Uqr7?=
 =?us-ascii?Q?HZGNk5877y3Gy+9on5J4i9XDSvRG6c7fIzU1lcnIRJwgogW3DaOfSlvqEX8H?=
 =?us-ascii?Q?7mp6L2rYSVxZTMB0/B1ctWXk+6n+2TjpNfihjFATNBRmBMi0qol0vHe9WHgc?=
 =?us-ascii?Q?DLn7nswiOin9Kd2YggPQdXq8oNoAzrz2NJvAv7a9POOCuztaU3BrvcmTAImk?=
 =?us-ascii?Q?dY7K1BXlfnr29et1Mc8sQDVq2hcfr9CliCGnYhD43+kgYGzBhDa/LEJfDG+z?=
 =?us-ascii?Q?bZTAVULLP3cw4USA72+c1XOeRLvNu108gXADaPuiY/5EwJ9FSs1rUOsZsKou?=
 =?us-ascii?Q?zUbcNlcQbrMviw9u62BNEZPouliTBVO2o3OJMfQereznrKNx0eOxFa5W+A29?=
 =?us-ascii?Q?QssnbUgIUBmVhaqFbv9p6zOOUnCM+ZvjYglNodlAcnlApfVWQ2ivOcYRXAuJ?=
 =?us-ascii?Q?XAzMGq/hBZIeYoMnEM8yALOU1x713U5p9fjgmqXM2uxekxQBJVi3JFPscy1l?=
 =?us-ascii?Q?l0qQHBAgsnCOjsQkKWWodJ8DN1zq546njY9SiLibndHCVUr5VKx3fYlQqdEL?=
 =?us-ascii?Q?OjCN6buviY7FPNXV+FapFrAnMWi7oryVrvr2MlHrRIYbYOGIm/XmQjDdiEU2?=
 =?us-ascii?Q?bGMvWhH+x+XVUDmm/WtjLP5uDQCHLVEXjGGvp+MN+ZhysKSle6gEI7eHRz8K?=
 =?us-ascii?Q?VVnkTK4EmFye+c/xRrVX2+iu7U/jk9kl0klwebO7clNjGvYWh7/7XqIHty63?=
 =?us-ascii?Q?7xTvoMpazM8ICCei3pAoiEwPjHVX7vGN8XhqKe4BVD2VTKCcJz+dtSsfGOyy?=
 =?us-ascii?Q?KGWDxoMcVoC49S6BRWHbHrnqmyrXH0SfDm/fNOvzmZguzDwN0IgrhrBgFWOZ?=
 =?us-ascii?Q?ozxJ6CMg0KjuA6L/Vt4E1/VXeDy+o0m23GdlRXlJl91uPsRmCTmSCH1AVOhR?=
 =?us-ascii?Q?rYNui0htQqqubh9t3O1kXqkr0Nk/gsh4NJm+oAky2VW/ESRuEYGU0tHhRBpt?=
 =?us-ascii?Q?SCXSjNJVIFsQFuBhmAAqtCByUzXFZVmKtJd9xj4YuRCgsqPd5IKkPiKa7g3v?=
 =?us-ascii?Q?m0nPGXMCdSX9CqO2W/ZdY6IT1PsKLwihHyTd/VlBCjIEavgIpYHpyJeUnyMx?=
 =?us-ascii?Q?nS8hXVLDcudkuBHle4YklAFEX5qdXtCGFQBLmsj0GCe9RFZr9gphXJnIXiC+?=
 =?us-ascii?Q?iNCF5TOavtyHDaEBMTMb3qApmJQNjeSMfQwh8l2KvhVJowaEyR7Ux70kiU71?=
 =?us-ascii?Q?hFVbGA3iUet9iFQYuOoko7BFDmVJ28BeOCNuMio/1DY6qAAJzXrItOlWiodB?=
 =?us-ascii?Q?aBzggVppsm9d6YVYyTN7+Gw5MPNYwO8xKNjQbF85D5pjpPBbjF82BCCch2EF?=
 =?us-ascii?Q?J0tH2sDiQD4AQZuTh8iker6j+I/ZOOYIqAWFSLo6i/bjczrH+afOWBs4owDH?=
 =?us-ascii?Q?ZCQPaOP9bIWPYfu51JO2wIMZMpnpHoeRSHpNWp9hwvoe46Lv48lxNmUVfIGS?=
 =?us-ascii?Q?TBe/KdBKMiA9nBqOo5N3/jCijthkJgx9DgXCJ5pQEQLx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:14:32.6228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b39b615-a2c2-418b-bbe7-08de57eb2d98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
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

Instead of returning feature bit mask of allowed features, initialize
the allowed features in the callback implementation itself.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 +---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 24 +----
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 11 +--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 92 +++++++++----------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 89 +++++++++---------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 11 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 35 +++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 12 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 80 ++++++++--------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 11 +--
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 +-
 11 files changed, 158 insertions(+), 226 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ccb771dacde1..e75dd0152ea7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -688,11 +688,8 @@ static int smu_sys_set_pp_table(void *handle,
 	return ret;
 }
 
-static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
+static int smu_init_driver_allowed_feature_mask(struct smu_context *smu)
 {
-	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
-	int ret = 0;
-
 	/*
 	 * With SCPM enabled, the allowed featuremasks setting(via
 	 * PPSMC_MSG_SetAllowedFeaturesMaskLow/High) is not permitted.
@@ -707,15 +704,7 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 
 	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
-	ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
-					     SMU_FEATURE_MAX/32);
-	if (ret)
-		return ret;
-
-	smu_feature_list_add_bits(smu, SMU_FEATURE_LIST_ALLOWED,
-				  (unsigned long *)allowed_feature_mask);
-
-	return ret;
+	return smu_init_allowed_features(smu);
 }
 
 static int smu_set_funcs(struct amdgpu_device *adev)
@@ -1946,7 +1935,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!smu->pm_enabled)
 		return 0;
 
-	ret = smu_get_driver_allowed_feature_mask(smu);
+	ret = smu_init_driver_allowed_feature_mask(smu);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 2290298579e1..7c63c631f6d4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -812,11 +812,10 @@ struct pptable_funcs {
 	int (*run_btc)(struct smu_context *smu);
 
 	/**
-	 * @get_allowed_feature_mask: Get allowed feature mask.
-	 * &feature_mask: Array to store feature mask.
-	 * &num: Elements in &feature_mask.
+	 * @init_allowed_features: Initialize allowed features bitmap.
+	 * Directly sets allowed features using smu_feature wrapper functions.
 	 */
-	int (*get_allowed_feature_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
+	int (*init_allowed_features)(struct smu_context *smu);
 
 	/**
 	 * @get_current_power_state: Get the current power state.
@@ -2052,14 +2051,6 @@ static inline void smu_feature_bits_copy(struct smu_feature_bits *dst,
 	bitmap_copy(dst->bits, src, nbits);
 }
 
-static inline void smu_feature_bits_or(struct smu_feature_bits *dst,
-				       const struct smu_feature_bits *src1,
-				       const unsigned long *src2,
-				       unsigned int nbits)
-{
-	bitmap_or(dst->bits, src1->bits, src2, nbits);
-}
-
 static inline struct smu_feature_bits *
 __smu_feature_get_list(struct smu_context *smu, enum smu_feature_list list)
 {
@@ -2128,15 +2119,6 @@ static inline void smu_feature_list_set_bits(struct smu_context *smu,
 			      smu->smu_feature.feature_num);
 }
 
-static inline void smu_feature_list_add_bits(struct smu_context *smu,
-					     enum smu_feature_list list,
-					     const unsigned long *src)
-{
-	struct smu_feature_bits *bits = __smu_feature_get_list(smu, list);
-
-	smu_feature_bits_or(bits, bits, src, smu->smu_feature.feature_num);
-}
-
 static inline void smu_feature_list_to_arr32(struct smu_context *smu,
 					     enum smu_feature_list list,
 					     uint32_t *arr)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 7c5ce6a6e2ca..b22a0e91826d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -345,14 +345,9 @@ static int arcturus_init_smc_tables(struct smu_context *smu)
 }
 
 static int
-arcturus_get_allowed_feature_mask(struct smu_context *smu,
-				  uint32_t *feature_mask, uint32_t num)
+arcturus_init_allowed_features(struct smu_context *smu)
 {
-	if (num > 2)
-		return -EINVAL;
-
-	/* pptable will handle the features to enable */
-	memset(feature_mask, 0xFF, sizeof(uint32_t) * num);
+	smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
 	return 0;
 }
@@ -1877,7 +1872,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* init dpm */
-	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
+	.init_allowed_features = arcturus_init_allowed_features,
 	/* btc */
 	.run_btc = arcturus_run_btc,
 	/* dpm/clk tables */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 1f84654bbc85..f14eed052526 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -275,89 +275,83 @@ static bool is_asic_secure(struct smu_context *smu)
 }
 
 static int
-navi10_get_allowed_feature_mask(struct smu_context *smu,
-				  uint32_t *feature_mask, uint32_t num)
+navi10_init_allowed_features(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (num > 2)
-		return -EINVAL;
-
-	memset(feature_mask, 0, sizeof(uint32_t) * num);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
-				| FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT)
-				| FEATURE_MASK(FEATURE_RSMU_SMN_CG_BIT)
-				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
-				| FEATURE_MASK(FEATURE_PPT_BIT)
-				| FEATURE_MASK(FEATURE_TDC_BIT)
-				| FEATURE_MASK(FEATURE_GFX_EDC_BIT)
-				| FEATURE_MASK(FEATURE_APCC_PLUS_BIT)
-				| FEATURE_MASK(FEATURE_VR0HOT_BIT)
-				| FEATURE_MASK(FEATURE_FAN_CONTROL_BIT)
-				| FEATURE_MASK(FEATURE_THERMAL_BIT)
-				| FEATURE_MASK(FEATURE_LED_DISPLAY_BIT)
-				| FEATURE_MASK(FEATURE_DS_LCLK_BIT)
-				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
-				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
-				| FEATURE_MASK(FEATURE_BACO_BIT)
-				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
-				| FEATURE_MASK(FEATURE_APCC_DFLL_BIT)
-				| FEATURE_MASK(FEATURE_FW_CTF_BIT)
-				| FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT)
-				| FEATURE_MASK(FEATURE_TEMP_DEPENDENT_VMIN_BIT);
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
+
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_PREFETCHER_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_MP0CLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_RSMU_SMN_CG_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_SOCCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_PPT_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_TDC_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_EDC_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_APCC_PLUS_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_VR0HOT_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FAN_CONTROL_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_THERMAL_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_LED_DISPLAY_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_LCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_DCEFCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FW_DSTATE_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_BACO_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_SS_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_APCC_DFLL_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FW_CTF_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_OUT_OF_BAND_MONITOR_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_TEMP_DEPENDENT_VMIN_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_GFXCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_LINK_BIT);
 
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_DCEFCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_ULV_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_ULV_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_GFXCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXOFF_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFXOFF_BIT);
 
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MMHUB_PG_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MMHUB_PG_BIT);
 
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_ATHUB)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_PG_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_ATHUB_PG_BIT);
 
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_VCN)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VCN_PG_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_VCN_PG_BIT);
 
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_JPEG)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_JPEG_PG_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_JPEG_PG_BIT);
 
 	if (smu->dc_controlled_by_gpio)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_ACDC_BIT);
 
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_SOCCLK_BIT);
 
-	/* DPM UCLK enablement should be skipped for navi10 A0 secure board */
 	if (!(is_asic_secure(smu) &&
 	      (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0)) &&
 	      (adev->rev_id == 0)) &&
-	    (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
-				| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
-				| FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
+	    (adev->pm.pp_feature & PP_MCLK_DPM_MASK)) {
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_UCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_VDDCI_SCALING_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_MVDD_SCALING_BIT);
+	}
 
-	/* DS SOCCLK enablement should be skipped for navi10 A0 secure board */
 	if (is_asic_secure(smu) &&
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0)) &&
 	    (adev->rev_id == 0))
-		*(uint64_t *)feature_mask &=
-				~FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_SOCCLK_BIT);
 
 	return 0;
 }
@@ -3277,7 +3271,7 @@ static int navi10_set_config_table(struct smu_context *smu,
 }
 
 static const struct pptable_funcs navi10_ppt_funcs = {
-	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
+	.init_allowed_features = navi10_init_allowed_features,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
 	.dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f930ba2733e9..98a02fc08214 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -276,85 +276,82 @@ static const uint8_t sienna_cichlid_throttler_map[] = {
 };
 
 static int
-sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
-				  uint32_t *feature_mask, uint32_t num)
+sienna_cichlid_init_allowed_features(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (num > 2)
-		return -EINVAL;
-
-	memset(feature_mask, 0, sizeof(uint32_t) * num);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
-				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
-				| FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT)
-				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
-				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
-				| FEATURE_MASK(FEATURE_DS_FCLK_BIT)
-				| FEATURE_MASK(FEATURE_DS_UCLK_BIT)
-				| FEATURE_MASK(FEATURE_FW_DSTATE_BIT)
-				| FEATURE_MASK(FEATURE_DF_CSTATE_BIT)
-				| FEATURE_MASK(FEATURE_RSMU_SMN_CG_BIT)
-				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
-				| FEATURE_MASK(FEATURE_VR0HOT_BIT)
-				| FEATURE_MASK(FEATURE_PPT_BIT)
-				| FEATURE_MASK(FEATURE_TDC_BIT)
-				| FEATURE_MASK(FEATURE_BACO_BIT)
-				| FEATURE_MASK(FEATURE_APCC_DFLL_BIT)
-				| FEATURE_MASK(FEATURE_FW_CTF_BIT)
-				| FEATURE_MASK(FEATURE_FAN_CONTROL_BIT)
-				| FEATURE_MASK(FEATURE_THERMAL_BIT)
-				| FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT);
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
+
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_PREFETCHER_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_FCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_MP0CLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_SOCCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_DCEFCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_FCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_UCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FW_DSTATE_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DF_CSTATE_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_RSMU_SMN_CG_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_SS_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_VR0HOT_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_PPT_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_TDC_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_BACO_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_APCC_DFLL_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FW_CTF_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FAN_CONTROL_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_THERMAL_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_OUT_OF_BAND_MONITOR_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_GFXCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_GFX_GPO_BIT);
 	}
 
 	if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) > IP_VERSION(11, 0, 7)) &&
 	    !(adev->flags & AMD_IS_APU))
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_DCS_BIT);
 
-	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
-					| FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
-					| FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
+	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK) {
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_UCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_VDDCI_SCALING_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_MVDD_SCALING_BIT);
+	}
 
 	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_LINK_BIT);
 
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_DCEFCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_SOCCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_ULV_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_ULV_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_GFXCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXOFF_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFXOFF_BIT);
 
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_ATHUB)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_PG_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_ATHUB_PG_BIT);
 
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MMHUB_PG_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MMHUB_PG_BIT);
 
 	if (smu->adev->pg_flags & AMD_PG_SUPPORT_VCN ||
 	    smu->adev->pg_flags & AMD_PG_SUPPORT_JPEG)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_PG_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MM_DPM_PG_BIT);
 
 	if (smu->dc_controlled_by_gpio)
-       *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_ACDC_BIT);
 
 	if (amdgpu_device_should_use_aspm(adev))
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_LCLK_BIT);
 
 	return 0;
 }
@@ -3085,7 +3082,7 @@ static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 }
 
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
-	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
+	.init_allowed_features = sienna_cichlid_init_allowed_features,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
 	.dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 9de0b676bb7b..3b6a34644a92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -329,14 +329,9 @@ static int aldebaran_init_smc_tables(struct smu_context *smu)
 	return smu_v13_0_init_smc_tables(smu);
 }
 
-static int aldebaran_get_allowed_feature_mask(struct smu_context *smu,
-					      uint32_t *feature_mask, uint32_t num)
+static int aldebaran_init_allowed_features(struct smu_context *smu)
 {
-	if (num > 2)
-		return -EINVAL;
-
-	/* pptable will handle the features to enable */
-	memset(feature_mask, 0xFF, sizeof(uint32_t) * num);
+	smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
 	return 0;
 }
@@ -1967,7 +1962,7 @@ static int aldebaran_send_hbm_bad_channel_flag(struct smu_context *smu,
 
 static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* init dpm */
-	.get_allowed_feature_mask = aldebaran_get_allowed_feature_mask,
+	.init_allowed_features = aldebaran_init_allowed_features,
 	/* dpm/clk tables */
 	.set_default_dpm_table = aldebaran_set_default_dpm_table,
 	.populate_umd_state_clk = aldebaran_populate_umd_state_clk,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ce52b616b935..9c4298736b28 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -287,49 +287,44 @@ static const uint8_t smu_v13_0_0_throttler_map[] = {
 };
 
 static int
-smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
-				  uint32_t *feature_mask, uint32_t num)
+smu_v13_0_0_init_allowed_features(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (num > 2)
-		return -EINVAL;
-
-	memset(feature_mask, 0xff, sizeof(uint32_t) * num);
+	smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
 	if (!(adev->pm.pp_feature & PP_SCLK_DPM_MASK)) {
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFX_IMU_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_GFXCLK_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_IMU_BIT);
 	}
 
 	if (!(adev->pg_flags & AMD_PG_SUPPORT_ATHUB) ||
 	    !(adev->pg_flags & AMD_PG_SUPPORT_MMHUB))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_ATHUB_MMHUB_PG_BIT);
 
 	if (!(adev->pm.pp_feature & PP_SOCCLK_DPM_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_SOCCLK_BIT);
 
-	/* PMFW 78.58 contains a critical fix for gfxoff feature */
 	if ((smu->smc_fw_version < 0x004e3a00) ||
 	     !(adev->pm.pp_feature & PP_GFXOFF_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFXOFF_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFXOFF_BIT);
 
 	if (!(adev->pm.pp_feature & PP_MCLK_DPM_MASK)) {
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_UCLK_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_VMEMP_SCALING_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_VDDIO_MEM_SCALING_BIT);
 	}
 
 	if (!(adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_GFXCLK_BIT);
 
 	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DPM_LINK_BIT);
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_DS_LCLK_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_LINK_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_LCLK_BIT);
 	}
 
 	if (!(adev->pm.pp_feature & PP_ULV_MASK))
-		*(uint64_t *)feature_mask &= ~FEATURE_MASK(FEATURE_GFX_ULV_BIT);
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_ULV_BIT);
 
 	return 0;
 }
@@ -3130,7 +3125,7 @@ static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
 }
 
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
-	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
+	.init_allowed_features = smu_v13_0_0_init_allowed_features,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
 	.i2c_init = smu_v13_0_0_i2c_control_init,
 	.i2c_fini = smu_v13_0_0_i2c_control_fini,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e82c43c851a..bd893e95515f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -742,15 +742,9 @@ static int smu_v13_0_6_fini_smc_tables(struct smu_context *smu)
 	return smu_v13_0_fini_smc_tables(smu);
 }
 
-static int smu_v13_0_6_get_allowed_feature_mask(struct smu_context *smu,
-						uint32_t *feature_mask,
-						uint32_t num)
+static int smu_v13_0_6_init_allowed_features(struct smu_context *smu)
 {
-	if (num > 2)
-		return -EINVAL;
-
-	/* pptable will handle the features to enable */
-	memset(feature_mask, 0xFF, sizeof(uint32_t) * num);
+	smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
 	return 0;
 }
@@ -3836,7 +3830,7 @@ static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras
 
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
-	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
+	.init_allowed_features = smu_v13_0_6_init_allowed_features,
 	/* dpm/clk tables */
 	.set_default_dpm_table = smu_v13_0_6_set_default_dpm_table,
 	.populate_umd_state_clk = smu_v13_0_6_populate_umd_state_clk,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0375e8484b2a..415766dbfe6c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -265,71 +265,67 @@ static const uint8_t smu_v13_0_7_throttler_map[] = {
 };
 
 static int
-smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
-				  uint32_t *feature_mask, uint32_t num)
+smu_v13_0_7_init_allowed_features(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	if (num > 2)
-		return -EINVAL;
-
-	memset(feature_mask, 0, sizeof(uint32_t) * num);
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DATA_READ_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FW_DATA_READ_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_POWER_OPTIMIZER_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_GFXCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_IMU_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_GFX_POWER_OPTIMIZER_BIT);
 	}
 
 	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXOFF_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFXOFF_BIT);
 
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK) {
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_FCLK_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_UCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_FCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_VMEMP_SCALING_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_VDDIO_MEM_SCALING_BIT);
 	}
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_SOCCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_PCIE_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_LINK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_LINK_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_GFXCLK_BIT);
 
 	if (adev->pm.pp_feature & PP_ULV_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_ULV_BIT);
-
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_VCN_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_FCLK_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DF_CSTATE_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_THROTTLERS_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VR0HOT_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_CTF_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FAN_CONTROL_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXCLK_SPREAD_SPECTRUM_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MEM_TEMP_READ_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DSTATE_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_MPCLK_DS_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_PCC_DFLL_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_CG_BIT);
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_ULV_BIT);
+
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_LCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_MP0CLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MM_DPM_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_VCN_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_FCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DF_CSTATE_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_THROTTLERS_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_VR0HOT_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FW_CTF_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FAN_CONTROL_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DS_SOCCLK_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFXCLK_SPREAD_SPECTRUM_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_TEMP_READ_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_FW_DSTATE_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_SOC_MPCLK_DS_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_BACO_MPCLK_DS_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_GFX_PCC_DFLL_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_SOC_CG_BIT);
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_BACO_BIT);
 
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_DPM_DCN_BIT);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_ATHUB) &&
 	    (adev->pg_flags & AMD_PG_SUPPORT_MMHUB))
-		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ATHUB_MMHUB_PG_BIT);
+		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_ATHUB_MMHUB_PG_BIT);
 
 	return 0;
 }
@@ -2736,7 +2732,7 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
 }
 
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
-	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
+	.init_allowed_features = smu_v13_0_7_init_allowed_features,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
 	.is_dpm_running = smu_v13_0_7_is_dpm_running,
 	.init_microcode = smu_v13_0_init_microcode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index d2aa5fabfca4..3c351ee41e68 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -264,14 +264,9 @@ static const uint8_t smu_v14_0_2_throttler_map[] = {
 	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
 };
 
-static int
-smu_v14_0_2_get_allowed_feature_mask(struct smu_context *smu,
-				  uint32_t *feature_mask, uint32_t num)
+static int smu_v14_0_2_init_allowed_features(struct smu_context *smu)
 {
-	if (num > 2)
-		return -EINVAL;
-
-	memset(feature_mask, 0xff, sizeof(uint32_t) * num);
+	smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
 	return 0;
 }
@@ -2757,7 +2752,7 @@ static int smu_v14_0_2_set_power_limit(struct smu_context *smu,
 }
 
 static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
-	.get_allowed_feature_mask = smu_v14_0_2_get_allowed_feature_mask,
+	.init_allowed_features = smu_v14_0_2_init_allowed_features,
 	.set_default_dpm_table = smu_v14_0_2_set_default_dpm_table,
 	.i2c_init = smu_v14_0_2_i2c_control_init,
 	.i2c_fini = smu_v14_0_2_i2c_control_fini,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 0f7778410a3a..24848da90234 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -70,7 +70,7 @@
 #define smu_apply_clocks_adjust_rules(smu)				smu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
 #define smu_notify_smc_display_config(smu)				smu_ppt_funcs(notify_smc_display_config, 0, smu)
 #define smu_run_btc(smu)						smu_ppt_funcs(run_btc, 0, smu)
-#define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
+#define smu_init_allowed_features(smu)		smu_ppt_funcs(init_allowed_features, 0, smu)
 #define smu_set_watermarks_table(smu, clock_ranges)			smu_ppt_funcs(set_watermarks_table, 0, smu, clock_ranges)
 #define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_funcs(thermal_temperature_range_update, 0, smu, range, rw)
 #define smu_register_irq_handler(smu)					smu_ppt_funcs(register_irq_handler, 0, smu)
-- 
2.49.0

