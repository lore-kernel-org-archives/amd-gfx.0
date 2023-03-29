Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A4DC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33D810EB47;
	Wed, 29 Mar 2023 15:26:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BDE10EB25
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfWpBo7XcQWQ7ZsC/jf0ALEP8EMVGHK/J60X6khqOPg7+5nrdo+sJ2kSgsVzWXCxjhVE8w4cHbGoBsN/GmQe77scVHCqRr+z0qFYTc0dydUwTnoZz90i96KqRrOfhMnGZdzrr94BExfoMGfiIOGNnxBdbsM72ZPWIqTVHuq1pJTdjf1y2azsMZrDE+sn5hqD+35ujhYrYj5Jy3gXad1D/7tOCam01HnQflzBIPi3lk5pCUQf3Qyvl8LCsO5I9mwMRuToTRKwOHL0Ds9oeprBiMITRScfHNGmdZNH/mGK+Rp8mKcU7zLa0R0Q1DGPe7k1GSpIHmDGAZuF4NLH7sFDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4Odm3pAFqe67RR2ilAFVFYhO6AEg7ZvS7j7o2/6VCQ=;
 b=k8pA70BDVzDdLT6iRfP8zlUCSG1/B+Dgp0tELRNHag2ln8ZE9lgTNAjqEgjC7VGhZo2VbC+J1kmo+4fRarEAgjK55kwmHLtbcxpbMd+gy8vzthRTVa8qKG389oPxRRY805qLN0TQyXPamD4pKi/yjtfJ4cw9mIFrAk7H7qMCgQ3yprnCBrLpVy9L4+76+usXFndbtTOpby4jNCWciTvJtdrr3B71kymI3hq3ixOsXMVv+hA2hKAUWc1657PuutLlnCSa7MTlQRkjcgOMzqYW2KUQUA6LNutLAIXxjrP1uA5iuzSkV20DXDAdRU3qdcUBMqA7WoCGyjwttMDEQA/Ldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4Odm3pAFqe67RR2ilAFVFYhO6AEg7ZvS7j7o2/6VCQ=;
 b=nh9vxeTGtLq9Sw/hTv+abwtfqCjrrRZZjUpssOKLdnk/mzhe7HgnrOpt9hwcWwH3PSEtOEFpaHWjZLOnYGxJO71fcPwiiRQRfmTv+/eEXfKXyuN7f7QuAA5jOps2kuWB37Rrp9tZghARs4HTPomUUKyMWuVidP9aeHiabox7qHo=
Received: from BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Wed, 29 Mar
 2023 15:25:38 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::aa) by BL0PR02CA0132.outlook.office365.com
 (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amdgpu: don't require a job for cond_exec and shadow
Date: Wed, 29 Mar 2023 11:25:14 -0400
Message-ID: <20230329152521.1980681-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: b27cdd90-a355-4103-cb70-08db3069d948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inSOtfxMVbIw4y5ttS04PxHUrX87aItm1+W/ER3J+7VJHhaQxRxhjV8ix35fK6d5BN26dbV0WfnMfELBJqe//rmKOwfwk7Bc25ZTZS3doNXBiNs0ueJgHVG4p8GETmyWXv+1EQaF4znTQw+aS74u5B3rZOgYsoKJJul+Zd8rV3K6a+PtX82xgZjNhlw9rkDkRnRczaghvqOuztYk1nEOh8h/M1sd0f3IC4RFGAhH4xLLLqiARVEkdT4CtUIyM5myhaEoUmJhb8CainL6Sn4xcpWzFQ5li3Fit6+n3rIM6Wm3w69Es7VDx1d8wDNxr5/c4i/dIfoCZhq54I9I7bDuIceIB3KL/HfoUysEyJyh1fLl0x5hFylIHZOTAWoPkSqv+d3nP1jh74ekxOwLfsBDSdIDJaRvgJtbvWAKcD2UnrufRBS4qE3Y8ecGQBKnfRSaznE0yCYfmevp8oTcOF8YbtmxXtlJsvfD2AYKm0cKQYSV7VioFVf1KTmSgnGgshhnx5sFgLplrua0pLO9SwCWDmlhlBb8KEATosVQjQM41b8XQS+wjs4d56mTtSRda7Talmhf5M+w6YsM4TFBpWtmMypy+Mxv2MyS5uTDFOVI4Axu5ILBHyHgMxPvUSQb7kNnRoLhWkBiVMuo+ufMHTdxjuicZ+Tp2B2C0k71zSafpVOlkNTDz5MPZjwH+BA/LU2xF0E5q9ydf/KlPUkMBDiJq1jC4wWQ2pwO1JmsZAlZ+u8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(316002)(36860700001)(54906003)(41300700001)(82740400003)(81166007)(356005)(8676002)(6916009)(4326008)(70206006)(70586007)(16526019)(186003)(1076003)(26005)(426003)(336012)(47076005)(83380400001)(2616005)(7696005)(478600001)(6666004)(8936002)(86362001)(82310400005)(36756003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:37.7713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27cdd90-a355-4103-cb70-08db3069d948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to reset the shadow state every time we submit an
IB and there needs to be a COND_EXEC packet after the
SET_Q_PREEMPTION_MODE packet for it to work properly, so
we should emit both of these packets regardless of whether
there is a job present or not.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 9bee630eb0c9..7f4c198ac483 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -223,11 +223,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 
 	amdgpu_ring_ib_begin(ring);
 
-	if (job && ring->funcs->emit_gfx_shadow)
+	if (ring->funcs->emit_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
 					    init_shadow, vmid);
 
-	if (job && ring->funcs->init_cond_exec)
+	if (ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
 	amdgpu_device_flush_hdp(adev, ring);
-- 
2.39.2

