Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74571C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7124910E445;
	Fri, 21 Jan 2022 20:22:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE7710E2FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE3BJSPyk3ST6Jt6wj+4HSq11J+tF/EdO/Khq5mTp74cP3c6iYFIt+meibysqWsTJ4RJwQC0WrmSYLN3gg/hTlng9O+XVYzCxnCRs8tbMDKDDL2TjNSIpmNPMrz8u5eWuA0ffTPfz9T0VoGk0jET0x0qbnaXz7mz/9IbKGNTU2noCHIUXoAUMeCstUYmJJT2rgrxB27d4bz/oeEqUJCpC/GSKJyi2xjZDIoJZhGaYurC9EO7K2BDxPx4Q8zLYzlXrrlCngREx5+0AHETwNqx1klUXrdnP4cohB+mwnESPhN0BRIMFbnbyYbveM/b9CJSmeGPGhEFTeYrBCOWBnmYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkG7fX8Yj8OOgwhb3C+COxCRqQ0SxUCKb3n2ukr5YOk=;
 b=AzpLD1Sr6V3w1VVOEVC2YKj2YbqoMsn2eCPgU6d35kprGI0tBASapx4L9s7A4Eeo12o2k+X6biV7S1qkinQRYt/s+p5bOCVou4N8YI8Uiuq5MVyXlSrgKH1r0dkME2tTTU06fP4dSJKAj1zBOfCYUAPezgdZ5sppJ7EA7qBI2aMGkPUglJzVOtrseJa05Th+q/uTbsyx8mv93InyWXlUT3MMfyDUu5GhtG+y+7eV5u4dz4mYaZvb8/ZnYOZm0kYMCRY5FiPIPZkf4gehmT/LTHP+/Os3MB+V+Qj8OVuoJDw5hd7DoF9ZRU9BH0nWNb9K9yj27mbgt14HdOBhfTj8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkG7fX8Yj8OOgwhb3C+COxCRqQ0SxUCKb3n2ukr5YOk=;
 b=HE+UDMbJ0XOJ7doelebTkzb58aQavFdkvo91F+MVJgkIxg3Ykhyfrv/Hy9l2raPS6awvOVTOxTjPI5r6GDTIkeQVNYA+lbLnIdQocl2R0FPH5wFxYt9H6cEOTMFxCgzdvpLDMM4FdmANHtUOfnPqTFPve8s22ILFyXaVg+8LEA8=
Received: from BN9PR03CA0563.namprd03.prod.outlook.com (2603:10b6:408:138::28)
 by BN8PR12MB2865.namprd12.prod.outlook.com (2603:10b6:408:96::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 20:22:38 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::a4) by BN9PR03CA0563.outlook.office365.com
 (2603:10b6:408:138::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Fri, 21 Jan 2022 20:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 20:22:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 14:22:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: convert amdgpu_display_supported_domains() to
 IP versions
Date: Fri, 21 Jan 2022 15:22:20 -0500
Message-ID: <20220121202220.5557-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121202220.5557-1-alexander.deucher@amd.com>
References: <20220121202220.5557-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cbddc13-c5b7-4ee3-a200-08d9dd1bc4e3
X-MS-TrafficTypeDiagnostic: BN8PR12MB2865:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB28656A7580A964A6CC1F0AFEF75B9@BN8PR12MB2865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2E/s5OjIr+yFFRv7LW8fllBJOkdmjMMg4VNAaX8cpNLFB0J1JMq8AtB8VrLb15A0e02aP1bf4KJZruf5+dxeAkRmkPAh4m/c0zfCWZqZOi0Rf4+FVywcUFp+RralTW0Kp138EGj60KiBFylD9TVIWt4uoDuZrl9BJNmRIrcoVJhvqnybLbxuNjkaBN/x5XPysEix5EvmUGdIEd8qol58nOprYr9a63D88WjuE73V4n6YWeZot2j1tcAt2V3ExA5BIPnh5u0YrhwhgjeFHnVLv16UNmWZE1kLfcPRZLXyjSde4PBb3cPY6NW2hdDTx6b4Dv/aRUwDou4iCHgxEwMnBq9YoaHlXCkJPyIPfDnpdcs+TqioBR+mpJpU+r1DUFCEMeJagK4HioeohCBUEsqZV+fxHmDfliMiO/hCbW1ApnByKycS8WdutoYfHwQv0pEzPzFdXKyHZAXmGCtTTn9bs5DOUkGVmVQI7dn7YQyc5Nnui6xdq/TFru7LwEPximZ5MOEW5VlSuUsseYzwl4MqLIOkdIaewcxwshvgLupVvRxHrzvYvta1fr+iQMPmJS+XDWYnNJOwEJJsUVqkOfZDUEf2wdHWnjC19zlrFq+FqEJErPG8BJQZgCbmVukanoqGx1GVngo+z0VCo/ji+XSYduqdoTTEj4KklaKJ5A4KYmNqd+Im7kqgfCvffzvWnyIGrtVK+3KaSifMY/x6W6lfSuEOZWroF5VxZeaiUU+TIygslIk2WWNxovOf8Ka7+p3GpYcGq9hItoTblsGImm5lEhJt94pOhA/RmQHicMxbD1E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(1076003)(83380400001)(47076005)(36756003)(6916009)(86362001)(81166007)(26005)(36860700001)(40460700001)(7696005)(186003)(16526019)(336012)(70586007)(82310400004)(70206006)(508600001)(6666004)(426003)(8676002)(2906002)(8936002)(4326008)(316002)(2616005)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:22:38.6431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbddc13-c5b7-4ee3-a200-08d9dd1bc4e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2865
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check IP versions rather than asic types.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 29 ++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 82011e75ed85..6cad39c31c58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -510,19 +510,24 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 		case CHIP_STONEY:
 			domain |= AMDGPU_GEM_DOMAIN_GTT;
 			break;
-		case CHIP_RAVEN:
-			/* enable S/G on PCO and RV2 */
-			if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
-			    (adev->apu_flags & AMD_APU_IS_PICASSO))
-				domain |= AMDGPU_GEM_DOMAIN_GTT;
-			break;
-		case CHIP_RENOIR:
-		case CHIP_VANGOGH:
-		case CHIP_YELLOW_CARP:
-			domain |= AMDGPU_GEM_DOMAIN_GTT;
-			break;
-
 		default:
+			switch (adev->ip_versions[DCE_HWIP][0]) {
+			case IP_VERSION(1, 0, 0):
+			case IP_VERSION(1, 0, 1):
+				/* enable S/G on PCO and RV2 */
+				if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
+				    (adev->apu_flags & AMD_APU_IS_PICASSO))
+					domain |= AMDGPU_GEM_DOMAIN_GTT;
+				break;
+			case IP_VERSION(2, 1, 0):
+			case IP_VERSION(3, 0, 1):
+			case IP_VERSION(3, 1, 2):
+			case IP_VERSION(3, 1, 3):
+				domain |= AMDGPU_GEM_DOMAIN_GTT;
+				break;
+			default:
+				break;
+			}
 			break;
 		}
 	}
-- 
2.34.1

