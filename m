Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9FEECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D648A10F30D;
	Mon, 29 Aug 2022 14:31:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D1D10F2FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRQriNE8BA09XJVPOBxoiVY4XNSeyrasl+GuvTT5fnCcptBEBvtevAbHc6fggkthxknhZkOjSoW5P7BY5wiUAuE4iyE/xG36ldnOZE2DfLkmrDs6vzorrpD861bau+01CCrL9Q08USPAqZD9koln9GLG7XFEBg9Nrx3yXBnurMxtRUQIA8+JeDVas31mBPVVosZkcnoLN1SMWNt9c34iWhF6Xpeg9Qa5BFW999GJkoJ8uYicHR6ylLCTGRwpjlA8g52hbWL8Wce9y/Fllm9Plk8vxU7F65UdB+MgjMMGhPdNLeXZZX1GEuHL89Y2y33exQP5fNcEhro9JJPeL3nT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7kcQG3rzTfS/djdmg8fNX3pLUoGntFg7c3jhbicL2Y=;
 b=BEcmI1YB8d2AR652GIhCINo7i103337shc6QKHHjYHtAKTo8lI7JLlLenvX3hfCp7qiJyao+SHn4PdacFuHFep+VJ3z6iH01JMyfcoPuSDoVkqR7enwwcRacCMPsoJCHf0MsJCbW/UdRvSSXQcqirxCqIlCIHLWhq1hJBymbYN/6QHyDwZMR/9vv+vj2Q57IJF6rLCoKVgmQtRWEuaJ9qSRUCr8gevJv5lMocXMquKfaP9VgmW/Te6ptOCyt5k09/oIse8zoZLP7wHOnDqPIIkGYH8iyYKPl7EJ495aNtdF0fEZP360a8AkkHOtwP5uICyAyMtHBuR17gzTbYr17UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7kcQG3rzTfS/djdmg8fNX3pLUoGntFg7c3jhbicL2Y=;
 b=CS9kSIYajf8oNfdGrvWPeSxyIuiGp4tvT63br7FJJk3K/ljYW7hwm21G6ceG9B6m3iEpy0VaCKVLWQ5vI9stXKXMKZoeuOlWYIlfWllW1f58RZdAJU90icZS2V4MJBDxsQTCfLZRmXtZpXgFRGaDm/pJWlA+3HPphJmhYKYKXeE=
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 14:31:17 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::6d) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:17 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:31:10 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/29] drm/amdkfd: add debug set flags operation
Date: Mon, 29 Aug 2022 10:30:21 -0400
Message-ID: <20220829143026.1509027-25-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79ac4608-8ab1-4060-9abb-08da89cb223b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5944:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aW1GDzOf4neKiUJDMbMMa2MlcEo21kVtlA9XeDtUws9pfSaGy4RUF4AhzKa7ros/S5Z3aZiBSZPo8WO7apqh3NnEgIKqwtlBfnhjHu1FUSFNTrEmYw6+D820KuJWWzf8c00jAWl1K8OxH6Vx3KQ9d9KBMjj7SxmYr3mEi+iugwMLhyFil57mhjm6MASU2PRC5a1jCmKUB7p68HkVzqJ0oJFEzst1hYxSm75N9W+Z9NaqfawijSTPsTOudEmJTPgR+NpnQDSteHLd3LtSI81D7qcg+LM+zoany7or6hNWboB8itNsOjWvIBW0PCodaEKpCpk3Kj0tcXEe6gjcAjmbDkOpJ0vLF0oHVAnrEy2NtxuSMZMEUR9gy/EIsWmOgI69fHKA4Ss6LVVeEBvcT5Mswtvnrs3ZyScg2x/3PAqVAz7IwM7eiAZGVIs+qhtdgOQwhP0I3RkViNowl6VoNezszhOKC0IoKj10E/LmTMcjjxXwJ7MWyIdgZ3ikTtddpTQJVIOx771f2ofdhvEcPqyHKP9B1n51Xb7x1ReGhvtSP97q0OgdlygEZo9YsU/QKOgyoyydA/41EU/08bGC3ESYamRWTcZE7OYSz006pBY3Wi/zVkR3qj55c1+S+rjHfAiMQfL1lwswMohNLECejSgYDCCyW4FMDaxciayVMGCOb3jiQNvFENcq3p2y+UkrgDFeHz0HhS+xkc0SYa7/+3XmjzVf3aPlLPrDP94JILeBTlekaoggeRvN65lOr4akMHwzy6dBcp0BFGwIH/UKzHHeWDa5WNPh+CrtbAFx2UVyr9w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(2906002)(6916009)(5660300002)(8936002)(8676002)(4326008)(36860700001)(1076003)(426003)(2616005)(316002)(47076005)(44832011)(70586007)(70206006)(36756003)(54906003)(6666004)(7696005)(41300700001)(86362001)(26005)(82310400005)(83380400001)(16526019)(356005)(336012)(40480700001)(81166007)(186003)(82740400003)(478600001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:17.0169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ac4608-8ab1-4060-9abb-08da89cb223b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow the debugger to set single memory and single ALU operations.

Some exceptions are imprecise (memory violations, address watch) in the
sense that a trap occurs only when the exception interrupt occurs and
not at the non-halting faulty instruction.  Trap temporaries 0 & 1 save
the program counter address, which means that these values will not point
to the faulty instruction address but to whenever the interrupt was
raised.

Setting the Single Memory Operations flag will inject an automatic wait
on every memory operation instruction forcing imprecise memory exceptions
to become precise at the cost of performance.  This setting is not
permitted on debug devices that support only a global setting of this
option.

Likewise, Single ALU Operations will force in-order ALU operations.
Although this is available on current hardware, it's not required so it
will be treated as a NOP.

Return the previous set flags to the debugger as well.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7448c3e50620..bec52bbba330 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2912,6 +2912,8 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				args->clear_node_address_watch.id);
 		break;
 	case KFD_IOC_DBG_TRAP_SET_FLAGS:
