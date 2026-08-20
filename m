Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94473C5DF87
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 10:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C7C10EFE5;
	Thu, 20 Aug 2026 10:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fzkfpYfY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283A510EFDE
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEEX9NTacbZelQmd8oZ/OXhW0QbcCaA/AQ3gNNQNpn+OGdTWsF5J4aF3WxyF/VJmAaEDvPawnUhLr395GOPjc/6BHRCokHubA235BHS/tiSsOBAXRoE04ORxEMZGuRz6m3WxyioVQcY5kGZocMIbGN1GjB6C7CMZrw2QvQQJExhnG+z6NsyVYDvymB70oU2M3m+mhawNVkFLPyTV6KpbaN4+roCI5oceFZGhc+uoFXPh5FKxaBu//85rxwHWhKPRM70EDViI4p0mMQG+c0yP/Wh2O1pAt7JeRjS+gLzGXhtdAxnDC+vtcGvACc3uUy6lsfzXLjI5zn3BRTtgcuqbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCRcETvbVbQfARADCktsuT6zKUcoPPRKK4rk6EzR1UQ=;
 b=rfAFs8oo9syMUcPOLnYfbBPc/TN1cafiiczTUchoSpbASmrA+fyN+GCG3NYIe+K6UMBRw/KiUOTPIsAJAnV96rTv2Kr3pW0hy1EYyrQc4h15tIgGqB3N4z0uf4fNJsNGBAleMVsWeEvF7OUMOZOMJOE073ItWhks3rfPOWpPUHa5BuDjM+7EHw1TSfcpcnwET5Gbiyq13NVqBfPx0VATwv/e35Ginr8S79IzlB/XAktLgmmxdltcuQ2HJ1UwmDb9wTdyojjXcAdnUzMVPIEcDky5lR2cvlMoKF9/StlBzdubyuEgBWarErFpCLPTt4hYvCYw9LDiTDazPnfW27Gj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCRcETvbVbQfARADCktsuT6zKUcoPPRKK4rk6EzR1UQ=;
 b=fzkfpYfY7AZHG6Of6yE7UNDx2Xc4Hc9I+IG7+mtSWPyxqHTG2WEINcc8J+vDpwS864jly8GXv0hHXNqYjKSta3laQHNuK2pL9RhwFImyXizFt9Sj16C5yYHEb8YuaKM8hU9/JZJ9lU3aZBnJrJ3DzdeaKd2/AiCjgiTRcs6sRQE=
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Thu, 20 Aug 2026 10:55:51 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::19) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 10:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 10:55:51 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 05:55:49 -0500
From: YuanShang Mao <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yuansmao@amd.com>
Subject: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset
Date: Thu, 20 Aug 2026 18:55:37 +0800
Message-ID: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: d4abf724-d6dc-4b09-50ed-08defea99982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: llr9GJo1paz7NcX6zdCHOUQav8YP0Z92odI+6q9ecTTKm27L0MlLXy5415arifMipBqO4eWsL2RVumE3hwGREjYGp5a0iyIN94uOLDY+vfOH2T+CwI4mpzMBz8CyGeTN8PQDpCjkpFN6rqKPh3vq1ywUMm3lO1EjX0bt9OHmRfePypO3okZIvMZNlGpTr3vP3JfBznIK6mOZgFE2NasW4wf1brbGOTXpJzQ4m/sMTIS9irJU8nPaGlSAP9L64YqU5qVlvl1ulsleCcCmhuGlzggVW5W/z5ffutiYODrkIZX/YcyrilqsKvoXtH3rrVnN/nmFjdjboYj4X8aF6W/uncV570bkWrxEpCkTTr0D039Fjp24tXZ0/8/7Rh4f/LgqXfxLcS2o6W+98+ceig8BNAURlQQx1bBUD1ABPm/JRcEugI/2CMt5PnXgaQAP1F3349Vxte9JHbKR3zvEOt1EHzsNSe8tJK7cvgemxSwVWnECjWPvMhCNGuOFRhx3cKEVaxwpygD3zrRMftoRCEeQdOvudS+rx7L6wriHWhj0qmNXbiIa7PrBsIKxx+UUFGkAPz6IwOzDnn8nenW2d4cfGDEbtNqP1g4Dgvx1ExHqCzxvgw9st7CljXDHQ/ZFp6Nw/7TphQtYQU+R9/sSVIS+hdVQUwiytYMwG46agQ83V9x+D95pDgzhpF8nxBeVMQ2kLnQTTOgsT+xIF4xHrN/+xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d+mw2GqBeLQkGFgCt3IRApjVLid8vmyjyTDDAT5VcftX9sSqkcVKBASzKbf42aYKLb8lnyLRDtPXUmL66ZbaLKpT+dbSs0Cw/jAaaFUaRHmZAYX0a6QwWl18CEwsrN8dcluiIkP4OOjTjTCcSG4Eu0RPVHZ9Q6D1h6nk96MWqSFjjuj5JDPd2eYZasaAIaNT65FFUF4negoyfw/k1b4yj0oKuvrxDEOu6PyLntN5ZDbQ6sOXYVG8sQFNLldBY/qiL7gLKsF3jcD4rw9+ZvpvDkknGDtFU3H0udDB1/AQVOf7qURdHx7fecjRtOWs4JThA3oFaiOqw0IkSbhBcwa7ECkqdcFTrySOHgSJxYqXP784kisif2ipkam3TE/3JG+PLxqIVXAygeJscn/wOeFnr0SHHwoi8DKSmEdnlxF9TXS7/7zlnKrS+1vGIsHii/Py
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 10:55:51.0232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4abf724-d6dc-4b09-50ed-08defea99982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
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

