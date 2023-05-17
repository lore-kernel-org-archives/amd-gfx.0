Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B073C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 09:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CF310E3F0;
	Wed, 17 May 2023 09:45:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEC910E3E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 09:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgXYMaJCpTe4n7cJ6IvljtbOKWIP22urrQOW2ukyf4a2MM1xVZIxV1QKr+2Mr4ZJhqICh8oN/ghUGgboNJWql5nAUqI1ufVwbTg06nq6wwcpFP7shSPNSwiNu5ewrFmfG1O9NCZXIaXT94A+yQF7sFPwKW7eKHpXiJYhsSUfqO592pSkGy5f1zERQemGpkAgWKw2ReBnpK7rKOzawu1p+Z9IPUlbVcAFezyfyswnXgZnyovJbmdSRNEOgtK3aViLq5TIKnqueI2ERH+kgJLjG13IwaPidYu3XJy92iJLvb1fMGjSJlYCgbSX1KQka+d7C3iIzE57wXEYWfH4g844Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGEfXKZ0iNovq7l4ssY1UrEtvN2LELHBBca9raWTJ3E=;
 b=b99AW5Cah2BJZdsbZz0d2jio4vja6SZ0kEqc7kBm3mj8zifS4Du8swAKG5WeR9OQOA5Q7jKaTzRPjMr3l4mRpUHmHcnRR1yAqQwDUQ50MBimeDVE1PN/2kWUEAQPbF5WT3zY7K8fI+YdI19CK+KqUuIYxx+frJG0Dsigyh7fd1Yr8V7KVXDExnhC5tuzToNQAKWACTqRUlNpZ8PrE7BCJrvuF2W/G3eeRpjFIQFgiRN0S4358NUqvMzZWPuWqP7k7MYojOh64OM+D902TAMPNTsg+e6JD/Vj0yvjzBsh5TWfSOVuwLJK9sXKx7ofIL2uxomPeA1jsr0asqLzqczN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGEfXKZ0iNovq7l4ssY1UrEtvN2LELHBBca9raWTJ3E=;
 b=xAKXQndhpWdXf2JfT2ZpRa/P2urwb71NTteEmdZ5dv79sZnphacrrc3ELUv7bFbIW10kRlWo59fa7TXMD8/84arhsu9moUgcSC5Esj3FvKthZwC9oy8UJhQqIDxJOe9BwMdeVmZYMgYJENrkqDCO+G/TCaqJ79K7dAQb70WgQdg=
Received: from BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::17)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 09:45:03 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::93) by BN9P221CA0009.outlook.office365.com
 (2603:10b6:408:10a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.16 via Frontend
 Transport; Wed, 17 May 2023 09:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 09:45:03 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 04:45:01 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
Date: Wed, 17 May 2023 17:44:42 +0800
Message-ID: <20230517094442.1395378-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 310d8efa-6e14-492a-a829-08db56bb6385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ze0K1ZGK9bxXMtdNACY1CZ5aimr7ofrtBPvtWCzzMO7+Gp+BCr2S0n2+qk7U5kBOybLiBzmWa+KCcZxQ0R112Rn5y4lTyHibvZq8Ry7hWSTZ4pQQPtNrJbcFS1xoVTVPdTl2VWZdv2IDPDtvFf/Lvr1WnCdLaKOX0BZQi2Wqk/O6vpsneSAqbsbmdTqpfsXsso6Nxy4pJLyOxccvwlgFjmb39Uvib2Uy3MwTLdEJ85AHZy9GgleY/wCW5aJ5yZJUqSWsuTTA8XInZOVe6CXGredfnjsbNh7nQnEUbe0P0ZYXnlqMH0wyBco2qzZE3JtakIzbw4n93WRKQ+bkE5ttlyMlL68YYIYOTkeDmxngNPFvakX8i2UBCAcIWKzoEeP3sFsbUc0B13DVkja2cTYnDG0pScE0TF9H9dwXz+77rIgVCfnX3qWJmF+Tun6DxJNJ0itS4xQb1+4Y9g1xJY3ZfY3henuYtaC148e2d1Aay0wB6uchJD6MX8WmOBDa0bQTnsNjpt9I/uRrcA5mfiW7g41NQakJTuNBOtiE6Mk38XIpiX1X0n3IjurS8QIqiAH77wFGEcvxuGZn09gcX8jM/cIBro9pBQKxnqGqk450+33jG1uLovwXkX6Ilv1IRpW2NgaArLdBAgs4mbclGJG1Q+XGE+suUibLB0RWLRaqGPqdQ/KcIFeV71HNLXfc+L7jY9jYq+XlIwj0/WifkcYPn7DKjazYSLlvSSElemk7fFC3BaXyN+61yp8hrZxPtNBtFq6sq5BeuLd1QD3xdqrG+w5QWtNTwBbHQawRs0GNKKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(47076005)(110136005)(426003)(336012)(478600001)(7696005)(6666004)(2616005)(1076003)(186003)(16526019)(40460700003)(26005)(2906002)(36756003)(4326008)(6636002)(82310400005)(82740400003)(70206006)(41300700001)(81166007)(5660300002)(316002)(356005)(8676002)(8936002)(86362001)(40480700001)(70586007)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 09:45:03.1165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310d8efa-6e14-492a-a829-08db56bb6385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Need flush HDP for MQD putting in vram
2. Zero out mes MQD

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8883d5ee13cb..f2d0b1d55d77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -593,6 +593,8 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 							kiq_ring->queue);
+	amdgpu_device_flush_hdp(adev, NULL);
+
 	spin_lock(&kiq->ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
 					adev->gfx.num_compute_rings +
@@ -630,6 +632,8 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
 		return -EINVAL;
 
+	amdgpu_device_flush_hdp(adev, NULL);
+
 	spin_lock(&kiq->ring_lock);
 	/* No need to map kcq on the slave */
 	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index f1a6abdad21b..88262f10ef7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -632,6 +632,8 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
 
+	memset(mqd, 0, sizeof(*mqd));
+
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
@@ -728,6 +730,7 @@ static int mes_v10_1_mqd_init(struct amdgpu_ring *ring)
 	/* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
 	mqd->cp_hqd_suspend_cntl_stack_offset = tmp;
 
+	amdgpu_device_flush_hdp(ring->adev, NULL);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9791f3581786..9a48328c6572 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -704,6 +704,8 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
 	uint32_t tmp;
 
+	memset(mqd, 0, sizeof(*mqd));
+
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
@@ -797,6 +799,7 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
 	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
 
+	amdgpu_device_flush_hdp(ring->adev, NULL);
 	return 0;
 }
 
-- 
2.37.3

