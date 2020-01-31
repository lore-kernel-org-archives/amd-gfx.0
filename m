Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99735C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3096A2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yZS+p2Vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3096A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799C46FC2E;
	Fri, 31 Jan 2020 22:17:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6886F6FC2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoSSLevfvyDBbmr2ZnBdX6jth+R12gHBcPSC2Q3ASjPfomi2q4wzYt8OLPSwJFsOHL7rbccUsNDCyZb7g0sp1vahZltxmtxn5Gy7h4m3rKScQHYT0JVQGkbWASDa4su/5IoTYry6lXqz5pMsEmBuznbMrAkKE995MMVyrf1ic1Mg6n5BVIskKdlQ7WENOYJ00fAzyzT9gMiBIgM/W8LgFdCw1dWXcI33dAwrGMyJ3+Ckn3WXNqL4kzdoz63AL16lPEvHjfVzA087409b1syLornU7IDr6Teh66ZVksniXMds3UnvYsYeivVnQwh/jvurvQHCb71i74MJKe9uWsNAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv1qfg8HPmbOy8w1/w36KKAFrgqbHwhT/DS780CLo5E=;
 b=h5kDb2ppo7MEZA3JZodrGlAuttmZZ8seyhhmpB9pSdT+APFmbfEs+qfTQUchKGgHCjQUpqRppwINmJ/bZqwvdjxeQvzrWP+/HBG4hSDfPY/4eVZ6xHa5h/hIr+T3vzlVicyjF+zD9bStsERlvcX8xs717wLV46TdbTBfPLlOdrXjaPugrhNkBPWuc1yo2wzsAel8zG/GdbxwaC8GPDPi0EE7I1F/fD6pwddeRdTjnJ4L2wfFcx3H0YU61kuge3r/ATdFgjikxdHJPnRKuApIBWwR35xFta0JSAjNEeQ4THTMr6jpib19l28LGWOViatjNLZsVAYRWFgNXF3fjFm3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv1qfg8HPmbOy8w1/w36KKAFrgqbHwhT/DS780CLo5E=;
 b=yZS+p2VcvegFVHVQeAwePKL/O6JhL4GhYtnqWwT8/+OOVYdORw2erm97RDsT5tPy6JFLMjIe/tHluctpb5O6t01XEggZ8wdI6Imo1OkiQ0vvRA9/0rnk/knWn5w1nNDTETB51OiIP8z6VIvLPPHBz3EpZWGJMlSIJgoIfLRd1Yw=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by BN6PR1201MB0148.namprd12.prod.outlook.com (2603:10b6:405:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Fri, 31 Jan
 2020 22:17:02 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:02 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:01 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:16:59 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:16:59 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/33] DC Patches 31 Jan 2020
Date: Fri, 31 Jan 2020 17:16:10 -0500
Message-ID: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(428003)(189003)(199004)(478600001)(7696005)(6916009)(26005)(8936002)(186003)(70206006)(5660300002)(70586007)(6666004)(4326008)(36756003)(1076003)(356004)(2906002)(54906003)(316002)(86362001)(81156014)(8676002)(81166006)(2616005)(426003)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0148; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4399310-3dd6-4ee7-59c8-08d7a69b4b8c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0148:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01486FF7627891F52EBFAE1CF9070@BN6PR1201MB0148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjTqm7AtYBk02oWKpyanjxlJ/6jeg+Wkyn5MwAmkA69c+InW6A5fn4r8cJSp5YWBY9x1pjL2E1BjzB4ciyYEiNRKJF+jUwoRlbhxctRuayXoXSetFOg+PALVB/1yMhXa6ag7G3dN/UyMPQFoQoQMsX7oF2fqom7vJ43xbjG7DCHfaN7lhRFdaX9r3RIU6AZCSG2ceqr9uHTZJ2B7hbPVPb0aIvd4Wi9vx0cQZSh3XSTZuSIhDyq3gDv7D+rau+tXbTkZHdMJoxOm5WMOD23RUWKnOStsVP1V6RViJU7QTUWAC3ElhFc9L7OcYgWiPUHYNJfdptfJfFXncKI5eqkXkS+z3LZvq2tOqBg2k+NC4mJ3VYeToMjUGyfqpzv5dh4Bl+ghb8dsJO2uPIttgBWtkC6IOoxS7R3df/bMjl/q8o7tKuNCmE1f0BmoostDK5Y9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:01.2224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4399310-3dd6-4ee7-59c8-08d7a69b4b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
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
*DMCUB changes
*psr frame calculation fix
*fix compile warnings
*refactor front end programing
*enable OLED support in DC

