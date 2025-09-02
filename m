Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DC6CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A85210E5D0;
	Tue,  2 Sep 2025 08:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1xhU+w2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCCF10E5D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lr00TjKHNDeL4OTJNof+BH5HRKKnBFJiv0KTom7ivJTms58dminxkp68sAfSGWlncplh5eopYipW5VfnTulLpnBAk3WlYmZKqyiFFjjJIXnIcjaW3sKaKMjGPqhW5CVTXSrG912RotdNhvQlX8yaYVr3GvTMahRc3VPChAWkAb0JqrjBlopRXdOOfGqQSu8YGjHBtaGp+ylKVh7sSpAbp4rJPbIDNFm4B4wUIGlaF5IVYNtEq7gezJITlOL/hEaWo+5JcMI8JT3p+9f0umfOEb1sjrM1bvsCFZytgwCyQPURa/nkPjrvi5L7VgdcNeQMEPVq135tiYkw0IF1+puzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDCsgO88w8vhCDdOChsh+IL/sqWlCjLhr7htZdAdU+Q=;
 b=V4auHQc4RoZC1DlVBWAlUBtXkDR0I8C5s/CRLToD5lg9fqb7dyyVEVssuXIvFPLs4nlicwPu/88XUJjM46o6u1xlx2cmOVcz2icTw6Nx2+tuLgKl6RhGxxPVl38+qj9W2EbuUlo7HXJVTse/g2aVeHml+VZ2E93zTwWzqRN2OicwsyLx4I7wxtAas0dhJ+kAR30EermEx4nJ9zMtObz66IHiIElkSYGZTKTV5qDxd/9YYLzsVtwi2rI/0JusyYo3peoWC1No46CJqdVJ9tUfN0uPkS0qah8V4U/G/0vMm0x5+WEe70uPX5BjFFb5HVggavDuCOtw7nQmujlxr3ICrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDCsgO88w8vhCDdOChsh+IL/sqWlCjLhr7htZdAdU+Q=;
 b=g1xhU+w29vbcFp73mvXyZoR1xj8qv+ij5w8KafOatQ6iD2s0c0LO1hYQFl9PC2zFp8+X+6lZ1NDI5ht+qsZVMypub7oF46JGOdeAaABDrDJio78BtSsSN8AS28jAKi0lU9CeqiaKzSbDxwZ9LS/SVtiHfxI3Tb2Rt+zwm6wnA2w=
Received: from MN2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:208:e8::36)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:08:22 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::bc) by MN2PR20CA0023.outlook.office365.com
 (2603:10b6:208:e8::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.28 via Frontend Transport; Tue,
 2 Sep 2025 08:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:08:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:08:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:08:21 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 2 Sep 2025 03:08:14 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v13 10/11] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Tue, 2 Sep 2025 16:04:11 +0800
