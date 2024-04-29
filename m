Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C00C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A024B10E922;
	Mon, 29 Apr 2024 15:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3FeZjuGj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED2A10F40D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaBjEl/o0P7EYj/k6qCfSJHsYo4+TCGb3KuWJBK7UJY3idH8yFp6WylMQN7vV+fo1fJkFtlc0oI2cl06acp2UxOdLTvTa68ccHV6ssX67MSCPngqP5xRQktZpOFDr6wADn8IP3UW2kC4P4FusdrDqYvIS6cIITMCpR8arSzQ0DxEaYx7Bu12FcCntdDvwMyjrck//Kod3Eyv1A5o0QEBxrF6spp+PBdo25oMgN0qPImEUiIaV98r4eLjWTIZY3xrIEK5KTO7ur/oTBQdk5kzWwqB87/wN4JZmTHcDiLtqM8q103m/Xz3stz+26L0YElHmHERNSZ6WtBEfGYjxeiSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUV2jA5pop8plKqLET9ij/aQj/+swr82qzw6514TS4g=;
 b=kWxeblSfZVoXvzyJfS25inYYX2/I0PK8VDYF0GSa5rGMGK0h9LpnNopR3mFMbc+h0ALxLTPHZCLB4z7kx3K9cvOPZIp4HfkwO9hzqSDwmM3JgW5ptHlJVXdXucWXLmvwZWHvMok+CEX6DQItUmKY4QtiUlWM3hur+mC0Lb1NTERpz+nU91gi179qJ6KBW1NbK8KH9Vr/3jiGplYlqNf0AtADIEHYqA9HY3z0sWKSCTeq3qKvIV9AXu3VZhq9vmMFnL+c6Jc7niiu6KNDoSy7N8mUnW6GJIEc6kgz7+cMQopI+pdup+ot2Drv5nvpnewOKccKFJgs4JyrAIp4ruMgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUV2jA5pop8plKqLET9ij/aQj/+swr82qzw6514TS4g=;
 b=3FeZjuGjjtqu+H81eO9sOlo+EaA9YRVSFcdSYk5gQX52r+2TEPXzbigI0O9K3ggjuMa20SVipyKHgZBXPg2wu1rIu8lz3w6OPFwjsDnltb/zJJVYXn+kLO1zdcfhu1aDGKSL1b6MIBc1tUuY+IKg2nULnV4L8Z/+TJs30xXOjIY=
Received: from BL1PR13CA0196.namprd13.prod.outlook.com (2603:10b6:208:2be::21)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:38 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::3f) by BL1PR13CA0196.outlook.office365.com
 (2603:10b6:208:2be::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 02/11] drm/amdgpu/mes12: add uni_mes fw loading support
