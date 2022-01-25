Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 10:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AEA710E28A;
	Tue, 25 Jan 2022 10:46:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A388C10E28A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 10:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP1ceoh+z02q+I6rVvOstr6IDyV7JIHvQD5BuTx2fRVDsa8tliA90uUMgOIUn1WxHOzJdfrT9rOW5O7L02oK1V09l9RBmHyPeViL9MDGxc58NNRiRRrA/hc8jp70WCQulvqc69BFQCHyUbBc8FKw07CoCcCgRXEo4Be2lb/i3+RsGM4E4AmdExJBxXhUJQZiFr1qgEmAW14PtvF513IiCZeacogerAyJf4rIcPI8sX8rjjQvr0lrLbxbv+qZd5Hc2tIe5aTml8x/coi8MNw6Iox6plrq39e2c5SODwS2RlkQ2eFPOeY8c32ShFZqGD0HCQvuzB6X3IHw0uW/16Jkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX7q2NzdLByGMPTqE7SU34OQjwgZjY/VgbAFjcsU4vs=;
 b=nPwy4k1X6yzdW9E27n5X6XQeUpgZ7S/QrMXwcJcl+anU9hoGt/Q29cDqvBwwSN+en3S3pA/OuJN365dwLu6gM/1VRvtnxyjgtOIab4wo0WZOpWI+A29ny/oteNQ8iCZr7vFhmeYgSAKMUSGt3Y3LLd45H4++jDsMz0Tq0khS+RerfcdmQ2uEAzd4wKaKiSvnAqDYfEt3/WzC+js0c+/O2oNTJlW3loiMOsNJ67I45iUisVIj8OTiGUhPFi9IvivkGRGcTJb3yyNLpXAGd97ThXXXrzVZibqukqkpiaUwKuB0QMmprTKYegNagG6fhCP0aNfhQe1pWv3gUHYQ4d2L9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX7q2NzdLByGMPTqE7SU34OQjwgZjY/VgbAFjcsU4vs=;
 b=NvqkdCHDwkgnrnwNzo88Or6hi5+x9l9sEdytDtuUksIwVtXtuzGX/lkqZWXgFnDxhaB6MWGp55O1V8AW6ZVemOiNZq/sS7xjASF78zp2vkbRmRVJWxuCsIndLDYLDlP+KA1uVxqS2J8oEuyUaSsD+Vqo4T2AswtU5bSP4oxPsm4=
Received: from DS7PR06CA0028.namprd06.prod.outlook.com (2603:10b6:8:54::33) by
 DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Tue, 25 Jan 2022 10:46:25 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::cf) by DS7PR06CA0028.outlook.office365.com
 (2603:10b6:8:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 10:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 10:46:24 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 04:46:22 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <john.clements@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add umc_fill_error_record to make code more
 simple
Date: Tue, 25 Jan 2022 18:46:09 +0800
Message-ID: <20220125104612.27050-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa73dd52-9394-4eb5-c5e5-08d9dfefef12
X-MS-TrafficTypeDiagnostic: DM5PR12MB2581:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2581D9651D3E1AB8D32553CBB05F9@DM5PR12MB2581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqGYFpk+LR62Solayf0XNWJtphmw2cELI5nymw/wFoTcnuR9VLpPPE44+KF8ugTjspTKDqlk6q7mrZ4YoDpkLnYvJBdX82qGR1RuXWKvUfZW5SmmEd+fQv0pT7YK6tFtuZeY3RqRZAgFm+b90Fgsw0uSc+KVoaj5G5IbwLWHX4HU3vXv/ZtWHESfvO1Yv9kVYA7i4qz3B2Ti6wmze7vPsGnc99hlLviEOhrCdA62lOrftRLUBIrx1f/gT9hdwYGPlFncA/p9uL5PXrutq1V3HH2fh/1+mHr4+OOSaEkPzUJM4JFnJTs3fNCJL0a6nu2mBQXX2zdlpGkOTbeLhTlZQ+eMr5wY0dCbgrXDqBvjk81zP/vXElgwpTxRZJx4NhZ+tOMEcc/CH8wboemrwbEyk8pGJpbuUxE+mbvqMUftK6Jvahnq6zD1QDhNaVQfMcOGReVnO0QXgmKIzMc7y47ZBdiwq0e1qPjhw4j0DaVIwB8IweyaCCHavSdqGvXpr80G+LjI0VPi5/JNUf2M2ShFkoTF3m+AgqqHe9I0kQ5W8EG057L3rWoZ625UVW+EmZfjCpOZVDS8W4wwfns1FHTLnHR+aXHOYtZ3DJE2RByudFQxS2jQ7hKbkD8GgwyFL6OCjB+10+F/vQwWiL+Do7BeALmSVt1sn+QSxtcUW0kxioLmRKhLhUpAXQcpZQzPAaxHunZkwdtULxj4o6rvMM7ypEoRbGBZCVuLWHyhFL2D7jtrZZnGwVYL9JTWxxEKiZ94ncc0YW2JcOUzb+zuoFC96KNfgk3uJPbIbvjKEdlPtiw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(110136005)(16526019)(186003)(6636002)(70586007)(86362001)(36756003)(2906002)(70206006)(81166007)(83380400001)(8676002)(316002)(36860700001)(8936002)(47076005)(6666004)(4326008)(336012)(82310400004)(356005)(426003)(1076003)(508600001)(30864003)(40460700003)(5660300002)(26005)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 10:46:24.9861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa73dd52-9394-4eb5-c5e5-08d9dfefef12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2581
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

Create common amdgpu_umc_fill_error_record function for all versions
of UMC and clean up related codes.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 23 ++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 21 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  5 ++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c   | 18 +++----------
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 36 +++++--------------------
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c   | 36 +++++--------------------
 6 files changed, 46 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d4e07d0acb66..e6324995fc54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -158,14 +158,9 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 	}
 
 	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
