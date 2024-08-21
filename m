Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B84EC5321E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E026D10E700;
	Wed, 21 Aug 2024 22:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gmn+8ZDu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45DF10E707
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veToq1OHWZ/+5oNW7KmwEnpwAr/6yk9dHWdImiamI+Q7BY8v8d/to/n0uHI6eN6AlnJk+4M7GCdyvzxjrgZuPqgnSdyhmt1K3aK5u0yFJxZe+pP8PxGk/pOp7e+AJNyt6pvTPL7JLOQzc4sKBXYwPow+kGWfFxApgVqqmzYs5ivBYRjTe0zw9yFeP430yeTycKd5VpPxot0uv2vpiRiyH4F4cju3vyUZciUyIoJrkkMIZEDJ4QkOVrjjIe0SPSjrbf3F5fNt6bdTRqS4yz16MbnreMBjiveXstw4akKcKp/Oyxp/GpDDGPPRd426QWSmkgGr0e8hdGD/ZwT2b0AF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTRF4zlnZYgJzPaz8IhBIq+1uO/qmeTivlCJk9xWVKU=;
 b=K0Z23/ZiO+fSSFnB6kyspyD6LDXae+JJ9a4Qb8IEjaBL6olErw3PCuCGaYv06lWr71WI0Ecj6NXPflZsyExaqkqCMUnlQU9qgtTYf8OvjATyh/1GVAd2UKkJWcsAJY0U4DXo92ZLledVCgo3bH3+G4nLERclDtvLOR0NCa5d/JzqufPmRD0p9uLzrPeB2ATy0d8RG0LsIp/OEwP+6vngT6NAV6XIzMGvik9wlb0BN7fwG/XddVR93cCL5eeSm18wPwaGOzGhkLT1YcuP9UewoUKTc1HeqPxUo/LxWDq45OlkHhp7vHan3TetOH5KnrxbbidQsa3SXYfAaJQouz3Dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTRF4zlnZYgJzPaz8IhBIq+1uO/qmeTivlCJk9xWVKU=;
 b=gmn+8ZDuAHTsG8cFoKxB6fJtlJwPfpkC8qx2ImdkRwlTSFlo8dvhWdBm/90tpNM0a7/vzN4beJu3RERQZqZfeyiq77TrW4zp8THDIT8PciW8bND1TeG+DVtIZcz/DmvWk3MkYw6BehLPkiXLOJPOG2/FgumwE+NJg+pe2pTFyLo=
Received: from BN9PR03CA0432.namprd03.prod.outlook.com (2603:10b6:408:113::17)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 22:04:40 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::c2) by BN9PR03CA0432.outlook.office365.com
 (2603:10b6:408:113::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:40 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:38 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 06/16] drm/amd/display: do not set traslate_by_source for
 DCN401 cursor
