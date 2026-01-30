Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14972D49C7D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37CE10E98D;
	Fri, 30 Jan 2026 08:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MKm2QwE1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27E710E97F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssjkThZ/89XZ6d7YDd64ZYwiJfZ1mrq5hO2Uwwcwovt+OuUN2eLN14hpc9h+l9fYqMD9ofmkIDYM8xpLkCeMLspt0mOf0HPyicBVSKS57J6M6ZgSnz1EVfas4IKAGkAqL8RXQUmPnSZVlr24KfGpMceg81S6m8hVRJBmJasuRyjnZIbqk/qfrhb01hkZNval1zSukZijsJr+AKKUbOrzGHGxEWqIBjWFJMklzO0dhzihS3C/83DX5VIDBzH0WInuVzkzyhU9tIUWadK4EFrvHOrd2iFwHixBpvokl4eBCCG+R6ZQD8j93haP045+FYx6mg93dm0Xv3A0fFlXpLn39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwTzivQ7LhYZelfZGNPbzJXpXaZUUUyPM96uraWEPQg=;
 b=a33efX9BPMT4KhcxTQqbemMBCBoFgERcKOlysOf8hm0lXTYWLkYKlMa8wBzWutjXgNPGqiwsxuKpwHiNuPbZ9CNLFzLwroSLYwv/x1OUw31dXagYePwHNFYI4EWbSoMTK3nm5mIluLvD9p17KS0AJqswf5UTJBiwKArX50Pc0n8rpVKzcNXy9cNH8pHGjAc/BIRiH2tNV9ZDee++DFJcikhvLlJ+Khg/r6gxx/jhPLYY5DBDCnq1xZjWZMMstEB95bnjKK/cenBOYapLGb8v3sa5G8INo4hJABYG5BAruxhxCpHHWaVWaftN8OzhS3gy/M6TG3XryHiKZazKpIftzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwTzivQ7LhYZelfZGNPbzJXpXaZUUUyPM96uraWEPQg=;
 b=MKm2QwE1WdV8rlSGQrfYbu+IG9hZUpzVt0+FPZ9lG+vnaGUr3m6aLawsMo6qVsHKJN3xCY9/Nly40NF2Loje4peHwaUNR+VHMOCfE6lNS3IvukL3J+/4EJ7hRnZybs3DLD9ldzV7+6MDGilScHNiJLhx0dNL9GMR8sv3gip0EGY=
Received: from BYAPR02CA0007.namprd02.prod.outlook.com (2603:10b6:a02:ee::20)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 08:42:23 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::27) by BYAPR02CA0007.outlook.office365.com
 (2603:10b6:a02:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:19 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v5 07/11] drm/amdgpu: Add user save area params to mqd input
