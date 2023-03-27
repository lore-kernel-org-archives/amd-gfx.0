Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01211C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 15:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E40110E381;
	Mon, 27 Mar 2023 15:20:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66E110E381
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 15:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0dWV7ABV7k98usGO4ykAgHlVOi+sL5zrEVyBRDoD1R87/8nVKRXlRJyk37r8UgMzMe3AogiHs8aTk4KuTqzA9QULGED37tdlCWrBvVmmoMYCn0fyT8DdWa5WEcw7I6gWIj9vA+QISATewoy56zWrjQDxSqR7YhhhcUzPRnDd+kAitj4jSGf+/rhPbPCRN+Po7R3NhI/MFZ2tpvZsTRIhg2/KwJMoiwvc1V6nxu4THWPpKbzFS4kspUxuBf+vuD/zLSvbK9L+pBjGj5/9TSD4ztzkoo5C99+WApf1k9kTDKz50e3tD7qsObDunSADyg90rry547hcbNE2knhoet1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mQLmOYU5NRN0o0gfr7s+37to9tw2PUcIDGNxRz5Ifw=;
 b=K77MIl0eJD70PpsBpk+leW7MeJc4yuh55O3yQY1U1ZQyfRXJu2WdoCq8XpOxjYl75Gi/jRFHneghd7T4vd/UI0sRHPEfEFsSM04tTIOYCYkE4vZa+9yUiXc726v75RAKFYaxlTwQm9o58uO9/qG6JA6A14HJUQE+JCy68idauU4TfQHQZZqciUNNDt4Lniepbwv7WMc8tzMyS8d3GSytyFuep4AsE0ntI8zYo277q5u5ZXl4nNSEsChiqqLQCfiHLgTINLaRgzOpvPHETW5rEMjretgdV4KhZvpLjGhVvSHWNTQ8nMW4KPWBFobiFTi/rUW2NkeE2GjAizmkjj3K4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mQLmOYU5NRN0o0gfr7s+37to9tw2PUcIDGNxRz5Ifw=;
 b=t7KyM+vLv38zdSYi5ut5fO2OVRzuVFZi7cmBEkgJ+6keU4nRYKmGtgpf9U7oKdVlyZxy1pe6yJCO6Htp2Xxwh99wf4ILZF6091POAKelE1yTPZt6Wx8CWW+ZTa82vExV5sp1O+42k5XWpvHbCcWWouDuXRwSs8dW8gU9jHl8lUQ=
Received: from CYZPR19CA0022.namprd19.prod.outlook.com (2603:10b6:930:8e::25)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Mon, 27 Mar
 2023 15:20:34 +0000
Received: from CY4PEPF0000C983.namprd02.prod.outlook.com
 (2603:10b6:930:8e:cafe::35) by CYZPR19CA0022.outlook.office365.com
 (2603:10b6:930:8e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 15:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C983.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 15:20:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 10:20:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 08:20:32 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 27 Mar 2023 10:20:31 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Date: Mon, 27 Mar 2023 23:20:28 +0800
Message-ID: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C983:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 02efa912-791a-4df2-94d4-08db2ed6cf3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i98o049sLrHj68CutG8/8PyI29cYV5qY99cDAA8Cs2JuneWpFPwJYZjbBPHEUvSp7BIHITMCcMPQcZf73Aewe+s32ujbIz7BzSvdtHut9wB9uvPcMTcuj8ZvM2w/uJLMjLagi2NxoCtGR/vwiR4KTAHB19TN1mLcPDHOUBzl9yCRMD6Mf+62BKzOvvm9YxK3rk852daeYj8XoCrmS4IkA0vYiLO4lZfeBxNNIIiVW0yFXAhiVo8M2gE6L9a8o8Ky49sVz09sGCGRDinVAZCu/uUPxtjk5PIs7MQtfhVV+B3nqN9loiWJnj7LZhr5a7CcCtZfYlTPbsf8VV3jBXq6TbZ7d7QSeuNDMTFqIFqWesT36xVGqy85BllQQxCW0Xfmr9u9+FoY2p+P3nTuPgqrAIoWJzdu1gGRz/XCMDGdw67pXHPEsAtzWoKwqn1M/nD77WCNoElK+KM/47iP9wQUFIReh6FIAL9NNIiitTmMWou+Q6cYtS+gHLM4M6AJ5l0758CxQ0clz06jJ3Qu30W/SvXpH7U3wiAp9smnD15R3+nmIQtQqiDjWkW0u4zjDToxxhtu7eRjvfs5ZIPO0WvyX32WkN+dRyj1zV/Y4aWnqls77ImWoCRu5bTC9RbdqLljtara6MxkHax5HwJ7SJkAPUQGjwA0A3RgaLQWX3eSpfrlaJAFO0fbdfVnay1SnQ18l7HcFwfT2abkWHi9CCmxyBAe4CULBFQ5/AnaMRshgXE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(47076005)(83380400001)(336012)(426003)(36860700001)(41300700001)(86362001)(36756003)(5660300002)(8936002)(356005)(81166007)(82740400003)(40460700003)(54906003)(7696005)(478600001)(8676002)(70586007)(70206006)(4326008)(6916009)(2906002)(82310400005)(40480700001)(6666004)(26005)(186003)(1076003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 15:20:33.6565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02efa912-791a-4df2-94d4-08db2ed6cf3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C983.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065
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
Cc: Alan Liu <HaoPing.Liu@amd.com>, bhawanpreet.lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
After gpu-reset, sometimes the driver would fail to enable vblank irq,
causing flip_done timed out and the desktop freezed.

During gpu-reset, we will disable and enable vblank irq in dm_suspend()
and dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we
will check irqs' refcount and decide to enable or disable the irqs again.

However, we have 2 sets of API for controling vblank irq, one is
dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
its own refcount and flag to store the state of vblank irq, and they
are not synchronized.

In drm we use the first API to control vblank irq but in
amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.

The failure happens when vblank irq was enabled by dm_vblank_get() before
gpu-reset, we have vblank->enabled true. However, during gpu-reset, in
amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state checked from
amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
again. After gpu-reset, if there is a cursor plane commit, the driver
will try to enable vblank irq by calling drm_vblank_enable(), but the
vblank->enabled is still true, so it fails to turn on vblank irq and
causes flip_done can't be completed in vblank irq handler and desktop
become freezed.

[How]
Combining the 2 vblank control APIs by letting drm's API finally calls
amdgpu_irq's API, so the irq's refcount and state of both APIs can be
synchronized. Also add a check to prevent refcount from being less then
0 in amdgpu_irq_put().

Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14 ++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index a6aef488a822..1b66003657e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
 	if (!src->enabled_types || !src->funcs->set)
 		return -EINVAL;
 
+	if (!amdgpu_irq_enabled(adev, src, type))
+		return 0;
+
 	if (atomic_dec_and_test(&src->enabled_types[type]))
 		return amdgpu_irq_update(adev, src, type);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index dc4f37240beb..e04f846b0b19 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -146,7 +146,7 @@ static void vblank_control_worker(struct work_struct *work)
 
 static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 {
-	enum dc_irq_source irq_source;
+	int irq_type;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
@@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (rc)
 		return rc;
 
-	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
+	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
+
+	if (enable)
+		rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
+
+	else
+		rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
 
-	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
-		return -EBUSY;
+	if (rc)
+		return rc;
 
 skip:
 	if (amdgpu_in_reset(adev))
-- 
2.34.1