Date: Mon, 29 Apr 2024 11:12:10 -0400
Message-ID: <20240429151219.3466531-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 737b6170-655b-49b8-96f4-08dc685ece39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pUinzFAA5JLU+rzKjnPyGqjyAljSqG9k+wLxeeI6QNm/XOJL//M7FK5VT4UH?=
 =?us-ascii?Q?ZkwcVbiOZIytEKgaCcsGmIY+BtnpB1lSoJJJRf7yKIfOgeyDyMZTxECHVKeQ?=
 =?us-ascii?Q?UNARkeK03zr+SIOinz3BbM5BWYXe/Vi6W2D2x+ep6dhL11Pi5pFx7JzO1Lj4?=
 =?us-ascii?Q?gvttugsgrCLSoYW8AQQLn70/VlPTgnP2Eh9CzGl3aYaT2GwvI1JK6wXmtgDS?=
 =?us-ascii?Q?j8F71XfRtBmBjRjAekpmYsuhtyRzGjfHobFOy/84eCqs4+CLFx7DZclaSkWw?=
 =?us-ascii?Q?ZoVT8UFf4/sj9F1M3n0JDjgAqGVB7TVF28/qGXQrP8mU8zwli7bgHyTFlnug?=
 =?us-ascii?Q?Swtbhod6x5lwC0mnlyA6qPiaEBQjcuWBXPL6VF3bHIKGeQmvNBIPXMBI1J/X?=
 =?us-ascii?Q?hcWf36QK2UVLuD9wXOe847yLQVmlaidY0Zo3MXKwhA3hWYNwvv8wC/xtd7dm?=
 =?us-ascii?Q?mJNcqS8EyaWsVizoaS03qm//h/5rznbxYDrVHHYdVJ8jELV6ayIGLbAwOCaP?=
 =?us-ascii?Q?5bS5FzOqOzBIQwemR5OBRWF1BcjcX82/HNev+N/cZw0y0h2l64YmaXYmxrAd?=
 =?us-ascii?Q?niRNGEVrK3j4d42Ee8tORPRa0ftgZ8gAWz2/OmbQBZ6/XWjs5jKnsbQeUAJu?=
 =?us-ascii?Q?tzy0Gl2eAzpOe0puwTg1Mc2ftFyP9X9rCT7c+4NSaLRosd52mHHst+FfvWrE?=
 =?us-ascii?Q?FV0ILshd4UtsCLh/SytXFpNjlwIKDGPpXT3X8Ng5xC3pkw7JFX6/pzwipNNG?=
 =?us-ascii?Q?yRjo5oJdgYDDBXicvYCjI1wzHqjsFPd8dVGtoal0SO3vThnElm0Ciz2dMqNK?=
 =?us-ascii?Q?6RDByOTs9AI7oN4wEs1gp0BAMyWXmgeDahX3fWYatQJD8G5hBBR5WUea3wJX?=
 =?us-ascii?Q?Rjd2CiIEzmwrxniUPKgDhJf3cXC/u0RWId7KHiFn6RT9VKjpbxcIryG5RbcI?=
 =?us-ascii?Q?a0WahtSHaBNyaIwDr6p4O0Lltr6Til4eIob9W1Z1vDmwDwh6U64xDKdoGnd4?=
 =?us-ascii?Q?PHJjQdhj4ZJZ+2q9u8Mf75TXO1VwZ1LUtSf+WcA502SrqyRG5FZ1N9hb3WdL?=
 =?us-ascii?Q?h6LEiTxj2nzdTVapKXdFE4MJNVJZoXviCQt7XkP07u0L3PZQWSDcIvdikU5N?=
 =?us-ascii?Q?+y+izu5tzbMCY1e2Um/dpfFwkEeWfAr24bjMLdk9hJ/j/CUIz3vrKklerJN+?=
 =?us-ascii?Q?/WKMFhylqEM7xW3mbgWkRfYKSJG4K7Yc5b3uQMs+HZyUL5KK7zM29nkK+Psl?=
 =?us-ascii?Q?3GUxeE8bxjUOLvYIuAu/QxLiNhrqsrbEgaZ3FUw5iqT+t7Ppiu4PBDA2Smd5?=
 =?us-ascii?Q?VSu41q6PgtPQRaxJnBFiIIoULPXfsfGSodCKBAi7ib4O1KF8VDd0ourKlf4M?=
 =?us-ascii?Q?bCef78QUOgcJvGLmILcbLrSfoNna?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:37.4613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 737b6170-655b-49b8-96f4-08dc685ece39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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

From: Jack Xiao <Jack.Xiao@amd.com>

Add the unified mes firmware loading support.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index e92478b1f298f..e9c963ac452ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -34,8 +34,10 @@
 
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_0_0_uni_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_1_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_12_0_1_uni_mes.bin");
 
 static int mes_v12_0_hw_fini(void *handle);
 static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev);
@@ -1331,6 +1333,14 @@ static int mes_v12_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int pipe, r;
 
+	if (adev->enable_uni_mes) {
+		r = amdgpu_mes_init_microcode(adev, AMDGPU_MES_SCHED_PIPE);
+		if (!r)
+			return 0;
+
+		adev->enable_uni_mes = false;
+	}
+
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
-- 
2.44.0

