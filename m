Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ECAC021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0061410E584;
	Tue, 25 Feb 2025 06:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sXZoD0dQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C14810E584
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSZpigcWpVvztkbR1h135HFyAtKA+6PCw2VpQIEzUEH9GUdr2bWH+lv8vuIgO6pw/sWLVQ+Yme4FB+hc8P61fhwQN20S+opG2wY6MkhzFAiZjuYET7P8Is29Yrvi6JmGa5nWIiQNc2K9BCNEgnw8C4MTsyvDTCd15zodbmoifs2v/UKLFwVhmJoFlHWbLNVSe7xUrTLH5uJx8eIgJ/qRzgNhgfXZ6Mzer7LVkczYKArVIAe10M6PAy67sE7d3XUmUqAKO/S3xZeIM4YD6WhhDqG/sMfR7TYucOBn9qWFKPPosizAHxZfEfEUZmtGHulr7wohGmNLMxqpde5tyweCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7E3lRd7Lk4SoAx3Sk8ymHE30l8DGQFq1m2z7vF2ULU=;
 b=fJbnfoADZCmnipmikNcrrcfO0Clwy5oTcmiLzckoEKSj9qNxLDHXGm3waaTWLLOVRkhxikoP4hvnaC8v1jZkjcF1wVh0mK5m8o9Uj0LfkwVNot67HSvCxHrFC/+O6jax9yqOeQBMg9ORbPVjM4ibEPf1oPFYI+qfo916PJltYtEIuOZNCelu8+fnt0w2fcrI9X31mbyfsYCXfOjAmYuR+Ny6NyOE5R2HVa58sb7/XZcyQobyQH3QwA6CsLso+ABM+/HZxzQBros5I3mcfZ5vUlw+5ye4KnaNhKUmweLsWkeuhtgg/VTVnymxvDxls6M1HEphfbdWM/5ozlNW0s3WmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7E3lRd7Lk4SoAx3Sk8ymHE30l8DGQFq1m2z7vF2ULU=;
 b=sXZoD0dQDDEplrYr73D/ID5vHDvE9wg6UKj+rFSfSTJ3/khgmUR5a4Q8DOU2DUy1C/gA5h2Dat/JXByo6qrjPeVhxxzSibqQo1tjVfaRvys7IDpbiV/Xx8D7j58I7xC3/LjYmpi2WmffufFA7WEBYuoyYtAqc2nC2nYgyyOvLnE=
Received: from BN1PR14CA0026.namprd14.prod.outlook.com (2603:10b6:408:e3::31)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:38:13 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::10) by BN1PR14CA0026.outlook.office365.com
 (2603:10b6:408:e3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:12 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:11 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:07 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 20/27] drm/amd/display: Change amdgpu_dm_irq_resume_*() to use
 drm_dbg()
