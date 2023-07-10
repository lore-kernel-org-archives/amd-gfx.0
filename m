Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC46FEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478B510E2BD;
	Mon, 10 Jul 2023 19:27:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5BC10E2DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuFNSVP+FiPapk9gh/1yZoiyIG4tPxk0ZoKO/h6ta6k9duzkzhBb4cdUt/O1xlaUviSFMbOm8BziaxDmL4qqqojxSOo4s4J438CjWcoItRlv4JzmcZb7WcQiRVI7H4irhjLKy0yyXzpN0Rut0E1sguddn2LOHZCieTUjjlGbh86oLMkT0vH0M102nH9Xs2hlSa5KOIc+pOZZiM/xA3Fp1D5t2e/flpWiEvQVSsZAcq2pDJKgx7UsEEJjqzlQTUum5YS2rV1aierE75cTvtRX96ilj4QwodkSIXmqlaAwO2Tck81xWhQG2QwI5ZPZB9XlxDR5haIU6vjzNFPq/red/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS3OpPAcSJIHMgMo3khi+mV0lMp14CdkhYHFYjwxYMo=;
 b=mRHfSZb8zUz6UakmQPbYjcmW6hKDGNc4Xvzx7o4slDiIlY3WZzfz6D8qO5sKnNoW/tADeIObftQjb1M0wnh0N+9ebMizr+8yG/zZZxUnToaNQ2hQi0GKsWQkOHk69w3XTkmN9NHr5VgKeC7OjY3chf8+CDtd+oE1M6VEnHXm77oH2+5U1MUNoN1nFz1YBXvzDoxNMYNVJJwyvc+9m29bMkeI5dkkuQ25wx0ymps6EvKvX47OmDD6ZNNRShNs1Uh3zLSTxwgjd7dOz++9dsoeIQqe9L17aA6/7etCNZaNwoUBbct+zunZuEUBCIRdfOhDLqA6DizAu3abk2/bMrfu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS3OpPAcSJIHMgMo3khi+mV0lMp14CdkhYHFYjwxYMo=;
 b=UdGk5V6rnaEAiyVzBgj56WW3f8wEtX+kr/jvxgxT4Aw9zHvPNCOdsFKjKqqFReZImZon4TFEdyrPkFM6qcL9ksW/7c3MVCWXSXanU9LuO7tBS5F8fY07nXJlIQgeSJ3lomyPMJfx6BEPCmmJKUwszu87MW78Hf4uYJ/d6kNSrJk=
