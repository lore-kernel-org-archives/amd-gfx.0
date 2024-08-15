Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25416C52D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 11:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F8210E1F6;
	Thu, 15 Aug 2024 11:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bsuGZ00p";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C7210E1F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 11:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8FI3HDKWOWN7sbmZISzq1qCSGXtfWcX6Q8TmCUheV0jhW4TwTc9fpb3RI7WwsZMOsF2dX6N7hk+QkYxddzjsJ7QC6q1eeqpABJ8FcAuTEjKzSfyet0m7bneLM6X7uoNDhHFdzKv8VWmXtXw6cNFJofpEhQQbxt6MFF5d1looi2hwExBJtCvLAbl8JxOkNXkAfoKkLH/Wr1OMQKRfFG4sfv0z/j2hA41UDCM35bI2+GGkWWC1BWXhbp+YkTO6bxUycKy4liouz1HGBamz5+tlUWef77CVIzHw7uD2Pbz1L3mQ2K/iFiLFIBwg6+Y0btQAo+ydp+t863DLpo0C5P+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sQ/NABScH4/p57hhd9kRMtZKeD4DKC20QZVqT2oXwE=;
 b=c131HNUc3d7P6iWQiMQXnLJoB894gGDkwxiJ6kVlBCPfSY1OkeGSwf6/jj+G4pzeMQPLM75XQsrXLI/xdVV/qIWPbogkjfv4KDnf5YWjbxhef928NwRxFno441RdJDFqvr8mGwRHQvn+QvFMeXfGMp0PFW5g03YQer1j4mA1Xu7Ux6rc71PpWOH90ZpQZtbk5QNr414Qi0oMycpbRWOZWpJr5pjCrtW4MThYnSnr8Z9F/gmOrb9PK1958H6yv1CPyow8qYARf2+2eHQjP0aAlMryjp33rQgkKS7/E58XRSW9ETEg/mlbxYVe0rN4ObbXs8KkZrWwGFy3i+Kav1Cf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sQ/NABScH4/p57hhd9kRMtZKeD4DKC20QZVqT2oXwE=;
 b=bsuGZ00p8AheAtmGcwb2KlqJkWgTVCLWHRs1hODXsLm8ql2t2/w9ZPXUl0h+2U3tgpgW1KfqA9hsPmWSx3Rt3TmpyqIuNofgZs1kkoxW8h3+vyZBDcOygA9Uj30aX+OJiimtO1y66DRSrwefZ9ajjQALRdgDQTQqzJgNn9XYvLQ=
