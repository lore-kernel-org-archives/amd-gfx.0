Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65369C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 14:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330D020679
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 14:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nLzO0a2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330D020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC0D891DC;
	Wed,  3 Jun 2020 14:09:46 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680042.outbound.protection.outlook.com [40.107.68.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC76891DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 14:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlE65XqMoNmPmA75OVzgnhVBo0syfrkBPTJC6Ak3WFAPJ5PYLWA9r6T5QCHPQgbitr/cYO83uBSN+7dpmwGu4PmxJN29wRc+fUVUZklsmRb/tTElnGuMlckYzzchOYXQ1maK9uRuoZH6bak50NRSacee/Cmmpxk1h+8xATWCdN7owWQW9oYOyvQbmihehW2iTAJDr2xQzrzsVIz9Jeh1WMfI0eCb0LFHiey8fPWa9FXdgWlFXpcqd2VKT9bqEr+pN9Lc8BtylW2NaWFXJcztymyTlzSgagrSz/EGSkDhzEGzq7QpuvssTEJ+Wj+0ygSUppd0JbihRXMgPnMsd+/Wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBe66+9ondEILVs83D3eOagSBfsGjYHqMT4vkNi9Y4Q=;
 b=PNxBJQAdWLTfAn85TWmmEpOl2SPbQWVofJT5YBsGDVq/uiX1oGaEZpEwYKm8c38M9yM9qqTZV4LMJWJGgSs030KrbVq+vWaNZaR8PRt3gR2YnOcbM4jYx0UF6BCVhpE2RfaHdbsW1gH7sGiF5k6ZVEKRZaR2c7bv2IVelb3XVz2siLbayFy2rSNC4wxLKaOKJc8FSmLoECPUrjmPUjrM4HhX8y5SVEsQ4hx6vFWHzSeEqFeX+QkCNKOnCPOTCLiXHd1CJT9vCMDqb8oPPwKUyv6kcuvvmLTZ2F8J9ETfM93wwo6egfPWX0p2OdN+0sBgcBPQGQCNs8wiPoEiIppvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBe66+9ondEILVs83D3eOagSBfsGjYHqMT4vkNi9Y4Q=;
 b=nLzO0a2LNh8zmRzZVK1MQr0tmdzp8E3WfPTWXBlTiNXtylvJML0CT5AzFY1mhtFudFMUMAWjVZj6RoaQLKS7WofWR7EoRuaqcw0nJOKm0/mIppg2X3s1M2LdbUlmuAN5JlE8AU3OsPEzeYHdZYT1bvxLs6Uoqw6bgxS3WZhNglk=
Received: from MWHPR22CA0045.namprd22.prod.outlook.com (2603:10b6:300:69::31)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 14:09:42 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::bb) by MWHPR22CA0045.outlook.office365.com
 (2603:10b6:300:69::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 14:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 14:09:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 3 Jun 2020
 09:09:40 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 3 Jun 2020
 09:09:40 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 3 Jun 2020 09:09:38 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: support reserve bad page for virt
Date: Wed, 3 Jun 2020 22:09:36 +0800
Message-ID: <20200603140936.7356-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966005)(54906003)(336012)(26005)(6916009)(316002)(426003)(1076003)(86362001)(8936002)(5660300002)(2616005)(8676002)(7696005)(4326008)(47076004)(478600001)(70206006)(82740400003)(356005)(2906002)(186003)(36756003)(81166007)(82310400002)(70586007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c56e49-2a7e-4821-c747-08d807c7c298
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4231ED7A310FB8DC54E0895A9A880@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDMRgbm0sfdxD8nCSCMkIcw5R/5mu3vwj6akoMXVUZlqB/LjXVokG+9FkGIwXRl8BedZMmXJ4LwhNC3Tm5OCDVdNVc+WOUFU4/Wnm39pgGpAAMuabpPOFJg+6UBTGy8BmgHvgFntoi4flX/3YyoASvBG+7QbVFpPEURSTULOME1M2tKEQv2XBAR9X/2ZTUzICQ6qcSlNs08QRQ6Xn3RYRxCXNhpW9v8FI8m0NdUf4VRVPH9QXRuIq3OAAJCL1yEzb3+Khp79UZSjfuNyu623A/RDm5q2wvs9zOLgiyp7uPlEiE7Ml00uharqwBM379sGps23wHYTLzOXay3m8SGOvXIu+SeqnHCcrtJz8W/s9A08DA9kuOXnh4UK+peDZkkS8iobV+8lKHbEWuoCc6xSJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:09:41.5894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c56e49-2a7e-4821-c747-08d807c7c298
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: Guchun.Chen@amd.com, Tao.Zhou1@amd.com,
 "Stanley.Yang" <Stanley.Yang@amd.com>, Monk.Liu@amd.com, John.Clements@amd.com,
 Dennis.Li@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: Ia0ad9453ac3ac929f95c73cbee5b7a8fc42a9816
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 164 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  30 +++-
 3 files changed, 196 insertions(+), 5 deletions(-)
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b633171281f8..e8986e007206 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2001,8 +2001,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		}
 	}
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_init_err_handler_data(adev);
 		amdgpu_virt_init_data_exchange(adev);
