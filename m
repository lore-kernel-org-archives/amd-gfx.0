Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE16C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1191D10EE1E;
	Fri,  8 Apr 2022 17:26:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C10410EE1E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SktUz4NoTqVIcrttZOLQIkWpCwuk2m6dF0C3k6K6TNWCPBDraqGIQZFZCjVrzWXpYmGMNWdNY4hWnRO6j12aAR0+7TPvBcIjsLHRhjWbmON4pK0sSK4/WGjhLddhgU0tTpykH9aYEN+t0+8tuhSUPKPHbBk1HtDrFvCT3JyL69URVjRmt0FWegD34bUHAGYfmhpX3eXb50Kli6g6L2ptHSkrb8O/+rHVtk4zIcrEEGu8JOW7SPiauvRsZtGivpikRyXk0Ae4Iyaj179akaKMMqcH5rj/KOmn6F0GRy47Uu0V8iFBtBXD4GNy7jfdXZAZ1wMRne1ID3cO92C8intpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boInsfrFfD4ZL/CyIEHtp3MwrgvVvHN+q5KaLU/eLXI=;
 b=NpzA9I5ytttGDd8O63A++5BDTOuEJ+fxlHxuhkgsokGgnOVOHnjORJKdvXFXu5xQxEzjNEBmEebqTHmVqhfN1IaYCy4sieUhxUqKjcG7sg4e2cbUkO3FumDurOasU6VJtARHWFEDrpsWUA5nnlVSG/NSzPXgiADdnxOMOeL7NbeXGnzgUCIm/zkHYmdAyMrF8p11Yhe2Uw7YtnGsFzOG7Uqd+K5aoyaOe7w3YsK69q6hNFtVJ/S5N4hgkSHBnBdqZi/Hk9M4ji8qU7XEFfSXn45cX2JLn/MSXCW76PFzAlmEAtPx8uLhhKXDKyiFJGPDSLCL1g5d9wfm2zwbovV7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boInsfrFfD4ZL/CyIEHtp3MwrgvVvHN+q5KaLU/eLXI=;
 b=bNi6xptaV2JMEsibxXex9d2Vvibi1N42u4yAKjIPQILCY9K34dmdn1J/tl7Pui0qZrPe2PZXcP9hVALbxUcn+Jxl6xKKig0EEK7sTH2i1AFIMCzTLUG4pvsKbQUCw1XFF/PTUfP2gAfPEhkAkewZNSt/HlS1JR65VyVYQSG7fw4=
