Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937B4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6D710E07A;
	Fri, 25 Mar 2022 22:54:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1438D10E07A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifPWSuutihxxAHkaX9kojZk1cCv1vjzOvqO6+diH73z61tn5s0gdsy6YJafOlueJ/VIomQV3JfW/4y5j2V5MqayluN9Et4+s/Jyhq4F4vNFFAk6yMc1WZ7MYskkIOfyOjQwAqZ5a4DJlHHehP4mgthYNZqbKevc81JG6kjh3v4lf+cAsQw9ioDbjrxfKtNxEnwLKNDkUb9sWznPmm/MPaleclsynSSAT31fn00IyDVtcwKec9GPpHVS7r8bWc5PCj1GWe/z45rv9WYDDs1+pUWr5Xs3pXLGQMvcWo7XQ6ChbNKMKMwBcUL5KFL/Gic/MtY/t/UOB7N8T0vqdEOoTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiOb+XQ5G0jhrRi6+vhJJkP3PfVyHwCs6WEeaDdEt88=;
 b=ngpeadHHyYECBlFEOqCpa7lBQdXHTtk56JjDdJtRPVXemejIdMXv4d5eAPkWuGrdchLc+e67pGEGm22mpmdgdd1IMmaA2MsUKM5fbmXsRrP5/+U9BdHYmPNxUYiF0FbCz1PK+EHKgOK+dgf8quiPaVSpbKyHCObRa2FIWtEQDwzK8tk/r4Ou26Wssbfuv8wAOsxJAryqs4wxr8pgLg+XbgvBVv4yMh/WtcH3JNL2NZbzjtYfGkIlye9bMxYIEMCpnxecok3x46baT1gpGrFsmY9Hqu0bkDqH2U6tFomoe+bQXuIuzJNKVjwzLwev0oBMpJEkgXEZCHDZudZYJiMqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiOb+XQ5G0jhrRi6+vhJJkP3PfVyHwCs6WEeaDdEt88=;
 b=NURL+S4WMtjjwQeaHjIyPO5YOknzwsiENy+LsiYJvhOSwSxd1Tm8LTtN3P1EQS48LTBW7c58igR85A24TvovTVLAsXmobcjGsTIwJoX4dxw69Syc4uLQknmIF8+G2RrgQQr/Q+nlVZnVja0Z1MRSEyZDIyoG8AhrLsvf1IInTN4=
Received: from MW3PR06CA0024.namprd06.prod.outlook.com (2603:10b6:303:2a::29)
 by BL0PR12MB2531.namprd12.prod.outlook.com (2603:10b6:207:3f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.21; Fri, 25 Mar
 2022 22:54:46 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::9c) by MW3PR06CA0024.outlook.office365.com
 (2603:10b6:303:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Fri, 25 Mar 2022 22:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:54:44 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:54:42 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches March 25, 2022
Date: Fri, 25 Mar 2022 16:53:46 -0600
Message-ID: <20220325225402.469841-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b831d854-7755-425d-a46b-08da0eb274a7
X-MS-TrafficTypeDiagnostic: BL0PR12MB2531:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2531C7CF151C05463EFB0DDAF71A9@BL0PR12MB2531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yr9IdGCqPGosqkXbxRj/HX3ATk33pyOc/pVU1GAkreBfHTQy+Zv64SgRfBVGLGkMFWQj7noCljedI1eAuh85eR3eyzjyPI1aidZtluGHEg5pmUgY8LhCGBCLNlvkvIaWBhPVQ49h5wGBMn0hORD7jncIWVj6HwNsapDQW6Fn+1hkpBSvM1JHINlvsrLH8I3EmpKI5qCB/CFkW+zMt1PC5qhxFRLfr2d8v+11O+DXUwZ1EtmkD07vAdH8iWSK3yEdZ00d6Ey3R1eiL4EJHCGe8J3caWa/Syr+EX6VCI+lPTLBaDu1RIrAHf1FW6icrycP5lDRyi90Tb9PoWn0z3PcQlRT6hMbegR6PMGDFRGB8AuRGS4trE1rEMqSZIDs5sXTEn2P3lSko+JRH71c4udU1UkfUTLghv3857TUj+1jPU7M6sbU/6ZMqAlPAD32B80H+lRu3SlO+VXN8lXgxn6sKeUvV9Y6qz0aO9U5A5SjXDFhvlngFjdJs5N0l4YOGvzD1WsNAtDeoEJbihLVzS1LnWyV4qPFg2uh4fr8v55/BsohTUJH1VcAYIwKwvqIedAMPgb0GdQTcmyJwuYjhRNusOAJFG9QS3UI6Ro+NbFFrXb3MHyFPAhEgvFt6nk73jVSuFXGv55stZLXY8pjgHM/aDUp4QemVqLzcEDRAbte63RGgYnc7/ORyOD1mPELucvcdw8U+2n5eUNWjlwAf2UZBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(44832011)(7696005)(83380400001)(8936002)(40460700003)(26005)(36756003)(2906002)(16526019)(426003)(47076005)(336012)(186003)(1076003)(36860700001)(2616005)(82310400004)(54906003)(6916009)(316002)(508600001)(356005)(86362001)(81166007)(8676002)(4326008)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:54:44.8426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b831d854-7755-425d-a46b-08da0eb274a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2531
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fix allocate_mst_payload assert on resume
* [FW Promotion] Release 0.0.110.0
* Revert FEC check in validation
* Update LTTPR UHBR link rate support struct
* Add support for USBC connector
* Add work around for AUX failure on wake
* Clear optc false state when disable otg
* Enable power gating before init_pipes
* Remove redundant dsc power gating from init_hw
* Power down hardware if timer not trigger
* Correct Slice reset calculation
* Enable 3-plane MPO for DCN31
* Set fec register init value
* Remove SW w/a for HDCP 1.4 1A-07 failure based on ECO fix
* Create underflow interrupt IRQ type

Angus Wang (1):
  drm/amd/display: Create underflow interrupt IRQ type

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.110.0

Aric Cyr (1):
  drm/amd/display: 3.2.179

Charlene Liu (1):
  drm/amd/display: Clear optc false state when disable otg

Chris Park (1):
  drm/amd/display: Correct Slice reset calculation

Jimmy Kizito (1):
  drm/amd/display: Add work around for AUX failure on wake.

Jingwen Zhu (1):
  drm/amd/display: Set fec register init value

Krunoslav Kovac (1):
  drm/amd/display: Enable 3-plane MPO for DCN31

Martin Leung (1):
  drm/amd/display: Revert FEC check in validation

Michael Strauss (1):
  drm/amd/display: Update LTTPR UHBR link rate support struct

Oliver Logush (1):
  drm/amd/display: Remove SW w/a for HDCP 1.4 1A-07 failure based on ECO
    fix

Paul Hsieh (1):
  drm/amd/display: Power down hardware if timer not trigger

Roman Li (3):
  drm/amd/display: Remove redundant dsc power gating from init_hw
  drm/amd/display: Enable power gating before init_pipes
  drm/amd/display: Fix allocate_mst_payload assert on resume

Samson Tam (1):
  drm/amd/display: Add support for USBC connector

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 .../amd/display/dc/bios/bios_parser_common.c  |  3 +
 .../drm/amd/display/dc/bios/command_table.c   |  3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 26 +++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 34 +++----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 59 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 18 ++--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  5 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 25 +++---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  5 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  6 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |  3 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |  3 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  4 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 90 +------------------
 .../drm/amd/display/include/grph_object_id.h  |  1 +
 21 files changed, 155 insertions(+), 143 deletions(-)

-- 
2.35.1

