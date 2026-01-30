Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73E9D49C7D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7C510E970;
	Fri, 30 Jan 2026 08:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H24k5XF8";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010048.outbound.protection.outlook.com
 [52.101.193.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB56810E973
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APxgIweR2qGt7N2mWCgu1QqSZpN+asegGAkQ6naqRajxJyE37tIeOForAazO2V+dl21C8obwMhoCLtE99KXfhLee9GWptKkif1sEQMUL6MlPRCwIJkeOWWDxPD7lhvMtWUUjVJHw3LvtYk4M4CCaM9v6N02XchfKDhwCfEyKMP6GLM3Dt+yULqnLVxKIWSnBI+mzfkvGYGL8UY9HDJKhdz+nW3x07bN+p+40nts0P0hTFQMtERNJEMVSXHy1vOIC0n4J4xX9kR12fKejzlCqo6V35tuYsBtECBdNJF0NCsd0g1cAGtwrPmZdQbfj0rzeKILWhPLS1+0AAXZ5fe3suA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1xUrYqj0Y+1YuXj5A1mVEVrU/0c4tB+PKPc6gwiUOo=;
 b=sRsFj1iGa+Vopl09iTLgky3m78t8Sl28VxH74yQP15/pdMoqUkB60Vo0tQSaIJjMjAEcSep1fqpP4nEZfVtqitgrcX0PjU6K+TKjQfkEkGyC+i5fNnncJP8Iz/zPxvryvhSKvrPIbVQZ1woULq9wkIhEVIgU2kBwfRA772fnMz59QSTgFUURKSL82AyWD16Lx+NwAfV7o3XC+yVhJESzIuiikiUAh0nkCFDoPahxH7ENvtIwUK4n7gRNxDTE7qkx7gw1xGtNibZR+jsb/Nsmr4e2rFx66F6B1noQkrfSkZ2zrUvol7+50705+pVPUjxxXYjC6UJ+djbNdHQUPfI6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1xUrYqj0Y+1YuXj5A1mVEVrU/0c4tB+PKPc6gwiUOo=;
 b=H24k5XF8WYqkvIQ3uC9AaEcvUcJQvxqrWRFEEGsnvP+XdJmdXcVJr78cJeQVScb/R6DZgPqyecUJskDiRticc3LSHDKJEJWBTkrDT0SEs1bfNeQ25tyqCVBdEpfPZjYqdcA1OLc/OCPZ+rLKxrkc1+FoUqY2zrwtfC3JoVdt9Sw=
Received: from BY5PR17CA0013.namprd17.prod.outlook.com (2603:10b6:a03:1b8::26)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:42:12 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::c3) by BY5PR17CA0013.outlook.office365.com
 (2603:10b6:a03:1b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:08 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v5 03/11] drm/amdgpu: Fill cwsr save area details
