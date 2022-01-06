Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE9EC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 05:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4488C1122C4;
	Thu,  6 Jan 2022 05:57:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17601122C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 05:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8BQyOAY7zq06r5SoWuD7xUU9h+8D17+PEHybxC5WKau7TR4ILy1zbyBZPoljSMVGThrvaJ8Ue+eRxul4QQd/TMPIM9Hd94hBWF1ZXHcDFWhJB2sl+QTfGdJUVcunsrdtYsPH+WJI70T32No5SxGCdFD0bsLCdk5GCDxUOxyCHGotL8+XUdUYsY3Ll8gsWBnFYW1TykZ4GgOSOtD6f0mgQH6woRI/Zkj00u7YzJqH44Q5ldkNHvu/dwD7PMS85Kj3pezPM8htw4aMDoDwWhZgAn8QsSzV4pmKXLAZEm/HbPhSMCA5HhzV7KVUb4iytDvWFMrExu6D25LxBUMgWKgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxNNgW9gLk+KKv/LIAor9pIK9VtI2vQAttCs/ih9GfE=;
 b=PEodPAa0zGEdt6JKgt4A3GVTnzd8lZ+QwBZVfQ7jx/+4pm2jrxH1VCEsD13mwDdbPrJsN5GIwJXqeQSKps1n7rEAH9xhl2dv5TKlFPdSueOcZB16CLj0aGBz8M+6uRCyFIbdCo/dpVSUbfj5ssE1rJFSnUwK4Q7nDeX/TYyz27rp9JqUc1Z+SExQP8CEFRdgLuzkz2RSXcJx3d+jxlXqI7kH2uJRLxXCfvvbuFxWCiAvE3LuzDLVsu37eCk0uf2ZqglgDr2N9WUiC6ijJPW0JgwhWhrPVX2XBnsWvlSVE2wjLb+KLGC4pRMW8WP2qKkVtPNEcmiWz/Ridke9obedmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxNNgW9gLk+KKv/LIAor9pIK9VtI2vQAttCs/ih9GfE=;
 b=Glt6S/jXvs15rIWlQWzUxiCw5ykKTCruQcS0OsxaC8CElvp96R40T5HN8eiq17gXM3YlCsfvXtU360aVqR78IRSL6BPZ5fl4op9bDjiBACnFaAOSkQQeBeAIDLZzI79UkWVXbDQG8qpcsOJ8vPcaLg4WPz9K56t2H/R62jGkuM8=
Received: from BN0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:408:142::25)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 05:57:54 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::d0) by BN0PR08CA0027.outlook.office365.com
 (2603:10b6:408:142::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Thu, 6 Jan 2022 05:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 05:57:54 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 23:57:52 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
Date: Thu, 6 Jan 2022 13:57:27 +0800
Message-ID: <20220106055732.3073780-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220106055732.3073780-1-evan.quan@amd.com>
References: <20220106055732.3073780-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58f849e8-b38e-4845-583c-08d9d0d97b58
X-MS-TrafficTypeDiagnostic: PH0PR12MB5417:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB541759CDD28EA462363762DFE44C9@PH0PR12MB5417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipq//RfNUzmluQSWYnx4IJuf0galfjLGXiGaGhtWywbI+5h6WXeFZLWzHlWxg5Gf4RWRsac+RTOfkQRpg83kyMOm5RceFxWsH5cDmALx5YY3H7FVGfuIRc1qzNC4FkY3fbFjlg9auIdGsFfFJ95e4wAQBLTlzNjdUf6UtZzUS4RkWRFBV4zIt/oWQ6tjBLXmBrjT15IunW80GJOfAl//60Qqg9JC9VLux82iizMntBqoCpPc7SkiH+narQfSIUuLmpmOtSsBxzE41r3itRiXZDRhCieI44hGS9tI+9qiZnVT98elWIvggmd1lzF1uSsjTaO2/j6Nxvm+fv+SJvNvSAgxj3/6y28QH78lyMs86zZdrQuxaJx8lLDuOiJy4iQH0zvHfl4A47X10pKWeatQcprvUwCBcK7VsrB3HqlFg+vJtv29t1g8fhmEMBVFAzcEqrbufXR53jy4JZ0j/vuzcPNe2AYaYRyk8e3D0w9du80Pt308y17RVcDPYSCfDWa28Z9s/tnjPcjfXGqqSuSdsggMEIgpIDg7VB7VGQSMNdWTW00AHZfJbLrCvknfPSeHYc1Xtjyd0vcUDz+3g0A33ikjc6TaKLfB00LEBknNbK3DUc5vqYCE7FusCj/dHuKdINiTR8x4yU24IRLqmuDikQ/KxJleHDTX7mLEglOQlFacWgtXdYAv+4HwtQIt3TCgEc/v8zDklK2UHGsK1iAVGl4W0/n81a9UZRSScEsJ7Lnk9/aguNyWqlJdrBQaQYuAagwuybj4VvdamauafrEDWVUHbLE4NefOotsIruUTBqo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(70206006)(70586007)(336012)(44832011)(40460700001)(356005)(82310400004)(83380400001)(426003)(316002)(6916009)(36860700001)(6666004)(2616005)(1076003)(8936002)(8676002)(508600001)(36756003)(26005)(186003)(16526019)(7696005)(5660300002)(4326008)(47076005)(2906002)(81166007)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 05:57:54.5035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f849e8-b38e-4845-583c-08d9d0d97b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As those related APIs are already protected by adev->pm.mutex.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I762fab96bb1c034c153b029f939ec6e498460007
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 56 +++----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 -
 2 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ae91ef2078bf..ecbc768dfe2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -158,8 +158,8 @@ static u32 smu_get_sclk(void *handle, bool low)
 	return clk_freq * 100;
 }
 
