Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC61E77187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 10:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FAC210EB4F;
	Wed, 18 Dec 2024 10:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSKGC+tP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55BD510EB4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 10:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDvp5CMbM1qLHgAZhw8nXeIoLEBjdJN0mMPUFPCMKy7VwVODt9/RAerMMY518bSFb7JpMxNiQ/BcrxlD5aA9yDOm3azMAXERogXkTd/ycoPB1BqRLYcIxZbaVSZE12KJSVRGLJAskUcPXwxivnYuFySvNRMYZ70JrJmiSZQKyj8USwPMPg7ZCpXGrt52W+FjgGk2EbYteO6Y1eAHE13MfYqeNU3ZGdLi6DzqwlqV16MV7o+lSX1yrFJwln+mkc6r8DhjLFkRlp6SAhWPPvdh5GaMfWGxZ7nJA6eV98SHk2NbIfg7CMUZeYzw6cwGy9+rPUTUrlFkT4OtPzRQRrAe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPCeWhPAgFvpoWfys8O+7rjH/OVQKpXsYE3/MoTmMPk=;
 b=bGa048osOm8OAuqVa6VguyLO7gzSZZP4J95sRPVGTFab9r09m2Zlc7VWSrv2NSbl0WssO3NiFLbOoi+LHF/FRWDAYmD8+Bmo/cRYxTCWxJPqncDWJ/aKwRthX+xa8F0O+4DY+EUQcFl5lRhNBh24ioAuZFqHDKGtu09sQCrOclUvOkGKg/M6RMLjtY/+1PdkLolCzIxic9EToSQtoYgAKErB1kuN+cwtN4Ek2IICbzg+ohrJCpV+hI9i7pWrEsxywNckJR1++NIu7tosw7T34ii5mm22ByFXXqgr6FKcv6/ZD9cxMINIHOM5JEtZ2sqNruhb6kGry912silndw7+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPCeWhPAgFvpoWfys8O+7rjH/OVQKpXsYE3/MoTmMPk=;
 b=LSKGC+tPGiy9lPe0+S33fCbkxbQASsswFMrxbIEGad48uzyHdQOo0zZ2z/A86kPxGcLMs/JBjVswgYmgaK4nef4U62BlT51/NRWth7XABkuKkHxOhHr94QUNPlEQJ5sQ36Y1g21haBahbzqF4/Yr+nPAlGvkDqsnhrWzO8wyeQE=
