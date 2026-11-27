Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD1606A321
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UWi18Dhr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97EF610E557;
	Fri, 27 Nov 2026 10:19:27 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBBA10E557
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 10:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDI4BrrYVwLUbFU7TYIoWA6BXJmSjFBWnkZGHyQw2RRsfjCbLuDYycHSZh68+/rTx0H+XvbKgONaXpt1GbYncnf1OQrGIjPKWFRyny6JLKKdE60HtSx/VAPC+0kVx7JUh52lv3UGTOPMLEBzw05p781eqc+cfKdlevHsExdd/TWj2XjMcL63yBfc4Nu9LL+xVzYJctiyj0aTaj9UNwg/lT118kCwAJ2EScQsilq2WQr+w7Zr/JOwHF+ZwWfHCqh8sJSDQE5v8UB1rT7vhfuciqbtQgaT+q413c+Jd4d0LMvt0W6k9G0QUmuwktS94798/FlH0Zl/UbfSrnNDFKbJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+m/qidpd0HqT7uPQjuxQEbNdsnbiIAqtdOR3f79/flY=;
 b=d7mHBfnj9tMMbFolEqTy39Ww8tHVT5k3Ra324f6p8//ISezUlf+FTT5mzesR6ufgvXdUd209udxTc5vVVapvYn07WLtucToT3D2xX8MV2Rpl4EdReg288VmQOxGNnJxnZ0dgCEmJwguV2NJqYpnDVuW5iWXiKJBu4MQmx3iXK/6DTV4uEpI8dbzn9v9XwbNwGTkKtGTicR60K476fJXzCXZLuuF3muNsAMqjXtOqMSj/wI6rc0g+iAEXaoarzj1mDypgVkeWSdw2+OigbcQvqbb0t6RDqcBdVuLL2RgwIQTZ/sZQDkFTcaA6DkRXjodTMznjQNMWxtaAaE44UX9FeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+m/qidpd0HqT7uPQjuxQEbNdsnbiIAqtdOR3f79/flY=;
 b=UWi18Dhrh9eF1Sxc3kp2iDCxS/Rbhi2q1gBqgpOO759ohmQ9K4gBE1RroPmymzsCW5Y8VggWjajVfW8iqUVegZGxG8GTQEE2mRtRayJnVRO22aHz80d+Gh5hXfaXGAAehGOFCKRPtPAk/o33hCW5Od5FKheZ9N2vJek3Vfs3sq4=
