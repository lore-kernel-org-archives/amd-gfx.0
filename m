Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94345606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zeaiACgt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF091121C4;
	Thu, 19 Nov 2026 09:06:18 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842751121C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 09:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHVuFXcAtZoJpQffkolP25uouYA1jx5nmRqpfe3nNKjoORUE7BNoc45em43wDBLW0ChsR//nzaip/jZBDnWSAjeV0+H/2NDxDgoacVuLZW0LjSwRbbvDLPniNsQizY2CN3OCyZnSiQ+78qUWwCTy8vI4edTHiYgB2JuBs442iThtRt3AqzUg9t8rga/3v/0ru5nxlGR8gRzV893eFlhBZL+vh5Fc7iG2u3fe3rZxdyEmxe/385HWe1DW8gI8qxmUTGWGZ6hMFSzzPeSd+kvj2yMdtmUzb2ygAzyMbrRbt000mI+qr3hFLTjxty2qIKyIPro+JnfV79vst7GK1hsyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th44C5M30LuoeAUK5vJjcFairEocne9teGNC3Ep8zmQ=;
 b=mKV+dggB/oGfKcoKhwGnbTJBzd5OemGabRCWqf1RsZra1BNl8gCwJLGbrhjf0D04zNSulTtO82tsMC3pRuuCiGSxD/2bcIkxwAPU/uP+sedXjg6dMM11ifYxz66jA3zq+dHROqFLlQzO7OuQFTWYUj41tCA44MvCVgLPNVwoXbOe/4HeEQWK99/S/sQLytE1Tgs+6jqa3Xw4rbYJJHUiYvUdrXDIw1He+AtYcKLtTlrC+GMGnSjQ0odB4SVJO8y8hzDedMUmXWo1vVxrNaIj7UhyHaDN957nmge7vzNV9x/E69LXGRoppCQW9cgSRF90q8DhpbzK9DyZtg9ZK8dSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th44C5M30LuoeAUK5vJjcFairEocne9teGNC3Ep8zmQ=;
 b=zeaiACgt71PJCHm4qyj3rlNKwyyG/03RCIx/BdaxbtkoexhyaJ+MSEBgPXiC9w361LNn4NGHB6DDtfA3yWKAu1NqfnP7xS7MpWeZv82evkUICft5480yC/VCdBHfS0gnHh7GDnr5JeMyQvayJ9Ip5mU8MYKjUS7Rr0JB02ujxVA=
