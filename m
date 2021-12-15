Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66812C43217
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 18:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAC610F83C;
	Wed, 15 Dec 2021 18:55:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627D110F83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 18:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtABF2e/xW7bT4A16soAs74Za2bbAFXwLGghTugL7h2DUKeyhYap59agGs2b7sASR950u+8NQmwoC4D2QmRuOuyH/9CpBXJFcozoNgs0lLbZnZCmOgJnJc01MOPOED2SDHljjt6+XySUBhhI7vsqYbKWHo8gdmaZ/KVnmd8l4PhKvGQFt3WMkR15vYVRGekT0GA/SpT9Spn6CEnErq4+nEhLiQPNm21qIdJ/Qfvm8YZr4ZJ8FeBolpTPtZHA8BpxiUWOb0tRUOkvEAJcqznt8vi/2GkXvaSxqOfOVSOtUBmp8UDnPtULkZe3/G5ABcPsUTGAKXM6DJDDlxYUjvrGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL1dpcsOzZkv1kJmLzmC983Jisog4WLLfOEShhCD6Co=;
 b=Ghz5P97lJWQ7UNawce9W6A2pGQic4Hf3fUrbNz7Zdb16EcHx4CJJUIlC5bKyyt8Y8hlyaFsD8KgwV3dADewEkhJiUdPqF+4bqIFr/6t50k9ILzftnNHNYHIi5kpleCEs2GhfIYcQG+68nbzOoTpig7EshOBOP2xXsf9KW0Ykj2ngw3teGXUjEKzwTl8k6JMgJn+glYuHzDId5N+q1OZW0tB6uoCPx+qSeoiNogkAXa6moqag1h7liyVE2zpO2jk2/ZDuBtwkmn7oc8Pezxd7QnlvzXYei+qVCeG7a061KQGQjiNCnbV6ai3ds4Y/tIRXKcUhWQ1WVqElpAyVp5jnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL1dpcsOzZkv1kJmLzmC983Jisog4WLLfOEShhCD6Co=;
 b=YixWTUTSnZZrzLB8b1hhHQgr3C0vrQ7IC8M4Wolk+67+5SSdnzN2SY99NMGoE8nQTi4vlpK2M6cR6/bdaIOapmS46ErPpJbJwvo+wSe8pUsyYKIl07zpK0vmL+1lTNbzQHQO0/daTnXrxj1AqFLuA+2q1ccjVkAe2DO2kBFIFR8=
Received: from DM6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:5:80::14) by
 MN2PR12MB3439.namprd12.prod.outlook.com (2603:10b6:208:cf::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Wed, 15 Dec 2021 18:55:28 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::5d) by DM6PR08CA0001.outlook.office365.com
 (2603:10b6:5:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Wed, 15 Dec 2021 18:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Wed, 15 Dec 2021 18:55:28 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 12:55:27 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers
Date: Wed, 15 Dec 2021 18:55:09 +0000
Message-ID: <20211215185510.15134-5-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215185510.15134-1-victor.skvortsov@amd.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 640d969c-8053-4eea-c921-08d9bffc7611
X-MS-TrafficTypeDiagnostic: MN2PR12MB3439:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB34390302B9042210EA98356D8B769@MN2PR12MB3439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFtt9sOyTYBArWKx5vGVbC3iGQzgcS7uMp5mmXeK/4/Ou9cj+W/dW/QNJAa6MN6NF/hk0adzhk4SmpEiibGnMJD09K7q3nDsknBsNq8F99UgBcHhnVUB7uxtewIboo+vpPI0V2LS57kGe+v7sitSTpYJcgL5prtHW1OLjmE+EQOsIz2DLf04d1bi3B1hdHQxTIPNBANXfA6oA9Kxe1dlz7P5r3qYyDgP9/dr/+60xFlX+jBxeGG31+M8X3VsF2nzyXiRCRr3Wv6LhA9YH292D8L+y/KJcpeVgwF1EOwaILTV1YBbc+u8aAeG8x17JbiUfHGhFl5huaOqdhSEXBV161gR0KqTs9BhTkneXu+uPpl3eMMFUZLfuoHZv7mHFTNpH9H+sayjlsvuF0Id9FLSpbZsJW4QS6BQymUKbqzxz1iLzCCkVWgHBJWcQucXdVcsZjDU9Ft4TcaWHC5yqXkk19SSAxZ6C4yBadvJxRd1G/rAxktJYJbYegvpe/++HWIHQ8IxUNKmwv5CqU0otEgp51Re0lS+nfVgPx9VYUvd0jF7aQdUjqLfvh9iLyV9iJh/IrqfGgk7c1DG/wsqh965fJ08ETjHaPhrg+w3sbOOxy9X89gHBhH7dR1gicklfk01kBKdWwt6rdYL9SRQN9tit2jS8hBBQCD04hlP/h8khUcy1pd9xqfJknI7M+3Di8NmAYwgDMuGty5RuQt1VgwKtvSm5m2eJO8v9zJ8FIfGjwCzyD28/TF6SzkWanOO6tcGDJR6m6FrqiPscCPfJcCS98Nq2QcGkhTdCkK7zqXtd6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(82310400004)(70586007)(81166007)(70206006)(6636002)(7696005)(508600001)(36860700001)(4326008)(6666004)(5660300002)(110136005)(316002)(356005)(16526019)(186003)(2616005)(8676002)(83380400001)(36756003)(1076003)(8936002)(426003)(26005)(336012)(86362001)(44832011)(47076005)(2906002)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 18:55:28.2395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640d969c-8053-4eea-c921-08d9bffc7611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3439
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV, RLC function pointers must be initialized early as
we rely on the RLCG interface for all GC register access.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 65e1f6cc59dd..1bc92a38d124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -844,6 +844,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
+		if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+			gfx_v9_0_set_rlc_funcs(adev);
 		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index edb3e3b08eed..d252b06efa43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -816,7 +816,6 @@ static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
 static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
-static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
@@ -7066,7 +7065,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gfx.cp_ecc_error_irq.funcs = &gfx_v9_0_cp_ecc_error_irq_funcs;
 }
 
-static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
+void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index dfe8d4841f58..1817e252354f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -29,4 +29,6 @@ extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
 			   u32 instance);
 
+void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

