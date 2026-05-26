Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB56CD5BD0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 02:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD60C10E18F;
	Tue, 26 May 2026 02:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VTXHnlX0";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518CC10E18F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 02:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVwvrb2spODEMxgHZKjaEesY+SHul5D41SMU5BZvRG8M+pJQrajhJwo33cgY8VD9xTNtoju4ytz5QgHo/ty1ttc7b2xMCKgU+Os2UI4Wv65UiBqe8c+npG1OQCarFSXkAVXCA77vyXyrKkjgrBJdlyOSK6pSBT+F71zdAlZL+qLGx3mNbUtbaViTl6dY3vGXmlfp6x6r1aEOi/IdUZtpPHhnDidrLBHx33PABfljjaFjXVqWlRsqxAKCrSDJHbQVHpV8s5Cgw3wxzgDsmjKqvRgb8USpm80EDWaOak4ImZrOZGRUW2RZ4O9EEj0SSRJH9ZVmwwCNXhsSPRxFoYuA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwGDfSzAzfqENvJRfN8XVuqsKxH20Bi+EoGCtDCY/i0=;
 b=a9gXi21rfALskqN4jl6vbHK+PVKaaaAap6KmTCfWX9sRdJaWVwbTBz8biqLWLqrcpxTm8iS1/xSveKgioDLmVsSEza9K5pn8q+a1BXLTc1m1N6iRAiTrDMkd9Mi+hS50pt9gsXFa6UDIshCTEzZft59fQYoYFcOndfKD/oBVevdB7iZYqsXGy54hVAlsFMcIwx4mO7/wOSNmPSIPKhZ8VOvQ/4pPOBO0U+6iQY5myqMY7SFEFg5JOgSpTt00PTCpIiVsnBvT8kHDDkUZcBmxpPjL8qsLCSJmykhefiH3gbSf2ywX9zZRF6QIjarlIHaanlrJ31I5XHhnveWoZAhnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwGDfSzAzfqENvJRfN8XVuqsKxH20Bi+EoGCtDCY/i0=;
 b=VTXHnlX0DGBsCG6Vzv6i8pWk91sluLqHpDosEaN89a1MVn6NATCeU0SVJJ+6P9PzQrAZPbl7mo5vr96WZNfdQtHfNNVzbSXKI+gjNplExexeIVHVmQiKndnZaqGPayJ/g24I2SzzmRUnmZ5bO+LOQ6RccGCvSBY2NxPok/m3puw=
Received: from MN2PR22CA0002.namprd22.prod.outlook.com (2603:10b6:208:238::7)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:58:42 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::30) by MN2PR22CA0002.outlook.office365.com
 (2603:10b6:208:238::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 02:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 02:58:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 21:58:40 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: improve the userq seq BO free bit lookup
Date: Tue, 26 May 2026 10:58:30 +0800
Message-ID: <20260526025830.50987-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfc8589-b545-4c6f-05e5-08debad2b18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fMWsNMBLxrOdCgTW+uysDTLpv+jQAUN9NkNl6yzJAdRNJD63fvpiR1K7hS4+6xNAIUVgXulpdhTMYk1aJNBR2o7dEzxPMomtrVAzK94DfSRPyw3hSkHxz2Qq2D/XL3RIJufvoeSYnoPUEXX9kBzvdTrhRQ6UQ0Q7SkE6wN/WHkQyuQDUK0bWmfdUa5rczdtaMRLVfea9TZcMhXL6LRbxufAiwWFZRZLlP4SUWEVtUfcD738BaYUIVweN+VcgopKhY4dYOlHkBxV7tN5AlBqck9SoI01AR6bf7vrh31MSdY0g85Wvv/EBwwuOq6S4nZOTSbf4DbvgcshDfbU05cWOGYw5jr0f9U1ji/7HM1E7ix2PejW4QVnnKzrSOJ8EUJ0eRO5teEcSF4y2O3LrgCrgGgc1MkGCKIwxnI+nFfYKshq6P1JL2drIKOaO16P9LMV5Rw00iNLeoP6hgafS/MyvDNwJQSPr+Y6L+9uKflJM1CQ3U5o+/uoZALqqcLksloXKQVMBAmR4NtbUd74JrkYGNQPR7u9QCuXKYe9xOhJ/9hwZP5LG8LOBx0cpSITdrnJrarbqIuO0fJOxoJvd5wvhHiWWnP/Ygq6VfJQmVnYl5K86FBB/yUuTJcfoi4zR3mqJREEpiK2OE2T3g934tC4QGzzeM8KFAvm5XAPZeha/8pKpElCTc4lW7taYiOD1ZEP4FCz98Omy0ZdTtVljDMqDJnwWQ1rQPmkNQdelOmdYJ4c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wBmnZ0lqoMWe6EPvTZIYCLP5+EhsfO2p3yYbqm+W1aSIJPNlYst6d2EloLr2i0gN6yT3egALfUsvWwFba2bNNg421BqUprcs0FTtfFOe4Kdcc16aZ1DXGlUiLE4BxsEb6I1Bn1az+ZQudh91uyb5vy9h8868Av0X14VpCSLEQRDusTqxqviQ6t2WdQSr+3nIMSt7Vgpuz/KcpkZDh0ej2M2ntvT5brtFU0rmbNk6op2dZoqJ6S4mGL1EBYkDmKpqaT4XeRgCnTNzMvjR/zoFFSQ5odn2G4qLLIFyWtFQbjyWzcQOGUSKDZoLRO/Oc9xQFAkoTWBaXJAQbQCDijvU6zpHaVb1y5h24wE+ruc5Y2LWoJT8dGwaCAR9JqwkE55fJkgjJKwLdlcZyTpz40CPfRDakekI6K0iC+4q9jylMBDZMfooAscj9JVaocX07ECB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:58:41.7281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfc8589-b545-4c6f-05e5-08debad2b18a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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

Use find_next_zero_bit() to locate the next free seq slot bit
instead of the current walk, for more efficient bitmap scanning.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index f4be19223588..63771d6d466e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -175,14 +175,15 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
 {
 	unsigned long bit_pos;
 
-	for (;;) {
-		bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
+	do {
+		bit_pos = find_next_zero_bit(adev->seq64.used,
+				     adev->seq64.num_sem, bit_pos);
 		if (bit_pos >= adev->seq64.num_sem)
 			return -ENOSPC;
-
 		if (!test_and_set_bit(bit_pos, adev->seq64.used))
 			break;
-	}
+		bit_pos++;
+	} while (1);
 
 	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
 
-- 
2.34.1

