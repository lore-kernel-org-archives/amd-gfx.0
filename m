Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD31C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5CE810F743;
	Fri, 14 Aug 2026 21:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FFb17epE";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2114D10F73A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0WhYagO4/AonLrHU7Vx5a1oxu8ZCrRFXYbiVBhuK6W35k7vw+boyBlwbmreMKskfBqj5EdrJw3uS4scdpXB3naZJlPKksjKspwU79uGQyOLiPFRiwP0jX5qB+d9bq7cSTf+lCHnYhUT/Cy7ACc2v/cOF62Gw4Y6rWm/AQYmT3onfhFCA84xKH83yirDMcKzuoyXiFX1W59/uDyahcunopyOqdHIP5OJMkDUvEkbzK/1XHd5zCtLdLST1MWf1/95iFfJbZ1AzQXvwwHSHN/naR01iBVkIqdCWySkbje0fagYXJUHC3n//zwNOxbCVFQV6BpdLEt6CKw3ccJC01vjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEQ1wOBa6AjOxgaMnvDQlMal6Gu+p6/lM/NPmnYYY3U=;
 b=qgjCYFIUtsD7LO6d88rTN/KPleUsTpNdr+CBoDTheriG4fu6RpUz7n8MnSvU/b98uwflnBqcfLiDRAC+lUf46PA8zbarzykADQ/Ew0BiTqqEzxyMwwEfr9Y0N///RYJLqroirNmBd7ImwrMFSVCOC23KhRNG9RYtsjVt2Yjs5f/8yyT4e4CLsRuwUjKkaljsFtMQ63Np3haFU6IxZxJswbY84vvoHMau8JElpaH0Y8pzdgdClHpRRGDp06QL1bdevfpue5mpjp0C19f2EKuMrlPhM+9ea2EceeeWH/tyikjCRAhhF5gorKznvF+PARmv/qCQsb9U0i4l0I6V/j/1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEQ1wOBa6AjOxgaMnvDQlMal6Gu+p6/lM/NPmnYYY3U=;
 b=FFb17epEbpBuRguWMnXqBaUdhFEyeDpcXhLHgdrePYnwLhaQq6Wg/xbx2ipAClDpyEwcFycSrcwfdeoN0BJzs+B4Od4qYoyjTi+BJD1J0ZMu+iXcP76aVNa1g8bNq3bXmkthHeqxBCrWhMLtIuvyW9dVgeRNT6ApnK/NK/CFdZo=
Received: from BN9PR03CA0582.namprd03.prod.outlook.com (2603:10b6:408:10d::17)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 21:03:59 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::4b) by BN9PR03CA0582.outlook.office365.com
 (2603:10b6:408:10d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 097/109] drm/amd/ras: increase page buffer size for A+A
