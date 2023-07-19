Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF506EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 14:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2DB10E4BF;
	Wed, 19 Jul 2023 14:36:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA5C10E4BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 14:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAl7wHG2NvUFQijvXJIr7Pm4Zwt9UxUVuujIASS8aGLwPTDppjgjvLQZ7mwzDhy7YIgs9+eYf57slAMhJ/005x9ARUQrp5NvNSgx6zewNC+L+gD2+Gszbp36W1Orx531RcYTFdpKbkNyibjAHwk474o06Bw3uumhHZmk+EhrhtPtO+CDnRstHY0dRRof9bb66VxeY0rtoctpOXPAmD6a9djYAtxl7YcFEo0T0WbjeE1scPo/spCljy+U7oQixqxuPaFANqJ18KWQ5Hb1PA0I0+wOitUTUT9J9BBS9K3xLMXfStO93tasCNibPNxxXotUSfa+9yvCbmTW01mBZr9Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITVxx5eFfG6iIbX5oCYv8c/CjbFP/CUKVYtJhdFnX7A=;
 b=MXzD5Kox5CriSuPAdF9nBeZeVyNKvr8QDlZHLbJgJ0C0chixxv2QKjpFXHMrbFLQA2GcXFEo+B2IwvVgmoOYqEyKWNjOcpYpABjC2EOYsebBINkOX44ViYnyZPHmGE6j0eRtJrt3wBPRGq/dy9JSrhb1Q0YDXZfhv7WAIAo6AJ8RtnuV9VeMpmZh7TSvvj9bVXeskAMAcNmgtSCoA3Yfm6MDlWP/r7YqAWEoi/0mxtI2UqRqwei+lUdwDmca8TJFGH/Sd3WwM+2E3NPdtxDm1JSf0uTIv9ESAIpN78wpc1xsBoiX8IdXvSK4IJkbqfJuOib91EsB+UD4FjQcYd0gwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITVxx5eFfG6iIbX5oCYv8c/CjbFP/CUKVYtJhdFnX7A=;
 b=a1whl4wcSqr+KrJijRs++oFmL9gpObvalMUqTtJ8B7Pu6ZJf//dOkmhYRpOzGufW0THb8+hiK6iXTsyJZRU0SAxng2VNtBqW9DY2Aa5hl49zuPG5z2hDKf3kWJlY09HNb3uk6EtZejMAWczf5IYXrBeYF1Pe57+GqWN+cTakWQs=
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 14:36:22 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::f8) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 14:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 14:36:22 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 09:36:21 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable cooperative groups for gfx11
Date: Wed, 19 Jul 2023 10:36:09 -0400
Message-ID: <20230719143609.3352043-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ee4afe-0242-41a8-12e2-08db8865863d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxh3HwE3Q3u8w4CV9FoMbKAKp+6s6uKxTX01HVtv1XpYUtm8VBvizE3y8d9hmTgmxKJgvN+hODitnysy9X8WOlG+U/Tjq3vZ0d4WQsPJewz3cLWPumllhgpPltPDx5hFAKY6+Uqtiw5cdHF2EQDbn5P3d9er0+S7HuM58IMjmKQiT0CGipCbyriphs8IEn3d+I84VtrMvOV7+/sAZo1gUecc+uZLSevteGAI6pA6dgb9BtzOD3ZYgj7VtKzXdkLmIgrXAzQaQy0r3c0L34wlKjdMhP3FUOWlxO2DywsJP05WLfgezSAXX8y9TrysiQkBxp+oUHBUE0LtQpN9ZBF8M34C1L73eTdnnrg/2eDa817QLckTeMexWmMgfkqcNBTaSq7VchW2aXFz/MBpZ7czUsebtMrlIZOSdc7HBE4NrJrH/xjk3FKfC2K8tZKVvGJXv5G8e4YvMF/bBmQSLdBN9t916a4aiRYmGRlq3k1+jG+Mjm6uXMlQww/hhg8ElzOXJJB0y7pF0R/0ewXUTNzqBuwrOq7GHAEQEqA36ZH6d4Fz067jEDjvbWbGLMYSos+xhEWvH1Kt9uarVL71Awq/phxeyaepz3Upek7TZaR7jfGJsQ26PJz3AO3j3AxMM40YV9Kwh+wWCLqELALNejxxlKa5Zl5+3CFsWsrjjIbmDY8JyXFlekInHd4JC1TBEpSBplQ9dODffYrwpjsQ6MQQsoNPGyuRwRaYT4NmZaZ11ZIDIxgmeZllh+13gjaobUbBHi7UbsqPrb764QGKF3Hz0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(66899021)(478600001)(7696005)(6666004)(54906003)(426003)(36860700001)(83380400001)(2616005)(47076005)(36756003)(40460700003)(86362001)(40480700001)(26005)(2906002)(16526019)(336012)(186003)(1076003)(82740400003)(5660300002)(8936002)(70586007)(81166007)(6916009)(316002)(4326008)(44832011)(41300700001)(70206006)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:36:22.7499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ee4afe-0242-41a8-12e2-08db8865863d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES can concurrently schedule queues on the device that require
exclusive device access if marked exclusively_scheduled without the
requirement of GWS.  Similar to the F32 HWS, MES will manage
quality of service for these queues.
Use this for cooperative groups since cooperative groups are device
occupancy limited.

Since some GFX11 devices can only be debugged with partial CUs, do not
allow the debugging of cooperative groups on these devices as the CU
occupancy limit will change on attach.

