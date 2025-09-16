Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316B3CAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF70210E3D4;
	Tue, 16 Sep 2025 19:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l2uEe2gd";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F3310E3D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlkoqobPZC9vZOqRqd3nEVafcrgG2qs6GdJxBoMRzMZBcW7ecT9yYTg36a6gn8rbt7HXXLnPU4WyiSq6HWMcHx2ffgK40cS5vrE5wRGAF2dBWrzfTJ3uaojfW29Kt/Ek8Qf1u3PCAGio2zyXcNG/f9SkyWTjiz+exj0MQYBuBShUvXEVKegntuXfshvXJAE9e5ElYcMEWxwHg5IujYcZjPpM0ZZsIUvif4Aso+fJXC9jhfPjakdG7Xmszl+faOWC23sNqZAep0zcf//i8jlC9+2pgSBEuV+4wEbmCQyi+OWaZwKNKnE3kpmqokpf3qaUY0MIjIEZHI0w5ncZlXNOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqXJQjuAVSrlZILxNQkysZsjFnLhmvRBoZ9KxlxKGjU=;
 b=Bpe/mkIp+Pap3SpOMhhOyk3ifdC3AKpJlYGHjxPWvhQ0E/4aJTQQ7I/YElHVXRNxmO42S8GkSI44lXp/z5jgdgU8QZ5ZNuogVlKWXj9UAUtsrOORCBq4U/hTn9CLttjykdXOtYgBJ0F4vIsjUBE3SefAyYVDJ/YeiYPjGKM0z/FvLB8hLpMnDBQkWPGIjdZvtkcHLNrDF7AYUdZwvJCzfwMt1TFNoE0BlkoP65l4rx8yD7D1SJSJ5lpOlT42xzRXD/qx76L5I2iMMHiYBU2FBPdxlKThJKw5WaQ3oMiaBnF9S5h0ud4YvEOICIbNjX0ScIlWbQZYHJJ7qz0XBVmdyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqXJQjuAVSrlZILxNQkysZsjFnLhmvRBoZ9KxlxKGjU=;
 b=l2uEe2gdIhGBlj0M4OwCp0lQG0r2S1UpcvPvW8uwELkNCDRhRFsxcW3Hlw9pOcNJAHrwks8CySHhigsUJI98yv35sIFvyuuxdtiQupkSjo7yvEP5fUSwOxvoxzAvQJ1I1EbwvozGV+4n5r+PNae1Cyi1w5c9/N711AC8otoglOo=
Received: from DS7PR03CA0333.namprd03.prod.outlook.com (2603:10b6:8:55::15) by
 DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Tue, 16 Sep 2025 19:12:07 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::af) by DS7PR03CA0333.outlook.office365.com
 (2603:10b6:8:55::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:06 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:06 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:06 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/20] DC Patches September 15, 2025
