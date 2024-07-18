Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FC0C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FDA10E929;
	Thu, 18 Jul 2024 14:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="leKWkVYT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914B410E925
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQivJtI9IlKgjHJcoWGl4Z5NWr/eEYtaTexY5I4yQsgtTv4twjftyGFGZyPRDmTwA0XV2ScgQvfg2pvLUxJDqD/lORRN7+wan6x2pK/bd9wOWaMwskDzwi9h2blyK/LK3LcAFFC1ZmskOMEaFvLwup0qv8MUC+CK8ujmsSM7CRqAs09brsFpaeptl6JLhfbvqINPC1gD2QnepN5zftXurIFyylI/RQpU1ltDEiMIV7PPkwRDecn/9TJkzknrV6CyfL0GEwPMIWOZZi9BqA1ReeiPnpwRECm5e+aa6SdMp0jkubvIfhmQmyqFtuzLviaVlRmO7Wd/PE2FTIvgF+8aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE5ttyMV3JC4TN1AGK4NKa7g68221j5EvUD69soVLCM=;
 b=JaALbIsV68jxa7phbYeRoNb/4RFNbkVC3fG4tW4veEaWXexPpL0tHZj6ZeftsJA7c43Slcq2NeVheOyqSR+CX1fMGEGNI4uU4WP5gmwLHG3VTAEJ4bGHTlQzQpi2agMJapLq/nJFVQCq9rOkRDjTmdpiEV4Upikk66vEGQKjycOSS+PSz15e/1ArKTgn3QLvfibVFR+Ra3zUWZc+HlBjLaiNIoG9C66rXFE9+QpYs4o9eoQUbkEmAFk6sywdrcVeSNQL2P8q4OiOP0L7t33flz+QtCh+jDtIY3SXKHkewpq8pXd0aYlsryF2NSIMpy0KsPIaqQw5KvIg3Gxfi/cOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE5ttyMV3JC4TN1AGK4NKa7g68221j5EvUD69soVLCM=;
 b=leKWkVYTheMZ/wTNjqbDBDbCXJfnlP1JiD6R19kI9QfpL1zbcEvM1/QpMydZ5ddDF9um7fE0T1XXXOgeQsNWwQD3uahiLcYQS9YkkXSBim+RczI7YLSM7cJBEMMmfTu2/TLZZ3GtXPV+7Yj50G4iMX7bXAMVhOq7LNRniYcKSto=
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 14:24:04 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::6f) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Thu, 18 Jul 2024 14:24:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Thu, 18 Jul 2024 14:24:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:23:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/gfx11: per queue reset only on bare metal
Date: Thu, 18 Jul 2024 10:23:43 -0400
Message-ID: <20240718142344.1738604-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718142344.1738604-1-alexander.deucher@amd.com>
References: <20240718142344.1738604-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 92258dd1-5021-4155-c9d5-08dca735470e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5wkuDSZW3WR642u3Vy55nLLZC2nh9eKBUL1YKgoJeOAhp3DzTaWkK0J712eQ?=
 =?us-ascii?Q?eFGlhIsLgwtt7YfenYuKLwuM4xLdxd9F6H1IUxiDal98MZLgJ1/pRr6JhZEO?=
 =?us-ascii?Q?WRvyZXA2v6ntlHcGWpZENSUUhdsyGdTq0SUTO4EAmujPONC/mkrD3NeWt3D0?=
 =?us-ascii?Q?G+7icAPO4dESITVxsdGu0DtuKR1jhIjDgeuVkGAAov/4vQ2qo2dhtsfVlAXJ?=
 =?us-ascii?Q?BkdpZZy/kXnaINcBW+T9BeGwlIvcny5I/chQvjfeaMdLfJEdxN5ouHkbBef/?=
 =?us-ascii?Q?+EE4lWn/BAOqayOmB1MpEnM6lfEYpuf9VdB+Tni9Xrg/My8FZaYcBQfizcA3?=
 =?us-ascii?Q?bIjsppIaJF8itgzwEUie8it7IMoouQVdlcWyQyek3buOZ7bi91tUu+6mVZdR?=
 =?us-ascii?Q?q0qyfYO/RIgCf6vsYofn7i0BK6NeE/BRePwvZhtNBfSBZYP1sRl1ucVGzoNz?=
 =?us-ascii?Q?MXRkgnDJpfUaT/sZUf9xtHHK3TOYVPkTEZCfjZ7yHHqF9KyRd3/36pL9GpnN?=
 =?us-ascii?Q?HLpZ6GG8fpOO2EjW+6wjaozPWWNTfQIGNhhfOPSAHCTVta6oHrQW7t0RVXst?=
 =?us-ascii?Q?kzonRUJLhZuhfv/fYbBAOS8HxJ0ji2kufMyzL9OawxIPXfTaHpJX2FoD6Vcp?=
 =?us-ascii?Q?cZ1T86pBp8LXJqMlKJnNkyh+/GtuC47Mwmfgf1zWeilEDjJmwvWOioGsBlL4?=
 =?us-ascii?Q?gvkFxDXHhK6KNGv604dx5GmiUaNkNaVf4CiMtCwj18GQBGHEOKQU04NBzOrz?=
 =?us-ascii?Q?AwLubl3Eyd+ynO/c/ryGUUVEGho5RJaaM7IRlO9OAwz1S3+8AMxxmLRJnSWN?=
 =?us-ascii?Q?jfEi2ufFgYdYBH5I+mtJIIZQY9z+ynzuD6ALBWORa1yp84tL/RAPxF/1aU2k?=
 =?us-ascii?Q?Rhg9gvrdoNYCyWpySid46UMpILB7Tal4qmRxHU/FYjP0wbz7/SidB3JSAlox?=
 =?us-ascii?Q?kPYbaEEVoEX59vvvPnV7fts2kosEi80weQHljlQOvJ/JIyiZHRFJnprlbDWA?=
 =?us-ascii?Q?EXFZ+XGT8NuxzV2kqVUiQAc2CpwtjhXkQDXgKoXt7bVKRT+cMWwlKeYj2Xkm?=
 =?us-ascii?Q?7U15TdFfzPr+Wvyy5d2k97Oa1WKXqI3s49dOskkYqjZNFuMiKlFKXzf4Dfs0?=
 =?us-ascii?Q?NTy09LQlZ+IEQBwg8OQ0KcvGGTRMYzLoDDOwpgScohUVuTPQ5B+Fb7jsOhEy?=
 =?us-ascii?Q?kzHnn9pYrhPE1K2oplicwg6vuKmcmPzNmbbFTWNeCPs5iJZuQ99KPoabv1PB?=
 =?us-ascii?Q?8naYm2ILyHX3BVH51SXzAyaFFqJjSxmM/3rIUZqkPsohnnYw7YME2MY02CLq?=
 =?us-ascii?Q?HvQ4YPc7Twy+vsdOmWms5lhjBi7WShw9PR5bhnZyaxkRwNFX/qmXdzmpvHyx?=
 =?us-ascii?Q?6f66x1KQTT/KpliNRBwlFYdmHwhSJaNJ6Lx+9OgSa9kae+aitHWkHtU1RW1X?=
 =?us-ascii?Q?CMpPtrqCyCnLeZeGWX/npQ0a95niSwws?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:24:04.5462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92258dd1-5021-4155-c9d5-08dca735470e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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

It's not supported under SR-IOV at the moment.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 20be1b9ecdc3..021f7394b252 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6529,6 +6529,9 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r)
 		return r;
@@ -6564,6 +6567,9 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int i, r = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-- 
2.45.2

