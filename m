Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1267DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31E764D92
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31E764D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 691176E0C5;
	Fri, 19 Feb 2021 22:16:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C5A6E0C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRFDe94mOnBQQZU9Cu7hIvhhiumluBcIW7T3zK26XxKwv9bMHpw3zV/li8fEZQfpSLXWhAxAPzgbyVKDBBPvgJqSJpuv87bXYmpqp7xTtu/i/QkNmtJfNauwMzxVhC2NODf39bpzI1gb9htHS1OjKQy58lk5BsUfaxKSvbnH+A/xbKDeKbybq63p32lb9ZXZP67xdsoIQKo/BFTzzMwniIPjLuj95fXlcaXJaKdixlPj4HjeKcIuRGrwpPRVLbKBQk55GZBwDUckLGtNLFWUokOc+tWzvWvynj8sFRLsqn2k7EGtMhmO/aOqd3w8yZP28osRQ1IZzQSSzlCCikNmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KFb+ObPXbehiEdnA/+4uExPd3uPwEHN4pzJLl4z4LA=;
 b=VNNgyJUwtKYy+dq/G8UnxDfXy/nfqOFoFu8lxkjYNcQqeWAEJibKJl48QTjbGuKgo4Rft+b9kThXtr14RPj2yf0PUmcGsKwDfLOHzHG/R3KUPHhyD0nfpJL34NDqFer4zzHbI5M8+OySboKp1pEQOgK/R7cB7MZ+1y/4vzedq6fiFmj006o2MYf7S50SExzctD01mx+5jnoEJc4OvrlIgkmeDaHnSM7j/EivqzIYi9lJEJtBV67StxRTjMPH7DuRI7cRVx53TkUZpfdU2ug/0hybuktgZo4Sx3vX76f8cxzRR2ziARUcdJAIaSSqfIjBFLU/3A5iTokKYbDr419RRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KFb+ObPXbehiEdnA/+4uExPd3uPwEHN4pzJLl4z4LA=;
 b=LYGTnNu7O3d3rkTV9NR/+0Y5DnDV5oZhVieq94ptV8t2AARy99Vt0ImfEOFkH+9fTMDkxU64/OsI/k6YIoNJ3xKDomYNi+c4qgnm+ia/NliAYLnKWdw0tNvFsn258mRNmtC4vkZfzJwZ5D/VCBo1T95Q0+WfPqTGhlwvpFpmzL0=
Received: from BN6PR17CA0043.namprd17.prod.outlook.com (2603:10b6:405:75::32)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 19 Feb
 2021 22:16:27 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::df) by BN6PR17CA0043.outlook.office365.com
 (2603:10b6:405:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:26 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:26 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:25 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] DC Patches FEB 22, 2021
Date: Fri, 19 Feb 2021 17:15:59 -0500
Message-ID: <20210219221612.1713328-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82146160-4425-4db2-385f-08d8d523fff4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4099:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4099C5074183B8EFB55C78B9F5849@BY5PR12MB4099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4dkmDxNWLgxGOY6gqb/BSUPCPfifDByb1H5Mx5fIRPc38FGOWykmOtsn5VpbQOnS29+VLCW9AKSTJleoJ+DgZYPxLM457uUG9e5tQZknPOwuHlJYAQ+xZklCEF6UejfHcsp7kNvmc3nBtL+eCjyFfYKsRQnfk847HJI6JE21861ZtmSG+nlVNfEzA1VDRQNgmGSAIxrSZvU53yvTWoId2NlixXxOSdCvQdlIlh4yfwhS0rlYR5PTMPCQfaQQHg6qxn/gNe6QwUshVb/m/2oxhdmKjox1kxY4Ff+2JDQHGoNewwf/+Nx9wpkicAFVTAnyw2K9if5mF1FWafnjlaVfi5Ds2fGYVi9PZA/EgfG4m/5zM2tLn56wMv5UZl281XgyJvrR6YNyVxTHxWn/knteQ2fRwEL3PfkFs+B9hA/O4xLrceIofQBdWlkwrNcm5EEQ7hgvsNHPsW1iDDYAeiZLzIPuJ7HortX1OqIEU91oBRNhdWBErPUPP0FPMXH+WjUwPZ6U0HiAMepZzgdMeFR5UGAbA8vtFVeIL4+WNL2gMZP5WglrAthp/HFztIucxCP0WIGeXoM+/wOUT0ko10KdBFnTYCvn/vfYrAgByQKV6svg1l6XH4uXVGulnH5gRpPTpRF3rzJ+pBujxIZ/7sKEeWLBruVYFcc5iN0ezDVFzP/7/jvquCFkQBfx1rwTVI2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(6916009)(70206006)(47076005)(36860700001)(426003)(86362001)(70586007)(2906002)(81166007)(8676002)(82310400003)(82740400003)(26005)(5660300002)(356005)(186003)(36756003)(478600001)(316002)(83380400001)(1076003)(8936002)(6666004)(4326008)(7696005)(2616005)(54906003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:26.7262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82146160-4425-4db2-385f-08d8d523fff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


This DC patchset brings improvements in multiple areas. In summary, we highlight:
* Firmware release 0.0.53.
* Addition of interrupts for DCN2.1
* Refractor debugfs entries for connectors.
* Enable display audio when seamless booting with an external monitor over DP.
* Fixes for System hang after multiple hotplug, timing synchronization for displays, disable seamless boot for DP.


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.53

Anthony Wang (2):
  drm/amd/display: disable seamless boot for DP MST
  drm/amd/display: enable audio on DP seamless boot

Aric Cyr (3):
  drm/amd/display: Don't optimize bandwidth before disabling planes
  drm/amd/display: reduce scope for local var

  drm/amd/display: 3.2.124
       This version brings along following fixes:
       - Fix system hang after multiple hotplug.
       - Don't optimize bandwidth before disabling planes.
       - Report timing synchronizable when DP streams time frame difference is less than 0.05 percent.
       - move trace buffer to uncached memory.
       - enable audio on DP seamless boot. 
       - Disable seamless boot for DP MST.


Eric Bernstein (1):
  drm/amd/display: Remove Assert from dcn10_get_dig_frontend

Eryk Brol (1):
  drm/amd/display: Check for DSC support instead of ASIC revision

Qingqing Zhuo (1):
  drm/amd/display: Fix system hang after multiple hotplugs

Rodrigo Siqueira (1):
  drm/amd/display: Add vupdate_no_lock interrupts for DCN2.1

Stylon Wang (1):
  drm/amd/display: Refactor debugfs entries for all connectors

Vladimir Stempen (1):
  drm/amd/display: Synchronize displays with different timings

Yongqiang Sun (1):
  drm/amd/display: move trace buffer to uncached memory.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  82 +++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  27 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  22 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  39 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  10 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  43 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  52 +++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 225 ++++++++++++++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   1 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   2 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 123 ++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   8 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +
 .../gpu/drm/amd/display/dc/inc/clock_source.h |   5 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  12 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  22 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   7 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   7 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   7 +
 29 files changed, 676 insertions(+), 48 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
