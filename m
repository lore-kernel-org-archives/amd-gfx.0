Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281ABC2B9F4
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 02:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D12613C1
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 02:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D12613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672E36E092;
	Fri, 18 Jun 2021 02:23:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4791C6E092
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 02:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVwuzmRtaCMFSfhmNRA2J7c0Mfc8IRs81A9ZTReuLm+qwZPGZYjVpglqLvaSL+WfWjyDQtQd3LKvM+yE6UGOYz1SrTesGfypz1vpb2T3bjkf8Dj4JCl48YJ4ECPKd1qAXFgUHkLjc+MkyVoJtDAdSvZ3ngXdQLGq4UlgX1AYHm6RdMWaDQebAOfWjjWJae/SE97NhPjx1lowZDfJM7V3yOe1FOJcUyY3yj0TJ9JREsvoDdJGB0PxLzDAsnW3VbeYmW3YMeAwBNRP2fJWZ6/y06vPpboD4bEkkjpOqYyrqMfhihacDq412eHipFbIIaxn78wZtDlAOys9I5YuJpuX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Scv8WwiuimQ+dm1/tMG+WGLGuXqB+SjRMG/0lQN1rZ8=;
 b=k/L08niMdDZXyQ+yHoKqhXbGihHx3Eqh42QYpY+PEWvY58kUQsiTT+/rVeLOQyjCVnBwYtRy7fzRFcRclv3ZDm8ZnqS7NhwxQGL/ma8uspBad0R8CnJpxyXPQE+DO8gPjgNg78XJ0V240Z4PinASRrNHvdiDKu1Kb8JE7CsLqxPGXa0HedziGdavY0RSwQP4Rt2LBLT99wtu5N6vSqAuEHfOJNlG9kc+wFfbvTSJV+gX72tBq24rBKyUe/EpH5mRixbK6LZCD69l61InCgeTJT7mTzeOB6ZiEzAYhbd1PodqOka27b5P94N020Nr5hBFxCaRLgQJFPxYnR+zQsYTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Scv8WwiuimQ+dm1/tMG+WGLGuXqB+SjRMG/0lQN1rZ8=;
 b=35oxQHInA7wsIrfd9t5LzH0tDkLoXyKSFcukaOcKxGU5kGHy1Z//o1g7pNEGe3xCJ9me+t41x28l15njceSAcA7f77ckmIduEiNTZ4wbn1tNfUwAK+MvpuRTU0rT1eGdc60t0wYs/KJ0JmrsD4MD4bj+JqkUv+cMulqCctMcn/E=
Received: from BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25)
 by DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 02:23:41 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::ad) by BN8PR12CA0012.outlook.office365.com
 (2603:10b6:408:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Fri, 18 Jun 2021 02:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 02:23:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 21:23:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 21:23:40 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 17 Jun 2021 21:23:39 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Revert enlarging CP_MEC_DOORBELL_RANGE patches.
Date: Fri, 18 Jun 2021 10:23:37 +0800
Message-ID: <20210618022337.2661813-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd63869-8970-4f82-ec10-08d9320016c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB5008:
X-Microsoft-Antispam-PRVS: <DM6PR12MB50089CC99686A605B0CFC634C10D9@DM6PR12MB5008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbTZf1xbiDveYgY840aNy9RXOGMARtF2nTJdNYgjLbKAuQk7U8yK9nHm0ZRedfP07XL0D1h0dfXHJlkhCxufwuBkRwMOL+DgMrVCYMD5T2COoxMXvleM32lomNXPph1H+TKFO09AIVUa+EVpaCacujWghKJ/p4THpEQxkSRbBasF2JVIjFQsDeRa0/5f7j/i5Apo99RNkn0BQd6VrJoUfQh/Mau8JBIOmxQcgDv3ntiu0M+AJTTwT3+ktnxrjC5xFCThXt7NRuqlmcBK/7jfbSdF0m0fFqHeNRxuwBEhHlm40Mmj9Wqfu1OfqEej3nas9CB9pG0JUbrAuAHkskNXOtZsk+YYjyBtLxHBQnBn5o3RpUwkwXcIdDrA9AqIGvq2J6SgwyEQcX6z9J0OqC7bY01ODz6/AlwOnHG3UJxVIIsgvYoKwUc9CfO0mTbiwbDW37XQtN3S1xZkTKQiceWam+pBgtNYM0kX35xFeG23h7Hv0b9GB4wWkscuOmblRgLpT+PIQ7l0A3VrEm3e43buqd+ofzZ+8tbDj12xPkCELL+mBXnk0ql+wnYDSF1kUvk7i4vWDfEHQWlke+77lHo/MbpppgUMuNhOn2RauGRucOMYnTAG03wEWOiCxRw9jksRoRjD3afAb5dMg4Hv9FNzhmLqE211QB/TPlJGtwcLetBgAI+g7uEiJeye2XKqTDvVZ5Uf87IKd+pjyK4I+wF6hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(2616005)(336012)(356005)(70206006)(81166007)(70586007)(83380400001)(8936002)(1076003)(82310400003)(316002)(8676002)(186003)(426003)(82740400003)(36860700001)(2906002)(478600001)(86362001)(26005)(7696005)(47076005)(5660300002)(4326008)(6916009)(36756003)(161623001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 02:23:41.2861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd63869-8970-4f82-ec10-08d9320016c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Revert "drm/amdgpu/gfx9: fix the doorbell missing when in CGPG issue."
Revert "drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to cover full doorbell."

This revert commits:
a3b4cfb09aa9e73cc48caff77efc161a396aeddb.
feae47198886d0df7b43876916a0e4366f159b45

Reason for revert: side effect of enlarging CP_MEC_DOORBELL_RANGE may
cause some APUs fail to enter gfxoff in certain user cases.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7bfe6f9d3a52..15ae9e33b925 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6974,12 +6974,8 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 			(adev->doorbell_index.kiq * 2) << 2);
-		/* If GC has entered CGPG, ringing doorbell > first page doesn't
-		 * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
-		 * this issue.
-		 */
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
-			(adev->doorbell.size - 4));
+			(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
 	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 922420a2c102..044076ec1d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3675,12 +3675,8 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 					(adev->doorbell_index.kiq * 2) << 2);
-		/* If GC has entered CGPG, ringing doorbell > first page doesn't
-		 * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
-		 * this issue.
-		 */
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
-					(adev->doorbell.size - 4));
+					(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
 	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
