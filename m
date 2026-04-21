Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B0AF94CA6
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E8310E912;
	Tue, 21 Apr 2026 18:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3J6k96dQ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3EE10E912
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xibR4cZse0dgn6durcQrdwXBRmH4pkBXyQGeKaToZGzxuQwquSPGyrOfjG1UEnll3v7x9Feupt7jKh4iSKLSz44ZO+rEs/K2jv+BeUU6bCHfOCOvuGumn09C0q5LQ/KBh4MU46OAzkTK6CBwoRIL7vWOIUdMEG8KuBk+FmsusAuZkF+rsDNSmO65NhXhOZvVbBxqYbx76cRBwgpWXAfPf6nsohWw1G7QVBVocJN1qc9mCIm5RsSyAntZIeoZHIZZCkqQa+RmiWL0UO0hRgisAafA+uJHZNuRPv+9kX18AJ5g99BaIO/8ng2Is0hbOKoIKEfl0M41WjiEF/5QjVKhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqYNPhxCtdIPGZ1rK5Vf0//veFVdKDAuQRywL9eTf1U=;
 b=Bpw93BOdhmMx60ti1XToobSorKweaAUp9z0Solkn5Ul2QQ3m0tPviwLvPqcXwNOKTkElr6htKxnYMbCyfUkBSGlkDkJYy4NX/RRIBlHCt8CltwsbjFbgx1oJRrHnRijMzl8Vmj57XWrq2pWxDOJyLLdIuvMTMBh/oVaKo0sqnftozQKTfLNnAupG8lQz7OoZ3kBclkTDPA3g9VB7EygoVkrYQA10vUlsT4MQMuo6GrRpMHwKCyy/9cqsJp/DoJdwvPLWaQdMUmWV1tLlxs+LBRjDAmBKBCHsZjtht4Lvq0JsU/YK1476U4ClAnTMMR1GJGVlIz0DDoYDDFbfamsnoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqYNPhxCtdIPGZ1rK5Vf0//veFVdKDAuQRywL9eTf1U=;
 b=3J6k96dQWFCpgJddXLBO9+yAuPrG93YOEt1s+oDUyOe2SMos68NyJAjPUIYg0xmWOvv469zqqCF888SR7KlESDZsYgDMfJE01R1oFV+9C6cdrNHU0AgyLGtrzZWn3zF7j5UyIc7WPohUqX/ZN5ENsF/9a+q8C/XJ5tRoIrU+EX8=
Received: from BN9PR03CA0648.namprd03.prod.outlook.com (2603:10b6:408:13b::23)
 by SA1PR12MB9548.namprd12.prod.outlook.com (2603:10b6:806:458::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:07:47 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::be) by BN9PR03CA0648.outlook.office365.com
 (2603:10b6:408:13b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 18:07:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:07:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 05/11] drm/amdgpu/uapi: Extend WAIT_EVENT with optional
 condition wait fields
