Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAFDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5746E8D9;
	Thu, 25 Nov 2021 10:58:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626106E8D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuEW571EDXYFKY5ZF+SqXlzxJkprlSM3Mo6MQVd2rr5wXV43KMl40nW3fOY0Fosmwv8VTOHq4UHWUTdoC6qzHr1DKvvT/TlPtdgd/DElO1WSZt9gj/Te+A0HxVGwm9xhH8XajYL1QdscH7HpLCsQ+vSByahv8nC0YqtFKso8GTORdHFT/th4un6arIdblckJnruS5HjCskvoVJ9UYUlAKuz+uwzOss25PkiJvgr9ivsxAXnSEDAW775Wb03/s9z7JykcMRi1cskvYgsbVxlm+DkovnhnyTJlk2FAqcfhzNYtWNycD84AjypbrhAi09XyM1TWHyGIB4sz41bRkSKIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUIE0AD95Af6Al4JUhfZXB+nUZWE+oIylnyYBw/d9ko=;
 b=LxYLkwqceNrDop6KFCI4uZJfvPCqVuKu1bgUzYDDNWJrG+oUcOYaB3QtV7OkFS8Lo5g61rd04tWHNQXGuOhKHNp26Hlg9zYNWRJHnP2KU0lhafkFJ5RV+oxYUR1B0PMa+KrgoKXlW6QkMcdHnYgjN0wdQuOSPlSXTqY82uCQcjV6UoX9DA+ZeEq8s6pJFXOG2R24uXeR8F7kvbCpLw7tq1pdDfSFs4qm8HD27TiqZnO5s+Cdl3uNM9KnvIljRPIeREQNghmbTkAw08kMg1ldVh2DlFwcCtlCOSpi5jdL6FoIkcSPvSSwrJAZP5hdDinLeXfvXyKaL1XKPPMmbhj1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUIE0AD95Af6Al4JUhfZXB+nUZWE+oIylnyYBw/d9ko=;
 b=2CSN1bSdCqlTbU6e/IAUXG1Fskcq+mml88TjD3UGtBOArlmL6WxpG+wQc3/Q2PDbIUX9+r0tS9PmRi7+/n7f8KT5I2xtnbv6X3JTH5Qa2dKSjF3elsyjsqzQ3jt0epUQi370tYlsl9BjgtdSg3X/MxPe+2BMWjkGOxhwGymw8Ss=
