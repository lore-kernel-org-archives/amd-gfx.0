Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE79CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B389810E4E2;
	Tue, 13 Oct 2026 11:16:10 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C811910E4E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JefGIvWVOJKB5sOG/NPTHjis6EgPRVnDS9amCcJYFkg+UzQ2WDUx3CvepmH8wD9iNCVnofO25JjNqv4BWCZU6gwSqRGLsABjxHJU4XuECoPWPAhq59LtpdUc5OJWqWjNF5mh9RO92Gs2Qo9eBVZNutkm0sngCE4tMpkpdfCUJmDtesDe4bXaSaODa+1gUBjKapSANA22KkT3TO7nSY0S+WdJNPX2yezJOBSvnJrasoS/JsZEOD7cPsTSGczzCtDMFVtXUm87YIbI99psQJBmW+fy8IpHt/INXBMQfRfwizg5dtX88uApvwNl8rMq/XeAaU9hfE6zA6lEvgMNiKl1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+xlTk5spgOV+oYYDlbIXKWFR0XzgjhnCw80zQHYK2k=;
 b=U0iqM0zFsUb7rY5TB7a7T6oqVDY3G+52i9x6jBUSlqMmYF/pedFzae2JhZQg5RCfL2nQlE7jgyrXO2plE735Zflxt5mKsHZ6tanWbkdmxSAFXMerH880iT9xe10OaQsH/0Qr+P1x+5WS+ULiUsLT6Pop4Yfl++U7ndNB5XcETu1aOeZtQXvroBwMAt+kANcKEoJMSWyL9JKVAo7VbMBjnXaHDfHWfoZgElR7ZBuyMj4gkA6aUpYoWpeLLiWXO/B8jtn6JjcElLuSItPMOyLoNrivjNBJ76eaeFcwKbkYyk/0ArmEgpqWPJZRU47sNK1DLKGrNdBJDvefAdHsXyPYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+xlTk5spgOV+oYYDlbIXKWFR0XzgjhnCw80zQHYK2k=;
 b=sdjGKMRkWVMTlWUknAKZOZk+hnKUTFJPAmunYRsGIaPc5kdETnWdQze5Ur9geCF0l62AxVl9dtAkOy6xpve1VQAAOcS9NlCnbHSZ8JAw2Bxd9EflV5c6hzF9GuI6+3P4B2KwEARci8mjWKbOz2Vj2GkPs2x6Q3Wn0c0H1Wbhr+c=
