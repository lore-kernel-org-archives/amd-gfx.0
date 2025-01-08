Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C47BE77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 22:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D132F10ECAA;
	Wed,  8 Jan 2025 22:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oE+blq9/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C4810ECAD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 22:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7ETDNlZm1sYx//27wXqTJKZLb+bbp0FLR6/qsAWiyZLviwi5VqUafze9RL5Pddnte5rYYuOPKByCUAmkgDt4urWjCHGgroafzvJ/bZie8hrZhcNcj1eAHikYQiVPm3MrgLsPj0h91avRkv3cnbFF74zCzd0fhIdjqxbwct9dNZgtTaya7R5t408MkN813Ucns1AKgEHIHp/9DZRMLxqxXaXs+NIpNpDBmxtq9dQeCXDfSOBn18/yjLQd9EIAy4OW6LkK9LgKGRkuN5dvq3sEmDkakrkjKNgiqskCCIdnWr5c9fbM1GOm7Kir2CTXCo19W5Gn5MNeIP7mtlpXiOx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKEyKyR0SLv3jZ7+mDjHRrG/mvuXhUr/9bS8vAliDNE=;
 b=pGvF64Ip//fgS+KfxT5zEaGnQm53apMgjk/8orikUQb2kz0SYD2L8xo9Ciyb0I4eAGC0SmP4KA6gwwCkpX2sH/w63mvQe/N636aMvJ9oY0/pUjNaxDwj2nqQcP12F6Z8u1PeQqgx58k0+3i+pyFW+L7WveaVuiDHEI1sp+qWzGYVCuavkpj7OuaAzmLA/xVAD2+FUjp9QuyB9pXYVR/kVYpnN6CtlUy9C2ypgFvqHVQc2mZlCu4l2gwG0uLYxoKi0nmPq+74XJbvBdD2iHztVl64OjfIOtFTvSElaN8Mg5VE2XRN8IN9Fl8ip5YjQCSThtKK6VXvz4l8ymVsXrsKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKEyKyR0SLv3jZ7+mDjHRrG/mvuXhUr/9bS8vAliDNE=;
 b=oE+blq9/SBe8PFnUF/w+h60fLPW8NKL5Ne1CeyxlIdCBo+Cl9Z+3FekssfOwCjQYFbeQgMUhgSFmY1rff/vfM4AQRMYeh0JzBFi6AP4GoY9NWZGs7Q+15e1guvXmO+NvAwguNCiHHi6R+JBPFIu+onT05L0uXecLw8OuxvLQXeY=
Received: from PH3PEPF00004099.namprd05.prod.outlook.com (2603:10b6:518:1::45)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 22:56:49 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH3PEPF00004099.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 22:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 22:56:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 16:56:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <kenneth.feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add dynamic workload profile switching for
 gfx12
