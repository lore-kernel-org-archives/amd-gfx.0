Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE836EB64DC
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Jul 2023 05:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12EAB10E021;
	Sun,  9 Jul 2023 05:52:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC93F10E021
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Jul 2023 05:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lzv73pn2TOr1kUO4aMsyup9WALSEVCqwwJ4H0P6u/SpVOtrtwrgfTkLKhhGju5pIExfgUW647XY98S1AmXeCT7Q6Pi7AsG2gnaFfEiCzKZJIzG0BehTYXFAEjabTjiKB9DVHjyazPg8hHHfOfcqyS8p1me48uUuT10NJY6F5RzNCII/ybd4Yb7HK9f3nZ1e4OnCPf1EEd1GA3/qBp6PkY3ue4A6ukILS9+WS4Ogp5yhwKR622fmZbG9vT5hIoke0P54o13Ij7sHAR+0RcUiXjiRS4K/8ja/kzTEAk0TcIDYLpF055kCVNzCV1OoL4p1UeoDlWBoS3cNzqBjRHyMgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcIwIi91epqcihNOZXXCXHNrl1NDUFp13TG34ZL7ssU=;
 b=k6tXse/2U1uArq32wRMxDL2qKXzZlzjuO2I7Z8VF7wst4SwOEXkL2Pt1AjwbjU+kRdPOT9Zfw7pjFLDbFgQcbcJwXdpQBVu5GdTW4ca8g8Q5sQ6y36GKd85FU/EsR5lFQFOjW9hYraup1JHXh0B6mFbk58TOgDy12c4ZmA9t9VyLShSH94Bu3EwsgI3zx/+VwdPGULj6wjMstg2qtNTEwfl9fmF9WrcN6uEaubpBzfMAZH1Rx1sotsdbFhWLGHPvv9T3+uHZNDWsrpVdz4PMdJKpWF56VYH5lFZu1oaYFfZbUay8rTIM0X/PsWCYXbF0fPmxiSlaQNbtRbxFfXkUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcIwIi91epqcihNOZXXCXHNrl1NDUFp13TG34ZL7ssU=;
 b=pKfUgFHn70OApZhKg6mfUNygAPi4CY+mSgPqPrr7E/6mM45nsujhnaOKMnmG5UDFomxT3SeQ1xxZBNg/EAgmDKZlH43/4tpHjcZ4t63uaZHUkhIkLqHPdV6bi4n2FyTtlJPkG6q0aWru7rPcZ09X9wk7VFm8SFWsQu7q0+ZpHGk=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Sun, 9 Jul 2023 05:52:32 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::73) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29 via Frontend
 Transport; Sun, 9 Jul 2023 05:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Sun, 9 Jul 2023 05:52:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 00:52:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix stack size in 'amdgpu_amdkfd_unmap_hiq'
Date: Sun, 9 Jul 2023 11:22:07 +0530
Message-ID: <20230709055207.222066-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6258eb-f842-4f9f-2932-08db8040b045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcGRvfu1RJt3ndVHtQmtEw0dne0gOSoyqYAdQL4Sh0ZCH72E41nstfB7oovpHyhqbQeIMGb4FSlj326LoRYU4iCUTpvK+hPJSHFLyAWyWlN9aK7dPV8Jkb6HcBpSKuJFSpUmqTq4TFiVGu7qeSLN36ACNjdeRFTg64ULI7blZsi8yKkzEESrgtOknNtBHFtSkyRq2kiZ5XbMsqXuwLIgMhshV/P2Ig7Eq0IfQGagMZ7EDfGSdCtRjLW5TFaReNNd1snwCCD3ODRUKfdBe+B7ZYonjGWSB0VI06Rm4eqBqk/3vuoS/xI0SdAf11Lf+FflCOLoGI4lO57627K0hrptmFTRGq2Oq1RdxerlMlRWs3G/3dnxG+V2t1kRhHBvB9d0ilnKb5SP/auhnX1M2zJhUQxzy2AFzCdSYiS7995DP7z5XZVQ3myZUWpR6I4rCqbPDWEGYETjpp95dDlIcUNFdq7jUp9A1sqf4b2WEG8IicQYC4o+ehnZKHyW4+fuHxenThVTKBiLh0XI88Z/ruJPlbAYyqlal9fVy6QrF9GjXnWd9Ph29cWA+rG6meSMjgWyekD7AdzNQhYp4WnYjruA6fXdaU52Zu8zBzimaWtWwI13sUY2Px/EZmc03STDrRl289putAQE7K1qwztjJnUqibx7Aic1fCY/yiDV/e63xQahPe31MBn+NZ7MxJM5vD5uivUjF3n+t+NtwMj2FS9dZ/FrJEcTFpyLQDAWyrHffjHtaCadKtq57uBI/fGPOo6ZQJmIR78ktmRhKhheqA14HQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(186003)(26005)(1076003)(16526019)(2616005)(36860700001)(336012)(426003)(66574015)(83380400001)(47076005)(41300700001)(4326008)(6636002)(316002)(2906002)(5660300002)(44832011)(8676002)(8936002)(478600001)(7696005)(6666004)(70206006)(70586007)(110136005)(54906003)(40480700001)(36756003)(81166007)(356005)(82740400003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 05:52:32.4923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6258eb-f842-4f9f-2932-08db8040b045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 26 ++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0040c63e2356..3f11889bca99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -836,19 +836,24 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	struct amdgpu_ring_funcs ring_funcs;
-	struct amdgpu_ring ring;
+	struct amdgpu_ring_funcs *ring_funcs;
+	struct amdgpu_ring *ring;
 	int r = 0;
 
+	ring_funcs = kzalloc(sizeof(*ring_funcs), GFP_KERNEL);
+	if (!ring_funcs)
+		return -ENOMEM;
+
+	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
+	if (!ring)
+		return -ENOMEM;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	memset(&ring, 0x0, sizeof(struct amdgpu_ring));
-	memset(&ring_funcs, 0x0, sizeof(struct amdgpu_ring_funcs));
-
-	ring_funcs.type = AMDGPU_RING_TYPE_COMPUTE;
-	ring.doorbell_index = doorbell_off;
-	ring.funcs = &ring_funcs;
+	ring_funcs->type = AMDGPU_RING_TYPE_COMPUTE;
+	ring->doorbell_index = doorbell_off;
+	ring->funcs = ring_funcs;
 
 	spin_lock(&kiq->ring_lock);
 
@@ -857,12 +862,15 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev, u32 doorbell_off,
 		return -ENOMEM;
 	}
 
-	kiq->pmf->kiq_unmap_queues(kiq_ring, &ring, RESET_QUEUES, 0, 0);
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES, 0, 0);
 
 	if (kiq_ring->sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
 
 	spin_unlock(&kiq->ring_lock);
 
+	kfree(ring_funcs);
+	kfree(ring);
+
 	return r;
 }
-- 
2.25.1

