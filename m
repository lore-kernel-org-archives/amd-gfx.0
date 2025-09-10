Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753BACA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B66710E844;
	Wed, 10 Sep 2025 05:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NUYDIUM/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2917A10E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voVNGsQnY8njUols4x/w9vRd0cxV79ZCKj4mC2ovIJJ94d6PCmfXbKD5uLmh1MDlpeMs0TfyYsS7vuhNEQptcBLtLBDX7pFlznnYqEl0d+ZzfTs3QJamLX8P7ePneiJikZoryRa8uxs6VjiClrjOeN/4+VOFQ7Ux4xB+IA0zY78eZtl6nmHPeJ40d5Pd7VN2G1d/T3Kg1tMKZpb1vMNdptU59nPw5ixqvO4l1wYWEw9YLajTuKdX3En5gEnsX5NGdVPV8rTEkP1hNSOFwQeN41V2sk+lcF9jPDFLTmuJLZqt34ybd0wQtbHhE1t41DDasX0g9VlOHqiEGW11JcFE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcR+ab+iOQ42cqt4uJhKBOOt/nhQSgQLPus/M2eGUKA=;
 b=Yw1TJ3yJn7At84EB9K5zjJvmqyaU8bAE25omImDwNn9e6NJ+5anrxDV8EDqSRaJvZStSgAzdwY/EMHd4LpmubJCl0DGN0bQJeb9hKTkUOjG/tf0ME3QXkfT1yVWpJmsv3Kw5wIBcJw+3NV0ykt0sldjHiN5ZoDDB19XAPxflLltY9tEcZhmdRxM5vQebCZeX7VR9qqGe1b1tmWMWAxffWR7ysQCePfoPzgj0S8u394teSCGDFPCKlq5hocVjUoz9cjUYHZNZ/PU/F5HHc8ztD3F8sCQt6Aqw6qsqdD9vve1MAYfSiN2mFThS5vKNbvx/sjF9qHk4V71t0fV1ydLOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcR+ab+iOQ42cqt4uJhKBOOt/nhQSgQLPus/M2eGUKA=;
 b=NUYDIUM/hh7xEs/+FC5lzVn/E5fCKS9b8pfHww8VFEiN5BEAjQMblD5pEwE868H0uZY3+v16Ayk6f3HbkP/eB9XmRCMNfNPAncbzzV8RFNGjPnWhfjHG3gLeMoUO7ZOVTJMtR5a7tBE3RLVObPExCjAuJO+oxwcKJNSvMCsxyDE=
Received: from BN8PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:60::16)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:17 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::83) by BN8PR12CA0003.outlook.office365.com
 (2603:10b6:408:60::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 05:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:16 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:15 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:12 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <Dillon.Varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/15] drm/amd/display: Add missing post flip calls
