Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D10E8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A595710E053;
	Tue,  3 Feb 2026 15:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TFG2tWUk";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27AAD10E053
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnjyjxJHMhVl/ZdIVMGt/QzUr2/Z973HSV51nMANscGNiCDQYoneXi9T+3ObPlNF22Yx/afKdkLUUNYVANirCeh/aroOqlO6MDotzuK20dIjeuxBOIASOpdG5ZFmhRMdb9lDfX21icFe/qLciKRWD47A8FUn+3LGWC8XNnXZmvKdb+1wB/XUBbxWhUk7yixsv7EyGKMgT+8x0iLm/Ssl1z73HbyknwuSo3qDJYUrKW4Vlr6dT21Y066NX24R0+QcfSJgH3xc5IT2Vy4wtdyma/py1K+74JC68Osz58c1dnD31pYagODf4gOhbS2zxhcat+y+AjwYlvW4VdNngmJ80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFcvBwiiYfiHnwKR0s9sVMRX/8cXnY7oUl92PxdQZ5w=;
 b=jpQmozCVtCKiJPEhgFYN2WewCCEolDigxPyOI+r732aIw4y++trtqSah00jeKMs9KXNY5etGSbiK5Bi1yMJkqr/s6YOanGpt5QhVOowZh8nupoRUIzkNhzl3mmCI3U0FuUJc1vdOcbEYgcsNN3HBlohnOFtNdLqKJY3LucZuoQXT/7J4+Q49kA3XPg/KuwTRAB81NGj1SbkgDTYGl4lq2CSicUfde5fuq0yqpBFtd08CAECcMoleFvwr9Evfq8JSZEHlsdG6bGoqA1sADvM9ne0S3t7gmdRkpWMGtiJnQ7E99EfCbT3esHX4UoJPoknAfZx87exSRZPVIoLeCDxPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFcvBwiiYfiHnwKR0s9sVMRX/8cXnY7oUl92PxdQZ5w=;
 b=TFG2tWUkALbj4L53kWWS/nddVGAqtNHWnhHWKpDgoXePV00wn6gkYvvyiVGODt+lPqEOiJOYx0xr/yDmUFPE1K2/vKCttW2Baf/aM4RCGP8d6pljZ2yleWLu8Uz8bIh8hQcNcRRmoN4w8N8sGGVJow72VOqwQcUIWqNxiTEur20=
Received: from BN1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:408:e2::18)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:12:49 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::b) by BN1PR13CA0013.outlook.office365.com
 (2603:10b6:408:e2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:12:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:12:48 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:12:45 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/16] DC Patches Feb 09 2026
