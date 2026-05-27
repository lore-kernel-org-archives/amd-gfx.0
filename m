Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA1DCD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 23:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E67C10EAB0;
	Wed, 27 May 2026 23:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRKRf2Sb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34A010EAB0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 23:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ajsy6KCPIMl9Lv62WGkwhvpQhY8dvy3lR06j68ScJ8ODB6Jh2X+VPEpbZYorvrknxY76JZeLc9AIrXHLu5QFBzFZC00ee1+TkdvLlCFBLtZWdBsv1qf1ConPPkLLIomouHiOIH3oCGENE7czYsux33ZBgJS01GhntRR9rNxKKoqgTlhavv5CJP3HStZs7QX8/85XZaXSFjquMkxtKxVk+vc+CIyzKR9M+VPx1yZuaFJQpUUoZ+IDyx+sHzkrg30QnTdo6di4UkKe1DbXTP09sd34Q0fQC6GkrRvdlwExJ6bBUTXklDpjI/5Tzv6TZ4CvO/OSlavLSNgGTxeMn990cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNKtXvnv8DZJEF8Air1jsKt1fxJjMTxMikgCyV1pNgE=;
 b=fjvyAIelA2dTppZJGZ9uBLflvRzkYO311koCE4d2OCCLiQxERySP3W7mGx9dYBJyGJTCfMyGR57A/1IXoxPOlp3agJmUA177ZohoY3Pfl5zpdhXZfissYrqkUmgFp3T0Pj5QQ2NYcJh7scs24XZgrhrP404ZetOsO/3YQjkurWyAR/gax/6LPHjWpesE6Mb2B5jyKPjhoLcagDl20xewuE6ph8Ei/Zhav9f8XeNeh/Zikfo/N200XBA551sVtKv7A9QQWi96Rk/p8xH6x3QEsJpAsUoOWOWYgN4KIK5lBxMIxM4WpmkJ/N0PnoZdDIilzkM+wgIIOCnZ50Lny9P0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNKtXvnv8DZJEF8Air1jsKt1fxJjMTxMikgCyV1pNgE=;
 b=MRKRf2SbZu8zWB/MYaCiYXGMbUvKCPjMIsi9l2yDQbDejLjIIg8xJQsw8//sFocptOHVxxoJLlUJ21TJ6DvLjQ6DO19OCsudx2l+1nU4uYlBzfyd7ehvyrnbr0xpCo3NqfDhEy/a7YIexmc3EhU/IO7p9P6srz7ujWPYR3diDpI=
Received: from BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 23:36:16 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::8e) by BL1PR13CA0127.outlook.office365.com
 (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Wed, 27
 May 2026 23:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 23:36:15 +0000
Received: from yunxiali-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 18:36:15 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/ras: add ras_suspend callback and use it for
 cp_ecc_error_irq
Date: Wed, 27 May 2026 19:35:03 -0400
Message-ID: <20260527233504.1830940-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260527233504.1830940-1-Yunxiang.Li@amd.com>
References: <20260527233504.1830940-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 366f3609-c0bb-4aed-a02e-08debc48beb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|5023799004|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uL35m5UZbYhxdFwHpySQf4/0jfYoFJm3dgbrnjcmbc4criDHr4KykXlRgRxePtjTrOzF1+S/sQXNuinPBRFhEuJtCF3Y4JE0LuSLT18PRWv8LKK3W5UIld369sn8B3BIiFhjCTl2lZ1KRja9YiftC6SoeRoVlQhKmkfoGpDrot5oawTluQbwjNghho/F+qNhprfPUxlQJFouKvs6Q6PYb8r6B6Bz1IlwbpysIm9eu1qb3H2sBrU3pPBl8UYAEqQweJ8Rs1NKt1oXGq9K6UfjJ+/VS015rND3mlKLYBCipqCUQnijSYoHIE7HhB4mcKPSJ04rqWHhpzBRXUOYfUiT0ILrKIjNggtVwWka1qGe1z26SROrN89RMtvIaovEj9JspUFUD5PpnTYY0u6AIO+G4K4lYGcCAtT0IUzAb/D+Gx3W6Z8FGTUfkdECt+XhqgECZ6Mj5r65G2MFK+CExwjKKrl/Zmrywy95m5bZcSbWV+KQSvIVAu+tkMdv5SFK3kcZSm5hoeVEkrOhfVjemuToi1+WByZJcZyqlLmNw1OGriYS6sVqzd3/xp/QGijcpDMYcDbj057MzFN75dSXYQa8S1VXDKagzcG4u0S443Oxq6swqaKC6oEsSFLs9mctQxO5PI6YCLZoxTQSDITzVqK5sso8hg9/ER/s6+vaNLtvQu/cr0IG+q0u9I5UYGMuAmL8YxL4CY4Aj+Vy6NRJXSCLqWAAz8YDd+NSSc8C1uThDEs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(5023799004)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pi3QD+GyDM7bKkG6lptHTk+w85QEbOUzgv6F5vztv9Wwek1WtjEh1PrFr7xwtB0hwctxz45mEojnuugLGXE+XbOo+wQb2WYNjMwv0Zc2haQS+gn5V0rNVdYCdENW6PTyAakJLSFix8toz5bcZJ3FEqLLI+OTpLQVV5Ubk61GFqdwpymn5usweM4YelMus92Sh1TNX/b+gQNNwp7Mv4/LTj81zvqlTK71B8N6FkNw2OhzC01qVJsPLdxW5ypitSKd6dyZd80DExKzdW424oOsBgeR55vXrrQckxFVPhoJTMGGV495iHQBy2q9+GCBZ7Reylg0+70SNIZAJhR9ih+JMUoZmJxcSOIoRVcYOG7urNLzeRUEHrknuL4e7Ma+BwFfBLYjDUWkXUIqdCKqbN15nC9nktsHGRRaQtiw8cLVKlem9CpCXcGWpBxuPTsw1+6C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:36:15.5964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366f3609-c0bb-4aed-a02e-08debc48beb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cp_ecc_error_irq is acquired in amdgpu_gfx_ras_late_init() but
released in gfx_v9_0_hw_fini(), so the put site has to query
amdgpu_irq_enabled() because the get is skipped on SR-IOV VF.

ras_late_init / ras_fini have no suspend counterpart, so move the
put to amdgpu_gfx_ras_suspend() / amdgpu_gfx_ras_fini() and add a
matching ras_suspend callback that is invoked from
amdgpu_ras_suspend() before disable_all_features().  The get and
put now sit in the same place and check the same condition (not
VF, funcs registered), no refcount querying needed.

An active flag gates ras_fini so the
suspend-then-unload-without-resume path falls into
amdgpu_ras_block_late_fini_default() instead of double-releasing
what ras_suspend already cleaned up.

Drop the cp_ecc_error_irq put from gfx_v9_0_hw_fini().  gfx_v8_0
manages cp_ecc_error_irq locally and is unaffected; no other GFX
generation has this IRQ.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 26 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 32 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 --
 5 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 515cc4a2aeb4d..1e190fb54a977 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -983,38 +983,50 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
 			r = amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
 			if (r)
 				return r;
 		}
 
 		r = amdgpu_ras_block_late_init(adev, ras_block);
 		if (r)
 			return r;
 