-
-	err_rec.address = address;
-	err_rec.retired_page = address >> AMDGPU_GPU_PAGE_SHIFT;
-	err_rec.ts = (uint64_t)ktime_get_real_seconds();
-	err_rec.err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-
 	err_data.err_addr = &err_rec;
-	err_data.err_addr_cnt = 1;
+	amdgpu_umc_fill_error_record(&err_data, address,
+			(address >> AMDGPU_GPU_PAGE_SHIFT), 0, 0);
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
@@ -2660,8 +2655,6 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d, chan_idx: %d",
 			     umc_inst, ch_inst);
 
-	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
-
 	/*
 	 * Translate UMC channel address to Physical address
 	 */
@@ -2673,16 +2666,10 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 			ADDR_OF_256B_BLOCK(channel_index) |
 			OFFSET_IN_256B_BLOCK(m->addr);
 
-	err_rec.address = m->addr;
-	err_rec.retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-	err_rec.ts = (uint64_t)ktime_get_real_seconds();
-	err_rec.err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-	err_rec.cu = 0;
-	err_rec.mem_channel = channel_index;
-	err_rec.mcumc_id = umc_inst;
-
+	memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
 	err_data.err_addr = &err_rec;
-	err_data.err_addr_cnt = 1;
+	amdgpu_umc_fill_error_record(&err_data, m->addr,
+			retired_page, channel_index, umc_inst);
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index b4c68c09e071..ff7805beda38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -218,3 +218,24 @@ int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
 	return 0;
 }
