Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93574606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=282m1yZH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66DE10F8AA;
	Wed, 11 Nov 2026 01:40:32 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578D810F8A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGfq08kELzh8bM6fVcQTiYKC3WDl9aaMUeIfMupMX6bZK27dS8KFnp75Xwgxqun7TEQJQudwF7jMJKAERYIxtJRdJWg9iue7lSNDC9Nyob5yWiKiCJrkgIsymkVqe6XMZTuQMfd7BAELd0TEQs7TTRKCVIcxQYVhHWcZyEIS8BW8Kh1lbJAA6fnePY6RjwyefGj4xqm26W7v0NWkn16br+xhjSrdzTWllmZHg2O+dll1wFTZIEw69uySiHEgJ7lDSwfz5UDYFptsXcATc/Uyz9JOw3eseUKOLiWoz2/zYmUblrFM+YCRCnBpdwWD3ovNfyxargBiJvC9UbpoOqmgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qco5EP8nH3/FMBRPcja9DQUPvH6MAjSuoGSk/ABrCU=;
 b=sQ1DaGd9VO4fCYAwgZwR1tvpWZJNSmx3kwLes3qbDrXX0txmAbJ2p2AIW9qvDm3rxYYQjwpgXCVnqJdwGAnMffZBt9Wg15kvRA56YHeSqlJRmfv47SFn+LVKIjQZ/zVBomo7A9dRP94fmvC2+CSUOydB+hlPBJnQiaSdHz7Fp2ZyQjwf4VevY2gOJ9CUtBsOT/shpa//fGcywJGOAPyLO171AjQ9O89NfhOuY5B7H3TDOISel17p6WboYuorfnJ04YrgCqsZGe6DNIuCDcAqydx/O0i+W27oC6CUGvxroEUOJrW9B+SACVz10XG5fNX0m1Z6a0ug7ui+AcomdSUOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qco5EP8nH3/FMBRPcja9DQUPvH6MAjSuoGSk/ABrCU=;
 b=282m1yZHYSv9h0gRJfQdtk/AhDNQTqr+zGPllf/GmivApLxF8mou6tlXDs1uRGNQJ8XkryLjf9oKCd0nifz1NIDrQoHNh6+5g1+Gnew3uur4iTJfoaXLT0X7mS1k44jLCGVg11gk0aPgygCUoHlIMnfxZPyQOj+aojuAxAZur5g=
Received: from SJ0PR05CA0121.namprd05.prod.outlook.com (2603:10b6:a03:33d::6)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:40:19 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::87) by SJ0PR05CA0121.outlook.office365.com
 (2603:10b6:a03:33d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:40:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:18 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:10 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 00/74] DC Patches November 16, 2026
