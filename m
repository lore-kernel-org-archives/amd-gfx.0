Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64DAC3ABA1
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Apr 2025 16:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453D010E226;
	Sun, 13 Apr 2025 16:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zASdvr+L";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEE810E0DC
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Apr 2025 16:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUB55Yl0AYXiWwio5kDHZwtBKHFP1LO9mqN1C4zSG3AVCR/v/bP+P/Fhcy2MhKawOpKTtvhNp/3zEw85njt1kw3HP0djnJvJwHKAFrR6101y6PpOsFYROPMK/nFl1LdXTyvRVfhS6riIrY5pCeBn4B1tI34vZLDBx3OcDZj0hF+qgGR9+jOP24IpB5WSJDHZfNLJK0PqYmzJpdZ/0JaWS8C89Q2Im8WYmdBr0PP2GPfHFVd0EtmDAcOtYWJI8UdALjnAmtX1LwsL+yUsdLCnVFVqkZv0S7CjiwHxO8d5S9X7ra8boBb0pRysxyET0caWnngw6kW3EmMwC7bJI6hDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEDRyB8QMpuPR6Nj6nNiUt7jT/nrxuDbChbweis1W4E=;
 b=p28gE03J7xCVYt+iKvGf8Maqx0E1HDpfY2e1pURBuNyAN78i0buYRkANSNCkACLvimbCjUrJCu09Kz0PwWvIanp9LpsjJrkwr0ccWUsrtuIvSqake1b3a6q96Vw1fy11AEe03pa/4razn9Zl4TTQ1sb18A8EhjUJ+0V0T7WSRlIPqCDpBz/kgHiiIOFdnpff2s4eHyItqRu/N6m9X/YQwOMmKqJh98BunEs7KMZLn/jvAqIvqPLpTbhLoNcpTBfd5grBzD0CaSSxdVwD0jOOnZUUt9KvlIL+Y1XR7L7PQV45+djs+9o9QTOWnoLF20Vc/EIk/7uiXW1+DxarXZlcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEDRyB8QMpuPR6Nj6nNiUt7jT/nrxuDbChbweis1W4E=;
 b=zASdvr+LuYw4n6XG7SpyS69jguJrwiUwJ2+x8/Vtq9Hbrq6zp1I8sm92tMuHikv4L8Pa2Inrlb6D0SGrj8vDAWPZH2v6DeE5sfAIWmIYAOpcXY/XvgQI0nT4Wu0N/26HiNygN3G+Q67G3cdOEuQuVfCiY7NF0tI506kU8O9b+9A=