Date: Wed, 21 Aug 2024 18:01:48 -0400
Message-ID: <20240821220156.1498549-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b58ab60-b583-4f77-4d96-08dcc22d4134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SWeJp8dRLAN6H3UqjMHnu/+NaS9OrKPA+S9ZMJHgF3YkmH0z2uqIPnzJSRa+?=
 =?us-ascii?Q?vxfj8saxwkVfgORc6G50b1epwSTmjftViQyi99/mzGVyXrg2nmY4amFvT31t?=
 =?us-ascii?Q?CeqR7iY7NYWNxYz42VxnXxdViGLCOFfNWh19AimZFPRTeb0+7tz21R5RrI1Y?=
 =?us-ascii?Q?kqZxaaIJXh+l+jN+SDTFtOcIMGnlo4rWdS3nfgKTElLjb0SImmo7r26hj+ob?=
 =?us-ascii?Q?cGTSp2o1biIgxOb4pCJUAfH0QKkwfh31X+2vFWVuPGlLGvp49eHhi7AxmPkN?=
 =?us-ascii?Q?XPDIh9iYEr0tJeTJwxrgUBbSiV4Fb2dxr0UCi6N0G/yG/q95VT8GKFiNy01+?=
 =?us-ascii?Q?9cSRQ9VzNCaqLdt3/vCAxKorOv1Q16rKDt0IJ6jSNaQwbfSdAmsZs+o4u0Ve?=
 =?us-ascii?Q?QxGPjCZ0DJQ60iKTTr80p86lqjrKApVVvQ/Tl2J1EMW4zyjCxWfy0kh560Cd?=
 =?us-ascii?Q?wH5Df1MYFChFqwPWtqVNpBcankF1aiB8xJ7i2HBPHA4l2RMK9hQ3aqXysVpj?=
 =?us-ascii?Q?ZR812V+00tAS8Hww73DXPVHG6pdYt2Y/a3NI1oTrtAovWDDyOGZRe39ZI64f?=
 =?us-ascii?Q?esMZjnO8DNKeqy2EgF9ui/e/fUUuPo7jkOabSl1FNoP0w6x7L17xx62llGMQ?=
 =?us-ascii?Q?zyj2jvV6z04DpHvOjcLJ2bj8XVdF6h1AyPVgnB50kcWStVy1htkXVn6tCc/I?=
 =?us-ascii?Q?BJfQw5NbnJuUAU+io5dopOMQ7jAUmXhbJhiyMf5qOTYq6024GUu8CfJ/XhnT?=
 =?us-ascii?Q?V26GnQJ1emmjmsj0Yz1/tymge6MoE5/uQQ6R2GT0X8VyOgBg+TdwHWY+EMBz?=
 =?us-ascii?Q?SawtFEzAEivydlDARRTvXqYRs3Z1dr2RjF/YpEIBtLpk/jxFj37JIeHCIhqO?=
 =?us-ascii?Q?/3y1kb5t/XjmqlfLUD3FGTHTxpvxMdOJ0IvnBuCx/WUuHYo3yHojkH28sppj?=
 =?us-ascii?Q?ZrNfJRPNyebsZNqSw7JZCqdeLQX7XBipRHzgDleggmrFwQPMa6/ayTDSqkGF?=
 =?us-ascii?Q?RB0/dWsOdqn37qsHaE57jZIEIC8HteRPWDd8sDKgzyLyHGNG/aa4w9jG3TqI?=
 =?us-ascii?Q?XqxCQ71qxIEneiv2jJ1dT/yyQMEmYkaTMQNeZX8cZIiIstzFSMEyy2KL3Q9u?=
 =?us-ascii?Q?YmrD/EQfceaZ3PggkdW4MuClM61Te1/LjpyksS860CXr2Ye8B/U3d/tCpBeF?=
 =?us-ascii?Q?7bAo5DtI8pn7g9sSS7kFAyGqroG/3TS9OvXDb4GPV6q/wdiXmzqD+4kliEDw?=
 =?us-ascii?Q?puY4UVHywM+bvHvN8kDtNJzw8P2i7bsXQwByd+rOGA1TBymwIioGRc9uXcte?=
 =?us-ascii?Q?KbK/98qjKpzVy5CSwQiyHGrtptN93ddLtx3E1fN+xqbqIZRNZBNMl0KkStPz?=
 =?us-ascii?Q?nZqmp5CAMnavNL9BrFeL1cyLAY5rn7CmE/Bo4Mw5pgW9Eb+BjGxfMeuh/KwR?=
 =?us-ascii?Q?EEFwPNGLvlpdfFtGQX8keNqFlCbFPzBk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:40.2406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b58ab60-b583-4f77-4d96-08dcc22d4134
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

translate_by_source need not be set for DCN401 onwards since cursor
cursor composition comes after scaler in the hardware pipeline.
Hence offset calculation has been reworked, and this setting is not
necessary to be enabled anymore.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 1ff469ef51af..7aa43570d219 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1278,6 +1278,7 @@ int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc
 					struct dc_cursor_position *position)
 {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	int x, y;
 	int xorigin = 0, yorigin = 0;
 
@@ -1309,12 +1310,14 @@ int amdgpu_dm_plane_get_cursor_position(struct drm_plane *plane, struct drm_crtc
 		y = 0;
 	}
 	position->enable = true;
-	position->translate_by_source = true;
 	position->x = x;
 	position->y = y;
 	position->x_hotspot = xorigin;
 	position->y_hotspot = yorigin;
 
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(4, 0, 1))
+		position->translate_by_source = true;
+
 	return 0;
 }
 
-- 
2.34.1