From: Yuansheng Mao <yuansmao@amd.com>

A full GPU reset reloads the MES firmware and wipes its queue
table, but KFD keeps the queue objects with is_reset left false.
Pre-reset cleanup cannot fix this: it runs with the reset domain
write lock held, so remove_queue_mes() fails with -EIO and the
cleanup loops bail out early.

When the process later exits, process_termination_cpsch() sends
REMOVE_QUEUE for doorbells MES no longer knows about. MES rejects
them, remove_queue_mes_on_reset_option() mistakes the rejection
for a hung queue and ends up in kfd_hws_hang(), requesting another
GPU reset. On SR-IOV that resets the whole card, so one injected
hang costs two resets and disturbs the other VFs.

Observed on Navi32 SR-IOV with a compute workload running:

  ring sdma1 timeout, signaled seq=239, emitted seq=240
  GPU reset begin!. Source:  1
  Failed to evict queue 2
  GPU reset(1) succeeded!
  [ ~34s later, when the killed process is reaped ]
  failed to remove queue from MES, doorbell=0x1002
  MES might be in unrecoverable state, issue a GPU reset
  GPU reset begin!. Source:  3

remove_queue_mes_on_reset_option() already skips queues with
is_reset set, but only the per-queue reset paths ever set it. Set
it in kgd2kfd_post_reset() as well. Suspend/resume is unaffected:
it goes through kgd2kfd_resume(), where queues are re-added to MES.

Signed-off-by: Yuansheng Mao <yuansmao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 586e640f13dc..d326e41a8656 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1033,6 +1033,27 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
+	/*
+	 * The reset wiped the MES queue table. Mark the queues as reset so
+	 * that teardown does not try to remove them from MES again.
+	 */
+	if (kfd->shared_resources.enable_mes) {
+		for (i = 0; i < kfd->num_nodes; i++) {
+			struct device_queue_manager *dqm = kfd->nodes[i]->dqm;
+			struct device_process_node *cur;
+			struct qcm_process_device *qpd;
+			struct queue *q;
+
+			dqm_lock(dqm);
+			list_for_each_entry(cur, &dqm->queues, list) {
+				qpd = cur->qpd;
+				list_for_each_entry(q, &qpd->queues_list, list)
+					q->properties.is_reset = true;
+			}
+			dqm_unlock(dqm);
+		}
+	}
+
 	for (i = 0; i < kfd->num_nodes; i++) {
 		ret = kfd_resume(kfd->nodes[i]);
 		if (ret)
-- 
2.25.1

