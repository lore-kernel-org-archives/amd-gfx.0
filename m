Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434A3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F9410E404;
	Wed, 29 Dec 2021 06:33:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22B210E404
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE1Qe/0WNGjoEiIlBTtcoWx5Za1ADnIK1bVYEBTNhUUyq3zI/mgduJGMYUiD5rRlEXTmHx7zJ/Zd1eBkrGbHbUl7LsrcwmoMs6b3gkegTpCJYh39glFkkYbHmQl1qEpMnrZV9+IpdMUiLK9NOxQTMQKoBANGOMOCwM/JnUL6KOD/CbGAD1+WtndhsNdVtQbUP1ZPvP6UZXXLLALS7zB0bwYyz1mQkdOpRoOHS0IfMefmKN/GQkQ2rarRecAGduhZ3RS+HZsJ8CNcqprZETWLEERfATQzDmz8b3ExIdzId6atTMMfzOtEiGavRPi1N+QsCUomHe6gDG0JO1ID0GurLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9o2ZCCIGBYLobGsBe4Y0MbbFOxAFqS1YoR06mcTVxU=;
 b=gFppJqmSmSLvqYzBAb+FOKn0+s4SpzzA9VTfTAw+gkNPf090EYxVzH7gW1HRCAXEJz5dtY1e+f45tKYbZ+20dXnxdUFzlNHenBuxFTXoIP5Gyxj3s6yLkZr5RQ6h6/bpMFeHqfOMLQMt4nNWmZxFmMfcPANwdrb6wveHFHKsz/2NjFdy2lpYfHkchRhNqp561Wm3pWkzYZmBbqQLvVFkyzoyzC/RywrSWv6dCCBLkVJdhit40fwqWQbEvlUu7I5eJaIaziGGSXjNMIm/X8yH+MjVNZjJxmOoZcLlpv66qqcG9ldIIslFtryakErch/j8TqvXJI8iHGtErrx08pQ1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9o2ZCCIGBYLobGsBe4Y0MbbFOxAFqS1YoR06mcTVxU=;
 b=rdcLr+PePh6jkG4+lP1Z4e1GPXE7J4iwyHk9CFWXL26930oqqC5N3ULH9mAhs5gELXw2it6JgR8gSsMrCrs2fuO1yVNwxH+P8sP28iN/bGgVo7WG0ycTdZtNZCjknEb3aD+0e/CMxVYwSUjvIoa+ETRSquNniUiKHVX/rzgbPHY=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by DM6PR12MB3578.namprd12.prod.outlook.com (2603:10b6:5:3c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 06:33:06 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::a2) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Wed, 29 Dec 2021 06:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 29 Dec 2021 06:33:06 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:33:04 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 08/12] drm/amdgpu: Modify umc block to fit for the unified
 ras block data and ops
