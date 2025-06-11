Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E95C61CE7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 10:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FEF210E328;
	Wed, 11 Jun 2025 10:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gqbwN9mE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25FA10E601
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 10:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCnymKpl75owLCKk7XsVUwANfug6kiZgRKa7M0zBCjZH+2ERoxCUQOCcPOlSpzO9b99RuJImIqUxAsZ2vaoTepqWQ+aonSDlKLMzjzdEJfgrds9v0ucj4OtZLejT116jVKvqdDuJKKNNRCSLaihiJBVl9dX0Of1UTvayov0f0nk/YC6L6Jzrzywt8vFwfa3PRmNZ1IrcjC2u6xE0iilimgpu2l09Guw50hHnyzC4ZuEtfHGBPNq0hej8sZ7UEXi+lYJWXFONrTircBH0ztCS9l7NSaqtqvxYtmPPKEIQ4AXhE7cvyy+voehb1Gu3voJ1RjXRfvMk3cWm/XfIlPZPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge9US5is25TWWmlwZvItgwDBTVRtpIBC4i/QAETMREo=;
 b=BcZUHTK4DGy3tpLtLyQsVjVnpdFT0f4CKYccS2jN5M1trbKy5JLNHdsvN79YPGT0q6JFp3lyRBE2zWvy02ys4CRjiCeiUNILGoJHvE+0PB+6dV6RgKCLS8bBAcylz5LcPhTYzZihOSZeP6Ot6as0Lvf85Ye49Y6wJ7GrWwOi5SvmCsBWbvuJgOmRiLGh2q88Um/KGwH2aSgc1LeeSazKhF0PZhRzPEoi/YBfmekg5uuZa14oWMGoXHxJIK8uECy1gQDuyj0nznKxPimBuJIKP+k0BD5juQ+isbiT05enfyOTzV5Wgx+1dwRIFHnmIevvOJwOCVWXw+ejnlproIokfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge9US5is25TWWmlwZvItgwDBTVRtpIBC4i/QAETMREo=;
 b=gqbwN9mE8oErmfXpexgfIW7iYiokpI1s1vPvVYaGB7Ai3EwFH0sS+0vpmkhJkx9Cz/TdFZKoYoI6b/RN2mPpd4poD0gWf7aE0q2RfOWS1LOJlOc6wfojbd+F4+N6iDhNkUjZ9EfiZYlRY6dk5/SL22U4fAQfcR7Kjv9bHGdpwxA=
