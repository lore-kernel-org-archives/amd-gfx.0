Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A718606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rx4jSa20
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DD910FF88;
	Wed, 18 Nov 2026 19:03:24 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F7410FF88
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5F6IJUpG7DienuR+a0tdFotZONdNKK+3aZfBo3GKUE3KgjUr8uHmBHLxBzViywbRQAEejOxZhzy2n46R5sO2pkl4x6KMXi09eWRo+YEk94kCj/bhidSNMDAnQpa/DLn4PvKn6xbr1pzuhXpJ7kRLxABS55WeBU4jlozFS7vsl6W09kOTD1bZHCO+4TAeKjrqdgQrBPoTi6VHbjKM8wvD1LuEYxKslAu0djDB/ixOJwlr3UEetefPkSrh0d6UJXa4GS/+6o3wEouIx+L8rMqoug8qz5BFy5IF4dCa4IK7eijuYbci7yxuioENjFLmSp0zZ+WWOOBgWD4HUVcO16Dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPnAGOtI+eJF/raXAl7pOZ8A9BzcvS1a+TiZW6y1tUQ=;
 b=N/XGIarWMOPg4f9Qn7ypotNnzTxCPRwqCA0kc/TZkYN70g1Fj8TPkZLX1AqorvyKNL/6l4uL3/PTGdNvzSLvbxgcc3G3nC9HmODSUl9vtkHHrabG1YF+9GnI1xuT40grttIBm+2w/8ZoyY80amQCsVayRyE7FNrLfbr+8ziV5ogxU//ThVNcAV6ydVwm5z4cthORDT/Oi+4kSr2xyFqNtsGErqHCwiY5KnZiix5Qn/a/3HGfbDtKBSbvlXoihV5MgHbfCvgxNy36OCVWVh1ympOG7lJmer+L4O8ikPprgcLGVx4KQpL2ahiblo0fgZbkWQ75pA1jdzjh0AkRGHRkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPnAGOtI+eJF/raXAl7pOZ8A9BzcvS1a+TiZW6y1tUQ=;
 b=Rx4jSa202DecIAtgf/rmsJ/VIzRqx0ZaAfQz1sLfY8r6iOn8iViNestS4gafkvtnBDfauvLIAIhMLQtm98qA0872t7dlGEOUPt/sF3w9t7SNVgx90Jd/+LRoiKpqPdTSwSdBLI122FlGtuTXPt+JO/9V5zcRmH1uwJF3qi+sD9k=
Received: from CH0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:610:e6::12)
 by LV0PR12MB268673.namprd12.prod.outlook.com (2603:10b6:408:60f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:03:06 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::4a) by CH0PR03CA0277.outlook.office365.com
 (2603:10b6:610:e6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 19:03:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:03:05 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:03:05 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/3] fix TTM device_list use-after-free on failed probe
Date: Wed, 18 Nov 2026 13:02:58 -0600
Message-ID: <20261118-superm1-amdgpu-memory-leak-v2-0-38365f37bd5a@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGL2/WoC/32NQQ6CMBBFr0Jm7RhmQAOuvIdhUcoAVQukBaIh3
 N2CcevyJe+/v4AXZ8TDJVrAyWy86bsAfIhAt6prBE0VGDjmMxFl6KdBnCVUtmqGCa3Y3r3xKeq
 BNbMqRZUJZTmEwOCkNq89fiu+7KfyLnrcipvRGj+G+f4+0+b9jpJ/RzNhjKlK85OuNeucr0E66
 t5Csa7rB9a+scLUAAAA
