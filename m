Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F997606A890
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MsN/GbNi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5BD71126B9;
	Fri, 13 Nov 2026 16:30:56 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D45E1126B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 16:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT2Kb6PmKNzk/uZ5hvL6SDoO3nHyPcr+P7RftFx4fj8B7vn8lE4yn0YhNTIA7h4i88a6U/fkwAq6Tn3VcDHWMihtpMAEme/4HBs+317KqWWM4olA6ESFcpuOKdzyqI/eR01FiJiN5MbsJGQ91Pq9dGdXVMTiLWkfYc48qwy8Ef9I+llnL0SbzOlf0um3vQrUcHRCSGErDYaUkMpob+K9Xgv3Is9OIGG2kJ/BLPegAyRUTGMGt9I6SWAyW+j/dQ3yW7f0N5rXYZBJcCV4jRRUMLH/MnJbYZ83KoXms7hMXK0kt74mJ4eD719lrgJPg2/2ncToUn/KSZ5ut9cVekzF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzW29O5cHPTJKtO3VjITHuD0qGP1u5DFDwEpyr2NqEE=;
 b=k4gbxqHISWC8P8FSKDP1TT/a0hW73ahvTOVDsVijVXMdWR/GBYfr9AtT0tBkApD6cA8OwBcvTJpwx1tXVGp8A/5c5JpCr2laCQ/K41SGg40ObtFxzaM2CuACUUqlOjgKpL9VXSdEc6e+IMQ+LnYYddF3kcHUaLONtxd9VWLC29d31YfBW7ygKKVEZbTi4rhm9vBgH1YSDYo3kluHjCnqWEOVu7jbSPtvCRWJbWlZY4nJBYiRqhl8Y+hI9L1wEm5XZCJe1Ic86ERirZQdFOAHU+T55/4+Ksm4b9F19AP6IvLBP52vScJKluv5jeA32P5fB7yRQQ1CvkZZNaFInbz/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzW29O5cHPTJKtO3VjITHuD0qGP1u5DFDwEpyr2NqEE=;
 b=MsN/GbNilqekVgzFVLER9a/svcFj4lJkoTRHhiSuBPRmpYrukzlrMhR4zXgsi0azK1oh4h7+EdWftu3FRaDDS0RYGlWWhV/J5Hs9CcpjRasUyRzYN40c9WbCjpZgo4tJ+gPESCDxzRYsujviSUMUZZmRAF/IIycRVfX87+Oa6gM=
