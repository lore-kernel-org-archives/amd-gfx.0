Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9D4C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 11:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FC210EA25;
	Fri,  9 May 2025 11:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IB3ttlGJ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C90710EA24
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 11:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTCP/ioaTH02lXAFuKie75Gpa08VZ2YUSb8qY5pqWT8d4SE1WteFQcjah4VPrv/u38DbHLY+qoOQKVfPsnKyCnwqzL2LMRp9Zojrib63zfhHuIIzg0ybdlMLMsGC/GD9+qNedNgw8Wb3eXx84P+TmnofAbKZ+PlcDca6MlTbH+3sChQm3kQbStwscnIlt5qYGszElNYbrlUdygVImws8Tgfem38K13nCuY5VQf3aN02A/SLTTH5zOVEUNMthBF58OHpsMNJGik0kPpMjYE+5NvHNEwToX3RAkRDNpQx/VLAIRea8wD/BEFhYPIY/IxsyUADf8RTu5AYb/25zDJ1ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJvbXkXkoh3Qj/Im1S79W+yTddPE56iFbFbqL9Lao2A=;
 b=BmcUpJrUVzNAzIumo5DfJ2m9kBH8SpJWztXAbTBkdm/y5FSwoIzRrLlu621T0ClM2WGMQWhqwdcc8l5nRJsyMvjBQUI30W2HUJDgoNc6lRtVHb9if7F7++l51yhGM0uD2E7PcVWsZAQh1W94CE7uHxpppWgSx5RviELb3EFbCyhQRUDFE0mc+2gUVFNkYO3GCsAkFK1lhEiYMhXVg+ut8fUEymX8vjgF7iPwkluXaClxRIrn7PdBF87EfYBT6xwIfYM7VW3Eu4yjCWEdWuro6ajHfgNf/cUn6jRbaht+kivMxPWpr3Eadyuih3Zz+jJqueB3CMlKhZgjY6onRSyjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJvbXkXkoh3Qj/Im1S79W+yTddPE56iFbFbqL9Lao2A=;
 b=IB3ttlGJ4LNL1M1FwapYzzF5wH7m4gr1hGNHzQ634HG8eRRVAc/4JAFRwqeUDGwg/3PbhBwxcotFiKrwZ4ERhcqxnF3jjN1LuZox7I2LuN30PWLuqAEcFQXLMsz3DIVA/NKSGkgsNHpgOLHNfQnKpbGKfu8vTKauk7iwcRLCPtY=