-		if (amdgpu_sriov_vf(adev))
-			return r;
-
-		if (adev->gfx.cp_ecc_error_irq.funcs) {
+		if (!amdgpu_sriov_vf(adev) && adev->gfx.cp_ecc_error_irq.funcs) {
 			r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 			if (r)
 				goto late_fini;
 		}
 	} else {
 		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
 	}
 
 	return 0;
 late_fini:
 	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
 
+void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev,
+			    struct ras_common_if *ras_block)
+{
+	if (!amdgpu_sriov_vf(adev) && adev->gfx.cp_ecc_error_irq.funcs)
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+}
+
+void amdgpu_gfx_ras_fini(struct amdgpu_device *adev,
+			 struct ras_common_if *ras_block)
+{
+	if (!amdgpu_sriov_vf(adev) && adev->gfx.cp_ecc_error_irq.funcs)
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	amdgpu_ras_block_late_fini(adev, ras_block);
+}
+
 int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 {
 	int err = 0;
 	struct amdgpu_gfx_ras *ras = NULL;
 
 	/* adev->gfx.ras is NULL, which means gfx does not
 	 * support ras function, then do nothing here.
 	 */
 	if (!adev->gfx.ras)
 		return 0;
@@ -1029,20 +1041,26 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 
 	strcpy(ras->ras_block.ras_comm.name, "gfx");
 	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__GFX;
 	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 	adev->gfx.ras_if = &ras->ras_block.ras_comm;
 
 	/* If not define special ras_late_init function, use gfx default ras_late_init */
 	if (!ras->ras_block.ras_late_init)
 		ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
 
+	if (!ras->ras_block.ras_suspend)
+		ras->ras_block.ras_suspend = amdgpu_gfx_ras_suspend;
+
+	if (!ras->ras_block.ras_fini)
+		ras->ras_block.ras_fini = amdgpu_gfx_ras_fini;
+
 	/* If not defined special ras_cb function, use default ras_cb */
 	if (!ras->ras_block.ras_cb)
 		ras->ras_block.ras_cb = amdgpu_gfx_process_ras_data_cb;
 
 	return 0;
 }
 
 int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 						struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 77050f9884f20..54c1eb9c499ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -608,21 +608,22 @@ bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int xcc_id,
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
 					       struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_gfx_ras_fini(struct amdgpu_device *adev);
