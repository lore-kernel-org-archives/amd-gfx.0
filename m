Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7D3C46CD2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 21:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCCE10EFD0;
	Mon, 22 Jan 2024 21:28:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C64010EFCF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIU9GI0AwycVBm3Q3n07h2USQ9Zf0yxAlYhg/QiFDbYNxu5amdo/7/gzDgaWasSBXDnrcCJKuoCJPtyfkg3DJV7cQDnaSyhB7bFI7NXYhavYDZXg1yA1mRI+Xjc+fRus9FvT5vhqHmtetgoKDiNiy9UfCVkSl/fiaQXvmQv95oVvE1Yl9qnHD36d3LavMtq4QT7Fbo+iMkvEpbbx8rF9EC04TBbZ1HMrvmTG0N/NEhy54+y+f8GvJLQ1AjKlZgsdGZp4p8gLpxE5B1DGWPhYkENLUekdc3hwXw9WvG4dmZn5g8ITQSWmoNs/bADBXiOEU8mScyLGoK1rkVrw1TwEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvELLlRxv1xcEO0fBIlYa107Cgn5LCfFe49lhz+IfFQ=;
 b=JRROhKGB9lBudlz5nZ6snbjioyyB2IJt4HlLOCTrnx4Q/ce7PmnNBDJFkrv74Qiqoc4s6K+cr9vGYIrYs87qnPN73NfMAAaooc7xCstyh2RSS9uvcR4jQOq4auahQSmmLTwqqhXRU7fUEg1DxUtcg0LzVPOY6TnopZOR+AF51mI1GUsbLHrJfnAFBtTq9mC925+QiC1ZSarinwyDbpGpKXU+iKZTztm21p8ZnbQ4BUpwMrmJiLMiiPvT/prb8CVV6xFS0qaR0WQVd/bwnUDxpoAEgU8VSECr27BBT6VnyTSC8HlSVssmIz+1LT5gQhfI9hChBFkocc+k3i1XTkMzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvELLlRxv1xcEO0fBIlYa107Cgn5LCfFe49lhz+IfFQ=;
 b=GKe9xsLqijkB1g8EBTA1aPmPPgyurwnwqOs72YasOAXUJ0HGzK9clrhjvNIV3Qko2Iq2SSr1hUT1MK3ZGEpYPZs+mhxRuksH2Pp1C2yIhp2Xavroyq7Nhz6uA6jC5XdwRiqaBbodG0bRzdUX330rTPmoV8vTjZPjF3K2WaS+/Y0=
