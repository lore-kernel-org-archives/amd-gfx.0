Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8197AF9D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 12:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA1B10E5E9;
	Tue, 14 Apr 2026 12:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k7nbZmVg";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D92410E5E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 12:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdo5eGNPCk/d73dVil0bHnPgiGuDkKnPJb4Hop3McZ0T7fawqGMCya05oyXO4J8r6bQLZVHI7tyC1ar3eK0RZvjwLtQocVqeO1agft/nouLvL5S8WTvUno6O8HIQ7MNSrsT2udoDxsd02iLeCKjvVRYgHHOI/htMbsYy0tXWzo3BKo4a7e/7M//b/r8JVhM2n54Gut/UbLqyNjzEyWG20Qfcq4nNOXkCfWKvfmo1YB3mxDKENIjQHBZMoJfw6pDElVwxOR5bGg13YjQd5ey3XLM0DmC86Bn/SkYM2eoLsWkuGTknsPmMju033rl8QuwqRFbwosaeLqwdAJvhXTkt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/DwWmO86QnEbHk0dipMznj0LUZ77/9yRhJuvcr6Oco=;
 b=IKbiPd9RvFkWp6WbrXiEeFCHr1JPoUmT7OA95OY+T8ri1Evx42iIdjyvIM4sglRfS+zWSszw88VDEZP3iAxn9q+9mtczus+J5GCZpDGqmDtY4sk5dOh54f4Bk2LhuonSnU7wsOHxdcIq09w//8LyKq0MXS6M/R/hB9oafzz64Nw11eGkjxByGsAO+TGOnQDD+C07ZeNVmi7PH5L0JtwO3PtWifFdW3bFviAtXH6nitUaeB4K9gReTO3D/MSEwcXMhvH94KjnHwZ4zoZgbSfeMCs0RuhyeaF+L4n+FP06GRT2eotUgiLRIRB3OaZjill4DSkVKedQJ2At+2ec9oEN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/DwWmO86QnEbHk0dipMznj0LUZ77/9yRhJuvcr6Oco=;
 b=k7nbZmVgHg9ScMCN3SlayuKvxLgYcjDmD+6WjeyMa9MOLcwgSzcs0fNk/CJF7ytXbc7Fo3q8rpSDGogciEMWb7s+/cRRZN+cPh741dT8fkURgV7yryoP6wfj2brmP9HyOyHUriZYbuny7iu5kbhbO0Og9g5kuUTPj20OceimK/Q=
Received: from CH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::17)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Tue, 14 Apr
 2026 12:43:56 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::ec) by CH0P220CA0029.outlook.office365.com
 (2603:10b6:610:ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 12:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:43:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 07:43:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 5/7] drm/amdgpu/uapi: Extend WAIT_EVENT with optional
 condition wait fields
Date: Tue, 14 Apr 2026 18:13:20 +0530
Message-ID: <20260414124322.2335906-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
References: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: c59da2ed-77e7-47a9-a544-08de9a237e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: XHfCjHJSxjAUEhyzhRXBChRpZJ1OV56EK/aJkbgGF9znDyVJPyAC4fC7OYvmergkRIqbD/LmM7T3nG+2GVVhbAjFiPRmLUXsgys60Jt2XcQjZGON3cz+rKbBN99LALk92YZQVfCOUUDnxZoLkyod6kMCq707Rc3HlLu8wdDqRb1Yqli0V001p3QpkhUR+16iR2d+7hMmrWFrd3mLb/1jxSzOhWuI1wLk0YnPF1MkT49fMheyZj8ulVnUh6sVV03KjhOMjA/DP2pg2QVurz+OtGOWnEyayWaxsLz1Ze1+6s/VAcyisFNJs/zTiuL1uX0AKcTyXXsN1lSlyzA6akFgpSPN3TVa4hUFsLImUmmk0On4d3hGalctC5VePFTijZ2Ow9udQxgNlGbwGT1e+CsxRPc+oylHwb0xUcQChfeG69ZyXaQAee+Cc41TKUkWFJrIziwQzBu0wnxEQZAlxre8HpzHlKM63DT5PcWvGXpKP/pCnqYswYPxj6m1ix+Zm+CQJ50o6H20603fzv/Nq+lNDEohvnZjL/0cPwdAb3HFZNszbYqSeYDXftvmi+1omFfqUIAhRad1av7Xt9zCvcABhRtY0NXtm+lIrWIHXTu6ufyEsPWaQvx8uVDoW1TArOawAMRrF0xON3A5u3BQ7vnvOuo7IZRVwE40BVrv/+pBPTjODy9xkDyykpoljmu4fqspJSoGR39zk439/xmLCnUuKgCk2UDwTKr4G332wV9LXutxOrhpQlK9Svjb+OE/IuJOHg//luNy90pTkVFMS4YWRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4FRRXbm1ZDqRzuDItTwLi3xnOZH5J4Tm2mrUKLkqNhRfTaE+ImpN0sQrd1oFNQSJLWGYJVI1OrsKDypL3b7J0tEgqEVfmppCobWj0tm6z8zC3B7fQWfTCfy4Omo8zNvXMp2UTvWm9W14ZAtqqJsJ0Ew1xnLLBXxS1bQc0TSOUIT666omcDMrw23ekVd9IM1L2TPd+gZndZz5+4QrVbUYCI4Y8VgpHbo+En2o/fBewdXVG99t173muvRY0whpSNLuoMpW+8g5PMEF8dferOcYtJfB7Px1ZuwSq9J0IeG4NL6lM0DFDJ4OAZHYeo+d3eAY3bkKGmIFu6Y29BH9Uqb+X8Vv8gBZPG14yz42J8Nw/q9AoTYCcDjii2NSsgbbedTeesEMI9VodY+yBB7/MVOM8VS9LXshRqj7Ym1XZmQpfBKisQgI5aPn/UCQfnB8fs0A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:43:56.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59da2ed-77e7-47a9-a544-08de9a237e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
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
 include/uapi/drm/amdgpu_drm.h | 42 +++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1ec371f55c39..1c5b77279a96 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -248,6 +248,16 @@ struct drm_amdgpu_eventfd {
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
@@ -335,18 +345,32 @@ struct drm_amdgpu_wait_event_data {
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
- */
-struct drm_amdgpu_wait_event {
-	__u32 event_type;
-	__u32 queue_id;
-	__s64 timeout_ns;
-	__u64 out_ptr;
-	__u32 out_size;
-	__u32 flags;
-};
+ *
+ * If @cond_op is not DRM_AMDGPU_WAIT_COND_NONE, WAIT_EVENT completes only
+ * when both the event selection and the userspace condition pass.
+ */
+struct drm_amdgpu_wait_event {
+	__u32 event_type;
+	__u32 queue_id;
+	__s64 timeout_ns;
+	__u64 out_ptr;
+	__u32 out_size;
+	__u32 flags;
+	__u16 cond_op;
+	__u16 reserved0;
+	__u32 reserved1;
+	__u64 cond_addr;
+	__u64 cond_value;
+	__u64 cond_mask;
+};
 
 /** Opcode to create new residency list.  */
 #define AMDGPU_BO_LIST_OP_CREATE	0
-- 
2.34.1

