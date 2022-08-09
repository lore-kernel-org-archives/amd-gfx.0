Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F01C19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 15:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6F5DA69D;
	Tue,  9 Aug 2022 15:10:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EECDA612
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 15:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr9dkI3VGaGat3kP0n0qy93m7rP46QUJYCjw9ew0oVpIgCHowvOAejae9j9MkKcxfLpQLSA2j8u4BBZLCcfYXmrb1JSprkxTKqkH1UecwCrjq8uscif+8aFhLiguwNIOGJHgA0tkyzdHdBv7Jd8PngutoXtantI+SmKnnUmjTzfE92IgAY1x2g0hq/ZRJdl91r7ATCKtxqjBSKEwIgrkgp0urs87kbIkz60MuYRNtRP1WWhoiJ0yXmfkg8XqUBeUFzhV/1PrLYLLeVb3Rxgr1SjPLKPeuH7dLEJotGiQtg5tnFvXKL+4mSQsA1I5F78YlNzWHtrW4j7N0m41a6U5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwZINPnqFcsyQmBEp6Jdv2xLb6YZesAQwmoMVV42ICY=;
 b=MqiTP+x6uzx9GfZ9Wprw7yR5TEJAkoqyLsYIha6LIxfOpUYghdCVKsy7A0ZYYgmmyVAACvillwAwIL57Hl8QRckH9E/KvjweSVjgLLWqt/vx4T6KQnrk08ETCLS7kLRZfNJ6lsVFqxLo9x2+wbYxWyG/gw5PW2vgHKgA5bWHpN8nvxV+xp302i/KntTI8R6VhKaKx1MuSMOSThB6BaFk4xg4gHlf0Zq/ZGuhX+pMIYZ7yoBF1yazFzmhnbZMUbOnzvzf/GwxEl0iQioBmq+3XA5iasP1AHq9DTj0F+NEzgm2/EXG5tMo8r/5tOrC5ozkDah20IczUxhIniRd24XZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwZINPnqFcsyQmBEp6Jdv2xLb6YZesAQwmoMVV42ICY=;
 b=u6abETd17vzV+ref3B0i0nDr/LWN9LTVZGgTWM+y1g1h6g1IVdo3gO77K811uMSx5LGmGMLgTo3MXXUzcRzLoE+/EGwizWvDrbMqW4dHEaTS+0zzaDMN9D19+NRUEXB0/8GdLIVAeT35+dRTEwzdjWrmQ3dvMF2NWVp83/MtQ1k=
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 15:10:05 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::55) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 15:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:10:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 10:10:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Fix S3 and S4 issues related to fbdev
Date: Tue, 9 Aug 2022 10:10:04 -0500
Message-ID: <20220809151008.20376-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15298cb2-d105-4207-5832-08da7a193d97
X-MS-TrafficTypeDiagnostic: DS7PR12MB5861:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yttx3DpCfNhffQgIKURYXhkgNsQNh9FYojZMf4nS1QFrdXDUY4vsOkW9UBU18RdJfvopwqO2DFTnpQ9u6fUZQO8+DuktHKj74BHA3gJTiNtLQmTIKuP9cHSMuGKAIsHKxd6Y/cpcH3MxlUA7uMwNv0uQEGlOOxjff9hM0vjQu21I7d3fBp5ul8DO3Y7C5HqRYy8xkki6biWcOqn0dfCAG1bZHsCly7oVd9x2Kyt8nCFfiWNKNy/wdMkTGythsmJJBuSA7w9Q6/bnxoF5fz+kFNNFTuEZzwqM9hGXzlyJSk5w1Er8CQJfYGIuL4TrJpyQGvZtY95Obc/fYNsOpCOeYAU5cEAGFMY9WVqcHPiSUvRYT2J52zfogtQz5XlhjnHeqCsBXmc0fx2lJYq4K8Nkpq5P7ETxZKH/HWRbdFRPxrZ8gHZ3t6M7FXZZcwqOJZo8BJ82J5E/CabtyfEswUTqzn5ekImARpnid4pll/xSzSCVe8VsnAT0nIQflavBdwKTpb+3sVJPpVq1IYN+w3r/t7SxKd4IOEXNUO4VwpzCMaGjGgBFwLotggGONpZdmyKXbs5kslQ6pnHcAsgJ0+cD6aIB28PeIfrpYFw9oeKI8ugw8CcGh5YntOaoJIufyyGmMIiSVYijwDjYxbm1k8EI8jUuXLnJNTrW+ZkgWyplJx9ZWsV4H2EXoaO3j/pFxiFsLLOY8Er8tExNcSQZ1ptDJcZgAESn/5ThICmhm54sN/eG74KyzALptBu072DM25d66em9eeZwGbe81/aYvM3CXWPMNoHRD6dsDMlfz4MkJ5yxy4Jw9lMzDMjbT7lG6zF+k5HPIiyxBCwLqUenigbO7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(2616005)(47076005)(336012)(426003)(16526019)(1076003)(186003)(478600001)(7696005)(2906002)(40460700003)(26005)(82310400005)(81166007)(356005)(82740400003)(83380400001)(40480700001)(41300700001)(86362001)(36860700001)(5660300002)(54906003)(70586007)(8936002)(36756003)(316002)(44832011)(70206006)(6916009)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:10:05.1508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15298cb2-d105-4207-5832-08da7a193d97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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
Cc: Alexander.Deucher@amd.com, h.judt@gmx.at, Renjith.Pananchikkal@amd.com,
 Evan.Quan@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Moving to the generic fbdev helper introduced a regression in S4 support
on Hawaii PRO graphics cards.  A workaround commit was introduced to
avoid this S4 regression until the root cause could be found, but that
workaround commit introduced a completely separate regression on S3 on
a WX3200.

This series reverts all the code to move to generic fbdev helpers to
fix both issues.

Mario Limonciello (4):
  Revert "drm/amdgpu/display: disable prefer_shadow for generic fb
    helpers"
  Revert "drm/amdgpu: keep fbdev buffers pinned during suspend"
  Revert "drm/amdgpu: drop amdgpu_display_gem_fb_init()"
  Revert "drm/amdgpu: use generic fb helpers instead of setting up AMD
    own's."

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        | 388 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  25 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 13 files changed, 457 insertions(+), 74 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c

-- 
2.34.1

