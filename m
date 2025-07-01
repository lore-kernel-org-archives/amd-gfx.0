Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6939CC83F03
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1C410E621;
	Tue,  1 Jul 2025 18:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YTczeTkm";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F6510E601
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAqWFRx5oHrzDFO87DNEEg7rCaRoe6f37ZgMklZbkvlrY96O/lSN/Z6BGHJ3+hZ9xu5+ryamkrw6p12zsyq4szxZjIHJ3x89o8M2z9eDbP5rxTKxhtZbm9WHLvOmAyOc+C8NlOTXr3POWcvKbbGx9hsdyVT4/3U4Ys1PMdi4/Wv2Cal7dzOqQpRVccec6cOekLwj8OzvIDvr0D6Hr8vVab+FE57a+78uJNp47ViMNJa5czjBYCUuux3WPQXqx4nL044fYfMeeV7Bk3iAEn5hDS3CLPrvSUQH2TkgvM2XCO0fmoiugZg90ZVlVBGDtk1Jed7vna55DFcohbjPFsXzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3EvccLbvPS1ED9jhnJtEaPieN2D0f9AeRsD7gZl2l0=;
 b=tZMuZ4VGG/Lhzu/jLzdPedlS7r7Gc//OGD8xIyWGgrkSYeDxzSYXhwxXzWVvumEB2a8S96s+mKTOC9QiHJmhmJL+Fi9HDLdNFmi50I+WUnQ4MPmc9CpLwwr3/Ct5tmHIi7RtqqZjTtO4seXHluwsoVMobeiMD5jiGqfxxIeo2zhAs+H6T6eiF59D1aW5tehIPr+auv9Ch5GqrKzwSjzUiCDmyFOI02o0Ijj3to1oZ4yIQ39i03lk5R1Cx7ntsR6G8a8m5F2kWdlg4gEAjlgwEUF0irmeQyoOZwPeU9G81AvRNVkP7SE6dLU5zGLle1PgC98S4wsLaksjKIQYOtzAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3EvccLbvPS1ED9jhnJtEaPieN2D0f9AeRsD7gZl2l0=;
 b=YTczeTkmJfVKy4vyAVbiPgDrwzGVuIiWzM7+a0QY/JmFqrClWAqLkfLbwfI6tCLtFA/9G/pfshFBhztj/zwzVX0j/9nIGM0egutgZsnrJP1hO5M0Ydnf3hN5Zn/0DQrajnrvjaURvfxCbhJHmq9K6KDpbHYyBnJIALu5LxIBcXA=
Received: from SJ0PR03CA0128.namprd03.prod.outlook.com (2603:10b6:a03:33c::13)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 1 Jul
 2025 18:45:10 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::fa) by SJ0PR03CA0128.outlook.office365.com
 (2603:10b6:a03:33c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/28] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Tue, 1 Jul 2025 14:44:27 -0400
