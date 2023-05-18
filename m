Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F88C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 07:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E942510E4FB;
	Thu, 18 May 2023 07:02:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA38810E00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 07:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac0ImsssPRBakEGBMgkl2N5dvN59jus9dIu7of6BE91bse86NHJBQtDQi3eyZGV30leDy8yRgnDGnCd2BqqfJFtu3Xxqf8vg7+bnW/bP0FIlezIi1ViVLqWhhbICvSQRtNGuqmzuOlCFdGRTprCY/2r8rGmJLYou4OQXZommMQMw0PmS+mbs2BCBXkOZQJcSggeyUFhAlmXlZuU34mCQV7q3a05shl1zZo0oBTVNgt4e/SuKU5s2rP1H+kN5zXbJ9hKgvkHS5s7hw4QoZAShyXcj6QGBfAXu+Osc35kf3vChN3NPULvVVn7PjWxXKcIY0SU+sUTXpnyGGmygXmiApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgtzAD/wRJow8+FUnmDsPAmpXP/Si6VKIM0Zo9O7EKA=;
 b=gHQ0V1lqyvWsyUC5woga5Y/w6/R2kZXgaJMt6Jj0JsguKE+X/4wzArYcZUr+7becqL6PvPwYj48GRqU6FfMO4sYEWnbpXsITJb+x6Kkklt0yWpGx2lIBTiPbzgk977EvlS9yXzHM6+Llwl7e8Ac3OwKI9DBPKpYebe73hBF1c/ZR1xbWj9lxICdAEApuQSxFe5nbnpQpogKlnPQnqkdNkRUnJCPKQgDoWtWmBi57PZUcty+iOgyOWNGlhwoPEYrmh0FhhZ3Wi2XMhc3umRNqahNbXWijrC2dAYW/v7DQ+PB6XWH933Ruk2rlNSWL7NaCKfjxsptC0OrHwGA43iAgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgtzAD/wRJow8+FUnmDsPAmpXP/Si6VKIM0Zo9O7EKA=;
 b=0wkS5mWsYa3b2lXEdT4ifavNNQ6QBNvK2SGjQG7/4r+ZMqLnr4nIVEzR9/cGkQOd4MatpKQIlrUF9ouHDyOSTvpxmZVRRB5HadxAY8G035oMloRf3lgGfDyxaS84tz3ip8hg6UYkXjT6Oaypo0H6z15/9GjS7EiAbSeolPOKw/A=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 07:02:34 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f3) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Thu, 18 May 2023 07:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.16 via Frontend Transport; Thu, 18 May 2023 07:02:33 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 02:02:30 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH 0/3] cleanup abuse of sched.ready in each ring init
Date: Thu, 18 May 2023 15:02:12 +0800
Message-ID: <20230518070215.3556653-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 8596c14c-4aa1-47b9-5c07-08db576ddad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXywtbJXEqBr3k8IejMgdTG5kv8ZuoDR9ceAPCOJ6F93joOOZOdUrJmZI2tTY6l7AT8hCOf8auA+zjt4qPehRepfb95EZb6+ex+trK29o4B21uU1xeAbChvcIxabAy3MrdPOSBTS7q+n7Ltzb2508k6f7RJBzK42jROFwIRUZHg+XxKE3B+wVyXtbQHQlx4sJ7bmnAJZ6z9DRCuI85zUATnkofn0riVHEgLrtILnSzOmakAGz9t0FWSw+2PcxWsHhEPQ+wfNNnuXwBlB76chaDIhObAgbbSOkHEtWUA1qdIYpHoL+NLtsWrwMm/VCzqAUHa8QD+ytUmhAGj9cTv8xqs/iko/V+uczOWMKSbeaUponoWgPSh7ilmHAy/rRB/KcwYDgikJXlsj4giu63qLt6S1SopDfFuDNBUJxZD8k3KbIiY5UMFL7fbM31fwbnXXF+kFSZwQT7XyDYVu+wGB0Hv/YjGVK1iOYG0GrnS1SQJFN9z0wj4zMjTBVZErjmsKDsBywXt2doq5Bb7B02L4NiPM0VR/9pDkoGUE/EQDaOPV8VxtO9yyTG35mO+0n2IqTfLaBRFEuHAxMdj5nOrAZBeO8v+JX+x8h8mJ6WbbejWsDGbRwEQzG3PVj3uSoR2+t+JG0pVXGhukhVufDVVTqQ6ZI8X6aClQGmxqf12mAI3wSkv/iHO9vYij1q+fMHUgjgp4rCEYUYksqHOytBsDQ7a3KLQetgiVRN+5b/orDZpNWaanF/qQ/ORuZQ6tff+F9qiIpupVwCPXEzNH98Mv8+5RcPVD5Q3wrDatUlVzD5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(478600001)(6666004)(110136005)(7696005)(70586007)(41300700001)(70206006)(36756003)(4326008)(86362001)(40460700003)(316002)(6636002)(82310400005)(5660300002)(426003)(47076005)(1076003)(186003)(40480700001)(2616005)(356005)(336012)(36860700001)(81166007)(8936002)(44832011)(8676002)(2906002)(26005)(16526019)(83380400001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:02:33.5937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8596c14c-4aa1-47b9-5c07-08db576ddad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series intend to fix the abuse of flag sched.ready in
each ring init process. Its status needs to be updated only after
respective ring/IB test in init/resume.

Guchun Chen (3):
  drm/amdgpu/sdma: set sched.ready status after ring/IB test in sdma
  drm/amdgpu/gfx: set sched.ready status after ring/IB test in gfx
  drm/amdgpu: switch to unified amdgpu_ring_test_helper

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 24 ++++-------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 25 ++++--------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c   |  8 +-------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  8 ++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  6 +-----
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  2 --
 17 files changed, 15 insertions(+), 95 deletions(-)

-- 
2.25.1

