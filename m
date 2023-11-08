Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED51BC4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B7710E82A;
	Wed,  8 Nov 2023 19:01:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2733110E81E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/UFh7Ct8uU7inmbsGQClcbJG0/SF5Z6W5x76yYIupTxO7zZCg9Pn//Ofg2kDzrX1V9mhBftixqffRWFM7E/YMa1GKswXEf7vXVCteqEZdLZdGqugPoQUS32LxU+O5IAK1Dy9bUY7crgQuvbpKlqzlP1zvHY2Qaw5rX2ONGCQAgDcFVyvd86o2M4E96MXL+3NknrJzqT/Kw2Jc7CpV9kxK4+JFLE471/p0nyW7xreTtW/+JXAiIVf5d9ObEnh3rYTNsm/1k+30LsEXMA67bpVjOmVB9RFbAg8nncoLonbyZOUVrs2KQy8k6lY1Rap5oaE2Xc7TfcgwIwWtIyPftwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRsmzGM62phutc5ObMfCEFA8OTRyLrfRKkWMLsaU10Q=;
 b=m8MTaGJpuTtROSbbeJFO0jvOSflLvEmy/GvXwD97nn9jb913N6ilPgEBfdnhyXuIVYFRxlOk6llKdOj7fdpBIsqajIINn2Ci/gTqurKs2PsCEVR2SyKnnonR4sQ0N1VwH5MIGgk+deh3JbclgZZhhxAx7LKHCodabk7N7xoTwWBimB1MMKQwPUR1BQg1Xrj9i6idUM3uM2ppRoi5a6ePhQhK590yfrM+mvQrsbTxUuWBgxc3op648yYKpNiwUOZe6LOaTPig3KwM0nyw4TDP75Wc+zALwmjotYO4Iw1q5H3hWUuxcAlU9wub/5j8sicuvPVp4yvivnzjI1RSGJKZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRsmzGM62phutc5ObMfCEFA8OTRyLrfRKkWMLsaU10Q=;
 b=xt/zFNfKR7f32izMPTGRK9UySIoIm5MQu5edvs52wIzHkVKl6Ag5j9ApL5h4i6VXWXi7Pm2bQrc/818+4JwIHPn1LkcqtPyRAA2e2jdVV1qflWrKGCN1JaFu7p7nvML2PtslQ3BO7K3dwUMAVoXF+RGqGuB+RelCgbOLYvYlMas=
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 19:00:57 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::d3) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:00:56 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:00:53 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/20] DC Patches Nov 08, 2023
Date: Wed, 8 Nov 2023 11:44:15 -0700
Message-ID: <20231108185501.45359-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: c962e6d5-17ac-4861-1022-08dbe08d0a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knZqsxiZuwFRvEtFQ6L80oVemMRlL3UNunufW6sNaGxRUV8O5RLIiDibN2RxHlQI86xrpJv2NRAXMQmCFDBM0sRRDV6DCG2m48JAS8Hipq2IQDu+gVMSVpM0Pr0J97Iwauhc7mWlHsvh8qDDBuJhCry1xzPiIW7Z0vCOZVv3ivCrMGqgAeZktGaNyZKB7tw6qtK7l1+67Xic909SK2QH4Ga4tP2Haxutw56F+eP3uWOlPG4VfrcYD3tN8oL2lO7sZKZvSBOVOeX9ndKf05E19J5R01t7v/vc2cWyTPr7aI3r4pX+XaxKPNUuJcxPLhEz2oUB6A4jnO2+JorDTyrda7p8h/yQCAPqYOY+cdJGuQZZZk//d6jvpnhO2c1QFfUOXMsR1opKiHUKLx7MoNStbxuQj7ln9/kEU2ciLCoz5vWp4hNi36HxTkbLrlRAsFw3SiO1fdljWAAT3oRwkjB1IouAumYlghAoV6yhI03k9KdIle3B0JOUDYh3p18b7e5tivcOEKowiQEPWijXPUDp0UaAqmKFfgmGobNjq/99MY8e3TcfcpRCyrmGTX09T2AHpHYXu8T4uTu93Fy04YDWq4xDrjrkX/1uR9F2bw5tRbwzVncE1MPqn/qi+92V9jS26WC5ss1lwl5H/bJGFUCCW8aabOuXWpIDXlDenN58/mDPhpk4UFk4vWHe419y5NoJ8PToT1veSP3eNuqWJ/66e23BKwNvDg9wDxcv+L5ckcN6JrbUDEAHUsImnUEAb3renOFA5qotToONrz74BEXmaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(70586007)(26005)(16526019)(478600001)(36860700001)(6666004)(2616005)(19627235002)(1076003)(70206006)(6916009)(316002)(54906003)(426003)(336012)(83380400001)(47076005)(7696005)(8936002)(4326008)(82740400003)(356005)(81166007)(41300700001)(5660300002)(44832011)(30864003)(40480700001)(2906002)(86362001)(8676002)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:00:56.9594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c962e6d5-17ac-4861-1022-08dbe08d0a3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alex
 Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Add missing chips for HDCP
