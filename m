Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C51BC3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88B910E397;
	Tue, 13 May 2025 11:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uRGG6E7g";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0484810E387
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oas60JzpoN72lLrRdcy6rpmAPG7y8mFagW4OLOsrd9VI7Q0FaLnhsjThcpG97GCm+QBIzXQxz5rU4Dlgt6Cz60UbPknB0hl5S3NRiYzfPVBYZmdu7hx8xJuxYfpxcWRqIdbLFVCv4xDpCt4p5XMpP1KwbBAIGMByMqxZOUXC4ZKFNyfCiaqdwGtEH2gyILq9cJAJyq/cN9HGynGVrTV0kdiJXGXMNCkBiNeBT3dFC1Kf1Xb4n1wb1MqjoSSOL5ovjF5Aq8DfejPMUr2dgh1ZMgoj+CTXKhWEF7WQIXtn6FIHlngwm4/qY5M6sMamID+8nHIuhzdWV21umsMTo4alHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMiU+uEBZHjOPz9QWrMkN+ExwdSrhSp+LoQ9Xam7Spc=;
 b=KFKhp7yQxPMFruQQOTLmvZrUq8z35t/GBKtjxuhZGi0ea1+SmfstMFIPQFkAla7do8tSfGYRpTu3Vov3+JakWI9j/VG54tD3Zw6VAW8r23EDYuXDPYiUa1v3J1KA3p5LT0eHprUAVZR1b5gFGwKZtXoJq3ZNHkYEJQNkHT+0+0FaPzHvNb792JXxp3xhWAWAWLEBqoLj+tE9Bl9ExBYsxe6wVhXDMaelZx2kyUYBp0YXim3V9CUK47/F46v7VZFQ+zG6+OsyFgQB76mynOnJwPEW5VaIG+IhCDhlECyyPtHPRJH3w7+p36fuITwI9S3XQ+vie6VPP41PjocZ0oY9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMiU+uEBZHjOPz9QWrMkN+ExwdSrhSp+LoQ9Xam7Spc=;
 b=uRGG6E7gEOhn2fI1gtWSpzVBS85li5/KbnoDBgFl0xhelitZ+XZ1MkJqDgEdNEA+SFhhwyF4JZY11hfhhJLpsIF9P8dg+attR0Tj0naga1PI3lgQHDPd3V2yxzy2e4Ahpip89T8mj385Wrs4MCfWMGdFjbBqKed2Eq4/5EK4ehE=
Received: from CH2PR15CA0012.namprd15.prod.outlook.com (2603:10b6:610:51::22)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 11:24:52 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::3b) by CH2PR15CA0012.outlook.office365.com
 (2603:10b6:610:51::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Tue,
 13 May 2025 11:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:24:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:24:51 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:24:48 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 00/11] DC Patches May 19 2025
