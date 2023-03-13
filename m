Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE465C6FD1F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDCC10E469;
	Mon, 13 Mar 2023 01:45:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9777B10E468
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOYJyJulMqSkMl6GI2bMN5VDX2wm8TFqUd6tcjO/Zn9+VrLarIK4toDdEtdRJjp7qZmkZhKLhb8gLMrW+XOzElZPgAokc434ITLsy8yYNfx2f5GpBEGCj+gJ0MRxjO+2IiFKTSPmrbCcpLzoxEeHKSJQ6q+llrVUYwK0SyVgTf4f5n3AnzKqLtrRF6wpjW6HOlbIQZll4YHvi1CSVC8sSRKjykehk/if3JViZS9xxB1jt2VaxdYOHuYV7DNhTqw7dRV+HsmcnlHNRMSQCNSLSd/ZI0krkOdUdKAWwZLkJCrUOOjawVwXt02GShmgrTTLXKwpOZsnH1SemyzNIIw+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H79LeK75ZKTvK/2JJbgRZqALII24g2Twgmi/qrUGwM=;
 b=KDYN6JieGyIg+0j/GdE+2vIV5i0pJ6KqOZiFBoTGzELYRSOGSNbpGcq/rNauEQLw29IwG64rfHFWntfrpOmUa1ymSNfCDrknT0zXEFy1oHphT0LA0oWQSQsizpI1TfCQcW/k3JuRlTwIaxBXUo/nMlcpZdu/8r4G+aw6q2XYaY8LiAWv2soV2suGT7O3hCdSq8W1Ng9LL9UECtnZq8+Xv1ji58qw17p2F3mbKcDrX3knket5wfX0Yo7M94iVQs3R6mDkD1eJXX3xNW1mi2HU56+kX3CFvEwjTxLnGPO/DTY2ki+Nyc0VEMNwJEomXE1NARXzN30reHHb/mBl2Kbh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H79LeK75ZKTvK/2JJbgRZqALII24g2Twgmi/qrUGwM=;
 b=zCSeVhjMnmHMMy3j4LSuMcfI06dYT8d29KcTODsWL8TKbSeEOu0QJCvklCXfv5nNkXhNfRrcpMPJDtfA+u3QwVRa0FzFm0cnIyObj9nH1g1wjVkbz3IwzKCXVXan7GilhgkvXwOOqqyFE1DVFlEyncDYwNhvHMEjZdiFnqRQvmk=
Received: from BN0PR04CA0209.namprd04.prod.outlook.com (2603:10b6:408:e9::34)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 01:44:52 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::d1) by BN0PR04CA0209.outlook.office365.com
 (2603:10b6:408:e9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:52 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:50 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 08/10] drm/amdgpu: Rework xgmi_wafl_pcs ras sw_init
Date: Mon, 13 Mar 2023 09:44:01 +0800
Message-ID: <20230313014403.21903-9-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230313014403.21903-1-Hawking.Zhang@amd.com>
References: <20230313014403.21903-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfbbbe0-f548-4abc-a172-08db23648a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsnFtLNDQ3koC8B9VDFM+yAaHHA1l2ovm1iITWhRLd7pyiGy+sMiYybkUS6jldV9pApTnn4NtlU8a6blMzkGImqd9JiJoWmgouKGDH6MPg8yvXcyBw+lqmZxjtMA1S0Tf+5vXyKmDOSus+xKa+83rT9+xR/hS2vSEY5xkKz1BhvbnIok96gFQABE26hmfSA0/uO8ugcTRyj29GmZZI2pXBYB7FjFV26cJFSdIqLJaXS3+1ccjLNMxO4YtZ3miN6Jt2uMhKKuqYQ+A26wyrwpVMUD1jr9k3suwva6577Pp3MjHIWu6dVDOb4uUsubckiuUrqsq++mvzmgnqVOj+lSksCprAC62/6r00KtqspEXaBL1nhEKjPXia8fnqRebF1h/7GrZWsLjf/OM2rqipaXuVWJp7AmUZJOhxRksnOZrSZ4prMOxqKcwf8TXN+ygDJlB2OyQazjZvpZBA/I9fSbZBLCvnL8KDXs5b2Lhq6ny5DyMXKhn1zbPI+o+hVK4vvsVPTgTH6pWddNmaz+2GFySoFokNQSPD1rwnMbGl5fwHb23DF1i0WIqMVJEG/KLCmCzEG5qkAriFhZCmsgkFBFF4vhxMz9CB9VtrjycghSmBvfxoGj99y7VqTVLYnlIdsAyAj/mVPk4aVzsZIVKhnpbNKaLgF4Av90lEvbJhuJgrutA3hv1iEtj34PoUjWtlmR4QF75N448bdNYQxHB+Z2ptx9S1vD7HWMk+wBJuHTezQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(6666004)(7696005)(26005)(36756003)(1076003)(40460700003)(5660300002)(16526019)(8936002)(40480700001)(186003)(8676002)(86362001)(41300700001)(2616005)(356005)(4326008)(426003)(70586007)(47076005)(70206006)(336012)(81166007)(478600001)(110136005)(82740400003)(316002)(6636002)(36860700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:52.5716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfbbbe0-f548-4abc-a172-08db23648a3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To align with other IP blocks.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  9 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  7 ++++++
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ab85b85496f2..a407357cb153 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -478,11 +478,10 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!adev->gmc.xgmi.connected_to_cpu) {
-		adev->gmc.xgmi.ras = &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-		adev->gmc.xgmi.ras_if = &adev->gmc.xgmi.ras->ras_block.ras_comm;
-	}
+	/* xgmi ras block */
+	r = amdgpu_xgmi_ras_sw_init(adev);
+	if (r)
+		return r;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index fef1575cd0cf..3fe24348d199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1048,12 +1048,30 @@ struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops = {
 
 struct amdgpu_xgmi_ras xgmi_ras = {
 	.ras_block = {
-		.ras_comm = {
-			.name = "xgmi_wafl",
-			.block = AMDGPU_RAS_BLOCK__XGMI_WAFL,
-			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-		},
 		.hw_ops = &xgmi_ras_hw_ops,
 		.ras_late_init = amdgpu_xgmi_ras_late_init,
 	},
 };
+
+int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_xgmi_ras *ras;
+
+	if (!adev->gmc.xgmi.ras)
+		return 0;
+
+	ras = adev->gmc.xgmi.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register xgmi_wafl_pcs ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "xgmi_wafl_pcs");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__XGMI_WAFL;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->gmc.xgmi.ras_if = &ras->ras_block.ras_comm;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 30dcc1681b4e..86fbf56938f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -73,5 +73,6 @@ static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		adev->gmc.xgmi.hive_id &&
 		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
 }
+int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 67c2a5186b8a..2a8dc9b52c2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1381,6 +1381,12 @@ static void gmc_v9_0_set_mca_ras_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		adev->gmc.xgmi.ras = &xgmi_ras;
+}
+
 static int gmc_v9_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1404,6 +1410,7 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_gfxhub_funcs(adev);
 	gmc_v9_0_set_hdp_ras_funcs(adev);
 	gmc_v9_0_set_mca_ras_funcs(adev);
+	gmc_v9_0_set_xgmi_ras_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
-- 
2.17.1