Date: Wed, 8 Jan 2025 17:56:26 -0500
Message-ID: <20250108225627.14063-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108225627.14063-1-alexander.deucher@amd.com>
References: <20250108225627.14063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d74cc7-9865-4399-05bd-08dd3037bb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s3C1Jww9i/ewe0PTKR60bQ2aAupEKRMakCgUi2h8XuhxF36uO0dZdPtc4QD4?=
 =?us-ascii?Q?wj+o6CweA40w4Hesr38xECxGzf84ADT6V26xxuxOx1Q9RarjnEiq0LrPe3iu?=
 =?us-ascii?Q?2FASupvAMUIZnBPk2GNDk54kWbe+e+0PP653AoNeipCbWYbfg+JTMrgd9vMF?=
 =?us-ascii?Q?EtOq2kMNrJg/FcWC4dAAksdF786NNBgbfX5NzvGNN8XE0Dsd5FHd8ftTljf7?=
 =?us-ascii?Q?y8auPwUrEAjvDdbdUl0OGXqXauBaeSyYjX8C6/2jrSpzf3aVmIjZuEVD4NkY?=
 =?us-ascii?Q?mok0wvxsJu/GbNDqi+D8vpmClnxULchYALcmSrA7T0pTpVosKCa2UJTjZ/Ho?=
 =?us-ascii?Q?VpF+ydoCvEC+zItVlE/hdSLtctOHWUKVwOsbUEKdLUuhJuJt+cUG4i5+DCIG?=
 =?us-ascii?Q?6OaLwcY6/AwBoDZy8cWNXEYBvQiRNrsQ51xdil4egQd2JzV5+tpcFYDA7Cl+?=
 =?us-ascii?Q?zvZqwLARHlMPpNLTlYhBgDZBuAcvKqqlHhnOyqf4OJ0FzpKtjK8AmUUYqKbU?=
 =?us-ascii?Q?UuFde6bHCAsAkBOyGngDJr4C1JBYuach3+Nt2v6KqQhVzv9PTpxYCAfMfqHP?=
 =?us-ascii?Q?7uJOEontCV3LCmLlNPmMXCFOYdTIX7l5VAiFd7QPhg4wjb6OhmpR9WZYIsmk?=
 =?us-ascii?Q?JkxNeT6fjD/MYbTc6ezoaEqvB+fyKExnq3MD8tael9xVBKNFyQeSfHYjBKrj?=
 =?us-ascii?Q?dyq9Nq9U4gFL1JoNTvD3L7uCiM/WFC4gh9uOnV5texKVbHZFI+qD4akeJx58?=
 =?us-ascii?Q?npLFiC+zGsElzLZ0TxN0TKcINJX+0oi38fxtHR8Z2OgAwqbcdqMJXTIThu+2?=
 =?us-ascii?Q?uABlcUwxWsgaiwhYEJqbUbcxEtgGNk+F6D6RB2yZ0VsstM79kkR5pwP0KYI5?=
 =?us-ascii?Q?7QbRqrNGQ/7g94tsDxe73YFXYiK7fwFKw7KOYE0euEDc1m++Jp3vdcyJfSxF?=
 =?us-ascii?Q?F01dVMA3sy4caUOi1fTv7AIFGv8mQdOLe/vjBS9sqeHHiMuCom3LgQbJvjKL?=
 =?us-ascii?Q?emBbIuSr3gLzPmPRuH5cCdzpLvypFNogvcGOLhrXqPsTtvET21wtZdg35Eo9?=
 =?us-ascii?Q?OWU0+W50clWImbabNC10GjFZe/cwnRtGL9nmKqArG9AwmWYY25BxgRehDbtZ?=
 =?us-ascii?Q?HS9zMiisMTT/Xhk+Oo0m76zUbdzrhJnYh3Y/IoVwWDw95OgWYU3uNhLNy6Q2?=
 =?us-ascii?Q?Cv8xXZgIfHI4AhjuVbBq3MljkQYVDA+zqFSzJKIxZCsl2o7rZ+OnnydzE/O+?=
 =?us-ascii?Q?OYwS1s+kcxxuM1bpiAI5bG4SyTdeNRwe/A3bCVy8MJb869b+7V3VYWsc9kuf?=
 =?us-ascii?Q?Q5iuVo/1TSBFV0IIIhG7Y6XH0Qo9DvynpJgh+TDMwQbhnNUTC0AynNs+LEIf?=
 =?us-ascii?Q?Vug9rNU4yF3pQf9hDYHSpj19R+7s398SYAKitHxhgVnLa84ZgEauNITwAxLd?=
 =?us-ascii?Q?iAx1Zz6iQcUzVIvX2P5S//YNr+qZECiLKcuwPS8GnnDpnoubzpiUgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:56:48.1233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d74cc7-9865-4399-05bd-08dd3037bb77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646
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

Enable dynamic workload profile switching for gfx12.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 3aa34c55554d1..9720e8fe46572 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1362,6 +1362,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
+	INIT_DELAYED_WORK(&adev->gfx.idle_work, amdgpu_gfx_profile_idle_work_handler);
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
@@ -3676,6 +3678,8 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	uint32_t tmp;
 
+	cancel_delayed_work_sync(&adev->gfx.idle_work);
+
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
@@ -5317,6 +5321,20 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	return amdgpu_ring_test_ring(ring);
 }
 
+static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_profile_ring_begin_use(ring);
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+}
+
+static void gfx_v12_0_ring_end_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_profile_ring_end_use(ring);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+}
+
 static const struct amd_ip_funcs gfx_v12_0_ip_funcs = {
 	.name = "gfx_v12_0",
 	.early_init = gfx_v12_0_early_init,
@@ -5382,8 +5400,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v12_0_ring_begin_use,
+	.end_use = gfx_v12_0_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
@@ -5421,8 +5439,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v12_0_ring_begin_use,
+	.end_use = gfx_v12_0_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
-- 
2.47.1

