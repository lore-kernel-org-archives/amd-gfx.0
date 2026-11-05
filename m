Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD776606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z6s5X/tl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B60E10E03C;
	Thu,  5 Nov 2026 22:24:52 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010057.outbound.protection.outlook.com
 [40.93.198.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F2210E03C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 22:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSTihWzIP0Un7DT/4+9omCtKri5z4N5tYd1yukRgesexJjsyZXTcT4NF+pO05OsbbJC2Cn7pYf9VYRMVwFK1PUY4jZbNmXGbEpezaNcFpEAyGgavDGy/qmfGuioctaGDK7wht2J1+kaXLWCvQHWe/NgwaOou6qrUzngNh8Lp28UtcWrBExnMUFx8tTVyIAATv1sDUNCxXoSjUI63I3SMTnqVZcXBUMDo3YbCED2gzwfjdOL13y9si6BlNvyNFzRNkRsvC5eX2LJXBLOSNMUdDOcN5S5bw82eI2PZLv8NMt0OHvGElJHRol7Tv5Iz6DbT1jCh5f1KOrwCzsyWT5Yj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKWcouXSCjWKb4aMgzO3NcwJ5exWyfm+ZT/okEJLUAs=;
 b=Va6AoQeu8x/4a5QILUOxgnoMZJbpyMAReXuB55lyccd50LRFQ9gn8LbrRYbua7zKn5b9fR/9FxSeYsJWRAbEjZ81I0yx4eTWQwxIO2HVarN9Hh+g46uvwJb60cSBMxRyRmagxeB2wGiqz5GbA1l5jU0QfmpyzrnJV1UrjmlEtylhQWB4dhl+Z8KVE5FYpZqVE23rJinQoVihP1AfWOG1NOMu6qCMbQPB9qGbbnu4elsgTtnorKRj3jgW/uhFN9e/WZAkebQRY+6Dc2eG5Pfc96aCfXAfGMX64iUIMo/cKEPtNVQIaicw8O0w1Y7B+TrCOaqGZgMOSFPaiOPk6p/AKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKWcouXSCjWKb4aMgzO3NcwJ5exWyfm+ZT/okEJLUAs=;
 b=Z6s5X/tlEKmVNrxbbe79TZULDv3tjIr0QgakXyot6RtaKAMUr+f2VzA0Buyy/C/PU7q5kqX9sETNwJSBqruhixVg2jkMXm3L9iPjlsr+fftFrxzc+tD+s/ai9HshhJl6QxiHA8NuKeEKjDgnbPbIlUrlvDFS4FJZdBWnbAS7Frc=
Received: from SJ0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:33a::32)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 22:24:44 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::76) by SJ0PR03CA0027.outlook.office365.com
 (2603:10b6:a03:33a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 22:24:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 22:24:42 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 5 Nov 2026 16:24:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Select the firmware signing scheme the PSP reports
Date: Thu, 5 Nov 2026 16:24:09 -0600
Message-ID: <20261105222409.1022159-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: c5036f93-7ee1-493e-2695-08df3b8b96f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|260925021311599003|260925021911599003|260925022911599003|11063799006|5023799004|56012099006|261009223027099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: nsj5i2apVEsEP1FITyNmTQsTD9HhMzEIcvcbp25ZKLvyGCflhWYD/34+9z2CzWwOEI8j2jcuku4Wen7kSSXX+vGdgxiBz/hfSCPloIUe97QwdEG7X62SonPwGgJjsYpRxkaNuWYJ5Gnbkj7xnH481qYQ+70aCQhRJ+CfmO5g7mpBng1wMXN7RiL48DfswspxHaWgVve6h8dB5NsoF7ZhZaQHNLBHVBlavP0IG5Fe63DxBNEhZIXImY1g9GGJX3i5u/9eldHfW5liL7rJ9ffqWiRfWHfFTgCJTGvpIwGl0R3j9zqihVSHfcBVAF7leqngHs8B2JiwZ+ELssgxDzZ/aK1ExS7vCO1ONDr/RNMqytzk30fZ3BnF4/aq51sdxDsk8gT+bvi0vWoyqblTeXLmcFXpGas1Nt+EjiP0HTAATxq60Cg/hhcRPy7CU4nJRU7oYcdOUvpBXOsrCPmYoPEM6uDWBv2QcaF074AcbI0D99jMOHlQDjXrjQmOm4JzCstN9DKS/ncHu4udLYSXyuTkd2loSFZsSOOzFfV0AOhoVhW2Z1+y4Z8wL2KIt5VLB9EDL3i06+X/PeI4/jLVlBC9eSXCKg6GUQ3G9poQtyJXgR7Y8xgdNyETK2YV/Ud4oV1RhLKxeD743HDp7y/ycQXO7HqKu06B13ljo/9N/lu9EF/U6Dj6GRIPsNwoh+giro4M+/9GGVmLEGAcTSKoMAvC9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: crHfa7EE9iRxaPaNdJYSRAJjiRvq7+cV83SZ7fPGzhbsJVQZnxsJzryOP11ysiu//niHBMdfKDruj3EgByH51OdAGvLQhnmtDWI70s06nR7/apOAmZ5dOiCv/c6J7u7fUZuSfwT/sZJmdwvKBIHIiwZuXLQnbN3cOFNCvS3+usMy0yUfmKVXyAwMvO+jMRjS8gJOnCOYT5SD+2NTCaAEAMWtdDJaXGjgRrpbZkYHiOoYp51mYPyVWKNssvRq56QqLOAMXTg8Kmt6chGyy0FUyRxU2dqDFSTEE2zWTovwZDnhDXg6N82gP+u3bHMovjn/jZyzeB5crW2jEAQ7rkPI6VpWSxnr4cDrBXrX3ecNhpLoZV1QthibxX5uHxYh42QOio+fLgCyZgJ+k1T+LOit3XPPa8OTAGdVxftE881fj9tIODjU3eTiTBaO4gxUdmhT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 22:24:42.7436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5036f93-7ee1-493e-2695-08df3b8b96f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
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
The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in bit 28
whether this is a preproduction part, which needs firmware of its own.

Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
own MMIO, and keep the result in adev->firmware.sign_type and
adev->firmware.preprod next to load_type. It is initialized once, after IP
discovery has populated the register bases and only when firmware is loaded
through the front door (the PSP). Only MP0 15.0.0 reports it. For all other
ASICs, SR-IOV VFs and an inaccessible register (all ones) the defaults are
kept: AMDGPU_FW_SIGN_DEFAULT and not preproduction. A preproduction part
that also reports the alternative scheme is not expected, so warn about it
and use the default firmware.

Firmware for preproduction parts is named with a "_p" suffix before the
extension and firmware for the alternative scheme with an "_l" suffix (e.g.
"foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on the
default scheme use the plain names. Do the substitution centrally in
amdgpu_ucode_request() so it covers every IP that loads firmware through it
(PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each loader
having to care. There is no fallback to the default file: it would be
rejected anyway. Declare the variants of the Medusa IPs with
MODULE_FIRMWARE() so that initramfs generators include them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 31 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 25 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  8 +++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  4 +++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 33 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 ++
 15 files changed, 128 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 23f0223a9b6b0..cf6f8ec597f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2098,6 +2098,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
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
index c0ed3e24b6840..509ceb1388d21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -403,6 +403,37 @@ static uint64_t psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
 	return pos;
 }
 
+/*
+ * Which firmware the platform needs, as reported by the PSP in C2PMSG_63: the
+ * signing scheme and whether this is a preproduction part. The defaults are kept if
+ * the ASIC doesn't report it or it can't be read.
+ */
+void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
+{
+	bool alt, preprod;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(15, 0, 0):
+		if (psp_v15_0_0_get_fw_variant(adev, &alt, &preprod))
+			return;
+		break;
+	default:
+		return;
+	}
+
+	if (alt && preprod) {
+		drm_warn(adev_to_drm(adev),
+			 "Preproduction part with alternative signing, using default firmware\n");
+		return;
+	}
+
+	adev->firmware.sign_type = alt ? AMDGPU_FW_SIGN_ALT : AMDGPU_FW_SIGN_DEFAULT;
+	adev->firmware.preprod = preprod;
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
index d2ce526dd95cc..eeb056dcad2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1527,6 +1527,27 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
 	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
 }
 
+/* Add the suffix of the firmware variant before the extension: foo.bin -> foo_l.bin */
+static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char *fname, size_t size)
+{
+	const char *suffix = ".bin";
+	size_t len = strlen(fname), base;
+
+	if (adev->firmware.preprod)
+		suffix = "_p.bin";
+	else if (adev->firmware.sign_type == AMDGPU_FW_SIGN_ALT)
+		suffix = "_l.bin";
+
+	if (len < strlen(".bin") || strcmp(fname + len - strlen(".bin"), ".bin"))
+		return 0;
+
+	base = len - strlen(".bin");
+	if (strscpy(fname + base, suffix, size - base) < 0)
+		return -EOVERFLOW;
+
+	return 0;
+}
+
 /*
  * amdgpu_ucode_request - Fetch and validate amdgpu microcode
  *
@@ -1555,6 +1576,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 		return -EOVERFLOW;
 	}
 
+	r = amdgpu_ucode_set_suffix(adev, fname, sizeof(fname));
+	if (r)
+		return r;
+
 	if (required == AMDGPU_UCODE_REQUIRED)
 		r = request_firmware(fw, fname, adev->dev);
 	else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 7c809692807fc..a77758c07be23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -571,6 +571,11 @@ enum amdgpu_firmware_load_type {
 	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
 };
 
+enum amdgpu_firmware_sign_type {
+	AMDGPU_FW_SIGN_DEFAULT = 0,
+	AMDGPU_FW_SIGN_ALT,
+};
+
 enum amdgpu_ucode_required {
 	AMDGPU_UCODE_OPTIONAL,
 	AMDGPU_UCODE_REQUIRED,
@@ -606,6 +611,8 @@ struct amdgpu_firmware_info {
 struct amdgpu_firmware {
 	struct amdgpu_firmware_info ucode[AMDGPU_UCODE_ID_MAXIMUM];
 	enum amdgpu_firmware_load_type load_type;
+	enum amdgpu_firmware_sign_type sign_type;
+	bool preprod;
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
index 430b8f3743b2b..e3b4605572153 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -134,9 +134,17 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
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
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 09dc01a425d13..2fe5ebd2ff6d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -44,6 +44,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 13ac733c8cf38..812e618012a32 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -61,7 +61,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index abaa40b6def90..edb1846587b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -32,7 +32,11 @@
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
@@ -108,6 +112,35 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
 	return ret;
 }
 
+/*
+ * C2PMSG_63 bit 6: 0 = default firmware signing, 1 = alternative
+ * C2PMSG_63 bit 28: 0 = production part, 1 = preproduction part
+ */
+#define PSP_V15_0_0_FW_SIGN_ALT		BIT(6)
+#define PSP_V15_0_0_FW_PREPROD		BIT(28)
+
+int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, bool *preprod)
+{
+	u32 val;
+
+	if (!adev->reg_offset[MP0_HWIP][0])
+		return -ENODEV;
+
+	val = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
+	if (val == 0xffffffff) {
+		drm_warn(adev_to_drm(adev), "Unable to access regMPASP_SMN_C2PMSG_63\n");
+		return -EIO;
+	}
+
+	*alt = !!(val & PSP_V15_0_0_FW_SIGN_ALT);
+	*preprod = !!(val & PSP_V15_0_0_FW_PREPROD);
+	dev_info(adev->dev, "PSP firmware: %s signing, %s part\n",
+		 *alt ? "alternative" : "default",
+		 *preprod ? "preproduction" : "production");
+
+	return 0;
+}
+
 static int psp_v15_0_0_ring_create(struct psp_context *psp,
 				 enum psp_ring_type ring_type)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
index ebd612103526f..2915ddcfff312 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
@@ -26,5 +26,6 @@
 #include "amdgpu_psp.h"
 
 void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
+int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, bool *preprod);
 
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

