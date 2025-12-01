Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C745BD116F9
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F0810E368;
	Mon,  1 Dec 2025 10:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NKHJ2bqD";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B5B10E368
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjCT2VMfJahXR29nW/Xdc7eBZV/CdOu4Hqb0nE1eP0nuZMwHObfwxdCY9QFLso/Zz46HIp/BvcZDi/pV4rt7KlctNlA4aq+zR9uwYo3dR0FOigJIGQY7S+H9xEpTvv31bXsgPdKbXPYVO02G71zfyhXTn7KNgcKKRFC/D4PBXVQni0iYZie4E6fRCXbwTKFY2cqv0HVug1q+hjb8pl8HE4UYixffelZusl2SiYbcGTyxb9ioRAWmYc5bJtu6GB15BOl4Js0HfXNGVrUQKjkgtNBriYInEpCvQnco6RXuWSc7H+7jcQDRzUyxtfFx5cNJZmEhS9JflxtJSsk6GiCF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfEJK14Pln2UJPeJsIGc30qS0y5Xx78KsY2GDcpTclk=;
 b=Av1hXKp0JsYhZAxzX+Dzy17jWVrvpKhXpvRJFO4AhC2XoiAC4SS4iePVra9nJXqx+61uHX4gIsMsmmSx+I9W8vRr9bj1ZM9rPCySFd4iwYFaYHk1HVsfxA1OUDvIURlczmSYDKWVcj0FM3Md7aBjKZ8AOMjAZWBXDmhlOy+szM1muPh0hAIc3k+x6nqgbYNNsboz1y/p8m+2q6SToRz4x7O6OSyi1Y9cDwh8w+kmfpWTDsiopIRpA6KVYVSKOjwsAjcT4fl35nmjCgTiX8wjISxiUtoTl1/p0ARKHrAR/owuIEEnXKWgNPaXmaCqby+qsqVWp1cFqVr0SzoWHDavyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfEJK14Pln2UJPeJsIGc30qS0y5Xx78KsY2GDcpTclk=;
 b=NKHJ2bqDesChNLgqd1A53g71lpHZfuy3kVzbLAVl4bQcovkWO+C2xi3vnHw6gbAuolEwsbPC8+dvXbn/0KZ8RtmCcQFE0tzP+/E9e8fJ+4oSOhU+K/rq1MDXcatNH7H5xpzW9jHah2jzHj+vxzrOLIwV4HEL3479P9C51r6KYQk=
Received: from CH2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:59::40)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:24 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::3b) by CH2PR03CA0030.outlook.office365.com
 (2603:10b6:610:59::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:22 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 06/17] drm/amd/pm: Use generic pcie dpm table for SMUv11
