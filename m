Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770A7C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 10:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CB110E206;
	Wed,  5 Aug 2026 10:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DhOnoyDE";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3311C10E206
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 10:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ3iVtOVGp1/7WLV0rE0Z8EMU0AqgognUKopKoT3brgTSIesLV0zDWkuFmsDx+KuaMQaoxXLPgGX7oCkrduyjxo6cUBvNq0ATSLPKT156vz1AySAqCTNpXfWuUbF6DvEoDKGydPvtJHPCVOtBtmV3yIh4DHV+Ie7if+hFxYIUIJ3CSOycPsbhfqPPnzrXLpzUgpwwBNOLdFbkP1sg3RmlIiR+JFaF3l0iT6jgxMVLTmtq012LO10sOsiiiCyNPp/uivJkoA/s0h30U3rVkLaq6BnKylSsaBjyc5YBZITFGDJ/NjMyAdEWW6KWWUY7FHT/ygViJRQ0iGkQFKXSq6SkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14RFgiW/x3RDtE5QN3Z8vSX9aFlc9vC9VTXQlLiHJlw=;
 b=ONgyoagiL61Fe/Yt34jmCSlNDRJwg5YA9ldkaKwsR/SwoXPgoQmQFsuJ+zPo3ov0p0rIm6U4Qln0S2dd3Zjhqkyfsnw1LdNHRmuRfWovWVxyxgDgJnlYGVGdBGnYL/s+8bLOlfXYeiudM0vCzTrXD6C0KZGcOuyvOKns6bxdFWRdBUMRwlYXlWblxbbqmQVhmLveghZEZjcAjBvr02jQNF4A2Vgl/8LKagFaMYrMJlJKeTLKRS02aFFRjdHPTJeQruMy9pSuXo5skG2Esp6pAPRMLYdEJchK2vveVYqU9+CqNpd/Bx3r6o9TdurGAxPfyBGyTQv9oHyyprXc0fULcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14RFgiW/x3RDtE5QN3Z8vSX9aFlc9vC9VTXQlLiHJlw=;
 b=DhOnoyDEcoYmf43YlmJoW0ou+/UK9b8YsLlQfrzwQOxROmu2ul4msWhhVRgM2xk6BWfUiMJXFzf97tTU2ra1/8rLSSgTWT7PIrj6zCcpiaOrLPQWC+8V5NUnyo5zvkP/vNkVBINV2VfPEwdtqdePZTeYGuRkgvpBiIJEVAgy09A=
Received: from SJ2P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::19)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 10:22:38 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:5db:cafe::ad) by SJ2P221CA0010.outlook.office365.com
 (2603:10b6:a03:5db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.20 via Frontend Transport; Wed, 5
 Aug 2026 10:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 10:22:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 05:22:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 05:22:37 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 05:22:36 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: keep PRT mappings off the vm_bo state lists
Date: Wed, 5 Aug 2026 18:22:12 +0800
Message-ID: <20260805102230.4060525-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: e043f619-6b96-46e8-5bc4-08def2db7997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: qyF/DLkvYFQzci7sWBAFwi35rhoy15JZ43+6f02KH467mzpK9Yic4HJvDx3BfendkN5lff523KBc1kIbxhQtvDwZUEopkPhXPedNDf0ReWhJYDHfnya9I7Jnb3Zao4MlSRzCVx1iDtSNfOjhLQlWDsA4Sxu5ELPXUSbK+K0VZFd3ccL+AF3Kfso7Tx9DY4UGIqo0TvLm6UR40QyaatY/Mib7cASgjcIsWBIehSVNtLpLD74qJ5uMcEA7ZdJbA4zrcddpmYwXpxv9vOsAqycg7+w7RD7NP3mNMBCEnuR4D4HRzDG4mP9Ed6JK578ASul4gvg11F/D6bcGvV708s8Rs9vLmcfOkb6FvuKijpmHERJjHVYxix+XMaioBSS9vf2F7BaeU8reu1IeHoLphr/re/HOsIVGvodMg6CrZVbVRLN1mQN2hXHyyg/TW5xrj+iVglpXw9QhKGWBDpsqbequptzulsFflvI4hOYYEZ2ibuNkMVpF0XxvyI0B7tgjBpjvmRCA2/8LlqjkCMlDN3KjVU8Y2jiUt3tkwkPr+qUXtVLp/6EDKpMyWJQQxhP2VZlfurk6AxUhnnBaxGji43b+bItZeFR+lEUELHB3Ac0O+iq15K+s25jQ6QRbNBJ5hvh/iLGUAoCR5PWgp4wd5OOjzVre19gq8PQevMDYuPWTlqKOKZUeiCT9lSHljt63Zz/zUJ9NWkIr4adhokd17zcnCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: akyUSdJD5Y9AiKD8imw6mZ7rcSN4nxqMNAgmqCzijmgoYmtpxj2WdOWmDL7bt1WC7tfQ80hHSAxcCKSvn3paKZ2Pnrnpd0O+QaYCdJ7tozAnn335OSTF3UOud7+4u0mSrsjtDttsqDuh8PjvXnVvaKbgdQozOow3ZTtp5Ow57ybyefcQwc9YbFCc6X/Mrg5vHW9QKLl5lshEiAxDn95V8ZZ+Yr7cnAw0Yqzgx/a6CIyovtQyXI5paFQ/ec+4tuJSL00DMq0H9VZH8ZtD4Wnp3lTpnhpW0/EoW11WNQrVTZBY3++sk1JH90+lR0xIZIVu5pJuU6YlyQEXSnMDYeaB23z+JyPtOwLDGr/BRAAEqvIKXzwFLC15FU2VHtyzFOI5nZBe0oK0JWTPUBU2PrDrBXolQF+qKAPNvazdZCxjG3kOJOXdj+GsxTQX3yFyHxfk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:22:38.3654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e043f619-6b96-46e8-5bc4-08def2db7997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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

A PRT/sparse mapping has no backing BO, so its bo_va->base.bo is NULL.
amdgpu_vm_bo_base_init() deliberately keeps such a bo_va off the vm_bo
state lists, but the tail of amdgpu_vm_bo_update() unconditionally called
amdgpu_vm_bo_idle() for the !always_valid case, putting the NULL-bo PRT
bo_va onto the individual.idle list.

On a GPU reset amdgpu_vm_bo_reset_state_machine() moves individual.idle
to individual.needs_update with moved=true, and amdgpu_vm_handle_moved()
then dereferences bo_va->base.bo to read its reservation object,
crashing on the NULL bo (e.g. the userq eviction restore worker running
during a reset while a user queue is torn down):

  BUG: kernel NULL pointer dereference, address: 0000000000000158
  RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
  Call Trace:
   amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
   amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]

