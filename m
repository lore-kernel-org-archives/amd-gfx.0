Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF0AC88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F74910E7CE;
	Tue, 15 Sep 2026 07:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E9ZknUro";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA66D10E6E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXWtTf2Gq5EBDC5tXNatBsVMDUdIBfevcOp4szHCvWFGZlls57bNNzNXEgN4ZwC3Bo6K47eVqgjr3Pixj6h8QCWIR8Xfsel53vdRHpyF84q1r6BUZbjREB2fAymz75NrdMJ/ROfXBWr7tXbsoJUH7ziwiLw7vaVu6H5BFPDVCLFTryJIPh9utnWC1335bM8EqjjoACwIHdCf/c9PSKg9M0awAQP8cM1awsbFDxqR5TVjO2oNk68Br9PCK8tknNrfKlDdrfdPO0xmLO6oaFmWt39vGqF8HaZ+p5Kc41gvvvt/sp9Mq++/YZAK1TdCdP6xDeVGui7RdnGPyiLKZ5LDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty4gUAxk3ffaaMg6U25/9VVHbExo5sIRPOWEHW0Cwx0=;
 b=KVaLoO77kV1HM2eu17rYpqAHe5u54QEAECk+QjoJLlxs9FcjJM9azQLHTUROu9ArVSZXNh2bv5vfgxTHOEzv18TEu1xxWelJcIX2v2OUVh2wvVnBwG/iCZfqzRklvdCyc10U2PJecqDUGlnDS46S7gRZu3xYsceVtk/5N+Gpg3SBPlJYu1rfWUyHK1ES4b7k0rqTSFSMnIz3dnTieH+9mqVKw8NjYJAdluXapSLfgDzxerBGUIuE3eTI5kv3ZMUYjLbXm2yxlU6iRwgm2zXXzFIbJsYyFQIYzFaPSVh3YP2cHtRRPOwmTxgjA6EREGB+6EEON9LK7c/80vclmQti6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty4gUAxk3ffaaMg6U25/9VVHbExo5sIRPOWEHW0Cwx0=;
 b=E9ZknUroBb0/8G/M1NVYOugyY9ozKebtn21/3ACwDxBYA6C3QO4MxhcUn0QzWEGHEY6L3+6OKOxTyW+KhYRRVK9G5/VXBP9EkQ4B7S/6nhr4N2OOk3d/q1eisZJRqwSley7xx2/OoKIfCSpAo0c5p8xYZUAg8e+k7lE10sIP0K8=
Received: from CH0PR04CA0048.namprd04.prod.outlook.com (2603:10b6:610:77::23)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:19:59 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::aa) by CH0PR04CA0048.outlook.office365.com
 (2603:10b6:610:77::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 07:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:19:58 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:19:55 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu: add UAPI for user queue query status
Date: Tue, 15 Sep 2026 15:19:42 +0800
Message-ID: <20260915071946.710846-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e4e731-1c37-479a-302a-08df12f9bfb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /x8cf4g/QLn0d5Z/w5lc8WkJWGUcXa3dOr9B8NKfSUQwW3TsInzgM/6Ww8lUMKhG9fxtcu1h0NjsQd/4+DQIWsXzTfYUYBkvzNdk/1t90R6pEnKfXOdCCj6fVHxxv31eJ8dFyLvxtH/KrRLWEhFVfFIqp70b6I7kWm+cLMnBgW6UOmYMe6wUShIRyubmjO8VPmvYaDqC7iMZkst3o0CAqSt0Rd5S3YSQRwbGNW+ifGkZvRgyem7esV2CdWRvcUvR/ZGN5/GOFJ6sNhx10Sl1628q4xkjCk7FKt93LkOW61DJAcwhy6k57N9WvmzGkaoUAwRLBvFgFxpywxzy1RR37Tp4WVDa+r5UGglR9yOidAq/DX7H9LH7x9z5kBPpoma2Eb8Krqj+nBmpI229JdTm47biJMlu3ANRLziSer/gr2+PdXKmi7fNL10YHSDdi+d01aS6Xm3fvvEWO1KjXUyvwsLhhSAAXP5K5FNgm5qhSFJpyrGEXClcenMTU4OL40a2V0XkO63tm5mNMunjV+1Wc+hYXWYSgaStp1QAP9/vLZn9tgsv+sUQbBmm7oxXgaRv85nY2nI7zPN5fSJA2YZVyVLAh0DdubqQpvNrAXooUf4r1EIxUqwnu97bgAOPVoMrbw9oVzflX5ji7m9S32yt7AXSOJWSjPpsjqk39kn2Zhx0rgAA2DTG/vQ5xN46F7xZ+i3Yb+fg+E+HPFJoJq2NrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4dnjzcPHSoDZajU/jmoeoNZJeeYfgkUKDBtrWezbhgyTePLGUcclAnFfE3HOtirTxdWkSDZHbOhayANgxxL2F3flsJ7cgswrmIejolRGGyANkQENxGE2g8d7ImPe/f1h3Q2ZZVzSP7b2BSmtnZiO6e7Fr6lOUshbvYIz2MO/alfQFbmVoSOjBDRuIyYl72TKItYp8x8rpW5jGm7E4Ru6in5qbtzLRZo5R5hMXjCmoSFFHDsgD7j34vITjCm7Hk9yoO65UgH0ESUXMSVmj8QQRxfkcDbHpLBGnFNviCGHqsl+oJh/EDdItXz3BeKWRzSgO+Qvp/jZWpNaZFLmI5LOeLkbFyMrwwzDSGnptEvSnaB6FDJW9sJ1FeZ06XsfkdHQ2NY4/uVjWn4yGxzATSiKfKlIcvThO/IibEPNBed6YTNVWAvcxX6Sr1QvL8WjhFzU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:19:58.1762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e4e731-1c37-479a-302a-08df12f9bfb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

