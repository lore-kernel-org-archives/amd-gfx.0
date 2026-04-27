Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9982FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E07910E60B;
	Mon, 27 Apr 2026 08:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="42l5CnGb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1795210E60B
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjI5WNZcGq0vpJVX2uTA9Ks2vibb33dH92a+l95lZbb2KlOP30bgyICczxtgYEt7teG2e070P6UtKjLZ6rmYmk6It5CjAP/EwWMo9LGY2kMyWDUSpK+4Bc1NH0u6XZvQvGZS55JGwBo4MLltlFUjGwUbOplV9OtiCXRBscQFH5dZfqOF4C3f7jhtIZWonuiYqp1294r2PAgfbX51ZyaPmGobXscunsdiIKPdgxVFeSkExTcCIyJ6xTLerx/lztzb25tnIex11mIxFwiUJ6XawQlEqRow+2r+0yLgaoR7d/wWAnZg6WrXkIcJKdyLB/ISAxmIBXG5qNHxWCT047eN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTt4jMlzvvrmlfQ7BVaC4MAwgDpVCUKe+DHWLFszhYE=;
 b=GpXBvnG6FIUfzFLY/9sIDXcOUglNN0eKJg8qyVtEJb2/Q8jIfa3Kj/LlhS8CH0seJQy9stQIa04GGB9Ki4oAPY6R4UlgojAIL0BSQlw08f7Q2Wj5OAbvfcIlKkGQZqUBdtcmOMfTPd7zOTR13GNJ04Ck1CunHcLFMZgDI+3+oR204xPi3ZBJ6Uew5SRDH1QEZooTOemAZFyxZ87hA3ygfNc2pch13r7qzDkT+0CL9a04CQR2LRhr87Zkz2+LcX47eL0N3C7IeucVQw3J0PuSJ/93B4WoI32dXbgTguGTh+j2G/6J6TTnED2gO36/sahZ83SVfWP606w3JnQGpH9awg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTt4jMlzvvrmlfQ7BVaC4MAwgDpVCUKe+DHWLFszhYE=;
 b=42l5CnGbyBNi7H2gO7ei7cAOzXdsDdP1BfEbsJN1W8BNmWSYhPFr26EycCTOUmf1n4NPo9Y4dWmuv/K5mSJAhEZurc3kMFDWByC7hng59udbE4AYpfMHaQtH8cMLesLj9VhlY/dv/duqtSTxW5Uoo3xY0nO4WB/4D4taDhgXhXM=
Received: from BYAPR07CA0068.namprd07.prod.outlook.com (2603:10b6:a03:60::45)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:36:02 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::f5) by BYAPR07CA0068.outlook.office365.com
 (2603:10b6:a03:60::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:36:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:36:00 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:35:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 04/11] drm/amdgpu/sdma7: register SDMA UMQ doorbell pool
Date: Mon, 27 Apr 2026 16:34:30 +0800
Message-ID: <20260427083543.1328533-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd24ad6-0583-4245-9648-08dea4380378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z9gykN4TBWEye+DkdFgthyHEgyCtGES2J/xfZHhyBjM6/gyGeRhNsqbuQieOTvF/hd1qNsp190sAfbizcfqcLX8sx3T6fjF3JMqDX1b24veoY034tk6K0VQNN4Ed80ZuPfJQpidVJB+Dk50/xRJkT4jVvu6QB0G1nfbQYpx/bYp4maF1BwSxo5VZ20VoG56hnp/zSELd/QXdKupTdxwsE5HAfsEX9OL80zsvV2mqMd7isNO5PuIEZD/QsUdoxHmx1bvSbou7TzF6bIo+tdgtvWOM2xVOAJvefAkCSDhOdvAmXOTYxi4DAOVHmf2CN4DIJlgQKh73veJyiPMRucjQ0Pp38h2z5HpSUZsgMsgMEyJ/Pb0J4nC8W0yHJqKdWSrVJ/GcX5pPxXMeQ51eQg5ARQv27edfzjwUTgm/47w/qb/8s0YS+mzkIRRcrOolSAybh2lrSnM7m/8EHx57dsyoR0/g2QbrKeIuEG5U/z0bygnGgLOMZkniFgldSG4+ATU9Lo0OBqIcLqkZb+QUxAGy3MSUWBG/cgsPaNQlGPCifedMj/rppdOJgWos6wD2rbx1geOOszf2p939721OQQOinFCOjN0JHBgoJxjDcBh14VlqTSVbpZCQNokugYUCGimXggIWPXBUWfRSQ3LSTOSLCB+N71TbXa6sKp9hecFh6ooIasltcQDEScNpBs9QExnV4VIXkBxvGVP+1f/uJwtCg9PpT7ShjytjDvQvK+Mr23mJOTtb5nsBBL+fg1xqe1w9ieaeGEFFmWR3xIBjwp607A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9BahHr4iRU/2r2rHYwFI3jQEI0OKZ9ikdzQwRumQl8gTlYknS/7K9rkh5W3YqLh0LuCrStpTMKT9/svsC1O+f3D1m2rMXK6uzucZni0bA8PwR5rFjXd5hBWDLFf+xnckMb5gBKDt5JY0lVnrvo0VYbYd29D4esXYS5pk4aOgMAIl2aMNHklgGCwf3LRO6Lc8N1Cr21OfUKKoi4F5ZdpWfK/clYJwh645ilEEIUFUN/I2lCcUEKlPqiiXlyBzvSiGM3/PzlUmF1z76lHC/0uzkyNFWmIP+sOfM4sV/yDCqkC7O0wm6IuT47Xzh14zKtyNwEsCUhG5c5glEOsfIR8D72YawZjiTms6BVP9B1kRTSwPK2eJNget3WDbP8xNPXoRGeXfT0VkF8I/ylM2Wt1yLatqJEdd53giKbBZsRZ2rS4lSA1F0GGHTIwPhFEsly0N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:36:01.5728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd24ad6-0583-4245-9648-08dea4380378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Call amdgpu_sdma_userq_doorbell_init() at sw_init time (gated on
userq_funcs[AMDGPU_HW_IP_DMA] being set so we only run on chips that
actually expose SDMA UMQs) and amdgpu_sdma_userq_doorbell_fini() at
sw_fini, so SDMA usermode queues get doorbells from the
firmware-managed NBIO routable window.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 85d98a0e1bff..5f6c51ba7ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1378,6 +1378,14 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	/*
+	 * Init the SDMA usermode-queue doorbell pool inside the firmware-
+	 * managed NBIO S2A SDMA decode window so user SDMA UMQs get
+	 * doorbells that are actually routable to the SDMA back-end.
+	 */
+	if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
+		amdgpu_sdma_userq_doorbell_init(adev);
+
 	return r;
 }
 
@@ -1389,6 +1397,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_userq_doorbell_fini(adev);
 	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
-- 
2.49.0

