Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B0C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FB361452
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79FB361452
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E914B6EA53;
	Wed, 29 Sep 2021 12:01:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FDB6EA50
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmP42lwRnTB9beBBB8YAFFZAE9N+uRG0WwqBRJDblrck6PoPRjl8XZhle4ekBs9ObcH6ojWNM34cu0X8V4PkwY0nlJhxDatp4gIOzIp/di2YrX2oQHx0QFeQ7DmWddhd6R6ZHOsmoXsRCklMIta9OHx68rUVghIe9aRGfRGvizpv1blG7+qQnBqSHGm+Q8tBxRXZIpNsrmfS6pUvK22J9RwBKRXAgpWiZl+chPQwRjs6uL8XarL/vPUH7DJa1r6SzdkEkXwwrlrpJHXIBX1VbSNJlLLinqSkIqkcmkw8nr+umWwhpsK9XXFo5Emwaq4DvUSiUp9hwQPOI+tj9DzTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0Eh6lBcG8VvapFoARGbHJjk9+U9v0DosdviXKremhhc=;
 b=ne3J1DgAM/7G9rREMtXqCseFZJQRj5V65KQuI9gCrI6fw4uZFOJnKK1BSFt5MMXAzRcJ6R1iTWxzqJU2cbXOg8UnwPChy18gkQoSELYLZS5EuMGm95mukTQ8yp+/9iIhU2rj5Dh15tVs0PrdUcMIyvDz6L5ZUGHNefrZgNr9Rvl1eHi6ND+dQrzXSKGGTvudnWPkBNt6edRGQZ30Ge5GdM7C0+TpPN7u3vx0NN3OA1/SoCRh38/t2nKJR/6aU7ImK5GfdoQMygwzAspNPIOegdNC6/azE6cz69SBtsrkmbd7ZH7V2ZgFVRk6xZqwJOtbX9Du1iAsMnjcty3JnN4/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Eh6lBcG8VvapFoARGbHJjk9+U9v0DosdviXKremhhc=;
 b=tox91d/A67rJTAM25HIr+ffKqP3ddPLTynMWEiJYtYYUJS/5h2aIjMYWq5LPPuCVGBvMEGcfmX+PZ3UoUJ+utsgnPMI2z1fddxX/+U6l8T3+4CS/xOtA++NL9n6otHo+rWMPKAZPcwvDg2Gol5OXmiNSPvtaU7HF7WjIcIE8C54=
Received: from MWHPR12CA0059.namprd12.prod.outlook.com (2603:10b6:300:103::21)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 29 Sep
 2021 12:01:14 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::2c) by MWHPR12CA0059.outlook.office365.com
 (2603:10b6:300:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:13 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:06 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <david.yatsin@amd.com>
Subject: [PATCH v3 12/16] drm/amdkfd: CRIU dump and restore queue mqds
Date: Wed, 29 Sep 2021 08:00:34 -0400
Message-ID: <20210929120038.6485-13-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b4979bb9-0fc6-4a4b-3b3f-08d98340d5c4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:
X-Microsoft-Antispam-PRVS: <MW2PR12MB257287B9BA4F4021D11CD37195A99@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cl76V0hX1tUqK8UbqvmQ3aMKwqPsEfODW75azLJ8JJSU13Z/Rd2BwFJZLkLGKqVbp7h1OZeg9uy8f9ixIcLdZ0xXmtziltzCcEe2fi8zf8yrMJQd3M+15SM0/rmcBWWrOqp3A2uLrwlF+IungYFTHksh9WmQ8j8pENbVbsGAjaPw7DS2ksTR6Hn2kV028ZIaSBAxeKIIbw9NmjawKmYHV44HE0ztM60B8LzEjoUniHyQVka874vTP4ZrdrxXrWSc9UKc/Kzz4fdZ8NMJZ6KguWH2UP0mVAoYelP0Gc3KLNINo5jz3ORUC92sKCdqbT/YxK4HW/gIzO2dAEcNToGN3ESm/FFagJIUgPYAnCVvEiff32ziL6bxQviACSIoUPYu24P3iK4NCzna1U6n6pneDzrN/z1Tmp/9VFZUqhg92OjSCnafkWEO+Q3bskZPeSwaT0puMPZT0LDUQVGC7rlrZh602WlydJ12mxy8vxyhm7auzdsqSBL0c+Xq5B7hY+Rsxucun6W6vdAbDRCW7Bec7ErRzD/meKZpcEMxN6jrzn7zjs4Q2vnEnmvkq/h/EzeEVNBZukr0iXoMQI6A9YvliMFNUnfdAGPc917/R8zr8lFl9Ar//3MDiuSIEQptsoDtXX8sgI2G5QlRPDqCyTI/pXcyiBxVkGl8u6/uvCb8Y/n2Bs132epfnHPn69oOjqHQMn/LkSW5e9Y4UgKjWrVYWapqpM6MBsGlmPXc+XF62jYrTSbZHXZZ52wuoogo9JOUHg5a6pPiuc5+/B6zMgLaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(508600001)(7696005)(82310400003)(5660300002)(6666004)(426003)(81166007)(16526019)(47076005)(316002)(36860700001)(1076003)(70586007)(336012)(2616005)(356005)(186003)(8676002)(2906002)(30864003)(86362001)(4326008)(70206006)(8936002)(6916009)(26005)(83380400001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:13.5566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4979bb9-0fc6-4a4b-3b3f-08d98340d5c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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

Dump contents of queue MQD's on CRIU dump and restore them during CRIU
restore.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 72 ++++++++++++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.h | 12 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  7 ++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 67 +++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 68 +++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 68 +++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 69 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 +
 .../amd/amdkfd/kfd_process_queue_manager.c    | 97 ++++++++++++++++---
 11 files changed, 444 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 8bb470b1ee93..d2130c5a947e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -312,7 +312,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			p->pasid,
 			dev->id);
 
