Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B68C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 10:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367136E93B;
	Thu, 25 Nov 2021 10:59:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF616E93B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 10:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqOBemyCuISuHbssNhWvIvsc1rAG9kVySnx3FDPctmPKCS7sucNkK/TYD0XKPA/qDbmH2ck4Lpry5lVFpkgUxx0qXwfL82YhrFvuCIaYUu1YpTe/CpW9ZWQDjz20QikGdKO5uollt8wAzenfpKqDTG4cV1IFJHG/iH+0mE9FXQJmKpj0Ae38PWRqCwsEps/QcUAWN3Omdj1HjdVJhcpufv2Zc1jEtUmoyx12oCvu+sSjmtgtjI01UY5+63krcPEkFFVBYVlcv+0q+8lZWV+WK49m05JlcabeMm8voLRCMEM7v4P3jgJDkiMYl4d5ZbeRIiRcyUuVDWbYtnUF5+Ngwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lX1lZojDjEH7HrkLolZr3cCiANEe04IZ8bU/p7vJo4=;
 b=MBW9CaszKYtUvV+uCwQwtpenVSaKe2H91P3srGtYKTtyqBtGBlis/ywyGSSrGQlx2YZ4B/fIkez9P08rIS3WUEVeRcXRGoi7ZsKUVIw47IfmvGZWFA4MhucaSdnsRdZgx3eHE9xCtVacaAC5AtrIWuojaTsKOasom3vOrCBq+nAam9WmFTQO8QEXVwTZgyusGAe7mqpoJT4N2mC6hIywfbvy1orlmkLLcQxFo6FLKeN/09s/tgjHoUO1VTDrzcy+U4FtaqpgGu8NGFXC7g8j6PqywyHWa3EKg1YG1rJFr6naktENhrkZU741yohPELVtmcEczl01UoduH8+GvtQThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lX1lZojDjEH7HrkLolZr3cCiANEe04IZ8bU/p7vJo4=;
 b=1CcNLd51iKRBFoh/Qc6ZUONOEq04wRJrxqmuODsnoEmdWS+qC6wc9Mp/qHaDOJcFb+nqwQY3hZZvRYmc+w9mvlY1eb+nWq6B+zCocXhMuWINuuC36s29snXzrTKkKiFKTkF6BESASeKLpTv/5Tg3eoKLLiQZfZZl5pAzzrrPRQA=
Received: from DS7PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:3b7::8) by
 BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 10:58:59 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::fa) by DS7PR03CA0093.outlook.office365.com
 (2603:10b6:5:3b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 10:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 10:58:59 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 04:58:57 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amdgpu: Modify umc block to fit for the unified ras
 function pointers.
Date: Thu, 25 Nov 2021 18:57:00 +0800
Message-ID: <20211125105701.15860-8-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c163c19-f32d-4e41-33a4-08d9b002957d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5112E3622F9D85606111BB1FFC629@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjapLiH3oGoeYMxtPNGfh0aV3OKThhQPq9yB7odPnQeFjCT1cteEt57jd0PARbPS4vPIcPnWTmHYY3E0SWkXCwq3E1C7fmwtWFF5W81xw7/KreVw2P6aZjzuYj4gFg6wT2cS33Pwk2gVIvr8pFORzXoIgPclSx6+kf/uMwDy7uECHn5wd+H0W74ob8X/Nk0WIXc3Tehq7b4dOR9+OfBYap/NLyQS/Qf6m1pnABekfHjhU+JSUSZ7PrwFkIYiUzKlpBkUFJcdldQ9bzYQ2kp8U13oj0D/wYtjMbARViRyqvrAEoNS12TJK7tGjfIgAML3sKg+Jam8sdPOW+R6Gr0pRK5vSwILDSIeolAAYoDWledco7/ewxtGelD/gePxG4LAbM9gqbVlcXBleutNBmAESaOAqXzlC9UZp4zSVO/VnUKK5VEs0jaR+Iyf4x9cWiaw9Mcps8fZkLl9NlMoBbbXkOGqKcKONQFh+qcd2TeO1v3Xum+fMnEtwBQWRcCkSXcGkkGsjLl8rc7H7vGWpu6sN2EW3aQnHiuLeqMOROfv/PKr8w7PEQNpwz26gV7LKPkp0dNky99Va9AxSJ1ywryeFPRdvYs2qIKjntHW9HgSV6sBnK1sSLPm+c7tplEQISgxdndJOweEGnBUsW/fuJhxszvFl0B8g/ert+FVycyOdZOO2gRh2pZA7x0qRCx/vY6RvXy8OBb6/oEdVSB7OX4TrFuKp8hZv8TXM5Fo7SgEj5t2/LFaQWbd6u7HN+M29kFr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(26005)(36756003)(2906002)(54906003)(16526019)(6916009)(81166007)(47076005)(82310400004)(7696005)(356005)(5660300002)(1076003)(83380400001)(6666004)(8676002)(70586007)(316002)(70206006)(36860700001)(2616005)(426003)(336012)(4326008)(508600001)(86362001)(8936002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 10:58:59.3289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c163c19-f32d-4e41-33a4-08d9b002957d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
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

Modify umc block ras functions to fit for the unified ras function pointers.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c   | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c   | 11 ++++++-----
 7 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7780effdf3ac..4499cc5186cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -435,8 +435,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	int r;
 
 	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->ras_late_init) {
-		r = adev->umc.ras_funcs->ras_late_init(adev);
+	    adev->umc.ras_funcs->ops.ras_late_init) {
+		r = adev->umc.ras_funcs->ops.ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -492,8 +492,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 {
 	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->ras_fini)
-		adev->umc.ras_funcs->ras_fini(adev);
+	    adev->umc.ras_funcs->ops.ras_fini)
+		adev->umc.ras_funcs->ops.ras_fini(adev);
 
 	if (adev->mmhub.ras_funcs &&
 	    adev->mmhub.ras_funcs->ops.ras_fini)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2c79172f6031..65306e0079af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -902,14 +902,14 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
 		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_count)
