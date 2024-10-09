Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87689CEE346
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA2C10E7D9;
	Wed,  9 Oct 2024 19:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ikiLIFHi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBEBD10E7DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bk9ff2aGARer9h9pUUW+bhLVcQ+9PnpNGLJZ282iyMst0ZjSoPCz/1qbJGYVd+/C7gbVrvEiGSwS+5qPuE6AuAZVNUrHdBYQ9SsWZpqOjfU73KwXyFY02gmUEu8tG/BT+zD2Nm+PKc9vkOR3HiCRmYI1WULlGQMxbj4tZPr4PdWqai2REZUViplvZuvs+dTUHod1OlVQDo3Vmydj2Z0KjOsELxOmCGdj8fj73JOWEaCTiPV+kIv512XhjdnIt9tPvoNvIYNvhUhATbXfRIBFaZ6OxEpRKtEt0JZwF2uSJn8aeRKTH7wkLLDA36qMyVT/0TtSuL4+DH3plmYF5caxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRmzIqSgVm9KzdboutKvhc729OfsJm59fxCsTY8xfsA=;
 b=NLQICwrsltmxYkTE9GY0Bud4DunZBn5hA2U8Cz5EutMKYAu/MWQoT4kN23uJFS8QYbNDqI8llj9xEqhMDWuF8d27cZqya2UBdAH7YpARt14H9bPtyPLFpzYpzN0AKNLNe0+lC6FdCx9NcAaC5s2WSpGUIEHbwHlh8dxB8z4nOIcZawFLdiFlc2oP1TDQv7nCe3ZidBXbSDVtMTBWXF4h0liSGqGX8Oc0KK6aqY1oloyifZejRlWmfEMIYCrSxmKbdT8dCyVdKNtV3SDY6TzY+gjFAndgVbJ5H5DjGcPKq/5QzsHHxShnWgELdG1SjQsSJyjkc0vczbDOziZlDgj4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRmzIqSgVm9KzdboutKvhc729OfsJm59fxCsTY8xfsA=;
 b=ikiLIFHiifyisqbLyMheOn9dc/Bk8dkyHczhIVEYy/Eav2TxsA2CQ4xUSTaQqA1deGODNXljmFE7jAJ2ELNxYnFipbg355Mf7AlEUZV9kDRUkzKLSkOQi/sTKuBkWoDz1zaZcbQC7e8VKGjltLCd8sMhH9hleb2zxkBXA26zdHY=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 19:25:47 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::b2) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 19:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:25:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:25:47 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:25:41 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 00/16] DC Patches October 9, 2024
