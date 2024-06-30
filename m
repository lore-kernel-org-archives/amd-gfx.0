Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC86C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCF710E047;
	Sun, 30 Jun 2024 14:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E2MnPm/B";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E22610E047
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPCBZpd8F401Im1mGBMzSTwF+umfMZETAc7Uwin0ozwJ3E9gq9XWAD3m+W9LKI7kU6nOzxDQX/pUbKz/F3yrd+bDxk2bmBMaBgsAN2QL1CiJ5f2K5OmbAsm6SLorDSX8M3s4mQLkfKnRW7RMJtiHkkJI7wF+cBlt2l9C3VMo1bdE8pnihd+/6i+dkiT4bbDBSyg8C/9So6wPd+mJA1kuNeukmYc3hOVy8BAj67EneUDpUhUHt5bSZrMV23RRuq8r8nrblZY42vhFm0ozQAH/cdiCRtdyOuqf9QTokQQT1fGnGS/AK+fNJOajJo1o10XTso+a69lIcZk37SAOkQRNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTVGcZXUheQn7dB55YwzeduCoOo7uu/l8KF4qBQWWtM=;
 b=E99ALe1I5a6lpAt66Y7mQBIrNIDDdZz/51xg82SPNdGxvml+OIi66UejdyOyLjkHPgGlGgGyof9XFSg6bpThagWvctPdTQSx47WyHGPIimL74B6fSv0bN/kQG8cwk0nD+0NVyM1zEhRz48WixSue+L3JHAdTnW4W1SqebiD5H6D3Dc+gvINKW9PWd4BJNgnBO2Qa9hH2p0c53mxdQiS7jt5HOsP1bt5h3eXVBCKWAHuvTCqDCP0Q8t600mghmpHNLf0VB6pXx+tcwsxqeUg1UvnfzLoTI3NQogHpbmsWyCVeijIc0FiyZ5/2rvVKaaHXH9Xp2IbxSu7EV93y5ArhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTVGcZXUheQn7dB55YwzeduCoOo7uu/l8KF4qBQWWtM=;
 b=E2MnPm/BHUiU//1PZJ9MXbDpiV4G/gJy9eaNIjaGcRh4dvn9zNdMCWf0ZurnJbxycjobhK/QLdwvyh/BpNf99TQt0+koKZjhl4lWqeg+QrPF0Copu+6xr7+7PmZ9vFRLxTlSMe/hf6il14jHTioWTXVQJRxdXsUpi7EewEr3Eak=
