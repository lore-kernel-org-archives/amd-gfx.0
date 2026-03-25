Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E710C106B506
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 11:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83DD710E87A;
	Wed, 25 Mar 2026 11:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pj/9/JGL";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8560310E87A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 11:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NApEUwREDwr8S91FzHg8gpS5fLC1+R73NwyoMpoNaBGfDcMVCJWHXz+jYFXKzw+0zRoBMbapPMivg3cjJWsVic9rChGz9oasITb/U11RwFd+MRPkkNVkaLSSKEIobSgfvo84Ii5msbQGWR6Eg5du674l5KLM0WI5pGoJcP6fds1I0/3w0PU+A0qJPMH6eTWvzG2gws1iW1TOf7V6pXX1BChzG/v+HNF0wlDjcimg3SHRAhVAGe6N2ZkG1sXnPlJ3I2UvKN1x1BLrEOiJPtpQF96PGS4kvHxMH75IIO0g//c2V71JKNCfMM9yozNJggBiybf3Fwh3mkuQGcAYGRhSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eJujgFPCQFqD0DoXPzmmvgsuOXciETVKklnFEWWvAw=;
 b=LxkKNFL0R8v7BpuX5tPWdsNoOVu58e0tekk0fn/dtWxaAP+4OH5V+Z6FxzyASlRMfMoP8prB52EKfOkNRAIOxeLu0dFyLeYJ4osbixfemIhYcuRsuJT9PLob78YD9ug5knbDC7evOUmpFJQK+4PU3mcxZ7s+fBo75CF/em4P80vVtImuzDRFayNm7fr+LYnRSVPZIRNS8TQ4y0shZZ3wI+MQLOXyaLHQuPrhWIzUYxIPeHI3gHBemtBJ/0mAOsXiBoctPrCNRYyYadhlII2chfbPgR+MRpaJN5vqtwoUV9rypNu4KEmiCn/PUVIwoTBrEgrwUJkqk95RKTsMtTM6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eJujgFPCQFqD0DoXPzmmvgsuOXciETVKklnFEWWvAw=;
 b=pj/9/JGL1plCQ7J3/tuXFF+672Pm0/Dcpk806aSR01k0xfsHPEmDtekEDaJ1WEvA6rKmq+KQOfn/iSFts0h5/gh6iZ0us0faobifMt/n6uAqm32a+hS2/KtqanMQs7712BcEBYpVCxfL/QLbmzFiCIAgSz/3EDO9O9GMEYUj0kA=
