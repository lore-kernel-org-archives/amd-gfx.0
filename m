Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E2C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 03:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7E8611BE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 03:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7E8611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC4D96EB41;
	Wed, 12 May 2021 03:35:12 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8C96EB41
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 03:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S23/3nLnSmD3fNK0WqcFS/MbaVgMTlHsJQRVLbqtSvZypBWOFe00Xk2t4iDXRXaOEpeaBrfXF/w9L85eAozBuf51sMOD3qJh8ew0Z+DDw2i4xZPidVQb23zNLdFpwULBxAWGsCnxIvMEYpbt687t+Zjnl5A1NFPc3g/o9iihsJLS3RaPghEtSagQGxCFgU1yun8OPxjMXzR9FA0LirtarGxNAX9e8A2xPD27yBH5P6srK4AJgTlW+MZ5f+vX48kZKFjKMoWGTpT86rnHrnFs6TxmPoOYg0RUQgiK0MNoZS/N6/2SdZlpBf0bsbbabpR8KwB8/kiZpwA+6kvF9h2blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQe6LBMmqJ42xLFIFBxPkcNibT2px71MYkMsITHuPRY=;
 b=P2ysETXd1TuUj/gd7MY7IROear4r+P4rQUgmNpqCFRGLPFHhp88kMZcBcw38h+Gr2rm6Tn5jCx5zMCMfd5wQdfCpGoe2Hj7hxWqCY6tcUeZmxDO+fZnJKEzA49vOCSZnndOhSmhALkcLkKA82ubQpa71z+icXnTislxbaIifUUcyhZRC6L4k7OW9t5A84NJmRHhdc25goBiuzoKKHRpoTQ5hRTcRfJTnWpI8gBl7s98aAUdxhXQcr9ui3exkpVT22OxwMM/IRt9cBd9c0hhIQSh2QwhF2WDvMyIWc6vTPbOPyvT6FitkuSN1EfCYeZtLi4a9EPxEicDI5cr4KGRMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQe6LBMmqJ42xLFIFBxPkcNibT2px71MYkMsITHuPRY=;
 b=nVtBf0nI+LOVkhjB1fCjL8XorfWRCRratyhbUGW4R4Lot4I/N7Zk7aXckmVQg+embfA/JoO+xeT3VcPQAjtmBG0M1duV/IFxorQoNlBuTnDg3ECDdvTpOOex8Q3rVESRrJdgDK5s2rkfsz006pTPuxb9QJZ0lJdoUfN7rcsb+6A=
Received: from BN6PR19CA0055.namprd19.prod.outlook.com (2603:10b6:404:e3::17)
 by BN6PR12MB1185.namprd12.prod.outlook.com (2603:10b6:404:1e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 03:35:08 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::d8) by BN6PR19CA0055.outlook.office365.com
 (2603:10b6:404:e3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Wed, 12 May 2021 03:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 12 May 2021 03:35:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 22:35:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 22:35:05 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 22:35:04 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <tom.stdenis@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] add vbios info query
