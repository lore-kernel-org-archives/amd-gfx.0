Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1902CCA47B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96FE113FBB;
	Fri, 10 Jun 2022 20:53:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1DB113FB9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWNrZhTjeoEl9s9kfss4iuy//C3ylSMq4NX80l5XroNfKFCkrJDNWFr1TnqW5+mggz+sWq+N4uFLGT7l2Hn+mrjjYpVysQCwwlzGGtn9EJGSuEq9AMGJuhHiEBh/L4Ke41rOQ9CdDURd/oLN80qmYgVNZOHHyjCXvOqkTcI/HgD1+HNbxkXWn1tYkSbuqLim6wvLhjUElLLQVPTgHdpy9C4GmDnMP9iolKwdZcV5cE+cdSHM34MaVmAOHpWGtFnq50CswocM2zF+QbnnNp9Ec6ghqtHPdY5U5VeM5T79mELdBsFOQK56xm4WClniL9npgrpoiPLDs0E43gEJUmpkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbnThCwAUIZgjDnKfxkBXa4ThHBbgIkcqEGfXhapzQ8=;
 b=QcsiVsPoywFR5ECpIazJYZpKxmn0wBBNZoefUwdNITKKgfbKyfmnJgatC9twNROv8E1vgwCS9GBiV2YnjI27n6rhAJFd1BgEGKrdiyBvnPxxRp0nWbfEGFJgzwSEjGGSnEtvSPxJuVMJV6tDDJtZTGMqgPfLsuRLOfZx/A6bIxdraLhcC8BdEYolol2zEGmVHm4i8uOAj32VHnaXBdZvuJNnaW5pECwzWWQ8jPIMUbgz6yVi4yxHYBIPhYTyXK6ARmg/sMAhQHaZcVA7ZEPQDe8vsswctgbwtcOXJgiglh+mb7JZTb7/Rh8gi5A1dZAhrWZvPc+SjifV0J+82mjHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbnThCwAUIZgjDnKfxkBXa4ThHBbgIkcqEGfXhapzQ8=;
 b=hbWc+3OStSnuzYi4DmjP6uTD0rxZL1ER3z+VvZZUUo93Sbhxrrez35yau0/8rLWKg6htjhBylX2rWCsjfYV3sKMWEQhl4LdBlMx4GVk9TeP6eS5u1bISIwoMDWC6XdhSKuvBlwe/MW8O0nSvMV5E7Q/3QKNTQMLGXpk/NOwKxTk=
Received: from MW4PR04CA0314.namprd04.prod.outlook.com (2603:10b6:303:82::19)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 20:52:59 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::d3) by MW4PR04CA0314.outlook.office365.com
 (2603:10b6:303:82::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14 via Frontend
 Transport; Fri, 10 Jun 2022 20:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:52:58 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:52:56 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/23] DC Patches June 06, 2022
