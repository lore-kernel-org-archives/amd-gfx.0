Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5EFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 20:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2466610E775;
	Thu, 17 Feb 2022 20:19:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D1A10E775
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 20:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0+cx8XYlwuLNrlQBfcePXP+4m1MosHSRtNF63y0beoXju81CjFQEm4aiedNebzkh7p6h1TfcAufz8TSDIsvysCBkBAGMpi2o9LQuxAEB5KvJb7SfVwvhAPS4JQPy2Hx+k0wzUms5hCa4QVq24OTPe9FXbpN3WXdl5x01KotUEza5RbSrMJLCpzqYYI2vASLC85dUhKl9YZYtQmVdsFQT4WNUrRPM5jqzkDNIkcvSxRqax4z2h0SbZmsYGdlj2es/cLzn9S+ep/pM+eSZzPL76xddXwOAxeKT0dXDOd4YZOAZe43hy1atcy96DYgW/AGbE9Z014GRhGN9otUyd0nIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GebWyO8uF66q6LLhHtSf+w0PsgbJCZS4ek5tZttUpOE=;
 b=MAF/3Y8VJROtqCYIP9gdqA79DF4G32kPE6Z582xc/RVzUxflzezcXtoc30GNNtWoZc1CyOwNr5q3DjKr6j34YwDCwdMGacIB9hUm39YmHQXWNaMaHe4E3nXdZTWs343FCglkDgZWuPYuPBfAT8SQAoLzg6AFBUxvYMxw8+I3X2VA/s69kUAErYiSf0NQze/y1belXQag+T66Ji2eq+8MWOYXCi9XJtvhKZjqhvgWtk4HL4clsp0VBrUaFKXerYQVYypEdjk/ebcy5hqJIw7/GkreVDiwuWxhWGbewEQSJsFno/VaNfHwCYtrrRqWSrBQghc0jPw8CNZoY+/JvQ4qVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GebWyO8uF66q6LLhHtSf+w0PsgbJCZS4ek5tZttUpOE=;
 b=NkzDcr7JNcXlhfSHI/ZZTvDjPDnvv0GQ2gj9mEdZbI7uklbH3BKOi1zMRXjsimL9JZW9IMoG+K5rREFW3Pjp6hOY64eFm6x/uzcHa1JaNaamj5eR+tTRzxVBgtSUHIwyjHtuukdYiv4brImt8yIqcK2RjxeCIt8j6GKpF5rQW1c=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by BN7PR12MB2834.namprd12.prod.outlook.com (2603:10b6:408:31::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 20:19:39 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::e9) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 20:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 20:19:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 14:19:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add SMU 13.0.5 Support
Date: Thu, 17 Feb 2022 15:19:23 -0500
Message-ID: <20220217201926.302025-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29d1d4be-67a8-442a-eb9b-08d9f252d2df
X-MS-TrafficTypeDiagnostic: BN7PR12MB2834:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2834DC1FDA0FEDCD2F992426F7369@BN7PR12MB2834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0OTOLLdb6ncT0vkjvNzR+gX7mwoT+ru9VKN95Fq+Ztu9OCLXcCO6aYIKcY252lk0fY+Kyelqt4OSEweCW/ZXaKNU3/z+fceQOWmBpUHnrjk5lIjeh0Jh6Y62LX/sBSoXebi3tt1CzR8jBmykancc0pVWYHAErC+96GjHCqqI3fASkj9dEQ68859McKCFD4Rnu193rPTejlGyOGHP3k8qKGQXYMSHnVAbxjjCQK5ErvWimezCWhClf/hQE7ituiwUbqbGSnv1wR+HZyLomJeWvY3fHfxkfXrXmX/OlaRcADOlt2rFNdJlTAV0t/TdEr6EmQJSH3GwJ1GNCHQ8exUzJ3sWhfZrkyRxrHklHsldXvlJ43Zly26NYEh8vb+RMAKhlAaLGBplllpMNsMLbGgpFYxRIJXKmEekkFtGM/trntvDCA08NSYP88pVo5Eox1NbdtFB/LQg0fZgc5pLT6hKW8omDO+MyP1gXZQTQVaLOMdIWIPmhKwCuHn4gQy/KKX2vVoOikfx6WIyxfEB4747sTvlv351vOVJ37FE8SmBISG64toa7GxgiOdn3WgrZgxJ5IfkQQJ2R6BQO9HqrjJvY+oZVuYmjsF1JDYdrN1xHuX2E/5cARLgcb8C43pTe+Ap1hBWFJgLDmJogn/DI0pRt/paaVn17+PYP+NluecZffTKqI8CIb2K7pwOOuehlx/3/6UTvY19yYVT36pVpok9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(83380400001)(316002)(47076005)(82310400004)(81166007)(36860700001)(40460700003)(356005)(508600001)(6916009)(186003)(1076003)(2906002)(26005)(5660300002)(16526019)(336012)(2616005)(426003)(86362001)(8936002)(70586007)(8676002)(4326008)(70206006)(36756003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 20:19:38.7984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d1d4be-67a8-442a-eb9b-08d9f252d2df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2834
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

This updates the SMU 13 support for chips that use the SMU 13.0.5.
The SMU (System Management Unit) is the power management
microcontroller on the GPU.

Yifan Zhang (3):
  drm/admgpu/pm: add smu 13.0.5 driver interface headers
  drm/amd/pm: update smc message sequence for smu 13.0.5
  drm/amd/pm: add smu_v13_0_5_ppt implementation

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |    4 +
 .../inc/pmfw_if/smu13_driver_if_v13_0_5.h     |  140 ++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_5_pmfw.h   |  126 ++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h  |   74 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |    3 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |    1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |    2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |    3 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 1142 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h  |   28 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   34 +-
 12 files changed, 1552 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h

-- 
2.35.1