Date: Wed, 29 Dec 2021 14:32:07 +0800
Message-ID: <20211229063211.43840-8-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a497fca1-a82e-409c-1cb8-08d9ca9512e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3578:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3578AE8F4EB4D7F723677E77FC449@DM6PR12MB3578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHAT3fvP5hLndn1yzDNkVovDZIOMnb2fYe3w5x82Z3TqsalfH/vSsAGBGe5mEQnS3t4DCPpLlHncAB+pMFJ7cigyJugcRoopzzw2p/oAGzrGALsNehFlEXavvGvpyHrpHSPd4u7YVLMCS7tEwCmX4FLrs54lb8mTzKfDs8Bp4Xo9H0c74dLZAwfgBpsioRN7fs6Wb29/P00/FB9quN3rDGR63m7I8OV+MkEOZvF1VjFrJvyXnV+A8yOmCcyulk+xZRt6KDKVcETEcPP9JWKiQ0PSk7dLV5w2j5Xy8vtnpMsXWB5HMdHdSyoBDYy4o+YpOGeP+bHt4Le6i6JSm+zzaiwvti6XBltBY6QgsFk4azbE5azAj/PtTJgpbSW8S/DUZG7ds/W55kDCHkWdIyHyHcMphJ8qShxHks4X1hddiZ8M9K8vxzNRE59me1c/idfVv8uQsNRiLMOXnXslnIxHm8Macwtd1ViKPljdu1wJ/rfnC45M+5Sky71FFwCnwniNwZildIP1ZWcDR2D3yaQ0eepHL+4nsIxMyPRb5xNel4VIJWTcDOZLYvDeGUZHizfCrKTs6vyMmdBmF2maGdgEul1ayC7skRhibpgP0bkivnE/c7k1qvDBlj/ox+O4uGh5GzxwKHgr/Q8GjNXj1mpGQu2t2ulNtjwz0Rmk/jmvKOO2GYTE1yKmKB32lL4WbUGntkxBPv9x8FO/OK68cfw3LWAeAO9BINn6dy3RWcaoiTsGqj+WrND0HqpV3ltxR0h7TrN6gV+oQt4WXZj+Khja3o697ILrCUqt5+PhInpfKpSMMFPCQMWHerm2Ig1G4QGuoVjgGogJS3+URiwKU+A10w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(36860700001)(1076003)(30864003)(356005)(40460700001)(81166007)(186003)(36756003)(5660300002)(316002)(86362001)(83380400001)(26005)(70206006)(82310400004)(70586007)(2616005)(2906002)(54906003)(8676002)(6916009)(16526019)(508600001)(4326008)(426003)(336012)(7696005)(47076005)(8936002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:33:06.4122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a497fca1-a82e-409c-1cb8-08d9ca9512e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
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

1.Modify umc block to fit for the unified ras block data and ops.
2.Change amdgpu_umc_ras_funcs to amdgpu_umc_ras, and the corresponding variable name remove _funcs suffix.
3.Remove the const flag of umc ras variable so that umc ras block can be able to be inserted into amdgpu device ras block link list.
4.Invoke amdgpu_ras_register_ras_block function to register umc ras block into amdgpu device ras block link list.
5.Remove the redundant code about umc in amdgpu_ras.c after using the unified ras block.
6.Fill unified ras block .name .block .ras_late_init and .ras_fini for all of umc versions. If .ras_late_init and .ras_fini had been defined by the selected umc version, the defined functions will take effect; if not defined, default fill them with amdgpu_umc_ras_late_init and amdgpu_umc_ras_fini.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 14 +++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 21 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.h   |  2 +-
 12 files changed, 92 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index b12da46c483a..429d89188d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -434,9 +434,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->ras_late_init) {
-		r = adev->umc.ras_funcs->ras_late_init(adev);
+	if (adev->umc.ras && adev->umc.ras->ras_block.ras_late_init) {
+		r = adev->umc.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
 			return r;
 	}
@@ -490,9 +489,8 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 {
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->ras_fini)
-		adev->umc.ras_funcs->ras_fini(adev);
+	if (adev->umc.ras && adev->umc.ras->ras_block.ras_fini)
+		adev->umc.ras->ras_block.ras_fini(adev);
 
 	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_fini)
 		adev->mmhub.ras->ras_block.ras_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 26bd9da31ffc..5a8fccfdb0bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -938,15 +938,19 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
-		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_count)
-			adev->umc.ras_funcs->query_ras_error_count(adev, &err_data);
+		if (!block_obj || !block_obj->hw_ops)	{
+			dev_info(adev->dev, "%s doesn't config ras function \n",
+				get_ras_block_str(&info->head));
+			return -EINVAL;
+		}
+
+		if (block_obj->hw_ops->query_ras_error_count)
+			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
 		 */
