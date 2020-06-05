Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1140C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 05:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93377207D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 05:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fHUl7P6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93377207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A4B6E83F;
	Fri,  5 Jun 2020 05:53:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA856E83F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 05:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSKw+zBH12MOzjMcRcTooG1OER3sMbh2xSNQSi8FvRGp2RV+VK6NZ9rUNaCaIztJMUK2MYN4S2TTRtrbyJb+52OLP7wN78jW3P8zzINmqtdk+bK0zP7TirBWc2ChR7CaTp6mY52YgFOxTkRh185n35c3RJEHb9Wvs9dRmLHyeruEYqroR9G5KUT617zkQkP6wq8hgOXZRZcgpa/5iPeNL4IMjzHVPwyYg5EqOI2omTLSEWDlC4AdKdCFORlZFvcKOGg7RyqECYaoTOygBMuHKAAVADiWf7v4tHCCsEtxUp16zdK/Zogex/B9sdUtud3ArmOYdYOOFTAg5YpkIZ19Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIwSDrT9SR0RNaV/Bkp0V4oSCNryEXKlnbZfFuxbC2A=;
 b=gdWAOmyWD8NHDm/0CtYKFOoIv/IgvjMkM2dQJmU5qfWrE/1P+1FoZstAB1GsmPvgaT4cL6IwVwextu4kAu6cEa0dlnl05m6rmkFVZcccv94SOuaeUvW3FKUnR5FY5pzLFErHMmVNyPg7lzCceYi9S5YHvOqjJO00k0vi37cvi47ZyGIX6dxKHkPpH4e7CiuxyVZk6Ht4XZ9wUb/41F4N8PYmMVVjW1MjI359HxYNFo/HrnaO4fH1bKSWfrkcw7AC51Wp918fkfgkqbQ6Vx0kN9gfO/gRn0zOfqNoqKnEKMOhu5SQvccf2NIkFe0sX/HNwlooGeqc6QUlCX5O0xTJyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIwSDrT9SR0RNaV/Bkp0V4oSCNryEXKlnbZfFuxbC2A=;
 b=fHUl7P6qtPPYil70WxeaufB2zqAE+meq9LBUQsDqmIjVyowNcnbSZINO9B8mUggDet22zIWhi8CWA1PF6yUYFCGpkuGLvxb/13Ols4ZLJyfMAUUW938PM85pFxnpnVbih7yOGCshuWoVhGdhoy1pVW9yoesFoaH8Eoj64xwg0SA=
Received: from BN6PR1701CA0016.namprd17.prod.outlook.com
 (2603:10b6:405:15::26) by CH2PR12MB3685.namprd12.prod.outlook.com
 (2603:10b6:610:2d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 05:53:38 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::85) by BN6PR1701CA0016.outlook.office365.com
 (2603:10b6:405:15::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Fri, 5 Jun 2020 05:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 05:53:37 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 5 Jun 2020
 00:53:37 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 5 Jun 2020 00:53:35 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3] drm/amdgpu: support reserve bad page for virt
Date: Fri, 5 Jun 2020 13:53:33 +0800
Message-ID: <20200605055333.19933-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966005)(86362001)(47076004)(54906003)(426003)(2616005)(316002)(70586007)(1076003)(70206006)(186003)(4326008)(478600001)(7696005)(36756003)(81166007)(356005)(82310400002)(336012)(26005)(82740400003)(8676002)(8936002)(2906002)(5660300002)(83380400001)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c9321ac-f2a3-4b34-d5c5-08d80914cabc
X-MS-TrafficTypeDiagnostic: CH2PR12MB3685:
X-Microsoft-Antispam-PRVS: <CH2PR12MB36859239523E41016E2E81EB9A860@CH2PR12MB3685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZM0Fo7c1cei7htHqw0l83AkdrO8VaxUoyhJM8MbOjBK+c16wwe3RGrOs/Wbt0RD6ak3eZd7ECMyd4VfiWuDRi69Z2dTLWaKY6UnXWSklCL4YUAN0OtYzH2LNzIEXa2YOIvMWIrymXp9n4t0e/i/hwkUKj/O3dx6yoCvLnj4sv6Ag/v6VsO1db+ic+3CGmEiwdReSXbZa4UTYNrp4mkyH5bMDqqR94T0jmY/jmNs56KFigGSd5+kayFv0xEIRllFF+7c7G6SvquvzU9BudvT4GVigaWBdnbV4IJ65HmvE9ix0SOKnNAKSt9giLWqgUlwyWUj3VPspmtqIcMctvCYinDJHs5lYoj7J1X9rJYkPb+Sd6CzuYwpcJy4zynqC3stK+nHMy3seTQ3tHmWFlYx5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 05:53:37.7864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9321ac-f2a3-4b34-d5c5-08d80914cabc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3685
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