-	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL,
+	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, NULL, NULL,
 			&doorbell_offset_in_process);
 	if (err != 0)
 		goto err_create_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index 749a7a3bf191..c6c0cd47e7f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -185,7 +185,7 @@ static int dbgdev_register_diq(struct kfd_dbgdev *dbgdev)
 	properties.type = KFD_QUEUE_TYPE_DIQ;
 
 	status = pqm_create_queue(dbgdev->pqm, dbgdev->dev, NULL,
-				&properties, &qid, NULL, NULL);
+				&properties, &qid, NULL, NULL, NULL);
 
 	if (status) {
 		pr_err("Failed to create DIQ\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 30ee22562329..3e11111a6a9b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -332,7 +332,8 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				struct queue *q,
 				struct qcm_process_device *qpd,
-				const struct kfd_criu_queue_priv_data *qd)
+				const struct kfd_criu_queue_priv_data *qd,
+				const void *restore_mqd)
 {
 	struct mqd_manager *mqd_mgr;
 	int retval;
@@ -391,8 +392,14 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 		retval = -ENOMEM;
 		goto out_deallocate_doorbell;
 	}
-	mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
-				&q->gart_mqd_addr, &q->properties);
+
+	if (qd)
+		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
+				     &q->properties, restore_mqd);
+	else
+		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
+					&q->gart_mqd_addr, &q->properties);
+
 	if (q->properties.is_active) {
 		if (!dqm->sched_running) {
 			WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
@@ -1334,7 +1341,8 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 
 static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 			struct qcm_process_device *qpd,
-			const struct kfd_criu_queue_priv_data *qd)
+			const struct kfd_criu_queue_priv_data *qd,
+			const void *restore_mqd)
 {
 	int retval;
 	struct mqd_manager *mqd_mgr;
@@ -1380,8 +1388,12 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	 * updates the is_evicted flag but is a no-op otherwise.
 	 */
 	q->properties.is_evicted = !!qpd->evicted;
-	mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
-				&q->gart_mqd_addr, &q->properties);
+	if (qd)
+		mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
+				     &q->properties, restore_mqd);
+	else
+		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
+					&q->gart_mqd_addr, &q->properties);
 
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
@@ -1769,6 +1781,50 @@ static int get_wave_state(struct device_queue_manager *dqm,
 			ctl_stack_used_size, save_area_used_size);
 }
 
