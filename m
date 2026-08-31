Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1C8C624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D10810EA8E;
	Mon, 31 Aug 2026 18:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yPntQGsM";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DFC010EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyrfqdLbG+OG0SRyhohvHfKUQKJ4L3Zt1t7FS2vg2YeD6aI54ujVU/8ShjYVfjO1tTNWDF2liKQlQto1agDeI0+Hhtpq3moN+s+eRuvb8Qi/K72KoNgxKetydh2ZtiB8usOgdy3scIUqRaUk9i+s+oWanLh0eLYt5WEr9bMGWcZaKsUfqDARgeykJnDN9XHbgJA82N4tqaDjvrctwMis1XjukmME5W8/DED8aTIOgizhM9mxCcoZSg9mfsjO/gx3OBd2pxdeAvQB0B1lihe2HT+rSWC/gH88z3cMNlHmcNbxW+XNRqJgJp91elOnv/uKrNqslXmNms2Ow4lWmrrgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yney1XmzorWTP9/fpq6Xv0V8vmsDEkzXFBY3NQA878Y=;
 b=PAqhM63qFG5pt9ZfjgQWumvsTPiostnvPhrxZr5enCEGIZnJwJSoDs2Rni9Ctrvev1lOn14jkilo+sgsT53/i3MamW3WS6fZtUVjm9myZsNysFBa/1M4hp2PrNR2OcgmDTTYbxcoSSb4s1QmsAIPUqfdH5/ymDL6tPj4ms8W3/2v0E6SK4F2FgaRmZu68qMXz2zxdNphYuHyRV4+dUwUhwCzxUSvP9rSB0YthHzJ4XtQjlmmCOiuyB8M5d7jJqXGTAnaAClOSkInrcgzFB6pI9plCSpgOKG1GALxo+STSgdZ9NL8VjHc1seT/tXx7BpK8CGQMSe2/H9POCRh7TCPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yney1XmzorWTP9/fpq6Xv0V8vmsDEkzXFBY3NQA878Y=;
 b=yPntQGsMzd/YGyVwb01jU1+uh6nYqcyJ8UV/dZRFUbzf+d9rjEMjwMEAZdde8JgZ4u9JDiOM3NwAqwpodb7YvH1EnPabC3h2m8IykaWE562ELxVgiZvZhcDcJOBIlhOIsxwA8fvZJTSPA1ZYPlILwOqvUogvQeb2IrQ9AwMVrTo=
Received: from BN0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:408:ea::12)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:11 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::20) by BN0PR04CA0067.outlook.office365.com
 (2603:10b6:408:ea::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 89/95] drm/amdgpu: Move ualink ip version related changes
Date: Mon, 31 Aug 2026 14:27:48 -0400
Message-ID: <20260831182754.1089811-90-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bc8750-2ae4-48ac-2506-08df078dc0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|3023799007|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZeCWh+QzTAnf71jVMwOuYCRNljq8kAUYiECsMs4e/0dnxAFW/iWx+weL+pxoUSpRK3konWm1gxLer8y/v8I/e/pWCYN5pk3XXlXvJbE+7SgVDX4d55i7evrfTaiZGJITqdg0PSRvSYCJzVPiz5IWUqNAsFMz75m+3k2QKiPW0jBRA5vhWfWaAhMCn8icbIMYn0/kkJy5KHigUm4cx7pJpeswnALbmloJfKrB1iXhZEjPQeqIEKoJwUGwrnnIiKB2gBl63/7ssEBoCTyVUrNn8zdmJt+zynfxW0FDfgWWxsL2I89YesruFOCv7fMElFdTcc41QHvcQMr1p0ZqmDQD+/vTQDTo8goy7S65NmsP2fFSVytf3+fu8YFE3PBWI2zSflsA0aeqnAZTMJHyE571lzX3R+j8lOpiJ3Vc8pKnEeWjcyipFm0pvApBWHs8ps2iEuJ4Leib1s6JBvd9+S49pJu2EslygA4Fd33PfYHYMWp3pNhUG10V5jEGy/cnh4XgEWaGxMzL2PjxAMMUiiiVVNaZpUiG9u/Vaiv2dD9w8DcZPb+YEjqPqw0+bCVpt6aa8bRS0y4yzvbUuMH1yQzd5O7N400X2wZOJ1yRyYDq3QVuOt5TTME4HW5BzApQOW1IVYeFEX8BDzTtCosB85kcHBbxrvgFiQKDzc1FGPcArtjk7kDa2oSDY//XWmKhkrZR3i+qSOKoQmqepJgPa0DiKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IlrHEfC+ya2bOdo+cLBnM9BYGX0Y3v5BJNjcPzkx+g5iq3aoHcPYYIVPGradARt7hIl3wyawFnfUSXTlTGNUGdnlvFQAUfbGb4UR0PtSXJqYMNTeqwm2VLZm7vF2RKv1qFWTTPGrU0fTpDBEIzx9w160uBn2qRI4l0c0Kk5/RaAu7IpHCn6tA2boxaerO8ECZ6sVRTHh6r26O3vbspFjnOEae2NiCcyUVRbPTUcXfwMW3C+9cQmReXYPsQYCeluMubqi5mLwKezcyPFDxvGN+vkoM0GuY7xalAyJQ/ugrRpAUHIO8DAzGrR3Jhoss+ABc8UrrP1/+ib+01ApApT/xvI2YFO6nx123clInZAXWYQeHBYwsJyzWczoOniww5xonz0jgIBEfObree1GqkiDGwU46DA/uLI2Fu56V2vCT/xlrG9wN3s20uSQXB1R14Eb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:11.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bc8750-2ae4-48ac-2506-08df078dc0b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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

