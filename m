Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFADAC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED3510E0C9;
	Fri, 10 Nov 2023 14:47:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D243010E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 14:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIr+jezpiTRGxEXyzt1KF6rYjiHM88H19N/yUxNm7/QNvYxz90xTJUzVjiyLwreWpQp3Z0pu10vSGH5MjZTTbVCdxrb9ynfTJ2jgmp3Ln8HNcCbG2oH4JUuOvSQSE/2yQB2Mb8ARvf7xcE6gEZjbqcf5c3l04+x55/3U5948CrfNA7evIhTdy28l9M3HpFFgqhy5iIzyeZlhPTsgGpxKVtFjTYm/yZ5Y/SKpC5/5Mqh3reQ0+idSaZl85mfRIsqmkRQNaFcdc5K76PsdCPBpwjreM2jDKe53ujoJC7pSTMU4c4XtvYGdBGaSOBPtk2EQ6SwBE8o+srl8j3Fq/iTG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OCU3iPye2+HhHHTL8IzMCqqdwjt2dw9OtjpStc7/hg=;
 b=URxfkA+MjX97iLb/VBvyeXRJzTtXvg7z8NrvabnWb1OsIZRxRnnUJZyXOovcPP4d3G9KA5w4eovbi5d1MkHJyUhgYwIgl5miWfJp+6ayUEZjFc7gttzr31ZOZuf4NotSOHAVTG6ZvHza+wZ1cB7ts7YJdtKJCWRNeLCLnQip6VQPazjk5ltH+qkWHgBytss8TgipnUg/13vk+Tam5ZLGBG82UB2u4T7VfOPwnBbr1S3vl3Zl/EBBW/9vFW3pxjvf5T0aOSgxB/pfMoxxNbCs0SH0oJ+/J2VGUJH9Z7q+mR5n9mWEzDlyZ6qNn5aLA1ssdBVuO45dhn7ahorvWwbqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OCU3iPye2+HhHHTL8IzMCqqdwjt2dw9OtjpStc7/hg=;
 b=qo5AShqoQB8kugcHNXiAy29i3F5qYQ6Vtqwc2xw7K0EuY6ADoMDaE1I4ruw9nvP42pQthuc4HPwzRmo4/yI8PZI7aR5ABYj1E9j10B7ZtCuBLp5R2a3CwahujPmge9lFX1hpMYtQQiL9byy/w7NeIsrFZBsOPUqXWKTXZUlsBns=
Received: from BYAPR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:e0::18)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Fri, 10 Nov
 2023 14:47:17 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::87) by BYAPR05CA0077.outlook.office365.com
 (2603:10b6:a03:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10 via Frontend
 Transport; Fri, 10 Nov 2023 14:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 14:47:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 08:47:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
Date: Fri, 10 Nov 2023 09:47:01 -0500
Message-ID: <20231110144701.1895397-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 385a41b9-c612-4cc6-ab77-08dbe1fbeed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rne1pKGft9yO0rU5roNcwf9nbwjT7IlDZ9nQ6eWpbi9pbYCBsz/AQV3KW7Qn8HO9F3/MMCDGxKp7kLRd5Qptn4Z8uELjDX7atScvPJ+Nn4sVq9gDfg7ZPSQf030fk++fMa3v3ahRB07hP7SpPTgBLWeEv6t4SEclU33QiCgc2l54ld3zWp/TzE8HEwAqVU3F+QEmQ3k3f2ezdEsOv23f6S1hRldbQr/PmPGNTbVO1OSGaXgpy5vvqJgyJLZlraqhWk7Zb1+nxX+GQwVSeDaFWRNeK2mlXcykhAnlCPbWRGU7QdJ6WEizHd/0BZXx0KkehgEKROkvbOZm8RGu52lrq9ixdZk7quWU9HbafZeoDJdA5LQHnujz7Zdjz8uoH/rRRlXsqqQCPa1WlE7EN+FpRm9wzY6Wip2UQbhoSKln4WHbF7lRwvvkEnz/JI9R4bx8+JwFqEEuElsIPSdLWvodDnkZyjy2xI5vZXlr/UlmJut5w1yWIDRDws8BhdyG6B9a/XufoTWW2sygjorV3Im+/ROECmuL7T7fTS+XemjijQeW+CiFuOIHKj4HNlu2p13A7VYPu3k7v4W2GxCu2PxWW2/UL8wd1qoEWoQJNSotlBTrGRNU54P63EOPSVeqfXEkltymdwXpw8qM9LIM0BfPfyDZ39t6eiXGEVnNWrS+Nfxv3zckRrk8sjethiAAciQQjrjgP3KMxX6FWoJW8xii1KFAl963E5lkUYClYLOm0uLbAG60g7waYyvVZnQwocRCrCQbrG8JdQbh1LSQzyLTZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(478600001)(7696005)(6666004)(2616005)(47076005)(336012)(1076003)(41300700001)(426003)(2906002)(26005)(70586007)(70206006)(83380400001)(54906003)(4326008)(8936002)(6916009)(316002)(8676002)(16526019)(5660300002)(36756003)(356005)(82740400003)(86362001)(81166007)(36860700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:47:16.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385a41b9-c612-4cc6-ab77-08dbe1fbeed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This worked by luck if the GART aperture ended up at 0.  When
we ended up moving GART on some chips, the GART aperture ended
up offsetting the the AGP address since the resource->start is
a GART offset, not an MC address.  Fix this by moving the AGP
address setup into amdgpu_bo_gpu_offset_no_check().

Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: christian.koenig@amd.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cef920a93924..1b3e97522838 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	uint64_t offset;
+	uint64_t offset, addr;
 
-	offset = (bo->tbo.resource->start << PAGE_SHIFT) +
-		 amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
+	addr = amdgpu_gmc_agp_addr(&bo->tbo);
+	if (addr != AMDGPU_BO_INVALID_OFFSET)
+		offset = addr;
+	else
+		offset = (bo->tbo.resource->start << PAGE_SHIFT) +
+			amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type);
 
 	return amdgpu_gmc_sign_extend(offset);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 05991c5c8ddb..ab4a762aed5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 		return 0;
 
 	addr = amdgpu_gmc_agp_addr(bo);
-	if (addr != AMDGPU_BO_INVALID_OFFSET) {
-		bo->resource->start = addr >> PAGE_SHIFT;
+	if (addr != AMDGPU_BO_INVALID_OFFSET)
 		return 0;
-	}
 
 	/* allocate GART space */
 	placement.num_placement = 1;
-- 
2.41.0

