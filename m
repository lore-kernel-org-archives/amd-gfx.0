Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D7FC624D6
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 08:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 854F010E5AF;
	Sat,  5 Sep 2026 08:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B0hPuVw6";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010007.outbound.protection.outlook.com
 [52.101.193.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B92510E5AF
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 08:20:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKp5jDTcJ3u8QgYcFD0w1Fcq2dVlI0SZnw9d9Hy8E5k6cO+nERQri/F7p4KcQVOfFe7Osz1Z42gTEREdmTBeiqKE4eUsKpn3R3sKk/v/I83tEBVresUpHCGfvDNybZWB+9VmVYvnhmJ+UyeadIKSJui4bgkUsmOZCFzEFWIoRj8/gaSqoEcg1G0FTFX2ViMPRZXImAKnWmWKvuJvgGyGazheozzoTve5P84x+3gVvBMZirbB8ex/ElZRx0+xmTC7VrVR2GSCyavi6xpP9LtLuN8blmzqF+s8j9LNlYMY8F3n4aTmBW4uA58qIRalyU4qhmaK+54mLRHInPNBHVVFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XQiV43L5Hu7uhRe1Uf+CVDPAwjqFwYRj/LdiKOKJeY=;
 b=j/LSFplUgQOGG+eR4PDZipw8zaTOcN0T5rEVc/BGOTkDXSxyTYO0GxhJHbKArc/eXkM2Fp4ybwzIQivoOk/LzTXvqqsAcfSMdXR2aXGPYvY6u3BKP1/sVumK+osWVWMlMPPkG2KHyWXhG0QVNrRnGomBxcPTd4AONNaIoknUtkMKnBHBXc4dPEgpk40EQ+FvFx+JZ5U7cl5h1XFCt9hUsiqJmxsQX+skzsDZGstBI7cgkJt5SfN+f1pTHGDP2i45NMkghMbta7FhpocDKkQ9AhXG+ZMGQO8gGA/CfB9LRa4JAw4CXxE+LeA8eusHLmA8abHeEp3JA1QNP+YGBpcnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XQiV43L5Hu7uhRe1Uf+CVDPAwjqFwYRj/LdiKOKJeY=;
 b=B0hPuVw6uThjP8EfLPJ0RlNZUIXiSbdyVohg1nZr09JO3d4RVUiF4vSfjEPNU3nmpGxme2OI4wrsgYB5luXpDTktzeITImyg2btr4ueVRhBbyUrrgE++mVlQ3skAUAc1yBwB3uzaETupyRf77WIYUDefATDcIrz+EVs1oa6Jug4=
Received: from MW4PR04CA0045.namprd04.prod.outlook.com (2603:10b6:303:6a::20)
 by IA4PR12MB9761.namprd12.prod.outlook.com (2603:10b6:208:550::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 08:19:58 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::ab) by MW4PR04CA0045.outlook.office365.com
 (2603:10b6:303:6a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Sat, 5
 Sep 2026 08:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 08:19:57 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 03:19:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/3] drm/amdgpu: Second-level trap handler for kernel queues
Date: Sat, 5 Sep 2026 13:49:32 +0530
Message-ID: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|IA4PR12MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: bac3d03b-d321-4891-e961-08df0b2678b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|56012099006|18002099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: LwIMyIGLZMl02TzicmRuUc6JoVcZU5T0P1mqGre3u3h0wai4V7enHI+51Kq4vaMm6tozRMn1x4ZQMby9zf6xn9QCreQOJ3KWToRSqs0ygVmm/yBQTwsy9lmf1bg3hJlJCZScPSm5XX8XucAeC3U7yLAlUL73Li7VnYW/RXCYpax4Rkltqj7SEWnIup4bcOe/VCix53X9I9in/aQCjYZ9VIlmhvCHkS8zFCLtCVTOcabHkYywwCm05D/Iz49rtwvFbGp5V+qkcVDEiynjVgCjgpCoOh9X5z1o2iQHeppaD87C8wA0pEbPLpgv3Fy1Jwd0SQPzMRVX6iH/8TMCJxzRzHXS6ftxwHkSxYZTqXl9dnfRHdbBkkuuHkRznLbBe2q4+VW1KECzqVgfwHjhtoqaVZGamOO8vN+JWfdbLHijuhGIRcBnY6uGCSYI8hD4Rr+Tj7RYUQ0NsUjx5WTO4Bll/WAexAgC0XQFOWDCDOixGJ0kLim/bylCXitbRjzWVbpzGnsx/DlmkVE2x2oA4ez5EF6fDcp3qagFUdU9JaDk1WsuX22VhqO//Rvf//OICcHHKZAcBIKtvio1Xk8MK5dbmM3TM41ZLqadCg1tHOxD+AQC9OI7AMMM2CtSKw8VV8YLuAEeDPDG2GNCrJgcYp/tjobK7libVKMFbWueOwwrJEUDBrICbOTX8YBzmUVfwMcXHMTrDrBtKx2SwNIfyzNO2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(56012099006)(18002099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9bzJcs5BK3GsvwswDN1tgtDMTYQayBzBmeMXVU6Yf//DD4xIljY1dUmvY0rtvlg0/rKZ1eqgzxEZr84B2mdadsDxG79laFHDPwB5I4EqgrAhdwGNO1n60J5NSZ8uLa3xUU0PNaZ1sbVNpkVcKA2suGm6Dkz823pSD/hDvcmsgwilblTO0GBmMuIhIGJYFQTes5otMwBh8OsUwuzSsEKTPzWfnkmN86idUy7jaTkRvyWttJa+kucTjx03rULGRlC7z6kn1RfvfMPjpV3VWHGCaqDtQ6W3MYfb+OOZmysAeGBCKJpMj9JXssLqp1R+zilgjt5pRwukR6bJ1OQm6NDBupFfm82QIwsc6cc2JsxmsNyrevpsCIrz2x3sUyZY0jJ9lWS5CklMJ807ZSt/khwWXKd5LBISAojZ5S/8XaGVEIZvAbksbXNojtlfQHFXlHAg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 08:19:57.0540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac3d03b-d321-4891-e961-08df0b2678b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9761
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

Background
----------
When a GPU shader crashes or hits an exception, the hardware
automatically jumps to a trap handler. There are two levels:

  First-level  — always active, managed by the kernel (CWSR)
  Second-level — optional, installed by userspace (RADV, ROCm)

The second-level handler lets userspace debuggers catch GPU crashes
and inspect what went wrong.

Problem
-------
The existing second-level trap handler support (merged earlier) only
works for user queues. RADV on GFX9 and GFX10 hardware (Vega, Navi,
Steam Deck) uses kernel queues — not user queues — because user queues
are not supported on those GPUs. This means RADV has no way to install
a second-level trap handler for shader debugging on those platforms.

Root cause: the SQ_SHADER_TMA register for kernel queue VMIDs was
never programmed by the driver, so there was nowhere to store the
second-level handler address.

Solution
--------
This series fixes the problem in three steps:

Patch 1 — Infrastructure
  - Allocate a small per-VM TMA buffer (kq_tma_bo) at VM creation time,
    the same way page tables are allocated.
  - Map it read-only into the GPU VM at a fixed address
    (AMDGPU_VA_RESERVED_TRAP_START).
  - Program SQ_SHADER_TMA for all kernel queue VMIDs to point to this
    fixed address. Because each VM has its own buffer at the same
    address, per-process isolation comes from the page tables — not
    from reprogramming the register per job.

Patch 2 — Hardware register programming (GFX10/11/12)
  - Implement the actual register writes (SQ_SHADER_TBA/TMA) for all
    supported GPU generations via SRBM select.
  - GFX10 uses mm-prefixed registers, GFX11/12 use reg-prefixed.
  - GFX12.1 has multiple XCC instances and iterates over all of them.
  - Called at boot and on GPU resume.

Patch 3 — Wire up SET_L2_TRAP and CLEAR_L2_TRAP
  - When userspace calls SET_L2_TRAP, write the second-level handler
    address into both the user queue TMA and the new kernel queue TMA.
  - When userspace calls CLEAR_L2_TRAP, zero both.
  - No new ioctl needed — RADV uses the same SET_L2_TRAP ioctl that
    user queues already use.

Design decisions
----------------
  - kq_tma_bo is per-VM, not device-level. One BO per process,
    same model as page tables.
  - Fixed VA (AMDGPU_VA_RESERVED_TRAP_START) in every VM's address
    space. Same register value for all VMIDs — isolation via page tables.
  - GPU sees it as read-only. Kernel CPU updates it via CPU mapping
    when SET_L2_TRAP is called.
  - Lifecycle matches page tables: allocated at VM init, freed at
    VM fini.
	
Only compilation tested.

Srinivasan Shanmugam (3):
  drm/amdgpu: Add per-VM kernel queue first-level trap handler
    infrastructure
  drm/amdgpu: Implement kernel VMID SQ_SHADER_TBA/TMA programming for
    GFX10/11/12
  drm/amdgpu: Extend second-level trap handler to kernel queues

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c    | 107 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h    |   7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  13 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  38 +++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  38 +++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  36 +++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  38 +++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  33 ++++++
 10 files changed, 320 insertions(+)

-- 
2.34.1

