Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A99C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 09:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07B31123FC;
	Thu, 13 Jan 2022 09:59:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C701123FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 09:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbyp+XtmYv9WV/oYEsjcaFKsZM9vEqDO+skz3hbctUYFda32rpdFSzTWiaOMHZLmWBeGikF3tGgSqAV8NQIgoturRkB2i8tA/YrzaCtuT2OTyEOSPU1kbdFoIhU3Ku9AgFfL7HLA6W6hc9jAD6L+4EYD7S+3abvgiNHuk4jj1mL2WF4Y2ntw3l2FWauGAJHaihfQY9jJxqvs9KOEE/0wwMxS4pOOBaUbcuVyjieEObdExIfBBJV9hz/Gp/mtK1FpjDrMJdIqSeav8yV2VO29yoPi774k0xRdskjw7iaEpBqTdNlx5OgJdzjqQpa2OUrWgnFPQsU6Je/iuhOMLmfttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0piPmcAmiYk0YnjNVwIDOJ5B9PzofJJa58LvhfTFYJo=;
 b=d8p7mkjsfkGm7a+Xt9LV/8ZhvVUD3Ek2OswAd3b99pYYR1ODDJ2SNDF5pGUh4Gl4/5uDycyPD+I5Zfbq9tY02gjxdH6Kh+n0vRPirGrHSuI6uo9cTWJf6UNWCw+GnNP7ht4lZEifw/yr8lOrcL2Av5opq3V1sPiRqjH2DMYAZCKzO1eX3ewPOyAdnOCFx+zQknjKBJmviRpCDuwC44bedvcIJzbQ/31zHJgIQI6e82EQvyCU09xeVVsASpadav066U9xpTIEnOyNGnfOARuGwRC0cQs0wQTirbQjbFnvwx3FGlauQuKz+VQfD3Be8ra2tiZTpfOC+FYOn/jdvcqfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0piPmcAmiYk0YnjNVwIDOJ5B9PzofJJa58LvhfTFYJo=;
 b=3mMmwpEEIPnpozf6k8cAr6QUd/1r+P4p7P0RlEZwO8H9nIIW2AgLpBdxrHbgDf+f+XADcjewdEw2Oiz20LFETTfdtemB3B6ni8/j9mC77jzdbRl+ic/2FuSg//vMPG7xdyWCV8EyV7UcQ/kbN3qHebv4T83kJBNZRk678/kYh3k=
Received: from DM5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:3:23::19) by
 BYAPR12MB3303.namprd12.prod.outlook.com (2603:10b6:a03:131::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 09:59:40 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::96) by DM5PR13CA0009.outlook.office365.com
 (2603:10b6:3:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2 via Frontend
 Transport; Thu, 13 Jan 2022 09:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 09:59:40 +0000
Received: from jenkins-MyrtleD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 03:59:37 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch v2] drm/amdgpu: add vram check function for GMC
Date: Thu, 13 Jan 2022 17:59:13 +0800
Message-ID: <20220113095913.30962-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21686b7a-8929-4029-336b-08d9d67b6a4f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3303:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB330317D70AE92D303B870ECBF1539@BYAPR12MB3303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkCb9QaXyAAZZFmAbBtQ/iY7bjgZDhbnK/wDjvZdSwa/9Rsq6vgkiimCYmfWbvsaE7h0dilvyVnCV4ccDQvMbEDtiOHwa7+W06gN2GK75eckaYczPpW+zHPeAtcKCiQJrMrklAYYSG94M4wY+qRqRI8+VTQeFPk5881enmG76TZ/yCvOvuzEeQ/vldKBYml9S9Uv9cwdZkcTuDSY+AOnaVWcTKA9ihVXfUNMwMXs0jbv2WQ9M82wTIhx2WGfrkR+a2mJ9KjE30QLJ7UdQUZ/WuB0EwZHWbsgtfyl0ulZOEJyKnvxy3jl19DNt3RTirG08YUdWsC19q5I8hqPzoi16h8/BLyCfANV5vPb5cJhckYJ8D8S0Og/DF1ogKmCo4nqlrPjtYlMbV1aSUAscpKZO6n49x8UEpbist3cngY5zsAp2u1JHSHRL/iZwPqJ8Xm6b6Ux6te/1dGYzwhOldN1q2kF+TsgiWGoxY8HAxbWuia7rh+Wc0gtteiCxqbaySXuA/H1u7WLa5Uj6Qi6h+tstKs/BBSWV9rQ/zB+BcXbcLpf8HzfccGnb3XMqvekVa305xGOQCeerc+/W8ojaWgD+2wk0Q6SIfipGYe/JzV0JsirQMX9h1Wq3on8hpgQL0oXvRIYuLRMUVlQOmxk3if2t4RSLdHhIH60Wf1FUA0Aknh0kV3elObhihn0VYbH1Q/9tSEzUkf3b6W07pK/af8irzn98uxjc/f7YI7La8i3u/aRJSDHi4AfY//OfqVRxkjsle35+bcU7LGtdwmeHO/P2r/aM25clATj6GjZ7SKuJvE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(2616005)(2906002)(70586007)(316002)(36860700001)(356005)(426003)(186003)(7696005)(54906003)(82310400004)(47076005)(336012)(86362001)(5660300002)(1076003)(8676002)(6666004)(70206006)(83380400001)(6916009)(36756003)(16526019)(508600001)(4326008)(81166007)(40460700001)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:59:40.1907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21686b7a-8929-4029-336b-08d9d67b6a4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will add vram check function for GMC, it will cover gmc v6/7/8/9/10

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 46 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  6 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  6 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  8 ++++-
 7 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 83f26bca7dac..96cabf3ed29e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -833,3 +833,49 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
 		break;
 	}
 }
