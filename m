Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D73C5DF75
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C013A10F74D;
	Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c2OiDYcA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D82110F73E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT0wvmsMV/dUIBTOidOkyY9NJ8zMW1B+cs8SsoAA9Jz/rAjlcHJwRs9fDP1Z/M2JWtg9bXjedcOBHityMw2qaaZt04n8i/vup78BwfwTKB108Ijx0EsabfV6wM7jVcdb55EAemK+XtOyb1mUG1PvcjpMLweROJcmQwGEy9Kq4Zk/Q1WGIy+UNBv33nvt+AYxEXJ+8OA4rBVHch7PAR6TQMlXloycVPz49wRabZiDEfijjhFGWGmUlvnGEaX23J9+6k2B0amG9dJYmT8jTzydzKDkapZZzHrEmaDD39u/Gknsoaz1eZX/NQKEnjU3A0wy8aqsGOSOXUNmPcyTkqlfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktonijW/eKc0F7+LQwHpnLubquxC71r0DbPmK39hR4Y=;
 b=vEWmicf7Js27IAPbZuneNfLIqiet2XUIdnsMtklp4I6HUmrAw7SnJwI2j8+p5ZSn7h9FvkSZ1YpWNliJaRZXApg64YHkPLqdGbigal+niehFBnnX0ODtIvzvPMGHjc9n7Hgj+djxeKCwwfN/fB6d7IoV8x8bOhvU0qMaTDjq87jqzD8Z/o1iL37awKA+RuZ7LIpjmJel3paFSilT6P/Kq3CZVd9TxU1j+M3KAL+XLqp4kbr5RS4aiV3rxKgQmRB+NcxTyZ0TTn/VMPArxEuzoqCC9bg0sfHkcL331xqAZixvi9sEJihxbWoTNbCdm4+ovdQqwQMgqVfvb9x5/pe/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktonijW/eKc0F7+LQwHpnLubquxC71r0DbPmK39hR4Y=;
 b=c2OiDYcAa42YAb6hCaDPdskbHeG3j0dfsj3DkIwitvfxEwxojWBhG6uF24b8mVUkuSpnKvUidQ0sNcsywukeHWakm8Z6j/hVZqtBNaBZHGIlF7XIEkvnKoNj41hmZcTULvUPuJqzGCO5a5mZc7ZcWHvHrPkFHMVyF34sIF95ZXU=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 21:04:04 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::ad) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:04:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 102/109] drm/amd/ras: define processor and memory CPER formats
Date: Fri, 14 Aug 2026 17:02:39 -0400
Message-ID: <20260814210246.3067612-103-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb59d02-699e-4aed-1b3a-08defa479194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|22082099003|18002099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: hExxdBICo9vrKqFkcTbqlsxVDMCZlwTwrSzFZqJRwejy+VxvwekQIxI5u67tfP51rnzjkWyOLC8XXwlnxv9DErP8tXTlnjyFebLs5dEwODE5rtl+8l9/ZWYW4mMzLTAZqxW1gqWrb+YAUM9KWrz86Thu8HTqXCp5IpEVj76QCWU4k7UGTeHxQM1W0NjjWmPtZsHdhkFQklUxI0OmXo8MjcUhavIvmGZ5ZEtC74z/jrSuusU1HDCIZJq9fXauh4JxROJJ2tN0mO3fT4PFQGGELb17TIEwzzetKW/2JNr5p+pry32gf4UwpvpSdEFyugpEZD6acWL8c0seBeZapa7PdtNYU9V6myONjPHaUa30GunUwhlHYP/LOdESAgYjeqi0DwL6XhnmJ19hlzuVnqqEfIIQmGfZ0NsKZAJ349+Hs3dGsK4miqn7p2C2/GR111v5y6clllF1txwa/EYYFgAztAzlEhQQQ4DcUQt2xtw1L4NBCtOtf7tw2o2UqFARijAneIf32D02ly2VGGTgFf73ymvj1YBwAxedBltFmE0xlXYGGO5dy1glSU2PteljAUP+VQ06Cqk/8o74l3M3zvvliHbleqQ73DGrKvVIi401YPmAqbcF4ySEUnJiwmRu4WXjoOmieRFpGNvDqCML2Ic9WPmq4YYQykNTlIk5ZOEOpqpO5YmG/w4FmYEHcN7CbPKvNV2gGIkipSfegS7hYRJnJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 34AsG6mKRi9FzFJ53Zov+yPXT9ar2SoVZKwanemZTcRCDM8xozMwA37tile9ANa6F04GV7+zDnY5Ozz7lSLExdSw5g4FLyiiaP72bNCT4rWB7Zqe76bSFF5MNkXEow6UAjyBCnBAmXkOvlQJvXFb2pEAU/9nNI0XRF0le9jZom/EROQ7tkLvYDSjcWjT+nyxOD1KAftevX9923PHWdHx4mka7sdr8YOdNNxtGJ92KjHRXQLIxd/AUzD8D6kGv1NDJs8aPr8pJmne2prr7CYwEeV9XWqsFoNdvE7gkd7s+mTIdKKuCgUQmJ1wTBWCH/UuBs4d+Nubllzj8XfeRYvH8PL94un/EuNQsZ8vF0anL+pFJoR95A7JJ/gHBpmZht7OQjw6b4LtCLvcAfq1eI64tJogpS5k9WJziBoUbOa7t7MWpT3aQ9bdROzWufBqGuTn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:04:02.4839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb59d02-699e-4aed-1b3a-08defa479194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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

