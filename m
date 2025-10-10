Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DBDCCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 14:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0D810E0BA;
	Fri, 10 Oct 2025 14:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DEMEzfAM";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010020.outbound.protection.outlook.com
 [52.101.193.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2351D10E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 14:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+c93+JYIaMc+7fU/QRW76XSX9HT0R/FKcGQapBAqIa5rW7CqL1YRljcVD4Qj8gVfvx3y8T/vzZXPgrIj7mnzoa3iNzyO8yi0wopbRcadgRzxO6qkVFD2Hbui2YTAn0/umhU3LqdMEC+m7MeEQ+9YkfiI+mBmqdGjXyMY6jNrelk7GoWSRj9htfr/PduQicHFndA6AqAGeMpKNmVRLK8sG4VPPqDRlgwhWZymtpcxVGUoEBYotAmZpNHLua4uVrLMNvTztWLWPh/68cvVfYa7nVt21komjRg17k17+I7ePFVkYeFs9vI2Vv/Q8OIV2cZgc7WR+9jOjxKYvZwYMpcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX16Ih5CYZ8sy5O/AllgNZ4xZh6XDXTjyKvLZwFtprs=;
 b=L0bWV5rRI5TLPAA5/HYypX18nbaLFiULWl/sRmeNhC+SXNub3LwAHzlqMLF/9UHyt/3cLS6f7f2Aj3zleIMThuySY/9Ze7zcLTbynUahV8yJkABs3DWJ2gLzAbm/cw2pO8CulJA1jpK3PIPz5RwZJlaH6KSCeNV15GxaZTUIe+ZuTjEMI5hB9CE+TcBB08Bfgx/5Z6pFwDe6EHt5EweRozfqXktmMf3p3US41VkI51o62v7gzAiOfofXB4KRKs3qDwU4YKHyPDSQw9dM0+dBeVLTp+f/9cG4QfOW5c+Jo64kX+g5HJye+BzkM1gCiKZrjtB+2G23Jo6xPvqiorpBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX16Ih5CYZ8sy5O/AllgNZ4xZh6XDXTjyKvLZwFtprs=;
 b=DEMEzfAMrCFDe0TVX26XB8sKjg+MfzxkkM+IZpMwBXfqH8jh518691MQXHkciAAPTsBjWWN1wM9RDTnZnGH0S5LK5OdGJihlyIEtnZ4TNkjLNGQ8eDZ/rDeBePsKrjw/oWxA9MJIkvH/rkqiRjMBNByQ5A21dRQbek3WCk1Q8Nc=
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:02:22 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::59) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 14:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 14:02:20 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 07:02:18 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add amdgpu_discovery_info
Date: Fri, 10 Oct 2025 19:32:00 +0530
Message-ID: <20251010140201.3492361-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7c4e84-c326-4185-aaa6-08de0805a16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VaKUd+ATPYHb34rwPb6SRvcBLHqVVb86WDAoxEBLzNxa0T1ag2Voo5VQGMUD?=
 =?us-ascii?Q?+VmuybLVjWKw/m2+SOxFIsUQ5G5srEHMcfodi9Q/Ih8u0soqBdDd8QMq9vzs?=
 =?us-ascii?Q?8t9y5ufLuRBFgmzuzCOcHqxqEV9XJhEOUDyPWLqbakYpmH7DZU1g84HSdoXW?=
 =?us-ascii?Q?Qa0reTNP0nsfDzo3Mo6ue1p+oScPe+bY7nRDStxlwKUjMOthgIy2obfRpZAI?=
 =?us-ascii?Q?WQgBiOq1HkXYyuw/vUnr+1O/InnHQD2TmY/kfv4TIhOD7Ao40gaQOoNRsk1W?=
 =?us-ascii?Q?q+bDrQUA/nVB2drM/wHMUO6g0cqu48bFFlu2jIG6LmvVNrHZClCT8myETF2e?=
 =?us-ascii?Q?Wlrpto+zTElRwc+MVpS/XzA+i1a/335lK2rIl60i76yjnnxB9SE2x0i0qCr4?=
 =?us-ascii?Q?eNlGV9NsXQh84GVEkKCT0LYnUj/fL4PgH+9XJapGzi1biFM/qF5646GMK7ap?=
 =?us-ascii?Q?Nja51W7nEU9VXpmB18AjZTwAraCSo7Kkd3EM6DEb/Ogoru5d66UAxyFFy55Z?=
 =?us-ascii?Q?y7AMDRQqoh4LE0805OmR9C/TRWOfwpfU9L8F2BcNel6LS6k2NsN9c7J9Wlmm?=
 =?us-ascii?Q?pExeBORmvN3uy33CZZ7wmzdp6UGr47SWYeMXIHbElfA4bjtlgAHuWQLHk0cN?=
 =?us-ascii?Q?KkleoZA61DTvXYkmnpBki7dle15nnrmTrRohqBpCnDwAMXIc4sU1KSsPde3p?=
 =?us-ascii?Q?t6EK8tFjns9iEYoAtLqiLsCWAZf1vsfKM+dgav+dqDPrbXLaeUvQDpRU7gqk?=
 =?us-ascii?Q?trMmZo6ivJrcOYulifqRJk0HqvdS8WaVEU8+BX16QQ9H09QSl9idHIt0tnpg?=
 =?us-ascii?Q?yOMUd74UVATZGyAhVQUHB89Xb06+Vmd3fw84qJBlmsUCXkFY2zTH+n1/CZ10?=
 =?us-ascii?Q?jLgRDDE8Rkc6W3nNh4latzXR8WmCADkw9Tr9Ee51q94rllJpfgPIaNE/dGPj?=
 =?us-ascii?Q?gFre+cGU9KgE1atOPnEA0nb5vOcxpfkv7eIrL3j1ubzaFl4Do4WmtXlQPaTo?=
 =?us-ascii?Q?1yLD31HRIBvpMOIbX6/fCNro8XIWKpNyWo9vK+GPhz5C3wBI+qJcSZVvTaHz?=
 =?us-ascii?Q?SF5oxExlK2l29e14+xcBLAcC9zwFdGz+aZxpg1+yq6jQw+lGPZ8ZvGsr3j56?=
 =?us-ascii?Q?XM48Ervn2TeTNPHPADe7buH9xAfkoTWozo9irElGyNSqIrKqRFpoOL/xk+BV?=
 =?us-ascii?Q?aO2tLa8pIyzM1dPDZXYwKxbEKrlcyaxgiYMBURuDmWpyiDPqbCKlqiFCE2P2?=
 =?us-ascii?Q?iC0xijOMMsnvhq+FcEPIhOgXQHL7rzZr/r4gycRbGjmoQArZrszczN3NyoKa?=
 =?us-ascii?Q?wS7czEKMURQTde1DImdJDRfl1bycWpaYBu4RQVL25Hkrzj2RaU4L4QwoLF4n?=
 =?us-ascii?Q?y0T1ujvBgya4wM4SKG1vl9vRhSQeoU/2t50ZsSfZNG14Shu6SJyANmlvoyNA?=
 =?us-ascii?Q?1sgsErNpQ4YjOLcRTbMDgksbVlLw6lmoIerlYNgSnHLub6zKw8PCjlKtJNQN?=
 =?us-ascii?Q?4vAGTjF++EgAPhYDfhScyRK3QGAwYaaDB1Tn25lNBfkbqt5BzX4fnIKmvWKE?=
 =?us-ascii?Q?V+ceYMqkyGpKAyKlHzg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:02:20.9007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7c4e84-c326-4185-aaa6-08de0805a16e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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

