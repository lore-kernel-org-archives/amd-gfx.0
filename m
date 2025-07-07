Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6737DC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A2110E524;
	Mon,  7 Jul 2025 19:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T8ZR41YB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4CF10E51F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtrceqegBKStGmwFLCJCqxpTOc8N8WveZzrL+vuhYDXXsV/pNoHX1uc1Lk2Re5BdBpNrQ+jdzOw28DaJAWaXJzoqcydCznKuvEGpdZLYN+3/0hW/n3iqB2EvZSEmRHteVTGd/ZohZbbf31DA7xe832xHR6PPV2o8d8o/8WupGjTRzweIzTTZGhRzGh+UWQuOMufppt53MbDxztkzsztThTGNysZd0nvMumSmjttL8n99UpWcCjNRP6N9mpNx0yXiqs1OFjmY9q0DGfGRpx/KdblWNaaxaAtvNTOeDNaK9nwlFCF3E9V3Mv1UZ7BDkFdB9eKS+oqjmrvyiYdg0zM4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vgNjvvUEkIDl+cxPo2+AYcipnIXUH6fo2aHpitLSuc=;
 b=keIsagRTtId/vc9zkHZgVmJ35KtWCOu7i/wlQscuCq4kuGdekwTPfpepuNfs8kIgkzybuEB1m5moA1bQjnHT+uT5HzKNEVYLGzHf7pXhPCi+rdWCgCxcS0AkifrYoGYjZiSJPfclBdIayntHIeoBJzZCLbJtctt2GhtnMK8rj6oIr8RmFTgPGOpCzRJ2Im3pB0/yklFdaNBb1OA4cDhPVgbUoLDLuhbFOEYdFsG2CHpbMl9NgKqpM7vfoWICC29KmdamIgl/Wzsc2ORiRHZU4A82OwsKzR0htgcsg1NXSQ5SZKxQy/qhLwgV2+1zKkqzHW5wo4GQ2vLMgTI5iEr2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vgNjvvUEkIDl+cxPo2+AYcipnIXUH6fo2aHpitLSuc=;
 b=T8ZR41YBcvsrpiC92VzRRd6BdrIwRO4zyuD4IYkTtzGHZlRKUCXSLjaC7Tu0NnQf5MVRDeonNmSG7I6GLfgfYx+kulf1YkF1GnlSqrl1nqhm9U7Xj1FZT5T2c/6XRvoNSJOUiyA6/d5hhcFW7zWUHPCKSnl1/dpwhquIbSuyH1M=
Received: from PH7P221CA0090.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::25)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:17 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::38) by PH7P221CA0090.outlook.office365.com
 (2603:10b6:510:328::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 08/36] drm/amdgpu/vcn4: add additional ring reset error
 checking
