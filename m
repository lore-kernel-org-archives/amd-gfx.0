Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE41D37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 521DF10E844;
	Thu, 17 Oct 2024 13:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hW1f6bsa";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9773310E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jobkIUSxDdJUvOK9SUz/gD7h50O/Lyx/9hX6AbM9ilE7Ms/on0Dxecj4kBlwFqIi9X1FYGz5CRL9v92DaNXlwNOF7sihXzEnQGn3iVAO0hiRwKhP2obzFaqfeA7bwX4ZVhGBSO7FUZR2Csf7NAlrPbJw3OWEeu606fYPt7Gsk6CIqxsMcLlJ5NyZN30Ooyknv3948ZBD6pIZqGEVuYNh0JFvAQNMC/KgJ2xHscHqE4ajeT1Z5YiQJUtI4VqxUBfw2UARrD6IZwzf+GcRXA0Pp9kcNdP2KX4J4qLoSYwdKNVc8XIJlxBcruQ5GnNnpgamptcXqrz0AlCigCo4WoFfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeDFQ/TiSLQEXYdxgdKMkkPxFB+w3y2+3AR+EpG+zw4=;
 b=X/1GqjIdFza0P+tSAHBzL40P7BVEUZe0Rxzp29vt8Drmh+CJ3YcUzdWsdmXYjpdyO9XmL8xkwOuye/uLnIThG764w5atzZhEJwtswn3vxrJ5gjojETr8tGUAL55dnSPdttlqCSUYTqbV3diAAo/vbWj3AEjF4b6+8fL90qZq74Q6qagHV58LAp7TyoaEdpEdZmyb/MgXdaW2CRC2rMeEitwPcYUaE5Is8Ps95GAV6lpYSBRQbMRT6Ch8dKaeIcz8xb4oamHex2MY34ouzLzzJh8WhUXDnT/noH8RDIt4aC/l7tp2qnVR1U+M88zCBLjPUNfOtGgEEHSSnPJjCDfFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeDFQ/TiSLQEXYdxgdKMkkPxFB+w3y2+3AR+EpG+zw4=;
 b=hW1f6bsabj6FbDuEzEfQ6mQ+vXdCpPOrim/8jhm2yIfPulUqzYdY1PKWNwq0exqaI0VdwqheWy4sU48mtpEzoxgkX6Zrkurt5qVavybX293ZH0zHgiAV0iGlfoKr9UPmllAE16N4lWYDBcsU6eji8NNJbfZgkH04Z/UQUe6owqM=
Received: from BN9PR03CA0451.namprd03.prod.outlook.com (2603:10b6:408:139::6)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 13:21:37 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::8e) by BN9PR03CA0451.outlook.office365.com
 (2603:10b6:408:139::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:34 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 30/32] drm/amdgpu: wait_for_idle for each vcn instance
