Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B686C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC80E89316;
	Thu,  2 Dec 2021 03:43:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB4989316
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3C+gFGQC/fn7wlNuf3T9JsUbMWY0fOHzYALu635uhtqRgvphqYYO4rOBH8SFe1l5z8awSDjAuQFAQk7xXy3ugDlZgXn0yqZ6n5Gsv7EXn9jKgMxou4TXgPTAKKSbqihm9HykjxcECnqmiKoVpTOe152/vjBYvEa+RxeXkSMZBrpko5H1gi8rGFJRqNJF5fZ8RnSkv0CSApqpfpIZLXMJxIIlRyWZh1ldOfCWmKujjlmTCkfkzf3jdrEtzjiFZ4Mdchyhe7I83n/yCe66nEk3ToKAILtOJeH2XUrIBoEklUYJA2VZ+dzFmBLJqcXAzRMJ7w1yEdQi7NxoeCqSGHEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DHV8ePH3lj7vBhtKP6k1XzgKTpaA7KM57k8/TlLYl8=;
 b=VpbCvhMLNc1RJ2RDvGYSuPYI4E7w1iGOc3cR+EIfPHPfKp7RkvEO/cSpwwFGpH7la0oR1hFyLnd7s92AuxHf/dt06CTO3OVAZsoDFba/JuFYpoQeZdMLgu1xnNN9GuKLl9EbFy9Xg/dOV6xjdIje5p36wLuicKgfDMi+oP236Tcz8YOO9jm5LU4Tdhggzpu7EnrJZg66WetVxLmBQW75q9G2P3KG+nAKbeozz9KUPh7sjK+wHsK4vj2bgkTqz/Gi6N6CIF7+BQ0LhdPO3mTviAB3TQx2yxF7dNgj/7suQglDjRo1B0VYEG3qThYD1JeI755c0GbJLpUSZNlPV+1HPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DHV8ePH3lj7vBhtKP6k1XzgKTpaA7KM57k8/TlLYl8=;
 b=2DiNu7To8zRrFnwXZuhme2ouu/cbzNScjYdDvbIvQ9/3uDrCPtBfc1gHzndY8dv/qX6IV8Lso2hEToR9BZVhsu1zgCJpkTYpjSvnbj0RForkls8VkPj95JH0nnq6kbpLBbpZrQFSNiKji1tTDNJDOPWupN68H84B+oN7Zcw0k74=
Received: from DM5PR08CA0052.namprd08.prod.outlook.com (2603:10b6:4:60::41) by
 DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 03:10:31 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::6e) by DM5PR08CA0052.outlook.office365.com
 (2603:10b6:4:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:30 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:28 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 14/17] drm/amd/pm: relocate the power related headers
