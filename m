Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB97C624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6DF10E560;
	Sat,  5 Sep 2026 10:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qo/KZzI2";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A4310E281
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMjHVoHdur8BM0KyIlKsNF5OJiRqiQ2KLQLZhrLr/kggaCI3tPBKjgckCijA1WoJzTH5r6V8od3p+Yau7RNE7TysSYf4PkZ28u8AFJg4pI5FBa5eARtU5G696SqN3vbvzXa/S/n+Z1m0JiR/QMFiwpNbhP1IXk0AwzTev8wJIcwgX2f7CUZFFc4Dg5FWP2spOdim64AumdYJvSgWmTIk6nC9FnYUHpmaGAiTxAek8edB/4lDyAbdH3o+GJp7HOBL8s2lrrUQzcv2GxB8i2vzr7tKtRuy+/+O+WLrTUGp4VAZJ3qLJKvlsOp4yWbtpTx+/cOMejdGT05Z21DIz7xZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw1a//OcMH865r2chbMOkFvuyf+Sj4MSVxYVSDt4I4U=;
 b=hF5O9Sy2VeTOpxsYSUruS+HpXsyhIUK7WO5J3oqxyn5zlNxHX16kJ1jGGnzwdgslx/zCH2TOfZeOSziebn6FNcoHsLjRUWkGzv7Av04/tt8lnFZ49dE6+hHn/bFtgxpoY4hiRUE2+WmLX/JSKwrLjD7VNCg+4NKRyANBPyKG7yTgqcyTB2Cxw8YclX1wvUMSiwb3qclsV58i9e7D5N59rsubmcYJnrfRPz3LJ1/kq/Qo+6ykDAL6nRX72CcvnonByDoLOWfYWIEJdk8QZAFJ7fag5NI2g3ABKLFgWEO/VlOFaan5OeW22footM2RMhvWFpDAv3i7gPK3bHEuBMP2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw1a//OcMH865r2chbMOkFvuyf+Sj4MSVxYVSDt4I4U=;
 b=Qo/KZzI29RtS9k2+cIydEf0DQcFPWpuah3AeUVRpIuSeSG4921jh81i6kCMEvD8tD6UNx6NBMFFuhYnnWgl0cFXuqCGhEkOfazmFTK4EB+CNSbAOjQwCH51FPrjXBqU6h51u30E2INSOSn/tBgaaYR5WLvRqKPIOcyEcj9Ntz4A=
Received: from DS1PR03CA0013.namprd03.prod.outlook.com (2603:10b6:8:450::6) by
 MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 10:06:01 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:450:cafe::d) by DS1PR03CA0013.outlook.office365.com
 (2603:10b6:8:450::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:00 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:05:59 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 01/13] drm/amdgpu: Add common NBIO doorbell entry helpers
Date: Sat, 5 Sep 2026 18:05:26 +0800
Message-ID: <20260905100538.12877-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: a9997f2a-51d7-4c5e-d615-08df0b3549a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jnx5LxuoVnJgFV6IF9p5zI54s/QzHdi02uqzqxYxmulm4tKcwLEbADx5CS0WVNI5hL0L+KvbvC78wmBmp+jh+c9Zqie7yQZ5QhKaHYeqlv2MShnFYr5+rdTS7YFcNhW0VJcvoww/sdz8CKtZaCOUnG3+eZfmSzItLMbvgmxtG6Yn+FGqWyEK8kOu1FwRmmWs4NPYMhcvYCyte4sePbal12IEN87yJwJT2niRODRUWwj+AggsFAJKRwjNINQXS8+od72b6vPHFlM9w6jdaxnpmwYE8MXBcLuwqtmmZuwFhczrq2m/hmyvV2mMmf6Rkd2vLeqGbj2sVyS++f1fKa7KKqZn9UScTA9vEc0AsMmJ5cy0E8zPsYozhr4Tx64acUABrGKtCQqN7RRnTN4GpNEX2Qe7d6pUFNyNsaz/6YsUel/ywhKlufR1P/1fJk4+DwZ/PDnMRoUlJSVG0LHjK0iGKIKGw0P3W9HUnrWc/PjOxazIQxLaQD9x/4a9qFNmcq8O1c+o5d+K088VnkfIBUrdDDsWvk1B3q3lZH3P7rBF2e/aa5RdB0G9L1pIj0rUpM+CG4v3xb34VG/xyNxvJfdrRT0Q2YhyTeVRcexMY1BDnK+Z6XeHDWVDrz2fm1tE0zD0fHHwsJV9Xi7rNOhRLHj0S7314MA/JmhC4QLGpOBkqTozAZRmbYIzaftQChG2i5hjR5ovyocE7Z0zy/6rDodL7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jpqa6VZRpbFhz8m3n7UB7RTycVnUFCEN3dpG+co5BwL4i8w1TQ0rozomuSNkeERpSijgAugtSoE6edAGNJXdJjvi1cP+J/fCXosgViV5s7Bw2zCM8vm88YSsz4Z0itHuz+N8thKolHnVgQ0N8CtiBNcFlpcpp3Bvr1b3FW51XhaeHmHHG4KHutfn1aLumhYhgNYldZl0laOjHvdKfyXHbJvOyMmaumCWN4d/O5cmzil7uZA0ZLTVjMjbDcaEKku5N7CZMNIzeQeBM1Iv0q/qEGsTFdV6nM8lG8vbwXvGLH71H0vJQD7G4zHuj3WONmUgXovg04SEjPpGeUYDc763yGujAnqOyz6f3ZAKWZcHbsBn51HEFhPQTYWRAyeWYWStj9sCcsBNdSxFCk1H3VWSF0JuyZg6U/hW3qgZqSdbt4HGWsuw1v2IK1LOfFMN8iov
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:00.5869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9997f2a-51d7-4c5e-d615-08df0b3549a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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

