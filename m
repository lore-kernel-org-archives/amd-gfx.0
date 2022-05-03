Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A08DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01A610ED6C;
	Tue,  3 May 2022 20:37:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132FC10EBE8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R82M/q+oxcBdzbvs0V01/fDwgYProTK3uJQYcOeusudSllWCdBx3UZQPHmNsPaQxIxKv1LS0zeX5a4TTnQZw9AL/7XNu7y2c5VgsvcQMXwg2KYek5Ap3tuNs5fC7UOxBlGR8jDlPbVqNxiJ8rTpmzGzYbXO/m1XYe+Md13qm8Ap7tiSMOkOplL8bvDiF0jUTInijVFIn1gQthlGHTXBTDa17bn/N+sr95TgvAvgrgz+tU2i0Bwmuks2QnDXGyE4W+g3O4Py/6CLjXcet/Pf0Kixa8aemdf0RTXbnWFFJqoCsainEziQ1+BEIlCu8DoQDeWWYBbhI6DU7/hLHgmlNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Unn7BBFZjLGFFet9dqbHy42mZ+Pg6P1djn2n7BD+szY=;
 b=EWys1tSgtpAw1c0Jr3U8G0JZRPhe1XIrqh8difvbW08v8MtRYch8VCRzwvDIqcWQT2EcjiRotd7XGIovQ7p/1S+4cEhQRhWv4/clmhdNPVFEMtRdVoBiWCVa2maaGZOKv4uoonG1wQ4qaok2WlRsrBuHzcphPNIXVJUecpF/Pv71Ovf7HEBnbh1hWztqVfARaoPLU3h6lWSBETF6lu3yARXBdAw/xauuM/4qQLDTdSr8+tJNlkos/nFn0CGn4lLNHXI/XH1ozlg8jFtD383pdBwd7cu1wYdUC6PH2jdpdUS/HxzqDXKLT83lWpIkhBgTu+W8yLMpvwIxubQ/HeGa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Unn7BBFZjLGFFet9dqbHy42mZ+Pg6P1djn2n7BD+szY=;
 b=n8f3qCiUnS2+6k++Xav3ECxYVFiXteTX9YaRGuh5sTQ/P//MA1EdET5Ssi7cVomcZ8w3/qIlEuWUmrl8ENXee8w5530z7ZrXeZRSqtgJ82BZi+zxTQSBHggLL3y/HujJxbdTMCY9Q8c6TOfcPGdLozSkGot8yOMs6ShQSr7u/fI=
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:37:30 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::77) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/26] SMU 13.0.7 Support
Date: Tue, 3 May 2022 16:36:51 -0400
Message-ID: <20220503203716.1230313-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46ee492c-0f61-4dc2-6785-08da2d44be1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2811C0D73BB470787A72A2D0F7C09@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWrvrRgKmYMKFsQ2r5AFUAY38A4PItu+vcOkMxeBAV5XIGGhvDTJA7O40fC9zQNQjVjwoDIcECG0qrjVZ5G66pakcW8ps/Ynu3tZMDQ9D4LLaAHvwF82+ghYqSkLSQOvpmgjQ4VSPaLkA2aDw6OZwAkAVCskRLOZq9NBbF/g30foKxC1w1dlykpS43nsQ4Cbg6GhbafUV06rlOzu281GKc0dYWfdTFfZun4XUYK0MBwGkneS+tVkIUoGpGO5s/lE6u2UogJvkS9kKmIsz+uXnLm8XWamu+YEt37PrLDtfb+IixA0ibt1FND0qAhuZIA9SmxAReuTmVHlBo35Jh1gdexuOfkG0XO1Qd/3u/60fuYsZwihvOGPA2ZzWzPAcyOP5vuErZvhy7gigxnlo7SSBvyqe6OwNiVyXXxcV+cLwheYsr+NijrbCN8eJZVTweJ7RufYux1yfiGInNKnTPTOdJbkW2Dj7+QnifS8J1YyxMQ5Q/v9qNjQNCKj0/7kOcKXfkEVznEJFZLRUtZlNClIdPV6dBHSY5BIgM04m4LhP8pubuV2An9jvJ4a2f+jkfgU0kNq5AAI9M/0JCVZesZP1QB8GgztnfYMIrCIsqLoAPYDStCjBjz8O0fPc0NpZ3gRTk95d3iJIKDfY5iSCeC47FInxWBuu91gy65XBN+WfYUDnlCpa8aaakmUlRC87HDPkLrRAFC7nPiiYz/iT1x1KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(186003)(26005)(47076005)(2906002)(1076003)(2616005)(426003)(16526019)(356005)(82310400005)(81166007)(40460700003)(86362001)(7696005)(83380400001)(36860700001)(508600001)(36756003)(5660300002)(8936002)(316002)(4326008)(8676002)(6916009)(70206006)(70586007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:29.5030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ee492c-0f61-4dc2-6785-08da2d44be1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
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

This adds support for System Management Unit (SMU) version 13.0.7.
This IP handles power management tasks on the GPU.  The first patch
is large headers to they were not sent to the list.

Chengming Gui (3):
  drm/amd/pm: add SMU_13_0_7 PMFW headers
  drm/amdgpu/swsmu: add smu 13.0.7 firmware
  drm/amd/pm: add SMU_13_0_7 ppt_funcs for SMU_13_0_7

Kenneth Feng (21):
  drm/amd/pm: support power on/off vcn/jpeg in smu v13_0_7
  drm/amd/pm: add features to smu_v13_0_7
  drm/amd/pm: add mvdd and vddio scaling in smu_v13_0_7
  drm/amd/pm: enable link dpm and link ds on smu_v13_0_7
  drm/amd/pm: enable mp0,vcn,dcn dpm on smu_v13_0_7
  drm/amd/pm: enable fclk,vcn ds and df cstate for smu_v13_0_7
  drm/amd/pm: enable platform features for smu_v13_0_7
  drm/amd/pm: add SCPM support in smu v13_0_7
  drm/amd/pm: update the features for smu_v13_0_7
  drm/amd/pm: pp_dpm_* interface for smu_v13_0_7
  drm/amd/pm:add UMD Pstate clock settings for smu_v13_0_7
  drm/amd/pm: enable pp_dpm_vclk/dclk interface for smu_v13_0_7
  drm/amd/pm: port the fan interface to smu_v13_0_7
  drm/amd/pm: add the pg_flag for athub and mmhub pg on smu_v13_0_7
  drm/amd/soc21: enable mmhub and athub power gating
  drm/amd/pm: enable gfx ds for smu_v13_0_7
  drm/amd/pm: enable gfx pcc and soc cg on smu_v13_0_7
  drm/amd/pm: pp_dpm_sclk change for smu_v13_0_7
  drm/amd/pm: enable workload type change on smu_v13_0_7
  drm/amd/pm: change the soft pptable id for smu_v13_0_7
  drm/amd/pm: report preDS gfxclk on smu_v13_0_7

Likun Gao (1):
  drm/amd/pm: add get enable mask function for smu v13_0_7

Yang Wang (1):
  drm/amd/pm: enable pmlog support for smu_v13_0_7

 drivers/gpu/drm/amd/amdgpu/soc21.c            |    4 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |    1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |    9 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |    4 +
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     | 1562 +++++++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |  134 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |    1 +
 .../amd/pm/swsmu/inc/smu_v13_0_7_pptable.h    |  200 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   11 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 1511 ++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.h  |   28 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |    2 +-
 13 files changed, 3463 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.h

-- 
2.35.1

