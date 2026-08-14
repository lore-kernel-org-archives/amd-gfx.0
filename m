Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9FFC5DF77
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF02010F737;
	Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bBFEoZuN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B60D10F71E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3HP2PUqB9mbXdF1AfIFMKCm+xvhvdIvcfDNqMZ/Oa/qvLn1UFolwqRwoo/FvY8Q8WDSzNCqHuLT5GjKiwfz5Il2bV43/ssCGXf3StnGX0Jw+bWV2+/0igJyd1Dp6bcFuljgwvGfJ2jUK3wlVsIQCS9s4xHGeeybvE0LtVlot6nKOduFNWJuFfMcUVEonQyXMsnoaw+oYPpheQ+NHEMVzjZPqdXtD3Ckxlt8LTCRpKsh5hMbh1qNJJpKbXtSCc7osrWUBLyjuLjDua38MuEmvhQvltocsrCIL+9GVjlvfqQcQZc3h5c/DjDkmoYZtnorNLORMYxARuPPWfTgPowzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jJQkE3rOrloTvVua0A2EG530dCx0uDJzTpwktVBkFs=;
 b=kEC35K0UjhVfA1NfxNmX2LwiHmRdMRorVrYQUNpXklzEGRGtdNsnHMoxC/bAonVPdhsoL83qAZksme5UfASGeHBbbzQRBgTl7Zv5j5FshNVctDkF8IY28/ouuth9OPb3GT4CxDJfFIKw0UnE/T/2LBaXe55sm3K47IGCcuXfeRHUsGVPUH0OtGjiMrsKjYU8aBEN2+K1ym0rcmw2B1k9XzHLP/OkUsCbMnvOLLEwvXe7iEqOppRhhU6RxrztwY6pBuLAx0AFvJiOdUpcCSrQXgwvd7qWSNiRS6N/9eycxAq+5Wv5rv+DK6oGaV5+I4HKK5YBpJE4TdynhCv0QsvStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jJQkE3rOrloTvVua0A2EG530dCx0uDJzTpwktVBkFs=;
 b=bBFEoZuNneL+CfH2T0zQu8VZNtQTR9kpx//UO7k0oqvkNhsM/SWSUCdxypkqJSPDofL37Z3RsBH/takieJKL+S5w8jdDB9O8TI0LjTBhTEpWC4narku8/rX3uNDu+v+UAjRXIlwJxMVJMoHkuqpWhi9SarK2F6yWb7XcQm/baCU=
Received: from DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::12) by
 MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Fri, 14 Aug 2026 21:03:39 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:280:cafe::5f) by DSZP220CA0005.outlook.office365.com
 (2603:10b6:5:280::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 061/109] drm/amdgpu: add switch to select firmware loading
 path for RAS RL and TA
