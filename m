Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D89DE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 18:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957AC10EC51;
	Wed,  8 Jan 2025 18:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N+BiZiYy";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD7310EC50
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 18:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar+5GZR0HLMe/4fe6UR3C/qym0kniXOlWLJd5ZvQmx4eWaNoYeUGXjVL/cCDWEzF9re58KCpW8y0FFa+zhNgXbN/TdIEgiAM5/cHBsT46uPx+kasBVwC846by+jnze1OOt/iGT/YCy9J5sFvKoy2Y3ZRQZK7p6AWBm87+opWrE8musXunecSU7lRGBI5si3OFJdAhG9EzzlcLXdmAv0jBJRZvQXbpMb1f44Bg39XNelJpERBR+SEREJS1Q4auFlNHg56Swj2vsYyXNs/KKMZlDXHXsellkHvFc1DkoJgxsLptHpefkbDFlYtjBrcimmqpdEtFzgquufrvgn0hit5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPRwLxjZs+voCxV9gJWm3N+TTw3ZRokgMmTP3rUyxcg=;
 b=xbfUDF/GBsNbddyoX3wYZ2C6p3bHroDVcH70LKRFC56cahzLgAhBlQPQPyDS7TWAGIFjNMaL4HFQ/G41ashF3QK56zjIw1kmnWMzHCfekQOFb3SPuHTIPfHVyLDeFlD5oATvj02gPXyGZG5H0Z+niIDToaBpapyG8U70dJ4urzfzdDSlGghIqz+OpXNIRhEW0hZXwkbSQg2YNStoxqiNyJDehnZJkV3B+g/fchKdhB0fzP6FbomHjn1+EOKzf21hxX832u0+rXIFPU9SioXvz6hos9l4QQGSHcV5JxrMy63sNH9xi3n6d2RiyP5uzDdDb5pG+G88eaOuwjVadEVUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPRwLxjZs+voCxV9gJWm3N+TTw3ZRokgMmTP3rUyxcg=;
 b=N+BiZiYyaSJb3UeRYgwnyENlpDCy4nlhuJc1/mXcmTr6MPJZXtolH8rG7Lt16AT8oIZ07KETaZYLIRBMJS33SrBPBpGLANia6nqCCT1a5s1OotdXmmnAedpXYCGKRQo4cdoNX6TYat5g1+n4KOG8VNc0pN+crTvNzVeFdnKsQR0=
Received: from BN9PR03CA0699.namprd03.prod.outlook.com (2603:10b6:408:ef::14)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Wed, 8 Jan
 2025 18:15:01 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::49) by BN9PR03CA0699.outlook.office365.com
 (2603:10b6:408:ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 18:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 18:15:00 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 8 Jan 2025 12:15:00 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kent.russell@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH v3] drm/amdkfd: Uninitialized and Unused variables