Date: Tue, 3 Feb 2026 23:01:42 +0800
Message-ID: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c50b9b3-9fbd-4835-c206-08de6336b169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n9bDQK9ilBMkGdS6iZyjiqcCEAhV3f2tQRc10TRyCFjjcSf+4hWTpxQRyf3d?=
 =?us-ascii?Q?QkqxtuLz9rtxTUAA02zTXNXL1AYJHTQyt1oqYrFVoas8czcK2ZX392N/9JTB?=
 =?us-ascii?Q?92KhEXEIQO1W/bO8mxWVzjXq6Luer8sDKVi2WCIPAtwlleardXjVRs8nA9he?=
 =?us-ascii?Q?6ciuHKHz+6LPao6xywD6zymGF7p4K5we3djyTI1JgKy9v2qNmMqzHG3fI/Bl?=
 =?us-ascii?Q?gTwZAsE0nF7vRujrOcl6+BVmQ6lWoGMM29IZf8LJR/cX62EKi4hWHHiptTDt?=
 =?us-ascii?Q?M7ka3CJ3/ixKTcwj38zbIWE4Rv62rgcTT78ToYDe7XZwgJAtf8PuFwgzoWsD?=
 =?us-ascii?Q?wey74MlWDyuQmNgWzzF1HFmcDWuq8HGF5nbCW+c7g2Mh67QWQX1ZztznFg7L?=
 =?us-ascii?Q?HnmZkpS8F7uHEW1Atm0NwebXvEz+EN5OX4lcPSk1E3HZo0qBW49Sof8nEg2W?=
 =?us-ascii?Q?2bGzEPVKI/0S4SINxYsKcmQ19QpZAXvWAwb4CEqHM+gOfwHomzan3f3za6uI?=
 =?us-ascii?Q?yBuidahJUshXtfKLRo4CoSwwbix6bEInNGsfRdCPak0DTpqgUt2Vu4dd95Wk?=
 =?us-ascii?Q?iNrOULeE64Wd0ffOMY5fS8s9QG0S9tJL53RfS9CaJ6nV7m6W+av+4vyzUHKp?=
 =?us-ascii?Q?0e/01Uke7DvCVixS+V7GFuUDgF5JAmFR+mto0FryqBTygDpGRk54s97OPNtp?=
 =?us-ascii?Q?6PJUhuKjLmMYTA3HcSPXGDssE6mcxX/Wa+EQUWjzL2mbwCoCC8QL5+vHcsAT?=
 =?us-ascii?Q?cJ5S+KBRFT7jMBlzFBdamAhKT10kErNdVZq/7VooPQVl0KtVO6ictVajIJeP?=
 =?us-ascii?Q?78Tc9xs3UQrf46NmBS7odOXnhGbMqJbJ/SVgHi5lTUdeYizb9PsI01i39X+W?=
 =?us-ascii?Q?ultXxpzs479fZ/OQiRfvvu1q4lyn1I7LRnsfAaE51hOuj5glE18vVAB4Bat1?=
 =?us-ascii?Q?fiK+PkcvvH3320HrfweMMT62ERVxEPer7/v3lBGLXDv9BWyK0BtmjOwEF50y?=
 =?us-ascii?Q?xsDSxiLPUd8OCgGG3YKmUbOb/JblNUVLrbvBEKaKTFXP9UbVeiQSlKXXXQ7x?=
 =?us-ascii?Q?EYeCY6mSk4JuWI9DdXUsrRt0hZlFkMAVxreaylGUgs154C8iEKz843L7eb9v?=
 =?us-ascii?Q?1Z+JwqGM/GtbmvmiEqRbCIm24u02CmTR5GNgq3EGrgoqOwBiwFr7eciUV9q1?=
 =?us-ascii?Q?3TL5m4sU4QRKq+SwGq9CKYBphlSjiAux0K9Dm29cy93CGVhaCEc/kKk0HF/y?=
 =?us-ascii?Q?RyhISlALDS6Ivvn5A1uvo7AADnv4yJ9bxbY4fysmClzRuy5QVx9yfO2OFr8q?=
 =?us-ascii?Q?dHPXwV8CaIibi9PMnzlGZ7RsIXPozKue2ydkjluSEAxwmOKNl/4vwXKT/4r8?=
 =?us-ascii?Q?bBNfwndkPGqLEdf6ZglHIiy0o7L7CmTl/+VJ9r/CE0YJeL5fIegdsFSkHVe2?=
 =?us-ascii?Q?cxB9nkz+JRvTUCM7XlYnqNNnbQN0I23aSW0dTE6JKDVrOmKFzrFunpS6VIUK?=
 =?us-ascii?Q?O4VJ+zSaH2rzXTRxQ/CNb5TOo48r7xBwolieuNhrle4ZP7Jfb6rJCYny8bY7?=
 =?us-ascii?Q?K8AGFqtemlDrgCZrubkIa6UL1GmbOhILqcYorsY5txLOQhCD71DodP7oExL8?=
 =?us-ascii?Q?rEN6X15XBVJWbuChgX1JTD/THaNSUVzX9Vf6qx4LRXPfZZGd94RyYcKVIgPD?=
 =?us-ascii?Q?s/1nPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SHZ2H7Dd1SJxEpgydatqSN66puQ/6hPpGRDaCN4tRfakbE2FiGkrOav/05bvHzJy16Qg5a7Xl6K4tpL8dcyhNKptcq/e4LYENB2PBIB6I3ZcvwzqMR28jUz+7tsWXQGVC8hhQ91Y9+V7aMgTg55qchRcvfT/Jz7PNz8Hslrwyn6mm0IaDAif+bBoOkfN0+tvZ/SU+I3X2bMKs4RVhenXM9x4E0saSOyJQWekB27ZR3sutFqfs+PHPYgHVbHo3RJT774pkIrtlzj667JQWWSPD7ugpokEwXr87fDF38yNzQmeH3sJ7MCIkY9BEqKbdIu2Bbdtji6ECkRirVR66UYMBLmqHZE5Dk0f0TnXTl1Im1ywzOhK6J8GSzK5DMiJfQQVqYgVo/xDOYiN/L/TdESvAqG3ZkpoepmlDMH2FhWPUceyhiLqX9kAb9HzKaVC8HH+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:12:48.8634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c50b9b3-9fbd-4835-c206-08de6336b169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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

