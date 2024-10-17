Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DF9D37490
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DEC10E83A;
	Thu, 17 Oct 2024 13:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ul7mviF3";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA4810E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Anst/00msuc7tfvUQgNqUc8NPvAsr75V1JznO95dNZY9Q0Q4Tc7RuVxREVG4FhG+1hsn1e7U/UmSwD5tnz3FohAZOy6JkEaV6Bfui/6LlaogDUW/aMSmWPnXpQ5aYLvFJTlEr28QdgjnfeV6Pku94pQh3A7AA6w349ZfcHkuduMan+/DS5LrUrRdvKDf1FEUupsP8k+VBlav0NwGIp5rA9g+BPK+cTUR/OEMTH9rWjDk8XrFOtw3QEu8PwnQxGGhWTduXwEto3x+Nd/XYGP8I86ZWcxiV8WY7WBRGQdbDxsD7lg78uRW2QRW3PtCbz7pMI9GfzE00LpKY2pONj2Y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AXoBcPJU+pa95bNHSBeD/xuuQT0OHaIvBi4Vu9dP3A=;
 b=NR8G1BCp55GR6zJKcR065LDr/G82KaulLN/InoRpZgmWI+7BEznyyOUXlVL97zzdQHpSNdr8J4Xirb0L8Leh3SSEce6kRvm9RsQFIZ8uY9F8UjxpH60iBhlCScz5xjugGQvtpWzstZgzR0l4E9iP4Un4vg355af7egBZQBSTiEMyepWx36f70ItHR6fvFur3v6WwApml/zD6MoyB1Pu+3FHoZuCXn9Pj1oB2FyVWWeITMV6CsIrUz7JWozCjerfGZL+2J9/L37KE7PzFJGYuH3oggeY6F0B75eN0cCEfVNhaSbIripe9iZl/iHTrdlqSquGDjIO2oQyKuKUJhrRfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AXoBcPJU+pa95bNHSBeD/xuuQT0OHaIvBi4Vu9dP3A=;
 b=Ul7mviF3LQQw9rNXS0TWamyEGdqMonISCe/uGfSc3O97UsMhuldN25t1GsnnU7eLz9dmIvP6mcvZGb+YnM1PG3sYbuwEZEzEF8fa9HWgmDhOOxKBUXJrYo9CTHC4IVSPn/xxXvg08zl3LO1qlMt1WgDWAGHQ3nxpa6jQjYtO/aA=
Received: from BL1PR13CA0100.namprd13.prod.outlook.com (2603:10b6:208:2b9::15)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 13:21:38 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::a3) by BL1PR13CA0100.outlook.office365.com
 (2603:10b6:208:2b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.10 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:38 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:34 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 31/32] drm/amdgpu: is_idle for each vcn instance
Date: Thu, 17 Oct 2024 09:20:52 -0400
Message-ID: <20241017132053.53214-32-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4b775a-a21d-4930-bc8f-08dceeaea18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+iwI14rWyYbJPKKaP0dl2b3giFvmV3iQq3xoHX1kvGsx7ziCnka+vzU3INsz?=
 =?us-ascii?Q?dQRNte1pUr4icAJpYFNAIWrNU46/8OAqR9WkpcNXFKwofEUi15sAdyWWVd5N?=
 =?us-ascii?Q?dZYziHwPMg7UxcHAjo2+7ugaV+cITCRDT5rLbeDH37+63JlpkTi8HzLQizp4?=
 =?us-ascii?Q?dZEoBF0kGpipLjri0TessqFArNf12MEslbbwNPDU58nh+4RmdvC8nSYLsMTx?=
 =?us-ascii?Q?I9De1yEyIJIltiepg90i13o56t62Oyj5Ldl2ESDA2zrKcVT+VjNfoImjIwCJ?=
 =?us-ascii?Q?M04Zl5oGm/K1y4t7YXBQag0lgyRZkO2QDRTLLVhRjmb3MsLo19PfJV+G+WQ5?=
 =?us-ascii?Q?ciEn6KnfR9h1BjccAdJ1gSmqyw4WYyoG385oUGhhnaV69b99fB6tKV8xDcdi?=
 =?us-ascii?Q?jHGE0k0vJ6CKLtJpi9bYnQShG62Rnp/Mitqk8CCghzUtvIrG0NwbYCJc30a6?=
 =?us-ascii?Q?rLkf+VWD9hh+xweC+l/IjyTE86FvMSERfCaHUZowTPk3jvVGWH9RgIc54FIy?=
 =?us-ascii?Q?ts3Z2ynh/hVw2GIJn9yf1BTNF+rKC5HRmSMbBndCJDKjP439R+7wE94rGxPS?=
 =?us-ascii?Q?9/EC+ejSHAKMAo8x0Go69xeODlYUtMQoPR0yCDyU5hi+4tkgCbjl+G8kEaWl?=
 =?us-ascii?Q?IUD4aDVlRK7gKli0GXsxzF5UzGcEmQ9CZcNbCwR6UKFiz9Ml8bOj1XbZmIth?=
 =?us-ascii?Q?tkgObhfCikDAeqhPz2KxJltqfaJ2xK7meP8/p6plXY90ngQca6gzSUqCgFlV?=
 =?us-ascii?Q?Gex2JZZVTEqk0F7fr/JfhX4qK5+IpoJRFkr1S6Vun9FlSsBEOzeR3iFcAcno?=
 =?us-ascii?Q?bDXhuB2DwqTj+tblBFA7Vf3aaufbhg4ZAFRHRzfSQHNL1jbMAoCJovUFgovn?=
 =?us-ascii?Q?Ue3HnupYD5HZF1cNyxdxwowQrAwME+o5ZClkFE4ufH363Ur1BMCsKUDjQeK2?=
 =?us-ascii?Q?bVDua2DDODhg7hFj89x7N/Fg99lhVC+6jJl2kk+iwsO4mA89X8S3w+5/Xntj?=
 =?us-ascii?Q?0hoMGEQqpOgSoRI4lcPlewFkMhASKoNAuXP8mmvgMZ5vC+Ida1dFPoxTqZuE?=
 =?us-ascii?Q?LlC/061MOWqA6zLIsR6BchNmNlBeR64nvb+NTOyC7fclr76uWAnqdLxYiLtX?=
 =?us-ascii?Q?F1XhMEb0Sl8OkWFzmau3Z7kW5W6FLERXzgVAn3Q6l82kFTnJ+bGI3ZGPzTfW?=
 =?us-ascii?Q?JNW+Y1FVYLRrplR6CCjPE4h8ms7BrJYjbZRbjCafhrbWX1vXVPahnkiMdRDx?=
 =?us-ascii?Q?dg10nO6f0NeHgLT/8ITtBVNSWjWI5maVGQLHL63JdbKTq8OiLI8qd7plHtWT?=
 =?us-ascii?Q?qWJIRkMRn4SmgB1rUewwNUUtDZCRvjwdCLG7XbYmI8Q+iB2VtMatabnjudEB?=
 =?us-ascii?Q?IIRzA0uT91VUP1emR5L3NFBRhUKG/sVLTLQgyGJvKo4K7Ufhyg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:38.1414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4b775a-a21d-4930-bc8f-08dceeaea18f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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