Message-ID: <20250701184451.11868-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 249e825c-3a21-4228-7dbb-08ddb8cf6811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7sBk3jxDQus/6ps/VOee5bD7gAQci9zvej3poQvcrAHdhjI+DnwMq9CM7NT8?=
 =?us-ascii?Q?2Vd+lgV1OT4Kub1gDYG1Eq6qcCyBNAsxyxxDpei3NnXkJZfvwrlXD6r7F9KL?=
 =?us-ascii?Q?5k5KYPVjie8iLRhe0Gw1tsOlL5RgpRzJEToDeIT4At879L9apT0BgrzQ6Vco?=
 =?us-ascii?Q?r+KLrkxt5IsLy+MnhDYuOz10C8Twrdi1QxlVgtzKn+Ahiyj3rtCr0FoF/okP?=
 =?us-ascii?Q?+7DOTmMAbGOwH/+39wOtr6WJmUaXTHGGPdbm7AKEf8IKqdHzMYHLgXpwCy2u?=
 =?us-ascii?Q?zt+amsZtDw7F0dqJZALMdkjdC5zG9d+rznh5tkedQiw8WYvcWyBNc26DCWqI?=
 =?us-ascii?Q?qSjmyRRfd7wiz7SMavxwB/4fAm7f/lBZcXQtmwwjT9xDRNbbHezf15Rdnqf8?=
 =?us-ascii?Q?W69JvOADaJ4R0QX+vUmkBGNK8rYRHB6GBw2C2ux+6/Rkrl8wTA5MreJDY8ah?=
 =?us-ascii?Q?bjxjwKvCMma0xBFO9WhKlPr838G2DmFV296y5U0K8iSmZb6hOpSX9sEVw0Iz?=
 =?us-ascii?Q?AulsOFeAEO8UmjA1wsTVnu9gOedib7YwdgQhuLa0FQU/y19QAu82pbdWUYbl?=
 =?us-ascii?Q?d9esoS0QQGSGhp4CGBc6CJMDwNVWoZFNUhGcwDLjuUW2MjWbF+yCHr+lDr5V?=
 =?us-ascii?Q?Ppcuokk5uURNXxPCN1D4/u+bmq8l91XsCIiQO2jWuf3l+V3L1Obn5xtHDddK?=
 =?us-ascii?Q?Sv1eXQHv/c+8F85DRgcYaQGMCl8UF3MfpNCzJnlnuc/lyCYV4DKhudM83DAW?=
 =?us-ascii?Q?I5vkE9k8rlfEHxeGnUI36qRrzvL5adeKrJtVM+8Id5hpxq5NqSUNeCEyvo/r?=
 =?us-ascii?Q?DDerQ1F5H9aQWvBVfEHDyvCtkDtcVe5plKCCFlyaYSKiaTMeURFjjapuNstR?=
 =?us-ascii?Q?llecQMpbsXB56vgfAily8sUSPxDkY1v5qF1ANi79P8p67KhzwaEZt6J6jrGg?=
 =?us-ascii?Q?Emoq/8uVIaFCKLOJ15hKEIfl94jUiNcQPSAB69TkBrZ++sW4UqeApb4QMJG+?=
 =?us-ascii?Q?Xv2j1fm9FB1IlqNpqZU14LSOSvo5ZA0jQTf6o+fJdyPjIGuBxeH2bamFc90c?=
 =?us-ascii?Q?G0QsA+aDGKL4D46ao3kYLC4TBjiao5e2ogx0OHTDNdLFg2ckwJR7ltVL+L51?=
 =?us-ascii?Q?kquxJj063IsT2BvYNrkL9Vp2KhyECdRfkXDp+pwoXrjnirV0jHRQr/dkBSBf?=
 =?us-ascii?Q?t9RI3K4Z0WtclyOUp9wIQWseQYA1AiAbxts6h64cacGhlIbHMLQMAn0Tqi1x?=
 =?us-ascii?Q?lmDBj1Ttfyq5JfTdmC6iFrPUEOnuL7hRy7PER9c1GUNSiyFqt5+N+jk5NUC/?=
 =?us-ascii?Q?dLZnbGzn9V0Adw40H3HyZhaxWkptAwXwhdWvM7x/R4p3yseLQVTID0HVmS2H?=
 =?us-ascii?Q?/KpGaCiKwS110QHaaJs4fi+S9c6qaJjObw7HnBBT2Zz0iPUQ/Ny1ZKVMWjt7?=
 =?us-ascii?Q?Lu7dkT5VWY0lrhrNFuIDRpAytA4eA6lp3k/IxV2i1JwslJITLvIoo63iyeON?=
 =?us-ascii?Q?7mCgIJCTYLMuqbtrYxbSidTMfIYSVIRycUsT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:09.8842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249e825c-3a21-4228-7dbb-08ddb8cf6811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 76ba664efecb3..30f6b04cf82e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7187,7 +7187,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -7238,19 +7238,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.50.0

