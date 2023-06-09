Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AA2C7EE2F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 15:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9E210E6C3;
	Fri,  9 Jun 2023 15:11:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF3110E6C2
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 15:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpihLmUOjmQMVOgZBgZVThb2YfUi49HPLIwdOR1mw73fBd5quKLlpABhXE8i8owQDitsfmcy8lqMwfI25hmq2tVdemw9A1R7DE+QYyuc4DfsAnUV5x7T4fGPwAehewpNhjiJHvKQZTJ36GaY6SgpWedIHOTDDZEuzwp2EVu1Nbk072rRFG9AGx8lnE/RpPxTmdxpdclOn6z2ajqg7nHtDgdMxNrKkvf7yRPDFcipZ4bFF6Q4/YXwaj7TdeFzLypoO14RuWoXkmP18g+Z9dVTqxj96JQ880dCtuKlJBsl60/6J2Xax4A9NNqf0UrosdfnxxWKGmNN1L2vNJyv99kZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzZAiG1CEQLfYOcU1eBUnxxJGF+aMTlqlBY4qCT02X4=;
 b=SeFFKWtFhlkMTfnenoobj2tppAUrHOXkDMYKj9CYO1j6CRsiLRBj1Q/9M3qISvMi5weTaD3U9tiYF+6UHfHLeE2aJjG+QcB/GeFzkpKMkF1oFkVhL2eqqcO1nZektZNuY7b+zv/ZFl1pXCd9Xh2yhCpTCVzaFihH4V5aRKPgskJiDI2iRSrCNfXnblDMDzL08ndL1SXRKzKg3Mo/cPsCzk1NQrqhG2k5XspZNs6y9ps6UDUHaAhYvW8eyNXE8hKCL1BD+4OQPCZMQCQGkT3H222qI4vJfBwSwESmJlfP/IICx9vqElyqZWnCkmqeekpZ9QpBQkxXUYSOWp7pQNY4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzZAiG1CEQLfYOcU1eBUnxxJGF+aMTlqlBY4qCT02X4=;
 b=ZxAU3RrJXb8SZiblhEpPqAOY1elDk4SL+0J3TNeTAKN8Rsvmv0El8+3Zf2Zzpfjhvg8Sa0uI6KIl+FZxWJo1o/mS3Qfk2QEz9WAiuFIMn8BwD+Ti0lW7k8ZF6Rbqhi8OfT/0wCEHHsuTOYsazyYDkQxNeaYVh8JrctAfujyWvTs=
Received: from BYAPR07CA0106.namprd07.prod.outlook.com (2603:10b6:a03:12b::47)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 15:11:42 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::b) by BYAPR07CA0106.outlook.office365.com
 (2603:10b6:a03:12b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 15:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.22 via Frontend Transport; Fri, 9 Jun 2023 15:11:42 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 10:11:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix kdoc warning
Date: Fri, 9 Jun 2023 20:41:23 +0530
Message-ID: <20230609151123.1006374-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BN9PR12MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 76004986-427a-4d0a-ec64-08db68fbd4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ubz80ouDylp555S0ce1d13utFhHQJEMXDazNTMONAd/E7ohUbGSF43v4Fnbqo4IDJABIPLtU03rEnegdz2tY2WEFN/EOeFruUmG9o3cMUmT8y1yqhsOKo0TLSfKO4iASrYmDJquP916Qy8Egwf4fh9QNvPMb67GSyyhVmanHVyo1r0c2UJYiYThw5Z9Lyuin/QxwUTiae8HqBO6dXdssWWxDuPLXILS8OmOZy1At0APtzfgDC/GfHO3HWwQ/8bw1jsjcA0SvXyr7anQi3KUSvJXkQ74WQa5Mjr7p6VTtIz1NHGkmgcXK50R/psU2AP3LLm/Jc/VrKpwhScSBzT/gvf/abO+Q80WpSp04MRSagcxBkPmY1gaQONZ4A/6n9FaSuGV7zJH/Pe/UJJYgp4xwYGdgp0vzwLYju0VdKIvVdnINskA5FfOcNOsncWFv6X/5Shld6z3em/oI5iorr39Mr+1FYIZeYq40bT1StgMAMoT/HFbJ749FWwj0wPbQ+MvJ4iq8T/aXNCUfb0RZWioL5D4TzQKWrVt9EfyB9GrnI9+Z4tMIseEqk3CFMy2ClYu6nJ1sE+IOXcJgEB2oTTcMJPIpCsU1bVAkpMg/iJGW+xG7kyedrJGejXXAFAdxTy4lTR4dOkfLEVISi7/DHqmftcD1WKhkZS4qbFtTq+PNJMfaRvDiQHXgphK8vpN96Bx2z9Schr+B7hNHz3Tc5FleVqpRkyq2kQmb30Hv8H2UpaHXWJE8w9vptpQV0ILG3mpanG+tvaFs6QDGFqh7ZVVPlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(478600001)(47076005)(6666004)(66574015)(186003)(16526019)(83380400001)(8676002)(8936002)(316002)(356005)(1076003)(36860700001)(26005)(82740400003)(4326008)(81166007)(70586007)(70206006)(6636002)(82310400005)(2906002)(336012)(40460700003)(5660300002)(426003)(36756003)(110136005)(54906003)(86362001)(40480700001)(7696005)(44832011)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 15:11:42.0395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76004986-427a-4d0a-ec64-08db68fbd4f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:76: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * EEPROM Table structure v1
drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:98: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * EEPROM Table structrue v2.1

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c2e8f6491ac6..0648dfe559af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -72,7 +72,7 @@
 /* Bad GPU tag ‘BADG’ */
 #define RAS_TABLE_HDR_BAD       0x42414447
 
-/**
+/*
  * EEPROM Table structure v1
  * ---------------------------------
  * |                               |
@@ -94,7 +94,7 @@
 #define RAS_MAX_RECORD_COUNT    ((RAS_TBL_SIZE_BYTES - RAS_TABLE_HEADER_SIZE) \
 				 / RAS_TABLE_RECORD_SIZE)
 
-/**
+/*
  * EEPROM Table structrue v2.1
  * ---------------------------------
  * |                               |
-- 
2.25.1

