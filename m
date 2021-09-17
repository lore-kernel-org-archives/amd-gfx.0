Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D0CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 17:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D7661212
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 17:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8D7661212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E876E02F;
	Fri, 17 Sep 2021 17:47:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F70A6E02F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 17:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D76gfKwiQVySnFxB0ezaRuL+Ut86syput7BFNJjJkABrYN62rhy3XR1rIzYPKAmnaF5XV1O1pe8QPtKcCdsAOmls7/98kCY0N3yLopp1oXzgycWV5Er8nhgzeNTFApXqQXv/gSO+RJjNKBraGy14G4PfrYZnt8pMrjJyrhSk6nwuJeoYqd3RTxe5wUYfF+pZE8fCEbmlmHJA2jcUkVjojQATWTAt/wUFIDrquJ8hPSvcotMdj7UtcOmVTyImoxnAmrBnCHe0rDDCm1fzJvLTwI5fxeDyiwf54LoM6f89+8Csq3y+v50wJMF7hF1Phf5GoNy9naJBbJfM3xl0uY+3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=wsry4ErvT4VZp9GrO4IJKWCLxFabFL/tohDlDl+kFUw=;
 b=BVlMTMUDtv0gTWDEsadQMVbYHk5jhG9qrmzLtKuCfF+wfm9ParvUBuzwtQV3KEIUcZ6ApdwOv26iFhW40oJvTq8Fag8VEKCLXiikFs8N8ChaJc+hCrJxaU+4oQdScAIoW97OzGHl6IOotctwfxfaUTKEZrfZiyYDi0+u1HkX5/f+UckwEVp+nlgRe1uRawnqcxXYLDn9ktU5xziXCQUY3omML9xkd/HYQk2Z2/AshB6Yxc05A/3pmpMptg5BGOggg72/gb04VLvQInhdaUhDKkMi1DZav5sZfBj2ujQ3HE0EhwNm/Jpq16fkRhkyIDSyf4gZCggzxFQKZHa2+Wz65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsry4ErvT4VZp9GrO4IJKWCLxFabFL/tohDlDl+kFUw=;
 b=iBG4ZMAx3GwKWPgDdWWX205VCHTdy+t8LykOE8M2i3A9ZQ9s5GrGxIKtbNC9rEl68dZ+UVwmhNvZuVx2p8r1+f6+kjnFnGJh8lGoZjpFOaAABZwLi4rLzC5+Rr1e9D3uJtkP24Y73giLA8ZPOzgLaaxRP8RADy5WuUarlEMwDXQ=