Add doorbell layout and field descriptions together
with common helpers to build and program nbio
doorbell entries.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 142 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  79 +++++++++++++
 2 files changed, 221 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index e4c8e98725f0..70b63fd3656f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -21,6 +21,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include "soc15_common.h"
 
 int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)
 {
@@ -94,3 +95,144 @@ void amdgpu_nbio_program_aspm(struct amdgpu_device *adev)
 	if (adev->nbio.funcs->program_aspm)
 		adev->nbio.funcs->program_aspm(adev);
 }
+
+static int amdgpu_nbio_set_doorbell_field(u32 *reg, u32 mask, u32 value)
+{
+	u32 shift;
+
+	if (!mask)
+		return value ? -EOPNOTSUPP : 0;
+
+	shift = __ffs(mask);
+	if (value > (mask >> shift))
+		return -ERANGE;
+
+	*reg |= (value << shift) & mask;
+	return 0;
+}
+
+int amdgpu_nbio_build_doorbell_entry(
+	struct amdgpu_device *adev,
+	const struct amdgpu_nbio_doorbell_fields *fields,
+	u32 *ctrl, u32 *ctrl1)
+{
+	const struct amdgpu_nbio_doorbell_layout *layout;
+	int r;
+
+	if (!fields || !ctrl)
+		return -EINVAL;
+
+	layout = adev->nbio.doorbell_layout;
+	if (!layout)
+		return -EINVAL;
+
+	*ctrl = 0;
+	if (ctrl1)
+		*ctrl1 = 0;
+
+	r = amdgpu_nbio_set_doorbell_field(ctrl, layout->ctrl.enable,
+					   fields->enable);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl, layout->ctrl.awid,
+					   fields->awid);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl, layout->ctrl.fence_enable,
+					   fields->fence_enable);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl, layout->ctrl.range_offset,
+					   fields->range_offset);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl, layout->ctrl.range_size,
+					   fields->range_size);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl, layout->ctrl.disable_64bit,
+					   fields->disable_64bit);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl,
+					   layout->ctrl.deduct_range_offset,
+					   fields->deduct_range_offset);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl, layout->ctrl.drop,
+					   fields->drop);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl, layout->ctrl.awaddr_31_28,
+					   fields->awaddr_31_28);
+	if (r)
+		return r;
+
+	if (!ctrl1)
+		return 0;
+	if (!layout->has_ctrl1)
+		return -EOPNOTSUPP;
+
+	r = amdgpu_nbio_set_doorbell_field(ctrl1,
+					   layout->ctrl1.target_port_type,
+					   fields->target_port_type);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl1,
+					   layout->ctrl1.target_die_id,
+					   fields->target_die_id);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl1,
+					   layout->ctrl1.target_port_id,
+					   fields->target_port_id);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl1,
+					   layout->ctrl1.override_poison_data,
+					   fields->override_poison_data);
+	if (r)
+		return r;
+	r = amdgpu_nbio_set_doorbell_field(ctrl1,
+					   layout->ctrl1.disable_4k_page_decode,
+					   fields->disable_4k_page_decode);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+void amdgpu_nbio_program_doorbell_entry(
+	struct amdgpu_device *adev,
+	enum amdgpu_nbio_doorbell_client client,
+	u32 instance, const u32 *ctrl, const u32 *ctrl1)
+{
+	struct amdgpu_nbio_doorbell_entries *entries;
+	struct amdgpu_nbio_doorbell_entry *entry;
+
+	if (WARN_ON_ONCE(client >= AMDGPU_NBIO_DOORBELL_CLIENT_COUNT))
+		return;
+
+	entries = &adev->nbio.doorbell_entries[client];
+	if (WARN_ON_ONCE(instance >= entries->num_entries))
+		return;
+
+	entry = &entries->entry[instance];
+	if (WARN_ON_ONCE(!entry->ctrl_reg))
+		return;
+
+	/* A NULL CTRL disables and clears the entry. */
+	if (!ctrl) {
+		WREG32_SOC15_IP(NBIO, entry->ctrl_reg, 0);
+		if (entry->ctrl1_reg)
+			WREG32_SOC15_IP(NBIO, entry->ctrl1_reg, 0);
+		return;
+	}
+
+	if (WARN_ON_ONCE(ctrl1 && !entry->ctrl1_reg))
+		return;
+
+	WREG32_SOC15_IP(NBIO, entry->ctrl_reg, *ctrl);
+	if (ctrl1)
+		WREG32_SOC15_IP(NBIO, entry->ctrl1_reg, *ctrl1);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index a61f3a6e8ec7..2ac392934169 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -55,6 +55,73 @@ struct amdgpu_nbio_ras {
 	int (*init_ras_err_event_athub_interrupt)(struct amdgpu_device *adev);
 };
 
+enum amdgpu_nbio_doorbell_client {
+	AMDGPU_NBIO_DOORBELL_CLIENT_CP,
+	AMDGPU_NBIO_DOORBELL_CLIENT_IH,
+	AMDGPU_NBIO_DOORBELL_CLIENT_SDMA,
+	AMDGPU_NBIO_DOORBELL_CLIENT_RLC,
+	AMDGPU_NBIO_DOORBELL_CLIENT_VCN,
+	AMDGPU_NBIO_DOORBELL_CLIENT_VPE,
+	AMDGPU_NBIO_DOORBELL_CLIENT_COUNT,
+};
+
+struct amdgpu_nbio_doorbell_ctrl_layout {
+	u32 enable;
+	u32 awid;
+	u32 fence_enable;
+	u32 range_offset;
+	u32 range_size;
+	u32 disable_64bit;
+	u32 deduct_range_offset;
+	u32 drop;
+	u32 awaddr_31_28;
+};
+
+struct amdgpu_nbio_doorbell_ctrl1_layout {
+	u32 target_port_type;
+	u32 target_die_id;
+	u32 target_port_id;
+	u32 override_poison_data;
+	u32 disable_4k_page_decode;
+};
+
+struct amdgpu_nbio_doorbell_layout {
+	struct amdgpu_nbio_doorbell_ctrl_layout ctrl;
+	struct amdgpu_nbio_doorbell_ctrl1_layout ctrl1;
+	bool has_ctrl1;
+};
+
+struct amdgpu_nbio_doorbell_fields {
+	bool enable;
+	u32 awid;
+	u32 range_offset;
+	u32 range_size;
+	u32 awaddr_31_28;
+	u32 target_port_type;
+	u32 target_die_id;
+	u32 target_port_id;
+	bool fence_enable;
+	bool disable_64bit;
+	bool deduct_range_offset;
+	bool drop;
+	bool override_poison_data;
+	bool disable_4k_page_decode;
+};
+
+#define AMDGPU_NBIO_MAX_DOORBELL_INSTANCES 16
+
+struct amdgpu_nbio_doorbell_entry {
+	u32 port;
+	u32 ctrl_reg;
+	u32 ctrl1_reg;
+};
+
+struct amdgpu_nbio_doorbell_entries {
+	u32 num_entries;
+	struct amdgpu_nbio_doorbell_entry
+		entry[AMDGPU_NBIO_MAX_DOORBELL_INSTANCES];
+};
+
 struct amdgpu_nbio_funcs {
 	const struct nbio_hdp_flush_reg *hdp_flush_reg;
 	u32 (*get_hdp_flush_req_offset)(struct amdgpu_device *adev);
@@ -113,6 +180,9 @@ struct amdgpu_nbio {
 	struct ras_common_if *ras_if;
 	const struct amdgpu_nbio_funcs *funcs;
 	struct amdgpu_nbio_ras  *ras;
+	const struct amdgpu_nbio_doorbell_layout *doorbell_layout;
+	struct amdgpu_nbio_doorbell_entries
+		doorbell_entries[AMDGPU_NBIO_DOORBELL_CLIENT_COUNT];
 };
 
 int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
@@ -123,4 +193,13 @@ bool amdgpu_nbio_is_replay_cnt_supported(struct amdgpu_device *adev);
 
 void amdgpu_nbio_program_aspm(struct amdgpu_device *adev);
 
+int amdgpu_nbio_build_doorbell_entry(
+	struct amdgpu_device *adev,
+	const struct amdgpu_nbio_doorbell_fields *fields,
+	u32 *ctrl, u32 *ctrl1);
+void amdgpu_nbio_program_doorbell_entry(
+	struct amdgpu_device *adev,
+	enum amdgpu_nbio_doorbell_client client,
+	u32 instance, const u32 *ctrl, const u32 *ctrl1);
+
 #endif
-- 
2.17.1