* Add new command to disable replay timing resync
* Fix encoder disable logic
* Enable DSC Flag in MST Mode Validation
* Change the DMCUB mailbox memory location from FB to inbox
* Add disable timeout option
* Negate IPS allow and commit bits
* Enable DCN clock gating for DCN35
* Prefer currently used OTG master when acquiring free pipe
* Try to acquire a free OTG master not used in cur ctx first
* Clear dpcd_sink_ext_caps if not set
* Enable fast plane updates on DCN3.2 and above
* Add null checks for 8K60 lightup
* Refactor resource into component directory
* Fix DSC not Enabled on Direct MST Sink
* Guard against invalid RPTR/WPTR being set
* Enable CM low mem power optimization
* Fix a debugfs null pointer error

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Anthony Koo (1):
  drm/amd/display: Add new command to disable replay timing resync

Aric Cyr (1):
  drm/amd/display: Promote DC to 3.2.260

Aurabindo Pillai (1):
  drm/amd/display: Fix a debugfs null pointer error

Daniel Miess (1):
  drm/amd/display: Enable DCN clock gating for DCN35

Duncan Ma (2):
  drm/amd/display: Negate IPS allow and commit bits
  drm/amd/display: Add disable timeout option

Fangzhi Zuo (2):
  drm/amd/display: Fix DSC not Enabled on Direct MST Sink
  drm/amd/display: Enable DSC Flag in MST Mode Validation

Krunoslav Kovac (1):
  drm/amd/display: Send PQ bit in AMD VSIF

Lewis Huang (1):
  drm/amd/display: Change the DMCUB mailbox memory location from FB to
    inbox

Mounika Adhuri (1):
  drm/amd/display: Refactor resource into component directory

Muhammad Ahmed (1):
  drm/amd/display: Add null checks for 8K60 lightup

Nicholas Kazlauskas (1):
  drm/amd/display: Guard against invalid RPTR/WPTR being set

Nicholas Susanto (1):
  drm/amd/display: Fix encoder disable logic

Paul Hsieh (1):
  drm/amd/display: Clear dpcd_sink_ext_caps if not set

Rodrigo Siqueira (1):
  drm/amd/display: Add missing chips for HDCP

Tianci Yin (1):
  drm/amd/display: Enable fast plane updates on DCN3.2 and above

Wenjing Liu (2):
  drm/amd/display: Try to acquire a free OTG master not used in cur ctx
    first
  drm/amd/display: Prefer currently used OTG master when acquiring free
    pipe

