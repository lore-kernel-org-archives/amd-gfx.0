Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0728C87FC5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EEF10E727;
	Tue, 22 Jul 2025 22:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zpFYmdnF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE4510E722
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRLcvSNLJdNrs+leEAS2IzOFPA3D4iRtMvnU2DLhfvPQ51nedxTMiUbGh0o5FCGkPlNRbtUW1+bd9Rhslq3r2Q3Q7fGNJYUXki5PFts4NZJ7TWm+GUl1DU1+X21bEVDWVx19jdIx1ukR2iwt9XXIT4BDX6zmqb/z71LHJnhXnjPvENT4plb29wUmzQaoAeYGJXX31WcacZ8LTQPfVfhz9CuqSd126ciXFkQVZbNsTdQApbfhd5yEO1u5xeJHHeuTF+u/QVBIDgv71LMG+8zq0iDVgwUhAvuxWw3uIMXtn9D2BVcU+bDc2RdhNAepj8YiwNunsBhZtTBfsbleFGL4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJyC0stgvIIC0B5MW+pPHAILqTF0sPmKxrOnDgLmUvc=;
 b=aMYQtpviYNn9V3YjRdmLJi/gtb3IKzy/vSf5B9uqdlOO9ZI+JBuOXYCgjf9xIR+ubkVtBj2f7KgWJcDg1iD4FTU6zG48DacW2aDdNFwUBcPX7xrfZCB14b1Qyn68pYDEXOM74zQSlUzAtMrjhYe2ReY6XYN52yyShGVbc0YjA9ZkUc5gV3z5FyVd48vnuFTdSRhYUmxM72t8V21cuy74gCXKB2wOr6/rKWoPv0YIotZbeqiFLUhCg5TS7oQu/bPAoderthfcfbvnz/8V1up+EzIL7sOtgp7xL36luWETP6vE0gmbEo2nDJCSuIW1jAbKNyKSNljQ6zyWE3e+P+TRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJyC0stgvIIC0B5MW+pPHAILqTF0sPmKxrOnDgLmUvc=;
 b=zpFYmdnFSkmvf3H8v85qsg6KEKaSjcJQht5/aPhSD9lSS4IOD+/r/VKG6Oc/bs+gowdqGeai2pT/7SO3Fi/IpGDWynQ1gO0LqQWpdb9l/YMWFReIuAge/Vy5iMa4hPsC05O++g5HGyCmHH+nybnBVj56g+BC2yjJG74/7Fej+fQ=
Received: from MN2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:c0::19)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 22:39:27 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::60) by MN2PR05CA0006.outlook.office365.com
 (2603:10b6:208:c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:26 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:25 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 09/25] drm/amd/display: Remove unnecessary whitespace
