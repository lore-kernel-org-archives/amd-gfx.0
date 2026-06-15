Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A63ACD98E8
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C9210E77C;
	Mon, 15 Jun 2026 23:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BE43ypMC";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E364110E70C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMz64g+5MJ42rnw4LLfD0mOK/kbRN1ix0nOILhyQlS0AXIu1DC8kUtMflfg19gD5tRpL5B3rECBkA9Sh7ryDvIh+P2PK6Wbnq8B/GT2HgI4IsDr+EXNUU/SHaDKsPzpkfXTRVyz1/uZYVcrNmrRaObUt0n137Vj8K6m7BqAr4dxU2q1e+jRE/vXZTjkP4vJWvJvRkp9D0q2Yl+I9lvc+DLScJdO/zbZtOLiLnIXcOsoDSerantRsw2+G7ZJtooj8k4sCyDjVLXgi4tiDsuxnmHqW6JVT9mJlgu76fVqI+74t187axDA8qdvEwgPPMzULe2QlNdzxTlWTDSKXI3DkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTw8iElpGcIMjG+k+uwbMXf8uam8HMIDcNZhWqknhlI=;
 b=sosixL8XNmBC7k0catwd7ToF+mmki8S4UVQQTTfAc4Jur+NLpF3ztwooFAH7vvFgnYW4ldWbxXSUB+3TKpos713h9oNsWUptNJB6s6Yv8Gaxr71rFu0KQjOI5roUPfyjiWBIzmastZZXBCpOzfRrnonsIPWtcEhsQJmVuS4dWPlxmru/njI1+7Gmze+I9tmHnZg+1AmC14A9BY0xPjT3thUhN3yQMeblSNnptzlFsZqxhyhRoZE4WQ9XB8BE+LOSu5sH0N6Jy6QO4I0zzdlGwmQ4LcdYClDFE8OWEgLkMNVn2Nr/pA0FlkPwMACxZ0BLc0hGIuWh7Ufp4DlxSOTiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTw8iElpGcIMjG+k+uwbMXf8uam8HMIDcNZhWqknhlI=;
 b=BE43ypMC/NjHMS+tsAt/xCY8GFl0607/T4oF3SG7ubg47Ow9wuUdVRqldr0VRu+fKDIsskpE79aBeXZPKo0MLDU7RE1YxWgB9hMGVDpJswt6IFGo6jTbZqbEUeB53XQ1xTMIGR296Bg/qPe90SdBC9OL7RRZOwzj1YTKkff4jjA=
Received: from CH0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:610:cc::17)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 23:57:00 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::9b) by CH0PR03CA0072.outlook.office365.com
 (2603:10b6:610:cc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:56:58 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/43] drm/amdgpu/sdma7.1: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:15 -0400
Message-ID: <20260615235645.737189-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: ec44dba3-807a-40b6-7315-08decb39ca35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: FKYW/tNniKKhPbstBgY4SBRNUr0a9ymh6mA2TFNxuHdimItbAvalDYl8NL+tY1tEjnd96b58ThwRMJEZYL0xhMGqlu6Nw0An73H4gydp+K6qBCzmHS4BMiaC8aW85u7z4uCcDk5SjZF1Aoel0IblLd0xhOwLAI1Ym9XA5sHeON7CEAv62rlNxqz8BH+lxs2ohtaubFJfbE1qAhxIrZRJJ7Cc7jPOIB/pXMdwjzSiFvFyW9Vrue9EsVZ0O8KLy9nVAGcsy84Ba9HT2cCktDlT5a82zHCWczQu1gU4RVN6XCux2Vbswf0Co6sZbiZXmdEkyg9STYUNB3oEreFGRWFmPS5kfQiEi7HsaFXPm3PtfJ7pK1sEPxmmDulu7ESb8COFS0yeIGCOyltr/nen94hDgkBK4m6xAOoysdtqQbNV6teEs2dXp2JhSWOlciLnHlDInmGHgOPP7uKzJtrZJ6QjlrtXY0R0MdgQjh/vM+jM1KmNCogTBwhZhh+FgesKSeMtFiymn3rC5yDKktCdlGuCOrrpPWu56939JH13u/QrtYKBdKAIhQkl4/HK5k6pX3VIwwuF900fFG46BRrduPEUkKWZ0hnpiVY+Xsi3nv37c3D2NzXHRsx4W2uVyuV2fdzcDVgWkhIVCMurJIZo2Z6ieOUfD5hIOJ6QKtD2cIl+Eqtk/yd44C+IUdydFbzNKVYSL1keEalVjKUWOhnZresj+dXMjJoikbjCvWC8vCVCM8Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZDd47F+ys32zg50hw3GFnJn5kz02AQs7MWSLjUbM+SR9U9aV+VqKV76sn0Xntf70r55A2gPEhiCTtE1dS2bWuHeu3vPMSBO33saNkJlv61Qf/sDztNbTltbGz5eevdDOym8VbSRL+/DlD1W5HyfvMUJalLXNu6H3xlXDzff0UbarA+UJ7qeRl5pCqreuQM2j2gbyAoe7i1Lg3Iu6pndo95w2s8bY2BnJsRx7fp+JQv7bND94eBhMkmT0JCwg8dXomH0R9YEYdQUSzNEzTAmYr83nr5o+JnQmL/zdzBVeUzKaRkS78DVc3APMj7C030uEpgjLXTP3cfd24FTXH7rhc7ifJt5gZ7VVbFRGgRBt4nA0agqavE8WXgSSv3kNITf3A6JU/4wNDEuqbG6WUk93LzwFY4zs6UfwbxGb8M+MArr2sXISB7M9JjLQm0vpAWdF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:59.8728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec44dba3-807a-40b6-7315-08decb39ca35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index cd9668605a501..b06001f6b5363 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -331,7 +331,7 @@ static void sdma_v7_1_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_FENCE) |
 			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */
 	/* zero in first two bits */
-	BUG_ON(addr & 0x3);
+	WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -342,7 +342,7 @@ static void sdma_v7_1_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_FENCE) |
 				  SDMA_PKT_FENCE_HEADER_MTYPE(0x3));
 		/* zero in first two bits */
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(seq));
-- 
2.54.0

