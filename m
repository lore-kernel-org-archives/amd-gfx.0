Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF851C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 10:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D235210E7C7;
	Thu, 13 Oct 2022 10:37:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375C710E7EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 10:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqsxwA2qYxeVWMt9jhHbcsyCwccNMgpiQSMp8+/Ivm2mNfTrOLDhoRt639vbqrH2nEZyxKQHrnj+yOM51qlyFUzraEQ3P0jQv9rOBNiOwkXRlHEAUw4n0Rlc59Tg1W5Yv5udJOUmu1FE+YHErpYd/G6xTxHmtame5QLDUcgw9QabmdaB7+5iWhSQrt17xjchupSZNBmm+4+oiNKn9BznISloLXNcQF8W1d3FyGx/E68fAsF8AJGN7xDjJM3NIPbMTJkjnlsJcwqXN0kV5mGtq8ccXgSUyCIYIT86kpkQG7jTwwBYx8FRacKt9+qhK1/FKgkPfc5eE/nvgVfKsH7gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAHVNqjTNBdsPMTiXY8BLV+NFl2+TfGqdmLIXKUwWvQ=;
 b=LMS/MiqbtbM8xDETMvIYgSkRIwL/AmVLWEUKdRPOptKoLUZlpepXXdQR1kFmEvPOCBTuzLRjyi4CfGWiwVVzWc+62iIW+MFHGz2qn0tsQX0K2tLlshdWV4qOVNSO4wztK0VAOIrtHjJ1g7k7AZwWVzS0eNCwxXWHb3ovDK3Y891D/X8XhhUPiG05GqUKLYvyXaK7zorUxcixuxhtWlEYto22nX3efIDn2JCd5MWesuNhfTWj0SiZGIa5sZvnFIQ1V8v1DhqomhG6gaaadPy0ALLYZ2ETiiXV0Aw7fdJdrvzUH/aMkXHBFO0WVFegKVl3cPw9cUZmam2PbMiUS1gC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAHVNqjTNBdsPMTiXY8BLV+NFl2+TfGqdmLIXKUwWvQ=;
 b=rd9W2slxKGOHnabaHItxATKulAhqJ2qfN7j7bhk8YsRe36Nb/wlXICh8sYMKDYYXMBelgCDTyH8RcgGLWYxN9RaPsXH3FO/GjgVZI1UGPWNmHnBp/gOc4jacuu7F3/LtYuKgj2utt7DiTVTDROwg2WWBhfpNC22l7MsUzBEabXQ=
Received: from BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 10:37:18 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::4) by BN9PR03CA0060.outlook.office365.com
 (2603:10b6:408:fb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 10:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 10:37:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 05:37:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 05:37:17 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 13 Oct 2022 05:37:14 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: dequeue mes scheduler during fini
Date: Thu, 13 Oct 2022 18:37:10 +0800
Message-ID: <20221013103710.2965530-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 59473ae9-eb56-485f-e63e-08daad06e6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1qdZUYtytIedHsiMVhv9LvEy8oqzyTRE5kGmTW4iuqx68Dna5MwNBc2Ic89BDm6ORi5sjKh9GvB7tQ9XR7jFhp9RXJP0x19qxAGOuR1X4AO/VPRbNLLXguaoXZtnR0gkF/uh0DeR5zS0Kmc+mEvYTGfA65P8dMSl9cPNhXbi1/ZP9ovgjYP9RpWXVS44fSbzK2TO4g0bbkNVcHxXEH3yOGyuz0UbFzG7FPHTWdJp/jo0BzH5ZGP3w6NXE18FmqQ+HYBUITdreamZb4RBE0P5mFO/jm84Rj1pmg9mHrqtTOoSBkgTzy5ajSUcoiizTeY03SLLEfAKUbDwDNIuRa1HIs0mDbL0Sun8jMz4CfsQRoU/aS0CW0n3Xt0MYwwWW/IBVMq+1gQpQ9D5y5xNhKhUT8xbwR7RjcWdFmWKoxI20ivNl5RX9/Wz6jrTY6qEXksBR6omqJwyXl+VHdRdqK7Lw1iAbD+YJsmJrJzoXIWGHdw4EnGQaI4sLc24fycN68VWAow4KklYoCm03ODV4rt+/fU7EJhdJ7SJ2RuTv9LErEnHSbntxComhnjDD93IEZaRFDsbQJo4NmBcXWpbf+JcNs1O/4eIeLHc/Zvif+9iQ+du8nYsCvA13ys6bQvWKPsVzHJO8e1KYdaX2h3XKGXxO1V4tk1tuwEmVD47NEA9jBB7wRYnwyRSS3jRJxoDJ9dzW1ODZy99yzkyujOxU0a/3dF6TG0CSvLZvbhgx7XNvt1o4K9zqTO8O6Xh9ufLRFazhMRwBCvtBdOtnjv0/SKSPnOO3K7Oh2US53NYwZvz3A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(316002)(478600001)(6916009)(54906003)(6666004)(4326008)(8676002)(70206006)(70586007)(8936002)(26005)(41300700001)(356005)(81166007)(7696005)(186003)(1076003)(336012)(5660300002)(2906002)(2616005)(47076005)(83380400001)(36756003)(36860700001)(82740400003)(82310400005)(40460700003)(426003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 10:37:18.2358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59473ae9-eb56-485f-e63e-08daad06e6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
If mes is not dequeued during fini, mes will be in an uncleaned state
during reload, then mes couldn't receive some commands which leads to
reload failure.

[How]
Perform MES dequeue via MMIO after all the unmap jobs are done by mes
and before kiq fini.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 47 +++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index ad980f4b66e1..6c9208e8f027 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -130,6 +130,9 @@ struct amdgpu_mes {
 	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
 	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
 
+	/* dequeue sched pipe via kiq */
+	void							(*kiq_dequeue_sched)(struct amdgpu_device *adev);
+
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 257b2e4de600..7c75758f58e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4406,6 +4406,9 @@ static int gfx_v11_0_hw_fini(void *handle)
 		if (amdgpu_gfx_disable_kcq(adev))
 			DRM_ERROR("KCQ disable failed\n");
 
+		if (adev->mes.ring.sched.ready && adev->mes.kiq_dequeue_sched)
+			adev->mes.kiq_dequeue_sched(adev);
+
 		amdgpu_mes_kiq_hw_fini(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index b48684db2832..79fcf7c304cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -44,6 +44,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
@@ -1078,6 +1079,7 @@ static int mes_v11_0_sw_init(void *handle)
 	adev->mes.funcs = &mes_v11_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
+	adev->mes.kiq_dequeue_sched = &mes_v11_0_kiq_dequeue_sched;
 
 	r = amdgpu_mes_init(adev);
 	if (r)
@@ -1151,6 +1153,42 @@ static int mes_v11_0_sw_fini(void *handle)
 	return 0;
 }
 
+static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
+{
+	uint32_t data;
+	int i;
+
+    mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+
+	/* disable the queue if it's active */
+	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+	}
+	data = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_EN, 0);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_HIT, 1);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	adev->mes.ring.sched.ready = false;
+}
+
 static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
 {
 	uint32_t tmp;
@@ -1257,9 +1295,12 @@ static int mes_v11_0_hw_init(void *handle)
 
 static int mes_v11_0_hw_fini(void *handle)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	adev->mes.ring.sched.ready = false;
+	/*
+	 * Do not disable mes.ring.sched.ready here, since mes
+	 * is still used to unmap other rings.
+	 * We'll set mes.ring.sched.ready to false when mes ring
+	 * is dequeued.
+	 */
 	return 0;
 }
 
-- 
2.25.1

