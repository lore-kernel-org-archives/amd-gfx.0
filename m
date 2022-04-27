Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88727C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB2610F3B8;
	Wed, 27 Apr 2022 03:01:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B159A10F3B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ckv7Ra2LPQZKvMkOKmV99Htvaur26hKmQ5wPdaUZ9iMndUGB9YC2cxr97YdypSo09CkXLBdlb8IaeRLdu4Zjw0sn0TVhcrI2RG6J3YdkPYvk89auos9a3O88otrAqwI1LLRYuIcxFpS7ySuS1pf0xG0Gl85sS/RecEuYfXkuYV1x6VV+t4p6F5O3D0Jc2QX0wcDdKd7q8+RVXAjoyWKUL1gZaFsP3YAcnVwfLMvMhT4LMF+dJHXZf9cwlPTr/9RugAEZq4s82uiXOUQB3rMNWv1WsDt0jETSipHmy4MblI2sQBVoP0AqBL53L7+vkBkkgVAHs0+P9K3sS2y9ha9Q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoeqDKd8k8pGYFW3PeZB+jvuCk+JnqI4LcPo5C4WQ/Q=;
 b=FJxb7QG+WZdzSo39ql2z5zyOHiYRyPYEPsmw9bVgzCjEzR+WlzdwlttAU6GEqLDjLK31XSTXtfcxhpxBJZJvQkbgIWGrL297/VrAxGJXZUGbhlFx69ElCkSPHBu+vuI/KV+CV8Tx/lCsINHuPerSFATG8HpxZJ+lSWzTzeMVBEilNyTaLSazVf6fKc0oWTUd36izy4U2EHLosAwbCnZjf+3GdQ6f0CC/vX1LjlVqVUHg9IH/fCuJ28dQ6pF9eEVJKSkeN+q5xp5w1ZfuB09mJcw0qt+acqILuzd/3qyc/hsxJFLHfGkICckOWuiOYXxwmil4mKszqLf7zWUPzKemCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoeqDKd8k8pGYFW3PeZB+jvuCk+JnqI4LcPo5C4WQ/Q=;
 b=FQz4G0TyrwDL/9WiEGFkvduveVhzgDDrrHw5AhjhErYxkjVsrTFmQK9gvi2uzGDfD07E5fY0vrRT/AYhgTESqeDjFxCCwetMyWe10QUqQh76zi/s0ru3LKiO+B77lGWIib60GgxJhGpdHDwDhxzufjqHCq7jP1k1M4qiChdseNs=
Received: from BN9PR03CA0523.namprd03.prod.outlook.com (2603:10b6:408:131::18)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 03:01:30 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::a2) by BN9PR03CA0523.outlook.office365.com
 (2603:10b6:408:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 03:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:01:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:28 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:01:24 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amd/display: Add Connection Manager boot option.
Date: Wed, 27 Apr 2022 11:00:53 +0800
Message-ID: <20220427030059.1242868-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427030059.1242868-1-Wayne.Lin@amd.com>
References: <20220427030059.1242868-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97ebda25-84f2-43bf-0c45-08da27fa3a08
X-MS-TrafficTypeDiagnostic: BY5PR12MB5000:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB5000F553313B289C54BBF716FCFA9@BY5PR12MB5000.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiPuLXZneP7q85JbkMM+GxPpLYfbiZ2WJb5frLz5+mZtjHN3MkRLTL1NpjSp3tMJaH4YvniwnhZOichVmyGIxYASGUjIRFikhuWRjOVQQTaNbZS00+gGUBsg4fEH+9SyvdkE6mYG+XllOniUxCJQybxcvHkwYZn5w1YsxVZ5dN7SZdYq4Y1SJ6Zb3ZdVJRC2twUCXTY4n4WwSwknWHO3IMyP2Egfla4jxEjt75EgsT3wvILhBmmJlqj5jDsFbk0v7v4m/KqhWbS41ztLrn9em8chhQLyO8xemeEq/P87qv2/lvX0F1nReX22p/hkGIvjTB1RHrsEXdK0xFJCXqJxS3Cyd++vtgY+DCieoWZZJ+qpjoy34Gdw3Ve5LtRUO/ugoJl41FoAAk/vIeaFp9Yds5qojYPWp9R6chL2z/qmb1L5iEn5V4+X5G+hAoVzWRlOQQ/haqcTxeJwFEW8E8K/fe1pU0FXDyFH3QWLvMIGATuaMNhkS1UmFXTjUmVdu+p1G5Q49KHCzW0xmXqOy+SOCoo3kxH1xUpkYkv/eJyhXeCSIhPa91UrNTHVz+Xsoc7eTqGlO8S8q1kzbLYJUOuu2S6Y5aPDSGTEqrCQ79Za+sMGjRAq5vXEta3N6Zsq2xk03HogaOY5uCEMeBOOOEinFeAoj2TeSJwW5CUunXIJfQ8ppTewlOPE2D3TO+enQkv8ZayvdYt0pIOfJ3UkBQVo7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(6666004)(40460700003)(26005)(81166007)(2906002)(5660300002)(82310400005)(36756003)(36860700001)(8936002)(7696005)(70206006)(2616005)(8676002)(4326008)(70586007)(83380400001)(356005)(1076003)(47076005)(186003)(336012)(426003)(86362001)(54906003)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:01:29.4634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ebda25-84f2-43bf-0c45-08da27fa3a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Boot up behaviour may differ depending on the Connection Manager
handling USB4 tunneling.

[How]
Send boot option to firmware to indicate Connection Manager.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 3 ++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 56757a286a03..f5cb8932bd5c 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -243,6 +243,7 @@ struct dmub_srv_hw_params {
 	bool power_optimization;
 	bool dpia_supported;
 	bool disable_dpia;
+	bool usb4_cm_version;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 05c8d91ad4ab..e24f117e831e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -350,8 +350,9 @@ union dmub_fw_boot_options {
 		uint32_t power_optimization: 1;
 		uint32_t diag_env: 1; /* 1 if diagnostic environment */
 		uint32_t gpint_scratch8: 1; /* 1 if GPINT is in scratch8*/
+		uint32_t usb4_cm_version: 1; /**< USB4 CM Version */
 
-		uint32_t reserved : 18; /**< reserved */
+		uint32_t reserved : 17; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 82c651535628..7c9330a61ac1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -340,6 +340,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.z10_disable = params->disable_z10;
 	boot_options.bits.dpia_supported = params->dpia_supported;
 	boot_options.bits.enable_dpia = params->disable_dpia ? 0 : 1;
+	boot_options.bits.usb4_cm_version = params->usb4_cm_version;
 	boot_options.bits.power_optimization = params->power_optimization;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
-- 
2.36.0

