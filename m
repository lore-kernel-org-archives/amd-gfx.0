Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A00CC83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE4610E525;
	Mon,  7 Jul 2025 19:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P5Tv6Gz0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A13310E512
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4+iGw6xOnbd/t5IdfUQWHFB9rzr3fsU9iexm+koSrriNp4XlZp6n7RVStOshlbH4iJ2CEf5HmymLTiMsmGwAKS+6pHBduAVAxdjfAppm7Mfw/TK7zaCnoIriwP0o0bw1lFdDC04RHClp/K0M/YizYdIqavwYn6B0hOCa5wanj3lSCYQi+Kg+dDlOupraORkdcmr3/9zRAEnx2+POMzGgFez1810bcjherMAgoaXIo7QaYWqSYcT+PRT5ASNNDu4CXLqM+khPOht3iBZcP3zljF54cNroJfiY7hvEMcop7lVIkJ60D/j0LjBBKszr/ccOTg+KV4aZkS5Zas4r/0Epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF+2fswAksQbSs8fLFO+ZxA1V/WImXxmkf9S0MA/Am0=;
 b=chMvpptZxvjZKwoWZl1vTbC5scTmp9IDXLfusjtNLgMXas2C8n7FcVGc+sRAG198/fYgAG+s6Vs4rlE9NQBqOKm3E4JkTcoIulc9R6btT33BOrgEORtX+GyEZbZEiXvG6gYlnJLaf3a8gAC4t6YHhDSM4/+F4LpN7+5TWlmzj+8+OVw161CGBOYY+Vxekmm8fmiYz6jZ3wpyOwL1QXHi/slWD7XAUpKTbpAMVWxcFzHlhWUZ6VsH4CzoJQPa+kBwEiBAzQFvRkIV/xhX4dpAO+tA1c5eo96NhGcHGo4voXYUpQz2fvbKwZNgcMwuAELGZLY8292I/xblmE0h/Xdy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF+2fswAksQbSs8fLFO+ZxA1V/WImXxmkf9S0MA/Am0=;
 b=P5Tv6Gz0w7B76g9NsJefT28net74x5JoPdU3Kskhlen0nCIeNY0WFwsmCoqi/xKq+DHz9IwSF94Vls2yUTMdoYfK2udeaJeLXdVeflfvkyOzVlasMvyuJZNIwBtHm5Alq/QwE6vOIiMPUp23yZ30jDoYCr2iMXzk/rgkUxjFx8I=
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:04:12 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::5f) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 03/36] drm/amdgpu/gfx10: fix kiq locking in KCQ reset
Date: Mon, 7 Jul 2025 15:03:22 -0400
Message-ID: <20250707190355.837891-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 8675c735-e2b3-42ee-64f2-08ddbd890f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bcfj4DbdtnnwMF8AGy4C76WVxwcG+s7rl/nkC3Ty6WfXdDhTWjoLKhWh74LT?=
 =?us-ascii?Q?sEE5EzPXN42AwQ+NVkuoH+QVnufSMjSpf1k6v5kViFsIBPkR2xY8pUOwpluN?=
 =?us-ascii?Q?RvWtOHyy55sl+jxZx3h5FafMZ+mIQehLvEJTLmxcGb5lotVHWaMwwH6tGvzx?=
 =?us-ascii?Q?Hg3wr/pz86sZv5VrLGxEA/CvsK9GsjWUXWQ+lQidxuqIPTexMZq6ssZsEaDf?=
 =?us-ascii?Q?4uXuMRG3aFOGlH3/L0V5VV4P0P+X5BzYMQ+HuFOkZACMmrDbChfvv7Bnwlte?=
 =?us-ascii?Q?c5ZZ6QqrXJiA+ckFFpQZvRgeqsxKrJATzspc+WvlVYs/TjJa2nXLdGQ/wolq?=
 =?us-ascii?Q?gJPQveLjYnQ+cKprU2uPO6epayxUTaFJkiEoH5+y2xZrc1PJsh+g4QSOCBMg?=
 =?us-ascii?Q?TlVuFQxyv/xdHui86ySjxIZhgSKEuimKWJUMde9Lr3GYHoCBW2qA9Gq+m9Kb?=
 =?us-ascii?Q?SCCH6qcM/iKIwiTism0lrhdg9YwvCFi+zDVhIf9TvrVm+A6JY1lTv52hFw/P?=
 =?us-ascii?Q?YiOt7SwXDk1fWQRP/bN6weEgWbG/PEH2PLu9TgvomNENDomxDvYbPeE0ro5T?=
 =?us-ascii?Q?0Pn+bkRLmXwBmSOcsrApIr9zoNkvmX4tCU6VfChG73NQLoFxZjJI62fFC054?=
 =?us-ascii?Q?ggIz8fLMnIjG+VBYcSWyrTFAqYdgmjMwf4vRrIya35SIiXMfAfa9z9CeOkYg?=
 =?us-ascii?Q?U2DQaCu+gSywjHe47/PcKbrovkoQcwxCtWEsbbcbadgmeoAeTKTEEfSyHGzh?=
 =?us-ascii?Q?e8duc+1ODwS9uP4n8C9PQdNXIpf5l59GQqqbUjxElFoqE+UgTTj+N70wWrnG?=
 =?us-ascii?Q?mDKPvYryqx1/UpbHxzcMG8sL8TJczi+11CzrfksseCpG2e43KCQzDqjcAabI?=
 =?us-ascii?Q?86gVrh/CcY6qn4Yhb+ttp99wYZsVLA+PbzfnAzSo+XpytujMA8vX6vovvziR?=
 =?us-ascii?Q?Vr9xUlFyTLlInt9X2ZnlxNjxeJqTgkzxwCmOoIpsEoMEm0yUYDkopqaJleBZ?=
 =?us-ascii?Q?qQDSCtY3hr7MDtmsJ9n5+IWmvMMkOrVo1Dm6AwtagfcZSp1aQFdwzXelsP/l?=
 =?us-ascii?Q?fUfq5qFXi0Y++Vfhk94Zxg3wGC4GV5tA3RbepfBj35bcw5ZRcYHEIZVBXWNt?=
 =?us-ascii?Q?VqxUDC0WyGVYqJeT64QXNyEAlUio5Lsdll2GVv8MKO1dCHSwHgb0QrHggZIK?=
 =?us-ascii?Q?vFauUbNrJItawNcVvr83KXNEhwd3wbX0mbVBeIOZW2Z/bs0eOPF7h3j56Faf?=
 =?us-ascii?Q?PY5jkbSdv3KX05NYhdXMsmSOkXwHHgY84FvkZ2sgm9uriRTs3cVT5S4Ykyhv?=
 =?us-ascii?Q?0Tz9Ojf9CjvqUDyhWqB551aNjN+f3rJfetg+eXnjmIX4B5b1sPkM9BleNPXz?=
 =?us-ascii?Q?PMwn/6s2eWhc0ar3FSS/QCJe4UMeB96EmOuluNDsFCAKmc53bizoDrP7hBs0?=
 =?us-ascii?Q?y3draWPR263jOBg9PZbTBko5p1lcpi/U9uIHTlahw36i28OWEMnBrNwavHM6?=
 =?us-ascii?Q?trF6VcuiKdTja1R4IVP6mO2zQt9T30nd2Kdu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:11.5919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8675c735-e2b3-42ee-64f2-08ddbd890f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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

The ring test needs to be inside the lock.

Fixes: 097af47d3cfb ("drm/amdgpu/gfx10: wait for reset done before remap")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5e099b5dc9a3c..d739bfb20383e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9625,9 +9625,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9663,9 +9662,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-- 
2.50.0

