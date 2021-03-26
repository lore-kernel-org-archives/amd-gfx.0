Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C54C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2601561A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2601561A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AFE6F4A4;
	Fri, 26 Mar 2021 22:05:43 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598026F4A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDyL94AuLUSnhfJTKTT4uuJ6Rn+iyeqr1oLMh8uNH5mg9cX91m6TSCJgMXKfKmrM6gQPBeM/Zc+MPzaqjSZFzCaxkztP1Exq6yl6ZXHfDL5tb0Mp4iBt+D8oupJm47O1D4VJ9imTRPZakTPnixYfOahB9/WuwhA+8fBAWi5CxQ6a/B/30fsIp56nJj+26cnOORt0gIXBAwDa0CXL/YAJkQzwyAq1H8yDcnLSsMGsPapSFwbOUYPurxkPuMG/YWhP0H6FwgRR++VJeAhxvgFN/FhGnxmwLzM6aBmqxuoUu1jFp6LzBaW7AGjKE1wfJ7EJ4giOz1xI51rtoSsP+kRXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4CVXUjs4RfyTEb3GqmlzSoAKAMURiECv5E7F67Mey4=;
 b=GD/TDhbuUaTJQQ3yQOgojJf8dBZR7VrUXpV0EycI0myH+rjs1lx+1rXM7gH3Aj7g06mDS279WZvNMt24d1qYUTZ2SsMyRheY2V/M/lAs8n8HxsPTNr3eo3UMLEauHtZMPRwfMiTaf3lD+tsM9CBgzXhMOsxZ8lf9zkhPI2crCkD9ZSPfF3x4WR6QcTbPCfDeWVaVOLHuXW6YEiJrV9ukFYXeDXs5V+/W+0eW97sq2Voujb9PexELKzd4z8mKAP39RgvIqwVGkX6X8vDQPPeb93OaYnMh5at8nhdrms6B+Y26eq+fve7WspJfQP/iVZiAUfElEFY2uh9yDLA1yn53yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4CVXUjs4RfyTEb3GqmlzSoAKAMURiECv5E7F67Mey4=;
 b=TnlGr2SIJkNGAmRjMkbl63DDO9u022PtxfJjZ+jddGWmyKEbhtz7I2uCQiK/7em0LPtxBM/ir0DGR15yIs1IIHJDrf8dpkP7qE5MMWCVTHdVnAKNH3io1Ox2+Z6dzXYYb+V+vt/BXxrEKTfbtWO7VgHaual9j2IsrTBFSWrrmf0=
Received: from DM6PR11CA0061.namprd11.prod.outlook.com (2603:10b6:5:14c::38)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 22:05:40 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::22) by DM6PR11CA0061.outlook.office365.com
 (2603:10b6:5:14c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 22:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:05:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:38 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:38 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/21] DC Patches March 26, 2021