+	}
 
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
@@ -2306,6 +2308,9 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_release_virt_err_handler_data(adev);
+
 	amdgpu_ras_pre_fini(adev);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
old mode 100644
new mode 100755
index f3b38c9e04ca..c1554562a2ce
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -26,6 +26,7 @@
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ras.h"
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
@@ -255,12 +256,164 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj,
 	return ret;
 }
 
+int amdgpu_virt_init_err_handler_data(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct virt_ras_err_handler_data **data = &virt->virt_eh_data;
+	/* GPU will be marked bad on host if bp count more then 10,
+	 * so alloc 512 is enough.
+	 */
+	unsigned int align_space = 512;
+	void *bps = NULL;
+	struct amdgpu_bo **bps_bo = NULL;
+
+	*data = kmalloc(sizeof(struct virt_ras_err_handler_data), GFP_KERNEL);
+	if (!*data)
+		return -ENOMEM;
+
+	bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
+	bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo), GFP_KERNEL);
+
+	if (!bps || !bps_bo) {
+		kfree(bps);
+		kfree(bps_bo);
+		return -ENOMEM;
+	}
+
+	(*data)->bps = bps;
+	(*data)->bps_bo = bps_bo;
+	(*data)->count = 0;
+	(*data)->last_reserved = 0;
+	return 0;
+}
+
+static void amdgpu_virt_release_bp(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
+	struct amdgpu_bo *bo;
+	int i;
+
+	if (!data)
+		return;
+
+	for (i = data->last_reserved - 1; i >= 0; i--) {
+		bo = data->bps_bo[i];
+		amdgpu_bo_free_kernel(&bo, NULL, NULL);
+		data->bps_bo[i] = bo;
+		data->last_reserved = i;
+	}
+}
+
+void amdgpu_release_virt_err_handler_data(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
+
+	if (!data)
+		return;
+
+	amdgpu_virt_release_bp(adev);
+
+	kfree(data->bps);
+	kfree(data->bps_bo);
+	kfree(data);
+	virt->virt_eh_data = NULL;
+}
+
+static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+		struct eeprom_table_record *bps, int pages)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
+
+	if (!data)
+		return;
+
+	memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
+	data->count += pages;
+}
+
+static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
+	struct amdgpu_bo *bo = NULL;
+	uint64_t bp;
+	int i;
+
+	if (!data)
+		return;
+
+	for (i = data->last_reserved; i < data->count; i++) {
+		bp = data->bps[i].retired_page;
+
+		/* There are two cases of reserve error should be ignored:
+		 * 1) a ras bad page has been allocated (used by someone);
+		 * 2) a ras bad page has been reserved (duplicate error injection
+		 *    for one page);
+		 */
+		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
+					       AMDGPU_GPU_PAGE_SIZE,
+					       AMDGPU_GEM_DOMAIN_VRAM,
+					       &bo, NULL))
+			DRM_WARN("RAS WARN: reserve vram for retired page %llx fail\n", bp);
+
+		data->bps_bo[i] = bo;
+		data->last_reserved = i + 1;
+		bo = NULL;
+	}
+}
+
+static bool amdgpu_virt_check_bad_page(struct amdgpu_device *adev,
+		uint64_t retired_page)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct virt_ras_err_handler_data *data = virt->virt_eh_data;
+	int i;
+
+	if (!data)
+		return true;
+
+	for (i = 0; i < data->count; i++)
+		if (retired_page == data->bps[i].retired_page)
+			return true;
+
+	return false;
+}
+
+static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
+		uint64_t bp_block_offset, uint32_t bp_block_size)
+{
+	struct eeprom_table_record bp;
+	uint64_t retired_page;
+	uint32_t bp_idx, bp_cnt;
+
+	if (bp_block_size) {
+		bp_cnt = bp_block_size / sizeof(uint64_t);
+		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
+			retired_page = *(uint64_t *)(adev->fw_vram_usage.va +
+					bp_block_offset + bp_idx * sizeof(uint64_t));
+			bp.retired_page = retired_page;
+
+			if (amdgpu_virt_check_bad_page(adev, retired_page))
+				continue;
+
+			amdgpu_virt_ras_add_bps(adev, &bp, 1);
+
+			amdgpu_virt_ras_reserve_bps(adev);
+		}
+	}
+}
+
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 {
 	uint32_t pf2vf_size = 0;
 	uint32_t checksum = 0;
 	uint32_t checkval;
 	char *str;
+	uint64_t bp_block_offset = 0;
+	uint32_t bp_block_size = 0;
 
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
@@ -275,6 +428,17 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 
 		/* pf2vf message must be in 4K */
 		if (pf2vf_size > 0 && pf2vf_size < 4096) {
+			if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
+				struct amdgim_pf2vf_info_v2 *pf2vf_v2 = NULL;
+
+				pf2vf_v2 = (struct amdgim_pf2vf_info_v2 *)adev->virt.fw_reserve.p_pf2vf;
+				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_L & 0xFFFFFFFF) |
+						((((uint64_t)pf2vf_v2->bp_block_offset_H) << 32) & 0xFFFFFFFF00000000);
+				bp_block_size = pf2vf_v2->bp_block_size;
+
+				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
+			}
+
 			checkval = amdgpu_virt_fw_reserve_get_checksum(
 				adev->virt.fw_reserve.p_pf2vf, pf2vf_size,
 				adev->virt.fw_reserve.checksum_key, checksum);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
