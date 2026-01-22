Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8676C44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6F810E1EE;
	Thu, 22 Jan 2026 10:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SNMgZiP6";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8672610E972
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqGmGQi8G3lQL37EsQt6+g+1SWS1+Q2tNWw8qphElqNWNn9l0Rsu8pzUjJvT2nQ5+op0+bGMEB2QQxAouKF4PAZ37yih9I199t08dOip+563h8MwbTLUa0Fp3cwU8j4bfqF78ucQyknfjPtT7B0p0Wjqw/AMVxXaolrWuVR+apPOuy80y0wYYrinyykzI00fHj2hF5w01em7BP0S45+hLM8qYjGv6hN7+358bisnQnEhW0++tGmnTxd4x7AleLnSMlbctXcuumLE8nOcWBM0iUFucCiLTm5janl0fWNQTfnKZK4BtSgCA/7DBCjic96yOHr9+xu03IFMUbi+Ln4o9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1xUrYqj0Y+1YuXj5A1mVEVrU/0c4tB+PKPc6gwiUOo=;
 b=rpedIs2/Pyt/E1FDbTqVLWonLig+v/G5ykeys05dWzQmm1Ayd/pk5swFxjRi9E5U6txqVyImKJhO4w9XBpNaO7nxEbZZ+sy5Sw6nYYJZu0RAvq8COgKMWqRHjMHKAtiroM075j+qAQ3PiXJgRs+hswxbZao5Vqyt5mZD4NGXl83+QpXWRoI5hp5icQ4ZFK8EkamDoJJRG1XwQUQKAR6Hl4wrV0UXMvmqGLxs02ChO3i+RXLEui5y+BULL2Uqj/74cxfYwX38SJEC+z8kR4J9Mppuo9ay8QypfMfaKaMFGIb8EVkwSm43Aon7PCij2AzgvCXGfP1qtqRRx87K7UnczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1xUrYqj0Y+1YuXj5A1mVEVrU/0c4tB+PKPc6gwiUOo=;
 b=SNMgZiP6dPig1fzpANi38OLuXQOw/Wu9UDHG3iTzimPnL7g5tUEsxM6+42hUKjmDH9R2mX1c/VEb4ZNZ5u9Bwn9wQUR1zNT9gxPKb1dl8BbhNyzUzdcDv7q64tMb24s6foookKOzYgx8cs0Q/nwxNvnfA/NTkqmogPAtxN79Fp8=
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:41:49 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::2d) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:41:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:46 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v4 03/11] drm/amdgpu: Fill cwsr save area details
Date: Thu, 22 Jan 2026 16:09:52 +0530
Message-ID: <20260122104118.1682154-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ed5520-4168-4ed7-41cd-08de59a2d885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+BGyX0XojCI64fSJbhz4xGaN7SWApHBJXSM8Hu1Olq5nLKlqJKRwT2RuJKPC?=
 =?us-ascii?Q?NZ1mpZdeUFOB/Ilig61i+6ryIPPxTzVoGkx04SJz3H89ksAOUG6YFvDre9dz?=
 =?us-ascii?Q?GXs4tRZrNRju9LBN8Lr6Ua/aVvBRVXIVdBgtdSZvu4mA+oh0Iww5KE2Tdyi6?=
 =?us-ascii?Q?MWmqRbp2mm1MDeWNdc6Np/v3mProrvUp9Cwf0ZR10X9keQQuOvBDE/dFPC8m?=
 =?us-ascii?Q?fMX0p7TroPvcdHs8d7ceM8TCPwOrdX2PYDjA7Dh9w+WUm/jS5UrbWtRACdnb?=
 =?us-ascii?Q?u3Vb9xmX5Sf6qiEU72vZgxJvf/CuxyamnK/3plFzBt63PSbkllXXc6ox7f/g?=
 =?us-ascii?Q?AUK0NmnLUmmFjmA6lEb3pyoxTuhIkmgoHzYCYRelnvpNAmlFBDy0I4jaPtL/?=
 =?us-ascii?Q?zfZJfqqdH6lzzp7ggfSuk8pz2M1D54DKqIk+rqejraG78GjoRvPO+O5LAHK5?=
 =?us-ascii?Q?Xuup6Vts4Ial39/JCh1QPHNGEPqpPN7OhoS/6CzfezL90AVY/Q0vFPBgcD+/?=
 =?us-ascii?Q?vwzjjJmSYyJLjFljaPlfyddpwTKPitGUCafYc4sFm06MiJUpw5lnQgtCCLX5?=
 =?us-ascii?Q?R2RnYzvRkZmL/NWE3lK1cKwV4pFJbyKUKjUFSvwloO6ulQ7Go4mgcxpAK+dq?=
 =?us-ascii?Q?WwzXsu0g1gYpDJVN7vhN8+THe6ug97l5XO4uFbELhJ510aIQ5YkkWulEF2vP?=
 =?us-ascii?Q?SzPIb06WKy7J7P00X84rMvqqgSCJqnXGnsO5WSTkH2aVD2EF3/JnHY9ykTGG?=
 =?us-ascii?Q?VH9wmZ9ZNOAdTmJWCpSeLdHvk52BpTr/6sGMZJjw0W9+LW4xAD2hcsb8Ua3k?=
 =?us-ascii?Q?n/5x714jbSbd8KlduAGjFmQMOUKrANqOQ3e03oM4y821Wx2Qb3S850JNOhTH?=
 =?us-ascii?Q?i4HHzqXGSnLW1hTiFDzXfkf+Ee3ep46JWHzZm46Ed1KXIceD4vUJY6rJyomq?=
 =?us-ascii?Q?XIi5Z7J7NgBNwwE6A7/GMR3Lvy79idfTKacjRdwoX+ZHQQqc2ibHvjmIS4Qg?=
 =?us-ascii?Q?V96r54bP40zEpCiDJSOiIc/qwzoQZJSuHE3WP21iGo9QqlshEtC3YyYMZIdn?=
 =?us-ascii?Q?wOtTiW48kkq52fspo5gouycUsxdAUXDLtX/FNQPftqyOd5sWNepVZJgfXThd?=
 =?us-ascii?Q?hGCLlqN8+Ub57GYiEa4236YEoU3193k+AXPRQBcHtnqM3zKt1hO0NeKsC8RP?=
 =?us-ascii?Q?7eEY3EIIem073jrSVW80GMJW7tWZFFYb8bg6y26TvkXTJUdcNDJn0B+UK/T1?=
 =?us-ascii?Q?OglP6dqcyh0weA2R64B0ud3gKpe4+qG6HfZkayXSqxmiHHwpU7gwQDn2k2w0?=
 =?us-ascii?Q?aE/z++F0jAUZtNvMj8f/6FfzzHTcBacvrQfGy1Ox9HY8hISt4eCHvN/7/dSo?=
 =?us-ascii?Q?JUOkpRGMGANxGJFUr3kIiEfbPfmmwvR33XWzzXRgbaWvFKRSwXYT3itxruJf?=
 =?us-ascii?Q?jNsQpG1cgajZhAJaGRy3xrZa45q+WKruh14++MeFMOgfANL+ZhOuTB+6qCTl?=
 =?us-ascii?Q?BbVnNj0DDSPPKaCZXGFh3aZH0STfSvMgrNW9+YTkb7dznj1zYtbaKtcnCRf5?=
 =?us-ascii?Q?SCsa/LNX6L3jPiM77cRn3o1qULbvKC2YaFj+tVzD8lKnt0/UomHVtuoL96W8?=
 =?us-ascii?Q?cPOBWLbrztPwyl1EJR3OJ+cg9nC3+5ahvsp2qkTuhpZFu4sqIMGuH+wobx2J?=
 =?us-ascii?Q?+3zCHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:41:48.4212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ed5520-4168-4ed7-41cd-08de59a2d885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706
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

