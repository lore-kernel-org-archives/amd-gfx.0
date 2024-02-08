Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC5EC48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 20:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5525E10EC51;
	Thu,  8 Feb 2024 20:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ivk8198O";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA57910EC55
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 20:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpsC3Yg0sskJ3WOgBUl0J87lgy2n1htW6VIS4QOD/5bZ8kJJErRgk4VIBaLenhBbCXJN1iBaInBfcIrdTpbojJzlTckUVMAmlkP1sljcRfu4m/duzxyohMrg79SVfWD2pwhju5v4p73m7ZLUiPd1Z4JXh/+TVkmsI94szh/CYxf4IJFKDJSE/Aqh+6YVUfn3NLpgK5SIeejWXxsIRfwJXiSr0d5dUcxNEPQHrYCrwKIsQnzUVEgb2ls0CvRuocTfPgZkFgTXawOXWWs18FLmsHk/AqtASAoiH+BlRYWUYI1liT3Npd1R2oqIEN/UebQ/hTEK2ZqJL6VEcn8225dfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdIirZqn8zelph+lUMNKOW8nH5ZSYJ1fWAC/DJD7pbo=;
 b=izAcKe/baXnGECTrb1V7EWbbgyeuqjId8cu6FZPo27hpsqN+kJt94lpwNiv5b6ZXCe4KWnGDI55YUFbxQ5e2eISGt0/Fovtr/Zfqwns5Fknzx+iyBlnlk3skphODlE9POos5l2Phj76s01g5Jro1J9IcNWZxkHQH2mB0gsprX04CWEMVjqF9U9M6KrduwR2NU1fJwr6et9ljT1D3CwA62+i9xfuUwwdo3F0rCXHzrOpHN5qLT+4gZwZq3pUQrHlHnDdHH0Muk6AYWNWnlsFuokbxOAx5wJQO2ENxFJTxW0IQWFpWoYhkw9lxPxfqAAcNOr8UAcn/TFNBlTyMvzH2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdIirZqn8zelph+lUMNKOW8nH5ZSYJ1fWAC/DJD7pbo=;
 b=ivk8198OKgyniR7fPJLiwE6a8bsXWHbOisVIxVj9J9doL+Y0N4fJBW9Mk2BK9mAI60LlGu33HJrfXGQtC5cOKwRIVY2vc9a4ABtK02CuxETblmayqWtl0DxQu3LGPLh/eUHs2faWPxgDr/vbnIa/ctrDKz0R7YxkTNZYNHPpeoI=
Received: from DS7PR03CA0150.namprd03.prod.outlook.com (2603:10b6:5:3b4::35)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 20:03:08 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::9c) by DS7PR03CA0150.outlook.office365.com
 (2603:10b6:5:3b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41 via Frontend
 Transport; Thu, 8 Feb 2024 20:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:03:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 14:03:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] JPEG 5.0 Support
Date: Thu, 8 Feb 2024 15:02:49 -0500
Message-ID: <20240208200253.409130-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd7949a-b9b8-48d3-accd-08dc28e0f7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqyMW9liOsoFmNOMyt7llIEaNtckBnjSjUSaLm7XdXSuSE5DxRM80i2hlqeo90x/xtHa69Ldr308XnCpNTsqNXNmJxkHEGliQqTHUicVYjKaTyR7DZad15D4mzuOaHiPvT/p5zKn4Q4rQs69LRqXhe8DTcNaWAGnJlyNQ1QS7kx7jsbkM4adkjNJM+NSgiam62dr/+tnctxsAtH4BEOYqR3abwyo5i0Ha3bnLKMk4Pjq6mwPpJ85MCnrGaOHA0Wzwe+8JMeR+kLDcXXba1i+9dLDLwAkDTkd2EAR6+cZo4lLcoqyYd4Gon0pGlBzcAyHcnu4+l+0sSk0tUJfTA7BKu8IT61zCrlwnJp6Cdh19qo1JgRaJJ/aMeeIvtCuatNnNQvKxqDLIFKXqpwOFXSlKsQQsNEXp6nJl8aiz/U/gKMyVGxfnfpyxU4aGtzu7auRpEaT1OLcfRknRc8WTuia+8kv574BqWoBSKIKgzxKq0risnu/Cc9cRFlV34mRMk6VheTjk187CVxAsy+kS7Z73Mq+kC5RkKuwr0SjFPj9o6yEzkYcm3jXTGiOSdYJv/ZX2BvYNZEgM2Kru9tPbFIUc1FHeGPpFYS2YI807ib9P1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(1076003)(16526019)(426003)(26005)(2616005)(336012)(41300700001)(70586007)(36756003)(478600001)(83380400001)(82740400003)(6666004)(356005)(81166007)(316002)(7696005)(4744005)(2906002)(4326008)(6916009)(8676002)(70206006)(86362001)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:03:07.5050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd7949a-b9b8-48d3-accd-08dc28e0f7dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
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

This patch set adds support for JPEG 5.0.x.

Sonny Jiang (4):
  drm/amdgpu: Add JPEG5 support
  drm/amdgpu/jpeg5: add power gating support
  drm/amdgpu/jpeg5: Enable doorbell
  drm/amdgpu: Add jpeg_v5_0_0 ip block support

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |  16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h      |  15 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      | 570 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h      |  29 +
 7 files changed, 628 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h

-- 
2.42.0

