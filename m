Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A34C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 21:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A0510EDB1;
	Thu,  8 Feb 2024 21:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KX+G6sNi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CAB310EDB1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 21:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViSQvwcyQdV2HVKlfucntL3TFSuwA+HWCD1z7HB7LRipKPK+clKZUXC/zuJTAdQI2k9fcFV0Gk7ZOose/pgh1cSRUtUmnZWUyl1jPWYbBVmA2Xc5PGmfSAfr94PCWW8zX2iBnw1RqradnNlChmxRhqJYMYq0sGOJ9lWI4eQB9xclcZJ+lIZey2mgOv4KmhSDsAvd6xh4iKJveSA7Nhows6w8HupwuVH7knkQprIw+Zrq0fEeBkECIR+FETaLU7M/96KwxUyuyPoFUKllI1Mn+KaCRzywfJqvfkbLiZt+PBZ5BxOpG7CXPojOmRs8z/FU0Y0VQhRD6Z9ONjU448H+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFX4r3b1uqyPWx1neK0dHat5edW8lvDkWMtmbBT7Ph0=;
 b=CBCiCXw/w9c9DqAdSCxaPyqLPd5w0pC7YCWCBoRP6q8iDmn78fOhZNCM+oYQa3V07vHzyyWos0tiE50mD1IGYO4jbx5azIjRZZSsSdTCNscv83T777aE1ycxJZx0KHB53zkZ9uED09Hao0PRQFUDZ5i9oqcQJjjuBEAGali/D/H8dKnroFKzyFGLxoUoqbzzjVfuYNULrIT+JxfcsJuQ74bmDXAWC9fNaQ5YFqEpZ3aqTIUGG3NLVZ5t5pk7ph0sKhaV6NgRJfnYJuMN92uR0K8EjjdGEYIL1+lEK4BdGF7yiimvOvIOqedv1WVYoXrQDiqYGcHZUwMIlwuMDLktAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFX4r3b1uqyPWx1neK0dHat5edW8lvDkWMtmbBT7Ph0=;
 b=KX+G6sNijzx5FCZHSj0Aj7Mi3YBhJ1rpJ+IePM0dCixzXm2jVvMciKzb6F3XWr0CbTCPzEn/+JHD3wFJ7iALpk04Ylli3U9nGFqKmUHF6Oy49aFDIkuSVVza7svMImI6fDBcyrXUS6RGzkm75rF+/jJ0nQHO43ghMlfOWu1QGQ8=
Received: from BLAPR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:32b::11)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Thu, 8 Feb
 2024 21:15:16 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::76) by BLAPR03CA0006.outlook.office365.com
 (2603:10b6:208:32b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 21:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 8 Feb 2024 21:15:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 15:15:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/psp: update define to better align with its meaning
Date: Thu, 8 Feb 2024 16:15:02 -0500
Message-ID: <20240208211502.431836-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b3a5b7-87e3-4769-0d1c-08dc28eb0bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yCb0bf6LKRYj5TrtjofyaEu/xH1nV8gD6GwPou3IuCIRbeKol2IZPyAZkTKxpYYc8+IJC22QvBNxWT39Jir/0T/UtiyuGjbF+mGCJrYj7qnSR/jx8EhlWew8rYM5PWMM2PZmPiPgms4iI5plD16enOZLmlxcPX/C12vYDGlZlu5o4grZZ2C922LhttYQUfTAGQ0QnJ69XFUoMjvJS27JZxH2PlkXdUJyYlttakPcBam/cAEFx/WVGBuqlPSr9vbLT9u2cGjQa8WH64axkjIE3Fgg+7sd5OBGvmNrPnlvzNWA+NzMvSDDIwTo1yx7aI3seOlRlCBFL1Z+lQmg/EAXLeZasP2QQR5JYVZKUeHL49QgWU6Uj9/P0hJ8vKCe4F7JmsdW6xC2WFNBmGgLMHJNDv6HMd2P/d572wyAGLOHK2CYe3Dd6k9jrYHbl1mghV1Xq98I00lwFPx0nkkI9yGPJWH4kHga2Llk0wL8VfUl5Rw1zaBo69yEEaIz4seZTtxKVY05+zvfofDkkwGEvGZaV70ykBFxDBG37IB6cb40gAu9X9TaDpDY74yr/ALY9+GueKxhsxiyRfaZ2+PCVfbWFBYdmL4SFdWEZPx6CUwJyc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(36840700001)(40470700004)(5660300002)(316002)(41300700001)(2906002)(83380400001)(426003)(2616005)(26005)(16526019)(336012)(81166007)(1076003)(86362001)(356005)(82740400003)(36756003)(8936002)(8676002)(6916009)(4326008)(70206006)(70586007)(478600001)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:15:16.0564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b3a5b7-87e3-4769-0d1c-08dc28eb0bda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
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

MEM_TRAINING_ENCROACHED_SIZE is for BIST training data.  It's
not memory type specific.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 9951bdd022de..47ffaa796264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -203,7 +203,7 @@ struct psp_ras_context {
 #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES	0x1000
 #define GDDR6_MEM_TRAINING_OFFSET		0x8000
 /*Define the VRAM size that will be encroached by BIST training.*/
-#define GDDR6_MEM_TRAINING_ENCROACHED_SIZE	0x2000000
+#define BIST_MEM_TRAINING_ENCROACHED_SIZE	0x2000000
 
 enum psp_memory_training_init_flag {
 	PSP_MEM_TRAIN_NOT_SUPPORT	= 0x0,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index efa37e3b7931..2395f1856962 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -506,7 +506,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		 * before training, and restore it after training to avoid
 		 * VRAM corruption.
 		 */
-		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
+		sz = BIST_MEM_TRAINING_ENCROACHED_SIZE;
 
 		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
 			DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 722b6066ce07..0e4329640ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -561,7 +561,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 		 * before training, and restore it after training to avoid
 		 * VRAM corruption.
 		 */
-		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
+		sz = BIST_MEM_TRAINING_ENCROACHED_SIZE;
 
 		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
 			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
-- 
2.42.0

