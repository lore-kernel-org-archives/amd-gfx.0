Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B95CC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 21:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03B210E13E;
	Mon, 11 Dec 2023 21:16:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15E610E13E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 21:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9LVKlIvihxuTvl6QjC4nDAML+no5uMTeEeLoQkk3E4KICfo1BD2Vb8HaH3MVTeofpg3TAN6Sle6+rBR2ODiIx2hoGkzfERXyebRkPBF1iITjOBP1k22W/A25G++4hAZj0Xwr2k86Em9sX8/LqJ3XLOn3Snz8QJgh9paMgvtV7ytAv4wF/sV9x6Dh/rnxYXPPiwHIUwZlKdhB+DgqADpIRsIS8SKvEabwa8A7BwqkC2mMqE9G6XcT1s8M6IeANHRrBFh+JKP0zH8cBvr6QZoD/DvMPJoa1WO0Vu3Zn1n2Bakiha4jUL3U/EnmoifDmciZ+E2HIkSbQBN3qQ4nGB/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKbB6zloa5qI5SMVZ70nVgn9FE6R/8kRonfyjTZHQbw=;
 b=h7NaHh5B2dLB8EfEKqcoOEbGnp+sj1bJmZHn6tidH5XKBIdtNgYlXiqy9dT1e1YtQqUimB9BwcRg4xXQ35ybHrComa/cIgvuCZ9Yey0IwBNqgWdSIu7ZDKOTWAcCmp9e5q2NUuBax3/AUCEfNBN6+5CIsxMWcET9XbIYk1sDnMbFjTZwIqBAO1KOHJsdmYmYyPLWxU/4u/AKjKWnwpGYkJYfaHP1N57D6f7Kszhyv2XLBhrrGbqIRkq2dY3XmczHNs4vMmzUxv4vsluY8tZslV5Fgy/72KyaHdnyOHnH2JvaYs/sH46LlIULdyVzaxgvh52LeByr3mWYFDG+aaHX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKbB6zloa5qI5SMVZ70nVgn9FE6R/8kRonfyjTZHQbw=;
 b=prA5SEJ3crAPgv0eL9xtiKZxsoyn4uQPNyEnsYnjLPWnE1o9HkOl1ke54GMIUazTe1oEkdWmX2w8aDQxiN9UWv1Q7xIuwBzmtinEmqzxxruE8B/LH+/68WA7YmbH+MB8Z5XxMLgCqNEYtE3ZAHYYGQHriGVQYkdeDY0JNclMPvc=
