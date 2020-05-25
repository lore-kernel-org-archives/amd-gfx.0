Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC06C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94B42071C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cpwvigir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94B42071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CE689BC2;
	Mon, 25 May 2020 18:13:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6BC89BF0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB2ODxe53/tIO2rV4XEG+ItZI42jS51FvGN5FnNhnZvF7ISTak404ZLlt9P25RykR0yoLnLZueJWNTuEzxhzg0I8d/PDLvAyPvUuPneJW9kDBsKkUIE9TlxAbr2wkLitjl/RaFLRlknrsV3mf2GZMMgpESCn+9SvtVpx3ETcHe2hwklV4lwfgiumzNot3W+kr3AO0pS4tL9EEWMjsgNplAGg/6Kz8TXYZpPjVQwLd4gEAsUSCxGcoV7a5jzzfprVGOwdLSddrd2WsEnOO5xRJDa6tEKhAxkdxZecPNTP69z58fLO4lYFDcfhsx2ukX5VyBfsmxu1/rjcPIfWhX0m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdamBohqi9UHU64jcXGhRcFN8CNNIV6VKWRA1T4x0Ng=;
 b=Qr/GBbkfzqDYlLIGcenEJGh3lAljwPxm/walK9nGFTBddnmUfK/c7OJ503wDOR9c+Sa55+1zifDrCE8Owiydqe/m0ljvivwTryPDg7Qay3a/Etfy9Qaz++2euguQ0VsshdjosypUjf3WZdxsKaKE425sEPMyrhBDyTjIYkBnCWYeMWcYovcdKQGbKbOq6wmP/F1CJRiVaW70cb9ydY/W+J/8ek9Bhh0DVGM9o1jdlwv2H567Ktf5Ps6xwdColEGI9NDF60W12/3gwBttctPjT1/8tKNqEMgML+dtru8u3rbA6F6aMERE9oWP6hO/PQxftItk1GWCjMI1rfR0grVIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdamBohqi9UHU64jcXGhRcFN8CNNIV6VKWRA1T4x0Ng=;
 b=CpwvigirsoN0WdmNIRn3KpoKYAzvL/sx46Gd2ijuty4D/FxBPXGEV7i4erATPx+MzGDZnmPUpl2juBKbi5EimjOxcZklUmLxtZYN0RJcZp8o8jfeDlnyxTZ6YmdhJlQ7oyHn/ssJ50fWc5Lsdr5VPMlWeQA4CZVeCE07TygsALw=
Received: from MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 18:13:11 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::68) by MWHPR22CA0047.outlook.office365.com
 (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Mon, 25 May 2020 18:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 18:13:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:07 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 25 May
 2020 13:13:07 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 25 May 2020 13:13:07 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches May 25th, 2020
Date: Mon, 25 May 2020 14:12:50 -0400
Message-ID: <20200525181306.3749-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(82740400003)(47076004)(356005)(81166007)(4326008)(86362001)(8936002)(426003)(44832011)(336012)(186003)(26005)(8676002)(2616005)(70206006)(70586007)(316002)(1076003)(82310400002)(36756003)(6916009)(6666004)(2906002)(5660300002)(478600001)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25209b6e-f944-4d2c-a3ac-08d800d748b0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4229:
X-Microsoft-Antispam-PRVS: <CH2PR12MB422990C771B45B830E49B0DCFBB30@CH2PR12MB4229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6NlCxjyLuLX3vlUmiI/13YgfOa4soJgMkxn2qlsqI01vItTFV4DMuAWSN2vasZ+XcVtZ50CTqflKWai5cXHn2r7t2y6n+WdNMGZLgagC6Sg7jzRpNvP98vd5RNOAzdulf8I/ajUn9ShET/TFxLwVNXakIvk3SLaIIPBbFR0bI4269gHsFMb99akue5wLdB1MGs6RIqW7GwfHP/plA6CjXMuqQvOISU7dq+JOFNZxpwNqtXz/tf3Zu5uGcK1fIimTk+fcbmVY0XLyXecE6n/0/Xo19wUTS40Udfdc2dFjwCk+NYDXS6OwZAtVbn2bABEAbOCGaelIQGSK7MLOr13UA5TIDQh8in53jUYUfj2MP4l/00ymomK5ZXKUUGbiFXVEf3TnbPZEWocuWX6700EJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 18:13:10.8840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25209b6e-f944-4d2c-a3ac-08d800d748b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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

This DC patchset brings improvements in multiple areas. 
In summary, we have:

* Fixes on HDCP, eDP, etc.
* Enhancements on interrupt handling, code security and others.

---------------------------------------------------------------

Alvin Lee (2):
  drm/amd/display: Disable PG on NV12
  drm/amd/display: Don't compare same stream for synchronized vblank

Anthony Koo (2):
  drm/amd/display: combine public interfaces into single header
  drm/amd/display: [FW Promotion] Release 1.0.12

Aric Cyr (5):
  drm/amd/display: 3.2.86
  drm/amd/display: Fix potential integer wraparound resulting in a hang
  drm/amd/display: Handle link loss interrupt better
  drm/amd/display: Guard against invalid array access
  drm/amd/display: 3.2.87

Bhawanpreet Lakha (1):
  drm/amd/display: Fix incorrect HDCP caps for dongle

David Galiffi (1):
  drm/amd/display: Increase Default Sizes of FW State and Trace Buffer

Dmytro Laktyushkin (1):
  drm/amd/display: simplify dml log2 function

Eric Bernstein (1):
  drm/amd/display: Allow Diagnostics test with eDP not connected

Hugo Hu (1):
  drm/amd/display: enable plane if container of plane_status changed

Paul Hsieh (2):
  drm/amd/display: link_status not align when power off encoder
  drm/amd/display: unit show garbage when do OPTC blank

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   7 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  26 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  21 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  10 +-
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |  20 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   4 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 391 +++++++++++++++++-
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  91 ----
 .../drm/amd/display/dmub/inc/dmub_cmd_vbios.h |  41 --
 .../drm/amd/display/dmub/inc/dmub_fw_meta.h   |  65 ---
 .../drm/amd/display/dmub/inc/dmub_gpint_cmd.h |  75 ----
 .../gpu/drm/amd/display/dmub/inc/dmub_rb.h    | 154 -------
 .../gpu/drm/amd/display/dmub/inc/dmub_types.h |  78 ----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_reg.h   |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   6 +-
 .../amd/display/modules/power/power_helpers.c |   2 +-
 23 files changed, 453 insertions(+), 568 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_dal.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd_vbios.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_gpint_cmd.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
 delete mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_types.h

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
