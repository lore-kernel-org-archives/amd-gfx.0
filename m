Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC71D13588
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 03:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E7A10E049;
	Mon, 28 Oct 2024 03:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P/LEVZzU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2099F10E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 03:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0/dQQmUgnvxnOFDkYv8eQfhaYlsRbi5qI/32t8A5rqjFBxJgi8L9AQcD1vxXnYjWLKxABulCUerN16K5YUnGftw8P7TNRcZzHGXgXs5j2xGEZw3Be7EDGhsI03v9MfYHUennWHW7ctbT/RGCNKTiUqRvaceoVqQW66qv7bYaUSzmbODCe89pzYrIJjgWAWRnyXWHGXxX0RDQVyGyE9jK98e5UiYKxgux7Sttlgr5xwQ5B89B95BWf2bTlbcPfgN2YTVHBF2QdLJ/uNsa9xMI7b/BaVHwNbOF+t+Ly6lQmB2bBw22aeR4wYYUV5ZToGzLMad3zbpoJi/5CSLacqNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezGibhqowO5FNlBXZ+5Ox4B1FjVhDkLG96ndme2y6zU=;
 b=Cv6GueC0OWnt+mw7O14g5BB2/J0JUflOnMibOLpe1IegRFiiZqBDRwwX/rOy/f0VE8TZOwB8g2vI9Nct3cfOQtHQOYc77fSALYlBi/bqTfXXVGaET9kS4nI4Nr1UjpY94Otyy0pmcTp1lKjXI26eV1QGada5W2dlLv/fbdXqCWLr7mBPiMnvikitZooFc3iuRPvxUYXjWS2hJEYr5s21AvCCFpkZFh4jEc0+qvOilsGGZF6VbtbJtIX9Q00IzXtax8hC/6X6pdsB2+j7U2KPHT+/dPg5uAUEUiU8yy55ko0t9axS3gxlRR6H+1fe6jpzh9W9XJHydWfDArPsajwWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezGibhqowO5FNlBXZ+5Ox4B1FjVhDkLG96ndme2y6zU=;
 b=P/LEVZzUq7A7nxRdb0BLN80Tyh8I545ayZZFys1UCI79ydvCib3Ad/S2+Rodb97CullpY09V9dXoxVYXfmcxhOXFtoQ55U6lR/Bdv0IcRTqndVxaDQ3hATGeBjH15golzU5h8FqUBxUhtfVsQxRc4XWwpx+Ru9pRr1f8i02YbKk=
Received: from BN1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:408:e2::10)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 03:15:09 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::33) by BN1PR13CA0005.outlook.office365.com
 (2603:10b6:408:e2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Mon, 28 Oct 2024 03:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 03:15:08 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 22:15:06 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <lijo.lazar@amd.com>,
 <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: add generic func to check if ta fw is
 applicable
Date: Mon, 28 Oct 2024 11:14:53 +0800
Message-ID: <20241028031453.1120413-1-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 72999c60-048b-4a78-3f90-08dcf6feba53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kgwf09BfWhtMloSpMSvBWIqhy9CfU/DcocIsf72NXe+bbQxdPPCsdecFK6rW?=
 =?us-ascii?Q?ZuLthgc0Eq9yDYBQ1b4nb9RNbfo0cvj214YwgERO8MeXKpFHtaR3+uX6Q1rw?=
 =?us-ascii?Q?Tj5o2La8WvjiOyTXRt7o6WaP1S/nLh1lCgkmDREbeWCfcFl234fSN1J2CfVC?=
 =?us-ascii?Q?doqWsPwnxEgEvQu2h1ZsEZQcAX7ycsmRudVas0rMmMEvRU9MtNBKL9i+PjXE?=
 =?us-ascii?Q?TXdJXr3U38gLMF0Pc15y8srqcc+dOWVOHykZmZ6xSWrR1QkLc0dLLOiwqmZn?=
 =?us-ascii?Q?AseDUlNUsVPrfAraw1t8dtd3xYul5uieoTTlh4LQBCEb0j2UH8QVKV7S3NvG?=
 =?us-ascii?Q?kK2JVfQ2zANMdovWgKQSqW1qH6BQthXpSQUqc2toPL2qxx8CZBRdAJ4cX4nj?=
 =?us-ascii?Q?WwDnf8Az7619Kn9hUWOBM58Ywdz7aZbDt+sIa5GJIdXnh4NKaVQvgJXzx/Ak?=
 =?us-ascii?Q?PNSTgTVvOZ17iaVdWT4ORHt37nz09/GDvUlZI/2OnveQSk4celEI3geQ41CP?=
 =?us-ascii?Q?M15zPONRjlBocvgTEHpdNHn52ct4sbqIenAF/iBXoGyqwCHjq4UCO/943b68?=
 =?us-ascii?Q?oYc/+5/RahsLpb+FRl9wn2/04P0Nl0gTj9BSql4/q6Sve8mSG72cjqtxoSKj?=
 =?us-ascii?Q?KvkauN8HY1AKnkBgafnGcsOpXTIoSmxvHcvlwUETIFLEbBSFghxAdphZ39+i?=
 =?us-ascii?Q?BBZg0ml3QgquX11EhN/+b8vt5n9Jw424AaBQL7xwCHf0IndSeK2zp+itZRwr?=
 =?us-ascii?Q?/5BO+BgSw9sf/T33aLAq3YLg7R89A26rIs+vxZ5SwCeAHq4mUDhGcqM4uKdz?=
 =?us-ascii?Q?JFEBlLJZmeKpm8vb0QVe++PfGba1l3AOAuw8DfxoxrOjy+269VWX5FHViLzn?=
 =?us-ascii?Q?Urau8gruS5O/drTWZpeaUD+2YGlUihdpfMrUwsTyeDoKmsoPa9hzBIdvHYx9?=
 =?us-ascii?Q?Wx0x1eLZYmFvkEhe+pRbEg0BdCDkieSBFOt5QDvqxD130RUSLYnvbeyAhJ/m?=
 =?us-ascii?Q?J/19aXw26Z/aN4B6+Mt+WnBFPSLU5+8szrH7cmoDTgxdp+BLP/EgC/NUNq9N?=
 =?us-ascii?Q?TKk9fuEMQkQ7d/Hqhz3R7fUwbWngIK6vqrL2k25AIvFSnQBnZtZ3fOZPfiqW?=
 =?us-ascii?Q?yZBCebAA6tyrPDhuZ+AWEN6qsuKbO7BpHNUouigxGizaR2WLfxZcmdAJ7jl2?=
 =?us-ascii?Q?NkGNDut177uyBb3PxuuZ3RvqafdwhnHdGe4Ny4xDmxHa5uyADSANcLqDzHbW?=
 =?us-ascii?Q?8BOb6+x1/GHn2cyoxasNPSSmWVKuKo7oC4WJv2jyohhjIHwjO3NNYE+lTpsm?=
 =?us-ascii?Q?bZ3mRWrIeRZJAw017C6ifESN/Rpb9f7cXm76Qo+0BE7gdIqcgP0I91nqNYWO?=
 =?us-ascii?Q?gUAHAv0RXxnslB1hGDFZfhsSqeEhdLhqt6TKkYCLvtJ4EvtjUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 03:15:08.7130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72999c60-048b-4a78-3f90-08dcf6feba53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

Separated xgmi ta is required for specific APU, and driver needs
parse the ta binary properly with aux xgmi ta packed.

v2: make the check function more generic (Lijo)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 33 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index abd5e980c9c7..92cf412a4c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3563,6 +3563,35 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 	return err;
 }
 
