Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63B3C3DA4A
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 16:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A1710E227;
	Sun, 13 Apr 2025 16:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vAZvXiQb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC1F10E225
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 16:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjLhiJZo4qtYbkwkVPVLI2uMJuWz1CU4Qd0FXDDNTjSydoTpOfHAkN1C7d9wxDgsFHbFXlkVQWC+oT3b/iYuw1pCr9Kj8dQoATQshCqMAwqU4P0TA/521hWsClLZie/EQsdfSMnxFIhWycYoKp+T8O/dZiHz6dMc2iQ37i3m5v7V7ahl0k0+gMVpQB+DjYqN09yVXwEhM54XAD5vOfJ+7lV+xkjtaPDcXGuU8VyCZLwmMtnbn+uIGTKVYHQXQhT4TA5eGa4d4PCZA81W8RNNj0JNEcCUB7Q8wdEqmcj3dMQlCV4GUwi8uqJB+Q63LcH+taMUZ+jShceqFuRGsZqZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbxlkL3EexKO6cmsTCXZcnTD04SAGnHOaYnBl0ofIhE=;
 b=KWWyt0XV44vWEL5xXLjhNr7g8Pu6B+9807zlayfLU5mJmdW3N3f4ycfTgE3EK26wqBD6KwDZx8M87iZ9JFJh+YZuNHQXlGYyX+B+qtLymFJHDdoeUPatKilxbgjWRah9devnNS39niARopwxfkLl502K6a/lyy8RWYYeOIP36m7ZXDxLzT4eomiIrmuBKl1DV0xycEXPG6hN1+oVSKIXeBjzLBjprCCIgqM+jSqsc0yGK1TJ0RFCqgvDxhjwx/ZhHnpMZcqUxwBTbAp6zwr7oBk05hg6Q1PqRW4Pv/EbA0/z1Q5JjCptXJSPGTQJXZJCbavWKs2T06R1IjJl82aHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbxlkL3EexKO6cmsTCXZcnTD04SAGnHOaYnBl0ofIhE=;
 b=vAZvXiQb0BAjCpg4aYIJu50gacR3naPcooPvIwe5s6lcGuKF7kQpjMhBcWsmJoDRt0cArJosTbtfCK+1NFhVBu0aR9t4AsnpYhq4cZnB/62Gxakrqq0EH6JebL60pJ7NPSm480WDzXMy8qCcFkPJBT8c0exQ0cLHDCcgYuMkzkM=