Date: Wed, 11 Nov 2026 09:28:06 +0800
Message-ID: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 353f514d-fa54-4498-91c4-08df3f94be70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|10067099003|261009223027099003|261026140227099003|3023799007|261028144727099003|261022113327099003|261021121427099003|261021123027099003|261022075727099003|261102123227099003|261022105027099003|261026121527099003|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: izP7cftzZh/KJzHW4wflmTihXkzVHPVZ7nzry/wteIrX4ecIEzxFQ4QOZQP3lMZdZCJ1xes/cbViE6rvbI3ck/kfjm78GtrpGsK8yUbLlr1FBW+LDd996RLKmotAupHM7BODaD6mA9CGjqTE4xjFXL0hXOVz6N0ztwdD0HF2oRzHvm4hGxQxc9rZbEJb0okqlZ8oNpXkweEUtXeda/gx8CAJ9MsMQrM5C5rFyNKo/FvNPRyc/ig5geAt9Jf+IGUPqZsuEEJfhKRAowme+j63D2u4rSbS+9fJUFK+pucA9yiUzFdzeeLhxOTJogrH2XsrK62VJhlGSI40FyXRlZFX7nmouxkyQw6HoA4GPBMhdeOoRcUagFzxj2oDV2t3WOVwlcTYnNMbYPIWX+3qXp6HZz3K2zmsoRq3TiPSdjtQ0zz0uOyNAmL3KaAMhh0ZydlYyYnAgjL3S+gvB7+tVDfTo+/FEgogsZH+c0ndhQgWgIMu0AW5UQA7iKofeaCBqjTY8LvoOVXVNYvJjiuD0Z/dudpDmFbut+VJ7iXtKw243E9sZQTgcS6xtjQdwxqNjbgD9pkCloI5e5aLcJc40PGOMDXAsydpsu59cuBcVf7xssS5HYOZcfQEufJYVP6MkMb3CR0EwkEnuzK4xacZPW0AXGVxYF7aFpvb8Xph1ciAvV7WsIwEA3DbxREKeTwl1pj+MT8STaSfqtFzn1H8oiF+yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(10067099003)(261009223027099003)(261026140227099003)(3023799007)(261028144727099003)(261022113327099003)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026121527099003)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jp2Ynuukum3hU2TNm0a8LpOOmiRYvJzezP7BbINb/NOwcs0+PXARf2V6B71d29Ow5rNErkul+O788ImPk/THn8vwBVr0W6Tlc4A/evKCyQpOdKRLjeniRV55miyFgp5HXLsXAjcHaCQTmdq8QZtP9fFnzm0uOgd4YlXY7oaj4tiqjWGqmW2xXjSxsJ/EmpIzxntc2EIryxhnVYqt5Z5o5ET1LO7GCIjeV+AcNA/cUFgWlLODouA2WQJjppN6+WBkXUSCzHc8XSY+/yQCCRfOptB1cC4d9RpPGfqwB+kBoo8FmYsYa3wIuvtZO6RbERSQyzb4rUZl0gxq6+q7DhNl9m2t1Fc5TZ6tXZSic8+zX3tN5PDDaGAD9eWpNqw9/kt71RIkGEXjMfpsfZaVZadePnbnJeTLfcd+JNwlWZuCjbKg9GQtT0VsX/YF9WDCca5v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:19.1881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353f514d-fa54-4498-91c4-08df3f94be70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Build DCN401 virtual commits and seamless plane updates in DC2, and
  dispatch the hardware span of a commit through dc2_funcs.
- Add the leaf block-sequence entries a virtual commit needs, and read
  the accelerated-mode bit through a query builder.
- Resolve watermark policy and the DPP, DTBCLK and DCN401 DENTIST
  targets when the sequence is built.
- Fix DSC teardown gating in the post-unlock sequence.
- Move HDMI FRL status polling outside dc_lock and stop it on fini.
- Relax stutter constraints for DRR streams, including ramless idle,
  track static-screen idle, and enable the relaxation on DCN42. Raise
  the DCN42 DDR5 stutter latency.
- Let DC_PSR_MASK enable PSR without a DMUB PSR cap.
- Enable HDCP on DCN6 and the DF C-state vote on DCN42B.
- Enable SST PCON FRL DSC passthrough and program the correct DP HPO
  APG instance.
- Exit IPS before checking flip pending, and keep the HPD IRQ reset
  path from taking dc_lock.
- Skip UPSP programming when the registers are absent, and skip
  visual confirm color programming when firmware owns it.
- Align DCN42B with DCN42 and extend the IOMMU mismatch workaround to
  DCN42B. Restore the missing DCN6 vtotal cap and vstartup assignment.
- Update the DMUB interface to 0.1.83.0 with an extended SoC bounding
  box, RAMLESS_LOBF commands, and a seamless-boot eDP request.
- Initialize the DMUB LSDMA ring, accept a 1932-byte PSP footer, and
  update the default VCO frequency.
- Fix the FFE link-rate change path and the p-state enable sequence.
  Commit the validated target when a minimal transition cannot be
  built.
