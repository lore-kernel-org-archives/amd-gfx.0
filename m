Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFB2C4829C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E68B10E266;
	Wed,  7 Feb 2024 20:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ccBMfC+x";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1B410E266
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtRUZBhrkqrmfy8p60rpQaVw1o7yY0XawvPtVg0+v9her2V3JWfKxF5FOmQbfXsJnuwZYigqBJNUOXYpAJRal4K/BK1w702gqeAQJPjgsoEzpt0bxRlPQH9u2h+JxmOccGVeobCMe6uucuxJUDBGUHNsFnVSL810wDRvxijnz06/76ldNSXcB66j/Hb9o6CEr2cPt1FanGSjxg2bkjUrnGN3TYafocg+87NLxCPugAEjgE5+zkWpy5nzlDur4MCERQ+YeB+HFpM3dvm4vKa2u9NzdgYB9aCj1cQosnKgkOqOIiTdT+mVzCXxYqIwv/RX8tA/rz9LY3HOxGsU1G781g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPB+9PlcP7qmllMEMgww8REGYBBV2evkRDjzcaA+0Wk=;
 b=jEBfo2f/futle100qNylpX/Ea5RI9dWxBIyx07MH8shcJGzazUPWHg5Nn1ukQjXQyTF0tgFLgYh3oKZIHh6aPQcl92GmbAMC2DMk3tBm8+wZ3N5Q5w0bc0Mm2tpSrEZjz/4QBZCMZKLc7RvbuIpxAIzVjsmfr5x7abrS6hk8Oq/YWftfWs1qUv/oy7VMf8hWXuyKHecd5g0oYIsba4+xvY8yqbH+/A0Pxo619/9aV7/g1GhyBQ+7u0lh0gFe+6exiZimhT5SiEQV53oVnc9WFmCGV9GPwUBAEnigIO0MmUkcmdDhT+bHTOIjM+NwtFtC2B9Sl8DnsFXlGw/0H9os8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPB+9PlcP7qmllMEMgww8REGYBBV2evkRDjzcaA+0Wk=;
 b=ccBMfC+xrHp2ohVJYfjnurnUJs2W9Z0QsAPBEMB0ROi2rMcoJp3+lYaGBHYTLbuG2YusICSNcACn29kBqSEeC8gGUmxCpi2m+eP7DD/P21KmCk6PLNDYkGwnRBa0Z9Ln4fZ3IWu898Vd9iBebEG17OR7IiIZtNwl/iaMz3/uQ1U=
Received: from SJ0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:33b::24)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 20:52:09 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::fd) by SJ0PR05CA0019.outlook.office365.com
 (2603:10b6:a03:33b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Wed, 7 Feb 2024 20:52:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:08 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:08 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/15] DC Patches for 12 Feb 2024
Date: Wed, 7 Feb 2024 15:50:35 -0500
Message-ID: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdcfb0c-98a7-4a66-9f36-08dc281ea6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDTkCk+NSq2OwbvdljEHEs2rfKD+xJ2ofpSLw3F9KBDQBQ9eIJakfwAJLA67RvWwUCq56x6ueUsi0dRWTJHba/DWcW9W2GkSb/VFr43W2hQeTSHu458g6Jn4uvTF5IQT2919NAHJ0EicycGiM418SiGCSEmZwmIfr7H03ZusJ4FBb2KTcrLb1LIp1qaUlkvc2TQE8+4EF36wYr5377U6nCltMVgAiQUaryZoM0vOTU8f6qYA+j/BlJaXiYRfaKomllJRt6o458b9zStyL0e8uZfMFn9EKGowyEJQhc/9GaEXCNfYqSYh5oux6VKtWLFkX6X7/XeZCpaaeo/SM4szUMq7mwegARJwCVMO0JdoXDiHNpRcsPYyYUrEr93qzKp5Py/7xHvxREU6V6Gyudw2xDgfG5GZpoxk20yZ8vUiHb20/jdwiJsgKYCoAl0XUMtkKPtvJVd74hYlUDZmF7PKzgmE3ZsmuHbETSR3NbpVrgdVSq1hMDJhCNxuBQXYmWYKx1gIxcdefjwABeibjnHuHG1v2M4orifw1wbw48zZHy8gHE5Euol5g4WZjPVgvQ/YQ/0GdqjxsexMiKkx9TtN3JMPlPOPucLTyEzr//vSLN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(26005)(8936002)(44832011)(4326008)(8676002)(5660300002)(54906003)(2906002)(41300700001)(86362001)(81166007)(83380400001)(1076003)(426003)(82740400003)(356005)(6666004)(336012)(2616005)(7696005)(316002)(478600001)(70206006)(36756003)(70586007)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:09.3112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdcfb0c-98a7-4a66-9f36-08dc281ea6f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

Summary:
    
    * Revert some changes related to pixel encoding and clocks that cause
      corruption
    * IPS hang fix and FGCG enable by default for DCN35
    * PSR-SU/Replay fixes
    * Plane clip size change treated as medium update
    * Fix for checking link alignment done during link training.
    * HDMI compliance test fixes and other improvements

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

----------------------------

Aric Cyr (1):
  drm/amd/display: 3.2.272

Charlene Liu (2):
  drm/amd/display: enable fgcg by default
  drm/amd/display: allow psr-su/replay for z8

Gabe Teeger (1):
  Revert "drm/amd/display: Send DTBCLK disable message on first commit"

George Shen (1):
  Revert "drm/amd/display: Add left edge pixel for YCbCr422/420 + ODM
    pipe split"

Martin Tsai (1):
  drm/amd/display: should support dmub hw lock on Replay

Michael Strauss (1):
  drm/amd/display: Update FIXED_VS Retimer HWSS Test Pattern Sequences

Nicholas Kazlauskas (2):
  drm/amd/display: Add shared firmware state for DMUB IPS handshake
  drm/amd/display: Increase ips2_eval delay for DCN35

Roman Li (1):
  drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr

Sohaib Nadeem (2):
  Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"
  drm/amd/display: fixed integer types and null check locations

Tom Chung (1):
  drm/amd/display: Preserve original aspect ratio in create stream

Wenjing Liu (1):
  drm/amd/display: treat plane clip size change as MED update type

Zhikai Zhai (1):
  drm/amd/display: Add align done check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  16 ++-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  16 ++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |  12 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  37 ------
 drivers/gpu/drm/amd/display/dc/dc.h           |  15 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  83 +++++++------
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   4 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   8 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 -
 .../display/dc/link/accessories/link_dp_cts.c |  27 ++--
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.c  |  16 +--
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |  51 ++++----
 .../drm/amd/display/dc/link/link_validation.c |   2 +-
 .../display/dc/link/protocols/link_dp_phy.c   |   6 +-
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   5 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 115 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |   3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  12 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   8 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  13 +-
 .../amd/display/include/link_service_types.h  |   9 ++
 35 files changed, 336 insertions(+), 187 deletions(-)

-- 
2.43.0