Received: from MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) by
 SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Sun, 13 Apr
 2025 16:06:22 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::cd) by MN2PR01CA0065.outlook.office365.com
 (2603:10b6:208:23f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Sun,
 13 Apr 2025 16:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 13 Apr 2025 16:06:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 11:06:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/gfx11: properly reference EOP interrupts for
 userqs
Date: Sun, 13 Apr 2025 12:06:05 -0400
Message-ID: <20250413160608.2198429-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a52adbb-72e1-4ed1-d580-08dd7aa52204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RVj6qN9h3naXyav89xvNqdbcbDbodipNpJGlvDmMEGavlCo99QNOQjyHy3Qz?=
 =?us-ascii?Q?LWq+K85ZgdMli5fQNbWyxy/ySmS0Zs1E7RxzsXfA/PTroYNszDxejeCSryUz?=
 =?us-ascii?Q?iB3/Wa7WlbgC08Eg7TApmt7joQFqcBsUihLtGpRtby+bS0TOS5uyy3AMvxia?=
 =?us-ascii?Q?DM+MnUS3IytOVB8Z8m2ozuW59UhdbxjrrmeCvKDRx/epafhTIJVyCxxz+BUP?=
 =?us-ascii?Q?T3IvNZyaOl9DzVvorZoUL8k8CdOdt/upuO5Bf7BtX2uiPaB0meqSOgteYM42?=
 =?us-ascii?Q?nxUlEGzA4WHEpFoMZdX3fLCdw1WWWU8iSw88JRSbxv3WfXhBl7hOcW9yVooo?=
 =?us-ascii?Q?lC2l/bKJOTb2WVTu+K1Cw0zlfD+CKy+y+gTvBPnvnXI5VVuqovVviYUuGsB8?=
 =?us-ascii?Q?c+pqfnGovDI/IiSTeHsOYoFg41eI+JYIfDb1vl/b9JqIpz1NqKietMWJpX/P?=
 =?us-ascii?Q?oE/VU+gLB6kAGeKe9/mfK55xguL5NlDQZFzo7fvMwJfw6TKgRKyHFSUGAZ+X?=
 =?us-ascii?Q?z3Faqh4Hoa7r8Pdpi6Z+yrQqx16i8aTNKFnp5XGMYyimdyPH53KcBVmVyBLp?=
 =?us-ascii?Q?CzpVzi4UtEJf2FsqWcWrM6kmeJulduNoiTMyEJ8k/KiHb9RCwoVnXj2FbNLv?=
 =?us-ascii?Q?qpVNmiJbkSsshgyyQ4tGxK+u9EuAv7+bDx/fGHOD4nwkQ8TPzeo3yOSdQC5/?=
 =?us-ascii?Q?LzTNGNYdvcJLZn3zMfH9xls4p6OphSh5IcsDnkdjQQDFNGbKyxoOL2qUVTIl?=
 =?us-ascii?Q?MExFMzVw2AAU3Y3v8X5dimfrTCYb1+NiTPmTfhQxveL+mnHof0rgMDv58CUp?=
 =?us-ascii?Q?Sq+TAbdDC+/g71h62jNkUNIurLMMb97cpq+WpCkre/Vh/GmTyd7dnoOd0RAe?=
 =?us-ascii?Q?7bQtpfJKjvjyhE9jS13Z6X09gpCAw2AgoZA+/c5ECjtPWmXVJ6yaiAYN2Pn5?=
 =?us-ascii?Q?HpkwRJ18dFLorIIzGiKtMmk0Zcij0zHRy6R/6eb0EjjbeNtNcX8nqDmwfYqn?=
 =?us-ascii?Q?0sG5h3mqoL3R3PwOTwlpFikomHrpYZaVZZL9LAUij41t2RQubS+P+hyhSlLI?=
 =?us-ascii?Q?H7ks7HZomjU/1viPdXAUNwQuWl6b8hyfYwpL+Lkifq3eaGX2jA88WHYR2af0?=
 =?us-ascii?Q?T9EREFd8hLYPqtHgVox3umpTod/fe7hVcJhfH9Oi58434W3je/dWQXbV1kKb?=
 =?us-ascii?Q?l/TtXOSHlKtgMBNEcKokf7+quZvGIhIixt4u8tjyGUEQbiRyXRZOmW9XNAXh?=
 =?us-ascii?Q?QRyC9go8CMhvzBbxOfBDijRSxNZWvyOkEw4I8go5eAP4O4whW3aAusg2uNCe?=
 =?us-ascii?Q?zBQBcVKh7C3hUUnf1QZNmDJX4nL5Fkku97GtLx3Lk/kNj7DFfqLe10nNc1Kt?=
 =?us-ascii?Q?pVD8W6PyxB9gwOshnhYwi6q11c0RceyVbE2lCe5GwULU+AaNzkvyIOWdagoy?=
 =?us-ascii?Q?XOK7JAkxlGGj7s9ZQiJAHy3lhKwZv0IkjIQ3UooMuyrV6s5/MLYojGkSSfqB?=
 =?us-ascii?Q?tTUVLUe/adHeBZUPhZITLPtvuiZEh6k688te?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2025 16:06:21.4944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a52adbb-72e1-4ed1-d580-08dd7aa52204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921
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

Regardless of whether we disable kernel queues, we need
to take an extra reference to the pipe interrupts for
user queues to make sure they stay enabled in case we
disable them for kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7274334ecd6fa..40d3c05326c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 					      bool enable)
 {
-	if (adev->gfx.disable_kq) {
-		unsigned int irq_type;
-		int m, p, r;
+	unsigned int irq_type;
+	int m, p, r;
 
+	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
 		for (m = 0; m < adev->gfx.me.num_me; m++) {
 			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
 				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
@@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 					return r;
 			}
 		}
+	}
 
+	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
 		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
 			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
 				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
 			}
 		}
 	}
+
 	return 0;
 }
 
-- 
2.49.0

