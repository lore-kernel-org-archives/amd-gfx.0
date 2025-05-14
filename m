Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF553C3ABDD
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6F310E6BB;
	Wed, 14 May 2025 17:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FK0+Ioz1";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A7B10E6BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zF11DQwvyFV7tIUQQAZYmjQ/lO7eLY98c8kxWtOvBeF6i+7G1X7CcanRf7DAADjySq3KdvaFf2ovhGwJJGMJp4hb5LvMO4ySEN6NnZlskdBtLOXncg3U+URmQHRnmQmTeEw+2ye098TkEQmfwRfITD36PxfZig5icnELjCCFjCa0oBVHI+S9Y/wz1+gx4OShrsnDvJi4zxBEMl9QTg32eHgw49Tl7/6T1AleWg9cCMf2CS6vhKaVwTSa16VWM6zx/iTgol/Z86ZRkqr+3CO2NIRxQyQ1WFCntVAamEIvZ9CLPoWe1KtnkcMM2irmJZOj/2J6AyUOyUmyG6D76lUQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDyxg+pbPUHyv+lTmquhDcE4cYlkrnjbmIwVdHoEnwU=;
 b=VTIKZ7D32eMzT7wA2JP/LKwmhAsd/fxEtq6RBmoD12cLpqxYMkgnqWsvQbdjtIXHHys0Mkdr0EDojQR6CDEGEd+HPDjj7LgwFvcYpN1xk7J2SzB5gaHN7+YfcWcSZkRSs97V37MMHxzi7J/255xWmc1OXGFltLeRcgCqnR/VAkPgD6l+e0g1FfmiYBAa+Imbad0HgxFAZUPuib/L03qPf3teY8dcZI4QBAwp+2wMNtASjyGpKSjg+qYP/TKGVPaf2XiIdRxWtcBTCjFMV6c8JRnhJqGD3QgJbR5jMawU2LbcBisJJ9G10rWY6NVYWulr1BiN25FTbBY/YuIQwrWIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDyxg+pbPUHyv+lTmquhDcE4cYlkrnjbmIwVdHoEnwU=;
 b=FK0+Ioz1awPxFbhfSWE1J7pRKeLRPNuQhLogyCtb2mjQja1keLqHJHtUSZiI+taTql7zN1ZeFL8DfX9xcncGf/tDU3FiuZxEPk+1S/GzGA2U2cpTtat/ydOZeRmfOo/JNmY0ud0Y1Qz1Q8m98GEoXIlX8YVDV9yOdgjEuJsGtyA=
Received: from SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 17:23:09 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e5) by SJ0PR03CA0283.outlook.office365.com
 (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Wed,
 14 May 2025 17:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:23:09 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 12:23:04 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v1 4/8] drm/amdgpu: read back register after written
