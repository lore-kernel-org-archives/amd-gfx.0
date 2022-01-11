Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0061AC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE4D12B65E;
	Tue, 11 Jan 2022 07:11:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD2E12B65E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKMo8I7giF1YN6M7eo3Sr6G27MGBYNHs2753I7X02TvY96edTKVKXVUS6FSbSIUlTmiIPrs2vGs3SFHM6jRVcnUmvh8JB7BbQCNW79Eyt4ujfmw5fOh7BXdRawZqv3RkqT5f1yxcyaj/FfSl8f3EQM/QER3y59YoFH82HZxNTFMqFibqBKKmLjWw0gGXYmzIlxlZWd4I4plIgmLE8AviUB1Yd+yA41vTqqt2tIKP9x55WZbsy15NsTDM2ajfafseHWHgXdQbmbttfIBZLHq9yzZa2ND9E+nALijoM3H2u/dhUA75gHlLYhWhjhsUGuoatOluc8WYvoQhBxGM1ci/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pakjl1ZH4YFlwJ3WYnnj3nV/LLWpJ6Qxes5WH17NeXk=;
 b=etMcVysVjr+syvT56I7q40JS26BuXGl7nBUDOMh8rRvPUawXzQxysQDMEfm+NdrsdKeL+z2opiTScZ/qYc/oU0Ny6siU4FE9XvS6fPLbIi6W5xw5VvJwL0Ga20FKRI8qvWBcagvShscpf5vTv5VBtsfL/bZSYgDtZ20XPq6Cqeh71okhyB/d+fx34cF5t14gT+Ezbr9FJ2/L0x+tl/+G1fa+jspBXPjRTvfI5wsJIWZRQtVMEUrYvFsAbBjAdOekKCvFQZjPw6PUOqCvmKlReu//lC1epepjYXdts6a7zbXyau7XUey9tDhvzHGhoD7NMl/3CAoGGV0cb1Wpmythrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pakjl1ZH4YFlwJ3WYnnj3nV/LLWpJ6Qxes5WH17NeXk=;
 b=YLMRTRI0Q3S57pzDjR6Ip48MTkaakkqiRKlq8JdYh0amvnC2TGLqM4Y5QF2kog9sR42jtKAIXfGBvFupknsuISopyt0TgnLsBD670VfH/fmkhCJzJ5IIqvRNigmbSqGQUk24hsrfhkUTc2J5K0LKxkTDr4a/R1uwiEhAWqOV31s=
