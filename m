Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F346C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 08:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551BB10E437;
	Tue, 16 Jan 2024 08:21:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319DB10E437
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 08:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi6lv9nuvfV2jXh9USlUBWVJo9pH9SGwur88XgrSZn7AEJ37flqz4v9Ei0yA0544Kj8wgJ9la2g+tUvRG05nEfb4HD+Oa7OIvQvarkQBQn5FFuC+lbYWIyr9WU28ht7wV3v1xc6X7n2w3G16mT4OlBsiwAEEnKn0sVkty1qAzNOKEYmfbjneHeW/t60NXSU/XNjXcpPfj0g1dIbXbRBFtAaBr23Xsqb8Bhic5f8dfO6Uq7+vKE1EdMc90kfyoqFIKNJ7ioI+tbLi8qNaKdLLcfUJn9t4CSuKCFoDOyj1roNPyKvxImG5Hu4hA1prirpygoabEWXIUedxcFytaLV63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHhaDTzKns7Afbi2YlWoi6YADuokRfbP55Q5JVfzBK8=;
 b=XngsiSbyc6gg1aizfg7sDUuuN0hKQNiovTlGMd+c6qR6ics55BZAa9HXV4JwnObuQJvn47szqqLIztU05HV1DwmoWp5XF2ZskDBDq0YvR+Y6YuNGFEELR7CORP9VQQRJDI7tLqaKBB5F/BMvprni6od529qyajDswEYOmI/7zIod8l8+hUCfwSyBKjdgjBSaDTNeqkHB42U5fsiqsFRYYEc7XESkQ++jmsDYTd1+A/OE44+lU5iOpuhhsH30OqH3Ciqodh8layybGNyfQwEmkA4h1hkEddq4OOSnoP2UoPbH7wgfJr8KEvcmt4DSRPQrbZwZx+zgswODI5e11H+GTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHhaDTzKns7Afbi2YlWoi6YADuokRfbP55Q5JVfzBK8=;
 b=31mM5aRs6YqEaPJrSdXDKV/b7fUXFuh1it5aEl/DGYjGgTzYfwaEHwKoo3E0PbYJ/1Odly8M47GUFLhGsyz6cAYOORjOL64Bp70FNonGcWB5PWqDuW50+aBe/QAYIZd8Cx+f9XpcTrKx0ik0JhKHEHaUfZ6a2wRh/v257C2D/Ao=
