Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFEEC54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E5110E3AF;
	Thu, 26 Jan 2023 00:33:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E2F10E3AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFRx2QgaPXPc/QFK3hLgtwfe7Y57x1hC4VaJhQfqQZNmDzfkDnBVQX9Z1O07Xbn3ga0I0/5GDRrw1prtbcDA80oKbyEPBX8UDC8QI+G+f6pTFna9aow9Bizjwpg5EIaZNwEh8oqp0fPTMYyJTvpp74Oq0m8qQ1npeBgyB7VsToVa7+8MmM++q0T7Bw1G1LC7vPNE/8T26kXOvQG6Z33t5vSXOH83Dy7ScSqMys317XiBVMWBnuPjPF2pAXJp8jjFTLtBXlOFXVxPyhn4NjaMM5f5h7Bp/+3OKKbRpGTgaFBjYGcoutbS9Ao9TF9/9dMeBMLR+BsyJiU3SbNtD3A9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD1y7A/4OU9cs3OOJmGgy24RQu2L5f5YXQGs9f4jEiU=;
 b=i9wSXXKKZxovafhjuyGa5EsgSIPhTa9BwuCQw7gqZFF0v0OHNcQ9Vn0COgYCY47BZX8lR4fmXRgdh9QztkCfx3uxtlncJPwTalXkCtymOJb83T5XeW54VEvxK8c1r+6nhrFD78G/Un6JW6S2Z9RX1bcBCFNsqoTAsAH69vbgbWnd7jKa4CoseLsrjIOnv6SdMlZhjCYmSIMZ8dxIGkCWzfxbzr8hqeFxPbUSj4cCkHBDrO6k5z8y2lWsXwqzjltSirPWr89899mgw0F0UcVEhEBFhG8BFsRzIykWlKoftqkvlCbaaArVoOFHBzV0gANFtNOGBUZya5/xl615VcMs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD1y7A/4OU9cs3OOJmGgy24RQu2L5f5YXQGs9f4jEiU=;
 b=JDqJiCOkkPbZfSL7HKieqUT4+adtEZ3q+EJqcEvQ5QJI/QO1AFTucVQdGHSBuB4uGwNKgUJTrckBXELWoP86DMhTUZnRpWL/+Hf1R6wJEbjSSDyzzg7ENVHbXdTk8m6DqyA73gtSec52/2FHRzwqN/JYPD9GEXZftOlKFDXT3zw=
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 00:33:32 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::b8) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Thu, 26 Jan 2023 00:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Thu, 26 Jan 2023 00:33:32 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:33:30 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches Jan 25, 2023
Date: Wed, 25 Jan 2023 17:32:14 -0700
Message-ID: <20230126003230.4178466-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9521e3-07a4-48a7-e072-08daff34f422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCOks0CqBw+hP2naZOg/hLpPdghM2AYxsSweTzHdtZvEUVEoyXslFjyy3oC2z7Px382b3lT+RzvK2uPTBcnM7Bk5nKyz+R5pb3CymJpmZXBVzFYwWCz6M8fsVRcrJXh+MyZoysQwKrjRsjDVPcUUQrwfSkwr90Ld4cU2AgdYzmV3DcHPXG1D2QHi1jooESQLcpe7Dm3xFHu96nFr6v/VNGxeu8rnGS3CLm0d0eYT5izKINsYYygBONdmMucyDC65fEs2gEgs3J9xV8qshbfG37SoLH3TMgU6a+6HPK6iD7xTZr+hJ7/j5wmQhdnMV+tumlapV5Ehi0f+WptdN/EPWbbliciKQJTM2bzmzDjduGUVVR9L2ptHgVqrn/Iesc9Qof1CtR9P3vH+Kv2lgCt+SGoTBitfTLcVNDGCAM+VbXKx8+/gsko+VM6tETWaYXN+0KR2SHgKNcCbmmEMIdrUw/+CRvN9kyfgEdMamF5N3sjKNr+u87LNQVic9Q00mVU8tZV9CXnroMjAB6KiaZa84mjiPcMJRcHeK8p0n2EUvLvE+nacPPrF/ri5a+xu17NEcgpNuSVvnZHFuEFuPY54cG8o8K7Au00kWi3CQ/ImOaLtjJRYrzHvgEzzTOdpCeDfI+atIXdjQ3s7ALKUMbNQWxq2EMKtyH2HkCS37ENX8pXE93+0qIXDrA0HE+4EKWoKi0U+3Ee4I0RVyUtf1k5rGFWAqA+XgwbRGt7U9gjMXqo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(7696005)(86362001)(82310400005)(186003)(6666004)(478600001)(26005)(70206006)(316002)(36860700001)(16526019)(40460700003)(54906003)(40480700001)(70586007)(4326008)(6916009)(8676002)(81166007)(356005)(426003)(2616005)(41300700001)(36756003)(47076005)(336012)(8936002)(44832011)(83380400001)(1076003)(82740400003)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:33:32.4873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9521e3-07a4-48a7-e072-08daff34f422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Fix linux dp link lost handled only one time
- Reset DMUB mailbox SW state after HW reset
- Unassign does_plane_fit_in_mall function from dcn3.2
- Add Function delaration in dc_link
- Fix crash when connecting 2 displays with video playback
- Adjust downscaling limits for dcn314
- Fix FCLK pstate change underflow
- Fix only one ABM pipe enabled under ODM combined case
- Add missing brackets in calculation
- Correct bw_params population
- Fix Z8 support configurations
- Add Debug Log for MST and PCON
- Fix MALL size hardcoded for DCN321
- Add rc_params_override option in dc_dsc_config
- Enable Freesync over PCon

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (2):
  drm/amd/display: Revert "avoid disable otg when dig was disabled"
  drm/amd/display: 3.2.221

