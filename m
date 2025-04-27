Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F9DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Apr 2025 07:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0315310E01F;
	Sun, 27 Apr 2025 07:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mSRjBDaZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773F010E01F
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Apr 2025 07:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEPI1IlqCRJfoDM8hk6kACwtHpVJjqNaoqZ0xXuLEwxJMvVKzHjYeMXe/Y6NEbUVv6Fn8NfVIGpYSb1K7wUiJJPHYpWkuAhWG0cChaBRAduHUFiVWO3RpmwkhHQgNNXA0vuwZ2kpuURaiy5kWHh/PnWS0YtXxzkGX0oM9OEKacvBGvQTTvzuiCpOcsEVgQSCNE6NT0gDfLw4MqhnHsYKUCr0bgkKTZ3yGwontfNvj41VNcJVpURX/MKniSmG9LyD6pjclGfuNa3A1T6A5WKHYS+ygT0QOR98fOwewvq3Ka19ZUf/b+9YPv7gD4H0lkC5WnQKp9Qst+w+juth/dK9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46yyEHyN4YQBeO2anUG7E+8CUahNWA5g4cD7UUWpyxQ=;
 b=K2MPbRxQ9X1v6/RAA+glLjWmn7ljHFk1+xOn3PBBgWrr1e1QZij0gQ2aJ2rT4WfqaxUKpeEE5e+YrCpwWvc/i7e7ji/8benMjXmi/6UTonka9T9Pa8RZQ5wJEW8Rt7JHaEXKOj2TKoG8SRbURfO32tulvIvist5DuDkG/cmKKJocXATG6sDCox3W9mWE8CaAXhtulnuxhUsM69rXBoG9fe3KyULr1pOQppWlcASf2hW5fR2xukI6q5oAkwlu64BNAugTQrtC2ZkxGYJVuSUY5QnKY9XcHOBuHpWcdfkvLArxS+bdFwh+TS2nCxfx421kckVhmtm2Id6ao6C93qUfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46yyEHyN4YQBeO2anUG7E+8CUahNWA5g4cD7UUWpyxQ=;
 b=mSRjBDaZxSrt34hUwTlhDXi/WU205hgfjH/Lp4WrRM/5xth5fYNsCTP2WqRgpgGhA3AWljZOQ3y4fbY4KskLK+WxOhCiX4cGZzfDv8mNSqhnj85e4DE7CYwpDjkRGpNeSxzawd/McU6BOxhfI8aPA7dEHivG5LxXbm9RQhnr/Ik=
