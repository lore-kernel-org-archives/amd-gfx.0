Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B41C021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAAC110E48B;
	Fri, 14 Feb 2025 08:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GO1OD9vv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AE010E48B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnbZEn6qcDTjZLyBkfnKsIhETJTxz7tFBpw9pb4cOcyE0gnjEQ+CfyOIMwU78Bhq39LzRcGEf7TFZXkeGRshr2ztagfCwTG7nKkoWzdjVGgZ5BYUkjsuY2u3tg9ZOvlIpsgH4hoq7lgwJTKqCAmkTx633aeE4KMi9W8zQotRtweMybzldrQ9KhJkEC/oQOw6i1pKF2uipLsI/8gLEj6qJyPI0XF/34epcfW4qHV9r0+d0Stel0Pju/WuRWRhhhtzGUXZRKGhjXVob7hp70vi1DVOI673vQS5L5uvvKKT/quIKsnAJQl5LpZonKQJmRoVrgaDgakaVv8MO3dc4Wkfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ilr3KZyj9F1nIHo8lFt7UBidQ0RS+Ee/EaoQZUkPE4=;
 b=PL/wzZSlqD6EvrpHspbdUf49aVfjOgPVXSfc/tAGQD4fiRRpIi6qLX8TB1bUfDs/mvSGCX5aNZRaUNFPH3vWv8KSxqyvCD6y5ZvKALPUj6oq1SuFT77obfPmCaBLnC/GehaXXtITwN7ZwQedgMonAC/GmLF1Vo55dJKJzlEHqyz4xcOXtT3rII4tXaZj/SG8nbey6DlN9SwRnXjLLbsn653Gz9YIpx0GS7aauSp6MO43pqPOTn+ljOZ1KdukbIvP9QF26AGzUmdIUthao8js7ldcKzCrZsSh0MHOUk/I8cN6uLf/HcJa3G7XJsztX4CPKhOAoJ8IvEV+jmHv7FkTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ilr3KZyj9F1nIHo8lFt7UBidQ0RS+Ee/EaoQZUkPE4=;
 b=GO1OD9vvbjCCATLIIPZ0mE7RGnApPY2PnIdVPRz+SwekluPItzZaHVSIvqreEnVD9CoI0gJgWpNUojo40W7tLC6ozXPbHJsNBlK5DT21Tvt0P7svtmJxymooETJiwbGF8WwoSerjmb5R/Y7YzcQKNOp8BvYDEgZ59VIjnVTRey8=
Received: from BN1PR14CA0011.namprd14.prod.outlook.com (2603:10b6:408:e3::16)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 08:07:55 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::49) by BN1PR14CA0011.outlook.office365.com
 (2603:10b6:408:e3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 08:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:07:55 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:07:50 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v2 02/12] drm/amdgpu: Introduce funcs for populating CPER
