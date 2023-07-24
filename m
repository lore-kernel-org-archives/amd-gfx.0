Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC133EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 342D910E113;
	Mon, 24 Jul 2023 19:02:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CD110E113
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKxAFk9GfYHZn9E9AlBS4fESxNBCH4+8RY5HTEhtBSmdPtCrs0D+Eh/lcFmRH8RhO0UN2on8T4LmrGgg9Kdx/alfcVK1GeqqSPNEwp+D5wjVpXYXF5QlYHZ3Vw9qqtQ8h3gr+hb3Z1/GItmxntRjurCDQcvZmU4D03YHLwc8X3gfHilHBDRusHn/twAi+fXxh3isLjlWCs4QsiQvKvzyLqW8WSOTN2ry7AXL7TmHeVzNAUEgarjSJKo0FBDgL/J8/qc3GQ/4goHdfqVczJrWkGOLIAGQtct3gehgHutcy95xVMgEsYpgxu11z5+7x34rxdF0qgZUI1yJDw2Ca5vnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYT2g+/QlOPeMrUTvJokSdFSXTLouUbY36aQvELWgL4=;
 b=fTMETAH3i3m8Q0ziG8q1/yuZL8b5Ps1LztnSeTIy2rYNVciJj3iJjJXQvm0fm3nrKiS7NgkgG9TYxnqaiN7IpvJiJLQehLIyql+7T8qaC2VxMTlaXl49dp2tIBGgSIdornFxQxoxhUXDE6r1bAO4ghUMXJH40MbDXrhgSxQqwfgOyAM/l+CvLwaCCY9Kv4gmM/kpOD/H7p1cYlzk3Q0nxC1W04PelAczHy+72tUwOvuy8m8ALJVj2h4e3BPmfk0IvNy7SBF1zsTbwsWeULbJZFfdHHWyMudP1oNGRaO35+d7KC84I1aIgA151s5qxgLV8zZ+Wt8PQjtmjTEZGndT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYT2g+/QlOPeMrUTvJokSdFSXTLouUbY36aQvELWgL4=;
 b=UhfDeenAPwprmJVSp+RPCHRcMW7YGgeiB2C6WYNgYQSdLQVmWIpbW6SlUsZe5EFmk/BsU5PhF4DPcjVI7sO6wR5eVQmcwS/LaOx67FHmazrWQmWTXBT0fRKwyVRAj1eEZxEVe1z3AZVHg9OKMACFa+HorQr1hVRb3ZghczDpTOE=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 19:02:33 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::c5) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Mon, 24 Jul 2023 19:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:02:33 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 14:02:32 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix and enable ttmp setup for gfx11
Date: Mon, 24 Jul 2023 15:01:59 -0400
Message-ID: <20230724190159.3544879-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: f595abe8-76b8-4a03-6412-08db8c788969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dr04y+g41F5a2R87zEwvGjstqw6+pMTn90d2k/3M2WyeMtZ3U7LbbWaX49KZbXxsw8SX1JW8g75Rowe8puxb5pp+DW1XiLzU6rQIG4oN4KELtJr2bUJ/UHJVCDXNf477KmsGLOlTUjnTxWzDY0VK/uS2QXDpDtP12zJb+7BfjqM5NvwrTHGyGkHKIegaGurv3NvW2a8gBy0ffDXdPa18eoKEoLlueSF2LGH5Lm+1EEfo4aVGHEx/flHR+RuVMj+p5d1Qs7Poyp7aN9MWRCjUH8P8ATZqqdZQe1wWykvgDM1uFxlVDd3Gu0bZtjc5vyfqyJ1FgfbAIhWJIXvRYO/9odYjVgcbJmOwGIdINbkvofEHmw9tVHhgvaB+VuAYKSBM6plyGB4US8IcyPlv2CPzwDfGWN/bei8k2mBMCDKeqFufMuK/2ggc6HP2d54eKAKXEvEToJvUmiQx2oe5LBIrT796CiGjMjRYM8bx00r5Gac4cE0AdCZOZ8+Jx5CLSDL+qxUfpJDdb87gueXe3wPhU4E3ri5/YSJ3DFnWHmejd/s/9jIqWgFh2dRdJe3qfHe+teObWdL3HIuRrhFnU8SAjdNgHLv3am7lcHmRgGjKBOfryhw58yH8ICeNdfBIajNBGuPp7sNzgWtbyC4lf8/DsjFGtvnBBxrxWWwAXZL7fCOTEfPkoJde3eIJRW7X1/sFUDGL9/xwEOFuOsrFj7Nz/U4KLoggV5XoYoL9aW8D8jgxsY4OCP883JpOAy9akaXggTZDrnUZpL0XCsaFYtNagwtWOarTK2J/nINIxvyQR1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6666004)(478600001)(86362001)(40480700001)(54906003)(81166007)(356005)(82740400003)(7696005)(70586007)(70206006)(36860700001)(2616005)(316002)(40460700003)(4326008)(6916009)(47076005)(83380400001)(2906002)(426003)(41300700001)(8936002)(8676002)(1076003)(26005)(36756003)(5660300002)(336012)(44832011)(186003)(16526019)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:02:33.0688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f595abe8-76b8-4a03-6412-08db8c788969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
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
Cc: JinHuiEric.Huang@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The MES cached process context must be cleared on adding any queue for
the first time.

For proper debug support, the MES will clear it's cached process context
on the first call to SET_SHADER_DEBUGGER.

