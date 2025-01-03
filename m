Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D01E7718F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 20:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A7210E435;
	Fri,  3 Jan 2025 20:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nOg03YvK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82FC10E435
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 20:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdfkWslhSz7zrD1LOLgyhTH8RYHSOaYi24HQ2ea3ICNu7gXqpEAN7llaJbwsATPQYadHlU0QMOhB01JSAMSlj7a9+vcdWF6Zs5UsuQSWJZL3YoGESOYz085qAfISZ/+t4UDrgZfi7+KS+YpmUhZrAy1N6IdunnLIawPptVeZdxirHZmjAhHclmHC8hJbSjIuiZXGCJjcUWtENRdg73c3Y/GRe04KKL5zfzW7UqZWXk8Dw4qxg6uDcqiI9kfZa9kv28bTU8iO7h486TvJCxqpWuFK/uPotm/9ZJmChx8S06BMfdp87rtWg4DxSfZWXfOLEi4J+/b1o8PXFlcGgTUmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCdmEpEP66yGrVU1pGiOl0nwAjNh99IMbAVorewRVEY=;
 b=aRBrCbSfgECEvK/VIHYrq8Oac6pzyfV0UuuFdaGv8EUySaOW7bgnuEipYgQ4bX25n0YAM4GYdDuwvKppZr+q5VC6Q2wZKCfr3hchbuh+qsVlZ3qhrQOfdW/WjOKb+mYIVDEjnqGfSDRGsBA8coc+r9WhBsY5EkYsgkgR+JIbHYV7obtG+7fhtKXMn9paXn6AqV9MjebJl/hnlxC6njqUO83fXCPEH1N8f2T1vF0Opr+N9zCxHbv2dAeOhJFu8Ffx68EPUWiUcz/w/BhgIRKWFYZATqWfrytQ7T7v2uuEpPpQb10DeT/wmh/f+NHLWp1fYzb+VMxklKUcAp0LOdif4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCdmEpEP66yGrVU1pGiOl0nwAjNh99IMbAVorewRVEY=;
 b=nOg03YvKkHrhAX57Wnc7B5+jBhn/RIv/cNsc6CvOaeM5PlYmi7m3tEBahsb3DF6xqUEuTwuAUfM371N+t53WJ/5uZ2+wCi7ZZu8WT17INeLChqO4cuFwojmgT/SJWvFlvckAv7kSnKlzKFgdtaSj6jIFEFbNo8y9CS+ePmE+LdE=
Received: from MN2PR20CA0044.namprd20.prod.outlook.com (2603:10b6:208:235::13)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 20:40:09 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:235:cafe::f3) by MN2PR20CA0044.outlook.office365.com
 (2603:10b6:208:235::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 20:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.0 via Frontend Transport; Fri, 3 Jan 2025 20:40:08 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 3 Jan 2025 14:40:07 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kent.russell@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH v4] drm/amdkfd: Uninitialized and Unused variables
