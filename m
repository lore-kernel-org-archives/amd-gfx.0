Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A60EC6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C7A10E138;
	Fri, 24 Mar 2023 06:51:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E049410E138
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OorFjA2FZ3qfcPCQmPY/iLq6GPFF17EfMdc1ZqfUHvYAzFuU9XMYjDEEBgq+BABhA1ZYGHJC07s7PMJnParZDpb0DRD6SS7KvvWhgtd52ZBs9et33D7ACvEfkM5YXpbWjovuXuVF3tQjnboLGUpzhwS1fKXuPQ3yWyA8ctE9u7fowYySNliP11l8A5L4gCsJMfNG+U6lnKh+FuaRpdp4oZvKLlp0DvAStZUJk3iafwG1O8vZZusS5lyB/NBoaRbtSfnHoRzpCMx5BtXIB/0qg3WojyoIXR2ACtHTc55ymQOewKU4rs0cejyNz3Sx9p+pmWwqf8AiMkDuJ6ZBSdyyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTml58bS0m5Oc9Iu3ZO4Do6bV7Eb4KqgA/e6H5nBAQo=;
 b=k0d+1QwWG5V50CZssXcMRjWFKEIAruVFiLIfVNFsAGuUEQ8zjzJJMJMLNL0gmFSzoRhw3gMSp+WXfd6VGhVpnfMhRBSPafnj2KX2l90IZ7Wywri1arISRroHqjog5A3fE3TEp4x+apiU9pvbrDR2+VKDRgwxK+zrv5aNfwC3MrXw8f8IqXIS4GsyJLQUItyIBCSaBT8vQXju6PqXBRk47dYz1xZQvjPZ9oFC4FB7cDblr5+2nvTRS/bU18blAh9AjrA4+GE3kEnbLEukvRRsVfk28AtFPG7ySz15+ZcrecmByuEwmnb961aXul45XPYo5JxOVsBjKP+Ac01r25iejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTml58bS0m5Oc9Iu3ZO4Do6bV7Eb4KqgA/e6H5nBAQo=;
 b=PTY/xmAUYTbPaH5WMu0xAfvedK+1v3F1QP8zvLkIzOk1dS0AQzl8fe15GMSCGzltY+JiteyDkEJCCqFa+3GdRAlH1P3GGas+MQM1pvYL5Vot+bB4DqVU3P/4LGcyKI6bdzCTdDUDFsUXVZCIDcZ8IsJunECp4wBAo3nAJuopl5k=
Received: from MW4PR02CA0004.namprd02.prod.outlook.com (2603:10b6:303:16d::19)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:51:45 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::9b) by MW4PR02CA0004.outlook.office365.com
 (2603:10b6:303:16d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Fri, 24 Mar 2023 06:51:44 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:51:38 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/19] DC Patches Mar 27th, 2023
Date: Fri, 24 Mar 2023 02:50:52 -0400
Message-ID: <20230324065111.2782-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT108:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3fe124-b693-497d-40c5-08db2c343b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5HKslzv7F3PnEyrLTjmpieIPV3zmG1nhvAhuWin3q7faPMCxqA1a/m4s3OLs8ltv+NsrhTSCi5w+MK9epIs7LXZTtnhhGPFZ7d27BUyHsnwXTgEMocKLMD0Q3qa5U55mTofx/c76Li+gyiwOeqhTAq7HapaT1Dxde3klFnlPAAlYbHvrJcL3B0gNLnIESLa/XmmBi1uta6oLWqrYWyIeO0WToXcyI+3O+SoZSCjopN/Bgxk6cut0eDFiT1cyVsv5lpF82+nJ53iWGprZyh/rWrd/ra4f5kOxvm2lTOmQ7GYIQTh9M0b1KOebOjiNQhfvM3W9BvHqXxqoTsGDHymV1MSE2tuo8M67kzbcziQiZYQJByOJC//6DmiKVtOG2lJZF+N2KL4grOtkwdVZmekDF+WfyRiV88ByeXJCweO9nV1CeEdE7aHN+HvafqQ/CZdFpX2vHnjndBUDWyWt1k5gbWzau4WM6Vk75CTt8VX7nV7bs+hNeo/M667P2f5JuYtS1GNOfUGFG9J/J+taUJIk5S1MAc33YupBAP/S05Or7xmyqSaSxscqWAlplaKBFNLEaQ0uQdzGnjKUJ+JDHCI38iZ37d7peEstxZ17HtGVUBp0qWSIMtHFBh6+ftNsOhJC/uMHNX/JGL2GGbRniMU2XNMVZdbwTR8ghOEXW1pAonTvuucpA7g/47KowYbZQTVWzuCPkuOLSRwZ6cKXNbr0TEJ/WW1pc+R4HXgal8ADIM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(70206006)(8936002)(70586007)(41300700001)(86362001)(6916009)(4326008)(8676002)(40460700003)(36756003)(1076003)(356005)(81166007)(36860700001)(26005)(40480700001)(2616005)(336012)(426003)(47076005)(83380400001)(6666004)(186003)(82310400005)(16526019)(478600001)(54906003)(316002)(82740400003)(2906002)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:51:44.8563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3fe124-b693-497d-40c5-08db2c343b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- Enable FPO optimization
- Support for 6.75 GBps link rate
- Fixes to underflow, black screen and more

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (6):
  drm/amd/display: Enable FPO for configs that could reduce vlevel
  drm/amd/display: Update FCLK change latency
  drm/amd/display: Use per pipe P-State force for FPO
  drm/amd/display: Only keep cursor p-state force for FPO
  drm/amd/display: Enable FPO optimization
  drm/amd/display: Uncomment assignments after HW headers are promoted

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.160.0

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.229

Artem Grishin (2):
  drm/amd/display: Add support for 6.75 GBps link rate
  drm/amd/display: Conditionally enable 6.75 GBps link rate

Ayush Gupta (1):
  drm/amd/display: fixed dcn30+ underflow issue

Charlene Liu (1):
  drm/amd/display: update dig enable sequence

Dmytro Laktyushkin (1):
  drm/amd/display: w/a for dcn315 inconsistent smu clock table

Martin Leung (1):
  drm/amd/display: fix double memory allocation

Nicholas Kazlauskas (2):
  drm/amd/display: Add NULL plane_state check for cursor disable logic
  drm/amd/display: Fix 4to1 MPC black screen with DPP RCO

Peichen Huang (1):
  drm/amd/display: skip ClearPayloadIdTable if device mst_en is 0

Qingqing Zhuo (1):
  drm/amd/display: Add infrastructure for enabling FAMS for DCN30

Taimur Hassan (1):
  drm/amd/display: Add 90Mhz to video_optimized_pixel_rates

 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  5 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 44 +++++++-------
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 17 +++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 16 +++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 18 +++++-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  3 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 13 +----
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  2 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   | 23 ++++++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  | 10 ++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |  2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  1 +
 .../dc/dcn32/dcn32_dio_stream_encoder.c       | 10 ++--
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |  8 +++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 10 ++++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 49 ++++++++++------
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 57 ++++++++++++++++---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 33 +++++++----
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  | 28 +++++----
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  6 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 16 ++++--
 .../dc/link/protocols/link_dp_capability.c    | 28 +++++++--
 .../dc/link/protocols/link_dp_training.c      |  3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 14 ++++-
 35 files changed, 319 insertions(+), 119 deletions(-)

-- 
2.34.1

