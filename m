Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAA0CA9EBD
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 02:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC1D10E9E4;
	Sat, 10 Oct 2026 02:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lE3M94LS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B4A10E9E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K86+r04Z408/at4TRLspFgde3C7CeGRsjZ2JF/H4vs4H5SO6tDm3WNG1X5hhy7CUoMlolLEj/Zx1pD5n+zk6U5uZYH8NU5qYV5R7kHXaT2J1ULuCGlVDIrvnEz0AiDuRewZApYrOq2fSBPUZyN/zYjmd5go52a7zF8YiCge5p72llOF6wWUyNWB2YMPEEEGO/aHFspckk+L1tU7N6mmhxf07X4tz5vYmsYabNxf5jQnL7F/gApSg+RD+TL4a2bDrCw84BAxgvCteIMN9Dh9z28kf+Jp3umsT9gges9uLGU385hwmfkXk0DS6Nb9B3Ck9pVpdUxc5RGpeA6+Pw3Mhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yazt0YJhZ/85lkn6UMS2BOTn8Tnv4YyQWHAEN6xgGn4=;
 b=KaM00r6NoMMcNws3gTGNikz7s3yBbjeI0yD+JGGLS1iGPGaQNlVevuHs1F23z4PAnfd5c2o11FFgaKMkKNp0Vx7tNTIVyBvR8cF775Cdu4LWErwnNZxZcViljCtu2H3O1Lw6b8QJLIBc/f7pwthSVxEriX3B5nIvReDJ/PTxc5zwNEY6PH4gtfzuTG+02MUDF8/ntg54EiSzUE1BCsrm8PfX3UG4ZtSQPUYdyTG9VjBk3eKOjiCWglP1Yvg466REn/2QRteZqADGeM8fWeizTa4A+Xo7J2Kuf2fgxU+x/YIaLYsWTQakd/+/rbhZsKIuTXxQhZkwYHIY9U/bOX1Phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yazt0YJhZ/85lkn6UMS2BOTn8Tnv4YyQWHAEN6xgGn4=;
 b=lE3M94LSOOt/8AECi/xk8pT2mZNMBICw6NPfPbihMnkcsS+F/FXcaOSAdMgEdd0IjuYHlyu12PDUAAWsuvGPJLDiHwMEFjh2yK+oyTzzgbOCOcBuWKGbfb0zxBtsQYAug4+AEFuWQqAtwmsEY4msFVZr0ur1K4KrOq/Xn4JroFY=
Received: from SJ0PR05CA0157.namprd05.prod.outlook.com (2603:10b6:a03:339::12)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sat, 10 Oct
 2026 02:50:36 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::4d) by SJ0PR05CA0157.outlook.office365.com
 (2603:10b6:a03:339::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Sat,
 10 Oct 2026 02:50:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 02:50:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 21:50:28 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 1/4] drm/amdgpu: add UAPI for user queue query status
Date: Sat, 10 Oct 2026 10:50:21 +0800
Message-ID: <20261010025024.2453900-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4ff6a6-6a8b-4a5c-9ca6-08df2679426d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|261009223027099003|56012099006|11063799006|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: H3p0ssoOKpzKtHbivFOn508u7hLNEVhze9MUoO97aMJjX6hRCZoBl4lVXP2o65hbiYFXoUq2WRHkG4IZUwwuPappgJv3QBFZ4YBgVdDytKM43MxiNJtLbVPrQUn2x8e0+uCPP8NNon2eX+yBbi2MaBQmt4FOJ4fUiLa78/W8VyBn0krWEm4+PRgWJMz+ka9A53ptq5ZC60pzlDIUhqUDCIvFqdaDudSsk9RC2yVFm9cowuqEpSsGq19GE/+nB5EDW6tEo75pk5qTxNCdL76r0e1PB9rl6VeuyxK3w0YJF99ekosNR59MBKz8qX9gsXDss1y/7W5wR0CahpEcu7ztnHxTkgwYq4GuaIq5pN5KeYhqLF5gMCuRP935CnkVOGsQqylwxjpX8/MLRkUkIwpm/GLbBs7qMtvUMhyYO23ZSB06q+qgMw42KICBneGksPUw9DyHNg0FApAJbyJD3G+iMXR6JUGHMG8rgG0HEPj8HGXsutdypSwk+HoW6F4zsmrY0GDqj7wgc54MbtMCJu99I9qnoKT0hICqFSHeDzch56RSrzzhgzuVSxOy2ZHxIJ7GJ1S3W67bDZ6p5epeiUXIvNaG5rxwaeq63uQJUNyEgDH+i44qj+rEz+83h6Ku23g9Adex2CtwtOvKGf+956TwP2Bttk879Sm0VpJPH+d+q9M++KL2dsXBz+r2S43Bv1UvPYVUV/7hJvdEw5Q7vNQyjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(261009223027099003)(56012099006)(11063799006)(18002099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1v4PBGY0YG1+Ut7h2MCXywaPOrDgNqKvjp7fQzfiTDJVtgsdTErV7Y1shnhmMKoxygT5pvvlu6+tywx8kwCe68w02XbACzKE53kcVRHw2nj2GDYliOPeqwukbD5Y3miw0WkMKdZSNDjlrsLHDZGzeJnDsSxWHtbM9+5xHjAbP+MEICbmJfHxOmt8ZiKWRI4e1FLoCCn0eTgP/J642cakdu+1huGQRF79oqgSZz08nir7j1P8pIyaCdagLG/+0t7dIKT/UKlSo0xGy2Hf78YgRzimXnR2oW/e2hnq+Ei58Fc/fRZqsHlsQsTVwCu0DJqKBRuH72KY4WSyBSNcRT9I0eEDv4nh4t+DouPORA5YNRSDszMzK0Gpp0YULPJJhRMxPSUFxYP7g/xzUBIirwbwHrDYnC5ChowmFf6sfsBOJ1dgs01wSJ2X9nfzPVCFCKbL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:50:35.6274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4ff6a6-6a8b-4a5c-9ca6-08df2679426d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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

Add an API to query whether a queue is broken because it is hung or
VRAM has been lost. Report either condition through a single BROKEN flag.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cd1b8034a2fb..71936418b0db 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -340,6 +340,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -352,6 +353,9 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+/* the queue is broken because it is hung or VRAM was lost */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1 << 0)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -433,9 +437,16 @@ struct drm_amdgpu_userq_out {
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

