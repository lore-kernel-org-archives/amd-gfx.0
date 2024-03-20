Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F34BC54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA2010E580;
	Wed, 20 Mar 2024 06:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WYfquOzb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE8A10E580
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhJSSfmEZa89W6+kXnfVc+4q8B88uSNa0XByEdizYJY1p8gEvrgXiNGMza26ah4I7q4TdawANBcZZ0yw4B66h12SDKE5MXvmc/5c9J15g+NU1Uuswp/eBjBQ5dUVjd+3Kl1wBjKlhu6IYROiTgL12zdWpjFgHdGabNzrUEFDkUapmEbGrJ8zvslScxBLCIj53/MTussFss/4ilrj2gaF6/U9UpE65vPMJSsne2cT57RBy+CTKj9R9LmthqwECiSOeQZwppSsWwPP57UVrMVFlQtYn+s1iQelOpKCPcrA4SRUp5l8Dj2ntM1O6E4Ghgo0XFS+e4L5Cjxijvy7GCA0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gSNetJvC5PEGU9jhlOH+VsGg6afQp05XRUcYuzV2ww=;
 b=fEHIOUBjZ9aAL9XTpOwh+2rs5qRVWbe7KF5bZZ8qKizIVPMyf84lnYeV529kyxHK5IuYIxzvdylBEgTXgt0O8ZZMEa1hGLxqeRcQBO3C+EYvIMQTA3ybvwzbmA6IIlzuiqVXz8K1olLoJuWgP0BI5Zr0FvWgcf5qXF/I1WPdtvS9uqXqr4HpLQ/zJbVSSWJwAeiwElnf9DjJCOg/omFq2Ye9FK6Ctfdsbap3Boz0b63FxCloZfmjSVHaS/fGvEp5vRRPg3WXHoqxxLhbAZLD7/OBWnsZQDHbZNDZYSwWxZI8fjfXOABtWIZqcY7o/S0yoOMvBlnhceozqEv/jf/RJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gSNetJvC5PEGU9jhlOH+VsGg6afQp05XRUcYuzV2ww=;
 b=WYfquOzbBWSvzrHWp2LHGK5dt36aPCFWgR1WmQeNr4lsIkMPXQLUYpfmb4dYpwISYMVsjILUzCNMitwyd+7zJU2X+efdryJBnUPZ6XYUeehBUynIdaEpxDhjaiQV6SMsAKgs5O6QQv7g7R8fYBIM8hEA6/gN1bGf5n6ZJOZ+jf0=
Received: from BN7PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:20::35)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 06:36:06 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:20:cafe::b2) by BN7PR02CA0022.outlook.office365.com
 (2603:10b6:408:20::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 06:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:36:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:36:05 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:36:02 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/22] DC Patches Mar 25 2024
Date: Wed, 20 Mar 2024 14:35:34 +0800
Message-ID: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 5748e153-a98c-4831-3c14-08dc48a80532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 613IItYffHmHWkLLTQiCeC/gRwwd+Mtq/jbY1a/4O+s5TAXlOQ62wxVO3vYP2ircWFT8u9JHxbkK/TA+Yy87gZgeIGq+VanUoTjJW6m2OR4w/OHNuN1Vk5WkbFu0GK8wMs4EALSqz+5PNjbN6r6DuLUdY1khHH4iLUFyy+9okA/E8cxda7/2GzoQMwmY02cdVqboG0pNfdcCA4yKEH6myg5u+4O9KDj+ejRyPMv+9App325BVKW2DTjNLXiogSwNau1cBMyuMNjnKs17/UanFySpTcj7iG8un2quEBzlg2CAEuxqOZ01G8fhyHXA+LmBrMN+VeFQ+ZpI/5NwzWlZRoK7H7xmK1hT3tB6LBOy2rNh44gyAZ0ZXGT4mlAxJO/bmDZ5DFJTpQCf5Op3uURvXO1xO192dzwPZR0lXwHEDvG8g0lv0z8Wf3L1TLmnHFM2TtQUsMT51uhL0lqGloGOxCrVPB2v/n7mPI5gx/VeSYjAFWl2lLV2NU4xjXeQEdNCIPFCCrKNqsPn0M6HVFOvtiqEOc2u9JXr5dI4c+AhDdkj68jHrgAxoVD2uaU0r3Uu25UG9tMFPIb34esAEOpN9P3yEn/8W5IIDvUzXriz4TyFV19HIcGj62rO0g4IR89BD2AtwoOwJhIjMKAR/YHV1bNTPeNfX8LIp4kofWbRo/bhBmfQdP+c7gNhjCaTlb9whEJwG87syXXfGBNYddOs5mmKFp0NCBgck6rjsQEl1olWS7+LVEtF3RPvrxM8E7iE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:36:05.8182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5748e153-a98c-4831-3c14-08dc48a80532
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
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