-		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_address)
-			adev->umc.ras_funcs->query_ras_error_address(adev, &err_data);
+		if (block_obj->hw_ops->query_ras_error_address)
+			block_obj->hw_ops->query_ras_error_address(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->query_ras_error_count) {
@@ -2374,12 +2378,12 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	/* Init poison supported flag, the default value is false */
 	if (adev->df.funcs &&
 	    adev->df.funcs->query_ras_poison_mode &&
-	    adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_poison_mode) {
+	    adev->umc.ras &&
+	    adev->umc.ras->query_ras_poison_mode) {
 		df_poison =
 			adev->df.funcs->query_ras_poison_mode(adev);
 		umc_poison =
-			adev->umc.ras_funcs->query_ras_poison_mode(adev);
+			adev->umc.ras->query_ras_poison_mode(adev);
 		/* Only poison is set in both DF and UMC, we can support it */
 		if (df_poison && umc_poison)
 			con->poison_supported = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0c7c56a91b25..b249076d5f76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -23,7 +23,7 @@
 
 #include "amdgpu_ras.h"
 
-int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
+int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
 	struct ras_fs_if fs_info = {
@@ -60,9 +60,9 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	/* ras init of specific umc version */
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->err_cnt_init)
-		adev->umc.ras_funcs->err_cnt_init(adev);
+	if (adev->umc.ras &&
+	    adev->umc.ras->err_cnt_init)
+		adev->umc.ras->err_cnt_init(adev);
 
 	return 0;
 
@@ -97,12 +97,12 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_count)
-	    adev->umc.ras_funcs->query_ras_error_count(adev, ras_error_status);
+	if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+	    adev->umc.ras->ras_block.hw_ops->query_ras_error_count)
+	    adev->umc.ras->ras_block.hw_ops->query_ras_error_count(adev, ras_error_status);
 
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_address &&
+	if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
+	    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
 	    adev->umc.max_ras_err_cnt_per_query) {
 		err_data->err_addr =
 			kcalloc(adev->umc.max_ras_err_cnt_per_query,
@@ -118,7 +118,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
 		 */
-		adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
+		adev->umc.ras->ras_block.hw_ops->query_ras_error_address(adev, ras_error_status);
 	}
 
 	/* only uncorrectable error needs gpu reset */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 1f5fe2315236..db5439f74d05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -20,6 +20,7 @@
  */
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
+#include "amdgpu_ras.h"
 
 /*
  * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
@@ -40,14 +41,9 @@
 #define LOOP_UMC_CH_INST(ch_inst) for ((ch_inst) = 0; (ch_inst) < adev->umc.channel_inst_num; (ch_inst)++)
 #define LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) LOOP_UMC_INST((umc_inst)) LOOP_UMC_CH_INST((ch_inst))
 
-struct amdgpu_umc_ras_funcs {
+struct amdgpu_umc_ras {
+	struct amdgpu_ras_block_object ras_block;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*query_ras_error_address)(struct amdgpu_device *adev,
-					void *ras_error_status);
 	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 };
 
@@ -69,10 +65,10 @@ struct amdgpu_umc {
 	struct ras_common_if *ras_if;
 
 	const struct amdgpu_umc_funcs *funcs;
-	const struct amdgpu_umc_ras_funcs *ras_funcs;
+	struct amdgpu_umc_ras *ras;
 };
 
-int amdgpu_umc_ras_late_init(struct amdgpu_device *adev);
+int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, void *ras_info);
 void amdgpu_umc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		void *ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index bbddb87d7d17..eb92bbd8c832 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -663,11 +663,25 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V8_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V8_7_PER_CHANNEL_OFFSET_SIENNA;
 		adev->umc.channel_idx_tbl = &umc_v8_7_channel_idx_tbl[0][0];
-		adev->umc.ras_funcs = &umc_v8_7_ras_funcs;
+		adev->umc.ras = &umc_v8_7_ras;
 		break;
 	default:
 		break;
 	}
+	if (adev->umc.ras) {
+		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
+
+		strcpy(adev->umc.ras->ras_block.name,"umc");
+		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->umc.ras->ras_block.ras_late_init)
+				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
+
+		/* If don't define special ras_fini function, use default ras_fini */
+		if (!adev->umc.ras->ras_block.ras_fini)
+				adev->umc.ras->ras_block.ras_fini = amdgpu_umc_ras_fini;
+	}
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 59829bd3aeb1..3e49acd90845 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1156,7 +1156,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_1_PER_CHANNEL_OFFSET_VG20;
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
-		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
+		adev->umc.ras = &umc_v6_1_ras;
 		break;
 	case CHIP_ARCTURUS:
 		adev->umc.max_ras_err_cnt_per_query = UMC_V6_1_TOTAL_CHANNEL_NUM;
@@ -1164,7 +1164,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V6_1_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_1_PER_CHANNEL_OFFSET_ARCT;
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
-		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
+		adev->umc.ras = &umc_v6_1_ras;
 		break;
 	case CHIP_ALDEBARAN:
 		adev->umc.max_ras_err_cnt_per_query = UMC_V6_7_TOTAL_CHANNEL_NUM;
@@ -1172,7 +1172,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V6_7_PER_CHANNEL_OFFSET;
 		if (!adev->gmc.xgmi.connected_to_cpu)
-			adev->umc.ras_funcs = &umc_v6_7_ras_funcs;
+			adev->umc.ras = &umc_v6_7_ras;
 		if (1 & adev->smuio.funcs->get_die_id(adev))
 			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_first[0][0];
 		else
@@ -1181,6 +1181,21 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
+
+	if (adev->umc.ras) {
+		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
+
+		strcpy(adev->umc.ras->ras_block.name,"umc");
+		adev->umc.ras->ras_block.block = AMDGPU_RAS_BLOCK__UMC;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->umc.ras->ras_block.ras_late_init)
+				adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
+
+		/* If don't define special ras_fini function, use default ras_fini */
+		if (!adev->umc.ras->ras_block.ras_fini)
+				adev->umc.ras->ras_block.ras_fini = amdgpu_umc_ras_fini;
+	}
 }
 
 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 921da7dffb1c..e3637583d5d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -465,10 +465,14 @@ static void umc_v6_1_err_cnt_init(struct amdgpu_device *adev)
 		umc_v6_1_enable_umc_index_mode(adev);
 }
 