Date: Wed, 14 May 2025 13:22:47 -0400
Message-ID: <20250514172251.726484-5-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c08d7f3-a4b3-4a9a-a0f7-08dd930bff6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J7s1jN8WOni2U+S/67nePMiz+qtj2gAiluQK+IyiqE2vesjAfH2ZliPFsomc?=
 =?us-ascii?Q?3IrY4f1uGlMnlqX6L7X5P1I/y6r18HIE+NGfFSLOseiM5iunquv9pBmFtUda?=
 =?us-ascii?Q?KEq3oExiFE6JxAaBSCjw01JV+LCSZa4kpwlyWhp6e4TQaqbs3pvuMnOpM6sD?=
 =?us-ascii?Q?GYBLGMNAz1PxUWCTphrIqGQZx1IFA5EYnkVKurOHdNb1NTmI3mYPx2iLT+Z+?=
 =?us-ascii?Q?Wc3UNQpw/8SjXpDAKHfQ2paHvHeXeFw4GP1pQVh0yMJTcyFPG+bV6qOqvmF+?=
 =?us-ascii?Q?aJkct8KI+usaSUqKsgIsWnXMaXrHtsiSuSImKSu2rjZpfODsonlphaIz5H5B?=
 =?us-ascii?Q?NP+0qoLE9XhoNILVOT5Se4DKzFJw+u1xQpIe0aNjjD8g0D+1xlg/fdT1NYvO?=
 =?us-ascii?Q?NKdHuP1lpq3bT+KiDYr1XHzmMS2xD+cidO1Jp33fMIF+OgxdXe7P1O4dXQTI?=
 =?us-ascii?Q?Anpj1nbb7ycvSBdvT0fSdGfGUXRlnDAODCd/4Bs6EMndKBcohII1mQa6UjEV?=
 =?us-ascii?Q?OikrmrtoGucLlkkla3/Qh1Go4uVZOrFBzg2GLrioC/pUvpS7gwnP1Ccys2Nj?=
 =?us-ascii?Q?mbByLAjeNXW04+wTQTMTnamEnxnYY8iDBBG6F8NdDGQ83dRA0cUnhmkEr8Ep?=
 =?us-ascii?Q?312Vs8Nqr6cwWPQIVjV3GjVrwo6VhEqx/6502SC0DO2YBfPkqD22SXDVuNr2?=
 =?us-ascii?Q?GWKPF+KTUdUdE5u45WAnPSfTHGBCx6Q8L5uX4YNhAewZyrfWRdR7E6eaI9Ra?=
 =?us-ascii?Q?eTFARpC00EwNTdmxpZvKAUklUNtaxkSkdN7VQVFMLV/8eGGzQSN3Gb84l+mn?=
 =?us-ascii?Q?7ACbKoh37xtjtaMzYyJpuCRl2zJmHJ6vR5ykPgJI+hR4g6ZvD2xAozroO4MF?=
 =?us-ascii?Q?TfJdHPTvltuWgZNdapHa4XexnL73PG87IOivlywYF0MqUvYM7h0TIO5R625n?=
 =?us-ascii?Q?HJyJwbsmERW2FcAKtyebEd6wNZ9B6a+wd1tDdL/IcN25ixtW6CNrJ9Abice3?=
 =?us-ascii?Q?V/mE+rtHUhgx+TiOkvFD++YVML5/Y31sSNmsvjuKwYBTzr5+BdPho+hkTHD4?=
 =?us-ascii?Q?IC0v4OdJQKBOpR5jIdhcKU9ItzoUqiqNkAeMG+XxQfpJZPcgvOwjn1tH5rCx?=
 =?us-ascii?Q?ftyWHp6x1PYQwsCDW5Uo8yN3hHQ32lR8bCuaNnI+IdMuf0swwVOAvwlFIZHy?=
 =?us-ascii?Q?HKUDjWMXuTmknM9o+rwievpKcT3Ck+bbVsvigvSUyg9Z3T0Le2cIuBPZ/xFa?=
 =?us-ascii?Q?KiJoGvlpyALj7gQXBc1RoZLb7qkyxizm6EZYlK+cfCHAzmF+NqrI9b4XBuTw?=
 =?us-ascii?Q?KKV38f4Exjh7Azyv1vSpYcZR4LlmAvgHs5ftEwsVwHjUuY6GGJvwqJgNJNUT?=
 =?us-ascii?Q?J5FA6ioFCj0fxZg0FrfoDP4RcGGwNtbM/F7VapIswpblErg5TfqKcXuNqsoQ?=
 =?us-ascii?Q?/LrGGaquz1DdGh/TumKa7L39/wcSjOLa53Mo6w+pllgaoPiTQn7+F7uUBuL7?=
 =?us-ascii?Q?YItyGSTK1I5esYqF8elcMMDJsxVkPG2X+Wz3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:23:09.4470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c08d7f3-a4b3-4a9a-a0f7-08dd930bff6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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

The addition of register read-back in VCN v3.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0b19f0ab4480..792edc6582c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1173,6 +1173,11 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR);
+
 	return 0;
 }
 
@@ -1360,6 +1365,11 @@ static int vcn_v3_0_start(struct amdgpu_vcn_inst *vinst)
 		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 	}
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR);
+
 	return 0;
 }
 
-- 
2.49.0