Calculate control stack and total save area size required.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 104 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |   4 +
 2 files changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index f2d3837366bf..80020fd33ce6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -32,6 +32,13 @@ extern int cwsr_enable;
 #define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
 #define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
 
+#define SGPR_SIZE_PER_CU 0x4000
+#define LDS_SIZE_PER_CU 0x10000
+#define HWREG_SIZE_PER_CU 0x1000
+#define DEBUGGER_BYTES_ALIGN 64
+#define DEBUGGER_BYTES_PER_WAVE 32
+#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
+
 enum amdgpu_cwsr_region {
 	AMDGPU_CWSR_TBA,
 	AMDGPU_CWSR_TMA,
@@ -121,6 +128,101 @@ static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
 	}
 }
 
+static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	uint32_t vgpr_size;
+
+	switch (gc_ver) {
+	case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
+	case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
+	case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
+	case IP_VERSION(9, 5, 0):
+		vgpr_size = 0x80000;
+		break;
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		vgpr_size = 0x60000;
+		break;
+	default:
+		vgpr_size = 0x40000;
+		break;
+	}
+
+	return vgpr_size;
+}
+
+static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device *adev)
+{
+	uint32_t lds_sz_per_cu;
+
+	lds_sz_per_cu =
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) ?
+			(adev->gfx.cu_info.lds_size << 10) :
+			LDS_SIZE_PER_CU;
+
+	return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU +
+	       lds_sz_per_cu + HWREG_SIZE_PER_CU;
+}
+
+static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_device *adev)
+{
+	uint32_t sz;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 1, 0))
+		sz = 12;
+	else
+		sz = 8;
+	return sz;
+}
+
+static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
+					    struct amdgpu_cwsr_info *cwsr_info)
+{
+	struct amdgpu_gfx_config *gfx_info = &adev->gfx.config;
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	uint32_t ctl_stack_size, wg_data_size, dbg_mem_size;
+	uint32_t array_count;
+	uint32_t wave_num;
+	uint32_t cu_num;
+
+	if (gc_ver < IP_VERSION(9, 0, 1))
+		return;
+
+	array_count = gfx_info->max_shader_engines * gfx_info->max_sh_per_se;
+
+	cu_num = adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask);
+	wave_num = (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAVI10 */
+			   min(cu_num * 40,
+			       array_count / gfx_info->max_sh_per_se * 512) :
+			   cu_num * 32;
+
+	wg_data_size = ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_cu(adev),
+			     PAGE_SIZE);
+	ctl_stack_size =
+		wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8;
+	ctl_stack_size =
+		ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
+		      PAGE_SIZE);
+	dbg_mem_size =
+		ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
+	/*
+	* HW design limits control stack size to 0x7000.
+	* This is insufficient for theoretical PM4 cases
+	* but sufficient for AQL, limited by SPI events.
+	*/
+	if (IP_VERSION_MAJ(gc_ver) == 10)
+		ctl_stack_size = min(ctl_stack_size, 0x7000);
+
+	cwsr_info->xcc_ctl_stack_sz = ctl_stack_size;
+	cwsr_info->xcc_cwsr_sz = ctl_stack_size + wg_data_size;
+	cwsr_info->xcc_dbg_mem_sz = dbg_mem_size;
+}
+
 int amdgpu_cwsr_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_cwsr_info *cwsr_info __free(kfree) =
@@ -145,6 +247,8 @@ int amdgpu_cwsr_init(struct amdgpu_device *adev)
 		return r;
 
 	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
+
+	amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
 	adev->cwsr_info = no_free_ptr(cwsr_info);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 26ed9308f70b..3c80d057bbed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -50,6 +50,10 @@ struct amdgpu_cwsr_info {
 	struct amdgpu_bo *isa_bo;
 	const void *isa_buf;
 	uint32_t isa_sz;
+	/* cwsr size info per XCC*/
+	uint32_t xcc_ctl_stack_sz;
+	uint32_t xcc_dbg_mem_sz;
+	uint32_t xcc_cwsr_sz;
 };
 
 int amdgpu_cwsr_init(struct amdgpu_device *adev);
-- 
2.49.0

