Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E606CD3A680
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3206810E6D5;
	Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0LgTU9Ko";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9738C10E6B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkDDUybYbjwrS9Gs97oMhaWIbDQttZSPcsMO8B83YHOAo46JLBY7CUYrOF7XissWMXghFsydcDvkVjqrbrS4EDh1AGg3l/HfPiVbl/1X5X2nNet4SMLtgqCyvhEL86oV/0gpCt5k/owCKIUnGk9pmgYX3HZpPRlpwkKbYBWnpgphyw3yho6zzazQCkN32w/saArkU9QuJAk8Xn3TQfNlYlxJgMyLdxaXICKcgLdXOaY4ImP2Dd89qzaSsqdd/VEdrTW1z5BJxmHESP3PqHdqa0XHJw6sS/UsZhZ80L71AZfXycslY9sdHXh2k9NTz7IcyLFmvktSyMpeq6zEpmwVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6lHKvaXezUbrZ41t8R0WSXtjHq1YiOc1mGFLaUNN4I=;
 b=MD/Ur3vJ2co7H9Z7uX5CQa52uLyNRy7a2fy/gXiFGtpccWpDwWLOC/UXt9l699xz4Y568lbeI/zAI0kMcau+b5P2NQLy/NFXZD2e55G9CQ1MzAayJCS6d2iM7lkOTApMwvtIfhPt9DhYnbp6ubhTf0FFKuvyk1vXG05SwrE2VH/bhtskh7mlqmMz0K+XLA0Glt5kAkL8f279gjSDQNkjMO3lRj+24dqPNM64KoL5TOe4qG0SARtq6UZ9Ufc27a90N4M8VSGbO7x5kPj/NINg5CFGbUwtHYUlV/q/WX7tOhgAA1K2OSQOHJnLMvhB8jLa2CPLV/LiFo3eWVOjTeABLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6lHKvaXezUbrZ41t8R0WSXtjHq1YiOc1mGFLaUNN4I=;
 b=0LgTU9KoQoZ6z/fu9BiODSEkl/aGIxxaLlbc+7O5bBU+Ot6FW7OdwVOT5naf1NcIVOH3JK4W23WF07QDuUFEBz21U4rG3wWK88TUpl0+kOp00nkDrKotpnOQrFaDG6knwqvA9aaZshfH9x8qEqXzVoFeKarQTpy9PQD/qGl10Gg=
Received: from SN6PR16CA0049.namprd16.prod.outlook.com (2603:10b6:805:ca::26)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 17:43:10 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::d1) by SN6PR16CA0049.outlook.office365.com
 (2603:10b6:805:ca::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:10 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 28/29] drm/amdgpu: wait_for_idle for each vcn instance