-static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
-					 bool enable)
+static int smu_dpm_set_vcn_enable(struct smu_context *smu,
+				  bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -178,24 +178,8 @@ static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
-{
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int ret = 0;
-
-	mutex_lock(&power_gate->vcn_gate_lock);
-
-	ret = smu_dpm_set_vcn_enable_locked(smu, enable);
-
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
-	return ret;
-}
-
-static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
-					  bool enable)
+static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
+				   bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -214,22 +198,6 @@ static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
-				   bool enable)
-{
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int ret = 0;
-
-	mutex_lock(&power_gate->jpeg_gate_lock);
-
-	ret = smu_dpm_set_jpeg_enable_locked(smu, enable);
-
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-
-	return ret;
-}
-
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -619,17 +587,14 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
-	mutex_lock(&power_gate->vcn_gate_lock);
-	mutex_lock(&power_gate->jpeg_gate_lock);
-
 	vcn_gate = atomic_read(&power_gate->vcn_gated);
 	jpeg_gate = atomic_read(&power_gate->jpeg_gated);
 
-	ret = smu_dpm_set_vcn_enable_locked(smu, true);
+	ret = smu_dpm_set_vcn_enable(smu, true);
 	if (ret)
 		goto err0_out;
 
-	ret = smu_dpm_set_jpeg_enable_locked(smu, true);
+	ret = smu_dpm_set_jpeg_enable(smu, true);
 	if (ret)
 		goto err1_out;
 
@@ -638,13 +603,10 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 		dev_err(smu->adev->dev,
 			"Failed to setup default dpm clock tables!\n");
 
-	smu_dpm_set_jpeg_enable_locked(smu, !jpeg_gate);
+	smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
 err1_out:
-	smu_dpm_set_vcn_enable_locked(smu, !vcn_gate);
+	smu_dpm_set_vcn_enable(smu, !vcn_gate);
 err0_out:
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
 	return ret;
 }
 
@@ -1006,8 +968,6 @@ static int smu_sw_init(void *handle)
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
-	mutex_init(&smu->smu_power.power_gate.vcn_gate_lock);
-	mutex_init(&smu->smu_power.power_gate.jpeg_gate_lock);
 
 	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 00760f3c6da5..c3efe4fea5e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -376,8 +376,6 @@ struct smu_power_gate {
 	bool vce_gated;
 	atomic_t vcn_gated;
 	atomic_t jpeg_gated;
-	struct mutex vcn_gate_lock;
-	struct mutex jpeg_gate_lock;
 };
 
 struct smu_power_context {
-- 
2.29.0

