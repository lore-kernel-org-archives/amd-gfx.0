Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6710ECCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 18:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070C210EC77;
	Fri, 10 Oct 2025 18:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TErhBe/n";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465A810EC77
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 18:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mxsi4PUynRws3WHfFONCJjrwlKPNFletwCSpntCh3G2OB1XkYjK70ObADMc9R9NbLjzIowuHkjMtbj5LPZr2fDzD+4ocLa6gDkGMBftXiGuC8yx2QQ5uUDZz623OZ0zaB9t++JgQD7v6D/yYIw0zEgN11BI0QEQLgAKtPM/hwYvtlvk8hr+5L88ouwFskYVLXfJaMxe+wj3zp8GX0qN5WGhgY6Gp1Xsy61aj8QNYeAsSAgGKFjHuT/RwoLwi0V0x4+B175WoLbSmCW+LsNJSiPkThNvMZcgAR3ft6Wsqf+0yhsTQyNiaukGx+vtevwxCsQDc7xynL+mBIcRPoQK6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmAaMpFWH0NO3c/tV/6W95616BaZyu7g02d0UGqxCRw=;
 b=OY3kezek14raySPzJHkAD3amm81m7dRPSmB+1y6aGfy5TBsyWliXHIDcW78LUIQoEauPxq8gL2FcUMvkDB4PMQ4rGvAUKTmV2G/8TjaRAs7lmSgH/nmawgPnlpPvsqVQFvDpzNeWHG7Ck3t3L4iLtp7qmeifXUS/bgCKKbzRctCqEfgxkzRjjVfE2e57DFxQqbI9JJ/XFKfLJPDBxF6Q0iZUSsQvvv0MAsBf1plL30v0a79REOoJw8CgOQWEEetcHV5kjywFOW2Ppg1POBcgaE5TMXYcqYfw2j9yYYZyPVSie4sihtl7D337DPJBNNDsfgjfjKYkeutE83YXQC+Gmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmAaMpFWH0NO3c/tV/6W95616BaZyu7g02d0UGqxCRw=;
 b=TErhBe/nq4Xph3IrLfb5xvAiIFnGMep0SgnUd/CsAapjwS+koHpEvhPNxb6NAJzXw1iwErIyBLCxzyzgTpgDG2+ADMq7BbwZsY7MbbBmlPTsuwO/GBbfsUuaAtVnF/R/Ewli5uCQnsDzzWAw9BH/t1nh20AIT7dHgzJ+eZ0rIBE=
Received: from CH0PR04CA0088.namprd04.prod.outlook.com (2603:10b6:610:74::33)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 18:49:05 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::67) by CH0PR04CA0088.outlook.office365.com
 (2603:10b6:610:74::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 18:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 18:49:04 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 11:49:02 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v3 3/6] drm/amdgpu: Introduce SRIOV critical regions v2 during
 VF init