Received: from CH2PR19CA0019.namprd19.prod.outlook.com (2603:10b6:610:4d::29)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 21:16:25 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:610:4d:cafe::79) by CH2PR19CA0019.outlook.office365.com
 (2603:10b6:610:4d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 21:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 21:16:24 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 15:16:23 -0600
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix mes set shader debugger process management
Date: Mon, 11 Dec 2023 16:16:12 -0500
Message-ID: <20231211211612.3109-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e1f109-708c-4021-96c2-08dbfa8e6e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6LZ6/3M6eqwwbPsTA+xBzyoS1Lu9s/YXE6Uy7/qPzf9AeuNDi2L0Ej0fw9XlcTKvgN6fzbmQ7t9umidcJ6e8EeCLDvU2rqoIfcrGxzp33ai8kKugiqf/Zya88JqRCb0DsB9PBuP+/RSwq8SlQ8IujC90PJLeonanIH7f0VnrLOQg/FZStwOdoD/twlAYHtzFnQITSZnGdFCeaUH1k5Li/zNEaXbEs6hR3iVnseUdEt8wkb1mmknCkkruwXrlFVZ7LOriWHNuLPcR71zYw+kya/VhVqYynSJ4xiouiQpiaLBunPrFQo9oqeHHsqsEc98wY9q6AZ8RPOROiEpx0xp+ZLgg3weq5eFIMGfw9LonFo2xCyaZhMs2tfPRJ3i1dvYIy7vjvjrhbw2z96+/x//emV+AtjlN5kYCvZQbf0+WMdlDV9OVhXFNcPipR+oK5kl15sIkJ07xOBgdMFQo5pf5eutHysGVFQH7JfuyvssM/3A43HWLGUmeYXPPT5dzFs8Kk+GOkDpG1vh2jwaILjN8Voe+XjHkl80zA9B0KH4BTjF5amSyHg3OTNfbmrlPyZDqLtYWURagWUAniDIHExJsKG9YXpEF4R3YJP0tx7zHtRDW4tTovkxSVl1NPWDl0rnomX/CP29aJB2aVOJjH4PlS2qPn6AHG80o0TkU8GYz3Ja9Z4IMykPbcJyr3x8R2MS3XULPEHrlD3eoeD2eSesb5imQCSKbPlXUj7uRtg6ELBWr+Sa5kD+Qhx838OY6MBgXwZ/v3SJtadr3z3ZdZbQvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(41300700001)(36860700001)(36756003)(86362001)(81166007)(356005)(82740400003)(2616005)(83380400001)(336012)(1076003)(426003)(16526019)(26005)(478600001)(7696005)(47076005)(6666004)(4326008)(5660300002)(316002)(70586007)(6916009)(54906003)(70206006)(8936002)(8676002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:16:24.5063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e1f109-708c-4021-96c2-08dbfa8e6e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
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
Cc: JinHuiEric.Huang@amd.com, Alice Wong <shiwei.wong@amd.com>,
 Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MES provides the driver a call to explicitly flush stale process memory
within the MES to avoid a race condition that results in a fatal
memory violation.

When SET_SHADER_DEBUGGER is called, the driver passes a memory address
that represents a process context address MES uses to keep track of
future per-process calls.

Normally, MES will purge its process context list when the last queue
has been removed.  The driver, however, can call SET_SHADER_DEBUGGER
regardless of whether a queue has been added or not.

If SET_SHADER_DEBUGGER has been called with no queues as the last call
prior to process termination, the passed process context address will
still reside within MES.

On a new process call to SET_SHADER_DEBUGGER, the driver may end up
passing an identical process context address value (based on per-process
gpu memory address) to MES but is now pointing to a new allocated buffer
object during KFD process creation.  Since the MES is unaware of this,
access of the passed address points to the stale object within MES and
triggers a fatal memory violation.

The solution is for KFD to explicitly flush the process context address
from MES on process termination.

Note that the flush call and the MES debugger calls use the same MES
interface but are separated as KFD calls to avoid conflicting with each
other.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 10 +++---
 .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  3 +-
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e544b823abf6..e98de23250dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -916,6 +916,11 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
 	op_input.set_shader_debugger.process_context_addr = process_context_addr;
 	op_input.set_shader_debugger.flags.u32all = flags;
+
+	/* use amdgpu mes_flush_shader_debugger instead */
+	if (op_input.set_shader_debugger.flags.process_ctx_flush)
+		return -EINVAL;
+
 	op_input.set_shader_debugger.spi_gdbg_per_vmid_cntl = spi_gdbg_per_vmid_cntl;
 	memcpy(op_input.set_shader_debugger.tcp_watch_cntl, tcp_watch_cntl,
 			sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
@@ -935,6 +940,32 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
+				     uint64_t process_context_addr)
+{
+	struct mes_misc_op_input op_input = {0};
+	int r;
+
+	if (!adev->mes.funcs->misc_op) {
+		DRM_ERROR("mes flush shader debugger is not supported!\n");
+		return -EINVAL;
+	}
+
+	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
+	op_input.set_shader_debugger.process_context_addr = process_context_addr;
+	op_input.set_shader_debugger.flags.process_ctx_flush = true;
+
+	amdgpu_mes_lock(&adev->mes);
+
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	if (r)
+		DRM_ERROR("failed to set_shader_debugger\n");
+
+	amdgpu_mes_unlock(&adev->mes);
+
+	return r;
+}
+
 static void
 amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 894b9b133000..7d4f93fea937 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -296,9 +296,10 @@ struct mes_misc_op_input {
 			uint64_t process_context_addr;
 			union {
 				struct {
-					uint64_t single_memop : 1;
-					uint64_t single_alu_op : 1;
-					uint64_t reserved: 30;
+					uint32_t single_memop : 1;
+					uint32_t single_alu_op : 1;
+					uint32_t reserved: 29;
+					uint32_t process_ctx_flush: 1;
 				};
 				uint32_t u32all;
 			} flags;
@@ -374,7 +375,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				const uint32_t *tcp_watch_cntl,
 				uint32_t flags,
 				bool trap_en);
-
+int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
+				uint64_t process_context_addr);
 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 			int queue_type, int idx,
 			struct amdgpu_mes_ctx_data *ctx_data,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 77f493262e05..8e55e78fce4e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -87,6 +87,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
+	amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
 	pdd->already_dequeued = true;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 1fbfd1aa987e..ec5b9ab67c5e 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -572,7 +572,8 @@ struct SET_SHADER_DEBUGGER {
 		struct {
 			uint32_t single_memop : 1;  /* SQ_DEBUG.single_memop */
 			uint32_t single_alu_op : 1; /* SQ_DEBUG.single_alu_op */
-			uint32_t reserved : 30;
+			uint32_t reserved : 29;
+			uint32_t process_ctx_flush : 1;
 		};
 		uint32_t u32all;
 	} flags;
-- 
2.34.1

