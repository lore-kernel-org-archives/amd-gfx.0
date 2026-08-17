Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F1EC5CFC1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 05:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09CD10E63F;
	Mon, 17 Aug 2026 05:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W820Aaab";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0C510E63F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 05:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1xZqF3EK3vBh4uiBbaato4abWcTh1V0+nU0uledtrdLX9YTrm6ol9oXuK32JmKI2gxF7dvZW3QvJAwkhwyfxzqd4TdwbLJ8ial1hwWayjFkT7OthzT/F8F+V1ylb32mxkYXYUtbZwTzbOMln9xjW66XeNyX58CZFq4W5fREf4LmtNGaTI3AS+8SmyuHTza1oIb+JNuau9BFkM0zsk9fgrcKJ8Q+wgILwBB6wZCSGe8+p1/Wr8swShIBgk/JHhfGQk8clu6d61rRvx+xz82ecOMbhLx9pcgCULaMludRG2k0CzlCTB90HROwz8YdcQp0omJy9RNFQChw518fDBIQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTxuJNGV4MFYvygkXXFZ273Xf7wNBfKYYC+BdcU1Vys=;
 b=ttPhBTvuntXX4nSdnNrtIprVRPCsKtqfgcbw28v3Rzum418UyD5eSm985kg/8S5+PMZuWqBV1NRPzsnTQj1ZwEOGh2hi0F5PGDr/N17iiGio1da1tn7HY1krsEhINNKZR16qWFLataA/1EjzCqSvh82W1gr8rmq8s496Wuh6m5SEwWqbGQhyKDrNgrVrIZdea7IlcSiwerfryP8HOQBfdjLssKFHR8IoA3HzD79phHpHkjzEj2U68qKLoYSR8Rm/2ntl2/LMKtit117ZDSvwV1F2ge8oYBj0mvrIKYavH6fQ+3rGYK5pBXHDd+eERPAojOimsBZrgxB0QBM9VrF8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTxuJNGV4MFYvygkXXFZ273Xf7wNBfKYYC+BdcU1Vys=;
 b=W820AaabJuYno+a407T5IfsMJ6DUCsRjLwnQxwPFvPTKLvQLH9erCuqS25eCbUPGDkkMKBdVK/aqy6dWm7FuzVZD+xD1BUWh1kTVGKqxbHdO3sVX7eQ7ICYMyZM8s3N4Viirh2S+rLPgmZOO8DNlOa/2iUF6u2kZjUIIFS/gAm8=
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:30:48 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::86) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 05:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Mon, 17 Aug 2026 05:30:48 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 00:30:45 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu: add missing nbio_v7_11_5 callback
Date: Mon, 17 Aug 2026 10:59:40 +0530
Message-ID: <20260817053024.277429-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fe97b8-61d7-4de1-9235-08defc20b1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: aEx0wtqnjoDDFw0Fdgvsq1pDzKxzRnCL8Ws4/L02H7iL5HAsjPrk8U67paobf4vOoviFwZnj/HKu9QvfTAwe5aURyaS8kA4jS16QkSK7qJpctN0gIe/7XY+54dCpy5w+305ttetHUqD5F0jZCee9J9m8Si9yEiuVq2GyYbr72K7imJQpVch5yIm5mfQOyGQ76lp5thuTVww/hHYfUdfKpHa2+/FG45UTh64OrRpLBvDzTbGResd8FhVj8yzB/y2g6/g1EwrZI5wPWYbgpRWMwYJ6xO/w1A4qWlRfCO2UEmnWnaTuChfHRcLO57roYMKp2pifMHxTpw0mYWaXuRBP4XKt6uH6i8xV0Q044kdHCvi9Uag0CANNtxN9nhNa3kDM6pE1A/Hop13cppe5IziNy2aRukdTM/OTSuXWlVQYD58ksvrXSGluatu+QSr7H+nbj1cptF6D6ylFbQIecXGotzrGDWXNIksOZIrAONOGPCqap7wWHT6X0zJMd6B96hnQWsTkDxMaNxTT31O7kKat99h5rfGLnz/85JliCQi2obuLw53KNonvLYAb0A2LmyqfeOVoR8NSP1pI5ejGxCFoA7U0xMKsN7ie7ni3FX/45FNTc35HKvbOyjZxIHdWngwx0JyG4eL3PwvYKVJuNfyKz1LaazGztFMWhsEaiWs4GVodgehjFizz7DrCMc3EVtOHLhhgWPht5T3up5qrBqTNfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZQSnNv3ji02kY8gyHtsNtGVH5Ssr82PHade/kCLeAkh+s03ST1I3byY/lZHoJMKEcR07xd+qtu6+pfGgJK97veQNbp9Ud3aRvjP5rGPhJWFvsHUGMD5D0nRLZBS56LreeBHtydvMZrmaRc4p/uIzITdLCT7dvLDg+Lj5qQAva+zkAsVoDuhG4iKBHnILWjLSJaeyE2SrwEjdJ9zdvlYuVjNQzL08XA1/jga5nk2+nekPOnoBO8zVU7rOkGhW2um+jd+0rriSdBJsiNEDXj/3MY0FhnFqthd+Vm1KHTA0bUHL6aKcxZJyb8sT/IbUqvJa81RL9Q/IdtfPuipqhfN1amQy0tubeSE9doNeZdkXC1W5Z7v/xX5OI0k5ExyGHuUe0hKqFBcVyPyL/AtKm1ZgfHDegHopfJdFVv1nCSyjNN/VkyidRbmE42hJ2VUD1qgX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:30:48.1100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fe97b8-61d7-4de1-9235-08defc20b1a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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

Add get_clockgating_state() since the missing
get_clockgating_state() caused a NULL pointer dereference when reading
the amdgpu_pm_info debugfs node.

Fixes: 0453ccd3237a ("drm/amdgpu: Add NBIO 7.11.5 support")

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
index 9bb998a47ef6..0ea6e091a24c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
@@ -249,6 +249,12 @@ static void nbio_v7_11_5_ih_control(struct amdgpu_device *adev)
 		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL, interrupt_cntl);
 }
 
+static void
+nbio_v7_11_5_get_clockgating_state(struct amdgpu_device *adev,
+				  u64 *flags)
+{
+}
+
 static u32 nbio_v7_11_5_get_hdp_flush_req_offset(struct amdgpu_device *adev)
 {
 	u32 offset;
@@ -337,6 +343,7 @@ const struct amdgpu_nbio_funcs nbio_v7_11_5_funcs = {
 	.enable_doorbell_aperture = nbio_v7_11_5_enable_doorbell_aperture,
 	.enable_doorbell_selfring_aperture = nbio_v7_11_5_enable_doorbell_selfring_aperture,
 	.ih_doorbell_range = nbio_v7_11_5_ih_doorbell_range,
+	.get_clockgating_state = nbio_v7_11_5_get_clockgating_state,
 	.ih_control = nbio_v7_11_5_ih_control,
 	.init_registers = nbio_v7_11_5_init_registers,
 	.remap_hdp_registers = nbio_v7_11_5_remap_hdp_registers,
-- 
2.43.0

