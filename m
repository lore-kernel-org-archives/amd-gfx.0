Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9212C9833F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 10:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BE210E3C3;
	Mon, 28 Sep 2026 10:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LsN2VDu7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B301E10E3C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 10:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgYZlIUY5zrUKF7ppdupqdF7S9boLTPpCEg2JXXWhkqu6tV1TTN9nt1qJ4l1pn0rFpjwHo7Gi5ChgBNV9/NJGLcTW9o5WDwX+ouc97uxgJy2rr4sHYfQpam3TsJ/m2IgvPGQpSF4DDxutGRH28WOhA46f+e4ivIvLx1ugYUZoz2tDosF2j4L0qYigD+2ZAehJRkJCtAp9ZWfbbl0wwzd3eL6n4RkW7o2+8RLi/FXc3x6zaTcxsbTQhV2TyeM1n3oQxH9YGHH+PRPY4ToWHjj0GOIjxPRdnkTFIMU8ETzpJn00pgoWOKUTt2nVWHcUzmgasaNvoOT/u4Ov5bAkzicJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppbZ0D/2o1Y1TV48R5jnU/lAZpc29TKbeuAVCVGZcwg=;
 b=rM83WCwFL8MmyfLzV1bROIGIXwbEX7rl5E/nGYlsVOUVgmFkmDY0iCxDDXK/+FGH6A5/mo8FVkSd3V9XWkrJcvkJnfoLlIPnF0MOsOohvWBAqoaAAuP1YzJiiDsNAOwduRi86VmiXu+48FjopZ0OUjG2f5F2+QbGT0UDqzsp2kB1oabvAHaSQchbB/x6cCozhEiu03h1B0qkchmrjIc9JtPDFjkaDn1/8KvXtRUOL1F8hHqmAW/WdA22K2BEJwoVwGSAuK9EfpUpV6UCYdLhmEidWKiPtP+NN2+8V51d9zt1idLhBAG4BKulYAxOOIF4TZQZJ8riY9O81AMeAijCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppbZ0D/2o1Y1TV48R5jnU/lAZpc29TKbeuAVCVGZcwg=;
 b=LsN2VDu7ISRMug6lBeIDSMZAnjtSqF9zW3lkoa30COjKEljB60bgjZEgpQ4pCgkDWgYRdGu+ebYoRGRH0UOxKlsbjNCBORth9laxfb+FSUURFBqrPIRl5RkzRZ7+WxAk1ilqFTtpY0TC2rwn/ECkkzwP7FKFT3lWC9aQgzIyAUg=
