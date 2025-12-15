Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED3DD5B864
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B12A10E4B4;
	Mon, 15 Dec 2025 18:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ADfsQn5T";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF0310E4B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D99oN4uUgvmgA8L6coIyM6e/s6vzXb0ft2fkltonKO6SykWqS2W+9KvMKOumzHk/clH27oeefJZC/7UqTytYQ7OrcdVDS9iHDxzmQ8y/zMAZZneClMP+C98otmRBD+J8C2bKhhWG9BjUjxJ6ZvzJo1wwCIpRS5NL5ZXuOtORor3yaKmwHRf1wn8hDGkxwgja1fPJzoeQgDuSj5rk9wI6WaxKK1TTum6+uUCuFz2vr6oK6Q7EBCIL11XmHlVX0ijPieCr23+difx8xDVvnca8egCceU/7dHjed1lIq+/x+QKyYCJPkw76PKIQT9APZlZLCMKg1a6VPkiT4W0ZXbGF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NZZVBIw8Eyu/vEE5rVWePm2ymwh8K489WaMyqNAyjw=;
 b=t0/F0l2PUiylt3EwV6FEJw/vWfn2UVPGcTJOja2h/Go1aBqVmA9SWu7u5hMV+VcHDqSkefDk/eE25llXgrXjnBYcoT/D3RAyHxsb5iCsH3xIovrPS7VZG7nuBW5Xl/mxKjc5d/Mm1jcut5tpWifsn5w7AGPSDJlP8m9skAdArNdB/+W403f9RdG9METVbFFqf9hA+XFByOJmGYLSZ3Vq4DcTZ5Z0J2k6dpn+7SPXCh9vvQSxTdA290L1kANj2Kza2R7carLIi+WpAshODV3OkDyruEH239fJwG8wf/eND73TiHBva0e7tdaRtstFUlKp52OWSv4gcr+yNziQgbTd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NZZVBIw8Eyu/vEE5rVWePm2ymwh8K489WaMyqNAyjw=;
 b=ADfsQn5TIl+O8FJk4pSx43ynqAJiQdTzJCPBohfhYNctMdkpBmDhb527eLufe8602XxSMT2n0G8Wpg8mcgM3W06RP9rP1A/Wr7YVglBk/2DWr+/V7ATkyQfGMRjc/V4j+EoDkFOMdK76be4Rnm9Ja5AFDnjog4ky6pwRsoY6wZ4=
