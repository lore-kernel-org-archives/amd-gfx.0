Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D19AC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD96B10E51D;
	Wed, 10 May 2023 20:49:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFCAF10E51D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7fk4B5dOFFNRrOdmnSj6N2Rp3L9c21qEFFBztkjrOH6wr2dBZE5jUW+NBAvpRVTcCTsabUk3EKSPj+Sew/iMj2r3YYt6OogQaB0Ukc0w0dUMQ3A7bJnW2jYHW0R9D9qKgloluQTKe40oPwPm39baty9qIOlbxtwXLc1nabZ9nI91Bqqe3gf0x1hjDCt2yA3WCCAigRXo1P4Aof+sLiciYKOzuaJXAmTtxwherAODHn55z+KWDX52lvYiogugIV1UameTBFUantqkXHXLFWo6fS23tf2VlTb8+sf+hiIOaxcLFTizE6IlpZcZVWDNxM887KA8jBZxwYdM9fEamF46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vhxl31P5MLouE0ZkBCkP2xnX+F3Ec0Oupl/3x5P0ozc=;
 b=IcLsCptF7E1T3Ymq7Y2tESsMnXhkZq9GAOcSAOafCJZzUlkoL4k+YiJhZbD0mvLKPKkMpGPm22yrtv8O+PXrd5t6RBZIt7vQAdZIkegw8dwP2C32U/tAO/2nQyrT2Mb1xy4IEFq0dIZgdoRATA1kBrnMSE8c7OgGzFOOwQIum4670vT/wpNiWtM+1KP9GS/1uSRpENcE4pf8ictopOmrm435qhC8kkgb9irTwtGrxltYFQ+uR7NnbrYaO7E85EMdlnecO+v8++Xw89ju6GQguamZexuwgJUte+QS1HQh0sk72zZ7dDqNI1/Sm3BxO3Tlt2bS9EHoBSvSnGlWD6HPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhxl31P5MLouE0ZkBCkP2xnX+F3Ec0Oupl/3x5P0ozc=;
 b=n079dm/vjlHtTWvZw9ZgxmJLf04Z4lw6PyKTy5exiA7vac44f3woTuZ0XTewVblQQ8HAXW8+KmJ78cB0KOLC9vbV7PVLF6CfgBEOJ6QbM5E1PAWg69ym0QLAB5wAV36pRFRUCg5M4MTEymI4Rb2VX5183Hy9UV9bUdLz0dRWHYY=
Received: from BN9PR03CA0779.namprd03.prod.outlook.com (2603:10b6:408:13a::34)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 20:49:02 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::34) by BN9PR03CA0779.outlook.office365.com
 (2603:10b6:408:13a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 20:49:02 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 13:49:02 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:00 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/10] DC Patches for 15 May 2023
Date: Wed, 10 May 2023 16:48:50 -0400
Message-ID: <20230510204900.949963-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9de4fa-d179-4e12-b44e-08db5197fce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxaBVgadag54ZG0D4XWSnK58ihEV0S7b1jQSW7IDIVuV5vVfSniRtys4BRrdXLbNZ8PxcHPx06AuV3D2kghQwHtYvGxwzWDKzz8JayHa7R1ODEtrh/Yu7+NysTYNEDR2FbnfNZU8UAnGpImgGNTs1abNHV1XttOSWO4CsmnUSmg/CpybpRSv7fJ9TekmGD5vEDXcP+n7FB2rNe9gnpQuFffm3wq1LB8IasqRWv71ezev6507UxuGlAhsyOjq4OpLYe9dr4iwkbaqH5+/G0+lWoOByY+0jkwOD//A8sGRQzHzqB9ypAUEOy4nPusZNmmOCFDzN8OUExjO8orphCAYVKf3YfAcxsaMVUyEMg7WimbeuBuP45arOFBbCC2HLFKcS80ny3WZKL534adV5MnAkySDct/2B7sRagusY8wA1DXjBlPWP9cR5uPfsJniS1sIMhKnVQ2C+Ev91nRqIxkALu8VlJvWpybHvovHVW/aXTkGkPKZpJKfdj4rwFDRvtFQf+azeh/TvHr0dZuTt0JM6yC9oFTigM2TjJSf03d5cog/zK/LW1W/fPQ/eqCN0hrUi6AcvxHoQ08rqZPbmK1Bxvtauau2V7BYIKhAXXteT7+WhqN7wZJ8OxZLrpLbb004taVfuumJ7+5JU/4udXivom8Fy6aGuSLIV7M2qeo/YMBsPe3bDqa5VQPjdDwnVPaE1F++06sYeaNRQg+tl/Oj/U2S9VR3l7glqrzKJMxI2XA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(26005)(86362001)(1076003)(40460700003)(186003)(478600001)(54906003)(82310400005)(7696005)(6666004)(5660300002)(36756003)(8936002)(8676002)(356005)(81166007)(44832011)(4326008)(316002)(70586007)(2906002)(6916009)(41300700001)(82740400003)(70206006)(2616005)(83380400001)(36860700001)(336012)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:02.7412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9de4fa-d179-4e12-b44e-08db5197fce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* DC v3.2.236
* Fixes related to DCN clock sequencing
* Changes to FPO acceptance heuristics for various modelines
* Dmesg log readability, visual debug improments and various bug fixes.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (3):
  drm/amd/display: Only skip update for DCFCLK, UCLK, FCLK on overclock
  drm/amd/display: Update vactive margin and max vblank for fpo +
    vactive
  drm/amd/display: Make unbounded req update separate from dlg/ttu

Aric Cyr (1):
  drm/amd/display: 3.2.236

Daniel Miess (2):
  drm/amd/display: Fix possible underflow for displays with large vblank
  drm/amd/display: Remove v_startup workaround for dcn3+

Leo (Hanghong) Ma (1):
  drm/amd/display: Add visual confirm color support for MCLK switch

Mustapha Ghaddar (1):
  drm/amd/display: enable dpia validate

Rodrigo Siqueira (2):
  drm/amd/display: Convert connector signal id to string
  drm/amd/display: Remove unnecessary variable

 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 24 +++++----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 51 ++++++++++++++++---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 50 ++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 ++++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 22 +++-----
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 37 ++++----------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  5 --
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  2 +-
 .../drm/amd/display/dc/dcn201/dcn201_hwseq.c  |  4 +-
 .../drm/amd/display/dc/dcn201/dcn201_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  2 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  1 -
 .../display/dc/dcn32/dcn32_resource_helpers.c |  2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |  2 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 24 +++++++--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 19 +++----
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 10 +++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 ++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  9 +++-
 .../drm/amd/display/dc/link/link_factory.c    |  6 +--
 .../drm/amd/display/dc/link/link_validation.c |  3 ++
 .../drm/amd/display/include/signal_types.h    | 28 ++++++++++
 29 files changed, 224 insertions(+), 107 deletions(-)

-- 
2.40.0

