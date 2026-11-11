Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C10606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iFnkmcWe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07C210FDA9;
	Wed, 11 Nov 2026 20:09:56 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B30F310FDA9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 20:09:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G70hXhvUoPhaUivYgqM7HDWrH3bOpSgZkejy5jteICA6m2j9PynVw5ho9p4yjUYwTxhiq5GU23n7oyLX0upnDjJhCegcIoSxe0Cs21wbXEXVN0fWPBy1C0F3i29iSMGDqaXW/7hTCpj+a8Wu13u4IIXHG+awCtYW9eademueo73JMLuvx5xqWC8vB6QU+n0Y6RKFbRiv+WOsp71Wiud9A62XkS2YICmPvvH5MgNT25RvK/OnjYnwaXDtRPHxrLOmPCf81yclk9yCfD36dw6nslyp6kRovl6EADbZ2d5e/LH7Yoar7xLbYTPP8vllybvgHgRSVPfzoPPurWmPiJ40Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92C7pWwIiMpXtfcEwz/41T7pHrFZAeKeQ2ggnMyeZ8Q=;
 b=S6UeaQGADvC2H4g8uFS9LDxPo+HLOnHXZF0cKY+R38XuNP5SgLCD1nofvt4Lqd1QZb9FbuFb2E5gDn99Mk68QA7PXPnZu9A26wuW/rFWOmHdlAksgtm2140NqCZNnbhL+uWEbn3Vmd6Xt4vQ7uiypsJoddK8F0hHfSGfgBM+ckIemjsjJ2rt7kxmRM6wAM/SwsPG1C4YtwC+KLNvUIv0wXmqemTPaM69hWX+k2XTmvXmTH6R4Luem+QXnGBJTB3fT/n63GYvOy2cMmckCtydgKBpvY4RGJsYNkzvvDsbqDUf9TpntgDwWKVatxI/u8nJJLgSmrURC+h7yCIAne8h8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92C7pWwIiMpXtfcEwz/41T7pHrFZAeKeQ2ggnMyeZ8Q=;
 b=iFnkmcWe5WDDOrIbOsClW8ktK4Vl1QKjh2BEGu7Jw1iW69LE00/C18FwAp4n+YM7oAAlOMdGrQRbHG4u4t+i7hc05JnRx31Pr9COTP1V8aZy2nkzYqLznjPJfVmyd6+VYFgXIJUgJJo3WnH05M/3WnzG0tvVYVlL4pZ8xxVK7zc=
Received: from DS7PR03CA0149.namprd03.prod.outlook.com (2603:10b6:5:3b4::34)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 20:09:19 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::35) by DS7PR03CA0149.outlook.office365.com
 (2603:10b6:5:3b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 20:09:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 20:09:18 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 11 Nov 2026 14:09:16 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4] drm/amd: Select the firmware signing scheme the PSP reports
