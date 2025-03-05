Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067B4C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCB310E6EE;
	Wed,  5 Mar 2025 05:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ebhT9UCb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AAD010E6EE
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRPUqiPf8YgYBqtEJevNghHOt7YU8DEUjWjkWBl0hEnExd4OYkooZdLF1OkmVqRjMM/Idy7Tky26wrQQaseuTN9o6v6sg39YJBgMMcI4zrkkuHACgc11I//1Wr+eZ72aalJEWx4pIrIcXeA186QZi04fEuvx9nC57abWu6w3jay73EYyfR/O4pVuBvmsvvZ5u0C1xvwaRzpuRGSFXf/V29eUn/SODu8UwOUpaCMkRRmqoeysHUnWw8Sumo8MPIvYW9nmA5ahPAP6EAJl/wh0XzSoW9XXZXmW1sxUsYzvcIJZNGfFLOD3zolGueaJeYFIPyYLh8ZsNuxQtAj2IIIUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PDqRWNAAW5Hl5LlPL9QQfEnLN/iZfNT5JHNsrjUyOw=;
 b=POcf9BMA+FfzybLxRU2gh31hiKPISUtBe+0589w2Mmj0D6oLmcq1xeiGpbgA48qur5gCNM8WEB69x/VTlTRGqCOFsHZg8w9/mj0s8tTzTSIdOK67VivsUF9ftRIy0xG3v6rWEN6O2u3CBoUpXkacxHWQ5eo8bTen30DTHM16I24IQqjgl4R8d4pxSI5iuj2oE6htfaIIiPQcI+2yWmLn3JIJOL9AG6SyEZVW5uMZ48bouxZQruESkxsQrZnRhbbWLobIBZnTJGfaGsyvKjbEIy0F0YzOMzyv5Bhc1dBCQ2S6a+PiNAYbxDsB8p+TRFYq74+IINAIXh3eADU4um7U6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PDqRWNAAW5Hl5LlPL9QQfEnLN/iZfNT5JHNsrjUyOw=;
 b=ebhT9UCbnBLU06SaV3fun7+mZti3lQskbEgymnCaVZUZNQncHHKLW5MciKcFiXjmfquk4BuPxWNgoPEBNciWPz+u39FO0+PV6UymV0eOIx/QrOGRYNDGLFR552gO/IMJdcZZbdy0/bx4QB4M6G55hDjeXXYe08d7+pofL5XOT2I=
Received: from MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:17:50 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::cb) by MN2PR22CA0025.outlook.office365.com
 (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:17:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:17:26 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:17:22 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 22/22] drm/amd/display: Promote DAL to 3.2.324
