Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39C0C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664FE6EE63;
	Wed,  1 Dec 2021 10:53:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0F76FA25
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEZJIY3+JFPeCwRPCnZ3YxfYoN2h71oK3EBJGFi4KR75YzH7s8qhhcwR25xjI6O1oNcrWZagDby7e2eCsoobwAVzTByGCTjtsAmkUrii3EpunBX+v3wkXnokKO2F0Oh3h3H+32uhPylvNHQayekai5YfnAQ/pydrZCd/nxlbSXggFbPMtoveNtEAHviqgqkKmlonXK0wNz1X21112AuwgYXUC8LfDoHAmbNWRaCkDEH9bYSBhNajKcFZgQCT5lKQQ8B3E4TcMwp8z8P2Tr2DF9eQL5dlLyp2N0OtoVOQsUjZbEonb9pRn8TdcXbQWi9Mnzw97m+fdTCCxH8S+6tMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iAgp4eLmO3SN494AbHz+b+coI2ZjC5HHrioYtxOiAk=;
 b=NzmrwvjLNPB7DbE+NYLt5FR+NhdM/7hvJUXi4Z4/82UwDNwFFokl3JJ/Iwf/g+qhCUYafNBqSFeMdGt701WhMYEF0oOwqNf/x5oGkOjEsG/iGpCUnbxim1XLPF3DEK3vARRn3YLWxJeM7LOuNAJR+BRHAOVz25w6qa4oCnw60uyXyRTFbr4iLYM+wPVHjT5dYhPSjaQ/595oZ2GoU9qYdTJD++FSuwz98yC2JQK5sAU7/Rrqdxp/b10RE084dcendD79pF0dbz8Nus1EwvR4AB8LcIYkYUMGpf5KpgsdGtvEAwfeDoK1763NSDhtEsoUXMjEDf6kvQT1d1NKBH5u4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iAgp4eLmO3SN494AbHz+b+coI2ZjC5HHrioYtxOiAk=;
 b=0Br+3hjg+uAcpHKx2LiMSRBRjGR9S2DhcQ8ikYhKNpzqnTj70Qlf2oHMAZqtj0jPTS9JZ8rxzIv+we1Mu1IDymFJq93ii3aaIioe7eleQnAyw+BFnr37btf1UeBfysqr8+oBTZ+YP2iwVpWy+RW5zXj8BjfL54Fk9acaAY4oAaw=
Received: from BN9PR03CA0093.namprd03.prod.outlook.com (2603:10b6:408:fd::8)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 10:53:47 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::df) by BN9PR03CA0093.outlook.office365.com
 (2603:10b6:408:fd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:47 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:45 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 08/11] drm/amdgpu: Modify umc block to fit for the unified
 ras block data and ops
Date: Wed, 1 Dec 2021 18:52:47 +0800
Message-ID: <20211201105250.298525-8-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201105250.298525-1-YiPeng.Chai@amd.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e5df8de-9127-4db1-bcc3-08d9b4b8da34
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5439:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5439A29785BBC4D2516065B2FC689@SJ0PR12MB5439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDpvoq/MgwvtDlNUnecSxXR7oyLjzDhoPdJ6GEy/ukXtz8oj4PLtCB1LoGB8xx3V0RuPDYHVye8tFYIeVS45dn3bI+1tAL9rzHwLpq/J3ziP7RQomxtZ0Iaa5+2ib3fTG0H3Bt+qRMJ1HmWEUtSe3u7hfQ+xYVvjR2neIm3aRFKEeRmSgKwbzfAalm2WAUL3lYs6FRVS2hrig8fFSVHz1PmQq+s+HU4jVcjQXp+/fFOCiMDSqhP4LSAM/fgiYSloBfH8bZlET9eBr2M5MaiLXa0puB83Q9y9prjebCyFvZQC4AvGxWJ9qto+Li2x8jbNdOfHTctq/Iq6HJijMZAr+e/aggDY8Z8/7o0+LY4P9aDjYbbYc6R1XW4x/rcaSQ7MdojIMWJRZ8LCmzSLhcC7K914FOEK7L/DMtV+2apOZZ7mKDC4JEQnEO5BqwPjZh0wOT8U+nJ1eW+Jh7CMAVIlGxjweM5mJQYQaWTHEUEAw/TE8c1PtbIJFGhp4/5kC+vy3JNfpW6q5tOMTpk38zrtpjCBQEaYMsGz/dQXzbn0KgSi9V2DOKZhuS5JvMWAgyl4BqXj5OK7ifzlN2CJT2CRCJ0dyZFegyMzJvgK7ufnOpfMQWmOKcrF3IDUvKWaf6EFeD188wBvIe+vKbXXXf0ahlvOA70PustBx8e8mJIpT/DOWvnKGlMV2+ocmCY+lJBBNoR4P5S5W0E/n3U4oWrPTfNjnyl7kt0NsJ355v6nbKO4LZmomhFEAZ3zaVxz5WTEvU0eN9PJwW+67HTuK9Jz0GTMRKIiuRT/LbGmYa8wgYDrLwTftHSaAhFi64RAJlPb6WVvXCJdAXB5rHQWvmMQ3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(186003)(1076003)(2616005)(83380400001)(7696005)(40460700001)(5660300002)(6916009)(82310400004)(54906003)(26005)(36756003)(336012)(508600001)(4326008)(36860700001)(426003)(70586007)(30864003)(8936002)(8676002)(47076005)(316002)(16526019)(81166007)(356005)(2906002)(70206006)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:47.7194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5df8de-9127-4db1-bcc3-08d9b4b8da34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, yipechai <YiPeng.Chai@amd.com>,
 yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify umc block to fit for the unified ras block data and ops.