Date: Tue, 16 Sep 2025 15:09:20 -0400
Message-ID: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: a02fc699-e818-4129-becc-08ddf554edbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnpNU0N2cm5FR3VaNHR3SGNZNGtYTjJCTWRMaE5CMUNFWmU4S2JpRGxYL0pm?=
 =?utf-8?B?OFhqYlNaMjVKdGUwYUVyWHQrclFzOFppc0pzbGpKR3VOVFBDSWp2dTEwZU9C?=
 =?utf-8?B?bDZCQjdHVXQxRWJKamdPVi9QcGNaZWQ3bExtOWlZd3ZEREkzaGMyV3FDNTY5?=
 =?utf-8?B?M2UrU294QkUzSXFxOU83a1FhcG5KV0dzVnloSisyenNCNTh2ak90RThSK2ww?=
 =?utf-8?B?aVp6aVFMM2dReHBVaDlSNjdBVUJ4VU1wWG91WS9EOXFkS21zVzVmUlBSN0NX?=
 =?utf-8?B?THB1TmtET3dtRGVpakdhdVlmTm01WWRqaURZSmR4R0x4UnZzSDh6dm1ubkhH?=
 =?utf-8?B?c0thYXV6d2hyMVBzVjVuRm1BbmhYcWwzL0hnSVY1dUZ1d0FFV1A2aVE0R3Nh?=
 =?utf-8?B?UVArOEpPdXdCYW5VekRCVkpTZ3ZVeXYzLzFVL21NZU5WUzhCUmFTNEpla2lP?=
 =?utf-8?B?MTQ4aXY1UUQyeEh3TVAxU044bkNUdi9meDFvZU9PU05wYkUzWWNEMnBYNHIy?=
 =?utf-8?B?ZkVLVjQvUDkzVzBidHlIenI2SCs4dklRNmJpVWFKc204QXdUWEZQWWgxY1l1?=
 =?utf-8?B?RzQwNFdqc04rSFNWNFJlKzZLZEE2QTlQclBMTlFWN2R4RStNMUV2MGFDSnZM?=
 =?utf-8?B?ejhxR1ZWU3Buc0VLditpUnpzdHRITjROTWlJbC9Td0lqQnVGZ1FQcWIzbGho?=
 =?utf-8?B?WlZzVkpESVRIb05leGdFZUk3YWdVem9Ca3VDOWR6U0RBSnJWKzR5NnVCZnVP?=
 =?utf-8?B?cFpJMUx5OTNPQlJrMGJiTXA0ZS9OUkhRekNuUzNMZmxwNWY4cGM0Y1B1c1NK?=
 =?utf-8?B?eGowdWlTdHJRWjlpTVVsQVUwVXBxejJYYjkydmFSdnpyZ0dJZmZ0ajA2TjJK?=
 =?utf-8?B?R2FGQzA2OExmd0R2NnVpZExGQ09VSGt3cWkrRTdBZkJtVWNVOVRmWndialFz?=
 =?utf-8?B?b2NBR1JJYmxCUmNESGIvMnpqUnRGV3UvZm5aeDRqNmxUWVZJUzZsRXNoTXVV?=
 =?utf-8?B?NGhNVTUwd2RsRTVXZ25jZ0tHVjZPWlBqTUhxWEt5a2VFaTR6d1ppVUtLa3JM?=
 =?utf-8?B?dTJKVWVCTUJjTmhtOEZVOHNPMjZBTUlHeklOZEJkdXJtaVRSYnNhVEVaSGJ2?=
 =?utf-8?B?aG5pakJyQVRCaHlDdUZET2xueGJpUDU0b3VLc212aFkwWkZHR0c2QXpMdmdz?=
 =?utf-8?B?NC9ZOE9FSTFYdHB3c1hKMStXRGM5bjMwelcvREtnaDJNdEVId0k3M2tYTGxD?=
 =?utf-8?B?VjIzVWRUWTlBZlpJeTBHQlVlZWM0UUFXTkdZMEdHdFlTeDBLUW5xUmVLOEJu?=
 =?utf-8?B?bitBTSszMzUrak9rMEdqSXU2SWQxQTdCWktTV2xxUFU1QlN4N0gwK1k1S3ht?=
 =?utf-8?B?d0ZUcktHSGpOYm5vWWRMdDQyUGlUSEFTbzlycUZrSWZISkg0VTd5WUUvQS9S?=
 =?utf-8?B?Zjg1MWZnYlRwQkRyRjlLZmhKTnlnZGFxTFZsMC9HWWRjTWJtTlFLNTFQaUpB?=
 =?utf-8?B?RjhwRDJsenZzT1ZUSmJBR2VFcERBa3A0WDV2czFvdDZVUk1LN2JMelVkdjg3?=
 =?utf-8?B?U0VXQStOZ0hXZkV2WHBxSUZaa1l5c2N3YzlMT3UyTitoeU5kYWRvamcyMzlm?=
 =?utf-8?B?Wnp0Z2Z3T0lNOVVXWktTa3IyK0FJU2F3R3hLZDhPS3d5emxqSWZ6ZVFtaTIy?=
 =?utf-8?B?ZmJFTW14cWk0bDR0QjZReWE0alI2ZFN0aHoyYWdpZENpWm0wT0RMT0MwOVI0?=
 =?utf-8?B?Q09YOWN1K1EzbXpIS2pOS0NkUkRuQVQxZjhsemF4UTh3WjJrR1YySUxzZFJr?=
 =?utf-8?B?akJhTnp0cGRmQks5NHErUVVGWk1nQk5jeHh1UlVlaXBlcFhySjh0aTQ2cXFS?=
 =?utf-8?B?NURYa0t0UUVJdzBVSHNFaXdiSlJVcldkbndxUEUyZjZKYVZ1K3RZaUhNQ3RM?=
 =?utf-8?B?N205ZWo0SzhIejN4azJwWjlxZlQzWmdsdDFwWUlSbzBabWwrYUYxdGJJeVEy?=
 =?utf-8?B?QTZiTTg5OCtkUVB1RDZ3NjBoTTQ3WG9rTGdLdnZjTHIwMEhCOEJuTXRQMWhm?=
 =?utf-8?Q?qo7dB8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:07.0429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a02fc699-e818-4129-becc-08ddf554edbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

    - Disable stutter when programming watermarks on dcn32
    - Improve brightness calculations
    - Fix saving vbios clocks during init for DCN314
    - Enable DTM 3 on DCN3.1+ dGPUs
    - Add new ultra sleep field in DMUB
    - Isolate DCN401 SMU functions
    - Refactor and add logging of SMU functions.
    - Add dccg logging
    - Fix DCN35 clocks initialization

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Allen Li (1):
  drm/amd/display: Add fast sync field in ultra sleep more for DMUB

