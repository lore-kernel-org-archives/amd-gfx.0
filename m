Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C77BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 09:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA4110E1BD;
	Fri, 14 Jan 2022 09:24:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FCB810E1BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 09:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RafCXcGGTZfkjddWoEpPqt5RIMpuDnPeFUWUWN7YnuK3oSNLbIom5oHd6xf1JRUy74ebbwe5Wt0bbG7+iKZzEomvzewsnDuQiOjnt61JPldL+NYV58NGwC5BE2vNdbeeF/7kdRTU1tplxziVKo0ZoitLvwlHRmyeP5YUgWmijdmfqbck6DliHR+XA3oRq749GWWW2/M736TtdsiIkoKPuSfVVfcQeCKmiz1jsTNLqsmXTa1eF5DcaH7JNjBcEMoNV9DUCxOJSGo4VoZPebQ3j5Hznu6LhRMjdpixbtYmKHEr0VQ3SEdxZfvNDJXP/maWtBTAyChjSEWjnHppR8qFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q19cfLenMN7RDsv4/VtimCTHV4RNDfgz+WqbSiTGhrQ=;
 b=gQVbqbSPupjLgO0ebkSHaAyNFQKVzq5UQWYOLjHZPsCYLad8hpFZVhBj56PwLX0y2RuGLAue0ay+RLBAe0aeDdbBs5HSPwzw6nxGYjeO35ZpBRosP81vT6oDgcHe+JJqitl2jkbfwrD0uK9+w5qvlIuIkDs1+92jgLTRxwB1suT4B6byC3UV2j51Dv/uC6GEgSFDcoz12T5cRFd9kf9rTu78sU1wTrIXydgq66o/kly6EhiEBJMx9zlI0QT08d+bDLmWo+iCqP6CfpBGiyNXqKyk9yglHdZsgFVFQ8UJiY0kXLN5B/PY5QqN5HGErZqnGhgG1krqUr3MVw7+KAwLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q19cfLenMN7RDsv4/VtimCTHV4RNDfgz+WqbSiTGhrQ=;
 b=EnYM/alG4PH7vgFlLn7KCzdDxfiOf67oK6EurHckEWqeusC8oCUvGKzvOXKRzXsIXg6zEyzfCwFppuEK2WaD957zD4fpu9V2QtNe4TrRdGrG82DJra848YV+9VcKzeuyCy+1jdnpKt0MUFOJg58xo63qkZ3i9AN7uAzeuJoYFqw=
