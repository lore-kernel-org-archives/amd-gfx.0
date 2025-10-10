Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBACCAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 04:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94AC010E26E;
	Fri, 10 Oct 2025 04:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sxb45bAr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FCB10E267
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 04:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM+HfPj55pBi+Fa7P3tJxDcNFGwX+Hl1Mi4MXWzCetM3EiqNHEfVMrcSSExOziX+7mRct3tC8uCAMPOgBaPm8McV6LxNA6nUwkb0PANynGp2bVnJ5teaGZGtkKFIsvv1F1oyb1g6nAv/MfGzNSPOfBbI5+YgP0z3ATMLMPUy/sydRnCej86sXoJTwKlu15WOSiB0IMesQK1sPgqCnyvU3NT73aLhVjcmczaKICfhFSrflpMNsJprnhduGedlCY1tDLIoc/EE5LIrLQNuxZ4ipYCv79jfOzgNEsPqSuE+7Ng46Yu5o+bAtURXMKRyBXzgrIGfvOeoio8KLC6AgcBZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hLddIxefCeT3bpqMLSUZVgcAVDHBwRFy8v/xoLNICU=;
 b=KDBTR04jaVrR0DH6YqyO/rDU3O3wUrq4ZNl+T3IzmbZYpxWP7zoFw6B6BOKu5tcapecTfL3Zxse8adrV8KO99iWSPUXDZAUJu/e2gLPLHby//svCQRKLNkE5QDQCg2A0KxidryWVr2Vl+gI3HHaCFvewgIuwHcvjG5d6+r9qLLD7/hlLU0rmH4Dr52lp+ljfrg64W2sQN4xFw5XHH8cUOij91/fuFwpX7bGmuO5riJj7O1YAzCWUXnC58ERPbRo6yW3BtNi6k1XMomdY7KTA6DSl3ccP74UJJWjrD6Ry48G7Hur9JBWC17oEoBIMzqla7Y1kmYntd3rl515AfbNIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hLddIxefCeT3bpqMLSUZVgcAVDHBwRFy8v/xoLNICU=;
 b=sxb45bArq25LDCoBIlth0wezDjF02sDsmg2XqFjMX74whza/3oAtJtdB098mg0DqM7D5/hUjdDfyH56C7E04EyH6j+EJg47NfLIe2XzJJHeOXWyAjaZC0kVaykTq/6InlKkXlJJb34v0aS6ckvPXY1UJiP1LvMJ3pW9w5NDMUec=
