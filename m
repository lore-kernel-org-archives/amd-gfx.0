Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D05F43848
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBEF10E71D;
	Wed, 15 Apr 2026 16:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LNviuQHL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC5910E71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwknTnChi9Ah0xEQBwIbG0suQWXS1OLrb0x7YGzO8Ze7Kxy/N8TMP8z0vT0F0wVtidYkfn0postUdy7a6ErR3/uzAEmxZ2u8bPf7WJNpGktujDMt7DMcZV2oxgtk2jU7gPLS05ZtYWTbhmAo03CuVRbEZccrPNETNf2VHT8lFr/S0o2RLzMIE0cNyvAZcHvgyWk7O3frM5M4doLpDutmWHG1WmWs9VO7baIypgInh5JAOCr4M/6gMAXv07vWUsmNVbz7k8jG/h1GrmY9BZFIwvOaw7HxkHZsz5z0HodsIx1v6gkB0y1Y/JR/UgGbyG40Aai8xUMPMwltwF2RGHRQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkJ9YFrtSimEVEu/Oo2xeGjYhtE+PbI92QSpJSv0Qk0=;
 b=wZNnfSbVAN2d4pv8YkaSSG9m2+l/oNvB5hSbagS9rjI+xeKjlVUo3OaVnF06nbkZze1BZECn08ohRqmXgUlmQdsX4gCH9LnZb9XYRcnBfQZFjQHpdhNDzarbDYhqT9v+bjSnD2A820F64k970Hdwa5xiTdbrTtyzSA0AYZLjltO19yNMs/QR2Ae3UHQ+nCk03nx6nzLiAR2Ru+F2kMTwKP5kBWe0XHmygsdn/987R7flgYW1HHPy9+qO6TE/TzSi0kF1DWwcvgHUrN8H+DHXg0ekjICxOzm3kw9iSL726F7l4I9R1yYYywWOoKNwjb3wI197jPsHpjfVzUnRv7bZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkJ9YFrtSimEVEu/Oo2xeGjYhtE+PbI92QSpJSv0Qk0=;
 b=LNviuQHLj3DJlyddT4C0lS3vgGqR5xrMpGLznwBUz+E9KLJB9sX83DsEf6uO7FO9K0or+es9XsWqGfl/VCx19DPas5k2dUyrSxrl20BSuwUhqnOgNkJmb9nIKSkmOTd8mRYb2MWwVjeaBbIXwGxGd22NiRL0XVNN6DN4GOhsNhk=
Received: from SA0PR11CA0171.namprd11.prod.outlook.com (2603:10b6:806:1bb::26)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 16:07:43 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::ee) by SA0PR11CA0171.outlook.office365.com
 (2603:10b6:806:1bb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 16:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:43 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 05/10] drm/amdgpu/uapi: Extend WAIT_EVENT with optional
 condition wait fields
Date: Wed, 15 Apr 2026 21:37:06 +0530
Message-ID: <20260415160711.261553-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a5cb38-b976-4377-7957-08de9b09207a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dtOy18TLwbuVgw1MMOxBUdkRVsjkW5fhLrhQvDOTje2D++hubrzFJIZnvXNnZY84ihFltCoKU/IRjkKPe9Vw7StKSorBRB78YVo3BuJnjnmBmftu4wd6fhvbbjcTyPXEQUZExCBGarJpY309ZcLFFyEg+G+5IoNWd2b827hvpolpPYEyRw8ORW3OISGHFjcS082sxJhtE4dB6NI5Zro3jI8kcXkENDRADWrtYCOjxj0P0zp43E6cts3hjYsRrH17jQ/gRA+M0E6MpgDTRZhdKFTEBNt8zl5279l09l58SsKGrWT+fQfAm27zbTqKmCCXhXxKz07j0em1aRe+23laMqfWFXPLuG6YuzfG/y0fx8Itbp3471k1uV6DKVAqJLF6ONWtLx/445gJ6IhjXgTFHsdDx/jljGptjEsxnhCXMjC272QNefRlGzuYzP+XVksa32LIQNHHM2Gs+lAtc8CFJHJJSFpxVfE3wfRxIqq2ZGyG1jT2qOYYlvmKtPjvIqMkqcoBE2MHio9rGGcYsWTokAOyXyKvZL/ksFI+uxal8O5E6el6AL3acqpAd6qYnpVGktTXe3zmyJ+EuHNpXhS4fFlTTUJ4HfI4SY1lJ8FxFJLY2ZtPbrvtmMe9BR6TWv0NNG1dtVCFaehvDnnBPC8+zIJNW6S3EKFg57THLw+9b10eJNKNHFnxsEAJ4LLpF89vErnhk+bpdAsn5CndGBavR0XcqFlt9NsnmgIX+vs+g/PEBnQKZewcJtt2QSladFwdOGFMB9CevjCBdC3rd2mcgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r8S63vy+OKJuMfbh1DWfr3aL3ZZrhp+HD9ywqKPahb9t0bQrXWj1O1q6U6PdXkGewYyhD4nVUYXjS9E4SPXMdiKYsGIlR/cYIhvZYpLd0xJ33SNg3ttGdssFbDOKorDouN6iO0w65QRTZKy0K1leZ9AUEjPL287VYyBNlfqwyPHC1drzDlAMpUZkrpS6J2a7sfhmpvRs70u3vp+yMLCrYDuL09AFmomXSfUZnoYSjMGj/uu5c61p50ggmhSWx6w3WtPZy4YkKu5m5jcCHCUmdtZ13pSE8/vPTAgVmbsGt6Z9waqyUk8n1n4Wmz4JMEQh4P5iEXiZ79JHPoFfPI/tpnP/5ybiD+w2wNOq2sBIA4WisaEAwa4DrOQJTeoORnn405BUf8/XzObKOW1AVPPQL7kWJPqv5H8UKlWMSfqLdeqjAgEyNBS76LFhd3SiOWRA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:43.4491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a5cb38-b976-4377-7957-08de9b09207a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979
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
index f8982d75b1b9..b575e9de0c47 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -249,6 +249,16 @@ struct drm_amdgpu_eventfd {
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
@@ -336,9 +346,17 @@ struct drm_amdgpu_wait_event_data {
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
@@ -347,6 +365,12 @@ struct drm_amdgpu_wait_event {
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