This allows TTMPs to be pesistently enabled in a safe manner.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 +++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        | 11 ++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 12 +++++-------
 6 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 77ca5cbfb601..d67d003bada2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -637,7 +637,7 @@ static uint32_t kgd_gfx_v11_disable_debug_trap(struct amdgpu_device *adev,
 {
 	uint32_t data = 0;
 
-	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, keep_trap_enabled);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
 	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
 	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e0f9cf6dd8fd..42df972357e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2755,6 +2755,16 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 
 		if (pdd->qpd.queue_count)
 			return -EEXIST;
+
+		/*
+		 * Setup TTMPs by default.
+		 * Note that this call must remain here for MES ADD QUEUE to
+		 * skip_process_ctx_clear unconditionally as the first call to
+		 * SET_SHADER_DEBUGGER clears any stale process context data
+		 * saved in MES.
+		 */
+		if (pdd->dev->kfd->shared_resources.enable_mes)
+			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
 	}
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
@@ -2848,7 +2858,8 @@ static int runtime_disable(struct kfd_process *p)
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
 				debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd);
+				kfd_dbg_set_mes_debug_mode(pdd,
+							   !kfd_dbg_has_cwsr_workaround(pdd->dev));
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 1f82caea59ba..9ec750666382 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -344,11 +344,10 @@ static int kfd_dbg_set_workaround(struct kfd_process *target, bool enable)
 	return r;
 }
 
-int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)
+int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 {
 	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
 	uint32_t flags = pdd->process->dbg_flags;
-	bool sq_trap_en = !!spi_dbg_cntl || !kfd_dbg_has_cwsr_workaround(pdd->dev);
 
 	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
 		return 0;
@@ -432,7 +431,7 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
 		r = debug_map_and_unlock(pdd->dev->dqm);
 	else
-		r = kfd_dbg_set_mes_debug_mode(pdd);
+		r = kfd_dbg_set_mes_debug_mode(pdd, true);
 
 	kfd_dbg_clear_dev_watch_id(pdd, watch_id);
 
@@ -474,7 +473,7 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
 		r = debug_map_and_unlock(pdd->dev->dqm);
 	else
-		r = kfd_dbg_set_mes_debug_mode(pdd);
+		r = kfd_dbg_set_mes_debug_mode(pdd, true);
 
 	/* HWS is broken so no point in HW rollback but release the watchpoint anyways */
 	if (r)
@@ -516,7 +515,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
 			r = debug_refresh_runlist(pdd->dev->dqm);
 		else
-			r = kfd_dbg_set_mes_debug_mode(pdd);
+			r = kfd_dbg_set_mes_debug_mode(pdd, true);
 
 		if (r) {
 			target->dbg_flags = prev_flags;
@@ -539,7 +538,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
 				debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd);
+				kfd_dbg_set_mes_debug_mode(pdd, true);
 		}
 	}
 
@@ -601,7 +600,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
 			debug_refresh_runlist(pdd->dev->dqm);
 		else
-			kfd_dbg_set_mes_debug_mode(pdd);
+			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
 	}
 
 	kfd_dbg_set_workaround(target, false);
@@ -717,7 +716,7 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
 			r = debug_refresh_runlist(pdd->dev->dqm);
 		else
-			r = kfd_dbg_set_mes_debug_mode(pdd);
+			r = kfd_dbg_set_mes_debug_mode(pdd, true);
 
 		if (r) {
 			target->runtime_info.runtime_state =
@@ -851,7 +850,7 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
 			r = debug_refresh_runlist(pdd->dev->dqm);
 		else
-			r = kfd_dbg_set_mes_debug_mode(pdd);
+			r = kfd_dbg_set_mes_debug_mode(pdd, true);
 
 		if (r)
 			break;
@@ -883,7 +882,7 @@ int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
 			r = debug_refresh_runlist(pdd->dev->dqm);
 		else
-			r = kfd_dbg_set_mes_debug_mode(pdd);
+			r = kfd_dbg_set_mes_debug_mode(pdd, true);
 
 		if (r)
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 586d7f886712..fd0ff64d4184 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -126,5 +126,14 @@ static inline bool kfd_dbg_has_gws_support(struct kfd_node *dev)
 	return true;
 }
 
-int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd);
+int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en);
+
+static inline bool kfd_dbg_has_ttmps_always_setup(struct kfd_node *dev)
+{
+	return (KFD_GC_VERSION(dev) < IP_VERSION(11, 0, 0) &&
+			KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 2)) ||
+	       (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
+			KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0) &&
+			(dev->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 70);
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 71b7f16c0173..ccaf85fc12c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -228,6 +228,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.tma_addr = qpd->tma_addr;
 	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
 	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
+	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled ||
+					     kfd_dbg_has_ttmps_always_setup(q->device);
 
 	queue_type = convert_to_mes_queue_type(q->properties.type);
 	if (queue_type < 0) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index eeedc3ddffeb..3b0749390388 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -38,6 +38,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_iommu.h"
 #include "kfd_svm.h"
+#include "kfd_debug.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_ras.h"
 #include "amdgpu.h"
@@ -1931,6 +1932,9 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_TRAP_OVERRIDE_SUPPORTED |
 			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
 
+	if (kfd_dbg_has_ttmps_always_setup(dev->gpu))
+		dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
+
 	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
 		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3))
 			dev->node_props.debug_prop |=
@@ -1941,10 +1945,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 				HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
 				HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
-		if (KFD_GC_VERSION(dev->gpu) != IP_VERSION(9, 4, 2))
-			dev->node_props.debug_prop |=
-				HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
-
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 4, 2))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
@@ -1952,9 +1952,7 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
 
-		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(11, 0, 0))
-			dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
-		else
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
 	}
-- 
2.25.1

