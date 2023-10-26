Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A26C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3500C10E804;
	Thu, 26 Oct 2023 14:20:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD4E10E830
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SawWYX/7vPYweBwecaO1l1Qq6oELKc0ytOS+WHQDQ2YOtsUOHSB2VGuufBBMETXUaLRmDN4ZYE3KQqwJkDHPBK3p28La+aagNMHbsAdoj35aGXDY4UO4aMxMe225/0wLpacroAC2P1TVUHF0U/Gk1AiPtBjEtqgXxPyj4JLGWsqFPtyjqNgLPCLtidJhErYN+3j8V6fJkd1qkhnxIPUm/RttzAel/urVgkjFXWk6jYSG5eD4qG4jVo2s7OXuyS1P/YleNaVX9LGcd2yOS585Xi2u2n1nor6mu03HGkYKmZrq7j51U9KZ6ipWhuW3pXBJ6g3g/vqMSSxJ2GUMupb9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKMDTBBHkYbeSQTX7eBNWVE6EOpH5sjas7qa+8wASgc=;
 b=CeQ8OxC80MlM9rJmSafAH82O1ucK/upmNrQRv2HC7KewwjgcygMSGqIyFEfwY2ADHP4lpLvgvRWrXYpRy2h2KkEFrLq+EVaCDEoWLUHjHTIRMvXtSBLlGetF3bErUFaqUmJ4bqIX90vXvL+ysiE3NaD1i8P1IEZwHFNT3L1UPafTYZRe9XrgV9XVz0zYdfnrnVq7DiI5PmVfXa/3zGteiJnvK0zNvFGOdjtoOYFtT4iw3u/3JKzaMrdjTyvEeriZ+pbqMXXS9IoPJZucwj7dsNJTLpQG8iuZGRDT1Kw5G7+nV3po4ayW3M7WCgtfXYAnPiu5i2cL86jk8JaaSO3EfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKMDTBBHkYbeSQTX7eBNWVE6EOpH5sjas7qa+8wASgc=;
 b=1V6W377INR1qMpNrv2t8MeQwLnulo7U6F5+ghV3rsBiKF66fnMt0PDS3mtBezcrMfXai4fOvuIwq9jRVaxEqZAmD4KzMz4XA7Q7WKgJdAfo/d4IIU1v+Epv4e4Bbk7vua1GCLOM+GX2aJYngBs1nlAVPUtgQPWuPiXxhOxMlVU0=
Received: from MW4PR03CA0085.namprd03.prod.outlook.com (2603:10b6:303:b6::30)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:20:26 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::c0) by MW4PR03CA0085.outlook.office365.com
 (2603:10b6:303:b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:24 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:23 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/25] DC Patches October 23, 2023
