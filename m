Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399C6CCD195
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A696310E6A0;
	Tue, 14 Oct 2025 20:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7U/U1Yp";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59E810E698
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 20:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnhUwkT1OWiZbwpr4UlRPRfmVafeTU1WEW7UddUzBzwoG80vvz17bYaQYgkHRfHkVcYwNSWfLy5Re+WoO1lPngX1cLkmqejoBm6FdlWmHJfXieRZf50H5nsf+DtUpgLpiI38UY1d4aq5C+iANi0mOz0gRtTfai7ioILprTqUC5iUzrILvcG3OMEOTJwsXN4UW6TerRlo0e5dj7caQRTXzvjoKOBlsJg6+diwI4NxnDRnKJpbOCwvravVtkPNQWvy5Xu1CuOZF6oivGIMGQQM2i9vkT9gQgMo2lEcr+mX9fOI3PE9DYngEolm6LrSK+GU840pZbWkHyxH/WX7OoghiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jELSDSFlwTrNoZytY04Wd6IRrh6Mu7t6FOfXxxGZWFs=;
 b=i0M2xc80BIoNnTKNZAzXxCvwTYuN8nPRRUn6yIzvKeC2qmx2YmtBMafDcKSC+VB5LirKk9ukusPMLahayYmuJvUgVAjmMPns41NiD4W5hvGtsFs3BVTc3gpDuREWll/vQKEsbqt4da12NB0nNXigLEi5eo2eD52UmbLkpLuPmKYRNuLs8Cjym24XdUyyb795Ziv+z6XpBsk6W4TSxvLylzBj4wuUi+P553c4aw/7aZuNKYJo84ocGyIVf2q3olRL6UPyHZtaV6O6JgMudx3IKnWFD6uY8rIdQUlJrWN7p9DFu4nDDRGq3BFmWgp4mhP4072Htfw4KMiDzVAcjAY4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jELSDSFlwTrNoZytY04Wd6IRrh6Mu7t6FOfXxxGZWFs=;
 b=k7U/U1YpDQITHbsJWrIHBwFUrOzvhu1HIwisPEsgvfh6O51EdfJTAu56J1BV5OLMkGVJ7LURGTvqSkIV/iwQcE/lGDn536XS3pcDVLWQw4/fB2LK5lKLajKL65Po1U7zbqcHt6Q8W3o6gXn8vqE409yWm+vq3aXfmpM3/S6CdAg=
Received: from SA9PR11CA0011.namprd11.prod.outlook.com (2603:10b6:806:6e::16)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 20:14:01 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::68) by SA9PR11CA0011.outlook.office365.com
 (2603:10b6:806:6e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 20:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 20:14:01 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Oct 2025 13:14:00 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v4 3/6] drm/amdgpu: Introduce SRIOV critical regions v2 during
 VF init
