Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C2AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360DF10F285;
	Mon, 21 Feb 2022 10:17:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B7810F26A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzWFpiyt2Pc1/J3Tz//7jOKVpGLT9MYS32vAOqvnGSJJNCeBBH+iSZ+P9JsFtO9apalhD0tpU5q4zm1oiBvC8thAgI/H/buAmzK9tvbwCz86wfp+9LCbk0VxDwgCptH9SPvXFBF8cjngLzU/qLuMxOOJvc3g09YW31qZ79JaAHT9aF51wMcsPomqctz8AyGS5lSoKNBpAZUzkDgg6tnmMrbU1KPnpEXq4yyOibX7t4oRqhKKiWxFPrsrWHQykOTZXunbuRlLQkfyzka1Hox3SCLHnQtXsC3mGR80U515Fw5NAmC7y8XOV21wyAjlMlIznsBz+ujhzeGKlvtIPbUy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44tBpRpXd6RjxJ6WHRNfn7LwTe/r0KJ3BZW5oBEsAEs=;
 b=GZOrCpDD79YApvUnY/+mEbrRsdDRdbx23O2ienzanv3FlN+Q+GphuygLoHMjkFQ3iCtbihmq3wdDOx3PoIp3vjaLu6KU5QsS82Qp1VZWlXs3L6GdX0pgvvtH+WhvmwLaBPaPZCJZ8TeNCqq/mqcm9dXwppdIhAlxHD57i7SSY5eISX9AKI1HA0+kqhhMfmbHCYNTQV5roWHIhRkX491zBCq8NFH0GLbRtwhS6cWrcRBWcQCb8kU9BLtLOmj4CIHmqoqsX07buHr1rpeRCtn/h6dg4eFX5ycNxbK1tEiW+7NFdKlYMFcISB9MHnzERH5LolPKatULXKf4pANKjtYZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44tBpRpXd6RjxJ6WHRNfn7LwTe/r0KJ3BZW5oBEsAEs=;
 b=qswbilboKPSN8fJMwaYpiuPfzp6kImSA9DvXibCoptHeURXcGwYLKksRcGdhsQHPtdt5NGeIKufAKqFFic/L6GTKrbt1EjmOowNWBfTg44R2FrtutYxRZXnmp/idOjN0oCiEAEUnpccvlQTBX6nVj3Vxyhz3BwNuRJVD1lyni/s=
Received: from DM5PR20CA0015.namprd20.prod.outlook.com (2603:10b6:3:93::25) by
 LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:17:16 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::ed) by DM5PR20CA0015.outlook.office365.com
 (2603:10b6:3:93::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:15 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:17:13 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amdgpu: Remove redundant calls of
 amdgpu_ras_block_late_fini in mca ras block
Date: Mon, 21 Feb 2022 18:16:19 +0800
Message-ID: <20220221101620.3269611-11-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4492ac96-db4a-44f7-0317-08d9f523559b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5920:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB59201351A5FFB2FB11728166FC3A9@LV2PR12MB5920.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGP8UcJwb+Wygx9S2w5vTmq4h5pVFumIJRk4BxyYuqebWYez+jGf0ftOeaK8QW+hOrxEtj7sqN39hs9LMNHQe/vuoitGlaKI9Yy4LUi/Dbbk1cNEMdqKd5+xykc3xMBY5iGLDaRUhi7EY+6V7hi2GnNUEmo7g7aCWNx+k8F7RcBQsSZH7EMgu/YjXpXf0RVZkpenSPF38L/D3tw2UvCqGZoYZeE41dRBuGJDpRxQlajbOaNF1vSEnobK7hGe/XKZYGX0w4bENMdQHqGPevgPPia3euW3zO28ABSlXtOdn4RHF1Fm/NaGRfNPmwy3vecOTOchYonVhGT2D3FK3rkRH88C20k4Qzx/76XCSn0++eSVWsA0l1+Y7BokUDrQljT7BeRus32BIGCB5zL7uFlBExWj+yfBiI3MQRdrKOmGz4rjIzPC/AaMLB+LPonNOxHNJCx7bRw/t+QD9a7k4pgE+wGDMbQC+JMwRd2LxBQl9f514yj2P4Tlj+RckIqx82Kfd4vLykpCkdea3yxizzi1KJpGwpgt8E8pmFoFNbFxmC12GSO9nHRNdZlyWi0b4ZqCSssy/xGZzHuja5Av4XYEiNzcteP8UAsBuQRkr8jbziwfi8+pKTQVf5USvchJB7cJu+j3VOmHcknVxvndvHR2kxKCqJUX+mE1pa2SIE+w64LZI5LWKdw8UP88nctF8jvgf5NR3f9egvRKjR8Ypq7d284HHVvoI4C/UBBpNXuX/fk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(4326008)(8936002)(5660300002)(2616005)(54906003)(316002)(6916009)(70586007)(86362001)(8676002)(70206006)(508600001)(82310400004)(2906002)(47076005)(36860700001)(40460700003)(356005)(336012)(426003)(83380400001)(26005)(36756003)(1076003)(186003)(81166007)(16526019)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:15.7424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4492ac96-db4a-44f7-0317-08d9f523559b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920
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

Remove redundant calls of amdgpu_ras_block_late_fini in mca ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   | 21 +++------------------
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index e2607d9f5cf4..51c2a82e2fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -70,9 +70,3 @@ void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 
 	amdgpu_mca_reset_error_count(adev, mc_status_addr);
 }
