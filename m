Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF4EC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 05:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D3E10F24E;
	Thu, 28 Mar 2024 05:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KkTe8Y3y";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9619710F1A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 05:53:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdJf0bn6IVgNNwNwokAo76Iqf5JFsKQYTsmjNjIaYbPIv+ys0S8mWiQsmS6bRm/1KivRnblksK0izVObPGUy2cQ648lGOuEsL1cmtlJzYrEUUFmqOVR+/16Tmz/aMLj5bZSxzDuf4RqLZRfB9gCKQ9eW6Fg2/xYGv5xhcaWcaMzsI1h/YuQiRaBJPHOavOX5hEGfNgiK5ZS49SiFIA2fr76iKgrAGn9jM1+lU7ONogQoJDLVQObNpQ2nrhQ2O3ic+SuZKSQzt/2yCUh3XXYzNmrvQB2341kjHy/uVZjQrGai0mwTvHL7M678EoVH1iWJ9yIIMQKQ6P07XCIX4EJUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR/R4y6uVHd25Llo/C4eF2jFaWO52H9u3hurcHGJJn8=;
 b=g4oINlEIWl4Ni8p4zFnhBZ+c7029kuThLV0VbKNzbMbFFUMmftH+3kRPnROpPCQXfKkOqtSqzvfd77o1aTTNMGmPMBoleFWSGGU+QWwn0NIMbZr8gwitIYogvAlx1uX+LvCQ+ZOyRrjNFzGwZSR87MN9PCaMQ8OigtAHFyN3iTXu2IyL4rmEecwSwuLOWvMJHUtZ2N62oHz6G6t/H0Hcc4PGkiL5buV4+RL5c66jYJD1Sv6BO1xP5TttjJAjRgrGKCklVM/1CY5PCyclAqsNK6WmPOxV/PIGRRm43uxFsBZ5afDYte2gmqylQIfjmw89ZdmYl3YtLfrCe2Me+9Rm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR/R4y6uVHd25Llo/C4eF2jFaWO52H9u3hurcHGJJn8=;
 b=KkTe8Y3yhrNTJsgVYhROcTnjodxGf9mzom28TzGHXNWuBpTJDeWC3YNhmLRCMQntjErFHtYkkVePmEmyjyhLwp9kutdeouWlp4B+vbe/8syluoT+kKJhJjISuEkRkLfSb5JBWi+/A6zV21Q3GGcFUbjiDw4bSX9XNSQ6tMYlODU=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 05:53:34 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::c4) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 28 Mar 2024 05:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 05:53:34 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 00:53:32 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: refine function signature of
 amdgpu_aca_get_error_data()
Date: Thu, 28 Mar 2024 13:53:14 +0800
Message-ID: <20240328055314.326165-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: b924b7ed-e892-4204-2896-08dc4eeb67bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKtdDbGoh0RN76PBoTgQdtjWb2DLHRxRarXVndufYsr6dhCNGVxHI3kxTMmv8CeoCToMwWgtVOFlicoBjkPeeWcSM9LmAPXwYZXcuLgO+nJiEu0j+oa9qb+WAULClBmGL09QeriQlW76gQubudJR4l8OGnHC7/DYv2Yu9DoOY1AebNT8qCwm1RHvl2/DyuNrymf5YRz7dfOJYRoVSYbA/XGMXRKC1+uzW0eU0nLGKrraKCvbvBmuQwaE3gedsp4C+NnBPQ50OOw4GCwTH4fsl7aqnMzRu8zzm7ho2iEMuNTkiEhCQRci+UwjNU4RV62cdMEnj3pdZrzDks0/yIbed9oo9alLb5aOgzXITX7j9jLZtL7PCl69b7yIp0czqBB9ABJAy1JK7KQ4E9NKqsmPLjwiben4tv1CuZvmH0RFuu+uszCdLnht4TfuPgGrxm94iRLk9J9o9RJDOsCa/OJCr5kTLLfKyOV1p93VtPTI39/iUUnPI5EoOsHqXQNsiduQBBlyYK2pT9zwKjj1uOxOEoZS2IukGukY5puz6FDIR+XMsoeF9ocFOp1cIiWYHWsczJaNhOK0VnGh6JK4+pFTMvbKXD26gzAtzb6n22cmN3D5fVVYyGT0JFQ7OITKcrYJQXaswD6hbujQf1yMdkWGYxz40Ry+H+5+NlN1EB1tUn5yCQAXPuv8cXBjfiZxtdpChzErBneWgpUXJOrfY1wWVQYo2dc0zmzpcCL7o9HWSvnlKteKneuS64yM5CwCBNuW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 05:53:34.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b924b7ed-e892-4204-2896-08dc4eeb67bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

refine function signature of amdgpu_aca_get_error_data();

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 6 +++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 920ddbb35c3d..cb6a40a042e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -525,10 +525,9 @@ static bool aca_handle_is_valid(struct aca_handle *handle)
 }
 
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
-			      enum aca_error_type type, void *data, void *qctx)
+			      enum aca_error_type type, struct ras_err_data *err_data,
+			      struct ras_query_context *qctx)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)data;
-
 	if (!handle || !err_data)
 		return -EINVAL;
 
@@ -538,8 +537,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (!(BIT(type) & handle->mask))
 		return  0;
 
-	return __aca_get_error_data(adev, handle, type, err_data,
-				    (struct ras_query_context *)qctx);
+	return __aca_get_error_data(adev, handle, type, err_data, qctx);
 }
 
 static void aca_error_init(struct aca_error *aerr, enum aca_error_type type)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 247968d6a925..3765843ea648 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -26,6 +26,9 @@
 
 #include <linux/list.h>
 
+struct ras_err_data;
+struct ras_query_context;
+
 #define ACA_MAX_REGS_COUNT	(16)
 
 #define ACA_REG_FIELD(x, h, l)			(((x) & GENMASK_ULL(h, l)) >> l)
@@ -198,7 +201,8 @@ int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
 			  const char *name, const struct aca_info *aca_info, void *data);
 void amdgpu_aca_remove_handle(struct aca_handle *handle);
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
-			      enum aca_error_type type, void *data, void *qctx);
+			      enum aca_error_type type, struct ras_err_data *err_data,
+			      struct ras_query_context *qctx);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
-- 
2.34.1

