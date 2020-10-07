Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3ABC4363D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FD420789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UWDYhIdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FD420789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E79889319;
	Wed,  7 Oct 2020 12:42:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A0689319
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu14oPswFJWKp4hgQXGoIz6ZBiJzFpmpCHDdj2ETRz6YJnK8+UTEAyXdsXuBwBZ7j/j/Yt6d+rWUnNdjtGWoSUkLjZaBu6tbfHVNgBA5TTzW8CxZi608ySGUHJXDAawd4+x6ja6WQa/NNBo4bqiuZnq5VY0uso/rW/7nxcC8RK5YExsyjeM7nziIAZqfL6hTQm11hV5aDTO2iJl/omxhTEfSl35OqblMzsMHTkMCvJQrwFupI+/UHOPhBzCz/W905hhPUjvbqZfTpECwBw/18LfxnQLTdDTNLQYKhP2fyA6hhq1+B+MVUWpdoHKor9krTXFBj8K4ARVhyGffCJzurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyxFICR85z2wTrwWS6sDiuN05+XgPl+Uo9DqYH6SoYc=;
 b=d6qfWPa5YqXTFW9WTER6tc8BJlsvaHJfoEzXTHiKVk0HoJew47zjzpd3siLd4+7JjWh/fYyIHCMoCCus35XaOdvYdPPR5O5e1VdVSG+CulTjS0lnkY7OK8sJupRKhduBeaRKVHqqAWYkK8Anikl1UaHFUmszRJx+uwrt57NkCOT0UDFQgkO0uk0kuMNMyZAc2r4A5WUYXIW9O4zDLKa9CiOoTXUlQ9A+zHYuf9Yhqpwc1aeGvlZ1uBFjV8A1wpStMjhs+xBNew22DHnFfm9/nwL19G2QQoM7wIk6SCyiRwd9oJQ6KuGJmUJDgtnuOWc39K/L0pRLe7jJ/KSNj0URlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyxFICR85z2wTrwWS6sDiuN05+XgPl+Uo9DqYH6SoYc=;
 b=UWDYhIdM0+aGcNpvxf93i7kGkLIU9NHIO8M4xfunmy+Sx3D9Fzdbyr/1EGksylBuXpvLmCW32Yubzj8TVar3R7Xe/FqPGa+MZhu3bBFrQkSwTYiSvdgOYVrcXJe2XwPpD+rpv7DG2z1ta0sIzDOuwZBNcvo75qKJsyAcpwmPCLg=
Received: from DM5PR06CA0066.namprd06.prod.outlook.com (2603:10b6:3:37::28) by
 MN2PR12MB3264.namprd12.prod.outlook.com (2603:10b6:208:104::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Wed, 7 Oct
 2020 12:42:26 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::3e) by DM5PR06CA0066.outlook.office365.com
 (2603:10b6:3:37::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:25 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:25 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:24 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches 2020 October 12
Date: Wed, 7 Oct 2020 08:42:12 -0400
Message-ID: <20201007124224.18789-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcba13ab-40f8-412a-1ed1-08d86abe71ee
X-MS-TrafficTypeDiagnostic: MN2PR12MB3264:
X-Microsoft-Antispam-PRVS: <MN2PR12MB326405B5A332F801A099877F8B0A0@MN2PR12MB3264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUhs56QdvO2Tq3Z/b6oGg89GtTA6oJj/imwL8kKu5V0S0Xd6fg7rRx8tdsUNrmF6wZEXNwGmtlA/WRJUxco16Au2D3x7N8mMLtZG3ac5i0B9JE47o2dSVh8x/djWmzgGs58ju9/yrcUNbZY5Z8tKKR207J3KYs8AsIvCVMvRdqR64CSsXksVvzMHRJGh4ZtU3WhlBkgQXXwKnBFaSJ0rER55lET8PTLCy40QkB4qncVAqfTjm6BNgHliCijGFyiuOk01rn5Vt8O+4bqIWbdi4gRXLIzuq3lrFbid8G/Zu17XqMi+Sxnq/jrxhF7zaKxnk2bGZ0V34mTwbyORr39r1UB3lbVlWxXNYp8NHz8YP+ohxurk0zR67z2F6gUIhPT3ThXipnVGpasmK2/pT73FMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(82740400003)(83380400001)(5660300002)(4326008)(47076004)(426003)(26005)(2616005)(316002)(186003)(336012)(8676002)(356005)(86362001)(7696005)(6666004)(81166007)(70206006)(44832011)(1076003)(82310400003)(36756003)(6916009)(478600001)(2906002)(54906003)(8936002)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:25.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcba13ab-40f8-412a-1ed1-08d86abe71ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3264
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* DC 3.2.107
* Firmware release 0.0.37
* DCN21 power optimization for video playback
* Bounding box updates
* Bug fixes for DP/HDMI hotplug, DSC debugfs, watermarks etc

--

Alvin Lee (1):
  drm/amd/display: Set WM set A to 0 if full pstate not supported

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.37

Aric Cyr (1):
  drm/amd/display: 3.2.107

Ashley Thomas (1):
  drm/amd/display: Source minimum HBlank support

Dmytro Laktyushkin (2):
  drm/amd/display: add dcn21 bw validation
  drm/amd/display: enable odm + full screen mpo on dcn21

Eryk Brol (1):
  drm/amd/display: Reverting "Add connector to the state if DSC debugfs
    is set"

Nikola Cornij (1):
  drm/amd/display: Add an option to limit max DSC target bpp per sink

Reza Amini (1):
  drm/amd/display: Define PSR ERROR Status bit VSC_SDP

Stylon Wang (1):
  drm/amd/display: Fix black screen after DP/HDMI hot-plug

Sung Lee (1):
  drm/amd/display: Add Bounding Box State for Low DF PState but High
    Voltage State

Taimur Hassan (1):
  drm/amd/display: Raise DPG height during timing synchronization

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  87 +++-----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  39 +++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  10 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../amd/display/dc/dce100/dce100_resource.c   |   1 +
 .../amd/display/dc/dce110/dce110_resource.c   |   1 +
 .../amd/display/dc/dce112/dce112_resource.c   |   1 +
 .../amd/display/dc/dce120/dce120_resource.c   |   1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  20 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  |  12 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |   4 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  17 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   3 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 206 ++++++++++++++++--
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  16 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  24 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   5 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 +
 28 files changed, 370 insertions(+), 110 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
