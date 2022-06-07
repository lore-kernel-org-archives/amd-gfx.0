Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312C4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 22:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F9110FE36;
	Tue,  7 Jun 2022 22:50:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F6510FE34
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 22:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4QJreuF7E2PSLM+3umTos3Gri2aWexMftQ7Wb3t5ADyx7Rr9y+d0FKSfJ912Q5/yyeHKsGzKB2dUyjmnDyBah7yjP6MpEuEQJwebjNy7oyPgAP/YOB6ZTgWMpcxHLHu0MI4Vuc31CRkVXNWyEoJyKRBSvMARq0PsbqZ8oxiumrR89H0HMIpTmJRTy0jYudAK/F2z1FcJcdXtQJJnyOS1a8/I9JE8mJsN3PVfYPdrgxFxb8rHw3JNRjSVnXird8rF/5WbWd8s/K48FSfTjqSS7L4jnsgt5npFazz1eJxr4lzlPQBr8m/DxsbBZAuUxL0moNj/b/AJIz3+ZUPiBI/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN/bR0iATzyWhEoNQ3mM4lLxJArOVV4EiaVzPsyyG+g=;
 b=FyYCRHZkK9WY9nKks0eAdJI0oZOJ9xvxVduBxh2thvYGroiLNilqYcM+GirQS0lq0GjNZRfOjKtO0v462wgZrtelw18B8n9ZIWqMsA8VGvJwYsZtfAfVssfKd4UPJng9G32YwXjcTS1niyUu4uRnfR2wmwF4tVy52PH6ooWYd7W8ccAL4E5pe4AlgPQlJiNUfFIpRV+iMjzk46WSShNHNJL+oiX4i+olPPmWpRDZil4Jqb8Yi0B2Rj/CBYsUBWOxoR5z6aBs0Qyrgdtx4AP0LQY4Kzmo6A2V7QXfFCEzFX2FFw8FHKrBXWDKGTYhhOOjdiFAsvNfsi3TBdqYU7linw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN/bR0iATzyWhEoNQ3mM4lLxJArOVV4EiaVzPsyyG+g=;
 b=AlFZtCEh8tqQI+u9bwrckbPr5Y61zaHYCyYSmAfFN6zITPYa9HN6/8ZkXsVe6Vl6qHKNZ5HmY9gy2br15UCptdhIMrrliIevUZp5kUTIBtBvryhLmoiM3N4hqeUunCdwyRkzfUBKBsZOud07GwUtyCyd56kxwPvBYF752uc3Vys=
Received: from MWHPR03CA0012.namprd03.prod.outlook.com (2603:10b6:300:117::22)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 22:50:19 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::29) by MWHPR03CA0012.outlook.office365.com
 (2603:10b6:300:117::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 22:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 22:50:18 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 17:50:18 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Fetch MES scheduler/KIQ versions
Date: Tue, 7 Jun 2022 18:50:04 -0400
Message-ID: <20220607225007.1372343-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85494fbc-841a-4ed3-02ef-08da48d818a7
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848936999AAC7EF0850A2E98AA59@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+t5p5tOnRXpqAJCLCJgOVfGbGcA9VpJEHRi24ID/hwzVu3+CrMRyajMvTw2vR/cWRLwoDjqHWAHefVi99uL0sVrck6KMkvXOEp1LdrIPFYm28xwjFns3aIuc45mcXp4GPtTjsKC41l5TzhN80YdBwUjGmJQ2FZo+kTcLIPPWo/Az1H0JvkXi4a6iaepMnCh4qktQFn5VGGAhDgtZhu6JbGwjsq2lac0IjfDnk3RSX/EuJOhHv2EgVsaI4Gi5kfANj85XbPpdEOwr01eYtfRVwOuOqPze7ssus0prQA854f7M2kFr0EZIvoHEg8hGe1fxcmSXEUbuzize9DpAAsuelNUId512IFGgFrrwJY0JSaLOi0YpPvOHodVJQqeamisxHRfS9Y3wEapJgZpPBhrtcG5zTyk5d/cxoX9QBMY15HEWTFT1tevaloiPijV7FdzYHq9k6CIjA1eYbgJ1Ai5I3IukOrB5XY1HE+CGmfF72l6wfX/k7iW3ynNhoPnyoQKU8YKdSwG4Bzaao8WDVmvZDbvDflkP5FtiAXB1ZSVpXMPCgc6DH89MMO0cWK1gaP1DrWxuWl6gLO9LLT27ViQm/FtWO0R45tXYbF3ky4Ds6H1cgjMn4XZqdodQgfFPOiDmrV7e576C+QTANVfnbxK4aVT5lSq3QHwVX4AedGmQDUDt/q18rljoA27ayS579WAZ22NRexl4tgYXrUanbFwyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(83380400001)(4326008)(7696005)(336012)(8676002)(16526019)(508600001)(86362001)(1076003)(186003)(2616005)(6666004)(40460700003)(36756003)(47076005)(54906003)(70586007)(426003)(8936002)(2906002)(6916009)(26005)(356005)(81166007)(316002)(5660300002)(36860700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 22:50:18.8205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85494fbc-841a-4ed3-02ef-08da48d818a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Mukul.Joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Store MES scheduler and MES KIQ version numbers in amdgpu_mes.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 92ddee5e33db..aa06c8396ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -64,6 +64,9 @@ struct amdgpu_mes {
 
 	spinlock_t                      queue_id_lock;
 
+	uint32_t			sched_version;
+	uint32_t			kiq_version;
+
 	uint32_t                        total_max_queue;
 	uint32_t                        doorbell_id_offset;
 	uint32_t                        max_doorbell_slices;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e4eb87689f7f..2a9ef308e71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -890,6 +890,18 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 		mes_v11_0_queue_init_register(ring);
 	}
 
+	/* get MES scheduler/KIQ versions */
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, pipe, 0, 0);
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+		adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
 	return 0;
 }
 
-- 
2.25.1