+		r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
+		break;
 	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
 	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
 	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 8195f1d9da8e..0219032b9ce1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -23,6 +23,7 @@
 #include "kfd_debug.h"
 #include "kfd_device_queue_manager.h"
 #include <linux/file.h>
+#include <uapi/linux/kfd_ioctl.h>
 
 /*
  * The spinlock protects the per device dev->alloc_watch_ids for multi-process access.
@@ -355,6 +356,37 @@ static void kfd_dbg_clear_process_address_watch(struct kfd_process *target)
 			kfd_dbg_trap_clear_dev_address_watch(target->pdds[i], j);
 }
 
+int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
+{
+	uint32_t prev_flags = target->dbg_flags;
+	int i, r = 0;
+
+	for (i = 0; i < target->n_pdds; i++) {
+		if (!kfd_dbg_is_per_vmid_supported(target->pdds[i]->dev) &&
+			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
+			*flags = prev_flags;
+			return -EPERM;
+		}
+	}
+
+	target->dbg_flags = *flags;
+	*flags = prev_flags;
+	for (i = 0; i < target->n_pdds; i++) {
+		struct kfd_process_device *pdd = target->pdds[i];
+
+		if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
+			continue;
+
+		r = debug_refresh_runlist(target->pdds[i]->dev->dqm);
+		if (r) {
+			target->dbg_flags = prev_flags;
+			break;
+		}
+	}
+
+	return r;
+}
+
 
 /* kfd_dbg_trap_deactivate:
  *	target: target process
@@ -369,9 +401,12 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 	int i, count = 0;
 
 	if (!unwind) {
+		uint32_t flags = 0;
 		cancel_work_sync(&target->debug_event_workarea);
 		kfd_dbg_clear_process_address_watch(target);
 		kfd_dbg_trap_set_wave_launch_mode(target, 0);
+
+		kfd_dbg_trap_set_flags(target, &flags);
 	}
 
 	for (i = 0; i < target->n_pdds; i++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index ad677e67e7eb..12b80b6c96d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -57,6 +57,7 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t watch_address_mask,
 					uint32_t *watch_id,
 					uint32_t watch_mode);
+int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
 int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 					unsigned int dev_id,
 					unsigned int queue_id,
-- 
2.25.1