Received: from CH2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610::28) by
 MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 11:37:43 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::e8) by CH2PR05CA0015.outlook.office365.com
 (2603:10b6:610::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Fri,
 9 May 2025 11:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 11:37:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 06:37:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Amber.Lin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use compatible NPS mode info
Date: Fri, 9 May 2025 17:07:24 +0530
Message-ID: <20250509113725.312103-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a90d235-75e8-4987-c11e-08dd8eede961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1nHZPGjbxD4LrlUyuo7ssPilr1609Pld+/bYT98cV5fWpgwng/vNGSGy1Rmi?=
 =?us-ascii?Q?8Aq3snObNR+Pn0A7qI4exkxvYoxJk+GT1FNPSFfMAEz7k8AvbTiUFgwfZ6/Z?=
 =?us-ascii?Q?BzeJtUU5XtiOAmXMpNWeMYoUp2B555vfUpcMhKmYYNOB0RL0A7bySH/KH3Xp?=
 =?us-ascii?Q?EzFwTFAaGyVmx5PspcIY8l8r51SsQPeIOvZzUWOx0dK15m4skRTxPIqkhZ72?=
 =?us-ascii?Q?TwANg7iKOWKd8bAL3tpqB0hcdaIWaVmwi5qam7j6rHwEL+3GuAG794odkhXQ?=
 =?us-ascii?Q?XjDGqyd3h3P587hzOsAf7d2g7NKW0iJ/ob0vrkpgoNJD8FbY2Z8prnxJZrhv?=
 =?us-ascii?Q?GB21l711lDqXtImTS61DsbeVukj/+vEsjErWh/dDcX5rDfoGMOkcVsPCFcYA?=
 =?us-ascii?Q?gzWkLwpmrC1z8zQRkkmvAhDtlh5YLCALSMZhz2rCPCne25F0jh36D1vuE5z5?=
 =?us-ascii?Q?TklpPn+i6cUZUtWBiLqwzqx81RpidtBcJYZKUqGo7BiC4CQc5qkpGkpozJje?=
 =?us-ascii?Q?BTQkqlec81SkbjyFORsEErQe1gt3DQmzNwruZ1d2zZQvpScZ8NMZTiVtbVeR?=
 =?us-ascii?Q?y+IUXo1zHKc1vchP0vkeb3O0MGUcC0///zeFg42onCo6M3pwrHzk39eTcPdl?=
 =?us-ascii?Q?bvGJ4O7iQaufGozsFOkgrSAJaLiVI04+p4ueqoIZ16aq1aqcUEC06MNtT9Us?=
 =?us-ascii?Q?ycaZ4xoF8Ci0kzpo8IL2Q890Afh9V3btFttppGj2G6DKEXgMA9XqhEYoy1pU?=
 =?us-ascii?Q?9CGm7DisTp3h1zf5cB2fKp0iof0dEZj7q7AU6uS6EjPJKhIPV8/dhi6AMpVs?=
 =?us-ascii?Q?Cx1vkP1Htd+1FM4JFK3iLyPkLMZZpEa95RmyPqKLtpKaeopIVR8mpHb/HfO4?=
 =?us-ascii?Q?fgAjoTw2KhQvm4dHERlNVzbu/8k2jQWdg/FZABTfzcYF5d3KP02xgm8rWve3?=
 =?us-ascii?Q?d4d25/ssj72qCJvQwF1otAUX34quMmp+z0wmFkpcmeejXMTQn+O5/eriD9Yb?=
 =?us-ascii?Q?Rggs3H5sxshzc3lYsnIgCkHeMG5Ft/DmrnhEncuIeGG6bNFw9b9nLbMxVa+W?=
 =?us-ascii?Q?A1wEaoaaoL/cMWiIqN2auR9pE0dKN3QYZzk6xPO3Br3uMavaxY8ur0cMdbbm?=
 =?us-ascii?Q?HnH8Jq4iHACnhffzf/E5wEmNBAgRTxbAPk7y8SXk1KnVSXS9aM8RNYSLqVqN?=
 =?us-ascii?Q?4yiHhBFHWSrcOMZZUcEQj3MrjVE2bBdCbZHoRmGMzm9hpbH2s04Ah8euxL/P?=
 =?us-ascii?Q?n8fkjv+GtPnzzLsDNrLeaG9heaMeAHwrPGiqx2FnPz5g0BP2rMpeR657LEPe?=
 =?us-ascii?Q?XHuVgNcXRlNinbTHx8ZFhRVkEGgfmCu6AHGtmAa8/1DyU87c6Uqgq8Eqq9Wa?=
 =?us-ascii?Q?tejIGOW0vL/M4ohxwVYJN0h8nFgNg1Vz0LjRv7yTS3umAoWhHWJ6mNz18Mhz?=
 =?us-ascii?Q?V/iMyhSFhKw6bilWEgw47MeaOym0hnLWU4sIEUqOaX5AuvzCR5rNCaafwgHt?=
 =?us-ascii?Q?xRYbgYOUA2DJG0bZ5pwYtM3UufObfoosSTSX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:37:42.9828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a90d235-75e8-4987-c11e-08dd8eede961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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

Compatible NPS modes for a partition mode are exposed through xcp_config
interface. To determine if a compute partition mode is valid, check if
the current NPS mode is part of compatible NPS modes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 103 ++++++++++++---------
 1 file changed, 60 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index ae071985f26e..d4bd24e3c390 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -448,53 +448,69 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int x
 	return 0;
 }
 
