Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890F5CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F13E10E4E9;
	Thu, 19 Oct 2023 13:32:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D0810E4F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzLSYhpgXqOmcXX99HI+LZXI1njU6HhgR97vPNoZSKsl3LszmMHDRiMtA2RyzVeWrvmtyIMWPpkQxNKuU5CQFPWMoSkokmq46G1bk6Q0kp8eGJhXPWGqfwJck67j7psHRHA0SYPUQxS1PrgySD5eJFWCRlLqqu3GYWda6sFHvkmwGtMuhe5GGwEysPFdCEVWUprSgvrVkZkdUMHgXWBq633J8rtRMYmsJPGrz10Q/brs6NQpqEhDwJU2oNSa6mWEmKCWxYhpTtjf8zKApXr20lw+wIDLmhDbgdORvcOLTBltsRaKBOjZF1XFygDojxDrOOBa0Ry6jgh4H5gC64Ehiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1C6p+P6pJ0sR3WyFS54VFdJ50/XN1Gg0Hk4eJnFNtw=;
 b=ewXkg6djTRKefUI+3rWGrdmsrXqjZKWmQz/BXCEGrm1UW3Ft6nzVQ2T5gFQGFmu1lOTjhpK9AKGaXR9zAJo2wuZ+yFEPqURvBdnkHmiGO0nwvNE5C6BtUDG7k6dGZGGG5ZJlQjntAIN4bF3eZoBt2H1YcseLmdZmy+u4MA//EgSdZ3RFf1qtTCPhC3VMj8SDlZ8ex9X/g+cYd3tS/MWiwgfqVJaZMj4iDJ/ewMuMp8vcrLV9LkR0uhEGYumsdahzQp7vE5qKCkjyE7kXuG7cz52hNnf3/M3XZaL97NuRKheb8u8aocuvNE/Ljylj8Z3fYETR+ph8tv60YnepS0TolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1C6p+P6pJ0sR3WyFS54VFdJ50/XN1Gg0Hk4eJnFNtw=;
 b=xxyO7F+AwVuSPBKcDxawYp9ZKOgogibe7YHNyBm1s7iKMrrjt46Zfg5dNme0HbycSUiP6R9J3W751yrNF4riaS5E3U7tJRMXU2aDaSZ8ZFkKPTmEWmwcy8O6B9v4CflWwcziBOXVyGyeTIgORDAF7F24QDsDxjt13XR31sqPdwc=
Received: from MN2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:d4::16)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Thu, 19 Oct
 2023 13:32:31 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::d1) by MN2PR04CA0003.outlook.office365.com
 (2603:10b6:208:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:32:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:30 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:32:24 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 00/24] DC Patches October 18, 2023
Date: Thu, 19 Oct 2023 09:31:58 -0400
Message-ID: <20231019133222.1633077-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 8400e431-4f4e-4c8a-12be-08dbd0a7d857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taZMfCgUXA+z5VuK1LwRYPVYGWw4Ugsg21aeZVx6B8EW3dxsubnvaRO9mMosIwICPhvyhMzBnKnqVnxgS+QhkJU4br2HbgFi5hOg/lOZ7pwHtUk5QYr3uP7RT8lAtzRLhtrg7btrqP+5AYZ/b8ZXWahntL/Cbb2YHK1NdLZVw8LwOFtH2uIsNAbWiq6Nq837RVbmtOg9VvcRIIQodMdwGrEpkBib8ttUb2QyT5aYB5D8Axrzc45KZMG36jcl6NxlNVUeP3jsfhG32TtIV9F35n9TFUHeNO28SsOoyL1ErLF23HaaOV52jxq805rM2JA74mPkt0IdFOasbQDDlAXKAPyUnCTK+jK6vk+wZFdqYNon1sLou0oFzw3yAwT3CW+PmbWtrlpaVqaEfryytHVWwKK8b+xvgb/vQnddouAwFOcTcKhxBvzwUVeuRRVG5QnN+VglCbiyeJtqKj3aQfULW2ExT5drSeuHnbTzvJFo7iTDoSgmDSfF7v1YK9vl+N0nc6TBBRLHNRDaqMcWDZKdjoF62Zn0ABgvKYAkUIYb1KvfRw6N4gy3s7yQBYj+gCJi9ffcCvArnecVJItL22LWM3djf8hjDaWLtJi1ad7bRKyZBiZpn0+SiW64XvhZoOxiEMSNLtZnwIZdSMmk6ptLL3GqG11cefflRjf7yDEhCIQ9ZAFphI1/VgwTCq0CPLpk/VIcti6NwlXBUiKzbMocxDwJd5EhYy1LadSINaoGuJErFraiVe73pW3mQV2stECCklA3wNNkv412m4VTu67Znw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(46966006)(36840700001)(40470700004)(86362001)(40480700001)(4326008)(5660300002)(2876002)(2906002)(8676002)(40460700003)(8936002)(41300700001)(36756003)(47076005)(81166007)(36860700001)(478600001)(2616005)(26005)(1076003)(82740400003)(6916009)(336012)(426003)(7696005)(316002)(83380400001)(6666004)(54906003)(70586007)(70206006)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:32:31.0289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8400e431-4f4e-4c8a-12be-08dbd0a7d857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707
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
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Fixes null-deref regression after
  "drm/amd/display: Update OPP counter from new interface"
