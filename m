Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DC3EEB583
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 10:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2685210EB3D;
	Thu, 12 Sep 2024 10:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z8M2wuRw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEBD210EB3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 10:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXQCcziEknAcdRIeB80WlrE4qhX1sMe6t06EKxcOZYUN/h+Xqx/07Ze1inXvg5wzfgiwE1JD+lsNUx32i3RYudxTT/XoS3Yz1pbpFAAg/8LiTRR6pmGWRmxUVTsCbqoEwYeIeSiPnZ11V24cMdCYFHsbKY4XxL+P47BQuCpl2aZziW2lqD8GeIx5rXYO3z5VemS/i1qA/YoYHoJ9GwOQoHDUDFJpEJI+Xm69HymVPNpdhD9+oqxsja2Lx3Hylbs6fhH0Ul716N5sdzxZn2Yyx0ldYc92xHFIzMUAMvUzebRlw6IorZ7mkii+3iwnCtEuFxvkyhH+DnpP2Sw826Ee2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWgIPVcQ+9wzF1QdUodXzCzpt6IcAExla62PgP28m/s=;
 b=p6Qgq+4KVgNxOqyHeyMxwITv1wMbYi/62ZzqtGGiMVZ4e8F8R7RxPI16gVwNyCg6wU4iK7WvL0xQLILrqP28Rw+RJlvWxIiB7KlGHgYWGpj4atBLLisNTvXlzdLBfMJaAdQVUlV6dcDEHZI1cS1ELFXsNxI38nbUUIA6mqmFemtdpiy/OLjWNRjIdxNqO0CCbLq6N00DITsDbl1a5nbCGAtTFnnsQ4p6MhUiqNB/D8rIsnj5UwM/8nWhN5AFyeEKoUTuIva79UDqLrgCYLZiZwrc5NJ87Au7QI9a8I3wb2G6QRSLV7ojPJ8WdtWJS16len0jUNFvEVi0UkKYpGYhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWgIPVcQ+9wzF1QdUodXzCzpt6IcAExla62PgP28m/s=;
 b=Z8M2wuRwFI6QmTbUrw/6RaWKo82gHK7AfvG8Dum/qe0spnG1GCHHqdexZA5ZE3SXw+m1bUO3eJuBzsS6jDGblzTsZZAxCPcyX24mmYcVHE1iOQ6pzRunEeLuTs+S7Xx/XcRYoWG/LrkporD1v6/I5i49EvR4YF2mDXnhUQt2yLI=
