Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B96E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB48010E989;
	Thu,  9 Jan 2025 03:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B4gIIXIn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECCB10E989
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH1c4PpjkUrxUagoT0vuQ/qEvGFGuJ8+fLlkMGzje7JwLgLLQ1WJYxf86XkjDVikYOA7Q8AXqXYsTKZWVkNqmMA+MH9aGalT2SLHsrBOLVBetssRE2W2MQ+ortObo/F+F4DYMnaDQcHsYAGU8cyAquoe7F7Zz6e5xlmt0m1EcIWTVOP61XWZyveY2Pv0vjkAgBP04xo+k7XmcBR2qUszWWPMmf2pTJu0sqJ7EkE1PFuyWCDkTBlRGthxMucmw0PZps3UMNO0d/kpDdXQNmIHN9Otb83HV2Ew1HPxfOvccLxhP9mLOMTyy7AEIJHnIyECLiRRE/rk69oD0k931WozaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JofGJYdw/mAmDxOIXQAJDrPEV7Hu4eAD6p0NrTL42Ms=;
 b=O/LCAKSj1R6deo/nLNmRLtrzJYqgbi0U5jZkuSYxrvGVX8oPj6X7DUIhUMDR94XmdvgSL4/C//EU5ffL1D9ZSejzMZrzd7KAOGYfU17k4Zre0fbmQBE/IvOXffoapNyiZCw+NQWrboq0q0fewCWWi0BNZDsq45bvwBr53iMOLDxouF/N2pZrts33kGyAC4KXxhzAUjs5UFBvMCch9SG9KEo5vDxvgs8iSDHYucXwGsshquAAvdAguRq+/l7naMhxIb4hhVBjsTdU46TXME6AdeaWxU2PF06M9BeNFE00sijcCLJuOWWlBnCZT5uYn5YeFSsY2lxm2BAA0QyGZNfVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JofGJYdw/mAmDxOIXQAJDrPEV7Hu4eAD6p0NrTL42Ms=;
 b=B4gIIXInEr5bH7+wmR/srBu0rhdPmp/BngTTg5J0rwGASYEVE2+kasxzbcqv92PkpJcnSrCyCwvtbQGRYz4Zh9yDW3iNVcR9i3Yru3wdLEuFt7QXEXhQzTz4H9AYDA0nNsmxxivv22RuSMAhwxSaEOkanyWadu8hGCWY+4Eeu08=
