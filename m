Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CDFC2BA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 07:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3050510E222;
	Tue, 18 Jun 2024 07:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EGEsuMe0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B6C10E5B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 07:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+gqYkwWK9Z1Y28wGwrtWxbE9K6rJXrEif6IQzWY/SbG4yLpoJSExQzmiZzifjWSmB+Eg70SXPSBw/vt5lSDrrLcYlC8xnH85Sg7/uaQ19weyurFgrV8XX5UFaQD/j8d2mLl0zZxtbJGeg9XhodNNey0lJWd+mhk8Rnv4evmouefzMew2RGA4XG+vwGWW+/CQWbpRukAW9yevdezsh2nr+7/s8h8WbXeF/6lOYJxyS0kEidBIH1M96lEQdjDZVbfRL4FCqzYCb1YSL/NkXfAFyBBbzArgIRNNl2IiNcZML35FLrQxgoMEMXlWAOUI8K8SSvH+Ba2vFQ21w8rv7xAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD3EMdJPYLypOx3mHXltLl58TAG7QUenZgSmptYxlSE=;
 b=lVmGC+rA3b7/jb1TKMveKGkZQYMjhYY0z3Wdw8WFWcG+K1bE2Qq9XBkH3rIds4s/xOvxPOhho1FOutYG2mRLHiD6Bb2y8YTs9f66R1zVnvGYU3sZ/933bUpWbdyjr+Ckvw+UkWZDOOeDrbJcRWbQlVt6NXoqNO2AnfuHs74uOLTVCXXC0EwsvizY9hQJ+cuh5nd5b1MV2hlYsHC6RFozwcaeCkkaNrUj0ABpj6/NE/vRbsJuKCSYCnc/i3nHYdb1Dy1QPPZOnT8r7riWa6yoe1ZBot+8E3nTuYgD41tpie311o3a1CrJ+5nCEL2lm/xplH85KD1vHqmhkkaBlocFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD3EMdJPYLypOx3mHXltLl58TAG7QUenZgSmptYxlSE=;
 b=EGEsuMe0GIlzO2bEwTHLSqxQZiXX0KWUqYV0L/lSEJp7lw+mVr4N3D8p0mJ6RwBM99Asns0pyIYciGp8aD5jmVwv95nDwzC1NCfnkImVi9vTMowPWyytNhkBB9pFuLggV35pzpV7r/qaD+ZgaNgrGNkH5DJDN8i6R58x0aVrmsw=
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 07:48:51 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::93) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 07:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 07:48:50 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 02:48:47 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipechai@amd.com>
Subject: [PATCH 2/2] Revert "drm/amdgpu: change aca bank error lock type to
 spinlock"
