Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBDCD637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FBF10E8A0;
	Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PaRCqpn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B61B10E710
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMmArmeK3EHTK73bmfIT3EurXTgEcxM6apsFRLCJY5Ctz78yBU1Ih66G+lHSif3ME20PUMJDVf9YYpTF6d0JsMxTSRr4Rgx3Py6SyoB0NCrvwtjmK6q+/a/Vn1i2nSxkiBqkhcSWEukxVBYItkZuJ1fKpvjJ22tBRxZUXEJIYgQMIBabUuJJyFJqnfLnO3o1U+v+Rn5L7a94qvcHnsQB730oX0hozijFvsTvt2TOzlXVd69zp8f3Ke/TtENEwUKAOqqhrF9yUZ5aLioH8FvTSD+A2XDXvenXysV8uHJ+D+nSx3a/jPIOfh295231xY1accBLrIAixssjrOiDQEEKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngqxIhmMVBDi+ZsfWntJG/kexusdSrXv9G4zU0JppQM=;
 b=DS/Yh+M/HAJioxrKIU0BfPK0skMKa7iboXE4ENBRsrSCYmJ3YQTzR5EnpGQjtFgkcqPp5akt6jLIAnAHRifYGOnmxxbmZ1U0/mIKIIFJtpKMLCjZrKgDbXYmKUHnOAhYNH814ss8vxuTorIDTuu2+zqhdErq8q8B9qRmxNR/odjt78enxB4IstCMFZr0dPtejflvix1N8DDK6n7OLzFlTw1piTSxj2n3j69IoP6rLQBcpjsvWibMuxJpCLrIqXevhXTqDELaKSdbdbd9Fa44+kss7AjuY69lWKNXjihl0eZyCM1dTghqijT/MYebvGTMu3AXch8tPlxQr1gbA27hQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngqxIhmMVBDi+ZsfWntJG/kexusdSrXv9G4zU0JppQM=;
 b=5PaRCqpncmw2qasTwvdehSdeo74Sl6A2cYGzCXJcDUmhA+y79iqMJt+h1jTqV+W67MvgQqSxh16G0u6tGKvE6Mk8E/ZYVNWmrA6bxfcWxtJWKpO2Ftl6sRSWPk4LzxW35tB4pOmr47O9Be38IvtBhnkfTgzVjSLMdmWPJ/24MaE=