Received: from SA1P222CA0057.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::6)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 03:05:38 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::16) by SA1P222CA0057.outlook.office365.com
 (2603:10b6:806:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Thu,
 9 Jan 2025 03:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 03:05:37 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 21:03:02 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: add support for NBIO IP version 7.11.2
Date: Thu, 9 Jan 2025 11:01:29 +0800
Message-ID: <20250109030133.3887086-3-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109030133.3887086-1-tim.huang@amd.com>
References: <20250109030133.3887086-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ec0d0e-7ef0-4f8a-b79b-08dd305a7e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oeoxeTCtpmEz32pGmM7MJmqH6eB7Ssh/fkYjwkpiq6M6m7ZDmYgRz4B6PhGO?=
 =?us-ascii?Q?LiqSpzDiCq0bGUMFiLS/yQ37pI8G2D4XVoeR1jhnor1n+ls9BdvAu6F3mZIf?=
 =?us-ascii?Q?Udn70dh1rQCx/GX9qbJySXY4OuJV7knKHD5GUbMh03Av8VmwNBJMUOfa15qi?=
 =?us-ascii?Q?bEqxh5Tb69JWN4Vrhglsn8RIDrA/ptNWGOqFAGusB/AYeIpcuichm5l7tzZC?=
 =?us-ascii?Q?MQMezlUBVbBcS4N30Zn9LJiVyH5KletOBh+TLI4od3exjLzKslSobiCnySGn?=
 =?us-ascii?Q?o26jvkcqTGkV8lDpGkioQVGDJENGpdx43YZt8EX2CWeL+6DoqVDzhNCZ4i9C?=
 =?us-ascii?Q?8ATVxWDpIiBS8etdvjMM87WGn3EywkYT0jl4g70M7P+fB1hJT7XJM496AOhH?=
 =?us-ascii?Q?wtgnZiyQdgFmiJl5RQMrZJBhRvwIK/5rlNkvwiqc+pdbt1/8t4S38y63kO6f?=
 =?us-ascii?Q?Bo5A/Tyf4+5eqMM0GhPUBYyNrZAxqkYwKpUx+nyq+1Im1a0KwZIlpyc56g2b?=
 =?us-ascii?Q?YSKgAFiLg0hlXMii+hRb8SsMxf8Th/hcAlMuCy6iWTimrDo7Rd+Lbr6sXHnc?=
 =?us-ascii?Q?j5MmdMW4gfnT992d5rVJtb+r65fskxgo/EkyAOBCHs4bbp1AJb9Q/WBco1Lg?=
 =?us-ascii?Q?iPsGV+tp+RVnRcXZR35NAewDbY6clHcMa8tAY2GOtCm/pY/AlTr1JmqOUrpA?=
 =?us-ascii?Q?TcnxfroX6m9L9HyKWKghYqUs7cIU25rR8nJi35S+WS/QuJThdwBT3TvOGGMe?=
 =?us-ascii?Q?Q96/v/KonSuNX/3n6XVV2O0bJS0n1bDoC7DsSsHRWzo8vPik3XxH7Ml7UXzS?=
 =?us-ascii?Q?5tOx9tppaZH1Ygr1Yytg08VK0FD2zxiLNrvw0ndAa+n6G3N6aT6XklpAbTDn?=
 =?us-ascii?Q?PHoD/uyqKbVcvXbaJx43v6bfMWnKguPLW3N29l0mBOzzXU08qW1KH4QMryRS?=
 =?us-ascii?Q?J5/zoakyMC/c5tSHoxFUfS9otd+iOUoZN8YkaVoUDuV0P9mwbDADKuEUELSP?=
 =?us-ascii?Q?ODhi5TZVNlThLfinevShMo3vh7C2tBH4Qlj9OVqWks51ysiErzkvGh2i3+LM?=
 =?us-ascii?Q?fXiIeIsosi+bXIxx2zptWJWjm9LxxjbvN8tBf+wsEzKjPIeLafpZdkuSQzr2?=
 =?us-ascii?Q?HTIrRJrUwVve1NnMgDFT4+70dLx+MoEZZZWeRffMXi0RNXZ7JBjKFO8TiEhs?=
 =?us-ascii?Q?jJQ1EKe7yaFE/KzUPOfnXrHIHE+NeKxIGIuEtFUd9eo9r0xX/A56ky5NSBuJ?=
 =?us-ascii?Q?2MDnxVKHxyHGzI63axbKdy4dYlpqzoBNcX6OGn97ZWiRv6J8Kwg10vjDb30U?=
 =?us-ascii?Q?zcxVnxwglaop9itowTrNIIG+AaHUvHoV21l8zCVO09/pLNkGrM7CbBjZiws/?=
 =?us-ascii?Q?G5LO3Ot1a0sNXMBbtlTJmtsLtqpusOc3T1kJlFWvSYorKIxosE/kIqPBQQpU?=
 =?us-ascii?Q?VfUYYmHUE8Uuq1u1XFmxzSkjfZi6mOGCkfJNIc5lWAe6cUEc//yBW5Ir3+Be?=
 =?us-ascii?Q?wrMcoH/dx+o1rt4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:05:37.9360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ec0d0e-7ef0-4f8a-b79b-08dd305a7e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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

This initializes NBIO IP version 7.11.2.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 27b90fc7967e..49d3d017c657 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2778,6 +2778,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(7, 11, 0):
 	case IP_VERSION(7, 11, 1):
+	case IP_VERSION(7, 11, 2):
 	case IP_VERSION(7, 11, 3):
 		adev->nbio.funcs = &nbio_v7_11_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_11_hdp_flush_reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ba889a85cdc5..e1dad7ca5b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -962,6 +962,7 @@ static int soc21_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(7, 7, 1):
 	case IP_VERSION(7, 11, 0):
 	case IP_VERSION(7, 11, 1):
+	case IP_VERSION(7, 11, 2):
 	case IP_VERSION(7, 11, 3):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
-- 
2.43.0

