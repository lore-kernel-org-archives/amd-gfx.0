Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F45C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D8310E3BD;
	Wed, 29 Dec 2021 06:33:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E86B10E3BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1r+lrgJHotWBZ7nxRsi93jvEKIJ1pCouP+8hl2ZReuI/zxvbP+4CZlyC4xOq9bvFFRZpwB0KIpCz1QD7sIJbDt6ozzBf9y3WWarZA45TG0t7v4VRdYaZsUQXzunHK0r90U3DG9IdqKAETHzx9vtiye+hXd3Y9o5ffcE9appSBtrL1ZVGFHdjg6Vs3N0wrlrW+Jq273iVCWG79irVVY1aC8Gh/2YImMAxvWH9zpkvblvQRJYWUwaoEtpj3hBQ6r471k6Km32OYBoeKAplc+it7GynaoDZPl9Sx+TqM6eoEZHTPyuI+Fb/PMZScTqarfNLaIABKl3U9R07uNe51CRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ0s31KckGYGc4hV2M1TO+pQl9//2cWcQqhCr2qkBA8=;
 b=D+u3w4yStFYfrl6W/jx1xFhpP8uK67jqoXx2hMEPtadnEgPk3zG8Q6RbMxF8echYd2JOhKoMKoT2s8fWT2H56tGMyV3FB/dTdvxI0d5NjMK8s5ExZjEh24+SLCZsAdXpvKc8RBjpnVZgAIlzGWCap03z9/LLdejrg0fxQE2JeNNBhzT/ywU8m4+l5T9Np5UBC7ac5B7bMx30Sf6CpCfiFmQ06fa4GTH0mEQ8CvdAju5DCdsfDNCmJuoSzmXp4CVuza6cULzPGg401N0vYSyfVz2+Vk9fXG3ayTT4i428cEHLd0LHUguYrJTINeCZymG6iM4VKcCqBq/D9GJRCROjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ0s31KckGYGc4hV2M1TO+pQl9//2cWcQqhCr2qkBA8=;
 b=KA4pE1qFRZv8gw1XMyT827gRnHxsTS9QoIDSwZhWFFnc3x+ij53zsE9AbepaBXBrtPQOFkM+gwU69J84c8Y0LCSDoh2hTlXFce2xwCxfHDITuPd5qyhY3nYUP3+ATswXKCCZztpQwYoGUoSmzV+LPZLGk8p/IU3F/vt+mfbSsa8=
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by MW3PR12MB4586.namprd12.prod.outlook.com (2603:10b6:303:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 06:33:01 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::a3) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Wed, 29 Dec 2021 06:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:33:00 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:32:58 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 05/12] drm/amdgpu: Modify hdp block to fit for the unified
 ras block data and ops
Date: Wed, 29 Dec 2021 14:32:04 +0800
Message-ID: <20211229063211.43840-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55c6ebf3-d41e-4f37-4435-08d9ca950f98
X-MS-TrafficTypeDiagnostic: MW3PR12MB4586:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4586C22533ABF985AAD8A922FC449@MW3PR12MB4586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:339;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLbZ6QoAbtqJGZIMp76ZV5PmJfGJvUvem3FQsBjr3LeCCM4AiQYIbhH/nlayFMc/4uQnzlNcV0tC8ERDabUcocG8hOVOTsSE+4ryVTXhkYPtUQKh2oLdyZwwAxw1UBvVfni7VSxCuBA7/A5DGJ5PrbbtKRnmtGNElJJjuJDHEqCwqrPiBDvAibRx8XWzvaMHWzWpM6VEBjk8lpOEjXBOGUsZiDk2ywbWRrl16IoS5gpe0FwhIX02ba7s/fAITxirPvOfQsDIut0GQR6KlB0q5LXeJMfetDbWpky7HuBABbHmDwKeNkc4iIYgggjTKx8Tw8Xdb2w/ki/RS4AwMhyhZHFYOEIONr+qk3ZovdqOKYO7eBHEOujU7QTur4mz/5ZIZ5vcGvbCvUghl6bChccTXEfQNaV5PEaLBjbkrS1RjcXbqTf8XtAQALixUTvnhBBXyHMsNgrcwM2gh9cpPMeWK0ILdPSVijn5aphpoVtQbUG2Jkr85sOFs/FUT/othOESJR8E4iTuMYgv7brfo1PxGDTUI1ju/3HMpr6ffq27BgVVlnP5mzo6pvb/sekzWo7jClY6Zui1QbbWkQfqrZqodd93cKpVRuK66jFWUFSU9H5hXZyDXCccpt9bQ2mhNnHFuNcglaYJYNtlMwBOTP3Zm9ZeWMpL3qOX6r5iWAUXFDdbqSRMal4acz+PqfVJcnpbp8gfKXO+FQgOXUfPIMgjf7tN3osFVRcCPEJQfnIyieuDCjQuh6b66MsovsOWZhlOUmfiIjqPXywoapby+6uS4VRXE5qgnqGR5N9mEisM7PPko2qHr7IteQZbWGfWlrUpbK3yRKaUJyHmIC0QS1LaW3Jthg84P6lcUaizVqGTclMmsHrpm03suYI1n4Lrc6B5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(186003)(47076005)(70206006)(4326008)(8936002)(426003)(70586007)(8676002)(36860700001)(2906002)(16526019)(336012)(2616005)(81166007)(356005)(83380400001)(26005)(36756003)(6916009)(6666004)(316002)(40460700001)(7696005)(86362001)(82310400004)(54906003)(1076003)(508600001)(5660300002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:33:00.8639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c6ebf3-d41e-4f37-4435-08d9ca950f98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4586
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify hdp block to fit for the unified ras block data and ops.
2.Change amdgpu_hdp_ras_funcs to amdgpu_hdp_ras, and the corresponding variable name remove _funcs suffix.
3.Remove the const flag of hdp ras variable so that hdp ras block can be able to be inserted into amdgpu device ras block link list.
4.Invoke amdgpu_ras_register_ras_block function to register hdp ras block into amdgpu device ras block link list.
5.Remove the redundant code about hdp in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h | 13 +++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h   |  2 +-
 7 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index af65ec46f783..b8902ad7e375 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -459,9 +459,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (adev->hdp.ras_funcs &&
-	    adev->hdp.ras_funcs->ras_late_init) {
-		r = adev->hdp.ras_funcs->ras_late_init(adev);
+	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_late_init) {
+		r = adev->hdp.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
 			return r;
 	}
@@ -503,9 +502,8 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
 		adev->gmc.xgmi.ras->ras_block.ras_fini(adev);
 
-	if (adev->hdp.ras_funcs &&
-	    adev->hdp.ras_funcs->ras_fini)
-		adev->hdp.ras_funcs->ras_fini(adev);
+	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_fini)
+		adev->hdp.ras->ras_block.ras_fini(adev);
 }
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 1d50d534d77c..5e6b57de3e1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -24,7 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev)
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
 	struct ras_ih_if ih_info = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7ec99d591584..c94a4b3c8d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -22,13 +22,10 @@
  */
 #ifndef __AMDGPU_HDP_H__
 #define __AMDGPU_HDP_H__
