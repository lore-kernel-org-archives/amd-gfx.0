Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263BCECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C07D10F334;
	Mon, 29 Aug 2022 14:32:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9921E10F300
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKgEtGrIm45xzwj+TwdTb1fjhcEU/iv5/5yDve5lW2xz509IxXqEvcf5FSiQdary1mAtmTn8pcY1YLiaEf0203Vz98dscvMVScfX9Zy2LUy4GC0SHMB//pK4TweNV7betvNzY0uLN8eObTipcfIIO+QQsuMsBnztKoNQ9KIyhj79gQASDH8RYnzOBPUGzNsj09ShglgP8OK+S1hQY8kOOpThFHIytlb4s6WQSGqLIM1VMRtLmX1PXdmGzPDGIuQgWK+K6bTaMqNae/SKEa8zSRxbd++Ux/N9/BSFbN6uQdP5SZ5LdL6SBlR2qhQ8ej2CLRezQwJfYFt7LbDMcBdSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjNbmtTVozeP3nxYIdR9NOTwoq38/KK7v6qjtV5Givo=;
 b=MQjz3hRWTSxbQlb1Ne+SA40JsPv+qlN3Mf8VnjPnZbco5xo/QebKJ4fh6DXLD+m/Rp+6ZEtwujENJ1XT377ci9fhvV79mHVdb+yejBn461kje79ggmw2G76FXNNHP88/CuTG52QeTP4yOKPG8Ho6z2Ef/qTObEEO+dxscTUwiiyKO4kGWa/3nPNKhTeOVP8iQpR3JQi9UIRCigPy5OoTZkocxShB2HbQ2f7j77iPJ0kKRApyfAvUrMSjlN7+mBRhbn3K465fiAWHbpCi+PU/p8HDnWhie7J5AGRP2gmQDr5NwBs2SN4M0XzB5rVbKDRGrZ5GcYqUtjqt9dOiW8c7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjNbmtTVozeP3nxYIdR9NOTwoq38/KK7v6qjtV5Givo=;
 b=XbMnBP5u/Uakfjh8LkUX5ebrjihhkw+IdsunTup7eQWT04JPLhiHBU+SjIb2hojd+dUij3clkgAOBjk0DeMRExqulaI7na+yTC887W5yhkcCJZwde1KdibUZYuiGBfwazDe+Fg0BzHndOxYe3WMEfu4WHI0EsJa4pgTD4wmLdYY=
Received: from MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39) by
 BN7PR12MB2641.namprd12.prod.outlook.com (2603:10b6:408:30::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Mon, 29 Aug 2022 14:31:17 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::3b) by MW2PR16CA0026.outlook.office365.com
 (2603:10b6:907::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:17 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:31:11 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/29] drm/amdkfd: add debug query event operation