Date: Fri, 10 Oct 2025 13:48:46 -0500
Message-ID: <20251010184849.9701-3-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010184849.9701-1-yunru.pan@amd.com>
References: <20251010184849.9701-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dc9be6-0016-45e4-a913-08de082dafd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hTklwF2kQvtfhOW3NdjVjTVIxsgBcB0yWcY5NNNCfSi0RiALRQUEylr5AMWd?=
 =?us-ascii?Q?v+wKrfDWU/FU4yLeiVEqsZ52QLqW0/LkBuu5F4xkt2XIBrTPvlW+Gh0TiFPR?=
 =?us-ascii?Q?a0Iunh6gWH8zagI+abbtFp0BWXfqKXDRf9QjnqLMICAOcqmsKvuSp3jbNIZE?=
 =?us-ascii?Q?2NGVxur9s4OkITVPlb2Y9pf0HWH8p03738vKTpX4QZmBeKX5kqFG8zRI4han?=
 =?us-ascii?Q?EYV7L1+crpWHWYs2SZtDd0ZUl6j8jaamg7G5C2c7Wxx/8MSsvNv82e5Jqbb2?=
 =?us-ascii?Q?WUbJfT52bw+rev85E+o6JT9x4ZPsonVsiAVUBquwedEdaT0xDhEmQoysj+xV?=
 =?us-ascii?Q?Msj9w5Ap/o+HkDHskx/xGqTCTjJ+uYFda/vImpbhgCWDgfONDb7IeN79sN9G?=
 =?us-ascii?Q?t9f1MPimvVxugJtZhZp9QfjOEiKNvZ0Tqud0ZppabBWKvTKb4dIGXvB5s0r3?=
 =?us-ascii?Q?HHgwvFvTkfsw9hLGCSMbjOml8EkHyC/iJMSbmYCgbtBk3KjqR6YhFf8QJMr0?=
 =?us-ascii?Q?cNl8sqA84OF8M9luxgxkpAE4x8PZFK5a9rCU5fvIvScS3MAAgE4Amt2NBCNX?=
 =?us-ascii?Q?lfYGQZKxOMrp/EfWt5yq09EEEswy0RoqvfXYIKSrCoPJBwCt3q8UJ1paGP9y?=
 =?us-ascii?Q?VmVLEmw+Ywj0aXre5RS7kGlt1Fr7qF9Yb5CBQwq/143539/U0+nKq4xvV6pE?=
 =?us-ascii?Q?w8HcKhIcIbwgRiYPxDbbRqhTymwE3Qq+JFbDg5Yc069aWPN21h19DZwRGBWw?=
 =?us-ascii?Q?/0xDqleLCTn995ms9MDbOWZmTALJpTzdeI4hoLsI+FQGOYd6auqxipvPbVMR?=
 =?us-ascii?Q?AfJoBZKU+Ah5KBJlJ+XNCdfw6NJh9cZnenvJhKkbq5fVQ50aJV8UnbuhCtzT?=
 =?us-ascii?Q?VfiaWk2TRtn5KZ1FZEO156CofO8ukU8HkFWYeLFEca1/OV/XxqRRAILo32kV?=
 =?us-ascii?Q?AyRAvjoQzDnS0T2dasfVP7XCFfG2zxSUz6b7FPimeBJ/BwUYlC+UudIAp52Y?=
 =?us-ascii?Q?+EyZghxilhGxIwghMGo91glMj6lJgj19MP5s2O5nkki8827cwQ/H+2bP9Oma?=
 =?us-ascii?Q?XKezXMWuOlaCSVJWkRyHCZfvDqiDO8PLc6KH1t6zpdDm/hiPGEOq5e+nX+OS?=
 =?us-ascii?Q?3ODgPPRMYgKifcDmiV/0x38HTSnj+NX2gXig64TQ+F7z4OgEE3+T3C4ATe3W?=
 =?us-ascii?Q?DQ3p1fw8ntb7/xn3wKSFBfA/SAfndr3ak3TIee6qYCenpuTWZ2qcqE6xNarB?=
 =?us-ascii?Q?ipEkPagwtgpsj/LPUfGS1BWQDcR9GDkXps/vfT2z18Yf+zcBHJEQ7KPBPg/s?=
 =?us-ascii?Q?/PcdH4MWC97fLJfpA9X5lwzJvKG0rvg4wYladzRtjrpyKXRQQEbYwO4gZd8R?=
 =?us-ascii?Q?obsQWD9WiVieWoUjwh5oSa1xmbGqGa0PoQsI2zGpm2EwhgCjjy0fcsbH1Tda?=
 =?us-ascii?Q?meKhOOSWgAtaGMWCiRV+gZkmDPPdpUnVx8f4CDVKINpveya7Ljm20TgHwD4Z?=
 =?us-ascii?Q?bdAVmIzSI/n5aJ6vR/9cFy2xZ5L95y4oMN88e7Id8GUrUlMZuPMY5XW6t3KU?=
 =?us-ascii?Q?SWS77dMcZ4Wj6a/k2DM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:49:04.9401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dc9be6-0016-45e4-a913-08de082dafd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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
index 36247a160aa6..f46edc03f57f 100644
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

