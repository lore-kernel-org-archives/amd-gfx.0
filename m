Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45454C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD6210E60F;
	Fri, 21 Oct 2022 07:36:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B928A10E60F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 07:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIQR4U9LyfkRS43T41uxbrKXpJ+U74VQjsBAYA1kmdp8ULgFPfnj1ZC+oAG51C8C9SauWJW9yEBH2Ym8Z36VHsyqSz3+417erbsQVX1GUe/9vf7EtmVzrM7N6tnUcjZ60vMt5PXWcMWC6Vx5dziQFZENs7BZ4DWLrhKd99bbg4UL9CS08hvBSKTy8kzxh0+4fmU9RAq2uvyNuArmSqgW53I9RPVCi+SdFeDwHzR6TZoNApjEYEvF1FFCo5ofeQKd/xHajWS4dXFQHLR/iaS3U0m/ZxJrUtCkR+ky5SzFsdY/CDo01yiSjSpifHl1YVqehtRTsh0VjeYlY0ygWvoRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY4WQvXC/woeNQ4DqgdWjoQffbTs73xpdPSGdMqJBmU=;
 b=GSMYjn02gMOOolI5t1GXoNxo3GryoL52Kb2gPRLJK/KE2PaOU0M8I5IpnxLjAJDyYYcYrlJUfF7itUFeGVM3FAURaNjU3ndSxQ66xAbWT4vzi9+HNy1xwVskfoTetgeqk01f+cE3MRB0fD8vT7O1SKX9iPK5CygTgxYM8KPOVqzHeVbhz968wbY9+MUVpXdEg0tQgZXqMlgKaVeCERTWc0MxDZJ63Cfaege678J7REVROupAPV0gc5AVzlakuRM0xY+4LT148ln25XJqeRvI6wi4fZurkeggbSUnyIER+zDILx4Zf63p6GMTuBjxqgMRJx4rni/f+pglussqAUEyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY4WQvXC/woeNQ4DqgdWjoQffbTs73xpdPSGdMqJBmU=;
 b=ltqOC5iaD9DqfZMoLcztxAcCFxz1AZ/EgOyxkWtN7wy15C3kZi55FsrZQCEGPEiSfzRLWZ/k1CoeVqB1zwkGhSn2IK1I7rKdG2USZvNYw4ZGDxYqw48kmwk/IcmyeuMcFvkuL4FfeipnlzNPFLgT3U8k5qMPULuyAB7MnIXxjCA=
Received: from BN9PR03CA0894.namprd03.prod.outlook.com (2603:10b6:408:13c::29)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 07:36:16 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::66) by BN9PR03CA0894.outlook.office365.com
 (2603:10b6:408:13c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Fri, 21 Oct 2022 07:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 07:36:16 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 02:36:14 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Date: Fri, 21 Oct 2022 15:36:02 +0800
Message-ID: <20221021073605.20352-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|MN2PR12MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bfb9619-f154-4de2-bc7f-08dab336f00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gh7xUNvXk2Xrystws2Y6uwMovA3uKZKszJgRm2fkIhbZI8Dv6A38kO9YVwqVLRW230dQpn0pMr9JgNHCcdJ4kzVtePyEPFQO5dCOptrW/F94ZCB8nqU8nuZyeQ44MCKXpgMXrF5RpfJt+kamoNPK04r8EUt+asWkQpaP01Er6EAgcFrP11voTSbGtyu6J88NExatdnyLLLWRpn6NRW6us8tFQrqkjgXaJSLjgTiXwVA9oJlEKV6MYx/EK0mGAvINCCJdpnygDTYb/c633HcCebMYpjY1tzJKnU5Hn0fzQTJUd3QqWBU5s+2zkyG5DId9naGa0HSOxfk/iySatcxB5bRrl1tLNYSjqLzOlQPKjnb2a/0agA/PYILoEAe+MpWs8po3rlcc7bXGlmqt1HuWtqTZ7P0DONqNQVZdvTxrdAOpifs7PNtRz5ZOVeJAHHGBJ1xbvknGqqF1qitP7lV5sxOGbs37U/G0cWcbv+ct/77lqxDbVEQitHNaP2GLDO1GQkF/MO0WKI29mvLA8qukCkHxeHpcl1LsG7prdgb7Vc1K/r/0schu213gdZrvzIOuptrK98fKlhiH8lNZ5hlgAOk9VfKG4Klznqvnhqxrg8Qg21pyKAj00HYuwTBGcxr5rwbgUqcPd7HtVZakIaNdX6s+93sUT3Ovqwxd5lBhgp68Ui0CjzYntf3TrGEFd29B4Fv4Yiukhm4uR1OGlb2X2kObiedv9q5B2leWap03hYxPOYRbxNPcPc356bbWHb/OkAqd0b6Uw/Lp7CqrL5qzSXY1hHu5vGu3kToodhrorzTI5egkptNcBsOPWSKC0hef
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(110136005)(6636002)(478600001)(4326008)(8936002)(8676002)(70206006)(5660300002)(86362001)(40460700003)(41300700001)(316002)(7696005)(2906002)(36756003)(26005)(356005)(82740400003)(47076005)(2616005)(16526019)(426003)(336012)(40480700001)(1076003)(186003)(81166007)(82310400005)(70586007)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:36:16.2562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfb9619-f154-4de2-bc7f-08dab336f00a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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

v2: remove page retirement handling from MCA poison handler,
    let MCA notifier do page retirement.

v3: remove specific poison handler for MCA to simplify code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 53 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index aad3c8b4c810..3c83129f4090 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -22,6 +22,59 @@
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
-- 
2.35.1