Changed from V1:
	rename some functions name, only init ras error handler data for
	supported asic.

Changed from V2:
	fix poential memory leak.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: Ia0ad9453ac3ac929f95c73cbee5b7a8fc42a9816
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 173 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  30 +++-
 3 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1df28b7bf22e..668ad0e35160 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2326,6 +2326,9 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
+		amdgpu_virt_release_ras_err_handler_data(adev);
+
 	amdgpu_ras_pre_fini(adev);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index bab9286021a7..0891f27ba166 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -26,6 +26,7 @@
 #include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_ras.h"
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
@@ -255,12 +256,171 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj,
 	return ret;
 }
 
+static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data **data = &virt->virt_eh_data;
+	/* GPU will be marked bad on host if bp count more then 10,
+	 * so alloc 512 is enough.
+	 */
+	unsigned int align_space = 512;
+	void *bps = NULL;
+	struct amdgpu_bo **bps_bo = NULL;
+
+	*data = kmalloc(sizeof(struct amdgpu_virt_ras_err_handler_data), GFP_KERNEL);
+	if (!*data)
+		return -ENOMEM;
+
+	bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
+	bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo), GFP_KERNEL);
+
+	if (!bps || !bps_bo) {
+		kfree(bps);
+		kfree(bps_bo);
+		kfree(*data);
+		return -ENOMEM;
+	}
+
+	(*data)->bps = bps;
+	(*data)->bps_bo = bps_bo;
+	(*data)->count = 0;
+	(*data)->last_reserved = 0;
+
+	virt->ras_init_done = true;
+
+	return 0;
+}
+
+static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
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
+void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+
+	virt->ras_init_done = false;
+
+	if (!data)
+		return;
+
+	amdgpu_virt_ras_release_bp(adev);
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
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
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
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
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
+			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
+
+		data->bps_bo[i] = bo;
+		data->last_reserved = i + 1;
+		bo = NULL;
+	}
+}
+
+static bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev,
+		uint64_t retired_page)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
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
+			if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
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
+	struct amdgim_pf2vf_info_v2 *pf2vf_v2 = NULL;
 
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
@@ -275,6 +435,19 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 
 		/* pf2vf message must be in 4K */
 		if (pf2vf_size > 0 && pf2vf_size < 4096) {
+			if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
+				pf2vf_v2 = (struct amdgim_pf2vf_info_v2 *)adev->virt.fw_reserve.p_pf2vf;
+				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_L & 0xFFFFFFFF) |
+						((((uint64_t)pf2vf_v2->bp_block_offset_H) << 32) & 0xFFFFFFFF00000000);
+				bp_block_size = pf2vf_v2->bp_block_size;
+
+				if (bp_block_size && !adev->virt.ras_init_done)
+					amdgpu_virt_init_ras_err_handler_data(adev);
+
+				if (adev->virt.ras_init_done)
+					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
+			}
+
 			checkval = amdgpu_virt_fw_reserve_get_checksum(
 				adev->virt.fw_reserve.p_pf2vf, pf2vf_size,
 				adev->virt.fw_reserve.checksum_key, checksum);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b90e822cebd7..f826945989c7 100644
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
 
+struct amdgpu_virt_ras_err_handler_data {
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
@@ -272,6 +291,8 @@ struct amdgpu_virt {
 	uint32_t reg_access_mode;
 	int req_init_data_ver;
 	bool tdr_debug;
+	struct amdgpu_virt_ras_err_handler_data *virt_eh_data;
+	bool ras_init_done;
 };
 
 #define amdgpu_sriov_enabled(adev) \
@@ -323,6 +344,7 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
 int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
 					unsigned int key,
 					unsigned int chksum);
+void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
 void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
