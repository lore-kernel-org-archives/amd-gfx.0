Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B397C19F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 07:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAAA418A734;
	Thu, 28 Jul 2022 07:05:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9E618A9B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 07:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGbfM025ez+YUrnYWXgXem1xKPLxHHirLVHrJNtIH6Va04qsz56k8p0xdk/Cl9+QY/nHOrqH4CxeFWvwy9PqW3zJiZIyMGjp8nAJqpv+J9uXFDnUZFlo8x6zNOXIAtlsKv9e7fgqO+TMr5Lcz2Z4z+qUHm25B7wz+qLkznb6Os0Hc3MmbfQLd0DTh3mWVEjvc+z0R1cL4U+cPG7NJOfedfACWmTGUkHZlee7oFwL9Mh1DGm+h+v34eW9FLD7M9Xeu1dfs5jappl+RAR+L8rqbgudRaOlD0m2jHLBlnYXY5YUc5YyWLW0oVkSEqDnnoPDBwPcyiwzuEBQB8JpiEg/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AojLCUDrXHT2iI8J5Hw1C/YO8FnPRaC0R2gS6dtL7ss=;
 b=C+IEehUMAiHMUNEnab5XdxhZw1oB+Xf5w26G8/BZ6h8REqAsZ8UzPACYEmfiLXqyBXxQ3uod4E97G/UsXl5dhaqx29FWmCJAeCtl/jn+l7S1gZb5MXb0PfDHajamluIFAgG7auAUDnl9Af0IFnz6udpq7prPfB0ODHpaco4PfhrwA88FGJpB1JAS8sJUL95LwNCpz7F3GD+6if14e2l7FpQF8aBU39TJvVdAQRWh8PBkmhaACxmKjFX/P/mneT1uAMXNfh9uDxweXracXz+EYUu5+aS1yPJbEqM8X+7iagOd75daS4NcZ5wU3QkUxg1HaHWk9ca13cfU+Smy7Ds9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AojLCUDrXHT2iI8J5Hw1C/YO8FnPRaC0R2gS6dtL7ss=;
 b=2+du530Cy9BHbySP1yyoU9gwpV7fLEGdi+NlnZ8Qmje7MEtNRZrTUiLExwU/2oxjUD/uTkjJR48tjm495vw9BCQH/Q+MYGjcEXDby9JvYQVcHhAlOUQs20HgnGzz/qlS8bRBAHHFMbefFb4I6mCIy2d05hLmQOriRKBUep3yES0=
Received: from BN1PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:e0::20)
 by CY4PR12MB1239.namprd12.prod.outlook.com (2603:10b6:903:3d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 07:05:22 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::ec) by BN1PR10CA0015.outlook.office365.com
 (2603:10b6:408:e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Thu, 28 Jul 2022 07:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 07:05:22 +0000
Received: from jenkins-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 02:05:19 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: enable support for psp 13.0.4 block
Date: Thu, 28 Jul 2022 15:04:19 +0800
Message-ID: <20220728070419.2485384-5-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
References: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16393283-bc53-469c-2264-08da706789cd
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7iH9VV5DSQfIa/SeHIdbrb7leMH0rY6/r5vHvH6T2qpi3bGraKrdhIZPBy7DiW3NLPPq8OVUOSNZzWeZdnbbJ9IVXvCAcjHRUX4ac1kF5Kv0Jh9rxBcREehrKNOHqhRciJOaIND5jea1h1OGYkJ35N+uWQPtkA3T/YJESOaonUxtfH420a3zD7NCEGMWKrX0nZiiNWGnMH0V+cjbJZ8OmDpFH5C3xLHMoTMTWA5RHPmf9UwRKql75LHN2ZKN5cLeDLk/pK/a7GUWjsVyhH2WFHAGYO5Jal6E1OMmqyBHSxHZ7VY7ZDT72qBkbroSRaKPh73Q3zq1/DX7MLZHm0gTuk5SN7khcF7eXlrkJEiUtTM5QW0pTh0WToz1+SkYGKUrNVfl97dLqqNXDPAsYHZ0XkrT4jaDxstQCDSYberTiZtw3yonpO7XLBcz/I/V6GuYrug5ZnzGobU9gReTbthS2k2O3OrADkXaZUemh7TrhzxB3ojdtig91dqZzukHKVkvPaO0JGT5T1mdsFKPSU6KlFnE/2GFSgJWmqGaKScZmfFh7plbf4JYhLd8OaLk5MYy+vnoi7F/9kYcAjdH9RHNOWLcWs1T50BWtvMs4/2PpEUlHc6+L19ZVQXGgQ3fp4qRVpWnji86j3ruyVYGbXIUogSQ6juNYbkx9Me8mviGizteEyMOrhWT94u2XCdp7T7+UIam1pzpIzA1XuvFPwHWH/mIDv7m/uTKPutDJ+cwi0vgjpgC0jqZzKppPogF9uFntSfRgCsXwa8wpduN3TF50rijx/x8fnXOkMKHsT/pkY95jzQ48Psk7ubuQPBSvI5faXGb9uQNV8S6ue/BgRo54w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(40470700004)(8676002)(6916009)(70206006)(40460700003)(1076003)(82310400005)(70586007)(478600001)(4326008)(2906002)(2616005)(316002)(7696005)(63370400001)(54906003)(81166007)(26005)(36860700001)(40480700001)(82740400003)(356005)(63350400001)(8936002)(83380400001)(5660300002)(16526019)(36756003)(186003)(41300700001)(47076005)(86362001)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:05:22.1586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16393283-bc53-469c-2264-08da706789cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
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
Cc: Alexander.Deucher@amd.com, tim.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch will enable support for psp 13.0.4 blcok.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c7d0cd15b5ef..5a283d12f8e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -115,7 +115,8 @@ amdgpu-y += \
 	psp_v11_0.o \
 	psp_v11_0_8.o \
 	psp_v12_0.o \
-	psp_v13_0.o
+	psp_v13_0.o \
+	psp_v13_0_4.o
 
 # add DCE block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 242d1847c4aa..95d34590cad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1630,12 +1630,14 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
-	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
+	case IP_VERSION(13, 0, 4):
+		amdgpu_device_ip_block_add(adev, &psp_v13_0_4_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add psp ip block(MP0_HWIP:0x%x)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3ee363bfbac2..bf41374e3ea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -37,6 +37,7 @@
 #include "psp_v11_0_8.h"
 #include "psp_v12_0.h"
 #include "psp_v13_0.h"
+#include "psp_v13_0_4.h"
 
 #include "amdgpu_ras.h"
 #include "amdgpu_securedisplay.h"
@@ -151,6 +152,10 @@ static int psp_early_init(void *handle)
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		break;
+	case IP_VERSION(13, 0, 4):
+		psp_v13_0_4_set_psp_funcs(psp);
+		psp->autoload_supported = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -3692,3 +3697,11 @@ const struct amdgpu_ip_block_version psp_v13_0_ip_block = {
 	.rev = 0,
 	.funcs = &psp_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version psp_v13_0_4_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_PSP,
+	.major = 13,
+	.minor = 0,
+	.rev = 4,
+	.funcs = &psp_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 180634616b0f..c32b74bd970f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -439,6 +439,7 @@ extern const struct amdgpu_ip_block_version psp_v11_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v11_0_8_ip_block;
 extern const struct amdgpu_ip_block_version psp_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
+extern const struct amdgpu_ip_block_version psp_v13_0_4_ip_block;
 
 extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 			uint32_t field_val, uint32_t mask, bool check_changed);
-- 
2.25.1

