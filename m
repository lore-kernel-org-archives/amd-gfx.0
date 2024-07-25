Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DADFC52D54
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3642510E863;
	Thu, 25 Jul 2024 15:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jpFyW+w6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF2F10E851
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ea4T6p8h7CqNLc98h3anTQFph3E1qk/yOyWLQrSa4xlrJCYwoEA9BCl6PmGGVoJyqa1m8vowTffWW3YqL7iNbbwLUAjPOjR9c25OiB3Uf8HdDVzYfstqJ1LKn6nV2A3g06O+rQfqKl2htKssYQBNyjn0PJPxHIRFidAFYe0mBmQ5bR988tq016l8Kw5Cx+j2fdSP1AezQogHmoRGDUBCY4WeGXPgnMyYQsVW61lZZp7VSRvUowgUrI3Oazxz4Bj9OFFw2x1a8ozoZt8Nr1f97x9gzwsaRxPwrdabDKWKVBgwbeRltetkeqcjqb7ou5jbF09aVs1auLp0F6KXHrS+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VfL2uB+kfZKMuPEIEBjfwIUJp90L4l+bT8X2I9BQgs=;
 b=opK9N5iav9qJmlPFz6XJ+4sNpDz4KL4laNTCY8rZi9gRFq64Mt7lV8f+AA9mixo8JtyfN+RNCsDor5WiyUFkOEXNH6AW1r5Mb5ZiVt/cumsWb/2H9XsBXmrMl5Obbzco94tzESnB9aWcYa5IkUBfH7e0Mg6pCtm8kE3O6Bj504y0VRlwhc+gyRBSrDPJQ7IYttgzQ12dClrtTbUZT8RvOrR3cLj/0soU6qZ1CexeZVbaIXhyFO01ytXHLRsPSjzXTxLeu2sQZK1JGngeFOf8/cLrhTo3VxQHHEvQLyQjw8V8tW1Hn5Eavdo8gjwFmKeyR3/3SSrIEF5Vuy8gaZm+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VfL2uB+kfZKMuPEIEBjfwIUJp90L4l+bT8X2I9BQgs=;
 b=jpFyW+w638MYLAu7uygGSU4e2FeD5sC5v2l6p42uw352GgmgIEhvQH3Sz2aUp8s9moNzXBwIE3WHI2kFd6vkx6kuK37CYzeqL0Gcw4LjL3j6v93CNA8fHee5HJP7z60k/5XITGXBuosjf5TWQSb7RpnfnRKf8Zmx/SbI7fDrllg=
Received: from PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::26)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 15:01:25 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::fa) by PH7P220CA0039.outlook.office365.com
 (2603:10b6:510:32b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/53] drm/amdgpu/gfx12: add ring reset callbacks
