Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BAEC47DDC
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 21:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D3A10EFCC;
	Mon, 22 Jan 2024 21:28:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E0F10EFC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 21:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRXMWMYoLJLOI09hZiZkp71ubhI0IkaL6Oi0YU6QcjwzKAQiML/72E9h1EJsWH7S/R+WY04bdY6Mp9rhR2xzokLdCfXgJJV0Bmq/4fh/b5uORyRdcs108z7vnmWTbalKp17zPrk3DBOLxcIdKn82Aebh4cxHB07u+qh+zhsUzdf23NJJA7a4oSHyKUTNmqiYTHRPW1JzYdHP/dW4jI1VG0ew3JX+5UugdWsjfxxPwJKtN4DXvscmj5tAJSdpqEJw7b+rcjChie8UIzShxY6palvlFLp8DGFAFNHoK0dJX/MNFk9YZRMtayPL/5GsgaxD7bewZwqXk3ttvlb4LJIJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq5Yfn7t4Uc4FkejYl0LwWFZg0D+D/aX9HxRZWV1voI=;
 b=mD+KoQb41J4/4I8AkQQeeMERz+RyrWjtIG2FME8JHR/VM1PWCiLHQWoeNDs3XcbPaSM0BHgUhjpefZ/K0YqVgaMDrVn2o6G4CAxUMqwfEAKg5jX26WIH6U051Q2RmLu8ducfKV1wBWBZ5Lez2zs1tWcDFkoVeUdOm+3VIqrpfkjjyEFvHtdGGa8sfA1UnGO2hu1mfGMol81pqObgSFzq0BgGeOvi7V2HJ3ZHWZTT59BoMHWuQtljhzautOcwJj89se04d4KWs8eFOtURbOO7wp5rD8jjNtamJdrArXGQmZLhj2Ife87d6B8hmUsNiilR/axNc5psB44+hJtHMmiFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq5Yfn7t4Uc4FkejYl0LwWFZg0D+D/aX9HxRZWV1voI=;
 b=xxxfWt5d+NitUgpT14ChAvDqeqtBvWzvrnVUDNObIlkaM73JbjNlvcp6XQqCJ68T3WMYyNo9hQcZKjuJIlPNh29KjxmoyiD53pyuSh1SAwLMSeFlS8Ha4Aa+MDVR7ttFV0o7XVhmMRri0rQiiUyFFJGQLDdkkW98i65VBgZHsXI=