Received: from BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::14)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:43:27 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::6f) by BL1P222CA0009.outlook.office365.com
 (2603:10b6:208:2c7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 04:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 04:43:26 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 21:43:26 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: Introduce SRIOV critical regions v2 during VF
 init
Date: Thu, 9 Oct 2025 23:43:06 -0500
Message-ID: <20251010044309.11822-3-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010044309.11822-1-yunru.pan@amd.com>
References: <20251010044309.11822-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db32bc8-2c33-4e50-df5b-08de07b78d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ET7oXNCHfgjUwQK9KGIW74yUKeS+tiiXEncScNlLj5KYaWMBVAR33X2+Mn/S?=
 =?us-ascii?Q?HudF5UgZ05CE3WkOyjgDXN0BUdhULFILu+2QCnOUvop9c2OtLmG0kKEoQN8O?=
 =?us-ascii?Q?K+2TJ+bC8t7BHatRthjpQD9OeSghqAKpfhf45AXMBi31v/lBr5mI8YYxTrSp?=
 =?us-ascii?Q?hPUcBiDCur/sNGyR6Sn5iBX5LRyjK9qYOtH7LLFJH3xALug+RaM1zalFdsaN?=
 =?us-ascii?Q?ByHBce3aelANVRz8mhZp3BVVCox6GkUvKJlqMXBJhXz0VicjxXbnmwaROGrA?=
 =?us-ascii?Q?oI0kteXN1mynvKN9R/1/wP6/wwxbd/ViD3/7aFK3w7vVu/9kGtHf/BQ1ALv0?=
 =?us-ascii?Q?OuKmbkw4CG5mKF04BJuVM1nKM1VNLalcvOhBDVYWg8tJTtTaSA6epAucoXhT?=
 =?us-ascii?Q?NhEDLioJkcAmQWc9hQtTeXJ0wLUgY2cPbtBRcoKUWReb4SdLJaeIGKbYchMZ?=
 =?us-ascii?Q?oTwGJGYUthsT+o6fLIeMHKx32jtdihupQ50yVaL/A2XTEX9l99ASiXNeSCkr?=
 =?us-ascii?Q?rijY6buPGjYSc2CYteO6IzhEZox1oQVU+VyLYOqg/3mnZaw8RvqJqrMQg6jN?=
 =?us-ascii?Q?/RsuicjFlfbFtye6WIEGUaE9LO3BfTq2l7wG3l/AYUOCjNNOUrVePwuYGMAm?=
 =?us-ascii?Q?tzxbp15JPNlNK93p1uRKw3z2sSkREvIyjXEMPJv8XmN/csqrv08I8bavqg3Y?=
 =?us-ascii?Q?PT9RXXmmQGAjf3pw7fB3V0XU1e2hrPE3SrPuqfPS0VFXQKyeGCZIEy9MYlaH?=
 =?us-ascii?Q?cLxIL6ZngePFG35LQJh+CcAQjCXEI8RIPUYPjnt5r+SOfvdWEfoWz6hJRSfp?=
 =?us-ascii?Q?TwmplD529E4y26gd5om6/ob2M5fNWuwwkdrRnHS1kpN2xCAPamOMNwyWVgmR?=
 =?us-ascii?Q?vXkPipduYPX/QM5DSyYs9SD5qq+CgW3X4UkKw4cwpybhSsp6lygy28ARjBAI?=
 =?us-ascii?Q?pxZpehAAbV3HsHGXKThJBKR60X9QmPH4EIVdqXEXJ69HW9rCJDSeziKfKAFs?=
 =?us-ascii?Q?1FLz5f0g/90GzkAm+M89xCBuw946Q0mT0k0+lizYFs6SQO3DSfu4B/fIqyoa?=
 =?us-ascii?Q?OTIgPxCuFEZPg5z0GsHPVEybBZ+4wxj0eaQq3JqWgUZDlhaJNsN7k3WSJ2B4?=
 =?us-ascii?Q?PWuGooSM5Vjj7FWBACuN9qeNuNriLSNC5VeVoi9ZfJWkk+Ku7oFUClapxFOx?=
 =?us-ascii?Q?zFSyqCsdWM71TvbzamJYkDAj2+L51xRC1/wh6A+Et5/Ju1g0v43kA0AR7NoD?=
 =?us-ascii?Q?IO/d3S6mi/HvyGjoh5ht29CzvWn8Q4xFf1ZgLZ7lWXzad3QGeioGwvahlubK?=
 =?us-ascii?Q?sF/7xCpJm2X2AmaNdrPStf7VMdmP4k19yc0+7RY2qYh1U1Vg91G8drNuUfu7?=
 =?us-ascii?Q?3onTE9wk/VXAK3lb1aE86mwXSDjwFpsF9oWrptTDsZIGJivcWRHBgfp6M2/O?=
 =?us-ascii?Q?Ie7c7a64PcQY0WVHDbAeDOkOM1qt4qztUomC58jpl5siWBo2xPLJ9mKwz7yP?=
 =?us-ascii?Q?4Y2oZEHu2XtA0Jpzl2W7EuXBxl+6LJGoGi1l6jI09E/ViT2oQn6YeqB8R7HF?=
 =?us-ascii?Q?X5Xg5CHeyZhAyvDiGl0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:43:26.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db32bc8-2c33-4e50-df5b-08de07b78d9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
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

    1. Introduced amdgpu_virt_init_critical_region during VF init.
     - VFs use init_data_header_offset and init_data_header_size_kb
            transmitted via PF2VF mailbox to fetch the offset of
            critical regions' offsets/sizes in VRAM and save to
            adev->virt.crit_region_offsets and adev->virt.crit_region_sizes_kb.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 113 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |   7 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++++
 4 files changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 929936c8d87c..351cfe03a1aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2754,6 +2754,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return r;
+
+		r = amdgpu_virt_init_critical_region(adev);
+		if (r)
+			return r;
 	}
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3a6b0e1084d7..6eca5e8a7375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -843,6 +843,119 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
 	adev->virt.ras.cper_rptr = 0;
 }
 
