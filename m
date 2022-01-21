Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8483AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 08:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B00D10E98C;
	Fri, 21 Jan 2022 08:49:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4048610E98C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 08:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWpJqTWNyAprz6pmQpAIP8E/5/vGwP1bMqsmsVhzsALghpgZXiei1NozHAjKzCc8n0rFc0IdyrRy6sqM8vCI/IGMKiuIqdVPlX4VEPPrAuNUDp+Dhn9HxVFvach2v0iIXACHsAVpPy4KwJGoGs17AS3mqDFtHCCPEvlo3yNjxVnQl5Juqpd+MjPem/Xv8ZyEYWajYELGVUBSn4iSQJqUGkMA9CVA0NJYrqDdcZorraELcpPF7Ugyi0v/ChAAwRyDXj83HiACLS2gHi2L/Rqj2itsu1aHfFCtz+mT7eenvBteJ8mbfItf9W6Rqd+BzQDCWUZYie6BFuVEWPkkXFZ2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llN/RACRFusokBaApUJm8dg//BJA8hXgiyg9fxEzG6Y=;
 b=H8Ha1xO09zHPDL16rFB2YlMQE+DE5b0Ksvpa3mc8MZb95/14YyVCYTzSATMuAWGzwrq0XgLlr9tBsFcl2W+3F3ILNsSO4h5ol5+HOB8GhCdSxmwqyHVKzfVqAmWAQ97vKXgvyimcUPSVfK3sTFmYHBJJo466/eBuqYwtHQUGVvgs42pE8JedB5PzrJ35C3P6QDUXDIrP6CoRtlZVbv4Ot0KutJpHax42MxZCCjegQ44Ahz8VNcZ1bS9teO0FYw39m45khnlbWaC1ASwos+H5jGhvrZyBCb04EqPU3aZlJ9Dxkgwk5E8DIngRZ1LFaed+Ijc7Nn5w4xuWZ3YY+oRJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llN/RACRFusokBaApUJm8dg//BJA8hXgiyg9fxEzG6Y=;
 b=jVu/o+UGsBgv29lvqFzhNtdS5Sj0LuLnO3kSKmb+IJDWKPDuEgqXmlOvyIDMD3IjDTpLWCu/QfrC7UcBYlVETCtbx/ecKPOmg8Z3Kh9dAkct9CislULlYp5zBFoXlc9PFKJCfChHCEaBKEAiiEYwG71rQtCMl27lWIlUTNXp+YA=
Received: from CO2PR05CA0094.namprd05.prod.outlook.com (2603:10b6:104:1::20)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 08:49:36 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::f3) by CO2PR05CA0094.outlook.office365.com
 (2603:10b6:104:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.8 via Frontend
 Transport; Fri, 21 Jan 2022 08:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 08:49:34 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 02:49:32 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add reset register trace dump function for
 gfx_v10_0
Date: Fri, 21 Jan 2022 14:19:10 +0530
Message-ID: <20220121084910.19917-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8441f76e-1fe1-4c29-dbf7-08d9dcbaf31c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51795044A90D4A957D87BA8BF85B9@BN9PR12MB5179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/uvOaREsPgql+jr6vdYRWGHPPKJEKlPK57ZdZCfI2uuoa8BCOxUkQwStRXCHAwWF/FcNPO19+p8pvL1AGMu9ZlGsEDpoj1Uiwzv5ycH3cze79BC/89w3k4tEH0dmoPXaZN8UxyUSWKTepoDZK5CS947+nmWEeBcBM2NCgxheX1FuyhqF2rgPva4Oyci5cxivDPCTv1RCdYdkPmZhf5rXa+MUQYIrA5w8P3TkdxTd/xF4+tLViQe9orcXacZHYe+2X3Ull4XtHlP7SGls9EBXsqi1Dn88tkq5FbBpJBisbwmg3IdRCFFdwtycxDck1J4j3HyefTzE072FwnntNxiuu4WMj6a4yWIctzk66GXrcBQb/GrtYeOm2DTJRUes4LWkv49bNWhc53jZvwgyzF6B6aHkieGtrub10lU11njJGW3tCMYdYUCl7N8aGoP2pb9E9LBqNG9ugUTsSWj7s6WU82dvdqvJnwKdBraV9PgsYm8C8/TyElU6R3FM30lL5FTfoTGfUDSg4V53ixBQ0LTAftDfpM3Re+AknoA7s++iN8huVewH1sgOD1b2gV5z0wZJEtUk7FFOapL9/NIW4JIdqelQI1+GPpm4P5yLCeRZ6f47V41BRHcbwfHGFT/s6fFfDJd1v+C0rqRlJovaG8NVXJl/Y/PeMSN7HDUEDx0ER422FNkyivMdzXCaQ/Tm+w+B8kyLdPidpUQZXTKRarXahzG60ozjq+2ChdW4OUUhV40gwoA+qb+PH7aMf5dfwRbolb15vTsBeqTFyQWn2z4LgK7IorMWKfuVymxhqvX3Pg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(508600001)(70206006)(70586007)(6916009)(1076003)(5660300002)(4326008)(16526019)(26005)(2906002)(186003)(36860700001)(81166007)(316002)(336012)(36756003)(7696005)(54906003)(47076005)(82310400004)(2616005)(40460700001)(83380400001)(6666004)(8676002)(356005)(426003)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 08:49:34.8856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8441f76e-1fe1-4c29-dbf7-08d9dcbaf31c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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