+static bool is_ta_fw_applicable(struct psp_context *psp,
+			     const struct psp_fw_bin_desc *desc)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t fw_version;
+
+	switch (desc->fw_type) {
+	case TA_FW_TYPE_PSP_XGMI:
+	case TA_FW_TYPE_PSP_XGMI_AUX:
+		/* for now, AUX TA only exists on 13.0.6 ta bin,
+		 * from v20.00.0x.14 */
+		if (amdgpu_ip_version(adev, MP0_HWIP, 0) ==
+		    IP_VERSION(13, 0, 6)) {
+			fw_version = le32_to_cpu(desc->fw_version);
+
+			if (adev->flags & AMD_IS_APU &&
+			    (fw_version & 0xff) >= 0x14)
+				return desc->fw_type == TA_FW_TYPE_PSP_XGMI_AUX;
+			else
+				return desc->fw_type == TA_FW_TYPE_PSP_XGMI;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return true;
+}
+
 static int parse_ta_bin_descriptor(struct psp_context *psp,
 				   const struct psp_fw_bin_desc *desc,
 				   const struct ta_firmware_header_v2_0 *ta_hdr)
@@ -3572,6 +3601,9 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 	if (!psp || !desc || !ta_hdr)
 		return -EINVAL;
 
+	if (!is_ta_fw_applicable(psp, desc))
+		return 0;
+
 	ucode_start_addr  = (uint8_t *)ta_hdr +
 			    le32_to_cpu(desc->offset_bytes) +
 			    le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
@@ -3584,6 +3616,7 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 		psp->asd_context.bin_desc.start_addr        = ucode_start_addr;
 		break;
 	case TA_FW_TYPE_PSP_XGMI:
+	case TA_FW_TYPE_PSP_XGMI_AUX:
 		psp->xgmi_context.context.bin_desc.fw_version       = le32_to_cpu(desc->fw_version);
 		psp->xgmi_context.context.bin_desc.size_bytes       = le32_to_cpu(desc->size_bytes);
 		psp->xgmi_context.context.bin_desc.start_addr       = ucode_start_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4e23419b92d4..4150ec0aa10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -163,6 +163,7 @@ enum ta_fw_type {
 	TA_FW_TYPE_PSP_DTM,
 	TA_FW_TYPE_PSP_RAP,
 	TA_FW_TYPE_PSP_SECUREDISPLAY,
+	TA_FW_TYPE_PSP_XGMI_AUX,
 	TA_FW_TYPE_MAX_INDEX,
 };
 
-- 
2.43.2