Date: Thu, 17 Oct 2024 09:20:51 -0400
Message-ID: <20241017132053.53214-31-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee0d025-caaf-49e5-c0da-08dceeaea132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2jXMULu45e6UqOopt4Njm/bcufQpx+ygLzsOTQiCgKAY1/MIAgdz/k5yq3ZP?=
 =?us-ascii?Q?iEVVDeU5+bXEjEq25qjOG0zy00479ELGQvr+ajX5fVGBPNERkQ/5dEub6yB8?=
 =?us-ascii?Q?4gUxwwLW48PG2kryo+ZKwg4/4JbLPgn82bXSZQ7LfbeEVdDXJOqWou1eo8k9?=
 =?us-ascii?Q?OzYgZK5EaaikbWzVaxSlXRAurV0hmQ3LDmYPZsmA3KeY2N4+rrnbsQtXd/zW?=
 =?us-ascii?Q?vUZA11p8DEEZV5g8pqB2iqoMMXY0bjWhK1P/w7D42KGBqR+vHmOfP/+aFII4?=
 =?us-ascii?Q?G90JeILge5WW8kDSgPkHtPL08xGEibCqtNwvbiDn2HNsPKCYsdbTemQNh1Eg?=
 =?us-ascii?Q?7VCW69KXnbd9DW4eB8KkAH/2AdpWbABLJBY38SBw8czmjfTzLogvvnAxQ2Hq?=
 =?us-ascii?Q?1CH8bxzoOEh9QPtUtwG2ajSyfW+je72HSlLExvLfd2KWUDrrbWbJA6ObwruG?=
 =?us-ascii?Q?4dFEGFcsleBHNmhnph/LuxkTwYRGIGoNss0aq5CGT7u4Gmap4Cd/EbnYe9IE?=
 =?us-ascii?Q?RxCzIBQMB5QjDNsFOl3fuMdGzrbpn4py+D3jMCPkWhhkdnUhNFJ3G6mNNyeJ?=
 =?us-ascii?Q?hzxNu2skYN2mFbn0XBB+R5+SoYaWOGamxN5mFlCTfj2fDjnxbqFLy0KwSluF?=
 =?us-ascii?Q?J2ViUMwSQ+pPu5NLNiTt+HwmSsCYuBuCs2G3ysrim7sEw9/Q30S2bso86qKL?=
 =?us-ascii?Q?SonWzyfX/oY3iL9kwXdeDZvUU2FyM0NzHbqFlYF3mOU33Z2RtmbZhfiAQn99?=
 =?us-ascii?Q?Dj8amnraoqadq0Fzab7vyUbt16y/ZbyvQ5OH+w9Ef7ZfqsgOsX7Asvb7r+jC?=
 =?us-ascii?Q?PInkf8BGe3mYXKBh45515zL16B+WymDkRCh61TeH0n9+0fRgoo4FIupi0QtP?=
 =?us-ascii?Q?8G+/bYm9GgvRitM8AG01srTMWSGTebpxNp7a4CFqHJAKG2xhhFDluWwwdCV6?=
 =?us-ascii?Q?Hq47dCxlp6iBCd0xmR4TKgA/Y8OVgn2uu8OFFC/BFZFKZ0is1qK7bH3g8tAL?=
 =?us-ascii?Q?mssheahHUyShWxNWz6eZXvajVOWDzg2N0qV1oxgVHEuV3j2Kbls++s93uvJO?=
 =?us-ascii?Q?uoyY4F6e7ncqrbpMi7S2/hnAH1kx5y0pKIke9jEr7Xa/vkcQEKQgxF80rlQX?=
 =?us-ascii?Q?/2Ay2eF6Zd6NJ+xMi66KJhs8xumCEI+RaOVLefthOGNYBnwCEu6R/17dRCGb?=
 =?us-ascii?Q?5UeCXvlJqVf9DUTQi7s+HR0D6CB8TFudqXLvWmnxLmVU29VRzU3ue7ytVGeZ?=
 =?us-ascii?Q?GTlK6ZFrFOyj7D++GDX7mDLiruGbDGliddViNPiMc6L6KitWOfqDnVXJzV+A?=
 =?us-ascii?Q?izz8UnOgnFwPm2+gI+oh4CBc8aA4F9ZhJVBMy3L0rhLMWONAuIlj+WmUmM1A?=
 =?us-ascii?Q?lx+3wJQxyToz73mtG6f12Ek6ZIik6IOaQdIP2j5PiOfSctEKOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:37.5320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee0d025-caaf-49e5-c0da-08dceeaea132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Perform wait_for_idle only for the instance of the current vcn IP block,
instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 18 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 17 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 17 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 17 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 17 ++++++++---------
 6 files changed, 47 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 5332b2903ce1..936d37b8fd3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1777,16 +1777,16 @@ static bool vcn_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
 static int vcn_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		ret = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE,
-			UVD_STATUS__IDLE);
-		if (ret)
-			return ret;
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	ret = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE,
+		UVD_STATUS__IDLE);
+	if (ret)
+		return ret;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 40a3d29d4e71..d1074490fdc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2105,17 +2105,16 @@ static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		ret = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE,
-			UVD_STATUS__IDLE);
-		if (ret)
-			return ret;
-	}
+	ret = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE,
+		UVD_STATUS__IDLE);
+	if (ret)
+		return ret;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 3b2f4f1e0939..a6d3425b499b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1968,17 +1968,16 @@ static bool vcn_v4_0_is_idle(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		ret = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE,
-			UVD_STATUS__IDLE);
-		if (ret)
-			return ret;
-	}
+	ret = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE,
+		UVD_STATUS__IDLE);
+	if (ret)
+		return ret;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index be03d31cb206..258c14fdfd23 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1566,14 +1566,13 @@ static bool vcn_v4_0_3_is_idle(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		ret = SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, i), regUVD_STATUS,
-					 UVD_STATUS__IDLE, UVD_STATUS__IDLE);
-		if (ret)
-			return ret;
-	}
+	ret = SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, inst), regUVD_STATUS,
+				 UVD_STATUS__IDLE, UVD_STATUS__IDLE);
+	if (ret)
+		return ret;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 43b1f3d06157..90a39a461e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1465,17 +1465,16 @@ static bool vcn_v4_0_5_is_idle(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		ret = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE,
-			UVD_STATUS__IDLE);
-		if (ret)
-			return ret;
-	}
+	ret = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE,
+		UVD_STATUS__IDLE);
+	if (ret)
+		return ret;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 65554c4e86cd..456951bf304f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1192,17 +1192,16 @@ static bool vcn_v5_0_0_is_idle(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		ret = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE,
-			UVD_STATUS__IDLE);
-		if (ret)
-			return ret;
-	}
+	ret = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE,
+		UVD_STATUS__IDLE);
+	if (ret)
+		return ret;
 
 	return ret;
 }
-- 
2.34.1

