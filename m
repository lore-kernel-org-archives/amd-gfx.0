Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDA4C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 16:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C0310E44A;
	Wed, 17 May 2023 16:13:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAF010E19E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 16:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6w53wl1ufe2oe5KiqFRsl/XTCCVELAzGAIbU4ybMAao2P/hIbP6tPIVlvxii1h3v9xxdSZ2eTKg+n3D6CbF2JRbGiLSNUftrZRjKQ6Xzxk/uXHUJXS52aUMrOnQwYW61qbZSZsMkGZ2r2MUkQiTEQxYRw7OUO1eHD17eMeQ6l51FgiOa582IWB3ue5dzfH5iF1sNIgAKSkfo0kJPUojOKhDaT7OZ9sAnxoe4FGniQ3kA1Zyy3yHhcTDYLum0dD7X7cXZm/qFPk3J1lZPjmgfghVaN6jMDW01ngASOV09HJ7obQRO+876OBYytJM9mrhXVBlKhXO9R5t7w1nh/0vpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCYnHK4BYgUIRbWWgJ7WjNC//fJHzLclgJ3lhF7YlxE=;
 b=RmxGGY9SkmKZ85LfGCmx9qjlRN1UJHjkCr0ZuyveO4fuK5ApUW0pZYeXKfMNUW6KBwgeX9q0Z37zHduGHLZMboXSrNqthnr0uKtjN8bxDRKMpFOFN3utEpcEY6fFoB5sLdAnesafd5AK5neCYTA+xqMBy49AzKTD/W9hivjvXfUcnevq2XW9Km5vjMGieSEhmWGs8DibBSCMw0ufgmCT9TyrllgcFH66yUPxI5/GwfDUSvO3AQVG8KwfGZLlUSM6JwBj0zzQyJDKHGrF1PxScm/3tZEeQFDQY9EMPukO5Q94JiMf7bxU0fpzWdh/8OsVztRfjFWiEsMnrfAEF6/Vgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCYnHK4BYgUIRbWWgJ7WjNC//fJHzLclgJ3lhF7YlxE=;
 b=YwErnhFc//sAFEq8ElpWJYcMalSy67a9i/7dSzbeQB7fW2o2DOdtHaxz8H/gVhmVnJ7xUq5f0U2TLWCHVCRMsVJLaPXD4ARhvAuDfJ7XSSvwVNVAWqBwbdUSFyaf4Bp4Ef0nfok//fHW8XOXAV4O6XNEOUhYJSyVXrDvP0TqAP8=
Received: from MW2PR16CA0072.namprd16.prod.outlook.com (2603:10b6:907:1::49)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:13:46 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::20) by MW2PR16CA0072.outlook.office365.com
 (2603:10b6:907:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 16:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Wed, 17 May 2023 16:13:44 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:13:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/4] Fix DCN 3.1.4 hangs on s2idle entry
Date: Wed, 17 May 2023 01:08:16 -0500
Message-ID: <20230517060820.5499-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 932a73b2-6d9a-4330-f980-08db56f1b079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtBuK2JBELcZbxJcrBSBH1fC7AlzBoxKC+QBZZlToIO0k5Pmt24RIjdU0yuDzfd4P/MRv0PKO1mlXspextCfnHmCxIXXOFPBDhX3YcfoIlRYmqHnm8Aa22cLfAA2/HkD0EbXd1cKCOtXzEQTfeIPYPzR/OTXUvtojVFfGMNutpCCcvetqS2OPJqL7A/v7FvSZn2qH/Xt9ITFByLB5f+O4jNH0+nFruWK9iyzVXL6XobzTmtR2qu5uIQPn3pgA74xbNvrahzhT9gkmL9hNjEYYNQN9tRtmX20JFmPpp8bmicc6diKdAIkhMt2iYII5Nw0dkQigkbY10baxlGdiUDQSK8VcmfUslikrvjpA5MdQ4V/psMzJ79nO0v0etz5sT6DZjxi5j6OvvgmjEd/ehPO1hyGQqTznMDOfngun41m8Jlo86TPzBzgbfJ7O8DnJUSSWRf05cFSB8U5P7gP1bBC6n+KiAjTkz6/6oEEvttG3ecmAr/Hu/B1SKWhkezr4gwUV3Ns7T3ETQkOls/zn9RB6xoT5JaTyg/RFLEhfJM9/8+yzjTQofGZHrF2/clv6iNbIRkMIlDYA6tZxmO5yo6CT0bWKfgjGnlyVRUdB4vjWTiRzE3Vk2nYrFQ4v68vEAgWqcajzSLhY3+ibs/I4tXzLKtXDz4gnPhxmXzH+nwH8ogbctYbu4r2Vj656Sc9eD9aXCfKXentijtZzaWLC/UEXdcrZcmbu33Ur/Y6Pbgcb+YX9ZV/6OaiwJjtRjdjHEGN2rnaoz+x8StNtYpgunrF+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(54906003)(5660300002)(47076005)(83380400001)(44832011)(8936002)(8676002)(40460700003)(41300700001)(70206006)(70586007)(316002)(82310400005)(478600001)(4326008)(36756003)(6916009)(40480700001)(7696005)(6666004)(1076003)(81166007)(26005)(426003)(2616005)(356005)(86362001)(36860700001)(186003)(16526019)(336012)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:13:44.9541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932a73b2-6d9a-4330-f980-08db56f1b079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DCN 3.1.4 s2idle entry will hang
occasionally on s2idle entry, but only if running Wayland and only
when using `systemctl suspend`, not `echo mem | tee /sys/power/state`.

This happens because using `systemctl suspend` will cause the screen
to lock right before writing mem into /sys/power/state. Userspace calls
an IOCTL that leads to gpu_clock_counter().

This causes a delayed GFXOFF entry to be scheduled right before s2idle
entry.  If the workqueue doesn't get processed before the RLC is turned
off the system is hung. Even if the workqueue *does* get processed, there
is a race between the APU microcontrollers and driver for whether GFX
is actually powered off when RLC is turned off.

To avoid this issue, flush the workqueue on s2idle entry and ensure that
GFX is really in GFXOFF before any sensitive register accesses occur.

NOTE: This main trigger for this issue (IOCTL reading GPU clocks at suspend)
is solved in amd-staging-drm-next via these commits:
5591a051b86b ("drm/amdgpu: refine get gpu clock counter method")
ea27ee2bea6b ("drm/amdgpu/gfx11: update gpu_clock_counter logic")

As GFXOFF can still be triggered in other ways, this series helps to
improve the robustness.  It was tested both with and without those commits
present.

v2->v3:
 * Remove dead code
 * Apply the logic to wait for matching GFXOFF state to more ASICs
 * Move code for IMU enabled ASICs to other files

Mario Limonciello (4):
  drm/amd: Flush any delayed gfxoff on suspend entry
  drm/amd: Validate gfxoff state for smu10
  drm/amd: Validate gfxoff state for smu12
  drm/amd: Validate gfxoff state for smu13

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  9 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        | 10 ++++
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 57 +++++++++----------
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    | 26 +++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 42 ++++++++++----
 7 files changed, 88 insertions(+), 58 deletions(-)

-- 
2.34.1