Received: from BL1PR13CA0212.namprd13.prod.outlook.com (2603:10b6:208:2bf::7)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:22 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::fc) by BL1PR13CA0212.outlook.office365.com
 (2603:10b6:208:2bf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:21 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Setup Retry based thrashing prevention on GFX 12.1
Date: Mon, 15 Dec 2025 13:15:50 -0500
Message-ID: <20251215181607.29132-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 856d594a-6428-4dbf-4603-08de3c060cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WJtSEXb7133UWLosGG4V8nSXMJrmwNunETpSAnQLPmwcQVITQwORBLhTft0Q?=
 =?us-ascii?Q?nOU5P410NZGg7mgTwpMvIDsGZCO9hURGCvEKsvyHsDL4Zb6B7ZIEmLI2StR6?=
 =?us-ascii?Q?h7h+SytwPDZxOuNzh7L6ooyuVJzkvNa8yXccBHuJkx58GtFyBu+SL3V/vJw+?=
 =?us-ascii?Q?kn+kd9kKrD6THIChf261ByXERTYMINcAbMdFWDkgzM1mjvaMJ599qfmY0B9/?=
 =?us-ascii?Q?X0MHZBMvDtzuLJEBt2AQSboOWxyj/FsZ0/r9Ip7bcF4A0uGQdTXTYtdXIExr?=
 =?us-ascii?Q?zPv7f5w2B6vWSxOesgg9TrQRraB9I4OVZTfGnhPP39ZgDx2dH0fqsRf05bK7?=
 =?us-ascii?Q?L4l0POYXJOYCLExpumeCrNPlX4/OAhLJgWGw6eUijc/7pSAQXC9/dK3eLI52?=
 =?us-ascii?Q?xIM7/21Z5DWe6KzGoSKzUwj1t8p0Z9YRdlabe2nodFEZoN24+GMn0gEjIWC/?=
 =?us-ascii?Q?FR+O2KDyMvLY41UU2sBLtSBCbYvjv+kFpWMEwzG87oOm0+03DsxXdBaCmI6w?=
 =?us-ascii?Q?OZVeygon/+uZzAOs5Nqay9NgksVzx0zNY2Z4eOOUf2V3ZlqZnwilwwpEDmYl?=
 =?us-ascii?Q?/ixXdjAWl23PA96aeQhYbiGyUIkm130kO1PZGYIMhEEkY8g0Lfhe90rD5oU/?=
 =?us-ascii?Q?Yj08vjyDvWNIezUqkv6/0s4GVQWjeU99IXfcVFgltGqUA0W8S76IytMPrxX2?=
 =?us-ascii?Q?8N+QfncxNQRwU+0nicQszyhfDYuzaVuVKPdXJP9o7dUVJdJpoTi94duZ700E?=
 =?us-ascii?Q?KHoiZiey786hep8GfHf1ghVfqxTdFMa11gyVFN7/LWVzyq4S+Htfr70AbM5q?=
 =?us-ascii?Q?KKuQNZvYZngGemGi7sd4WaYbUg5DuDoybsEJIOlBu2pkSnBCplQi6I16THI3?=
 =?us-ascii?Q?jKggCq+gBhFybI5bE0evPf5b30oYM3m3p4ACsWSRlwRWRL/w+po9vydtBody?=
 =?us-ascii?Q?ArNup4ZogP15ieoVtH0xOiad6NapaG3FWbT8bt2oGmfv3esCuRGH6MPH/5RI?=
 =?us-ascii?Q?3jG9kKlHIGLj/LiSFaUZgsxKyF3ZjTuKAyvKhfBUYAorXVjyTv//J7xBlTv/?=
 =?us-ascii?Q?yjJ2+iJhINTUkpTquBxUsk5BaAle7CPcHgC8DXsHA7V9cDE8Wilxp+3/5/fQ?=
 =?us-ascii?Q?Vs8crEtl6/qsknma4JDpKLZW7TOdZ3+Vo5nqwP3XoAAfzQ/eMQ38ylCOrZFB?=
 =?us-ascii?Q?2argpU+gtd1GhQG1m68CZZQKAd5zeCsEcMSw56JyziOiIHi11MnAwyrhxFBW?=
 =?us-ascii?Q?8/6hBLsiB+eD34+CvRwK4BMtQourmRVEP0WHux36I/qRyyQxYEmIWmpVfyq5?=
 =?us-ascii?Q?cd/gW2pBph3RanDdDyMGlThfbYj/cvMZpJO2nGGhJ37RLHgCDB6hU8ZzxzpG?=
 =?us-ascii?Q?74vA4Dl3fHEawURE9EbdW5uKsCqbzZTQQi1WIfVnLTMnI1qLt0Y+8VCdI7Wd?=
 =?us-ascii?Q?9nfDYsYFEueORVl1t4k5qTAfDNNATd+pTgS/gGFckipVK25hYQUvQQxQ5B1Y?=
 =?us-ascii?Q?qv6mXucu/ZeOEaGX3ta8pdI4fvZzzxNCQ5Qdg2aCSycoiJAno9QmnsQsuFn+?=
 =?us-ascii?Q?wckrcxqokBAze0Y7gvw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:21.3431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856d594a-6428-4dbf-4603-08de3c060cb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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

From: Mukul Joshi <mukul.joshi@amd.com>

Enable the new UTCL0 retry-based thrashing prevention on GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 0e57c367d9819..6777319234969 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2607,6 +2607,24 @@ static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPG_PSP_DEBUG, data);
 }
 
+static void gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(struct amdgpu_device *adev,
+					 int xcc_id)
+{
+	uint32_t val;
+
+	/* Set the TCP UTCL0 register to enable atomics */
+	val = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+					regTCP_UTCL0_THRASHING_CTRL);
+	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL, THRASHING_EN, 0x2);
+	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
+					RETRY_FRAGMENT_THRESHOLD_UP_EN, 0x1);
+	val = REG_SET_FIELD(val, TCP_UTCL0_THRASHING_CTRL,
+					RETRY_FRAGMENT_THRESHOLD_DOWN_EN, 0x1);
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id),
+					regTCP_UTCL0_THRASHING_CTRL, val);
+}
+
 static void gfx_v12_1_xcc_enable_atomics(struct amdgpu_device *adev,
 					 int xcc_id)
 {
@@ -2623,8 +2641,10 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 {
 	int i;
 
-	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); i++)
+	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); i++) {
 		gfx_v12_1_xcc_enable_atomics(adev, i);
+		gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(adev, i);
+	}
 }
 
 static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
-- 
2.52.0

