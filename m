Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E55C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37DD010E5E9;
	Wed,  6 Dec 2023 19:52:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3845510E13E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UczOnE7nDk8J9Ts2HC4msr8IQV2+5rUSS0HhlSU49MYy92DUta1DYzXm6vNQg3Ne1yX3EYMBRr2rOsr3NXWQ2r1sRFwbheoT+OGGcDGNNlJOO1oiSy6rJC/iLmo3oTSWWr1YaPHU4tGOzHl+ZiUSQM8y16m1m7VlMADBdC6D8cq6kXLfFCBVr1amxqbtvsJJ1+tupt8EPubtROHrz1J3RYKIKMUthR7W99cSLVa3hNwk31GFF35X0ud2MWv0IGUo+IO51V2lSlwVENU6f6dv1vwiGXe+VYIl1uR0GFAOfCQJv0nbReVcv8hE6HFVdbJujDPU742uHo7E90oq+TuutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2BRcpE6+C9OgrktFjHAc6llaPMNz27+EV0RxN4yiy4=;
 b=CjwiWNojH7H8//dy/yYMJ7UbJfUSwOwpxsWWnpzHVi9TZH02X8L12LzkiNXACslDi65opL6oqYH2ZvMDKTsfbsUePPDx6KrVjReM1GpqLUwWhBSumgfpRAZZbVabsdt4vdMOvtUBKSfY37hxHHi8bXKj/qJA05tWiDobHJK3qKvnjVNKm8UJYJc45pjCOg6QmIa160xAddKkNumzoRolQICoL08EgWt0ptf7DTJ1wqF9RsiFhmGag03PwL+tOKNZUYyYzLXWecb6bJeXy72Qr5LUkhdGQmGbQ1oXCIdEXe/nJy0KJOkcpBj+RuXJbONVPLYLKbnmsfYO2FWOmeA6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2BRcpE6+C9OgrktFjHAc6llaPMNz27+EV0RxN4yiy4=;
 b=iI6m19KEpmrmMZaxsRegxKkz0YWtlQabyYgxYrC80h5uG6O6VGouA9fPjjqTE/T07gmc0FaCrXyNdTqL5Yc+MQE7XXr+fDMqaA+XRnYzHddGkgD4sZ8nNyLZYAg+7JORg2ru5JvMXPsq28q3DI+O0b3RAkUYzF6+yPIQWfvXJew=
Received: from CH2PR18CA0036.namprd18.prod.outlook.com (2603:10b6:610:55::16)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 19:52:36 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::b3) by CH2PR18CA0036.outlook.office365.com
 (2603:10b6:610:55::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:35 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 11:52:35 -0800
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:34 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] DC Patches for Dec 11, 2023
Date: Wed, 6 Dec 2023 14:52:21 -0500
Message-ID: <20231206195234.182989-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: e0308165-266b-4b49-2a86-08dbf694e4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VR8CJT6OQhoB9zlX6WNbyluUqtp98dWodP6NzcIzpDfJ/08flEuS80sxNgpBcZbQI90QsEuKC1bU2k18bGNkeqdRfkbQcbFMTkK76hxKpnGoqBpbW9Frmypu2B4f+eNs7N3Wi2JB/M54ox273XKaTUjyKp6jDpjK8Hdlty6SvgXTVw1bf9B7K7eKLFaGkzLMn15YUjJggt/UrR0muLKAC9IZh2eFeL9wuaH8yaQQrK0YQDPSlW5i1gnYdAp3AqEuRLoquAaX49cUXQDKAlGCxuBtnVn4LJIOVNS+g9D+SwW7+/H6B7po5yUxV5vzITrpxKAjipqXs3FdLZWqMSxWXMnwBxMRJ8QrMFljDpEuP5TgWhHMzS9fmHhr3REa4EBtweYcEdvJE65gB2gZLbpKRmtDmW0cHZ9p9tTZ3L4ouzSkb7lIXVl5gdE8zI8KJCh+q1NuM1bJyn+GzyVype3S7tlaKbV+2y/2BrB8kqKVJYOQRgx0mueLdhOMztuOK6x0DFmiwAXvm7cg6nd9TGCSuU4Xhnv0vK3xMokPnUrmLquwrpKtXF6NKpDB2HCuuXTK7553jB/nqGjRIH3ISL+ckRxWy+Fxu4Ag/PNpQ/OBQVuqrdCEtW7KWGvyjfF087O5ztpWKI9AmSxg2CNbzdbTRXu13v3y3xnQy4f1PiPqL2spZoNXdMeWg0bUXW6C/nPZNQICH1XIHu88vzjseuxL279c8Py62ZYmp58qmdaqSl3zR3A9xPSd2eso8vuaWrCAk+SBVGpj7SELeVsdPo/EsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(36840700001)(46966006)(40470700004)(40480700001)(36860700001)(5660300002)(47076005)(44832011)(82740400003)(6666004)(7696005)(81166007)(356005)(41300700001)(4326008)(36756003)(8676002)(86362001)(8936002)(2906002)(40460700003)(316002)(426003)(26005)(83380400001)(336012)(1076003)(2616005)(478600001)(6916009)(54906003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:35.7961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0308165-266b-4b49-2a86-08dbf694e4e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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
 Daniel Wheeler <daniel.wheeler@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

Bug fixes for:
  * DCN35 power gating
  * P-state change, & prefetch logic
  * ABM
  * DP 2.1
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

===

Allen (1):
  drm/amd/display: Disable OPTC pg to match DC Hubp/dpp pg

Alvin Lee (2):
  drm/amd/display: For prefetch mode > 0, extend prefetch if possible
  drm/amd/display: Force p-state disallow if leaving no plane config

Aric Cyr (1):
  drm/amd/display: 3.2.264

Aurabindo Pillai (2):
  drm/amd/display: Use explicit size for types in DCCG's struct
    dp_dto_params
  drm/amd/display: trivial comment change

Charlene Liu (1):
  drm/amd/display: fix HW block PG sequence

Fangzhi Zuo (1):
  drm/amd/display: Populate dtbclk from bounding box

Joshua Aberback (1):
  drm/amd/display: Remove minor revision 5 until proper parser is ready

Michael Strauss (1):
  drm/amd/display: Revert DP2 MST hub triple display fix

Ran Shi (1):
  drm/amd/display: allow DP40 cables to do UHBR13.5

Sung Joon Kim (1):
  drm/amd/display: Exit from idle state before accessing HW data

Taimur Hassan (1):
  drm/amd/display: Revert "Fix conversions between bytes and KB"

 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 -
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   4 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   3 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   3 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  33 ++++-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  14 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  16 +--
 .../display/dc/dml2/dml2_translation_helper.c |   5 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   7 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  20 +++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 134 +++++++++++++-----
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   6 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +-
 .../dc/link/protocols/link_dp_capability.c    |  14 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   1 +
 19 files changed, 195 insertions(+), 82 deletions(-)

-- 
2.39.2