Date: Tue, 22 Jul 2025 18:36:15 -0400
Message-ID: <20250722223911.2655505-10-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 407767c4-438a-4521-f7be-08ddc9709d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p64BkTZBA2g0EsHIumnvrLGxF42rr2r6yAaT0mFuU0aCqpzJBq4BJLulCZjM?=
 =?us-ascii?Q?Ef+XHsUix74jwQEA30CoUzcUwkAdhNSASDY/vyAWO8BYuWb2Rw1OSxRmpl3r?=
 =?us-ascii?Q?OyH4pSdGOBwzN2O8N/ajFM0/QO4A3aj7U093lHjaEIjB+MPmCm/ErXlVr31G?=
 =?us-ascii?Q?noxo/a9JfEoK6fdiz6DmZhGBvIz1bHX6GPt20Z27nIALnitNGPn6CC6vGacF?=
 =?us-ascii?Q?FfRybFAxAoIMzwpKWSAguVR/+nDbE7FZEo/lucHOxdP0Tb2uPYnT/V0h1Jq0?=
 =?us-ascii?Q?xvDsc9EQaKgKezJpvvR99SISRhIQliICsGmDASnsmtdx61u5zgvfPT/SskL1?=
 =?us-ascii?Q?dwW7wqgbEUiO1EdFwj1yctKJD+92PwBRhm/ITq60kfXGewC2Xf0tUS7St8zK?=
 =?us-ascii?Q?mUSKBIpps6Wgvgpx/TaCphF7ZdgtSRwqlPMG36Dp9b3Zo4y1718s1qgJe+gq?=
 =?us-ascii?Q?yTSnnFjxoiCHpqC4zIn4NhIbaznk5LHv+1Oeim2lNxjPMdAlB1Gqs2E5zrZo?=
 =?us-ascii?Q?yT1GfDngOIVNuZI/YqF8dbt1YdyL3WmJCzPfgHxZfkDRXu4YEBWj2LJNvBzX?=
 =?us-ascii?Q?aAsNxhYYsvkb+c712Tq6pOvSpWXlR9rCL635O0M4YvendyPUzD45ebYQzx1u?=
 =?us-ascii?Q?fr8Hz4eG65YVZ7wM60Q6d0HelbXwflh8jaA4e0ydMQQwALyCEWCN5UkIK5hc?=
 =?us-ascii?Q?llqbAlUfK/RQOulOJF2kS3ccxIk/Cxyzm5XB172enaR57QMqa7ArTARluPb0?=
 =?us-ascii?Q?9DI/Z61yvCk7Mi/ADhuHazZiG44MKAtZ9mjejp5Wp0H8frhrUXR131U/9meB?=
 =?us-ascii?Q?pljlfH9/Yt2ZwRRbsdSfjwMuRx+UHC+tU9k0woagA1RmXnRuGhyxbfIAbjYr?=
 =?us-ascii?Q?E8IaIoSv0+ZBJ7VprMmS4PryTxhw9FPMilvza7Y9LYkv88gtC3HqjyMpW9wP?=
 =?us-ascii?Q?0hkeCTLJ72TSjsTwibb9721mYKcyjnKejrDTm0ECBa/Yef5/BI8w0c/TCKnF?=
 =?us-ascii?Q?jA+fhjzA1tTr0naG+qlFmAGK4RwLdhEFrq0Vz1OKOGP+Yk2bs+elwxsTAnBF?=
 =?us-ascii?Q?uT2lGPsmErs74Bdx7W2o6Qy3Et1LPw2dQjqmda9PF81hQ+kNwHOE8vy3WWEG?=
 =?us-ascii?Q?Im+fBQuNn9mzEUh8wbK4nZeZW9Td7koh2Az8aZHGpXxmwopYW2rtZ4pFUP/i?=
 =?us-ascii?Q?ZoythrpZYQiI2PGCnWiI7k+FSBTBjZrryPkOAo4w+m5X9mlk1DyKaHv5sS+A?=
 =?us-ascii?Q?q9vmHG2bMHfnPFlkSa/lqtfhVN12JfkWVMQRn8afmWGlkqC2Vm/51++o8aiT?=
 =?us-ascii?Q?f2Y890ylKc/9s1LWBqMgU942L5DCMF8HWQxHY181mlSHwjKnFHEO6cSbZK2o?=
 =?us-ascii?Q?yIH4NYqt8AV7m8NeWsGFXXthnkYJObfFOl8mGkbXu393/i5aqqy4dy/dQCrS?=
 =?us-ascii?Q?Dzuilz9o8jAkccHEiiQ7DhOUFxmfNMVapnK+x6fTbCSwp7a3K5A4ZtIYrvFU?=
 =?us-ascii?Q?oY1bNCLdPC47qy47WWQQImo3SMdQwPB82FWv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:27.1520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407767c4-438a-4521-f7be-08ddc9709d78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823
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

[Why]
Whitespace before a new line is unnecessary.

[How]
Remove whitespace.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e024632399f..19b0689601e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6386,13 +6386,15 @@ static void fill_stream_properties_from_drm_display_mode(
 							       (struct drm_connector *)connector,
 							       mode_in);
 		if (err < 0)
-			drm_warn_once(connector->dev, "Failed to setup avi infoframe on connector %s: %zd \n", connector->name, err);
+			drm_warn_once(connector->dev, "Failed to setup avi infoframe on connector %s: %zd\n",
+				      connector->name, err);
 		timing_out->vic = avi_frame.video_code;
 		err = drm_hdmi_vendor_infoframe_from_display_mode(&hv_frame,
 								  (struct drm_connector *)connector,
 								  mode_in);
 		if (err < 0)
-			drm_warn_once(connector->dev, "Failed to setup vendor infoframe on connector %s: %zd \n", connector->name, err);
+			drm_warn_once(connector->dev, "Failed to setup vendor infoframe on connector %s: %zd\n",
+				      connector->name, err);
 		timing_out->hdmi_vic = hv_frame.vic;
 	}
 
-- 
2.43.0