Received: from MW4PR04CA0297.namprd04.prod.outlook.com (2603:10b6:303:89::32)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 16:15:33 +0000
Received: from MW2PEPF00014673.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::42) by MW4PR04CA0297.outlook.office365.com
 (2603:10b6:303:89::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 16:15:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014673.mail.protection.outlook.com (10.167.249.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 16:15:32 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 10:15:30 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5] drm/amd: Select the firmware signing scheme the PSP reports
Date: Fri, 13 Nov 2026 10:15:21 -0600
Message-ID: <20261113161521.2132645-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014673:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e87971-29c1-44ec-bc5c-08df41a157cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|5023799004|56012099006|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261009223027099003|261102123227099003|261028144727099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: jBz4y1+Xc12OLMOT9rgCgw0VR/MX2RmzROwtRmVj72pSxn81K1M2jZj+ea3FN2ot+WhmC2kd7hRvRer783/E1Ra88fQpi1Syqx4rvYDMLDL4ywK7QQF6PHmCfr4kukZ735KJLODSmDcM16yqpnmOp2aLoKeH/XCYfxeVg9ZgdTwHj6Ea//sotOQgXlUR8I9f3QuTQK2FT33Xvf65x+aKHscIShZbS55ygVdnh7nHOVnxXk/q2HUAX8QG/d8oaYTKm1xVlUAE/sq3CcLViCIjPkNZy378wTWqMQiekWCuZtvEtan9AzGh6+Um+2fWrg1uoJbAqH4njrMTPau3R8yrYrzjZCGg38xCZyTSJ5ptXkmuKXc1fBDbKj0yVIlVhtAPsRvlMVQFIA4ZYGM0FEN4iIA3RFVMP9KiBMTEfzdS7qS5naJpweNVzygvp4e25TqA/6MKNpGFycQ+NvZPLaZFs5cMILozRAdSNgLDDtOTrDsr3sRmWirEWxR9l2xR2g1uuIw2XuklQMqOjH0vgqcvssPEKYPmzesPC8L1xVLjNK/dnfe03ipVaaFHZGSdFwXHReJ00Wh0HD5o7nn2QswXKDWNivEeh7J4sOw3dXDZJsrxedY0TGVZyktd3PvWwYtQNkjnjDpjYCR8CTu4EKch8WNy0aEL2nuNcoOhIQjDFdEEjM75sebMXIAhYEOzekIWze81NxkqXlCqtzFQUSKkAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(5023799004)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261009223027099003)(261102123227099003)(261028144727099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hlp2ZVrjVrOfVL9tob6GzRm7ldFty7z6TSoDWm+K77t3IvQ5gkuNj0NJtckHbU0OHnU5HqXRvTED0SOoOa8iJQSPVm3K0qbbl9UI6EAw7qIaA12SqS6ipzsISFUKecID5njjX6kJOgeWCVUn+/EyiTtP97+CpIa+1ChCivJiaLd6uEOIieqaDKQ8Vsnb0mUxNTz8cyXGDI26LxB68wCzfoWWm0Rtu6eAuQsUMNKugZezPo0+6rZeeQ/LjaVy2mNQE3W3/e8Nn09M3Ga+6HpiQ7ukuX7BFEgCD06CLZ3PWlvqGhyQVYSXIJrF5OFLGo5BJhbuLsx4JQ3ZREuRIVCtPy2l2JhGV5axDh4PjEGxwnu3pHXOl7JiZ24elCbhwywSykitv8SvF3CmsbufjxRVx4w386q7IFrz423SA9wmOmeuWbP8/kjwx2eUeoH1UzCL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:15:32.6691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e87971-29c1-44ec-bc5c-08df41a157cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014673.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some platforms ship BIOS with either a default or an alternative trust
authority, so firmware for every IP must be signed with the matching
scheme.
The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in bit
28 whether this is a preproduction part, which needs firmware of its own.

Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
own MMIO, and keep the result in adev->firmware.sign_type next to
load_type, where preproduction is a type of its own. It is initialized
once, after IP discovery has populated the register bases and only when
firmware is loaded through the front door (the PSP). Only MP0 15.0.0
reports it. For all other ASICs, SR-IOV VFs and an inaccessible register
(all ones) the defaults are kept: AMDGPU_FW_SIGN_DEFAULT. A preproduction
part that also reports the alternative scheme is not expected, so warn
about it and use the default firmware.

Firmware for preproduction parts is named with a "_p" suffix before the
extension and firmware for the alternative scheme with an "_l" suffix
(e.g. "foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on
the default scheme use the plain names. Do the substitution centrally in
amdgpu_ucode_request() so it covers every IP that loads firmware through
it (PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each
loader having to care. There is no fallback to the default file: it would
be rejected anyway. Declare the variants with MODULE_FIRMWARE() so that
initramfs generators include them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add unknown type to enum for unexpected combinations (Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 34 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  9 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 ++++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  8 +++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 49 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
 15 files changed, 158 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c60acca7e5cf8..11b64fff853b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2097,6 +2097,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
 	}
 
+	/* Needs the register bases, and must be known before requesting firmware */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
+		amdgpu_psp_init_fw_variant(adev);
+
 	total = true;
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		ip_block = &adev->ip_blocks[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 548e017311d48..22eb27b4ab5c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -402,6 +402,26 @@ static uint64_t psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
 	return pos;
 }
 
+/*
+ * Which firmware the platform needs, as reported by the PSP in C2PMSG_63: the
+ * signing scheme and whether this is a preproduction part. The defaults are kept if
+ * the ASIC doesn't report it or it can't be read.
+ */
+void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(15, 0, 0):
+	case IP_VERSION(15, 0, 9):
+		psp_v15_0_0_get_fw_variant(adev);
+		break;
+	default:
+		break;
+	}
+}
+
 /*
  * Helper funciton to query psp runtime database entry
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 975d123593588..9b04e51f589ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -631,6 +631,7 @@ int psp_ta_invoke(struct psp_context *psp,
 
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
 bool psp_is_xgmi_ta_supported(struct psp_context *psp);
+void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev);
 int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index d2ce526dd95cc..4d5e31ef8c939 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1527,6 +1527,36 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
 	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
 }
 
+/* Add the suffix of the firmware variant before the extension: foo.bin -> foo_l.bin */
+static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char *fname)
+{
+	const char *suffix;
+	size_t base;
+
+	switch (adev->firmware.sign_type) {
+	case AMDGPU_FW_SIGN_PREPROD:
+		suffix = "_p.bin";
+		break;
+	case AMDGPU_FW_SIGN_ALT:
+		suffix = "_l.bin";
+		break;
+	case AMDGPU_FW_SIGN_UNKNOWN:
+		/* Unexpected bit combination: try the default binary, it may not work */
+	default:
+		/* Default variant: the name is unchanged */
+		return 0;
+	}
+
+	if (!strends(fname, ".bin"))
+		return -EINVAL;
+
+	base = strlen(fname) - strlen(".bin");
+	if (strscpy(fname + base, suffix, AMDGPU_UCODE_NAME_MAX - base) < 0)
+		return -EOVERFLOW;
+
+	return 0;
+}
+
 /*
  * amdgpu_ucode_request - Fetch and validate amdgpu microcode
  *
@@ -1555,6 +1585,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 		return -EOVERFLOW;
 	}
 
+	r = amdgpu_ucode_set_suffix(adev, fname);
+	if (r)
+		return r;
+
 	if (required == AMDGPU_UCODE_REQUIRED)
 		r = request_firmware(fw, fname, adev->dev);
 	else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 7c809692807fc..15e789718dede 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -571,6 +571,14 @@ enum amdgpu_firmware_load_type {
 	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
 };
 
+enum amdgpu_firmware_sign_type {
+	AMDGPU_FW_SIGN_DEFAULT = 0,
+	AMDGPU_FW_SIGN_ALT,
+	AMDGPU_FW_SIGN_PREPROD,
+	/* Unexpected combination of signing bits, default firmware may not work */
+	AMDGPU_FW_SIGN_UNKNOWN,
+};
+
 enum amdgpu_ucode_required {
 	AMDGPU_UCODE_OPTIONAL,
 	AMDGPU_UCODE_REQUIRED,
@@ -606,6 +614,7 @@ struct amdgpu_firmware_info {
 struct amdgpu_firmware {
 	struct amdgpu_firmware_info ucode[AMDGPU_UCODE_ID_MAXIMUM];
 	enum amdgpu_firmware_load_type load_type;
+	enum amdgpu_firmware_sign_type sign_type;
 	struct amdgpu_bo *fw_buf;
 	unsigned int fw_size;
 	unsigned int max_ucodes;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6c12d8aa3c769..1df2725d31e0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -66,6 +66,8 @@
 #define FIRMWARE_VCN5_0_1		"amdgpu/vcn_5_0_1.bin"
 #define FIRMWARE_VCN5_0_2		"amdgpu/vcn_5_0_2.bin"
 #define FIRMWARE_VCN5_3_0		"amdgpu/vcn_5_3_0.bin"
+#define FIRMWARE_VCN5_3_0_ALT		"amdgpu/vcn_5_3_0_l.bin"
+#define FIRMWARE_VCN5_3_0_PREPROD	"amdgpu/vcn_5_3_0_p.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -95,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
 MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
+MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_ALT);
+MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_PREPROD);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5d068a9d9c72c..3d82cfbd14f17 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -134,13 +134,29 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_p.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 09dc01a425d13..a409911939d38 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -44,7 +44,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_p.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 60b27278a598b..30d3d25d59842 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -61,9 +61,17 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1_p.bin");
 
 static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index abaa40b6def90..5dbd74549c833 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -32,11 +32,19 @@
 #include "mp/mp_15_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_l.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_p.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_l.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_p.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_l.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_p.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_l.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_p.bin");
 
 #define regMPASP_PCRU0_MPASP_C2PMSG_64                                         0x4280
 #define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                                2
@@ -108,6 +116,47 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
 	return ret;
 }
 
