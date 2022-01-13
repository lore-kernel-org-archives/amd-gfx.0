Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B7FC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 07:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A392310E718;
	Thu, 13 Jan 2022 07:45:47 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CAC10E6ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw5Ci8fas1UZuD+VXYPFoFFBRIgBFjtFdXMb/rD8vMj6WM1dBPPyv1N9yAGB7Wuzhg2EtJp+SCwQyONgsgxeEYyqE/rvtghfRqpuGsJ6UgnoqDaG/fY77bxl7IQeyjTwP/2siDphz3yQm5CKqej7qwJ9bDejmUvb952uib5kpM4MnKwVTYlCYfNyMXw1yxrXQLzPKr3QaopmpIDh5WCQgp31sOPk6AqoT9BsgMoN7HH8Xar/79gFxxXh7WUkQVZUONUzyfN9u6TJxCF30TSs0fg+qFNvRbIiqDXXFMpb1+EKuLjGb1Evakmd8+0HXBwB2WtstUhrXEiTHhxj0gBX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c33GybQFMQV7g75imc3PyIsJk2uIYgNEnExOwqfFaL0=;
 b=jS3FAp9C474aWBy5m7z5T65lpRkl+3XCJAuNT170EcI7sBfWOdx0+f5AwEWDnxaPD/3w42+/PRycHvCpYqxh4+qV3EcEhWBLtLqIGL6PBk8WnLbKjRXjGv/Y7bm2HaasugfAbRyoyWaOXXlxCcRzUGzXnyDpxpsYAxpf6nvchtaLTLuK4fY0U3ohxBTRqk8hi61ywAIND7iZaRfu0J5xYRCOq2Ashl/wAJPsQVsVpfjOEUiFtrwkvhkChL/gldbQazXU6ixY47Y4CyJToLACVCOZKAewJ94GmKk0bOf5FDokgD64rGF7AqaVKchoWw1qKlOHJO0HisDwvTnPmvHVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c33GybQFMQV7g75imc3PyIsJk2uIYgNEnExOwqfFaL0=;
 b=m3z8U72j2HmIQE7ValP3OhDVzOyQMCVlI5umBq1hcNgGrDfzzMzF588/jBV1HmMQu46CF6q6o420sMy9t8MCOMw67hz5xRUGAlGrNVudqE9m/LZ9tJXk3kw7lz/RcfgxJvUf/v1LJxutK7RVTA5AgUnjN7T5IIvV9mx5Cfl3oY4=
Received: from BN0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:e8::29)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 07:45:44 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::23) by BN0PR04CA0054.outlook.office365.com
 (2603:10b6:408:e8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 07:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 07:45:44 +0000
Received: from jenkins-MyrtleD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 01:45:42 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add vram check function for GMC
Date: Thu, 13 Jan 2022 15:45:26 +0800
Message-ID: <20220113074526.29827-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113074526.29827-1-Xiaojian.Du@amd.com>
References: <20220113074526.29827-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe4eb57-c83f-4dfc-0863-08d9d668b49c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4542A682BB31595483F88A82F1539@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zztizEKQON33+b6w/hOImrjIxY1IkrxQpSNPecQRsz6OKprdYBzIK/fbZw29m887YQLBJU/YzqhBv8YH1GoVLAlOyR5Dp5Cumc+FPO1BCeYDKq6B4YhDVSvjvmPsaq6fySguIRMhC/6awAnGDSbWAepgeifWyGIpKYo1JdBaR8ZR8X51qoYcg0oUB8U17c4mr9R6a8EFcLWqboBdUWp3eWwJpyffNqGgj2KupgihvhYrtl/4l405ZthVBvTS4/q8YaeJ6jsnnw2X8yEFvnwM/X2/6dR2JpOrbxowjKrL6pNg5aYZuZoZTHphmg93tV0WadvVjlQVwLNqlbV1ti73gePJxoXabFnv/I4F5aylkaxtUEwbydl1jlLR3i2siGO31EKOsZqjDSbZu89qJqJaxG/oRz1d3KW5rIm6hu2jiNm0VnX7EK9Y7XzzPJCo8zIVZTUyKN93zr7g0BZmOEhwgcNx5Z9SM/vuJLoxLbtdUcwMD/IAbYoIVaREvLGzeb4n9VQjac6dt5Rbrqlqg++yAScH8pXC/BY4VKjmzIQHNqibn2PCvKGp/1lgQ8pbar1K23PAl+PGWfMo6BQ32Zg2Uv83HYuixx6Rn8tXWKakaxpGkpuYTd0dgM69K2/2cZfzO+8+iAuurDn3olHBjY6R7SVZJjLO468LWWBII6ubDkkAfHoEGqaN3MbUXHg+w4VYla1i7hFwwRZg7mYjRQt9IlBseOuG6bqsPsAHsQCktJ5iX7bSa6d9T3jbOcNSzIz48/xRjjRhtUKYTPm8pSSGaFyy0wCnoqGNJRCy4IwOTnk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(186003)(1076003)(4326008)(26005)(8936002)(7696005)(5660300002)(70586007)(70206006)(36860700001)(8676002)(508600001)(6916009)(356005)(2906002)(426003)(82310400004)(2616005)(316002)(40460700001)(83380400001)(6666004)(47076005)(336012)(86362001)(16526019)(36756003)(54906003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:45:44.4390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe4eb57-c83f-4dfc-0863-08d9d668b49c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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

This will add vram check function for GMC, it will cover gmc v8/9/10

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  8 ++++-
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 83f26bca7dac..dbc0de89d7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -833,3 +833,45 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
 		break;
 	}
 }
+
+int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
+{
+	int ret, size = 0x100000;
+	uint8_t cptr[10];
+
+	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM,
+				&adev->vram_bo,
+				&adev->vram_gpu,
+				&adev->vram_ptr);
+	if (ret)
+		return ret;
+
+	memset(adev->vram_ptr, 0x86, size);
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
+	ret = memcmp(adev->vram_ptr, cptr, 10);
+	if (ret)
+		return ret;
+
+	ret = memcmp(adev->vram_ptr + (size / 2), cptr, 10);
+	if (ret)
+		return ret;
+
+	ret = memcmp(adev->vram_ptr + size - 10, cptr, 10);
+	if (ret)
+		return ret;
+
+	amdgpu_bo_free_kernel(&adev->vram_bo, &adev->vram_gpu,
+			&adev->vram_ptr);
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