-const struct amdgpu_umc_ras_funcs umc_v6_1_ras_funcs = {
-	.err_cnt_init = umc_v6_1_err_cnt_init,
-	.ras_late_init = amdgpu_umc_ras_late_init,
-	.ras_fini = amdgpu_umc_ras_fini,
+const struct amdgpu_ras_block_hw_ops umc_v6_1_ras_hw_ops = {
 	.query_ras_error_count = umc_v6_1_query_ras_error_count,
 	.query_ras_error_address = umc_v6_1_query_ras_error_address,
 };
+
+struct amdgpu_umc_ras umc_v6_1_ras = {
+	.ras_block = {
+		.hw_ops = &umc_v6_1_ras_hw_ops,
+	},
+	.err_cnt_init = umc_v6_1_err_cnt_init,
+};
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
index 5dc36c730bb2..50c632eb4cc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
@@ -45,7 +45,7 @@
 /* umc ce count initial value */
 #define UMC_V6_1_CE_CNT_INIT	(UMC_V6_1_CE_CNT_MAX - UMC_V6_1_CE_INT_THRESHOLD)
 
-extern const struct amdgpu_umc_ras_funcs umc_v6_1_ras_funcs;
+extern struct amdgpu_umc_ras umc_v6_1_ras;
 extern const uint32_t
 	umc_v6_1_channel_idx_tbl[UMC_V6_1_UMC_INSTANCE_NUM][UMC_V6_1_CHANNEL_INSTANCE_NUM];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index f7ec3fe134e5..e5682800257e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -321,10 +321,14 @@ static bool umc_v6_7_query_ras_poison_mode(struct amdgpu_device *adev)
 	return true;
 }
 
-const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs = {
-	.ras_late_init = amdgpu_umc_ras_late_init,
-	.ras_fini = amdgpu_umc_ras_fini,
+const struct amdgpu_ras_block_hw_ops umc_v6_7_ras_hw_ops = {
 	.query_ras_error_count = umc_v6_7_query_ras_error_count,
 	.query_ras_error_address = umc_v6_7_query_ras_error_address,
-	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
 };
+
+struct amdgpu_umc_ras umc_v6_7_ras = {
+	.ras_block = {
+		.hw_ops = &umc_v6_7_ras_hw_ops,
+	},
+	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
+};
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 57f2557e7aca..1f2edf625370 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -43,7 +43,7 @@
 #define UMC_V6_7_TOTAL_CHANNEL_NUM	(UMC_V6_7_CHANNEL_INSTANCE_NUM * UMC_V6_7_UMC_INSTANCE_NUM)
 /* UMC regiser per channel offset */
 #define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
-extern const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs;
+extern struct amdgpu_umc_ras umc_v6_7_ras;
 extern const uint32_t
 	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM];
 extern const uint32_t
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index af59a35788e3..ff9e1fac616d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -324,10 +324,14 @@ static void umc_v8_7_err_cnt_init(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_umc_ras_funcs umc_v8_7_ras_funcs = {
-	.err_cnt_init = umc_v8_7_err_cnt_init,
-	.ras_late_init = amdgpu_umc_ras_late_init,
-	.ras_fini = amdgpu_umc_ras_fini,
+const struct amdgpu_ras_block_hw_ops umc_v8_7_ras_hw_ops = {
 	.query_ras_error_count = umc_v8_7_query_ras_error_count,
 	.query_ras_error_address = umc_v8_7_query_ras_error_address,
 };
+
+struct amdgpu_umc_ras umc_v8_7_ras = {
+	.ras_block = {
+		.hw_ops = &umc_v8_7_ras_hw_ops,
+	},
+	.err_cnt_init = umc_v8_7_err_cnt_init,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
index 37e6dc7c28e0..dd4993f5f78f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.h
@@ -44,7 +44,7 @@
 /* umc ce count initial value */
 #define UMC_V8_7_CE_CNT_INIT	(UMC_V8_7_CE_CNT_MAX - UMC_V8_7_CE_INT_THRESHOLD)
 
-extern const struct amdgpu_umc_ras_funcs umc_v8_7_ras_funcs;
+extern struct amdgpu_umc_ras umc_v8_7_ras;
 extern const uint32_t
 	umc_v8_7_channel_idx_tbl[UMC_V8_7_UMC_INSTANCE_NUM][UMC_V8_7_CHANNEL_INSTANCE_NUM];
 
-- 
2.25.1

