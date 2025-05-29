Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7488C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 08:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647C410E71C;
	Thu, 29 May 2025 08:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y05/JwEr";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0513710E23C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 08:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUAzzGo1mnGZTj5Ajofhv4G3b02k/mlTvCVkCvVAGlgbReBok1hdtBOVQKylYUOvPMbAc5Z7J67bfCDOCmXJy2vVQ2cnKl8VU2qIDwHihBcxLFDnG7jAkfXbQW0EnJy/XIrScABKZWSOG+KVoJ5xqm9iAoECn5KM1OPyPuhi+REqxZUgP/l00BVhTwezAcvxc4U4vfq5lxa/fGzHdSNKYmfjyxCmY7L82h/kLzrgUN6zpcxyFMlb7A7S9nAKwZXN6L+cWqU+SIrjk7S/F1SSFjFCYZDYf+w8U33cjayq5FaRXQ57gzWHEChmzcQYji39FteBaxwcw0DsE8bvzt+fKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsTwACCFnCd08WewZYLbkRwEhk1yokx6rcDhulZ4P4g=;
 b=q56U9va6VSN3ln3sT+1Kpb4JfgFIk8/KoW641ZsY5EO/oxgGZFVsVXJQ3M8p20SdBrDit2/HYuXB+E6otmt4oTXIzUmxS1v+vXIWSXMo72CGyhVKgJaGnH+bfDj+kwR7Jl+4W76vwbXLargfC7cf71U0CzQTG4+2SoCSZ/sWoo0sdAr9cs7vIKGEZhTTWYUA0NUPtZY6x/O8THQxydQohyQzg45Rn3Bw05BtpxQYlVkGsN1I2rztONJ6e1J1joJLQYU2f68fZaJhRp1Lm4etbRsWfI/zz6NZRWQQIQcjizOjbqXLS16bk55to1Fa/Bg5WBUI18l3TDMVgHiB/zXc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsTwACCFnCd08WewZYLbkRwEhk1yokx6rcDhulZ4P4g=;
 b=Y05/JwErdPXptxXnMmeFq5AJKptZ+PU/GtoZ6+cLy+QuQDYf4J3rpRWoMSg5PDxIEg8JL4RZMS3kn+PNMzEX63wAylKjWPsDjWSYMZbZ9GY3OikBDet/480/+oy7zG3CATdB3BV7RIEPhvsFWDMSUPyjsw1snnSZvO85RU3wJ9M=