- Fix some bound and NULL check
- Fix nonseamless transition from ODM + MPO to ODM + subvp
- Allow Z8 when stutter threshold is not met
- Remove plane and stream pointers from dc scratch
- Remove read/write to external register
- Increase number of hpo dp link encoders
- Increase clock table size
- Add new IPS config mode
- Build scaling params when a new plane is appended
- Refactor DML2 interfaces
- Allow idle opts for no flip case on PSR panel

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alvin Lee (2):
  drm/amd/display: Allow idle opts for no flip case on PSR panel
  drm/amd/display: Remove plane and stream pointers from dc scratch

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.210.0

Aric Cyr (1):
  drm/amd/display: 3.2.278

Bhawanpreet Lakha (2):
  drm/amd/display: Allow Z8 when stutter threshold is not met
  drm/amd/display: Allow Z8 when stutter threshold is not met for dcn35

Dillon Varone (3):
  drm/amd/display: Expand DML2 callbacks
  drm/amd/display: Refactor DML2 interfaces
  drm/amd/display: Modify DHCUB waterwark structures and functions

George Shen (1):
  drm/amd/display: Remove MPC rate control logic from DCN30 and above

Muhammad Ahmed (1):
  drm/amd/display: Skip pipe if the pipe idx not set properly

Natanel Roizenman (1):
  drm/amd/display: Consolidate HPO enable/disable and restrict only to
    state transitions.

Nicholas Kazlauskas (1):
  drm/amd/display: Add new IPS config mode

Roman Li (1):
  drm/amd/display: Fix bounds check for dcn35 DcfClocks

Sohaib Nadeem (1):
  drm/amd/display: Added missing null checks

Sridevi Arvindekar (1):
  drm/amd/display: Increase number of hpo dp link encoders

Sung Joon Kim (2):
  drm/amd/display: Remove read/write to external register
  drm/amd/display: Increase clock table size

Taimur Hassan (1):
  drm/amd/display: Send DTBCLK disable message on first commit

Wenjing Liu (3):
  drm/amd/display: fix a dereference of a NULL pointer
  drm/amd/display: fix nonseamless transition from ODM + MPO to ODM +
    subvp
  drm/amd/display: build scaling params when a new plane is appended

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  42 +++---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  45 +------
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |  21 ---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  86 ++++++------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  89 ++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  31 +++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  16 +--
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |  49 ++-----
 drivers/gpu/drm/amd/display/dc/dc.h           |  29 +++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  29 +++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_state.h     |   6 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |  12 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |   8 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |  10 +-
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.h   |   2 +-
 .../drm/amd/display/dc/dcn201/dcn201_hubbub.c |   2 +-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |   8 +-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.h   |   8 +-
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  54 ++++----
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |  14 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |   8 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  10 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |   8 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |   5 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  23 +---
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |   4 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   9 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  10 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  23 ++--
 .../display/dc/dml2/dml2_translation_helper.c |  14 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   5 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   9 ++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  28 +++-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h  |   2 +-
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |  10 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  10 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  44 ++++---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  24 ++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  84 ++++++------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  66 +++++-----
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   5 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  41 ------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 122 ++++++------------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  57 --------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   7 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   5 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 -
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  12 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  17 +++
 .../dc/resource/dcn32/dcn32_resource.c        |  41 +++---
 .../dc/resource/dcn32/dcn32_resource.h        |   6 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  25 +---
 .../dc/resource/dcn35/dcn35_resource.c        |  10 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  10 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  40 +++++-
 71 files changed, 669 insertions(+), 743 deletions(-)

-- 
2.34.1