Date: Tue, 29 Oct 2024 13:42:39 -0400
Message-ID: <20241029174240.682928-29-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e09e9d-7e15-4c59-7b11-08dcf8412800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apZNh7GuR7Kvw+rqk2jIiCOhxZlFJioXQfX2BVZSFGgKnwgjXiaixOSs/S84?=
 =?us-ascii?Q?GW8euRGho2nHxO8M29OnpK7lrkqgq0SaKlHPr1/XREz9RO4sGV7K7Xa2P7ld?=
 =?us-ascii?Q?lkHs/QvM2Ts3WYZAoGSgARFUOwdabcEt+/ekVxjGK60eruQ0D8nD2CxaLe96?=
 =?us-ascii?Q?LoOLkGqr5b2fj0Ve3KumgE9981wWvgpOcSDcWbqyq7DLjIpvH9pXJnsSMYyH?=
 =?us-ascii?Q?6hLIU2JNuOEFrlyp8H76ANUPfL4zPP+Jto9DNXttsknKyDo0qTgiXxbKZPvU?=
 =?us-ascii?Q?58wTeNC4y7kQCIQfzaOFW+Vriykuhzq0GbGP8gax0aorao29Ti9JMNseFodP?=
 =?us-ascii?Q?kv2aeFtqQOXbziXKoMRav+1vwDy+WhfHs4CtCJZbk2tjINkSdtMpWsfXA7A4?=
 =?us-ascii?Q?H/iJiMvXd5bK+Om/X9jMYYknJ3K2D42+qVi5M9GsiqYVrs2Pn0XKwPqar/da?=
 =?us-ascii?Q?LcX7YSeG+CEtcVijs0S9xJniSyEpqfoviQO7w0th/Y6gowhCC6f11ISfyPOB?=
 =?us-ascii?Q?fK+QZEnqeC8rJ+kSL/ymuIVlDdbC7e5TuOMUC8k6rvMAVCZDMaz5ft8pHSnC?=
 =?us-ascii?Q?yb2wU13rPADkWGe0TAyGAV11zx9obHdChBzNilixLzxgBC12sBvLzwSU3ki4?=
 =?us-ascii?Q?QIFAj06RsUqnDzonvPemtgXL076zIG1YSSmSdGo7WyzX7Cz1dXMnX4pAAqGZ?=
 =?us-ascii?Q?XxYc2pv/YYo7GCGMm5tXs0ch53fihrlgN2VbY4UPiiX5HMWUAoODxL4nxJ5I?=
 =?us-ascii?Q?90JKT3gH2oTnbbJ9rW3kP2Cqdz+o840zXiNy7Are/SMNJ9lvpaluBbNJqNcL?=
 =?us-ascii?Q?KdZw7XnRUv36bNEbNxC68RXQ0uwVnKp4qZHv+WdABCNeGe5P6zL1Maap71KH?=
 =?us-ascii?Q?/Fuzs7L8LME8eS4vqzl+WyxfuyyisYt6z1SqDeaZXSH5Ommv0biFmOHWCAeS?=
 =?us-ascii?Q?qMbUeknLme018by/QAzvoat59gZx/Nz698zyu1lMPTHeqtgBmip/BKFpMuAe?=
 =?us-ascii?Q?oKeho7E7DNaMxRzWNUqeezEmv3YlNVgBCqKpy6Gvmfyar+mKE+cWOKKJDp2k?=
 =?us-ascii?Q?kJxA6w4rGZtwOJ9Svo1YmdZhhdSFALJxYKINq1X5nivn9f8wC5DpxsaRV0rl?=
 =?us-ascii?Q?1zW8UxDEDcH8wyBVUart/J7Oc0HYykHXU8uw3tzanXADZE8jeN8TRM32s6Qf?=
 =?us-ascii?Q?Z/+cB45LaNo33nswlhopYPqYztJmfGO0jeeoG7sL8pXeZ2YhkS8wao25AkBC?=
 =?us-ascii?Q?JXRfOTcWsD5hl9UA3kB+FJLPRknOTqczUxTqHmvwSXHbMAo5z/tfTjS9d2YO?=
 =?us-ascii?Q?mFPpfZmN/9eTV8XdP0MvEb9QzEjuC3c2eYNkjtXj3OFYH5+FLvkGScsIOV2S?=
 =?us-ascii?Q?8knjCErZhP8xqdB0wz8m+IUfaHq3knNI99F+3k7lOHpg8AVACg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:10.6513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e09e9d-7e15-4c59-7b11-08dcf8412800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933
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

v2: remove unneeded local variable initialization.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 15 ++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 15 ++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 11 ++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 15 ++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 15 ++++++---------
 6 files changed, 35 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 2e5888b905fb..34d94b09f04c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1777,16 +1777,14 @@ static bool vcn_v2_5_is_idle(void *handle)
 static int vcn_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret;
 
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
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0d1c1534db40..451858f86272 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2105,17 +2105,14 @@ static bool vcn_v3_0_is_idle(void *handle)
 static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret;
 
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
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index e9a8e027d5f9..fa7cf10e8900 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1968,17 +1968,14 @@ static bool vcn_v4_0_is_idle(void *handle)
 static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret;
 
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
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 716bc85141cb..d05dcadb3e81 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1566,14 +1566,11 @@ static bool vcn_v4_0_3_is_idle(void *handle)
 static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		ret = SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, i), regUVD_STATUS,
-					 UVD_STATUS__IDLE, UVD_STATUS__IDLE);
-		if (ret)
-			return ret;
-	}
+	ret = SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, inst), regUVD_STATUS,
+				 UVD_STATUS__IDLE, UVD_STATUS__IDLE);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b74b2c0942c9..307c8e204456 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1465,17 +1465,14 @@ static bool vcn_v4_0_5_is_idle(void *handle)
 static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret;
 
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
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 3fbc2aafcd29..50022bbb276e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1192,17 +1192,14 @@ static bool vcn_v5_0_0_is_idle(void *handle)
 static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, ret = 0;
+	int inst = ip_block->instance;
+	int ret;
 
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
 
 	return ret;
 }
-- 
2.34.1

