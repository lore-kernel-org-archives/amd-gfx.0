Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46357C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B47520801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hhZ8eNtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B47520801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29FAF6E466;
	Mon,  8 Jun 2020 04:59:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC186E463
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl30hEbPMm0nPWkdasmIupOmrKtxx7fSDl/XdlQZZnab6V++QhkbfWISQ/vVXv2CuOk94vEpyPB3ftfP4M/2kq+ORJmOCDfLZQ+lSDNisU21cSE/epEg330MVRtgLkXTBhZE/tqGdB2fhjWz0pgY+Hyl8EDmyBhJMiX7yzriyHZIgpQUeZ9R+2QOgo75Debh5IBauAm7BwQBOgCoYvo4e+k6KK4G9YcuM5AU+PklXHKbELBKzfrnpvGXYQJ0oIf5ah5YBZv9HLUCk8iNY3SkhGYdffnHO9qaKP7Em4Lf/vUaXIGLkQL3fAuefcALO59cVJnp1h157w3I2hZ+tkZrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgEbqbWqDEwJ/MEm5ECo+9dCW9X7ummSumVilIgQ00U=;
 b=TMcyKM3qrF8FVi45kkowPOFoaC8nSdJHy8UWCswokOEvJTlqS+ibmPk0chlFJalAjvDmHPF+sdzJwSL9VbB+NqBGUe78yNVn6+dwOLSC+pOIbRzb8SgrYC2wwLwfFLJ09CvtjQM1XSZrFlItxHo4jrFg8qd8ZpbvF8VnHNbJm3CZd4pkk2hxkroqRF0/oz7B9wIuYeYZ0ODrU4rxr0D1kFZPDNRemIWtHvpiwmwjjsWw6pQlOFpPtaZwWwJ77Y/fZ0IR8J9bGdZS0BmCw4d6/Kai+WxMwC5T4+1UVorDzhejR4LqwjKA+45GpYtY6BKe1Am/UpUoSKDh1b3yDodeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgEbqbWqDEwJ/MEm5ECo+9dCW9X7ummSumVilIgQ00U=;
 b=hhZ8eNtdO1vXBz6aKh0mp/bZthd+hJ65Abqr7c/FNjnR80l8XAyFWzbMp4worufBC7+tNKzJj8F2B94yt/5RzfXX3LkY3dQI8prLM1/Nj+i1YMl3pKmPLy/rmNLtzzhMBWyq/URuedRHLLnQkWZ7ZJv8REVVwevu6Vj1jlJj2JA=
Received: from CO2PR04CA0090.namprd04.prod.outlook.com (2603:10b6:104:6::16)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 04:59:29 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::be) by CO2PR04CA0090.outlook.office365.com
 (2603:10b6:104:6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:29 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:28 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:27 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/28] DC Patches June 8, 2020
Date: Mon, 8 Jun 2020 00:58:58 -0400
Message-ID: <20200608045926.17197-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966005)(478600001)(4326008)(8676002)(8936002)(70586007)(1076003)(6916009)(5660300002)(86362001)(70206006)(316002)(426003)(26005)(82740400003)(81166007)(2906002)(47076004)(356005)(82310400002)(83380400001)(336012)(6666004)(54906003)(186003)(2616005)(44832011)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1e66aa6-e11b-48d2-9e20-08d80b68b9a8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1661A7F55AE5D6E522A24E05FB850@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZL2HuY3ls8MYEz8n1bxz/ZaSwEJAq9HbjfpycIXv1bGQkMCyE95dUgPv+/0hcVa7/RO56kbuG1lzq2uS0oDZTlBCPwvFpSGCM48rvOSb1x7QNPxHuzTomEEUAAroxq6SuR8DV+jJEKR5ZKhzP7X/p7R9yOVF4KpkAWe2ZdF78TtzFCAEw+FpHckTFpK7vaoJYv/2XbzXGHwib35h4nTnkFPaZzVwFU13O5RT0O1CsKuXJKV8CsEekZeRlfA2VryoSQ9Tvbpvrz9eAnvfVYbty/2SVnHRR+YtZFsCnexufd+szouPN38M6ndxlsxl0ZwPxn7edhmXDzDx1S+tUW5RB5BEXEHss0NTEbPw5nB/qQfM7S9NnCaQKVmXU1Am5abpYZ67v6IzoaB5nfArErMXVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:29.0565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e66aa6-e11b-48d2-9e20-08d80b68b9a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings changes in multiple areas. In summary, we highlight:
* Bug fixes in bandwidth calculation, DSC calculation, etc.
* Improvements in DP 
* Code refactoring and cleanup
* FW promotion

Anthony Koo (3):
  drm/amd/display: [FW Promotion] Release 1.0.13
  drm/amd/display: [FW Promotion] Release 1.0.14
  drm/amd/display: [FW Promotion] Release 1.0.15

Aric Cyr (3):
  drm/amd/display: 3.2.88
  drm/amd/display: Improve DisplayPort monitor interop
  drm/amd/display: 3.2.89

Aurabindo Pillai (1):
  drm/amd/display: Enable use of dmub iff dmcu is disabled

Charlene Liu (2):
  drm/amd/display: correct alpha_en programming for new pixel format
  drm/amd/display: update audio wall clock programming

Dale Zhao (1):
  drm/amd/display: Disable pipe split for modes with borders

Dmytro Laktyushkin (2):
  drm/amd/display: remove unnecessary mpcc updates
  drm/amd/display: make calculate watermarks a function pointer

Hugo Hu (1):
  drm/amd/display: Revert "enable plane if plane_status changed"

Jun Lei (1):
  drm/amd/display: add support for per-state dummy-pstate latency

Lewis Huang (1):
  drm/amd/display: change global buffer to local buffer

Martin Tsai (1):
  drm/amd/display: Force delay after DP receive power up

Michael Strauss (1):
  drm/amd/display: Fix incorrect dcn1 bandwidth calculations

Nicholas Kazlauskas (2):
  drm/amd/display: Use u16 for drm_bpp in DSC calculations
  drm/amd/display: Fix VBA chroma calculation for pipe splitting

Rodrigo Siqueira (2):
  drm/amd/display: Rework dsc to isolate FPU operations
  drm/amd/display: Add helper to convert DC status

Roman Li (1):
  drm/amd/display: Remove unused macro from dcn21

Wenjing Liu (1):
  drm/amd/display: Revert "DP link layer test 4.2.1.1 fix due to specs
    update"

Wesley Chalmers (1):
  drm/amd/display: Move call to disable DPG

Yongqiang Sun (3):
  drm/amd/display: runtime select dmub emulatior.
  drm/amd/display: not reset dmub in driver.
  drm/amd/display: Not doing bios data pack.

po-tchen (1):
  drm/amd/display: Passing initial SDP deadline to dmub

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  10 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   5 +
 .../drm/amd/display/dc/calcs/dcn_calc_auto.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  59 +++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  75 +++++----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 -
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  15 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |   4 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  22 +--
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  17 ++
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   5 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |   2 -
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  18 +--
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 151 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |   5 +-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |  27 +---
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   6 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |   2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   6 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  70 +++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  16 +-
 .../drm/amd/display/modules/color/Makefile    |   4 +
 .../amd/display/modules/color/color_gamma.c   | 115 ++++++-------
 .../amd/display/modules/color/color_gamma.h   |  18 ++-
 .../amd/display/modules/color/color_table.c   |  48 ++++++
 .../amd/display/modules/color/color_table.h   |  47 ++++++
 39 files changed, 612 insertions(+), 207 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/modules/color/color_table.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/color/color_table.h

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