-static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
-					  int mode,
-					  struct amdgpu_xcp_cfg *xcp_cfg)
+static int __aqua_vanjaram_get_px_mode_info(struct amdgpu_xcp_mgr *xcp_mgr,
+					    int px_mode, int *num_xcp,
+					    uint16_t *nps_modes)
 {
 	struct amdgpu_device *adev = xcp_mgr->adev;
-	int max_res[AMDGPU_XCP_RES_MAX] = {};
-	bool res_lt_xcp;
-	int num_xcp, i;
-	u16 nps_modes;
 
-	if (!(xcp_mgr->supp_xcp_modes & BIT(mode)))
+	if (!num_xcp || !nps_modes || !(xcp_mgr->supp_xcp_modes & BIT(px_mode)))
 		return -EINVAL;
 
-	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
-	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
-	max_res[AMDGPU_XCP_RES_DEC] = adev->vcn.num_vcn_inst;
-	max_res[AMDGPU_XCP_RES_JPEG] = adev->jpeg.num_jpeg_inst;
-
-	switch (mode) {
+	switch (px_mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
-		num_xcp = 1;
-		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
+		*num_xcp = 1;
+		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE);
 		break;
 	case AMDGPU_DPX_PARTITION_MODE:
-		num_xcp = 2;
-		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
-			    BIT(AMDGPU_NPS2_PARTITION_MODE);
+		*num_xcp = 2;
+		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			     BIT(AMDGPU_NPS2_PARTITION_MODE);
 		break;
 	case AMDGPU_TPX_PARTITION_MODE:
-		num_xcp = 3;
-		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
-			    BIT(AMDGPU_NPS4_PARTITION_MODE);
+		*num_xcp = 3;
+		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			     BIT(AMDGPU_NPS4_PARTITION_MODE);
 		break;
 	case AMDGPU_QPX_PARTITION_MODE:
-		num_xcp = 4;
-		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
-			    BIT(AMDGPU_NPS4_PARTITION_MODE);
+		*num_xcp = 4;
+		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			     BIT(AMDGPU_NPS4_PARTITION_MODE);
 		break;
 	case AMDGPU_CPX_PARTITION_MODE:
-		num_xcp = NUM_XCC(adev->gfx.xcc_mask);
-		nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
-			    BIT(AMDGPU_NPS4_PARTITION_MODE);
+		*num_xcp = NUM_XCC(adev->gfx.xcc_mask);
+		*nps_modes = BIT(AMDGPU_NPS1_PARTITION_MODE) |
+			     BIT(AMDGPU_NPS4_PARTITION_MODE);
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
+					  int mode,
+					  struct amdgpu_xcp_cfg *xcp_cfg)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int max_res[AMDGPU_XCP_RES_MAX] = {};
+	bool res_lt_xcp;
+	int num_xcp, i, r;
+	u16 nps_modes;
+
+	if (!(xcp_mgr->supp_xcp_modes & BIT(mode)))
+		return -EINVAL;
+
+	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
+	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
+	max_res[AMDGPU_XCP_RES_DEC] = adev->vcn.num_vcn_inst;
+	max_res[AMDGPU_XCP_RES_JPEG] = adev->jpeg.num_jpeg_inst;
+
+	r = __aqua_vanjaram_get_px_mode_info(xcp_mgr, mode, &num_xcp, &nps_modes);
+	if (r)
+		return r;
+
 	xcp_cfg->compatible_nps_modes =
 		(adev->gmc.supported_nps_modes & nps_modes);
 	xcp_cfg->num_res = ARRAY_SIZE(max_res);
@@ -543,30 +559,31 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 					  enum amdgpu_gfx_partition mode)
 {
 	struct amdgpu_device *adev = xcp_mgr->adev;
-	int num_xcc, num_xccs_per_xcp;
+	int num_xcc, num_xccs_per_xcp, r;
+	int num_xcp, nps_mode;
+	u16 supp_nps_modes;
+	bool comp_mode;
+
+	nps_mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+	r = __aqua_vanjaram_get_px_mode_info(xcp_mgr, mode, &num_xcp,
+					       &supp_nps_modes);
+	if (r)
+		return false;
 
+	comp_mode = !!(BIT(nps_mode) & supp_nps_modes);
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
-		return adev->gmc.num_mem_partitions == 1 && num_xcc > 0;
+		return comp_mode && num_xcc > 0;
 	case AMDGPU_DPX_PARTITION_MODE:
-		return adev->gmc.num_mem_partitions <= 2 && (num_xcc % 4) == 0;
+		return comp_mode && (num_xcc % 4) == 0;
 	case AMDGPU_TPX_PARTITION_MODE:
-		return (adev->gmc.num_mem_partitions == 1 ||
-			adev->gmc.num_mem_partitions == 3) &&
-		       ((num_xcc % 3) == 0);
+		return comp_mode && ((num_xcc % 3) == 0);
 	case AMDGPU_QPX_PARTITION_MODE:
 		num_xccs_per_xcp = num_xcc / 4;
-		return (adev->gmc.num_mem_partitions == 1 ||
-			adev->gmc.num_mem_partitions == 4) &&
-		       (num_xccs_per_xcp >= 2);
+		return comp_mode && (num_xccs_per_xcp >= 2);
 	case AMDGPU_CPX_PARTITION_MODE:
-		/* (num_xcc > 1) because 1 XCC is considered SPX, not CPX.
-		 * (num_xcc % adev->gmc.num_mem_partitions) == 0 because
-		 * num_compute_partitions can't be less than num_mem_partitions
-		 */
-		return ((num_xcc > 1) &&
-		       (num_xcc % adev->gmc.num_mem_partitions) == 0);
+		return comp_mode && (num_xcc > 1);
 	default:
 		return false;
 	}
-- 
2.25.1

