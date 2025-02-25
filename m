Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEBAC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAE110E56B;
	Tue, 25 Feb 2025 06:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DeeTJwvk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF81710E56C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EupiNBI9Xw9znBmT8M2VkoajJsjoP8RQ+s29dHgnhVom713BbtEzuVgmuBKJexHrCiuD92aRWtSXA7GTuCYjZWRBHYoalAoi2Q+Pl9SA7udwGvdFonTau4OaLluf4WCMuq+pn1LGZ1cnLyzvzEV2CFVvC8kK0vXuyJmRhV5+6Y7pzoI8nIrytyTql8jBHkieGcj1NLvnMwNG+HYSOJpbOjenAyr1v41H6y/IsitZP728Yoc8UVO9ksXsLydixvf1X0oWLyoYDUwm/RCnl4t7KkbN4ixOS+XGdkKJFnsyr+s+XYOWpidfjnvoLE3tGX+AzWrsKM3awr/QCYL1O+ClIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqQrlD1/5IoQIfcvl3tAPivefOrXb2Pxn+5hNYLkDhA=;
 b=fLC7svMU5pY4/nst1r40wnS9Sb9L/GaMsd9EfgjofPldQ2XNtKW1zwgUkgzHYGl7KffZzdwl+RSyQgiJv3Dc03RhrNrKLqk+fYLiuamxVEY9laHtGq5EJcyUeWkMEWqAlFrdNrx/0BDN0aJUlN8a0TSzfhVGWtsZl4x81uDAPeLZRgJYDLR74990iuF5KeEYjSRu2TZ3iFtqOg0bwT+MULyeZfWxSf/jvnwTW5Qf49Pvridf8VehEsMMyQuNo0Au7NnSh7Ke/kzm7tEHMjGKLT1gnWOBi5CPY4o4ygWJIWyuDdm2+4sQKw7EwcrunipYlMGJov/E06n/vdNWFZc0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqQrlD1/5IoQIfcvl3tAPivefOrXb2Pxn+5hNYLkDhA=;
 b=DeeTJwvksmgkghFaedjVWvKwD/n1rtysOANG94ksHxHltFUKL5fuEzxHQc4in82FKPhXuHmZZVCjNaJnjabvVSnT3k0aU7EhWMF71/vKQ8rsYu/YqrUlmoSJkHq11L1JRnGlYXlKWrf5x4fnShSGCKHxZQDPBjk93hlA9vzg0A0=
Received: from BN9PR03CA0565.namprd03.prod.outlook.com (2603:10b6:408:138::30)
 by PH7PR12MB7187.namprd12.prod.outlook.com (2603:10b6:510:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:37:52 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::1f) by BN9PR03CA0565.outlook.office365.com
 (2603:10b6:408:138::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:51 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:47 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 16/27] drm/amd/display: Catch failures for
 amdgpu_dm_commit_zero_streams()