Date: Mon, 1 Dec 2025 15:33:19 +0530
Message-ID: <20251201101331.101584-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
References: <20251201101331.101584-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 926cdab1-149b-47b4-6ee1-08de30c266d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/y9RzrCEBHTeoj3B6J7LewrBqbbh2Y9r6Xgk9uH5EGtwPwJMIuiRYmJosdvX?=
 =?us-ascii?Q?kSBmw71PB+cL5T83NahSZL1I3TUdnrqT75zaCUhYV2CXsVnHI+nQpk3ujxk7?=
 =?us-ascii?Q?2PfsMrFflRWK0UcZo3k+dvjNtDrg8qPQSHlNAivmseHOatyGsc664i3revvE?=
 =?us-ascii?Q?R0bE5JS13kYyQZmgZtyz8jXMPUP8DdnmYjNIvvWyN9AggZj0kCcOxQDAPK3z?=
 =?us-ascii?Q?bpXKLr2QMFq4lb7C4kGizDunwQ7FYwjqlqf+i46Hw6mFXfsCC9ndgX7L5VXP?=
 =?us-ascii?Q?Mw9IYrpqmsks+zr5TRA04+cNEAvdgODo+g7XaZyU/wgIYCNhFoqNsiEyBaxG?=
 =?us-ascii?Q?TiACepEMuKLg2APVuF4rDiF8+wSJvlRSQ3S3F0lumHgMcBRd9z0SliO4A8bE?=
 =?us-ascii?Q?o7n8mIjZpfDVhzOtoRikX0E2bpsTqfUSuKsafsaJCN2UR09gAaPsUFORm4aq?=
 =?us-ascii?Q?w/lBRguzEbi0L+kqX+Dn/m8PBtNrGLUM+75anT3k+3TbxNZCj+Qw8nflD4s8?=
 =?us-ascii?Q?pWECit9yjzHN+rAmhVQSMjLxvV29MHdC7UzreyKsTBDjgC9hxb3dsQ2o5+2Y?=
 =?us-ascii?Q?yVRvDwe63cePRkVYzHtkzpk0P3nzq3svB2Lb89M+mAljRIJL6UcFmyWRLlj2?=
 =?us-ascii?Q?h8b1850gitg2JFbfHVcq8EsXiofNbeN/DbemAyrNl3l7CrQaB/w4YgRgn982?=
 =?us-ascii?Q?ry6d9x0WAucuRKwz+mQJ/G5xFeViIGvozpJbnHgdd6XdS/FxCPrgFrmTXBVE?=
 =?us-ascii?Q?tLqw2HzKhvI7lLPdpqi0EKzg4fhJMO0ppd/2mdBURKCqBYlPxRFt8FsE7wcL?=
 =?us-ascii?Q?zjerQ5wE1OmzTq4zoiaVAltAxncKxx14Q8wdNqQuPm48vNfwBcZT+o7p9na5?=
 =?us-ascii?Q?wA2aeDby/qLoxkLsmSvuTOWYw5hYRCIITjwdxRJQ0QJffg7QeliASd8rYEJv?=
 =?us-ascii?Q?TKTiJ32YADfomziycmUSjrFFZQpQrS9XnwT8UcMhyCUwQNAqcvlHTfzVLXVY?=
 =?us-ascii?Q?wPt0tANzvmPjAO6cbE8dgLF+KvFCM42jEOA7skut2Xa9V8WgM8X5aBaZGonZ?=
 =?us-ascii?Q?m3GP6IqhNbBeBOnyISig0SMrqD6yVrIyILWHhUaYhxnVc9PTrSZUa64feglk?=
 =?us-ascii?Q?Xdv36599DLVL/rPnriCKjoskp08AC4YNEG9GtIH8CEySweAlU6dPc5pwQvmc?=
 =?us-ascii?Q?GMCHc8j+j+R6mF3Xz1U7XztUJWHRjx7I/4gUij1n01tW/KsE8tCnvXPuGa5X?=
 =?us-ascii?Q?dND0e33PSGdC7Vm1KhSyUTHmmpd2AHFI5/7fqqNQeBpxSJAGmdzIb7nsxcSu?=
 =?us-ascii?Q?G1No2GlHzFSgS6hmho9bLh07AtYxvNC73OJYoODnbkKxSIwzW41MDwglAcfC?=
 =?us-ascii?Q?ziXcO0DK2bevSEPiSlQjttGt7hVIgNf7ErQ8M6kY18pWcY1kjHS7qYPIJsAB?=
 =?us-ascii?Q?XSGVJSOdUAVbB2weu+CiMey+sk+oVEWhhvQLIe6laHdRoH0XMTOYvf3M7K6l?=
 =?us-ascii?Q?vSESMMaTa1SDZu3IySsvX4hnv4E91dLg5tHPKuZOvfUuRmU0cgDE5M5WLOIQ?=
 =?us-ascii?Q?V5+oLcUn2TA2CbrTNO8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:23.9654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926cdab1-149b-47b4-6ee1-08de30c266d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

Use smu_pcie_table for SMUv11 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  8 +--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 45 ++++++++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 50 +++++++++++--------
 3 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index 02c4072f57d5..d18934c6fbd5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -79,12 +79,6 @@ struct smu_11_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
