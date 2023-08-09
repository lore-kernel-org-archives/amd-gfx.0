Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E18C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7763C10E09C;
	Wed,  9 Aug 2023 15:07:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA5910E09C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMwCZrTfwelq/QihShnSQ78t/UyeiXNSAGcvSoCnmoQ521UANMLvtu9ZmLRFUoLXdENPxOtSicUDSf1Ovct4XbxxJ+bnldaTM3qC+w/AMi2kq29Hy9dEuc8AjbMsWGFyetW8pcV1kqb9cZNdeXvMtNThopPju/vV/XcjLNByzYCxBNcSVebfz7aDnc1LUhpIyKJugqIHQ/7cSKPEIyaNBV9SjGxyLPjol0eD/sB/0+iGqE214/A2IZwKg7yx11/swwf7dS/aFFqN0/tnAoxdrHzSV0k7nu4cDQv2x87Xrhkee7ZxLP+dTeKBEgthYJ7f1xFdeCo7ZSAuRZsylCGO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWop+Oqs0yU6uQ+hpgf5nB4zpawpsWn3xsFg/ol2hn8=;
 b=K7WlSUPCrkHHTw7KgnAfBB/VGh7PkfGyAOAB9dt22i+x2FpdskSlKuN0dq0XKpE3sFiMg0hDfcNskRNNr8smTJz4UkyiTowElFmgNIZOzWtKhPdj9XiwKD2d+6fNuqK9bqzdjG5ISEI9vqdYLJGGV4imUWR9HvzV0wBrtj4SanHM/mqLEI16TxxngBF/Lu+Ri419Ija0AGRGG0r00rTYyZhUgDk8FyeZk1b1jn92RTueddCzY2rg7SU3BMUlxB3W7OIRcApF+hOaI7fLR0k/TcFIeZP1+IRfz6oMY9xRW6+nzm0t7OMKtiMS1dqSVyuiohNC4wkzvIWxdlJxwMnDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWop+Oqs0yU6uQ+hpgf5nB4zpawpsWn3xsFg/ol2hn8=;
 b=D8lwt70Lls7rS/FCsxO4n90P2f/vdJu0rKWXQlES3gbL/mugOxlN+lhVZyo6cyboSSYXG0c3zLLm1zqZ0Rq579ZjT81Ds/ROmdiyjCVcf65lg4lgNEY0wNsuISmHwfG075fuWZeIaCd+fXtoUE+Q6mXsTUeRjXPgykXzIqhZwkU=
Received: from CYZPR19CA0021.namprd19.prod.outlook.com (2603:10b6:930:8e::22)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:06:58 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::50) by CYZPR19CA0021.outlook.office365.com
 (2603:10b6:930:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Wed, 9 Aug 2023 15:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:06:58 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:06:54 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/15] DC Patches August 11, 2023
Date: Wed, 9 Aug 2023 23:04:50 +0800
Message-ID: <20230809150620.1071566-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: 996e781a-0d32-4604-0582-08db98ea46e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQNAbihzEPOVLTQn2uaL7cGPPrbseGLmf2auMSIuUHssDqEDcHuBKd5iJI2hFumIHLn6FQBzVrpOPWZ1hQ+hYnP10yYOSGYRS+Z3Gbz14e2akzqxDzNvFtCOHhe3Io5uvxPS8Qu8zIQkE/gG9DcND22kVVRT6HMMW7IGCpuZUAUoa/uH1PUyc6LErwwvQTopdMvVRYhCwfdH/fhmFbc9O9V964NPz/RJn3Hes4zQUUqw7ZlLm8gzOxfkvzPGBbVNZE0iR/I4uVs9t2rME+lv78R7KmuXM2EhX9xMRME4k1WXyU4u55wYpLOQQTx1SHXluiyt0dVJN926rVcpUpJ7T+TGWPZyu4kwoGddypxXPYcht5nALgvuP2hH81/Ig7j9bPZDDyygo0MDezEZxuPYI5jNN7Om51i3CH/ycoedkJPq1Ow6XH0ry0yVdik9XyhvOyxOgg8LFw82oHItl10gNWtVrCFsYZpkpRyY3vNcu8IJLgUXYhwRrAVMCqGZ6xpWVDdPMKycfA7Tb4KiCJRGiqBB5YP776t7/IRJZ2Fk2iicpyX0kXMY2h7zgrj2Rkww5slycju3/YgE61j/E2jc4eJwLNy8rasp3GUBhx/2sPqS5DGMFYObJf6NI0K2IOQov8Gvxue5kV5gHG0p6Sw0NSO92LehVQUA6CxvKvlMwoUUl4eNm9sBnsNDwo6qzV9JKzCn6PAIs8SAcIovTHplmbvagpwXUmRbOSScJLpu6Gli2P8CJv3MOfjc4vqqBCP2yEEK5Gi4foFfb7rPC9z6bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(186006)(82310400008)(451199021)(1800799006)(36840700001)(40470700004)(46966006)(4326008)(40480700001)(6916009)(86362001)(40460700003)(44832011)(81166007)(8676002)(8936002)(5660300002)(2906002)(36756003)(316002)(41300700001)(70206006)(70586007)(82740400003)(2616005)(36860700001)(54906003)(356005)(1076003)(426003)(478600001)(16526019)(26005)(336012)(83380400001)(47076005)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:06:58.0884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 996e781a-0d32-4604-0582-08db98ea46e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
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

