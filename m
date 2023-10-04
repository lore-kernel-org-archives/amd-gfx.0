Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4258CE7B611
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 13:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C252B10E0EC;
	Wed,  4 Oct 2023 13:21:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E1710E369
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 13:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC/Qztu5OUgeJTdR84SwrY2hknsR6HDupd8moJ7QMTI3Wcx1maNRDJAylRJRSf9+hLlgseHPW+sdnXTgroN7uTFrNro/kcVznsTswU+961UsdKQuOsbR/CNIyXDgJZ4WVEu7qr6Ei8TiVtmuwGJ2aidUCjJZEBuEyxbVnpcNDLyoIDAwcBOaMO8pGWufb77/2WEgwPwV4hP5aZyjaXOUDf7zFIoTt3wLkvVXeI44He1x2IXdPGpFbZdIZAGmbSAYvOHNPkzOLq3AeuuSPllPz8oGxg4sgvl0rBYX/KBZMzdW3d0Hl3Ixu2dybAshgnZdXiRfcjZo8hYCIsAVP8dePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ze0yqW6KrZcvbgp1uGVgq83LzvbefidK0cEewbsk4g=;
 b=WkUQP5gDQehYSFmG390VC3GASlfClerurrDmcoxY1e51JQ8arcyekIJALIjpSz5npQ08xdjvouuSv8gDTvLZaa02e2kwd8rr2WNF/bXHkIPAW0Yq0bdVnF8kQz/tWKkK3jRcslCAGU+DRoGITjCms826f8ZIxR2cyp6qMvgwVGvVoR9+Yj+6yJCZrelop2hSSEKCa5QeGywZjkSbdzD4SuKuL70E0fG+rAS/IGBN5T+T0eoqkP5sgxU14OKgBLzhnPVoHNRhV0NJLm0Ut6Z0Z/++w843H22gs1bySwIdxSN0I43dimio/apzCE1gzra85w7CXRbUhVlebkW3ynIu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ze0yqW6KrZcvbgp1uGVgq83LzvbefidK0cEewbsk4g=;
 b=zcjg/9BJR8+cXWcra7QgURDfZCUp7rWQm0/7Ovrgp4/gjqi35A5GHc4UdOAIxEqzZnfdg+iv23A8aD2ZnCqKivgcZXlGDv3+q6ZvBcmeg0tMeAv0B5RfMJjq71PdJd5kc5LIjcKPSVwOnj3cL/PEiYh+b1EfWl4ED6elcPrADY4=
