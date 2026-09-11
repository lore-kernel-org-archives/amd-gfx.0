Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088A9C88E5A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FA310F599;
	Fri, 11 Sep 2026 17:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S4ACl/y/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1551F10E4CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl8Ih9o0nPl6eFaMQHSXXIOxB1yw59KIYXdZTus40onXGlEGrCsrFY1pOL+zQ1B4FWf9AnrOk+ss7cp5OtPfBO/lvm5DG6ofOPeGFzAzS3rDiupHCx43P18XbNlfqWHzdk8mykdqSaN3zXugiU4jxnHiYghJHVw6qfRh9o1d6IlwqMcyPtFz6CLSZZk8CaiLEm5lQCGdQSMQ8kOdcwPrQspyZR+gnbVCrwVlZbzS7h6CUt3Xey2riop7fSOjbmrcvRwZE93gchOEU2ir8EuJVtzxg1zU+yO3J91tXf5Us3rnI0rrPIv0gGP5aFnZvfJc3rnxVhl+DsjdjN1DJiig0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5BS6bgv1eqrQJstllZot7rff4L9xuiPJ9R4bP5CAEU=;
 b=LfA4D8UZ2Hl6BqD05jT2Pb4dWnDthQrhSE5Qz7E0OzodEWINpCFdZjJm/iXxEGPxzqTxXKPUAoZcmP1O3lH/oNVaOSSdAlbOsq40eGo2gL0G92/9KIv98dRJHc/RDxPLnA+aKPWEO95jJmr/H5L5+I2hFNaRKQmBCzjEhzt9/Hkds9xgIEQ+9PUmBQqjIF28yCWvoXjPrx+Ai52GupnvPCMoHYpijq+mmjONQY+h4XMiC2M4iu+i4zFY4x0eaUe55GncBOfVS/4Npp+xtRYXRdk/1NFILsVf8DkvVP0EnzTfkJtS/uG4P7YuLfV3V+By/ECpUv1k/ZXm/uD9AmiUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5BS6bgv1eqrQJstllZot7rff4L9xuiPJ9R4bP5CAEU=;
 b=S4ACl/y/9mATG1M4BqPsNUcvVyl87zIP9VbX+vkyE1pmZqiVEf2S+MRFxJmucWOEPSxGI6gjEdN56f5CLBCYtLPQZx3naFGZ6FWcDD8Of/3+1OV2+qgq1XIqqaSqaHNkTH8WihkLNpTkVQPeKpIa2uFmxvtNZAoqbY4OAj3H+f4=
Received: from CH0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:610:e4::35)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:07 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::4) by CH0PR03CA0210.outlook.office365.com
 (2603:10b6:610:e4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/23] drm/amdgpu: add tlb invalidation method enum
Date: Fri, 11 Sep 2026 13:55:32 -0400
Message-ID: <20260911175544.1314467-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ca0849-a2e8-492a-31b4-08df102df16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: O6z1JIxh7Zwrtk29lF2mFrPA4YzYF0JodCGQaH5yBuKGrx8lHd9n7IHPag3YELs9T2oirVeVE515fPrOBcT7JVa96PbWh4dN0H7VceHxvH5OevT2P2i/F8WxNQa5fL2mJCcA2+Nj9AlxSBo/Xs+yZyjyYPuLVYWpregyzi17JSo/OBgB9Bj4ErPn4txAsnU+ntkLGzdNgzAi0O/m/IeXJOs63bq4Nrw6xhW/J6s7nPtCG83WZ3s6sHklPy3J+8ZE2WokVRFR7iSFIuqPjgBmgwcXmRztc4vXfDFmn0d+12KjikwVH/AZ2L7VUT3xGSdyxpq3RdcW96qj2O7i1g+0I+C5/E+3qB1yx/yqxg9OJRfP4UZ3A5uPzqOpjnP/Pfu4Px1NeUv4qEHw8Oorp3aLcFAz1YkLAmBKqUS9kqoCeacNPZLULLv9gCzqv95dNqYqrjpgsYGqGi//ERgq5t0u2EqnfyN4U6/Ohcj2kawIwDORL8tlQPDS9l1wM8Ta7zfEEPxd+ukqCm5HOOgmuJp5T8WYFMaf+LKCjDvH9VhLM/NAa3mqzbR1Phi8KhbqFhghl2obhuoUt09KsdgF751nvL55pUNQz1G0plnKMFfH1/jnZmeGhVkejwZ4SH97IS2C2zdP2df0Eh07oYaM7b3Bp7r6Ov6y1zp6aKjbc1uA6e9IwxuihGeieAhUThnXos8O8Uvn5E5Laz2UtIXcUqkSBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RScQ5yLnvqcHUsfZ16xypZ76c7MvR+imT9PVA9mDfX8SCB4I+uXg1NElAhgQuIbB0c2Wp1oI3PA7bWk1qS++YvdMwjuGyshWnaF+Ik6RuyBZW0nV8jZ1AbtuZXicAWS/x+Jp3TvR5CdNLItmzCgwG8KLOPSxaybw2pt6a43yBb185c7+qH+cBfuWnnx1WF63uvljn70HGtsWZO4jc0qGW9ECp8DrosshJjWW/6CtYL5p//zCDU7uovi8wWAPdzGfbrltTjauYMKajMlTp2yTElX0nE1slGylcCF/jXFLnjj5reuiKcYkq8oheRTywxCIdmZSPqaPQIXz7OYaOjJTADwpwmBLkuaO0Vfit0axO0VzPTwO9w9iF/m21XXEASoDRj0XCT+I0eze0+95ccL/K0VCgABmBUeHJQZdjMdvdeHfVuJTYtRdLmTxMsbIbVdL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:01.9478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ca0849-a2e8-492a-31b4-08df102df16d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
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

Use it to track invalidation method to use.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index cffd5ca3fc66b..55b696b85d544 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -98,6 +98,13 @@ enum amdgpu_memory_partition {
 #define AMDGPU_GMC121_FAULT_SOURCE_DATA_WRITE 0x200000
 #define AMDGPU_GMC121_FAULT_SOURCE_DATA_EXE   0x100000
 
+enum amdgpu_tlb_inv_method {
+	AMDGPU_TLB_INV_METHOD_MMIO = 0,
+	AMDGPU_TLB_INV_METHOD_SDMA,
+	AMDGPU_TLB_INV_METHOD_KIQ,
+	AMDGPU_TLB_INV_METHOD_MES
+};
+
 /*
  * GMC page fault information
  */
@@ -370,6 +377,9 @@ struct amdgpu_gmc {
 	bool flush_pasid_uses_kiq;
 
 	bool override_pte;
+
+	enum amdgpu_tlb_inv_method gart_inv_method;
+	enum amdgpu_tlb_inv_method pasid_inv_method;
 };
 
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
-- 
2.55.0

