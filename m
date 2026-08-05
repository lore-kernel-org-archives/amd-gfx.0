Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33BFC561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 21:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4746910EFFA;
	Wed,  5 Aug 2026 21:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cS+7WbcH";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF09D10EFFA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 21:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLAA7/RHfwTR5NKOzuET9BKVjE9tWvvECyAT+ev9Vubdt7luT3vg3TDdDTE4Ty29KlVU0H0WqA9ASBk5JCMIdJdSkG+pi55eNMZ9scP+QPk9BvgGAsRdryQh/DSzhZgvhnRlAGzvDAVB/nrtK6JncaVK92HjxYOfFA6JSJy/Y8/X4+LpOG8EeVR3t2Xyb1koRQm86guAMFaxskhouIr1y4XLXPlDox/aHUKNRafUqraXjhbIRQvul6iSSgbG19wxMvMeMd7tF80QJiZmcQrcbICHapYu9Ze3Eg6KpjriGGWcZZQXYH3fXSTf+JPlWyngky8SDbFd1iD9R8bt2smt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8B0DhIXvw8WVpTvTW+IC3t+TH7W85j8f7rh6E4adAA=;
 b=aGjBqMnNkh6MUK9LirRGteFeserzaulzTxh4KujuvsFdiP1WlkxgjOvTp/w2RzpEGRyyjTcfpcEl3T09m2VBAYK9puLoAMMQcHM8HzRMThc/XkKaxvXw4UR/VQ+v3UUgzDBaTyKTgyCKDTkYCJDyTWb7aIddf23KdTwEk7Ekoky01xQjVEjuyLQD1XECBGb8fErZLc3HQW3Cj1TOCY4vrxP/0GEpPwhuEku/cWMMdRC2oCQK5VAahi3O7Hbg5cwIkFLGO+A0mnycPSGcSgrFREp/ZwHg8G1SUTC19xxueKX3v/MlIrUosNW2Wtq2aHEOmh4xzNNBRKLtCPJr15a3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8B0DhIXvw8WVpTvTW+IC3t+TH7W85j8f7rh6E4adAA=;
 b=cS+7WbcHvUD/3hmEJdKtUVLNKb1BAgyKZUQDuXn0E6oKlgtmkMtZ/PlEuUlUlN9MC4J0u48gTw4Ds1kTrGxp/iDqIvreLQN9bDqzVsy5NDGlQfRvdF9E88k70hz2ziHyHKktExuKIlLO4h5VZz0L9AoSQ+jHG9QMYsgJvA8AVGM=
Received: from CH5PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:1ed::20)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 21:27:51 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::c) by CH5PR02CA0018.outlook.office365.com
 (2603:10b6:610:1ed::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 21:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Wed, 5 Aug 2026 21:27:51 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 5 Aug 2026 16:27:50 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tishko.Araz@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: workaround 100% gpu usage issue for gfx11
Date: Wed, 5 Aug 2026 17:27:22 -0400
Message-ID: <20260805212722.247508-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805212722.247508-1-jinhuieric.huang@amd.com>
References: <20260805212722.247508-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 238a1b0f-7d98-49a7-294f-08def3386765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: hoxM99QGNh1zKHXwv0JlcudW+DNMnFBYrpg7eKzrWf7ht/F3We9RztMd+/p+GsJY/ndeSK3L9vDdNfCFwp6pymY8Zsk3/6o4VGn/kvchV29ucZq9as7s6pezmfdF8FFy0z92A/YGo+I0RrFsOZ1Nx3HTGfKOp2y3yWj/RZ56wWRvg22O6Aa3IEFbkCsSFxze9wb2Z0BKER+bcPwDf+UeWlV7T3SusImsMOJq44GlesdgVmGLWow3QXuKRHBfWVYviQEt9POzyfWIawlY3ZkshlstEGo3BFoJ872z7NPQsmIUNKmTVbQrK8oG0StRlw08EQ0sQZjZrnQ/B1IOb9rfL65AtMyPLockTl4BEFPKyXjEzGGiDDsGnNGDfjPw4/ECXsJ0VILvpi+JIuT5Jtv4g9ILv0JbWHAs1tPLxTN11Uxh0A5dvv0rhMpJ6HwYzVU1+fAgE0U/CAIyXsYaih3lefhPWM1bFIWduVoXPPp8dY7r5etAC7d6k5qxn/kGiWKethrIB4Mnj7x4HtZdpB/ocaHbtTeQ9ZfG3jQtuijXFwzr56RDM8/lMXFZ6a06Jg85Sj7M6ixhivE7qhZpt2N6Kd/rBBlwWLsRyT9UT19P7AWeAYKtDFORDcJ771IvYhAc2WfgUxuXxTUB9yVu2/jW9qgcszUNzSnKb56r6ItIIVSMO454UttzH4aCRYraV7getzjBGnFru8N224Pmbg4EUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UREEHz5XH7JboW0QfKdiaGcnWtb0gO188i+1RAOP0uryqBe2RDF4t4i41OTWqx/jNOT9Unn1vJ2bTsme2HuEtYuc2HQ1z5X+l/ALDQv3ZpfmaVR0mADJEXlNYTSbO31l34KABaCF187HdtDTjExTdbQ6RbTrm+GapBzkzGjPvl+bWea1C9YBl8CGeUU8BV3mB7S8d9+uBU8bPJzdKdUoZfIHjT4ZHg/oxfcEPEwfmHMYXl19XWEcQ/pUIzqhna6pG9jL3UDjjF0JljmJnyRFPPoZIQY8VqNFRq0auyzZXaoByNljPSzixnToIbcBmLHA0FaFriKJ9I2a5cIDpp9jqoZipcpRqeA+mAJU7dTgArIC2N6HGbf15SO1wttVFl6zGjARZzT+c5Zgiws7zRaK/iCYTjTXHoNd51w3HkgthQ1FeOUhFtItKsakhW3fcqds
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 21:27:51.1049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 238a1b0f-7d98-49a7-294f-08def3386765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
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

the issue only happens with oversubscription when gpu has no
workload, the root cause is mes oversubscription timer, so
disable mes timer and make a similar timer in kfd to resolve
the issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bc0ee6ccfca7..40683db66a13 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1019,7 +1019,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
-	mes_set_hw_res_pkt.oversubscription_timer = 50;
 	if (adev->mes.use_rs64mem)
 		mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx = 1;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ea9d87450eae..350e0ce308d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -47,6 +47,9 @@
 /* See unmap_queues_cpsch() */
 #define USE_DEFAULT_GRACE_PERIOD 0xffffffff
 
+/* Interval for notifying MES of work on unmapped queues during oversubscription */
+#define DQM_MES_UNMAP_NOTIFY_DELAY_MS 50
+
 static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
 				  u32 pasid, unsigned int vmid);
 