Received: from BN0PR02CA0040.namprd02.prod.outlook.com (2603:10b6:408:e5::15)
 by DM5PR12MB1626.namprd12.prod.outlook.com (2603:10b6:4:d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.17; Fri, 17 Sep 2021 17:47:38 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::38) by BN0PR02CA0040.outlook.office365.com
 (2603:10b6:408:e5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 17:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 17:47:38 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 12:47:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Mark Broadworth <mark.broadworth@amd.com>
Subject: [PATCH 00/18] DC Patches September 17, 2021
Date: Fri, 17 Sep 2021 13:46:58 -0400
Message-ID: <20210917174716.3011466-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06e4e11b-b45d-4aae-ef90-08d97a033d4d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1626:
X-Microsoft-Antispam-PRVS: <DM5PR12MB162641E9DD810DCD79F6CC9998DD9@DM5PR12MB1626.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jIFlaAWVWIgLrBRaeXf/AWYIMSWxF1YojW9jk+UQQwqwBv8Q6TqesnmMi9gnR9POo3T3oO/jLaJettq0FH3XJkNLtswk/Mdw6dGSftVSC+put2BMxUlE31oVh64jmzbenD/5qlaq0UWG3RP24evCkhD+qYjqaWV3kmHU7yP0J182LCNK6V49Y+D1CspOK7rRLuyUOAVpbiuP8kLgUwhqaxBr3BosN97Hb37aR3cn/G6zpr64IAOTyYR1te/HDtR3ZwH+YUvxIeCqh4Lay9ZM+xUaBS7NJK5qqQ17WNCWXNpQyjwVBqN4yVI/yxAWctiu84QbJ0lm6FooG5ty5iK1DxGS7IlmRy8Yl4ludOpGHADLhbxBPD1HOmJEsQ5/nn6Pnrh0YrLL/bX6V6yVVheEFUoyB6e47WhVO2sUGriIYgObgFKtbssB4+FDPA0zK59beYV5o6FZbMSoRrjO0Bzz/AXnAV5RkNcRtG7aTJAcKWjxIZHPvCfG0NAWLF2zENBkYBVnhhfAtjoS98ngEcJ4jRxO5IsO/yjQUizO75+lbJIWgRkpyag+P0pXgCfOHcwTUJLR3hDu0zkLdY3Z4UnRgT/PWKMwrNhR4DU3upJTNnOK6bO++eva+vIxUtKAeWL0nafFdzzhFb+m+ZTvaqhPivCtxaBaOHUDkutmKFKXFjXPoKCQAcpT528zBdmjziUv/8ggtq8qcnlJINLjnAruDtSmXztgGB1nzFdgCjwor4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(426003)(86362001)(316002)(70586007)(6666004)(336012)(8676002)(82310400003)(2616005)(36756003)(186003)(5660300002)(508600001)(16526019)(54906003)(4326008)(83380400001)(1076003)(36860700001)(2906002)(8936002)(356005)(70206006)(47076005)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 17:47:38.1204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e4e11b-b45d-4aae-ef90-08d97a033d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1626
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
highlight:

- New firmware version
- Fix HPD problems on DCN2
- Fix generic encoder problems and null deferences
- Adjust DCN301 watermark
- Rework dynamic bpp for DCN3x
- Improve link training fallback logic

Best Regards
Siqueira

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Mark Broadworth <mark.broadworth@amd.com>

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.83
  drm/amd/display: [FW Promotion] Release 0.0.84

Aric Cyr (2):
  drm/amd/display: 3.2.153
  drm/amd/display: 3.2.154

Guo, Bing (1):
  drm/amd/display: Fix issue with dynamic bpp change for DCN3x

Hayden Goodfellow (1):
  drm/amd/display: Fix wrong format specifier in amdgpu_dm.c

Jimmy Kizito (4):
  drm/amd/display: Fix link training fallback logic
  drm/amd/display: Fix concurrent dynamic encoder assignment
  drm/amd/display: Fix dynamic encoder reassignment
  drm/amd/display: Fix null pointer dereference for encoders

Lai, Derek (1):
  drm/amd/display: Added power down on boot for DCN3

Liu, Zhan (3):
  drm/amd/display: Fix DCN3 B0 DP Alt Mapping
  drm/amd/display: Fix B0 USB-C DP Alt mode
  drm/amd/display: DIG mapping change is causing a blocker

Meenakshikumar Somasundaram (1):
  drm/amd/display: Creating a fw boot options bit for an upcoming
    feature

Michael Strauss (1):
  drm/amd/display: Disable mem low power for CM HW block on DCN3.1

Nikola Cornij (1):
  drm/amd/display: Use adjusted DCN301 watermarks

Qingqing Zhuo (1):
  drm/amd/display: Extend w/a for hard hang on HPD to dcn20

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  12 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  17 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  39 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 461 ++++++++++++++----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  35 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  17 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   5 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   3 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  18 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  17 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  | 198 +++++---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  |   6 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  96 +++-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  39 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |  11 +-
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  15 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   4 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  18 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   6 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |   6 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  23 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |  25 +
 .../display/dc/irq/dcn20/irq_service_dcn20.h  |   2 +
 .../dc/virtual/virtual_stream_encoder.c       |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   7 +-
 .../include/asic_reg/dpcs/dpcs_4_2_0_offset.h |  27 +
 36 files changed, 878 insertions(+), 255 deletions(-)

-- 
2.25.1