Date: Fri, 14 Aug 2026 17:02:34 -0400
Message-ID: <20260814210246.3067612-98-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: cff9f76e-bbe0-4d1c-b2f1-08defa478f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cZ9S7iS3x3q7PXUmpEHQcabo63Ig6FY1SLpeGP1dDyDYkHmMyNycGBnOFrTTcNEj13n11JxtfznxKiqtnzfeS17I0550+Ri9dKyILKEcE3YjavTF1EE/3gNpOdSK8yMViPc1i/mjNsBWI47tya1gfjGu8zEApWrvzgOG/u/lighnqguaf/HBrqKEkH6uOy+MOtlS2vJam3huJiA7HxgMRPD7G6phwipfp/pnd4y6HM5LMwu5j8loPEjefTyUXTGmVbxoqcZa/qbtzGiQzbOxffqqs+TKXxbGy+m4qSXxZG+IDN0uRq5U+wL5/4Hk1z4p9rELjy2rWoq9LapC4ToYWxfCuLxKdgstzoMP9nHBq1vsBLagK2W9sYAon4txv/dpFQ/e8ioXD+ZdoJwK383Sq7T+pOkrxVS2KSwayY9Wzn/JT9CJPiRQDlSNcV/m6BFrZX5VQadvuerlWHRJx0OfThIyHCI9ewaQo/fqYC4/kAoO/nY/PHi0/0ZxmTdgSLvp1ucOY6NdttebFYNVImF+wYCk/U+nva8+juKntNGjVQ32fz2uf6H34JWwgSFtp1ftAkFfXC1NJLmit8yoAZUcH4vjS+Dl1DVvUuBqm1tY7Yl7iU3ISzSDylipTtOSCgPsC24hctPHNsQnLgqR6D5DwKjd/OVeKrsqVAYzRjZKMRzvIJm26jqXSbqZl8cM9p/rtbfwoKe/mdAJ4CxvXbR/bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z8ktG8yMMLe26MRyQLkFlIdNURa+fRLLbyr383bkVLgJx8YOtuCVSD4jd0JKilG3AIOr2Zd6lVQvDPSvecI14DehZvJsLybi2GBSE8YhAgv39DU4OvFLnvoMR+5ycQh5lZTBtjyh7cVRiof4XcGY3P0y8cb/+GBzv4753doA4uayvdPoGs6Ii6WI8WuimjwqBRvd+9PgX9izT2mikvL5lReFo6qPvWkrk/eLUUK8f1U+xwo8ub/Q0raOSlqd9A+Z9BQxtZxsIC0bYj2YiUkeWmBl0f+JBWI7UhWB/Xj6dgI2Q2Km/EWtlLK0856i353N6wYo5Nx7R8s8zE0SdGjQgiIKA9rw0nR6QUKPUPMWAdtePs6oZzaBC7328JOgCgZN/mD2Umzeva/4TIinpHyVjZI+f7/FJa4G4GJjez5m8zuBtPHxBYoD5Qo5Cn+8gXuF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:58.4942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff9f76e-bbe0-4d1c-b2f1-08defa478f31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Increase page buffer size for A+A.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++++++--------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 263ac4b2ab582..c3bc71e1c9ff4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -219,8 +219,9 @@ static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_vram_block_info blk_info;
-	uint64_t page_pfns[32] = {0};
-	int i, ret, count;
+	uint64_t *page_pfns = NULL;
+	u32 nr_page_pfns = 256;
+	int i, ret = 0, count;
 	bool hit = false;
 
 	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0))
@@ -243,15 +244,21 @@ static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 	    (address >= RAS_UMC_INJECT_ADDR_LIMIT))
 		return -EFAULT;
 
+	page_pfns = kcalloc(nr_page_pfns, sizeof(*page_pfns), GFP_KERNEL);
+	if (!page_pfns)
+		return -ENOMEM;
+
 	if (amdgpu_sriov_vf(adev))
 		count = amdgpu_virt_ras_convert_retired_address(adev, address,
-			page_pfns, ARRAY_SIZE(page_pfns));
+			page_pfns, nr_page_pfns);
 	else
 		count = amdgpu_ras_mgr_lookup_bad_pages_in_a_row(adev, address,
-			page_pfns, ARRAY_SIZE(page_pfns));
+			page_pfns, nr_page_pfns);
 
-	if (count <= 0)
-		return -EPERM;
+	if (count <= 0) {
+		ret = -EPERM;
+		goto out;
+	}
 
 	for (i = 0; i < count; i++) {
 		memset(&blk_info, 0, sizeof(blk_info));
@@ -264,16 +271,23 @@ static int amdgpu_check_address_validity(struct amdgpu_device *adev,
 			 */
 			if ((flags == BYPASS_ALLOCATED_ADDRESS) &&
 			    ((blk_info.task.pid != task_pid_nr(current)) ||
-				strncmp(blk_info.task.comm, current->comm, TASK_COMM_LEN)))
-				return -EACCES;
-			else if ((flags == BYPASS_INITIALIZATION_ADDRESS) &&
+				strncmp(blk_info.task.comm, current->comm, TASK_COMM_LEN))) {
+				ret = -EACCES;
+				goto out;
+			} else if ((flags == BYPASS_INITIALIZATION_ADDRESS) &&
 				(blk_info.task.pid == con->init_task_pid) &&
-				!strncmp(blk_info.task.comm, con->init_task_comm, TASK_COMM_LEN))
-				return -EACCES;
+				!strncmp(blk_info.task.comm, con->init_task_comm, TASK_COMM_LEN)) {
+				ret = -EACCES;
+				goto out;
+			}
 		}
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	kfree(page_pfns);
+	return ret;
 }
 
 static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *buf,
-- 
2.55.0