Date: Fri, 30 Jan 2026 14:07:57 +0530
Message-ID: <20260130084137.2906792-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 95babad7-f198-4413-914b-08de5fdb7626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TLYVeHBXYwxldRBW4Vx5SAu/B1X/5/E6OTXCyzZ37QPU7K0v8/eYKKy6jWq6?=
 =?us-ascii?Q?qdbv/HGHNfG4V6ElXrl/JnfcGb/qlKU6jH12qFHOrA2orED7l/KOKkR9ShlX?=
 =?us-ascii?Q?di7dvFwh9lfq1XU1kLlaJysltLKMmmHpJSWYxFk0yzfI1nEsok6xIgNOn2rF?=
 =?us-ascii?Q?5BF/ClMTwmYlhEojyED6sY5fm1Mipu3Ii35eZ/GAhrRDoLbvf8cYfwobnP71?=
 =?us-ascii?Q?SOmkMeWfkSpqU1GTvjMYpfbIPZdMCntjF5RQ5rjWnwXndh1omV/M05KXoXRF?=
 =?us-ascii?Q?Wxhn/BTFfbQdCx5LApMgLkTJ3reVfA7IAZSFrrME5zEuhLxukO0knq5M5VSs?=
 =?us-ascii?Q?mYEK3eISmC+wzj7yobqiM2wV7HRxjyN1EWOKgkhcxveXDTtY73JnZ1uBvoLE?=
 =?us-ascii?Q?gFm/m05FpdGEBGGEITHr/szf9Z7o6NsxA5KKZEeP0b3B6ZUhTDvb3bjzMp0P?=
 =?us-ascii?Q?k8rJ5YKrxRx1E8NSp2hBI4yQ3MHf8HbR+hZ13k1LY/zk15E+6hy+pwruVMkG?=
 =?us-ascii?Q?Oi53BBf5BKm0ibYVZh6j36uAUiAjRkPZEOKmqMznV7JuQI3JDN5mLkkM9OBS?=
 =?us-ascii?Q?D/X8sL6A6EOsMc7xj5YDExAGzPOj6FplefK9xSVz0sYgoDogZYVXHGGj9x5U?=
 =?us-ascii?Q?deS5E5LIquj6jzFjOKmR7SoQ1TfplQKqUWJq6W+nDuJ3ns+HuU59lazETpd8?=
 =?us-ascii?Q?7DdzKUmc7AH2fIeG72cP3NCufyP//TDPEERBjz5K3eDJr1bjTValUY4v/cOS?=
 =?us-ascii?Q?Q05EEuC7e/FAatpUdWAPUlxlVBefVNTS5uNrlJjnElLfeS08ICRxGCeMsXqm?=
 =?us-ascii?Q?UZcAkF4SZojiz1CwW45cvCiseOeiItoNXU8DHyERxmQzCOa644odVUbduF1I?=
 =?us-ascii?Q?DVm20dGg+I18JOj8BHFP7fuN1dPITQ1EZFVnUxT5Dz0nN0N/p+qejjc9vOly?=
 =?us-ascii?Q?Vz5k9vaqEQtg1o7C8zSYT8RRfUhkJnSG8dETAnzvJi+S0aK18/3JQEk5pqWv?=
 =?us-ascii?Q?zTacf82NQq0wLwkU4ugpPlEGbq1EzEa/6b0CPDNgzN/4NWiAUTVdq4OSNUSL?=
 =?us-ascii?Q?iaaW8WiHhmByeoc5o6dvXpZkYhrCFs/Agdi/v7CdHKQ+d+MKcJuMnu0ke+lP?=
 =?us-ascii?Q?fgNczlL82RObsiHEUqJmquz3JmBNOsRWtW7yj+aoGGSZ+D9p27ywEffEkRuy?=
 =?us-ascii?Q?qdzaEOKvJGEfE3l8NhHiyiPkNAG66s4iyxMVR/6sb7WhweXxecmtBqhmmEOL?=
 =?us-ascii?Q?ZhFgKYNfLLK5Ar2Q0/TWL/ZfXxlC55g1/fWnlRO9qc5GfW9AdJQz7uXctHra?=
 =?us-ascii?Q?xeHG1nTKbaZtO6/7R00rquXGiRFuxRkLpHlUYHniWS9HzCf7CZj4wTUq84IZ?=
 =?us-ascii?Q?cb8tmMjpZEQAQGaslR41/2vWWIrdgiiQsMTGO1BulQgpOG/F1w4yRyFx649e?=
 =?us-ascii?Q?bHdV0hy1A4RArC8si9gDEbSTu7CFOL/wmpP3LgATqXQg416Q+xsTsGqmTnX8?=
 =?us-ascii?Q?AhGlLE+PajdRieXxYWk8E79CzdrGCCKR/xLIQ+aJbpNvde4NjAj3KQKPfwcJ?=
 =?us-ascii?Q?DWJs3KO5ozOsY1RPvh4HZ4fS+sDZHfaK8L4PjvjsDvJOA7KY85aiZWWOkRrH?=
 =?us-ascii?Q?1035+rX2eGbBBkhcH1599EK1Lhug2ijktByHLymr5IHxa/xlngf9B1peSmUq?=
 =?us-ascii?Q?QhnMNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GCo+cxFq3owzL4GKtAz6rW8mMTDMRavKbetU4IxSCxNrbS/s0qXeTkKeaMi+fx2STo4OLKGcFI/o5/cjiRvYxZkwEKosJr2U0W7Y7VjEIadpHR+IhjYO+xU8NV/jHfySFNyfAQv6EPwJuS8Lcw/D8dQOdfz9rVhAekWEYpmr4ZiD4Gxz9HUgUeF0NDJ3dGl2xHB5QTYwyo208NQlQqMunW90TsDqX9aKC1ijEFY/cSkARvvuJ78IxAOvIzpxZsQk3brWZMA76zMFwUz3E4I3vTCNlfbzQyRSB99K0HkaCllxocoZm4YMcFIhhBs8+F6T9BVqehS8NgkWqKluD7lzXL0lGNqhpMYZlwevBQ9xk6WJSmWeyHMCcV6diQjFRYjgpDQa/yRoq6YEHgpCzcxUo3dWrPtD3W9rPWbqdUGm7MatgFhrP7VacwDw8gfznVab
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:11.7070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95babad7-f198-4413-914b-08de5fdb7626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
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

