Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F48DF433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B9D10E7FD;
	Thu, 16 Apr 2026 03:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4S5bGq8y";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7923C10E7FD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2KLOqggjgBSnkp7Q4hnn49rTILsIcqE6cH8V+pigi0sSWmYynTqrN8E5qWZHtB0lrvzw/rVCVeEeXI9VSF/Zc5Y5MHm9QXxB2SEa8OxEHYmJsuqRXuYS2Zs3zOK3aaCf35GHqRpxCOKTu0isteKQL1fuewoJJtHV6DtrD1+MNQUJWoyN9aQGnHhgpaTW4ZjNaMp9+Jjwz2tw77+TjbJg9lrqTzOKWDkKSkKVNXFIi6vS5GD65p0b5uqYOr2KN9Tir/Wj4615j7q1x1/+M3gPIbClyWT0OdKaqFW4RQZdA2vc8K/ZPn0bkvN+M8FwPCsfj+CE0EG2BEobvzGVDro3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqYNPhxCtdIPGZ1rK5Vf0//veFVdKDAuQRywL9eTf1U=;
 b=VxXUK7T6h0RhUe9HdlP7xzRQ2wqrIiB8ApTLj0BgfbQeFe4vPcdgGYpp6c69RY8BUgiarkTxi44SpyHLkn3sy37s44HDllm32fi5ednTy1bSBlzawcHy0B95yw6+fR9LZB/dmiY89qdAj27DuZ8lgmOermFA/e+1bxnyHDhfZxqA5MawUKLtzvMuzJrryd0GvPtbCENMFuA9kLNw87+89a7aVP8G04lsujlVfKh0OtSmGd3XChGWktoQ8np+e5fZhw/r/+2PlMEkJVPB4zzAUikJIvhPCHDysFaAI98MEDoYS1trwVkTdACc2epBTPxRKD3jo5JnNz+XRbMWfaECvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqYNPhxCtdIPGZ1rK5Vf0//veFVdKDAuQRywL9eTf1U=;
 b=4S5bGq8yGJK4wrGyF1+JGvEFRMGtgahCCo6Qi7vvINkNRxJmdQPcThkefLOOpRMBIGhwkKXUNhY40GR4jeJMy6sCkiJtS3FF4hKcgAs/9EMbUB74lyFVW85vDXF4jueNoSb+QK3y1skaub2x/cb4fobZNnpJRPRn5qtf6alrprM=
Received: from BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::18)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:44:51 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::50) by BL1P221CA0028.outlook.office365.com
 (2603:10b6:208:2c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Thu,
 16 Apr 2026 03:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 05/11] drm/amdgpu/uapi: Extend WAIT_EVENT with optional
 condition wait fields
Date: Thu, 16 Apr 2026 09:14:14 +0530
Message-ID: <20260416034420.2368152-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff6c50a-3779-48b7-8760-08de9b6a83a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mP4FGa3Ss4ezZGgOjznE2NWYJFNNKsAbKj2Yj1ZJMTE0r8usTAUTXnCwyl1H6XfhHRQUcyvDNGwGm2icKMCmHAYf2iKpQSEz8OqzjHGOYbM1uXy5C9hcOglJlW6lwdpBkLQwwcLdMAN9Jm1YGB6+to9SdTOhzayVTYZzoUZYlbpJyFrvTvCZIiLKTdpFiqU7d1M2FxiTiSRdaGUTwS4xim9bLwYiXByOBiLrF2GeCLZuzX8yhhbMhVxfPYmgUcjIMtwLEBoEXBIWhmiiMtPtaogCgfpET6dvzhp5uwneYVJB870NigjJ24sKasstOeB/Z6sFzywSiu9gGE6c9EnBMdLdjisBE6xJq+qNGn2Vi4Kb821sT77I4MgI4yX/g8ldKGjf0GOxQIba+1WbLLnJh9bsG43ZnWmAd/fzsCmm13eFnURcFPi1mdBFrCTxH44n2kcg89oRDK+e4J1dEKoXnLk0Lsc9O9ANqP4Iw4Rmdm4mR2eeP93TwuC1AFKqI9qKagQkqTtwjcJLB6UG9a5DExypVkHXvX6jWwoZ58BpFlupSl4lAF+64rwFwTdYTlM2O7SwyjTQR9NGCYllGNTayN0WYAtFyPdQ4uwdU0xETHjdHHgUaWBCF5aqifL1sPOPsvC+vy06KfLKun1k0+zdXRfJ7y5TBCSz/D0dphQCOeap/3rX+gvrmpRsoBhYJptEhBf4+4mXeJawuj+8rGlhz4HvC1dFRQAnGR4B8ZpJP4A66AZa0ceXOjJXfhR+Rs+JVhuDrQib0uoViUeks/85Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PBlH0JHtKwh4ToM+qlCjc4hIeimUEHAagrhqGswhmCWGBDsVmqT+WVlWRtiBBEME+naPxRFNbaTUhcRJ4CoAQW6ThviX3Udgk9hdB+Arp873t6IYG6N8vH4++E90CTm3/c0KTZ9jL1m2MXdK9mPrCZcKVzQ35nYkkcKgzvIPnqdhRCWdmTPntH6UiNBAvaVeKVShnA7rBRE+wsqwCAAFcoIyvCA+Y4Lh9vKs9SHuR1BLFXFOjZ6jl9yajRHszjclvwBcMoprSMLagcx1pgYG9XT5MkuayULRnbYk//dawPqPYIdmDBatOo54kLdWKRMo1SdJTG9GXZRxvxnPi6wbZevIh2npevTTTOsK9jifXYi64wFNM9RcqG46ckapzwkaTIhQfZ5svMSNHrbb3U6HKuSNhsCy8l4/TJ9Zr9uP9rLKE6bPzXxvrcF9zE9wWuE/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:50.9927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff6c50a-3779-48b7-8760-08de9b6a83a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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

