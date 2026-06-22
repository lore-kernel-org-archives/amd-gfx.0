Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BD5CDB476
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCC710E55E;
	Mon, 22 Jun 2026 08:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hcr5LGPb";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066BB10E563
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh+EWzONiljpoLBqKM4loKPc0iGEKY1z1rqoCtiT0my4io9OwFY0NziGFFZ90v7bSQHPZoX3iIgiChPPeObQr+MK7IUBd0iaNry8tgzpOxXVWdRn3RQxDkKwrpw25+NiWPlLMPZOVLB4NRKUbNeKCHHvnbZ/E10BOvw+cB4JkRuxZrrwCucr84DxMbVKSPYHbvpZyTd6k0rhe3/JykfDbvN4IR7FuR/PH2uAYuivUkCrW+z1qDuCKReWK+fdA25lpB+tJ5ZqDGb6Nhz3voMIXEbn9Q5Z0n7VbVg+Mx/dFiyDyo1LgEY8wM2FTygX0Uu7RZ79cSS1cg64RHcl+RA8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBurd0NrK9AYA2Egh8T0nK+J1XhBAV5bN94F0bYqiTo=;
 b=S2OnQ4qsykf3bxwt2pYX1pYExx6ra7y8xTBNgkZGIE8Iy0tOgWIFes/HZYFwMg7qIabiXKJ2cOwOieKhBbeVLYWygueGGVjRl3LECnDfnbdC8kCXcIhqtXghAIWaMNYkb9re+FMywho3cMkPu1CARSlX4iqg1dKxreMr6b76ZN+xDk70DPU59zCrza+5AaD5AMEFCpxcufA7e57LqVtfRVm1j9ccats6brCnXuuHBYDjJtS27oMjk6Ps7D1OivUoq+rcifWF4qnvoWFVtlwG1J9D3cozi6dTtBEHTjd8eXwZKQhvn1wSAUSPkEbWwAvPPQpn+gLdqSIA3l5REW2yxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBurd0NrK9AYA2Egh8T0nK+J1XhBAV5bN94F0bYqiTo=;
 b=Hcr5LGPb0g/Mxnawd9F2LXYp7lCJXNifiuh74lAQ9eCQDlin+T0Dcwmadykz/Q5SJ/uZRGtk6q1m8/3OzfJZ6sRWbKemsEM4fDNpfum351CYswzySFx6dUirYgvvXEfOBYDeWmGfiucPBM0jnwwqx5pTBIPSjF+S4Ovkvoc2AwQ=
Received: from DS7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:8:54::23) by
 CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Mon, 22 Jun 2026 08:45:47 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::73) by DS7PR06CA0042.outlook.office365.com
 (2603:10b6:8:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:47 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:44 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 19/48] drm/amdgpu: retire legacy RAS reset/query operations
 for XGMI v6_4
