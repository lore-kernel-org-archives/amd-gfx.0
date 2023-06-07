Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39259C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EB910E529;
	Wed,  7 Jun 2023 17:27:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9FE10E529
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkUv4Xsyp6V6ALAe+3MJKqCK52UMFLDrwJupYC478KHZ6Q6VIxHDvscIZ8tMO5YbpzG5OYS+cphXddIy7sBSn9joPKzDY+E4T6RfHAiStWeibBYI52sycdYmGq0l+MWjNZwTN5PnEK6DaGN1DOuZlzUdTMLQfCR1UyLL6HWc9A5ihNMB788O769G0y5wWxIdzmt/tinZb0bw72fOIowz2RPVQaV8ekW4d4EaOeAipFdgOERk/p3dcpc+GlxXaUuHQFlFoA1dBCxudJ124pkimxTQYPzOxRCduMYGTE6B68nvRW+DLbufrtKbZSz5TtzWUxoKJnVYMmEV3ZMJf+px6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6zCrQ4/gpnojlU1pN2lRrNrknTMG7n/w4twXNI3dSk=;
 b=TjQSySg8TSVVjhlNBLDoyzcsxT8FM+3ThbiZEHHrFtRGDHQZwEhfZcyzhS3z50gMm+mtb+gTxPQN6SwgwTTZMQiy3H8HnoUeBu6M0efTvmkq1WWWYZUq5eN3ZIUPL9hvmJQe2FXxrJ8jr0Y+ldS2PFJAkxCD/JSAF1Gg7CmzgNKkqoGdp/f6hB3oaqC2ValyyqGwKHGOFBrzgSRZ6t/QSu68+SezCjwDRiBwpyGOAWKaqmjh2fK6FAIFRoGH8EjsUv1PRkuzLy7lDaeRP+n7sXTeVD2udYn+umfBzS1qG7sDmrWvKxsID/zAdXKMxtXkTkmpVyXA7xPaXoo2sSN7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6zCrQ4/gpnojlU1pN2lRrNrknTMG7n/w4twXNI3dSk=;
 b=JzgdB9L6z3zGJxEccaNo35CirWrhO65jNGKgqnt7WivwMqusu4vyoz2qKFJClAthXlZCb0i6eAw/bWDMyzRrHoLCD85wBEyNY64Pnpylf1IwuYQqD8U6/7TD0pYWEyKlk3YGA1AI2n5uQkwnEoaTUI7yHG3Kwji0imltalMc9yg=
