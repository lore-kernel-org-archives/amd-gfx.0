Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D88CC3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 07:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9D210E0C8;
	Mon, 12 May 2025 07:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tc/Jakd7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADF510E0C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 07:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVZXUmv5s2DvmlkpTfM3/ThTO036ZhSmBaOGizKYvhqlZN6pjLL/yLWg+ZoCvJXiv+D6IpsWXXB51LlQByi7BTXn55wHYvY5Y1OiRLeD3xW0iilVlXVdB1zOvmgwRwnE1alGTDQfMEhDN0MGoyIahF1boGhHk8anqg6k0HoiMgIi60IMyjoqXCdr1MOHhaLQG+lNf1tXwKXvaVEWRaHU41X0Ug+kLAeS07lploL7TlpRRnm6kCIaLx2TX0V9KpjIjqzjsufyrQJIqjUpiuJpMNlNxegus2+U5L/ZDeYSxJbPafQDrD9ITHlA8usB8ygLcaUv7Gx1gKGOB7FRHoxybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I401rYLT7a/OsQ2b3bEz1xcpzMfuW09M+NZfUwjKMNo=;
 b=eZuM9vfrs+DCxXQuMHK52TYNKDfunFThRSUQtgWzzJUwkGYYoVpaIiNM2OB3UfYAD4tSCovw7x3s9urI2IR1tpL1zqC7I5H75b2Zob0TgaswJxUVNgDZTKruv8S4eb6/PMpsE4y6UXLzzgFcZTBcyOes0V7eHQ4kfCc3duYE4gssYgPi2oKZ8WRC4bF0PLHq9ptIQIBJQ6mLVAbqrgimEKU2paIe1E06sHqRyLYW7/JG26uPH2RO1fbpkXgJq0fJaahuJZWeDjoFYuhvd1ZSsugn2Cq6n6CuPLDjRrj9ri37iavQcWpkIItp0ShET0qIIO8e3zL+aNtAp3rTjkpfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I401rYLT7a/OsQ2b3bEz1xcpzMfuW09M+NZfUwjKMNo=;
 b=Tc/Jakd7pNDGpKQKT4V3rCjTk90E9fsrO31KY4SLVKz15eXVrNMQSEVrkRcfBw0ARiuCCGCRTijJiUq5bcgOUpXKRGHFf1qrFVuqrmmwTGhFSihlFs0lYAY3MQqU5mdkpdbZ/sA2QYadWteTrpcQyYVrCsCntz+9ArIU1+XQBKQ=
