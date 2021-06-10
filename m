Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7289FC47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4015661263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4015661263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36586E4CB;
	Thu, 10 Jun 2021 16:29:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF476E4CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMonzZA+pKzZ9WnjdbaX04aWS29cOtVdjnlmztkrU1RM/4rqqXUUhV8v6s1jEf3Ck9/1zI/88H3e8a+zLgUjfAcvjpZiPwxu5BxM/MaP7BW1Bls1y49NLcQ1DVTGBdgmI5tMPeHYhk+DspWq6bTuuDbzcS4ksznuwguHSKSsswpOZ9gvyEX0vyQ/zd+or2xipV3UQKRXsbbvjUZEtAC+CQRAYe/G7eaXTl5UjuJe/NIMWAt1u0or4+z70vbcfMw1fsS8Qbp1tIr5To/Q3xEN7kyjJfzs+HrjlYHEEpmCMfzeZ9IZgdrn6x1SsZgCKyJ9jlb/72ZGHuXut8Sd2h6YSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZjlnOZquMBZsLViLbA9rP0X2Oy0bVo5TEfMgf9VtIs=;
 b=g7b9h9ncWylYPeQ3vgn3v2QBFXL9E3MWL4pnQt3J/Pwa/TQltLYT7TFcKiVrosfM5mn0syskBIgxJtmJEDwyjDJ71+/35eVOjAQRGxJXvJSfmZA90ziTiJLeKTZaEoGm9XBIxZL1hw8v3Psm6qm4IlQ81w9IIOOWjNQ83RyAB0HKkWAD3ZvTgRRyyZFh9kGrw+r4InWSCQY1MLm+PLxjpSivE3f5voukqj0GO0Dkzr0gtzxCI6V4UVqKdEFd+dyXYZWD22LJ0//YKs3xY752hv8i/MnSiU2on//VLsdv8w8j29SW7H68lOIAIHk/MNNb/E3TxinIAclg4Lct2XORHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZjlnOZquMBZsLViLbA9rP0X2Oy0bVo5TEfMgf9VtIs=;
 b=WY9M6JomMBKB9iMChh245iwqotC2/Fud39RbhEQZVQiwfJFgn5gT6HgL4wQmh4mkorkZ09fIRq+beM8a3COGJTjnOwx2ZYcoqmWoSigN+aIq6VSpwXiACLQ41a+QGE9goeCFhxIv75CCm95a7JPuRT4xVmPxc3UIEw5vAEpON4o=
Received: from MWHPR17CA0052.namprd17.prod.outlook.com (2603:10b6:300:93::14)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Thu, 10 Jun
 2021 16:29:07 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::5c) by MWHPR17CA0052.outlook.office365.com
 (2603:10b6:300:93::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:05 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:04 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/24] DC Patches June 10, 2021
Date: Thu, 10 Jun 2021 12:28:14 -0400
Message-ID: <20210610162838.287723-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57537665-9db8-47a9-094c-08d92c2cde2d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5289:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5289471B79E1BFCE5604F55DEB359@BN9PR12MB5289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcqTF21dkAZx2hk19g4EHvPzJm7ZaSU00s1UoYW6TRT3QP5CSdAshzCK6LVNHH48h3DRaJBNGdbGbg58uisSMkvTAWXu+kb5HMw1M6SgQemnkok7M/46D8wNer9oYM7sQi56y96cmmd5pRG0QUVjVZG8w9lchjeThTE5SgTgLNO5gRhHWtKzwsNqIOXaLJXXq0H7PTjWDs3OaFkLjUwWTYdQWeZk6sSeLNhETgCzIKP2+T6w6blED8HdS+J1Pdn+agynZZHN61mwNCc16fFNbanTbOh7b/y1/+j3B+6u5TdAMwthch5HYbcLk6p7nPesEU4AqjAAFi7r68SAyogSEEMxJomHbKvg//1G8c2pFvE5fh+xPWW5lnNE3mMrWvcaGX27eBxR2mMuZBGPa3CxvZTeLytiFXcUOSrPIzMhPBYjaepBYBUSrSAzj7amEQUQ9V0YZ4QXFB6kORv64uMAsN7nfeOB6SjZTbitWdE7Ttw+JvKt8GuAgSaaRxOsFdYaOn4fVu12uZ8xGxpMnwB4iCRutNDBrc4b97GRwyQCXWcXyjVTznNdHCxLlbW33FRgNmC08SVqxgcYbZqCOcS+FrpM6iXREzxy/Opz6Qa1/OZan+0zNChvBZYJTpCQ0X/udxNKAkhkbsIi001SGfZZ9qqsI+/BACvpO2wE2U3yUH29dJhGyP5K/4CnVYTdWYp8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(5660300002)(2906002)(86362001)(2616005)(1076003)(426003)(83380400001)(54906003)(6666004)(8936002)(26005)(36860700001)(316002)(4326008)(82310400003)(336012)(47076005)(8676002)(70586007)(70206006)(7696005)(81166007)(186003)(478600001)(36756003)(82740400003)(6916009)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:06.5783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57537665-9db8-47a9-094c-08d92c2cde2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
* LTTPR improvements
* Backlight improvements
* eDP hotplug detection

