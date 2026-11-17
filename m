Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86B606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ew4V58L/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E567010E4E6;
	Tue, 17 Nov 2026 07:24:16 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4AE10E4E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKRlnRuxHdI1Y8KoUCw7tioLDCT/e5htooHLfgUTP002+YlYxn7a+BrEqSvxvs1P2y33PlQIG2ykok4TF3OhMj38gIovVLw52lkRgqciI+uHpEeuOh8aBh4wRzEtYqLQULuMTiVVBseSFap2iExYHz6oLoJftAeipIRbjeS+a2UaKyi+HsBdrAhNSDuOpP4Cv759vftR4EE3k8BOC1TtHH2hApbFPRQf/unVlP1CphKDEQ2C+oYd39GUkevyLg34E0NsGxtxRb/anYApVfRLt73nRtxCIDs8gcrUgcun6JzzyhOc4BPPmSwqZckSVJBv5EtlCC3REXru5gBjuk2l4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7YJ5S0wLy/l2JPUfG5keHaUCffag2BVTKp18NjAdIM=;
 b=BARCjk7g0IiWx8m2z1d/m9yiVgmhB77EnMkVEpeSGzi3J1e1+0oVXZ8+yWwdZw0SrND7xiyw0O/rTE+Aii4Ute2X70bJGLrzs+FcVRRhvZbEur7U/d0yuOlQfZ21Oal8Juto1/08F9QefI1zeaPllMxCowUhssEe3ECL4SwUz/eavtJn6BcLapZw+9USpHswkWRBW8Xo5YSXN9RW+ukRPbgfpGnihHLPcGE5fmi4abwVKjsI9d/6FyDmGf5emz9eOhYgCGyi32BKpBnWGNfvgTYNfD5TmARsQdR7nBbr/Vzx92MzL2KV/r565oIw6OSZ2q3t6Wb6UbPx7Y8YEhBcdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7YJ5S0wLy/l2JPUfG5keHaUCffag2BVTKp18NjAdIM=;
 b=Ew4V58L/MtYG7USyMJfgU51FwR9lxtUwwe94WsI756Q0CtauP6cSoVeM4JcVcsk/+QDaXPGHdg7s3vAVtFkBP2iYf8gXyp1ttnwEFt/mp9DJJlbkwRBr8lHl635JO8s37Qn1OJmKrYNdQGWHjkIUiFb3MfLeeUzSXBB3SvL0sO4=
Received: from PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::6)
 by DSVPR12MB664020.namprd12.prod.outlook.com (2603:10b6:8:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:24:06 +0000
Received: from PH2PEPF00048917.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::19) by PH8P220CA0028.outlook.office365.com
 (2603:10b6:510:348::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 07:24:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048917.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:24:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:24:02 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH RESEND 1/4] drm/amdgpu: add UAPI for user queue query status
Date: Tue, 17 Nov 2026 15:23:50 +0800
Message-ID: <20261117072353.537506-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048917:EE_|DSVPR12MB664020:EE_
X-MS-Office365-Filtering-Correlation-Id: 01420836-b525-4deb-2c2b-08df447bc382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: hSaaYbFGHeNuM6L3YJ7HdgbeZAswtBiX8QFxLv7HnP6AUwH14rv5avOAPlqSDU5u8L8C+7TDoxU0Ib62ausfkdPUC2BN6LZT06VKjJL9vSWX7lP5NTQeQAM72YGDrVSVYXNTtnQaEcRbYLYegmDlRX6TnVNGWb69OW5TgdSFsVsnjjQbOMqWWzURogr5nctt7lQjFXA7umAZWPe4tYvypcF7qwfUJ5y1y8k7Uyf5slK5ommEyOymQex5vlkPRKbFOvCKq87lGXMRGsGIfIHBzosDPNvejeOSisJI57FlanVVOKq/s+33L1UNXrYQWVwElWbyPCF146q8r3u3Vs1yaUA6qje/LZ2zxgyOSUreDt0nc/XLZ2tQOQJxsUQaxWdjnjeq42nvZpKohLjNSaJbwD5C1SvFS2KuBFQOcdgViYjHIxX4WAGPjTcn70SjYATLl3MKx9fhWI/C+eKzHkqPboe/PGZI5HF8gJ1f2v8e7hbrlWsIUCHFuwwFzF0Ppsb0g3RrWXLLnZEGrIoOxTYwqCdobMHOqcl3C1s0MgqNcGrOK5FrsBKeE3cGzo0Rvgi9DKk5rZ0/W96t4WY+XuDvm1HX3z+LA6U83uJwmcvbOoerv7c/TG2C2cV3S8IxAa1whsNSX9E/QyzdAjL918vkQsCHXN67R7QCcksSNcJK4UJYSkNIy2y6pfYHYJXIegW+q3MV7neBPjqUgMvllFV2cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gN/s61HCkBAOznMSzlDxiw5m0rWfrcI5iLi0yI7qwcmJrSItDaF+XxIzyoPyR7DgzNpR0f07U5gBMMUvD3htnii6Oj3nhqVFM/pj071tbGYbGd9SIXUCaRiRYAv8tS9oQyuJiMpUyK7gzf333S3xCnbgUyl5GBb20PWgg1PiAZc1Im/Jm+4ccpSeCsTw1UQfpGNOKcSJ6MashSzj+zebg+TYOdQ6pjXkl8m7FGG8UbKVvorZKxOndj5EFpyOGVweFdO5/4k57JjemJOKSAR4vjmlTIlE3glbegSVhOLJKIIageQK9ImbKInLr+Np0GHE4LEzwpPhYFb310F2bYL05uIkLyMCr/ZQTa4EiZV4p+deK2WkBXbLNloUodw+KqTtXLfYhL9fU/MT/aRbrPEN0X8xr9mevGUBZkJmg+P85EMgvbWTBK8lRYZKA5LY8McH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:24:06.0511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01420836-b525-4deb-2c2b-08df447bc382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048917.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB664020
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 29009f6aabde..a1da2833610f 100644
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