Date: Wed, 10 Sep 2025 13:22:11 +0800
Message-ID: <20250910052620.2884581-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa97fe5-4523-4255-2594-08ddf02ab46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3cAu0QyxZj9qcPnUuxVp9UEP9IpsuSggzTM9kbB7nZJkPAw8ZwkQFcQmbLqJ?=
 =?us-ascii?Q?1G9anmWvc6oIQ6RiiibzUux98ROmu6ugrcUl4i0ZInoLvFNlqKL/gOOF5qB9?=
 =?us-ascii?Q?TEsq7AeUeo1K0M8zfO+ojk1Cmlp9ntvjMV9tjD8wGOgCWsx7AthwhWXMPq7a?=
 =?us-ascii?Q?jZJrhLiuvvnQuuWwN8t+hGBaU7/x5bALcbC9DhtK3wyvK2rdHBkI2kT/3Lik?=
 =?us-ascii?Q?q19G6aY47sxkPLKd0P0ZAI0n796IWz89ldOizkTckJWbt4luvo9EpXNIy8Pz?=
 =?us-ascii?Q?recsAFHJqUnZBF4SF6H0cU7AcmfMxSDoyCwkjNg8RKZ8b2NFT0MrDL5je1Yq?=
 =?us-ascii?Q?5un9rFKH+jFe6rHqbKmXxLOAgjo59SzlMUkVBvkuapqbWDVlVOcRL5eTpziG?=
 =?us-ascii?Q?m6kQ3GpU7ahKUhPMiOZosgcoZ3253Ql0yq7eHjuJOEPpC22I3Xe9VjeUz/ux?=
 =?us-ascii?Q?h9/hm0CU57Dq69AWDn7GkcwwMTUR58sLIgKTb81GT+bD4oAG7Og3ERceTsFY?=
 =?us-ascii?Q?Ia+oIFfn7WyAu/ZAU3omQEXnZ6D5+8t7DEDIU2AldBFD3ZVKlOSr8oUHQPi8?=
 =?us-ascii?Q?dyMjzUzmQ1wXjgE0wmuY0htoQ0xMxx2iL3OvLjeSVNIrU+8N1oJlYyuuh6bT?=
 =?us-ascii?Q?W9Pw9Ab4bXOp/aDD5823GD+QNw/o8j/FotW4GvMXBUGJAntXgKXLk0/FTALW?=
 =?us-ascii?Q?jnMb8XTG43z7ZstWhaRAsF0VV6cT6bhsJSaso3DhPLyH5h1MDGYiOwb4erK4?=
 =?us-ascii?Q?N6v6bwIDmq+D37dnTGpU02uQNgNwbz4acNXWgryIY81KrHCklzdNIL20x7Xn?=
 =?us-ascii?Q?LlwRTbhywxMXh5KshekgxEJvBcOvrCg2NmNsemDAe8zGm72u5zyLW4KG91iq?=
 =?us-ascii?Q?M1W4gqvd4quKFAMTg/REpavzMUQeTP9Mo1XQBRt8QfXrdH9YQwTtb/yu/dR5?=
 =?us-ascii?Q?LJeHCNWPrQbzUQy0spXHgJ3QUPXtHaCn5MtWJCUnc2QcjFl7a6pqzCqHvFlD?=
 =?us-ascii?Q?tYQUL+lh4d+kShWW5n64XToI89x8JxgbpNNJvTe74Gdv5vsSL0e2gBaeFqz+?=
 =?us-ascii?Q?Os30zshekFNzG0toufD80fpLFsgbLVRgn9tMJ/3HKGUX0tPlzGAsZoeyE6R+?=
 =?us-ascii?Q?NU1wKaeThLgMaM1RfUjbGwXNYP2o6DftQ8AM0zzg9DnsB9QUmE0knVtndzG3?=
 =?us-ascii?Q?g1l5HMA1pzitEmkARjgk51nR1ksUMAv0EBk/+Zh5AbRJ74FuxXq8Guxa4MQr?=
 =?us-ascii?Q?EQ326zs4ZlV/wXvJCDpAKU6VIdwcS2DCiw+FPr75mrwCSumnj/yvFVc4ccr6?=
 =?us-ascii?Q?B1KypQ0FDUC6n9HFV0YjzFcT72KidBkyNXSyfYvyuEoJq3vefbtOw/gg/Jk+?=
 =?us-ascii?Q?nVvOdfLzvspyW1B/Y3muOkxkax8Zz5x1Xs+U6VJ73aotrcbkZEgUXpV/+Yc6?=
 =?us-ascii?Q?l9aWsi1e9+uKWFWalbvGLC6M7dNGke91d8r6fdD1oztNUTz40J3yBuc2wDLE?=
 =?us-ascii?Q?TCNahaAvRsLDb9/8GccqUhkGTmPx5eeni67g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:16.2321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa97fe5-4523-4255-2594-08ddf02ab46c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
dc_post_update_surfaces_to_stream needs to be called after a full update
completes in order to optimize clocks and watermarks for power. Add
missing calls before idle entry is requested to ensure optimal power.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b088cb8ae780..849c45d10ad6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -417,8 +417,7 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 	/*
 	 * Previous frame finished and HW is ready for optimization.
 	 */
-	if (update_type == UPDATE_TYPE_FAST)
-		dc_post_update_surfaces_to_stream(dc);
+	dc_post_update_surfaces_to_stream(dc);
 
 	return dc_update_planes_and_stream(dc,
 					   array_of_surface_update,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 45feb404b097..94f43f0cb4a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -218,8 +218,10 @@ static void amdgpu_dm_idle_worker(struct work_struct *work)
 			break;
 		}
 
-		if (idle_work->enable)
+		if (idle_work->enable) {
+			dc_post_update_surfaces_to_stream(idle_work->dm->dc);
 			dc_allow_idle_optimizations(idle_work->dm->dc, true);
+		}
 		mutex_unlock(&idle_work->dm->dc_lock);
 	}
 	idle_work->dm->idle_workqueue->running = false;
@@ -273,8 +275,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		dc_post_update_surfaces_to_stream(dm->dc);
 		dc_allow_idle_optimizations(dm->dc, true);
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.43.0

