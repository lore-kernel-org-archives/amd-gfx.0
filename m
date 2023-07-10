Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CD0EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 03:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7428710E044;
	Mon, 10 Jul 2023 03:23:25 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449F110E044
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 03:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ0hc9+e1mLvuBlRSAWHTnNT6JuM+Cgi/1KOBFHs4EHzaLqpHa1Obq2nE+I/tB5PdDH2GdWipqR5ffmNo7RJhzLlWt+wLh1faVpYb6b3mmenG+HT/BNDbIo4FEekrOCxmSSkdcXYVCZh5YjviLd2UHLOUgK5+Ot0w8Jol01o100x6p10XIedRAMgvt1wpPGAdmW4VABJcOzzboYoprDuaK0fpL5LzFvFU9W6fQcAQG4IQYA+TTpu4l5Jj568gBZ8TEg5sox9g3Md/kQqSLfKNnKuTPDTHQmNCuVM77sVU7EYeI9qZZMceN6BBx942gkbGM7mkDe7Ccbv9nTsAuJ2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4hW89gYIMlHNMEBkApYIsv2HLchRg0ss9nrflRegMk=;
 b=K1Z6rlgfuDvLAAR5AN7QTQ5KceE5MHC8zhxy4ubMQAcd85gCyYIcgu/nXoe9v9JxkNNQdsub9UpXWQR1Xh21HbqIBoGL/IB+0r+s3bOma1gTj/KjsqX0GmQrAf5oKTFVkq92/vrTYKQ5MVCyWZhJRuvPK50T2QMXDUSLLGTWK0pl72d0UfcMGv8uza+fj2Tw79T3aBbIzE0vgnm11lKxiI6KVouTKJp55n6rms1lVcCS/EWq567oEhu9pIj8mG2MeqLfpHZT/VnMFxPUBIrmsCibDMAH2ffvpVQ6+OT548XrMfzBS6wJH4VU3pmTBWmMTnpOSo2+IylWRZEISEM9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4hW89gYIMlHNMEBkApYIsv2HLchRg0ss9nrflRegMk=;
 b=NkI+wrw695KGMdd4Rtr3DdKqYkWyt0vWFdo7R5EhQkQWjwen9i6IiEJ5UxCEQOimhfEEALfwNLAqfisWrUGRkR2q0Al8mX/Yp9ZVWT8gs5+StPFqsE6t27w9es/hxaJMbuVqxZMlG328/VV4yUBjRGeRFX3n4wNo/oWUZou4Zt8=
Received: from MW4PR02CA0005.namprd02.prod.outlook.com (2603:10b6:303:16d::14)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 03:23:16 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::dd) by MW4PR02CA0005.outlook.office365.com
 (2603:10b6:303:16d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 03:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 03:23:16 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 22:22:51 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix stack size in 'amdgpu_amdkfd_unmap_hiq'
Date: Mon, 10 Jul 2023 08:52:23 +0530
Message-ID: <20230710032223.274800-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230709150506.255846-1-srinivasan.shanmugam@amd.com>
References: <20230709150506.255846-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca38575-cf65-4829-0da5-08db80f50041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rd2CgnD/k8y+Rv9NzL3hP6de2rEI8Tdo7d0lZQX73LBBcAuWVZLOuV/7AZWRVQeuTN5Uqy98hMqezbU6zt4hJPfO3J0gpdFyQifj+r27JzQ065NEpLGSIkZ8TePxva+3swVzO1Ev3p5GZbtEbbLbQb9DfCvTyxtZiOh0MA6M2WRCr8kfKs7DFt0xiPK1UzDLf0sQ08VF/UgWKbdAnWYAaCE6kcqlMGrd4wDWXA1fKiiVjDbQ00nhgpD1pqfh8ETBvFgsiFmMzDPmpFoNHzDp+sJUIlak8sfkJ9yqPe5pgazczoA73KFMrh3piQS7fczptUn4uSBXZF7JP8y1a0+sn84MJDtfC8xEyDKH3HPPOmDLld0tt6iyVY/VUvDxvfKvoDhLm327Ez9yXKj7cLhisz1W4B8bfryMX548d9DEb7tBlQHwZrD70OPfh6zXGkK3IxHUbCYb2ZXCu6GIZnn3GA+kLBeYFTueQCnCBqVxs8Eu+XfFsUftrAcw5Ce5yAKCQa/+ZElC0ZbDafXCUrzl3ZvVwY7HK5j3hsXib01MiS3yojsyDokfUfSed1Zwe8nxBbxIUinV0erFCQdyW/l42PQU0s5vS+jgaA4HlI0mc3wGBm6Gh0AgubC+B3QEtMd9WNg/tCBx22arvOoLHucef+2iOxpP4kDF4QjLD5uD0gN4nl1rOsTp1BjrTHSdfeq3pbtVbRsjkFApHX4ugIhW8qVZBQrdKvCQ5qbEPye87Ss5os5khM4JEMKlxILmCYEYe81EYt9OI1vup2LQaNgiOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(478600001)(7696005)(6666004)(110136005)(54906003)(70586007)(1076003)(26005)(186003)(16526019)(336012)(70206006)(2906002)(82310400005)(41300700001)(316002)(6636002)(4326008)(5660300002)(44832011)(8936002)(8676002)(81166007)(356005)(82740400003)(40460700003)(86362001)(36756003)(47076005)(36860700001)(2616005)(83380400001)(66574015)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 03:23:16.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca38575-cf65-4829-0da5-08db80f50041
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
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

Suggested-by: Guchun Chen <guchun.chen@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v3:
 - free ring_funcs before 'return -ENOMEM' (Guchun).
 - keep the check of ' kiq->pmf' and 'kiq->pmf->kiq_unmap_queues' ahead
   of allocation of ring & ring_funcs (Guchun).

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32 ++++++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0040c63e2356..629ca1ad75a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -836,33 +836,47 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	struct amdgpu_ring_funcs ring_funcs;
-	struct amdgpu_ring ring;
+	struct amdgpu_ring_funcs *ring_funcs;
+	struct amdgpu_ring *ring;
 	int r = 0;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	memset(&ring, 0x0, sizeof(struct amdgpu_ring));
-	memset(&ring_funcs, 0x0, sizeof(struct amdgpu_ring_funcs));
+	ring_funcs = kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
+	if (!ring_funcs)
+		return -ENOMEM;
+
+	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
+	if (!ring) {
+		r = -ENOMEM;
+		goto free_ring_funcs;
+	}
 
-	ring_funcs.type = AMDGPU_RING_TYPE_COMPUTE;
-	ring.doorbell_index = doorbell_off;
-	ring.funcs = &ring_funcs;
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
+	kfree(ring);
+
+free_ring_funcs:
+	kfree(ring_funcs);
+
 	return r;
 }
-- 
2.25.1

