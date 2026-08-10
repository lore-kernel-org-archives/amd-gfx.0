Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB63DC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 09:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E3B810E77A;
	Mon, 10 Aug 2026 09:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fLqWPpuw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF79510E77A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 09:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTvhPxzz+BRQOc8fLnBKWOSbZTFe4AXyD37YKUgJqE9AGY7ILC7rwwk4f3Q+HDrFnVYXxpDNQwVbYOYApQ11yhdjO0zGXzGl02u/VBRfVqWMUXLCnMdhe7ZKzmNyZILsnfIB0QSP9zjmBHlANAKYMJ+6+QAqJSsRGxx66lMQXuHL9kII32cbJd6Dtc3q45XYja9vrA7J2TX6tEGunUasFIyjP8CL1WUCMEMiIGnD3i/MdlMcyZNkiQKVRKnC/WrnzLAf8ZMNxAPN7wyftrVrCJz/5rKJ6EpeQjBVzGlhA795nvmYfYRlk+CXNXZ90cBMAqK2jOAofPA5vofrHVO8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMmzCCxjN6+a9rcbtCZSSb1vNhyj8ECUT/djYkV66P0=;
 b=IY63nZ1+3NzgPTHF2AU8dRXvPoyRnAEz3t9eFgay7Rx6HBaLX+eczvFzdKYxJZK/veRXH0RyPbUZUSVf4icYIW9byiAjIOEidMRlgNWsYgPMLaTnA/tjwR6St1xDCjp6piwEQTXuS6viKfFV9KzIejnZ+iQu3HesnqVXNOIi2lpeIwfuvIFXeMAGPk1yzTW36AEpd+sc5ip7AbGiSvpM70lnkGgMwOdzY4iSlHgSRLX5pAtGtdGmsbSw+bOdybQQ40a+j+7nYtP+ey7pO8srJafugVQhxuyiq+J9RThhGQbX7OIGGGVcVOPZP2BY+QuGWwRoGsBXSjbrSH5IWdFuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMmzCCxjN6+a9rcbtCZSSb1vNhyj8ECUT/djYkV66P0=;
 b=fLqWPpuwOJ2MlCTU56YBdL6XMW2jZM6y6AHL5yLjExcYmkZKRyi86lOLpKowHTkEDba3Gm59bvgzcBNyqh6ldcw4Nd3rzj8opoAD6cjbfF8fCKpU9sZz26olgdSRfs91vkLOecwfYwdjYUCbxH/Heq9TU1B6J6oC06cwr6zrpJE=