Received: from CH0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:610:e4::33)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 10:02:07 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:e4:cafe::aa) by CH0PR03CA0208.outlook.office365.com
 (2603:10b6:610:e4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 10:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Thu, 12 Sep 2024 10:02:07 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 05:02:05 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, Le Ma
 <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: load sos binary properly on the basis of pmfw
 version
Date: Thu, 12 Sep 2024 18:01:42 +0800
Message-ID: <20240912100142.599746-2-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240912100142.599746-1-le.ma@amd.com>
References: <20240912100142.599746-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 848e380d-a2b2-4e2f-e810-08dcd311f5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aRZBDxzyqk9bvTsYD4pIvbQlepIxlvS4zqvhV9XfqAYtjX+mmibbRoQO53xO?=
 =?us-ascii?Q?5cH/So0EhY2TuN6PvKQXcot/NrRLmwjP2DkghDPM91C71ZmzxUoFSBSpF9dX?=
 =?us-ascii?Q?BIZtAjmT4EvNrqC0+7F5cgYUWX6qhtUN2VZ3gLXNDDu4DmZsY4odN7o9woER?=
 =?us-ascii?Q?baa5eFEi5EIOLODSvwze66PnvhtQN9fcUpOgTvXQ5p2sHBPFrjEKu/a+xAnH?=
 =?us-ascii?Q?8B4Hus1lJeA9Zm7QKOdjfDWl5dxt3QEZqVTi4V2sIjpv09nYX6QgK7r/p+gJ?=
 =?us-ascii?Q?8ymJXSUS7jk/+fyZihL/f1RBWDwX8QrN6FelJ5UnUnS6LlaYK8DQOB6TWRIu?=
 =?us-ascii?Q?QHAS03uHvhWahImAdjQ4lSF9OlpJhXGiNnvBG5opFdyKRiwxx7ufRL8ZkgfK?=
 =?us-ascii?Q?QHUQxg4ptMFFo61td+7iqz7Ipk6PpJ5kmdyxpxUMyhkzwI4t1OzsghjMEwzP?=
 =?us-ascii?Q?o2p2uKKQDAXpO+1bd06XBHFAuZ8NIzcSBRUaCYmnLb/RoA4cPJpFUi9ISLyu?=
 =?us-ascii?Q?XzCms+xRlnNmLVtZVGegVs9sKiTJv2YUVLw7RkMx8ifQcVpC9dwNvLcMDQUV?=
 =?us-ascii?Q?IJbduBLO9rdZ8JooJDk35r2booX3ZXZ8kTUbbXTUp3lGidI6s1lHGpHWp7Mk?=
 =?us-ascii?Q?8UDF4sESXisMIZL/lMlZ8E2HPdDNONvUdXHlLuuKHsbUjDji2li5fWQmf3Nq?=
 =?us-ascii?Q?rtOyvQLn2uQOYXMHEGbtKK5oDPhekBwOORj7W5K3eVNZl1mdvyxq9Gn+d2S5?=
 =?us-ascii?Q?XW6O+KkRKRRwYcStJIMuiVNeqaMQ2bojo3eJYcVVeijib0OuJsp/h/f4Oo1L?=
 =?us-ascii?Q?ONNTzv7Gzvr0fY4YAyBxwHaLEaOPBC0vc6OkPFk/srgpY6T3zChUp79HFkCs?=
 =?us-ascii?Q?0+HC/EdVFTm+zyULC9a6lMBAdgnrY4OUgobne2dooseSr4k3z8xpyQEIYkbX?=
 =?us-ascii?Q?yMocFcfdDWQg4wS75ti5KWfdIViv/atmroXzZfxzivt/nyhq1QQMeZL3fVFa?=
 =?us-ascii?Q?VRPp1C+JuoADM4BSou1lyBBm83+JMyFhlsc5/1hqkVbxMNF/iOthSeHwRTlz?=
 =?us-ascii?Q?88hKKZ5RwPTGBeRM3r6XYvMMHZGcIHu56BSdyXpVu+eBbTZBOcdx/Eg5Jx65?=
 =?us-ascii?Q?enWuoxw5A5AWVyAO3JW8tpdqXoCbJ03jkerc2TtcWxze4ZGCYvOPo7Qv1Dth?=
 =?us-ascii?Q?jeGTqwu1391+/VJzbmCUKfRccCZiPho+xWnJl+O09jKhUkPFjs6Ct41l2+xz?=
 =?us-ascii?Q?0rjR0trSPPo6wRAmnDtJeEz6wdQ3AuXGDRxeKkrmbCQdzYnFQyYU7zlGdDc1?=
 =?us-ascii?Q?KzC39mbd2jGUjuRhzlA7VJ/PM8lr5d6JR0vhEz1j4rBxpyqrzKi7NyRuZ3ZZ?=
 =?us-ascii?Q?nldZ9ZmwsViGl0jBju7wQT471vphwVoCxAUdL3Db4kU3JOzpew=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 10:02:07.2416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848e380d-a2b2-4e2f-e810-08dcd311f5e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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

To be compatible with legacy IFWI, driver needs to carry legacy tOS and
query pmfw version to load them accordingly.

Add psp_firmware_header_v2_1 to handle the combined sos binary.

Double the sos count limit for the case of aux sos fw packed.

v2: pass the correct fw_bin_desc to parse_sos_bin_descriptor

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 29 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 11 ++++++++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 189574d53ebd..f702f3391c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3425,9 +3425,11 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
 	const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
 	const struct psp_firmware_header_v2_0 *sos_hdr_v2_0;
-	int err = 0;
+	const struct psp_firmware_header_v2_1 *sos_hdr_v2_1;
+	int fw_index, fw_bin_count, start_index = 0;
+	const struct psp_fw_bin_desc *fw_bin;
 	uint8_t *ucode_array_start_addr;
-	int fw_index = 0;
+	int err = 0;
 
 	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos.bin", chip_name);
 	if (err)
@@ -3478,15 +3480,30 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 	case 2:
 		sos_hdr_v2_0 = (const struct psp_firmware_header_v2_0 *)adev->psp.sos_fw->data;
 
-		if (le32_to_cpu(sos_hdr_v2_0->psp_fw_bin_count) >= UCODE_MAX_PSP_PACKAGING) {
+		fw_bin_count = le32_to_cpu(sos_hdr_v2_0->psp_fw_bin_count);
+
+		if (fw_bin_count >= UCODE_MAX_PSP_PACKAGING) {
 			dev_err(adev->dev, "packed SOS count exceeds maximum limit\n");
 			err = -EINVAL;
 			goto out;
 		}
 
-		for (fw_index = 0; fw_index < le32_to_cpu(sos_hdr_v2_0->psp_fw_bin_count); fw_index++) {
-			err = parse_sos_bin_descriptor(psp,
-						       &sos_hdr_v2_0->psp_fw_bin[fw_index],
+		if (sos_hdr_v2_0->header.header_version_minor == 1) {
+			sos_hdr_v2_1 = (const struct psp_firmware_header_v2_1 *)adev->psp.sos_fw->data;
+
+			fw_bin = sos_hdr_v2_1->psp_fw_bin;
+
+			if (psp_is_aux_sos_load_required(psp))
+				start_index = le32_to_cpu(sos_hdr_v2_1->psp_aux_fw_bin_index);
+			else
+				fw_bin_count -= le32_to_cpu(sos_hdr_v2_1->psp_aux_fw_bin_index);
+
+		} else {
+			fw_bin = sos_hdr_v2_0->psp_fw_bin;
+		}
+
+		for (fw_index = start_index; fw_index < fw_bin_count; fw_index++) {
+			err = parse_sos_bin_descriptor(psp, fw_bin + fw_index,
 						       sos_hdr_v2_0);
 			if (err)
 				goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 5bc37acd3981..36b14c1b94b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -136,6 +136,14 @@ struct psp_firmware_header_v2_0 {
 	struct psp_fw_bin_desc psp_fw_bin[];
 };
 
+/* version_major=2, version_minor=1 */
+struct psp_firmware_header_v2_1 {
+	struct common_firmware_header header;
+	uint32_t psp_fw_bin_count;
+	uint32_t psp_aux_fw_bin_index;
+	struct psp_fw_bin_desc psp_fw_bin[];
+};
+
 /* version_major=1, version_minor=0 */
 struct ta_firmware_header_v1_0 {
 	struct common_firmware_header header;
@@ -426,6 +434,7 @@ union amdgpu_firmware_header {
 	struct psp_firmware_header_v1_1 psp_v1_1;
 	struct psp_firmware_header_v1_3 psp_v1_3;
 	struct psp_firmware_header_v2_0 psp_v2_0;
+	struct psp_firmware_header_v2_0 psp_v2_1;
 	struct ta_firmware_header_v1_0 ta;
 	struct ta_firmware_header_v2_0 ta_v2_0;
 	struct gfx_firmware_header_v1_0 gfx;
@@ -447,7 +456,7 @@ union amdgpu_firmware_header {
 	uint8_t raw[0x100];
 };
 
-#define UCODE_MAX_PSP_PACKAGING ((sizeof(union amdgpu_firmware_header) - sizeof(struct common_firmware_header) - 4) / sizeof(struct psp_fw_bin_desc))
+#define UCODE_MAX_PSP_PACKAGING ((sizeof(union amdgpu_firmware_header) - sizeof(struct common_firmware_header) - 4) / sizeof(struct psp_fw_bin_desc)) * 2
 
 /*
  * fw loading support
-- 
2.43.2

