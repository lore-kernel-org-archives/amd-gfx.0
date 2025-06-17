Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405C9C7115A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82C010E55B;
	Tue, 17 Jun 2025 08:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vpDg8nXt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0889110E54F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO0cQiHa9KCjqC4fP/gjpWy5ubEWiFo5FeqI0S41qQU5u+5i0Xuh4vrGQySuVepGd2nacUkCwyvXxyiGvOs8JNs7ANtIf32AFaUnw7WfS30MiQTNE0rjg0Gg3gQCoLejswgbFRtrm+NI6gMikFt6nSaWVcAforSOcsi1pCigMh3zaZCtlufbpzhwUgvaUh8mtpzxGbj2CCv2mM4bM3QkOiCG5R3SgE+LRkgboZ0wN/LdH8jmaT18S29u3xKg0Lvr/zH/oFjfimMAdyRxr4Jxr+FjP7HzgLKNwubX9/bl+5hD/A53Law9wcusgB47AE6oZCEfMQK6D3T7IBwTvy1NTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bncrbMNnt6NHswc5IQ4BHFzPa8a+fOuL9FiStHj0gM8=;
 b=h7Lfkp4UrJN00aVAs/yL2fcOAooi/pW7oXWQlb2xajVU+6f2bG4v3ooUgRvLxLvNztxjJ1Bx64YqtID8jQUayhrcFVq7WBDg6kC2IojrcKVxHLcPzs7EvXOPL1nrvcBoTz/cM8AUGwq+xNX5GgOJCpXxNwvDYDO7sOHAq7fhkd8QcPIn/DBl861xxS+GjV5i5ETFOu9xSW5HuGCm7Kh2QKEZGHL1eZylH9p+GWs+0IfLi7G8eG75mzEZHncFq/uySaXNDq65xneUOtCtAhFQoppJbk4dcc4lOsspkeYxyifRO+V29btebzGxUGDqZuaWbauWDGvPUOEouwjjETNKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bncrbMNnt6NHswc5IQ4BHFzPa8a+fOuL9FiStHj0gM8=;
 b=vpDg8nXt/B+nB6E4t7l2G6/7OlQXecIuDQJJ9VyYhxJCtnZ9JcquaGCj/apGp5KrAanv2qV0MaU1jxEbdHu0/KkI4Lib1cnDrRcJXcW48MhIrH5yggRR7EyySKbVBYkpeX7Tprb+XyOkDeATQa6BtWsCHzgWwy1hMMRIZiZs3J8=
Received: from BYAPR11CA0038.namprd11.prod.outlook.com (2603:10b6:a03:80::15)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 17 Jun
 2025 08:02:24 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::e1) by BYAPR11CA0038.outlook.office365.com
 (2603:10b6:a03:80::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Tue,
 17 Jun 2025 08:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:23 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:22 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 08/11] drm/amdgpu: add userq va unmap validated helper
