Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7460CDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 10:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CFA10E5AA;
	Fri, 20 Oct 2023 10:00:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABD810E5A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 10:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBlikAsXKIPIvmWngXlLX2CKLux5ymqzF8/vASfDmex9rgqCPnXw+uk2P8+jBxm5MTsD/72izO8QWxw3zH0cocgpevN36WAfzVlmawp4qIQwffB6chzMMZ4Y4mATzY99VC9uZpombes8a9UKOkE6js41fgjQ+RxQ9Z6xFQM/qp6ARhIT2RgHJM1dzPJV41yFV7FXiZnPsNA7dcBoNneTbSmlPFxqmO67osWv7ik3wyy5AjjdneVcynLZpJh0b6rmcLFK/MsChfWApwvfjCw6dg884hwOAD2PupsGWq+71WJ80gg+tdGHuXfd8WvnROquexRLjz/2wFvI94uGb1q1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXRz+j9XbkRNLyb1WoZ69cDFmzHhWlLyV6oz8rfu8So=;
 b=ck31zDVhpOJM3JFLgTZn85Gvpkp4uRi5KRaMmOt37y64z7oV3BKqWzfLq8jbodInnQqNkHpWousmdJyNoS3269eokPiRWpsShcOxiwucbJCWfQor0jvrEt/TqrJV9PTy2pUMtG+5g9jSau65Ulrr27aUfl0mwVx3lTR8V1VrIIw4F0OPUZ6GZcgtdljnDIuV0y88d2onO4RW9Qv1TmKz4ke3CrlRGCPZUDR5CcAK47aPJfbjLp4QUQikqBF798wHGhJJ/wdD0xzJHRod6XRm+t174AW+bicuI4PE9+vlgvlvLL9UeORSgI3aAtyDN7K6NQyfgrKphywTt1MKKoe28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXRz+j9XbkRNLyb1WoZ69cDFmzHhWlLyV6oz8rfu8So=;
 b=aWzbkH5/Z4ehMM21rq+RH3bPXzthr2TZOnSz1H4l0wPNdXWkFtYy0Bz0/ekQFB5stA6FoJiRr4BHpQn7zOGRhubLnnNN63BGM4PYxzoBw9p04q1SV+68D0NsWPfX5QnMTfzgravko+seDOU1v2p95gs7p9+ycae+OgQcNbKE7TM=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 10:00:02 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9d) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Fri, 20 Oct 2023 10:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Fri, 20 Oct 2023 10:00:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 05:00:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 04:59:35 -0500
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 04:59:34 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add timeout for sync wait
Date: Fri, 20 Oct 2023 17:59:11 +0800
Message-ID: <20231020095911.591988-2-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231020095911.591988-1-Emily.Deng@amd.com>
References: <20231020095911.591988-1-Emily.Deng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BL1PR12MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 08083565-acc4-4117-f0a5-08dbd1535376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ReIRgZ4khgDvDV355+f8KrpnqfHRJ9dFbZKZqWau3kl8KqubGD9caf5GdTy6Y+Qy3UWCIBM0XLxg/M0yIydxTeJQro6CA1IfWJCz5Agz43sQEmjNpHjtW1pek3uIKjksLE+z4beGvhvVIgd/caARfA0DnNe05dOBvOzwXXaRTP1+OaFpPkN+RbkTPEEFQBRv219g85fiohGtRFvauBTYx+EEj/1JhauxPcGfBdL5jrWV8Ske8tgt5cl1Xq1YG8d5AfSwx5hiBxNoCMHOaRirFB7s2LP8t7IQ8ikKJHYYbyTJUMS7tjRvfs+x/egSIR5EUTAmblIGrTxSLpZUjIbvXKKVlB91sziOxU+HJAgC5/xuBGc52gMnPv/rLNmMA0E7E5Rth0Ai0dTkdAbfLgFfEWKsFOdQBHpd59HlZjhV7fFXbk6EFjcK18ytDDbjYPwhIy+kdGckJDrRmQxH35Efl3JuCdYkoYTzZCD1kF/9KGOglKJtJMY2tZDBp4FOp4/whe3jXgW1Lo2hWYzVWcV7CWE8oQ8eWalDfMnHagC1Pa34VEtE/UVpzvvE3thBC8sqk6LaUnziRGg8prg2NiEoSUGY4N3wKfded1xTlCVYoZ3v+iFQ1d8wcdhNqUNhqq4MYXBe1FCSHxqCQvn2SSHkjQgc3Ir1cw8vBitiWBLWyPDTogLclu+WAsLLbg1I2sh6P+Ok21guhboEHta3IM7vWrOdR/3eV3TThX2ZzeOd22WzRstDWSoG/Crf9u6jHh8lxl/8+6HO6HzynllnuaWRew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(46966006)(40470700004)(36840700001)(6916009)(40460700003)(2906002)(36756003)(1076003)(70586007)(6666004)(7696005)(2616005)(70206006)(316002)(478600001)(86362001)(336012)(47076005)(83380400001)(426003)(36860700001)(26005)(82740400003)(356005)(81166007)(40480700001)(41300700001)(8936002)(5660300002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 10:00:01.4445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08083565-acc4-4117-f0a5-08dbd1535376
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Issue: Dead heappen during gpu recover, the call sequence as below:

amdgpu_device_gpu_recover->amdgpu_amdkfd_pre_reset->flush_delayed_work->
amdgpu_amdkfd_gpuvm_restore_process_bos->amdgpu_sync_wait

It is because the amdgpu_sync_wait is waiting for the bad job's fence, and
never return, so the recover couldn't continue.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index dcd8c066bc1f..9d4f122a7bf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -406,8 +406,15 @@ int amdgpu_sync_wait(struct amdgpu_sync *sync, bool intr)
 	int i, r;
 
 	hash_for_each_safe(sync->fences, i, tmp, e, node) {
-		r = dma_fence_wait(e->fence, intr);
-		if (r)
+		struct drm_sched_fence *s_fence = to_drm_sched_fence(e->fence);
+		long timeout = msecs_to_jiffies(10000);
+
+		if (s_fence)
+			timeout = s_fence->sched->timeout;
+		r = dma_fence_wait_timeout(e->fence, intr, timeout);
+		if (r == 0)
+			r = -ETIMEDOUT;
+		if (r < 0)
 			return r;
 
 		amdgpu_sync_entry_free(e);
-- 
2.36.1

