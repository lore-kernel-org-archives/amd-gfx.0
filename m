Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C69CCF2DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC2C10E887;
	Mon, 19 Oct 2026 08:34:25 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1CB10E876
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feG5t9jS5kOQSiUXNVXhI4nvVQGMMI55KBbHaIVvQWJD8CQFaj/4HigaJn9RhCEjEyb+uax9TGoer5bWG3lWaHBfqmWgUSUoaoaOZoWT9Cy/IEGTxh8139M4TmUY4jLQX9P3cLcPEaqxtxdyeJAleyygYW47xfXwJOg7RToAMWeRA/dTHl8D/tPUwj5HpTAzlRp8zG4b7bI39tnPcr5r1Vcu+P8lGGIMz3PSpfIQHrW2Ge6NB0unZd/so3z9TJwh6yPmseWOUwRXoaZckvFc5GNKujol3qfvhPfBx57oCvnD89kAgA4pvRytv85TROwd2OxtOkZeEmHs8N71MYJuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tvecREpRljYoKc/PvW3TI5tdGMVPqAiTOmWasiYOqY=;
 b=XfbjGmn1M1PgROhLChULbXad8dCNf2hLj6wJmsmG8brV6Y0lskrIUKf26C2fro1PkDeIw0z3rldx5IlHTFJWlciWwNhLRjEp14fKXmmR+yZr/24fSrGjiyoHKGao4avvVJK8TYbqSqrGkjQLKtDswWp+mzH5mZumbOEOFHb+h9RSIYAf7aoc4TtBtD9QZ5c6zDFqQMQEWRY2wpAAaUyRv8GL8o7kyvLZnq1mDF6KlhFRtrzuvnsR/ezN5SgaKyDFa7rjGa1n65wxFDF79OCmp1wfo0Px1AHy/abn3UzJT+rNwOkqAuPb+ocoKbSwnpyqoTeA9OYFQwgHX7B8c+/2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tvecREpRljYoKc/PvW3TI5tdGMVPqAiTOmWasiYOqY=;
 b=WH3t/w5WrjMFQyZVj7GDocAesBNz7m0H6hwJGWoFVAH3tPWzPtgQrNarlxfoQpiSBAmht595FZVB2Wm5GrtC998H1BGQXSMJ57Hq+TmX/qIMj9vJJ/bZw10aVZt6WMOJ5Ytu/Y2LCU/VwTS7WN9FZQG+Umx/E2D2HncDHK+QPvM=
Received: from SJ0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:a03:2c0::22)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Mon, 19 Oct
 2026 08:34:12 +0000
