Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2F5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5FF61250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B5FF61250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE35B6E1FB;
	Fri, 24 Sep 2021 19:09:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7DE6E1FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQExiAqxIi+MzNkHXYT3YqMOGsUfpUTg/VuEYxcr+W3X11qCwQz1vCgR03jrWrWbV7VteUTtn4jFaiG0JiR1zHT9Cdhxj6xWlkB1iTgXUYva0xhyuD1/r2M4lTXZ+eSYbXDWIzPAXyhSm2j1f27fRuGHWq5m+BNqarTQjBb4I7/ezvx333Lm8beQjRH5007FcU+fPRWFcACkPclFICsUCMR2OObcWresI7ZqqxFu8J+E1f4dgtAMC9rS44KCVb/LUMVAfBJpnpKFevjKW1hFt4C3HTrmvUTJl6HFbaepOQZ5WEgesHYK1mdJR7Q1p7WjRHtPnx1ulcdbum1eOYFnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=c9FwAL55IKORW/+ZRmADuevkVtvEKVABfe44Aj1Q588=;
 b=efkcb7LZpnmTNXiiH301Yj7f+Wyft2ACJXTU5PoFeA7zZkVN3kRNVWVAc/8V+pUx+sYnWJ4xEsqEr0oVMK38riabLl63619ZBd45+XtkWSWyISCO/SGqdBOzkY51NZvPkbu2butuHLzodQbpkJvJgzo0xkyZVx6nksTQOf/jRRV0R/gGbspHLHCvpWn2xYM384qQnpC1alT22AVNJb6yo7rk9ETnAHUMvgMIOqhqxGnIMUq/tIujrT+Y+kXVa66L4RDapkrJMODq5XaR9ygIGFNkWbw//VG9kU23780EJKdoAkzxeVlez+QGR20AM0QBpqXOTguJwZQVg8UJykGNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9FwAL55IKORW/+ZRmADuevkVtvEKVABfe44Aj1Q588=;
 b=r9SGRwc5gmDWJQxbZwqedM9RBg0hk6RrV+LCM87Z2L7sPpEfGYb38RS73kswEn983qavDGJinxilL0TjmML+ZB60lDi9IFnlAbOPMoeaa2AqsAeQssB6LQEHg4mpdXRXC2InlJyZ+UWD/UZrMMFUBE4yFh0gKb0L0ieTKXPptJA=