Add amdgpu_discovery_info structure to keep all discovery related
information.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 196 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   2 +-
 6 files changed, 129 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9cbc8648f837..fcc8c31ffd51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -972,8 +972,7 @@ struct amdgpu_device {
 	struct notifier_block		acpi_nb;
 	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
-	struct debugfs_blob_wrapper     debugfs_vbios_blob;
-	struct debugfs_blob_wrapper     debugfs_discovery_blob;
+	struct debugfs_blob_wrapper debugfs_vbios_blob;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
@@ -1063,6 +1062,9 @@ struct amdgpu_device {
 		u32			log2_max_MBps;
 	} mm_stats;
 
+	/* discovery*/
+	struct amdgpu_discovery_info discovery;
+
 	/* display */
 	bool				enable_virtual_display;
 	struct amdgpu_vkms_output       *amdgpu_vkms_output;
@@ -1265,8 +1267,6 @@ struct amdgpu_device {
 
 	struct list_head                ras_list;
 
-	struct ip_discovery_top         *ip_top;
-
 	struct amdgpu_reset_domain	*reset_domain;
 
 	struct mutex			benchmark_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a70651050acf..062a8ee50a77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2123,10 +2123,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
 			    &adev->debugfs_vbios_blob);
 
-	adev->debugfs_discovery_blob.data = adev->mman.discovery_bin;
-	adev->debugfs_discovery_blob.size = adev->mman.discovery_tmr_size;
-	debugfs_create_blob("amdgpu_discovery", 0444, root,
-			    &adev->debugfs_discovery_blob);
+	if (adev->discovery.debugfs_discovery_blob.size)
+		debugfs_create_blob("amdgpu_discovery", 0444, root,
+				    &adev->discovery.debugfs_discovery_blob);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f3d42c5b1547..4eada22cca4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2626,7 +2626,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		chip_name = "arcturus";
 		break;
 	case CHIP_NAVI12:
-		if (adev->mman.discovery_bin)
+		if (adev->discovery.discovery_bin)
 			return 0;
 		chip_name = "navi12";
 		break;
@@ -5038,7 +5038,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
-	if (adev->mman.discovery_bin)
+	if (adev->discovery.discovery_bin)
 		amdgpu_discovery_fini(adev);
 
 	amdgpu_reset_put_reset_domain(adev->reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 73401f0aeb34..bd324385e18a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -254,9 +254,10 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
 	pos = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
 
 	/* This region is read-only and reserved from system use */
-	discv_regn = memremap(pos, adev->mman.discovery_tmr_size, MEMREMAP_WC);
+	discv_regn =
+		memremap(pos, adev->discovery.discovery_tmr_size, MEMREMAP_WC);
 	if (discv_regn) {
-		memcpy(binary, discv_regn, adev->mman.discovery_tmr_size);
+		memcpy(binary, discv_regn, adev->discovery.discovery_tmr_size);
 		memunmap(discv_regn);
 		return 0;
 	}
@@ -301,7 +302,8 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	if (sz_valid) {
 		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
-					  adev->mman.discovery_tmr_size, false);
+					  adev->discovery.discovery_tmr_size,
+					  false);
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
@@ -389,6 +391,7 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
 static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
 					   struct binary_header *bhdr)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct table_info *info;
 	uint16_t checksum;
 	uint16_t offset;
