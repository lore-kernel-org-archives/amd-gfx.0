Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0F8C71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B98910E533;
	Mon,  7 Jul 2025 19:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JBMHgXB3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D2910E536
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l16rk9zBaRNobTShR5TMJMdoWQh4GaNmlhHNdpWUP1AGGm9Z4f7SgIGxAxs+0T7idg2oMzRYy+SlCu0rvoJfiHgqhpdcPzN0CRj2e0x5412/jP7b7qOeRmCq3GT1phmmKAgPSGbsObQr1WAE+ncpbw2TAZUQoZAI5V89dEfsqVdpd/6t2q7UtECroBoq4Q+2qeS85x72OaZ2lbT4S2kxgbEDnSkH7ge7GdhHVzvDykwnDn/7BIQKyUCN092FwmU3arocxXuYCaJzLafCIcL5ycnITtsAliRzgKkFrec0pcpJRbJMOmq+5RMQRW+rZe0W4zFGfgjkzAPvAzo8L3EIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wtuyqs799HdBuenFF7jL5ULxlKjfVNhFjRmZYy+hQlo=;
 b=EG4LV73Lgueu5i+bjePRZZsdCUAcGEIlMRWJJSTI/IWlaJon2Jot7LHyIqfkW4EQ7usQ7TBubdHtk9QbOmAYaNMfM4sKdMzyIEUua+iNcQX2xSCvUOyJ1ZVnnH2/TCcP7q3B7bqgdWNdFdED9bq+BWVnGsD2sm9q8RFr34GFKFyb1IxiyrDbehF0/sI92X86IlZuArZG99j7TLPx/AmnCO64mav/GP5kuDEBLYQz79KLdLMasUGVPtbImx3zSE3bOTUDPZelJ7ymEoEWiugeDGdCMJw58fJJyFTgbjUozeTatTowWGAJr09lVZO4qcwJF7d5RX3iuGBs4fX7C3B8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wtuyqs799HdBuenFF7jL5ULxlKjfVNhFjRmZYy+hQlo=;
 b=JBMHgXB37ONEIM8rrHuJJNeDX3MKM9LSt05tVzl7egBEezCsKCUX+Rsjrta3Vd8zAu2trWr2rxYMdzT7kUzSWkkg4fIMLOaLr2ZS2a/dUFJ5EsCYO6s1Uu4i2dvOypjNgFBEfwuxH8nWn4N1JPwplmCnbH4S+ujozj7WLCjx70c=
Received: from DM6PR11CA0027.namprd11.prod.outlook.com (2603:10b6:5:190::40)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 19:04:17 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::23) by DM6PR11CA0027.outlook.office365.com
 (2603:10b6:5:190::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 09/36] drm/amdgpu/vcn4.0.5: add additional ring reset error
 checking
