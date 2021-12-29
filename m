Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436FAC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E99A10E3C0;
	Wed, 29 Dec 2021 06:33:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B0710E3D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF1LfRGX8cvpXOZspSmmm8E0l8hGQx/yeHjSGrV+zKMrB14YJNS6hiMA/dgQgo8jJIWB3xHk+t8St3yGZ5Wkc+dE7iZhqBxaykSt7kG2dRyDKppoW1Ch7NosT/EdQ5oBtf3QgDFTgAmJXg8kC14e29DMC2rBs+2PZ5AncCk14Lv6LX3szfZf6EHWMb5fQC7tTFuuBb55Cf7KXAN5BhF+2/GmgG3M00ptkkMZNf8E6nEtpx6q64mbjg65IFaz/tyTd7t3JYNJb4E5FZBUQyJHGdj5zv9XptxrtHV00z9arMnzN/f80Bss77mZkYzXu+f14GWRru/h4TLXCY9Q1zaBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08YoQUngYb51YgKAmvBOjokyq4rZD+Xe6QQh/adV0T0=;
 b=KNp3bqH8mNDnWiVsBLJ+EnG3cONv/zSQ5CC/WkOCMObTddVZfpuGPNL7QnKJXwzoMftbukeYxsEqIfpClJOggiL0kaZTJyvWFEVMQQd2EOUTraK30zHVn5//q/MtMa5whosqXFDcuXUX5N/kseQzlY81R3SohEi+MoOT+K+ZCLC1ewS7MokGrfFtUBua11E9lj1mishqjANhtBEKI3whdbIdBJ8XPFFk+hos4HJ2erks8L8efxHcE4evJViKmKXzlAsooh1o8HEcfaBdsAK06EC6r/gT1EvtYdpibytAluDOBa7O0K4cltVIkTBPikRBW+OmgYE4b/onUVpC23zxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08YoQUngYb51YgKAmvBOjokyq4rZD+Xe6QQh/adV0T0=;
 b=zZ1/oMm2m3Bp8UKgr775/LyxFPzLWh7LiYQHCfNQVA6aa6JfE5UShLX6bSbwawtUeYStrETC/BT1S6q2I7kotHs4KB9m00vezUoWY6+1Mpr1i6V8QMbkdx3cLOI/Yj50ZlVVoEHMWH0PsnQ2QIcxTxt4UuE2+FaHv/F+u0bLk3w=
Received: from MWHPR22CA0058.namprd22.prod.outlook.com (2603:10b6:300:12a::20)
 by MWHPR1201MB0062.namprd12.prod.outlook.com (2603:10b6:301:54::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 06:32:58 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::a0) by MWHPR22CA0058.outlook.office365.com
 (2603:10b6:300:12a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Wed, 29 Dec 2021 06:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:32:57 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:32:54 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 03/12] drm/amdgpu: Modify gfx block to fit for the unified
 ras block data and ops