Received: from BN8PR03CA0021.namprd03.prod.outlook.com (2603:10b6:408:94::34)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 11:38:54 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::b2) by BN8PR03CA0021.outlook.office365.com
 (2603:10b6:408:94::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 11:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 11:38:54 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 06:38:52 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add gpu_coredump parameter
Date: Thu, 15 Aug 2024 19:38:34 +0800
Message-ID: <20240815113836.399377-2-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815113836.399377-1-Trigger.Huang@amd.com>
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: e614ebba-ce76-46b8-22f0-08dcbd1ed774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yeGvu7SeqCzk8M1HB7vOaiJMqVMAdszwqiuD5WKVN2WrFyddPUeNOunWl20Q?=
 =?us-ascii?Q?RyvZeHYz2FBBiZdDQPia1QACvov9Um5v9AnIaQ9bAFdxB74mXRK8BXdq6Pjx?=
 =?us-ascii?Q?SjD521oUzQU1FuL2lcMYbXO6cByQRwraACsIng7CDrxBdfsmRFk5qd+xOO5D?=
 =?us-ascii?Q?IEz8XJtPZeOiQwwN3F9v7uA4juAQT5ny4U2qqxccJemd4OM7ruKlHO0I5bPd?=
 =?us-ascii?Q?XDUd4ye1SeuaRDp0xLvl66dh3de+52KP6Pn9uUpPNSciq0iAtYKT+Msa79Oa?=
 =?us-ascii?Q?vrNhoE489qKnXg2OBbcYzjGnSLS0MpqQA40m1iXSavuHYIhbTI04J61x8M96?=
 =?us-ascii?Q?/sXAYeCp+TFHl68aE4L5a3Y0wty9RHuhsuSSXXrX9gAHW80RsUd6VkvAKujo?=
 =?us-ascii?Q?8y9c/2x3q2RJ90TqqUHZPhAFBNyJjMiOysYzsugC16I+yh+9W/VZSqIT4hLU?=
 =?us-ascii?Q?v6/LXZqTgdhMJ5kUqNb4NBSFX2LTIVDq8+IHQFhOi3GZQvq7RKrZkhZYBJz0?=
 =?us-ascii?Q?QzW2YUdRKoOi1GloAntYtkj1wvLMFMK4QjJXMipZ6onCWhHX6/ONOYXKjTyJ?=
 =?us-ascii?Q?GSVFQ8uV1ionM61qnwMUUK6k+isdD0eDxhYnF8yd7dxcXvlXoIaP3FoDIPIA?=
 =?us-ascii?Q?t+60RG1C63O65zQHMj3H8RIOWP7QzOnS2OREEKng8tgk8vT3NbTzf/ZM8vov?=
 =?us-ascii?Q?b5wGRWMKnaR7ji1DXz6je2YdFcmZBpF7iuf5GTTzr7y0EhHKWL0zngAXgTMa?=
 =?us-ascii?Q?0c5ORlqoqqWqoL+n+6UXRfo7GCHE6K3kEZKBdZfs5gvgKxG+fhhUnDCX0v7k?=
 =?us-ascii?Q?LiTSiCk1Yn8Qpl3q5sEVhYZFcp+2k4qjQkgGys9Egl9qyUU9hl8ymUR1J0I8?=
 =?us-ascii?Q?9oj/NNW/qP+z+UaqsdLcgZ21BQL6n8+fliuLclTWmKFCW+H5jO2sXDilTFIU?=
 =?us-ascii?Q?BfNMeFTbQ7j6z0QOhOPujXsQ842ga7WZ0PC7tTi62n1w3pbgDvDe5hT2zdZu?=
 =?us-ascii?Q?Ys5XYfT1meWauAD7KVGkJI6dkuedZqMYEpP/eNremL5144EddJNPF7CPh56C?=
 =?us-ascii?Q?3d7RcOrAOAW1FV/U7C2MV0Urgl9e5eLg1c7MY7lmYmt6dgSBC9PaiichxMzd?=
 =?us-ascii?Q?crn2NnlogsLcFRk31kfcUf9yWVaJIXon03ZA9WjSUuDnJrVhxt3wU+8lh5pL?=
 =?us-ascii?Q?uHgNPi4A50VqJZTf79nIQNjRD6CSOACEvQwqG+DNI5GxHkpVPJgpcDJFFGM9?=
 =?us-ascii?Q?C7+OTVP1B3YrDFye7FcK/e4z8gER6auaYQ8cyrfe08goriTc3NOMffhw0Cu8?=
 =?us-ascii?Q?lc7cb+nuUlrOMBWSgKbiBOJEsR3wKg0fWLEm4V+WwxC6RJZ/Q234dXLcN1wO?=
 =?us-ascii?Q?hZ81QhjUhbal3QSBKDruxt+zgJ/WedRaSYZTFAJGIr83hWAz2ce+ZmQLUmUt?=
 =?us-ascii?Q?9x5r3EHSdOLIUTXgfbf0pX6ysIhcLfIv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 11:38:54.0367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e614ebba-ce76-46b8-22f0-08dcbd1ed774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
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

From: Trigger Huang <Trigger.Huang@amd.com>

Add new separate parameter to control GPU coredump procedure. This can
be used to decouple the coredump procedure from gpu recovery procedure

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 937de21a7142..4dd465ad14af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -201,6 +201,7 @@ extern uint amdgpu_force_long_training;
 extern int amdgpu_lbpw;
 extern int amdgpu_compute_multipipe;
 extern int amdgpu_gpu_recovery;
+extern int amdgpu_gpu_coredump;
 extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern int amdgpu_smu_pptable_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b2..c5d357420236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -178,6 +178,7 @@ uint amdgpu_force_long_training;
 int amdgpu_lbpw = -1;
 int amdgpu_compute_multipipe = -1;
 int amdgpu_gpu_recovery = -1; /* auto */
+int amdgpu_gpu_coredump;
 int amdgpu_emu_mode;
 uint amdgpu_smu_memory_pool_size;
 int amdgpu_smu_pptable_id = -1;
@@ -556,6 +557,13 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
 MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
 
+/**
+ * DOC: gpu_coredump (int)
+ * Set to enable GPU coredump mechanism (1 = enable, 0 = disable). The default is 0
+ */
+MODULE_PARM_DESC(gpu_coredump, "Enable GPU coredump mechanism, (1 = enable, 0 = disable (default))");
+module_param_named(gpu_coredump, amdgpu_gpu_coredump, int, 0444);
+
 /**
  * DOC: emu_mode (int)
  * Set value 1 to enable emulation mode. This is only needed when running on an emulator. The default is 0 (disabled).
-- 
2.34.1