Date: Tue, 18 Jun 2024 15:48:35 +0800
Message-ID: <20240618074835.1439008-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618074835.1439008-1-kevinyang.wang@amd.com>
References: <20240618074835.1439008-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbbdfa6-f54e-4557-0bf0-08dc8f6b17f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QJuUsZCPUxe873tfqoFgKoCw3KInPQ59YDa2NHu1AuvEc5ZBKaa1UOJwuIzt?=
 =?us-ascii?Q?rH4iegqAwuxhHNzBqi1gazZEMlgXPtS1R7+qiNJhoqwCSRb7sIB8pxlD/46U?=
 =?us-ascii?Q?iLKcK+X5BZiiDkdP63EN9/S/Ti88a2C7bp6UCRhwTLyIBL0P2EF9zbEM969I?=
 =?us-ascii?Q?bqUytejyC7HHkG+hsRon5B7UyTYqIc466zNcCY2lIFI3JoF7mjBcWEyFPuGV?=
 =?us-ascii?Q?fvcYCv+m7kdK6+aD7diOQpSXQO594x2M+cJeHijwrPvWOnK4jyRr3wQnT9Fv?=
 =?us-ascii?Q?5hlybUO6tX0gkPuxZdP2gtFdR/yl263tYz1f0eAeRy58qmLGKIfYhLdgAY5M?=
 =?us-ascii?Q?FQOayfXlFkyHpZUODZQ+VQdPwp1JfrdCFQCfqc0Pbdiljnaf3UVjsPYmANId?=
 =?us-ascii?Q?GW5oVM/LNrSOtYuLjTJ/TntrFWA6rt2+prVpCuO7qrZD2qR3IgNlrwm878Uf?=
 =?us-ascii?Q?OiMBiSyLjn7OOs7TxSSRJlqv7P40R5Ro2qdocKFLTAZEDO3dDkCdgi3BC1GD?=
 =?us-ascii?Q?Ewf6sVSPFRC4kE01qgFrlK9w4GqvasEhIm9qT7E8qBl6PTcTu+azwXjobpv2?=
 =?us-ascii?Q?qB6L8xui7+da1cA7BygKTtyziEPv2+5w3WZKhJS2u9afh9Rud07/VvQhQuW8?=
 =?us-ascii?Q?Jgtr7pjsq08dowbdIgNp/O2IzWkrbi7v/roKHT3gqGbvOVh7QSYdIQuKSQzF?=
 =?us-ascii?Q?fuyznuvEPU0FZ9YaMEMOYkH21f/kK+oSEj7W9STYL9165Ujz6/I3CQ12E1fw?=
 =?us-ascii?Q?6FL0tojzkUpxxEksECmhSylp8V6KhhEiq+BTfAhA5gzdctz1AM99RRm9aYNx?=
 =?us-ascii?Q?UqRMRLccJvm62jW1JCTJXS3M7Xwij5znpy4xhVV2KGcDillLif5zwFUcq6Uv?=
 =?us-ascii?Q?ApucNmXgQ6+L+BAqtkKfh/GuqyAkMDTSN2+TRSWinHW7vNHm8ON0VzMsQ8y+?=
 =?us-ascii?Q?yB6Oe0PiZVbGXax1bnqZGK6s4nVC+7v9j0vOIkYTGSP9XDbJihlzBLqa9VNV?=
 =?us-ascii?Q?N/BHFQlbxsPcN4nM6x/jlgHicrqhYVuIBWlviyeM9butQo5i5jyRmgU7lgjm?=
 =?us-ascii?Q?wtKplQU0NeCRJOcW0P0c+gL9We6uZySvb0hS4lGDfJq7lgvWLTUEvyb/QEQi?=
 =?us-ascii?Q?fmxSeOcWHKc3p5+qD4Hg+WQIUxQH7kiJ4Cebn+ksFmDX3KuBfj+m9EcLnn9h?=
 =?us-ascii?Q?94BtylM1n5KfWJ9AHxFz3iv4WJD0OiCU+rSsb3H1+uJwzOk1GqfRrTVyfqYa?=
 =?us-ascii?Q?SBSQPdQzgPVh7RTfUMfmsVYH1mhAhSV2DWJaBrL2TK72nd+l853mWvc894hQ?=
 =?us-ascii?Q?goCZV9pwER0q3EGFQSWE6TrUaeaSf042XNgKaF1Ab5UyFRyhmi9++w3ZI1Hf?=
 =?us-ascii?Q?lawHhGmjn55MU28QbJyK4ew4ee3gnYrt3D86WC8dWEoqbHbPFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:48:50.4519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbbdfa6-f54e-4557-0bf0-08dc8f6b17f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

This reverts commit 354436e7905d166011f2aa26dccd9fa04b20940e.

Revert this patch to modify lock type back to 'mutex' to avoid kernel
calltrace issue.

[  602.668806] Workqueue: amdgpu-reset-dev amdgpu_ras_do_recovery [amdgpu]
[  602.668939] Call Trace:
[  602.668940]  <TASK>
[  602.668941]  dump_stack_lvl+0x4c/0x70
[  602.668945]  dump_stack+0x14/0x20
[  602.668946]  __schedule_bug+0x5a/0x70
[  602.668950]  __schedule+0x940/0xb30
[  602.668952]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.668955]  ? hrtimer_reprogram+0x77/0xb0
[  602.668957]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.668959]  ? hrtimer_start_range_ns+0x126/0x370
[  602.668961]  schedule+0x39/0xe0
[  602.668962]  schedule_hrtimeout_range_clock+0xb1/0x140
[  602.668964]  ? __pfx_hrtimer_wakeup+0x10/0x10
[  602.668966]  schedule_hrtimeout_range+0x17/0x20
[  602.668967]  usleep_range_state+0x69/0x90
[  602.668970]  psp_cmd_submit_buf+0x132/0x570 [amdgpu]
[  602.669066]  psp_ras_invoke+0x75/0x1a0 [amdgpu]
[  602.669156]  psp_ras_query_address+0x9c/0x120 [amdgpu]
[  602.669245]  umc_v12_0_update_ecc_status+0x16d/0x520 [amdgpu]
[  602.669337]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669339]  ? stack_depot_save+0x12/0x20
[  602.669342]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669343]  ? set_track_prepare+0x52/0x70
[  602.669346]  ? kmemleak_alloc+0x4f/0x90
[  602.669348]  ? __kmalloc_node+0x34b/0x450
[  602.669352]  amdgpu_umc_update_ecc_status+0x23/0x40 [amdgpu]
[  602.669438]  mca_umc_mca_get_err_count+0x85/0xc0 [amdgpu]
[  602.669554]  mca_smu_parse_mca_error_count+0x120/0x1d0 [amdgpu]
[  602.669655]  amdgpu_mca_dispatch_mca_set.part.0+0x141/0x250 [amdgpu]
[  602.669743]  ? kmemleak_free+0x36/0x60
[  602.669745]  ? kvfree+0x32/0x40
[  602.669747]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669749]  ? kfree+0x15d/0x2a0
[  602.669752]  amdgpu_mca_smu_log_ras_error+0x1f6/0x210 [amdgpu]
[  602.669839]  amdgpu_ras_query_error_status_helper+0x2ad/0x390 [amdgpu]
[  602.669924]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.669925]  ? __call_rcu_common.constprop.0+0xa6/0x2b0
[  602.669929]  amdgpu_ras_query_error_status+0xf3/0x620 [amdgpu]
[  602.670014]  ? srso_alias_return_thunk+0x5/0xfbef5
[  602.670017]  amdgpu_ras_log_on_err_counter+0xe1/0x170 [amdgpu]
[  602.670103]  amdgpu_ras_do_recovery+0xd2/0x2c0 [amdgpu]
[  602.670187]  ? srso_alias_return_thunk+0x5/0

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 19 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  3 +--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 04515c1c7241..7945173321a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -222,9 +222,9 @@ static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_
 	INIT_LIST_HEAD(&bank_error->node);
 	memcpy(&bank_error->info, info, sizeof(*info));
 
