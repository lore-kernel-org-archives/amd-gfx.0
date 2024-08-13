Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0C5C52D7B
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 18:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B13110E3DB;
	Tue, 13 Aug 2024 18:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pQsKvg0a";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9829510E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 18:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFBZwA5JB2l1lltpgzzkz5I2CO1HmXdl3GAYozxAnRN8Lvk5QYChB56t9D8ejCBxW/6KDLTya8GloqHNd0Fop7yMsYfg4b56uoQnYoqwBu+AYpdoCYnWj2x4TcTD+auA2HwzU0eJCq8fXawhfO/w2xKy5mEKTucHdLZ+Es6nGLIX1rW78EGc4r26gXxYjwwZ8WbfSrK8izUxdSQ0xBMed63vdoWSsGyWyG3Bj9yxc1iWjPerHCE2s8a6I5M3YgOu40Dw+yy+F0UuN7TJL04Wfw6h3PdHeg3FVSXkITtYf0A9FViezJR9KoVxER+APt+4+OVwb60xMt3mW9W9I1ofPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/U0eoSi3d+pY0TMf1Jf8eDeUAoyRZEBNgbb3k6gkTc=;
 b=lSZEjKemFUtztHPATAH/+Tn5H+Fb6Ei0d63mhdfvXD9zbdWqcTHTftGrePq+FREFWoyQjCX8FKLfMHgiaVQNzYWBgJqrpUbyI0yZ+GnXSOufHDvXIKK2f9KN56wbWxG3YMEHYsQ+DmufmJ+BfffExfvvbfgQj51E0H3+Aut+mYngilVDDo8lmvPGoqZoTxNm2Zj08UyaKCKli8Jq9G1MufnKKniuTJlheeiZ1PTawExY3bFIFDlVDuoZpkrXXDIWopIAbjcHpbCIkiWonHVBcSDUeppGVZUX5kJUEOpVEWSNf+XmtWMhN7n351nmriws0iim6gn9h0NT17LmjO8pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/U0eoSi3d+pY0TMf1Jf8eDeUAoyRZEBNgbb3k6gkTc=;
 b=pQsKvg0aukHZeUy5jKPwRD/ivvDPeoKe1rijWIUW+FL/4Ii7p8ER4KsC7q0pyy01I2XXCJvWEKBigUxCj1OI9p4VL8BZ3NfNJvCB2M9bieAiqeeDxh3VwbDC59XdrJU1IOAF3N65+yCqp9Fze0hvxzTVeChX12Wk1w5r6Oiym84=
