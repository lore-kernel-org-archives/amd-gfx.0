Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D333EC54F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8E410E298;
	Thu, 22 May 2025 21:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0cCGSWls";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B516810E0F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT5BI6myymUsJU+HXABQ7FpL/F7QnuIHSxyDcQvcmsbJW5IVWnao8mSVvCS4NApCjmWRu8WtWyh1QEjtPs8cjog/KT9/LtW3vAcXGPvb61MX36LkxiCnl5lWfZFW+gWoDN7snM+d9mf7MIHRGwmvwqJbeWMCr5r2PHZHIWKavoKt/Dj5sexuHWpKGC19U13CUwUmVReYzjg9g9IUueZoJMStmIxaLdNIRaajCSiJChE/QIItuQhR/IJjqcmtraplmNkC+okWaypvdUNsH+w9lJQNp8ISqiQZP5pim87P72J49nt3Bnhi501yn6ceVZ2LWcNaZuuVmLw55CFXMy0xnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxlX7UHAmLJ9i4ugkMtuwy2HDWIDGHfLfl8gFcU4t2w=;
 b=XVT8MzByKgx1gHiZW/RHeICUA1CsDtTKJt1ZejFFpSTmVBxA/juAsNzIYnhRPBSezxMOgyho72PUYS8YJBIq0wWj2UTl18Nvtqj+0WXzMIE6oBAngLGwxIaLjeaLbaCVgwFYMp1vTrXPntsVyr/6tJaqACizMi4h+ri8P56d5Wx7XHa1Wdrx5sGiSiP64q/XKUGof7bMepn9aEO6sYnK8m2bxWAQcVUBvpZvNURa1Pe7/2Z+duBF4SIxnvMbBmVa3/neaZJG/Bp3hIHg13GkzDAKneDZT0g4+KKwoHE03CWpc8Ru+vQ85ja0k6l6eMrGlOtqopXvawTHtF0IbYp7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxlX7UHAmLJ9i4ugkMtuwy2HDWIDGHfLfl8gFcU4t2w=;
 b=0cCGSWlsp8ubuFt355FlAvWiw+Ot/AQ1zVPI/wHTvOQrU167KPOLxVs9e6NfPor7/lTIHda5rfjJZTTExLujDhhgm6ghHIs8tzWTHYGpAYrtGCSfASaGbmF/WjblwMbwa2B7XvlxUDSEeq9cn649r39piwuCg7evnOs2fjG1Dec=
