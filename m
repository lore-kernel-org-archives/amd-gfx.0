Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E424AC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0131A10E2AD;
	Thu,  9 Dec 2021 16:54:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A367E89F8B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke13kr5o2DlstH02Vq68P8ckjF2vnEqqLeS9Ckjl4fAypkqmmAe8VDa8HhkhcrvnoZTVZjGEGAPn6ylvazQvO/tXVRmDDzcGKw8k6usyGGIMT7T5Mf20YMYFn3c+JVeJxM5iIlSaCpsGqfhKV4K+poxSTo3iSFwRvDTjQYm6j3Lz1sw4LeiN1WjAEgJsYtyUTtHZsvfW9yN1Fw2NttG8r//C0nqdYf2/1zFKGtHpAsu48BOVwehuWpbEWbI3TN7FnpiHyDfx9qbLkE7UZ8AXJZRbOvrGtV+I8JUktgrqyf7GKw+1pGPBhZ+hEDspHRfmijH/GwT5PcSUlIN5tP4fjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R46qMxTRREJ3WCTyMgCcgSt+tijvDU8BWN8TjpCUazU=;
 b=ENTdbkaLUTXWvM+AfB6IDKHcoBMwRQATQ/2PGb7E5YbqRWnseDBMQO9ZY6VCGkb2C39b2s9E4cHIjriQpxZVhwvaC/2zzY69XaXyrRiuW8fp7pGRrr381Fi0IZhTEB77vvfvhginDvsmdnYJq02ktnUMzl2Q6TfoP6cupOPnAFn2WvfO/nnI6UlNSFXwsenSmLvWbqsmrWj1ptvJFuXMHJ6ulJnuELg5ypiGMhwBRVU49xyMVI8ev14f1iffACuQrjj6+br7xJYLEF6jAgOMwbe5e4Qyu/1dbLICp6h2NuUOXMWk5s1PqLhWnYOQeHHmI0t1t/827vXM4MfJexUtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R46qMxTRREJ3WCTyMgCcgSt+tijvDU8BWN8TjpCUazU=;
 b=kri2HVmCUZX90KXGK4BMCgrcvmws+ADfj1KSi6zDCj78p4X74qWpZp5x5/2G5kfhqmwB9YEG41teu+4l+KCfY9ifLUMaeJd+SEUGtO8dKqvIfYLZTnnQwiwd5wGOiAbhMC78pJm6IiMr3gp+2JqEMBLkd5eKEjvXYI3B//o47JI=
Received: from DM5PR07CA0081.namprd07.prod.outlook.com (2603:10b6:4:ad::46) by
 SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Thu, 9 Dec 2021 15:47:57 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::7f) by DM5PR07CA0081.outlook.office365.com
 (2603:10b6:4:ad::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Thu, 9 Dec 2021 15:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 15:47:57 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 9 Dec
 2021 09:47:56 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: Reduce SG bo memory usage for mGPUs
Date: Thu, 9 Dec 2021 10:47:15 -0500
Message-ID: <20211209154715.20956-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209154715.20956-1-Philip.Yang@amd.com>
References: <20211209154715.20956-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37134d98-e1f8-4fca-1cc7-08d9bb2b459b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4399:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB43992D38F486F7128067C808E6709@SA0PR12MB4399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuYJl0/3BBvUow14ifBf4jny5Ys/6rk3r7kUYcuimozlScgKKjVKEfg+KHlI8y1dEqebBejBtGIncHtc/Ymu2FV/hFY58JY4vbvbeXYDKS7YUJ+9hGLkavzGnnmEy0JKUX8PPOVJYBmjgj8GY03J9Rh7TZINKdfmk4AA5wUAsmDLI7xy2nFc2LOZUMLxS3DqcyQ8xufd+6sfLmcll7f7uxBbrM7AeDIsWywkycH5O6FHCmQyx/Cmn0NKnWycRBOXxUPb4jgz0cfD9veiq3xedZU07SJWK/PTGkn1SnuFvYou5Jendwg6gOT7O45E4L6CmBJUWyUqd/RCmnn1uoH/1aOTUqzNr4/oxU0+DnP1im9mm3pAP3cs/g7zT05MKuRz2//Ce/EdI/gn5em8JOCTXM6A8JWkodZqWcbbRwaBio3dKVb7vVAGnyrmjgqTL++C8Vj8dskZlxmY9Y0EOguyM72FGVaYcAiMWR74GLf11jWb6jAYycBFqLyrRgQx7Eh1W3z68y4M6piyek2nz28Ob9+sd4boyP07kPddXDbaGDZRf1gdBYXYl18ohzWkX/RUywDZeCLum5g5vGiavVHiF2O1KbAGjeaPE2VZ4NRk1JxvcDv47mE2QgD9jSrkB6A3M+UW23rHADTcSCNqnIR2KPQlLA+exKf1EHTe1/dtCxw1fQFfmZsL8cdFfQK8zHzlyC/3NmMTPPS74RGhsGO125y+q7Wi1U7FjAvyWdAb0lGDyGydMMA3650UN7LQ9qJvOaa578mTS1r0fPC0lk86bnsioUJ1QFNWL3WA2X4owIs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(7696005)(6916009)(6666004)(82310400004)(47076005)(508600001)(2616005)(336012)(426003)(316002)(186003)(16526019)(36756003)(81166007)(83380400001)(356005)(8936002)(36860700001)(1076003)(26005)(4326008)(5660300002)(8676002)(70586007)(2906002)(40460700001)(86362001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 15:47:57.4548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37134d98-e1f8-4fca-1cc7-08d9bb2b459b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For userptr bo, if adev is not in IOMMU isolation mode, RAM direct map
to GPU, multiple GPUs use same system memory dma mapping address, they
can share the original mem->bo in attachment to reduce dma address array
memory usage.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b8490789eef4..f9bab963a948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -708,10 +708,12 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
 			 va + bo_size, vm);
 
-		if (adev == bo_adev || (mem->domain == AMDGPU_GEM_DOMAIN_VRAM &&
-					amdgpu_xgmi_same_hive(adev, bo_adev))) {
-			/* Mappings on the local GPU and VRAM mappings in the
-			 * local hive share the original BO
+		if (adev == bo_adev ||
+		   (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
+		   (mem->domain == AMDGPU_GEM_DOMAIN_VRAM && amdgpu_xgmi_same_hive(adev, bo_adev))) {
+			/* Mappings on the local GPU, or VRAM mappings in the
+			 * local hive, or userptr mapping IOMMU direct map mode
+			 * share the original BO
 			 */
 			attachment[i]->type = KFD_MEM_ATT_SHARED;
 			bo[i] = mem->bo;
-- 
2.17.1