Received: from MW4PR03CA0269.namprd03.prod.outlook.com (2603:10b6:303:b4::34)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:32:20 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::1b) by MW4PR03CA0269.outlook.office365.com
 (2603:10b6:303:b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 28 Sep 2026 10:32:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:32:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 05:32:18 -0500
Received: from victor-aws2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 05:32:17 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Shaoyun.Liu@amd.com>
CC: <Davis.Ming@amd.com>, <Gavin.Wan@amd.com>, Victor Zhao
 <Victor.Zhao@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Read RLC GPU clock on GFX12.1 VF
Date: Mon, 28 Sep 2026 18:31:55 +0800
Message-ID: <20260928103155.843597-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260928103155.843597-1-Victor.Zhao@amd.com>
References: <20260928103155.843597-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c16ae07-efa1-4270-9ede-08df1d4bc666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /mIN5L4H+oIlY3JTgZjCZ9FRYE/CatPRQoi+ba6f5tJtU8yRGF40cfXJwIQQJ1VT8ZNNQoHldbrjtDAsM+Ec6ESeelz2qUaD9QYBr/jylhtlobdE4UdwrptXzhToHoLRAZLuBYNHNnP5CL9X5Bt81+el2LVa6PkBX9g3zsAfdlDjYsRDYAgG/v+9ZRVpklB3vHv3DkuC4XLOhsQi4k3sNXVMDc6+WM9sWv2abzGU8lWXN+HPjKxPnGZGvfTLx2ABZaZACb0Yz2HcxgzNvb+SlCGgHqs5X075In9mBuqhCnZTWjqtSHBFbR8/Vrs2dn7RRXNNOob8mU/PvM+OPWKMADMyYBJCxz0XXyKJ7Rn5cGXiBOx1ST7/XCLcE3pcZe5sDc9+d6XBmUFCuCfETAYgSXnq/YFY+k1eqCdxEQKEi7CJSBgAvan53JN7EDxmqefCIv5AyCH30FoxAOcLTzpYCseWHKnVj/e6vcsvoaB/RtX7iRwdt49vxDnx/2Bh+ckZqlovMd5nAKZNtIyuWC0ZP9rm940u/P/7Eb11CY7X59elsntKNihsUL9krchqHNb5aw6oZmeyLA4g3Zo9YVVmEvcskJ4GpPpu6cUFbSgWUeG9JwbKefXRqf7XwI8PkBMQW3yA4VZSbfw98CNSQxkq8bSPekFFcgJDr97RMIxUhpxQQwLio9i7rwWzxH2HlKct
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uZ1GCoty4In0/3gakI16tEy8YYa3bMeQ7UmozPT+uKUUgYHEaXTs68H3igcRkio/34E7wyHY0/pf/l09UQaR4OG6fyrJ3silFjGgjSpjhjfJmrsC8oKWOwFxgYSuqz4X0JS7BXZupYTqX+ab8oXu//HftERBYKtvt3jEWYa9LGwzL+gfOBj9ofj8P+6qrXALaKfo7D/BEaydu/1EY/qEgwIXNeh0KT/1Olqzpqz2yWhSxLff+zWVgrS6P53nhWXaie61KyxVAQuQW8ivyZuWt8kgFFisc9Evcl1iQZXGUKilJDWNjHJhQ2tOOor4TlLqDIh2nwB+2HNt++if+r3fXuji85N1vH3hI8udwoihefM1SbnAxeXWaTjyV49x7cQReUwd8TFkwqMi6q1O4t+5cKXAFD5KObljs/ZnzRNNs/OI/HR9/DshldehrfdiAFbo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:32:19.7267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c16ae07-efa1-4270-9ede-08df1d4bc666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

[why]
VF timestamp queries need a TSC sample independent of CP/MES.
The SMUIO path is not safe on VF.

[how]
Capture via RLC_CAPTURE_GPU_CLOCK_COUNT and read the consecutive
count registers with amdgpu_mes_rreg64().

v3: check errors returned by amdgpu_mes_rreg64()

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d6f70d33201a0..83be620d7204b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3168,10 +3168,37 @@ static int gfx_v12_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+static uint64_t gfx_v12_1_get_rlc_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	uint64_t clock = 0;
+	uint32_t reg;
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
+	if (amdgpu_device_skip_hw_access(adev) ||
+	    !adev->mes.ring[0].sched.ready)
+		goto unlock_reset;
+
+	mutex_lock(&adev->gfx.gpu_clock_mutex);
+	WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
+	reg = SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
+			       regRLC_GPU_CLOCK_COUNT_LSB);
+	if (amdgpu_mes_rreg64(adev, reg, 0, &clock))
+		clock = 0;
+	mutex_unlock(&adev->gfx.gpu_clock_mutex);
+
+unlock_reset:
+	up_read(&adev->reset_domain->sem);
+	return clock;
+}
+
 static uint64_t gfx_v12_1_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return gfx_v12_1_get_rlc_gpu_clock_counter(adev);
+
 	if (adev->smuio.funcs &&
 	    adev->smuio.funcs->get_gpu_clock_counter)
 		clock = adev->smuio.funcs->get_gpu_clock_counter(adev);
-- 
2.50.1