+
+void amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
+		uint64_t err_addr,
+		uint64_t retired_page,
+		uint32_t channel_index,
+		uint32_t umc_inst)
+{
+	struct eeprom_table_record *err_rec =
+		&err_data->err_addr[err_data->err_addr_cnt];
+
+	err_rec->address = err_addr;
+	/* page frame address is saved */
+	err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+	err_rec->ts = (uint64_t)ktime_get_real_seconds();
+	err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
+	err_rec->cu = 0;
+	err_rec->mem_channel = channel_index;
+	err_rec->mcumc_id = umc_inst;
+
+	err_data->err_addr_cnt++;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 195740a6d97d..4db0526d0be4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -80,4 +80,9 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
+void amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
+		uint64_t err_addr,
+		uint64_t retired_page,
+		uint32_t channel_index,
+		uint32_t umc_inst);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 4776301972d4..939cb203f7ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -300,7 +300,6 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 {
 	uint32_t lsb, mc_umc_status_addr;
 	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
-	struct eeprom_table_record *err_rec;
 	uint32_t channel_index = adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
 
 	if (adev->asic_type == CHIP_ARCTURUS) {
@@ -328,8 +327,6 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 		return;
 	}
 
-	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
-
 	/* calculate error address if ue/ce error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
@@ -348,18 +345,9 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 
 		/* we only save ue error information currently, ce is skipped */
 		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1) {
-			err_rec->address = err_addr;
-			/* page frame address is saved */
-			err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-			err_rec->ts = (uint64_t)ktime_get_real_seconds();
-			err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-			err_rec->cu = 0;
-			err_rec->mem_channel = channel_index;
-			err_rec->mcumc_id = umc_inst;
-
-			err_data->err_addr_cnt++;
-		}
+				== 1)
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+					retired_page, channel_index, umc_inst);
 	}
 
 	/* clear umc status */
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index f5a1ba7db75a..300dee9ec6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -120,7 +120,6 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 					 uint32_t umc_inst)
 {
 	uint64_t mc_umc_status, err_addr, retired_page;
-	struct eeprom_table_record *err_rec;
 	uint32_t channel_index;
 	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -137,8 +136,6 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	if (!err_data->err_addr)
 		return;
 
-	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
-
 	/* calculate error address if ue/ce error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
@@ -154,18 +151,9 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 
 		/* we only save ue error information currently, ce is skipped */
 		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1) {
-			err_rec->address = err_addr;
-			/* page frame address is saved */
-			err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-			err_rec->ts = (uint64_t)ktime_get_real_seconds();
-			err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-			err_rec->cu = 0;
-			err_rec->mem_channel = channel_index;
-			err_rec->mcumc_id = umc_inst;
-
-			err_data->err_addr_cnt++;
-		}
+				== 1)
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+					retired_page, channel_index, umc_inst);
 	}
 }
 
@@ -345,7 +333,6 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 {
 	uint32_t mc_umc_status_addr;
 	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
-	struct eeprom_table_record *err_rec;
 	uint32_t channel_index;
 
 	mc_umc_status_addr =
@@ -364,8 +351,6 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 		return;
 	}
 
-	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
-
 	channel_index =
 		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
 
@@ -384,18 +369,9 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 
 		/* we only save ue error information currently, ce is skipped */
 		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1) {
-			err_rec->address = err_addr;
-			/* page frame address is saved */
-			err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-			err_rec->ts = (uint64_t)ktime_get_real_seconds();
-			err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-			err_rec->cu = 0;
-			err_rec->mem_channel = channel_index;
-			err_rec->mcumc_id = umc_inst;
-
-			err_data->err_addr_cnt++;
-		}
+				== 1)
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+					retired_page, channel_index, umc_inst);
 	}
 
 	/* clear umc status */
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index d70417196662..de85a998ef99 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -121,7 +121,6 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 					uint32_t umc_inst)
 {
 	uint64_t mc_umc_status, err_addr, retired_page;
-	struct eeprom_table_record *err_rec;
 	uint32_t channel_index;
 	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -138,8 +137,6 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	if (!err_data->err_addr)
 		return;
 
-	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
-
 	/* calculate error address if ue/ce error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
@@ -155,18 +152,9 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 
 		/* we only save ue error information currently, ce is skipped */
 		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1) {
-			err_rec->address = err_addr;
-			/* page frame address is saved */
-			err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-			err_rec->ts = (uint64_t)ktime_get_real_seconds();
-			err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-			err_rec->cu = 0;
-			err_rec->mem_channel = channel_index;
-			err_rec->mcumc_id = umc_inst;
-
-			err_data->err_addr_cnt++;
-		}
+				== 1)
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+					retired_page, channel_index, umc_inst);
 	}
 }
 
@@ -344,7 +332,6 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 {
 	uint32_t lsb, mc_umc_status_addr;
 	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
-	struct eeprom_table_record *err_rec;
 	uint32_t channel_index = adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
 
 	mc_umc_status_addr =
@@ -363,8 +350,6 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 		return;
 	}
 
-	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
-
 	/* calculate error address if ue/ce error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
@@ -383,18 +368,9 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 
 		/* we only save ue error information currently, ce is skipped */
 		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1) {
-			err_rec->address = err_addr;
-			/* page frame address is saved */
-			err_rec->retired_page = retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-			err_rec->ts = (uint64_t)ktime_get_real_seconds();
-			err_rec->err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-			err_rec->cu = 0;
-			err_rec->mem_channel = channel_index;
-			err_rec->mcumc_id = umc_inst;
-
-			err_data->err_addr_cnt++;
-		}
+				== 1)
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+					retired_page, channel_index, umc_inst);
 	}
 
 	/* clear umc status */
-- 
2.17.1

