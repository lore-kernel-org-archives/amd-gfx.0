Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C548C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD22206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VIiQyZpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD22206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018776E175;
	Mon,  1 Jun 2020 07:30:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A936E188
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/4A6GQHsBsju0XA3MdvVpoZioWGVmWIFfyccXh1M8Iexzzfe4VrrK0lePdn4TKK1gOV2IBphqchgtrmsGKistN537ys2FCYgsvP8ymrROYcXkxBhUj7b/VFpgkt5/WfRQoseAzK3mei0P4/RKci4nEkmFJOQQByGPT5sVnW2nwVliLXW9f7ELzc0Sc4Gsclq86V1T+JZ1JI9rNDVGn/wHKlKvlKIasfNSgGLu+JZhpq5CAXJOmwZgcADjCfOsKOrcZ4pKMfmtgrlj70nZyMNi/NTjiRpI+SVihaLyd7bN1gMbvg7InBsJseoP7F2RrceZJiUXGgy6jQWV2RDXqC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN/3iKf8kVbFGYpukkKu+Y+0pdbSWMcvc+zrLuaruzc=;
 b=Xkf3GHzM9IpoV/FWtw0sZuQ50xNk/Xsvp7zz9G7na8zK1tSfAyo0Hl2nZp2mcdKwRnFrXQoN0dyk0HXLK7hNZBySyHvfJ7ifIux4/J/jz2VRlHgMTh9pNP+okM8jDiIp2BdIvC6bSd3BzSgDulJzt9SSwsL+JUQJiJM9JvGhKRcFTh69JxqxXsJdL5qTkgK0sxeBGrf/fbwCjuNmYq5dTywiKqotPwdHtPCmDTOUK1G9nJBpwkBDIn10NzbhckYu8rJQJi2Rgil1dGz5ltbbPnWxdS4c2deTAXWEPv8VujjRw7LFTwoIODwXrFxa5acHLdwExq6WWyOaxfxDEDumhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN/3iKf8kVbFGYpukkKu+Y+0pdbSWMcvc+zrLuaruzc=;
 b=VIiQyZpQSHffaL2l+OHVIeajXlP8tqutTT3+7PcagJjNUnrTooyCPv3WRKEDa4+5MXXN8/+40Nhx3hpYIHt6ddIVMnRmUV5+7ORQstVvWSuKmAYgkDQTHSnI8jgONJf9n8QAbgzg6olhzzJTQcWbOdHj9mr8JEncEjZfzxo6nBc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:30:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:30:44 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/9] drm/amd/powerplay: centralize all buffer allocation in
 sw_init phase
Date: Mon,  1 Jun 2020 15:29:57 +0800
Message-Id: <20200601073003.13044-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:30:43 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cac9e815-d00f-4ff0-153d-08d805fdb221
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38035ACAFB3436A1039315C0E48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKI7cDbPijwpcj6mkJBjCAcWfAL+3r21P6/eamf5OSCQGpD4INyX+vHC5aCNEezeZ3As4+SXfqtS8ZLKWvpPMTh/CXYamEkq+vJb4MUEgFpjwjzaahE+XagjT5k7F5ceG4xazbgquMb0PsX8r91ptHWI/U3gd783xoLrp+UU2W+Zhx1p5dbRpeBSWNdBlT3Y0xz031XeCS1Lw1E75M4Oiq333JS6DCmsttcsSAso4KMbf/X+kw+RFDY/HSykfD3yXHQohm1rnuzcUmm+ghJVmFzNrob380C2srS03+HNQs2Z3IA9WFzjoKznRBRewDoqUAFPWj4Z3I+Iodrnbwc/9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(30864003)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(6666004)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cWpZIKoy9UPzuROgQnyOEoavW0aVSRgTcArF5O9NzDr5sIZ/gYhfIsqbKCDEhFGOOIuQ+mLwxKKlgNVFzAkiy+XFMdJDqGp3RELQ1C3iZt3jLsjFoMILNg02goKesolyRnjSQfSw4vFNOuJnq6w0shZ5voc+NIApljHgyT52tdqF7x1Ao8IMTvjT2MrS3By00OlsLVo3UUXd3hE+xoszjSEQbwKen4fJKjnWUG2v3wFDTTcLInhwelB0KgqJGObLxwANIjah0BhfShPOgu26oQVAl3wCcNkSah3P8dZwC7eLd1X/8dx2fbdggt0vYxLBkwUWvO1bu8yxz9G76h+clQAz643rc10wmpQCjWBDYnIWSSZeQADuOw98NRP5P5/gvHsrcVOTJVsFzjALMeYNik5A0CEXR0XbruvdK8K+K+LBJPj3u93cgFLlNI3NAzXAHuTvfF3k7ur32iuBwSgWHeljyvSjFTGFCUpByGKIt8iS1rbYcGlxkNOugeTzOx/o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac9e815-d00f-4ff0-153d-08d805fdb221
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:30:44.9350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /USuG26EW72uzNGR6iFHXoHUUX4rqG/i5oJYkE/LFGkhUl+6aTnwI46WhZfhG3o7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit common design. And this can simplify the buffer deallocation.

