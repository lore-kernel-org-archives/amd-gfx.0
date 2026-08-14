Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1A6C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 06:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9865D10E05B;
	Fri, 14 Aug 2026 06:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e5zo67ba";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8B410E05B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 06:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H50nGmyeEYrx42vrUq8TqauYuM5kimZzChQGzBV35+SnhtQwFO6zB9HHxlSlEW1wmLC8IkuFhyRsQGufzBWCf7hEjXwqryzsHHEHDgrQCfkxGXIVT/e8u2FX9wxrbUouPCQse9argcW1+tBreAKdBFCjSQ4uzMQ1a0v16K9mJTrfR+ajL7bF3E702DDKgzLPXK0p/QwsN75E6fde125T/FfQ0U7/95MX6Fak0cKirsSquc73YFjLHPYs5esOiG4ETCIHdx4+GBv6nnR8/GdSUdTIFhzuutJ/vhVP2t7AeTkaRTuaaJAqiLN0tIZehCwLkrbkYerFBtDOaVOemo5qOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/V0n3vILd8+9SjHxPofZUUH3WOS0t06o25nl0kjPJk=;
 b=uU16P+k4LJFYSEhVcBT0rGCYLhGZlwNyxA8OiwiNq2dmUAiDAINN5J+cNHFll4KLN/mOfmxA5Ygo0eGJvnihnAARRco2S5oVBbRFf4OqTqCmBEs456RdqpyOE/nS3FGufBY84zCJMpwzt+4MQwceK1cyQXW3Fj/wTSc/vmIoJeKwtXJyumEZZQdupOxdVdHtgkHjcC90Sn5h8eNWYGTio6RqKNgQv9gs7ojTSf8HdHHqdDqumMIr2h/nriPKH2MaSM/2v3XoQycoCZ2yiAm6rn2B8dvmVf4djntzA4EcUGVyNGztSUzPCyML5vW31PVzj7UFlBYe/jDzzH0olWft+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/V0n3vILd8+9SjHxPofZUUH3WOS0t06o25nl0kjPJk=;
 b=e5zo67batSHpFdO4nAyiVZlWLOBi6+rOn929DPTM6N7xcFvWyRD9DLtZcD5BbhVV+4bq1cuDe1OypFtlcrurF0yaf/2vkVZ6IZnhDurqnG2EKsQtuiE5yPo9jtwfmsRipBeCfXavIdokXwQLh/Hx2Vn+VZoAXS69QthtbG0wHco=
Received: from BN9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::31)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 06:22:55 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::a0) by BN9P221CA0011.outlook.office365.com
 (2603:10b6:408:10a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 06:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 06:22:54 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 01:22:52 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add UAPI for user queue query status
Date: Fri, 14 Aug 2026 14:22:41 +0800
Message-ID: <20260814062242.407455-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b55dda-faac-4554-8f60-08def9cc79b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|11063799006|56012099006|6133799003|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: FseR/MLHLJTQlDnexjWcKocvrMGlqAMdhKof7PC8osJbyYXul63+1LCf0jqyLfStIkQ5TpstAyjAoeR8ckQD5HG/Svw9M2nD6hUa1TQyb7niRI9Z7eD6l/5EYECdsqkn5dKXPf5CmZnSk8dG+peBwApmD5w1FnTeSd/+QgEoRgSN0Dzjkm2oqjXj1PQQo9LYnYKqf3FXlTy+pFAq9ugt6oTwpZElHsy1AVWXFRixQt2oqQuhnJ3M/wtmowlq4F6StZHIAA/nsvkYL1yLuOJ1ya9yiazdEFjlVsmpgU6OyLE+oxuJfaW+3PBIM1GCOKOYlMUY5E9R+MVnMqCjc4i1/zZSJkjupbmd8lmP90QWizOKOMN8CtMHcSbXZ8zoIFdx1KBKPQNFGlMc4F2LEPeLOhRi14wxziPh2ZMcUUZQE+I5922Cez9CB2FtIKrngH/xwkqOezrL6y3hkytFpUY5PfbijxbTAaHxPHkI4KWlTywVJXn4GOqj3QuXGhdRrg9LBkh1zODAHKpNqrcW9xyfLYx8LAudduPvvNWz+9xinQHMMrmBq4XLIkOoEue8hnQdaiO0FSmLzJueTn1WUWCSNyMw6I9FL0U1gwDt5FM4YryNsKurPbvzRnnx/sFE2ZvEQwCrnRY1ekJ9rP0PI+/XtoBmXYOirI5c8/webowB/ZzV3EqQao5XYyezh522XS6opKvS2920rugubfAfGPSYFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(6133799003)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mw3nQAmJoekmfximn9dZTTe62PfOkA3x4ORKpt+z0kohcPTqzMBKQvLgeXcbe9BMl7phu1zYb7AJHZRujzIqma3FpD9d9HUfZMJZ5XGYFBe2Lnz4XhFS/hzBCVY/Zfo7LN2fnIDhgQi6F1VxSdOYjYCjYVEk8308BTvS6VDGEcC9YDZgZOf+SAKUH1nHl7/OAnGq/DVYC9/5BmOShq2GrUaEN6ujF/AZZJ7BegQyc7b2QfE6asMIHi4jVGfyL1KlkWFYf6zYc8yQe1oGSHXfcvmJF2fTZhvefeFp23RcEbvBppFNDx9y73IK8FOY1JU5wrfejNR/5kt6n9RGaQ56yPpJyMyFFG8tM2J5pb3tVR+ZKeNR876WQOCYDr546taLlBIieU50d9oPvNk7VIxrNeRM9lfSXZ3K/46tp4H5+/zCpSKRHaV/Mza82kvUahav
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 06:22:54.3538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b55dda-faac-4554-8f60-08def9cc79b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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

From: Alex Deucher <alexander.deucher@amd.com>

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0a113529bdcb..15b0ccfe00e5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -332,6 +332,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -344,6 +345,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -425,9 +432,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

