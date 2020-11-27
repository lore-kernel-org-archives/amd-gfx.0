Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B279C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B7921D7A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 14:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AlKEBctU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B7921D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8907C6EDDC;
	Fri, 27 Nov 2020 14:11:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08916EDDC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 14:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msUjzU3bE8FYsctTvrboL/jAaYZeMPsN+dSv6aARLqXKV0TM63er6xTe80mohJtPWMDwYiXwpiBrat5pj5qyTyWf6vw2jQRYXjlxIO/90O/n+rirXUwGRWOf8EIrjqO5oAOlPlPXnvgfpv63qSEmOmjHYUocoQ6ebjYJe9ksLZhPHsem7r6q3Dnllg7/rh9gLyxVL2/A4qDScBq+Paf0xnS5rAJt7Q0fx0/Qw2X8BHgb5lUcvakANqMHcTnQwxmT1Q81412OFzByqIe3yozLMBEAVjy23O9+vBTTMwNQgejYPq3YkEKtVNwyeWyZ8xlk1nHnYU4LnkQI7rFzyiSnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7U42T6s+cgKLmBRFrWgIHeGGr0pwqP3FTxkYo0TX+o=;
 b=K1ambpumbupCf/i9TKI++9V3bxai1+z+v7v3GjF7Bw1a5eG86DkBqKW7EiPYZJoGQbYfqKDKzy3ARRTpPiUM1upJQCZWg1gt0jKmC8rTPTk5NcbIbQGai55s6E2Up8xVMLE88rCNc+qJqhtzOthtIhZozxUAVZnGiLWaxL/nzpuUG2h2f2Glbl9Sj1zQg+yu204z19r6zWz279GKeqRaRIIqIZ8IQ6h/1kkjz9mT8BVJ8jnRmuimdiIeT7b20aEyfMDYZCQW7SriX12bFkdR3GlpX5rvg2W09Y+X/0phU/98I/XbLZf/Ir52rYNHSTy4oWiNdewR8M/19+e9+Dsqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7U42T6s+cgKLmBRFrWgIHeGGr0pwqP3FTxkYo0TX+o=;
 b=AlKEBctUP9/ejQtorChPidDoSDZWwi3rtnw0zH+RutmDi/6R+/L1FLhDBR91gjFmBToYneI82cPLMLjlDhhVq4cPeUimH1SxKflHZJqAGp2FnC7EdVGnhzEZQIUT0CPKxCxbuBBjdImWTXs8kMhEBPMfIOD0sGA8CRNsZrzDTtc=
Received: from MWHPR04CA0027.namprd04.prod.outlook.com (2603:10b6:300:ee::13)
 by MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 14:11:09 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::d6) by MWHPR04CA0027.outlook.office365.com
 (2603:10b6:300:ee::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 14:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Fri, 27 Nov 2020 14:11:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:08 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 27 Nov
 2020 08:11:07 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 08:11:07 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] DC Patches Nov 30, 2020
Date: Fri, 27 Nov 2020 09:10:56 -0500
Message-ID: <20201127141107.7731-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eaa5fea-a8b7-4220-f9ea-08d892de49c5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3935:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39351EB8D438F04FA45D9D5F8BF80@MN2PR12MB3935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kI6mY7XPHK7eaWLYAxsM7L9LhfG7S6KfzsSxCEEMdVduD03KE5ecVpJmlc1mcqemSWGdZzkkv8Ll7CDx3cf8klfm9THkFn0aKitZmsXRjd3U0XfkW3nLA+w/mE00TW+zMuyYtObCX5mbBienO0ifgvHu8Oao9sDU43TK2idDyNe1afLYqHsAT00ac9NqU45nYnhFy6jRcZOvdeJjuH5ir2VcVsiPuB5ZO1UWQopA9gM2UBV3SQssAdVgZM8d+vad36JPNPidvoRi1kR1sVln1GvSvRT3x3X9OnAW99SJen/L/f1r9Los9L/4modl2zac7NdCJjBvd5ZGOmd47IVfRa005E6EiIvgQKlWYwhbQ9Fu/vfyGDHSZ9fGUGj+7lpLp/lQrb7ZP1qEH1f5ZRxzSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966005)(2906002)(82740400003)(47076004)(81166007)(356005)(6916009)(8676002)(70586007)(8936002)(70206006)(5660300002)(44832011)(1076003)(82310400003)(83380400001)(4326008)(316002)(478600001)(54906003)(336012)(26005)(86362001)(36756003)(186003)(7696005)(2616005)(6666004)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 14:11:08.9342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaa5fea-a8b7-4220-f9ea-08d892de49c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
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
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* DC 3.2.114
* DMUB firmware 0.0.44
* Power optimizations
* Bug fixes

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.44

Aric Cyr (1):
  drm/amd/display: DC Release 3.2.114

Aurabindo Pillai (1):
  drm/amd/display: Remove unused smu related function

Brandon Syu (1):
  drm/amd/display: Init clock value by current vbios CLKs

Eric Bernstein (1):
  drm/amd/display: Revert update clk_mgr for vg

Eryk Brol (1):
  drm/amd/display: Do full modeset when DSC debugfs is changed

Jacky Liao (2):
  drm/amd/display: Add HDR3DLUT and SHAPER memory shutdown support
  drm/amd/display: Add DSCL memory low power support

Joshua Aberback (1):
  drm/amd/display: Check link_active instead of lane_settings != unknown

Sung Lee (1):
  drm/amd/display: Update dram_clock_change_latency for DCN2.1

Zhan Liu (1):
  drm/amd/display: Properly define DPCS related info for DCN301

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 13 ++++-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  8 +--
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    | 10 ----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h  |  8 +++
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 24 ++++++++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h  |  6 +--
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 38 +++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  | 19 ++++++-
 .../amd/display/dc/dcn301/dcn301_resource.c   | 13 +++--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 54 ++++++++++++++-----
 15 files changed, 163 insertions(+), 42 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