Received: from BN0PR04CA0165.namprd04.prod.outlook.com (2603:10b6:408:eb::20)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:54:55 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::45) by BN0PR04CA0165.outlook.office365.com
 (2603:10b6:408:eb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 09:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 09:54:55 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 04:54:54 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: Implement insert_end for VCE 3
Date: Mon, 10 Aug 2026 11:54:41 +0200
Message-ID: <20260810095440.9135-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 440c78d9-1b12-4ff4-bef9-08def6c56e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: WjRDJiR2zPCqYlfJcWJZiOziuAG8dcKXX5LAfj9Tqgl9XaORyI4WtgveOGyfwy89kJhEc1pAy1F4qY5nlMECFdBaiazy+eG+uXfrrVWklYhq8vq9E01TSYDyOSvNmF6rLMXacUk8o6PxWTrkNI8JAJDbWJgaLHXx7q/Vk1tSo1+fTMxKYapjoRWCbLOck+W9pBL+TbhddokI0r53I99GoaKH0hoMbrFoeMZ10Vi3LuGje33sg1s2epsr95h/WnI2QI6TX0HXS9orlo5FlG05CNytKLhJ6xLFuW/wnWsPkvLbtffhJanczmV4z28JmVpbeWvHTeVPJZPkJUvHUlWHip5V8T8MJs4cYp8H27ciwS9ep7W2dj0CY50wlGYmxoaaB8Tr4Y9QNmN6hPy/tW80nwqP5be2DnnEKhgQXQv5u6GozBrVgLA3gzGqA7LNM7YdBbxUhsgAsbgHnBvg9quTlkoJj6PmlsxYjINZDVFVZnjvyqH0cJHCetLGODep0fTc0dEpCgSuhxGNNx+UiY+JGgBaJfhpupP6zzarhMDrvTADMNU5p75QtzRThar6ZhHtNXlb2JOSrfJZpOhgwfxmqelozGMAfPJOySnl1xh5J6iGvWBH0SM0mY9x1urCubUcFhPF/AC+sHPIM7qW0KucVC1wi9ZOLTeErVtakVjJ1Us9jA84jWdU9WjEali4H0whRVuSCcTYp3Se9b63CEPCgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XoRqNapZjBEcvC5eZpm7JknfGdnjqR3+Qr3QmlfQMvoXzAemJmtS7lXZg3H3cRf7DeOpMjzOZ4L1J4ntqvMPx8kemByNv0Qm52FoZ0VryDRANiNjb7baxZuP+s8LGsLnYI8PCQI4ZxRj0PEahz2e6vL3GDXrq6tw0nPlHe8JqLw++g2/KTQvtPh0ydVEQIc7wurHAbD7xm7IVPILWUy0gYnsJpbc7PTs006ls3/Iym3ngU+f4NiwsAdD4VlJvBeqt86n1psKR82SzEZ0Zrv2MkmwTqqTerpr8fx+aAAFnikLvojkmkNajypgBXP2cdgbCb/DxMieYPrzYv5DuNtkoDRpNxopr1gU/3eKsPM6OTHHB9TlpLfb/w6XKu+q8H7/cbW/dpx6CieNgDE+3ftzBFyAcOQFbf3u3EPlbQpuIeBHWD9cn0g/qomOehmB7Fco
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:54:55.3378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 440c78d9-1b12-4ff4-bef9-08def6c56e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
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

After a recent change VCE now hangs when VCE_CMD_END is emitted
after a pipeline sync without VM flush.
Implement insert_end to correctly insert only one VCE_CMD_END per job.

Fixes: 83a8dee2bdfb ("drm/amdgpu: always emit the job vm fence")
Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 9f4e88440c0a..a9497e2e07f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -809,6 +809,23 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
+static void vce_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+			u64 seq, unsigned flags)
+{
+	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+
+	amdgpu_ring_write(ring, VCE_CMD_FENCE);
+	amdgpu_ring_write(ring, addr);
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring, seq);
+	amdgpu_ring_write(ring, VCE_CMD_TRAP);
+}
+
+static void vce_v3_0_ring_insert_end(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, VCE_CMD_END);
+}
+
 static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 				   unsigned int vmid, uint64_t pd_addr)
 {
@@ -818,7 +835,6 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
 	amdgpu_ring_write(ring, vmid);
-	amdgpu_ring_write(ring, VCE_CMD_END);
 }
 
 static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
@@ -884,17 +900,19 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.set_wptr = vce_v3_0_ring_set_wptr,
 	.patch_cs_in_place = amdgpu_vce_ring_parse_cs_vm,
 	.emit_frame_size =
-		6 + /* vce_v3_0_emit_vm_flush */
+		5 + /* vce_v3_0_emit_vm_flush */
 		4 + /* vce_v3_0_emit_pipeline_sync */
-		6 + 6, /* amdgpu_vce_ring_emit_fence x2 vm fence */
+		5 + 5 + /* vce_v3_0_ring_emit_fence x2 vm fence */
+		1, /* vce_v3_0_ring_insert_end */
 	.emit_ib_size = 5, /* vce_v3_0_ring_emit_ib */
 	.emit_ib = vce_v3_0_ring_emit_ib,
 	.emit_vm_flush = vce_v3_0_emit_vm_flush,
 	.emit_pipeline_sync = vce_v3_0_emit_pipeline_sync,
-	.emit_fence = amdgpu_vce_ring_emit_fence,
+	.emit_fence = vce_v3_0_ring_emit_fence,
 	.test_ring = amdgpu_vce_ring_test_ring,
 	.test_ib = amdgpu_vce_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vce_v3_0_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vce_ring_begin_use,
 	.end_use = amdgpu_vce_ring_end_use,
-- 
2.43.0