Date: Thu, 26 Oct 2023 10:19:55 -0400
Message-ID: <20231026142020.67861-1-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d9d7f5-2e4c-4bae-7c9d-08dbd62eb2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJLkt+6oggaOO0n9DmA5hBXdrq7aIVc6Fg3CP+9VhTfhdjfgBvh7Yx3Q3Pg0YOhbJ0siRvg/JDS/ralr6zLnquj40PXS/ZOoC9g20kLYx7K3VVzW5OVi+TEEQc5lCA4wl35avSPXjnyao3wddZK7dgWZ0Riu8KsQE1dE4ypY2UuOEqFC4+to7d2BkYMzhAwDeEIEpp41LqzisBjoNsezOBL+nmLuhw6CyyafvoVwrXqRcKUMRRDPoyf67UQKs1Z6B7GOuKlStX718AmfVDgHnjcqb/16KiYKj9X8oJua6bOq7afNWp9JzsHcwMKDdJfoF4KDU0KlZcqNYO2tsN45qODBKT8CTzz3Iu7hjmcrrMES0GJvjnlujF6TKW+PuZSb8vNKmQH56x8JYGNhyTKBbbl53hzu2JRO+52/binWNBjmwqWlB1rcuzgXuG52JaYdIXTIWEXG2fyxdl/nbYGk9lvLBwOitX3G25mc+fP1hAApFcBF5QT8a/FIn5aabHQiXhsBLpjsax7e/9qqD3xho/l99CEVtqpuj+nI3NfhdLyhmId4lAcagLxmUV2eDo+HOs/A1iAi0ZxeKhr6CK9HMbSoZoO35lY8GQpPNUyyWfIr4IBxUKhyyPtwrkY0FyEcF7KqmkeXAY3jh9hGzr349s4CBmZt0UPYLZKqaub8fMhCIll2ZUihQmAmIkrbbrx2OW1DXLpnXKFCL66Xvp4X5b7z4DF0F8AToNN1+vu7/Ew6o7fsdDZFnPGzO1w1NaDMgKK9WClLoEHArRuMNNymnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(2616005)(336012)(82740400003)(70206006)(70586007)(26005)(54906003)(426003)(1076003)(6916009)(6666004)(47076005)(81166007)(356005)(36860700001)(83380400001)(5660300002)(4326008)(40480700001)(41300700001)(36756003)(316002)(8936002)(8676002)(86362001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:25.6638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d9d7f5-2e4c-4bae-7c9d-08dbd62eb2b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Enable HPD handler for replay.
* Add disable replay desync error check.
* Add more IPS options for static screen and video playback.
* Add test link rate UHBR13.5 for DP2.0.
* Enable 12 and 16 max_slices for DP2 DSC.
* Update HPO MSA colorimetry for test automation.
* Enable DCN35 clock gating.
* Disable DCN35 cm power optimization.
* Fix DCN35 light up.
* Enable fast update on blendTF.
* Fix DML2 logic to handle duplicate planes on one stream.
* Reduce frequency of IRQ from DMUB queue/execute/wait.
* Fix blend LUT programming bug.
* Fix registers programming skipped during resume from s3.

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.189.0
  drm/amd/display: [FW Promotion] Release 0.0.190.0

Aric Cyr (2):
  drm/amd/display: 3.2.257
  drm/amd/display: 3.2.258

ChunTao Tso (1):
  drm/amd/display: amend HPD handler for Replay

Daniel Miess (3):
  drm/amd/display: On boot disable domain22 force power on
  drm/amd/display: Enable DCN clock gating
  drm/amd/display: Enable RCO options for dcn35

Dennis Chan (2):
  drm/amd/display: Introduce flag for disabling Replay desync recovery
  drm/amd/display: Revise Replay Desync Error IRQ handle

Fangzhi Zuo (1):
  drm/amd/display: Allow 16 max_slices for DP2 DSC

George Shen (2):
  drm/amd/display: Update DP HPO MSA with colorimetry from test request
  drm/amd/display: Update test link rate DPCD bit field to match spec

Ilya Bakoulin (3):
  drm/amd/display: Fix blend LUT programming
  drm/amd/display: Enable fast update on blendTF change
  drm/amd/display: Fix missing blendTF programming

JinZe.Xu (1):
  drm/amd/display: decouple dmcub execution to reduce lock granularity

Roman Li (1):
  drm/amd/display: Add missing dml2 init value for dcn35

Sung Joon Kim (4):
  drm/amd/display: Program plane color setting correctly
  drm/amd/display: Fix handling duplicate planes on one stream
  drm/amd/display: Fix FRL assertion on boot
  drm/amd/display: Enable more IPS options

Taimur Hassan (1):
  drm/amd/display: Fix OTG disable workaround logic

Wayne Lin (1):
  drm/amd/display: Avoid NULL dereference of timing generator

Yihan Zhu (1):
  drm/amd/display: DCN35 Disable cm power optimization

 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  18 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  74 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   8 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   6 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |  10 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |   3 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |   5 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |   3 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  13 ++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c | 137 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |  14 ++
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  20 +--
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  45 +++---
 .../amd/display/dc/dml2/dml2_internal_types.h |   3 +
 .../display/dc/dml2/dml2_translation_helper.c |  79 +++++++++-
 .../display/dc/dml2/dml2_translation_helper.h |   2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  18 ++-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  11 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  11 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |   2 +
 .../display/dc/link/accessories/link_dp_cts.c |  17 ++-
 .../dc/link/protocols/link_dp_irq_handler.c   |  15 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  25 ++--
 31 files changed, 477 insertions(+), 91 deletions(-)

-- 
2.25.1