Date: Fri, 3 Jan 2025 15:39:50 -0500
Message-ID: <20250103203950.1470013-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 63aa0827-d4a3-45b1-44ab-08dd2c36cfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nvz48FZHp5iPkEKhUe8IOF0O8YVatroXh22FqsUebS+X2eKLOvp/kUsAUSx/?=
 =?us-ascii?Q?YoTXqkqqcDr7L5hrZDMxObqeoIf+KRB9bWA32ay+Ou4+QJWhSxAm5oryhh9z?=
 =?us-ascii?Q?vumc168cK7x1omcG7XzthDLfEO+yzbv99A8ORRLY22gY3OQvdQiLONz5NKa/?=
 =?us-ascii?Q?zc7b3jAiIQ1n3+QUa3FtwG+QDcRbfEy9LXAOIDVbAME9XPE7aT7oqf8NJwA/?=
 =?us-ascii?Q?QbECNaBMYGZAEDBekEqzF/LH2aweCAf0rJyPORWIeo7/Xjtg+f7A9BX2quzR?=
 =?us-ascii?Q?D8IxGAebYw42sZueZAgt9/Ep9OLLOEpi9gozU2w4xivRg0MJyZd7TNguEG6V?=
 =?us-ascii?Q?XnSXjXBYrMO5RcHATssXNbxHnDzTwv4aMiaULwcGyvd2p1jbevpAu4j4IZg8?=
 =?us-ascii?Q?/cs4QHXsbG4R3HdLqmrc79EYyleNkkQyG1tYiSMeaciSxYyZcekmKc2kOKQE?=
 =?us-ascii?Q?l7liyEgSgTVkaajQJbKeBN9KZXYqdWP0ogLoPkSsd0GpHHv1lQBlq5BMd+6+?=
 =?us-ascii?Q?Dbtf8qXTXQo0Gn1GYY+EWJQ2PaEdDBbl7eLJuWgAdo5YfMwBht4GWYDWn0I0?=
 =?us-ascii?Q?mqivyPxwEKsmeRh6TsHkwwsxVqBxrEU1yiggpeMQa5HEjTDFCPH/QceKmAmW?=
 =?us-ascii?Q?22Dvxx3vg/KvjsjNQ7ilPgX+PNjusa+Y9HHFzIUI8cEERZGlSCcEAPnPlXaa?=
 =?us-ascii?Q?X3DJHKof/hJKzOJe2/F+4Vwwz8unKqb4CAQwx+/+QJdJbV4OYtGpF+tzQjOk?=
 =?us-ascii?Q?jwHvygCQ3oO31RQyazNcNBajEssVLMkCGX86IGjSxaH2jcCTKYNyNaa74GFc?=
 =?us-ascii?Q?PXfn74AiJfKj+FloROM6nNMoNnHD6VwbfZduZqZ5hyj478LsZC2mbHnw33In?=
 =?us-ascii?Q?HOVTN8px3zGvdDXK2wpbKpKwQDlfSuxxaHuPaxiAhl72A6LTdX1A2cuq9DA7?=
 =?us-ascii?Q?2jvEvlqP3Ig8Ec5+Ch2mBNeLYKgPxgZNtNZPSOi3HfAn/5EOBiDWNd3miQpF?=
 =?us-ascii?Q?LOx+JK1eT0xNLBjAGqBytCvGJrOoiIhxq4RlCUGjQ7KLkI+EvwSewzNWLFkI?=
 =?us-ascii?Q?oth3Zaqm5XWgji54C/v8HU2Np12DUTI5dimbom+vv3yScplVZxhZDg86bHXO?=
 =?us-ascii?Q?E13nnjWKLAjhCXHWICHkf86QjxcdZ01RL5AiiPVfe2FadClOEiIFkezkBcCm?=
 =?us-ascii?Q?NzbJjHaYYv/zN5Yt/9z4YIWLzOWpu5N0EnPwKrnzkFJXtn7bBFW+q4OnU21r?=
 =?us-ascii?Q?XKqlswpHwCFxoLiSCZ8pGLluEMRPtija1yTXgHJ61L12Xh+1/x+UMX3MOdj+?=
 =?us-ascii?Q?VXT70YjzG2nkLKp55Vy9CxUKt7oiI9bPUgWG5glImmJKqy/YB7mHSMpVoon0?=
 =?us-ascii?Q?vs7nE5my7c0dacwpM1V85XHbMLmH10eeLq5IPBUFMthGvFSAhC25xhzQW5ba?=
 =?us-ascii?Q?Ak2Qby80CHFat6oBai8OxgSUgpq0TDzNbnU/K85CQ2+gJdhNnDKpE3Dx/TPk?=
 =?us-ascii?Q?VK5ZB4mPCnXPv+Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 20:40:08.4011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63aa0827-d4a3-45b1-44ab-08dd2c36cfeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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

This patch initialized key variables and removed unused ones.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  8 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 38 ++++++++-----------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 ++--
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  1 -
 5 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 065d87841459..cf2dc2c23d2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1496,12 +1496,12 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 {
 	struct kfd_ioctl_get_dmabuf_info_args *args = data;
 	struct kfd_node *dev = NULL;
-	struct amdgpu_device *dmabuf_adev;
+	struct amdgpu_device *dmabuf_adev = NULL;
 	void *metadata_buffer = NULL;
-	uint32_t flags;
-	int8_t xcp_id;
+	uint32_t flags = 0;
+	int8_t xcp_id = 0;
 	unsigned int i;
-	int r;
+	int r = 0;
 
 	/* Find a KFD GPU device that supports the get_dmabuf_info query */
 	for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index a29374c86405..5af5b9baa894 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1038,7 +1038,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
-	int ret, i;
+	int ret = 0, i;
 
 	if (!kfd->init_complete)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 1405e8affd48..23673065c7f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -199,7 +199,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct mes_add_queue_input queue_input;
-	int r, queue_type;
+	int r = 0, queue_type;
 	uint64_t wptr_addr_off;
 
 	if (!dqm->sched_running || dqm->sched_halt)
@@ -284,7 +284,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			struct qcm_process_device *qpd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
-	int r;
+	int r = 0;
 	struct mes_remove_queue_input queue_input;
 
 	if (!dqm->sched_running || dqm->sched_halt)
@@ -634,7 +634,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 				const void *restore_mqd, const void *restore_ctl_stack)
 {
 	struct mqd_manager *mqd_mgr;
-	int retval;
+	int retval = 0;
 
 	dqm_lock(dqm);
 
@@ -862,11 +862,9 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
 				struct queue *q)
 {
-	int retval;
-	struct mqd_manager *mqd_mgr;
-
-	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
-			q->properties.type)];
+	int retval = 0;
+	struct mqd_manager *mqd_mgr =
+	  dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
 
 	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		deallocate_hqd(dqm, q);