Date: Fri, 14 Feb 2025 16:07:09 +0800
Message-ID: <75f9be139f5f3c6384710fd4acadcb1342e60bee.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c00bad-7b63-4c38-e077-08dd4cceafd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fq/CqELGa7buCq0bK3ZeIMc6h4Yt1L+r9QAhHwcLsnaGKq3rmiRZaxmOVZ/a?=
 =?us-ascii?Q?VJft3ixmjpLJiMBMkcxfQAA0H2oH0w8qs3IVEMIT3rH0mPD0VC7cQYyi934y?=
 =?us-ascii?Q?QIbhRAyf/BlaqvHgIwFqXoCYxBqit9j6WzGV74ISrgU148zFuwCeN2MGz4o9?=
 =?us-ascii?Q?ZBGBn51F9damT6dURQET70GOXHZ2WI/rCNj3Pxkpu8Ii3MQ+XHqEM5Z6McVb?=
 =?us-ascii?Q?yXMgedf8NQeftlY7i3UwZcxYliaiT3lPT60WN9+cSzVQztShHVcaavXABRTx?=
 =?us-ascii?Q?lM2jkdnULLTGheqVLXZrwNaRpEY6jtEUyBMlGG86kWQxFJoCLoB+Norc3aij?=
 =?us-ascii?Q?Fc/+o1QIhPwaLQJ66Fea9TyboDy+LExjye2oMLYaz3U3n+/GpKbSiNe+1dVQ?=
 =?us-ascii?Q?IeZzYUtmbsf6CMCq+HyrntPD3TlhoAWnr/0j087cpNc7sWcA1lRNz85xvt3/?=
 =?us-ascii?Q?hM7Avdl0CiN+0uNP5VTBkOCeNKa8qM6lbMSQrTrUa8tJrglj7Pd3WM4mV/pr?=
 =?us-ascii?Q?e4UYk1yX2+87ukobwPEularJXi6p6cLWPKwB29RyNbdR5frVc9AJNKKrIw1R?=
 =?us-ascii?Q?NsnagkTqxFig6rk1UjPwFqqjSHgwSMFs1MGDLDyQS/t3D4kJIBsMtzdg1ahE?=
 =?us-ascii?Q?kmOfRatvS+19Zi+fNKuS5Y0FSccHEbcV49IGcH46FO7tMcRXFr1SnKREab6J?=
 =?us-ascii?Q?cDPuWLoiqwLddIjGhMMagAeNxpjbjU36J0mrZZHX358ZOQ4oaOkY7+g6Nqtg?=
 =?us-ascii?Q?g+vtfN3LecvqgoA3V8rnhA1uLekUTVcf1sDau6krYDJpIysA7InlOeKwlOie?=
 =?us-ascii?Q?vjiRCsCREwxWXrfbw1kQQFCUyM1r+pjJyclSTEsUzfgImOnYiv6UUwdol+FZ?=
 =?us-ascii?Q?2zCfw+1SQCU+fWZb28Kjc96pMjOepk76iom/ObRhBbPP/pq4mbnaudwiD034?=
 =?us-ascii?Q?suMn5x+0VNB1b8zK/b2puS982WyuzVc5anpPOU1Dq7HJJmW4XLEPKzGJ0h9r?=
 =?us-ascii?Q?orr5gxO26rXU+ESh8Dq+zCyYH28QCjWp3pufLTSVzokdbepp+IfG4GPt4nkR?=
 =?us-ascii?Q?/mD+JF84izXUqTqtosz0rzn2QMpp4RFsnzQPkold0ry1UC414KJV0Qgd8xz0?=
 =?us-ascii?Q?fzMN3C6QYiF5hDbP5llysdzBtu7h1KrZYb/iEfCGGZijy7LzLpoS5kp9obhf?=
 =?us-ascii?Q?zoOa1h5zB1tfUkW+RSSZqV5+P15cZDNjKmTXIqnKMwzdoJ/1wQ70TjSyxYBf?=
 =?us-ascii?Q?mG4atSvDqtYiMrUxXY209RB6M2FXOpAuJ4ke7R7hPAoPha7S8gK5PEQaJWWK?=
 =?us-ascii?Q?YmrbCPi2UrpzAaxlPlR8QVTbPdqPcL7JKNLimA7/MN2iG4avyCYyO/7rz6gK?=
 =?us-ascii?Q?/SXdOQ7EK9XxPwq4xG3hrDsrpZG6YeAkBuHJ+fyxKXW6kCMc8IwURgkh4/ap?=
 =?us-ascii?Q?SrPMvhIsk7PsRZosgmxUrhl4tyApPK8y/pq+Www/Z9xhicXahZSZzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:07:55.3118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c00bad-7b63-4c38-e077-08dd4cceafd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Introduce utility functions designed to assist
in populating CPER records.

