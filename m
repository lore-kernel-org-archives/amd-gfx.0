Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A8CC25B41
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 22:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BDB10E600;
	Fri, 20 Oct 2023 22:06:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8CA10E600
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 22:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMqt5wnP1PHRsxseX2Bd48W7FA5xS+aRmebcOa03AR/I//kD1n/yuXzB3qb9Rdt9qB+sAm+h/uWnsG05Mz7IJmnijcDY9bvK3yr/8e8QnWnhoTmNaFwxDLipb7vznzhOMEam5WSrq+nu12Nr7Yo91ZBnSDx7IKr94cebVbJpQ6W2tpMXCMeKUHzXLMG6j+DzbuCVH3g3HvxUaP0Dqq0yR03DVzMVtxZIR8e1GWQaBs6b5dVKLlG4/bjmbcxiIZCPIgVPXqZG6CJBOMisWqrAyig7PFuzV8X6/9EQKACY3LMz+d7f8Ps+QRTw6vI6jugnDpFS5xBBqww8/C7Njx/GVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mgb0A1iKUlpvT6CYW3a1fCouRt7A6GYkjFTMCfRBhS8=;
 b=DpSKgp9JxJAH/VTvtVe+9jkHhcAwi1PcYLXEbztvwAFrYYJ6Q/tqvhx8rIivC7SxpeFsE3npLpbL+U70Q/asozUhOSoKWA4DyIsecCh5so6fHwJ4R9bupHs+snPVU3Xc8tVI1pT2R1+FFR6MUQxkZ6MaubD6iJ9AtUl/PMZUF8wIllBuES8Y+hnxIw7sb9wyFt2QAE1vQb4BFNoK8vywHJdLzLDiMCl1zpqm+3di4uQ0KwrlcsgWG+NWySmULZR6ZurNSUl3fv101HMJUiHHoCZLwsoLbB0gIcwvhbGx4W8KQ4uUBYnUWBsDTHIDcoIk50/GcKdWdXQgrkjxhPkqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgb0A1iKUlpvT6CYW3a1fCouRt7A6GYkjFTMCfRBhS8=;
 b=XWR3m0kQCS3XZQpDrBdx0bBVMLgCsWhktSC6XswcrDBTFbvavFOPiqK+5b/JDSjPKsbDrhlmxNhIwr4BLUGZf0tSGvVtDyTj30xVM1mPASLVLgkWiRsNm/oGXjF1/InfwO99GWjd57BEfA10tOPH6zFK+UAvxpCTIouq1vBIOe8=
Received: from MN2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:208:23c::8)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 20 Oct
 2023 22:06:36 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::1b) by MN2PR18CA0003.outlook.office365.com
 (2603:10b6:208:23c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 22:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 22:06:35 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 17:06:34 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 8/8] Documentation/gpu: Introduce a simple contribution list
 for display code
Date: Fri, 20 Oct 2023 16:05:21 -0600
Message-ID: <20231020220549.493808-9-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 555ffef3-b296-48a3-06f0-08dbd1b8d3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omO3YVQLB6ca3NDYYpgPK21+ak8ROV49Tj2YGgLoAoHS+ggVO9K+7VKtlR4Cm2REL0rKL4TsGBYnb3RUI6Kk8MJY88satu19bdyYGgC7636ESphMJoNhEkP24QwJHO51MdBgFFF0zY/UaXXRAJ92saDj0XoxJjY7hhIGKuGA7Ua5rmR+Jn8CZWlWDI1U/Vm7+ZiaCRNMPjvz6E1LczbL6pyvF12R8RpSYvx9Jyt5pqNuJ0icPayMH60SN7J8GTCmRgcKXp9GGIxrZuMQJjuRY1VBRlxA6XUy//+TxCfXPRz+K7ZOWJF1aFrpdeSh/2aQC8MyYFZ4S5UPGnXowrqD4cfxddE5DlYcUCX955z2N3Y4EoqS6JdvO9WpA1aDBVKQPSkdm1pMfnRb2tPj2DsqffODMgswe2Kw6ZFijS2xpZy6HEoMqaG8fsYXQ+6wftYV+Ws9dT4Oaia6B8sNHbUgXFh2fJnuI+V2N7QqNJ8qgWPREJeSX3auNQc5BYlUbJLMaKd58yhuhpNOO1ST31KhG4Ifkp5hJ5e+1ZM+kcthcwKr1kCB9VSMH5DkkBcNgotMjLjWYrn0NZyNmadCrlY14dc8EVakDmWipXYmdDnsNdckIMiD32ptRhI2vcG/qm5jlItzLbaQxPJpmPhY7zzGVRgxUWXeZF+IbzP6CqwyKsyJAVolWqR7WPGt9HGaoUBRASYvHB8WG7GSG4cLu3Wz09cMVcAd6qc3oFr2NOsiTfdr8BOofaJgFxeBlVo5K6RHNfeQBlXw6AmJ3EsyoQ+4iyujKXJiuodVjpRGktW8Eos=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(6666004)(2616005)(1076003)(26005)(336012)(426003)(16526019)(83380400001)(966005)(356005)(110136005)(82740400003)(81166007)(36860700001)(47076005)(5660300002)(30864003)(40460700003)(36756003)(8676002)(4326008)(40480700001)(2906002)(316002)(41300700001)(8936002)(70206006)(70586007)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:06:35.8829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 555ffef3-b296-48a3-06f0-08dbd1b8d3b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