-			adev->umc.ras_funcs->query_ras_error_count(adev, &err_data);
+		    adev->umc.ras_funcs->ops.query_ras_error_count)
+			adev->umc.ras_funcs->ops.query_ras_error_count(adev, &err_data);
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
 		 */
 		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_address)
-			adev->umc.ras_funcs->query_ras_error_address(adev, &err_data);
+		    adev->umc.ras_funcs->ops.query_ras_error_address)
+			adev->umc.ras_funcs->ops.query_ras_error_address(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->query_ras_error_count) {
@@ -2341,11 +2341,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	if (adev->df.funcs &&
 	    adev->df.funcs->query_ras_poison_mode &&
 	    adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_poison_mode) {
+	    adev->umc.ras_funcs->ops.query_ras_poison_mode) {
 		df_poison =
 			adev->df.funcs->query_ras_poison_mode(adev);
 		umc_poison =
-			adev->umc.ras_funcs->query_ras_poison_mode(adev);
+			adev->umc.ras_funcs->ops.query_ras_poison_mode(adev);
 		/* Only poison is set in both DF and UMC, we can support it */
 		if (df_poison && umc_poison)
 			con->poison_supported = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0c7c56a91b25..9a44c410be06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -98,11 +98,11 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_count)
-	    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
+	    adev->umc.ras_funcs->ops.query_ras_error_count)
+	    adev->umc.ras_funcs->ops.query_ras_error_count(adev, ras_error_status);
 
 	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_address &&
+	    adev->umc.ras_funcs->ops.query_ras_error_address &&
 	    adev->umc.max_ras_err_cnt_per_query) {
 		err_data->err_addr =
 			kcalloc(adev->umc.max_ras_err_cnt_per_query,
@@ -118,7 +118,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
 		 */
-		adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
+		adev->umc.ras_funcs->ops.query_ras_error_address(adev, ras_error_status);
 	}
 
 	/* only uncorrectable error needs gpu reset */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 1f5fe2315236..d6d0d92f8fc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -20,6 +20,7 @@
  */
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
+#include "amdgpu_ras.h"
 
 /*
  * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
@@ -41,14 +42,8 @@
 #define LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) LOOP_UMC_INST((umc_inst)) LOOP_UMC_CH_INST((ch_inst))
 
 struct amdgpu_umc_ras_funcs {
+	struct amdgpu_ras_block_ops ops;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*query_ras_error_address)(struct amdgpu_device *adev,
-					void *ras_error_status);
-	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 921da7dffb1c..2451b6d025e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -467,8 +467,10 @@ static void umc_v6_1_err_cnt_init(struct amdgpu_device *adev)
 
 const struct amdgpu_umc_ras_funcs umc_v6_1_ras_funcs = {
 	.err_cnt_init = umc_v6_1_err_cnt_init,
-	.ras_late_init = amdgpu_umc_ras_late_init,
-	.ras_fini = amdgpu_umc_ras_fini,
-	.query_ras_error_count = umc_v6_1_query_ras_error_count,
-	.query_ras_error_address = umc_v6_1_query_ras_error_address,
+	.ops = {
+		.ras_late_init = amdgpu_umc_ras_late_init,
+		.ras_fini = amdgpu_umc_ras_fini,
+		.query_ras_error_count = umc_v6_1_query_ras_error_count,
+		.query_ras_error_address = umc_v6_1_query_ras_error_address,
+	},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index f7ec3fe134e5..a4786de6186f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -322,9 +322,11 @@ static bool umc_v6_7_query_ras_poison_mode(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs = {
-	.ras_late_init = amdgpu_umc_ras_late_init,
-	.ras_fini = amdgpu_umc_ras_fini,
-	.query_ras_error_count = umc_v6_7_query_ras_error_count,
-	.query_ras_error_address = umc_v6_7_query_ras_error_address,
-	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
+	.ops = {
+		.ras_late_init = amdgpu_umc_ras_late_init,
+		.ras_fini = amdgpu_umc_ras_fini,
+		.query_ras_error_count = umc_v6_7_query_ras_error_count,
+		.query_ras_error_address = umc_v6_7_query_ras_error_address,
+		.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
+	},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index af59a35788e3..2ae97edf9a47 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -325,9 +325,10 @@ static void umc_v8_7_err_cnt_init(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_umc_ras_funcs umc_v8_7_ras_funcs = {
-	.err_cnt_init = umc_v8_7_err_cnt_init,
-	.ras_late_init = amdgpu_umc_ras_late_init,
-	.ras_fini = amdgpu_umc_ras_fini,
-	.query_ras_error_count = umc_v8_7_query_ras_error_count,
-	.query_ras_error_address = umc_v8_7_query_ras_error_address,
+	.ops = {
+		.ras_late_init = amdgpu_umc_ras_late_init,
+		.ras_fini = amdgpu_umc_ras_fini,
+		.query_ras_error_count = umc_v8_7_query_ras_error_count,
+		.query_ras_error_address = umc_v8_7_query_ras_error_address,
+	},
 };
-- 
2.25.1

