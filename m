Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DDBC33CB6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E50220663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oyoSJHjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E50220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B99E6E24E;
	Thu, 16 Jan 2020 20:11:29 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B39586E24E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfA0RDA5HT2XMOfPi3eHwDxsZAEDjDxq/Y+XoAMKFdXBdY4kJTMNBMOmK4TQjcYr4mYiYUARq5lMOtKU6UXxKuvxdE2frg7s/WXvtbcQVzBxceWjY0oUuQi0bCc2+kTlqvyRiiKgGb/4Sk3V1tWiyhtj+okdd4bCfv1Z3fgjPPWyO1jP7NFpC21e6agxrqdbpwJVamZxk+pc3RcgK9M2/KMdFmt1YI6WrZOzZb9I0GB805BQVs2L+USYjKastvUDClvFFKDMXcgfKTZlJmiKVa/u7YN9uGgGeT1PJeSw5YlBbNbNcT0zhgJ+/tg6aFnavUyu1cYO2nmggzQj8rsexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxet/GjI5sbephx6GPpIjD2g9obfGN5HPZ82VIC2hl4=;
 b=OKBebzO99j2tbxMm9DLfSCLNpnUXa7EMWilqdH2bRDG70weumQCX+N+II8L8q5risCt6w7bGDd1z10gcp552W2JlqZCbdl34QDsYidnvoWE2WEbIbYx7Zh3QDeP3EPfKEGJkF7CwOHXX6K82sy9XHrGvqrw0kCteFOwdQKLPuoidYycbmu/CfWwg7H3l7C+jhLzq4PoCWK+wAe3Wsdnd0O41MlzMR5QFKgharViDyD/DH1Nc3Y1NJInXPGevjX0x0a9B8DD2A/Gmm6NSxEnzOqYbekpV4OzOd1A6KiIXYNMaGgRAU9EEgABnx7LW0wt0SLofe63YAvfh/G6ux6JAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxet/GjI5sbephx6GPpIjD2g9obfGN5HPZ82VIC2hl4=;
 b=oyoSJHjlbrV/E9jp7ps3q8GdkCSR6vUA14kLNDGLIuUZ+s8C2IY7bVDOF2kA1BDRXlDYOopd4fFZw4lBAJ+6P1DSaWHzbcxksDLSDTWaXNBWqxP+48UvG9U6m6+dM3GP/PVSizMqHkjT4Mo3s0Apij182frAvZEhhQOL8RRT7vU=
Received: from DM3PR12CA0124.namprd12.prod.outlook.com (2603:10b6:0:51::20) by
 MWHPR1201MB0240.namprd12.prod.outlook.com (2603:10b6:301:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 16 Jan
 2020 20:11:25 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::209) by DM3PR12CA0124.outlook.office365.com
 (2603:10b6:0:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 20:11:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:11:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:24 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:24 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:11:24 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/22] DC Patches 16 Jan 2020
Date: Thu, 16 Jan 2020 15:10:36 -0500
Message-ID: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(428003)(189003)(199004)(36756003)(6916009)(478600001)(316002)(70586007)(426003)(26005)(336012)(7696005)(2616005)(186003)(356004)(6666004)(81166006)(81156014)(2906002)(8936002)(8676002)(5660300002)(54906003)(70206006)(4326008)(1076003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0240; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817bcda2-b083-4527-9cd2-08d79ac04399
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0240:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0240DEA5665F855E1B8471BFF9360@MWHPR1201MB0240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5gfwKBsbwCXqKRvmkhRnBv6Bc97gd6IdsLzMKaRRQfcy262XRUpTVF2mfG2cT6WXZbbYOxcsFLMZE0nwNxTkYYCGWKjmKy3rYPRH2Qkyp58ACh9/32F9vfEXHTFGHV0URB3ktcdF42I7190her6uSWsRfykakU2lEnPM0Exre0OSXgu+CPMGltcOnkopyJ5+hVJijjxk1UtXjPcY8CpQli9iqc/7yHtYr4QGwthdB8SMPUsS0noQuoXCw4Q4z5KgdCR7HJfwWOrY1T6XDa27UuyDhNrEJqS3KWHRiRk/KpSk9f8L1qnZR5B/n0kibPG/DRoQA7mOU8XpXhkZKY3Zb0OIgq1TMxe1gAanLGb3//HTDVgurNLZEFmnfp0B6w6fh0VHj6r/2EjZIjJUNb2O4hrqKaij1uAJLlUEBASRL1cJz58mh3GsoMQRZJWgcuI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:11:25.3782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817bcda2-b083-4527-9cd2-08d79ac04399
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0240
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Summary Of Changes
* Code fixes/cleanups
* i2c frequency refactor
* DMCUB changes
* Update type fix

Anthony Koo (1):
  drm/amd/display: Refactor to remove diags specific rgam func

Aric Cyr (1):
  drm/amd/display: 3.2.69

Brandon Syu (1):
  drm/amd/display: fix rotation_angle to use enum values

Haiyi Zhou (1):
  drm/amd/display: Fixed comment styling

Isabel Zhang (1):
  drm/amd/display: changed max_downscale_src_width to 4096.

Jerry (Fangzhi) Zuo (1):
  drm/amd/display: Fix DML dummyinteger types mismatch

Lewis Huang (2):
  drm/amd/display: Refine i2c frequency calculating sequence
  drm/amd/display: init hw i2c speed

Nicholas Kazlauskas (7):
  drm/amd/display: Get fb base and fb offset for DMUB from registers
  drm/amd/display: Fallback to DMCUB when command table is missing
  drm/amd/display: Do DMCUB hw_init before DC
  drm/amd/display: Add hardware reset interface for DMUB service
  drm/amd/display: Call ATOM_INIT instead of ATOM_ENABLE for DMCUB
  drm/amd/display: Reset inbox rptr/wptr when resetting DMCUB
  drm/amd/display: Check hw_init state when determining if DMCUB is
    initialized

Paul Hsieh (1):
  drm/amd/display: check pipe_ctx is split pipe or not

Roman Li (1):
  drm/amd/display: Fix update type for multiple planes

Sung Lee (1):
  drm/amd/display: Do not send training pattern if VS Different

Wenjing Liu (4):
  drm/amd/display: update MSA and VSC SDP on video test pattern request
  drm/amd/display: Add debug option to disable DSC support
  drm/amd/display: support VSC SDP update on video test pattern request
  drm/amd/display: use odm combine for YCbCr420 timing with h_active
    greater than 4096

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  68 ++--
 .../drm/amd/display/dc/bios/command_table2.c  |  78 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  17 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  34 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |  73 +----
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.h   |   1 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  12 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  19 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  24 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  24 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   4 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |  17 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  25 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   8 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  19 ++
 .../amd/display/modules/color/color_gamma.c   | 307 ++++++++----------
 .../amd/display/modules/color/color_gamma.h   |   4 -
 .../amd/display/modules/freesync/freesync.c   |   2 +-
 21 files changed, 426 insertions(+), 318 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