+/*
+ * C2PMSG_63 bit 6: 0 = default firmware signing, 1 = alternative
+ * C2PMSG_63 bit 28: 0 = production part, 1 = preproduction part
+ */
+#define PSP_V15_0_0_FW_SIGN_ALT		BIT(6)
+#define PSP_V15_0_0_FW_PREPROD		BIT(28)
+
+void psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev)
+{
+	bool alt, preprod;
+	u32 val;
+
+	if (!adev->reg_offset[MP0_HWIP][0])
+		return;
+
+	val = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
+	if (val == 0xffffffff) {
+		drm_warn(adev_to_drm(adev), "Unable to access regMPASP_SMN_C2PMSG_63\n");
+		return;
+	}
+
+	alt = val & PSP_V15_0_0_FW_SIGN_ALT;
+	preprod = val & PSP_V15_0_0_FW_PREPROD;
+
+	if (alt && preprod) {
+		drm_warn(adev_to_drm(adev),
+			 "Preproduction part with alternative signing is unexpected, signing type unknown\n");
+		adev->firmware.sign_type = AMDGPU_FW_SIGN_UNKNOWN;
+		return;
+	}
+
+	if (preprod)
+		adev->firmware.sign_type = AMDGPU_FW_SIGN_PREPROD;
+	else if (alt)
+		adev->firmware.sign_type = AMDGPU_FW_SIGN_ALT;
+
+	dev_info(adev->dev, "PSP firmware: %s signing, %s part (C2PMSG_63=0x%08x)\n",
+		 alt ? "alternative" : "default",
+		 preprod ? "preproduction" : "production", val);
+}
+
 static int psp_v15_0_0_ring_create(struct psp_context *psp,
 				 enum psp_ring_type ring_type)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
