Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE278C197A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 07:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D79110E125;
	Mon, 20 Nov 2023 07:17:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D77610E125
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 07:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkpdF4r59fgd973meM7j9o6tqDhp4N/YpJjRUQ+mpXIEw84lcan6ouejGFDWsRAkWu8QYobdE2ptSnIvOcIQsjogyr24G4y5rtVd6ysu1UZ3s/dhWccBUZH6DD1TimBLdZMXO7sCgzVNbXMjgvrHdWYkxmzttPPZzk8DTxKv40egwqaDvoN3GMpsgt+PIqJzf1s0VrB0Z9T5TGNDgC/k/BeLeteA/14TmVnVUheJ4kgOMO59INxc6ELUDUtR8Jvo5dKbWsB42qnESw/Tvhqz/AqV1Ml9lwcnYM0c7f9f0sb4IZz/p3Kq8bOw9LUwhx2QMUx9qSXRBJMqhY+XsijAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+bvQU5idXy3Uq4EquZ3o0DxrYKZ6LaC4xN8MgyJ0Cw=;
 b=n3qQGtEXJLtwOXnnDSXC6yHk2vuv5Fh4ZAv8vaPvlBWSUgspWw1lgQ08xFUUnGZzczaQnMCtHmrhl/waz7N/l4sr7ddxP4W2NaZiLIXIWQ9Ub5lhdBrnDEpUscbPbn6AdMpLv42dCdYuJhTxOJ4nzz96IBgtD2FKx7oK4AAwfLF9Rk1KCOXYkpgW0J9AxnVRe2ns2rj27xnpCkQ8rp9gacPn8vnDzyn55QGnCBoOxYEr9lCjnecVJe95elRBpqOsSNjFC/3+dvW7EgM6Z3lmK63/kn87g4jm5tTJZBjgw9a3soJOhLSuhcYuU3OVF6AUBOVs+rvXDJYXWBBqHk/Z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+bvQU5idXy3Uq4EquZ3o0DxrYKZ6LaC4xN8MgyJ0Cw=;
 b=S4Jw+GRjkk+CbeV+iZNsZWWj4LkscdSUAuyX9Nx4B3cDi4fUiOEqaEzVRxRVRDKhUxU6f/wxcH66RuV5PEMSV3DBmoWYk1GdZRhkKIXCGMuegqn5wlcWf95P23dINIJcyxIxp6FmNr38xi2OkhpeC4vyzMq8MtnMvTerBo+vsgU=
Received: from DS7PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:3b7::14)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 07:17:43 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::ef) by DS7PR03CA0099.outlook.office365.com
 (2603:10b6:5:3b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 07:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 07:17:43 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 01:17:41 -0600
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit
Date: Mon, 20 Nov 2023 15:17:31 +0800
Message-ID: <20231120071731.4128025-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 11af2430-ec93-4c51-0732-08dbe998c9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brsROXJC73ulx7x89hJA+tv/J1xEcWJ84vU3160ak5CFsZil6J8ZadLOckKqWwfOFVbAKeQcwY6tLe2U9jLnraan58CilW3T2Ox/x4i0rd6SV2kQ4DZgxpq+ACEUlyBmNKgo4bhUGf7MS4GWHXt74wNPYvPLAjSCxe33TPJN2nxeK5Ua50WvFQ3KgY3CZDwDDRzOMA2stG40xl96EztoHfvPnV8sELBgvC0LFOVkSxb7OvuOkWRx0+QtsxbTmFOa9bAd4aCbLtVyXE5eVUE6Wq4g4/RaDG1pq81NxvzkDr6LrQllx9gIyGMjAOONk9elplGr1sAxAwX67DZXMv1yPGo1z/CC7Pnt+YU8wuYuZ5EB4uIiZHmVeTtCr4V+PnY+desXmJP50h0untvsuosZM/1VZin6Ef55iE1xY3ozCfYOmge2yaJF+GMNUwAMaP0L1nF6nBDd6cFYuVjmhVHYihK+QaQ27R/BP/jpU8XHct7IEMY5IMPT+lFgLVpV/wfHIBTzFE+p6P3wWlp09yWY2l9g4Xy5zo4L9DZ7/GCOgMN4ujtXENSnjqW6I1hmOg407rk1vLHW+kxou+yJobzrwbpov9pekPZlp/GKlfTZ5GfByU8jzBx22dCHJAGTw1aRFaRaoTEYXK6cAPZIEqsKMtQo7WFCSfDEEfM4EsKAXoetf6YDSAjUy5diR0q+bB+n1McsBLxVEqbfVHtIhgpLdDaNSt8nCCadUlInFV2oub5fnRbVt97f6TkX+ianijyo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(5660300002)(2906002)(70206006)(81166007)(82740400003)(356005)(86362001)(36756003)(426003)(83380400001)(7696005)(1076003)(336012)(26005)(16526019)(2616005)(36860700001)(478600001)(6666004)(47076005)(41300700001)(8676002)(8936002)(4326008)(70586007)(316002)(6916009)(54906003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 07:17:43.0726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11af2430-ec93-4c51-0732-08dbe998c9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
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
Cc: ZhenGuo Yin <zhenguo.yin@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Memory leaks of gang_ctx_bo and wptr_bo.

[How]
Free gang_ctx_bo and wptr_bo in pqm_uninit.

v2: add a common function pqm_clean_queue_resource to
free queue's resources.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 46 ++++++++++---------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 77649392e233..b027485fbe66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -169,16 +169,34 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
 	return 0;
 }
 
+static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
+				     struct process_queue_node *pqn)
+{
+	struct kfd_node *dev;
+
+	dev = pqn->q->device;
+	if (pqn->q->gws) {
+		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+		    !dev->kfd->shared_resources.enable_mes)
+			amdgpu_amdkfd_remove_gws_from_process(
+				pqm->process->kgd_process_info, pqn->q->gws);
+	}
+
+	if (dev->kfd->shared_resources.enable_mes) {
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
+		if (pqn->q->wptr_bo)
+			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+	}
+}
+
 void pqm_uninit(struct process_queue_manager *pqm)
 {
 	struct process_queue_node *pqn, *next;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
-		if (pqn->q && pqn->q->gws &&
-		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-		    !pqn->q->device->kfd->shared_resources.enable_mes)
-			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
-				pqn->q->gws);
+		if (pqn->q)
+			pqm_clean_queue_resource(pqm, pqn);
+
 		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 		list_del(&pqn->process_queue_list);
@@ -461,22 +479,8 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 				goto err_destroy_queue;
 		}
 
-		if (pqn->q->gws) {
-			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-			    !dev->kfd->shared_resources.enable_mes)
-				amdgpu_amdkfd_remove_gws_from_process(
-						pqm->process->kgd_process_info,
-						pqn->q->gws);
-			pdd->qpd.num_gws = 0;
-		}
-
-		if (dev->kfd->shared_resources.enable_mes) {
-			amdgpu_amdkfd_free_gtt_mem(dev->adev,
-						   pqn->q->gang_ctx_bo);
-			if (pqn->q->wptr_bo)
-				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
-
-		}
+		pqm_clean_queue_resource(pqm, pqn);
+		pdd->qpd.num_gws = 0;
 		uninit_queue(pqn->q);
 	}
 
-- 
2.35.1