Received: from MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) by
 IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Sun, 13 Apr
 2025 16:06:23 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::ec) by MN2PR01CA0049.outlook.office365.com
 (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Sun,
 13 Apr 2025 16:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Sun, 13 Apr 2025 16:06:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Apr
 2025 11:06:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/sdma7: properly reference trap interrupts for userqs
Date: Sun, 13 Apr 2025 12:06:08 -0400
Message-ID: <20250413160608.2198429-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413160608.2198429-1-alexander.deucher@amd.com>
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 00327f3c-5c7a-4965-64e2-08dd7aa52357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A2HqR12ep9JrYh6B6IZEullSYf6rCI5RBhyN6yMK3z4LYYFFz3VkSTynFzzF?=
 =?us-ascii?Q?3lU4Q4jtWfx1nfP1/gcRPIvL9jYMtJHxv+L2evnLeqVJYyHmtDg413tXM52Q?=
 =?us-ascii?Q?FfYSrNDSlcbac0VlhJ1XXB3UkhPyK/BtPKzcb1sO0T6yWJxDyRfzf4ZtyL1l?=
 =?us-ascii?Q?/3D2zyDcAsi+7JKjFxdR31NwxERwUhdlGLlkTzOROKTouu2GbbS+L3KnEYZC?=
 =?us-ascii?Q?I90MR9A5QyhiGcsDsbG64jtrfyfvS+P2aQ8YTCybCRTNB1sKbpXAzQtyZYjm?=
 =?us-ascii?Q?CCynNNzm3QqCOU7RNlb90soqbcdvKD0TEY3gs5B0H0nn9+7HM2u8UUnSqfNy?=
 =?us-ascii?Q?6ELq2+Y9glxAXxN8vw1LBhzY5hbXH9OHjtF2WHfr8PAqM/FdwxmLUPvjrDYX?=
 =?us-ascii?Q?oRit1hjiefR9mN4m7sxJ6F6meUoQeo9AG0AJfk5cEwWxgb8HYOBszuVWsA0i?=
 =?us-ascii?Q?m9PmthECpkxdcfjFA8fB9ZCh8NBrpQ7LmyhcuaCUMxN9XdMXLH3B0PrDS26r?=
 =?us-ascii?Q?AB1eE+xH6fRtD3U9EFOi37rIt7S0QIKajCmfu0j2Hsai2tEXdxzJYkBYBp+0?=
 =?us-ascii?Q?J/UYnCHJK5V3/YVhA0+VBN0UJD9XfyPHa4WsdZm1PjslVTRXrlANpKWbrkbU?=
 =?us-ascii?Q?cH29OWlDgazqIt7OL7hid+HlejgCe8yVG84chi8PrPuJlTf+geQPSpUXeriz?=
 =?us-ascii?Q?fAx2w+mVxpUFR/CIDs+1NRUtGc9HYBpgCXk4R2VVbxvxo81dtIta5C9Fzl0i?=
 =?us-ascii?Q?WF/3fy13LQKRDE8jsU4JQwetyN/eQwkURm2vQqH7eiGESgQSF5iAsdQGyjcS?=
 =?us-ascii?Q?9YLg9wFekGhEylBltRd3eSrqg+yvMjRYGhMOEM5uLARcfGN/xYPnOtLZMDdJ?=
 =?us-ascii?Q?6mQrEEVKKeHJVZA8iueXbBn/XrzPR+FJciRiTLrTFRJJ1GOfS/pJvaMwGAzO?=
 =?us-ascii?Q?gjhrmRgUe2ruFwX8aBdzKpujhhH3MpJhqk0KadKd6qv7AKbDkckV3Bb7wBS3?=
 =?us-ascii?Q?JvB2m13NhRt3lPcEbyor5B78J5hkt+/UFyJi19w+QzlEOV+5RRb+junMV0sv?=
 =?us-ascii?Q?xsxEDR9pDJ0zilSJH+KkPjGmZJNYknfgln64oL3kjL5OrySJAeueT/38bXVJ?=
 =?us-ascii?Q?iBeZ/K4z9q0DoLipaqaVxzNfSTt81Ipcg0SxD3n8oEvP4KxRqBtQh6fPpc52?=
 =?us-ascii?Q?p6OrbI/wRC6olxX4j7+H5bWFnJncvhYE/Cj1jUU1ZlcUv06xZICg/d+mhRTi?=
 =?us-ascii?Q?jtA3RToYAu4RpY5iOWXW31VfRYXzMaGuRFCsYgKd03rM7Uu5M9E1XBfkjVjD?=
 =?us-ascii?Q?w6qWqSv0Qs8VlhzjpQYFVYczzcCs+Xt4wPwR7MLAUoQ+SkrD+ayxvgf55iHa?=
 =?us-ascii?Q?yIVuI5PFnNwKHfoSA1iw5qY942aFA5E7KvpbKlnN/fv/xtTNXwA/e0/KuUWt?=
 =?us-ascii?Q?PG1wt7AkgN48t+qOD01Cx4XyPXSokqiyoMFZDmk0CkK6ZbkGckr2Sr7SRpEE?=
 =?us-ascii?Q?jBvW4r4Ki5jhTeS70FoArvDf3VpFJ4YQARSe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2025 16:06:23.7132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00327f3c-5c7a-4965-64e2-08dd7aa52357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
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

We need to take a reference to the interrupts to make
sure they stay enabled even if the kernel queues have
disabled them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 31 +++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 1f3045323c929..669d1ef3fab22 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1352,11 +1352,39 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int sdma_v7_0_set_userq_trap_interrupts(struct amdgpu_device *adev,
+					       bool enable)
+{
+	unsigned int irq_type;
+	int i, r;
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			irq_type = AMDGPU_SDMA_IRQ_INSTANCE0 + i;
+			if (enable)
+				r = amdgpu_irq_get(adev, &adev->sdma.trap_irq,
+						   irq_type);
+			else
+				r = amdgpu_irq_put(adev, &adev->sdma.trap_irq,
+						   irq_type);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
 static int sdma_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 
-	return sdma_v7_0_start(adev);
+	r = sdma_v7_0_start(adev);
+	if (r)
+		return r;
+
+	return sdma_v7_0_set_userq_trap_interrupts(adev, true);
 }
 
 static int sdma_v7_0_hw_fini(struct amdgpu_ip_block *ip_block)
@@ -1368,6 +1396,7 @@ static int sdma_v7_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	sdma_v7_0_ctx_switch_enable(adev, false);
 	sdma_v7_0_enable(adev, false);
+	sdma_v7_0_set_userq_trap_interrupts(adev, false);
 
 	return 0;
 }
-- 
2.49.0

