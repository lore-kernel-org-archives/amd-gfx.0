Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D10EE01F1
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 17:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2214110E4CE;
	Wed, 13 Sep 2023 17:15:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1121810E4E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 17:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2M5tSRQjF58T9Mm/qsYoFoltU/8G3KPzlIzFsan11G4GpKRJAW1EJx+EJ2mVf44WgQDH2h4oKUQx4OGrWIxShzm2lfqscFKfqKEpRInslhrM8dwbBunHOA2y3oT2KHfu4LOdg8uLpC+hr4dM7QufFLgBC2sPNev9I4cw75T6o7cxi0J8klTSvMdr2rSw6Xz7gcWYvVcb7p3FXm5gYZUawL0tzScGiwDf8BbyNlzd6CflQ5hvfiqLg7DyuzL5xMigs4r2aOB4phZeaMaq9/XCrYOZ92C2PaROzZ+6Os+8r9vSyM9m2rWkY4zRl1i5ZilvE/isxiXl60Zpo7OCqGtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Keim3Y0n3ADkMu4UXS/2WcC1WnOJYCDhMn1txTead8=;
 b=gPjFMxu0UhjW+9MeDlF7w+aW4dtx9bdY65Jby0u0eOxDCxbgOo+eQ0cZwJpdgbpz2tDR19Vo8gdl1f8VgHi82tsTgCOueyc0LIvncLYfgtAQXFBDzzjJAu7mp52csxBe2UUuqj4M2XR35lFWTvqnuNY1/BZUmjRvPOukBO07d/+7IB9WlmiJ6+Ubv/D0t/WLoMyDhz/ZpZ+/G1hN7WA1sAR1wayKi2OPC8lvyCtGxOOvTgrkzQxNTAqHgmPcar0+5Fhb0RoslwswEzBPGmO5XQMJDS9rpLENVakHV9Du8lknT2EYDmku6pKEm2/Vv6ZSFR9hDU6MLiI23f8u+f6EOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Keim3Y0n3ADkMu4UXS/2WcC1WnOJYCDhMn1txTead8=;
 b=ufx+2vGWsjthComoj088pjcuJ/PfZxvcIr6j9aEkWmt2HmmIFDWI2/CHpcmmJQQVdP2uhcfQDrMpKM3x3tUpuGPLfKpWyo02+T0fKMdU1Juoxecptw+1iI9laQNsW8YCnjbbvIl55kctpr8jRZdo8IL896XMljGSCEv5XBspHjY=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 13 Sep
 2023 17:15:25 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::c4) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 17:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 17:15:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 12:15:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/4] Enable seamless boot more widely
Date: Wed, 13 Sep 2023 12:14:51 -0500
Message-ID: <20230913171455.153412-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 88955259-c843-4810-ed0c-08dbb47d0502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02JsmKjKYxHA3GY+nwMHP+a4FWzbIrEJD8gEMnu8rJhf/peqEamcoUl8C4dY8y4I/62etYC6EhDIHxNwQzeSiZlmrIb7bUTCxsszzJAp2bHcq4lgNndEqN6O3HHbIf2bOH/DTwr0HGnWUDfXMNjSR4nZoDQCAQyFgdqEZRl4yxUJ9M/zlPvurhwowIVo1Yw2eFaeBb+CnhX9h7idMomyryvQSnZWjgRlzSxHMbqGdFCGJtTPjc+Bh3TkgjYxro+20O9JiUNsl/88HOQAoR11VW2mcU3cGeAlWekFpwlqlGhVWfu7F8oU2xG/UFuUceL0TbGE8S3AEnphuhvX5pFu51UcE9hDLdORz394peZChGMKipHU//g0gszE3tEfhq7g8vDYFHIqcjjlMq3uINFgQGt08m4+zZgC0uepALQqqFvxTyAQfDJoEkftB+0yD1FmQNEQQGFseo4dTTphI2GvLWZfvUTVHrIWnAa7VtATOE1ESvG2Ly6v5rKC4bF33Hy1egEfdsli1ttUDLdLyyfgkJ8d8U9YsIG4vl2NQDHi9zfFQLLgnVx1b4b4WHX3EmCyFjJtqXkmLpTUqS1ARe5KhliqmZFZ+eQP1dWXvtXMr7i+Y3qN/VpbmPv3K22GYWtcPaX2XdrmG7Qs3DSbW5cctTabwPR8z0n5s9VjvjF4xQgZQCFnRwrJmvFPF4HkyPlr4fIcH4HeWiJ20DMkWOlDGwI+NlOlqIMRuiZ5Nv+eWR4XN34Olc+CJvjYxmO+/E2SrOpbw2w/MF1b7QryzCPmvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(66899024)(2906002)(47076005)(36756003)(86362001)(356005)(81166007)(82740400003)(40480700001)(8936002)(8676002)(4326008)(1076003)(2616005)(16526019)(5660300002)(26005)(70206006)(7696005)(70586007)(54906003)(6916009)(316002)(41300700001)(6666004)(336012)(426003)(478600001)(83380400001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:15:13.2453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88955259-c843-4810-ed0c-08dbb47d0502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Seamless boot allows keeping the content on the framebuffer from pre-boot
so the screen doesn't get "painted black" during boot process.

Ideally the flow looks like:
* UEFI F/W posts vendor logo
* GRUB doesn't show anything, but silently continues
* Plymouth starts and adds OS logo to bottom and spinner
* Simple DRM loads, no mode changes
* amdgpu loads, no mode changes
* Spinner keeps spinning
* GDM starts up

Previously this was only enabled on Van Gogh, but this series enables
the functionality more widely onto DCN3.0+.

This also introduces a kernel module parameter that to easily force it
enabled on other ASICs too, which may be useful to adjust policy.

Mario Limonciello (4):
  drm/amd: Drop special case for yellow carp without discovery
  drm/amd: Move seamless boot check out of display
  drm/amd: Add a module parameter for seamless boot
  drm/amd: Enable seamless boot by default on newer ASICs

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 28 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  6 ----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +--------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 --
 6 files changed, 39 insertions(+), 30 deletions(-)

-- 
2.34.1