Yihan Zhu (1):
  drm/amd/display: Enable CM low mem power optimization

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  21 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  63 +++---
 drivers/gpu/drm/amd/display/dc/Makefile       |   5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  18 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  50 ++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  39 +++-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../gpu/drm/amd/display/dc/dce100/Makefile    |  46 ----
 .../gpu/drm/amd/display/dc/dce110/Makefile    |   4 +-
 .../gpu/drm/amd/display/dc/dce112/Makefile    |   3 +-
 .../gpu/drm/amd/display/dc/dce120/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   6 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   1 -
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn315/Makefile    |  30 ---
 .../gpu/drm/amd/display/dc/dcn316/Makefile    |  30 ---
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |  13 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  30 +++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h |   7 +-
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |  10 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  10 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |   1 -
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |  15 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  42 ++--
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  12 ++
 .../drm/amd/display/dc/link/link_detection.c  |   3 +
 .../gpu/drm/amd/display/dc/resource/Makefile  | 199 ++++++++++++++++++
 .../{ => resource}/dce100/dce100_resource.c   |   0
 .../{ => resource}/dce100/dce100_resource.h   |   0
 .../{ => resource}/dce110/dce110_resource.c   |   0
 .../{ => resource}/dce110/dce110_resource.h   |   0
 .../{ => resource}/dce112/dce112_resource.c   |   0
 .../{ => resource}/dce112/dce112_resource.h   |   0
 .../{ => resource}/dce120/dce120_resource.c   |   2 +-
 .../{ => resource}/dce120/dce120_resource.h   |   0
 .../display/dc/resource/dce80/CMakeLists.txt  |   4 +
 .../dc/{ => resource}/dce80/dce80_resource.c  |   0
 .../dc/{ => resource}/dce80/dce80_resource.h  |   0
 .../dc/{ => resource}/dcn10/dcn10_resource.c  |  25 ++-
 .../dc/{ => resource}/dcn10/dcn10_resource.h  |   0
 .../dc/{ => resource}/dcn20/dcn20_resource.c  |  24 +--
 .../dc/{ => resource}/dcn20/dcn20_resource.h  |   0
 .../{ => resource}/dcn201/dcn201_resource.c   |  14 +-
 .../{ => resource}/dcn201/dcn201_resource.h   |   0
 .../dc/{ => resource}/dcn21/dcn21_resource.c  |   6 +-
 .../dc/{ => resource}/dcn21/dcn21_resource.h  |   0
 .../dc/{ => resource}/dcn30/dcn30_resource.c  |   2 +-
 .../dc/{ => resource}/dcn30/dcn30_resource.h  |   0
 .../{ => resource}/dcn301/dcn301_resource.c   |   4 +-
 .../{ => resource}/dcn301/dcn301_resource.h   |   0
 .../{ => resource}/dcn302/dcn302_resource.c   |   4 +-
 .../{ => resource}/dcn302/dcn302_resource.h   |   0
 .../{ => resource}/dcn303/dcn303_resource.c   |   4 +-
 .../{ => resource}/dcn303/dcn303_resource.h   |   0
 .../dc/{ => resource}/dcn31/dcn31_resource.c  |   2 +-
 .../dc/{ => resource}/dcn31/dcn31_resource.h  |   0
 .../{ => resource}/dcn314/dcn314_resource.c   |   0
 .../{ => resource}/dcn314/dcn314_resource.h   |   0
 .../{ => resource}/dcn315/dcn315_resource.c   |   0
 .../{ => resource}/dcn315/dcn315_resource.h   |   0
 .../{ => resource}/dcn316/dcn316_resource.c   |   0
 .../{ => resource}/dcn316/dcn316_resource.h   |   0
 .../dc/{ => resource}/dcn32/dcn32_resource.c  |   4 +-
 .../dc/{ => resource}/dcn32/dcn32_resource.h  |   0
 .../{ => resource}/dcn321/dcn321_resource.c   |   2 +-
 .../{ => resource}/dcn321/dcn321_resource.h   |   0
 .../dc/{ => resource}/dcn35/dcn35_resource.c  |  20 +-
 .../dc/{ => resource}/dcn35/dcn35_resource.h  |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  22 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  41 ++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  50 ++++-
 .../drm/amd/display/include/hdcp_msg_types.h  |   5 +
 .../amd/display/modules/freesync/freesync.c   |   6 +-
 .../include/asic_reg/dcn/dcn_3_5_0_sh_mask.h  |   8 +
 94 files changed, 655 insertions(+), 308 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dce100/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn315/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn316/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce100/dce100_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce100/dce100_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce110/dce110_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce110/dce110_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce112/dce112_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce112/dce112_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce120/dce120_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce120/dce120_resource.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dce80/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce80/dce80_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dce80/dce80_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn10/dcn10_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn10/dcn10_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn20/dcn20_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn20/dcn20_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn201/dcn201_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn201/dcn201_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn21/dcn21_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn21/dcn21_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn30/dcn30_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn30/dcn30_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn301/dcn301_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn301/dcn301_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn302/dcn302_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn302/dcn302_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn303/dcn303_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn303/dcn303_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn31/dcn31_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn31/dcn31_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn314/dcn314_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn314/dcn314_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn315/dcn315_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn315/dcn315_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn316/dcn316_resource.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn316/dcn316_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn32/dcn32_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn32/dcn32_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn321/dcn321_resource.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn321/dcn321_resource.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn35/dcn35_resource.c (98%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn35/dcn35_resource.h (99%)

-- 
2.42.0

