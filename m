Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD28BC3DA61
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jul 2024 06:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD7610E190;
	Sun, 21 Jul 2024 06:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N/l9rMHq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D1610E190
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jul 2024 06:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBu7s5wybcZtirLmBdWZcTGaKJT4vskw11XkwgpJ0MTj5+jP7sxnSfouQepYKSQAPKsABJRNtEg7K1aFUsjW4Jlb8BRBsw3CGwgubf15ReOQfMd6++O3V6DoinyLPkH8OdmupgHybR9udTXbpFRauP9oN8AQq9gQVS72FECXbkcWfriKkdBXj15aP09M8uEify9at0v31FvA8ZY0jKwTEAwI84vG0QObAAeIZNHuC2YW0c5yDJvLJdzQvgEgpQoEqUcmGMOSuktkHrxbBO6MD5E+Ossqip+Q79ve4wiMTmJXJG8n6l3A5ZzPYyfayJ0WcKd1vJMm5kNbUpLiIWXTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMYtLnuFMWN1DV9QfDdF7djbahkglya1Jl0sM59PGj4=;
 b=ZrkjzDBvOV+uAkyt18rIzP1jWzcpC5QWwiHJA3krO9DhEtD/ZiaGkVlVBkVYqWLqbAFZtjLh/YmksoC/IjScUbfmm10JpzOgN3sA32A+arz37RPal+2XfHi7UxTWHO4LUVI641S4pHfDepqVULI6UAjaonjA+53Vb9AeZBy1xJfCWVVa5JKchibUFaPjPrLcAb1rlWN2AQpyBgFouSfbxrQ8tCQOGuOePCeckCOnrowsse33tX5s9iYU/f1s1iFHzUrJgz+MBpdTLsyJdm+h5atYY5l2qA+kzniaQbwcRAbwM72HuYjciXgBiHqbfdRnxHfsZu7QSb0XK1IqvMnq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMYtLnuFMWN1DV9QfDdF7djbahkglya1Jl0sM59PGj4=;
 b=N/l9rMHqpcMf9hJ+2Ln77Wt9dy6aWA8L7I8a7igYa1ZOXrunGnhYbk61ECv1kN++/K5cvLpuniCUp098YvEYzQl4p36ElJ5wMAP4AlakxuDUHNTblRG5WcPhexxWK6WOisGDte3z6LzRw0ArtAnelNUiUxMAk2rG4mfC4qn3h04=
