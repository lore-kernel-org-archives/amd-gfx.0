Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FE3C35274
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A296110E0A6;
	Mon, 18 Dec 2023 18:19:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02E110E0A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:19:24 +0000 (UTC)
Received: from MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 08:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcA5b0cBQw4CfSBnDWjKkWb7RgKR7Y27Q+YxjVi4YaafU1DNGqzYrdq7zwyoK4btQRMQmM9Cl+/o4dX1X0TfbZbTfUSmnkwq1v3mTdB/dGbMhqq1ZP1H5x+F4ZSFTP+QOC4/sfYlcj98fnfbw3yxOjcRNviEc0l64wMSy4ecCHNHPBWq6wl1gAWhUEEo/vQN02/6H3FI4LbrTEnPheTqIusFWfL4HR6D+8ri0XTx96Rv4GafcamQIVZdFxhtOi2w1QWtJko3vnL6X6eYPgZiYpdK3jNmtwkYsV9Sw16bGhmxpDojKYmv3DuLgxMO3UA/+isyPs0hHOYsTU/0pVOqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+SsQxyKotxoFxrKuaYUUN7rcXFk3XRTe7mkbG15yOI=;
 b=R0vI86o1tW4HMBPMZMvm8UkpufeELSoThgffxBcD9pFKMjl90g/Z7QWCvFJCsohe2YJ6wLtYphefOg3RoQA3jLNv6nFonekE8Nkj6MEcizG/A1KaFdRzsuJq1RErlLX53GAgfLZiEA3m7DirWDP8ij5KB+m7+3vewF96078aq7KeUv336sejT+iEakxsQZ6yvCtv/j61CV4AdMmSDmcbEATekaFij6YryRuSeOQ0pZ90+voMsyBAeArP5fA4sEL38UszgWzOPwKlGmZRFv2o6kU0V2Ojb0I9V+1eW3QmoyQGGaXnii9zsgi/IbcP67hosbHfY+W8hYP77/YnwDq76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+SsQxyKotxoFxrKuaYUUN7rcXFk3XRTe7mkbG15yOI=;
 b=LjEocUNt/M/P3e/78Dul0u26hGJ3uu4jRT2g/aehoOrZZ6MVKyJMzyI8vKWo43wHHZT75qQTxfLWu1nRRbt3eZukY+UpVVSC49UEUwt2VkPZVHtxoBNBP5rt9UhUNzyLzeONgcVI0QjjHrQyZ7ThPW3dxsrYQd/Dydegx2AwQNw=
Received: from SA0PR11CA0076.namprd11.prod.outlook.com (2603:10b6:806:d2::21)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 07:10:30 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::44) by SA0PR11CA0076.outlook.office365.com
 (2603:10b6:806:d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 07:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 07:10:30 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 01:10:27 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Add poison mode check error condition for umc
 v12_0
Date: Mon, 18 Dec 2023 15:09:30 +0800
Message-ID: <20231218070932.2307244-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218070932.2307244-1-YiPeng.Chai@amd.com>
References: <20231218070932.2307244-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MN2PR12MB4519:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: ad06d239-af9d-4ae5-8c40-08dbff986b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaXeuDjW4gUM3zArnBTtJp7+V4U9eGlVqJcYlFRRaKtiCKD+o6Z1wfdmtUwYj4oGQqQGSNy6ZvE+l8CgomOFI6JRso2Oxi8bbHAM26qpTw3qbT3Gn6RqiEjXlLDgXdlQ9m+LtTox7VwIBkAOzd1I97qY3bNZkfhLsmIriEXdQiHNDVXKL4FL8hNU6hfuFfNzi64ASLrKh0tuPzr3TifYefCyJ4FtoIBdW/GC+8ICf0Vc8SfScQnmOlLGd8HNq3iHy8nyfMxu8QNWnQrWAIGIEzFGAncbs3tyea5geyI/mrPdxJ0rItgO6bK8PR7k3CgnEEUaSB2Cun3r2sNiURBqwiJi/gBdM2oxX/r8V4KAsP0iB9V0R03Az4AuR0dJQ3NQ+RjlFmkeHpJSJH+nw9I8SmUeRuPjZJbBhaBLKLJcAoaOqy89UKj9RpDPjx2wUAiWJTGmg09PCV02TdtyNU+ZJ1bbqSKwU1eqZm+w0iW3Lb95aPfbxDys6KNb0mL/pEzYxwJjPVg101xLEvsi0l1iRfvTnIJH1GBCRrhbUGVltW+JIul2nwSz/Uhn6hzhVGfiQsSjP4Oss9OELkuxyVLmsig/W4WdNkYZu0I3zC+I31z/+B/oiMBtyJUmEvZ1Vyx2X9VQaGDM0tYqKnzG65CWEh0y34ufzDVIwvrMO6FO6B4nXOxa/Bx9L3Ufwk1pkuoJl1MdyeL/qBSYEdmIRJypKN+Zbq0bo9fJ4+I3Qkl8zb+TxfwshEgkIQtSx1ajQo4L2/rAAOkZzkkU3g0T/ieapw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(47076005)(83380400001)(1076003)(2616005)(16526019)(426003)(336012)(26005)(36860700001)(316002)(8676002)(8936002)(5660300002)(41300700001)(4326008)(2906002)(478600001)(6666004)(7696005)(54906003)(70206006)(6916009)(70586007)(36756003)(81166007)(356005)(86362001)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:10:30.0297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad06d239-af9d-4ae5-8c40-08dbff986b27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
X-OriginatorOrg: amd.com
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add poison mode check error condition for umc v12_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        | 20 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h        |  4 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  4 ++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 8d60c39ae1c5..8430888760ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -88,16 +88,26 @@ static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
 		umc_v12_0_reset_error_count_per_channel, NULL);
 }
 
-bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status)
+bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
+	if (amdgpu_ras_is_poison_mode_supported(adev) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1))
+		return true;
+
 	return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
 		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
 		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1));
 }
 
-bool umc_v12_0_is_correctable_error(uint64_t mc_umc_status)
+bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
+	if (amdgpu_ras_is_poison_mode_supported(adev) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1))
+		return false;
+
 	return (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1 ||
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 &&
@@ -105,7 +115,7 @@ bool umc_v12_0_is_correctable_error(uint64_t mc_umc_status)
 		/* Identify data parity error in replay mode */
 		((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) == 0x5 ||
 		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) == 0xb) &&
-		!(umc_v12_0_is_uncorrectable_error(mc_umc_status)))));
+		!(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))));
 }
 
 static void umc_v12_0_query_correctable_error_count(struct amdgpu_device *adev,
@@ -124,7 +134,7 @@ static void umc_v12_0_query_correctable_error_count(struct amdgpu_device *adev,
 	mc_umc_status =
 		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
 
-	if (umc_v12_0_is_correctable_error(mc_umc_status))
+	if (umc_v12_0_is_correctable_error(adev, mc_umc_status))
 		*error_count += 1;
 }
 
@@ -142,7 +152,7 @@ static void umc_v12_0_query_uncorrectable_error_count(struct amdgpu_device *adev
 	mc_umc_status =
 		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
 
-	if (umc_v12_0_is_uncorrectable_error(mc_umc_status))
+	if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status))
 		*error_count += 1;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index b34b1e358f8b..17b4b52d6f13 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -117,8 +117,8 @@
 		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) << UMC_V12_0_PA_CH6_BIT); \
 	} while (0)
 
-bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status);
-bool umc_v12_0_is_correctable_error(uint64_t mc_umc_status);
+bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
+bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 
 extern const uint32_t
 	umc_v12_0_channel_idx_tbl[]
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ddd782fbee7a..bb3e953bfed5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2524,9 +2524,9 @@ static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct
 		return 0;
 	}
 
-	if (type == AMDGPU_MCA_ERROR_TYPE_UE && umc_v12_0_is_uncorrectable_error(status0))
+	if (type == AMDGPU_MCA_ERROR_TYPE_UE && umc_v12_0_is_uncorrectable_error(adev, status0))
 		*count = 1;
-	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && umc_v12_0_is_correctable_error(status0))
+	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && umc_v12_0_is_correctable_error(adev, status0))
 		*count = 1;
 
 	return 0;
-- 
2.34.1

