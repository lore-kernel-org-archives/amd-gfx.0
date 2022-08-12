Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1711BC00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9DF97DBF;
	Sat, 13 Aug 2022 02:12:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE12A9445
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9ynC/YLSl+SdjM0nsMDgaCmfrIuW3XInr6JzLvBL1yJUfu/hlFR2hEUpJ3DoocHtegT88tnrow5p0SlRKkSP90XJhimsPyPR+AXELut5dHCX4AI6lyYVx4+qg4AVm1Y7vPJS7Yzo4s+L9QqVMkeAdiRUQlXCHGELaMwZd4EnMHSvYYDGR3ktYRI+v2ZT/+lzXFMSKWMcwubL3O4eI10FveFyeHK9BdJS6XZtJDfUnW4E3lqP/Urvf4YQD/+DlQP2fTpWBA7qnRiTadKT/GIisDCSwAUBnHepEp8CeozmmPJ3Zq7zXXwohXVTC3vzp5w3rgnkIMLT+zl+pd4ji8jZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBS5FVe26AmX7TswvqGD62iVkjj1R9wV5FwVA8q/IVY=;
 b=BecEH4LQUNBtcV66VeRolUy7TRxkpUbsMGfTMUoWc9+zc95Cldct6sxKwDBl4jW9EwvZqsH+mbF2Azp++6kfMbbOybmBt/gpszHNNl4LEJrZA3uw+p1FM15x0LLuj4KKPa4QyjHvcskxxfbA7g7Qs939Zf5Co28YPJZYdll5PFPWEA56dh8gbq/1sQuC6fhyxuOH8jeobMYGWSgivb+cW7Yk6LY+hlrK38R/TKBp34EGePv1erQOwsSt8gpgmC5wmklRgudg1pl9Y3bPe/FguMP+5NdUErMLVzUVeC7NQscxzpCEKo2C5McVcU7q3wj4KXoD7LT2TJtm3rC9IRt2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBS5FVe26AmX7TswvqGD62iVkjj1R9wV5FwVA8q/IVY=;
 b=MmNIqmvYQ5bhzMRWS5IbpqtWLi88Gz1R5gXL/KHV6pTXOkW3AkYlxiyjxhWSJ+dZSUBjVeJwg0+PvNZatKeKU6YNePU3UCt7y4xG1LIJZsQZOcy+nI7iwqsqCuQPM1UioDfbAQsBTldAyFj74lSAPuoqQN/TB5YYSfF9jHKHULo=