Received: from MWHPR22CA0072.namprd22.prod.outlook.com (2603:10b6:300:12a::34)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 19:09:46 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::70) by MWHPR22CA0072.outlook.office365.com
 (2603:10b6:300:12a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Fri, 24 Sep 2021 19:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:09:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:09:44 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:43 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>
Subject: [PATCH 00/24] DC Patches Sep 24, 2021
Date: Fri, 24 Sep 2021 15:09:10 -0400
Message-ID: <20210924190934.1193379-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49a7ae00-4084-44dd-f633-08d97f8edf83
X-MS-TrafficTypeDiagnostic: DM6PR12MB4417:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44177CA4EE67C54C3005FCF8EBA49@DM6PR12MB4417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Hljy+r7a1wfgsxgAOSOwexfepsLCcqnsa4acFbdDMmJZc5SQzZoh9ePmYRJp/LP7EL6Hk9VQ3tQnNu/VPQPGWmyDcY3WozyBUeN23cPvIhuEBDCV7Y9wTK70sLX7INilMKIiZplIxl68A7nz3OzhexZi4PokyX7LSeIn8wS2WV3zEbfe7Z6JfVbFuoNMua4WuhI8DvUoEfdu30guyfpYJrGX2/wdydiNodGCcZVQVCPmsbDpP2UxHyTTQgEuRV4Kiz/nYdUSfZ1ErgtisoCVFLq84Y1CymGYWU7hJ1FMNSbJUGBJUXipBNPl38Jf0BlkDkwIyLS0hLh9Niau+Ohz2CaYfIE0HYFtVro82BBua0vgBvUNaYKO6bFtfLTKu4QHIXX1kbiBB2wLYPcoTt440Vl6eDqEaKTkS4YgATRLaXxtiEy0OTJk0S4FgXhc0htoStEALRGKFxMAkej7IDIqylF2+fpbeV/p3BCzKTFQ4e5Qw2beZ7+s9MHqzTg80ErSQnkE/lQN5Y2TydBUMdnnMajxu1JIjcg8nbK5tblBKqGx9hWbBCxaBIpJtAlDo9+voZpk2XAZEjgu2OyXTHNbQz5Av0ZtE5n2af2YvPor1LYnB4q+PzURgBemCB0pvovTk4TJZOu/Z8qlBgCtA8xE1mbIW9VGEkg8oF8De8jNbT9gkElqfKnqDXYQ8Mkj11Xn8ClxWNsMJ1ZNcfd9IuEX5lXn6BXAJMhDclSlBiA1ts=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(36860700001)(4326008)(8936002)(7696005)(2906002)(6916009)(8676002)(508600001)(186003)(47076005)(26005)(316002)(86362001)(82310400003)(336012)(2616005)(54906003)(6666004)(70206006)(5660300002)(70586007)(356005)(81166007)(83380400001)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:09:46.0167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a7ae00-4084-44dd-f633-08d97f8edf83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

This DC patchset brings improvements in multiple areas. In summary, we
have:
    - Fixes to backlight, LUT, PPS, MST
    - Use correct vpg for 128b/132b encoding
    - Improved logging for VCP
    - Replace referral of dal with dc

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.85
  drm/amd/display: [FW Promotion] Release 0.0.86

Aric Cyr (1):
  drm/amd/display: 3.2.155

Charlene Liu (1):
  drm/amd/display: Pass PCI deviceid into DC

David Galiffi (1):
  drm/amd/display: Add debug support to override the Minimum DRAM Clock

Eric Yang (1):
  drm/amd/display: add vsync notify to dmub for abm pause

George Shen (2):
  drm/amd/display: Handle Y carry-over in VCP X.Y calculation
  drm/amd/display: Update VCP X.Y logging to improve usefulness

Ilya (1):
  drm/amd/display: Add PPS immediate update flag for DCN2

Jimmy Kizito (1):
  drm/amd/display: Fix MST link encoder availability check.

Josip Pavic (1):
  drm/amd/display: initialize backlight_ramping_override to false

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for link encoder access for MST.

Michael Strauss (2):
  drm/amd/display: Don't enable AFMT for DP audio stream
  drm/amd/display: Defer LUT memory powerdown until LUT bypass latches

Oliver Logush (1):
  drm/amd/display: Add an extra check for dcn10 OPTC data format

Qingqing Zhuo (1):
  drm/amd/display: Replace referral of dal with dc

Wenjing Liu (8):
  drm/amd/display: use correct vpg instance for 128b/132b encoding
  drm/amd/display: update cur_lane_setting to an array one for each lane
  drm/amd/display: add function to convert hw to dpcd lane settings
  drm/amd/display: implement decide lane settings
  drm/amd/display: rename lane_settings to hw_lane_settings
  drm/amd/display: decouple hw_lane_settings from dpcd_lane_settings
  drm/amd/display: add two lane settings training options
  drm/amd/display: make verified link cap not exceeding max link cap

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  14 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  73 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  73 ++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 591 +++++++-----------
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  23 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   5 -
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  21 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h  |   6 -
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   6 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  11 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |   5 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   4 +
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   9 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |  59 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  21 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   1 -
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |   2 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.h  |   2 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |   2 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.h  |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  58 +-
 .../amd/display/include/link_service_types.h  |  29 +-
 34 files changed, 583 insertions(+), 477 deletions(-)

-- 
2.25.1