Change-Id: Iee682e76aadb5f34861d69d5794ced44f0a78789
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 330 ++++++++++-----------
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 105 ++++---
 2 files changed, 223 insertions(+), 212 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b4f108cb52fa..70c7b3fdee79 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -817,6 +817,147 @@ int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
 	return 0;
 }
 
+static int smu_init_fb_allocations(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	struct smu_table *driver_table = &(smu_table->driver_table);
+	uint32_t max_table_size = 0;
+	int ret, i;
+
+	/* VRAM allocation for tool table */
+	if (tables[SMU_TABLE_PMSTATUSLOG].size) {
+		ret = amdgpu_bo_create_kernel(adev,
+					      tables[SMU_TABLE_PMSTATUSLOG].size,
+					      tables[SMU_TABLE_PMSTATUSLOG].align,
+					      tables[SMU_TABLE_PMSTATUSLOG].domain,
+					      &tables[SMU_TABLE_PMSTATUSLOG].bo,
+					      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
+					      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
+		if (ret) {
+			pr_err("VRAM allocation for tool table failed!\n");
+			return ret;
+		}
+	}
+
+	/* VRAM allocation for driver table */
+	for (i = 0; i < SMU_TABLE_COUNT; i++) {
+		if (tables[i].size == 0)
+			continue;
+
+		if (i == SMU_TABLE_PMSTATUSLOG)
+			continue;
+
+		if (max_table_size < tables[i].size)
+			max_table_size = tables[i].size;
+	}
+
+	driver_table->size = max_table_size;
+	driver_table->align = PAGE_SIZE;
+	driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
+
+	ret = amdgpu_bo_create_kernel(adev,
+				      driver_table->size,
+				      driver_table->align,
+				      driver_table->domain,
+				      &driver_table->bo,
+				      &driver_table->mc_address,
+				      &driver_table->cpu_addr);
+	if (ret) {
+		pr_err("VRAM allocation for driver table failed!\n");
+		if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
+			amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
+					      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
+					      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
+	}
+
+	return ret;
+}
+
+static int smu_fini_fb_allocations(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	struct smu_table *driver_table = &(smu_table->driver_table);
+
+	if (!tables)
+		return 0;
+
+	if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
+		amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
+				      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
+				      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
+
+	amdgpu_bo_free_kernel(&driver_table->bo,
+			      &driver_table->mc_address,
+			      &driver_table->cpu_addr);
+
+	return 0;
+}
+
+/**
+ * smu_alloc_memory_pool - allocate memory pool in the system memory
+ *
+ * @smu: amdgpu_device pointer
+ *
+ * This memory pool will be used for SMC use and msg SetSystemVirtualDramAddr
+ * and DramLogSetDramAddr can notify it changed.
+ *
+ * Returns 0 on success, error on failure.
+ */
+static int smu_alloc_memory_pool(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *memory_pool = &smu_table->memory_pool;
+	uint64_t pool_size = smu->pool_size;
+	int ret = 0;
+
+	if (pool_size == SMU_MEMORY_POOL_SIZE_ZERO)
+		return ret;
+
+	memory_pool->size = pool_size;
+	memory_pool->align = PAGE_SIZE;
+	memory_pool->domain = AMDGPU_GEM_DOMAIN_GTT;
+
+	switch (pool_size) {
+	case SMU_MEMORY_POOL_SIZE_256_MB:
+	case SMU_MEMORY_POOL_SIZE_512_MB:
+	case SMU_MEMORY_POOL_SIZE_1_GB:
+	case SMU_MEMORY_POOL_SIZE_2_GB:
+		ret = amdgpu_bo_create_kernel(adev,
+					      memory_pool->size,
+					      memory_pool->align,
+					      memory_pool->domain,
+					      &memory_pool->bo,
+					      &memory_pool->mc_address,
+					      &memory_pool->cpu_addr);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_free_memory_pool(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *memory_pool = &smu_table->memory_pool;
+
+	if (memory_pool->size == SMU_MEMORY_POOL_SIZE_ZERO)
+		return 0;
+
+	amdgpu_bo_free_kernel(&memory_pool->bo,
+			      &memory_pool->mc_address,
+			      &memory_pool->cpu_addr);
+
+	memset(memory_pool, 0, sizeof(struct smu_table));
+
+	return 0;
+}
+
 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
 	int ret;
@@ -841,6 +982,17 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
 		return ret;
 	}
 
+	/*
+	 * allocate vram bos to store smc table contents.
+	 */
+	ret = smu_init_fb_allocations(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_alloc_memory_pool(smu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -848,6 +1000,14 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
 {
 	int ret;
 
+	ret = smu_free_memory_pool(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_fini_fb_allocations(smu);
+	if (ret)
+		return ret;
+
 	ret = smu_fini_power(smu);
 	if (ret) {
 		pr_err("Failed to init smu_fini_power!\n");
@@ -947,85 +1107,6 @@ static int smu_sw_fini(void *handle)
 	return 0;
 }
 
-static int smu_init_fb_allocations(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *tables = smu_table->tables;
-	struct smu_table *driver_table = &(smu_table->driver_table);
-	uint32_t max_table_size = 0;
-	int ret, i;
-
-	/* VRAM allocation for tool table */
-	if (tables[SMU_TABLE_PMSTATUSLOG].size) {
-		ret = amdgpu_bo_create_kernel(adev,
-					      tables[SMU_TABLE_PMSTATUSLOG].size,
-					      tables[SMU_TABLE_PMSTATUSLOG].align,
-					      tables[SMU_TABLE_PMSTATUSLOG].domain,
-					      &tables[SMU_TABLE_PMSTATUSLOG].bo,
-					      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
-					      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
-		if (ret) {
-			pr_err("VRAM allocation for tool table failed!\n");
-			return ret;
-		}
-	}
-
-	/* VRAM allocation for driver table */
-	for (i = 0; i < SMU_TABLE_COUNT; i++) {
-		if (tables[i].size == 0)
-			continue;
-
-		if (i == SMU_TABLE_PMSTATUSLOG)
-			continue;
-
-		if (max_table_size < tables[i].size)
-			max_table_size = tables[i].size;
-	}
-
-	driver_table->size = max_table_size;
-	driver_table->align = PAGE_SIZE;
-	driver_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
-
-	ret = amdgpu_bo_create_kernel(adev,
-				      driver_table->size,
-				      driver_table->align,
-				      driver_table->domain,
-				      &driver_table->bo,
-				      &driver_table->mc_address,
-				      &driver_table->cpu_addr);
-	if (ret) {
-		pr_err("VRAM allocation for driver table failed!\n");
-		if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
-			amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
-					      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
-					      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
-	}
-
-	return ret;
-}
-
-static int smu_fini_fb_allocations(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *tables = smu_table->tables;
-	struct smu_table *driver_table = &(smu_table->driver_table);
-
-	if (!tables)
-		return 0;
-
-	if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
-		amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
-				      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
-				      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
-
-	amdgpu_bo_free_kernel(&driver_table->bo,
-			      &driver_table->mc_address,
-			      &driver_table->cpu_addr);
-
-	return 0;
-}
-
 static int smu_smc_table_hw_init(struct smu_context *smu,
 				 bool initialize)
 {
@@ -1063,13 +1144,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		/*
-		 * allocate vram bos to store smc table contents.
-		 */
-		ret = smu_init_fb_allocations(smu);
-		if (ret)
-			return ret;
-
 		/*
 		 * Parse pptable format and fill PPTable_t smc_pptable to
 		 * smu_table_context structure. And read the smc_dpm_table from vbios,
@@ -1187,68 +1261,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	return ret;
 }
 
-/**
- * smu_alloc_memory_pool - allocate memory pool in the system memory
- *
- * @smu: amdgpu_device pointer
- *
- * This memory pool will be used for SMC use and msg SetSystemVirtualDramAddr
- * and DramLogSetDramAddr can notify it changed.
- *
- * Returns 0 on success, error on failure.
- */
-static int smu_alloc_memory_pool(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *memory_pool = &smu_table->memory_pool;
-	uint64_t pool_size = smu->pool_size;
-	int ret = 0;
-
-	if (pool_size == SMU_MEMORY_POOL_SIZE_ZERO)
-		return ret;
-
-	memory_pool->size = pool_size;
-	memory_pool->align = PAGE_SIZE;
-	memory_pool->domain = AMDGPU_GEM_DOMAIN_GTT;
-
-	switch (pool_size) {
-	case SMU_MEMORY_POOL_SIZE_256_MB:
-	case SMU_MEMORY_POOL_SIZE_512_MB:
-	case SMU_MEMORY_POOL_SIZE_1_GB:
-	case SMU_MEMORY_POOL_SIZE_2_GB:
-		ret = amdgpu_bo_create_kernel(adev,
-					      memory_pool->size,
-					      memory_pool->align,
-					      memory_pool->domain,
-					      &memory_pool->bo,
-					      &memory_pool->mc_address,
-					      &memory_pool->cpu_addr);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
-static int smu_free_memory_pool(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *memory_pool = &smu_table->memory_pool;
-
-	if (memory_pool->size == SMU_MEMORY_POOL_SIZE_ZERO)
-		return 0;
-
-	amdgpu_bo_free_kernel(&memory_pool->bo,
-			      &memory_pool->mc_address,
-			      &memory_pool->cpu_addr);
-
-	memset(memory_pool, 0, sizeof(struct smu_table));
-
-	return 0;
-}
-
 static int smu_start_smc_engine(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1306,10 +1318,6 @@ static int smu_hw_init(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = smu_alloc_memory_pool(smu);
-	if (ret)
-		goto failed;
-
 	/*
 	 * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
 	 * pool location.
@@ -1401,7 +1409,6 @@ static int smu_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
-	struct smu_table_context *table_context = &smu->smu_table;
 	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
@@ -1432,23 +1439,6 @@ static int smu_hw_fini(void *handle)
 		return ret;
 	}
 
-	kfree(table_context->driver_pptable);
-	table_context->driver_pptable = NULL;
-
-	kfree(table_context->max_sustainable_clocks);
-	table_context->max_sustainable_clocks = NULL;
-
-	kfree(table_context->overdrive_table);
-	table_context->overdrive_table = NULL;
-
-	ret = smu_fini_fb_allocations(smu);
-	if (ret)
-		return ret;
-
-	ret = smu_free_memory_pool(smu);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index d6bdd2126f72..3b22f66e3fbc 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -432,25 +432,67 @@ int smu_v11_0_init_smc_tables(struct smu_context *smu)
 	struct smu_table *tables = NULL;
 	int ret = 0;
 
-	if (smu_table->tables)
-		return -EINVAL;
-
 	tables = kcalloc(SMU_TABLE_COUNT, sizeof(struct smu_table),
 			 GFP_KERNEL);
-	if (!tables)
-		return -ENOMEM;
-
+	if (!tables) {
+		ret = -ENOMEM;
+		goto err0_out;
+	}
 	smu_table->tables = tables;
 
 	ret = smu_tables_init(smu, tables);
 	if (ret)
-		return ret;
+		goto err1_out;
 
 	ret = smu_v11_0_init_dpm_context(smu);
 	if (ret)
-		return ret;
+		goto err1_out;
+
+	smu_table->driver_pptable =
+		kzalloc(tables[SMU_TABLE_PPTABLE].size, GFP_KERNEL);
+	if (!smu_table->driver_pptable) {
+		ret = -ENOMEM;
+		goto err2_out;
+	}
+
+	smu_table->max_sustainable_clocks =
+		kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks), GFP_KERNEL);
+	if (!smu_table->max_sustainable_clocks) {
+		ret = -ENOMEM;
+		goto err3_out;
+	}
+
+	/* Arcturus does not support OVERDRIVE */
+	if (tables[SMU_TABLE_OVERDRIVE].size) {
+		smu_table->overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->overdrive_table) {
+			ret = -ENOMEM;
+			goto err4_out;
+		}
+
+		smu_table->boot_overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->boot_overdrive_table) {
+			ret = -ENOMEM;
+			goto err5_out;
+		}
+	}
 
 	return 0;
+
+err5_out:
+	kfree(smu_table->overdrive_table);
+err4_out:
+	kfree(smu_table->max_sustainable_clocks);
+err3_out:
+	kfree(smu_table->driver_pptable);
+err2_out:
+	smu_v11_0_fini_dpm_context(smu);
+err1_out:
+	kfree(tables);
+err0_out:
+	return ret;
 }
 
 int smu_v11_0_fini_smc_tables(struct smu_context *smu)
@@ -461,6 +503,17 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 	if (!smu_table->tables)
 		return -EINVAL;
 
+	kfree(smu_table->boot_overdrive_table);
+	kfree(smu_table->overdrive_table);
+	kfree(smu_table->max_sustainable_clocks);
+	kfree(smu_table->driver_pptable);
+	smu_table->boot_overdrive_table = NULL;
+	smu_table->overdrive_table = NULL;
+	smu_table->max_sustainable_clocks = NULL;
+	smu_table->driver_pptable = NULL;
+	kfree(smu_table->hardcode_pptable);
+	smu_table->hardcode_pptable = NULL;
+
 	kfree(smu_table->tables);
 	kfree(smu_table->metrics_table);
 	kfree(smu_table->watermarks_table);
@@ -723,18 +776,6 @@ int smu_v11_0_parse_pptable(struct smu_context *smu)
 {
 	int ret;
 
-	struct smu_table_context *table_context = &smu->smu_table;
-	struct smu_table *table = &table_context->tables[SMU_TABLE_PPTABLE];
-
-	/* during TDR we need to free and alloc the pptable */
-	if (table_context->driver_pptable)
-		kfree(table_context->driver_pptable);
-
-	table_context->driver_pptable = kzalloc(table->size, GFP_KERNEL);
-
-	if (!table_context->driver_pptable)
-		return -ENOMEM;
-
 	ret = smu_store_powerplay_table(smu);
 	if (ret)
 		return -EINVAL;
@@ -975,17 +1016,10 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 
 int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 {
-	struct smu_11_0_max_sustainable_clocks *max_sustainable_clocks;
+	struct smu_11_0_max_sustainable_clocks *max_sustainable_clocks =
+			smu->smu_table.max_sustainable_clocks;
 	int ret = 0;
 
-	if (!smu->smu_table.max_sustainable_clocks)
-		max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
-					 GFP_KERNEL);
-	else
-		max_sustainable_clocks = smu->smu_table.max_sustainable_clocks;
-
-	smu->smu_table.max_sustainable_clocks = (void *)max_sustainable_clocks;
-
 	max_sustainable_clocks->uclock = smu->smu_table.boot_values.uclk / 100;
 	max_sustainable_clocks->soc_clock = smu->smu_table.boot_values.socclk / 100;
 	max_sustainable_clocks->dcef_clock = smu->smu_table.boot_values.dcefclk / 100;
@@ -1930,24 +1964,11 @@ int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize,
 	int ret = 0;
 
 	if (initialize) {
-		if (table_context->overdrive_table) {
-			return -EINVAL;
-		}
-		table_context->overdrive_table = kzalloc(overdrive_table_size, GFP_KERNEL);
-		if (!table_context->overdrive_table) {
-			return -ENOMEM;
-		}
 		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
 		if (ret) {
 			pr_err("Failed to export overdrive table!\n");
 			return ret;
 		}
-		if (!table_context->boot_overdrive_table) {
-			table_context->boot_overdrive_table = kmemdup(table_context->overdrive_table, overdrive_table_size, GFP_KERNEL);
-			if (!table_context->boot_overdrive_table) {
-				return -ENOMEM;
-			}
-		}
 	}
 	ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, true);
 	if (ret) {
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