This DC patchset brings improvements in multiple areas. In summary, we have:

- Fix system resume lag issue
- Correct hubp GfxVersion verification
- Add parse all extension blocks for VSDB
- Increase DCN35 SR enter/exit latency
- Refactor virtual directory reorganize encoder and hwss files
- Set enable_legacy_fast_update to false for DCN36
- Avoid updating surface with the same surface under MPO

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Fix the incorrect type in dml_print

Bhuvanachandra Pinninti (1):
  drm/amd/display: Refactor virtual directory reorganize encoder and
    hwss files.

Clay King (1):
  drm/amd/display: bypass post csc for additional color spaces in dal

Leo Li (1):
  drm/amd/display: Increase DCN35 SR enter/exit latency

Leon Huang (1):
  drm/amd/display: Check frame skip capability in Sink side

Muaaz Nisar (1):
  Revert "drm/amd/display: mouse event trigger to boost RR when idle"

Nicholas Carbones (2):
  drm/amd/display: Correct hubp GfxVersion verification
  drm/amd/display: Revert "Migrate DCCG register access from hwseq to
    dccg component."

Peichen Huang (1):
  drm/amd/display: use enum value for panel replay setting

Ray Wu (1):
  drm/amd/display: Parse all extension blocks for VSDB

Roman Li (1):
  drm/amd/display: Make GPIO HPD path conditional

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.46.0
  drm/amd/display: Promote DC to 3.2.369

Tom Chung (1):
  drm/amd/display: Fix system resume lag issue

Wayne Lin (1):
  drm/amd/display: Avoid updating surface with the same surface under
    MPO

YiLing Chen (1):
  drm/amd/display: set enable_legacy_fast_update to false for DCN36

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 16 +++++-
 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 16 +++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 13 -----
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    | 54 +------------------
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    | 18 ++-----
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |  9 ++++
 .../{ => dio}/virtual/virtual_link_encoder.c  |  2 -
 .../{ => dio}/virtual/virtual_link_encoder.h  |  0
 .../virtual/virtual_stream_encoder.c          |  1 -
 .../virtual/virtual_stream_encoder.h          |  0
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  4 +-
 .../amd/display/dc/dml2_0/display_mode_util.c |  2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  | 21 ++++++--
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  4 ++
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |  6 +--
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 35 ++++++------
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 28 +++++-----
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 28 +++++-----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 29 +++++++---
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  5 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  9 ++--
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 --
 drivers/gpu/drm/amd/display/dc/link/Makefile  |  3 +-
 .../hwss/link_hwss_virtual.c}                 |  2 +-
 .../hwss/link_hwss_virtual.h}                 |  6 +--
 .../drm/amd/display/dc/link/link_factory.c    |  8 +--
 .../dc/link/protocols/link_dp_panel_replay.c  | 14 ++++-
 .../amd/display/dc/link/protocols/link_hpd.c  |  9 +++-
 .../dc/resource/dce100/dce100_resource.c      |  2 +-
 .../dc/resource/dce120/dce120_resource.c      |  2 +-
 .../dc/resource/dcn10/dcn10_resource.c        |  2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  2 +-
 .../dc/resource/dcn201/dcn201_resource.c      |  2 +-
 .../dc/resource/dcn21/dcn21_resource.c        |  2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
 .../dc/resource/dcn301/dcn301_resource.c      |  2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  2 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  2 +-
 .../dc/resource/dcn316/dcn316_resource.c      |  2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  2 +-
 .../gpu/drm/amd/display/dc/virtual/Makefile   | 30 -----------
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 15 ++++++
 58 files changed, 229 insertions(+), 238 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/virtual/virtual_link_encoder.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/virtual/virtual_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/virtual/virtual_stream_encoder.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/virtual/virtual_stream_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{virtual/virtual_link_hwss.c => link/hwss/link_hwss_virtual.c} (98%)
 rename drivers/gpu/drm/amd/display/dc/{virtual/virtual_link_hwss.h => link/hwss/link_hwss_virtual.h} (92%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/virtual/Makefile

-- 
2.43.0