* Fixes display flashing when VSR and HDR enabled on dcn32
* Fixes dcn3x intermittent hangs due to FPO
* Fixes MST Multi-Stream light up on dcn35
* Fixes green screen on DCN31x when DVI and HDMI monitors attached
* Adds DML2 improvements
* Adds idle power optimization improvements
* Accommodates panels with lower nit backlight
* Updates SDP VSC colorimetry from DP test automation request
* Reverts "drm/amd/display: allow edp updates for virtual signal"

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Agustin Gutierrez (1):
  drm/amd/display: Remove power sequencing check

Alex Hung (2):
  drm/amd/display: Revert "drm/amd/display: allow edp updates for
    virtual signal"
  drm/amd/display: Set emulated sink type to HDMI accordingly.

Alvin Lee (1):
  drm/amd/display: Update FAMS sequence for DCN30 & DCN32

Aric Cyr (1):
  drm/amd/display: 3.2.256

Aurabindo Pillai (1):
  drm/amd/display: add interface to query SubVP status

Fangzhi Zuo (1):
  drm/amd/display: Fix MST Multi-Stream Not Lighting Up on dcn35

George Shen (1):
  drm/amd/display: Update SDP VSC colorimetry from DP test automation
    request

Hugo Hu (1):
  drm/amd/display: reprogram det size while seamless boot

Ilya Bakoulin (1):
  drm/amd/display: Fix shaper using bad LUT params

Iswara Nagulendran (1):
  drm/amd/display: Read before writing Backlight Mode Set Register

Michael Strauss (1):
  drm/amd/display: Disable SYMCLK32_SE RCO on DCN314

Nicholas Kazlauskas (2):
  drm/amd/display: Revert "Improve x86 and dmub ips handshake"
  drm/amd/display: Fix IPS handshake for idle optimizations

Rodrigo Siqueira (3):
  drm/amd/display: Correct enum typo
  drm/amd/display: Add prefix to amdgpu crtc functions
  drm/amd/display: Add prefix for plane functions

Samson Tam (2):
  drm/amd/display: fix num_ways overflow error
  drm/amd/display: add null check for invalid opps

Sung Joon Kim (2):
  drm/amd/display: Add a check for idle power optimization
  drm/amd/display: Fix HDMI framepack 3D test issue

Swapnil Patel (1):
  drm/amd/display: Reduce default backlight min from 5 nits to 1 nits

Wenjing Liu (2):
  drm/amd/display: add pipe resource management callbacks to DML2
  drm/amd/display: implement map dc pipe with callback in DML2

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  48 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 542 +++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  26 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  26 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  23 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   9 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   8 +-
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |   5 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 146 +++++
 .../display/dc/dml2/dml2_translation_helper.c |   2 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  16 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   6 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  21 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  11 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  39 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   6 +-
 .../display/dc/link/accessories/link_dp_cts.c |   6 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../link/protocols/link_edp_panel_control.c   |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 +
 .../drm/amd/display/include/signal_types.h    |   1 -
 31 files changed, 646 insertions(+), 343 deletions(-)

-- 
2.34.1