+#include "amdgpu_ras.h"
 
-struct amdgpu_hdp_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+struct amdgpu_hdp_ras{
+	struct amdgpu_ras_block_object ras_block;
 };
 
 struct amdgpu_hdp_funcs {
@@ -43,9 +40,9 @@ struct amdgpu_hdp_funcs {
 struct amdgpu_hdp {
 	struct ras_common_if			*ras_if;
 	const struct amdgpu_hdp_funcs		*funcs;
-	const struct amdgpu_hdp_ras_funcs	*ras_funcs;
+	struct amdgpu_hdp_ras 	*ras;
 };
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev);
+int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, void *ras_info);
 void amdgpu_hdp_ras_fini(struct amdgpu_device *adev);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8b0d11bb8186..ecb35d9994ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -982,6 +982,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
+	case AMDGPU_RAS_BLOCK__HDP:
 		if (!block_obj || !block_obj->hw_ops)	{
 			dev_info(adev->dev, "%s doesn't config ras function \n",
 				get_ras_block_str(&info->head));
@@ -990,11 +991,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		if (block_obj->hw_ops->query_ras_error_count)
 			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
 		break;
-	case AMDGPU_RAS_BLOCK__HDP:
-		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->query_ras_error_count)
-			adev->hdp.ras_funcs->query_ras_error_count(adev, &err_data);
-		break;
 	case AMDGPU_RAS_BLOCK__MCA:
 		amdgpu_ras_mca_query_error_status(adev, &info->head, &err_data);
 		break;
@@ -1088,9 +1084,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 			adev->sdma.funcs->reset_ras_error_count(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__HDP:
-		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->reset_ras_error_count)
-			adev->hdp.ras_funcs->reset_ras_error_count(adev);
+		if (!block_obj || !block_obj->hw_ops)	{
+			dev_info(adev->dev, "%s doesn't config ras function \n", ras_block_str(block));
+			return -EINVAL;
+		}
+
+		if (block_obj->hw_ops->reset_ras_error_count)
+			block_obj->hw_ops->reset_ras_error_count(adev);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3606d2cbff5e..22ea77817dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1223,7 +1223,8 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 {
-	adev->hdp.ras_funcs = &hdp_v4_0_ras_funcs;
+	adev->hdp.ras = &hdp_v4_0_ras;
+	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
 }
 
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
@@ -1300,9 +1301,9 @@ static int gmc_v9_0_late_init(void *handle)
 		    adev->mmhub.ras_funcs->reset_ras_error_count)
 			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
 
-		if (adev->hdp.ras_funcs &&
-		    adev->hdp.ras_funcs->reset_ras_error_count)
-			adev->hdp.ras_funcs->reset_ras_error_count(adev);
+		if (adev->hdp.ras && adev->hdp.ras->ras_block.hw_ops &&
+		    adev->hdp.ras->ras_block.hw_ops->reset_ras_error_count)
+			adev->hdp.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 	}
 
 	r = amdgpu_gmc_ras_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 74b90cc2bf48..903bd8f1443e 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -149,13 +149,21 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
 }
 
-const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs = {
-	.ras_late_init = amdgpu_hdp_ras_late_init,
-	.ras_fini = amdgpu_hdp_ras_fini,
+struct amdgpu_ras_block_hw_ops hdp_v4_0_ras_hw_ops = {
 	.query_ras_error_count = hdp_v4_0_query_ras_error_count,
 	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
 };
 
+struct amdgpu_hdp_ras hdp_v4_0_ras = {
+	.ras_block = {
+		.name = "hdp",
+		.block = AMDGPU_RAS_BLOCK__HDP,
+		.hw_ops = &hdp_v4_0_ras_hw_ops,
+		.ras_late_init = amdgpu_hdp_ras_late_init,
+		.ras_fini = amdgpu_hdp_ras_fini,
+	},
+};
+
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
 	.flush_hdp = hdp_v4_0_flush_hdp,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
index dc3a1b81dd62..c44eee9282ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
@@ -27,6 +27,6 @@
 #include "soc15_common.h"
 
 extern const struct amdgpu_hdp_funcs hdp_v4_0_funcs;
-extern const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs;
+extern struct amdgpu_hdp_ras  hdp_v4_0_ras;
 
 #endif
-- 
2.25.1