Received: from CH0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:610:e6::11)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Sun, 21 Jul
 2024 06:22:38 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::fa) by CH0PR03CA0276.outlook.office365.com
 (2603:10b6:610:e6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Sun, 21 Jul 2024 06:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Sun, 21 Jul 2024 06:22:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 01:22:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL check for clk_mgr in dcn32_init_hw
Date: Sun, 21 Jul 2024 11:52:11 +0530
Message-ID: <20240721062216.3151119-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a6ba3d-a127-497b-f4ee-08dca94d84ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ynmAxatvogwdGJ/2kbBlR8BbmE1+iatz4nD2lrVUSjlpXyCoZ8bR9wsAbNRW?=
 =?us-ascii?Q?DHMOl1lqI+NxqhOSzuAOFRRxTQXIfiviIU1bWy4yEs+PzXG7ADBgs1TL7Ec0?=
 =?us-ascii?Q?y2GIfI+hgLJ5GcTiJ4tCU7yiE+MMT0EKMzzb3aI5sUra3II/S98RP1Obr1O5?=
 =?us-ascii?Q?1s5OYGLE0d3vptKoE1SWtril6LZnPxgXO2BqAfWClaWhYHIefDTZ9/KCfRGj?=
 =?us-ascii?Q?eKUjqGaFIZ9X26Rt7q+cJumzo0xdTTp84e8aSWa5O4pw8lyq9X2wtC41wLuH?=
 =?us-ascii?Q?KQ5MKVdMg5y52kli8op5H7weTu1on9odvAF03rOD6y7TSjYeFUnuDNxYcBeL?=
 =?us-ascii?Q?+ZuhQvaOpMd9/COSsU1wQVZ8yPpEnYkqp/3M1iD0XkdjAYVdgPqplmYmThOS?=
 =?us-ascii?Q?8HaMRviU/3JNPlPpkRM+kdwbAXXaPCecpmJUJ+BItQvG6HlvFoXyqrf2tuz3?=
 =?us-ascii?Q?+mAwcscGAnD7zTkkZMXrHhOspziHKzCXvAF1UMyHPZhgA7qL9bENOJ7EiA/B?=
 =?us-ascii?Q?s5v2z7YqxqM5censNrpi9h7C7sQvbg4CUa2okMZQC2WKCqrvd5y4KuMAhdOI?=
 =?us-ascii?Q?lurAOMcMRl9Tho1eifRWBzLB4umULymmfsx/MCyR27Opgb3S4JCEhhtovfxm?=
 =?us-ascii?Q?1QL3zOFzXK+mWTlMlpTNfoTxakly0F6uuTyvuMJcu2oST8k4cEHnXSQQd1yV?=
 =?us-ascii?Q?3X4qcRACpR3yrTZ2laIp50pn0y+rGdxvnMs8oswwzGpr57QJ1U39mGFGxRiL?=
 =?us-ascii?Q?0kKzaETD99SaZScz6rECm+gQZKUQeW4WWQS5nWcR38VnzIj8fkWq+sYsa5ka?=
 =?us-ascii?Q?b3qx1YBJrrPWhAicjHFLJn+sC1QGNF/1Fdd45moCVqEzK7PuKRdiuj+FlQbi?=
 =?us-ascii?Q?jTSTRueC1anfUgs5L0/Z9UvjtQgUbkq9U7yl/7Ng9ZCAx9+qYgcOBqNbQDgQ?=
 =?us-ascii?Q?LESLds6hfVEw/NtvEl/n0nI7jue+xwr2GHiepoGKoFuDLyXZ9k3GUkJs/3Dy?=
 =?us-ascii?Q?pdSq8oMEwU1UZ8ZFveb+HWmqTVHUiltWiBfesC1rITw1C3iw+0wkVTeoH5+G?=
 =?us-ascii?Q?ha5euDXM7B9HnJvuxV691JV/ngMBLkAYmc3Mn+at3njr85kK09tfdUstBDnv?=
 =?us-ascii?Q?TX5R3bq9g7MAUBgOHM9esAIBSKLDIFf4gHYWXGt4WcAZ3NO6W3bcW3vZwKBT?=
 =?us-ascii?Q?WsrRQcwePfzxXitJ/DFk5MqWu/SroxXzMs9stCOGxpRCRRN2u3Fzmn22Yy4h?=
 =?us-ascii?Q?dsctDCb9F5BHItwRvWiSFBfz6Nzy5WXAbJZ1W2cHecfsRyPGyJ/CcIt9AesS?=
 =?us-ascii?Q?j9FSmb4CZFAt6mETOq1A0bkXYNs8zaGD6T+nvuR27IOo5A2M2gN68G8cnVVI?=
 =?us-ascii?Q?SZEd14RQRRaYpugAgHlpbdhQneIkFlHlM3iE/ARNUif55QMfObe8gTOXlQ3h?=
 =?us-ascii?Q?Vwr2fzCgcbRGyoYcVjGP7PmsbjeyEm/K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 06:22:38.2424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a6ba3d-a127-497b-f4ee-08dca94d84ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

This commit addresses a potential null pointer dereference issue in the
`dcn32_init_hw` function. The issue could occur when `dc->clk_mgr` is
null.

The fix adds a check to ensure `dc->clk_mgr` is not null before
accessing its functions. This prevents a potential null pointer
dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:961 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 782)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 7f41eccefe02..96b5362c926d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -958,10 +958,11 @@ void dcn32_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
-- 
2.34.1