This commit adds a contribution list for display under the kernel
documentation with some first suggestions. It also drops an old TODO
list from the display folder.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amdgpu/display/display-contributing.rst   |  88 ++++++++++++++
 Documentation/gpu/amdgpu/display/index.rst    |  12 +-
 drivers/gpu/drm/amd/display/TODO              | 110 ------------------
 3 files changed, 95 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/display/display-contributing.rst
 delete mode 100644 drivers/gpu/drm/amd/display/TODO

diff --git a/Documentation/gpu/amdgpu/display/display-contributing.rst b/Documentation/gpu/amdgpu/display/display-contributing.rst
new file mode 100644
index 000000000000..0247e0579fd4
--- /dev/null
+++ b/Documentation/gpu/amdgpu/display/display-contributing.rst
@@ -0,0 +1,88 @@
+.. _display_todos:
+
+==============================
+AMDGPU - Display Contributions
+==============================
+
+First of all, if you are here, you probably want to give some technical
+contribution to the display code, and for that, we say thank you :)
+
+This page summarizes some of the issues you can help with. This page follows
+the DRM way of creating a TODO list; for more information, check
+'Documentation/gpu/todo.rst'.
+
+Gitlab issues
+=============
+
+Users can report issues associated with AMD GPUs at:
+
+- https://gitlab.freedesktop.org/drm/amd
+
+Usually, we try to add a proper label to all new tickets to make it easy to
+filter issues. If you can reproduce any problem, you could help by adding more
+information or fixing the issue.
+
+Level: diverse
+
+IGT
+===
+
+`IGT`_ provides many integration tests that can be run on your GPU. We always
+want to pass a large set of tests to increase the test coverage in our CI. If
+you wish to contribute to the display code but are unsure where a good place
+is, we recommend you run all IGT tests and try to fix any failure you see in
+your hardware. Keep in mind that this failure can be an IGT problem or a kernel
+issue; it is necessary to analyze case-by-case.
+
+Level: diverse
+
+.. _IGT: https://gitlab.freedesktop.org/drm/igt-gpu-tools
+
+Compilation
+===========
+
+Fix compilation warnings
+------------------------
+
+Enable the W1 or W2 warning level in the kernel compilation and try to fix the
+issues on the display side.
+
+Level: Starter
+
+Code Refactor
+=============
+
+Add prefix to DC functions to improve the debug with ftrace
+-----------------------------------------------------------
+
+The Ftrace debug feature (check 'Documentation/trace/ftrace.rst') is a
+fantastic way to check the code path when developers are trying to make sense
+of a bug. Ftrace provide a filter mechanism that can be useful when the
+developer has some hunch of which part of the code can cause the issue; for
+this reason, if a set of function has a proper prefix, it becomes easy to
+create a good filter. The DC code does not follow some prefix rules, which
+makes the Ftrace filter more complicated. If you want something simple to start
+contributing to the display, you can make patches for adding prefixes to DC
+functions. To create those prefixes, use part of the file name as a prefix for
+all functions in the target file. Check the 'amdgpu_dm_crtc.c` and
+`amdgpu_dm_plane.c` for some references.
+
+Level: Starter
+
+
+Try to move some of the sink handling code to DRM
+-------------------------------------------------
+
+When amdgpu was upstream for the first time, developers discussed how AMD
+display handles sink. From the conversation, developers concluded that we
+should move some of those codes to the DRM helpers/core in the long term.
+
+Level: Advanced
+
+Simplify DDC
+------------
+
+We can probably remove vector.c from dc/basics. It's used in DDC code which can
+probably be simplified enough to no longer need a vector implementation.
+
+Level: Advanced
diff --git a/Documentation/gpu/amdgpu/display/index.rst b/Documentation/gpu/amdgpu/display/index.rst
index 9d53a42c5339..25445a50121e 100644
--- a/Documentation/gpu/amdgpu/display/index.rst
+++ b/Documentation/gpu/amdgpu/display/index.rst
@@ -109,11 +109,12 @@ if possible.
 DC Workflow for a new feature
 -----------------------------
 
-When we enable a new feature in the DC, the entire development workflow happens
-on the amd-gfx mailing list. For example, when we enabled the PSR or the Replay
-feature, all the development happened on amd-gfx. When enabling a new feature,
-we just use promotion for extra validation in the latest patches by asking the
-quality team to test the current promotion together with the new patches.
+When an AMD developer enables a new feature in the DC, the entire development
+workflow happens on the amd-gfx mailing list. For example, when we enabled the
+PSR or the Replay feature, all the development happened on amd-gfx. When
+enabling a new feature, we just use promotion for extra validation in the
+latest patches by asking the quality team to test the current promotion
+together with the new patches.
 
 --------------
 DC Information
