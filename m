Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D7C021A9
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 15:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D8C10ECBA;
	Fri, 14 Feb 2025 15:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pPU0j67C";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9D510ECC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 15:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEgS9CONfzE6SlRvNjXiJRwefZ/kjPXhnTvFK5G22G5DrVw/AA3vrb/0jWKDzj/S2tP9CC7Y0euDoDXWcZpjoyzDOlaySlCSuGCLznu2iwYDxtPBKeK7PjiCXJr2DZZ7sUpkgXQvcp1l71wPAqPEQ9fpJzBVOjnEVc4KQOGS0Tp94aAvcoeAUjRH1yHvUYPCygKTS9sSrDTWVm3hjcPY7yQyUEGb0WKVpwgAb7JnrjyIyuCoeAXs8kE89+JlgCbjnf1ye9yH9waU1CViFM5KEZpgmQChpKh4RBDERoSlG7lBYgfgadNfNwnh6UpZfIBvY9hBZJEGXMyvuNGQJ0MUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPMr6XWwCkVrjGoFwHGc27gFaFlIfsjXNXle/VVlFjM=;
 b=C1GPFGpgXKyiWCxocM8RdEb/2Ymbv/2olCQ7sruP7XPXY+9tBqoE+LUjcnirGhHTjnwBC4W8PcVbZffDAdpNWT84TlXAkwzXyGpqhk4skN4H1jIxSr2Q3xmQ8mBIvsn07dny549K4LcaxmD9wN03Fji9BCD4KTsbIifl4OlzBo5VNnKEneAhtkQRdL0J5Arh27pGeJ5UN7YnzZP76tLSCDUCGCG0PgUuCgNLokWWzymTMgSnd2QwAS06A9d5docPAWlKqGkU/bC/GPlt7qaGSpxblenzlPw3YeTw9KbxVkIqXptLwcmw7jXt0xirJlD4KAbQ4T2KYPJ99EvqRxV28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPMr6XWwCkVrjGoFwHGc27gFaFlIfsjXNXle/VVlFjM=;
 b=pPU0j67CM2zdnKvEdtQKqPzZaTH+lULNJn9WQTpX8GgmhWG+/nHWeZTiUPIWE1h7i9Nv+yfCRD7v0A2XKEgvdrUvGvpbesKoohm1qXq7eD/bh38/pmxXWG2pvE0x5jbaK31/f6Y16ePB5eTkl17aHkcq11qjVBoPdDQvjFXxzC8=