+static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
+{
+	uint32_t sum = 0;
+
+	if (buf_start >= buf_end)
+		return 0;
+
+	for (; buf_start < buf_end; buf_start++)
+		sum += buf_start[0];
+
+	return 0xffffffff - sum;
+}
+
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
+	uint32_t init_hdr_offset = adev->virt.init_data_header.offset;
+	uint32_t init_hdr_size = adev->virt.init_data_header.size_kb << 10;
+	uint64_t pos = 0;
+	uint64_t vram_size;
+	int r = 0;
+	uint8_t checksum = 0;
+
+	/* Skip below init if critical region version != v2 */
+	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
+		return 0;
+
+	if (init_hdr_offset < 0) {
+		dev_err(adev->dev, "Invalid init header offset\n");
+		return -EINVAL;
+	}
+
+	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+	if (!vram_size || vram_size == U32_MAX)
+		return -EINVAL;
+	vram_size <<= 20;
+
+	if ((init_hdr_offset + init_hdr_size) > vram_size) {
+		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
+		return -EINVAL;
+	}
+
+	/* Allocate for init_data_hdr */
+	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
+	if (!init_data_hdr)
+		return -ENOMEM;
+
+	pos = (uint64_t)init_hdr_offset;
+	amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
+					sizeof(struct amd_sriov_msg_init_data_header), false);
+
+	switch (init_data_hdr->version) {
+	case GPU_CRIT_REGION_V2:
+		if (strncmp(init_data_hdr->signature, "INDA", 4) != 0) {
+			dev_err(adev->dev, "Invalid init data signature: %.4s\n",
+					init_data_hdr->signature);
+			r = -EINVAL;
+			goto out;
+		}
+
+		checksum = amdgpu_virt_crit_region_calc_checksum(
+				(uint8_t *)&init_data_hdr->initdata_offset,
+				(uint8_t *)init_data_hdr +
+				sizeof(struct amd_sriov_msg_init_data_header));
+		if (checksum != init_data_hdr->checksum) {
+			dev_err(adev->dev, "Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
+					checksum, init_data_hdr->checksum);
+			r = -EINVAL;
+			goto out;
+		}
+
+		/* Initialize critical region offsets */
+		adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
+			init_data_hdr->ip_discovery_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
+			init_data_hdr->vbios_img_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
+			init_data_hdr->ras_tele_info_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
+			init_data_hdr->dataexchange_offset;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
+			init_data_hdr->bad_page_info_offset;
+
+		/* Initialize critical region sizes */
+		adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
+			init_data_hdr->ip_discovery_size_in_kb;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
+			init_data_hdr->vbios_img_size_in_kb;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
+			init_data_hdr->ras_tele_info_size_in_kb;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
+			init_data_hdr->dataexchange_size_in_kb;
+		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
+			init_data_hdr->bad_page_size_in_kb;
+
+		adev->virt.is_dynamic_crit_regn_enabled = true;
+		break;
+	default:
+		dev_err(adev->dev, "Invalid init header version: %u\n",
+				init_data_hdr->version);
+		r = -EINVAL;
+		goto out;
+	}
+
+out:
+	kfree(init_data_hdr);
+	init_data_hdr = NULL;
+
+	return r;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 51ff73b1fcd5..bc1fc1c6daba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -52,6 +52,8 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
+#define mmRCC_CONFIG_MEMSIZE	0xde3
+
 #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
 
 enum amdgpu_sriov_vf_mode {
@@ -296,6 +298,9 @@ struct amdgpu_virt {
 
 	/* dynamic(v2) critical regions */
 	struct amdgpu_virt_region init_data_header;
+	struct amdgpu_virt_region crit_regn;
+	struct amdgpu_virt_region crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
+	bool is_dynamic_crit_regn_enabled;
 
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
@@ -432,6 +437,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
 void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index b53caab5b706..d15c256f9abd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -70,6 +70,37 @@ enum amd_sriov_crit_region_version {
 	GPU_CRIT_REGION_V2 = 2,
 };
 
+/* v2 layout offset enum (in order of allocation) */
+enum amd_sriov_msg_table_id_enum {
+	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
+	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
+	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
+	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
+	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
+	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
+	AMD_SRIOV_MSG_MAX_TABLE_ID,
+};
+
+struct amd_sriov_msg_init_data_header {
+	char     signature[4];  /* "INDA"  */
+	uint32_t version;
+	uint32_t checksum;
+	uint32_t initdata_offset; /* 0 */
+	uint32_t initdata_size_in_kb; /* 5MB */
+	uint32_t valid_tables;
+	uint32_t vbios_img_offset;
+	uint32_t vbios_img_size_in_kb;
+	uint32_t dataexchange_offset;
+	uint32_t dataexchange_size_in_kb;
+	uint32_t ras_tele_info_offset;
+	uint32_t ras_tele_info_size_in_kb;
+	uint32_t ip_discovery_offset;
+	uint32_t ip_discovery_size_in_kb;
+	uint32_t bad_page_info_offset;
+	uint32_t bad_page_size_in_kb;
+	uint32_t reserved[8];
+};
+
 /*
  * PF2VF history log:
  * v1 defined in amdgim
-- 
2.34.1