Date: Wed, 29 Dec 2021 14:32:02 +0800
Message-ID: <20211229063211.43840-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1aeaf2b-8c13-4f9c-f157-08d9ca950d77
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0062:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0062EB94B567D208058BAEF3FC449@MWHPR1201MB0062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cTtvhWauNDawEZ7XxP5dQPHLhjB8bovB6p9HLIGylXe9pFsgZz/V1msoALjFdAOnNhXtnJgwU9xGB4G+/WMrLaPhKKB/UOkM1VU+PKcKdG1kMXpLgpuOFk+RUXHhIMyVaWDrN13lIFzMJdQCzRd54vDxE9o3Q2lZuyTtMKwNl2KpNKAN/UE5+sAZtuHi6WYRPvIbC5jhWGuBDRh0n7/H5bEzERlttF6dUpw+DAm4q/bpysq6tbD1DE8DBSBkupxJs2w1O0AiQRi3J/i9fRGnycZIsBRiQgeCGGQX1z1j3sbUeTXz5TsNllogRwVGW2LWT2I3Oz1q6f0aJDjflr7Uh/54PdZ9e8MmZST40OQ5x2zH5X6j2eE3xaAahEYEB1ebrkWrBDhw+gecNUUwtztjtOrQYRRJL/4c2CRhGLWfgj7TedJu76Yd5Qn/9YIT4Ozlq1JZ3OImEOhTLgxT08RXFtbwMxMlkPkuBGjYOTRNNoXaYOSCqBhG7EvrQbXrlBUMXNoqHtey8Hj6TyGsQB+RMsIlpcaJMXhPPGCGbHCnQHWSAKHMB0yNpYI4swVCnKjTx0Fs9FtmaePmd9MSFbHpotX8Zi6rhNNDM14EJR9mMdQYEaw9AFrm4i3xThaqY1Js1U+49h8O3MYE8HbwlH3sQ9/PBLZRfVdPvrCCijsSvyGwJzqm0p+3+B7ngRIN+SKA257hqFl7so6BiDqPsBp41eTEu3jTbOd5eca12R81NJJaaHCLCBa4C9SNLac2Nc/LsXimF7ncBzMh14Ksdxusl+fngYEsFm8cxQSxxskdRxj0dvQzMrbJ4JsEWRCZr4bVYoXdP7N9Ue2//gvRXqzgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(508600001)(2616005)(186003)(16526019)(426003)(26005)(5660300002)(82310400004)(47076005)(83380400001)(7696005)(8676002)(336012)(36756003)(6916009)(70586007)(70206006)(81166007)(356005)(40460700001)(8936002)(36860700001)(1076003)(4326008)(86362001)(316002)(6666004)(2906002)(54906003)(30864003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:32:57.2819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1aeaf2b-8c13-4f9c-f157-08d9ca950d77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0062
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify gfx block to fit for the unified ras block data and ops.
2.Change amdgpu_gfx_ras_funcs to amdgpu_gfx_ras, and the corresponding variable name remove _funcs suffix.
3.Remove the const flag of gfx ras variable so that gfx ras block can be able to be inserted into amdgpu device ras block link list.
4.Invoke amdgpu_ras_register_ras_block function to register gfx ras block into amdgpu device ras block link list.
5.Remove the redundant code about gfx in amdgpu_ras.c after using the unified ras block.
6.Fill unified ras block .name .block .ras_late_init and .ras_fini for all of gfx versions. If .ras_late_init and .ras_fini had been defined by the selected gfx version, the defined functions will take effect; if not defined, default fill with amdgpu_gfx_ras_late_init and amdgpu_gfx_ras_fini.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 17 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 61 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 65 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 24 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 25 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  2 +-
 8 files changed, 121 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1795d448c700..18e4106aa03b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -622,7 +622,7 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
 	return r;
 }
 
-int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev)
+int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
 	struct ras_fs_if fs_info = {
@@ -696,9 +696,9 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 	 */
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
 		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_count)
-			adev->gfx.ras_funcs->query_ras_error_count(adev, err_data);
+		if (adev->gfx.ras && adev->gfx.ras->ras_block.hw_ops &&
+		    adev->gfx.ras->ras_block.hw_ops->query_ras_error_count)
+			adev->gfx.ras->ras_block.hw_ops->query_ras_error_count(adev, err_data);
 		amdgpu_ras_reset_gpu(adev);
 	}
 	return AMDGPU_RAS_SUCCESS;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6b78b4a0e182..35f2a724616e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -31,6 +31,7 @@
 #include "amdgpu_ring.h"
 #include "amdgpu_rlc.h"
 #include "soc15.h"
+#include "amdgpu_ras.h"
 
 /* GFX current status */
 #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
@@ -213,16 +214,8 @@ struct amdgpu_cu_info {
 	uint32_t bitmap[4][4];
 };
 
-struct amdgpu_gfx_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*ras_error_inject)(struct amdgpu_device *adev,
-				void *inject_if);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-				     void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
-	void (*query_ras_error_status)(struct amdgpu_device *adev);
-	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+struct amdgpu_gfx_ras {
+	struct amdgpu_ras_block_object  ras_block;
 	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
 };
 
@@ -348,7 +341,7 @@ struct amdgpu_gfx {
 
 	/*ras */
 	struct ras_common_if			*ras_if;
-	const struct amdgpu_gfx_ras_funcs	*ras_funcs;
+	struct amdgpu_gfx_ras	*ras;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
@@ -410,7 +403,7 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
-int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev);
+int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, void *ras_info);
 void amdgpu_gfx_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 67a08629711c..8ca1f294c202 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -926,6 +926,7 @@ void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 				  struct ras_query_if *info)
 {
+	struct amdgpu_ras_block_object* block_obj = NULL;
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 	int i;
@@ -933,6 +934,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
+	block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, 0);
+
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
 		if (adev->umc.ras_funcs &&
@@ -953,13 +956,16 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 		break;
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_count)
-			adev->gfx.ras_funcs->query_ras_error_count(adev, &err_data);
+		if (!block_obj || !block_obj->hw_ops)   {
+			dev_info(adev->dev, "%s doesn't config ras function \n",
+						get_ras_block_str(&info->head));
+			return -EINVAL;
+		}
+		if (block_obj->hw_ops->query_ras_error_count)
+			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
 
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_status)
-			adev->gfx.ras_funcs->query_ras_error_status(adev);
+		if (block_obj->hw_ops->query_ras_error_status)
+			block_obj->hw_ops->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -1046,18 +1052,23 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
+	struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+
 	if (!amdgpu_ras_is_supported(adev, block))
 		return -EINVAL;
 
 	switch (block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->reset_ras_error_count)