Received: from BYAPR21CA0002.namprd21.prod.outlook.com (2603:10b6:a03:114::12)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 10:25:44 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::7d) by BYAPR21CA0002.outlook.office365.com
 (2603:10b6:a03:114::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.7 via Frontend Transport; Wed,
 18 Dec 2024 10:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 10:25:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 04:25:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 04:25:43 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 18 Dec 2024 04:25:41 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: fixed page fault when enable MES shader debugger
Date: Wed, 18 Dec 2024 18:25:41 +0800
Message-ID: <20241218102541.812627-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: bf18d1f0-2c4e-4d81-21ac-08dd1f4e54d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NbgEEg1vo8hhGIA9ign5CbNU8dGK9DiMgN+L3pCPgaH1IK5txUvYo1uYxd4L?=
 =?us-ascii?Q?ontyAWdAEXC8C6ROscp6O4CLk9Ab63+V2CAaWDVKA8PEHRGa0/hBt+3ipBth?=
 =?us-ascii?Q?KHNoQmDBhbHaEsTmblEllLtATBYibbtcpWdf+pOFH/X+N0jbboznjCQKx3u7?=
 =?us-ascii?Q?wGjDfa8yBfYc7NIDKH9u78ANcw6mCh25dQd8dSi/g45tmu816kcI+XgEeHHQ?=
 =?us-ascii?Q?rYspndjR7Ivoov+zx5N93Jm3iAJXrcYHcP+f5r98wX0G2peOvjRWet6ak0+O?=
 =?us-ascii?Q?r8PjIjEwAGBEmzpaD6M4Iq2q4WwAGs3Ce/vqFDdi2FraspRE0YicUTPF2/70?=
 =?us-ascii?Q?BR6Ut+0Mc7oYl/xEPETqX3sESSe3MIbrQuJ9smdh33g4PJGPQBMbuBHH1Quf?=
 =?us-ascii?Q?HFqdaus1YKYWmXxoJ5sDUyx9af8zUVveaCRZ45Jwsrcm8ABKHdahyj/9ZmHA?=
 =?us-ascii?Q?g3wzGc4WXz3iN3wSV/9ABN82RVSPfufFqhsKVyhxu3QiKDR73ApkuQ8Iged+?=
 =?us-ascii?Q?6YRDJcSdVxGZMc2Bc9uts6cP2tEV1mFSfZrD9ySLQJiOqujwvPebHmURIjyt?=
 =?us-ascii?Q?XbBgbksREuuvOB+o24nbP0OZxj3uW0Z36+cXE8g9oLryKfqtP7LD+n5HEBVc?=
 =?us-ascii?Q?hpZwmcI0Odw2HXICyj+4AKa8fNjjv/VbMIBjQYP1mXHeWwtO9msXdggpa61q?=
 =?us-ascii?Q?2U8hIWksuxghZ5LJdqEVnm018yhxtKDzF37SQWMerZRCDzKKYUrwYM1P5Lb3?=
 =?us-ascii?Q?UGohw8uN/shZuDpf+NN7g1Jmw38AtyageTfjTazV3GgXItQG0Vq1efha7NCg?=
 =?us-ascii?Q?FGwOLDdxeqc2fdxxarKILPoiY1TaAXQ4Urjrsfhoy9zqL0QMoKTVL6VfHefq?=
 =?us-ascii?Q?Hpzwph6YGJ1ynbDO6u+M/0fLpufHdpYS5WouHKdoRNxKymFEOZAkuvsB3OeI?=
 =?us-ascii?Q?nl3QolncDibBvHn6JMWOS5rh1oW4tAiNpVnz+Hnxie7G/Tb01fJm6YLlToKC?=
 =?us-ascii?Q?OzTfbEKgmv7wM4A95GxBiZE/R2YFe5Lpc8Z0FVk02D7kU9QntjuUmzXxyvSV?=
 =?us-ascii?Q?DjvgFTjPLj3p4sYYlOdkcCFTDUK//oC+IkTz96RSWNwdSoSCYGVvq2nzu91I?=
 =?us-ascii?Q?pHKzBFkcHngNLPj+T0MHC/QEnwLoipgxUg6y4oEsUTZ52gr8Trl4xyZo018n?=
 =?us-ascii?Q?dRU2kkitJUahI+X6GYO2YvXUEYuK1k1oGDQgh6sLSvsbN4A8cFU43OXKctlm?=
 =?us-ascii?Q?8KlwOyPo7bmFjGTsV2yJ4NwcsKSgXoJDapfqcFYoE/hYWfS2g5jRRukyB+JT?=
 =?us-ascii?Q?IWfanWgOv4BPlpyhZrJyoVhzMusIyIe7eE8a4Gb/Epj993Ox2xIxTdVAOxPF?=
 =?us-ascii?Q?WiP39tneRwPC+LWKQQv3lz8w2TBW5+fLd7sERxHvo4mCfbMbiHoqI40nWHeX?=
 =?us-ascii?Q?M/lii8iWXHv99qB8WfezZkU8xStjqgJJLNLkRTmvJ/7W8YimeE59jAwGnZM7?=
 =?us-ascii?Q?KkzvIMBzH4aS/4M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 10:25:44.5792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf18d1f0-2c4e-4d81-21ac-08dd1f4e54d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
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

Initialize the process context address before setting the shader debugger.

[  260.781212] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:32 vmid:0 pasid:0)
[  260.781236] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[  260.781255] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00040A40
[  260.781270] amdgpu 0000:03:00.0: amdgpu:      Faulty UTCL2 client ID: CPC (0x5)
[  260.781284] amdgpu 0000:03:00.0: amdgpu:      MORE_FAULTS: 0x0
[  260.781296] amdgpu 0000:03:00.0: amdgpu:      WALKER_ERROR: 0x0
[  260.781308] amdgpu 0000:03:00.0: amdgpu:      PERMISSION_FAULTS: 0x4
[  260.781320] amdgpu 0000:03:00.0: amdgpu:      MAPPING_ERROR: 0x0
[  260.781332] amdgpu 0000:03:00.0: amdgpu:      RW: 0x1
[  260.782017] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:32 vmid:0 pasid:0)
[  260.782039] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[  260.782058] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00040A41
[  260.782073] amdgpu 0000:03:00.0: amdgpu:      Faulty UTCL2 client ID: CPC (0x5)
[  260.782087] amdgpu 0000:03:00.0: amdgpu:      MORE_FAULTS: 0x1
[  260.782098] amdgpu 0000:03:00.0: amdgpu:      WALKER_ERROR: 0x0
[  260.782110] amdgpu 0000:03:00.0: amdgpu:      PERMISSION_FAULTS: 0x4
[  260.782122] amdgpu 0000:03:00.0: amdgpu:      MAPPING_ERROR: 0x0
[  260.782137] amdgpu 0000:03:00.0: amdgpu:      RW: 0x1
[  260.782155] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:32 vmid:0 pasid:0)
[  260.782166] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 312dfa84f29f..a8abc3091801 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -350,10 +350,27 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 {
 	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
 	uint32_t flags = pdd->process->dbg_flags;
+	struct amdgpu_device *adev = pdd->dev->adev;
+	int r;
 
 	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
 		return 0;
 
+	if (!pdd->proc_ctx_cpu_ptr) {
+			r = amdgpu_amdkfd_alloc_gtt_mem(adev,
+				AMDGPU_MES_PROC_CTX_SIZE,
+				&pdd->proc_ctx_bo,
+				&pdd->proc_ctx_gpu_addr,
+				&pdd->proc_ctx_cpu_ptr,
+				false);
+		if (r) {
+			dev_err(adev->dev,
+			"failed to allocate process context bo\n");
+			return r;
+		}
+		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+	}
+
 	return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
 						pdd->watch_points, flags, sq_trap_en);
 }
-- 
2.25.1

