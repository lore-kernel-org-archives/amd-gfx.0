Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13375C6FD1F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Mar 2023 01:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822FC10E45D;
	Mon, 13 Mar 2023 01:44:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC1110E45D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Mar 2023 01:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbj63kfFfIsWlgPLwSL8sIKuEZSc/do0pkXc1W/aV1UE9W6DnX1TToO7pSG01ma7EgMcSgBeaH8CGuHrFDY7QgNhvlYXuRpDhim3N/ArPccVsVFsqTZ+jjUJzp4BwwAzRJLghV2H2qrzjuyz3m/uwv69CjBXWXIuMEuz5YwNvaq4lskeEu0weom5xNCy6TZ6/hfYlICiT//c69Z0nS4sG8mnI1ynn/t8eqaLhuoVoxCx9Uvn2F+QK06tkw1B5CgqKofWVidxYt6t5/EFLvm2USCyCZXpKl+tkN9FOvYr81/wxQbFCR1zwkVttMnLxI+X0CYed/qGEd4E6BXyROXRwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEygw++GIqxZCbpjbBxcU/25wqk5smit0CAp3CeGd/I=;
 b=J4SM4VgYVAbr+hH0E+F0tjQsTAJnK94swds/e7B95B8LM8X6jyCVeBzIIrsFbWQTymGD8gnxydJ0pbeLLqhMMZZnkFSDJSYoDLXax0MGxFcAv8PglPpWL1kQzJXrPKTxGV6tFBnXKvkkmJvOAVc1oSzq+RVk/Cr3ritCegFr6Bk5435SyCh+p9vhNtB6v0Ip7GortfNcZy2zPGHJWlDBmQiM+vqIkK4IZkvr7yBXv7xzhyjOJyWGz2G9xdwRwLbaOSq7Uo/XI3PpMKliqS+CrIuhXx441k3zsoeNre8atK5ySoIFvoo4sdAdjNaJ3VUs3CjCB2RJfhL9fDGYR0P37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEygw++GIqxZCbpjbBxcU/25wqk5smit0CAp3CeGd/I=;
 b=Ia+vdU/ek0OQ6sWLpZ+j0eneHO2qc4umTRSvQS72PQ6KK0oBkpPB0CS2QknWJvVEJTQA6mJ3mxAALApnjsuULYs9wRvfDRHC0MPpG0A4IQlvZ4VW83dYaGvSCeMrd3jsW2LjXfGYVXq4CVKcTnW+ZfuVIKhmktzJX6O/XEtsG5A=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Mon, 13 Mar
 2023 01:44:34 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::56) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.25 via Frontend
 Transport; Mon, 13 Mar 2023 01:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.24 via Frontend Transport; Mon, 13 Mar 2023 01:44:32 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 12 Mar 2023 20:44:30 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 02/10] drm/amdgpu: Move vcn ras block init to ras sw_init
Date: Mon, 13 Mar 2023 09:43:55 +0800
Message-ID: <20230313014403.21903-3-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e73f62c-d2c3-409a-20e7-08db23647e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dODvmCgAOTIRYJ5LAdWtTyrkBmNA0lXYAkMeNgUlNUO1s+E2VJtDf7VV0zU/3r2a0H4aLD4wcmSvFBUOrSqYHjAP0n0peBsyj8MuC/PZJbgP3MYD281vSHD8lMSyRuKrlPtOzYNoeupcY2Ye6zNKRZ1XGSn7f4FygsBtWmBUhnVzZi+qRTLIyioZhhRy6mxqaQ6GEVQLDh7fVXs8jSgwjRn5CaTCf6W/zVGUCEIK1txfA/iXJbrtnNyOgsbKopAzLebERpdZhrPB/Bg7Cdf4M92qK9yUxrilct3P2QAboKCwP2r+f6ASUBFgZ4xYY4kRztrX1ZuOuX/8ai5lXIOaPO8wpg0n6E6IJVx/spV+9eQGXBVqo7RNLa4veCUreiuEgaSKwbSwc//BOKh1mJIVURZvmSmaanvZVAIhQ2T1AaCFvtPFPAH1vmw5lOgNj9VdWD1zV69IbEAqAYmWiG5PwKeXGXqdN2hH8an33pTsWdc3DMG7PTe7kRxEK/q/oe98NcaR8BaLlOODGK4a5p37BQKbdZOmrMyQmLz8/PyvYWdPIqYMcrh7OZ1xD7Uxo+lHFK4WjMx13+as9QlX0AzdUtl08GqMg9YksfRs2lBMdfS2Tzjm6KOY6cBRCwvivIUoVTMVQBGe+tkm80dklty2HxOqdX2g4zYKqd4pohXvku53DWuhp+ySPMcAlC0yMQ6SnrPyndco4V558XxQEOweVWz/2HIxblmLA5oQj7TwuY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(356005)(36756003)(86362001)(82740400003)(81166007)(36860700001)(40460700003)(2906002)(4326008)(5660300002)(41300700001)(8936002)(40480700001)(82310400005)(8676002)(1076003)(26005)(16526019)(336012)(186003)(2616005)(6636002)(83380400001)(47076005)(478600001)(316002)(426003)(110136005)(70206006)(70586007)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 01:44:32.9271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e73f62c-d2c3-409a-20e7-08db23647e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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

Initialize vcn ras block only when vcn ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_int.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 29 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  6 +++--
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 02d428ddf2f8..8664a5301b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1158,19 +1158,28 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_vcn_set_ras_funcs(struct amdgpu_device *adev)
+int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 {
+	int err;
+	struct amdgpu_vcn_ras *ras;
+
 	if (!adev->vcn.ras)
-		return;
+		return 0;
 
-	amdgpu_ras_register_ras_block(adev, &adev->vcn.ras->ras_block);
+	ras = adev->vcn.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register vcn ras block!\n");
+		return err;
+	}
 
-	strcpy(adev->vcn.ras->ras_block.ras_comm.name, "vcn");
-	adev->vcn.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
-	adev->vcn.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
-	adev->vcn.ras_if = &adev->vcn.ras->ras_block.ras_comm;
+	strcpy(ras->ras_block.ras_comm.name, "vcn");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+	adev->vcn.ras_if = &ras->ras_block.ras_comm;
 
-	/* If don't define special ras_late_init function, use default ras_late_init */
-	if (!adev->vcn.ras->ras_block.ras_late_init)
-		adev->vcn.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d3e2af902907..c730949ece7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -400,6 +400,6 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
 int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 			struct amdgpu_irq_src *source,
 			struct amdgpu_iv_entry *entry);
-void amdgpu_vcn_set_ras_funcs(struct amdgpu_device *adev);
+int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b0b0e69c6a94..223e7dfe4618 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -225,6 +225,10 @@ static int vcn_v2_5_sw_init(void *handle)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
 
+	r = amdgpu_vcn_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -2031,6 +2035,4 @@ static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	amdgpu_vcn_set_ras_funcs(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 43d587404c3e..720ab36f9c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -181,6 +181,10 @@ static int vcn_v4_0_sw_init(void *handle)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
 
+	r = amdgpu_vcn_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -2123,6 +2127,4 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	amdgpu_vcn_set_ras_funcs(adev);
 }
-- 
2.17.1

