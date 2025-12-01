Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E649BD111A8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B6310E35A;
	Mon,  1 Dec 2025 10:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vkhfhFjI";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB5510E364
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldtLJG/MOSYvuCp17znCzHAx57LULqucdwCFzyR1V6Lt7hVg5+LsQwO8odpHqcEuKAsORimUdJt2e3kaxc0iFsklY5UfI6U+U4ha+Ai7JRecyL89z/aUMgNGWkRydXKPyHjBp/bb/6KHb3qMDbPaZYU3glyorjs19MfNa5yzmuaCa1Tfen6xdaMvfqC5IsNI5YZHcsQZhoPrs28r40jHrHSGHb6m17MIjGmz3X3ihwonyowkjzygmYXtKtEcoLyZGr9kI4hlujcR4l5Y+mrRO+99aU0c5PbwaLMe0C3Eve6a9Pe73q3DzsOOaSRXg8QQCpEQW3BDrlB4+ZF7fHemsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9UOe+GJDNoJkMwQIGQHYVPWPTQPObSMslhmzBVMm+w=;
 b=PcD+5E56+jD/C6mINQQNQ8vM5uOloZazKVmjMndRfPGvAYR3sijOik4wMwA6jljLV+HK4938sE1Dt3hm9Nyq5t7RmIgP1r9RoJFyj9kvRDZCgE8LsMfuPbpwAQpqHsgEQNmDXq/Ay1eckaroVxM6WNjoY2zG8KKZRDGDOdZXIgUmrovgs36+kQNc4iHzHhUlglK7+jNafFwVvtLQye/vn7T4nr1g8S1zeXTn19I4ZMYRnIleMbqNJxYl6X3nig8uqeHZqFyREh/SGxw0+9oN4PmiyhDqW3nxKQeIkz4kcZJtkU/QzBR6oSSAZSSl3n7w1LndtPNVUWx70ZZxnmxWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9UOe+GJDNoJkMwQIGQHYVPWPTQPObSMslhmzBVMm+w=;
 b=vkhfhFjI/e6GbwHIznI8m3giHnFK+IDwdO+O/rUBVLGHik4vJ0SIBQH6LbWq1rruOGJW8njVx52MOubhuxi016l5VPgLDVUuJSA/5t3pT3OCIZ/4zkz3evNEx6e+SVWil7XeXuQa2KG/NXG9SlKD9YvL/fMvNJoCO8eagwLW+qA=
Received: from CH0P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::23)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:23 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::fd) by CH0P223CA0025.outlook.office365.com
 (2603:10b6:610:116::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:20 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 05/17] drm/amd/pm: Add generic pcie dpm table