Received: from MW2PEPF00014679.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::8) by SJ0PR13CA0017.outlook.office365.com
 (2603:10b6:a03:2c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Mon,
 19 Oct 2026 08:34:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014679.mail.protection.outlook.com (10.167.249.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:00 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 04/13] drm/amdgpu/userq: add a lock to keep user queues stable
 in an engine reset
Date: Mon, 19 Oct 2026 16:33:04 +0800
Message-ID: <20261019083402.2033724-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014679:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbb4e9f-98d1-46b7-2af8-08df2dbbbf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|22082099003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: bhRrUG3lTClAzKov/YQKhhH9UrcJtjKpCXo622BEHRQAwYj/jsCs9RxFHNAsAsogk88R68Rlv69NkYaVKSQTkIwzPtDLz5s4EKbfHt94Ob8WpakJqtyf9JXo+egbQGTrz3kesbYWnFpa/06RFBl2gZ7U4HHuHnnWRriarBbfd6442Bb9D3vTsFbdk50QQSeTFfdvuqmsQlLJ35wi3N4GcVzzFHdXuVJJA1GLyFikFWQsccgAbpVC4yRv9ypNT/gY1/HBY1+vjs1od8fqJI/cdIhklemiTHBh2oIXlLzg7vqkQX1oACH2plZfPD/z/aQgXkllIqz+z9/W4BGEuswp9L8LQnLF9x6xSqpWC31g2wy0hBzYtLCwUTEmMULcXvcsg6Ea3YQk26+u/x7GnYrV5AP33Clz01MrFcinU2ycGJQNYjjW26j2w9FgZQzGnvntE/+J5F1FLpn6M4de7iHIV2YglYBH/3mzvVLDnlLaJquDi7e0zTqy/sUWU2QU2sHE9pGBzMdh1/8FoPsVKX/0PPkwJhgebQp6ZkT6tNKm3bCqKPN71XexDyjgFkQWgc3gdPBuYohDDjcqNJHv/qoNSXMb7e7IYXfcEba0NQi8s7aze6MTRG5HD+jfjCyzqZk7Ln6Nk8qhQooxAVFg6l1EMHTssO3FB6hcOZtp7o2AnGgUdYx3l3qTo4WPSFCEqepm/nMm6apGy4ZGvdM01F0fxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2HFkRB9oNrgqlnawugGB5sYhY76RFk4hakStQ3ulrtDLY5KKyd3g2UR/P1wbN318XPvdbQyfh2aX8xTNjek7tO/nqg3VKYNco/YzrTgB+YIBHpNKC/xMi/jB4ztt6sKudplt1C1VNjUJi3kUVzOsE0hb2B+5vR0IER2MGSigmBs+Geva5/DGubuznwBGCKNr2WBa8KTkDFc3KBsnUd/GbygsS5DoA68grcoGpADoNrc2r9QTtCNFH88hADTxBvMRhgJDMEuZzdajXhNZ7ovoETgTEtbB5b53IDEdt6zdJ/wDPDyHo3ac4IPKD1J35VBUhvaxe97+PT/ZOnuU2pS33t4uvsaVuB659/ekC6QfPYbsC7kRnYLeW/V/aSLDsf6nT1RTsm3dGzyUa1MAyavBqarzL+LrsWwrvSt4h610xNKxl1WuN3qkZGulI76/FfkZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:10.1896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbb4e9f-98d1-46b7-2af8-08df2dbbbf67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014679.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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

An engine reset, eg. of the gfx engine, only takes the reset domain for
read: taking it for write would fail the queue operations of the compute
engine, eg. KFD adds and removes queues only with a read trylock. Unlike
in a full reset, that doesn't keep a user queue from being mapped,
unmapped or freed while the reset handles it.

Add a userq_engine_reset_sem per engine of the GFX IP. A reset that
handles the user queues of an engine holds it for write from saving
their state before the reset to recovering them after it. The queue
map/unmap/preempt/restore helpers, and removing a queue from the
doorbell xarray before it is freed, take the one of the queue's engine
for read: they only need to keep the reset out, and the queues of
different processes keep changing state concurrently. A preemption, for
example, polls its suspend fence for up to usec_timeout after it
released the MES lock. The queues of the other IPs, eg. SDMA, don't take
any, and the reset of one engine doesn't hold up the queues of the
other.

Each semaphore gets a lockdep class of its own: a compute reset may stop
the gfx user queues for enforced isolation.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 51 ++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b74f9136aa2e..3aba35bdfc9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3871,6 +3871,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
 
 	xa_init_flags(&adev->userq_doorbell_xa, XA_FLAGS_LOCK_IRQ);
+	/* A lockdep class each: a compute reset may stop gfx user queues. */
+	init_rwsem(&adev->gfx.userq_engine_reset_sem[AMDGPU_GFX_ENGINE_GFX]);
+	init_rwsem(&adev->gfx.userq_engine_reset_sem[AMDGPU_GFX_ENGINE_COMPUTE]);
 
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5bee0ca6a209..c9736a3c298e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -550,6 +550,11 @@ struct amdgpu_gfx {
 	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
 	/* Mutex for synchronizing KFD scheduler operations */
 	struct mutex                    userq_sch_mutex;
+	/*
+	 * Per engine: held for write by a reset that handles the user queues
+	 * of the engine, and for read to change the state of one or free it.
+	 */
+	struct rw_semaphore		userq_engine_reset_sem[AMDGPU_GFX_ENGINE_NUM];
 	u64				userq_sch_req_count[MAX_XCP];
 	bool				userq_sch_inactive[MAX_XCP];
 	/* atomic bitmap of faulted gfx UQ slots (index = pipe | queue << 2) */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1a2aa85c504e..cbad1fa1d2b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -306,6 +306,44 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
 
 
 
+/*
+ * The reset lock of the GFX IP engine that runs @queue, or NULL: an engine
+ * reset holds it for write while it handles the user queues of the engine.
+ */
+static struct rw_semaphore *
+amdgpu_userq_engine_reset_sem(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_GFX:
+		return &adev->gfx.userq_engine_reset_sem[AMDGPU_GFX_ENGINE_GFX];
+	case AMDGPU_HW_IP_COMPUTE:
+		return &adev->gfx.userq_engine_reset_sem[AMDGPU_GFX_ENGINE_COMPUTE];
+	default:
+		return NULL;
+	}
+}
+
+static void amdgpu_userq_reset_read_lock(struct amdgpu_usermode_queue *queue)
+{
+	struct rw_semaphore *sem = amdgpu_userq_engine_reset_sem(queue);
+
+	if (sem)
+		down_read(sem);
+}
+
+static void amdgpu_userq_reset_read_unlock(struct amdgpu_usermode_queue *queue)
+{
+	struct rw_semaphore *sem = amdgpu_userq_engine_reset_sem(queue);
+
+	if (sem)
+		up_read(sem);
+}
+
+DEFINE_GUARD(userq_reset_read, struct amdgpu_usermode_queue *,
+	     amdgpu_userq_reset_read_lock(_T), amdgpu_userq_reset_read_unlock(_T))
+
 static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
@@ -314,6 +352,8 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	guard(userq_reset_read)(queue);
+
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -338,6 +378,8 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	guard(userq_reset_read)(queue);
+
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -362,6 +404,8 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	guard(userq_reset_read)(queue);
+
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		trace_amdgpu_userq_state_start(queue);
@@ -388,6 +432,8 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	guard(userq_reset_read)(queue);
+
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -420,7 +466,10 @@ static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
 	struct amdgpu_device *adev = queue->userq_mgr->adev;
 
 	down_read(&adev->reset_domain->sem);
+	/* Keep the queue alive while an engine reset handles it. */
+	amdgpu_userq_reset_read_lock(queue);
 	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
+	amdgpu_userq_reset_read_unlock(queue);
 	up_read(&adev->reset_domain->sem);
 }
 
@@ -805,7 +854,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return 0;
 
 erase_doorbell:
+	amdgpu_userq_reset_read_lock(queue);
 	xa_erase_irq(&adev->userq_doorbell_xa, index);
+	amdgpu_userq_reset_read_unlock(queue);
 clean_mqd:
 	uq_funcs->mqd_destroy(queue);
 clean_doorbell_bo:
-- 
2.50.1