Received: from BYAPR06CA0069.namprd06.prod.outlook.com (2603:10b6:a03:14b::46)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 21:28:20 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::11) by BYAPR06CA0069.outlook.office365.com
 (2603:10b6:a03:14b::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 21:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 21:28:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 15:28:16 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>
Subject: [PATCH v2 7/8] Documentation/gpu: Add an explanation about the DC
 weekly patches
Date: Mon, 22 Jan 2024 14:25:00 -0700
Message-ID: <20240122212719.647008-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
References: <20240122212719.647008-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|BL1PR12MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d10d5e2-7092-4719-4e48-08dc1b910db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdS68xb3hurzYhurNBWqiz3z5jYdDnNMaRN3WEzoH1bqJc7oKljRTQyUJtgGIZ9+fwVen09NhxeQ2rkTNnICwFhnhvF1OaKChRho7WkbXtTy6zLEb1kpci87Nw/mOJWYD3IqqMGrlb7cxrDpkv/M+nGn1Zyhg1QYLuCOUwr0zZk9vEm+QZ5qgdC6M6SbL5SS9Suow3z7PQvWDjPJJ3DemCrUJ7QQzRN3TYcZrFrCf+Y7Lbqs4S94oJ56ozp6hs0vQnGWXmWVljayveCku5zY+pMzBBcA9OZJGqP1TicXCimGaKq7uR3TVg8iYZfCgPLNsFjGxScLv5R6pkafBMRey6kqS2SvHBmyf3GnewsWY8VZ/Aml/VE8IfI5bNfAnY0TbJXKBC3VeVhpx4BhqGH2TOnyPSTG1YU9v265LOWfCulQOubnCkcidkteE00dLJBy1w1/i11wGpGbriToUuC5x2S/zNyF8M/6lQX0S6GnyiVlPe8QJCZHYgPqrl/IbxH+R4XNnNXPvU3D1rrlU0+Xd5nGUi4Jv6fvxrLBR8d2yXM/h1fKp64q2EQZ/YG7CC74uSeiyCYj5rawOnAeUqeBd8lTv1tUN0bgro0nqzdO7WY9tqDVhT5byIzMG5wLjI3ilk//FRwXApuWpWmp8R/0zZHFUj7o7CsozyaLLhKdj/ohgfaDRBcFOhVZv/rTW0fszlXug/B+0t8/yMS5QCCfEN3UqFjpC3YMoW2GwCVjGAW3KreQ0+8LKlvaZbFXUN+f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(46966006)(36840700001)(40470700004)(86362001)(316002)(54906003)(70206006)(70586007)(8936002)(8676002)(4326008)(478600001)(110136005)(2906002)(41300700001)(36756003)(5660300002)(83380400001)(40460700003)(40480700001)(47076005)(16526019)(26005)(66574015)(2616005)(1076003)(426003)(336012)(81166007)(36860700001)(356005)(82740400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:28:19.2540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d10d5e2-7092-4719-4e48-08dc1b910db0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
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
Cc: Harry Wentland <Harry.Wentland@amd.com>, Rodrigo
 Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit introduces some explanation about the display team
validation.

Changes since V1:
- Remove unprecise information about the DC process for now, can be
  added later on.
- Jani: Fix bullets

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/index.rst | 76 ++++++++++++++++++++--
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/index.rst b/Documentation/gpu/amdgpu/display/index.rst
index b09d1434754d..aa89e8f9ab89 100644
--- a/Documentation/gpu/amdgpu/display/index.rst
+++ b/Documentation/gpu/amdgpu/display/index.rst
@@ -7,18 +7,80 @@ drm/amd/display - Display Core (DC)
 AMD display engine is partially shared with other operating systems; for this
 reason, our Display Core Driver is divided into two pieces:
 
-1. **Display Core (DC)** contains the OS-agnostic components. Things like
+#. **Display Core (DC)** contains the OS-agnostic components. Things like
    hardware programming and resource management are handled here.
-2. **Display Manager (DM)** contains the OS-dependent components. Hooks to the
-   amdgpu base driver and DRM are implemented here.
+#. **Display Manager (DM)** contains the OS-dependent components. Hooks to the
+   amdgpu base driver and DRM are implemented here. For example, you can check
+   display/amdgpu_dm/ folder.
+
+------------------
+DC Code validation
+------------------
+
+Maintaining the same code base across multiple OSes requires a lot of
+synchronization effort between repositories and exhaustive validation. In the
+DC case, we maintain a tree to centralize code from different parts. The shared
+repository has integration tests with our Internal Linux CI farm, and we run a
+comprehensive set of IGT tests in various AMD GPUs/APUs (mostly recent dGPUs
+and APUs). Our CI also checks ARM64/32, PPC64/32, and x86_64/32 compilation
+with DCN enabled and disabled.
+
+When we upstream a new feature or some patches, we pack them in a patchset with
+the prefix **DC Patches for <DATE>**, which is created based on the latest
+`amd-staging-drm-next <https://gitlab.freedesktop.org/agd5f/linux>`_. All of
+those patches are under a DC version tested as follows:
+
+* Ensure that every patch compiles and the entire series pass our set of IGT
+  test in different hardware.
+* Prepare a branch with those patches for our validation team. If there is an
+  error, a developer will debug as fast as possible; usually, a simple bisect
+  in the series is enough to point to a bad change, and two possible actions
+  emerge: fix the issue or drop the patch. If it is not an easy fix, the bad
+  patch is dropped.
+* Finally, developers wait a few days for community feedback before we merge
+  the series.
+
+It is good to stress that the test phase is something that we take extremely
+seriously, and we never merge anything that fails our validation. Follows an
+overview of our test set:
+
+#. Manual test
+    * Multiple Hotplugs with DP and HDMI.
+    * Stress test with multiple display configuration changes via the user interface.
+    * Validate VRR behaviour.
+    * Check PSR.
+    * Validate MPO when playing video.
+    * Test more than two displays connected at the same time.
+    * Check suspend/resume.
+    * Validate FPO.
+    * Check MST.
+#. Automated test
+    * IGT tests in a farm with GPUs and APUs that support DCN and DCE.
+    * Compilation validation with the latest GCC and Clang from LTS distro.
+    * Cross-compilation for PowerPC 64/32, ARM 64/32, and x86 32.
+
+In terms of test setup for CI and manual tests, we usually use:
+
+#. The latest Ubuntu LTS.
+#. In terms of userspace, we only use fully updated open-source components
+   provided by the distribution official package manager.
+#. Regarding IGT, we use the latest code from the upstream.
+#. Most of the manual tests are conducted in the GNome but we also use KDE.
+
+Notice that someone from our test team will always reply to the cover letter
+with the test report.
+
+--------------
+DC Information
+--------------
 
 The display pipe is responsible for "scanning out" a rendered frame from the
 GPU memory (also called VRAM, FrameBuffer, etc.) to a display. In other words,
 it would:
 
-1. Read frame information from memory;
-2. Perform required transformation;
-3. Send pixel data to sink devices.
+#. Read frame information from memory;
+#. Perform required transformation;
+#. Send pixel data to sink devices.
 
 If you want to learn more about our driver details, take a look at the below
 table of content:
@@ -26,8 +88,8 @@ table of content:
 .. toctree::
 
    display-manager.rst
-   dc-debug.rst
    dcn-overview.rst
    dcn-blocks.rst
    mpo-overview.rst
+   dc-debug.rst
    dc-glossary.rst
-- 
2.43.0