Date: Tue, 13 May 2025 19:24:28 +0800
Message-ID: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: cbac46ee-420f-45ca-9d91-08dd9210c787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1je1VBequEJKOKojOi9iE1chHYRRIpzqArbP6hm902nxvm+yF37ItKFSZMy1?=
 =?us-ascii?Q?QqHlkztrpl2bI7UaJL0c/vJlfGvouuq6QSwkPFffnKE2pjX81/w+ho8JGHL0?=
 =?us-ascii?Q?RGVjYMuReqlVzYJhX8H0072UDx6thCZwP19+9mI6dj92DU7OXKWqE0Ogtb6E?=
 =?us-ascii?Q?bPHWeGakgeyeb5fsy8j4gfvJrtC4UfuEuHrhXzVIvMwNEqKF9DwTDdc5GE5T?=
 =?us-ascii?Q?gN4QnZsO+1TyoWPvryVGDYNlyj00ZXnqhupn9n5oMC+eEjxppHZeWwn1fcW8?=
 =?us-ascii?Q?KSmj/WhQYcWj6hr0YqBiPeQD/cnton7NKV21O4HkBJO8WEivU7pSHtXs0duT?=
 =?us-ascii?Q?bI44owfgNDlGFQ/fKSG+mfP+gdTxIIrNWeBX3CwWR0JhQQN196YcSivXnwEx?=
 =?us-ascii?Q?TPXTSdQ2O/pKBqolTbcdRXpDgafVP49/YQQ7EesC6k8BdUBbkPTKWbTPwYhX?=
 =?us-ascii?Q?L0TnLFeYRBDYqmedOQnZJBWwklNHWw30XA5e7eaz3sHqaScNYUtZ/e3p1UU4?=
 =?us-ascii?Q?mY1KpyRaudQstxrOy8eqZzwGdTFtS7SLWkWUBZ14h9PZ7s8uZd/IESd9+o5q?=
 =?us-ascii?Q?X+9t1uB1YKvWlswHkMRtqd18p+2ogWKpr33c/wVYWUeik8vQkzNgBrMTCVsa?=
 =?us-ascii?Q?bVJ+Ur2hNTogsYMqG8n4ZJ7dicuqRfkA1h0HYHuVWTJVaBa3zmnaQJn5UU8r?=
 =?us-ascii?Q?ecjfAJJr4KChQGhypmCugpz8i24H7BcJavcvJTAl6WJL84XjMqmEroATs6YP?=
 =?us-ascii?Q?1kyPtla/ddi4EzmZKowP1SnTXKHhNzcRqj5pPgTResyNiOB6H+GeDI614mVf?=
 =?us-ascii?Q?mIVWekU/4RmwyTqqWGoyM2LU4qUFf3hNXNUSirj7rmSPOwSLWxADryBX0epU?=
 =?us-ascii?Q?dJb9ruEfPh16CcTlPxLP/W6SB4nFnbrRsDHy6f2jN3zEzkH97vLw/2ltMzWB?=
 =?us-ascii?Q?aBpz8oWrXuVE55Ua5Tqg7G8+fMCwgsIrJB3L3Rktb+lt6JRuxQ+pv/gskvWb?=
 =?us-ascii?Q?OtDTqO9F18nvqkJ3neAYl2yAUpBH1gBOdPjgg91+yAU9w+3rnZC32yLTMsjH?=
 =?us-ascii?Q?uvV+NPj47vlGwb5AQqXRPW+w0Ka6pmjeqgx7yC2T0uR8SuCX0531ToqH+Ch2?=
 =?us-ascii?Q?qemdwUNI9W+4juVzZu71E3EoLMtrY1utFVmtP609Zf1QfQJRX3z88XC2FvsL?=
 =?us-ascii?Q?DVbTnTpyAuvmaGnbeH9w08fBkM5udex0BOV7/fVYv32XcrP99USIYqDLjOC5?=
 =?us-ascii?Q?zo3C7w45NUus5A9mxMGIi376A9NnsWhOZAhIqX8YPcNzcFN1CKZuSGPYhATx?=
 =?us-ascii?Q?uQcaR3M28EKOWC10nq2P3u2ks2VjMY9n9hRIrnWJOUMi2Hii5Na0s5gGEj8a?=
 =?us-ascii?Q?AQTiV48cTP05yqJn2FqI6GZ8t+cIhrfTZhJe/oM8C4UPfg/BOGfso3iG+gQT?=
 =?us-ascii?Q?iHzApxHWR6yYG0VOeUM6yoVi6EDn1fZ5m6nF9dqD20uiLe45ERGS8C73QkeP?=
 =?us-ascii?Q?7wGAoaknoye96YrdG+cCDoHCo+5AyDIdfvm/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:24:52.0405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbac46ee-420f-45ca-9d91-08dd9210c787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

-Support external tunneling feature
-Modify DCN401 DMUB reset & halt sequence
-Fix the typo in dcn401 Hubp block
-Skip backend validation for virtual monitors

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Chiawen Huang (1):
  drm/amd/display: Skip backend validation for virtual monitors

Cruise Hung (1):
  drm/amd/display: Support external tunneling feature

Dillon Varone (1):
  drm/amd/display: Modify DCN401 DMUB reset & halt sequence

Karthi Kandasamy (1):
  drm/amd/display: Move mcache allocation programming from DML to
    resource

Nevenko Stupar (1):
  drm/amd/display: Fix the typo in dcn401 Hubp block

Ovidiu Bunea (1):
  drm/amd/display: Add GPINT retries to ips_query_residency_info

Samson Tam (1):
  drm/amd/display: add support for 2nd sharpening range

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.11.0
  drm/amd/display: Promote DAL to 3.2.334

Tomasz Siemek (1):
  drm/amd/display: Extend dc_plane_get_status with flags

Yihan Zhu (1):
  drm/amd/display: init local variable to fix format errors

 drivers/gpu/drm/amd/display/dc/core/dc.c      | 10 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 13 ++++
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |  8 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 14 ++--
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 21 ++++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     | 10 ++-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.h  |  2 +
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c | 40 +++++++++++
 .../amd/display/dc/dml2/dml21/dml21_wrapper.h | 64 +++++++++++++++++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 16 ++---
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 ++
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  8 +++
 .../drm/amd/display/dc/link/link_detection.c  | 21 ++----
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  6 +-
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../dc/link/protocols/link_dp_capability.c    |  8 +--
 .../display/dc/link/protocols/link_dp_dpia.c  | 54 ++++++++++++--
 .../display/dc/link/protocols/link_dp_dpia.h  |  6 ++
 .../dc/link/protocols/link_dp_dpia_bw.c       | 70 +++++++------------
 .../dc/link/protocols/link_dp_dpia_bw.h       |  4 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  4 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |  4 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 34 ++++++++-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 16 ++---
 30 files changed, 337 insertions(+), 115 deletions(-)

-- 
2.34.1