Received: from DM6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:5:190::24)
 by DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 13 Aug
 2022 02:12:19 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::c1) by DM6PR11CA0011.outlook.office365.com
 (2603:10b6:5:190::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Sat, 13 Aug 2022 02:12:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:11:49 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:11:46
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches August 12, 2022
Date: Sat, 13 Aug 2022 06:12:08 +0800
Message-ID: <20220812221222.1700948-1-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c7a056-6f2f-4185-2d04-08da7cd1404c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1385:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zyw5B9bhEuqDhT92dt1W4ef8mpO0f3ri+dbdQdvCMUjF66XbMHeAykQN01JTqTCgwYmJxgAeLDD8D3LMzOYn/8z7lWw0srujjsdUigcUUz+IRJCa29EGHNszccAw5nAKZWMzRpBdKr461fLMNw5Go1SbQsBMeDWaLf4ARziBK5LZ7gH0SJoo9vANG3qHMvLwRvBZ43pigP6cr0ghh3CtzZDi3gjMhkjqlLS89sw7WqSZTn2eSRBakRKzZr7Qu5BaWjOCefvuwuVrdnR5uNE1NR56lq7XygYWeADSro9wkcqtEU6K3ZMOkWpC1efMts0lsWQD6adoeVB/4f0wsf3qDkr66ts670meA6Gp0qMetDlWzutoq97xK1lb41jqsO9sRtEDbsXNLygujA0w+syEQjA6nJuV3zorPAbdhte3NpMnNQslb7Bijlg7mmfLIEbBC1zcrKgA9TmhlG2ZmbhcguGtpYtPFGG8OyY0xNxpnhVEZXVCJ9J1rH+xGF7jgmYEklG2cj+J0CqcPnJrpOpZVtAhQ/qJikd4CK5xr3Cwt5r4OtuQmbFntsywyQaPsA8rIy7VkIgiweN4CZQTftM0kODvsNmzgnDns7bPS1GUE8vlVGGrNGGk0rbQwbSIxwBJQbnt2I85YEaGVA6dXKQ0R4AJngTS0jHFcmmWmZ+csaGvPa1ZrP3MfJsDAbPqpOpMKJozmqgeJLH0Kx82wexWYHadcKL60U2d/aOJdRvLzNigSaQimXFkcFglLI4kzEGsIHxqZrUiD76ewAwnztJSZVY60NC9gV2kxbsQnZc4pUGVecMioncMELEpKIPAxlUOOZ/TYI2CiS9QM40VpxkG3BybecP/hzXXUXX6OdNSxqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(40470700004)(46966006)(82740400003)(8936002)(36860700001)(5660300002)(82310400005)(2906002)(81166007)(6916009)(6666004)(356005)(7696005)(41300700001)(54906003)(26005)(316002)(478600001)(8676002)(1076003)(70586007)(4326008)(83380400001)(40460700003)(70206006)(2616005)(47076005)(186003)(40480700001)(426003)(336012)(86362001)(36756003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:12:19.3995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c7a056-6f2f-4185-2d04-08da7cd1404c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
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
Cc: stylon.wang@amd.com, brichang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fix ARGB16161616 pixel format;
* Fix pixel clock in 10/12-bpc;
* Add reserved dc_log_type;
* Fix some variables widths in dc;
* Add chip version GC_11_0_3_A0 to DCN32 family;
* Fix light up bug with dcn314 with 8K@30; 
* Fix monitor hang while playback MPO video;
* Include scaling factor for SubVP command;
* Improve header inclusion pattern;
* Update clock table policy for DCN314;
* Modify DSC bit for phantom pipes;
* Use pitch when calculating size to cache in MALL;
* Avoid doing vm_init multiple time;

Alvin Lee (3):
  drm/amd/display: Include scaling factor for SubVP command
  drm/amd/display: Don't set DSC for phantom pipes
  drm/amd/display: Use pitch when calculating size to cache in MALL

Aric Cyr (1):
  drm/amd/display: 3.2.198

Chaitanya Dhere (1):
  drm/amd/display: Modify header inclusion pattern

Charlene Liu (1):
  drm/amd/display: avoid doing vm_init multiple time

Daniel Miess (1):
  drm/amd/display: Add debug parameter to retain default clock table

Ethan Wellenreiter (1):
  drm/amd/display: reverted limiting vscsdp_for_colorimetry and
    ARGB16161616 pixel format addition

Ian Chen (1):
  Add reserved dc_log_type.

Ilya Bakoulin (1):
  drm/amd/display: Fix pixel clock programming

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Nicholas Kazlauskas (1):
  drm/amd/display: Update clock table policy for DCN314

Samson Tam (1):
  drm/amd/display: add chip revision to DCN32

Tom Chung (1):
  drm/amd/display: Fix plug/unplug external monitor will hang while
    playback MPO video

 .../drm/amd/display/dc/basics/conversion.c    |  21 ++
 .../drm/amd/display/dc/basics/conversion.h    |   3 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 188 ++++++++++++------
 .../display/dc/clk_mgr/dcn314/dcn314_smu.h    |  33 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  11 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |   2 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   3 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |   2 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   3 -
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |   8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |   2 -
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   3 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   2 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   2 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   1 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |   4 +-
 .../drm/amd/display/include/logger_types.h    |   4 +-
 23 files changed, 225 insertions(+), 90 deletions(-)

-- 
2.25.1