Date: Thu, 2 Dec 2021 11:09:27 +0800
Message-ID: <20211202030930.1681278-15-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0abdb231-cd6a-48a9-a1d5-08d9b5414c84
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52147651CF8C278A4CF07BAFE4699@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dMkXYdU5PiPw+4foJn7MPkZIrOK9BYgejb0R6wlZkK5ADT62BJQx4DYEr/AgW4vrv4Nv9c7J5eikw5sDX3sKhJKTmfpxZlK4XcziB4PIahV88YeZSJssuEQde2tzs/EREybC0rmsfDMr7nkA6XclG/+kIXhJOQ+9Y1ZcXc1C22a7bJCTNTHXrCtN01cX9dwlYQrWkznNvuP5bbnG94CzS2RyjWufoCMY+vbpGLxCa85rtNHLBGAkR1Xhxde8nDG20Z+ShrvXpaD0B0NK/fOhlsR6NvxshiU4EoYXxOKHLawzdtxwX9F3G5CDO0ZHpvvXZi3EorTHXorh9IsB1tHIMldbKWQMEmXbNky2CsmKXYWxitBiz8ICmih+6iYzIUKNYich8MWksYyKHuRG/BaoGxINq2OHtKuBzRNTRCbqscaEZGmHxkryqemzWz0kO4Eft14H01Ad5O/i36qbB6+rjdnT64uX/5Z8p6aXm3g96BLQ+kbJDxAZiWjUaT+gTp2qlEapYNHRTZAMeoc6b+YSP3QGadeIYgrGd8Mjdm+DOhiCezZNKjhUfuH+p/e0YvpANsBsXDCy4c3fE50fusduuGKkfLP6sZ95bvsH8RUy1vYrkZot9kga1PSO4clkUfU+mAoQnHEKU9y9LvL3ud1cKmgKj0AqZjcyZvxgB5pLCEZ5TDf4ln0eIViYCYZT4F5+z/vweG3xVLfm4b2PrIY8VzZ2gACCgjGzvPAomnV4tNdbITkVlWcd84ju/oWP0mjKU9hnDAxgcDELmMITg9FJZ90j7LJxHL5AENtcSmnK8Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(6916009)(47076005)(336012)(186003)(508600001)(54906003)(2906002)(316002)(30864003)(86362001)(8676002)(70206006)(5660300002)(8936002)(83380400001)(7696005)(2616005)(82310400004)(356005)(36756003)(426003)(81166007)(36860700001)(4326008)(44832011)(40460700001)(26005)(70586007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:30.9994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abdb231-cd6a-48a9-a1d5-08d9b5414c84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of centralizing all headers in the same folder. Separate them into
different folders and place them among those source files those who really
need them.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Id74cb4c7006327ca7ecd22daf17321e417c4aa71
---
 drivers/gpu/drm/amd/pm/Makefile               | 10 +++---
 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    | 32 +++++++++++++++++++
 .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |  0
 .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |  0
 .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |  0
 .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |  0
 .../pm/{powerplay => legacy-dpm}/legacy_dpm.c |  0
 .../pm/{powerplay => legacy-dpm}/legacy_dpm.h |  0
 .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |  0
 .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |  0
 .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  0
 .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |  0
 .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |  0
 .../{powerplay => legacy-dpm}/sislands_smc.h  |  0
 drivers/gpu/drm/amd/pm/powerplay/Makefile     |  6 +---
 .../pm/{ => powerplay}/inc/amd_powerplay.h    |  0
 .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |  0
 .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |  0
 .../pm/{ => powerplay}/inc/hardwaremanager.h  |  0
 .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |  0
 .../{ => powerplay}/inc/polaris10_pwrvirus.h  |  0
 .../amd/pm/{ => powerplay}/inc/power_state.h  |  0
 .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |  0
 .../amd/pm/{ => powerplay}/inc/pp_endian.h    |  0
 .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |  0
 .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |  0
 .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |  0
 .../pm/{ => powerplay}/inc/smu10_driver_if.h  |  0
 .../pm/{ => powerplay}/inc/smu11_driver_if.h  |  0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |  0
 .../pm/{ => powerplay}/inc/smu71_discrete.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |  0
 .../pm/{ => powerplay}/inc/smu72_discrete.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |  0
 .../pm/{ => powerplay}/inc/smu73_discrete.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |  0
 .../pm/{ => powerplay}/inc/smu74_discrete.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |  0
 .../pm/{ => powerplay}/inc/smu75_discrete.h   |  0
 .../amd/pm/{ => powerplay}/inc/smu7_common.h  |  0
 .../pm/{ => powerplay}/inc/smu7_discrete.h    |  0
 .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |  0
 .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |  0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |  0
 .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |  0
 .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |  0
 .../pm/{ => powerplay}/inc/smu9_driver_if.h   |  0
 .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |  0
 .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |  0
 .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |  0
 .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |  0
 .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |  0
 .../inc/vega12/smu9_driver_if.h               |  0
 .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |  0
 .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |  0
 .../amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h  |  0
 .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |  0
 .../amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h   |  0
 .../inc/smu11_driver_if_arcturus.h            |  0
 .../inc/smu11_driver_if_cyan_skillfish.h      |  0
 .../{ => swsmu}/inc/smu11_driver_if_navi10.h  |  0
 .../inc/smu11_driver_if_sienna_cichlid.h      |  0
 .../{ => swsmu}/inc/smu11_driver_if_vangogh.h |  0
 .../amd/pm/{ => swsmu}/inc/smu12_driver_if.h  |  0
 .../inc/smu13_driver_if_aldebaran.h           |  0
 .../inc/smu13_driver_if_yellow_carp.h         |  0
 .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |  0
 .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |  0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |  0
 .../pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h    |  0
 .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |  0
 .../amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h  |  0
 .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |  0
 .../amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h   |  0
 .../amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h  |  0
 .../amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h   |  0
 .../amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h  |  0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |  0
 .../amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h  |  0
 .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |  0
 .../amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h |  0
 .../pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h    |  0
 .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |  0
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
 87 files changed, 39 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/cik_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/legacy_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/r600_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c (100%)
 rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/sislands_smc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/amd_powerplay.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hardwaremanager.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/polaris10_pwrvirus.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu11_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_cz.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_vi.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12/smu9_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_arcturus.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_cyan_skillfish.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_navi10.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_sienna_cichlid.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_vangogh.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu12_driver_if.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_aldebaran.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_yellow_carp.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h (100%)
 rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)