Date: Tue, 25 Feb 2025 14:36:03 +0800
Message-ID: <20250225063610.631461-21-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eceaf12-96d1-4c0a-fe2c-08dd5566f9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fsDQkAAx5EsAug2sdUTNe7owYqBHlPGgllL8HlU0efCT6OWV/XsjTjTXx9wa?=
 =?us-ascii?Q?RzYjkB3kgsLcnrSpOexO2NmExEh3hXMrShDxB4GUTKUtrvItKdUrPxJLHq6V?=
 =?us-ascii?Q?wnoPyTXPhduiKPWWkdHxyTkWIxnH0AERQjPceIAvFDX6pdNKVGX/GxlY4TvS?=
 =?us-ascii?Q?BT9ZAzJUYU3QQ6XLG+VC23LtpwMcJJE9NbePxr60W4y+xCRYTkYoZFS5VYVq?=
 =?us-ascii?Q?0iL2fI9HAOwzxkW5FAQ9vPoWFPDvWa2ZLyx8FGGGKcwPC0JOaSisAOzKSK4W?=
 =?us-ascii?Q?5+fxyBkgLDkpaY8h2zxNnKU0tG0BQnDkKi3ToC7o5r+AHTK7AB9btVhikXAE?=
 =?us-ascii?Q?+uZIbFFqDUbvlTRa1RQ1hL8jC28bTYPvLas0Rw1g1LtofwTXnigDiDAk/uaa?=
 =?us-ascii?Q?XUo72U0upIMugr32ge8s6RW+n8l2hTGE1s8MN1wx1z6RQydvEZ66E7Bcwkwy?=
 =?us-ascii?Q?RwzA+LL7hV8wxMs9SV/qnmId6bUA+0m3K9MA/S7F8TwsZac8GyW92LySjmps?=
 =?us-ascii?Q?ifmBnfxq1KBwQddR9hPKTJiZ0QkI5FydQQs6xqsJClXDuO6aQw5a31rbyazA?=
 =?us-ascii?Q?rcKv/3bdUPF3EtrGxVgR2n6TRgdG0SnsfmfkEyAkwdXRb2FexuU8rmV1/sq3?=
 =?us-ascii?Q?Cv/imYCyRogZlYnnv+AZb8F+d1VdDbgugqAvFj9DFlc4CpV9h8DRzQdJ880x?=
 =?us-ascii?Q?CoEWv9d5yMiiE4Nsg5DRh8AWnKHBihkXIZRI5R3c40HlTrnHRiwHih5Y4Ebe?=
 =?us-ascii?Q?pFT0fbR9NmduNVrLOYTSuFDUbm+/ZX470H2mHZRdsBj5DUqEfcNPYmpoegls?=
 =?us-ascii?Q?RZSlpSOtHZz9Aa7KD3BMbkheMoINYLP9zKYGcOzhfXtVFhqL8CIgFd/piJmt?=
 =?us-ascii?Q?ULENpT7WACeD9Og2yt2MWTlM6Zbmetv8JzQ/w3jRfoda9oTNJ+tz7Dgt/4cq?=
 =?us-ascii?Q?q4nrDQkDEDzn6rvthehZv6ECOFLXPXfm2CBZpR2n5OQf4nRfKrUXmEQ2LGyZ?=
 =?us-ascii?Q?pybyfq4+1ERxhserV3lLVQXCl+Nd3NY0qgh9AamAN9rDH5+X+SESVc8KBh29?=
 =?us-ascii?Q?vCdX+5Hil6MI4rvfsalq7xFpxs3yDj59SCmABGwMqQCuA5AmD7npraXYC0DG?=
 =?us-ascii?Q?iT+9SIFjY1nrXJevVItHZHXYyeyuutAUhGY2mtVjq7u9HwpIZBIU98OSb2X6?=
 =?us-ascii?Q?Wb5tFKgMj04IJgXNXYqML8zPffoDVo13aOon+tGpK8fLA8YZGIeeDO1fj6tV?=
 =?us-ascii?Q?HqmWbX5InH9GXME+W3u9HjJbds2BKeqIcnEDcyGl5o9q0zSy4NEkZm7KC0yg?=
 =?us-ascii?Q?lib36FL0Q3MZbBgd3GM6qF4so1PQKLoceslhAscSMTmi3uG/63FtP3ASNL66?=
 =?us-ascii?Q?yf0lXj0yvssgVl8zuaFZHEHpgb52cJFYbh7wR2uaEs7dgadOtLsXq/7RtktQ?=
 =?us-ascii?Q?3JQgL+nX5DICcPcO1J58wqjxY5n9AtsOSdCA6pvt8hU5TEkBwg5A3xinVV4B?=
 =?us-ascii?Q?1BX+VHHsDn45WaI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:12.4264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eceaf12-96d1-4c0a-fe2c-08dd5566f9f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
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

From: Mario Limonciello <mario.limonciello@amd.com>

drm_dbg() is helpful to show which device had the debug statement.
Adjust to using this instead for debug messages.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 34cd39488ad0..adbbc43adde8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -521,7 +521,7 @@ int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 
 	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 
-	DRM_DEBUG_KMS("DM_IRQ: early resume\n");
+	drm_dbg(adev_to_drm(adev), "DM_IRQ: early resume\n");
 
 	/* re-enable short pulse interrupts HW interrupt */
 	for (src = DC_IRQ_SOURCE_HPD1RX; src <= DC_IRQ_SOURCE_HPD6RX; src++) {
@@ -544,7 +544,7 @@ int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 
 	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 
-	DRM_DEBUG_KMS("DM_IRQ: resume\n");
+	drm_dbg(adev_to_drm(adev), "DM_IRQ: resume\n");
 
 	/**
 	 * Renable HW interrupt  for HPD and only since FLIP and VBLANK
-- 
2.37.3