Date: Mon, 7 Jul 2025 15:03:27 -0400
Message-ID: <20250707190355.837891-9-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c0456d-8f30-469e-7474-08ddbd891204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sjh79D4ZoLOqVG42HRLpqUq8P7W7RqTmoUjd/hNUb3vgJFzUkbN+RLSV5QFX?=
 =?us-ascii?Q?xc6Z62aakFOF3rKzaPQbWmbOtZlQLBWeNWEWXgPgujLJ/O6qASt98t2ql64e?=
 =?us-ascii?Q?d5Qzq4Zil/i0XFRizOJ1+/idYdqyhChp8acHtrwVnbJOwSbfNa8+2neL7tJ6?=
 =?us-ascii?Q?eOmItU2NGrwpEniPci8nY2t0/WUhpyVkz4m+tjV6WopqgXiIhPUmWDT5tmTI?=
 =?us-ascii?Q?1QoIjLZbKMCyEUr2kGYVIRBm2lXUs9vjmKGCp7VOy6xNGZc5Y9WIn8kp8K4t?=
 =?us-ascii?Q?3ZnlTnlUn6kNfGui45LKXtrVNxqpT1hh+2VjR5OdVou/ZBSAD5jTT6t7ZqSZ?=
 =?us-ascii?Q?oXgod+Ayw32359E+tZp9QaW2r6btHcX0mvdn79p7E3fWLI8hCz0KA5IFjtwc?=
 =?us-ascii?Q?kihBHfpehdy9DlF94++6m/FXiPjwoP7KvGzjLJ9IkadMUJF1FkutPPF9s9Tu?=
 =?us-ascii?Q?IaDz16oTD1mnoSzq2eJbqYHDJgM2Y7DrTDwqvTdJe53++iuWM7rJJvi73QRv?=
 =?us-ascii?Q?ITMOeylDAa2NTUHF4qIjvNwA6+GF622xvCHIHPImVY6ppkmgaymTsUIq++ew?=
 =?us-ascii?Q?jXaj4vGkgRsVKEkkK9YAojLEpWZ2tqWZjSRGDyOasTKZo6/zoUhLIYyWwIza?=
 =?us-ascii?Q?4tsVI7gKQslef0j4F2bu4LKDdrEdEc0EJNSwqBA5CQu53WdA2Uo1t0DZJza7?=
 =?us-ascii?Q?p02UoLD5/pC4BSpxCKkn5F+HorUfi/xdKXTrU2WtGAobKHJIqyTo+h4ovtTf?=
 =?us-ascii?Q?Pg0yTgRuHJDruGzX18RYGxPSx0gGG5TCvw+9FrAeSfywaVzza3amfYU/ft6U?=
 =?us-ascii?Q?1daTwBxa6aYk6vBY2g3WaSrpCnByMGe2ZpdDmopbXJhcA+msYnsOpdVm06nI?=
 =?us-ascii?Q?QxM7qhyIOiSA/ni+KXB4JodLUwlkyKPVL+fclJpqny64DlVnXFxsyxI0Eobt?=
 =?us-ascii?Q?vVcih4wdFUTGQBgq303vPaX8aLamWlCvJG3Tv0M2mb4TOm6YdQn41UymjZl7?=
 =?us-ascii?Q?NDkOaJaKbaYzfP0/1rldB1GXAmH/Xno9GAcyQ1tENALD6Di0zFgzTXyUUMjA?=
 =?us-ascii?Q?dyLC8ufDYpCxpgYzbqG9cds7Yw9/wxN3NbrGsAxPfHtF371c3XdkLbSKnXvc?=
 =?us-ascii?Q?JdOkC3fYIw4KgcPoNFdlqAzV3mpM8z/EyGK0/Zu7FME59dGqdDKKmR5iKYsP?=
 =?us-ascii?Q?29ZKxuLxLW7wtjdAW1xpCimB1hD5DIRrNAdyFEuufdM9c/V063rDEk6agYOJ?=
 =?us-ascii?Q?2ooDk+99F6sOSHhmlbCnpd7XLIp/PakPFxIxDUYVWMPzXjXb3DsL27vYCIh4?=
 =?us-ascii?Q?n6N8ag3wuZLHbCoWxTMaB+ihN4x2xw4hC0ceXsoyCeYOGttp8Xj3NoW65p8T?=
 =?us-ascii?Q?yuR3HApucDinwapMzxo+/AHPZgTPzYRQDdUJWJsjgQIye2ymohb0GNLlUf1E?=
 =?us-ascii?Q?1fLmqbJkTmtKn0GBx2fqwI4oy51wXYvlsL+fzTVPVWPCFHCT6jYmG3B1c+a1?=
 =?us-ascii?Q?zj/9SMmqlCnQ/XREAjqbPg4slKsqgBT7shQG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:16.6037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c0456d-8f30-469e-7474-08ddbd891204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077
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

Fixes: b8b6e6f1654d ("drm/amd: Add per-ring reset for vcn v4.0.0 use")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index eec9133e1b2c4..5bbce8544fef0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1979,8 +1979,12 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 		return -EOPNOTSUPP;
 
 	drm_sched_wqueue_stop(&ring->sched);
-	vcn_v4_0_stop(vinst);
-	vcn_v4_0_start(vinst);
+	r = vcn_v4_0_stop(vinst);
+	if (r)
+		return r;
+	r = vcn_v4_0_start(vinst);
+	if (r)
+		return r;
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-- 
2.50.0

