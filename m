Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AE0FA3741
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F73610E303;
	Mon, 31 Oct 2022 16:25:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB7110E2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzK8UEdgo110ZAvw7JL3Z1lT9cvjPyms4HitMMCDQVsF4kuMSgMQNzc5uki2bNv+i/Hs47FLno8j1wwUJ1Bem44Z352iUpiO7DB9KIsOSa+cY5cQzJEV+OUlYdkM5C1XSaq3NOSdOQDf6QwG0H+1zwr8mtdtvo3nZQjv3PZuWw0DNPLUKiOPiLUdN7PO6Ou2xWdKCjJNYscS1Twpw4nakgesP5MHyAfejJDJKGWoR2v2sAVvHoOhj+Weo1PYGtSni+nKVSvhgAcNl2iGVqdpmhKCBcpfSdIGB+6f5iwyWiqlsNv9FNlonJcPCZ6F0bABMN+ySssS5H4E0YXENsL57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOmLKmhXggVitnoPv+7E/c6qAo338ewmtAPgsypsfXk=;
 b=ZFmVLIwbQKnMKbNhUmwXgISvT19SpRYFXawmlpFgU3qH5j1qOTcwBXYU/275EyVOIJjxoa4I1bs9+fAqq9cKj4uDKRnCBVQQUxG7ElPz/OPGnD/pKAdC5YdI4lZ2LVFWfYReEzFlCLLBa/30CcryUQI2f5blmPKg/zTAlkyeWe8tWNrRbeklZ8L+oFHVjOXKzUCS2x/HiECpmxesRkLhN2TWZ5XRBh6lVZky0A0gd8r9UPzO58Apc2JJryzUkcJGF1X0sbVH/FZ8VC4+LSjTpTjeNAZavTrBtY9AWaI4AtzG5UJjUrN/B7ziEfp1ynoHTCZIgNxjjmlHADUvHmUccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOmLKmhXggVitnoPv+7E/c6qAo338ewmtAPgsypsfXk=;
 b=xA9ZF2G7HqBZXssKrxjTxytRD8fHuEwm3T8S6H4lNsEk/KhHcqOejBMdgefEGGzZcJDjulXXfbmljgxwtgoiXzseuaxvmoRb2XLMDNw9cFg+sfFjHRSwWSevtvoJ9UHHoBvXB5tweYYUqTWGOGo5xk/ARapF1vN7iUTKDxoDHVM=
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 31 Oct
 2022 16:24:34 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::5e) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:33 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:30 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/29] drm/amdkfd: add debug query event operation
Date: Mon, 31 Oct 2022 12:23:55 -0400
Message-ID: <20221031162359.445805-25-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da313a3-a2d1-4536-7ed5-08dabb5c6571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Gp/7ovvdmjw5byELVZquLVI9SvHWzLoAyv7Xem7VRxDKSG30qBk/2I5ULtoPPcs+UCD01WOTrXoOf047UdIcVfIVrpxKDkP6tnRq5NC0UMXzQz0W4BH+uP3LqVyd1fmxSTsoUvwKO16JIDeXhMnEtpT1WTOvaDJnt4qeNeSolKEdrck2dg3UNjNmhtAM4XD3NsuwdcshDpHncXoN9BHc/Oso2U2I0GOXtL9tBFVQVcFBODsII0HerMJzJhBtRy59V6DmlBoMEhJsWLcrM2AzrHkTyfqrYlYel0fqLov1PoqS2CtcTdEcZd0YbxwxDjlhYHvRTFM6DRC8YhdQM8eEYuMizx+J4WPiIDpEOXcUxKEgCEKpRpPrRKmLc3ZVzIXN/NMVg4GKVc+j85Fu65cgDWOLlMSak4wsTaDvQVeqsLvtcOMeYppYrDnoOmGe7PNAbIM00HW/lbZLE4F9IbeX70UND2HdGTFpl/YDMnSeRdhnAiTJlglKCD9QhkcF8YfDMQYMx9UsivXM0oqF10Cpw/ssC59KykFIeNM+E2uBTHxS65vGvTyWQAOqh7OrEy3tc7ADR1CtHAsguExC2aefqw7ZDmyCbTO6seZfURXNl+C5CSmL0AB4/3LMCs6+fqnRIiNzZG4EoSJ3WUcMLZ7qhh0d7xPz8B5x76s5YH3lT4o2HdW+TDAEuVG2kpvl2eS5sUkB51sGf6rsh6CTYHQUo9492ow2g+OfDHwgfoJ+cWjAqjqwe3r1y8HLZvzHB4dkncKl3261CEUHB5e9BcIKo+8FUU7ZNYzAd9Xq+DspOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(186003)(41300700001)(83380400001)(70206006)(70586007)(40480700001)(81166007)(16526019)(2616005)(478600001)(82740400003)(82310400005)(4326008)(336012)(36860700001)(8676002)(6916009)(316002)(1076003)(2906002)(47076005)(86362001)(356005)(6666004)(7696005)(426003)(8936002)(5660300002)(44832011)(26005)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:33.8262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da313a3-a2d1-4536-7ed5-08dabb5c6571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
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
Cc: Felix.Kuehling@amd.com
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
index 200e11f02382..b918213a0087 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2946,6 +2946,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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
index 1f4d3fa0278e..6985a53b83e9 100644
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

