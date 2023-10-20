Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89804C25B42
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 22:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958AB10E5FF;
	Fri, 20 Oct 2023 22:06:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B237410E5FE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 22:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV9d7bQjRnzp1PBb21Yt3cQLoqNUu2c80D3rmjG9Mc+OmL27uUdP1BlR2hPiTPkLjRZmNMkimRn+cz1HCUjEsdRMQJC67OaZnxkdIfFyOyXe89nq0s9FMy3fpRhfRp1tHUDrZC7ACqiBwEeKpDTXyRZx2S2XmblXt0PqOwYfoK0WOxDyvA6sZVm7YCOjH4/u/2vxl6r/SsjWYE1Bvk8wEq0jkuOk/jMA/3inv3hw06r1AaiEF7E3CNVXvH/PARKGXZ+1D2HjuysVzZ4pA+QEypVJFZY4XdJLBmZRI+VhxV2sE+xWSXicrVpLblEdhWVl+P5VDEfXgEzbMH+nNUkvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBD1c6I/erM9D3IH7x76igDjzHH967Z6yrmpUW5gv/I=;
 b=WodiJfUSo88vVlu4NWIL8kWzXcMtB9dHcx90yTBH5tc0W9Pu5C3U/ZR9tDshPEQEsNkXhv1H1pb00PNVg9OvwA0utfgAe0uUXRh3vHvDiOOibYiUOXFja8UllbQC3NnX0lJNq8hznLXKIK7RVkkXQedrc4LFEHvXgCMxk0mJbQJXNfbautJp9qwZeOLbhiRkD5DoYFx85PSB+y4bvZPLSTfmeVyxE4Igg9a9vFma7Knmp2uAbkvqK3mUjr87GjUEAE4XnpfieekiHwRujwe+2Z1lJnCN1LEJsFXgk8fjv2dJyp+nU4dAqMp1BByolL5CrJfDQ2nLvGwHkHX/MmTZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBD1c6I/erM9D3IH7x76igDjzHH967Z6yrmpUW5gv/I=;
 b=xekg0Sf1C3q3fGaHwh1F+v6imuvzIhgOcYygpnRJquqaInnYbn1fHnIIABT304W7GQb5/2hfKHgSKb+2rLhemYtPWgRHjC3oZK/U20NakoUl9lk8BlrVauTTArTwrthyki1dPN0KTJIYhnp1teEKsyJzBRsZ7F8P4SP3NwzNw08=
Received: from MN2PR17CA0031.namprd17.prod.outlook.com (2603:10b6:208:15e::44)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 22:06:34 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::65) by MN2PR17CA0031.outlook.office365.com
 (2603:10b6:208:15e::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 22:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 22:06:34 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:06:33 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 7/8] Documentation/gpu: Add an explanation about the DC weekly
 patches
