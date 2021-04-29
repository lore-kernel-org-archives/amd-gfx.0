Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A6C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDB661445
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDB661445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9312B6EC85;
	Thu, 29 Apr 2021 06:26:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B346EC85
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkdKbxSsMNlUirL94H1LPrY+mBuRMbTbSTua9yPtL73m/BrRudoCEROq8wpvOHF18CaNyg5FtqR7Bw4f237zyrHil6JjStk3rwYmLNf1LoJze+i18MUnJP66E82juZUUNzX/uheqwOP0u4KdQtQF79HIpwjVGtzkdnLrGm8jzFp8CXJ2Mg0e96ttSIV8euQaIB+3gQQn6K1O59pngOEyV/tIXWeX+GoSqlEOiHzQV45p7Jb+yJ4HAcG4MR7DQurmfgConjgw39tCjkMpTyQmhZU/a5Nr//OtuNXs8zXTDSCM+2KiAooeZE3dxC9SbH9pUlemO2NNf7WkcvC99YWYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KeQYn7+u3Pz1bP/iNwUdNOLDmNf57Cp8e8B7n0J17Q=;
 b=nCwBCfWJHjSFHNxIXEeRAuSrcgVstl+VkvPNQCZEcl4r8ca9YO5Q6sgPkLsm8Bn+Pf8tHIYOUPbN7JZ6h62rF4fRBSjLCM1eAsUsaSLNqHmObpxHbLO/yv0QU63UPBdg2BUg7kUH7sU2/LHBu0uq8j+bj1RHjjOL4+hX+hAcVdBicIbTN+edxDfAYCx142tEs56PemMu6AvoGkcl2R6eLKrkWJYOBVExQmoGwp1+n+ghtoHFoIoBQF40eBekAs9A9aSaVdXGtys09h/R2kcC9gEV++ZmyRSXll7OcBOHHYKn1cqpoYh+faVo30rCVLViiDxNqxueNyD6lgmoDRB7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KeQYn7+u3Pz1bP/iNwUdNOLDmNf57Cp8e8B7n0J17Q=;
 b=Jv7B79u9/126iv8FDKNFn/M5dRH32Oerylts2e0x7u1ILhny9v/IA0BRwBBxXIoFqnmsnn4yQj26atdGw1K901AdyJ15wuPrMvhxevaT3cfD4iTYe/AgRSovLNDyddQKvD+QddpBB37D3Ubik/AvnDum03VjXulUncC8CwYigXg=
Received: from BN9PR03CA0563.namprd03.prod.outlook.com (2603:10b6:408:138::28)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 06:25:57 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::c) by BN9PR03CA0563.outlook.office365.com
 (2603:10b6:408:138::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 06:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 06:25:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:25:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:25:56 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:25:55 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: add helpers for hdp ras init/fini
Date: Thu, 29 Apr 2021 14:25:41 +0800
Message-ID: <1619677546-2630-2-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f3663b6-1834-446a-a9e9-08d90ad7a682
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54007C0CB336410E99F66E6FFC5F9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oupZPcVbjCwUXJXf695rXHNHx5dMmYtJ96VrcBjK6sHDSEjAsHdNCbfSf2fbEFCFDAeW23MIemMiAnqqbM0lCgdorzfmYMiRs1hOxvWMkw4YrwQEQ42ndZIMTzHIFkY4tdUYXQ9fYHW1iISqORu3MrZjBho1Lphpaf4E1FZQT0DX4invAtoYFODBkuvq/FhscrMj3jMbw7V6aLVawAtN/+SyMI7UDkNT1WKMSia1N/p4EJt4CB/ltHCr5jBtcKrj2ki0UVw5szimjPBDC5KMd/xHIPCF7GPYNxZB3eFpKMvj/rn+bLtzNmKNolVeKRIQMPg/2BZILp2BPJAa5OeLeC5/xmX4RV24I4WzbGafdiD1iG2m+TrQTa62Pi8DjJMUa7JL+GJAO9bnodmsj+8lhhEQ9+sM2kvHijN5QcYR/dYLOH73wy87BoCXRNuWOBQTy1oTwaQHRTu5RNOSxtZsEmJglvz0Y0Bf+QiRLcB8+y7EFZOH6Un+UdGc09R41MGtBRH7iVCEJ/nWcmC+25iDpwLneDl/6dSdOb3uZ0JdWSi/NPRA15NpFrGXrnwkXShFXzI/q4/HwfqvQsyo93lxtwv6a5Qg8qpNgntjf1TCdywz+dosxZdxDrOVYAYljB6VaeEVbXZLWYAV9XB9/g974T0hie7jHAuj7jESBnKMnIctQ7LlGMldkkbN9dXsIEq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(46966006)(47076005)(426003)(82310400003)(478600001)(110136005)(8676002)(82740400003)(316002)(26005)(36860700001)(186003)(81166007)(4326008)(336012)(86362001)(70206006)(70586007)(36756003)(7696005)(5660300002)(2616005)(356005)(6666004)(8936002)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:25:57.7013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3663b6-1834-446a-a9e9-08d90ad7a682
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

hdp ras init/fini are common functions that
can be shared among hdp generations

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 69 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 +
 3 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ee85e8a..418e674 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -56,7 +56,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-	amdgpu_fw_attestation.o amdgpu_securedisplay.o
+	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
new file mode 100644
index 0000000..1d50d53
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -0,0 +1,69 @@
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
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_ras.h"
+
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev)
+{
+	int r;
+	struct ras_ih_if ih_info = {
+		.cb = NULL,
+	};
+	struct ras_fs_if fs_info = {
+		.sysfs_name = "hdp_err_count",
+	};
+
+	if (!adev->hdp.ras_if) {
+		adev->hdp.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
+		if (!adev->hdp.ras_if)
+			return -ENOMEM;
+		adev->hdp.ras_if->block = AMDGPU_RAS_BLOCK__HDP;
+		adev->hdp.ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->hdp.ras_if->sub_block_index = 0;
+		strcpy(adev->hdp.ras_if->name, "hdp");
+	}
+	ih_info.head = fs_info.head = *adev->hdp.ras_if;
+	r = amdgpu_ras_late_init(adev, adev->hdp.ras_if,
+				 &fs_info, &ih_info);
+	if (r || !amdgpu_ras_is_supported(adev, adev->hdp.ras_if->block)) {
+		kfree(adev->hdp.ras_if);
+		adev->hdp.ras_if = NULL;
+	}
+
+	return r;
+}
+
+void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)
+{
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
+	    adev->hdp.ras_if) {
+		struct ras_common_if *ras_if = adev->hdp.ras_if;
+		struct ras_ih_if ih_info = {
+			.cb = NULL,
+		};
+
+		amdgpu_ras_late_fini(adev, ras_if, &ih_info);
+		kfree(ras_if);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index c89cf8d..ba6f272 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -47,4 +47,6 @@ struct amdgpu_hdp {
 	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
 };
 
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev);
+void amdgpu_hdp_ras_fini(struct amdgpu_device *adev);
 #endif /* __AMDGPU_HDP_H__ */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
