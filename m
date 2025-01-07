Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7DBE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64AD110EB26;
	Tue,  7 Jan 2025 15:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PibcdD+P";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4727F10EB22
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHuFLkU97F6cf6Iew58JC1cyDglKpy5GNXxKXccxOQb0LUXTRPujyd+ueZcQjUtk1tGg1DpDbmbR9m2D3kYJIUdkfBVKij+oqdptaWnsNRU90EeOpDRD2YYlZxZ8PGv+2Sw69ooKyBhTtmSRF8RgbyB7aVo+igTkgyMGeIJyHHIpxhkXWqCCCzkGzJnz22BeLn9/v9d8Y0Fes5a3Q2uwJqWZJxWpGiQNET9cIjES+nqVsV5rsDW4NE68d1iMPsY5ZEoXrGcHhzVKsdwxcKF+86f7JrFK/hcfJN/I6ClO+clyro1X7ZjI3GL/UHG/x1iOIUULzSIVZ7WMxzSygr3lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQMG3YR8xlVG/hw8ysaQP/VOx5CayJSWrCdeESu+Acg=;
 b=K3oDQrllz8jDPZZm7qyG73mXqICQj1iNFFMs6IxGj+MUIJa7JQOh+KcBXamQpDSkjYzFN5MU40yoiNCocuWj86A9teZcuoBG5NvMgHXcIRDTMda/casCa8GYrmKabewqoq/FY+CWJtlmjuiNOWrvuhLkuPFVp8FGPb9IKR8GkkRhpvXVxxQFL4qGXllDNg8Jf2Qdcy9FFyfszU6Kl+BYxWWpCf2fHvH7gFQehcc+656PUFMvr813QxaWIiwklCXhY/NTReIYM6gIBxIZmxYshUaHJu6qPXrwGN5a7f8As2XAJ5V2RWXhI+sBu8KzHrP9j0kP7B5EjGQglcqRBOUTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQMG3YR8xlVG/hw8ysaQP/VOx5CayJSWrCdeESu+Acg=;
 b=PibcdD+PfxAlIyHN+1j7IdZTC6bJjibwkI3u9gsIylzoUoAF/5gx9izL/aWbVCQNbqezSkeVHsgJv9qDYjPp8r4kMCKrzlgNnJpzT1Wh0onbXB97fXoR0nH8j7r7QCc1RQIy8F6ifsvSRG9b788rU0hJtt8s9PvnMVTbASLT+vU=
Received: from BN9PR03CA0291.namprd03.prod.outlook.com (2603:10b6:408:f5::26)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:30:41 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::5b) by BN9PR03CA0291.outlook.office365.com
 (2603:10b6:408:f5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.16 via Frontend Transport; Tue,
 7 Jan 2025 15:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:39 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:37 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 20/24] drm/amd/display: Use HW lock mgr for PSR1