Date: Fri, 30 Jan 2026 14:08:01 +0530
Message-ID: <20260130084137.2906792-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0d4801-72e1-46b8-b4a8-08de5fdb7cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c9XKMZUMUvAsV9gLldJdbqeXBp8fvByKKVeW8saSmCicqyk5bH1ZU7HsgWY3?=
 =?us-ascii?Q?EAaf96UX6eQFx1aFHXicDt7FGXgWpCc8hWihseH9MGHZClF+Oy+XoAVyPp3G?=
 =?us-ascii?Q?WrPsfceHfXNBe+OyCU4+TmGc86m4QC6SknAPYmWiBi1xzfxAtT725+sJvpa9?=
 =?us-ascii?Q?5YiVyvkmmGqjdSZC96KqoDNrY1+pS1uWfVnhOj2v1ovAHn5vEOaQjFLKk4ai?=
 =?us-ascii?Q?1y1M0jUJfJzlYQmGL2ZOiY23d9HQyqPkyB97u8RcFXwNXPIL2OJ/XGA9qUYo?=
 =?us-ascii?Q?up6spCqpZ3032MsJZjQkhKJXEYXh/CmJn+PBQ48VzgUT5nEzNMgY4QsfQ1n8?=
 =?us-ascii?Q?Is7vqRB3n3CxuQ6tmsz7y8m+S82Wi3EdoOB0KFuAMWaCKCOIZv5okjIgkjdL?=
 =?us-ascii?Q?KS9PQE+CcMj4CCUu7PQXcm/OjJyVe29wImN8W65uXYcsBsqunuIaWanHrHNi?=
 =?us-ascii?Q?RH9YEDI7pkRt3Guxj4p3i/0t1P4Jax2uT7mPU/zeAg3MY2aCDbi302PRq/lY?=
 =?us-ascii?Q?pct0XDOPUp7pWr5UnbzQLfYF1tDuz+c745K+sAEY2qAx3MhzPdk/BUZ0rbLe?=
 =?us-ascii?Q?QT7JxDYKVVVCV3tFSfbtq48faxv7J/4pcq6aYWDVpX/tAydUl9WxcFVhneUR?=
 =?us-ascii?Q?ihjQTlEfSA5N/8+C8TplIXdkQW3xVp3A3veaL0ga/pBsA0ZY90PTME7fOcTB?=
 =?us-ascii?Q?e6DdjzlXea+ZZSWgd1aFzoB9DgxGCEjCsB+WQYslH+Mp1WehImyQbBrAVjOH?=
 =?us-ascii?Q?EfJad6nBZVhZv/LygvvdNv0blAp7/DL10efOLYYGnIe7qje7iod4JN8ZHqh1?=
 =?us-ascii?Q?bszRAvTCs0tjHVS9OONkGZwAKAsvaE/m19aFzFMBUrZVYI6RzVZRf2Db/GG/?=
 =?us-ascii?Q?NbPJ6gxSmiUuxr1yamxcJ6GnOGYymHVfVuONsODW1HIpwfmpr1g2kdribD1Z?=
 =?us-ascii?Q?3k+bY6HSixHBQGDLT50xqLNffOSx6S9Id0TB/jmJNwTJCfJnEEmJbb97ImvW?=
 =?us-ascii?Q?MmhuPEVnTiO3SMviWn641uxaaksQiN2DdLbxhmuwfSGRwakf+9Szl63LEkTp?=
 =?us-ascii?Q?br7t1niOMhz1eo7v9Z/zlSJGakcXl4yEO+SmX9Ftzv7Br7UTAd/G900T1hac?=
 =?us-ascii?Q?cChPTnauEkSUA8azIgqviXGu//EmJ6FqfyCBE7MYLk0dUNiuAJOTdief220m?=
 =?us-ascii?Q?3A3NJpTFns//XGaTsrdI+LgcEkBo1YtTwPcWQKm7oawV4z0uIZeeq0UyvSg7?=
 =?us-ascii?Q?PS4cigQuYWQrZJ1M7q6yTcV6tT4J6yIpu2qlbn3W5kPrBavMbGFb9e1pQszS?=
 =?us-ascii?Q?KBIvfWnf616ER0fpmQ3/2ENG8s5kcmoG64WtU7WaYpGcZnv72rRiptzotwnx?=
 =?us-ascii?Q?GC7GYzEL0ilqNinAtxSWs+jxqy2Bx/R+a2VDntKhMICnH0D6VXAj5OZ+/U5A?=
 =?us-ascii?Q?uagbmarugEOCnBisolOunlI9hLKU9dvSbzmOo82qONpmCRc84bKit5Z7JWLK?=
 =?us-ascii?Q?MdCuvUtsK43TzFuJVAqUzWRkCA+pFRNyVyuZtKcLwyOcRhzKkEbLlkPBhC2L?=
 =?us-ascii?Q?XAhPUAPIyFqrj+kJ9lNBXaDYtSob5u40KSWCx8ubhYRFAZsKoXFuB7pYI39y?=
 =?us-ascii?Q?A45EU+mN8kFlzvoaE9i+9hzE3u1Z1j5WpWnk8WuBJVrm9hlxrDWHBYbaAjVN?=
 =?us-ascii?Q?tfWi/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HUSQt9mtrM5Ksi1Aqi2WCYXIHqw1UfAVaVgibn/hedtU38X9gJqUp7UAdcp82kCevCEjml+/gMOu+2XipY+S9GjF7Xu1fX6JBzgnNrrfTOOkQw7o9FqEMhs/x+rDsOBDC865ME3bYqdKaEUj4vhpfShfTjOB7EkRQDxNPhZIFxKVq6wZufGQgpj1OIlliep/LAopjqpz8yDNqT8T0azPWLbu+LzHeuoPbNEgqHzPM17xGCODM07DF8dFcm0YqZvnkwjMNZrRgw/F8wdbwnA8PrAqoG3HFX7ulzb67t8SqH4+W+H3UCSua316jG1jbyaGh0j/+8+/8QSk3X6nYYbp2jqDloHa3yFtekvCg01wzpil4gSY45ZrzUXNGwAHUhCiFB6B0gHuA33k+FyPIdGh1LWuvvLXIjDB6MHuTxZANziB8aGCEHFIFnuSeGwrMcSo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:22.7288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0d4801-72e1-46b8-b4a8-08de5fdb7cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462
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

Add user save area parameters to mqd properties for queue creation.
Validate the parameters before using for mqd initialization.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 14 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 23 +++++++++++++++++++++
 5 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 218d8030a07c..26b757c95579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -814,6 +814,10 @@ struct amdgpu_mqd_prop {
 	uint64_t fence_address;
 	bool tmz_queue;
 	bool kernel_queue;
+	/* cwsr params*/
+	uint64_t ctx_save_area_addr;
+	uint32_t ctx_save_area_size;
+	uint32_t ctl_stack_size;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 37a526a1085f..119b84a0703e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_cwsr.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -265,6 +266,29 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	return r;
 }
 
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	uint32_t cwsr_size;
+	int num_xcc;
+	int r;
+
+	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
+					num_xcc);
+	if (r)
+		return r;
+	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
+	if (!cwsr_size)
+		return -EOPNOTSUPP;
+
+	return amdgpu_userq_input_va_validate(
+		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size);
+}
+
 static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 5845d8959034..a64292bc24dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,6 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
+struct amdgpu_cwsr_params;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -157,4 +158,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 				       struct amdgpu_bo_va_mapping *mapping,
 				       uint64_t saddr);
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 40660b05f979..5f6a6f630495 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3243,6 +3243,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
 
+	/* If non-zero, assume cwsr is enabled */
+	if (prop->ctx_save_area_addr) {
+		mqd->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		mqd->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
+		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
+		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 27917614b1a8..71a323ad1ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -314,6 +314,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_cwsr_params cwsr_params;
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -339,6 +340,28 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_cwsr_is_enabled(adev)) {
+			struct amdgpu_fpriv *fpriv =
+				uq_mgr_to_fpriv(queue->userq_mgr);
+			int num_xcc;
+
+			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
+							 fpriv->xcp_id);
+			cwsr_params.ctx_save_area_address =
+				userq_props->ctx_save_area_addr;
+			cwsr_params.cwsr_sz = userq_props->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+
+			r = amdgpu_userq_input_cwsr_params_validate(
+				queue, &cwsr_params);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+		}
+
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
-- 
2.49.0

