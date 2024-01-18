Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433A8C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 06:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B209F10E145;
	Thu, 18 Jan 2024 06:44:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4D410E145
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 06:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRgxNBj4kg489sUi5WeVuCnMSY/fM0t5axUaVAPXJn42BUSxm8sqLvtGtJtZu4N0RwbjlmM2mvIVWGrnb5Pw1OJRo2hPqaZ97wZVSheMyp8WtM+445sQkqdaLVdk+7z4vrREUu/LrOivJYSWvB5yCuxV8rzXAsXE52HDMO61wgAsQgRb2b8YAScT3qNRTcC0yMlAdE7HNKz/bJtX2xIgMgz/JUgR66uKCknyqTcq1VV9/dNqcuc3xIGevAqO3BU8m5VxDuC193Kq0V0Zy5JDdH2UEpiigl4qJyPZUys47OqrIzrz6JzCJKyUW560iuw0PGIvbPsVTe/bfXoS/p8O3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37v06N6kk/zJa9gZKfGr3QRKVWg7RXxVq/OXEpG/qrI=;
 b=PQrMMO+0YhwXaREhH9wkuCqCo13cwxmkLX/WzydRkwPdod5matZG3q6NdAEGWhI0eVCJrkh0ujEsY3YGnjm14zaN0ciB53ikcsdPA57hH9E9JcwNQFCZA6H7aw+avK7waRrfB/3fZMuNX7rtuEKfSQQuujf2MrEjVBhp/hIYoRZHVyXvbauqwj7WyPSo5zjSlZTIWlKx5Iw26Z7MwebAjqL82jHzY3Q9D2rNKn35Zth1yzXsRD9i+JKJJKFlzXHBrUNqRHpxSACj6v5r9qpOLGHSu4N39L1pe0TPRfOhWxmLlABXT+ZGoGpzBxg8RjJmhHntz3cZ5p/8/pxL2RjcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37v06N6kk/zJa9gZKfGr3QRKVWg7RXxVq/OXEpG/qrI=;
 b=q3Mygx7vsRRduAoxY8Psh3c4ZTsbxPNQonYP5Mf4hjpegaBT8OTG8mJjpEMLKgw+kvMOP3i/gfVccMJ/ExRROzDaj1JK5t1OVQqG/rDs+a9SmHnnfgXJv0SbJbW3jbFL7k6853RUZQul30Mh3eYNEWFW9q8963d0X+KMps/E1V8=
Received: from SN1PR12CA0061.namprd12.prod.outlook.com (2603:10b6:802:20::32)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 06:44:01 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::fb) by SN1PR12CA0061.outlook.office365.com
 (2603:10b6:802:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Thu, 18 Jan 2024 06:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 06:44:00 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 00:43:39 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 4/5] drm/amdgpu: add interface to check mca umc status
Date: Thu, 18 Jan 2024 14:42:56 +0800
Message-ID: <20240118064257.1951585-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
References: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2eff6e-78e9-4f32-6c03-08dc17f0daab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDD2BFrO9bS9lswUAlIcO0f0EhFxl/cVWiUsdGdQXfq7Deksjgbj37jf7eO12xr61MfkDxdW3e38KB9Lwm5Lh30bMcd3O50dQfdTPKd5yGDJDAh1pguyJ7scUPVBuZj0BTT8Mg7iAX7TFdMYqXdS0nasAyH+eqFKdSA0xbrsEVtmx5RIa3gZFw4XPcL+Xknxd03/2pQt2jUHq3bXuQZrv7MUyr2CmaBYCccEs2hUAP+w9vZl2YYGK0+V2v9usuFtrDYk9XeKoTbxiSHM9RKXEEye1zkD5H3J3Iu1I2KSXY6XdZ66ErPbYDI2ybooGYcLgL/29o976KTvFilGad+GZwee2mdr7/Jt/zgdtnTKOka3XEl8qGRiv9rPQhfkAYxW3uB3mKfrOgjSK81NksfYPJVbY0u65qAemmusdC5DhTeSGU7hvoxK/j5A1W2r0aeRqIMvBVBjHxZFS0cF5bQhFR3QsiZZE7WvkZC3MkuLpIft4TRFLhS9EUqqEF5msyh+lJMEw9AvHzgKrexD4da5czSAg9mB8c7ldEUwIu2h/pU27zoCFZuVFTADEINxo/wvoBZ9MJH6jhqbSyQD5C/Dt9FFjRLEZ+b+yp0aaB59nqqjMthEQETMWgVK2PI99Mi/6snb1cRcaZ278Z4geUua3iEZ4d3F7AVXwqKvsiH/a3j0Dml2yRjqQ4MU9DBAqiNwkbKZRMc0HYd/S+JFLUeJBFA6dGgnOdfAgTT/8ygWH0iktBn3tlugDl8rPQUhRaKFATV96ZKvalU6im3qY+BohQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(26005)(336012)(6666004)(7696005)(36860700001)(426003)(16526019)(2616005)(1076003)(36756003)(86362001)(356005)(82740400003)(81166007)(8936002)(2906002)(4326008)(41300700001)(316002)(83380400001)(47076005)(5660300002)(478600001)(70586007)(8676002)(6916009)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:44:00.7400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2eff6e-78e9-4f32-6c03-08dc17f0daab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to check mca umc status.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       | 12 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        | 20 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 +++---
 5 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index fde20857b3dd..65ed8bb5c120 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -27,6 +27,16 @@
 #include "umc/umc_6_7_0_offset.h"
 #include "umc/umc_6_7_0_sh_mask.h"
 
