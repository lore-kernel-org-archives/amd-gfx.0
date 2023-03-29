Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377C8C77B62
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CC310EB40;
	Wed, 29 Mar 2023 15:25:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C8510EB34
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi3QkEt6XfHmcekO80ZqXGaciJpFyGFrWzYLVWtOVzlpgryDXKmccQvjDFG6sJUsvRc/u8Xqv47mHsK3rqgNlaOgHfiTI7pG76GtSb2ynvvcm0uWIwuxgpAAZOzPJnlli/3J4FaYNRid7dL9FG8yuCv9ZnyGoAgQKHOZmtxiMXnhXqFf3P3+OW3QMAY/BsTeCdc1Fkz7JL94UyQ89qesqGNetjc5pGVPZ5Vml8Z1IeoJhJxkPndXI63WYJGkMxancySu2q8yaumrM3StwA9/FUDtA+JCHFkf5N3By2lQrxygRGGZadFbUO5BornxRkSDqUcQlRV6C/hzlz8sCt9OwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHJuJPaG0CoiXT3+wQIZsE58JX0gpCz8WLzPj/MTGWQ=;
 b=djP4z3kl1oJCBQ4geAEXK2/a/OmPrWnqyjvH/ipI8XRMX1BjZ8cp0YH0HZDlneqdahoIGik8+/tIIOcP/ircnC8cyN+q51ZIivyM5OBA0BV0diyAZgl1ipXmfDTqxT2N8rrY1n+ls+w7zm3BoWPhSo2uoNtnB4+UUd9DvDTYsv1amUffOY8Pwv9bPFeNmZ+pjORgRVZFLbSfh6ijmTf7cAITIyEtf0DcyomQ4C23tKbtCorMxmIBO6LJBDmwTw5m+kO3MghwC48CRr0SYIYBUXnaX4BGbUWMCACrAb/8ZbFOcCCSkhSYU+ieZV3HKx3ej4mpDwSGIU2qKi2wx79mUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHJuJPaG0CoiXT3+wQIZsE58JX0gpCz8WLzPj/MTGWQ=;
 b=yq3ZYEtENArzJUOfC+6130McKIl2ckWt0ppPhdbzsrvEBO7zy52WsLaat9aBlIcR7SnEp2I/yHKk8sv4aryx/H9ZT3AEXeVCxQCw2VASiwO4oGrOnyU3WGhjbHWg19DYZDHTQXsYWQGX8bA9nVlSJy2hh7UlAvQaGb/nmPSx43c=
Received: from BL0PR02CA0110.namprd02.prod.outlook.com (2603:10b6:208:35::15)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 15:25:40 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::fa) by BL0PR02CA0110.outlook.office365.com
 (2603:10b6:208:35::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amdgpu: add get_gfx_shadow_info callback for gfx11
Date: Wed, 29 Mar 2023 11:25:17 -0400
Message-ID: <20230329152521.1980681-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4ecb0e-f77f-4a12-be83-08db3069da5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0m7ylZ8OONkB2r67qG9akGCAh2qrHwX6GjeiDBd/2LGCHNXzrgqrrRSeWZq4blkh5wbWSoSO6htK74O69rk4rLEFt2e6a5xnC/lHv7reT5BY47xgHixX/2tWocTywcNi5Rvk5p10ovT/KPferXkAlHDYHIAdH2PRJUGBkOXxnEwQH4GRj4kDQM1tqmw2dpQr/Vab2Ze+1fJ2uMlyca5DYDFoAOCYZK76ME5U++kU2lhBiDMUWjBd4TRNWzR0w/riCArwq5UB7116yVGEK422oHJLYzl1oaECGLaL7yjs12gcFzTHdqCL8mi/zTQCiE+qF6GMJwpOFY7NtZlT9nFvKGAACqkEN/CtK8ViQDiRVy2y4xlAP47bMVx96RH/8gi3C3C7tXDlnyOoNVikpe/zVdimgDwz+c1QQlFRu3NTfRjyOh6vCvn5t/wJTRfIqUItReAfrhtGyiY669D8QKQGhKns42NzZeMXEyfaZpE2CYHeoOHWah/ma9LRLKdRE6b/l/0vcx9wgySLIWqnTS8vNkju2HXoAnuhNfuM7gpqyn0J3g1qIP/nBwt+J1MzYv7kfzyEvxEcD5feQKb3EIiWCrsUkD+V9BHyjFgbjvQrtEUH8es1PZ/cPKgYDbLeoaWDJjpyylvh9TJXtwgWQLdarVVG96r6hGEJtA6vPuZM7PGD4wrixc8Z0MfebwW8T2ZjsYUHrl8+4Z1AOXdpMNZE7vMJKpvhDZYtNKcSoW/SRvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2906002)(336012)(426003)(83380400001)(2616005)(86362001)(36860700001)(41300700001)(36756003)(40460700003)(5660300002)(81166007)(82740400003)(356005)(40480700001)(7696005)(478600001)(8676002)(6916009)(70206006)(70586007)(4326008)(16526019)(6666004)(186003)(82310400005)(1076003)(316002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:39.5995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4ecb0e-f77f-4a12-be83-08db3069da5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used to get the size and alignment requirements for
the gfx shadow buffer for preemption.

v2: use FW version check to determine whether to
    return a valid size here
    return an error if not supported (Alex)
v3: drop GDS (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1fc1e941f7df..df2eabf50e6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -822,6 +822,30 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc21_grbm_select(adev, me, pipe, q, vm);
 }
 
+/* all sizes are in bytes */
+#define MQD_SHADOW_BASE_SIZE      73728
+#define MQD_SHADOW_BASE_ALIGNMENT 256
+#define MQD_FWWORKAREA_SIZE       484
+#define MQD_FWWORKAREA_ALIGNMENT  256
+
+static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+					 struct amdgpu_gfx_shadow_info *shadow_info)
+{
+	if (shadow_info) {
+		if (adev->gfx.cp_gfx_shadow) {
+			shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
+			shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
+			shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
+			shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+			return 0;
+		} else {
+			memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+			return -ENOTSUPP;
+		}
+	}
+	return -EINVAL;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
@@ -830,6 +854,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
+	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.39.2