Date: Wed, 11 Nov 2026 14:09:00 -0600
Message-ID: <20261111200900.1657741-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d83547-fd39-4210-7bb3-08df402faad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|6133799003|10067099003|18002099003|11063799006|261102123227099003|5023799004|261026140227099003|261021121427099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: YL1KlBPhQTVRKsUuY9QswRYTEDxF1O/ZDoodrmirK7HUkB/msZQwbFJCZv0dzyQuqWnV5r1fakAZPtjT/M1IA8CBdAv1A2oiBqIjOl+mPRyCwUydsEljte8m1xHrQArnq2KirxAxsWH554a+i2KYz+QqHBRINUWtryiDa5HTIH6ondpNwXD5cZJFYw4o/yVQBc0JLrCmibDMuRpCv9Z+AnvjjKX1EBW1oWB//nYl9X6nfpnYRQBF7aoNtPePahCXfqEaECN8sx9B0QvmivJt3DJ/X6Rtqy7kvKcsP0rhZ8TFy3WY8dgZP/8d7ZmQ+yYyDXsZKSeiLHH32pO2UiXp6angTXX3y9XrtS5PH0js4w4j42WEGMiIGZH5j5dGNNViCqwLGm66P7WAy6xOqVPzn6HU9QEq4hyqXlvsVZTBHYT2eDyVcT3QL7ZH29YgSA8Hhp92iRyQPy4IB+Xwm2lJyr9HRxOM+y1CtYFfo2/GpXtmiJTHn+Cmj5cyGXSFP50gIVwYRGgUnoMQKYiPzho6jledeyZQGT3Nlk9gbUPuGzQ/9DBheNuGDIOJ2ZCMpCip40GZTw4zY3uXl9F+MNQOxrWw3KbUgZTLMD+pHIXFlC/h7zKsf2F7AaEFp3VZDZGZiCAQalRGUKaZ3OFSy3ZTpYvy0yrv1JJFYOJkOXBY3NvXw+R7Yz/9an1X4+gMIU8vYOo1QnWqlM3YBs6CyyU/0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(6133799003)(10067099003)(18002099003)(11063799006)(261102123227099003)(5023799004)(261026140227099003)(261021121427099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d+l5EITlpAoTZngxnyuEPB7Nh2qUkh8WoKJQk3Nteum7Hubf6/oiwsVzqBtvruLSHPBroo1VIChvM/cxDBYBH6cRV6XtZQAUbCUX3BFT/J1PJGFJsXjPyw14VTxLWDzvuNt2y1TpcwpQhpc5wUCViQ+IlmB+EAmviLr2jdKhcEKijv1fbrjfzh/2VionWShOnMnij8jcJu0Jy5ZsAXx2jWmsmMpPXesQxRy1+oT8C0Jbq6XjnYx7BXHQzktwDEi1yBwr+u6SSkWdoKpFaofD6fn1t6rrX8Fovuz8t2SuyfQJupmLvDAT13cz7l2m6d1ckcRuFwgDpHf+Le0a1gFy6hV8O069YndtPWvdT9Z2AAk1BNfTojzsLxKo+tPGDQ1tIP8b/4wY41ZQhjD36jtvRMcr5XwofIE/vP7HpaGqD0SY0HqsfrjrI4mi/OddsvOk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:09:18.2777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d83547-fd39-4210-7bb3-08df402faad5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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
v4:
 * Add missing 11.7.1 MODULE_FIRMWARE declarations (Sashiko)
v3:
 * Use strends() (Lijo)
 * Don't initialize suffix in amdgpu_ucode_set_suffix() (Lijo)
 * Make preproduction a signing type instead of a separate bool
 * Use a switch/case to make suffixes more obvious
 * Return correct error code on invalid fname
v2:
 * Cover PSP 15.0.9 too.
 * Cover MODULE_FIRMWARE declarations for more files.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 32 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 +++++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  8 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 48 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
 15 files changed, 153 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 19a566187dfb5..b24ccdd958a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2101,6 +2101,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
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
index 82a2684dbd2e1..6d693b5249ddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -403,6 +403,26 @@ static uint64_t psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
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
index a4ec60f6c3170..7d8fc8eb2b125 100644
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
index d2ce526dd95cc..f39cbe689c21c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1527,6 +1527,34 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
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
@@ -1555,6 +1583,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
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
index 35277b240f25a..b3e83ec0fff7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -571,6 +571,12 @@ enum amdgpu_firmware_load_type {
 	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
 };
 
+enum amdgpu_firmware_sign_type {
+	AMDGPU_FW_SIGN_DEFAULT = 0,
+	AMDGPU_FW_SIGN_ALT,
+	AMDGPU_FW_SIGN_PREPROD,
+};
+
 enum amdgpu_ucode_required {
 	AMDGPU_UCODE_OPTIONAL,
 	AMDGPU_UCODE_REQUIRED,
@@ -606,6 +612,7 @@ struct amdgpu_firmware_info {
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
index d5f428ac19bf3..b42733d85ea89 100644
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
index e2b3f46bbc645..b6c4ae35ca03a 100644
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
index 0895c29899d2b..c76a6c4e69992 100644
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
index abaa40b6def90..734915573718d 100644
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
@@ -108,6 +116,46 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
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
+			 "Preproduction part with alternative signing, using default firmware\n");
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
index 383c53afd1f67..7cd08a9a957d6 100644
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
2.56.0