From: Xiang Liu <xiang.liu@amd.com>

CPU machine-check and platform boot errors require standard processor
and Platform Memory section definitions. The AMD crashdump format also
uses a 64-byte common header followed by a common error information
structure.

Add the required GUIDs, validity fields, processor structures, and AMD
crashdump wire layout so rascore can generate each record type.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_cper.h | 99 +++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.h b/drivers/gpu/drm/amd/ras/core/ras_cper.h
index f69f4e4de9ec9..58d2955ec08dc 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.h
@@ -38,8 +38,10 @@ struct ras_cper_guid {
 		(d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }}
 
 #define CPER_HDR__REV_1          (0x100)
+#define CPER_HDR__REV_AMD_CPU    (0x101)
 #define CPER_SEC__MINOR_REV_1    (0x01)
 #define CPER_SEC__MAJOR_REV_22   (0x22)
+#define CPER_SEC__REV_AMD_CPU    (0x0100)
 #define CPER_OAM_MAX_COUNT      (8)
 
 #define CPER_CTX_TYPE__CRASH     (1)
@@ -68,6 +70,43 @@ struct ras_cper_guid {
 #define PROC_ERR__SECTION_TYPE                                         \
 	CPER_GUID__INIT(0xDC3EA0B0, 0xA144, 0x4797, 0xB9, 0x5B, 0x53, 0xFA, \
 		  0x24, 0x2B, 0x6E, 0x1D)
+#define PROC_ERR__MS_CHECK_TYPE                                        \
+	CPER_GUID__INIT(0x48AB7F57, 0xDC34, 0x4F6C, 0xA7, 0xD3, 0xB0, 0xB5, \
+		  0xB0, 0xA7, 0x43, 0x14)
+#define PLATFORM_MEM__SECTION_TYPE                                     \
+	CPER_GUID__INIT(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
+		  0xED, 0x7C, 0x83, 0xB1)
+#define PCIE_ERR__SECTION_TYPE                                         \
+	CPER_GUID__INIT(0xD995E954, 0xBBC1, 0x430F, 0xAD, 0x91, 0xB4, 0x4D, \
+		  0xCB, 0x3C, 0x6F, 0x35)
+#define SMN_ERR__SECTION_TYPE                                          \
+	CPER_GUID__INIT(0xA2860CC1, 0x8987, 0x4B7C, 0xB8, 0x6A, 0xD5, 0x08, \
+		  0xB1, 0x76, 0xBA, 0x70)
+
+#define CPER_PROC_VALID_APIC_ID		BIT_ULL(0)
+#define CPER_PROC_ERR_INFO_COUNT(x)	(((u64)(x) & 0x3f) << 2)
+#define CPER_PROC_CONTEXT_COUNT(x)	(((u64)(x) & 0x3f) << 8)
+#define CPER_AMD_CONTEXT_COUNT(x)	(((u64)(x) & 0x3f) << 8)
+#define CPER_AMD_ERR_INFO_COUNT(x)	(((u64)(x) & 0x3f) << 2)
+
+#define CPER_PROC_INFO_VALID_CHECK_INFO	BIT_ULL(0)
+
+#define CPER_MS_CHECK_VALID_ERR_TYPE	BIT_ULL(0)
+#define CPER_MS_CHECK_VALID_PCC		BIT_ULL(1)
+#define CPER_MS_CHECK_VALID_UNCORRECTED	BIT_ULL(2)
+#define CPER_MS_CHECK_VALID_OVERFLOW	BIT_ULL(5)
+#define CPER_MS_CHECK_ERR_TYPE_INTERNAL	(5ULL << 16)
+#define CPER_MS_CHECK_PCC		BIT_ULL(19)
+#define CPER_MS_CHECK_UNCORRECTED	BIT_ULL(20)
+#define CPER_MS_CHECK_OVERFLOW		BIT_ULL(23)
+
+#define CPER_MCA_STATUS_OVERFLOW	BIT_ULL(62)
+#define CPER_MCA_STATUS_UNCORRECTED	BIT_ULL(61)
+#define CPER_MCA_STATUS_PCC		BIT_ULL(57)
+#define CPER_MCA_STATUS_DEFERRED	BIT_ULL(44)
+
+#define CPER_SMCA_MC0_STATUS_MSR	(0xc0002001U)
+#define CPER_SMCA_BANK_STRIDE		(0x10U)
 
 enum ras_cper_type {
 	RAS_CPER_TYPE_RUNTIME,
@@ -238,10 +277,10 @@ struct cper_section_runtime {
 };
 
 struct crashdump_hdr {
-	uint64_t reserved1;
-	uint64_t reserved2;
+	u64 valid_bits;
+	u32 pcie_device_id;
+	u32 pldm_bundle;
 	char     fw_id[48];
-	uint64_t reserved3[8];
 };
 
 struct fatal_reg_info {
@@ -267,16 +306,56 @@ struct crashdump_boot {
 	uint64_t msg[CPER_OAM_MAX_COUNT];
 };
 
+struct crashdump_error_info {
+	struct ras_cper_guid error_type;
+	u64 valid_bits;
+	u64 check_info;
+	u8 fru_part_number[16];
+	u8 redfish_event_id[16];
+};
+
 struct cper_section_fatal {
-	struct crashdump_hdr    hdr;
-	struct crashdump_fatal  data;
+	struct crashdump_hdr hdr;
+	struct crashdump_error_info error_info;
+	struct crashdump_fatal data;
 };
 
 struct cper_section_boot {
-	struct crashdump_hdr  hdr;
+	struct crashdump_hdr hdr;
+	struct crashdump_error_info error_info;
 	struct crashdump_boot data;
 };
 
+struct cper_processor_section {
+	u64 valid_bits;
+	u64 apic_id;
+	u8 cpuid[48];
+};
+
+struct cper_processor_error_info {
+	struct ras_cper_guid error_type;
+	u64 valid_bits;
+	u64 check_info;
+	u64 target_id;
+	u64 requester_id;
+	u64 responder_id;
+	u64 instruction_pointer;
+};
+
+struct cper_processor_context {
+	u16 reg_ctx_type;
+	u16 reg_arr_size;
+	u32 msr_addr;
+	u64 mm_reg_addr;
+	u64 reg_dump[RAS_CPER_ACA_REG_COUNT];
+};
+
+struct cper_section_processor {
+	struct cper_processor_section processor;
+	struct cper_processor_error_info error_info;
+	struct cper_processor_context context;
+};
+
 struct ras_cper_fatal_record {
 	struct cper_section_hdr hdr;
 	struct cper_section_desc descriptor;
@@ -288,6 +367,13 @@ struct ras_cper_boot_record {
 	struct cper_section_desc descriptor;
 	struct cper_section_boot boot;
 };
+
+struct ras_cper_processor_record {
+	struct cper_section_hdr hdr;
+	struct cper_section_desc descriptor;
+	struct cper_section_processor processor;
+};
+
 #pragma pack(pop)
 
 struct ras_core_context;
@@ -334,6 +420,7 @@ struct ras_cper {
 #define RAS_BOOT_SEC_LEN			(sizeof(struct cper_section_boot))
 #define RAS_FATAL_SEC_LEN			(sizeof(struct cper_section_fatal))
 #define RAS_NONSTD_SEC_LEN			(sizeof(struct cper_section_runtime))
+#define RAS_PROC_SEC_LEN			(sizeof(struct cper_section_processor))
 
 #define RAS_SEC_DESC_OFFSET(idx)		(RAS_HDR_LEN + (RAS_SEC_DESC_LEN * idx))
 
-- 
2.55.0

