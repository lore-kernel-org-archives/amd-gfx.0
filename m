Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1148CCD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC0B1120E2;
	Wed,  3 Jun 2026 16:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q4U5YwnP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221E21120E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQlIN93hEELfgzEiVKf867wjmEuAg2rpxlkHZ23H9rRFi8QVvoKTCsVBTgCeKiZsiNF0ayEIPpzAuMF/ov7o69lV3Bwd1PIvYqL9oKSNtICPFUzv/z0w8XhwgiNbIgPQP7nt0Aed8JZx0LS+4pfZz+GTmzNov+C77Lb1F9doYt405PgEs0TmvJphuUrlETGH01pPXPqTgnNlpjEJ+UL47UsNxIi4EmDUldz4Ua8/xEdVlPhsjf3MDolXEra5G1x5XJEgmpNGJrYLCqGwxSozCdtCuRu1Eaibb3UqpvL9I79yxNNUHGwpMB2sVlGjyx3m5E0P9pMK1Y4kIpHVBFJcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmeIji94cbqh/4YFhCcBNDJJyCHEFkG4DY9zHSWlX4g=;
 b=gVn6h/lDuQiqFdg87enNxzfT1lWtG4sh6filAKLVe05arWUXtSXPVzn+yBjAdnxEqtDNEBR05vp8HPcyRANth/Kos83glJ4TnwF0cVte8XQa+Z5O8SljoCx7K7c3VwhIK/mxfqk8vSGhfR8sLqXbDzBUccQHiUoeCLVPXErkl8grj6aujOFNE1uVzYtNh7GXa8CCOKI2mH2xremYaDXD0ydvB2XMPXmz8h5wTqbKb8IOJ5XXJ3F4ImrzNdSyVWMcaZ0Scz/OAB6vjQYlw1suGqtb7PLJL2+LhmNMyWhjy7vB52RkBKrUFtomBarZMj+HuJXPlncB5DOQ/C7rsierEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmeIji94cbqh/4YFhCcBNDJJyCHEFkG4DY9zHSWlX4g=;
 b=Q4U5YwnPAgHwzgJ44hfkHMLovOlwBCrlx6+6+lnFbPV7DR5FmQba2XhjufK6lgnpxlDrFrW0EhPFTXY3N3tZitCzNMG4muemLVm83oBWdw1bsAVT0wb/sDyZmUlWsTIaoiaALGEQA5M+TPRJV5awt3+h+iJltCJGlJuS28di4a4=