Received: from CH0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:610:e6::17)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 08:30:35 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::fd) by CH0PR03CA0282.outlook.office365.com
 (2603:10b6:610:e6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 08:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 08:30:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 03:30:32 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Mangesh.Gadre@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Remove nbiov7.9 replay count reporting
Date: Thu, 29 May 2025 14:00:15 +0530
Message-ID: <20250529083015.589652-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529083015.589652-1-lijo.lazar@amd.com>
References: <20250529083015.589652-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ca4abb-27f4-4c81-e66c-08dd9e8b152f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6iwgm7Faj+Ly2B6RsEM7Wglske6r11aOnFnV4A7Wh3VHiTFD9oF0T0AraJfM?=
 =?us-ascii?Q?bA7xkS4k1JSMgd1eUqZxnuaFnkXUzGofPPdwDfl3kiPOOaRfGOEk/OxNpNGm?=
 =?us-ascii?Q?LH7MCE4eZSRYG6b0ENSmDQkZd4+fBFGMXhOOKPi++qw+fr/C6LCsUWOgwql+?=
 =?us-ascii?Q?HyUnc3Eq+RjyjQ9biWYoSlyTpmxhEqocnnvrhr/VAlvPhwLG9wJ1BqNue3k7?=
 =?us-ascii?Q?RYIkrRLF62kLKOGNIe4VjDoaj5deNRwpVxo83WEKUQNuChfV3YvK7nK6ozuS?=
 =?us-ascii?Q?rPb6Jti/W8Ux69QHV+J3jdxzY8gQ65CrqGFVZ1kAKNjHgkk+IWqXiMG2Bvqx?=
 =?us-ascii?Q?mBGsncaA5PLY/sPRp9akD/NIHwY6I880Nz4xa6dsCtkuAYPD71V2+JBtQmui?=
 =?us-ascii?Q?rIOgx9x/eIPj7YB498vYGJ60VIrpF2Xo/p52ZjvSVu/0B9JTfM9KBZc4evX8?=
 =?us-ascii?Q?/yok20M4glzYDWd3fKdUldXh8fXk209HrteWRhDO0VuYduO+dVkhqF6944i5?=
 =?us-ascii?Q?Ry2PqaQ2pztGYheQ+N8yOp403kYZq5bjpSMXE1zxS451y2S3kbtg3gSxOZpc?=
 =?us-ascii?Q?3HE/LM+0lyBi1/5+XmkUrmVUTrlBP1nb/FpTMRjTzlKOMgEhL12WdJfoUEdc?=
 =?us-ascii?Q?7qSqCpOvDuh2VXngNdIrsyGpSF40lebQMMi/RG+AcjZ8P9At+Hc4+T4qzonT?=
 =?us-ascii?Q?uhyzfbZDG24RFAmn9lGBN72nOAPnpk5B/jVgGtdRhA3yUEJONA5WnOpH1z8I?=
 =?us-ascii?Q?hw0jPsn+JaJisEbj8iNwJruA2JRXfQYxK+DU2F7E7/Ny47fhZC5iqiFziLpa?=
 =?us-ascii?Q?E53guKYaz0gKOJOVOg52EcyN1+Ccsj/EvXdi+SfUpZanfNlWEYV48SuTjkyb?=
 =?us-ascii?Q?vaIQkuSHL9EEIu3B9e9gRH+vrenKTTLj/SQZZgiabnYJ2QCHXUi/TAfJ8GYP?=
 =?us-ascii?Q?e3NqFtteUWriF8uIgaSXYGgMHfbYarFNuvtAmukYm2dwUpdeNxGvzuolCfN9?=
 =?us-ascii?Q?iYO9kTNOB/IR4W0mXvY9P/vJMlDNNnw7oVxHmY9eny5a/vHrS+MT14HJ4L9X?=
 =?us-ascii?Q?GvrMqjopRqB1BsoLaRoVdiNsbyp12HCM9P0V8qdV/WJqK5yRsPgmQBRctc5U?=
 =?us-ascii?Q?kLmSSE2NCSKjLWq2eA5hAUTE/zT4zMF9hGqf0wgjr5vXd1MzKLQ5s61Pessw?=
 =?us-ascii?Q?5vkUv0aIeCJQ51s5A5x/R/NA2AUCqvHkQRr9BuRarCZPOERqoIYB1BEhXkUl?=
 =?us-ascii?Q?ZO6Nux/2sszSsDtbqn8V+IV8jfzH04CxwQlM/yEV0kWX2z0CuOC617+o+ukt?=
 =?us-ascii?Q?VsKlQadnmY86EJ4+V0hOof/A5y3/z/KPlCzP1W4zKwnP5YRNA1ZYVC9hYADH?=
 =?us-ascii?Q?Njp7YzUb+3huvvcemGZBB2DOvWXZDt/PEcsGHR+5Psv0CYL5k4uX/VrNDG5f?=
 =?us-ascii?Q?iLkJH/P0Vn1Tdm7mRc2MchD3fRNlKJvIth2fdMYX1kYrUNG8FVtD6oTUx5pL?=
 =?us-ascii?Q?I13yNQnqrzx50cH8dD8B1Pv1Vj5/TY23FHlw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 08:30:34.9054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ca4abb-27f4-4c81-e66c-08dd9e8b152f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
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

Direct pcie replay count reporting is not available on nbio v7.9.
Reporting is done through firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 50709d18f4a6 ("drm/amdgpu: Add pci replay count to nbio v7.9")
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index a376f072700d..1c22bc11c1f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -31,9 +31,6 @@
 
 #define NPS_MODE_MASK 0x000000FFL
 
-/* Core 0 Port 0 counter */
-#define smnPCIEP_NAK_COUNTER 0x1A340218
-
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -467,22 +464,6 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	}
 }
 
-static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev)
-{
-	u32 val, nak_r, nak_g;
-
-	if (adev->flags & AMD_IS_APU)
-		return 0;
-
-	/* Get the number of NAKs received and generated */
-	val = RREG32_PCIE(smnPCIEP_NAK_COUNTER);
-	nak_r = val & 0xFFFF;
-	nak_g = val >> 16;
-
-	/* Add the total number of NAKs, i.e the number of replays */
-	return (nak_r + nak_g);
-}
-
 #define MMIO_REG_HOLE_OFFSET 0x1A000
 
 static void nbio_v7_9_set_reg_remap(struct amdgpu_device *adev)
@@ -524,7 +505,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.is_nps_switch_requested = nbio_v7_9_is_nps_switch_requested,
 	.init_registers = nbio_v7_9_init_registers,
-	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
 	.set_reg_remap = nbio_v7_9_set_reg_remap,
 };
 
-- 
2.25.1

