Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3135F108E1E2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 11:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94AF110E970;
	Thu, 19 Mar 2026 11:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5gfpCNsw";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447FA10E970
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 11:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lR5ROHsauxWBLnyp6XXLOe2dAjIAgExK3VwnIOVLSD+0l65dPEyF8ktWMNDd4N/XuQKNWrmQqOku/mhb7Rw4iTNEMFLxspdYoZlRItVPnPSNGZsFWkXpGvsVIoedi3nlMuA2kCMjNWXS+cQ+uOGhUsC2zxwPtagiFH1dnbynpea0hSEygXUQvtF9YxkOgrN5AX+6aAjyIe45BF1bT61zZ8G2Y0NXOa04l7NMQ+w0rpl1jF9/oaNwvNZjJFO3M9U4bWj4HiRU/LP1BgahQGcZSWqcRaV32Ky1sCQugO/Uvqs6Agzk5Zb88h+WqXuy2KrCbwvMVB562rSR+VmZ8SQfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD2WLHW2bIp85RhzkKSKyVGEjwloMsUTJ5EMjRSReWc=;
 b=N4SVWAUNgL8ZWRKC7UNm49/d8C3RQUjbBFDUO9OIp5PTJoxCuaKVbfXAZlGk1aVkF2jO0vFwUbBN5ASwUecU5hsoKh7wJQueC3+IvNS+2RljS2ktM0k7yVkPpjyu+OOtO0mDLlchBjAXI6B5HXBMbEn6jKTMF3Sg9rlZk+Fp+2blU2/5IGDBP2OEmCicybVGOMMrPny2uyqsr9m3Gfq9CN2HQO6FWu0H2Rjq7yTcTQXDh0Z8jlb6NQIZRfju2hBeELI3iN074SeLzxO+7eXOzbHs37dMm9dimxP/nh2TGYNWd/tw+sKyIwhyGcNCartoIyHGSO4JasBS1ZjcNRivhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD2WLHW2bIp85RhzkKSKyVGEjwloMsUTJ5EMjRSReWc=;
 b=5gfpCNsw2WVOPbCz2CBe5sw5J9HvpF/lrPkba20JXS8RVkGdNLQXpEPKY/0WtlmsihBZjolwsi7r2wJBA3oUKoAmzvSpreEsPdnIjXrviVRFH0Z/tB4FQsF5ZBPB3L4bQBeJD6wt/KNUrJ/psMIW6SQnTodgxuhCvYJoS/UATqY=
Received: from BYAPR07CA0066.namprd07.prod.outlook.com (2603:10b6:a03:60::43)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 11:00:05 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:60:cafe::28) by BYAPR07CA0066.outlook.office365.com
 (2603:10b6:a03:60::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 11:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Thu, 19 Mar 2026 11:00:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 19 Mar 2026 06:00:00 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: Skip discovery dump when topology is unavailable
Date: Thu, 19 Mar 2026 16:29:34 +0530
Message-ID: <20260319105934.1989939-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: fc42dc00-c08c-47e2-08ca-08de85a6ad14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kcVcBjqRe809MMpWRNST3JykbXubRP9QxRAWwvvEu/yGg18r+J11Pld73W0ZFw+2Rw2T50FC3K/N7sCp7OcYskeXXZm7ltTx1kRBfDh4BFcjwTcLcpA3VejgfrP/UNR5n+AHo59IlYv5litW7sjd7kk+rdM7QWNNe2keI2iPiPlv8zYXVQ3Nw45OxlcL148agrDXO4yfNnjdSqArhJ46KuYhOEd3YicMoFuLj3kfdW3Id1iRTUhN/QNRHGOtIA4KtTqaLmJPfLsezRTIyAJ0L53iSyDF0Rf6eFpoW80A1NM7kBIn3YPdQh//OtjL7IK8fkLTUitc75sSUIBjJYAGKck1mrUimmUC8lLaV0X3cP4QzUZgzkhAyI+PQXEgp68zhMgJVUg0f8ZMGNUyku+KWefWNmK6B1tzqtGLLKPQVHKkrem+StXzEyTNHCzfdT/cDmvkWD0E3LXcCJkhGDRWak2XKNwIUlg9rHWkUH5vjRBH4ZZ8afdJgCN/gOT63TL8npZXRwEAfxiGmdrZVjTNPuvsKtJxB9Dkr6boSZwQu2waFL63gum+zwaxwL0TS4ePh70t8WXNZi/x++KsSusyHFbgRybYACMdGeNshttsbAcZVF651iDWEPITJyvJMvcA7avQa1BkU+q/lGdkn5LOjFCpGHBXMc7b6UDfq3f/Ws65ba/ORIfl+1oiR2nfLvd2Yb0RbFlQQZ5WE6m4D/AWOI3dXLZMizpNN+P3HplKZLYVcEqravTEWkFRvn7F8jzZ8SCVEEdV3vFTTku8frN4OQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XZ7Q/7hZTJmjr9WZ4nXbLrorN1qsvcHFFkfe/W60l/xrpYwu90grTAKmd0U+cCtfa1kcR3//Yoiw1aULB2FYPsOPv7UhIU69OPzncICyvwEmRsUJVQymeJhtYtkjABzkaSaSKeJtivI70JgpEohMK4xXybKfnfMcbcOwhj+cfWC8L7qR3tkaEiqOoL7A1PTJ2Madb0gD9L2g3P2r7N8ehjKSI53STFYAx6T4jEQuGV8haLQO9N2T9tAQmnXDiuJ+r9f61XBZ49RjL/E2F+f2xi3A6NQhvOvKiEjH9bSFV5D4VBJTZirYqew8tB8+tXGt2JPOPTj59vNozLgW6jm78DJdJyiBCucc90xbZLGcljBYvEpmwpbzjrkSGZ+XOg6z9Vv6dzjQParAuWZ/2Deqm7g6oZCDUhuLkMNXErFgacMrfWmnORwENHT8Gx9Nj1vK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 11:00:04.6688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc42dc00-c08c-47e2-08ca-08de85a6ad14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
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

When generating a devcoredump, amdgpu_discovery_dump() prints the IP
discovery topology.

The function already needs to handle the case where
adev->discovery.ip_top is NULL to avoid a crash.

Currently, the code prints a section header and an additional message
when the topology is unavailable.

However, for platforms where discovery is not used, this section is not
expected to be present. Printing an extra message adds unnecessary
output.

Simplify this by skipping the entire section when ip_top is NULL.

The NULL check is kept to avoid a crash, but no output is generated when
the discovery topology is unavailable.

Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6be1f971a31a..5a4e63e1ad93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1422,15 +1422,13 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p)
 	struct ip_hw_instance *ip_inst;
 	int i = 0, j;
 
-	drm_printf(p, "\nHW IP Discovery\n");
-
-	if (!ip_top) {
-		drm_printf(p, "ip discovery topology unavailable\n");
+	if (!ip_top)
 		return;
-	}
 
 	die_kset = &ip_top->die_kset;
 
+	drm_printf(p, "\nHW IP Discovery\n");
+
 	spin_lock(&die_kset->list_lock);
 	list_for_each(el_die, &die_kset->list) {
 		drm_printf(p, "die %d\n", i++);
-- 
2.34.1

