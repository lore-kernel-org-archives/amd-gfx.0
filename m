Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E731CC3DA66
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 06:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 657AF10E10A;
	Fri, 25 Aug 2023 06:44:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C093410E10A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 06:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QovnfcqXq41XxOBJMcqjsxacOv1eRUm3e5tsRiNnWd5NUxxMLYEm0TWuBTkV5IKriSn+vVtzpSWT5i4lVEV/ehhwkECzPbS8jEbg/K5hEw6Bqc0Q3O4RMXVLqnDx3/qHGj1HcDPpOb1eDvY1nPXIKG9lJjWM5qylQwJ2DxxcVuiaxn6xR2kPTBwhw3GfSbcYgyImSRm/CXs2Ddb4IyFC3KKCVSx8BexQEaSl2JuqBHFZKLy5WeV/Ch0Zw6qiCPJfAtea8ohYbvWl+VpAjEDPgzTUOaCs/fGX/bNaTbolOxdZ+FDUxex6YbVYEOw8FYVUik7VtjmTrIVuTUsr6568Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbxQFRh8ARRugaSVHbR6GkIrpEYwLLE1/XS6Rdab1SE=;
 b=A4eZ+6HKnIuCJZ1Cv/W/inqlHSWQtK2HF5K9bRVQo9vBbm/D2ZM8oxeHeaZA7MKPL7NiLsynuZmvj8F1lIo2F16WLbvlp1CptGtIlBhRxBbBZC2AzUoxroDHr2mjoLOEYR8/kd+wi95wbt8HpdqulAgwJb/RTNd/K4rb7KVBXu7IgLtD3qDWjWjBjVxqS0mABzKk1DAj1h/YRJf4TkSELdiIXLFsY302mmex2DBRKKOFGFm8es011otlxcgpFPD1/I+4r0/Tml9QFZOKir8dXC4njOFhX219ilLzaQqML+myNy3lNWwbbSAGhQwNF0XSbfMhFBRFuJdj6INTkD2T4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbxQFRh8ARRugaSVHbR6GkIrpEYwLLE1/XS6Rdab1SE=;
 b=FWNL/UJn5PnLab4rQrFr0P+kkNuJe6vulvI55DW+K0gQuvfqGUegnY4/hVc8khwmV99xqBW2VA1e4OhkJcaubesXicQ2soX46KAwr/c6fTUDODBKzal8VWADI/DvRUX3Nbx28yGBwmmazwjll7HVTXhhMxBX6i+LaJuK+DlW6G4=
Received: from DM6PR17CA0016.namprd17.prod.outlook.com (2603:10b6:5:1b3::29)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 06:44:16 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::4e) by DM6PR17CA0016.outlook.office365.com
 (2603:10b6:5:1b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 06:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 06:44:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 01:44:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 01:44:03 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 01:44:02
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Support query ecc cap for aqua_vanjaram
Date: Fri, 25 Aug 2023 14:43:53 +0800
Message-ID: <20230825064353.23079-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825064353.23079-1-Hawking.Zhang@amd.com>
References: <20230825064353.23079-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 540cf686-7ec9-4052-fdc3-08dba536b34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUFsMP9yHY1vw7fOMznVm/l7AO1C0RsRl56ewgalLUmxGTCGHIaCTc3naF/9T/MTimfJn3mej/FM/OZHs6TcZzoG0+x7wtM6sJKlrmSufDHO6hAm/8JWhQ5cI9r6kpvwqgf+ZKBLseL166lfxJJw36oT5XvTXV7f3KlZcvMEbh2/j0REh5U5QY4XqiBvOVbAZ8XteEvOtGDFNDNmjIqTz5DOCqigS3B0q2nRtRJEq9kiI5OWDh08snfwaZvihXbRXQmT8PimlCGklV4nVvogZoHNNsrirONKhoO7WqFSPQgDXvQ+CnadBDNqsmnwIILYlLQZNHadzvtU849SrQn0tQZn1Oe4yCoyjkxDdpJJRlsaxU/1aBQNuix/5J1GJX5Hcf0+aYJRWE9m4GDfFyjWnli5wVKwYW+bX8YO4b/wce/OimBXecghUh3cn0aGK3YicW5pqSGl78qXz7RAjyI6yVllPaMO69FKdG/ljGhggd1T+EvHWtT9Moo70ZFKsZ3RDW3yzBPO4GDaFqkunbNFgust++EY/W1N/SmdLGHK0kijMzUpf2pGLsxd6ixfvbV97NALRoBMz1JDwXJvnSI9cUEEc/eLcBMC7qrGG39qFo97am5nHL8vyd4ja+96csCIHu1Z/QeWqaBJJS7Z+sK37LXy/rkqaWVQa8cih+JBfuyxSxVHR4lSI9vSFBHgbNLI3mqw2t2p2iHOOI2SWMYQS0H6K7W7cB5fzfOiYg4gD756cnDQurllZ2TD5nWffSR4iBBdsBgCaVRy05F1yr8FWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(426003)(47076005)(36756003)(83380400001)(7696005)(36860700001)(26005)(40480700001)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(6636002)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:44:15.7547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540cf686-7ec9-4052-fdc3-08dba536b34e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver queries umc_info v4_0 to identify ecc cap
for aqua_vanjaram

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Candice Li <candice.li@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 835980e94b9e..fb2681dd6b33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -217,6 +217,7 @@ union umc_info {
 	struct atom_umc_info_v3_1 v31;
 	struct atom_umc_info_v3_2 v32;
 	struct atom_umc_info_v3_3 v33;
+	struct atom_umc_info_v4_0 v40;
 };
 
 union vram_info {
@@ -508,9 +509,8 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 
 	if (amdgpu_atom_parse_data_header(mode_info->atom_context,
 				index, &size, &frev, &crev, &data_offset)) {
+		umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
 		if (frev == 3) {
-			umc_info = (union umc_info *)
-				(mode_info->atom_context->bios + data_offset);
 			switch (crev) {
 			case 1:
 				umc_config = le32_to_cpu(umc_info->v31.umc_config);
@@ -533,6 +533,20 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)
 				/* unsupported crev */
 				return false;
 			}
+		} else if (frev == 4) {
+			switch (crev) {
+			case 0:
+				umc_config1 = le32_to_cpu(umc_info->v40.umc_config1);
+				ecc_default_enabled =
+					(umc_config1 & UMC_CONFIG1__ENABLE_ECC_CAPABLE) ? true : false;
+				break;
+			default:
+				/* unsupported crev */
+				return false;
+			}
+		} else {
+			/* unsupported frev */
+			return false;
 		}
 	}
 
-- 
2.17.1