Anthony Koo (3):
  drm/amd/display: Split program front end part that occur outside lock
  drm/amd/display: Indicate dsc updates explicitly
  drm/amd/display: Added locking for atomic update stream and update
    planes

Aric Cyr (5):
  drm/amd/display: Fix GSL acquire
  drm/amd/display: remove unused variable
  drm/amd/display: 3.2.70
  drm/amd/display: Check engine is not NULL before acquiring
  drm/amd/display: 3.2.71

Charlene Liu (1):
  drm/amd/display: add stream_enc_inst for PSP HDCP inst use

David Galiffi (1):
  drm/amd/display: Use uint64_t logger_mask instead of uint32_t

Eric Bernstein (1):
  drm/amd/display: Fix various issues found by compiler warning as
    errors

Eric Yang (1):
  drm/amd/display: fix inputting clk lvl into dml for RN

George Shen (1):
  drm/amd/display: Move USB-C workaround to after parameter variables
    are set

Hersen Wu (1):
  drm/amd/display: linux enable oled panel support dc part

Isabel Zhang (1):
  drm/amd/display: Add initialitions for PLL2 clock source

Jing Zhou (1):
  drm/amd/display: external monitor abm enabled in modern standby

Joseph Gravenor (2):
  drm/amd/display: remove invalid dc_is_hw_initialized function
  drm/amd/display: turn off the mst hub before we do detection

Nicholas Kazlauskas (3):
  drm/amd/display: Add GPINT handler interface
  drm/amd/display: Wait for clean shutdown in DMCUB reset
  drm/amd/display: Add DMUB tracebuffer debugfs

Peikang Zhang (2):
  drm/amd/display: dc_get_vmid_use_vector() crashes when get called
  drm/amd/display: Update hubbub description comment

Roman Li (2):
  drm/amd/display: Fix psr static frames calculation
  drm/amd/display: remove early break in interdependent_lock

Sung Lee (3):
  drm/amd/display: Do not set optimized_require to false after plane
    disable
  drm/amd/display: Use dcfclk to populate watermark ranges
  drm/amd/display: Add wm ranges to clk_mgr

Tony Cheng (1):
  drm/amd/display: fix workaround for incorrect double buffer register
    for DLG ADL and TTU

Wenjing Liu (1):
  drm/amd/display: decouple global lock out of pipe control lock

Wyatt Wood (1):
  drm/amd/display: Add set psr version message

Yongqiang Sun (2):
  drm/amd/display: Check hyperV flag in DC.
  drm/amd/display: Limit minimum DPPCLK to 100MHz.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  61 ++++++
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  25 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 149 ++++++++++----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  41 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 189 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  22 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  34 ++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  62 ++++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   9 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  43 ++--
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |  63 +-----
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  93 ++++++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   7 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   2 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  90 +++------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   7 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   3 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  35 +++-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   3 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 171 ++++++++++++----
 .../amd/display/dc/dml/display_mode_structs.h |   5 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   3 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  10 +-
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |   4 +-
 .../drm/amd/display/dmub/inc/dmub_gpint_cmd.h |  74 +++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |  48 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  58 ++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   9 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  50 +++++
 41 files changed, 1074 insertions(+), 340 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