-
-void amdgpu_mca_ras_fini(struct amdgpu_device *adev,
-			 struct amdgpu_mca_ras *mca_dev)
-{
-	amdgpu_ras_block_late_fini(adev, mca_dev->ras_if);
-}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index 15e1a1efeb4f..7ce16d16e34b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -56,7 +56,4 @@ void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 				      uint64_t mc_status_addr,
 				      void *ras_error_status);
 
-void amdgpu_mca_ras_fini(struct amdgpu_device *adev,
-			 struct amdgpu_mca_ras *mca_dev);
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 02c50be19d3b..5ce6778a821d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -37,11 +37,6 @@ static void mca_v3_0_mp0_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static void mca_v3_0_mp0_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	amdgpu_mca_ras_fini(adev, &adev->mca.mp0);
-}
-
 static int mca_v3_0_ras_block_match(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index)
 {
@@ -71,7 +66,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
 		},
 		.hw_ops = &mca_v3_0_mp0_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_fini = mca_v3_0_mp0_ras_fini,
+		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
 
@@ -83,11 +78,6 @@ static void mca_v3_0_mp1_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static void mca_v3_0_mp1_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	amdgpu_mca_ras_fini(adev, &adev->mca.mp1);
-}
-
 const struct amdgpu_ras_block_hw_ops mca_v3_0_mp1_hw_ops = {
 	.query_ras_error_count = mca_v3_0_mp1_query_ras_error_count,
 	.query_ras_error_address = NULL,
@@ -103,7 +93,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
 		},
 		.hw_ops = &mca_v3_0_mp1_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_fini = mca_v3_0_mp1_ras_fini,
+		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
 
@@ -115,11 +105,6 @@ static void mca_v3_0_mpio_query_ras_error_count(struct amdgpu_device *adev,
 				         ras_error_status);
 }
 
-static void mca_v3_0_mpio_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	amdgpu_mca_ras_fini(adev, &adev->mca.mpio);
-}
-
 const struct amdgpu_ras_block_hw_ops mca_v3_0_mpio_hw_ops = {
 	.query_ras_error_count = mca_v3_0_mpio_query_ras_error_count,
 	.query_ras_error_address = NULL,
@@ -135,7 +120,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
 		},
 		.hw_ops = &mca_v3_0_mpio_hw_ops,
 		.ras_block_match = mca_v3_0_ras_block_match,
-		.ras_fini = mca_v3_0_mpio_ras_fini,
+		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 };
 
-- 
2.25.1

