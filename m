Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5B7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEB060720
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EEB060720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEF372DF9;
	Thu,  4 Nov 2021 20:52:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7378E72DF9
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8KLT9xuHNX4GrqAES8sf1K9ZBV+9YIaqqO7XICJud9Et86+9M5Q/hSQP9Zk9iubUHB0QGA3V+9cwaYviVyogXP2tedyzIKeOkhLHYNKVKOKzSucospohbKdYBnEt+nmfIAwdAk7JqES9Bh0ZHvZxOexjQnuDLCyfqQWoQYyUzkczdhzw1FogWl5T4FLUYrYMDDv8BCYyKG+KE5W9eGqPO9sDAaGSM3TyeSLOkUDEjICw/vzdhVuyhnRk35OF1vXFu0dTDZsz7Dkn+5wZ6NLqXqvZ5HWQWkIisnT9SQljSh0wLiKFJxwwMP9qu+55wh2M9Ajub8u05hrqXJlx+FkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fLGg+VpxJAvZ3V6pyOsOCR/BIfeMhiRMK+7bRhXgE4=;
 b=ek6Eb+e+l5Fhp4M9wFFsMGBFHKxT3NmWQKZsRHthrGXpxvAirMBDZLnIcYZIQ8owYyS012BvBLU42cYhBhmCpj7cl4fJvaNhLJkfIY8cgNrorcyLP6/KnPGoJ5AmtJxt+Yqyl8/CoR+mBaxd8SYIG1rF0+qHu5pRBr+NXoDoCPV4BZ2tA/z5LnSPSXgbx8UdsiPf8UfUxeRa9ZjvdbTYHBW7m1nQD4TVKTQKmxFvmimWus96h3yS+IzIT2JDw33NSMkmROMsg4hqyRygAAfBwY5a2rmHC3qY2ZZ67AnNsm+cDSLkMpCFxLWeJv80DpaebAbphiHHuZoAbvPLzbZsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fLGg+VpxJAvZ3V6pyOsOCR/BIfeMhiRMK+7bRhXgE4=;
 b=d3leO/o7eqZS88RGO7c7NAaCHzCB689urbRqtjnwe9vnYEisdpYTX7G2XWjIYeYQ0bFSQtGe9f8z8dZiMp/vMY0T5X1+9XVbrWXsuEoCTMz8RIKCR9z3yFAABmZIK+hHv9+IEsyxN4eE7/+d/xpR+rTKBPgI0axdsdKExQ8HRvc=
Received: from DS7PR03CA0296.namprd03.prod.outlook.com (2603:10b6:5:3ad::31)
 by MN2PR12MB3805.namprd12.prod.outlook.com (2603:10b6:208:15a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 20:52:25 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::5c) by DS7PR03CA0296.outlook.office365.com
 (2603:10b6:5:3ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:19 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:18 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/22] DC Patches Nov 4, 2021
