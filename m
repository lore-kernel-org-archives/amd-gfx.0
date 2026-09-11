Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046EFC88E53
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5719510F64E;
	Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QUfQgj4H";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BEF710EED9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/yvrD6jkeWbgrfAocf/FIP2atvXyMQ8r0SDh21c65H5H/LVxi70Kqm5+VzWItmzLdlON2WOAGrncFxAcyH74x1jV+vZRHeyGSipFkohpItKzEN8aY2DyKttP84y6a6tMkV7seWqlH3tWlCl//74LrzkrTc0LqL/fKgofxkSPzF1ENhPh4D/k/GcFC7TbzDI3wuvNQVMLFefc8DijTUscU/LzJbqrpxK12Lht95SSLIwjkpX5/J5HJaPSJdF63UVVFywKCEpU/BvRWn1q1nacuDhV2zrdX7I5O+5udApt+5bGdq8lNfjpA8OrVWA82/7jfChcGbswhQzusuRzP854g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRIvaC3EqSItr6SvMKjMTpodem8djAq4heRaLWXldkk=;
 b=GFpAkTqQmpe8/TLe+Gsur8qnEDHZobCFXAnp0xE7VBGIeW4VKW14cgoWkiJAccCQ8Q9ll+21DwBTv1yUiEtdMZ+FX6JtdW7mgSb1FGDeaV31tjPdb51FyMgEAQsM9o9xA3qTjS6qDKuFxaZTJ6s+1DB0sXZfWGh22eoCLtCGuZqwvJjzkdniwKkhsaZgWjZyQEZgq3KsHq2NBBAW3F26JRMzR8K+BM7Cz82/rPaBt6x8hbK1yFOIJqOJD3yieiIODwq1OmWvElqf3QzN8Hyh0Qkb3a1TdglUEf8y/A6KuFpdJuryeWGTyp4LGfdb3LTJ6O2IAfJaMy9aMd1j1B1tfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRIvaC3EqSItr6SvMKjMTpodem8djAq4heRaLWXldkk=;
 b=QUfQgj4HV+1sRDeAGMyJgYHQCQpttHxthZJzSj4KpgceSd1OVCOJeyElBlBFkDZSUMMZsOKdArEn4T8c2xrL/Qszg2hfOhpj8xoiqUfXsG9m+4AtdqGUyLuXuBswhHumfxrXszqF0MD8QJBNMloqhUtDyBoY+PVY4PpD02CxpSA=
Received: from CH0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:610:e4::24)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:56:08 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::79) by CH0PR03CA0199.outlook.office365.com
 (2603:10b6:610:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/23] drm/amdgpu: uplevel reset check in
 amdgpu_gmc_flush_gpu_tlb()
Date: Fri, 11 Sep 2026 13:55:34 -0400
Message-ID: <20260911175544.1314467-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a34e46-908d-4409-0756-08df102df50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sxfnv4C74zbameedXavJV0LoPfSUKn9cuASfZ7voZ0/aCe8iPoZIbGH23T+fH9wor22Fio7YegJ+vqovKCHJa5qCoDUhl548XWwGHyPM9ipvMj2X8DOtvfTH5bpiYi6USxvszsqafZKQ7/kU8gQSm8KqoMPBop1DEsEW/EudNEZ9+r0BcafDylbnx8BhHHttoQuK7G16Agu4BEz3XAkKbJ6pbQoBRBedqsFE1RbevhR0G2x6yp2ssRQ4OqYGSbohmYh07B2x8mHDsRFz/mRXgU7FNXsR8eQgFXBlSnbL95uk6ASjYevGZ9XxeE/gMl5WQoy2f/oXpVN2KRx9OPCq2kn0RDG2SAxHS/0Ex+prPyIrN1f9x5GFo+jdcdftEDOXcHYdvOl+p9Y5qdrZaNV/C+oPcgcftaA6w/O47uB8ihg5OscO/v9R92l4mrQqlQWq1n0NfiQ71oH2uv/Jsw434jvTnpfLTE4qJUeuHN/HxxtQJYTIRm009bkhlUHtv33jrOxSdOOK2b+W/Ipe32MPftnGVowGt8+WXNXzh83NPkFWITIycpqRvGZef/1vUDD5lCqHJnPPt8g1eDUscAr/z1JYXFdmaQbYEmCYeH5V5HXcd+JXpPxfMyhmpUGSk9ofcNEL73z8oDiCfpuJdY6HkvG+rgQVPYLZWGEV0BIxqBBN7zabRuiWPm56B1MJUPpH8zcAIaKnq9Xiy81Aw3qgFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dL7GLVqH5ZCMLvp8D85eLw4w4IFx7QG09KVEI5zq04oaQoHUbaVx/R64v8LYR0a8+w2peSI0Fo/nES6sBD5jOV8WR9oelRyieMtc5DeyP3IYoik6FSaunWEnnNZua9uZRdSTGx4wH28w8xwY8ECfkAi48LppQHHqHKD83dwHe3VESua/RnNnvkP8lmmcjEM7mwt+iDxzUdJ+E7jxEHYxW5toRiW46kdjDkuDlyfPZTHG73qI2tDGiBfvZrEVupn2TZas6BbePc8fe0KDzpadJikXWVef5B3m6Dwz/8AA16y9aG4lJLCT7OfJ3cZ4f0/zz/RkVLJSLy6vTxIzDTMPCdhuBNNmoQDuJI6WeFu3zo+oiMxWZvbc7u7yHWMGszel3udjIQrocI0xZuxSY6m62tHpUgw3BumDH8iVQYYSeDdjx+5cy2utQL2pK1e3BE6X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:08.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a34e46-908d-4409-0756-08df102df50a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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

Check for both the MMIO/KIQ/MES and SDMA pathes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4acad329aee5a..f1c7bb37cfb8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -724,6 +724,13 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	struct amdgpu_job *job;
 	int r;
 
+	/*
+	 * A GPU reset should flush all TLBs anyway, so no need to do
+	 * this while one is ongoing.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return;
+
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
 	switch (adev->gmc.gart_inv_method) {
@@ -740,13 +747,6 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	if (!adev->mman.buffer_funcs_enabled || vmid ||
 	    !adev->ib_pool_ready || !ring->sched.ready || use_mmio) {
-		/*
-		 * A GPU reset should flush all TLBs anyway, so no need to do
-		 * this while one is ongoing.
-		 */
-		if (!down_read_trylock(&adev->reset_domain->sem))
-			return;
-
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
 							   vmhub, 2);
@@ -784,11 +784,13 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	dma_fence_wait(fence, false);
 	dma_fence_put(fence);
+	up_read(&adev->reset_domain->sem);
 
 	return;
 
 error_alloc:
 	mutex_unlock(&adev->mman.default_entity.lock);
+	up_read(&adev->reset_domain->sem);
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
-- 
2.55.0

