Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C1AEB64DC
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Jul 2023 15:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C801E10E0DC;
	Sun,  9 Jul 2023 15:05:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57E210E0DC
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Jul 2023 15:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaRQ/qQCn532nC53+ypV3LFMXribUIYFImrhpf2+j2BeD18ZuAYal0J9e5DuoBOOlEMTT79OytEWf/mDrtlZTJMDovHrkTa2RhBpSIOl9WtIqWfTmw+5SIsvB9ldoS+uyVWcg60cSA13aI7KR3uq9yF1rri0wFja/3Q8T5qsifBH2PJOWhb5o5uNG0XNs2vryWjVDxRhauucXBDDXcDrWJU00/B6C+UeKii3PiY0FWGzU4X8ve+iCRfUFDGLYwHMP9jYVNQ71DdVxq6rSHFplZwNNdVD91jERNwZZ6ul13ALq985+LggXx+pO0AQJITrqhTDiE6yJodUoC/63mvc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t49CLEw5A2i3dCwupT8zZ063MQv8SAHTDODl9yyiIXQ=;
 b=hvxTuBVYzlx9JSK5TAfNOAXxGn0fQC7T23utYBRkTu0g8N50vvV1Jx0uitzkngqNiAnbVmNkBzAUQ6LF+XoMzFSNd/HZng4Bsl5AVB8fqQoFKMbPcZ/OjZBh8I74sWsfGdw6kpQ6Ng6w9QSFu6RDH1gQLqTarMIo8lzkedbtvLgzeTVlsEfVixUySPMBgHecThgXJXKo+3zrG1BgmitwdA2KCOEhJPwvGhSyMP9cm7QTxfB7GRS4AXcRMhFrznyiayL48EEcFcYwz5z+ZXZL8eV0bHuO+A0gW0f6VpgLOp1PbI9PG5V0FZ2CMnpev2l+ILgQcsFLhPZMk4rM+rfbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t49CLEw5A2i3dCwupT8zZ063MQv8SAHTDODl9yyiIXQ=;
 b=JgtpwF1pfPGJ2omDSwcW1PQcoLaggO22NouhxxPr800poNHT/PKmy2A6myspeGGfJmO0cziq6r+Yz0VP0c4qpU8yF5NhqaJIP2eyM90oTFEUviyp/prGoCoaHzL3p3Y2aiCsJePuA6gxizJU/gwqyr6Tpfdbx02yEBcSe7Q6W4U=
Received: from DM6PR10CA0032.namprd10.prod.outlook.com (2603:10b6:5:60::45) by
 IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sun, 9 Jul
 2023 15:05:32 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::14) by DM6PR10CA0032.outlook.office365.com
 (2603:10b6:5:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Sun, 9 Jul 2023 15:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Sun, 9 Jul 2023 15:05:31 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 10:05:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix stack size in 'amdgpu_amdkfd_unmap_hiq'
Date: Sun, 9 Jul 2023 20:35:06 +0530
Message-ID: <20230709150506.255846-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4321a8-0b60-4926-9895-08db808df0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaHMF+BY9cMUNLnqI1AwK5qY2Zl1ZktyXMYgAvv7Blc/BQPEbQhw3dyD/yW5Kba9rgZ4mIjtGcjbjdfoyY7mfk/u3UUzIvU2qAKo0DnfyIYo+CLyITLfRpZwp8GAgCoiKED5UX8Y2d5+Wa6SUBdOEGfDDVZRJmHzMtoP3a1o+nf4t2fanLzXkd/y8dvORVqZMvyzg/Ie0dx9RjO6znGRyri5SJIpyshWnAIslDjpLcgVxIRodMM1VgXJC7dRIzDHqtfYIABWFB+FkaCxN4WuE5Q6VH9n1mhwex8nNK5aN2p8zmsoFmLlz1tcs9lu/HwNIWybdoxS/mR5l7jr29bBcP8RanHAsuRJqoiC/3X57kHBjmX6rzxv6OoFeuz6g8c+FuxRpSfdhhaaT7SDv9NuHacg4N8OhKIiCeZVVcucHzIxgiY8PoygTZ3QMNlIKZUc9vRJB10eTH0j21hlSry/FSuc+HVAsTmyzA00iCg70T9sMpGDB1hYQAYSnO9O5mtCnrxXdORE7O8e+K8cPyFL4FPHyJlRu2HY4lripEk6KiTrVGFisDsU5Q2SNwbra1/hpfFdoXuMYkNLFt8uBGfg9QairmefJJch2DRWzyQCU9Z4ZOIqpbd1kR/VDYW0jn+4mLyP8fnhCXKSrlujuRNwEf9Z8/6d+HqXIx5S2tU8PeyrOn0AjFeFk3IpJgkjpOhCaowlXwUWPjB/YoI2f/sSVeYP4MMVzXJ0KH1AQPhXecrXJSjJifDV8CgG8DN/5XXuxNyq+1FDoDrhCquiB2Bfxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(478600001)(54906003)(110136005)(36860700001)(2616005)(66574015)(336012)(86362001)(426003)(83380400001)(47076005)(36756003)(40460700003)(40480700001)(2906002)(82310400005)(70586007)(26005)(16526019)(186003)(1076003)(81166007)(356005)(82740400003)(70206006)(316002)(6636002)(4326008)(41300700001)(8676002)(8936002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 15:05:31.8404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4321a8-0b60-4926-9895-08db808df0a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate large local variable on heap to avoid exceeding the
stack size:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c: In function ‘amdgpu_amdkfd_unmap_hiq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c:868:1: warning: the frame size of 1280 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 34 +++++++++++++++-------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0040c63e2356..8c9a48062abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -836,33 +836,45 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	struct amdgpu_ring_funcs ring_funcs;
-	struct amdgpu_ring ring;
+	struct amdgpu_ring_funcs *ring_funcs;
+	struct amdgpu_ring *ring;
 	int r = 0;
 
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
+	ring_funcs = kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
+	if (!ring_funcs)
+		return -ENOMEM;
 
-	memset(&ring, 0x0, sizeof(struct amdgpu_ring));
-	memset(&ring_funcs, 0x0, sizeof(struct amdgpu_ring_funcs));
+	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
+	if (!ring)
+		return -ENOMEM;
 
-	ring_funcs.type = AMDGPU_RING_TYPE_COMPUTE;
-	ring.doorbell_index = doorbell_off;
-	ring.funcs = &ring_funcs;
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues) {
+		r = -EINVAL;
+		goto free_ring;
+	}
+
+	ring_funcs->type = AMDGPU_RING_TYPE_COMPUTE;
+	ring->doorbell_index = doorbell_off;
+	ring->funcs = ring_funcs;
 
 	spin_lock(&kiq->ring_lock);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
 		spin_unlock(&kiq->ring_lock);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto free_ring;
 	}
 
-	kiq->pmf->kiq_unmap_queues(kiq_ring, &ring, RESET_QUEUES, 0, 0);
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES, 0, 0);
 
 	if (kiq_ring->sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
 
 	spin_unlock(&kiq->ring_lock);
 
+free_ring:
+	kfree(ring_funcs);
+	kfree(ring);
+
 	return r;
 }
-- 
2.25.1