Date: Wed, 8 Jan 2025 13:14:35 -0500
Message-ID: <20250108181435.2244038-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 470769af-1d7e-4c5c-8fc3-08dd30105de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PbaVPCzNXEqFt/Qxa55ekgRLCsQsV+PNz0cMeA/FzTXSwyS3cadb5UINKFFw?=
 =?us-ascii?Q?rOk99YuX7fEgBsF4Hq0QUBMFmcgCyrcDzU1OV/TO7+eUQH46tX6Y8NTUSa3D?=
 =?us-ascii?Q?ybtcu2NsgnYoxQnkMtuqvlFv1r7aYDcBYPz1+s/soAFblfLTL6TKLYVrQAoE?=
 =?us-ascii?Q?tAPuo2kuZrhc1+5WP2QIX/C+TEwqnV+HMubjIDNXB2J1UNNEJq8F5d5A9L7a?=
 =?us-ascii?Q?1JUbsMa3ltdTMauG5w/XRHzeY49wnd2rQIiq/Zl4jmZS0Q4aucE3xgBkYLzv?=
 =?us-ascii?Q?UPKn1WPddFBp5fZ8i+rToedhei6gDfhXDWQuUKVurMq23RoX1JvoFxTPwHm/?=
 =?us-ascii?Q?mu6qbEz3M8X9RZ7KI3W6dFbq7DQl8t9cYdTckOKCohrkQ4h/2aHZ36jjOL8K?=
 =?us-ascii?Q?U6mMvTAVQ7heDQYoS01L+Cfw7tvP0aMj5Edggl/vE+V7n3yJ4aiBSGwYYHJw?=
 =?us-ascii?Q?5kfygWAsTczbpHqFXX8AUMsM0atLJwATMwZcZdjZukizj612Ive4/fkRsns3?=
 =?us-ascii?Q?+ZTdxZVIeY5PXn+1UVE2H1d9hZuy2ONP+yCkkDlQYZDPhMX/uFNqAloiWDhF?=
 =?us-ascii?Q?EmcRo0WM0w5Fb0DnIaYLEzAWfl+0P07vj5V1Njb9yInzgZNtY0RoSYf4XpN/?=
 =?us-ascii?Q?rSSRlmYsNM3KZ6zeBmHq9ZAMxXBTpp48xtEojlBry242MZK+G1Z63eorr8x0?=
 =?us-ascii?Q?WNZmUIxE1wD9wiQMhXcMNTQz5FhvrxFi7JEUALnWORSz3VGdZ6pOmPaXxprS?=
 =?us-ascii?Q?MVtQNzdhSmmuWYcSfRhGsVneA5d0jX8iBaWHG1EXTFdshc1eQyc5j61BU/AA?=
 =?us-ascii?Q?19N1l+4QJKgPb35mxkY/6RaInJdPi6zMBbnOSZuL5h6IQeY9EYCawMtO4UGg?=
 =?us-ascii?Q?VqonaqPAFn4wX+EEt79ndgl0gOQIZ6F3nUv6W4q2hHstiCgay6oXvRVaV1nM?=
 =?us-ascii?Q?UWpLlYBr4YI0tAeLxL0qo0b+Wq88GvtX90oGJDgg5b+HKzUW2wLLXENQq1qu?=
 =?us-ascii?Q?Ad5S2YXGQb3w0i0KXsH8shG+EK1YjsRwvhAle9jTzvCtTWEOieGW7vSyOaH3?=
 =?us-ascii?Q?E8UkXl8vz/SFfjJXGpxFsnM1MZp06LjyShQ5ISrl0RzgSMu6kF7mCSURhsHH?=
 =?us-ascii?Q?u9qpUynbP3RKwVfH8QyR2ggb1u+qdLqtyM5Py8KGUdXRVZoHbOjN6GuGOzJk?=
 =?us-ascii?Q?mAyN7/LlF93jy9UBssNqN7gvrX8D2g+PCAig+4DzLncGa1qRUIV0UTe8r48Z?=
 =?us-ascii?Q?CarAONivOCP2BEcQhWVJRgO4IekhlEkaftJxW9U9ZGRKc9lTfrQxWg5/1A7P?=
 =?us-ascii?Q?1wa8DmZo/FAFweTC+1utx3cktr3W/j8OTdPknHSULVHHRBNGER1NCXjqkM4j?=
 =?us-ascii?Q?GW8mVOSVVt32s34b54q/kwoVLQ1gRNSkSN0ePC0K1FRFg2VPtJRAShjlEaxG?=
 =?us-ascii?Q?79ELiPTnTsbE4UijPb/RzNfnySGp9Us+1EwxQn3fK1xz6MigxTQq/HaAneyu?=
 =?us-ascii?Q?KhskcAiUViWB/M4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 18:15:00.8723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470769af-1d7e-4c5c-8fc3-08dd30105de4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
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
 .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 24 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 42 ++++++++-----------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 ++--
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 +++----
 .../amd/amdkfd/kfd_process_queue_manager.c    |  6 +--
 8 files changed, 43 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 795382b55e0a..9767f6483871 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -35,7 +35,7 @@ static bool cik_event_interrupt_isr(struct kfd_node *dev,
 			(const struct cik_ih_ring_entry *)ih_ring_entry;
 	const struct kfd2kgd_calls *f2g = dev->kfd2kgd;
 	unsigned int vmid;
-	uint16_t pasid;
+	uint16_t pasid = 0;
 	bool ret;
 
 	/* This workaround is due to HW/FW limitation on Hawaii that
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 065d87841459..306ea5a8a747 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -923,7 +923,7 @@ static int kfd_ioctl_get_tile_config(struct file *filep,
 {
 	struct kfd_ioctl_get_tile_config_args *args = data;
 	struct kfd_process_device *pdd;
-	struct tile_config config;
+	struct tile_config config = {0};
 	int err = 0;
 
 	mutex_lock(&p->mutex);
@@ -1042,7 +1042,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 {
 	struct kfd_ioctl_alloc_memory_of_gpu_args *args = data;
 	struct kfd_process_device *pdd;
-	void *mem;
+	void *mem = NULL;
 	struct kfd_node *dev;
 	int idr_handle;
 	long err;
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
@@ -1551,7 +1551,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	struct kfd_process_device *pdd;
 	int idr_handle;
 	uint64_t size;
-	void *mem;
+	void *mem = NULL;
 	int r;
 
 	mutex_lock(&p->mutex);
@@ -1837,10 +1837,8 @@ static int criu_get_prime_handle(struct kgd_mem *mem,
 				 int flags, u32 *shared_fd,
 				 struct file **file)
 {
-	struct dma_buf *dmabuf;
-	int ret;
-
-	ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
+	struct dma_buf *dmabuf = NULL;
+	int ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
 	if (ret) {
 		pr_err("dmabuf export failed for the BO\n");
 		return ret;
@@ -2291,7 +2289,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 	int idr_handle;
 	int ret;
 	const bool criu_resume = true;
-	u64 offset;
+	u64 offset = 0;
 
 	if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) {
 		if (bo_bucket->size !=
@@ -2358,7 +2356,7 @@ static int criu_restore_bo(struct kfd_process *p,
 			   struct file **file)
 {
 	struct kfd_process_device *pdd;
-	struct kgd_mem *kgd_mem;
+	struct kgd_mem *kgd_mem = NULL;
 	int ret;
 	int j;
 
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
index 1405e8affd48..d4a346ac1167 100644
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
 
@@ -795,7 +795,7 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 {
 	int status = 0;
 	unsigned int vmid;
-	uint16_t queried_pasid;
+	uint16_t queried_pasid = 0;
 	union SQ_CMD_BITS reg_sq_cmd;
 	union GRBM_GFX_INDEX_BITS reg_gfx_index;
 	struct kfd_process_device *pdd;
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
@@ -3647,7 +3639,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 {
 	struct device_queue_manager *dqm = data;
 	uint32_t xcc_mask = dqm->dev->xcc_mask;
-	uint32_t (*dump)[2], n_regs;
+	uint32_t (*dump)[2] = {}, n_regs = 0;
 	int pipe, queue;
 	int r = 0, xcc_id;
 	uint32_t sdma_engine_start;
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 083f83c94531..a6188c06c7a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -272,7 +272,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	struct kfd_process_device *pdd = NULL;
 	int i;
 	struct kfd_cu_occupancy *cu_occupancy;
-	u32 queue_format;
+	u32 queue_format = 0;
 
 	pdd = container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev = pdd->dev;
@@ -743,9 +743,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 				   uint32_t flags, struct kgd_mem **mem, void **kptr)
 {
 	struct kfd_node *kdev = pdd->dev;
-	int err;
-
-	err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev, gpu_va, size,
+	int err = amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev, gpu_va, size,
 						 pdd->drm_priv, mem, NULL,
 						 flags, false);
 	if (err)
@@ -798,8 +796,8 @@ static int kfd_process_device_reserve_ib_mem(struct kfd_process_device *pdd)
 			KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE |
 			KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
 			KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
-	struct kgd_mem *mem;
-	void *kaddr;
+	struct kgd_mem *mem = NULL;
+	void *kaddr = NULL;
 	int ret;
 
 	if (qpd->ib_kaddr || !qpd->ib_base)
@@ -1369,8 +1367,8 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
 			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
 			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
-	struct kgd_mem *mem;
-	void *kaddr;
+	struct kgd_mem *mem = NULL;
+	void *kaddr = NULL;
 	int ret;
 
 	if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 9df56f8e09f9..06fbb107f303 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -769,7 +769,7 @@ int kfd_process_get_queue_info(struct kfd_process *p,
 			if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
 				q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 				q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-				uint32_t mqd_size, ctl_stack_size;
+				uint32_t mqd_size = 0, ctl_stack_size = 0;
 
 				*num_queues = *num_queues + 1;
 
@@ -872,8 +872,8 @@ static int criu_checkpoint_queues_device(struct kfd_process_device *pdd,
 	list_for_each_entry(q, &pdd->qpd.queues_list, list) {
 		struct kfd_criu_queue_priv_data *q_data;
 		uint64_t q_data_size;
-		uint32_t mqd_size;
-		uint32_t ctl_stack_size;
+		uint32_t mqd_size = 0;
+		uint32_t ctl_stack_size = 0;
 
 		if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE &&
 			q->properties.type != KFD_QUEUE_TYPE_SDMA &&
-- 
2.43.0

