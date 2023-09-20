Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C804CE79AD
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 08:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF8B10E45E;
	Wed, 20 Sep 2023 08:37:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F1810E45E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 08:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoO2fD6SX+pPrC0YFPrKtmDJQpt2N11rLxejwpWBS53/myfFpN0lGCaMOjTPL/QwCC2b+ZPZIGDS+xSrwFyw03Ob0AFDAtX7xvmtjx4yNPmJ0mU5wA2n7lp/mj2oZfFwUIfmLjNckLAq+tq6HUVHPk+1KxYdRMx4V1/yY7NS7hDE5+hAo/pXrEjMPW0OyGtndXxLojniJV0D8RgJT9mYfXeLT828gWSYRgkNZ5dqcLvAocxvHH+vK6dvz3QEHBf+OGpdCJklsVuWfa8UUgHrKt4g6ApNz9REiBourHwcWqbdG3z/qmM9dgj/MBB+kOA4nytv2+zDVi+Sr5Mb1pq+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgHzXGsA+AUBep5eOSAw19g5LRXH+tYUnKomScM0j94=;
 b=jEJ/fctA5m2TCJKKDlKh4QcCcEmXqnf8hCwzq2PgQdJq+R9sOvVZGiFzKoa5VXlRh6VE2TnrPmL5yv+olp2IYwXRraN2nMwlpbh9PKZCxEKSYs/w8JhO/e/auASHhUdObBwicNdNNw4ABPAKJ+LA3c1+q3QUnR+sBadTh8OfIzdF9oKXcuMrfHfMJRNYceNTQrWbhQbvT4Tyr66trrFcp5ZGbFvd3+Wkv3kvdYCnseyAi1Pqc+j7w5klgYYg+orapFHzPTG56qtcFcHM76ql8DT1cJlcKbZ75OvgGvaF9pAFMN/HGdIuqPQLyRvNV6qroBpojveN9YoEVIgxkuywGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgHzXGsA+AUBep5eOSAw19g5LRXH+tYUnKomScM0j94=;
 b=VlhThpYhNtvap1XVKjHb4kYJjd0Jh3vu94feO8+DN8BwT9JuDN3PQZrh4RuDJBC8NFRi1+DNhQdg5uQkD7oof5C7mXZIYAHx0FDTnkJhfbgqOa3Q1PRe9iNFdCH4n4lhIbfTKViYey8J8Y6Z//YVobGh7EJnkXQCvS8dyF1BBsk=
Received: from MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 08:37:43 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::e4) by MN2PR07CA0012.outlook.office365.com
 (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 08:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 08:37:42 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 03:37:10 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <candice.li@amd.com>, <kevinyang.wang@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix value of some UMC parameters for UMC v12
Date: Wed, 20 Sep 2023 16:36:58 +0800
Message-ID: <20230920083659.8237-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230920083659.8237-1-tao.zhou1@amd.com>
References: <20230920083659.8237-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2a64b6-ea84-4051-46b4-08dbb9b4db3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xc66JNoHTYYwUyrXm5vKFl0tj9Q3pOGRXjovGPrHn0Ow84829ocGHxnSQPwMGpSv4qcejDQ7SG8Xloe8gK+SiR2AenaNeZzyQdyZx1GsoYJlz2CCsE/xKW/MIKHTwXv+NXUP4aiZeqzp0E4IMwzpqDXzrpcCV20PfbKAuueAOyLF97K6XOlxmOmcs1r2Q/nIzAIWPxzZ2UKer24xqteValXA/dWmfmmy7VKJ+zLm8hb0Dm+ObDmsHEhOom0mfzjYxGBD3C340DQ7bWWb6bp5Uq4t8MWG7ZqoxUdDnY6wqUU2iXP9ByQMw5mnVlQ6Wp+LqGGN1jHTsByb47CxxCurgiytVafSOQh+VHTA2/3agWyHH4Md4hwyWzdZfwsJ8CSllnuMi3tTMyRdFNBvZwJQvxiEph073CTXzWlrH47cUsEecU4ifkqTrlOfGDzzsIeMmPgCreXYtiaTuqoywNLMljNprtHdg/8VkSJ8jwKCXhWu0Xw3QFGJ1UownUu+gS8FnIPJudQy9c2NSWP95JY+d2a1ctJUOa2xH9CElFHeihDK3MxMkGP0ak0ZqawB+YC1/c2q4en8ibzD+8/IuNrrxqiHmm1EOILpM0RlkohxY8xtczgenmrvcSH7xBr/G16BI77JEeZ5cj5lJUWEPuYkj8xp9HqzupFmmc2GJlmcjoLyoY8VNmqaPfsRuNMmobgqnovcbCJDnKV8y8U3dMZTDfOp674Y/khuscJEQTjalUz8de55YZQY3XoZvxQPzY1A2jNiR82PnngBKMAOL1L76w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(81166007)(356005)(82740400003)(36756003)(40480700001)(86362001)(40460700003)(478600001)(110136005)(70206006)(6666004)(6636002)(2906002)(316002)(70586007)(7696005)(8676002)(8936002)(5660300002)(4326008)(41300700001)(47076005)(36860700001)(1076003)(426003)(26005)(2616005)(336012)(16526019)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 08:37:42.6197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2a64b6-ea84-4051-46b4-08dbb9b4db3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare for bad page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a5510412acd0..bae4a0d18190 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1497,12 +1497,14 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_second[0][0];
 		break;
 	case IP_VERSION(12, 0, 0):
-		adev->umc.max_ras_err_cnt_per_query = UMC_V12_0_TOTAL_CHANNEL_NUM(adev);
+		adev->umc.max_ras_err_cnt_per_query =
+			UMC_V12_0_TOTAL_CHANNEL_NUM(adev) * UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		adev->umc.channel_inst_num = UMC_V12_0_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs = UMC_V12_0_PER_CHANNEL_OFFSET;
 		adev->umc.active_mask = adev->aid_mask;
+		adev->umc.retire_unit = UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		adev->umc.channel_idx_tbl = &umc_v12_0_channel_idx_tbl[0][0][0];
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 			adev->umc.ras = &umc_v12_0_ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index e3619d67ae3b..4885b9fff272 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -53,6 +53,8 @@
 
 /* one piece of normalized address is mapped to 8 pieces of physical address */
 #define UMC_V12_0_NA_MAP_PA_NUM        8
+/* R13 bit shift should be considered, double the number */
+#define UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
 /* bank bits in MCA error address */
 #define UMC_V12_0_MCA_B0_BIT 6
 #define UMC_V12_0_MCA_B1_BIT 7
-- 
2.35.1