+void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_if *ras_block);
+void amdgpu_gfx_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 int amdgpu_get_gfx_off_entrycount(struct amdgpu_device *adev, u64 *value);
 int amdgpu_get_gfx_off_residency(struct amdgpu_device *adev, u32 *residency);
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value);
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry);
 int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry);
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c38af6d3599ed..bc91a5d0b9075 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -88,20 +88,23 @@ const char *ras_mca_block_string[] = {
 	"mca_mp1",
 	"mca_mpio",
 	"mca_iohc",
 };
 
 struct amdgpu_ras_block_list {
 	/* ras block link */
 	struct list_head node;
 
 	struct amdgpu_ras_block_object *ras_obj;
+
+	/* set by ras_late_init, cleared by ras_suspend/ras_fini */
+	bool active;
 };
 
 const char *get_ras_block_str(struct ras_common_if *ras_block)
 {
 	if (!ras_block)
 		return "NULL";
 
 	if (ras_block->block >= AMDGPU_RAS_BLOCK_COUNT ||
 	    ras_block->block >= ARRAY_SIZE(ras_block_string))
 		return "OUT OF RANGE";
@@ -4607,24 +4610,37 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 				/* there should be no any reference. */
 				WARN_ON(alive_obj(obj));
 			}
 		}
 	}
 }
 
 void amdgpu_ras_suspend(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_block_list *node;
+	struct amdgpu_ras_block_object *obj;
 
 	if (!adev->ras_enabled || !con)
 		return;
 
+	/* run per-block ras_suspend before tearing down the RAS context */
+	list_for_each_entry(node, &adev->ras_list, node) {
+		if (!node->active)
+			continue;
+
+		obj = node->ras_obj;
+		if (obj && obj->ras_suspend)
+			obj->ras_suspend(adev, &obj->ras_comm);
+		node->active = false;
+	}
+
 	amdgpu_ras_disable_all_features(adev, 0);
 	/* Make sure all ras objects are disabled. */
 	if (AMDGPU_RAS_GET_FEATURES(con->features))
 		amdgpu_ras_disable_all_features(adev, 1);
 }
 
 int amdgpu_ras_late_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_block_list *node, *tmp;
 	struct amdgpu_ras_block_object *obj;
@@ -4664,22 +4680,29 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
 			continue;
 
 		if (obj->ras_late_init) {
 			r = obj->ras_late_init(adev, &obj->ras_comm);
 			if (r) {
 				dev_err(adev->dev, "%s failed to execute ras_late_init! ret:%d\n",
 					obj->ras_comm.name, r);
 				return r;
 			}
-		} else
-			amdgpu_ras_block_late_init_default(adev, &obj->ras_comm);
+		} else {
+			r = amdgpu_ras_block_late_init_default(adev, &obj->ras_comm);
+			if (r) {
+				dev_err(adev->dev, "%s failed to execute ras_block_late_init_default! ret:%d\n",
+					obj->ras_comm.name, r);
+				return r;
+			}
+		}
+		node->active = true;
 	}
 
 	amdgpu_ras_check_bad_page_status(adev);
 
 	return 0;
 }
 
 /* do some fini work before IP fini as dependence */
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 {
@@ -4704,25 +4727,26 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
 	if (!adev->ras_enabled || !con)
 		return 0;
 
 	amdgpu_ras_critical_region_fini(adev);
 	mutex_destroy(&con->critical_region_lock);
 
 	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
 		if (ras_node->ras_obj) {
 			obj = ras_node->ras_obj;
-			if (amdgpu_ras_is_supported(adev, obj->ras_comm.block) &&
-			    obj->ras_fini)
+			/* fall back to default cleanup if ras_suspend already ran */
+			if (ras_node->active && obj->ras_fini)
 				obj->ras_fini(adev, &obj->ras_comm);
 			else
 				amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
+			ras_node->active = false;
 		}
 
 		/* Clear ras blocks from ras_list and free ras block list node */
 		list_del(&ras_node->node);
 		kfree(ras_node);
 	}
 
 	amdgpu_ras_fs_fini(adev);
 	amdgpu_ras_interrupt_remove_all(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ff44190d7d98e..a86ab65aa2f07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -755,20 +755,21 @@ struct ras_debug_if {
 	};
 	int op;
 };
 
 struct amdgpu_ras_block_object {
 	struct ras_common_if  ras_comm;
 
 	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index);
 	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
+	void (*ras_suspend)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 	void (*ras_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 	ras_ih_cb ras_cb;
 	const struct amdgpu_ras_block_hw_ops *hw_ops;
 };
 
 struct amdgpu_ras_block_hw_ops {
 	int  (*ras_error_inject)(struct amdgpu_device *adev,
 			void *inject_if, uint32_t instance_mask);
 	void (*query_ras_error_count)(struct amdgpu_device *adev, void *ras_error_status);
 	void (*query_ras_error_status)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e5a3735d98342..bec0720f70552 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4050,22 +4050,20 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	    !amdgpu_sriov_vf(adev))
 		gfx_v9_4_2_set_power_brake_sequence(adev);
 
 	return r;
 }
 
 static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (amdgpu_irq_enabled(adev, &adev->gfx.cp_ecc_error_irq, 0))
-		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
 		amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_inst_irq, 0))
 		amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	if (amdgpu_irq_enabled(adev, &adev->gfx.bad_op_irq, 0))
 		amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
 
 	/* DF freeze and kcq disable will fail */
 	if (!amdgpu_ras_intr_triggered())
 		/* disable KCQ to avoid CPC touch memory not valid anymore */

base-commit: e08f39913bfa3e8c6a61fc30ee3870d7d156c19f
prerequisite-patch-id: 61de2a725d655efda7db2b8f3e3c2f80f22c7e3e
-- 
2.51.2

