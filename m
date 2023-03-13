Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B58C6FD19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0538610E463;
	Mon, 13 Mar 2023 01:44:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F63C10E463
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK32uHu5EaEhR1ponYBLI9/JxKa+hn6DfJSNcnJ85cP1VNkDZVsyeVBJ5nQpEtnJKVDcH81gtvJZk9zOo6/lx9hhUaeyI/pHV3p/cyBtWTwMb6u3+oagVJC+v4kqig2p8WCdoifvPxYUCSizdyxzb2D7cSWzUy3GtR1CyJ54s9fd0tn0rQYUCmm2uJ3/kCQcvBupT1P/ut+/Cna2P1FClpWh7ypGSUPoFcDTY/WsQjrQpCz2WEeGHeTGq3qpuC2zsDqtAwkf9tCDcnhfbrjpgguGpM5TG+aZxKQcNmuvtuKQrHl+xDTUWu/pfS20y3PiMgdueZLFpq3odaxdgBYnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3H+D5pZd0u3KgBVEUiBySdCWkLTpecYjdoUUxzL5/Y=;
 b=IoMQ9gLNndSkdSGleH4sbIt7kwiGH/Fc7oEEf+P5g3Onw8GGlQ/50k9zbbIilX1iDA5wpiZC5UvQZ13igF9hFzivIoNlkFMXsTyExLLzDGBLOIzpoOsor762wePLf6o0bIjiPlARPUtOkkg+fg5OaRq8tf/3obKJpbj930TydoNltTlgSFHtEjgox+u15gsxAcYCnC8eJuKLpOMBWCAs9etbOry0THMo/QABhCs9+MdI64YbQZMuuokkKVMyGoEpGhWCACbMVWo90HoK+ZHYxOsX4n/VnUJM4l/mWCmGQMi5Hhi7DtWbUhu/22EsSqIq2SIatADyG1xvYo1gxEdq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3H+D5pZd0u3KgBVEUiBySdCWkLTpecYjdoUUxzL5/Y=;
 b=1L4w015ZfWSaSR0LE98yNi+wjKQa8zSTzIbawse/ZKJdlQ7VFPEnIXEeISOSl9lAZUFBEm88CLzbzlxe+PIqZ+lz1frgOdT40XhIIxLZB7tbYb67THhCBjja1jTTF6bVE5w0hYtx/LfUgWHRFCrcTcYScJtCS5EenTZZ/lDSmRA=
Received: from BN8PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:70::40)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 01:44:47 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::12) by BN8PR04CA0027.outlook.office365.com
 (2603:10b6:408:70::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:46 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:44 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 06/10] drm/amdgpu: Move hdp ras block init to ras sw_init
Date: Mon, 13 Mar 2023 09:43:59 +0800
Message-ID: <20230313014403.21903-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313014403.21903-1-Hawking.Zhang@amd.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: a38f9434-a596-4624-3340-08db236486e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7aVbWhQCgVnqq6aiCFVZC+xNwbNZiRoJJKd7JZm+Wbu3xNGb1p+r0Nw1ea1YGjQ64Hp2fXkXLQYetbvbJTBmrPBaiyt0YHKaNxI3YOjFQ+sTzQYFiBNv8/0Gcb8OVDzLfYOfgLXEDqG+eMeUNOesepADGW1QrF3tLsL1ujzuur9hE3re7snYFKY7oVKCfczI9rYD961xfojWgxCJOvKiwe+spMedrQyvX2hORSFTFKyGifFS8YSMJDx4TEAtcMnDMjBEsacb0IDvhpij56Y8H8gGvlFF1527ReKl8y9EnB2djEEDWrRvJpBmWbNThatVNROJbsDyqMajJhog1vv0ASdgf5oO/ww3g+K5zOXmeBtMAuD6OwkHlY6OIRDqkks2e5pIaJpirT33Q0U6+0iKXgg3lChAlrSDmwNUkAp0Ihr5+jjqM8l0P1MqzyhGLkhKYkpXasE+sd7q0J02Ld+qD+DiXQ2IYUNWMgPQ1qtZQnLNuqr5BjHYkGOMhFlXo9Jvq3Sh1L4Qch2MMX0xFjXqNmXikL9SRpoEfpvSsqkMSx027wxOoQcgMl72LQi06Zl3jRRGFkqdFZvWkCQ64pw3+SyYmiZnuriTP8rHVesvhez3BApaEPiRGEztYNQsGMjvp053L5QCHKHJrwSu3YyLoXXD/adFMcyXqYREf384wHBXJ2nhw+x+qtRj6+KPSIo5xx/scolvRCKxrxfwpde/sxq6eUPRzpen6uQRIUWcz8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(40460700003)(36756003)(83380400001)(47076005)(426003)(478600001)(82310400005)(6666004)(1076003)(26005)(2616005)(336012)(7696005)(16526019)(356005)(8676002)(4326008)(70206006)(70586007)(40480700001)(8936002)(186003)(41300700001)(86362001)(6636002)(316002)(110136005)(36860700001)(82740400003)(81166007)(2906002)(66899018)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:46.9589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38f9434-a596-4624-3340-08db236486e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize hdp ras block only when mmhub ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_init.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 48 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   |  5 ---
 6 files changed, 55 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 00c33ce38761..5f9ac1bcb6bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -54,7 +54,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
 	amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o \
 	amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
-	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o \
+	amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o amdgpu_hdp.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a15bc513dd67..551884dc5245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -460,6 +460,11 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	/* hdp ras block */
+	r = amdgpu_hdp_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras = &xgmi_ras;
 		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
new file mode 100644
index 000000000000..b6cf801939aa
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include "amdgpu_ras.h"
+
+int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_hdp_ras *ras;
+
+	if (!adev->hdp.ras)
+		return 0;
+
+	ras = adev->hdp.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register hdp ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "hdp");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__HDP;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->hdp.ras_if = &ras->ras_block.ras_comm;
+
+	/* hdp ras follows amdgpu_ras_block_late_init_default for late init */
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index ac5c61d3de2b..7b8a6152dc8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -43,5 +43,5 @@ struct amdgpu_hdp {
 	struct amdgpu_hdp_ras	*ras;
 };
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
+int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b3bb70210122..9a333f9744bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1361,8 +1361,6 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->hdp.ras = &hdp_v4_0_ras;
-	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
-	adev->hdp.ras_if = &adev->hdp.ras->ras_block.ras_comm;
 }
 
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index ee09cf1b8e4f..71d1a2e3bac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -161,11 +161,6 @@ struct amdgpu_ras_block_hw_ops hdp_v4_0_ras_hw_ops = {
 
 struct amdgpu_hdp_ras hdp_v4_0_ras = {
 	.ras_block = {
-		.ras_comm = {
-			.name = "hdp",
-			.block = AMDGPU_RAS_BLOCK__HDP,
-			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
 	},
 };
-- 
2.17.1