Daniel Miess (3):
  drm/amd/display: Correct bw_params population
  drm/amd/display: Add missing brackets in calculation
  drm/amd/display: Adjust downscaling limits for dcn314

Fangzhi Zuo (1):
  drm/amd/display: Add Debug Log for MST and PCON

George Shen (1):
  drm/amd/display: Unassign does_plane_fit_in_mall function from dcn3.2

Hersen Wu (1):
  drm/amd/display: fix linux dp link lost handled only one time

Leon Huang (1):
  drm/amd/display: Fix only one ABM pipe enabled under ODM combined case

Mustapha Ghaddar (1):
  drm/amd/display: Add Function delaration in dc_link

Nicholas Kazlauskas (2):
  drm/amd/display: Fix Z8 support configurations
  drm/amd/display: Reset DMUB mailbox SW state after HW reset

Samson Tam (1):
  drm/amd/display: fix MALL size hardcoded for DCN321

Sung Joon Kim (1):
  drm/amd/display: Enable Freesync over PCon

Vladimir Stempen (1):
  drm/amd/display: fix FCLK pstate change underflow

Wenjing Liu (1):
  drm/amd/display: add rc_params_override option in dc_dsc_config

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 72 +++++++++++++++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 67 +++++++++--------
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 45 +++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 12 ++++
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 31 +++++---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        | 26 ++-----
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 24 +++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 30 ++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  | 36 +++++++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  9 +++
 .../amd/display/dc/dcn314/dcn314_resource.c   |  5 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 14 ++--
 .../dc/dml/dcn314/display_mode_vba_314.c      |  2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  4 ++
 .../gpu/drm/amd/display/dc/dsc/dscc_types.h   |  5 +-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  | 10 +--
 .../dc/link/protocols/link_dp_dpia_bw.h       | 24 -------
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 12 ++++
 .../amd/display/include/ddc_service_types.h   |  1 +
 .../amd/display/modules/inc/mod_info_packet.h |  4 +-
 .../display/modules/info_packet/info_packet.c |  4 +-
 25 files changed, 328 insertions(+), 115 deletions(-)

-- 
2.39.1

