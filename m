Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82E3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F94A10E8E5;
	Tue, 26 Apr 2022 18:29:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC05D10E69D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAxFQTthgO8uW7kzNm0QBN0ORLgM7b6mGpJk4e+YN+AK5bxOJXBU3GE5EAzTJXpAoBtFnvu+MnJkzGy+SYf/6QAEyBQ+X82mIv92sQxdE8+ze/CY6qUnh2Yg7M3mOYkR/NV0lpoUp8c2opHNO9vv5VuJnVcBrIcHIV9bb/+rpthjr3vgNmYQlDk3xPwalyZ268o84c2Nd7LwNdmEs5hF3ONatUaCPPbwNAAgosnYnVSnSR9uT2UZH6qDaMC5bFU/GEqW2I0KbLMWE35py15Xo2UPvBxnuZwkZV7wh3SGgie3m4HOoYbtWpWhUbInfGqO+LE+OuASvN+ZE3k1KYdC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhjV8BGsEsiFQ3CYKLwpLOBLt1GNJrF1bb/U4I9Z2S4=;
 b=NVygl+3xj1EG8gsEKckwmafMKfOuo8wrx96insm0W5z/PQFUb94gnaKtShqbHJ+lcrS/YFndJFqmC3DveF0vkTUopSPR3LWI2w2xCFnpv4lltQcqm4H4VVslDudMbDv8QzpImhTDy2e3gdnQzqM+rX0J9IJcvEZw7V27qq9hzd2hk8QPZ3FgB+nCfh5TiRMJIVFCaCq7oeUYBnzZ75ytQvuCRHMYz8OEZtc2H1ABUcpy8d7N5LXMZ22w0aq5j4DEMrmwV7zG2i9YCyHLXHEkeJh1GghPOWx5EVuZpiPsVQIKuVFs4+tddJ3wvicrSnIP+IVqCkQwOQhk2wWwDI3rTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhjV8BGsEsiFQ3CYKLwpLOBLt1GNJrF1bb/U4I9Z2S4=;
 b=Gx9jfI63igOmdY7oGutKQ4OXGX2okPqaQRu93XN0Zq4Mkm9yiBbfhYhHOoDVkKLsRDAgklUOOORWbzaZ3egqFD1XC7joCgGGWKxx1+n1uUcbEjHuVckTiW1uIK3WQNaAWtApOLACweYN6VTQREyUkQdvoU1dgqLqSADThjofoKw=
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by BN7PR12MB2628.namprd12.prod.outlook.com (2603:10b6:408:30::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:29:39 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::b7) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 26 Apr 2022 18:29:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:29:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: update query ref clk from bios
Date: Tue, 26 Apr 2022 14:29:20 -0400
Message-ID: <20220426182920.3007060-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182920.3007060-1-alexander.deucher@amd.com>
References: <20220426182920.3007060-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8330b1c9-8927-4c16-a537-08da27b2b8ff
X-MS-TrafficTypeDiagnostic: BN7PR12MB2628:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB26283A563B8E36F94254AA16F7FB9@BN7PR12MB2628.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTgPYKgsVgCAOS0nGnd0cJmTYE2guuLgbCTPueN4lAAk1pbPifOaEOIDV6r2jRIItWx4o7+xY+zLfKn+dh90wVaDPdbORFumAgMJlq8UESTRtd6mwIFdKspoEd2s2Zgk0JAZIKYEF1bfJu8sD0TJG5YlBZyKKV6wRNgyIWqZmlBHhuVsJyY3onBPuZfDc1n2l28Mk5/c9I/vXXlNCNc3UAU4D87c0tIug8SYNTTJBk9pIY8ziOWC5cH/c6D8v7rCVVmUQ4IGCFyPqDceNQio0xDSdZUeOcWL1/irXwmUifVr26QKrrb/3DtXcoj6KLSm1lg6HKcK0xVa1Gv9NViUcehG490pSrIHXe9A1dPBJIum/RCL7azUySyRvsOeHEnnzOb5Lc0AyaChIZp9HX+04wSA1i1BoJrVLhAis+oGmFQACHgM0S/B4k8OIRShMUya5PMvrx/K1urEz1Hmg48RJtwOwbSPYNBeBq1b+Ceg2a5Fbwfm97EgHsXjaFkVLhvThWohzvtaVLhNO1gCrWb//17zRyRNWZJEQvGKQRKHB75wCARQ8E5Ra5zGNam2R2KN8lDgT87mh2vcAio05x2ySwPpuN7gf30Q5vAyPdsB3NkVOnoRXdKnLUxB3bGzIE+62+LjSZwXFNkCzSMVebn5DdlphNfZw7U06RQm9atDmMtMy9xytz1jlD8TOzMKQjk3+jJY/jTb9oYscp3gur0E/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(8676002)(70586007)(70206006)(4326008)(2616005)(7696005)(26005)(6916009)(6666004)(316002)(82310400005)(40460700003)(36860700001)(86362001)(508600001)(36756003)(426003)(47076005)(336012)(81166007)(356005)(16526019)(186003)(1076003)(83380400001)(2906002)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:29:38.5270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330b1c9-8927-4c16-a537-08da27b2b8ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2628
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Handle atom_gfx_info_v3_0 structure.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 0900912be72d..494ca6a0f47a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -558,6 +558,13 @@ union smu_info {
 	struct atom_smu_info_v3_1 v31;
 };
 
+union gfx_info {
+	struct atom_gfx_info_v2_2 v22;
+	struct atom_gfx_info_v2_4 v24;
+	struct atom_gfx_info_v2_7 v27;
+	struct atom_gfx_info_v3_0 v30;
+};
+
 int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 {
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
@@ -639,23 +646,26 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 						   gfx_info);
 		if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, NULL,
 					  &frev, &crev, &data_offset)) {
-			struct atom_gfx_info_v2_2 *gfx_info = (struct atom_gfx_info_v2_2*)
+			union gfx_info *gfx_info = (union gfx_info *)
 				(mode_info->atom_context->bios + data_offset);
-			if ((frev == 2) && (crev >= 2))
-				spll->reference_freq = le32_to_cpu(gfx_info->rlc_gpu_timer_refclk);
-			ret = 0;
+			if ((frev == 3) ||
+			    (frev == 2 && crev == 6)) {
+				spll->reference_freq = le32_to_cpu(gfx_info->v30.golden_tsc_count_lower_refclk);
+				ret = 0;
+			} else if ((frev == 2) &&
+				   (crev >= 2) &&
+				   (crev != 6)) {
+				spll->reference_freq = le32_to_cpu(gfx_info->v22.rlc_gpu_timer_refclk);
+				ret = 0;
+			} else {
+				BUG();
+			}
 		}
 	}
 
 	return ret;
 }
 
-union gfx_info {
-	struct atom_gfx_info_v2_4 v24;
-	struct atom_gfx_info_v2_7 v27;
-	struct atom_gfx_info_v3_0 v30;
-};
-
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev)
 {
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
-- 
2.35.1