Received: from BN0PR10CA0022.namprd10.prod.outlook.com (2603:10b6:408:143::30)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 17:27:04 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::dc) by BN0PR10CA0022.outlook.office365.com
 (2603:10b6:408:143::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 17:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 17:27:03 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 12:27:00 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix and enable debugging for gfx11
Date: Wed, 7 Jun 2023 13:26:47 -0400
Message-ID: <20230607172647.1824726-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9a8384-5788-4de0-3aed-08db677c68c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3swS5IrNeyaO5foKeilsY0nhHxc5YtqTqQf+xJdwnT6SVbFKlLeoChfMLdVZ3DgC9p9fWHXINxKSSRmWwORmAnwwJG95Wlsp+CKZfZGjDIDleEv69g9t91990d7tQf0jrZXb8YkG4DYmZou4D5oYs1zpEtjspsW9skGyD6mLn6ypmSizeCwPQPv9kSEuEc5MOr1CwnVXEblaUEjRMewn3TSHUa20KH5Sqw+EM5p+VEzkF3bV3DQe2+hsNvyi+IcaHEG8KChqaAjb0pQ6icsODw1lVarE8qGNjkQEtsSXTncLaM8Ovaj6vZUp7yK5Ak+ytZk5AIaqSZRgtzmDQ7tSTbBm8h/q/RRVylUvCCW9GsIrb9nuMN7S0JT5rgHrEMSBW+lLAte0lJ+6yxE/CI3e/tFDoTMlzhwE5oGI7rM1BinNfcPF/c5LQetNLlLjojcWpiQCJUturmFigXASOJZkb7Q1r/u6GGjKYp1f0WFQt5uiRxFEHW2/O+piHp5mMeYMcQ0+JkJEfrPaOLFRC96xG4kO/WOZ7UFVPFDfm5nPKaZqeH38X8OWaC1Sp3XKmfaLUYXgbDlos+GHimk9wnq4lmh+kxp1dGkFTTGX8Dr912EQANQ/x17DJ8i2c4VfhAV56cg+5SJ60ZqO9Lxnu648qd/p9FGLiY3U1AHywIHou4gUrfUvtGgJvMlSNtd/PD5qIdeVHQuhc0fzQUsAFF5kG8YDoStnaJlilN7nYad7l+h5SwL5No//B/vXqz/EVDjjGEEEawNYtRzIHZr1SifdLu6pVf0CHs0/g2S6A0KhG20=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(82310400005)(40460700003)(6666004)(40480700001)(26005)(1076003)(16526019)(83380400001)(47076005)(336012)(426003)(36860700001)(2616005)(186003)(36756003)(86362001)(356005)(82740400003)(81166007)(54906003)(5660300002)(44832011)(316002)(41300700001)(8676002)(8936002)(70586007)(4326008)(70206006)(6916009)(478600001)(66899021)(2906002)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:27:03.4146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9a8384-5788-4de0-3aed-08db677c68c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
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
Cc: JinHuiEric.Huang@amd.com, Felix.Kueling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are a few fixes required to enable gfx11 debugging.

First, ADD_QUEUE.trap_en is an inappropriate place to toggle
a per-process register so move it to SET_SHADER_DEBUGGER.trap_en.
When ADD_QUEUE.skip_process_ctx_clear is set, MES will prioritize
the SET_SHADER_DEBUGGER.trap_en setting.

Second, to preserve correct save/restore priviledged wave states
in coordination with the trap enablement setting, resume suspended
waves early in the disable call.

Finally, displaced single stepping can cause non-fatal illegal
instructions during process termination on debug disable.  To work
around this, stall the waves prior to disable and allow clean
up to happen naturally on process termination.

NOTE: The AMDGPU_MES_VERSION_MASK check is a place holder as
MES FW updates have been reviewed but is awaiting binary
creation.  Once the binaries have been created, this check may
be subject to change.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  4 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 31 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 12 ++++---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  1 +
 7 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 20cc3fffe921..95d69f9c7361 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -928,7 +928,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
 				const uint32_t *tcp_watch_cntl,
-				uint32_t flags)
+				uint32_t flags,
+				bool trap_en)
 {
 	struct mes_misc_op_input op_input = {0};
 	int r;
@@ -945,6 +946,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	memcpy(op_input.set_shader_debugger.tcp_watch_cntl, tcp_watch_cntl,
 			sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
 
+	op_input.set_shader_debugger.trap_en = trap_en;
+
 	amdgpu_mes_lock(&adev->mes);
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index b5f5eed2b5ef..2d6ac30b7135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -294,6 +294,7 @@ struct mes_misc_op_input {
 			} flags;
 			uint32_t spi_gdbg_per_vmid_cntl;
 			uint32_t tcp_watch_cntl[4];
+			uint32_t trap_en;
 		} set_shader_debugger;
 	};
 };
@@ -361,7 +362,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
 				const uint32_t *tcp_watch_cntl,
-				uint32_t flags);
+				uint32_t flags,
+				bool trap_en);
 
 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 			int queue_type, int idx,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c4e3cb8d44de..1bdaa00c0b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -347,6 +347,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
 				input->set_shader_debugger.tcp_watch_cntl,
 				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
