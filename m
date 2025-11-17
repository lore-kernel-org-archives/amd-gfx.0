Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7602DCEBF61
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 13:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A9510E39E;
	Mon, 17 Nov 2025 13:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/kFMwa/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F6110E39E
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 13:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpPC9Qh6X8uIVBqtCcuAxKASD2OIQNaQ2K8YPZ1pPLxnazCA4yxXwhx4uNEMBQtdpyiF8AnBWQNUHTdn7l5rRqjpGbhLzKBMW83vfoVw15ISSDVBpKaQo59mPorfa8c5sDP35LlrNbjs5jSBVfV8KFKsL999XRqAAGC9WYo36tWyHF7yiS6xQYigg/pocBFGxRYucy/G4dIpZA4JApKk0T+3l8YfpHFFMpZkwBAEII2Ih33GPC3PBknyenSa/nh6gcCbMw82ozSfKV2fqJyycLjPmLqNd9NMkVV/RczuG/5kRB2fU6UeEnOUtugxiYYi0Am9NxvQgEKy9ChySIyMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHfoOk/wdoeTMC7HdYKp0c4dh3Q2FznE4LIQa9j/C94=;
 b=XqwB6Sjz1eX7FXPrY+vChbmS7tBKNcBRy9Ndeuga86SvdpURhId9xsvIxJ5S2NA6GpoSED3KowNnTf3OG6dFNVsQswpRqN1/T8TrhoSfI9v5NrKkyDBG5KWdrBLELjR7AoAbTrUjZLlehW7oZ8KKlG+3qBvLYkCE6zW/H/fXzuLVjke217ZP/p4ocQEqFw8rIZ+lu2q7TS7FmzWUpNpwFQVxUQQCofhla1xrMvSkTk8+cC2ik+vyINXtj8x9aXy+JnJ/7VkF315VVKfExtQBw1Eod2p/RT7w2Fv8AviisW/goHAkCZ6dJ6X+OQY9ChGbB8t6PKj9VIc7UR1a34j+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHfoOk/wdoeTMC7HdYKp0c4dh3Q2FznE4LIQa9j/C94=;
 b=B/kFMwa/e8qG7HK4O00zoVm3wzW9XkqRITMv3xNm22bipKrhnmP8/CjTClSWgfRA31AGqqHOThgaNvzlPnjS2vtooLX152nSCF78LxoMs4GSSbqWxuCOXOTQ1BieaW+mvsDNrAa/RFCY59vqNCmrVBzQlJbcoA0mwcVoXiaLzlQ=
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 13:31:16 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::43) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 13:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 13:31:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 17 Nov 2025 05:31:04 -0800
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/ttm: Fix crash when handling MMIO_REMAP in PDE
 flags
