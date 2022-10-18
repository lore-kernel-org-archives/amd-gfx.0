Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943A5C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 08:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C2410EEE4;
	Tue, 18 Oct 2022 08:33:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2E010EEE4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 08:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAILEIs9I+FcT3s43isYUXIFDXZ2qKQSfWVlDGouaoeHj/nCys6tjthARedfx41fqWoLGoMjwJn3ElYKdcVzzbBppnadAA0qbQ2k4PWSp1G+Akdvo3iKHLIOSGFnB2mx73CXD6D4Zq8d/Omq41EEzcEPo1Bm/zh4QRLZBVexbnBIjoFUSFvSFh1i2u9kJU0I58Lm8H8A4iLmm0+y9WYUS4MdUfIOeS/tsuJPC6o0UFga2JAQkQ+hTnDMY1esLeSq/EhfiOuAE0SuxdPuG2/BIJUiVYcQqLE3iuVwtOitnqvz2R81FVKZNTuD5G4CZi/3LTb6ucEhar8gETJ61ixUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGiBuMdw2rw8GxQMBXiZslv9bFnZFAOFOe0wyLbVFzw=;
 b=UEm99rfpvJniwzuhGP4GbQzXibZkq6JnzsDurPQ9I+D0e6bHjt0GXozTCpVMcVooZEUkXdmwJJJAPgwEHVpe+BHvX26wymJlVkDnstBh42se+FgqqQQzOG5y9LulHS1tMjdsA4N2V6cqKm4eppfxjE/6opUI4Z07Tg1312bscOWBEjXPiHe/qfvEonRqyM5CDGg4oBREy/qCZDFADX6+T9L3EGc54y36jRBy6KPDwSa/1LOHra4X3QTRsYEDj5B/pDWPBHFcZsCRX7PjFSNOqwdsh3ZojxKCyoBuagUQV3+8yUcCZizU13V0Qe3tCFFDB+r0frEqM9SL9muEuJmqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGiBuMdw2rw8GxQMBXiZslv9bFnZFAOFOe0wyLbVFzw=;
 b=i0SY9YYwGDUS7HCYuKegFcmv7W6idC6ze/eKlubMklSp4FEqOIFFScqLtFFvRZ2eoNI3b/wq2QCVfW0leK9TXiHLVPo8H4+48CeHKsIVXsWJwGwrXYRfIYH2qofXoJdiwC2/RaNyKm0oIGJsP+Os0CihLbeKsPsydd9EL0FFcbY=
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 08:32:53 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::fa) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 08:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 08:32:52 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 03:32:40 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Date: Tue, 18 Oct 2022 16:31:57 +0800
Message-ID: <20221018083200.15597-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: a76e0094-e230-42a7-5de2-08dab0e35917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GONdqe9s6rWXGlPuRJNVibQhTXBEhdZnOjbqQruP9YpRdW3Ng7iuvdwUhahZoJotjWED5lqOdOTQjNsX29hETbex3dDQiYS1NioMOJe2yJCt/x55He3pkHOjdZePG0oznMhh3jqHPf3Gtdpxga61d9YdVG9y8YAS7y2ektA1Ra+5cyWaiSGsDjhlLC4ornA6iF8Ivq7jJXLredh84lzNabf/e7bTkyMbFjn4sIw3lLDZ7Y+DIJvqMhQ2Ie968w5Qg1UrS96B3qgF9lJv/mUqZLACqxBsBPhlx9aohLdXhcN2u/BPV9DZ29vhu9plsRMnS3wK/9bh0r1zHIVp/TctIg5TzWDkaYw94/HwyhgkwIjUjJQ7a/BLzHaZ1cQzMQFEHCZwnEQqgyhj77xCWGaXL2zI6oAF5bLk9r9UH/n6KPaWbxfNtHpFH6SMnvNnpoulis54O6HnkybycrvbvXY8qczIe5NohGpM5Wzs8wA11R10D7PKsMS8xIwB1xF9swL+SXSE2+VHwhlq3jAu7EMwz6y0l5w0RnopX+otWEcY8E2EWDeOq9bfls6JfNXObL2nLbPpQgSDZarK/e7FFeAHg1jXsLOx5y+dzz6ecFq1EBHj84o3WLTEhrLHGC9tIZ7nxRxfMzIajMt3VuYsqbn+gjkK+XVIwxMDXSTbo08TK50gYE7vySTIda3QRis+i/4mCwQZE62gsf/eDyi0pM+7BC000N8IHDeU1eFSbnqNVFcxTiVRwy1d9WFXZih0AY6O0mcUk6RGcVZJiYK3c62NXITjTJ1z0k+Xv5+Wk6NH64/8U5FQk5a/SXgcd3kUogL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(6666004)(40460700003)(7696005)(478600001)(26005)(36756003)(2616005)(186003)(1076003)(16526019)(336012)(47076005)(426003)(2906002)(83380400001)(40480700001)(86362001)(6636002)(36860700001)(316002)(110136005)(5660300002)(82740400003)(8936002)(70586007)(70206006)(356005)(8676002)(4326008)(81166007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 08:32:52.3396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76e0094-e230-42a7-5de2-08dab0e35917
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define page retirement functions for MCA platform.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 112 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   2 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |   2 +
 4 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index aad3c8b4c810..e97b1bd343ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -22,6 +22,118 @@
  */
 
 #include "amdgpu.h"
+#include "umc_v6_7.h"
+
+static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
+				    struct ras_err_data *err_data, uint64_t err_addr,
+				    uint32_t ch_inst, uint32_t umc_inst)
+{
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 7, 0):
+		umc_v6_7_convert_error_address(adev,
+				err_data, err_addr, ch_inst, umc_inst);
+		break;
+	default:
+		dev_warn(adev->dev,
+			 "UMC address to Physical address translation is not supported\n");
+		return AMDGPU_RAS_FAIL;
+	}
+
+	return AMDGPU_RAS_SUCCESS;
+}
+
+static int amdgpu_umc_ecc_info_query_error_address(struct amdgpu_device *adev,
+					     struct ras_err_data *err_data)
+{
+	switch (adev->ip_versions[UMC_HWIP][0]) {
+	case IP_VERSION(6, 7, 0):
+		umc_v6_7_ecc_info_query_ras_error_address(adev,
+				err_data);
+		break;
+	default:
+		dev_warn(adev->dev,
+			 "UMC error address query is not supported\n");
+		return AMDGPU_RAS_FAIL;
+	}
+
+	return AMDGPU_RAS_SUCCESS;
+}
+
+int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst)
+{
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+	int ret = AMDGPU_RAS_FAIL;
+
+	err_data.err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+			sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if (!err_data.err_addr) {
+		dev_warn(adev->dev,
+			"Failed to alloc memory for umc error record in MCA notifier!\n");
+		return AMDGPU_RAS_FAIL;
+	}
+
+	/*
+	 * Translate UMC channel address to Physical address
+	 */
+	ret = amdgpu_umc_convert_error_address(adev, &err_data, err_addr,
+					ch_inst, umc_inst);
+	if (ret)
+		goto out;
+
+	if (amdgpu_bad_page_threshold != 0) {
+		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
+						err_data.err_addr_cnt);
+		amdgpu_ras_save_bad_pages(adev);
+	}
+
+out:
+	kfree(err_data.err_addr);
+	return ret;
+}
+
+static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
+		struct ras_err_data *err_data, bool reset)
+{
+	int ret = AMDGPU_RAS_FAIL;
+
+	err_data->err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+			sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if (!err_data->err_addr) {
+		dev_warn(adev->dev,
+			"Failed to alloc memory for MCA RAS poison handler!\n");
+		goto out2;
+	}
+
+	/*
+	 * Translate UMC channel address to Physical address
+	 */
+	ret = amdgpu_umc_ecc_info_query_error_address(adev, err_data);
+	if (ret)
+		goto out1;
+
+	if (amdgpu_bad_page_threshold != 0) {
+		amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
+						err_data->err_addr_cnt);
+		amdgpu_ras_save_bad_pages(adev);
+	}
+
+out1:
+	kfree(err_data->err_addr);
+out2:
+	/* trigger gpu reset even error count is 0 for CPU MCA RAS,
+	 * MCA notifier is responsible for page retirement if error
+	 * count can't be queried in poison handler.
+	 */
+	if (reset) {
+		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+		amdgpu_ras_reset_gpu(adev);
+	}
+
+	return ret;
+}
 
 static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 		void *ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 3629d8f292ef..659a10de29c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -98,4 +98,6 @@ void amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		void *ras_error_status,
 		struct amdgpu_iv_entry *entry);
+int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 72fd963f178b..b0da50d03af6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -252,7 +252,7 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	}
 }
 
-static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
+void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 105245d5b6e5..24382e9e5814 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -74,4 +74,6 @@ extern const uint32_t
 void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
                                     struct ras_err_data *err_data, uint64_t err_addr,
                                     uint32_t ch_inst, uint32_t umc_inst);
+void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
+					     void *ras_error_status);
 #endif
-- 
2.35.1