Received: from MN2PR22CA0014.namprd22.prod.outlook.com (2603:10b6:208:238::19)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 22 May
 2025 21:49:42 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::cc) by MN2PR22CA0014.outlook.office365.com
 (2603:10b6:208:238::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Thu,
 22 May 2025 21:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:49:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:49:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gfx8: reset cleanups
Date: Thu, 22 May 2025 17:49:18 -0400
Message-ID: <20250522214919.11912-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522214919.11912-1-alexander.deucher@amd.com>
References: <20250522214919.11912-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe4d417-ff64-4707-5e91-08dd997a8f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ff841oJIcdFRLBJdmB4Re9hzBlryrLba8VXXyj1MaIwUlVViDphuZRMHYd5N?=
 =?us-ascii?Q?nCBR8TYZlT49ELLnTL+1hT4csg84idNXCG7JAiRda10S4Dn29qaC0XdB/ees?=
 =?us-ascii?Q?OToMswDvsKEtvuUj9MpzNTYSBurmsnopVagI0I95qGUEW11Q29aL4UvaC3zR?=
 =?us-ascii?Q?o9+pHNtDBva87xgknP1NnlBQN2TdZiB/tEWXNSKa2QV6SpPY6SPC3CI926u+?=
 =?us-ascii?Q?IiGSr+gqp9QhQ40KF6KpXBShLO1FkXqXM/fz3VK9J7to/+sc47s+x/7ix1jW?=
 =?us-ascii?Q?rfdXnZETHDlj1IU/FjdXYbngr0utcN0smK95nN6/aHoM9MQWi4eqCTANzGKj?=
 =?us-ascii?Q?w/nvxxaOp0Vb/tbXfzwHFuGMxlln0b7hnU3DizhcCMsrOgEdL5JkqyxQSvlU?=
 =?us-ascii?Q?6rmfYNB9yLHAmCJfnH1s7G/MqeAhKv6xejxu2O11QOb7qvgv3qVVHvCoCGJf?=
 =?us-ascii?Q?Fav0lk08vXDDTzVJt34Ud0l/qm7zeUkTvB6C1UruWBoBRbLYDroFeZbAE4Hv?=
 =?us-ascii?Q?PFKtf+8vKitiXjY+kU1kwRtKjO32optPOawT9wK05bN8QTD+20NKBIzE4DXD?=
 =?us-ascii?Q?bezexRn3B5Ilmt4238+bhWyB/Ps2/NCjIKcqETmXI7VYK+KVq6PIOzX9ybTF?=
 =?us-ascii?Q?X9mNKuTeuQy8ZLn4XwWxU6g2cPnk2Eys2Y20j102Y0BtEaHy2JgYSZekukmh?=
 =?us-ascii?Q?4RVfhC9eJpsckWE/LFOpQUNABdqc6bTbgGhIpPgL5g78e8J3E5pbiVPx/8Eo?=
 =?us-ascii?Q?b5v/ELjH/qL3byTisZJ2mqCo+UGWE3MShi7MBWESj0AsiwG9a2beP8El1Hgn?=
 =?us-ascii?Q?0vkyoMf4yxVphgU4GwN6n/KQllnKa3llx1JN9r1N8AQQbiODhbtcZ42rV6rZ?=
 =?us-ascii?Q?LS1TrNilrvor3KgZjneZG2941u532pezpvYTHNSGrqYGA7TLa7SG+RydaC7P?=
 =?us-ascii?Q?fuR6ivSNaw71F1IXx05OXy9+FbfxSb/XZw51+2aAkfpbDmDHVMs8HEMBtP9k?=
 =?us-ascii?Q?WPIVwOyZk538VAq5qXJQ5Zk+8O54jytVYtYGWjHUjfPr0w9VrmgiPzVmpVHP?=
 =?us-ascii?Q?Zq8j1ZRHpjWioMKTQpND9EkzW4thbfVDmXgF3Ms0P7VjyfvqdmjYqH58j4WO?=
 =?us-ascii?Q?xnfZ8C6wEkWT28lnimviNEhia0QLDhzaRaQtuatJVJtM/GpWbLlbWC+7ts+A?=
 =?us-ascii?Q?rlLaahwpHl/K7L+oS3jwEcRQH5ycNt+wpxBa5Y450H1wy9azkV+nDfObprCb?=
 =?us-ascii?Q?Sc/0POZnMYyM+NngYsUp0RQ2rn6p+bGfnZUaojoBAhihqYkokvQIbhoq7KOx?=
 =?us-ascii?Q?KyQvZeUjXBAKTgxl3NVWvTPD6+rY1Vx5ntu0Tnv7Amg47ay2Jdw2wsRf+eXI?=
 =?us-ascii?Q?J8MZw5+P50XOX/aaFRGhfhZNza47JOVtTu3vugj/cUmti/cf8Jc91hgVdqxR?=
 =?us-ascii?Q?zm4G7OQXAI/S02cHRgpvuHrMQeul6du1X0eLbjtv3swL2+ZiIEohWviNsodn?=
 =?us-ascii?Q?mXWmW+6WemOzNUCoHDQ3i8Vde1OkTCMKPvmY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:49:42.3887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe4d417-ff64-4707-5e91-08dd997a8f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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

Move the KIQ ring test into the kiq lock, add
the missing ring_commit.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5ee2237d8ee8f..89311d8fe1f6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6868,10 +6868,8 @@ static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
 	gfx_v8_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -6881,6 +6879,7 @@ static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
 	gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
 	gfx_v8_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
+	amdgpu_ring_commit(ring);
 
 	return amdgpu_ring_test_ring(ring);
 }
-- 
2.49.0

