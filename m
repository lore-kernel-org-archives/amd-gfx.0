Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF16FC5AC67
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 07:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484D910E2B1;
	Tue, 11 Aug 2026 07:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RANtnqiG";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6061B10E2B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 07:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3a5xGRz+4aLIRwsPS1MiVyAq1mty8INiRjXxQBOIVI/PjSL5kTQGb5WdVgbisyZ7fEr7wlpvySjkv1cdumzW71B6i0gmIKJ7FJAVkNgWva7kDjP28+OezurS1AZlyE5UrIRQZXYFXrYjq0SAN+CYpqad5odWifUcM5y/5zK+GoZYwLZUAGUOnIsjf7Zotl0rtzVohgPIt1LElfBsk7sR0ppuqJwJMn3/GGLy4miSCp/wPprWOPWH5zyWMfaprIo7HLS0vyQ3ussDcwKxddvWT1POmLULeKm7wk0IpdfRaGmEK5BZ8hqc0ujOVB5fyz7S3xoQQUd+a8oVal/rMR2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a45shaDj4V9OfzWCVqTWWgMCqWhVBrHfpIogwtu+6hA=;
 b=YK47S0gILTEx1MHXbuC2NqYkGyZxE0Lu4izQHXW1woT5aRZP7/j5NhHjoQod7ZzWirdtj46WIupFTXYW5R9rIhR6bKvJVUvlWEA0HSdvHCOGEhTNgbXoRgndEDUthRCwl8t/CWLaDKBMrhHGH0P+OwExuukotmsJsYOOjg+TAh4V3e7Fe+6ggRkTDTcah88lIGs0x6bWRFd/OM78laBdhXZ14sqjW5+FV2YvN4V+6UmtzBY0SWQwbwb91+bxUXwojOJ3AlNI8QbBU2nWrTQqGK2il0BKkfuuDbtDBiEBCOJjecIY9XxgefFcw5Xw0xsCGKVdbyQUXnc1LLkKAewnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a45shaDj4V9OfzWCVqTWWgMCqWhVBrHfpIogwtu+6hA=;
 b=RANtnqiGxjXNwtJkyeAbl1rkdLeYsDUCVuJIOSJnko3dxCWh0L7RgDbCoPNrXf/8Pkf9WEVV0aH1XNDt6I0peBzXlXwnThbUHItLIj2yRS92uXC3db744/ZUAGfoeNkt1ZZckdD10Vnl6oSsp1m8m1N6ugMPCuNF+MaOKVG6hRU=
