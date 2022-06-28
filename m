Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8346CCCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DF010FABE;
	Tue, 28 Jun 2022 14:51:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2003F10FA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEKqWuJxvnwrYEpjQT+yYoK996D3qgTNlzXLiy3jk0gxruBr7r2l5muqUCMyqcpj0Dv8jQAR5taai9zIKNBR5cIft+m3cSEzLey1zdffTN7rHmRKd3IolxQsbgseSE3jqn5MOETcEqHjn5NbQDVVIsCJ+P6S4rP8iK+2E79Edose7tzYtD9liJ6ULUi3jwdVB/3p6z/Hh0OWyBNbsrFtyMuMc+n2i+QkLSfrjqu2+Go2SU2DSWot/yLD2NDuZOeKVnhVWaYl9TAug306qpPJ/Zqims3PyZMqBj1+IyFrHh8mAaO1M0x+5EhuSItEgfklDDf7zqWHfRnMLaFoIXBtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX5ZSdQVtP/T2YkFCQBWrQNqhl1A/ELhGtQsJXRuaJc=;
 b=NilvHaXeAB2XwiaxSDJbk2lCeo2b6KDvrrYyEEbSmugg+trdkG1vfPQKDWE4cwMwK6/F6aP9+zLEQAPYn4QhpKZRdE2WuYkp1cwR7uM2Y0JUbpX+gPmXZtn1JEz93dQS10r2Nf/cRGmDE0+gn7urCGcHrZyWz35fFIbpyEOizinFrkIMPteqEVBNm3pgT/OA0cVbhcbh3DOv6xzlMCYLPCWcwD4zrAnxJRUNSjJZR52+bB7CxhmKTDqhF6tgj/0z0sdd0A07SIHBoN+0TRyc/IYZcnlUoDtGnaFrGGBbpJe1igJxxGMI4M51TOAa+ntF7YOh0NepT3cd7W+gCkw4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX5ZSdQVtP/T2YkFCQBWrQNqhl1A/ELhGtQsJXRuaJc=;
 b=SOMfBqpQ8ADI2Tx2mZtS5I4C9LUnKaFarxBceKTcTu5w5ez1Sp4+PQcYJVkEqpl8q1Pj22XQq/muA40ax5S4vIg6ZNOp8qP7REs6qO4nKgRsyGfXgUuCrBcmTby9CI1OQ9RzLNqJqbbBoo0a2F4fluVMSCk9Ci3MlufTsp4UmsI=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 14:51:30 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::34) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:29 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] libhsakmt: add open SMI event handle
Date: Tue, 28 Jun 2022 10:50:19 -0400
Message-ID: <20220628145020.26925-11-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd4602d-40f2-4f26-c54b-08da5915af42
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RajjjJ8zEim0HYc/pfkP4JbkNFU7/CXzqJ7Rps0DXrwCTUykNiQOF1AclPDfTSqhon7ufdOAiaPuXRgLuDN/XGW5D7otd8gGdIJnWtULp28G+CKp7csRjrf/RvE7eEc7GojIQqRrOLTr6GWDW9/WJfDGBMB2AKBtdyTDVw5BA/JdNoGZXkA4fFg+dCDq7hfHQL53hIjvuMf6ZgfKDNl1ZwoK4GGSb8S1O+UA2OIdXgCI67omIq+Jkj+l5hX4rzqY6cg7WjxQ+Ftx5lSKH2lQrOisV9lhSt52spa162tltuDS7GiLjOEtQQm41FZl5AtOETFVP+AYn/7FdD3aNSsY08RkzBG8JW1KzBll5NMCca+GhB+n4W4qFJwFTrFupZlEhZPLD1WrvN4QRMw1RA+Oj1iNHTMUnraG6ipu3zmXlRlZyrNRpBuPp7NmmIttausbP8q9Vkkeyvw1+DG+nJYWwbkzDADO0l/7W1QbddY5yjCNQmZ/27x85z1O4R+9jVsVeJPbP/y7Om54HT6Vv4gPgtrOm6Y8Gi+25lxPbKtwQhOvMZyzSebSQKu8x/3iX59MrFoO6AkXJnFPXhvXkj+af30N1+aBMKrmyfTeqPnXntHWj1A7YRJIpc/eQlC7w7DXXrQTcsUpg1NUYP78PSLHvLshSahx2kgffpxs+vTiuatmxcx4tz2l7czSf+GOCWQ5f9kKmDNKdI60XE1yje//rMd0H119VgP42x4oD6p2irZgLdDL83SJtbJn7dHrkkXh+s8B/PP7Yjs5Xt6rRAQEoZ05QlELVe9UrrtExcAc/I9aQi/eh5aiTuyGsrxckmruVdAOOiuc0IrBjIKrof1SmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(40470700004)(86362001)(2906002)(6666004)(40460700003)(36860700001)(16526019)(336012)(54906003)(83380400001)(6916009)(426003)(47076005)(5660300002)(36756003)(70586007)(186003)(40480700001)(82310400005)(478600001)(7696005)(8676002)(70206006)(1076003)(4326008)(316002)(81166007)(356005)(82740400003)(2616005)(26005)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:29.4045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd4602d-40f2-4f26-c54b-08da5915af42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

