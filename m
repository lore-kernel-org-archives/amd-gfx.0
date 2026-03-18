Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBBC103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDAB10E836;
	Wed, 18 Mar 2026 14:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZPY7eR7O";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18B010E836
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eO2mNAMPqkrKo7Xk0by24X3r0FVRc1GQCezIQKGf6eO22MwVJvhy42PNyvacDqJF1Imzh2EvQfJ7Sj3GEO/oTj7Ucr+heMK0kVIl1/QSqYd7X5VHWd9LmEcT70PI0kd21npSwD/71cRnnNJ7GRbGliN3P+jPc1n0aXXFx4KfBrLv3yLDS6OIs9tlXsvPQhdyQrG18rV5WSFmTON0HnCtKc3SogVSFkMqQmyuKcabvbJGiFVd2GZWPbWW/urh7e7NpaMs2X/Emcg0y1sKBA3TMQ0lnlWH637sF84JXDHLla9OSi5BpP7f1sIhGMrd//O9jwgStLQHEblIzkDtOOFz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG9MMx8XD5zJXDnqi5KiBkG+VtW3/+Ou8NwIClXhJLM=;
 b=NSd06TZc3YVZDwxqK+Q4GCqOZ15NaWTXYWiRkleHPeEioL19lpeuROE4Wou34kN6oJpL+7xXaXFMg3EOE320SOVUGsTsXJO/sEf8H+9BYgPkQX8skOfOngJQWRFWTNQKRfU/PQNCVVu9tZWOUZsOn6TZpMv5qihLUYRR74SdxWlXGsfeeq3pq/ytMHoRfWANhaGq2LOsp5uufH0TYQ+mOQI0ffe1Z6qaXPeVz4tp6pI43OmjIy5/2wrE8w2cEGXH9W0F5JYQTAy8Z6wzb6hmXJphg9tqgCLJ+YWQfpszg25Nfx9VVzvOnf4RqPP8FAuVYBBPEYLfvlMtvOBXWNavGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG9MMx8XD5zJXDnqi5KiBkG+VtW3/+Ou8NwIClXhJLM=;
 b=ZPY7eR7ObF9bhPPpVlvO+PRsfeV79cyMQVg7Lw+iwPDVYNH/TNy4snkAN20sP5XSOU3IRUfGbT3wvlwIs33Hb8fB0zaJn8KqL7YTw+U+l+24wQ5Uk+K3TscyC5QZA+bCw2T/mgXO9lGVAuobfy1+1WA6vaSQRqo8S58fZx0+shI=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 14:10:29 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::44) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:10:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:10:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:10:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:10:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/sdma7: program quantums
Date: Wed, 18 Mar 2026 10:10:11 -0400
Message-ID: <20260318141012.583021-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141012.583021-1-alexander.deucher@amd.com>
References: <20260318141012.583021-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|CYYPR12MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fde7ea7-10c3-4f0c-a6cb-08de84f81be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +BB+Z3Z4xrrAS55uc6Sd0bxVnWQDRd3Nf1nrDuhOz5A/vkDwCnbOc6i9+es9okQSdB5BeneMjpKCbYUAbUhSskTetxqr3x7+7RO7ba//68ouJdJ2PQ1EcLsX9l5AaURXcYzB9FXCYTSuBgBQhV7yLX+dbBrQfk4qEYU4Hjmu0pftwnJIqNK0y82HmaTf7LkG3PFMrrTW8irotxfxwGPhzEJVCHSPYw+5Ns4N4dV4JEi3WrlCWSTsml78/xZ/9tjHM9U5NUI2Aha0OsuV2KuG3qn1xXDbTihE8Wd2H4lZic0KCEWZnl45GmJdUn0hwb+Z0h+IOVUk9fl6ho2W+WaOavxWaQItGU6Cz20kQde0KVspxBKCX8LuMV9PEBPtTQbHWZaR2lRPKHctqQrgSbjTvIPd0bnT77U1Z1MFgCWfnFkYBxBCVjKPiN6H0L5b8FXHOiMYhL0i55VJDhjSRFYLl75rclCPw3f86thzgRyHcKJLUeptK3QQTlJytj3OQDkXOMCj7+5Cb2dF58UO4jQb2is8Gn1qqpWH8EkPJjQEvUjyIK8q6AY/zGgbeYDQesy4kIUcEQYyZTkPzu/KE2syvQcUQV+D5+fSOz47MF11DRx1hhTCQT78eZBqwtjhtKBMLBVFNz1uL5n5hhAMbWRoizW68myhiTEAKa0rvzpI8UxMQ0ZDQszYkC+RvbFVlZyt6SHjr03uGcPUcKWkHzCd7c+Ch0EbSjERZZpeImwwMUHpUJlcwD1DoM/ekK/AtdADiq95V+pn7zpJS27blwORCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2zVBoKI7MiPxgKJU8XNZI3XLf5nLopOgtSVpAwEhQfbGTkXgf9qtf/lcvT0XB2UZ0bdMY8Kx9ES5PsxJ4kpBgx4U12IZSqueZvmKLnzBQtBaENvpkqCBdxXNoA5DK+JD69Gwweg3XzcPv6aP+EGgX0dv9UyFExlj8F3pVk6Qw0n2nOwiMXKjvTCBuEJvNRwUEZRKZc7hrMATXgKq5ToB+3ZxGCHXzb+VFz3Hka+6/yPEdEliACyt3QG9D9No4xYbg0Z0crTaKgRceUrb/l90YF6P/YmLr8qs8mJ6kD+yILIYypBLmonBnANgPW4EAJnVw4LCyU/u3EH6Uho+8FZu2EJxtyxoXaSeihqwGtQnHyEsN7NcMNyb0uT9WyGzqUlJ5AxAGzifhimLQC3xvKXffFUavEjjVuCRtQ0Y/GK7qHJh0C5Y7Fb18XzJdhDg7Dt4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:10:28.6640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fde7ea7-10c3-4f0c-a6cb-08de84f81be2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
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

Set the quantums for queue switching on the instance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 5679a94d0815e..5c79689c02efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -496,6 +496,38 @@ static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
 	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
 
+	/* handle queue priority and quantums */
+	temp = REG_SET_FIELD(0, SDMA0_QUEUE0_SCHEDULE_CNTL, GLOBAL_ID, 2); /* 3-0, 3 is highest priority */
+	temp = REG_SET_FIELD(temp, SDMA0_QUEUE0_SCHEDULE_CNTL, CONTEXT_QUANTUM,
+			     AMDGPU_SDMA_CONTEXT_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_SCHEDULE_CNTL), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_GLOBAL_QUANTUM, GLOBAL_FOCUS_QUANTUM,
+			     AMDGPU_SDMA_FOCUS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_GLOBAL_QUANTUM, GLOBAL_NORMAL_QUANTUM,
+			     AMDGPU_SDMA_NORMAL_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_GLOBAL_QUANTUM), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_PROCESS_QUANTUM0, PROCESS0_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM0, PROCESS1_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM0, PROCESS2_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM0, PROCESS3_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_PROCESS_QUANTUM0), temp);
+
+	temp = REG_SET_FIELD(0, SDMA0_PROCESS_QUANTUM1, PROCESS4_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM1, PROCESS5_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM1, PROCESS6_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	temp = REG_SET_FIELD(temp, SDMA0_PROCESS_QUANTUM1, PROCESS7_QUANTUM,
+			     AMDGPU_SDMA_PROCESS_QUANTUM); /*  value * 100us */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_PROCESS_QUANTUM1), temp);
+
 	/* Initialize the ring buffer's read and write pointers */
 	if (restore) {
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
-- 
2.53.0

