Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738E3C4829C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E438D112DE0;
	Tue,  6 Feb 2024 20:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q9oM7wng";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27651112DDA
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbOp92gNy2V90Wpso2VBirZ8DhNCHcSVdZStR74zhW5Kxm908UyORWpE+uP5p26qCbD17MZDU3fpl7m9hpMSUy2hnM4yJD1tLSK1KZJecfwdyixIGqTVQTqR/Z8l3BQnqQprGLGC0O8/+cKUOKnxU7VZl64oK4cqi8OgPeDzV7gM8vuDwfmLCkEqN7mEXdCLtZlYu9LO4VUE4/G8jYRlky41Ffb4cfcybBvSXZFpiEfDwvt1D35PQV7u9RKNwrKEj5+Aj7f5VeQTQsb4FsxX6LZyGlTMvt+SaBHdL+jWw/NBiwqlASVrpWfdTCimx+V1hm5nM00xK6TgyGR/y23FvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exzYy80ix8vIsojP0DCkLtQPtT7OCB8k5MU4vIDyyEo=;
 b=eLa3WpcmR+pjx1voT+Jpp5zHZ+V/BCAR65ZrbQi15SA63GC2EazPzpZslgTs20qHjr8FECS/g8l6nGJkX8FsjZHRFhNxWc6dyUrAOj94L1d+Tts7CI7+Cx52B0bnx/PT7M4IDPr0Nn7M5KFx1I8O8C8HL8XPcqDAkk7zZ2pGtkSGvM8vQJpuNXGt//mDPwqrJJRkP91ICE1juzxifxc+56VBQKeQo8BU78MzenFCBq/tvzUIIuvHH3w9buB27oKz2fcvNLKyWNYPcK+OYnh0QTJK2mT3274Pw8a4z50MdS7C7WX1pXphBYNrtbujRVBZwh/Kxyf77fSmRYm7Gs7qGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exzYy80ix8vIsojP0DCkLtQPtT7OCB8k5MU4vIDyyEo=;
 b=q9oM7wngl108raNj8eRiS+6+gH+QV4wiOEUne7jr6QCTzZa4qydM9GUDhxZXg07qtm5HDHKNuDEcJUIMNZoLy9/f+S0jdFIE2SoizPlAtNyRFxxw0I1CpYLTawWGQaqbF4BBfm5dpvIgOJKlpJ1if+W+y7Anf8qP13B6k7kwZB0=
Received: from BY5PR20CA0017.namprd20.prod.outlook.com (2603:10b6:a03:1f4::30)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 20:18:12 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::8e) by BY5PR20CA0017.outlook.office365.com
 (2603:10b6:a03:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:18:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:18:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/3] LSDMA 7.0 support
Date: Tue, 6 Feb 2024 15:17:49 -0500
Message-ID: <20240206201751.1671125-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f66097-7604-4bad-4de1-08dc2750bdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQgYmVa+bPbRpf8SE48MToi/C8xb1m04yCPY1F/Hz5WjjaLfvD/+U3QuoFfJsm6cSwf6UAKpTizZjN8593y54c6I3Wl0uZvcvkcw5vRqRmR7VuBHjDGaLG+AOQXdkJrNds1CXE5Xk7gmmaN7Zscix1vi/96Dn/zeIbSbqPmxf1OnaywDr8b0dGkQFFnDuddqYXszLNJoh1LfpFygKcdISQhO4KC0EUr1gPg+4YQrEcm9wAz/QgJKgzq0U0zdvN1Rdpk0itvmnIzkYrkIi5CiToxnFKRVrnLxElPqz8TPCS582ZGbJNP2BzLY91DNcP9z22+CF9EmvoZDDRU9c6MObsx5gW0Xj0ufjCqMJftbTluzeQbMCz10CBkVNsQtXmnHLpoowN/yXvvv6TgLQnlOmqBC/gcXHZv1CnrjvtAoy0kf42k6Q0rRE9VcFH2d9nJejCTrPbg0pbe6S5eJNaild3ipdr+HrQdrcXIUlhuqlFFSg5dKl+i/v3y93OSCB5dtoyZdAFVbF9IzrYaft6C95w/sJW3XqYArMt5q80OgwIBG1DPzRO2pBeVdiJMeR/wVdqCGpDeSv8/Gs4ivpruK9vKHlg/xPpa+CU/QGa/xjIQmZVpg3o123CHLHwZRDvFfPahLJ/oiibSfRaDSgCsBV59kLxPNAdmUou+c23pYow/yw0TSI358aBeRbEGKcRRNy36UEDWvoNwmuthJTP6zaVm86F1bfQy2jBUk8F/aSnNYKFCrDAe+O6VKAmQq7fF8XjPexXpY3PuLN3hinCwFOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(8676002)(40460700003)(40480700001)(2906002)(4326008)(316002)(70206006)(70586007)(6916009)(47076005)(478600001)(1076003)(16526019)(7696005)(36756003)(2616005)(36860700001)(82740400003)(86362001)(26005)(6666004)(81166007)(336012)(356005)(83380400001)(426003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:18:11.6289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f66097-7604-4bad-4de1-08dc2750bdf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LSDMA (Light SDMA) is a general purpose SDMA engine on the GPU.
The driver uses it for MMIO-controlled DMA access to GPU
accessible memory.  This adds support for ASICs containing
LSDMA version 7.0.x.

The first patch adds the register headers and is very large, so I've
omitted it.

Hawking Zhang (1):
  drm/amdgpu: Add lsdma v7_0_0 ip headers (v3)

Likun Gao (2):
  drm/amdgpu: Add lsdma v7_0 ip block support
  drm/amdgpu/discovery: Add lsdma v7_0 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    5 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c       |  121 ++
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.h       |   31 +
 .../asic_reg/lsdma/lsdma_7_0_0_offset.h       |  388 +++++
 .../asic_reg/lsdma/lsdma_7_0_0_sh_mask.h      | 1411 +++++++++++++++++
 6 files changed, 1957 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_0_0_sh_mask.h

-- 
2.42.0