- Fix KUnit tiled EDID size
- fix hubbub read state logging
- skip_lcdvdd_off for eDP link lost retrain
- Don't shrink zero-area recout in full viewport visual confirm
- panel specific wa not fall back to tmds
- Use expanded DMUB-provided SoC BB and IP caps
- Only force P-State on first plane if TTU is below WM
- Program the kept-plane scaler in DC2
- Add and remove two MPO planes in DC2
- Add DC2 state facts and split the builders
- Program DC2 commit stereo once
- Maximum SOP states is 8
- Use soc_bb hostvm fraction instead of hardcoded value
- Increase state if dcfclk deep sleep needed exceeds dcfclk
- Flip dml2_core_utils_get_segment_horizontal_contiguous() Inputs
- Update DCN6 Calcs
- Add effective_number_of_dpp parameter
- Read DRAM channel width from SMU init table
- Update DCN42B stutter latency to match DCN42
- Expect VRAM|GTT for the DMUB framebuffer
- Report QoS latency bounds and request
- upsp fixes
- Limit VRAM aperture retrieval to DCN6
- Make DPP_PG_CONTROL and HUBP_PG_CONTROL BLS compliant
- Seed boot clocks to avoid lowering pre-OS display clocks
- Account for split pipe overlap in alt channel copy size
- Get OPP heads and DPP pipes by stream in dc_resource
- Program ODM 2:1 and 3:1 on one stream in DC2
- Enable Replay timing sync by default
- Various cleanups.

---

Alex Hung (2):
  drm/amd/display: Fix elapsed time indentation
  drm/amd/display: Fix KUnit tiled EDID size

Allen Pan (1):
  drm/amd/display: Update DCN42B stutter latency to match DCN42

Alvin Lee (4):
  drm/amd/display: Update indicate pstate enable sequence
  drm/amd/display: Update DP HPO to use correct APG instance
  drm/amd/display: Updating missing assignments for DCN6
  drm/amd/display: Don't shrink zero-area recout in full viewport visual
    confirm

Aric Cyr (1):
  drm/amd/display: Ensure exit IPS before checking flip status

Ashwin Santhosh (2):
  drm/amd/display: Skip visual confirm color programming when FW owns it
  drm/amd/display: Account for split pipe overlap in alt channel copy
    size

Austin Zheng (5):
  drm/amd/display: Fix Stage Optimizer Parameter Naming
  drm/amd/display: Read DCN6 SOP constraints from the idle row
  drm/amd/display: Use soc_bb hostvm fraction instead of hardcoded value
  drm/amd/display: Flip
    dml2_core_utils_get_segment_horizontal_contiguous() Inputs
  drm/amd/display: Add effective_number_of_dpp parameter

Charlene Liu (6):
  drm/amd/display: Extend the IOMMU mismatch workaround to DCN42B
  drm/amd/display: update dcn42b based on dcn42
  drm/amd/display: enable DF C-state vote on DCN42B
  drm/amd/display: Increase the DCN42 DDR5 stutter latency
  drm/amd/display: Keep panel power across link-loss retrain
  drm/amd/display: Keep patched HDMI panels on FRL across detect

Dillon Varone (3):
  drm/amd/display: Relax stutter constraints for DRR streams
  drm/amd/display: cleanup tiling and address formats
  drm/amd/display: Enable DRR stutter constraint relaxation on DCN42

Eric Bernstein (1):
  drm/amd/display: Skip UPSP programming when UPSP regs are absent

Fangzhi Zuo (4):
  drm/amd/display: Correct the forced YCbCr420 comment
  drm/amd/display: Move HDMI FRL Polling Outside dc_lock
  drm/amd/display: Stop HDMI FRL status polling on fini
  drm/amd/display: Enable SST PCON FRL DSC passthrough

Gabriel Abarca (2):
  drm/amd/display: Increase state if dcfclk deep sleep needed exceeds
    dcfclk
  drm/amd/display: Update DCN6 Calcs

