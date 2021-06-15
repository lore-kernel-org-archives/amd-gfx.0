Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449A0C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 17:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B8D61009
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 17:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B8D61009
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752D56E167;
	Tue, 15 Jun 2021 17:51:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F616E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 17:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERn8Mbh4JsQQ44+OKwIebBvtNvqPYzm3uXF6eohAE8ubA1s87DFMzXmk6GMm3Sihg28vy8TcQK0WUMliSJG9nI2/fB/GNgUsfAHiBQZSdQ9sGRZaA2Ra7Z2HC1SR/LeDLTKNNfoGh8hvUrL9Ch3eR/GWQHQ23qLgaSGOCh4yps7gs1MtsZagQJx8L+E8iPPQySgsgH0Ob4S5JtdUrRTjI/XUpy7tmvlUQP5oXrCw2/jGRq1kf9raPTQgxcQzL0q4TvpvD6Azs30vQfmCyudAlPnL0XhW/sgR1IHcU5rhXtQ/Jz+TBiqUtHnPcTSgA3lBMCi15Srp0yO5Z7ZcZQeS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=529p97/3W8V02U2N7AqYWpCfR8mf0rqrz/lHdXu6d+0=;
 b=Vo2ILa2OlOp2Y9HAK8/yM4frui0Ef0yDeuP8y8c7rQjkQygA7L6OPK9/lcHnMDrfY25cXwwyI++aW32o+dAwZn1SkDKnAY0BI7YFWnoGiR1rT89ZQPCh26RodXH6qdF4CbXQIGoR1nba/VnwO75B9yBemARuwOi7N2ZK0UbfVyP2mAS4oSMOHN4m3EyzCMNHXqRojPyVGsawwJML0JXBb/7CMUJy0qhb43ozma3R4HEGCLUSBFxtax07gAT67WaWP787hE1Kqn2LlVG0HL4BTe0zv0RhTDsWJBOhYrNEL4tsExlAmim1vqxowb5BZSdy1QblPYJ2WaCeaA4zNximfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=529p97/3W8V02U2N7AqYWpCfR8mf0rqrz/lHdXu6d+0=;
 b=1MN9DYAck3D1AqHkN2UJ4xOGIHGjOzU9Zfe+VpTM8XGyrHscfXnXXrWFxh8dB2FT8O/BPmndV6kXU9tr+3cSAUKJSyMaVTxidDDbN+09L8mzBOpiPZg9xJNp4Iw3icjpdXg5dy2b8yA+7VYTaG3VumHCromHWzfxbl/o3QrEckw=
Received: from MWHPR2001CA0019.namprd20.prod.outlook.com
 (2603:10b6:301:15::29) by CY4PR12MB1797.namprd12.prod.outlook.com
 (2603:10b6:903:124::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 17:51:16 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::1a) by MWHPR2001CA0019.outlook.office365.com
 (2603:10b6:301:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 15 Jun 2021 17:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 17:51:15 +0000
Received: from alin.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 15 Jun
 2021 12:51:14 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix circular lock in nocpsch path
Date: Tue, 15 Jun 2021 13:50:49 -0400
Message-ID: <20210615175049.18382-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e65980c7-f277-47b0-8ac1-08d930262c55
X-MS-TrafficTypeDiagnostic: CY4PR12MB1797:
X-Microsoft-Antispam-PRVS: <CY4PR12MB179771FB4B3AEAEA91DA29F6E1309@CY4PR12MB1797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHjaD6XF1ArYZnfgEh0HCr3042RmZpdlv3et02a4nnkFnTqvFYlcYU+ByZ6bx5S6rP07/KnGsFfegx/k1ucsjPTO7ERZwPaaeChLOEWgAW2daxBgV9fIn1TZ7GxC4yN0AUiG2gQnP/it6S4zmP20ayNB104stx7quxdF+bXhlsA7okxm1nqhw8yFt6B6SFWn4A5Gn6XurNAEZNx3lT5w6fRYdIP09cnoWEDK/Dch7V9le3Rzhass1BxFWEeZCjRih7EMyWIJmhYjtg4coaCQsoLfkkL+EmhiVw4KfWbqLpxGCTCoduMyDiIrOH8FLkW96WFN+kcfrp5u0ZlU+kI34YJ7Et8MOBhc0Tf/lo965KurqBLgBPklBSBIC8Fxdi6IHMxIU/zmkL7dJo2kMIczqDXa95vDwVjqYUODk8Bd0snUympG5TOPas9/29bFjAhAJHQthBTqIZylNcsRpec13A3fmAtz/5Vz2r7S8fq4Uj6oxfmIkK8ep4/G2GyDMAFfi9SNuw4ME99/Qp7b0/cCxNoGB9Vm9+fAO3VXUDwMAiOCX2L1N+Ho13X5CGCN9KNrxyVT3OptPAe609Jzbfd67LFaDTCt2yU4AJSEitK12/eK4CQRLF8QYs9ptqolGd4/s5IScStmCFSvxL+QXsUTr2IEznKIKvBdVgR96AnF8uTUPC2upluWGXNAwBKXR+YS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(26005)(86362001)(2616005)(6666004)(16526019)(83380400001)(47076005)(426003)(5660300002)(8676002)(356005)(8936002)(82740400003)(70206006)(81166007)(36756003)(6916009)(186003)(1076003)(478600001)(2906002)(36860700001)(7696005)(4326008)(316002)(70586007)(82310400003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 17:51:15.8770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65980c7-f277-47b0-8ac1-08d930262c55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1797
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
Cc: Amber Lin <Amber.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Calling free_mqd inside of destroy_queue_nocpsch_locked can cause a
circular lock. destroy_queue_nocpsch_locked is called under a DQM lock,
which is taken in MMU notifiers, potentially in FS reclaim context.
Taking another lock, which is BO reservation lock from free_mqd, while
causing an FS reclaim inside the DQM lock creates a problematic circular
lock dependency. Therefore move free_mqd out of
destroy_queue_nocpsch_locked and call it after unlocking DQM.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 72bea5278add..c069fa259b30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -486,9 +486,6 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	if (retval == -ETIME)
 		qpd->reset_wavefronts = true;
 
-
-	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
-
 	list_del(&q->list);
 	if (list_empty(&qpd->queues_list)) {
 		if (qpd->reset_wavefronts) {
@@ -523,6 +520,8 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	int retval;
 	uint64_t sdma_val = 0;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
+	struct mqd_manager *mqd_mgr =
+		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
 
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
@@ -540,6 +539,8 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 		pdd->sdma_past_activity_counter += sdma_val;
 	dqm_unlock(dqm);
 
+	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+
 	return retval;
 }
 
@@ -1629,7 +1630,7 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
 static int process_termination_nocpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
-	struct queue *q, *next;
+	struct queue *q;
 	struct device_process_node *cur, *next_dpn;
 	int retval = 0;
 	bool found = false;
@@ -1637,12 +1638,19 @@ static int process_termination_nocpsch(struct device_queue_manager *dqm,
 	dqm_lock(dqm);
 
 	/* Clear all user mode queues */
-	list_for_each_entry_safe(q, next, &qpd->queues_list, list) {
+	while (!list_empty(&qpd->queues_list)) {
+		struct mqd_manager *mqd_mgr;
 		int ret;
 
+		q = list_first_entry(&qpd->queues_list, struct queue, list);
+		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
+				q->properties.type)];
 		ret = destroy_queue_nocpsch_locked(dqm, qpd, q);
 		if (ret)
 			retval = ret;
+		dqm_unlock(dqm);
+		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+		dqm_lock(dqm);
 	}
 
 	/* Unregister process */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