Date: Mon, 29 Aug 2022 10:30:22 -0400
Message-ID: <20220829143026.1509027-26-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 97c9953f-b868-4530-9744-08da89cb2244
X-MS-TrafficTypeDiagnostic: BN7PR12MB2641:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRg47ZXsuMBn9Vv4UbPhiqra+yNBZCTVdLOVT86MtMTNe2lb3qIGeeL7mL2tORzybPU+s767clvFFK4EwuLVRuUmMxN4MfaVpkILAIp+JYS3yMrEeI4MwZ1Pe2B1/nY70w0R/BphLuln/48A41jbDdI22PE93mKqcMuCh89/cEDwFH755ZQKwO8bf7MUR7Rat6R1jTiibrcE+OeyKNnG/CyOQoCfm2NrLGkqSwaRZbJ01RYu65IlSy1ZLCztFI7PCQT8lDGfg1uFPbumR4KIe2WS4gnn6LmhEHytFh4blkN0u9hsxhH36o7i6AGooqXr3og9DTZ1vK0lQG+xDP3BLQsMrLloaSAYVvC+irGRP9sbq2ZRmO1/9AVvlXQZKfI8KxgNy4d+pr4C0CdKlAZR7cTiqwdup6EU+BC572sw4q4nQLq6FOu/80sc8WX8iQR5dNGuoBl/5BrcHP6/1fc9qp9CD/gtXedr27XU3HfLRDjhrLmnC+26d4spdq0n9sCldKuloYFebbA4q/9bgh+1bGSbLSnWqS02sR4JVBEWSKwX3qmp0sVamsDD+iC3AbikvOJedQdcMQzLsgr1CKKYbuldy3aSy9Wtg8CGczea7X9L3tHo0UB4dCnkWIooUdXomW0NjqoWyurl2sghK4rU9aswj1HlgQPKgNtsJhKXopEUdHyMQKd8R8qYsBtVwFWTpKoW7mE5LySyT4gCiXeKH2s9gcg43FEMO7GCYW0T03KQOwngH4mklARogTiJWh1/J/ObZ98R+ryb7ikUkECvPjsgXC5Ac1p3EoOfpRTN6cdEWhRetxqRlpHu0pkIfcLY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(8676002)(70206006)(70586007)(316002)(6916009)(54906003)(4326008)(40480700001)(82310400005)(40460700003)(36860700001)(44832011)(8936002)(5660300002)(2906002)(81166007)(356005)(82740400003)(36756003)(6666004)(7696005)(26005)(41300700001)(478600001)(86362001)(1076003)(16526019)(2616005)(336012)(426003)(83380400001)(186003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:17.0914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c9953f-b868-4530-9744-08da89cb2244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2641
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

Allow the debugger to a single query queue, device and process exception
in a FIFO manner.
The KFD should also return the GPU or Queue id of the exception.
The debugger also has the option of clearing exceptions after
being queried.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  6 +++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 64 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  5 ++
 3 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index bec52bbba330..042cb0f6426b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2915,6 +2915,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
 		break;
 	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
+		r = kfd_dbg_ev_query_debug_event(target,
+				&args->query_debug_event.queue_id,
+				&args->query_debug_event.gpu_id,
+				args->query_debug_event.exception_mask,
+				&args->query_debug_event.exception_mask);
+		break;
 	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
 	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
 	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 0219032b9ce1..3b15159421cc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -33,6 +33,70 @@
 #define MAX_WATCH_ADDRESSES	4
 static DEFINE_SPINLOCK(watch_points_lock);
 
+int kfd_dbg_ev_query_debug_event(struct kfd_process *process,
+		      unsigned int *queue_id,
+		      unsigned int *gpu_id,
+		      uint64_t exception_clear_mask,
+		      uint64_t *event_status)
+{
+	struct process_queue_manager *pqm;
+	struct process_queue_node *pqn;
+	int i;
+
+	if (!(process && process->debug_trap_enabled))
+		return -ENODATA;
+
+	mutex_lock(&process->event_mutex);
+	*event_status = 0;
+	*queue_id = 0;
+	*gpu_id = 0;
+
+	/* find and report queue events */
+	pqm = &process->pqm;
+	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
+		uint64_t tmp = process->exception_enable_mask;
+
+		if (!pqn->q)
+			continue;
+
+		tmp &= pqn->q->properties.exception_status;
+
+		if (!tmp)
+			continue;
+
+		*event_status = pqn->q->properties.exception_status;
+		*queue_id = pqn->q->properties.queue_id;
+		*gpu_id = pqn->q->device->id;
+		pqn->q->properties.exception_status &= ~exception_clear_mask;
+		goto out;
+	}
+
+	/* find and report device events */
+	for (i = 0; i < process->n_pdds; i++) {
+		struct kfd_process_device *pdd = process->pdds[i];
+		uint64_t tmp = process->exception_enable_mask
+						& pdd->exception_status;
+
+		if (!tmp)
+			continue;
+
+		*event_status = pdd->exception_status;
+		*gpu_id = pdd->dev->id;
+		pdd->exception_status &= ~exception_clear_mask;
+		goto out;
+	}
+
+	/* report process events */
+	if (process->exception_enable_mask & process->exception_status) {
+		*event_status = process->exception_status;
+		process->exception_status &= ~exception_clear_mask;
+	}
+
+out:
+	mutex_unlock(&process->event_mutex);
+	return *event_status ? 0 : -EAGAIN;
+}
+
 void debug_event_write_work_handler(struct work_struct *work)
 {
 	struct kfd_process *process;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 12b80b6c96d0..c64ffd3efc46 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -27,6 +27,11 @@
 
 void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
 int kfd_dbg_trap_activate(struct kfd_process *target);
+int kfd_dbg_ev_query_debug_event(struct kfd_process *process,
+			unsigned int *queue_id,
+			unsigned int *gpu_id,
+			uint64_t exception_clear_mask,
+			uint64_t *event_status);
 bool kfd_set_dbg_ev_from_interrupt(struct kfd_dev *dev,
 				   unsigned int pasid,
 				   uint32_t doorbell_id,
-- 
2.25.1

