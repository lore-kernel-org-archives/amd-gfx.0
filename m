Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83A8CCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 14:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE1110E2B0;
	Fri, 10 Oct 2025 14:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CkabRHjZ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091AB10E089
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 14:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJ2SmITrhKJcV6cY9vO0nx6yNE5ks9CF0b8CtsPhvwW4lNhCDu/tQPvLz0mH3K6kSzCubEqyfFCQg7ndBIakuNVPRHOTTaTrWYo/umyuCtGrPRNtVOVFeKaXqAHhrXlDPXDNUFToOXRWgeszUTujSsklO0HGE0anvGySP+99jyZKtNZQC+wSWImdRJkqIgN2kxMgqLN9jk5UAGmgtPQKzbKd/MWMHKdE5KNZBOuOgtsp59sVoOeuy6n4PB+a6TgB2ZqtatdNQEl21GNGPD8nWFD8nrNq08WV54bHqR37v31enuQPRipJqE0U0x76unpHZ0diEkU4IknIs7IcH3V9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XyCbBCIuxOjtOl0mJFF06W6Wn7rPGG4d0xFSDKzEaY=;
 b=q9Qme3EaoazFX0kXRg8qweC2QheUY0BiUxk6k6K8VVHiAI63O9VUhLs47jDfdbTLqv5xdqgInO5hAN/YOCQSwJoqbXTjuz2TrJxgmyorEp/M15aPIbx6Ib0Ffiyf0pmvF3f1i1+l2TGU8WjhSsEAXFx4NwAGtYYXu0qbPZnnRLEeZTzCfMXd2ERPzDmjVcDmjJvm2qhEEbTYv1FJThfHmwUk/pG+XN//IteA0NKnXWHa0oGtsLniXK/7AcuAmXs5o4syUdvmnTLiwBCBv4APEGAZ5I4HXxLxKL+z3FFwWGp58WHluUEWvRHWVzQkzgLjSP0Yy4XC3OYzdN6X5qi6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XyCbBCIuxOjtOl0mJFF06W6Wn7rPGG4d0xFSDKzEaY=;
 b=CkabRHjZLFTApm45cTAEE9Y5ft+P/CRJXKzCeaKMNI0RWYtK0LnBKbQzE21cFme3gCjNXxryfP/hoMgubDwr1irScZ4RLS8I2k7EAFK0RHGqVi+kihEs21F7zzB3+PRnh8s/bYzzLeX4HtGmv6sjhVmHZxwJkSx8nEt97Use+8o=