Received: from DM5PR07CA0138.namprd07.prod.outlook.com (2603:10b6:3:13e::28)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 10:58:51 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::ad) by DM5PR07CA0138.outlook.office365.com
 (2603:10b6:3:13e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 10:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:58:50 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:49 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amdgpu: Modify mca block to fit for the unified ras
 function pointers.
Date: Thu, 25 Nov 2021 18:56:57 +0800
Message-ID: <20211125105701.15860-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125105701.15860-1-YiPeng.Chai@amd.com>
References: <20211125105701.15860-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f83d2c-19e8-43ce-bfc5-08d9b0029075
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:
X-Microsoft-Antispam-PRVS: <MN2PR12MB422165DB7B22BE84C2CC19EFFC629@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bipPlt/OOlSnf5wf3oknAcjVDuLDm5h9cvtPrqI9rQ16ZrOk9E9inI1bPsXhm3Wzzi54wWeJ3acVSNlnaC2fMZJ6SRctGICWcTtu8XYrCACIBcVQINteMKErqOsRrV7CRnSrFsGfhMmAi/luyyxSrNfpVb9yuh52Y7uoKF3KKcfTsJUKUyZI/9TPo3oC0Vj4J9sOx6zoBwdwvVrnOu5Zpv5aZ1OjeTAUQo0wFNfMNOTm4aZLCWnL7Dl2BHl4rNT2kywPEZCteIiFiqpHcd3+M+lDVKhDBC0ObMVpu0A9noglqPq3SjQTAnlEfxvEgB/JGNythDPAkkY69+FTTnu6aoYUEONn5n6ant3f7kI/UwtsYFLPMbMpncsxSlPKlIMoiuxOvDawevCshAgCC38ck852LS7vo6qliNfWQN+nKwmgY7RwgbHrcAE/VmVStsyu1+NOQAaM7w2309q8A1QIoUMEZi/xvvNfNcGy0Ee/TjMx+9trqyciyfxcEGOqAK/xZjSq/+aCm2oGwS6yBt9azpzSC6RFCNn9SO4Pt5z4qeBPWIklkTU2J2+bhQdEXCIfzm6xd8VzMd3MawaeyOdpvxWh362HpliHD3Wz9sJ5ru5AnX0YZkiTYr4TLPmIs0+mcoDXBCx2EGTUcihnjDiLOxO5Gt8waKcxDOevRZtixzgre+vmUR1NRPb+L9zkm71Fqjd194YpVVuKeiPQ47isZv0oSJbe824Kq4RilplVHaD4JcviS5TN8uadBuedAfCn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(16526019)(83380400001)(6916009)(426003)(1076003)(47076005)(186003)(54906003)(2616005)(336012)(356005)(316002)(2906002)(8676002)(4326008)(70586007)(508600001)(36860700001)(81166007)(26005)(70206006)(8936002)(6666004)(5660300002)(86362001)(36756003)(82310400004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:58:50.8965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f83d2c-19e8-43ce-bfc5-08d9b0029075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify mca block ras functions to fit for the unified ras function pointers.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  8 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 30 +++++++++++++++----------
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 0aab31fce997..024342969267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -466,22 +466,22 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->mca.mp0.ras_funcs &&
-	    adev->mca.mp0.ras_funcs->ras_late_init) {
-		r = adev->mca.mp0.ras_funcs->ras_late_init(adev);
+	    adev->mca.mp0.ras_funcs->ops.ras_late_init) {
+		r = adev->mca.mp0.ras_funcs->ops.ras_late_init(adev);
 		if (r)
 			return r;
 	}
 
 	if (adev->mca.mp1.ras_funcs &&
-	    adev->mca.mp1.ras_funcs->ras_late_init) {
-		r = adev->mca.mp1.ras_funcs->ras_late_init(adev);
+	    adev->mca.mp1.ras_funcs->ops.ras_late_init) {
+		r = adev->mca.mp1.ras_funcs->ops.ras_late_init(adev);
 		if (r)
 			return r;
 	}
 
 	if (adev->mca.mpio.ras_funcs &&
-	    adev->mca.mpio.ras_funcs->ras_late_init) {
-		r = adev->mca.mpio.ras_funcs->ras_late_init(adev);
+	    adev->mca.mpio.ras_funcs->ops.ras_late_init) {
+		r = adev->mca.mpio.ras_funcs->ops.ras_late_init(adev);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index c74bc7177066..fbc3ebc81b99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -20,14 +20,10 @@
  */
 #ifndef __AMDGPU_MCA_H__
 #define __AMDGPU_MCA_H__
+#include "amdgpu_ras.h"
 
 struct amdgpu_mca_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*query_ras_error_address)(struct amdgpu_device *adev,
-					void *ras_error_status);
+	struct amdgpu_ras_block_ops ops;
 	uint32_t ras_block;
 	uint32_t ras_sub_block;
 	const char* sysfs_name;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a3b606c84d45..e7cd2de07665 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -870,18 +870,18 @@ void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
 	switch (ras_block->sub_block_index) {
 	case AMDGPU_RAS_MCA_BLOCK__MP0:
 		if (adev->mca.mp0.ras_funcs &&
-		    adev->mca.mp0.ras_funcs->query_ras_error_count)
-			adev->mca.mp0.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->mca.mp0.ras_funcs->ops.query_ras_error_count)
+			adev->mca.mp0.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_MCA_BLOCK__MP1:
 		if (adev->mca.mp1.ras_funcs &&
-		    adev->mca.mp1.ras_funcs->query_ras_error_count)
-			adev->mca.mp1.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->mca.mp1.ras_funcs->ops.query_ras_error_count)
+			adev->mca.mp1.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_MCA_BLOCK__MPIO:
 		if (adev->mca.mpio.ras_funcs &&
-		    adev->mca.mpio.ras_funcs->query_ras_error_count)
-			adev->mca.mpio.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->mca.mpio.ras_funcs->ops.query_ras_error_count)
+			adev->mca.mpio.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 8f7107d392af..dc2424587f12 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -48,10 +48,12 @@ static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_mca_ras_funcs mca_v3_0_mp0_ras_funcs = {
-	.ras_late_init = mca_v3_0_mp0_ras_late_init,
-	.ras_fini = mca_v3_0_mp0_ras_fini,
-	.query_ras_error_count = mca_v3_0_mp0_query_ras_error_count,
-	.query_ras_error_address = NULL,
+	.ops = {
+		.ras_late_init = mca_v3_0_mp0_ras_late_init,
+		.ras_fini = mca_v3_0_mp0_ras_fini,
+		.query_ras_error_count = mca_v3_0_mp0_query_ras_error_count,
+		.query_ras_error_address = NULL,
+	},
 	.ras_block = AMDGPU_RAS_BLOCK__MCA,
 	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MP0,
 	.sysfs_name = "mp0_err_count",
@@ -76,10 +78,12 @@ static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_mca_ras_funcs mca_v3_0_mp1_ras_funcs = {
-	.ras_late_init = mca_v3_0_mp1_ras_late_init,
-	.ras_fini = mca_v3_0_mp1_ras_fini,
-	.query_ras_error_count = mca_v3_0_mp1_query_ras_error_count,
-	.query_ras_error_address = NULL,
+	.ops = {
+		.ras_late_init = mca_v3_0_mp1_ras_late_init,
+		.ras_fini = mca_v3_0_mp1_ras_fini,
+		.query_ras_error_count = mca_v3_0_mp1_query_ras_error_count,
+		.query_ras_error_address = NULL,
+	},
 	.ras_block = AMDGPU_RAS_BLOCK__MCA,
 	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MP1,
 	.sysfs_name = "mp1_err_count",
@@ -104,10 +108,12 @@ static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_mca_ras_funcs mca_v3_0_mpio_ras_funcs = {
-	.ras_late_init = mca_v3_0_mpio_ras_late_init,
-	.ras_fini = mca_v3_0_mpio_ras_fini,
-	.query_ras_error_count = mca_v3_0_mpio_query_ras_error_count,
-	.query_ras_error_address = NULL,
+	.ops = {
+		.ras_late_init = mca_v3_0_mpio_ras_late_init,
+		.ras_fini = mca_v3_0_mpio_ras_fini,
+		.query_ras_error_count = mca_v3_0_mpio_query_ras_error_count,
+		.query_ras_error_address = NULL,
+	},
 	.ras_block = AMDGPU_RAS_BLOCK__MCA,
 	.ras_sub_block = AMDGPU_RAS_MCA_BLOCK__MPIO,
 	.sysfs_name = "mpio_err_count",
-- 
2.25.1