Received: from MN2PR19CA0017.namprd19.prod.outlook.com (2603:10b6:208:178::30)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 08:21:19 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::7) by MN2PR19CA0017.outlook.office365.com
 (2603:10b6:208:178::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28 via Frontend
 Transport; Tue, 16 Jan 2024 08:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 08:21:18 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 02:21:16 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: add interface to check mca umc status
Date: Tue, 16 Jan 2024 16:20:33 +0800
Message-ID: <20240116082034.1739848-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: f748a3b8-b89f-4269-3730-08dc166c1d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wwvP1Qv19AsgkTT6bZb9uXZi2LSY9IwnOE0uYM9den7/B0C/j9UB7r2EzyjYC+IVptnuhmAq+ZjQ8zzdk9JO96Y0zlWCxB0yjnHzinAGjzElGjmAK4BWHDy4xyjj3RwxTKN74JS1j7mznel6QVqs+gDhhy/bjnuQKvT9kvLsXtkOHXr8Qeb0kLkumna4b8NwXoM2rDqpgFf2514fY+YpYdAZhKzOuJuCcXbebCiYcpRG4Xlm2YwZjvzcUcEHsIB3/z0+bX2tLvqvSh5+2BXahp1T0DO9FToofd3jsl7IS4WoLxswxuDOkTOw0DHnKf3F9wMfIFzk98hmsX1HWoLjcUhefzvjblMCOl4qbItfdXR0u5wQEaS9ppCsr2k1VWWkGqZUC55xUmkte9kapXwCxb3rf6VVSLVlIUXgKiDBpH5Zdr3ngPig18mCveWFVOWXmGC/JHLT/C1wEf+V78JIq/VBYnSfl5kOAp+ZZMqxoMcQp76T8CpFlqrvFCUJb41Nwm+48hqOsUaQORJWBT87iyH9t+GrQSM1GPyzgjLxhZkgxrImkrTw05aw4U5nPOi+SsKcJojYO6JOwLMSpMd8vVozlZGe154g7dRtsl+wABLiwtHXty/Erij9edIz32Q1bb4k7aV94wKJO3GV3VAhlMhb33fvT9fbAOKYWMRIwkAJUXlKSjaFLlsJRVme+USqtZrcAos7nfzivufGOY7euf7IpWXgR0C1BySOG8inEqy0tfMiYHCtp7pz79lXmCO1ijV00+4x+JJRO1Lfk7Rfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(36840700001)(46966006)(40470700004)(1076003)(40480700001)(40460700003)(336012)(6666004)(86362001)(7696005)(2616005)(26005)(16526019)(426003)(36756003)(82740400003)(356005)(81166007)(41300700001)(83380400001)(47076005)(2906002)(5660300002)(4326008)(478600001)(8936002)(70586007)(6916009)(54906003)(70206006)(8676002)(316002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 08:21:18.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f748a3b8-b89f-4269-3730-08dc166c1d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to check mca umc status.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       | 12 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  4 +++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        | 20 +++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 +++---
 5 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index fde20857b3dd..65ed8bb5c120 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -27,6 +27,16 @@
 #include "umc/umc_6_7_0_offset.h"
 #include "umc/umc_6_7_0_sh_mask.h"
 
+static bool amdgpu_mca_is_deferred_error(struct amdgpu_device *adev,
+					uint64_t mc_status)
+{
+	if (adev->umc.ras->check_ecc_err_status)
+		return adev->umc.ras->check_ecc_err_status(adev,
+				AMDGPU_MCA_ERROR_TYPE_DE, &mc_status);
+
+	return false;
+}
+
 void amdgpu_mca_query_correctable_error_count(struct amdgpu_device *adev,
 					      uint64_t mc_status_addr,
 					      unsigned long *error_count)
@@ -257,7 +267,7 @@ int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_ras_blo
 			amdgpu_ras_error_statistic_ue_count(err_data,
 				&mcm_info, &err_addr, (uint64_t)count);
 		else {
-			if (!!(MCA_REG__STATUS__DEFERRED(entry->regs[MCA_REG_IDX_STATUS])))
+			if (amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_REG_IDX_STATUS]))
 				amdgpu_ras_error_statistic_de_count(err_data,
 					&mcm_info, &err_addr, (uint64_t)count);
 			else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
index b399f1b62887..b964110ed1e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -65,6 +65,7 @@ enum amdgpu_mca_ip {
 enum amdgpu_mca_error_type {
 	AMDGPU_MCA_ERROR_TYPE_UE = 0,
 	AMDGPU_MCA_ERROR_TYPE_CE,
+	AMDGPU_MCA_ERROR_TYPE_DE,
 };
 
 struct amdgpu_mca_ras_block {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ee487adce7e4..a46742595bdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -21,7 +21,7 @@
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__
 #include "amdgpu_ras.h"
-
+#include "amdgpu_mca.h"
 /*
  * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
  * is the index of 4KB block
@@ -64,6 +64,8 @@ struct amdgpu_umc_ras {
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
+	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
+			enum amdgpu_mca_error_type type, void *ras_error_status);
 	/* support different eeprom table version for different asic */
 	void (*set_eeprom_table_version)(struct amdgpu_ras_eeprom_table_header *hdr);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index fa2168f1d3bf..1e8e97d72f1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -425,6 +425,25 @@ static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 	}
 }
 
+static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
+			enum amdgpu_mca_error_type type, void *ras_error_status)
+{
+	uint64_t mc_umc_status = *(uint64_t *)ras_error_status;
+
+	switch (type) {
+	case AMDGPU_MCA_ERROR_TYPE_UE:
+		return umc_v12_0_is_uncorrectable_error(adev, mc_umc_status);
+	case AMDGPU_MCA_ERROR_TYPE_CE:
+		return umc_v12_0_is_correctable_error(adev, mc_umc_status);
+	case AMDGPU_MCA_ERROR_TYPE_DE:
+		return umc_v12_0_is_deferred_error(adev, mc_umc_status);
+	default:
+		return false;
+	}
+
+	return false;
+}
+
 static void umc_v12_0_err_cnt_init(struct amdgpu_device *adev)
 {
 	amdgpu_umc_loop_channels(adev,
@@ -510,5 +529,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v12_0_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v12_0_ecc_info_query_ras_error_address,
+	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cee8ee5afcb6..751d91de2795 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2570,9 +2570,9 @@ static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct
 		return 0;
 	}
 
-	if ((type == AMDGPU_MCA_ERROR_TYPE_UE && umc_v12_0_is_uncorrectable_error(adev, status0)) ||
-	    (type == AMDGPU_MCA_ERROR_TYPE_CE && (umc_v12_0_is_correctable_error(adev, status0) ||
-	     umc_v12_0_is_deferred_error(adev, status0))))
+	if (umc_v12_0_is_deferred_error(adev, status0) ||
+	    umc_v12_0_is_uncorrectable_error(adev, status0) ||
+	    umc_v12_0_is_correctable_error(adev, status0))
 		*count = 1;
 
 	return 0;
-- 
2.34.1

