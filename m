Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEAFC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 19:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC8B6E9BF;
	Mon, 29 Nov 2021 19:15:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59116E0D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 19:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKrI2hf8ZB5DmRORsk8BVrzUVpsWiSt8O9TEMZw8Yva8ELEbEbcUObWlaefdjROJ73rSPN5B65f2ACQ5aAgemlTIYnJLukqpNiaSegb3FYrCZuBIcN4e57tmV+7bgm3YFVts9hvQUx/duyHhgFRM2e5PMqfXd4d1sRe6kqqme76Ant0KDy6nD1X/zBRkZXYr0ehVANXZEdoGyFvLz/O3EC6hoQKzdLON84BFqdNy2NVWkjL0G8gG+Yxoo7DsPM9Q1pRLgfwrOyzm8yaKGUWdSKrRvszK4MdUM1lZCoHA+9pmuMyYE01hk7gK4ZiemR/S7vJgnnNrc/AkYmzTOdqgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tErh+DT+3o1LnDJQMG/hCwJ1hkpXTWQPgg+4OWDA07U=;
 b=EObLi+qjLVoakgEWa3gPL0uisEltgLwUYAqGcKULUNqCelaYyxFQGYBrvk0QH6z5kC32Gt0VzFUC5odI0ynjEallASiiXd/6HJfp4uXTUfvqt+ELbVqxx/T3nmz0pR4A4/jC6IdjiadCdXE9PAq+8WxgtGWrcAlQ2s96hBuEtUj8fLrArZNnqV2qqnkDh96QWMjTW/RUZTLpoa/10aptKWv2KwIRE2O2hk/My+JnjG28XMEM9Y3erDvzS0e5HwG/mlLvK9j2aILZGEszMRUeCERqcMNInflBgCtgvtU3zuWosyj2R/+lOOOS1m4HXfLTNc6ItjwQnkQxiF/PXzxMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tErh+DT+3o1LnDJQMG/hCwJ1hkpXTWQPgg+4OWDA07U=;
 b=HyFAE1K3WzznzaT04f0kGz8Ng6TwNedE4J9sodaHrsVDOkhBr6xxbTJIv50u4p2H1JC9vxIWmEsKGkFcM8pmOKSA4TyNuFLpqHZ4Z/k8nvtOVLwoKWBSQ4MPPw7AFqYZMXUR9EcHdt4pZ9ANcqOewgehlfPzl8WHlCcFPDJolv0=
Received: from DM5PR16CA0047.namprd16.prod.outlook.com (2603:10b6:4:15::33) by
 DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Mon, 29 Nov 2021 19:15:09 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::bc) by DM5PR16CA0047.outlook.office365.com
 (2603:10b6:4:15::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Mon, 29 Nov 2021 19:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:15:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 13:15:08 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: fix double free mem structure
Date: Mon, 29 Nov 2021 14:14:45 -0500
Message-ID: <20211129191445.16688-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126235837.11229-1-Philip.Yang@amd.com>
References: <20211126235837.11229-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 191b926e-8e66-4b39-ff81-08d9b36c8f69
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:
X-Microsoft-Antispam-PRVS: <DM4PR12MB529614E1FEA874531C903610E6669@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C06meSx88iwB3OpGZ/vM0ANEIHyQ/O/irGuWQ8ICT3uQg9m9qPEdWpvy3KfKIVt24Un9Sf09PurrxSK7Hb9EkUv03Epc9PpBH7WLFi8hDwBtpLYeN8nyCnLLr7UXgHU2E+IPiN07tFqrAxJ7FFaG3762wgT2P8BGIU/2hy4auLM+4wTXDx37RtDarfnp32rgTvMLKr53SyBR+qJ7QWtG9YKKEmyz9J93r8/pZEndrk86OmZu1pP+PhN0jdhZvhtkp1HJHqmCFyAlztW5n/z6zqUW9DGXNjnCVqmxChdE2UaX1cJVoqdnG3ozc1zzHBFUlWntKJoJF0xa0yi3ksM2hkHicr450NTp20Lk8LwJB5cpzwkDMYAr/nNtHPZOobFL9ODwrT/u0oMFR+GpLctjr3lat1mKTfoXaV1ygA0WFFZp279Pa7dUiFk7x/vnfL3t8V4KG6kzyawjGhKv4W6PKjpIvLavdzC8pT/qf71xU9zauuAM1eh3XaAxAa+cdy7Mva7TTyOqlQyMkRtf1qN27dMdK1fyfy3lWYrJE9zmRjJNYb5+/u19qkM2R2oXBBVNDCrC8tgyykvdMQJbj2kzhmeJ8W2I4TFTACp0XdSXTxNQdv50Vkuez+Og20vY3FOpjDcley+sPMxHQZUT6yeRJLqYPboMst/C1xtty8aMiBZ6hZY0gRuFpKzeq9EXHgRR9bDyCkvbMQoKVR7Yj+yJoTgTHAoQk3ehHAdcgDdO9VA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(6916009)(70206006)(8936002)(70586007)(82310400004)(83380400001)(508600001)(16526019)(316002)(2906002)(1076003)(54906003)(4326008)(2616005)(5660300002)(86362001)(36860700001)(356005)(8676002)(6666004)(426003)(26005)(7696005)(336012)(47076005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:15:09.2744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191b926e-8e66-4b39-ff81-08d9b36c8f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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

drm_gem_object_put calls release_notify callback to free the mem
structure and unreserve_mem_limit, move it down after the last access
of mem and make it conditional call.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index c5362c23e687..5df89a295177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1460,7 +1460,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct sg_table *sg = NULL;
 	uint64_t user_addr = 0;
 	struct amdgpu_bo *bo;
-	struct drm_gem_object *gobj;
+	struct drm_gem_object *gobj = NULL;
 	u32 domain, alloc_domain;
 	u64 alloc_flags;
 	int ret;
@@ -1582,14 +1582,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_pin_bo:
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
-	drm_gem_object_put(gobj);
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
 	unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&(*mem)->lock);
-	kfree(*mem);
+	if (gobj)
+		drm_gem_object_put(gobj);
+	else
+		kfree(*mem);
 err:
 	if (sg) {
 		sg_free_table(sg);
-- 
2.17.1

