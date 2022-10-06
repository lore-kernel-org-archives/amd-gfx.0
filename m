Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B81C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E25B10E8AA;
	Thu,  6 Oct 2022 21:27:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C889810E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPfd5lYMYXyY37NY/HGknUirmqbRA+d2pjo21jKl3D0QzGivFcu25xVm5kWrjgLS1GTypb5gkt28XNw/DsC2b9rUjMIZJ1igolrLdGkplDZOES3lrjp7r+L0bqpg5263zlqDG7U/MDp/ztSpquJ3oVfxDfhInM6fypJS8NchkPfnQZmK6iJvYqABfMSkOm57U5M4Z+FGNfb/LbpEOA3FR/yh1Z7JZs80zvdwcOYEmB3fpjORCPRh1GJ0lZvaJfEU3fwoSnZHxkqbiiCICZDNAI5OSJUX+UnkPVhSM3yaTRQl2fU3KwuGdJaWx/3YcDopn7CwJ7rqBIBLIcnmanOHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCfXChGbJhLLZN1928DBOa5HFsc7W89JDOLM5nJ+csI=;
 b=Dh0dhI/hzEvcNTTF42ZJ+knt4fb3vPPORrVdyn9JhbdbqIgJDQOaNV7PSZRmJcI4n2xHBq0m3+mU0P8slxP8zn6XveLnyyt8WR+FaeeGiOTIbfWdfIY01fBdOUbh/Upn+p4N9EiRtJzzFBiBWomf47JKun6fUiDDKP59YBk2jK4ZAgNitedr9Nl1hFZ60I3P0POwVlAD3MU3FGPmCJ2BeJogtSRUEc05TtjzGuy9XyRWqq1zvKs5VE5PrP4cd08w9bx9mMvYwuj30F2x8f8cCIEwiHYHK+sa6Y2BRVhrzmUDa4HI9uvbdBXvXFMsOD8o85lx4CUNzyLsgAHMzsZSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCfXChGbJhLLZN1928DBOa5HFsc7W89JDOLM5nJ+csI=;
 b=BaLnUeM3UsoDbOsof1bbFi8W4c6wyi2gysKjxBifgEHEgrAKp1zRkmslcmXt31kCyF8984vCyOUmeTfH27ycsYWMmRsbqdnYPT+8MOFhlqD+D6tOTLxVPGw6kKkWka0dQrPPp1WkURvbJUPg4qf90CVWBTIFAXNctstHBEpR8CU=
Received: from BN1PR14CA0021.namprd14.prod.outlook.com (2603:10b6:408:e3::26)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Thu, 6 Oct
 2022 21:27:28 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::eb) by BN1PR14CA0021.outlook.office365.com
 (2603:10b6:408:e3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:27 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:26 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/23] DC Patches October 17th, 2022