Received: from CH0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:610:cc::7)
 by PH6PR12MB503762.namprd12.prod.outlook.com (2603:10b6:510:3de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 09:06:05 +0000
Received: from CH3PEPF00024580.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::9d) by CH0PR03CA0062.outlook.office365.com
 (2603:10b6:610:cc::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 09:06:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00024580.mail.protection.outlook.com (10.167.252.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 09:06:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:06:04 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:06:04 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:05:57 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Jonathan.Kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [v2 1/3] drm/amdkfd: leave the devices a process has no VM on out of
 debugging
Date: Thu, 19 Nov 2026 17:04:53 +0800
Message-ID: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00024580:EE_|PH6PR12MB503762:EE_
X-MS-Office365-Filtering-Correlation-Id: da1f16a3-ed52-4b9b-d033-08df461c578e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|261102123227099003|10067099003|261026121527099003|5023799004|11063799006|56012099006|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261028144727099003|261009223027099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Y8xvj3IzgH1da7tGiTTTcwOX+pWTjEylJ60T1okwYcmr7UbprbFxLIoLH3m7I8hw2ZsYXXUTliRuzbWj4qemzJCOVReq5QgBuRZkDfCh8ivveQnfFjh4KGbPNxQSsBiNyI9BdA9SsmBtvngQ2zFoqv+vxbtAFJaUImOeWIkHl9IC4DxXqbb0AfDQMVc3dVHLwm0mTxWLDrB7ZTv5aydRU56mA8LYJJg8uXVPJbyXkzM3NBypJFi0jVIXUzRnoSyQ1uSHF+m7O6ndwrq3GGbvsDFSLocemUiGps/J1os/iAveD113dBUpzGr2p8BsJPR+iDelxoyUXNMIjTfQCP5ZyR0/+vBYOeztOkoUvkH29YE9ld+1QX4jVtHAd2zDF92CYoBGLp0VKFpaVvj7LGJ6n/Qo1yUdlEbyrq/kNk5dcsPcw7fltObOvZfp2+bLa+HqcE+swuiY5oVRWa6bZAO0ba+SYiNvhs8AN/BsgCZ5XRp6eFjetXwfyXpgS/YRRgd/9GM6Dufj1jczaqE6xlaEi15lQg8yZ5T2B7YbVnS5XMJK3MTVxw9BEwtCSylW9YBmPCH+hllumwKdpsN2XAGR9dUfIwH0Dy9keHMAI1noq3P/Fi7CYjPERenyzIeZjhzfhz70KfWKJVyenyNTm0whyROhP5Bg3gUpAYeH/OTE1uz/95l+GsXkD3dI/aEGPRej+SiUYOIGgpzhsk36WDrBUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(261102123227099003)(10067099003)(261026121527099003)(5023799004)(11063799006)(56012099006)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261028144727099003)(261009223027099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ykpgT3JU5giTJ1CfgLYiPSmz1uepH2g+vlWZdstJOC9cGDavg7OuBMvrov7LoqYIj42p7lgUtr0fdZ6l0KYUzVLJFuKnYA9Bvtcd3OuiVqOy3TyT8HpZYL6dwlnLeeNN3MK0ZAgz8dJOojJkQtqqdBBiZU7yXTkct+ev4DzRRYb54nu3w/JOIjs4E2P5MMk4GYTvt2+/lrCqst+WgWvt5CrKq1dZXdId9kGIokoN73/BqidbLps6KcsyvDhSS0TiFDYFjLgWWcBDKNh60R8znRnI5+4o+cKAjBBvi5x7J2GxnJJ7lU+F7ArFqbP45tSgGrCAmgA4LIpxY76RXQkN3nCj35KV1bD2TB8T9U5gr/n9nUm2JJnN1Czb8IBQXpsqqqvEP6lAn0tgBoyf0+TnVXuQwJAu/QJmLtAIc9kw2cnxIdKoxZJ0b/fneB4ysaVY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:06:05.1586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1f16a3-ed52-4b9b-d033-08df461c578e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00024580.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB503762
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

Debug activation and the debug operations go through all devices of the
process, also the ones it never acquired a VM on. With a dGPU and an
iGPU without per VMID debugging, debugging a process that only uses the
dGPU still takes the single debug VMID of the iGPU, so a second debugger
fails:

  amdgpu 0000:05:00.0: Trap debug id already reserved

and a trap override the iGPU doesn't support fails with -EACCES.

A process isn't expected to use a device it hasn't acquired by the time
its runtime is enabled. Only activate debugging on the devices with a VM
and track it in debug_active, set once the debug VMID is reserved so the
unwind also undoes the device that failed. Deactivation and the debug
operations only go over those devices and address watches on other
devices fail with -ENODEV. A device the process still acquires later is
only debugged from the next attach.

As kfd_dbg_trap_set_flags() now skips devices, rewind up to the last
updated device instead of using the number of updated devices as the
bound.

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 60 ++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +
 5 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3d2136adb62b..3d768511d002 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3039,7 +3039,7 @@ static int runtime_disable(struct kfd_process *p)
 
 	if (p->debug_trap_enabled) {
 		if (was_enabled)
-			kfd_dbg_trap_deactivate(p, false, 0);
+			kfd_dbg_trap_deactivate(p, false);
 
 		if (!p->is_runtime_retry)
 			kfd_dbg_ev_raise(KFD_EC_MASK(EC_PROCESS_RUNTIME),
@@ -3219,7 +3219,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 					args->clear_node_address_watch.gpu_id);
 
 		pdd = kfd_process_device_data_by_id(target, user_gpu_id);
-		if (user_gpu_id == -EINVAL || !pdd) {
+		if (user_gpu_id == -EINVAL || !pdd || !pdd->debug_active) {
 			r = -ENODEV;
 			goto unlock_out;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index d5c87de519ac..b2d01613a21c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -504,9 +504,13 @@ static void kfd_dbg_clear_process_address_watch(struct kfd_process *target)
 {
 	int i, j;
 
-	for (i = 0; i < target->n_pdds; i++)
+	for (i = 0; i < target->n_pdds; i++) {
+		if (!target->pdds[i]->debug_active)
+			continue;
+
 		for (j = 0; j < MAX_WATCH_ADDRESSES; j++)
 			kfd_dbg_trap_clear_dev_address_watch(target->pdds[i], j);
+	}
 }
 
 int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
@@ -517,8 +521,12 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 	for (i = 0; i < target->n_pdds; i++) {
 		uint32_t caps;
 		uint32_t caps2;
-		struct kfd_topology_device *topo_dev =
-			kfd_topology_device_by_id(target->pdds[i]->dev->id);
+		struct kfd_topology_device *topo_dev;
+
+		if (!target->pdds[i]->debug_active)
+			continue;
+
+		topo_dev = kfd_topology_device_by_id(target->pdds[i]->dev->id);
 		if (!topo_dev)
 			return -EINVAL;
 
@@ -549,7 +557,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
-		if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
+		if (!pdd->debug_active || !kfd_dbg_is_per_vmid_supported(pdd->dev))
 			continue;
 
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
@@ -562,7 +570,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 			break;
 		}
 
-		rewind_count++;
+		rewind_count = i + 1;
 	}
 
 	/* Rewind flags */
@@ -572,7 +580,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 		for (i = 0; i < rewind_count; i++) {
 			struct kfd_process_device *pdd = target->pdds[i];
 
-			if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
+			if (!pdd->debug_active ||
+			    !kfd_dbg_is_per_vmid_supported(pdd->dev))
 				continue;
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
@@ -588,12 +597,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 /* kfd_dbg_trap_deactivate:
  *	target: target process
  *	unwind: If this is unwinding a failed kfd_dbg_trap_enable()
- *	unwind_count:
- *		If unwind == true, how far down the pdd list we need
- *				to unwind
- *		else: ignored
  */
-void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count)
+void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind)
 {
 	int i;
 
@@ -614,12 +619,9 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
-		/* If this is an unwind, and we have unwound the required
-		 * enable calls on the pdd list, we need to stop now
-		 * otherwise we may mess up another debugger session.
-		 */
-		if (unwind && i == unwind_count)
-			break;
+		if (!pdd->debug_active)
+			continue;
+		pdd->debug_active = false;
 
 		kfd_process_set_trap_debug_flag(&pdd->qpd, false);
 
@@ -684,7 +686,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target, bool drain_irqs)
 	 * attached running target runtime state to enable for re-attach.
 	 */
 	if (target->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED)
-		kfd_dbg_trap_deactivate(target, false, 0);
+		kfd_dbg_trap_deactivate(target, false);
 	else if (target->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_DISABLED)
 		target->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
 
@@ -715,6 +717,9 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
+		if (!pdd->drm_priv)
+			continue;
+
 		if (!kfd_dbg_is_per_vmid_supported(pdd->dev)) {
 			r = reserve_debug_trap_vmid(pdd->dev->dqm, &pdd->qpd);
 
@@ -727,6 +732,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 			}
 		}
 
+		pdd->debug_active = true;
+
 		/* Disable GFX OFF to prevent garbage read/writes to debug registers.
 		 * If RLC restore of debug registers is not supported and runtime enable
 		 * hasn't done so already on ttmp setup request, restore the trap config registers.
@@ -775,7 +782,7 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 	/* Enabling debug failed, we need to disable on
 	 * all GPUs so the enable is all or nothing.
 	 */
-	kfd_dbg_trap_deactivate(target, true, i);
+	kfd_dbg_trap_deactivate(target, true);
 	return r;
 }
 
@@ -825,7 +832,7 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 		atomic_inc(&target->debugger_process->debugged_process_count);
 
 	if (copy_to_user(runtime_info, (void *)&target->runtime_info, copy_size)) {
-		kfd_dbg_trap_deactivate(target, false, 0);
+		kfd_dbg_trap_deactivate(target, false);
 		fput(target->dbg_ev_file);
 		target->dbg_ev_file = NULL;
 		if (target->debugger_process)
@@ -851,7 +858,12 @@ static int kfd_dbg_validate_trap_override_request(struct kfd_process *p,
 
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
-		int err = pdd->dev->kfd2kgd->validate_trap_override_request(
+		int err;
+
+		if (!pdd->debug_active)
+			continue;
+
+		err = pdd->dev->kfd2kgd->validate_trap_override_request(
 								pdd->dev->adev,
 								trap_override,
 								trap_mask_supported);
@@ -886,6 +898,9 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
+		if (!pdd->debug_active)
+			continue;
+
 		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 		pdd->spi_dbg_override = pdd->dev->kfd2kgd->set_wave_launch_trap_override(
 				pdd->dev->adev,
@@ -922,6 +937,9 @@ int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
+		if (!pdd->debug_active)
+			continue;
+
 		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 		pdd->spi_dbg_launch_mode = pdd->dev->kfd2kgd->set_wave_launch_mode(
 				pdd->dev->adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 5babf9b992cd..e93d77fccda2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -25,7 +25,7 @@
 
 #include "kfd_priv.h"
 
-void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
+void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind);
 int kfd_dbg_trap_activate(struct kfd_process *target);
 int kfd_dbg_ev_query_debug_event(struct kfd_process *process,
 			unsigned int *queue_id,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b5d7d13f31a5..b8ef93dba0af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3851,6 +3851,9 @@ int resume_queues(struct kfd_process *p,
 		struct queue *q;
 		int r, per_device_resumed = 0;
 
+		if (!pdd->debug_active)
+			continue;
+
 		dqm_lock(dqm);
 
 		/* unmask queues that resume or already resumed as valid */
@@ -3954,6 +3957,9 @@ int suspend_queues(struct kfd_process *p,
 		struct queue *q;
 		int r, per_device_suspended = 0;
 
+		if (!pdd->debug_active)
+			continue;
+
 		mutex_lock(&p->event_mutex);
 		dqm_lock(dqm);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 129363ad4e34..ed85b7fb896e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -880,6 +880,8 @@ struct kfd_process_device {
 	uint32_t watch_points[4];
 	uint64_t watch_addresses[4];
 	uint32_t alloc_watch_ids;
+	/* Debugging is activated on the device */
+	bool debug_active;
 
 	/*
 	 * If this process has been checkpointed before, then the user
-- 
2.50.1

