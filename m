Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29620CDD1CE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB6310E46A;
	Fri, 27 Sep 2024 17:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cexLFgHo";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE3510E46A
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTWtWRTXDskjKe/+R0TBcBRijehnevr7IKM0LEeN+x3xJiwGyk3zv5xFp0GvATNFJn7GJk2jvukVYtjBUGT6niLtlC+TytMkc2DMRIjPBi+u31AqpzMTWlSk160AN75BXEAExbbxTPBFKlsVO27jDObAfQvsMj9GZ2y+FaiZYjADS68avOWyJGxxUksLeK4kq6KVcqAhQcVxQPq434EOGolIPIYGyCjLyCMW4TdwBCJmu4yYdSQmHf2pSbjB/VECr6dewPywL14F7QHiadvPTSHi2WP5pZ/hvfT7wjJDRwSy4zQyuV7iQSW8zxIEl/NwdBZXtxF0rKCkp9hBJ4Su+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A0I/nUXk63gpUTWSh7Qlsek6JV/GET0imi3ixw5B/k=;
 b=gP01XTn8LRJrJS8UyBwLlKKANnKKfDUxsMs6cnaEfA+x7464Fr1ze4jTC4g2heRu1uWDBb/algmfuc1yXDxYv1XIL/ylnU6aEj78jOLpNS4t4q3ta0cWt85+ILGTryTKLw23EJ4WaI4BceQUg3RdcuvqK6ivpU1d4hk+KlZ5tmoXDh4/cQ96ucsYj9BMUCdYbDoiPovcYGeSrXhMLEoPGn8tNVP1/7gYCBmloYsVREqgeROEfjck0GbwM5E2WzU5qDqXqS6r3bhrPueXGt7jCq1fVXdhwrb/OBN0DdQF8iRCka5hqBEQKszmupPSxhSHIVthqvQ9oqf1ujN3RkDSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A0I/nUXk63gpUTWSh7Qlsek6JV/GET0imi3ixw5B/k=;
 b=cexLFgHoCfK9YnnBiblHo/zuxupH/3UgpCrH2WrX+02sbK9kbzEURtF7E4bppoLUyuAedgmpChoawom3xSxqQIymycpqLa7KavMhUJtYiaJB61aCiPWvMLAxxt+b5+fmoA/qooD8wiSTXnj4Rxvmmg9oFRKMdhYm9uKtMokN7Bk=
Received: from PH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::25)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:01:40 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::e4) by PH0P220CA0005.outlook.office365.com
 (2603:10b6:510:d3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:39 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:33 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 00/13] DC Patches Sept 23, 2024