Date: Tue, 25 Feb 2025 14:35:59 +0800
Message-ID: <20250225063610.631461-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH7PR12MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e97c96-9002-452d-add6-08dd5566ee19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rIWbdxuAN9jNJsiYYcBD8OoVhxgIQ7LvHfHwR1L/Xiv4WpidJr+B969QGvOx?=
 =?us-ascii?Q?7DQLwwJ7ecamKQ/bpb6QzWJLkEtZX3ZR2edrESSDhs6HohF4QPzu3mo9lpeG?=
 =?us-ascii?Q?AeIWL0Kc+0D52R+J4ohGNxzl/9IreyGP2VAP0ouwQrt4CjT9DWJqpUUL/RBQ?=
 =?us-ascii?Q?MbhIyQrSb5P66dSr6MOYIN6CGmBcjrt90VLIERWwnpcMGjaj6A6a7vAtd6nr?=
 =?us-ascii?Q?QfceJkTXJml9ImzW8yywWnl1Vf0rTnZ8497cPSzelbM92Ah0yVv/Ghjk0LMH?=
 =?us-ascii?Q?OcPdnLtDxZuLSBaLuyYzzIocTEgvEjGn19saCp/elgL8xYSQnXVwtYSdJ/4H?=
 =?us-ascii?Q?KAlVowSq04hsORBIYgnJtnupQbe9s2g/TqEP3r3verh3dMntNK76uJ2gA+XS?=
 =?us-ascii?Q?/Gk8MiIoU8+CE5RcgOfl6aoDDYqetW/fv1BaVD9iD7Zth+AVktovjhay9Lfa?=
 =?us-ascii?Q?rSaKTmAsFhz+JlZU37f3lyWp3lze99FNLpTGxpqhL0ImFbvXpR/yEGhJcxAn?=
 =?us-ascii?Q?oSqF5rpPVsjknXzEBIc3/i4TjsMCSP57g3tiQFsPQV4DbOh4PP3Krc1qnkiZ?=
 =?us-ascii?Q?F+gp73qog5Z5TutQ9Jf9N6AEhEzHqKc30xmei6f3raVVN6zLkNKRnEp/DUE/?=
 =?us-ascii?Q?c45WK8DGsbIAmclulie9/ODu9QG8JHzbpoKy+ztkcziX2DMBVC5DgQsx66a7?=
 =?us-ascii?Q?Ix9Iytw43mxCytLkbEPz+tz/H8RYatrQPNObQ43nKmj7hDgjvyMYyGH0+Um0?=
 =?us-ascii?Q?yJzyfxEnOz3FEoBr7ehxIjuaAK95KtS/I5/Oxb+q43X7vafI1c9h6BfYKjci?=
 =?us-ascii?Q?jklrYzgSSk+lAynDLv/aXqUxN990SEF7Zp2XUqnTn84USAsK9aQVnxEWphdb?=
 =?us-ascii?Q?7PjAZRq41gUR776goixV7u5lbAG8Y3J8nfmR1EE5ZdipPdj1VtFoM7V7xxiR?=
 =?us-ascii?Q?Y69Xj/Ld6G0FHjYVXfjD0nltL+Nktz3GxID6nKrrM3lzboa53+RIMOgOeY4M?=
 =?us-ascii?Q?QzLcUo6DAjqX2tt7sHYq8bPaBLhN5qA5Bpla0LsOnRaQgxF+4FMmFejd5q17?=
 =?us-ascii?Q?UJU7A519/zHy2GKc0qZevBFGdc2gYZ/6uJDRW1RilbFvuBKHNsG/Yvck7pK2?=
 =?us-ascii?Q?mb2X+Wkq8Tp9f1nfbIBjuDzml2HZoSA40r6lpDjCEswLVzQT2PRmcoOKrcDQ?=
 =?us-ascii?Q?HEWVVE8govbfyoEt8GSOpg08Fg8muf50MEmQvojejBFD1+VTn+N8P6YeZQ1w?=
 =?us-ascii?Q?puaFa+zgPrGlRX5s5/zlbVX3bRIMHUnTwBy7cLMuUgV1zcvGpXK9RDFQxBQd?=
 =?us-ascii?Q?rHd2CcVNvFCe6r4QoZBdcLF+qne4a5gNZTjWsnSATllmPnTD19NxfHsh3gcO?=
 =?us-ascii?Q?BJpSsQcpQda/K3iTpLs/au07miYMYB4iAScZP6d9Z+q/gfbSb2pNMYqLOwyd?=
 =?us-ascii?Q?qEgbYDUUt0P77APmwqtOm02ffPaw+BGJzx1hcFWY4g2c5QloHQ4APg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:52.5639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e97c96-9002-452d-add6-08dd5566ee19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7187
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

amdgpu_dm_commit_zero_streams() returns a DC error code that isn't
checked. Add an explicit check to this and fail dm_suspend() if it
is not DC_OK.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6473622e2bf8..fbeb3e89675b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3144,6 +3144,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 	if (amdgpu_in_reset(adev)) {
+		enum dc_status res;
+
 		mutex_lock(&dm->dc_lock);
 
 		dc_allow_idle_optimizations(adev->dm.dc, false);
@@ -3153,7 +3155,11 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		if (dm->cached_dc_state)
 			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
-		amdgpu_dm_commit_zero_streams(dm->dc);
+		res = amdgpu_dm_commit_zero_streams(dm->dc);
+		if (res != DC_OK) {
+			drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res);
+			return -EINVAL;
+		}
 
 		amdgpu_dm_irq_suspend(adev);
 
-- 
2.37.3