Alvin Lee (1):
  drm/amd/display: Use mpc.preblend flag to indicate preblend

Charlene Liu (3):
  drm/amd/display: Insert dccg log for easy debug
  drm/amd/display: Correct sw cache timing to ensure dispclk ramping
  drm/amd/display: Revert "correct sw cache timing to ensure dispclk
    ramping"

Dillon Varone (6):
  drm/amd/display: Disable stutter when programming watermarks on dcn32
  drm/amd/display: Add missing post flip calls
  drm/amd/display: Isolate dcn401 SMU functions
  drm/amd/display: Refactor SMU tracing
  drm/amd/display: Set wm_pending when disable stutter w/a used
  drm/amd/display: Remove wm_optimized_required

Ivan Lipski (1):
  drm/amd/display: Enable DTM v3 on dGPUs with DCN 3.1+

Karthi Kandasamy (1):
  drm/amd/display: Add AVI infoframe copy in
    copy_stream_update_to_stream

Leo Li (1):
  drm/amd/display: Init DCN35 clocks from pre-os HW values

Lo-an Chen (1):
  drm/amd/display: Init dispclk from bootup clock for DCN314

Mario Limonciello (1):
  drm/amd/display: Handle interpolation for first data point

Paul Hsieh (1):
  drm/amd/display: Add monitor patch to read psr cap again

Sridevi Arvindekar (1):
  drm/amd/display: Fix for test crash due to power gating

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.28.0
  drm/amd/display: Promote DC to 3.2.351

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   4 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |   2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 142 +++++++++++++++++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   5 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 121 ++++++++++++++-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  26 ++--
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   | 130 +++++++++++++++-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   6 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  24 ++-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  11 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  38 ++++-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   8 +-
 .../link/protocols/link_edp_panel_control.c   |  14 ++
 .../dc/resource/dcn314/dcn314_resource.c      |   1 +
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 31 files changed, 556 insertions(+), 72 deletions(-)

-- 
2.43.0

