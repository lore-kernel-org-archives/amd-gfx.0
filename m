Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12059C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CEF2073E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YbxgZVKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CEF2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528EF89FD1;
	Wed,  5 Aug 2020 17:41:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3560789DDF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 17:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHn4XCjrE/eQvd/D3kJexjGlS1bi6p0WlW9XXBCygCpKObLH5xbDktT3pxqDoSE1iITiOu+tYhUOfikkd9SNdwRe4MdlMwI356GSORs6QLHFkaMO6UkBFSaJcVmh9TVr88KzbiYbObvxfwmBB9tYBmThish5JWf22hP3KhXKdYEZlfk6izoMlKeWFq8QB/Z6Oh2490ESi9MKxXkHkpPJl6BdS7g+RjhNaSq8G//Zgn+NJoXeZosXx340KWjRqK9gCWzBoVZtXggbdiPf1R+Nw5w9WFt84ey6C4CsS1vxd5VzjlidEucnXC3uSRYD6eOm7b1GnZiE2/GvooMGFRo/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGeUVkJ1S+Z/RuKXvvA9+R2u+8QnKgwEJyvDhq9Hzvc=;
 b=OLVveNWOMxl6a7dnl/ZT7soJZRVECerA3XyzCeXz+DORAdEqw9D+99myyVTkP1EBgoqcdl8FpBdoovlgpKuVnkMrXchTMA7dlTNnZWMWc413YpfKuUbqKUCHkcLexNnWM/+PfpfzJ5MlZf+wQFOX7XGOTP6oyCjW/GuWuxdDTsztm1vMozJisawl2WW1JcqpeEYBEWiFgqeNeZZmpjAPVhxtBbrdww2TElTXFjRKVxw6rd5bNwHP1pzhsVrO4lAojocAjSMcU61AYn27ksGjShkPANSFd9EZyR6wihdaMr9zLN5Vwj6DzGqHIAJbxDiLBFeM9OCQyW4RsBy6yJjYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGeUVkJ1S+Z/RuKXvvA9+R2u+8QnKgwEJyvDhq9Hzvc=;
 b=YbxgZVKAzFRUGGg8Y1tuxCV4Nr2EkSIr8FMhEs/fyK+7j+V8D6debxdw262pyc5XmKvMW5hddoe8TBBcqt4SrDgY/K9iDbMDB6bjBkPrxCRbCzjm8STDN/M6XOijzWFs2IJ6+SPluQ4uv1AMfu2HAIjjHS1OIqiCdb/4NIUq77Q=
Received: from CO1PR15CA0082.namprd15.prod.outlook.com (2603:10b6:101:20::26)
 by BL0PR12MB2546.namprd12.prod.outlook.com (2603:10b6:207:3f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 5 Aug
 2020 17:41:01 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::47) by CO1PR15CA0082.outlook.office365.com
 (2603:10b6:101:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 5 Aug 2020 17:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 17:41:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:40:59 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:40:59 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 12:40:58 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] DC Patches August 10th, 2020
Date: Wed, 5 Aug 2020 13:40:49 -0400
Message-ID: <20200805174058.11736-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda01ade-3897-4b4d-cb9e-08d83966b7c3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2546:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25460A0515D6DCF7029456BDFB4B0@BL0PR12MB2546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqTfaUE2xnbqgcazxjSflLhIaSioV1mxxkUVEHebfJS8Gc0tYmfbeeQ2Wd0Psz9psA/OCbnNU2vU+tnlgm8QzzNGcBgPisJSYslV4cdy/dT1jQRFDjahDHzTXTnQ1pPRaNVl8bpetSFZqLi1/z9iOJIygklA4V1zapAHafIeNzog6Xk2Cg/63qATBDMMH3/ElKI5Eou2p086eo65KP4224n9p41OTa4cNXEk9EFwrk9LIOpQBi7e0agYSmStEKPvl2d5Wen64thLWIrfdOysEJrrMExDmvwfghKvNeYIkXUNRrkqCNMVWAoIPpDVGKTaXsPW1ds+LHKXbVXV+QdJtmE5c48RPVxCidBYsCPkpVX2A07T3bImyfOxgfZa22QVXTxhysCAxO70iNpmlJvvbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(8936002)(478600001)(336012)(4326008)(8676002)(36756003)(86362001)(316002)(54906003)(26005)(5660300002)(186003)(81166007)(6666004)(2906002)(82310400002)(70206006)(70586007)(83380400001)(47076004)(82740400003)(44832011)(1076003)(2616005)(356005)(426003)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:41:00.3815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda01ade-3897-4b4d-cb9e-08d83966b7c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2546
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fixes on LFC, pipe split, register mapping and others.
* Code clean-up.


Alvin Lee (2):
  drm/amd/display: Revert regression
  drm/amd/display: Disconnect pipe separetely when disable pipe split

Anthony Koo (2):
  drm/amd/display: Fix LFC multiplier changing erratically
  drm/amd/display: Switch to immediate mode for updating infopackets

Aric Cyr (1):
  drm/amd/display: Fix incorrect backlight register offset for DCN

Jaehyun Chung (1):
  drm/amd/display: Blank stream before destroying HDCP session

Joshua Aberback (1):
  drm/amd/display: Adjust static-ness of resource functions

Stylon Wang (1):
  drm/amd/display: Fix EDID parsing after resume from suspend

Xiaodong Yan (1):
  drm/amd/display: mpcc black color should not be impacted by pixel
    encoding format

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   3 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.h   |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 154 +++++++++++++++++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   2 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  16 +-
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  14 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 114 -------------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   7 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   1 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  27 +--
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   3 +
 .../amd/display/modules/freesync/freesync.c   |  36 +++-
 17 files changed, 232 insertions(+), 166 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
