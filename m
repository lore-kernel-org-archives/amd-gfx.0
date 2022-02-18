Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DF3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328BD10EE8B;
	Fri, 18 Feb 2022 15:04:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C6F10EE8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqloKLoQZg4WPZetOPYtCNz9WFr9U5fWreqA8hheDGfUos37qkj0JAE8nl0iBBcJZfJXK+RJoFlJAEMXgfsOLvDgojtUfoENrcnDa66CR394AKNVoUfaXGaMyjxHopBBMPSFUBWlCoABNalc612xk1oBdE8/bgcY9DFrEWCUJH5gcHNl+tz5O5v8xSDpBc7F67kD5D2M9n6Mt/QufYt3DiG8Ff18uRwf+f86+jRZXUWxvaERuKeOXQ0W+G0ZEKf0n8jO2yuWPFchKSPkMsc9TeQKW3QEQe4u8wWVlYsDqSJ/17wWB33pHcSIOdf3UTFKZCgXy175zzv9I83z6bIu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc8jeTyi+FiiZHD8UDXzeWs2evyeTuuA48b+xgd2YkQ=;
 b=VUF4H36NDRtRpfUJDuz77tx6fwY1xBygxvZiAznjBNacloQIjftlCqNaGiXL8zq/2yW3SsyZuigf7qbjEZS9ygTVhxsetT7FM434gRDkeYO4E1j7/MPhWOfX3ylbC1XG2qcn3Or2HN8+L6UrhkIWL0CZXzj85y39pCWjN3sJkqv0hQT3YZcYwJljXo0rCUup2O+O1/v03VlPUc+3OnlFfJz6SPoWJkcd5wsd7j0A8iN5YC9Gj7Mzm0JpzBFRMGrLQUOuIPi97JYmRBUKWs5aSY+PuLwMn4JsINkEaBO3IRbochzGRbBRrfJG7ejHwH7m3wZ/Iauql4N9bKDzttFfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc8jeTyi+FiiZHD8UDXzeWs2evyeTuuA48b+xgd2YkQ=;
 b=MNCNkJSMZKf84vXTchM3c2Ur7dUp34Zq0AXx9Nof17/fsUch8Goyx0mnNFTZfiVB4WefqOB2l3Uo+gF9sa6KCHms3NzvMBPW0D/y7G/9RrDPMecxdjA+uRcc3EIj+N33M/en/UpmDKp/uDg6uDcw3/P3T1WyBTwCln8RSC/WTA4=
Received: from DS7PR03CA0151.namprd03.prod.outlook.com (2603:10b6:5:3b2::6) by
 DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Fri, 18 Feb 2022 15:04:01 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::7b) by DS7PR03CA0151.outlook.office365.com
 (2603:10b6:5:3b2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:00 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:03:55 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches February 21, 2022
Date: Fri, 18 Feb 2022 23:03:17 +0800
Message-ID: <20220218150329.7976-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 147c6e24-d948-4b4d-1f25-08d9f2efe563
X-MS-TrafficTypeDiagnostic: DM4PR12MB5198:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51983B1F2CF56C58F144175697379@DM4PR12MB5198.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBavaeUO6fjbuljUlkrwHEHOdUYOJs9U0Kz05zc2JHCu8GQpZUIp9qJCABqxLKf3ZPoROKtbwWCazvDpBIpXBSHF0g/sc4k1gvIo4DJ9gaxltgLfPW8688lfQXNpPCB0lBy9DXZJWPxMzi+riDi1o+y7nRLWJyoTOD5TvxNV5UaORKQe6hkKf3Zx4aYYw1AxeGXwOSVuGbbVN434I2W0quRzZ2qnx+fKPBT8Krkd2EV/oW5E205yDt4Ic1CFfe/efaA9m3dg1SinjRlgfgp7/8ZcjHXIVCQcOqpjnUQaB9OqmVNs+bLLkHDTYLvuqLxMuZftguA0Llbzz+FpjaDuYokeQcpbeCDYSUqIxCegN0LsKii0uj386cShGLBNmsxpWoHiucsxE0amNA6NBYXKR9rihPMfVp8CT8y/x7r8bvkl2PVHcNeWUROU6ZnVxB4arZZ+E4PkWzXNUB33IrF8Ys49IhFFnrqezAjcLhX9oG63KOuJ0b3NhTmMQkzniMXOQv517LuWnhzEjcvIQwR+fXcQ5u/2lyW9oyV5bQZXn2Glg9yQBBmmVwjO92oWlLDqcGSAMjpMoAcW2IZw2k5it2s7HyX0BRZpXhaikPb3yAmchX61i/qgXanjqdkZJo7AOuLzDl9oqfcmVSrbEaAaLqUslrnZNCxwjmX410pyEMsYoML5XsdRsZYc24M8vfNqMFVwxsVBxDxUoJK2fDrQYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(4326008)(70206006)(508600001)(8676002)(81166007)(6666004)(2906002)(6916009)(54906003)(44832011)(1076003)(2616005)(426003)(83380400001)(336012)(70586007)(26005)(186003)(16526019)(7696005)(356005)(40460700003)(82310400004)(36756003)(86362001)(36860700001)(47076005)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:00.8126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147c6e24-d948-4b4d-1f25-08d9f2efe563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* add debug option to bypass ssinfo from bios.
* Refactor fixed VS logic for non-transparent mode
* add cable ID support for usb c connector
* clear remote dc_sink when stop mst
* Ignore Transitional Invalid Link Rate Error Message
* Fix wrong resolution with DP/VGA adapter
* Refactor PSR DPCD caps detection
* Set compbuf size to min at prep prevent overbook crb
* lock/un-lock cursor if odm pipe split used
* OVT Update on InfoFrame and Mode Management

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.105.0

Aric Cyr (1):
  drm/amd/display: 3.2.174

Charlene Liu (1):
  drm/amd/display: add debug option to bypass ssinfo from bios.

Chris Park (1):
  drm/amd/display: OVT Update on InfoFrame and Mode Management

Fangzhi Zuo (1):
  drm/amd/display: Ignore Transitional Invalid Link Rate Error Message

Ilya (1):
  drm/amd/display: Fix wrong resolution with DP/VGA adapter

Ma, Duncan (1):
  drm/amd/display: Set compbuf size to min at prep prevent overbook crb

Paul Hsieh (1):
  drm/amd/display: lock/un-lock cursor if odm pipe split used

Po Ting Chen (1):
  drm/amd/display: Refactor PSR DPCD caps detection

Shen, George (1):
  drm/amd/display: Refactor fixed VS logic for non-transparent mode

Wayne Lin (1):
  drm/amd/display: clear remote dc_sink when stop mst

Wenjing Liu (1):
  drm/amd/display: add cable ID support for usb c connector

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  58 +----
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |   2 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  22 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   3 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 230 +++++++++++++++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  11 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  32 ++-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  12 +-
 .../amd/display/dc/dml/display_mode_structs.h |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  44 +++-
 .../amd/display/include/ddc_service_types.h   |   1 +
 .../drm/amd/display/include/set_mode_types.h  |   8 +-
 21 files changed, 369 insertions(+), 113 deletions(-)

-- 
2.25.1