System Management Interface event is read from anonymous file handle,
this helper wrap the ioctl interface to get anonymous file handle for
GPU nodeid.

Define SMI event IDs, event triggers, copy the same value from
kfd_ioctl.h to avoid translation.

Change-Id: I5c8ba5301473bb3b80bb4e2aa33a9f675bedb001
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/hsakmt.h      | 16 ++++++++++++++
 include/hsakmttypes.h | 49 +++++++++++++++++++++++++++++++++++++++++++
 src/events.c          | 27 ++++++++++++++++++++++++
 src/libhsakmt.ver     |  1 +
 4 files changed, 93 insertions(+)

diff --git a/include/hsakmt.h b/include/hsakmt.h
index abc617f..ca586ba 100644
--- a/include/hsakmt.h
+++ b/include/hsakmt.h
@@ -877,6 +877,22 @@ hsaKmtGetXNACKMode(
     HSAint32 * enable  // OUT: returns XNACK value.
 );
 
+/**
+   Open anonymous file handle to enable events and read SMI events.
+
+   To enable events, write 64bit events mask to fd, event enums as bit index.
+   for example, event mask (HSA_SMI_EVENT_MASK_FROM_INDEX(HSA_SMI_EVENT_INDEX_MAX) - 1) to enable all events
+
+   Read event from fd is not blocking, use poll with timeout value to check if event is available.
+   Event is dropped if kernel event fifo is full.
+*/
+HSAKMT_STATUS
+HSAKMTAPI
+hsaKmtOpenSMI(
+    HSAuint32 NodeId,   // IN: GPU node_id to receive the SMI event from
+    int *fd             // OUT: anonymous file handle
+);
+
 #ifdef __cplusplus
 }   //extern "C"
 #endif
diff --git a/include/hsakmttypes.h b/include/hsakmttypes.h
index ab2591b..690e001 100644
--- a/include/hsakmttypes.h
+++ b/include/hsakmttypes.h
@@ -1354,6 +1354,55 @@ typedef struct _HSA_SVM_ATTRIBUTE {
 	HSAuint32 value; // attribute value
 } HSA_SVM_ATTRIBUTE;
 