@@ -921,7 +919,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
 				struct queue *q)
 {
-	int retval;
+	int retval = 0;
 	uint64_t sdma_val = 0;
 	struct device *dev = dqm->dev->adev->dev;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
@@ -1150,7 +1148,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 	struct queue *q;
 	struct mqd_manager *mqd_mgr;
 	struct kfd_process_device *pdd;
-	int retval, ret = 0;
+	int retval = 0, ret = 0;
 
 	dqm_lock(dqm);
 	if (qpd->evicted++ > 0) /* already evicted, do nothing */
@@ -1260,7 +1258,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	uint64_t pd_base;
 	uint64_t eviction_duration;
-	int retval, ret = 0;
+	int retval = 0, ret = 0;
 
 	pdd = qpd_to_pdd(qpd);
 	/* Retrieve PD base */
@@ -1437,13 +1435,12 @@ static int register_process(struct device_queue_manager *dqm,
 static int unregister_process(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
-	int retval;
+	int retval = 0;
 	struct device_process_node *cur, *next;
 
 	pr_debug("qpd->queues_list is %s\n",
 			list_empty(&qpd->queues_list) ? "empty" : "not empty");
 
-	retval = 0;
 	dqm_lock(dqm);
 
 	list_for_each_entry_safe(cur, next, &dqm->queues, list) {
@@ -1473,7 +1470,7 @@ set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
 			unsigned int vmid)
 {
 	uint32_t xcc_mask = dqm->dev->xcc_mask;
-	int xcc_id, ret;
+	int xcc_id, ret = 0;
 
 	for_each_inst(xcc_id, xcc_mask) {
 		ret = dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
@@ -1827,8 +1824,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	struct device *dev = dqm->dev->adev->dev;
 	int retval, num_hw_queue_slots;
 
-	retval = 0;
-
 	dqm_lock(dqm);
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes) {
@@ -1988,7 +1983,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 			const struct kfd_criu_queue_priv_data *qd,
 			const void *restore_mqd, const void *restore_ctl_stack)
 {
-	int retval;
+	int retval = 0;
 	struct mqd_manager *mqd_mgr;
 
 	if (dqm->total_queue_count >= max_num_of_queues_per_device) {
@@ -2282,8 +2277,8 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				bool reset)
 {
 	struct device *dev = dqm->dev->adev->dev;
-	struct mqd_manager *mqd_mgr;
-	int retval;
+	struct mqd_manager *mqd_mgr = NULL;
+	int retval = 0;
 
 	if (!dqm->sched_running)
 		return 0;
@@ -2705,7 +2700,7 @@ static int checkpoint_mqd(struct device_queue_manager *dqm,
 static int process_termination_cpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
-	int retval;
+	int retval = 0;
 	struct queue *q;
 	struct device *dev = dqm->dev->adev->dev;
 	struct kernel_queue *kq, *kq_next;
@@ -2715,8 +2710,6 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES;
 	bool found = false;
 
-	retval = 0;
-
 	dqm_lock(dqm);
 
 	/* Clean all kernel queues */
@@ -3439,7 +3432,6 @@ int suspend_queues(struct kfd_process *p,
 					else
 						per_device_suspended++;
 				} else if (err != -EBUSY) {
-					r = err;
 					queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
 					break;
 				}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ff417d5361c4..55fc98358999 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -571,7 +571,7 @@ static int hiq_load_mqd_kiq_v9_4_3(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *p, struct mm_struct *mms)
 {
 	uint32_t xcc_mask = mm->dev->xcc_mask;
-	int xcc_id, err, inst = 0;
+	int xcc_id, err = 0, inst = 0;
 	void *xcc_mqd;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
 
@@ -595,7 +595,7 @@ static int destroy_hiq_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 			uint32_t pipe_id, uint32_t queue_id)
 {
 	uint32_t xcc_mask = mm->dev->xcc_mask;
-	int xcc_id, err, inst = 0;
+	int xcc_id, err = 0, inst = 0;
 	uint64_t hiq_mqd_size = kfd_hiq_mqd_stride(mm->dev);
 	struct v9_mqd *m;
 	u32 doorbell_off;
@@ -751,7 +751,7 @@ static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   uint32_t pipe_id, uint32_t queue_id)
 {
 	uint32_t xcc_mask = mm->dev->xcc_mask;
-	int xcc_id, err, inst = 0;
+	int xcc_id, err = 0, inst = 0;
 	void *xcc_mqd;
 	struct v9_mqd *m;
 	uint64_t mqd_offset;
@@ -781,7 +781,7 @@ static int load_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
 	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
 	uint32_t xcc_mask = mm->dev->xcc_mask;
-	int xcc_id, err, inst = 0;
+	int xcc_id, err = 0, inst = 0;
 	void *xcc_mqd;
 	uint64_t mqd_stride_size = mm->mqd_stride(mm, p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index c1199d06d131..cf803aed5069 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -173,7 +173,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
 				engine_sel__mes_map_queues__sdma0_vi;
-		use_static = false; /* no static queues under SDMA */
 		break;
 	default:
 		WARN(1, "queue type %d", q->properties.type);
-- 
2.43.0