Received: from PH8PR02CA0018.namprd02.prod.outlook.com (2603:10b6:510:2d0::8)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 13:21:02 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b9) by PH8PR02CA0018.outlook.office365.com
 (2603:10b6:510:2d0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Wed, 4 Oct 2023 13:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 13:21:02 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 08:20:58 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: enable FRU device for SMU v13.0.6
Date: Wed, 4 Oct 2023 18:50:36 +0530
Message-ID: <20231004132039.1506172-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CH0PR12MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a97e8ef-aa9b-4938-d7ec-08dbc4dcc1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fiysD8wxsr8FaU+Jnq7TYu0HMmoczI8G5w7fRlvdTQ1qdJEpcY7dFHcBsGiLyZ5Xi7meI67UvPAGjawxqRhRIIeWOmEEkKr5Gv8x11GMSRqHR11RnTwelSca34zeP/ieVa+WvxT9YgkRnePHwxhVzx4hQD70amOpMdXpXHT0oypfl518XwRbzfsi5rvkY+thJToufNf0IFoXolkcrVaQUoz4iLFqN+efgyYATPTLZ1RbU2CUDTtg2NsLuiKKNe2kKEdkCIpMw7xLcmR5ScLCGiZJDYaWGjbDOHlmfFb60ssiiVZk2bxU4rWvWdNqX7TF+INUBEQxKuhwVrUm7KD5GVJkOA1feC0wYSJdF+GgXQGJEiP9c3i01yf97Y8K0cLcF3TnLM9KN7OhmY5PsBOS/aMYWJKzhq1t6ymgv96P4Fb8xI1NfkMVc3Ijrhu31W8LKSD1Ss9o0UW5nrtGELW7s1dt8hJGGQK1PBFR98JMFXX+A9ksk0uQK2PcFoPUa0Rq5y9TaJxUOqbipY79AK4vhrXbU7QFsdgbZtsirNefYv0K6PLqvmJR/OabISnMKzeDExGklCLTYaVK+VK0gS6xtSM1hjSzqAMc+jTItfaz+oz5QkEWJN5RsLHnDDp3mHyudok+tJZNxSoPEmuHxIWpCGGvY2MD0KJKNXOq4N0A7O4kgAAopnq7aFsYbEE3JGyC+t+V0GvtjBArHBkvWT4VAyuLNlS5mhKO7Q9+mebXEfZuwhhvZPRQjwHKDtec/pMypuIjrTHlJPArIpGho60mQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(47076005)(2906002)(83380400001)(40460700003)(82740400003)(86362001)(81166007)(36756003)(356005)(36860700001)(40480700001)(6916009)(316002)(54906003)(70206006)(70586007)(7696005)(1076003)(41300700001)(2616005)(336012)(6666004)(478600001)(426003)(4326008)(44832011)(8676002)(5660300002)(26005)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:21:02.3808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a97e8ef-aa9b-4938-d7ec-08dbc4dcc1af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <kevinyang.wang@amd.com>

v1:
enable GFX v9.4.3 FRU device to query board information.

v2:
use MP1 version to identify different asic

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 48 +++++++++++--------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 7cd0dfaeee20..d0ae9cada110 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -57,27 +57,26 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 	 * for ease/speed/readability. For now, 2 string comparisons are
 	 * reasonable and not too expensive
 	 */
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-		/* D161 and D163 are the VG20 server SKUs */
-		if (strnstr(atom_ctx->vbios_pn, "D161",
-			    sizeof(atom_ctx->vbios_pn)) ||
-		    strnstr(atom_ctx->vbios_pn, "D163",
-			    sizeof(atom_ctx->vbios_pn))) {
-			if (fru_addr)
-				*fru_addr = FRU_EEPROM_MADDR_6;
-			return true;
-		} else {
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(11, 0, 2):
+		switch (adev->asic_type) {
+		case CHIP_VEGA20:
+			/* D161 and D163 are the VG20 server SKUs */
+			if (strnstr(atom_ctx->vbios_pn, "D161",
+				    sizeof(atom_ctx->vbios_pn)) ||
+			    strnstr(atom_ctx->vbios_pn, "D163",
+				    sizeof(atom_ctx->vbios_pn))) {
+				if (fru_addr)
+					*fru_addr = FRU_EEPROM_MADDR_6;
+				return true;
+			} else {
+				return false;
+			}
+		case CHIP_ARCTURUS:
+		default:
 			return false;
 		}
-	case CHIP_ALDEBARAN:
-		/* All Aldebaran SKUs have an FRU */
-		if (!strnstr(atom_ctx->vbios_pn, "D673",
-			     sizeof(atom_ctx->vbios_pn)))
-			if (fru_addr)
-				*fru_addr = FRU_EEPROM_MADDR_6;
-		return true;
-	case CHIP_SIENNA_CICHLID:
+	case IP_VERSION(11, 0, 7):
 		if (strnstr(atom_ctx->vbios_pn, "D603",
 			    sizeof(atom_ctx->vbios_pn))) {
 			if (strnstr(atom_ctx->vbios_pn, "D603GLXE",
@@ -92,6 +91,17 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 		} else {
 			return false;
 		}
+	case IP_VERSION(13, 0, 2):
+		/* All Aldebaran SKUs have an FRU */
+		if (!strnstr(atom_ctx->vbios_pn, "D673",
+			     sizeof(atom_ctx->vbios_pn)))
+			if (fru_addr)
+				*fru_addr = FRU_EEPROM_MADDR_6;
+		return true;
+	case IP_VERSION(13, 0, 6):
+			if (fru_addr)
+				*fru_addr = FRU_EEPROM_MADDR_8;
+			return true;
 	default:
 		return false;
 	}
-- 
2.25.1