@@ -398,14 +401,14 @@ static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
 	checksum = le16_to_cpu(info->checksum);
 
 	struct nps_info_header *nhdr =
-		(struct nps_info_header *)(adev->mman.discovery_bin + offset);
+		(struct nps_info_header *)(discovery_bin + offset);
 
 	if (le32_to_cpu(nhdr->table_id) != NPS_INFO_TABLE_ID) {
 		dev_dbg(adev->dev, "invalid ip discovery nps info table id\n");
 		return -EINVAL;
 	}
 
-	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
+	if (!amdgpu_discovery_verify_checksum(discovery_bin + offset,
 					      le32_to_cpu(nhdr->size_bytes),
 					      checksum)) {
 		dev_dbg(adev->dev, "invalid nps info data table checksum\n");
@@ -447,49 +450,55 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
 	struct binary_header *bhdr;
+	uint8_t *discovery_bin;
 	const char *fw_name;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
 	int r;
 
-	adev->mman.discovery_tmr_size = DISCOVERY_TMR_SIZE;
-	adev->mman.discovery_bin = kzalloc(adev->mman.discovery_tmr_size, GFP_KERNEL);
-	if (!adev->mman.discovery_bin)
+	adev->discovery.discovery_bin = kzalloc(DISCOVERY_TMR_SIZE, GFP_KERNEL);
+	if (!adev->discovery.discovery_bin)
 		return -ENOMEM;
+	adev->discovery.discovery_tmr_size = DISCOVERY_TMR_SIZE;
+	adev->discovery.debugfs_discovery_blob.data =
+		adev->discovery.discovery_bin;
+	adev->discovery.debugfs_discovery_blob.size =
+		adev->discovery.discovery_tmr_size;
 
+	discovery_bin = adev->discovery.discovery_bin;
 	/* Read from file if it is the preferred option */
 	fw_name = amdgpu_discovery_get_fw_name(adev);
 	if (fw_name != NULL) {
 		drm_dbg(&adev->ddev, "use ip discovery information from file");
-		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
+		r = amdgpu_discovery_read_binary_from_file(adev, discovery_bin,
+							   fw_name);
 		if (r)
 			goto out;
 	} else {
 		drm_dbg(&adev->ddev, "use ip discovery information from memory");
-		r = amdgpu_discovery_read_binary_from_mem(
-			adev, adev->mman.discovery_bin);
+		r = amdgpu_discovery_read_binary_from_mem(adev, discovery_bin);
 		if (r)
 			goto out;
 	}
 
 	/* check the ip discovery binary signature */
-	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+	if (!amdgpu_discovery_verify_binary_signature(discovery_bin)) {
 		dev_err(adev->dev,
 			"get invalid ip discovery binary signature\n");
 		r = -EINVAL;
 		goto out;
 	}
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	bhdr = (struct binary_header *)discovery_bin;
 
 	offset = offsetof(struct binary_header, binary_checksum) +
 		sizeof(bhdr->binary_checksum);
 	size = le16_to_cpu(bhdr->binary_size) - offset;
 	checksum = le16_to_cpu(bhdr->binary_checksum);
 
-	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-					      size, checksum)) {
+	if (!amdgpu_discovery_verify_checksum(discovery_bin + offset, size,
+					      checksum)) {
 		dev_err(adev->dev, "invalid ip discovery binary checksum\n");
 		r = -EINVAL;
 		goto out;
@@ -501,15 +510,16 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (offset) {
 		struct ip_discovery_header *ihdr =
-			(struct ip_discovery_header *)(adev->mman.discovery_bin + offset);
+			(struct ip_discovery_header *)(discovery_bin + offset);
 		if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
 			dev_err(adev->dev, "invalid ip discovery data table signature\n");
 			r = -EINVAL;
 			goto out;
 		}
 
-		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-						      le16_to_cpu(ihdr->size), checksum)) {
+		if (!amdgpu_discovery_verify_checksum(discovery_bin + offset,
+						      le16_to_cpu(ihdr->size),
+						      checksum)) {
 			dev_err(adev->dev, "invalid ip discovery data table checksum\n");
 			r = -EINVAL;
 			goto out;
@@ -522,7 +532,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (offset) {
 		struct gpu_info_header *ghdr =
-			(struct gpu_info_header *)(adev->mman.discovery_bin + offset);
+			(struct gpu_info_header *)(discovery_bin + offset);
 
 		if (le32_to_cpu(ghdr->table_id) != GC_TABLE_ID) {
 			dev_err(adev->dev, "invalid ip discovery gc table id\n");
@@ -530,8 +540,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			goto out;
 		}
 
-		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-						      le32_to_cpu(ghdr->size), checksum)) {
+		if (!amdgpu_discovery_verify_checksum(discovery_bin + offset,
+						      le32_to_cpu(ghdr->size),
+						      checksum)) {
 			dev_err(adev->dev, "invalid gc data table checksum\n");
 			r = -EINVAL;
 			goto out;
@@ -544,7 +555,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (offset) {
 		struct harvest_info_header *hhdr =
-			(struct harvest_info_header *)(adev->mman.discovery_bin + offset);
+			(struct harvest_info_header *)(discovery_bin + offset);
 
 		if (le32_to_cpu(hhdr->signature) != HARVEST_TABLE_SIGNATURE) {
 			dev_err(adev->dev, "invalid ip discovery harvest table signature\n");
@@ -552,8 +563,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			goto out;
 		}
 
-		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-						      sizeof(struct harvest_table), checksum)) {
+		if (!amdgpu_discovery_verify_checksum(
+			    discovery_bin + offset,
+			    sizeof(struct harvest_table), checksum)) {
 			dev_err(adev->dev, "invalid harvest data table checksum\n");
 			r = -EINVAL;
 			goto out;
@@ -566,7 +578,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (offset) {
 		struct vcn_info_header *vhdr =
-			(struct vcn_info_header *)(adev->mman.discovery_bin + offset);
+			(struct vcn_info_header *)(discovery_bin + offset);
 
 		if (le32_to_cpu(vhdr->table_id) != VCN_INFO_TABLE_ID) {
 			dev_err(adev->dev, "invalid ip discovery vcn table id\n");
@@ -574,8 +586,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			goto out;
 		}
 
-		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-						      le32_to_cpu(vhdr->size_bytes), checksum)) {
+		if (!amdgpu_discovery_verify_checksum(
+			    discovery_bin + offset,
+			    le32_to_cpu(vhdr->size_bytes), checksum)) {
 			dev_err(adev->dev, "invalid vcn data table checksum\n");
 			r = -EINVAL;
 			goto out;
@@ -588,7 +601,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (0 && offset) {
 		struct mall_info_header *mhdr =
-			(struct mall_info_header *)(adev->mman.discovery_bin + offset);
+			(struct mall_info_header *)(discovery_bin + offset);
 
 		if (le32_to_cpu(mhdr->table_id) != MALL_INFO_TABLE_ID) {
 			dev_err(adev->dev, "invalid ip discovery mall table id\n");
@@ -596,8 +609,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			goto out;
 		}
 
-		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
-						      le32_to_cpu(mhdr->size_bytes), checksum)) {
+		if (!amdgpu_discovery_verify_checksum(
+			    discovery_bin + offset,
+			    le32_to_cpu(mhdr->size_bytes), checksum)) {
 			dev_err(adev->dev, "invalid mall data table checksum\n");
 			r = -EINVAL;
 			goto out;
@@ -607,8 +621,8 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	return 0;
 
 out:
-	kfree(adev->mman.discovery_bin);
-	adev->mman.discovery_bin = NULL;
+	kfree(adev->discovery.discovery_bin);
+	adev->discovery.discovery_bin = NULL;
 	if ((amdgpu_discovery != 2) &&
 	    (RREG32(mmIP_DISCOVERY_VERSION) == 4))
 		amdgpu_ras_query_boot_status(adev, 4);
@@ -620,8 +634,8 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
 	amdgpu_discovery_sysfs_fini(adev);
-	kfree(adev->mman.discovery_bin);
-	adev->mman.discovery_bin = NULL;
+	kfree(adev->discovery.discovery_bin);
+	adev->discovery.discovery_bin = NULL;
 }
 
 static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
@@ -646,6 +660,7 @@ static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
 static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 						uint32_t *vcn_harvest_count)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
@@ -655,21 +670,21 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	uint8_t inst;
 	int i, j;
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
-			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+	bhdr = (struct binary_header *)discovery_bin;
+	ihdr = (struct ip_discovery_header
+			*)(discovery_bin +
+			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
 	/* scan harvest bit of all IP data structures */
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
+		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->mman.discovery_bin +
-					   ip_offset);
+			ip = (struct ip *)(discovery_bin + ip_offset);
 			inst = ip->number_instance;
 			hw_id = le16_to_cpu(ip->hw_id);
 			if (amdgpu_discovery_validate_ip(adev, inst, hw_id))
@@ -711,13 +726,14 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 						     uint32_t *vcn_harvest_count,
 						     uint32_t *umc_harvest_count)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
 	u16 offset;
 	int i;
 	uint32_t umc_harvest_config = 0;
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	bhdr = (struct binary_header *)discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset);
 
 	if (!offset) {
@@ -725,7 +741,7 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 		return;
 	}
 
-	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin + offset);
+	harvest_info = (struct harvest_table *)(discovery_bin + offset);
 
 	for (i = 0; i < 32; i++) {
 		if (le16_to_cpu(harvest_info->list[i].hw_id) == 0)
@@ -1021,8 +1037,8 @@ static void ip_disc_release(struct kobject *kobj)
 						       kobj);
 	struct amdgpu_device *adev = ip_top->adev;
 
-	adev->ip_top = NULL;
 	kfree(ip_top);
+	adev->discovery.ip_top = NULL;
 }
 
 static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