+
+int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
+{
+	struct amdgpu_bo	*vram_bo;
+	uint64_t	vram_gpu;
+	void	*vram_ptr;
+
+	int ret, size = 0x100000;
+	uint8_t cptr[10];
+
+	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM,
+				&vram_bo,
+				&vram_gpu,
+				&vram_ptr);
+	if (ret)
+		return ret;
+
+	memset(vram_ptr, 0x86, size);
+	memset(cptr, 0x86, 10);
+
+	/**
+	* Check the start, the mid, and the end of the memory if the content of
+	* each byte is the pattern "0x86". If yes, we suppose the vram bo is
+	* workable.
+	*
+	* Note: If check the each byte of whole 1M bo, it will cost too many
+	* seconds, so here, we just pick up three parts for emulation.
+	*/
+	ret = memcmp(vram_ptr, cptr, 10);
+	if (ret)
+		return ret;
+
+	ret = memcmp(vram_ptr + (size / 2), cptr, 10);
+	if (ret)
+		return ret;
+
+	ret = memcmp(vram_ptr + size - 10, cptr, 10);
+	if (ret)
+		return ret;
+
+	amdgpu_bo_free_kernel(&vram_bo, &vram_gpu,
+			&vram_ptr);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 82ec665b366c..f06af61378ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -343,4 +343,5 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
 uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
 uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
+int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3915ba837596..5e407c88c8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1048,6 +1048,10 @@ static int gmc_v10_0_hw_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_gmc_vram_checking(adev);
+	if (r)
+		return r;
+
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
 		adev->umc.funcs->init_registers(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 0fe714f54cca..17770c1017ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -923,7 +923,11 @@ static int gmc_v6_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	return r;
+	r = amdgpu_gmc_vram_checking(adev);
+	if (r)
+		return r;
+
+	return 0;
 }
 
 static int gmc_v6_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0a50fdaced7e..fa43905ae61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1112,7 +1112,11 @@ static int gmc_v7_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	return r;
+	r = amdgpu_gmc_vram_checking(adev);
+	if (r)
+		return r;
+
+	return 0;
 }
 
 static int gmc_v7_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9a3fc0926903..6c94a9712a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1241,7 +1241,11 @@ static int gmc_v8_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	return r;
+	r = amdgpu_gmc_vram_checking(adev);
+	if (r)
+		return r;
+
+	return 0;
 }
 
 static int gmc_v8_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ce7d438eeabe..1ea18b4ff63f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1771,8 +1771,14 @@ static int gmc_v9_0_hw_init(void *handle)
 		adev->umc.funcs->init_registers(adev);
 
 	r = gmc_v9_0_gart_enable(adev);
+	if (r)
+		return r;
 
-	return r;
+	r = amdgpu_gmc_vram_checking(adev);
+	if (r)
+		return r;
+
+	return 0;
 }
 
 /**
-- 
2.25.1