+		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
 		break;
 	default:
 		DRM_ERROR("unsupported misc op (%d) \n", input->op);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 125274445f43..e7bc07068eed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -349,12 +349,30 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)
 {
 	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
 	uint32_t flags = pdd->process->dbg_flags;
+	bool sq_trap_en = !!spi_dbg_cntl;
 
 	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
 		return 0;
 
+	/*
+	 * For displaced single stepping, the debugger inserts s_trap instructions
+	 * from user space.
+	 * This can race with the CWSR workaround during a non-IOCTL disable and
+	 * cause non-fatal trailing SQ illegal instructions.
+	 * As a work around, stall waves indefinitely in this case as the process
+	 * queues will terminate anyways.  MES will automatically clean up the
+	 * SPI debug HW registers when all queues are unmapped.
+	 * IOCTL disable will not hit these cases as the program needs to be in a
+	 * non-continued state to make the disable call in the first place so
+	 * debugger insertion of s_trap in debug memory will never occur.
+	 */
+	if (KFD_GC_VERSION(pdd->dev) >= IP_VERSION(11, 0, 0) &&
+	    KFD_GC_VERSION(pdd->dev) < IP_VERSION(12, 0, 0) &&
+	    !pdd->process->mm && !sq_trap_en)
+		spi_dbg_cntl |= 0x1; /* Set SPI_GDBG_PER_VMID_CNTL.stall_vmid */
+
 	return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
-						pdd->watch_points, flags);
+						pdd->watch_points, flags, sq_trap_en);
 }
 
 #define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
@@ -557,6 +575,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 
 	if (!unwind) {
 		uint32_t flags = 0;
+		int resume_count = resume_queues(target, 0, NULL);
+
+		if (resume_count)
+			pr_debug("Resumed %d queues\n", resume_count);
 
 		cancel_work_sync(&target->debug_event_workarea);
 		kfd_dbg_clear_process_address_watch(target);
@@ -598,13 +620,6 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 	}
 
 	kfd_dbg_set_workaround(target, false);
-
-	if (!unwind) {
-		int resume_count = resume_queues(target, 0, NULL);
-
-		if (resume_count)
-			pr_debug("Resumed %d queues\n", resume_count);
-	}
 }
 
 static void kfd_dbg_clean_exception_status(struct kfd_process *target)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0c1be91a87c6..ff0a28760494 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -227,8 +227,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	queue_input.tba_addr = qpd->tba_addr;
 	queue_input.tma_addr = qpd->tma_addr;
 	queue_input.trap_en = KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
-			      KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0) ||
-			      q->properties.is_dbg_wa;
+			      KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0);
 	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
 
 	queue_type = convert_to_mes_queue_type(q->properties.type);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index faa7939f35bd..90b86a6ac7bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1863,13 +1863,15 @@ static void kfd_topology_set_dbg_firmware_support(struct kfd_topology_device *de
 {
 	bool firmware_supported = true;
 
-	/*
-	 * FIXME: GFX11 FW currently not sufficient to deal with CWSR WA.
-	 * Updated FW with API changes coming soon.
-	 */
 	if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0) &&
 			KFD_GC_VERSION(dev->gpu) < IP_VERSION(12, 0, 0)) {
-		firmware_supported = false;
+		uint32_t mes_api_rev = (dev->gpu->adev->mes.sched_version &
+						AMDGPU_MES_API_VERSION_MASK) >>
+						AMDGPU_MES_API_VERSION_SHIFT;
+		uint32_t mes_rev = dev->gpu->adev->mes.sched_version &
+						AMDGPU_MES_VERSION_MASK;
+
+		firmware_supported = (mes_api_rev >= 14) && (mes_rev >= 64);
 		goto out;
 	}
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index f3c15f18ddb5..0997e999416a 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -575,6 +575,7 @@ struct SET_SHADER_DEBUGGER {
 	} flags;
 	uint32_t spi_gdbg_per_vmid_cntl;
 	uint32_t tcp_watch_cntl[4]; /* TCP_WATCHx_CNTL */
+	uint32_t trap_en;
 };
 
 union MESAPI__MISC {
-- 
2.25.1