Received: from BN1PR14CA0029.namprd14.prod.outlook.com (2603:10b6:408:e3::34)
 by BN8PR12MB2930.namprd12.prod.outlook.com (2603:10b6:408:69::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 09:23:57 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::4b) by BN1PR14CA0029.outlook.office365.com
 (2603:10b6:408:e3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 09:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 09:23:57 +0000
Received: from jenkins-MyrtleD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 03:23:54 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch v3] drm/amdgpu: add vram check function for GMC
Date: Fri, 14 Jan 2022 17:23:38 +0800
Message-ID: <20220114092338.10004-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891727b3-0b27-458a-062b-08d9d73f9748
X-MS-TrafficTypeDiagnostic: BN8PR12MB2930:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB293049A086EF75C1424C2601F1549@BN8PR12MB2930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rWI8c+cWLnm2MWhhZpJMe4TpeeuvpQeqxJ9us1JoW/mQbF4gF4FFvcvvZgr5+U63erilnWRmhUeo9vHL2iublZu+sCYbBMbv2nGFDSKtgj4QpTdqpsyxNCyiPdu68VAfPP48B9U15ICIMzbGn6K/ELz6J4iOn6GFrMOSmtUPKpQMuZw30zAC26RVxcg9GQMdJjLlxEiYp+aW9YvQB4NnDuB+0LPADfsnGEAHJd/gSUHR85B+GZoz+aAQxiXwyT0Zn5g+/s9qSksX/f/jXzAuXUPgz656+6r3ZDcOPYObTHunBz31oSeK7W9bxDc/r+RWp/e59Q0sEsuez+Hk0E22weavn5yqvjl0y2QW7LwBh/pk+NSrJ2BYkywcJ+Aam78fl4mrsUWnQdXMkyfVySm8Vm547Ioaa9Op7CJVEV70K2/e1bXulq69HyoD1H+jkxUz1SEGY6ZvVw716kTIP5fdLFO9yJILH5lYxUZf0sB2AFvUD+DOcBmmo3D8M17GwhzMMleAg4VHx+4/sR9AIIr0+f9xmuCEu9py754te5dgq/NXOsXsXbnciAnDZI61UVTyIBzOoyzgNAO9N5Sl2Ov5DIWMB43+AvZ6H8gpxoXQbCd8NY+d9V3M8StRdgGtPILvV8+vNcwLHwF3PDM75cn6dZAqhfW/+D6dsYygnnVyxQe2JBSa5yBRvkV2oZ8SYRDTfkBzyzVmMBoVy+spKccT+Bn7q1LAvHuqpq9B+/Y1Aas8HSFriiL6bYWlIbabQQBJnaKAHZV6szPXYbQY39fFGvLAe9u/zx6lVAWiKZtQWk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(316002)(54906003)(86362001)(186003)(70586007)(5660300002)(83380400001)(70206006)(6666004)(6916009)(40460700001)(81166007)(426003)(1076003)(336012)(7696005)(356005)(4326008)(2616005)(47076005)(26005)(36756003)(2906002)(36860700001)(8936002)(508600001)(8676002)(82310400004)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 09:23:57.0158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 891727b3-0b27-458a-062b-08d9d73f9748
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2930
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will add vram check function for GMC block.
It will write pattern data to the vram and then read back from the vram,
so that to verify the work status of vram.
This patch  will cover gmc v6/7/8/9/10.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 46 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  5 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   |  5 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  5 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  5 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  7 +++-
 7 files changed, 70 insertions(+), 4 deletions(-)

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
index 3915ba837596..41b11c1f8db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1048,6 +1048,11 @@ static int gmc_v10_0_hw_init(void *handle)
 	if (r)
 		return r;
 
+	if (amdgpu_emu_mode == 1) {
+		r = amdgpu_gmc_vram_checking(adev);
+		if (r)
+			return r;
+	}
 	if (adev->umc.funcs && adev->umc.funcs->init_registers)
 		adev->umc.funcs->init_registers(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 0fe714f54cca..dec5539fe779 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -923,7 +923,10 @@ static int gmc_v6_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	return r;
+	if (amdgpu_emu_mode == 1)
+		return amdgpu_gmc_vram_checking(adev);
+	else
+		return r;
 }
 
 static int gmc_v6_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0a50fdaced7e..b249aa9b3724 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1112,7 +1112,10 @@ static int gmc_v7_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	return r;
+	if (amdgpu_emu_mode == 1)
+		return amdgpu_gmc_vram_checking(adev);
+	else
+		return r;
 }
 
 static int gmc_v7_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9a3fc0926903..78ce7828b348 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1241,7 +1241,10 @@ static int gmc_v8_0_hw_init(void *handle)
 	if (r)
 		return r;
 
-	return r;
+	if (amdgpu_emu_mode == 1)
+		return amdgpu_gmc_vram_checking(adev);
+	else
+		return r;
 }
 
 static int gmc_v8_0_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ce7d438eeabe..ebbd212ed795 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1771,8 +1771,13 @@ static int gmc_v9_0_hw_init(void *handle)
 		adev->umc.funcs->init_registers(adev);
 
 	r = gmc_v9_0_gart_enable(adev);
+	if (r)
+		return r;
 
-	return r;
+	if (amdgpu_emu_mode == 1)
+		return amdgpu_gmc_vram_checking(adev);
+	else
+		return r;
 }
 
 /**
-- 
2.25.1