Date: Tue, 21 Apr 2026 23:36:21 +0530
Message-ID: <20260421180627.2402093-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA1PR12MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: d84704bb-23ec-4b66-6347-08de9fd0e471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: qjeIZPV/7oghYuODqnx5MgvYEaZjrPk8cQ+vVCSO+UskuUe8+88QMxRdf0x/ESp409pTgIySf0blYVRJGPcjlGr09AmT2kg+7T4qKWoFCTTypICXYGCD+pTcHcXGTyLVqH9RfQnkYbQLSZhZ07MCdDs7nRLTyseRg4ee9A/z+NDkxwZXUnJEzX/YmTWstL9T+Z/9/gYMIThwh5P59JiK/QKbAlInZYWpLdBaaag9rlRU230ju1llEBIuPxAaS+ewXfrQOoKFCNKrHkJqddOGM7vkSRBGwtSKJ/2bxo8MQprkwINW6/Lp+DbY/Cgrfue0/ezUFSEBbiCU5oaXDojA/nwE8xi8W5u7WsC2d2vy8SIAzRkBFqiWFZ93J8cJKGARimjh1VzQxt2vN0ea1Ks6U6wHub56+2/UURv1ueSViLF3I4fMBmh3XSfkAJ0DM1cauTSGEbg6eEhXOMhkDRG2aJXIMW7lEX3bG7HFbr8/1OJUqKrDGhREjaV8p2ycp/pTywbcWaT0JT1lH/eGu5AuzEnASoCltCP7knGYNMwBA0XIeHqcHt8EjHDFAaG3j3eDYTY0yd+FzZrmahprTss+30jWJ728mSMsYvDeukmcZ3MqwbZCot40728av55sNX2AeUKmKPhxm1jTfGasTvAGRehh32AGx64fPT0tw9MVfIdxqd1An/ibSnHE60A/xGh9vZ19CGLWWFNRnnMHgsqfjq60P4kc83pEiMylFFIXajINnL5DMoXnI+16J05QPj0JguDB+2Q0IVqkRBbNAhVD9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zbEBQQIvrDqibGB6R7i2MCabi2Un85stuwKspzcpaSCzDYcR6qwnIVUWWKh7mDuyWbG1GqBiS1no9Mew84MOJCUA2ep27auNWR8mdA/viMPcYRQngERgh9sL69Suw5FvNgkGwK1cFVy458rUDC9EHfwGet5knQUYwj+5NuoF8MPKx8eWlvWtDOa8YjNt5jVsayXFaLeYuN78nZY5nuThjaHbZsHkKXKWO/SRBEiXcNGqm4tgoYZJIt4QHrCff7j4sj1Mv/bTINXhdjCxTlGCmfoNf9ghInJk+hhIvWNEL8ZUkRCDviHjWhmmy4bJ/C2TVeBurC6jmJAKDPjT+bkI3GGN6Q29AMCTwKLGcHrcYAhXEmoKKgnWPX9y6kqxDUp0mhHSepdvFc6CS+EaP+hAlau3fEt7yvyembZTW7WAWI/VfPvJYxYTGzydUZDxU5DK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:07:46.7405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84704bb-23ec-4b66-6347-08de9fd0e471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9548
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

Extend WAIT_EVENT with optional userspace condition-wait fields.

When provided, WAIT_EVENT completes only when both:
- a matching event record exists, and
- the userspace condition passes

The condition uses a userspace address, value, mask, and compare
operator.

This keeps the existing WAIT_EVENT behavior unchanged when no condition
fields are specified.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d2038d38645a..82c6f3bd628b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -250,6 +250,16 @@ struct drm_amdgpu_eventfd {
 	__u32 flags;
 };
 
+enum drm_amdgpu_wait_cond_op {
+	DRM_AMDGPU_WAIT_COND_NONE = 0,
+	DRM_AMDGPU_WAIT_COND_EQ = 1,
+	DRM_AMDGPU_WAIT_COND_NEQ = 2,
+	DRM_AMDGPU_WAIT_COND_GT = 3,
+	DRM_AMDGPU_WAIT_COND_GTE = 4,
+	DRM_AMDGPU_WAIT_COND_LT = 5,
+	DRM_AMDGPU_WAIT_COND_LTE = 6,
+};
+
 /**
  * struct drm_amdgpu_wait_event_queue - queue-scoped event metadata
  * @queue_id: queue selector
@@ -337,9 +347,17 @@ struct drm_amdgpu_wait_event_data {
  * @out_ptr: userspace pointer to struct drm_amdgpu_wait_event_data
  * @out_size: size of userspace output buffer
  * @flags: must be 0
+ * @cond_op: optional condition compare operator
+ * @reserved0: reserved, must be 0
+ * @cond_addr: optional userspace address for condition waiting
+ * @cond_value: comparison value for condition waiting
+ * @cond_mask: mask for condition waiting
  *
  * Wait for the selected event and copy the first matching event record to
  * userspace. Matching records are consumed by a single waiter.
+ *
+ * If @cond_op is not DRM_AMDGPU_WAIT_COND_NONE, WAIT_EVENT completes only
+ * when both the event selection and the userspace condition pass.
  */
 struct drm_amdgpu_wait_event {
 	__u32 event_type;
@@ -348,6 +366,12 @@ struct drm_amdgpu_wait_event {
 	__u64 out_ptr;
 	__u32 out_size;
 	__u32 flags;
+	__u16 cond_op;
+	__u16 reserved0;
+	__u32 reserved1;
+	__u64 cond_addr;
+	__u64 cond_value;
+	__u64 cond_mask;
 };
 
 /** Opcode to create new residency list.  */
-- 
2.34.1

