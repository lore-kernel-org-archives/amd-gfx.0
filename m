Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AD6C7EE24
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 21:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5516010E6E9;
	Fri, 12 May 2023 21:44:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DE710E2C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 21:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD5vscOrzA/fSreivsnliSCfnjk5pyAjsFStXygGjNAsXq8tFm3ZmQfasmjbSTYRhIx/hEcSqEw1IDVON/TEUyR+I4ex5DVvcRVe/6UCDHEuML1a7gi34GTSO2DNYKOYNQNrgsuvkKcGlHnfF0UkWvYeRp1D0SC4wfEPpn5/V7qSutFMVEGp0vc6F3ZqMsKDoAOhvCqbWcYwvRjfchVQkHIe4x68qJ5c3DpQQMu77v+a4S1NAIMco53WgFqUlsoyUrCsSOX5KRNqoBGMctG2w1Zwx1prxVO99S43FqNTz6YRMudLpA3e4IceASvZZsHocjPaCfDC8FmQNA2+57aRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWP91nxxjGEmllwVEYLBJvZxZ5/WOzV8tsSdxgSmbsM=;
 b=Dzm8XY0beq08CMKqZ3lys/x2UbPPefLSi0gHkxH8IDa2+H0l3uMoV2XVxSAbBcmi223PvWNRiXFZXreIVlbNbr68DYBVbry8F3mXj9sjK2vHa7Nnd8HReZn2n6KnxK3DQwuyjDqktEqj+NZZ8EHvQA+pv8OeGTBDaVTH8AANv4ay3waNXN2G4XICbsAipSfc+y26vj/FIqPd4xJKjaIuucOW4o/Df0xaza/LA9GB8XCQRNdcYG/WcBRt3wgSRql3pg4ZfFBH1NJfVBYy0HIN4+pRNfbmT8mfiJ7JRuTvDVSguQKgnk8DHUKF6/0AAdI3cULeikTomJe9ZGQyeOX7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWP91nxxjGEmllwVEYLBJvZxZ5/WOzV8tsSdxgSmbsM=;
 b=h2fh8w5ANDm/ufBD1ycKOtRBDW05W3vMwEfnT77mJxX5cKYIlzwa8qi1paM7AsYepNwxQGMnEPQSCKmbOBDvFkfdeRxXrUleqRSgWF8OU1/xYsY24JFp3lhE9zNvo4uMF7xuiSWAwXyhgI7pd2DLajEXTXP1rO1x2qwK9vS+dvk=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 21:44:17 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::21) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 21:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.26 via Frontend Transport; Fri, 12 May 2023 21:44:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 16:44:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amdgpu: add RAS status reset for gfx_v9_4_3
Date: Fri, 12 May 2023 17:43:44 -0400
Message-ID: <20230512214351.1356254-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512214351.1356254-1-alexander.deucher@amd.com>
References: <20230512214351.1356254-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ef74b5-5a4e-4d3c-415a-08db5332091c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoMfGu7Yj36QXEmJhOvEm9/IrCNoUW5x6gPWPa2y1TbNL8zmkv9nkfVyuk0O6jDGKC12+lt5ABFYBzxC07mzo/zJH9I61xnG+WEc8FDuA4zkwr13mLitKeFLxBubTpBEN4cjD5YSCM3UDDrL44MfExXcVkKSJuHe8z/xpId0PBwnd6Aesr47BTQxVnQ18c+cxCUWXoPVRb0zQDAi/2n+3yXYPB6FDw8AGzhGHiFa2jEl9gjZcOaKGs5NfCdzvngEatsZXng8UnqwJcNfJ+ru1/EJ66TrtD0R2/lTHYFvI7zeP6Y34rT3+tCJFrzXzQLGAqnzQeniQFuY+LVA0eIxVzLslCyRsUMUwzw3RII95uPRY9t6K3fbc4hTqv48pqFaNVFWGgEbQx6EPQoRR7/Eigc4zbEMRBh4SeLsF+vbU8Sil6WsYRuqHMrq9izhmw6YU4DzevN1zB2iX+qpBq9uiZMDex+7qUlD1/xsA6cxbw1wuuCxI5cVubrtZx9YkQ1OlZlpLOjVGP8714/krqZVP/ZSZzSnMEh05Y7dbFMu38k3LCsHO9Kg5Z5yWLjO542Xf/zCvoi3sHIS8icCyhkrOXzMz0L5gn77OgriEdqDUbeDGjaoQJLXVCav2OFMV6ZJjI+h5QxSaDLoJdusx6uSD8oWs0jg7JDE24jSjVneTYuYSMujkML8qR4/Pbr0zZmGY2N2C4YUkAieEpEDSbgEcdaWPT7ogn4Pb9bp/tgTk+jk/B7xA2B+o33HYaLkjQIy1aMS0w6L4z+Ykz35/w/AsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(70586007)(6916009)(4326008)(70206006)(7696005)(316002)(54906003)(36756003)(478600001)(86362001)(83380400001)(47076005)(426003)(1076003)(16526019)(186003)(336012)(36860700001)(26005)(8676002)(5660300002)(2906002)(8936002)(40480700001)(6666004)(82310400005)(81166007)(82740400003)(41300700001)(356005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:44:16.7811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ef74b5-5a4e-4d3c-415a-08db5332091c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Reset GFX RAS status registers.

v2: fix typo in title.
    remove xcp operation.
v3: change instance from 0 to xcc_id for register access.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f178e3f565e9..e6069d081f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3050,11 +3050,52 @@ static void gfx_v9_4_3_inst_query_ras_err_status(struct amdgpu_device *adev,
 	gfx_v9_4_3_inst_query_utc_err_status(adev, xcc_id);
 }
 
+static void gfx_v9_4_3_inst_reset_utc_err_status(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regUTCL2_MEM_ECC_STATUS, 0x3);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_MEM_ECC_STATUS, 0x3);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_WALKER_MEM_ECC_STATUS, 0x3);
+}
+
+static void gfx_v9_4_3_inst_reset_ea_err_status(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	uint32_t i, j;
+	uint32_t value;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (i = 0; i < gfx_v9_4_3_ea_err_status_regs.se_num; i++) {
+		for (j = 0; j < gfx_v9_4_3_ea_err_status_regs.instance; j++) {
+			gfx_v9_4_3_xcc_select_se_sh(adev, i, 0, j, xcc_id);
+			value = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_STATUS);
+			value = REG_SET_FIELD(value, GCEA_ERR_STATUS,
+						CLEAR_ERROR_STATUS, 0x1);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_STATUS, value);
+		}
+	}
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+			xcc_id);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
+
+static void gfx_v9_4_3_inst_reset_ras_err_status(struct amdgpu_device *adev,
+					void *ras_error_status, int xcc_id)
+{
+	gfx_v9_4_3_inst_reset_utc_err_status(adev, xcc_id);
+	gfx_v9_4_3_inst_reset_ea_err_status(adev, xcc_id);
+}
+
 static void gfx_v9_4_3_query_ras_error_status(struct amdgpu_device *adev)
 {
 	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_query_ras_err_status);
 }
 
+static void gfx_v9_4_3_reset_ras_error_status(struct amdgpu_device *adev)
+{
+	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_reset_ras_err_status);
+}
+
 static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs = {
 	.name = "gfx_v9_4_3",
 	.early_init = gfx_v9_4_3_early_init,
-- 
2.40.1