Date: Mon, 22 Jun 2026 16:44:21 +0800
Message-ID: <a45d02b4c23d3e9a44bde07c9a1ede19c015c6c2.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1b8c6b-ec03-4358-862c-08ded03aa795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 3aVBrdUcZ9tfZM+Pj59Y0IA9p0dYZcID8UFnSpQVaEGLDsQnS8lhTZqOp/nwZXxgvZpOozoOQnQkIipqNFh85yb4yV7+hU+iBHNXuuE8c+vN0j9a7l67i8Ad36DFaSsjE4wce7fCqxqUHzZ17PJ0pInBqyzE6sWhqmjHgq98H+dR/8tTo0FcUl6LWdTDMeLuErGZUzuE6cj90UkSN/2cb3W7J7Hr9YnUaYHzgmCoaG3yLLD4m5GCrqqza36qESi4o8UwTIHwfpHexIeA3+CYOGFqL3vzQOk8AGyOrXDgU0ES4XtL+iiZR49NfqIk+RqJVe05Jt9rwqJfhxGqzH3u6k3iQTVY8KTFMWYWwPuV3/CpoHCiZAy6jewIS7nIKlvokuZV+KO59EYzLkDA2vG/iyL5ypnGdutoh3ivc+h0HeRCvpFK3bJZyFi3Wc3TwG4TsPze+mYkTArvjBBFklJBXkvY614NUtIa76lZP/Z59jBueajyklgYBnUPTqijHMgIRHcUPBI3Z5stXyN7F6FAM/G4mR+1TQK7Tg6c0aBXP/glfV4CeNRKmOmYhuVUKGM1gScznm1ZD/Riybzg2Z9y3j7pviYK5xQMZWvlzAzdOw8ajDD4/wiR87MyNeY3YgV6XTbeN0kCEqoNf5/Tr2tptpJSkXHoWTvlXxaP6IIbVk8q5Tj09vQVLbI/HS7f4jpS0+l0mejFr/jvGE+Et/3Ojw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: juNzH8VI4ysKs8p/iJe8arD9OAUoAtr6uGmhlaUrOfOMy4YGnvJgrlx1UiLZP5d4wlAiBOY9vMTwQc9FcF8rIhya9ePEPKQY3D1iAbpladrHcDzmGuvGit5BVnBuKeFCImN7GVmFX5gEoVBymb5eZWVBljczDE6ch1918XKQDgO5LkncQ5qZ9RO6NNaIxP4t9HBA2JNnP3VhM9ToIB6suqru0UTFawgrV+oPLxRrWWnap6WbDmLVyxeofv2QB2srLmMWjoL75D3UggnObcQysvvq9OMwl0489zg0KJht5CFE9+mXkU1cCsIjSY4XjPnSJ4mrldwTkSFcH6ZkMn6e5enhahkKDwCoPZHG1bwZlcAmQfPIRrh8EttPtbzQPzlKT0mpUSanR9mnMXY2vS86YFt4GihWRf3fDEZDgRBFq7F7t0tCcRJ8ZL2mKXA+m93o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:47.0595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1b8c6b-ec03-4358-862c-08ded03aa795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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

retire legacy RAS reset/query operations for XGMI v6_4

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 49 +-----------------------
 1 file changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5fa706915d49..59c76fe3c56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -106,16 +106,6 @@ static const int walf_pcs_err_noncorrectable_mask_reg_aldebaran[] = {
 	smnPCS_GOPX1_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
 };
 
-static const int xgmi3x16_pcs_err_status_reg_v6_4[] = {
-	smnPCS_XGMI3X16_PCS_ERROR_STATUS,
-	smnPCS_XGMI3X16_PCS_ERROR_STATUS + 0x100000
-};
-
-static const int xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[] = {
-	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK,
-	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
-};
-
 static const struct amdgpu_pcs_ras_field xgmi_pcs_ras_fields[] = {
 	{"XGMI PCS DataLossErr",
 	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataLossErr)},
@@ -1165,17 +1155,6 @@ static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++)
-			pcs_clear_status(adev,
-					xgmi3x16_pcs_err_status_reg_v6_4[i]);
-		break;
-	default:
-		break;
-	}
 }
 
 static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
@@ -1193,11 +1172,7 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 
 	if (is_xgmi_pcs) {
 		if (amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 1, 0) ||
-		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 4, 0) ||
-		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 4, 1)) {
+		    IP_VERSION(6, 1, 0)) {
 			pcs_ras_fields = &xgmi3x16_pcs_ras_fields[0];
 			field_array_size = ARRAY_SIZE(xgmi3x16_pcs_ras_fields);
 		} else {
@@ -1235,7 +1210,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 						     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	int i, supported = 1;
+	int i;
 	uint32_t data, mask_data = 0;
 	uint32_t ue_cnt = 0, ce_cnt = 0;
 
@@ -1299,26 +1274,6 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		supported = 0;
-		break;
-	}
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		/* check xgmi3x16 pcs error */
-		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++) {
-			data = RREG32_PCIE(xgmi3x16_pcs_err_status_reg_v6_4[i]);
-			mask_data =
-				RREG32_PCIE(xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[i]);
-			if (data)
-				amdgpu_xgmi_query_pcs_error_status(adev, data,
-						mask_data, &ue_cnt, &ce_cnt, true, true);
-		}
-		break;
-	default:
-		if (!supported)
-			dev_warn(adev->dev, "XGMI RAS error query not supported");
 		break;
 	}
 
-- 
2.34.1