Date: Thu, 4 Nov 2021 16:51:53 -0400
Message-ID: <20211104205215.1125899-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13b2038c-e166-4c48-d754-08d99fd500fe
X-MS-TrafficTypeDiagnostic: MN2PR12MB3805:
X-Microsoft-Antispam-PRVS: <MN2PR12MB380527DBD8C63228C04B66A9EB8D9@MN2PR12MB3805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROGnFzANWEoqBwSmQIKey9iTujEMLMS095ALikcHpQ1xlxSnJ/ybE4u31pPrysX4S9a8lyepdfxtqIBCNX2tSG2tGe2IvLpcYQ9U/u5ZsZVUh6fEeFPoHXXaMrSr2j8n0WZRV/i1sGLA8PPAD/RvWkdINyji5rYTlWJ+cMLE63y0fYEdSs0XorOKLhrTC/ko1rYllYm6g2vk7z+wBO3u7SqCQ3d8/ep0KvgVu8mvHEER66+pAHGTVH4iVgdMz5qwvxNzYQWDBE9Dl2awUHNPMhHsszQO3Y7E3FXKNCkp6yuWAMd5PxcnnciwxGs/u0o3eLuduDbIobZtcoNC0MvUyQcwvblg9y+Lh1xkEjA1wjBVDLkkbFIAtMRsopGXTbQMNSZBRnR5C6lOVf0Ij2Sb2LggHD1skjXhHHNLZ4HXrQzWmwoX9SNkgANWjASifx01Dih0UiV/KwCNXPkE8RVrJRa+8pvIhtATwjJT5/PlIppBja4F2H9dldDeS1Mu+Q1K28wMlhHrKlBOIgTDXj1K+3AfjOjhxkkBe0g3Zn8IEXTnFHu7dE/za+uJXT7Fu8MSzZb4wO+F+EHphQalz78sn+tcycHEZ7J4mAzNiwIjdKfH1r47e2/fasiPK2GwwqoxDTcMTyxAFptNjnmFtPAc5QgNn2PbLXJ6xJkys359tq7+coKPEGv4fZOAvrEkXZNtFMGZa5w0ypiGL/xutzzjjjmdc8zMTmES1p/D2s5P4TI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(47076005)(36860700001)(70586007)(316002)(54906003)(70206006)(2906002)(336012)(4326008)(6916009)(426003)(2616005)(508600001)(36756003)(7696005)(5660300002)(8676002)(26005)(1076003)(356005)(6666004)(82310400003)(86362001)(81166007)(186003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:24.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b2038c-e166-4c48-d754-08d99fd500fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Improvements to INBOX0 HW Lock
* Add support for sending TPS3 pattern
* Fix Coverity Issues
* Fixes for DMUB
* Fix RGB MPO underflow with multiple displays
* WS fixes and code restructure

Alvin Lee (1):
  drm/amd/display: Wait for ACK for INBOX0 HW Lock

Angus Wang (1):
  drm/amd/display: Fix RGB MPO underflow with multiple displays

Anson Jacob (1):
  drm/amd/display: Add comment where CONFIG_DRM_AMD_DC_DCN macro ends

Aric Cyr (1):
  drm/amd/display: 3.2.161

Charlene Liu (3):
  drm/amd/display: remove dmcub_support cap dependency
  drm/amd/display: clean up some formats and log.
  drm/amd/display: Adjust code indentation

Chris Park (1):
  drm/amd/display: Fix Coverity Issues

Dmytro Laktyushkin (1):
  drm/amd/display: bring dcn31 clk mgr in line with other version style

Huang, ChiaWen (1):
  drm/amd/display: use link_rate_set above DPCD 1.3 (#1527)

Jimmy Kizito (3):
  drm/amd/display: Use link_enc_cfg API for queries.
  drm/amd/display: Query all entries in assignment table during updates.
  drm/amd/display: Initialise encoder assignment when initialising
    dc_state.

Leo (Hanghong) Ma (1):
  drm/amd/display: Add helper for blanking all dp displays

Meenakshikumar Somasundaram (1):
  drm/amd/display: Add hpd pending flag to indicate detection of new
    hpd.

Mikita Lipski (1):
  drm/amd/display: Pass panel inst to a PSR command

Nicholas Kazlauskas (3):
  drm/amd/display: Fix detection of aligned DMUB firmware meta info
  drm/amd/display: Don't lock connection_mutex for DMUB HPD
  drm/amd/display: Add callbacks for DMUB HPD IRQ notifications

Robin Chen (1):
  drm/amd/display: To support sending TPS3 pattern when restoring link

Roy Chan (1):
  drm/amd/display: fix stale info in link encoder assignment

Sung Joon Kim (1):
  drm/amd/display: retain/release stream pointer in link enc table

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 ++++---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |  7 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 17 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 78 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  2 +-
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 20 ++---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 51 ++++++------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 37 ++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  7 +-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  6 --
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |  2 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  3 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 13 +++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 22 +-----
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 +---------
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 +---------
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 -
 .../amd/display/dc/dcn302/dcn302_resource.c   |  2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 38 +--------
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  6 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 41 ++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 78 +++++++++++++++----
 .../amd/display/include/ddc_service_types.h   |  3 +
 33 files changed, 330 insertions(+), 244 deletions(-)

-- 
2.25.1

