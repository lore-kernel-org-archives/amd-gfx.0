Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEA2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 06:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6C210EE29;
	Mon, 17 Jan 2022 06:33:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC63A10EE29
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 06:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrIaWwCLACBw0F4zBHJlLQe68AoiYieikINyNVind4Ua9RKeanyXvSpVvQcd1786jBYqs0+wBgIci4jUFm9KTaC/9/I5OggbqVQKCVtDyTbsilEoE/K51M7FdQQ7uDV98idmqUrTByLJLasTUsM9c7wfpnsuy3+zcZTrLxgasCBuE2yI/seZqcmhy6Uv0vV5f1RynVVhlpmBZzT/UnXlhNgmeTUN8IHcDuGpMDeJus7Ya6XM2Rudi5W5JmgjvU6/Ain5MglSrAikgwO3/R0q1Ac5JtFhlfnWNVs1LV8gbRRoLWLevuNCSFrWFChMcCp6+nCuQwlOx1vKXWf1IyHv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llN/RACRFusokBaApUJm8dg//BJA8hXgiyg9fxEzG6Y=;
 b=ceQETip93hP5PYWXXURBfylWgnguoT2hAjFt+TwFfXoUH4B7IdZwQI1Y2fR+xWWEl6YyZlbtETVd3PAG9FTFi9UqgCif+tvlQZIYrKtOsIF8lsk2V94Hw9VA/rH53ZoVpg83uGw+O3pbLyzk25UBEOCPhua7T56mRFlPOICIPpFWt6VDb12P53DdHG5axMb6IjLzjb4Myr/z/avOaHDqkfaOEd0OQIOcC1SYFb0ePWgq4ScCpp1ILGReRPGt+0RbxrHM2ynCH8E23DABoSllxOGsVp2aRSCtl9N+mIz1OW+vAYJa6gT5POqgCxGxWbpXV0wj/RwLj0mFC6El7j2tyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llN/RACRFusokBaApUJm8dg//BJA8hXgiyg9fxEzG6Y=;
 b=Y0dvKnyElNQx4jfM0Jum9cOG9gln8KQxwEv4UaWl41IvLfLEgB+yWzrpWWS0EC1j+K3N8ayl3caO0vlcvZWlBz6fE5qjAyvoNLTBG4ymZltZRkOiORYd/9nZz8WPx153ABzG0i3lvQiVA43HulXhpgDBS18x9+JrAvDrAhakHhM=
Received: from DM6PR18CA0004.namprd18.prod.outlook.com (2603:10b6:5:15b::17)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 06:33:20 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::7f) by DM6PR18CA0004.outlook.office365.com
 (2603:10b6:5:15b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 06:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 06:33:19 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 17 Jan 2022 00:33:16 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add reset register trace dump function for
 gfx_v10_0
Date: Mon, 17 Jan 2022 12:02:58 +0530
Message-ID: <20220117063258.27802-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d35d1403-1ed5-4045-35be-08d9d983408a
X-MS-TrafficTypeDiagnostic: CH0PR12MB5314:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53143C00B3F9F6417604A346F8579@CH0PR12MB5314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3h3p3TcJTMzUwPzvKZ42gNxR+UMlWe+oPuenvhI1qCZs5+GCSdZTt0m8lNt+POrevHrBNB74vR3ZLeTS99C7uDHTnegs2204cBtsrQk5O6o9ISA0bx8B+QldjiOySpOzbJDKBdc1Rj+ud+e4qWDcBqSC65WftsaPIrVskr1C0Z2F6QFgVUa+giYD3KbMtZv8Yhy4LGSsS8B5SAXfP5MB2/AjmbcuwC6ov2ySf+bEGkfuwoZag/kS2vU5M95QgeDPT8Wz98MmtMRtRzgcRIHwgFmxYqPRcmcX0AobsbcE/kdoMSROOeVznEQQ/kt8rXsb07R469m9V0QIAmnu4Zn9JkudyQLwcMam00xNXQ5rPpLRRoYbQaW5KmcQ3L17jTL+yrKypzZhuMcIoFQRffFhrjTfRmlk02FCgF/iuSeklQjVJkZppmVR6GPbJCtTtzHkeUH0UXhzfjLYaePmUV75/+A9TIrhwOw69MMPjslyu9dDfoLhbUZpPRjnROWArq25IiK6kJex9jz3kenbzdBvIX+ssF08GCCF1tqS8JhXqlQKDumrE5C4jnQi/w6SLs/7GFGcXJUYUM3TYi2XfDBQxsNsCczyE7qs4zA3Uknunq8kuhsMWEwFH87CcleVcIrJQgn0suDJpNCs50ypuxxNNXa6kr/pktpx/8WGoK5ZS0AwPLOWy2HV5/hcZbz4eloCTRB1N4hMy7hXtGdtcxVVSNzfFbWf8VMvvVkHAI+0dTFmZQE84bfBTIstgjloqdroo6ogFNTdlM2nztApDAnlXpsZoc/2uBz3MRikXAkbjI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(54906003)(8676002)(316002)(8936002)(4326008)(36860700001)(83380400001)(508600001)(336012)(426003)(40460700001)(82310400004)(5660300002)(356005)(7696005)(36756003)(70586007)(6916009)(70206006)(1076003)(2616005)(16526019)(26005)(86362001)(2906002)(81166007)(186003)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 06:33:19.5597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35d1403-1ed5-4045-35be-08d9d983408a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implementation of register trace dump function on the AMD GPU resets

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  8 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 53 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/include/amd_shared.h  |  1 +
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d855cb53c7e0..c97b53b54333 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -537,6 +537,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __entry->seqno)
 );
 