Received: from BYAPR06CA0062.namprd06.prod.outlook.com (2603:10b6:a03:14b::39)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 21:28:21 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::7d) by BYAPR06CA0062.outlook.office365.com
 (2603:10b6:a03:14b::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 21:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 21:28:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 15:28:18 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>
Subject: [PATCH v2 8/8] Documentation/gpu: Introduce a simple contribution
 list for display code
Date: Mon, 22 Jan 2024 14:25:01 -0700
Message-ID: <20240122212719.647008-9-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 071bd09f-93bc-4ae0-f3ea-08dc1b910e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGCzeR82ABD5gigF5NQj0lnumGAU6BEpvHmVxcDmuj/h/w8ZG2ZFA8AXUvq6qYrPerQbeEdR9sFdlVIIWAnwFCwq7grfDLg5VO+XLj1HR0iu9LIsY8xidrrXBSe3PnAQjJFbB8iWqmQhpAEAgiRWj3ntLmoM795SnMrK33eN/PNHeFFTr9g5fl3mACwK1Nf3kk4D4KvPo0eL80Sbe8muGwrWq7YEBb9RvCcV60FbhwZiYD/qnpQJ+1dSjQ+cvPrfhCY6WTW3XWyKUnrLHk0L7EjymkzVXXy0MAubFl0l1B67eu4iMq1OYyXsOZap46StpY9REV0uuzsDxCuPjs566tb+IkLctCr7lDqRpBe1/4QTcthEproKjUuE/1Di4YKH9j0MC3pWifDRC3LipV67swjH9lCdggehvqlf4VEunUkv0o5Sayw7Gf2X+ub14iJbuVzBTH0+O20nXNGUyEgVNqaJLGfxQpE74nWWeaJLS6aYskp0R0zYXpDgi0BYjmBRRC8/0swo/bjG79KWWjx2addOJ54FHt+AxlKuSZcx2dgT4ycjl4CYsruXk0LcHWxmzAUwGckHTwS8on1UA0KfZ3TmBQfl+zX4id+pXgdFU9I7klVB+VT97f6WgMje/toYb+4G6bRicRD5Ps/J54dFutajyV301WRZSiLDZgLYa0w6dEKAWMR1GElxg45YsVjQYHWfPY3GWkpLF7PvHOeVmEMhpTb6k2NYkcI2zI4OReMEANiGyvn+i46JsJj/9uEsSp4fWAv33P71lKkZKkCg11hyRVna7s7ShFkmPvoj//6Ju80x+MzIe5ueICPwJ1poGoxWC6y+uHJBQrpqXBHBzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(336012)(426003)(66574015)(54906003)(316002)(86362001)(40480700001)(40460700003)(966005)(83380400001)(47076005)(6666004)(110136005)(81166007)(82740400003)(8936002)(8676002)(36860700001)(4326008)(5660300002)(26005)(1076003)(16526019)(2616005)(478600001)(70206006)(70586007)(356005)(36756003)(30864003)(66899024)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:28:20.7383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071bd09f-93bc-4ae0-f3ea-08dc1b910e99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
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

This commit adds a contribution list for display under the kernel
documentation with some first suggestions. It also drops an old TODO
list from the display folder.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <Harry.Wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amdgpu/display/display-contributing.rst   | 168 ++++++++++++++++++
 Documentation/gpu/amdgpu/display/index.rst    |   1 +
 drivers/gpu/drm/amd/display/TODO              | 110 ------------
 3 files changed, 169 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/display/display-contributing.rst
 delete mode 100644 drivers/gpu/drm/amd/display/TODO

diff --git a/Documentation/gpu/amdgpu/display/display-contributing.rst b/Documentation/gpu/amdgpu/display/display-contributing.rst
new file mode 100644
index 000000000000..fdb2bea01d53
--- /dev/null
+++ b/Documentation/gpu/amdgpu/display/display-contributing.rst
@@ -0,0 +1,168 @@
+.. _display_todos:
+
+==============================
+AMDGPU - Display Contributions
+==============================
+
+First of all, if you are here, you probably want to give some technical
+contribution to the display code, and for that, we say thank you :)
+
+This page summarizes some of the issues you can help with; keep in mind that
+this is a static page, and it is always a good idea to try to reach developers
+in the amdgfx or some of the maintainers. Finally, this page follows the DRM
+way of creating a TODO list; for more information, check
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
+Fix compilation issues when using um architecture
+-------------------------------------------------
+
+Linux has a User-mode Linux (UML) feature, and the kernel can be compiled to
+the **um** architecture. Compiling for **um** can bring multiple advantages
+from the test perspective. We currently have some compilation issues in this
+area that we need to fix.
+
+Level: Intermediate
+
+Code Refactor
+=============
+
+Add prefix to DC functions to improve the debug with ftrace
+-----------------------------------------------------------
+
+The Ftrace debug feature (check 'Documentation/trace/ftrace.rst') is a
+fantastic way to check the code path when developers try to make sense of a
+bug. Ftrace provides a filter mechanism that can be useful when the developer
+has some hunch of which part of the code can cause the issue; for this reason,
+if a set of functions has a proper prefix, it becomes easy to create a good
+filter. Additionally, prefixes can improve stack trace readability.
+
+The DC code does not follow some prefix rules, which makes the Ftrace filter
+more complicated and reduces the readability of the stack trace. If you want
+something simple to start contributing to the display, you can make patches for
+adding prefixes to DC functions. To create those prefixes, use part of the file
+name as a prefix for all functions in the target file. Check the
+'amdgpu_dm_crtc.c` and `amdgpu_dm_plane.c` for some references. However, we
+strongly advise not to send huge patches changing these prefixes; otherwise, it
+will be hard to review and test, which can generate second thoughts from
+maintainers. Try small steps; in case of double, you can ask before you put in
+effort. We recommend first looking at folders like dceXYZ, dcnXYZ, basics,
+bios, core, clk_mgr, hwss, resource, and irq.
+
+Level: Starter
+
+Reduce code duplication
+-----------------------
+
+AMD has an extensive portfolio with various dGPUs and APUs that amdgpu
+supports. To maintain the new hardware release cadence, DCE/DCN was designed in
+a modular design, making the bring-up for new hardware fast. Over the years,
+amdgpu accumulated some technical debt in the code duplication area. For this
+task, it would be a good idea to find a tool that can discover code duplication
+(including patterns) and use it as guidance to reduce duplications.
+
+Level: Intermediate
+
+Make atomic_commit_[check|tail] more readable
+---------------------------------------------
+
+The functions responsible for atomic commit and tail are intricate and
+extensive. In particular `amdgpu_dm_atomic_commit_tail` is a long function and
+could benefit from being split into smaller helpers. Improvements in this area
+are more than welcome, but keep in mind that changes in this area will affect
+all ASICs, meaning that refactoring requires a comprehensive verification; in
+other words, this effort can take some time for validation.
+
+Level: Advanced
+
+Documentation
+=============
+
+Expand kernel-doc
+-----------------
+
+Many DC functions do not have a proper kernel-doc; understanding a function and
+adding documentation is a great way to learn more about the amdgpu driver and
+also leave an outstanding contribution to the entire community.
+
+Level: Starter
+
+Beyond AMDGPU
+=============
+
+AMDGPU provides features that are not yet enabled in the userspace. This
+section highlights some of the coolest display features, which could be enabled
+with the userspace developer helper.
+
+Enable underlay
+---------------
+
+AMD display has this feature called underlay (which you can read more about at
+'Documentation/GPU/amdgpu/display/mpo-overview.rst') which is intended to
+save power when playing a video. The basic idea is to put a video in the
+underlay plane at the bottom and the desktop in the plane above it with a hole
+in the video area. This feature is enabled in ChromeOS, and from our data
+measurement, it can save power.
+
+Level: Unknown
+
+Adaptive Backlight Modulation (ABM)
+-----------------------------------
+
+ABM is a feature that adjusts the display panel's backlight level and pixel
+values depending on the displayed image. This power-saving feature can be very
+useful when the system starts to run off battery; since this will impact the
+display output fidelity, it would be good if this option was something that
+users could turn on or off.
+
+Level: Unknown
+
+
+HDR & Color management & VRR
+----------------------------
+
+HDR, Color Management, and VRR are huge topics and it's hard to put these into
+concise ToDos. If you are interested in this topic, we recommend checking some
+blog posts from the community developers to better understand some of the
+specific challenges and people working on the subject. If anyone wants to work
+on some particular part, we can try to help with some basic guidance. Finally,
+keep in mind that we already have some kernel-doc in place for those areas.
+
+Level: Unknown
diff --git a/Documentation/gpu/amdgpu/display/index.rst b/Documentation/gpu/amdgpu/display/index.rst
index aa89e8f9ab89..f0c342e00a39 100644
--- a/Documentation/gpu/amdgpu/display/index.rst
+++ b/Documentation/gpu/amdgpu/display/index.rst
@@ -92,4 +92,5 @@ table of content:
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
2.43.0

