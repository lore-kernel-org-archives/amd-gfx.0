Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F9AC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 14:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F1010E1B9;
	Tue,  2 Jan 2024 14:17:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA0810E1B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 14:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqNeUzt1Vfikvye/lq9O7PnP+N7qhFiRbZIXSe2Nl6jLRI37k+0n/HmtdiUpOS8yI0g49ZRpdYLlFYe+vkVlOKZm6Kvu3odhqg8PuihhdG6DXsZQsFzY3YD8AHD7sPLYMJEcjXrlH6ilPkLApxP0WqK/eKDOcNPO+krOMwWXOV5EKddcrtvlHAQZeq5bBnnTFgpgD2h3xtzd3nTNPO1QJzPEwLZ6+gb7pJEfT0uEb0IAQIHRA1CoIMzviT36dNB8NPUwwTTw5XnXnHiVmPzYD52alezlNg2FFH4lPZEtbhkrn3qbRNyFV4/UBMK+SQs/iAe7hyphJqRLSssUBFybFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IzD2qwtHt/L9qQst8nYHIxT/xw7kWyO8mDJktJ79fc=;
 b=QW8XhOQR+qPGt9qVqBZqPImeLrHDQ97uwOtnIMM2yl5OcRCVt8M6+Yt/BlpsiK9rxzsET81RL97k2LMcHdzbPUbNtOTW0DrcwDxnuUb3OdX3HdpSsd4Y1O2kMWDX1eewyVxYiRVVP5ZMhVWc5pnOv3Wcxu36xYBEDvE2/az1c7R5bjZXnbS3p82aQmUJ7ELjiuTRNQCtVKA3KNW/efjQXeuSIi4vElE3zyA3KYsuYU3//BvUU24tbzoDaL4T4bOE27Hfvq414JRxq4DLZ5jtdlGuyzD7OxP7XzSyS5MWRG8A2wW8gX/i/iuSrUODal0zGcpw/rYybwBDHGfwLu6oQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IzD2qwtHt/L9qQst8nYHIxT/xw7kWyO8mDJktJ79fc=;
 b=tgVmmV8BjtMUVX2HKu9iSxtpBuY0X8W2w+nEpqOSJ2O9jde48z5nKu1fAl6QzF4vWC8haulk+kbYVPTd/HxTr0w9LjStfWpZXzJSn+fnmMehNHkwLlAnFnS4SZnMYc95mY1/0ssaUHfpYFGY09gpsWIO8q3ERKGarkXep+32Iz0=
Received: from BLAPR03CA0034.namprd03.prod.outlook.com (2603:10b6:208:32d::9)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:16:59 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::f0) by BLAPR03CA0034.outlook.office365.com
 (2603:10b6:208:32d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Tue, 2 Jan 2024 14:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 14:16:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:16:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:16:42 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Tue, 2 Jan 2024 08:16:40 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: Query ras capablity from psp v2
Date: Tue, 2 Jan 2024 22:16:20 +0800
Message-ID: <20240102141621.29700-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102141621.29700-1-Hawking.Zhang@amd.com>
References: <20240102141621.29700-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bac253e-ce0f-4666-4d25-08dc0b9d7b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sB8MJyWZoaMUYocqsEG+fnpbfrYWJU/H52EPpZks7AamSPGgMjRJS3YoOGT8NTT7j06l7kZJ+xNYeGrUErhPT4kJNLndu7hh8ikmRX5brgfxm1aYcqm/CJfeFe+XNehlPVzQRxNVZg3q9w6n9XlPRjQaDyT+Y9wBWbhy6u71VUYyDgJbOAaRi2ctWZ5mxaR5MjQCHAFb5bASE9hYKUt4tR6qR9T3QDe1Y9I2cUsqGtLmcAuQPxsam02oRPWYO6DG0MBQcg7D/rQnaBJHnjJvLWoHsxpSjwFPGWexeoQQ5nZf8863r4n0lOAUh7zi0v4c/HxzYWKIEBfY82vOK1Ee4FikBBOFqnSpHD7ltdWuqZLOUgfWBqEbJr9Aq9rzfGEplWnHO1Qkg/hT/+VGHcPlKTzyatmZnatkLxqooL9msD8QzNvSFp71QXw/bUqCjYd4ZsV3j0k/5sCr7qkkTz7dTW9aKvUqCHU6dm0onZ8XyDctk2PjZeg7OIZ4341C1+vxYEX99LnBhKkpOPZ6jh6jq2ak0XOnZtHgskckV0rAKttqDge7Gk0loDbLuh5JwW9eJ5ZhWjdnetVV0qcpmXFPW41KzV4CkEgkzm7v8R2zOlI8JwCTS5AWqKBqqUXgHaONJaxfUVHSJHA0hee2JFb2yCu5IPWE9MHMZ5GpIOwqg03MgG8arQ9PHWWbtzib5tdQyTMdFGsoF6JZI29LqjmzzKKuBxLLEcCPhz9mjotOEZOw5hsQwageBVf4EaEEcRh0zXMfvkSRXIgFsCuOrEwo/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(47076005)(2616005)(26005)(1076003)(83380400001)(426003)(81166007)(82740400003)(356005)(336012)(36860700001)(8676002)(5660300002)(8936002)(316002)(54906003)(110136005)(4326008)(2906002)(6636002)(41300700001)(6666004)(7696005)(70206006)(70586007)(478600001)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:16:59.0608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bac253e-ce0f-4666-4d25-08dc0b9d7b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of traditional atomfirmware interfaces for RAS
capability, host driver can query ras capability from
psp starting from psp v13_0_6.

v2: drop redundant local variable from get_ras_capability.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 26 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0dc8686e54f7..af3bc36aef18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2128,6 +2128,16 @@ int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
 	return ret;
 }
 
+bool amdgpu_psp_get_ras_capability(struct psp_context *psp)
+{
+	if (psp->funcs &&
+	    psp->funcs->get_ras_capability) {
+		return psp->funcs->get_ras_capability(psp);
+	} else {
+		return false;
+	}
+}
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 09d1f8f72a9c..652b0a01854a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -134,6 +134,7 @@ struct psp_funcs {
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
+	bool (*get_ras_capability)(struct psp_context *psp);
 };
 
 struct ta_funcs {
@@ -537,4 +538,5 @@ int psp_spatial_partition(struct psp_context *psp, int mode);
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
+bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 676bec2cc157..722b6066ce07 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -27,6 +27,7 @@
 #include "amdgpu_ucode.h"
 #include "soc15_common.h"
 #include "psp_v13_0.h"
+#include "amdgpu_ras.h"
 
 #include "mp/mp_13_0_2_offset.h"
 #include "mp/mp_13_0_2_sh_mask.h"
@@ -770,6 +771,30 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct psp_context *psp)
 	return 0;
 }
 
+static bool psp_v13_0_get_ras_capability(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	u32 reg_data;
+
+	/* query ras cap should be done from host side */
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+	if (!con)
+		return false;
+
+	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) &&
+	    (!(adev->flags & AMD_IS_APU))) {
+		reg_data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
+		adev->ras_hw_enabled = (reg_data & GENMASK_ULL(23, 0));
+		con->poison_supported = ((reg_data & GENMASK_ULL(24, 24)) >> 24) ? true : false;
+		return true;
+	} else {
+		return false;
+	}
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
@@ -792,6 +817,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.update_spirom = psp_v13_0_update_spirom,
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
+	.get_ras_capability = psp_v13_0_get_ras_capability,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.17.1

