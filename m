Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B2EC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE7B10E7E9;
	Wed, 13 Aug 2025 23:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rLo8aiv8";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DB910E7E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK1xa9XKglRGhMMuOA0pOUuZpr4WHazbsCrDoKdfkM/+pzpLD7KnPMSAr6qE0YosQi4t7fuKUHDrkanl47tspPFthG5JSQwLKktvVXOgbKnoQ8Ckp50EQdBX6soY2OPa1XZgKmKiAAU9WlJZnkNeInnndPBaI6zHEkJ9jo+JUskSP1ln8jEOXp8kFTg31cEzQML5wXbsZUxtZ4x0fSnprSFqWcHlpgJHJ0Fz8p3c94PhVmGjckFyE1OdlS4U1QzCOJ9Hm+0aueiVaRXDUGDikYlZwHBnNXULCmZ7L9mp0iSXWmITmrBR5lmAJGE8IZTMJ7t88myF28u4Q9y+JtxEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XogNH3oW2eSpP82ORnvDXGlO+tt73ExucgLiEnV8dAg=;
 b=yFyVMEY1sjLKT2L+u5U/SuVnE2QP7Odo2sD1yHni2laRLfKh6T7C18YZLZ3CiIg/RZSITmirYUIgTu7kDWb//g2EVJUiPx0WgHyrFpXrPi2sr39JKTiDVd1Nu7WVClffGeWnn8vjwhfr8XpF3Ohyw+m/5/02M/mOzG3JUck3wQYiYhGl1ZYv8qsT3AyJiqsmCxDTyjx/whKDKvueZCuxRYANAO5DS/yZKUIi/UbZzSvoJOd5L2Dy7xbweE/FU/KimauahXKCAjvA5faiKPjMf0y55Bfr9gRK8YPbWD/8J+nTED0o74FxkWHz1XGm1hzQ8NmkEuOWsz1QXZs3lWrccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XogNH3oW2eSpP82ORnvDXGlO+tt73ExucgLiEnV8dAg=;
 b=rLo8aiv8p4npc2E6BE59bM8YmpL0s9/xWzIO6Gjk10Ap7vhpK2LSSArEfn8ycbC1kJw6uS3LzomQN62uiEq3Tekct5BinO/VG/x0dags+BFgYoaHkOnXay7a4HJfzCuaWsCI0gKkIesMxb3FwqfDhac1IzHVz4rKZEJEpcQjWPM=
Received: from CY5PR19CA0080.namprd19.prod.outlook.com (2603:10b6:930:69::29)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:28:46 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::bb) by CY5PR19CA0080.outlook.office365.com
 (2603:10b6:930:69::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:28:46 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:28:43 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 10/11] drm/amd/display: Fix Xorg desktop unresponsive on
 Replay panel