Received: from SJ0PR05CA0150.namprd05.prod.outlook.com (2603:10b6:a03:33d::35)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 07:40:16 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::93) by SJ0PR05CA0150.outlook.office365.com
 (2603:10b6:a03:33d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 07:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 07:40:15 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 02:40:08 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu: add missing nbio_v7_11_5 callbacks
Date: Tue, 11 Aug 2026 13:09:03 +0530
Message-ID: <20260811073953.553303-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5413afdb-2bd4-400f-6465-08def77bc8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Krrv1zSZ9klH2p8Hxg5v84Aq7YGOtK698ZuG5BxiZWm+1Rjav3P+kMj1DOjuJyI2GYQASaObCaiq2w/JKS+IQf8FPOh0JuGi1T/U1rxV+F7/BOEh/cFmHas0dZLVEA2zYZQHeTJgfsY0hKhYmv9/3J8jk8d6cQFI4L3aSwq4gslWRiFAh8x9NS9oek2KaCUnTwQSM3PfETmjQVvnQAfC44nCdkMkYXnNUOdVYxg7G9qS6kuJ7g/dcGjNnHgRlPu1k+N/4KCcXU81VWNkklixxaAW6G6d9YFtxFVsZf3NKsC/YMNvrtK3uxKqMAjzcBy38+K+UH6LGx2GCaNXH/R2WQIUnx/14k9GeL51vapJwtgZPFxM47Qo6WOxc7z9DkOORdYOLtgy4jbPQ/eWfPZ0iq7IA1Zrwt4nLnNpxc5zVDleGqHZVRttVI7X+gLiCDhJj5f1qxQeaoAalhtUqZf8zXxMTrqD/3zUzrNdCvOoG+BN+3uMEY/yJweS5hsVjrQ7vusdigAtuMrFuCgJOQdIJX8N0Chj7euyrMOwEwoOTaALFKfkTFsrMeBh5wjiWrC5odKXay027I4QCJn+dAFGPzZyoNLpVPQ9WmyFLyZkMb3Ohxb7cHET73eQFuiakSzT5jbjLTMvfSIikvotHuziCE6Pt1MAdYf3BeHCnFKBW6nrZXCcVYYFNrteQuW43QsNHdn+9T6QYo2YMYkuJc556w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +A3pQyi8vwqZ4uo0VIZQFw9nNow3FnTbrSbYCspnhLrmwNqOj/nHszNOqi1PTqUqEDyx5kzaCufSY3tArk9tuOssxY5jH7foV4a2T6wTJOJ4sSQw466vphd043KX8BQvaKnj0csS0hfI4atk/qUIgNEcHjqIQKnG8uesLQMKTim01+LIs9mfzfQI/OZW4iFrsYatuVdjqp4cdh62K3DXwo0DEJayvE8c18YY54NbeZiy2hsWXirUKJIqX4HM8xL9ktXNaAmd3Hx6RfXIjr4ouCKRzLzZFqOEbdA38+rkVALonVjXQtkbyNOgQojaxNnHBlap5qod49CeZLusXbL5HKG6305WD5zTtgN10JeHbUPRwLQRqBd0+KUDPe0zEdFJ/hlBBks0zfQazT0827ENoorxm0bqAPxHP1oaBy/GlJ1WkTDGnFf+JxV3NdgQB216
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 07:40:15.6331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5413afdb-2bd4-400f-6465-08def77bc8f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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

Wire up get_clockgating_state, update_medium_grain_clock_gating,
update_medium_grain_light_sleep and get_rom_offset. The missing
get_clockgating_state caused a NULL pointer dereference when reading
the amdgpu_pm_info debugfs node.

Fixes: 0453ccd3237a ("drm/amdgpu: Add NBIO 7.11.5 support")

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
index 9bb998a47ef6..558511dd25aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11_5.c
@@ -249,6 +249,24 @@ static void nbio_v7_11_5_ih_control(struct amdgpu_device *adev)
 		WREG32_SOC15(NBIO, 0, regBIF_BX1_INTERRUPT_CNTL, interrupt_cntl);
 }
 
+static void
+nbio_v7_11_5_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+					     bool enable)
+{
+}
+
+static void
+nbio_v7_11_5_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+					    bool enable)
+{
+}
+
+static void
+nbio_v7_11_5_get_clockgating_state(struct amdgpu_device *adev,
+				  u64 *flags)
+{
+}
+
 static u32 nbio_v7_11_5_get_hdp_flush_req_offset(struct amdgpu_device *adev)
 {
 	u32 offset;
@@ -309,6 +327,16 @@ static void nbio_v7_11_5_init_registers(struct amdgpu_device *adev)
 	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
 }
 
+static u32 nbio_v7_11_5_get_rom_offset(struct amdgpu_device *adev)
+{
+	u32 data, rom_offset;
+
+	data = RREG32_SOC15(NBIO, 0, regREGS_ROM_OFFSET_CTRL);
+	rom_offset = REG_GET_FIELD(data, REGS_ROM_OFFSET_CTRL, ROM_OFFSET);
+
+	return rom_offset;
+}
+
 #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 
 static void nbio_v7_11_5_set_reg_remap(struct amdgpu_device *adev)
@@ -337,8 +365,12 @@ const struct amdgpu_nbio_funcs nbio_v7_11_5_funcs = {
 	.enable_doorbell_aperture = nbio_v7_11_5_enable_doorbell_aperture,
 	.enable_doorbell_selfring_aperture = nbio_v7_11_5_enable_doorbell_selfring_aperture,
 	.ih_doorbell_range = nbio_v7_11_5_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbio_v7_11_5_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbio_v7_11_5_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbio_v7_11_5_get_clockgating_state,
 	.ih_control = nbio_v7_11_5_ih_control,
 	.init_registers = nbio_v7_11_5_init_registers,
 	.remap_hdp_registers = nbio_v7_11_5_remap_hdp_registers,
+	.get_rom_offset = nbio_v7_11_5_get_rom_offset,
 	.set_reg_remap = nbio_v7_11_5_set_reg_remap,
 };
-- 
2.43.0

