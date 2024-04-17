Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE749C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 03:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DD51130B1;
	Wed, 17 Apr 2024 03:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dXGiexsL";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068E71130B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 03:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5ZMV6bn5ME+FauIVsXtiS9RPQ6rZp0I+YA0ysRXVNElFWr1jEWOMXcvW3poDl0VlQyFYsCPO+e5CsyWfdmbHI8lTTv5LZczYMDz1q0XuJIO+viNGMrWu2rU3HPD1oiAuaAUP0Yk2RXBUlCwdwpvzNzzGJql7BY9l0HsZS+j68TVh8IVQIoWGCFtpjFMNNx41/9COGHedyx5nEWr2nPL82gLPm3y6WItP82fxPV3LTiA/hAzemyvP4TsruZN9RQ+iYdXFJvuFjmK6shs5i+z5Pvh2XrCVrLUufsoyYrRmTnJD6ND7Cy57lv7FGr6TBsfKa74FCuaoaQS6+qj8g4Fag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SABgNE3PotHZ9PEw4jzgFXNdnEWicvU+Tw7K1RrWJDU=;
 b=gO0ig0+NYCxAdA0tleJy5cMX3fS87tsB2LOogDfZ63U1IzGlo5UZUoh2tMm9Ri3QdyJfFkaCO3Gw+zb74LJPHfNRZeEU+xW9CaN+CMxUfki3elGWOzPSmOUC11TNDbjiJgFi9Vl9ECATZMl2nMCGv3M10Zyog4B/po5L8HaVOdPsb23IiRj4uF/SF6jShDFPL8aqeToK6TJD08EXkiNev0vHuKtKonV5hq+XkLc3ZFHcnFF3pq3pxrrgtcBK7LOYMAGrgWci6H6vUWA/7Txq3ZcrB/WmW66fjnTsc5uNBC2s7u1V7yU3ddYq/YRPV8XeTX1Zxn5pJujEPXAAVnhaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SABgNE3PotHZ9PEw4jzgFXNdnEWicvU+Tw7K1RrWJDU=;
 b=dXGiexsLS6xVPs7tiwQvTIWhr8HDBhUDlTRwQdvYay43JvTDaOMwKNPQzTdNI7ZvyTl4w7aY4+dVZRfRhn3qZT1hM3pBykQ7QWqj5A6TI7Ty0/0w5w2Zg5u/uwT7/PZC30GenHO74OmVuMw0t86IK0htT7YCNZLNbsC8ubithSo=
Received: from DS7PR05CA0022.namprd05.prod.outlook.com (2603:10b6:5:3b9::27)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 03:10:36 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ce) by DS7PR05CA0022.outlook.office365.com
 (2603:10b6:5:3b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Wed, 17 Apr 2024 03:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 03:10:36 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 22:10:34 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: add ACA error query support for umc_v12_0
Date: Wed, 17 Apr 2024 11:10:03 +0800
Message-ID: <20240417031003.1251031-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b334a55-9453-4c15-9ba5-08dc5e8bf3dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLJUq+PJHxNTv53u8B1XvM26MtYF7OKuOgtas6DLEHNsb1hRg3rbpYl+WgtHHsJMM45cOnH2E+Fuyc55O+xVpU4bFRLDVOjWUr4V5fAp9o2sKGZUcHf6aT3DJZDllv+Jxg0ileVtVUuBn4RRPABZs+kjqQI95sVemUkvC5RD1bo1rTKuQZ+aKUIRjMUfphkG6USoXzoXUwLzjg4Q9hEExJDdoj67cQPd67J3hD/mtAbXsGkLFpyztSz+R2DV/0Dm6CPkKHrAbf9ootAqeYmk+bHS6jvsAEbBmK1KnvOge/6/YWuVWCuB8YfeftTylbJTEM+QpVorPNJn3iRasu46GNV2pOJ0hHwb1/sqYC23nHMc2fL4S9mbGSPOZ8xKQzgwuWWFULlZrW0U6X6JcxPEMyh6HLBj26vrjUjwqR5fXut4wHZtP2NAvZsYnyaIToInKkiOU4qGHPEtPHL5wFbIdhYM5ZOFzzBiMnd5vL1wD+OasWcpVupUXH1lmY/NEts6JO4+meui+X57D5aQqwkoudRPLOzV7B2LqlRL6aktAzu+Hz+rZK8kGGB3e2ZW83apouOHs5llItnBmf5raj7/3Mp/LQGnr65V4ePdE0aVY9AYrF85InM+gzGAqRu3635vEbEUR38FrNS2ODLHozsjRGzQNM0H1NPJmQQqJdVBmB3TwtOKJ7t49F4syDvSuVM/C88oxXW3O+DEsFpmfKqRNoy343NoRdfgesckIz61HX43JYtBbhQujo9LLkdbkBwW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:10:36.3994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b334a55-9453-4c15-9ba5-08dc5e8bf3dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add ACA error query support for umc_v12_0.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 18 ++++++++++++++----
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 352ce16a0963..46b7f0c5cd8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1268,9 +1268,9 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 	return 0;
 }
 
-static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
-					 enum aca_error_type type, struct ras_err_data *err_data,
-					 struct ras_query_context *qctx)
+int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+				  enum aca_error_type type, struct ras_err_data *err_data,
+				  struct ras_query_context *qctx)
 {
 	struct ras_manager *obj;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 8d26989c75c8..487548879c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -898,6 +898,10 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block blk)
 ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
 				  struct aca_handle *handle, char *buf, void *data);
 
+int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu_ras_block blk,
+				  enum aca_error_type type, struct ras_err_data *err_data,
+				  struct ras_query_context *qctx);
+
 void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info,
 			struct ras_err_addr *err_addr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index f69871902233..9f2c46814a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -317,16 +317,26 @@ static int umc_v12_0_err_cnt_init_per_channel(struct amdgpu_device *adev,
 static void umc_v12_0_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 					void *ras_error_status)
 {
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct ras_query_context qctx;
 
 	memset(&qctx, 0, sizeof(qctx));
 	qctx.event_id = amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr_triggered() ?
 						    RAS_EVENT_TYPE_ISR : RAS_EVENT_TYPE_INVALID);
 
-	amdgpu_mca_smu_log_ras_error(adev,
-		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status, &qctx);
-	amdgpu_mca_smu_log_ras_error(adev,
-		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status, &qctx);
+	if (amdgpu_aca_is_enabled(adev)) {
+		amdgpu_aca_get_error_data(adev, AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_CE,
+					  err_data, &qctx);
+		amdgpu_aca_get_error_data(adev, AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_UE,
+					  err_data, &qctx);
+		amdgpu_aca_get_error_data(adev, AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_DEFERRED,
+					  err_data, &qctx);
+	} else {
+		amdgpu_mca_smu_log_ras_error(adev, AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE,
+					     err_data, &qctx);
+		amdgpu_mca_smu_log_ras_error(adev, AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE,
+					     err_data, &qctx);
+	}
 }
 
 static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
-- 
2.34.1