Received: from DS7PR03CA0131.namprd03.prod.outlook.com (2603:10b6:5:3b4::16)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:27:37 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::93) by DS7PR03CA0131.outlook.office365.com
 (2603:10b6:5:3b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:27:36 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jul
 2023 12:27:35 -0700
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:35 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 00/10] Freesync Panel Replay V2
Date: Mon, 10 Jul 2023 15:27:23 -0400
Message-ID: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 19635ee7-9ade-4b89-950d-08db817bb7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZk5pjfOgsAKVRdaagsCs+r6Zi4hONmhnZPaE0okTn+YI4xYNf5w1Fp9auOxwNzql2bCEDLLT9wad7MnVqIYAzjX0pHiZxOBLXlbxnpCwsH0McCUrCDNdFFQX5wzTc7PpdXzlg3hed3R9xqjIsTj3TtXso2IkILcI6Mtnx4ufQ8ULT3e3XIiaQVytffj+gB5W1ig0rlnAY3Lpsp5wW5LJRC37lRwuxJrFRIMoQ1FW1N0MnFJB70VLY3zqr14KvTLqMlDvkyZdDOguS/BelEk30RKQ4GAn8a+8DKfDREFyhYRdc1IqgZeuVGS5+TtdyyoY4w7U/+aH+DyEF0Ez/P6Uoxe8AJU5McYc0Dc+yAWh9L9tGhVRll39eRKkEI9N9xV2J2nQHbVcpQ5PHaLxgpUc/MnVzNbuYIXw+Zlcd3VvwyyRKU4RntcW3tE6w7kHy4VfR8JNDJlUpSVxzAu9quOt1hVjOqQXHBapDStXeg+FerD+EVlUSSneFaPBcHqn+DSu/EfvcpDl+cmRBR6Cifq970lyavVbdhPYhV74Mu2KGfF9BQ8iTlwZSbBmTMB8r5rbIXOps6axzlRrG0fF/asLLwH7u69apNDSRSB0fvjKteHRPYELt464uzAfBaLszGc48pjG97/Fm5sudoSxsmTeFONYWVDhWHi+aJHMq3B9L3uz/daVoZLOvMb9l4EeNENh2DTExYicCtc1vAezT2AMeCsHbZ0St5hnmc6KtgrN50+a2SBMGO3dyBMBsrTvr+dYwPVNVKic/dfvgTPxElUDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(478600001)(110136005)(26005)(1076003)(336012)(70586007)(186003)(70206006)(2906002)(82310400005)(41300700001)(5660300002)(4326008)(316002)(6636002)(8936002)(81166007)(8676002)(82740400003)(356005)(40460700003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(426003)(40480700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:36.4777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19635ee7-9ade-4b89-950d-08db817bb7ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set introduces Freesync Panel Replay capability on DCN 3.1.4
and newer. Replay has been verified to be working with these patches (in
house)

These patches are enabling panel replay in static screen use-cases.
Other use cases will be added as they are ready


The importance of Replay
************************

In some instances, the GPU is transmitting repeated frames to the sink
without any updates or changes in the content. These repeat transmission
are wasteful, resulting in power draw in different aspects of the system

1. DCN is fetching the frame of data from DF/UMC/DRAM. This memory traffic
prevents power down of parts of this HW path.

2. GPU is transmitting pixel data to the display through the main link of
the DisplayPort interface. This prevents power down of both the Source
transmitter (TX) and the Sink receiver (RX)



How it improves on PSR
************************

The concepts of utilizing replay is similar to PSR, but there is a benefit of:
	Source and Sink remaining synchronized which allows for
        	- lower latency when switching from replay to live frames
	        - enable the possibility of more use cases
		- easy control of the sink's refresh rate during replay

Due to Source and Sink remaining timing synchronized, Replay can be activated
in more UI scenarios.


V2: Bug fixes, V1 had some issues which have all been fixed.
	- Invisible Cursor
	- Random Hang
	- Laggy System

Regards,
Bhawan

Bhawanpreet Lakha (10):
  drm/amd/display: Add structs for Freesync Panel Replay
  drm/amd/display: Add Functions to enable Freesync Panel Replay
  drm/amd/display: Add Freesync Panel DM code
  drm/amd/display: Read replay data from sink
  drm/amd/display: Get replay info from VSDB
  drm/amd/display: Add Replay supported/enabled checks
  drm/amd/display: Update replay for clk_mgr optimizations
  drm/amd/display: Update adaptive sync infopackets for replay
  drm/amd/display: Handle Replay related hpd irq
  drm/amd/display: Enable Replay for static screen use cases

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  71 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 183 ++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  46 ++
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  29 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  41 ++
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 303 +++++++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  58 +++
 .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  13 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |  14 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  19 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  14 +
 .../drm/amd/display/dc/link/link_factory.c    |   7 +
 .../dc/link/protocols/link_dp_capability.c    |  10 +
 .../dc/link/protocols/link_dp_irq_handler.c   |  66 +++
 .../link/protocols/link_edp_panel_control.c   | 165 +++++++
 .../link/protocols/link_edp_panel_control.h   |   8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 412 ++++++++++++++++++
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   5 +-
 .../display/modules/info_packet/info_packet.c |   4 +
 .../amd/display/modules/power/power_helpers.c |   5 +
 .../amd/display/modules/power/power_helpers.h |   2 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
 38 files changed, 1533 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h

-- 
2.25.1