Received: from BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:58:58 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::b8) by BY3PR04CA0007.outlook.office365.com
 (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 11:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 11:58:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Mar 2026 06:58:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix PRT VA handling and guard BO access in VA
 update path
Date: Wed, 25 Mar 2026 17:28:26 +0530
Message-ID: <20260325115826.2100519-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 6052fe30-ce6f-4d3a-58dd-08de8a65e550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pv5e+RobihZvQ4KhUlfRFVhr83KVOscb09qqHMlpizyaLdlzAOPlEuEKQBW74GsNs4UkKbE+m41oXCw6bIXpzntY9agRDEJx/mVMkQJkgwvtyN6lo+TYJD//iFBfU4Fw8JLZQB/F6xIM1/TtJVM8Po14H1w7Z6/fQpicFMi7MUVehPgBMLINLH/9YMbPaV2YN3NBWLHQBvyQTfuTNnsw1tU/B/rxk7T9ZXNEDGz4V2vzAdNbLvU8dw8+wq+0anhdZ984+L/OP74CSsd675+bqwizSNOZkgjr+EjHEBd23kHOBMFcq9IdnhBUuBYJWV3FqTcegnNsHB2X0bwV0309SZJY/hUpGR6k1BE6GrfCM4byRAyU1jjNtZq4XaHh0aTP7DFSavW10/y2u80FAmxxY/lpSeDwQie0aup9nKb1TnpNCJllfE/8xWtcq2Z1Jd2fTAXr0CTxCM0XlyQzIMyDDubaQV16aSM3jmo+enc43h/TE3OBbZ+P+rGBWg2fcJjGxghUWJsa+/VMH4H0C0DONUiD+MfrT6Z/HiAN/PcK1jpUWHtLkYyiKdAvVyL8zxnPPrn818iX6hojMdTPH9dpeaSwg06glPg5VU3cdqUQaX1HBsxJU4Z/VhF6DCfYlDDNfG7Qdry5yWPOKG0HGiQJI1Bj5a8fhqNHndJ+4kLPDtsFSh2BpkepcEUKkTLI4greXxKAVKg0Z5XdTn0b4PystL9jdm5kZWZBo+jWL9QIFFII5oyLjTji+HVZDogeVAfE190afneGzDd6GMoYw1shbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q4NHkfyEALldPlGezx5QrXFwZSLIOU/sYwnxY12ydkpA8i9d8iNKGGwByjFtlzdcoSDHynCpJ9RW8pXCnWmCpyq8+TUT3NEOzdgRoMd/j5BCFv+ajWfGbUz7buszqu57XiVrae9DzWYY9cyICYpy6il6AlV1nAzuxAjxP+1QR5O6OEsGD0rZqQToiVVssdWUlNPG/s0z4brS+e4S/hPzigImSAei5ZxMfmfrf6azkar+FZGru7F9p4rKnq0x7vZ3T+p56oWpDR2bV6Syu64Mps5gohcSvJb5HuRUVmb9i+z7IuKT9qjIDcry5CdKYVlidq1rvG3YbxUUXO77oUTE9kT5qhoAOppQagagB7cXXJR4C5yfGsnxr9zvfQwa58UWA65xzoHMrsFhgQNOP0/h1T57Gv8nhrOs1ZgwXOJnLWAVPgpyG6No9XflJtpwOf8n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:58:57.5365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6052fe30-ce6f-4d3a-58dd-08de8a65e550
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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

PRT (Page Request Table) mappings are not backed by a real buffer.  In
this case, bo_va is valid, but bo_va->bo is NULL, meaning the mapping
exists but does not point to any real buffer object.

amdgpu_gem_va_ioctl() currently mixes CLEAR and PRT handling, which can
result in incorrect bo_va selection. CLEAR should use bo_va = NULL,
while PRT should use the special fpriv->prt_va mapping.

Fix this by clearly selecting bo_va:
- use fpriv->prt_va for PRT
- use NULL only for CLEAR
- use amdgpu_vm_bo_find() for normal BO mappings

Also, amdgpu_gem_va_update_vm() accesses bo_va->base.bo without checking
if it is NULL. This is not valid for PRT mappings.

This keeps CLEAR, PRT, and normal cases separate and avoids invalid
memory access.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b0ba2bdaf43a..289d6b58b579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -772,8 +772,10 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
+	/* Only do BO-specific handling if this VA is backed by a real BO */
 	if ((operation == AMDGPU_VA_OP_MAP ||
 	     operation == AMDGPU_VA_OP_REPLACE) &&
+	    bo_va->base.bo &&
 	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
 
 		/*
@@ -909,15 +911,23 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 			goto error;
 	}
 
-	/* Resolve the BO-VA mapping for this VM/BO combination. */
-	if (abo) {
+	/* Resolve the BO-VA mapping for this VM/BO combination.
+	 *
+	 * Depending on the case decide bo_va:
+	 * - PRT: use special per-file prt_va (bo_va valid, but bo_va->bo == NULL)
+	 * - CLEAR: no BO involved → bo_va = NULL
+	 * - Normal BO path: lookup mapping from VM
+	 */
+	if (args->flags & AMDGPU_VM_PAGE_PRT) {
+		bo_va = fpriv->prt_va;
+	} else if (args->operation == AMDGPU_VA_OP_CLEAR) {
+		bo_va = NULL;
+	} else if (abo) {
 		bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
 		if (!bo_va) {
 			r = -ENOENT;
 			goto error;
 		}
-	} else if (args->operation != AMDGPU_VA_OP_CLEAR) {
-		bo_va = fpriv->prt_va;
 	} else {
 		bo_va = NULL;
 	}
-- 
2.34.1