Received: from IA4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::12)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:15 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::34) by IA4P220CA0003.outlook.office365.com
 (2603:10b6:208:558::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: enable CP interrupt for gfx v12_1 in frontdoor
 loading case
Date: Tue, 16 Dec 2025 16:03:45 -0500
Message-ID: <20251216210349.1963466-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bb4edd-1b67-4c32-e145-08de3ce6ab7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?usaD/xCGdNZykwbt2CsF4JseyVSzcXoquZOUecyn/T/0ts9PbU4mtgdu8PxS?=
 =?us-ascii?Q?8vt3urlIt4pvf0DVLOcSTKQ31VCdgVu+iG/uiy7YF4Tr7wvqyiDJV5biq83M?=
 =?us-ascii?Q?mzx9sXeLyypeKOWDwN+OAajxMmKF1XgVo+9uG1p2PllEzLEVKWVJIgT+HCdJ?=
 =?us-ascii?Q?XZpbMh+mpRhistSHITjYbHUJgBVkcsL01OvaRtGCmCFbyEn4rlfozeaHOyFu?=
 =?us-ascii?Q?+EG9VHfxRcBz9po3skW4H9zMW/f1yburGyuKV6dgVo2hpjfdibRMs1EOuP/s?=
 =?us-ascii?Q?QqRbrv0OokcoEnTA6qCO6TEy4MLSXNgFuGmboCb2NUSXvQY7xHw/VAaznnaL?=
 =?us-ascii?Q?qRrGuJDr5XQKJgqq5GKxzMX2oiG4WEG5KKMiIyvG6OTMvWR+53b9igQPDGGu?=
 =?us-ascii?Q?VtXja056pJ2ddIed32pSgRBKFI78VSkk3R+fzFn2eTNdlCCurSVoV8N/zZt7?=
 =?us-ascii?Q?oMc24iZvhPdPPaY5x+LmdHuUvwn8219UE2DWgCfRjvYYgaC9pcN+F+tHboJK?=
 =?us-ascii?Q?7J2VLr2am6OYmqr/v0Ftt+11ozkYKSKly1dOE0q9qY/G3JbT3zP86THfItGM?=
 =?us-ascii?Q?Umdvj8HnWRP+7HEEpBsXbPjh9UhFMtqX4ml0dO1yipyHqux1KSrbLnvs0yVy?=
 =?us-ascii?Q?P3DBI9QeVtBh/bvqQpsCmdZ8fwSTR8Sv2uoTnGi3hJTlNRk3K2bz88oXjzCH?=
 =?us-ascii?Q?SKVeKKB9PEKtI6nNe2oyop8s/LGnXqrrHyANMqTCfSvJPc9HaoIeuH6BuU5f?=
 =?us-ascii?Q?toBHNfoOyfH/e/zW39ThlWTUjldoWa9vN/9yG9hJZu94Xvg00QHxE1vUK5jq?=
 =?us-ascii?Q?7KknzNbFHo+bawjSTJuQgltwe0Q4mNJeHdB2MZC3wo7aU3kLZnbtdnEFNEHx?=
 =?us-ascii?Q?v9SiPgiRVxOU6SzVUA6ygvlDS5qLma+N/PhqwSNP2Up4eDKtxlV80XgGZigK?=
 =?us-ascii?Q?rZWR3Jl1VDaEQgSQ+D9E0s44qV0ClF0umIFpxWO4z1ofJLUebSSrGQJ7knrl?=
 =?us-ascii?Q?5qvqMGiyX0DB/QEzcrCTGdjjrCXgyJor7aJL60sS5Q3h5dU2uImsCslwuan0?=
 =?us-ascii?Q?8b06amRKy+TcBt43h+HPXZC29DTIy6cn5b+v60K/kgaEpCHPdpd+J+Rwgd7f?=
 =?us-ascii?Q?FW2D5v5Lvs383KDqCyhKhZE2Wy9SVC/8xx2mf/UCAv31wwWp0kD+3YIcIfpK?=
 =?us-ascii?Q?IhSkGMk5CqW0dGApRiTTgXr1A4VIqM313bWgKxpbfimhgnrS/NDmqUm1/ud7?=
 =?us-ascii?Q?PgURIEDaoEm9KcNhhrSpR73TFqyXIyFk0Km3KTcgzNtIjjhQfKSxylQaU3BV?=
 =?us-ascii?Q?6F9GSU+ceH2xXvtR0g/L9XAq1CcxlYb/7/m0hY31IGExGxTAqPDfjXc7hA/C?=
 =?us-ascii?Q?CPIOI/+z0fB27wZc1EzEWavYFjgQhSNJc6a7i5+EaL1Is2LAJwKiYtn1hmpc?=
 =?us-ascii?Q?Do2ESRZFyqWsJ+Ixmk2xWe8JdigkljHTlXk2QQFGBfybvA8YZsmU8AO2Hvpc?=
 =?us-ascii?Q?wtQp6uY8o6sS4F9scVTGC3/QlVEHLjum06qs0Xxxz40wp+AUCpVMCnW5yNVW?=
 =?us-ascii?Q?0y34lo2BYMe9QUVOHwI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:15.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bb4edd-1b67-4c32-e145-08de3ce6ab7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
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

From: Le Ma <le.ma@amd.com>

Enable cp interrupt for event detection since GFX CGCG and LS
has been enabled by firmware.

v2: enable CP INT by merely checking fw_load_type

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index c419e60702c8f..943be8ce17395 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2479,8 +2479,9 @@ static int gfx_v12_1_xcc_cp_resume(struct amdgpu_device *adev, uint16_t xcc_mask
 				return r;
 		}
 
-		if (!(adev->flags & AMD_IS_APU))
-			gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
+		/* GFX CGCG and LS is set by default */
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
+			gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, true, xcc_id);
 
 		gfx_v12_1_xcc_cp_set_doorbell_range(adev, xcc_id);
 
-- 
2.52.0

