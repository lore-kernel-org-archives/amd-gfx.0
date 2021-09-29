Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208CBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F186147F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7F186147F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032F16EA55;
	Wed, 29 Sep 2021 12:01:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7026EA52
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVD6BUHP5a4Yg5z1ypSObHnGOf/lvgPor2/OcxSrp9BWxuyk1SYHgVUbZZIV93kmZN1GZrA1T8W3edTAwEV90cy55oWTYUNITOxQlrVJ6qMA8jQk2JcvNUXpgtQzfoUVGwoCdU1oma28pJ67TZ5s9IdJtzLgi2ntwlSVndZBIovgBisl/OWjDWEmYjQbuu+xapE5fdFtduEtE+cNPGPzeCU/B7WekbAJCs5JbXfDpvkd16pdDvuNQLBjDkv3cOYGCZsXlryo6CXMNII/Qu6SvAYB73ih8fKAfs94eLq4Wv1QNI502vNXZ9S5Vge3BmS3Yogsh27K9CNJ8HyRj/B48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=iwZj7WpD4hZTITeuUZtOKYCgeuTcgVPTMZcIiAjux/Y=;
 b=D3Vp9erFNPKfiszmBW7AoHhEXRIN0Nr4WX1BfCfBOQjiFKtvkLooW83Tx5aKXnjHH8jZ90/EzfhhxKBS72cD4b6CzCs3OKUQV5QCf3X5fdngz58CoQGqZClXbY4F+9XOuhCExQZn5wml9RmYipODQ4FacE33T+gTDrWBW+l83yAg4x2QdOXV0pIyob7/+AVsdRDw3hwz5bff025tYf3itWjZ8hC/Xr2CY/8aMxBqk55kjwAXuwJEdaRHFYnrN/PaB3GxOvwXrYFmstwvgQkJnxPab92y+7ZshPIPJiltuE3yTQ9M9hzMBAzuJiU2L1svP1ldJeieamX5UbzKrjKskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwZj7WpD4hZTITeuUZtOKYCgeuTcgVPTMZcIiAjux/Y=;
 b=quv6lWMTmi1hmRPQe6apUBaWw9c6Z2SCDduq5vaprW8PlUmA/DBSfDlEZ5zaFz7WcU37nt2WYvf4LfRJ62CIXuXBs4Zpf//c5ULpvDp6DU1jCneEkqYk8mTDDCKq9Uwvln3YNm6KSLyg0sAzkqa96XHkVdH5oRaNghOZLjITB3c=
Received: from CO2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:102:2::31)
 by MN2PR12MB3166.namprd12.prod.outlook.com (2603:10b6:208:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 29 Sep
 2021 12:01:12 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::71) by CO2PR05CA0063.outlook.office365.com
 (2603:10b6:102:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:11 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:05 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <david.yatsin@amd.com>
Subject: [PATCH v3 10/16] drm/amdkfd: CRIU restore sdma id for queues
Date: Wed, 29 Sep 2021 08:00:32 -0400
Message-ID: <20210929120038.6485-11-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929120038.6485-1-david.yatsin@amd.com>
References: <20210929120038.6485-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2fcf60c-2cc3-4155-4a64-08d98340d492
X-MS-TrafficTypeDiagnostic: MN2PR12MB3166:
X-Microsoft-Antispam-PRVS: <MN2PR12MB316678158396799A45C7EF0395A99@MN2PR12MB3166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+9StKIMjhNFBYfESUCdrp6tv/MSKqyO0tJJsw8TBLCvZ7skMaiJVsmSiAzyCAXeWFjb3QD7fQrmrFNPT/8r0tHYXN6mPjEvJybJ5RfZiGK2AEXHo8ZyUqKtKPiFqnskWvesr57o2MeP5OayYJtZB7vEa1MNr3yF3PQyRvFWFFCiur1o6JP58DDBCXh64rpWqNrAm5muuKGsoM4Q/xefLdTKsbzsGPOEuQvtUX88N8sxB+DkpjgMPPlZPWxrn+ROV6bTc0OLQWQx8Aify26GTG9+kHL+684X2xezoUTujrlRmnAe84jtcju8BYVcB1UZUwlF3p88Vtma19qrobaiVyHxgRIeKHsidXfoOCq04gEfTzbPH2WHgojwUVRZWtbt45uNx6Fez2T6IbSZxSoVh2+eXQNQ1yXSjVZQbKWurCZ2UvJkaAyBIcrUHNSDWP4gp9/d8yJD61UBJlPnSOJ/bzt9fEX+/q6HZ+U/kU/qJZKYTKsLwu1BR6sOiw5kO+3nL50/m1YDtIhIBxX1llJo1jW0zBOE+gPIj4xY7e5e1nFIcp8DhgfupnZ1dt3v8EQdaLp6o9AVfchw9Lk9O4QDs/6Lk82cSHRTyE2S1JSBPe33ciEV2csw0y6cXvr5+ghEzcJMgpzaKKxj13sNN2JFEWCfM/02iVZwiHnChvIZTLUoG4F2J5XO+ACVeGJcvk3LX789+mS8vvxmXts72NR89YNcwxwoyHlHGynYy8HQcqk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(4326008)(5660300002)(36860700001)(336012)(2906002)(83380400001)(26005)(7696005)(316002)(1076003)(356005)(47076005)(16526019)(82310400003)(508600001)(186003)(8676002)(81166007)(70206006)(86362001)(8936002)(2616005)(6666004)(70586007)(6916009)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:11.5599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fcf60c-2cc3-4155-4a64-08d98340d492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3166
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

When re-creating queues during CRIU restore, restore the queue with the
same sdma id value used during CRIU dump.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 48 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  4 +-
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f8fce9d05f50..c29dbc529548 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -58,7 +58,7 @@ static inline void deallocate_hqd(struct device_queue_manager *dqm,
 				struct queue *q);
 static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
-				struct queue *q);
+				struct queue *q, const uint32_t *restore_sdma_id);
 static void kfd_process_hw_exception(struct work_struct *work);
 
 static inline