Date: Fri, 26 Mar 2021 18:05:13 -0400
Message-ID: <20210326220534.918023-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f33e14c7-7cae-41f8-ccf3-08d8f0a34b16
X-MS-TrafficTypeDiagnostic: SN1PR12MB2591:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2591C484826A1E9B79ABCBAAEB619@SN1PR12MB2591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6QHnJpaMtTOaU5yCpZ4c/TXR3YeZkBu1+mT0oMgqXuGC0TNnbem2G2IfpwtGwt7uBOZ5fydNo2jSEnRJFTD8muxsjo6f8HOz96dVFFXlS+C+NzUpqk0rqCB7Y+KVUhyX6iQC5OjnSDjgbf/PGYHw1H9r/VM+vidsxgHGcVowUDMAxaCPC/guNBo8alg3rvmvJKWZGqzvoLuqnJwQkfk/P9YJDXQSRZIpjA5NyNqgUoAgQG0wATQv6umK4L0MTSM3s6pb48t3motcEC2lNXsC6JZ4+j+3zhVHqxCF4kV//9iXrdqJTfh0dEeSjD6qKUV7HCMlnadxKXgbgLUOECvz6yWcVqyZ/f3Kw/Axj28TLdh0NUpMhbKU2Me1fcDOUulbhgKiibgV1d/u9jvZbg8/C7fNlu83XIGBD9b6MP1lsVv9p/CsGLL7Z8vgor9hKKOGtjHqF5Bzw1Pu0juU+FrEdUmtdtmfMibiX34i3WjThhuVA86Xoe4JsiKa0mYUPlriNemLVHJ+WaoWEuaZEcZY+AP2DoHU1rOYpYtkt9f1QPvodqTXMHXHFV1eTa7XCscO0DYAHmbcIJbla1RLpRe47wNpymS8X2sf1cnq/5ujUluCd8UDFdiDGIYRUMUytlIwd2OzM79gVRC0Akeqytgb5/KWB2FFZUnjWb2r7koDRvTjUOhFWmnYC3jDNnXlDyv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(356005)(81166007)(82740400003)(316002)(70586007)(83380400001)(36756003)(186003)(6916009)(26005)(7696005)(336012)(70206006)(82310400003)(4326008)(54906003)(5660300002)(36860700001)(1076003)(478600001)(8936002)(8676002)(426003)(47076005)(2906002)(6666004)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:05:40.2006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33e14c7-7cae-41f8-ccf3-08d8f0a34b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset brings along following features/fixes:
    - LTTPR improvements
    - Disable MALL when SMU not present
    - Fix bug in HW that causes P-State to hang when DPG is enabled in
      certain conditions
    - Update code path for enabling DPG
    - Update display endpoint control path
    - Add dynamic link encoder selection
    - Fix debugfs MST topology to dump from the root MST node
    - Enable DP DSC Compliance automation for Linux
    - ASSR is enabled only when DPCD is supported and the display
      connected is internal
    - Added kernel trace event to print real-time refresh rate value
      to debug VRR issues

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.58

Aric Cyr (1):
  drm/amd/display: 3.2.129

Chris Park (1):
  drm/amd/display: Disable MALL when SMU not present

Eryk Brol (1):
  drm/amd/display: Fix MST topology debugfs

Jimmy Kizito (2):
  drm/amd/display: Add dynamic link encoder selection.
  drm/amd/display: Update display endpoint control path.

Krunoslav Kovac (1):
  drm/amd/display: Rename fs_params to hdr_tm_params

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix static checker warnings on tracebuff_fb

Qingqing Zhuo (2):
  drm/amd/display: enable DP DSC Compliance automation
  drm/amd/display: add log for automated test

Rodrigo Siqueira (1):
  drm/amd/display: Add refresh rate trace

Stylon Wang (1):
  drm/amd/display: Guard ASSR with internal display flag

Vladimir Stempen (1):
  drm/amd/display: Fix typo for variable name

Wenjing Liu (2):
  drm/amd/display: define mod_hdcp_display_disable_option struct
  drm/amd/display: add mod hdcp interface for supporting encryption
    state query

Wesley Chalmers (6):
  drm/amd/display: BIOS LTTPR Caps Interface
  drm/amd/display: Interface for LTTPR interop
  drm/amd/display: Enumerate LTTPR modes
  drm/amd/display: LTTPR config logic
  drm/amd/display: New path for enabling DPG
  drm/amd/display: Set max TTU on DPG enable

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  19 ++
 drivers/gpu/drm/amd/display/dc/Makefile       |   5 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    | 190 +++++++++++
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   7 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  35 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  16 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 197 +++++++++---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 303 ++++++++++++++++++
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  24 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   6 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  16 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  15 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  10 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  27 ++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  13 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  86 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 142 ++++----
 .../amd/display/modules/color/color_gamma.c   |   6 +-
 .../amd/display/modules/color/color_gamma.h   |   4 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  10 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   4 +-
 .../display/modules/hdcp/hdcp1_execution.c    |  37 ++-
 .../display/modules/hdcp/hdcp1_transition.c   |   6 +-
 .../display/modules/hdcp/hdcp2_execution.c    |  10 +-
 .../display/modules/hdcp/hdcp2_transition.c   |  10 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  10 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  10 +-
 drivers/gpu/drm/amd/include/atomfirmware.h    |  38 ++-
 38 files changed, 1141 insertions(+), 176 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