+TRACE_EVENT(gfx_v10_0_reset_reg_dumps,
+	    TP_PROTO(char *reg_dumps),
+	    TP_ARGS(reg_dumps),
+	    TP_STRUCT__entry(__string(dumps, reg_dumps)),
+	    TP_fast_assign(__assign_str(dumps, reg_dumps);),
+	    TP_printk("amdgpu register dump {%s}", __get_str(dumps))
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dbe7442fb25c..a63cdd0ad53a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -46,7 +46,7 @@
 #include "v10_structs.h"
 #include "gfx_v10_0.h"
 #include "nbio_v2_3.h"
-
+#include "amdgpu_trace.h"
 /*
  * Navi10 has two graphic rings to share each graphic pipe.
  * 1. Primary ring
@@ -188,6 +188,12 @@
 #define RLCG_ERROR_REPORT_ENABLED(adev) \
 	(amdgpu_sriov_reg_indirect_mmhub(adev) || amdgpu_sriov_reg_indirect_gc(adev))
 
+#define N_REGS (17)
+#define DUMP_REG(addr) do {					\
+		(dump)[i][0] = (addr);				\
+		(dump)[i++][1] =  RREG32_SOC15_IP(GC, addr);	\
+	} while (0)
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -7466,7 +7472,6 @@ static int gfx_v10_0_hw_init(void *handle)
 {
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	if (!amdgpu_emu_mode)
 		gfx_v10_0_init_golden_registers(adev);
 
@@ -7580,6 +7585,49 @@ static int gfx_v10_0_hw_fini(void *handle)
 	return 0;
 }
 
+static int gfx_v10_0_reset_reg_dumps(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i = 0;
+	uint32_t (*dump)[2], n_regs = 0;
+	char *reg_dumps;
+
+	dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	reg_dumps = kmalloc(1024, GFP_KERNEL);
+
+	if (dump == NULL || reg_dumps == NULL)
+		return -ENOMEM;
+
+	DUMP_REG(mmGRBM_STATUS2);
+	DUMP_REG(mmGRBM_STATUS_SE0);
+	DUMP_REG(mmGRBM_STATUS_SE1);
+	DUMP_REG(mmGRBM_STATUS_SE2);
+	DUMP_REG(mmGRBM_STATUS_SE3);
+	DUMP_REG(mmSDMA0_STATUS_REG);
+	DUMP_REG(mmSDMA1_STATUS_REG);
+	DUMP_REG(mmCP_STAT);
+	DUMP_REG(mmCP_STALLED_STAT1);
+	DUMP_REG(mmCP_STALLED_STAT1);
+	DUMP_REG(mmCP_STALLED_STAT3);
+	DUMP_REG(mmCP_CPC_STATUS);
+	DUMP_REG(mmCP_CPC_BUSY_STAT);
+	DUMP_REG(mmCP_CPC_STALLED_STAT1);
+	DUMP_REG(mmCP_CPF_STATUS);
+	DUMP_REG(mmCP_CPF_BUSY_STAT);
+	DUMP_REG(mmCP_CPF_STALLED_STAT1);
+
+	n_regs = i;
+
+	for (i = 0; i < n_regs; i++)
+		sprintf(reg_dumps + strlen(reg_dumps), "%08x: %08x, ", dump[i][0], dump[i][1]);
+
+	trace_gfx_v10_0_reset_reg_dumps(reg_dumps);
+	kfree(dump);
+	kfree(reg_dumps);
+
+	return 0;
+}
+
 static int gfx_v10_0_suspend(void *handle)
 {
 	return gfx_v10_0_hw_fini(handle);
@@ -9359,6 +9407,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
 	.set_powergating_state = gfx_v10_0_set_powergating_state,
 	.get_clockgating_state = gfx_v10_0_get_clockgating_state,
+	.reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 4b9e68a79f06..a165680d73a2 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -298,6 +298,7 @@ struct amd_ip_funcs {
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u32 *flags);
 	int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
+	int (*reset_reg_dumps)(void *handle);
 };
 
 
-- 
2.25.1