-
-struct smu_11_0_pcie_table {
-	uint8_t  pcie_gen[MAX_PCIE_CONF];
-	uint8_t  pcie_lane[MAX_PCIE_CONF];
-};
-
 struct smu_11_0_dpm_tables {
 	struct smu_dpm_table             soc_table;
 	struct smu_dpm_table             gfx_table;
@@ -99,7 +93,7 @@ struct smu_11_0_dpm_tables {
 	struct smu_dpm_table             display_table;
 	struct smu_dpm_table             phy_table;
 	struct smu_dpm_table             fclk_table;
-	struct smu_11_0_pcie_table       pcie_table;
+	struct smu_pcie_table            pcie_table;
 };
 
 struct smu_11_0_dpm_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 4ad59c107a33..71ea20bcaf4f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1259,10 +1259,10 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 	uint32_t gen_speed, lane_width;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	PPTable_t *pptable = (PPTable_t *)table_context->driver_pptable;
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
+	struct smu_pcie_table *pcie_table;
 	uint32_t min_value, max_value;
 
 	switch (clk_type) {
@@ -1332,22 +1332,28 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
-		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			*offset += sysfs_emit_at(buf, *offset, "%d: %s %s %dMhz %s\n", i,
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 3) ? "16.0GT/s," : "",
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 1) ? "x1" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 2) ? "x2" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 3) ? "x4" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 4) ? "x8" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 5) ? "x12" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 6) ? "x16" : "",
-					pptable->LclkFreq[i],
-					(gen_speed == dpm_context->dpm_tables.pcie_table.pcie_gen[i]) &&
-					(lane_width == dpm_context->dpm_tables.pcie_table.pcie_lane[i]) ?
-					"*" : "");
+		pcie_table = &dpm_context->dpm_tables.pcie_table;
+		for (i = 0; i < pcie_table->lclk_levels; i++) {
+			*offset += sysfs_emit_at(
+				buf, *offset, "%d: %s %s %dMhz %s\n", i,
+				(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
+				(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
+				(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
+				(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
+								 "",
+				(pcie_table->pcie_lane[i] == 1) ? "x1" :
+				(pcie_table->pcie_lane[i] == 2) ? "x2" :
+				(pcie_table->pcie_lane[i] == 3) ? "x4" :
+				(pcie_table->pcie_lane[i] == 4) ? "x8" :
+				(pcie_table->pcie_lane[i] == 5) ? "x12" :
+				(pcie_table->pcie_lane[i] == 6) ? "x16" :
+								  "",
+				pcie_table->lclk_freq[i],
+				(gen_speed == pcie_table->pcie_gen[i]) &&
+						(lane_width ==
+						 pcie_table->pcie_lane[i]) ?
+					"*" :
+					"");
 		}
 		break;
 	case SMU_OD_SCLK:
@@ -2245,10 +2251,13 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 	int i;
 
 	/* lclk dpm table setup */
-	for (i = 0; i < MAX_PCIE_CONF; i++) {
+	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pptable->PcieGenSpeed[i];
 		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pptable->PcieLaneCount[i];
+		dpm_context->dpm_tables.pcie_table.lclk_freq[i] =
+			pptable->LclkFreq[i];
 	}
+	dpm_context->dpm_tables.pcie_table.lclk_levels = NUM_LINK_LEVELS;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 1e47dd2d915e..6bac81408614 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -958,6 +958,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
 	DpmDescriptor_t *table_member;
+	uint16_t *lclk_freq;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
@@ -1141,6 +1142,11 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->dpm_levels[0].enabled = true;
 	}
 
+	GET_PPTABLE_MEMBER(LclkFreq, &lclk_freq);
+	for (i = 0; i < NUM_LINK_LEVELS; i++)
+		dpm_context->dpm_tables.pcie_table.lclk_freq[i] = lclk_freq[i];
+	dpm_context->dpm_tables.pcie_table.lclk_levels = NUM_LINK_LEVELS;
+
 	return 0;
 }
 
@@ -1269,13 +1275,12 @@ static int sienna_cichlid_emit_clk_levels(struct smu_context *smu,
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	uint16_t *table_member;
-
 	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
 	int i, size = *offset, ret = 0, start_offset = *offset;
 	uint32_t cur_value = 0, value = 0, count = 0;
+	struct smu_pcie_table *pcie_table;
 	uint32_t freq_values[3] = {0};
 	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
@@ -1338,23 +1343,28 @@ static int sienna_cichlid_emit_clk_levels(struct smu_context *smu,
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
-		GET_PPTABLE_MEMBER(LclkFreq, &table_member);
-		for (i = 0; i < NUM_LINK_LEVELS; i++)
-			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 1) ? "5.0GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 2) ? "8.0GT/s," :
-					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 3) ? "16.0GT/s," : "",
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 1) ? "x1" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 2) ? "x2" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 3) ? "x4" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 4) ? "x8" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 5) ? "x12" :
-					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 6) ? "x16" : "",
-					table_member[i],
-					(gen_speed == dpm_context->dpm_tables.pcie_table.pcie_gen[i]) &&
-					(lane_width == dpm_context->dpm_tables.pcie_table.pcie_lane[i]) ?
-					"*" : "");
+		pcie_table = &dpm_context->dpm_tables.pcie_table;
+		for (i = 0; i < pcie_table->lclk_levels; i++)
+			size += sysfs_emit_at(
+				buf, size, "%d: %s %s %dMhz %s\n", i,
+				(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
+				(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
+				(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
+				(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
+								 "",
+				(pcie_table->pcie_lane[i] == 1) ? "x1" :
+				(pcie_table->pcie_lane[i] == 2) ? "x2" :
+				(pcie_table->pcie_lane[i] == 3) ? "x4" :
+				(pcie_table->pcie_lane[i] == 4) ? "x8" :
+				(pcie_table->pcie_lane[i] == 5) ? "x12" :
+				(pcie_table->pcie_lane[i] == 6) ? "x16" :
+								  "",
+				pcie_table->lclk_freq[i],
+				(gen_speed == pcie_table->pcie_gen[i]) &&
+						(lane_width ==
+						 pcie_table->pcie_lane[i]) ?
+					"*" :
+					"");
 		break;
 	case SMU_OD_SCLK:
 		if (!smu->od_enabled || !od_table || !od_settings)
@@ -2129,7 +2139,7 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 						 uint8_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
+	struct smu_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
 	uint8_t *table_member1, *table_member2;
 	uint8_t min_gen_speed, max_gen_speed;
 	uint8_t min_lane_width, max_lane_width;
-- 
2.49.0

