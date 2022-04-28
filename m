Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844E9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8FC10EB95;
	Thu, 28 Apr 2022 21:34:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BED10EB95
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE6DzrE774jq2/cMfRINGApp/AYf/xD1mahKGybWqlIl/gln3Ud24HOlRtaVkmBkBsepEV5obaLCbZu3Z9rjuLmiOMVBeh4e0sOisfMj4qo6Xui/R1cEOMSdviDn0h25bwYhhE6FL4XFPreOIzb8ZUkK2uZSG4h8j0iWePnwI0kCr5o+46mLQt4d7X63PQCEGEt/R4KiTvWapZgppggSSw1hNsGuHYFixdSZLL5PGkYO3+dbwiE8LoONvIsyGnVksG5Qw11JoSH8quAUTZD+2BZUHxKark+MvmUraxYkitSgvcBF/1+Qnkf7aGqi1L5ON58VUq1y58JLPznGR+IepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWRDfobQP+TyjJ7cwMXWdFFNZmyCFpZtcIbBhIWZVsU=;
 b=V/XF0TTA9HIbtUx3O4CvTwnOny54RQdC0omGlo+N8BET+6ExtpPdpwj0zdYdGvT+vB7APuVRnOigdESUVU7IO+EOswireQbArFejq9A29xjQSx0dQhdubwpnlRAaXt5duAu9PE/xddmVuGVFHdT2DDOVv4CZMDMb1/c/ifzXHwDIT3AIlsJNDv0nQk7PriVfBr7voykjBISOnWCHQYu1tQ3UiNXpKGbwgXnEx2IJJmrOz2no880u92JpVJfoFVqMLFEESNsmjkbvvsxGdjbO8X6F7hesWAWVAposh9IYlGhs/Tkwl5aj8zBdXUMr0kMJmC8YsuikqNrJPJpuOs7b1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWRDfobQP+TyjJ7cwMXWdFFNZmyCFpZtcIbBhIWZVsU=;
 b=BbWBY0PvNthNYQX1vAKIqlenoGkfHlOLIUMd3YmHfx0G2SazF/QjovkKPUQknz41wjTvPu4YRBNpyboFzJB76+2QUPFQTGcYrTX4fIj5RAtYSDFwHvZs+1bc72yoFLXBl/fQx3d2zIc2LE7Bw1syVYJNtp4+kow7oMok9RSvhhU=
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by DM5PR12MB1371.namprd12.prod.outlook.com (2603:10b6:3:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 21:34:48 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::54) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:34:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:34:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Updates to SMU13 support
Date: Thu, 28 Apr 2022 17:34:24 -0400
Message-ID: <20220428213427.700543-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c696129-ed5f-4c91-2242-08da295ee9dd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1371:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1371B0A4CD31900A2D31A140F7FD9@DM5PR12MB1371.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAU9UgPh075RuN9ubdXAdLmRVa1v4bsdix8I29OnrpRQrs4DOq3A9CBxTzSMikeI7770C51FIGXtpM1TJg70Mr5CC3RteYtuPXDBLtv6JG/AjfSQ7pBrZm/eFZwQsORHISsDosiHFhCqU76bN0EOucyVLkTfYj3ng59l3tVo1qmG0p7xrT/PrS/QPyda71K17KvaMpXem2xnWRPoVl07hk9fMcWneqn5oxoOtU1Fl1mb01myaGLDIAwjAeP0ioT2DpZTKQXuaEAwvB6/8xsOOidcQdxBySzDGCaUTNzOLxThF2kdHDQty0ppL0MNsca+EVUQev2q7JEvEN1GmQ5RM2FgtPNVZEIdm933W8DpB2Em5vLo/N94OJNoR8yudG8eRpiMq/UgxOFJKWncGXtcb0LdodyLa1zIAKUZK51ryqMVHIZAoiIHFo3hC06982Peven3mCBR6KUZFB3YNhnCi3SOnGn4W2a4XksbhdVKKlwuvcikxInvcH5QRe7lj4N1N4m7nPuwhlolICr5UGNFFhJ5nQ1hF5XR3laKCc5yW0phRfxazA0+xGKqqy9m/Zbjw9sdNTdbe4Aq8JvcPkDB/kf5hspV/AEn4pSRPEpu9l6q4V+NyPGNvvWTzRJJIC5ZSnPj7g1CBBnW0Z4XH5h7sqDJjCQEZHDlCm7P7sYsy/pi7ebN3Gr97HKjBLxzh71u1wWdCuAQ0stcjwwpawhUkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(26005)(83380400001)(316002)(5660300002)(36860700001)(8936002)(47076005)(426003)(6666004)(336012)(186003)(16526019)(36756003)(2616005)(7696005)(1076003)(508600001)(6916009)(82310400005)(2906002)(15650500001)(356005)(40460700003)(4326008)(8676002)(70206006)(70586007)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:34:45.1719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c696129-ed5f-4c91-2242-08da295ee9dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set add support for new SMU 13 versions.  SMU is the System
Management Unit on the GPU.  It handles power management and other tasks.
Patch 1 is new header files and is potentially too big for the mailing
list.

Evan Quan (2):
  drm/amd/smu: Update SMU13 support for SMU 13.0.0
  drm/amdgpu/soc21: enable ATHUB and MMHUB PG

Likun Gao (2):
  drm/amd/smu: add smu v13_0 header files
  drm/amdgpu/discovery: Enable SMU for SMU 13.0.0

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |    3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |    1 +
 .../gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h  |  200 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |    4 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    6 +
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     | 1544 +++++++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |  141 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |    2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   29 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |    2 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.h    |    8 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  321 +++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 1367 +++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.h  |   28 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   11 +
 16 files changed, 3617 insertions(+), 51 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
 create mode 100755 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.h

-- 
2.35.1