@@ -1060,6 +1076,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 				      const size_t _ip_offset, const int num_ips,
 				      bool reg_base_64)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	int ii, jj, kk, res;
 	uint16_t hw_id;
 	uint8_t inst;
@@ -1077,7 +1094,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			struct ip_v4 *ip;
 			struct ip_hw_instance *ip_hw_instance;
 
-			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
+			ip = (struct ip_v4 *)(discovery_bin + ip_offset);
 			inst = ip->instance_number;
 			hw_id = le16_to_cpu(ip->hw_id);
 			if (amdgpu_discovery_validate_ip(adev, inst, hw_id) ||
@@ -1164,17 +1181,20 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 
 static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 {
+	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
-	struct kset *die_kset = &adev->ip_top->die_kset;
+	struct kset *die_kset = &ip_top->die_kset;
 	u16 num_dies, die_offset, num_ips;
 	size_t ip_offset;
 	int ii, res;
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
-					      le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+	bhdr = (struct binary_header *)discovery_bin;
+	ihdr = (struct ip_discovery_header
+			*)(discovery_bin +
+			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
 	DRM_DEBUG("number of dies: %d\n", num_dies);
@@ -1183,7 +1203,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 		struct ip_die_entry *ip_die_entry;
 
 		die_offset = le16_to_cpu(ihdr->die_info[ii].die_offset);
-		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
+		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
@@ -1217,30 +1237,32 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 
 static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
+	struct ip_discovery_top *ip_top;
 	struct kset *die_kset;
 	int res, ii;
 
-	if (!adev->mman.discovery_bin)
+	if (!discovery_bin)
 		return -EINVAL;
 
-	adev->ip_top = kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
-	if (!adev->ip_top)
+	ip_top = kzalloc(sizeof(*ip_top), GFP_KERNEL);
+	if (!ip_top)
 		return -ENOMEM;
 
-	adev->ip_top->adev = adev;
-
-	res = kobject_init_and_add(&adev->ip_top->kobj, &ip_discovery_ktype,
+	ip_top->adev = adev;
+	adev->discovery.ip_top = ip_top;
+	res = kobject_init_and_add(&ip_top->kobj, &ip_discovery_ktype,
 				   &adev->dev->kobj, "ip_discovery");
 	if (res) {
 		DRM_ERROR("Couldn't init and add ip_discovery/");
 		goto Err;
 	}
 
-	die_kset = &adev->ip_top->die_kset;
+	die_kset = &ip_top->die_kset;
 	kobject_set_name(&die_kset->kobj, "%s", "die");
-	die_kset->kobj.parent = &adev->ip_top->kobj;
+	die_kset->kobj.parent = &ip_top->kobj;
 	die_kset->kobj.ktype = &die_kobj_ktype;
-	res = kset_register(&adev->ip_top->die_kset);
+	res = kset_register(&ip_top->die_kset);
 	if (res) {
 		DRM_ERROR("Couldn't register die_kset");
 		goto Err;
@@ -1254,7 +1276,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 
 	return res;
 Err:
-	kobject_put(&adev->ip_top->kobj);
+	kobject_put(&ip_top->kobj);
 	return res;
 }
 
@@ -1299,10 +1321,11 @@ static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_entry)
 
 static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 {
+	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
 	struct list_head *el, *tmp;
 	struct kset *die_kset;
 
-	die_kset = &adev->ip_top->die_kset;
+	die_kset = &ip_top->die_kset;
 	spin_lock(&die_kset->list_lock);
 	list_for_each_prev_safe(el, tmp, &die_kset->list) {
 		list_del_init(el);
@@ -1311,8 +1334,8 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 		spin_lock(&die_kset->list_lock);
 	}
 	spin_unlock(&die_kset->list_lock);
-	kobject_put(&adev->ip_top->die_kset.kobj);
-	kobject_put(&adev->ip_top->kobj);
+	kobject_put(&ip_top->die_kset.kobj);
+	kobject_put(&ip_top->kobj);
 }
 
 /* ================================================== */
@@ -1323,6 +1346,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
+	uint8_t *discovery_bin;
 	struct ip_v4 *ip;
 	uint16_t die_offset;
 	uint16_t ip_offset;
@@ -1338,22 +1362,23 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	r = amdgpu_discovery_init(adev);
 	if (r)
 		return r;
-
+	discovery_bin = adev->discovery.discovery_bin;
 	wafl_ver = 0;
 	adev->gfx.xcc_mask = 0;
 	adev->sdma.sdma_mask = 0;
 	adev->vcn.inst_mask = 0;
 	adev->jpeg.inst_mask = 0;
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
-			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+	bhdr = (struct binary_header *)discovery_bin;
+	ihdr = (struct ip_discovery_header
+			*)(discovery_bin +
+			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
 	num_dies = le16_to_cpu(ihdr->num_dies);
 
 	DRM_DEBUG("number of dies: %d\n", num_dies);
 
 	for (i = 0; i < num_dies; i++) {
 		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
+		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
@@ -1367,7 +1392,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				le16_to_cpu(dhdr->die_id), num_ips);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
+			ip = (struct ip_v4 *)(discovery_bin + ip_offset);
 
 			inst = ip->instance_number;
 			hw_id = le16_to_cpu(ip->hw_id);
@@ -1517,16 +1542,16 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct ip_discovery_header *ihdr;
 	struct binary_header *bhdr;
 	int vcn_harvest_count = 0;
 	int umc_harvest_count = 0;
 	uint16_t offset, ihdr_ver;
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	bhdr = (struct binary_header *)discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset);
-	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
-					      offset);
+	ihdr = (struct ip_discovery_header *)(discovery_bin + offset);
 	ihdr_ver = le16_to_cpu(ihdr->version);
 	/*
 	 * Harvest table does not fit Navi1x and legacy GPUs,
@@ -1573,22 +1598,23 @@ union gc_info {
 
 static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct binary_header *bhdr;
 	union gc_info *gc_info;
 	u16 offset;
 
-	if (!adev->mman.discovery_bin) {
+	if (!discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	bhdr = (struct binary_header *)discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[GC].offset);
 
 	if (!offset)
 		return 0;
 
-	gc_info = (union gc_info *)(adev->mman.discovery_bin + offset);
+	gc_info = (union gc_info *)(discovery_bin + offset);
 
 	switch (le16_to_cpu(gc_info->v1.header.version_major)) {
 	case 1:
@@ -1681,24 +1707,25 @@ union mall_info {
 
 static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct binary_header *bhdr;
 	union mall_info *mall_info;
 	u32 u, mall_size_per_umc, m_s_present, half_use;
 	u64 mall_size;
 	u16 offset;
 
-	if (!adev->mman.discovery_bin) {
+	if (!discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	bhdr = (struct binary_header *)discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[MALL_INFO].offset);
 
 	if (!offset)
 		return 0;
 
-	mall_info = (union mall_info *)(adev->mman.discovery_bin + offset);
+	mall_info = (union mall_info *)(discovery_bin + offset);
 
 	switch (le16_to_cpu(mall_info->v1.header.version_major)) {
 	case 1:
@@ -1737,12 +1764,13 @@ union vcn_info {
 
 static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct binary_header *bhdr;
 	union vcn_info *vcn_info;
 	u16 offset;
 	int v;
 
-	if (!adev->mman.discovery_bin) {
+	if (!discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
@@ -1757,13 +1785,13 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	bhdr = (struct binary_header *)discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
 
 	if (!offset)
 		return 0;
 
-	vcn_info = (union vcn_info *)(adev->mman.discovery_bin + offset);
+	vcn_info = (union vcn_info *)(discovery_bin + offset);
 
 	switch (le16_to_cpu(vcn_info->v1.header.version_major)) {
 	case 1:
@@ -1823,6 +1851,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  struct amdgpu_gmc_memrange **ranges,
 				  int *range_cnt, bool refresh)
 {
+	uint8_t *discovery_bin = adev->discovery.discovery_bin;
 	struct amdgpu_gmc_memrange *mem_ranges;
 	struct binary_header *bhdr;
 	union nps_info *nps_info;
@@ -1839,13 +1868,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 			return r;
 		nps_info = &nps_data;
 	} else {
-		if (!adev->mman.discovery_bin) {
+		if (!discovery_bin) {
 			dev_err(adev->dev,
 				"fetch mem range failed, ip discovery uninitialized\n");
 			return -EINVAL;
 		}
 
-		bhdr = (struct binary_header *)adev->mman.discovery_bin;
+		bhdr = (struct binary_header *)discovery_bin;
 		offset = le16_to_cpu(bhdr->table_list[NPS_INFO].offset);
 
 		if (!offset)
@@ -1855,8 +1884,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 		if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
 			return -ENOENT;
 
-		nps_info =
-			(union nps_info *)(adev->mman.discovery_bin + offset);
+		nps_info = (union nps_info *)(discovery_bin + offset);
 	}
 
 	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index b44d56465c5b..842cb59cea6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -27,6 +27,13 @@
 #define DISCOVERY_TMR_SIZE      (10 << 10)
 #define DISCOVERY_TMR_OFFSET    (64 << 10)
 
+struct amdgpu_discovery_info {
+	struct debugfs_blob_wrapper debugfs_discovery_blob;
+	struct ip_discovery_top *ip_top;
+	uint32_t discovery_tmr_size;
+	uint8_t *discovery_bin;
+};
+
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d13d28a5923c..73336291984a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1955,7 +1955,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * If IP discovery enabled, a block of memory should be
 	 * reserved for IP discovey.
 	 */
-	if (adev->mman.discovery_bin) {
+	if (adev->discovery.discovery_bin) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
-- 
2.49.0

