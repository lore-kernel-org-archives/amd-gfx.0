Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF1AC624D8
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA2910EEF6;
	Tue,  1 Sep 2026 20:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHIiNyNp";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E48E10EEFC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+uVTHUfDOJ3+Xy3iC+0vm/C6BAgnmbPR2kxvxcZWtUjT3Xx4CblqKcXqkHqE3kI+PQfIa9prZA7mlVZ7zPKb8lQGlWcU2TSDxcvemSXY9oEVRNA2wI8bR2KlnpbRLLrhR4fcvMbYTpceaWbT9BqkFl5o2/dnp1Nzf0pET0qt3R2vQXvW+PJ21SDeUvsgYwMjBXrZKYVV7WPLN3eDFk7bhsqyhFI5+WqpBcHy8XxQn9VzO4aKqsJGe+vAIpFCh+QRzr/OBXhfwdT5kLyjBB0Oh9py79woNihli27XdPw7KEc9+tJV4FiDE58t4GaGkLZFl4u8Oo4EJbKPeKxYcyXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDShDBroQFSutHCtU4+tU7bqcY0hHQdMb0BJ3fS+jmo=;
 b=hvP8HA+OLOUEIy9j9zs8DjOvlxKPsV3R5cHqXeYMwqnOqJmsrgEGft6b+In0Cm/JYMoN5xkd36rxUkZUNBqnwiOTsR58EkkDxueeq9LR3XGJaKpm+QiYrE16JDdWBlF882KvG8qzHlxPJ1qPgPlZRoe5bhDzGCwFwkY3Cek0wCAAT2AYqMwPr3LplkIDEvHxGdA3jZdtJI42sLKLoavA74d01jqRNuRHtrqluBBmWnVqhTlxGfYYqx5z0FcL7GTequFZD6Hy4QuHVOTlsok60CMOXBfG/yPWjrn854nwVXATefQXy5L1863nG3mmM1m2jUfcjCj+xe2Gh7Unu7moNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDShDBroQFSutHCtU4+tU7bqcY0hHQdMb0BJ3fS+jmo=;
 b=UHIiNyNpJa/wRv4teAhaWUruG9w47U2Tdoa1VmBzH57CVU4PsjHt1O/aOhu8n/vtzfskV4Y7+i73hc0gTZgn+ByHJNDSzZJP8qJzMrfzQspFW1Vz50gHru4cXh9iVvDFEt24fj1mjx03klprKZOXWgVLFw5QICyQIzZCunz210E=
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 20:10:53 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::a9) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/31] drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
Date: Tue, 1 Sep 2026 16:10:06 -0400
Message-ID: <20260901201034.2960437-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ea78b8-d86c-486b-db55-08df08651ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D1tpdn8ZNKDlrj/0MxTxpBjMDxAqKxwC9T5dFjfqxC72+KGv0ddvhP8NdmdE9HD7WVUBaO929h0PhqzKzX+LrkiSnKt0Fs7kzC8uqm8a9PWDeVlamfcGkm8YJFrY6z0gEzKNJQzpUi0BL7fww5Hd7OuZQhZWIrT/NwWbaz3m6aB7rZ4ajGDP28P//EUox/m45BsSz8dekMLptbB5LgINyYwq/i6FIqzp3+HaAbAEqJhc9qvTF9mW/aSFfQAqjRr8fQLsTRFeJXHAU+8bGEHBkjLhdJlDR2+rjsSEd0PMzU6SyaUu2OSeFA8ZV69sMlIBVBgTc6lity6S0pMLom8ITqLuR+krEBsoFgHGQdNYTMfzfL7wCi3aPmoJX/B4RqbFhsIluRaera0J43NOLb9QiMp5JyG24wzrnu8Z20xDytyO13WvG6MLvP7weMD38K8TuXs9D7IVYNPvYO1Ifs6z44g5PEG5cD9JUm02acz9jhY2tD0xiwHd91YSR/CMKeaLnW0b9dUlcqQbG23ISC8IZSmB8uohsb1URYXT4zh7pX5Z9zDv4itGJAawDqYJla5atwHN1zqDbW8L9aL/stR3pvwysE5ag0M5uEMDyEbhFCd1jk+QKfGNMLxR9IOwkyDIIKUHHB/UDKHR56JfeAdQLdrlUq16Qgr+RVoU+S/JwsGKmOytLi2BDtJXC8MImCiUNJKI3QfQmJbWsI8V2Ni9Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z8YmzIXuPlY/WUWMjL2I45mNd+bhzMVx97sxmolnMQHBOnnyE5JN7f5Tp/Kwdm22mJCFuqaAekwqT+XCwKFwN3/PcUlXnFEdtL+sU2RJqzhzob+8nLI3sfkJQuCAYvkeMlvRmDmIEVhemxb4BP59XsHM+DC43UO95QvE0DK/fflTYEXpHw94rJtQPyIMxgAnJEqT6GrC8SNn8MzytHpMXv936pQ1015/yLt2zXxOZS7tnHMPYU04/9dkpOIO6bfceQzRKcSd2QpZFK3eX84K21pai0yNlU+EbAHd1e501KRXEpblD/9S+3EIL70SH2KCLMsoj6WA+Tv2AJHuJZXJLuhh3LqwGE0Z0At9gTe0amNZqmaVJVii0eOkioaSN0vLmCAmj6PRH3JxVSoQ2wZyyVHmk4M7LlAvE5EnUL4KqK3UjK1ltJscI0spRLTzOcdS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:53.0843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ea78b8-d86c-486b-db55-08df08651ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f454aff831b03..41ebc6ae182cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -253,6 +253,10 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -306,6 +310,9 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (i >= adev->usec_timeout)
 		dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
 }
-- 
2.55.0