Date: Tue, 17 Jun 2025 16:01:48 +0800
Message-ID: <20250617080151.1093481-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0fe86c-a843-4b5e-f942-08ddad754b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/ijJqunKhPAt4Xao8Bet1Dt3Y5537ozv/eu6lQXxuLl3QZCJnQrwbQhLZCF?=
 =?us-ascii?Q?QAnlWddUpSB6nVtlHIjB5kkYdEqX8IxnF5EC9eKvEMXKYVLxawSN12dRc7aK?=
 =?us-ascii?Q?0uGaiJyRC/DuWB4Dlu73uNe7a5tdCi7m6JxyHRuxeFkrwrAku9ThFdRtSJ1j?=
 =?us-ascii?Q?4RPTZEnDLniMLGq25hqnvO8QJDjjFM/eKAqzAyojsPH1m1PMiJbnhOPbPkd7?=
 =?us-ascii?Q?+s1eydcDPNQUNDeSY6qqP5pdNvoyBi+pEJrIC3Q7Yj7PWFno8XCVDZyL6xZ2?=
 =?us-ascii?Q?AlTvI6OB1vxKmt3I0XwRIDOwtGYknyJ3ZosOIqVXpiDUTGSTgLdDSO1YdRli?=
 =?us-ascii?Q?g0nimSYTiGQ4G4ZxM0j4UUhVFhI4BhCVwWDhU0ivc30WqpiSXcbnJsGldohL?=
 =?us-ascii?Q?lSeulSQtLWw5Tbr2VaNkAaico6LghOeyPzPgFqFOid60TehtP6227LhuvHVf?=
 =?us-ascii?Q?/yjRQv5hcs0aK4Fe2ZEVBAeHL8JKZpX/fRSdG9EtqztCqGNPK4Rldq7ICbVk?=
 =?us-ascii?Q?sABL1icz/rgm0bXewXl5oPC9tpKbzSBZQ9TcCV4Sl0mjwlZRD2FdknHhXlpi?=
 =?us-ascii?Q?pnL2xUqlWhSuFHQNLw9QJeMFe3sFqOd1tgQM4CYvHOSXB79UkJIoKKnVjbiZ?=
 =?us-ascii?Q?lZTEhTma9CVVXKTn/QlJLCoQb1PTPwTTFnCsEod/h1yl4i+6xjYNTtqv62w9?=
 =?us-ascii?Q?mVed8OVz86PxZ9yALuo5oeTQFKLYtOFusn5ZVvRY2E+PubM4nVFX7LYAQaxo?=
 =?us-ascii?Q?7OYYqsX4EacuPLW9YfqjadadvrAoQH8zAWl0Of7OX3b8+WYgAm4VMGZgDksa?=
 =?us-ascii?Q?Z1dizLzjq6jtqwR2S7BTD8oEJI7gIcvSoXZBOldcvyYnMRNtpTOMmqIoLsLV?=
 =?us-ascii?Q?ImIQyD5qC2uTcfUFmaXTjcc5DlWIihXgJGdBime3cMY/kw87TQ4zrv9AXFJ+?=
 =?us-ascii?Q?DMfW5/K0meTcExtmw0qWLHbUraZgwJtUc3u9JLgi8tMZdQcTc+k1a146/FfL?=
 =?us-ascii?Q?kI8mpjmcbt2ZXPmSnszhW7dxWnXVO5a6BuzMkSdPVgkpzyRQUuBmx2/sqO0a?=
 =?us-ascii?Q?tpzSzrC+Q6c/nAiMSuG/QA3PUoHRSAg/EOG3OZDR4LvaHhXr3xIWrsb+oF78?=
 =?us-ascii?Q?0p8hsIxT5mU6zwzFjTb4FCmAnlMbjk0lgVPryJwIW0rA2gE+4mp8mjJL94nN?=
 =?us-ascii?Q?7CZxnS3iThzbSDWoXlsv8QJNaaoG8CSp/x0xP/2Mfb+qHDH2fR7KOjeiWa78?=
 =?us-ascii?Q?ydnnawQiaBorKqGxP4jkCuo3dAM7ibnUoKPb9b9koEc637agjFNTDSLQSCao?=
 =?us-ascii?Q?pB+fhhnZQ7miHyW4SZ1HtDJkXKM7WrmD85TDFS5ZSvrfi/vGLbFhSt/iAMdJ?=
 =?us-ascii?Q?JfdZzxKUJjFGOWbsiFio+fUPym12qO3xcP3jPgsMbALZdANfyWXg6gy/tpsr?=
 =?us-ascii?Q?l3PwEwCo5NbedTgVLtXIbkkMGdL2XfdPXwMAcgwoPJZm8A9sOHNhCx7AFsyn?=
 =?us-ascii?Q?wQvNJo+FZ9OOg4SaViuvZFdiW91oASjQ6Dxa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:23.9421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0fe86c-a843-4b5e-f942-08ddad754b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

This helper can validate the userq whether can be
unmapped prior to the userq VA GEM unmap.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 55 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4b00d9b16046..f04b51ded06f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1135,3 +1135,58 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct amdgpu_usermode_queue *queue,
+							uint64_t va)
+{
+	/*TODO: validate the user vas of EOP, shadow buffer, CSA buffer*/
+	if (amdgpu_userq_va_align(queue->queue_va) != va &&
+			amdgpu_userq_va_align(queue->wptr_va) != va &&
+			amdgpu_userq_va_align(queue->rptr_va) != va)
+		return false;
+
+	return true;
+}
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
+				uint64_t va)
+{
+	struct amdgpu_fpriv *fpriv = vm_to_fpriv(vm);
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+
+	if (vm->is_userq_context && &fpriv->vm == vm) {
+		struct amdgpu_usermode_queue *queue;
+		int queue_id, r = 0;
+
+		if (mutex_trylock(&uq_mgr->userq_mutex)) {
+			/* If here the userq bo is busy and needs to deactivate and prevent reusing it.*/
+			idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+				struct dma_fence *f = queue->last_fence;
+
+
+				if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, va)) {
+					dev_dbg(uq_mgr->adev->dev, "queue(id:%d) not belond to vm:%p\n",
+						queue_id,vm);
+					continue;
+				}
+
+				if (f && !dma_fence_is_signaled(f)) {
+
+					dev_warn(uq_mgr->adev->dev, "try to unmap the busy queue(id:%d):%p under vm:%p\n",
+						queue_id, queue, vm);
+					/* Need to set a resonable state for avoiding reusing this queue*/
+					queue->state = AMDGPU_USERQ_STATE_HUNG;
+					r++;
+				}
+			}
+			mutex_unlock(&uq_mgr->userq_mutex);
+			return r;
+		} else {
+			/* do we need a try lock again before return*/
+			return -EBUSY;
+		}
+
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 9543fbab7cc3..7e532ca0ba05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -31,6 +31,7 @@
 #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define vm_to_fpriv(v)  container_of(v, struct amdgpu_fpriv, vm)
 
 enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
@@ -145,4 +146,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
+				uint64_t va);
 #endif
-- 
2.34.1

