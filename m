Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BEAC52D7D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 23:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6CF10E320;
	Wed, 14 Aug 2024 23:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q7pFI18R";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5256710E31F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 23:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7mOGj6plqo6cEhrRSs6BCLcmtU4bN31JEBfV+lRKdSoEcPl7/UzQnLsDPnwC1V8Aiw1JVRm7xN97ZhK34lxKAzedh3Bjnl4nmXUtS89LdAIEhbPawPYfRRfbOOPOW6V/KQDeJloWE7Fh7L/N3/ltq0U/2Cufuzjdd2DxK4Dh8hF+awOaxjyfhUXAWr1Q0gPCEJ6xhIXqB4qlYTXHq5TmfBESTG2nR/b0ROUny35U12AIB2PCcaL6zfnz7Rr4rfH/9zFedpBwS6FkiayuVY42IWTctOOdTMMkFZrwOtrKYK99cQMW5SeC8MuisfeJFDaLYdG9yEb8U5ofO9RkDrUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs0oZL9seHXmwTk+9AHu8wFksb4BaT6QA92au7HwNrs=;
 b=PSzBdbPDwJOMbrbduVVEcFcmPlSDQLQttEELSy8P95PeV4BmrqlygfIpxGleEyll/KwEBVSiM2J+VwAtFfOX4HCm7h2j33d8dMRlAY/rKpPsMnR5jojGqrDli1Z8VMZnA7bYk3g/1OXo1xZCJLFh7yxrc96XmrfF45iYdxqnTiVowi7qMX+XKuB5E9PWPPSExaXcyp4WhBQBPaSgkyDI2aTPSYMoivK11aIXrsudkH7lbG2W9AD98FlieSzrL7kb/vLrzmMk3V/xHbF+gd+JrKiT0ZOYB/CCkfBC0a5YP5ouPwpxNd0Z6DmzslQliXveYpxhiW17ZF2ib0pc4z+qVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs0oZL9seHXmwTk+9AHu8wFksb4BaT6QA92au7HwNrs=;
 b=Q7pFI18Rcw/HoznK08utACNKLX8dn1dtO/3ALe/9StZ8IzG3C8cJDv9Ow1kHyfZVCK4sReyvIjwt5ZaHSQR3Af3jv73+b8eSnQw1I/iHmYGacsCmz5kQEnYoBYeYACr8CjxeMCLoWO2tt2yqJS1Gvz+/paX594f2yVuFanXe+e4=
