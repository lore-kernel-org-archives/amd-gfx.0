Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844EE606A32E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qxzXjuOJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25DB91124EF;
	Fri, 13 Nov 2026 13:40:47 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A1C11250D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 13:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpqrdD6Edhrg6VFMf5mrBc/td5c1dV0z8A/Gf4UI/QTENlXaAoZYU5eecScOdAY3TyhkyInAY38Y7EKnVuEbBbfakICnsXYGuY/HvKmvaRF/lPQi9jeVvp7yeaIGb6RtVLxhOePjYRndLyiPTdD7aoCe5nxyGUDYJ8yh7LteIFhugYbCsCSvPERs2khX6UpAnALhJ2OwMAOlXp5A5w4ZGiF5BMdn7NOqD8X7TBlTU1ZlIBbQk8xEnTngXOqiOk7AhuRGLO/SZUv3TqnSr5J9DaXWXCD0AkoX3kHwpii01SoeHKaN66OECZ8aU34QcAm1M1D23ZwjIXthDFaY7NgxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rlw/lBG0YtCt8z17D5YCP95LMkwcjQ2LcIZdhiDI7Q=;
 b=S/YYm5Ix+kJ5EPru3Sdc7tfRTM9ub093To53VBnh6i+oIWWDro4bUisXVmx7XsYNbq+uZQxYI2Nx/TRdNh/9/Soil/rCnEAXNJKFZEqhaOm19mTvEA/w1KNX9JBepuDacFNHIYDOYz/gj/XgMAmm0gtC7yoAH1TyByPo0DkpYgeHP0+lY3F7JEwjN55f+eR11VUOjHBe+uIfiSVrWV0lBF4QGfnPbwu1yfrW/12KNaH+bfk3vuxXv2OUUB2qxLrq9wjorGMx/d2l5qZw3sdKHzCiXDw7V4SlgwYOyZkR7dSlaEFadNGtBiuRj0WOTJW0yxRHn7CIf+eWdUeT+l+9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rlw/lBG0YtCt8z17D5YCP95LMkwcjQ2LcIZdhiDI7Q=;
 b=qxzXjuOJdgD4EHC6G8RED5CEeUI/0zhi6etRlp3HWxs2MfniSPkJa804vwyD+17zyXiazEHgOcKz16am8E4AFVHFLTLABJmaG98kQWaeQay0V0V8qmc7Jh3JLKNspJe2Lk247vf8PQxJhIIC2jllLwwmr1KVI1o/lxlUrcG71X8=
Received: from PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::14)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:40:30 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::21) by PH8P220CA0031.outlook.office365.com
 (2603:10b6:510:348::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 13:40:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 13:40:29 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 07:40:28 -0600
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: clear root PT after setting vm->is_npa = true
Date: Fri, 13 Nov 2026 08:40:17 -0500
Message-ID: <20261113134017.2781893-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 5255e911-b4b9-4a40-cfee-08df418baead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: +E+FfMGrEtyYAJUVosNyW6TOAFobiHN7L5vb0Nu/pFASLrhzC2tgwCwbsGsNSoYmr5zLpvh4anBEpPFYzZU9t/AxWnSz5FDMbB/m+R4oaeAzn5qpBtwBN6fhxlZNq2OF8o5k4YPcG9NTBiSHRP3MoE+NXITt2cMQ9hOGJOC+Xy2P3kpmZaG8XNqV+auXSb+2Kna6Ssi8rsPVBcsvMkkHxWdwy+ERBilffjggWfQz6O0WJce/QHmnlwY5NTfO2bRsiGgefNsax6Q78ZHZKV1gjb8NjFJrHXP7KlMz8os6se0Y3NwNLCHWgp98FotbNnx5Bs4PJY2zYH1/nH/SeyUER0VF5X+28HNYeArBidY5q+mNWcI2Li1wqumMV2ciwnwrII5p7ZRuVUKHko6YgG8x25XzCIhHOznmUcyenC8A5IhQgMN0oN17wgBDiUOQRDH/BNcHaPnqXBWKLrk7SqChu0NtbDFbPs2ChZXawhRE4G/MfAYYluCOumfSAAB7U9ueesz4keB6vUlO1JzwmB8sx64hKh7chiNL5vdzGIolDOiz+RgzU7SXuR6kwnWJlK9inagbkn7b/PFEdBz5vFvFDzdET2d2iq1HrKFG0M+361pkk/3+A+AViMtOq/ifda4fsXHZsdUJOpnst+oLyXQZeNc3bD/ZDRkwjKK0XctWbz3rXu+rv0c8Ca94ul+EnTUFsEUPeCcVCGipuEA8r/Iu8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +areLyzyTHrpeW90LZovM2sXu/vLj1UejeLZRQj8k4cM4UkLjEUh9cg2YI93TpJFwTN+PV3a7ugtKCKbhvqvdLJFL9HHW2B0udzbqtwsUeBibf+lQBFSE+y9Jk1d+JdBF1xEk7Gk7XB8XS8IKfA2v1z6XUiojaV+iLpN72eEBBu6Ue0vtF181cTkybZW71DqiaIOwjld2RuF+38mRzoYZrJ4frlQOgX+ccMyeWbY8O8J2UMybCJDpioE9Vc61C5s5dzOYy6p+hQPcYb2A22qkrdDAyfZhpZsbXqbRW5vekNw/3RilEa1LcBfoiTeY6ACacTVUJjzyRb5cJhSo4Cdaq3v8zBHC18vfLgH4CGiM3Eh9vxspYBUBf2/tKQ+nBu0t6p+WJtj7ZeDPLLi3NZIXH7Yu2qtDSavy6O8KQvJ/IPB4zFkJ1Wljlk+2exd5CYA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:40:29.6016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5255e911-b4b9-4a40-cfee-08df418baead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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

Previously, the root pt was never cleared after setting vm->is_npa =
true within amdgpu_vm_make_npa(). This resulted in the flag
adev->gmc.no_retry_flags to never be applied for the NPA VMs.

Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
been pinned/validated. This allows the root PT of the NPA VM to be cleared
with the correct value.

Remove the redundant second setting of vm->is_npa = true.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e..bc5d4bfdd424 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2829,11 +2829,12 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (r)
 		return r;
 	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
+	if (!r)
+		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
 	amdgpu_bo_unreserve(vm->root.bo);
 	if (r)
 		return r;
 
-	vm->is_npa = true;
 	vm->need_tlb_fence = false;
 
 	return 0;
-- 
2.56.0