Date: Wed, 12 May 2021 11:34:51 +0800
Message-ID: <20210512033451.19253-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c885a16-a054-4b16-dce4-08d914f6f074
X-MS-TrafficTypeDiagnostic: BN6PR12MB1185:
X-Microsoft-Antispam-PRVS: <BN6PR12MB11856B3AFCF2DB440C28AB8AF8529@BN6PR12MB1185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yey5+u8bKYkH6ryNO6wMsXHePYimaa0MOBwOesSq0l87oMDcaKCj+QXXR/2SOSMUrEdQCWdR/1/fZZ+cMZhPFe/2IxJ7I9YSrRpbX+r3lMgEYriH8Sy9KmfjZE/xUAjqwJENiMyJMhZ9Y/aJ3Ml0zsR2Qr/Vg0dtQAjj1VWJpb8Xanx9LpmKRV/LSCpm9aga9+DiiTwJd+6/w9C3o9Q/UpbrRqX2oofALqUDgfDiSFt4/S9dX0QdWpamhO+8N9ioE/MVRTizGOdK/PuR/HzLzLclEcvMRJYHgwWXFYGKPBWuB0xd9HrvEGBc/Du2yd2B52nPO+0rd741Yv0FFnhsWgqX97NfOOgKkn26Jl+MHEFZ72sHvZAJmdzeW/1xxMEA/L+fxG2FlQUZBdg3XrSiMugZO5xGfKk16Jb46CeYNFZXDujaAEJLWmrfPIiLpFohwwAjrHBLSmYwt5bWiVTkvJPREe+t6wiN4TjIY8YpgkazwWBdMNGb4rggFfpyXkN5bMwxQHnUYJaAYyatlbpGXVGjUSI7hUYZoitJHpo9TXvgvPtNFxlnQb3Mcc00kLlWGYNdGgYFEjHnXJAHKMGVYnZRoNNe6lVOXm1C4oQs2pasPG3BrOHKx6adLHV7BhCT1WwBVF47tK6fEgDEEAwEDslkFHU+0TXsu74iqwm9VSac8AO8jkh1Fo1wTnkqnXvc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(36840700001)(5660300002)(54906003)(6666004)(110136005)(1076003)(83380400001)(82310400003)(36756003)(81166007)(316002)(82740400003)(8936002)(336012)(4326008)(2616005)(7696005)(26005)(86362001)(186003)(70206006)(70586007)(356005)(8676002)(2906002)(47076005)(478600001)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 03:35:07.7886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c885a16-a054-4b16-dce4-08d914f6f074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1185
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
Cc: alexander.deucher@amd.com, Jiawei Gu <Jiawei.Gu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 src/app/CMakeLists.txt             |  1 +
 src/app/main.c                     |  8 +++++
 src/app/vbios.c                    | 58 ++++++++++++++++++++++++++++++
 src/lib/lowlevel/linux/query_drm.c | 11 ++++++
 src/umr.h                          | 15 ++++++++
 src/umrapp.h                       |  1 +
 6 files changed, 94 insertions(+)
 create mode 100644 src/app/vbios.c

diff --git a/src/app/CMakeLists.txt b/src/app/CMakeLists.txt
index ca7d46b..462e4fc 100644
--- a/src/app/CMakeLists.txt
+++ b/src/app/CMakeLists.txt
@@ -35,6 +35,7 @@ add_library(umrapp STATIC
   pp_table.c
   navi10_ppt.c
   read_metrics.c
+  vbios.c
   ${GUI_SOURCE}
 )
 
diff --git a/src/app/main.c b/src/app/main.c
index 47ddb38..b484cf3 100644
--- a/src/app/main.c
+++ b/src/app/main.c
@@ -825,6 +825,11 @@ int main(int argc, char **argv)
 				asic = get_asic();
 			ih_self_test(asic);
 #endif