diff --git a/drivers/gpu/drm/amd/pm/Makefile b/drivers/gpu/drm/amd/pm/Makefile
index d35ffde387f1..84c7203b5e46 100644
--- a/drivers/gpu/drm/amd/pm/Makefile
+++ b/drivers/gpu/drm/amd/pm/Makefile
@@ -21,20 +21,22 @@
 #
 
 subdir-ccflags-y += \
-		-I$(FULL_AMD_PATH)/pm/inc/  \
 		-I$(FULL_AMD_PATH)/include/asic_reg  \
 		-I$(FULL_AMD_PATH)/include  \
+		-I$(FULL_AMD_PATH)/pm/inc/  \
 		-I$(FULL_AMD_PATH)/pm/swsmu \
+		-I$(FULL_AMD_PATH)/pm/swsmu/inc \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu11 \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu12 \
 		-I$(FULL_AMD_PATH)/pm/swsmu/smu13 \
-		-I$(FULL_AMD_PATH)/pm/powerplay \
+		-I$(FULL_AMD_PATH)/pm/powerplay/inc \
 		-I$(FULL_AMD_PATH)/pm/powerplay/smumgr\
-		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr
+		-I$(FULL_AMD_PATH)/pm/powerplay/hwmgr \
+		-I$(FULL_AMD_PATH)/pm/legacy-dpm
 
 AMD_PM_PATH = ../pm
 