+static void get_queue_dump_info(struct device_queue_manager *dqm,
+			const struct queue *q,
+			u32 *mqd_size)
+{
+	struct mqd_manager *mqd_mgr;
+	enum KFD_MQD_TYPE mqd_type =
+			get_mqd_type_from_queue_type(q->properties.type);
+
+	dqm_lock(dqm);
+	mqd_mgr = dqm->mqd_mgrs[mqd_type];
+	*mqd_size = mqd_mgr->mqd_size;
+
+	dqm_unlock(dqm);
+}
+
+static int dump_mqd(struct device_queue_manager *dqm,
+			  const struct queue *q,
+			  void *mqd)
+{
+	struct mqd_manager *mqd_mgr;
+	int r = 0;
+	enum KFD_MQD_TYPE mqd_type =
+			get_mqd_type_from_queue_type(q->properties.type);
+
+	dqm_lock(dqm);
+
+	if (q->properties.is_active || !q->device->cwsr_enabled) {
+		r = -EINVAL;
+		goto dqm_unlock;
+	}
+
+	mqd_mgr = dqm->mqd_mgrs[mqd_type];
+	if (!mqd_mgr->dump_mqd) {
+		r = -EOPNOTSUPP;
+		goto dqm_unlock;
+	}
+
+	mqd_mgr->dump_mqd(mqd_mgr, q->mqd, mqd);
+
+dqm_unlock:
+	dqm_unlock(dqm);
+	return r;
+}
+
 static int process_termination_cpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
@@ -1945,6 +2001,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.evict_process_queues = evict_process_queues_cpsch;
 		dqm->ops.restore_process_queues = restore_process_queues_cpsch;
 		dqm->ops.get_wave_state = get_wave_state;
+		dqm->ops.get_queue_dump_info = get_queue_dump_info;
+		dqm->ops.dump_mqd = dump_mqd;
 		break;
 	case KFD_SCHED_POLICY_NO_HWS:
 		/* initialize dqm for no cp scheduling */
@@ -1964,6 +2022,8 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.restore_process_queues =
 			restore_process_queues_nocpsch;
 		dqm->ops.get_wave_state = get_wave_state;
