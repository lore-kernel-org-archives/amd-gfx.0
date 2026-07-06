Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CC9C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E7110EABF;
	Mon,  6 Jul 2026 20:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGTGNa9Y";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB9110EABA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InmZM3WxhF2DdcmAtclqaxykOwZljb+b7tMAPr3we3twslPkljz02shP6fDXaDJFv/GCEdTqj/p5qdnp1ZGSWyGJ10QDB3SFIy9RG3ZHtV/hSJEWW5EUcvJZqj2vQLltcATaqE5HiNyAGvH7VaS2DhC1C0KzmnGG40YVHLSJz7ta20zbD9MM6JpKlBdnvqmfXFk0SMazsvdShhJfdaJgqDxW82oNZaPKPs64zzDqHAizzMHeIeQObo8vYqZ9fDuQraKaDnDpX081xS2lMY+BtzH72iZ4TBl7t4BYSHpHiAW8/zFUZFKdmmA79+rIL2N0QZxhaJ45bWw8ow0uEZHr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejPpjWa6yud57kRE2K+n+MclKpV67XQUj/WlENH8rdE=;
 b=SehSoXP3TRyVR6yC4ePx4AsZOaeXTyYCPPy9qml5Xo8IGyAHbo1P5cDDVe663I7x+PvRD36ZZPZOdJwAiCFE3iB9hx2y2exDuzcFbtIrhQspHr/nJco/QHi85Tcg+Qh2fS6IIRUJ7SkUdEp5sPBfbDuphybMhCozSZhc2aCdKsPO9fXR9TZ1luZt81GQIyPK5dTWaiUI2zMTLXAeRE2+Sok8no/f30jpyKQvkI9OD1fR+oWBCpT6IroqyBoGwBLEVvyGqfNukDRX8E8cCAhBmJuKa/geB7UHywcTDZZOZK5nLk4UyAddu3YQii742akcceNSnb1tHsqje3K25obTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejPpjWa6yud57kRE2K+n+MclKpV67XQUj/WlENH8rdE=;
 b=ZGTGNa9YqWg7ftgrnPgRK4C5buwwPNQerLS5jAeN7Bbj3BjjWbmoCDCJl/Td3GJ0vPQsq6xu++QiAOS4YsNUOaH/vLV9lCyFgQMPXIPdE4lPg9G+Pe//+D8FWR6nHgmGfOLJRtdxqI2bbmcgvBcULl61zfsQMppBWUWaLVuppSA=
Received: from SJ0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:2c0::21)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 20:06:10 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::59) by SJ0PR13CA0016.outlook.office365.com
 (2603:10b6:a03:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 20:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 20:06:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 15:06:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/gfx12: disallow gfxoff around GPU reset
Date: Mon, 6 Jul 2026 16:05:57 -0400
Message-ID: <20260706200600.15071-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706200600.15071-1-alexander.deucher@amd.com>
References: <20260706200600.15071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 75368b67-83a0-414e-aac7-08dedb9a0622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wImQnDt3Lhp0w7KWG1ozK5a/YQKMNMtr407TGnaFCDtWtch9fA6RkYjPFXDBgPCRp0X4RcaKzq88+NkeeHQPlshdu6gUVs4KKkMbbOCq8e97a3JVLjP4EUnk74GqFYMNDTp42KCdgQkvz5g+9svcn893r6FAhL6HhP7kLmDxtHrUeawUjAxRaLSwF4XZ70PHilej72zv/2QrhvLfjXJeqGgBgvoCKqkql++MQ63UG5dymJ3PQfK2xrFJoT4Ve6FWzc6PmbBmjc0/y3XxKs+MjtEwTG16rx1Fmc7sWTRFlPwH7Ul6o+MVIMtyg5StMoqeNYDVRT1e+Ax1xWCX5StChP6/rzTASH2eSaz0/mv6ksMvFrgY7+MiluC9nne7MTPBid1Rloj2gm33VEI/wtA+4ce9NJwW3Pg8s9MAIirrnIrbCHz45wN0gmaEALeDOZCL+Xor/VMXPdwoL2HwYk7TF13AEARC7o9TSA/r5seeFIWKOi5BGiN1EBhpKlNPTYPdEHmk+if2keXJVFqIOFKwd8D/8Lxfk0wdCkx3JTjB7zja882YHcirjtmwGw9u1YCGpGimKOytsFi7sqGqekd5dGNGexl9RdUfmFgyMMXjQ0C0+Z4i4sKT3IKY+u1U20ynveQdz7u7ndpaLVGbO0muMmBcE311YW/WB+wLFgDIPNBxeGmM/9cd3KLKevr4Ll3s5qHwko10ND7+NUmdL1SmcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 59KbxeZ67Ft8TJenGjK/7qNGw/XRbh493PJCkLOX8iheIfLClbJU3enOjSD8AO00T3zah1NNnvT+4tAM4RHYEJksWsuJKgvHWJ5/BoW3f7tpCTtUaFCbPiJ8+UrC/9vxKOlI5R7zFoSrYmJ5AAD45iGNO0YBhs3iqnSSXnx7R5PJDuLhQpBcU9NLsbGkMP2C/tu3IYArORHhIHWzqEs+n3gDB6Lm0tvJZJYlJ+1nD2onUlCsQ6TE8xy7uoAqWEbABvvEja7xK7tRQe+zluSKxivYRRyOYTaErKNdEhb6izSrcGz3sQXcqWjWToym6Wou+8xloT2PcRFiryDCLSC1GR0xrD4L3qlB74BINsinw/H67nLx8OIt0MkP58tmRVKVStV1luhvNyxFaC3zUb5DX85763B2FUz6osrmwNgJM8S7pRRYvnkgW+6iMqP430Wq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:06:10.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75368b67-83a0-414e-aac7-08dedb9a0622
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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

If gfx is hung, we shouldn't need this since gfx won't be
powered down, but we could potentially have a case where
a queue can be preempted, but due logic errors in the commands,
the fence never signals.  GFX could potentially go into
the off state.  Protect against that.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a35cac55c859d..9055b56e78f4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5292,8 +5292,14 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool use_mmio = adev->gfx.me.use_mmio_for_reset;
+	int r;
 
-	return amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
+	if (use_mmio)
+		amdgpu_gfx_off_ctrl(adev, false);
+	r = amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
+	if (use_mmio)
+		amdgpu_gfx_off_ctrl(adev, true);
+	return r;
 }
 
 static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
-- 
2.54.0