Received: from SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::27)
 by DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 10:05:06 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::54) by SN7P222CA0018.outlook.office365.com
 (2603:10b6:806:124::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 11 Jun 2025 10:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 10:05:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 05:05:05 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 05:04:58 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [v4 2/3] drm/amdgpu: Use logical instance ID for SDMA v4_4_2 queue
 operations
Date: Wed, 11 Jun 2025 18:04:44 +0800
Message-ID: <20250611100445.3379455-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611100445.3379455-1-jesse.zhang@amd.com>
References: <20250611100445.3379455-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: b05a1090-e3ac-47bf-659c-08dda8cf70e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oK7qGgTyyCR/OKz0RtiXwwtRD8NfjJMb9mUJibX5zPvlxA6rEK0HOpJsbw8D?=
 =?us-ascii?Q?4uZE9fsiXEG+jRyFm0jQP1mXBNx9tXRXqvvO2evOgW30p4ZWIDjHnC7g0Vou?=
 =?us-ascii?Q?769okvl/o7XxF7LdKZ50/Pec16h5c9Wt8gMQ2hag/IijpBFPyYL0y+BtyFsH?=
 =?us-ascii?Q?wnP0xDzcSJVR16x+5ziUHx7GV4mRc/UqDKt2PnUVJa5M5h0Fk/ze/VHyjS7+?=
 =?us-ascii?Q?Vb3NspN8Bl6wQQ7j1miJfYStruZzdx0OO331/q8ec6Tb+1+Gd8q9WkpSpgAJ?=
 =?us-ascii?Q?uC6J+BGGHkNsTxdKdVYtUyUUvOyX1DpdcDscruLQgPQLEQgFblSItAKP32y2?=
 =?us-ascii?Q?p4rFfogRZ4IkE0eWL3edZhxOswLn1Sos75/JmAGaO4/9rKMNfO/jOp6SqFRR?=
 =?us-ascii?Q?9+IdHFsDtEfw0B+DZx4xdu1guiN2ShXaj8htzR/q90ZwXmIllril4MTcKXgD?=
 =?us-ascii?Q?hKZZTED9QhuzBC7SIL9MRYQwVBy/fOc2iSiPyTx7/U6jrxH7V43YBgSYqmJL?=
 =?us-ascii?Q?yT+0pkh2oQaD0l1eznL7jxp1EfpZRky3rhPF6wcKnudi5imRQzR2Xjuh5pH8?=
 =?us-ascii?Q?OEy8RMyUcyM4LJF6aiR1l5IeBs/0t12jGS7gvWzhBnw8y22AXl/Rql95hIMp?=
 =?us-ascii?Q?XRd2spF1qIdtUqPcdI2hL5jyCB+/5VUbs/WYw/B0kylcxTy3m6u2H1KuNWin?=
 =?us-ascii?Q?pr1iDyBhEXadixjXxp+LXtYk5lFIonxUH1mMK3HZ19KWR764eD8nv6nKzUQQ?=
 =?us-ascii?Q?SCRQymW3R8J52cxeQDleZE8irJj0xbkwI8CTJRdeCD5J13Oz+rqDzBMQfL1G?=
 =?us-ascii?Q?qPFx3i5Xn5e+N5CzSDQLYTu2X8KJOBOIdasI+lqPKHAZRPAItjKqhnBfnNC1?=
 =?us-ascii?Q?fxXGOMVvFkI7QMtlJGHJSha5KgQMvGTBJcqiuGVXX4hptyxmQcQ6qIKiY5oK?=
 =?us-ascii?Q?KyBIfIOoEtlCUHUFKHpCrUhn+Sw9mY4hKVvnko765u1pQkoUCtx2z/Nj77z9?=
 =?us-ascii?Q?lXbiFdDKge2m28X3dZ2jlHd81/6Vnq/t0dyCVoCoIAl8vBy6xkDXdvpzdMQ4?=
 =?us-ascii?Q?9klVBNL8SvORdIp9p2Jj1nlWWitHBrzswOGnqm+Ev343M+SIzYx/XNZX6xyh?=
 =?us-ascii?Q?Ac5IbDoVYZYXGq3gGzOAG+/IgWXdRIT4IzdVcE8QDU+Ss4u7kHBXNqbj0H+o?=
 =?us-ascii?Q?GYTjKjEnHhhkajXbgqCf+nd8QWIwCvz7jESZooUoPeAmqC5yqQ98XT7ENyL6?=
 =?us-ascii?Q?qiLfsCFKLMBMa8p9YVvJEn8yXkWEcHYR87dawuDUv8zcqPsVy1YVp7RXdeua?=
 =?us-ascii?Q?pOkFK0RQK723GHSq/bu/AmtjUjVKd9xsQCIjJzIZPbYuqr3TsoEQ3OLOxeWR?=
 =?us-ascii?Q?ETTj1uWPDw6IP18LMpIz1WS0X2O48qMG3k9xk1jlN6Z9Ujj0l2Pot1flDiG0?=
 =?us-ascii?Q?UVWJ9/TlnaJj0EKTJf1markh42EjoFzGUbSasmv98oT7NMi74+CI7EaX9AFi?=
 =?us-ascii?Q?Po052KqxBZ5dJyiU5SQVZqRnijRs7+jPZNIL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:05:06.1173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05a1090-e3ac-47bf-659c-08dda8cf70e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751
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

Simplify SDMA v4_4_2 queue reset and stop operations by:
1. Removing GET_INST(SDMA0) conversion for ring->me
2. Using the logical instance ID (ring->me) directly
3. Maintaining consistent behavior with other SDMA queue operations

This change aligns with the existing queue handling logic where
ring->me already represents the correct instance identifier.

Signed-off-by:  Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c169112a5e7..3de125062ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1670,7 +1670,7 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 id = GET_INST(SDMA0, ring->me);
+	u32 id = ring->me;
 	int r;
 
 	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
@@ -1686,7 +1686,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 instance_id = GET_INST(SDMA0, ring->me);
+	u32 instance_id = ring->me;
 	u32 inst_mask;
 	uint64_t rptr;
 
-- 
2.34.1

