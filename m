Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF08AC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696E110E30E;
	Thu, 25 Jul 2024 18:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eAidodjk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F7910E30E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG36rAyDjs6qfaLIf23AjqKMxQu/hnyBUuT9jCUMYWXYl+62BJA5lUtTWe9pOdy7I7/zdz9/8Hi7nEajOhXUzqlpIrTzaGiUKZn9Jr9oe4mExdLgvDfVxNa2i2ZOOuMoh+cg4y7J/bOeGpg9KlONeOwDGH8iCnHybTkVsukDncxKDk6vsO3hbptspnmjuBv7qfjOBBRMt+cxr1F/RejwYL2/XCXsRtlA7/tH3+5MZEboAuhCKAlmCEiNs3kcBomm7pmXR2x8VP2YSbvBuS27QIzvQe/04facJktf9sH2eOc5snvyteT+BZ/KzZote6MtMUEkQ90yh1U8bUIITnrP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVbwD1d6ib1im79lD6iSZf0RH0iNZj9zkjpkmAP8fUQ=;
 b=lXk3FCI+HUivdhNRckkUwnsi7DlMK4hQF2+xz16a/iRbBWcq8JjrluNpqJv2wXZUGCXB5c9VafQR6MAKNRAp7qBG77dmR8Jbx1ZK8sA0dcZkN+GKnXY3LLpUoewpGqIzuLZHGFpm6YSyoyy4uA0Atue7pBdCsiEWJr5dv8rQQz1FfIhMEyP/eU+dXtSpWmIpZMpMhXU5wjJvsFgRfB7/iV6IKIg8dtnLzHtfZaddXwlE4njcqmGQt5v0UQt3YXFsl5vtzA+rimj8oyYWoSlLoq/gD703ThvO1SDwAEJJLuz8MwQi+apVjIQT3pJJ2rwqKX8hipfaBwYzwp3uo4ersg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVbwD1d6ib1im79lD6iSZf0RH0iNZj9zkjpkmAP8fUQ=;
 b=eAidodjkVTqVYCkOe+T1+tn7VqmAmwhzmWdCTRJaExLT6PsxWpZtfexNhJDwc7Ot0p3dCNedA9zo46576LMAP4YODBP4atMYHPp4n6EYMJJan/Rd/pdhOtlzWZKyFq2dYvIZ2deWmFgdLFKInnw3cqBbr3C0aL3+G95XP3ZTVw0=
Received: from CH0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:610:b1::27)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:03:41 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::d4) by CH0PR13CA0022.outlook.office365.com
 (2603:10b6:610:b1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:38 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 03/39] drm/amd/display: Run idle optimizations at end of
 vblank handler