Received: from BN9PR03CA0523.namprd03.prod.outlook.com (2603:10b6:408:131::18)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 23:28:52 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::1f) by BN9PR03CA0523.outlook.office365.com
 (2603:10b6:408:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 23:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 14 Aug 2024 23:28:51 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 18:28:50 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>
Subject: [PATCHv2 3/3] drm/amdkfd: Update BadOpcode Interrupt handling with MES
Date: Wed, 14 Aug 2024 19:27:54 -0400
Message-ID: <20240814232754.1119319-3-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240814232754.1119319-1-mukul.joshi@amd.com>
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 61461942-510b-4e1b-7c4a-08dcbcb8db43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wX3b4uglukqVTobUXDs19NyqMPiNlJbFIloy1P8XZMUOxsDDfOCc/cY2WnnL?=
 =?us-ascii?Q?qdoCAs7W70xLuIW1Hk2qpdnY2L4XW3y4baj3W12dt+0F+s0QBxWeShJCL1AZ?=
 =?us-ascii?Q?XDyD2IYXOwDJtYkczWm+yD1+yazI69r67SFysrcO6EXiGQGaAUxqBOEW46jM?=
 =?us-ascii?Q?OrS2uQ9e0/XgRpk/oP4CyrUAntEegonvdM5FhvOnktQ2PAnvHT40Cwggyxba?=
 =?us-ascii?Q?oF9sh5imedj0aStbL2BRgo/MFjDNC0sc/K/xOAJk881lc2Bvzbs5AbVTB2r8?=
 =?us-ascii?Q?UUPWPOeOuY7N9eeiypj/MSDBLRAQVvnSLp80GjS/sp8euG2WtOYfqnSPazoY?=
 =?us-ascii?Q?NMMi8AipxXPH/ah/mmuTyQpY61wzDm5HweF5kuqiIxUHNlMuVZxLwAtfWNC9?=
 =?us-ascii?Q?BDA9UrO0CkBX69GIqr/L//bs/TbakbaUyvve+sly0RmONrUBuhukNZgwdRHs?=
 =?us-ascii?Q?Wy+wI7/rWbhtnoRBLxjWLVWM0/sYXikIXmQMU+LV3gZ+2ZUTdN7fpc7FVZJw?=
 =?us-ascii?Q?CNjJWwt/wSpU11a09ZQS17PNphS10KPaICHpX1Nx94XlXYx0Cms6PQHwF7qG?=
 =?us-ascii?Q?m7JLTgVCk9yGYnDZZgHAD/pl1sc1NYTnVars84y47j2e/gOmcvdx5uhMQMv3?=
 =?us-ascii?Q?4mkdp5kg53raoalPqAORgMBmBsSdfO8HFshN/a4OKw93wy4FLeZYlZFLfNAz?=
 =?us-ascii?Q?tkW7V1TcdyaG6zZVrX+nILKE6SiHajVbK1cDCiOwZByfGxuD4jAi453cLI4T?=
 =?us-ascii?Q?NSMQEai3wVRXr9+hM8+4KML4z/qBJ+clDSs5T13y4O+Gufubtqr6jEFb24Ep?=
 =?us-ascii?Q?I5qWLSBJe/oF3ybW4JuXCwjwXfCD/vhNFaPUO4vdu0MZRDoFBz7nluvrqGra?=
 =?us-ascii?Q?AH4cAPC5vRIZ8I6gEWeipIO6RNcV5FrtnwasFxKqsuXN0eDfRcEY4vma6cqq?=
 =?us-ascii?Q?zq9CCv/HVGZ/2yZEqOMSARhR7yMwySsy2D6ZWTC1tvs8SM32xnCBMYf3MFiE?=
 =?us-ascii?Q?xYHt1hJmgBkHEqLV/PIb+MzQslqgzOhFTiaon57+K9hT+y6/jDqyrLyb7W0Q?=
 =?us-ascii?Q?o7sT3qWDILtM5cPWoSRwnhoTYdbXYxOef4oSwrhzvCNRRLMF3KHJbuDn30wG?=
 =?us-ascii?Q?01KhiCcNCpd+0etELuL5ii5JUszhko/9BXEYH5Et+Kb0CHWccI/r4bNxBnPf?=
 =?us-ascii?Q?DhWG0OUanvFiuo8M6ug39rBav/Pwvk72XnbPSM5ylI6XcSUpcIoaWaw/b6lR?=
 =?us-ascii?Q?SpS1Ju5Syp782Si9SCRKNhRWjpDt++pO8SyoSsSJOWwRsxb1LxXYUhmaOkwq?=
 =?us-ascii?Q?29p7T3UKtBacUo2vNTvRmvT5OMqtNDP/QoLhFks5k7xYWQne36iWcEvN4LJJ?=
 =?us-ascii?Q?EfEf/HfXM1o2vXxEOwzkE5+gLKAxQRlUuBFWlPKU3LclodjentNRcUPWet7a?=
 =?us-ascii?Q?hi7iOKUj3DJnGVBKYjMx6IPAMOMIsfjE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 23:28:51.7780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61461942-510b-4e1b-7c4a-08dcbcb8db43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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
Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
v1->v2:
- No change.

 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 51 +++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  9 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index cb5b866eee3b..67b97d86e65e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2871,6 +2871,57 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
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
 static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
 				   struct qcm_process_device *qpd)
 {
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

