Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E7DC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 01:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AA110E25C;
	Mon, 14 Nov 2022 01:52:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4504B10E25C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 01:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiAEYvFPPyA2HSj//jx1Qu77nnw6iEKPewSLn+dA0vXDSBwatNKlkJHNGotxjoe9VQXald3sVkmltX1zI/iOALkVoijYqczzpA6MB0HdFLdyR1jtz5nz2sYo7WGDWcml794ROgidclK2tDT54Z52N43n/eXAe+955MgD8W+pFUpQmtscsBxlsYzPeFoKJsmFlkpAo5c+FnQnfSTR0c0Cp9iL7G2VKFMbGfJG6dsqc3J6jtgLz5hkUs3v7qJZSdpwjix9C+OYeGItTFY+KFPgKOQdbfKrvk6eJTcbpWLwU2kL+qY7MZUpIgQ1zAEzdpW27JQQXX0i1p0Vayw/l6tFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0Q7SN/k1/bvHdh0p5DPkSPTgcEVkr6FnJYCv3PPS24=;
 b=DGSjK1P5TuEpw0mEZVP8ddiU9NisdFCyCmJGmdTlnXoaALSZk36YWrDGQPZyXg10lJyPlNb0zddsS9i5sZb6vlii2UAVa/0Ejw3QVddFnGOi0sFauxiVUkuDpHHC365hJyE5Momfgz363j6kmg9qqopr7NMItIZ4XU6LA/fc1Oa+xGNMAYrluGwF0l9+/M6bnwxeCA2/mBcJek+jyPsLF9h3RypgtzZQ5DP4ZTY0qNR1/PuqiMN5bc14QhXf6LNyEyV9EUtzfXV4N/4phgXJuZWNhbHPB5NIU3kGQl5ltQPTtxxbdWP4fVKqcZY7G+fnnc5jIc4W6WamH069F0PQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0Q7SN/k1/bvHdh0p5DPkSPTgcEVkr6FnJYCv3PPS24=;
 b=Bd/5zTPivy87Oh8nUHQbPle1CjM2gYgLHzDoxGauTZ4C9BkIyiABM9m2l7e9diIQj4wWL1QYRk6nGTV6v3QedknVVB5s5roRxFyNucrMj0RGOpoi5lUQUJiCY81ut+FqBcO74nRhmrMm7we1/m2/ITxdkMTdvqJ6ee7dYlUj6dA=
Received: from MW4PR03CA0344.namprd03.prod.outlook.com (2603:10b6:303:dc::19)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 01:52:23 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::d3) by MW4PR03CA0344.outlook.office365.com
 (2603:10b6:303:dc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 01:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 01:52:23 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 19:52:15 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add umc channel index mapping table for umc_v8_10
Date: Mon, 14 Nov 2022 09:51:34 +0800
Message-ID: <20221114015134.4079216-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ac0b67-db48-490c-741c-08dac5e2dfa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWu6Z3pFxqxzzEK0d5Pz0o3+F6oJm5AVlNytV7HW8gm1ai6v1GZCfWxREeQfqF9Z576OcNOSXtOvxeIYCSgaWbPowto3JqT0FV8Tw4w7A0Yz9KXqcVjIkkH5ptUXVZhl6a9ONMN3I26HTNAOx/duryeZZsrVLGlohr1GeaDl71QYPeYrDaJN4Le1f2Mxrzi7I6xe37dzi6c23VhlELHK8Fx6WmLp2fvy+YAy4mtD3cTDuAOqfZg2WLMh/wKcwjIi/T676nj7sOr59iPDxCgNbmlPNCA3mwCXLDBpJXZgH0PLj1hWPb3kjcOtKKIU3opA+NczHKac5r5GbwNGxR/0lP4+tYmg8alfsxdvZYsLauG2Ygh/GFAXBjI29JaPWo2uA379SchB2Qlq6B1VP7yrIQ/7iOTy4gCJPOZLyAwOpJO1FSVefqxV/qHxZiQUZbTVzUQakyRsM3PCDX71fpJRHJJ2rHM0M3lmdKQPPZv2OO8HiIuvaZbAHj+MDkctlVZodVQO1AhF5C4GfuPpH5opM+qBwXJyEcM25VyaqMYQ7iOrBKw+UNWSVA5Vy6KlB3uPdnpzrRCoLbqAfhOHEZonjM4mzrNyVgB/Vb3GSLe78nlLsNJsgc3jmUQ4dmFmXZ+ZZMej8nFFqn+9JdLGvLihCHht3dxfh1b9zwW24ENUjsS7LPujtLiL36qo52UOiyMe5pGBPUX+Pv2/vKMoRzxpIOulSlXcZBfj90wEEET5eNtsA8kswq1jLK/oAnSc1d1QcFy1nJtxWDBvROoIJYmpngjOJu3VrihTAOQTOBNLICqvMDM+wBy5KXxnBIRybu6a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(81166007)(83380400001)(356005)(47076005)(186003)(1076003)(2616005)(16526019)(426003)(336012)(36860700001)(82740400003)(2906002)(8936002)(40460700003)(40480700001)(82310400005)(478600001)(26005)(6666004)(7696005)(8676002)(70586007)(70206006)(4326008)(41300700001)(5660300002)(6916009)(316002)(54906003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 01:52:23.0292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ac0b67-db48-490c-741c-08dac5e2dfa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>,
 Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add umc channel index mapping table for umc_v8_10.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h |  4 ++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 16f52049d986..96e52ec0fb69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -558,7 +558,10 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.node_inst_num = adev->gmc.num_umc;
 		adev->umc.max_ras_err_cnt_per_query = UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
 		adev->umc.channel_offs = UMC_V8_10_PER_CHANNEL_OFFSET;
-		adev->umc.channel_idx_tbl = &umc_v8_10_channel_idx_tbl[0][0][0];
+		if (adev->umc.node_inst_num == 4)
+			adev->umc.channel_idx_tbl = &umc_v8_10_channel_idx_tbl_ext0[0][0][0];
+		else
+			adev->umc.channel_idx_tbl = &umc_v8_10_channel_idx_tbl[0][0][0];
 		adev->umc.ras = &umc_v8_10_ras;
 		break;
 	case IP_VERSION(8, 11, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index 91235df54e22..b7da4528cf0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -45,6 +45,16 @@ const struct channelnum_map_colbit umc_v8_10_channelnum_map_colbit_table[] = {
 	{6,  11},
 };
 
+const uint32_t
+	umc_v8_10_channel_idx_tbl_ext0[]
+				[UMC_V8_10_UMC_INSTANCE_NUM]
+				[UMC_V8_10_CHANNEL_INSTANCE_NUM] = {
+	   {{1,   5}, {7,  3}},
+	   {{14, 15}, {13, 12}},
+	   {{10, 11}, {9,  8}},
+	   {{6,   2}, {0,  4}}
+	};
+
 const uint32_t
 	umc_v8_10_channel_idx_tbl[]
 				[UMC_V8_10_UMC_INSTANCE_NUM]
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
index 849ede88e111..25eaf4af5fcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
@@ -66,5 +66,9 @@ extern const uint32_t
 				[UMC_V8_10_UMC_INSTANCE_NUM]
 				[UMC_V8_10_CHANNEL_INSTANCE_NUM];
 
+extern const uint32_t
+	umc_v8_10_channel_idx_tbl_ext0[]
+				[UMC_V8_10_UMC_INSTANCE_NUM]
+				[UMC_V8_10_CHANNEL_INSTANCE_NUM];
 #endif
 
-- 
2.25.1