-PM_LIBS = swsmu powerplay
+PM_LIBS = swsmu powerplay legacy-dpm
 
 AMD_PM = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/,$(PM_LIBS)))
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
new file mode 100644
index 000000000000..baa4265d1daa
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
@@ -0,0 +1,32 @@
+#
+# Copyright 2021 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+
+AMD_LEGACYDPM_PATH = ../pm/legacy-dpm
+
+LEGACYDPM_MGR-y = legacy_dpm.o
+
+LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
+LEGACYDPM_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
+
+AMD_LEGACYDPM_POWER = $(addprefix $(AMD_LEGACYDPM_PATH)/,$(LEGACYDPM_MGR-y))
+
+AMD_POWERPLAY_FILES += $(AMD_LEGACYDPM_POWER)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/cik_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/cik_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/kv_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/kv_smc.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/kv_smc.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/legacy_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/ppsmc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/ppsmc.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/r600_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/si_smc.c
rename to drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
diff --git a/drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h
rename to drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
diff --git a/drivers/gpu/drm/amd/pm/powerplay/Makefile b/drivers/gpu/drm/amd/pm/powerplay/Makefile
index 614d8b6a58ad..795a3624cbbf 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/Makefile
+++ b/drivers/gpu/drm/amd/pm/powerplay/Makefile
@@ -28,11 +28,7 @@ AMD_POWERPLAY = $(addsuffix /Makefile,$(addprefix $(FULL_AMD_PATH)/pm/powerplay/
 
 include $(AMD_POWERPLAY)
 
-POWER_MGR-y = amd_powerplay.o legacy_dpm.o
-
-POWER_MGR-$(CONFIG_DRM_AMDGPU_CIK)+= kv_dpm.o kv_smc.o
-
-POWER_MGR-$(CONFIG_DRM_AMDGPU_SI)+= si_dpm.o si_smc.o
+POWER_MGR-y = amd_powerplay.o
 
 AMD_PP_POWER = $(addprefix $(AMD_PP_PATH)/,$(POWER_MGR-y))
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amd_powerplay.h b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/amd_powerplay.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
diff --git a/drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/cz_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/cz_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/fiji_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/fiji_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/hardwaremanager.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/hwmgr.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
diff --git a/drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h b/drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/polaris10_pwrvirus.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/polaris10_pwrvirus.h
diff --git a/drivers/gpu/drm/amd/pm/inc/power_state.h b/drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/power_state.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h
diff --git a/drivers/gpu/drm/amd/pm/inc/pp_debug.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/pp_debug.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_debug.h
diff --git a/drivers/gpu/drm/amd/pm/inc/pp_endian.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/pp_endian.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_endian.h
diff --git a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h b/drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/pp_thermal.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/pp_thermal.h
diff --git a/drivers/gpu/drm/amd/pm/inc/ppinterrupt.h b/drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/ppinterrupt.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/ppinterrupt.h
diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/rv_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu10.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu10.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu10_driver_if.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu10_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu11_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu71.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu71.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu71_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu71_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu71_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu72.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu72.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu72_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu72_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu72_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu73.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu73.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu73_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu73_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu73_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu74.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu74.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu74_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu74_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu74_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu75.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu75.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu75_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu75_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu75_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_common.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7_common.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_common.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_discrete.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7_discrete.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_discrete.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7_fusion.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_fusion.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu7_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu8.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu8.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu8_fusion.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu8_fusion.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu8_fusion.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu9.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu9.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu9_driver_if.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_cz.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_cz.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_ucode_xfer_vi.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smu_ucode_xfer_vi.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smumgr.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/smumgr.h
diff --git a/drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/tonga_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/tonga_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/vega10_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega10_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/vega12/smu9_driver_if.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12/smu9_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/vega12_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega12_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h b/drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/vega20_ppsmc.h
rename to drivers/gpu/drm/amd/pm/powerplay/inc/vega20_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/aldebaran_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/aldebaran_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
diff --git a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/arcturus_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/arcturus_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_arcturus.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_arcturus.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_arcturus.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_cyan_skillfish.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_cyan_skillfish.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_navi10.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_navi10.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_sienna_cichlid.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_sienna_cichlid.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_vangogh.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu11_driver_if_vangogh.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu12_driver_if.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu12_driver_if.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu12_driver_if.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_aldebaran.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_aldebaran.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_yellow_carp.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu13_driver_if_yellow_carp.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_11_0_cdr_table.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_11_0_cdr_table.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_types.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_7_pptable.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_0_pptable.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_pmfw.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_pmfw.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_5_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_pmfw.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_pmfw.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_8_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v12_0_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_pmfw.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_pmfw.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_ppsmc.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_1_ppsmc.h
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
similarity index 100%
rename from drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
rename to drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a03bbd2a7aa0..1e6d76657bbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -33,7 +33,6 @@
 #include "smu11_driver_if_arcturus.h"
 #include "soc15_common.h"
 #include "atom.h"
-#include "power_state.h"
 #include "arcturus_ppt.h"
 #include "smu_v11_0_pptable.h"
 #include "arcturus_ppsmc.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 3c82f5455f88..cc502a35f9ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -33,7 +33,6 @@
 #include "smu13_driver_if_aldebaran.h"
 #include "soc15_common.h"
 #include "atom.h"
-#include "power_state.h"
 #include "aldebaran_ppt.h"
 #include "smu_v13_0_pptable.h"
 #include "aldebaran_ppsmc.h"
-- 
2.29.0

