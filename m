Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB42C77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 14:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA5410EC6A;
	Thu, 20 Apr 2023 14:47:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD8510EC6A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 14:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWMh4rX0K1x6b8TYU52n1IAYCvE5ptSjrVbjimjCk2W6UICsKgH3uGOQKSCw4855WOyuXO+wh/3Xvg/lNGrsf9e9IFHBylubE0++BoNkANFbXzqqFk8vklbYBoU1kkSxAas8cBhnQ94RzYrnkxbvE6R4Ue0M9ymh3BujpPInLx/iZG1ITlrAT14+U33668UhFWxaiZYdO65TgjDOWf+WRk+nKTZhvNnjA+7m31HOR2AhqGp62ceIkq7EgqkVOkj6xYcU5JW/iu6I8vsBRBA3JqMwZYBW09fDFRjiJv5DwYk758/63ntWhrE5EncmvM7jGbghCa0O2WPcAqrtzWjtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30cy8aJA9ftm8BvxJSM7pAss6Uvjjrp2mJWWquftuQA=;
 b=OKe56vcGUe9r8Tz9anVxZBULzm5bnF3Da0LhvwP8Nw61fx9UwX9eB1GHn9+nTRNm0lbsh1Mg5HBoi+Uqd3QSztn6ef1ULv71KAET4Ci7wvlfkRTgVLwqpaEce44jFTOP3ZJHe0HRw9t6ZXi7AfBtkYLbTK9JoTwaYQp6pV3wmpInNp4iBhU5xjIyHfNlQvIhCg7p8ADcAr9kElZfelD3qvp4C2swHQuH7cAbxfRl3zKAeXPbT0MhXw2oYldwHIG6Vzl2VZvsBIZ1xvk6h65pGTudYSVwVxbCn/4UzQWRSKvVeJ5JpyBPK+/y7leWbvIRWOswgSTQK0U2bbz8PbA2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cy8aJA9ftm8BvxJSM7pAss6Uvjjrp2mJWWquftuQA=;
 b=V12Jo81JTkWoGCbnjNHJDIFRIi6jswPbpOoTAOjrHS11FW+4s/ggR1qOLYq6wHvx5A4xezXVfCy0pygoHh3ApdGUb9B6E2IDLtjjFHND8q8piKLmivowkaoZBO3XwXgKfp1o5ZjtGEo87JNZqxWgQ0MmiD6MRqpBGuzqVFeYqFo=
Received: from DM6PR02CA0062.namprd02.prod.outlook.com (2603:10b6:5:177::39)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 14:47:51 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::da) by DM6PR02CA0062.outlook.office365.com
 (2603:10b6:5:177::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Thu, 20 Apr 2023 14:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 14:47:51 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 20 Apr 2023 09:47:49 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/6] Usermode queue fencing synchronization
Date: Thu, 20 Apr 2023 07:47:08 -0700
Message-ID: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf1a8ff-aae2-4f19-f498-08db41ae375b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tc1f1jMgWN6IF8tDqponP2ASHCAzzyWrcX8ifvEfOo4jVpVMZjACDeTDsz/D0VtX+zZnj2pnP+a19RjNT2TZWlWtVgkea1RgOO7pMrcHVSdGfHeOzqz5yN18lFVGiIC1uNtzmGv2WLP5XGZap6R8dqzzneGWOqwGpOq4JL/ZWVIOjBtHxnFGaGzwyQyr4kmAQmFZ+Xco5x7hDj3ITBq/vv8DmDrw9J1EI84L9Fr0kNBHMS8CqHiEhHnLoZJ28MoWSyhUy/0Yzc4YSZjY9miXxxMnLezntfS7ILzkgwRgXRoMltgt49CisWIQ9/a/ijUKexBMd6vg9Ex/gaeMH1lieVJAcfUxluy1+h+G9mfdTOr8bePmh9MTq+WVVG57f4q9oHDDjGqUTRoCHCd331TtfPfLYfWiWw4ZPwzPARX4EDqxcsvY48KmHviOsUuXBLVwEksp2kEStIGEloUplczIOVRNVKL2qAgYcPXkqSSB2OsNdOp9geq4wYQ+f6BajtgyHG6ICVyA7h+pDspT2CSueRoOLvDNiruRmP2unYulA5TfslTQ6GAdpFy6Lu5MskmvyZlmNpY7DUZ/uGt7LUCzPY4/Pipg4M3hLtFr4P1jsQx1Mhcc67o5vhhdeiYXucGQbSp4YEGUcJ8W2PJDCh3FnshBhjLJLKXJ+qIMa/eYncMX9ew0mDLxklOP476/mYuY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(478600001)(1076003)(81166007)(356005)(82740400003)(82310400005)(2616005)(186003)(16526019)(26005)(36860700001)(7696005)(47076005)(426003)(83380400001)(966005)(336012)(86362001)(4326008)(54906003)(70586007)(36756003)(40480700001)(41300700001)(8676002)(8936002)(316002)(70206006)(6916009)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:47:51.1164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf1a8ff-aae2-4f19-f498-08db41ae375b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The idea about usermode queue fencing synchronization is described
in the below link
https://patchwork.freedesktop.org/series/114385/

The core usermode queue and doorbell design patches in review are seen below
which are prerequisites for this work.
https://patchwork.freedesktop.org/series/113675/
https://patchwork.freedesktop.org/series/115802/

drm_exec helper patches in review are seen below which are prerequisites
for this work.
https://patchwork.freedesktop.org/series/114465/

Alex Deucher (1):
  drm/amdgpu: UAPI headers for userqueue Secure semaphore

Arunpravin Paneer Selvam (5):
  drm/amdgpu: Implement a new 64bit sequence memory driver
  drm/amdgpu: Implement a new userqueue fence driver
  drm/amdgpu: Add mqd support for the fence address
  drm/amdgpu: Implement userqueue signal/wait IOCTL functions
  drm/amdgpu: Enable userqueue fence interrupt handling  support

 build.sh                                      |  11 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c     | 158 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h     |  48 ++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 552 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  71 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  20 +
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |  12 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  20 +-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
 drivers/gpu/drm/amd/include/v11_structs.h     |   4 +-
 include/uapi/drm/amdgpu_drm.h                 |  47 ++
 16 files changed, 979 insertions(+), 4 deletions(-)
 create mode 100755 build.sh
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h

-- 
2.25.1

