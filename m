Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A4C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 04:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E550A10E152;
	Wed, 12 Feb 2025 04:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d+AMUwiP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A4B10E152
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 04:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoLpgWsx9ZFRRDXXYZRAys8Yi7WBGtjBlsKh8XaDoLI8ZDtyDPr4cDXsURqyNy/LCEA7tsmZr7CZV0vrqCuDaMS2+8xBKCXKRXmjiD18cTLUhja6ApJV3jUcnN1iorunbexq5YrHx8iNadzg3HAM21myggBZ/JAgWGyzkFjz+Roy40dDm37PlYh8EZA9x9n58seRwPzry2TEhHcM5sLRduyYc3mvMB9R42a4L1GsIaENNPGzJ9ToH6SMCqvVLn5IEsltbLRa2pezsnNtHtnMXrMBFZbu5pqLJPWADbdFkBTxiwbJRmmbF/KJ0W9DRIicLgT4Wuscu4guqH9Es0ddaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2Ig8MicJ8pxChoasz13amFo+mQhskDKdXbWGg6ZydY=;
 b=wMhmDNz3YC2rwiRWfzPnvwbzgwO5lZfiUgS1XPCKqauh6yKC/m+KLlwJx/nIw++bPGNW441WJqiisMM/yj+T95f4naVFEbctrlWY65/E6fCJGETchC31gwaU9dvFxebvGz+oqXrjbMU32XZ32N1BJjeKv7DjG9zRjw3x0Qfv8zQZUalxpaUcKkBApHnH1wZhNa2dUSt/fRmAwGJltWoyPTYweGAJw84StQjeTo1kQCzLWqwp3QcogBJ3aMCWHNMeooXc+kDK/wCxQMVphDiAVG9u+fH5Y/RxY/3fwlZ/qFMKNkHdv6JAZ/I/i/AD8Sb3lO3bQXz8twcOpHfG9EP3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2Ig8MicJ8pxChoasz13amFo+mQhskDKdXbWGg6ZydY=;
 b=d+AMUwiPs3MJgkwLldkChLlqKmETupqbRszA0qpKwgkKZVOOSfzBAl9zU/FvkEbA2rAxw29RT4qJo0xAkYMkbnWqOu/3MPORMwP4ijbRXdG+wQb2wmCKJVRee4PqPrMV5GN/qWgifaXTl2xG+g8to/Bkm2iC2/WKTGOqCBlDoFg=