Date: Wed, 9 Oct 2024 15:23:28 -0400
Message-ID: <20241009192344.650118-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d071ac-f7e5-4407-1ae4-08dce8982d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ElupMG86H/bxhIvGAgD6eCGTQIRObncQqZnSAJ16BwuXbAX7zMG1HLn0gXEM?=
 =?us-ascii?Q?8bmDJmJzjg5apmFLgH+GlJCTn6kQg1HVongllpbau4gj0HtkerT7SjlztS4I?=
 =?us-ascii?Q?sc9fiUYBBTER8DMnqSsO9jYDaN7tYduF/th2aVie6b+ouSrD3H6374reMD9V?=
 =?us-ascii?Q?PR1FGjeFlX+RJRJUPKl/ukUol/EsxKV6LIxZqXlf1broH5sZ9iGgXIyed8FZ?=
 =?us-ascii?Q?JP3RZGVV6668uB6hx9JgFVntGlXsT1bVyaIfJ0qsiYB7QjOYpFJQxr8Npd/L?=
 =?us-ascii?Q?cFbMKfM8h2rYtjOigXZwSE/kF/7fr9zbnQL8mrFp0iVX98rkOqf7h/F8LNiK?=
 =?us-ascii?Q?knOAN5XAIgYdeiu45+Vs/CrfPU/Vxj3BITOXcd0wOV/E/gKFxjjVy80dtuAg?=
 =?us-ascii?Q?6AUO/HhNUiKNrkUGItDq3oWkc5rsgNuSpxTsrQP1H4PTwmgsnAW8f0enOLbF?=
 =?us-ascii?Q?N8v/Pv1DHZSTp0t39g1V1rc6Y81llXWbtoy6tnpwaUPK1I8u4QAdPaC+IlpK?=
 =?us-ascii?Q?5hDP6h6MBR8EE6BYKpn9F5AmgBxO9YMQiZJiNH/55Gp3kkzKAa/LcxMQbPYN?=
 =?us-ascii?Q?qTux37qXooF81MlE70A7cjmquSOX4LtomBxsWaL+BVDSlPSb5znDnkpxTMfR?=
 =?us-ascii?Q?DY/tnAMT84QyjJUNRiYMjc24Fc5ihvp4ClVmMNy59iykWB3447uE3+YeY0PI?=
 =?us-ascii?Q?sDG9A/3l03KTRODge6DeLB487k4HT5iIKhGD2oxIT/fdUOXOCMs9L0QnuDWG?=
 =?us-ascii?Q?1xkEq82csSxnuZPBWgn7aDJ7fqKgdh5BNLtoB/832Agd4+qtz+qEKW2ShFLz?=
 =?us-ascii?Q?DSAOCRzp5RaDCFw7o99RJ7g//DFjNuRsK+JzaJTp8XLu+pH92m1HUURtwWgy?=
 =?us-ascii?Q?Y0RqYeHHDCNyFW7P+CFNRIXS+kqy2W1V2nMm2ZgJutQ9j2a5CNaAPHWl6zk0?=
 =?us-ascii?Q?heFN60FcoH7DIcxOsQ/Q4a2cb9fyNB1thnz6MMuN4Vm2nAbjO/2C5LuCjVOb?=
 =?us-ascii?Q?DubqmJOM540T67Q8fh5xemzlHOeuejPHP7QnAsphJwRNRbTnM5oSXQ4VE1PU?=
 =?us-ascii?Q?pJEv5jLwXtskGQFj9o5rrEG5jIU7tfSnev7uKyS6R8cuYMGvm77ZGcd36FT2?=
 =?us-ascii?Q?hZlgR1slRmmXAp8M2Dlnep1z5+IWBh4AcCKkioyTF/fHV2IKiAZFJe6130t2?=
 =?us-ascii?Q?GApvlguv/QEJ1QmlptKHdLLK8+g5vhUB+UI6plYikqhWbKeyKRgou3+ds1Z+?=
 =?us-ascii?Q?2dbgBwnsQ/t9C6XPFjGI979Qpna5o57eJbHaqucDlasZUgtCvcTmAICPKMBp?=
 =?us-ascii?Q?pBJf5MB8NU9CKy0kHn+rE8MpSOIktSIY/oMM8OxjgagshAvbZd5K+zPqLbG+?=
 =?us-ascii?Q?xv//zIBiDbm17CvC5SeyJp34rE9a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:25:47.6300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d071ac-f7e5-4407-1ae4-08dce8982d91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
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

From: Roman Li <Roman.Li@amd.com>

This DC v.3.2.305 patchset brings improvements in multiple areas. In summary, we have:

- Add sharpening policy to plane state
- Clear pipe pointers on pipe reset
- Resolve correct MALL size for dcn401
- Read Sink emission rate capability
- IPX fixes
- Coverity fixes

 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (5):
  drm/amd/display: Check returns from drm_dp_dpcd_write
  drm/amd/display: Check status from dpcd_get_tunneling_device_data
  drm/amd/display: Remove useless assignments
  drm/amd/display: print messages when programming shaper/3dlut fails
  drm/amd/display: Check returned status from core_link_read_dpcd

Aric Cyr (1):
  drm/amd/display: 3.2.305

Dillon Varone (1):
  drm/amd/display: resolve correct MALL size for dcn401

Ilya Bakoulin (1):
  drm/amd/display: Add 3DLUT FL HW bug workaround

Joshua Aberback (1):
  drm/amd/display: Clear pipe pointers on pipe reset

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix Coverity change for visual confirm

Leo Chen (1):
  drm/amd/display: Full exit out of IPS2 when all allow signals have
    been cleared

Robin Chen (1):
  drm/amd/display: Read Sink emission rate capability

Roman Li (2):
  drm/amd/display: Increase idle worker HPD detection time
  drm/amd/display: Add check for headless for idle optimization

Samson Tam (2):
  drm/amd/display: add sharpening policy to plane state
  drm/amd/display: disable dynamic ODM when sharpness is enabled

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 17 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 30 ++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  9 ++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  3 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 -
 .../drm/amd/display/dc/gpio/gpio_service.c    |  1 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  1 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 20 ++---
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 13 ++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 73 ++++++++++++++++---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../display/dc/hwss/hw_sequencer_private.h    |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +
 .../dc/link/protocols/link_dp_capability.c    | 16 ++++
 .../display/dc/link/protocols/link_dp_dpia.c  |  7 ++
 .../dc/link/protocols/link_dp_training.c      | 11 +++
 .../link_dp_training_fixed_vs_pe_retimer.c    |  1 -
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 31 ++++++++
 .../dc/resource/dcn32/dcn32_resource.c        |  4 +
 .../dc/resource/dcn401/dcn401_resource.c      | 28 ++++++-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  6 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 +-
 .../gpu/drm/amd/display/include/dpcd_defs.h   | 19 ++---
 31 files changed, 254 insertions(+), 72 deletions(-)

-- 
2.34.1

