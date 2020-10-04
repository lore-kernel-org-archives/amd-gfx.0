Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D55C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95E3206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xPcjEk5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95E3206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE1F89E03;
	Sun,  4 Oct 2020 17:18:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55C889E03
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnmrTKM9IEb2QtTgKNlBJQTrDM7shsW6ap6FPlNaUxzYPpMWmaBqxi+1AAWTtrx1bbbpu4d2PoMlf8CJBLkdkxvy7ueG1LWTJ6m118J0BOYOXkQQHVkM2flWrdP2aM/hMHZeHLa7VRXbd3g7PmgLCXXhMELkbVDHFiqcFYbx6ZYzJ70ZoWZKlVA96kSd92glwxqadunay/C3VTBmIgRAkS4HQfvbyKko28+avPZCP/Ogfw6bmDgUXzf+Mx+QI7ml+JaXkTnYXJ2niaGQDhZ/g6rsfLyO0clOSAkteUJpNOVNg7q4uP6GNfDreQyy46nkJFpQm4wP4FcOmD21xcKqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/O3jof//Gh8CrlrmBtrIBVyKL4F7lyPStp8/7Oii8E=;
 b=IZoeWenvzG3zjEl8pMlt1iuz2XAhnFdVAZQ1ADehQ8BtIeSbg63VkQetDeT89e5ON+AxohbVJphM2dBYCvdS9XJ08hPb5xEHmtPC45rRrWZ2U/ls3SJLGpdOhCPA/bVdoMG8IrYz0sSTGQXHXwfcimGnWHRhel6+3LwU/hj78iaXp0TA3t9T80Pk8TJu9LnhhCeSz8GytUOaHk9HPUngIRlx6VtPtKrYWE4lMMiqMLcUP+McwFSs9H7Zwo8P+aZhlgK+rgliiP3KTa3iyuJXIdaJvj98ZaNxp1KeBDvaBgMwfX2A9TxYptznzr/rStVmPT55F5izekd9GAxmUL8vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/O3jof//Gh8CrlrmBtrIBVyKL4F7lyPStp8/7Oii8E=;
 b=xPcjEk5ligIucXM046WT+4xRSaDp3LcmQJFrMJusaXPXDnMOP1IP624CWVagl9AzngVGkmSneqWXbgGOT99asVrKid9DLeGCje2a7rhgK4zJOXmm+aehemJDoN7W4E0vqxFogkirjEbhIhImpjwWblbij/zitkC6TcparKByEf8=
Received: from MWHPR22CA0066.namprd22.prod.outlook.com (2603:10b6:300:12a::28)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Sun, 4 Oct
 2020 17:18:39 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::11) by MWHPR22CA0066.outlook.office365.com
 (2603:10b6:300:12a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Sun, 4 Oct 2020 17:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:18:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:18:37 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:18:37 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:18:31 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/18] DC Patches October 5, 2020
Date: Sun, 4 Oct 2020 13:17:55 -0400
Message-ID: <20201004171813.7819-1-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca4c1177-4947-4648-3b60-08d8688988e5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4181:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41812FBB9A437CAEBDE2B277E50F0@CH2PR12MB4181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34Vp/YXcFlTKqiD14j1sc5t7ifWodzHgLVRwkQC5+pTf7Mx3R0G+yWX7dlvtmizJz6mQc/59oWgdmtihDDyS1Mm4Iykq3MvwjPzXDoPuiEngKpdk+/si+M8Tk7LjOOy3PlvwApIzHaXFzUnZF/TZQjmjy4NZmNOGtKaTL98r+0O8lf7dEIdv1gmRo9bDEAyGSqWoA8IBefXJBRCL6WNAXGgNfQY6/nH59SG146frlzVCljxEbAplE2wq/QKeoXPYIFG37lJo9Y9PutL6n1KsX85zgvqmq2LhP+w1N+T0WKIWHMSZVXofcxl0p9/B3fU1BqXqBnH7s2oUb4yZCFAO5Q595TWDqjXC5bhLzFBjEDq6T2gCYU6QYdZf+DA+UpMJocZrh6Q8jXG4Sz8G5EGuFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39850400004)(46966005)(5660300002)(8676002)(478600001)(36756003)(8936002)(6666004)(83380400001)(1076003)(44832011)(82740400003)(356005)(82310400003)(186003)(2616005)(70206006)(70586007)(81166007)(4326008)(336012)(426003)(2906002)(54906003)(6916009)(26005)(86362001)(47076004)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:18:38.7648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4c1177-4947-4648-3b60-08d8688988e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fixes in Freesync, audio, ABM
* Improvements in i2c, p-state
* Added HDMI remote sink validation

------------------

Alvin Lee (3):
  drm/amd/display: Don't allow pstate if no support in blank
  drm/amd/display: Program meta addresses correctly
  drm/amd/display: Only flush inst_fb if backdoor loading

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.36

Aric Cyr (4):
  drm/amd/display: 3.2.105
  drm/amd/display: Check for flip pending before locking pipes
  drm/amd/display: FreeSync not active near lower bound of non-LFC
    monitor range
  drm/amd/display: 3.2.106

Charlene Liu (1):
  drm/amd/display: Add i2c speed arbitration for dc_i2c and hdcp_i2c

Chris Park (1):
  drm/amd/display: Change to correct unit on audio rate

Dmytro Laktyushkin (1):
  drm/amd/display: Fix OPTC_DATA_FORMAT programming

Fangzhi Zuo (1):
  drm/amd/display: HDMI remote sink need mode validation for Linux

Felipe (1):
  drm/amd/display: Fixed comments (uniform style)

Joshua Aberback (2):
  drm/amd/display: Force enable pstate on driver unload
  drm/amd/display: Copy WM values from set A to other sets in hw_init

Rodrigo Siqueira (1):
  drm/amd/display: Avoid set zero in the requested clk

Sung Lee (1):
  drm/amd/display: Hardcode 45W Bounding Box for DCN2.1 Diags

Yongqiang Sun (1):
  drm/amd/display: Block ABM in case of eDP ODM

 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  18 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |   9 +-
 .../amd/display/dc/dce100/dce100_resource.c   |   1 +
 .../amd/display/dc/dce110/dce110_resource.c   |   3 +-
 .../amd/display/dc/dce112/dce112_resource.c   |   1 +
 .../amd/display/dc/dce120/dce120_resource.c   |   1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 164 +++++++++---------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  11 ++
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |   8 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   6 +-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  15 ++
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 120 ++++---------
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |  54 ++++++
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   |   5 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  16 ++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   8 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   6 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   7 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  17 +-
 .../amd/display/modules/freesync/freesync.c   |  55 +++---
 35 files changed, 323 insertions(+), 235 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
