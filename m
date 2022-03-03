Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B11C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 02:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5065710EC55;
	Thu,  3 Mar 2022 02:55:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647A110EC55
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 02:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPI2GBy1t6yPxvVeSjqEafUEsCUSsFF+YL6CJhfDAybR1Y0kFA+DAv5AGnPGo9rlIc0IhVDqvy9RcxHFfdY51JfrtXHpvdIzgk++fou82rGinH2+hV4kmd9IQ2a0gSSlWv0tFn+je8rSP2eJW5DL38NtZ9/fRHvet+Ro5NU7Q72qoLv3my+rvDAP5b5RUIGM+3ksqcRO2CsJowvD9MuMxVTzbpcS3W6YeS/kHbEd6bBfULYC3rl8vBScLGzEKPI30yqxNXBPA/eDfPO2kGASVmQt0aAwhf/Vm/oAAzFWpsTZCSOKgicRHhvwRDJRo6JlYt1UmPWddR89flLfQIBQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc1tXypo7gy7jb4IztPHPpNyjAgi40VmOJ3h33fU+/k=;
 b=bMMa/ESlNNcUsdpWNf+wH20gGWhRVfMskLCp/+w4/tLDG8TkctuLz1u6U/GZtwC9Xf7QTYEF+McN2OIgImF8MEbwUsjKokRIms4rhkMJMhVmMG4aaCMJoYeWAMaVr4HsSrcKOqs17sSgaSQzRkl6RI6RSX51ltbPg1D8DkHvO6HT4ZecTCFdcI4q6Qd/ghazYPIy+IT5kBHe5M/nbW/XPE9bqNxk171VkRUnbYwWephYewoYiAg5qKgxICTBOB28Yc3Pu+8YjRUSbVVe4UadlTFscHh7CWeZvF1Ut4ZDVMTBpqf1jocpj2bklyY38Tq+JPeKakcqsfi+WDeJBZz99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc1tXypo7gy7jb4IztPHPpNyjAgi40VmOJ3h33fU+/k=;
 b=EZl10hdZL0cR3f/PuTgbeoFtNp7sdRLJyjwiInfHpEKKfkbEJLIcYxeCo56BPTgPFl2HXe3uCCMdNemT0biCFRHqp9ziDgmtv2kugqzVly3SNptXhaAmMGxhufSF9IGHKnnre74u/OMTLVZswrZoFnkb/JhXuie5R8Urg9tUuuk=
Received: from BN0PR04CA0090.namprd04.prod.outlook.com (2603:10b6:408:ea::35)
 by BYAPR12MB3031.namprd12.prod.outlook.com (2603:10b6:a03:d8::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Thu, 3 Mar
 2022 02:55:19 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::41) by BN0PR04CA0090.outlook.office365.com
 (2603:10b6:408:ea::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 02:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 02:55:19 +0000
Received: from MSDN-LAPTOPDYU.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 2 Mar 2022 20:55:18 -0600
From: David Yu <David.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add DFC CAP support for mi200
Date: Wed, 2 Mar 2022 21:55:11 -0500
Message-ID: <20220303025511.27319-1-David.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fbe50f5-a936-4b8d-3bd9-08d9fcc140bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB3031:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30310F0E8C147C4B84E8E3FA81049@BYAPR12MB3031.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jjkxWDMe4jBH+n0Yf8BlxdptFksrF+e7NyJDwz7h0NaaRIVsvUfCB4dh83rsCFTNuO6kXCNn5BbmV59odxnftvHnbiTS8lEwZSP1iHcr3PUKKG8pfLn2y4CZv+k9p7Ln+6mJh5L9/sTbFF1aV48VSDyybPeWPsfeiU2XTz5psXj2F5wnqo0u1qse6e7XOyhfwNtyBUFbrlQnMrxU0wRF9komuYTDZpp0r6zFvNe/gNDXthJSaV6aFbsq/roMJBeD3Xi+Qwgwh94Ww3Veb7SRJQodJmNeyL8sF9y/WOKavE6nKMGhloOxgXrxCU+V6UvHRKmDzksuMGsTu6PjnLZpKlLuSEeGeb5APuejRrxr/QgU6qy1OGg3+rxsahuKcefVz8HG5sGV8u9t83O/g//98X3C4FMc0NyWaK/Qyc4IT+RcxFCBLbVNE/7AKZEJD0Adrp8CXBTYk1zRPa9WM9DGsFHZKjZwoVzQI79mFfi8cDLtPgRYXRuykGeHGTFUfSkejpPwAjdBI6VW9MjGOOD6MiImRqJkx2a7Mvs2oS+wtRYKTqjAeMaXr66ySNQ75AxmwQtCWkN1J7pVEi9QX5DA/CgbF/H3x6EM9fFbejp0VSeZIRyZRRcU99PbVvBnSs8H4daZH9s/fNYTFlmtPIxJIo3XAvWdg0vrRLIpRLp7MGBBsUzVH+uOcufbOOMGQz8/VlC+oml4kUL+ILKtAZVdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(5660300002)(2616005)(336012)(426003)(1076003)(316002)(8936002)(82310400004)(70586007)(70206006)(8676002)(2906002)(16526019)(26005)(186003)(36756003)(4326008)(81166007)(356005)(6666004)(508600001)(83380400001)(6916009)(36860700001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 02:55:19.3885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbe50f5-a936-4b8d-3bd9-08d9fcc140bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3031
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
Cc: David Yu <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add DFC CAP support for mi200

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 94bfe502b55e..3ce1d38a7822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -277,7 +277,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		ret = psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret = psp_init_ta_microcode(psp, "aldebaran");
+		ret = psp_init_cap_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 2c6070b90dcf..024f60631faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -31,6 +31,7 @@
 
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
-- 
2.25.1