X-Change-ID: 20261118-superm1-amdgpu-memory-leak-f22abeab3189
To: Alex Deucher <alexander.deucher@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|LV0PR12MB268673:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd4ffa9-3ba5-4a6e-f323-08df45a693c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|261009223027099003|18002099003|11063799006|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: Lc998k6t7NnOkdBzvDG7gJ75U11Ud+TsyzoOeiIpo7djEJPVDcxFht1QJ1bE9XZ6+yf+NthAITi4yX/D1t7z35GdPmhHPoF5mo13BYQUaqgiKkPFRE750X7DV04bxA3j0lfq5mHS7QpGsqstw/ShpDnqJfraSGiMTJnhtCFq1+VDW5Tw0002gR+wxsIdLhqNS7UP+jPcrUHTsUGEWZMp08R3TuIn1KxDZa/WPuPN6+6b8cR7e5BneEtDcXoZmIh5GugjkZzhm+sTFmdnsOTI6VqKHoO6kE3Y5gaCWlpr0ko4LLkOunnqB7DxPFIXtfz9MWQDLGTEEIpOKl5jzS0hkhgTUs39nOrXAA/zMWcU3eKRQ1BzuQNaJkqF4pYjeXCDAh9MRfT86c+CsohtO1VbBLDUxznn560Hte/1bS8d4UROkhkv/zoMjt+yDY6PjQ7hgzoMDKM0SPD/s2uj8ZO8rQnEBXCzKeogsEkIyDt3Qtp4K7hTXdbOrS7afnFk596qOxQU0DaxCXjOlfqoSoiosKzYRwWLpMwU0bd3g6N58YzrsQSTlGllEYQ5EJGpL/ydtJbMSt7f1/CkCNh1VeobOkbfqBylFOwb0N9kWz/5gJYWED4TP+FsS1nfYxw0z5npLWQWEckRyz3gXVZarzpoEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(261009223027099003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZNOeco1I0behWtzDd8esSWnGhsAyLhuUxkHb/aPARe98wLZYZdBgkGKUu/QQvgdu+gILyAJu85ZIlloXVHS6X2plHVpguGCkqx3QV9fiZSQM+ioPkjaLunlgIHEY2SOTJo4kaN+yPsP15Fg0cpwjq3Y9FvZ7aW7YSTWTZJuC+vK6aaay2T3lRbQk5ah/JEx/yhkDXGLyTV6qdd+8RfW8jxxwCJBPmvDRUffCg+zqL17iPuehPdmz4MkWAMvLxXRfBu+Jfw3tVqKg/os2pOMJkQmaw51asrFxj0J6xLAX+ex6VbMV2x2qvFqnRu29A+JLHAH6Pc+to+CQLe6K4JfnDXg0e5/qs2wH0Q0mQTAtPyvAP8UgImKDAw9iqLqzFRVAD2KZm9TAP9VN5Qvb6fQqpViH9UyfhnCsXxSCMqGIt3leA9PMbiN5Wd0em/Lf/BwA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:03:05.5817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd4ffa9-3ba5-4a6e-f323-08df45a693c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB268673
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When amdgpu probe fails after ttm_device_init() has succeeded, the freed
amdgpu_device stays linked on ttm_glob.device_list. The next
ttm_device_init() or ttm_global_swapout() then touches freed memory
(list_add corruption on the following bind).

Failure points are any error return in amdgpu_ttm_init() after
ttm_device_init(), and gmc_v*_sw_init() failing after amdgpu_bo_init().
In the latter case GMC's status.sw stays false, so amdgpu_device_ip_fini()
skips its sw_fini, which is the only path to amdgpu_bo_fini() ->
amdgpu_ttm_fini() -> ttm_device_fini(). The leaked MMIO_REMAP BO also
shows up as "Memory manager not clean" on the next bind.

Patch 1 unwinds amdgpu_ttm_init() through amdgpu_ttm_fini() and makes
that function safe on a partially initialized device.
Patch 2 unwinds amdgpu_bo_init() in the GMC sw_init paths (v6-v12),
including freeing the pinned GART table and pdb0 BOs first.
Patch 3 releases the WC memtype and MTRR when amdgpu_bo_init() fails
after reserving them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes in v2:
- Patch 2: free the pinned GART table BO (and pdb0_bo on v9/v12) before
  amdgpu_bo_fini() on the error paths, as sw_fini does; use the RAM
  variant on v9 without VRAM (reported by Sashiko)
- Link to v1: https://patch.msgid.link/20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com

To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org

---
Mario Limonciello (3):
      drm/amdgpu: unwind TTM on amdgpu_ttm_init() failure
      drm/amdgpu: unwind bo_init on GMC sw_init failure
      drm/amdgpu: release WC memtype and MTRR when amdgpu_bo_init() fails

 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 43 ++++++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 11 ++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 11 ++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 12 +++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  7 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 15 ++++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 15 ++++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 17 ++++++++++--
 9 files changed, 116 insertions(+), 35 deletions(-)
---
base-commit: bd703c23ae1dea86795e99d510fb9196566baa01
change-id: 20261118-superm1-amdgpu-memory-leak-f22abeab3189

Best regards,
--  
Mario Limonciello <mario.limonciello@amd.com>

