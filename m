Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96916078248
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uV+9Btyb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4725910F040;
	Mon,  2 Nov 2026 15:48:59 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C2610F041
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 15:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnZEBytSC2AeuCPXtmqx2bSb+eEmPcRFchlh2/4svAgoADvnyLMc4yJOKqURungl1ozZSkMWviFs/mWqW6u5mbomd3O3996LsMquz6uTwE/tCpR7pjkij5RCb3GFDQJD8CK5LR1Lr466WWwuimoKVeF4rX4fIJqRTYyh4s3AOk1ly8PRxxZIsOVQ2ZtZ2sSUkgwksxxzcAqHwP8FlXO1R++fb+2v4IKpZJEozmDhu13kGon7k9QtEhw9fmyZzd8CZ4TTj57krSe5eFLGJ2dM4yjgpjO3BZi+LUbEb6c46Gy+op3cl3NH0hH/eMWjd135c5ymFhA59j7s4qevbuGUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lAhTgIgGfVsOc/By0XGbPHMzG8hvxqNVptCD0fp6Fg=;
 b=prJv5ijyf/RmylVvR+si1ykELw9OxAt3bUsDg+rAXFxeaTEqKPiGaRJUK1vH7leJXmB80xaXJw2XBARbqS4CdEdMXhMfSMnZyM9NXufpTP3YcL5B9rhKFWlwOuVt6JOEqSCvrmUMFfabZPGeWpAxD/26UEjbw/8YnCJ7XWA1ZOz6CohjAbPLj0OHee5YLPraRx12WvmenHqlYxNBUuxbN6t2nkVa3Ob1SMu6UUmsctSfiDlC9vZvxfebzuMnTPQKg2LFRIbMoBATJ5cXUSmt4HoMYMZNdVUzsw75pYe4UToBdzHszEeh+CkFiQ3bwgJxBF9AN0XEVt7e9a0+RdeugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lAhTgIgGfVsOc/By0XGbPHMzG8hvxqNVptCD0fp6Fg=;
 b=uV+9BtybnQiXll952CqwN2NF/DC08mRJL3syFMB/IpW3zNlwJch3d85AnFOIctNbdts8KE9xDG+7UokxjYRD7n3BOmAx4WDGP5v8WAglspro6K7ybYW5FVdtv34ZsICr9CuYMb8mW9t+8fSsseExDgRge1mpw9/3TwHFkYZL1+M=
Received: from CH0P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::16)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:48:47 +0000
Received: from CH3PEPF0002457D.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::24) by CH0P221CA0012.outlook.office365.com
 (2603:10b6:610:11c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 2
 Nov 2026 15:48:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457D.mail.protection.outlook.com (10.167.252.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 15:48:45 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 2 Nov 2026 09:48:41 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shweta.Khatri@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: load-balance SDMA_BY_ENG_ID queue allocation
 across engines
Date: Mon, 2 Nov 2026 10:48:23 -0500
Message-ID: <20261102154823.20736-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457D:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: b062d989-c9dc-48b1-9539-08df38f8c705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|18002099003|261102123227099003|56012099006|11063799006|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: XBWQeS/u/w5LYMVD8mgcIkxHX0URPK7SnzZjeOWLmlmxXP+ybLKhcKMVZP7Cxy1ENpgW7wHuvkbWdD/tRTjGx2vaYEKkbuxmpHb9s+mnVSMYwVu3h7eIqT9hVBISWElXO2Mg0Mm1RyU7B+c7L+vHWT0/tW3AIBCs82JPmsZrlCqvUZrPGkggwSU01M8es8Mjlh2W3jF6wdOzRgMMGHpXG2DYgycCiWZ+9ZLsb5rC0P4bM9w2Sm/JD7VCNjrJiNib5TMjIOanQI+mbL7Nj90a9IZo5QTDilaGqIJSjU3niygdFmwPpo4iok8NPP3JBqpneqXVjlcSOP2LHgiYbbBo9HVO3vR6tFsFpXSb+685r8G3xI55rOrnzSE6uCXo+dROGxr9tnN4G3Bayxvafne1/5l7yfiJh6+4On0uymTINUyb25jYOmej4bXkLEEE9uWNVdyE/Bap8m3wIsrZLsV+CjWgNRxVuIOWKw4ZWKCS/0r0cKVAD+K16CtD+MDoxYOelq1lk9wGRMClSLib9KrFMAb1PtFPB4zwA3YcWiRni3DtAT9S20t+mizT3kmm3YTFnAmJ686jWkAz8PHZHBIK2FLj4/EMww5EVyrthcFb6O//yMfD3NUHdH8zmSSoXqanMEXowmFOihtHNt/moKxELg1O7f6tCE85Om9ONGN3JuVZPp1bDD8nvNc5N8sQ0DE9iSz7poptJ7dDP2PI33FyMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(261102123227099003)(56012099006)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yqa/2rItAuiFHIasVexWO8Si0SuuZFGm/RM93E6a1DyoWJAyZWoV+FAK0qI9JtFTGnEcWvh9tNmqyB875/n3vBcSRzxidDq0FKwB6rf5MXN0nmT21LIcF789G0QjMom2BpIZlqRvu4zGr7dFMe/JPVbW4B5OJXOh/NgfEcY8Ys0b2rEMzwjboiVcn+PswZoFpLn2K8HgF9pZTEjreYrHetBmW9HiO7F0s88hGhpqaFPE0zAz7WNx0Ig8UTS7f/81/yQYffjwzTwnZMoQIVbaB/q5hXBJBzonXvDuBLmPT+TMBh2cJehnU4A/Ml9PRJgpDtl2tgO0FCkhiTGQdYadbj4e1KqWFDEm91CQUybL7i+U0e28XZIP3o36R67bmmyomhHs7YTPrzRsi1ppYGE7KZMsbvL4DCTaHvB1jO/z0sEe8a6xgZxjmpj4lNg82eg4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:48:45.1403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b062d989-c9dc-48b1-9539-08df38f8c705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ROCr picks a P2P SDMA engine independently per process, so many
processes sharing a GPU can converge on the same engine while sibling
engines idle. Use the existing per-engine sdma_bitmap/xgmi_sdma_bitmap
occupancy, already tracked across all processes, to redirect queue
creation to a less contended sibling engine when the requested one is
shared with another process or full. Prefers (in order): a fully idle
sibling, a sibling used only by this process, the requested engine if
it still has room, then any sibling with room.

No uAPI change: KFD never reports the allocated sdma_engine_id back to
userspace, so this redirect is fully transparent to existing callers.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
 1 file changed, 140 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7b2f6636ae0f..c8db35952e4b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -70,7 +70,8 @@ static inline void deallocate_hqd(struct device_queue_manager *dqm,
 				struct queue *q);
 static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
-				struct queue *q, const uint32_t *restore_sdma_id);
+				struct queue *q, struct qcm_process_device *qpd,
+				const uint32_t *restore_sdma_id);
 
 static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
 static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