@@ -276,8 +279,16 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			q->properties.doorbell_off);
 		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
+		return r;
 	}
 
+	/* GFX11: start notify timer only once when oversubscription begins */
+	if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
+	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
+	    dqm->active_cp_queue_count > get_cp_queues_num(dqm))
+		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
+				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
+
 	return r;
 }
 
@@ -354,7 +365,16 @@ static void set_perfcount(struct device_queue_manager *dqm, int enable)
 static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			    struct qcm_process_device *qpd)
 {
-	return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
+	int r = remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
+
+	/* GFX11: stop notify timer when oversubscription clears */
+	if (!r &&
+	    KFD_GC_VERSION(dqm->dev) >= IP_VERSION(11, 0, 0) &&
+	    KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
+	    dqm->active_cp_queue_count <= get_cp_queues_num(dqm))
+		cancel_delayed_work(&dqm->notify_unmap_work);
+
+	return r;
 }
 
 static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
@@ -3088,6 +3108,20 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 	amdgpu_amdkfd_free_kernel_mem(dev->adev, &mqd->mem);
 }
 
+static void mes_notify_unmap_work_handler(struct work_struct *work)
+{
+	struct device_queue_manager *dqm =
+		container_of(work, struct device_queue_manager,
+			     notify_unmap_work.work);
+
+	amdgpu_mes_notify_unmap_queue((struct amdgpu_device *)dqm->dev->adev);
+
+	/* Re-arm if still oversubscribed */
+	if (READ_ONCE(dqm->active_cp_queue_count) > get_cp_queues_num(dqm))
+		queue_delayed_work(system_wq, &dqm->notify_unmap_work,
+				   msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_DELAY_MS));
+}
+
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 {
 	struct device_queue_manager *dqm;
@@ -3213,6 +3247,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 
 	if (!dqm->ops.initialize(dqm)) {
 		init_waitqueue_head(&dqm->destroy_wait);
+		INIT_DELAYED_WORK(&dqm->notify_unmap_work,
+				  mes_notify_unmap_work_handler);
 		return dqm;
 	}
 
@@ -3229,6 +3265,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
+	cancel_delayed_work_sync(&dqm->notify_unmap_work);
 	dqm->ops.stop(dqm);
 	dqm->ops.uninitialize(dqm);
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c9f9f7a87111..21cf3c16f3f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -281,6 +281,7 @@ struct device_queue_manager {
 	uint32_t		wait_times;
 
 	wait_queue_head_t	destroy_wait;
+	struct delayed_work	notify_unmap_work;
 
 	/* for per-queue reset support */
 	struct dqm_detect_hang_info *detect_hang_info;
-- 
2.34.1