Date: Tue, 7 Jan 2025 23:28:51 +0800
Message-ID: <20250107152855.2953302-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bd8dc1-f76f-4e40-8eac-08dd2f303e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y1lU+/Onsmg0/MNN6dYAuB+ebDrJTWKXpFph4KvLI/g6EXjVGNKaDP+dSqMh?=
 =?us-ascii?Q?RBzxqOHZv+Uy1yVJID3w0LbQaxEOfU6syfaAdPUvfYRWh5X6PGMDZ/Iz4Clu?=
 =?us-ascii?Q?lYPGH1+aUp1/V7Or0PUu3SKkYiGnkrLKll7LPwufa9YF2L27mKCHuhSTxjwl?=
 =?us-ascii?Q?nONzIQ/L7iUb4YEgNDx9LDqhz1b84dyO7t45UPs0Jf1ym6lxvM4fB/jKUipx?=
 =?us-ascii?Q?vyynIqJRjrHttRWZW06KVHlTdfa63EM9z6E6iCsV1V1jcd009PWCafqH1iHA?=
 =?us-ascii?Q?jk3SX7Q8RO92KJsKzSf+2MH5NGRJYsrKQplUSOp1j1JVRTQ846z/a8LJhHV6?=
 =?us-ascii?Q?IgfPq30erfPijRjzhoqj4CJxbevx7ay36sBkcGM4jAMmPuiE3HmRt6ee3pQ+?=
 =?us-ascii?Q?HMIAcjFrS2pxTBZi9MUW3VQyZ4pRUjn9YN4H8vDd1HyZTBFMIlP9C35zuJUL?=
 =?us-ascii?Q?jgMeRiQWzxdmdPCHN3zuQEAR3GyqQ5kakSS9RvtBVHCz4sMFqC/8zJDk6GUt?=
 =?us-ascii?Q?noZxCTC5b1FPvMoH/8nViFNOxwcfjkz+we4DEBvdNrXI5r+wAg0YiSpxaPw2?=
 =?us-ascii?Q?FuZKNEAOmgEHhepzPbzHS0BrKvgJz3aahK3GgfKf9oyZt5Na5Jtsce5z4e7Q?=
 =?us-ascii?Q?arVfwdVYXVY7c8cTxUzz4kJPXLwCJuD7SoVMoYeDB7/aD8rSQzexrUqOUqn7?=
 =?us-ascii?Q?tftJ0jH97JqH19BsH3AxYg9yKvsxcWQfnixCgSpMZWssbbK84WTT8Dzg8AJN?=
 =?us-ascii?Q?da8b5mDRDzBgcAw/For5x2Jfi7iDRwzOUDrlZFwPL0MbHIba7kmveoURkPLt?=
 =?us-ascii?Q?EkZj1daOzVNiY4b88OM3H4fjSfBJYVBE1qK5LjWYuChDesDvaYgiM1lm7F4X?=
 =?us-ascii?Q?Y6N3oGToD/y0R9/noqTLbhAnZIikENXSDtoY33z/kFh1NgpdBi1PLW/+6M8O?=
 =?us-ascii?Q?TD5Ex+NFb1Z1ATLmNcPnr4aVgyr00uIUQNNCQ+WgzQ1Jje2wJ0zN5pI9nfuV?=
 =?us-ascii?Q?TqY9XVoah5r17KVQM2QfXNMFkRZz6rr7nqjqdlduTOXJikIXwEJ48YU8ZYkQ?=
 =?us-ascii?Q?7R2IhwE0NWrP3UbXpUW1QkvAT3s5gaSlvdSvuZ2XbA6TrESP14OXFgjYO1wj?=
 =?us-ascii?Q?R2oIb7FxwjpcpLVfI4qHOVNXW/XmFO6ADOC/w2THBgDSd8L3NmlNPpfa75X1?=
 =?us-ascii?Q?yLt9nOwnO0ZZD8JMvuahzK1ej8EfnvDKZMGvBu3HLaZTYPlT/7e6B+a6U0D9?=
 =?us-ascii?Q?X8iwCyuE5J45dv6RyY0qq/x8Lnai7ZJLPPJ07kLMdMz6VR2v93zG8ZV7FyzF?=
 =?us-ascii?Q?qfiBujGdbXI4nh4Iw7y3FpJWv0hOlc37ouT0huvrGNoNYJaAvgM4UqblH+oH?=
 =?us-ascii?Q?elMcE7Jiw461ZuGRDLRL/25loPS8+q0iPGEP4QwrmsHYP6U3mfZoUByG9QNl?=
 =?us-ascii?Q?GkZeWHSiyi0q2+Jbzh15QtTsrbvIdr7lQd2tVvViOEuzUyKu6j8Itlv9Wp3T?=
 =?us-ascii?Q?btjrLx1imLIbsps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:40.7173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bd8dc1-f76f-4e40-8eac-08dd2f303e5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
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

[Why]
Without the dmub hw lock, it may cause the lock timeout issue
while do modeset on PSR1 eDP panel.

[How]
Allow dmub hw lock for PSR1.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index bf636b28e3e1..5bb8b78bf250 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -63,7 +63,8 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 
 bool should_use_dmub_lock(struct dc_link *link)
 {
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1 ||
+	    link->psr_settings.psr_version == DC_PSR_VERSION_1)
 		return true;
 
 	if (link->replay_settings.replay_feature_enabled)
-- 
2.34.1