-			adev->gfx.ras_funcs->reset_ras_error_count(adev);
+		if (!block_obj || !block_obj->hw_ops)   {
+			dev_info(adev->dev, "%s doesn't config ras function \n", ras_block_str(block));
+			return -EINVAL;
+		}
 
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->reset_ras_error_status)
-			adev->gfx.ras_funcs->reset_ras_error_status(adev);
+		if (block_obj->hw_ops->reset_ras_error_count)
+			block_obj->hw_ops->reset_ras_error_count(adev);
+
+		if (block_obj->hw_ops->reset_ras_error_status)
+			block_obj->hw_ops->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
@@ -1122,7 +1133,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		.address = info->address,
 		.value = info->value,
 	};
-	int ret = 0;
+    int ret = -EINVAL;
+    struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
 
 	if (!obj)
 		return -EINVAL;
@@ -1136,11 +1148,13 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->ras_error_inject)
-			ret = adev->gfx.ras_funcs->ras_error_inject(adev, info);
-		else
-			ret = -EINVAL;
+		if (!block_obj || !block_obj->hw_ops)   {
+			dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
+			return -EINVAL;
+		}
+
+		if (block_obj->hw_ops->ras_error_inject)
+			ret = block_obj->hw_ops->ras_error_inject(adev, info);
 		break;
 	case AMDGPU_RAS_BLOCK__UMC:
 	case AMDGPU_RAS_BLOCK__SDMA:
@@ -1761,15 +1775,20 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 					  struct ras_query_if *info)
 {
+	struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
 	/*
 	 * Only two block need to query read/write
 	 * RspStatus at current state
 	 */
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__GFX:
-		if (adev->gfx.ras_funcs &&
-		    adev->gfx.ras_funcs->query_ras_error_status)
-			adev->gfx.ras_funcs->query_ras_error_status(adev);
+		if (!block_obj || !block_obj->hw_ops)   {
+			dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
+			return ;
+		}
+
+		if (block_obj->hw_ops->query_ras_error_status)
+			block_obj->hw_ops->query_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 08e91e7245df..e100d9102846 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -817,7 +817,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
-static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if);
@@ -2127,12 +2127,16 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
 };
 
-static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs = {
-	.ras_late_init = amdgpu_gfx_ras_late_init,
-	.ras_fini = amdgpu_gfx_ras_fini,
-	.ras_error_inject = &gfx_v9_0_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,
+const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = {
+		.ras_error_inject = &gfx_v9_0_ras_error_inject,
+		.query_ras_error_count = &gfx_v9_0_query_ras_error_count,
+		.reset_ras_error_count = &gfx_v9_0_reset_ras_error_count,
+};
+
+static struct amdgpu_gfx_ras gfx_v9_0_ras = {
+	.ras_block = {
+		.hw_ops = &gfx_v9_0_ras_ops,
+	},
 };
 
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
@@ -2161,7 +2165,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		DRM_INFO("fix gfx.config for vega12\n");
 		break;
 	case CHIP_VEGA20:
-		adev->gfx.ras_funcs = &gfx_v9_0_ras_funcs;
+		adev->gfx.ras = &gfx_v9_0_ras;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2187,7 +2191,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			gb_addr_config = RAVEN_GB_ADDR_CONFIG_GOLDEN;
 		break;
 	case CHIP_ARCTURUS:
-		adev->gfx.ras_funcs = &gfx_v9_4_ras_funcs;
+		adev->gfx.ras = &gfx_v9_4_ras;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2208,7 +2212,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config |= 0x22010042;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->gfx.ras_funcs = &gfx_v9_4_2_ras_funcs;
+		adev->gfx.ras = &gfx_v9_4_2_ras;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -2227,6 +2231,25 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	if (adev->gfx.ras) {
+		err = amdgpu_ras_register_ras_block(adev, &adev->gfx.ras->ras_block);
+		if (err) {
+			DRM_ERROR("Failed to register gfx ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->gfx.ras->ras_block.name,"gfx");
+		adev->gfx.ras->ras_block.block = AMDGPU_RAS_BLOCK__GFX;
+
+		/* If not define special ras_late_init function, use gfx default ras_late_init */
+		if (!adev->gfx.ras->ras_block.ras_late_init)
+				adev->gfx.ras->ras_block.ras_late_init = amdgpu_gfx_ras_late_init;
+
+		/* If not define special ras_fini function, use gfx default ras_fini */
+		if (!adev->gfx.ras->ras_block.ras_fini)
+				adev->gfx.ras->ras_block.ras_fini = amdgpu_gfx_ras_fini;
+	}
+
 	adev->gfx.config.gb_addr_config = gb_addr_config;
 
 	adev->gfx.config.gb_addr_config_fields.num_pipes = 1 <<
@@ -2448,9 +2471,8 @@ static int gfx_v9_0_sw_fini(void *handle)
 	int i;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->gfx.ras_funcs &&
-	    adev->gfx.ras_funcs->ras_fini)
-		adev->gfx.ras_funcs->ras_fini(adev);
+	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_fini)
+		adev->gfx.ras->ras_block.ras_fini(adev);
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
@@ -4888,16 +4910,15 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->gfx.ras_funcs &&
-	    adev->gfx.ras_funcs->ras_late_init) {
-		r = adev->gfx.ras_funcs->ras_late_init(adev);
+	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_late_init) {
+		r = adev->gfx.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
 			return r;
 	}
 