Date: Thu, 25 Jul 2024 11:00:28 -0400
Message-ID: <20240725150055.1991893-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: d35c908c-07d2-4cb6-5383-08dcacbaa77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vuibmZfBnEe2CiO7IaCFrxv6TImXnv0psSvHw/2ZD9GzeU3UQk1nq2Up6Kd3?=
 =?us-ascii?Q?6hFc93nqcFZInRIgrBBH+UZOL84pl8W0brG8gtMa2ErnGM4TYQQ8QQJ6CAKW?=
 =?us-ascii?Q?e5vWpntbDSsJuru4tD2J0QCWivB0/pdyX6sLw+v5nfypeCB0xMcuQd4Bftf9?=
 =?us-ascii?Q?VLC1XUfuylZuo8h7QD+Hdq8kdSiQzrxjm9XFY4bMRzy84Jsip8fGLQflRuMN?=
 =?us-ascii?Q?e5XVp3V34/jFKxCMb6H41B1iOF0RZLEz88JhG1oFbXZoRE2E3At7KfqeV91a?=
 =?us-ascii?Q?TUYyARRhfTW6o6bQNi3KML4ivu7wW6EFmNoyrksujJicyIR4tNgnLFudzXc/?=
 =?us-ascii?Q?CVZlV3Z6+TBXTLO93uKDzGz7CWYhxCVVP1XjOKPVH28xMCX7aPDc18RXEXh0?=
 =?us-ascii?Q?+MbxJxZ0ViH9SJBfmxqUOh42lVNrb6NjiM154hraGWjg2n6e2QA5e6iZtK72?=
 =?us-ascii?Q?T58r0+92BYrd7l5KDANLSW8hP5ha/2yBrfMPRcYGcQU5V5WfrR/rAOjLNNA6?=
 =?us-ascii?Q?1ZX4a0+XHJkITROW00bvDUhe8gqltAH3LfprJaCryE5wg99PMg+xUn/eI92o?=
 =?us-ascii?Q?54FaVoytj4l+p0QhNjxKHK87d73NI9vyKCqdAhLC8LLs4FjuAtOJmB25sZVr?=
 =?us-ascii?Q?rUtZ/cVUsihXp8zc6fHu7KScNJ3ivu5OYKkzGtHgblXF40xOqp3sbFbYfpIK?=
 =?us-ascii?Q?glXXssMKsDFcPXov5439Y/xCyY/Bkw2I335AfE0F8DYdWs7fjCi6BNpitu3J?=
 =?us-ascii?Q?OR9t9Lxu0oYHOxs/0DnlbCXIC8wMEPuZJbosYrU2sDyK1na4mxcr1v+GlMib?=
 =?us-ascii?Q?Atbjuebq8WWlNXEn5P8aPuOwRd118ceurLyEVVIYcnVOgZLItXqiLhG0711n?=
 =?us-ascii?Q?DRs3ZzTN190FyAnvg+jDOpB8sfVJKS8oSZXbj/e5RucaQ89Craf+Pp1voQ3c?=
 =?us-ascii?Q?iySIUc6nI39YYX8obrGOWuTN2OdQM9COXaoIG0KK0t0U3lxW9atZavg2ti1u?=
 =?us-ascii?Q?bmJ+81OhpOud8hQhYW8EZxhzPPZzQiGmOhvvdmKBZ0XFZToGsHB+gp2Zz9Pj?=
 =?us-ascii?Q?L5ccheR6F3mHy9bxJMonc4b35pzyh+tYwR5ifXPvqZSwSOmI7AAXECwWTeGL?=
 =?us-ascii?Q?5mQN0Uy2UaoPyTuxyaaFbieTR89bZnUzNTDKec0m8u3/jM4lmFn5tSZjXWTX?=
 =?us-ascii?Q?fq1yH0MR4QLq9g5S6ox57H1eTtRDERQUnVRQJysfXlDfizOJQZD3GTNiVuuQ?=
 =?us-ascii?Q?HmJdt+FaODMMNay4bTEldyntuiVlPz707s0gcNTp0L5/iQgoO3MMfwlQPzhj?=
 =?us-ascii?Q?fMw4nr7rjDF7/9ONpcXHBWDeidM/zmugZyXXE17NnSVx+V31Q519Vp1FXbN5?=
 =?us-ascii?Q?ExQ5FZdoSJEAlRdbN36arv38sOEJ0mvgkuPgb8l61nxx4Hb/6HwAKIZHwUSQ?=
 =?us-ascii?Q?Fs+KlMe368no681u5a3ZKtrknlqpBP0G?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:25.2289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35c908c-07d2-4cb6-5383-08dcacbaa77b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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

Add ring reset callbacks for gfx and compute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f932c7ff85e3..790b8d471d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5135,6 +5135,22 @@ static void gfx_v12_ip_dump(void *handle)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static int gfx_v12_0_reset_ring(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	int r;
+
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
+	if (r)
+		return r;
+
+	/* reset the ring */
+	ring->wptr = 0;
+	*ring->wptr_cpu_addr = 0;
+	amdgpu_ring_clear_ring(ring);
+
+	return amdgpu_ring_test_ring(ring);
+}
+
 static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.name = "gfx_v12_0",
 	.early_init = gfx_v12_0_early_init,
@@ -5197,6 +5213,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
+	.reset = gfx_v12_0_reset_ring,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
@@ -5231,6 +5248,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
+	.reset = gfx_v12_0_reset_ring,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
-- 
2.45.2