Received: from DS7PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:3b7::13)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:26:13 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::42) by DS7PR03CA0098.outlook.office365.com
 (2603:10b6:5:3b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 17:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:26:12 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:26:10 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: DC Patches Apri 6, 2022
Date: Fri, 8 Apr 2022 13:18:51 -0400
Message-ID: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3143602-130e-46f9-1731-08da1984e0bd
X-MS-TrafficTypeDiagnostic: MN0PR12MB5715:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5715FC606D3A7BB0AB06E2ABFCE99@MN0PR12MB5715.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Axemj1DvCkGafm/XbfLT63TZutyvlU+LfAC69BuPoet6wBen6ZC8zYRFNFZ4eYUCEL5XJMzXv+QzJ2/ONLYXb84CtHulICeEa9WaE9SJbc5g/5X3QqAZbqYEK7nXlFcmaLg0z1q+Mh7BCDvnaqPvjPEpzV9BlOEpTIfTRrFEco6C331zG6eVSlGymFAnYgdZubsmNO8PBHRRY4u+lu1jXtwClN4eAfVCcC+27W9d/jrSyqI17g9Hk3tA869XkJw/WfP5OWA5DIoPvGxV6bju9Wx3DY+OcjUjVjERpT/KEGo9pz0vE5v3IC5hv0thdwkR+KsbG2OPAafuM1nt/Zt5MaPV7j1l3x4LUii51A2vh/0QgDI7HghUt9Uf5VYpf/Q0A2DnESSmU/f9UgaIInRFP8F6m4bAvM/MLuEi3gw1Tbj0bZjAIRAH5JvrPrlOaNKKxcLBP3M7M1MbP2oGckRtlD1jZfq76LD1EW3ZLwIbM+U3roFYRqTBIUJNPAaZ+kwOltE2GAXKrb5GLmBobYa1jsFPFH6fpHhAnwjxm060HShvq4bJ7t4UysxxkgygwgJthDBHudVkSvyp34QebdRQqEJ3KprWMAYNCpnCBYNNWXEOZKZR/QjJ7JvSTtYF65W7bdtw618oW7fiK10r47nQ6l2lBmT9Va8e/XbDxFumlsiM1lQazwfom1RWSHH9YhARuMPza4YUmQgx3qeK6IUwHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(6666004)(54906003)(336012)(8936002)(2906002)(86362001)(2616005)(40460700003)(7696005)(36860700001)(356005)(47076005)(186003)(5660300002)(3480700007)(81166007)(426003)(16526019)(26005)(83380400001)(316002)(70586007)(36756003)(6916009)(70206006)(4326008)(8676002)(82310400005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:26:12.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3143602-130e-46f9-1731-08da1984e0bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
    
    *Disabling Z10 on DCN31
    *Fix issue breaking 32bit Linux build
    *Fix inconsistent timestamp type
    *Add DCN30 support FEC init
    *Fix crash on setting VRR with no display connected
    *Disable FEC if DSC not supported for EDP
    *Add odm seamless boot support
    *Select correct DTO source
    *Power down hardware if timer not trigger


AMD\syerizvi (1):
  drm/amd/display: Disabling Z10 on DCN31

Angus Wang (1):
  drm/amd/display: Fix inconsistent timestamp type

Aric Cyr (1):
  drm/amd/display: 3.2.181

Charlene Liu (1):
  drm/amd/display: remove dtbclk_ss compensation for dcn316

David Zhang (1):
  drm/amd/display: implement shared PSR-SU sink validation helper

Dillon Varone (2):
  drm/amd/display: Add dtb clock to dc_clocks
  drm/amd/display: Select correct DTO source

Duncan Ma (1):
  drm/amd/display: Add odm seamless boot support

Eric Yang (1):
  drm/amd/display: undo clearing of z10 related function pointers

Evgenii Krasnikov (1):
  drm/amd/display: ensure PSR force_static flag can always be set

Harry VanZyllDeJong (1):
  drm/amd/display: Fix crash on setting VRR with no display connected

Hayden Goodfellow (1):
  drm/amd/display: Fix issue breaking 32bit Linux build

Iswara Nagulendran (1):
  drm/amd/display: Disable FEC if DSC not supported for EDP

Jingwen Zhu (1):
  drm/amd/display: add DCN30 support FEC init

Josip Pavic (1):
  drm/amd/display: do not wait for mpc idle if tg is disabled

Max Erenberg (1):
  drm/amd/display: Disallow entering PSR when panel is disconnected

Oliver Logush (2):
  drm/amd/display: Insert pulling smu busy status before sending another
    request
  drm/amd/display: Always update DPPCLK_DTO when clock increase

Paul Hsieh (1):
  drm/amd/display: Power down hardware if timer not trigger

hersen wu (1):
  drm/amd/display: expose skip_detection_link_training to debugfs

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 37 +++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  9 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  2 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |  3 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 17 +++-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  3 +
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 26 +++++-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 +++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 17 +++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 82 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 40 +++++++--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  6 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  5 --
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 21 +++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +
 .../amd/display/modules/freesync/freesync.c   |  5 +-
 .../amd/display/modules/power/power_helpers.c | 38 +++++++++
 .../amd/display/modules/power/power_helpers.h |  1 +
 25 files changed, 285 insertions(+), 61 deletions(-)

-- 
2.32.0