-	if (adev->gfx.ras_funcs &&
-	    adev->gfx.ras_funcs->enable_watchdog_timer)
-		adev->gfx.ras_funcs->enable_watchdog_timer(adev);
+	if (adev->gfx.ras &&
+	    adev->gfx.ras->enable_watchdog_timer)
+		adev->gfx.ras->enable_watchdog_timer(adev);
 
 	return 0;
 }
@@ -6841,7 +6862,7 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);
 }
 
-static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -6850,7 +6871,7 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t reg_value;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -6879,8 +6900,6 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	gfx_v9_0_query_utc_edc_status(adev, err_data);
-
-	return 0;
 }
 
 static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index b4789dfc2bb9..c67e387a97f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -863,7 +863,7 @@ static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -872,7 +872,7 @@ static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t reg_value;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -903,7 +903,6 @@ static int gfx_v9_4_query_ras_error_count(struct amdgpu_device *adev,
 
 	gfx_v9_4_query_utc_edc_status(adev, err_data);
 
-	return 0;
 }
 
 static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
@@ -1029,11 +1028,16 @@ static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs = {
-        .ras_late_init = amdgpu_gfx_ras_late_init,
-        .ras_fini = amdgpu_gfx_ras_fini,
-        .ras_error_inject = &gfx_v9_4_ras_error_inject,
-        .query_ras_error_count = &gfx_v9_4_query_ras_error_count,
-        .reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
-        .query_ras_error_status = &gfx_v9_4_query_ras_error_status,
+
+const struct amdgpu_ras_block_hw_ops  gfx_v9_4_ras_ops = {
+	.ras_error_inject = &gfx_v9_4_ras_error_inject,
+	.query_ras_error_count = &gfx_v9_4_query_ras_error_count,
+	.reset_ras_error_count = &gfx_v9_4_reset_ras_error_count,
+	.query_ras_error_status = &gfx_v9_4_query_ras_error_status,
+};
+
+struct amdgpu_gfx_ras gfx_v9_4_ras = {
+	.ras_block = {
+		.hw_ops = &gfx_v9_4_ras_ops,
+	},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
index bdd16b568021..ca520a767267 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
@@ -24,6 +24,6 @@
 #ifndef __GFX_V9_4_H__
 #define __GFX_V9_4_H__
 
-extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs;
+extern struct amdgpu_gfx_ras gfx_v9_4_ras;
 
 #endif /* __GFX_V9_4_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 54306fd45ff1..f5b37176ca30 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1644,14 +1644,14 @@ static int gfx_v9_4_2_query_utc_edc_count(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
+static void gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
 					    void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	uint32_t sec_count = 0, ded_count = 0;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
-		return -EINVAL;
+		return;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -1664,7 +1664,6 @@ static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += sec_count;
 	err_data->ue_count += ded_count;
 
-	return 0;
 }
 
 static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device *adev)
@@ -1934,13 +1933,17 @@ static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
-const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs = {
-	.ras_late_init = amdgpu_gfx_ras_late_init,
-	.ras_fini = amdgpu_gfx_ras_fini,
-	.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
-	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
-	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
-	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
-	.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
+struct amdgpu_ras_block_hw_ops  gfx_v9_4_2_ras_ops ={
+		.ras_error_inject = &gfx_v9_4_2_ras_error_inject,
+		.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
+		.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
+		.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
+		.reset_ras_error_status = &gfx_v9_4_2_reset_ras_error_status,
+};
+
+struct amdgpu_gfx_ras gfx_v9_4_2_ras = {
+	.ras_block = {
+		.hw_ops = &gfx_v9_4_2_ras_ops,
+	},
 	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index 6db1f88509af..7584624b641c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -31,6 +31,6 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
 
-extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
+extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
 
 #endif /* __GFX_V9_4_2_H__ */
-- 
2.25.1

