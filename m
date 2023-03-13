Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9944EC6FD1F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E0910E458;
	Mon, 13 Mar 2023 01:44:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9627210E458
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKP0BbhrP7tSrmyrCzCPu/QlHCcicgE8mjvL3Uu9LhSCOtMHSfRCfedXF4yMC6ry49YbjdjRqApnegmfTCsxBX/nSdqs0K0HFxTjsvdThMBAlAFywjjoyCSsgx9XRIQb4wKJKU1ApKK+sCQeipvq0EqCTTgGkvpTNkx2FhyUdM2FTjWKCfx1OSmsndTJMOU07IyT0ZRJ1hnYzOhpdOr2tFnyH31uNiNfYJeQ3uhrhSJvj9Wt7IVOszwfq8eg7SGOGQVRNOmw9yhG6tThtDPQ2R9zzw+sMZhLbpthvPeMJOCfVm/MkjKXFg7+Ta8MIhEy0bY8uU1cGYs85GaDSJEauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBwIVtbZyatPTwigW+MoX0aOXCuWGomttG/08uu34cQ=;
 b=FP4Fc5zHdV0Yuw4igkcFPkOaCvVbbnNwQlodcjiIdVyM5W/vOIgPuXf7g1yfJEvKQlCjAV1vGW5TXrqkDMP3gz40zyeVHaFBRx2FGrFRIw5LwbXXOjxXz+LAKN1pMex6AvLAQUzayF7nbq3/KNNOcG1YexE+G3EpSzX7PTCK6G/U2LUmj5ZG7Ngh3x3zEn2pJjeX6yPBsHc8mIdFIEe2sSVCbL39aE1j9i/yLsczfDqdVqlIywEVYUhBTFEenlBY8VDSB5OaZwB5yN28C1uOIT7ZWKR0SHSzh7Ovycz+EpwZZed5K9FOxEqz6ZtL4jNPB3cIiKlGZn+nKpW7TY7Vfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBwIVtbZyatPTwigW+MoX0aOXCuWGomttG/08uu34cQ=;
 b=LnO6dM+FakV1wzyLvh4MhXHCDS5tg7PCZFH8n0Lz38KtIOBvKKjRQ8akv/ieWWY86qqdIj5zllWT6FYIBv3L+0noSH/0wVFCSWq6cH/neMSNF/zwBFnHJhuGTebrti2ht4TeWYVnocXMqFGttad0Y5qP9cvHvI3JCwskObTsW/g=
Received: from BN0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:408:ea::26)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 01:44:30 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::e6) by BN0PR04CA0081.outlook.office365.com
 (2603:10b6:408:ea::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:29 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:27 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 01/10] drm/amdgpu: Move jpeg ras block init to ras sw_init
Date: Mon, 13 Mar 2023 09:43:54 +0800
Message-ID: <20230313014403.21903-2-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|DM4PR12MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: d814e64f-dec5-4035-0cb5-08db23647c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mR7uzZJGdpbQtfNyp+nFBZq9AhHjeXhBCQYy4dzGfm6Evn1OQwHCWVfZTEQhnSunmdO9oe7dtsGkc+gxCAbtPe2kMc+Q1MVw6Uo+O57egE+YVeaN5+bBUUHUfMh/ghDb6YHbVMZO3tRZ0bnJeHjrn/VIGYC19ekSDiQP8/n1an2tYOhko3EqT3t+nXQT2K+NdIuKWwL6xbQqlXky9QXlG1Q5ZR8v818pFyS+Lmh6xMJl+tQLSAs4HHbSBSJSV81au4VL+hWoNmC0q6biMEP8C4HCfbDlqHDdtTP/ufVhwV4YaD/xRIYWYitXoLiBMduAzgD6glXhQnhnpssf8gUv0ls28zt8oBzEdJs3uIBot4Xi70uz0QKCYSP4YgUEwQi2LMU2iZY50o5Fs22d5/U2Q7tSwnNlh/YHBscu6crGAdt2BA63oPboDTl/TOoOTLqyZL1SY7pRW+kMZxoiNQTGIjfOEtOe7HYqm9EBorUg/hCyeVt/cWwUSahIgjbL9+bE85vX3NJ26dbqSpFAE1pmnBoq/N76LOSlLfnjp7CEBcypZkblU7ZQuxrr0JhK4XKU2wAc/Ns4XHsdeqIBpvL+dXt5gyfxoIRomKrWUI7V84cRTH7XWLWEb7hVqGQfkMLdG8768Kd5TrQEUe1+OSqLHlyh76MnenkUcf7Nu22a2pka+zZA6EmOrpPfJirEdEWTxJUpw3ms6NvSjdTnRC5PtmL9wi7GANxrkbtxnUZIPE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(46966006)(36840700001)(40470700004)(336012)(2616005)(186003)(16526019)(1076003)(26005)(8936002)(83380400001)(6666004)(82310400005)(36860700001)(356005)(82740400003)(81166007)(426003)(47076005)(5660300002)(8676002)(40480700001)(40460700003)(4326008)(70586007)(2906002)(7696005)(70206006)(41300700001)(478600001)(316002)(110136005)(36756003)(86362001)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:29.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d814e64f-dec5-4035-0cb5-08db23647c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
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

Initialize jpeg ras block only when jpeg ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_int.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 29 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++--
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 8f472517d181..74695161cf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -235,19 +235,28 @@ int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-void jpeg_set_ras_funcs(struct amdgpu_device *adev)
+int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 {
+	int err;
+	struct amdgpu_jpeg_ras *ras;
+
 	if (!adev->jpeg.ras)
-		return;
+		return 0;
 
-	amdgpu_ras_register_ras_block(adev, &adev->jpeg.ras->ras_block);
+	ras = adev->jpeg.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register jpeg ras block!\n");
+		return err;
+	}
 
-	strcpy(adev->jpeg.ras->ras_block.ras_comm.name, "jpeg");
-	adev->jpeg.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
-	adev->jpeg.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
-	adev->jpeg.ras_if = &adev->jpeg.ras->ras_block.ras_comm;
+	strcpy(ras->ras_block.ras_comm.name, "jpeg");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+	adev->jpeg.ras_if = &ras->ras_block.ras_comm;
 
-	/* If don't define special ras_late_init function, use default ras_late_init */
-	if (!adev->jpeg.ras->ras_block.ras_late_init)
-		adev->jpeg.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index e8ca3e32ad52..0ca76f0f23e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -72,6 +72,6 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
-void jpeg_set_ras_funcs(struct amdgpu_device *adev);
+int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f2b743a93915..6b1887808782 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -138,6 +138,10 @@ static int jpeg_v2_5_sw_init(void *handle)
 		adev->jpeg.inst[i].external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_PITCH);
 	}
 
+	r = amdgpu_jpeg_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -806,6 +810,4 @@ static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	jpeg_set_ras_funcs(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3beb731b2ce5..3129094baccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -113,6 +113,10 @@ static int jpeg_v4_0_sw_init(void *handle)
 	adev->jpeg.internal.jpeg_pitch = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
+	r = amdgpu_jpeg_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -685,6 +689,4 @@ static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	jpeg_set_ras_funcs(adev);
 }
-- 
2.17.1