Received: from BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Sun, 27 Apr
 2025 07:14:11 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::72) by BLAPR03CA0146.outlook.office365.com
 (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Sun,
 27 Apr 2025 07:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 27 Apr 2025 07:14:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Apr
 2025 02:14:09 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: don't sync the user queue eviction fence
Date: Sun, 27 Apr 2025 15:13:59 +0800
Message-ID: <20250427071401.4047874-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb0b5c0-6825-4607-b96f-08dd855b1bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cf7lbQ0lFyNAeISjT5X7MKdM9EWR17CEzz9EADzpYXjrSLBdlV6clV9vdJz0?=
 =?us-ascii?Q?L0qpX70i1EbLux4eg4QHMS2coGTRHAEVTmnATK/lwRqAEHO5PujmVhepmA3R?=
 =?us-ascii?Q?/iG7CB9kFoHe1KsVtYjXa7eSjmYJ/w6zowbJn6WOpcJFMhKYhU2uT2xGu9jY?=
 =?us-ascii?Q?rwTvAy2lwcAaWAIsPPvCmdSOeecOrGx1IUgmNirW8iuwnekwAEsj6bAw+9KN?=
 =?us-ascii?Q?3fgfOoHW7cuiPDsFfOHbW3oRhMEXXiDJ5lX37KFLB1H1u4qJjJel/gNOgeUI?=
 =?us-ascii?Q?DdCOZPkDu5zgS7/R5IyRsC93IVb5XheqXtr7fkg+pFTt4RSpahPRav6OgTLt?=
 =?us-ascii?Q?1xU9otUA2eTZbrKhVC7npl4Ay8jQ937/6DKxycbsNF7OxtvapZLauchcLznk?=
 =?us-ascii?Q?n0tasjtqUBNL4ZyI2bU6IBryJP61lvwZ5y7dggbEDqr3T6cccM6cLQwfCO/P?=
 =?us-ascii?Q?dk5pRT5iU1xITswPOUXEu/sT6oXui/pGsgjRO9fjPLO228CHyvRuoB/+STmA?=
 =?us-ascii?Q?nq3dnAbZyMVsmPNFtWknBb6HxV0kDKt5O1XBwDS5rY1N0rGROzh7d63Ak/17?=
 =?us-ascii?Q?uNBwaKTD7C84yXCBKqg3KYdbMXRXHdWP/3nEL0u6GJ/OjEgeGMuk5Nw6Wum5?=
 =?us-ascii?Q?KcGXmoRQjgyoTYtqDXknUUBpWHF68Cf2LT6KzdtBowh5mXuQed0Q901K3hLn?=
 =?us-ascii?Q?yvr2LYopJZdrnugJOoVHLX9F4KV/Viuwr30HrNnjhuHyIwwmWiHcBXAyZORi?=
 =?us-ascii?Q?oWy/iyKbMtIfkcUb1o73hzr9eiGItFnbG7r3F5aoHPV0zbA8lk1GzQzyVqyQ?=
 =?us-ascii?Q?E3ykVYtYvDp8EXKLdeT7uQoZ2TcmbhM+nlu11dY/OIusD/qPaHVizXbJyYT6?=
 =?us-ascii?Q?bZlhl1ZaZFVs4/OSHPyZJG3GnGmfauDjDZzW5Xi928t3i8amc7OFvIJM/pE4?=
 =?us-ascii?Q?F0wCUATIGYiKSfxDiR3zy2/4PV0I1IYx6glCdAQ/rjW3q1JpaZkLnULJ2y2B?=
 =?us-ascii?Q?KefBhXlA/JEPaOx1deEXqCswXK/Ucj+bgrG09vzb/umiTYLe7dWu8x8BY+FH?=
 =?us-ascii?Q?XI6hct7irdkqAs0omAqE8dTGIfidcj3tP4rSyGzvl6WKuAo3/ikXWVlOXEuu?=
 =?us-ascii?Q?r7dFLG7QPuEWK8xeXKh/tKFMUOq1/blv+aCD8aDZO6CcUCiCAZx8YDmAIiZB?=
 =?us-ascii?Q?3nzjQZ6Rp1DLj6d5Iunyykp4VHoOg1qN1UU9V6oc7/2ipZegpZhZU6ITOaku?=
 =?us-ascii?Q?1ccSSsLhr62TkoI4szlJ9UNCBcm6RJhe5f0vBF+vLW2e9SWe7Os+Hd0NX7US?=
 =?us-ascii?Q?iFRQB8WEkyBwt2mw9gBsi4YGWepwz76MAtZG9oIjzVT36SCSk8QAmHZ1/rkA?=
 =?us-ascii?Q?xXemrD/v/DyBdRGf8OCpmItMX+vzWLnMIWkTdJiMkcRk/mSPv4ACeSRVsnWI?=
 =?us-ascii?Q?3l5LhJl4hLVwch1NBYnOZ9tPauoChG/W1HlHVtfMLmX/DEXtr9NA41WhXg7J?=
 =?us-ascii?Q?cxqZzJGn9ZW6RIeHVysoY4QbyTzhZyLdodSM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 07:14:11.3445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb0b5c0-6825-4607-b96f-08dd855b1bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

Don't return and sync the user queue eviction fence;
otherwise, the eviction fence will be returned as a
dependent fence during VM update and refer to the fence
result in leakage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index d86e611a9ff4..6c9b2b43a929 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -224,6 +224,17 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
 	dma_fence_put(stub);
 }
 
+bool amdgpu_eviction_fence_valid(struct dma_fence *f)
+{
+
+	if(!f)
+		return false;
+	if (f->ops == &amdgpu_eviction_fence_ops)
+		return true;
+
+	return false;
+}
+
 int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
 {
 	/* This needs to be done one time per open */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..d4e1975cac71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -42,6 +42,7 @@ struct amdgpu_eviction_fence_mgr {
 };
 
 /* Eviction fence helper functions */
+bool amdgpu_eviction_fence_valid(struct dma_fence *f);
 struct amdgpu_eviction_fence *
 amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 5576ed0b508f..d22e6763bfb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -185,6 +185,10 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 {
 	void *fence_owner = amdgpu_sync_get_owner(f);
 
+	/* don't sync the kgd userq eviction fence*/
+	if(amdgpu_eviction_fence_valid(f))
+		return false;
+
 	/* Always sync to moves, no matter what */
 	if (fence_owner == AMDGPU_FENCE_OWNER_UNDEFINED)
 		return true;
-- 
2.34.1

