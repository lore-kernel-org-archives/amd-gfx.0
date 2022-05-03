Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC64C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9368510F38F;
	Tue,  3 May 2022 20:29:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A0F10F399
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5Rtl3lJnbWsdm5v5QFUUCc3L+yeU9MyJNW8j5scOK+RnqnZULs5NX957CjjEcNrj7lwoHnhgs3e2tiV4XwH/A0m6ttuok8ckrb5Qz1MPq6LWVOBsvHEKHOp8uCNHD2qxeGMloS4U9tbcq1s5NfdaarQ9KOjt9eJgOAQWyAGF65VKM1IkRJ127jeLWDfQ+i1z6/fyFvGcfCyVlvlHAIGq0UyjDAg54ceXtEfWKdFYxdaD8CwW1X47K8fpZxXDyNamRLPled8FN5esOJ+JQ0xpNT8OSWRIxS0gImWA/Jw1l7J739RCAX+LWI9lNlN6sLpNhAa4ibWuiyc/XVAq4O8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN4LZlDW/Kmj0KkzP0OoANNXpg4PEJnQPOEVk0E4wdE=;
 b=LHW65zBR2aWmX6WTvOSoD+H4cy9UA834CclTOJT6DRKoGLWghy/UWz+XyRbf0A9LoBrLULej6u9pKL9+Z/aavrD5aaLTHfdifs9THs/cvTKc5ox+X64zdi7oeUm6EYCR4+WrWwy2fGwwFXLjKabnKpfvQHmQbn9uZZUns1EYOQKRdxzuqL69DAoA8LAc2aXjjpXj872Y+w+BtaDvvhLdVYLaDA73pPZ7Mg31i4/KLlt083bKxTabot6hZzhpqeDOurt21PXX38A92OlUyv973UybfI4evVelm55kE3TiwVYFy85LormriP8V7DCibIvf+c6yjBZr/vqHXWvf7m5Qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN4LZlDW/Kmj0KkzP0OoANNXpg4PEJnQPOEVk0E4wdE=;
 b=nxhkj8+k/hKsu1s/UHu6J1CpBI9Bc9Ci6h6x+SstKMQCqgLCkm5EqH18aPb6f/obY19g7juSVWuMacJSH9q5yq0hxUnHXpr/s4l7JPEVPnnrYEGwAoU8pfY3b0sfdRqB/Ii/mJC49bikQFcDcFVQXujYt/iaOAOFSr5hUuDUUfs=
Received: from DM6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:5:bc::14) by
 DM6PR12MB2987.namprd12.prod.outlook.com (2603:10b6:5:3b::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 3 May 2022 20:29:35 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::17) by DM6PR13CA0001.outlook.office365.com
 (2603:10b6:5:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.14 via Frontend
 Transport; Tue, 3 May 2022 20:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add initial GC 11.0.2 support
Date: Tue, 3 May 2022 16:29:07 -0400
Message-ID: <20220503202912.1211009-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb2ccf8-6d55-4aec-7fde-08da2d43a385
X-MS-TrafficTypeDiagnostic: DM6PR12MB2987:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2987D103106257D2F098E2E6F7C09@DM6PR12MB2987.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUpPqytQtEgLEA50YQvZn/5U1qroh2t3KzU5DNVNcObTJpFjW8D0eW1/8rmmBFBnXm8qoDwUvrbCN5zctY8dJSAaNyB9pscPSqEhL3iLQLFxS7UnXicX33KTgE++9uWcP70vLAJsjtH3pxSXyBRaPkChCjNDo56YYe1fcoiuiDcMGulC6YsOYmhAGkc+aDNEdQwhQv06nfprRZMaQAurI7CRjA2OeA+td0r1/3Xv40I1M78poNut9sxYITqQCAPyFDv8TT4xJc/af3yNXMVdOt0eh1yJZ7VVuANig1T+GioZnjPa9z+ZNqCXpu+6N8DFrDFZdrQEK90LjsISvjJZgnYCUTk6OTqxsyy7pQw7c7hba002kR12D+1gGijW6k5QdTtnp9iStcBLifvAGc8vQaJzzbrT/rxNBkaY08+Vxrw5U8MUpu2oicacqS+X54zKZay1GjggazWu9cMrVbWndC6bDfwmHi0lk15iRZDvRastDW8ifkbBtAmkn2dTGO7smYoOOJKMzt7PPcybiG8LQyXOJOFpNpy60NnwkRVd06X/IbanVN53jYMOOLy3aIAKwHQ3knJaGf42CfkiWTWXjzYDciCkROo14Vsz41ea3UbjjJrSbHwxjNm9ZB+30Z7E5xiorOOwN7iLMRkMswiCHXOf5SeU5LSuLaOfggm+xTZs5tGi5IRAfxF7Ka4XMvQV4bO2BAZlkYS+2Hsca2dzZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(47076005)(2616005)(6666004)(1076003)(16526019)(7696005)(36756003)(26005)(426003)(70586007)(5660300002)(86362001)(8936002)(82310400005)(186003)(4326008)(508600001)(356005)(2906002)(336012)(8676002)(70206006)(6916009)(316002)(54906003)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:35.4746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb2ccf8-6d55-4aec-7fde-08da2d43a385
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2987
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Add initial support for GC 11.0.2 to gfx_v11_0.c.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8a1c0f783a2a..97d37b2e58f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -59,6 +59,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_toc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_rlc.bin");
 
 static const struct soc15_reg_golden golden_settings_gc_11_0[] =
 {
@@ -1122,6 +1126,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1548,6 +1553,7 @@ static int gfx_v11_0_sw_init(void *handle)
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
-- 
2.35.1