old mode 100644
new mode 100755
index b90e822cebd7..96d84f036e96
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -143,19 +143,27 @@ struct  amdgim_pf2vf_info_v2 {
 	uint32_t vce_enc_max_pixels_count;
 	/* 16x16 pixels/sec, codec independent */
 	uint32_t vce_enc_max_bandwidth;
+	/* Bad pages block position in BYTE */
+	uint32_t bp_block_offset_L;
+	uint32_t bp_block_offset_H;
+	/* Bad pages block size in BYTE */
+	uint32_t bp_block_size;
 	/* MEC FW position in kb from the start of VF visible frame buffer */
-	uint64_t mecfw_kboffset;
+	uint32_t mecfw_kboffset_L;
+	uint32_t mecfw_kboffset_H;
 	/* MEC FW size in KB */
 	uint32_t mecfw_ksize;
 	/* UVD FW position in kb from the start of VF visible frame buffer */
-	uint64_t uvdfw_kboffset;
+	uint32_t uvdfw_kboffset_L;
+	uint32_t uvdfw_kboffset_H;
 	/* UVD FW size in KB */
 	uint32_t uvdfw_ksize;
 	/* VCE FW position in kb from the start of VF visible frame buffer */
-	uint64_t vcefw_kboffset;
+	uint32_t vcefw_kboffset_L;
+	uint32_t vcefw_kboffset_H;
 	/* VCE FW size in KB */
 	uint32_t vcefw_ksize;
-	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 0, 0, (9 + sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 3)];
+	uint32_t reserved[AMDGIM_GET_STRUCTURE_RESERVED_SIZE(256, 0, 0, (18 + sizeof(struct amd_sriov_msg_pf2vf_info_header)/sizeof(uint32_t)), 0)];
 } __aligned(4);
 
 
@@ -254,6 +262,17 @@ typedef struct amdgim_vf2pf_info_v2 amdgim_vf2pf_info ;
 		} \
 	} while (0)
 
+struct virt_ras_err_handler_data {
+	/* point to bad page records array */
+	struct eeprom_table_record *bps;
+	/* point to reserved bo array */
+	struct amdgpu_bo **bps_bo;
+	/* the count of entries */
+	int count;
+	/* last reserved entry's index + 1 */
+	int last_reserved;
+};
+
 /* GPU virtualization */
 struct amdgpu_virt {
 	uint32_t			caps;
@@ -272,6 +291,7 @@ struct amdgpu_virt {
 	uint32_t reg_access_mode;
 	int req_init_data_ver;
 	bool tdr_debug;
+	struct virt_ras_err_handler_data *virt_eh_data;
 };
 
 #define amdgpu_sriov_enabled(adev) \
@@ -323,6 +343,8 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
 int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
 					unsigned int key,
 					unsigned int chksum);
+void amdgpu_release_virt_err_handler_data(struct amdgpu_device *adev);
+int amdgpu_virt_init_err_handler_data(struct amdgpu_device *adev);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