@@ -309,7 +309,8 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 
 static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				struct queue *q,
-				struct qcm_process_device *qpd)
+				struct qcm_process_device *qpd,
+				const struct kfd_criu_queue_priv_data *qd)
 {
 	struct mqd_manager *mqd_mgr;
 	int retval;
@@ -349,7 +350,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 			q->pipe, q->queue);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		retval = allocate_sdma_queue(dqm, q);
+		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
 		if (retval)
 			goto deallocate_vmid;
 		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
@@ -1040,7 +1041,7 @@ static void pre_reset(struct device_queue_manager *dqm)
 }
 
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
-				struct queue *q)
+				struct queue *q, const uint32_t *restore_sdma_id)
 {
 	int bit;
 
@@ -1050,9 +1051,21 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			return -ENOMEM;
 		}
 
-		bit = __ffs64(dqm->sdma_bitmap);
-		dqm->sdma_bitmap &= ~(1ULL << bit);
-		q->sdma_id = bit;
+		if (restore_sdma_id) {
+			/* Re-use existing sdma_id */
+			if (!(dqm->sdma_bitmap & (1ULL << *restore_sdma_id))) {
+				pr_err("SDMA queue already in use\n");
+				return -EBUSY;
+			}
+			dqm->sdma_bitmap &= ~(1ULL << *restore_sdma_id);
+			q->sdma_id = *restore_sdma_id;
+		} else {
+			/* Find first available sdma_id */
+			bit = __ffs64(dqm->sdma_bitmap);
+			dqm->sdma_bitmap &= ~(1ULL << bit);
+			q->sdma_id = bit;
+		}
+
 		q->properties.sdma_engine_id = q->sdma_id %
 				get_num_sdma_engines(dqm);
 		q->properties.sdma_queue_id = q->sdma_id /
@@ -1062,9 +1075,19 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			pr_err("No more XGMI SDMA queue to allocate\n");
 			return -ENOMEM;
 		}
-		bit = __ffs64(dqm->xgmi_sdma_bitmap);
-		dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
-		q->sdma_id = bit;
+		if (restore_sdma_id) {
+			/* Re-use existing sdma_id */
+			if (!(dqm->xgmi_sdma_bitmap & (1ULL << *restore_sdma_id))) {
+				pr_err("SDMA queue already in use\n");
+				return -EBUSY;
+			}
+			dqm->xgmi_sdma_bitmap &= ~(1ULL << *restore_sdma_id);
+			q->sdma_id = *restore_sdma_id;
+		} else {
+			bit = __ffs64(dqm->xgmi_sdma_bitmap);
+			dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
+			q->sdma_id = bit;
+		}
 		/* sdma_engine_id is sdma id including
 		 * both PCIe-optimized SDMAs and XGMI-
 		 * optimized SDMAs. The calculation below
@@ -1288,7 +1311,8 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 }
 
 static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
-			struct qcm_process_device *qpd)
+			struct qcm_process_device *qpd,
+			const struct kfd_criu_queue_priv_data *qd)
 {
 	int retval;
 	struct mqd_manager *mqd_mgr;
@@ -1303,7 +1327,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		dqm_lock(dqm);
-		retval = allocate_sdma_queue(dqm, q);
+		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
 		dqm_unlock(dqm);
 		if (retval)
 			goto out;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c8719682c4da..f9adce73ad94 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -86,7 +86,8 @@ struct device_process_node {
 struct device_queue_manager_ops {
 	int	(*create_queue)(struct device_queue_manager *dqm,
 				struct queue *q,
-				struct qcm_process_device *qpd);
+				struct qcm_process_device *qpd,
+				const struct kfd_criu_queue_priv_data *qd);
 
 	int	(*destroy_queue)(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index e3cf99dfe352..f0e421a121df 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -273,7 +273,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data);
 		print_queue(q);
 		break;
 
@@ -293,7 +293,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
-- 
2.17.1