Date: Fri, 27 Sep 2024 13:00:50 -0400
Message-ID: <20240927170103.102180-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: a38bc630-bfcf-49a6-a52d-08dcdf160e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/1G6iCoMXFzfymf6tDc/DN6nJoCaSd2OiS7AMnP38L+NlXj0o734j9Z2LTUl?=
 =?us-ascii?Q?CNx6V2gSQgmv8oTQMA97XwTGA3mnSDiSHAhLpdptEVc0yUih1ww6lSZS9NKD?=
 =?us-ascii?Q?K7AYIzl86A0jNbo4dtvCUbZu9AkeKoETEl2wjc6mTHQjW/EY+Ua9O0skFDZ0?=
 =?us-ascii?Q?CAWFWOeen32lOXK1oUBUVBmSVoHr1oxjClc0GFN180kf9vvMT3SOaJFn2c6B?=
 =?us-ascii?Q?BRKnDt2uMDSzRV/pKP9AgQsRwm1xrhLxhpjWVZdxcJ6/LA0J9J/zOWX7ehl3?=
 =?us-ascii?Q?gDHIsugqGBMY1ft/hq+G+KLEULhnFJOF/cuRhNLJhwi2jPWQJJ3UEyq3TL00?=
 =?us-ascii?Q?PBsYVJaHTV1j1jbdf/iAiSwXd9XRGXf3GrbuA6B98dejqlxKUjselqiQfZZn?=
 =?us-ascii?Q?JAoLoqb1gENlIZpvAo3O0xUD5ynSI9oSUeTltoO3qlIUMNMSk3ko7B/7CTeu?=
 =?us-ascii?Q?lwtJavGOINsIyrIUUbhTebuqTix/30dQmmNxOYNrpf5cjvfBwdXIY5Y+BxRZ?=
 =?us-ascii?Q?h3/+t7AnHYIFGS6O6FSeMD2N0Z93IpcM1s4qO5deejTMZlss74eeQCdWnHUJ?=
 =?us-ascii?Q?3rhp831LxfN/xH6tmR0DRR72HFQiKGTxAMW0CDYp+gLMwcg+ZZ70HqxPpEZe?=
 =?us-ascii?Q?ehTyFBN9Ahw560MII9fw6RaWEg9YbLI0rw3Dk/0N6CcH30LZcO7jwQ3kp7nM?=
 =?us-ascii?Q?vDhhXwyZTAEXkPJpepomjC5QazeJF7x5p2eRfv/zCeA4aUibUilJ4taHVBM7?=
 =?us-ascii?Q?k5Vyy3HMccMrkRWHFJ+tMDv58+WU1n2LcAwNOLlEvxBHenupXpkHM8wQAqX3?=
 =?us-ascii?Q?d48W+l3otMPt7pi8tdvhdPiits07ptXEs04JhXALFVJ4Y256Objpl8oxAcTW?=
 =?us-ascii?Q?9peYQsDdJlPLsqAqBTvuDL053+PSkK9YKm1ook83eD0ZsQBUI2LDxWDU3S5x?=
 =?us-ascii?Q?YEBExBYSaah9a6H228WD3GgrMAbDxbhH8L9+RBxgP8dIJSXjdJ4IlepzhYk+?=
 =?us-ascii?Q?UFut/ZSGYpf2RheVjg8S4AX+WDB6fmCMpSf0yHs++2KBg/jQsP67Mnmiix9P?=
 =?us-ascii?Q?64PpDndnJQCn64O3PIXYvrlw2C96NeEJ+TG8eDRQbnJ2MHE9DWGin8zoSMM8?=
 =?us-ascii?Q?yLc1bAAju+F3lWCYPwM2NS065/qQ7TeLX9IzDd1YsMIdyd/40vQp/YtOhCRo?=
 =?us-ascii?Q?9PAMl4zkZfmS2Zc+JflKxusT101kijL5kul6U9+jAgsfiYLTfxxPgAoNwc2L?=
 =?us-ascii?Q?7b7HuG/pfrvkkaZLAUgnx5ZUZtQkPIcpyWzan8wo5QRsRlITH6fZltWVbOn4?=
 =?us-ascii?Q?iehIKUb0FMUCNWrnMIeOVXYYdr2DWEzTVxcdOMrM+06YKA2+iVRB3wkgIp8H?=
 =?us-ascii?Q?Gw1QiXEJRgaRPuPAHDM1wMx+cJI0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:40.0399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38bc630-bfcf-49a6-a52d-08dcdf160e51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Improve brightness control
* Add support for UHBR10 eDP
* OPTC required only for DTBCLK_P for dcn401
* Fix TBT monitor resume issue
* Code cleanup

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (3):
  drm/amd/display: Remove always-false branches
  drm/amd/display: Eliminate recursive header inclusion
  drm/amd/display: Removed unused assignments and variables

Aric Cyr (1):
  drm/amd/display: 3.2.303

Dillon Varone (1):
  drm/amd/display: Configure DTBCLK_P with OPTC only for dcn401

Liu Xi (Alex) (1):
  drm/amd/display: add more support for UHBR10 eDP

Muyuan Yang (2):
  drm/amd/display: Change Brightness Control Priority
  drm/amd/display: Introduce New ABC Framework for Brightness Control

Ovidiu Bunea (1):
  drm/amd/display: Add IPS residency capture helpers to dc_dmub_srv

Paul Hsieh (1):
  drm/amd/display: Add logs to record register read/write

Ryan Seto (1):
  drm/amd/display: Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.236.0

Tom Chung (1):
  drm/amd/display: Fix system hang while resume with TBT monitor

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  48 +----
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  78 ++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  39 ++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   1 -
 drivers/gpu/drm/amd/display/dc/dc_state.h     |   1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   6 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  84 --------
 .../dc/dml/dcn30/display_mode_vba_30.c        |   9 -
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 187 +++++++++++++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  11 ++
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   6 +-
 .../link/protocols/link_edp_panel_control.c   |  43 ++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 157 ++++++++++++++-
 .../drm/amd/display/include/logger_types.h    |   4 +-
 18 files changed, 521 insertions(+), 177 deletions(-)

-- 
2.34.1