+static bool amdgpu_mca_is_deferred_error(struct amdgpu_device *adev,
+					uint64_t mc_status)
+{
+	if (adev->umc.ras->check_ecc_err_status)
+		return adev->umc.ras->check_ecc_err_status(adev,
+				AMDGPU_MCA_ERROR_TYPE_DE, &mc_status);
+
+	return false;
+}
+
 void amdgpu_mca_query_correctable_error_count(struct amdgpu_device *adev,
 					      uint64_t mc_status_addr,
 					      unsigned long *error_count)
@@ -257,7 +267,7 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 			amdgpu_ras_error_statistic_ue_count(err_data,
 				&mcm_info, &err_addr, (uint64_t)count);
 		else {
-			if (!!(MCA_REG__STATUS__DEFERRED(entry->regs[MCA_REG_IDX_STATUS])))
+			if (amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_REG_IDX_STATUS]))
 				amdgpu_ras_error_statistic_de_count(err_data,
 					&mcm_info, &err_addr, (uint64_t)count);
 			else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index b399f1b62887..b964110ed1e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -65,6 +65,7 @@ enum amdgpu_mca_ip {
 enum amdgpu_mca_error_type {
 	AMDGPU_MCA_ERROR_TYPE_UE = 0,
 	AMDGPU_MCA_ERROR_TYPE_CE,
+	AMDGPU_MCA_ERROR_TYPE_DE,
 };
 
 struct amdgpu_mca_ras_block {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index de2dc1853636..83199296ed10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -21,7 +21,7 @@
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
 #include "amdgpu_ras.h"
-
+#include "amdgpu_mca.h"
 /*
  * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
  * is the index of 4KB block
@@ -64,6 +64,8 @@ struct amdgpu_umc_ras {
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
+	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
+			enum amdgpu_mca_error_type type, void *ras_error_status);
 	/* support different eeprom table version for different asic */
 	void (*set_eeprom_table_version)(struct amdgpu_ras_eeprom_table_header *hdr);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index fa2168f1d3bf..1e8e97d72f1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -425,6 +425,25 @@ static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 	}
 }
 
+static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
+			enum amdgpu_mca_error_type type, void *ras_error_status)
+{
+	uint64_t mc_umc_status = *(uint64_t *)ras_error_status;
+
+	switch (type) {
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+		return umc_v12_0_is_uncorrectable_error(adev, mc_umc_status);
+	case AMDGPU_MCA_ERROR_TYPE_CE:
+		return umc_v12_0_is_correctable_error(adev, mc_umc_status);
+	case AMDGPU_MCA_ERROR_TYPE_DE:
+		return umc_v12_0_is_deferred_error(adev, mc_umc_status);
+	default:
+		return false;
+	}
+
+	return false;
+}
+
 static void umc_v12_0_err_cnt_init(struct amdgpu_device *adev)
 {
 	amdgpu_umc_loop_channels(adev,
@@ -510,5 +529,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v12_0_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v12_0_ecc_info_query_ras_error_address,
+	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..67fc01e0f9c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2557,9 +2557,9 @@ static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct
 		return 0;
 	}
 
-	if ((type == AMDGPU_MCA_ERROR_TYPE_UE && umc_v12_0_is_uncorrectable_error(adev, status0)) ||
-	    (type == AMDGPU_MCA_ERROR_TYPE_CE && (umc_v12_0_is_correctable_error(adev, status0) ||
-	     umc_v12_0_is_deferred_error(adev, status0))))
+	if (umc_v12_0_is_deferred_error(adev, status0) ||
+	    umc_v12_0_is_uncorrectable_error(adev, status0) ||
+	    umc_v12_0_is_correctable_error(adev, status0))
 		*count = 1;
 
 	return 0;
-- 
2.34.1