Date: Mon, 7 Jul 2025 15:03:28 -0400
Message-ID: <20250707190355.837891-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d599848-32d2-49da-84f2-08ddbd891224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fGqG4n8cn9+bKnCHRCqXWR/WcbFrtOVfjBzphhIJCZHhgq1P9kCDSULCr3+8?=
 =?us-ascii?Q?gFx4vPbrmJWqcpU7WHmM8GGD1o8o0V5+/Yxi4BSrGiEz4to06QhjEKGQ6iGh?=
 =?us-ascii?Q?AGbpXZQcJ+lF+601BD0tJedn5afaF8vfB8gCtxh7+nwOFEDVng+u3kWwpTlH?=
 =?us-ascii?Q?D8N3KEG6k3efTwCdH63pJQs+HFhs3LNkLITnAUyR5AmOL63r44uXvs7ea51I?=
 =?us-ascii?Q?QDAl77eE7RMw1BytamTp9q6daJRsQE5sUarK4ES2ucmzx7Lvyx45kZzcxNYV?=
 =?us-ascii?Q?2RDLWaQc1dWWutIM1Jk3huVvuB5lTQgg7eXRHfa9FNB9iurDP0vUyqgEpKBS?=
 =?us-ascii?Q?WzzygVK6R7o3cJZnJkfbv8sCGL/5QoTKDfOweXJx7Y0whrQkTchJ5jzpWAx8?=
 =?us-ascii?Q?0aUEfk8RnPEik7XkrnRqiZ+St2CY8iIfjc2BQFCTTyDJWcSAIk6usxY3StdY?=
 =?us-ascii?Q?Dev/GgXTUwNVaQvsV6tRHuesnlDaXdFEQ1wjk7qaInaa6i2T8GprVAxLERlI?=
 =?us-ascii?Q?Yt9o+sd3U5fWkEQIL7CNFD1Gj7jOeDi1g+9muvpqaiMeGr7ZY5gsLDOw21oU?=
 =?us-ascii?Q?KoD3AaSXzKqgieGM+TdhIzEXwX8L2xjo+FnyMRsj+5hrpMJ6G7L4xQCLviDl?=
 =?us-ascii?Q?unpcNQexezcizxooH3UPuG2krCu0ue+XLxM4dozx3vyLGEFRCJZGEB1DUBAh?=
 =?us-ascii?Q?pGphmjRcRBrTzcZ8lG4eiH0SOsnHBAi1Xx+C7s2mJ91SilNkshMEp6bIycxv?=
 =?us-ascii?Q?p0S4Y7CJuEPXVKya6XJxomoWPH+qCYH762Kh0/fNqLAuhERCEqV0OsptKy+j?=
 =?us-ascii?Q?reqMTlI8lX55EPLpn9UFoTbf2CB+GMnr5fE11oRKKpoSWRVLzB43TDemEGrc?=
 =?us-ascii?Q?ABP1UVC1SqovMimp++JjbNIuOqbWVyuINQ3CbmzEZc1uGyBh/aKEYSm3rqlq?=
 =?us-ascii?Q?34f0mkru0CytmJFAQaLJeLm+d7iydpUCXRENMnOrcg18e3gv4MsuAvM3YGos?=
 =?us-ascii?Q?w0TyVdFS09ZSZ8WrDXQE8ziKpZ9SAlRi+PKYfCdu/vWLVMS7pdyu9XlXTF3u?=
 =?us-ascii?Q?3oNUphMW0BDoud8Jl4RdtLoan9XsSsEdD3/PFqlzLwrSnk/z2ez0gXhDAGJ0?=
 =?us-ascii?Q?KHgYFjOHa6+0DfYi4VFI16NLKuVmrv+lspA1x37rYTB/inTkBsQcqorwxsdz?=
 =?us-ascii?Q?N6HV3ec2LUuGdIBAqAtfirFlykb08MUIPsijC7VREPoYDDCh7tfmJVKLl8bB?=
 =?us-ascii?Q?BXBrL9RPW+SpfGFOv90LZQ7KzS222VG011usBNlwgdTzND921GPowg/ueA0c?=
 =?us-ascii?Q?s9YCYHqE17ASEtR2/OBaQy99lruTZwU0oe3WwQTqJKXiZkJ8HbNA7omG/0I7?=
 =?us-ascii?Q?iz7mvyvk2hAC29ELGtdqF++z0zEI7A586n02eDo5erJocVAoNBLquiI01EKV?=
 =?us-ascii?Q?5w9GeRIG6hgKQdlDQQ7HTns76tx4MDioPAXRf9HzaWfERsAcgaQcx8KZM/MY?=
 =?us-ascii?Q?kdSMuvdQdVVx7diafjzgRsM4gkQifeIV8Vhs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:16.8145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d599848-32d2-49da-84f2-08ddbd891224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

Start and stop can fail, so add checks.

Fixes: d1a46cdd0053 ("drm/amd: Add per-ring reset for vcn v4.0.5 use")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 7e37ddea63550..6000c528ad6ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1477,8 +1477,12 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 		return -EOPNOTSUPP;
 
 	drm_sched_wqueue_stop(&ring->sched);
-	vcn_v4_0_5_stop(vinst);
-	vcn_v4_0_5_start(vinst);
+	r = vcn_v4_0_5_stop(vinst);
+	if (r)
+		return r;
+	r = vcn_v4_0_5_start(vinst);
+	if (r)
+		return r;
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-- 
2.50.0