Received: from BN9PR03CA0782.namprd03.prod.outlook.com (2603:10b6:408:13f::7)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 12 May
 2025 07:30:16 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::90) by BN9PR03CA0782.outlook.office365.com
 (2603:10b6:408:13f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 12 May 2025 07:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 07:30:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 02:30:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: fix userq resource double freed
Date: Mon, 12 May 2025 15:30:02 +0800
Message-ID: <20250512073002.401719-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e2ed6a-eafa-4bef-c911-08dd9126d725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lCGkECCFua6ihJB21bfT3uKlal6DQZ8IWlHHe0TWPq8F31UjM/nJ8wxA9Odb?=
 =?us-ascii?Q?JeesdnC3qyzojWO1AU8ifzQZ3QaJmhdErSKNkWJbILf8+2RU++b7Ez8irdTt?=
 =?us-ascii?Q?N7swrOMdU0kVH4UKVFtbM3vbABg2PPUlNUunLsB3FHnmcNMaeI3WnUFL5vcf?=
 =?us-ascii?Q?DGk49vTrI1ki2/n5B/NDpKcnUsE9NIi1N/LFLty3v7jQpCNZoTh7ZMZUIYv5?=
 =?us-ascii?Q?dpfLp8+6BALU+mY95PPczmEsowsrADlnZ2WxxlCseKfEJaOEh/d7KDFM/sVZ?=
 =?us-ascii?Q?2jeWWXagjH1qHVWvTWxqX/X2l02VC/iQ8p4HjbRBLatTMZnb/ghT/1tm25ZH?=
 =?us-ascii?Q?1yj4/DzjmBtpN28oaCH8RSFV8AX8JWb4DGsGfuOESHfTEp6ixGdCksVOZN56?=
 =?us-ascii?Q?JqjBCZ8wGJEkPmTVm+dA1JRtNJfjJvz3CfOf8XCj8WWiOEdoRq4fmSQn+2Vd?=
 =?us-ascii?Q?njz8/T+Nw9gHuh9pXrjbQw9c61QrUx4A1Gf5xgR4IE5hOGflrUb58V/Dvo3t?=
 =?us-ascii?Q?mp0gktVMnvebMvwMA5faNuB1Hq4l6Xk3UcJL8g/J7COUkng03GDFZoKiyYq+?=
 =?us-ascii?Q?WoaJMrFFccfEO5rczE8jB2BWX7VPJTny2pbMkNXgeI19ZDboB/srihi+jwxC?=
 =?us-ascii?Q?h6Kxfb4DnZ4P2VKQJR9OnVCpTdTAMR7kgczTGYQP9HOyuvgLH9QKHexsBZ0Z?=
 =?us-ascii?Q?X8YAFF/ehMnRtQe22kBWuUa/8F9exXGADbaTsblk96zZDS/h16vsKwUHaYxl?=
 =?us-ascii?Q?Q5eJN2thkV8x/pFnNXD9gixUOwuWUiKdYK/eUqg5+BCG5OaN8O3LrxkI9AS1?=
 =?us-ascii?Q?AndOZ+0S3ISp86j2xd/C8AE0Bj1igHxrq7qANjyM+wl/lT6SbJ9x1jgp+h5i?=
 =?us-ascii?Q?a3NRZXpinkUHEcMy+MN9xB4nRD4eVR2xaM9U9GND+Imf0U0aKWzAeJvvU7+V?=
 =?us-ascii?Q?K+8cFcw3HT+ICPLuQsiIaHWMcuG3LfXmzSxOO6vOq2/STHutvC4veDTOU44m?=
 =?us-ascii?Q?qzoxv7L33ENfOPSAcGRiJ/PKOiG1IRIGm5BxNL2wvw70PNo2syASc3fcTMOb?=
 =?us-ascii?Q?7u8i7ZuokgyUbkXEEcS0oiNqa7EGHjfWWqpiBvlXxnbDAh2C9o+qhh7uvo1o?=
 =?us-ascii?Q?EnMeSp4vAnNWa73Bx2r1yRHebTFXRvn8Igpq9wAOzrqMzW8Djb5wgISKC6tc?=
 =?us-ascii?Q?HlYLl56ptcto6xVGtTyEL0w3t4HUkAjf9nMB374nNwtFH1O8r5E38OFZv5mB?=
 =?us-ascii?Q?rjE5bwI7cN9qFDj+raOp8UkVyEaGIULpoQXUsfObJ2bDFi+w+YPxpiSpE8nI?=
 =?us-ascii?Q?pEc3FLMqlUboF6U8eGwGf90sLTb4nhkApj8fpufQzcRUBhAx4E8kf4hlLsSS?=
 =?us-ascii?Q?vSl9U77Zuw5re0KzWMoHl+a0TsCvnN/OIkh2ygi8TqB20gSzHr6mCQBmxki4?=
 =?us-ascii?Q?4e3rPzJeKcKTKM3JdsTWuuMxmAB6kqePFgcKHCJpyusz6sUTso3SGoyBMRiM?=
 =?us-ascii?Q?wLufMLaqHLUUsrq6tC/DV1L6Ws5RUdH3lGo4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 07:30:16.0486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e2ed6a-eafa-4bef-c911-08dd9126d725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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

As the userq resource was already freed at the drm_release
early phase, it should avoid freeing userq resource again
at the later kms postclose callback.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8d4a2aed7231..cf0f35a7daee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1502,10 +1502,11 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(pd);
 	}
 
-	fpriv->evf_mgr.fd_closing = true;
-	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
-
+	if (!fpriv->evf_mgr.fd_closing) {
+		fpriv->evf_mgr.fd_closing = true;
+		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+	}
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
-- 
2.34.1