Date: Thu, 25 Jul 2024 12:00:47 -0600
Message-ID: <20240725180309.105968-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: f162f8b3-e339-48b2-27d9-08dcacd41e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DAvS8CkO8ytFMWQNcYL82ijMKgPMShxHpxKPosnfc88Z0Tl1bhsMM7Zlq6V0?=
 =?us-ascii?Q?MXPSo+/JtJIAj5WV7/tc8kPfd7KnG/OaQpjrgnJ2hkBBa3NFMjHpGoqvp0eL?=
 =?us-ascii?Q?TctGmZLZ2dby5JKNmbhsQwqV8MJlRdi8Oigglo12IXFLGQvvRfYL1wpnBmSG?=
 =?us-ascii?Q?myIB8m3EnG9Q2QVr4JbDvC/5sUbsdzlFnJsMGCgua7TRBrBjjpBxhtMrwCSy?=
 =?us-ascii?Q?+TgOOI4FAFmeRDYnWpBguoAiYOo1cU6K4M2e1nurDsbBkgxjjr803ppwpUI5?=
 =?us-ascii?Q?vBN3SIkyCYbwGR+Ku2NeSkueKgMBEaq4g69U00SXqz3zZacsDHcVp1IrNaTp?=
 =?us-ascii?Q?TUQFXfpeDO8b90vXOu7v+gJ13DOzxa6uOcUvMSDje34MYuv8d/0GvwEtAgFH?=
 =?us-ascii?Q?iuYs7rpDwb6SJHX+X6XFMHSdc8iENH4QjMBCWvP+s9w9EFmej711qmNzcHoT?=
 =?us-ascii?Q?9rXsGPWgZ86r11EEZkHNz/u5UM2zG8YM3Q8tR87EN9jluUP40rBwvGvk1hpW?=
 =?us-ascii?Q?T5WNz0YHFgLPe7Z0JKDPu0KZTl0DaPZnMPsOJeOo/VEjLubLsHD0MALuz2KL?=
 =?us-ascii?Q?VwidzK8ZkVGT5mY94BcUzgFPWRQD21URZOeGRcpHLTihVfOqyDQSSp5U4/y1?=
 =?us-ascii?Q?sNYbjLfg7pmYswkkh0GlOS9fvI8azHg0L9v6z+1uBzYKFZrfiTbWLkpkbpUq?=
 =?us-ascii?Q?7nuxqi0Hcxl40XGaqap6dyUnRITvbgnYv0BNV0ruowX0tCr0L1lGy3SODfJF?=
 =?us-ascii?Q?VM6sIpPZ/UcHaKv9EhdHzZRlnixhBBR7ONpwaTxZvFJuSDTaPJRiEhbbOu62?=
 =?us-ascii?Q?t9aQ1zwZBJCIz7NVg0dq/UbPPdBLHIe0vTkSAzxVZ4/nyuDhT2MuDwkyTrC/?=
 =?us-ascii?Q?zi4cNfxyoTLAKPqeo2LkUW7DAqGf2PaoHn7ZHQqRbXPI3hXfTsfaCC6/OXz4?=
 =?us-ascii?Q?CSYdIVcxFMI8py2ba5VZbS7BZVBl2e/cfY64RV3thHNsDjWPjzHJ99iCTgxW?=
 =?us-ascii?Q?zcW9+iE1MBt8+Jux1ohV+C1MOgczLZvLcos084ODaISMCjaKK/m6Q/dH4Vxt?=
 =?us-ascii?Q?LA7aDIw7imfANF1FzDRjIWZ4gVxnpEva3UowB/aNVIumrRiffavm4/3lqu4F?=
 =?us-ascii?Q?qsgfzPnneYtHJlik0+5ZaMgqEiY0VQVerOXofF0h2/aiM47+Pa03P6awQd9i?=
 =?us-ascii?Q?oSNY4oYRWPpZNuiVaGeFafqtY0pGLZjMVCaHmsYCdifIAqjIgiZPsOMq5b0g?=
 =?us-ascii?Q?DNFp9Iw4PU99vCFD8e1s5sQblbBwDafczkuQBXXXOVxVnC9jLfIjzy+l/2Sp?=
 =?us-ascii?Q?ViwbOaSoxPQmPHRWN0o1HcLFIH0oWLmythq9Na1GIg1z1JXHP0oenFbyfggo?=
 =?us-ascii?Q?ptIBPaTc/JUg/T0FbOIs7FWtFoUUeo4jwXpCDl3I0JvrUZcH9y3Mwe+MHpZw?=
 =?us-ascii?Q?mFAD8k1mTqlI0IzHI09OEffIhurGgEzJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:41.6023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f162f8b3-e339-48b2-27d9-08dcacd41e22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
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

From: Leo Li <sunpeng.li@amd.com>

[Why & How]
1. After allowing idle optimizations, hw programming is disallowed.
2. Before hw programming, we need to disallow idle optimizations.

Otherwise, in scenario 1, we will immediately kick hw out of idle
optimizations with register access.

Scenario 2 is less of a concern, since any register access will kick
hw out of idle optimizations. But we'll do it early for correctness.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c   | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 1fe038616d9f..a2cf2c066a76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -251,9 +251,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	else if (dm->active_vblank_irq_count)
 		dm->active_vblank_irq_count--;
 
-	dc_allow_idle_optimizations(dm->dc, dm->active_vblank_irq_count == 0);
-
-	DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
+	if (dm->active_vblank_irq_count > 0) {
+		DRM_DEBUG_KMS("Allow idle optimizations (MALL): false\n");
+		dc_allow_idle_optimizations(dm->dc, false);
+	}
 
 	/*
 	 * Control PSR based on vblank requirements from OS
@@ -272,6 +273,11 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->stream->link->replay_settings.replay_feature_enabled);
 	}
 
+	if (dm->active_vblank_irq_count == 0) {
+		DRM_DEBUG_KMS("Allow idle optimizations (MALL): true\n");
+		dc_allow_idle_optimizations(dm->dc, true);
+	}
+
 	mutex_unlock(&dm->dc_lock);
 
 	dc_stream_release(vblank_work->stream);
-- 
2.43.0

