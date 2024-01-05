Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A1CC3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 03:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 668C210E55B;
	Fri,  5 Jan 2024 03:25:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B3510E55B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 03:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oae54c5pob68CHJW2+1GY5F3xresNeS/n4WWiNqKjWU1CIjFiDa5TWBR2QD0iXjOxn1MQT/bkyWcCKJfH+QNO/kLvth68c7WJf1zjUQJ13FEvm0QYdI2kDzLrQAlrbEtAqWe/lBVrzrf4RHETTD3JTaOGkw11kaeOL2EQKlfAWPmWq0r+nxdMayC/L2IcbRX/1WxUIPI/oYTe7dI/lIDtl1pgOIt6Cql0f19rf/iWN+QwBlEOWMHZpa5c8G5tdbx+gmPyXf5oUt5B8mU7UkJ8vfc9RFx0cgxj1zItNoSYx8KV66y5d6vy1PvSKh7N63RwFEJNNPwcLW7qetyOcZgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRw2WaF/zuV93i4G+UNecejsYBcoOUibEaX/+WIRG6k=;
 b=mrU/f1qvbAqygRVqvr6T8Pr+GHL4O2qG8iOBr1nOL4nHnLNSTxJxq7xydnYtDWc2kxFHMNNTIwXVBUQREomMPoMMFeeI3jrlR8L+AQrd2gRgPVf9GkSyhafiXN1+4KllzvWNElzeJCHUjooOX0jHM83U0g+mAWNVQcHQCHET7NrfzQM3Ba3JzmPs57coCfRg9311XeruEGwLbY6mhMNR9urMGLzLqzTv3QLugkC87lMECGU81zVoOsxLpUpucPZpk8C4Suc38TfPVqVAzzS68q9HDoXD/5KaRlvFHzVzi0No79ZvKxEHfWUU2oHL1/Ru08BzJ1bbZiZ6ZeDjAtM+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRw2WaF/zuV93i4G+UNecejsYBcoOUibEaX/+WIRG6k=;
 b=PvQ/LzfniYxKS6DjnSXZtMcCj8zg6M58BQ7pzPmGFOaqE9h4QTNBQiPf4QuhkbGQPg/ogYuPoc8ABh4kJXf9F4LwLNv6huNQ5K4nBxMB5j6oO8qD/4VXeDOX5TNmeBclfbpZqSiquxT3Gyi/YtxKXqTHHNGvhxJULtORsI7jdP0=
Received: from BYAPR07CA0034.namprd07.prod.outlook.com (2603:10b6:a02:bc::47)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 03:25:51 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::17) by BYAPR07CA0034.outlook.office365.com
 (2603:10b6:a02:bc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Fri, 5 Jan 2024 03:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 03:25:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 4 Jan 2024 21:25:34 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix with right return code '-EIO' in
 'amdgpu_gmc_vram_checking()'
Date: Fri, 5 Jan 2024 08:55:24 +0530
Message-ID: <20240105032524.2644127-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 7562cb69-ca6e-421f-f235-08dc0d9e0483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JRAlmfjhJ8KxCsE78CcOMLZxXN3LWqDhyoM0an7nBByiOS3GIVeeQ8VY0b6uMDwve+bG1e5xMljUNw0MfE2VTEiNhC4CmCnTC0YXovgJ5IMwbHyruHa24gBdG7avcXiivTMfpuktPCcm4JU6JSOrFrwJtuO8e/vRcuRUtUqCAEYj5DYpwxntPR9OD5CF2FclMEPCG3n/rJzY2GgJK/oKm+JS8kP2Y0bdGo0QSFXIqNen2Xd/QqALTtjwHIcBc+sG2D3bhu71NiQViDAlnlpZRPqqzRaNtwu2dR4Yq4OqmcD3jOyk/Su6ZY0gEg1FH+7JthFld1/NqlX31V/G4Pp5Cn33N9qwt/7Yij7HXZGfvya2qI6wJtImNfZayxrUvNIF7AIrCE3vhmZRVg+3ezwvX6TlCy1svTRCL3pyoq6xcMeZLON5U0ppxXe5CXIBkyBDK9VxIs2htlHZYuw7AX+F8amVKnN3Tfv5+VGTFLeERZGSGaGiRT1nzL+T3Z/dD2wF/0Z1fBKHwvDk3kiEBM3CYxIOwXJ0xNvrLp3BOpYOnLeUjaWfmQQ/0INhvkkgLPq+n4XUVE6V8GnBqdG/T3fludgkitcU8QsMtAAxUHf+RH4F0+SfKzgFKnnfmUMrEH5WAn7tpV1VZP3SUFoglB3cVyKExOr5qRzLSyY87FWf3ttFGSl/ut7VpL723tzojYi7kZJF6vWCBtlHvtyTYfusrIr6yoX96R80lRnPdTFiEtxkyyXb4qHl6eCoYbVMyTOud3anPyCTGO7iX1owQ+hqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(40470700004)(46966006)(36840700001)(47076005)(1076003)(2616005)(83380400001)(44832011)(2906002)(26005)(16526019)(82740400003)(356005)(110136005)(81166007)(6666004)(316002)(41300700001)(66574015)(54906003)(8936002)(36860700001)(8676002)(6636002)(5660300002)(4326008)(478600001)(70586007)(7696005)(426003)(336012)(70206006)(86362001)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 03:25:50.9486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7562cb69-ca6e-421f-f235-08dc0d9e0483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_gmc_vram_checking() function in emulation checks whether
all of the memory range of shared system memory could be accessed by
GPU, from this aspect, -EIO is returned for error scenarios.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:919 gmc_v6_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1103 gmc_v7_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1223 gmc_v8_0_hw_init() warn: missing error code? 'r'
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2344 gmc_v9_0_hw_init() warn: missing error code? 'r'

Cc: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---

v2:
 - release temporary buffers, if memcmp() fails (Christian) 

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d2f273d77e59..55784a9f26c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1045,21 +1045,28 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 	 * seconds, so here, we just pick up three parts for emulation.
 	 */
 	ret = memcmp(vram_ptr, cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
 	ret = memcmp(vram_ptr + (size / 2), cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
 	ret = memcmp(vram_ptr + size - 10, cptr, 10);
-	if (ret)
-		return ret;
+	if (ret) {
+		ret = -EIO;
+		goto release_buffer;
+	}
 
+release_buffer:
 	amdgpu_bo_free_kernel(&vram_bo, &vram_gpu,
 			&vram_ptr);
 
-	return 0;
+	return ret;
 }
 
 static ssize_t current_memory_partition_show(
-- 
2.34.1

