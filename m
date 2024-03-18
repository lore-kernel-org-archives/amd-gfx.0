Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40486C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 20:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B839310F86B;
	Mon, 18 Mar 2024 20:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xXLjm+dL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B8C10E5B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 20:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7g68hFGGympwVUJTV1XGgGSoTcRQ0xQamPye2Yw+hqSohLGCGkT+9hHeg3wPOa/7w4W+IYhFzv1IZwLffFRS56vfXOyh7xJXdvwr7HOU4hBZhE1vcGPhBCA+b2Y2xPl1Aj8IUKggxejfJPQn9e0RV3dfnEBTrsu3nXzBj+Klr7h70cLoqkmt5Xj1gbp7zE7W9/pf4LTD1/gXLx1mbzFZ2fv2Lyr1OOlHAbN47OLoZ8DH+w+wAPzHDY6HCgCUoE7iod5/daMf+Y4P3PEUNIiDA+r+bHfEWRJ+5Y5ZqD2jEo3JSrH+Eqnqr0xg4Ef4jbdj/oF41vXz81BkVHKGoD8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hig9jZDnSfelrEFgY0sxXV3CtH9PKzOdiEll8Eltqno=;
 b=FUZYSRoMNSLIixTKF1Bn4EGqtLNjZ9/ONuNK76jSF/aFWbS6s0/geyFGswghWgzv+pKtVMH6qUpIDO2meNnuV6C94+hSpUEL0rSmLqZmw0R+pyWg4FBoGQSKwF26irXayQ6HUSMIbc0+v1HZ2PdjFdy/cfPHvBayFVEYi4hW2csW0EuXag4irodb5j1X63AqPJjBMak44Di5wdxkCjvFEJe3Y4bUTcDzwqrwm2wuUclKcaMwUeF8qNzGcfme+4fW3xY7GEIv7I2+xmEPa/LucNsYsRt+IbK0l+KK7VXvvojiHJh1eVW6Y/aGpIj3WBKIZlOv8/gth2EMI870ReEQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hig9jZDnSfelrEFgY0sxXV3CtH9PKzOdiEll8Eltqno=;
 b=xXLjm+dLVUnsWO4zJV23A9rJqI9SG2EAxec5fj2Ss97OTqeXHSBTpQua5e2w6ujZr9tZxuS5fBxi2u4IXoI6qzOUcL4U/NoC+/8WoRkhPYyM6s5ngtSdSlxxk0CwmZ/JAK7ewkV6zP+bGAZCzuc3yJWc4IAFrvhY1ZvFlkxWr2U=
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 20:43:15 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::6) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 20:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 20:43:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 15:43:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add smuio callback to get gpu clk counter
Date: Mon, 18 Mar 2024 16:42:51 -0400
Message-ID: <20240318204252.144624-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318204252.144624-1-alexander.deucher@amd.com>
References: <20240318204252.144624-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7fd1f0-da6d-4f8d-0ef5-08dc478c08db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxH3erWZ6ph0ZYfWhtoX70zx3h2iK8OsmUcMByJHQHrFXdXzjYRnAFMjo+01pR63fTfaZWc4XV118CQjUX9i2oBWUqNWP/43FppvRBP2OMrSqwOluT6rSRiXfuz0OsrSCgijupztcfyWmKe9V43yiK4D08Sox9PwLZ6TKkS+v9NdbU/0XyXjp8Vy3DBbrHeUO6HKjvuTzlyYd7b1B7v2q1Iwk8Di2fSUPI1s0sefWEGeY7L14QoEBy4BhVb3I8MZvz8orhZnbkebN4C4HkaJBxmqfZRHqAbUm6m/SHkqHlOej+3g07qk0fMVvE4IFn9zCaQB+8lscpcwQ/vt8j6LH009QPjG8JLMAy0VOFx4VgnWJK4qks824KwHsUT2Ao36V1GRk4VLtlr7uxXx5nk0HzuIW24v3x6t7h1jp5qLNxZH4GLlcA7KWjgHs+CkhLpNY9wkESXSBSsZ6QSBZneRP33tW9LXafpYhfrEtTunqRRodunHYmWQvzfgeXGGQi/zU4WKSk4SV7nd4W6fxj0IfmFRiT7w18MSR1B06kvsHl9cJRyVS88DH7cdfthwpjH6nYFbJ7TXje8m0X7b7QfJv566FQVcH6uqtBmVE9AoXn03BFIar93E/LGr5ko0o7gen6vIZKPsa1NfGTx8R8HcpvWG66+28X7Ah2Rb2FFGyjSKGwehRBxrS+bHNC+fPjt7lKs6W2R4AUztc14bk5XgBzvtMpPtuJ9Sgdmo2WSaGtd7gBro7C/zWBAVvrHs1/Sv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:43:14.7929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7fd1f0-da6d-4f8d-0ef5-08dc478c08db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add smuio callback to get gpu clk counter

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
index ff4435181055..ec9d12f85f39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -44,6 +44,7 @@ struct amdgpu_smuio_funcs {
 	u32 (*get_socket_id)(struct amdgpu_device *adev);
 	enum amdgpu_pkg_type (*get_pkg_type)(struct amdgpu_device *adev);
 	bool (*is_host_gpu_xgmi_supported)(struct amdgpu_device *adev);
+	u64 (*get_gpu_clock_counter)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_smuio {
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c
index 7b7cca220b26..2a51a70d4846 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v14_0_2.c
@@ -24,6 +24,7 @@
 #include "smuio_v14_0_2.h"
 #include "smuio/smuio_14_0_2_offset.h"
 #include "smuio/smuio_14_0_2_sh_mask.h"
+#include <linux/preempt.h>
 
 static u32 smuio_v14_0_2_get_rom_index_offset(struct amdgpu_device *adev)
 {
@@ -35,7 +36,27 @@ static u32 smuio_v14_0_2_get_rom_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(SMUIO, 0, regROM_DATA);
 }
 
+static u64 smuio_v14_0_2_get_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	u64 clock;
+	u64 clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
+
+	preempt_disable();
+	clock_counter_hi_pre = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	clock_counter_lo = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	/* the clock counter may be udpated during polling the counters */
+	clock_counter_hi_after = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	if (clock_counter_hi_pre != clock_counter_hi_after)
+		clock_counter_lo = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	preempt_enable();
+
+	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
+
+	return clock;
+}
+
 const struct amdgpu_smuio_funcs smuio_v14_0_2_funcs = {
 	.get_rom_index_offset = smuio_v14_0_2_get_rom_index_offset,
 	.get_rom_data_offset = smuio_v14_0_2_get_rom_data_offset,
+	.get_gpu_clock_counter = smuio_v14_0_2_get_gpu_clock_counter,
 };
-- 
2.44.0

