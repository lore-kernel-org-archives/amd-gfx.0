Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBA3D116E1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3E910E9CD;
	Fri, 25 Oct 2024 02:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lyv3I2Qt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B1310E9E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPZWWHVxK/4KsbHrkvYnwXJXqDMBORC5W16yttDl+YdivWsAikLL6otYqe4lMIn2Bivhtrlu58MC1rdbiyWoQJ8b/0s4mk2fYX//ZYvUFNhFxbStNfrzzJn0B0gVJLYOgMQqApTanWHH7O8ckKb3ib3RfyVfgD/pGmQKABVmo2cAVqI6EHn4Ar4AD+b33744EKFXcrNeMxd8fxwDOWX2eHzvnJm96cp9baOUghY1Eqj25nFYWDq1pKsTTsumLmNac3VCLeZmqR0ouq71HMhSfWmXFA3UDYhgbpM7a89M2raYsCAv1sSXMAXi6CMrqASL7Wel360b2V49WbrTabuz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp71ug45mVdVbTZ+k6wphAC2OVo12KTFJXVI4pFRr6o=;
 b=S4n0TC5TDcACW4DiXF2ALYUskohCvU++ia9SgDTgAnecwPC59bZZ3IyfteHrnCxNcT4QTTbcpBjfTbBfUjzKTIdl8AXUbCY+McurWVc6Bqcalqy803Uese+j1JcRjQAAKeatuX25teJaZa9CagL5muntA0QzqZDMoH0GIhVLhLV4du5cJY1lBwaXeV9nNvO/+7bZABuH54o4lWpfODvBOVVlAYvyNl4KDuDakrEXo4+0CIM/F0ICAvFiTiaET+ztaP3J29roDq9BUIwrgIKRwLvYxJqwT6qQvNveqIviDOLMVscTp3M3I8STNuvYtPNH6GtEkMvKlkljWhnm+OujdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp71ug45mVdVbTZ+k6wphAC2OVo12KTFJXVI4pFRr6o=;
 b=Lyv3I2Qt25YHtbHyAREL6WkA4MUUhZJ0/Dpiwg+B3dG7AAhAd1wFbHrQHoI6PSprnVbY01YdL9jEfOyIXrHGSMHyEstkNUq0HgYBK1LrNbf96DP5OsTtHq1wdvSmAlpsfyOQhzb21/G4JB2vJgBhhhtThhsnb3mVEcog8LE+GzI=
Received: from DM6PR18CA0001.namprd18.prod.outlook.com (2603:10b6:5:15b::14)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 02:36:27 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::6f) by DM6PR18CA0001.outlook.office365.com
 (2603:10b6:5:15b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:27 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:22 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 28/29] drm/amdgpu: wait_for_idle for each vcn instance
Date: Thu, 24 Oct 2024 22:35:44 -0400
Message-ID: <20241025023545.465886-29-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 2caf3bb8-9d62-433e-8f0e-08dcf49dd35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3QePkpD4mpY2A6qEX8E3D6Xj8ibmsvauCnh45hT55Jk5kNQxoqs87PynKMap?=
 =?us-ascii?Q?gezkZ+Ns70or6c6L3S/OsYRLShLt2ULeYPktqfEBiNieeg2DHed0wJY2gRGq?=
 =?us-ascii?Q?dUUjC3DIhUNRnj72X8hHRobG/lX5Ruv3MGAP+CDLCCV+/LpNIjT/KLOapwWf?=
 =?us-ascii?Q?mr9+rrVEvZroFRwCksg8sjipjtF7Xzo1oYN0psHqbGj7QYNlMXEW1nXTGHoi?=
 =?us-ascii?Q?YdO49+LVS+KgTgNQJYeNslReK7lJ1bD1lLYXPeqqZHctktaDoFWyTE+Hakzo?=
 =?us-ascii?Q?JZ66BCHE1TkmlKIgjGw4Hi2Qd9tJe0HK1dreTRRLcKx35MSBCeXFBcwqOvDm?=
 =?us-ascii?Q?i+OQ5DYZOKCUPo27Dx/nqIEIAKQ+jw1EBAYK7wAq64giBWlYyoGGwW52iyS3?=
 =?us-ascii?Q?l1MCiBwnWfjdhTSq7ZDw1vyb114mkIU/63fi9ksCpP8T5g28BFjmSJtcyaEs?=
 =?us-ascii?Q?LG+O8R+VFeFz/7NLNw3AYPRBZKQjqCGaWTchAotJFu5aoll29dp9Vto0+wOy?=
 =?us-ascii?Q?Kosra4qVOVybBjzcJzL/7FPz91ZnvdEp8pAxmtbUOR2Z/ynkJSq0WaJEHWvG?=
 =?us-ascii?Q?8DPZRUNt81+CY4ZUQM9JBAElg1EsBlZUvU9JwB5NnMB8BBdt6RlperGar47s?=
 =?us-ascii?Q?hBbvHesRkPL69tkDnCr8vb8CUdg027o3S9Ezig3K49j3OOd7fCNPfJevsDdI?=
 =?us-ascii?Q?74V+pIZzhdyqTHJMJiCAnqY4GW4PrnvCrkveByUpGQxoCdrXqZa+YkCuZDOn?=
 =?us-ascii?Q?Tzm2R8zX3E8IzdZOpEp8asroL0rwN71ZhWci4F/5ZSKQbEVS+92IJ938IrXM?=
 =?us-ascii?Q?a+STbshbIUkHMzz0F4FLI2RMwSXhVD8FFVjp9ZuWOq062EAenbAhJgU1BPeN?=
 =?us-ascii?Q?uCu+N1XsUdAhqo8OT2WYXybK/fxDUBijnbaZbHtHcc71XDP6LUEfxzwSmt2L?=
 =?us-ascii?Q?GGCVYI2ca5+bDrbfnZaNTAH7MEbFUR6UlKF0nH8Mmh2btiEF5crUSmCmZWdo?=
 =?us-ascii?Q?OglAHIqr0YJeTP5sceOIWesmuMsEMb4nwVgMA6AN5JQTLM4JgGHaTXbov42q?=
 =?us-ascii?Q?SV9Rlp/MwveeFI4VUhVMjx9k+ZisysPFMxUsgXyZZqGOS8X3wal6ZQjFmR61?=
 =?us-ascii?Q?mV8mN4jzLJyD8r9mBFAmcdBqf7H5BUtPnUYUhijjfbihCzd/nEMAmq2owfb6?=
 =?us-ascii?Q?G04XiZk8CBEvMoRvk9B6bbhdOYLISa7kO924bC85KuuOgbMwKBJZ6cS+JkAP?=
 =?us-ascii?Q?ZkW22R+wkJ4Hg8OMjbbtlPkkXO2jZtfFJsai+TQNO1j4Z8QiTFVFNRj6AS+i?=
 =?us-ascii?Q?m528exjtnB7PEzyOQ/yX3Auzokm4HdAep6tTgEih0NTKhr/g8glxWUCQ/TBB?=
 =?us-ascii?Q?W8oAeP0ZYLCuHLs9V0J45XIlCQVICJJdPPpPtpnENQjtoUF5RA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:27.0994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caf3bb8-9d62-433e-8f0e-08dcf49dd35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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