This DC patchset brings improvements in multiple areas. In summary, we have:

- Improve power saving feature
- Clean up for code clarity
- Fix MST issues in system resume
- Fix crashing bug
- Fix pipe allocation for older ASIC
- Fix for gamut remap
- Fix 8K 60Hz display in test cases
- Fix bug in clock gating
- Improve DP2 compliance

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Enable subvp high refresh up to 175hz
  drm/amd/display: PMFW to wait for DMCUB ack for FPO cases

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.179.0

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.247

Aurabindo Pillai (3):
  drm/amd/display: Add some missing register definitions
  drm/amd/display: enable low power mode for VGA memory
  drm/amd/display: Remove freesync video mode amdgpu parameter

Charlene Liu (1):
  drm/amd/display: avoid crash and add z8_marks related in dml

Krunoslav Kovac (1):
  drm/amd/display: Gamut remap only changes missed

Michael Strauss (1):
  drm/amd/display: Support Compliance Test Pattern Generation with DP2
    Retimer

Muhammad Ahmed (1):
  drm/amd/display: disable clock gating logic reversed bug fix

Nicholas Susanto (1):
  drm/amd/display: Enable 8k60hz mode on single display

Wayne Lin (1):
  drm/amd/display: Adjust the resume flow

Wenjing Liu (2):
  drm/amd/display: fix incorrect stream_res allocation for older ASIC
  drm/amd/display: implement pipe type definition and adding accessors

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  27 --
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 185 +++++++----
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   5 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   7 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  41 +--
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 194 ++++++-----
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  22 +-
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |  69 ++--
 .../amd/display/dc/dce100/dce100_resource.c   |   2 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   2 +-
 .../amd/display/dc/dce112/dce112_resource.c   |   4 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  41 ++-
 .../amd/display/dc/dcn201/dcn201_resource.c   |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   5 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   3 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |   4 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   4 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   8 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |   4 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  12 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   4 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  12 +-
 .../drm/amd/display/dc/dml/calcs/dce_calcs.c  |   2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  16 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   2 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h | 220 ++++++++++++-
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   3 +-
 .../display/dc/link/accessories/link_dp_cts.c |   6 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |   2 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.h  |   3 +
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.c  | 200 ++++++++++++
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.h  |  37 +++
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |  22 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.h   |  28 +-
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    | 229 +++++++++++++
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.h    |  33 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   7 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../amd/display/dc/link/protocols/link_ddc.c  |  82 +++++
 .../amd/display/dc/link/protocols/link_ddc.h  |  14 +
 .../link_dp_training_fixed_vs_pe_retimer.c    | 305 +++++-------------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   |   5 +
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |   5 +
 .../include/asic_reg/dcn/dcn_3_0_2_offset.h   |   4 +
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  |   5 +-
 55 files changed, 1356 insertions(+), 560 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h

-- 
2.41.0