Received: from DS7PR03CA0162.namprd03.prod.outlook.com (2603:10b6:5:3b2::17)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 04:25:12 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::4a) by DS7PR03CA0162.outlook.office365.com
 (2603:10b6:5:3b2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 04:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 04:25:11 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 22:25:09 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Optimize the enablement of GECC
Date: Wed, 12 Feb 2025 12:23:21 +0800
Message-ID: <20250212042321.1612148-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: ecacf4e0-08cd-4a92-e74b-08dd4b1d3db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gDvL2eDfxc0S79PfCJ+fCZAseQ06auILGyrPWJg9yddJNE8oBuelQOB6XgqN?=
 =?us-ascii?Q?NJSGl1huGYg6gHPGdxvMAxhi52Ks+gi5kgQdXGm7PwxVqDZiEdFrXBoAbVbf?=
 =?us-ascii?Q?XECX8zJPQD7vD2fu3wne5lot0KHT5T+/KmwjTuHoIn4dAwOPH0SJtD+j9nrL?=
 =?us-ascii?Q?obBI0g9HUgjPRS/5B4zRO23Gg+MNk2u1THeHqXKhrZVt/WOfisCeXqfDx6R5?=
 =?us-ascii?Q?3YXSNpEttkIBb9sRlOh60Qn+Umz9W7QFX6ehn96QK/w1ONIY4DY9QZw8Rxtu?=
 =?us-ascii?Q?o+TfcQ4Om4s8p1Q4ELjWywwgL4yWhT0I9xAg1DCK7mRtcDxpLI0JxCsmnEK8?=
 =?us-ascii?Q?yfPEevqUSb3OG/oCJDOx8uhZHytxvpfdBbePv+UBNL4IolZaOsRsQPtqmjM+?=
 =?us-ascii?Q?fRd1hmrKOtU0AH/bYgCYeUhKta/ZvtCV+U9aJJ6d8S0sAet21Zkrxj0eYM6d?=
 =?us-ascii?Q?0HKNQLGlLuZ9uEoDEqpv2ealhXW9ClOQbqwJvQCgO4mUH8nDMQ+SL4lClpuh?=
 =?us-ascii?Q?w+hCDxkEuOY286IyfKzc95+jr6hcwGLIGL/bGiENRB6FejCm/e/0D8z8uGr6?=
 =?us-ascii?Q?iRSz/r6dGFha9MLDwlIM5kLQqq8APX3dYYMibIFKMiSTd7y/Qb6LA5sJFKKD?=
 =?us-ascii?Q?HEf+hqKRWUcZ18qdOlmhzZqWOnOveDztZvYKQ6zCcFUUxZxYdpZg8OqNp+lp?=
 =?us-ascii?Q?dpfdoj/5X9cYCdFSAZt792jNZX74lCmZ/bArVRw6Xy6R86v7yz1FJzOTHS9Y?=
 =?us-ascii?Q?U7GJtBJFZw6Xy2PjUv820YIb7hU2dHcVhjsS2nmnm216Ij8hzBktG3GmVoZk?=
 =?us-ascii?Q?gTv+Wmlf7qqlISiziwfQQKladDAgnM9shBiQafxu1OgxJKkNIUhDn4CC0JR1?=
 =?us-ascii?Q?OWdinJWKjpjE8CmrxgC1sIb32ZDNZon6+kiEi3xfXkxRGD2NTAFvxeJuBNlk?=
 =?us-ascii?Q?+e0yIPMSH7DyyHhGTCm+aJ0x96SKXaW8+3Ky5y26Ofkm8m2VVH4W3auWot0b?=
 =?us-ascii?Q?JUPBxMMpGs+CMWHN4eELsmxPXBswMkLNAT9tMpjTfqWR+4O2PbDk+HGeIVBA?=
 =?us-ascii?Q?LGnQxrEAJIpcjzizqGi1WERjrR9uXa9rsOB8Q68VIVTQKdUfKLSREM6yf47i?=
 =?us-ascii?Q?7gGuxUR2dL2BiL/dE7mxX56KLbT79MhgAP11fQaNGFkaQlIGWFgPhjBeJa4M?=
 =?us-ascii?Q?nUS78uxpoIeUFdhdMlWRKzSNSMLf9eG3WMNRH4g0UOtMubjKFeMUkrcIQgE/?=
 =?us-ascii?Q?wFOEfCLTdcUjch1PCKCTXrR7t8BJIdGGyJuuhhR3ltChWqPakplmXzFiAv58?=
 =?us-ascii?Q?QgaKTPIj6eU0rGRmCttQple+dpOt86Ia12SMh1zuDbvc9GCPckWnCa33i1Nr?=
 =?us-ascii?Q?e7fmT3SwxM4XOEx7n91G3XYRp8PCNXLnTXy90O5kBF/dkAtio5xKdruB1Esv?=
 =?us-ascii?Q?MSiRSlgbpUhsiVeWnCosOmdZGrisyM+pTSYp2dW1hk6v+TK4JlbgMQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 04:25:11.6447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecacf4e0-08cd-4a92-e74b-08dd4b1d3db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
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

Enable GECC only when the default memory ECC mode or
the module parameter amdgpu_ras_enable is activated.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 18 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 31 ++++++++++---------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c03a586eb5a26f..7f84cc66a19b34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1167,6 +1167,7 @@ struct amdgpu_device {
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t                        ras_hw_enabled;
 	uint32_t                        ras_enabled;
+	bool                            ras_default_ecc_enabled;
 
 	bool                            no_hw_access;
 	struct pci_saved_state          *pci_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index f873dd3cae1606..eb015bdda8a749 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -549,9 +549,10 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 	u16 data_offset, size;
 	union umc_info *umc_info;
 	u8 frev, crev;
-	bool ecc_default_enabled = false;
+	bool mem_ecc_enabled = false;
 	u8 umc_config;
 	u32 umc_config1;
+	adev->ras_default_ecc_enabled = false;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 			umc_info);
@@ -563,20 +564,22 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 			switch (crev) {
 			case 1:
 				umc_config = le32_to_cpu(umc_info->v31.umc_config);
-				ecc_default_enabled =
+				mem_ecc_enabled =
 					(umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
 				break;
 			case 2:
 				umc_config = le32_to_cpu(umc_info->v32.umc_config);
-				ecc_default_enabled =
+				mem_ecc_enabled =
 					(umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
 				break;
 			case 3:
 				umc_config = le32_to_cpu(umc_info->v33.umc_config);
 				umc_config1 = le32_to_cpu(umc_info->v33.umc_config1);
-				ecc_default_enabled =
+				mem_ecc_enabled =
 					((umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ||
 					 (umc_config1 & UMC_CONFIG1__ENABLE_ECC_CAPABLE)) ? true : false;
+				adev->ras_default_ecc_enabled =
+					(umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
 				break;
 			default:
 				/* unsupported crev */
@@ -585,9 +588,12 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 		} else if (frev == 4) {
 			switch (crev) {
 			case 0:
+				umc_config = le32_to_cpu(umc_info->v40.umc_config);
 				umc_config1 = le32_to_cpu(umc_info->v40.umc_config1);
-				ecc_default_enabled =
+				mem_ecc_enabled =
 					(umc_config1 & UMC_CONFIG1__ENABLE_ECC_CAPABLE) ? true : false;
+				adev->ras_default_ecc_enabled =
+					(umc_config & UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;
 				break;
 			default:
 				/* unsupported crev */
@@ -599,7 +605,7 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 		}
 	}
 
-	return ecc_default_enabled;
+	return mem_ecc_enabled;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 196b8dbffc2e28..06f6bbdc7f5e9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1794,7 +1794,22 @@ int psp_ras_initialize(struct psp_context *psp)
 		if (ret)
 			dev_warn(adev->dev, "PSP get boot config failed\n");
 
-		if (!amdgpu_ras_is_supported(psp->adev, AMDGPU_RAS_BLOCK__UMC)) {
+		if ((adev->ras_default_ecc_enabled || amdgpu_ras_enable == 1) &&
+		    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC)) {
+			if (boot_cfg == 1) {
+				dev_info(adev->dev, "GECC is enabled\n");
+			} else {
+				/* enable GECC in next boot cycle if it is disabled
+				 * in boot config, or force enable GECC if failed to
+				 * get boot configuration
+				 */
+				ret = psp_boot_config_set(adev, BOOT_CONFIG_GECC);
+				if (ret)
+					dev_warn(adev->dev, "PSP set boot config failed\n");
+				else
+					dev_warn(adev->dev, "GECC will be enabled in next boot cycle\n");
+			}
+		} else {
 			if (!boot_cfg) {
 				dev_info(adev->dev, "GECC is disabled\n");
 			} else {
@@ -1809,20 +1824,6 @@ int psp_ras_initialize(struct psp_context *psp)
 				else
 					dev_warn(adev->dev, "GECC will be disabled in next boot cycle if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
 			}
-		} else {
-			if (boot_cfg == 1) {
-				dev_info(adev->dev, "GECC is enabled\n");
-			} else {
-				/* enable GECC in next boot cycle if it is disabled
-				 * in boot config, or force enable GECC if failed to
-				 * get boot configuration
-				 */
-				ret = psp_boot_config_set(adev, BOOT_CONFIG_GECC);
-				if (ret)
-					dev_warn(adev->dev, "PSP set boot config failed\n");
-				else
-					dev_warn(adev->dev, "GECC will be enabled in next boot cycle\n");
-			}
 		}
 	}
 
-- 
2.25.1