George Zhang (1):
  drm/amd/display: Don't let HPD IRQ handler take dc_lock in reset

Ilya Bakoulin (1):
  drm/amd/display: Fix FFE test automation link rate change

Ivan Lipski (4):
  drm/amd/display: Initialize DMUB LSDMA ring buffer
  drm/amd/display: Enable HDCP on DCN6
  drm/amd/display: Use expanded DMUB-provided SoC BB and IP caps
  drm/amd/display: Limit VRAM aperture retrieval to DCN6

James Lin (1):
  drm/amd/display: commit validated target when minimal transition
    cannot be built

Jing Zhou (1):
  drm/amd/display: Seed boot clocks to avoid lowering pre-OS display
    clocks

Karen Chen (1):
  drm/amd/display: fix hubbub read state logging

Nevenko Stupar (1):
  drm/amd/display: Update default VCO frequency

Ovidiu Bunea (1):
  drm/amd/display: Only force P-State on first plane if TTU is below WM

Piotr Maziarz (3):
  drm/amd/display: Resolve clk_mgr DPP DTO targets when the sequence is
    built
  drm/amd/display: Resolve clk_mgr DTBCLK DTO targets when the sequence
    is built
  drm/amd/display: Resolve the DCN401 DENTIST divider when the sequence
    is built

Rafal Ostrowski (4):
  drm/amd/display: Remove duplicate block sequence leftovers
  drm/amd/display: HWSS Refactor - Watermarks
  drm/amd/display: Fix DSC teardown gating in post-unlock BLS sequence
  drm/amd/display: Make DPP_PG_CONTROL and HUBP_PG_CONTROL BLS compliant

Ray Wu (2):
  drm/amd/display: Allow DC_PSR_MASK to enable PSR without DMUB PSR cap
  drm/amd/display: Enable Replay timing sync by default

Sreeja Golui (2):
  drm/amd/display: Include Ramless Idle in stutter relaxation
  drm/amd/display: detect static screen state and propagate

Sridevi Arvindekar (1):
  drm/amd/display: Bypass chroma upsampling without the DPP cap

Taimur Hassan (4):
  drm/amd/display: [FW Promotion] Release 0.1.83.0
  drm/amd/display: Promote DC to 3.2.406
  drm/amd/display: [FW Promotion] Release 0.1.84.0
  drm/amd/display: Promote DC to 3.2.407

Tony Cheng (13):
  drm/amd/display: Dispatch commit_state_hw through dc2_funcs
  drm/amd/display: Add leaf BLS entries for a virtual commit
  drm/amd/display: Build the dcn401 virtual commit natively
  drm/amd/display: Build the dcn401 seamless update in DC2
  drm/amd/display: Read accelerated mode through a query builder
  drm/amd/display: Build the kept-plane surface update in DC2
  drm/amd/display: Skip first-enable steps on a kept plane
  drm/amd/display: Program the kept-plane scaler in DC2
  drm/amd/display: Add and remove two MPO planes in DC2
  drm/amd/display: Add DC2 state facts and split the builders
  drm/amd/display: Program DC2 commit stereo once
  drm/amd/display: Get OPP heads and DPP pipes by stream in dc_resource
  drm/amd/display: Program ODM 2:1 and 3:1 on one stream in DC2

Wayne Lin (1):
  drm/amd/display: Expect VRAM|GTT for the DMUB framebuffer