Skip amdgpu_vm_bo_idle() when bo is NULL so a PRT mapping never lands on
a state list in the first place, and refresh the PRT page tables
explicitly in the userq restore path (as the CS path already does) so
sparse mappings survive a VRAM-lost reset. Because the PRT bo_va is off
the state lists, its PTE update fence lands in prt_va->last_pt_update
rather than vm->last_update, so wait on it explicitly before restarting
the queues (mirroring how the CS path syncs that fence).

v2:
 - keep the PRT bo_va off the vm_bo state lists instead of NULL-guarding
   bo inside amdgpu_vm_handle_moved(); a PRT mapping should never be on
   the moved list in the first place (Christian)

v3:
 - the PRT PTEs are updated separately, so their fence is in
   prt_va->last_pt_update, not vm->last_update; wait on it in the userq
   restore path before restarting queues, otherwise the queues could
   restart before the sparse PTEs are written (Christian)

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 +++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6d3ed55e9ab4..bcfbd7213dd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1070,6 +1070,16 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	/*
+	 * PRT/sparse mappings are kept off the vm_bo state lists, so
+	 * amdgpu_vm_handle_moved() does not touch them. Refresh their PTEs
+	 * explicitly here (as the CS path does) so sparse mappings survive a
+	 * VRAM-lost reset.
+	 */
+	ret = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+	if (ret)
+		goto unlock_all;
+
 	key = 0;
 	/* Validate User Ptr BOs */
 	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
@@ -1127,6 +1137,12 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	 */
 	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)
 		dma_fence_wait(bo_va->last_pt_update, false);
+	/*
+	 * The PRT bo_va is kept off the state lists, so its PTE update fence
+	 * lands in prt_va->last_pt_update rather than vm->last_update; wait on
+	 * it explicitly (as the CS path syncs it) before restarting queues.
+	 */
+	dma_fence_wait(fpriv->prt_va->last_pt_update, false);
 	dma_fence_wait(vm->last_update, false);
 
 	xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4c90e88e2e30..02e2e576f154 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1391,7 +1391,13 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 			amdgpu_vm_bo_evicted(&bo_va->base);
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);
-	} else {
+	} else if (bo) {
+		/*
+		 * A PRT/sparse mapping has no BO and is kept off the vm_bo
+		 * state lists (see amdgpu_vm_bo_base_init()); putting it on the
+		 * idle list here would let amdgpu_vm_handle_moved() dereference
+		 * the NULL bo after a reset.
+		 */
 		amdgpu_vm_bo_idle(&bo_va->base);
 	}
 
-- 
2.49.0

