Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3D3CF042E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC40910E5EB;
	Tue,  8 Oct 2024 21:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lAvuZ8ED";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9704F10E5DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9Kwm+66LzDPhP5uQ3mJmIkLRNtqBPvnGxfEPY7flaJDVktU5gDaHM3I8Y1C6fVGBUImaUGh5OcG9OFJjt7DOIHLf9d4sz/2v5svGhcs6jQpEsCAnwEz+wetmzwK85tQfejiFFJmEXWZIrevksNEAbObu8MIXQd/1ycT24+rBA3PVQXE9zY6TcpZd+xd8EEcGTq8xVM8jN/4ivhUDFvAyoEIZxeUPsdhQ5KdutrKAQq9z8MnBjeC1KxV5O2hCxp9TyZfK+kywPbjgojRp8FBGpCpUZvbw6V6OFiTItWiiuybGqBRyJS7gGLVS9s2C+FPaJHMmSsVV2ax3GxbrXDt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AXoBcPJU+pa95bNHSBeD/xuuQT0OHaIvBi4Vu9dP3A=;
 b=v4vrYHl0ADJb08XbsHxw//EUUPSTQzSX+x257vS1JK11adr0IokPuILAER3+gT4eyNi1Ojhjo1ngq2w7ej3ffED88POAHTOPPBXT8BGsSKDt8J7N2PM2F3hsCLy8LAGtEtwMKFSCD8ebjtdlHt7tyIxeLaHALMpJDW/4MupkbluwSyj+ErMgFZYH4rheCu73T2Y80rF4IhQrK11oUAs2zEPeJixD9hCM6bPrAuYWg9BtsBgnYfCqxR+TWMAoFzXrLGTcWaru3yUzhHnKF4omvLmIDEX0msuHVnd1FaFwaX+ePEzeqXnhwlZbkJIeUafnaQsx3GPu1Pc5Yc6a/ESUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AXoBcPJU+pa95bNHSBeD/xuuQT0OHaIvBi4Vu9dP3A=;
 b=lAvuZ8ED3eDzrgZWnhbOAmAV8QqY7UrlKEQG3j/CC4AX4m7Nn8lq/gpxvI9xxcGDkP/kV7EnEn/Cb5oLEa884xFLF4P64eO+qaomSmysKWQFhEGGIx9nmBc89419gL79lq+1NfogtSoLZaegC6qHuE0EscEhtaEsI8Y6bFpLyLw=
Received: from CH2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610::37) by
 DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 21:16:36 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::9c) by CH2PR05CA0024.outlook.office365.com
 (2603:10b6:610::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:35 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:30 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 31/32] drm/amdgpu: is_idle for each vcn instance
Date: Tue, 8 Oct 2024 17:15:52 -0400
Message-ID: <20241008211553.36264-32-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 206f1714-77f8-4041-4d8f-08dce7de7df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EnAIDzHouFYmNIm4ssqkYZ/j6TbMntkwMCFcQphLC5FY7qWFT1cWTtN+VyQg?=
 =?us-ascii?Q?jklCdcQPGbCp/mTfwlYslerF/ZY4PyuiMlRNfD3kFCocTdidaPPH0Dl7uSWl?=
 =?us-ascii?Q?hrnKr1AVeobVjw9o8bq5s+yiIBV8oLN3i1MjyuC+OwUlikFyjjXlvyRgMkS/?=
 =?us-ascii?Q?MXAjvY+HajWjEgucnmfKvSVbGBCLbVREc2/kgjWNRd+i2jnsEcwzklhiIQD7?=
 =?us-ascii?Q?mHkyIx/lfpy8P1bVSU0CM5QMwZEGpGNyEfnDTE/dv0ia+UC8Cy90BxDKGcdy?=
 =?us-ascii?Q?ZWBzMlp94Mq3YfDXE09fB2AEZMrIJuqCetvb1C6NO/337V03sH8bkS0LkV68?=
 =?us-ascii?Q?RXUznzIEdIUpvWath5rb4PmiwpPu0H5zYnYDKYANrLIgIYRSwdTA3mAsRx+S?=
 =?us-ascii?Q?KwMrWEVKb2YZLB6TJb1TiY3/dG9F6i0zhG0td5MKDQS3h2qJ21TKCgRaXtpD?=
 =?us-ascii?Q?9XE/nLQ7LZgFEDvVSKtg81SJwQ1qCaLANHVBoZ8UJGGLJ1pHZ3koWrDjQlGD?=
 =?us-ascii?Q?4da/l55X9fpS2N2FiKOBNohGjH/Jj6hDdG1598OBcEbHUdFoehCOgEKt4M2L?=
 =?us-ascii?Q?t+LiThJJrnYUhXqfMg1iixgd1uuRKn6LiwL12ym87Rd3kJ5fdDwlFdzFROjQ?=
 =?us-ascii?Q?osb2W6jGUsBBYSNjc9CsCP8fAOgtn4qQvwlJTSU6a0nkdS6O74L4Q56EnUVy?=
 =?us-ascii?Q?1lCMYI0Hsr1fcRiVgL0QnKdth9yGqd5NWzMer00QZyv1LzEZaP5JzjgVABvy?=
 =?us-ascii?Q?E04mMJbVP+ATf1EycHmeCv123b5J6kTavam3WdXmbSSnVcy3ziSbq7smmFCj?=
 =?us-ascii?Q?AKVY+DaIYAeG2QtpRoSB3oQ7ERuNqYgAWTtcwao1kMXFtvBkGKosv4B9y+Bz?=
 =?us-ascii?Q?9wr/A1G6mwwPhNx6b0+iQZ5xvql23Z3HGgULeNK/1JFk8OhRNZdXPUQUMJbZ?=
 =?us-ascii?Q?Vu8asyHGzKxubhjqrqH8jALay+cqDK7AvA2v3eBLaQnI7d7FCpRFm0c79fGC?=
 =?us-ascii?Q?UyMJ8i3KwEaI9tIhrghkEhqlpUEp38d04p/3NZMREycc3iLd1et8orKTra4i?=
 =?us-ascii?Q?1wDhicajGZ9Z31ZcDqXnVeWmLWc2Yg47skftWrymcuNVZAVPl9erIABXcjPm?=
 =?us-ascii?Q?5U7+jRtrcaPvzgswPtFRkY/8nNaPukmC7AY36PUiWK+JRm38n1TbkfnWD5tG?=
 =?us-ascii?Q?vS9UzRlh0H3XUGcWngjZ04lNeN3A1VxYRlWl27CljhatomUttWcDAogyajlB?=
 =?us-ascii?Q?qgisbg7FrpKHFXa8KPF5vxoZ/x4yHjUJ4uSCRgwG+eTjCFFDwJWZB2ZOQVj6?=
 =?us-ascii?Q?CiHZtMifrdtdwDzKi1vmoQjvXU49NsiB0KwCEee6aaZr0hNJonp8ePX0TSb5?=
 =?us-ascii?Q?www/N4M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:35.9982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206f1714-77f8-4041-4d8f-08dce7de7df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
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