@@ -137,4 +138,5 @@ table of content:
    dcn-blocks.rst
    mpo-overview.rst
    dc-debug.rst
+   display-contributing.rst
    dc-glossary.rst
diff --git a/drivers/gpu/drm/amd/display/TODO b/drivers/gpu/drm/amd/display/TODO
deleted file mode 100644
index a8a6c106e8c7..000000000000
--- a/drivers/gpu/drm/amd/display/TODO
+++ /dev/null
@@ -1,110 +0,0 @@
-===============================================================================
-TODOs
-===============================================================================
-
-1. Base this on drm-next - WIP
-
-
-2. Cleanup commit history
-
-
-3. WIP - Drop page flip helper and use DRM's version
-
-
-4. DONE - Flatten all DC objects
-    * dc_stream/core_stream/stream should just be dc_stream
-    * Same for other DC objects
-
-    "Is there any major reason to keep all those abstractions?
-
-    Could you collapse everything into struct dc_stream?
-
-    I haven't looked recently but I didn't get the impression there was a
-    lot of design around what was public/protected, more whatever needed
-    to be used by someone else was in public."
-    ~ Dave Airlie
-
-
-5. DONE - Rename DC objects to align more with DRM
-    * dc_surface -> dc_plane_state
-    * dc_stream -> dc_stream_state
-
-
-6. DONE - Per-plane and per-stream validation
-
-
-7. WIP - Per-plane and per-stream commit
-
-
-8. WIP - Split pipe_ctx into plane and stream resource structs
-
-
-9. Attach plane and stream reources to state object instead of validate_context
-
-
-10. Remove dc_edid_caps and drm_helpers_parse_edid_caps
-    * Use drm_display_info instead
-    * Remove DC's edid quirks and rely on DRM's quirks (add quirks if needed)
-
-    "Making sure you use the sink-specific helper libraries and kernel
-    subsystems, since there's really no good reason to have 2nd
-    implementation of those in the kernel. Looks likes that's done for mst
-    and edid parsing. There's still a bit a midlayer feeling to the edid
-    parsing side (e.g. dc_edid_caps and dm_helpers_parse_edid_caps, I
-    think it'd be much better if you convert that over to reading stuff
-    from drm_display_info and if needed, push stuff into the core). Also,
-    I can't come up with a good reason why DC needs all this (except to
-    reimplement half of our edid quirk table, which really isn't a good
-    idea). Might be good if you put this onto the list of things to fix
-    long-term, but imo not a blocker. Definitely make sure new stuff
-    doesn't slip in (i.e. if you start adding edid quirks to DC instead of
-    the drm core, refactoring to use the core edid stuff was pointless)."
-    ~ Daniel Vetter
-
-
-11. Remove dc/i2caux. This folder can be somewhat misleading. It's basically an
-overy complicated HW programming function for sendind and receiving i2c/aux
-commands. We can greatly simplify that and move it into dc/dceXYZ like other
-HW blocks.
-
-12. drm_modeset_lock in MST should no longer be needed in recent kernels
-    * Adopt appropriate locking scheme
-
-13. get_modes and best_encoder callbacks look a bit funny. Can probably rip out
-a few indirections, and consider removing entirely and using the
-drm_atomic_helper_best_encoder default behaviour.
-
-14. core/dc_debug.c, consider switching to the atomic state debug helpers and
-moving all your driver state printing into the various atomic_print_state
-callbacks. There's also plans to expose this stuff in a standard way across all
-drivers, to make debugging userspace compositors easier across different hw.
-
-15. Move DP/HDMI dual mode adaptors to drm_dp_dual_mode_helper.c. See
-dal_ddc_service_i2c_query_dp_dual_mode_adaptor.
-
-16. Move to core SCDC helpers (I think those are new since initial DC review).
-
-17. There's still a pretty massive layer cake around dp aux and DPCD handling,
-with like 3 levels of abstraction and using your own structures instead of the
-stuff in drm_dp_helper.h. drm_dp_helper.h isn't really great and already has 2
-incompatible styles, just means more reasons not to add a third (or well third
-one gets to do the cleanup refactor).
-
-18. There's a pile of sink handling code, both for DP and HDMI where I didn't
-immediately recognize the standard. I think long term it'd be best for the drm
-subsystem if we try to move as much of that into helpers/core as possible, and
-share it with drivers. But that's a very long term goal, and by far not just an
-issue with DC - other drivers, especially around DP sink handling, are equally
-guilty.
-
-19. DONE - The DC logger is still a rather sore thing, but I know that the
-DRM_DEBUG stuff just isn't up to the challenges either. We need to figure out
-something that integrates better with DRM and linux debug printing, while not
-being useless with filtering output. dynamic debug printing might be an option.
-
-20. Use kernel i2c device to program HDMI retimer. Some boards have an HDMI
-retimer that we need to program to pass PHY compliance. Currently that's
-bypassing the i2c device and goes directly to HW. This should be changed.
-
-21. Remove vector.c from dc/basics. It's used in DDC code which can probably
-be simplified enough to no longer need a vector implementation.
-- 
2.42.0