Received: from CH0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:610:b3::18)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:15:58 +0000
Received: from DM3PEPF000265C2.namprd03.prod.outlook.com
 (2603:10b6:610:b3:cafe::14) by CH0PR03CA0043.outlook.office365.com
 (2603:10b6:610:b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:15:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C2.mail.protection.outlook.com (10.167.23.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:15:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:15:51 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:15:43 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 00/30] DC Patches October 19, 2026
Date: Tue, 13 Oct 2026 19:07:47 +0800
Message-ID: <20261013111616.2267344-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C2:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: c597a4bb-8945-4b58-29a5-08df291b5b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|6133799003|10067099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: MicbyyeDZB+BAaIR733ekkxsPbIFhnNtrfatZXtHSUuyD+bYc0r1z7IYPjEEZw9+MchDDZ3djw3ICBBDegq/M25lR4dahiEA4HV0LchgZvFIW5GMrb2Aa7LwhEeZRM2qx3mcs5qczHLIxl/y09XEqp7ZJr8o40U7dWtMFmLb6BsavpQg7e+8Mut2VpdeFPtMnq1Nxa5nMuoz05dltGa0mI9WOzjZy7iYQc918oP5Rgu+s0kzM/RaYQoo892yax5B6jKz//fLJwz9cYMsPl/+8vNKSHigODBDV6Hv5o/c31NUYFVVgzBf4fw2U1Pi0Ec6kW+m+LRUXwQXH+UfuXVttliitGeq7eGbQJIL9Hg/N9HjzwFPm7VlOgDJ+lS7h3g7ZTj3XORyIxiV7hYxF8VR/NoYF2WcUc+GVZu4ky++UapCp2sP4+pY8KcfqFSQ1zqEjcNnYLRqQ909FdtYhz4wcpXETY3HGa5wQoeN3y+VhOoyTR4CJhdSq0PJEryUjhF9RkbtHQiQlGCOeeFf6O+YlYOh49iqHTXyv+Uop+DQDSRIDfyvffLrUiJj5w99rEjRA5cLMmNx4gMyfLctQ2oWBeyQGc2S10VIiikLTlCAZwjVb4rnKboEgxnkeqEwMdZIsRZrvYcbxtuHKp3Momfqs6OV/Y2V1IslEDnxxt8FZKOfCW24UgZQhwG+SC+h0tgL6N3hTsBIGFobMXd4FLMmOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w5jigUQzGSuLB5PL1jiBwXNZ5ONw+9PYSjp1sCp+SMPlatzn9q7quEdsVz4PElwgYyE6vY0vPYEeg0Q7t+ovbmNHok1kkqjR10lQkeA8O1EaJ84A1i1yWV5Fpka1DBPvrfIBZBcBgnwJNHX1w66BuK/caxObNupOAPZX4NPsTMWI1sjoyAlC3LFbXOI7JZmAh2lxxJu2hQWYNXUeqqHDFVde5NTzaUrsHrHJ0g2q8ipiqUmtJ3ZCpfMePOg6+xraN6iY02NQMV/TKvY5GjdBBlLooDBRCFOh3Dq18MN8oz+i4IjP69GNMbnXWlZURXcMdsHK/Y/6xYHf8Pj2aojYaf2PEImnMc3BVCEtb7W6a7uCzbVUtRZgd/k/tuE6v6b1b3TFnsKBEhN3arhlk2P6v7UmOT9Au2r752lfZLHvAhE6ZI2pLH+SgHPy0m0tOMua
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:15:57.8520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c597a4bb-8945-4b58-29a5-08df291b5b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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

This DC patchset brings improvements in multiple areas. In summary, we have:

- Fix HDMI FRL FFE compliance test and adjust FRL LT timeout.
- Align eDP DSC link policy to minimize lane count.
- Add AS-SDP V3 support for VESA Panel Replay.
- Add DPG force-on-flip support.
- Log PSR/Replay status and exit PSR/Replay on non-modeset full updates.
- Reject invalid per-mode FreeSync timing and set VRR_EN state.
- Align VRR timing gate with FreeSync module.
- Warn on unadvertised modes without scaling.
- Use DMUB to notify PME and update DMU cmd header.
- Do not allow vbios version of dmubfw in the driver.
- Use picoseconds for line time and correct next frame calculation.
- Fix YUV422 semi-planar color blurring and UPSP chroma upsampling.
- Reset UPSP and pre-CSC registers on DCN6 DPP reset.
- Handle exit LS in second ISHARP programming block.
- Remove hard-coded min dcfclk for AC.
- Do not WARN when removing an unallocated MST payload.
- Various cleanups, KUnit test fixes and debug flag gating.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alvin Lee (3):
  drm/amd/display: Update DMU cmd header
  drm/amd/display: Use picoseconds for line time on DCN6+
  drm/amd/display: Correct next frame calculation

Aric Cyr (1):
  drm/amd/display: move timing_adjust_pending into dc_stream_state

Charlene Liu (3):
  drm/amd/display: use dmub to notify pme
  drm/amd/display: Do not allow vbios version of dmubfw in the driver
  drm/amd/display: remove hard code min dcfclk for AC.

Dillon Varone (1):
  drm/amd/display: set VRR_EN for inactive state

Fangzhi Zuo (4):
  drm/amd/display: Simplify hdmi_automation debugfs with
    debugfs_create_bool
  drm/amd/display: reject invalid per-mode FreeSync timing
  drm/amd/display: warn on unadvertised modes without scaling
  drm/amd/display: align VRR timing gate with FreeSync module

Ilya Bakoulin (2):
  drm/amd/display: Fix HDMI FRL FFE compliance test
  drm/amd/display: Adjust HDMI FRL LT timeout

Ivan Lipski (2):
  drm/amd/display: Remove unused has_vsdb variable
  drm/amd/display: fix NULL dc deref in hpd_init KUnit tests

Kaier Hsueh (1):
  drm/amd/display: YUV422 Semi-Planar Images Show Color Blurring at
    Color Boundaries

Leon Huang (1):
  drm/amd/display: Add AS-SDP V3 support for VESA PR

Mario Limonciello (1):
  drm/amd/display: don't WARN when removing an unallocated MST payload

Piotr Maziarz (1):
  drm/amd/display: Gate DP_TRACE_SOURCE_SEQUENCE emission on the debug
    flag

Ray Wu (3):
  drm/amd/display: Align eDP DSC link policy to minimize lane count
  drm/amd/display: Log PSR and Replay status after mode change
  drm/amd/display: Exit PSR/Replay on non-modeset full updates

Roman Li (1):
  drm/amd/display: guard DCE-only hwseq definitions

Samson Tam (2):
  drm/amd/display: handle exit LS in second ISHARP programming block
  drm/amd/display: handle UPSP chroma upsampling in DML

Sharique Pervaiz (1):
  drm/amd/display: Add DPG force-on-flip support for SystemDisplayEnable

Sridevi Arvindekar (1):
  drm/amd/display: Reset UPSP and pre-CSC registers on DCN6 DPP reset

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.80.0
  drm/amd/display: Promote DC to 3.2.403

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  61 ++++++---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  44 +++---
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  69 +---------
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  43 +++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   7 +-
 .../tests/amdgpu_dm_connector_test.c          |   8 +-
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |  55 +++++++-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  20 ++-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |  48 ++++++-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  55 ++++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  12 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  17 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  11 ++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   3 +-
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../dml2_core_dcn6_funcs_mode_programming.c   |   4 +-
 .../dml2_core_dcn6_funcs_mode_support.c       |   3 +-
 .../alternate_pstate_shared_lib.c             |  11 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   8 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  40 ++++--
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |  17 ++-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |   1 +
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |   7 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  55 ++++++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   7 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  11 ++
 .../display/dc/link/hwss/link_hwss_hpo_frl.c  |   3 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   2 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 129 +++++++++++++-----
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |   7 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  34 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   7 +
 .../amd/display/modules/inc/mod_info_packet.h |   5 +
 .../display/modules/info_packet/info_packet.c |  38 +++++-
 39 files changed, 634 insertions(+), 224 deletions(-)

-- 
2.43.0