Date: Mon, 17 Nov 2025 19:00:49 +0530
Message-ID: <20251117133049.102851-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 20110f20-8029-48e9-7daf-08de25dd940f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vkh1NnJqRld1SlorSFBqYUs2ODFlNVpyVEJSTDBWelFESWNPWUFZbVNWWHJz?=
 =?utf-8?B?N0UyNnRjaW84L0NPYzF0UmdKK1d6NkJNaUM2Tnh4VUZBTm5oTmpPMWp6emJa?=
 =?utf-8?B?clQ2ZUM3bDBGdDZ0WStEZENNRkVRTU8zcUtnamRmUHVqazQ0RHZFTElkMTBO?=
 =?utf-8?B?S3VnN1Q1bU1RYUMrZDhKRHFoNlNPNkdPR2RsRzd6Y242RVdhUFZTdXplSDFp?=
 =?utf-8?B?K0lYNngyM2d4VzEvc0pobURrVUtWajg1YVB5WHllV2JOOUQ0Y3BMRnI0cUNj?=
 =?utf-8?B?cllWS2pMb1ExcWRSanBpeHBReWVVSTlUaFhvNHBRZjBKdndvVXFOUTRhN1Ro?=
 =?utf-8?B?RUpPajVVTER3dmJxSHRhMFlTaDBwZk51Y1FFOUNSVjhpNFc0SW5MRTl3Sith?=
 =?utf-8?B?SkRMdzRoOUNmMjgwdmpYQlc3THlQUUJJcU9VNnpxN1dFNlk3b3NqR0lnUDU2?=
 =?utf-8?B?VlF2SmdHUE5ucmhKNVlhQWE2M2dEUlFRVTE2MjRSYnQvMG13Q1pTSW5kcXpL?=
 =?utf-8?B?T25aRG1IS2ZpOXcyRE16YkxIaW01TU5CUFdDc3NRV0IwS1J6emJ0YTBpcGNr?=
 =?utf-8?B?VUJqT0FCSjdjdG45SDZYNkM1ZFhkRGhXRUsvYmx2VDdQRzB3aEhyRWVuVWNT?=
 =?utf-8?B?WnJ4RmprTE5KYm9Da1lnZ2NjTTVEdE9SOTgvRkFNRG1WL0JoZi9OK013VnNV?=
 =?utf-8?B?S0RZSDFydUFnRkowWkRadlMzdVBvRWxuMFFwc1pIdXkrZEpuRWVnRWNndW01?=
 =?utf-8?B?VEVKSURiMmYwYXVRZWFweHduNlhiMlJZbnFqdnhqUm1wcmhzNGxHVXlBNXFx?=
 =?utf-8?B?bzdST0ZZSUdTZGhXeEIxaCsxSnRRdjcyQ3h5LzJMWWFWRDZScTRVbU0zNHZ1?=
 =?utf-8?B?blFoT3FKVnV1ZTdSL3RtZFZHclo4TzBjZlA3STRpQlpXUHNsOTRTSEdpTHF6?=
 =?utf-8?B?NjlOaURaUlRtOTEwOTdTamtsTXh1aGtTWVd2N00rZWswQnhSZ1lIUW4yZS9l?=
 =?utf-8?B?S1NxVlpZWmR4dUFLMktjVjY1clJObGUzZXlGQXpjR2JwWlFEN2JrbnVkM2JN?=
 =?utf-8?B?VUFwU1NROWIzdnNxdjRXT0ZqOHBLbzRlcVIyNU0rSFJWT0I0bWlOL0NsR3Qw?=
 =?utf-8?B?RnNlSVpzc2lCbXBhL2xJaXBWeU9jaTB2OWhyNFMwSW1YWVZFRmFuTmoyQldB?=
 =?utf-8?B?bnhwdXNWeVlJd0JXZlNQVFRTalovOCtPdTFpNHN5YjMzZFpKTG40aVJRR0hw?=
 =?utf-8?B?K2NhSHA4Qm5MQlM4TW9QTHlwQmpJU0pEMy9PbmlaK0Y4Vk9Kbms5K1VTblp3?=
 =?utf-8?B?b0toZWdBc015MHF5VU5UVC91RTVQWVo5SXdvVVB1OUp4WlJlMnhjVHpVdEUw?=
 =?utf-8?B?Z2p0dXlSWWcyakgvSHhJc3pwbitoU1BPcmxIMkdQckxTMlFpc0RpL2FSTXJz?=
 =?utf-8?B?OUxKNmZ2NU5WLzUxTVdlbURjMFpFQVp6eHFRanEvOXJmVGFOVlZJaXVlZGI1?=
 =?utf-8?B?STV1TjZNUFV1OUxMK2hKTDRGMUFOTmQyU1BiU2pYTnZiTmhZQ05wbTU5KzVp?=
 =?utf-8?B?QUVMbEdNRDN3NG1kblpXWnFHMHlDYU16Si9vL0xQVTdXTm9ZNE1za1pndlNI?=
 =?utf-8?B?aTVDVEgrQmxPbXUvWVBqYUtKazZMdWhtOEhUWUJpbys0Zmp3djJ4cGZObE1C?=
 =?utf-8?B?OVZweERkdkxtSVhCV3JOMDk2OVBrQVFKOWtGb21iUW1ocGM4K0w1elE2a01y?=
 =?utf-8?B?L0dCUy9VQzdaMFRTdDVyRWROdE50ZzJJV3B5MFp3RnFsWmd3MjlUYzEzRnJv?=
 =?utf-8?B?ZlJ1YkVUZFI3aU0rV3Vic0swVzdmM0hEY2dEQmgzLzU5YmJCTStORlR1ak5C?=
 =?utf-8?B?ZFhNS2RXUlNsWGxQLzIxV3BxL1djQk90ZEpUcFk0VTRYd0k2L3IzZG1tSy9u?=
 =?utf-8?B?eCttcGdwb3RtTGRDclB5SGQxNTF3RzBDWFdnTmhyajVCcFZZUjBxdFNKbEpJ?=
 =?utf-8?B?c0MwZS9hYy93c1FzZE84aE5yUEdpMEpFMFJmUTkydTYxaGd5a1RhREtKd21W?=
 =?utf-8?B?THhHYUtVc1NaL0xld0oyNVhTTWNFU0E3eUxzS3FwMUFSZUF6V0VNSDhaQStx?=
 =?utf-8?Q?dwj4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 13:31:13.4807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20110f20-8029-48e9-7daf-08de25dd940f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
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

MMIO_REMAP is a special IO page backed by the device's remap BAR
(adev->rmmio_remap.bus_addr) rather than regular TT-backed system
memory.  There is no meaningful ttm_tt/sg behind the MMIO_REMAP
singleton BO.

amdgpu_ttm_tt_pde_flags() was treating AMDGPU_PL_MMIO_REMAP like
TT/doorbell/ preempt memory and would eventually rely on ttm/ttm->sg
being valid. For the MMIO_REMAP BO this assumption does not hold and can
lead to a NULL pointer dereference when computing PDE flags for that
placement.

For AMDGPU_PL_MMIO_REMAP we now set both AMDGPU_PTE_VALID and
AMDGPU_PTE_SYSTEM and return early. PTE_VALID is needed so the GPU
treats the remap page as a real, usable mapping, and PTE_SYSTEM marks it
as system/IO memory instead of VRAM. Returning early makes sure we do
not touch ttm or ttm->sg, which are not valid for this special BO and
previously caused a NULL pointer crash.

Fixes: d716b3a2df1b ("drm/amdgpu: Implement TTM handling for MMIO_REMAP placement")
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 84f9d5a57d03..0e7a631a9081 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1319,13 +1319,23 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
 {
 	uint64_t flags = 0;
 
+	/*
+	 * MMIO_REMAP is a special IO page backed by the device's remap BAR
+	 * (adev->rmmio_remap.bus_addr). There is no meaningful ttm_tt/sg
+	 * behind it, so do NOT touch ttm->sg here. Just treat it as
+	 * SYSTEM / IO memory and bail out.
+	 */
+	if (mem && mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
+		flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM;
+		return flags;
+	}
+
 	if (mem && mem->mem_type != TTM_PL_SYSTEM)
 		flags |= AMDGPU_PTE_VALID;
 
 	if (mem && (mem->mem_type == TTM_PL_TT ||
 		    mem->mem_type == AMDGPU_PL_DOORBELL ||
-		    mem->mem_type == AMDGPU_PL_PREEMPT ||
-		    mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {
+		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
 		flags |= AMDGPU_PTE_SYSTEM;
 
 		if (ttm->caching == ttm_cached)
-- 
2.34.1

