Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAD1CD8C8C
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jun 2026 13:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472FB112E24;
	Sat,  6 Jun 2026 13:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DsBrXTe4";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915D6112E24
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jun 2026 13:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBI3goZtZZpO1jHK5IYZpr6Gnz92X3HxWhPktijTt9o7hzeTQyyCsu+/bYtZq8OYVThTeB3OHmWc8DzDyO/A8oBnPja/eX8mMXyx5OqJOZ5S1NRpSFkhdIj5/Tm/4xvtRD6Y3jGjwoMGBOq7sGNZD47b3AD/SEdCCp4sFuf5qVXBSBg2lAEr49qsEq91GFsPsAlv9FfexOyp8JyBS50DjWuVivTvE/FNFRJyIIReANONRENgNJ0FrwXd/R1cbzUBGrJZxx2D5s4UNHiZVklLmOahFV710j4gYKNeGlhLsAqb2hLbs+169Fg5jkzm82r4g3fRGOVGA0Cu41TCHBufJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDzmR/+KgPNG8ubXbpC6JGBK3aBa8VDCQ3g38QvmGcc=;
 b=inwvaYmSljKeGMDFdE9x/iKQZTX8Soejrh/VlC4VG7bIXYrJIN4KODl8zLZ7M2z3bi8eQJtkiwWh/Ur/u2To2LDj9IPfYpw6qu0QQOEs45uiK05TZfbS+eFWr+d4k0P4QxkgKz1M30iHtMUHeJdhxoD/JqAwb0NHTl8hkKCozy7MH5HvhZsmUrx8WIs7MhRBQ66SXvbbMWTtL+8RFlZI3w9Az+pAYWbA63rIIEO+SBQT+lkAvViveHK6RNBX4Emyn6rwAWm7m5mrx4l2JHfZDnIlAoKhGP8Hntj2fzHYgIoDt00VTJCSrMTxr/Y79oSVFqeTNEPrYrg53cy+YiKPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDzmR/+KgPNG8ubXbpC6JGBK3aBa8VDCQ3g38QvmGcc=;
 b=DsBrXTe4GkGtsQYiO6aHlU2kF4Clc73UHp6bwlTidtuWmH3KcITjicsvlzOJtzGWZUm2c0Nud24qfB4qq+thnETYl24m4p21iCHI5La/E2hsMQlbkkQa0QIVgKJOf49XJFMEPFzDg5he3lvbOqP9Opg71Oi2zc4M43KfP/+peZ0=
Received: from BN9PR03CA0595.namprd03.prod.outlook.com (2603:10b6:408:10d::30)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Sat, 6 Jun 2026
 13:31:46 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::18) by BN9PR03CA0595.outlook.office365.com
 (2603:10b6:408:10d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.11 via Frontend Transport; Sat, 6
 Jun 2026 13:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sat, 6 Jun 2026 13:31:45 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 08:31:19 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu/ras: added RAS EEPROM device support check
Date: Sat, 6 Jun 2026 21:31:10 +0800
Message-ID: <117a42d9579afd04366a096c2322021cefb34736.1780752510.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1780752510.git.cesun102@amd.com>
References: <cover.1780752510.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: c30209d5-bd55-41ca-c5ce-08dec3cff40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AKJEhigj0OSw9+gsDutXWPsPM+cgE+LZvj9uhXAHwR6jUHTP4WlDiC/gWWggQdcH+QlSylR/D1hgD8pxzjSFjl4SPh9qJpWk8xNntPu8frRxALgGXbaaIdXoo4ykLzqd38zQnhuysQfOTKzisPhfhQgZrbJ8PgurOr4NNFUQk4eH2p7jjK+Bg6NB6ybM4yPGKMqLs4FrHQBd86k8gxM1Oge2OHFVMmA6YF9d/UtmKLWKyHdYv/6WE0F4jSXU0UO5U7c4eUos30VJddBRTDXdTnL2EvjOaun38gD29Ej8hAFVd2TrYufMJp/vVzR+4i0iVAI2xSTy7v1AEPlnomrTQcDrh4IvweHCTAY6rSL1gh0w88zyYn5uVSotI40j7mSO/wi8lcJifWSOTSVFykUQrDJJ76Bv7IF+tzBFQrdVbvthQw0lAuaC1+nUKoqFkj4kjAKZYYoEcTiRQ8T49Wk++ToPy7YF7FgETSEAdh3QI3B2grHLVWXWaLU+kC1sL2a7niLTjs8dRdu0j3k4396E5ddYX5cuPI55o8OwqSD2SIPoqGUtmH3ADQ9LC4TN8Kz8by6ep5DpcIE1rnWiBPvIkpkaNth7ru869kaNBt62evCdE3REr3nE1+UJWV1Qr6fCsO3xZ7m8aMsKw01G2F5fqsQ4RVXVW+jdPqivHICEBt3UUa2/WSE0aL/bkvsXLovblS4bFynuzZphIv2UMHIIVba1oJls18H9ZDEC0+PBSCk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HYwWfiRdG5qvhxCNdU7jrE8m3AzhuUlYbuUIlnCyAaMkDHVXCyMUOEOtDJ7jrZ+d/4L264YDtFhda/Y8pdq305Cq0k8JRgiyayt9WL/gQJfdlcJydL8fCzXayX7/z0jQA9xHpgIwt0u7X3FSzL1xyZo5YBFkTi6EkG/ugvVpW1Lqfv3mwhFV2BYwe+YWfpQex1PR9RKVmE1hyipIHgB2wOB3qiwyhZyMVLuhLDOgIwGkMuMGfS5mQgl4juzBUZ3yLEKwuKTokhSI3H2xRS8BgcEUGbWSCcUmsRjLHkdSVwKxTgKwZ/3SAhQuxDH36HDRVSqJY+n0UttOIeDyFXYuPkVcnXdTObWeqJqXdq2JOG7vxoRF+a6m7LAf8FbwR7trBfK54hYtF9yQuUA+2rBwDOKmdWV6JZsVar0VMtwrmi9JVMAnNXFKcTU3r1pLvqgt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 13:31:45.3104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30209d5-bd55-41ca-c5ce-08dec3cff40f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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

Added RAS EEPROM device support check

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ef09a6fad659..26f554a80e1a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -142,6 +142,21 @@ static int amdgpu_ras_mgr_init_eeprom_config(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool amdgpu_ras_mgr_eeprom_is_supported(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 14):
+		return (adev->gmc.is_app_apu) ? false : true;
+	default:
+		return false;
+	}
+}
+
 static int amdgpu_ras_mgr_init_mp1_config(struct amdgpu_device *adev,
 		struct ras_core_config *config)
 {
@@ -266,7 +281,8 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 		init_config.aca_ip_version = IP_VERSION(1, 0, 0);
 
 	init_config.sys_fn = &amdgpu_ras_sys_fn;
-	init_config.ras_eeprom_supported = true;
+	init_config.ras_eeprom_supported =
+		amdgpu_ras_mgr_eeprom_is_supported(adev);
 	init_config.poison_supported =
 		amdgpu_ras_is_poison_mode_supported(adev);
 
-- 
2.34.1

