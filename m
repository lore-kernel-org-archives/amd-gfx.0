Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6623CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 01:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453AD10E727;
	Thu, 18 Jun 2026 01:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chj+T/t3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 728E710E694
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 01:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCn6xxG0ELPHYiTAzRgyhtGnotXRxdcmpmhePrHdiDuv6HusJdJyFwE/Z/oaB7Z8ieT2NKOLiZWGjkqi+/Sy6yBBsvNWv888ZqRYXAQUVhX1IU99mAc4TX1JigvTlJHThO774/Xlwv8TA84VXYvuLN2R4Kz2HRP6ECUGxWy7gPP5wmHcDjLmCC8jq+5fvZSMlK5P13ZNEA2gtkEd89CzPQjt+1ctbRt0RtBbyU5VD1T9PiInuq9h19HpBp2dHQ8aZE6vy0JwzAoSpEo9M2gOir3RCIrf/KxR2zRaSggxYQG4a8Zueo5Gepi67lzuF1CDgUwhPwBk+g1px71+0MkbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xozzmaS99b5EenpG4q+26mD6Fj+0aQgkUqmJOU/Z2Cg=;
 b=r7EG/WRvdYb0jSTG1OPRgY9kBgZdOLDZu58F5RtPAKUKpPKz2nAXEZaomNP7M6G4awu7kSfZOPWARXTORbw7eSDosasL/mCv9tIZ0wR9pfHJHX0foo531OKXCnLrcwqKjpgbJJFImCzon93c41bicA9YEhqrgDoM39R/T9y4jjBV160qMrc4RMn5xWDI/1hAZduz8ebN15rjIntc7hN1p+4YklBIVKs/zoc2xUhNiEknGJUoSo0RyWSLnyhu/jHhqVJeEAu2cp9Hsi89VqVLXv56oUNy5HNls17YymTn2FuUEYx4IBjYEWCBUfQ9Gh8besf0e5TSs1RMGLRTNiPpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xozzmaS99b5EenpG4q+26mD6Fj+0aQgkUqmJOU/Z2Cg=;
 b=chj+T/t3v/S2d2SwUZkbl34agCswkGVrHo9jMgdy1aFDjGwdZ9eexYFghW0t48u164gYZ+fsu80BdvPwOZ+ZczGQkpXp/Iyk850x9NCPxUqmXxmXIiosmZlMGaGn89QwFrWEloM7cs/S1j+OJSKNSr+W+aQUsyGywYq8LeXcDxo=
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Thu, 18 Jun
 2026 01:23:30 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::36) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 01:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 01:23:29 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 20:23:29 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jesse.Zhang@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix mes remove_hw_queue lock
Date: Wed, 17 Jun 2026 21:23:12 -0400
Message-ID: <20260618012313.139892-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf2bea9-1516-4c46-a6ba-08deccd8345a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: rHINvgv8z7EtE45Qeoc/ED301xNFtxfGT96QZBcsodsOx+VOJ6hJggaahuSECaDZ7DCXGf69PfHQrrQuB0OGCJt9/YU6AIqdRkDmk1pQEOX7cFYhul25rge1EmfMYa1ypPfxu/mPcJ40PDLZ79022ZVdzeMOOfs/ycwRh5ArqBgnIjUDu4iAnx8erKKZRqNV1eGdMURbIwIpUQNPXzfMHG59brd8TcNIQvEjIaJYI5VKWTCXhg3HZwUaiXqEQVxt0EN400np+JERVJ8T3SMvCneKSIODmWPQQDlCJo0HEtH5xp/yffgDl8YmrjOqUQDvnoPwPDqrTTqKO6FBOGnDe3hmLpKUPDbpK5QwDYH868XvBb+lcIEHKra4eh3Awh4O3ME4cRiEVS4n6CYx516z8+cL2BvEzwk1DMJYQM5QFiwfobLBVLwpxZgnbsS4TWM4DYcjSjHk3eB3v5wRn+KHDPeVI43LnYBJjyS8j93NtdNFIHStUSVNLS+J5ctCjRDJTxRpZYIk4bQlk+yGhS9XsvMUhQTJwTDf+slF/MyA/y+IPJrCfredJMmIljLQPVKW7fMxL+yT/h/mMtv5puTiYkGRVFPLRdcY3XXgdYbuxNOBoQHnyNFaQUisLLPGSXKN6dj990vXF1QUPb7QCCVBwFbfNilbPVysR4NRDG/5jsISp28NWetJSabQM5QASvWvcObz2qwiiLsD2lYBBugXng3TXvmgn6uJHuzrDganc6I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: awWrnk9JaCGg9K2uo8cpPOMS6l8/fq46gOHEjuUX/B1ubvlkPfTE/3oEFWJwfBOS+VsaKuDgildNtiW3pav5b6kQGhKq0Km9kKRvros7LXIiiO0yGtPyfgXyOH4/85xYWAfq/L136FRM5HRKWB8im+fAVpc4RzAWJBXvnLBxZ7F9451NTOjxMm3H6kqItrAk35Kw2eBvqydNaKdh+jNggzzOyTBPnxNeEie/VQD5CJFe58n/W/jXUAUjbgIx+unzk6XiT5q0dBX6MNjPM8p/7pej5OLd9FrHE5Bed7Q5971gB0sjOzNGtSDFChZV5rZV0FPr42uNI4GmkUR85trmGaIgNex3ZMUy/Glb5M9vrFkYpdaBKvMd5nWqq47k8wwIk/QMgCnXNDCNvsc8a8LExBuY8vWSt9+pUW7f9cL6fkRMMDdXt5d8q4pDJyUBklhW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 01:23:29.6119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf2bea9-1516-4c46-a6ba-08deccd8345a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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

down_read/up_read adev->reset_domain semaphore should be placed around
remove queue.

Fixes: f5587b4740c0 ("drm/amdgpu: Remove faulty queue before resume")
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c               | 5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0506b90f318e..982b41606d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2358,9 +2358,14 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		 * preempted successfuly. Remove it before resume all so it
 		 * doesn't get mapped back
 		 */
+		if (!down_read_trylock(&adev->reset_domain->sem)) {
+			r = -EIO;
+			goto out;
+		}
 		amdgpu_mes_lock(&adev->mes);
 		r = adev->mes.funcs->remove_hw_queue(&adev->mes, queue_input);
 		amdgpu_mes_unlock(&adev->mes);
+		up_read(&adev->reset_domain->sem);
 	}
 
 out:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index fc1d179148c0..4e60d9364e37 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -493,12 +493,8 @@ static int recover_bad_queue_mes(struct device_queue_manager *dqm, struct queue
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
 	int r = 0;
 
-	if (!down_read_trylock(&adev->reset_domain->sem))
-		return -EIO;
-
 	r = reset_queues_mes(dqm, q);
 
-	up_read(&adev->reset_domain->sem);
 	return r;
 }
 
-- 
2.43.0

