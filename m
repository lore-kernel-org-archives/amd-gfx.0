Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE47C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 20:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CBB10E545;
	Wed,  7 Jun 2023 20:20:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2331C10E545
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 20:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W149mu45k1Eal0FPXYA3qC5CziR6zb8GtbjsvmT3o0j745nztAhOD06Y6NNPPPB01j6dzqBbGscBoMsryMw8ZwZA6zGZZmGDer1z8CgsV8H/FwGxTzMlglTmJu4TRAmvO/9Xks66ud2rAmMl4Nq7GL408SgDkdwkuT1yt6No98gSdvFcTqxZngBjw1jAvmkI0gKlrusXG/jT7FLzJlgp1qJdVYKj1NQhgjBqvAg8uU8U29HTNMnBX+gQn5LEkGZ2swWGa7jyAPmCBDC7qVTEkZMtl9Jw4YEAhh9SQGRNWNu55WFgnjRtYVhsEjoVXOk9uGtzokNsnhYJ1MWPReNdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax3hdxVFv6M6OYPQA+i0cB2cS75H7qbVR0cQfNmdPXk=;
 b=A/w+OlBP973VlDCh6U35iKCglXhLvBAEOvNHTfLhRqJEU0Ka5k4ZqB4qQboHUV46I8ULjT1OA+UoqqyR61CiWFiPIYLTpXc1D0B4cqk8MdKNMx466zEqN39Pt8X470FvOtfPkGaJLSwWniqGchfH9BvE2bqDrGpvAxwzZgfbTk5gyu6vR0qmcsxH1jWwLOm+hs8avjdCYDy34pCyWAHzHC8TCQyiZSw0Pdqv6gi0KSzxriH+BWQUfOxxQgK3ZfnbyNzJRDN6sPs8/yACcycMgXEENrb/ZmeunooHQ5SSXK7PlkxIobMNntyP39yM57iswmSsnv37SkckvCiThkdVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax3hdxVFv6M6OYPQA+i0cB2cS75H7qbVR0cQfNmdPXk=;
 b=3W5DZTwGHLrK0uj/fXCwAgxWnfRtSs2VhOGE+0aFinYPOLxcfvjxNDiogTmmGlcZeKJtjQC5cAssAQrci0Oiap9KLSURwQCm+jJQusNTuH8xKhvM+a7UUuZcFW+LG8XPbb1dBSqzNapX437YHt6Yt1udL93GiJLm50CXrOzwekE=
Received: from BN7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:408:34::23)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 20:20:14 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::9d) by BN7PR06CA0046.outlook.office365.com
 (2603:10b6:408:34::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 20:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Wed, 7 Jun 2023 20:20:13 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 15:20:11 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix and enable debugging for gfx11
Date: Wed, 7 Jun 2023 16:20:02 -0400
Message-ID: <20230607202002.1876968-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|CH0PR12MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e0f1e0-f091-4d9b-d7c7-08db679499e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlQo8XA2md0mYewSjKbarFTfSd2+ibuoT9NVeEnsMoHxqSUD7LfY44IakEGPK3OHTGRnkBTM+eoKw2dsfv4bvViBHQnn8Vn/BhnzkiXKAv9/k6R1qk4mCZljhJR1cQmUgaYdHJG165J9VASENkd7ssr3/qcOJf1YfNc7UtiDEB+jsocjELApq1+e+8BHCtCXrJNT0gWC2SX5QZMxhrRhO1og6FXut8BQJRPqZZeKsGYOTb5+WiOK7Iez/DOyODser4Jo33/PSJBQNcU1ssRNhfaDJeJSf/ecmyLYr0DE1FhUCDuCQru+s11qJzkoPqPMENfQDTLh83ZuwJcJCM0gVhcZMHCk3OPLY30qqUtra0qFC2bMPNdOMRocSL5H+b30JzmeM6eCHKnWTbnBGn5+7UKNVgk6ZbA+7SW0xcUKlCz7e+7gTdcyE5o2yXwIutX0vuyBjfkS7eEIwNux2hsmepajl/bvcm2gik9Q8ABrsKl8Pqixazd5K0rKsQHfGYyjLtfl8iMdRmbDJX6skQqTQfyDM+lx0CEa2mObWRLjoTN+flRiVXMxbTdPGoRcEuPVhfaC7cknTAHT0ZhleLUt2ZVuy3PLwjJTzPb8o2A5wQWrxAkRMsEH5zkdRzn7uaAawO/Adf1FarXSJZx880/szxaE9ZmD4Z2T+L+MGglhYtpv/gXhh7yWFOnvoQ+7wbkASm9xXCDP75conl9hTS2YT11Dx/S/NwwZLQCjYl4FhdgqsEvoPncpBlkW6LjfrN7EEOBqA+tP/giSbXoJE4QuniDJ0msEMpHnJ1sFu6Mgcbo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(82740400003)(70206006)(36756003)(356005)(81166007)(70586007)(4326008)(6916009)(83380400001)(54906003)(8676002)(40480700001)(8936002)(5660300002)(86362001)(44832011)(2906002)(316002)(41300700001)(40460700003)(2616005)(426003)(336012)(47076005)(1076003)(26005)(16526019)(186003)(66899021)(7696005)(6666004)(82310400005)(36860700001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 20:20:13.7320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e0f1e0-f091-4d9b-d7c7-08db679499e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
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

There are a couple of fixes required to enable gfx11 debugging.

First, ADD_QUEUE.trap_en is an inappropriate place to toggle
a per-process register so move it to SET_SHADER_DEBUGGER.trap_en.
When ADD_QUEUE.skip_process_ctx_clear is set, MES will prioritize
the SET_SHADER_DEBUGGER.trap_en setting.

Second, to preserve correct save/restore priviledged wave states
in coordination with the trap enablement setting, resume suspended
waves early in the disable call.

NOTE: The AMDGPU_MES_VERSION_MASK check is a place holder as
MES FW updates have been reviewed but is awaiting binary
creation.  Once the binaries have been created, this check may
be subject to change.

v2: do a trap_en safety check in case old mes doesn't accept
unused trap_en d-word.
remove unnecessary process termination work around.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c             | 14 ++++++--------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          | 12 +++++++-----
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |  1 +
 7 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 20cc3fffe921..e9091ebfe230 100644
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
@@ -945,6 +946,10 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	memcpy(op_input.set_shader_debugger.tcp_watch_cntl, tcp_watch_cntl,
 			sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
 
+	if (((adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK) >>
+			AMDGPU_MES_API_VERSION_SHIFT) >= 14)
+		op_input.set_shader_debugger.trap_en = trap_en;
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
index 125274445f43..cd34e7aaead4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -349,12 +349,13 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)
 {
 	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
 	uint32_t flags = pdd->process->dbg_flags;
+	bool sq_trap_en = !!spi_dbg_cntl;
 
 	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
 		return 0;
 
 	return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
-						pdd->watch_points, flags);
+						pdd->watch_points, flags, sq_trap_en);
 }
 
 #define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
@@ -557,6 +558,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 
 	if (!unwind) {
 		uint32_t flags = 0;
+		int resume_count = resume_queues(target, 0, NULL);
+
+		if (resume_count)
+			pr_debug("Resumed %d queues\n", resume_count);
 
 		cancel_work_sync(&target->debug_event_workarea);
 		kfd_dbg_clear_process_address_watch(target);
@@ -598,13 +603,6 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
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