Received: from MWHPR2001CA0015.namprd20.prod.outlook.com
 (2603:10b6:301:15::25) by DM6PR12MB2681.namprd12.prod.outlook.com
 (2603:10b6:5:41::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:11:39 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::fd) by MWHPR2001CA0015.outlook.office365.com
 (2603:10b6:301:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Tue, 11 Jan 2022 07:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 07:11:38 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 01:11:36 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add reset register dump function for gfx_v10_0
Date: Tue, 11 Jan 2022 12:41:19 +0530
Message-ID: <20220111071119.5464-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f314e1-bc2b-468a-920f-08d9d4d19c6b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2681:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB268136F3FF1AFD928BF87AFAF8519@DM6PR12MB2681.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8EP6uQ+eETfEn8OXi/L+NBBLqWT5gXm2jsJPSvuMD7LVFB58d6/XoG+x1ujcw/i1sft8GMze3L1cASHHrPB0vsNDWv17tlyZnMpnw9UPeym8sMJwM8ngLLA9h7OvtnVZqE6bPZmJ4d2SP+1osrOZ9XmKUFgaFOHepIdsS73I24Dv/MOgah2Uj/z5fPtgBwPrY8ovCJMkVOcNKdVjBy//hAvPXAESityD3/g8ttaYvQig79xawfKb5KlSO2rIBjVjGJ02i2d0ezHzOExelS1wjgqKOOyruSdcZHpqAiMlsCs+tyzsmVhlBN8LgoOHTp6tub/Xeco10oEyoFLljoEsGSSsGXA+1fgvTc5YrO9LKtIfH+eOvN+7WVtx8NAD+YH8oHX2xYeGCNUfiEZClaw83rySGFlsF2HXVLEArquOefUP6LEtj8nFacJbQd79GRPKiOIxyEMweaqAJPWqD9/jrtrMxj/CzyCBcLfYodlYklTOOZSa1oO8dn4EQdOHf8QFNWCtBKfp8Fda5d5COZ8F87Yv3K5Mfxvp/fi3Og1DxtbktNO7JrtTxAk2IyvC8E8QJSZsjjAB0HgV0VYuhAmh30c0PRsfTFkzcWrmM9vfVowK86qIqkeUlyXfVFazqjwPaG7GEtjs0z9SbiubxOOQ5Xc0EZZ47DWAKVNUdzFUgvINvjdvURKy6dar8YMYJ6op8GrZA9PTgT0SHfXMoWhGqc6Pmzv1zG0f+bkDDhVD3v3UNwyMFwr4sR927E4J/7leQNaXx1qzw27rW0eoNqFrj7SsWp7d9E/3VIzRE2njcM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(356005)(316002)(40460700001)(81166007)(83380400001)(2616005)(6666004)(70586007)(70206006)(7696005)(82310400004)(16526019)(186003)(426003)(336012)(508600001)(36756003)(2906002)(6916009)(5660300002)(8936002)(4326008)(1076003)(8676002)(47076005)(36860700001)(86362001)(54906003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:11:38.5622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f314e1-bc2b-468a-920f-08d9d4d19c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
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
Cc: alexander.deucher@amd.com, Somalapuram
 Amaranath <Amaranath.Somalapuram@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implementation of register dump function when the AMD GPU resets

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 55 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/include/amd_shared.h |  2 +
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index dbe7442fb25c..dbd74204f06d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7466,7 +7466,6 @@ static int gfx_v10_0_hw_init(void *handle)
 {
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	if (!amdgpu_emu_mode)
 		gfx_v10_0_init_golden_registers(adev);
 
@@ -7580,6 +7579,59 @@ static int gfx_v10_0_hw_fini(void *handle)
 	return 0;
 }
 
+static int gfx_v10_0_reset_reg_dumps(void *handle,
+		uint32_t (**dump)[2], uint32_t *n_regs, char ***r_names)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t i = 0;
+
+#define N_REGS (17)
+#define DUMP_REG(addr) do {				\
+		(*dump)[i][0] = (addr);			\
+		(*dump)[i++][1] = RREG32(addr);		\
+	} while (0)
+
+	char *reg_names[N_REGS] = {
+		"mmGRBM_STATUS2", "mmGRBM_STATUS_SE0", "mmGRBM_STATUS_SE1",
+		"mmGRBM_STATUS_SE2", "mmGRBM_STATUS_SE3", "mmSDMA0_STATUS_REG",
+		"mmSDMA1_STATUS_REG", "mmCP_STAT", "mmCP_STALLED_STAT1",
+		"mmCP_STALLED_STAT1", "mmCP_STALLED_STAT3", "mmCP_CPC_STATUS",
+		"mmCP_CPC_BUSY_STAT", "mmCP_CPC_STALLED_STAT1", "mmCP_CPF_STATUS",
+		"mmCP_CPF_BUSY_STAT", "mmCP_CPF_STALLED_STAT1"
+	};
+
+	*dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	if (*dump == NULL)
+		return -ENOMEM;
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
+	*n_regs = i;
+
+	(*r_names) = kcalloc(N_REGS, sizeof(char *), GFP_KERNEL);
+	for (i = 0; i < N_REGS; i++) {
+		(*r_names)[i] = kcalloc(30, sizeof(char), GFP_KERNEL);
+		strcpy((*r_names)[i], reg_names[i]);
+	}
+
+	return 0;
+}
+
 static int gfx_v10_0_suspend(void *handle)
 {
 	return gfx_v10_0_hw_fini(handle);
@@ -9359,6 +9411,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
 	.set_clockgating_state = gfx_v10_0_set_clockgating_state,
 	.set_powergating_state = gfx_v10_0_set_powergating_state,
 	.get_clockgating_state = gfx_v10_0_get_clockgating_state,
+	.reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
 };
 
 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 4b9e68a79f06..98291a8f57dd 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -298,6 +298,8 @@ struct amd_ip_funcs {
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u32 *flags);
 	int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
+	int (*reset_reg_dumps)(void *handle,
+			uint32_t (**dump)[2], uint32_t *n_regs, char ***r_names);
 };
 
 
-- 
2.25.1