@@ -807,7 +808,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 			q->pipe, q->queue);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
+		retval = allocate_sdma_queue(dqm, q, qpd, qd ? &qd->sdma_id : NULL);
 		if (retval)
 			goto deallocate_vmid;
 		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
@@ -1923,8 +1924,125 @@ static int stop_nocpsch(struct device_queue_manager *dqm)
 	return 0;
 }
 
+/*
+ * Count how many of one physical SDMA engine's queue slots are already
+ * claimed by a queue, by any process sharing this device. Per-engine slots
+ * are interleaved in the bitmap with a stride of num_engines, i.e. engine
+ * "engine" owns bits {engine, engine + num_engines, engine + 2*num_engines, ...}.
+ */
+static uint32_t sdma_engine_busy_slots(unsigned long *bitmap, uint32_t num_engines,
+					uint32_t num_queues, uint32_t engine)
+{
+	uint32_t slot, busy = 0;
+
+	for (slot = engine; slot < num_queues; slot += num_engines)
+		if (!test_bit(slot, bitmap))
+			busy++;
+
+	return busy;
+}
+
+/*
+ * Count how many of this engine's busy slots (per sdma_engine_busy_slots())
+ * are already owned by the calling process itself, by walking its own
+ * (typically short) queue list rather than every queue on the device.
+ */
+static uint32_t sdma_engine_own_slots(struct qcm_process_device *qpd, uint32_t num_engines,
+				       bool is_xgmi, uint32_t engine)
+{
+	struct queue *cur;
+	uint32_t count = 0;
+
+	list_for_each_entry(cur, &qpd->queues_list, list) {
+		bool cur_is_xgmi = cur->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI;
+
+		if (cur->properties.type != KFD_QUEUE_TYPE_SDMA &&
+		    cur->properties.type != KFD_QUEUE_TYPE_SDMA_XGMI)
+			continue;
+		if (cur_is_xgmi != is_xgmi)
+			continue;
+		if ((cur->sdma_id % num_engines) == engine)
+			count++;
+	}
+
+	return count;
+}
+
+/*
+ * KFD_QUEUE_TYPE_SDMA_BY_ENG_ID callers (ROCr in particular) always ask for
+ * one concrete engine id, picked with no visibility into what other
+ * processes sharing this GPU have already claimed. When several independent
+ * processes make the same locally-reasonable choice -- e.g. each one's
+ * round-robin or recommended-engine logic lands on "the first XGMI peer I
+ * ever talked to" -- they collide on one physical SDMA engine while sibling
+ * engines sit completely idle, splitting that one engine's bandwidth across
+ * every colliding process instead of spreading the traffic out.
+ *
+ * dqm->sdma_bitmap / xgmi_sdma_bitmap already record per-engine slot
+ * occupancy across every process on this device. Reuse that existing,
+ * cross-process-shared state with redirecting preferred oder: requested
+ * engine not foreign-shared and still has room, a fully idle sibling,
+ * a sibling used only by this process, the requested engine if it still
+ * has room, then any sibling with room.
+ */
+static uint32_t pick_sdma_engine(struct qcm_process_device *qpd, unsigned long *bitmap,
+				  uint32_t num_engines, uint32_t num_queues, bool is_xgmi,
+				  uint32_t requested_engine)
+{
+	uint32_t eng, busy, own, slots_per_engine = num_queues / num_engines;
+	bool requested_has_room;
+	int fallback_own_eng = -1, fallback_any_eng = -1;
+
+	busy = sdma_engine_busy_slots(bitmap, num_engines, num_queues, requested_engine);
+	if (busy == 0)
+		return requested_engine;
+
+	requested_has_room = busy < slots_per_engine;
+	own = sdma_engine_own_slots(qpd, num_engines, is_xgmi, requested_engine);
+	if (own >= busy && requested_has_room)
+		return requested_engine;
+
+	/*
+	 * Single pass over sibling engines: return an idle one immediately.
+	 * Otherwise remember the first sibling with room, split into a
+	 * same-process-only candidate and a general one, so a fallback that
+	 * is merely shared with ourselves outranks one shared with another
+	 * process.
+	 */
+	for (eng = 0; eng < num_engines; eng++) {
+		uint32_t eng_busy, eng_own;
+
+		if (eng == requested_engine)
+			continue;
+
+		eng_busy = sdma_engine_busy_slots(bitmap, num_engines, num_queues, eng);
+		if (eng_busy == 0)
+			return eng;
+		if (eng_busy >= slots_per_engine)
+			continue;
+
+		if (fallback_any_eng < 0)
+			fallback_any_eng = eng;
+
+		if (fallback_own_eng < 0) {
+			eng_own = sdma_engine_own_slots(qpd, num_engines, is_xgmi, eng);
+			if (eng_own >= eng_busy)
+				fallback_own_eng = eng;
+		}
+	}
+
+	if (fallback_own_eng >= 0)
+		return (uint32_t)fallback_own_eng;
+
+	if (requested_has_room)
+		return requested_engine;
+
+	return fallback_any_eng >= 0 ? (uint32_t)fallback_any_eng : requested_engine;
+}
+
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
-				struct queue *q, const uint32_t *restore_sdma_id)
+				struct queue *q, struct qcm_process_device *qpd,
+				const uint32_t *restore_sdma_id)
 {
 	struct device *dev = dqm->dev->adev->dev;
 	int bit;
@@ -1995,7 +2113,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			kfd_get_num_xgmi_sdma_engines(dqm->dev);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
 		int i, num_queues, num_engines, eng_offset = 0, start_engine;
+		uint32_t requested_engine;
 		bool free_bit_found = false, is_xgmi = false;
+		unsigned long *engine_bitmap;
 
 		if (q->properties.sdma_engine_id < kfd_get_num_sdma_engines(dqm->dev)) {
 			num_queues = get_num_sdma_queues(dqm);
@@ -2008,16 +2128,29 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			q->properties.type = KFD_QUEUE_TYPE_SDMA_XGMI;
 			is_xgmi = true;
 		}
+		engine_bitmap = is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap;
+
+		/*
+		 * Treat the caller's engine id as a preference, not a mandate:
+		 * redirect onto an idle sibling engine if the requested one is
+		 * already shared by another queue. See pick_sdma_engine().
+		 */
+		requested_engine = q->properties.sdma_engine_id - eng_offset;
+		start_engine = pick_sdma_engine(qpd, engine_bitmap, num_engines, num_queues,
+						is_xgmi, requested_engine);
+		if (start_engine != requested_engine)
+			pr_debug("SDMA engine %u busy, redirecting queue to idle engine %u\n",
+				 requested_engine + eng_offset, start_engine + eng_offset);
 
 		/* Scan available bit based on target engine ID. */
-		start_engine = q->properties.sdma_engine_id - eng_offset;
 		for (i = start_engine; i < num_queues; i += num_engines) {
 
-			if (!test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap))
+			if (!test_bit(i, engine_bitmap))
 				continue;
 
-			clear_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap);
+			clear_bit(i, engine_bitmap);
 			q->sdma_id = i;
+			q->properties.sdma_engine_id = start_engine + eng_offset;
 			q->properties.sdma_queue_id = q->sdma_id / num_engines;
 			free_bit_found = true;
 			break;
@@ -2392,7 +2525,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI ||
 		q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
 		dqm_lock(dqm);
-		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
+		retval = allocate_sdma_queue(dqm, q, qpd, qd ? &qd->sdma_id : NULL);
 		dqm_unlock(dqm);
 		if (retval)
 			goto out;
-- 
2.43.0

