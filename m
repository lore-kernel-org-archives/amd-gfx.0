Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92179CD611E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A27B10E124;
	Mon,  9 Oct 2023 18:33:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E4F10E124
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7QOoFo6WQngKOwQmQHhONU+whkeuro3CGRe1RJ0aTWtOPWHkR4t1wekcftZd4buHwJknHHJkBv7gSRz+dlJePSgPDph/808NqHkxwqzTQYgwI47rXwYjHW06xTmTUr8/8I99H+98QxsZLyYhyDFIiu+siFXhWTdn5veqaqicj1+i1cxoOcV7S3MKBukDEOX6Sj4D7vQdkClB9/6WaZIXJkX8oaPAFrn24PDtVSF/v0igf6pKn+2UAQ77rqHsi6JsAc8sZ117nJdWtWhMsL32curDyIFXb3evTtFAt8p/IZ7TM0ZQ5pcPENxrTlmYkrEymNK91qqGVqkiW71r60LNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7bdcE78dqTfTRfMJelr768P56uL+zZfy8rNIHgdl04=;
 b=cZZDCHscQt7YrZojyiSrqaJC4fLzANsJRUZsu8gukkcJkganTj++aTtchq4ln5wapn5Vh6vq2jdEIgGHpS6BPtPyV3Yriyp6v0ylDY9V2xefOV3P0qTIs2rqJvgD8qISzZCs06jitdJtrh44KUncGZnLKnSKKSwVRzyFQR9o8BRHMlIq4S3j6X2nagCPbEeDB2eaYBcnQP5Zsjt2o7SkrSyXWdF0CirwCg67xaAQMgrxaaFB4NqMXArwBujD9qSYrE7u1iKAZFEujZJYY0+zbFlvtF0eg1p7xakD2KfPyWiKYXUQQM0Np1cBTwUzgAH79KBQxuE3IO0AED2wugm/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7bdcE78dqTfTRfMJelr768P56uL+zZfy8rNIHgdl04=;
 b=pXly5QtfOLgi8AFFMTorv1snXCJmwrFPGr5eMrhsqARf7goNjjgBgx95Ib1ErFq5CbwhqVhEpfl9xGvEK9I578g+5qDpdn6P04NGniEbjciXGUq95Azt2XdpSkbGOfpphF1JsZC7qiRSb1Y4CNGUf399evCPvActPQlaDJSYztI=
Received: from BL1PR13CA0343.namprd13.prod.outlook.com (2603:10b6:208:2c6::18)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Mon, 9 Oct
 2023 18:33:06 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::25) by BL1PR13CA0343.outlook.office365.com
 (2603:10b6:208:2c6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 18:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:33:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:33:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] Add SMU 14.0 support
Date: Mon, 9 Oct 2023 14:32:29 -0400
Message-ID: <20231009183234.518379-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b9d239-043e-4e64-5a61-08dbc8f62e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxBRQfjXB3n7tvf3D9osNeDeMoukDhGzwMawzAqypjWb/8Cpk2BjYQJNm/rVra9q2hqleMwKXY1zM995piI5gomPHaZ0BSNgyvNg+44xWkmBzZrFaSOz5uPp+khCwjTr61ZVCqA4P3iKnFYh8ARrz7npySI9TyKNf3lsEAq7aIXsps/MzvlngDeIjaEpBnIhf+/KRSYPP5h7Go8FEuUGml0qV/vPPuID6+1hVW09cCdgseWKXhuDU+DfFlfeJSU4BSgoDoBZ1jPB9XE02co6w8PxXkiFKwyCK69sWjZJtamSrUvsrOFVQ+5xYQMh+goe3yYacG78uC6I4+V4CaQbUdU5eR7FXqqFdKmceVjGvfBn9Q5NBOeNqZaDCLp6wxQYdiEA+UjHB3YZ8bKqKbxsVHmX+KCnua2FGcGsKGbGrcxUclI1MVjnckM+cqDQXafq7prZKDQ9Cx8RxVx9Qd9/OkbGr6n17kmkUnauD1Bty9DugK5TW2cUQKxl1COBYiXOOg/2Znyk6jzvVvfSOa2NPtfszNSn1APtOGcTFOS1LCpYZduPx3Xkbw+q4akxC6uhPdJ0D4td0Oq7nFq1nbWynDBSDxQaUHfeeIBWPpOeqZ5rW7LqoQzCsNpASBRPfD3c+ov/WZLWqnFdSMDX3w3OqV430XxvsBhpArre/8xqsfP1YoVRC0hkv7kl+wwA7E6fmzHAZSedvKurvjJoeOrNYv5MOtk8PvFsE+b5qIGr5vTVI4uEC3sFbzdGhNGtAGHGLZ/64Oaqc/cfMX+DPxzReg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(5660300002)(2616005)(316002)(70586007)(40460700003)(6916009)(41300700001)(70206006)(26005)(426003)(16526019)(336012)(36756003)(7696005)(40480700001)(83380400001)(6666004)(356005)(82740400003)(478600001)(47076005)(36860700001)(86362001)(1076003)(81166007)(4326008)(8936002)(8676002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:33:06.1873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b9d239-043e-4e64-5a61-08dbc8f62e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
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

This adds support for SMU 14.0 support.  SMU is
the IP block which runs PMFW and manages power
for the GPU.

Kenneth Feng (1):
  drm/amd/swsmu: add smu14 ip support

Li Ma (4):
  drm/amdgpu/swsmu: add smu v14_0_0 driver if file
  drm/amd/swsmu: add smu v14_0_0 ppsmc file
  drm/amd/swsmu: add smu v14_0_0 pmfw if file
  drm/amdgpu/discovery: add SMU 14 support

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    3 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |    1 +
 drivers/gpu/drm/amd/pm/Makefile               |    1 +
 drivers/gpu/drm/amd/pm/swsmu/Makefile         |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   12 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    6 +
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     |  281 +++
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h   |  156 ++
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h  |  142 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |    7 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  230 +++
 drivers/gpu/drm/amd/pm/swsmu/smu14/Makefile   |   30 +
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 1727 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 1078 ++++++++++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.h  |   28 +
 15 files changed, 3701 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu14/Makefile
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.h

-- 
2.41.0

