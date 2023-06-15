Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16866EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 20:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99BA910E1A1;
	Thu, 15 Jun 2023 20:39:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC81610E19C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 20:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFs0s9NyskwgxHfY9xeQ8r50oRqP3OZpVZS7yaYha9Cxck+4hZ1ekS+mxC3/aH0WpBCYQ4xZyVq+U6ku82wwllp81f7iHnf4KK/B4RZ4VJDGiAQXNGfZ8ywXH1GRLJuxtkhq/B8v3QPiXzo2iOkhPg9HDJ/wBXL0Dyqt95hT/gyFRiXTkN1/FWc4dAqUnQi+8ZCyG6xQ+DtSXSq6exyQk1pU2FStulsN2gzAouyLb9F8e8wrHKEdFe+B62sq4UgZ7Ywcx7hqArtXBxYLQ1WE86hR5YmX8y9kc15u3jdk1oR2srsvRYnPvRshhsO6G9ssOZk3pTStZ4IWVPxtEEv4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctsnfo4QjRf3GP2PxDWBf7Xva+/XUE3OpMYadlKsET4=;
 b=lL7ey9fdtrpOs/d7kup4pxp8DRQIapvUxT5DtOXWEMBdhFXjqji7x/Zm68nLZjwFy5yf/RBgU7myP0Qvk2EdrZQOkoTaQ2XHjAELD+/Ne/hGDH7wMYkZRm5of2vgFBglKQmSxD2kf1B5FGgKmsByyijPnTLrVFxRtPWeA6oJT8Qe67D/+XNFxE8Yiw/sQfZ7Q0KKPWHixFgiOdvYKKfECL4TrkJOngAsFPDbQqeGsy4K7hfi2p7xkIZbKdj2MMYacV0NZ44jhocBKFtf1af9/I+HWtcjtl1oViPRR1F2mpMy4Ov9tiHMU86gDhVpDFBY9mK5qnb4OQDTEC/ltjEG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctsnfo4QjRf3GP2PxDWBf7Xva+/XUE3OpMYadlKsET4=;
 b=MuR6I044dLO0CYp0/wlXiIWTX+GSrebEIeEjiOlncVkuS/4XZ/GcGYjPuJl+qaXzLU6/uy+1wMJOn/9lcx6kBChktJPjbx1xPb6QyytxlHUY+374uNC1mL3GB0Y6MD9rYcmqFZ88Cxw+i5BSzYaCNa/9tT0lhJDhpdzskRkpEVI=
Received: from DS7PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:3b8::30)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 20:39:52 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::10) by DS7PR03CA0025.outlook.office365.com
 (2603:10b6:5:3b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 20:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Thu, 15 Jun 2023 20:39:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 15:39:51 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 15:39:50 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 0/6] Freesync Panel Replay
Date: Thu, 15 Jun 2023 16:39:24 -0400
Message-ID: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|BL1PR12MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: e244e74a-ca4c-44c2-c7ff-08db6de0ab5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6LMYUJ+SfgmfZm5aYbfIIcIkw3moSQraSy6BXPxx9wJIOYRLiPcVs//nSlSW2zncULEuLpAiBuCMl1wrOCZmAs5AobJaGvlWaLdlMG2RInlza6xTOLSMuGQjC29NllagSmXIV76ALRc8oAI3kyRC8AZOgt5SnCyjt50UjNfiA7X7TBUmnopL3AXylMRqqIv1Gpjlzv0FRq1twoIxtEVGdnuKUZTSXW4d2biuI1qEWwN0XosQGBe2kwrAug+HBUiYB8s94kZVhe68WQKUsKc4fb1ZzAk1y9t0gZxuYlzFVDJ5++ufzxFa4+cc4uRUO0fslrTjUb3sEKztlbJglE0PzTfG+F2fkUATC6yuqPDMjnr7UeiWA5uuvlrtvKHmFzS6JWlHt6NmbpDd0FsFwRRyBVTCYJXAJ3/QvNFLIRrHRtDbjMDjcawhxTMoILRqBjS4HalbkQt8uKU/0dGNPDhM2mJn64mNdbX9L5H+QIjaJbu6aBnUjOhNB5fc8kKq6qEjzKbZKgwJCDsz9Yse9Mu3opiM5pE1HaRBdUaCEINrIGFmyTeyuGw51jqq7jtARCmbIcQx/UZbxoOKB0E2Ujpk05VkjrSnewQcWEJiZdrPEAq3lnQbCgpiMFmhpd7AYgs0PDU0jD/J5PAw637sJfK2oeIbDt+Wd5sfPYtomc5vgHvBW39oSSC9Kf3r8XC9lSVZaviv61YIzSYcgdj+3KBAuef1gguKPDGAMpyJQcu/dhUdvwRyOpT4Y7sXvVnwAQhjwrvHE1KvdbbT568poyeeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(8936002)(186003)(86362001)(40480700001)(1076003)(36860700001)(26005)(5660300002)(40460700003)(8676002)(81166007)(356005)(478600001)(36756003)(70206006)(70586007)(2906002)(6636002)(41300700001)(4326008)(2616005)(336012)(426003)(83380400001)(110136005)(82740400003)(7696005)(47076005)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 20:39:51.7246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e244e74a-ca4c-44c2-c7ff-08db6de0ab5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
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
and newer

These patches are enabling panel replay in static screen use-cases.
Other use cases will be added as they are ready

*Please note that there is a bug I am seeing with these patches where
there is a hang after the screen is idle for a few minutes. I am
actively debugging this and will send an updated patch set once the fix
is found


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



How it improves on PSR
************************

The concepts of utilizing replay is similar to PSR, but there is a benefit of:
	Source and Sink remaining synchronized which allows for
        	- lower latency when switching from replay to live frames
	        - enable the possibility of more use cases
		- easy control of the sink's refresh rate during replay

Due to Source and Sink remaining timing synchronized, Replay can be activated
in more UI scenarios.


Regards,
Bhawan



Bhawanpreet Lakha (6):
  drm/amd/display: Add structs for Freesync Panel Replay
  drm/amd/display: Add Functions to enable Freesync Panel Replay
  drm/amd/display: Add Freesync Panel DM code
  drm/amd/display: Read replay data from sink
  drm/amd/display: Enable Replay for static screen use cases
  drm/amd/display: Get replay info from VSDB

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  56 +++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 184 ++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  46 ++
 .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  29 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  41 ++
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 303 +++++++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  58 +++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  12 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |  12 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  19 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  14 +
 .../drm/amd/display/dc/link/link_factory.c    |   7 +
 .../dc/link/protocols/link_dp_capability.c    |  10 +
 .../link/protocols/link_edp_panel_control.c   | 165 +++++++
 .../link/protocols/link_edp_panel_control.h   |   8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 408 ++++++++++++++++++
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   4 +-
 .../amd/display/modules/power/power_helpers.c |   5 +
 .../amd/display/modules/power/power_helpers.h |   2 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
 26 files changed, 1414 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h

-- 
2.25.1