2.Implement .ras_block_match function pointer for umc block to identify itself.
3.Change amdgpu_umc_ras_funcs to amdgpu_umc_ras, and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of umc ras variable so that umc ras block can be able to be insertted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register umc ras block into amdgpu device ras block link list.
6.Remove the redundant code about umc in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 18 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  9 ++++++---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c   | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 23 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c   | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.h   |  2 +-
 12 files changed, 111 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 317b5e93a1f0..ead143214448 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -434,9 +434,9 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->ras_late_init) {
-		r = adev->umc.ras_funcs->ras_late_init(adev);
+	if (adev->umc.ras && adev->umc.ras->ras_block.ops &&
+	    adev->umc.ras->ras_block.ops->ras_late_init) {
+		r = adev->umc.ras->ras_block.ops->ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -493,9 +493,9 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 {
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->ras_fini)
-		adev->umc.ras_funcs->ras_fini(adev);
+	if (adev->umc.ras && adev->umc.ras->ras_block.ops &&
+	    adev->umc.ras->ras_block.ops->ras_fini)
+		adev->umc.ras->ras_block.ops->ras_fini(adev);
 
 	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ops &&
 	    adev->mmhub.ras->ras_block.ops->ras_fini)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 273a550741e4..7d050afd7e2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -925,15 +925,18 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
-		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_count)
-			adev->umc.ras_funcs->query_ras_error_count(adev, &err_data);
+		if (!block_obj || !block_obj->ops)	{
+			dev_info(adev->dev, "%s don't config ras function \n",
+				get_ras_block_str(&info->head));
+			return -EINVAL;
+		}
+		if (block_obj->ops->query_ras_error_count)
+			block_obj->ops->query_ras_error_count(adev, &err_data);
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
 		 */