Message-ID: <20250902080712.2515811-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a46cd1d-8af1-48ad-bd47-08dde9f7e273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rOIzyAsjrolciG/YKh4PnYmIm4tmho7r7K0+cBn/J/FIVOg+T9VSaJkZxLtS?=
 =?us-ascii?Q?WHBYZFotZvqNwwZh9VzvJk1tW7KKmIX6g3MsJDDBgAa8sGpnhvKH5WZ66Iwf?=
 =?us-ascii?Q?AFpvxl3b+cBCMwF9iGG9Gk0QrSkR3tATwjtDb5bKzIPLOp6WSRkZu4UfYO+9?=
 =?us-ascii?Q?FU0uyn9TC4786PgApOL4E+547yDBDKQguCv5J6mIRoM0AJCJO7icZu5t/rmJ?=
 =?us-ascii?Q?rCAEEMGkvtjyivmS8L389dmcKMlCfODvMg3W7ftEuBtZizbex/HQ8PobSgEZ?=
 =?us-ascii?Q?B1VkvPoPtn8qTdcdmXicOHWbr9dPyQRP8nN3VwMmexWAsGeykAbIdZXX5sGV?=
 =?us-ascii?Q?D5KcPmXyjd3s2A7PR+cXgF2gsU0as53lTiDKiGqGDOgIu1MwkeGIUVPdRl2U?=
 =?us-ascii?Q?Q1zwixrXC9afeNI5SZzodnL6NpZeVw//+FecjaCTpfwPpLSpT7E/WiuHHSTk?=
 =?us-ascii?Q?o97F6d7RZJiJcEpW4qLRz4YRZVZoOXLv54tobsgtQxScfuUQQesjXnzEh0Pp?=
 =?us-ascii?Q?hZOJGV7tXKCTjhGA5l7p6hDFtlYkCtH5iDLDN7nR8LZhiS+2jPJ68pSI+HIT?=
 =?us-ascii?Q?ymQIvWU4hAEpbbkjiNAmSFTWB3UoP8eHM009oISMR7SsUNnLnCIu+UHKiX3O?=
 =?us-ascii?Q?LqelCWamh4Is37w+XyWFC9IvG0IoNFUJx/gxJOzub/9RUGp3H3r4oyVu9unm?=
 =?us-ascii?Q?sKLd+NOg+45TuZcJiL54u8BlDUrUblqUKk5SgocWB49l5HAfV+p9jiXDbhU6?=
 =?us-ascii?Q?p9faCFKaJOmt3rGvsgJ2HpGRUuAjyl0xfRnqAZCFq4LnE0CCc09J9SQcgFmm?=
 =?us-ascii?Q?8FFxLgiUTebm4M/ISM6i+Oy6r8nybXi3EXy8HMcAk38edymbhrflPaiqODox?=
 =?us-ascii?Q?+9d+ETXQngDTy0cMQ3MBCpZeMpSBFLjxQnXEK1eMqdvAJWZ6mKeYaQq0Y9zE?=
 =?us-ascii?Q?Kx79qTcElLgzi1RGw2R4kZreaNiiB3UUHIYQcTI6Bd9UO8kgdNPhPu59q85I?=
 =?us-ascii?Q?zL0nTBaL9PheNDAuZMJCqomitHKfDjdnHg5bFxMLVxh8L0DlwIysZa+PnYpZ?=
 =?us-ascii?Q?KKme0aZpC4/8fiqF6yYkva7CQtaL09oaTPRBdgZmrfVK1R2wDjP5aDz3f7TK?=
 =?us-ascii?Q?hC4JPBGq6JBMMLRS7Fc0nfExQV0r2mbQhz/RyrPizwGaz4RNT7yHp2NOtqCy?=
 =?us-ascii?Q?CO426M1e61Jthz82GCjMOn6vBYSUnAQulZ9pHTjHDvbVlXqjAI0vzlbAt3Du?=
 =?us-ascii?Q?pwoQW6mXegs6N5RgH1mNe1ZJCKrZh/10HoOjOW3Ev6faNt3WgpAo69VWWafl?=
 =?us-ascii?Q?UbA00j0FJgVEcRvvCPP+Qi6qQcB/SA986PbVqeE35uIi+EQd+hlGKcZhMK6/?=
 =?us-ascii?Q?P/dsvunak3VPdejVEu9VIMhC4jYWiuy0IyKouFL+kh6UrnV7WIoDtd6i7DHZ?=
 =?us-ascii?Q?oKb/J0SdsPnXOXfQXsvxmF8PykAt8F7gyCpMZDTSN/5SxT+rYe2pEqiexKRW?=
 =?us-ascii?Q?bJjtmoQj6LKHvHYlKWszCXNex3Yh/URQWZku?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:22.1452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a46cd1d-8af1-48ad-bd47-08dde9f7e273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
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

This patch modifies the user queue management to use preempt/restore
operations instead of full map/unmap for queue eviction scenarios where
applicable. The changes include:

1. Introduces new helper functions:
   - amdgpu_userqueue_preempt_helper()
   - amdgpu_userqueue_restore_helper()

2. Updates queue state management to track PREEMPTED state

3. Modifies eviction handling to use preempt instead of unmap:
   - amdgpu_userq_evict_all() now uses preempt_helper
   - amdgpu_userq_restore_all() now uses restore_helper

The preempt/restore approach provides better performance during queue
eviction by avoiding the overhead of full queue teardown and setup.
Full map/unmap operations are still used for initial setup/teardown
and system suspend scenarios.

v2: rename amdgpu_userqueue_restore_helper/amdgpu_userqueue_preempt_helper to
amdgpu_userq_restore_helper/amdgpu_userq_preempt_helper for consistency. (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..54851ba8756a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -54,6 +54,49 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
+		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r)
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
@@ -536,7 +579,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userq_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.49.0