Date: Wed, 5 Mar 2025 13:14:02 +0800
Message-ID: <20250305051402.1550046-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe2b859-69e7-4afa-82b0-08dd5ba5130b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k6OJarb07hpt69zlCF/mMwv5FWgPF1zsYmF5m4WrVqO5QiSG5ZdmSR+CjeFG?=
 =?us-ascii?Q?Am1j4QB+9G2F/26kEy1aa/dXRb916pyEAHyG5PWrBc0MQCmIGCRYnLwaqABl?=
 =?us-ascii?Q?7QeusfvdfynZJYVfd1sl5iw7dnTpQXlPzui79+OWh0VhIDbxpsUJIiHcC9o0?=
 =?us-ascii?Q?rAUzYHSaBaUjNHtYf7iAEsJsOxbKjLJpqq35ONBRJThphojrbYzNMCAnUVk6?=
 =?us-ascii?Q?hxcQjPMISN8RXiaPP2DBI/B4gu2XMLey0WQwXSlTEpb5lkTmKPn2rPKkZ51y?=
 =?us-ascii?Q?f/3PJSLNJxWGPOGjRsKCrd+B2GeF6v/cO7s608KWBOvnfyO7p2fW1sTw0pPD?=
 =?us-ascii?Q?Zn+X3wxfQLiuyDbVBRUcH2afDTUR/zlL4DgDXIcpjNUXCz3h9SPYUPjbxN7v?=
 =?us-ascii?Q?/UzDHic85YrGkMQ0o2dunUVuHj2UFZTAHUU9eyYZueEMDITNbDWPlGGVMwtK?=
 =?us-ascii?Q?uMuDOVWgDn3yVSwCnxzJ5dhtP0dRCV7yC4czTaGISG5sAAfGEXWwnNnEEBQv?=
 =?us-ascii?Q?HPZ+5xI3pA56kPsH0afVMwbi1RxHn4E/PJCUbBdFjT4DTWyAtrM4HXAEuhsk?=
 =?us-ascii?Q?I+Seq86r4xdCQxlK87GKKiNvbTZ0xIzzXLb2YPq2BsbB/vtvN6ZgAuhiid5V?=
 =?us-ascii?Q?M5MoABdT5ptjb+hVNJtZCtEIwyyboHbah08rNdf5sbxp/KSIbEWAs8lHkt3c?=
 =?us-ascii?Q?KPBpF+okApjAzyVa3q5zkB5jqXrFNXFUpuebKk250WknSZq4ebHPx9OkghQ4?=
 =?us-ascii?Q?76MQuSoq2+UaCe5+Fh46bVSNjOdE+jsyEopZBugg2Z4wCpp5jeyPAruCahoo?=
 =?us-ascii?Q?ZWeW97hEdrtAVn8uV9FkUcxfIW35npBqIJVkLeHZ3vqziHpuGgdUL2yp5pv7?=
 =?us-ascii?Q?AysPRclZHu3Q7yH1g7e3UipZWAtnvWjgXjr4q+sgxKV6x645T4RTm+PCwKY1?=
 =?us-ascii?Q?jWJmgaapMIKopDl7uwKnF5f8BsDpr0FNVx5pmwYTWE5YXKjCk+a79dR5nDg5?=
 =?us-ascii?Q?JHKw3qhy/ittRD/yg7aYAcWyrOd48ZBzd7GGyaeiYwhWjr/pZ1afXcut2HqN?=
 =?us-ascii?Q?YH+2oCqQz87nVx0iRPqjDIUiyMQywYBVJ2tAtN/US+iNyPqH0c5KyzeAaoJR?=
 =?us-ascii?Q?GTY3nbinm0lhj+I79zMeY8ZcNDonPR2NROHDaBcflfP2EsrgeoM7rGpa2ZcM?=
 =?us-ascii?Q?SmipS4L3xD0HhhjCDGcWRrCiadAqjp7CocP1jAOpiYz/4hdY2V4hcXjFfXLP?=
 =?us-ascii?Q?V/CfekBqTFj9UXU7ZTS+nomfThuGcCg95xdryiEk5XE7fmmofRB2F1YsVadl?=
 =?us-ascii?Q?jIqTSeYVe3S5aeInvZldPicDfEhq9Sn8xy7VgbiAkVhuQFEiPs5hlJkWob5H?=
 =?us-ascii?Q?vsWffbw6Kuc2cNMTMPzyeKCECRo05cvF3WdUrxU8oeY0zHtXotHLX6nd3rRN?=
 =?us-ascii?Q?So1/L2AtJsKHF4s0Qh61Ozy9tUiECrP5fYtF5VXT3nGtlSBrC6nDNOPnqEsf?=
 =?us-ascii?Q?l0++jy3SIN1erOo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:17:50.3262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe2b859-69e7-4afa-82b0-08dd5ba5130b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following fixes:
- Fix some Replay/PSR issue
- Fix backlight brightness
- Fix suspend issue
- Fix visual confirm color
- Add scoped mutexes for amdgpu_dm_dhcp

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a62c4893e5ff..67e1bb6fa335 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.323"
+#define DC_VER "3.2.324"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