+		dqm->ops.get_queue_dump_info = get_queue_dump_info;
+		dqm->ops.dump_mqd = dump_mqd;
 		break;
 	default:
 		pr_err("Invalid scheduling policy %d\n", dqm->sched_policy);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index f9adce73ad94..90260a3e4037 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -81,13 +81,18 @@ struct device_process_node {
  *
  * @get_wave_state: Retrieves context save state and optionally copies the
  * control stack, if kept in the MQD, to the given userspace address.
+ *
+ * @get_queue_dump_info: Retrieves queue size information for CRIU checkpoint.
+ *
+ * @dump_mqd: dump queue MQD contents for CRIU checkpoint.
  */
 
 struct device_queue_manager_ops {
 	int	(*create_queue)(struct device_queue_manager *dqm,
 				struct queue *q,
 				struct qcm_process_device *qpd,
-				const struct kfd_criu_queue_priv_data *qd);
+				const struct kfd_criu_queue_priv_data *qd,
+				const void *restore_mqd);
 
 	int	(*destroy_queue)(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
@@ -135,6 +140,11 @@ struct device_queue_manager_ops {
 				  void __user *ctl_stack,
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
+
+	void	(*get_queue_dump_info)(struct device_queue_manager *dqm,
+				  const struct queue *q, u32 *mqd_size);
+
+	int	(*dump_mqd)(struct device_queue_manager *dqm, const struct queue *q, void *mqd);
 };
 
 struct device_queue_manager_asic_ops {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 6e6918ccedfd..e278b69d771e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -99,6 +99,13 @@ struct mqd_manager {
 				  u32 *ctl_stack_used_size,
 				  u32 *save_area_used_size);
 
+	void	(*dump_mqd)(struct mqd_manager *mm, void *mqd, void *mqd_dst);
+
+	void	(*restore_mqd)(struct mqd_manager *mm, void **mqd,
+				struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+				struct queue_properties *p,
+				const void *mqd_src);
+
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 064914e1e8d6..1d000252080c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -275,6 +275,69 @@ static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 					pipe_id, queue_id);
 }
 
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct cik_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct cik_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src)
+{
+	uint64_t addr;
+	struct cik_mqd *m;
+
+	m = (struct cik_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	m->cp_hqd_pq_doorbell_control = DOORBELL_OFFSET(qp->doorbell_off);
+
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct cik_sdma_rlc_registers *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct cik_sdma_rlc_registers));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+				struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+				struct queue_properties *qp,
+				const void *mqd_src)
+{
+	uint64_t addr;
+	struct cik_sdma_rlc_registers *m;
+
+	m = (struct cik_sdma_rlc_registers *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
+
 /*
  * preempt type here is ignored because there is only one way
  * to preempt sdma queue
@@ -388,6 +451,8 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd;
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
+		mqd->dump_mqd = dump_mqd;
+		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct cik_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -428,6 +493,8 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = destroy_mqd_sdma;
 		mqd->is_occupied = is_occupied_sdma;
+		mqd->dump_mqd = dump_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct cik_sdma_rlc_registers);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index c7fb59ca597f..13be01d1809f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -283,6 +283,41 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct v10_compute_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v10_compute_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src)
+{
+	uint64_t addr;
+	struct v10_compute_mqd *m;
+
+	m = (struct v10_compute_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	m->cp_hqd_pq_doorbell_control =
+		qp->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -370,6 +405,35 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct v10_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v10_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			     struct queue_properties *qp,
+			     const void *mqd_src)
+{
+	uint64_t addr;
+	struct v10_sdma_mqd *m;
+
+	m = (struct v10_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -414,6 +478,8 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->is_occupied = is_occupied;
 		mqd->mqd_size = sizeof(struct v10_compute_mqd);
 		mqd->get_wave_state = get_wave_state;
+		mqd->dump_mqd = dump_mqd;
+		mqd->restore_mqd = restore_mqd;
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
@@ -457,6 +523,8 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = destroy_mqd_sdma;
 		mqd->is_occupied = is_occupied_sdma;
+		mqd->dump_mqd = dump_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct v10_sdma_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7f4e102ff4bd..c07bea4026d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -338,6 +338,41 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct v9_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v9_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src)
+{
+	uint64_t addr;
+	struct v9_mqd *m;
+
+	m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	m->cp_hqd_pq_doorbell_control =
+		qp->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+				m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -425,6 +460,35 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct v9_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct v9_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			     struct queue_properties *qp,
+			     const void *mqd_src)
+{
+	uint64_t addr;
+	struct v9_sdma_mqd *m;
+
+	m = (struct v9_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -467,6 +531,8 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
 		mqd->get_wave_state = get_wave_state;
+		mqd->dump_mqd = dump_mqd;
+		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct v9_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -507,6 +573,8 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = destroy_mqd_sdma;
 		mqd->is_occupied = is_occupied_sdma;
+		mqd->dump_mqd = dump_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct v9_sdma_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 33dbd22d290f..1fb5ddf82307 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -303,6 +303,42 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	return 0;
 }
 
+static void dump_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct vi_mqd *m;
+
+	m = get_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct vi_mqd));
+}
+
+static void restore_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *qp,
+			const void *mqd_src)
+{
+	uint64_t addr;
+	struct vi_mqd *m;
+
+	m = (struct vi_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	m->cp_hqd_pq_doorbell_control =
+		qp->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	qp->is_active = 0;
+}
+
+
 static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -394,6 +430,35 @@ static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
 	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->kgd, mqd);
 }
 
+static void dump_mqd_sdma(struct mqd_manager *mm, void *mqd, void *mqd_dst)
+{
+	struct vi_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+
+	memcpy(mqd_dst, m, sizeof(struct vi_sdma_mqd));
+}
+
+static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
+			     struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			     struct queue_properties *qp,
+			     const void *mqd_src)
+{
+	uint64_t addr;
+	struct vi_sdma_mqd *m;
+
+	m = (struct vi_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memcpy(m, mqd_src, sizeof(*m));
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+
+	qp->is_active = 0;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int debugfs_show_mqd(struct seq_file *m, void *data)
@@ -436,6 +501,8 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->destroy_mqd = destroy_mqd;
 		mqd->is_occupied = is_occupied;
 		mqd->get_wave_state = get_wave_state;
+		mqd->dump_mqd = dump_mqd;
+		mqd->restore_mqd = restore_mqd;
 		mqd->mqd_size = sizeof(struct vi_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
@@ -476,6 +543,8 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 		mqd->update_mqd = update_mqd_sdma;
 		mqd->destroy_mqd = destroy_mqd_sdma;
 		mqd->is_occupied = is_occupied_sdma;
+		mqd->dump_mqd = dump_mqd_sdma;
+		mqd->restore_mqd = restore_mqd_sdma;
 		mqd->mqd_size = sizeof(struct vi_sdma_mqd);
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7e52ef69636a..c7499b803758 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1130,6 +1130,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
+			    const void *restore_mqd,
 			    uint32_t *p_doorbell_offset_in_process);
 int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid);
 int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
@@ -1152,6 +1153,9 @@ int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
 			      uint64_t fence_value,
 			      unsigned int timeout_ms);
 
+int pqm_get_queue_dump_info(struct process_queue_manager *pqm, unsigned int qid, u32 *mqd_size);
+int pqm_dump_mqd(struct process_queue_manager *pqm, unsigned int qid, void *dst_mqd);
+
 /* Packet Manager */
 
 #define KFD_FENCE_COMPLETED (100)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index f0e421a121df..c6e70ba7c1cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -209,6 +209,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			    struct queue_properties *properties,
 			    unsigned int *qid,
 			    const struct kfd_criu_queue_priv_data *q_data,
+			    const void *restore_mqd,
 			    uint32_t *p_doorbell_offset_in_process)
 {
 	int retval;
@@ -273,7 +274,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data, restore_mqd);
 		print_queue(q);
 		break;
 
@@ -293,7 +294,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 			goto err_create_queue;
 		pqn->q = q;
 		pqn->kq = NULL;
-		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data);
+		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data, restore_mqd);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
@@ -529,11 +530,20 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
 }
 
 