Date: Tue, 14 Oct 2025 15:13:43 -0500
Message-ID: <20251014201346.9422-3-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014201346.9422-1-yunru.pan@amd.com>
References: <20251014201346.9422-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2ab58a-6fe1-4fc0-e25b-08de0b5e372b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7L/TTxiIPF/oR0LxUnPVALvwduSVeUxDAMJDXJxI+HsDr8StMhM9UsG8qnOi?=
 =?us-ascii?Q?vARoB/VMNh1v64mc03y1wqAZsQRyYbSHQsBN+Agtm51Sfza9DrU/pdEHd0ml?=
 =?us-ascii?Q?G14i+6pB/e0g9O7tZ6bweR1KEUjS/Xy8sUCVxQYsbUGNfT6J9pW1BR3AZQPa?=
 =?us-ascii?Q?H67DM7Itd/2mayBtrEUXTHMG3uFmQKo7KKvvEFOR8pHGFfP7Xm6RrR/YGeNI?=
 =?us-ascii?Q?vgstTMrdPAx0pfqCEEhi25ofg3j1toIKWnUbikxKee3TEUIdFiFmZbbkiXZc?=
 =?us-ascii?Q?CKQEO0Hj03jdVXec+Sb53pQSeiVwRycozV+EGlVefAiHVDudHMoICPZgCFIg?=
 =?us-ascii?Q?+Vt1toMwxDP5Ely425ot6AwRJ8PpRJj2sK/dls9jLBCLhFmZ2Wvm+GJbMjqI?=
 =?us-ascii?Q?wjIsgo2UZsYbi2c1dpHAhsEVhipqo0d9CDUGKNQMjp1EsV0kcdHYUHRziYzz?=
 =?us-ascii?Q?p+pSQxoqcuFIQTH2FC3qNC+BSKor4XncO6FHjohgDixV2e9g2CXdYQf4Rgdy?=
 =?us-ascii?Q?2Dzv38ur2Czs2S+/8C5I+wxeV4sBi33MNUm2zOmiLdYhkW4rBwlCodZdB4ii?=
 =?us-ascii?Q?UQJSM0cPhwN5OPC286BYWfrbpUKh1w5DlKKgGtQFdwuDj+PWd41gq/FXa1/N?=
 =?us-ascii?Q?APQBzdPTnoB8h58Oo40c/NqjYZld+ZK1AMqbJb6EeQaYWDQh5Y0ik7z65eFa?=
 =?us-ascii?Q?85pK1bBL/tUpoRoGIshChmSKBgiyWfNktYh6Bv3wIDGC7C8vFvUTZlm+UlE8?=
 =?us-ascii?Q?bTsaEhOENNr+4uVKuvixX5Yo15fqgIWHo99y2Z83/TteLpye8nRLXkdf/tbG?=
 =?us-ascii?Q?kd5imok/sqJSu6Sx/AFEWAf/3KeRkrXyZoMZXbVxdzHyTBlo5uT/XnlpQOq6?=
 =?us-ascii?Q?OYrJ9IqL9B9gaZKTHNJTY3r4CP3LDA0xHSm2KPcI81OUiLh1uSeDwXA040H6?=
 =?us-ascii?Q?MME+0DU144cxtZnCge5iKFDB47QZVA7h+Nfv2EdMaNweijRCdTiv98NU4iNz?=
 =?us-ascii?Q?l00ERHUmhAvtTEx/pu+dz+XLdJAytF9vqTqvhXOetxyBkY+wqCeok7LEPK1v?=
 =?us-ascii?Q?CXC3S+O2t9dCkU/J870nhxmqkBK59qYfwpfWDWwMuP8ftXBm+ZMCHQXxlwfd?=
 =?us-ascii?Q?7mrXKQEbKpnxNPcQ1pRuafR82Y5l3tt35nBrl0z6S2StumDBOfnSbjTMEwdx?=
 =?us-ascii?Q?11zd0FmE8RSCHx6+AuGpHIrtZRIqHWRnYv0VJzp3FQxWIyLVuYt03Qgbb0eH?=
 =?us-ascii?Q?kVGJkZ4CGi3Sv+wUBLHzT+l/s/hBqGy2tzIIcKinbYsp5VzpZbm6zp9w+4UG?=
 =?us-ascii?Q?Q3nEJQn06WgA0qrjvCLwyDNjI3xKhsCjOQ5av8CjEkPosSYcq2vdjq3/SNKP?=
 =?us-ascii?Q?QcBa1pZuSQPc7B/ZNh5Qh9w6lI9dDxJshApMQghl9m2F9AgZ8+oLreF3nOYa?=
 =?us-ascii?Q?1oQR6uJy6ofyIb3tkk32g7fdFFU5mLyhDaF3UhiE89Jr37JHNacDMUgX31M1?=
 =?us-ascii?Q?JYtrBw4bzlfOU3/sTl+rmX0A4wUrxOeXCtpHppzcQeQTv816Fuyt43N6ISGI?=
 =?us-ascii?Q?xOoWTcvkshR5SM79pOI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:14:01.2988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2ab58a-6fe1-4fc0-e25b-08de0b5e372b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 106 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++++
 4 files changed, 150 insertions(+)

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
index 39ab7d00379b..27235f3f3b81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -44,6 +44,8 @@
 		vf2pf_info->ucode_info[ucode].version = ver; \
 	} while (0)
 
+#define mmRCC_CONFIG_MEMSIZE    0xde3
+
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
 	/* By now all MMIO pages except mailbox are blocked */
@@ -843,6 +845,110 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
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
+	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
+					sizeof(struct amd_sriov_msg_init_data_header), false);
+
+	if (strncmp(init_data_hdr->signature,
+				AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
+				AMDGPU_SRIOV_CRIT_DATA_SIG_LEN) != 0) {
+		dev_err(adev->dev, "Invalid init data signature: %.4s\n",
+			init_data_hdr->signature);
+		r = -EINVAL;
+		goto out;
+	}
+
+	checksum = amdgpu_virt_crit_region_calc_checksum(
+			(uint8_t *)&init_data_hdr->initdata_offset,
+			(uint8_t *)init_data_hdr +
+			sizeof(struct amd_sriov_msg_init_data_header));
+	if (checksum != init_data_hdr->checksum) {
+		dev_err(adev->dev, "Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
+				checksum, init_data_hdr->checksum);
+		r = -EINVAL;
+		goto out;
+	}
+
+	/* Initialize critical region offsets */
+	adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
+		init_data_hdr->ip_discovery_offset;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
+		init_data_hdr->vbios_img_offset;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
+		init_data_hdr->ras_tele_info_offset;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
+		init_data_hdr->dataexchange_offset;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
+		init_data_hdr->bad_page_info_offset;
+
+	/* Initialize critical region sizes */
+	adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
+		init_data_hdr->ip_discovery_size_in_kb;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
+		init_data_hdr->vbios_img_size_in_kb;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
+		init_data_hdr->ras_tele_info_size_in_kb;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
+		init_data_hdr->dataexchange_size_in_kb;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
+		init_data_hdr->bad_page_size_in_kb;
+
+	adev->virt.is_dynamic_crit_regn_enabled = true;
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
index 36247a160aa6..5c1dce9731e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -54,6 +54,10 @@
 
 #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
 
+/* Signature used to validate the SR-IOV dynamic critical region init data header ("INDA") */
+#define AMDGPU_SRIOV_CRIT_DATA_SIGNATURE "INDA"
+#define AMDGPU_SRIOV_CRIT_DATA_SIG_LEN   4
+
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
 	SRIOV_VF_MODE_ONE_VF,
@@ -296,6 +300,9 @@ struct amdgpu_virt {
 
 	/* dynamic(v2) critical regions */
 	struct amdgpu_virt_region init_data_header;
+	struct amdgpu_virt_region crit_regn;
+	struct amdgpu_virt_region crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
+	bool is_dynamic_crit_regn_enabled;
 
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
@@ -432,6 +439,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
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