Received: from MN2PR05CA0048.namprd05.prod.outlook.com (2603:10b6:208:236::17)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:36:16 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::12) by MN2PR05CA0048.outlook.office365.com
 (2603:10b6:208:236::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:36:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:36:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/uapi: Add debug event definitions
Date: Wed, 3 Jun 2026 22:05:58 +0530
Message-ID: <20260603163602.2678435-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
References: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 959ce923-9222-4f8f-78c1-08dec18e3b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Lq1S6yS+3bSpz6xGUrtXT7VayuVp28w67hj+5MHuyiaS/xZ4z2SPpqtiOoWF0jtuYYeJbgeCZnX0l1NFw11v7d//sJM05hlJyoYuHJPqn0UkvqHKGlYRqO0rxY4vMmcXXm5PRE7RBnjfZLZpiw7zJCh9+7wqHJJsCflgRm1WXiF0VTi5HpXoWSiNEjr/WLUa/ozQWaTceTLMV6Yy3gYtjWv0TASlc/ZT2cE5yqy0eqHa+p1c0EYkzw26HjggBTThRjlDGoskHg19L5u3P51V1zv2Wed+YSYHTVByzoB88hiJdF4DlZJsppJPiaYR8XU4WWobO4BNc6QQ033tZFwTkSqeEFTGKPbN8yctQRamjQevjVIol3k565ikov4Wm6qOtKjlnLz0ny9jde7grRgodtKqrS3g+/1+zccWiLOOBhDj1Ht0EmpV43NQhLkVHbdB7BuRYarOqbN8ce0pTtVNzIfYPzilqDHzx4KwU/3zjTD6t5jS0dRNTXrJ/4Yq7BrCUlfuAhzJJ0z4e/xIDPO9ft7cOXQim7uVB0cbMc1nbK4lgp7zHy4zBav06fOU3GXMrjhS4v0H6smPap7skwOW4DtDVNVtodvcuhi9njo2ao+gD2gkroxPWAlBboqPlLNMsCu+5d2vY5+AtXMvQfHRuqMWLa/kkSbrHvvIzs9RiMZNbsworcg6rHKtA5IqKKueSHCBwvOA3RFe9xGRjUWacGgPhyQEC3kuG7//awtIE0w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ftrpo0YNBQWy7uK5bN9x3O6+FTW1VvTr4XZvQeDjgvIun9KDzaOT2aRFkQJYe8d2qFJaqUAig+pg0NG6GaikARpsAgfB7P3+CYeet6M4wapACGjage2AjMkZVIlaftPf2zn1UrVSxYzA31XZG1oU+DD2CBpi1KZO+lnSsZO+yyEu+I35bJ2fTH5Xu7T/06V1CkWoWv7lGCPR0nlNjDvsm5VWxoMR4YjgXLAp93/WMEurbTu18ECVRXhrt5LfqTlDxx/FePkDSvQEH63bWJfY93mghiUNu0LigDYBlr/YdXUPubIdRSYYcF0asAP0Rju9jTsUxJms7weX358bm/iw9XbPMK15Nixx3yXvTbRtVzQJ3BWofT9dCOjpAgnOVHlSPVWCOeAzC6J/iVr40GUUU/qIQPdVWdEfNsoO97f4cI5jutiSVqUwFDTg6iTqBKMi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:36:15.3929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959ce923-9222-4f8f-78c1-08dec18e3b1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
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

Add the minimal UAPI definitions needed for debugger event support on
render nodes.

This introduces the debugger attach operation, debug-fd read and forward
ioctls, and the debug event record format used to communicate
intercepted GPU events between the driver and the debugger.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 82c6f3bd628b..d77f724373db 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -41,6 +41,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_CREATE		0x00
 #define DRM_AMDGPU_EVENTFD		0x1A
 #define DRM_AMDGPU_WAIT_EVENT		0x1B
+#define DRM_AMDGPU_DEBUG_EVENT		0x1C
 #define DRM_AMDGPU_GEM_MMAP		0x01
 #define DRM_AMDGPU_CTX			0x02
 #define DRM_AMDGPU_BO_LIST		0x03
@@ -85,6 +86,8 @@ extern "C" {
 	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_eventfd)
 #define DRM_IOCTL_AMDGPU_WAIT_EVENT \
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_EVENT, struct drm_amdgpu_wait_event)
+#define DRM_IOCTL_AMDGPU_DEBUG_EVENT \
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_DEBUG_EVENT, union drm_amdgpu_debug_event)
 
 /**
  * DOC: memory domains
@@ -339,6 +342,55 @@ struct drm_amdgpu_wait_event_data {
 	} u;
 };
 
+enum drm_amdgpu_debug_event_op {
+	DRM_AMDGPU_DEBUG_EVENT_OP_ATTACH = 0,
+};
+
+/* Debug-fd ioctls. */
+#define DRM_AMDGPU_DEBUG_FD_READ_EVENT	_IOWR('A', 0x0, struct drm_amdgpu_debug_event_record)
+#define DRM_AMDGPU_DEBUG_FD_FORWARD_EVENT	_IOW('A', 0x1, struct drm_amdgpu_debug_event_record)
+
+/* Debug event flags. */
+#define DRM_AMDGPU_DEBUG_EVENT_NEED_FORWARD	(1 << 0)
+
+/**
+ * struct drm_amdgpu_debug_event_attach - attach debugger to render-node fd
+ * @op: must be DRM_AMDGPU_DEBUG_EVENT_OP_ATTACH
+ * @flags: must be 0
+ * @debug_fd: returned debugger fd
+ * @reserved: must be 0
+ */
+struct drm_amdgpu_debug_event_attach {
+	__u32 op;
+	__u32 flags;
+	__s32 debug_fd;
+	__u32 reserved;
+};
+
+/**
+ * struct drm_amdgpu_debug_event_record - event intercepted by debugger
+ * @len: size of this record
+ * @event_type: one of enum drm_amdgpu_event_type
+ * @flags: debug event flags
+ * @seqno: debug-event sequence number
+ * @queue_id: queue identifier, or 0 for device-scoped events
+ * @reserved: must be 0
+ * @data: original WAIT_EVENT payload
+ */
+struct drm_amdgpu_debug_event_record {
+	__u32 len;
+	__u16 event_type;
+	__u16 flags;
+	__u64 seqno;
+	__u32 queue_id;
+	__u32 reserved;
+	struct drm_amdgpu_wait_event_data data;
+};
+
+union drm_amdgpu_debug_event {
+	struct drm_amdgpu_debug_event_attach attach;
+};
+
 /**
  * struct drm_amdgpu_wait_event - wait for a render-node event
  * @event_type: kernel-defined event type
-- 
2.34.1