Wenjing Liu (2):
  drm/amd/display: Read DRAM channel width from SMU init table
  drm/amd/display: Report QoS latency bounds and request

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   17 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   15 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   10 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    3 +-
 .../tests/amdgpu_dm_connector_test.c          |    9 +-
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |   45 +-
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     |   27 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |    6 +
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |   35 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    3 +
 .../amd/display/dc/bls_builder/bls_builder.h  |    6 +-
 .../dc/bls_builder/bls_builder_internal.h     |    2 +
 .../bls_builder/bls_builder_private_types.h   |  137 +
 .../dc/bls_builder/dcn401_builder_internal.h  |  110 +
 .../dc/bls_builder/dcn401_init_builder.c      |   36 +
 .../bls_builder/dcn401_non_seamless_builder.c |  501 ++++
 .../dc/bls_builder/dcn401_seamless_builder.c  | 2235 +++++++++++++++++
 .../display/dc/bls_executor/bls_executor.c    | 1076 ++++++++
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   83 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  170 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   15 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   31 +-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   25 +-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h        |    1 +
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |    3 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  157 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |   14 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  115 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  317 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   48 +-
 .../amd/display/dc/core/dc_resource_helper.c  |    7 +-
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  341 ++-
 .../gpu/drm/amd/display/dc/core2/dc_core2.h   |    1 +
 .../drm/amd/display/dc/core2/dc_core2_init.c  |    2 +-
 .../display/dc/core2/dc_core2_legacy_init.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 .../amd/display/dc/dc_api_dispatch/api_shim.c |   25 +
 .../amd/display/dc/dc_api_dispatch/api_shim.h |    9 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    1 +
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   16 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |    8 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    3 +
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |    4 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |    4 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |    1 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    2 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |    2 +
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   75 +-
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |   30 +-
 .../dml2_core_dcn6_funcs_mode_programming.c   |   34 +-
 .../dml2_core_dcn6_funcs_mode_support.c       |   19 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    3 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |    4 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   20 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h |    4 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h |    8 +-
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   19 +-
 .../src/inc/dml2_internal_shared_types.h      |    4 +-
 .../dml21_wrapper/dml21_translation_helper.c  |   17 +-
 .../dc/dml2_wrapper/dml2_mall_phantom.c       |    1 -
 .../display/dc/dml2_wrapper/dml2_wrapper.h    |    1 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |    2 +-
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |    4 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |    3 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |    1 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |    8 +-
 .../display/dc/hubbub/dcn201/dcn201_hubbub.c  |    3 +-
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |    3 +-
 .../display/dc/hubbub/dcn21/dcn21_hubbub.h    |    1 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |    5 +-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |    1 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |    5 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |   23 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |    7 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |    1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   12 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |    3 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   20 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |    3 +-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |   52 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   61 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    9 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   48 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    9 +-
 .../amd/display/dc/hwss/dcn302/dcn302_hwseq.c |   15 +-
 .../amd/display/dc/hwss/dcn302/dcn302_hwseq.h |    6 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c |   11 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.h |    6 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |    3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   15 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |    3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    7 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |    3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  180 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    2 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |    9 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    1 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  422 +++-
 .../display/dc/hwss/hw_sequencer_private.h    |   14 +-
 .../amd/display/dc/inc/dc_core_interface.h    |   12 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   38 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   22 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   21 +-
 .../display/dc/inc/soc_and_ip_translator.h    |    4 +-
 .../drm/amd/display/dc/link/link_detection.c  |   26 +
 .../dc/link/protocols/link_dp_irq_handler.c   |    8 +-
 .../display/dc/link/protocols/link_hdmi_frl.c |   30 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    2 +
 .../dc/resource/dcn42b/dcn42b_resource.c      |    5 +-
 .../dc/resource/dcn60/dcn60_resource.c        |   30 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |    4 +-
 .../dcn42/dcn42_soc_and_ip_translator.c       |    4 +-
 .../dcn42b/dcn42b_soc_and_ip_translator.c     |    4 +-
 .../dcn60/dcn60_soc_and_ip_translator.c       |   96 +-
 .../amd/display/dc/state_facts/state_facts.c  |  294 +++
 .../amd/display/dc/state_facts/state_facts.h  |  132 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  213 +-
 .../amd/display/modules/power/power_replay.c  |    2 +-
 125 files changed, 6985 insertions(+), 905 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_builder_internal.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_non_seamless_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_seamless_builder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/state_facts/state_facts.h

-- 
2.43.0