-		if (adev->umc.ras_funcs &&
-		    adev->umc.ras_funcs->query_ras_error_address)
-			adev->umc.ras_funcs->query_ras_error_address(adev, &err_data);
+		if (block_obj->ops->query_ras_error_address)
+			block_obj->ops->query_ras_error_address(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->query_ras_error_count) {
@@ -2359,12 +2362,12 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	/* Init poison supported flag, the default value is false */
 	if (adev->df.funcs &&
 	    adev->df.funcs->query_ras_poison_mode &&
-	    adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_poison_mode) {
+	    adev->umc.ras && adev->umc.ras->ras_block.ops &&
+	    adev->umc.ras->ras_block.ops->query_ras_poison_mode) {
 		df_poison =
 			adev->df.funcs->query_ras_poison_mode(adev);
 		umc_poison =
-			adev->umc.ras_funcs->query_ras_poison_mode(adev);
+			adev->umc.ras->ras_block.ops->query_ras_poison_mode(adev);
 		/* Only poison is set in both DF and UMC, we can support it */
 		if (df_poison && umc_poison)
 			con->poison_supported = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0c7c56a91b25..2624421b131e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
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
+	if (adev->umc.ras && adev->umc.ras->ras_block.ops &&
+	    adev->umc.ras->ras_block.ops->query_ras_error_count)
+	    adev->umc.ras->ras_block.ops->query_ras_error_count(adev, ras_error_status);
 
-	if (adev->umc.ras_funcs &&
-	    adev->umc.ras_funcs->query_ras_error_address &&
+	if (adev->umc.ras && adev->umc.ras->ras_block.ops &&
+	    adev->umc.ras->ras_block.ops->query_ras_error_address &&
 	    adev->umc.max_ras_err_cnt_per_query) {
 		err_data->err_addr =
 			kcalloc(adev->umc.max_ras_err_cnt_per_query,
@@ -118,7 +118,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
 		 */
-		adev->umc.ras_funcs->query_ras_error_address(adev, ras_error_status);
+		adev->umc.ras->ras_block.ops->query_ras_error_address(adev, ras_error_status);
 	}
 
 	/* only uncorrectable error needs gpu reset */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 1f5fe2315236..cf8af55d904a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -20,6 +20,7 @@
  */
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
+#include "amdgpu_ras.h"
 
 /*
  * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
@@ -40,15 +41,9 @@
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
-	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
@@ -69,7 +64,7 @@ struct amdgpu_umc {
 	struct ras_common_if *ras_if;
 
 	const struct amdgpu_umc_funcs *funcs;
-	const struct amdgpu_umc_ras_funcs *ras_funcs;
+	struct amdgpu_umc_ras *ras;
 };
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index bbddb87d7d17..b12bd2c78778 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -663,11 +663,13 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.umc_inst_num = UMC_V8_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V8_7_PER_CHANNEL_OFFSET_SIENNA;
 		adev->umc.channel_idx_tbl = &umc_v8_7_channel_idx_tbl[0][0];
-		adev->umc.ras_funcs = &umc_v8_7_ras_funcs;
+		adev->umc.ras = &umc_v8_7_ras;
 		break;
 	default:
 		break;
 	}
+	if(adev->umc.ras)
+		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 53ec18c595e8..c1c4b1c6c1e7 100644
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
@@ -1181,6 +1181,9 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
+
+	if(adev->umc.ras)
+		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
 }
 
 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 921da7dffb1c..ed480c2081a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -465,10 +465,31 @@ static void umc_v6_1_err_cnt_init(struct amdgpu_device *adev)
 		umc_v6_1_enable_umc_index_mode(adev);
 }
 
-const struct amdgpu_umc_ras_funcs umc_v6_1_ras_funcs = {
-	.err_cnt_init = umc_v6_1_err_cnt_init,
+static int umc_v6_1_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops umc_v6_1_ras_ops = {
+	.ras_block_match = umc_v6_1_ras_block_match,
 	.ras_late_init = amdgpu_umc_ras_late_init,
 	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v6_1_query_ras_error_count,
 	.query_ras_error_address = umc_v6_1_query_ras_error_address,
 };
+
+struct amdgpu_umc_ras umc_v6_1_ras = {
+	.ras_block = {
+		.name = "umc",
+		.block = AMDGPU_RAS_BLOCK__UMC,
+		.ops = &umc_v6_1_ras_ops,
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
index f7ec3fe134e5..e26728dbc6e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -321,10 +321,31 @@ static bool umc_v6_7_query_ras_poison_mode(struct amdgpu_device *adev)
 	return true;
 }
 
-const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs = {
+static int umc_v6_7_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops umc_v6_7_ras_pos = {
+	.ras_block_match = umc_v6_7_ras_block_match,
 	.ras_late_init = amdgpu_umc_ras_late_init,
 	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v6_7_query_ras_error_count,
 	.query_ras_error_address = umc_v6_7_query_ras_error_address,
 	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
 };
+
+struct amdgpu_umc_ras umc_v6_7_ras = {
+	.ras_block = {
+		.name = "umc",
+		.block = AMDGPU_RAS_BLOCK__UMC,
+		.ops = &umc_v6_7_ras_pos,
+	},
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
index af59a35788e3..037791e90c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -324,10 +324,31 @@ static void umc_v8_7_err_cnt_init(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_umc_ras_funcs umc_v8_7_ras_funcs = {
-	.err_cnt_init = umc_v8_7_err_cnt_init,
+static int umc_v8_7_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops umc_v8_7_ras_ops = {
+	.ras_block_match = umc_v8_7_ras_block_match,
 	.ras_late_init = amdgpu_umc_ras_late_init,
 	.ras_fini = amdgpu_umc_ras_fini,
 	.query_ras_error_count = umc_v8_7_query_ras_error_count,
 	.query_ras_error_address = umc_v8_7_query_ras_error_address,
 };
+
+struct amdgpu_umc_ras umc_v8_7_ras = {
+	.ras_block = {
+		.name = "umc",
+		.block = AMDGPU_RAS_BLOCK__UMC,
+		.ops = &umc_v8_7_ras_ops,
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

