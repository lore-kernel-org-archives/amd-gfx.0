Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA29EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B702D10E201;
	Thu, 14 Sep 2023 02:01:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5FB10E201
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8Buykxhc40kfh5SdJ7/QufMFQp3SeY/AwQ6iC6MdVrsyrXINmsiBhhHnc+8anAfIhWGf78AeEjS0mDP4QJk+gf8PnsZv5z1x75qrE3ok9Qz5Hpv2WwRGWlMhp1x6HxG2qdhpHZyXMW1jHbV6UbZpkL8lMzpFfMdCyWB5uike/gfR0bw3h66ykWJ7TcET2ejv2eltK2jIBvFvCV1TrmuIOs1Q54NfOaxdX6hWY4bMJ43b6u+/ZnpUrZfREIgTW6IGAoR+RpIywAsSjzevuhb/yCprMVKl557H4s2XQ2HJmDQrNSnbUqgSQ+4rhxgQHbik5LBjmJA6LUPZvopIsHyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C3HWU4ukC5N79Dd/jEmCBwijeq/WJ0pxKLYTzIXabc=;
 b=K5m/BOT1gOHwoU+NknUvQlzJFHWnfdHCSrYRIKPSZ6qdzOms38Xe51SneKw3fB3ZlLP9c/fJt9QJ5zlGdozXSsKnDgNfYqlc5h0GEwtB2OzjR/yX3IgXOYp3yOlcbzmArKGWZ3JRj06vSuA+zsREiaV/8tfuuUuG/zi6gnGVz/Z08eby3bWM2Le4u3rOqQsjkD7sY06Wvq4ih7xJ68pE7kxeBMbP6ntnLYkQUFMhi/U9NGJsMeb0mZ9f2Qc7c14BFaktwbbpfdN/UfF0hmpoJWwwFpNWaOUHnJV+WZzeY+k3RKUzDwHUdU4tvIm6+xgb3ldbsVmXSmMtIPHmRJTDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C3HWU4ukC5N79Dd/jEmCBwijeq/WJ0pxKLYTzIXabc=;
 b=ZWf50iwE0z3HlTrHr385BhIvhszTedx/cz9MFuz+qKUhLH95AHQD0L1KVwbdMUWQDrSgp0W1QcXO+DySZlv9eAe5uKUCMDDZDC2nlz3nyDD71pvsh02UOi7WxQoKwSbf5yrlsqg3e+t6Ot3Jyt97tw3r9NlIcoUvSuSgAZc559E=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 02:01:11 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::3e) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:11 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/28] DC Patches September 13, 2020
Date: Wed, 13 Sep 2023 19:59:53 -0600
Message-ID: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MW3PR12MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a150e5-ae45-4194-c807-08dbb4c677fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PahU1tZcge3Mu10U3W+ZJZguF95FhCFXlTzc8KOhDJP8cTFP1zE2HjhQRYy0ziuLo+Ncr/ii8PAxWyVtFCrHC/1tReWbGozxVEHTCAex/LGbAIhdWiw4SPRodLeWDPu59OiwAzhzBU4rdXq6o/nDoQHOCnRx91pmGhA+sMVtFd+dvvK/w8LaatkoYGgeRYeCRFgm16Vd0PEe5WGZW/Wehb8UraX8NC/L15M02PmWyplBwJILlI3bh/+1kKCqWSluV7W3BNbimokQBynhv5BTY+ZQ3JImGGzzoHB5pxz7QeEXygOWukQzuIMNjilG7tgE+8A4CNhogxF9DNAktfo8lLBGL9JNZ3eJVFEqOZ/8zHyMCHdCi/MMzBEM8KEp+XMqe3MEkOOMLArASU/D9x6zlqnL3DYOo57URhByHES3/UU+OJmeAsq7C/3Ax5odtlGapdESLj1KkMbK1XUtqIbbF6A4qcRYGh9lxMuGP3G38TlGGXUtiVSQQV5DRxrFg9LRyG5Mwef8aSUkTG55pJOssa/cDz0uvikzA0jugK3HK0KThuH0oI82yHlxF1jsx5VYyM2iBj4H7lSBK6AflbEkfKhQ1a55/n/mpySuI0Q1uuNvK2S5Sgk7CZgm0UWlkR1yavtXm9EL6ZIEPbs1VVx+mm/rsHIWx3sD4LrvNCL7q0r88ZRLLFnmSg17Dqt4/DVpycV/niC5W1p3So63rUekWRym10k3ElGAWfyMWuxhjhvxco6GllwjHWlFfGZXe4/h1ch/t8uhgjUtOQPCbO79NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(6916009)(316002)(54906003)(70206006)(70586007)(6666004)(40480700001)(478600001)(41300700001)(8936002)(8676002)(40460700003)(4326008)(1076003)(5660300002)(16526019)(26005)(36756003)(36860700001)(82740400003)(356005)(47076005)(336012)(426003)(2906002)(2616005)(86362001)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:11.1477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a150e5-ae45-4194-c807-08dbb4c677fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
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

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Use optc32 instead of optc30 in DC
- Optimize OLED T7 delay
- Multiple fixes for MST, register mas, and others
- Update driver and IPS interop
- Improve z8 watermark mask
- DCN35 updates
- Enable replay for DCN35
- Temporarily disable clock gating

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Agustin Gutierrez (1):
  drm/amd/display: Optimize OLED T7 delay

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.183.0

