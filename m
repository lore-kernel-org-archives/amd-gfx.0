Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF15E8FDDB
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F5110E0E9;
	Wed,  4 Oct 2023 09:23:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B24C10E0E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKZOvvX7ueKywJID8c6qNDfhlmP0HgZHYk/PUN9UYZuspa6GFfxnpn7F1G9QVsY+cIwtQers7Llqai0c3gRornaKHTH0aW40IUdsZdhtiR0U8vhqJolcVbHxD8S6lmZQtVuPwVQapMQkr4jRIOgOhNJrG0PgqxLSiJwVH/wO3yY/YX0YMeJN9rNqhmbkoZao1RPv8ioqtyEj9Ym0NIMDvkkLqA2GqOSo/jJ9h/EMYVH9FPiQ4rHCB5ZNWWDikXomcRKhmpFg3s1pvT/m+m1LI+WP74udzrg9chWe0g5TrU9p3den5NxFDGInPDdRC2HIZzAGc/LPmHt3JdUhTC9v8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/Ww6Lp8NZW9NlKtb3YzqG6vbGQZstuRK3nkmrXW7Mo=;
 b=NacQp+XbIHemMzjbqO8yYmWapEH8Szq0O/ZB/Lxh/cnvMF64yvdf9hP5hWOFLILk9SfpPCJLIAG+/ZiVm0uNUIJdsDf9lb80p+i5YvfipYpa4LIei7pL6PniFsW8kC2kK07e6C6uDoFok8rZeAe75tWc+Km2ajqU+lxi9gl9/D6Hu4ysJCM/GpNtehYIiGXEoDxDkL5W7MHfvQnaVubLQUtfR08mfabKXPnEQsS+KhCwzSE4ge1tOFmo9bPuVzgl25xf//DLnNU7c5Ogn7DYo2S7t0CToM8FQzBN/6v7BbJ690UVoaI/eL8tQWPsuHbjZWjkOpVDyl9HtkbSttMhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/Ww6Lp8NZW9NlKtb3YzqG6vbGQZstuRK3nkmrXW7Mo=;
 b=fHshp6g5RBsR23CPBEHoSEc7DLde7Swa39+m3eY0xi1iWdZECMN70ATjGoZ5l0TPZfW9I0aacr9noxwYINUud1Y+OFaPUzTsowFeFNeu5kCv2NG1AMq3M9/jq8x0HgZXC/gbTpWpdeFoxs6jb4QCLoP8srCNLxZiFABdo7n4FIA=
