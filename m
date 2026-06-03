Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BAECD6E60
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00041120D2;
	Wed,  3 Jun 2026 16:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPSkGz5l";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A651120D0
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4tgIhm+MIxkdA6HJ1pU25MfbCH/0z+bb6Y2GcJKrIiZ66I5f1yiJQemV01wcQygfbmjwopEXA1ZxNfyK964FYaqP5pM7O8/LnSx0TBslrOP4q/Mb9OA85L3R7tu8HgPzjJWAb22tZn47uxFwaaXcVAcJWttcbTE1Q84sX4BUe3qQ6AaJKyF/PUWZfNZOtq9NclsXJ56IjpajwIHbxDr4qdg+I+ostsD+MUBsis2D9vu5ZbatLcOr2Tf4knRXScuUjdypJ1El+mzsW/OljvOe9Xyg/Y7mSI4h0ntQjL7KgOyYnmcLseJSeRTYMvRP+y9AEq/ujyMdVMTmpr10NNh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqYNPhxCtdIPGZ1rK5Vf0//veFVdKDAuQRywL9eTf1U=;
 b=YyA5oLFmIWEjOoi1Is9bJEz6DCipEbscUmItyNiWiEPOsXXguM+KOGHzejaHKXnW7mr/hP1N2Fn2ZzjGpXwzvfZ9frASNnH4XMUWXvmc1zs70mQa/Dn/cAF/eORUxg2koRnr7Wyggvee+jvSXZBOK5A56Uphm2pEmc519heHquJPAGxYTRWprmK7JVXhLgrPVrKSQOVtRx7iw7ZFaVzaTWWFzg+giTUL/zOo40zH6Ry9Z0fITVGTZFM1meDKwOoKAoV3AcCB099mwx/LGn9vAofeqUNwcvN0SaJF01UfUH2UwaD8y1jb/YL4YdLRPWunIJH9ucHP3Q8cShSflbU+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqYNPhxCtdIPGZ1rK5Vf0//veFVdKDAuQRywL9eTf1U=;
 b=zPSkGz5lb+Nj30pBd5sMAheeC+1USJWOLoIRjE7tVaon365/3oDF7lhjE2ZjXxr7fcIfnvx1LJMODx1UexcXTjEIXwrcg01ke59Md7GCnL7MQB024zLviBamDtbuTa+mDTLZb5TvVBtKqAUKtpHVMyTmb4zvPr4yIREj7hGK2Sg=
Received: from BLAPR03CA0086.namprd03.prod.outlook.com (2603:10b6:208:329::31)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:35:16 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::59) by BLAPR03CA0086.outlook.office365.com
 (2603:10b6:208:329::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 05/11] drm/amdgpu/uapi: Extend WAIT_EVENT with optional
 condition wait fields
Date: Wed, 3 Jun 2026 22:04:44 +0530
Message-ID: <20260603163450.2678374-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: f227e2ff-131c-4a8f-575a-08dec18e17dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: g4hd6wlTP+w42qo6/Qe96hLPmsho30A/GvZ5c6l3MMeBQXrHgBfRqVO3xU7qv7N9KZh/e30Rv47YWixGAGTVhjODqZW8QblWNkWQFwFMeqO9xM1cbIp3QuVtWoV2/YDcdSSAJLO6GFYS/hdmmZD3gieXTwxUyfxd7W53Wb0b9xkL42TiJM4dRCQfhRTbeAuCOCACJWdndNrZNnK+SHBO7PZKsSigdvp5BAnbUqqHKSM33QS7VSCkdRxxo/JkArhYwhu5gVGj+5P2jKkK5cpN7PnQNJ6/Z6m2SvATR+q7Alg+CvzYRuUoVXplaWQieVkzGTySf2XPe5ut7fbwB+i8RuZg3bXqOqr8LIrdDGXfwZ9IXaHVYJUHzPUb/Tfwr7d4PP6Aotck2/NVc+lahmaJhzPuHCdXQJYfM5amA0ip1f4S/He2Dlg3wOsV55jROx9Bt/DTTAZHNR8FaLZjy6lqD82udmoQBe/Vuao78gskb5yTmfO/2cIdgzWhp7e5BZ5fnCBz/G5Q2ztdTxFQkEtlPAPR2l4eL1paMJjAqGnUP7iQsAyr77z+Y6t3iXK6sYTSnOTwVQEAzLHxsgPBjW1Nzc7YqIaTEd143zsJxfkVVhnATS7ldRwhgflvTYcwhaQr8euSHHeB6dROtip8OviQVvc/LnWc7Oo0lM0I5M0qI1TDGrlnJ4TJG6DAUoj+K8X0Nr5XGYJDm0koqHcrCP8TbjUFJ73Ovn3hboT5wNAiAMc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HtAuiGojXCkmhtANveDHw2Q0RkeVW0OVzv+c21s9FPSuDiSVuEIW+QuWQvc2xm9JJ1pkaarXRonUTFyE5BmP7KYYo12mwSJIcUB+WkTDqGwEZa3sIb2b/0NAfUwEEofM0Cl8ADjbXWlazOJk/eI6Z3mreZ2B+KBQe7ZE7alq8QkQzrYCC77BmMD4wi24xP1HErc2R8Px5/iUgiLmdaCwdaPAgroVPRatkTW5EtR/XEEwKiK5jz5WSCf1GECGc6F75oy+tZfB2AoSfv9RodwDtD3gKWwSKwRZVkQ+1hbnbUDTF9ds/JoFzi3PVwTYLecHEeWIwNatXIJmNIb/yom2Stw43mwvSDCiti0xKkZ9VsEoZFJQ7I1VzifWRRF9CnoeOSctcKjnFD9JqV1mLg/nVf24MmRsRkYb4xyKaRVYMB6vRC/GeOWK1IagbPiOmzVx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:16.2723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f227e2ff-131c-4a8f-575a-08dec18e17dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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