index ebd612103526f..081be8e8268bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
@@ -26,5 +26,6 @@
 #include "amdgpu_psp.h"
 
 void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
+void psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 4845588c4c247..2586d49f1e940 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_1_4_l.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_1_4_p.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
 
 #define SDMA1_REG_OFFSET 0x600
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
index c92c5fc59aeb9..cefb8d739faf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
@@ -31,6 +31,8 @@
 #include "vpe/vpe_2_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
+MODULE_FIRMWARE("amdgpu/vpe_2_0_0_l.bin");
+MODULE_FIRMWARE("amdgpu/vpe_2_0_0_p.bin");
 MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
 
 #define VPE_THREAD1_UCODE_OFFSET	0x8000
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 0ea8f9a582ccc..b28d67b4e70aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -62,6 +62,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
+MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_ALT);
+MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_PREPROD);
 MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
index df3e776c1ad14..219e9c0427441 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
@@ -61,6 +61,8 @@ int dm_init_microcode(struct amdgpu_device *adev);
 #define FIRMWARE_DCN_36_DMUB		"amdgpu/dcn_3_6_dmcub.bin"
 #define FIRMWARE_DCN_401_DMUB		"amdgpu/dcn_4_0_1_dmcub.bin"
 #define FIRMWARE_DCN_42_DMUB		"amdgpu/dcn_4_2_dmcub.bin"
+#define FIRMWARE_DCN_42_DMUB_ALT	"amdgpu/dcn_4_2_dmcub_l.bin"
+#define FIRMWARE_DCN_42_DMUB_PREPROD	"amdgpu/dcn_4_2_dmcub_p.bin"
 #define FIRMWARE_DCN_42B_DMUB		"amdgpu/dcn_4_2_1_dmcub.bin"
 #define FIRMWARE_DCN_60_DMUB		"amdgpu/dcn_6_0_0_dmcub.bin"
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
-- 
2.43.0