Aric Cyr (2):
  drm/amd/display: 3.2.251
  drm/amd/display: 3.2.252

Artem Grishin (1):
  drm/amd/display: STREAM_MAPPER_CONTROL register offset on DCN35

Charlene Liu (4):
  drm/amd/display: Temporarily disable clock gating
  drm/amd/display: Add z8_marks related in dml for DCN35
  drm/amd/display: Correct z8 watermark mask
  drm/amd/display: fix some non-initialized register mask and setting

Duncan Ma (2):
  drm/amd/display: Fix dig register undefined
  drm/amd/display: Update driver and IPS interop

Gabe Teeger (1):
  drm/amd/display: Add option to flip ODM optimization

Muhammad Ahmed (6):
  drm/amd/display: disable clock gating logic
  drm/amd/display: Enable DCLK_DS from driver by default
  drm/amd/display: disable IPS
  drm/amd/display: Fix MST recognizes connected displays as one
  drm/amd/display: Expand DML to better support replay
  drm/amd/display: Enable DCN low mem power by default

Mustapha Ghaddar (1):
  drm/amd/display: Add DPIA Link Encoder Assignment Fix for DCN35

Ovidiu Bunea (1):
  drm/amd/display: Use optc32 instead of optc30 in DC

Qingqing Zhuo (1):
  drm/amd/display: Add DCN35 case for dc_clk_mgr_create

Rodrigo Siqueira (1):
  drm/amd/display: Drop unused code

Roman Li (1):
  drm/amd/display: Enable replay for dcn35

Sung Joon Kim (2):
  drm/amd/display: Add pointer check before function call
  drm/amd/display: Add IPS control flag

Sung-huai Wang (1):
  drm/amd/display: fix static screen detection setting for DCN35

Taimur Hassan (1):
  drm/amd/display: Add reset for SYMCLKC_FE_SRC_SEL

Wenjing Liu (1):
  drm/amd/display: Update pipe resource interfaces for DCN35

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   1 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   9 --
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  13 ++
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  24 ++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |  16 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |   8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |   2 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 114 +++++++++----
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |  62 +++++--
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   |   9 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |   4 +-
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.c    |   2 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.h | 151 +-----------------
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  53 +++---
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  50 +++++-
 .../drm/amd/display/dc/dcn35/dcn35_resource.h |   3 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  47 ++++++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   4 +-
 .../display/dc/link/accessories/link_fpga.c   |  95 -----------
 .../display/dc/link/accessories/link_fpga.h   |  30 ----
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   1 -
 .../drm/amd/display/dc/link/link_factory.c    |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  31 ++++
 32 files changed, 359 insertions(+), 391 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h

-- 
2.40.1