-	spin_lock(&aerr->lock);
+	mutex_lock(&aerr->lock);
 	list_add_tail(&bank_error->node, &aerr->list);
-	spin_unlock(&aerr->lock);
+	mutex_unlock(&aerr->lock);
 
 	return bank_error;
 }
@@ -235,7 +235,7 @@ static struct aca_bank_error *find_bank_error(struct aca_error *aerr, struct aca
 	struct aca_bank_info *tmp_info;
 	bool found = false;
 
-	spin_lock(&aerr->lock);
+	mutex_lock(&aerr->lock);
 	list_for_each_entry(bank_error, &aerr->list, node) {
 		tmp_info = &bank_error->info;
 		if (tmp_info->socket_id == info->socket_id &&
@@ -246,7 +246,7 @@ static struct aca_bank_error *find_bank_error(struct aca_error *aerr, struct aca
 	}
 
 out_unlock:
-	spin_unlock(&aerr->lock);
+	mutex_unlock(&aerr->lock);
 
 	return found ? bank_error : NULL;
 }
@@ -474,7 +474,7 @@ static int aca_log_aca_error(struct aca_handle *handle, enum aca_error_type type
 	struct aca_error *aerr = &error_cache->errors[type];
 	struct aca_bank_error *bank_error, *tmp;
 
-	spin_lock(&aerr->lock);
+	mutex_lock(&aerr->lock);
 
 	if (list_empty(&aerr->list))
 		goto out_unlock;
@@ -485,7 +485,7 @@ static int aca_log_aca_error(struct aca_handle *handle, enum aca_error_type type
 	}
 
 out_unlock:
-	spin_unlock(&aerr->lock);
+	mutex_unlock(&aerr->lock);
 
 	return 0;
 }
@@ -542,7 +542,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 
 static void aca_error_init(struct aca_error *aerr, enum aca_error_type type)
 {
-	spin_lock_init(&aerr->lock);
+	mutex_init(&aerr->lock);
 	INIT_LIST_HEAD(&aerr->list);
 	aerr->type = type;
 	aerr->nr_errors = 0;
@@ -561,10 +561,11 @@ static void aca_error_fini(struct aca_error *aerr)
 {
 	struct aca_bank_error *bank_error, *tmp;
 
-	spin_lock(&aerr->lock);
+	mutex_lock(&aerr->lock);
 	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
 		aca_bank_error_remove(aerr, bank_error);
-	spin_unlock(&aerr->lock);
+
+	mutex_destroy(&aerr->lock);
 }
 
 static void aca_fini_error_cache(struct aca_handle *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index ba724c2a997d..5ef6b745f222 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -25,7 +25,6 @@
 #define __AMDGPU_ACA_H__
 
 #include <linux/list.h>
-#include <linux/spinlock.h>
 
 struct ras_err_data;
 struct ras_query_context;
@@ -134,7 +133,7 @@ struct aca_bank_error {
 
 struct aca_error {
 	struct list_head list;
-	spinlock_t lock;
+	struct mutex lock;
 	enum aca_error_type type;
 	int nr_errors;
 };
-- 
2.34.1