Date: Thu, 6 Oct 2022 17:26:27 -0400
Message-ID: <20221006212650.561923-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 625d508d-e72e-4b07-03c2-08daa7e19198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bZs6DgsCmYGUSuv4X/pQslxLku6Bnqq01RJPbLEqn8OUolrtkgzZExS9QBprkSkDdPAgwgiijVGflJAH1IsP78ytvT43Z1Dvi2/C00VKZXkM57AZTbP/CFjSYw0RDU3wID/MrUyvdPwNjXq2HsVTXCn44/JrzHNfJy0pVc4IBENrQUwPWVpb6QQOCX08AnHC32C/ULjczA4bzeAuhVB0vqN8RhJyd49KtM5f4tPhtAtNzvdtga77noI7WosXenlKVDsKiusCckWhbQRRLLyS8qCwRMuRc//Wc0ALZhgj3wKYgRMbzO49Wf3riprz+vMSqVYrs7V22VLzEj6vHv0ZIsQrFlruoQQiVzmIZVy8qilCeT6YM0929sMMSApv8/7+9B04KCkrxlEv9Zmbq2gvg5IzHtdfxvZykQW5GadSdvMNE0Shjpk317tOLMaRpkRI35bsMGGwhwW1AgydMf5n02o9KVcesPIPGUORDUPGyuVtSmNbA0Um1lVg5pGNDGljvHB+MYVKi8OMlzWNmU5Hcp3QFS+4I/jQSRZxVG7RAcEMlN49drvtGOTFXTcTUw4DNCPbr6cQ/R7JOLoH80yKnq6Np9GWoSH/d8HCnkz0+6eNAdDn6pPn5KhFXiNX36yFuatPWwP9Bi9hp03ilv2jsV4NTFkGpWtLrHYr1m7ssAWlllYQJmkg+5ZEyaTCYWvzY0jfy63OyTIeKq5ChDTfW2pF9pcJyD3x4MBD1Hs4PppW/fFvwZxm50K43KQhqALt752YLhVZosb5DUoJkDKiDygajrlymiD+7boLfQk3iSNnBeFK2HwREQybIxyryMz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(16526019)(40480700001)(47076005)(83380400001)(2616005)(26005)(478600001)(44832011)(186003)(1076003)(426003)(4326008)(8676002)(8936002)(70586007)(41300700001)(70206006)(316002)(6916009)(54906003)(356005)(36860700001)(82740400003)(81166007)(36756003)(82310400005)(86362001)(40460700003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:27.7704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625d508d-e72e-4b07-03c2-08daa7e19198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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

This DC patch-set brings improvements in multiple areas. In summary, we
highlight:

  - PMFW z-state interface update
  - Cursor update refactor
  - Fixes to DSC validation, DCFCLK during Freesync, etc.
  - Code cleanup

Cc: Daniel Wheeler <daniel.wheeler@amd.com> 

---

Alvin Lee (2):
  drm/amd/display: Fix watermark calculation
  drm/amd/display: Don't return false if no stream

Aric Cyr (1):
  drm/amd/display: 3.2.207

Aurabindo Pillai (1):
  drm/amd/display: Do not trigger timing sync for phantom pipes

Dillon Varone (4):
  Revert "drm/amd/display: skip commit minimal transition state"
  drm/amd/display: Use correct pixel clock to program DTBCLK DTO's
  drm/amd/display: Acquire FCLK DPM levels on DCN32
  drm/amd/display: Fix bug preventing FCLK Pstate allow message being
    sent

Dmytro Laktyushkin (1):
  drm/amd/display: always allow pstate change when no dpps are active on
    dcn315

Fangzhi Zuo (1):
  drm/amd/display: Validate DSC After Enable All New CRTCs

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Jun Lei (1):
  drm/amd/display: Add a helper to map ODM/MPC/Multi-Plane resources

Martin Leung (1):
  drm/amd/display: zeromem mypipe heap struct before using it

Max Tseng (1):
  drm/amd/display: Use the same cursor info across features

Meenakshikumar Somasundaram (1):
  drm/amd/display: Display does not light up after S4 resume

Nicholas Kazlauskas (1):
  drm/amd/display: Update PMFW z-state interface for DCN314

Rodrigo Siqueira (5):
  drm/amd/display: Add a missing hook to DCN20
  drm/amd/display: Clean some DCN32 macros
  drm/amd/display: Use set_vtotal_min_max to configure OTG VTOTAL
  drm/amd/display: Drop uncessary OTG lock check
  drm/amd/display: Remove wrong pipe control lock

Vladimir Stempen (2):
  drm/amd/display: properly configure DCFCLK when enable/disable
    Freesync
  drm/amd/display: increase hardware status wait time

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn314/dcn314_smu.c    |  11 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  45 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  51 +++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  49 ++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 147 ++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 167 +++---------------
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  29 +--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  30 ++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  12 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |   4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |   1 -
 .../amd/display/dc/dcn314/dcn314_resource.c   |   3 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |  11 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   3 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   7 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |   9 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   9 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  15 +-
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |  98 ++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   5 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 140 +++++++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 38 files changed, 635 insertions(+), 268 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h

-- 
2.25.1

