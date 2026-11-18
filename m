Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7A60A2603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IIl9ROi0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BD410FF8F;
	Wed, 18 Nov 2026 19:08:10 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236D210FF8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtVYcxLoHVxFk9bjAs0fSkmVufY6/DCE2UzP3Tika4H2DcEfnQInZipYZlnUbNYOiXzQNkan4p3b9KxeQ8LFuqA26RT1U9xHlaziT8SV/UZHq8Umlw6wRQtT89HbfYHcMCYzY3QuBuj2FPFVTL1KIIDzy6uZ80P8anlkYskPNvrB4nQ6GbIf8UjhWH/HPoxKG87PRCFMXW3XQYKwV/0jYEtzrwptNlYFBNSTzyb7G298FT6weStpEAQGL4pM8k2v5f6upJePVtKxzGQuJaEEQrOLJpnEscR+UFiVdwkiCJTwVk7vDtaUppIPTSVBpHk5pMDx7vNbaGGdV0dk9PD/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1lO4xzuDIt+fvBZgj62BVT956DUs3GnjVLipLuIvmk=;
 b=wPGZBE5Rw0TJ2kau+YQJQGBCrZ/ZFe7DGIBGhFFHmMt8E6kM/ShVmQWVMc8B7h+h3mjQFZoG2cPcsHT3tqGJBL7kDzocnR2ca7pWclXXEhOB2lymi5Tyymn7ifQJoHagLWM/vQAcnTGb5mujcJsNJZ1Nemq7a2idphsVQ7hANlb4H6gir9bo6AHJgbnaeJcWQl7DihmzZBrntXyP34N/kFdtAcMzquHKLw7XjHdZPQheqgy9tmx3y5LbZt4Uy8lXMLVcWfTlNfSICqSgZitdmXkVXLXiuVVSuNkGL8UlOQm3Px3Vj4NSr3AJpSsHyES7A69cCv36BWCcnGiSBIS9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1lO4xzuDIt+fvBZgj62BVT956DUs3GnjVLipLuIvmk=;
 b=IIl9ROi0jTCpYSGRmJsuQLBoRO3m0pFn+dOA94t/7ZhLdDfm+J2mSynWT8XK8tqjuw/FAfoFcmzRUMLQkerpdQ6s3yr8uYJMvAgBqvtYiZuuDFUhkfEW3pK1FnAs+W8CFcfe/xg/3rgQhrndM++oUqyPwL3V8OXrh4UY1vBAyG4=
Received: from DS1PR03CA0016.namprd03.prod.outlook.com (2603:10b6:8:233::6) by
 SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:07:53 +0000
Received: from DS1PEPF00053450.namprd04.prod.outlook.com
 (2603:10b6:8:233:cafe::a1) by DS1PR03CA0016.outlook.office365.com
 (2603:10b6:8:233::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 19:07:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053450.mail.protection.outlook.com (10.167.23.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:45 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:44 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 09/10] drm/amdgpu/uvd: stop using amdgpu_bo_fence
Date: Wed, 18 Nov 2026 14:07:34 -0500
Message-ID: <20261118190735.1863676-10-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053450:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4e224f-7e5c-4d36-45d2-08df45a73f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|261026140227099003|11063799006|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Kbtec4Ik8r2ygGyCrIg6RXtNvwCY1FkaXcQww4XG2WGNn1p8BX/5dfORpnZDvx9wU3NrHL9SPhJo1XN+fZw96BzDyPr8h0fXa4iYAuzQVeb61kRtDNVkJwv0rdAGfd1mUmuXgKulS9dlLTcLhzuEUXYFGFcKV96mh2pEJYfzHgS3XSuPeXYX2LZkDZdtHDlyeFFoNDgVoK3LrpBzxiZrRmpoiSUcZmOQYKnLOYj4b1P8egw+en807IPGBlemfNhOJeKAe0CEw241qmvy540DajYnyAAt65AAjfJFvEERm3MEZ5nlSr8q5iDDlJZS1lz7JlpGINamJG6a/kKloJJUWmzOAD9dycrY2nD4+cjkEyRnrDbgKtHUKfejJHW3D7fLFSt/pQ91EWZDSt1C1/9xNCGU7qjkdplWPJ5qqCpL5xzIIeZmnDI7A35+Jaw/pklYYiGZSkr0jRsTqJTo25hIwjUKKsMlH441mpfkS7LDxUm2fpkptLV4x+94CIhsJQeSxSM0G3sA7HP1bx/eF+HFjSru2h4iFSxOG6NKHLAeQdb9n5KNIYyPZYt4SI3Lb3serC3hsnGBTAL+zhCF8Sf/JHE8bMMVCC1AX/nAebAlvKukjNnXIoMt4dXXTEZKNsdKi4SJWoJ61xS7gTeJOkbgpw+V/WwN1cv+kBg/e3nO60u7jvnxtPHThyMUW6/x/uzb8aolfS4voLKrJuR/9a4R4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(261026140227099003)(11063799006)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YwjSV5CPQZgxh7MWL6NgDnmSPEQ4gWaziRcx4hUTB9UB9o2dIiM4eaeg7/tYsMKCr6O4Ud9nvfToynX0m8nXbzC0Nrezy4SxYkPcmiT8uUQBiByandW7V2hxRmEzw5ySwrp1jeAHWrtZNUaaZJ0loBaoG5WWvAkWxRoSDtxf1iFU6I8hi0Y/dplPycH8Yy60iPpyEN9680u/VuDZe1BUGMEJowa0F1kmgcc5ynx6eo1N9ElbgpBDUBPCLuNlr0iWhmJf0LXCOp84EY6mRIVkkr+VbbauW1EGf2wFraQbQsR4n3SlgsQ09Rh0pRQsh/ih1dDWpxcZ6qTDxE0V65RFoezezqQw3P9sgH2fEfDW/1TAetqFt/X6kQv++TGt0frDtOFNAWCMLs4Q8rizySFpX0UxxrP+0LXYZK8OxC+PVQ61fNEaYP71f9hQjaXaHXzT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:53.2570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4e224f-7e5c-4d36-45d2-08df45a73f43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053450.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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

This helper is deprecated since it is incorrect in most circumstances.
This was a circumstance where it was mostly correct but it is the only
remaining usage, so get rid of it here.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d88dde859615..9570db033b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1154,16 +1154,24 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 		if (r)
 			goto err_free;
 	} else {
+		r = amdgpu_bo_reserve(bo, true);
+		if (r)
+			goto err_free;
+
 		r = drm_sched_job_add_resv_dependencies(&job->base,
 							bo->tbo.base.resv,
 							DMA_RESV_USAGE_KERNEL);
 		if (r)
-			goto err_free;
+			goto err_unreserve;
 
 		f = amdgpu_job_submit(job);
 
-		amdgpu_bo_reserve(bo, true);
-		amdgpu_bo_fence(bo, f, false);
+		r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
+		if (r) {
+			dma_fence_wait(f, false);
+			r = 0;
+		} else
+			dma_resv_add_fence(bo->tbo.base.resv, f, DMA_RESV_USAGE_BOOKKEEP);
 		amdgpu_bo_unreserve(bo);
 	}
 
@@ -1173,6 +1181,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 	return 0;
 
+err_unreserve:
+	amdgpu_bo_unreserve(bo);
+
 err_free:
 	amdgpu_job_free(job);
 	return r;
-- 
2.56.1

