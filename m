Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5178C3A5A9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA102072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UV6NYGBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA102072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF126E082;
	Sat,  2 May 2020 21:34:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F666E082
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgwloDmFtw7UIvW7ZHAyG4UPt83xBBdXEuSx+lm0VDxS76z3/8GLrhCRiVDafj2c9ZpB+QmBWlXogCR6c9L1C/KRSBLNpi4ZjpnTEL7Jr1mXRa2Rm4zmOqasQNIwUT3c4471xsS2LjfcWbbSGT1E6isH/Tw8mFFa8qPe3oW2IJfYndIVRaG/LXnkQLw0I81TsZxviTFOgt7pls7w+FfzrpYZL+XTaIkmjUEzYN6HAyRvMHfqSpDk8QWC6mBujSReRGkhxYm9Uvp1kl2R84xB9b8mJ/HPIxdsm+2K3WJDeMEH6xoX90org/PBKjmEXhqABLwHBaK2eNYVshxKcB538w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX3P3HQ0jASt8wZfXQt0QLGUe8vaczEq6o7rJX62VYU=;
 b=Cu4mGOCiIvKUGSq9HoMJl6tVZY7zLu+CKTq+AHX1ptqF/4KE+SNQckGDB+6AEGtZ1Gy64UOVyed+5CYamia+lP4gch+ENEczec2bi1XJ7t/FCwLxBaPJFTDHCvE9q0Air9tptyiDbFsTC1hktLm009cCBQNixRB1INAkCjXQdr/BZWb4M+XJHRdesECAzAE1Z3r45WqhttJcQDtMrnCPr9voRZnR+YSeSaiNeBVa44cNIO6rd4VAo+hoLX9YxhZ+PnLCy+8Asmi1eQc5CDCSm5k1f7OtD3lIP8mUHmWuRBaCfuUM22TVyysA5O5cF7j6Y10nNDf7sdfHKCuyCF+6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX3P3HQ0jASt8wZfXQt0QLGUe8vaczEq6o7rJX62VYU=;
 b=UV6NYGBrIKLTInkxWZMaQgXovpnCngRxTblDWO4CnAF0D/gDLm4Z0L+CgtgFDFl1V8mXN/AC15V+rMJxVIn9Pc1gF9QaSGOT3mHO/fYlpipR1rptsUt1VrnV7dzzFwZnOS7Sii/tfVLBg8BAnzgka0iY94ryM2e8LVwI6eHnjLY=
Received: from MWHPR22CA0062.namprd22.prod.outlook.com (2603:10b6:300:12a::24)
 by BYAPR12MB2965.namprd12.prod.outlook.com (2603:10b6:a03:ae::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 21:34:46 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::7d) by MWHPR22CA0062.outlook.office365.com
 (2603:10b6:300:12a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:34:46 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:44 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:44 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:43 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches 27 April 2020
Date: Sat, 2 May 2020 17:34:26 -0400
Message-ID: <20200502213443.39232-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(47076004)(54906003)(6916009)(316002)(8936002)(70206006)(70586007)(8676002)(426003)(478600001)(82310400002)(336012)(2616005)(81166007)(356005)(36756003)(86362001)(5660300002)(26005)(6666004)(82740400003)(1076003)(7696005)(2906002)(44832011)(186003)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b983f1a6-81e6-4db6-4b98-08d7eee0a23a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2965:
X-Microsoft-Antispam-PRVS: <BYAPR12MB296523B77F8AFC5459414E7C8BA80@BYAPR12MB2965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nANyIe9wY1B/zV004pynyL7le6idkwVDlBDYNZucN7VESffScibQjya/m4l/a0khpIT6uMniX5D5fEtkoIApE7MJw1NZe7HwzTFZRtPMduUztOmi1tzHM3QQMG5J/1qGzTxej6ahVcELkaZWjmlqV2WVSM4QuzJnS2m5JqJA9glvh1Q2gZiahfNCii3tWUkIBJwFcYbOyG1eElBPEhbVMQHdhG5L8424iBWI9QJmfmQ9N0neGknp/I0zTJOH83T6kCkGQVyBjYSbGo9p9/zcCGfFOjKybV48e9S/DKnMS5Zsxsu0+rFhI6kuvvgU3YsfqKtaWKGEnJdwlp/ACDJxARkhzRFWERRbrVCgvRkt2FFv/7qqP9oVKRtUbTH5E3J05wHrCqNoVmOH+Il9hLKakqgTh8ThlUeib8Saibotl/ExRURRmaWltuo9fkjqZoLWUAPKiu+gXQmptjZFvHUiW7+1NjoaAX2C1zD9+VtjQLA5b1hPUrlcXfGg5bzNjWundVFgG57AVrOWlmpq0Xj8HQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:45.6349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b983f1a6-81e6-4db6-4b98-08d7eee0a23a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2965
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
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we hightlight:

* DC version 3.2.84
* FP16 pixel format support
* Various bug fixes and improvements

Alvin Lee (1):
  drm/amd/display: Allow PState switch in VBLANK one display VACTIVE

Anthony Koo (3):
  drm/amd/display: add addition dc type to translate to dmub fw type
  drm/amd/display: move location of dmub_srv.h file
  drm/amd/display: Add struct field for future use

Aric Cyr (2):
  drm/amd/display: Mode change with same timing causing long display
    blank
  drm/amd/display: 3.2.84

Aurabindo Pillai (2):
  drm/amd/display: Prevent dpcd reads with passive dongles
  drm/amd/display: remove unused module/stats

Isabel Zhang (1):
  drm/amd/display: Add 4 to 1 MPC split support

Jerry (Fangzhi) Zuo (1):
  drm/amd/display: Check DMCU Exists Before Loading

Lewis Huang (1):
  drm/amd/display: temporary clamp the vratio used to 1.0

Roman Li (1):
  drm/amd/display: fix counter in wait_for_no_pipes_pending

Stylon Wang (1):
  drm/amd/display: Support FP16 pixel format

Sung Lee (1):
  drm/amd/display: Update DCN2.1 DV Code Revision

Yongqiang Sun (1):
  drm/amd/display: Move panel_cntl specific register from abm to
    panel_cntl.

yanyan kang (1):
  drm/amd/display: The external monitor will show gray screen during SUT
    reboot

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  40 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  65 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  67 ---
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  | 215 +--------
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  30 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   | 204 +++++++-
 .../drm/amd/display/dc/dce/dce_panel_cntl.h   |  48 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 129 +----
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  15 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  49 +-
 .../display/dc/dce110/dce110_hw_sequencer.h   |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  35 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  18 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   8 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 127 +++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   5 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 +
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  29 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  26 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   8 +-
 .../amd/display/dc/dml/display_mode_structs.h |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  15 +-
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  16 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   3 -
 .../drm/amd/display/dmub/{inc => }/dmub_srv.h |   9 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_reg.c   |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 +-
 .../display/modules/info_packet/info_packet.c |   3 +-
 .../gpu/drm/amd/display/modules/stats/stats.c | 448 ------------------
 drivers/gpu/drm/amd/include/atomfirmware.h    |  12 +-
 45 files changed, 561 insertions(+), 1112 deletions(-)
 rename drivers/gpu/drm/amd/display/dmub/{inc => }/dmub_srv.h (99%)
 delete mode 100644 drivers/gpu/drm/amd/display/modules/stats/stats.c

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