v2: call cper_init/fini in device_ip_init/fini.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c   | 281 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h   |  91 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   4 +
 5 files changed, 381 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 04247303b3cf..84bb3dfa39a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -66,7 +66,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_userq_fence.o amdgpu_eviction_fence.o
+	amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_cper.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc1f8d6fd0c4..db0a26800927 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -110,6 +110,7 @@
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
 #include "amdgpu_reg_state.h"
@@ -1128,6 +1129,9 @@ struct amdgpu_device {
 	/* ACA */
 	struct amdgpu_aca		aca;
 
+	/* CPER */
+	struct amdgpu_cper		cper;
+
 	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
 	uint32_t		        harvest_ip_mask;
 	int				num_ip_blocks;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
new file mode 100644
index 000000000000..8ce5dc6efcf9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+
+static const guid_t MCE			= CPER_NOTIFY_MCE;
+static const guid_t CMC			= CPER_NOTIFY_CMC;
+static const guid_t BOOT		= BOOT_TYPE;
+
+static const guid_t CRASHDUMP		= AMD_CRASHDUMP;
+static const guid_t RUNTIME		= AMD_GPU_NONSTANDARD_ERROR;
+
+static void __inc_entry_length(struct cper_hdr *hdr, uint32_t size)
+{
+	hdr->record_length += size;
+}
+
+void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
+				struct cper_hdr *hdr,
+				enum amdgpu_cper_type type,
+				enum cper_error_severity sev)
+{
+	hdr->signature[0]		= 'C';
+	hdr->signature[1]		= 'P';
+	hdr->signature[2]		= 'E';
+	hdr->signature[3]		= 'R';
+	hdr->revision			= CPER_HDR_REV_1;
+	hdr->signature_end		= 0xFFFFFFFF;
+	hdr->error_severity		= sev;
+
+	hdr->valid_bits.platform_id	= 1;
+	hdr->valid_bits.partition_id	= 1;
+	hdr->valid_bits.timestamp	= 1;
+	/*TODO need to initialize hdr->timestamp */
+
+	snprintf(hdr->record_id, 8, "%d", atomic_inc_return(&adev->cper.unique_id));
+	snprintf(hdr->platform_id, 16, "0x%04X:0x%04X",
+		 adev->pdev->vendor, adev->pdev->device);
+	/* pmfw version should be part of creator_id according to CPER spec */
+	snprintf(hdr->creator_id, 16, "%s", CPER_CREATOR_ID_AMDGPU);
+
+	switch (type) {
+	case AMDGPU_CPER_TYPE_BOOT:
+		hdr->notify_type = BOOT;
+		break;
+	case AMDGPU_CPER_TYPE_FATAL:
+	case AMDGPU_CPER_TYPE_BP_THRESHOLD:
+		hdr->notify_type = MCE;
+		break;
+	case AMDGPU_CPER_TYPE_RUNTIME:
+		if (sev == CPER_SEV_NON_FATAL_CORRECTED)
+			hdr->notify_type = CMC;
+		else
+			hdr->notify_type = MCE;
+		break;
+	default:
+		dev_err(adev->dev, "Unknown CPER Type\n");
+		break;
+	}
+
+	__inc_entry_length(hdr, HDR_LEN);
+}
+
+static int amdgpu_cper_entry_fill_section_desc(struct amdgpu_device *adev,
+					       struct cper_sec_desc *section_desc,
+					       bool bp_threshold,
+					       bool poison,
+					       enum cper_error_severity sev,
+					       guid_t sec_type,
+					       uint32_t section_length,
+					       uint32_t section_offset)
+{
+	section_desc->revision_minor		= CPER_SEC_MINOR_REV_1;
+	section_desc->revision_major		= CPER_SEC_MAJOR_REV_22;
+	section_desc->sec_offset		= section_offset;
+	section_desc->sec_length		= section_length;
+	section_desc->valid_bits.fru_id		= 1;
+	section_desc->valid_bits.fru_text	= 1;
+	section_desc->flag_bits.primary		= 1;
+	section_desc->severity			= sev;
+	section_desc->sec_type			= sec_type;
+
+	if (adev->smuio.funcs &&
+	    adev->smuio.funcs->get_socket_id)
+		snprintf(section_desc->fru_text, 20, "OAM%d",
+			 adev->smuio.funcs->get_socket_id(adev));
+	/* TODO: fru_id is 16 bytes in CPER spec, but driver defines it as 20 bytes */
+	snprintf(section_desc->fru_id, 16, "%llx", adev->unique_id);
+
+	if (bp_threshold)
+		section_desc->flag_bits.exceed_err_threshold = 1;
+	if (poison)
+		section_desc->flag_bits.latent_err = 1;
+
+	return 0;
+}
+
+int amdgpu_cper_entry_fill_fatal_section(struct amdgpu_device *adev,
+					 struct cper_hdr *hdr,
+					 uint32_t idx,
+					 struct cper_sec_crashdump_reg_data reg_data)
+{
+	struct cper_sec_desc *section_desc;
+	struct cper_sec_crashdump_fatal *section;
+
+	section_desc = (struct cper_sec_desc *)((uint8_t *)hdr + SEC_DESC_OFFSET(idx));
+	section = (struct cper_sec_crashdump_fatal *)((uint8_t *)hdr +
+		   FATAL_SEC_OFFSET(hdr->sec_cnt, idx));
+
+	amdgpu_cper_entry_fill_section_desc(adev, section_desc, false, false,
+					    CPER_SEV_FATAL, CRASHDUMP, FATAL_SEC_LEN,
+					    FATAL_SEC_OFFSET(hdr->sec_cnt, idx));
+
+	section->body.reg_ctx_type = CPER_CTX_TYPE_CRASH;
+	section->body.reg_arr_size = sizeof(reg_data);
+	section->body.data = reg_data;
+
+	__inc_entry_length(hdr, SEC_DESC_LEN + FATAL_SEC_LEN);
+
+	return 0;
+}
+
+int amdgpu_cper_entry_fill_runtime_section(struct amdgpu_device *adev,
+					   struct cper_hdr *hdr,
+					   uint32_t idx,
+					   enum cper_error_severity sev,
+					   uint32_t *reg_dump,
+					   uint32_t reg_count)
+{
+	struct cper_sec_desc *section_desc;
+	struct cper_sec_nonstd_err *section;
+	bool poison;
+
+	poison = (sev == CPER_SEV_NON_FATAL_CORRECTED) ? false : true;
+	section_desc = (struct cper_sec_desc *)((uint8_t *)hdr + SEC_DESC_OFFSET(idx));
+	section = (struct cper_sec_nonstd_err *)((uint8_t *)hdr +
+		   NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
+
+	amdgpu_cper_entry_fill_section_desc(adev, section_desc, false, poison,
+					    sev, RUNTIME, NONSTD_SEC_LEN,
+					    NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
+
+	reg_count = min(reg_count, CPER_ACA_REG_COUNT);
+
+	section->hdr.valid_bits.err_info_cnt = 1;
+	section->hdr.valid_bits.err_context_cnt = 1;
+
+	section->info.error_type = RUNTIME;
+	section->info.ms_chk_bits.err_type_valid = 1;
+	section->ctx.reg_ctx_type = CPER_CTX_TYPE_CRASH;
+	section->ctx.reg_arr_size = sizeof(section->ctx.reg_dump);
+
+	memcpy(section->ctx.reg_dump, reg_dump, reg_count * sizeof(uint32_t));
+
+	__inc_entry_length(hdr, SEC_DESC_LEN + NONSTD_SEC_LEN);
+
+	return 0;
+}
+
+int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev,
+						      struct cper_hdr *hdr,
+						      uint32_t idx)
+{
+	struct cper_sec_desc *section_desc;
+	struct cper_sec_nonstd_err *section;
+
+	section_desc = (struct cper_sec_desc *)((uint8_t *)hdr + SEC_DESC_OFFSET(idx));
+	section = (struct cper_sec_nonstd_err *)((uint8_t *)hdr +
+		   NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
+
+	amdgpu_cper_entry_fill_section_desc(adev, section_desc, true, false,
+					    CPER_SEV_FATAL, RUNTIME, NONSTD_SEC_LEN,
+					    NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
+
+	section->hdr.valid_bits.err_info_cnt = 1;
+	section->hdr.valid_bits.err_context_cnt = 1;
+
+	section->info.error_type = RUNTIME;
+	section->info.ms_chk_bits.err_type_valid = 1;
+	section->ctx.reg_ctx_type = CPER_CTX_TYPE_CRASH;
+	section->ctx.reg_arr_size = sizeof(section->ctx.reg_dump);
+
+	/* Hardcoded Reg dump for bad page threshold CPER */
+	section->ctx.reg_dump[CPER_ACA_REG_CTL_LO]    = 0x1;
+	section->ctx.reg_dump[CPER_ACA_REG_CTL_HI]    = 0x0;
+	section->ctx.reg_dump[CPER_ACA_REG_STATUS_LO] = 0x137;
+	section->ctx.reg_dump[CPER_ACA_REG_STATUS_HI] = 0xB0000000;
+	section->ctx.reg_dump[CPER_ACA_REG_ADDR_LO]   = 0x0;
+	section->ctx.reg_dump[CPER_ACA_REG_ADDR_HI]   = 0x0;
+	section->ctx.reg_dump[CPER_ACA_REG_MISC0_LO]  = 0x0;
+	section->ctx.reg_dump[CPER_ACA_REG_MISC0_HI]  = 0x0;
+	section->ctx.reg_dump[CPER_ACA_REG_CONFIG_LO] = 0x2;
+	section->ctx.reg_dump[CPER_ACA_REG_CONFIG_HI] = 0x1ff;
+	section->ctx.reg_dump[CPER_ACA_REG_IPID_LO]   = 0x0;
+	section->ctx.reg_dump[CPER_ACA_REG_IPID_HI]   = 0x96;
+	section->ctx.reg_dump[CPER_ACA_REG_SYND_LO]   = 0x0;
+	section->ctx.reg_dump[CPER_ACA_REG_SYND_HI]   = 0x0;
+
+	__inc_entry_length(hdr, SEC_DESC_LEN + NONSTD_SEC_LEN);
+
+	return 0;
+}
+
+struct cper_hdr *amdgpu_cper_alloc_entry(struct amdgpu_device *adev,
+					 enum amdgpu_cper_type type,
+					 uint16_t section_count)
+{
+	struct cper_hdr *hdr;
+	uint32_t size = 0;
+
+	size += HDR_LEN;
+	size += (SEC_DESC_LEN * section_count);
+
+	switch (type) {
+	case AMDGPU_CPER_TYPE_RUNTIME:
+	case AMDGPU_CPER_TYPE_BP_THRESHOLD:
+		size += (NONSTD_SEC_LEN * section_count);
+		break;
+	case AMDGPU_CPER_TYPE_FATAL:
+		size += (FATAL_SEC_LEN * section_count);
+		break;
+	case AMDGPU_CPER_TYPE_BOOT:
+		size += (BOOT_SEC_LEN * section_count);
+		break;
+	default:
+		dev_err(adev->dev, "Unknown CPER Type!\n");
+		return NULL;
+	}
+
+	hdr = kzalloc(size, GFP_KERNEL);
+	if (!hdr)
+		return NULL;
+
+	/* Save this early */
+	hdr->sec_cnt = section_count;
+
+	return hdr;
+}
+
+int amdgpu_cper_init(struct amdgpu_device *adev)
+{
+	mutex_init(&adev->cper.cper_lock);
+
+	adev->cper.enabled = true;
+	adev->cper.max_count = CPER_MAX_ALLOWED_COUNT;
+
+	/*TODO: initialize cper ring*/
+
+	return 0;
+}
+
+int amdgpu_cper_fini(struct amdgpu_device *adev)
+{
+	adev->cper.enabled = false;
+
+	/*TODO: free cper ring */
+	adev->cper.count = 0;
+	adev->cper.wptr = 0;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
new file mode 100644
index 000000000000..0ae845420983
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __AMDGPU_CPER_H__
+#define __AMDGPU_CPER_H__
+
+#include "amd_cper.h"
+
+#define CPER_MAX_ALLOWED_COUNT		0x1000
+#define HDR_LEN				(sizeof(struct cper_hdr))
+#define SEC_DESC_LEN			(sizeof(struct cper_sec_desc))
+
+#define BOOT_SEC_LEN			(sizeof(struct cper_sec_crashdump_boot))
+#define FATAL_SEC_LEN			(sizeof(struct cper_sec_crashdump_fatal))
+#define NONSTD_SEC_LEN			(sizeof(struct cper_sec_nonstd_err))
+
+#define SEC_DESC_OFFSET(idx)		(HDR_LEN + (SEC_DESC_LEN * idx))
+
+#define BOOT_SEC_OFFSET(count, idx)	(HDR_LEN + (SEC_DESC_LEN * count) + (BOOT_SEC_LEN * idx))
+#define FATAL_SEC_OFFSET(count, idx)	(HDR_LEN + (SEC_DESC_LEN * count) + (FATAL_SEC_LEN * idx))
+#define NONSTD_SEC_OFFSET(count, idx)	(HDR_LEN + (SEC_DESC_LEN * count) + (NONSTD_SEC_LEN * idx))
+
+enum amdgpu_cper_type {
+	AMDGPU_CPER_TYPE_RUNTIME,
+	AMDGPU_CPER_TYPE_FATAL,
+	AMDGPU_CPER_TYPE_BOOT,
+	AMDGPU_CPER_TYPE_BP_THRESHOLD,
+};
+
+struct amdgpu_cper {
+	bool enabled;
+
+	atomic_t unique_id;
+	struct mutex cper_lock;
+
+	/* Lifetime CPERs generated */
+	uint32_t count;
+	uint32_t max_count;
+
+	uint32_t wptr;
+
+	void *ring[CPER_MAX_ALLOWED_COUNT];
+};
+
+void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
+				struct cper_hdr *hdr,
+				enum amdgpu_cper_type type,
+				enum cper_error_severity sev);
+int amdgpu_cper_entry_fill_fatal_section(struct amdgpu_device *adev,
+					 struct cper_hdr *hdr,
+					 uint32_t idx,
+					 struct cper_sec_crashdump_reg_data reg_data);
+int amdgpu_cper_entry_fill_runtime_section(struct amdgpu_device *adev,
+					   struct cper_hdr *hdr,
+					   uint32_t idx,
+					   enum cper_error_severity sev,
+					   uint32_t *reg_dump,
+					   uint32_t reg_count);
+int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev,
+						      struct cper_hdr *hdr,
+						      uint32_t section_idx);
+
+struct cper_hdr *amdgpu_cper_alloc_entry(struct amdgpu_device *adev,
+					 enum amdgpu_cper_type type,
+					 uint16_t section_count);
+
+int amdgpu_cper_init(struct amdgpu_device *adev);
+int amdgpu_cper_fini(struct amdgpu_device *adev);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f9a7bd741a41..f5c65e89b23b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3075,6 +3075,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	amdgpu_fru_get_product_info(adev);
 
+	r = amdgpu_cper_init(adev);
+
 init_failed:
 
 	return r;
@@ -3435,6 +3437,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_cper_fini(adev);
+
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
 
-- 
2.34.1