Received: from CY8PR11CA0017.namprd11.prod.outlook.com (2603:10b6:930:48::26)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 18:57:26 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::b3) by CY8PR11CA0017.outlook.office365.com
 (2603:10b6:930:48::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Tue, 13 Aug 2024 18:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 13 Aug 2024 18:57:25 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 13:57:24 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Update BadOpcode Interrupt handling with MES
Date: Tue, 13 Aug 2024 14:57:13 -0400
Message-ID: <20240813185713.942012-3-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240813185713.942012-1-mukul.joshi@amd.com>
References: <20240813185713.942012-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c88115-2625-4fb0-3621-08dcbbc9c5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7cPn5m4rGFI6NbHjy+bOUINmAtTHC85AeHFcrD/WeP9ongQD1dSr98YQaLgT?=
 =?us-ascii?Q?e0V8F00WdhDgnvTpLvBndaNlZQH6ar3B2mBWbKsf0c30PnrUSgo1f+kFcqXH?=
 =?us-ascii?Q?s+3I5flm7rXxQRG815RXU5BDcO/y8qLRjmqGa8G06di6dyhaJCPwVAfNlvDj?=
 =?us-ascii?Q?GjvwX5p3QWh82N7TfxAygYqwBJAt7uiFG/sIhSsz60VSqcTWtlWxnev0qBTS?=
 =?us-ascii?Q?5dkdgVHA7KdIcEVc0mEJtYDJLIrsezPX/PeHADg+/SuO25OiRnsO7Ej2qAfa?=
 =?us-ascii?Q?b2gdcizDh5A9xZK5vsDR5iQZs+BP3aaCeiZdfv1fRiYqAa0SR9HvJj0bNRpU?=
 =?us-ascii?Q?N9f6esOZB7GyUBs5k7CWIVeNPitfeBNP+Ykx/4FFwiGzbLoz+MQtEvUd7g4J?=
 =?us-ascii?Q?wKtyhPfWzv9hdttcbqNcg5hzFo6We1MNPxgj/+RmbRNcPaKRtY97YhG2+E0q?=
 =?us-ascii?Q?tCWoZQ8YqZWJWpq9uU7Eexgz/fZxSD9+D2yjGOfsu9qUAZwFJSwj8bnNt48E?=
 =?us-ascii?Q?rqMV1zJKACNCCs5OffUm2R80BGuKRhnH0FA+1LgW2AS4/z/VmvSFPKFlx/jy?=
 =?us-ascii?Q?ETMjs+SnxhqLGZClf9AVpqbR8BvteLZovd0o8KHVgVz2JPRrAXrgCQINw5OE?=
 =?us-ascii?Q?ds0J3Zju+dm1PopxS0nuc5K5FKJyJmQAAGch3xrcIMJcVa8MAa9/6ZHsjXqF?=
 =?us-ascii?Q?HBdY/ZeGHmTVFSPfIXgHdkoDCtIXx/7iGUEU9WCwsArDOulcxTFNndu6tRgI?=
 =?us-ascii?Q?lAfSFll92U/fwb3m1PGeYPCFw3PS6ngH6/zUVny5euMwbWDsVxXPA+Dse/60?=
 =?us-ascii?Q?KkwUx2rubxwl4QauXiWjpzWr5utJJ1lhNk5vNjMG22GigmF5gmxkP18CEaDe?=
 =?us-ascii?Q?tD19OuOWK1D9vzB6MQEyD8sNICc8dPvcWHfrVThP14T0fUcBHElYSlIXzmr2?=
 =?us-ascii?Q?uj3SKjLnEMdQv+irzaUuoEjBzBJQtH7jI99yMdm7qm8Z+F/T2OSthmTrwnn0?=
 =?us-ascii?Q?wZMqZhZBWN0mhTPG/smCdFA4Pk6a3yrwYasK9ikOD3qDWGKdbUBp42eEjq1s?=
 =?us-ascii?Q?BQBDizwX2LVzUFNFpWrrxpaDbelSgjjH7VUkWtrU3kBB0v2EH+pbU9gAqiPc?=
 =?us-ascii?Q?OapFcECNaX2wMD1RQYrOWv8dQQE6oTBK+CLXaCVWqcHW3kP6TMH4bFYxCGjF?=
 =?us-ascii?Q?UAwcY5djhF8TuaU1aFapYlTcvUQwifENCNwlott5rT3B577ud2FuxtBjZ38p?=
 =?us-ascii?Q?4arHK3PLFIH9vGXoJT6HxefGYfzSNB8Z5IaheuktzSqeJmtlVgOGCV6p+zKD?=
 =?us-ascii?Q?XKCbRMhp0NJF689boTazyeARWaTbPr6Scrw7m3vgk40S3xN0C+T5ScBfq7bQ?=
 =?us-ascii?Q?aSI67wwG8oJiei+2Bay0hvBgGDBOJErFQjTOd54jCzCW9KJRDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 18:57:25.9389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c88115-2625-4fb0-3621-08dcbbc9c5ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

Based on the recommendation of MEC FW, update BadOpcode interrupt
handling by unmapping all queues, removing the queue that got the
interrupt from scheduling and remapping rest of the queues back when
using MES scheduler. This is done to prevent the case where unmapping
of the bad queue can fail thereby causing a GPU reset.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 51 +++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  9 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e16b17e301d9..dbbd836d0b9d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2885,6 +2885,57 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
 	kfree(dqm);
 }
 
+int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct device_queue_manager *dqm = knode->dqm;
+	struct device *dev = dqm->dev->adev->dev;
+	struct qcm_process_device *qpd;
+	struct queue *q = NULL;
+	int ret = 0;
+
+	if (!p)
+		return -EINVAL;
+
+	dqm_lock(dqm);
+
+	pdd = kfd_get_process_device_data(dqm->dev, p);
+	if (pdd) {
+		qpd = &pdd->qpd;
+
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
+				ret = suspend_all_queues_mes(dqm);
+				if (ret) {
+					dev_err(dev, "Suspending all queues failed");
+					goto out;
+				}
+
+				q->properties.is_evicted = true;
+				q->properties.is_active = false;
+				decrement_queue_count(dqm, qpd, q);
+
+				ret = remove_queue_mes(dqm, q, qpd);
+				if (ret) {
+					dev_err(dev, "Removing bad queue failed");
+					goto out;
+				}
+
+				ret = resume_all_queues_mes(dqm);
+				if (ret)
+					dev_err(dev, "Resuming all queues failed");
+
+				break;
+			}
+		}
+	}
+
+out:
+	dqm_unlock(dqm);
+	return ret;
+}
+
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 {
 	struct kfd_process_device *pdd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index f524a55eee11..b3f988b275a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -330,11 +330,14 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
 			kfd_signal_event_interrupt(pasid, context_id0, 32);
 		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
-			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)))
-			kfd_set_dbg_ev_from_interrupt(dev, pasid,
-				KFD_CTXID0_DOORBELL_ID(context_id0),
+			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0))) {
+			u32 doorbell_id = KFD_CTXID0_DOORBELL_ID(context_id0);
+
+			kfd_set_dbg_ev_from_interrupt(dev, pasid, doorbell_id,
 				KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
 				NULL, 0);
+			kfd_dqm_suspend_bad_queue_mes(dev, pasid, doorbell_id);
+		}
 
 		/* SDMA */
 		else if (source_id == SOC21_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f7c12d4f0abb..7bba6bed2f48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1324,6 +1324,7 @@ struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
 					enum kfd_queue_type type);
 void kernel_queue_uninit(struct kernel_queue *kq);
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
+int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id);
 
 /* Process Queue Manager */
 struct process_queue_node {
-- 
2.35.1