Received: from CH2PR17CA0001.namprd17.prod.outlook.com (2603:10b6:610:53::11)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Fri, 14 Feb 2025 15:01:37 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::34) by CH2PR17CA0001.outlook.office365.com
 (2603:10b6:610:53::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 15:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 15:01:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 09:01:34 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Feb 2025 09:01:33 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Rodrigo
 Siqueira" <Rodrigo.Siqueira@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 05/16] drm/amd/display: Rename panic function
Date: Fri, 14 Feb 2025 10:00:22 -0500
Message-ID: <20250214150033.767978-6-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214150033.767978-1-Roman.Li@amd.com>
References: <20250214150033.767978-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fa8db1-81be-41b9-6bc1-08dd4d087b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wKwYxzWtentO6fIx1iXcE7KNDWGaXj+Q9LI57D9xUWGss3c1By+onA+rmFZC?=
 =?us-ascii?Q?a0rWCujw+bbeP4j2bQ5JZdqomeYB7obKaKmjUDU1hzkdUGezomoukEICJuUA?=
 =?us-ascii?Q?E8rd3rUlC6JwVZRLaZye35BU6VTNzojXTYz/wKcCKVI/gK7sp9Vs+TkwYE/Y?=
 =?us-ascii?Q?BnnOKMkuKuDMxxrKNsrNXWSc3pjV3a64HHbD6ucK2Cj3EJMNZOsocGM5uobf?=
 =?us-ascii?Q?db2QmfIrwcYLdn06y6XF9bE/gXdsQ2bEM7G4yo/yHooeo5xGc4d14erx3QpK?=
 =?us-ascii?Q?cDXFBtAPbftOJraimDrqtBjCKnKwSklYhnuMQ+VQ22vnuHsnxGaVgSxJpKsO?=
 =?us-ascii?Q?6akmz5LHZB8+pG69uurwzw0YK063MwjpnAiPW01djEmV3NGhiobFLREpwvnY?=
 =?us-ascii?Q?ZMjOdtG9Zq/0T8YO1WUQoKQB/dQK06XOGJnHvHiTdMNoOnvJz71CluxaLgcn?=
 =?us-ascii?Q?WnjMt6Vi9N4PnVTY4GjFkdGL1cWN8kmhxHCEyscdjG0lxiMF3Tq+zALTDNHu?=
 =?us-ascii?Q?/lxZO36pVMTLbPNe2jCvNlQO0IYZYZhw7uX314ji8DylaBUgirZpWyAPYVh2?=
 =?us-ascii?Q?J292AeeydeCUgdkvpRiJ4rRD2eMgbI7bhqkxYZy+YavB/V9nITrHwOA83IML?=
 =?us-ascii?Q?qaoKqQCPsyhYjImeIU3zbiQr/c1ngGn2GokDDTse63vm+F+PfXgD1T0p0dlJ?=
 =?us-ascii?Q?yE6S08URuvhg5UZSDk8owLKi/HFtj8mQoug3JMER89QlA+9jv2+c58QQPmqf?=
 =?us-ascii?Q?F2LYeZwmVCfplrGT3bbVOuKolR9uQXvgdJBh8ZdidBwtHKyC+JtHQQeoPkcV?=
 =?us-ascii?Q?+/jzNaiiBkR5JI7uKAzsZ7w8QZGtZjQoGGVDNldfm+7F6X8KocoeNJkXNUrd?=
 =?us-ascii?Q?ShOlgJELLE2O5oFudxxakxy4ZdSNlu8W/6uQbp34Q9LXCEx0/W8wYR2vj5mH?=
 =?us-ascii?Q?IDZF6KhcC8jfF9wMCplfFWGhiK62KVghthtj3qAe0XPvvmrIbvVRrYW494IO?=
 =?us-ascii?Q?UXZi28F95vlWviZR4oaoS+RLLF5FkWQcPybwqUsCQNV5ShEaRxMCfOeWYz7B?=
 =?us-ascii?Q?PqlqPyYW7tzhOfVH7TJthq6opdST0PRCbUP+1KMiYT5Zf40+/zeWWtTVDcwP?=
 =?us-ascii?Q?nZM/4CYb9KVGVcvx3EuVA4U4NA5MGzdE12vcEsLFiYzPzdM4LnM1qIJViF/H?=
 =?us-ascii?Q?t4xvamyKiD46EpK5UndPdDIAsSPYBZusMnAm5AA4qjx2Lc6+2Z7Ji/YByIa5?=
 =?us-ascii?Q?AocWcNNielrpWhJ8RJkwnsJoPvz40t6xPzh3tStk32sQcQ3C+pfSnc93p+Fc?=
 =?us-ascii?Q?+ZCO6zqL9NeUTILsEgp7rbkqybx6Kwt0Bn4pgiv2W1XA8Wlsk2ELynJO550g?=
 =?us-ascii?Q?4DkUbDKP1YKbB9TDG4VIvxMDzvDVRFA8YhbcFakrXO8ow4zqnJ15B7eT3g1Q?=
 =?us-ascii?Q?BXRVH7QQvSe6cPDkVeQSyQ6vQtzqIijpMN5l0htoMxy5AZuD/lt/KXYhsQIA?=
 =?us-ascii?Q?n58+b5HUEP4Or0E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:01:37.5135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fa8db1-81be-41b9-6bc1-08dd4d087b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Rename dc_plane_force_update_for_panic to
dc_plane_force_dcc_and_tiling_disable to describe the function operation
in the name. Also, this function might be used in other contexts, and a
more generic name can be helpful for this purpose.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c        | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_plane.h               | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 774cc3f4f3fd..dcf2b98566ea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1430,7 +1430,7 @@ static void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 
 	dc_plane_state = dm_plane_state->dc_state;
 
-	dc_plane_force_update_for_panic(dc_plane_state, fb->modifier ? true : false);
+	dc_plane_force_dcc_and_tiling_disable(dc_plane_state, fb->modifier ? true : false);
 }
 
 static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index f3471d45b312..aa4184dd0e53 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -270,8 +270,8 @@ void dc_3dlut_func_retain(struct dc_3dlut *lut)
 	kref_get(&lut->refcount);
 }
 
-void dc_plane_force_update_for_panic(struct dc_plane_state *plane_state,
-				     bool clear_tiling)
+void dc_plane_force_dcc_and_tiling_disable(struct dc_plane_state *plane_state,
+					   bool clear_tiling)
 {
 	struct dc *dc;
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_plane.h b/drivers/gpu/drm/amd/display/dc/dc_plane.h
index fabcefeda288..e9413685ed4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_plane.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_plane.h
@@ -34,7 +34,7 @@ const struct dc_plane_status *dc_plane_get_status(
 void dc_plane_state_retain(struct dc_plane_state *plane_state);
 void dc_plane_state_release(struct dc_plane_state *plane_state);
 
-void dc_plane_force_update_for_panic(struct dc_plane_state *plane_state,
-				     bool clear_tiling);
+void dc_plane_force_dcc_and_tiling_disable(struct dc_plane_state *plane_state,
+					   bool clear_tiling);
 
 #endif /* _DC_PLANE_H_ */
-- 
2.34.1