Received: from PH8P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::15)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 10:19:17 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::7) by PH8P221CA0042.outlook.office365.com
 (2603:10b6:510:346::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 10:19:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 10:19:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:19:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:19:15 -0600
Received: from rtgbeta01.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 04:19:12 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Strahinja Stamenkovic
 <strahinja.stamenkovic@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
CC: Priya Hosur <Priya.Hosur@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: bound APU available memory by host
 available memory
Date: Fri, 27 Nov 2026 15:49:07 +0530
Message-ID: <20261127101908.8313-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127082854.112025-1-Priya.Hosur@amd.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf7c0ba-ec81-474a-2eb8-08df4c6fe411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261021121427099003|56012099006|11063799006|10067099003|261022105027099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261102123227099003|6133799003|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info: J9Jwxcc0OdVqJpW2uc9xkqOat7HTxE0Z3LKP5ThrL0koVurzjj/DBn+/8QCis0LR0oziHlVTMpDDI0hnKYW3rKDQo2u9/eGeaq3hKZQqBYklnfmGch9RoRKwaUbe24a+mFtOwL1QF7R9BvpCq6bd6+x83JZ/zRk/JAJkZuPNn2xmdulpUiTGaw5UZcw8TXfD/kY+i1cPtIx+ov+uaLmFcZeqEuGIuJVAJbMBXVN9c1XZKLylVovo0K3ebnHfTR1F+E5nbD5plfqOF/2FAQvc7Ua2IhfB2wsiNWbPWnTrThOwlI0AAnLULJSEPrQJQJccRw//q15Ywbo4Mf/6Q+SbTg6pnZIjccrtNpxft6V4m8GjxS7OM0labWG0PqwMU6KM7HYfjNt3GmoK2zW9Zdxq9oug0slWuHI6GNelttB1RtZ9okKkv/lVjfhLNQvM097/lB/m9XCSnEEJQSB4PR8vr67v3cieeMhWEdFOb1IXZQXAt/xLmP3JA5MSzNQN8l9Bxx8AbzmptZlTrW/XGLuEmOsbF2tG1DqiDdkTHhB/5atGOCMB76ufpFZ/Zx4aFEeps2uqXTkA75dW4yH7vAii/+1PqwcVvNcuj1K1jKVKuS4gCSB4jdPtGlrZBrbpT0ORiHrAHmKg0nb1m1EDUgXJbJYqi5EeMd5xLFup+OgaoqX0YbLqvcVKEMgQKeWdCFc7AVrglN/hqF2C1AFHdtxJGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261021121427099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261102123227099003)(6133799003)(18002099003)(261009223027099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gfEhDRcXf1a6tXMNybiUvpxMIUgf3P4sdwg49F+v/cE5FrMMJHZmDLQjo9htth9cOFhm15Agk2Vynx5rh6/X8CkL5TZC00RQSWIWFw72qJurpXx40lftf3it0IEAISQO8wV/m0qotRB+NL4zZJehiH/Gl9qCYDoWF8/e3fsJG1gKRXbUnlmgtFq6y8/uvqPeHRxNrR3lovnbSMVv/BodCabcyyZqcCCVZTH7KYxSeMRvfRI29U9rwkJ/YcKbAsDN7YizfF5nSmpExatjI67HQkPeBcnSpT2s3NUWWFz1aQds2CCsF4Ei3NppQWne1EG0QfWrQn8rnN8zfN6D9SEUmggmgJxqy3tYDs+4w/X8BOV+UsJmP8g70nGvo5jvkhoWacKId1u09gN7PO4F1gwqH1g9qcB/mNOk5Dmgym6zdHRdd1kPGYrWOn5CYAvWtwVY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:19:16.0424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf7c0ba-ec81-474a-2eb8-08df4c6fe411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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

On APUs where the VRAM carve-out is smaller than GTT (apu_prefer_gtt),
KFD serves VRAM allocations from GTT, which is ordinary system memory.
amdgpu_amdkfd_get_available_memory() then reports the minimum of the
static KFD system limit, the TTM limit and the XCP size, each reduced
only by KFD's own allocations. Memory used by the rest of the system is
never subtracted, so AMDKFD_IOC_AVAILABLE_MEMORY, and hipMemGetInfo() on
top of it, overstates what can be allocated.

On a Ryzen AI MAX+ 395 (gfx1151, 62 GiB RAM, ttm.pages_limit 80 GiB)
with 40 GiB held by another process, hipMemGetInfo() reports 59.67 GiB
free while MemAvailable is 20.39 GiB. Applications that size buffers
from it (e.g. a KV cache) overcommit and, without swap, trigger the OOM
killer instead of failing cleanly.

Bound the reported value by si_mem_available() when apu_prefer_gtt is
set, unless no_system_mem_limit is set, which explicitly allows KFD to
overcommit system memory. si_mem_available() includes reclaimable page
cache, so this does not under-report on an idle system.

Apply the bound in amdgpu_amdkfd_get_available_memory() rather than in
__get_available_memory(), which is also used by the allocation path for
is_app_apu. Allocation limits are unchanged; only the reported value is
affected.

Co-developed-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>
Signed-off-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a6616447abc8..0a04516e137e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1732,6 +1732,16 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 					   adev->kfd.vram_used_aligned[xcp_id]);
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
+	/*
+	 * In GTT mode, KFD allocations are backed by ordinary system pages, so
+	 * memory used elsewhere on the host is not available to the GPU either.
+	 * KFD only tracks its own usage, so also bound the reported value by the
+	 * host's available memory. This affects reporting only, not the limits.
+	 */
+	if (adev->apu_prefer_gtt && !no_system_mem_limit)
+		available = min_t(size_t, available,
+				  (size_t)si_mem_available() << PAGE_SHIFT);
+
 	return available;
 }
 
-- 
2.43.0