Date: Fri, 20 Oct 2023 16:05:20 -0600
Message-ID: <20231020220549.493808-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
References: <20231020220549.493808-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: bd24bf19-645e-47fa-c258-08dbd1b8d30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9H+Isnp2Ux1pxF1A7lYaD3WfPI14S1mYWOwKmadAldxKNaXueYXBAvifWyVlyIuehJXOuoIxi0qrxRpQQ/+0aT/XX0s4ohWEFjQK87NQrPCtmhd7tDfEVO5P38Mjkif/to/bFnHXLWYKINPO8MyhkAkQmEMdOEDh9mvfjZJVCgJc108qgA5gpM2cITVHWv40+JN3qlYFByoZKgAvgoVEQlAiMyz0uCzrBpB4P7y2LuHp+JywcJ2uQ/r/EYurGGE833wj/IzBqExiZizJ0WVuiFpuQ1PZ40m0sPGaBNzwKiDIrS/Jv1bdzwfg6wBqo6zJoR2OHLsjIzEc6usN3wX3vJ9mhrkvSwPtwEmR9k7YqEd5hSRz+ZuvFx9fnx+KzHTF9Pr0nZbvV/FouyqtCMT6AcaQ+XmuIGw7Gzne9cgQnd4D9DtDt0MZtB+kDo3bhp7/lgqJfL5OSGhHkz0FODRsxO1g5CJQnR0SUxrC33ayvf3NWmsZOCUSLGeZuKOSVQV29IuwuzsCk1x2g7FN9wrru8AfhiV3yLA68054C1n3JcaFpbXRm01Z4wPt7qymeGPRTg8ny62y/mac4Ja4N2PdEsuxt3r8g0WqDJjnzjZ3HMu8382nUzLmGsphv5u8CopzeVdlansoFLdog7dNaqmuaXJijpFuz1Ax7Qvi76lNC2PepiUwl1Z0YT6Ilh6lBUx/sG7LfZBwfDnWi5QmgWaUZscMcO7t/8zfaKHhHfGPAaI9mHATJa9EUidFKCPYJA7GxgtyEDK3hD4yjgY++RPjnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(26005)(40460700003)(40480700001)(66899024)(2906002)(316002)(70586007)(70206006)(110136005)(54906003)(8676002)(8936002)(6666004)(478600001)(36756003)(4326008)(86362001)(5660300002)(336012)(41300700001)(47076005)(2616005)(1076003)(36860700001)(82740400003)(16526019)(83380400001)(426003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:06:34.7472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd24bf19-645e-47fa-c258-08dbd1b8d30a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry
 Wentland <Harry.Wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sharing code with other OSes is confusing and raises some questions.
This patch introduces some explanation about our upstream process with
the shared code.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/index.rst | 111 ++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu/display/index.rst b/Documentation/gpu/amdgpu/display/index.rst
index b09d1434754d..9d53a42c5339 100644
--- a/Documentation/gpu/amdgpu/display/index.rst
+++ b/Documentation/gpu/amdgpu/display/index.rst
@@ -10,7 +10,114 @@ reason, our Display Core Driver is divided into two pieces:
 1. **Display Core (DC)** contains the OS-agnostic components. Things like
    hardware programming and resource management are handled here.
 2. **Display Manager (DM)** contains the OS-dependent components. Hooks to the
-   amdgpu base driver and DRM are implemented here.
+   amdgpu base driver and DRM are implemented here. For example, you can check
+   display/amdgpu_dm/ folder.
+
+--------------------
+How AMD shares code?
+--------------------
+
+Maintaining the same code-base across multiple OSes requires a lot of
+synchronization effort between repositories. In the DC case, we maintain a
+central repository where everyone who works from other OSes can put their
+change in this centralized repository. In a simple way, this shared repository
+is identical to all code that you can see in the display folder. The shared
+repo has integration tests with our Linux CI farm, and we run an exhaustive set
+of IGT tests in various AMD GPUs/APUs. Our CI also checks ARM64/32, PPC64/32,
+and x86_64/32 compilation with DCN enabled and disabled. After all tests pass
+and the developer gets reviewed by someone else, the change gets merged into
+the shared repository.
+
+To maintain this shared code working properly, we run two activities every
+week:
+
+1. **Weekly backport**: We bring changes from Linux to the other shared
+   repositories. This work gets massive support from our CI tools, which can
+   detect new changes and send them to internal maintainers.
+2. **Weekly promotion**: Every week, we get changes from other teams in the
+   shared repo that have yet to be made public. For this reason, at the
+   beginning of each week, a developer will review that internal repo and
+   prepare a series of patches that can be sent to the public upstream
+   (promotion).
+
+For the context of this documentation, promotion is the essential part that
+deserves a good elaboration here.
+
+Weekly promotion
+----------------
+
+As described in the previous sections, the display folder has its equivalent as
+an internal repository shared with multiple teams. The promotion activity is
+the task of 'promoting' those internal changes to the upstream; this is
+possible thanks to numerous tools that help us manage the code-sharing
+challenges. The weekly promotion usually takes one week, sliced like this:
+
+1. Extract all merged patches from the previous week that can be sent to the
+   upstream. In other words, we check the week's time frame.
+2. Evaluate if any potential new patches make sense to the upstream.
+3. Create a branch candidate with the latest amd-staging-drm-next code together
+   with the new patches. At this step, we must ensure that every patch compiles
+   and the entire series pass our set of IGT test in different hardware (i.e.,
+   it has to pass to our CI).
+4. Send the new candidate branch for an internal quality test and extra CI
+   validation.
+5. Send patches to amd-gfx for reviews. We wait a few days for community
+   feedback after sending a series to the public mailing list.  6. If there is
+   an error, we debug as fast as possible; usually, a simple bisect in the
+   weekly promotion patches points to a bad change, and we can take two
+   possible actions: fix the issue or drop the patch. If we cannot identify the
+   problem in the week interval, we drop the promotion and start over the
+   following week; in this case, the following promotion will have the previous
+   patches plus the new ones.
+
+We usually rotate the above process with many display developers to keep the
+workload manageable for everybody. It is good to highlight that the test phase
+is something that we take extremely seriously, and we never merge anything that
+fails our validation. Just to give an overview:
+
+1. Manual test
+ - Multiple Hotplugs with DP and HDMI.
+ - Stress test with multiple display configuration changes via the user
+   interface.
+ - Validate VRR behaviour.
+ - Check PSR.
+ - Validate MPO when playing video.
+ - Test more than two displays connected at the same time.
+ - Check suspend/resume.
+2. Automated test
+ - IGT tests in a farm with GPUs and APUs that support DCN and DCE.
+ - Compilation validation with the latest GCC and Clang from LTS distro.
+ - Cross-compilation for PowerPC 64/32, ARM 64/32, and x86 32.
+
+Notice that all of the above tests happen in various AMD devices.
+
+Contributions to the weekly promotion
+-------------------------------------
+
+If you have a patch and are unsure if it can cause regressions in other ASICs
+and want some validation, you can ask us to include your patches in the weekly
+promotion for validation. Just keep in mind that your patch will be included in
+the next promotion cycle and re-submitted on your behalf (without changing your
+authorship) by some of the display developers.
+
+The weekly promotion process is a very organic initiative that has changed
+significantly over the years, thanks to numerous feedbacks. We are all ears if
+you have any suggestions on how we can improve this process; just keep in mind
+that this is a very challenging task, and implementing some ideas can take time
+if possible.
+
+DC Workflow for a new feature
+-----------------------------
+
+When we enable a new feature in the DC, the entire development workflow happens
+on the amd-gfx mailing list. For example, when we enabled the PSR or the Replay
+feature, all the development happened on amd-gfx. When enabling a new feature,
+we just use promotion for extra validation in the latest patches by asking the
+quality team to test the current promotion together with the new patches.
+
+--------------
+DC Information
+--------------
 
 The display pipe is responsible for "scanning out" a rendered frame from the
 GPU memory (also called VRAM, FrameBuffer, etc.) to a display. In other words,
@@ -26,8 +133,8 @@ table of content:
 .. toctree::
 
    display-manager.rst
-   dc-debug.rst
    dcn-overview.rst
    dcn-blocks.rst
    mpo-overview.rst
+   dc-debug.rst
    dc-glossary.rst
-- 
2.42.0