In addition, zero initialize the MES add queue submission vector for MES
initialization tests as we do not want these to be cooperative
dispatches.

v2: fix up indentation and comments.
remove unnecessary perf warning on oversubscription.
change 0 init to 0 memset to deal with padding.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c              |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h              |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c               |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c               |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c              |  6 +++++-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    |  7 ++-----
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   | 12 ++++++++----
 drivers/gpu/drm/amd/include/mes_v11_api_def.h        |  4 +++-
 9 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f808841310fd..72ab6a838bb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -642,6 +642,8 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
 	unsigned long flags;
 	int r;
 
+	memset(&queue_input, 0, sizeof(struct mes_add_queue_input));
+
 	/* allocate the mes queue buffer */
 	queue = kzalloc(sizeof(struct amdgpu_mes_queue), GFP_KERNEL);
 	if (!queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 2d6ac30b7135..2053954a235c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -224,6 +224,7 @@ struct mes_add_queue_input {
 	uint32_t	is_kfd_process;
 	uint32_t	is_aql_queue;
 	uint32_t	queue_size;
+	uint32_t	exclusively_scheduled;
 };
 
 struct mes_remove_queue_input {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 1bdaa00c0b46..8e67e965f7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -214,6 +214,8 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
 	mes_add_queue_pkt.gds_size = input->queue_size;
 
+	mes_add_queue_pkt.exclusively_scheduled = input->exclusively_scheduled;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 40ac093b5035..e0f9cf6dd8fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1487,7 +1487,8 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
 		goto out_unlock;
 	}
 
-	if (!kfd_dbg_has_gws_support(dev) && p->debug_trap_enabled) {
+	if (p->debug_trap_enabled && (!kfd_dbg_has_gws_support(dev) ||
+				      kfd_dbg_has_cwsr_workaround(dev))) {
 		retval = -EBUSY;
 		goto out_unlock;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ccfc81f085ce..1f82caea59ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -753,7 +753,8 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 		if (!KFD_IS_SOC15(pdd->dev))
 			return -ENODEV;
 
-		if (!kfd_dbg_has_gws_support(pdd->dev) && pdd->qpd.num_gws)
+		if (pdd->qpd.num_gws && (!kfd_dbg_has_gws_support(pdd->dev) ||
+					 kfd_dbg_has_cwsr_workaround(pdd->dev)))
 			return -EBUSY;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0b3dc754e06b..ebc9674d3ce1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -508,6 +508,7 @@ static int kfd_gws_init(struct kfd_node *node)
 {
 	int ret = 0;
 	struct kfd_dev *kfd = node->kfd;
+	uint32_t mes_rev = node->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
 
 	if (node->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		return 0;
@@ -524,7 +525,10 @@ static int kfd_gws_init(struct kfd_node *node)
 		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
 		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
 			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
-			&& kfd->mec2_fw_version >= 0x6b))))
+			&& kfd->mec2_fw_version >= 0x6b) ||
+		(KFD_GC_VERSION(node) >= IP_VERSION(11, 0, 0)
+			&& KFD_GC_VERSION(node) < IP_VERSION(12, 0, 0)
+			&& mes_rev >= 68))))
 		ret = amdgpu_amdkfd_alloc_gws(node->adev,
 				node->adev->gds.gws_size, &node->gws);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 761963ad6154..71b7f16c0173 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -237,10 +237,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	}
 	queue_input.queue_type = (uint32_t)queue_type;
 
-	if (q->gws) {
-		queue_input.gws_base = 0;
-		queue_input.gws_size = qpd->num_gws;
-	}
+	queue_input.exclusively_scheduled = q->properties.is_gws;
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
@@ -250,7 +247,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			q->properties.doorbell_off);
 		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
-}
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index ba9d69054119..e8ee52d70a19 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -123,7 +123,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	if (!gws && pdd->qpd.num_gws == 0)
 		return -EINVAL;
 
-	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3)) {
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) && !dev->kfd->shared_resources.enable_mes) {
 		if (gws)
 			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
 				gws, &mem);
@@ -136,7 +136,9 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	} else {
 		/*
 		 * Intentionally set GWS to a non-NULL value
-		 * for GFX 9.4.3.
+		 * for devices that do not use GWS for global wave
+		 * synchronization but require the formality
+		 * of setting GWS for cooperative groups.
 		 */
 		pqn->q->gws = gws ? ERR_PTR(-ENOMEM) : NULL;
 	}
@@ -173,7 +175,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
 		if (pqn->q && pqn->q->gws &&
-		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
+				KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+					!pqn->q->device->kfd->shared_resources.enable_mes)
 			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
 				pqn->q->gws);
 		kfd_procfs_del_queue(pqn->q);
@@ -455,7 +458,8 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		}
 
 		if (pqn->q->gws) {
-			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
+			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+						!dev->kfd->shared_resources.enable_mes)
 				amdgpu_amdkfd_remove_gws_from_process(
 						pqm->process->kgd_process_info,
 						pqn->q->gws);
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 0997e999416a..b1db2b190187 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -275,7 +275,9 @@ union MESAPI__ADD_QUEUE {
 			uint32_t trap_en		: 1;
 			uint32_t is_aql_queue		: 1;
 			uint32_t skip_process_ctx_clear : 1;
-			uint32_t reserved		: 19;
+			uint32_t map_legacy_kq		: 1;
+			uint32_t exclusively_scheduled	: 1;
+			uint32_t reserved		: 17;
 		};
 		struct MES_API_STATUS		api_status;
 		uint64_t                        tma_addr;
-- 
2.25.1

