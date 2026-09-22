Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D7C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 07:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4919410E422;
	Tue, 22 Sep 2026 07:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgFik8Sl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D7710E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 07:59:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJTg8xZDcAHU3nyNuOtdvqxJIL62LWEu7TJclTc9Tbois1buoQTCIVjk8Wdf0XzpwBE5PUp/F5pZl69GzKC7QrjCwUdZcAX7BlGvWqwuWGTYYv0toP+bbkhCRBXtcdcwKp4JPwA+92pfXd3jzUnGpCkdMKFr/G5LLOt4DZHxvqNTLc5DAdzyykD7ijAd5HqNU4Kb35SH8/initeZ9Ny5QfcEet9Jlg5Btkd8a6M/FuyQpBGlLJ4v42BatNE1iqHM9v/k/diMjBurgMXSHy7cxxo4VLuZmNIz9M86Bv3SYWE0QzsNm267f/JHVnr9JLTV3r4+dkBkQyaekITktXa0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty4gUAxk3ffaaMg6U25/9VVHbExo5sIRPOWEHW0Cwx0=;
 b=A5NwphpXFdB2qTzzj/s1RyEloDTawUcTltM/qf+ZHPy1PBpWzIAE+c8CALUWey20RRF06Q/EGkJ+kBd8LaWA8LfJ0Sq2PPkOOPpRLodENioPpaffmtcvdsVpNo7QMqnxECCnNkv9bKLSyndOmrjk9H5hQD7vCGLLdy6dU2fjtD3FlXVTPP9wTvQeq3YnSwvHa/Q6lDokb5LF0yeaj7xeuIXzlxvoxTpOT8IlpuDcRe+ar6noXxrt4xiOmXYaibk85MfW5C6w51JeZ3HjOZ794qgEcE8WqzgGutS4i5Q58/29F6PtKwmicZzDUoq4CwdYRV+Sedsh1jM+aP0eCB5pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty4gUAxk3ffaaMg6U25/9VVHbExo5sIRPOWEHW0Cwx0=;
 b=sgFik8SlUTilSAWZi+K5lI7r3PWvdVcf9CgaegU9DZeJQ0EpZiKQPYjhhb23q1PUGk8sfW8f5hT67oNc4TcyqVKjSLETgJ8tsPHdvAm99YAVx1wF3HLCNKMmiYAnmNVCFkUUwTSd9EWqMDhqPQzuLTFWFkKhH8QkR1vhyxhYJ6s=
Received: from SJ0PR03CA0155.namprd03.prod.outlook.com (2603:10b6:a03:338::10)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 07:59:04 +0000
Received: from SJ1PEPF000037B5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::60) by SJ0PR03CA0155.outlook.office365.com
 (2603:10b6:a03:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 22
 Sep 2026 07:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B5.mail.protection.outlook.com (10.167.244.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 07:59:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 02:59:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 1/5] drm/amdgpu: add UAPI for user queue query status
Date: Tue, 22 Sep 2026 15:58:48 +0800
Message-ID: <20260922075852.2335748-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B5:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d06e84-0015-4d41-b423-08df187f5ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|6133799003|3023799007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 5+gIKnHiGJbw8jL7DDpucnyVeFUWbQlVKOdwLxgkhr1jz0ytQJl2Ri7SZ1k+UoxsC3yyCXeq1P6KGpoU0xji4a91deDOHc1W7mTEHOPcDbrcaA8JaRPi02SXpXzxRUbIZ1ssrCyV+3+uef6UFdqRSQzUnCyOwZSYDQ2aoPO4Jia9mchVxSZ+A5zv4Y3aoYLT5+hhHHEw5p4wuYEACn8mFb8AugyeDB9Wq9whVhpBOb5r6ESxy+EwgVjpgFfHsrw86OXlDDzGlZr/M6z+Z466pk30ea3PpaR2MmBFQp2peRkdZ85PG75ndWelu9yzE545KDoCMiMCOqhFCIGIXl1/GCmye8ARhRcg4ePCkbKf0uf+mJn8835TFqlR/1HoDpIcBiFBprK/NITjlGVWXaMBET9Mm+Lo+Kuq2wGcBIZzhd64FmV2alZomgqMQncRPoItRlKdYvAPHhu/2gqzk0OowUwiAWe64VvE0PiVBcocmwLx/E+YNRSU2zh7WU/TqZjSoDOXrK5X5Rw7HUKdoKUiFeI5LlKyltd7L2yk/8i8H+FsCK4U5Yr+rTeDBf68Ly62TqqT6oJ7vwN7N1gpD86ja8A3OYaBNwrE75RwIr6JK6aJATwPiE26GmThAAsUcbxvvOdP/Lnq0FPCrqcTHsNFbkr6AgEgHhVco8Abypb5sGU5hEx41Ytb4zTFm3nR08U/dNo48zc6pIhsYBmAxLdP+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VCrPbFs5qkavQRImYm/k6VFzvpxtRvNzsVZXt15YkIcYswUheUp3JI9R2VQjBH6320hf4IETHBI4lXuzGnpU3p3ndWEVYMwkPujbZLM29ozDrgF7kaeKGR+bXYSyO+WfBZUNlI3nu7wEGftqcmQoPAL2yl6C2nmiE+cY1G6LcUS7GSePUgUbnSTRP7R3TyqmTX8kctyhEN8iqqryuJn4nLgFHRiTvnMQUzCROwgidGzkhVm1wYdtAPu3kp5qB2gIs/L8CNe4rpXrGAiR5jcc9ZT9I/YWphEoHSd9fU67QkrZAExOlNy/iY4y1mgp1EOk0VgcaLFxK+Pbx4owsQzsvXcjOoTboRFyAVb2PMcAP+QsGU2B6EwrO7Jrsrc+BRloOGOyw3iOP36qk919H22LLLJMuV2FZ6rXd/Lf3dFnZTDB3cQPAbjJBtZ1waZbTX9n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:59:04.1018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d06e84-0015-4d41-b423-08df187f5ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527
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
index cd1b8034a2fb..183ac26f2bd3 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -340,6 +340,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -352,6 +353,12 @@ union drm_amdgpu_ctx {
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
@@ -433,9 +440,16 @@ struct drm_amdgpu_userq_out {
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