Received: from PH7P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::31)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:40:46 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::19) by PH7P220CA0032.outlook.office365.com
 (2603:10b6:510:32b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:40:46 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:40:44 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: initialize GC IP v11.5.2
Date: Sun, 30 Jun 2024 22:38:30 +0800
Message-ID: <20240630143836.2015991-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 781aca0a-342f-41ae-0623-08dc9912a0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5YBJQVpPHPOtmWIfLbOcErYMq5l1uyq584dtQ+ZNPuAR9pU+xisM2ez03ikY?=
 =?us-ascii?Q?lsYQaagyNneeTraBGjJBKrN92OymBxQGvGZ1E+QCwBtwyb+m/CJoH3583Gwp?=
 =?us-ascii?Q?OdHAROyC/w/P1CUTr0+oIQ52kF/Z+8p3IRDNWtrH71cIZ1yfB1D8/2mMBQbS?=
 =?us-ascii?Q?YdThabj7diqa6niPp+Hine2sSNiBtw75LZnnwub8wcMmRuAvdW0KEHZsqB4W?=
 =?us-ascii?Q?tNC0TzGLQjw9lktcsROxkJIs2xAeN+42SRCdGXsZ+0SKXH1qyOFYT8mXAvSe?=
 =?us-ascii?Q?9Jd4W7q+VBqjAkY8jTSKNP8WDXo8FfBgJVJ9N6zUyLrxeSvM91Cobu6q6+x8?=
 =?us-ascii?Q?wn5dau4eqkiCBpXKNY29375K2fHsPftxaJrM7fdkOT1uMI2s6CJc39WL//q+?=
 =?us-ascii?Q?EWcfL+ZsuybmkYb9XHGbSveZiTMqrkpetxiDJBBi/gAX88LtDecGaJkuGFMY?=
 =?us-ascii?Q?NVfR9E5anJGOBpVj5MTCJ2lR8YOWUsBnznFT+anxjhL9aYcroVbtf7C3+SK3?=
 =?us-ascii?Q?8BoAPbVX5y1/KMG7yCBg5Rqu0Fi8YCsAgbf6ohtNlon+ihaYWUXj8eQi5gXs?=
 =?us-ascii?Q?zCnPsZVi+FTFiwwBMVpiUVSg0a/AOJbdDAAE5HopKJQHoLcjbZOtwnp7PG96?=
 =?us-ascii?Q?ZHpmwbvnah7ZZkOieMGljOhh7aeI0z88eID/5IraT7A51H+2Vr95bo8tDMdS?=
 =?us-ascii?Q?nh/OOrHWMex7CmEE1spYsYtejsQbpkE0dGtBG79OswgnBLyeN4HycNKOFsxX?=
 =?us-ascii?Q?OZQrW1YUrzsXb3g4DpOgn73kyJ+pR5TELT93xaARFbWy7VLqTpYyQenrBIPA?=
 =?us-ascii?Q?hXm02nmxbLE1CA46f7vOK42B5rXtHEhfdGOXuQ0fXYF6B3UYSx4QeR6qQghe?=
 =?us-ascii?Q?W+JO5d0IqTbEwIy3Y6fDaYsa6dYnvr7qPh1PgUoKOWzDPgPdxpvI7S9Z3E5H?=
 =?us-ascii?Q?XLTrhUvDruLZ0wRU7MXwrrPKEb0lCfzPaMyXij7vW1WtbyZnx20Dp1CJcMln?=
 =?us-ascii?Q?QGq9bC9FCGcZp7CwDiHI6ZzQRG4POpqZaboneESHR3mdRrFD7ZWxAEVjbFEl?=
 =?us-ascii?Q?boG7H/3jq7z0d9gNdOyxpGTXobgnIDLet8qr42Rd+VjQ+XDVwc8EEyP3/6iH?=
 =?us-ascii?Q?ta5LgoSkW2Pj+rcy8iFgWvZ4srgLKl88ll4bEWj5FI5eHpnkgQeUVEibSlFV?=
 =?us-ascii?Q?XNRWbD63k/FZtDRDjrZoWb7aiekGOYL+oVX4MjFXOi94XmjvjHx2iN17DHfk?=
 =?us-ascii?Q?kYu4/odItU7LEN4bxJf6krzKMzxcmjBWxNLakoYjt7Fcpm/VFqNk7f8aX8fM?=
 =?us-ascii?Q?rVbQ+UYizxd4PxYEsaVu18Jp03xguBjHKepfzu9/A5Osko9nEIQmDiGvFpzw?=
 =?us-ascii?Q?DwRYkoF2tSHeBuKQKrbU6FmHv/BQODUg0zbvzgUrak84RwwfQJa5z0VsvFku?=
 =?us-ascii?Q?AWqmvVbiVzcAayr8cZ+06KdgOpjG0q6l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:40:46.4124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781aca0a-342f-41ae-0623-08dc9912a0bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

Initialize GC 11.5.2 and set gfx hw configuration.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0d078d0db162..9acdabd7719a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1054,6 +1054,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1534,6 +1535,7 @@ static int gfx_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -2782,7 +2784,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 		    amdgpu_ip_version(adev, GC_HWIP, 0) ==
 			    IP_VERSION(11, 0, 4) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 0) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1))
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
@@ -5296,6 +5299,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(11, 0, 4):
 		case IP_VERSION(11, 5, 0):
 		case IP_VERSION(11, 5, 1):
+		case IP_VERSION(11, 5, 2):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5332,6 +5336,7 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5364,6 +5369,7 @@ static int gfx_v11_0_set_clockgating_state(void *handle,
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
-- 
2.43.0