Received: from BN9PR03CA0454.namprd03.prod.outlook.com (2603:10b6:408:139::9)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:58:36 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::de) by BN9PR03CA0454.outlook.office365.com
 (2603:10b6:408:139::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 14:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 14:58:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 07:58:34 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Add amdgpu_discovery_info
Date: Fri, 10 Oct 2025 20:27:33 +0530
Message-ID: <20251010145814.3514884-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: b84c8251-710f-4d8a-c333-08de080d7d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wiBxslkyBD1y4oyaPphZc5kNioNd/r7xcCqxc9aku6Z846xUWvn1noxox7TF?=
 =?us-ascii?Q?X8Rd9y6CJEy+LcFUhhDbk1ssce0Oi16Mzf8lgiKOpiV3nXMKwIIbKwbkfIKv?=
 =?us-ascii?Q?Bo37x1AgKwr6hERRyT6H+FsKZGbD3nqmv9UzgP/dwuy/WbOgu5pGBUmG9dQ4?=
 =?us-ascii?Q?n++h0U8gcPV08cVcG8V5kto79niXGo9EQt6ukcZ4hS9ICH3LUBXdiCRBNauM?=
 =?us-ascii?Q?bEdlZejmWd2HhJ3XSm88wd5M3joTmnosD5jjQLx7Xab9aWytzMV4UWjYsGw+?=
 =?us-ascii?Q?Ls8VO5DpggGomJokPISl3XX1UhMt90nYZ2GibX0aGaKrDC3Wx6c6Y+GW6YXI?=
 =?us-ascii?Q?UKQagxeqGrQo8XRllKYHxzNETh36u3WaIZkSf+TA6Opgg2EEyHiGGHk9ZXtw?=
 =?us-ascii?Q?82IfZoDoYQMhVhtMuJY2PBmxgw3GpeeBXzGPkazNf7SyZY2vCvclqUAe2SDl?=
 =?us-ascii?Q?whokfF4W6kBAZQowiyCIu1QIvylBJNu+pDOKrM69XViskZUsp2JAAOdK1Sjh?=
 =?us-ascii?Q?eMvlRcfn6tZ93asi7xpO45UnJr1PyqtPeU0t/U+ldXG1npXNki5/eiYWNnNa?=
 =?us-ascii?Q?wL3kyVNq8SNHZet3Dl/ETKCK4n5TP5yCscEwY2iHYQUBsWlmEQm6VnTS9TY/?=
 =?us-ascii?Q?z3UaFT6VmSo6oasNr7hvObbV1Q86kcmPO+2Drdcqf9c0pLWhIwk7E6gReS5Z?=
 =?us-ascii?Q?QtpzrFnt6oQW2MTZDhoyUF41DQTE5Y25vneROcS5pQTaO/s34KD7AKATF5GB?=
 =?us-ascii?Q?czD2uoMK68RgOik/jYYiHTATbvFQgkrgIe8l8/zuafjXhPY5TuqdCsRULeZy?=
 =?us-ascii?Q?NjCmEY9ZFjJ+c/gdmSU1hf/k519787rkOx23r9YlherKx9CEb9XqKk2aspUl?=
 =?us-ascii?Q?1jd85AzmECAMPaac04KM8nOxQdRS5scA5kPRlphfN8czd0+hPgNu8JFoD+il?=
 =?us-ascii?Q?erK2lbAVUDqbDlqsjcAbOHRRyNHUJ7h3jvqzfjHMgLOge2bqpaIRVHmyAWOb?=
 =?us-ascii?Q?MmC3OcVJft6yiKcklL7IWIC1EiGeVXV9DHFPcRqDJyseTXsUxk4r+fVzQ5A9?=
 =?us-ascii?Q?kBuecSy61ngM4eZV/1jHZ6gHI4hNmlTrf0tWOYrJ+tkOcLEQEaTpn25cPl/a?=
 =?us-ascii?Q?gN4DkN8peDm5B9E1zBnGWvuRMahI128m+i/S+wZZaomA21CxgNtVLGDyHYwi?=
 =?us-ascii?Q?qBHCXCAbFPT7355ZoGlH/jVNpiq/L35GSdrqLbCF9x/bFj0+d/YNh1AdpaxH?=
 =?us-ascii?Q?8WU3KL9br+HoDmpzYqfgbedZrnrOQw4+RsfLGLul1t1rTnhmFViOkgcWLzYk?=
 =?us-ascii?Q?QXdV6mcXpHtxwd/KXeduN7XYR0VSJJGF7opsR/oiwQle1MuwhuwEbVWmwJle?=
 =?us-ascii?Q?I2gp/aVZcpuqLtCdfcLfUKU9Wr0nrzNS/iMZorTGdT3IZT62cOv3hYtAgt8Y?=
 =?us-ascii?Q?o/ZzupfzeEtkB9YJ+KY0siDSGaMUgkgVlfj58K0zNS7DOwcyQ19vpptelx0n?=
 =?us-ascii?Q?CfjjlhlUgEyF2dCY3nf2Uldkcz1cnEL9evUkuWRoYELjR/+yOCcpyaZ8kYPO?=
 =?us-ascii?Q?mBhJpZGfjOETJ4n+oEE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:58:36.2084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84c8251-710f-4d8a-c333-08de080d7d47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813
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

v2: Remove superfluous discovery_ prefix for members (Alex) 

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 192 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   2 +-
 6 files changed, 129 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9cbc8648f837..f52b783a8eb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -839,8 +839,6 @@ struct amd_powerplay {
 	const struct amd_pm_funcs *pp_funcs;
 };
 
-struct ip_discovery_top;
-
 /* polaris10 kickers */
 #define ASICID_IS_P20(did, rid)		(((did == 0x67DF) && \
 					 ((rid == 0xE3) || \
@@ -972,8 +970,7 @@ struct amdgpu_device {
 	struct notifier_block		acpi_nb;
 	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
-	struct debugfs_blob_wrapper     debugfs_vbios_blob;
-	struct debugfs_blob_wrapper     debugfs_discovery_blob;
+	struct debugfs_blob_wrapper debugfs_vbios_blob;
 	struct mutex			srbm_mutex;
 	/* GRBM index mutex. Protects concurrent access to GRBM index */
 	struct mutex                    grbm_idx_mutex;
@@ -1063,6 +1060,9 @@ struct amdgpu_device {
 		u32			log2_max_MBps;
 	} mm_stats;
 
+	/* discovery*/
+	struct amdgpu_discovery_info discovery;
+
 	/* display */
 	bool				enable_virtual_display;
 	struct amdgpu_vkms_output       *amdgpu_vkms_output;
@@ -1265,8 +1265,6 @@ struct amdgpu_device {
 
 	struct list_head                ras_list;
 
-	struct ip_discovery_top         *ip_top;
-
 	struct amdgpu_reset_domain	*reset_domain;
 
 	struct mutex			benchmark_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a70651050acf..f45926abea67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2123,10 +2123,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_blob("amdgpu_vbios", 0444, root,
 			    &adev->debugfs_vbios_blob);
 
-	adev->debugfs_discovery_blob.data = adev->mman.discovery_bin;
-	adev->debugfs_discovery_blob.size = adev->mman.discovery_tmr_size;
-	debugfs_create_blob("amdgpu_discovery", 0444, root,
-			    &adev->debugfs_discovery_blob);
+	if (adev->discovery.debugfs_blob.size)
+		debugfs_create_blob("amdgpu_discovery", 0444, root,
+				    &adev->discovery.debugfs_blob);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f3d42c5b1547..57f3c4373c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2626,7 +2626,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		chip_name = "arcturus";
 		break;
 	case CHIP_NAVI12:
-		if (adev->mman.discovery_bin)
+		if (adev->discovery.size)
 			return 0;
 		chip_name = "navi12";
 		break;
@@ -5038,7 +5038,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
-	if (adev->mman.discovery_bin)
+	if (adev->discovery.size)
 		amdgpu_discovery_fini(adev);
 
 	amdgpu_reset_put_reset_domain(adev->reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 73401f0aeb34..02b661232db8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -254,9 +254,9 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
 	pos = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
 
 	/* This region is read-only and reserved from system use */
-	discv_regn = memremap(pos, adev->mman.discovery_tmr_size, MEMREMAP_WC);
+	discv_regn = memremap(pos, adev->discovery.size, MEMREMAP_WC);
 	if (discv_regn) {
-		memcpy(binary, discv_regn, adev->mman.discovery_tmr_size);
+		memcpy(binary, discv_regn, adev->discovery.size);
 		memunmap(discv_regn);
 		return 0;
 	}
@@ -301,7 +301,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	if (sz_valid) {
 		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
-					  adev->mman.discovery_tmr_size, false);
+					  adev->discovery.size, false);
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
@@ -389,6 +389,7 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
 static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
 					   struct binary_header *bhdr)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
 	struct table_info *info;
 	uint16_t checksum;
 	uint16_t offset;
@@ -398,14 +399,14 @@ static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
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
@@ -447,49 +448,53 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
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
+	adev->discovery.bin = kzalloc(DISCOVERY_TMR_SIZE, GFP_KERNEL);
+	if (!adev->discovery.bin)
 		return -ENOMEM;
+	adev->discovery.size = DISCOVERY_TMR_SIZE;
+	adev->discovery.debugfs_blob.data = adev->discovery.bin;
+	adev->discovery.debugfs_blob.size = adev->discovery.size;
 
+	discovery_bin = adev->discovery.bin;
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
@@ -501,15 +506,16 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
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
@@ -522,7 +528,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (offset) {
 		struct gpu_info_header *ghdr =
-			(struct gpu_info_header *)(adev->mman.discovery_bin + offset);
+			(struct gpu_info_header *)(discovery_bin + offset);
 
 		if (le32_to_cpu(ghdr->table_id) != GC_TABLE_ID) {
 			dev_err(adev->dev, "invalid ip discovery gc table id\n");
@@ -530,8 +536,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
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
@@ -544,7 +551,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (offset) {
 		struct harvest_info_header *hhdr =
-			(struct harvest_info_header *)(adev->mman.discovery_bin + offset);
+			(struct harvest_info_header *)(discovery_bin + offset);
 
 		if (le32_to_cpu(hhdr->signature) != HARVEST_TABLE_SIGNATURE) {
 			dev_err(adev->dev, "invalid ip discovery harvest table signature\n");
@@ -552,8 +559,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
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
@@ -566,7 +574,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (offset) {
 		struct vcn_info_header *vhdr =
-			(struct vcn_info_header *)(adev->mman.discovery_bin + offset);
+			(struct vcn_info_header *)(discovery_bin + offset);
 
 		if (le32_to_cpu(vhdr->table_id) != VCN_INFO_TABLE_ID) {
 			dev_err(adev->dev, "invalid ip discovery vcn table id\n");
@@ -574,8 +582,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
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
@@ -588,7 +597,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (0 && offset) {
 		struct mall_info_header *mhdr =
-			(struct mall_info_header *)(adev->mman.discovery_bin + offset);
+			(struct mall_info_header *)(discovery_bin + offset);
 
 		if (le32_to_cpu(mhdr->table_id) != MALL_INFO_TABLE_ID) {
 			dev_err(adev->dev, "invalid ip discovery mall table id\n");
@@ -596,8 +605,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
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
@@ -607,8 +617,8 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	return 0;
 
 out:
-	kfree(adev->mman.discovery_bin);
-	adev->mman.discovery_bin = NULL;
+	kfree(adev->discovery.bin);
+	adev->discovery.bin = NULL;
 	if ((amdgpu_discovery != 2) &&
 	    (RREG32(mmIP_DISCOVERY_VERSION) == 4))
 		amdgpu_ras_query_boot_status(adev, 4);
@@ -620,8 +630,8 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
 void amdgpu_discovery_fini(struct amdgpu_device *adev)
 {
 	amdgpu_discovery_sysfs_fini(adev);
-	kfree(adev->mman.discovery_bin);
-	adev->mman.discovery_bin = NULL;
+	kfree(adev->discovery.bin);
+	adev->discovery.bin = NULL;
 }
 
 static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
@@ -646,6 +656,7 @@ static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
 static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 						uint32_t *vcn_harvest_count)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
@@ -655,21 +666,21 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
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
@@ -711,13 +722,14 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 						     uint32_t *vcn_harvest_count,
 						     uint32_t *umc_harvest_count)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
 	struct binary_header *bhdr;
 	struct harvest_table *harvest_info;
 	u16 offset;
 	int i;
 	uint32_t umc_harvest_config = 0;
 
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	bhdr = (struct binary_header *)discovery_bin;
 	offset = le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset);
 
 	if (!offset) {
@@ -725,7 +737,7 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 		return;
 	}
 
-	harvest_info = (struct harvest_table *)(adev->mman.discovery_bin + offset);
+	harvest_info = (struct harvest_table *)(discovery_bin + offset);
 
 	for (i = 0; i < 32; i++) {
 		if (le16_to_cpu(harvest_info->list[i].hw_id) == 0)
@@ -1021,8 +1033,8 @@ static void ip_disc_release(struct kobject *kobj)
 						       kobj);
 	struct amdgpu_device *adev = ip_top->adev;
 
-	adev->ip_top = NULL;
 	kfree(ip_top);
+	adev->discovery.ip_top = NULL;
 }
 
 static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
@@ -1060,6 +1072,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 				      const size_t _ip_offset, const int num_ips,
 				      bool reg_base_64)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
 	int ii, jj, kk, res;
 	uint16_t hw_id;
 	uint8_t inst;
@@ -1077,7 +1090,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			struct ip_v4 *ip;
 			struct ip_hw_instance *ip_hw_instance;
 
-			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
+			ip = (struct ip_v4 *)(discovery_bin + ip_offset);
 			inst = ip->instance_number;
 			hw_id = le16_to_cpu(ip->hw_id);
 			if (amdgpu_discovery_validate_ip(adev, inst, hw_id) ||
@@ -1164,17 +1177,20 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 
 static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 {
+	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
+	uint8_t *discovery_bin = adev->discovery.bin;
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
@@ -1183,7 +1199,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 		struct ip_die_entry *ip_die_entry;
 
 		die_offset = le16_to_cpu(ihdr->die_info[ii].die_offset);
-		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
+		dhdr = (struct die_header *)(discovery_bin + die_offset);
 		num_ips = le16_to_cpu(dhdr->num_ips);
 		ip_offset = die_offset + sizeof(*dhdr);
 
@@ -1217,30 +1233,32 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 
 static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
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
@@ -1254,7 +1272,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 
 	return res;
 Err:
-	kobject_put(&adev->ip_top->kobj);
+	kobject_put(&ip_top->kobj);
 	return res;
 }
 
@@ -1299,10 +1317,11 @@ static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_entry)
 
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
@@ -1311,8 +1330,8 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 		spin_lock(&die_kset->list_lock);
 	}
 	spin_unlock(&die_kset->list_lock);
-	kobject_put(&adev->ip_top->die_kset.kobj);
-	kobject_put(&adev->ip_top->kobj);
+	kobject_put(&ip_top->die_kset.kobj);
+	kobject_put(&ip_top->kobj);
 }
 
 /* ================================================== */
@@ -1323,6 +1342,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
+	uint8_t *discovery_bin;
 	struct ip_v4 *ip;
 	uint16_t die_offset;
 	uint16_t ip_offset;
@@ -1338,22 +1358,23 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	r = amdgpu_discovery_init(adev);
 	if (r)
 		return r;
-
+	discovery_bin = adev->discovery.bin;
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
 
@@ -1367,7 +1388,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				le16_to_cpu(dhdr->die_id), num_ips);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
+			ip = (struct ip_v4 *)(discovery_bin + ip_offset);
 
 			inst = ip->instance_number;
 			hw_id = le16_to_cpu(ip->hw_id);
@@ -1517,16 +1538,16 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
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
@@ -1573,22 +1594,23 @@ union gc_info {
 
 static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
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
@@ -1681,24 +1703,25 @@ union mall_info {
 
 static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
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
@@ -1737,12 +1760,13 @@ union vcn_info {
 
 static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
 	struct binary_header *bhdr;
 	union vcn_info *vcn_info;
 	u16 offset;
 	int v;
 
-	if (!adev->mman.discovery_bin) {
+	if (!discovery_bin) {
 		DRM_ERROR("ip discovery uninitialized\n");
 		return -EINVAL;
 	}
@@ -1757,13 +1781,13 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
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
@@ -1823,6 +1847,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  struct amdgpu_gmc_memrange **ranges,
 				  int *range_cnt, bool refresh)
 {
+	uint8_t *discovery_bin = adev->discovery.bin;
 	struct amdgpu_gmc_memrange *mem_ranges;
 	struct binary_header *bhdr;
 	union nps_info *nps_info;
@@ -1839,13 +1864,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
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
@@ -1855,8 +1880,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 		if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
 			return -ENOENT;
 
-		nps_info =
-			(union nps_info *)(adev->mman.discovery_bin + offset);
+		nps_info = (union nps_info *)(discovery_bin + offset);
 	}
 
 	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index b44d56465c5b..b1eec3af3c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -24,9 +24,20 @@
 #ifndef __AMDGPU_DISCOVERY__
 #define __AMDGPU_DISCOVERY__
 
+#include <linux/debugfs.h>
+
 #define DISCOVERY_TMR_SIZE      (10 << 10)
 #define DISCOVERY_TMR_OFFSET    (64 << 10)
 
+struct ip_discovery_top;
+
+struct amdgpu_discovery_info {
+	struct debugfs_blob_wrapper debugfs_blob;
+	struct ip_discovery_top *ip_top;
+	uint32_t size;
+	uint8_t *bin;
+};
+
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d13d28a5923c..5bf6bb3b2faa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1955,7 +1955,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * If IP discovery enabled, a block of memory should be
 	 * reserved for IP discovey.
 	 */
-	if (adev->mman.discovery_bin) {
+	if (adev->discovery.bin) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
-- 
2.49.0