-static void get_queue_data_sizes(struct kfd_process_device *pdd,
+static int get_queue_data_sizes(struct kfd_process_device *pdd,
 				struct queue *q,
-				uint32_t *cu_mask_size)
+				uint32_t *cu_mask_size,
+				uint32_t *mqd_size)
 {
+	int ret;
+
 	*cu_mask_size = sizeof(uint32_t) * (q->properties.cu_mask_count / 32);
+
+	ret = pqm_get_queue_dump_info(&pdd->process->pqm, q->properties.queue_id, mqd_size);
+	if (ret)
+		pr_err("Failed to get queue dump info (%d)\n", ret);
+
+	return ret;
 }
 
 int kfd_process_get_queue_info(struct kfd_process *p, uint32_t *num_queues, uint32_t *q_data_sizes)
@@ -552,10 +562,14 @@ int kfd_process_get_queue_info(struct kfd_process *p, uint32_t *num_queues, uint
 				q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 				q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 				u32 cu_mask_size;
+				u32 mqd_size;
+				int ret;
 
-				get_queue_data_sizes(pdd, q, &cu_mask_size);
+				ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size);
+				if (ret)
+					return ret;
 
-				data_sizes += cu_mask_size;
+				data_sizes += cu_mask_size + mqd_size;
 				q_index++;
 			} else {
 				pr_err("Unsupported queue type (%d)\n", q->properties.type);
@@ -569,15 +583,17 @@ int kfd_process_get_queue_info(struct kfd_process *p, uint32_t *num_queues, uint
 	return 0;
 }
 
-static void criu_dump_queue(struct kfd_process_device *pdd,
+static int criu_dump_queue(struct kfd_process_device *pdd,
 			   struct queue *q,
 			   struct kfd_criu_queue_bucket *q_bucket,
 			   void *private_data)
 {
 	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
-	uint8_t *cu_mask;
+	uint8_t *cu_mask, *mqd;
+	int ret;
 
 	cu_mask = (void *)(q_data + 1);
+	mqd = cu_mask + q_data->cu_mask_size;
 
 	q_bucket->gpu_id = pdd->dev->id;
 	q_data->type = q->properties.type;
@@ -607,7 +623,14 @@ static void criu_dump_queue(struct kfd_process_device *pdd,
 	if (q_data->cu_mask_size)
 		memcpy(cu_mask, q->properties.cu_mask, q_data->cu_mask_size);
 
+	ret = pqm_dump_mqd(&pdd->process->pqm, q->properties.queue_id, mqd);
+	if (ret) {
+		pr_err("Failed dump queue_mqd (%d)\n", ret);
+		return ret;
+	}
+
 	pr_debug("Dumping Queue: gpu_id:%x queue_id:%u\n", q_bucket->gpu_id, q_data->q_id);
+	return ret;
 }
 
 static int criu_dump_queues_device(struct kfd_process_device *pdd,
@@ -627,6 +650,7 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 		struct kfd_criu_queue_priv_data *q_data;
 		uint64_t q_data_size;
 		uint32_t cu_mask_size;
+		uint32_t mqd_size;
 
 		if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE &&
 			q->properties.type != KFD_QUEUE_TYPE_SDMA &&
@@ -638,9 +662,11 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 
 		memset(&q_bucket, 0, sizeof(q_bucket));
 
-		get_queue_data_sizes(pdd, q, &cu_mask_size);
+		ret = get_queue_data_sizes(pdd, q, &cu_mask_size, &mqd_size);
+		if (ret)
+			return ret;
 
-		q_data_size = sizeof(*q_data) + cu_mask_size;
+		q_data_size = sizeof(*q_data) + cu_mask_size + mqd_size;
 
 		/* Increase local buffer space if needed */
 		if (q_private_data_size < q_data_size) {
@@ -656,9 +682,13 @@ static int criu_dump_queues_device(struct kfd_process_device *pdd,
 
 		q_data = (struct kfd_criu_queue_priv_data *)q_private_data;
 
+		/* data stored in this order: priv_data, cu_mask, mqd */
 		q_data->cu_mask_size = cu_mask_size;
+		q_data->mqd_size = mqd_size;
 
-		criu_dump_queue(pdd, q, &q_bucket, q_data);
+		ret = criu_dump_queue(pdd, q, &q_bucket, q_data);
+		if (ret)
+			break;
 
 		q_bucket.priv_data_offset = *queues_priv_data_offset;
 		q_bucket.priv_data_size = q_data_size;
@@ -711,7 +741,7 @@ int kfd_criu_dump_queues(struct kfd_process *p, struct kfd_ioctl_criu_dumper_arg
 		return -EINVAL;
 	}
 
-	/* Queue private data size for each queue can vary in size as it also includes cu_mask.
+	/* Queue private data size for each queue can vary in size as it also includes cu_mask, mqd.
 	 * First queue private data starts after all queue_buckets
 	 */
 
@@ -777,15 +807,16 @@ static int criu_restore_queue(struct kfd_process *p,
 			      void *private_data)
 {
 	struct kfd_criu_queue_priv_data *q_data = (struct kfd_criu_queue_priv_data *) private_data;
-	uint8_t *cu_mask;
+	uint8_t *cu_mask, *mqd;
 	struct queue_properties qp;
 	unsigned int queue_id;
 	int ret = 0;
 
 	pr_debug("Restoring Queue: gpu_id:%x queue_id:%u\n", q_bucket->gpu_id, q_data->q_id);
 
-	/* data stored in this order: cu_mask */
+	/* data stored in this order: cu_mask, mqd */
 	cu_mask = (void *)(q_data + 1);
+	mqd = cu_mask + q_data->cu_mask_size;
 
 	memset(&qp, 0, sizeof(qp));
 	ret = set_queue_properties_from_criu(&qp, q_bucket, q_data, cu_mask);
@@ -794,7 +825,7 @@ static int criu_restore_queue(struct kfd_process *p,
 
 	print_queue_properties(&qp);
 
-	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, NULL);
+	ret = pqm_create_queue(&p->pqm, dev, NULL, &qp, &queue_id, q_data, mqd, NULL);
 	if (ret) {
 		pr_err("Failed to create new queue err:%d\n", ret);
 		ret = -EINVAL;
@@ -890,6 +921,42 @@ int kfd_criu_restore_queues(struct kfd_process *p, struct kfd_ioctl_criu_restore
 	return ret;
 }
 
+int pqm_get_queue_dump_info(struct process_queue_manager *pqm, unsigned int qid, u32 *mqd_size)
+{
+	struct process_queue_node *pqn;
+
+	pqn = get_queue_by_qid(pqm, qid);
+	if (!pqn) {
+		pr_debug("amdkfd: No queue %d exists for operation\n", qid);
+		return -EFAULT;
+	}
+
+	if (!pqn->q->device->dqm->ops.get_queue_dump_info) {
+		pr_err("amdkfd: queue dumping not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	pqn->q->device->dqm->ops.get_queue_dump_info(pqn->q->device->dqm, pqn->q, mqd_size);
+	return 0;
+}
+
+int pqm_dump_mqd(struct process_queue_manager *pqm, unsigned int qid, void *mqd)
+{
+	struct process_queue_node *pqn;
+
+	pqn = get_queue_by_qid(pqm, qid);
+	if (!pqn) {
+		pr_debug("amdkfd: No queue %d exists for operation\n", qid);
+		return -EFAULT;
+	}
+
+	if (!pqn->q->device->dqm->ops.dump_mqd) {
+		pr_err("amdkfd: queue dumping not supported on this device\n");
+		return -EOPNOTSUPP;
+	}
+
+	return pqn->q->device->dqm->ops.dump_mqd(pqn->q->device->dqm, pqn->q, mqd);
+}
 
 #if defined(CONFIG_DEBUG_FS)
 
-- 
2.17.1