+typedef enum _HSA_SMI_EVENT {
+	HSA_SMI_EVENT_NONE = 0, /* not used */
+	HSA_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
+	HSA_SMI_EVENT_THERMAL_THROTTLE = 2,
+	HSA_SMI_EVENT_GPU_PRE_RESET = 3,
+	HSA_SMI_EVENT_GPU_POST_RESET = 4,
+	HSA_SMI_EVENT_MIGRATE_START = 5,
+	HSA_SMI_EVENT_MIGRATE_END = 6,
+	HSA_SMI_EVENT_PAGE_FAULT_START = 7,
+	HSA_SMI_EVENT_PAGE_FAULT_END = 8,
+	HSA_SMI_EVENT_QUEUE_EVICTION = 9,
+	HSA_SMI_EVENT_QUEUE_RESTORE = 10,
+	HSA_SMI_EVENT_UNMAP_FROM_GPU = 11,
+	HSA_SMI_EVENT_INDEX_MAX = 12,
+
+	/*
+	 * max event number, as a flag bit to get events from all processes,
+	 * this requires super user permission, otherwise will not be able to
+	 * receive event from any process. Without this flag to receive events
+	 * from same process.
+	 */
+	HSA_SMI_EVENT_ALL_PROCESS = 64
+} HSA_EVENT_TYPE;
+
+typedef enum _HSA_MIGRATE_TRIGGERS {
+	HSA_MIGRATE_TRIGGER_PREFETCH,
+	HSA_MIGRATE_TRIGGER_PAGEFAULT_GPU,
+	HSA_MIGRATE_TRIGGER_PAGEFAULT_CPU,
+	HSA_MIGRATE_TRIGGER_TTM_EVICTION
+} HSA_MIGRATE_TRIGGERS;
+
+typedef enum _HSA_QUEUE_EVICTION_TRIGGERS {
+	HSA_QUEUE_EVICTION_TRIGGER_SVM,
+	HSA_QUEUE_EVICTION_TRIGGER_USERPTR,
+	HSA_QUEUE_EVICTION_TRIGGER_TTM,
+	HSA_QUEUE_EVICTION_TRIGGER_SUSPEND,
+	HSA_QUEUE_EVICTION_CRIU_CHECKPOINT,
+	HSA_QUEUE_EVICTION_CRIU_RESTORE
+} HSA_QUEUE_EVICTION_TRIGGERS;
+
+typedef enum _HSA_SVM_UNMAP_TRIGGERS {
+	HSA_SVM_UNMAP_TRIGGER_MMU_NOTIFY,
+	HSA_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE,
+	HSA_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU
+} HSA_SVM_UNMAP_TRIGGERS;
+
+#define HSA_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
+#define HSA_SMI_EVENT_MSG_SIZE	96
+
 #pragma pack(pop, hsakmttypes_h)
 
 
diff --git a/src/events.c b/src/events.c
index d4c751c..06d3959 100644
--- a/src/events.c
+++ b/src/events.c
@@ -339,3 +339,30 @@ out:
 
 	return result;
 }
+
+HSAKMT_STATUS HSAKMTAPI hsaKmtOpenSMI(HSAuint32 NodeId, int *fd)
+{
+	struct kfd_ioctl_smi_events_args args;
+	HSAKMT_STATUS result;
+	uint32_t gpuid;
+
+	CHECK_KFD_OPEN();
+
+	pr_debug("[%s] node %d\n", __func__, NodeId);
+
+	result = validate_nodeid(NodeId, &gpuid);
+	if (result != HSAKMT_STATUS_SUCCESS) {
+		pr_err("[%s] invalid node ID: %d\n", __func__, NodeId);
+		return result;
+	}
+
+	args.gpuid = gpuid;
+	result = kmtIoctl(kfd_fd, AMDKFD_IOC_SMI_EVENTS, &args);
+	if (result) {
+		pr_debug("open SMI event fd failed %s\n", strerror(errno));
+		return HSAKMT_STATUS_ERROR;
+	}
+
+	*fd = args.anon_fd;
+	return HSAKMT_STATUS_SUCCESS;
+}
diff --git a/src/libhsakmt.ver b/src/libhsakmt.ver
index 50c309d..46370c6 100644
--- a/src/libhsakmt.ver
+++ b/src/libhsakmt.ver
@@ -69,6 +69,7 @@ hsaKmtSVMSetAttr;
 hsaKmtSVMGetAttr;
 hsaKmtSetXNACKMode;
 hsaKmtGetXNACKMode;
+hsaKmtOpenSMI;
 
 local: *;
 };
-- 
2.35.1