*** BLURB HERE ***

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.70

Aric Cyr (1):
  drm/amd/display: 3.2.140

Ashley Thomas (1):
  drm/amd/display: add DMUB registers to crash dump diagnostic data.

David Galiffi (1):
  drm/amd/display: Updated variable name.

Dmytro Laktyushkin (1):
  drm/amd/display: Remove unnecessary blank lines

Josip Pavic (1):
  drm/amd/display: tune backlight ramping profiles

Po-Ting Chen (1):
  drm/amd/display: Change swizzle visual confirm reference pipe

Roman Li (1):
  drm/amd/display: move psr dm interface to separate files

Wenjing Liu (1):
  drm/amd/display: dp mst detection code refactor

Wesley Chalmers (14):
  drm/amd/display: Read LTTPR caps first on hotplug
  drm/amd/display: Move LTTPR cap read into its own function
  drm/amd/display: Read LTTPR caps first on bootup
  drm/amd/display: Set LTTPR Transparent Mode after read link cap
  drm/amd/display: Always write repeater mode regardless of LTTPR
  drm/amd/display: Improve logic for is_lttpr_present
  drm/amd/display: Enforce DPCD Address ranges
  drm/amd/display: Rename constant
  drm/amd/display: 7 retries + 50 ms timeout on AUX DEFER
  drm/amd/display: Do not count I2C DEFERs with AUX DEFERs
  drm/amd/display: Partition DPCD address space and break up
    transactions
  drm/amd/display: Add interface to get Calibrated Avg Level from FIFO
  drm/amd/display: Cover edge-case when changing DISPCLK WDIVIDER
  drm/amd/display: Extend AUX timeout for DP initial reads

Yi-Ling Chen (1):
  drm/amd/display: add config option for eDP hotplug detection

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 +----------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 166 +++++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |  37 +++
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  68 +++++-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h  |   3 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 167 ++++++--------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 170 +++++++-------
 .../drm/amd/display/dc/core/dc_link_dpcd.c    | 218 ++++++++++++++++++
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  31 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 100 +++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  23 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   5 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  24 ++
 .../display/dc/dcn20/dcn20_stream_encoder.c   |  12 +
 .../display/dc/dcn20/dcn20_stream_encoder.h   |   3 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 +
 .../dc/dcn30/dcn30_dio_stream_encoder.h       |  12 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   4 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   2 -
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  11 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/link_dpcd.h    |  18 ++
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  14 --
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  29 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  65 +++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  14 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn301.c    |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn302.c    |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn303.c    |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  10 +
 .../amd/display/modules/power/power_helpers.c |  20 +-
 .../include/asic_reg/dcn/dcn_3_0_1_sh_mask.h  |   2 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |   2 +
 include/drm/drm_dp_helper.h                   |  17 ++
 45 files changed, 1042 insertions(+), 403 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_dpcd.h

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
