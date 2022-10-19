Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E97C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 08:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA6510F181;
	Wed, 19 Oct 2022 08:12:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0EC10F181
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 08:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N++iG0sm4vACWU6jMXDyuNcfla/u4yvQ/VW9uVaWqkF6jXc3TJD7NGkQg+DfNCSB1jyR6uJMqW6LLdOpkqypYKO2WkeKjKrjyVsEIPf1/V1x/EbvoDlARNKWbMSa/Fs63f1frgQ9PVIMHia0EoS9p9CNY+5x9seJWov+SPsGaU7k38aVTwcFvFBhfLcG+4C+naFXBNkkm6fTUwM6izTUXa5aEWyvBUK5litekuJGBiMYtpCFwPoxJeVavkU0HNDXVKMSsrtVC3BOT5v3c9Xu/IGXQEknlpSJg0KONSUgnBNJ4UYZl3NYSRfndU7RElakA0ugN7Aw47TI3aXvGKWoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTSI7muQ1uFtmtRoWvWN6Q3CMEGWalwzqCPew5ebChs=;
 b=JDkRUIBSqAd5SH8NXdZ2xxIvz4XPq1ekTO9WSV57NKBrnELWOpx4YZB8FGsmQHv4jjJ/Nx0V20xtBWViSVycZ4AnHEzxsI4XEsOOSsgEF+ibLxySRRq0Z5Ska46WFLXjQdXNPQmlv2B7o6JckKPZwBMPUbVOOSqAqf87XVyJ5jPTryX6ARaQ8IQAdy3oHDh3ntSnqx4FHYEmcy2daZH3cIGXlJwfSwdjsyM7q04eoXTrBNesCPa1gzX7sk2GfolXoXICa9PLUDIStY9QU0QXWtqWnQMao/sJHs/6R5slOGZIF/cCyDIohM+Qxgy23X/AoVy5QHu40QuDkgP84n4tLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTSI7muQ1uFtmtRoWvWN6Q3CMEGWalwzqCPew5ebChs=;
 b=ipTBpORld+MxaE5rgA0ZEQmAkjdgK1xHP6jxZH3eOn9ERPasR92epgRjcYAhdD7tIvBBNJT+jfWmEO1VlG4vpCX+Vuyidp5AOFOK3n6w+BGZrVIYk9zifr1p2XVP+GIeMc26UronCdvzneRlu4Rqg1Jt9pTB1KUYw+LfVoYJ48g=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 08:12:30 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::8d) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Wed, 19 Oct 2022 08:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 08:12:29 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 03:12:27 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Date: Wed, 19 Oct 2022 16:11:47 +0800
Message-ID: <20221019081150.31773-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fb032a-174b-4bd7-fdb5-08dab1a9aab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfR58YNvA9CXfwi6MrCkSPo/c43Srz4XFQyC6trCZQraXdoQHj46UjSJbg+yCCgzJa496qUPB2E6IvXZiXNi/uAwFM84/B0b24y08V2uROHBxwgcdMqqaJQa1oxh4OQqCT4H5hEJsrC2PBohBpG9f8YJU6I4g2O13yQo6Ne43vYrXjqOcm01THkRbiV8fbeUYAowkngUxjMLGRncoUcOs43FdAUvW2vI2XDF8PNgNOIcZcQ11T/7U4wiV5HzWpTRvDFfsn+wPGRR5s4Hen+UnEOyUI3TkUOmDbFgV/I2CA64/nrR8oqqZMStjjp4ZV2GQf0pxHfj1zQNRFYtPIqDTakgEBDIqXTDojvpBQybmwS309rLMxqrhyuMkVfgpiC0gJh6RxzTEPqbzUCgHkdzUxtHfdXvkIF8C5yXVanxXWo/DNKnPj3405gWDENVijXe6hA8i2RB1R3LYwqbSdyCdp1J316ZJNf+En4Z9T4WcBrEITGQiss9tH2BuMDecNMycvG5UBFAxf3Dh/G/ObnUk3/gJGGx/t0tp2P0IEFlNBehuL4mzbPkCwbR7BiCnAcB3IFYXBRl1OpqvXtagjoUh7mazIP8Dp1N5spisar5mne+j7uQ5h8mMjBu3bT9XMLt5yYXq1gwU4bb7JKypaRYTKymRfiAGGRfvfHShjeXbE3XrWHFQqPh1jQFYDvEtSOEhkff6TwwR9Nl7VK4t2z5qSlXh+RWOx6BSu+usS/m/BfZ15s1w5a3UliWesYfkHwtbJMeXEdh/9WGjpsqOEV7nZrRMA1JJiKSo0nG51fH7wwO1Jk0MJAjY0fFJQJVRtfC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(1076003)(2906002)(426003)(336012)(82740400003)(47076005)(8936002)(26005)(36756003)(5660300002)(356005)(16526019)(41300700001)(186003)(2616005)(81166007)(86362001)(82310400005)(40480700001)(40460700003)(36860700001)(6636002)(6666004)(316002)(110136005)(7696005)(478600001)(4326008)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 08:12:29.7314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fb032a-174b-4bd7-fdb5-08dab1a9aab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 67 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 +
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index aad3c8b4c810..9494fa14db9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -22,6 +22,73 @@
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
+
+static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
+		struct ras_err_data *err_data, bool reset)
+{
+	/* MCA poison handler is only responsible for GPU reset,
+	 * let MCA notifier do page retirement.
+	 */
+	if (reset) {
+		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+		amdgpu_ras_reset_gpu(adev);
+	}
+
+	return AMDGPU_RAS_SUCCESS;
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