Date: Fri, 14 Aug 2026 17:01:58 -0400
Message-ID: <20260814210246.3067612-62-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: d1952666-cb7a-402c-9a15-08defa4783e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|10067099003|11063799006|22082099003|18002099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: o+ImeonfGfzweiCwHuu6ojxiSMODHZM5fvw02FRJB0JSlLwy+q81fS9cVbOrZLyiW/54//TT9jqpbLdvpG3xL+vSxH/XWbnSaHWOq8JTh5B6wDxxvyjhPvIYOkdRnKpqrnzYIQMUc17nFxh4ZSRVlKiJSbW7NvKmaNAVm/GiYLJ5C/yMq36SbbaMXXEwxNjcLzO0/NohqIjbE7iWr07kcupD0swyP6pbnFhna+tkbPZfQj1ZQmFJJ3dhHB8kroe/9CZ8iVhrvrDSzt7IMyKI7oNDEFtf49sBVRwYenkNO3prLqvcKzl2xehopdDunh9akuSwiqPtkJfjFjGetc18dNsn2AgZKN2IVEilizeP84veEtwFZHdROxxsxK3+A6Eij1Hx1Ap7nJ6H0m2a/ZbPMoif7roG/cxzBWyEZc2H1HNKmeyinlGcKli62moiGpSz/26soXGTYhjRbmNDm1I7nW4T8IjJdfca/vOkhMLa069sgCom0G3SE7c0H4pyD4h+CCKwjHNs4VJM3yqhDNpkakFomf2tOY0uU/72xWVjG9RHWe9UBSxOCBxuRWMHvQKuQpfEPSBFFUQa36G6pkAZGuY3HjjRw5bRu1X/N9jzWw5CDVOLQGXLDlGvPBytcHAhN776G0G5ZGdJ2Up0AIu3BSuzKKZWBkg1+6k5UCfF8Ho=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: efaDxC+yWi2xJYeweeLJQ3dOpPc9NxRGY/PpHlfmoe4KjBb8ZDYF3Gy5yJNEaXTIsu7SWz4szR+kTPuvHtWjcTHW8vXV5YqaA4vYydjpO02MGeP/wvJ7gkIRCwd8DUnot/XiGuMQjtA5AVl5Q8o12Wbsq2Pemi1mDrlJOF1wlHWqCrKqWN4YNsT3WnanVyq85dAEnpwHua55xN64rohbRcJ7xTJ2y67CaF1mjIkYukdrVkZVjUV6ghNGnmb44nm9UAbTyzjRZoCNV4D6XJkDDU2VloYdGPY39+kQn6K5Z7oEE8Oi0l9HF3WpGCVxl5CFcg8/XAdha1VEx+ZuSvsJctWfnAPT13+hp1Euyc1aUi6b2eKZS1EdD/NqiTtVRhF1uFP57ruv9A/V4S1y8JGqN2h9bsS3ADexfKNsCQOlZBgkw/etFFpZUn0y1ogax7Rf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:39.5535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1952666-cb7a-402c-9a15-08defa4783e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Introduce a toggle to control whether RAS RL and TA firmware are loaded
through the legacy path or the RAS module.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c          | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h          |  2 ++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c |  6 +++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d5998497b22e0..55d293a2ee381 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1175,6 +1175,7 @@ static int psp_boot_config_set(struct amdgpu_device *adev, uint32_t boot_cfg)
 
 static int psp_rl_load(struct amdgpu_device *adev)
 {
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int ret;
 	struct psp_context *psp = &adev->psp;
 	struct psp_gfx_cmd_resp *cmd;
@@ -1182,6 +1183,9 @@ static int psp_rl_load(struct amdgpu_device *adev)
 	if (!is_psp_fw_valid(psp->rl))
 		return 0;
 
+	if (con && con->uniras_load_ras_fw)
+		return 0;
+
 	cmd = acquire_psp_cmd_buf(psp);
 
 	ret = psp_copy_fw(psp, psp->rl.start_addr, psp->rl.size_bytes);
@@ -2327,9 +2331,13 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable)
 {
+	struct amdgpu_ras *con = amdgpu_ras_get_context(psp->adev);
 	enum ras_command cmd_id;
 	int ret;
 
+	if (con && con->uniras_load_ras_fw)
+		return 0;
+
 	if (!psp->ras_context.context.initialized || !info)
 		return -EINVAL;
 
@@ -2369,6 +2377,7 @@ int psp_ras_initialize(struct psp_context *psp)
 	int ret;
 	uint32_t boot_cfg = 0xFF;
 	struct amdgpu_device *adev = psp->adev;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ta_ras_shared_memory *ras_cmd;
 
 	/*
@@ -2436,6 +2445,9 @@ int psp_ras_initialize(struct psp_context *psp)
 		}
 	}
 
+	if (con && con->uniras_load_ras_fw)
+		return 0;
+
 	psp->ras_context.context.mem_context.shared_mem_size = PSP_RAS_SHARED_MEM_SIZE;
 	psp->ras_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 63ea7d39b84e1..84799c39ef81c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -572,6 +572,8 @@ struct amdgpu_ras {
 
 	/* Disable/Enable uniras switch */
 	bool uniras_enabled;
+	bool uniras_load_ras_fw;
+	const struct ras_smu_drv *ras_smu_drv;
 };
 
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 3797a17385b44..34b4b3345259a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -188,9 +188,10 @@ static int amdgpu_ras_mgr_get_ras_psp_system_status(struct ras_core_context *ras
 			struct ras_psp_sys_status *status)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	status->psp_cmd_mutex = &adev->psp.mutex;
-	status->uniras_load_fw = false;
+	status->uniras_load_fw = con ? con->uniras_load_ras_fw : false;
 
 	status->use_dedicated_memory = !status->uniras_load_fw;
 
@@ -310,6 +311,9 @@ int amdgpu_ras_mgr_sw_init(struct amdgpu_device *adev)
 	else
 		return 0;
 
+	/* Enable uniras to load RL firmware and TA firmware */
+	con->uniras_load_ras_fw = true;
+
 	ras_mgr = kzalloc_obj(*ras_mgr);
 	if (!ras_mgr)
 		return -EINVAL;
-- 
2.55.0