From: Lijo Lazar <lijo.lazar@amd.com>

Move more IP version specific related things to ualink version file.
Use soc v1.0 IH client id defintion and define mpnht interrupt source
id in ivsrcid header.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 28 +++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h    |  4 ++-
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c      | 24 +++++++++++++--
 .../ivsrcid/mpnht/irqsrcs_mpnht_15_0.h        | 30 +++++++++++++++++++
 4 files changed, 63 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d7d74b1ae7fc6..5957a3a2c85b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1419,8 +1419,6 @@ static const struct kobj_type ualink_station_config_ktype = {
 
 int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
 	struct amdgpu_ualink_station_config *stations;
 	struct amdgpu_ualink_vpod_config *vpod_config;
 	struct amdgpu_ualink_ppod_setup *ppod_setup;
@@ -1460,12 +1458,6 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->ualink.config = vpod_config;
 	adev->ualink.stations = stations;
 
-	r = amdgpu_ualink_init_interrupt(adev);
-	if (r) {
-		dev_err(adev->dev, "Failed to add UALink irq: %d\n", r);
-		return r;
-	}
-
 	return 0;
 }
 
@@ -6012,32 +6004,28 @@ static const struct amdgpu_irq_src_funcs ualink_irq_funcs = {
 	.process = amdgpu_ualink_process_irq,
 };
 
-/* TODO: if move to header file soc21_enum.h */
-#define UALINK_IH_CLIENT_ID 0x1C
-#define UALINK_IH_SOURCE_ID 0x0
-
 /**
- * amdgpu_ualink_init_interrupt - initialization of UALink IRQ
+ * amdgpu_ualink_init_interrupt - register the UALink IRQ source
  * @adev: amdgpu device pointer
+ * @client_id: IH client ID for the interrupt source
+ * @src_id: source ID for the interrupt source
  *
- * Registers the UALink interrupt source with the IH (Interrupt Handler)
- * subsystem during early device initialization. This sets up the IRQ
- * callback functions for handling remote interrupts from peer GPUs.
+ * Registers the UALink interrupt source with the IH subsystem.
  *
  * Return: 0 on success, negative error code on failure
  */
-int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
+int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
+				 unsigned int client_id, unsigned int src_id)
 {
 	int r;
 
 	dev_dbg(adev->dev, "init ualink irq client_id 0x%x src_id 0x%x\n",
-		UALINK_IH_CLIENT_ID, UALINK_IH_SOURCE_ID);
+		client_id, src_id);
 
 	adev->ualink.irq.num_types = 1;
 	adev->ualink.irq.funcs = &ualink_irq_funcs;
 
-	r = amdgpu_irq_add_id(adev, UALINK_IH_CLIENT_ID,
-			      UALINK_IH_SOURCE_ID, &adev->ualink.irq);
+	r = amdgpu_irq_add_id(adev, client_id, src_id, &adev->ualink.irq);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index e23aaf8b313e1..792b0fc9fed97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -388,7 +388,9 @@ struct amdgpu_ualink_mgr {
 	unsigned long drop_msg_bitmap;
 };
 
-int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev);
+int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev,
+				 unsigned int client_id, unsigned int src_id);
+
 int amdgpu_ualink_sw_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
index 0fe2c0fba4cf9..58cf98ac94add 100644
--- a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
@@ -23,6 +23,7 @@
 
 #include <linux/delay.h>
 #include "amdgpu.h"
+#include "ivsrcid/mpnht/irqsrcs_mpnht_15_0.h"
 #include "amdgpu_ualink.h"
 #include "ualink_v1_0.h"
 
@@ -104,11 +105,30 @@ static int ualink_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int ualink_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = ualink_ip_sw_init(ip_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ualink_init_interrupt(adev, SOC_V1_0_IH_CLIENTID_nHT,
+					 MPNHT_15_0__SRCID__REMOTE_INTERRUPT);
+	if (r) {
+		dev_err(adev->dev, "Failed to add UALink irq: %d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
 static const struct amd_ip_funcs ualink_v1_0_ip_funcs = {
 	.name = "ualink",
 	.early_init = ualink_v1_0_early_init,
 	.late_init = ualink_ip_late_init,
-	.sw_init = ualink_ip_sw_init,
+	.sw_init = ualink_v1_0_sw_init,
 	.sw_fini = ualink_ip_sw_fini,
 	.hw_init = ualink_ip_hw_init,
 };
@@ -119,4 +139,4 @@ const struct amdgpu_ip_block_version ualink_v1_0_ip_block = {
 	.minor = 0,
 	.rev = 0,
 	.funcs = &ualink_v1_0_ip_funcs,
-};
\ No newline at end of file
+};
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h b/drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h
new file mode 100644
index 0000000000000..c960353f107db
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/ivsrcid/mpnht/irqsrcs_mpnht_15_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __IRQSRCS_MPNHT_15_0_H__
+#define __IRQSRCS_MPNHT_15_0_H__
+
+/* MPNHT remote interrupt */
+#define MPNHT_15_0__SRCID__REMOTE_INTERRUPT            0x00
+
+#endif
-- 
2.55.0