Perform is_idle only for the instance of the current vcn IP block,
instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  9 ++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 11 +++++------
 6 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 936d37b8fd3c..0b62729fca89 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1762,14 +1762,13 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
 static bool vcn_v2_5_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
+	int inst = ip_block->instance;
+	int ret = 1;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret &= (RREG32_SOC15(VCN, i, mmUVD_STATUS) == UVD_STATUS__IDLE);
-	}
+	ret &= (RREG32_SOC15(VCN, inst, mmUVD_STATUS) == UVD_STATUS__IDLE);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index d1074490fdc9..5b11062b873d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2090,14 +2090,13 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int inst)
 static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
+	int inst = ip_block->instance;
+	int ret = 1;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret &= (RREG32_SOC15(VCN, i, mmUVD_STATUS) == UVD_STATUS__IDLE);
-	}
+	ret &= (RREG32_SOC15(VCN, inst, mmUVD_STATUS) == UVD_STATUS__IDLE);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index a6d3425b499b..69fff5df1c68 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1946,14 +1946,13 @@ static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, int inst
 static bool vcn_v4_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
+	int inst = ip_block->instance;
+	int ret = 1;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret &= (RREG32_SOC15(VCN, i, regUVD_STATUS) == UVD_STATUS__IDLE);
-	}
+	ret &= (RREG32_SOC15(VCN, inst, regUVD_STATUS) == UVD_STATUS__IDLE);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 258c14fdfd23..cb30d5e5bc70 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1546,12 +1546,11 @@ static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev, int in
 static bool vcn_v4_0_3_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
+	int inst = ip_block->instance;
+	int ret = 1;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) ==
-                       UVD_STATUS__IDLE);
-	}
+	ret &= (RREG32_SOC15(VCN, GET_INST(VCN, inst), regUVD_STATUS) ==
+				   UVD_STATUS__IDLE);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 90a39a461e86..68397bea5a18 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1443,14 +1443,13 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev, int in
 static bool vcn_v4_0_5_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
+	int inst = ip_block->instance;
+	int ret = 1;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret &= (RREG32_SOC15(VCN, i, regUVD_STATUS) == UVD_STATUS__IDLE);
-	}
+	ret &= (RREG32_SOC15(VCN, inst, regUVD_STATUS) == UVD_STATUS__IDLE);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 456951bf304f..fd78472b906a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1170,14 +1170,13 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev, int in
 static bool vcn_v5_0_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 1;
+	int inst = ip_block->instance;
+	int ret = 1;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret &= (RREG32_SOC15(VCN, i, regUVD_STATUS) == UVD_STATUS__IDLE);
-	}
+	ret &= (RREG32_SOC15(VCN, inst, regUVD_STATUS) == UVD_STATUS__IDLE);
 
 	return ret;
 }
-- 
2.34.1