Date: Fri, 10 Jun 2022 16:52:22 -0400
Message-ID: <20220610205245.174802-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9d46020-7866-4e6d-6254-08da4b233366
X-MS-TrafficTypeDiagnostic: MN2PR12MB4831:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB483126FDD6F7E6407F48854DF4A69@MN2PR12MB4831.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /h5nnL6EDJTI1LVtdyIWhmE+v4WwUsV9fRwjei256VdgxjArQyKvyMWkUP1SPE3LH25o1Zz81ZLioOWf3aEnlZSf7b30fV6Qob1fxrz57QKgQRx2k4PT6oD+9bkhQ5pLpqDrppIaEjUIsn8eNhjVXXQrxdMYxQKW8NV9q+QLMJAXxWaIAVXGedBCqo4d4c37zY5BPvanUpXUJp+T57Yj8S0dz6kBY94C5PD+5G/ChywR6qZGpCrlMIX2n+EDDypBxqUliGyXj4YuK4K+3cOEPFgndlu2/grsuLmvxWCOVl9OeEoc725oKYEss83UusIhTwc5J8K+KF/7bQPImuzlM1EwpU9gVA2joyMsZC2YFyLbCMysczq1zenAFdZiyoFjlDDRswtk3dkTBCw7WiYhxuLuk+GnU22qKMF2LgafxDhkSk32ei874BEiOGl65tvrJDt/2MXl3Fsmkc6JwPBtMAGQksJfmoIzQnwWf4X7dBsxVjNUwiR/auloC9xWXpWCERoiLLNCPJWFdcqS7EQidLGA9Lqt0mmQP/GPu0ld+5HEFmzqHhCJ/pImorGnxWmE2l+kGbypz+XW3MK8ReCDV/lTMO6K8A6aFPT731n7CBuvXn5yJ2UeMW2/bUtA9qz03l2ZYvpStYEGnaOD42kxkf64fNN9LLebqkbDz7UIWfh+Qy4OzV/TpU0dszYQzD3jxV5vclKUThXVNDwCk9qeYUcg5vt3O7/FWkVuoXMZcncJLSx7aCcUJViLTSvAOS1x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(6916009)(36860700001)(82310400005)(1076003)(4326008)(8676002)(316002)(2616005)(36756003)(54906003)(70206006)(26005)(47076005)(70586007)(186003)(16526019)(40460700003)(336012)(426003)(6666004)(7696005)(86362001)(356005)(44832011)(508600001)(83380400001)(81166007)(2906002)(8936002)(5660300002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:52:58.1820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d46020-7866-4e6d-6254-08da4b233366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
have:

* DP fixes
* Reduced frame size in the bouding boxes of a number of ASICs.
* Exiting idle optimizations
* General cleanup
* Power management optimizations
* HF-VSIF support
* VTEM support
* FVA timing improvements

Ahmad Othman (2):
  drm/amd/display: Add support for HF-VSIF
  drm/amd/display: Adding VTEM to dc

Aric Cyr (1):
  drm/amd/display: 3.2.190

Charlene Liu (1):
  drm/amd/display: FVA timing adjustment

Felipe (2):
  drm/amd/display: Firmware assisted MCLK switch and FS
  drm/amd/display: Pass vrr mode to dcn

Hamza Mahfooz (1):
  drm/amd/display: fix build when CONFIG_DRM_AMD_DC_DCN is not defined

Harry VanZyllDeJong (1):
  drm/amd/display: Disables dynamic memory clock switching in games

Ian Chen (1):
  drm/amd/display: DAL ACR, dc part, fix missing dcn30

Joshua Aberback (1):
  drm/amd/display: Blank for uclk OC in dm instead of dc

Lee, Alvin (1):
  drm/amd/display: Add debug option for exiting idle optimizations on
    cursor updates

Martin Leung (1):
  drm/amd/display: Add null check to dc_submit_i2c_oem

Nicholas Kazlauskas (1):
  drm/amd/display: Copy hfvsif_infopacket when stream update

Oliver Logush (1):
  drm/amd/display: Drop unused privacy_mask setters and getters

Qingqing Zhuo (1):
  drm/amd/display: update topology_update_input_v3 struct

Rodrigo Siqueira (4):
  drm/amd/display: Reduce frame size in the bouding box for DCN20
  drm/amd/display: Reduce frame size in the bouding box for DCN301
  drm/amd/display: Reduce frame size in the bouding box for DCN31/316
  drm/amd/display: Reduce frame size in the bouding box for DCN21

Samson Tam (1):
  drm/amd/display: Fix comments

Shah, Dharati (1):
  drm/amd/display: Fix monitor flash issue

Wenjing Liu (1):
  drm/amd/display: lower lane count first when CR done partially fails
    in EQ

hersen wu (1):
  drm/amd/display: dsc validate fail not pass to atomic check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  2 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 43 ++++++++----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 23 ++++---
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  | 11 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 66 +++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  8 ++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 13 ++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 27 +++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           | 13 ++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  5 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  9 ++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  1 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  1 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  8 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  1 -
 .../display/dc/dcn20/dcn20_stream_encoder.c   |  1 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 28 +++++---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    | 11 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 67 +++++++++----------
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 30 ++++-----
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 64 ++++++++----------
 .../dc/gpio/dcn20/hw_translate_dcn20.c        | 17 +++--
 .../dc/gpio/dcn21/hw_translate_dcn21.c        | 17 +++--
 .../dc/gpio/dcn30/hw_translate_dcn30.c        | 19 +++---
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |  6 --
 .../amd/display/dc/inc/hw/stream_encoder.h    |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  1 +
 .../amd/display/include/link_service_types.h  |  2 +
 .../amd/display/modules/freesync/freesync.c   |  5 ++
 .../display/modules/hdcp/hdcp2_transition.c   |  2 +-
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  4 ++
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   | 11 +++
 .../amd/display/modules/inc/mod_freesync.h    |  3 +
 41 files changed, 326 insertions(+), 214 deletions(-)

-- 
2.36.1

