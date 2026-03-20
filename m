Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B2E109318E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 08:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6060F10E96A;
	Fri, 20 Mar 2026 08:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ntO2Gk4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1573010E96A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 08:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAkNnUn43zH1IVfIkq5YSUY+bO6JuFLVr+kEIok7baL3Vp+EfkfTYv9P3Vx5pGW2NdCwyy1FUWwW4z1N4l3/Bm3gMFnyDdhx4I735nBPedbogV7sMsKwlJXV1V6Wy74RlPQw1f/kmTr2snKmRa+5q0KDbziG7wT/TAtpSfwBbUPybNOi6nTjNNFxZkbf7t0W5QS/JJFwwH8YZeEIXLw4DaIGNRjI/0uTNWUwWtGB7V3AylVCilK1PfybMvWiUIhthFkbw50YRtlLuZMsQ9rWfrAEuK141FTHoIfetyDiS8m/BG2soNPYG8NnwSRpmUvUJ/oHM1+AWkO1mrd4fnszjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vz4nPKFmFRqi4Pa8yTo8hz+G09u+eq/VhcM8/YWEFCs=;
 b=iqikQazZBiWSOZA1nbFBsiFsSsEJYfXRTbOweam7iBlolf+2scY+T2eFSWDjWOTcMOoqHt/Enj0EP4sjs5socO7sxShvgvrhWWl1ZjTeelfO3TpZ/8rGgAYvb82gve5Bw6bOdTcbLzrZpxVs8p4WXGWjSokowZkxhtjBsVjEaOPx2BsZvixt1kX+rfHBjz/YOmIi93HCUU71xYK7Hgc8VLi4N+dUXkO5oDVK+zt4etnApKXrY5fJZIlm8LymnBNJ5oXgONEnfHWD/QAIS0ebA2iuYfhIrTc9qZOUPldyQNrqnbTBSv60mrwpdsS2mDZUA0GPeHspgHC4CrGX7CcSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz4nPKFmFRqi4Pa8yTo8hz+G09u+eq/VhcM8/YWEFCs=;
 b=2ntO2Gk4bBsa/bolmMGJeTfEUvNix44zChHtyn5cF4iP5T7j+nawqso+SvaBxqb2WdAQyiXOXNyXfu6SD/e+y2w0Kancb8rpC9DNkziO2gAUEgBCy9KbFiinfnXuj65uXx2mJA5vb4JJnqLeDeP2zcl7OcJTKeajXkqOw1InV4s=
Received: from MW4PR04CA0365.namprd04.prod.outlook.com (2603:10b6:303:81::10)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 08:41:55 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::ce) by MW4PR04CA0365.outlook.office365.com
 (2603:10b6:303:81::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Fri,
 20 Mar 2026 08:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 08:41:51 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 03:41:50 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/userq: fix the old userq fence dereference
Date: Fri, 20 Mar 2026 16:41:40 +0800
Message-ID: <20260320084140.3329888-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 5267e70d-15e2-406d-16e7-08de865c88a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: hh6XpENwl6dTX5vV5PRyireumTOczBMJbqIg2ticwt81jX3Cm6ESBql+SX/B3tMfOSPw+k7nB/aeZmF+OIC/3CNN7m5k9UirPAhvbpIAFPRMktYASajVIxUDzEqC0k3U1Ae1Yh9wmfyC8k5Hr5M1Kfw30BTld0oY6oN1CzaZalJKKBBULCXVtDdq6Fx/HeEZqj4kh1BTr4M/JfClGfpNmFiHbuudz0RZ9m9mtGo6aa7PwSF7zIkEr0KxSWJ7ut2qyr0TTbA8L4KbeQcZOrM/OqU3ti62h5LgpCexNrY+XrhBUW8SKElyCD5WRU9QZ+/ub4wfKs9oMe5ZHE6DCw5vEpVXR4jv8P5Yay0W5BxLe0BHBovK7xCzLCg+QORw06z2kdabge2sgrCgrzIb4cVT6y/rfyCkf0VcbgOr7ekenZcO/2vlezT1XNGmobtdID4bqO9xwZMn4H4ne3mxZWkmlL2QhhmsapBwKSK3TTIPMmrxBtNVDcCmwdjyRQWUe4ykoYgeJ3HS+Qw9N7tXyagh7+F0HboSbbDE0fr/zaaYjXrgSaSrTrndPBxXGT+5vAtcva9hqRqUFiynpa+OJlLF4F+Nyvu8fNWHOhSUMJmOuNKWsegh1Ty2kDcaCgkVZgYa4q4UTiQKRy6QPAeA1nf5wXJsxRYUVMyX2zWWACZpottK4g2g/iIlQ3eOrxUndaEIGe+SamdJhggqlMtiRCcwCEHqQB2QxUFHofszQvxZzt/GC09SUDVOLrfbjglA37+53xFc6EiiRI6x3jSBQDaaSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5q2LA5sma/d4GFld4o5WdBOL8X0dM+qKspMBpzHjMChHelY3wJLDxUp9r8oFYxNte4BS9l9SDvv7WyBzNI0SotV62mn4Pqw0lAJHi3hMIjVv8Yszb6vaJE2t3dp619TeAzVHaIg9TzstJkIsiWgJm2p1MHZAlw9kqitrzXG5wqL0rlqkKqqTj1o/7dDiCJzIIOhJ20Zz/cTqz0xLzB2NGKSD+7M+f9kT+Pmwxqym+iSu9uGPTNe1dIMcBjGBKIkgBX2hAUfggLE8KGRLskPb4io2ZOVOWYknyDD+UxotAKOGephgLqUqVmBGpFLdb8C9sJqw0P6JpDtbzm0/l41WLdg/ltBvcZKM1oC9r5iHzplJF12LtGLRZTvxWc7uRpIOhbu1UiNtginQNrVuXrRpp/Bn/oz28lsRuOU5F3URmJkGiPy4hz44UIGlDy7vzac5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 08:41:51.9721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5267e70d-15e2-406d-16e7-08de865c88a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
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

It needs to drop the old userq fence dereference, otherwise
it can't be walked during freeing the queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 9df62f71f27c..f1acd785c27d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -105,9 +105,21 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	get_task_comm(fence_drv->timeline_name, current);
 
 	xa_lock_irqsave(&adev->userq_xa, flags);
-	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
-			      fence_drv, GFP_KERNEL));
+	struct amdgpu_userq_fence_driver *old;
+
+	old = __xa_store(&adev->userq_xa, userq->doorbell_index,
+			      fence_drv, GFP_KERNEL);
 	xa_unlock_irqrestore(&adev->userq_xa, flags);
+
+	if (xa_is_err(old)) {
+		r = xa_err(old);
+	} else if (old) {
+		/* Doorbell index was reused: drop the replaced driver's ref */
+		amdgpu_userq_fence_driver_put(old);
+		r = 0;
+	} else {
+		r = 0;
+	}
 	if (r)
 		goto free_seq64;
 
-- 
2.34.1