+		} else if (!strcmp(argv[i], "--vbios_info") || !strcmp(argv[i], "-vi")) {
+			if (!asic)
+				asic = get_asic();
+			if (umr_print_vbios_info(asic) != 0)
+				fprintf(stderr, "[ERROR]: Cannot print vbios info.\n");
 		} else if (!strcmp(argv[i], "--help") || !strcmp(argv[i], "-h")) {
 			printf("User Mode Register debugger v%s for AMDGPU devices (build: %s [%s]), Copyright (c) 2021, AMD Inc.\n"
 "\n*** Device Selection ***\n"
@@ -951,6 +956,9 @@ printf(
 	"\n\t\tPrint the GPU metrics table for the device."
 "\n\t--power, -p \n\t\tRead the conetent of clocks, temperature, gpu loading at runtime"
 	"\n\t\toptions 'use_colour' to colourize output \n");
+printf(
+"\n*** Video BIOS Information ***\n"
+"\n\t--vbios_info, -vi \n\t\tPrint Video BIOS information\n");
 
 #if UMR_GUI
 printf(
diff --git a/src/app/vbios.c b/src/app/vbios.c
new file mode 100644
index 0000000..98e0f87
--- /dev/null
+++ b/src/app/vbios.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+ * Authors: Tom St Denis <tom.stdenis@amd.com>
+ *
+ */
+#include "umrapp.h"
+
+#define AMDGPU_INFO_VBIOS			0x1B
+#define AMDGPU_INFO_VBIOS_INFO			0x3
+int umr_print_vbios_info(struct umr_asic *asic)
+{
+	char fname[64];
+	int r;
+	struct umr_vbios_info vbios_info;
+
+	if (asic->fd.drm < 0) {
+		snprintf(fname, sizeof(fname)-1, "/dev/dri/card%d", asic->instance);
+		asic->fd.drm = open(fname, O_RDWR);
+	}
+
+	r = umr_query_drm_vbios(asic, AMDGPU_INFO_VBIOS, AMDGPU_INFO_VBIOS_INFO,
+			&vbios_info, sizeof(vbios_info));
+	if (r)
+		return r;
+
+	printf("vbios name          : %s\n", vbios_info.name);
+	printf("vbios dbdf          : 0x%x\n", vbios_info.dbdf);
+	printf("vbios pn            : %s\n", vbios_info.vbios_pn);
+	printf("vbios version       : %d\n", vbios_info.version);
+	printf("vbios date          : %s\n", vbios_info.date);
+	printf("vbios serial        : %lld\n", vbios_info.serial);
+	printf("vbios dev_id        : 0x%x\n", vbios_info.dev_id);
+	printf("vbios rev_id        : 0x%x\n", vbios_info.rev_id);
+	printf("vbios sub_dev_id    : 0x%x\n", vbios_info.sub_dev_id);
+	printf("vbios sub_ved_id    : 0x%x\n", vbios_info.sub_ved_id);
+
+	close(asic->fd.drm);
+	return 0;
+}
\ No newline at end of file
diff --git a/src/lib/lowlevel/linux/query_drm.c b/src/lib/lowlevel/linux/query_drm.c
index d0c82d4..f4ab709 100644
--- a/src/lib/lowlevel/linux/query_drm.c
+++ b/src/lib/lowlevel/linux/query_drm.c
@@ -49,7 +49,18 @@ int umr_query_drm(struct umr_asic *asic, int field, void *ret, int size)
 	inf.return_size = size;
 	inf.query = field;
 	return ioctl(asic->fd.drm, DRM_IOC(DRM_IOC_WRITE, DRM_IOCTL_BASE, DRM_COMMAND_BASE + DRM_AMDGPU_INFO, sizeof(inf)), &inf);
+}
 
+int umr_query_drm_vbios(struct umr_asic *asic, int field, int type, void *ret, int size)
+{
+	struct drm_amdgpu_info inf;
+
+	memset(&inf, 0, sizeof inf);
+	inf.return_pointer = (uintptr_t)ret;
+	inf.return_size = size;
+	inf.query = field;
+	inf.vbios_info.type = type;
+	return ioctl(asic->fd.drm, DRM_IOC(DRM_IOC_WRITE, DRM_IOCTL_BASE, DRM_COMMAND_BASE + DRM_AMDGPU_INFO, sizeof(inf)), &inf);
 }
 
 #else
diff --git a/src/umr.h b/src/umr.h
index 4e730e5..41266e2 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -973,6 +973,7 @@ void umr_free_asic(struct umr_asic *asic);
 void umr_free_maps(struct umr_asic *asic);
 void umr_close_asic(struct umr_asic *asic); // call this to close a fully open asic
 int umr_query_drm(struct umr_asic *asic, int field, void *ret, int size);
+int umr_query_drm_vbios(struct umr_asic *asic, int field, int type, void *ret, int size);
 void umr_enumerate_devices(void);
 int umr_update(struct umr_asic *asic, char *script);
 int umr_update_string(struct umr_asic *asic, char *sdata);
@@ -1349,6 +1350,20 @@ struct umr_soc15_database {
 	struct umr_soc15_database *next;
 };
 
+// vbios
+struct umr_vbios_info {
+	uint8_t name[64];
+	uint32_t dbdf;
+	uint8_t vbios_pn[64];
+	uint32_t version;
+	uint8_t date[32];
+	uint64_t serial;
+	uint32_t dev_id;
+	uint32_t rev_id;
+	uint32_t sub_dev_id;
+	uint32_t sub_ved_id;
+};
+
 FILE *umr_database_open(char *path, char *filename);
 struct umr_soc15_database *umr_database_read_soc15(char *path, char *filename);
 void umr_database_free_soc15(struct umr_soc15_database *soc15);
diff --git a/src/umrapp.h b/src/umrapp.h
index 14457fe..1336e07 100644
--- a/src/umrapp.h
+++ b/src/umrapp.h
@@ -57,5 +57,6 @@ void umr_clock_scan(struct umr_asic *asic, const char* clock_name);
 void umr_clock_manual(struct umr_asic *asic, const char* clock_name, void* value);
 int umr_print_pp_table(struct umr_asic *asic, const char* param);
 int umr_print_gpu_metrics(struct umr_asic *asic);
+int umr_print_vbios_info(struct umr_asic *asic);
 
 void run_server_loop(const char *url, struct umr_asic * asic);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