Date: Mon, 1 Dec 2025 15:33:18 +0530
Message-ID: <20251201101331.101584-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
References: <20251201101331.101584-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: f18ba23f-30ca-48f1-77e1-08de30c265c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZU5UBYjENTL+hD1Kw/3ocE2FstQxWAH/V+hHADJzYoS+9CAdV3AXH+3ncNYz?=
 =?us-ascii?Q?qy1b5ZiesuKi5+2XGPChM+OPc3S7oQ3gEvkU9cL2Ov3NUHAfr1F7wHF6hAJP?=
 =?us-ascii?Q?EwSDJrA+DzPFJ3pn1N8lEr5G3vgOECHxmRO2VGENsZMw+INpkMl5TuzRanuJ?=
 =?us-ascii?Q?yJOpsxHlNM1c1v6AdIz5iLFACbBowjEdrxSAtiDvnnsKvUqWDjr+atyc+Dtc?=
 =?us-ascii?Q?Zkk0gJEqpShjAiZGoMb/wKJLf/IVOQlTx9KZs3biKq50mawazkYI0i6sxeM3?=
 =?us-ascii?Q?Ip9yxNjp6ysz0Jmz0GILmH4ZsJcQogvkUNvuGzneA8naZEFZmWubtTI3TKpo?=
 =?us-ascii?Q?yKYL+wKY8riIoVHoehvSk3lYQwvqYHnnbRQzGVb/DHZp8HM9ln1wjKcY0uuG?=
 =?us-ascii?Q?s+oOPN3tFyS72BfIouJHz91YysVdxnoB3JfTrx1y8KHUutmwpS6CKbE0bUBM?=
 =?us-ascii?Q?NbblaUkLFHM372gdyVSoRHOBYV1mM9PkdpKBlOUWvnrbdyDSNqqGovjNoMSG?=
 =?us-ascii?Q?8zM6ortFPrvs0S2tibnxY3bVMrP2GEUVmJn+kezQ9Z7FZ9r9AwRyq5oBc0gc?=
 =?us-ascii?Q?9HB6elMizfowzgpX1lkYqEhRmyyNbs+FK4NXKrEQ++5FZ2ElnvqNPqC/qSJF?=
 =?us-ascii?Q?MtM1ENH7pbKBdwf/mS+ielYLlUq8P1aM1kOzMPCDhs7Qd9A8C/Pmf36yq5jR?=
 =?us-ascii?Q?QbHiDj79EOb/A+D85BGQr/jTu8x7vhvyBHKarwSEfg3+gmJXQj4jEtNlNI5J?=
 =?us-ascii?Q?ir9HROwl+RSNnmQjuXiKp1N4KYupwHgs0A0u9956XAzzH/0+5XXCWG5IXOhv?=
 =?us-ascii?Q?FXTz5IZOAgo1T7XKcqFv/uXi4LXS2C+AQhESJQ3YJ8RT5kcdTBxzG3YnY6l/?=
 =?us-ascii?Q?0Iyu6KqD6AnfQWMAQ/MnQH+E7xl9NQ5vjjuhpB+ifyR2mKQFQOsHe8RSZHm8?=
 =?us-ascii?Q?tJq9sRO5bAGdoK/fckWx3Vdpq23RVypC5qjvf1MnmCD3SOZO9ojMoNrrszQg?=
 =?us-ascii?Q?1B+tD82oirDSw7DEwBgJK/+Mr9L00oOK7c0b8FmUtXq8cSmCqJ7QeMwMpuAP?=
 =?us-ascii?Q?FuXBwjZLoKEIU0jF+HeMyav4bPtMhS2inXcvVo7SjZYP9DrLunIcZFBw7Dy+?=
 =?us-ascii?Q?hbFHR4SSPTknqV/ZjU954FlP6yafLXUR+U+GE+PabSqWLBRx5PGF+cS2byUZ?=
 =?us-ascii?Q?jMqtrLNp4YQcZY6Gm7fwDtSrWrl6WyWuHC0VITVXMqykpPqZuubMh6bGc76T?=
 =?us-ascii?Q?Y0SlGM8TyynOcHIGUVdCDy5KgdelYVdLB3bEWg87v1nLfg1GQe32RjHflUts?=
 =?us-ascii?Q?90XzUSLVICEncRUS+4JbQXKw9sIuXYTpqzvNvPEDBGqBA/u6o01bMTuqTXJz?=
 =?us-ascii?Q?mOmwRrBCGHZxv3ZwgWNe1GwFJRvkmMpYmJ73he11ZK0pbheidsEVHK+TJkBS?=
 =?us-ascii?Q?nP9DWe29pHOpV98J49+JbUbXPc3AjBjRsAU7JYw7ZA9o6SHacde3pKRcjoV4?=
 =?us-ascii?Q?zF6Yh6PX9K7/OapgwzsgOv6CwgwCDVVUXBX4YD/eJHko38XeXu5R+jCSahmy?=
 =?us-ascii?Q?0cRAipZ8aAscFta6Qs4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:22.2010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f18ba23f-30ca-48f1-77e1-08de30c265c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330
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

Add a generic pcie dpm table which contains the number of link clock
levels and link clock, pcie gen speed/width corresponding to each level.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3d67d948eaff..a4e8e488030f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -314,6 +314,15 @@ struct smu_dpm_table {
 #define SMU_DPM_TABLE_MAX(table) \
 	((table)->count > 0 ? (table)->dpm_levels[(table)->count - 1].value : 0)
 
+#define SMU_MAX_PCIE_LEVELS 3
+
+struct smu_pcie_table {
+	uint8_t pcie_gen[SMU_MAX_PCIE_LEVELS];
+	uint8_t pcie_lane[SMU_MAX_PCIE_LEVELS];
+	uint16_t lclk_freq[SMU_MAX_PCIE_LEVELS];
+	uint32_t lclk_levels;
+};
+
 struct smu_bios_boot_up_values {
 	uint32_t			revision;
 	uint32_t			gfxclk;
-- 
2.49.0