Date: Wed, 13 Aug 2025 17:18:18 -0600
Message-ID: <20250813232532.2661638-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abe419f-8f82-48e1-2dda-08dddac12651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpOjbL0VIF43xqDl31zI+8zyet7zGZP687S83khiHAA906q7Johx/WBPybps?=
 =?us-ascii?Q?h9BKH5yws8jYGQ/QZjFLLfsnoIKHjIdVxu76DUjTDJzuFaXb76P7bkQjduCt?=
 =?us-ascii?Q?+D0uK1bq1RBDlwOuVXRyTNXBAfMiNeUY0EqtZaLXNCLmz4eaL684nGSh/ESe?=
 =?us-ascii?Q?XDxsqwQVj6N5U5+5osWWDDX9GdIORt3zz6/l/fHYdA0NfIxRFYUptkLpnhkC?=
 =?us-ascii?Q?CQVt32kx67Ui8fEG+y8bJy+2PFSEY2GEBpzQH+2S5Btd8s+G0OAtHqF9/1wN?=
 =?us-ascii?Q?Bjz6cglRSMO68dNGhsagk6O7UyBL0Eb3Cc/OLlhgg+CBsrNKV1l9PX6nxMA5?=
 =?us-ascii?Q?Xkb4Gg+Hh8JforwrDwHrAUGZl1A7ttaArUilz8gOUOzBwXBbO9oZaQAuJGnt?=
 =?us-ascii?Q?e8QCFXJc2M1g1+0UiBC8meHhZ2Cdu+Yd8Qojd065x16fNMerB4M1cM/qbOfY?=
 =?us-ascii?Q?bcpXeKrcjdNFk6t8zXDUYKo5K4N0a9SQPnDlNdGvRcgMl3AS8uIIz1+bpGhq?=
 =?us-ascii?Q?274mr3fP4DXkCa9B5hC1UdubnYSqVz6wa+KbTKJVe087cPnHuDS6tydzrSSm?=
 =?us-ascii?Q?QqALss6jnAq+n6iVhONV1I2MIehBWEj1DVMaBg6mmYnfXfrHy6FSlTmZKycP?=
 =?us-ascii?Q?ONhHG0whg2uz8Dl4MP3X+Jn0sweJhTPXcq4GKs8/nwsKBfEfP7Oc8q8dohvm?=
 =?us-ascii?Q?It1NHBZWlL4IZ4n8+lOQ4jVSf5KUsYv7di89zoimEJ1/psHhCVvRk9NJKDjG?=
 =?us-ascii?Q?zSPBmGBi0h8i7W0aiPVaiPvd4WYKYGvbtr5upqnYlu4zeJKzVBL2zPXDWOs0?=
 =?us-ascii?Q?FjlgcBK/XoEWQCpkBOgecb4CgGfodSFDgKQjoZOthLS1UutQRiKN1KzNjx02?=
 =?us-ascii?Q?znk+KiPdGVPumtofWLBU59faQUsRTculEnQR+6o1O77AoXIZ5f3iCTjiXHWk?=
 =?us-ascii?Q?SQ9KyBreVT9u2JEhv8yqgB6NqEvliMtVZ3GUvL+W/Qz0uRj3aHYsIByeNK2Y?=
 =?us-ascii?Q?TxO7WNOleHwOEYWiJ2bdl26ky6inV9SCTQKfc8sv1/77KtJJi5ouWwDeXgOg?=
 =?us-ascii?Q?hvQA4UcQ+Zdj9k+hCgZXGHyIVDkpi9uOlyWSmQbcTwDb8N1selvEwpwS3wUL?=
 =?us-ascii?Q?i/3peWvMgz7xUjuf6rqikyJoLnlB4VH0yCEP4YcSWkWkORsxpp/dD/lkAhXI?=
 =?us-ascii?Q?2v0OHZuesNlFR3kW+62u9lpmBv/KV4wpqw1DvlmXdajz0D7XFmsIR2WZIfb8?=
 =?us-ascii?Q?gcnlDd+7gVzn4wldDCc1bCxKLJKYNOrCMakhJZW8YD167GM/3Ylid6yl+OPm?=
 =?us-ascii?Q?ItuB37eFfiqGbfrbkwVsNOEbfN3bE5BDYpS8YzrW84u/ONSQr7XrgPsnXtBi?=
 =?us-ascii?Q?Qv0V2izsawt6peLTJVCpAzzGBueHHTZBYpS/MPlU3vFFNVS/QUiLSZ8copR9?=
 =?us-ascii?Q?ssIoiI/7LjGD6lrIKTXNZ8CdNKaYJ2uozU+DDTyRRBLtVCiKJU4F1Qrgcdfl?=
 =?us-ascii?Q?JE+OB+pdBkr5CTlxSvMJbV96zYgLtiqbvM1k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:28:46.1997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abe419f-8f82-48e1-2dda-08dddac12651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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

From: Tom Chung <chiahsuan.chung@amd.com>

[WHY & HOW]
IPS & self-fresh feature can cause vblank counter resets between
vblank disable and enable.
It may cause system stuck due to wait the vblank counter.

Call the drm_crtc_vblank_restore() during vblank enable to estimate
missed vblanks by using timestamps and update the vblank counter in
DRM.

It can make the vblank counter increase smoothly and resolve this issue.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 010172f930ae..45feb404b097 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -299,6 +299,25 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
 	if (enable) {
+		struct dc *dc = adev->dm.dc;
+		struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
+		struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
+		struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
+		bool sr_supported = (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED) ||
+								pr->config.replay_supported;
+
+		/*
+		 * IPS & self-refresh feature can cause vblank counter resets between
+		 * vblank disable and enable.
+		 * It may cause system stuck due to waiting for the vblank counter.
+		 * Call this function to estimate missed vblanks by using timestamps and
+		 * update the vblank counter in DRM.
+		 */
+		if (dc->caps.ips_support &&
+			dc->config.disable_ips != DMUB_IPS_DISABLE_ALL &&
+			sr_supported && vblank->config.disable_immediate)
+			drm_crtc_vblank_restore(crtc);
+
 		/* vblank irq on -> Only need vupdate irq in vrr mode */
 		if (amdgpu_dm_crtc_vrr_active(acrtc_state))
 			rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
-- 
2.43.0