Received: from MN2PR22CA0006.namprd22.prod.outlook.com (2603:10b6:208:238::11)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 09:23:19 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::9e) by MN2PR22CA0006.outlook.office365.com
 (2603:10b6:208:238::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:23:19 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:23:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:23:18 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:23:12 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches Oct 06 2023
Date: Wed, 4 Oct 2023 17:22:45 +0800
Message-ID: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 656e52f0-b746-4560-ef52-08dbc4bb8c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzw8h3e9QMkxrZtQRwWk5sQp/xW4CpQJB48ryXqN6/e3x//uL7L4bi2448cTwhTauUbO/HSn4UPTE/rEcl/+XMWpZfRvbh4TPhRSeK9n7Dx3rxNEbnvDIsmdGOsCaAr6PZZNM2gXYUw4F8DduajeTQ2LocEwyEhbBaiQDOeicnOOWdGrUKtjvwKTYYba0juqYrzkHh5iPpSkpDUtehNoUhk2wDs8pFRcCsiWHyfCckbzVkW+idAavsAaj8olNy5IfLth4DIRem1+/4UG2/MnBDSrv0z3nx1QBEdizgC99eyL6Bv/gWkXOCYcBwUxaleHB9a0I7XkjDSkDgynt2q8PErMe4m4nX3B3V2gBygMT/hKx+rsfjZHiVb/2qVwCVbUUzgH5Lhc/OtjlMoQ+2/YXV8O98fkVHQ6SvowGyroNV7vgHa1ecGCATzh2Fi0woVdRoAA3PXj9A2AaDfECP6+1YOQg0kbQHllShmATKKY5Qzmvcsdfv9xd4VcB03WTba1PQ7XH1SGfjqzlOU/jILUZGlz0JFJDSKzLYo901dN2peDVWmvQmsRDpzXc6X3lB/P1pinuv/MebcEesYH8gv2s73VumwbG/rn+Bf5wJHR4/2Um6G+4NkC1IDlEntRISLoTDltglaNg6pFM/mKypVPCuToU1ef9R6PNAMJeXEOwCWBojPiHMFUnHOL78mqyXXQ79LOR+hq5O+H/Ot5Kjx8E8meBW/deGAznvT3IQyz0QfgSI8VmrYgtAguSlTh+6C6mpiuJado+CBF1jpPmE+x2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(26005)(40460700003)(40480700001)(41300700001)(70586007)(4326008)(70206006)(316002)(6916009)(54906003)(478600001)(2906002)(36756003)(86362001)(5660300002)(30864003)(8676002)(83380400001)(36860700001)(82740400003)(47076005)(81166007)(356005)(7696005)(6666004)(426003)(336012)(1076003)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:23:19.0567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 656e52f0-b746-4560-ef52-08dbc4bb8c12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

- Refactor DPG test pattern logic for ODM cases
- Refactor HWSS into component folder
- Revert "drm/amd/display: Add a check for idle power optimization"
- Revert "drm/amd/display: remove duplicated edp relink to fastboot
- Update cursor limits based on SW cursor fallback limits
- Update stream mask
- Update pmfw_driver_if new structure
- Modify SMU message logs
- Don't set dpms_off for seamless boot

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Update cursor limits based on SW cursor fallback
    limits
  drm/amd/display: Make DCN3x use older FPO sequence

Aric Cyr (2):
  drm/amd/display: Revert "drm/amd/display: remove duplicated edp relink
    to fastboot"
  drm/amd/display: 3.2.255

Charlene Liu (1):
  drm/amd/display: Update pmfw_driver_if new structure

Daniel Miess (1):
  drm/amd/display: Don't set dpms_off for seamless boot

Duncan Ma (1):
  drm/amd/display: Update stream mask

George Shen (2):
  drm/amd/display: Refactor DPG test pattern logic for ODM cases
  drm/amd/display: Disable SubVP if test pattern is enabled

Max Tseng (1):
  drm/amd/display: Modify Vmin default value

Mounika Adhuri (1):
  drm/amd/display: Refactor HWSS into component folder

Muhammad Ahmed (1):
  drm/amd/display: Update dml ssb from pmfw clock table

Muhammad Ansari (1):
  drm/amd/display: VSIF v3 set Max Refresh Rate

Nicholas Kazlauskas (1):
  drm/amd/display: Don't use fsleep for PSR exit waits

Sung Joon Kim (2):
  drm/amd/display: Modify SMU message logs
  drm/amd/display: Revert "drm/amd/display: Add a check for idle power
    optimization"

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../dc/clk_mgr/dce120/dce120_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 215 ++++++++++++------
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |  12 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |  36 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 105 +++++++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 143 ++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  34 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   3 +-
 .../gpu/drm/amd/display/dc/dce100/Makefile    |   2 +-
 .../amd/display/dc/dce100/dce100_resource.c   |   4 +-
 .../gpu/drm/amd/display/dc/dce110/Makefile    |   2 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dce112/Makefile    |   2 +-
 .../amd/display/dc/dce112/dce112_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dce120/Makefile    |   1 -
 .../amd/display/dc/dce120/dce120_resource.c   |   6 +-
 .../amd/display/dc/dce60/dce60_hw_sequencer.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile |   2 +-
 .../drm/amd/display/dc/dce80/dce80_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   4 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn201/dcn201_init.c   |   6 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   6 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   6 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   6 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn302/dcn302_init.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn303/dcn303_init.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   4 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   4 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   4 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   2 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   8 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   4 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |   1 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  15 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  15 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  24 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.h  |   2 -
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  | 183 +++++++++++++++
 .../amd/display/dc/{ => hwss}/dce/dce_hwseq.c |   0
 .../amd/display/dc/{ => hwss}/dce/dce_hwseq.h |   0
 .../dce100/dce100_hwseq.c}                    |   4 +-
 .../dce100/dce100_hwseq.h}                    |   0
 .../dce110/dce110_hwseq.c}                    |   8 +-
 .../dce110/dce110_hwseq.h}                    |   0
 .../dce112/dce112_hwseq.c}                    |   4 +-
 .../dce112/dce112_hwseq.h}                    |   0
 .../dce120/dce120_hwseq.c}                    |   4 +-
 .../dce120/dce120_hwseq.h}                    |   0
 .../dce80/dce80_hwseq.c}                      |   6 +-
 .../dce80/dce80_hwseq.h}                      |   0
 .../dcn10/dcn10_hwseq.c}                      |  16 +-
 .../dcn10/dcn10_hwseq.h}                      |   0
 .../display/dc/{ => hwss}/dcn20/dcn20_hwseq.c |  28 ++-
 .../display/dc/{ => hwss}/dcn20/dcn20_hwseq.h |   0
 .../dc/{ => hwss}/dcn201/dcn201_hwseq.c       |   2 +-
 .../dc/{ => hwss}/dcn201/dcn201_hwseq.h       |   0
 .../display/dc/{ => hwss}/dcn21/dcn21_hwseq.c |   2 +-
 .../display/dc/{ => hwss}/dcn21/dcn21_hwseq.h |   0
 .../display/dc/{ => hwss}/dcn30/dcn30_hwseq.c |  31 +--
 .../display/dc/{ => hwss}/dcn30/dcn30_hwseq.h |   0
 .../dc/{ => hwss}/dcn301/dcn301_hwseq.c       |   0
 .../dc/{ => hwss}/dcn301/dcn301_hwseq.h       |   0
 .../dc/{ => hwss}/dcn302/dcn302_hwseq.c       |   0
 .../dc/{ => hwss}/dcn302/dcn302_hwseq.h       |   0
 .../dc/{ => hwss}/dcn303/dcn303_hwseq.c       |   0
 .../dc/{ => hwss}/dcn303/dcn303_hwseq.h       |   0
 .../display/dc/{ => hwss}/dcn31/dcn31_hwseq.c |   2 +-
 .../display/dc/{ => hwss}/dcn31/dcn31_hwseq.h |   0
 .../dc/{ => hwss}/dcn314/dcn314_hwseq.c       |   2 +-
 .../dc/{ => hwss}/dcn314/dcn314_hwseq.h       |   0
 .../display/dc/{ => hwss}/dcn32/dcn32_hwseq.c |  14 +-
 .../display/dc/{ => hwss}/dcn32/dcn32_hwseq.h |   3 +
 .../display/dc/{ => hwss}/dcn35/dcn35_hwseq.c |   2 +-
 .../display/dc/{ => hwss}/dcn35/dcn35_hwseq.h |   0
 .../display/dc/{inc => hwss}/hw_sequencer.h   |   4 +-
 .../dc/{inc => hwss}/hw_sequencer_private.h   |   0
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  13 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   7 +
 .../display/dc/link/accessories/link_dp_cts.c | 117 ++--------
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 -
 .../amd/display/modules/freesync/freesync.c   |   9 +-
 110 files changed, 820 insertions(+), 409 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dce/dce_hwseq.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dce/dce_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce100/dce100_hw_sequencer.c => hwss/dce100/dce100_hwseq.c} (98%)
 rename drivers/gpu/drm/amd/display/dc/{dce100/dce100_hw_sequencer.h => hwss/dce100/dce100_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce110/dce110_hw_sequencer.c => hwss/dce110/dce110_hwseq.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/{dce110/dce110_hw_sequencer.h => hwss/dce110/dce110_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce112/dce112_hw_sequencer.c => hwss/dce112/dce112_hwseq.c} (98%)
 rename drivers/gpu/drm/amd/display/dc/{dce112/dce112_hw_sequencer.h => hwss/dce112/dce112_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce120/dce120_hw_sequencer.c => hwss/dce120/dce120_hwseq.c} (98%)
 rename drivers/gpu/drm/amd/display/dc/{dce120/dce120_hw_sequencer.h => hwss/dce120/dce120_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce80/dce80_hw_sequencer.c => hwss/dce80/dce80_hwseq.c} (94%)
 rename drivers/gpu/drm/amd/display/dc/{dce80/dce80_hw_sequencer.h => hwss/dce80/dce80_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dcn10/dcn10_hw_sequencer.c => hwss/dcn10/dcn10_hwseq.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/{dcn10/dcn10_hw_sequencer.h => hwss/dcn10/dcn10_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn20/dcn20_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn20/dcn20_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn201/dcn201_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn201/dcn201_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn21/dcn21_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn21/dcn21_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn30/dcn30_hwseq.c (96%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn30/dcn30_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn301/dcn301_hwseq.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn301/dcn301_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn302/dcn302_hwseq.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn302/dcn302_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn303/dcn303_hwseq.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn303/dcn303_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn31/dcn31_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn31/dcn31_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn314/dcn314_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn314/dcn314_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn32/dcn32_hwseq.c (98%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn32/dcn32_hwseq.h (98%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn35/dcn35_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn35/dcn35_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{inc => hwss}/hw_sequencer.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{inc => hwss}/hw_sequencer_private.h (100%)

-- 
2.25.1

